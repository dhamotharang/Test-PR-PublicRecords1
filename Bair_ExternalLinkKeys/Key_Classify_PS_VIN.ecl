IMPORT SALT33,ut,std;
EXPORT Key_Classify_PS_VIN := MODULE
 
//VIN:?:LNAME:+:P_CITY_NAME
 
EXPORT KeyName := KeyPrefix+'::'+'key::Bair_ExternalLinkKeys'+'::'+Config.KeyInfix+'::EID_HASH::Refs::VIN';
 
EXPORT KeyName_sf := KeyPrefix+'::'+'key::Bair_ExternalLinkKeys'+'::'+KeySuperfile+'::EID_HASH::Refs::VIN';
 
EXPORT AssignCurrentKeyToSuperFile := FileServices.AddSuperFile(KeyName_sf,KeyName);
 
EXPORT ClearKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(KeyName_sf,,TRUE),FileServices.ClearSuperFile(KeyName_sf));
SHARED h := CandidatesForKey;//The input file - distributed by EID_HASH
layout := RECORD // project out required fields
// Compulsory fields
  h.VIN;
// Optional fields
  h.EID_HASH; // The ID field
  h.LNAME;
// Extra credit fields
  h.P_CITY_NAME;
//Scores for various field components
  h.VIN_weight100 ; // Contains 100x the specificity
  h.LNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_p_Weight100;
  h.LNAME_e1_Weight100;
  h.LNAME_e1p_Weight100;
  h.LNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.P_CITY_NAME_weight100 ; // Contains 100x the specificity
END;
 
s := Specificities(File_Classify_PS).Specificities[1];
 
DataForKey0 := DEDUP(SORT(TABLE(h((VIN NOT IN SET(s.nulls_VIN,VIN) AND VIN <> (TYPEOF(VIN))'')),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
 
EXPORT Key := INDEX(DataForKey0,,KeyName_sf);
 
EXPORT BuildAll := BUILDINDEX(Key, OVERWRITE);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,EID_HASH,VIN,LNAME,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_P_CITY_NAME := GROUP( DEDUP( SORT( Grpd, EXCEPT P_CITY_NAME), EXCEPT P_CITY_NAME));
  CntRed_P_CITY_NAME := (KeyCnt-COUNT(Rem_P_CITY_NAME))/KeyCnt;
EXPORT Shrinkage := DATASET([{'VIN','P_CITY_NAME',CntRed_P_CITY_NAME*100,CntRed_P_CITY_NAME*TSize}],SALT33.ShrinkLayout);
EXPORT CanSearch(Process_PS_Layouts.InputLayout le) := le.VIN <> (typeof(le.VIN))'';
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(TYPEOF(h.VIN) param_VIN = (TYPEOF(h.VIN))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'') := 
    STEPPED( LIMIT( Key(
          KEYED(( VIN = param_VIN AND param_VIN <> (TYPEOF(VIN))''))
      AND ( LNAME = (TYPEOF(LNAME))'' OR param_LNAME = (TYPEOF(LNAME))'' OR metaphonelib.DMetaPhone1(LNAME)=metaphonelib.DMetaPhone1(param_LNAME) OR SALT33.WithinEditN(LNAME,param_LNAME,1, 0) OR SALT33.HyphenMatch(LNAME,param_LNAME,1)<=2 )),5000,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),EID_HASH);
 
 
EXPORT ScoredEID_HASHFetch(TYPEOF(h.VIN) param_VIN = (TYPEOF(h.VIN))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.P_CITY_NAME) param_P_CITY_NAME = (TYPEOF(h.P_CITY_NAME))'') := FUNCTION
  RawData := RawFetch(param_VIN,param_LNAME);
 
  Process_PS_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 9; // Set bitmap for key used
    SELF.keys_failed := IF(le.EID_HASH = 0, 1 << 9, 0); // Set bitmap for key failed
    SELF.VIN_match_code := MAP(le.VIN = (TYPEOF(le.VIN))'' OR le.VIN = (TYPEOF(le.VIN))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_VIN(le.VIN,param_VIN,TRUE));
    SELF.VINWeight := (50+MAP ( le.VIN = param_VIN  => le.VIN_weight100,
          le.VIN = (TYPEOF(le.VIN))'' OR param_VIN = (TYPEOF(le.VIN))'' => 0,
          -0.550*le.VIN_weight100))/100; 
    SELF.LNAME_match_code := MAP(le.LNAME = (TYPEOF(le.LNAME))'' OR param_LNAME = (TYPEOF(param_LNAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_LNAME(le.LNAME,param_LNAME,0,0,FALSE));
    SELF.LNAMEWeight := (50+MAP ( le.LNAME = (TYPEOF(le.LNAME))'' OR param_LNAME = (TYPEOF(param_LNAME))'' => 0,
           le.LNAME = param_LNAME  => le.LNAME_weight100,
           SALT33.WithinEditN(le.LNAME,param_LNAME,1, 0) => IF( metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(param_LNAME),le.LNAME_e1p_weight100,le.LNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(param_LNAME)=>le.LNAME_p_weight100,
           SALT33.HyphenMatch(le.LNAME,param_LNAME,1)<=2 => le.LNAME_weight100*MIN(1,LENGTH(TRIM(param_LNAME))/LENGTH(TRIM(le.LNAME))),
           -0.617*le.LNAME_weight100))/100*0.80; 
    SELF.P_CITY_NAME_match_code := MAP(le.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' OR param_P_CITY_NAME = (TYPEOF(param_P_CITY_NAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_P_CITY_NAME(le.P_CITY_NAME,param_P_CITY_NAME,FALSE));
    SELF.P_CITY_NAMEWeight := (50+MAP ( le.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' OR param_P_CITY_NAME = (TYPEOF(param_P_CITY_NAME))'' => 0,
           le.P_CITY_NAME = param_P_CITY_NAME  => le.P_CITY_NAME_weight100,
           -0.580*le.P_CITY_NAME_weight100))/100; 
    SELF.Weight := IF(le.EID_HASH = 0, 100, MAX(0,SELF.VINWeight) + MAX(0,SELF.LNAMEWeight) + MAX(0,SELF.P_CITY_NAMEWeight));
    SELF := le;
  END;
  RETURN ROLLUP(PROJECT(NOFOLD(RawData),Score(LEFT)),LEFT.EID_HASH = RIGHT.EID_HASH,Process_PS_Layouts.combine_scores(LEFT,RIGHT));
END;
 
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT33.UIDType Reference;//How to recognize this record in the subsequent
  TYPEOF(h.VIN) VIN := (TYPEOF(h.VIN))'';
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))'';
  TYPEOF(h.P_CITY_NAME) P_CITY_NAME := (TYPEOF(h.P_CITY_NAME))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex) := FUNCTION
 
  Process_PS_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 9; // Set bitmap for key used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.VIN_match_code := MAP(le.VIN = (TYPEOF(le.VIN))'' OR le.VIN = (TYPEOF(le.VIN))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_VIN(le.VIN,ri.VIN,TRUE));
    SELF.VINWeight := (50+MAP ( le.VIN = ri.VIN  => le.VIN_weight100,
          le.VIN = (TYPEOF(le.VIN))'' OR ri.VIN = (TYPEOF(le.VIN))'' => 0,
          -0.550*le.VIN_weight100))/100; 
    SELF.LNAME_match_code := MAP(le.LNAME = (TYPEOF(le.LNAME))'' OR ri.LNAME = (TYPEOF(ri.LNAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_LNAME(le.LNAME,ri.LNAME,0,0,FALSE));
    SELF.LNAMEWeight := (50+MAP ( le.LNAME = (TYPEOF(le.LNAME))'' OR ri.LNAME = (TYPEOF(ri.LNAME))'' => 0,
           le.LNAME = ri.LNAME  => le.LNAME_weight100,
           SALT33.WithinEditN(le.LNAME,ri.LNAME,1, 0) => IF( metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(ri.LNAME),le.LNAME_e1p_weight100,le.LNAME_e1_weight100),
           metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(ri.LNAME)=>le.LNAME_p_weight100,
           SALT33.HyphenMatch(le.LNAME,ri.LNAME,1)<=2 => le.LNAME_weight100*MIN(1,LENGTH(TRIM(ri.LNAME))/LENGTH(TRIM(le.LNAME))),
           -0.617*le.LNAME_weight100))/100*0.80; 
    SELF.P_CITY_NAME_match_code := MAP(le.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' OR ri.P_CITY_NAME = (TYPEOF(ri.P_CITY_NAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_P_CITY_NAME(le.P_CITY_NAME,ri.P_CITY_NAME,FALSE));
    SELF.P_CITY_NAMEWeight := (50+MAP ( le.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' OR ri.P_CITY_NAME = (TYPEOF(ri.P_CITY_NAME))'' => 0,
           le.P_CITY_NAME = ri.P_CITY_NAME  => le.P_CITY_NAME_weight100,
           -0.580*le.P_CITY_NAME_weight100))/100; 
    SELF.Weight := IF(le.EID_HASH = 0, 100, MAX(0,SELF.VINWeight) + MAX(0,SELF.LNAMEWeight) + MAX(0,SELF.P_CITY_NAMEWeight));
    SELF := le;
  END;
  Recs0 := Recs(VIN <> (typeof(VIN))'');
  SALT33.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference,Bair_ExternalLinkKeys.Config.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,LEFT.VIN = RIGHT.VIN
     AND ( LEFT.LNAME = (TYPEOF(LEFT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR metaphonelib.DMetaPhone1(LEFT.LNAME)=metaphonelib.DMetaPhone1(RIGHT.LNAME) OR SALT33.WithinEditN(LEFT.LNAME,RIGHT.LNAME,1, 0) OR SALT33.HyphenMatch(LEFT.LNAME,RIGHT.LNAME,1)<=2  ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.VIN = RIGHT.VIN,5000)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),LEFT.VIN = RIGHT.VIN
     AND ( LEFT.LNAME = (TYPEOF(LEFT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR metaphonelib.DMetaPhone1(LEFT.LNAME)=metaphonelib.DMetaPhone1(RIGHT.LNAME) OR SALT33.WithinEditN(LEFT.LNAME,RIGHT.LNAME,1, 0) OR SALT33.HyphenMatch(LEFT.LNAME,RIGHT.LNAME,1)<=2  ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.VIN = RIGHT.VIN,5000),HASH,HINT(unsorted_output)); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := Process_PS_Layouts.CombineLinkpathScores(J2); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT33.MAC_Dups_Restore(J3,DD,J4,Reference,TRUE)
  RETURN J4;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_VIN='',Input_LNAME='',Input_P_CITY_NAME='',output_file,AsIndex='true') := MACRO
IMPORT SALT33,Bair_ExternalLinkKeys;
#IF(#TEXT(Input_VIN)<>'')
  #uniquename(trans)
  Bair_ExternalLinkKeys.Key_Classify_PS_VIN.InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    SELF.VIN := (TYPEOF(SELF.VIN))le.Input_VIN;
    #IF ( #TEXT(Input_LNAME) <> '' )
      SELF.LNAME := (TYPEOF(SELF.LNAME))le.Input_LNAME;
    #END
    #IF ( #TEXT(Input_P_CITY_NAME) <> '' )
      SELF.P_CITY_NAME := (TYPEOF(SELF.P_CITY_NAME))le.Input_P_CITY_NAME;
    #END
  END;
  #uniquename(p)
  %p% := PROJECT(Infile,%trans%(left));
  output_file := Bair_ExternalLinkKeys.Key_Classify_PS_VIN.ScoredFetch_Batch(%p%,AsIndex);
#ELSE
  output_file := DATASET([],Bair_ExternalLinkKeys.Process_PS_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
END;
