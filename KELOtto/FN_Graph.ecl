//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT Std;
IMPORT * FROM KEL011.Null;
EXPORT FN_Graph := MODULE
  EXPORT KEL.typ.nstr FN_Clean_Spaces(KEL.typ.nstr __Ps) := FUNCTION
    s := __T(__Ps);
    __IsNull := __NL(__Ps);
    __Value := STD.Str.CleanSpaces(s);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nstr);
  END;
END;
