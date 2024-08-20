extends ParallaxBackground
class_name SkyBackground

@export var day_sky: CompressedTexture2D
@export var night_sky: CompressedTexture2D
@export var small_clouds: CompressedTexture2D
@export var stars: CompressedTexture2D

func set_night():
	$Sky/Sprite2D.texture = night_sky
	$"small clouds/Sprite2D".set_texture(stars)
	$"big clouds".visible = false

func set_day():
	$Sky/Sprite2D.texture = day_sky
	$"small clouds/Sprite2D".set_texture(small_clouds)
	$"big clouds".visible = true
