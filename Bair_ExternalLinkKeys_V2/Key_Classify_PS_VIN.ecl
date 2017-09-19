IMPORT SALT37,std;
EXPORT Key_Classify_PS_VIN := MODULE
 
//VIN:?:LNAME:+:P_CITY_NAME:ST
EXPORT KeyName := KeyPrefix+'::'+'key::Bair_ExternalLinkKeys_V2'+'::'+Config.KeyInfix+'::EID_HASH::Refs::VIN';
 
EXPORT KeyName_sf := KeyPrefix+'::'+'key::Bair_ExternalLinkKeys_V2'+'::'+KeySuperfile+'::EID_HASH::Refs::VIN';
 
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
  h.ST;
//Scores for various field components
  h.VIN_weight100 ; // Contains 100x the specificity
  h.LNAME_weight100 ; // Contains 100x the specificity
  h.P_CITY_NAME_weight100 ; // Contains 100x the specificity
  h.ST_weight100 ; // Contains 100x the specificity
END;
 
s := Specificities(File_Classify_PS).Specificities[1];
 
DataForKey0 := DEDUP(SORT(TABLE(h((VIN NOT IN SET(s.nulls_VIN,VIN) AND VIN <> (TYPEOF(VIN))'')),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
SHARED DataForKey := DataForKey0;
 
EXPORT Key := INDEX(DataForKey,{DataForKey},{},KeyName_sf);
 
EXPORT BuildAll := BUILDINDEX(Key, OVERWRITE);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,EID_HASH,VIN,LNAME,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_P_CITY_NAME := GROUP( DEDUP( SORT( Grpd, EXCEPT P_CITY_NAME), EXCEPT P_CITY_NAME));
  CntRed_P_CITY_NAME := (KeyCnt-COUNT(Rem_P_CITY_NAME))/KeyCnt;
  Rem_ST := GROUP( DEDUP( SORT( Grpd, EXCEPT ST), EXCEPT ST));
  CntRed_ST := (KeyCnt-COUNT(Rem_ST))/KeyCnt;
EXPORT Shrinkage := DATASET([{'VIN','P_CITY_NAME',CntRed_P_CITY_NAME*100,CntRed_P_CITY_NAME*TSize},{'VIN','ST',CntRed_ST*100,CntRed_ST*TSize}],SALT37.ShrinkLayout);
EXPORT CanSearch(Process_PS_Layouts.InputLayout le) := le.VIN <> (TYPEOF(le.VIN))'' AND Fields.InValid_VIN((SALT37.StrType)le.VIN)=0;
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(TYPEOF(h.VIN) param_VIN = (TYPEOF(h.VIN))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'') := 
    STEPPED( LIMIT( Key(
          KEYED(( VIN = param_VIN AND param_VIN <> (TYPEOF(VIN))''))
      AND ( LNAME = (TYPEOF(LNAME))'' OR param_LNAME = (TYPEOF(LNAME))'' OR SALT37.MatchBagOfWords(LNAME,param_LNAME,31744,3) > Config.LNAME_Force * 100)),Config.VIN_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),EID_HASH);
 
 
EXPORT ScoredEID_HASHFetch(TYPEOF(h.VIN) param_VIN = (TYPEOF(h.VIN))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.P_CITY_NAME) param_P_CITY_NAME = (TYPEOF(h.P_CITY_NAME))'',TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetch(param_VIN,param_LNAME);
 
  Process_PS_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 8; // Set bitmap for keys used
    SELF.keys_failed := IF(le.EID_HASH = 0, 1 << 8, 0); // Set bitmap for key failed
    SELF.VIN_match_code := match_methods(File_Classify_PS).match_VIN(le.VIN,param_VIN,TRUE);
    SELF.VINWeight := (50+MAP (
           le.VIN = param_VIN  => le.VIN_weight100,
          le.VIN = (TYPEOF(le.VIN))'' OR param_VIN = (TYPEOF(le.VIN))'' => 0,
          -0.550*le.VIN_weight100))/100; 
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
    SELF.Weight := IF(le.EID_HASH = 0, 100, MAX(0,SELF.VINWeight) + MAX(0,SELF.LNAMEWeight) + MAX(0,SELF.P_CITY_NAMEWeight));
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
  TYPEOF(h.VIN) VIN := (TYPEOF(h.VIN))'';
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))'';
  TYPEOF(h.P_CITY_NAME) P_CITY_NAME := (TYPEOF(h.P_CITY_NAME))'';
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex, BOOLEAN In_disableForce = FALSE) := FUNCTION
 
  Process_PS_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 8; // Set bitmap for keys used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.VIN_match_code := match_methods(File_Classify_PS).match_VIN(le.VIN,ri.VIN,TRUE);
    SELF.VINWeight := (50+MAP (
           le.VIN = ri.VIN  => le.VIN_weight100,
          le.VIN = (TYPEOF(le.VIN))'' OR ri.VIN = (TYPEOF(le.VIN))'' => 0,
          -0.550*le.VIN_weight100))/100; 
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
    SELF.Weight := IF(le.EID_HASH = 0, 100, MAX(0,SELF.VINWeight) + MAX(0,SELF.LNAMEWeight) + MAX(0,SELF.P_CITY_NAMEWeight));
    SELF := le;
  END;
  Recs0 := Recs(VIN <> (TYPEOF(VIN))'');
  SALT37.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference,Config.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,LEFT.VIN = RIGHT.VIN
     AND ( LEFT.LNAME = (TYPEOF(LEFT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR SALT37.MatchBagOfWords(LEFT.LNAME,RIGHT.LNAME,31744,3) > Bair_ExternalLinkKeys_V2.Config.LNAME_Force * 100 ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.VIN = RIGHT.VIN,Config.VIN_MAXBLOCKSIZE)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),LEFT.VIN = RIGHT.VIN
     AND ( LEFT.LNAME = (TYPEOF(LEFT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR SALT37.MatchBagOfWords(LEFT.LNAME,RIGHT.LNAME,31744,3) > Bair_ExternalLinkKeys_V2.Config.LNAME_Force * 100 ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.VIN = RIGHT.VIN,Config.VIN_MAXBLOCKSIZE),HASH,UNORDERED); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := PROJECT(J2, Process_PS_Layouts.update_forcefailed(LEFT,In_disableForce));
  J4 := Process_PS_Layouts.CombineLinkpathScores(J3,In_disableForce); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT37.MAC_Dups_Restore(J4,DD,J5,Reference,TRUE)
  RETURN J5;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_VIN='',Input_LNAME='',Input_P_CITY_NAME='',Input_ST='',output_file,AsIndex='true', In_disableForce = 'false') := MACRO
IMPORT SALT37,Bair_ExternalLinkKeys_V2;
#IF(#TEXT(Input_VIN)<>'')
  #uniquename(trans)
  Bair_ExternalLinkKeys_V2.Key_Classify_PS_VIN.InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    SELF.VIN := (TYPEOF(SELF.VIN))le.Input_VIN;
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
  output_file := Bair_ExternalLinkKeys_V2.Key_Classify_PS_VIN.ScoredFetch_Batch(%p%,AsIndex, In_disableForce);
#ELSE
  output_file := DATASET([],Bair_ExternalLinkKeys_V2.Process_PS_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
END;
