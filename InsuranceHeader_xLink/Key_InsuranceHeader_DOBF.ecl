﻿IMPORT SALT311,std;
EXPORT Key_InsuranceHeader_DOBF(BOOLEAN incremental=FALSE, UNSIGNED2  aBlockLimit= Config.DOBF_MAXBLOCKLIMIT) := MODULE/*HACK25*/
 
//DOB:FNAME:?:LNAME:MNAME:+:ST:CITY:SSN5:SSN4:DERIVED_GENDER:DL_NBR:DL_STATE:SNAME
EXPORT KeyName := KeyNames().DOBF_logical; /*HACK40*/
 
EXPORT KeyName_sf := KeyNames().DOBF_super; /*HACK10*/
 
EXPORT AssignCurrentKeyToSuperFile := FileServices.AddSuperFile(KeyName_sf,KeyName);
 
EXPORT ClearKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(KeyName_sf,,TRUE),FileServices.ClearSuperFile(KeyName_sf));
STRING csv_fields := 'DOB_year,DOB_month,DOB_day,FNAME,LNAME,MNAME,ST,CITY,SSN5,SSN4,DERIVED_GENDER,DL_NBR,DL_STATE,SNAME,DID';
SHARED h := CandidatesForKey(csv_fields, incremental);//The input file - distributed by DID
 
SHARED s := Specificities(File_InsuranceHeader).Specificities[1];
SHARED s_index := Keys(File_InsuranceHeader).Specificities_Key[1]; // Index access for MEOW queries
layout := RECORD // project out required fields
// Compulsory fields
  h.DOB_year;
  h.DOB_month;
  h.DOB_day;
  h.FNAME;
// Optional fields
  h.DID; // The ID field
  h.LNAME;
  h.MNAME;
// Extra credit fields
  h.ST;
  h.CITY;
  h.SSN5;
  h.SSN4;
  h.DERIVED_GENDER;
  h.DL_NBR;
  h.DL_STATE;
  h.SNAME;
  h.DT_EFFECTIVE_FIRST;
  h.DT_EFFECTIVE_LAST;
  h.FNAME_len;
  h.LNAME_len;
  h.MNAME_len;
  h.SSN5_len;
  h.SSN4_len;
  h.DL_NBR_len;
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
  h.FNAME_PreferredName_Weight100;
  h.FNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.LNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_MAINNAME_fuzzy_weight100 ; // Contains 100x the specificity
  h.LNAME_p_Weight100;
  h.LNAME_e1_Weight100;
  h.LNAME_e1p_Weight100;
  h.LNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.MNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_MAINNAME_fuzzy_weight100 ; // Contains 100x the specificity
  h.MNAME_initial_char_weight100 ; // Contains 100x the specificity
  h.MNAME_e2_Weight100;
  h.MNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.ST_weight100 ; // Contains 100x the specificity
  h.CITY_weight100 ; // Contains 100x the specificity
  h.SSN5_weight100 ; // Contains 100x the specificity
  INTEGER2 SSN5_e1_Weight100 := SALT311.Min0(h.SSN5_weight100 + 100*log(h.SSN5_cnt/h.SSN5_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.SSN4_weight100 ; // Contains 100x the specificity
  INTEGER2 SSN4_e1_Weight100 := SALT311.Min0(h.SSN4_weight100 + 100*log(h.SSN4_cnt/h.SSN4_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.DERIVED_GENDER_weight100 ; // Contains 100x the specificity
  h.DERIVED_GENDER_initial_char_weight100 ; // Contains 100x the specificity
  h.DL_NBR_weight100 ; // Contains 100x the specificity
  INTEGER2 DL_NBR_e1_Weight100 := SALT311.Min0(h.DL_NBR_weight100 + 100*log(h.DL_NBR_cnt/h.DL_NBR_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.DL_STATE_weight100 ; // Contains 100x the specificity
  h.SNAME_weight100 ; // Contains 100x the specificity
END;
 
DataForKey0 := DEDUP(SORT(TABLE(h((DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) OR DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) OR DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)),(FNAME NOT IN SET(s.nulls_FNAME,FNAME) AND FNAME <> (TYPEOF(FNAME))'')),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
SHARED DataForKey := DataForKey0;
 
EXPORT Key := INDEX(DataForKey,{DataForKey},{BOOLEAN IsIncremental := incremental},KeyName_sf);
 
EXPORT BuildAll := BUILDINDEX(Key, KeyName, OVERWRITE);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,DID,DOB_year,DOB_month,DOB_day,FNAME,LNAME,MNAME,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_ST := GROUP( DEDUP( SORT( Grpd, EXCEPT ST), EXCEPT ST));
  CntRed_ST := (KeyCnt-COUNT(Rem_ST))/KeyCnt;
  Rem_CITY := GROUP( DEDUP( SORT( Grpd, EXCEPT CITY), EXCEPT CITY));
  CntRed_CITY := (KeyCnt-COUNT(Rem_CITY))/KeyCnt;
  Rem_SSN5 := GROUP( DEDUP( SORT( Grpd, EXCEPT SSN5), EXCEPT SSN5));
  CntRed_SSN5 := (KeyCnt-COUNT(Rem_SSN5))/KeyCnt;
  Rem_SSN4 := GROUP( DEDUP( SORT( Grpd, EXCEPT SSN4), EXCEPT SSN4));
  CntRed_SSN4 := (KeyCnt-COUNT(Rem_SSN4))/KeyCnt;
  Rem_DERIVED_GENDER := GROUP( DEDUP( SORT( Grpd, EXCEPT DERIVED_GENDER), EXCEPT DERIVED_GENDER));
  CntRed_DERIVED_GENDER := (KeyCnt-COUNT(Rem_DERIVED_GENDER))/KeyCnt;
  Rem_DL_NBR := GROUP( DEDUP( SORT( Grpd, EXCEPT DL_NBR), EXCEPT DL_NBR));
  CntRed_DL_NBR := (KeyCnt-COUNT(Rem_DL_NBR))/KeyCnt;
  Rem_DL_STATE := GROUP( DEDUP( SORT( Grpd, EXCEPT DL_STATE), EXCEPT DL_STATE));
  CntRed_DL_STATE := (KeyCnt-COUNT(Rem_DL_STATE))/KeyCnt;
  Rem_SNAME := GROUP( DEDUP( SORT( Grpd, EXCEPT SNAME), EXCEPT SNAME));
  CntRed_SNAME := (KeyCnt-COUNT(Rem_SNAME))/KeyCnt;
EXPORT Shrinkage := DATASET([{'DOBF','ST',CntRed_ST*100,CntRed_ST*TSize},{'DOBF','CITY',CntRed_CITY*100,CntRed_CITY*TSize},{'DOBF','SSN5',CntRed_SSN5*100,CntRed_SSN5*TSize},{'DOBF','SSN4',CntRed_SSN4*100,CntRed_SSN4*TSize},{'DOBF','DERIVED_GENDER',CntRed_DERIVED_GENDER*100,CntRed_DERIVED_GENDER*TSize},{'DOBF','DL_NBR',CntRed_DL_NBR*100,CntRed_DL_NBR*TSize},{'DOBF','DL_STATE',CntRed_DL_STATE*100,CntRed_DL_STATE*TSize},{'DOBF','SNAME',CntRed_SNAME*100,CntRed_SNAME*TSize}],SALT311.ShrinkLayout);
EXPORT MergeKeyFiles(STRING superFileIn, STRING outfileName, UNSIGNED4 minDate = 0, BOOLEAN replaceExisting = FALSE) := FUNCTION
  fieldListIndex := SALT311.MAC_FieldListCSVFromDataset(DataForKey,[],',');
  fieldListPayload := 'IsIncremental';
  RETURN Process_xIDL_Layouts().MAC_GenerateMergedKey(superFileIn, outfileName, minDate, replaceExisting, fieldListIndex, fieldListPayload, 'Key');
END;
EXPORT MAX_BLOCKLIMIT := IF (aBlockLimit=0,  Config.DOBF_MAXBLOCKLIMIT, aBlockLimit);/*HACK24a*/
EXPORT CanSearch(Process_xIDL_Layouts().InputLayout le) := le.DOB <> (TYPEOF(le.DOB))'' AND Fields.InValid_DOB((SALT311.StrType)le.DOB)=0 AND le.FNAME <> (TYPEOF(le.FNAME))'' AND Fields.InValid_FNAME((SALT311.StrType)le.FNAME)=0;
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(UNSIGNED4 param_DOB,TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'') := 
    STEPPED( LIMIT( Key(
           param_DOB <> 0 AND KEYED(DOB_year = param_DOB DIV 10000 AND DOB_month = param_DOB DIV 100 % 100 AND DOB_day = param_DOB % 100)
      AND KEYED((FNAME = param_FNAME))
      AND ((param_LNAME = (TYPEOF(LNAME))'' OR LNAME = (TYPEOF(LNAME))'') OR (LNAME = param_LNAME) OR ( (metaphonelib.DMetaPhone1(LNAME)=metaphonelib.DMetaPhone1(param_LNAME))  OR (Config.WithinEditN(LNAME,LNAME_len,param_LNAME,param_LNAME_len,1,Config.LNAME_LENGTH_EDIT2) /*HACK06*/)  OR (SALT311.HyphenMatch(LNAME,param_LNAME,1)<=2)OR (Config.WildMatch(LNAME,param_LNAME,FALSE)) ))
      AND ((param_MNAME = (TYPEOF(MNAME))'' OR MNAME = (TYPEOF(MNAME))'') OR (MNAME = param_MNAME) OR ((MNAME[1..LENGTH(TRIM(param_MNAME))] = param_MNAME OR param_MNAME[1..LENGTH(TRIM(MNAME))] = MNAME)  OR (Config.WithinEditN(MNAME,MNAME_len,param_MNAME,param_MNAME_len,2, 0)) ))),MAX_BLOCKLIMIT/*HACK24b*/,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),DID);
 
 
EXPORT ScoredDIDFetch(UNSIGNED4 param_DOB,TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',TYPEOF(h.CITY) param_CITY = (TYPEOF(h.CITY))'',TYPEOF(h.SSN5) param_SSN5 = (TYPEOF(h.SSN5))'',TYPEOF(h.SSN5_len) param_SSN5_len = (TYPEOF(h.SSN5_len))'',TYPEOF(h.SSN4) param_SSN4 = (TYPEOF(h.SSN4))'',TYPEOF(h.SSN4_len) param_SSN4_len = (TYPEOF(h.SSN4_len))'',TYPEOF(h.DERIVED_GENDER) param_DERIVED_GENDER = (TYPEOF(h.DERIVED_GENDER))'',TYPEOF(h.DL_NBR) param_DL_NBR = (TYPEOF(h.DL_NBR))'',TYPEOF(h.DL_NBR_len) param_DL_NBR_len = (TYPEOF(h.DL_NBR_len))'',TYPEOF(h.DL_STATE) param_DL_STATE = (TYPEOF(h.DL_STATE))'',TYPEOF(h.SNAME) param_SNAME = (TYPEOF(h.SNAME))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetch(param_DOB,param_FNAME,param_FNAME_len,param_LNAME,param_LNAME_len,param_MNAME,param_MNAME_len);
useDate := (UNSIGNED4)SALT311.fn_now('YYYYMMDD');
 
  Process_xIDL_Layouts().LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 6; // Set bitmap for keys used
    SELF.keys_poisoned := IF(le.DT_EFFECTIVE_LAST <> 0 AND le.IsIncremental, SELF.keys_used, 0);
    SELF.keys_failed := IF(le.DID = 0, 1 << 6, 0); // Set bitmap for key failed
    SELF.DOB_year_match_code := MAP(
      le.DOB_year = 0 OR ((UNSIGNED)param_DOB) DIV 10000 = 0 /*DOBHACK01*/ => SALT311.MatchCode.OneSideNull,
      match_methods(File_InsuranceHeader).match_DOB_year(le.DOB_year,((UNSIGNED)param_DOB) DIV 10000,TRUE));
    SELF.DOBWeight_year := (50+MAP ( SELF.DOB_year_match_code = SALT311.MatchCode.OneSideNull => 0,
       SELF.DOB_year_match_code = SALT311.MatchCode.ExactMatch => le.DOB_year_weight100,
       -1.000*le.DOB_year_weight100))/100;
    SELF.DOB_month_match_code := MAP(
      le.DOB_month = 0 OR ((UNSIGNED)param_DOB) DIV 100 % 100 = 0 /*DOBHACK02*/ => SALT311.MatchCode.OneSideNull,
      match_methods(File_InsuranceHeader).match_DOB_month(le.DOB_month,((UNSIGNED)param_DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)param_DOB) % 100,TRUE));
    SELF.DOBWeight_month := (50+MAP ( SELF.DOB_month_match_code = SALT311.MatchCode.OneSideNull => 0,
      SELF.DOB_month_match_code = SALT311.MatchCode.ExactMatch => le.DOB_month_weight100,
       -1.000*le.DOB_month_weight100))/100;
    SELF.DOB_day_match_code := MAP(
		le.DOB_day = 0 OR ((UNSIGNED)param_DOB) % 100 = 0 /*DOBHACK03*/ => SALT311.MatchCode.OneSideNull,
      match_methods(File_InsuranceHeader).match_DOB_day(le.DOB_month,((UNSIGNED)param_DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)param_DOB) % 100,TRUE));
    SELF.DOBWeight_day := (50+MAP ( SELF.DOB_day_match_code = SALT311.MatchCode.OneSideNull => 0,
      SELF.DOB_day_match_code = SALT311.MatchCode.ExactMatch => le.DOB_day_weight100,
       -1.000*le.DOB_day_weight100))/100;
		DOB_AggWeight := SELF.DOBWeight_day + SELF.DOBWeight_month + SELF.DOBWeight_year;
    SELF.DOB_match_code := MAP(
      le.DOB_year+le.DOB_month+le.DOB_day = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(File_InsuranceHeader).match_DOB_el(le.DOB_year, le.DOB_month, le.DOB_day, param_DOB, DOB_AggWeight ,TRUE));
    SELF.DOBWeight :=  MAP(
           SELF.DOB_match_code = SALT311.MatchCode.OneSideNull => 0,
           DOB_AggWeight); 
    SELF.FNAME_match_code := match_methods(File_InsuranceHeader).match_FNAME(le.FNAME,param_FNAME,le.FNAME_len,param_FNAME_len,TRUE);
    SELF.FNAMEWeight := (50+MAP (
           SELF.FNAME_match_code = SALT311.MatchCode.ExactMatch =>le.FNAME_weight100,
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
    SELF.MNAME_match_code := MAP(
           le.MNAME = (TYPEOF(le.MNAME))'' OR param_MNAME = (TYPEOF(param_MNAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_MNAME(le.MNAME,param_MNAME,le.MNAME_len,param_MNAME_len,FALSE));
    SELF.MNAMEWeight := (50+MAP (
           SELF.MNAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.MNAME_match_code = SALT311.MatchCode.ExactMatch =>le.MNAME_weight100,
           SELF.MNAME_match_code = SALT311.MatchCode.InitialLMatch =>le.MNAME_weight100,
           SELF.MNAME_match_code = SALT311.MatchCode.InitialRMatch=> SALT311.Fn_Interpolate_Initial(le.MNAME,param_MNAME,le.MNAME_weight100,le.MNAME_initial_char_weight100),
           SELF.MNAME_match_code = SALT311.MatchCode.EditDistanceMatch =>le.MNAME_e2_weight100,
           -0.772*le.MNAME_weight100))/100*0.80; 
    SELF.ST_match_code := MAP(
           le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_ST(le.ST,param_ST,FALSE));
    SELF.STWeight := (50+MAP (
           SELF.ST_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.ST_match_code = SALT311.MatchCode.ExactMatch =>le.ST_weight100,
           -0.690*le.ST_weight100))/100; 
    SELF.CITY_match_code := MAP(
           le.CITY = (TYPEOF(le.CITY))'' OR param_CITY = (TYPEOF(param_CITY))'' => SALT311.MatchCode.OneSideNull,
           le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' OR le.ST <> param_ST  => SALT311.MatchCode.ContextNoMatch, // Only valid if the context variable is equal
           match_methods(File_InsuranceHeader).match_CITY(le.CITY,param_CITY,FALSE));
    SELF.CITYWeight := (50+MAP (
           SELF.CITY_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.CITY_match_code = SALT311.MatchCode.ContextNoMatch => 0,
           SELF.CITY_match_code = SALT311.MatchCode.ExactMatch =>le.CITY_weight100,
           -0.580*le.CITY_weight100))/100; 
    SELF.SSN5_match_code := MAP(
           le.SSN5 = (TYPEOF(le.SSN5))'' OR param_SSN5 = (TYPEOF(param_SSN5))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_SSN5(le.SSN5,param_SSN5,le.SSN5_len,param_SSN5_len,FALSE));
    SELF.SSN5Weight := (50+MAP (
           SELF.SSN5_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.SSN5_match_code = SALT311.MatchCode.ExactMatch =>le.SSN5_weight100,
           SELF.SSN5_match_code = SALT311.MatchCode.EditDistanceMatch =>le.SSN5_e1_weight100,
           -0.873*le.SSN5_weight100))/100; 
    SELF.SSN4_match_code := MAP(
           le.SSN4 = (TYPEOF(le.SSN4))'' OR param_SSN4 = (TYPEOF(param_SSN4))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_SSN4(le.SSN4,param_SSN4,le.SSN4_len,param_SSN4_len,FALSE));
    SELF.SSN4Weight := (50+MAP (
           SELF.SSN4_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.SSN4_match_code = SALT311.MatchCode.ExactMatch =>le.SSN4_weight100,
           SELF.SSN4_match_code = SALT311.MatchCode.EditDistanceMatch =>le.SSN4_e1_weight100,
           -0.866*le.SSN4_weight100))/100; 
    SELF.DERIVED_GENDER_match_code := MAP(
           le.DERIVED_GENDER = (TYPEOF(le.DERIVED_GENDER))'' OR param_DERIVED_GENDER = (TYPEOF(param_DERIVED_GENDER))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_DERIVED_GENDER(le.DERIVED_GENDER,param_DERIVED_GENDER,FALSE));
    SELF.DERIVED_GENDERWeight := (50+MAP (
           SELF.DERIVED_GENDER_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.DERIVED_GENDER_match_code = SALT311.MatchCode.ExactMatch =>le.DERIVED_GENDER_weight100,
           SELF.DERIVED_GENDER_match_code = SALT311.MatchCode.InitialLMatch =>le.DERIVED_GENDER_weight100,
           SELF.DERIVED_GENDER_match_code = SALT311.MatchCode.InitialRMatch=> SALT311.Fn_Interpolate_Initial(le.DERIVED_GENDER,param_DERIVED_GENDER,le.DERIVED_GENDER_weight100,le.DERIVED_GENDER_initial_char_weight100),
           -0.983*le.DERIVED_GENDER_weight100))/100; 
    SELF.DL_NBR_match_code := MAP(
           le.DL_NBR = (TYPEOF(le.DL_NBR))'' OR param_DL_NBR = (TYPEOF(param_DL_NBR))'' => SALT311.MatchCode.OneSideNull,
           le.DL_STATE = (TYPEOF(le.DL_STATE))'' OR param_DL_STATE = (TYPEOF(param_DL_STATE))'' OR le.DL_STATE <> param_DL_STATE  => SALT311.MatchCode.ContextNoMatch, // Only valid if the context variable is equal
           match_methods(File_InsuranceHeader).match_DL_NBR(le.DL_NBR,param_DL_NBR,le.DL_NBR_len,param_DL_NBR_len,FALSE));
    SELF.DL_NBRWeight := (50+MAP (
           SELF.DL_NBR_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.DL_NBR_match_code = SALT311.MatchCode.ContextNoMatch => 0,
           SELF.DL_NBR_match_code = SALT311.MatchCode.ExactMatch =>le.DL_NBR_weight100,
           SELF.DL_NBR_match_code = SALT311.MatchCode.EditDistanceMatch =>le.DL_NBR_e1_weight100,
           -0.876*le.DL_NBR_weight100))/100; 
    SELF.DL_STATE_MATCH_CODE := IF(SELF.DL_NBRWeight>0, MAP( /*HACK22a*/
           le.DL_STATE = (TYPEOF(le.DL_STATE))'' OR param_DL_STATE = (TYPEOF(param_DL_STATE))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_DL_STATE(le.DL_STATE,param_DL_STATE,FALSE)), 0) /*HACK22b*/;
    SELF.DL_STATEWeight := IF(SELF.DL_NBRWeight>0, (50+MAP ( /*HACK23a*/
           SELF.DL_STATE_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.DL_STATE_match_code = SALT311.MatchCode.ExactMatch =>le.DL_STATE_weight100,
           -0.975*le.DL_STATE_weight100))/100, 0); /*HACK23b*/ 
    SELF.SNAME_match_code := MAP(
           le.SNAME = (TYPEOF(le.SNAME))'' OR param_SNAME = (TYPEOF(param_SNAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_SNAME(le.SNAME,param_SNAME,FALSE));
    SELF.SNAMEWeight := (50+MAP (
           SELF.SNAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.SNAME_match_code = SALT311.MatchCode.ExactMatch =>le.SNAME_weight100,
           -0.946*le.SNAME_weight100))/100; 
    SELF.Weight := IF(le.DID = 0, 100, MAX(0, SELF.DOBWeight) + MAX(0, SELF.FNAMEWeight) + MAX(0, SELF.LNAMEWeight) + MAX(0, SELF.MNAMEWeight) + MAX(0, SELF.STWeight) + MAX(0, SELF.CITYWeight) + MAX(0, SELF.SSN5Weight) + MAX(0, SELF.SSN4Weight) + MAX(0, SELF.DERIVED_GENDERWeight) + MAX(0, SELF.DL_NBRWeight) + MAX(0, SELF.DL_STATEWeight) + MAX(0, SELF.SNAMEWeight));
    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));
  poisoned_results := TABLE(result0(keys_poisoned > 0), {DID, keys_poisoned}, DID, keys_poisoned);
  result_rollup0 := DEDUP(SORT(result0,DID,DOB_year,DOB_month,DOB_day,FNAME,LNAME,MNAME,ST,CITY,SSN5,SSN4,DERIVED_GENDER,DL_NBR,DL_STATE,SNAME,DT_EFFECTIVE_FIRST,-DT_EFFECTIVE_LAST),DID,DOB_year,DOB_month,DOB_day,FNAME,LNAME,MNAME,ST,CITY,SSN5,SSN4,DERIVED_GENDER,DL_NBR,DL_STATE,SNAME,DT_EFFECTIVE_FIRST);
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
  UNSIGNED4 DOB := 0;
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))'';
  TYPEOF(h.FNAME_len) FNAME_len := (TYPEOF(h.FNAME_len))'';
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))'';
  TYPEOF(h.LNAME_len) LNAME_len := (TYPEOF(h.LNAME_len))'';
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))'';
  TYPEOF(h.MNAME_len) MNAME_len := (TYPEOF(h.MNAME_len))'';
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))'';
  TYPEOF(h.CITY) CITY := (TYPEOF(h.CITY))'';
  TYPEOF(h.SSN5) SSN5 := (TYPEOF(h.SSN5))'';
  TYPEOF(h.SSN5_len) SSN5_len := (TYPEOF(h.SSN5_len))'';
  TYPEOF(h.SSN4) SSN4 := (TYPEOF(h.SSN4))'';
  TYPEOF(h.SSN4_len) SSN4_len := (TYPEOF(h.SSN4_len))'';
  TYPEOF(h.DERIVED_GENDER) DERIVED_GENDER := (TYPEOF(h.DERIVED_GENDER))'';
  TYPEOF(h.DL_NBR) DL_NBR := (TYPEOF(h.DL_NBR))'';
  TYPEOF(h.DL_NBR_len) DL_NBR_len := (TYPEOF(h.DL_NBR_len))'';
  TYPEOF(h.DL_STATE) DL_STATE := (TYPEOF(h.DL_STATE))'';
  TYPEOF(h.SNAME) SNAME := (TYPEOF(h.SNAME))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex, BOOLEAN In_disableForce = FALSE) := FUNCTION
 
  Process_xIDL_Layouts().LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 6; // Set bitmap for keys used
    SELF.keys_poisoned := IF(le.DT_EFFECTIVE_LAST <> 0 AND le.IsIncremental, SELF.keys_used, 0);
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.DOB_year_match_code := MAP(
      le.DOB_year = 0 OR ((UNSIGNED)ri.DOB) DIV 10000 = 0 /*DOBHACK04*/ => SALT311.MatchCode.OneSideNull,
      match_methods(File_InsuranceHeader).match_DOB_year(le.DOB_year,((UNSIGNED)ri.DOB) DIV 10000,TRUE));
    SELF.DOBWeight_year := (50+MAP ( SELF.DOB_year_match_code = SALT311.MatchCode.OneSideNull => 0,
       SELF.DOB_year_match_code = SALT311.MatchCode.ExactMatch => le.DOB_year_weight100,
       -1.000*le.DOB_year_weight100))/100;
    SELF.DOB_month_match_code := MAP(
      le.DOB_month = 0 OR ((UNSIGNED)ri.DOB) DIV 100 % 100 = 0 /*DOBHACK05*/ => SALT311.MatchCode.OneSideNull,
      match_methods(File_InsuranceHeader).match_DOB_month(le.DOB_month,((UNSIGNED)ri.DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)ri.DOB) % 100,TRUE));
    SELF.DOBWeight_month := (50+MAP ( SELF.DOB_month_match_code = SALT311.MatchCode.OneSideNull => 0,
      SELF.DOB_month_match_code = SALT311.MatchCode.ExactMatch => le.DOB_month_weight100,
       -1.000*le.DOB_month_weight100))/100;
    SELF.DOB_day_match_code := MAP(
		le.DOB_day = 0 OR ((UNSIGNED)ri.DOB) % 100 = 0 /*DOBHACK06*/ => SALT311.MatchCode.OneSideNull,
      match_methods(File_InsuranceHeader).match_DOB_day(le.DOB_month,((UNSIGNED)ri.DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)ri.DOB) % 100,TRUE));
    SELF.DOBWeight_day := (50+MAP ( SELF.DOB_day_match_code = SALT311.MatchCode.OneSideNull => 0,
      SELF.DOB_day_match_code = SALT311.MatchCode.ExactMatch => le.DOB_day_weight100,
       -1.000*le.DOB_day_weight100))/100;
		DOB_AggWeight := SELF.DOBWeight_day + SELF.DOBWeight_month + SELF.DOBWeight_year;
    SELF.DOB_match_code := MAP(
      le.DOB_year+le.DOB_month+le.DOB_day = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(File_InsuranceHeader).match_DOB_el(le.DOB_year, le.DOB_month, le.DOB_day, ri.DOB, DOB_AggWeight ,TRUE));
    SELF.DOBWeight :=  MAP(
           SELF.DOB_match_code = SALT311.MatchCode.OneSideNull => 0,
           DOB_AggWeight); 
    SELF.FNAME_match_code := match_methods(File_InsuranceHeader).match_FNAME(le.FNAME,ri.FNAME,le.FNAME_len,ri.FNAME_len,TRUE);
    SELF.FNAMEWeight := (50+MAP (
           SELF.FNAME_match_code = SALT311.MatchCode.ExactMatch =>le.FNAME_weight100,
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
    SELF.MNAME_match_code := MAP(
           le.MNAME = (TYPEOF(le.MNAME))'' OR ri.MNAME = (TYPEOF(ri.MNAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_MNAME(le.MNAME,ri.MNAME,le.MNAME_len,ri.MNAME_len,FALSE));
    SELF.MNAMEWeight := (50+MAP (
           SELF.MNAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.MNAME_match_code = SALT311.MatchCode.ExactMatch =>le.MNAME_weight100,
           SELF.MNAME_match_code = SALT311.MatchCode.InitialLMatch =>le.MNAME_weight100,
           SELF.MNAME_match_code = SALT311.MatchCode.InitialRMatch=> SALT311.Fn_Interpolate_Initial(le.MNAME,ri.MNAME,le.MNAME_weight100,le.MNAME_initial_char_weight100),
           SELF.MNAME_match_code = SALT311.MatchCode.EditDistanceMatch =>le.MNAME_e2_weight100,
           -0.772*le.MNAME_weight100))/100*0.80; 
    SELF.ST_match_code := MAP(
           le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_ST(le.ST,ri.ST,FALSE));
    SELF.STWeight := (50+MAP (
           SELF.ST_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.ST_match_code = SALT311.MatchCode.ExactMatch =>le.ST_weight100,
           -0.690*le.ST_weight100))/100; 
    SELF.CITY_match_code := MAP(
           le.CITY = (TYPEOF(le.CITY))'' OR ri.CITY = (TYPEOF(ri.CITY))'' => SALT311.MatchCode.OneSideNull,
           le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' OR le.ST <> ri.ST  => SALT311.MatchCode.ContextNoMatch, // Only valid if the context variable is equal
           match_methods(File_InsuranceHeader).match_CITY(le.CITY,ri.CITY,FALSE));
    SELF.CITYWeight := (50+MAP (
           SELF.CITY_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.CITY_match_code = SALT311.MatchCode.ContextNoMatch => 0,
           SELF.CITY_match_code = SALT311.MatchCode.ExactMatch =>le.CITY_weight100,
           -0.580*le.CITY_weight100))/100; 
    SELF.SSN5_match_code := MAP(
           le.SSN5 = (TYPEOF(le.SSN5))'' OR ri.SSN5 = (TYPEOF(ri.SSN5))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_SSN5(le.SSN5,ri.SSN5,le.SSN5_len,ri.SSN5_len,FALSE));
    SELF.SSN5Weight := (50+MAP (
           SELF.SSN5_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.SSN5_match_code = SALT311.MatchCode.ExactMatch =>le.SSN5_weight100,
           SELF.SSN5_match_code = SALT311.MatchCode.EditDistanceMatch =>le.SSN5_e1_weight100,
           -0.873*le.SSN5_weight100))/100; 
    SELF.SSN4_match_code := MAP(
           le.SSN4 = (TYPEOF(le.SSN4))'' OR ri.SSN4 = (TYPEOF(ri.SSN4))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_SSN4(le.SSN4,ri.SSN4,le.SSN4_len,ri.SSN4_len,FALSE));
    SELF.SSN4Weight := (50+MAP (
           SELF.SSN4_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.SSN4_match_code = SALT311.MatchCode.ExactMatch =>le.SSN4_weight100,
           SELF.SSN4_match_code = SALT311.MatchCode.EditDistanceMatch =>le.SSN4_e1_weight100,
           -0.866*le.SSN4_weight100))/100; 
    SELF.DERIVED_GENDER_match_code := MAP(
           le.DERIVED_GENDER = (TYPEOF(le.DERIVED_GENDER))'' OR ri.DERIVED_GENDER = (TYPEOF(ri.DERIVED_GENDER))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_DERIVED_GENDER(le.DERIVED_GENDER,ri.DERIVED_GENDER,FALSE));
    SELF.DERIVED_GENDERWeight := (50+MAP (
           SELF.DERIVED_GENDER_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.DERIVED_GENDER_match_code = SALT311.MatchCode.ExactMatch =>le.DERIVED_GENDER_weight100,
           SELF.DERIVED_GENDER_match_code = SALT311.MatchCode.InitialLMatch =>le.DERIVED_GENDER_weight100,
           SELF.DERIVED_GENDER_match_code = SALT311.MatchCode.InitialRMatch=> SALT311.Fn_Interpolate_Initial(le.DERIVED_GENDER,ri.DERIVED_GENDER,le.DERIVED_GENDER_weight100,le.DERIVED_GENDER_initial_char_weight100),
           -0.983*le.DERIVED_GENDER_weight100))/100; 
    SELF.DL_NBR_match_code := MAP(
           le.DL_NBR = (TYPEOF(le.DL_NBR))'' OR ri.DL_NBR = (TYPEOF(ri.DL_NBR))'' => SALT311.MatchCode.OneSideNull,
           le.DL_STATE = (TYPEOF(le.DL_STATE))'' OR ri.DL_STATE = (TYPEOF(ri.DL_STATE))'' OR le.DL_STATE <> ri.DL_STATE  => SALT311.MatchCode.ContextNoMatch, // Only valid if the context variable is equal
           match_methods(File_InsuranceHeader).match_DL_NBR(le.DL_NBR,ri.DL_NBR,le.DL_NBR_len,ri.DL_NBR_len,FALSE));
    SELF.DL_NBRWeight := (50+MAP (
           SELF.DL_NBR_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.DL_NBR_match_code = SALT311.MatchCode.ContextNoMatch => 0,
           SELF.DL_NBR_match_code = SALT311.MatchCode.ExactMatch =>le.DL_NBR_weight100,
           SELF.DL_NBR_match_code = SALT311.MatchCode.EditDistanceMatch =>le.DL_NBR_e1_weight100,
           -0.876*le.DL_NBR_weight100))/100; 
    SELF.DL_STATE_MATCH_CODE := IF(SELF.DL_NBRWeight>0, MAP( /*HACK22a*/
           le.DL_STATE = (TYPEOF(le.DL_STATE))'' OR ri.DL_STATE = (TYPEOF(ri.DL_STATE))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_DL_STATE(le.DL_STATE,ri.DL_STATE,FALSE)), 0) /*HACK22b*/;
    SELF.DL_STATEWeight := IF(SELF.DL_NBRWeight>0, (50+MAP ( /*HACK23a*/
           SELF.DL_STATE_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.DL_STATE_match_code = SALT311.MatchCode.ExactMatch =>le.DL_STATE_weight100,
           -0.975*le.DL_STATE_weight100))/100, 0); /*HACK23b*/ 
    SELF.SNAME_match_code := MAP(
           le.SNAME = (TYPEOF(le.SNAME))'' OR ri.SNAME = (TYPEOF(ri.SNAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_SNAME(le.SNAME,ri.SNAME,FALSE));
    SELF.SNAMEWeight := (50+MAP (
           SELF.SNAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.SNAME_match_code = SALT311.MatchCode.ExactMatch =>le.SNAME_weight100,
           -0.946*le.SNAME_weight100))/100; 
    SELF.Weight := IF(le.DID = 0, 100, MAX(0, SELF.DOBWeight) + MAX(0, SELF.FNAMEWeight) + MAX(0, SELF.LNAMEWeight) + MAX(0, SELF.MNAMEWeight) + MAX(0, SELF.STWeight) + MAX(0, SELF.CITYWeight) + MAX(0, SELF.SSN5Weight) + MAX(0, SELF.SSN4Weight) + MAX(0, SELF.DERIVED_GENDERWeight) + MAX(0, SELF.DL_NBRWeight) + MAX(0, SELF.DL_STATEWeight) + MAX(0, SELF.SNAMEWeight));
    SELF := le;
  END;
  Recs0 := Recs(DOB <> (TYPEOF(DOB))'',FNAME <> (TYPEOF(FNAME))'');
  SALT311.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference,Config.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,(SALT311.MOD_DateMatch((LEFT.DOB DIV 10000 ),(LEFT.DOB DIV 100 % 100 ),(LEFT.DOB % 100),RIGHT.DOB_year,RIGHT.DOB_month,RIGHT.DOB_day,false,false,0,false,0,0).NNEQ)
     AND ((RIGHT.FNAME = LEFT.FNAME))
     AND ((LEFT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'') OR (RIGHT.LNAME = LEFT.LNAME) OR ( (metaphonelib.DMetaPhone1(RIGHT.LNAME)=metaphonelib.DMetaPhone1(LEFT.LNAME))  OR (Config.WithinEditN(RIGHT.LNAME,RIGHT.LNAME_len,LEFT.LNAME,LEFT.LNAME_len,1, Config.LNAME_LENGTH_EDIT2) /*HACK09*/)  OR (SALT311.HyphenMatch(RIGHT.LNAME,LEFT.LNAME,1)<=2)OR (Config.WildMatch(RIGHT.LNAME,LEFT.LNAME,FALSE)) ))
     AND ((LEFT.MNAME = (TYPEOF(RIGHT.MNAME))'' OR RIGHT.MNAME = (TYPEOF(RIGHT.MNAME))'') OR (RIGHT.MNAME = LEFT.MNAME) OR ((RIGHT.MNAME[1..LENGTH(TRIM(LEFT.MNAME))] = LEFT.MNAME OR LEFT.MNAME[1..LENGTH(TRIM(RIGHT.MNAME))] = RIGHT.MNAME)  OR (Config.WithinEditN(RIGHT.MNAME,RIGHT.MNAME_len,LEFT.MNAME,LEFT.MNAME_len,2, 0)) )),Score_Batch(RIGHT,LEFT),
    ATMOST((SALT311.MOD_DateMatch((LEFT.DOB DIV 10000 ),(LEFT.DOB DIV 100 % 100 ),(LEFT.DOB % 100),RIGHT.DOB_year,RIGHT.DOB_month,RIGHT.DOB_day,false,false,0,false,0,0).NNEQ)
     AND ((RIGHT.FNAME = LEFT.FNAME)),Config.DOBF_MAXBLOCKSIZE)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),(SALT311.MOD_DateMatch((LEFT.DOB DIV 10000 ),(LEFT.DOB DIV 100 % 100 ),(LEFT.DOB % 100),RIGHT.DOB_year,RIGHT.DOB_month,RIGHT.DOB_day,false,false,0,false,0,0).NNEQ)
     AND ((RIGHT.FNAME = LEFT.FNAME))
     AND ((LEFT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'') OR (RIGHT.LNAME = LEFT.LNAME) OR ( (metaphonelib.DMetaPhone1(RIGHT.LNAME)=metaphonelib.DMetaPhone1(LEFT.LNAME))  OR (Config.WithinEditN(RIGHT.LNAME,RIGHT.LNAME_len,LEFT.LNAME,LEFT.LNAME_len,1, Config.LNAME_LENGTH_EDIT2) /*HACK09*/)  OR (SALT311.HyphenMatch(RIGHT.LNAME,LEFT.LNAME,1)<=2)OR (Config.WildMatch(RIGHT.LNAME,LEFT.LNAME,FALSE)) ))
     AND ((LEFT.MNAME = (TYPEOF(RIGHT.MNAME))'' OR RIGHT.MNAME = (TYPEOF(RIGHT.MNAME))'') OR (RIGHT.MNAME = LEFT.MNAME) OR ((RIGHT.MNAME[1..LENGTH(TRIM(LEFT.MNAME))] = LEFT.MNAME OR LEFT.MNAME[1..LENGTH(TRIM(RIGHT.MNAME))] = RIGHT.MNAME)  OR (Config.WithinEditN(RIGHT.MNAME,RIGHT.MNAME_len,LEFT.MNAME,LEFT.MNAME_len,2, 0)) )),Score_Batch(RIGHT,LEFT),
    ATMOST((SALT311.MOD_DateMatch((LEFT.DOB DIV 10000 ),(LEFT.DOB DIV 100 % 100 ),(LEFT.DOB % 100),RIGHT.DOB_year,RIGHT.DOB_month,RIGHT.DOB_day,false,false,0,false,0,0).NNEQ)
     AND ((RIGHT.FNAME = LEFT.FNAME)),Config.DOBF_MAXBLOCKSIZE),HASH,UNORDERED); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  useDate := (UNSIGNED4)SALT311.fn_now('YYYYMMDD');
  J2_dist := DISTRIBUTE(J2, HASH(Reference));
  poisoned_results := TABLE(SORT(J2_dist, Reference, DID, LOCAL), {Reference, DID, keys_poisoned}, Reference, DID, keys_poisoned, LOCAL);
  result_rollup0 := DEDUP(SORT(J2_dist,Reference,DID,DOB_year,DOB_month,DOB_day,FNAME,LNAME,MNAME,ST,CITY,SSN5,SSN4,DERIVED_GENDER,DL_NBR,DL_STATE,SNAME,DT_EFFECTIVE_FIRST,-DT_EFFECTIVE_LAST, LOCAL),Reference,DID,DOB_year,DOB_month,DOB_day,FNAME,LNAME,MNAME,ST,CITY,SSN5,SSN4,DERIVED_GENDER,DL_NBR,DL_STATE,SNAME,DT_EFFECTIVE_FIRST, LOCAL);
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
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_DOB='',Input_FNAME='',Input_LNAME='',Input_MNAME='',Input_ST='',Input_CITY='',Input_SSN5='',Input_SSN4='',Input_DERIVED_GENDER='',Input_DL_NBR='',Input_DL_STATE='',Input_SNAME='',output_file,AsIndex='true', In_disableForce = 'false') := MACRO
  IMPORT SALT311,InsuranceHeader_xLink;
  #IF(#TEXT(Input_DOB)<>'' AND #TEXT(Input_FNAME)<>'')
    #UNIQUENAME(trans)
    InsuranceHeader_xLink.Key_InsuranceHeader_DOBF().InputLayout_Batch %trans%(InFile le) := TRANSFORM
      SELF.Reference := le.Input_Ref;
      SELF.DOB := (UNSIGNED4)le.Input_DOB;
      SELF.FNAME := (TYPEOF(SELF.FNAME))le.Input_FNAME;
      SELF.FNAME_len := LENGTH(TRIM((TYPEOF(SELF.FNAME))le.Input_FNAME));
      #IF ( #TEXT(Input_LNAME) <> '' )
        SELF.LNAME := (TYPEOF(SELF.LNAME))le.Input_LNAME;
        SELF.LNAME_len := LENGTH(TRIM((TYPEOF(SELF.LNAME))le.Input_LNAME));
      #END
      #IF ( #TEXT(Input_MNAME) <> '' )
        SELF.MNAME := (TYPEOF(SELF.MNAME))le.Input_MNAME;
        SELF.MNAME_len := LENGTH(TRIM((TYPEOF(SELF.MNAME))le.Input_MNAME));
      #END
      #IF ( #TEXT(Input_ST) <> '' )
        SELF.ST := (TYPEOF(SELF.ST))le.Input_ST;
      #END
      #IF ( #TEXT(Input_CITY) <> '' )
        SELF.CITY := (TYPEOF(SELF.CITY))le.Input_CITY;
      #END
      #IF ( #TEXT(Input_SSN5) <> '' )
        SELF.SSN5 := (TYPEOF(SELF.SSN5))le.Input_SSN5;
        SELF.SSN5_len := LENGTH(TRIM((TYPEOF(SELF.SSN5))le.Input_SSN5));
      #END
      #IF ( #TEXT(Input_SSN4) <> '' )
        SELF.SSN4 := (TYPEOF(SELF.SSN4))le.Input_SSN4;
        SELF.SSN4_len := LENGTH(TRIM((TYPEOF(SELF.SSN4))le.Input_SSN4));
      #END
      #IF ( #TEXT(Input_DERIVED_GENDER) <> '' )
        SELF.DERIVED_GENDER := (TYPEOF(SELF.DERIVED_GENDER))le.Input_DERIVED_GENDER;
      #END
      #IF ( #TEXT(Input_DL_NBR) <> '' )
        SELF.DL_NBR := (TYPEOF(SELF.DL_NBR))le.Input_DL_NBR;
        SELF.DL_NBR_len := LENGTH(TRIM((TYPEOF(SELF.DL_NBR))le.Input_DL_NBR));
      #END
      #IF ( #TEXT(Input_DL_STATE) <> '' )
        SELF.DL_STATE := (TYPEOF(SELF.DL_STATE))le.Input_DL_STATE;
      #END
      #IF ( #TEXT(Input_SNAME) <> '' )
        SELF.SNAME := (TYPEOF(SELF.SNAME))le.Input_SNAME;
      #END
    END;
    #UNIQUENAME(p)
    %p% := PROJECT(Infile,%trans%(left));
    output_file := InsuranceHeader_xLink.Key_InsuranceHeader_DOBF().ScoredFetch_Batch(%p%,AsIndex, In_disableForce);
  #ELSE
    output_file := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch); // Compulsory fields missing
  #END
ENDMACRO;
END;
