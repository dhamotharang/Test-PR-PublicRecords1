EXPORT Key_HealthProvider_VEN := MODULE
IMPORT SALT29,ut,std;
//VENDOR_ID:SRC:?:MAINNAME:+:SNAME:GENDER:DOB
EXPORT KeyName := PRTE_Health_Provider_Services.Files.FILE_VendorID; //'~'+'key::PRTE_Health_Provider_Services::LNPID::Refs::VEN';
SHARED h := CandidatesForKey;//The input file - distributed by LNPID
layout := RECORD // project out required fields
// Compulsory fields
  h.VENDOR_ID;
  h.SRC;
// Optional fields
  h.LNPID; // The ID field
  h.FNAME_PreferredName;
  h.FNAME;
  h.MNAME;
  h.LNAME;
// Extra credit fields
  h.SNAME;
  h.GENDER;
  h.DOB_year;
  h.DOB_month;
  h.DOB_day;
//Scores for various field components
  h.VENDOR_ID_weight100 ; // Contains 100x the specificity
  h.SRC_weight100 ; // Contains 100x the specificity
  h.FNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_p_Weight100;
  h.FNAME_e1_Weight100;
  h.FNAME_e1p_Weight100;
  h.FNAME_PreferredName_Weight100;
  h.FNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.MNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_e2_Weight100;
  h.MNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.LNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_p_Weight100;
  h.LNAME_e1_Weight100;
  h.LNAME_e1p_Weight100;
  h.LNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.SNAME_weight100 ; // Contains 100x the specificity
  h.GENDER_weight100 ; // Contains 100x the specificity
  h.DOB_year_weight100 ; // Contains 100x the specificity
  h.DOB_month_weight100 ; // Contains 100x the specificity
  h.DOB_day_weight100 ; // Contains 100x the specificity
  INTEGER2 FNAME_initial_weight100 := 0; // Weight if only first character matches
  INTEGER2 MNAME_initial_weight100 := 0; // Weight if only first character matches
END;
s := Specificities(File_HealthProvider).Specificities[1];
DataForKey0 := DEDUP(SORT(TABLE(h(VENDOR_ID NOT IN SET(s.nulls_VENDOR_ID,VENDOR_ID),SRC NOT IN SET(s.nulls_SRC,SRC)),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
EXPORT Key := INDEX(DataForKey0,,KeyName);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,LNPID,VENDOR_ID,SRC,FNAME,MNAME,LNAME,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_SNAME := GROUP( DEDUP( SORT( Grpd, EXCEPT SNAME), EXCEPT SNAME));
  CntRed_SNAME := (KeyCnt-COUNT(Rem_SNAME))/KeyCnt;
  Rem_GENDER := GROUP( DEDUP( SORT( Grpd, EXCEPT GENDER), EXCEPT GENDER));
  CntRed_GENDER := (KeyCnt-COUNT(Rem_GENDER))/KeyCnt;
  Rem_DOB := GROUP( DEDUP( SORT( Grpd, EXCEPT DOB_year,DOB_month,DOB_day), EXCEPT DOB_year,DOB_month,DOB_day));
  CntRed_DOB := (KeyCnt-COUNT(Rem_DOB))/KeyCnt;
EXPORT Shrinkage := DATASET([{'VEN','SNAME',CntRed_SNAME*100,CntRed_SNAME*TSize},{'VEN','GENDER',CntRed_GENDER*100,CntRed_GENDER*TSize},{'VEN','DOB',CntRed_DOB*100,CntRed_DOB*TSize}],SALT29.ShrinkLayout);
EXPORT CanSearch(Process_xLNPID_Layouts.InputLayout le) := le.VENDOR_ID <> (typeof(le.VENDOR_ID))'' AND le.SRC <> (typeof(le.SRC))'';
KeyRec := RECORDOF(Key);
EXPORT RawFetch(TYPEOF(h.VENDOR_ID) param_VENDOR_ID,TYPEOF(h.SRC) param_SRC,TYPEOF(h.FNAME) param_FNAME,TYPEOF(h.MNAME) param_MNAME,TYPEOF(h.LNAME) param_LNAME) := 
    STEPPED( LIMIT( Key(
          ( VENDOR_ID = param_VENDOR_ID AND param_VENDOR_ID <> (TYPEOF(VENDOR_ID))'' )
      AND ( SRC = param_SRC AND param_SRC <> (TYPEOF(SRC))'' )
      AND (( FNAME[1..LENGTH(TRIM(param_FNAME))] = param_FNAME OR param_FNAME[1..LENGTH(TRIM(FNAME))] = FNAME  OR FNAME_PreferredName = fn_PreferredName(param_FNAME) OR metaphonelib.DMetaPhone1(FNAME)=metaphonelib.DMetaPhone1(param_FNAME) OR SALT29.WithinEditN(FNAME,param_FNAME,1, 0)  )
        AND ( MNAME[1..LENGTH(TRIM(param_MNAME))] = param_MNAME OR param_MNAME[1..LENGTH(TRIM(MNAME))] = MNAME OR SALT29.WithinEditN(MNAME,param_MNAME,2, 0)  )
        AND ( LNAME = (TYPEOF(LNAME))'' OR param_LNAME = (TYPEOF(LNAME))'' OR metaphonelib.DMetaPhone1(LNAME)=metaphonelib.DMetaPhone1(param_LNAME) OR SALT29.WithinEditN(LNAME,param_LNAME,1, 0) OR SALT29.HyphenMatch(LNAME,param_LNAME,1)<=2  )
        OR SALT29.fn_concept_wordbag_EditN.Match3((SALT29.StrType)FNAME,FNAME_MAINNAME_weight100,true,0,true,1,(SALT29.StrType)MNAME,MNAME_MAINNAME_weight100,true,0,true,2,(SALT29.StrType)LNAME,LNAME_MAINNAME_weight100,true,0,false,1,(SALT29.StrType)param_FNAME,0,(SALT29.StrType)param_MNAME,0,(SALT29.StrType)param_LNAME,0)>= 0 )),10000,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),LNPID);
EXPORT ScoredLNPIDFetch(TYPEOF(h.VENDOR_ID) param_VENDOR_ID,TYPEOF(h.SRC) param_SRC,TYPEOF(h.FNAME) param_FNAME,TYPEOF(h.MNAME) param_MNAME,TYPEOF(h.LNAME) param_LNAME,TYPEOF(h.SNAME) param_SNAME,TYPEOF(h.GENDER) param_GENDER,UNSIGNED4 param_DOB) := FUNCTION
  RawData := RawFetch(param_VENDOR_ID,param_SRC,param_FNAME,param_MNAME,param_LNAME);
  Process_xLNPID_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 14; // Set bitmap for key used
    SELF.keys_failed := IF(le.LNPID = 0, 1 << 14, 0); // Set bitmap for key failed
    SELF.VENDOR_ID_match_code := MAP(
		le.VENDOR_ID = (TYPEOF(le.VENDOR_ID))'' OR le.VENDOR_ID = (TYPEOF(le.VENDOR_ID))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_VENDOR_ID(le.VENDOR_ID,param_VENDOR_ID,TRUE));
    SELF.VENDOR_IDWeight := (50+MAP ( le.VENDOR_ID = param_VENDOR_ID  => le.VENDOR_ID_weight100,
          le.VENDOR_ID = (TYPEOF(le.VENDOR_ID))'' OR param_VENDOR_ID = (TYPEOF(le.VENDOR_ID))'' => 0,
           -0.152*le.VENDOR_ID_weight100))/100; 
    SELF.SRC_match_code := MAP(
		le.SRC = (TYPEOF(le.SRC))'' OR le.SRC = (TYPEOF(le.SRC))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_SRC(le.SRC,param_SRC,TRUE));
    SELF.SRCWeight := (50+MAP ( le.SRC = param_SRC  => le.SRC_weight100,
          le.SRC = (TYPEOF(le.SRC))'' OR param_SRC = (TYPEOF(le.SRC))'' => 0,
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
    SELF.MNAME_match_code := MAP(
		le.MNAME = (TYPEOF(le.MNAME))'' OR param_MNAME = (TYPEOF(param_MNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_MNAME(le.MNAME,param_MNAME,FALSE));
    SELF.MNAMEWeight := (50+MAP ( le.MNAME = param_MNAME  => le.MNAME_weight100,
           le.MNAME = (TYPEOF(le.MNAME))'' OR param_MNAME = (TYPEOF(param_MNAME))'' => 0,
           le.MNAME = param_MNAME[1..LENGTH(TRIM(le.MNAME))] => le.MNAME_weight100,
           SALT29.WithinEditN(le.MNAME,param_MNAME,2, 0) => le.MNAME_e2_weight100,
           le.MNAME[1..LENGTH(TRIM(param_MNAME))] = param_MNAME => SALT29.Fn_Interpolate_Initial(le.MNAME,param_MNAME,le.MNAME_weight100,le.MNAME_initial_weight100), // later in sequence as less accurate
           -0.932*le.MNAME_weight100))/100; 
    SELF.LNAME_match_code := MAP(
		le.LNAME = (TYPEOF(le.LNAME))'' OR param_LNAME = (TYPEOF(param_LNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_LNAME(le.LNAME,param_LNAME,FALSE));
    SELF.LNAMEWeight := (50+MAP ( le.LNAME = param_LNAME  => le.LNAME_weight100,
           le.LNAME = (TYPEOF(le.LNAME))'' OR param_LNAME = (TYPEOF(param_LNAME))'' => 0,
           SALT29.WithinEditN(le.LNAME,param_LNAME,1, 0) => IF( metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(param_LNAME),le.LNAME_e1p_weight100,le.LNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(param_LNAME)=>le.LNAME_p_weight100,
           SALT29.HyphenMatch(le.LNAME,param_LNAME,1)<=2 => le.LNAME_weight100*MIN(1,LENGTH(TRIM(param_LNAME))/LENGTH(TRIM(le.LNAME))),
           -0.874*le.LNAME_weight100))/100; 
    SELF.MAINNAME_match_code := match_methods(File_HealthProvider).match_MAINNAME(HASH32(le.FNAME,le.MNAME,le.LNAME),HASH32(param_FNAME,param_MNAME,param_LNAME),(SALT29.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,true,0,true,1,(SALT29.StrType)le.MNAME,le.MNAME_MAINNAME_weight100,true,0,true,2,(SALT29.StrType)le.LNAME,le.LNAME_MAINNAME_weight100,true,0,false,1,(SALT29.StrType)param_FNAME,0,(SALT29.StrType)param_MNAME,0,(SALT29.StrType)param_LNAME,0);
    SELF.MAINNAMEWeight := (50+MAP(HASH32(le.FNAME,le.MNAME,le.LNAME)=HASH32(param_FNAME,param_MNAME,param_LNAME) => le.FNAME_weight100+le.MNAME_weight100+le.LNAME_weight100,
           SALT29.fn_concept_wordbag_EditN.Match3((SALT29.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,true,0,true,1,(SALT29.StrType)le.MNAME,le.MNAME_MAINNAME_weight100,true,0,true,2,(SALT29.StrType)le.LNAME,le.LNAME_MAINNAME_weight100,true,0,false,1,(SALT29.StrType)param_FNAME,0,(SALT29.StrType)param_MNAME,0,(SALT29.StrType)param_LNAME,0)))/100; //Concept could score even if fields do not
    SELF.SNAME_match_code := MAP(
		le.SNAME = (TYPEOF(le.SNAME))'' OR param_SNAME = (TYPEOF(param_SNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_SNAME(le.SNAME,param_SNAME,FALSE));
    SELF.SNAMEWeight := (50+MAP ( le.SNAME = param_SNAME  => le.SNAME_weight100,
           le.SNAME = (TYPEOF(le.SNAME))'' OR param_SNAME = (TYPEOF(param_SNAME))'' => 0,
           -0.990*le.SNAME_weight100))/100; 
    SELF.GENDER_match_code := MAP(
		le.GENDER = (TYPEOF(le.GENDER))'' OR param_GENDER = (TYPEOF(param_GENDER))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_GENDER(le.GENDER,param_GENDER,FALSE));
    SELF.GENDERWeight := (50+MAP ( le.GENDER = param_GENDER  => le.GENDER_weight100,
           le.GENDER = (TYPEOF(le.GENDER))'' OR param_GENDER = (TYPEOF(param_GENDER))'' => 0,
           -0.987*le.GENDER_weight100))/100; 
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
    SELF.Weight :=MAX(0,SELF.VENDOR_IDWeight) + MAX(0,SELF.SRCWeight) + MAX(self.MAINNAMEWeight,MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.LNAMEWeight)) + MAX(0,SELF.SNAMEWeight) + MAX(0,SELF.GENDERWeight) + MAX(0,SELF.DOBWeight);
    SELF := le;
  END;
  RETURN ROLLUP(PROJECT(NOFOLD(RawData),Score(LEFT)),LEFT.LNPID = RIGHT.LNPID,Process_xLNPID_Layouts.combine_scores(LEFT,RIGHT));
END;
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT29.UIDType Reference;//How to recognize this record in the subsequent
  TYPEOF(h.VENDOR_ID) VENDOR_ID := (TYPEOF(h.VENDOR_ID))'';
  TYPEOF(h.SRC) SRC := (TYPEOF(h.SRC))'';
  SALT29.StrType MAINNAME := (SALT29.StrType)'';
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))'';
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))'';
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))'';
  TYPEOF(h.SNAME) SNAME := (TYPEOF(h.SNAME))'';
  TYPEOF(h.GENDER) GENDER := (TYPEOF(h.GENDER))'';
  unsigned4 DOB := 0;
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex) := FUNCTION
  Process_xLNPID_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 14; // Set bitmap for key used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.VENDOR_ID_match_code := MAP(
		le.VENDOR_ID = (TYPEOF(le.VENDOR_ID))'' OR le.VENDOR_ID = (TYPEOF(le.VENDOR_ID))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_VENDOR_ID(le.VENDOR_ID,ri.VENDOR_ID,TRUE));
    SELF.VENDOR_IDWeight := (50+MAP ( le.VENDOR_ID = ri.VENDOR_ID  => le.VENDOR_ID_weight100,
          le.VENDOR_ID = (TYPEOF(le.VENDOR_ID))'' OR ri.VENDOR_ID = (TYPEOF(le.VENDOR_ID))'' => 0,
           -0.152*le.VENDOR_ID_weight100))/100; 
    SELF.SRC_match_code := MAP(
		le.SRC = (TYPEOF(le.SRC))'' OR le.SRC = (TYPEOF(le.SRC))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_SRC(le.SRC,ri.SRC,TRUE));
    SELF.SRCWeight := (50+MAP ( le.SRC = ri.SRC  => le.SRC_weight100,
          le.SRC = (TYPEOF(le.SRC))'' OR ri.SRC = (TYPEOF(le.SRC))'' => 0,
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
    SELF.MNAME_match_code := MAP(
		le.MNAME = (TYPEOF(le.MNAME))'' OR ri.MNAME = (TYPEOF(ri.MNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_MNAME(le.MNAME,ri.MNAME,FALSE));
    SELF.MNAMEWeight := (50+MAP ( le.MNAME = ri.MNAME  => le.MNAME_weight100,
           le.MNAME = (TYPEOF(le.MNAME))'' OR ri.MNAME = (TYPEOF(ri.MNAME))'' => 0,
           le.MNAME = ri.MNAME[1..LENGTH(TRIM(le.MNAME))] => le.MNAME_weight100,
           SALT29.WithinEditN(le.MNAME,ri.MNAME,2, 0) => le.MNAME_e2_weight100,
           le.MNAME[1..LENGTH(TRIM(ri.MNAME))] = ri.MNAME => SALT29.Fn_Interpolate_Initial(le.MNAME,ri.MNAME,le.MNAME_weight100,le.MNAME_initial_weight100), // later in sequence as less accurate
           -0.932*le.MNAME_weight100))/100; 
    SELF.LNAME_match_code := MAP(
		le.LNAME = (TYPEOF(le.LNAME))'' OR ri.LNAME = (TYPEOF(ri.LNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_LNAME(le.LNAME,ri.LNAME,FALSE));
    SELF.LNAMEWeight := (50+MAP ( le.LNAME = ri.LNAME  => le.LNAME_weight100,
           le.LNAME = (TYPEOF(le.LNAME))'' OR ri.LNAME = (TYPEOF(ri.LNAME))'' => 0,
           SALT29.WithinEditN(le.LNAME,ri.LNAME,1, 0) => IF( metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(ri.LNAME),le.LNAME_e1p_weight100,le.LNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(ri.LNAME)=>le.LNAME_p_weight100,
           SALT29.HyphenMatch(le.LNAME,ri.LNAME,1)<=2 => le.LNAME_weight100*MIN(1,LENGTH(TRIM(ri.LNAME))/LENGTH(TRIM(le.LNAME))),
           -0.874*le.LNAME_weight100))/100; 
    SELF.MAINNAME_match_code := match_methods(File_HealthProvider).match_MAINNAME(HASH32(le.FNAME,le.MNAME,le.LNAME),HASH32(ri.FNAME,ri.MNAME,ri.LNAME),(SALT29.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,true,0,true,1,(SALT29.StrType)le.MNAME,le.MNAME_MAINNAME_weight100,true,0,true,2,(SALT29.StrType)le.LNAME,le.LNAME_MAINNAME_weight100,true,0,false,1,(SALT29.StrType)ri.FNAME,0,(SALT29.StrType)ri.MNAME,0,(SALT29.StrType)ri.LNAME,0);
    SELF.MAINNAMEWeight := (50+MAP(HASH32(le.FNAME,le.MNAME,le.LNAME)=HASH32(ri.FNAME,ri.MNAME,ri.LNAME) => le.FNAME_weight100+le.MNAME_weight100+le.LNAME_weight100,
           SALT29.fn_concept_wordbag_EditN.Match3((SALT29.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,true,0,true,1,(SALT29.StrType)le.MNAME,le.MNAME_MAINNAME_weight100,true,0,true,2,(SALT29.StrType)le.LNAME,le.LNAME_MAINNAME_weight100,true,0,false,1,(SALT29.StrType)ri.FNAME,0,(SALT29.StrType)ri.MNAME,0,(SALT29.StrType)ri.LNAME,0)))/100; //Concept could score even if fields do not
    SELF.SNAME_match_code := MAP(
		le.SNAME = (TYPEOF(le.SNAME))'' OR ri.SNAME = (TYPEOF(ri.SNAME))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_SNAME(le.SNAME,ri.SNAME,FALSE));
    SELF.SNAMEWeight := (50+MAP ( le.SNAME = ri.SNAME  => le.SNAME_weight100,
           le.SNAME = (TYPEOF(le.SNAME))'' OR ri.SNAME = (TYPEOF(ri.SNAME))'' => 0,
           -0.990*le.SNAME_weight100))/100; 
    SELF.GENDER_match_code := MAP(
		le.GENDER = (TYPEOF(le.GENDER))'' OR ri.GENDER = (TYPEOF(ri.GENDER))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_GENDER(le.GENDER,ri.GENDER,FALSE));
    SELF.GENDERWeight := (50+MAP ( le.GENDER = ri.GENDER  => le.GENDER_weight100,
           le.GENDER = (TYPEOF(le.GENDER))'' OR ri.GENDER = (TYPEOF(ri.GENDER))'' => 0,
           -0.987*le.GENDER_weight100))/100; 
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
    SELF.Weight :=MAX(0,SELF.VENDOR_IDWeight) + MAX(0,SELF.SRCWeight) + MAX(self.MAINNAMEWeight,MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.LNAMEWeight)) + MAX(0,SELF.SNAMEWeight) + MAX(0,SELF.GENDERWeight) + MAX(0,SELF.DOBWeight);
    SELF := le;
  END;
  Recs0 := Recs(VENDOR_ID <> (typeof(VENDOR_ID))'',SRC <> (typeof(SRC))'');
  SALT29.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,LEFT.VENDOR_ID = RIGHT.VENDOR_ID
     AND LEFT.SRC = RIGHT.SRC
     AND ( ( 
        (LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME OR RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME OR metaphonelib.DMetaPhone1(LEFT.FNAME)=metaphonelib.DMetaPhone1(RIGHT.FNAME) OR SALT29.WithinEditN(LEFT.FNAME,RIGHT.FNAME,1, 0)  OR RIGHT.FNAME_PreferredName = fn_PreferredName(LEFT.FNAME) ) AND (LEFT.MNAME[1..LENGTH(TRIM(RIGHT.MNAME))] = RIGHT.MNAME OR RIGHT.MNAME[1..LENGTH(TRIM(LEFT.MNAME))] = LEFT.MNAME OR SALT29.WithinEditN(LEFT.MNAME,RIGHT.MNAME,2, 0) ) AND (LEFT.LNAME = (TYPEOF(LEFT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR metaphonelib.DMetaPhone1(LEFT.LNAME)=metaphonelib.DMetaPhone1(RIGHT.LNAME) OR SALT29.WithinEditN(LEFT.LNAME,RIGHT.LNAME,1, 0) OR SALT29.HyphenMatch(LEFT.LNAME,RIGHT.LNAME,1)<=2 )
          OR SALT29.fn_concept_wordbag_EditN.Match3((SALT29.StrType)RIGHT.FNAME,RIGHT.FNAME_MAINNAME_weight100,true,0,true,1,(SALT29.StrType)RIGHT.MNAME,RIGHT.MNAME_MAINNAME_weight100,true,0,true,2,(SALT29.StrType)RIGHT.LNAME,RIGHT.LNAME_MAINNAME_weight100,true,0,false,1,(SALT29.StrType)LEFT.FNAME,0,(SALT29.StrType)LEFT.MNAME,0,(SALT29.StrType)LEFT.LNAME,0)>= 0) ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID
     AND LEFT.SRC = RIGHT.SRC,10000)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),LEFT.VENDOR_ID = RIGHT.VENDOR_ID
     AND LEFT.SRC = RIGHT.SRC
     AND ( ( 
        (LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME OR RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME OR metaphonelib.DMetaPhone1(LEFT.FNAME)=metaphonelib.DMetaPhone1(RIGHT.FNAME) OR SALT29.WithinEditN(LEFT.FNAME,RIGHT.FNAME,1, 0)  OR RIGHT.FNAME_PreferredName = fn_PreferredName(LEFT.FNAME) ) AND (LEFT.MNAME[1..LENGTH(TRIM(RIGHT.MNAME))] = RIGHT.MNAME OR RIGHT.MNAME[1..LENGTH(TRIM(LEFT.MNAME))] = LEFT.MNAME OR SALT29.WithinEditN(LEFT.MNAME,RIGHT.MNAME,2, 0) ) AND (LEFT.LNAME = (TYPEOF(LEFT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR metaphonelib.DMetaPhone1(LEFT.LNAME)=metaphonelib.DMetaPhone1(RIGHT.LNAME) OR SALT29.WithinEditN(LEFT.LNAME,RIGHT.LNAME,1, 0) OR SALT29.HyphenMatch(LEFT.LNAME,RIGHT.LNAME,1)<=2 )
          OR SALT29.fn_concept_wordbag_EditN.Match3((SALT29.StrType)RIGHT.FNAME,RIGHT.FNAME_MAINNAME_weight100,true,0,true,1,(SALT29.StrType)RIGHT.MNAME,RIGHT.MNAME_MAINNAME_weight100,true,0,true,2,(SALT29.StrType)RIGHT.LNAME,RIGHT.LNAME_MAINNAME_weight100,true,0,false,1,(SALT29.StrType)LEFT.FNAME,0,(SALT29.StrType)LEFT.MNAME,0,(SALT29.StrType)LEFT.LNAME,0)>= 0) ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID
     AND LEFT.SRC = RIGHT.SRC,10000),HASH,HINT(unsorted_output)); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := Process_xLNPID_Layouts.CombineLinkpathScores(J2); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT29.MAC_Dups_Restore(J3,DD,J4,Reference,TRUE)
  RETURN J4;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_VENDOR_ID='',Input_SRC='',Input_FNAME='',Input_MNAME='',Input_LNAME='',Input_SNAME='',Input_GENDER='',Input_DOB='',output_file,AsIndex='true') := MACRO
IMPORT SALT29,PRTE_Health_Provider_Services;
#IF(#TEXT(Input_VENDOR_ID)<>'' AND #TEXT(Input_SRC)<>'')
  #uniquename(trans)
  PRTE_Health_Provider_Services.Key_HealthProvider_VEN.InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    SELF.VENDOR_ID := (TYPEOF(SELF.VENDOR_ID))le.Input_VENDOR_ID;
    SELF.SRC := (TYPEOF(SELF.SRC))le.Input_SRC;
    #IF ( #TEXT(Input_FNAME) <> '' )
      SELF.FNAME := (TYPEOF(SELF.FNAME))le.Input_FNAME;
    #END
    #IF ( #TEXT(Input_MNAME) <> '' )
      SELF.MNAME := (TYPEOF(SELF.MNAME))le.Input_MNAME;
    #END
    #IF ( #TEXT(Input_LNAME) <> '' )
      SELF.LNAME := (TYPEOF(SELF.LNAME))le.Input_LNAME;
    #END
    #IF ( #TEXT(Input_SNAME) <> '' )
      SELF.SNAME := (TYPEOF(SELF.SNAME))le.Input_SNAME;
    #END
    #IF ( #TEXT(Input_GENDER) <> '' )
      SELF.GENDER := (TYPEOF(SELF.GENDER))le.Input_GENDER;
    #END
    #if ( #TEXT(Input_DOB) <> '' )
      self.DOB := (unsigned4)le.Input_DOB;
    #end
  END;
  #uniquename(p)
  %p% := PROJECT(Infile,%trans%(left));
  output_file := PRTE_Health_Provider_Services.Key_HealthProvider_VEN.ScoredFetch_Batch(%p%,AsIndex);
#ELSE
  output_file := DATASET([],PRTE_Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
END;
