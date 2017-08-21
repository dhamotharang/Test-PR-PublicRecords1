IMPORT SALT37,std;
EXPORT Key_Classify_PS_SSN := MODULE
 
//POSSIBLE_SSN:?:MAINNAME:+:SEARCH_ADDR1:P_CITY_NAME:ST:DOB
EXPORT KeyName := KeyPrefix+'::'+'key::Bair_ExternalLinkKeys_V2'+'::'+Config.KeyInfix+'::EID_HASH::Refs::SSN';
 
EXPORT KeyName_sf := KeyPrefix+'::'+'key::Bair_ExternalLinkKeys_V2'+'::'+KeySuperfile+'::EID_HASH::Refs::SSN';
 
EXPORT AssignCurrentKeyToSuperFile := FileServices.AddSuperFile(KeyName_sf,KeyName);
 
EXPORT ClearKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(KeyName_sf,,TRUE),FileServices.ClearSuperFile(KeyName_sf));
SHARED h := CandidatesForKey;//The input file - distributed by EID_HASH
layout := RECORD // project out required fields
// Compulsory fields
  h.POSSIBLE_SSN;
// Optional fields
  h.EID_HASH; // The ID field
  h.FNAME_PreferredName;
  h.FNAME;
  h.MNAME;
  h.LNAME;
// Extra credit fields
  h.SEARCH_ADDR1;
  h.P_CITY_NAME;
  h.ST;
  h.DOB_year;
  h.DOB_month;
  h.DOB_day;
  h.POSSIBLE_SSN_len;
  h.FNAME_len;
  h.MNAME_len;
//Scores for various field components
  h.POSSIBLE_SSN_weight100 ; // Contains 100x the specificity
  INTEGER2 POSSIBLE_SSN_e1_Weight100 := SALT37.Min0(h.POSSIBLE_SSN_weight100 + 100*log(h.POSSIBLE_SSN_cnt/h.POSSIBLE_SSN_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.FNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_initial_char_weight100 ; // Contains 100x the specificity
  h.FNAME_p_Weight100;
  h.FNAME_e1_Weight100;
  h.FNAME_e1p_Weight100;
  h.FNAME_PreferredName_Weight100;
  h.MNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_initial_char_weight100 ; // Contains 100x the specificity
  h.MNAME_e2_Weight100;
  h.LNAME_weight100 ; // Contains 100x the specificity
  h.SEARCH_ADDR1_weight100 ; // Contains 100x the specificity
  h.P_CITY_NAME_weight100 ; // Contains 100x the specificity
  h.ST_weight100 ; // Contains 100x the specificity
  h.DOB_year_weight100; // Contains 100x the specificity
  h.DOB_month_weight100; // Contains 100x the specificity
  h.DOB_day_weight100; // Contains 100x the specificity
END;
 
s := Specificities(File_Classify_PS).Specificities[1];
 
DataForKey0 := DEDUP(SORT(TABLE(h((POSSIBLE_SSN NOT IN SET(s.nulls_POSSIBLE_SSN,POSSIBLE_SSN) AND POSSIBLE_SSN <> (TYPEOF(POSSIBLE_SSN))'')),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
SHARED DataForKey := DataForKey0;
 
EXPORT Key := INDEX(DataForKey,{DataForKey},{},KeyName_sf);
 
EXPORT BuildAll := BUILDINDEX(Key, OVERWRITE);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,EID_HASH,POSSIBLE_SSN,FNAME,MNAME,LNAME,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_SEARCH_ADDR1 := GROUP( DEDUP( SORT( Grpd, EXCEPT SEARCH_ADDR1), EXCEPT SEARCH_ADDR1));
  CntRed_SEARCH_ADDR1 := (KeyCnt-COUNT(Rem_SEARCH_ADDR1))/KeyCnt;
  Rem_P_CITY_NAME := GROUP( DEDUP( SORT( Grpd, EXCEPT P_CITY_NAME), EXCEPT P_CITY_NAME));
  CntRed_P_CITY_NAME := (KeyCnt-COUNT(Rem_P_CITY_NAME))/KeyCnt;
  Rem_ST := GROUP( DEDUP( SORT( Grpd, EXCEPT ST), EXCEPT ST));
  CntRed_ST := (KeyCnt-COUNT(Rem_ST))/KeyCnt;
  Rem_DOB := GROUP( DEDUP( SORT( Grpd, EXCEPT DOB_year,DOB_month,DOB_day), EXCEPT DOB_year,DOB_month,DOB_day));
  CntRed_DOB := (KeyCnt-COUNT(Rem_DOB))/KeyCnt;
EXPORT Shrinkage := DATASET([{'SSN','SEARCH_ADDR1',CntRed_SEARCH_ADDR1*100,CntRed_SEARCH_ADDR1*TSize},{'SSN','P_CITY_NAME',CntRed_P_CITY_NAME*100,CntRed_P_CITY_NAME*TSize},{'SSN','ST',CntRed_ST*100,CntRed_ST*TSize},{'SSN','DOB',CntRed_DOB*100,CntRed_DOB*TSize}],SALT37.ShrinkLayout);
EXPORT CanSearch(Process_PS_Layouts.InputLayout le) := le.POSSIBLE_SSN <> (TYPEOF(le.POSSIBLE_SSN))'' AND Fields.InValid_POSSIBLE_SSN((SALT37.StrType)le.POSSIBLE_SSN)=0;
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(TYPEOF(h.POSSIBLE_SSN) param_POSSIBLE_SSN = (TYPEOF(h.POSSIBLE_SSN))'',TYPEOF(h.POSSIBLE_SSN_len) param_POSSIBLE_SSN_len = (TYPEOF(h.POSSIBLE_SSN_len))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'') := 
    STEPPED( LIMIT( Key(
          KEYED(( POSSIBLE_SSN = param_POSSIBLE_SSN AND param_POSSIBLE_SSN <> (TYPEOF(POSSIBLE_SSN))''))
      AND ( (FNAME[1..LENGTH(TRIM(param_FNAME))] = param_FNAME OR param_FNAME[1..LENGTH(TRIM(FNAME))] = FNAME)  OR FNAME_PreferredName = fn_PreferredName(param_FNAME) OR metaphonelib.DMetaPhone1(FNAME)=metaphonelib.DMetaPhone1(param_FNAME) OR Config.WithinEditN(FNAME,FNAME_len,param_FNAME,param_FNAME_len,1, 0) )
        AND ( (MNAME[1..LENGTH(TRIM(param_MNAME))] = param_MNAME OR param_MNAME[1..LENGTH(TRIM(MNAME))] = MNAME) OR Config.WithinEditN(MNAME,MNAME_len,param_MNAME,param_MNAME_len,2, 0) )
        AND ( LNAME = (TYPEOF(LNAME))'' OR param_LNAME = (TYPEOF(LNAME))'' OR SALT37.MatchBagOfWords(LNAME,param_LNAME,31744,3) > Config.LNAME_Force * 100)),Config.SSN_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),EID_HASH);
 
 
EXPORT ScoredEID_HASHFetch(TYPEOF(h.POSSIBLE_SSN) param_POSSIBLE_SSN = (TYPEOF(h.POSSIBLE_SSN))'',TYPEOF(h.POSSIBLE_SSN_len) param_POSSIBLE_SSN_len = (TYPEOF(h.POSSIBLE_SSN_len))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',TYPEOF(h.SEARCH_ADDR1) param_SEARCH_ADDR1 = (TYPEOF(h.SEARCH_ADDR1))'',TYPEOF(h.P_CITY_NAME) param_P_CITY_NAME = (TYPEOF(h.P_CITY_NAME))'',TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',UNSIGNED4 param_DOB,BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetch(param_POSSIBLE_SSN,param_POSSIBLE_SSN_len,param_FNAME,param_MNAME,param_LNAME,param_FNAME_len,param_MNAME_len);
 
  Process_PS_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 10; // Set bitmap for keys used
    SELF.keys_failed := IF(le.EID_HASH = 0, 1 << 10, 0); // Set bitmap for key failed
    SELF.POSSIBLE_SSN_match_code := match_methods(File_Classify_PS).match_POSSIBLE_SSN(le.POSSIBLE_SSN,param_POSSIBLE_SSN,le.POSSIBLE_SSN_len,param_POSSIBLE_SSN_len,TRUE);
    SELF.POSSIBLE_SSNWeight := (50+MAP (
           le.POSSIBLE_SSN = param_POSSIBLE_SSN  => le.POSSIBLE_SSN_weight100,
          le.POSSIBLE_SSN = (TYPEOF(le.POSSIBLE_SSN))'' OR param_POSSIBLE_SSN = (TYPEOF(le.POSSIBLE_SSN))'' => 0,
          -0.965*le.POSSIBLE_SSN_weight100))/100; 
    SELF.FNAME_match_code := MAP(
           le.FNAME = (TYPEOF(le.FNAME))'' OR param_FNAME = (TYPEOF(param_FNAME))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_Classify_PS).match_FNAME(le.FNAME,param_FNAME,le.FNAME_len,param_FNAME_len,FALSE));
    SELF.FNAMEWeight := (50+MAP (
           le.FNAME = (TYPEOF(le.FNAME))'' OR param_FNAME = (TYPEOF(param_FNAME))'' => 0,
           le.FNAME = param_FNAME  => le.FNAME_weight100,
           le.FNAME = param_FNAME[1..LENGTH(TRIM(le.FNAME))]   =>le.FNAME_weight100,
           le.FNAME[1..LENGTH(TRIM(param_FNAME))] = param_FNAME => SALT37.Fn_Interpolate_Initial(le.FNAME,param_FNAME,le.FNAME_weight100,le.FNAME_initial_char_weight100),
           Config.WithinEditN(le.FNAME,le.FNAME_len,param_FNAME,param_FNAME_len,1, 0)  =>IF( metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(param_FNAME),le.FNAME_e1p_weight100,le.FNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(param_FNAME)  =>le.FNAME_p_weight100,
           le.FNAME_PreferredName = fn_PreferredName(param_FNAME) => le.FNAME_PreferredName_weight100,
           -0.737*le.FNAME_weight100))/100*0.80; 
    SELF.MNAME_match_code := MAP(
           le.MNAME = (TYPEOF(le.MNAME))'' OR param_MNAME = (TYPEOF(param_MNAME))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_Classify_PS).match_MNAME(le.MNAME,param_MNAME,le.MNAME_len,param_MNAME_len,FALSE));
    SELF.MNAMEWeight := (50+MAP (
           le.MNAME = (TYPEOF(le.MNAME))'' OR param_MNAME = (TYPEOF(param_MNAME))'' => 0,
           le.MNAME = param_MNAME  => le.MNAME_weight100,
           le.MNAME = param_MNAME[1..LENGTH(TRIM(le.MNAME))]   =>le.MNAME_weight100,
           le.MNAME[1..LENGTH(TRIM(param_MNAME))] = param_MNAME => SALT37.Fn_Interpolate_Initial(le.MNAME,param_MNAME,le.MNAME_weight100,le.MNAME_initial_char_weight100),
           Config.WithinEditN(le.MNAME,le.MNAME_len,param_MNAME,param_MNAME_len,2, 0)  =>le.MNAME_e2_weight100,
           -0.772*le.MNAME_weight100))/100*0.80; 
    SELF.LNAME_match_code := MAP(
           le.LNAME = (TYPEOF(le.LNAME))'' OR param_LNAME = (TYPEOF(param_LNAME))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_Classify_PS).match_LNAME(le.LNAME,param_LNAME,FALSE));
    SELF.LNAMEWeight := (50+MAP (
           le.LNAME = (TYPEOF(le.LNAME))'' OR param_LNAME = (TYPEOF(param_LNAME))'' => 0,
           le.LNAME = param_LNAME  => le.LNAME_weight100,
           SALT37.MatchBagOfWords(le.LNAME,param_LNAME,31744,3)))/100*2.00; 
    SELF.SEARCH_ADDR1_match_code := MAP(
           le.SEARCH_ADDR1 = (TYPEOF(le.SEARCH_ADDR1))'' OR param_SEARCH_ADDR1 = (TYPEOF(param_SEARCH_ADDR1))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_Classify_PS).match_SEARCH_ADDR1(le.SEARCH_ADDR1,param_SEARCH_ADDR1,FALSE));
    SELF.SEARCH_ADDR1Weight := (50+MAP (
           le.SEARCH_ADDR1 = (TYPEOF(le.SEARCH_ADDR1))'' OR param_SEARCH_ADDR1 = (TYPEOF(param_SEARCH_ADDR1))'' => 0,
           le.SEARCH_ADDR1 = param_SEARCH_ADDR1  => le.SEARCH_ADDR1_weight100,
           -0.424*le.SEARCH_ADDR1_weight100))/100; 
    SELF.P_CITY_NAME_match_code := MAP(
           le.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' OR param_P_CITY_NAME = (TYPEOF(param_P_CITY_NAME))'' => SALT37.MatchCode.OneSideNull,
           le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' OR le.ST <> param_ST => 0, // Only valid if the context variable is equal
           match_methods(File_Classify_PS).match_P_CITY_NAME(le.P_CITY_NAME,param_P_CITY_NAME,FALSE));
    SELF.P_CITY_NAMEWeight := (50+MAP (
           le.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' OR param_P_CITY_NAME = (TYPEOF(param_P_CITY_NAME))'' => 0,
           le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' OR le.ST <> param_ST => 0, // Only valid if the context variable is equal
           le.P_CITY_NAME = param_P_CITY_NAME  => le.P_CITY_NAME_weight100,
           -0.580*le.P_CITY_NAME_weight100))/100; 
    SELF.ST_match_code := MAP(
           le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_Classify_PS).match_ST(le.ST,param_ST,FALSE));
    SELF.STWeight := (50+MAP (
           le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' => 0,
           le.ST = param_ST  => le.ST_weight100,
           -0.690*le.ST_weight100))/100; 
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
      match_methods(File_Classify_PS).match_DOB_year(le.DOB_year,((UNSIGNED)param_DOB) DIV 10000));
    SELF.DOB_month_match_code := MAP(
      le.DOB_month = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT37.MatchCode.OneSideNull,
      match_methods(File_Classify_PS).match_DOB_month(le.DOB_month,((UNSIGNED)param_DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)param_DOB) % 100));
    SELF.DOB_day_match_code := MAP(
      le.DOB_day = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT37.MatchCode.OneSideNull,
      match_methods(File_Classify_PS).match_DOB_day(le.DOB_month,((UNSIGNED)param_DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)param_DOB) % 100));
    SELF.DOB_match_code := MAP(
      le.DOB_year+le.DOB_month+le.DOB_day = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT37.MatchCode.OneSideNull,
      SELF.DOBWeight = SELF.DOBWeight_year+SELF.DOBWeight_month+SELF.DOBWeight_day => SALT37.MatchCode.DateAggregate,
      SALT37.MatchCode.NoMatch);
    SELF.Weight := IF(le.EID_HASH = 0, 100, MAX(0,SELF.POSSIBLE_SSNWeight) + MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.LNAMEWeight) + MAX(0,SELF.SEARCH_ADDR1Weight) + MAX(0,SELF.P_CITY_NAMEWeight) + MAX(0,SELF.STWeight) + MAX(0,SELF.DOBWeight));
    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));
  result1 := PROJECT(result0, Process_PS_Layouts.update_forcefailed(LEFT,param_disableForce));
  result2 := ROLLUP(result1,LEFT.EID_HASH = RIGHT.EID_HASH,Process_PS_Layouts.combine_scores(LEFT,RIGHT,param_disableForce));
  RETURN result2;
END;
 
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT37.UIDType Reference;//How to recognize this record in the subsequent
  TYPEOF(h.POSSIBLE_SSN) POSSIBLE_SSN := (TYPEOF(h.POSSIBLE_SSN))'';
  TYPEOF(h.POSSIBLE_SSN_len) POSSIBLE_SSN_len := (TYPEOF(h.POSSIBLE_SSN_len))'';
  SALT37.StrType MAINNAME := (SALT37.StrType)'';
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))'';
  TYPEOF(h.FNAME_len) FNAME_len := (TYPEOF(h.FNAME_len))'';
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))'';
  TYPEOF(h.MNAME_len) MNAME_len := (TYPEOF(h.MNAME_len))'';
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))'';
  TYPEOF(h.SEARCH_ADDR1) SEARCH_ADDR1 := (TYPEOF(h.SEARCH_ADDR1))'';
  TYPEOF(h.P_CITY_NAME) P_CITY_NAME := (TYPEOF(h.P_CITY_NAME))'';
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))'';
  unsigned4 DOB := 0;
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex, BOOLEAN In_disableForce = FALSE) := FUNCTION
 
  Process_PS_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 10; // Set bitmap for keys used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.POSSIBLE_SSN_match_code := match_methods(File_Classify_PS).match_POSSIBLE_SSN(le.POSSIBLE_SSN,ri.POSSIBLE_SSN,le.POSSIBLE_SSN_len,ri.POSSIBLE_SSN_len,TRUE);
    SELF.POSSIBLE_SSNWeight := (50+MAP (
           le.POSSIBLE_SSN = ri.POSSIBLE_SSN  => le.POSSIBLE_SSN_weight100,
          le.POSSIBLE_SSN = (TYPEOF(le.POSSIBLE_SSN))'' OR ri.POSSIBLE_SSN = (TYPEOF(le.POSSIBLE_SSN))'' => 0,
          -0.965*le.POSSIBLE_SSN_weight100))/100; 
    SELF.FNAME_match_code := MAP(
           le.FNAME = (TYPEOF(le.FNAME))'' OR ri.FNAME = (TYPEOF(ri.FNAME))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_Classify_PS).match_FNAME(le.FNAME,ri.FNAME,le.FNAME_len,ri.FNAME_len,FALSE));
    SELF.FNAMEWeight := (50+MAP (
           le.FNAME = (TYPEOF(le.FNAME))'' OR ri.FNAME = (TYPEOF(ri.FNAME))'' => 0,
           le.FNAME = ri.FNAME  => le.FNAME_weight100,
           le.FNAME = ri.FNAME[1..LENGTH(TRIM(le.FNAME))]   =>le.FNAME_weight100,
           le.FNAME[1..LENGTH(TRIM(ri.FNAME))] = ri.FNAME => SALT37.Fn_Interpolate_Initial(le.FNAME,ri.FNAME,le.FNAME_weight100,le.FNAME_initial_char_weight100),
           Config.WithinEditN(le.FNAME,le.FNAME_len,ri.FNAME,ri.FNAME_len,1, 0)  =>IF( metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(ri.FNAME),le.FNAME_e1p_weight100,le.FNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(ri.FNAME)  =>le.FNAME_p_weight100,
           le.FNAME_PreferredName = fn_PreferredName(ri.FNAME) => le.FNAME_PreferredName_weight100,
           -0.737*le.FNAME_weight100))/100*0.80; 
    SELF.MNAME_match_code := MAP(
           le.MNAME = (TYPEOF(le.MNAME))'' OR ri.MNAME = (TYPEOF(ri.MNAME))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_Classify_PS).match_MNAME(le.MNAME,ri.MNAME,le.MNAME_len,ri.MNAME_len,FALSE));
    SELF.MNAMEWeight := (50+MAP (
           le.MNAME = (TYPEOF(le.MNAME))'' OR ri.MNAME = (TYPEOF(ri.MNAME))'' => 0,
           le.MNAME = ri.MNAME  => le.MNAME_weight100,
           le.MNAME = ri.MNAME[1..LENGTH(TRIM(le.MNAME))]   =>le.MNAME_weight100,
           le.MNAME[1..LENGTH(TRIM(ri.MNAME))] = ri.MNAME => SALT37.Fn_Interpolate_Initial(le.MNAME,ri.MNAME,le.MNAME_weight100,le.MNAME_initial_char_weight100),
           Config.WithinEditN(le.MNAME,le.MNAME_len,ri.MNAME,ri.MNAME_len,2, 0)  =>le.MNAME_e2_weight100,
           -0.772*le.MNAME_weight100))/100*0.80; 
    SELF.LNAME_match_code := MAP(
           le.LNAME = (TYPEOF(le.LNAME))'' OR ri.LNAME = (TYPEOF(ri.LNAME))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_Classify_PS).match_LNAME(le.LNAME,ri.LNAME,FALSE));
    SELF.LNAMEWeight := (50+MAP (
           le.LNAME = (TYPEOF(le.LNAME))'' OR ri.LNAME = (TYPEOF(ri.LNAME))'' => 0,
           le.LNAME = ri.LNAME  => le.LNAME_weight100,
           SALT37.MatchBagOfWords(le.LNAME,ri.LNAME,31744,3)))/100*2.00; 
    SELF.SEARCH_ADDR1_match_code := MAP(
           le.SEARCH_ADDR1 = (TYPEOF(le.SEARCH_ADDR1))'' OR ri.SEARCH_ADDR1 = (TYPEOF(ri.SEARCH_ADDR1))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_Classify_PS).match_SEARCH_ADDR1(le.SEARCH_ADDR1,ri.SEARCH_ADDR1,FALSE));
    SELF.SEARCH_ADDR1Weight := (50+MAP (
           le.SEARCH_ADDR1 = (TYPEOF(le.SEARCH_ADDR1))'' OR ri.SEARCH_ADDR1 = (TYPEOF(ri.SEARCH_ADDR1))'' => 0,
           le.SEARCH_ADDR1 = ri.SEARCH_ADDR1  => le.SEARCH_ADDR1_weight100,
           -0.424*le.SEARCH_ADDR1_weight100))/100; 
    SELF.P_CITY_NAME_match_code := MAP(
           le.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' OR ri.P_CITY_NAME = (TYPEOF(ri.P_CITY_NAME))'' => SALT37.MatchCode.OneSideNull,
           le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' OR le.ST <> ri.ST => 0, // Only valid if the context variable is equal
           match_methods(File_Classify_PS).match_P_CITY_NAME(le.P_CITY_NAME,ri.P_CITY_NAME,FALSE));
    SELF.P_CITY_NAMEWeight := (50+MAP (
           le.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' OR ri.P_CITY_NAME = (TYPEOF(ri.P_CITY_NAME))'' => 0,
           le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' OR le.ST <> ri.ST => 0, // Only valid if the context variable is equal
           le.P_CITY_NAME = ri.P_CITY_NAME  => le.P_CITY_NAME_weight100,
           -0.580*le.P_CITY_NAME_weight100))/100; 
    SELF.ST_match_code := MAP(
           le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_Classify_PS).match_ST(le.ST,ri.ST,FALSE));
    SELF.STWeight := (50+MAP (
           le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' => 0,
           le.ST = ri.ST  => le.ST_weight100,
           -0.690*le.ST_weight100))/100; 
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
      match_methods(File_Classify_PS).match_DOB_year(le.DOB_year,((UNSIGNED)ri.DOB) DIV 10000));
    SELF.DOB_month_match_code := MAP(
      le.DOB_month = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT37.MatchCode.OneSideNull,
      match_methods(File_Classify_PS).match_DOB_month(le.DOB_month,((UNSIGNED)ri.DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)ri.DOB) % 100));
    SELF.DOB_day_match_code := MAP(
      le.DOB_day = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT37.MatchCode.OneSideNull,
      match_methods(File_Classify_PS).match_DOB_day(le.DOB_month,((UNSIGNED)ri.DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)ri.DOB) % 100));
    SELF.DOB_match_code := MAP(
      le.DOB_year+le.DOB_month+le.DOB_day = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT37.MatchCode.OneSideNull,
      SELF.DOBWeight = SELF.DOBWeight_year+SELF.DOBWeight_month+SELF.DOBWeight_day => SALT37.MatchCode.DateAggregate,
      SALT37.MatchCode.NoMatch);
    SELF.Weight := IF(le.EID_HASH = 0, 100, MAX(0,SELF.POSSIBLE_SSNWeight) + MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.LNAMEWeight) + MAX(0,SELF.SEARCH_ADDR1Weight) + MAX(0,SELF.P_CITY_NAMEWeight) + MAX(0,SELF.STWeight) + MAX(0,SELF.DOBWeight));
    SELF := le;
  END;
  Recs0 := Recs(POSSIBLE_SSN <> (TYPEOF(POSSIBLE_SSN))'');
  SALT37.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference,Config.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,LEFT.POSSIBLE_SSN = RIGHT.POSSIBLE_SSN
     AND (( ((LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME OR RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME ) OR metaphonelib.DMetaPhone1(LEFT.FNAME)=metaphonelib.DMetaPhone1(RIGHT.FNAME) OR Bair_ExternalLinkKeys_V2.Config.WithinEditN(LEFT.FNAME,LEFT.FNAME_len,RIGHT.FNAME,RIGHT.FNAME_len,1, 0)  OR RIGHT.FNAME_PreferredName = fn_PreferredName(LEFT.FNAME) ) AND ((LEFT.MNAME[1..LENGTH(TRIM(RIGHT.MNAME))] = RIGHT.MNAME OR RIGHT.MNAME[1..LENGTH(TRIM(LEFT.MNAME))] = LEFT.MNAME )OR Bair_ExternalLinkKeys_V2.Config.WithinEditN(LEFT.MNAME,LEFT.MNAME_len,RIGHT.MNAME,RIGHT.MNAME_len,2, 0) ) AND (LEFT.LNAME = (TYPEOF(LEFT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR SALT37.MatchBagOfWords(LEFT.LNAME,RIGHT.LNAME,31744,3) > Bair_ExternalLinkKeys_V2.Config.LNAME_Force * 100) )),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.POSSIBLE_SSN = RIGHT.POSSIBLE_SSN,Config.SSN_MAXBLOCKSIZE)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),LEFT.POSSIBLE_SSN = RIGHT.POSSIBLE_SSN
     AND (( ((LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME OR RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME ) OR metaphonelib.DMetaPhone1(LEFT.FNAME)=metaphonelib.DMetaPhone1(RIGHT.FNAME) OR Bair_ExternalLinkKeys_V2.Config.WithinEditN(LEFT.FNAME,LEFT.FNAME_len,RIGHT.FNAME,RIGHT.FNAME_len,1, 0)  OR RIGHT.FNAME_PreferredName = fn_PreferredName(LEFT.FNAME) ) AND ((LEFT.MNAME[1..LENGTH(TRIM(RIGHT.MNAME))] = RIGHT.MNAME OR RIGHT.MNAME[1..LENGTH(TRIM(LEFT.MNAME))] = LEFT.MNAME )OR Bair_ExternalLinkKeys_V2.Config.WithinEditN(LEFT.MNAME,LEFT.MNAME_len,RIGHT.MNAME,RIGHT.MNAME_len,2, 0) ) AND (LEFT.LNAME = (TYPEOF(LEFT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR SALT37.MatchBagOfWords(LEFT.LNAME,RIGHT.LNAME,31744,3) > Bair_ExternalLinkKeys_V2.Config.LNAME_Force * 100) )),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.POSSIBLE_SSN = RIGHT.POSSIBLE_SSN,Config.SSN_MAXBLOCKSIZE),HASH,UNORDERED); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := PROJECT(J2, Process_PS_Layouts.update_forcefailed(LEFT,In_disableForce));
  J4 := Process_PS_Layouts.CombineLinkpathScores(J3,In_disableForce); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT37.MAC_Dups_Restore(J4,DD,J5,Reference,TRUE)
  RETURN J5;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_POSSIBLE_SSN='',Input_FNAME='',Input_MNAME='',Input_LNAME='',Input_SEARCH_ADDR1='',Input_P_CITY_NAME='',Input_ST='',Input_DOB='',output_file,AsIndex='true', In_disableForce = 'false') := MACRO
IMPORT SALT37,Bair_ExternalLinkKeys_V2;
#IF(#TEXT(Input_POSSIBLE_SSN)<>'')
  #uniquename(trans)
  Bair_ExternalLinkKeys_V2.Key_Classify_PS_SSN.InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    SELF.POSSIBLE_SSN := (TYPEOF(SELF.POSSIBLE_SSN))le.Input_POSSIBLE_SSN;
    SELF.POSSIBLE_SSN_len := LENGTH(TRIM((TYPEOF(SELF.POSSIBLE_SSN))le.Input_POSSIBLE_SSN));
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
    #END
    #IF ( #TEXT(Input_SEARCH_ADDR1) <> '' )
      SELF.SEARCH_ADDR1 := (TYPEOF(SELF.SEARCH_ADDR1))le.Input_SEARCH_ADDR1;
    #END
    #IF ( #TEXT(Input_P_CITY_NAME) <> '' )
      SELF.P_CITY_NAME := (TYPEOF(SELF.P_CITY_NAME))le.Input_P_CITY_NAME;
    #END
    #IF ( #TEXT(Input_ST) <> '' )
      SELF.ST := (TYPEOF(SELF.ST))le.Input_ST;
    #END
    #if ( #TEXT(Input_DOB) <> '' )
      self.DOB := (unsigned4)le.Input_DOB;
    #end
  END;
  #uniquename(p)
  %p% := PROJECT(Infile,%trans%(left));
  output_file := Bair_ExternalLinkKeys_V2.Key_Classify_PS_SSN.ScoredFetch_Batch(%p%,AsIndex, In_disableForce);
#ELSE
  output_file := DATASET([],Bair_ExternalLinkKeys_V2.Process_PS_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
END;
