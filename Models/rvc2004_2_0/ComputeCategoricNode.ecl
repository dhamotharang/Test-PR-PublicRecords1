EXPORT ComputeCategoricNode(fieldval,dtable,curstate,nullval) := FUNCTIONMACRO
    REAL val := dtable[curstate].Number;
	RETURN MAP ( dtable[curstate].comparemethod = 0 => curstate,
	             fieldval = nullval => dtable[curstate].missing,
				 EXISTS(dtable[curstate].legs) => dtable[curstate].legs[fieldval].leg,
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
