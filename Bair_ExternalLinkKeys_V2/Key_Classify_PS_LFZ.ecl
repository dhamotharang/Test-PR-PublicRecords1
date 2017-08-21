IMPORT SALT37,std;
EXPORT Key_Classify_PS_LFZ := MODULE
 
//LNAME:FNAME:?:ZIP:+:P_CITY_NAME:PRIM_RANGE:PRIM_NAME:MNAME:SEC_RANGE:NAME_SUFFIX:DOB:ST
EXPORT KeyName := KeyPrefix+'::'+'key::Bair_ExternalLinkKeys_V2'+'::'+Config.KeyInfix+'::EID_HASH::Refs::LFZ';
 
EXPORT KeyName_sf := KeyPrefix+'::'+'key::Bair_ExternalLinkKeys_V2'+'::'+KeySuperfile+'::EID_HASH::Refs::LFZ';
 
EXPORT AssignCurrentKeyToSuperFile := FileServices.AddSuperFile(KeyName_sf,KeyName);
 
EXPORT ClearKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(KeyName_sf,,TRUE),FileServices.ClearSuperFile(KeyName_sf));
SHARED h := CandidatesForKey;//The input file - distributed by EID_HASH
layout := RECORD // project out required fields
// Compulsory fields
  UNSIGNED4 GSS_hash := 0; // A 'nominal' to allow this record to be treated as a pseudo-inversion
  h.FNAME;
// Optional fields
  h.EID_HASH; // The ID field
  h.ZIP;
// Extra credit fields
  h.P_CITY_NAME;
  h.PRIM_RANGE;
  h.PRIM_NAME;
  h.MNAME;
  h.SEC_RANGE;
  h.NAME_SUFFIX;
  h.DOB_year;
  h.DOB_month;
  h.DOB_day;
  h.ST;
  UNSIGNED2 GSS_word_weight := 0; // Weight for just the word in the hash
  //Required in project to allow later processing
  h.LNAME;
  UNSIGNED8 gss_bloom := SALT37.Fn_Wordbag_To_Bloom(h.LNAME); // To allow pruning of positives from rawfetch
  h.FNAME_len;
  h.PRIM_RANGE_len;
  h.PRIM_NAME_len;
  h.MNAME_len;
//Scores for various field components
  h.FNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_initial_char_weight100 ; // Contains 100x the specificity
  h.FNAME_p_Weight100;
  h.FNAME_e1_Weight100;
  h.FNAME_e1p_Weight100;
  h.FNAME_PreferredName_Weight100;
  h.ZIP_weight100 ; // Contains 100x the specificity
  h.P_CITY_NAME_weight100 ; // Contains 100x the specificity
  h.PRIM_RANGE_weight100 ; // Contains 100x the specificity
  INTEGER2 PRIM_RANGE_e1_Weight100 := SALT37.Min0(h.PRIM_RANGE_weight100 + 100*log(h.PRIM_RANGE_cnt/h.PRIM_RANGE_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.PRIM_NAME_weight100 ; // Contains 100x the specificity
  INTEGER2 PRIM_NAME_e1_Weight100 := SALT37.Min0(h.PRIM_NAME_weight100 + 100*log(h.PRIM_NAME_cnt/h.PRIM_NAME_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.MNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_initial_char_weight100 ; // Contains 100x the specificity
  h.MNAME_e2_Weight100;
  h.SEC_RANGE_weight100 ; // Contains 100x the specificity
  h.NAME_SUFFIX_weight100 ; // Contains 100x the specificity
  h.DOB_year_weight100; // Contains 100x the specificity
  h.DOB_month_weight100; // Contains 100x the specificity
  h.DOB_day_weight100; // Contains 100x the specificity
  h.ST_weight100 ; // Contains 100x the specificity
END;
 
s := Specificities(File_Classify_PS).Specificities[1];
 
DataForKey0 := DEDUP(SORT(TABLE(h((LNAME NOT IN SET(s.nulls_LNAME,LNAME) AND LNAME <> (TYPEOF(LNAME))''),(FNAME NOT IN SET(s.nulls_FNAME,FNAME) AND FNAME <> (TYPEOF(FNAME))'')),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
// Now need to 'blow out' the fixed word-bag fields to create the pseudo-inversion
SALT37.mac_expand_wordbag_key(DataForKey0,GSS_hash,LNAME,DataForKey1,GSS_word_weight)
DataForKey2 := DEDUP(SORT(DataForKey1,WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Can remove wordbag fields now
SHARED DataForKey := DataForKey2;
 
EXPORT Key := INDEX(DataForKey,{DataForKey},{},KeyName_sf);
 
EXPORT BuildAll := BUILDINDEX(Key, OVERWRITE);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,EID_HASH,LNAME,FNAME,ZIP,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_P_CITY_NAME := GROUP( DEDUP( SORT( Grpd, EXCEPT P_CITY_NAME), EXCEPT P_CITY_NAME));
  CntRed_P_CITY_NAME := (KeyCnt-COUNT(Rem_P_CITY_NAME))/KeyCnt;
  Rem_PRIM_RANGE := GROUP( DEDUP( SORT( Grpd, EXCEPT PRIM_RANGE), EXCEPT PRIM_RANGE));
  CntRed_PRIM_RANGE := (KeyCnt-COUNT(Rem_PRIM_RANGE))/KeyCnt;
  Rem_PRIM_NAME := GROUP( DEDUP( SORT( Grpd, EXCEPT PRIM_NAME), EXCEPT PRIM_NAME));
  CntRed_PRIM_NAME := (KeyCnt-COUNT(Rem_PRIM_NAME))/KeyCnt;
  Rem_MNAME := GROUP( DEDUP( SORT( Grpd, EXCEPT MNAME), EXCEPT MNAME));
  CntRed_MNAME := (KeyCnt-COUNT(Rem_MNAME))/KeyCnt;
  Rem_SEC_RANGE := GROUP( DEDUP( SORT( Grpd, EXCEPT SEC_RANGE), EXCEPT SEC_RANGE));
  CntRed_SEC_RANGE := (KeyCnt-COUNT(Rem_SEC_RANGE))/KeyCnt;
  Rem_NAME_SUFFIX := GROUP( DEDUP( SORT( Grpd, EXCEPT NAME_SUFFIX), EXCEPT NAME_SUFFIX));
  CntRed_NAME_SUFFIX := (KeyCnt-COUNT(Rem_NAME_SUFFIX))/KeyCnt;
  Rem_DOB := GROUP( DEDUP( SORT( Grpd, EXCEPT DOB_year,DOB_month,DOB_day), EXCEPT DOB_year,DOB_month,DOB_day));
  CntRed_DOB := (KeyCnt-COUNT(Rem_DOB))/KeyCnt;
  Rem_ST := GROUP( DEDUP( SORT( Grpd, EXCEPT ST), EXCEPT ST));
  CntRed_ST := (KeyCnt-COUNT(Rem_ST))/KeyCnt;
EXPORT Shrinkage := DATASET([{'LFZ','P_CITY_NAME',CntRed_P_CITY_NAME*100,CntRed_P_CITY_NAME*TSize},{'LFZ','PRIM_RANGE',CntRed_PRIM_RANGE*100,CntRed_PRIM_RANGE*TSize},{'LFZ','PRIM_NAME',CntRed_PRIM_NAME*100,CntRed_PRIM_NAME*TSize},{'LFZ','MNAME',CntRed_MNAME*100,CntRed_MNAME*TSize},{'LFZ','SEC_RANGE',CntRed_SEC_RANGE*100,CntRed_SEC_RANGE*TSize},{'LFZ','NAME_SUFFIX',CntRed_NAME_SUFFIX*100,CntRed_NAME_SUFFIX*TSize},{'LFZ','DOB',CntRed_DOB*100,CntRed_DOB*TSize},{'LFZ','ST',CntRed_ST*100,CntRed_ST*TSize}],SALT37.ShrinkLayout);
EXPORT CanSearch(Process_PS_Layouts.InputLayout le) := le.LNAME <> (TYPEOF(le.LNAME))'' AND Fields.InValid_LNAME((SALT37.StrType)le.LNAME)=0 AND le.FNAME <> (TYPEOF(le.FNAME))'' AND Fields.InValid_FNAME((SALT37.StrType)le.FNAME)=0;
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.ZIP) param_ZIP = (TYPEOF(h.ZIP))'') := 
  FUNCTION
 //Generate service attributes for GSS join
    wds := SALT37.fn_string_to_wordstream(param_LNAME);
    indexOutputRecord := RECORDOF(Key);
    slimrec := { Key.gss_word_weight, Key.EID_HASH };
    BloomF := SALT37.Fn_Wordbag_To_Bloom(param_LNAME); // Use for extra index filtering
    doIndexRead(UNSIGNED4 search,UNSIGNED2 spc) := STEPPED(KEY( KEYED(GSS_hash = search) AND (GSS_bloom & BloomF) = BloomF
      AND KEYED(( FNAME = param_FNAME AND param_FNAME <> (TYPEOF(FNAME))''))
      AND ( ZIP = (TYPEOF(ZIP))'' OR param_ZIP = (TYPEOF(ZIP))'' OR ZIP = param_ZIP )),EID_HASH,PRIORITY(40-spc)); // Filter for each row of index fetch
    SALT37.MAC_collate_wordbag_matches1(wds,slimrec,doIndexRead,EID_HASH,steppedmatches) // Perform N-way join
    res := JOIN( steppedmatches, Key, KEYED(RIGHT.GSS_Hash = wds[1].hsh)
      AND KEYED(( RIGHT.FNAME = param_FNAME AND param_FNAME <> (TYPEOF(RIGHT.FNAME))'')) AND KEYED(LEFT.EID_HASH = RIGHT.EID_HASH),TRANSFORM(indexOutputRecord,SELF.gss_word_weight := LEFT.gss_word_weight,SELF := RIGHT));
    RETURN IF(SUM(wds,spec) > 7,res,IF(SUM(wds,spec) = 0,DATASET([],indexOutputRecord) ,DATASET(ROW([],indexOutputRecord)))); // Ensure at least spc of specificity in gss portion
  END;
 
EXPORT ScoredEID_HASHFetch(TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.ZIP) param_ZIP = (TYPEOF(h.ZIP))'',TYPEOF(h.P_CITY_NAME) param_P_CITY_NAME = (TYPEOF(h.P_CITY_NAME))'',TYPEOF(h.PRIM_RANGE) param_PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',TYPEOF(h.PRIM_RANGE_len) param_PRIM_RANGE_len = (TYPEOF(h.PRIM_RANGE_len))'',TYPEOF(h.PRIM_NAME) param_PRIM_NAME = (TYPEOF(h.PRIM_NAME))'',TYPEOF(h.PRIM_NAME_len) param_PRIM_NAME_len = (TYPEOF(h.PRIM_NAME_len))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',TYPEOF(h.SEC_RANGE) param_SEC_RANGE = (TYPEOF(h.SEC_RANGE))'',TYPEOF(h.NAME_SUFFIX) param_NAME_SUFFIX = (TYPEOF(h.NAME_SUFFIX))'',UNSIGNED4 param_DOB,TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetch(param_LNAME,param_FNAME,param_FNAME_len,param_ZIP);
 
  Process_PS_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 7; // Set bitmap for keys used
    SELF.keys_failed := IF(le.EID_HASH = 0, 1 << 7, 0); // Set bitmap for key failed
    SELF.LNAME_match_code := match_methods(File_Classify_PS).match_LNAME(le.LNAME,param_LNAME,TRUE);
    SELF.LNAMEWeight :=   le.gss_word_weight*2.00; //Fixed Wordbag weights accumulated in gss_weight field
  SELF.LNAME_GSS_Weight := le.gss_word_weight;// MORE - need to scale in independence
  SELF.LNAME_gss_cases := DATASET([{le.gss_hash}],SALT37.layout_GSS_cases);
    SELF.FNAME_match_code := match_methods(File_Classify_PS).match_FNAME(le.FNAME,param_FNAME,le.FNAME_len,param_FNAME_len,TRUE);
    SELF.FNAMEWeight := (50+MAP (
           le.FNAME = param_FNAME  => le.FNAME_weight100,
          le.FNAME = (TYPEOF(le.FNAME))'' OR param_FNAME = (TYPEOF(le.FNAME))'' => 0,
          -0.737*le.FNAME_weight100))/100*0.80; 
    SELF.ZIP_match_code := MAP(
           le.ZIP = (TYPEOF(le.ZIP))'' OR param_ZIP = (TYPEOF(param_ZIP))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_Classify_PS).match_ZIP(le.ZIP,param_ZIP,FALSE));
    SELF.ZIPWeight := (50+MAP (
           le.ZIP = (TYPEOF(le.ZIP))'' OR param_ZIP = (TYPEOF(param_ZIP))'' => 0,
           le.ZIP = param_ZIP  => le.ZIP_weight100,
           -1.000*le.ZIP_weight100))/100; 
    SELF.P_CITY_NAME_match_code := MAP(
           le.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' OR param_P_CITY_NAME = (TYPEOF(param_P_CITY_NAME))'' => SALT37.MatchCode.OneSideNull,
           le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' OR le.ST <> param_ST => 0, // Only valid if the context variable is equal
           match_methods(File_Classify_PS).match_P_CITY_NAME(le.P_CITY_NAME,param_P_CITY_NAME,FALSE));
    SELF.P_CITY_NAMEWeight := (50+MAP (
           le.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' OR param_P_CITY_NAME = (TYPEOF(param_P_CITY_NAME))'' => 0,
           le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' OR le.ST <> param_ST => 0, // Only valid if the context variable is equal
           le.P_CITY_NAME = param_P_CITY_NAME  => le.P_CITY_NAME_weight100,
           -0.580*le.P_CITY_NAME_weight100))/100; 
    SELF.PRIM_RANGE_match_code := MAP(
           le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR param_PRIM_RANGE = (TYPEOF(param_PRIM_RANGE))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_Classify_PS).match_PRIM_RANGE(le.PRIM_RANGE,param_PRIM_RANGE,le.PRIM_RANGE_len,param_PRIM_RANGE_len,FALSE));
    SELF.PRIM_RANGEWeight := (50+MAP (
           le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR param_PRIM_RANGE = (TYPEOF(param_PRIM_RANGE))'' => 0,
           le.PRIM_RANGE = param_PRIM_RANGE  => le.PRIM_RANGE_weight100,
           Config.WithinEditN(le.PRIM_RANGE,le.PRIM_RANGE_len,param_PRIM_RANGE,param_PRIM_RANGE_len,1, 0)  =>le.PRIM_RANGE_e1_weight100,
           -0.537*le.PRIM_RANGE_weight100))/100; 
    SELF.PRIM_NAME_match_code := MAP(
           le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR param_PRIM_NAME = (TYPEOF(param_PRIM_NAME))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_Classify_PS).match_PRIM_NAME(le.PRIM_NAME,param_PRIM_NAME,le.PRIM_NAME_len,param_PRIM_NAME_len,FALSE));
    SELF.PRIM_NAMEWeight := (50+MAP (
           le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR param_PRIM_NAME = (TYPEOF(param_PRIM_NAME))'' => 0,
           le.PRIM_NAME = param_PRIM_NAME  => le.PRIM_NAME_weight100,
           Config.WithinEditN(le.PRIM_NAME,le.PRIM_NAME_len,param_PRIM_NAME,param_PRIM_NAME_len,1, 0)  =>le.PRIM_NAME_e1_weight100,
           -0.531*le.PRIM_NAME_weight100))/100; 
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
    SELF.SEC_RANGE_match_code := MAP(
           le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR param_SEC_RANGE = (TYPEOF(param_SEC_RANGE))'' => SALT37.MatchCode.OneSideNull,
           le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR param_PRIM_NAME = (TYPEOF(param_PRIM_NAME))'' OR le.PRIM_NAME <> param_PRIM_NAME => 0, // Only valid if the context variable is equal
           match_methods(File_Classify_PS).match_SEC_RANGE(le.SEC_RANGE,param_SEC_RANGE,FALSE));
    SELF.SEC_RANGEWeight := (50+MAP (
           le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR param_SEC_RANGE = (TYPEOF(param_SEC_RANGE))'' => 0,
           le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR param_PRIM_NAME = (TYPEOF(param_PRIM_NAME))'' OR le.PRIM_NAME <> param_PRIM_NAME => 0, // Only valid if the context variable is equal
           le.SEC_RANGE = param_SEC_RANGE  => le.SEC_RANGE_weight100,
           SALT37.HyphenMatch(le.SEC_RANGE,param_SEC_RANGE,1)<=2  =>le.SEC_RANGE_weight100*MIN(1,LENGTH(TRIM(param_SEC_RANGE))/LENGTH(TRIM(le.SEC_RANGE))),
           -0.629*le.SEC_RANGE_weight100))/100; 
    SELF.NAME_SUFFIX_match_code := MAP(
           le.NAME_SUFFIX = (TYPEOF(le.NAME_SUFFIX))'' OR param_NAME_SUFFIX = (TYPEOF(param_NAME_SUFFIX))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_Classify_PS).match_NAME_SUFFIX(le.NAME_SUFFIX,param_NAME_SUFFIX,FALSE));
    SELF.NAME_SUFFIXWeight := (50+MAP (
           le.NAME_SUFFIX = (TYPEOF(le.NAME_SUFFIX))'' OR param_NAME_SUFFIX = (TYPEOF(param_NAME_SUFFIX))'' => 0,
           le.NAME_SUFFIX = param_NAME_SUFFIX  => le.NAME_SUFFIX_weight100,
           -0.946*le.NAME_SUFFIX_weight100))/100; 
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
    SELF.Weight := IF(le.EID_HASH = 0, 100, MAX(0,SELF.LNAMEWeight) + MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.ZIPWeight) + MAX(0,SELF.P_CITY_NAMEWeight) + MAX(0,SELF.PRIM_RANGEWeight) + MAX(0,SELF.PRIM_NAMEWeight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.SEC_RANGEWeight) + MAX(0,SELF.NAME_SUFFIXWeight) + MAX(0,SELF.DOBWeight));
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
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))'';
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))'';
  TYPEOF(h.FNAME_len) FNAME_len := (TYPEOF(h.FNAME_len))'';
  TYPEOF(h.ZIP) ZIP := (TYPEOF(h.ZIP))'';
  TYPEOF(h.P_CITY_NAME) P_CITY_NAME := (TYPEOF(h.P_CITY_NAME))'';
  TYPEOF(h.PRIM_RANGE) PRIM_RANGE := (TYPEOF(h.PRIM_RANGE))'';
  TYPEOF(h.PRIM_RANGE_len) PRIM_RANGE_len := (TYPEOF(h.PRIM_RANGE_len))'';
  TYPEOF(h.PRIM_NAME) PRIM_NAME := (TYPEOF(h.PRIM_NAME))'';
  TYPEOF(h.PRIM_NAME_len) PRIM_NAME_len := (TYPEOF(h.PRIM_NAME_len))'';
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))'';
  TYPEOF(h.MNAME_len) MNAME_len := (TYPEOF(h.MNAME_len))'';
  TYPEOF(h.SEC_RANGE) SEC_RANGE := (TYPEOF(h.SEC_RANGE))'';
  TYPEOF(h.NAME_SUFFIX) NAME_SUFFIX := (TYPEOF(h.NAME_SUFFIX))'';
  unsigned4 DOB := 0;
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex, BOOLEAN In_disableForce = FALSE) := FUNCTION
 
  Process_PS_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 7; // Set bitmap for keys used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.LNAME_match_code := match_methods(File_Classify_PS).match_LNAME(le.LNAME,ri.LNAME,TRUE);
    SELF.LNAMEWeight := IF(SALT37.MatchBagOfWords(le.LNAME,ri.LNAME,31744,3)<=Config.LNAME_force,SKIP,SALT37.MatchBagOfWords(le.LNAME,ri.LNAME,31744,3)/100)*2.00; 
    SELF.FNAME_match_code := match_methods(File_Classify_PS).match_FNAME(le.FNAME,ri.FNAME,le.FNAME_len,ri.FNAME_len,TRUE);
    SELF.FNAMEWeight := (50+MAP (
           le.FNAME = ri.FNAME  => le.FNAME_weight100,
          le.FNAME = (TYPEOF(le.FNAME))'' OR ri.FNAME = (TYPEOF(le.FNAME))'' => 0,
          -0.737*le.FNAME_weight100))/100*0.80; 
    SELF.ZIP_match_code := MAP(
           le.ZIP = (TYPEOF(le.ZIP))'' OR ri.ZIP = (TYPEOF(ri.ZIP))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_Classify_PS).match_ZIP(le.ZIP,ri.ZIP,FALSE));
    SELF.ZIPWeight := (50+MAP (
           le.ZIP = (TYPEOF(le.ZIP))'' OR ri.ZIP = (TYPEOF(ri.ZIP))'' => 0,
           le.ZIP = ri.ZIP  => le.ZIP_weight100,
           -1.000*le.ZIP_weight100))/100; 
    SELF.P_CITY_NAME_match_code := MAP(
           le.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' OR ri.P_CITY_NAME = (TYPEOF(ri.P_CITY_NAME))'' => SALT37.MatchCode.OneSideNull,
           le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' OR le.ST <> ri.ST => 0, // Only valid if the context variable is equal
           match_methods(File_Classify_PS).match_P_CITY_NAME(le.P_CITY_NAME,ri.P_CITY_NAME,FALSE));
    SELF.P_CITY_NAMEWeight := (50+MAP (
           le.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' OR ri.P_CITY_NAME = (TYPEOF(ri.P_CITY_NAME))'' => 0,
           le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' OR le.ST <> ri.ST => 0, // Only valid if the context variable is equal
           le.P_CITY_NAME = ri.P_CITY_NAME  => le.P_CITY_NAME_weight100,
           -0.580*le.P_CITY_NAME_weight100))/100; 
    SELF.PRIM_RANGE_match_code := MAP(
           le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR ri.PRIM_RANGE = (TYPEOF(ri.PRIM_RANGE))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_Classify_PS).match_PRIM_RANGE(le.PRIM_RANGE,ri.PRIM_RANGE,le.PRIM_RANGE_len,ri.PRIM_RANGE_len,FALSE));
    SELF.PRIM_RANGEWeight := (50+MAP (
           le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR ri.PRIM_RANGE = (TYPEOF(ri.PRIM_RANGE))'' => 0,
           le.PRIM_RANGE = ri.PRIM_RANGE  => le.PRIM_RANGE_weight100,
           Config.WithinEditN(le.PRIM_RANGE,le.PRIM_RANGE_len,ri.PRIM_RANGE,ri.PRIM_RANGE_len,1, 0)  =>le.PRIM_RANGE_e1_weight100,
           -0.537*le.PRIM_RANGE_weight100))/100; 
    SELF.PRIM_NAME_match_code := MAP(
           le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR ri.PRIM_NAME = (TYPEOF(ri.PRIM_NAME))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_Classify_PS).match_PRIM_NAME(le.PRIM_NAME,ri.PRIM_NAME,le.PRIM_NAME_len,ri.PRIM_NAME_len,FALSE));
    SELF.PRIM_NAMEWeight := (50+MAP (
           le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR ri.PRIM_NAME = (TYPEOF(ri.PRIM_NAME))'' => 0,
           le.PRIM_NAME = ri.PRIM_NAME  => le.PRIM_NAME_weight100,
           Config.WithinEditN(le.PRIM_NAME,le.PRIM_NAME_len,ri.PRIM_NAME,ri.PRIM_NAME_len,1, 0)  =>le.PRIM_NAME_e1_weight100,
           -0.531*le.PRIM_NAME_weight100))/100; 
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
    SELF.SEC_RANGE_match_code := MAP(
           le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR ri.SEC_RANGE = (TYPEOF(ri.SEC_RANGE))'' => SALT37.MatchCode.OneSideNull,
           le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR ri.PRIM_NAME = (TYPEOF(ri.PRIM_NAME))'' OR le.PRIM_NAME <> ri.PRIM_NAME => 0, // Only valid if the context variable is equal
           match_methods(File_Classify_PS).match_SEC_RANGE(le.SEC_RANGE,ri.SEC_RANGE,FALSE));
    SELF.SEC_RANGEWeight := (50+MAP (
           le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR ri.SEC_RANGE = (TYPEOF(ri.SEC_RANGE))'' => 0,
           le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR ri.PRIM_NAME = (TYPEOF(ri.PRIM_NAME))'' OR le.PRIM_NAME <> ri.PRIM_NAME => 0, // Only valid if the context variable is equal
           le.SEC_RANGE = ri.SEC_RANGE  => le.SEC_RANGE_weight100,
           SALT37.HyphenMatch(le.SEC_RANGE,ri.SEC_RANGE,1)<=2  =>le.SEC_RANGE_weight100*MIN(1,LENGTH(TRIM(ri.SEC_RANGE))/LENGTH(TRIM(le.SEC_RANGE))),
           -0.629*le.SEC_RANGE_weight100))/100; 
    SELF.NAME_SUFFIX_match_code := MAP(
           le.NAME_SUFFIX = (TYPEOF(le.NAME_SUFFIX))'' OR ri.NAME_SUFFIX = (TYPEOF(ri.NAME_SUFFIX))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_Classify_PS).match_NAME_SUFFIX(le.NAME_SUFFIX,ri.NAME_SUFFIX,FALSE));
    SELF.NAME_SUFFIXWeight := (50+MAP (
           le.NAME_SUFFIX = (TYPEOF(le.NAME_SUFFIX))'' OR ri.NAME_SUFFIX = (TYPEOF(ri.NAME_SUFFIX))'' => 0,
           le.NAME_SUFFIX = ri.NAME_SUFFIX  => le.NAME_SUFFIX_weight100,
           -0.946*le.NAME_SUFFIX_weight100))/100; 
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
    SELF.Weight := IF(le.EID_HASH = 0, 100, MAX(0,SELF.LNAMEWeight) + MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.ZIPWeight) + MAX(0,SELF.P_CITY_NAMEWeight) + MAX(0,SELF.PRIM_RANGEWeight) + MAX(0,SELF.PRIM_NAMEWeight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.SEC_RANGEWeight) + MAX(0,SELF.NAME_SUFFIXWeight) + MAX(0,SELF.DOBWeight));
    SELF := le;
  END;
  Recs0 := Recs(LNAME <> (TYPEOF(LNAME))'',FNAME <> (TYPEOF(FNAME))'');
  SALT37.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference,Config.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,HASH32(SALT37.fn_bow_bestword(LEFT.LNAME))=RIGHT.gss_hash AND SALT37.MatchBagOfWords(LEFT.LNAME,RIGHT.LNAME,31744,3) > Bair_ExternalLinkKeys_V2.Config.LNAME_Force * 100
     AND LEFT.FNAME = RIGHT.FNAME
     AND ( LEFT.ZIP = (TYPEOF(LEFT.ZIP))'' OR RIGHT.ZIP = (TYPEOF(RIGHT.ZIP))'' OR LEFT.ZIP = RIGHT.ZIP  ),Score_Batch(RIGHT,LEFT),
    ATMOST(HASH32(SALT37.fn_bow_bestword(LEFT.LNAME))=RIGHT.gss_hash
     AND LEFT.FNAME = RIGHT.FNAME,Config.LFZ_MAXBLOCKSIZE)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),HASH32(SALT37.fn_bow_bestword(LEFT.LNAME))=RIGHT.gss_hash AND SALT37.MatchBagOfWords(LEFT.LNAME,RIGHT.LNAME,31744,3) > Bair_ExternalLinkKeys_V2.Config.LNAME_Force * 100
     AND LEFT.FNAME = RIGHT.FNAME
     AND ( LEFT.ZIP = (TYPEOF(LEFT.ZIP))'' OR RIGHT.ZIP = (TYPEOF(RIGHT.ZIP))'' OR LEFT.ZIP = RIGHT.ZIP  ),Score_Batch(RIGHT,LEFT),
    ATMOST(HASH32(SALT37.fn_bow_bestword(LEFT.LNAME))=RIGHT.gss_hash
     AND LEFT.FNAME = RIGHT.FNAME,Config.LFZ_MAXBLOCKSIZE),HASH,UNORDERED); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := PROJECT(J2, Process_PS_Layouts.update_forcefailed(LEFT,In_disableForce));
  J4 := Process_PS_Layouts.CombineLinkpathScores(J3,In_disableForce); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT37.MAC_Dups_Restore(J4,DD,J5,Reference,TRUE)
  RETURN J5;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_LNAME='',Input_FNAME='',Input_ZIP='',Input_P_CITY_NAME='',Input_PRIM_RANGE='',Input_PRIM_NAME='',Input_MNAME='',Input_SEC_RANGE='',Input_NAME_SUFFIX='',Input_DOB='',Input_ST='',output_file,AsIndex='true', In_disableForce = 'false') := MACRO
IMPORT SALT37,Bair_ExternalLinkKeys_V2;
#IF(#TEXT(Input_LNAME)<>'' AND #TEXT(Input_FNAME)<>'')
  #uniquename(trans)
  Bair_ExternalLinkKeys_V2.Key_Classify_PS_LFZ.InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    SELF.LNAME := (TYPEOF(SELF.LNAME))le.Input_LNAME;
    SELF.FNAME := (TYPEOF(SELF.FNAME))le.Input_FNAME;
    SELF.FNAME_len := LENGTH(TRIM((TYPEOF(SELF.FNAME))le.Input_FNAME));
    #IF ( #TEXT(Input_ZIP) <> '' )
      SELF.ZIP := (TYPEOF(SELF.ZIP))le.Input_ZIP;
    #END
    #IF ( #TEXT(Input_P_CITY_NAME) <> '' )
      SELF.P_CITY_NAME := (TYPEOF(SELF.P_CITY_NAME))le.Input_P_CITY_NAME;
    #END
    #IF ( #TEXT(Input_PRIM_RANGE) <> '' )
      SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))le.Input_PRIM_RANGE;
      SELF.PRIM_RANGE_len := LENGTH(TRIM((TYPEOF(SELF.PRIM_RANGE))le.Input_PRIM_RANGE));
    #END
    #IF ( #TEXT(Input_PRIM_NAME) <> '' )
      SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))le.Input_PRIM_NAME;
      SELF.PRIM_NAME_len := LENGTH(TRIM((TYPEOF(SELF.PRIM_NAME))le.Input_PRIM_NAME));
    #END
    #IF ( #TEXT(Input_MNAME) <> '' )
      SELF.MNAME := (TYPEOF(SELF.MNAME))le.Input_MNAME;
      SELF.MNAME_len := LENGTH(TRIM((TYPEOF(SELF.MNAME))le.Input_MNAME));
    #END
    #IF ( #TEXT(Input_SEC_RANGE) <> '' )
      SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))le.Input_SEC_RANGE;
    #END
    #IF ( #TEXT(Input_NAME_SUFFIX) <> '' )
      SELF.NAME_SUFFIX := (TYPEOF(SELF.NAME_SUFFIX))le.Input_NAME_SUFFIX;
    #END
    #if ( #TEXT(Input_DOB) <> '' )
      self.DOB := (unsigned4)le.Input_DOB;
    #end
    #IF ( #TEXT(Input_ST) <> '' )
      SELF.ST := (TYPEOF(SELF.ST))le.Input_ST;
    #END
  END;
  #uniquename(p)
  %p% := PROJECT(Infile,%trans%(left));
  output_file := Bair_ExternalLinkKeys_V2.Key_Classify_PS_LFZ.ScoredFetch_Batch(%p%,AsIndex, In_disableForce);
#ELSE
  output_file := DATASET([],Bair_ExternalLinkKeys_V2.Process_PS_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
END;
