//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT $,Email_Data,PublicRecords_KEL,Risk_Indicators,STD,address,header;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
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
  SHARED __CC9260 := -99999;
  EXPORT KEL.typ.str FN_Validate_Flag(KEL.typ.nstr __PFieldToCheck) := FUNCTION
    RETURN MAP(__T(__OR(__NT(__PFieldToCheck),__OP2(__PFieldToCheck,=,__CN(''))))=>(KEL.typ.str)__CC9260,__T(__OP2(FN__fn_Filter_Out_Valid_Chars(__ECAST(KEL.typ.nstr,__FN1(KEL.Routines.ToUpperCase,__FN1(KEL.Routines.TrimBoth,__PFieldToCheck)))),=,__CN('')))=>'0','1');
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
  EXPORT KEL.typ.nstr FN__fn_Naic_Code_Interpreter(KEL.typ.nstr __PNaicCodeInput) := FUNCTION
    NaicCodeInput := __T(__PNaicCodeInput);
    __IsNull := __NL(__PNaicCodeInput);
    __Value := PublicRecords_KEL.ECL_Functions.fn_NaicCodeInterpreter((INTEGER)NaicCodeInput);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nstr);
  END;
  EXPORT KEL.typ.str FN__fn_Naic_Group_Code_Interpreter(KEL.typ.nstr __PNaicCodeGroup) := FUNCTION
    RETURN MAP(__T(__OP2(__PNaicCodeGroup,=,__CN('11')))=>'Agriculture, Forestry, Fishing and Hunting',__T(__OP2(__PNaicCodeGroup,=,__CN('21')))=>'Mining',__T(__OP2(__PNaicCodeGroup,=,__CN('22')))=>'Utilities',__T(__OP2(__PNaicCodeGroup,=,__CN('23')))=>'Construction',__T(__OR(__OR(__OP2(__PNaicCodeGroup,=,__CN('31')),__OP2(__PNaicCodeGroup,=,__CN('32'))),__OP2(__PNaicCodeGroup,=,__CN('33'))))=>'Manufactuing',__T(__OP2(__PNaicCodeGroup,=,__CN('42')))=>'Wholesale Trade',__T(__OR(__OP2(__PNaicCodeGroup,=,__CN('44')),__OP2(__PNaicCodeGroup,=,__CN('45'))))=>'Retail Trade',__T(__OR(__OP2(__PNaicCodeGroup,=,__CN('48')),__OP2(__PNaicCodeGroup,=,__CN('49'))))=>'Transportation and Warehousing',__T(__OP2(__PNaicCodeGroup,=,__CN('51')))=>'Information',__T(__OP2(__PNaicCodeGroup,=,__CN('52')))=>'Finance and Insurance',__T(__OP2(__PNaicCodeGroup,=,__CN('53')))=>'Real Estate and Rental and Leasing',__T(__OP2(__PNaicCodeGroup,=,__CN('54')))=>'Professional, Scientific, and Technical Services',__T(__OP2(__PNaicCodeGroup,=,__CN('55')))=>'Management of Companies and Enterprises',__T(__OP2(__PNaicCodeGroup,=,__CN('56')))=>'Administrative and Waste Management Services',__T(__OP2(__PNaicCodeGroup,=,__CN('61')))=>'Educational Services',__T(__OP2(__PNaicCodeGroup,=,__CN('62')))=>'Health Care and Social Assistance',__T(__OP2(__PNaicCodeGroup,=,__CN('71')))=>'Arts, Entertainment, and Recreation',__T(__OP2(__PNaicCodeGroup,=,__CN('72')))=>'Accommodation and Food Services',__T(__OP2(__PNaicCodeGroup,=,__CN('81')))=>'Other Services',__T(__OP2(__PNaicCodeGroup,=,__CN('92')))=>'Public Administration','Other');
  END;
  EXPORT KEL.typ.nstr FN_Fn_S_I_C_Code_Interpreter(KEL.typ.nstr __PSic4CodeInput) := FUNCTION
    Sic4CodeInput := __T(__PSic4CodeInput);
    __IsNull := __NL(__PSic4CodeInput);
    __Value := PublicRecords_KEL.ECL_Functions.Fn_SICCodeInterpreter((INTEGER)Sic4CodeInput);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nstr);
  END;
  EXPORT KEL.typ.str FN_Fn_S_I_C_Group_Code_Interpreter(KEL.typ.nstr __PSicCodeGroup) := FUNCTION
    RETURN MAP(__T(__OP2(__PSicCodeGroup,IN,__CN(['01','02','07','08','09'])))=>'Agriculture, Forestry, Fishing and Hunting',__T(__OP2(__PSicCodeGroup,IN,__CN(['10','12','13','14'])))=>'Mining',__T(__OP2(__PSicCodeGroup,=,__CN('49')))=>'Utilities',__T(__OP2(__PSicCodeGroup,IN,__CN(['15','16','17'])))=>'Construction',__T(__OP2(__PSicCodeGroup,IN,__CN(['20','21','22','23','24','25','26','28','29','30','31','32','33','34','35','36','37','38','39'])))=>'Manufactuing',__T(__OP2(__PSicCodeGroup,IN,__CN(['50','51'])))=>'Wholesale Trade',__T(__OP2(__PSicCodeGroup,IN,__CN(['52','53','54','55','56','57','59'])))=>'Retail Trade',__T(__OP2(__PSicCodeGroup,IN,__CN(['40','41','42','43','44','45','46','47'])))=>'Transportation and Warehousing',__T(__OP2(__PSicCodeGroup,IN,__CN(['27','48','78'])))=>'Information',__T(__OP2(__PSicCodeGroup,IN,__CN(['60','61','62','63','64','67'])))=>'Finance and Insurance',__T(__OP2(__PSicCodeGroup,=,__CN('65')))=>'Real Estate',__T(__OP2(__PSicCodeGroup,IN,__CN(['81','87'])))=>'Professional, Scientific, and Technical Services',__T(__OP2(__PSicCodeGroup,=,__CN('73')))=>'Administrative Services',__T(__OP2(__PSicCodeGroup,=,__CN('82')))=>'Educational Services',__T(__OP2(__PSicCodeGroup,IN,__CN(['80','83'])))=>'Health Care and Social Assistance',__T(__OP2(__PSicCodeGroup,IN,__CN(['79','84'])))=>'Arts, Entertainment, and Recreation',__T(__OP2(__PSicCodeGroup,IN,__CN(['58','70'])))=>'Accommodation and Food Services',__T(__OP2(__PSicCodeGroup,IN,__CN(['72','75','76','86','88','89'])))=>'Other Services',__T(__OP2(__PSicCodeGroup,IN,__CN(['91','92','93','94','95','96','97'])))=>'Public Administration','Other');
  END;
  EXPORT KEL.typ.nstr FN__fn_Addr1_From_Components(KEL.typ.nstr __PPrimaryRange, KEL.typ.nstr __PPredirectional, KEL.typ.nstr __PPrimaryName, KEL.typ.nstr __PSuffix, KEL.typ.nstr __PPostdirectional, KEL.typ.nstr __PUnitDesignation, KEL.typ.nstr __PSecondaryRange) := FUNCTION
    PrimaryRange := __T(__PPrimaryRange);
    Predirectional := __T(__PPredirectional);
    PrimaryName := __T(__PPrimaryName);
    Suffix := __T(__PSuffix);
    Postdirectional := __T(__PPostdirectional);
    UnitDesignation := __T(__PUnitDesignation);
    SecondaryRange := __T(__PSecondaryRange);
    __IsNull := __NL(__PPrimaryRange) OR __NL(__PPredirectional) OR __NL(__PPrimaryName) OR __NL(__PSuffix) OR __NL(__PPostdirectional) OR __NL(__PUnitDesignation) OR __NL(__PSecondaryRange);
    __Value := address.Addr1FromComponents(PrimaryRange,Predirectional,PrimaryName,Suffix,Postdirectional,UnitDesignation,SecondaryRange);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nstr);
  END;
  EXPORT KEL.typ.str FN__map_Filing_Type(KEL.typ.nstr __PfilingType) := FUNCTION
    RETURN MAP(__T(__OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PfilingType)),IN,__CN(['UCC-3 TERMINATION','TERMINATION','UCC3 TERMINATION'])))=>'1',__T(__OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PfilingType)),=,__CN('CORRECTION')))=>'2',__T(__OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PfilingType)),=,__CN('AMENDMENT')))=>'3',__T(__OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PfilingType)),=,__CN('ASSIGNMENT')))=>'4',__T(__OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PfilingType)),=,__CN('CONTINUATION')))=>'5',__T(__OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PfilingType)),=,__CN('FILING OFFICER STATEMENT')))=>'6',__T(__OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PfilingType)),=,__CN('INITIAL FILING')))=>'7','7');
  END;
  EXPORT KEL.typ.str FN__map_Status_Type(KEL.typ.nstr __PStatusType) := FUNCTION
    RETURN MAP(__T(__OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PStatusType)),=,__CN('ACTIVE')))=>'1',__T(__OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PStatusType)),=,__CN('LAPSED')))=>'2',__T(__OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PStatusType)),=,__CN('TERMINATED')))=>'3',__T(__OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PStatusType)),=,__CN('DELETED')))=>'4',__T(__OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PStatusType)),=,__CN('EXPUNGED')))=>'5','1');
  END;
  EXPORT KEL.typ.str FN__map_Inferred_Status(KEL.typ.nstr __PfilingType) := FUNCTION
    RETURN IF(__T(__OP2(__PfilingType,=,__CN('1'))),'3','1');
  END;
  EXPORT KEL.typ.nstr FN_Map_Sic_Code_Padding(KEL.typ.nstr __PSicCode) := FUNCTION
    RETURN MAP(__T(__OP2(__FN1(LENGTH,__PSicCode),=,__CN(1)))=>__ECAST(KEL.typ.nstr,__OP2(__OP2(__CN('0'),+,__PSicCode),+,__CN('00'))),__T(__OP2(__FN1(LENGTH,__PSicCode),=,__CN(3)))=>__ECAST(KEL.typ.nstr,__OP2(__CN('0'),+,__PSicCode)),__T(__OP2(__FN1(LENGTH,__PSicCode),=,__CN(2)))=>__ECAST(KEL.typ.nstr,__OP2(__PSicCode,+,__CN('00'))),__ECAST(KEL.typ.nstr,__PSicCode));
  END;
END;
