IMPORT SALT37,std;
EXPORT Key_InsuranceHeader_DLN(BOOLEAN incremental=FALSE, UNSIGNED2  aBlockLimit= Config.DLN_MAXBLOCKLIMIT) := MODULE/*HACK25*/
 
//DL_NBR:DL_STATE:?:MAINNAME:+:SSN5:SSN4:DERIVED_GENDER:SNAME:DOB
EXPORT KeyName := KeyNames().DLN_super; /*HACK10*/
 
EXPORT KeyName_sf := '~'+KeyPrefix+'::'+'key::InsuranceHeader_xLink'+'::'+KeySuperfile+'::DID::Refs::DLN';
 
EXPORT AssignCurrentKeyToSuperFile := FileServices.AddSuperFile(KeyName_sf,KeyName);
 
EXPORT ClearKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(KeyName_sf,,TRUE),FileServices.ClearSuperFile(KeyName_sf));
STRING csv_fields := 'DL_NBR,DL_STATE,FNAME,MNAME,LNAME,SSN5,SSN4,DERIVED_GENDER,SNAME,DOB_year,DOB_month,DOB_day,DID';
SHARED h := CandidatesForKey(csv_fields,incremental);//The input file - distributed by DID
layout := RECORD // project out required fields
// Compulsory fields
  h.DL_NBR;
  h.DL_STATE;
// Optional fields
  h.DID; // The ID field
  h.FNAME_PreferredName;
  h.FNAME;
  h.MNAME;
  h.LNAME;
// Extra credit fields
  h.SSN5;
  h.SSN4;
  h.DERIVED_GENDER;
  h.SNAME;
  h.DOB_year;
  h.DOB_month;
  h.DOB_day;
  h.DT_EFFECTIVE_FIRST;
  h.DT_EFFECTIVE_LAST;
  h.DL_NBR_len;
  h.FNAME_len;
  h.MNAME_len;
  h.LNAME_len;
  h.SSN5_len;
  h.SSN4_len;
//Scores for various field components
  h.DL_NBR_weight100 ; // Contains 100x the specificity
  INTEGER2 DL_NBR_e1_Weight100 := SALT37.Min0(h.DL_NBR_weight100 + 100*log(h.DL_NBR_cnt/h.DL_NBR_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.DL_STATE_weight100 ; // Contains 100x the specificity
  h.FNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_MAINNAME_fuzzy_weight100 ; // Contains 100x the specificity
  h.FNAME_initial_char_weight100 ; // Contains 100x the specificity
  h.FNAME_p_Weight100;
  h.FNAME_e1_Weight100;
  h.FNAME_e1p_Weight100;
  h.FNAME_PreferredName_Weight100;
  h.FNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.MNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_MAINNAME_fuzzy_weight100 ; // Contains 100x the specificity
  h.MNAME_initial_char_weight100 ; // Contains 100x the specificity
  h.MNAME_e2_Weight100;
  h.MNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.LNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_MAINNAME_fuzzy_weight100 ; // Contains 100x the specificity
  h.LNAME_p_Weight100;
  h.LNAME_e1_Weight100;
  h.LNAME_e1p_Weight100;
  h.LNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.SSN5_weight100 ; // Contains 100x the specificity
  INTEGER2 SSN5_e1_Weight100 := SALT37.Min0(h.SSN5_weight100 + 100*log(h.SSN5_cnt/h.SSN5_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.SSN4_weight100 ; // Contains 100x the specificity
  INTEGER2 SSN4_e1_Weight100 := SALT37.Min0(h.SSN4_weight100 + 100*log(h.SSN4_cnt/h.SSN4_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.DERIVED_GENDER_weight100 ; // Contains 100x the specificity
  h.DERIVED_GENDER_initial_char_weight100 ; // Contains 100x the specificity
  h.SNAME_weight100 ; // Contains 100x the specificity
  h.DOB_year_weight100; // Contains 100x the specificity
  h.DOB_month_weight100; // Contains 100x the specificity
  h.DOB_day_weight100; // Contains 100x the specificity
END;
 
s := Specificities(File_InsuranceHeader).Specificities[1];
 
DataForKey0 := DEDUP(SORT(TABLE(h((DL_NBR NOT IN SET(s.nulls_DL_NBR,DL_NBR) AND DL_NBR <> (TYPEOF(DL_NBR))''),(DL_STATE NOT IN SET(s.nulls_DL_STATE,DL_STATE) AND DL_STATE <> (TYPEOF(DL_STATE))'')),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
SHARED DataForKey := DataForKey0;
 
EXPORT Key := INDEX(DataForKey,{DataForKey},{BOOLEAN IsIncremental := incremental},KeyName);
 
EXPORT BuildAll := BUILDINDEX(Key, OVERWRITE);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,DID,DL_NBR,DL_STATE,FNAME,MNAME,LNAME,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_SSN5 := GROUP( DEDUP( SORT( Grpd, EXCEPT SSN5), EXCEPT SSN5));
  CntRed_SSN5 := (KeyCnt-COUNT(Rem_SSN5))/KeyCnt;
  Rem_SSN4 := GROUP( DEDUP( SORT( Grpd, EXCEPT SSN4), EXCEPT SSN4));
  CntRed_SSN4 := (KeyCnt-COUNT(Rem_SSN4))/KeyCnt;
  Rem_DERIVED_GENDER := GROUP( DEDUP( SORT( Grpd, EXCEPT DERIVED_GENDER), EXCEPT DERIVED_GENDER));
  CntRed_DERIVED_GENDER := (KeyCnt-COUNT(Rem_DERIVED_GENDER))/KeyCnt;
  Rem_SNAME := GROUP( DEDUP( SORT( Grpd, EXCEPT SNAME), EXCEPT SNAME));
  CntRed_SNAME := (KeyCnt-COUNT(Rem_SNAME))/KeyCnt;
  Rem_DOB := GROUP( DEDUP( SORT( Grpd, EXCEPT DOB_year,DOB_month,DOB_day), EXCEPT DOB_year,DOB_month,DOB_day));
  CntRed_DOB := (KeyCnt-COUNT(Rem_DOB))/KeyCnt;
EXPORT Shrinkage := DATASET([{'DLN','SSN5',CntRed_SSN5*100,CntRed_SSN5*TSize},{'DLN','SSN4',CntRed_SSN4*100,CntRed_SSN4*TSize},{'DLN','DERIVED_GENDER',CntRed_DERIVED_GENDER*100,CntRed_DERIVED_GENDER*TSize},{'DLN','SNAME',CntRed_SNAME*100,CntRed_SNAME*TSize},{'DLN','DOB',CntRed_DOB*100,CntRed_DOB*TSize}],SALT37.ShrinkLayout);
EXPORT MergeKeyFiles(STRING superFileIn, STRING outfileName, UNSIGNED4 minDate = 0, BOOLEAN replaceExisting = FALSE) := FUNCTION
  fieldListIndex := SALT37.MAC_FieldListCSVFromDataset(DataForKey,[],',');
  fieldListPayload := 'IsIncremental';
  RETURN Process_xIDL_Layouts().MAC_GenerateMergedKey(superFileIn, outfileName, minDate, replaceExisting, fieldListIndex, fieldListPayload, 'Key');
END;
EXPORT MAX_BLOCKLIMIT := IF (aBlockLimit=0,  Config.DLN_MAXBLOCKLIMIT, aBlockLimit);/*HACK24a*/
EXPORT CanSearch(Process_xIDL_Layouts().InputLayout le) := le.DL_NBR <> (TYPEOF(le.DL_NBR))'' AND Fields.InValid_DL_NBR((SALT37.StrType)le.DL_NBR)=0 AND le.DL_STATE <> (TYPEOF(le.DL_STATE))'' AND Fields.InValid_DL_STATE((SALT37.StrType)le.DL_STATE)=0;
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(TYPEOF(h.DL_NBR) param_DL_NBR = (TYPEOF(h.DL_NBR))'',TYPEOF(h.DL_NBR_len) param_DL_NBR_len = (TYPEOF(h.DL_NBR_len))'',TYPEOF(h.DL_STATE) param_DL_STATE = (TYPEOF(h.DL_STATE))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'') := 
    STEPPED( LIMIT( Key(
          KEYED(( DL_NBR = param_DL_NBR AND param_DL_NBR <> (TYPEOF(DL_NBR))''))
      AND KEYED(( DL_STATE = param_DL_STATE AND param_DL_STATE <> (TYPEOF(DL_STATE))''))
      AND (( (FNAME[1..LENGTH(TRIM(param_FNAME))] = param_FNAME OR param_FNAME[1..LENGTH(TRIM(FNAME))] = FNAME)  OR FNAME_PreferredName = fn_PreferredName(param_FNAME) OR metaphonelib.DMetaPhone1(FNAME)=metaphonelib.DMetaPhone1(param_FNAME) OR Config.WithinEditN(FNAME,FNAME_len,param_FNAME,param_FNAME_len,1,Config.FNAME_LENGTH_EDIT2) /*HACK02*/ OR Config.WildMatch(FNAME,param_FNAME,FALSE) )
        AND ( (MNAME[1..LENGTH(TRIM(param_MNAME))] = param_MNAME OR param_MNAME[1..LENGTH(TRIM(MNAME))] = MNAME) OR Config.WithinEditN(MNAME,MNAME_len,param_MNAME,param_MNAME_len,2, 0) )
        AND ( LNAME = (TYPEOF(LNAME))'' OR param_LNAME = (TYPEOF(LNAME))'' OR metaphonelib.DMetaPhone1(LNAME)=metaphonelib.DMetaPhone1(param_LNAME) OR Config.WithinEditN(LNAME,LNAME_len,param_LNAME,param_LNAME_len,1,Config.LNAME_LENGTH_EDIT2) /*HACK06*/ OR SALT37.HyphenMatch(LNAME,param_LNAME,1)<=2 OR Config.WildMatch(LNAME,param_LNAME,FALSE) )
        OR (SALT37.fn_concept_wordbag_EditN_EL.Match3((SALT37.StrType)FNAME,FNAME_MAINNAME_weight100,true,0,false,FNAME_initial_char_weight100/*HACK11*/,1,0,FNAME_len,FNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)MNAME,MNAME_MAINNAME_weight100,true,0,true,MNAME_initial_char_weight100,2,0,MNAME_len,MNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)LNAME,LNAME_MAINNAME_weight100,true,0,false,0,1,0,LNAME_len,LNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)param_FNAME,param_FNAME_len,(SALT37.StrType)param_MNAME,param_MNAME_len,(SALT37.StrType)param_LNAME,param_LNAME_len,InsuranceHeader_xLink.Config.WithinEditN) > 0
OR FNAME = param_FNAME))),MAX_BLOCKLIMIT/*HACK24b*/ /*HACK14c*/,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),DID);
 
 
EXPORT ScoredDIDFetch(TYPEOF(h.DL_NBR) param_DL_NBR = (TYPEOF(h.DL_NBR))'',TYPEOF(h.DL_NBR_len) param_DL_NBR_len = (TYPEOF(h.DL_NBR_len))'',TYPEOF(h.DL_STATE) param_DL_STATE = (TYPEOF(h.DL_STATE))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'',TYPEOF(h.SSN5) param_SSN5 = (TYPEOF(h.SSN5))'',TYPEOF(h.SSN5_len) param_SSN5_len = (TYPEOF(h.SSN5_len))'',TYPEOF(h.SSN4) param_SSN4 = (TYPEOF(h.SSN4))'',TYPEOF(h.SSN4_len) param_SSN4_len = (TYPEOF(h.SSN4_len))'',TYPEOF(h.DERIVED_GENDER) param_DERIVED_GENDER = (TYPEOF(h.DERIVED_GENDER))'',TYPEOF(h.SNAME) param_SNAME = (TYPEOF(h.SNAME))'',UNSIGNED4 param_DOB,BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetch(param_DL_NBR,param_DL_NBR_len,param_DL_STATE,param_FNAME,param_MNAME,param_LNAME,param_FNAME_len,param_MNAME_len,param_LNAME_len);
 
  Process_xIDL_Layouts().LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 9; // Set bitmap for keys used
    SELF.keys_poisoned := IF(le.DT_EFFECTIVE_LAST <> 0 AND le.IsIncremental, SELF.keys_used, 0);
    SELF.keys_failed := IF(le.DID = 0, 1 << 9, 0); // Set bitmap for key failed
    SELF.DL_NBR_match_code := MAP(
           le.DL_STATE = (TYPEOF(le.DL_STATE))'' OR param_DL_STATE = (TYPEOF(param_DL_STATE))'' OR le.DL_STATE <> param_DL_STATE => 0, // Only valid if the context variable is equal
           match_methods(File_InsuranceHeader).match_DL_NBR(le.DL_NBR,param_DL_NBR,le.DL_NBR_len,param_DL_NBR_len,TRUE));
    SELF.DL_NBRWeight := (50+MAP (
           le.DL_STATE = (TYPEOF(le.DL_STATE))'' OR param_DL_STATE = (TYPEOF(param_DL_STATE))'' OR le.DL_STATE <> param_DL_STATE => 0, // Only valid if the context variable is equal
           le.DL_NBR = param_DL_NBR  => le.DL_NBR_weight100,
          le.DL_NBR = (TYPEOF(le.DL_NBR))'' OR param_DL_NBR = (TYPEOF(le.DL_NBR))'' => 0,
          -0.876*le.DL_NBR_weight100))/100; 
    SELF.DL_STATE_match_code := match_methods(File_InsuranceHeader).match_DL_STATE(le.DL_STATE,param_DL_STATE,TRUE);
    SELF.DL_STATEWeight := (50+MAP (
           le.DL_STATE = param_DL_STATE  => le.DL_STATE_weight100,
          le.DL_STATE = (TYPEOF(le.DL_STATE))'' OR param_DL_STATE = (TYPEOF(le.DL_STATE))'' => 0,
          -0.975*le.DL_STATE_weight100))/100; 
    SELF.FNAME_match_code := MAP(
           le.FNAME = (TYPEOF(le.FNAME))'' OR param_FNAME = (TYPEOF(param_FNAME))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_FNAME(le.FNAME,param_FNAME,le.FNAME_len,param_FNAME_len,FALSE));
    SELF.FNAMEWeight := (50+MAP (
           le.FNAME = (TYPEOF(le.FNAME))'' OR param_FNAME = (TYPEOF(param_FNAME))'' => 0,
           le.FNAME = param_FNAME  => le.FNAME_weight100,
           le.FNAME = param_FNAME[1..LENGTH(TRIM(le.FNAME))]   =>le.FNAME_weight100,
           le.FNAME[1..LENGTH(TRIM(param_FNAME))] = param_FNAME => SALT37.Fn_Interpolate_Initial(le.FNAME,param_FNAME,le.FNAME_weight100,le.FNAME_initial_char_weight100),
           Config.WithinEditN(le.FNAME,le.FNAME_len,param_FNAME,param_FNAME_len,1,Config.FNAME_LENGTH_EDIT2) /*HACK03*/  =>IF( metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(param_FNAME),le.FNAME_e1p_weight100,le.FNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(param_FNAME)  =>le.FNAME_p_weight100,
           Config.WildMatch(le.FNAME,param_FNAME,false)  =>le.FNAME_weight100 / Config.WildPenalty,
           le.FNAME_PreferredName = fn_PreferredName(param_FNAME) => le.FNAME_PreferredName_weight100,
           -0.737*le.FNAME_weight100))/100*0.80; 
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
    SELF.LNAME_match_code := MAP(
           le.LNAME = (TYPEOF(le.LNAME))'' OR param_LNAME = (TYPEOF(param_LNAME))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_LNAME(le.LNAME,param_LNAME,le.LNAME_len,param_LNAME_len,FALSE));
    SELF.LNAMEWeight := (50+MAP (
           le.LNAME = (TYPEOF(le.LNAME))'' OR param_LNAME = (TYPEOF(param_LNAME))'' => 0,
           le.LNAME = param_LNAME  => le.LNAME_weight100,
           SALT37.HyphenMatch(le.LNAME,param_LNAME,1)<=2  =>le.LNAME_weight100*MIN(1,LENGTH(TRIM(param_LNAME))/LENGTH(TRIM(le.LNAME))),
           Config.WithinEditN(le.LNAME,le.LNAME_len,param_LNAME,param_LNAME_len,1,Config.LNAME_LENGTH_EDIT2) /*HACK07*/  =>IF( metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(param_LNAME),le.LNAME_e1p_weight100,le.LNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(param_LNAME)  =>le.LNAME_p_weight100,
           Config.WildMatch(le.LNAME,param_LNAME,false)  =>le.LNAME_weight100 / Config.WildPenalty,
           -0.617*le.LNAME_weight100))/100*0.80; 
    SELF.MAINNAME_match_code := match_methods(File_InsuranceHeader).match_MAINNAME(HASH32((SALT37.StrType) le.FNAME,(SALT37.StrType) le.MNAME,(SALT37.StrType) le.LNAME),HASH32((SALT37.StrType) param_FNAME,(SALT37.StrType) param_MNAME,(SALT37.StrType) param_LNAME),(SALT37.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,true,0,true,le.FNAME_initial_char_weight100,1,0,le.FNAME_len,le.FNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)le.MNAME,le.MNAME_MAINNAME_weight100,true,0,true,le.MNAME_initial_char_weight100,2,0,le.MNAME_len,le.MNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)le.LNAME,le.LNAME_MAINNAME_weight100,true,0,false,0,1,0,le.LNAME_len,le.LNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)param_FNAME,0,param_FNAME_len,0,(SALT37.StrType)param_MNAME,0,param_MNAME_len,0,(SALT37.StrType)param_LNAME,0,param_LNAME_len,0,FALSE);
    SELF.MAINNAMEWeight := (50+MAP(HASH32((SALT37.StrType) le.FNAME,(SALT37.StrType) le.MNAME,(SALT37.StrType) le.LNAME) = HASH32((SALT37.StrType) param_FNAME,(SALT37.StrType) param_MNAME,(SALT37.StrType) param_LNAME) => le.FNAME_weight100+le.MNAME_weight100+le.LNAME_weight100,
                SALT37.fn_concept_wordbag_EditN_EL.Match3((SALT37.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,true,0,FALSE /*HACK12*/,le.FNAME_initial_char_weight100,1,0,le.FNAME_len,le.FNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)le.MNAME,le.MNAME_MAINNAME_weight100,true,0,true,le.MNAME_initial_char_weight100,2,0,le.MNAME_len,le.MNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)le.LNAME,le.LNAME_MAINNAME_weight100,true,0,false,0,1,0,le.LNAME_len,le.LNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)param_FNAME,param_FNAME_len,(SALT37.StrType)param_MNAME,param_MNAME_len,(SALT37.StrType)param_LNAME,param_LNAME_len,InsuranceHeader_xLink.Config.WithinEditN)))/100; //Concept could score even if fields do not
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
    SELF.Weight := IF(le.DID = 0, 100, MAX(0,SELF.DL_NBRWeight) + MAX(0,SELF.DL_STATEWeight) + MAX(SELF.MAINNAMEWeight,MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.LNAMEWeight)) + MAX(0,SELF.SSN5Weight) + MAX(0,SELF.SSN4Weight) + MAX(0,SELF.DERIVED_GENDERWeight) + MAX(0,SELF.SNAMEWeight) + MAX(0,SELF.DOBWeight));
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
  TYPEOF(h.DL_NBR) DL_NBR := (TYPEOF(h.DL_NBR))'';
  TYPEOF(h.DL_NBR_len) DL_NBR_len := (TYPEOF(h.DL_NBR_len))'';
  TYPEOF(h.DL_STATE) DL_STATE := (TYPEOF(h.DL_STATE))'';
  SALT37.StrType MAINNAME := (SALT37.StrType)'';
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))'';
  TYPEOF(h.FNAME_len) FNAME_len := (TYPEOF(h.FNAME_len))'';
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))'';
  TYPEOF(h.MNAME_len) MNAME_len := (TYPEOF(h.MNAME_len))'';
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))'';
  TYPEOF(h.LNAME_len) LNAME_len := (TYPEOF(h.LNAME_len))'';
  TYPEOF(h.SSN5) SSN5 := (TYPEOF(h.SSN5))'';
  TYPEOF(h.SSN5_len) SSN5_len := (TYPEOF(h.SSN5_len))'';
  TYPEOF(h.SSN4) SSN4 := (TYPEOF(h.SSN4))'';
  TYPEOF(h.SSN4_len) SSN4_len := (TYPEOF(h.SSN4_len))'';
  TYPEOF(h.DERIVED_GENDER) DERIVED_GENDER := (TYPEOF(h.DERIVED_GENDER))'';
  TYPEOF(h.SNAME) SNAME := (TYPEOF(h.SNAME))'';
  unsigned4 DOB := 0;
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex, BOOLEAN In_disableForce = FALSE) := FUNCTION
 
  Process_xIDL_Layouts().LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 9; // Set bitmap for keys used
    SELF.keys_poisoned := IF(le.DT_EFFECTIVE_LAST <> 0 AND le.IsIncremental, SELF.keys_used, 0);
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.DL_NBR_match_code := MAP(
           le.DL_STATE = (TYPEOF(le.DL_STATE))'' OR ri.DL_STATE = (TYPEOF(ri.DL_STATE))'' OR le.DL_STATE <> ri.DL_STATE => 0, // Only valid if the context variable is equal
           match_methods(File_InsuranceHeader).match_DL_NBR(le.DL_NBR,ri.DL_NBR,le.DL_NBR_len,ri.DL_NBR_len,TRUE));
    SELF.DL_NBRWeight := (50+MAP (
           le.DL_STATE = (TYPEOF(le.DL_STATE))'' OR ri.DL_STATE = (TYPEOF(ri.DL_STATE))'' OR le.DL_STATE <> ri.DL_STATE => 0, // Only valid if the context variable is equal
           le.DL_NBR = ri.DL_NBR  => le.DL_NBR_weight100,
          le.DL_NBR = (TYPEOF(le.DL_NBR))'' OR ri.DL_NBR = (TYPEOF(le.DL_NBR))'' => 0,
          -0.876*le.DL_NBR_weight100))/100; 
    SELF.DL_STATE_match_code := match_methods(File_InsuranceHeader).match_DL_STATE(le.DL_STATE,ri.DL_STATE,TRUE);
    SELF.DL_STATEWeight := (50+MAP (
           le.DL_STATE = ri.DL_STATE  => le.DL_STATE_weight100,
          le.DL_STATE = (TYPEOF(le.DL_STATE))'' OR ri.DL_STATE = (TYPEOF(le.DL_STATE))'' => 0,
          -0.975*le.DL_STATE_weight100))/100; 
    SELF.FNAME_match_code := MAP(
           le.FNAME = (TYPEOF(le.FNAME))'' OR ri.FNAME = (TYPEOF(ri.FNAME))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_FNAME(le.FNAME,ri.FNAME,le.FNAME_len,ri.FNAME_len,FALSE));
    SELF.FNAMEWeight := (50+MAP (
           le.FNAME = (TYPEOF(le.FNAME))'' OR ri.FNAME = (TYPEOF(ri.FNAME))'' => 0,
           le.FNAME = ri.FNAME  => le.FNAME_weight100,
           le.FNAME = ri.FNAME[1..LENGTH(TRIM(le.FNAME))]   =>le.FNAME_weight100,
           le.FNAME[1..LENGTH(TRIM(ri.FNAME))] = ri.FNAME => SALT37.Fn_Interpolate_Initial(le.FNAME,ri.FNAME,le.FNAME_weight100,le.FNAME_initial_char_weight100),
           Config.WithinEditN(le.FNAME,le.FNAME_len,ri.FNAME,ri.FNAME_len,1, Config.FNAME_LENGTH_EDIT2) /*HACK04*/  =>IF( metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(ri.FNAME),le.FNAME_e1p_weight100,le.FNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(ri.FNAME)  =>le.FNAME_p_weight100,
           Config.WildMatch(le.FNAME,ri.FNAME,false)  =>le.FNAME_weight100 / Config.WildPenalty,
           le.FNAME_PreferredName = fn_PreferredName(ri.FNAME) => le.FNAME_PreferredName_weight100,
           -0.737*le.FNAME_weight100))/100*0.80; 
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
    SELF.LNAME_match_code := MAP(
           le.LNAME = (TYPEOF(le.LNAME))'' OR ri.LNAME = (TYPEOF(ri.LNAME))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_LNAME(le.LNAME,ri.LNAME,le.LNAME_len,ri.LNAME_len,FALSE));
    SELF.LNAMEWeight := (50+MAP (
           le.LNAME = (TYPEOF(le.LNAME))'' OR ri.LNAME = (TYPEOF(ri.LNAME))'' => 0,
           le.LNAME = ri.LNAME  => le.LNAME_weight100,
           SALT37.HyphenMatch(le.LNAME,ri.LNAME,1)<=2  =>le.LNAME_weight100*MIN(1,LENGTH(TRIM(ri.LNAME))/LENGTH(TRIM(le.LNAME))),
           Config.WithinEditN(le.LNAME,le.LNAME_len,ri.LNAME,ri.LNAME_len,1, Config.LNAME_LENGTH_EDIT2) /*HACK08*/  =>IF( metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(ri.LNAME),le.LNAME_e1p_weight100,le.LNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(ri.LNAME)  =>le.LNAME_p_weight100,
           Config.WildMatch(le.LNAME,ri.LNAME,false)  =>le.LNAME_weight100 / Config.WildPenalty,
           -0.617*le.LNAME_weight100))/100*0.80; 
    SELF.MAINNAME_match_code := match_methods(File_InsuranceHeader).match_MAINNAME(HASH32((SALT37.StrType) le.FNAME,(SALT37.StrType) le.MNAME,(SALT37.StrType) le.LNAME),HASH32((SALT37.StrType) ri.FNAME,(SALT37.StrType) ri.MNAME,(SALT37.StrType) ri.LNAME),(SALT37.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,true,0,true,le.FNAME_initial_char_weight100,1,0,le.FNAME_len,le.FNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)le.MNAME,le.MNAME_MAINNAME_weight100,true,0,true,le.MNAME_initial_char_weight100,2,0,le.MNAME_len,le.MNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)le.LNAME,le.LNAME_MAINNAME_weight100,true,0,false,0,1,0,le.LNAME_len,le.LNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)ri.FNAME,0,ri.FNAME_len,0,(SALT37.StrType)ri.MNAME,0,ri.MNAME_len,0,(SALT37.StrType)ri.LNAME,0,ri.LNAME_len,0,FALSE);
    SELF.MAINNAMEWeight := (50+MAP(HASH32((SALT37.StrType) le.FNAME,(SALT37.StrType) le.MNAME,(SALT37.StrType) le.LNAME) = HASH32((SALT37.StrType) ri.FNAME,(SALT37.StrType) ri.MNAME,(SALT37.StrType) ri.LNAME) => le.FNAME_weight100+le.MNAME_weight100+le.LNAME_weight100,
                SALT37.fn_concept_wordbag_EditN_EL.Match3((SALT37.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,true,0,FALSE /*HACK12*/,le.FNAME_initial_char_weight100,1,0,le.FNAME_len,le.FNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)le.MNAME,le.MNAME_MAINNAME_weight100,true,0,true,le.MNAME_initial_char_weight100,2,0,le.MNAME_len,le.MNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)le.LNAME,le.LNAME_MAINNAME_weight100,true,0,false,0,1,0,le.LNAME_len,le.LNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)ri.FNAME,ri.FNAME_len,(SALT37.StrType)ri.MNAME,ri.MNAME_len,(SALT37.StrType)ri.LNAME,ri.LNAME_len,InsuranceHeader_xLink.Config.WithinEditN)))/100; //Concept could score even if fields do not
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
    SELF.Weight := IF(le.DID = 0, 100, MAX(0,SELF.DL_NBRWeight) + MAX(0,SELF.DL_STATEWeight) + MAX(SELF.MAINNAMEWeight,MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.LNAMEWeight)) + MAX(0,SELF.SSN5Weight) + MAX(0,SELF.SSN4Weight) + MAX(0,SELF.DERIVED_GENDERWeight) + MAX(0,SELF.SNAMEWeight) + MAX(0,SELF.DOBWeight));
    SELF := le;
  END;
  Recs0 := Recs(DL_NBR <> (TYPEOF(DL_NBR))'',DL_STATE <> (TYPEOF(DL_STATE))'');
  SALT37.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference,Config.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,LEFT.DL_NBR = RIGHT.DL_NBR
     AND LEFT.DL_STATE = RIGHT.DL_STATE
     AND (( ( 
        ((LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME OR RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME ) OR metaphonelib.DMetaPhone1(LEFT.FNAME)=metaphonelib.DMetaPhone1(RIGHT.FNAME) OR InsuranceHeader_xLink.Config.WithinEditN(LEFT.FNAME,LEFT.FNAME_len,RIGHT.FNAME,RIGHT.FNAME_len,1, Config.FNAME_LENGTH_EDIT2) /*HACK05*/  OR RIGHT.FNAME_PreferredName = fn_PreferredName(LEFT.FNAME) ) AND ((LEFT.MNAME[1..LENGTH(TRIM(RIGHT.MNAME))] = RIGHT.MNAME OR RIGHT.MNAME[1..LENGTH(TRIM(LEFT.MNAME))] = LEFT.MNAME )OR InsuranceHeader_xLink.Config.WithinEditN(LEFT.MNAME,LEFT.MNAME_len,RIGHT.MNAME,RIGHT.MNAME_len,2, 0) ) AND (LEFT.LNAME = (TYPEOF(LEFT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))''  OR metaphonelib.DMetaPhone1(LEFT.LNAME)=metaphonelib.DMetaPhone1(RIGHT.LNAME) OR InsuranceHeader_xLink.Config.WithinEditN(LEFT.LNAME,LEFT.LNAME_len,RIGHT.LNAME,RIGHT.LNAME_len,1, Config.LNAME_LENGTH_EDIT2) /*HACK09*/ OR SALT37.HyphenMatch(LEFT.LNAME,RIGHT.LNAME,1)<=2 )
          OR (SALT37.fn_concept_wordbag_EditN_EL.Match3((SALT37.StrType)RIGHT.FNAME,RIGHT.FNAME_MAINNAME_weight100,true,0,false/*HACK13*/,RIGHT.FNAME_initial_char_weight100,1,0,RIGHT.FNAME_len,RIGHT.FNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)RIGHT.MNAME,RIGHT.MNAME_MAINNAME_weight100,true,0,true,RIGHT.MNAME_initial_char_weight100,2,0,RIGHT.MNAME_len,RIGHT.MNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)RIGHT.LNAME,RIGHT.LNAME_MAINNAME_weight100,true,0,false,0,1,0,RIGHT.LNAME_len,RIGHT.LNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)LEFT.FNAME,LEFT.FNAME_len,(SALT37.StrType)LEFT.MNAME,LEFT.MNAME_len,(SALT37.StrType)LEFT.LNAME,LEFT.LNAME_len,InsuranceHeader_xLink.Config.WithinEditN) > 0
 OR LEFT.FNAME = RIGHT.FNAME)) )),/*HACK14d*/Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.DL_NBR = RIGHT.DL_NBR
     AND LEFT.DL_STATE = RIGHT.DL_STATE,Config.DLN_MAXBLOCKSIZE)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),LEFT.DL_NBR = RIGHT.DL_NBR
     AND LEFT.DL_STATE = RIGHT.DL_STATE
     AND (( ( 
        ((LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME OR RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME ) OR metaphonelib.DMetaPhone1(LEFT.FNAME)=metaphonelib.DMetaPhone1(RIGHT.FNAME) OR InsuranceHeader_xLink.Config.WithinEditN(LEFT.FNAME,LEFT.FNAME_len,RIGHT.FNAME,RIGHT.FNAME_len,1, Config.FNAME_LENGTH_EDIT2) /*HACK05*/  OR RIGHT.FNAME_PreferredName = fn_PreferredName(LEFT.FNAME) ) AND ((LEFT.MNAME[1..LENGTH(TRIM(RIGHT.MNAME))] = RIGHT.MNAME OR RIGHT.MNAME[1..LENGTH(TRIM(LEFT.MNAME))] = LEFT.MNAME )OR InsuranceHeader_xLink.Config.WithinEditN(LEFT.MNAME,LEFT.MNAME_len,RIGHT.MNAME,RIGHT.MNAME_len,2, 0) ) AND (LEFT.LNAME = (TYPEOF(LEFT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))''  OR metaphonelib.DMetaPhone1(LEFT.LNAME)=metaphonelib.DMetaPhone1(RIGHT.LNAME) OR InsuranceHeader_xLink.Config.WithinEditN(LEFT.LNAME,LEFT.LNAME_len,RIGHT.LNAME,RIGHT.LNAME_len,1, Config.LNAME_LENGTH_EDIT2) /*HACK09*/ OR SALT37.HyphenMatch(LEFT.LNAME,RIGHT.LNAME,1)<=2 )
          OR (SALT37.fn_concept_wordbag_EditN_EL.Match3((SALT37.StrType)RIGHT.FNAME,RIGHT.FNAME_MAINNAME_weight100,true,0,false/*HACK13*/,RIGHT.FNAME_initial_char_weight100,1,0,RIGHT.FNAME_len,RIGHT.FNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)RIGHT.MNAME,RIGHT.MNAME_MAINNAME_weight100,true,0,true,RIGHT.MNAME_initial_char_weight100,2,0,RIGHT.MNAME_len,RIGHT.MNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)RIGHT.LNAME,RIGHT.LNAME_MAINNAME_weight100,true,0,false,0,1,0,RIGHT.LNAME_len,RIGHT.LNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)LEFT.FNAME,LEFT.FNAME_len,(SALT37.StrType)LEFT.MNAME,LEFT.MNAME_len,(SALT37.StrType)LEFT.LNAME,LEFT.LNAME_len,InsuranceHeader_xLink.Config.WithinEditN) > 0
 OR LEFT.FNAME = RIGHT.FNAME)) )),/*HACK14d*/Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.DL_NBR = RIGHT.DL_NBR
     AND LEFT.DL_STATE = RIGHT.DL_STATE,Config.DLN_MAXBLOCKSIZE),HASH,UNORDERED); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := PROJECT(J2, Process_xIDL_Layouts().update_forcefailed(LEFT,In_disableForce));
  J4 := Process_xIDL_Layouts().CombineLinkpathScores(J3,In_disableForce); // Combine results and restrict number for one linkpath
  J5 := PROJECT(J4(keys_poisoned > 0), Process_xIDL_Layouts().apply_poison(LEFT)) & J4(keys_poisoned = 0);
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT37.MAC_Dups_Restore(J5,DD,J6,Reference,TRUE)
  RETURN J6;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_DL_NBR='',Input_DL_STATE='',Input_FNAME='',Input_MNAME='',Input_LNAME='',Input_SSN5='',Input_SSN4='',Input_DERIVED_GENDER='',Input_SNAME='',Input_DOB='',output_file,AsIndex='true', In_disableForce = 'false') := MACRO
IMPORT SALT37,InsuranceHeader_xLink;
#IF(#TEXT(Input_DL_NBR)<>'' AND #TEXT(Input_DL_STATE)<>'')
  #uniquename(trans)
  InsuranceHeader_xLink.Key_InsuranceHeader_DLN().InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    SELF.DL_NBR := (TYPEOF(SELF.DL_NBR))le.Input_DL_NBR;
    SELF.DL_NBR_len := LENGTH(TRIM((TYPEOF(SELF.DL_NBR))le.Input_DL_NBR));
    SELF.DL_STATE := (TYPEOF(SELF.DL_STATE))le.Input_DL_STATE;
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
      SELF.LNAME_len := LENGTH(TRIM((TYPEOF(SELF.LNAME))le.Input_LNAME));
    #END
    #IF ( #TEXT(Input_SSN5) <> '' )
      SELF.SSN5 := (TYPEOF(SELF.SSN5))le.Input_SSN5;
      SELF.SSN5_len := LENGTH(TRIM((TYPEOF(SELF.SSN5))le.Input_SSN5));
    #END
    #IF ( #TEXT(Input_SSN4) <> '' )
      SELF.SSN4 := (TYPEOF(SELF.SSN4))le.Input_SSN4;
      SELF.SSN4_len := LENGTH(TRIM((TYPEOF(SELF.SSN4))le.Input_SSN4));
    #END
    #IF ( #TEXT(Input_DERIVED_GENDER) <> '' )
      SELF.DERIVED_GENDER := (TYPEOF(SELF.DERIVED_GENDER))le.Input_DERIVED_GENDER;
    #END
    #IF ( #TEXT(Input_SNAME) <> '' )
      SELF.SNAME := (TYPEOF(SELF.SNAME))le.Input_SNAME;
    #END
    #if ( #TEXT(Input_DOB) <> '' )
      self.DOB := (unsigned4)le.Input_DOB;
    #end
  END;
  #uniquename(p)
  %p% := PROJECT(Infile,%trans%(left));
  output_file := InsuranceHeader_xLink.Key_InsuranceHeader_DLN().ScoredFetch_Batch(%p%,AsIndex, In_disableForce);
#ELSE
  output_file := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
END;
