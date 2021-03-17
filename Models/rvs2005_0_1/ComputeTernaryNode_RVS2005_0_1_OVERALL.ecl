﻿EXPORT ComputeTernaryNode_RVS2005_0_1_OVERALL(fieldval,dtable,curstate,nullval) := FUNCTIONMACRO
  REAL4 val := dtable[curstate].Number;
  RETURN MAP ( dtable[curstate].comparemethod = 0 => curstate,
    fieldval = nullval => dtable[curstate].missing,
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
