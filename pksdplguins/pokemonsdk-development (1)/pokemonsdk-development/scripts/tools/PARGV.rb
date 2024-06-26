# Module responsive of loading arguments from ARGV with the correct values.
#
# How to access an argument :
#   PARGV[:arg_name]
# How to set the properties of an argument
#   PARGV.define_arg(:arg_name, multiple: true/false, flag: true/false, default: value, aliases: [:h])
# How to parse the ARGV again to PARGV
#   PARGV.parse
#
# @note : ScriptLoad will call PARGV.parse
module PARGV
  @args = {}
  @unamed = []
  LAUNCHED_BY_STUDIO = 'studio'
  GAME_OPTS = '.gameopts'

  module_function

  # Define an argument that can be set in ARGV
  # @param name [Symbol] name of the argument (to retreive it)
  # @param multiple [Boolean] if the argument is an Array and can be used multiple times
  # @param flag [Boolean] if the argument is not supposed to have a value (but set !default if present)
  # @param default [Object] value of the argument if absent
  # @param aliases [Array<Symbol>] list of aliases for the argument
  # @param adjust [Proc] value ajustment called when a value is set
  # @note If the name is 1 char, it'll require one dash, otherwise, two dashes
  def define_arg(name, multiple: false, flag: true, default: false, aliases: [], &adjust)
    default = [] if multiple && !default.is_a?(Array)
    @args[name] = {
      multiple: multiple,
      flag: flag,
      default: default,
      value: default,
      adjust: adjust,
      aliases: aliases
    }
    return nil
  end

  # Parse the arguments
  # @param argv [Array<String>] list of arguments
  def parse(argv = ARGV)
    argv = p_autoload_special_argv(argv) if argv == ARGV
    p_reset_values
    p_parse(argv)
  end

  # Retreive the value of an argument
  # @param name [Symbol] name of the argument
  # @return [Object]
  # @note Aliases are not supported as name!
  def [](name)
    @args[name]&.fetch(:value)
  end

  # Retreive all the unamed arguments
  def unamed
    @unamed.clone
  end

  # Tell if the game was launched from Pokemon studio
  # @return [Boolean]
  def game_launched_by_studio?
    @unamed.include?(LAUNCHED_BY_STUDIO)
  end

  # Retreive a default value
  # @param name [Symbol] name of the argument
  # @return [Object]
  # @note Aliases are not supported as name!
  def default(name)
    @args[name]&.fetch(:default)
  end

  # Update the game opts
  # @param opts [Array<String>] lines that should end up in the .gameopts file
  def update_game_opts(*opts)
    last_opts = File.exist?(GAME_OPTS) ? File.readlines(GAME_OPTS).map(&:chomp) : []

    opts.each do |opt|
      begin_part = "#{opt.split('=').first}="
      last_opts.delete_if { |last_opt| last_opt.start_with?(begin_part) }
    end

    new_opts = last_opts + opts
    File.write(GAME_OPTS, new_opts.join("\n"))
  end

  # Return the value of an argument

  class << self
    private

    # Reset the values to default
    def p_reset_values
      @args.each { |_name, arg| arg[:value] = arg[:default] }
      @unamed.clear
    end

    # Parse the arguments
    # @param argv [Array<String>] list of arguments
    def p_parse(argv)
      last = nil
      not_parsing = false
      bnd = binding
      argv.each do |arg|
        next @unamed << arg if not_parsing
        if arg.start_with?('--')
          p_parse_double_dash(arg, bnd)
        elsif arg.start_with?('-')
          p_parse_single_dash(arg, bnd)
        else
          p_parse_unamed(arg, last, bnd)
        end
      end
    end

    # Parse a double dash argument
    # @param arg [String] current argument value
    # @param bnd [Binding] binding containing last variable (to set if needed)
    def p_parse_double_dash(arg, bnd)
      name, value = arg.match(/--([^=]*)={0,1}(.*)/).captures
      # -- only => all the other arguments are unamed
      return bnd.local_variable_set(:not_parsing, true) if name.empty?
      p_process_value(name, value, bnd)
    end

    # Parse a single dash argument
    # @param arg [String] current argument value
    # @param bnd [Binding] binding containing last variable (to set if needed)
    def p_parse_single_dash(arg, bnd)
      return if arg.size == 1
      name, value = arg.match(/-(.)(.*)/).captures
      p_process_value(name, value, bnd)
    end

    # Parse an unamed argument
    # @param arg [String] current argument
    # @param last [Array, nil] if there was a previous argument without value
    # @param bnd [Binding] binding containing last variable
    def p_parse_unamed(arg, last, bnd)
      if last
        p_parse_value(*last, arg)
        bnd.local_variable_set(:last, nil)
      else
        @unamed << arg
      end
    end

    # Process the argument value (if found)
    # @param name [String] name of the argument
    # @param value [String] value of the argument
    # @param bnd [Binding] binding containing last variable (to set if needed)
    def p_process_value(name, value, bnd)
      arg_data = p_find_arg_data(name.to_sym)
      # No data => unamed
      return @unamed << value unless arg_data
      # Flag => true, ignoring any values
      if arg_data[:flag]
        p_parse_value(arg_data, name.to_sym, true)
      # No value => waiting for the next value (not flag)
      elsif value.empty?
        bnd.local_variable_set(:last, [arg_data, name.to_sym])
      else
        p_parse_value(arg_data, name.to_sym, value)
      end
    end

    # Find the arg data according to the name of the argument
    # @param name [Symbol] name of the arg
    # @return [Hash, nil]
    def p_find_arg_data(name)
      return @args[name] || @args.find { |_name, arg_data| arg_data[:aliases].include?(name) }&.last
    end

    # Parse and set the value of an argument
    # @param arg_data [Hash] data containing the adjust proc
    # @param name [Symbol] name of the argument passed by the user
    # @param value [String, Object]
    # @return [Object]
    def p_parse_value(arg_data, name, value)
      value = arg_data[:adjust]&.call(value, name) || value
      if arg_data[:multiple]
        arg_data[:value] << value
      else
        arg_data[:value] = value
      end
    end

    # Autoload the special argv from .gameopts
    # @param argv [Array<String>]
    # @return [Array<String>]
    def p_autoload_special_argv(argv)
      return argv unless File.exist?(GAME_OPTS)

      opts = File.readlines(GAME_OPTS).map(&:chomp).reverse
      return argv.dup.concat(opts).uniq { |v| v.split('=').first }
    end
  end
end

# Define global PARGV
PARGV.define_arg(:scale, flag: false, default: nil) { |value| value.to_f.between?(0.1, 12) ? value.to_f : 2 }
PARGV.define_arg(:smooth)
PARGV.define_arg(:"no-vsync", flag: true, default: nil)
PARGV.define_arg(:fullscreen)
PARGV.define_arg(:"ignore-gpu-issue", flag: true, default: nil)
PARGV.define_arg(:lang, flag: false, default: nil)
PARGV.define_arg(:help, aliases: [:h]) do
  print "\e[46m\e[30m"
  puts 'PSDK Help'.center(80, '=')
  print "\e[40m\e[36m"
  puts(
    '--scale=value : Define the screen scale (to make it bigger or smaller)',
    "  default value : #{PARGV.default(:help)}",
    '--smooth : Tell if the texture are smoothed by GPU',
    '--fullscreen : Tell if the game launch in fullscreen',
    '--no-vsync : Tell if the game should run without vsync',
    '--lang=value : Define the game language'
  )
  unless File.exist?('Data/Scripts.dat')
    puts(
      '--tags : Open the system tag editor',
      '--worldmap : Open the worldmap editor',
      '--util=scriptname : Load a plugin (scriptname in plugins)',
      '--mon : Monitor the user & psdk scripts to reload them on change'
    )
  end
  puts '--help : Show this'
  print "\e[37m"
  exit!
end
# Define PARGV from debug perspective
unless File.exist?('Data/Scripts.dat')
  PARGV.define_arg(:tags)
  PARGV.define_arg(:worldmap)
  PARGV.define_arg(:util, flag: false, multiple: true, aliases: [:u])
  PARGV.define_arg(:mon, flag: true, aliases: [:m])
end
