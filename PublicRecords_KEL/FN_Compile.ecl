//HPCC Systems KEL Compiler Version 0.11.4
IMPORT KEL011 AS KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT FN_Compile := MODULE
  EXPORT KEL.typ.nint FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(KEL.typ.nkdate __Pfrom, KEL.typ.nkdate __Pto) := FUNCTION
    RETURN __FN1(ABS,__FN2(KEL.Routines.DaysBetween,__Pfrom,__Pto));
  END;
  EXPORT KEL.typ.nint FN_A_B_S_Y_E_A_R_S_B_E_T_W_E_E_N(KEL.typ.nkdate __Pfrom, KEL.typ.nkdate __Pto) := FUNCTION
    RETURN __FN1(ABS,__FN2(KEL.Routines.YearsBetween,__Pfrom,__Pto));
  END;
END;
