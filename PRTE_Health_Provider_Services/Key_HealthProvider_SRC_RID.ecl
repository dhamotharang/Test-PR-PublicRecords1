EXPORT Key_HealthProvider_SRC_RID := MODULE
IMPORT SALT29,ut,std;
//SOURCE_RID:?:SRC:FNAME:+:LNAME:DOB:V_CITY_NAME:ST:GENDER:MNAME:SNAME
EXPORT KeyName := PRTE_Health_Provider_Services.Files.FILE_SOURCE_RID; //'~'+'key::PRTE_Health_Provider_Services::LNPID::Refs::SRC_RID';
SHARED h := CandidatesForKey;//The input file - distributed by LNPID
layout := RECORD // project out required fields
// Compulsory fields
  h.SOURCE_RID;
// Optional fields
  h.SRC;
  h.LNPID; // The ID field
  h.FNAME_PreferredName;
  h.FNAME;
// Extra credit fields
  h.LNAME;
  h.DOB_year;
  h.DOB_month;
  h.DOB_day;
  h.V_CITY_NAME;
  h.ST;
  h.GENDER;
  h.MNAME;
  h.SNAME;
//Scores for various field components
  h.SOURCE_RID_weight100 ; // Contains 100x the specificity
  h.SRC_weight100 ; // Contains 100x the specificity
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
  h.DOB_year_weight100 ; // Contains 100x the specificity
  h.DOB_month_weight100 ; // Contains 100x the specificity
  h.DOB_day_weight100 ; // Contains 100x the specificity
  h.V_CITY_NAME_weight100 ; // Contains 100x the specificity
  h.ST_weight100 ; // Contains 100x the specificity
  h.GENDER_weight100 ; // Contains 100x the specificity
  h.MNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_e2_Weight100;
  h.MNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.SNAME_weight100 ; // Contains 100x the specificity
  INTEGER2 FNAME_initial_weight100 := 0; // Weight if only first character matches
  INTEGER2 MNAME_initial_weight100 := 0; // Weight if only first character matches
END;
s := Specificities(File_HealthProvider).Specificities[1];
DataForKey0 := DEDUP(SORT(TABLE(h(SOURCE_RID NOT IN SET(s.nulls_SOURCE_RID,SOURCE_RID)),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
layout note_init2(layout le,Specificities(File_HealthProvider).FNAME_values_persisted ri) := TRANSFORM
  SELF.FNAME_initial_weight100 := ri.field_specificity * 100;
  SELF := le;
END;
DataForKey1 := JOIN(DataForKey0,Specificities(File_HealthProvider).FNAME_values_persisted(LENGTH(TRIM(FNAME))=1),LEFT.FNAME[1]=RIGHT.FNAME[1],note_init2(LEFT,RIGHT),LOOKUP,LEFT OUTER); // Append specificities for initials of FNAME
layout note_init8(layout le,Specificities(File_HealthProvider).MNAME_values_persisted ri) := TRANSFORM
  SELF.MNAME_initial_weight100 := ri.field_specificity * 100;
  SELF := le;
END;
DataForKey2 := JOIN(DataForKey1,Specificities(File_HealthProvider).MNAME_values_persisted(LENGTH(TRIM(MNAME))=1),LEFT.MNAME[1]=RIGHT.MNAME[1],note_init8(LEFT,RIGHT),LOOKUP,LEFT OUTER); // Append specificities for initials of MNAME
EXPORT Key := INDEX(DataForKey2,,KeyName);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,LNPID,SOURCE_RID,SRC,FNAME,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_LNAME := GROUP( DEDUP( SORT( Grpd, EXCEPT LNAME), EXCEPT LNAME));
  CntRed_LNAME := (KeyCnt-COUNT(Rem_LNAME))/KeyCnt;
  Rem_DOB := GROUP( DEDUP( SORT( Grpd, EXCEPT DOB_year,DOB_month,DOB_day), EXCEPT DOB_year,DOB_month,DOB_day));
  CntRed_DOB := (KeyCnt-COUNT(Rem_DOB))/KeyCnt;
  Rem_V_CITY_NAME := GROUP( DEDUP( SORT( Grpd, EXCEPT V_CITY_NAME), EXCEPT V_CITY_NAME));
  CntRed_V_CITY_NAME := (KeyCnt-COUNT(Rem_V_CITY_NAME))/KeyCnt;
  Rem_ST := GROUP( DEDUP( SORT( Grpd, EXCEPT ST), EXCEPT ST));
  CntRed_ST := (KeyCnt-COUNT(Rem_ST))/KeyCnt;
  Rem_GENDER := GROUP( DEDUP( SORT( Grpd, EXCEPT GENDER), EXCEPT GENDER));
  CntRed_GENDER := (KeyCnt-COUNT(Rem_GENDER))/KeyCnt;
  Rem_MNAME := GROUP( DEDUP( SORT( Grpd, EXCEPT MNAME), EXCEPT MNAME));
  CntRed_MNAME := (KeyCnt-COUNT(Rem_MNAME))/KeyCnt;
  Rem_SNAME := GROUP( DEDUP( SORT( Grpd, EXCEPT SNAME), EXCEPT SNAME));
  CntRed_SNAME := (KeyCnt-COUNT(Rem_SNAME))/KeyCnt;
EXPORT Shrinkage := DATASET([{'SRC_RID','LNAME',CntRed_LNAME*100,CntRed_LNAME*TSize},{'SRC_RID','DOB',CntRed_DOB*100,CntRed_DOB*TSize},{'SRC_RID','V_CITY_NAME',CntRed_V_CITY_NAME*100,CntRed_V_CITY_NAME*TSize},{'SRC_RID','ST',CntRed_ST*100,CntRed_ST*TSize},{'SRC_RID','GENDER',CntRed_GENDER*100,CntRed_GENDER*TSize},{'SRC_RID','MNAME',CntRed_MNAME*100,CntRed_MNAME*TSize},{'SRC_RID','SNAME',CntRed_SNAME*100,CntRed_SNAME*TSize}],SALT29.ShrinkLayout);
EXPORT CanSearch(Process_xLNPID_Layouts.InputLayout le) := le.SOURCE_RID <> (typeof(le.SOURCE_RID))'';
KeyRec := RECORDOF(Key);
EXPORT RawFetch(TYPEOF(h.SOURCE_RID) param_SOURCE_RID,TYPEOF(h.SRC) param_SRC,TYPEOF(h.FNAME) param_FNAME) := 
    STEPPED( LIMIT( Key(
          ( SOURCE_RID = param_SOURCE_RID AND param_SOURCE_RID <> (TYPEOF(SOURCE_RID))'' )
      AND ( SRC = (TYPEOF(SRC))'' OR param_SRC = (TYPEOF(SRC))'' OR SRC = param_SRC  )
      AND ( FNAME[1..LENGTH(TRIM(param_FNAME))] = param_FNAME OR param_FNAME[1..LENGTH(TRIM(FNAME))] = FNAME  OR FNAME_PreferredName = fn_PreferredName(param_FNAME) OR metaphonelib.DMetaPhone1(FNAME)=metaphonelib.DMetaPhone1(param_FNAME) OR SALT29.WithinEditN(FNAME,param_FNAME,1, 0)  )),10000,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),LNPID);
EXPORT ScoredLNPIDFetch(TYPEOF(h.SOURCE_RID) param_SOURCE_RID,TYPEOF(h.SRC) param_SRC,TYPEOF(h.FNAME) param_FNAME,TYPEOF(h.LNAME) param_LNAME,UNSIGNED4 param_DOB,TYPEOF(h.V_CITY_NAME) param_V_CITY_NAME,TYPEOF(h.ST) param_ST,TYPEOF(h.GENDER) param_GENDER,TYPEOF(h.MNAME) param_MNAME,TYPEOF(h.SNAME) param_SNAME) := FUNCTION
  RawData := RawFetch(param_SOURCE_RID,param_SRC,param_FNAME);
  Process_xLNPID_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 23; // Set bitmap for key used
    SELF.keys_failed := IF(le.LNPID = 0, 1 << 23, 0); // Set bitmap for key failed
    SELF.SOURCE_RID_match_code := MAP(
		le.SOURCE_RID = (TYPEOF(le.SOURCE_RID))'' OR le.SOURCE_RID = (TYPEOF(le.SOURCE_RID))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_SOURCE_RID(le.SOURCE_RID,param_SOURCE_RID,TRUE));
    SELF.SOURCE_RIDWeight := (50+MAP ( le.SOURCE_RID = param_SOURCE_RID  => le.SOURCE_RID_weight100,
          le.SOURCE_RID = (TYPEOF(le.SOURCE_RID))'' OR param_SOURCE_RID = (TYPEOF(le.SOURCE_RID))'' => 0,
           -0.036*le.SOURCE_RID_weight100))/100; 
    SELF.SRC_match_code := MAP(
		le.SRC = (TYPEOF(le.SRC))'' OR param_SRC = (TYPEOF(param_SRC))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_SRC(le.SRC,param_SRC,FALSE));
    SELF.SRCWeight := (50+MAP ( le.SRC = param_SRC  => le.SRC_weight100,
           le.SRC = (TYPEOF(le.SRC))'' OR param_SRC = (TYPEOF(param_SRC))'' => 0,
           -0.284*le.SRC_weight100))/100; 
    SELF.FNAME_match_code := MAP(
		le.FNAME = (TYPEOF(le.FNAME))'' OR param_FNAME = (TYPEOF(param_FNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_FNAME(le.FNAME,param_FNAME,FALSE));
    SELF.FNAMEWeight := (50+MAP ( le.FNAME = param_FNAME  => le.FNAME_weight100,
           le.FNAME_PreferredName = fn_PreferredName(param_FNAME) => le.FNAME_PreferredName_weight100,
           le.FNAME = (TYPEOF(le.FNAME))'' OR param_FNAME = (TYPEOF(param_FNAME))'' => 0,
           le.FNAME = param_FNAME[1..LENGTH(TRIM(le.FNAME))] => le.FNAME_weight100,
           SALT29.WithinEditN(le.FNAME,param_FNAME,1, 0) => IF( metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(param_FNAME),le.FNAME_e1p_weight100,le.FNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(param_FNAME)=>le.FNAME_p_weight100,
           le.FNAME[1..LENGTH(TRIM(param_FNAME))] = param_FNAME => SALT29.Fn_Interpolate_Initial(le.FNAME,param_FNAME,le.FNAME_weight100,le.FNAME_initial_weight100), // later in sequence as less accurate
           -0.961*le.FNAME_weight100))/100; 
    SELF.LNAME_match_code := MAP(
		le.LNAME = (TYPEOF(le.LNAME))'' OR param_LNAME = (TYPEOF(param_LNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_LNAME(le.LNAME,param_LNAME,FALSE));
    SELF.LNAMEWeight := (50+MAP ( le.LNAME = param_LNAME  => le.LNAME_weight100,
           le.LNAME = (TYPEOF(le.LNAME))'' OR param_LNAME = (TYPEOF(param_LNAME))'' => 0,
           SALT29.WithinEditN(le.LNAME,param_LNAME,1, 0) => IF( metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(param_LNAME),le.LNAME_e1p_weight100,le.LNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(param_LNAME)=>le.LNAME_p_weight100,
           SALT29.HyphenMatch(le.LNAME,param_LNAME,1)<=2 => le.LNAME_weight100*MIN(1,LENGTH(TRIM(param_LNAME))/LENGTH(TRIM(le.LNAME))),
           -0.874*le.LNAME_weight100))/100; 
    SELF.DOB_year_match_code := MAP(
		le.DOB_year = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT29.MatchCode.OneSideNull,
		match_methods(File_HealthProvider).match_DOB_year(le.DOB_year,((UNSIGNED)param_DOB) DIV 10000));
    SELF.DOB_month_match_code := MAP(
		le.DOB_month = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT29.MatchCode.OneSideNull,
		match_methods(File_HealthProvider).match_DOB_month(le.DOB_month,((UNSIGNED)param_DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)param_DOB) % 100));
    SELF.DOB_day_match_code := MAP(
		le.DOB_day = 0 OR param_DOB = (TYPEOF(param_DOB))'' => SALT29.MatchCode.OneSideNull,
		match_methods(File_HealthProvider).match_DOB_day(le.DOB_month,((UNSIGNED)param_DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)param_DOB) % 100));
    SELF.DOBWeight_year := (50+MAP ( le.DOB_year = 0 OR ((UNSIGNED)param_DOB) DIV 10000 = 0 => 0,
       le.DOB_year = ((UNSIGNED)param_DOB) DIV 10000  => le.DOB_year_weight100,
       -0.995*le.DOB_year_weight100))/100;
    SELF.DOBWeight_month := (50+MAP ( le.DOB_month = 0 OR ((UNSIGNED)param_DOB) DIV 100 % 100 = 0 => 0,
      le.DOB_month = ((UNSIGNED)param_DOB) DIV 100 % 100  => le.DOB_month_weight100,
       -0.995*le.DOB_month_weight100))/100;
    SELF.DOBWeight_day := (50+MAP ( le.DOB_day = 0 OR ((UNSIGNED)param_DOB) % 100 = 0 => 0,
      le.DOB_day = ((UNSIGNED)param_DOB) % 100  => le.DOB_day_weight100,
       -0.995*le.DOB_day_weight100))/100;
    SELF.DOBWeight := (SELF.DOBWeight_year+SELF.DOBWeight_month+SELF.DOBWeight_day); 
    SELF.V_CITY_NAME_match_code := MAP(
		le.V_CITY_NAME = (TYPEOF(le.V_CITY_NAME))'' OR param_V_CITY_NAME = (TYPEOF(param_V_CITY_NAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_V_CITY_NAME(le.V_CITY_NAME,param_V_CITY_NAME,FALSE));
    SELF.V_CITY_NAMEWeight := (50+MAP ( le.V_CITY_NAME = param_V_CITY_NAME  => le.V_CITY_NAME_weight100,
           le.V_CITY_NAME = (TYPEOF(le.V_CITY_NAME))'' OR param_V_CITY_NAME = (TYPEOF(param_V_CITY_NAME))'' => 0,
           -0.562*le.V_CITY_NAME_weight100))/100; 
    SELF.ST_match_code := MAP(
		le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_ST(le.ST,param_ST,FALSE));
    SELF.STWeight := (50+MAP ( le.ST = param_ST  => le.ST_weight100,
           le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' => 0,
           -0.823*le.ST_weight100))/100; 
    SELF.GENDER_match_code := MAP(
		le.GENDER = (TYPEOF(le.GENDER))'' OR param_GENDER = (TYPEOF(param_GENDER))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_GENDER(le.GENDER,param_GENDER,FALSE));
    SELF.GENDERWeight := (50+MAP ( le.GENDER = param_GENDER  => le.GENDER_weight100,
           le.GENDER = (TYPEOF(le.GENDER))'' OR param_GENDER = (TYPEOF(param_GENDER))'' => 0,
           -0.987*le.GENDER_weight100))/100; 
    SELF.MNAME_match_code := MAP(
		le.MNAME = (TYPEOF(le.MNAME))'' OR param_MNAME = (TYPEOF(param_MNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_MNAME(le.MNAME,param_MNAME,FALSE));
    SELF.MNAMEWeight := (50+MAP ( le.MNAME = param_MNAME  => le.MNAME_weight100,
           le.MNAME = (TYPEOF(le.MNAME))'' OR param_MNAME = (TYPEOF(param_MNAME))'' => 0,
           le.MNAME = param_MNAME[1..LENGTH(TRIM(le.MNAME))] => le.MNAME_weight100,
           SALT29.WithinEditN(le.MNAME,param_MNAME,2, 0) => le.MNAME_e2_weight100,
           le.MNAME[1..LENGTH(TRIM(param_MNAME))] = param_MNAME => SALT29.Fn_Interpolate_Initial(le.MNAME,param_MNAME,le.MNAME_weight100,le.MNAME_initial_weight100), // later in sequence as less accurate
           -0.932*le.MNAME_weight100))/100; 
    SELF.SNAME_match_code := MAP(
		le.SNAME = (TYPEOF(le.SNAME))'' OR param_SNAME = (TYPEOF(param_SNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_SNAME(le.SNAME,param_SNAME,FALSE));
    SELF.SNAMEWeight := (50+MAP ( le.SNAME = param_SNAME  => le.SNAME_weight100,
           le.SNAME = (TYPEOF(le.SNAME))'' OR param_SNAME = (TYPEOF(param_SNAME))'' => 0,
           -0.990*le.SNAME_weight100))/100; 
    SELF.Weight :=MAX(0,SELF.SOURCE_RIDWeight) + MAX(0,SELF.SRCWeight) + MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.LNAMEWeight) + MAX(0,SELF.DOBWeight) + MAX(0,SELF.V_CITY_NAMEWeight) + MAX(0,SELF.STWeight) + MAX(0,SELF.GENDERWeight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.SNAMEWeight);
    SELF := le;
  END;
  RETURN ROLLUP(PROJECT(NOFOLD(RawData),Score(LEFT)),LEFT.LNPID = RIGHT.LNPID,Process_xLNPID_Layouts.combine_scores(LEFT,RIGHT));
END;
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT29.UIDType Reference;//How to recognize this record in the subsequent
  TYPEOF(h.SOURCE_RID) SOURCE_RID := (TYPEOF(h.SOURCE_RID))'';
  TYPEOF(h.SRC) SRC := (TYPEOF(h.SRC))'';
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))'';
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))'';
  unsigned4 DOB := 0;
  TYPEOF(h.V_CITY_NAME) V_CITY_NAME := (TYPEOF(h.V_CITY_NAME))'';
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))'';
  TYPEOF(h.GENDER) GENDER := (TYPEOF(h.GENDER))'';
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))'';
  TYPEOF(h.SNAME) SNAME := (TYPEOF(h.SNAME))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex) := FUNCTION
  Process_xLNPID_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 23; // Set bitmap for key used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.SOURCE_RID_match_code := MAP(
		le.SOURCE_RID = (TYPEOF(le.SOURCE_RID))'' OR le.SOURCE_RID = (TYPEOF(le.SOURCE_RID))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_SOURCE_RID(le.SOURCE_RID,ri.SOURCE_RID,TRUE));
    SELF.SOURCE_RIDWeight := (50+MAP ( le.SOURCE_RID = ri.SOURCE_RID  => le.SOURCE_RID_weight100,
          le.SOURCE_RID = (TYPEOF(le.SOURCE_RID))'' OR ri.SOURCE_RID = (TYPEOF(le.SOURCE_RID))'' => 0,
           -0.036*le.SOURCE_RID_weight100))/100; 
    SELF.SRC_match_code := MAP(
		le.SRC = (TYPEOF(le.SRC))'' OR ri.SRC = (TYPEOF(ri.SRC))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_SRC(le.SRC,ri.SRC,FALSE));
    SELF.SRCWeight := (50+MAP ( le.SRC = ri.SRC  => le.SRC_weight100,
           le.SRC = (TYPEOF(le.SRC))'' OR ri.SRC = (TYPEOF(ri.SRC))'' => 0,
           -0.284*le.SRC_weight100))/100; 
    SELF.FNAME_match_code := MAP(
		le.FNAME = (TYPEOF(le.FNAME))'' OR ri.FNAME = (TYPEOF(ri.FNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_FNAME(le.FNAME,ri.FNAME,FALSE));
    SELF.FNAMEWeight := (50+MAP ( le.FNAME = ri.FNAME  => le.FNAME_weight100,
           le.FNAME_PreferredName = fn_PreferredName(ri.FNAME) => le.FNAME_PreferredName_weight100,
           le.FNAME = (TYPEOF(le.FNAME))'' OR ri.FNAME = (TYPEOF(ri.FNAME))'' => 0,
           le.FNAME = ri.FNAME[1..LENGTH(TRIM(le.FNAME))] => le.FNAME_weight100,
           SALT29.WithinEditN(le.FNAME,ri.FNAME,1, 0) => IF( metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(ri.FNAME),le.FNAME_e1p_weight100,le.FNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(ri.FNAME)=>le.FNAME_p_weight100,
           le.FNAME[1..LENGTH(TRIM(ri.FNAME))] = ri.FNAME => SALT29.Fn_Interpolate_Initial(le.FNAME,ri.FNAME,le.FNAME_weight100,le.FNAME_initial_weight100), // later in sequence as less accurate
           -0.961*le.FNAME_weight100))/100; 
    SELF.LNAME_match_code := MAP(
		le.LNAME = (TYPEOF(le.LNAME))'' OR ri.LNAME = (TYPEOF(ri.LNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_LNAME(le.LNAME,ri.LNAME,FALSE));
    SELF.LNAMEWeight := (50+MAP ( le.LNAME = ri.LNAME  => le.LNAME_weight100,
           le.LNAME = (TYPEOF(le.LNAME))'' OR ri.LNAME = (TYPEOF(ri.LNAME))'' => 0,
           SALT29.WithinEditN(le.LNAME,ri.LNAME,1, 0) => IF( metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(ri.LNAME),le.LNAME_e1p_weight100,le.LNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(ri.LNAME)=>le.LNAME_p_weight100,
           SALT29.HyphenMatch(le.LNAME,ri.LNAME,1)<=2 => le.LNAME_weight100*MIN(1,LENGTH(TRIM(ri.LNAME))/LENGTH(TRIM(le.LNAME))),
           -0.874*le.LNAME_weight100))/100; 
    SELF.DOB_year_match_code := MAP(
		le.DOB_year = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT29.MatchCode.OneSideNull,
		match_methods(File_HealthProvider).match_DOB_year(le.DOB_year,((UNSIGNED)ri.DOB) DIV 10000));
    SELF.DOB_month_match_code := MAP(
		le.DOB_month = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT29.MatchCode.OneSideNull,
		match_methods(File_HealthProvider).match_DOB_month(le.DOB_month,((UNSIGNED)ri.DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)ri.DOB) % 100));
    SELF.DOB_day_match_code := MAP(
		le.DOB_day = 0 OR ri.DOB = (TYPEOF(ri.DOB))'' => SALT29.MatchCode.OneSideNull,
		match_methods(File_HealthProvider).match_DOB_day(le.DOB_month,((UNSIGNED)ri.DOB) DIV 100 % 100,le.DOB_day, ((UNSIGNED)ri.DOB) % 100));
    SELF.DOBWeight_year := (50+MAP ( le.DOB_year = 0 OR ((UNSIGNED)ri.DOB) DIV 10000 = 0 => 0,
       le.DOB_year = ((UNSIGNED)ri.DOB) DIV 10000  => le.DOB_year_weight100,
       -0.995*le.DOB_year_weight100))/100;
    SELF.DOBWeight_month := (50+MAP ( le.DOB_month = 0 OR ((UNSIGNED)ri.DOB) DIV 100 % 100 = 0 => 0,
      le.DOB_month = ((UNSIGNED)ri.DOB) DIV 100 % 100  => le.DOB_month_weight100,
       -0.995*le.DOB_month_weight100))/100;
    SELF.DOBWeight_day := (50+MAP ( le.DOB_day = 0 OR ((UNSIGNED)ri.DOB) % 100 = 0 => 0,
      le.DOB_day = ((UNSIGNED)ri.DOB) % 100  => le.DOB_day_weight100,
       -0.995*le.DOB_day_weight100))/100;
    SELF.DOBWeight := (SELF.DOBWeight_year+SELF.DOBWeight_month+SELF.DOBWeight_day); 
    SELF.V_CITY_NAME_match_code := MAP(
		le.V_CITY_NAME = (TYPEOF(le.V_CITY_NAME))'' OR ri.V_CITY_NAME = (TYPEOF(ri.V_CITY_NAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_V_CITY_NAME(le.V_CITY_NAME,ri.V_CITY_NAME,FALSE));
    SELF.V_CITY_NAMEWeight := (50+MAP ( le.V_CITY_NAME = ri.V_CITY_NAME  => le.V_CITY_NAME_weight100,
           le.V_CITY_NAME = (TYPEOF(le.V_CITY_NAME))'' OR ri.V_CITY_NAME = (TYPEOF(ri.V_CITY_NAME))'' => 0,
           -0.562*le.V_CITY_NAME_weight100))/100; 
    SELF.ST_match_code := MAP(
		le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_ST(le.ST,ri.ST,FALSE));
    SELF.STWeight := (50+MAP ( le.ST = ri.ST  => le.ST_weight100,
           le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' => 0,
           -0.823*le.ST_weight100))/100; 
    SELF.GENDER_match_code := MAP(
		le.GENDER = (TYPEOF(le.GENDER))'' OR ri.GENDER = (TYPEOF(ri.GENDER))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_GENDER(le.GENDER,ri.GENDER,FALSE));
    SELF.GENDERWeight := (50+MAP ( le.GENDER = ri.GENDER  => le.GENDER_weight100,
           le.GENDER = (TYPEOF(le.GENDER))'' OR ri.GENDER = (TYPEOF(ri.GENDER))'' => 0,
           -0.987*le.GENDER_weight100))/100; 
    SELF.MNAME_match_code := MAP(
		le.MNAME = (TYPEOF(le.MNAME))'' OR ri.MNAME = (TYPEOF(ri.MNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_MNAME(le.MNAME,ri.MNAME,FALSE));
    SELF.MNAMEWeight := (50+MAP ( le.MNAME = ri.MNAME  => le.MNAME_weight100,
           le.MNAME = (TYPEOF(le.MNAME))'' OR ri.MNAME = (TYPEOF(ri.MNAME))'' => 0,
           le.MNAME = ri.MNAME[1..LENGTH(TRIM(le.MNAME))] => le.MNAME_weight100,
           SALT29.WithinEditN(le.MNAME,ri.MNAME,2, 0) => le.MNAME_e2_weight100,
           le.MNAME[1..LENGTH(TRIM(ri.MNAME))] = ri.MNAME => SALT29.Fn_Interpolate_Initial(le.MNAME,ri.MNAME,le.MNAME_weight100,le.MNAME_initial_weight100), // later in sequence as less accurate
           -0.932*le.MNAME_weight100))/100; 
    SELF.SNAME_match_code := MAP(
		le.SNAME = (TYPEOF(le.SNAME))'' OR ri.SNAME = (TYPEOF(ri.SNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_SNAME(le.SNAME,ri.SNAME,FALSE));
    SELF.SNAMEWeight := (50+MAP ( le.SNAME = ri.SNAME  => le.SNAME_weight100,
           le.SNAME = (TYPEOF(le.SNAME))'' OR ri.SNAME = (TYPEOF(ri.SNAME))'' => 0,
           -0.990*le.SNAME_weight100))/100; 
    SELF.Weight :=MAX(0,SELF.SOURCE_RIDWeight) + MAX(0,SELF.SRCWeight) + MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.LNAMEWeight) + MAX(0,SELF.DOBWeight) + MAX(0,SELF.V_CITY_NAMEWeight) + MAX(0,SELF.STWeight) + MAX(0,SELF.GENDERWeight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.SNAMEWeight);
    SELF := le;
  END;
  Recs0 := Recs(SOURCE_RID <> (typeof(SOURCE_RID))'');
  SALT29.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,LEFT.SOURCE_RID = RIGHT.SOURCE_RID
     AND ( LEFT.SRC = (TYPEOF(LEFT.SRC))'' OR RIGHT.SRC = (TYPEOF(RIGHT.SRC))'' OR LEFT.SRC = RIGHT.SRC  )
     AND ( LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME OR RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME OR metaphonelib.DMetaPhone1(LEFT.FNAME)=metaphonelib.DMetaPhone1(RIGHT.FNAME) OR SALT29.WithinEditN(LEFT.FNAME,RIGHT.FNAME,1, 0)  OR RIGHT.FNAME_PreferredName = fn_PreferredName(LEFT.FNAME)  ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.SOURCE_RID = RIGHT.SOURCE_RID,10000)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),LEFT.SOURCE_RID = RIGHT.SOURCE_RID
     AND ( LEFT.SRC = (TYPEOF(LEFT.SRC))'' OR RIGHT.SRC = (TYPEOF(RIGHT.SRC))'' OR LEFT.SRC = RIGHT.SRC  )
     AND ( LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME OR RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME OR metaphonelib.DMetaPhone1(LEFT.FNAME)=metaphonelib.DMetaPhone1(RIGHT.FNAME) OR SALT29.WithinEditN(LEFT.FNAME,RIGHT.FNAME,1, 0)  OR RIGHT.FNAME_PreferredName = fn_PreferredName(LEFT.FNAME)  ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.SOURCE_RID = RIGHT.SOURCE_RID,10000),HASH,HINT(unsorted_output)); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := Process_xLNPID_Layouts.CombineLinkpathScores(J2); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT29.MAC_Dups_Restore(J3,DD,J4,Reference,TRUE)
  RETURN J4;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_SOURCE_RID='',Input_SRC='',Input_FNAME='',Input_LNAME='',Input_DOB='',Input_V_CITY_NAME='',Input_ST='',Input_GENDER='',Input_MNAME='',Input_SNAME='',output_file,AsIndex='true') := MACRO
IMPORT SALT29,PRTE_Health_Provider_Services;
#IF(#TEXT(Input_SOURCE_RID)<>'')
  #uniquename(trans)
  PRTE_Health_Provider_Services.Key_HealthProvider_SRC_RID.InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    SELF.SOURCE_RID := (TYPEOF(SELF.SOURCE_RID))le.Input_SOURCE_RID;
    #IF ( #TEXT(Input_SRC) <> '' )
      SELF.SRC := (TYPEOF(SELF.SRC))le.Input_SRC;
    #END
    #IF ( #TEXT(Input_FNAME) <> '' )
      SELF.FNAME := (TYPEOF(SELF.FNAME))le.Input_FNAME;
    #END
    #IF ( #TEXT(Input_LNAME) <> '' )
      SELF.LNAME := (TYPEOF(SELF.LNAME))le.Input_LNAME;
    #END
    #if ( #TEXT(Input_DOB) <> '' )
      self.DOB := (unsigned4)le.Input_DOB;
    #end
    #IF ( #TEXT(Input_V_CITY_NAME) <> '' )
      SELF.V_CITY_NAME := (TYPEOF(SELF.V_CITY_NAME))le.Input_V_CITY_NAME;
    #END
    #IF ( #TEXT(Input_ST) <> '' )
      SELF.ST := (TYPEOF(SELF.ST))le.Input_ST;
    #END
    #IF ( #TEXT(Input_GENDER) <> '' )
      SELF.GENDER := (TYPEOF(SELF.GENDER))le.Input_GENDER;
    #END
    #IF ( #TEXT(Input_MNAME) <> '' )
      SELF.MNAME := (TYPEOF(SELF.MNAME))le.Input_MNAME;
    #END
    #IF ( #TEXT(Input_SNAME) <> '' )
      SELF.SNAME := (TYPEOF(SELF.SNAME))le.Input_SNAME;
    #END
  END;
  #uniquename(p)
  %p% := PROJECT(Infile,%trans%(left));
  output_file := PRTE_Health_Provider_Services.Key_HealthProvider_SRC_RID.ScoredFetch_Batch(%p%,AsIndex);
#ELSE
  output_file := DATASET([],PRTE_Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
END;
