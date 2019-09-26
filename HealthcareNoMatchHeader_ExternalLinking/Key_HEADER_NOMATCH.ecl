IMPORT SALT311,std,HealthcareNoMatchHeader_InternalLinking,HealthcareNoMatchHeader_Ingest;
EXPORT Key_HEADER_NOMATCH(
    STRING	pSrc        = ''
    , STRING  pVersion  = (STRING)STD.Date.Today()
    , DATASET(HealthcareNoMatchHeader_InternalLinking.Layout_Header) pInfile = HealthcareNoMatchHeader_Ingest.Files(pSrc).AllRecords
  ) := MODULE
 
//DOB:FNAME:?:LNAME:CITY_NAME:+:ZIP:ST:GENDER:PRIM_NAME:PRIM_RANGE:MNAME:SSN:LEXID:SEC_RANGE:SUFFIX
EXPORT KeyName := HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).ExternalKeys.Refs_NoMatch.New;
SHARED h := CandidatesForKey(pSrc,pVersion,pInfile);//The input file - distributed by nomatch_id
 
SHARED s := HealthcareNoMatchHeader_InternalLinking.Specificities(pSrc,pVersion,pInfile).Specificities[1];
SHARED s_index := Keys(pSrc,pVersion,pInfile).Specificities_Key[1]; // Index access for MEOW queries
layout := RECORD // project out required fields
// Compulsory fields
  h.DOB_year;
  h.DOB_month;
  h.DOB_day;
  h.FNAME;
// Optional fields
  h.CITY_NAME;
  h.nomatch_id; // The ID field
  h.LNAME;
// Extra credit fields
  h.ZIP;
  h.ST;
  h.GENDER;
  h.PRIM_NAME;
  h.PRIM_RANGE;
  h.MNAME;
  h.SSN;
  h.LEXID;
  h.SEC_RANGE;
  h.SUFFIX;
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
  h.FNAME_e1_Weight100;
  h.FNAME_e2_Weight100;
  h.FNAME_PreferredName_Weight100;
  h.FNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.LNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_MAINNAME_fuzzy_weight100 ; // Contains 100x the specificity
  h.LNAME_initial_char_weight100 ; // Contains 100x the specificity
  h.LNAME_e1_Weight100;
  h.LNAME_e2_Weight100;
  h.LNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.CITY_NAME_weight100 ; // Contains 100x the specificity
  h.ZIP_weight100 ; // Contains 100x the specificity
  h.ST_weight100 ; // Contains 100x the specificity
  h.GENDER_weight100 ; // Contains 100x the specificity
  h.PRIM_NAME_weight100 ; // Contains 100x the specificity
  h.PRIM_RANGE_weight100 ; // Contains 100x the specificity
  h.MNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_MAINNAME_fuzzy_weight100 ; // Contains 100x the specificity
  h.MNAME_initial_char_weight100 ; // Contains 100x the specificity
  h.MNAME_e1_Weight100;
  h.MNAME_e2_Weight100;
  h.MNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.SSN_weight100 ; // Contains 100x the specificity
  INTEGER2 SSN_e1_Weight100 := SALT311.Min0(h.SSN_weight100 + 100*log(h.SSN_cnt/h.SSN_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.LEXID_weight100 ; // Contains 100x the specificity
  h.SEC_RANGE_weight100 ; // Contains 100x the specificity
  h.SUFFIX_weight100 ; // Contains 100x the specificity
END;
 
DataForKey0 := DEDUP(SORT(TABLE(h((DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) OR DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) OR DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)),(FNAME NOT IN SET(s.nulls_FNAME,FNAME) AND FNAME <> (TYPEOF(FNAME))'')),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
SHARED DataForKey := DataForKey0;
 
EXPORT Key := INDEX(DataForKey,{DataForKey},{},KeyName);
 
EXPORT BuildAll := BUILDINDEX(Key, OVERWRITE);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,nomatch_id,DOB_year,DOB_month,DOB_day,FNAME,LNAME,CITY_NAME,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_ZIP := GROUP( DEDUP( SORT( Grpd, EXCEPT ZIP), EXCEPT ZIP));
  CntRed_ZIP := (KeyCnt-COUNT(Rem_ZIP))/KeyCnt;
  Rem_ST := GROUP( DEDUP( SORT( Grpd, EXCEPT ST), EXCEPT ST));
  CntRed_ST := (KeyCnt-COUNT(Rem_ST))/KeyCnt;
  Rem_GENDER := GROUP( DEDUP( SORT( Grpd, EXCEPT GENDER), EXCEPT GENDER));
  CntRed_GENDER := (KeyCnt-COUNT(Rem_GENDER))/KeyCnt;
  Rem_PRIM_NAME := GROUP( DEDUP( SORT( Grpd, EXCEPT PRIM_NAME), EXCEPT PRIM_NAME));
  CntRed_PRIM_NAME := (KeyCnt-COUNT(Rem_PRIM_NAME))/KeyCnt;
  Rem_PRIM_RANGE := GROUP( DEDUP( SORT( Grpd, EXCEPT PRIM_RANGE), EXCEPT PRIM_RANGE));
  CntRed_PRIM_RANGE := (KeyCnt-COUNT(Rem_PRIM_RANGE))/KeyCnt;
  Rem_MNAME := GROUP( DEDUP( SORT( Grpd, EXCEPT MNAME), EXCEPT MNAME));
  CntRed_MNAME := (KeyCnt-COUNT(Rem_MNAME))/KeyCnt;
  Rem_SSN := GROUP( DEDUP( SORT( Grpd, EXCEPT SSN), EXCEPT SSN));
  CntRed_SSN := (KeyCnt-COUNT(Rem_SSN))/KeyCnt;
  Rem_LEXID := GROUP( DEDUP( SORT( Grpd, EXCEPT LEXID), EXCEPT LEXID));
  CntRed_LEXID := (KeyCnt-COUNT(Rem_LEXID))/KeyCnt;
  Rem_SEC_RANGE := GROUP( DEDUP( SORT( Grpd, EXCEPT SEC_RANGE), EXCEPT SEC_RANGE));
  CntRed_SEC_RANGE := (KeyCnt-COUNT(Rem_SEC_RANGE))/KeyCnt;
  Rem_SUFFIX := GROUP( DEDUP( SORT( Grpd, EXCEPT SUFFIX), EXCEPT SUFFIX));
  CntRed_SUFFIX := (KeyCnt-COUNT(Rem_SUFFIX))/KeyCnt;
EXPORT Shrinkage := DATASET([{'NOMATCH','ZIP',CntRed_ZIP*100,CntRed_ZIP*TSize},{'NOMATCH','ST',CntRed_ST*100,CntRed_ST*TSize},{'NOMATCH','GENDER',CntRed_GENDER*100,CntRed_GENDER*TSize},{'NOMATCH','PRIM_NAME',CntRed_PRIM_NAME*100,CntRed_PRIM_NAME*TSize},{'NOMATCH','PRIM_RANGE',CntRed_PRIM_RANGE*100,CntRed_PRIM_RANGE*TSize},{'NOMATCH','MNAME',CntRed_MNAME*100,CntRed_MNAME*TSize},{'NOMATCH','SSN',CntRed_SSN*100,CntRed_SSN*TSize},{'NOMATCH','LEXID',CntRed_LEXID*100,CntRed_LEXID*TSize},{'NOMATCH','SEC_RANGE',CntRed_SEC_RANGE*100,CntRed_SEC_RANGE*TSize},{'NOMATCH','SUFFIX',CntRed_SUFFIX*100,CntRed_SUFFIX*TSize}],SALT311.ShrinkLayout);
EXPORT CanSearch(Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).InputLayout le) := le.DOB <> (TYPEOF(le.DOB))'' AND Fields.InValid_DOB((SALT311.StrType)le.DOB)=0 AND le.FNAME <> (TYPEOF(le.FNAME))'' AND Fields.InValid_FNAME((SALT311.StrType)le.FNAME)=0;
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(UNSIGNED4 param_DOB,TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'',TYPEOF(h.CITY_NAME) param_CITY_NAME = (TYPEOF(h.CITY_NAME))'') := 
    STEPPED( LIMIT( Key(
           param_DOB <> 0 AND KEYED(DOB_year = param_DOB DIV 10000 AND DOB_month = param_DOB DIV 100 % 100 AND DOB_day = param_DOB % 100)
      AND KEYED((FNAME = param_FNAME))
      AND ((param_LNAME = (TYPEOF(LNAME))'' OR LNAME = (TYPEOF(LNAME))'') OR (LNAME = param_LNAME) OR ((LNAME[1..LENGTH(TRIM(param_LNAME))] = param_LNAME OR param_LNAME[1..LENGTH(TRIM(LNAME))] = LNAME)  OR (Config.WithinEditN(LNAME,LNAME_len,param_LNAME,param_LNAME_len,2, 6))  OR (SALT311.HyphenMatch(LNAME,param_LNAME,1)<=2)))
      AND KEYED((param_CITY_NAME = (TYPEOF(CITY_NAME))'' OR CITY_NAME = (TYPEOF(CITY_NAME))'') OR (CITY_NAME = param_CITY_NAME))),Config.NOMATCH_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),nomatch_id);
 
 
EXPORT Scorednomatch_idFetch(UNSIGNED4 param_DOB,TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'',TYPEOF(h.CITY_NAME) param_CITY_NAME = (TYPEOF(h.CITY_NAME))'',TYPEOF(h.ZIP) param_ZIP = (TYPEOF(h.ZIP))'',TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',TYPEOF(h.GENDER) param_GENDER = (TYPEOF(h.GENDER))'',TYPEOF(h.PRIM_NAME) param_PRIM_NAME = (TYPEOF(h.PRIM_NAME))'',TYPEOF(h.PRIM_RANGE) param_PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',TYPEOF(h.SSN) param_SSN = (TYPEOF(h.SSN))'',TYPEOF(h.SSN_len) param_SSN_len = (TYPEOF(h.SSN_len))'',TYPEOF(h.LEXID) param_LEXID = (TYPEOF(h.LEXID))'',TYPEOF(h.SEC_RANGE) param_SEC_RANGE = (TYPEOF(h.SEC_RANGE))'',TYPEOF(h.SUFFIX) param_SUFFIX = (TYPEOF(h.SUFFIX))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetch(param_DOB,param_FNAME,param_FNAME_len,param_LNAME,param_LNAME_len,param_CITY_NAME);
 
  Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 1; // Set bitmap for keys used
    SELF.keys_failed := IF(le.nomatch_id = 0, 1 << 1, 0); // Set bitmap for key failed
    SELF.DOB_year_match_code := MAP(
      le.DOB_year = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(pSrc,pVersion,pInfile).match_DOB_year(le.DOB_year,((UNSIGNED)param_DOB) DIV 10000,TRUE));
    SELF.DOBWeight_year := (50+MAP ( SELF.DOB_year_match_code = SALT311.MatchCode.OneSideNull => 0,
       SELF.DOB_year_match_code = SALT311.MatchCode.ExactMatch => le.DOB_year_weight100,
       -1.000*le.DOB_year_weight100))/100;
    SELF.DOB_month_match_code := MAP(
      le.DOB_month = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(pSrc,pVersion,pInfile).match_DOB_month(le.DOB_month,((UNSIGNED)param_DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)param_DOB) % 100,TRUE));
    SELF.DOBWeight_month := (50+MAP ( SELF.DOB_month_match_code = SALT311.MatchCode.OneSideNull => 0,
      SELF.DOB_month_match_code = SALT311.MatchCode.ExactMatch => le.DOB_month_weight100,
       -1.000*le.DOB_month_weight100))/100;
    SELF.DOB_day_match_code := MAP(
      le.DOB_day = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(pSrc,pVersion,pInfile).match_DOB_day(le.DOB_month,((UNSIGNED)param_DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)param_DOB) % 100,TRUE));
    SELF.DOBWeight_day := (50+MAP ( SELF.DOB_day_match_code = SALT311.MatchCode.OneSideNull => 0,
      SELF.DOB_day_match_code = SALT311.MatchCode.ExactMatch => le.DOB_day_weight100,
       -1.000*le.DOB_day_weight100))/100;
		DOB_AggWeight := SELF.DOBWeight_day + SELF.DOBWeight_month + SELF.DOBWeight_year;
    SELF.DOB_match_code := MAP(
      le.DOB_year+le.DOB_month+le.DOB_day = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(pSrc,pVersion,pInfile).match_DOB_el(le.DOB_year, le.DOB_month, le.DOB_day, param_DOB, DOB_AggWeight ,TRUE));
    SELF.DOBWeight :=  MAP(
           SELF.DOB_match_code = SALT311.MatchCode.OneSideNull => 0,
           DOB_AggWeight); 
    SELF.FNAME_match_code := match_methods(pSrc,pVersion,pInfile).match_FNAME(le.FNAME,param_FNAME,le.FNAME_len,param_FNAME_len,TRUE);
    SELF.FNAMEWeight := (50+MAP (
           SELF.FNAME_match_code = SALT311.MatchCode.ExactMatch =>le.FNAME_weight100,
           -1.000*le.FNAME_weight100))/100; 
    SELF.LNAME_match_code := MAP(
           le.LNAME = (TYPEOF(le.LNAME))'' OR param_LNAME = (TYPEOF(param_LNAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(pSrc,pVersion,pInfile).match_LNAME(le.LNAME,param_LNAME,le.LNAME_len,param_LNAME_len,FALSE));
    SELF.LNAMEWeight := (50+MAP (
           SELF.LNAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.LNAME_match_code = SALT311.MatchCode.ExactMatch =>le.LNAME_weight100,
           SELF.LNAME_match_code = SALT311.MatchCode.HyphenMatch =>le.LNAME_weight100*MIN(1,LENGTH(TRIM(param_LNAME))/LENGTH(TRIM(le.LNAME))),
           SELF.LNAME_match_code = SALT311.MatchCode.InitialLMatch =>le.LNAME_weight100,
           SELF.LNAME_match_code = SALT311.MatchCode.InitialRMatch=> SALT311.Fn_Interpolate_Initial(le.LNAME,param_LNAME,le.LNAME_weight100,le.LNAME_initial_char_weight100),
           SELF.LNAME_match_code = SALT311.MatchCode.EditDistanceMatch =>MAP((6 > le.LNAME_len) AND (6 > param_LNAME_len) => le.LNAME_e1_weight100, le.LNAME_e2_weight100),
           -1.000*le.LNAME_weight100))/100; 
    SELF.CITY_NAME_match_code := MAP(
           le.CITY_NAME = (TYPEOF(le.CITY_NAME))'' OR param_CITY_NAME = (TYPEOF(param_CITY_NAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(pSrc,pVersion,pInfile).match_CITY_NAME(le.CITY_NAME,param_CITY_NAME,FALSE));
    SELF.CITY_NAMEWeight := (50+MAP (
           SELF.CITY_NAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.CITY_NAME_match_code = SALT311.MatchCode.ExactMatch =>le.CITY_NAME_weight100,
           -1.000*le.CITY_NAME_weight100))/100; 
    SELF.ZIP_match_code := MAP(
           le.ZIP = (TYPEOF(le.ZIP))'' OR param_ZIP = (TYPEOF(param_ZIP))'' => SALT311.MatchCode.OneSideNull,
           match_methods(pSrc,pVersion,pInfile).match_ZIP(le.ZIP,param_ZIP,FALSE));
    SELF.ZIPWeight := (50+MAP (
           SELF.ZIP_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.ZIP_match_code = SALT311.MatchCode.ExactMatch =>le.ZIP_weight100,
           -1.000*le.ZIP_weight100))/100; 
    SELF.ST_match_code := MAP(
           le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' => SALT311.MatchCode.OneSideNull,
           match_methods(pSrc,pVersion,pInfile).match_ST(le.ST,param_ST,FALSE));
    SELF.STWeight := (50+MAP (
           SELF.ST_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.ST_match_code = SALT311.MatchCode.ExactMatch =>le.ST_weight100,
           -1.000*le.ST_weight100))/100; 
    SELF.GENDER_match_code := MAP(
           le.GENDER = (TYPEOF(le.GENDER))'' OR param_GENDER = (TYPEOF(param_GENDER))'' => SALT311.MatchCode.OneSideNull,
           match_methods(pSrc,pVersion,pInfile).match_GENDER(le.GENDER,param_GENDER,FALSE));
    SELF.GENDERWeight := (50+MAP (
           SELF.GENDER_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.GENDER_match_code = SALT311.MatchCode.ExactMatch =>le.GENDER_weight100,
           -1.000*le.GENDER_weight100))/100; 
    SELF.PRIM_NAME_match_code := MAP(
           le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR param_PRIM_NAME = (TYPEOF(param_PRIM_NAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(pSrc,pVersion,pInfile).match_PRIM_NAME(le.PRIM_NAME,param_PRIM_NAME,FALSE));
    SELF.PRIM_NAMEWeight := (50+MAP (
           SELF.PRIM_NAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.PRIM_NAME_match_code = SALT311.MatchCode.ExactMatch =>le.PRIM_NAME_weight100,
           -1.000*le.PRIM_NAME_weight100))/100; 
    SELF.PRIM_RANGE_match_code := MAP(
           le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR param_PRIM_RANGE = (TYPEOF(param_PRIM_RANGE))'' => SALT311.MatchCode.OneSideNull,
           match_methods(pSrc,pVersion,pInfile).match_PRIM_RANGE(le.PRIM_RANGE,param_PRIM_RANGE,FALSE));
    SELF.PRIM_RANGEWeight := (50+MAP (
           SELF.PRIM_RANGE_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.PRIM_RANGE_match_code = SALT311.MatchCode.ExactMatch =>le.PRIM_RANGE_weight100,
           -1.000*le.PRIM_RANGE_weight100))/100; 
    SELF.MNAME_match_code := MAP(
           le.MNAME = (TYPEOF(le.MNAME))'' OR param_MNAME = (TYPEOF(param_MNAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(pSrc,pVersion,pInfile).match_MNAME(le.MNAME,param_MNAME,le.MNAME_len,param_MNAME_len,FALSE));
    SELF.MNAMEWeight := (50+MAP (
           SELF.MNAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.MNAME_match_code = SALT311.MatchCode.ExactMatch =>le.MNAME_weight100,
           SELF.MNAME_match_code = SALT311.MatchCode.InitialLMatch =>le.MNAME_weight100,
           SELF.MNAME_match_code = SALT311.MatchCode.InitialRMatch=> SALT311.Fn_Interpolate_Initial(le.MNAME,param_MNAME,le.MNAME_weight100,le.MNAME_initial_char_weight100),
           SELF.MNAME_match_code = SALT311.MatchCode.EditDistanceMatch =>MAP((6 > le.MNAME_len) AND (6 > param_MNAME_len) => le.MNAME_e1_weight100, le.MNAME_e2_weight100),
           -1.000*le.MNAME_weight100))/100; 
    SELF.SSN_match_code := MAP(
           le.SSN = (TYPEOF(le.SSN))'' OR param_SSN = (TYPEOF(param_SSN))'' => SALT311.MatchCode.OneSideNull,
           match_methods(pSrc,pVersion,pInfile).match_SSN(le.SSN,param_SSN,le.SSN_len,param_SSN_len,FALSE));
    SELF.SSNWeight := (50+MAP (
           SELF.SSN_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.SSN_match_code = SALT311.MatchCode.ExactMatch =>le.SSN_weight100,
           SELF.SSN_match_code = SALT311.MatchCode.EditDistanceMatch =>le.SSN_e1_weight100,
           -1.000*le.SSN_weight100))/100; 
    SELF.LEXID_match_code := MAP(
           le.LEXID = (TYPEOF(le.LEXID))'' OR param_LEXID = (TYPEOF(param_LEXID))'' => SALT311.MatchCode.OneSideNull,
           match_methods(pSrc,pVersion,pInfile).match_LEXID(le.LEXID,param_LEXID,FALSE));
    SELF.LEXIDWeight := (50+MAP (
           SELF.LEXID_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.LEXID_match_code = SALT311.MatchCode.ExactMatch =>le.LEXID_weight100,
           -1.000*le.LEXID_weight100))/100; 
    SELF.SEC_RANGE_match_code := MAP(
           le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR param_SEC_RANGE = (TYPEOF(param_SEC_RANGE))'' => SALT311.MatchCode.OneSideNull,
           match_methods(pSrc,pVersion,pInfile).match_SEC_RANGE(le.SEC_RANGE,param_SEC_RANGE,FALSE));
    SELF.SEC_RANGEWeight := (50+MAP (
           SELF.SEC_RANGE_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.SEC_RANGE_match_code = SALT311.MatchCode.ExactMatch =>le.SEC_RANGE_weight100,
           SELF.SEC_RANGE_match_code = SALT311.MatchCode.HyphenMatch =>le.SEC_RANGE_weight100*MIN(1,LENGTH(TRIM(param_SEC_RANGE))/LENGTH(TRIM(le.SEC_RANGE))),
           -1.000*le.SEC_RANGE_weight100))/100; 
    SELF.SUFFIX_match_code := MAP(
           le.SUFFIX = (TYPEOF(le.SUFFIX))'' OR param_SUFFIX = (TYPEOF(param_SUFFIX))'' => SALT311.MatchCode.OneSideNull,
           match_methods(pSrc,pVersion,pInfile).match_SUFFIX(le.SUFFIX,param_SUFFIX,FALSE));
    SELF.SUFFIXWeight := (50+MAP (
           SELF.SUFFIX_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.SUFFIX_match_code = SALT311.MatchCode.ExactMatch =>le.SUFFIX_weight100,
           -1.000*le.SUFFIX_weight100))/100; 
    SELF.Weight := IF(le.nomatch_id = 0, 100, MAX(0, SELF.DOBWeight) + MAX(0, SELF.FNAMEWeight) + MAX(0, SELF.LNAMEWeight) + MAX(0, SELF.CITY_NAMEWeight) + MAX(0, SELF.ZIPWeight) + MAX(0, SELF.STWeight) + MAX(0, SELF.GENDERWeight) + MAX(0, SELF.PRIM_NAMEWeight) + MAX(0, SELF.PRIM_RANGEWeight) + MAX(0, SELF.MNAMEWeight) + MAX(0, SELF.SSNWeight) + MAX(0, SELF.LEXIDWeight) + MAX(0, SELF.SEC_RANGEWeight) + MAX(0, SELF.SUFFIXWeight));
    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));
  result1 := PROJECT(result0, Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).update_forcefailed(LEFT,param_disableForce));
  result2 := ROLLUP(result1,LEFT.nomatch_id = RIGHT.nomatch_id,Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).combine_scores(LEFT,RIGHT,param_disableForce));
  RETURN result2;
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
  TYPEOF(h.CITY_NAME) CITY_NAME := (TYPEOF(h.CITY_NAME))'';
  TYPEOF(h.ZIP) ZIP := (TYPEOF(h.ZIP))'';
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))'';
  TYPEOF(h.GENDER) GENDER := (TYPEOF(h.GENDER))'';
  TYPEOF(h.PRIM_NAME) PRIM_NAME := (TYPEOF(h.PRIM_NAME))'';
  TYPEOF(h.PRIM_RANGE) PRIM_RANGE := (TYPEOF(h.PRIM_RANGE))'';
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))'';
  TYPEOF(h.MNAME_len) MNAME_len := (TYPEOF(h.MNAME_len))'';
  TYPEOF(h.SSN) SSN := (TYPEOF(h.SSN))'';
  TYPEOF(h.SSN_len) SSN_len := (TYPEOF(h.SSN_len))'';
  TYPEOF(h.LEXID) LEXID := (TYPEOF(h.LEXID))'';
  TYPEOF(h.SEC_RANGE) SEC_RANGE := (TYPEOF(h.SEC_RANGE))'';
  TYPEOF(h.SUFFIX) SUFFIX := (TYPEOF(h.SUFFIX))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex, BOOLEAN In_disableForce = FALSE) := FUNCTION
 
  Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 1; // Set bitmap for keys used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.DOB_year_match_code := MAP(
      le.DOB_year = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(pSrc,pVersion,pInfile).match_DOB_year(le.DOB_year,((UNSIGNED)ri.DOB) DIV 10000,TRUE));
    SELF.DOBWeight_year := (50+MAP ( SELF.DOB_year_match_code = SALT311.MatchCode.OneSideNull => 0,
       SELF.DOB_year_match_code = SALT311.MatchCode.ExactMatch => le.DOB_year_weight100,
       -1.000*le.DOB_year_weight100))/100;
    SELF.DOB_month_match_code := MAP(
      le.DOB_month = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(pSrc,pVersion,pInfile).match_DOB_month(le.DOB_month,((UNSIGNED)ri.DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)ri.DOB) % 100,TRUE));
    SELF.DOBWeight_month := (50+MAP ( SELF.DOB_month_match_code = SALT311.MatchCode.OneSideNull => 0,
      SELF.DOB_month_match_code = SALT311.MatchCode.ExactMatch => le.DOB_month_weight100,
       -1.000*le.DOB_month_weight100))/100;
    SELF.DOB_day_match_code := MAP(
      le.DOB_day = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(pSrc,pVersion,pInfile).match_DOB_day(le.DOB_month,((UNSIGNED)ri.DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)ri.DOB) % 100,TRUE));
    SELF.DOBWeight_day := (50+MAP ( SELF.DOB_day_match_code = SALT311.MatchCode.OneSideNull => 0,
      SELF.DOB_day_match_code = SALT311.MatchCode.ExactMatch => le.DOB_day_weight100,
       -1.000*le.DOB_day_weight100))/100;
		DOB_AggWeight := SELF.DOBWeight_day + SELF.DOBWeight_month + SELF.DOBWeight_year;
    SELF.DOB_match_code := MAP(
      le.DOB_year+le.DOB_month+le.DOB_day = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT311.MatchCode.OneSideNull,
      match_methods(pSrc,pVersion,pInfile).match_DOB_el(le.DOB_year, le.DOB_month, le.DOB_day, ri.DOB, DOB_AggWeight ,TRUE));
    SELF.DOBWeight :=  MAP(
           SELF.DOB_match_code = SALT311.MatchCode.OneSideNull => 0,
           DOB_AggWeight); 
    SELF.FNAME_match_code := match_methods(pSrc,pVersion,pInfile).match_FNAME(le.FNAME,ri.FNAME,le.FNAME_len,ri.FNAME_len,TRUE);
    SELF.FNAMEWeight := (50+MAP (
           SELF.FNAME_match_code = SALT311.MatchCode.ExactMatch =>le.FNAME_weight100,
           -1.000*le.FNAME_weight100))/100; 
    SELF.LNAME_match_code := MAP(
           le.LNAME = (TYPEOF(le.LNAME))'' OR ri.LNAME = (TYPEOF(ri.LNAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(pSrc,pVersion,pInfile).match_LNAME(le.LNAME,ri.LNAME,le.LNAME_len,ri.LNAME_len,FALSE));
    SELF.LNAMEWeight := (50+MAP (
           SELF.LNAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.LNAME_match_code = SALT311.MatchCode.ExactMatch =>le.LNAME_weight100,
           SELF.LNAME_match_code = SALT311.MatchCode.HyphenMatch =>le.LNAME_weight100*MIN(1,LENGTH(TRIM(ri.LNAME))/LENGTH(TRIM(le.LNAME))),
           SELF.LNAME_match_code = SALT311.MatchCode.InitialLMatch =>le.LNAME_weight100,
           SELF.LNAME_match_code = SALT311.MatchCode.InitialRMatch=> SALT311.Fn_Interpolate_Initial(le.LNAME,ri.LNAME,le.LNAME_weight100,le.LNAME_initial_char_weight100),
           SELF.LNAME_match_code = SALT311.MatchCode.EditDistanceMatch =>MAP((6 > le.LNAME_len) AND (6 > ri.LNAME_len) => le.LNAME_e1_weight100, le.LNAME_e2_weight100),
           -1.000*le.LNAME_weight100))/100; 
    SELF.CITY_NAME_match_code := MAP(
           le.CITY_NAME = (TYPEOF(le.CITY_NAME))'' OR ri.CITY_NAME = (TYPEOF(ri.CITY_NAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(pSrc,pVersion,pInfile).match_CITY_NAME(le.CITY_NAME,ri.CITY_NAME,FALSE));
    SELF.CITY_NAMEWeight := (50+MAP (
           SELF.CITY_NAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.CITY_NAME_match_code = SALT311.MatchCode.ExactMatch =>le.CITY_NAME_weight100,
           -1.000*le.CITY_NAME_weight100))/100; 
    SELF.ZIP_match_code := MAP(
           le.ZIP = (TYPEOF(le.ZIP))'' OR ri.ZIP = (TYPEOF(ri.ZIP))'' => SALT311.MatchCode.OneSideNull,
           match_methods(pSrc,pVersion,pInfile).match_ZIP(le.ZIP,ri.ZIP,FALSE));
    SELF.ZIPWeight := (50+MAP (
           SELF.ZIP_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.ZIP_match_code = SALT311.MatchCode.ExactMatch =>le.ZIP_weight100,
           -1.000*le.ZIP_weight100))/100; 
    SELF.ST_match_code := MAP(
           le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' => SALT311.MatchCode.OneSideNull,
           match_methods(pSrc,pVersion,pInfile).match_ST(le.ST,ri.ST,FALSE));
    SELF.STWeight := (50+MAP (
           SELF.ST_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.ST_match_code = SALT311.MatchCode.ExactMatch =>le.ST_weight100,
           -1.000*le.ST_weight100))/100; 
    SELF.GENDER_match_code := MAP(
           le.GENDER = (TYPEOF(le.GENDER))'' OR ri.GENDER = (TYPEOF(ri.GENDER))'' => SALT311.MatchCode.OneSideNull,
           match_methods(pSrc,pVersion,pInfile).match_GENDER(le.GENDER,ri.GENDER,FALSE));
    SELF.GENDERWeight := (50+MAP (
           SELF.GENDER_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.GENDER_match_code = SALT311.MatchCode.ExactMatch =>le.GENDER_weight100,
           -1.000*le.GENDER_weight100))/100; 
    SELF.PRIM_NAME_match_code := MAP(
           le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR ri.PRIM_NAME = (TYPEOF(ri.PRIM_NAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(pSrc,pVersion,pInfile).match_PRIM_NAME(le.PRIM_NAME,ri.PRIM_NAME,FALSE));
    SELF.PRIM_NAMEWeight := (50+MAP (
           SELF.PRIM_NAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.PRIM_NAME_match_code = SALT311.MatchCode.ExactMatch =>le.PRIM_NAME_weight100,
           -1.000*le.PRIM_NAME_weight100))/100; 
    SELF.PRIM_RANGE_match_code := MAP(
           le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR ri.PRIM_RANGE = (TYPEOF(ri.PRIM_RANGE))'' => SALT311.MatchCode.OneSideNull,
           match_methods(pSrc,pVersion,pInfile).match_PRIM_RANGE(le.PRIM_RANGE,ri.PRIM_RANGE,FALSE));
    SELF.PRIM_RANGEWeight := (50+MAP (
           SELF.PRIM_RANGE_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.PRIM_RANGE_match_code = SALT311.MatchCode.ExactMatch =>le.PRIM_RANGE_weight100,
           -1.000*le.PRIM_RANGE_weight100))/100; 
    SELF.MNAME_match_code := MAP(
           le.MNAME = (TYPEOF(le.MNAME))'' OR ri.MNAME = (TYPEOF(ri.MNAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(pSrc,pVersion,pInfile).match_MNAME(le.MNAME,ri.MNAME,le.MNAME_len,ri.MNAME_len,FALSE));
    SELF.MNAMEWeight := (50+MAP (
           SELF.MNAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.MNAME_match_code = SALT311.MatchCode.ExactMatch =>le.MNAME_weight100,
           SELF.MNAME_match_code = SALT311.MatchCode.InitialLMatch =>le.MNAME_weight100,
           SELF.MNAME_match_code = SALT311.MatchCode.InitialRMatch=> SALT311.Fn_Interpolate_Initial(le.MNAME,ri.MNAME,le.MNAME_weight100,le.MNAME_initial_char_weight100),
           SELF.MNAME_match_code = SALT311.MatchCode.EditDistanceMatch =>MAP((6 > le.MNAME_len) AND (6 > ri.MNAME_len) => le.MNAME_e1_weight100, le.MNAME_e2_weight100),
           -1.000*le.MNAME_weight100))/100; 
    SELF.SSN_match_code := MAP(
           le.SSN = (TYPEOF(le.SSN))'' OR ri.SSN = (TYPEOF(ri.SSN))'' => SALT311.MatchCode.OneSideNull,
           match_methods(pSrc,pVersion,pInfile).match_SSN(le.SSN,ri.SSN,le.SSN_len,ri.SSN_len,FALSE));
    SELF.SSNWeight := (50+MAP (
           SELF.SSN_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.SSN_match_code = SALT311.MatchCode.ExactMatch =>le.SSN_weight100,
           SELF.SSN_match_code = SALT311.MatchCode.EditDistanceMatch =>le.SSN_e1_weight100,
           -1.000*le.SSN_weight100))/100; 
    SELF.LEXID_match_code := MAP(
           le.LEXID = (TYPEOF(le.LEXID))'' OR ri.LEXID = (TYPEOF(ri.LEXID))'' => SALT311.MatchCode.OneSideNull,
           match_methods(pSrc,pVersion,pInfile).match_LEXID(le.LEXID,ri.LEXID,FALSE));
    SELF.LEXIDWeight := (50+MAP (
           SELF.LEXID_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.LEXID_match_code = SALT311.MatchCode.ExactMatch =>le.LEXID_weight100,
           -1.000*le.LEXID_weight100))/100; 
    SELF.SEC_RANGE_match_code := MAP(
           le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR ri.SEC_RANGE = (TYPEOF(ri.SEC_RANGE))'' => SALT311.MatchCode.OneSideNull,
           match_methods(pSrc,pVersion,pInfile).match_SEC_RANGE(le.SEC_RANGE,ri.SEC_RANGE,FALSE));
    SELF.SEC_RANGEWeight := (50+MAP (
           SELF.SEC_RANGE_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.SEC_RANGE_match_code = SALT311.MatchCode.ExactMatch =>le.SEC_RANGE_weight100,
           SELF.SEC_RANGE_match_code = SALT311.MatchCode.HyphenMatch =>le.SEC_RANGE_weight100*MIN(1,LENGTH(TRIM(ri.SEC_RANGE))/LENGTH(TRIM(le.SEC_RANGE))),
           -1.000*le.SEC_RANGE_weight100))/100; 
    SELF.SUFFIX_match_code := MAP(
           le.SUFFIX = (TYPEOF(le.SUFFIX))'' OR ri.SUFFIX = (TYPEOF(ri.SUFFIX))'' => SALT311.MatchCode.OneSideNull,
           match_methods(pSrc,pVersion,pInfile).match_SUFFIX(le.SUFFIX,ri.SUFFIX,FALSE));
    SELF.SUFFIXWeight := (50+MAP (
           SELF.SUFFIX_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.SUFFIX_match_code = SALT311.MatchCode.ExactMatch =>le.SUFFIX_weight100,
           -1.000*le.SUFFIX_weight100))/100; 
    SELF.Weight := IF(le.nomatch_id = 0, 100, MAX(0, SELF.DOBWeight) + MAX(0, SELF.FNAMEWeight) + MAX(0, SELF.LNAMEWeight) + MAX(0, SELF.CITY_NAMEWeight) + MAX(0, SELF.ZIPWeight) + MAX(0, SELF.STWeight) + MAX(0, SELF.GENDERWeight) + MAX(0, SELF.PRIM_NAMEWeight) + MAX(0, SELF.PRIM_RANGEWeight) + MAX(0, SELF.MNAMEWeight) + MAX(0, SELF.SSNWeight) + MAX(0, SELF.LEXIDWeight) + MAX(0, SELF.SEC_RANGEWeight) + MAX(0, SELF.SUFFIXWeight));
    SELF := le;
  END;
  Recs0 := Recs(DOB <> (TYPEOF(DOB))'',FNAME <> (TYPEOF(FNAME))'');
  SALT311.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference,Config.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,(SALT311.MOD_DateMatch((LEFT.DOB DIV 10000 ),(LEFT.DOB DIV 100 % 100 ),(LEFT.DOB % 100),RIGHT.DOB_year,RIGHT.DOB_month,RIGHT.DOB_day,false,false,0,false,0,0).NNEQ)
     AND ((RIGHT.FNAME = LEFT.FNAME))
     AND ((LEFT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'') OR (RIGHT.LNAME = LEFT.LNAME) OR ((RIGHT.LNAME[1..LENGTH(TRIM(LEFT.LNAME))] = LEFT.LNAME OR LEFT.LNAME[1..LENGTH(TRIM(RIGHT.LNAME))] = RIGHT.LNAME)  OR (Config.WithinEditN(RIGHT.LNAME,RIGHT.LNAME_len,LEFT.LNAME,LEFT.LNAME_len,2, 6))  OR (SALT311.HyphenMatch(RIGHT.LNAME,LEFT.LNAME,1)<=2)))
     AND ((LEFT.CITY_NAME = (TYPEOF(RIGHT.CITY_NAME))'' OR RIGHT.CITY_NAME = (TYPEOF(RIGHT.CITY_NAME))'') OR (RIGHT.CITY_NAME = LEFT.CITY_NAME)),Score_Batch(RIGHT,LEFT),
    ATMOST((SALT311.MOD_DateMatch((LEFT.DOB DIV 10000 ),(LEFT.DOB DIV 100 % 100 ),(LEFT.DOB % 100),RIGHT.DOB_year,RIGHT.DOB_month,RIGHT.DOB_day,false,false,0,false,0,0).NNEQ)
     AND ((RIGHT.FNAME = LEFT.FNAME)),Config.NOMATCH_MAXBLOCKSIZE)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),(SALT311.MOD_DateMatch((LEFT.DOB DIV 10000 ),(LEFT.DOB DIV 100 % 100 ),(LEFT.DOB % 100),RIGHT.DOB_year,RIGHT.DOB_month,RIGHT.DOB_day,false,false,0,false,0,0).NNEQ)
     AND ((RIGHT.FNAME = LEFT.FNAME))
     AND ((LEFT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'') OR (RIGHT.LNAME = LEFT.LNAME) OR ((RIGHT.LNAME[1..LENGTH(TRIM(LEFT.LNAME))] = LEFT.LNAME OR LEFT.LNAME[1..LENGTH(TRIM(RIGHT.LNAME))] = RIGHT.LNAME)  OR (Config.WithinEditN(RIGHT.LNAME,RIGHT.LNAME_len,LEFT.LNAME,LEFT.LNAME_len,2, 6))  OR (SALT311.HyphenMatch(RIGHT.LNAME,LEFT.LNAME,1)<=2)))
     AND ((LEFT.CITY_NAME = (TYPEOF(RIGHT.CITY_NAME))'' OR RIGHT.CITY_NAME = (TYPEOF(RIGHT.CITY_NAME))'') OR (RIGHT.CITY_NAME = LEFT.CITY_NAME)),Score_Batch(RIGHT,LEFT),
    ATMOST((SALT311.MOD_DateMatch((LEFT.DOB DIV 10000 ),(LEFT.DOB DIV 100 % 100 ),(LEFT.DOB % 100),RIGHT.DOB_year,RIGHT.DOB_month,RIGHT.DOB_day,false,false,0,false,0,0).NNEQ)
     AND ((RIGHT.FNAME = LEFT.FNAME)),Config.NOMATCH_MAXBLOCKSIZE),HASH,UNORDERED); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := PROJECT(J2, Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).update_forcefailed(LEFT,In_disableForce));
  J4 := Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).CombineLinkpathScores(J3,In_disableForce); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT311.MAC_Dups_Restore(J4,DD,J5,Reference,TRUE)
  RETURN J5;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_DOB='',Input_FNAME='',Input_LNAME='',Input_CITY_NAME='',Input_ZIP='',Input_ST='',Input_GENDER='',Input_PRIM_NAME='',Input_PRIM_RANGE='',Input_MNAME='',Input_SSN='',Input_LEXID='',Input_SEC_RANGE='',Input_SUFFIX='',output_file,AsIndex='true', In_disableForce = 'false') := MACRO
  IMPORT SALT311,HealthcareNoMatchHeader_ExternalLinking;
  #IF(#TEXT(Input_DOB)<>'' AND #TEXT(Input_FNAME)<>'')
    #UNIQUENAME(trans)
    HealthcareNoMatchHeader_ExternalLinking.Key_HEADER_NOMATCH(pSrc,pVersion,pInfile).InputLayout_Batch %trans%(InFile le) := TRANSFORM
      SELF.Reference := le.Input_Ref;
      SELF.DOB := (UNSIGNED4)le.Input_DOB;
      SELF.FNAME := (TYPEOF(SELF.FNAME))le.Input_FNAME;
      SELF.FNAME_len := LENGTH(TRIM((TYPEOF(SELF.FNAME))le.Input_FNAME));
      #IF ( #TEXT(Input_LNAME) <> '' )
        SELF.LNAME := (TYPEOF(SELF.LNAME))le.Input_LNAME;
        SELF.LNAME_len := LENGTH(TRIM((TYPEOF(SELF.LNAME))le.Input_LNAME));
      #END
      #IF ( #TEXT(Input_CITY_NAME) <> '' )
        SELF.CITY_NAME := (TYPEOF(SELF.CITY_NAME))le.Input_CITY_NAME;
      #END
      #IF ( #TEXT(Input_ZIP) <> '' )
        SELF.ZIP := (TYPEOF(SELF.ZIP))le.Input_ZIP;
      #END
      #IF ( #TEXT(Input_ST) <> '' )
        SELF.ST := (TYPEOF(SELF.ST))le.Input_ST;
      #END
      #IF ( #TEXT(Input_GENDER) <> '' )
        SELF.GENDER := (TYPEOF(SELF.GENDER))le.Input_GENDER;
      #END
      #IF ( #TEXT(Input_PRIM_NAME) <> '' )
        SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))le.Input_PRIM_NAME;
      #END
      #IF ( #TEXT(Input_PRIM_RANGE) <> '' )
        SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))le.Input_PRIM_RANGE;
      #END
      #IF ( #TEXT(Input_MNAME) <> '' )
        SELF.MNAME := (TYPEOF(SELF.MNAME))le.Input_MNAME;
        SELF.MNAME_len := LENGTH(TRIM((TYPEOF(SELF.MNAME))le.Input_MNAME));
      #END
      #IF ( #TEXT(Input_SSN) <> '' )
        SELF.SSN := (TYPEOF(SELF.SSN))le.Input_SSN;
        SELF.SSN_len := LENGTH(TRIM((TYPEOF(SELF.SSN))le.Input_SSN));
      #END
      #IF ( #TEXT(Input_LEXID) <> '' )
        SELF.LEXID := (TYPEOF(SELF.LEXID))le.Input_LEXID;
      #END
      #IF ( #TEXT(Input_SEC_RANGE) <> '' )
        SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))le.Input_SEC_RANGE;
      #END
      #IF ( #TEXT(Input_SUFFIX) <> '' )
        SELF.SUFFIX := (TYPEOF(SELF.SUFFIX))le.Input_SUFFIX;
      #END
    END;
    #UNIQUENAME(p)
    %p% := PROJECT(Infile,%trans%(left));
    output_file := HealthcareNoMatchHeader_ExternalLinking.Key_HEADER_NOMATCH(pSrc,pVersion,pInfile).ScoredFetch_Batch(%p%,AsIndex, In_disableForce);
  #ELSE
    output_file := DATASET([],HealthcareNoMatchHeader_ExternalLinking.Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).LayoutScoredFetch); // Compulsory fields missing
  #END
ENDMACRO;
END;
