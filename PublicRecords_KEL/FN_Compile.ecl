//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT Risk_Indicators,STD;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT FN_Compile := MODULE
  EXPORT KEL.typ.nint FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(KEL.typ.nkdate __Pfrom, KEL.typ.nkdate __Pto) := FUNCTION
    RETURN __FN1(ABS,__FN2(KEL.Routines.DaysBetween,__Pfrom,__Pto));
  END;
  EXPORT KEL.typ.nstr FN_Is_Blank(KEL.typ.nstr __PFieldToCheck, KEL.typ.nstr __PDefaultVal) := FUNCTION
    RETURN IF(__T(__OR(__NT(__PFieldToCheck),__OP2(__PFieldToCheck,=,__CN('')))),__ECAST(KEL.typ.nstr,__PDefaultVal),__ECAST(KEL.typ.nstr,__PFieldToCheck));
  END;
  EXPORT KEL.typ.nint FN_Is_Zero(KEL.typ.nint __PFieldToCheck, KEL.typ.nint __PDefaultVal) := FUNCTION
    RETURN IF(__T(__OR(__NT(__PFieldToCheck),__OP2(__PFieldToCheck,=,__CN(0)))),__ECAST(KEL.typ.nint,__PDefaultVal),__ECAST(KEL.typ.nint,__PFieldToCheck));
  END;
  EXPORT KEL.typ.nstr FN_Is_Blank2_Fields(KEL.typ.nstr __PField1ToCheck, KEL.typ.nstr __PDefault1Val, KEL.typ.nstr __PField2ToCheck, KEL.typ.nstr __PDefault2Val) := FUNCTION
    RETURN MAP(__T(__OR(__NT(__PField1ToCheck),__OP2(__PField1ToCheck,=,__CN(''))))=>__ECAST(KEL.typ.nstr,__PDefault1Val),__T(__OR(__NT(__PField2ToCheck),__OP2(__PField2ToCheck,=,__CN(''))))=>__ECAST(KEL.typ.nstr,__PDefault2Val),__ECAST(KEL.typ.nstr,__PField2ToCheck));
  END;
  EXPORT KEL.typ.bool FN_Name_Not_Populated_Check(KEL.typ.nstr __PFnameToCheck, KEL.typ.nstr __PMnameToCheck, KEL.typ.nstr __PLnameToCheck) := FUNCTION
    RETURN IF(__T(__AND(__AND(__OR(__NT(__PFnameToCheck),__OP2(__PFnameToCheck,=,__CN(''))),__OR(__NT(__PMnameToCheck),__OP2(__PMnameToCheck,=,__CN('')))),__OR(__NT(__PLnameToCheck),__OP2(__PLnameToCheck,=,__CN(''))))),TRUE,FALSE);
  END;
  EXPORT KEL.typ.bool FN_Is_Not_Enough_To_Clean(KEL.typ.nstr __PFieldToCheck) := FUNCTION
    RETURN IF(__T(__OR(__NT(__PFieldToCheck),__OP2(__PFieldToCheck,=,__CN('')))),TRUE,FALSE);
  END;
  EXPORT KEL.typ.nbool FN_City_State_Zip_Not_Populated_Check(KEL.typ.nstr __PCity, KEL.typ.nstr __PState, KEL.typ.nstr __PZip) := FUNCTION
    RETURN __AND(__OR(__NT(__PZip),__OP2(__PZip,=,__CN(''))),__OR(__OR(__NT(__PCity),__OP2(__PCity,=,__CN(''))),__OR(__NT(__PState),__OP2(__PState,=,__CN('')))));
  END;
  EXPORT KEL.typ.str FN_Is_Echo_Populated(KEL.typ.nstr __PFieldToCheck) := FUNCTION
    RETURN IF(__T(__OR(__NT(__PFieldToCheck),__OP2(__PFieldToCheck,=,__CN('')))),'0','1');
  END;
  EXPORT KEL.typ.nstr FN_Is_Clean_Populated(KEL.typ.nstr __PFieldToCheck, KEL.typ.nstr __PDefaultVal1, KEL.typ.nstr __PDefaultVal2) := FUNCTION
    RETURN IF(__T(__OP2(__PFieldToCheck,=,__PDefaultVal1)),__ECAST(KEL.typ.nstr,__PDefaultVal1),__ECAST(KEL.typ.nstr,__CN(IF(__T(__OP2(__PFieldToCheck,=,__PDefaultVal2)),'0','1'))));
  END;
  EXPORT KEL.typ.nkdate FN_G_E_T_B_U_I_L_D_D_A_T_E(KEL.typ.nstr __PvariableName) := FUNCTION
    variableName := __T(__PvariableName);
    __IsNull := __NL(__PvariableName);
    __Value := (UNSIGNED8)Risk_Indicators.get_Build_date(variableName);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nkdate);
  END;
  EXPORT KEL.typ.nint FN_Edit_Distance(KEL.typ.nstr __Pfield1, KEL.typ.nstr __Pfield2) := FUNCTION
    field1 := __T(__Pfield1);
    field2 := __T(__Pfield2);
    __IsNull := __NL(__Pfield1) OR __NL(__Pfield2);
    __Value := STD.Str.EditDistance(field1,field2);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nint);
  END;
END;
