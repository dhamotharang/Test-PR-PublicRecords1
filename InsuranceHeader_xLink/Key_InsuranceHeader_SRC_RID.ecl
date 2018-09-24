IMPORT SALT37,std;
EXPORT Key_InsuranceHeader_SRC_RID(BOOLEAN incremental=FALSE) := MODULE
 
//SRC:SOURCE_RID:?:FNAME:DOB:CITY:DERIVED_GENDER:SNAME:+:ST
EXPORT KeyName := KeyNames().SRC_RID_super; /*HACK10*/
 
EXPORT KeyName_sf := '~'+KeyPrefix+'::'+'key::InsuranceHeader_xLink'+'::'+KeySuperfile+'::DID::Refs::SRC_RID';
 
EXPORT AssignCurrentKeyToSuperFile := FileServices.AddSuperFile(KeyName_sf,KeyName);
 
EXPORT ClearKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(KeyName_sf,,TRUE),FileServices.ClearSuperFile(KeyName_sf));
STRING csv_fields := 'SRC,SOURCE_RID,FNAME,DOB_year,DOB_month,DOB_day,CITY,DERIVED_GENDER,SNAME,ST,DID';
SHARED h := CandidatesForKey(csv_fields,incremental);//The input file - distributed by DID
layout := RECORD // project out required fields
// Compulsory fields
  h.SRC;
  h.SOURCE_RID;
// Optional fields
  h.CITY;
  h.SNAME;
  h.DID; // The ID field
  h.FNAME_PreferredName;
  h.FNAME;
  h.DOB_year;
  h.DOB_month;
  h.DOB_day;
  h.DERIVED_GENDER;
// Extra credit fields
  h.ST;
  h.DT_EFFECTIVE_FIRST;
  h.DT_EFFECTIVE_LAST;
  h.FNAME_len;
//Scores for various field components
  h.SRC_weight100 ; // Contains 100x the specificity
  h.SOURCE_RID_weight100 ; // Contains 100x the specificity
  h.FNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_MAINNAME_fuzzy_weight100 ; // Contains 100x the specificity
  h.FNAME_initial_char_weight100 ; // Contains 100x the specificity
  h.FNAME_p_Weight100;
  h.FNAME_e1_Weight100;
  h.FNAME_e1p_Weight100;
  h.FNAME_PreferredName_Weight100;
  h.FNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.DOB_year_weight100; // Contains 100x the specificity
  h.DOB_month_weight100; // Contains 100x the specificity
  h.DOB_day_weight100; // Contains 100x the specificity
  h.CITY_weight100 ; // Contains 100x the specificity
  h.DERIVED_GENDER_weight100 ; // Contains 100x the specificity
  h.DERIVED_GENDER_initial_char_weight100 ; // Contains 100x the specificity
  h.SNAME_weight100 ; // Contains 100x the specificity
  h.ST_weight100 ; // Contains 100x the specificity
END;
 
s := Specificities(File_InsuranceHeader).Specificities[1];
 
DataForKey0 := DEDUP(SORT(TABLE(h((SRC NOT IN SET(s.nulls_SRC,SRC) AND SRC <> (TYPEOF(SRC))''),(SOURCE_RID NOT IN SET(s.nulls_SOURCE_RID,SOURCE_RID) AND SOURCE_RID <> (TYPEOF(SOURCE_RID))'')),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
SHARED DataForKey := DataForKey0;
 
EXPORT Key := INDEX(DataForKey,{DataForKey},{BOOLEAN IsIncremental := incremental},KeyName);
 
EXPORT BuildAll := BUILDINDEX(Key, OVERWRITE);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,DID,SRC,SOURCE_RID,FNAME,DOB_year,DOB_month,DOB_day,CITY,DERIVED_GENDER,SNAME,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_ST := GROUP( DEDUP( SORT( Grpd, EXCEPT ST), EXCEPT ST));
  CntRed_ST := (KeyCnt-COUNT(Rem_ST))/KeyCnt;
EXPORT Shrinkage := DATASET([{'SRC_RID','ST',CntRed_ST*100,CntRed_ST*TSize}],SALT37.ShrinkLayout);
EXPORT MergeKeyFiles(STRING superFileIn, STRING outfileName, UNSIGNED4 minDate = 0, BOOLEAN replaceExisting = FALSE) := FUNCTION
  fieldListIndex := SALT37.MAC_FieldListCSVFromDataset(DataForKey,[],',');
  fieldListPayload := 'IsIncremental';
  RETURN Process_xIDL_Layouts().MAC_GenerateMergedKey(superFileIn, outfileName, minDate, replaceExisting, fieldListIndex, fieldListPayload, 'Key');
END;
EXPORT CanSearch(Process_xIDL_Layouts().InputLayout le) := le.SRC <> (TYPEOF(le.SRC))'' AND Fields.InValid_SRC((SALT37.StrType)le.SRC)=0 AND le.SOURCE_RID <> (TYPEOF(le.SOURCE_RID))'' AND Fields.InValid_SOURCE_RID((SALT37.StrType)le.SOURCE_RID)=0;
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(TYPEOF(h.SRC) param_SRC = (TYPEOF(h.SRC))'',TYPEOF(h.SOURCE_RID) param_SOURCE_RID = (TYPEOF(h.SOURCE_RID))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',UNSIGNED4 param_DOB,TYPEOF(h.CITY) param_CITY = (TYPEOF(h.CITY))'',TYPEOF(h.DERIVED_GENDER) param_DERIVED_GENDER = (TYPEOF(h.DERIVED_GENDER))'',TYPEOF(h.SNAME) param_SNAME = (TYPEOF(h.SNAME))'') := 
    STEPPED( LIMIT( Key(
          KEYED(( SRC = param_SRC AND param_SRC <> (TYPEOF(SRC))''))
      AND KEYED(( SOURCE_RID = param_SOURCE_RID AND param_SOURCE_RID <> (TYPEOF(SOURCE_RID))''))
      AND ( (FNAME[1..LENGTH(TRIM(param_FNAME))] = param_FNAME OR param_FNAME[1..LENGTH(TRIM(FNAME))] = FNAME)  OR FNAME_PreferredName = fn_PreferredName(param_FNAME) OR metaphonelib.DMetaPhone1(FNAME)=metaphonelib.DMetaPhone1(param_FNAME) OR Config.WithinEditN(FNAME,FNAME_len,param_FNAME,param_FNAME_len,1, 0) OR Config.WildMatch(FNAME,param_FNAME,FALSE) )
      AND SALT37.MOD_DateMatch(DOB_year,DOB_month,DOB_day,param_DOB DIV 10000,param_DOB DIV 100 % 100,param_DOB % 100,true,true,13,true).NNEQ
      AND KEYED(( CITY = (TYPEOF(CITY))'' OR param_CITY = (TYPEOF(CITY))'' OR CITY = param_CITY ))
      AND ( (DERIVED_GENDER[1..LENGTH(TRIM(param_DERIVED_GENDER))] = param_DERIVED_GENDER OR param_DERIVED_GENDER[1..LENGTH(TRIM(DERIVED_GENDER))] = DERIVED_GENDER) )
      AND KEYED(( SNAME = (TYPEOF(SNAME))'' OR param_SNAME = (TYPEOF(SNAME))'' OR SNAME = param_SNAME ))),Config.SRC_RID_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),DID);
 
 
EXPORT ScoredDIDFetch(TYPEOF(h.SRC) param_SRC = (TYPEOF(h.SRC))'',TYPEOF(h.SOURCE_RID) param_SOURCE_RID = (TYPEOF(h.SOURCE_RID))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',UNSIGNED4 param_DOB,TYPEOF(h.CITY) param_CITY = (TYPEOF(h.CITY))'',TYPEOF(h.DERIVED_GENDER) param_DERIVED_GENDER = (TYPEOF(h.DERIVED_GENDER))'',TYPEOF(h.SNAME) param_SNAME = (TYPEOF(h.SNAME))'',TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetch(param_SRC,param_SOURCE_RID,param_FNAME,param_FNAME_len,param_DOB,param_CITY,param_DERIVED_GENDER,param_SNAME);
 
  Process_xIDL_Layouts().LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 8; // Set bitmap for keys used
    SELF.keys_poisoned := IF(le.DT_EFFECTIVE_LAST <> 0 AND le.IsIncremental, SELF.keys_used, 0);
    SELF.keys_failed := IF(le.DID = 0, 1 << 8, 0); // Set bitmap for key failed
    SELF.SRC_match_code := match_methods(File_InsuranceHeader).match_SRC(le.SRC,param_SRC,TRUE);
    SELF.SRCWeight := (50+MAP (
           le.SRC = param_SRC  => le.SRC_weight100,
          le.SRC = (TYPEOF(le.SRC))'' OR param_SRC = (TYPEOF(le.SRC))'' => 0,
          -0.283*le.SRC_weight100))/100; 
    SELF.SOURCE_RID_match_code := MAP(
           le.SRC = (TYPEOF(le.SRC))'' OR param_SRC = (TYPEOF(param_SRC))'' OR le.SRC <> param_SRC => 0, // Only valid if the context variable is equal
           match_methods(File_InsuranceHeader).match_SOURCE_RID(le.SOURCE_RID,param_SOURCE_RID,TRUE));
    SELF.SOURCE_RIDWeight := (50+MAP (
           le.SRC = (TYPEOF(le.SRC))'' OR param_SRC = (TYPEOF(param_SRC))'' OR le.SRC <> param_SRC => 0, // Only valid if the context variable is equal
           le.SOURCE_RID = param_SOURCE_RID  => le.SOURCE_RID_weight100,
          le.SOURCE_RID = (TYPEOF(le.SOURCE_RID))'' OR param_SOURCE_RID = (TYPEOF(le.SOURCE_RID))'' => 0,
          -0.000*le.SOURCE_RID_weight100))/100; 
    SELF.FNAME_match_code := MAP(
           le.FNAME = (TYPEOF(le.FNAME))'' OR param_FNAME = (TYPEOF(param_FNAME))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_FNAME(le.FNAME,param_FNAME,le.FNAME_len,param_FNAME_len,FALSE));
    SELF.FNAMEWeight := (50+MAP (
           le.FNAME = (TYPEOF(le.FNAME))'' OR param_FNAME = (TYPEOF(param_FNAME))'' => 0,
           le.FNAME = param_FNAME  => le.FNAME_weight100,
           le.FNAME = param_FNAME[1..LENGTH(TRIM(le.FNAME))]   =>le.FNAME_weight100,
           le.FNAME[1..LENGTH(TRIM(param_FNAME))] = param_FNAME => SALT37.Fn_Interpolate_Initial(le.FNAME,param_FNAME,le.FNAME_weight100,le.FNAME_initial_char_weight100),
           Config.WithinEditN(le.FNAME,le.FNAME_len,param_FNAME,param_FNAME_len,1, 0)  =>IF( metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(param_FNAME),le.FNAME_e1p_weight100,le.FNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(param_FNAME)  =>le.FNAME_p_weight100,
           Config.WildMatch(le.FNAME,param_FNAME,false)  =>le.FNAME_weight100 / Config.WildPenalty,
           le.FNAME_PreferredName = fn_PreferredName(param_FNAME) => le.FNAME_PreferredName_weight100,
           -0.737*le.FNAME_weight100))/100*0.80; 
    SELF.DOBWeight_year := (50+MAP ( le.DOB_year = 0 OR ((UNSIGNED)param_DOB) DIV 10000 = 0 => 0,
       le.DOB_year = ((UNSIGNED)param_DOB) DIV 10000  => le.DOB_year_weight100,
       SALT37.Fn_YearMatch(le.DOB_year,((unsigned)param_DOB) DIV 10000,13)=> le.DOB_year_weight100-358, //YEAR_SHIFT
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
      le.DOB_year = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT37.MatchCode.OneSideNull,
      match_methods(File_InsuranceHeader).match_DOB_year(le.DOB_year,((UNSIGNED)param_DOB) DIV 10000));
    SELF.DOB_month_match_code := MAP(
      le.DOB_month = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT37.MatchCode.OneSideNull,
      match_methods(File_InsuranceHeader).match_DOB_month(le.DOB_month,((UNSIGNED)param_DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)param_DOB) % 100));
    SELF.DOB_day_match_code := MAP(
      le.DOB_day = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT37.MatchCode.OneSideNull,
      match_methods(File_InsuranceHeader).match_DOB_day(le.DOB_month,((UNSIGNED)param_DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)param_DOB) % 100));
    SELF.DOB_match_code := MAP(
      le.DOB_year+le.DOB_month+le.DOB_day = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT37.MatchCode.OneSideNull,
      Config.DOB_UseGenerationForce AND le.DOB_year>0 AND (((UNSIGNED)param_DOB) DIV 10000)>0 AND ABS(le.DOB_year-((UNSIGNED)param_DOB) DIV 10000) > 13 => SALT37.MatchCode.GenerationNoMatch,
      SELF.DOBWeight = SELF.DOBWeight_year+SELF.DOBWeight_month+SELF.DOBWeight_day => SALT37.MatchCode.DateAggregate,
      SALT37.MatchCode.NoMatch);
    SELF.CITY_match_code := MAP(
           le.CITY = (TYPEOF(le.CITY))'' OR param_CITY = (TYPEOF(param_CITY))'' => SALT37.MatchCode.OneSideNull,
           le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' OR le.ST <> param_ST => 0, // Only valid if the context variable is equal
           match_methods(File_InsuranceHeader).match_CITY(le.CITY,param_CITY,FALSE));
    SELF.CITYWeight := (50+MAP (
           le.CITY = (TYPEOF(le.CITY))'' OR param_CITY = (TYPEOF(param_CITY))'' => 0,
           le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' OR le.ST <> param_ST => 0, // Only valid if the context variable is equal
           le.CITY = param_CITY  => le.CITY_weight100,
           -0.580*le.CITY_weight100))/100; 
    SELF.DERIVED_GENDER_match_code := MAP(
           le.DERIVED_GENDER = (TYPEOF(le.DERIVED_GENDER))'' OR param_DERIVED_GENDER = (TYPEOF(param_DERIVED_GENDER))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_DERIVED_GENDER(le.DERIVED_GENDER,param_DERIVED_GENDER,FALSE));
    SELF.DERIVED_GENDERWeight := (50+MAP (
           le.DERIVED_GENDER = (TYPEOF(le.DERIVED_GENDER))'' OR param_DERIVED_GENDER = (TYPEOF(param_DERIVED_GENDER))'' => 0,
           le.DERIVED_GENDER = param_DERIVED_GENDER  => le.DERIVED_GENDER_weight100,
           le.DERIVED_GENDER = param_DERIVED_GENDER[1..LENGTH(TRIM(le.DERIVED_GENDER))]   =>le.DERIVED_GENDER_weight100,
           le.DERIVED_GENDER[1..LENGTH(TRIM(param_DERIVED_GENDER))] = param_DERIVED_GENDER => SALT37.Fn_Interpolate_Initial(le.DERIVED_GENDER,param_DERIVED_GENDER,le.DERIVED_GENDER_weight100,le.DERIVED_GENDER_initial_char_weight100),
           -0.983*le.DERIVED_GENDER_weight100))/100; 
    SELF.SNAME_match_code := MAP(
           le.SNAME = (TYPEOF(le.SNAME))'' OR param_SNAME = (TYPEOF(param_SNAME))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_SNAME(le.SNAME,param_SNAME,FALSE));
    SELF.SNAMEWeight := (50+MAP (
           le.SNAME = (TYPEOF(le.SNAME))'' OR param_SNAME = (TYPEOF(param_SNAME))'' => 0,
           le.SNAME = param_SNAME  => le.SNAME_weight100,
           -0.946*le.SNAME_weight100))/100; 
    SELF.Weight := IF(le.DID = 0, 100, MAX(0,SELF.SRCWeight) + MAX(0,SELF.SOURCE_RIDWeight) + MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.DOBWeight) + MAX(0,SELF.CITYWeight) + MAX(0,SELF.DERIVED_GENDERWeight) + MAX(0,SELF.SNAMEWeight));
    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));
  result1 := PROJECT(result0, Process_xIDL_Layouts().update_forcefailed(LEFT,param_disableForce));
  result2 := ROLLUP(result1,LEFT.DID = RIGHT.DID,Process_xIDL_Layouts().combine_scores(LEFT,RIGHT,param_disableForce));
  result3 := PROJECT(result2(keys_poisoned > 0), Process_xIDL_Layouts().apply_poison(LEFT)) & result2(keys_poisoned = 0);
  RETURN result3;
END;
 
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT37.UIDType Reference;//How to recognize this record in the subsequent
  TYPEOF(h.SRC) SRC := (TYPEOF(h.SRC))'';
  TYPEOF(h.SOURCE_RID) SOURCE_RID := (TYPEOF(h.SOURCE_RID))'';
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))'';
  TYPEOF(h.FNAME_len) FNAME_len := (TYPEOF(h.FNAME_len))'';
  unsigned4 DOB := 0;
  TYPEOF(h.CITY) CITY := (TYPEOF(h.CITY))'';
  TYPEOF(h.DERIVED_GENDER) DERIVED_GENDER := (TYPEOF(h.DERIVED_GENDER))'';
  TYPEOF(h.SNAME) SNAME := (TYPEOF(h.SNAME))'';
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex, BOOLEAN In_disableForce = FALSE) := FUNCTION
 
  Process_xIDL_Layouts().LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 8; // Set bitmap for keys used
    SELF.keys_poisoned := IF(le.DT_EFFECTIVE_LAST <> 0 AND le.IsIncremental, SELF.keys_used, 0);
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.SRC_match_code := match_methods(File_InsuranceHeader).match_SRC(le.SRC,ri.SRC,TRUE);
    SELF.SRCWeight := (50+MAP (
           le.SRC = ri.SRC  => le.SRC_weight100,
          le.SRC = (TYPEOF(le.SRC))'' OR ri.SRC = (TYPEOF(le.SRC))'' => 0,
          -0.283*le.SRC_weight100))/100; 
    SELF.SOURCE_RID_match_code := MAP(
           le.SRC = (TYPEOF(le.SRC))'' OR ri.SRC = (TYPEOF(ri.SRC))'' OR le.SRC <> ri.SRC => 0, // Only valid if the context variable is equal
           match_methods(File_InsuranceHeader).match_SOURCE_RID(le.SOURCE_RID,ri.SOURCE_RID,TRUE));
    SELF.SOURCE_RIDWeight := (50+MAP (
           le.SRC = (TYPEOF(le.SRC))'' OR ri.SRC = (TYPEOF(ri.SRC))'' OR le.SRC <> ri.SRC => 0, // Only valid if the context variable is equal
           le.SOURCE_RID = ri.SOURCE_RID  => le.SOURCE_RID_weight100,
          le.SOURCE_RID = (TYPEOF(le.SOURCE_RID))'' OR ri.SOURCE_RID = (TYPEOF(le.SOURCE_RID))'' => 0,
          -0.000*le.SOURCE_RID_weight100))/100; 
    SELF.FNAME_match_code := MAP(
           le.FNAME = (TYPEOF(le.FNAME))'' OR ri.FNAME = (TYPEOF(ri.FNAME))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_FNAME(le.FNAME,ri.FNAME,le.FNAME_len,ri.FNAME_len,FALSE));
    SELF.FNAMEWeight := (50+MAP (
           le.FNAME = (TYPEOF(le.FNAME))'' OR ri.FNAME = (TYPEOF(ri.FNAME))'' => 0,
           le.FNAME = ri.FNAME  => le.FNAME_weight100,
           le.FNAME = ri.FNAME[1..LENGTH(TRIM(le.FNAME))]   =>le.FNAME_weight100,
           le.FNAME[1..LENGTH(TRIM(ri.FNAME))] = ri.FNAME => SALT37.Fn_Interpolate_Initial(le.FNAME,ri.FNAME,le.FNAME_weight100,le.FNAME_initial_char_weight100),
           Config.WithinEditN(le.FNAME,le.FNAME_len,ri.FNAME,ri.FNAME_len,1, 0)  =>IF( metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(ri.FNAME),le.FNAME_e1p_weight100,le.FNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(ri.FNAME)  =>le.FNAME_p_weight100,
           Config.WildMatch(le.FNAME,ri.FNAME,false)  =>le.FNAME_weight100 / Config.WildPenalty,
           le.FNAME_PreferredName = fn_PreferredName(ri.FNAME) => le.FNAME_PreferredName_weight100,
           -0.737*le.FNAME_weight100))/100*0.80; 
    SELF.DOBWeight_year := (50+MAP ( le.DOB_year = 0 OR ((UNSIGNED)ri.DOB) DIV 10000 = 0 => 0,
       le.DOB_year = ((UNSIGNED)ri.DOB) DIV 10000  => le.DOB_year_weight100,
       SALT37.Fn_YearMatch(le.DOB_year,((unsigned)ri.DOB) DIV 10000,13)=> le.DOB_year_weight100-358, //YEAR_SHIFT
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
      le.DOB_year = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT37.MatchCode.OneSideNull,
      match_methods(File_InsuranceHeader).match_DOB_year(le.DOB_year,((UNSIGNED)ri.DOB) DIV 10000));
    SELF.DOB_month_match_code := MAP(
      le.DOB_month = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT37.MatchCode.OneSideNull,
      match_methods(File_InsuranceHeader).match_DOB_month(le.DOB_month,((UNSIGNED)ri.DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)ri.DOB) % 100));
    SELF.DOB_day_match_code := MAP(
      le.DOB_day = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT37.MatchCode.OneSideNull,
      match_methods(File_InsuranceHeader).match_DOB_day(le.DOB_month,((UNSIGNED)ri.DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)ri.DOB) % 100));
    SELF.DOB_match_code := MAP(
      le.DOB_year+le.DOB_month+le.DOB_day = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT37.MatchCode.OneSideNull,
      Config.DOB_UseGenerationForce AND le.DOB_year>0 AND (((UNSIGNED)ri.DOB) DIV 10000)>0 AND ABS(le.DOB_year-((UNSIGNED)ri.DOB) DIV 10000) > 13 => SALT37.MatchCode.GenerationNoMatch,
      SELF.DOBWeight = SELF.DOBWeight_year+SELF.DOBWeight_month+SELF.DOBWeight_day => SALT37.MatchCode.DateAggregate,
      SALT37.MatchCode.NoMatch);
    SELF.CITY_match_code := MAP(
           le.CITY = (TYPEOF(le.CITY))'' OR ri.CITY = (TYPEOF(ri.CITY))'' => SALT37.MatchCode.OneSideNull,
           le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' OR le.ST <> ri.ST => 0, // Only valid if the context variable is equal
           match_methods(File_InsuranceHeader).match_CITY(le.CITY,ri.CITY,FALSE));
    SELF.CITYWeight := (50+MAP (
           le.CITY = (TYPEOF(le.CITY))'' OR ri.CITY = (TYPEOF(ri.CITY))'' => 0,
           le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' OR le.ST <> ri.ST => 0, // Only valid if the context variable is equal
           le.CITY = ri.CITY  => le.CITY_weight100,
           -0.580*le.CITY_weight100))/100; 
    SELF.DERIVED_GENDER_match_code := MAP(
           le.DERIVED_GENDER = (TYPEOF(le.DERIVED_GENDER))'' OR ri.DERIVED_GENDER = (TYPEOF(ri.DERIVED_GENDER))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_DERIVED_GENDER(le.DERIVED_GENDER,ri.DERIVED_GENDER,FALSE));
    SELF.DERIVED_GENDERWeight := (50+MAP (
           le.DERIVED_GENDER = (TYPEOF(le.DERIVED_GENDER))'' OR ri.DERIVED_GENDER = (TYPEOF(ri.DERIVED_GENDER))'' => 0,
           le.DERIVED_GENDER = ri.DERIVED_GENDER  => le.DERIVED_GENDER_weight100,
           le.DERIVED_GENDER = ri.DERIVED_GENDER[1..LENGTH(TRIM(le.DERIVED_GENDER))]   =>le.DERIVED_GENDER_weight100,
           le.DERIVED_GENDER[1..LENGTH(TRIM(ri.DERIVED_GENDER))] = ri.DERIVED_GENDER => SALT37.Fn_Interpolate_Initial(le.DERIVED_GENDER,ri.DERIVED_GENDER,le.DERIVED_GENDER_weight100,le.DERIVED_GENDER_initial_char_weight100),
           -0.983*le.DERIVED_GENDER_weight100))/100; 
    SELF.SNAME_match_code := MAP(
           le.SNAME = (TYPEOF(le.SNAME))'' OR ri.SNAME = (TYPEOF(ri.SNAME))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_SNAME(le.SNAME,ri.SNAME,FALSE));
    SELF.SNAMEWeight := (50+MAP (
           le.SNAME = (TYPEOF(le.SNAME))'' OR ri.SNAME = (TYPEOF(ri.SNAME))'' => 0,
           le.SNAME = ri.SNAME  => le.SNAME_weight100,
           -0.946*le.SNAME_weight100))/100; 
    SELF.Weight := IF(le.DID = 0, 100, MAX(0,SELF.SRCWeight) + MAX(0,SELF.SOURCE_RIDWeight) + MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.DOBWeight) + MAX(0,SELF.CITYWeight) + MAX(0,SELF.DERIVED_GENDERWeight) + MAX(0,SELF.SNAMEWeight));
    SELF := le;
  END;
  Recs0 := Recs(SRC <> (TYPEOF(SRC))'',SOURCE_RID <> (TYPEOF(SOURCE_RID))'');
  SALT37.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference,Config.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,LEFT.SRC = RIGHT.SRC
     AND LEFT.SOURCE_RID = RIGHT.SOURCE_RID
     AND ( (LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME OR RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME ) OR metaphonelib.DMetaPhone1(LEFT.FNAME)=metaphonelib.DMetaPhone1(RIGHT.FNAME) OR InsuranceHeader_xLink.Config.WithinEditN(LEFT.FNAME,LEFT.FNAME_len,RIGHT.FNAME,RIGHT.FNAME_len,1, 0)  OR RIGHT.FNAME_PreferredName = fn_PreferredName(LEFT.FNAME)  )
     AND SALT37.MOD_DateMatch(((UNSIGNED)LEFT.DOB DIV 10000 ),((UNSIGNED)LEFT.DOB DIV 100 % 100 ),((UNSIGNED)LEFT.DOB % 100),RIGHT.DOB_year,RIGHT.DOB_month,RIGHT.DOB_day,true,true,13,true,0,0).NNEQ
     AND ( LEFT.CITY = (TYPEOF(LEFT.CITY))'' OR RIGHT.CITY = (TYPEOF(RIGHT.CITY))'' OR LEFT.CITY = RIGHT.CITY  )
     AND ( (LEFT.DERIVED_GENDER[1..LENGTH(TRIM(RIGHT.DERIVED_GENDER))] = RIGHT.DERIVED_GENDER OR RIGHT.DERIVED_GENDER[1..LENGTH(TRIM(LEFT.DERIVED_GENDER))] = LEFT.DERIVED_GENDER ) )
     AND ( LEFT.SNAME = (TYPEOF(LEFT.SNAME))'' OR RIGHT.SNAME = (TYPEOF(RIGHT.SNAME))'' OR LEFT.SNAME = RIGHT.SNAME  ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.SRC = RIGHT.SRC
     AND LEFT.SOURCE_RID = RIGHT.SOURCE_RID,Config.SRC_RID_MAXBLOCKSIZE)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),LEFT.SRC = RIGHT.SRC
     AND LEFT.SOURCE_RID = RIGHT.SOURCE_RID
     AND ( (LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME OR RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME ) OR metaphonelib.DMetaPhone1(LEFT.FNAME)=metaphonelib.DMetaPhone1(RIGHT.FNAME) OR InsuranceHeader_xLink.Config.WithinEditN(LEFT.FNAME,LEFT.FNAME_len,RIGHT.FNAME,RIGHT.FNAME_len,1, 0)  OR RIGHT.FNAME_PreferredName = fn_PreferredName(LEFT.FNAME)  )
     AND SALT37.MOD_DateMatch(((UNSIGNED)LEFT.DOB DIV 10000 ),((UNSIGNED)LEFT.DOB DIV 100 % 100 ),((UNSIGNED)LEFT.DOB % 100),RIGHT.DOB_year,RIGHT.DOB_month,RIGHT.DOB_day,true,true,13,true,0,0).NNEQ
     AND ( LEFT.CITY = (TYPEOF(LEFT.CITY))'' OR RIGHT.CITY = (TYPEOF(RIGHT.CITY))'' OR LEFT.CITY = RIGHT.CITY  )
     AND ( (LEFT.DERIVED_GENDER[1..LENGTH(TRIM(RIGHT.DERIVED_GENDER))] = RIGHT.DERIVED_GENDER OR RIGHT.DERIVED_GENDER[1..LENGTH(TRIM(LEFT.DERIVED_GENDER))] = LEFT.DERIVED_GENDER ) )
     AND ( LEFT.SNAME = (TYPEOF(LEFT.SNAME))'' OR RIGHT.SNAME = (TYPEOF(RIGHT.SNAME))'' OR LEFT.SNAME = RIGHT.SNAME  ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.SRC = RIGHT.SRC
     AND LEFT.SOURCE_RID = RIGHT.SOURCE_RID,Config.SRC_RID_MAXBLOCKSIZE),HASH,UNORDERED); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := PROJECT(J2, Process_xIDL_Layouts().update_forcefailed(LEFT,In_disableForce));
  J4 := Process_xIDL_Layouts().CombineLinkpathScores(J3,In_disableForce); // Combine results and restrict number for one linkpath
  J5 := PROJECT(J4(keys_poisoned > 0), Process_xIDL_Layouts().apply_poison(LEFT)) & J4(keys_poisoned = 0);
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT37.MAC_Dups_Restore(J5,DD,J6,Reference,TRUE)
  RETURN J6;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_SRC='',Input_SOURCE_RID='',Input_FNAME='',Input_DOB='',Input_CITY='',Input_DERIVED_GENDER='',Input_SNAME='',Input_ST='',output_file,AsIndex='true', In_disableForce = 'false') := MACRO
IMPORT SALT37,InsuranceHeader_xLink;
#IF(#TEXT(Input_SRC)<>'' AND #TEXT(Input_SOURCE_RID)<>'')
  #uniquename(trans)
  InsuranceHeader_xLink.Key_InsuranceHeader_SRC_RID().InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    SELF.SRC := (TYPEOF(SELF.SRC))le.Input_SRC;
    SELF.SOURCE_RID := (TYPEOF(SELF.SOURCE_RID))le.Input_SOURCE_RID;
    #IF ( #TEXT(Input_FNAME) <> '' )
      SELF.FNAME := (TYPEOF(SELF.FNAME))le.Input_FNAME;
      SELF.FNAME_len := LENGTH(TRIM((TYPEOF(SELF.FNAME))le.Input_FNAME));
    #END
    #if ( #TEXT(Input_DOB) <> '' )
      self.DOB := (unsigned4)le.Input_DOB;
    #end
    #IF ( #TEXT(Input_CITY) <> '' )
      SELF.CITY := (TYPEOF(SELF.CITY))le.Input_CITY;
    #END
    #IF ( #TEXT(Input_DERIVED_GENDER) <> '' )
      SELF.DERIVED_GENDER := (TYPEOF(SELF.DERIVED_GENDER))le.Input_DERIVED_GENDER;
    #END
    #IF ( #TEXT(Input_SNAME) <> '' )
      SELF.SNAME := (TYPEOF(SELF.SNAME))le.Input_SNAME;
    #END
    #IF ( #TEXT(Input_ST) <> '' )
      SELF.ST := (TYPEOF(SELF.ST))le.Input_ST;
    #END
  END;
  #uniquename(p)
  %p% := PROJECT(Infile,%trans%(left));
  output_file := InsuranceHeader_xLink.Key_InsuranceHeader_SRC_RID().ScoredFetch_Batch(%p%,AsIndex, In_disableForce);
#ELSE
  output_file := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
END;
