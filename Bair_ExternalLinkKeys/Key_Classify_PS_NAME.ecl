IMPORT SALT33,ut,std;
EXPORT Key_Classify_PS_NAME := MODULE
 
//FNAME:LNAME:ST:?:NAME_SUFFIX:MNAME:+:PRIM_RANGE:PRIM_NAME:SEC_RANGE:P_CITY_NAME:DOB:SEARCH_ADDR1:SEARCH_ADDR2:LEXID
 
EXPORT KeyName := KeyPrefix+'::'+'key::Bair_ExternalLinkKeys'+'::'+Config.KeyInfix+'::EID_HASH::Refs::NAME';
 
EXPORT KeyName_sf := KeyPrefix+'::'+'key::Bair_ExternalLinkKeys'+'::'+KeySuperfile+'::EID_HASH::Refs::NAME';
 
EXPORT AssignCurrentKeyToSuperFile := FileServices.AddSuperFile(KeyName_sf,KeyName);
 
EXPORT ClearKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(KeyName_sf,,TRUE),FileServices.ClearSuperFile(KeyName_sf));
SHARED h := CandidatesForKey;//The input file - distributed by EID_HASH
layout := RECORD // project out required fields
// Compulsory fields
  h.FNAME;
  h.LNAME;
  h.ST;
// Optional fields
  h.NAME_SUFFIX;
  h.EID_HASH; // The ID field
  h.MNAME;
// Extra credit fields
  h.PRIM_RANGE;
  h.PRIM_NAME;
  h.SEC_RANGE;
  h.P_CITY_NAME;
  h.DOB_year;
  h.DOB_month;
  h.DOB_day;
  h.SEARCH_ADDR1;
  h.SEARCH_ADDR2;
  h.LEXID;
//Scores for various field components
  h.FNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_initial_char_weight100 ; // Contains 100x the specificity
  h.FNAME_p_Weight100;
  h.FNAME_e1_Weight100;
  h.FNAME_e1p_Weight100;
  h.FNAME_PreferredName_Weight100;
  h.FNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.LNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_p_Weight100;
  h.LNAME_e1_Weight100;
  h.LNAME_e1p_Weight100;
  h.LNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.ST_weight100 ; // Contains 100x the specificity
  h.NAME_SUFFIX_weight100 ; // Contains 100x the specificity
  h.MNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_initial_char_weight100 ; // Contains 100x the specificity
  h.MNAME_e2_Weight100;
  h.MNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.PRIM_RANGE_weight100 ; // Contains 100x the specificity
  INTEGER2 PRIM_RANGE_e1_Weight100 := SALT33.Min0(h.PRIM_RANGE_weight100 + 100*log(h.PRIM_RANGE_cnt/h.PRIM_RANGE_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.PRIM_NAME_weight100 ; // Contains 100x the specificity
  INTEGER2 PRIM_NAME_e1_Weight100 := SALT33.Min0(h.PRIM_NAME_weight100 + 100*log(h.PRIM_NAME_cnt/h.PRIM_NAME_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.SEC_RANGE_weight100 ; // Contains 100x the specificity
  h.P_CITY_NAME_weight100 ; // Contains 100x the specificity
  h.DOB_year_weight100; // Contains 100x the specificity
  h.DOB_month_weight100; // Contains 100x the specificity
  h.DOB_day_weight100; // Contains 100x the specificity
  h.SEARCH_ADDR1_weight100 ; // Contains 100x the specificity
  h.SEARCH_ADDR2_weight100 ; // Contains 100x the specificity
  h.LEXID_weight100 ; // Contains 100x the specificity
END;
 
s := Specificities(File_Classify_PS).Specificities[1];
 
DataForKey0 := DEDUP(SORT(TABLE(h((FNAME NOT IN SET(s.nulls_FNAME,FNAME) AND FNAME <> (TYPEOF(FNAME))''),(LNAME NOT IN SET(s.nulls_LNAME,LNAME) AND LNAME <> (TYPEOF(LNAME))''),(ST NOT IN SET(s.nulls_ST,ST) AND ST <> (TYPEOF(ST))'')),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
 
EXPORT Key := INDEX(DataForKey0,,KeyName_sf);
 
EXPORT BuildAll := BUILDINDEX(Key, OVERWRITE);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,EID_HASH,FNAME,LNAME,ST,NAME_SUFFIX,MNAME,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_PRIM_RANGE := GROUP( DEDUP( SORT( Grpd, EXCEPT PRIM_RANGE), EXCEPT PRIM_RANGE));
  CntRed_PRIM_RANGE := (KeyCnt-COUNT(Rem_PRIM_RANGE))/KeyCnt;
  Rem_PRIM_NAME := GROUP( DEDUP( SORT( Grpd, EXCEPT PRIM_NAME), EXCEPT PRIM_NAME));
  CntRed_PRIM_NAME := (KeyCnt-COUNT(Rem_PRIM_NAME))/KeyCnt;
  Rem_SEC_RANGE := GROUP( DEDUP( SORT( Grpd, EXCEPT SEC_RANGE), EXCEPT SEC_RANGE));
  CntRed_SEC_RANGE := (KeyCnt-COUNT(Rem_SEC_RANGE))/KeyCnt;
  Rem_P_CITY_NAME := GROUP( DEDUP( SORT( Grpd, EXCEPT P_CITY_NAME), EXCEPT P_CITY_NAME));
  CntRed_P_CITY_NAME := (KeyCnt-COUNT(Rem_P_CITY_NAME))/KeyCnt;
  Rem_DOB := GROUP( DEDUP( SORT( Grpd, EXCEPT DOB_year,DOB_month,DOB_day), EXCEPT DOB_year,DOB_month,DOB_day));
  CntRed_DOB := (KeyCnt-COUNT(Rem_DOB))/KeyCnt;
  Rem_SEARCH_ADDR1 := GROUP( DEDUP( SORT( Grpd, EXCEPT SEARCH_ADDR1), EXCEPT SEARCH_ADDR1));
  CntRed_SEARCH_ADDR1 := (KeyCnt-COUNT(Rem_SEARCH_ADDR1))/KeyCnt;
  Rem_SEARCH_ADDR2 := GROUP( DEDUP( SORT( Grpd, EXCEPT SEARCH_ADDR2), EXCEPT SEARCH_ADDR2));
  CntRed_SEARCH_ADDR2 := (KeyCnt-COUNT(Rem_SEARCH_ADDR2))/KeyCnt;
  Rem_LEXID := GROUP( DEDUP( SORT( Grpd, EXCEPT LEXID), EXCEPT LEXID));
  CntRed_LEXID := (KeyCnt-COUNT(Rem_LEXID))/KeyCnt;
EXPORT Shrinkage := DATASET([{'NAME','PRIM_RANGE',CntRed_PRIM_RANGE*100,CntRed_PRIM_RANGE*TSize},{'NAME','PRIM_NAME',CntRed_PRIM_NAME*100,CntRed_PRIM_NAME*TSize},{'NAME','SEC_RANGE',CntRed_SEC_RANGE*100,CntRed_SEC_RANGE*TSize},{'NAME','P_CITY_NAME',CntRed_P_CITY_NAME*100,CntRed_P_CITY_NAME*TSize},{'NAME','DOB',CntRed_DOB*100,CntRed_DOB*TSize},{'NAME','SEARCH_ADDR1',CntRed_SEARCH_ADDR1*100,CntRed_SEARCH_ADDR1*TSize},{'NAME','SEARCH_ADDR2',CntRed_SEARCH_ADDR2*100,CntRed_SEARCH_ADDR2*TSize},{'NAME','LEXID',CntRed_LEXID*100,CntRed_LEXID*TSize}],SALT33.ShrinkLayout);
EXPORT CanSearch(Process_PS_Layouts.InputLayout le) := le.FNAME <> (typeof(le.FNAME))'' AND le.LNAME <> (typeof(le.LNAME))'' AND le.ST <> (typeof(le.ST))'';
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',TYPEOF(h.NAME_SUFFIX) param_NAME_SUFFIX = (TYPEOF(h.NAME_SUFFIX))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'') := 
    STEPPED( LIMIT( Key(
          KEYED(( FNAME = param_FNAME AND param_FNAME <> (TYPEOF(FNAME))''))
      AND KEYED(( LNAME = param_LNAME AND param_LNAME <> (TYPEOF(LNAME))''))
      AND KEYED(( ST = param_ST AND param_ST <> (TYPEOF(ST))''))
      AND KEYED(( NAME_SUFFIX = (TYPEOF(NAME_SUFFIX))'' OR param_NAME_SUFFIX = (TYPEOF(NAME_SUFFIX))'' OR NAME_SUFFIX = param_NAME_SUFFIX ))
      AND ( MNAME[1..LENGTH(TRIM(param_MNAME))] = param_MNAME OR param_MNAME[1..LENGTH(TRIM(MNAME))] = MNAME OR SALT33.WithinEditN(MNAME,param_MNAME,2, 0) )),500,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),EID_HASH);
 
 
EXPORT ScoredEID_HASHFetch(TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',TYPEOF(h.NAME_SUFFIX) param_NAME_SUFFIX = (TYPEOF(h.NAME_SUFFIX))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.PRIM_RANGE) param_PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',TYPEOF(h.PRIM_NAME) param_PRIM_NAME = (TYPEOF(h.PRIM_NAME))'',TYPEOF(h.SEC_RANGE) param_SEC_RANGE = (TYPEOF(h.SEC_RANGE))'',TYPEOF(h.P_CITY_NAME) param_P_CITY_NAME = (TYPEOF(h.P_CITY_NAME))'',UNSIGNED4 param_DOB,TYPEOF(h.SEARCH_ADDR1) param_SEARCH_ADDR1 = (TYPEOF(h.SEARCH_ADDR1))'',TYPEOF(h.SEARCH_ADDR2) param_SEARCH_ADDR2 = (TYPEOF(h.SEARCH_ADDR2))'',TYPEOF(h.LEXID) param_LEXID = (TYPEOF(h.LEXID))'') := FUNCTION
  RawData := RawFetch(param_FNAME,param_LNAME,param_ST,param_NAME_SUFFIX,param_MNAME);
 
  Process_PS_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 1; // Set bitmap for key used
    SELF.keys_failed := IF(le.EID_HASH = 0, 1 << 1, 0); // Set bitmap for key failed
    SELF.FNAME_match_code := MAP(le.FNAME = (TYPEOF(le.FNAME))'' OR le.FNAME = (TYPEOF(le.FNAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_FNAME(le.FNAME,param_FNAME,0,0,TRUE));
    SELF.FNAMEWeight := (50+MAP ( le.FNAME = param_FNAME  => le.FNAME_weight100,
          le.FNAME = (TYPEOF(le.FNAME))'' OR param_FNAME = (TYPEOF(le.FNAME))'' => 0,
          -0.737*le.FNAME_weight100))/100*0.80; 
    SELF.LNAME_match_code := MAP(le.LNAME = (TYPEOF(le.LNAME))'' OR le.LNAME = (TYPEOF(le.LNAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_LNAME(le.LNAME,param_LNAME,0,0,TRUE));
    SELF.LNAMEWeight := (50+MAP ( le.LNAME = param_LNAME  => le.LNAME_weight100,
          le.LNAME = (TYPEOF(le.LNAME))'' OR param_LNAME = (TYPEOF(le.LNAME))'' => 0,
          -0.617*le.LNAME_weight100))/100*0.80; 
    SELF.ST_match_code := MAP(le.ST = (TYPEOF(le.ST))'' OR le.ST = (TYPEOF(le.ST))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_ST(le.ST,param_ST,TRUE));
    SELF.STWeight := (50+MAP ( le.ST = param_ST  => le.ST_weight100,
          le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(le.ST))'' => 0,
          -0.690*le.ST_weight100))/100; 
    SELF.NAME_SUFFIX_match_code := MAP(le.NAME_SUFFIX = (TYPEOF(le.NAME_SUFFIX))'' OR param_NAME_SUFFIX = (TYPEOF(param_NAME_SUFFIX))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_NAME_SUFFIX(le.NAME_SUFFIX,param_NAME_SUFFIX,FALSE));
    SELF.NAME_SUFFIXWeight := (50+MAP ( le.NAME_SUFFIX = (TYPEOF(le.NAME_SUFFIX))'' OR param_NAME_SUFFIX = (TYPEOF(param_NAME_SUFFIX))'' => 0,
           le.NAME_SUFFIX = param_NAME_SUFFIX  => le.NAME_SUFFIX_weight100,
           -0.946*le.NAME_SUFFIX_weight100))/100; 
    SELF.MNAME_match_code := MAP(le.MNAME = (TYPEOF(le.MNAME))'' OR param_MNAME = (TYPEOF(param_MNAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_MNAME(le.MNAME,param_MNAME,0,0,FALSE));
    SELF.MNAMEWeight := (50+MAP ( le.MNAME = (TYPEOF(le.MNAME))'' OR param_MNAME = (TYPEOF(param_MNAME))'' => 0,
           le.MNAME = param_MNAME  => le.MNAME_weight100,
           le.MNAME = param_MNAME[1..LENGTH(TRIM(le.MNAME))] => le.MNAME_weight100,
           SALT33.WithinEditN(le.MNAME,param_MNAME,2, 0) => le.MNAME_e2_weight100,
           le.MNAME[1..LENGTH(TRIM(param_MNAME))] = param_MNAME => SALT33.Fn_Interpolate_Initial(le.MNAME,param_MNAME,le.MNAME_weight100,le.MNAME_initial_char_weight100), // later in sequence as less accurate
           -0.772*le.MNAME_weight100))/100*0.80; 
    SELF.PRIM_RANGE_match_code := MAP(le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR param_PRIM_RANGE = (TYPEOF(param_PRIM_RANGE))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_PRIM_RANGE(le.PRIM_RANGE,param_PRIM_RANGE,0,0,FALSE));
    SELF.PRIM_RANGEWeight := (50+MAP ( le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR param_PRIM_RANGE = (TYPEOF(param_PRIM_RANGE))'' => 0,
           le.PRIM_RANGE = param_PRIM_RANGE  => le.PRIM_RANGE_weight100,
           SALT33.WithinEditN(le.PRIM_RANGE,param_PRIM_RANGE,1, 0) => le.PRIM_RANGE_e1_weight100,
           -0.537*le.PRIM_RANGE_weight100))/100; 
    SELF.PRIM_NAME_match_code := MAP(le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR param_PRIM_NAME = (TYPEOF(param_PRIM_NAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_PRIM_NAME(le.PRIM_NAME,param_PRIM_NAME,0,0,FALSE));
    SELF.PRIM_NAMEWeight := (50+MAP ( le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR param_PRIM_NAME = (TYPEOF(param_PRIM_NAME))'' => 0,
           le.PRIM_NAME = param_PRIM_NAME  => le.PRIM_NAME_weight100,
           SALT33.WithinEditN(le.PRIM_NAME,param_PRIM_NAME,1, 0) => le.PRIM_NAME_e1_weight100,
           -0.531*le.PRIM_NAME_weight100))/100; 
    SELF.SEC_RANGE_match_code := MAP(le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR param_SEC_RANGE = (TYPEOF(param_SEC_RANGE))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_SEC_RANGE(le.SEC_RANGE,param_SEC_RANGE,FALSE));
    SELF.SEC_RANGEWeight := (50+MAP ( le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR param_SEC_RANGE = (TYPEOF(param_SEC_RANGE))'' => 0,
           le.SEC_RANGE = param_SEC_RANGE  => le.SEC_RANGE_weight100,
           SALT33.HyphenMatch(le.SEC_RANGE,param_SEC_RANGE,1)<=2 => le.SEC_RANGE_weight100*MIN(1,LENGTH(TRIM(param_SEC_RANGE))/LENGTH(TRIM(le.SEC_RANGE))),
           -0.629*le.SEC_RANGE_weight100))/100; 
    SELF.P_CITY_NAME_match_code := MAP(le.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' OR param_P_CITY_NAME = (TYPEOF(param_P_CITY_NAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_P_CITY_NAME(le.P_CITY_NAME,param_P_CITY_NAME,FALSE));
    SELF.P_CITY_NAMEWeight := (50+MAP ( le.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' OR param_P_CITY_NAME = (TYPEOF(param_P_CITY_NAME))'' => 0,
           le.P_CITY_NAME = param_P_CITY_NAME  => le.P_CITY_NAME_weight100,
           -0.580*le.P_CITY_NAME_weight100))/100; 
    SELF.DOBWeight_year := (50+MAP ( le.DOB_year = 0 OR ((UNSIGNED)param_DOB) DIV 10000 = 0 => 0,
       le.DOB_year = ((UNSIGNED)param_DOB) DIV 10000  => le.DOB_year_weight100,
       SALT33.Fn_YearMatch(le.DOB_year,((unsigned)param_DOB) DIV 10000,13)=> le.DOB_year_weight100-358, //YEAR_SHIFT
       -1.000*le.DOB_year_weight100))/100;
    SELF.DOBWeight_month := (50+MAP ( le.DOB_month = 0 OR ((UNSIGNED)param_DOB) DIV 100 % 100 = 0 => 0,
      le.DOB_month = ((UNSIGNED)param_DOB) DIV 100 % 100  => le.DOB_month_weight100,
      le.DOB_month = 1 AND le.DOB_day = 1 => -200, // SOFT1 
      le.DOB_month = ((UNSIGNED)param_DOB) % 100 AND le.DOB_day = ((UNSIGNED)param_DOB) DIV 100 % 100 => le.DOB_month_weight100-100, // MDDM
       -1.000*le.DOB_month_weight100))/100;
    SELF.DOBWeight_day := (50+MAP ( le.DOB_day = 0 OR ((UNSIGNED)param_DOB) % 100 = 0 => 0,
      le.DOB_day = ((UNSIGNED)param_DOB) % 100  => le.DOB_day_weight100,
      le.DOB_day = 1 => -200, // SOFT1 
      le.DOB_month = ((UNSIGNED)param_DOB) % 100 AND le.DOB_day = ((UNSIGNED)param_DOB) DIV 100 % 100 => le.DOB_day_weight100-100, // MDDM
       -1.000*le.DOB_day_weight100))/100;
    SELF.DOBWeight := (SELF.DOBWeight_year+SELF.DOBWeight_month+SELF.DOBWeight_day); 
    SELF.DOB_year_match_code := MAP(
      le.DOB_year = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT33.MatchCode.OneSideNull,
      match_methods(File_Classify_PS).match_DOB_year(le.DOB_year,((UNSIGNED)param_DOB) DIV 10000));
    SELF.DOB_month_match_code := MAP(
      le.DOB_month = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT33.MatchCode.OneSideNull,
      match_methods(File_Classify_PS).match_DOB_month(le.DOB_month,((UNSIGNED)param_DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)param_DOB) % 100));
    SELF.DOB_day_match_code := MAP(
      le.DOB_day = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT33.MatchCode.OneSideNull,
      match_methods(File_Classify_PS).match_DOB_day(le.DOB_month,((UNSIGNED)param_DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)param_DOB) % 100));
    SELF.DOB_match_code := MAP(
      le.DOB_year+le.DOB_month+le.DOB_day = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT33.MatchCode.OneSideNull,
      SELF.DOBWeight = SELF.DOBWeight_year+SELF.DOBWeight_month+SELF.DOBWeight_day => SALT33.MatchCode.DateAggregate,
      SALT33.MatchCode.NoMatch);
    SELF.SEARCH_ADDR1_match_code := MAP(le.SEARCH_ADDR1 = (TYPEOF(le.SEARCH_ADDR1))'' OR param_SEARCH_ADDR1 = (TYPEOF(param_SEARCH_ADDR1))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_SEARCH_ADDR1(le.SEARCH_ADDR1,param_SEARCH_ADDR1,FALSE));
    SELF.SEARCH_ADDR1Weight := (50+MAP ( le.SEARCH_ADDR1 = (TYPEOF(le.SEARCH_ADDR1))'' OR param_SEARCH_ADDR1 = (TYPEOF(param_SEARCH_ADDR1))'' => 0,
           le.SEARCH_ADDR1 = param_SEARCH_ADDR1  => le.SEARCH_ADDR1_weight100,
           -0.424*le.SEARCH_ADDR1_weight100))/100; 
    SELF.SEARCH_ADDR2_match_code := MAP(le.SEARCH_ADDR2 = (TYPEOF(le.SEARCH_ADDR2))'' OR param_SEARCH_ADDR2 = (TYPEOF(param_SEARCH_ADDR2))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_SEARCH_ADDR2(le.SEARCH_ADDR2,param_SEARCH_ADDR2,FALSE));
    SELF.SEARCH_ADDR2Weight := (50+MAP ( le.SEARCH_ADDR2 = (TYPEOF(le.SEARCH_ADDR2))'' OR param_SEARCH_ADDR2 = (TYPEOF(param_SEARCH_ADDR2))'' => 0,
           le.SEARCH_ADDR2 = param_SEARCH_ADDR2  => le.SEARCH_ADDR2_weight100,
           -0.480*le.SEARCH_ADDR2_weight100))/100; 
    SELF.LEXID_match_code := MAP(le.LEXID = (TYPEOF(le.LEXID))'' OR param_LEXID = (TYPEOF(param_LEXID))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_LEXID(le.LEXID,param_LEXID,FALSE));
    SELF.LEXIDWeight := (50+MAP ( le.LEXID = (TYPEOF(le.LEXID))'' OR param_LEXID = (TYPEOF(param_LEXID))'' => 0,
           le.LEXID = param_LEXID  => le.LEXID_weight100,
           -0.650*le.LEXID_weight100))/100; 
    SELF.Weight := IF(le.EID_HASH = 0, 100, MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.LNAMEWeight) + MAX(0,SELF.STWeight) + MAX(0,SELF.NAME_SUFFIXWeight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.PRIM_RANGEWeight) + MAX(0,SELF.PRIM_NAMEWeight) + MAX(0,SELF.SEC_RANGEWeight) + MAX(0,SELF.P_CITY_NAMEWeight) + MAX(0,SELF.DOBWeight) + MAX(0,SELF.SEARCH_ADDR1Weight) + MAX(0,SELF.SEARCH_ADDR2Weight) + MAX(0,SELF.LEXIDWeight));
    SELF := le;
  END;
  RETURN ROLLUP(PROJECT(PROJECT(NOFOLD(RawData),Score(LEFT)),Process_PS_Layouts.update_forcefailed(LEFT)),LEFT.EID_HASH = RIGHT.EID_HASH,Process_PS_Layouts.combine_scores(LEFT,RIGHT));
END;
 
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT33.UIDType Reference;//How to recognize this record in the subsequent
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))'';
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))'';
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))'';
  TYPEOF(h.NAME_SUFFIX) NAME_SUFFIX := (TYPEOF(h.NAME_SUFFIX))'';
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))'';
  TYPEOF(h.PRIM_RANGE) PRIM_RANGE := (TYPEOF(h.PRIM_RANGE))'';
  TYPEOF(h.PRIM_NAME) PRIM_NAME := (TYPEOF(h.PRIM_NAME))'';
  TYPEOF(h.SEC_RANGE) SEC_RANGE := (TYPEOF(h.SEC_RANGE))'';
  TYPEOF(h.P_CITY_NAME) P_CITY_NAME := (TYPEOF(h.P_CITY_NAME))'';
  unsigned4 DOB := 0;
  TYPEOF(h.SEARCH_ADDR1) SEARCH_ADDR1 := (TYPEOF(h.SEARCH_ADDR1))'';
  TYPEOF(h.SEARCH_ADDR2) SEARCH_ADDR2 := (TYPEOF(h.SEARCH_ADDR2))'';
  TYPEOF(h.LEXID) LEXID := (TYPEOF(h.LEXID))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex) := FUNCTION
 
  Process_PS_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 1; // Set bitmap for key used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.FNAME_match_code := MAP(le.FNAME = (TYPEOF(le.FNAME))'' OR le.FNAME = (TYPEOF(le.FNAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_FNAME(le.FNAME,ri.FNAME,0,0,TRUE));
    SELF.FNAMEWeight := (50+MAP ( le.FNAME = ri.FNAME  => le.FNAME_weight100,
          le.FNAME = (TYPEOF(le.FNAME))'' OR ri.FNAME = (TYPEOF(le.FNAME))'' => 0,
          -0.737*le.FNAME_weight100))/100*0.80; 
    SELF.LNAME_match_code := MAP(le.LNAME = (TYPEOF(le.LNAME))'' OR le.LNAME = (TYPEOF(le.LNAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_LNAME(le.LNAME,ri.LNAME,0,0,TRUE));
    SELF.LNAMEWeight := (50+MAP ( le.LNAME = ri.LNAME  => le.LNAME_weight100,
          le.LNAME = (TYPEOF(le.LNAME))'' OR ri.LNAME = (TYPEOF(le.LNAME))'' => 0,
          -0.617*le.LNAME_weight100))/100*0.80; 
    SELF.ST_match_code := MAP(le.ST = (TYPEOF(le.ST))'' OR le.ST = (TYPEOF(le.ST))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_ST(le.ST,ri.ST,TRUE));
    SELF.STWeight := (50+MAP ( le.ST = ri.ST  => le.ST_weight100,
          le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(le.ST))'' => 0,
          -0.690*le.ST_weight100))/100; 
    SELF.NAME_SUFFIX_match_code := MAP(le.NAME_SUFFIX = (TYPEOF(le.NAME_SUFFIX))'' OR ri.NAME_SUFFIX = (TYPEOF(ri.NAME_SUFFIX))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_NAME_SUFFIX(le.NAME_SUFFIX,ri.NAME_SUFFIX,FALSE));
    SELF.NAME_SUFFIXWeight := (50+MAP ( le.NAME_SUFFIX = (TYPEOF(le.NAME_SUFFIX))'' OR ri.NAME_SUFFIX = (TYPEOF(ri.NAME_SUFFIX))'' => 0,
           le.NAME_SUFFIX = ri.NAME_SUFFIX  => le.NAME_SUFFIX_weight100,
           -0.946*le.NAME_SUFFIX_weight100))/100; 
    SELF.MNAME_match_code := MAP(le.MNAME = (TYPEOF(le.MNAME))'' OR ri.MNAME = (TYPEOF(ri.MNAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_MNAME(le.MNAME,ri.MNAME,0,0,FALSE));
    SELF.MNAMEWeight := (50+MAP ( le.MNAME = (TYPEOF(le.MNAME))'' OR ri.MNAME = (TYPEOF(ri.MNAME))'' => 0,
           le.MNAME = ri.MNAME  => le.MNAME_weight100,
           le.MNAME = ri.MNAME[1..LENGTH(TRIM(le.MNAME))] => le.MNAME_weight100,
           SALT33.WithinEditN(le.MNAME,ri.MNAME,2, 0) => le.MNAME_e2_weight100,
           le.MNAME[1..LENGTH(TRIM(ri.MNAME))] = ri.MNAME => SALT33.Fn_Interpolate_Initial(le.MNAME,ri.MNAME,le.MNAME_weight100,le.MNAME_initial_char_weight100), // later in sequence as less accurate
           -0.772*le.MNAME_weight100))/100*0.80; 
    SELF.PRIM_RANGE_match_code := MAP(le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR ri.PRIM_RANGE = (TYPEOF(ri.PRIM_RANGE))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_PRIM_RANGE(le.PRIM_RANGE,ri.PRIM_RANGE,0,0,FALSE));
    SELF.PRIM_RANGEWeight := (50+MAP ( le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR ri.PRIM_RANGE = (TYPEOF(ri.PRIM_RANGE))'' => 0,
           le.PRIM_RANGE = ri.PRIM_RANGE  => le.PRIM_RANGE_weight100,
           SALT33.WithinEditN(le.PRIM_RANGE,ri.PRIM_RANGE,1, 0) => le.PRIM_RANGE_e1_weight100,
           -0.537*le.PRIM_RANGE_weight100))/100; 
    SELF.PRIM_NAME_match_code := MAP(le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR ri.PRIM_NAME = (TYPEOF(ri.PRIM_NAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_PRIM_NAME(le.PRIM_NAME,ri.PRIM_NAME,0,0,FALSE));
    SELF.PRIM_NAMEWeight := (50+MAP ( le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR ri.PRIM_NAME = (TYPEOF(ri.PRIM_NAME))'' => 0,
           le.PRIM_NAME = ri.PRIM_NAME  => le.PRIM_NAME_weight100,
           SALT33.WithinEditN(le.PRIM_NAME,ri.PRIM_NAME,1, 0) => le.PRIM_NAME_e1_weight100,
           -0.531*le.PRIM_NAME_weight100))/100; 
    SELF.SEC_RANGE_match_code := MAP(le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR ri.SEC_RANGE = (TYPEOF(ri.SEC_RANGE))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_SEC_RANGE(le.SEC_RANGE,ri.SEC_RANGE,FALSE));
    SELF.SEC_RANGEWeight := (50+MAP ( le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR ri.SEC_RANGE = (TYPEOF(ri.SEC_RANGE))'' => 0,
           le.SEC_RANGE = ri.SEC_RANGE  => le.SEC_RANGE_weight100,
           SALT33.HyphenMatch(le.SEC_RANGE,ri.SEC_RANGE,1)<=2 => le.SEC_RANGE_weight100*MIN(1,LENGTH(TRIM(ri.SEC_RANGE))/LENGTH(TRIM(le.SEC_RANGE))),
           -0.629*le.SEC_RANGE_weight100))/100; 
    SELF.P_CITY_NAME_match_code := MAP(le.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' OR ri.P_CITY_NAME = (TYPEOF(ri.P_CITY_NAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_P_CITY_NAME(le.P_CITY_NAME,ri.P_CITY_NAME,FALSE));
    SELF.P_CITY_NAMEWeight := (50+MAP ( le.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' OR ri.P_CITY_NAME = (TYPEOF(ri.P_CITY_NAME))'' => 0,
           le.P_CITY_NAME = ri.P_CITY_NAME  => le.P_CITY_NAME_weight100,
           -0.580*le.P_CITY_NAME_weight100))/100; 
    SELF.DOBWeight_year := (50+MAP ( le.DOB_year = 0 OR ((UNSIGNED)ri.DOB) DIV 10000 = 0 => 0,
       le.DOB_year = ((UNSIGNED)ri.DOB) DIV 10000  => le.DOB_year_weight100,
       SALT33.Fn_YearMatch(le.DOB_year,((unsigned)ri.DOB) DIV 10000,13)=> le.DOB_year_weight100-358, //YEAR_SHIFT
       -1.000*le.DOB_year_weight100))/100;
    SELF.DOBWeight_month := (50+MAP ( le.DOB_month = 0 OR ((UNSIGNED)ri.DOB) DIV 100 % 100 = 0 => 0,
      le.DOB_month = ((UNSIGNED)ri.DOB) DIV 100 % 100  => le.DOB_month_weight100,
      le.DOB_month = 1 AND le.DOB_day = 1 => -200, // SOFT1 
      le.DOB_month = ((UNSIGNED)ri.DOB) % 100 AND le.DOB_day = ((UNSIGNED)ri.DOB) DIV 100 % 100 => le.DOB_month_weight100-100, // MDDM
       -1.000*le.DOB_month_weight100))/100;
    SELF.DOBWeight_day := (50+MAP ( le.DOB_day = 0 OR ((UNSIGNED)ri.DOB) % 100 = 0 => 0,
      le.DOB_day = ((UNSIGNED)ri.DOB) % 100  => le.DOB_day_weight100,
      le.DOB_day = 1 => -200, // SOFT1 
      le.DOB_month = ((UNSIGNED)ri.DOB) % 100 AND le.DOB_day = ((UNSIGNED)ri.DOB) DIV 100 % 100 => le.DOB_day_weight100-100, // MDDM
       -1.000*le.DOB_day_weight100))/100;
    SELF.DOBWeight := (SELF.DOBWeight_year+SELF.DOBWeight_month+SELF.DOBWeight_day); 
    SELF.DOB_year_match_code := MAP(
      le.DOB_year = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT33.MatchCode.OneSideNull,
      match_methods(File_Classify_PS).match_DOB_year(le.DOB_year,((UNSIGNED)ri.DOB) DIV 10000));
    SELF.DOB_month_match_code := MAP(
      le.DOB_month = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT33.MatchCode.OneSideNull,
      match_methods(File_Classify_PS).match_DOB_month(le.DOB_month,((UNSIGNED)ri.DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)ri.DOB) % 100));
    SELF.DOB_day_match_code := MAP(
      le.DOB_day = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT33.MatchCode.OneSideNull,
      match_methods(File_Classify_PS).match_DOB_day(le.DOB_month,((UNSIGNED)ri.DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)ri.DOB) % 100));
    SELF.DOB_match_code := MAP(
      le.DOB_year+le.DOB_month+le.DOB_day = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT33.MatchCode.OneSideNull,
      SELF.DOBWeight = SELF.DOBWeight_year+SELF.DOBWeight_month+SELF.DOBWeight_day => SALT33.MatchCode.DateAggregate,
      SALT33.MatchCode.NoMatch);
    SELF.SEARCH_ADDR1_match_code := MAP(le.SEARCH_ADDR1 = (TYPEOF(le.SEARCH_ADDR1))'' OR ri.SEARCH_ADDR1 = (TYPEOF(ri.SEARCH_ADDR1))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_SEARCH_ADDR1(le.SEARCH_ADDR1,ri.SEARCH_ADDR1,FALSE));
    SELF.SEARCH_ADDR1Weight := (50+MAP ( le.SEARCH_ADDR1 = (TYPEOF(le.SEARCH_ADDR1))'' OR ri.SEARCH_ADDR1 = (TYPEOF(ri.SEARCH_ADDR1))'' => 0,
           le.SEARCH_ADDR1 = ri.SEARCH_ADDR1  => le.SEARCH_ADDR1_weight100,
           -0.424*le.SEARCH_ADDR1_weight100))/100; 
    SELF.SEARCH_ADDR2_match_code := MAP(le.SEARCH_ADDR2 = (TYPEOF(le.SEARCH_ADDR2))'' OR ri.SEARCH_ADDR2 = (TYPEOF(ri.SEARCH_ADDR2))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_SEARCH_ADDR2(le.SEARCH_ADDR2,ri.SEARCH_ADDR2,FALSE));
    SELF.SEARCH_ADDR2Weight := (50+MAP ( le.SEARCH_ADDR2 = (TYPEOF(le.SEARCH_ADDR2))'' OR ri.SEARCH_ADDR2 = (TYPEOF(ri.SEARCH_ADDR2))'' => 0,
           le.SEARCH_ADDR2 = ri.SEARCH_ADDR2  => le.SEARCH_ADDR2_weight100,
           -0.480*le.SEARCH_ADDR2_weight100))/100; 
    SELF.LEXID_match_code := MAP(le.LEXID = (TYPEOF(le.LEXID))'' OR ri.LEXID = (TYPEOF(ri.LEXID))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_LEXID(le.LEXID,ri.LEXID,FALSE));
    SELF.LEXIDWeight := (50+MAP ( le.LEXID = (TYPEOF(le.LEXID))'' OR ri.LEXID = (TYPEOF(ri.LEXID))'' => 0,
           le.LEXID = ri.LEXID  => le.LEXID_weight100,
           -0.650*le.LEXID_weight100))/100; 
    SELF.Weight := IF(le.EID_HASH = 0, 100, MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.LNAMEWeight) + MAX(0,SELF.STWeight) + MAX(0,SELF.NAME_SUFFIXWeight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.PRIM_RANGEWeight) + MAX(0,SELF.PRIM_NAMEWeight) + MAX(0,SELF.SEC_RANGEWeight) + MAX(0,SELF.P_CITY_NAMEWeight) + MAX(0,SELF.DOBWeight) + MAX(0,SELF.SEARCH_ADDR1Weight) + MAX(0,SELF.SEARCH_ADDR2Weight) + MAX(0,SELF.LEXIDWeight));
    SELF := le;
  END;
  Recs0 := Recs(FNAME <> (typeof(FNAME))'',LNAME <> (typeof(LNAME))'',ST <> (typeof(ST))'');
  SALT33.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference,Bair_ExternalLinkKeys.Config.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,LEFT.FNAME = RIGHT.FNAME
     AND LEFT.LNAME = RIGHT.LNAME
     AND LEFT.ST = RIGHT.ST
     AND ( LEFT.NAME_SUFFIX = (TYPEOF(LEFT.NAME_SUFFIX))'' OR RIGHT.NAME_SUFFIX = (TYPEOF(RIGHT.NAME_SUFFIX))'' OR LEFT.NAME_SUFFIX = RIGHT.NAME_SUFFIX  )
     AND ( LEFT.MNAME[1..LENGTH(TRIM(RIGHT.MNAME))] = RIGHT.MNAME OR RIGHT.MNAME[1..LENGTH(TRIM(LEFT.MNAME))] = LEFT.MNAME OR SALT33.WithinEditN(LEFT.MNAME,RIGHT.MNAME,2, 0)  ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.FNAME = RIGHT.FNAME
     AND LEFT.LNAME = RIGHT.LNAME
     AND LEFT.ST = RIGHT.ST,500)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),LEFT.FNAME = RIGHT.FNAME
     AND LEFT.LNAME = RIGHT.LNAME
     AND LEFT.ST = RIGHT.ST
     AND ( LEFT.NAME_SUFFIX = (TYPEOF(LEFT.NAME_SUFFIX))'' OR RIGHT.NAME_SUFFIX = (TYPEOF(RIGHT.NAME_SUFFIX))'' OR LEFT.NAME_SUFFIX = RIGHT.NAME_SUFFIX  )
     AND ( LEFT.MNAME[1..LENGTH(TRIM(RIGHT.MNAME))] = RIGHT.MNAME OR RIGHT.MNAME[1..LENGTH(TRIM(LEFT.MNAME))] = LEFT.MNAME OR SALT33.WithinEditN(LEFT.MNAME,RIGHT.MNAME,2, 0)  ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.FNAME = RIGHT.FNAME
     AND LEFT.LNAME = RIGHT.LNAME
     AND LEFT.ST = RIGHT.ST,500),HASH,HINT(unsorted_output)); // PULL used to cause non-indexed join
  J2 := PROJECT(IF(AsIndex,J0,J1),Process_PS_Layouts.update_forcefailed(LEFT));
  J3 := Process_PS_Layouts.CombineLinkpathScores(J2); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT33.MAC_Dups_Restore(J3,DD,J4,Reference,TRUE)
  RETURN J4;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_FNAME='',Input_LNAME='',Input_ST='',Input_NAME_SUFFIX='',Input_MNAME='',Input_PRIM_RANGE='',Input_PRIM_NAME='',Input_SEC_RANGE='',Input_P_CITY_NAME='',Input_DOB='',Input_SEARCH_ADDR1='',Input_SEARCH_ADDR2='',Input_LEXID='',output_file,AsIndex='true') := MACRO
IMPORT SALT33,Bair_ExternalLinkKeys;
#IF(#TEXT(Input_FNAME)<>'' AND #TEXT(Input_LNAME)<>'' AND #TEXT(Input_ST)<>'')
  #uniquename(trans)
  Bair_ExternalLinkKeys.Key_Classify_PS_NAME.InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    SELF.FNAME := (TYPEOF(SELF.FNAME))le.Input_FNAME;
    SELF.LNAME := (TYPEOF(SELF.LNAME))le.Input_LNAME;
    SELF.ST := (TYPEOF(SELF.ST))le.Input_ST;
    #IF ( #TEXT(Input_NAME_SUFFIX) <> '' )
      SELF.NAME_SUFFIX := (TYPEOF(SELF.NAME_SUFFIX))le.Input_NAME_SUFFIX;
    #END
    #IF ( #TEXT(Input_MNAME) <> '' )
      SELF.MNAME := (TYPEOF(SELF.MNAME))le.Input_MNAME;
    #END
    #IF ( #TEXT(Input_PRIM_RANGE) <> '' )
      SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))le.Input_PRIM_RANGE;
    #END
    #IF ( #TEXT(Input_PRIM_NAME) <> '' )
      SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))le.Input_PRIM_NAME;
    #END
    #IF ( #TEXT(Input_SEC_RANGE) <> '' )
      SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))le.Input_SEC_RANGE;
    #END
    #IF ( #TEXT(Input_P_CITY_NAME) <> '' )
      SELF.P_CITY_NAME := (TYPEOF(SELF.P_CITY_NAME))le.Input_P_CITY_NAME;
    #END
    #if ( #TEXT(Input_DOB) <> '' )
      self.DOB := (unsigned4)le.Input_DOB;
    #end
    #IF ( #TEXT(Input_SEARCH_ADDR1) <> '' )
      SELF.SEARCH_ADDR1 := (TYPEOF(SELF.SEARCH_ADDR1))le.Input_SEARCH_ADDR1;
    #END
    #IF ( #TEXT(Input_SEARCH_ADDR2) <> '' )
      SELF.SEARCH_ADDR2 := (TYPEOF(SELF.SEARCH_ADDR2))le.Input_SEARCH_ADDR2;
    #END
    #IF ( #TEXT(Input_LEXID) <> '' )
      SELF.LEXID := (TYPEOF(SELF.LEXID))le.Input_LEXID;
    #END
  END;
  #uniquename(p)
  %p% := PROJECT(Infile,%trans%(left));
  output_file := Bair_ExternalLinkKeys.Key_Classify_PS_NAME.ScoredFetch_Batch(%p%,AsIndex);
#ELSE
  output_file := DATASET([],Bair_ExternalLinkKeys.Process_PS_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
END;
