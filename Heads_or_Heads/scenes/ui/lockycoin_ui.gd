class_name LuckCoinUI
extends Panel

# 能量值信号，用于与其他系统通信
signal energy_changed(new_energy)
signal energy_depleted()
signal energy_max_reached()

# 能量属性 - Godot 4.5 新的 setter 语法
var current_energy: float = 0.0:
	set(value):
		var previous_energy = current_energy
		current_energy = clamp(value, 0.0, max_energy)
		if current_energy != previous_energy:
			update_display()
			energy_changed.emit(current_energy)
			if current_energy <= 0:
				energy_depleted.emit()
			elif current_energy >= max_energy:
				energy_max_reached.emit()

var max_energy: float = 100.0:
	set(value):
		max_energy = max(value, 0.1)  # 确保最小为0.1避免除零
		current_energy = min(current_energy, max_energy)
		update_display()

# 场景节点引用 - Godot 4.5 使用 @onready
@onready var luckycoin_label: Label = $Label
# @onready var progress_bar: ProgressBar = $ProgressBar  # 如果有进度条的话

func _ready():
	# 初始化显示
	update_display()

# 更新UI显示
func update_display() -> void:
	if luckycoin_label:
		# 防止除零错误
		var display_percentage = 0.0
		if max_energy > 0:
			display_percentage = (current_energy / max_energy) * 100
		
		# 格式化显示，保留一位小数
		luckycoin_label.text = str(display_percentage) + "%"
	
	# 如果有进度条也更新
	#if progress_bar:
	#	progress_bar.max_value = max_energy
	#	progress_bar.value = current_energy

# 公共方法 - 增加能量
func add_energy(amount: float) -> void:
	current_energy += amount  # 这会自动调用setter

# 公共方法 - 减少能量
func subtract_energy(amount: float) -> void:
	current_energy -= amount

# 公共方法 - 设置能量百分比
func set_energy_percentage(percentage: float) -> void:
	var clamped_percentage = clamp(percentage, 0.0, 1.0)
	current_energy = max_energy * clamped_percentage

# 获取当前能量百分比（0.0 - 1.0）
func get_energy_percentage() -> float:
	if max_energy <= 0:
		return 0.0
	return current_energy / max_energy

# 获取当前能量值（用于游戏运算）
func get_current_energy() -> float:
	return current_energy

# 检查是否有足够能量
func has_enough_energy(required: float) -> bool:
	return current_energy >= required

# 重置能量
func reset_energy() -> void:
	current_energy = max_energy
