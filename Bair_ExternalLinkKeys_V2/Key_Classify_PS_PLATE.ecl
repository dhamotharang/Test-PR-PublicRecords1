IMPORT SALT37,std;
EXPORT Key_Classify_PS_PLATE := MODULE
 
//PLATE:?:MAINNAME:+:P_CITY_NAME:ST
EXPORT KeyName := KeyPrefix+'::'+'key::Bair_ExternalLinkKeys_V2'+'::'+Config.KeyInfix+'::EID_HASH::Refs::PLATE';
 
EXPORT KeyName_sf := KeyPrefix+'::'+'key::Bair_ExternalLinkKeys_V2'+'::'+KeySuperfile+'::EID_HASH::Refs::PLATE';
 
EXPORT AssignCurrentKeyToSuperFile := FileServices.AddSuperFile(KeyName_sf,KeyName);
 
EXPORT ClearKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(KeyName_sf,,TRUE),FileServices.ClearSuperFile(KeyName_sf));
SHARED h := CandidatesForKey;//The input file - distributed by EID_HASH
layout := RECORD // project out required fields
// Compulsory fields
  h.PLATE;
// Optional fields
  h.EID_HASH; // The ID field
  h.FNAME_PreferredName;
  h.FNAME;
  h.MNAME;
  h.LNAME;
// Extra credit fields
  h.P_CITY_NAME;
  h.ST;
  h.FNAME_len;
  h.MNAME_len;
//Scores for various field components
  h.PLATE_weight100 ; // Contains 100x the specificity
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
  h.P_CITY_NAME_weight100 ; // Contains 100x the specificity
  h.ST_weight100 ; // Contains 100x the specificity
END;
 
s := Specificities(File_Classify_PS).Specificities[1];
 
DataForKey0 := DEDUP(SORT(TABLE(h((PLATE NOT IN SET(s.nulls_PLATE,PLATE) AND PLATE <> (TYPEOF(PLATE))'')),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
SHARED DataForKey := DataForKey0;
 
EXPORT Key := INDEX(DataForKey,{DataForKey},{},KeyName_sf);
 
EXPORT BuildAll := BUILDINDEX(Key, OVERWRITE);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,EID_HASH,PLATE,FNAME,MNAME,LNAME,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_P_CITY_NAME := GROUP( DEDUP( SORT( Grpd, EXCEPT P_CITY_NAME), EXCEPT P_CITY_NAME));
  CntRed_P_CITY_NAME := (KeyCnt-COUNT(Rem_P_CITY_NAME))/KeyCnt;
  Rem_ST := GROUP( DEDUP( SORT( Grpd, EXCEPT ST), EXCEPT ST));
  CntRed_ST := (KeyCnt-COUNT(Rem_ST))/KeyCnt;
EXPORT Shrinkage := DATASET([{'PLATE','P_CITY_NAME',CntRed_P_CITY_NAME*100,CntRed_P_CITY_NAME*TSize},{'PLATE','ST',CntRed_ST*100,CntRed_ST*TSize}],SALT37.ShrinkLayout);
EXPORT CanSearch(Process_PS_Layouts.InputLayout le) := le.PLATE <> (TYPEOF(le.PLATE))'' AND Fields.InValid_PLATE((SALT37.StrType)le.PLATE)=0;
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(TYPEOF(h.PLATE) param_PLATE = (TYPEOF(h.PLATE))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'') := 
    STEPPED( LIMIT( Key(
          KEYED(( PLATE = param_PLATE AND param_PLATE <> (TYPEOF(PLATE))''))
      AND ( (FNAME[1..LENGTH(TRIM(param_FNAME))] = param_FNAME OR param_FNAME[1..LENGTH(TRIM(FNAME))] = FNAME)  OR FNAME_PreferredName = fn_PreferredName(param_FNAME) OR metaphonelib.DMetaPhone1(FNAME)=metaphonelib.DMetaPhone1(param_FNAME) OR Config.WithinEditN(FNAME,FNAME_len,param_FNAME,param_FNAME_len,1, 0) )
        AND ( (MNAME[1..LENGTH(TRIM(param_MNAME))] = param_MNAME OR param_MNAME[1..LENGTH(TRIM(MNAME))] = MNAME) OR Config.WithinEditN(MNAME,MNAME_len,param_MNAME,param_MNAME_len,2, 0) )
        AND ( LNAME = (TYPEOF(LNAME))'' OR param_LNAME = (TYPEOF(LNAME))'' OR SALT37.MatchBagOfWords(LNAME,param_LNAME,31744,3) > Config.LNAME_Force * 100)),Config.PLATE_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),EID_HASH);
 
 
EXPORT ScoredEID_HASHFetch(TYPEOF(h.PLATE) param_PLATE = (TYPEOF(h.PLATE))'',TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.MNAME) param_MNAME = (TYPEOF(h.MNAME))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.MNAME_len) param_MNAME_len = (TYPEOF(h.MNAME_len))'',TYPEOF(h.P_CITY_NAME) param_P_CITY_NAME = (TYPEOF(h.P_CITY_NAME))'',TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetch(param_PLATE,param_FNAME,param_MNAME,param_LNAME,param_FNAME_len,param_MNAME_len);
 
  Process_PS_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 12; // Set bitmap for keys used
    SELF.keys_failed := IF(le.EID_HASH = 0, 1 << 12, 0); // Set bitmap for key failed
    SELF.PLATE_match_code := match_methods(File_Classify_PS).match_PLATE(le.PLATE,param_PLATE,TRUE);
    SELF.PLATEWeight := (50+MAP (
           le.PLATE = param_PLATE  => le.PLATE_weight100,
          le.PLATE = (TYPEOF(le.PLATE))'' OR param_PLATE = (TYPEOF(le.PLATE))'' => 0,
          -1.000*le.PLATE_weight100))/100; 
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
    SELF.Weight := IF(le.EID_HASH = 0, 100, MAX(0,SELF.PLATEWeight) + MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.LNAMEWeight) + MAX(0,SELF.P_CITY_NAMEWeight) + MAX(0,SELF.STWeight));
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
  TYPEOF(h.PLATE) PLATE := (TYPEOF(h.PLATE))'';
  SALT37.StrType MAINNAME := (SALT37.StrType)'';
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))'';
  TYPEOF(h.FNAME_len) FNAME_len := (TYPEOF(h.FNAME_len))'';
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))'';
  TYPEOF(h.MNAME_len) MNAME_len := (TYPEOF(h.MNAME_len))'';
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))'';
  TYPEOF(h.P_CITY_NAME) P_CITY_NAME := (TYPEOF(h.P_CITY_NAME))'';
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex, BOOLEAN In_disableForce = FALSE) := FUNCTION
 
  Process_PS_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 12; // Set bitmap for keys used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.PLATE_match_code := match_methods(File_Classify_PS).match_PLATE(le.PLATE,ri.PLATE,TRUE);
    SELF.PLATEWeight := (50+MAP (
           le.PLATE = ri.PLATE  => le.PLATE_weight100,
          le.PLATE = (TYPEOF(le.PLATE))'' OR ri.PLATE = (TYPEOF(le.PLATE))'' => 0,
          -1.000*le.PLATE_weight100))/100; 
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
    SELF.Weight := IF(le.EID_HASH = 0, 100, MAX(0,SELF.PLATEWeight) + MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.LNAMEWeight) + MAX(0,SELF.P_CITY_NAMEWeight) + MAX(0,SELF.STWeight));
    SELF := le;
  END;
  Recs0 := Recs(PLATE <> (TYPEOF(PLATE))'');
  SALT37.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference,Config.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,LEFT.PLATE = RIGHT.PLATE
     AND (( ((LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME OR RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME ) OR metaphonelib.DMetaPhone1(LEFT.FNAME)=metaphonelib.DMetaPhone1(RIGHT.FNAME) OR Bair_ExternalLinkKeys_V2.Config.WithinEditN(LEFT.FNAME,LEFT.FNAME_len,RIGHT.FNAME,RIGHT.FNAME_len,1, 0)  OR RIGHT.FNAME_PreferredName = fn_PreferredName(LEFT.FNAME) ) AND ((LEFT.MNAME[1..LENGTH(TRIM(RIGHT.MNAME))] = RIGHT.MNAME OR RIGHT.MNAME[1..LENGTH(TRIM(LEFT.MNAME))] = LEFT.MNAME )OR Bair_ExternalLinkKeys_V2.Config.WithinEditN(LEFT.MNAME,LEFT.MNAME_len,RIGHT.MNAME,RIGHT.MNAME_len,2, 0) ) AND (LEFT.LNAME = (TYPEOF(LEFT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR SALT37.MatchBagOfWords(LEFT.LNAME,RIGHT.LNAME,31744,3) > Bair_ExternalLinkKeys_V2.Config.LNAME_Force * 100) )),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.PLATE = RIGHT.PLATE,Config.PLATE_MAXBLOCKSIZE)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),LEFT.PLATE = RIGHT.PLATE
     AND (( ((LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME OR RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME ) OR metaphonelib.DMetaPhone1(LEFT.FNAME)=metaphonelib.DMetaPhone1(RIGHT.FNAME) OR Bair_ExternalLinkKeys_V2.Config.WithinEditN(LEFT.FNAME,LEFT.FNAME_len,RIGHT.FNAME,RIGHT.FNAME_len,1, 0)  OR RIGHT.FNAME_PreferredName = fn_PreferredName(LEFT.FNAME) ) AND ((LEFT.MNAME[1..LENGTH(TRIM(RIGHT.MNAME))] = RIGHT.MNAME OR RIGHT.MNAME[1..LENGTH(TRIM(LEFT.MNAME))] = LEFT.MNAME )OR Bair_ExternalLinkKeys_V2.Config.WithinEditN(LEFT.MNAME,LEFT.MNAME_len,RIGHT.MNAME,RIGHT.MNAME_len,2, 0) ) AND (LEFT.LNAME = (TYPEOF(LEFT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR SALT37.MatchBagOfWords(LEFT.LNAME,RIGHT.LNAME,31744,3) > Bair_ExternalLinkKeys_V2.Config.LNAME_Force * 100) )),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.PLATE = RIGHT.PLATE,Config.PLATE_MAXBLOCKSIZE),HASH,UNORDERED); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := PROJECT(J2, Process_PS_Layouts.update_forcefailed(LEFT,In_disableForce));
  J4 := Process_PS_Layouts.CombineLinkpathScores(J3,In_disableForce); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT37.MAC_Dups_Restore(J4,DD,J5,Reference,TRUE)
  RETURN J5;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_PLATE='',Input_FNAME='',Input_MNAME='',Input_LNAME='',Input_P_CITY_NAME='',Input_ST='',output_file,AsIndex='true', In_disableForce = 'false') := MACRO
IMPORT SALT37,Bair_ExternalLinkKeys_V2;
#IF(#TEXT(Input_PLATE)<>'')
  #uniquename(trans)
  Bair_ExternalLinkKeys_V2.Key_Classify_PS_PLATE.InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    SELF.PLATE := (TYPEOF(SELF.PLATE))le.Input_PLATE;
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
    #IF ( #TEXT(Input_P_CITY_NAME) <> '' )
      SELF.P_CITY_NAME := (TYPEOF(SELF.P_CITY_NAME))le.Input_P_CITY_NAME;
    #END
    #IF ( #TEXT(Input_ST) <> '' )
      SELF.ST := (TYPEOF(SELF.ST))le.Input_ST;
    #END
  END;
  #uniquename(p)
  %p% := PROJECT(Infile,%trans%(left));
  output_file := Bair_ExternalLinkKeys_V2.Key_Classify_PS_PLATE.ScoredFetch_Batch(%p%,AsIndex, In_disableForce);
#ELSE
  output_file := DATASET([],Bair_ExternalLinkKeys_V2.Process_PS_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
END;
