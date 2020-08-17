﻿IMPORT SALT311,std;
EXPORT Key_InsuranceHeader_NAME(BOOLEAN incremental=FALSE, UNSIGNED2  aBlockLimit= Config.NAME_MAXBLOCKLIMIT) := MODULE/*HACK25*/
 
//FNAME:LNAME:ST:?:DERIVED_GENDER:SNAME:MNAME:SSN5:SSN4:+:PRIM_RANGE:PRIM_NAME:SEC_RANGE:CITY:DOB
EXPORT KeyName := KeyNames().NAME_logical; /*HACK40*/
 
EXPORT KeyName_sf := KeyNames().NAME_super; /*HACK10*/
 
EXPORT AssignCurrentKeyToSuperFile := FileServices.AddSuperFile(KeyName_sf,KeyName);
 
EXPORT ClearKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(KeyName_sf,,TRUE),FileServices.ClearSuperFile(KeyName_sf));
STRING csv_fields := 'FNAME,LNAME,ST,DERIVED_GENDER,SNAME,MNAME,SSN5,SSN4,PRIM_RANGE,PRIM_NAME,SEC_RANGE,CITY,DOB_year,DOB_month,DOB_day,DID';
SHARED h := CandidatesForKey(csv_fields, incremental);//The input file - distributed by DID
 
SHARED s := Specificities(File_InsuranceHeader).Specificities[1];
SHARED s_index := Keys(File_InsuranceHeader).Specificities_Key[1]; // Index access for MEOW queries
layout := RECORD // project out required fields
// Compulsory fields
  h.FNAME;
  h.LNAME;
  h.ST;
// Optional fields
  h.SNAME;
  h.DID; // The ID field
  h.DERIVED_GENDER;
  h.MNAME;
  h.SSN5;
  h.SSN4;
// Extra credit fields
  h.PRIM_RANGE;
  h.PRIM_NAME;
  h.SEC_RANGE;
  h.CITY;
  h.DOB_year;
  h.DOB_month;
  h.DOB_day;
  h.DT_EFFECTIVE_FIRST;
  h.DT_EFFECTIVE_LAST;
  h.FNAME_len;
  h.LNAME_len;
  h.MNAME_len;
  h.SSN5_len;
  h.SSN4_len;
  h.PRIM_RANGE_len;
  h.PRIM_NAME_len;
//Scores for various field components
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
  h.ST_weight100 ; // Contains 100x the specificity
  h.DERIVED_GENDER_weight100 ; // Contains 100x the specificity
  h.DERIVED_GENDER_initial_char_weight100 ; // Contains 100x the specificity
  h.SNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_MAINNAME_fuzzy_weight100 ; // Contains 100x the specificity
  h.MNAME_initial_char_weight100 ; // Contains 100x the specificity
  h.MNAME_e2_Weight100;
  h.MNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.SSN5_weight100 ; // Contains 100x the specificity
  INTEGER2 SSN5_e1_Weight100 := SALT311.Min0(h.SSN5_weight100 + 100*log(h.SSN5_cnt/h.SSN5_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.SSN4_weight100 ; // Contains 100x the specificity
  INTEGER2 SSN4_e1_Weight100 := SALT311.Min0(h.SSN4_weight100 + 100*log(h.SSN4_cnt/h.SSN4_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.PRIM_RANGE_weight100 ; // Contains 100x the specificity
  h.PRIM_RANGE_e1_Weight100;
  h.PRIM_NAME_weight100 ; // Contains 100x the specificity
  h.PRIM_NAME_e1_Weight100;
  h.SEC_RANGE_weight100 ; // Contains 100x the specificity
  h.CITY_weight100 ; // Contains 100x the specificity
  h.DOB_year_weight100; // Contains 100x the specificity
  h.DOB_month_weight100; // Contains 100x the specificity
  h.DOB_day_weight100; // Contains 100x the specificity
END;
 
DataForKey0 := DEDUP(SORT(TABLE(h((FNAME NOT IN SET(s.nulls_FNAME,FNAME) AND FNAME <> (TYPEOF(FNAME))''),(LNAME NOT IN SET(s.nulls_LNAME,LNAME) AND LNAME <> (TYPEOF(LNAME))''),(ST NOT IN SET(s.nulls_ST,ST) AND ST <> (TYPEOF(ST))'')),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
SHARED DataForKey := project(DataForKey0, transform(layout,	BOOLEAN emptyConcept :=  left.CITY = '' and 	left.PRIM_NAME = '';  
	 // 10-19 => st_weight/2 or 20 and greater => st_weight/3 
		self.st_weight100 := IF (emptyConcept AND left.st_weight100 >=1000 AND left.st_weight100<2000,  
					left.st_weight100/2, IF (emptyConcept AND left.st_weight100>=2000, left.st_weight100/3, left.st_weight100)); 
		self := left)); /*HACK39*/
 
EXPORT Key := INDEX(DataForKey,{DataForKey},{BOOLEAN IsIncremental := incremental},KeyName_sf);
 
EXPORT BuildAll := BUILDINDEX(Key, KeyName, OVERWRITE);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,DID,FNAME,LNAME,ST,DERIVED_GENDER,SNAME,MNAME,SSN5,SSN4,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_PRIM_RANGE := GROUP( DEDUP( SORT( Grpd, EXCEPT PRIM_RANGE), EXCEPT PRIM_RANGE));
  CntRed_PRIM_RANGE := (KeyCnt-COUNT(Rem_PRIM_RANGE))/KeyCnt;
  Rem_PRIM_NAME := GROUP( DEDUP( SORT( Grpd, EXCEPT PRIM_NAME), EXCEPT PRIM_NAME));
  CntRed_PRIM_NAME := (KeyCnt-COUNT(Rem_PRIM_NAME))/KeyCnt;
  Rem_SEC_RANGE := GROUP( DEDUP( SORT( Grpd, EXCEPT SEC_RANGE), EXCEPT SEC_RANGE));
  CntRed_SEC_RANGE := (KeyCnt-COUNT(Rem_SEC_RANGE))/KeyCnt;
  Rem_CITY := GROUP( DEDUP( SORT( Grpd, EXCEPT CITY), EXCEPT CITY));
  CntRed_CITY := (KeyCnt-COUNT(Rem_CITY))/KeyCnt;
  Rem_DOB := GROUP( DEDUP( SORT( Grpd, EXCEPT DOB_year,DOB_month,DOB_day), EXCEPT DOB_year,DOB_month,DOB_day));
  CntRed_DOB := (KeyCnt-COUNT(Rem_DOB))/KeyCnt;
EXPORT Shrinkage := DATASET([{'NAME','PRIM_RANGE',CntRed_PRIM_RANGE*100,CntRed_PRIM_RANGE*TSize},{'NAME','PRIM_NAME',CntRed_PRIM_NAME*100,CntRed_PRIM_NAME*TSize},{'NAME','SEC_RANGE',CntRed_SEC_RANGE*100,CntRed_SEC_RANGE*TSize},{'NAME','CITY',CntRed_CITY*100,CntRed_CITY*TSize},{'NAME','DOB',CntRed_DOB*100,CntRed_DOB*TSize}],SALT311.ShrinkLayout);
EXPORT MergeKeyFiles(STRING superFileIn, STRING outfileName, UNSIGNED4 minDate = 0, BOOLEAN replaceExisting = FALSE) := FUNCTION
  fieldListIndex := SALT311.MAC_FieldListCSVFromDataset(DataForKey,[],',');
  fieldListPayload := 'IsIncremental';
  RETURN Process_xIDL_Layouts().MAC_GenerateMergedKey(superFileIn, outfileName, minDate, replaceExisting, fieldListIndex, fieldListPayload, 'Key');
END;
EXPORT MAX_BLOCKLIMIT := IF (aBlockLimit=0,  Config.NAME_MAXBLOCKLIMIT, aBlockLimit);/*HACK24a*/
EXPORT CanSearch(Process_xIDL_Layouts().InputLayout le) := le.FNAME <> (TYPEOF(le.FNAME))'' AND Fields.InValid_FNAME((SALT311.StrType)le.FNAME)=0 AND le.LNAME <> (TYPEOF(le.LNAME))'' AND Fields.InValid_LNAME((SALT311.StrType)le.LNAME)=0 AND le.ST <> (TYPEOF(le.ST))'' AND Fields.InValid_ST((SALT311.StrType)le.ST)=0;
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'',TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',TYPEOF(h.DERIVED_GENDER) param_DERIVED_GENDER = (TYPEOF(h.DERIVED_GENDER))'',TYPEOF(h.SNAME) param_SNAME = (TYPEOF(h.SNAME))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',TYPEOF(h.SSN5) param_SSN5 = (TYPEOF(h.SSN5))'',TYPEOF(h.SSN5_len) param_SSN5_len = (TYPEOF(h.SSN5_len))'',TYPEOF(h.SSN4) param_SSN4 = (TYPEOF(h.SSN4))'',TYPEOF(h.SSN4_len) param_SSN4_len = (TYPEOF(h.SSN4_len))'') := 
    STEPPED( LIMIT( Key(
          KEYED((FNAME = param_FNAME))
      AND KEYED((LNAME = param_LNAME))
      AND KEYED((ST = param_ST))
      AND ((param_DERIVED_GENDER = (TYPEOF(DERIVED_GENDER))'' OR DERIVED_GENDER = (TYPEOF(DERIVED_GENDER))'') OR (DERIVED_GENDER = param_DERIVED_GENDER) OR ((DERIVED_GENDER[1..LENGTH(TRIM(param_DERIVED_GENDER))] = param_DERIVED_GENDER OR param_DERIVED_GENDER[1..LENGTH(TRIM(DERIVED_GENDER))] = DERIVED_GENDER) ))
      AND KEYED((param_SNAME = (TYPEOF(SNAME))'' OR SNAME = (TYPEOF(SNAME))'') OR (SNAME = param_SNAME))
      AND ((param_MNAME = (TYPEOF(MNAME))'' OR MNAME = (TYPEOF(MNAME))'') OR (MNAME = param_MNAME) OR ((MNAME[1..LENGTH(TRIM(param_MNAME))] = param_MNAME OR param_MNAME[1..LENGTH(TRIM(MNAME))] = MNAME)  OR (Config.WithinEditN(MNAME,MNAME_len,param_MNAME,param_MNAME_len,2, 0)) ))
      AND ((param_SSN5 = (TYPEOF(SSN5))'' OR SSN5 = (TYPEOF(SSN5))'') OR (SSN5 = param_SSN5) OR ((Config.WithinEditN(SSN5,SSN5_len,param_SSN5,param_SSN5_len,1, 0)) ))
      AND ((param_SSN4 = (TYPEOF(SSN4))'' OR SSN4 = (TYPEOF(SSN4))'') OR (SSN4 = param_SSN4) OR ((Config.WithinEditN(SSN4,SSN4_len,param_SSN4,param_SSN4_len,1, 0)) ))),MAX_BLOCKLIMIT/*HACK24b*/,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),DID);
 
 
EXPORT ScoredDIDFetch(TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'',TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',TYPEOF(h.DERIVED_GENDER) param_DERIVED_GENDER = (TYPEOF(h.DERIVED_GENDER))'',TYPEOF(h.SNAME) param_SNAME = (TYPEOF(h.SNAME))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',TYPEOF(h.SSN5) param_SSN5 = (TYPEOF(h.SSN5))'',TYPEOF(h.SSN5_len) param_SSN5_len = (TYPEOF(h.SSN5_len))'',TYPEOF(h.SSN4) param_SSN4 = (TYPEOF(h.SSN4))'',TYPEOF(h.SSN4_len) param_SSN4_len = (TYPEOF(h.SSN4_len))'',TYPEOF(h.PRIM_RANGE) param_PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',TYPEOF(h.PRIM_RANGE_len) param_PRIM_RANGE_len = (TYPEOF(h.PRIM_RANGE_len))'',TYPEOF(h.PRIM_NAME) param_PRIM_NAME = (TYPEOF(h.PRIM_NAME))'',TYPEOF(h.PRIM_NAME_len) param_PRIM_NAME_len = (TYPEOF(h.PRIM_NAME_len))'',TYPEOF(h.SEC_RANGE) param_SEC_RANGE = (TYPEOF(h.SEC_RANGE))'',TYPEOF(h.CITY) param_CITY = (TYPEOF(h.CITY))'',UNSIGNED4 param_DOB,BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetch(param_FNAME,param_FNAME_len,param_LNAME,param_LNAME_len,param_ST,param_DERIVED_GENDER,param_SNAME,param_MNAME,param_MNAME_len,param_SSN5,param_SSN5_len,param_SSN4,param_SSN4_len);
useDate := (UNSIGNED4)SALT311.fn_now('YYYYMMDD');
 
  Process_xIDL_Layouts().LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 1; // Set bitmap for keys used
    SELF.keys_poisoned := IF(le.DT_EFFECTIVE_LAST <> 0 AND le.IsIncremental, SELF.keys_used, 0);
    SELF.keys_failed := IF(le.DID = 0, 1 << 1, 0); // Set bitmap for key failed
    SELF.FNAME_match_code := match_methods(File_InsuranceHeader).match_FNAME(le.FNAME,param_FNAME,le.FNAME_len,param_FNAME_len,TRUE);
    SELF.FNAMEWeight := (50+MAP (
           SELF.FNAME_match_code = SALT311.MatchCode.ExactMatch =>le.FNAME_weight100,
           -0.737*le.FNAME_weight100))/100*0.80; 
    SELF.LNAME_match_code := match_methods(File_InsuranceHeader).match_LNAME(le.LNAME,param_LNAME,le.LNAME_len,param_LNAME_len,TRUE);
    SELF.LNAMEWeight := (50+MAP (
           SELF.LNAME_match_code = SALT311.MatchCode.ExactMatch =>le.LNAME_weight100,
           -0.617*le.LNAME_weight100))/100*0.80; 
    SELF.ST_match_code := match_methods(File_InsuranceHeader).match_ST(le.ST,param_ST,TRUE);
    SELF.STWeight := (50+MAP (
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
    SELF.PRIM_RANGE_match_code := MAP(
           le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR param_PRIM_RANGE = (TYPEOF(param_PRIM_RANGE))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_PRIM_RANGE(le.PRIM_RANGE,param_PRIM_RANGE,le.PRIM_RANGE_len,param_PRIM_RANGE_len,FALSE));
    SELF.PRIM_RANGEWeight := (50+MAP (
           SELF.PRIM_RANGE_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.PRIM_RANGE_match_code = SALT311.MatchCode.ExactMatch =>le.PRIM_RANGE_weight100,
           SELF.PRIM_RANGE_match_code = SALT311.MatchCode.EditDistanceMatch =>le.PRIM_RANGE_e1_weight100,
           SELF.PRIM_RANGE_match_code = SALT311.MatchCode.WildMatch =>le.PRIM_RANGE_weight100 / Config.WildPenalty,
           -0.537*le.PRIM_RANGE_weight100))/100; 
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
    SELF.Weight := IF(le.DID = 0, 100, MAX(0, SELF.FNAMEWeight) + MAX(0, SELF.LNAMEWeight) + MAX(0, SELF.STWeight) + MAX(0, SELF.DERIVED_GENDERWeight) + MAX(0, SELF.SNAMEWeight) + MAX(0, SELF.MNAMEWeight) + MAX(0, SELF.SSN5Weight) + MAX(0, SELF.SSN4Weight) + MAX(0, SELF.PRIM_RANGEWeight) + MAX(0, SELF.PRIM_NAMEWeight) + MAX(0, SELF.SEC_RANGEWeight) + MAX(0, SELF.CITYWeight) + MAX(0, SELF.DOBWeight));
    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));
  poisoned_results := TABLE(result0(keys_poisoned > 0), {DID, keys_poisoned}, DID, keys_poisoned);
  result_rollup0 := DEDUP(SORT(result0,DID,FNAME,LNAME,ST,DERIVED_GENDER,SNAME,MNAME,SSN5,SSN4,PRIM_RANGE,PRIM_NAME,SEC_RANGE,CITY,DOB_year,DOB_month,DOB_day,DT_EFFECTIVE_FIRST,-DT_EFFECTIVE_LAST),DID,FNAME,LNAME,ST,DERIVED_GENDER,SNAME,MNAME,SSN5,SSN4,PRIM_RANGE,PRIM_NAME,SEC_RANGE,CITY,DOB_year,DOB_month,DOB_day,DT_EFFECTIVE_FIRST);
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
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))'';
  TYPEOF(h.FNAME_len) FNAME_len := (TYPEOF(h.FNAME_len))'';
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))'';
  TYPEOF(h.LNAME_len) LNAME_len := (TYPEOF(h.LNAME_len))'';
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))'';
  TYPEOF(h.DERIVED_GENDER) DERIVED_GENDER := (TYPEOF(h.DERIVED_GENDER))'';
  TYPEOF(h.SNAME) SNAME := (TYPEOF(h.SNAME))'';
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))'';
  TYPEOF(h.MNAME_len) MNAME_len := (TYPEOF(h.MNAME_len))'';
  TYPEOF(h.SSN5) SSN5 := (TYPEOF(h.SSN5))'';
  TYPEOF(h.SSN5_len) SSN5_len := (TYPEOF(h.SSN5_len))'';
  TYPEOF(h.SSN4) SSN4 := (TYPEOF(h.SSN4))'';
  TYPEOF(h.SSN4_len) SSN4_len := (TYPEOF(h.SSN4_len))'';
  TYPEOF(h.PRIM_RANGE) PRIM_RANGE := (TYPEOF(h.PRIM_RANGE))'';
  TYPEOF(h.PRIM_RANGE_len) PRIM_RANGE_len := (TYPEOF(h.PRIM_RANGE_len))'';
  TYPEOF(h.PRIM_NAME) PRIM_NAME := (TYPEOF(h.PRIM_NAME))'';
  TYPEOF(h.PRIM_NAME_len) PRIM_NAME_len := (TYPEOF(h.PRIM_NAME_len))'';
  TYPEOF(h.SEC_RANGE) SEC_RANGE := (TYPEOF(h.SEC_RANGE))'';
  TYPEOF(h.CITY) CITY := (TYPEOF(h.CITY))'';
  UNSIGNED4 DOB := 0;
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex, BOOLEAN In_disableForce = FALSE) := FUNCTION
 
  Process_xIDL_Layouts().LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 1; // Set bitmap for keys used
    SELF.keys_poisoned := IF(le.DT_EFFECTIVE_LAST <> 0 AND le.IsIncremental, SELF.keys_used, 0);
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.FNAME_match_code := match_methods(File_InsuranceHeader).match_FNAME(le.FNAME,ri.FNAME,le.FNAME_len,ri.FNAME_len,TRUE);
    SELF.FNAMEWeight := (50+MAP (
           SELF.FNAME_match_code = SALT311.MatchCode.ExactMatch =>le.FNAME_weight100,
           -0.737*le.FNAME_weight100))/100*0.80; 
    SELF.LNAME_match_code := match_methods(File_InsuranceHeader).match_LNAME(le.LNAME,ri.LNAME,le.LNAME_len,ri.LNAME_len,TRUE);
    SELF.LNAMEWeight := (50+MAP (
           SELF.LNAME_match_code = SALT311.MatchCode.ExactMatch =>le.LNAME_weight100,
           -0.617*le.LNAME_weight100))/100*0.80; 
    SELF.ST_match_code := match_methods(File_InsuranceHeader).match_ST(le.ST,ri.ST,TRUE);
    SELF.STWeight := (50+MAP (
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
    SELF.PRIM_RANGE_match_code := MAP(
           le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR ri.PRIM_RANGE = (TYPEOF(ri.PRIM_RANGE))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_PRIM_RANGE(le.PRIM_RANGE,ri.PRIM_RANGE,le.PRIM_RANGE_len,ri.PRIM_RANGE_len,FALSE));
    SELF.PRIM_RANGEWeight := (50+MAP (
           SELF.PRIM_RANGE_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.PRIM_RANGE_match_code = SALT311.MatchCode.ExactMatch =>le.PRIM_RANGE_weight100,
           SELF.PRIM_RANGE_match_code = SALT311.MatchCode.EditDistanceMatch =>le.PRIM_RANGE_e1_weight100,
           SELF.PRIM_RANGE_match_code = SALT311.MatchCode.WildMatch =>le.PRIM_RANGE_weight100 / Config.WildPenalty,
           -0.537*le.PRIM_RANGE_weight100))/100; 
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
    SELF.Weight := IF(le.DID = 0, 100, MAX(0, SELF.FNAMEWeight) + MAX(0, SELF.LNAMEWeight) + MAX(0, SELF.STWeight) + MAX(0, SELF.DERIVED_GENDERWeight) + MAX(0, SELF.SNAMEWeight) + MAX(0, SELF.MNAMEWeight) + MAX(0, SELF.SSN5Weight) + MAX(0, SELF.SSN4Weight) + MAX(0, SELF.PRIM_RANGEWeight) + MAX(0, SELF.PRIM_NAMEWeight) + MAX(0, SELF.SEC_RANGEWeight) + MAX(0, SELF.CITYWeight) + MAX(0, SELF.DOBWeight));
    SELF := le;
  END;
  Recs0 := Recs(FNAME <> (TYPEOF(FNAME))'',LNAME <> (TYPEOF(LNAME))'',ST <> (TYPEOF(ST))'');
  SALT311.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference,Config.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,((RIGHT.FNAME = LEFT.FNAME))
     AND ((RIGHT.LNAME = LEFT.LNAME))
     AND ((RIGHT.ST = LEFT.ST))
     AND ((LEFT.DERIVED_GENDER = (TYPEOF(RIGHT.DERIVED_GENDER))'' OR RIGHT.DERIVED_GENDER = (TYPEOF(RIGHT.DERIVED_GENDER))'') OR (RIGHT.DERIVED_GENDER = LEFT.DERIVED_GENDER) OR ((RIGHT.DERIVED_GENDER[1..LENGTH(TRIM(LEFT.DERIVED_GENDER))] = LEFT.DERIVED_GENDER OR LEFT.DERIVED_GENDER[1..LENGTH(TRIM(RIGHT.DERIVED_GENDER))] = RIGHT.DERIVED_GENDER) ))
     AND ((LEFT.SNAME = (TYPEOF(RIGHT.SNAME))'' OR RIGHT.SNAME = (TYPEOF(RIGHT.SNAME))'') OR (RIGHT.SNAME = LEFT.SNAME))
     AND ((LEFT.MNAME = (TYPEOF(RIGHT.MNAME))'' OR RIGHT.MNAME = (TYPEOF(RIGHT.MNAME))'') OR (RIGHT.MNAME = LEFT.MNAME) OR ((RIGHT.MNAME[1..LENGTH(TRIM(LEFT.MNAME))] = LEFT.MNAME OR LEFT.MNAME[1..LENGTH(TRIM(RIGHT.MNAME))] = RIGHT.MNAME)  OR (Config.WithinEditN(RIGHT.MNAME,RIGHT.MNAME_len,LEFT.MNAME,LEFT.MNAME_len,2, 0)) ))
     AND ((LEFT.SSN5 = (TYPEOF(RIGHT.SSN5))'' OR RIGHT.SSN5 = (TYPEOF(RIGHT.SSN5))'') OR (RIGHT.SSN5 = LEFT.SSN5) OR ((Config.WithinEditN(RIGHT.SSN5,RIGHT.SSN5_len,LEFT.SSN5,LEFT.SSN5_len,1, 0)) ))
     AND ((LEFT.SSN4 = (TYPEOF(RIGHT.SSN4))'' OR RIGHT.SSN4 = (TYPEOF(RIGHT.SSN4))'') OR (RIGHT.SSN4 = LEFT.SSN4) OR ((Config.WithinEditN(RIGHT.SSN4,RIGHT.SSN4_len,LEFT.SSN4,LEFT.SSN4_len,1, 0)) )),Score_Batch(RIGHT,LEFT),
    ATMOST(((RIGHT.FNAME = LEFT.FNAME))
     AND ((RIGHT.LNAME = LEFT.LNAME))
     AND ((RIGHT.ST = LEFT.ST)),Config.NAME_MAXBLOCKSIZE)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),((RIGHT.FNAME = LEFT.FNAME))
     AND ((RIGHT.LNAME = LEFT.LNAME))
     AND ((RIGHT.ST = LEFT.ST))
     AND ((LEFT.DERIVED_GENDER = (TYPEOF(RIGHT.DERIVED_GENDER))'' OR RIGHT.DERIVED_GENDER = (TYPEOF(RIGHT.DERIVED_GENDER))'') OR (RIGHT.DERIVED_GENDER = LEFT.DERIVED_GENDER) OR ((RIGHT.DERIVED_GENDER[1..LENGTH(TRIM(LEFT.DERIVED_GENDER))] = LEFT.DERIVED_GENDER OR LEFT.DERIVED_GENDER[1..LENGTH(TRIM(RIGHT.DERIVED_GENDER))] = RIGHT.DERIVED_GENDER) ))
     AND ((LEFT.SNAME = (TYPEOF(RIGHT.SNAME))'' OR RIGHT.SNAME = (TYPEOF(RIGHT.SNAME))'') OR (RIGHT.SNAME = LEFT.SNAME))
     AND ((LEFT.MNAME = (TYPEOF(RIGHT.MNAME))'' OR RIGHT.MNAME = (TYPEOF(RIGHT.MNAME))'') OR (RIGHT.MNAME = LEFT.MNAME) OR ((RIGHT.MNAME[1..LENGTH(TRIM(LEFT.MNAME))] = LEFT.MNAME OR LEFT.MNAME[1..LENGTH(TRIM(RIGHT.MNAME))] = RIGHT.MNAME)  OR (Config.WithinEditN(RIGHT.MNAME,RIGHT.MNAME_len,LEFT.MNAME,LEFT.MNAME_len,2, 0)) ))
     AND ((LEFT.SSN5 = (TYPEOF(RIGHT.SSN5))'' OR RIGHT.SSN5 = (TYPEOF(RIGHT.SSN5))'') OR (RIGHT.SSN5 = LEFT.SSN5) OR ((Config.WithinEditN(RIGHT.SSN5,RIGHT.SSN5_len,LEFT.SSN5,LEFT.SSN5_len,1, 0)) ))
     AND ((LEFT.SSN4 = (TYPEOF(RIGHT.SSN4))'' OR RIGHT.SSN4 = (TYPEOF(RIGHT.SSN4))'') OR (RIGHT.SSN4 = LEFT.SSN4) OR ((Config.WithinEditN(RIGHT.SSN4,RIGHT.SSN4_len,LEFT.SSN4,LEFT.SSN4_len,1, 0)) )),Score_Batch(RIGHT,LEFT),
    ATMOST(((RIGHT.FNAME = LEFT.FNAME))
     AND ((RIGHT.LNAME = LEFT.LNAME))
     AND ((RIGHT.ST = LEFT.ST)),Config.NAME_MAXBLOCKSIZE),HASH,UNORDERED); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  useDate := (UNSIGNED4)SALT311.fn_now('YYYYMMDD');
  J2_dist := DISTRIBUTE(J2, HASH(Reference));
  poisoned_results := TABLE(SORT(J2_dist, Reference, DID, LOCAL), {Reference, DID, keys_poisoned}, Reference, DID, keys_poisoned, LOCAL);
  result_rollup0 := DEDUP(SORT(J2_dist,Reference,DID,FNAME,LNAME,ST,DERIVED_GENDER,SNAME,MNAME,SSN5,SSN4,PRIM_RANGE,PRIM_NAME,SEC_RANGE,CITY,DOB_year,DOB_month,DOB_day,DT_EFFECTIVE_FIRST,-DT_EFFECTIVE_LAST, LOCAL),Reference,DID,FNAME,LNAME,ST,DERIVED_GENDER,SNAME,MNAME,SSN5,SSN4,PRIM_RANGE,PRIM_NAME,SEC_RANGE,CITY,DOB_year,DOB_month,DOB_day,DT_EFFECTIVE_FIRST, LOCAL);
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
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_FNAME='',Input_LNAME='',Input_ST='',Input_DERIVED_GENDER='',Input_SNAME='',Input_MNAME='',Input_SSN5='',Input_SSN4='',Input_PRIM_RANGE='',Input_PRIM_NAME='',Input_SEC_RANGE='',Input_CITY='',Input_DOB='',output_file,AsIndex='true', In_disableForce = 'false') := MACRO
  IMPORT SALT311,InsuranceHeader_xLink;
  #IF(#TEXT(Input_FNAME)<>'' AND #TEXT(Input_LNAME)<>'' AND #TEXT(Input_ST)<>'')
    #UNIQUENAME(trans)
    InsuranceHeader_xLink.Key_InsuranceHeader_NAME().InputLayout_Batch %trans%(InFile le) := TRANSFORM
      SELF.Reference := le.Input_Ref;
      SELF.FNAME := (TYPEOF(SELF.FNAME))le.Input_FNAME;
      SELF.FNAME_len := LENGTH(TRIM((TYPEOF(SELF.FNAME))le.Input_FNAME));
      SELF.LNAME := (TYPEOF(SELF.LNAME))le.Input_LNAME;
      SELF.LNAME_len := LENGTH(TRIM((TYPEOF(SELF.LNAME))le.Input_LNAME));
      SELF.ST := (TYPEOF(SELF.ST))le.Input_ST;
      #IF ( #TEXT(Input_DERIVED_GENDER) <> '' )
        SELF.DERIVED_GENDER := (TYPEOF(SELF.DERIVED_GENDER))le.Input_DERIVED_GENDER;
      #END
      #IF ( #TEXT(Input_SNAME) <> '' )
        SELF.SNAME := (TYPEOF(SELF.SNAME))le.Input_SNAME;
      #END
      #IF ( #TEXT(Input_MNAME) <> '' )
        SELF.MNAME := (TYPEOF(SELF.MNAME))le.Input_MNAME;
        SELF.MNAME_len := LENGTH(TRIM((TYPEOF(SELF.MNAME))le.Input_MNAME));
      #END
      #IF ( #TEXT(Input_SSN5) <> '' )
        SELF.SSN5 := (TYPEOF(SELF.SSN5))le.Input_SSN5;
        SELF.SSN5_len := LENGTH(TRIM((TYPEOF(SELF.SSN5))le.Input_SSN5));
      #END
      #IF ( #TEXT(Input_SSN4) <> '' )
        SELF.SSN4 := (TYPEOF(SELF.SSN4))le.Input_SSN4;
        SELF.SSN4_len := LENGTH(TRIM((TYPEOF(SELF.SSN4))le.Input_SSN4));
      #END
      #IF ( #TEXT(Input_PRIM_RANGE) <> '' )
        SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))le.Input_PRIM_RANGE;
        SELF.PRIM_RANGE_len := LENGTH(TRIM((TYPEOF(SELF.PRIM_RANGE))le.Input_PRIM_RANGE));
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
      #IF ( #TEXT(Input_DOB) <> '' )
          SELF.DOB := (UNSIGNED4)le.Input_DOB;
      #END
    END;
    #UNIQUENAME(p)
    %p% := PROJECT(Infile,%trans%(left));
    output_file := InsuranceHeader_xLink.Key_InsuranceHeader_NAME().ScoredFetch_Batch(%p%,AsIndex, In_disableForce);
  #ELSE
    output_file := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch); // Compulsory fields missing
  #END
ENDMACRO;
END;
