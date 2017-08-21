EXPORT Key_HealthProvider_ADDRESS := MODULE
IMPORT SALT29,ut,std;
//PRIM_RANGE:PRIM_NAME:ZIP:?:SEC_RANGE:FNAME:+:V_CITY_NAME:ST:GENDER:LNAME:MNAME:SNAME:DOB:C_LIC_NBR:LIC_STATE:BILLING_TAX_ID
EXPORT KeyName := PRTE_Health_Provider_Services.Files.FILE_Address; //'~'+'key::PRTE_Health_Provider_Services::LNPID::Refs::ADDRESS';
SHARED h := CandidatesForKey;//The input file - distributed by LNPID
layout := RECORD // project out required fields
// Compulsory fields
  h.PRIM_RANGE;
  h.PRIM_NAME;
  h.ZIP;
// Optional fields
  h.LNPID; // The ID field
  h.SEC_RANGE;
  h.FNAME_PreferredName;
  h.FNAME;
// Extra credit fields
  h.V_CITY_NAME;
  h.ST;
  h.GENDER;
  h.LNAME;
  h.MNAME;
  h.SNAME;
  h.DOB_year;
  h.DOB_month;
  h.DOB_day;
  h.C_LIC_NBR;
  h.LIC_STATE;
  h.BILLING_TAX_ID;
//Scores for various field components
  h.PRIM_RANGE_weight100 ; // Contains 100x the specificity
  h.PRIM_NAME_weight100 ; // Contains 100x the specificity
  h.ZIP_weight100 ; // Contains 100x the specificity
  h.SEC_RANGE_weight100 ; // Contains 100x the specificity
  h.FNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_p_Weight100;
  h.FNAME_e1_Weight100;
  h.FNAME_e1p_Weight100;
  h.FNAME_PreferredName_Weight100;
  h.FNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.V_CITY_NAME_weight100 ; // Contains 100x the specificity
  h.ST_weight100 ; // Contains 100x the specificity
  h.GENDER_weight100 ; // Contains 100x the specificity
  h.LNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_p_Weight100;
  h.LNAME_e1_Weight100;
  h.LNAME_e1p_Weight100;
  h.LNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.MNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_e2_Weight100;
  h.MNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.SNAME_weight100 ; // Contains 100x the specificity
  h.DOB_year_weight100 ; // Contains 100x the specificity
  h.DOB_month_weight100 ; // Contains 100x the specificity
  h.DOB_day_weight100 ; // Contains 100x the specificity
  h.C_LIC_NBR_weight100 ; // Contains 100x the specificity
  INTEGER2 C_LIC_NBR_e1_Weight100 := SALT29.Min0(h.C_LIC_NBR_weight100 + 100*log(h.C_LIC_NBR_cnt/h.C_LIC_NBR_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.LIC_STATE_weight100 ; // Contains 100x the specificity
  h.BILLING_TAX_ID_weight100 ; // Contains 100x the specificity
  INTEGER2 FNAME_initial_weight100 := 0; // Weight if only first character matches
  INTEGER2 MNAME_initial_weight100 := 0; // Weight if only first character matches
END;
s := Specificities(File_HealthProvider).Specificities[1];
DataForKey0 := DEDUP(SORT(TABLE(h(PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE),PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME),ZIP NOT IN SET(s.nulls_ZIP,ZIP)),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
layout note_init4(layout le,Specificities(File_HealthProvider).FNAME_values_persisted ri) := TRANSFORM
  SELF.FNAME_initial_weight100 := ri.field_specificity * 100;
  SELF := le;
END;
DataForKey1 := JOIN(DataForKey0,Specificities(File_HealthProvider).FNAME_values_persisted(LENGTH(TRIM(FNAME))=1),LEFT.FNAME[1]=RIGHT.FNAME[1],note_init4(LEFT,RIGHT),LOOKUP,LEFT OUTER); // Append specificities for initials of FNAME
layout note_init9(layout le,Specificities(File_HealthProvider).MNAME_values_persisted ri) := TRANSFORM
  SELF.MNAME_initial_weight100 := ri.field_specificity * 100;
  SELF := le;
END;
DataForKey2 := JOIN(DataForKey1,Specificities(File_HealthProvider).MNAME_values_persisted(LENGTH(TRIM(MNAME))=1),LEFT.MNAME[1]=RIGHT.MNAME[1],note_init9(LEFT,RIGHT),LOOKUP,LEFT OUTER); // Append specificities for initials of MNAME
EXPORT Key := INDEX(DataForKey2,,KeyName);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,LNPID,PRIM_RANGE,PRIM_NAME,ZIP,SEC_RANGE,FNAME,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_V_CITY_NAME := GROUP( DEDUP( SORT( Grpd, EXCEPT V_CITY_NAME), EXCEPT V_CITY_NAME));
  CntRed_V_CITY_NAME := (KeyCnt-COUNT(Rem_V_CITY_NAME))/KeyCnt;
  Rem_ST := GROUP( DEDUP( SORT( Grpd, EXCEPT ST), EXCEPT ST));
  CntRed_ST := (KeyCnt-COUNT(Rem_ST))/KeyCnt;
  Rem_GENDER := GROUP( DEDUP( SORT( Grpd, EXCEPT GENDER), EXCEPT GENDER));
  CntRed_GENDER := (KeyCnt-COUNT(Rem_GENDER))/KeyCnt;
  Rem_LNAME := GROUP( DEDUP( SORT( Grpd, EXCEPT LNAME), EXCEPT LNAME));
  CntRed_LNAME := (KeyCnt-COUNT(Rem_LNAME))/KeyCnt;
  Rem_MNAME := GROUP( DEDUP( SORT( Grpd, EXCEPT MNAME), EXCEPT MNAME));
  CntRed_MNAME := (KeyCnt-COUNT(Rem_MNAME))/KeyCnt;
  Rem_SNAME := GROUP( DEDUP( SORT( Grpd, EXCEPT SNAME), EXCEPT SNAME));
  CntRed_SNAME := (KeyCnt-COUNT(Rem_SNAME))/KeyCnt;
  Rem_DOB := GROUP( DEDUP( SORT( Grpd, EXCEPT DOB_year,DOB_month,DOB_day), EXCEPT DOB_year,DOB_month,DOB_day));
  CntRed_DOB := (KeyCnt-COUNT(Rem_DOB))/KeyCnt;
  Rem_C_LIC_NBR := GROUP( DEDUP( SORT( Grpd, EXCEPT C_LIC_NBR), EXCEPT C_LIC_NBR));
  CntRed_C_LIC_NBR := (KeyCnt-COUNT(Rem_C_LIC_NBR))/KeyCnt;
  Rem_LIC_STATE := GROUP( DEDUP( SORT( Grpd, EXCEPT LIC_STATE), EXCEPT LIC_STATE));
  CntRed_LIC_STATE := (KeyCnt-COUNT(Rem_LIC_STATE))/KeyCnt;
  Rem_BILLING_TAX_ID := GROUP( DEDUP( SORT( Grpd, EXCEPT BILLING_TAX_ID), EXCEPT BILLING_TAX_ID));
  CntRed_BILLING_TAX_ID := (KeyCnt-COUNT(Rem_BILLING_TAX_ID))/KeyCnt;
EXPORT Shrinkage := DATASET([{'ADDRESS','V_CITY_NAME',CntRed_V_CITY_NAME*100,CntRed_V_CITY_NAME*TSize},{'ADDRESS','ST',CntRed_ST*100,CntRed_ST*TSize},{'ADDRESS','GENDER',CntRed_GENDER*100,CntRed_GENDER*TSize},{'ADDRESS','LNAME',CntRed_LNAME*100,CntRed_LNAME*TSize},{'ADDRESS','MNAME',CntRed_MNAME*100,CntRed_MNAME*TSize},{'ADDRESS','SNAME',CntRed_SNAME*100,CntRed_SNAME*TSize},{'ADDRESS','DOB',CntRed_DOB*100,CntRed_DOB*TSize},{'ADDRESS','C_LIC_NBR',CntRed_C_LIC_NBR*100,CntRed_C_LIC_NBR*TSize},{'ADDRESS','LIC_STATE',CntRed_LIC_STATE*100,CntRed_LIC_STATE*TSize},{'ADDRESS','BILLING_TAX_ID',CntRed_BILLING_TAX_ID*100,CntRed_BILLING_TAX_ID*TSize}],SALT29.ShrinkLayout);
EXPORT CanSearch(Process_xLNPID_Layouts.InputLayout le) := le.PRIM_RANGE <> (typeof(le.PRIM_RANGE))'' AND le.PRIM_NAME <> (typeof(le.PRIM_NAME))'' AND le.ZIP <> (typeof(le.ZIP))'';
KeyRec := RECORDOF(Key);
EXPORT RawFetch(TYPEOF(h.PRIM_RANGE) param_PRIM_RANGE,TYPEOF(h.PRIM_NAME) param_PRIM_NAME,TYPEOF(h.ZIP) param_ZIP,TYPEOF(h.SEC_RANGE) param_SEC_RANGE,TYPEOF(h.FNAME) param_FNAME) := 
    STEPPED( LIMIT( Key(
          ( PRIM_RANGE = param_PRIM_RANGE AND param_PRIM_RANGE <> (TYPEOF(PRIM_RANGE))'' )
      AND ( PRIM_NAME = param_PRIM_NAME AND param_PRIM_NAME <> (TYPEOF(PRIM_NAME))'' )
      AND ( ZIP = param_ZIP AND param_ZIP <> (TYPEOF(ZIP))'' )
      AND ( SEC_RANGE = (TYPEOF(SEC_RANGE))'' OR param_SEC_RANGE = (TYPEOF(SEC_RANGE))'' OR SALT29.HyphenMatch(SEC_RANGE,param_SEC_RANGE,1)<=2  )
      AND ( FNAME[1..LENGTH(TRIM(param_FNAME))] = param_FNAME OR param_FNAME[1..LENGTH(TRIM(FNAME))] = FNAME  OR FNAME_PreferredName = fn_PreferredName(param_FNAME) OR metaphonelib.DMetaPhone1(FNAME)=metaphonelib.DMetaPhone1(param_FNAME) OR SALT29.WithinEditN(FNAME,param_FNAME,1, 0)  )),10000,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),LNPID);
EXPORT ScoredLNPIDFetch(TYPEOF(h.PRIM_RANGE) param_PRIM_RANGE,TYPEOF(h.PRIM_NAME) param_PRIM_NAME,TYPEOF(h.ZIP) param_ZIP,TYPEOF(h.SEC_RANGE) param_SEC_RANGE,TYPEOF(h.FNAME) param_FNAME,TYPEOF(h.V_CITY_NAME) param_V_CITY_NAME,TYPEOF(h.ST) param_ST,TYPEOF(h.GENDER) param_GENDER,TYPEOF(h.LNAME) param_LNAME,TYPEOF(h.MNAME) param_MNAME,TYPEOF(h.SNAME) param_SNAME,UNSIGNED4 param_DOB,TYPEOF(h.C_LIC_NBR) param_C_LIC_NBR,TYPEOF(h.LIC_STATE) param_LIC_STATE,TYPEOF(h.BILLING_TAX_ID) param_BILLING_TAX_ID) := FUNCTION
  RawData := RawFetch(param_PRIM_RANGE,param_PRIM_NAME,param_ZIP,param_SEC_RANGE,param_FNAME);
  Process_xLNPID_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 6; // Set bitmap for key used
    SELF.keys_failed := IF(le.LNPID = 0, 1 << 6, 0); // Set bitmap for key failed
    SELF.PRIM_RANGE_match_code := MAP(
		le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_PRIM_RANGE(le.PRIM_RANGE,param_PRIM_RANGE,TRUE));
    SELF.PRIM_RANGEWeight := (50+MAP ( le.PRIM_RANGE = param_PRIM_RANGE  => le.PRIM_RANGE_weight100,
          le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR param_PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' => 0,
           -0.447*le.PRIM_RANGE_weight100))/100; 
    SELF.PRIM_NAME_match_code := MAP(
		le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_PRIM_NAME(le.PRIM_NAME,param_PRIM_NAME,TRUE));
    SELF.PRIM_NAMEWeight := (50+MAP ( le.PRIM_NAME = param_PRIM_NAME  => le.PRIM_NAME_weight100,
          le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR param_PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' => 0,
           -0.431*le.PRIM_NAME_weight100))/100; 
    SELF.ZIP_match_code := MAP(
		le.ZIP = (TYPEOF(le.ZIP))'' OR le.ZIP = (TYPEOF(le.ZIP))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_ZIP(le.ZIP,param_ZIP,TRUE));
    SELF.ZIPWeight := (50+MAP ( le.ZIP = param_ZIP  => le.ZIP_weight100,
          le.ZIP = (TYPEOF(le.ZIP))'' OR param_ZIP = (TYPEOF(le.ZIP))'' => 0,
           -0.495*le.ZIP_weight100))/100; 
    SELF.SEC_RANGE_match_code := MAP(
		le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR param_SEC_RANGE = (TYPEOF(param_SEC_RANGE))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_SEC_RANGE(le.SEC_RANGE,param_SEC_RANGE,FALSE));
    SELF.SEC_RANGEWeight := (50+MAP ( le.SEC_RANGE = param_SEC_RANGE  => le.SEC_RANGE_weight100,
           le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR param_SEC_RANGE = (TYPEOF(param_SEC_RANGE))'' => 0,
           SALT29.HyphenMatch(le.SEC_RANGE,param_SEC_RANGE,1)<=2 => le.SEC_RANGE_weight100*MIN(1,LENGTH(TRIM(param_SEC_RANGE))/LENGTH(TRIM(le.SEC_RANGE))),
           -0.582*le.SEC_RANGE_weight100))/100; 
    SELF.FNAME_match_code := MAP(
		le.FNAME = (TYPEOF(le.FNAME))'' OR param_FNAME = (TYPEOF(param_FNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_FNAME(le.FNAME,param_FNAME,FALSE));
    SELF.FNAMEWeight := (50+MAP ( le.FNAME = param_FNAME  => le.FNAME_weight100,
           le.FNAME_PreferredName = fn_PreferredName(param_FNAME) => le.FNAME_PreferredName_weight100,
           le.FNAME = (TYPEOF(le.FNAME))'' OR param_FNAME = (TYPEOF(param_FNAME))'' => 0,
           le.FNAME = param_FNAME[1..LENGTH(TRIM(le.FNAME))] => le.FNAME_weight100,
           SALT29.WithinEditN(le.FNAME,param_FNAME,1, 0) => IF( metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(param_FNAME),le.FNAME_e1p_weight100,le.FNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(param_FNAME)=>le.FNAME_p_weight100,
           le.FNAME[1..LENGTH(TRIM(param_FNAME))] = param_FNAME => SALT29.Fn_Interpolate_Initial(le.FNAME,param_FNAME,le.FNAME_weight100,le.FNAME_initial_weight100), // later in sequence as less accurate
           -0.961*le.FNAME_weight100))/100; 
    SELF.V_CITY_NAME_match_code := MAP(
		le.V_CITY_NAME = (TYPEOF(le.V_CITY_NAME))'' OR param_V_CITY_NAME = (TYPEOF(param_V_CITY_NAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_V_CITY_NAME(le.V_CITY_NAME,param_V_CITY_NAME,FALSE));
    SELF.V_CITY_NAMEWeight := (50+MAP ( le.V_CITY_NAME = param_V_CITY_NAME  => le.V_CITY_NAME_weight100,
           le.V_CITY_NAME = (TYPEOF(le.V_CITY_NAME))'' OR param_V_CITY_NAME = (TYPEOF(param_V_CITY_NAME))'' => 0,
           -0.562*le.V_CITY_NAME_weight100))/100; 
    SELF.ST_match_code := MAP(
		le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_ST(le.ST,param_ST,FALSE));
    SELF.STWeight := (50+MAP ( le.ST = param_ST  => le.ST_weight100,
           le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' => 0,
           -0.823*le.ST_weight100))/100; 
    SELF.GENDER_match_code := MAP(
		le.GENDER = (TYPEOF(le.GENDER))'' OR param_GENDER = (TYPEOF(param_GENDER))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_GENDER(le.GENDER,param_GENDER,FALSE));
    SELF.GENDERWeight := (50+MAP ( le.GENDER = param_GENDER  => le.GENDER_weight100,
           le.GENDER = (TYPEOF(le.GENDER))'' OR param_GENDER = (TYPEOF(param_GENDER))'' => 0,
           -0.987*le.GENDER_weight100))/100; 
    SELF.LNAME_match_code := MAP(
		le.LNAME = (TYPEOF(le.LNAME))'' OR param_LNAME = (TYPEOF(param_LNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_LNAME(le.LNAME,param_LNAME,FALSE));
    SELF.LNAMEWeight := (50+MAP ( le.LNAME = param_LNAME  => le.LNAME_weight100,
           le.LNAME = (TYPEOF(le.LNAME))'' OR param_LNAME = (TYPEOF(param_LNAME))'' => 0,
           SALT29.WithinEditN(le.LNAME,param_LNAME,1, 0) => IF( metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(param_LNAME),le.LNAME_e1p_weight100,le.LNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(param_LNAME)=>le.LNAME_p_weight100,
           SALT29.HyphenMatch(le.LNAME,param_LNAME,1)<=2 => le.LNAME_weight100*MIN(1,LENGTH(TRIM(param_LNAME))/LENGTH(TRIM(le.LNAME))),
           -0.874*le.LNAME_weight100))/100; 
    SELF.MNAME_match_code := MAP(
		le.MNAME = (TYPEOF(le.MNAME))'' OR param_MNAME = (TYPEOF(param_MNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_MNAME(le.MNAME,param_MNAME,FALSE));
    SELF.MNAMEWeight := (50+MAP ( le.MNAME = param_MNAME  => le.MNAME_weight100,
           le.MNAME = (TYPEOF(le.MNAME))'' OR param_MNAME = (TYPEOF(param_MNAME))'' => 0,
           le.MNAME = param_MNAME[1..LENGTH(TRIM(le.MNAME))] => le.MNAME_weight100,
           SALT29.WithinEditN(le.MNAME,param_MNAME,2, 0) => le.MNAME_e2_weight100,
           le.MNAME[1..LENGTH(TRIM(param_MNAME))] = param_MNAME => SALT29.Fn_Interpolate_Initial(le.MNAME,param_MNAME,le.MNAME_weight100,le.MNAME_initial_weight100), // later in sequence as less accurate
           -0.932*le.MNAME_weight100))/100; 
    SELF.SNAME_match_code := MAP(
		le.SNAME = (TYPEOF(le.SNAME))'' OR param_SNAME = (TYPEOF(param_SNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_SNAME(le.SNAME,param_SNAME,FALSE));
    SELF.SNAMEWeight := (50+MAP ( le.SNAME = param_SNAME  => le.SNAME_weight100,
           le.SNAME = (TYPEOF(le.SNAME))'' OR param_SNAME = (TYPEOF(param_SNAME))'' => 0,
           -0.990*le.SNAME_weight100))/100; 
    SELF.DOB_year_match_code := MAP(
		le.DOB_year = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT29.MatchCode.OneSideNull,
		match_methods(File_HealthProvider).match_DOB_year(le.DOB_year,((UNSIGNED)param_DOB) DIV 10000));
    SELF.DOB_month_match_code := MAP(
		le.DOB_month = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT29.MatchCode.OneSideNull,
		match_methods(File_HealthProvider).match_DOB_month(le.DOB_month,((UNSIGNED)param_DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)param_DOB) % 100));
    SELF.DOB_day_match_code := MAP(
		le.DOB_day = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT29.MatchCode.OneSideNull,
		match_methods(File_HealthProvider).match_DOB_day(le.DOB_month,((UNSIGNED)param_DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)param_DOB) % 100));
    SELF.DOBWeight_year := (50+MAP ( le.DOB_year = 0 OR ((UNSIGNED)param_DOB) DIV 10000 = 0 => 0,
       le.DOB_year = ((UNSIGNED)param_DOB) DIV 10000  => le.DOB_year_weight100,
       -0.995*le.DOB_year_weight100))/100;
    SELF.DOBWeight_month := (50+MAP ( le.DOB_month = 0 OR ((UNSIGNED)param_DOB) DIV 100 % 100 = 0 => 0,
      le.DOB_month = ((UNSIGNED)param_DOB) DIV 100 % 100  => le.DOB_month_weight100,
       -0.995*le.DOB_month_weight100))/100;
    SELF.DOBWeight_day := (50+MAP ( le.DOB_day = 0 OR ((UNSIGNED)param_DOB) % 100 = 0 => 0,
      le.DOB_day = ((UNSIGNED)param_DOB) % 100  => le.DOB_day_weight100,
       -0.995*le.DOB_day_weight100))/100;
    SELF.DOBWeight := (SELF.DOBWeight_year+SELF.DOBWeight_month+SELF.DOBWeight_day); 
    SELF.C_LIC_NBR_match_code := MAP(
		le.C_LIC_NBR = (TYPEOF(le.C_LIC_NBR))'' OR param_C_LIC_NBR = (TYPEOF(param_C_LIC_NBR))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_C_LIC_NBR(le.C_LIC_NBR,param_C_LIC_NBR,FALSE));
    SELF.C_LIC_NBRWeight := (50+MAP ( le.C_LIC_NBR = param_C_LIC_NBR  => le.C_LIC_NBR_weight100,
           le.C_LIC_NBR = (TYPEOF(le.C_LIC_NBR))'' OR param_C_LIC_NBR = (TYPEOF(param_C_LIC_NBR))'' => 0,
           SALT29.WithinEditN(le.C_LIC_NBR,param_C_LIC_NBR,1, 0) => le.C_LIC_NBR_e1_weight100,
           -0.671*le.C_LIC_NBR_weight100))/100; 
    SELF.LIC_STATE_match_code := MAP(
		le.LIC_STATE = (TYPEOF(le.LIC_STATE))'' OR param_LIC_STATE = (TYPEOF(param_LIC_STATE))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_LIC_STATE(le.LIC_STATE,param_LIC_STATE,FALSE));
    SELF.LIC_STATEWeight := (50+MAP ( le.LIC_STATE = param_LIC_STATE  => le.LIC_STATE_weight100,
           le.LIC_STATE = (TYPEOF(le.LIC_STATE))'' OR param_LIC_STATE = (TYPEOF(param_LIC_STATE))'' => 0,
           -0.810*le.LIC_STATE_weight100))/100; 
    SELF.BILLING_TAX_ID_match_code := MAP(
		le.BILLING_TAX_ID = (TYPEOF(le.BILLING_TAX_ID))'' OR param_BILLING_TAX_ID = (TYPEOF(param_BILLING_TAX_ID))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_BILLING_TAX_ID(le.BILLING_TAX_ID,param_BILLING_TAX_ID,FALSE));
    SELF.BILLING_TAX_IDWeight := (50+MAP ( le.BILLING_TAX_ID = param_BILLING_TAX_ID  => le.BILLING_TAX_ID_weight100,
           le.BILLING_TAX_ID = (TYPEOF(le.BILLING_TAX_ID))'' OR param_BILLING_TAX_ID = (TYPEOF(param_BILLING_TAX_ID))'' => 0,
           -0.392*le.BILLING_TAX_ID_weight100))/100*0.75; 
    SELF.Weight :=MAX(0,SELF.PRIM_RANGEWeight) + MAX(0,SELF.PRIM_NAMEWeight) + MAX(0,SELF.ZIPWeight) + MAX(0,SELF.SEC_RANGEWeight) + MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.V_CITY_NAMEWeight) + MAX(0,SELF.STWeight) + MAX(0,SELF.GENDERWeight) + MAX(0,SELF.LNAMEWeight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.SNAMEWeight) + MAX(0,SELF.DOBWeight) + MAX(0,SELF.C_LIC_NBRWeight) + MAX(0,SELF.LIC_STATEWeight) + MAX(0,SELF.BILLING_TAX_IDWeight);
    SELF := le;
  END;
  RETURN ROLLUP(PROJECT(NOFOLD(RawData),Score(LEFT)),LEFT.LNPID = RIGHT.LNPID,Process_xLNPID_Layouts.combine_scores(LEFT,RIGHT));
END;
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT29.UIDType Reference;//How to recognize this record in the subsequent
  TYPEOF(h.PRIM_RANGE) PRIM_RANGE := (TYPEOF(h.PRIM_RANGE))'';
  TYPEOF(h.PRIM_NAME) PRIM_NAME := (TYPEOF(h.PRIM_NAME))'';
  TYPEOF(h.ZIP) ZIP := (TYPEOF(h.ZIP))'';
  TYPEOF(h.SEC_RANGE) SEC_RANGE := (TYPEOF(h.SEC_RANGE))'';
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))'';
  TYPEOF(h.V_CITY_NAME) V_CITY_NAME := (TYPEOF(h.V_CITY_NAME))'';
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))'';
  TYPEOF(h.GENDER) GENDER := (TYPEOF(h.GENDER))'';
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))'';
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))'';
  TYPEOF(h.SNAME) SNAME := (TYPEOF(h.SNAME))'';
  unsigned4 DOB := 0;
  TYPEOF(h.C_LIC_NBR) C_LIC_NBR := (TYPEOF(h.C_LIC_NBR))'';
  TYPEOF(h.LIC_STATE) LIC_STATE := (TYPEOF(h.LIC_STATE))'';
  TYPEOF(h.BILLING_TAX_ID) BILLING_TAX_ID := (TYPEOF(h.BILLING_TAX_ID))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex) := FUNCTION
  Process_xLNPID_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 6; // Set bitmap for key used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.PRIM_RANGE_match_code := MAP(
		le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_PRIM_RANGE(le.PRIM_RANGE,ri.PRIM_RANGE,TRUE));
    SELF.PRIM_RANGEWeight := (50+MAP ( le.PRIM_RANGE = ri.PRIM_RANGE  => le.PRIM_RANGE_weight100,
          le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR ri.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' => 0,
           -0.447*le.PRIM_RANGE_weight100))/100; 
    SELF.PRIM_NAME_match_code := MAP(
		le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_PRIM_NAME(le.PRIM_NAME,ri.PRIM_NAME,TRUE));
    SELF.PRIM_NAMEWeight := (50+MAP ( le.PRIM_NAME = ri.PRIM_NAME  => le.PRIM_NAME_weight100,
          le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR ri.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' => 0,
           -0.431*le.PRIM_NAME_weight100))/100; 
    SELF.ZIP_match_code := MAP(
		le.ZIP = (TYPEOF(le.ZIP))'' OR le.ZIP = (TYPEOF(le.ZIP))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_ZIP(le.ZIP,ri.ZIP,TRUE));
    SELF.ZIPWeight := (50+MAP ( le.ZIP = ri.ZIP  => le.ZIP_weight100,
          le.ZIP = (TYPEOF(le.ZIP))'' OR ri.ZIP = (TYPEOF(le.ZIP))'' => 0,
           -0.495*le.ZIP_weight100))/100; 
    SELF.SEC_RANGE_match_code := MAP(
		le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR ri.SEC_RANGE = (TYPEOF(ri.SEC_RANGE))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_SEC_RANGE(le.SEC_RANGE,ri.SEC_RANGE,FALSE));
    SELF.SEC_RANGEWeight := (50+MAP ( le.SEC_RANGE = ri.SEC_RANGE  => le.SEC_RANGE_weight100,
           le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR ri.SEC_RANGE = (TYPEOF(ri.SEC_RANGE))'' => 0,
           SALT29.HyphenMatch(le.SEC_RANGE,ri.SEC_RANGE,1)<=2 => le.SEC_RANGE_weight100*MIN(1,LENGTH(TRIM(ri.SEC_RANGE))/LENGTH(TRIM(le.SEC_RANGE))),
           -0.582*le.SEC_RANGE_weight100))/100; 
    SELF.FNAME_match_code := MAP(
		le.FNAME = (TYPEOF(le.FNAME))'' OR ri.FNAME = (TYPEOF(ri.FNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_FNAME(le.FNAME,ri.FNAME,FALSE));
    SELF.FNAMEWeight := (50+MAP ( le.FNAME = ri.FNAME  => le.FNAME_weight100,
           le.FNAME_PreferredName = fn_PreferredName(ri.FNAME) => le.FNAME_PreferredName_weight100,
           le.FNAME = (TYPEOF(le.FNAME))'' OR ri.FNAME = (TYPEOF(ri.FNAME))'' => 0,
           le.FNAME = ri.FNAME[1..LENGTH(TRIM(le.FNAME))] => le.FNAME_weight100,
           SALT29.WithinEditN(le.FNAME,ri.FNAME,1, 0) => IF( metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(ri.FNAME),le.FNAME_e1p_weight100,le.FNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(ri.FNAME)=>le.FNAME_p_weight100,
           le.FNAME[1..LENGTH(TRIM(ri.FNAME))] = ri.FNAME => SALT29.Fn_Interpolate_Initial(le.FNAME,ri.FNAME,le.FNAME_weight100,le.FNAME_initial_weight100), // later in sequence as less accurate
           -0.961*le.FNAME_weight100))/100; 
    SELF.V_CITY_NAME_match_code := MAP(
		le.V_CITY_NAME = (TYPEOF(le.V_CITY_NAME))'' OR ri.V_CITY_NAME = (TYPEOF(ri.V_CITY_NAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_V_CITY_NAME(le.V_CITY_NAME,ri.V_CITY_NAME,FALSE));
    SELF.V_CITY_NAMEWeight := (50+MAP ( le.V_CITY_NAME = ri.V_CITY_NAME  => le.V_CITY_NAME_weight100,
           le.V_CITY_NAME = (TYPEOF(le.V_CITY_NAME))'' OR ri.V_CITY_NAME = (TYPEOF(ri.V_CITY_NAME))'' => 0,
           -0.562*le.V_CITY_NAME_weight100))/100; 
    SELF.ST_match_code := MAP(
		le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_ST(le.ST,ri.ST,FALSE));
    SELF.STWeight := (50+MAP ( le.ST = ri.ST  => le.ST_weight100,
           le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' => 0,
           -0.823*le.ST_weight100))/100; 
    SELF.GENDER_match_code := MAP(
		le.GENDER = (TYPEOF(le.GENDER))'' OR ri.GENDER = (TYPEOF(ri.GENDER))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_GENDER(le.GENDER,ri.GENDER,FALSE));
    SELF.GENDERWeight := (50+MAP ( le.GENDER = ri.GENDER  => le.GENDER_weight100,
           le.GENDER = (TYPEOF(le.GENDER))'' OR ri.GENDER = (TYPEOF(ri.GENDER))'' => 0,
           -0.987*le.GENDER_weight100))/100; 
    SELF.LNAME_match_code := MAP(
		le.LNAME = (TYPEOF(le.LNAME))'' OR ri.LNAME = (TYPEOF(ri.LNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_LNAME(le.LNAME,ri.LNAME,FALSE));
    SELF.LNAMEWeight := (50+MAP ( le.LNAME = ri.LNAME  => le.LNAME_weight100,
           le.LNAME = (TYPEOF(le.LNAME))'' OR ri.LNAME = (TYPEOF(ri.LNAME))'' => 0,
           SALT29.WithinEditN(le.LNAME,ri.LNAME,1, 0) => IF( metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(ri.LNAME),le.LNAME_e1p_weight100,le.LNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(ri.LNAME)=>le.LNAME_p_weight100,
           SALT29.HyphenMatch(le.LNAME,ri.LNAME,1)<=2 => le.LNAME_weight100*MIN(1,LENGTH(TRIM(ri.LNAME))/LENGTH(TRIM(le.LNAME))),
           -0.874*le.LNAME_weight100))/100; 
    SELF.MNAME_match_code := MAP(
		le.MNAME = (TYPEOF(le.MNAME))'' OR ri.MNAME = (TYPEOF(ri.MNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_MNAME(le.MNAME,ri.MNAME,FALSE));
    SELF.MNAMEWeight := (50+MAP ( le.MNAME = ri.MNAME  => le.MNAME_weight100,
           le.MNAME = (TYPEOF(le.MNAME))'' OR ri.MNAME = (TYPEOF(ri.MNAME))'' => 0,
           le.MNAME = ri.MNAME[1..LENGTH(TRIM(le.MNAME))] => le.MNAME_weight100,
           SALT29.WithinEditN(le.MNAME,ri.MNAME,2, 0) => le.MNAME_e2_weight100,
           le.MNAME[1..LENGTH(TRIM(ri.MNAME))] = ri.MNAME => SALT29.Fn_Interpolate_Initial(le.MNAME,ri.MNAME,le.MNAME_weight100,le.MNAME_initial_weight100), // later in sequence as less accurate
           -0.932*le.MNAME_weight100))/100; 
    SELF.SNAME_match_code := MAP(
		le.SNAME = (TYPEOF(le.SNAME))'' OR ri.SNAME = (TYPEOF(ri.SNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_SNAME(le.SNAME,ri.SNAME,FALSE));
    SELF.SNAMEWeight := (50+MAP ( le.SNAME = ri.SNAME  => le.SNAME_weight100,
           le.SNAME = (TYPEOF(le.SNAME))'' OR ri.SNAME = (TYPEOF(ri.SNAME))'' => 0,
           -0.990*le.SNAME_weight100))/100; 
    SELF.DOB_year_match_code := MAP(
		le.DOB_year = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT29.MatchCode.OneSideNull,
		match_methods(File_HealthProvider).match_DOB_year(le.DOB_year,((UNSIGNED)ri.DOB) DIV 10000));
    SELF.DOB_month_match_code := MAP(
		le.DOB_month = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT29.MatchCode.OneSideNull,
		match_methods(File_HealthProvider).match_DOB_month(le.DOB_month,((UNSIGNED)ri.DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)ri.DOB) % 100));
    SELF.DOB_day_match_code := MAP(
		le.DOB_day = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT29.MatchCode.OneSideNull,
		match_methods(File_HealthProvider).match_DOB_day(le.DOB_month,((UNSIGNED)ri.DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)ri.DOB) % 100));
    SELF.DOBWeight_year := (50+MAP ( le.DOB_year = 0 OR ((UNSIGNED)ri.DOB) DIV 10000 = 0 => 0,
       le.DOB_year = ((UNSIGNED)ri.DOB) DIV 10000  => le.DOB_year_weight100,
       -0.995*le.DOB_year_weight100))/100;
    SELF.DOBWeight_month := (50+MAP ( le.DOB_month = 0 OR ((UNSIGNED)ri.DOB) DIV 100 % 100 = 0 => 0,
      le.DOB_month = ((UNSIGNED)ri.DOB) DIV 100 % 100  => le.DOB_month_weight100,
       -0.995*le.DOB_month_weight100))/100;
    SELF.DOBWeight_day := (50+MAP ( le.DOB_day = 0 OR ((UNSIGNED)ri.DOB) % 100 = 0 => 0,
      le.DOB_day = ((UNSIGNED)ri.DOB) % 100  => le.DOB_day_weight100,
       -0.995*le.DOB_day_weight100))/100;
    SELF.DOBWeight := (SELF.DOBWeight_year+SELF.DOBWeight_month+SELF.DOBWeight_day); 
    SELF.C_LIC_NBR_match_code := MAP(
		le.C_LIC_NBR = (TYPEOF(le.C_LIC_NBR))'' OR ri.C_LIC_NBR = (TYPEOF(ri.C_LIC_NBR))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_C_LIC_NBR(le.C_LIC_NBR,ri.C_LIC_NBR,FALSE));
    SELF.C_LIC_NBRWeight := (50+MAP ( le.C_LIC_NBR = ri.C_LIC_NBR  => le.C_LIC_NBR_weight100,
           le.C_LIC_NBR = (TYPEOF(le.C_LIC_NBR))'' OR ri.C_LIC_NBR = (TYPEOF(ri.C_LIC_NBR))'' => 0,
           SALT29.WithinEditN(le.C_LIC_NBR,ri.C_LIC_NBR,1, 0) => le.C_LIC_NBR_e1_weight100,
           -0.671*le.C_LIC_NBR_weight100))/100; 
    SELF.LIC_STATE_match_code := MAP(
		le.LIC_STATE = (TYPEOF(le.LIC_STATE))'' OR ri.LIC_STATE = (TYPEOF(ri.LIC_STATE))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_LIC_STATE(le.LIC_STATE,ri.LIC_STATE,FALSE));
    SELF.LIC_STATEWeight := (50+MAP ( le.LIC_STATE = ri.LIC_STATE  => le.LIC_STATE_weight100,
           le.LIC_STATE = (TYPEOF(le.LIC_STATE))'' OR ri.LIC_STATE = (TYPEOF(ri.LIC_STATE))'' => 0,
           -0.810*le.LIC_STATE_weight100))/100; 
    SELF.BILLING_TAX_ID_match_code := MAP(
		le.BILLING_TAX_ID = (TYPEOF(le.BILLING_TAX_ID))'' OR ri.BILLING_TAX_ID = (TYPEOF(ri.BILLING_TAX_ID))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_BILLING_TAX_ID(le.BILLING_TAX_ID,ri.BILLING_TAX_ID,FALSE));
    SELF.BILLING_TAX_IDWeight := (50+MAP ( le.BILLING_TAX_ID = ri.BILLING_TAX_ID  => le.BILLING_TAX_ID_weight100,
           le.BILLING_TAX_ID = (TYPEOF(le.BILLING_TAX_ID))'' OR ri.BILLING_TAX_ID = (TYPEOF(ri.BILLING_TAX_ID))'' => 0,
           -0.392*le.BILLING_TAX_ID_weight100))/100*0.75; 
    SELF.Weight :=MAX(0,SELF.PRIM_RANGEWeight) + MAX(0,SELF.PRIM_NAMEWeight) + MAX(0,SELF.ZIPWeight) + MAX(0,SELF.SEC_RANGEWeight) + MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.V_CITY_NAMEWeight) + MAX(0,SELF.STWeight) + MAX(0,SELF.GENDERWeight) + MAX(0,SELF.LNAMEWeight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.SNAMEWeight) + MAX(0,SELF.DOBWeight) + MAX(0,SELF.C_LIC_NBRWeight) + MAX(0,SELF.LIC_STATEWeight) + MAX(0,SELF.BILLING_TAX_IDWeight);
    SELF := le;
  END;
  Recs0 := Recs(PRIM_RANGE <> (typeof(PRIM_RANGE))'',PRIM_NAME <> (typeof(PRIM_NAME))'',ZIP <> (typeof(ZIP))'');
  SALT29.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE
     AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME
     AND LEFT.ZIP = RIGHT.ZIP
     AND ( LEFT.SEC_RANGE = (TYPEOF(LEFT.SEC_RANGE))'' OR RIGHT.SEC_RANGE = (TYPEOF(RIGHT.SEC_RANGE))'' OR SALT29.HyphenMatch(LEFT.SEC_RANGE,RIGHT.SEC_RANGE,1)<=2  )
     AND ( LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME OR RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME OR metaphonelib.DMetaPhone1(LEFT.FNAME)=metaphonelib.DMetaPhone1(RIGHT.FNAME) OR SALT29.WithinEditN(LEFT.FNAME,RIGHT.FNAME,1, 0)  OR RIGHT.FNAME_PreferredName = fn_PreferredName(LEFT.FNAME)  ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE
     AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME
     AND LEFT.ZIP = RIGHT.ZIP,10000)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE
     AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME
     AND LEFT.ZIP = RIGHT.ZIP
     AND ( LEFT.SEC_RANGE = (TYPEOF(LEFT.SEC_RANGE))'' OR RIGHT.SEC_RANGE = (TYPEOF(RIGHT.SEC_RANGE))'' OR SALT29.HyphenMatch(LEFT.SEC_RANGE,RIGHT.SEC_RANGE,1)<=2  )
     AND ( LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME OR RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME OR metaphonelib.DMetaPhone1(LEFT.FNAME)=metaphonelib.DMetaPhone1(RIGHT.FNAME) OR SALT29.WithinEditN(LEFT.FNAME,RIGHT.FNAME,1, 0)  OR RIGHT.FNAME_PreferredName = fn_PreferredName(LEFT.FNAME)  ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE
     AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME
     AND LEFT.ZIP = RIGHT.ZIP,10000),HASH,HINT(unsorted_output)); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := Process_xLNPID_Layouts.CombineLinkpathScores(J2); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT29.MAC_Dups_Restore(J3,DD,J4,Reference,TRUE)
  RETURN J4;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_PRIM_RANGE='',Input_PRIM_NAME='',Input_ZIP='',Input_SEC_RANGE='',Input_FNAME='',Input_V_CITY_NAME='',Input_ST='',Input_GENDER='',Input_LNAME='',Input_MNAME='',Input_SNAME='',Input_DOB='',Input_C_LIC_NBR='',Input_LIC_STATE='',Input_BILLING_TAX_ID='',output_file,AsIndex='true') := MACRO
IMPORT SALT29,PRTE_Health_Provider_Services;
#IF(#TEXT(Input_PRIM_RANGE)<>'' AND #TEXT(Input_PRIM_NAME)<>'' AND #TEXT(Input_ZIP)<>'')
  #uniquename(trans)
  PRTE_Health_Provider_Services.Key_HealthProvider_ADDRESS.InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))le.Input_PRIM_RANGE;
    SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))le.Input_PRIM_NAME;
    SELF.ZIP := (TYPEOF(SELF.ZIP))le.Input_ZIP;
    #IF ( #TEXT(Input_SEC_RANGE) <> '' )
      SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))le.Input_SEC_RANGE;
    #END
    #IF ( #TEXT(Input_FNAME) <> '' )
      SELF.FNAME := (TYPEOF(SELF.FNAME))le.Input_FNAME;
    #END
    #IF ( #TEXT(Input_V_CITY_NAME) <> '' )
      SELF.V_CITY_NAME := (TYPEOF(SELF.V_CITY_NAME))le.Input_V_CITY_NAME;
    #END
    #IF ( #TEXT(Input_ST) <> '' )
      SELF.ST := (TYPEOF(SELF.ST))le.Input_ST;
    #END
    #IF ( #TEXT(Input_GENDER) <> '' )
      SELF.GENDER := (TYPEOF(SELF.GENDER))le.Input_GENDER;
    #END
    #IF ( #TEXT(Input_LNAME) <> '' )
      SELF.LNAME := (TYPEOF(SELF.LNAME))le.Input_LNAME;
    #END
    #IF ( #TEXT(Input_MNAME) <> '' )
      SELF.MNAME := (TYPEOF(SELF.MNAME))le.Input_MNAME;
    #END
    #IF ( #TEXT(Input_SNAME) <> '' )
      SELF.SNAME := (TYPEOF(SELF.SNAME))le.Input_SNAME;
    #END
    #if ( #TEXT(Input_DOB) <> '' )
      self.DOB := (unsigned4)le.Input_DOB;
    #end
    #IF ( #TEXT(Input_C_LIC_NBR) <> '' )
      SELF.C_LIC_NBR := (TYPEOF(SELF.C_LIC_NBR))le.Input_C_LIC_NBR;
    #END
    #IF ( #TEXT(Input_LIC_STATE) <> '' )
      SELF.LIC_STATE := (TYPEOF(SELF.LIC_STATE))le.Input_LIC_STATE;
    #END
    #IF ( #TEXT(Input_BILLING_TAX_ID) <> '' )
      SELF.BILLING_TAX_ID := (TYPEOF(SELF.BILLING_TAX_ID))le.Input_BILLING_TAX_ID;
    #END
  END;
  #uniquename(p)
  %p% := PROJECT(Infile,%trans%(left));
  output_file := PRTE_Health_Provider_Services.Key_HealthProvider_ADDRESS.ScoredFetch_Batch(%p%,AsIndex);
#ELSE
  output_file := DATASET([],PRTE_Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
END;
