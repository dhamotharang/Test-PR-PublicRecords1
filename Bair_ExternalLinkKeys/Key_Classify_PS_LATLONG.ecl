IMPORT SALT33,ut,std;
EXPORT Key_Classify_PS_LATLONG := MODULE
 
//LATITUDE:LONGITUDE:?:MAINNAME:+:POSSIBLE_SSN
 
EXPORT KeyName := KeyPrefix+'::'+'key::Bair_ExternalLinkKeys'+'::'+Config.KeyInfix+'::EID_HASH::Refs::LATLONG';
 
EXPORT KeyName_sf := KeyPrefix+'::'+'key::Bair_ExternalLinkKeys'+'::'+KeySuperfile+'::EID_HASH::Refs::LATLONG';
 
EXPORT AssignCurrentKeyToSuperFile := FileServices.AddSuperFile(KeyName_sf,KeyName);
 
EXPORT ClearKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(KeyName_sf,,TRUE),FileServices.ClearSuperFile(KeyName_sf));
SHARED h := CandidatesForKey;//The input file - distributed by EID_HASH
layout := RECORD // project out required fields
// Compulsory fields
  h.LATITUDE;
  h.LONGITUDE;
// Optional fields
  h.EID_HASH; // The ID field
  h.FNAME_PreferredName;
  h.FNAME;
  h.MNAME;
  h.LNAME;
// Extra credit fields
  h.POSSIBLE_SSN;
//Scores for various field components
  h.LATITUDE_weight100 ; // Contains 100x the specificity
  h.LONGITUDE_weight100 ; // Contains 100x the specificity
  h.FNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_initial_char_weight100 ; // Contains 100x the specificity
  h.FNAME_p_Weight100;
  h.FNAME_e1_Weight100;
  h.FNAME_e1p_Weight100;
  h.FNAME_PreferredName_Weight100;
  h.FNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.MNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_initial_char_weight100 ; // Contains 100x the specificity
  h.MNAME_e2_Weight100;
  h.MNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.LNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_p_Weight100;
  h.LNAME_e1_Weight100;
  h.LNAME_e1p_Weight100;
  h.LNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.POSSIBLE_SSN_weight100 ; // Contains 100x the specificity
  INTEGER2 POSSIBLE_SSN_e1_Weight100 := SALT33.Min0(h.POSSIBLE_SSN_weight100 + 100*log(h.POSSIBLE_SSN_cnt/h.POSSIBLE_SSN_e1_cnt)/log(2)); // Precompute edit-distance specificity
END;
 
s := Specificities(File_Classify_PS).Specificities[1];
 
DataForKey0 := DEDUP(SORT(TABLE(h((LATITUDE NOT IN SET(s.nulls_LATITUDE,LATITUDE) AND LATITUDE <> (TYPEOF(LATITUDE))''),(LONGITUDE NOT IN SET(s.nulls_LONGITUDE,LONGITUDE) AND LONGITUDE <> (TYPEOF(LONGITUDE))'')),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
 
EXPORT Key := INDEX(DataForKey0,,KeyName_sf);
 
EXPORT BuildAll := BUILDINDEX(Key, OVERWRITE);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,EID_HASH,LATITUDE,LONGITUDE,FNAME,MNAME,LNAME,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_POSSIBLE_SSN := GROUP( DEDUP( SORT( Grpd, EXCEPT POSSIBLE_SSN), EXCEPT POSSIBLE_SSN));
  CntRed_POSSIBLE_SSN := (KeyCnt-COUNT(Rem_POSSIBLE_SSN))/KeyCnt;
EXPORT Shrinkage := DATASET([{'LATLONG','POSSIBLE_SSN',CntRed_POSSIBLE_SSN*100,CntRed_POSSIBLE_SSN*TSize}],SALT33.ShrinkLayout);
EXPORT CanSearch(Process_PS_Layouts.InputLayout le) := le.LATITUDE <> (typeof(le.LATITUDE))'' AND le.LONGITUDE <> (typeof(le.LONGITUDE))'';
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(TYPEOF(h.LATITUDE) param_LATITUDE = (TYPEOF(h.LATITUDE))'',TYPEOF(h.LONGITUDE) param_LONGITUDE = (TYPEOF(h.LONGITUDE))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'') := 
    STEPPED( LIMIT( Key(
          KEYED(( LATITUDE = param_LATITUDE AND param_LATITUDE <> (TYPEOF(LATITUDE))''))
      AND KEYED(( LONGITUDE = param_LONGITUDE AND param_LONGITUDE <> (TYPEOF(LONGITUDE))''))
      AND (( FNAME[1..LENGTH(TRIM(param_FNAME))] = param_FNAME OR param_FNAME[1..LENGTH(TRIM(FNAME))] = FNAME  OR FNAME_PreferredName = fn_PreferredName(param_FNAME) OR metaphonelib.DMetaPhone1(FNAME)=metaphonelib.DMetaPhone1(param_FNAME) OR SALT33.WithinEditN(FNAME,param_FNAME,1, 0) )
        AND ( MNAME[1..LENGTH(TRIM(param_MNAME))] = param_MNAME OR param_MNAME[1..LENGTH(TRIM(MNAME))] = MNAME OR SALT33.WithinEditN(MNAME,param_MNAME,2, 0) )
        AND ( LNAME = (TYPEOF(LNAME))'' OR param_LNAME = (TYPEOF(LNAME))'' OR metaphonelib.DMetaPhone1(LNAME)=metaphonelib.DMetaPhone1(param_LNAME) OR SALT33.WithinEditN(LNAME,param_LNAME,1, 0) OR SALT33.HyphenMatch(LNAME,param_LNAME,1)<=2 )
        OR SALT33.fn_concept_wordbag_EditN_EL.Match3((SALT33.StrType)FNAME,FNAME_MAINNAME_weight100,true,0,true,FNAME_initial_char_weight100,1,(SALT33.StrType)MNAME,MNAME_MAINNAME_weight100,true,0,true,MNAME_initial_char_weight100,2,(SALT33.StrType)LNAME,LNAME_MAINNAME_weight100,true,0,false,0,1,(SALT33.StrType)param_FNAME,(SALT33.StrType)param_MNAME,(SALT33.StrType)param_LNAME) > 0)),5000,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),EID_HASH);
 
 
EXPORT ScoredEID_HASHFetch(TYPEOF(h.LATITUDE) param_LATITUDE = (TYPEOF(h.LATITUDE))'',TYPEOF(h.LONGITUDE) param_LONGITUDE = (TYPEOF(h.LONGITUDE))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.POSSIBLE_SSN) param_POSSIBLE_SSN = (TYPEOF(h.POSSIBLE_SSN))'') := FUNCTION
  RawData := RawFetch(param_LATITUDE,param_LONGITUDE,param_FNAME,param_MNAME,param_LNAME);
 
  Process_PS_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 12; // Set bitmap for key used
    SELF.keys_failed := IF(le.EID_HASH = 0, 1 << 12, 0); // Set bitmap for key failed
    SELF.LATITUDE_match_code := MAP(le.LATITUDE = (TYPEOF(le.LATITUDE))'' OR le.LATITUDE = (TYPEOF(le.LATITUDE))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_LATITUDE(le.LATITUDE,param_LATITUDE,TRUE));
    SELF.LATITUDEWeight := (50+MAP ( le.LATITUDE = param_LATITUDE  => le.LATITUDE_weight100,
          le.LATITUDE = (TYPEOF(le.LATITUDE))'' OR param_LATITUDE = (TYPEOF(le.LATITUDE))'' => 0,
          -1.000*le.LATITUDE_weight100))/100; 
    SELF.LONGITUDE_match_code := MAP(le.LONGITUDE = (TYPEOF(le.LONGITUDE))'' OR le.LONGITUDE = (TYPEOF(le.LONGITUDE))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_LONGITUDE(le.LONGITUDE,param_LONGITUDE,TRUE));
    SELF.LONGITUDEWeight := (50+MAP ( le.LONGITUDE = param_LONGITUDE  => le.LONGITUDE_weight100,
          le.LONGITUDE = (TYPEOF(le.LONGITUDE))'' OR param_LONGITUDE = (TYPEOF(le.LONGITUDE))'' => 0,
          -1.000*le.LONGITUDE_weight100))/100; 
    SELF.FNAME_match_code := MAP(le.FNAME = (TYPEOF(le.FNAME))'' OR param_FNAME = (TYPEOF(param_FNAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_FNAME(le.FNAME,param_FNAME,0,0,FALSE));
    SELF.FNAMEWeight := (50+MAP ( le.FNAME = (TYPEOF(le.FNAME))'' OR param_FNAME = (TYPEOF(param_FNAME))'' => 0,
           le.FNAME = param_FNAME  => le.FNAME_weight100,
           le.FNAME_PreferredName = fn_PreferredName(param_FNAME) => le.FNAME_PreferredName_weight100,
           le.FNAME = param_FNAME[1..LENGTH(TRIM(le.FNAME))] => le.FNAME_weight100,
           SALT33.WithinEditN(le.FNAME,param_FNAME,1, 0) => IF( metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(param_FNAME),le.FNAME_e1p_weight100,le.FNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(param_FNAME)=>le.FNAME_p_weight100,
           le.FNAME[1..LENGTH(TRIM(param_FNAME))] = param_FNAME => SALT33.Fn_Interpolate_Initial(le.FNAME,param_FNAME,le.FNAME_weight100,le.FNAME_initial_char_weight100), // later in sequence as less accurate
           -0.737*le.FNAME_weight100))/100*0.80; 
    SELF.MNAME_match_code := MAP(le.MNAME = (TYPEOF(le.MNAME))'' OR param_MNAME = (TYPEOF(param_MNAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_MNAME(le.MNAME,param_MNAME,0,0,FALSE));
    SELF.MNAMEWeight := (50+MAP ( le.MNAME = (TYPEOF(le.MNAME))'' OR param_MNAME = (TYPEOF(param_MNAME))'' => 0,
           le.MNAME = param_MNAME  => le.MNAME_weight100,
           le.MNAME = param_MNAME[1..LENGTH(TRIM(le.MNAME))] => le.MNAME_weight100,
           SALT33.WithinEditN(le.MNAME,param_MNAME,2, 0) => le.MNAME_e2_weight100,
           le.MNAME[1..LENGTH(TRIM(param_MNAME))] = param_MNAME => SALT33.Fn_Interpolate_Initial(le.MNAME,param_MNAME,le.MNAME_weight100,le.MNAME_initial_char_weight100), // later in sequence as less accurate
           -0.772*le.MNAME_weight100))/100*0.80; 
    SELF.LNAME_match_code := MAP(le.LNAME = (TYPEOF(le.LNAME))'' OR param_LNAME = (TYPEOF(param_LNAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_LNAME(le.LNAME,param_LNAME,0,0,FALSE));
    SELF.LNAMEWeight := (50+MAP ( le.LNAME = (TYPEOF(le.LNAME))'' OR param_LNAME = (TYPEOF(param_LNAME))'' => 0,
           le.LNAME = param_LNAME  => le.LNAME_weight100,
           SALT33.WithinEditN(le.LNAME,param_LNAME,1, 0) => IF( metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(param_LNAME),le.LNAME_e1p_weight100,le.LNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(param_LNAME)=>le.LNAME_p_weight100,
           SALT33.HyphenMatch(le.LNAME,param_LNAME,1)<=2 => le.LNAME_weight100*MIN(1,LENGTH(TRIM(param_LNAME))/LENGTH(TRIM(le.LNAME))),
           -0.617*le.LNAME_weight100))/100*0.80; 
    SELF.MAINNAME_match_code := match_methods(File_Classify_PS).match_MAINNAME(HASH32(le.FNAME,le.MNAME,le.LNAME),HASH32(param_FNAME,param_MNAME,param_LNAME),(SALT33.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,true,0,true,le.FNAME_initial_char_weight100,1,(SALT33.StrType)le.MNAME,le.MNAME_MAINNAME_weight100,true,0,true,le.MNAME_initial_char_weight100,2,(SALT33.StrType)le.LNAME,le.LNAME_MAINNAME_weight100,true,0,false,0,1,(SALT33.StrType)param_FNAME,0,(SALT33.StrType)param_MNAME,0,(SALT33.StrType)param_LNAME,0,true);
    SELF.MAINNAMEWeight := (50+MAP(HASH32(le.FNAME,le.MNAME,le.LNAME)=HASH32(param_FNAME,param_MNAME,param_LNAME) => le.FNAME_weight100+le.MNAME_weight100+le.LNAME_weight100,
           SALT33.fn_concept_wordbag_EditN_EL.Match3((SALT33.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,true,0,true,le.FNAME_initial_char_weight100,1,(SALT33.StrType)le.MNAME,le.MNAME_MAINNAME_weight100,true,0,true,le.MNAME_initial_char_weight100,2,(SALT33.StrType)le.LNAME,le.LNAME_MAINNAME_weight100,true,0,false,0,1,(SALT33.StrType)param_FNAME,(SALT33.StrType)param_MNAME,(SALT33.StrType)param_LNAME)))/100; //Concept could score even if fields do not
    SELF.POSSIBLE_SSN_match_code := MAP(le.POSSIBLE_SSN = (TYPEOF(le.POSSIBLE_SSN))'' OR param_POSSIBLE_SSN = (TYPEOF(param_POSSIBLE_SSN))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_POSSIBLE_SSN(le.POSSIBLE_SSN,param_POSSIBLE_SSN,0,0,FALSE));
    SELF.POSSIBLE_SSNWeight := (50+MAP ( le.POSSIBLE_SSN = (TYPEOF(le.POSSIBLE_SSN))'' OR param_POSSIBLE_SSN = (TYPEOF(param_POSSIBLE_SSN))'' => 0,
           le.POSSIBLE_SSN = param_POSSIBLE_SSN  => le.POSSIBLE_SSN_weight100,
           SALT33.WithinEditN(le.POSSIBLE_SSN,param_POSSIBLE_SSN,1, 0) => le.POSSIBLE_SSN_e1_weight100,
           -0.965*le.POSSIBLE_SSN_weight100))/100; 
    SELF.Weight := IF(le.EID_HASH = 0, 100, MAX(0,SELF.LATITUDEWeight) + MAX(0,SELF.LONGITUDEWeight) + MAX(self.MAINNAMEWeight,MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.LNAMEWeight)) + MAX(0,SELF.POSSIBLE_SSNWeight));
    SELF := le;
  END;
  RETURN ROLLUP(PROJECT(NOFOLD(RawData),Score(LEFT)),LEFT.EID_HASH = RIGHT.EID_HASH,Process_PS_Layouts.combine_scores(LEFT,RIGHT));
END;
 
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT33.UIDType Reference;//How to recognize this record in the subsequent
  TYPEOF(h.LATITUDE) LATITUDE := (TYPEOF(h.LATITUDE))'';
  TYPEOF(h.LONGITUDE) LONGITUDE := (TYPEOF(h.LONGITUDE))'';
  SALT33.StrType MAINNAME := (SALT33.StrType)'';
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))'';
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))'';
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))'';
  TYPEOF(h.POSSIBLE_SSN) POSSIBLE_SSN := (TYPEOF(h.POSSIBLE_SSN))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex) := FUNCTION
 
  Process_PS_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 12; // Set bitmap for key used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.LATITUDE_match_code := MAP(le.LATITUDE = (TYPEOF(le.LATITUDE))'' OR le.LATITUDE = (TYPEOF(le.LATITUDE))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_LATITUDE(le.LATITUDE,ri.LATITUDE,TRUE));
    SELF.LATITUDEWeight := (50+MAP ( le.LATITUDE = ri.LATITUDE  => le.LATITUDE_weight100,
          le.LATITUDE = (TYPEOF(le.LATITUDE))'' OR ri.LATITUDE = (TYPEOF(le.LATITUDE))'' => 0,
          -1.000*le.LATITUDE_weight100))/100; 
    SELF.LONGITUDE_match_code := MAP(le.LONGITUDE = (TYPEOF(le.LONGITUDE))'' OR le.LONGITUDE = (TYPEOF(le.LONGITUDE))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_LONGITUDE(le.LONGITUDE,ri.LONGITUDE,TRUE));
    SELF.LONGITUDEWeight := (50+MAP ( le.LONGITUDE = ri.LONGITUDE  => le.LONGITUDE_weight100,
          le.LONGITUDE = (TYPEOF(le.LONGITUDE))'' OR ri.LONGITUDE = (TYPEOF(le.LONGITUDE))'' => 0,
          -1.000*le.LONGITUDE_weight100))/100; 
    SELF.FNAME_match_code := MAP(le.FNAME = (TYPEOF(le.FNAME))'' OR ri.FNAME = (TYPEOF(ri.FNAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_FNAME(le.FNAME,ri.FNAME,0,0,FALSE));
    SELF.FNAMEWeight := (50+MAP ( le.FNAME = (TYPEOF(le.FNAME))'' OR ri.FNAME = (TYPEOF(ri.FNAME))'' => 0,
           le.FNAME = ri.FNAME  => le.FNAME_weight100,
           le.FNAME_PreferredName = fn_PreferredName(ri.FNAME) => le.FNAME_PreferredName_weight100,
           le.FNAME = ri.FNAME[1..LENGTH(TRIM(le.FNAME))] => le.FNAME_weight100,
           SALT33.WithinEditN(le.FNAME,ri.FNAME,1, 0) => IF( metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(ri.FNAME),le.FNAME_e1p_weight100,le.FNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(ri.FNAME)=>le.FNAME_p_weight100,
           le.FNAME[1..LENGTH(TRIM(ri.FNAME))] = ri.FNAME => SALT33.Fn_Interpolate_Initial(le.FNAME,ri.FNAME,le.FNAME_weight100,le.FNAME_initial_char_weight100), // later in sequence as less accurate
           -0.737*le.FNAME_weight100))/100*0.80; 
    SELF.MNAME_match_code := MAP(le.MNAME = (TYPEOF(le.MNAME))'' OR ri.MNAME = (TYPEOF(ri.MNAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_MNAME(le.MNAME,ri.MNAME,0,0,FALSE));
    SELF.MNAMEWeight := (50+MAP ( le.MNAME = (TYPEOF(le.MNAME))'' OR ri.MNAME = (TYPEOF(ri.MNAME))'' => 0,
           le.MNAME = ri.MNAME  => le.MNAME_weight100,
           le.MNAME = ri.MNAME[1..LENGTH(TRIM(le.MNAME))] => le.MNAME_weight100,
           SALT33.WithinEditN(le.MNAME,ri.MNAME,2, 0) => le.MNAME_e2_weight100,
           le.MNAME[1..LENGTH(TRIM(ri.MNAME))] = ri.MNAME => SALT33.Fn_Interpolate_Initial(le.MNAME,ri.MNAME,le.MNAME_weight100,le.MNAME_initial_char_weight100), // later in sequence as less accurate
           -0.772*le.MNAME_weight100))/100*0.80; 
    SELF.LNAME_match_code := MAP(le.LNAME = (TYPEOF(le.LNAME))'' OR ri.LNAME = (TYPEOF(ri.LNAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_LNAME(le.LNAME,ri.LNAME,0,0,FALSE));
    SELF.LNAMEWeight := (50+MAP ( le.LNAME = (TYPEOF(le.LNAME))'' OR ri.LNAME = (TYPEOF(ri.LNAME))'' => 0,
           le.LNAME = ri.LNAME  => le.LNAME_weight100,
           SALT33.WithinEditN(le.LNAME,ri.LNAME,1, 0) => IF( metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(ri.LNAME),le.LNAME_e1p_weight100,le.LNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(ri.LNAME)=>le.LNAME_p_weight100,
           SALT33.HyphenMatch(le.LNAME,ri.LNAME,1)<=2 => le.LNAME_weight100*MIN(1,LENGTH(TRIM(ri.LNAME))/LENGTH(TRIM(le.LNAME))),
           -0.617*le.LNAME_weight100))/100*0.80; 
    SELF.MAINNAME_match_code := match_methods(File_Classify_PS).match_MAINNAME(HASH32(le.FNAME,le.MNAME,le.LNAME),HASH32(ri.FNAME,ri.MNAME,ri.LNAME),(SALT33.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,true,0,true,le.FNAME_initial_char_weight100,1,(SALT33.StrType)le.MNAME,le.MNAME_MAINNAME_weight100,true,0,true,le.MNAME_initial_char_weight100,2,(SALT33.StrType)le.LNAME,le.LNAME_MAINNAME_weight100,true,0,false,0,1,(SALT33.StrType)ri.FNAME,0,(SALT33.StrType)ri.MNAME,0,(SALT33.StrType)ri.LNAME,0,true);
    SELF.MAINNAMEWeight := (50+MAP(HASH32(le.FNAME,le.MNAME,le.LNAME)=HASH32(ri.FNAME,ri.MNAME,ri.LNAME) => le.FNAME_weight100+le.MNAME_weight100+le.LNAME_weight100,
           SALT33.fn_concept_wordbag_EditN_EL.Match3((SALT33.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,true,0,true,le.FNAME_initial_char_weight100,1,(SALT33.StrType)le.MNAME,le.MNAME_MAINNAME_weight100,true,0,true,le.MNAME_initial_char_weight100,2,(SALT33.StrType)le.LNAME,le.LNAME_MAINNAME_weight100,true,0,false,0,1,(SALT33.StrType)ri.FNAME,(SALT33.StrType)ri.MNAME,(SALT33.StrType)ri.LNAME)))/100; //Concept could score even if fields do not
    SELF.POSSIBLE_SSN_match_code := MAP(le.POSSIBLE_SSN = (TYPEOF(le.POSSIBLE_SSN))'' OR ri.POSSIBLE_SSN = (TYPEOF(ri.POSSIBLE_SSN))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_POSSIBLE_SSN(le.POSSIBLE_SSN,ri.POSSIBLE_SSN,0,0,FALSE));
    SELF.POSSIBLE_SSNWeight := (50+MAP ( le.POSSIBLE_SSN = (TYPEOF(le.POSSIBLE_SSN))'' OR ri.POSSIBLE_SSN = (TYPEOF(ri.POSSIBLE_SSN))'' => 0,
           le.POSSIBLE_SSN = ri.POSSIBLE_SSN  => le.POSSIBLE_SSN_weight100,
           SALT33.WithinEditN(le.POSSIBLE_SSN,ri.POSSIBLE_SSN,1, 0) => le.POSSIBLE_SSN_e1_weight100,
           -0.965*le.POSSIBLE_SSN_weight100))/100; 
    SELF.Weight := IF(le.EID_HASH = 0, 100, MAX(0,SELF.LATITUDEWeight) + MAX(0,SELF.LONGITUDEWeight) + MAX(self.MAINNAMEWeight,MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.LNAMEWeight)) + MAX(0,SELF.POSSIBLE_SSNWeight));
    SELF := le;
  END;
  Recs0 := Recs(LATITUDE <> (typeof(LATITUDE))'',LONGITUDE <> (typeof(LONGITUDE))'');
  SALT33.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference,Bair_ExternalLinkKeys.Config.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,LEFT.LATITUDE = RIGHT.LATITUDE
     AND LEFT.LONGITUDE = RIGHT.LONGITUDE
     AND (( ( 
        (LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME OR RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME OR metaphonelib.DMetaPhone1(LEFT.FNAME)=metaphonelib.DMetaPhone1(RIGHT.FNAME) OR SALT33.WithinEditN(LEFT.FNAME,RIGHT.FNAME,1, 0)  OR RIGHT.FNAME_PreferredName = fn_PreferredName(LEFT.FNAME) ) AND (LEFT.MNAME[1..LENGTH(TRIM(RIGHT.MNAME))] = RIGHT.MNAME OR RIGHT.MNAME[1..LENGTH(TRIM(LEFT.MNAME))] = LEFT.MNAME OR SALT33.WithinEditN(LEFT.MNAME,RIGHT.MNAME,2, 0) ) AND (LEFT.LNAME = (TYPEOF(LEFT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR metaphonelib.DMetaPhone1(LEFT.LNAME)=metaphonelib.DMetaPhone1(RIGHT.LNAME) OR SALT33.WithinEditN(LEFT.LNAME,RIGHT.LNAME,1, 0) OR SALT33.HyphenMatch(LEFT.LNAME,RIGHT.LNAME,1)<=2 )
          OR SALT33.fn_concept_wordbag_EditN_EL.Match3((SALT33.StrType)RIGHT.FNAME,RIGHT.FNAME_MAINNAME_weight100,true,0,true,RIGHT.FNAME_initial_char_weight100,1,(SALT33.StrType)RIGHT.MNAME,RIGHT.MNAME_MAINNAME_weight100,true,0,true,RIGHT.MNAME_initial_char_weight100,2,(SALT33.StrType)RIGHT.LNAME,RIGHT.LNAME_MAINNAME_weight100,true,0,false,0,1,(SALT33.StrType)LEFT.FNAME,(SALT33.StrType)LEFT.MNAME,(SALT33.StrType)LEFT.LNAME) > 0) )),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.LATITUDE = RIGHT.LATITUDE
     AND LEFT.LONGITUDE = RIGHT.LONGITUDE,5000)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),LEFT.LATITUDE = RIGHT.LATITUDE
     AND LEFT.LONGITUDE = RIGHT.LONGITUDE
     AND (( ( 
        (LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME OR RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME OR metaphonelib.DMetaPhone1(LEFT.FNAME)=metaphonelib.DMetaPhone1(RIGHT.FNAME) OR SALT33.WithinEditN(LEFT.FNAME,RIGHT.FNAME,1, 0)  OR RIGHT.FNAME_PreferredName = fn_PreferredName(LEFT.FNAME) ) AND (LEFT.MNAME[1..LENGTH(TRIM(RIGHT.MNAME))] = RIGHT.MNAME OR RIGHT.MNAME[1..LENGTH(TRIM(LEFT.MNAME))] = LEFT.MNAME OR SALT33.WithinEditN(LEFT.MNAME,RIGHT.MNAME,2, 0) ) AND (LEFT.LNAME = (TYPEOF(LEFT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR metaphonelib.DMetaPhone1(LEFT.LNAME)=metaphonelib.DMetaPhone1(RIGHT.LNAME) OR SALT33.WithinEditN(LEFT.LNAME,RIGHT.LNAME,1, 0) OR SALT33.HyphenMatch(LEFT.LNAME,RIGHT.LNAME,1)<=2 )
          OR SALT33.fn_concept_wordbag_EditN_EL.Match3((SALT33.StrType)RIGHT.FNAME,RIGHT.FNAME_MAINNAME_weight100,true,0,true,RIGHT.FNAME_initial_char_weight100,1,(SALT33.StrType)RIGHT.MNAME,RIGHT.MNAME_MAINNAME_weight100,true,0,true,RIGHT.MNAME_initial_char_weight100,2,(SALT33.StrType)RIGHT.LNAME,RIGHT.LNAME_MAINNAME_weight100,true,0,false,0,1,(SALT33.StrType)LEFT.FNAME,(SALT33.StrType)LEFT.MNAME,(SALT33.StrType)LEFT.LNAME) > 0) )),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.LATITUDE = RIGHT.LATITUDE
     AND LEFT.LONGITUDE = RIGHT.LONGITUDE,5000),HASH,HINT(unsorted_output)); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := Process_PS_Layouts.CombineLinkpathScores(J2); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT33.MAC_Dups_Restore(J3,DD,J4,Reference,TRUE)
  RETURN J4;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_LATITUDE='',Input_LONGITUDE='',Input_FNAME='',Input_MNAME='',Input_LNAME='',Input_POSSIBLE_SSN='',output_file,AsIndex='true') := MACRO
IMPORT SALT33,Bair_ExternalLinkKeys;
#IF(#TEXT(Input_LATITUDE)<>'' AND #TEXT(Input_LONGITUDE)<>'')
  #uniquename(trans)
  Bair_ExternalLinkKeys.Key_Classify_PS_LATLONG.InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    SELF.LATITUDE := (TYPEOF(SELF.LATITUDE))le.Input_LATITUDE;
    SELF.LONGITUDE := (TYPEOF(SELF.LONGITUDE))le.Input_LONGITUDE;
    #IF ( #TEXT(Input_FNAME) <> '' )
      SELF.FNAME := (TYPEOF(SELF.FNAME))le.Input_FNAME;
    #END
    #IF ( #TEXT(Input_MNAME) <> '' )
      SELF.MNAME := (TYPEOF(SELF.MNAME))le.Input_MNAME;
    #END
    #IF ( #TEXT(Input_LNAME) <> '' )
      SELF.LNAME := (TYPEOF(SELF.LNAME))le.Input_LNAME;
    #END
    #IF ( #TEXT(Input_POSSIBLE_SSN) <> '' )
      SELF.POSSIBLE_SSN := (TYPEOF(SELF.POSSIBLE_SSN))le.Input_POSSIBLE_SSN;
    #END
  END;
  #uniquename(p)
  %p% := PROJECT(Infile,%trans%(left));
  output_file := Bair_ExternalLinkKeys.Key_Classify_PS_LATLONG.ScoredFetch_Batch(%p%,AsIndex);
#ELSE
  output_file := DATASET([],Bair_ExternalLinkKeys.Process_PS_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
END;
