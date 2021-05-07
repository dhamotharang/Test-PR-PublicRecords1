EXPORT ComputeBinaryNode_FIWN12103_0_SSN_OVERALL(fieldval,dtable,curstate) := FUNCTIONMACRO
  REAL4 val := dtable[curstate].Number;
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
