IMPORT SALT33,ut,std;
EXPORT Key_Classify_PS_ADDRESS1 := MODULE
 
//PRIM_NAME:P_CITY_NAME:ST:?:PRIM_RANGE:LNAME:FNAME:+:SEC_RANGE:ZIP:DOB
 
EXPORT KeyName := KeyPrefix+'::'+'key::Bair_ExternalLinkKeys'+'::'+Config.KeyInfix+'::EID_HASH::Refs::ADDRESS1';
 
EXPORT KeyName_sf := KeyPrefix+'::'+'key::Bair_ExternalLinkKeys'+'::'+KeySuperfile+'::EID_HASH::Refs::ADDRESS1';
 
EXPORT AssignCurrentKeyToSuperFile := FileServices.AddSuperFile(KeyName_sf,KeyName);
 
EXPORT ClearKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(KeyName_sf,,TRUE),FileServices.ClearSuperFile(KeyName_sf));
SHARED h := CandidatesForKey;//The input file - distributed by EID_HASH
layout := RECORD // project out required fields
// Compulsory fields
  h.PRIM_NAME;
  h.P_CITY_NAME;
  h.ST;
// Optional fields
  h.EID_HASH; // The ID field
  h.PRIM_RANGE;
  h.LNAME;
  h.FNAME_PreferredName;
  h.FNAME;
// Extra credit fields
  h.SEC_RANGE;
  h.ZIP;
  h.DOB_year;
  h.DOB_month;
  h.DOB_day;
//Scores for various field components
  h.PRIM_NAME_weight100 ; // Contains 100x the specificity
  INTEGER2 PRIM_NAME_e1_Weight100 := SALT33.Min0(h.PRIM_NAME_weight100 + 100*log(h.PRIM_NAME_cnt/h.PRIM_NAME_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.P_CITY_NAME_weight100 ; // Contains 100x the specificity
  h.ST_weight100 ; // Contains 100x the specificity
  h.PRIM_RANGE_weight100 ; // Contains 100x the specificity
  INTEGER2 PRIM_RANGE_e1_Weight100 := SALT33.Min0(h.PRIM_RANGE_weight100 + 100*log(h.PRIM_RANGE_cnt/h.PRIM_RANGE_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.LNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_p_Weight100;
  h.LNAME_e1_Weight100;
  h.LNAME_e1p_Weight100;
  h.LNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.FNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_initial_char_weight100 ; // Contains 100x the specificity
  h.FNAME_p_Weight100;
  h.FNAME_e1_Weight100;
  h.FNAME_e1p_Weight100;
  h.FNAME_PreferredName_Weight100;
  h.FNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.SEC_RANGE_weight100 ; // Contains 100x the specificity
  h.ZIP_weight100 ; // Contains 100x the specificity
  h.DOB_year_weight100; // Contains 100x the specificity
  h.DOB_month_weight100; // Contains 100x the specificity
  h.DOB_day_weight100; // Contains 100x the specificity
END;
 
s := Specificities(File_Classify_PS).Specificities[1];
 
DataForKey0 := DEDUP(SORT(TABLE(h((PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME) AND PRIM_NAME <> (TYPEOF(PRIM_NAME))''),(P_CITY_NAME NOT IN SET(s.nulls_P_CITY_NAME,P_CITY_NAME) AND P_CITY_NAME <> (TYPEOF(P_CITY_NAME))''),(ST NOT IN SET(s.nulls_ST,ST) AND ST <> (TYPEOF(ST))'')),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
 
EXPORT Key := INDEX(DataForKey0,,KeyName_sf);
 
EXPORT BuildAll := BUILDINDEX(Key, OVERWRITE);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,EID_HASH,PRIM_NAME,P_CITY_NAME,ST,PRIM_RANGE,LNAME,FNAME,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_SEC_RANGE := GROUP( DEDUP( SORT( Grpd, EXCEPT SEC_RANGE), EXCEPT SEC_RANGE));
  CntRed_SEC_RANGE := (KeyCnt-COUNT(Rem_SEC_RANGE))/KeyCnt;
  Rem_ZIP := GROUP( DEDUP( SORT( Grpd, EXCEPT ZIP), EXCEPT ZIP));
  CntRed_ZIP := (KeyCnt-COUNT(Rem_ZIP))/KeyCnt;
  Rem_DOB := GROUP( DEDUP( SORT( Grpd, EXCEPT DOB_year,DOB_month,DOB_day), EXCEPT DOB_year,DOB_month,DOB_day));
  CntRed_DOB := (KeyCnt-COUNT(Rem_DOB))/KeyCnt;
EXPORT Shrinkage := DATASET([{'ADDRESS1','SEC_RANGE',CntRed_SEC_RANGE*100,CntRed_SEC_RANGE*TSize},{'ADDRESS1','ZIP',CntRed_ZIP*100,CntRed_ZIP*TSize},{'ADDRESS1','DOB',CntRed_DOB*100,CntRed_DOB*TSize}],SALT33.ShrinkLayout);
EXPORT CanSearch(Process_PS_Layouts.InputLayout le) := le.PRIM_NAME <> (typeof(le.PRIM_NAME))'' AND le.P_CITY_NAME <> (typeof(le.P_CITY_NAME))'' AND le.ST <> (typeof(le.ST))'';
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(TYPEOF(h.PRIM_NAME) param_PRIM_NAME = (TYPEOF(h.PRIM_NAME))'',TYPEOF(h.P_CITY_NAME) param_P_CITY_NAME = (TYPEOF(h.P_CITY_NAME))'',TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',TYPEOF(h.PRIM_RANGE) param_PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'') := 
    STEPPED( LIMIT( Key(
          KEYED(( PRIM_NAME = param_PRIM_NAME AND param_PRIM_NAME <> (TYPEOF(PRIM_NAME))''))
      AND KEYED(( P_CITY_NAME = param_P_CITY_NAME AND param_P_CITY_NAME <> (TYPEOF(P_CITY_NAME))''))
      AND KEYED(( ST = param_ST AND param_ST <> (TYPEOF(ST))''))
      AND ( PRIM_RANGE = (TYPEOF(PRIM_RANGE))'' OR param_PRIM_RANGE = (TYPEOF(PRIM_RANGE))'' OR SALT33.WithinEditN(PRIM_RANGE,param_PRIM_RANGE,1, 0) )
      AND ( LNAME = (TYPEOF(LNAME))'' OR param_LNAME = (TYPEOF(LNAME))'' OR metaphonelib.DMetaPhone1(LNAME)=metaphonelib.DMetaPhone1(param_LNAME) OR SALT33.WithinEditN(LNAME,param_LNAME,1, 0) OR SALT33.HyphenMatch(LNAME,param_LNAME,1)<=2 )
      AND ( FNAME[1..LENGTH(TRIM(param_FNAME))] = param_FNAME OR param_FNAME[1..LENGTH(TRIM(FNAME))] = FNAME  OR FNAME_PreferredName = fn_PreferredName(param_FNAME) OR metaphonelib.DMetaPhone1(FNAME)=metaphonelib.DMetaPhone1(param_FNAME) OR SALT33.WithinEditN(FNAME,param_FNAME,1, 0) )),5000,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),EID_HASH);
 
 
EXPORT ScoredEID_HASHFetch(TYPEOF(h.PRIM_NAME) param_PRIM_NAME = (TYPEOF(h.PRIM_NAME))'',TYPEOF(h.P_CITY_NAME) param_P_CITY_NAME = (TYPEOF(h.P_CITY_NAME))'',TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',TYPEOF(h.PRIM_RANGE) param_PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.SEC_RANGE) param_SEC_RANGE = (TYPEOF(h.SEC_RANGE))'',TYPEOF(h.ZIP) param_ZIP = (TYPEOF(h.ZIP))'',UNSIGNED4 param_DOB) := FUNCTION
  RawData := RawFetch(param_PRIM_NAME,param_P_CITY_NAME,param_ST,param_PRIM_RANGE,param_LNAME,param_FNAME);
 
  Process_PS_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 3; // Set bitmap for key used
    SELF.keys_failed := IF(le.EID_HASH = 0, 1 << 3, 0); // Set bitmap for key failed
    SELF.PRIM_NAME_match_code := MAP(le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_PRIM_NAME(le.PRIM_NAME,param_PRIM_NAME,0,0,TRUE));
    SELF.PRIM_NAMEWeight := (50+MAP ( le.PRIM_NAME = param_PRIM_NAME  => le.PRIM_NAME_weight100,
          le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR param_PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' => 0,
          -0.531*le.PRIM_NAME_weight100))/100; 
    SELF.P_CITY_NAME_match_code := MAP(le.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' OR le.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_P_CITY_NAME(le.P_CITY_NAME,param_P_CITY_NAME,TRUE));
    SELF.P_CITY_NAMEWeight := (50+MAP ( le.P_CITY_NAME = param_P_CITY_NAME  => le.P_CITY_NAME_weight100,
          le.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' OR param_P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' => 0,
          -0.580*le.P_CITY_NAME_weight100))/100; 
    SELF.ST_match_code := MAP(le.ST = (TYPEOF(le.ST))'' OR le.ST = (TYPEOF(le.ST))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_ST(le.ST,param_ST,TRUE));
    SELF.STWeight := (50+MAP ( le.ST = param_ST  => le.ST_weight100,
          le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(le.ST))'' => 0,
          -0.690*le.ST_weight100))/100; 
    SELF.PRIM_RANGE_match_code := MAP(le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR param_PRIM_RANGE = (TYPEOF(param_PRIM_RANGE))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_PRIM_RANGE(le.PRIM_RANGE,param_PRIM_RANGE,0,0,FALSE));
    SELF.PRIM_RANGEWeight := (50+MAP ( le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR param_PRIM_RANGE = (TYPEOF(param_PRIM_RANGE))'' => 0,
           le.PRIM_RANGE = param_PRIM_RANGE  => le.PRIM_RANGE_weight100,
           SALT33.WithinEditN(le.PRIM_RANGE,param_PRIM_RANGE,1, 0) => le.PRIM_RANGE_e1_weight100,
           -0.537*le.PRIM_RANGE_weight100))/100; 
    SELF.LNAME_match_code := MAP(le.LNAME = (TYPEOF(le.LNAME))'' OR param_LNAME = (TYPEOF(param_LNAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_LNAME(le.LNAME,param_LNAME,0,0,FALSE));
    SELF.LNAMEWeight := (50+MAP ( le.LNAME = (TYPEOF(le.LNAME))'' OR param_LNAME = (TYPEOF(param_LNAME))'' => 0,
           le.LNAME = param_LNAME  => le.LNAME_weight100,
           SALT33.WithinEditN(le.LNAME,param_LNAME,1, 0) => IF( metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(param_LNAME),le.LNAME_e1p_weight100,le.LNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(param_LNAME)=>le.LNAME_p_weight100,
           SALT33.HyphenMatch(le.LNAME,param_LNAME,1)<=2 => le.LNAME_weight100*MIN(1,LENGTH(TRIM(param_LNAME))/LENGTH(TRIM(le.LNAME))),
           -0.617*le.LNAME_weight100))/100*0.80; 
    SELF.FNAME_match_code := MAP(le.FNAME = (TYPEOF(le.FNAME))'' OR param_FNAME = (TYPEOF(param_FNAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_FNAME(le.FNAME,param_FNAME,0,0,FALSE));
    SELF.FNAMEWeight := (50+MAP ( le.FNAME = (TYPEOF(le.FNAME))'' OR param_FNAME = (TYPEOF(param_FNAME))'' => 0,
           le.FNAME = param_FNAME  => le.FNAME_weight100,
           le.FNAME_PreferredName = fn_PreferredName(param_FNAME) => le.FNAME_PreferredName_weight100,
           le.FNAME = param_FNAME[1..LENGTH(TRIM(le.FNAME))] => le.FNAME_weight100,
           SALT33.WithinEditN(le.FNAME,param_FNAME,1, 0) => IF( metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(param_FNAME),le.FNAME_e1p_weight100,le.FNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(param_FNAME)=>le.FNAME_p_weight100,
           le.FNAME[1..LENGTH(TRIM(param_FNAME))] = param_FNAME => SALT33.Fn_Interpolate_Initial(le.FNAME,param_FNAME,le.FNAME_weight100,le.FNAME_initial_char_weight100), // later in sequence as less accurate
           -0.737*le.FNAME_weight100))/100*0.80; 
    SELF.SEC_RANGE_match_code := MAP(le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR param_SEC_RANGE = (TYPEOF(param_SEC_RANGE))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_SEC_RANGE(le.SEC_RANGE,param_SEC_RANGE,FALSE));
    SELF.SEC_RANGEWeight := (50+MAP ( le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR param_SEC_RANGE = (TYPEOF(param_SEC_RANGE))'' => 0,
           le.SEC_RANGE = param_SEC_RANGE  => le.SEC_RANGE_weight100,
           SALT33.HyphenMatch(le.SEC_RANGE,param_SEC_RANGE,1)<=2 => le.SEC_RANGE_weight100*MIN(1,LENGTH(TRIM(param_SEC_RANGE))/LENGTH(TRIM(le.SEC_RANGE))),
           -0.629*le.SEC_RANGE_weight100))/100; 
    SELF.ZIP_match_code := MAP(le.ZIP = (TYPEOF(le.ZIP))'' OR param_ZIP = (TYPEOF(param_ZIP))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_ZIP(le.ZIP,param_ZIP,FALSE));
    SELF.ZIPWeight := (50+MAP ( le.ZIP = (TYPEOF(le.ZIP))'' OR param_ZIP = (TYPEOF(param_ZIP))'' => 0,
           le.ZIP = param_ZIP  => le.ZIP_weight100,
           -1.000*le.ZIP_weight100))/100; 
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
    SELF.Weight := IF(le.EID_HASH = 0, 100, MAX(0,SELF.PRIM_NAMEWeight) + MAX(0,SELF.P_CITY_NAMEWeight) + MAX(0,SELF.STWeight) + MAX(0,SELF.PRIM_RANGEWeight) + MAX(0,SELF.LNAMEWeight) + MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.SEC_RANGEWeight) + MAX(0,SELF.ZIPWeight) + MAX(0,SELF.DOBWeight));
    SELF := le;
  END;
  RETURN ROLLUP(PROJECT(PROJECT(NOFOLD(RawData),Score(LEFT)),Process_PS_Layouts.update_forcefailed(LEFT)),LEFT.EID_HASH = RIGHT.EID_HASH,Process_PS_Layouts.combine_scores(LEFT,RIGHT));
END;
 
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT33.UIDType Reference;//How to recognize this record in the subsequent
  TYPEOF(h.PRIM_NAME) PRIM_NAME := (TYPEOF(h.PRIM_NAME))'';
  TYPEOF(h.P_CITY_NAME) P_CITY_NAME := (TYPEOF(h.P_CITY_NAME))'';
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))'';
  TYPEOF(h.PRIM_RANGE) PRIM_RANGE := (TYPEOF(h.PRIM_RANGE))'';
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))'';
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))'';
  TYPEOF(h.SEC_RANGE) SEC_RANGE := (TYPEOF(h.SEC_RANGE))'';
  TYPEOF(h.ZIP) ZIP := (TYPEOF(h.ZIP))'';
  unsigned4 DOB := 0;
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex) := FUNCTION
 
  Process_PS_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 3; // Set bitmap for key used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.PRIM_NAME_match_code := MAP(le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_PRIM_NAME(le.PRIM_NAME,ri.PRIM_NAME,0,0,TRUE));
    SELF.PRIM_NAMEWeight := (50+MAP ( le.PRIM_NAME = ri.PRIM_NAME  => le.PRIM_NAME_weight100,
          le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR ri.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' => 0,
          -0.531*le.PRIM_NAME_weight100))/100; 
    SELF.P_CITY_NAME_match_code := MAP(le.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' OR le.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_P_CITY_NAME(le.P_CITY_NAME,ri.P_CITY_NAME,TRUE));
    SELF.P_CITY_NAMEWeight := (50+MAP ( le.P_CITY_NAME = ri.P_CITY_NAME  => le.P_CITY_NAME_weight100,
          le.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' OR ri.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' => 0,
          -0.580*le.P_CITY_NAME_weight100))/100; 
    SELF.ST_match_code := MAP(le.ST = (TYPEOF(le.ST))'' OR le.ST = (TYPEOF(le.ST))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_ST(le.ST,ri.ST,TRUE));
    SELF.STWeight := (50+MAP ( le.ST = ri.ST  => le.ST_weight100,
          le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(le.ST))'' => 0,
          -0.690*le.ST_weight100))/100; 
    SELF.PRIM_RANGE_match_code := MAP(le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR ri.PRIM_RANGE = (TYPEOF(ri.PRIM_RANGE))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_PRIM_RANGE(le.PRIM_RANGE,ri.PRIM_RANGE,0,0,FALSE));
    SELF.PRIM_RANGEWeight := (50+MAP ( le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR ri.PRIM_RANGE = (TYPEOF(ri.PRIM_RANGE))'' => 0,
           le.PRIM_RANGE = ri.PRIM_RANGE  => le.PRIM_RANGE_weight100,
           SALT33.WithinEditN(le.PRIM_RANGE,ri.PRIM_RANGE,1, 0) => le.PRIM_RANGE_e1_weight100,
           -0.537*le.PRIM_RANGE_weight100))/100; 
    SELF.LNAME_match_code := MAP(le.LNAME = (TYPEOF(le.LNAME))'' OR ri.LNAME = (TYPEOF(ri.LNAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_LNAME(le.LNAME,ri.LNAME,0,0,FALSE));
    SELF.LNAMEWeight := (50+MAP ( le.LNAME = (TYPEOF(le.LNAME))'' OR ri.LNAME = (TYPEOF(ri.LNAME))'' => 0,
           le.LNAME = ri.LNAME  => le.LNAME_weight100,
           SALT33.WithinEditN(le.LNAME,ri.LNAME,1, 0) => IF( metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(ri.LNAME),le.LNAME_e1p_weight100,le.LNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(ri.LNAME)=>le.LNAME_p_weight100,
           SALT33.HyphenMatch(le.LNAME,ri.LNAME,1)<=2 => le.LNAME_weight100*MIN(1,LENGTH(TRIM(ri.LNAME))/LENGTH(TRIM(le.LNAME))),
           -0.617*le.LNAME_weight100))/100*0.80; 
    SELF.FNAME_match_code := MAP(le.FNAME = (TYPEOF(le.FNAME))'' OR ri.FNAME = (TYPEOF(ri.FNAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_FNAME(le.FNAME,ri.FNAME,0,0,FALSE));
    SELF.FNAMEWeight := (50+MAP ( le.FNAME = (TYPEOF(le.FNAME))'' OR ri.FNAME = (TYPEOF(ri.FNAME))'' => 0,
           le.FNAME = ri.FNAME  => le.FNAME_weight100,
           le.FNAME_PreferredName = fn_PreferredName(ri.FNAME) => le.FNAME_PreferredName_weight100,
           le.FNAME = ri.FNAME[1..LENGTH(TRIM(le.FNAME))] => le.FNAME_weight100,
           SALT33.WithinEditN(le.FNAME,ri.FNAME,1, 0) => IF( metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(ri.FNAME),le.FNAME_e1p_weight100,le.FNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(ri.FNAME)=>le.FNAME_p_weight100,
           le.FNAME[1..LENGTH(TRIM(ri.FNAME))] = ri.FNAME => SALT33.Fn_Interpolate_Initial(le.FNAME,ri.FNAME,le.FNAME_weight100,le.FNAME_initial_char_weight100), // later in sequence as less accurate
           -0.737*le.FNAME_weight100))/100*0.80; 
    SELF.SEC_RANGE_match_code := MAP(le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR ri.SEC_RANGE = (TYPEOF(ri.SEC_RANGE))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_SEC_RANGE(le.SEC_RANGE,ri.SEC_RANGE,FALSE));
    SELF.SEC_RANGEWeight := (50+MAP ( le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR ri.SEC_RANGE = (TYPEOF(ri.SEC_RANGE))'' => 0,
           le.SEC_RANGE = ri.SEC_RANGE  => le.SEC_RANGE_weight100,
           SALT33.HyphenMatch(le.SEC_RANGE,ri.SEC_RANGE,1)<=2 => le.SEC_RANGE_weight100*MIN(1,LENGTH(TRIM(ri.SEC_RANGE))/LENGTH(TRIM(le.SEC_RANGE))),
           -0.629*le.SEC_RANGE_weight100))/100; 
    SELF.ZIP_match_code := MAP(le.ZIP = (TYPEOF(le.ZIP))'' OR ri.ZIP = (TYPEOF(ri.ZIP))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_ZIP(le.ZIP,ri.ZIP,FALSE));
    SELF.ZIPWeight := (50+MAP ( le.ZIP = (TYPEOF(le.ZIP))'' OR ri.ZIP = (TYPEOF(ri.ZIP))'' => 0,
           le.ZIP = ri.ZIP  => le.ZIP_weight100,
           -1.000*le.ZIP_weight100))/100; 
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
    SELF.Weight := IF(le.EID_HASH = 0, 100, MAX(0,SELF.PRIM_NAMEWeight) + MAX(0,SELF.P_CITY_NAMEWeight) + MAX(0,SELF.STWeight) + MAX(0,SELF.PRIM_RANGEWeight) + MAX(0,SELF.LNAMEWeight) + MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.SEC_RANGEWeight) + MAX(0,SELF.ZIPWeight) + MAX(0,SELF.DOBWeight));
    SELF := le;
  END;
  Recs0 := Recs(PRIM_NAME <> (typeof(PRIM_NAME))'',P_CITY_NAME <> (typeof(P_CITY_NAME))'',ST <> (typeof(ST))'');
  SALT33.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference,Bair_ExternalLinkKeys.Config.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,LEFT.PRIM_NAME = RIGHT.PRIM_NAME
     AND LEFT.P_CITY_NAME = RIGHT.P_CITY_NAME
     AND LEFT.ST = RIGHT.ST
     AND ( LEFT.PRIM_RANGE = (TYPEOF(LEFT.PRIM_RANGE))'' OR RIGHT.PRIM_RANGE = (TYPEOF(RIGHT.PRIM_RANGE))'' OR SALT33.WithinEditN(LEFT.PRIM_RANGE,RIGHT.PRIM_RANGE,1, 0)  )
     AND ( LEFT.LNAME = (TYPEOF(LEFT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR metaphonelib.DMetaPhone1(LEFT.LNAME)=metaphonelib.DMetaPhone1(RIGHT.LNAME) OR SALT33.WithinEditN(LEFT.LNAME,RIGHT.LNAME,1, 0) OR SALT33.HyphenMatch(LEFT.LNAME,RIGHT.LNAME,1)<=2  )
     AND ( LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME OR RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME OR metaphonelib.DMetaPhone1(LEFT.FNAME)=metaphonelib.DMetaPhone1(RIGHT.FNAME) OR SALT33.WithinEditN(LEFT.FNAME,RIGHT.FNAME,1, 0)  OR RIGHT.FNAME_PreferredName = fn_PreferredName(LEFT.FNAME)  ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.PRIM_NAME = RIGHT.PRIM_NAME
     AND LEFT.P_CITY_NAME = RIGHT.P_CITY_NAME
     AND LEFT.ST = RIGHT.ST,5000)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),LEFT.PRIM_NAME = RIGHT.PRIM_NAME
     AND LEFT.P_CITY_NAME = RIGHT.P_CITY_NAME
     AND LEFT.ST = RIGHT.ST
     AND ( LEFT.PRIM_RANGE = (TYPEOF(LEFT.PRIM_RANGE))'' OR RIGHT.PRIM_RANGE = (TYPEOF(RIGHT.PRIM_RANGE))'' OR SALT33.WithinEditN(LEFT.PRIM_RANGE,RIGHT.PRIM_RANGE,1, 0)  )
     AND ( LEFT.LNAME = (TYPEOF(LEFT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR metaphonelib.DMetaPhone1(LEFT.LNAME)=metaphonelib.DMetaPhone1(RIGHT.LNAME) OR SALT33.WithinEditN(LEFT.LNAME,RIGHT.LNAME,1, 0) OR SALT33.HyphenMatch(LEFT.LNAME,RIGHT.LNAME,1)<=2  )
     AND ( LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME OR RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME OR metaphonelib.DMetaPhone1(LEFT.FNAME)=metaphonelib.DMetaPhone1(RIGHT.FNAME) OR SALT33.WithinEditN(LEFT.FNAME,RIGHT.FNAME,1, 0)  OR RIGHT.FNAME_PreferredName = fn_PreferredName(LEFT.FNAME)  ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.PRIM_NAME = RIGHT.PRIM_NAME
     AND LEFT.P_CITY_NAME = RIGHT.P_CITY_NAME
     AND LEFT.ST = RIGHT.ST,5000),HASH,HINT(unsorted_output)); // PULL used to cause non-indexed join
  J2 := PROJECT(IF(AsIndex,J0,J1),Process_PS_Layouts.update_forcefailed(LEFT));
  J3 := Process_PS_Layouts.CombineLinkpathScores(J2); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT33.MAC_Dups_Restore(J3,DD,J4,Reference,TRUE)
  RETURN J4;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_PRIM_NAME='',Input_P_CITY_NAME='',Input_ST='',Input_PRIM_RANGE='',Input_LNAME='',Input_FNAME='',Input_SEC_RANGE='',Input_ZIP='',Input_DOB='',output_file,AsIndex='true') := MACRO
IMPORT SALT33,Bair_ExternalLinkKeys;
#IF(#TEXT(Input_PRIM_NAME)<>'' AND #TEXT(Input_P_CITY_NAME)<>'' AND #TEXT(Input_ST)<>'')
  #uniquename(trans)
  Bair_ExternalLinkKeys.Key_Classify_PS_ADDRESS1.InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))le.Input_PRIM_NAME;
    SELF.P_CITY_NAME := (TYPEOF(SELF.P_CITY_NAME))le.Input_P_CITY_NAME;
    SELF.ST := (TYPEOF(SELF.ST))le.Input_ST;
    #IF ( #TEXT(Input_PRIM_RANGE) <> '' )
      SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))le.Input_PRIM_RANGE;
    #END
    #IF ( #TEXT(Input_LNAME) <> '' )
      SELF.LNAME := (TYPEOF(SELF.LNAME))le.Input_LNAME;
    #END
    #IF ( #TEXT(Input_FNAME) <> '' )
      SELF.FNAME := (TYPEOF(SELF.FNAME))le.Input_FNAME;
    #END
    #IF ( #TEXT(Input_SEC_RANGE) <> '' )
      SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))le.Input_SEC_RANGE;
    #END
    #IF ( #TEXT(Input_ZIP) <> '' )
      SELF.ZIP := (TYPEOF(SELF.ZIP))le.Input_ZIP;
    #END
    #if ( #TEXT(Input_DOB) <> '' )
      self.DOB := (unsigned4)le.Input_DOB;
    #end
  END;
  #uniquename(p)
  %p% := PROJECT(Infile,%trans%(left));
  output_file := Bair_ExternalLinkKeys.Key_Classify_PS_ADDRESS1.ScoredFetch_Batch(%p%,AsIndex);
#ELSE
  output_file := DATASET([],Bair_ExternalLinkKeys.Process_PS_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
END;
