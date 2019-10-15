﻿IMPORT SALT311,std;
EXPORT Key_HealthProvider_CNSMR_SSN_LP := MODULE
 
//CNSMR_SSN:?:MAINNAME:+:V_CITY_NAME:ST:GENDER:SNAME:CNSMR_DOB:C_LIC_NBR:LIC_STATE
EXPORT KeyName := Health_Provider_Services.Files.FILE_CNSMR_SSN_SF; // '~'+'key::Health_Provider_Services::LNPID::Refs::CNSMR_SSN_LP';
SHARED h := CandidatesForKey;//The input file - distributed by LNPID
 
SHARED s := Specificities(File_HealthProvider).Specificities[1];
SHARED s_index := Keys(File_HealthProvider).Specificities_Key[1]; // Index access for MEOW queries
layout := RECORD // project out required fields
// Compulsory fields
  h.CNSMR_SSN;
// Optional fields
  h.LNPID; // The ID field
  h.FNAME_PreferredName;
  h.FNAME;
  h.MNAME;
  h.LNAME;
// Extra credit fields
  h.V_CITY_NAME;
  h.ST;
  h.GENDER;
  h.SNAME_NormSuffix;
  h.SNAME;
  h.CNSMR_DOB_year;
  h.CNSMR_DOB_month;
  h.CNSMR_DOB_day;
  h.C_LIC_NBR;
  h.LIC_STATE;
  h.CNSMR_SSN_len;
  h.FNAME_len;
  h.MNAME_len;
  h.LNAME_len;
  h.C_LIC_NBR_len;
//Scores for various field components
  h.CNSMR_SSN_weight100 ; // Contains 100x the specificity
  INTEGER2 CNSMR_SSN_e1_Weight100 := SALT311.Min0(h.CNSMR_SSN_weight100 + 100*log(h.CNSMR_SSN_cnt/h.CNSMR_SSN_e1_cnt)/log(2)); // Precompute edit-distance specificity
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
  h.V_CITY_NAME_weight100 ; // Contains 100x the specificity
  h.ST_weight100 ; // Contains 100x the specificity
  h.GENDER_weight100 ; // Contains 100x the specificity
  h.SNAME_weight100 ; // Contains 100x the specificity
  h.SNAME_NormSuffix_Weight100;
  h.CNSMR_DOB_year_weight100; // Contains 100x the specificity
  h.CNSMR_DOB_month_weight100; // Contains 100x the specificity
  h.CNSMR_DOB_day_weight100; // Contains 100x the specificity
  h.C_LIC_NBR_weight100 ; // Contains 100x the specificity
  INTEGER2 C_LIC_NBR_e1_Weight100 := SALT311.Min0(h.C_LIC_NBR_weight100 + 100*log(h.C_LIC_NBR_cnt/h.C_LIC_NBR_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.LIC_STATE_weight100 ; // Contains 100x the specificity
END;
 
DataForKey0 := DEDUP(SORT(TABLE(h((CNSMR_SSN NOT IN SET(s.nulls_CNSMR_SSN,CNSMR_SSN) AND CNSMR_SSN <> (TYPEOF(CNSMR_SSN))'')),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
SHARED DataForKey := DataForKey0;
 
EXPORT Key := INDEX(DataForKey,{DataForKey},{},KeyName);
 
EXPORT BuildAll := BUILDINDEX(Key, OVERWRITE);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,LNPID,CNSMR_SSN,FNAME,MNAME,LNAME,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_V_CITY_NAME := GROUP( DEDUP( SORT( Grpd, EXCEPT V_CITY_NAME), EXCEPT V_CITY_NAME));
  CntRed_V_CITY_NAME := (KeyCnt-COUNT(Rem_V_CITY_NAME))/KeyCnt;
  Rem_ST := GROUP( DEDUP( SORT( Grpd, EXCEPT ST), EXCEPT ST));
  CntRed_ST := (KeyCnt-COUNT(Rem_ST))/KeyCnt;
  Rem_GENDER := GROUP( DEDUP( SORT( Grpd, EXCEPT GENDER), EXCEPT GENDER));
  CntRed_GENDER := (KeyCnt-COUNT(Rem_GENDER))/KeyCnt;
  Rem_SNAME := GROUP( DEDUP( SORT( Grpd, EXCEPT SNAME), EXCEPT SNAME));
  CntRed_SNAME := (KeyCnt-COUNT(Rem_SNAME))/KeyCnt;
  Rem_CNSMR_DOB := GROUP( DEDUP( SORT( Grpd, EXCEPT CNSMR_DOB_year,CNSMR_DOB_month,CNSMR_DOB_day), EXCEPT CNSMR_DOB_year,CNSMR_DOB_month,CNSMR_DOB_day));
  CntRed_CNSMR_DOB := (KeyCnt-COUNT(Rem_CNSMR_DOB))/KeyCnt;
  Rem_C_LIC_NBR := GROUP( DEDUP( SORT( Grpd, EXCEPT C_LIC_NBR), EXCEPT C_LIC_NBR));
  CntRed_C_LIC_NBR := (KeyCnt-COUNT(Rem_C_LIC_NBR))/KeyCnt;
  Rem_LIC_STATE := GROUP( DEDUP( SORT( Grpd, EXCEPT LIC_STATE), EXCEPT LIC_STATE));
  CntRed_LIC_STATE := (KeyCnt-COUNT(Rem_LIC_STATE))/KeyCnt;
EXPORT Shrinkage := DATASET([{'CNSMR_SSN_LP','V_CITY_NAME',CntRed_V_CITY_NAME*100,CntRed_V_CITY_NAME*TSize},{'CNSMR_SSN_LP','ST',CntRed_ST*100,CntRed_ST*TSize},{'CNSMR_SSN_LP','GENDER',CntRed_GENDER*100,CntRed_GENDER*TSize},{'CNSMR_SSN_LP','SNAME',CntRed_SNAME*100,CntRed_SNAME*TSize},{'CNSMR_SSN_LP','CNSMR_DOB',CntRed_CNSMR_DOB*100,CntRed_CNSMR_DOB*TSize},{'CNSMR_SSN_LP','C_LIC_NBR',CntRed_C_LIC_NBR*100,CntRed_C_LIC_NBR*TSize},{'CNSMR_SSN_LP','LIC_STATE',CntRed_LIC_STATE*100,CntRed_LIC_STATE*TSize}],SALT311.ShrinkLayout);
EXPORT CanSearch(Process_xLNPID_Layouts.InputLayout le) := le.CNSMR_SSN <> (TYPEOF(le.CNSMR_SSN))'' AND Fields.InValid_CNSMR_SSN((SALT311.StrType)le.CNSMR_SSN)=0;
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(TYPEOF(h.CNSMR_SSN) param_CNSMR_SSN = (TYPEOF(h.CNSMR_SSN))'',TYPEOF(h.CNSMR_SSN_len) param_CNSMR_SSN_len = (TYPEOF(h.CNSMR_SSN_len))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'') := 
    STEPPED( LIMIT( Key(
          KEYED((CNSMR_SSN = param_CNSMR_SSN))
      AND (((param_FNAME = (TYPEOF(FNAME))'' OR FNAME = (TYPEOF(FNAME))'') OR (FNAME = param_FNAME) OR ((FNAME[1..LENGTH(TRIM(param_FNAME))] = param_FNAME OR param_FNAME[1..LENGTH(TRIM(FNAME))] = FNAME)  OR  (FNAME_PreferredName = fn_PreferredName(param_FNAME))  OR  (metaphonelib.DMetaPhone1(FNAME)=metaphonelib.DMetaPhone1(param_FNAME))  OR (Config.WithinEditN(FNAME,FNAME_len,param_FNAME,param_FNAME_len,2, 5)) ))
        AND ((param_MNAME = (TYPEOF(MNAME))'' OR MNAME = (TYPEOF(MNAME))'') OR (MNAME = param_MNAME) OR ((MNAME[1..LENGTH(TRIM(param_MNAME))] = param_MNAME OR param_MNAME[1..LENGTH(TRIM(MNAME))] = MNAME)  OR  (metaphonelib.DMetaPhone1(MNAME)=metaphonelib.DMetaPhone1(param_MNAME))  OR (Config.WithinEditN(MNAME,MNAME_len,param_MNAME,param_MNAME_len,2, 5)) ))
        AND ((param_LNAME = (TYPEOF(LNAME))'' OR LNAME = (TYPEOF(LNAME))'') OR (LNAME = param_LNAME) OR ((LNAME[1..LENGTH(TRIM(param_LNAME))] = param_LNAME OR param_LNAME[1..LENGTH(TRIM(LNAME))] = LNAME)  OR  (metaphonelib.DMetaPhone1(LNAME)=metaphonelib.DMetaPhone1(param_LNAME))  OR (Config.WithinEditN(LNAME,LNAME_len,param_LNAME,param_LNAME_len,2, 5))  OR (SALT311.HyphenMatch(LNAME,param_LNAME,1)<=2)))
        OR SALT311.fn_concept_wordbag_EditN_EL.Match3((SALT311.StrType)FNAME,FNAME_MAINNAME_weight100,true,0,true,FNAME_initial_char_weight100,IF( LENGTH(TRIM((SALT311.StrType)FNAME))<5, 1, 2),5,FNAME_len,FNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)MNAME,MNAME_MAINNAME_weight100,true,0,true,MNAME_initial_char_weight100,IF( LENGTH(TRIM((SALT311.StrType)MNAME))<5, 1, 2),5,MNAME_len,MNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)LNAME,LNAME_MAINNAME_weight100,true,0,true,LNAME_initial_char_weight100,IF( LENGTH(TRIM((SALT311.StrType)LNAME))<5, 1, 2),5,LNAME_len,LNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)param_FNAME,param_FNAME_len,(SALT311.StrType)param_MNAME,param_MNAME_len,(SALT311.StrType)param_LNAME,param_LNAME_len,Health_Provider_Services.Config.WithinEditN) > 0)),Config.CNSMR_SSN_LP_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),LNPID);
 
 
EXPORT ScoredLNPIDFetch(TYPEOF(h.CNSMR_SSN) param_CNSMR_SSN = (TYPEOF(h.CNSMR_SSN))'',TYPEOF(h.CNSMR_SSN_len) param_CNSMR_SSN_len = (TYPEOF(h.CNSMR_SSN_len))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'',TYPEOF(h.V_CITY_NAME) param_V_CITY_NAME = (TYPEOF(h.V_CITY_NAME))'',TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',TYPEOF(h.GENDER) param_GENDER = (TYPEOF(h.GENDER))'',TYPEOF(h.SNAME) param_SNAME = (TYPEOF(h.SNAME))'',UNSIGNED4 param_CNSMR_DOB,TYPEOF(h.C_LIC_NBR) param_C_LIC_NBR = (TYPEOF(h.C_LIC_NBR))'',TYPEOF(h.C_LIC_NBR_len) param_C_LIC_NBR_len = (TYPEOF(h.C_LIC_NBR_len))'',TYPEOF(h.LIC_STATE) param_LIC_STATE = (TYPEOF(h.LIC_STATE))'') := FUNCTION
  RawData := RawFetch(param_CNSMR_SSN,param_CNSMR_SSN_len,param_FNAME,param_MNAME,param_LNAME,param_FNAME_len,param_MNAME_len,param_LNAME_len);
 
  Process_xLNPID_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 9; // Set bitmap for keys used
    SELF.keys_failed := IF(le.LNPID = 0, 1 << 9, 0); // Set bitmap for key failed
    SELF.CNSMR_SSN_match_code := match_methods(File_HealthProvider).match_CNSMR_SSN(le.CNSMR_SSN,param_CNSMR_SSN,le.CNSMR_SSN_len,param_CNSMR_SSN_len,TRUE);
    SELF.CNSMR_SSNWeight := (50+MAP (
           SELF.CNSMR_SSN_match_code = SALT311.MatchCode.ExactMatch =>le.CNSMR_SSN_weight100,
           -0.963*le.CNSMR_SSN_weight100))/100; 
    SELF.FNAME_match_code := MAP(
           le.FNAME = (TYPEOF(le.FNAME))'' OR param_FNAME = (TYPEOF(param_FNAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_HealthProvider).match_FNAME(le.FNAME,param_FNAME,le.FNAME_len,param_FNAME_len,FALSE));
    SELF.FNAMEWeight := (50+MAP (
           SELF.FNAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.FNAME_match_code = SALT311.MatchCode.ExactMatch =>le.FNAME_weight100,
           SELF.FNAME_match_code = SALT311.MatchCode.InitialLMatch =>le.FNAME_weight100,
           SELF.FNAME_match_code = SALT311.MatchCode.InitialRMatch=> SALT311.Fn_Interpolate_Initial(le.FNAME,param_FNAME,le.FNAME_weight100,le.FNAME_initial_char_weight100),
           SELF.FNAME_match_code = SALT311.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(param_FNAME),MAP((5 > le.FNAME_len) AND (5 > param_FNAME_len) => le.FNAME_e1p_weight100, le.FNAME_e2p_weight100),MAP((5 > le.FNAME_len) AND (5 > param_FNAME_len) => le.FNAME_e1_weight100, le.FNAME_e2_weight100)),
           SELF.FNAME_match_code = SALT311.MatchCode.PhoneticMatch =>le.FNAME_p_weight100,
           SELF.FNAME_match_code = SALT311.MatchCode.CustomFuzzyMatch =>le.FNAME_PreferredName_weight100,
           -0.961*le.FNAME_weight100))/100; 
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
    SELF.LNAME_match_code := MAP(
           le.LNAME = (TYPEOF(le.LNAME))'' OR param_LNAME = (TYPEOF(param_LNAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_HealthProvider).match_LNAME(le.LNAME,param_LNAME,le.LNAME_len,param_LNAME_len,FALSE));
    SELF.LNAMEWeight := (50+MAP (
           SELF.LNAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.LNAME_match_code = SALT311.MatchCode.ExactMatch =>le.LNAME_weight100,
           SELF.LNAME_match_code = SALT311.MatchCode.HyphenMatch =>le.LNAME_weight100*MIN(1,LENGTH(TRIM(param_LNAME))/LENGTH(TRIM(le.LNAME))),
           SELF.LNAME_match_code = SALT311.MatchCode.InitialLMatch =>le.LNAME_weight100,
           SELF.LNAME_match_code = SALT311.MatchCode.InitialRMatch=> SALT311.Fn_Interpolate_Initial(le.LNAME,param_LNAME,le.LNAME_weight100,le.LNAME_initial_char_weight100),
           SELF.LNAME_match_code = SALT311.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(param_LNAME),MAP((5 > le.LNAME_len) AND (5 > param_LNAME_len) => le.LNAME_e1p_weight100, le.LNAME_e2p_weight100),MAP((5 > le.LNAME_len) AND (5 > param_LNAME_len) => le.LNAME_e1_weight100, le.LNAME_e2_weight100)),
           SELF.LNAME_match_code = SALT311.MatchCode.PhoneticMatch =>le.LNAME_p_weight100,
           -0.874*le.LNAME_weight100))/100; 
    INTEGER2 MAINNAME_BOWWeight := SALT311.fn_concept_wordbag_EditN_EL.Match3((SALT311.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,true,0,true,le.FNAME_initial_char_weight100,IF( LENGTH(TRIM((SALT311.StrType)le.FNAME))<5, 1, 2),5,le.FNAME_len,le.FNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)le.MNAME,le.MNAME_MAINNAME_weight100,true,0,true,le.MNAME_initial_char_weight100,IF( LENGTH(TRIM((SALT311.StrType)le.MNAME))<5, 1, 2),5,le.MNAME_len,le.MNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)le.LNAME,le.LNAME_MAINNAME_weight100,true,0,true,le.LNAME_initial_char_weight100,IF( LENGTH(TRIM((SALT311.StrType)le.LNAME))<5, 1, 2),5,le.LNAME_len,le.LNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)param_FNAME,param_FNAME_len,(SALT311.StrType)param_MNAME,param_MNAME_len,(SALT311.StrType)param_LNAME,param_LNAME_len,Health_Provider_Services.Config.WithinEditN);
    SELF.MAINNAME_match_code := MAP(HASH32((SALT311.StrType) le.FNAME,(SALT311.StrType) le.MNAME,(SALT311.StrType) le.LNAME) = HASH32((SALT311.StrType)param_FNAME,(SALT311.StrType)param_MNAME,(SALT311.StrType)param_LNAME) => SALT311.MatchCode.ExactMatch,
          MAINNAME_BOWWeight > 0 => SALT311.MatchCode.WordbagMatch,
          SALT311.MatchCode.NoMatch);
    SELF.MAINNAMEWeight := (50+MAP(    SELF.MAINNAME_match_code = SALT311.MatchCode.ExactMatch  => le.FNAME_weight100+le.MNAME_weight100+le.LNAME_weight100,
                SELF.MAINNAME_match_code = SALT311.MatchCode.WordbagMatch => MAINNAME_BOWWeight,
                MAINNAME_BOWWeight))/100; //Concept could score even if fields do not
    SELF.V_CITY_NAME_match_code := MAP(
           le.V_CITY_NAME = (TYPEOF(le.V_CITY_NAME))'' OR param_V_CITY_NAME = (TYPEOF(param_V_CITY_NAME))'' => SALT311.MatchCode.OneSideNull,
           le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' OR le.ST <> param_ST  => SALT311.MatchCode.ContextNoMatch, // Only valid if the context variable is equal
           match_methods(File_HealthProvider).match_V_CITY_NAME(le.V_CITY_NAME,param_V_CITY_NAME,FALSE));
    SELF.V_CITY_NAMEWeight := (50+MAP (
           SELF.V_CITY_NAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.V_CITY_NAME_match_code = SALT311.MatchCode.ContextNoMatch => 0,
           SELF.V_CITY_NAME_match_code = SALT311.MatchCode.ExactMatch =>le.V_CITY_NAME_weight100,
           -0.562*le.V_CITY_NAME_weight100))/100; 
    SELF.ST_match_code := MAP(
           le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_HealthProvider).match_ST(le.ST,param_ST,FALSE));
    SELF.STWeight := (50+MAP (
           SELF.ST_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.ST_match_code = SALT311.MatchCode.ExactMatch =>le.ST_weight100,
           -0.823*le.ST_weight100))/100; 
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
    SELF.CNSMR_DOB_year_match_code := MAP(
      le.CNSMR_DOB_year = 0 OR param_CNSMR_DOB = (TYPEOF(param_CNSMR_DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(File_HealthProvider).match_CNSMR_DOB_year(le.CNSMR_DOB_year,((UNSIGNED)param_CNSMR_DOB) DIV 10000,FALSE));
    SELF.CNSMR_DOBWeight_year := (50+MAP ( SELF.CNSMR_DOB_year_match_code = SALT311.MatchCode.OneSideNull => 0,
       SELF.CNSMR_DOB_year_match_code = SALT311.MatchCode.ExactMatch => le.CNSMR_DOB_year_weight100,
       -0.995*le.CNSMR_DOB_year_weight100))/100;
    SELF.CNSMR_DOB_month_match_code := MAP(
      le.CNSMR_DOB_month = 0 OR param_CNSMR_DOB = (TYPEOF(param_CNSMR_DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(File_HealthProvider).match_CNSMR_DOB_month(le.CNSMR_DOB_month,((UNSIGNED)param_CNSMR_DOB) DIV 100 % 100,le.CNSMR_DOB_day, ((UNSIGNED)param_CNSMR_DOB) % 100,FALSE));
    SELF.CNSMR_DOBWeight_month := (50+MAP ( SELF.CNSMR_DOB_month_match_code = SALT311.MatchCode.OneSideNull => 0,
      SELF.CNSMR_DOB_month_match_code = SALT311.MatchCode.ExactMatch => le.CNSMR_DOB_month_weight100,
       -0.995*le.CNSMR_DOB_month_weight100))/100;
    SELF.CNSMR_DOB_day_match_code := MAP(
      le.CNSMR_DOB_day = 0 OR param_CNSMR_DOB = (TYPEOF(param_CNSMR_DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(File_HealthProvider).match_CNSMR_DOB_day(le.CNSMR_DOB_month,((UNSIGNED)param_CNSMR_DOB) DIV 100 % 100,le.CNSMR_DOB_day, ((UNSIGNED)param_CNSMR_DOB) % 100,FALSE));
    SELF.CNSMR_DOBWeight_day := (50+MAP ( SELF.CNSMR_DOB_day_match_code = SALT311.MatchCode.OneSideNull => 0,
      SELF.CNSMR_DOB_day_match_code = SALT311.MatchCode.ExactMatch => le.CNSMR_DOB_day_weight100,
       -0.995*le.CNSMR_DOB_day_weight100))/100;
		CNSMR_DOB_AggWeight := SELF.CNSMR_DOBWeight_day + SELF.CNSMR_DOBWeight_month + SELF.CNSMR_DOBWeight_year;
    SELF.CNSMR_DOB_match_code := MAP(
      le.CNSMR_DOB_year+le.CNSMR_DOB_month+le.CNSMR_DOB_day = 0 OR param_CNSMR_DOB = (TYPEOF(param_CNSMR_DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(File_HealthProvider).match_CNSMR_DOB_el(le.CNSMR_DOB_year, le.CNSMR_DOB_month, le.CNSMR_DOB_day, param_CNSMR_DOB, CNSMR_DOB_AggWeight ,FALSE));
    SELF.CNSMR_DOBWeight :=  MAP(
           SELF.CNSMR_DOB_match_code = SALT311.MatchCode.OneSideNull => 0,
           CNSMR_DOB_AggWeight); 
    SELF.C_LIC_NBR_match_code := MAP(
           le.C_LIC_NBR = (TYPEOF(le.C_LIC_NBR))'' OR param_C_LIC_NBR = (TYPEOF(param_C_LIC_NBR))'' => SALT311.MatchCode.OneSideNull,
           le.LIC_STATE = (TYPEOF(le.LIC_STATE))'' OR param_LIC_STATE = (TYPEOF(param_LIC_STATE))'' OR le.LIC_STATE <> param_LIC_STATE  => SALT311.MatchCode.ContextNoMatch, // Only valid if the context variable is equal
           match_methods(File_HealthProvider).match_C_LIC_NBR(le.C_LIC_NBR,param_C_LIC_NBR,le.C_LIC_NBR_len,param_C_LIC_NBR_len,FALSE));
    SELF.C_LIC_NBRWeight := (50+MAP (
           SELF.C_LIC_NBR_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.C_LIC_NBR_match_code = SALT311.MatchCode.ContextNoMatch => 0,
           SELF.C_LIC_NBR_match_code = SALT311.MatchCode.ExactMatch =>le.C_LIC_NBR_weight100,
           SELF.C_LIC_NBR_match_code = SALT311.MatchCode.EditDistanceMatch =>le.C_LIC_NBR_e1_weight100,
           -0.671*le.C_LIC_NBR_weight100))/100; 
    SELF.LIC_STATE_match_code := MAP(
           le.LIC_STATE = (TYPEOF(le.LIC_STATE))'' OR param_LIC_STATE = (TYPEOF(param_LIC_STATE))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_HealthProvider).match_LIC_STATE(le.LIC_STATE,param_LIC_STATE,FALSE));
    SELF.LIC_STATEWeight := (50+MAP (
           SELF.LIC_STATE_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.LIC_STATE_match_code = SALT311.MatchCode.ExactMatch =>le.LIC_STATE_weight100,
           -0.810*le.LIC_STATE_weight100))/100; 
    SELF.Weight := IF(le.LNPID = 0, 100, MAX(0, SELF.CNSMR_SSNWeight) + MAX(SELF.MAINNAMEWeight, (MAX(0, SELF.FNAMEWeight) + MAX(0, SELF.MNAMEWeight) + MAX(0, SELF.LNAMEWeight))) + MAX(0, SELF.V_CITY_NAMEWeight) + MAX(0, SELF.STWeight) + MAX(0, SELF.GENDERWeight) + MAX(0, SELF.SNAMEWeight) + MAX(0, SELF.CNSMR_DOBWeight) + MAX(0, SELF.C_LIC_NBRWeight) + MAX(0, SELF.LIC_STATEWeight));
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
  TYPEOF(h.CNSMR_SSN) CNSMR_SSN := (TYPEOF(h.CNSMR_SSN))'';
  TYPEOF(h.CNSMR_SSN_len) CNSMR_SSN_len := (TYPEOF(h.CNSMR_SSN_len))'';
  SALT311.StrType MAINNAME := (SALT311.StrType)'';
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))'';
  TYPEOF(h.FNAME_len) FNAME_len := (TYPEOF(h.FNAME_len))'';
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))'';
  TYPEOF(h.MNAME_len) MNAME_len := (TYPEOF(h.MNAME_len))'';
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))'';
  TYPEOF(h.LNAME_len) LNAME_len := (TYPEOF(h.LNAME_len))'';
  TYPEOF(h.V_CITY_NAME) V_CITY_NAME := (TYPEOF(h.V_CITY_NAME))'';
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))'';
  TYPEOF(h.GENDER) GENDER := (TYPEOF(h.GENDER))'';
  TYPEOF(h.SNAME) SNAME := (TYPEOF(h.SNAME))'';
  UNSIGNED4 CNSMR_DOB := 0;
  TYPEOF(h.C_LIC_NBR) C_LIC_NBR := (TYPEOF(h.C_LIC_NBR))'';
  TYPEOF(h.C_LIC_NBR_len) C_LIC_NBR_len := (TYPEOF(h.C_LIC_NBR_len))'';
  TYPEOF(h.LIC_STATE) LIC_STATE := (TYPEOF(h.LIC_STATE))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex) := FUNCTION
 
  Process_xLNPID_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 9; // Set bitmap for keys used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.CNSMR_SSN_match_code := match_methods(File_HealthProvider).match_CNSMR_SSN(le.CNSMR_SSN,ri.CNSMR_SSN,le.CNSMR_SSN_len,ri.CNSMR_SSN_len,TRUE);
    SELF.CNSMR_SSNWeight := (50+MAP (
           SELF.CNSMR_SSN_match_code = SALT311.MatchCode.ExactMatch =>le.CNSMR_SSN_weight100,
           -0.963*le.CNSMR_SSN_weight100))/100; 
    SELF.FNAME_match_code := MAP(
           le.FNAME = (TYPEOF(le.FNAME))'' OR ri.FNAME = (TYPEOF(ri.FNAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_HealthProvider).match_FNAME(le.FNAME,ri.FNAME,le.FNAME_len,ri.FNAME_len,FALSE));
    SELF.FNAMEWeight := (50+MAP (
           SELF.FNAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.FNAME_match_code = SALT311.MatchCode.ExactMatch =>le.FNAME_weight100,
           SELF.FNAME_match_code = SALT311.MatchCode.InitialLMatch =>le.FNAME_weight100,
           SELF.FNAME_match_code = SALT311.MatchCode.InitialRMatch=> SALT311.Fn_Interpolate_Initial(le.FNAME,ri.FNAME,le.FNAME_weight100,le.FNAME_initial_char_weight100),
           SELF.FNAME_match_code = SALT311.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(ri.FNAME),MAP((5 > le.FNAME_len) AND (5 > ri.FNAME_len) => le.FNAME_e1p_weight100, le.FNAME_e2p_weight100),MAP((5 > le.FNAME_len) AND (5 > ri.FNAME_len) => le.FNAME_e1_weight100, le.FNAME_e2_weight100)),
           SELF.FNAME_match_code = SALT311.MatchCode.PhoneticMatch =>le.FNAME_p_weight100,
           SELF.FNAME_match_code = SALT311.MatchCode.CustomFuzzyMatch =>le.FNAME_PreferredName_weight100,
           -0.961*le.FNAME_weight100))/100; 
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
    SELF.LNAME_match_code := MAP(
           le.LNAME = (TYPEOF(le.LNAME))'' OR ri.LNAME = (TYPEOF(ri.LNAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_HealthProvider).match_LNAME(le.LNAME,ri.LNAME,le.LNAME_len,ri.LNAME_len,FALSE));
    SELF.LNAMEWeight := (50+MAP (
           SELF.LNAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.LNAME_match_code = SALT311.MatchCode.ExactMatch =>le.LNAME_weight100,
           SELF.LNAME_match_code = SALT311.MatchCode.HyphenMatch =>le.LNAME_weight100*MIN(1,LENGTH(TRIM(ri.LNAME))/LENGTH(TRIM(le.LNAME))),
           SELF.LNAME_match_code = SALT311.MatchCode.InitialLMatch =>le.LNAME_weight100,
           SELF.LNAME_match_code = SALT311.MatchCode.InitialRMatch=> SALT311.Fn_Interpolate_Initial(le.LNAME,ri.LNAME,le.LNAME_weight100,le.LNAME_initial_char_weight100),
           SELF.LNAME_match_code = SALT311.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(ri.LNAME),MAP((5 > le.LNAME_len) AND (5 > ri.LNAME_len) => le.LNAME_e1p_weight100, le.LNAME_e2p_weight100),MAP((5 > le.LNAME_len) AND (5 > ri.LNAME_len) => le.LNAME_e1_weight100, le.LNAME_e2_weight100)),
           SELF.LNAME_match_code = SALT311.MatchCode.PhoneticMatch =>le.LNAME_p_weight100,
           -0.874*le.LNAME_weight100))/100; 
    INTEGER2 MAINNAME_BOWWeight := SALT311.fn_concept_wordbag_EditN_EL.Match3((SALT311.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,true,0,true,le.FNAME_initial_char_weight100,IF( LENGTH(TRIM((SALT311.StrType)le.FNAME))<5, 1, 2),5,le.FNAME_len,le.FNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)le.MNAME,le.MNAME_MAINNAME_weight100,true,0,true,le.MNAME_initial_char_weight100,IF( LENGTH(TRIM((SALT311.StrType)le.MNAME))<5, 1, 2),5,le.MNAME_len,le.MNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)le.LNAME,le.LNAME_MAINNAME_weight100,true,0,true,le.LNAME_initial_char_weight100,IF( LENGTH(TRIM((SALT311.StrType)le.LNAME))<5, 1, 2),5,le.LNAME_len,le.LNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)ri.FNAME,ri.FNAME_len,(SALT311.StrType)ri.MNAME,ri.MNAME_len,(SALT311.StrType)ri.LNAME,ri.LNAME_len,Health_Provider_Services.Config.WithinEditN);
    SELF.MAINNAME_match_code := MAP(HASH32((SALT311.StrType) le.FNAME,(SALT311.StrType) le.MNAME,(SALT311.StrType) le.LNAME) = HASH32((SALT311.StrType)ri.FNAME,(SALT311.StrType)ri.MNAME,(SALT311.StrType)ri.LNAME) => SALT311.MatchCode.ExactMatch,
          MAINNAME_BOWWeight > 0 => SALT311.MatchCode.WordbagMatch,
          SALT311.MatchCode.NoMatch);
    SELF.MAINNAMEWeight := (50+MAP(    SELF.MAINNAME_match_code = SALT311.MatchCode.ExactMatch  => le.FNAME_weight100+le.MNAME_weight100+le.LNAME_weight100,
                SELF.MAINNAME_match_code = SALT311.MatchCode.WordbagMatch => MAINNAME_BOWWeight,
                MAINNAME_BOWWeight))/100; //Concept could score even if fields do not
    SELF.V_CITY_NAME_match_code := MAP(
           le.V_CITY_NAME = (TYPEOF(le.V_CITY_NAME))'' OR ri.V_CITY_NAME = (TYPEOF(ri.V_CITY_NAME))'' => SALT311.MatchCode.OneSideNull,
           le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' OR le.ST <> ri.ST  => SALT311.MatchCode.ContextNoMatch, // Only valid if the context variable is equal
           match_methods(File_HealthProvider).match_V_CITY_NAME(le.V_CITY_NAME,ri.V_CITY_NAME,FALSE));
    SELF.V_CITY_NAMEWeight := (50+MAP (
           SELF.V_CITY_NAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.V_CITY_NAME_match_code = SALT311.MatchCode.ContextNoMatch => 0,
           SELF.V_CITY_NAME_match_code = SALT311.MatchCode.ExactMatch =>le.V_CITY_NAME_weight100,
           -0.562*le.V_CITY_NAME_weight100))/100; 
    SELF.ST_match_code := MAP(
           le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_HealthProvider).match_ST(le.ST,ri.ST,FALSE));
    SELF.STWeight := (50+MAP (
           SELF.ST_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.ST_match_code = SALT311.MatchCode.ExactMatch =>le.ST_weight100,
           -0.823*le.ST_weight100))/100; 
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
    SELF.CNSMR_DOB_year_match_code := MAP(
      le.CNSMR_DOB_year = 0 OR ri.CNSMR_DOB = (TYPEOF(ri.CNSMR_DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(File_HealthProvider).match_CNSMR_DOB_year(le.CNSMR_DOB_year,((UNSIGNED)ri.CNSMR_DOB) DIV 10000,FALSE));
    SELF.CNSMR_DOBWeight_year := (50+MAP ( SELF.CNSMR_DOB_year_match_code = SALT311.MatchCode.OneSideNull => 0,
       SELF.CNSMR_DOB_year_match_code = SALT311.MatchCode.ExactMatch => le.CNSMR_DOB_year_weight100,
       -0.995*le.CNSMR_DOB_year_weight100))/100;
    SELF.CNSMR_DOB_month_match_code := MAP(
      le.CNSMR_DOB_month = 0 OR ri.CNSMR_DOB = (TYPEOF(ri.CNSMR_DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(File_HealthProvider).match_CNSMR_DOB_month(le.CNSMR_DOB_month,((UNSIGNED)ri.CNSMR_DOB) DIV 100 % 100,le.CNSMR_DOB_day, ((UNSIGNED)ri.CNSMR_DOB) % 100,FALSE));
    SELF.CNSMR_DOBWeight_month := (50+MAP ( SELF.CNSMR_DOB_month_match_code = SALT311.MatchCode.OneSideNull => 0,
      SELF.CNSMR_DOB_month_match_code = SALT311.MatchCode.ExactMatch => le.CNSMR_DOB_month_weight100,
       -0.995*le.CNSMR_DOB_month_weight100))/100;
    SELF.CNSMR_DOB_day_match_code := MAP(
      le.CNSMR_DOB_day = 0 OR ri.CNSMR_DOB = (TYPEOF(ri.CNSMR_DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(File_HealthProvider).match_CNSMR_DOB_day(le.CNSMR_DOB_month,((UNSIGNED)ri.CNSMR_DOB) DIV 100 % 100,le.CNSMR_DOB_day, ((UNSIGNED)ri.CNSMR_DOB) % 100,FALSE));
    SELF.CNSMR_DOBWeight_day := (50+MAP ( SELF.CNSMR_DOB_day_match_code = SALT311.MatchCode.OneSideNull => 0,
      SELF.CNSMR_DOB_day_match_code = SALT311.MatchCode.ExactMatch => le.CNSMR_DOB_day_weight100,
       -0.995*le.CNSMR_DOB_day_weight100))/100;
		CNSMR_DOB_AggWeight := SELF.CNSMR_DOBWeight_day + SELF.CNSMR_DOBWeight_month + SELF.CNSMR_DOBWeight_year;
    SELF.CNSMR_DOB_match_code := MAP(
      le.CNSMR_DOB_year+le.CNSMR_DOB_month+le.CNSMR_DOB_day = 0 OR ri.CNSMR_DOB = (TYPEOF(ri.CNSMR_DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(File_HealthProvider).match_CNSMR_DOB_el(le.CNSMR_DOB_year, le.CNSMR_DOB_month, le.CNSMR_DOB_day, ri.CNSMR_DOB, CNSMR_DOB_AggWeight ,FALSE));
    SELF.CNSMR_DOBWeight :=  MAP(
           SELF.CNSMR_DOB_match_code = SALT311.MatchCode.OneSideNull => 0,
           CNSMR_DOB_AggWeight); 
    SELF.C_LIC_NBR_match_code := MAP(
           le.C_LIC_NBR = (TYPEOF(le.C_LIC_NBR))'' OR ri.C_LIC_NBR = (TYPEOF(ri.C_LIC_NBR))'' => SALT311.MatchCode.OneSideNull,
           le.LIC_STATE = (TYPEOF(le.LIC_STATE))'' OR ri.LIC_STATE = (TYPEOF(ri.LIC_STATE))'' OR le.LIC_STATE <> ri.LIC_STATE  => SALT311.MatchCode.ContextNoMatch, // Only valid if the context variable is equal
           match_methods(File_HealthProvider).match_C_LIC_NBR(le.C_LIC_NBR,ri.C_LIC_NBR,le.C_LIC_NBR_len,ri.C_LIC_NBR_len,FALSE));
    SELF.C_LIC_NBRWeight := (50+MAP (
           SELF.C_LIC_NBR_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.C_LIC_NBR_match_code = SALT311.MatchCode.ContextNoMatch => 0,
           SELF.C_LIC_NBR_match_code = SALT311.MatchCode.ExactMatch =>le.C_LIC_NBR_weight100,
           SELF.C_LIC_NBR_match_code = SALT311.MatchCode.EditDistanceMatch =>le.C_LIC_NBR_e1_weight100,
           -0.671*le.C_LIC_NBR_weight100))/100; 
    SELF.LIC_STATE_match_code := MAP(
           le.LIC_STATE = (TYPEOF(le.LIC_STATE))'' OR ri.LIC_STATE = (TYPEOF(ri.LIC_STATE))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_HealthProvider).match_LIC_STATE(le.LIC_STATE,ri.LIC_STATE,FALSE));
    SELF.LIC_STATEWeight := (50+MAP (
           SELF.LIC_STATE_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.LIC_STATE_match_code = SALT311.MatchCode.ExactMatch =>le.LIC_STATE_weight100,
           -0.810*le.LIC_STATE_weight100))/100; 
    SELF.Weight := IF(le.LNPID = 0, 100, MAX(0, SELF.CNSMR_SSNWeight) + MAX(SELF.MAINNAMEWeight, (MAX(0, SELF.FNAMEWeight) + MAX(0, SELF.MNAMEWeight) + MAX(0, SELF.LNAMEWeight))) + MAX(0, SELF.V_CITY_NAMEWeight) + MAX(0, SELF.STWeight) + MAX(0, SELF.GENDERWeight) + MAX(0, SELF.SNAMEWeight) + MAX(0, SELF.CNSMR_DOBWeight) + MAX(0, SELF.C_LIC_NBRWeight) + MAX(0, SELF.LIC_STATEWeight));
    SELF := le;
  END;
  Recs0 := Recs(CNSMR_SSN <> (TYPEOF(CNSMR_SSN))'');
  SALT311.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference,Config.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,((RIGHT.CNSMR_SSN = LEFT.CNSMR_SSN))
     AND (( 
        ((LEFT.FNAME = (TYPEOF(RIGHT.FNAME))'' OR RIGHT.FNAME = (TYPEOF(RIGHT.FNAME))'') OR (RIGHT.FNAME = LEFT.FNAME) OR ((RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME OR LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME)  OR  (RIGHT.FNAME_PreferredName = fn_PreferredName(LEFT.FNAME))  OR  (metaphonelib.DMetaPhone1(RIGHT.FNAME)=metaphonelib.DMetaPhone1(LEFT.FNAME))  OR (Config.WithinEditN(RIGHT.FNAME,RIGHT.FNAME_len,LEFT.FNAME,LEFT.FNAME_len,2, 5)) ))
        AND ((LEFT.MNAME = (TYPEOF(RIGHT.MNAME))'' OR RIGHT.MNAME = (TYPEOF(RIGHT.MNAME))'') OR (RIGHT.MNAME = LEFT.MNAME) OR ((RIGHT.MNAME[1..LENGTH(TRIM(LEFT.MNAME))] = LEFT.MNAME OR LEFT.MNAME[1..LENGTH(TRIM(RIGHT.MNAME))] = RIGHT.MNAME)  OR  (metaphonelib.DMetaPhone1(RIGHT.MNAME)=metaphonelib.DMetaPhone1(LEFT.MNAME))  OR (Config.WithinEditN(RIGHT.MNAME,RIGHT.MNAME_len,LEFT.MNAME,LEFT.MNAME_len,2, 5)) ))
        AND ((LEFT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'') OR (RIGHT.LNAME = LEFT.LNAME) OR ((RIGHT.LNAME[1..LENGTH(TRIM(LEFT.LNAME))] = LEFT.LNAME OR LEFT.LNAME[1..LENGTH(TRIM(RIGHT.LNAME))] = RIGHT.LNAME)  OR  (metaphonelib.DMetaPhone1(RIGHT.LNAME)=metaphonelib.DMetaPhone1(LEFT.LNAME))  OR (Config.WithinEditN(RIGHT.LNAME,RIGHT.LNAME_len,LEFT.LNAME,LEFT.LNAME_len,2, 5))  OR (SALT311.HyphenMatch(RIGHT.LNAME,LEFT.LNAME,1)<=2)))
          OR SALT311.fn_concept_wordbag_EditN_EL.Match3((SALT311.StrType)RIGHT.FNAME,RIGHT.FNAME_MAINNAME_weight100,true,0,true,RIGHT.FNAME_initial_char_weight100,IF( LENGTH(TRIM((SALT311.StrType)RIGHT.FNAME))<5, 1, 2),5,RIGHT.FNAME_len,RIGHT.FNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)RIGHT.MNAME,RIGHT.MNAME_MAINNAME_weight100,true,0,true,RIGHT.MNAME_initial_char_weight100,IF( LENGTH(TRIM((SALT311.StrType)RIGHT.MNAME))<5, 1, 2),5,RIGHT.MNAME_len,RIGHT.MNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)RIGHT.LNAME,RIGHT.LNAME_MAINNAME_weight100,true,0,true,RIGHT.LNAME_initial_char_weight100,IF( LENGTH(TRIM((SALT311.StrType)RIGHT.LNAME))<5, 1, 2),5,RIGHT.LNAME_len,RIGHT.LNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)LEFT.FNAME,LEFT.FNAME_len,(SALT311.StrType)LEFT.MNAME,LEFT.MNAME_len,(SALT311.StrType)LEFT.LNAME,LEFT.LNAME_len,Health_Provider_Services.Config.WithinEditN) > 0)),Score_Batch(RIGHT,LEFT),
    ATMOST(((RIGHT.CNSMR_SSN = LEFT.CNSMR_SSN)),Config.CNSMR_SSN_LP_MAXBLOCKSIZE)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),((RIGHT.CNSMR_SSN = LEFT.CNSMR_SSN))
     AND (( 
        ((LEFT.FNAME = (TYPEOF(RIGHT.FNAME))'' OR RIGHT.FNAME = (TYPEOF(RIGHT.FNAME))'') OR (RIGHT.FNAME = LEFT.FNAME) OR ((RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME OR LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME)  OR  (RIGHT.FNAME_PreferredName = fn_PreferredName(LEFT.FNAME))  OR  (metaphonelib.DMetaPhone1(RIGHT.FNAME)=metaphonelib.DMetaPhone1(LEFT.FNAME))  OR (Config.WithinEditN(RIGHT.FNAME,RIGHT.FNAME_len,LEFT.FNAME,LEFT.FNAME_len,2, 5)) ))
        AND ((LEFT.MNAME = (TYPEOF(RIGHT.MNAME))'' OR RIGHT.MNAME = (TYPEOF(RIGHT.MNAME))'') OR (RIGHT.MNAME = LEFT.MNAME) OR ((RIGHT.MNAME[1..LENGTH(TRIM(LEFT.MNAME))] = LEFT.MNAME OR LEFT.MNAME[1..LENGTH(TRIM(RIGHT.MNAME))] = RIGHT.MNAME)  OR  (metaphonelib.DMetaPhone1(RIGHT.MNAME)=metaphonelib.DMetaPhone1(LEFT.MNAME))  OR (Config.WithinEditN(RIGHT.MNAME,RIGHT.MNAME_len,LEFT.MNAME,LEFT.MNAME_len,2, 5)) ))
        AND ((LEFT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'') OR (RIGHT.LNAME = LEFT.LNAME) OR ((RIGHT.LNAME[1..LENGTH(TRIM(LEFT.LNAME))] = LEFT.LNAME OR LEFT.LNAME[1..LENGTH(TRIM(RIGHT.LNAME))] = RIGHT.LNAME)  OR  (metaphonelib.DMetaPhone1(RIGHT.LNAME)=metaphonelib.DMetaPhone1(LEFT.LNAME))  OR (Config.WithinEditN(RIGHT.LNAME,RIGHT.LNAME_len,LEFT.LNAME,LEFT.LNAME_len,2, 5))  OR (SALT311.HyphenMatch(RIGHT.LNAME,LEFT.LNAME,1)<=2)))
          OR SALT311.fn_concept_wordbag_EditN_EL.Match3((SALT311.StrType)RIGHT.FNAME,RIGHT.FNAME_MAINNAME_weight100,true,0,true,RIGHT.FNAME_initial_char_weight100,IF( LENGTH(TRIM((SALT311.StrType)RIGHT.FNAME))<5, 1, 2),5,RIGHT.FNAME_len,RIGHT.FNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)RIGHT.MNAME,RIGHT.MNAME_MAINNAME_weight100,true,0,true,RIGHT.MNAME_initial_char_weight100,IF( LENGTH(TRIM((SALT311.StrType)RIGHT.MNAME))<5, 1, 2),5,RIGHT.MNAME_len,RIGHT.MNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)RIGHT.LNAME,RIGHT.LNAME_MAINNAME_weight100,true,0,true,RIGHT.LNAME_initial_char_weight100,IF( LENGTH(TRIM((SALT311.StrType)RIGHT.LNAME))<5, 1, 2),5,RIGHT.LNAME_len,RIGHT.LNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)LEFT.FNAME,LEFT.FNAME_len,(SALT311.StrType)LEFT.MNAME,LEFT.MNAME_len,(SALT311.StrType)LEFT.LNAME,LEFT.LNAME_len,Health_Provider_Services.Config.WithinEditN) > 0)),Score_Batch(RIGHT,LEFT),
    ATMOST(((RIGHT.CNSMR_SSN = LEFT.CNSMR_SSN)),Config.CNSMR_SSN_LP_MAXBLOCKSIZE),HASH,UNORDERED); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := Process_xLNPID_Layouts.CombineLinkpathScores(J2); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT311.MAC_Dups_Restore(J3,DD,J4,Reference,TRUE)
  RETURN J4;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_CNSMR_SSN='',Input_FNAME='',Input_MNAME='',Input_LNAME='',Input_V_CITY_NAME='',Input_ST='',Input_GENDER='',Input_SNAME='',Input_CNSMR_DOB='',Input_C_LIC_NBR='',Input_LIC_STATE='',output_file,AsIndex='true') := MACRO
  IMPORT SALT311,Health_Provider_Services;
  #IF(#TEXT(Input_CNSMR_SSN)<>'')
    #UNIQUENAME(trans)
    Health_Provider_Services.Key_HealthProvider_CNSMR_SSN_LP.InputLayout_Batch %trans%(InFile le) := TRANSFORM
      SELF.Reference := le.Input_Ref;
      SELF.CNSMR_SSN := (TYPEOF(SELF.CNSMR_SSN))le.Input_CNSMR_SSN;
      SELF.CNSMR_SSN_len := LENGTH(TRIM((TYPEOF(SELF.CNSMR_SSN))le.Input_CNSMR_SSN));
      #IF ( #TEXT(Input_FNAME) <> '' )
        SELF.FNAME := (TYPEOF(SELF.FNAME))le.Input_FNAME;
        SELF.FNAME_len := LENGTH(TRIM((TYPEOF(SELF.FNAME))le.Input_FNAME));
      #END
      #IF ( #TEXT(Input_MNAME) <> '' )
        SELF.MNAME := (TYPEOF(SELF.MNAME))le.Input_MNAME;
        SELF.MNAME_len := LENGTH(TRIM((TYPEOF(SELF.MNAME))le.Input_MNAME));
      #END
      #IF ( #TEXT(Input_LNAME) <> '' )
        SELF.LNAME := (TYPEOF(SELF.LNAME))le.Input_LNAME;
        SELF.LNAME_len := LENGTH(TRIM((TYPEOF(SELF.LNAME))le.Input_LNAME));
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
      #IF ( #TEXT(Input_SNAME) <> '' )
        SELF.SNAME := (TYPEOF(SELF.SNAME))le.Input_SNAME;
      #END
      #IF ( #TEXT(Input_CNSMR_DOB) <> '' )
          SELF.CNSMR_DOB := (UNSIGNED4)le.Input_CNSMR_DOB;
      #END
      #IF ( #TEXT(Input_C_LIC_NBR) <> '' )
        SELF.C_LIC_NBR := (TYPEOF(SELF.C_LIC_NBR))le.Input_C_LIC_NBR;
        SELF.C_LIC_NBR_len := LENGTH(TRIM((TYPEOF(SELF.C_LIC_NBR))le.Input_C_LIC_NBR));
      #END
      #IF ( #TEXT(Input_LIC_STATE) <> '' )
        SELF.LIC_STATE := (TYPEOF(SELF.LIC_STATE))le.Input_LIC_STATE;
      #END
    END;
    #UNIQUENAME(p)
    %p% := PROJECT(Infile,%trans%(left));
    output_file := Health_Provider_Services.Key_HealthProvider_CNSMR_SSN_LP.ScoredFetch_Batch(%p%,AsIndex);
  #ELSE
    output_file := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch); // Compulsory fields missing
  #END
ENDMACRO;
END;
