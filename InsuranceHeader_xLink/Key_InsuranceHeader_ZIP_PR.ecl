IMPORT SALT311,std;
EXPORT Key_InsuranceHeader_ZIP_PR(BOOLEAN incremental=FALSE, UNSIGNED2  aBlockLimit= Config.ZIP_PR_MAXBLOCKLIMIT) := MODULE/*HACK25*/
 
//ZIP:PRIM_RANGE:?:FNAME:LNAME:+:PRIM_NAME:SEC_RANGE:CITY:ST:DERIVED_GENDER:SNAME:DOB
EXPORT KeyName := KeyNames().ZIP_PR_logical; /*HACK40*/
 
EXPORT KeyName_sf := KeyNames().ZIP_PR_super; /*HACK10*/
 
EXPORT AssignCurrentKeyToSuperFile := FileServices.AddSuperFile(KeyName_sf,KeyName);
 
EXPORT ClearKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(KeyName_sf,,TRUE),FileServices.ClearSuperFile(KeyName_sf));
STRING csv_fields := 'ZIP,PRIM_RANGE,FNAME,LNAME,PRIM_NAME,SEC_RANGE,CITY,ST,DERIVED_GENDER,SNAME,DOB_year,DOB_month,DOB_day,DID';
SHARED h := CandidatesForKey(csv_fields, incremental);//The input file - distributed by DID
 
SHARED s := Specificities(File_InsuranceHeader).Specificities[1];
SHARED s_index := Keys(File_InsuranceHeader).Specificities_Key[1]; // Index access for MEOW queries
layout := RECORD // project out required fields
// Compulsory fields
  h.ZIP;
  h.PRIM_RANGE;
// Optional fields
  h.DID; // The ID field
  h.FNAME_PreferredName;
  h.FNAME;
  h.LNAME;
// Extra credit fields
  h.PRIM_NAME;
  h.SEC_RANGE;
  h.CITY;
  h.ST;
  h.DERIVED_GENDER;
  h.SNAME;
  h.DOB_year;
  h.DOB_month;
  h.DOB_day;
  h.DT_EFFECTIVE_FIRST;
  h.DT_EFFECTIVE_LAST;
  h.PRIM_RANGE_len;
  h.FNAME_len;
  h.LNAME_len;
  h.PRIM_NAME_len;
//Scores for various field components
  h.ZIP_weight100 ; // Contains 100x the specificity
  h.PRIM_RANGE_weight100 ; // Contains 100x the specificity
  h.PRIM_RANGE_e1_Weight100;
  h.FNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_MAINNAME_fuzzy_weight100 ; // Contains 100x the specificity
  h.FNAME_initial_char_weight100 ; // Contains 100x the specificity
  h.FNAME_p_Weight100;
  h.FNAME_e1_Weight100;
  h.FNAME_e1p_Weight100;
  h.FNAME_PreferredName_Weight100;
  h.FNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.LNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_MAINNAME_fuzzy_weight100 ; // Contains 100x the specificity
  h.LNAME_p_Weight100;
  h.LNAME_e1_Weight100;
  h.LNAME_e1p_Weight100;
  h.LNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.PRIM_NAME_weight100 ; // Contains 100x the specificity
  h.PRIM_NAME_e1_Weight100;
  h.SEC_RANGE_weight100 ; // Contains 100x the specificity
  h.CITY_weight100 ; // Contains 100x the specificity
  h.ST_weight100 ; // Contains 100x the specificity
  h.DERIVED_GENDER_weight100 ; // Contains 100x the specificity
  h.DERIVED_GENDER_initial_char_weight100 ; // Contains 100x the specificity
  h.SNAME_weight100 ; // Contains 100x the specificity
  h.DOB_year_weight100; // Contains 100x the specificity
  h.DOB_month_weight100; // Contains 100x the specificity
  h.DOB_day_weight100; // Contains 100x the specificity
END;
 
DataForKey0 := DEDUP(SORT(TABLE(h((ZIP NOT IN SET(s.nulls_ZIP,ZIP) AND ZIP <> (TYPEOF(ZIP))''),(PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) AND PRIM_RANGE <> (TYPEOF(PRIM_RANGE))'')),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
SHARED DataForKey := DataForKey0;
 
EXPORT Key := INDEX(DataForKey,{DataForKey},{BOOLEAN IsIncremental := incremental},KeyName_sf);
 
EXPORT BuildAll := BUILDINDEX(Key, KeyName, OVERWRITE);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,DID,ZIP,PRIM_RANGE,FNAME,LNAME,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_PRIM_NAME := GROUP( DEDUP( SORT( Grpd, EXCEPT PRIM_NAME), EXCEPT PRIM_NAME));
  CntRed_PRIM_NAME := (KeyCnt-COUNT(Rem_PRIM_NAME))/KeyCnt;
  Rem_SEC_RANGE := GROUP( DEDUP( SORT( Grpd, EXCEPT SEC_RANGE), EXCEPT SEC_RANGE));
  CntRed_SEC_RANGE := (KeyCnt-COUNT(Rem_SEC_RANGE))/KeyCnt;
  Rem_CITY := GROUP( DEDUP( SORT( Grpd, EXCEPT CITY), EXCEPT CITY));
  CntRed_CITY := (KeyCnt-COUNT(Rem_CITY))/KeyCnt;
  Rem_ST := GROUP( DEDUP( SORT( Grpd, EXCEPT ST), EXCEPT ST));
  CntRed_ST := (KeyCnt-COUNT(Rem_ST))/KeyCnt;
  Rem_DERIVED_GENDER := GROUP( DEDUP( SORT( Grpd, EXCEPT DERIVED_GENDER), EXCEPT DERIVED_GENDER));
  CntRed_DERIVED_GENDER := (KeyCnt-COUNT(Rem_DERIVED_GENDER))/KeyCnt;
  Rem_SNAME := GROUP( DEDUP( SORT( Grpd, EXCEPT SNAME), EXCEPT SNAME));
  CntRed_SNAME := (KeyCnt-COUNT(Rem_SNAME))/KeyCnt;
  Rem_DOB := GROUP( DEDUP( SORT( Grpd, EXCEPT DOB_year,DOB_month,DOB_day), EXCEPT DOB_year,DOB_month,DOB_day));
  CntRed_DOB := (KeyCnt-COUNT(Rem_DOB))/KeyCnt;
EXPORT Shrinkage := DATASET([{'ZIP_PR','PRIM_NAME',CntRed_PRIM_NAME*100,CntRed_PRIM_NAME*TSize},{'ZIP_PR','SEC_RANGE',CntRed_SEC_RANGE*100,CntRed_SEC_RANGE*TSize},{'ZIP_PR','CITY',CntRed_CITY*100,CntRed_CITY*TSize},{'ZIP_PR','ST',CntRed_ST*100,CntRed_ST*TSize},{'ZIP_PR','DERIVED_GENDER',CntRed_DERIVED_GENDER*100,CntRed_DERIVED_GENDER*TSize},{'ZIP_PR','SNAME',CntRed_SNAME*100,CntRed_SNAME*TSize},{'ZIP_PR','DOB',CntRed_DOB*100,CntRed_DOB*TSize}],SALT311.ShrinkLayout);
EXPORT MergeKeyFiles(STRING superFileIn, STRING outfileName, UNSIGNED4 minDate = 0, BOOLEAN replaceExisting = FALSE) := FUNCTION
  fieldListIndex := SALT311.MAC_FieldListCSVFromDataset(DataForKey,[],',');
  fieldListPayload := 'IsIncremental';
  RETURN Process_xIDL_Layouts().MAC_GenerateMergedKey(superFileIn, outfileName, minDate, replaceExisting, fieldListIndex, fieldListPayload, 'Key');
END;
EXPORT MAX_BLOCKLIMIT := IF (aBlockLimit=0,  Config.ZIP_PR_MAXBLOCKLIMIT, aBlockLimit);/*HACK24a*/
EXPORT CanSearch(Process_xIDL_Layouts().InputLayout le) := EXISTS(le.ZIP_cases) AND le.PRIM_RANGE <> (TYPEOF(le.PRIM_RANGE))'' AND Fields.InValid_PRIM_RANGE((SALT311.StrType)le.PRIM_RANGE)=0;
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(DATASET(Process_xIDL_Layouts().layout_ZIP_cases) param_ZIP,TYPEOF(h.PRIM_RANGE) param_PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',TYPEOF(h.PRIM_RANGE_len) param_PRIM_RANGE_len = (TYPEOF(h.PRIM_RANGE_len))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'') := 
    STEPPED( LIMIT( Key(
          KEYED((ZIP IN SET(param_ZIP,ZIP)))
      AND KEYED((PRIM_RANGE = param_PRIM_RANGE))
      AND ((param_FNAME = (TYPEOF(FNAME))'' OR FNAME = (TYPEOF(FNAME))'') OR (FNAME = param_FNAME) OR ((FNAME[1..LENGTH(TRIM(param_FNAME))] = param_FNAME OR param_FNAME[1..LENGTH(TRIM(FNAME))] = FNAME)  OR  (FNAME_PreferredName = fn_PreferredName(param_FNAME))  OR  (metaphonelib.DMetaPhone1(FNAME)=metaphonelib.DMetaPhone1(param_FNAME))  OR (Config.WithinEditN(FNAME,FNAME_len,param_FNAME,param_FNAME_len,1,Config.FNAME_LENGTH_EDIT2) /*HACK02*/) OR (Config.WildMatch(FNAME,param_FNAME,FALSE)) ))
      AND ((param_LNAME = (TYPEOF(LNAME))'' OR LNAME = (TYPEOF(LNAME))'') OR (LNAME = param_LNAME) OR ( (metaphonelib.DMetaPhone1(LNAME)=metaphonelib.DMetaPhone1(param_LNAME))  OR (Config.WithinEditN(LNAME,LNAME_len,param_LNAME,param_LNAME_len,1,Config.LNAME_LENGTH_EDIT2) /*HACK06*/)  OR (SALT311.HyphenMatch(LNAME,param_LNAME,1)<=2)OR (Config.WildMatch(LNAME,param_LNAME,FALSE)) ))),MAX_BLOCKLIMIT/*HACK24b*/,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),DID);
 
 
EXPORT ScoredDIDFetch(DATASET(Process_xIDL_Layouts().layout_ZIP_cases) param_ZIP,TYPEOF(h.PRIM_RANGE) param_PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',TYPEOF(h.PRIM_RANGE_len) param_PRIM_RANGE_len = (TYPEOF(h.PRIM_RANGE_len))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'',TYPEOF(h.PRIM_NAME) param_PRIM_NAME = (TYPEOF(h.PRIM_NAME))'',TYPEOF(h.PRIM_NAME_len) param_PRIM_NAME_len = (TYPEOF(h.PRIM_NAME_len))'',TYPEOF(h.SEC_RANGE) param_SEC_RANGE = (TYPEOF(h.SEC_RANGE))'',TYPEOF(h.CITY) param_CITY = (TYPEOF(h.CITY))'',TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',TYPEOF(h.DERIVED_GENDER) param_DERIVED_GENDER = (TYPEOF(h.DERIVED_GENDER))'',TYPEOF(h.SNAME) param_SNAME = (TYPEOF(h.SNAME))'',UNSIGNED4 param_DOB,BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetch(param_ZIP,param_PRIM_RANGE,param_PRIM_RANGE_len,param_FNAME,param_FNAME_len,param_LNAME,param_LNAME_len);
useDate := (UNSIGNED4)SALT311.fn_now('YYYYMMDD');
 
  Process_xIDL_Layouts().LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 7; // Set bitmap for keys used
    SELF.keys_poisoned := IF(le.DT_EFFECTIVE_LAST <> 0 AND le.IsIncremental, SELF.keys_used, 0);
    SELF.keys_failed := IF(le.DID = 0, 1 << 7, 0); // Set bitmap for key failed
    SELF.ZIP_match_code := match_methods(File_InsuranceHeader).match_ZIP_el(le.ZIP,SET(param_ZIP,ZIP),TRUE);
    SELF.ZIPWeight := (50+MAP (
           SELF.ZIP_match_code = SALT311.MatchCode.ExactMatch =>le.ZIP_weight100 * param_ZIP(ZIP=le.ZIP)[1].weight/100.0,
           -1.000*le.ZIP_weight100))/100; 
    SELF.ZIP_cases := DATASET([{le.ZIP,SELF.ZIPweight}],Process_xIDL_Layouts().layout_ZIP_cases);
    SELF.PRIM_RANGE_match_code := match_methods(File_InsuranceHeader).match_PRIM_RANGE(le.PRIM_RANGE,param_PRIM_RANGE,le.PRIM_RANGE_len,param_PRIM_RANGE_len,TRUE);
    SELF.PRIM_RANGEWeight := (50+MAP (
           SELF.PRIM_RANGE_match_code = SALT311.MatchCode.ExactMatch =>le.PRIM_RANGE_weight100,
           -0.537*le.PRIM_RANGE_weight100))/100; 
    SELF.FNAME_match_code := MAP(
           le.FNAME = (TYPEOF(le.FNAME))'' OR param_FNAME = (TYPEOF(param_FNAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_FNAME(le.FNAME,param_FNAME,le.FNAME_len,param_FNAME_len,FALSE));
    SELF.FNAMEWeight := (50+MAP (
           SELF.FNAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.FNAME_match_code = SALT311.MatchCode.ExactMatch =>le.FNAME_weight100,
           SELF.FNAME_match_code = SALT311.MatchCode.InitialLMatch =>le.FNAME_weight100,
           SELF.FNAME_match_code = SALT311.MatchCode.InitialRMatch=> SALT311.Fn_Interpolate_Initial(le.FNAME,param_FNAME,le.FNAME_weight100,le.FNAME_initial_char_weight100),
           SELF.FNAME_match_code = SALT311.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(param_FNAME),le.FNAME_e1p_weight100,le.FNAME_e1_weight100),
           SELF.FNAME_match_code = SALT311.MatchCode.PhoneticMatch =>le.FNAME_p_weight100,
           SELF.FNAME_match_code = SALT311.MatchCode.WildMatch =>le.FNAME_weight100 / Config.WildPenalty,
           SELF.FNAME_match_code = SALT311.MatchCode.CustomFuzzyMatch =>le.FNAME_PreferredName_weight100,
           -0.737*le.FNAME_weight100))/100*0.80; 
    SELF.LNAME_match_code := MAP(
           le.LNAME = (TYPEOF(le.LNAME))'' OR param_LNAME = (TYPEOF(param_LNAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_LNAME(le.LNAME,param_LNAME,le.LNAME_len,param_LNAME_len,FALSE));
    SELF.LNAMEWeight := (50+MAP (
           SELF.LNAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.LNAME_match_code = SALT311.MatchCode.ExactMatch =>le.LNAME_weight100,
           SELF.LNAME_match_code = SALT311.MatchCode.HyphenMatch =>le.LNAME_weight100*MIN(1,LENGTH(TRIM(param_LNAME))/LENGTH(TRIM(le.LNAME))),
           SELF.LNAME_match_code = SALT311.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(param_LNAME),le.LNAME_e1p_weight100,le.LNAME_e1_weight100),
           SELF.LNAME_match_code = SALT311.MatchCode.PhoneticMatch =>le.LNAME_p_weight100,
           SELF.LNAME_match_code = SALT311.MatchCode.WildMatch =>le.LNAME_weight100 / Config.WildPenalty,
           -0.617*le.LNAME_weight100))/100*0.80; 
    SELF.PRIM_NAME_match_code := MAP(
           le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR param_PRIM_NAME = (TYPEOF(param_PRIM_NAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_PRIM_NAME(le.PRIM_NAME,param_PRIM_NAME,le.PRIM_NAME_len,param_PRIM_NAME_len,FALSE));
    SELF.PRIM_NAMEWeight := (50+MAP (
           SELF.PRIM_NAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.PRIM_NAME_match_code = SALT311.MatchCode.ExactMatch =>le.PRIM_NAME_weight100,
           SELF.PRIM_NAME_match_code = SALT311.MatchCode.EditDistanceMatch =>le.PRIM_NAME_e1_weight100,
           SELF.PRIM_NAME_match_code = SALT311.MatchCode.WildMatch =>le.PRIM_NAME_weight100 / Config.WildPenalty,
           -0.531*le.PRIM_NAME_weight100))/100; 
    SELF.SEC_RANGE_match_code := MAP(
           le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR param_SEC_RANGE = (TYPEOF(param_SEC_RANGE))'' => SALT311.MatchCode.OneSideNull,
           le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR param_PRIM_NAME = (TYPEOF(param_PRIM_NAME))'' OR le.PRIM_NAME <> param_PRIM_NAME  => SALT311.MatchCode.ContextNoMatch, // Only valid if the context variable is equal
           match_methods(File_InsuranceHeader).match_SEC_RANGE(le.SEC_RANGE,param_SEC_RANGE,FALSE));
    SELF.SEC_RANGEWeight := (50+MAP (
           SELF.SEC_RANGE_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.SEC_RANGE_match_code = SALT311.MatchCode.ContextNoMatch => 0,
           SELF.SEC_RANGE_match_code = SALT311.MatchCode.ExactMatch =>le.SEC_RANGE_weight100,
           SELF.SEC_RANGE_match_code = SALT311.MatchCode.HyphenMatch =>le.SEC_RANGE_weight100*MIN(1,LENGTH(TRIM(param_SEC_RANGE))/LENGTH(TRIM(le.SEC_RANGE))),
           -0.629*le.SEC_RANGE_weight100))/100; 
    SELF.CITY_match_code := MAP(
           le.CITY = (TYPEOF(le.CITY))'' OR param_CITY = (TYPEOF(param_CITY))'' => SALT311.MatchCode.OneSideNull,
           le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' OR le.ST <> param_ST  => SALT311.MatchCode.ContextNoMatch, // Only valid if the context variable is equal
           match_methods(File_InsuranceHeader).match_CITY(le.CITY,param_CITY,FALSE));
    SELF.CITYWeight := (50+MAP (
           SELF.CITY_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.CITY_match_code = SALT311.MatchCode.ContextNoMatch => 0,
           SELF.CITY_match_code = SALT311.MatchCode.ExactMatch =>le.CITY_weight100,
           -0.580*le.CITY_weight100))/100; 
    SELF.ST_match_code := MAP(
           le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_ST(le.ST,param_ST,FALSE));
    SELF.STWeight := (50+MAP (
           SELF.ST_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.ST_match_code = SALT311.MatchCode.ExactMatch =>le.ST_weight100,
           -0.690*le.ST_weight100))/100; 
    SELF.DERIVED_GENDER_match_code := MAP(
           le.DERIVED_GENDER = (TYPEOF(le.DERIVED_GENDER))'' OR param_DERIVED_GENDER = (TYPEOF(param_DERIVED_GENDER))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_DERIVED_GENDER(le.DERIVED_GENDER,param_DERIVED_GENDER,FALSE));
    SELF.DERIVED_GENDERWeight := (50+MAP (
           SELF.DERIVED_GENDER_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.DERIVED_GENDER_match_code = SALT311.MatchCode.ExactMatch =>le.DERIVED_GENDER_weight100,
           SELF.DERIVED_GENDER_match_code = SALT311.MatchCode.InitialLMatch =>le.DERIVED_GENDER_weight100,
           SELF.DERIVED_GENDER_match_code = SALT311.MatchCode.InitialRMatch=> SALT311.Fn_Interpolate_Initial(le.DERIVED_GENDER,param_DERIVED_GENDER,le.DERIVED_GENDER_weight100,le.DERIVED_GENDER_initial_char_weight100),
           -0.983*le.DERIVED_GENDER_weight100))/100; 
    SELF.SNAME_match_code := MAP(
           le.SNAME = (TYPEOF(le.SNAME))'' OR param_SNAME = (TYPEOF(param_SNAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_SNAME(le.SNAME,param_SNAME,FALSE));
    SELF.SNAMEWeight := (50+MAP (
           SELF.SNAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.SNAME_match_code = SALT311.MatchCode.ExactMatch =>le.SNAME_weight100,
           -0.946*le.SNAME_weight100))/100; 
    SELF.DOB_year_match_code := MAP(
      le.DOB_year = 0 OR ((UNSIGNED)param_DOB) DIV 10000 = 0 /*DOBHACK01*/ => SALT311.MatchCode.OneSideNull,
      match_methods(File_InsuranceHeader).match_DOB_year(le.DOB_year,((UNSIGNED)param_DOB) DIV 10000,FALSE));
    SELF.DOBWeight_year := (50+MAP ( SELF.DOB_year_match_code = SALT311.MatchCode.OneSideNull => 0,
       SELF.DOB_year_match_code = SALT311.MatchCode.ExactMatch => le.DOB_year_weight100,
       SELF.DOB_year_match_code = SALT311.MatchCode.YearMatch => le.DOB_year_weight100-358, //YEAR_SHIFT
       -1.000*le.DOB_year_weight100))/100;
    SELF.DOB_month_match_code := MAP(
      le.DOB_month = 0 OR ((UNSIGNED)param_DOB) DIV 100 % 100 = 0 /*DOBHACK02*/ => SALT311.MatchCode.OneSideNull,
      match_methods(File_InsuranceHeader).match_DOB_month(le.DOB_month,((UNSIGNED)param_DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)param_DOB) % 100,FALSE));
    SELF.DOBWeight_month := (50+MAP ( SELF.DOB_month_match_code = SALT311.MatchCode.OneSideNull => 0,
      SELF.DOB_month_match_code = SALT311.MatchCode.ExactMatch => le.DOB_month_weight100,
      SELF.DOB_month_match_code = SALT311.MatchCode.MonthDaySwitch => le.DOB_month_weight100-100, // MDDM
      SELF.DOB_month_match_code = SALT311.MatchCode.SoftMatch => -200, // SOFT1 
       -1.000*le.DOB_month_weight100))/100;
    SELF.DOB_day_match_code := MAP(
		le.DOB_day = 0 OR ((UNSIGNED)param_DOB) % 100 = 0 /*DOBHACK03*/ => SALT311.MatchCode.OneSideNull,
      match_methods(File_InsuranceHeader).match_DOB_day(le.DOB_month,((UNSIGNED)param_DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)param_DOB) % 100,FALSE));
    SELF.DOBWeight_day := (50+MAP ( SELF.DOB_day_match_code = SALT311.MatchCode.OneSideNull => 0,
      SELF.DOB_day_match_code = SALT311.MatchCode.ExactMatch => le.DOB_day_weight100,
      SELF.DOB_day_match_code = SALT311.MatchCode.MonthDaySwitch => le.DOB_day_weight100-100, // MDDM
      SELF.DOB_day_match_code = SALT311.MatchCode.SoftMatch => -200, // SOFT1 
       -1.000*le.DOB_day_weight100))/100;
		DOB_AggWeight := SELF.DOBWeight_day + SELF.DOBWeight_month + SELF.DOBWeight_year;
    SELF.DOB_match_code := MAP(
      le.DOB_year+le.DOB_month+le.DOB_day = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(File_InsuranceHeader).match_DOB_el(le.DOB_year, le.DOB_month, le.DOB_day, param_DOB, DOB_AggWeight ,FALSE));
    SELF.DOBWeight :=  MAP(
           SELF.DOB_match_code = SALT311.MatchCode.OneSideNull => 0,
           DOB_AggWeight); 
    SELF.Weight := IF(le.DID = 0, 100, MAX(0, SELF.ZIPWeight) + MAX(0, SELF.PRIM_RANGEWeight) + MAX(0, SELF.FNAMEWeight) + MAX(0, SELF.LNAMEWeight) + MAX(0, SELF.PRIM_NAMEWeight) + MAX(0, SELF.SEC_RANGEWeight) + MAX(0, SELF.CITYWeight) + MAX(0, SELF.STWeight) + MAX(0, SELF.DERIVED_GENDERWeight) + MAX(0, SELF.SNAMEWeight) + MAX(0, SELF.DOBWeight));
    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));
  poisoned_results := TABLE(result0(keys_poisoned > 0), {DID, keys_poisoned}, DID, keys_poisoned);
  result_rollup0 := DEDUP(SORT(result0,DID,ZIP_cases[1],PRIM_RANGE,FNAME,LNAME,PRIM_NAME,SEC_RANGE,CITY,ST,DERIVED_GENDER,SNAME,DOB_year,DOB_month,DOB_day,DT_EFFECTIVE_FIRST,-DT_EFFECTIVE_LAST),DID,ZIP_cases[1],PRIM_RANGE,FNAME,LNAME,PRIM_NAME,SEC_RANGE,CITY,ST,DERIVED_GENDER,SNAME,DOB_year,DOB_month,DOB_day,DT_EFFECTIVE_FIRST);
  result_rollup1 := JOIN(result_rollup0, poisoned_results, LEFT.DID = RIGHT.DID, TRANSFORM(RECORDOF(LEFT), SELF.keys_poisoned := RIGHT.keys_poisoned, SELF := LEFT), LEFT OUTER);
  result1 := result_rollup1((DT_EFFECTIVE_FIRST = 0 OR useDate >= DT_EFFECTIVE_FIRST) AND (useDate <= DT_EFFECTIVE_LAST OR DT_EFFECTIVE_LAST = 0));
  result2 := PROJECT(result1, Process_xIDL_Layouts().update_forcefailed(LEFT,param_disableForce));
  result3 := ROLLUP(result2,LEFT.DID = RIGHT.DID,Process_xIDL_Layouts().combine_scores(LEFT,RIGHT,param_disableForce));
  RETURN result3;
END;
 
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT311.UIDType Reference;//How to recognize this record in the subsequent
  DATASET(InsuranceHeader_xLink.Process_xIDL_Layouts().layout_ZIP_cases) ZIP_cases := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().layout_ZIP_cases);
  TYPEOF(h.PRIM_RANGE) PRIM_RANGE := (TYPEOF(h.PRIM_RANGE))'';
  TYPEOF(h.PRIM_RANGE_len) PRIM_RANGE_len := (TYPEOF(h.PRIM_RANGE_len))'';
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))'';
  TYPEOF(h.FNAME_len) FNAME_len := (TYPEOF(h.FNAME_len))'';
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))'';
  TYPEOF(h.LNAME_len) LNAME_len := (TYPEOF(h.LNAME_len))'';
  TYPEOF(h.PRIM_NAME) PRIM_NAME := (TYPEOF(h.PRIM_NAME))'';
  TYPEOF(h.PRIM_NAME_len) PRIM_NAME_len := (TYPEOF(h.PRIM_NAME_len))'';
  TYPEOF(h.SEC_RANGE) SEC_RANGE := (TYPEOF(h.SEC_RANGE))'';
  TYPEOF(h.CITY) CITY := (TYPEOF(h.CITY))'';
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))'';
  TYPEOF(h.DERIVED_GENDER) DERIVED_GENDER := (TYPEOF(h.DERIVED_GENDER))'';
  TYPEOF(h.SNAME) SNAME := (TYPEOF(h.SNAME))'';
  UNSIGNED4 DOB := 0;
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex, BOOLEAN In_disableForce = FALSE) := FUNCTION
 
  Process_xIDL_Layouts().LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 7; // Set bitmap for keys used
    SELF.keys_poisoned := IF(le.DT_EFFECTIVE_LAST <> 0 AND le.IsIncremental, SELF.keys_used, 0);
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.ZIP_match_code := match_methods(File_InsuranceHeader).match_ZIP_el(le.ZIP,SET(ri.ZIP_cases,ZIP),TRUE);
    SELF.ZIPWeight := (50+MAP (
           SELF.ZIP_match_code = SALT311.MatchCode.ExactMatch =>le.ZIP_weight100 * ri.ZIP_cases(ZIP=le.ZIP)[1].weight/100.0,
           -1.000*le.ZIP_weight100))/100; 
    SELF.ZIP_cases := DATASET([{le.ZIP,SELF.ZIPweight}],Process_xIDL_Layouts().layout_ZIP_cases);
    SELF.PRIM_RANGE_match_code := match_methods(File_InsuranceHeader).match_PRIM_RANGE(le.PRIM_RANGE,ri.PRIM_RANGE,le.PRIM_RANGE_len,ri.PRIM_RANGE_len,TRUE);
    SELF.PRIM_RANGEWeight := (50+MAP (
           SELF.PRIM_RANGE_match_code = SALT311.MatchCode.ExactMatch =>le.PRIM_RANGE_weight100,
           -0.537*le.PRIM_RANGE_weight100))/100; 
    SELF.FNAME_match_code := MAP(
           le.FNAME = (TYPEOF(le.FNAME))'' OR ri.FNAME = (TYPEOF(ri.FNAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_FNAME(le.FNAME,ri.FNAME,le.FNAME_len,ri.FNAME_len,FALSE));
    SELF.FNAMEWeight := (50+MAP (
           SELF.FNAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.FNAME_match_code = SALT311.MatchCode.ExactMatch =>le.FNAME_weight100,
           SELF.FNAME_match_code = SALT311.MatchCode.InitialLMatch =>le.FNAME_weight100,
           SELF.FNAME_match_code = SALT311.MatchCode.InitialRMatch=> SALT311.Fn_Interpolate_Initial(le.FNAME,ri.FNAME,le.FNAME_weight100,le.FNAME_initial_char_weight100),
           SELF.FNAME_match_code = SALT311.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(ri.FNAME),le.FNAME_e1p_weight100,le.FNAME_e1_weight100),
           SELF.FNAME_match_code = SALT311.MatchCode.PhoneticMatch =>le.FNAME_p_weight100,
           SELF.FNAME_match_code = SALT311.MatchCode.WildMatch =>le.FNAME_weight100 / Config.WildPenalty,
           SELF.FNAME_match_code = SALT311.MatchCode.CustomFuzzyMatch =>le.FNAME_PreferredName_weight100,
           -0.737*le.FNAME_weight100))/100*0.80; 
    SELF.LNAME_match_code := MAP(
           le.LNAME = (TYPEOF(le.LNAME))'' OR ri.LNAME = (TYPEOF(ri.LNAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_LNAME(le.LNAME,ri.LNAME,le.LNAME_len,ri.LNAME_len,FALSE));
    SELF.LNAMEWeight := (50+MAP (
           SELF.LNAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.LNAME_match_code = SALT311.MatchCode.ExactMatch =>le.LNAME_weight100,
           SELF.LNAME_match_code = SALT311.MatchCode.HyphenMatch =>le.LNAME_weight100*MIN(1,LENGTH(TRIM(ri.LNAME))/LENGTH(TRIM(le.LNAME))),
           SELF.LNAME_match_code = SALT311.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(ri.LNAME),le.LNAME_e1p_weight100,le.LNAME_e1_weight100),
           SELF.LNAME_match_code = SALT311.MatchCode.PhoneticMatch =>le.LNAME_p_weight100,
           SELF.LNAME_match_code = SALT311.MatchCode.WildMatch =>le.LNAME_weight100 / Config.WildPenalty,
           -0.617*le.LNAME_weight100))/100*0.80; 
    SELF.PRIM_NAME_match_code := MAP(
           le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR ri.PRIM_NAME = (TYPEOF(ri.PRIM_NAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_PRIM_NAME(le.PRIM_NAME,ri.PRIM_NAME,le.PRIM_NAME_len,ri.PRIM_NAME_len,FALSE));
    SELF.PRIM_NAMEWeight := (50+MAP (
           SELF.PRIM_NAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.PRIM_NAME_match_code = SALT311.MatchCode.ExactMatch =>le.PRIM_NAME_weight100,
           SELF.PRIM_NAME_match_code = SALT311.MatchCode.EditDistanceMatch =>le.PRIM_NAME_e1_weight100,
           SELF.PRIM_NAME_match_code = SALT311.MatchCode.WildMatch =>le.PRIM_NAME_weight100 / Config.WildPenalty,
           -0.531*le.PRIM_NAME_weight100))/100; 
    SELF.SEC_RANGE_match_code := MAP(
           le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR ri.SEC_RANGE = (TYPEOF(ri.SEC_RANGE))'' => SALT311.MatchCode.OneSideNull,
           le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR ri.PRIM_NAME = (TYPEOF(ri.PRIM_NAME))'' OR le.PRIM_NAME <> ri.PRIM_NAME  => SALT311.MatchCode.ContextNoMatch, // Only valid if the context variable is equal
           match_methods(File_InsuranceHeader).match_SEC_RANGE(le.SEC_RANGE,ri.SEC_RANGE,FALSE));
    SELF.SEC_RANGEWeight := (50+MAP (
           SELF.SEC_RANGE_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.SEC_RANGE_match_code = SALT311.MatchCode.ContextNoMatch => 0,
           SELF.SEC_RANGE_match_code = SALT311.MatchCode.ExactMatch =>le.SEC_RANGE_weight100,
           SELF.SEC_RANGE_match_code = SALT311.MatchCode.HyphenMatch =>le.SEC_RANGE_weight100*MIN(1,LENGTH(TRIM(ri.SEC_RANGE))/LENGTH(TRIM(le.SEC_RANGE))),
           -0.629*le.SEC_RANGE_weight100))/100; 
    SELF.CITY_match_code := MAP(
           le.CITY = (TYPEOF(le.CITY))'' OR ri.CITY = (TYPEOF(ri.CITY))'' => SALT311.MatchCode.OneSideNull,
           le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' OR le.ST <> ri.ST  => SALT311.MatchCode.ContextNoMatch, // Only valid if the context variable is equal
           match_methods(File_InsuranceHeader).match_CITY(le.CITY,ri.CITY,FALSE));
    SELF.CITYWeight := (50+MAP (
           SELF.CITY_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.CITY_match_code = SALT311.MatchCode.ContextNoMatch => 0,
           SELF.CITY_match_code = SALT311.MatchCode.ExactMatch =>le.CITY_weight100,
           -0.580*le.CITY_weight100))/100; 
    SELF.ST_match_code := MAP(
           le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_ST(le.ST,ri.ST,FALSE));
    SELF.STWeight := (50+MAP (
           SELF.ST_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.ST_match_code = SALT311.MatchCode.ExactMatch =>le.ST_weight100,
           -0.690*le.ST_weight100))/100; 
    SELF.DERIVED_GENDER_match_code := MAP(
           le.DERIVED_GENDER = (TYPEOF(le.DERIVED_GENDER))'' OR ri.DERIVED_GENDER = (TYPEOF(ri.DERIVED_GENDER))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_DERIVED_GENDER(le.DERIVED_GENDER,ri.DERIVED_GENDER,FALSE));
    SELF.DERIVED_GENDERWeight := (50+MAP (
           SELF.DERIVED_GENDER_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.DERIVED_GENDER_match_code = SALT311.MatchCode.ExactMatch =>le.DERIVED_GENDER_weight100,
           SELF.DERIVED_GENDER_match_code = SALT311.MatchCode.InitialLMatch =>le.DERIVED_GENDER_weight100,
           SELF.DERIVED_GENDER_match_code = SALT311.MatchCode.InitialRMatch=> SALT311.Fn_Interpolate_Initial(le.DERIVED_GENDER,ri.DERIVED_GENDER,le.DERIVED_GENDER_weight100,le.DERIVED_GENDER_initial_char_weight100),
           -0.983*le.DERIVED_GENDER_weight100))/100; 
    SELF.SNAME_match_code := MAP(
           le.SNAME = (TYPEOF(le.SNAME))'' OR ri.SNAME = (TYPEOF(ri.SNAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_SNAME(le.SNAME,ri.SNAME,FALSE));
    SELF.SNAMEWeight := (50+MAP (
           SELF.SNAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.SNAME_match_code = SALT311.MatchCode.ExactMatch =>le.SNAME_weight100,
           -0.946*le.SNAME_weight100))/100; 
    SELF.DOB_year_match_code := MAP(
      le.DOB_year = 0 OR ((UNSIGNED)ri.DOB) DIV 10000 = 0 /*DOBHACK04*/ => SALT311.MatchCode.OneSideNull,
      match_methods(File_InsuranceHeader).match_DOB_year(le.DOB_year,((UNSIGNED)ri.DOB) DIV 10000,FALSE));
    SELF.DOBWeight_year := (50+MAP ( SELF.DOB_year_match_code = SALT311.MatchCode.OneSideNull => 0,
       SELF.DOB_year_match_code = SALT311.MatchCode.ExactMatch => le.DOB_year_weight100,
       SELF.DOB_year_match_code = SALT311.MatchCode.YearMatch => le.DOB_year_weight100-358, //YEAR_SHIFT
       -1.000*le.DOB_year_weight100))/100;
    SELF.DOB_month_match_code := MAP(
      le.DOB_month = 0 OR ((UNSIGNED)ri.DOB) DIV 100 % 100 = 0 /*DOBHACK05*/ => SALT311.MatchCode.OneSideNull,
      match_methods(File_InsuranceHeader).match_DOB_month(le.DOB_month,((UNSIGNED)ri.DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)ri.DOB) % 100,FALSE));
    SELF.DOBWeight_month := (50+MAP ( SELF.DOB_month_match_code = SALT311.MatchCode.OneSideNull => 0,
      SELF.DOB_month_match_code = SALT311.MatchCode.ExactMatch => le.DOB_month_weight100,
      SELF.DOB_month_match_code = SALT311.MatchCode.MonthDaySwitch => le.DOB_month_weight100-100, // MDDM
      SELF.DOB_month_match_code = SALT311.MatchCode.SoftMatch => -200, // SOFT1 
       -1.000*le.DOB_month_weight100))/100;
    SELF.DOB_day_match_code := MAP(
		le.DOB_day = 0 OR ((UNSIGNED)ri.DOB) % 100 = 0 /*DOBHACK06*/ => SALT311.MatchCode.OneSideNull,
      match_methods(File_InsuranceHeader).match_DOB_day(le.DOB_month,((UNSIGNED)ri.DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)ri.DOB) % 100,FALSE));
    SELF.DOBWeight_day := (50+MAP ( SELF.DOB_day_match_code = SALT311.MatchCode.OneSideNull => 0,
      SELF.DOB_day_match_code = SALT311.MatchCode.ExactMatch => le.DOB_day_weight100,
      SELF.DOB_day_match_code = SALT311.MatchCode.MonthDaySwitch => le.DOB_day_weight100-100, // MDDM
      SELF.DOB_day_match_code = SALT311.MatchCode.SoftMatch => -200, // SOFT1 
       -1.000*le.DOB_day_weight100))/100;
		DOB_AggWeight := SELF.DOBWeight_day + SELF.DOBWeight_month + SELF.DOBWeight_year;
    SELF.DOB_match_code := MAP(
      le.DOB_year+le.DOB_month+le.DOB_day = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(File_InsuranceHeader).match_DOB_el(le.DOB_year, le.DOB_month, le.DOB_day, ri.DOB, DOB_AggWeight ,FALSE));
    SELF.DOBWeight :=  MAP(
           SELF.DOB_match_code = SALT311.MatchCode.OneSideNull => 0,
           DOB_AggWeight); 
    SELF.Weight := IF(le.DID = 0, 100, MAX(0, SELF.ZIPWeight) + MAX(0, SELF.PRIM_RANGEWeight) + MAX(0, SELF.FNAMEWeight) + MAX(0, SELF.LNAMEWeight) + MAX(0, SELF.PRIM_NAMEWeight) + MAX(0, SELF.SEC_RANGEWeight) + MAX(0, SELF.CITYWeight) + MAX(0, SELF.STWeight) + MAX(0, SELF.DERIVED_GENDERWeight) + MAX(0, SELF.SNAMEWeight) + MAX(0, SELF.DOBWeight));
    SELF := le;
  END;
  Recs0 := Recs(EXISTS(ZIP_cases),PRIM_RANGE <> (TYPEOF(PRIM_RANGE))'');
  InputLayout_Batch NormMultiple0(InputLayout_Batch L,INTEGER C) := TRANSFORM
    SELF.ZIP_cases := L.ZIP_cases[C];
    SELF := L;
  END;
  Recs1 := NORMALIZE(Recs0,COUNT(LEFT.ZIP_cases),NormMultiple0(LEFT,COUNTER));
  SALT311.MAC_Dups_Note(Recs1,InputLayout_Batch,Recs2,outdups,Reference,Config.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs2,Key,((RIGHT.ZIP = LEFT.ZIP_cases[1].ZIP))
     AND ((RIGHT.PRIM_RANGE = LEFT.PRIM_RANGE))
     AND ((LEFT.FNAME = (TYPEOF(RIGHT.FNAME))'' OR RIGHT.FNAME = (TYPEOF(RIGHT.FNAME))'') OR (RIGHT.FNAME = LEFT.FNAME) OR ((RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME OR LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME)  OR  (RIGHT.FNAME_PreferredName = fn_PreferredName(LEFT.FNAME))  OR  (metaphonelib.DMetaPhone1(RIGHT.FNAME)=metaphonelib.DMetaPhone1(LEFT.FNAME))  OR (Config.WithinEditN(RIGHT.FNAME,RIGHT.FNAME_len,LEFT.FNAME,LEFT.FNAME_len,1, Config.FNAME_LENGTH_EDIT2) /*HACK05*/) OR (Config.WildMatch(RIGHT.FNAME,LEFT.FNAME,FALSE)) ))
     AND ((LEFT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'') OR (RIGHT.LNAME = LEFT.LNAME) OR ( (metaphonelib.DMetaPhone1(RIGHT.LNAME)=metaphonelib.DMetaPhone1(LEFT.LNAME))  OR (Config.WithinEditN(RIGHT.LNAME,RIGHT.LNAME_len,LEFT.LNAME,LEFT.LNAME_len,1, Config.LNAME_LENGTH_EDIT2) /*HACK09*/)  OR (SALT311.HyphenMatch(RIGHT.LNAME,LEFT.LNAME,1)<=2)OR (Config.WildMatch(RIGHT.LNAME,LEFT.LNAME,FALSE)) )),Score_Batch(RIGHT,LEFT),
    ATMOST(((RIGHT.ZIP = LEFT.ZIP_cases[1].ZIP))
     AND ((RIGHT.PRIM_RANGE = LEFT.PRIM_RANGE)),Config.ZIP_PR_MAXBLOCKSIZE)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs2,PULL(Key),((RIGHT.ZIP = LEFT.ZIP_cases[1].ZIP))
     AND ((RIGHT.PRIM_RANGE = LEFT.PRIM_RANGE))
     AND ((LEFT.FNAME = (TYPEOF(RIGHT.FNAME))'' OR RIGHT.FNAME = (TYPEOF(RIGHT.FNAME))'') OR (RIGHT.FNAME = LEFT.FNAME) OR ((RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME OR LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME)  OR  (RIGHT.FNAME_PreferredName = fn_PreferredName(LEFT.FNAME))  OR  (metaphonelib.DMetaPhone1(RIGHT.FNAME)=metaphonelib.DMetaPhone1(LEFT.FNAME))  OR (Config.WithinEditN(RIGHT.FNAME,RIGHT.FNAME_len,LEFT.FNAME,LEFT.FNAME_len,1, Config.FNAME_LENGTH_EDIT2) /*HACK05*/) OR (Config.WildMatch(RIGHT.FNAME,LEFT.FNAME,FALSE)) ))
     AND ((LEFT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'') OR (RIGHT.LNAME = LEFT.LNAME) OR ( (metaphonelib.DMetaPhone1(RIGHT.LNAME)=metaphonelib.DMetaPhone1(LEFT.LNAME))  OR (Config.WithinEditN(RIGHT.LNAME,RIGHT.LNAME_len,LEFT.LNAME,LEFT.LNAME_len,1, Config.LNAME_LENGTH_EDIT2) /*HACK09*/)  OR (SALT311.HyphenMatch(RIGHT.LNAME,LEFT.LNAME,1)<=2)OR (Config.WildMatch(RIGHT.LNAME,LEFT.LNAME,FALSE)) )),Score_Batch(RIGHT,LEFT),
    ATMOST(((RIGHT.ZIP = LEFT.ZIP_cases[1].ZIP))
     AND ((RIGHT.PRIM_RANGE = LEFT.PRIM_RANGE)),Config.ZIP_PR_MAXBLOCKSIZE),HASH,UNORDERED); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  useDate := (UNSIGNED4)SALT311.fn_now('YYYYMMDD');
  J2_dist := DISTRIBUTE(J2, HASH(Reference));
  poisoned_results := TABLE(SORT(J2_dist, Reference, DID, LOCAL), {Reference, DID, keys_poisoned}, Reference, DID, keys_poisoned, LOCAL);
  result_rollup0 := DEDUP(SORT(J2_dist,Reference,DID,ZIP_cases[1],PRIM_RANGE,FNAME,LNAME,PRIM_NAME,SEC_RANGE,CITY,ST,DERIVED_GENDER,SNAME,DOB_year,DOB_month,DOB_day,DT_EFFECTIVE_FIRST,-DT_EFFECTIVE_LAST, LOCAL),Reference,DID,ZIP_cases[1],PRIM_RANGE,FNAME,LNAME,PRIM_NAME,SEC_RANGE,CITY,ST,DERIVED_GENDER,SNAME,DOB_year,DOB_month,DOB_day,DT_EFFECTIVE_FIRST, LOCAL);
  result_rollup1 := JOIN(result_rollup0, poisoned_results, LEFT.Reference = RIGHT.Reference AND LEFT.DID = RIGHT.DID, TRANSFORM(RECORDOF(LEFT), SELF.keys_poisoned := RIGHT.keys_poisoned, SELF := LEFT), LEFT OUTER, LOCAL);
  result_rollup := result_rollup1((DT_EFFECTIVE_FIRST = 0 OR useDate >= DT_EFFECTIVE_FIRST) AND (useDate <= DT_EFFECTIVE_LAST OR DT_EFFECTIVE_LAST = 0));
  J3 := IF(EXISTS(poisoned_results), result_rollup, J2);
  J4 := PROJECT(J3, Process_xIDL_Layouts().update_forcefailed(LEFT,In_disableForce));
  J5 := Process_xIDL_Layouts().CombineLinkpathScores(J4,In_disableForce); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT311.MAC_Dups_Restore(J5,DD,J6,Reference,TRUE)
  RETURN J6;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_ZIP='',Input_PRIM_RANGE='',Input_FNAME='',Input_LNAME='',Input_PRIM_NAME='',Input_SEC_RANGE='',Input_CITY='',Input_ST='',Input_DERIVED_GENDER='',Input_SNAME='',Input_DOB='',output_file,AsIndex='true', In_disableForce = 'false') := MACRO
  IMPORT SALT311,InsuranceHeader_xLink;
  #IF(#TEXT(Input_ZIP)<>'' AND #TEXT(Input_PRIM_RANGE)<>'')
    #UNIQUENAME(trans)
    InsuranceHeader_xLink.Key_InsuranceHeader_ZIP_PR().InputLayout_Batch %trans%(InFile le) := TRANSFORM
      SELF.Reference := le.Input_Ref;
      SELF.ZIP_cases := le.Input_ZIP;
      SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))le.Input_PRIM_RANGE;
      SELF.PRIM_RANGE_len := LENGTH(TRIM((TYPEOF(SELF.PRIM_RANGE))le.Input_PRIM_RANGE));
      #IF ( #TEXT(Input_FNAME) <> '' )
        SELF.FNAME := (TYPEOF(SELF.FNAME))le.Input_FNAME;
        SELF.FNAME_len := LENGTH(TRIM((TYPEOF(SELF.FNAME))le.Input_FNAME));
      #END
      #IF ( #TEXT(Input_LNAME) <> '' )
        SELF.LNAME := (TYPEOF(SELF.LNAME))le.Input_LNAME;
        SELF.LNAME_len := LENGTH(TRIM((TYPEOF(SELF.LNAME))le.Input_LNAME));
      #END
      #IF ( #TEXT(Input_PRIM_NAME) <> '' )
        SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))le.Input_PRIM_NAME;
        SELF.PRIM_NAME_len := LENGTH(TRIM((TYPEOF(SELF.PRIM_NAME))le.Input_PRIM_NAME));
      #END
      #IF ( #TEXT(Input_SEC_RANGE) <> '' )
        SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))le.Input_SEC_RANGE;
      #END
      #IF ( #TEXT(Input_CITY) <> '' )
        SELF.CITY := (TYPEOF(SELF.CITY))le.Input_CITY;
      #END
      #IF ( #TEXT(Input_ST) <> '' )
        SELF.ST := (TYPEOF(SELF.ST))le.Input_ST;
      #END
      #IF ( #TEXT(Input_DERIVED_GENDER) <> '' )
        SELF.DERIVED_GENDER := (TYPEOF(SELF.DERIVED_GENDER))le.Input_DERIVED_GENDER;
      #END
      #IF ( #TEXT(Input_SNAME) <> '' )
        SELF.SNAME := (TYPEOF(SELF.SNAME))le.Input_SNAME;
      #END
      #IF ( #TEXT(Input_DOB) <> '' )
          SELF.DOB := (UNSIGNED4)le.Input_DOB;
      #END
    END;
    #UNIQUENAME(p)
    %p% := PROJECT(Infile,%trans%(left));
    output_file := InsuranceHeader_xLink.Key_InsuranceHeader_ZIP_PR().ScoredFetch_Batch(%p%,AsIndex, In_disableForce);
  #ELSE
    output_file := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch); // Compulsory fields missing
  #END
ENDMACRO;
END;
