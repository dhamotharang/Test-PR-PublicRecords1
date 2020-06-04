IMPORT SALT311,std;
EXPORT Key_HealthProvider_DOB_LP := MODULE
 
//DOB:FNAME:LNAME:?:MNAME:+:ST:V_CITY_NAME:SSN:GENDER:SNAME
EXPORT KeyName := Health_Provider_Services.Files.FILE_DOB_SF;  //'~'+'key::Health_Provider_Services::LNPID::Refs::DOB_LP';
SHARED h := CandidatesForKey;//The input file - distributed by LNPID
 
SHARED s := Specificities(File_HealthProvider).Specificities[1];
SHARED s_index := Keys(File_HealthProvider).Specificities_Key[1]; // Index access for MEOW queries
layout := RECORD // project out required fields
// Compulsory fields
  h.DOB_year;
  h.DOB_month;
  h.DOB_day;
  h.FNAME;
  h.LNAME;
// Optional fields
  h.LNPID; // The ID field
  h.MNAME;
// Extra credit fields
  h.ST;
  h.V_CITY_NAME;
  h.SSN;
  h.GENDER;
  h.SNAME_NormSuffix;
  h.SNAME;
  h.FNAME_len;
  h.LNAME_len;
  h.MNAME_len;
  h.SSN_len;
//Scores for various field components
  h.DOB_year_weight100; // Contains 100x the specificity
  h.DOB_month_weight100; // Contains 100x the specificity
  h.DOB_day_weight100; // Contains 100x the specificity
  h.FNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_MAINNAME_fuzzy_weight100 ; // Contains 100x the specificity
  h.FNAME_initial_char_weight100 ; // Contains 100x the specificity
  h.FNAME_p_Weight100;
  h.FNAME_e1_Weight100;
  h.FNAME_e1p_Weight100;
  h.FNAME_e2_Weight100;
  h.FNAME_e2p_Weight100;
  h.FNAME_PreferredName_Weight100;
  h.FNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.LNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_MAINNAME_fuzzy_weight100 ; // Contains 100x the specificity
  h.LNAME_initial_char_weight100 ; // Contains 100x the specificity
  h.LNAME_p_Weight100;
  h.LNAME_e1_Weight100;
  h.LNAME_e1p_Weight100;
  h.LNAME_e2_Weight100;
  h.LNAME_e2p_Weight100;
  h.LNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.MNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_MAINNAME_fuzzy_weight100 ; // Contains 100x the specificity
  h.MNAME_initial_char_weight100 ; // Contains 100x the specificity
  h.MNAME_p_Weight100;
  h.MNAME_e1_Weight100;
  h.MNAME_e1p_Weight100;
  h.MNAME_e2_Weight100;
  h.MNAME_e2p_Weight100;
  h.MNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.ST_weight100 ; // Contains 100x the specificity
  h.V_CITY_NAME_weight100 ; // Contains 100x the specificity
  h.SSN_weight100 ; // Contains 100x the specificity
  INTEGER2 SSN_e1_Weight100 := SALT311.Min0(h.SSN_weight100 + 100*log(h.SSN_cnt/h.SSN_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.GENDER_weight100 ; // Contains 100x the specificity
  h.SNAME_weight100 ; // Contains 100x the specificity
  h.SNAME_NormSuffix_Weight100;
END;
 
DataForKey0 := DEDUP(SORT(TABLE(h((DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) OR DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) OR DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)),(FNAME NOT IN SET(s.nulls_FNAME,FNAME) AND FNAME <> (TYPEOF(FNAME))''),(LNAME NOT IN SET(s.nulls_LNAME,LNAME) AND LNAME <> (TYPEOF(LNAME))'')),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
SHARED DataForKey := DataForKey0;
 
EXPORT Key := INDEX(DataForKey,{DataForKey},{},KeyName);
 
EXPORT BuildAll := BUILDINDEX(Key, OVERWRITE);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,LNPID,DOB_year,DOB_month,DOB_day,FNAME,LNAME,MNAME,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_ST := GROUP( DEDUP( SORT( Grpd, EXCEPT ST), EXCEPT ST));
  CntRed_ST := (KeyCnt-COUNT(Rem_ST))/KeyCnt;
  Rem_V_CITY_NAME := GROUP( DEDUP( SORT( Grpd, EXCEPT V_CITY_NAME), EXCEPT V_CITY_NAME));
  CntRed_V_CITY_NAME := (KeyCnt-COUNT(Rem_V_CITY_NAME))/KeyCnt;
  Rem_SSN := GROUP( DEDUP( SORT( Grpd, EXCEPT SSN), EXCEPT SSN));
  CntRed_SSN := (KeyCnt-COUNT(Rem_SSN))/KeyCnt;
  Rem_GENDER := GROUP( DEDUP( SORT( Grpd, EXCEPT GENDER), EXCEPT GENDER));
  CntRed_GENDER := (KeyCnt-COUNT(Rem_GENDER))/KeyCnt;
  Rem_SNAME := GROUP( DEDUP( SORT( Grpd, EXCEPT SNAME), EXCEPT SNAME));
  CntRed_SNAME := (KeyCnt-COUNT(Rem_SNAME))/KeyCnt;
EXPORT Shrinkage := DATASET([{'DOB_LP','ST',CntRed_ST*100,CntRed_ST*TSize},{'DOB_LP','V_CITY_NAME',CntRed_V_CITY_NAME*100,CntRed_V_CITY_NAME*TSize},{'DOB_LP','SSN',CntRed_SSN*100,CntRed_SSN*TSize},{'DOB_LP','GENDER',CntRed_GENDER*100,CntRed_GENDER*TSize},{'DOB_LP','SNAME',CntRed_SNAME*100,CntRed_SNAME*TSize}],SALT311.ShrinkLayout);
EXPORT CanSearch(Process_xLNPID_Layouts.InputLayout le) := le.DOB <> (TYPEOF(le.DOB))'' AND Fields.InValid_DOB((SALT311.StrType)le.DOB)=0 AND le.FNAME <> (TYPEOF(le.FNAME))'' AND Fields.InValid_FNAME((SALT311.StrType)le.FNAME)=0 AND le.LNAME <> (TYPEOF(le.LNAME))'' AND Fields.InValid_LNAME((SALT311.StrType)le.LNAME)=0;
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(UNSIGNED4 param_DOB,TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'') := 
    STEPPED( LIMIT( Key(
           param_DOB <> 0 AND KEYED(DOB_year = param_DOB DIV 10000 AND DOB_month = param_DOB DIV 100 % 100 AND DOB_day = param_DOB % 100)
      AND KEYED((FNAME = param_FNAME))
      AND KEYED((LNAME = param_LNAME))
      AND ((param_MNAME = (TYPEOF(MNAME))'' OR MNAME = (TYPEOF(MNAME))'') OR (MNAME = param_MNAME) OR ((MNAME[1..LENGTH(TRIM(param_MNAME))] = param_MNAME OR param_MNAME[1..LENGTH(TRIM(MNAME))] = MNAME)  OR  (metaphonelib.DMetaPhone1(MNAME)=metaphonelib.DMetaPhone1(param_MNAME))  OR (Config.WithinEditN(MNAME,MNAME_len,param_MNAME,param_MNAME_len,2, 5)) ))),Config.DOB_LP_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),LNPID);
 
 
EXPORT ScoredLNPIDFetch(UNSIGNED4 param_DOB,TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',TYPEOF(h.V_CITY_NAME) param_V_CITY_NAME = (TYPEOF(h.V_CITY_NAME))'',TYPEOF(h.SSN) param_SSN = (TYPEOF(h.SSN))'',TYPEOF(h.SSN_len) param_SSN_len = (TYPEOF(h.SSN_len))'',TYPEOF(h.GENDER) param_GENDER = (TYPEOF(h.GENDER))'',TYPEOF(h.SNAME) param_SNAME = (TYPEOF(h.SNAME))'') := FUNCTION
  RawData := RawFetch(param_DOB,param_FNAME,param_FNAME_len,param_LNAME,param_LNAME_len,param_MNAME,param_MNAME_len);
 
  Process_xLNPID_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 10; // Set bitmap for keys used
    SELF.keys_failed := IF(le.LNPID = 0, 1 << 10, 0); // Set bitmap for key failed
    SELF.DOB_year_match_code := MAP(
      le.DOB_year = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(File_HealthProvider).match_DOB_year(le.DOB_year,((UNSIGNED)param_DOB) DIV 10000,TRUE));
    SELF.DOBWeight_year := (50+MAP ( SELF.DOB_year_match_code = SALT311.MatchCode.OneSideNull => 0,
       SELF.DOB_year_match_code = SALT311.MatchCode.ExactMatch => le.DOB_year_weight100,
       -0.995*le.DOB_year_weight100))/100;
    SELF.DOB_month_match_code := MAP(
      le.DOB_month = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(File_HealthProvider).match_DOB_month(le.DOB_month,((UNSIGNED)param_DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)param_DOB) % 100,TRUE));
    SELF.DOBWeight_month := (50+MAP ( SELF.DOB_month_match_code = SALT311.MatchCode.OneSideNull => 0,
      SELF.DOB_month_match_code = SALT311.MatchCode.ExactMatch => le.DOB_month_weight100,
       -0.995*le.DOB_month_weight100))/100;
    SELF.DOB_day_match_code := MAP(
      le.DOB_day = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(File_HealthProvider).match_DOB_day(le.DOB_month,((UNSIGNED)param_DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)param_DOB) % 100,TRUE));
    SELF.DOBWeight_day := (50+MAP ( SELF.DOB_day_match_code = SALT311.MatchCode.OneSideNull => 0,
      SELF.DOB_day_match_code = SALT311.MatchCode.ExactMatch => le.DOB_day_weight100,
       -0.995*le.DOB_day_weight100))/100;
		DOB_AggWeight := SELF.DOBWeight_day + SELF.DOBWeight_month + SELF.DOBWeight_year;
    SELF.DOB_match_code := MAP(
      le.DOB_year+le.DOB_month+le.DOB_day = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(File_HealthProvider).match_DOB_el(le.DOB_year, le.DOB_month, le.DOB_day, param_DOB, DOB_AggWeight ,TRUE));
    SELF.DOBWeight :=  MAP(
           SELF.DOB_match_code = SALT311.MatchCode.OneSideNull => 0,
           DOB_AggWeight); 
    SELF.FNAME_match_code := match_methods(File_HealthProvider).match_FNAME(le.FNAME,param_FNAME,le.FNAME_len,param_FNAME_len,TRUE);
    SELF.FNAMEWeight := (50+MAP (
           SELF.FNAME_match_code = SALT311.MatchCode.ExactMatch =>le.FNAME_weight100,
           -0.961*le.FNAME_weight100))/100; 
    SELF.LNAME_match_code := match_methods(File_HealthProvider).match_LNAME(le.LNAME,param_LNAME,le.LNAME_len,param_LNAME_len,TRUE);
    SELF.LNAMEWeight := (50+MAP (
           SELF.LNAME_match_code = SALT311.MatchCode.ExactMatch =>le.LNAME_weight100,
           -0.874*le.LNAME_weight100))/100; 
    SELF.MNAME_match_code := MAP(
           le.MNAME = (TYPEOF(le.MNAME))'' OR param_MNAME = (TYPEOF(param_MNAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_HealthProvider).match_MNAME(le.MNAME,param_MNAME,le.MNAME_len,param_MNAME_len,FALSE));
    SELF.MNAMEWeight := (50+MAP (
           SELF.MNAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.MNAME_match_code = SALT311.MatchCode.ExactMatch =>le.MNAME_weight100,
           SELF.MNAME_match_code = SALT311.MatchCode.InitialLMatch =>le.MNAME_weight100,
           SELF.MNAME_match_code = SALT311.MatchCode.InitialRMatch=> SALT311.Fn_Interpolate_Initial(le.MNAME,param_MNAME,le.MNAME_weight100,le.MNAME_initial_char_weight100),
           SELF.MNAME_match_code = SALT311.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.MNAME)=metaphonelib.DMetaPhone1(param_MNAME),MAP((5 > le.MNAME_len) AND (5 > param_MNAME_len) => le.MNAME_e1p_weight100, le.MNAME_e2p_weight100),MAP((5 > le.MNAME_len) AND (5 > param_MNAME_len) => le.MNAME_e1_weight100, le.MNAME_e2_weight100)),
           SELF.MNAME_match_code = SALT311.MatchCode.PhoneticMatch =>le.MNAME_p_weight100,
           -0.932*le.MNAME_weight100))/100; 
    SELF.ST_match_code := MAP(
           le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_HealthProvider).match_ST(le.ST,param_ST,FALSE));
    SELF.STWeight := (50+MAP (
           SELF.ST_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.ST_match_code = SALT311.MatchCode.ExactMatch =>le.ST_weight100,
           -0.823*le.ST_weight100))/100; 
    SELF.V_CITY_NAME_match_code := MAP(
           le.V_CITY_NAME = (TYPEOF(le.V_CITY_NAME))'' OR param_V_CITY_NAME = (TYPEOF(param_V_CITY_NAME))'' => SALT311.MatchCode.OneSideNull,
           le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' OR le.ST <> param_ST  => SALT311.MatchCode.ContextNoMatch, // Only valid if the context variable is equal
           match_methods(File_HealthProvider).match_V_CITY_NAME(le.V_CITY_NAME,param_V_CITY_NAME,FALSE));
    SELF.V_CITY_NAMEWeight := (50+MAP (
           SELF.V_CITY_NAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.V_CITY_NAME_match_code = SALT311.MatchCode.ContextNoMatch => 0,
           SELF.V_CITY_NAME_match_code = SALT311.MatchCode.ExactMatch =>le.V_CITY_NAME_weight100,
           -0.562*le.V_CITY_NAME_weight100))/100; 
    SELF.SSN_match_code := MAP(
           le.SSN = (TYPEOF(le.SSN))'' OR param_SSN = (TYPEOF(param_SSN))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_HealthProvider).match_SSN(le.SSN,param_SSN,le.SSN_len,param_SSN_len,FALSE));
    SELF.SSNWeight := (50+MAP (
           SELF.SSN_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.SSN_match_code = SALT311.MatchCode.ExactMatch =>le.SSN_weight100,
           SELF.SSN_match_code = SALT311.MatchCode.EditDistanceMatch =>le.SSN_e1_weight100,
           -0.965*le.SSN_weight100))/100; 
    SELF.GENDER_match_code := MAP(
           le.GENDER = (TYPEOF(le.GENDER))'' OR param_GENDER = (TYPEOF(param_GENDER))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_HealthProvider).match_GENDER(le.GENDER,param_GENDER,FALSE));
    SELF.GENDERWeight := (50+MAP (
           SELF.GENDER_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.GENDER_match_code = SALT311.MatchCode.ExactMatch =>le.GENDER_weight100,
           -0.987*le.GENDER_weight100))/100; 
    SELF.SNAME_match_code := MAP(
           le.SNAME = (TYPEOF(le.SNAME))'' OR param_SNAME = (TYPEOF(param_SNAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_HealthProvider).match_SNAME(le.SNAME,param_SNAME,FALSE));
    SELF.SNAMEWeight := (50+MAP (
           SELF.SNAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.SNAME_match_code = SALT311.MatchCode.ExactMatch =>le.SNAME_weight100,
           SELF.SNAME_match_code = SALT311.MatchCode.CustomFuzzyMatch =>le.SNAME_NormSuffix_weight100,
           -0.990*le.SNAME_weight100))/100; 
    SELF.Weight := IF(le.LNPID = 0, 100, MAX(0, SELF.DOBWeight) + MAX(0, SELF.FNAMEWeight) + MAX(0, SELF.LNAMEWeight) + MAX(0, SELF.MNAMEWeight) + MAX(0, SELF.STWeight) + MAX(0, SELF.V_CITY_NAMEWeight) + MAX(0, SELF.SSNWeight) + MAX(0, SELF.GENDERWeight) + MAX(0, SELF.SNAMEWeight));
    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));
  result1 := ROLLUP(result0,LEFT.LNPID = RIGHT.LNPID,Process_xLNPID_Layouts.combine_scores(LEFT,RIGHT));
  RETURN result1;
END;
 
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT311.UIDType Reference;//How to recognize this record in the subsequent
  UNSIGNED4 DOB := 0;
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))'';
  TYPEOF(h.FNAME_len) FNAME_len := (TYPEOF(h.FNAME_len))'';
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))'';
  TYPEOF(h.LNAME_len) LNAME_len := (TYPEOF(h.LNAME_len))'';
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))'';
  TYPEOF(h.MNAME_len) MNAME_len := (TYPEOF(h.MNAME_len))'';
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))'';
  TYPEOF(h.V_CITY_NAME) V_CITY_NAME := (TYPEOF(h.V_CITY_NAME))'';
  TYPEOF(h.SSN) SSN := (TYPEOF(h.SSN))'';
  TYPEOF(h.SSN_len) SSN_len := (TYPEOF(h.SSN_len))'';
  TYPEOF(h.GENDER) GENDER := (TYPEOF(h.GENDER))'';
  TYPEOF(h.SNAME) SNAME := (TYPEOF(h.SNAME))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex) := FUNCTION
 
  Process_xLNPID_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 10; // Set bitmap for keys used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.DOB_year_match_code := MAP(
      le.DOB_year = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(File_HealthProvider).match_DOB_year(le.DOB_year,((UNSIGNED)ri.DOB) DIV 10000,TRUE));
    SELF.DOBWeight_year := (50+MAP ( SELF.DOB_year_match_code = SALT311.MatchCode.OneSideNull => 0,
       SELF.DOB_year_match_code = SALT311.MatchCode.ExactMatch => le.DOB_year_weight100,
       -0.995*le.DOB_year_weight100))/100;
    SELF.DOB_month_match_code := MAP(
      le.DOB_month = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(File_HealthProvider).match_DOB_month(le.DOB_month,((UNSIGNED)ri.DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)ri.DOB) % 100,TRUE));
    SELF.DOBWeight_month := (50+MAP ( SELF.DOB_month_match_code = SALT311.MatchCode.OneSideNull => 0,
      SELF.DOB_month_match_code = SALT311.MatchCode.ExactMatch => le.DOB_month_weight100,
       -0.995*le.DOB_month_weight100))/100;
    SELF.DOB_day_match_code := MAP(
      le.DOB_day = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(File_HealthProvider).match_DOB_day(le.DOB_month,((UNSIGNED)ri.DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)ri.DOB) % 100,TRUE));
    SELF.DOBWeight_day := (50+MAP ( SELF.DOB_day_match_code = SALT311.MatchCode.OneSideNull => 0,
      SELF.DOB_day_match_code = SALT311.MatchCode.ExactMatch => le.DOB_day_weight100,
       -0.995*le.DOB_day_weight100))/100;
		DOB_AggWeight := SELF.DOBWeight_day + SELF.DOBWeight_month + SELF.DOBWeight_year;
    SELF.DOB_match_code := MAP(
      le.DOB_year+le.DOB_month+le.DOB_day = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(File_HealthProvider).match_DOB_el(le.DOB_year, le.DOB_month, le.DOB_day, ri.DOB, DOB_AggWeight ,TRUE));
    SELF.DOBWeight :=  MAP(
           SELF.DOB_match_code = SALT311.MatchCode.OneSideNull => 0,
           DOB_AggWeight); 
    SELF.FNAME_match_code := match_methods(File_HealthProvider).match_FNAME(le.FNAME,ri.FNAME,le.FNAME_len,ri.FNAME_len,TRUE);
    SELF.FNAMEWeight := (50+MAP (
           SELF.FNAME_match_code = SALT311.MatchCode.ExactMatch =>le.FNAME_weight100,
           -0.961*le.FNAME_weight100))/100; 
    SELF.LNAME_match_code := match_methods(File_HealthProvider).match_LNAME(le.LNAME,ri.LNAME,le.LNAME_len,ri.LNAME_len,TRUE);
    SELF.LNAMEWeight := (50+MAP (
           SELF.LNAME_match_code = SALT311.MatchCode.ExactMatch =>le.LNAME_weight100,
           -0.874*le.LNAME_weight100))/100; 
    SELF.MNAME_match_code := MAP(
           le.MNAME = (TYPEOF(le.MNAME))'' OR ri.MNAME = (TYPEOF(ri.MNAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_HealthProvider).match_MNAME(le.MNAME,ri.MNAME,le.MNAME_len,ri.MNAME_len,FALSE));
    SELF.MNAMEWeight := (50+MAP (
           SELF.MNAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.MNAME_match_code = SALT311.MatchCode.ExactMatch =>le.MNAME_weight100,
           SELF.MNAME_match_code = SALT311.MatchCode.InitialLMatch =>le.MNAME_weight100,
           SELF.MNAME_match_code = SALT311.MatchCode.InitialRMatch=> SALT311.Fn_Interpolate_Initial(le.MNAME,ri.MNAME,le.MNAME_weight100,le.MNAME_initial_char_weight100),
           SELF.MNAME_match_code = SALT311.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.MNAME)=metaphonelib.DMetaPhone1(ri.MNAME),MAP((5 > le.MNAME_len) AND (5 > ri.MNAME_len) => le.MNAME_e1p_weight100, le.MNAME_e2p_weight100),MAP((5 > le.MNAME_len) AND (5 > ri.MNAME_len) => le.MNAME_e1_weight100, le.MNAME_e2_weight100)),
           SELF.MNAME_match_code = SALT311.MatchCode.PhoneticMatch =>le.MNAME_p_weight100,
           -0.932*le.MNAME_weight100))/100; 
    SELF.ST_match_code := MAP(
           le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_HealthProvider).match_ST(le.ST,ri.ST,FALSE));
    SELF.STWeight := (50+MAP (
           SELF.ST_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.ST_match_code = SALT311.MatchCode.ExactMatch =>le.ST_weight100,
           -0.823*le.ST_weight100))/100; 
    SELF.V_CITY_NAME_match_code := MAP(
           le.V_CITY_NAME = (TYPEOF(le.V_CITY_NAME))'' OR ri.V_CITY_NAME = (TYPEOF(ri.V_CITY_NAME))'' => SALT311.MatchCode.OneSideNull,
           le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' OR le.ST <> ri.ST  => SALT311.MatchCode.ContextNoMatch, // Only valid if the context variable is equal
           match_methods(File_HealthProvider).match_V_CITY_NAME(le.V_CITY_NAME,ri.V_CITY_NAME,FALSE));
    SELF.V_CITY_NAMEWeight := (50+MAP (
           SELF.V_CITY_NAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.V_CITY_NAME_match_code = SALT311.MatchCode.ContextNoMatch => 0,
           SELF.V_CITY_NAME_match_code = SALT311.MatchCode.ExactMatch =>le.V_CITY_NAME_weight100,
           -0.562*le.V_CITY_NAME_weight100))/100; 
    SELF.SSN_match_code := MAP(
           le.SSN = (TYPEOF(le.SSN))'' OR ri.SSN = (TYPEOF(ri.SSN))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_HealthProvider).match_SSN(le.SSN,ri.SSN,le.SSN_len,ri.SSN_len,FALSE));
    SELF.SSNWeight := (50+MAP (
           SELF.SSN_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.SSN_match_code = SALT311.MatchCode.ExactMatch =>le.SSN_weight100,
           SELF.SSN_match_code = SALT311.MatchCode.EditDistanceMatch =>le.SSN_e1_weight100,
           -0.965*le.SSN_weight100))/100; 
    SELF.GENDER_match_code := MAP(
           le.GENDER = (TYPEOF(le.GENDER))'' OR ri.GENDER = (TYPEOF(ri.GENDER))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_HealthProvider).match_GENDER(le.GENDER,ri.GENDER,FALSE));
    SELF.GENDERWeight := (50+MAP (
           SELF.GENDER_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.GENDER_match_code = SALT311.MatchCode.ExactMatch =>le.GENDER_weight100,
           -0.987*le.GENDER_weight100))/100; 
    SELF.SNAME_match_code := MAP(
           le.SNAME = (TYPEOF(le.SNAME))'' OR ri.SNAME = (TYPEOF(ri.SNAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_HealthProvider).match_SNAME(le.SNAME,ri.SNAME,FALSE));
    SELF.SNAMEWeight := (50+MAP (
           SELF.SNAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.SNAME_match_code = SALT311.MatchCode.ExactMatch =>le.SNAME_weight100,
           SELF.SNAME_match_code = SALT311.MatchCode.CustomFuzzyMatch =>le.SNAME_NormSuffix_weight100,
           -0.990*le.SNAME_weight100))/100; 
    SELF.Weight := IF(le.LNPID = 0, 100, MAX(0, SELF.DOBWeight) + MAX(0, SELF.FNAMEWeight) + MAX(0, SELF.LNAMEWeight) + MAX(0, SELF.MNAMEWeight) + MAX(0, SELF.STWeight) + MAX(0, SELF.V_CITY_NAMEWeight) + MAX(0, SELF.SSNWeight) + MAX(0, SELF.GENDERWeight) + MAX(0, SELF.SNAMEWeight));
    SELF := le;
  END;
  Recs0 := Recs(DOB <> (TYPEOF(DOB))'',FNAME <> (TYPEOF(FNAME))'',LNAME <> (TYPEOF(LNAME))'');
  SALT311.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference,Config.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,(SALT311.MOD_DateMatch((LEFT.DOB DIV 10000 ),(LEFT.DOB DIV 100 % 100 ),(LEFT.DOB % 100),RIGHT.DOB_year,RIGHT.DOB_month,RIGHT.DOB_day,false,false,0,false,0,0).NNEQ)
     AND ((RIGHT.FNAME = LEFT.FNAME))
     AND ((RIGHT.LNAME = LEFT.LNAME))
     AND ((LEFT.MNAME = (TYPEOF(RIGHT.MNAME))'' OR RIGHT.MNAME = (TYPEOF(RIGHT.MNAME))'') OR (RIGHT.MNAME = LEFT.MNAME) OR ((RIGHT.MNAME[1..LENGTH(TRIM(LEFT.MNAME))] = LEFT.MNAME OR LEFT.MNAME[1..LENGTH(TRIM(RIGHT.MNAME))] = RIGHT.MNAME)  OR  (metaphonelib.DMetaPhone1(RIGHT.MNAME)=metaphonelib.DMetaPhone1(LEFT.MNAME))  OR (Config.WithinEditN(RIGHT.MNAME,RIGHT.MNAME_len,LEFT.MNAME,LEFT.MNAME_len,2, 5)) )),Score_Batch(RIGHT,LEFT),
    ATMOST((SALT311.MOD_DateMatch((LEFT.DOB DIV 10000 ),(LEFT.DOB DIV 100 % 100 ),(LEFT.DOB % 100),RIGHT.DOB_year,RIGHT.DOB_month,RIGHT.DOB_day,false,false,0,false,0,0).NNEQ)
     AND ((RIGHT.FNAME = LEFT.FNAME))
     AND ((RIGHT.LNAME = LEFT.LNAME)),Config.DOB_LP_MAXBLOCKSIZE)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),(SALT311.MOD_DateMatch((LEFT.DOB DIV 10000 ),(LEFT.DOB DIV 100 % 100 ),(LEFT.DOB % 100),RIGHT.DOB_year,RIGHT.DOB_month,RIGHT.DOB_day,false,false,0,false,0,0).NNEQ)
     AND ((RIGHT.FNAME = LEFT.FNAME))
     AND ((RIGHT.LNAME = LEFT.LNAME))
     AND ((LEFT.MNAME = (TYPEOF(RIGHT.MNAME))'' OR RIGHT.MNAME = (TYPEOF(RIGHT.MNAME))'') OR (RIGHT.MNAME = LEFT.MNAME) OR ((RIGHT.MNAME[1..LENGTH(TRIM(LEFT.MNAME))] = LEFT.MNAME OR LEFT.MNAME[1..LENGTH(TRIM(RIGHT.MNAME))] = RIGHT.MNAME)  OR  (metaphonelib.DMetaPhone1(RIGHT.MNAME)=metaphonelib.DMetaPhone1(LEFT.MNAME))  OR (Config.WithinEditN(RIGHT.MNAME,RIGHT.MNAME_len,LEFT.MNAME,LEFT.MNAME_len,2, 5)) )),Score_Batch(RIGHT,LEFT),
    ATMOST((SALT311.MOD_DateMatch((LEFT.DOB DIV 10000 ),(LEFT.DOB DIV 100 % 100 ),(LEFT.DOB % 100),RIGHT.DOB_year,RIGHT.DOB_month,RIGHT.DOB_day,false,false,0,false,0,0).NNEQ)
     AND ((RIGHT.FNAME = LEFT.FNAME))
     AND ((RIGHT.LNAME = LEFT.LNAME)),Config.DOB_LP_MAXBLOCKSIZE),HASH,UNORDERED); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := Process_xLNPID_Layouts.CombineLinkpathScores(J2); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT311.MAC_Dups_Restore(J3,DD,J4,Reference,TRUE)
  RETURN J4;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_DOB='',Input_FNAME='',Input_LNAME='',Input_MNAME='',Input_ST='',Input_V_CITY_NAME='',Input_SSN='',Input_GENDER='',Input_SNAME='',output_file,AsIndex='true') := MACRO
  IMPORT SALT311,Health_Provider_Services;
  #IF(#TEXT(Input_DOB)<>'' AND #TEXT(Input_FNAME)<>'' AND #TEXT(Input_LNAME)<>'')
    #UNIQUENAME(trans)
    Health_Provider_Services.Key_HealthProvider_DOB_LP.InputLayout_Batch %trans%(InFile le) := TRANSFORM
      SELF.Reference := le.Input_Ref;
      SELF.DOB := (UNSIGNED4)le.Input_DOB;
      SELF.FNAME := (TYPEOF(SELF.FNAME))le.Input_FNAME;
      SELF.FNAME_len := LENGTH(TRIM((TYPEOF(SELF.FNAME))le.Input_FNAME));
      SELF.LNAME := (TYPEOF(SELF.LNAME))le.Input_LNAME;
      SELF.LNAME_len := LENGTH(TRIM((TYPEOF(SELF.LNAME))le.Input_LNAME));
      #IF ( #TEXT(Input_MNAME) <> '' )
        SELF.MNAME := (TYPEOF(SELF.MNAME))le.Input_MNAME;
        SELF.MNAME_len := LENGTH(TRIM((TYPEOF(SELF.MNAME))le.Input_MNAME));
      #END
      #IF ( #TEXT(Input_ST) <> '' )
        SELF.ST := (TYPEOF(SELF.ST))le.Input_ST;
      #END
      #IF ( #TEXT(Input_V_CITY_NAME) <> '' )
        SELF.V_CITY_NAME := (TYPEOF(SELF.V_CITY_NAME))le.Input_V_CITY_NAME;
      #END
      #IF ( #TEXT(Input_SSN) <> '' )
        SELF.SSN := (TYPEOF(SELF.SSN))le.Input_SSN;
        SELF.SSN_len := LENGTH(TRIM((TYPEOF(SELF.SSN))le.Input_SSN));
      #END
      #IF ( #TEXT(Input_GENDER) <> '' )
        SELF.GENDER := (TYPEOF(SELF.GENDER))le.Input_GENDER;
      #END
      #IF ( #TEXT(Input_SNAME) <> '' )
        SELF.SNAME := (TYPEOF(SELF.SNAME))le.Input_SNAME;
      #END
    END;
    #UNIQUENAME(p)
    %p% := PROJECT(Infile,%trans%(left));
    output_file := Health_Provider_Services.Key_HealthProvider_DOB_LP.ScoredFetch_Batch(%p%,AsIndex);
  #ELSE
    output_file := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch); // Compulsory fields missing
  #END
ENDMACRO;
END;
