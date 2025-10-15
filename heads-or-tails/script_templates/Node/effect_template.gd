# meta-name: Effect
# meta-description: Creat an effect which can be applied to a target.
class_name MyAwesomeEffect
extends Effect

var member_var := 0

func execute(_targets: Array[Node]) -> void:
	print("My effect targets them: %s" % _targets)
	print("It does %s something" % member_var)
