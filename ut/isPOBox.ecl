export isPOBox(STRING prim_name, boolean RequireNumber = false) :=
	prim_name[1..7] = 'PO BOX ' and
	(not RequireNumber or prim_name[7..] <> '');