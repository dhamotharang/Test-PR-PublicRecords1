//Rural Route
export isRR(STRING prim_name, boolean RequireNumber = false) := 
	(stringlib.stringfilterout(prim_name, '-.0123456789')[..3] = 'RR ') AND
	(not RequireNumber or prim_name[3..] <> '');