# A sprite that show a Game_Picture on the screen
class Sprite_Picture < ShaderedSprite
  # Tell if the loop of the gif is disabled or not
  # @return [Boolean]
  attr_accessor :gif_loop_disabled

  # Initialize a new Sprite_Picture
  # @param viewport [Viewport] the viewport where the sprite will be shown
  # @param picture [Game_Picture] the picture
  def initialize(viewport, picture)
    super(viewport)
    self.shader = Shader.create(:full_shader)
    @picture = picture
    @gif_handle = nil
    update
  end

  # Dispose the picture
  def dispose
    dispose_bitmap
    super
  end

  # Update the picture sprite display with the information of the current Game_Picture
  def update
    super
    # Try to load the new file if the name is different
    if @picture_name != @picture.name
      @picture_name = @picture.name
      load_bitmap
    end
    # Don't update if the name is empty
    if @picture_name.empty?
      self.visible = false
      return
    end
    self.visible = true

    update_properties
    update_gif if @gif_handle
  end

  # Tell if the gif animation is done
  # @return [Boolean]
  def gif_done?
    return true unless @gif_handle

    return @gif_handle.frame + 1 >= @gif_handle.frame_count
  end

  private

  # Update the picture properties on the sprite
  def update_properties
    if @picture.origin == 0
      set_origin(0, 0)
    else
      set_origin(bitmap.width / 2, bitmap.height / 2)
    end
    set_position(@picture.x, @picture.y)
    self.z = @picture.number
    self.zoom_x = @picture.zoom_x / 100.0
    self.zoom_y = @picture.zoom_y / 100.0
    self.opacity = @picture.opacity
    shader.blend_type = @picture.blend_type
    self.angle = @picture.angle
    tone = @picture.tone
    unless tone.eql?(@current_tone)
      shader.set_float_uniform('tone', tone)
      @current_tone = tone.clone
    end
    self.mirror = @picture.mirror
    self.mirror = @picture.mirror = false
  end

  # Update the gif animation
  def update_gif
    return if @gif_loop_disabled && gif_done?
    @gif_handle.update(bitmap)
  end

  # Load the picture bitmap
  def load_bitmap
    if @picture_name.empty?
      dispose_bitmap if @gif_handle
      return
    end
    # Test for gif loading
    if Yuki::GifReader.exist?(gif_filename = "#{@picture_name}.gif", :picture)
      @gif_handle = Yuki::GifReader.new(RPG::Cache.picture(gif_filename), true)
      self.bitmap = Texture.new(@gif_handle.width, @gif_handle.height)
    else
      set_bitmap(@picture_name, :picture)
    end
  end

  # Dispose the bitmap
  def dispose_bitmap
    bitmap.dispose if bitmap && !bitmap.disposed?
    @gif_handle = nil
  end
end
