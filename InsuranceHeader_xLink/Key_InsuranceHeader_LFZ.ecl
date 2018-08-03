IMPORT SALT37,std;
EXPORT Key_InsuranceHeader_LFZ(BOOLEAN incremental=FALSE, UNSIGNED2  aBlockLimit= Config.LFZ_MAXBLOCKLIMIT) := MODULE/*HACK25*/
 
//LNAME:FNAME:ZIP:+:CITY:PRIM_RANGE:PRIM_NAME:SSN5:SSN4:MNAME:SEC_RANGE:SNAME:DOB:ST
EXPORT KeyName := KeyNames().LFZ_super; /*HACK10*/
 
EXPORT KeyName_sf := '~'+KeyPrefix+'::'+'key::InsuranceHeader_xLink'+'::'+KeySuperfile+'::DID::Refs::LFZ';
 
EXPORT AssignCurrentKeyToSuperFile := FileServices.AddSuperFile(KeyName_sf,KeyName);
 
EXPORT ClearKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(KeyName_sf,,TRUE),FileServices.ClearSuperFile(KeyName_sf));
STRING csv_fields := 'LNAME,FNAME,ZIP,CITY,PRIM_RANGE,PRIM_NAME,SSN5,SSN4,MNAME,SEC_RANGE,SNAME,DOB_year,DOB_month,DOB_day,ST,DID';
SHARED h := CandidatesForKey(csv_fields,incremental);//The input file - distributed by DID
layout := RECORD // project out required fields
// Compulsory fields
  h.LNAME;
  h.FNAME;
  h.ZIP;
  h.DID; // The ID field
// Extra credit fields
  h.CITY;
  h.PRIM_RANGE;
  h.PRIM_NAME;
  h.SSN5;
  h.SSN4;
  h.MNAME;
  h.SEC_RANGE;
  h.SNAME;
  h.DOB_year;
  h.DOB_month;
  h.DOB_day;
  h.ST;
  h.DT_EFFECTIVE_FIRST;
  h.DT_EFFECTIVE_LAST;
  h.LNAME_len;
  h.FNAME_len;
  h.PRIM_RANGE_len;
  h.PRIM_NAME_len;
  h.SSN5_len;
  h.SSN4_len;
  h.MNAME_len;
//Scores for various field components
  h.LNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_MAINNAME_fuzzy_weight100 ; // Contains 100x the specificity
  h.LNAME_p_Weight100;
  h.LNAME_e1_Weight100;
  h.LNAME_e1p_Weight100;
  h.LNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.FNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_MAINNAME_fuzzy_weight100 ; // Contains 100x the specificity
  h.FNAME_initial_char_weight100 ; // Contains 100x the specificity
  h.FNAME_p_Weight100;
  h.FNAME_e1_Weight100;
  h.FNAME_e1p_Weight100;
  h.FNAME_PreferredName_Weight100;
  h.FNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.ZIP_weight100 ; // Contains 100x the specificity
  h.CITY_weight100 ; // Contains 100x the specificity
  h.PRIM_RANGE_weight100 ; // Contains 100x the specificity
  h.PRIM_RANGE_e1_Weight100;
  h.PRIM_NAME_weight100 ; // Contains 100x the specificity
  h.PRIM_NAME_e1_Weight100;
  h.SSN5_weight100 ; // Contains 100x the specificity
  INTEGER2 SSN5_e1_Weight100 := SALT37.Min0(h.SSN5_weight100 + 100*log(h.SSN5_cnt/h.SSN5_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.SSN4_weight100 ; // Contains 100x the specificity
  INTEGER2 SSN4_e1_Weight100 := SALT37.Min0(h.SSN4_weight100 + 100*log(h.SSN4_cnt/h.SSN4_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.MNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_MAINNAME_fuzzy_weight100 ; // Contains 100x the specificity
  h.MNAME_initial_char_weight100 ; // Contains 100x the specificity
  h.MNAME_e2_Weight100;
  h.MNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.SEC_RANGE_weight100 ; // Contains 100x the specificity
  h.SNAME_weight100 ; // Contains 100x the specificity
  h.DOB_year_weight100; // Contains 100x the specificity
  h.DOB_month_weight100; // Contains 100x the specificity
  h.DOB_day_weight100; // Contains 100x the specificity
  h.ST_weight100 ; // Contains 100x the specificity
END;
 
s := Specificities(File_InsuranceHeader).Specificities[1];
 
DataForKey0 := DEDUP(SORT(TABLE(h((LNAME NOT IN SET(s.nulls_LNAME,LNAME) AND LNAME <> (TYPEOF(LNAME))''),(FNAME NOT IN SET(s.nulls_FNAME,FNAME) AND FNAME <> (TYPEOF(FNAME))''),(ZIP NOT IN SET(s.nulls_ZIP,ZIP) AND ZIP <> (TYPEOF(ZIP))'')),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
SHARED DataForKey := project(DataForKey0, transform(layout,	BOOLEAN emptyConcept :=  left.CITY = '' and 	left.PRIM_NAME = '';  
	 // 10-19 => zipweight/3 or 20 and greater => zipweight/4 
		self.ZIP_weight100 := IF (emptyConcept AND left.ZIP_weight100 >=1000 AND left.ZIP_weight100<2000,  
					left.ZIP_weight100/3, IF (emptyConcept AND left.ZIP_weight100>=2000, left.ZIP_weight100/4, left.ZIP_weight100)); 
		self := left)); /*HACK15*/
 
EXPORT Key := INDEX(DataForKey,{DataForKey},{BOOLEAN IsIncremental := incremental},KeyName);
 
EXPORT BuildAll := BUILDINDEX(Key, OVERWRITE);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,DID,LNAME,FNAME,ZIP,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_CITY := GROUP( DEDUP( SORT( Grpd, EXCEPT CITY), EXCEPT CITY));
  CntRed_CITY := (KeyCnt-COUNT(Rem_CITY))/KeyCnt;
  Rem_PRIM_RANGE := GROUP( DEDUP( SORT( Grpd, EXCEPT PRIM_RANGE), EXCEPT PRIM_RANGE));
  CntRed_PRIM_RANGE := (KeyCnt-COUNT(Rem_PRIM_RANGE))/KeyCnt;
  Rem_PRIM_NAME := GROUP( DEDUP( SORT( Grpd, EXCEPT PRIM_NAME), EXCEPT PRIM_NAME));
  CntRed_PRIM_NAME := (KeyCnt-COUNT(Rem_PRIM_NAME))/KeyCnt;
  Rem_SSN5 := GROUP( DEDUP( SORT( Grpd, EXCEPT SSN5), EXCEPT SSN5));
  CntRed_SSN5 := (KeyCnt-COUNT(Rem_SSN5))/KeyCnt;
  Rem_SSN4 := GROUP( DEDUP( SORT( Grpd, EXCEPT SSN4), EXCEPT SSN4));
  CntRed_SSN4 := (KeyCnt-COUNT(Rem_SSN4))/KeyCnt;
  Rem_MNAME := GROUP( DEDUP( SORT( Grpd, EXCEPT MNAME), EXCEPT MNAME));
  CntRed_MNAME := (KeyCnt-COUNT(Rem_MNAME))/KeyCnt;
  Rem_SEC_RANGE := GROUP( DEDUP( SORT( Grpd, EXCEPT SEC_RANGE), EXCEPT SEC_RANGE));
  CntRed_SEC_RANGE := (KeyCnt-COUNT(Rem_SEC_RANGE))/KeyCnt;
  Rem_SNAME := GROUP( DEDUP( SORT( Grpd, EXCEPT SNAME), EXCEPT SNAME));
  CntRed_SNAME := (KeyCnt-COUNT(Rem_SNAME))/KeyCnt;
  Rem_DOB := GROUP( DEDUP( SORT( Grpd, EXCEPT DOB_year,DOB_month,DOB_day), EXCEPT DOB_year,DOB_month,DOB_day));
  CntRed_DOB := (KeyCnt-COUNT(Rem_DOB))/KeyCnt;
  Rem_ST := GROUP( DEDUP( SORT( Grpd, EXCEPT ST), EXCEPT ST));
  CntRed_ST := (KeyCnt-COUNT(Rem_ST))/KeyCnt;
EXPORT Shrinkage := DATASET([{'LFZ','CITY',CntRed_CITY*100,CntRed_CITY*TSize},{'LFZ','PRIM_RANGE',CntRed_PRIM_RANGE*100,CntRed_PRIM_RANGE*TSize},{'LFZ','PRIM_NAME',CntRed_PRIM_NAME*100,CntRed_PRIM_NAME*TSize},{'LFZ','SSN5',CntRed_SSN5*100,CntRed_SSN5*TSize},{'LFZ','SSN4',CntRed_SSN4*100,CntRed_SSN4*TSize},{'LFZ','MNAME',CntRed_MNAME*100,CntRed_MNAME*TSize},{'LFZ','SEC_RANGE',CntRed_SEC_RANGE*100,CntRed_SEC_RANGE*TSize},{'LFZ','SNAME',CntRed_SNAME*100,CntRed_SNAME*TSize},{'LFZ','DOB',CntRed_DOB*100,CntRed_DOB*TSize},{'LFZ','ST',CntRed_ST*100,CntRed_ST*TSize}],SALT37.ShrinkLayout);
EXPORT MergeKeyFiles(STRING superFileIn, STRING outfileName, UNSIGNED4 minDate = 0, BOOLEAN replaceExisting = FALSE) := FUNCTION
  fieldListIndex := SALT37.MAC_FieldListCSVFromDataset(DataForKey,[],',');
  fieldListPayload := 'IsIncremental';
  RETURN Process_xIDL_Layouts().MAC_GenerateMergedKey(superFileIn, outfileName, minDate, replaceExisting, fieldListIndex, fieldListPayload, 'Key');
END;
EXPORT MAX_BLOCKLIMIT := IF (aBlockLimit=0,  Config.LFZ_MAXBLOCKLIMIT, aBlockLimit);/*HACK24a*/
EXPORT CanSearch(Process_xIDL_Layouts().InputLayout le) := le.LNAME <> (TYPEOF(le.LNAME))'' AND Fields.InValid_LNAME((SALT37.StrType)le.LNAME)=0 AND le.FNAME <> (TYPEOF(le.FNAME))'' AND Fields.InValid_FNAME((SALT37.StrType)le.FNAME)=0 AND le.ZIP <> (TYPEOF(le.ZIP))'' AND Fields.InValid_ZIP((SALT37.StrType)le.ZIP)=0;
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.ZIP) param_ZIP = (TYPEOF(h.ZIP))'') := 
    STEPPED( LIMIT( Key(
          KEYED(( LNAME = param_LNAME AND param_LNAME <> (TYPEOF(LNAME))''))
      AND KEYED(( FNAME = param_FNAME AND param_FNAME <> (TYPEOF(FNAME))''))
      AND KEYED(( ZIP = param_ZIP AND param_ZIP <> (TYPEOF(ZIP))''))),MAX_BLOCKLIMIT/*HACK24b*/,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),DID);
 
 
EXPORT ScoredDIDFetch(TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.ZIP) param_ZIP = (TYPEOF(h.ZIP))'',TYPEOF(h.CITY) param_CITY = (TYPEOF(h.CITY))'',TYPEOF(h.PRIM_RANGE) param_PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',TYPEOF(h.PRIM_RANGE_len) param_PRIM_RANGE_len = (TYPEOF(h.PRIM_RANGE_len))'',TYPEOF(h.PRIM_NAME) param_PRIM_NAME = (TYPEOF(h.PRIM_NAME))'',TYPEOF(h.PRIM_NAME_len) param_PRIM_NAME_len = (TYPEOF(h.PRIM_NAME_len))'',TYPEOF(h.SSN5) param_SSN5 = (TYPEOF(h.SSN5))'',TYPEOF(h.SSN5_len) param_SSN5_len = (TYPEOF(h.SSN5_len))'',TYPEOF(h.SSN4) param_SSN4 = (TYPEOF(h.SSN4))'',TYPEOF(h.SSN4_len) param_SSN4_len = (TYPEOF(h.SSN4_len))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',TYPEOF(h.SEC_RANGE) param_SEC_RANGE = (TYPEOF(h.SEC_RANGE))'',TYPEOF(h.SNAME) param_SNAME = (TYPEOF(h.SNAME))'',UNSIGNED4 param_DOB,TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetch(param_LNAME,param_LNAME_len,param_FNAME,param_FNAME_len,param_ZIP);
 
  Process_xIDL_Layouts().LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 11; // Set bitmap for keys used
    SELF.keys_poisoned := IF(le.DT_EFFECTIVE_LAST <> 0 AND le.IsIncremental, SELF.keys_used, 0);
    SELF.keys_failed := IF(le.DID = 0, 1 << 11, 0); // Set bitmap for key failed
    SELF.LNAME_match_code := match_methods(File_InsuranceHeader).match_LNAME(le.LNAME,param_LNAME,le.LNAME_len,param_LNAME_len,TRUE);
    SELF.LNAMEWeight := (50+MAP (
           le.LNAME = param_LNAME  => le.LNAME_weight100,
          le.LNAME = (TYPEOF(le.LNAME))'' OR param_LNAME = (TYPEOF(le.LNAME))'' => 0,
          -0.617*le.LNAME_weight100))/100*0.80; 
    SELF.FNAME_match_code := match_methods(File_InsuranceHeader).match_FNAME(le.FNAME,param_FNAME,le.FNAME_len,param_FNAME_len,TRUE);
    SELF.FNAMEWeight := (50+MAP (
           le.FNAME = param_FNAME  => le.FNAME_weight100,
          le.FNAME = (TYPEOF(le.FNAME))'' OR param_FNAME = (TYPEOF(le.FNAME))'' => 0,
          -0.737*le.FNAME_weight100))/100*0.80; 
    SELF.ZIP_match_code := match_methods(File_InsuranceHeader).match_ZIP(le.ZIP,param_ZIP,TRUE);
    SELF.ZIPWeight := (50+MAP (
           le.ZIP = param_ZIP  => le.ZIP_weight100,
          le.ZIP = (TYPEOF(le.ZIP))'' OR param_ZIP = (TYPEOF(le.ZIP))'' => 0,
          -1.000*le.ZIP_weight100))/100; 
    SELF.CITY_match_code := MAP(
           le.CITY = (TYPEOF(le.CITY))'' OR param_CITY = (TYPEOF(param_CITY))'' => SALT37.MatchCode.OneSideNull,
           le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' OR le.ST <> param_ST => 0, // Only valid if the context variable is equal
           match_methods(File_InsuranceHeader).match_CITY(le.CITY,param_CITY,FALSE));
    SELF.CITYWeight := (50+MAP (
           le.CITY = (TYPEOF(le.CITY))'' OR param_CITY = (TYPEOF(param_CITY))'' => 0,
           le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' OR le.ST <> param_ST => 0, // Only valid if the context variable is equal
           le.CITY = param_CITY  => le.CITY_weight100,
           -0.580*le.CITY_weight100))/100; 
    SELF.PRIM_RANGE_match_code := MAP(
           le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR param_PRIM_RANGE = (TYPEOF(param_PRIM_RANGE))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_PRIM_RANGE(le.PRIM_RANGE,param_PRIM_RANGE,le.PRIM_RANGE_len,param_PRIM_RANGE_len,FALSE));
    SELF.PRIM_RANGEWeight := (50+MAP (
           le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR param_PRIM_RANGE = (TYPEOF(param_PRIM_RANGE))'' => 0,
           le.PRIM_RANGE = param_PRIM_RANGE  => le.PRIM_RANGE_weight100,
           Config.WithinEditN(le.PRIM_RANGE,le.PRIM_RANGE_len,param_PRIM_RANGE,param_PRIM_RANGE_len,1, 0)  =>le.PRIM_RANGE_e1_weight100,
           Config.WildMatch(le.PRIM_RANGE,param_PRIM_RANGE,false)  =>le.PRIM_RANGE_weight100 / Config.WildPenalty,
           -0.537*le.PRIM_RANGE_weight100))/100; 
    SELF.PRIM_NAME_match_code := MAP(
           le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR param_PRIM_NAME = (TYPEOF(param_PRIM_NAME))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_PRIM_NAME(le.PRIM_NAME,param_PRIM_NAME,le.PRIM_NAME_len,param_PRIM_NAME_len,FALSE));
    SELF.PRIM_NAMEWeight := (50+MAP (
           le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR param_PRIM_NAME = (TYPEOF(param_PRIM_NAME))'' => 0,
           le.PRIM_NAME = param_PRIM_NAME  => le.PRIM_NAME_weight100,
           Config.WithinEditN(le.PRIM_NAME,le.PRIM_NAME_len,param_PRIM_NAME,param_PRIM_NAME_len,1, 0)  =>le.PRIM_NAME_e1_weight100,
           Config.WildMatch(le.PRIM_NAME,param_PRIM_NAME,false)  =>le.PRIM_NAME_weight100 / Config.WildPenalty,
           -0.531*le.PRIM_NAME_weight100))/100; 
    SELF.SSN5_match_code := MAP(
           le.SSN5 = (TYPEOF(le.SSN5))'' OR param_SSN5 = (TYPEOF(param_SSN5))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_SSN5(le.SSN5,param_SSN5,le.SSN5_len,param_SSN5_len,FALSE));
    SELF.SSN5Weight := (50+MAP (
           le.SSN5 = (TYPEOF(le.SSN5))'' OR param_SSN5 = (TYPEOF(param_SSN5))'' => 0,
           le.SSN5 = param_SSN5  => le.SSN5_weight100,
           Config.WithinEditN(le.SSN5,le.SSN5_len,param_SSN5,param_SSN5_len,1, 0)  =>le.SSN5_e1_weight100,
           -0.873*le.SSN5_weight100))/100; 
    SELF.SSN4_match_code := MAP(
           le.SSN4 = (TYPEOF(le.SSN4))'' OR param_SSN4 = (TYPEOF(param_SSN4))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_SSN4(le.SSN4,param_SSN4,le.SSN4_len,param_SSN4_len,FALSE));
    SELF.SSN4Weight := (50+MAP (
           le.SSN4 = (TYPEOF(le.SSN4))'' OR param_SSN4 = (TYPEOF(param_SSN4))'' => 0,
           le.SSN4 = param_SSN4  => le.SSN4_weight100,
           Config.WithinEditN(le.SSN4,le.SSN4_len,param_SSN4,param_SSN4_len,1, 0)  =>le.SSN4_e1_weight100,
           -0.866*le.SSN4_weight100))/100; 
    SELF.MNAME_match_code := MAP(
           le.MNAME = (TYPEOF(le.MNAME))'' OR param_MNAME = (TYPEOF(param_MNAME))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_MNAME(le.MNAME,param_MNAME,le.MNAME_len,param_MNAME_len,FALSE));
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
           match_methods(File_InsuranceHeader).match_SEC_RANGE(le.SEC_RANGE,param_SEC_RANGE,FALSE));
    SELF.SEC_RANGEWeight := (50+MAP (
           le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR param_SEC_RANGE = (TYPEOF(param_SEC_RANGE))'' => 0,
           le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR param_PRIM_NAME = (TYPEOF(param_PRIM_NAME))'' OR le.PRIM_NAME <> param_PRIM_NAME => 0, // Only valid if the context variable is equal
           le.SEC_RANGE = param_SEC_RANGE  => le.SEC_RANGE_weight100,
           SALT37.HyphenMatch(le.SEC_RANGE,param_SEC_RANGE,1)<=2  =>le.SEC_RANGE_weight100*MIN(1,LENGTH(TRIM(param_SEC_RANGE))/LENGTH(TRIM(le.SEC_RANGE))),
           -0.629*le.SEC_RANGE_weight100))/100; 
    SELF.SNAME_match_code := MAP(
           le.SNAME = (TYPEOF(le.SNAME))'' OR param_SNAME = (TYPEOF(param_SNAME))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_SNAME(le.SNAME,param_SNAME,FALSE));
    SELF.SNAMEWeight := (50+MAP (
           le.SNAME = (TYPEOF(le.SNAME))'' OR param_SNAME = (TYPEOF(param_SNAME))'' => 0,
           le.SNAME = param_SNAME  => le.SNAME_weight100,
           -0.946*le.SNAME_weight100))/100; 
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
    SELF.Weight := IF(le.DID = 0, 100, MAX(0,SELF.LNAMEWeight) + MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.ZIPWeight) + MAX(0,SELF.CITYWeight) + MAX(0,SELF.PRIM_RANGEWeight) + MAX(0,SELF.PRIM_NAMEWeight) + MAX(0,SELF.SSN5Weight) + MAX(0,SELF.SSN4Weight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.SEC_RANGEWeight) + MAX(0,SELF.SNAMEWeight) + MAX(0,SELF.DOBWeight));
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
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))'';
  TYPEOF(h.LNAME_len) LNAME_len := (TYPEOF(h.LNAME_len))'';
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))'';
  TYPEOF(h.FNAME_len) FNAME_len := (TYPEOF(h.FNAME_len))'';
  TYPEOF(h.ZIP) ZIP := (TYPEOF(h.ZIP))'';
  TYPEOF(h.CITY) CITY := (TYPEOF(h.CITY))'';
  TYPEOF(h.PRIM_RANGE) PRIM_RANGE := (TYPEOF(h.PRIM_RANGE))'';
  TYPEOF(h.PRIM_RANGE_len) PRIM_RANGE_len := (TYPEOF(h.PRIM_RANGE_len))'';
  TYPEOF(h.PRIM_NAME) PRIM_NAME := (TYPEOF(h.PRIM_NAME))'';
  TYPEOF(h.PRIM_NAME_len) PRIM_NAME_len := (TYPEOF(h.PRIM_NAME_len))'';
  TYPEOF(h.SSN5) SSN5 := (TYPEOF(h.SSN5))'';
  TYPEOF(h.SSN5_len) SSN5_len := (TYPEOF(h.SSN5_len))'';
  TYPEOF(h.SSN4) SSN4 := (TYPEOF(h.SSN4))'';
  TYPEOF(h.SSN4_len) SSN4_len := (TYPEOF(h.SSN4_len))'';
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))'';
  TYPEOF(h.MNAME_len) MNAME_len := (TYPEOF(h.MNAME_len))'';
  TYPEOF(h.SEC_RANGE) SEC_RANGE := (TYPEOF(h.SEC_RANGE))'';
  TYPEOF(h.SNAME) SNAME := (TYPEOF(h.SNAME))'';
  unsigned4 DOB := 0;
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex, BOOLEAN In_disableForce = FALSE) := FUNCTION
 
  Process_xIDL_Layouts().LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 11; // Set bitmap for keys used
    SELF.keys_poisoned := IF(le.DT_EFFECTIVE_LAST <> 0 AND le.IsIncremental, SELF.keys_used, 0);
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.LNAME_match_code := match_methods(File_InsuranceHeader).match_LNAME(le.LNAME,ri.LNAME,le.LNAME_len,ri.LNAME_len,TRUE);
    SELF.LNAMEWeight := (50+MAP (
           le.LNAME = ri.LNAME  => le.LNAME_weight100,
          le.LNAME = (TYPEOF(le.LNAME))'' OR ri.LNAME = (TYPEOF(le.LNAME))'' => 0,
          -0.617*le.LNAME_weight100))/100*0.80; 
    SELF.FNAME_match_code := match_methods(File_InsuranceHeader).match_FNAME(le.FNAME,ri.FNAME,le.FNAME_len,ri.FNAME_len,TRUE);
    SELF.FNAMEWeight := (50+MAP (
           le.FNAME = ri.FNAME  => le.FNAME_weight100,
          le.FNAME = (TYPEOF(le.FNAME))'' OR ri.FNAME = (TYPEOF(le.FNAME))'' => 0,
          -0.737*le.FNAME_weight100))/100*0.80; 
    SELF.ZIP_match_code := match_methods(File_InsuranceHeader).match_ZIP(le.ZIP,ri.ZIP,TRUE);
    SELF.ZIPWeight := (50+MAP (
           le.ZIP = ri.ZIP  => le.ZIP_weight100,
          le.ZIP = (TYPEOF(le.ZIP))'' OR ri.ZIP = (TYPEOF(le.ZIP))'' => 0,
          -1.000*le.ZIP_weight100))/100; 
    SELF.CITY_match_code := MAP(
           le.CITY = (TYPEOF(le.CITY))'' OR ri.CITY = (TYPEOF(ri.CITY))'' => SALT37.MatchCode.OneSideNull,
           le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' OR le.ST <> ri.ST => 0, // Only valid if the context variable is equal
           match_methods(File_InsuranceHeader).match_CITY(le.CITY,ri.CITY,FALSE));
    SELF.CITYWeight := (50+MAP (
           le.CITY = (TYPEOF(le.CITY))'' OR ri.CITY = (TYPEOF(ri.CITY))'' => 0,
           le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' OR le.ST <> ri.ST => 0, // Only valid if the context variable is equal
           le.CITY = ri.CITY  => le.CITY_weight100,
           -0.580*le.CITY_weight100))/100; 
    SELF.PRIM_RANGE_match_code := MAP(
           le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR ri.PRIM_RANGE = (TYPEOF(ri.PRIM_RANGE))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_PRIM_RANGE(le.PRIM_RANGE,ri.PRIM_RANGE,le.PRIM_RANGE_len,ri.PRIM_RANGE_len,FALSE));
    SELF.PRIM_RANGEWeight := (50+MAP (
           le.PRIM_RANGE = (TYPEOF(le.PRIM_RANGE))'' OR ri.PRIM_RANGE = (TYPEOF(ri.PRIM_RANGE))'' => 0,
           le.PRIM_RANGE = ri.PRIM_RANGE  => le.PRIM_RANGE_weight100,
           Config.WithinEditN(le.PRIM_RANGE,le.PRIM_RANGE_len,ri.PRIM_RANGE,ri.PRIM_RANGE_len,1, 0)  =>le.PRIM_RANGE_e1_weight100,
           Config.WildMatch(le.PRIM_RANGE,ri.PRIM_RANGE,false)  =>le.PRIM_RANGE_weight100 / Config.WildPenalty,
           -0.537*le.PRIM_RANGE_weight100))/100; 
    SELF.PRIM_NAME_match_code := MAP(
           le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR ri.PRIM_NAME = (TYPEOF(ri.PRIM_NAME))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_PRIM_NAME(le.PRIM_NAME,ri.PRIM_NAME,le.PRIM_NAME_len,ri.PRIM_NAME_len,FALSE));
    SELF.PRIM_NAMEWeight := (50+MAP (
           le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR ri.PRIM_NAME = (TYPEOF(ri.PRIM_NAME))'' => 0,
           le.PRIM_NAME = ri.PRIM_NAME  => le.PRIM_NAME_weight100,
           Config.WithinEditN(le.PRIM_NAME,le.PRIM_NAME_len,ri.PRIM_NAME,ri.PRIM_NAME_len,1, 0)  =>le.PRIM_NAME_e1_weight100,
           Config.WildMatch(le.PRIM_NAME,ri.PRIM_NAME,false)  =>le.PRIM_NAME_weight100 / Config.WildPenalty,
           -0.531*le.PRIM_NAME_weight100))/100; 
    SELF.SSN5_match_code := MAP(
           le.SSN5 = (TYPEOF(le.SSN5))'' OR ri.SSN5 = (TYPEOF(ri.SSN5))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_SSN5(le.SSN5,ri.SSN5,le.SSN5_len,ri.SSN5_len,FALSE));
    SELF.SSN5Weight := (50+MAP (
           le.SSN5 = (TYPEOF(le.SSN5))'' OR ri.SSN5 = (TYPEOF(ri.SSN5))'' => 0,
           le.SSN5 = ri.SSN5  => le.SSN5_weight100,
           Config.WithinEditN(le.SSN5,le.SSN5_len,ri.SSN5,ri.SSN5_len,1, 0)  =>le.SSN5_e1_weight100,
           -0.873*le.SSN5_weight100))/100; 
    SELF.SSN4_match_code := MAP(
           le.SSN4 = (TYPEOF(le.SSN4))'' OR ri.SSN4 = (TYPEOF(ri.SSN4))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_SSN4(le.SSN4,ri.SSN4,le.SSN4_len,ri.SSN4_len,FALSE));
    SELF.SSN4Weight := (50+MAP (
           le.SSN4 = (TYPEOF(le.SSN4))'' OR ri.SSN4 = (TYPEOF(ri.SSN4))'' => 0,
           le.SSN4 = ri.SSN4  => le.SSN4_weight100,
           Config.WithinEditN(le.SSN4,le.SSN4_len,ri.SSN4,ri.SSN4_len,1, 0)  =>le.SSN4_e1_weight100,
           -0.866*le.SSN4_weight100))/100; 
    SELF.MNAME_match_code := MAP(
           le.MNAME = (TYPEOF(le.MNAME))'' OR ri.MNAME = (TYPEOF(ri.MNAME))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_MNAME(le.MNAME,ri.MNAME,le.MNAME_len,ri.MNAME_len,FALSE));
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
           match_methods(File_InsuranceHeader).match_SEC_RANGE(le.SEC_RANGE,ri.SEC_RANGE,FALSE));
    SELF.SEC_RANGEWeight := (50+MAP (
           le.SEC_RANGE = (TYPEOF(le.SEC_RANGE))'' OR ri.SEC_RANGE = (TYPEOF(ri.SEC_RANGE))'' => 0,
           le.PRIM_NAME = (TYPEOF(le.PRIM_NAME))'' OR ri.PRIM_NAME = (TYPEOF(ri.PRIM_NAME))'' OR le.PRIM_NAME <> ri.PRIM_NAME => 0, // Only valid if the context variable is equal
           le.SEC_RANGE = ri.SEC_RANGE  => le.SEC_RANGE_weight100,
           SALT37.HyphenMatch(le.SEC_RANGE,ri.SEC_RANGE,1)<=2  =>le.SEC_RANGE_weight100*MIN(1,LENGTH(TRIM(ri.SEC_RANGE))/LENGTH(TRIM(le.SEC_RANGE))),
           -0.629*le.SEC_RANGE_weight100))/100; 
    SELF.SNAME_match_code := MAP(
           le.SNAME = (TYPEOF(le.SNAME))'' OR ri.SNAME = (TYPEOF(ri.SNAME))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_SNAME(le.SNAME,ri.SNAME,FALSE));
    SELF.SNAMEWeight := (50+MAP (
           le.SNAME = (TYPEOF(le.SNAME))'' OR ri.SNAME = (TYPEOF(ri.SNAME))'' => 0,
           le.SNAME = ri.SNAME  => le.SNAME_weight100,
           -0.946*le.SNAME_weight100))/100; 
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
    SELF.Weight := IF(le.DID = 0, 100, MAX(0,SELF.LNAMEWeight) + MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.ZIPWeight) + MAX(0,SELF.CITYWeight) + MAX(0,SELF.PRIM_RANGEWeight) + MAX(0,SELF.PRIM_NAMEWeight) + MAX(0,SELF.SSN5Weight) + MAX(0,SELF.SSN4Weight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.SEC_RANGEWeight) + MAX(0,SELF.SNAMEWeight) + MAX(0,SELF.DOBWeight));
    SELF := le;
  END;
  Recs0 := Recs(LNAME <> (TYPEOF(LNAME))'',FNAME <> (TYPEOF(FNAME))'',ZIP <> (TYPEOF(ZIP))'');
  SALT37.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference,Config.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,LEFT.LNAME = RIGHT.LNAME
     AND LEFT.FNAME = RIGHT.FNAME
     AND LEFT.ZIP = RIGHT.ZIP,Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.LNAME = RIGHT.LNAME
     AND LEFT.FNAME = RIGHT.FNAME
     AND LEFT.ZIP = RIGHT.ZIP,Config.LFZ_MAXBLOCKSIZE)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),LEFT.LNAME = RIGHT.LNAME
     AND LEFT.FNAME = RIGHT.FNAME
     AND LEFT.ZIP = RIGHT.ZIP,Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.LNAME = RIGHT.LNAME
     AND LEFT.FNAME = RIGHT.FNAME
     AND LEFT.ZIP = RIGHT.ZIP,Config.LFZ_MAXBLOCKSIZE),HASH,UNORDERED); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := PROJECT(J2, Process_xIDL_Layouts().update_forcefailed(LEFT,In_disableForce));
  J4 := Process_xIDL_Layouts().CombineLinkpathScores(J3,In_disableForce); // Combine results and restrict number for one linkpath
  J5 := PROJECT(J4(keys_poisoned > 0), Process_xIDL_Layouts().apply_poison(LEFT)) & J4(keys_poisoned = 0);
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT37.MAC_Dups_Restore(J5,DD,J6,Reference,TRUE)
  RETURN J6;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_LNAME='',Input_FNAME='',Input_ZIP='',Input_CITY='',Input_PRIM_RANGE='',Input_PRIM_NAME='',Input_SSN5='',Input_SSN4='',Input_MNAME='',Input_SEC_RANGE='',Input_SNAME='',Input_DOB='',Input_ST='',output_file,AsIndex='true', In_disableForce = 'false') := MACRO
IMPORT SALT37,InsuranceHeader_xLink;
#IF(#TEXT(Input_LNAME)<>'' AND #TEXT(Input_FNAME)<>'' AND #TEXT(Input_ZIP)<>'')
  #uniquename(trans)
  InsuranceHeader_xLink.Key_InsuranceHeader_LFZ().InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    SELF.LNAME := (TYPEOF(SELF.LNAME))le.Input_LNAME;
    SELF.LNAME_len := LENGTH(TRIM((TYPEOF(SELF.LNAME))le.Input_LNAME));
    SELF.FNAME := (TYPEOF(SELF.FNAME))le.Input_FNAME;
    SELF.FNAME_len := LENGTH(TRIM((TYPEOF(SELF.FNAME))le.Input_FNAME));
    SELF.ZIP := (TYPEOF(SELF.ZIP))le.Input_ZIP;
    #IF ( #TEXT(Input_CITY) <> '' )
      SELF.CITY := (TYPEOF(SELF.CITY))le.Input_CITY;
    #END
    #IF ( #TEXT(Input_PRIM_RANGE) <> '' )
      SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))le.Input_PRIM_RANGE;
      SELF.PRIM_RANGE_len := LENGTH(TRIM((TYPEOF(SELF.PRIM_RANGE))le.Input_PRIM_RANGE));
    #END
    #IF ( #TEXT(Input_PRIM_NAME) <> '' )
      SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))le.Input_PRIM_NAME;
      SELF.PRIM_NAME_len := LENGTH(TRIM((TYPEOF(SELF.PRIM_NAME))le.Input_PRIM_NAME));
    #END
    #IF ( #TEXT(Input_SSN5) <> '' )
      SELF.SSN5 := (TYPEOF(SELF.SSN5))le.Input_SSN5;
      SELF.SSN5_len := LENGTH(TRIM((TYPEOF(SELF.SSN5))le.Input_SSN5));
    #END
    #IF ( #TEXT(Input_SSN4) <> '' )
      SELF.SSN4 := (TYPEOF(SELF.SSN4))le.Input_SSN4;
      SELF.SSN4_len := LENGTH(TRIM((TYPEOF(SELF.SSN4))le.Input_SSN4));
    #END
    #IF ( #TEXT(Input_MNAME) <> '' )
      SELF.MNAME := (TYPEOF(SELF.MNAME))le.Input_MNAME;
      SELF.MNAME_len := LENGTH(TRIM((TYPEOF(SELF.MNAME))le.Input_MNAME));
    #END
    #IF ( #TEXT(Input_SEC_RANGE) <> '' )
      SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))le.Input_SEC_RANGE;
    #END
    #IF ( #TEXT(Input_SNAME) <> '' )
      SELF.SNAME := (TYPEOF(SELF.SNAME))le.Input_SNAME;
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
  output_file := InsuranceHeader_xLink.Key_InsuranceHeader_LFZ().ScoredFetch_Batch(%p%,AsIndex, In_disableForce);
#ELSE
  output_file := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
END;
