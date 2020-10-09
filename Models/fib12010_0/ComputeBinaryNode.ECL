/*
    if (S_EQ.equals(s)) // Needs to be in sync with luci.comparebinarynode
        return 1;
    if (S_NEQ.equals(s))
        return 2;
    if (S_GEQ.equals(s))
        return 3;
    if (S_LEQ.equals(s))
        return 4;
    if (S_LT.equals(s))
        return 5;
    if (S_GT.equals(s))
        return 6;
*/

EXPORT ComputeBinaryNode(fieldval,dtable,curstate) := FUNCTIONMACRO
    REAL val := dtable[curstate].Number;
	RETURN MAP ( dtable[curstate].comparemethod = 0 => curstate,
	             CHOOSE( dtable[curstate].comparemethod,
	                     fieldval = val,
                         fieldval <> val,
                         fieldval >= val,
                         fieldval <= val,
                         fieldval < val,
                         fieldval > val
	             ) => dtable[curstate].l,
	             dtable[curstate].r );
ENDMACRO;
