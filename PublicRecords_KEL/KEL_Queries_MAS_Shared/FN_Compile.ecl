//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT $,Email_Data,NID,PublicRecords_KEL,Royalty,STD,address,header;
IMPORT CFG_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Shared;
IMPORT * FROM KEL16.Null;
EXPORT FN_Compile(CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT KEL.typ.nbool FN_R_E_A_L_E_Q_U_A_L(KEL.typ.nfloat __Pval1, KEL.typ.nfloat __Pval2) := FUNCTION
    RETURN __OP2(__FN1(ABS,__OP2(__Pval1,-,__Pval2)),<,__CN(1.0E-8));
  END;
  EXPORT KEL.typ.nint FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(KEL.typ.nkdate __Pfrom, KEL.typ.nkdate __Pto) := FUNCTION
    RETURN __FN1(ABS,__FN2(KEL.Routines.DaysBetween,__Pfrom,__Pto));
  END;
  EXPORT KEL.typ.nint FN_A_B_S_Y_E_A_R_S_B_E_T_W_E_E_N(KEL.typ.nkdate __Pfrom, KEL.typ.nkdate __Pto) := FUNCTION
    RETURN __FN1(ABS,__FN2(KEL.Routines.YearsBetween,__Pfrom,__Pto));
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
  EXPORT KEL.typ.bool FN_Is_Not_Enough_To_Clean_Int(KEL.typ.nstr __PFieldToCheck) := FUNCTION
    RETURN IF(__T(__OR(__NT(__PFieldToCheck),__OP2(__PFieldToCheck,=,__CAST(KEL.typ.str,__CN(0))))),TRUE,FALSE);
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
    __Value := (UNSIGNED8)PublicRecords_KEL.ECL_Functions.get_mas_build_dates(variableName);
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
  EXPORT KEL.typ.nstr FN_Consumer_Source_Group(KEL.typ.nstr __PRawSource) := FUNCTION
    RawSource := __T(__PRawSource);
    __IsNull := __NL(__PRawSource);
    __Value := PublicRecords_KEL.ECL_Functions.Common_Functions.ConsumerSourceGroup(RawSource);
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
  SHARED __CC13682 := -99999;
  EXPORT KEL.typ.str FN_Validate_Flag(KEL.typ.nstr __PFieldToCheck) := FUNCTION
    RETURN MAP(__T(__OR(__NT(__PFieldToCheck),__OP2(__PFieldToCheck,=,__CN(''))))=>(KEL.typ.str)__CC13682,__T(__OP2(FN__fn_Filter_Out_Valid_Chars(__ECAST(KEL.typ.nstr,__FN1(KEL.Routines.ToUpperCase,__FN1(KEL.Routines.TrimBoth,__PFieldToCheck)))),=,__CN('')))=>'0','1');
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
  EXPORT KEL.typ.nbool FN__fn_In_Voters_State(KEL.typ.nstr __PState, KEL.typ.nstr __Phistorydate) := FUNCTION
    State := __T(__PState);
    historydate := __T(__Phistorydate);
    __IsNull := __NL(__PState) OR __NL(__Phistorydate);
    __Value := PublicRecords_KEL.ECL_Functions.FN_inVotersState(State,historydate);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nbool);
  END;
  EXPORT KEL.typ.nbool FN__fn_In_Drivers_State(KEL.typ.nstr __PState) := FUNCTION
    RETURN __OP2(__PState,IN,__CN(['MO','MN','FL','OH','TX','NE','ID','ME','WV','MI','LA','NC','MA','TN','WY','KY','CT','WI']));
  END;
  EXPORT KEL.typ.nstr FN__fn_Naic_Code_Interpreter(KEL.typ.nstr __PNaicCodeInput) := FUNCTION
    NaicCodeInput := __T(__PNaicCodeInput);
    __IsNull := __NL(__PNaicCodeInput);
    __Value := PublicRecords_KEL.ECL_Functions.fn_NaicCodeInterpreter(NaicCodeInput);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nstr);
  END;
  EXPORT KEL.typ.str FN__fn_Naic_Group_Code_Interpreter(KEL.typ.nstr __PNaicCodeGroup) := FUNCTION
    RETURN MAP(__T(__OP2(__PNaicCodeGroup,=,__CN('11')))=>'Agriculture, Forestry, Fishing and Hunting',__T(__OP2(__PNaicCodeGroup,=,__CN('21')))=>'Mining',__T(__OP2(__PNaicCodeGroup,=,__CN('22')))=>'Utilities',__T(__OP2(__PNaicCodeGroup,=,__CN('23')))=>'Construction',__T(__OR(__OR(__OP2(__PNaicCodeGroup,=,__CN('31')),__OP2(__PNaicCodeGroup,=,__CN('32'))),__OP2(__PNaicCodeGroup,=,__CN('33'))))=>'Manufactuing',__T(__OP2(__PNaicCodeGroup,=,__CN('42')))=>'Wholesale Trade',__T(__OR(__OP2(__PNaicCodeGroup,=,__CN('44')),__OP2(__PNaicCodeGroup,=,__CN('45'))))=>'Retail Trade',__T(__OR(__OP2(__PNaicCodeGroup,=,__CN('48')),__OP2(__PNaicCodeGroup,=,__CN('49'))))=>'Transportation and Warehousing',__T(__OP2(__PNaicCodeGroup,=,__CN('51')))=>'Information',__T(__OP2(__PNaicCodeGroup,=,__CN('52')))=>'Finance and Insurance',__T(__OP2(__PNaicCodeGroup,=,__CN('53')))=>'Real Estate and Rental and Leasing',__T(__OP2(__PNaicCodeGroup,=,__CN('54')))=>'Professional, Scientific, and Technical Services',__T(__OP2(__PNaicCodeGroup,=,__CN('55')))=>'Management of Companies and Enterprises',__T(__OP2(__PNaicCodeGroup,=,__CN('56')))=>'Administrative and Waste Management Services',__T(__OP2(__PNaicCodeGroup,=,__CN('61')))=>'Educational Services',__T(__OP2(__PNaicCodeGroup,=,__CN('62')))=>'Health Care and Social Assistance',__T(__OP2(__PNaicCodeGroup,=,__CN('71')))=>'Arts, Entertainment, and Recreation',__T(__OP2(__PNaicCodeGroup,=,__CN('72')))=>'Accommodation and Food Services',__T(__OP2(__PNaicCodeGroup,=,__CN('81')))=>'Other Services',__T(__OP2(__PNaicCodeGroup,=,__CN('92')))=>'Public Administration','Other');
  END;
  EXPORT KEL.typ.nstr FN_Fn_S_I_C_Code_Interpreter(KEL.typ.nstr __PSic4CodeInput) := FUNCTION
    Sic4CodeInput := __T(__PSic4CodeInput);
    __IsNull := __NL(__PSic4CodeInput);
    __Value := PublicRecords_KEL.ECL_Functions.Fn_SICCodeInterpreter(Sic4CodeInput);
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
  EXPORT KEL.typ.nbool FN_Is_Found(KEL.typ.nstr __Psource, KEL.typ.nstr __Ptarget) := FUNCTION
    source := __T(__Psource);
    target := __T(__Ptarget);
    __IsNull := __NL(__Psource) OR __NL(__Ptarget);
    __Value := STD.Str.Find(source, target, 1) > 0;
    RETURN __BNT(__Value,__IsNull,KEL.typ.nbool);
  END;
  EXPORT KEL.typ.nstr FN_Regex_Replace(KEL.typ.nstr __Pregex, KEL.typ.nstr __Ptext, KEL.typ.nstr __Preplacement, KEL.typ.nbool __Pcaseinsensitive) := FUNCTION
    regex := __T(__Pregex);
    text := __T(__Ptext);
    replacement := __T(__Preplacement);
    caseinsensitive := __T(__Pcaseinsensitive);
    __IsNull := __NL(__Pregex) OR __NL(__Ptext) OR __NL(__Preplacement) OR __NL(__Pcaseinsensitive);
    __Value := IF(caseinsensitive, REGEXREPLACE(regex, text, replacement, NOCASE), REGEXREPLACE(regex, text, replacement));
    RETURN __BNT(__Value,__IsNull,KEL.typ.nstr);
  END;
  EXPORT KEL.typ.nstr FN_Slim_Business_Name(KEL.typ.nstr __PBusinessName) := FUNCTION
    RETURN FN_Regex_Replace(__ECAST(KEL.typ.nstr,__CN('\\s')),__ECAST(KEL.typ.nstr,FN_Regex_Replace(__ECAST(KEL.typ.nstr,__CN('(?:^| )(?:CENTER(?:$| )|COMPANY(?:$| )|CO(?:$| )|CORP(?:$| )|CORPORATION(?:$| )|CORPORATE(?:$| )|SERVICE(?:$| )|SERVICES(?:$| )|SER(?:$| )|INC(?:$| )|INCORPORATED(?:$| )|INTL(?:$| )|INTERNATIONAL(?:$| )|GLOBAL(?:$| )|INTERCONTINENTAL(?:$| )|WORLDWIDE(?:$| )|ASSOC(?:$| )|ASS(?:$| )|ASSO(?:$| )|ASSOCIATES(?:$| )|ASSOCIATION(?:$| )|BOUTIQUE(?:$| )|INDUSTRIES(?:$| )|INDUSTRIAL(?:$| )|IND(?:$| )|ENTERPRISES(?:$| )|ENTERPRISE(?:$| )|TRADING(?:$| )|GP(?:$| )|G P(?:$| )|QA(?:$| )|Q A(?:$| )|LP(?:$| )|L P(?:$| )|LLP(?:$| )|COOP(?:$| )|FACTORY(?:$| )|GRP(?:$| )|GROUP(?:$| )|LC(?:$| )|L C(?:$| )|LLC(?:$| )|FL LLC(?:$| )|BUILDING(?:$| )|CONDOMINIUM(?:$| )|COMMISSION(?:$| )|CLUB(?:$| )|DEPT(?:$| )|DEPARTMENT(?:$| )|DEPARTMENTS(?:$| )|NATIONWIDE(?:$| )|CONTRACTORS(?:$| )|CONTRACTING(?:$| )|WORLD(?:$| )|ADVANCED(?:$| )|STORE(?:$| )|STORES(?:$| )|THE(?:$| )|OF(?:$| )|MALL(?:$| )|LTD(?:$| )|LIMITED(?:$| )|LIABILITY(?:$| )|PARTNERSHIP(?:$| )|PARTNERS(?:$| )|PARTNER(?:$| )|FRANCHISE(?:$| )|INDUSTRY(?:$| )|INDUSTRIES(?:$| )|VENTURE(?:$| )|VENTURES(?:$| )|HOLDING(?:$| )|HOLDINGS(?:$| )|GENERAL(?:$| )|AND(?:$| )|MANAGEMENT(?:$| )|MGMT(?:$| )|MFG(?:$| )|MANUFACTURING(?:$| )|COOPERATIVE(?:$| )|DBA(?:$| )|ORG(?:$| )|ORGANIZATION(?:$| )|CONTRACTOR(?:$| ))+')),__ECAST(KEL.typ.nstr,FN_Regex_Replace(__ECAST(KEL.typ.nstr,__CN('[[:punct:]]')),__ECAST(KEL.typ.nstr,__PBusinessName),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nbool,__CN(TRUE)))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nbool,__CN(TRUE)))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nbool,__CN(TRUE)));
  END;
  EXPORT KEL.typ.nfloat FN_Levenshtein_Similarity(KEL.typ.nstr __Pfield1, KEL.typ.nstr __Pfield2) := FUNCTION
    RETURN __OP2(FN_Edit_Distance(__ECAST(KEL.typ.nstr,__Pfield1),__ECAST(KEL.typ.nstr,__Pfield2)),/,KEL.Routines.MaxN(__FN1(LENGTH,__Pfield1),__FN1(LENGTH,__Pfield2)));
  END;
  EXPORT KEL.typ.nbool FN_Is_Null_Or_Equal(KEL.typ.nunk __PField1, KEL.typ.nunk __PField2) := FUNCTION
    RETURN __OR(__OP2(__PField1,=,__PField2),__AND(__NT(__PField1),__NT(__PField2)));
  END;
  EXPORT KEL.typ.nbool FN_Edit_Distance_Within_Radius(KEL.typ.nstr __Pfield1, KEL.typ.nstr __Pfield2, KEL.typ.nint __Pradius) := FUNCTION
    field1 := __T(__Pfield1);
    field2 := __T(__Pfield2);
    radius := __T(__Pradius);
    __IsNull := __NL(__Pfield1) OR __NL(__Pfield2) OR __NL(__Pradius);
    __Value := STD.Str.EditDistanceWithinRadius(field1, field2, radius);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nbool);
  END;
  EXPORT KEL.typ.nbool FN_Is_Phone7_Match(KEL.typ.nstr __PPhone1, KEL.typ.nstr __PPhone2) := FUNCTION
    RETURN FN_Edit_Distance_Within_Radius(__ECAST(KEL.typ.nstr,__PPhone1),__ECAST(KEL.typ.nstr,__PPhone2),__ECAST(KEL.typ.nint,__CN(1)));
  END;
  EXPORT KEL.typ.nbool FN_Is_Phone10_Match(KEL.typ.nstr __PPhone1, KEL.typ.nstr __PPhone2) := FUNCTION
    RETURN __OR(__OP2(__FN3(KEL.Routines.SubStr2,__PPhone1,__CN(4),__CN(10)),=,__FN3(KEL.Routines.SubStr2,__PPhone2,__CN(4),__CN(10))),FN_Edit_Distance_Within_Radius(__ECAST(KEL.typ.nstr,__PPhone1),__ECAST(KEL.typ.nstr,__PPhone2),__ECAST(KEL.typ.nint,__CN(2))));
  END;
  EXPORT KEL.typ.nbool FN_Is_Phone_Match(KEL.typ.nstr __PPhoneOnFile, KEL.typ.nstr __PInputPhone) := FUNCTION
    RETURN MAP(__T(__AND(__OP2(__FN1(LENGTH,__PPhoneOnFile),=,__CN(10)),__OP2(__FN1(LENGTH,__PInputPhone),=,__CN(10))))=>__ECAST(KEL.typ.nbool,FN_Is_Phone10_Match(__ECAST(KEL.typ.nstr,__PPhoneOnFile),__ECAST(KEL.typ.nstr,__PInputPhone))),__T(__AND(__OP2(__FN1(LENGTH,__PPhoneOnFile),=,__CN(7)),__OP2(__FN1(LENGTH,__PInputPhone),=,__CN(7))))=>__ECAST(KEL.typ.nbool,FN_Is_Phone7_Match(__ECAST(KEL.typ.nstr,__PPhoneOnFile),__ECAST(KEL.typ.nstr,__PInputPhone))),__T(__AND(__OP2(__FN1(LENGTH,__PPhoneOnFile),=,__CN(10)),__OP2(__FN1(LENGTH,__PInputPhone),=,__CN(7))))=>__ECAST(KEL.typ.nbool,FN_Is_Phone7_Match(__ECAST(KEL.typ.nstr,__FN3(KEL.Routines.SubStr2,__PPhoneOnFile,__CN(4),__CN(10))),__ECAST(KEL.typ.nstr,__PInputPhone))),__T(__AND(__OP2(__FN1(LENGTH,__PPhoneOnFile),=,__CN(7)),__OP2(__FN1(LENGTH,__PInputPhone),=,__CN(10))))=>__ECAST(KEL.typ.nbool,FN_Is_Phone10_Match(__ECAST(KEL.typ.nstr,__OP2(__FN3(KEL.Routines.SubStr2,__PInputPhone,__CN(1),__CN(3)),+,__PPhoneOnFile)),__ECAST(KEL.typ.nstr,__PInputPhone))),__ECAST(KEL.typ.nbool,__CN(FALSE)));
  END;
  EXPORT KEL.typ.nstr FN_Fn_I_P_Validate(KEL.typ.nstr __Pfield1) := FUNCTION
    field1 := __T(__Pfield1);
    __IsNull := __NL(__Pfield1);
    __Value := PublicRecords_KEL.ECL_Functions.Fn_IPValidate(field1);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nstr);
  END;
  EXPORT KEL.typ.nbool FN_Is_Fcra_Inquiry(KEL.typ.nstr __PFunctionDescription) := FUNCTION
    FunctionDescription := __T(__PFunctionDescription);
    __IsNull := __NL(__PFunctionDescription);
    __Value := PublicRecords_KEL.ECL_Functions.Common_Functions.IsFcra(FunctionDescription);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nbool);
  END;
  EXPORT KEL.typ.nbool FN_Is_Non_Fcra_Inquiry(KEL.typ.nstr __PFunctionDescription) := FUNCTION
    FunctionDescription := __T(__PFunctionDescription);
    __IsNull := __NL(__PFunctionDescription);
    __Value := PublicRecords_KEL.ECL_Functions.Common_Functions.IsNonFcra(FunctionDescription);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nbool);
  END;
  EXPORT KEL.typ.nbool FN_Is_Valid_Inquiry_Product_Code(KEL.typ.nint __PProductCode) := FUNCTION
    ProductCode := __T(__PProductCode);
    __IsNull := __NL(__PProductCode);
    __Value := (STRING)ProductCode IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes;
    RETURN __BNT(__Value,__IsNull,KEL.typ.nbool);
  END;
  EXPORT KEL.typ.nbool FN_Is_Inquiry_S_S_N_Match(KEL.typ.nstr __PSSN1, KEL.typ.nstr __PSSN2) := FUNCTION
    RETURN __OP2(__PSSN1,=,__PSSN2);
  END;
  EXPORT KEL.typ.nbool FN_Is_Inquiry_Address_Match(KEL.typ.nint __Pzip51, KEL.typ.nstr __PPrimRange1, KEL.typ.nstr __PPrimName1, KEL.typ.nstr __PSecRange1, KEL.typ.nstr __PPreDir1, KEL.typ.nstr __PSuffix1, KEL.typ.nint __Pzip52, KEL.typ.nstr __PPrimRange2, KEL.typ.nstr __PPrimName2, KEL.typ.nstr __PSecRange2, KEL.typ.nstr __PPreDir2, KEL.typ.nstr __PSuffix2) := FUNCTION
    RETURN __AND(__AND(__AND(__AND(__AND(__OP2(__Pzip51,=,__Pzip52),__CN(__DEFAULT(__PPrimRange1,'') = __DEFAULT(__PPrimRange2,''))),__CN(__DEFAULT(__PPrimName1,'') = __DEFAULT(__PPrimName2,''))),__CN(__DEFAULT(__PSecRange1,'') = __DEFAULT(__PSecRange2,''))),__CN(__DEFAULT(__PPreDir1,'') = __DEFAULT(__PPreDir2,''))),__CN(__DEFAULT(__PSuffix1,'') = __DEFAULT(__PSuffix2,'')));
  END;
  EXPORT KEL.typ.nbool FN_Is_Inquiry_Phone_Match(KEL.typ.nint __PPhone1, KEL.typ.nint __PPhone2) := FUNCTION
    RETURN __OP2(__PPhone1,=,__PPhone2);
  END;
  EXPORT KEL.typ.nbool FN_Is_D_O_B_Match(KEL.typ.nkdate __PDOB1, KEL.typ.nkdate __PDOB2) := FUNCTION
    RETURN __OP2(__PDOB1,=,__PDOB2);
  END;
  EXPORT KEL.typ.nkdate FN_Time_Stamp_To_Date(KEL.typ.ntimestamp __Px) := FUNCTION
    x := __T(__Px);
    __IsNull := __NL(__Px);
    __Value := (STRING) x[..8];
    RETURN __BNT(__Value,__IsNull,KEL.typ.nkdate);
  END;
  EXPORT KEL.typ.nbool FN_Fn___Clean___Date___Year_Filled(KEL.typ.nstr __PDateVar, KEL.typ.nint __PMinDate, KEL.typ.nint __PMaxDate, KEL.typ.nbool __PSetDef) := FUNCTION
    DateVar := __T(__PDateVar);
    MinDate := __T(__PMinDate);
    MaxDate := __T(__PMaxDate);
    SetDef := __T(__PSetDef);
    __IsNull := __NL(__PDateVar) OR __NL(__PMinDate) OR __NL(__PMaxDate) OR __NL(__PSetDef);
    __Value := PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(DateVar, MinDate, MaxDate, SetDef)[1].YearFilled;
    RETURN __BNT(__Value,__IsNull,KEL.typ.nbool);
  END;
  EXPORT KEL.typ.nbool FN_Fn___Clean___Date___Month_Filled(KEL.typ.nstr __PDateVar, KEL.typ.nint __PMinDate, KEL.typ.nint __PMaxDate, KEL.typ.nbool __PSetDef) := FUNCTION
    DateVar := __T(__PDateVar);
    MinDate := __T(__PMinDate);
    MaxDate := __T(__PMaxDate);
    SetDef := __T(__PSetDef);
    __IsNull := __NL(__PDateVar) OR __NL(__PMinDate) OR __NL(__PMaxDate) OR __NL(__PSetDef);
    __Value := PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(DateVar, MinDate, MaxDate, SetDef)[1].MonthFilled;
    RETURN __BNT(__Value,__IsNull,KEL.typ.nbool);
  END;
  EXPORT KEL.typ.nbool FN_Fn___Clean___Date___Day_Filled(KEL.typ.nstr __PDateVar, KEL.typ.nint __PMinDate, KEL.typ.nint __PMaxDate, KEL.typ.nbool __PSetDef) := FUNCTION
    DateVar := __T(__PDateVar);
    MinDate := __T(__PMinDate);
    MaxDate := __T(__PMaxDate);
    SetDef := __T(__PSetDef);
    __IsNull := __NL(__PDateVar) OR __NL(__PMinDate) OR __NL(__PMaxDate) OR __NL(__PSetDef);
    __Value := PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(DateVar, MinDate, MaxDate, SetDef)[1].DayFilled;
    RETURN __BNT(__Value,__IsNull,KEL.typ.nbool);
  END;
  EXPORT KEL.typ.nbool FN_Fn___Clean___Date___Year_Non_Zero(KEL.typ.nstr __PDateVar, KEL.typ.nint __PMinDate, KEL.typ.nint __PMaxDate, KEL.typ.nbool __PSetDef) := FUNCTION
    DateVar := __T(__PDateVar);
    MinDate := __T(__PMinDate);
    MaxDate := __T(__PMaxDate);
    SetDef := __T(__PSetDef);
    __IsNull := __NL(__PDateVar) OR __NL(__PMinDate) OR __NL(__PMaxDate) OR __NL(__PSetDef);
    __Value := PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(DateVar, MinDate, MaxDate, SetDef)[1].YearNonZero;
    RETURN __BNT(__Value,__IsNull,KEL.typ.nbool);
  END;
  EXPORT KEL.typ.nbool FN_Fn___Clean___Date___Month_Non_Zero(KEL.typ.nstr __PDateVar, KEL.typ.nint __PMinDate, KEL.typ.nint __PMaxDate, KEL.typ.nbool __PSetDef) := FUNCTION
    DateVar := __T(__PDateVar);
    MinDate := __T(__PMinDate);
    MaxDate := __T(__PMaxDate);
    SetDef := __T(__PSetDef);
    __IsNull := __NL(__PDateVar) OR __NL(__PMinDate) OR __NL(__PMaxDate) OR __NL(__PSetDef);
    __Value := PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(DateVar, MinDate, MaxDate, SetDef)[1].MonthNonZero;
    RETURN __BNT(__Value,__IsNull,KEL.typ.nbool);
  END;
  EXPORT KEL.typ.nbool FN_Fn___Clean___Date___Day_Non_Zero(KEL.typ.nstr __PDateVar, KEL.typ.nint __PMinDate, KEL.typ.nint __PMaxDate, KEL.typ.nbool __PSetDef) := FUNCTION
    DateVar := __T(__PDateVar);
    MinDate := __T(__PMinDate);
    MaxDate := __T(__PMaxDate);
    SetDef := __T(__PSetDef);
    __IsNull := __NL(__PDateVar) OR __NL(__PMinDate) OR __NL(__PMaxDate) OR __NL(__PSetDef);
    __Value := PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(DateVar, MinDate, MaxDate, SetDef)[1].DayNonZero;
    RETURN __BNT(__Value,__IsNull,KEL.typ.nbool);
  END;
  EXPORT KEL.typ.nbool FN_Fn___Clean___Date___Year_Valid(KEL.typ.nstr __PDateVar, KEL.typ.nint __PMinDate, KEL.typ.nint __PMaxDate, KEL.typ.nbool __PSetDef) := FUNCTION
    DateVar := __T(__PDateVar);
    MinDate := __T(__PMinDate);
    MaxDate := __T(__PMaxDate);
    SetDef := __T(__PSetDef);
    __IsNull := __NL(__PDateVar) OR __NL(__PMinDate) OR __NL(__PMaxDate) OR __NL(__PSetDef);
    __Value := PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(DateVar, MinDate, MaxDate, SetDef)[1].YearValid;
    RETURN __BNT(__Value,__IsNull,KEL.typ.nbool);
  END;
  EXPORT KEL.typ.nbool FN_Fn___Clean___Date___Month_Valid(KEL.typ.nstr __PDateVar, KEL.typ.nint __PMinDate, KEL.typ.nint __PMaxDate, KEL.typ.nbool __PSetDef) := FUNCTION
    DateVar := __T(__PDateVar);
    MinDate := __T(__PMinDate);
    MaxDate := __T(__PMaxDate);
    SetDef := __T(__PSetDef);
    __IsNull := __NL(__PDateVar) OR __NL(__PMinDate) OR __NL(__PMaxDate) OR __NL(__PSetDef);
    __Value := PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(DateVar, MinDate, MaxDate, SetDef)[1].MonthValid;
    RETURN __BNT(__Value,__IsNull,KEL.typ.nbool);
  END;
  EXPORT KEL.typ.nbool FN_Fn___Clean___Date___Day_Valid(KEL.typ.nstr __PDateVar, KEL.typ.nint __PMinDate, KEL.typ.nint __PMaxDate, KEL.typ.nbool __PSetDef) := FUNCTION
    DateVar := __T(__PDateVar);
    MinDate := __T(__PMinDate);
    MaxDate := __T(__PMaxDate);
    SetDef := __T(__PSetDef);
    __IsNull := __NL(__PDateVar) OR __NL(__PMinDate) OR __NL(__PMaxDate) OR __NL(__PSetDef);
    __Value := PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(DateVar, MinDate, MaxDate, SetDef)[1].DayValid;
    RETURN __BNT(__Value,__IsNull,KEL.typ.nbool);
  END;
  EXPORT KEL.typ.nbool FN_Fn___Clean___Date___Chron_State_Unknown(KEL.typ.nstr __PDateVar, KEL.typ.nint __PMinDate, KEL.typ.nint __PMaxDate, KEL.typ.nbool __PSetDef) := FUNCTION
    DateVar := __T(__PDateVar);
    MinDate := __T(__PMinDate);
    MaxDate := __T(__PMaxDate);
    SetDef := __T(__PSetDef);
    __IsNull := __NL(__PDateVar) OR __NL(__PMinDate) OR __NL(__PMaxDate) OR __NL(__PSetDef);
    __Value := PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(DateVar, MinDate, MaxDate, SetDef)[1].ChronStateUnknown;
    RETURN __BNT(__Value,__IsNull,KEL.typ.nbool);
  END;
  EXPORT KEL.typ.nstr FN_Standardize_Nickname(KEL.typ.nstr __PFirstName) := FUNCTION
    FirstName := __T(__PFirstName);
    __IsNull := __NL(__PFirstName);
    __Value := NID.PreferredFirstNew(FirstName, TRUE);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nstr);
  END;
  EXPORT KEL.typ.bool FN_Is_First_Name_Match(KEL.typ.nstr __PFirstName1, KEL.typ.nstr __PFirstName2) := FUNCTION
    RETURN MAP(__T(__OR(__NT(__PFirstName1),__NT(__PFirstName2)))=>FALSE,__T(__OP2(__PFirstName1,=,__PFirstName2))=>TRUE,__T(__OP2(FN_Standardize_Nickname(__ECAST(KEL.typ.nstr,__PFirstName1)),=,FN_Standardize_Nickname(__ECAST(KEL.typ.nstr,__PFirstName2))))=>TRUE,__T(__AND(__OP2(__FN1(LENGTH,__PFirstName1),=,__CN(1)),__FN2(KEL.Routines.StartsWith,__PFirstName2,__PFirstName1)))=>TRUE,__T(__AND(__AND(__OP2(__FN1(LENGTH,__PFirstName1),>,__CN(2)),__OP2(__FN1(LENGTH,__PFirstName2),>,__CN(2))),__OR(__OR(__OR(__FN2(KEL.Routines.EndsWith,__PFirstName1,__PFirstName2),__FN2(KEL.Routines.EndsWith,__PFirstName2,__PFirstName1)),__FN2(KEL.Routines.StartsWith,__PFirstName1,__PFirstName2)),__FN2(KEL.Routines.StartsWith,__PFirstName2,__PFirstName1))))=>TRUE,__T(__AND(__OR(__OP2(__FN1(LENGTH,__PFirstName1),>,__CN(4)),__OP2(__FN1(LENGTH,__PFirstName2),>,__CN(4))),__OP2(FN_Levenshtein_Similarity(__ECAST(KEL.typ.nstr,__PFirstName1),__ECAST(KEL.typ.nstr,__PFirstName2)),>,__CN(0.6))))=>TRUE,__T(__AND(__AND(__OP2(__FN1(LENGTH,__PFirstName1),<,__CN(5)),__OP2(__FN1(LENGTH,__PFirstName2),<,__CN(5))),__OP2(FN_Levenshtein_Similarity(__ECAST(KEL.typ.nstr,__PFirstName1),__ECAST(KEL.typ.nstr,__PFirstName2)),>,__CN(0.5))))=>TRUE,FALSE);
  END;
  EXPORT KEL.typ.bool FN_Is_Last_Name_Match(KEL.typ.nstr __PLastName1, KEL.typ.nstr __PLastName2) := FUNCTION
    RETURN MAP(__T(__OR(__NT(__PLastName1),__NT(__PLastName2)))=>FALSE,__T(__OP2(__PLastName1,=,__PLastName2))=>TRUE,__T(__AND(__AND(__OP2(__FN1(LENGTH,__PLastName1),>,__CN(2)),__OP2(__FN1(LENGTH,__PLastName2),>,__CN(2))),__OR(__OR(__OR(__FN2(KEL.Routines.EndsWith,__PLastName1,__PLastName2),__FN2(KEL.Routines.EndsWith,__PLastName2,__PLastName1)),__FN2(KEL.Routines.StartsWith,__PLastName1,__PLastName2)),__FN2(KEL.Routines.StartsWith,__PLastName2,__PLastName1))))=>TRUE,__T(__AND(__OR(__OP2(__FN1(LENGTH,__PLastName1),>,__CN(4)),__OP2(__FN1(LENGTH,__PLastName2),>,__CN(4))),__OP2(FN_Levenshtein_Similarity(__ECAST(KEL.typ.nstr,__PLastName1),__ECAST(KEL.typ.nstr,__PLastName2)),>,__CN(0.6))))=>TRUE,__T(__AND(__AND(__OP2(__FN1(LENGTH,__PLastName1),<,__CN(5)),__OP2(__FN1(LENGTH,__PLastName2),<,__CN(5))),__OP2(FN_Levenshtein_Similarity(__ECAST(KEL.typ.nstr,__PLastName1),__ECAST(KEL.typ.nstr,__PLastName2)),>,__CN(0.5))))=>TRUE,FALSE);
  END;
  EXPORT KEL.typ.nbool FN_Within_F1_Y(KEL.typ.nkdate __PInputDate, KEL.typ.nkdate __Preference) := FUNCTION
    RETURN __AND(__AND(__OP2(__PInputDate,<=,__FN4(KEL.Routines.AdjustCalendar,__Preference,__CN(-1),__CN(0),__CN(0))),__OP2(__PInputDate,>=,__FN4(KEL.Routines.AdjustCalendar,__Preference,__CN(-2),__CN(0),__CN(0)))),__FN1(KEL.Routines.IsValidDate,__PInputDate));
  END;
  EXPORT KEL.typ.nstr FN_G_E_T___V_A_L_U_E(SET OF KEL.typ.str __PValues, KEL.typ.nint __PPosition) := FUNCTION
    Values := __PValues;
    Position := __T(__PPosition);
    __IsNull := __NL(__PPosition);
    __Value := Values[Position];
    RETURN __BNT(__Value,__IsNull,KEL.typ.nstr);
  END;
  EXPORT KEL.typ.nint FN_G_E_T___S_T_O_R_E_D___G_L_B_P_U_R_P_O_S_E(KEL.typ.nstr __PStoredName) := FUNCTION
    StoredName := __T(__PStoredName);
    __IsNull := __NL(__PStoredName);
    __Value := PublicRecords_KEL.MAS_get.MASGateway.GatewayFunctions.GrabGLBPurpose(StoredName);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nint);
  END;
  EXPORT KEL.typ.nint FN_G_E_T___S_T_O_R_E_D___D_P_P_A_P_U_R_P_O_S_E(KEL.typ.nstr __PStoredName) := FUNCTION
    StoredName := __T(__PStoredName);
    __IsNull := __NL(__PStoredName);
    __Value := PublicRecords_KEL.MAS_get.MASGateway.GatewayFunctions.GrabDPPAPurpose(StoredName);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nint);
  END;
  EXPORT KEL.typ.nstr FN_G_E_T___S_T_O_R_E_D___W_A_T_C_H_L_I_S_T_S___R_E_Q_U_E_S_T_E_D(KEL.typ.nstr __PStoredName) := FUNCTION
    StoredName := __T(__PStoredName);
    __IsNull := __NL(__PStoredName);
    __Value := PublicRecords_KEL.MAS_get.MASGateway.GatewayFunctions.GrabWatchlistsRequested(StoredName);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nstr);
  END;
  EXPORT KEL.typ.nbool FN_G_E_T___S_T_O_R_E_D___I_N_C_L_U_D_E___O_F_A_C(KEL.typ.nstr __PStoredName) := FUNCTION
    StoredName := __T(__PStoredName);
    __IsNull := __NL(__PStoredName);
    __Value := PublicRecords_KEL.MAS_get.MASGateway.GatewayFunctions.GrabIncludeOFAC(StoredName);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nbool);
  END;
  EXPORT KEL.typ.nbool FN_G_E_T___S_T_O_R_E_D___I_N_C_L_U_D_E___A_D_D_I_T_I_O_N_A_L___W_A_T_C_H_L_I_S_T_S(KEL.typ.nstr __PStoredName) := FUNCTION
    StoredName := __T(__PStoredName);
    __IsNull := __NL(__PStoredName);
    __Value := PublicRecords_KEL.MAS_get.MASGateway.GatewayFunctions.GrabIncludeAdditionalWatchlists(StoredName);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nbool);
  END;
  EXPORT KEL.typ.nfloat FN_G_E_T___S_T_O_R_E_D___G_L_O_B_A_L___W_A_T_C_H_L_I_S_T___T_H_R_E_S_H_O_L_D(KEL.typ.nstr __PStoredName) := FUNCTION
    StoredName := __T(__PStoredName);
    __IsNull := __NL(__PStoredName);
    __Value := PublicRecords_KEL.MAS_get.MASGateway.GatewayFunctions.GrabGlobalWatchlistThreshold(StoredName);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nfloat);
  END;
  EXPORT KEL.typ.nbool FN_G_E_T___S_T_O_R_E_D___I_S___F_C_R_A(KEL.typ.nstr __PStoredName) := FUNCTION
    StoredName := __T(__PStoredName);
    __IsNull := __NL(__PStoredName);
    __Value := PublicRecords_KEL.MAS_get.MASGateway.GatewayFunctions.GrabIsFCRA(StoredName);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nbool);
  END;
  EXPORT KEL.typ.nstr FN_G_E_T___N_E_T_A_C_U_I_T_Y___U_R_L(KEL.typ.nstr __PStoredName) := FUNCTION
    StoredName := __T(__PStoredName);
    __IsNull := __NL(__PStoredName);
    __Value := PublicRecords_KEL.MAS_get.MASGateway.NetAcuityFunctions.GrabNetAcuityURL(StoredName);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nstr);
  END;
  EXPORT SET OF KEL.typ.str FN_G_A_T_E_W_A_Y___N_E_T_A_C_U_I_T_Y(KEL.typ.nstr __PIPAddress, KEL.typ.nstr __PLexID, KEL.typ.nstr __PGatewayURL, KEL.typ.nint __PDPPAPurpose, KEL.typ.nint __PGLBPurpose) := FUNCTION
    IPAddress := __T(__PIPAddress);
    LexID := __T(__PLexID);
    GatewayURL := __T(__PGatewayURL);
    DPPAPurpose := __T(__PDPPAPurpose);
    GLBPurpose := __T(__PGLBPurpose);
    __Value := PublicRecords_KEL.MAS_get.MASGateway.NetAcuityFunctions.NetAcuityWrapper(IPAddress, LexID, GatewayURL, DPPAPurpose, GLBPurpose);
    RETURN __Value;
  END;
  EXPORT KEL.typ.nint FN_G_E_T___N_E_T_A_C_U_I_T_Y___R_O_Y_A_L_T_I_E_S(KEL.typ.nstr __PIPAddress, KEL.typ.nstr __PIPType) := FUNCTION
    IPAddress := __T(__PIPAddress);
    IPType := __T(__PIPType);
    __IsNull := __NL(__PIPAddress) OR __NL(__PIPType);
    __Value := Royalty.RoyaltyNetAcuity.GetCount(TRIM(IPAddress), TRIM(IPType));
    RETURN __BNT(__Value,__IsNull,KEL.typ.nint);
  END;
  EXPORT KEL.typ.nstr FN_G_E_T___O_F_A_C___U_R_L(KEL.typ.nstr __PStoredName) := FUNCTION
    StoredName := __T(__PStoredName);
    __IsNull := __NL(__PStoredName);
    __Value := PublicRecords_KEL.MAS_get.MASGateway.OFACWatchlistsFunctions.GrabOFACURL(StoredName);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nstr);
  END;
  EXPORT SET OF KEL.typ.str FN_G_A_T_E_W_A_Y___O_F_A_C(KEL.typ.nstr __PGatewayURL, KEL.typ.nstr __PFirstName, KEL.typ.nstr __PMiddleName, KEL.typ.nstr __PLastName, KEL.typ.nstr __PDateOfBirth, KEL.typ.nbool __PIncludeOFAC, KEL.typ.nbool __PIncludeAdditionalWatchlists, KEL.typ.nfloat __PGlobalWatchlistThreshold, KEL.typ.nstr __PWatchlistsRequested) := FUNCTION
    GatewayURL := __T(__PGatewayURL);
    FirstName := __T(__PFirstName);
    MiddleName := __T(__PMiddleName);
    LastName := __T(__PLastName);
    DateOfBirth := __T(__PDateOfBirth);
    IncludeOFAC := __T(__PIncludeOFAC);
    IncludeAdditionalWatchlists := __T(__PIncludeAdditionalWatchlists);
    GlobalWatchlistThreshold := __T(__PGlobalWatchlistThreshold);
    WatchlistsRequested := __T(__PWatchlistsRequested);
    __Value := PublicRecords_KEL.MAS_get.MASGateway.OFACWatchlistsFunctions.OFACWatchlistsWrapper(GatewayURL, FirstName, MiddleName, LastName, DateOfBirth, IncludeOFAC, IncludeAdditionalWatchlists, GlobalWatchlistThreshold, WatchlistsRequested);
    RETURN __Value;
  END;
  EXPORT KEL.typ.nstr FN_G_E_T___T_A_R_G_U_S___U_R_L(KEL.typ.nstr __PStoredName) := FUNCTION
    StoredName := __T(__PStoredName);
    __IsNull := __NL(__PStoredName);
    __Value := PublicRecords_KEL.MAS_get.MASGateway.TargusFunctions.GrabTargusURL(StoredName);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nstr);
  END;
  EXPORT SET OF KEL.typ.str FN_G_A_T_E_W_A_Y___T_A_R_G_U_S(KEL.typ.nstr __PGatewayURL, KEL.typ.nstr __PFirstName, KEL.typ.nstr __PLastName, KEL.typ.nstr __PPhone10, KEL.typ.nint __PDPPAPurpose, KEL.typ.nint __PGLBPurpose, KEL.typ.nbool __PIsFCRA) := FUNCTION
    GatewayURL := __T(__PGatewayURL);
    FirstName := __T(__PFirstName);
    LastName := __T(__PLastName);
    Phone10 := __T(__PPhone10);
    DPPAPurpose := __T(__PDPPAPurpose);
    GLBPurpose := __T(__PGLBPurpose);
    IsFCRA := __T(__PIsFCRA);
    __Value := PublicRecords_KEL.MAS_get.MASGateway.TargusFunctions.TargusWrapper(GatewayURL, FirstName, LastName, Phone10, DPPAPurpose, GLBPurpose, IsFCRA);
    RETURN __Value;
  END;
  EXPORT KEL.typ.nstr FN_G_E_T___I_N_S_U_R_A_N_C_E___P_H_O_N_E___U_R_L(KEL.typ.nstr __PStoredName) := FUNCTION
    StoredName := __T(__PStoredName);
    __IsNull := __NL(__PStoredName);
    __Value := PublicRecords_KEL.MAS_get.MASGateway.InsurancePhoneFunctions.GrabInsurancePhoneURL(StoredName);
    RETURN __BNT(__Value,__IsNull,KEL.typ.nstr);
  END;
  EXPORT SET OF KEL.typ.str FN_G_A_T_E_W_A_Y___I_N_S_U_R_A_N_C_E___P_H_O_N_E(KEL.typ.nstr __PGatewayURL, KEL.typ.nstr __PFirstName, KEL.typ.nstr __PLastName, KEL.typ.nstr __PStreetAddress, KEL.typ.nstr __PCity, KEL.typ.nstr __PState, KEL.typ.nstr __PZip, KEL.typ.nstr __PPhone10, KEL.typ.nint __PGLBPurpose, KEL.typ.nbool __PIsFCRA) := FUNCTION
    GatewayURL := __T(__PGatewayURL);
    FirstName := __T(__PFirstName);
    LastName := __T(__PLastName);
    StreetAddress := __T(__PStreetAddress);
    City := __T(__PCity);
    State := __T(__PState);
    Zip := __T(__PZip);
    Phone10 := __T(__PPhone10);
    GLBPurpose := __T(__PGLBPurpose);
    IsFCRA := __T(__PIsFCRA);
    __Value := PublicRecords_KEL.MAS_get.MASGateway.InsurancePhoneFunctions.InsurancePhoneWrapper(GatewayURL, FirstName, LastName, StreetAddress, City, State, Zip, Phone10, GLBPurpose, IsFCRA);
    RETURN __Value;
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
