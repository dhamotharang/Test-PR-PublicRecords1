EXPORT Key_HealthProvider_CNSMR_DOB_LP := MODULE
IMPORT SALT29,ut,std;
//CNSMR_DOB:FNAME:LNAME:?:MNAME:+:ST:V_CITY_NAME:CNSMR_SSN:GENDER:SNAME
EXPORT KeyName := Health_Provider_Services.Files.FILE_CNSMR_DOB_SF; //'~'+'key::Health_Provider_Services::LNPID::Refs::CNSMR_DOB_LP';
SHARED h := CandidatesForKey;//The input file - distributed by LNPID
layout := RECORD // project out required fields
// Compulsory fields
  h.CNSMR_DOB_year;
  h.CNSMR_DOB_month;
  h.CNSMR_DOB_day;
  h.FNAME;
  h.LNAME;
// Optional fields
  h.LNPID; // The ID field
  h.MNAME;
// Extra credit fields
  h.ST;
  h.V_CITY_NAME;
  h.CNSMR_SSN;
  h.GENDER;
  h.SNAME;
//Scores for various field components
  h.CNSMR_DOB_year_weight100 ; // Contains 100x the specificity
  h.CNSMR_DOB_month_weight100 ; // Contains 100x the specificity
  h.CNSMR_DOB_day_weight100 ; // Contains 100x the specificity
  h.FNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_MAINNAME_weight100 ; // Contains 100x the specificity
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
  h.MNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_e2_Weight100;
  h.MNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.ST_weight100 ; // Contains 100x the specificity
  h.V_CITY_NAME_weight100 ; // Contains 100x the specificity
  h.CNSMR_SSN_weight100 ; // Contains 100x the specificity
  INTEGER2 CNSMR_SSN_e1_Weight100 := SALT29.Min0(h.CNSMR_SSN_weight100 + 100*log(h.CNSMR_SSN_cnt/h.CNSMR_SSN_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.GENDER_weight100 ; // Contains 100x the specificity
  h.SNAME_weight100 ; // Contains 100x the specificity
  INTEGER2 MNAME_initial_weight100 := 0; // Weight if only first character matches
END;
s := Specificities(File_HealthProvider).Specificities[1];
DataForKey0 := DEDUP(SORT(TABLE(h((CNSMR_DOB_year NOT IN SET(s.nulls_CNSMR_DOB_year,CNSMR_DOB_year) OR CNSMR_DOB_month NOT IN SET(s.nulls_CNSMR_DOB_month,CNSMR_DOB_month) OR CNSMR_DOB_day NOT IN SET(s.nulls_CNSMR_DOB_day,CNSMR_DOB_day)),FNAME NOT IN SET(s.nulls_FNAME,FNAME),LNAME NOT IN SET(s.nulls_LNAME,LNAME)),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
layout note_init3(layout le,Specificities(File_HealthProvider).MNAME_values_persisted ri) := TRANSFORM
  SELF.MNAME_initial_weight100 := ri.field_specificity * 100;
  SELF := le;
END;
DataForKey1 := JOIN(DataForKey0,Specificities(File_HealthProvider).MNAME_values_persisted(LENGTH(TRIM(MNAME))=1),LEFT.MNAME[1]=RIGHT.MNAME[1],note_init3(LEFT,RIGHT),LOOKUP,LEFT OUTER); // Append specificities for initials of MNAME
EXPORT Key := INDEX(DataForKey1,,KeyName);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,LNPID,CNSMR_DOB_year,CNSMR_DOB_month,CNSMR_DOB_day,FNAME,LNAME,MNAME,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_ST := GROUP( DEDUP( SORT( Grpd, EXCEPT ST), EXCEPT ST));
  CntRed_ST := (KeyCnt-COUNT(Rem_ST))/KeyCnt;
  Rem_V_CITY_NAME := GROUP( DEDUP( SORT( Grpd, EXCEPT V_CITY_NAME), EXCEPT V_CITY_NAME));
  CntRed_V_CITY_NAME := (KeyCnt-COUNT(Rem_V_CITY_NAME))/KeyCnt;
  Rem_CNSMR_SSN := GROUP( DEDUP( SORT( Grpd, EXCEPT CNSMR_SSN), EXCEPT CNSMR_SSN));
  CntRed_CNSMR_SSN := (KeyCnt-COUNT(Rem_CNSMR_SSN))/KeyCnt;
  Rem_GENDER := GROUP( DEDUP( SORT( Grpd, EXCEPT GENDER), EXCEPT GENDER));
  CntRed_GENDER := (KeyCnt-COUNT(Rem_GENDER))/KeyCnt;
  Rem_SNAME := GROUP( DEDUP( SORT( Grpd, EXCEPT SNAME), EXCEPT SNAME));
  CntRed_SNAME := (KeyCnt-COUNT(Rem_SNAME))/KeyCnt;
EXPORT Shrinkage := DATASET([{'CNSMR_DOB_LP','ST',CntRed_ST*100,CntRed_ST*TSize},{'CNSMR_DOB_LP','V_CITY_NAME',CntRed_V_CITY_NAME*100,CntRed_V_CITY_NAME*TSize},{'CNSMR_DOB_LP','CNSMR_SSN',CntRed_CNSMR_SSN*100,CntRed_CNSMR_SSN*TSize},{'CNSMR_DOB_LP','GENDER',CntRed_GENDER*100,CntRed_GENDER*TSize},{'CNSMR_DOB_LP','SNAME',CntRed_SNAME*100,CntRed_SNAME*TSize}],SALT29.ShrinkLayout);
EXPORT CanSearch(Process_xLNPID_Layouts.InputLayout le) := le.CNSMR_DOB <> (typeof(le.CNSMR_DOB))'' AND le.FNAME <> (typeof(le.FNAME))'' AND le.LNAME <> (typeof(le.LNAME))'';
KeyRec := RECORDOF(Key);
EXPORT RawFetch(UNSIGNED4 param_CNSMR_DOB,TYPEOF(h.FNAME) param_FNAME,TYPEOF(h.LNAME) param_LNAME,TYPEOF(h.MNAME) param_MNAME) := 
    STEPPED( LIMIT( Key(
           param_CNSMR_DOB <> 0 AND SALT29.MOD_DateMatch(CNSMR_DOB_year,CNSMR_DOB_month,CNSMR_DOB_day,param_CNSMR_DOB DIV 10000,param_CNSMR_DOB DIV 100 % 100,param_CNSMR_DOB % 100,false,false,0,false).Eq
      AND ( FNAME = param_FNAME AND param_FNAME <> (TYPEOF(FNAME))'' )
      AND ( LNAME = param_LNAME AND param_LNAME <> (TYPEOF(LNAME))'' )
      AND ( MNAME[1..LENGTH(TRIM(param_MNAME))] = param_MNAME OR param_MNAME[1..LENGTH(TRIM(MNAME))] = MNAME OR SALT29.WithinEditN(MNAME,param_MNAME,2, 0)  )),10000,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),LNPID);
EXPORT ScoredLNPIDFetch(UNSIGNED4 param_CNSMR_DOB,TYPEOF(h.FNAME) param_FNAME,TYPEOF(h.LNAME) param_LNAME,TYPEOF(h.MNAME) param_MNAME,TYPEOF(h.ST) param_ST,TYPEOF(h.V_CITY_NAME) param_V_CITY_NAME,TYPEOF(h.CNSMR_SSN) param_CNSMR_SSN,TYPEOF(h.GENDER) param_GENDER,TYPEOF(h.SNAME) param_SNAME) := FUNCTION
  RawData := RawFetch(param_CNSMR_DOB,param_FNAME,param_LNAME,param_MNAME);
  Process_xLNPID_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 11; // Set bitmap for key used
    SELF.keys_failed := IF(le.LNPID = 0, 1 << 11, 0); // Set bitmap for key failed
    SELF.CNSMR_DOB_year_match_code := MAP(
		le.CNSMR_DOB_year = 0 OR param_CNSMR_DOB = (TYPEOF(param_CNSMR_DOB))'' => SALT29.MatchCode.OneSideNull,
		match_methods(File_HealthProvider).match_CNSMR_DOB_year(le.CNSMR_DOB_year,((UNSIGNED)param_CNSMR_DOB) DIV 10000));
    SELF.CNSMR_DOB_month_match_code := MAP(
		le.CNSMR_DOB_month = 0 OR param_CNSMR_DOB = (TYPEOF(param_CNSMR_DOB))'' => SALT29.MatchCode.OneSideNull,
		match_methods(File_HealthProvider).match_CNSMR_DOB_month(le.CNSMR_DOB_month,((UNSIGNED)param_CNSMR_DOB) DIV 100 % 100,le.CNSMR_DOB_day, ((UNSIGNED)param_CNSMR_DOB) % 100));
    SELF.CNSMR_DOB_day_match_code := MAP(
		le.CNSMR_DOB_day = 0 OR param_CNSMR_DOB = (TYPEOF(param_CNSMR_DOB))'' => SALT29.MatchCode.OneSideNull,
		match_methods(File_HealthProvider).match_CNSMR_DOB_day(le.CNSMR_DOB_month,((UNSIGNED)param_CNSMR_DOB) DIV 100 % 100,le.CNSMR_DOB_day, ((UNSIGNED)param_CNSMR_DOB) % 100));
    SELF.CNSMR_DOBWeight_year := (50+MAP ( le.CNSMR_DOB_year = 0 OR ((UNSIGNED)param_CNSMR_DOB) DIV 10000 = 0 => 0,
       le.CNSMR_DOB_year = ((UNSIGNED)param_CNSMR_DOB) DIV 10000  => le.CNSMR_DOB_year_weight100,
       -0.995*le.CNSMR_DOB_year_weight100))/100;
    SELF.CNSMR_DOBWeight_month := (50+MAP ( le.CNSMR_DOB_month = 0 OR ((UNSIGNED)param_CNSMR_DOB) DIV 100 % 100 = 0 => 0,
      le.CNSMR_DOB_month = ((UNSIGNED)param_CNSMR_DOB) DIV 100 % 100  => le.CNSMR_DOB_month_weight100,
       -0.995*le.CNSMR_DOB_month_weight100))/100;
    SELF.CNSMR_DOBWeight_day := (50+MAP ( le.CNSMR_DOB_day = 0 OR ((UNSIGNED)param_CNSMR_DOB) % 100 = 0 => 0,
      le.CNSMR_DOB_day = ((UNSIGNED)param_CNSMR_DOB) % 100  => le.CNSMR_DOB_day_weight100,
       -0.995*le.CNSMR_DOB_day_weight100))/100;
    SELF.CNSMR_DOBWeight := (SELF.CNSMR_DOBWeight_year+SELF.CNSMR_DOBWeight_month+SELF.CNSMR_DOBWeight_day); 
    SELF.FNAME_match_code := MAP(
		le.FNAME = (TYPEOF(le.FNAME))'' OR le.FNAME = (TYPEOF(le.FNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_FNAME(le.FNAME,param_FNAME,TRUE));
    SELF.FNAMEWeight := (50+MAP ( le.FNAME = param_FNAME  => le.FNAME_weight100,
          le.FNAME = (TYPEOF(le.FNAME))'' OR param_FNAME = (TYPEOF(le.FNAME))'' => 0,
           -0.961*le.FNAME_weight100))/100; 
    SELF.LNAME_match_code := MAP(
		le.LNAME = (TYPEOF(le.LNAME))'' OR le.LNAME = (TYPEOF(le.LNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_LNAME(le.LNAME,param_LNAME,TRUE));
    SELF.LNAMEWeight := (50+MAP ( le.LNAME = param_LNAME  => le.LNAME_weight100,
          le.LNAME = (TYPEOF(le.LNAME))'' OR param_LNAME = (TYPEOF(le.LNAME))'' => 0,
           -0.874*le.LNAME_weight100))/100; 
    SELF.MNAME_match_code := MAP(
		le.MNAME = (TYPEOF(le.MNAME))'' OR param_MNAME = (TYPEOF(param_MNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_MNAME(le.MNAME,param_MNAME,FALSE));
    SELF.MNAMEWeight := (50+MAP ( le.MNAME = param_MNAME  => le.MNAME_weight100,
           le.MNAME = (TYPEOF(le.MNAME))'' OR param_MNAME = (TYPEOF(param_MNAME))'' => 0,
           le.MNAME = param_MNAME[1..LENGTH(TRIM(le.MNAME))] => le.MNAME_weight100,
           SALT29.WithinEditN(le.MNAME,param_MNAME,2, 0) => le.MNAME_e2_weight100,
           le.MNAME[1..LENGTH(TRIM(param_MNAME))] = param_MNAME => SALT29.Fn_Interpolate_Initial(le.MNAME,param_MNAME,le.MNAME_weight100,le.MNAME_initial_weight100), // later in sequence as less accurate
           -0.932*le.MNAME_weight100))/100; 
    SELF.ST_match_code := MAP(
		le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_ST(le.ST,param_ST,FALSE));
    SELF.STWeight := (50+MAP ( le.ST = param_ST  => le.ST_weight100,
           le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' => 0,
           -0.823*le.ST_weight100))/100; 
    SELF.V_CITY_NAME_match_code := MAP(
		le.V_CITY_NAME = (TYPEOF(le.V_CITY_NAME))'' OR param_V_CITY_NAME = (TYPEOF(param_V_CITY_NAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_V_CITY_NAME(le.V_CITY_NAME,param_V_CITY_NAME,FALSE));
    SELF.V_CITY_NAMEWeight := (50+MAP ( le.V_CITY_NAME = param_V_CITY_NAME  => le.V_CITY_NAME_weight100,
           le.V_CITY_NAME = (TYPEOF(le.V_CITY_NAME))'' OR param_V_CITY_NAME = (TYPEOF(param_V_CITY_NAME))'' => 0,
           -0.562*le.V_CITY_NAME_weight100))/100; 
    SELF.CNSMR_SSN_match_code := MAP(
		le.CNSMR_SSN = (TYPEOF(le.CNSMR_SSN))'' OR param_CNSMR_SSN = (TYPEOF(param_CNSMR_SSN))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_CNSMR_SSN(le.CNSMR_SSN,param_CNSMR_SSN,FALSE));
    SELF.CNSMR_SSNWeight := (50+MAP ( le.CNSMR_SSN = param_CNSMR_SSN  => le.CNSMR_SSN_weight100,
           le.CNSMR_SSN = (TYPEOF(le.CNSMR_SSN))'' OR param_CNSMR_SSN = (TYPEOF(param_CNSMR_SSN))'' => 0,
           SALT29.WithinEditN(le.CNSMR_SSN,param_CNSMR_SSN,1, 0) => le.CNSMR_SSN_e1_weight100,
           -0.963*le.CNSMR_SSN_weight100))/100; 
    SELF.GENDER_match_code := MAP(
		le.GENDER = (TYPEOF(le.GENDER))'' OR param_GENDER = (TYPEOF(param_GENDER))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_GENDER(le.GENDER,param_GENDER,FALSE));
    SELF.GENDERWeight := (50+MAP ( le.GENDER = param_GENDER  => le.GENDER_weight100,
           le.GENDER = (TYPEOF(le.GENDER))'' OR param_GENDER = (TYPEOF(param_GENDER))'' => 0,
           -0.987*le.GENDER_weight100))/100; 
    SELF.SNAME_match_code := MAP(
		le.SNAME = (TYPEOF(le.SNAME))'' OR param_SNAME = (TYPEOF(param_SNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_SNAME(le.SNAME,param_SNAME,FALSE));
    SELF.SNAMEWeight := (50+MAP ( le.SNAME = param_SNAME  => le.SNAME_weight100,
           le.SNAME = (TYPEOF(le.SNAME))'' OR param_SNAME = (TYPEOF(param_SNAME))'' => 0,
           -0.990*le.SNAME_weight100))/100; 
    SELF.Weight :=MAX(0,SELF.CNSMR_DOBWeight) + MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.LNAMEWeight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.STWeight) + MAX(0,SELF.V_CITY_NAMEWeight) + MAX(0,SELF.CNSMR_SSNWeight) + MAX(0,SELF.GENDERWeight) + MAX(0,SELF.SNAMEWeight);
    SELF := le;
  END;
  RETURN ROLLUP(PROJECT(NOFOLD(RawData),Score(LEFT)),LEFT.LNPID = RIGHT.LNPID,Process_xLNPID_Layouts.combine_scores(LEFT,RIGHT));
END;
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT29.UIDType Reference;//How to recognize this record in the subsequent
  unsigned4 CNSMR_DOB := 0;
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))'';
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))'';
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))'';
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))'';
  TYPEOF(h.V_CITY_NAME) V_CITY_NAME := (TYPEOF(h.V_CITY_NAME))'';
  TYPEOF(h.CNSMR_SSN) CNSMR_SSN := (TYPEOF(h.CNSMR_SSN))'';
  TYPEOF(h.GENDER) GENDER := (TYPEOF(h.GENDER))'';
  TYPEOF(h.SNAME) SNAME := (TYPEOF(h.SNAME))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex) := FUNCTION
  Process_xLNPID_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 11; // Set bitmap for key used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.CNSMR_DOB_year_match_code := MAP(
		le.CNSMR_DOB_year = 0 OR ri.CNSMR_DOB = (TYPEOF(ri.CNSMR_DOB))'' => SALT29.MatchCode.OneSideNull,
		match_methods(File_HealthProvider).match_CNSMR_DOB_year(le.CNSMR_DOB_year,((UNSIGNED)ri.CNSMR_DOB) DIV 10000));
    SELF.CNSMR_DOB_month_match_code := MAP(
		le.CNSMR_DOB_month = 0 OR ri.CNSMR_DOB = (TYPEOF(ri.CNSMR_DOB))'' => SALT29.MatchCode.OneSideNull,
		match_methods(File_HealthProvider).match_CNSMR_DOB_month(le.CNSMR_DOB_month,((UNSIGNED)ri.CNSMR_DOB) DIV 100 % 100,le.CNSMR_DOB_day, ((UNSIGNED)ri.CNSMR_DOB) % 100));
    SELF.CNSMR_DOB_day_match_code := MAP(
		le.CNSMR_DOB_day = 0 OR ri.CNSMR_DOB = (TYPEOF(ri.CNSMR_DOB))'' => SALT29.MatchCode.OneSideNull,
		match_methods(File_HealthProvider).match_CNSMR_DOB_day(le.CNSMR_DOB_month,((UNSIGNED)ri.CNSMR_DOB) DIV 100 % 100,le.CNSMR_DOB_day, ((UNSIGNED)ri.CNSMR_DOB) % 100));
    SELF.CNSMR_DOBWeight_year := (50+MAP ( le.CNSMR_DOB_year = 0 OR ((UNSIGNED)ri.CNSMR_DOB) DIV 10000 = 0 => 0,
       le.CNSMR_DOB_year = ((UNSIGNED)ri.CNSMR_DOB) DIV 10000  => le.CNSMR_DOB_year_weight100,
       -0.995*le.CNSMR_DOB_year_weight100))/100;
    SELF.CNSMR_DOBWeight_month := (50+MAP ( le.CNSMR_DOB_month = 0 OR ((UNSIGNED)ri.CNSMR_DOB) DIV 100 % 100 = 0 => 0,
      le.CNSMR_DOB_month = ((UNSIGNED)ri.CNSMR_DOB) DIV 100 % 100  => le.CNSMR_DOB_month_weight100,
       -0.995*le.CNSMR_DOB_month_weight100))/100;
    SELF.CNSMR_DOBWeight_day := (50+MAP ( le.CNSMR_DOB_day = 0 OR ((UNSIGNED)ri.CNSMR_DOB) % 100 = 0 => 0,
      le.CNSMR_DOB_day = ((UNSIGNED)ri.CNSMR_DOB) % 100  => le.CNSMR_DOB_day_weight100,
       -0.995*le.CNSMR_DOB_day_weight100))/100;
    SELF.CNSMR_DOBWeight := (SELF.CNSMR_DOBWeight_year+SELF.CNSMR_DOBWeight_month+SELF.CNSMR_DOBWeight_day); 
    SELF.FNAME_match_code := MAP(
		le.FNAME = (TYPEOF(le.FNAME))'' OR le.FNAME = (TYPEOF(le.FNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_FNAME(le.FNAME,ri.FNAME,TRUE));
    SELF.FNAMEWeight := (50+MAP ( le.FNAME = ri.FNAME  => le.FNAME_weight100,
          le.FNAME = (TYPEOF(le.FNAME))'' OR ri.FNAME = (TYPEOF(le.FNAME))'' => 0,
           -0.961*le.FNAME_weight100))/100; 
    SELF.LNAME_match_code := MAP(
		le.LNAME = (TYPEOF(le.LNAME))'' OR le.LNAME = (TYPEOF(le.LNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_LNAME(le.LNAME,ri.LNAME,TRUE));
    SELF.LNAMEWeight := (50+MAP ( le.LNAME = ri.LNAME  => le.LNAME_weight100,
          le.LNAME = (TYPEOF(le.LNAME))'' OR ri.LNAME = (TYPEOF(le.LNAME))'' => 0,
           -0.874*le.LNAME_weight100))/100; 
    SELF.MNAME_match_code := MAP(
		le.MNAME = (TYPEOF(le.MNAME))'' OR ri.MNAME = (TYPEOF(ri.MNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_MNAME(le.MNAME,ri.MNAME,FALSE));
    SELF.MNAMEWeight := (50+MAP ( le.MNAME = ri.MNAME  => le.MNAME_weight100,
           le.MNAME = (TYPEOF(le.MNAME))'' OR ri.MNAME = (TYPEOF(ri.MNAME))'' => 0,
           le.MNAME = ri.MNAME[1..LENGTH(TRIM(le.MNAME))] => le.MNAME_weight100,
           SALT29.WithinEditN(le.MNAME,ri.MNAME,2, 0) => le.MNAME_e2_weight100,
           le.MNAME[1..LENGTH(TRIM(ri.MNAME))] = ri.MNAME => SALT29.Fn_Interpolate_Initial(le.MNAME,ri.MNAME,le.MNAME_weight100,le.MNAME_initial_weight100), // later in sequence as less accurate
           -0.932*le.MNAME_weight100))/100; 
    SELF.ST_match_code := MAP(
		le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_ST(le.ST,ri.ST,FALSE));
    SELF.STWeight := (50+MAP ( le.ST = ri.ST  => le.ST_weight100,
           le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' => 0,
           -0.823*le.ST_weight100))/100; 
    SELF.V_CITY_NAME_match_code := MAP(
		le.V_CITY_NAME = (TYPEOF(le.V_CITY_NAME))'' OR ri.V_CITY_NAME = (TYPEOF(ri.V_CITY_NAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_V_CITY_NAME(le.V_CITY_NAME,ri.V_CITY_NAME,FALSE));
    SELF.V_CITY_NAMEWeight := (50+MAP ( le.V_CITY_NAME = ri.V_CITY_NAME  => le.V_CITY_NAME_weight100,
           le.V_CITY_NAME = (TYPEOF(le.V_CITY_NAME))'' OR ri.V_CITY_NAME = (TYPEOF(ri.V_CITY_NAME))'' => 0,
           -0.562*le.V_CITY_NAME_weight100))/100; 
    SELF.CNSMR_SSN_match_code := MAP(
		le.CNSMR_SSN = (TYPEOF(le.CNSMR_SSN))'' OR ri.CNSMR_SSN = (TYPEOF(ri.CNSMR_SSN))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_CNSMR_SSN(le.CNSMR_SSN,ri.CNSMR_SSN,FALSE));
    SELF.CNSMR_SSNWeight := (50+MAP ( le.CNSMR_SSN = ri.CNSMR_SSN  => le.CNSMR_SSN_weight100,
           le.CNSMR_SSN = (TYPEOF(le.CNSMR_SSN))'' OR ri.CNSMR_SSN = (TYPEOF(ri.CNSMR_SSN))'' => 0,
           SALT29.WithinEditN(le.CNSMR_SSN,ri.CNSMR_SSN,1, 0) => le.CNSMR_SSN_e1_weight100,
           -0.963*le.CNSMR_SSN_weight100))/100; 
    SELF.GENDER_match_code := MAP(
		le.GENDER = (TYPEOF(le.GENDER))'' OR ri.GENDER = (TYPEOF(ri.GENDER))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_GENDER(le.GENDER,ri.GENDER,FALSE));
    SELF.GENDERWeight := (50+MAP ( le.GENDER = ri.GENDER  => le.GENDER_weight100,
           le.GENDER = (TYPEOF(le.GENDER))'' OR ri.GENDER = (TYPEOF(ri.GENDER))'' => 0,
           -0.987*le.GENDER_weight100))/100; 
    SELF.SNAME_match_code := MAP(
		le.SNAME = (TYPEOF(le.SNAME))'' OR ri.SNAME = (TYPEOF(ri.SNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_SNAME(le.SNAME,ri.SNAME,FALSE));
    SELF.SNAMEWeight := (50+MAP ( le.SNAME = ri.SNAME  => le.SNAME_weight100,
           le.SNAME = (TYPEOF(le.SNAME))'' OR ri.SNAME = (TYPEOF(ri.SNAME))'' => 0,
           -0.990*le.SNAME_weight100))/100; 
    SELF.Weight :=MAX(0,SELF.CNSMR_DOBWeight) + MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.LNAMEWeight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.STWeight) + MAX(0,SELF.V_CITY_NAMEWeight) + MAX(0,SELF.CNSMR_SSNWeight) + MAX(0,SELF.GENDERWeight) + MAX(0,SELF.SNAMEWeight);
    SELF := le;
  END;
  Recs0 := Recs((unsigned)CNSMR_DOB div 10000 <> 0 and (unsigned)CNSMR_DOB div 100 % 100 <> 0 and (unsigned)CNSMR_DOB % 100<>0,FNAME <> (typeof(FNAME))'',LNAME <> (typeof(LNAME))'');
  SALT29.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,SALT29.MOD_DateMatch(((UNSIGNED)LEFT.CNSMR_DOB DIV 10000 ),((UNSIGNED)LEFT.CNSMR_DOB DIV 100 % 100 ),((UNSIGNED)LEFT.CNSMR_DOB % 100),RIGHT.CNSMR_DOB_year,RIGHT.CNSMR_DOB_month,RIGHT.CNSMR_DOB_day,false,false,0,false).NNEQ
     AND LEFT.FNAME = RIGHT.FNAME
     AND LEFT.LNAME = RIGHT.LNAME
     AND ( LEFT.MNAME[1..LENGTH(TRIM(RIGHT.MNAME))] = RIGHT.MNAME OR RIGHT.MNAME[1..LENGTH(TRIM(LEFT.MNAME))] = LEFT.MNAME OR SALT29.WithinEditN(LEFT.MNAME,RIGHT.MNAME,2, 0)  ),Score_Batch(RIGHT,LEFT),
    ATMOST(SALT29.MOD_DateMatch(((UNSIGNED)LEFT.CNSMR_DOB DIV 10000 ),((UNSIGNED)LEFT.CNSMR_DOB DIV 100 % 100 ),((UNSIGNED)LEFT.CNSMR_DOB % 100),RIGHT.CNSMR_DOB_year,RIGHT.CNSMR_DOB_month,RIGHT.CNSMR_DOB_day,false,false,0,false).NNEQ
     AND LEFT.FNAME = RIGHT.FNAME
     AND LEFT.LNAME = RIGHT.LNAME,10000)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),SALT29.MOD_DateMatch(((UNSIGNED)LEFT.CNSMR_DOB DIV 10000 ),((UNSIGNED)LEFT.CNSMR_DOB DIV 100 % 100 ),((UNSIGNED)LEFT.CNSMR_DOB % 100),RIGHT.CNSMR_DOB_year,RIGHT.CNSMR_DOB_month,RIGHT.CNSMR_DOB_day,false,false,0,false).NNEQ
     AND LEFT.FNAME = RIGHT.FNAME
     AND LEFT.LNAME = RIGHT.LNAME
     AND ( LEFT.MNAME[1..LENGTH(TRIM(RIGHT.MNAME))] = RIGHT.MNAME OR RIGHT.MNAME[1..LENGTH(TRIM(LEFT.MNAME))] = LEFT.MNAME OR SALT29.WithinEditN(LEFT.MNAME,RIGHT.MNAME,2, 0)  ),Score_Batch(RIGHT,LEFT),
    ATMOST(SALT29.MOD_DateMatch(((UNSIGNED)LEFT.CNSMR_DOB DIV 10000 ),((UNSIGNED)LEFT.CNSMR_DOB DIV 100 % 100 ),((UNSIGNED)LEFT.CNSMR_DOB % 100),RIGHT.CNSMR_DOB_year,RIGHT.CNSMR_DOB_month,RIGHT.CNSMR_DOB_day,false,false,0,false).NNEQ
     AND LEFT.FNAME = RIGHT.FNAME
     AND LEFT.LNAME = RIGHT.LNAME,10000),HASH,HINT(unsorted_output)); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := Process_xLNPID_Layouts.CombineLinkpathScores(J2); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT29.MAC_Dups_Restore(J3,DD,J4,Reference,TRUE)
  RETURN J4;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_CNSMR_DOB='',Input_FNAME='',Input_LNAME='',Input_MNAME='',Input_ST='',Input_V_CITY_NAME='',Input_CNSMR_SSN='',Input_GENDER='',Input_SNAME='',output_file,AsIndex='true') := MACRO
IMPORT SALT29,Health_Provider_Services;
#IF(#TEXT(Input_CNSMR_DOB)<>'' AND #TEXT(Input_FNAME)<>'' AND #TEXT(Input_LNAME)<>'')
  #uniquename(trans)
  Health_Provider_Services.Key_HealthProvider_CNSMR_DOB_LP.InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    self.CNSMR_DOB := (unsigned4)le.Input_CNSMR_DOB;
    SELF.FNAME := (TYPEOF(SELF.FNAME))le.Input_FNAME;
    SELF.LNAME := (TYPEOF(SELF.LNAME))le.Input_LNAME;
    #IF ( #TEXT(Input_MNAME) <> '' )
      SELF.MNAME := (TYPEOF(SELF.MNAME))le.Input_MNAME;
    #END
    #IF ( #TEXT(Input_ST) <> '' )
      SELF.ST := (TYPEOF(SELF.ST))le.Input_ST;
    #END
    #IF ( #TEXT(Input_V_CITY_NAME) <> '' )
      SELF.V_CITY_NAME := (TYPEOF(SELF.V_CITY_NAME))le.Input_V_CITY_NAME;
    #END
    #IF ( #TEXT(Input_CNSMR_SSN) <> '' )
      SELF.CNSMR_SSN := (TYPEOF(SELF.CNSMR_SSN))le.Input_CNSMR_SSN;
    #END
    #IF ( #TEXT(Input_GENDER) <> '' )
      SELF.GENDER := (TYPEOF(SELF.GENDER))le.Input_GENDER;
    #END
    #IF ( #TEXT(Input_SNAME) <> '' )
      SELF.SNAME := (TYPEOF(SELF.SNAME))le.Input_SNAME;
    #END
  END;
  #uniquename(p)
  %p% := PROJECT(Infile,%trans%(left));
  output_file := Health_Provider_Services.Key_HealthProvider_CNSMR_DOB_LP.ScoredFetch_Batch(%p%,AsIndex);
#ELSE
  output_file := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
END;
