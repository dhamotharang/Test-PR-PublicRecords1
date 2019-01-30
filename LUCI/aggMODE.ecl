  EXPORT REAL8 aggMODE(SET of REAL8 vals):=FUNCTION
    dsgrp:=SORT(TABLE(DATASET(vals,{REAL8 val}),{val,numtrees:=COUNT(GROUP)},val),-numtrees);
		result:=dsgrp[1].val;
    return result;
    //todo: if multiple values have the same max count, return one at random
  END;