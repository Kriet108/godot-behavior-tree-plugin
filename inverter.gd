extends "res://addons/com.brandonlamb.bt/root.gd"

const BehvError = preload("res://addons/com.brandonlamb.bt/error.gd")

# Decorator Node
func tick(actor, ctx):
	if get_child_count() > 1:
		return BehvError.new(self, "Inverter has more than one child")

	# 0..1 children
	for c in get_children():
		if c.disabled:
			return OK

		var result = c.tick(actor, ctx)

		if (typeof(result) == TYPE_OBJECT and result extends BehvError) or result == ERR_BUSY:
			return result
		elif result == OK:
			return FAILED
		elif result == FAILED:
			return OK
