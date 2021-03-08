//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT ProfileBoosterV2_KEL,Risk_Indicators;
IMPORT CFG_Compile FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL12.Null;
EXPORT FN_Compile(CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT KEL.typ.nint FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(KEL.typ.nkdate __Pfrom, KEL.typ.nkdate __Pto) := FUNCTION
    RETURN __FN1(ABS,__FN2(KEL.Routines.DaysBetween,__Pfrom,__Pto));
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
  EXPORT KEL.typ.str FN_Is_Echo_Populated_Integer(KEL.typ.nint __PFieldToCheck) := FUNCTION
    RETURN IF(__T(__OR(__NT(__PFieldToCheck),__OP2(__PFieldToCheck,=,__CN(0)))),'0','1');
  END;
  EXPORT KEL.typ.nkdate FN_G_E_T_B_U_I_L_D_D_A_T_E(KEL.typ.nstr __PvariableName) := FUNCTION
    variableName := __T(__PvariableName);
    __IsNull := __NL(__PvariableName);
    __Value := (UNSIGNED8)Risk_Indicators.get_Build_date(variableName);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nkdate);
  END;
  EXPORT KEL.typ.nstr FN_Vehicle_Type_Group(KEL.typ.nstr __PFieldToCheck) := FUNCTION
    FieldToCheck := __T(__PFieldToCheck);
    __IsNull := __NL(__PFieldToCheck);
    __Value := ProfileBoosterV2_KEL.ECL_Functions.Common_Functions.VehicleTypeGroup(FieldToCheck);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nstr);
  END;
END;
