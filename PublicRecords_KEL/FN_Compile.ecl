//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT $,Email_Data,PublicRecords_KEL,Risk_Indicators,STD,header;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT FN_Compile(CFG_Compile __cfg = CFG_Compile) := MODULE
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
    __Value := STD.Str.EditDistance(field1, field2);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nint);
  END;
  EXPORT KEL.typ.nint FN_Find_Count(KEL.typ.nstr __Psource, KEL.typ.nstr __Ptarget) := FUNCTION
    source := __T(__Psource);
    target := __T(__Ptarget);
    __IsNull := __NL(__Psource) OR __NL(__Ptarget);
    __Value := STD.Str.FindCount(source, target);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nint);
  END;
  EXPORT KEL.typ.nstr FN_Source_Group(KEL.typ.nstr __PRawSource) := FUNCTION
    RawSource := __T(__PRawSource);
    __IsNull := __NL(__PRawSource);
    __Value := PublicRecords_KEL.ECL_Functions.Common_Functions.SourceGroup(RawSource);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nstr);
  END;
  EXPORT KEL.typ.nstr FN_Filter(KEL.typ.nstr __PSource, KEL.typ.nstr __PFilterString) := FUNCTION
    Source := __T(__PSource);
    FilterString := __T(__PFilterString);
    __IsNull := __NL(__PSource) OR __NL(__PFilterString);
    __Value := STD.Str.Filter(Source, FilterString);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nstr);
  END;
  EXPORT KEL.typ.nstr FN_Filter_Out(KEL.typ.nstr __Psource, KEL.typ.nstr __Pfilter) := FUNCTION
    source := __T(__Psource);
    filter := __T(__Pfilter);
    __IsNull := __NL(__Psource) OR __NL(__Pfilter);
    __Value := STD.Str.FilterOut(source, filter);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nstr);
  END;
  EXPORT KEL.typ.nbool FN_Is_Bad_Phone(KEL.typ.nstr __PPhone) := FUNCTION
    Phone := __T(__PPhone);
    __IsNull := __NL(__PPhone);
    __Value := PublicRecords_KEL.ECL_Functions.Common_Functions.IsBadPhone(Phone);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nbool);
  END;
  EXPORT KEL.typ.nbool FN_Is_Bad_S_S_N(KEL.typ.nstr __PSSN) := FUNCTION
    SSN := __T(__PSSN);
    __IsNull := __NL(__PSSN);
    __Value := PublicRecords_KEL.ECL_Functions.Common_Functions.IsBadSSN(SSN);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nbool);
  END;
  EXPORT KEL.typ.nstr FN_Fn___Clean___State(KEL.typ.nstr __PState) := FUNCTION
    State := __T(__PState);
    __IsNull := __NL(__PState);
    __Value := PublicRecords_KEL.ECL_Functions.Fn_Clean_DLState(State);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nstr);
  END;
  EXPORT KEL.typ.nstr FN_Get_Clean_Email_Domain(KEL.typ.nstr __Pemail) := FUNCTION
    email := __T(__Pemail);
    __IsNull := __NL(__Pemail);
    __Value := Email_Data.Fn_Clean_Email_Domain(email);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nstr);
  END;
  EXPORT KEL.typ.nstr FN_Get_Clean_Email_Username(KEL.typ.nstr __Pemail) := FUNCTION
    email := __T(__Pemail);
    __IsNull := __NL(__Pemail);
    __Value := Email_Data.Fn_Clean_Email_Username(email);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nstr);
  END;
  EXPORT KEL.typ.nint FN_Find_Last_String_Instance(KEL.typ.nstr __Psource, KEL.typ.nstr __PsearchString) := FUNCTION
    source := __T(__Psource);
    searchString := __T(__PsearchString);
    __IsNull := __NL(__Psource) OR __NL(__PsearchString);
    __Value := StringLib.StringFind(source, searchString,StringLib.StringFindCount(source, searchString));
    RETURN __BNT(__Value,__IsNull,KEL.typ.nint);
  END;
  EXPORT KEL.typ.nint FN_Bad_Email_Check(KEL.typ.nstr __Pemail, KEL.typ.nstr __Pdomain) := FUNCTION
    email := __T(__Pemail);
    domain := __T(__Pdomain);
    __IsNull := __NL(__Pemail) OR __NL(__Pdomain);
    __Value := Email_Data.Fn_InvalidEmail(email,domain);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nint);
  END;
  EXPORT KEL.typ.nstr FN__fn_Filter_Out_Valid_Chars(KEL.typ.nstr __PField) := FUNCTION
    Field := __T(__PField);
    __IsNull := __NL(__PField);
    __Value := PublicRecords_KEL.ECL_Functions.Fn_STD_Str_FilterOut_ValidChars(Field);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nstr);
  END;
  SHARED __CC8928 := -99999;
  EXPORT KEL.typ.str FN_Validate_Flag(KEL.typ.nstr __PFieldToCheck) := FUNCTION
    RETURN MAP(__T(__OR(__NT(__PFieldToCheck),__OP2(__PFieldToCheck,=,__CN(''))))=>(KEL.typ.str)__CC8928,__T(__OP2(FN__fn_Filter_Out_Valid_Chars(__ECAST(KEL.typ.nstr,__FN1(KEL.Routines.ToUpperCase,__FN1(KEL.Routines.TrimBoth,__PFieldToCheck)))),=,__CN('')))=>'0','1');
  END;
  EXPORT KEL.typ.nstr FN__fn_Bogus_Names(KEL.typ.nstr __PsNameFirst, KEL.typ.nstr __PsNameMid, KEL.typ.nstr __PsNameLast) := FUNCTION
    sNameFirst := __T(__PsNameFirst);
    sNameMid := __T(__PsNameMid);
    sNameLast := __T(__PsNameLast);
    __IsNull := __NL(__PsNameFirst) OR __NL(__PsNameMid) OR __NL(__PsNameLast);
    __Value := header.BogusNames(sNameFirst, sNameMid, sNameLast);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nstr);
  END;
  EXPORT KEL.typ.nint FN_Append_Location_I_D(KEL.typ.nstr __PPrimRange, KEL.typ.nstr __PPredir, KEL.typ.nstr __PPrimName, KEL.typ.nstr __PSuffix, KEL.typ.nstr __PPostdir, KEL.typ.nstr __PSecRange, KEL.typ.nstr __PCity, KEL.typ.nstr __PState, KEL.typ.nstr __PZIP) := FUNCTION
    PrimRange := __T(__PPrimRange);
    Predir := __T(__PPredir);
    PrimName := __T(__PPrimName);
    Suffix := __T(__PSuffix);
    Postdir := __T(__PPostdir);
    SecRange := __T(__PSecRange);
    City := __T(__PCity);
    State := __T(__PState);
    ZIP := __T(__PZIP);
    __IsNull := __NL(__PPrimRange) OR __NL(__PPredir) OR __NL(__PPrimName) OR __NL(__PSuffix) OR __NL(__PPostdir) OR __NL(__PSecRange) OR __NL(__PCity) OR __NL(__PState) OR __NL(__PZIP);
    __Value := PublicRecords_KEL.ECL_Functions.Fn_Append_LocationID(PrimRange, Predir, PrimName, Suffix, Postdir, SecRange, City, State, ZIP);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nint);
  END;
  EXPORT KEL.typ.nstr FN__fn_Remove_Special_Chars(KEL.typ.nstr __Pfield1, KEL.typ.nstr __Preplacement) := FUNCTION
    field1 := __T(__Pfield1);
    replacement := __T(__Preplacement);
    __IsNull := __NL(__Pfield1) OR __NL(__Preplacement);
    __Value := PublicRecords_KEL.ECL_Functions.Fn_RemoveSpecialChars(field1, replacement);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nstr);
  END;
END;
