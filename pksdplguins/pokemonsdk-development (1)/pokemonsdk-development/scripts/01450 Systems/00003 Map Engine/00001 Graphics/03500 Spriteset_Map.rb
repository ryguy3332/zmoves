# Display everything that should be displayed during the Scene_Map
class Spriteset_Map
  include Hooks
  # Retrieve the Game Player sprite
  # @return [Sprite_Character]
  attr_reader :game_player_sprite

  # Initialize a new Spriteset_Map object
  # @param zone [Integer, nil] the id of the zone where the player is
  def initialize(zone = nil)
    @loaded_autotiles = []
    # Type of viewport the spriteset map uses
    viewport_type = :main
    exec_hooks(Spriteset_Map, :viewport_type, binding)
    init_viewports(viewport_type)
    Yuki::ElapsedTime.start(:spriteset_map)
    exec_hooks(Spriteset_Map, :initialize, binding)
    init_tilemap
    init_panorama_fog
    init_characters
    init_player
    init_weather_picture_timer
    finish_init(zone)
  rescue ForceReturn => e
    log_error("Hooks tried to return #{e.data} in Spriteset_Map#initialize")
  end

  # Method responsive of initializing the viewports
  # @param viewport_type [Symbol]
  def init_viewports(viewport_type)
    @viewport1 = Viewport.create(viewport_type, 0)
    @viewport1.extend(Viewport::WithToneAndColors)
    @viewport1.shader = Shader.create(:map_shader)
    @viewport2 = Viewport.create(viewport_type, 200)
    @viewport3 = Viewport.create(viewport_type, 5000)
    @viewport3.extend(Viewport::WithToneAndColors)
    @viewport3.shader = Shader.create(:map_shader)
  end

  # Take a snapshot of the spriteset
  # @return [Array<Texture>]
  def snap_to_bitmaps
    @viewport1.sort_z
    @viewport2.sort_z
    @viewport3.sort_z
    background = Texture.new(@viewport1.rect.width, @viewport2.rect.width)
    background_image = Image.new(background.width, background.height)
    background_image.fill_rect(0, 0, background.width, background.height, Color.new(0, 0, 0))
    background_image.copy_to_bitmap(background)
    background_image.dispose
    return [
      background,
      @viewport1.snap_to_bitmap,
      @viewport2.snap_to_bitmap,
      @viewport3.snap_to_bitmap
    ]
  end

  # Do the same as initialize but without viewport initialization (opti)
  # @param zone [Integer, nil] the id of the zone where the player is
  def reload(zone = nil)
    Yuki::ElapsedTime.start(:spriteset_map)
    exec_hooks(Spriteset_Map, :reload, binding)
    init_tilemap
    init_characters
    init_player
    finish_init(zone)
  rescue ForceReturn => e
    log_error("Hooks tried to return #{e.data} in Spriteset_Map#reload")
  end

  # Last step of the Spriteset initialization
  # @param zone [Integer, nil] the id of the zone where the player is
  def finish_init(zone)
    exec_hooks(Spriteset_Map, :finish_init, binding)
    Yuki::ElapsedTime.show(:spriteset_map, 'End of spriteset init took')
    update
    Graphics.sort_z
  rescue ForceReturn => e
    log_error("Hooks tried to return #{e.data} in Spriteset_Map#finish_init")
  end

  # Return the prefered tilemap class
  # @return [Class]
  def tilemap_class
    tilemap_class = Configs.display.tilemap_settings.tilemap_class
    return Object.const_get(tilemap_class) if Object.const_defined?(tilemap_class)
    return Yuki::Tilemap16px if tilemap_class.match?(/16|Yuri_Tilemap/)

    return Yuki::Tilemap
  end

  # Tilemap initialization
  def init_tilemap
    tilemap_class = self.tilemap_class
    if @tilemap.class != tilemap_class
      @tilemap&.dispose
      # @type [Yuki::Tilemap]
      @tilemap = tilemap_class.new(@viewport1)
    end
    Yuki::ElapsedTime.show(:spriteset_map, 'Creating tilemap object took')
    map_datas = Yuki::MapLinker.map_datas
    Yuki::MapLinker.spriteset = self
    Yuki::Tilemap::MapData::AnimatedTileCounter.synchronize_all
    last_loaded_autotiles = @loaded_autotiles
    @loaded_autotiles = []
    map_datas.each(&:load_tileset)
    Yuki::ElapsedTime.show(:spriteset_map, 'Loading tilesets took')
    @tilemap.map_datas = map_datas
    @tilemap.reset
    Yuki::ElapsedTime.show(:spriteset_map, 'Resetting the tilemap took')
    (last_loaded_autotiles - @loaded_autotiles).each(&:dispose)
  end

  # Attempt to load an autotile
  # @param filename [String] name of the autotile
  # @return [Texture] the bitmap of the autotile
  def load_autotile(filename)
    autotile = load_autotile_internal(filename)
    @loaded_autotiles << autotile unless @loaded_autotiles.include?(autotile)
    return autotile
  end

  # Attempt to load an autotile
  # @param filename [String] name of the autotile
  # @return [Texture] the bitmap of the autotile
  def load_autotile_internal(filename)
    return RPG::Cache.autotile(filename) if filename.start_with?('_')

    target_filename = filename + '_._tiled'
    if RPG::Cache.autotile_exist?(target_filename)
      filename = target_filename
    elsif !filename.empty? && RPG::Cache.autotile_exist?(filename)
      Converter.convert_autotile("graphics/autotiles/#{filename}.png")
      filename = target_filename
    end
    return RPG::Cache.autotile(filename)
  end

  # Panorama and fog initialization
  def init_panorama_fog
    @panorama = Plane.new(@viewport1)
    @panorama.z = -1000
    @fog = Plane.new(@viewport1)
    @fog.z = 3000
  end

  # PSDK related thing initialization
  def init_psdk_add
    exec_hooks(Spriteset_Map, :init_psdk_add, binding)
  rescue ForceReturn => e
    log_error("Hooks tried to return #{e.data} in Spriteset_Map#init_psdk_add")
  end
  Hooks.register(self, :initialize, 'PSDK Additional Spriteset Initialization') { init_psdk_add }
  Hooks.register(self, :reload, 'PSDK Additional Spriteset Initialization') { init_psdk_add }

  # Sprite_Character initialization
  def init_characters
    if (character_sprites = @character_sprites)
      return recycle_characters(character_sprites)
    end

    @character_sprites = character_sprites = []
    $game_map.events.each_value do |event|
      next unless event.can_be_shown?

      sprite = Sprite_Character.new(@viewport1, event)
      event.particle_push
      character_sprites.push(sprite)
    end
    Yuki::ElapsedTime.show(:spriteset_map, 'Slow character sprite creation took')
  end

  # Recycled Sprite_Character initialization
  # @param character_sprites [Array<Sprite_Character>] the actual stack of sprites
  def recycle_characters(character_sprites)
    # Recycle events
    i = -1
    $game_map.events.each_value do |event|
      next unless event.can_be_shown?

      character = character_sprites[i += 1]
      event.particle_push
      if character
        character.init(event)
      else
        character_sprites[i] = Sprite_Character.new(@viewport1, event)
      end
    end
    # Overflow dispose
    i += 1
    character_sprites.pop.dispose while i < character_sprites.size
    Yuki::ElapsedTime.show(:spriteset_map, 'Fast character sprite creation took')
  end

  # Player initialization
  def init_player
    exec_hooks(Spriteset_Map, :init_player_begin, binding)
    @character_sprites.push(@game_player_sprite = Sprite_Character.new(@viewport1, $game_player))
    $game_player.particle_push
    exec_hooks(Spriteset_Map, :init_player_end, binding)
    Yuki::ElapsedTime.show(:spriteset_map, 'init_player took')
  rescue ForceReturn => e
    log_error("Hooks tried to return #{e.data} in Spriteset_Map#init_player")
  end

  # Weather, picture and timer initialization
  def init_weather_picture_timer
    @weather = RPG::Weather.new(@viewport1)
    @picture_sprites = Array.new(50) { |i| Sprite_Picture.new(@viewport2, $game_screen.pictures[i + 1]) }
    @timer_sprite = Sprite_Timer.new(Graphics.window)
  end

  # Create the quest informer array
  def init_quest_informer
    # @type [Array<UI::QuestInformer>]
    @quest_informers = []
  end
  Hooks.register(self, :initialize, 'Quest Informer') { init_quest_informer }

  # Tell if the spriteset is disposed
  # @return [Boolean]
  def disposed?
    @viewport1.disposed?
  end

  # Spriteset_map dispose
  # @param from_warp [Boolean] if true, prepare a screenshot with some conditions and cancel the sprite dispose process
  # @return [Sprite, nil] a screenshot or nothing
  def dispose(from_warp = false)
    return take_map_snapshot if $game_switches[Yuki::Sw::WRP_Transition] && $scene.instance_of?(Scene_Map) && from_warp
    return nil if from_warp

    @tilemap.dispose
    @panorama.dispose
    @fog.dispose
    @character_sprites.each(&:dispose)
    @game_player_sprite = nil
    @weather.dispose
    @picture_sprites.each(&:dispose)
    @timer_sprite.dispose
    @quest_informers.clear
    @viewport1.dispose
    @viewport2.dispose
    @viewport3.dispose
    exec_hooks(Spriteset_Map, :dispose, binding)
    return nil
  rescue ForceReturn => e
    log_error("Hooks tried to return #{e.data} in Spriteset_Map#dispose")
  end

  # Update every sprite
  def update
    update_panorama_fog
    @tilemap.ox = $game_map.display_x / 4
    @tilemap.oy = $game_map.display_y / 4
    @tilemap.update
    update_events
    update_weather_picture
    @timer_sprite.update
    @viewport1.tone = $game_screen.tone
    @viewport1.ox = $game_screen.shake
    @viewport3.color = $game_screen.flash_color
    @viewport1.update
    @viewport3.update
    exec_hooks(Spriteset_Map, :update, binding)
    Graphics::FPSBalancer.global.run { exec_hooks(Spriteset_Map, :update_fps_balanced, binding) }
    @viewport1.sort_z # unless Graphics.skipping_frame?
    @viewport2.sort_z
  rescue ForceReturn => e
    log_error("Hooks tried to return #{e.data} in Spriteset_Map#update")
  end

  # update event sprite
  def update_events
    @character_sprites.each(&:update)
    $game_map.event_erased = false if $game_map.event_erased
  end

  # update weather and picture sprites
  def update_weather_picture
    @weather.max = $game_screen.weather_max
    @weather.type = $game_screen.weather_type
    @weather.ox = $game_map.display_x / 4
    @weather.oy = $game_map.display_y / 4
    @weather.update
    @picture_sprites.each(&:update)
  end

  # update panorama and fog sprites
  def update_panorama_fog
    if @panorama_name != $game_map.panorama_name # or @panorama_hue != $game_map.panorama_hue
      @panorama_name = $game_map.panorama_name
      @panorama_hue = $game_map.panorama_hue
      unless @panorama.texture.nil?
        @panorama.texture.dispose
        @panorama.texture = nil
      end
      @panorama.texture = RPG::Cache.panorama(@panorama_name, @panorama_hue) unless @panorama_name.empty? # if @panorama_name != ""
      Graphics.frame_reset
    end

    if @fog_name != $game_map.fog_name # or @fog_hue != $game_map.fog_hue
      @fog_name = $game_map.fog_name
      @fog_hue = $game_map.fog_hue
      unless @fog.texture.nil?
        @fog.texture.dispose
        @fog.texture = nil
      end
      @fog.texture = RPG::Cache.fog(@fog_name, @fog_hue) unless @fog_name.empty? # if @fog_name != ""
      Graphics.frame_reset
    end

    @panorama.set_origin($game_map.display_x / 8, $game_map.display_y / 8)

    @fog.zoom = $game_map.fog_zoom / 100.0
    @fog.opacity = $game_map.fog_opacity.to_i
    @fog.blend_type = $game_map.fog_blend_type
    @fog.set_origin(($game_map.display_x / 8 + $game_map.fog_ox) / 2, ($game_map.display_y / 8 + $game_map.fog_oy) / 2)
    @fog.tone = $game_map.fog_tone
  end

  # Get the Sprite_Picture linked to the ID of the Game_Picture
  # @param [Integer] the ID of the Game_Picture
  # @return [Sprite_Picture]
  def sprite_picture(id_game_picture)
    return @picture_sprites[id_game_picture - 1]
  end

  # create the zone panel of the current zone
  # @param zone [Integer, nil] the id of the zone where the player is
  def create_panel(zone)
    return unless zone && data_zone(zone).panel_id > 0

    @map_panel = UI::MapPanel.new(@viewport2, data_zone(zone))
  end
  Hooks.register(self, :finish_init, 'Zone Panel') { |method_binding| create_panel(method_binding[:zone]) }

  # Dispose the zone panel
  def dispose_sp_map
    @map_panel&.dispose
    @map_panel = nil
  end
  Hooks.register(self, :reload, 'Zone Panel') { dispose_sp_map }
  Hooks.register(self, :dispose, 'Zone Panel') { dispose_sp_map }

  # Update the zone panel
  def update_panel
    return unless @map_panel

    @map_panel.update
    dispose_sp_map if @map_panel.done?
  end
  Hooks.register(self, :update, 'Zone Panel') { update_panel }

  # Change the visible state of the Spriteset
  # @param value [Boolean] the new visibility state
  def visible=(value)
    @map_panel&.visible = value
    @viewport1.visible = value
    @viewport2.visible = value
    @viewport3.visible = value
  end

  # Return the map viewport
  # @return [Viewport]
  def map_viewport
    return @viewport1
  end

  # Add a new quest informer
  # @param name [String] Name of the quest
  # @param quest_status [Symbol] status of quest (:new, :completed, :failed)
  def inform_quest(name, quest_status)
    @quest_informers << UI::QuestInformer.new(@viewport2, name, quest_status, @quest_informers.size)
  end

  private

  # Take a snapshot of the map
  # @return [Sprite] the snapshot ready to be used
  def take_map_snapshot
    sp = Sprite.new(@viewport3)
    rc = @viewport3.rect
    sp.z = 10**6
    sp.bitmap = $scene.snap_to_bitmap
    sp.set_position(rc.width / 2, rc.height / 2)
    sp.set_origin(sp.width / 2, sp.height / 2)
    sp.zoom = rc.width / sp.bitmap.width.to_f
    return sp
  end

  # Update the quest informer
  def update_quest_informer
    @quest_informers.each do |informer|
      informer.update
      informer.dispose if informer.done?
    end
    @quest_informers.clear if @quest_informers.all?(&:done?)
  end
  Hooks.register(self, :update, 'Quest Informer') { update_quest_informer }

  # Hook that load the saved fog if we are on a outdoor map without any fog
  Hooks.register(Spriteset_Map, :reload, 'Spriteset_Map reloaded') do
    if $game_map.fog_name == nil.to_s && $game_switches[Yuki::Sw::Env_CanFly] && $fog_info
      $game_map.fog_name = $fog_info[0]
      $game_map.fog_hue = $fog_info[1]
      $game_map.fog_opacity = $fog_info[2]
      $game_map.fog_blend_type = $fog_info[3]
      $game_map.fog_zoom = $fog_info[4]
      $game_map.fog_sx = $fog_info[5]
      $game_map.fog_sy = $fog_info[6]
    end
  end
end
