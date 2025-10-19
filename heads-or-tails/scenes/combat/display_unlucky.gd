extends TextureRect

@export var display_duration: float = 0.5  # 显示持续时间
@export var fade_duration: float = 0.1    # 淡入淡出时间

func _ready():
	GlobalSignals.card_effect_triggered.connect(_on_global_card_effect_triggered)
	# 初始状态：完全透明且隐藏
	modulate.a = 0
	visible = false

	
func show_effect():
	# 1. 显示节点并重置状态
	visible = true
	modulate.a = 0
	scale = Vector2(0.8, 0.8)  # 初始稍小的缩放
	
	# 2. 创建Tween动画
	var tween = create_tween()
	tween.set_parallel(true)  # 允许同时执行多个动画
	
	# 3. 淡入效果
	tween.tween_property(self, "modulate:a", 1.0, fade_duration)
	
	# 4. 缩放效果（从缩小到正常）
	tween.tween_property(self, "scale", Vector2(1, 1), fade_duration).set_trans(Tween.TRANS_BACK)
	
	# 5. 等待显示时间后淡出
	await tween.finished
	await get_tree().create_timer(display_duration).timeout
	
	# 6. 创建新的Tween用于淡出
	tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "modulate:a", 0.0, fade_duration)
	tween.tween_property(self, "scale", Vector2(0.8, 0.8), fade_duration)
	
	# 7. 动画完成后隐藏
	await tween.finished
	visible = false

# 在卡牌逻辑中调用此方法
func _on_card_effect_success():
	# 添加安全检查
	if not is_inside_tree():
		return
	
	# 确保获取到的特效节点也是有效的
	var effect_display = get_node_or_null("UI/EffectDisplay")
	if effect_display and effect_display.is_inside_tree():
		effect_display.show_effect()

func _on_global_card_effect_triggered(effect_type):
	if effect_type == "unlucky":
		show_effect()
