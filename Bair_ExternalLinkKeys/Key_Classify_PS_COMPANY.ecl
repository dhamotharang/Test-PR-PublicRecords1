IMPORT SALT33,ut,std;
EXPORT Key_Classify_PS_COMPANY := MODULE
 
//CLEAN_COMPANY_NAME:?:SEARCH_ADDR1:+:P_CITY_NAME:ST:SEARCH_ADDR2:LEXID
 
EXPORT KeyName := KeyPrefix+'::'+'key::Bair_ExternalLinkKeys'+'::'+Config.KeyInfix+'::EID_HASH::Refs::COMPANY';
 
EXPORT KeyName_sf := KeyPrefix+'::'+'key::Bair_ExternalLinkKeys'+'::'+KeySuperfile+'::EID_HASH::Refs::COMPANY';
 
EXPORT AssignCurrentKeyToSuperFile := FileServices.AddSuperFile(KeyName_sf,KeyName);
 
EXPORT ClearKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(KeyName_sf,,TRUE),FileServices.ClearSuperFile(KeyName_sf));
SHARED h := CandidatesForKey;//The input file - distributed by EID_HASH
layout := RECORD // project out required fields
// Compulsory fields
  h.CLEAN_COMPANY_NAME;
// Optional fields
  h.SEARCH_ADDR1;
  h.EID_HASH; // The ID field
// Extra credit fields
  h.P_CITY_NAME;
  h.ST;
  h.SEARCH_ADDR2;
  h.LEXID;
//Scores for various field components
  h.CLEAN_COMPANY_NAME_weight100 ; // Contains 100x the specificity
  h.SEARCH_ADDR1_weight100 ; // Contains 100x the specificity
  h.P_CITY_NAME_weight100 ; // Contains 100x the specificity
  h.ST_weight100 ; // Contains 100x the specificity
  h.SEARCH_ADDR2_weight100 ; // Contains 100x the specificity
  h.LEXID_weight100 ; // Contains 100x the specificity
END;
 
s := Specificities(File_Classify_PS).Specificities[1];
 
DataForKey0 := DEDUP(SORT(TABLE(h((CLEAN_COMPANY_NAME NOT IN SET(s.nulls_CLEAN_COMPANY_NAME,CLEAN_COMPANY_NAME) AND CLEAN_COMPANY_NAME <> (TYPEOF(CLEAN_COMPANY_NAME))''),(SEARCH_ADDR1 NOT IN SET(s.nulls_SEARCH_ADDR1,SEARCH_ADDR1) AND SEARCH_ADDR1 <> (TYPEOF(SEARCH_ADDR1))'')),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
 
EXPORT Key := INDEX(DataForKey0,,KeyName_sf);
 
EXPORT BuildAll := BUILDINDEX(Key, OVERWRITE);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,EID_HASH,CLEAN_COMPANY_NAME,SEARCH_ADDR1,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_P_CITY_NAME := GROUP( DEDUP( SORT( Grpd, EXCEPT P_CITY_NAME), EXCEPT P_CITY_NAME));
  CntRed_P_CITY_NAME := (KeyCnt-COUNT(Rem_P_CITY_NAME))/KeyCnt;
  Rem_ST := GROUP( DEDUP( SORT( Grpd, EXCEPT ST), EXCEPT ST));
  CntRed_ST := (KeyCnt-COUNT(Rem_ST))/KeyCnt;
  Rem_SEARCH_ADDR2 := GROUP( DEDUP( SORT( Grpd, EXCEPT SEARCH_ADDR2), EXCEPT SEARCH_ADDR2));
  CntRed_SEARCH_ADDR2 := (KeyCnt-COUNT(Rem_SEARCH_ADDR2))/KeyCnt;
  Rem_LEXID := GROUP( DEDUP( SORT( Grpd, EXCEPT LEXID), EXCEPT LEXID));
  CntRed_LEXID := (KeyCnt-COUNT(Rem_LEXID))/KeyCnt;
EXPORT Shrinkage := DATASET([{'COMPANY','P_CITY_NAME',CntRed_P_CITY_NAME*100,CntRed_P_CITY_NAME*TSize},{'COMPANY','ST',CntRed_ST*100,CntRed_ST*TSize},{'COMPANY','SEARCH_ADDR2',CntRed_SEARCH_ADDR2*100,CntRed_SEARCH_ADDR2*TSize},{'COMPANY','LEXID',CntRed_LEXID*100,CntRed_LEXID*TSize}],SALT33.ShrinkLayout);
EXPORT CanSearch(Process_PS_Layouts.InputLayout le) := le.CLEAN_COMPANY_NAME <> (typeof(le.CLEAN_COMPANY_NAME))'';
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(TYPEOF(h.CLEAN_COMPANY_NAME) param_CLEAN_COMPANY_NAME = (TYPEOF(h.CLEAN_COMPANY_NAME))'',TYPEOF(h.SEARCH_ADDR1) param_SEARCH_ADDR1 = (TYPEOF(h.SEARCH_ADDR1))'') := 
    STEPPED( LIMIT( Key(
          KEYED(( CLEAN_COMPANY_NAME = param_CLEAN_COMPANY_NAME AND param_CLEAN_COMPANY_NAME <> (TYPEOF(CLEAN_COMPANY_NAME))''))
      AND KEYED(( SEARCH_ADDR1 = (TYPEOF(SEARCH_ADDR1))'' OR param_SEARCH_ADDR1 = (TYPEOF(SEARCH_ADDR1))'' OR SEARCH_ADDR1 = param_SEARCH_ADDR1 ))),5000,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),EID_HASH);
 
 
EXPORT ScoredEID_HASHFetch(TYPEOF(h.CLEAN_COMPANY_NAME) param_CLEAN_COMPANY_NAME = (TYPEOF(h.CLEAN_COMPANY_NAME))'',TYPEOF(h.SEARCH_ADDR1) param_SEARCH_ADDR1 = (TYPEOF(h.SEARCH_ADDR1))'',TYPEOF(h.P_CITY_NAME) param_P_CITY_NAME = (TYPEOF(h.P_CITY_NAME))'',TYPEOF(h.ST) param_ST = (TYPEOF(h.ST))'',TYPEOF(h.SEARCH_ADDR2) param_SEARCH_ADDR2 = (TYPEOF(h.SEARCH_ADDR2))'',TYPEOF(h.LEXID) param_LEXID = (TYPEOF(h.LEXID))'') := FUNCTION
  RawData := RawFetch(param_CLEAN_COMPANY_NAME,param_SEARCH_ADDR1);
 
  Process_PS_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 14; // Set bitmap for key used
    SELF.keys_failed := IF(le.EID_HASH = 0, 1 << 14, 0); // Set bitmap for key failed
    SELF.CLEAN_COMPANY_NAME_match_code := MAP(le.CLEAN_COMPANY_NAME = (TYPEOF(le.CLEAN_COMPANY_NAME))'' OR le.CLEAN_COMPANY_NAME = (TYPEOF(le.CLEAN_COMPANY_NAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_CLEAN_COMPANY_NAME(le.CLEAN_COMPANY_NAME,param_CLEAN_COMPANY_NAME,TRUE));
    SELF.CLEAN_COMPANY_NAMEWeight := (50+MAP ( le.CLEAN_COMPANY_NAME = param_CLEAN_COMPANY_NAME  => le.CLEAN_COMPANY_NAME_weight100,
          le.CLEAN_COMPANY_NAME = (TYPEOF(le.CLEAN_COMPANY_NAME))'' OR param_CLEAN_COMPANY_NAME = (TYPEOF(le.CLEAN_COMPANY_NAME))'' => 0,
          -0.450*le.CLEAN_COMPANY_NAME_weight100))/100; 
    SELF.SEARCH_ADDR1_match_code := MAP(le.SEARCH_ADDR1 = (TYPEOF(le.SEARCH_ADDR1))'' OR param_SEARCH_ADDR1 = (TYPEOF(param_SEARCH_ADDR1))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_SEARCH_ADDR1(le.SEARCH_ADDR1,param_SEARCH_ADDR1,FALSE));
    SELF.SEARCH_ADDR1Weight := (50+MAP ( le.SEARCH_ADDR1 = (TYPEOF(le.SEARCH_ADDR1))'' OR param_SEARCH_ADDR1 = (TYPEOF(param_SEARCH_ADDR1))'' => 0,
           le.SEARCH_ADDR1 = param_SEARCH_ADDR1  => le.SEARCH_ADDR1_weight100,
           -0.424*le.SEARCH_ADDR1_weight100))/100; 
    SELF.P_CITY_NAME_match_code := MAP(le.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' OR param_P_CITY_NAME = (TYPEOF(param_P_CITY_NAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_P_CITY_NAME(le.P_CITY_NAME,param_P_CITY_NAME,FALSE));
    SELF.P_CITY_NAMEWeight := (50+MAP ( le.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' OR param_P_CITY_NAME = (TYPEOF(param_P_CITY_NAME))'' => 0,
           le.P_CITY_NAME = param_P_CITY_NAME  => le.P_CITY_NAME_weight100,
           -0.580*le.P_CITY_NAME_weight100))/100; 
    SELF.ST_match_code := MAP(le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_ST(le.ST,param_ST,FALSE));
    SELF.STWeight := (50+MAP ( le.ST = (TYPEOF(le.ST))'' OR param_ST = (TYPEOF(param_ST))'' => 0,
           le.ST = param_ST  => le.ST_weight100,
           -0.690*le.ST_weight100))/100; 
    SELF.SEARCH_ADDR2_match_code := MAP(le.SEARCH_ADDR2 = (TYPEOF(le.SEARCH_ADDR2))'' OR param_SEARCH_ADDR2 = (TYPEOF(param_SEARCH_ADDR2))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_SEARCH_ADDR2(le.SEARCH_ADDR2,param_SEARCH_ADDR2,FALSE));
    SELF.SEARCH_ADDR2Weight := (50+MAP ( le.SEARCH_ADDR2 = (TYPEOF(le.SEARCH_ADDR2))'' OR param_SEARCH_ADDR2 = (TYPEOF(param_SEARCH_ADDR2))'' => 0,
           le.SEARCH_ADDR2 = param_SEARCH_ADDR2  => le.SEARCH_ADDR2_weight100,
           -0.480*le.SEARCH_ADDR2_weight100))/100; 
    SELF.LEXID_match_code := MAP(le.LEXID = (TYPEOF(le.LEXID))'' OR param_LEXID = (TYPEOF(param_LEXID))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_LEXID(le.LEXID,param_LEXID,FALSE));
    SELF.LEXIDWeight := (50+MAP ( le.LEXID = (TYPEOF(le.LEXID))'' OR param_LEXID = (TYPEOF(param_LEXID))'' => 0,
           le.LEXID = param_LEXID  => le.LEXID_weight100,
           -0.650*le.LEXID_weight100))/100; 
    SELF.Weight := IF(le.EID_HASH = 0, 100, MAX(0,SELF.CLEAN_COMPANY_NAMEWeight) + MAX(0,SELF.SEARCH_ADDR1Weight) + MAX(0,SELF.P_CITY_NAMEWeight) + MAX(0,SELF.STWeight) + MAX(0,SELF.SEARCH_ADDR2Weight) + MAX(0,SELF.LEXIDWeight));
    SELF := le;
  END;
  RETURN ROLLUP(PROJECT(NOFOLD(RawData),Score(LEFT)),LEFT.EID_HASH = RIGHT.EID_HASH,Process_PS_Layouts.combine_scores(LEFT,RIGHT));
END;
 
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT33.UIDType Reference;//How to recognize this record in the subsequent
  TYPEOF(h.CLEAN_COMPANY_NAME) CLEAN_COMPANY_NAME := (TYPEOF(h.CLEAN_COMPANY_NAME))'';
  TYPEOF(h.SEARCH_ADDR1) SEARCH_ADDR1 := (TYPEOF(h.SEARCH_ADDR1))'';
  TYPEOF(h.P_CITY_NAME) P_CITY_NAME := (TYPEOF(h.P_CITY_NAME))'';
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))'';
  TYPEOF(h.SEARCH_ADDR2) SEARCH_ADDR2 := (TYPEOF(h.SEARCH_ADDR2))'';
  TYPEOF(h.LEXID) LEXID := (TYPEOF(h.LEXID))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex) := FUNCTION
 
  Process_PS_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 14; // Set bitmap for key used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.CLEAN_COMPANY_NAME_match_code := MAP(le.CLEAN_COMPANY_NAME = (TYPEOF(le.CLEAN_COMPANY_NAME))'' OR le.CLEAN_COMPANY_NAME = (TYPEOF(le.CLEAN_COMPANY_NAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_CLEAN_COMPANY_NAME(le.CLEAN_COMPANY_NAME,ri.CLEAN_COMPANY_NAME,TRUE));
    SELF.CLEAN_COMPANY_NAMEWeight := (50+MAP ( le.CLEAN_COMPANY_NAME = ri.CLEAN_COMPANY_NAME  => le.CLEAN_COMPANY_NAME_weight100,
          le.CLEAN_COMPANY_NAME = (TYPEOF(le.CLEAN_COMPANY_NAME))'' OR ri.CLEAN_COMPANY_NAME = (TYPEOF(le.CLEAN_COMPANY_NAME))'' => 0,
          -0.450*le.CLEAN_COMPANY_NAME_weight100))/100; 
    SELF.SEARCH_ADDR1_match_code := MAP(le.SEARCH_ADDR1 = (TYPEOF(le.SEARCH_ADDR1))'' OR ri.SEARCH_ADDR1 = (TYPEOF(ri.SEARCH_ADDR1))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_SEARCH_ADDR1(le.SEARCH_ADDR1,ri.SEARCH_ADDR1,FALSE));
    SELF.SEARCH_ADDR1Weight := (50+MAP ( le.SEARCH_ADDR1 = (TYPEOF(le.SEARCH_ADDR1))'' OR ri.SEARCH_ADDR1 = (TYPEOF(ri.SEARCH_ADDR1))'' => 0,
           le.SEARCH_ADDR1 = ri.SEARCH_ADDR1  => le.SEARCH_ADDR1_weight100,
           -0.424*le.SEARCH_ADDR1_weight100))/100; 
    SELF.P_CITY_NAME_match_code := MAP(le.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' OR ri.P_CITY_NAME = (TYPEOF(ri.P_CITY_NAME))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_P_CITY_NAME(le.P_CITY_NAME,ri.P_CITY_NAME,FALSE));
    SELF.P_CITY_NAMEWeight := (50+MAP ( le.P_CITY_NAME = (TYPEOF(le.P_CITY_NAME))'' OR ri.P_CITY_NAME = (TYPEOF(ri.P_CITY_NAME))'' => 0,
           le.P_CITY_NAME = ri.P_CITY_NAME  => le.P_CITY_NAME_weight100,
           -0.580*le.P_CITY_NAME_weight100))/100; 
    SELF.ST_match_code := MAP(le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_ST(le.ST,ri.ST,FALSE));
    SELF.STWeight := (50+MAP ( le.ST = (TYPEOF(le.ST))'' OR ri.ST = (TYPEOF(ri.ST))'' => 0,
           le.ST = ri.ST  => le.ST_weight100,
           -0.690*le.ST_weight100))/100; 
    SELF.SEARCH_ADDR2_match_code := MAP(le.SEARCH_ADDR2 = (TYPEOF(le.SEARCH_ADDR2))'' OR ri.SEARCH_ADDR2 = (TYPEOF(ri.SEARCH_ADDR2))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_SEARCH_ADDR2(le.SEARCH_ADDR2,ri.SEARCH_ADDR2,FALSE));
    SELF.SEARCH_ADDR2Weight := (50+MAP ( le.SEARCH_ADDR2 = (TYPEOF(le.SEARCH_ADDR2))'' OR ri.SEARCH_ADDR2 = (TYPEOF(ri.SEARCH_ADDR2))'' => 0,
           le.SEARCH_ADDR2 = ri.SEARCH_ADDR2  => le.SEARCH_ADDR2_weight100,
           -0.480*le.SEARCH_ADDR2_weight100))/100; 
    SELF.LEXID_match_code := MAP(le.LEXID = (TYPEOF(le.LEXID))'' OR ri.LEXID = (TYPEOF(ri.LEXID))'' => SALT33.MatchCode.OneSideNull,match_methods(File_Classify_PS).match_LEXID(le.LEXID,ri.LEXID,FALSE));
    SELF.LEXIDWeight := (50+MAP ( le.LEXID = (TYPEOF(le.LEXID))'' OR ri.LEXID = (TYPEOF(ri.LEXID))'' => 0,
           le.LEXID = ri.LEXID  => le.LEXID_weight100,
           -0.650*le.LEXID_weight100))/100; 
    SELF.Weight := IF(le.EID_HASH = 0, 100, MAX(0,SELF.CLEAN_COMPANY_NAMEWeight) + MAX(0,SELF.SEARCH_ADDR1Weight) + MAX(0,SELF.P_CITY_NAMEWeight) + MAX(0,SELF.STWeight) + MAX(0,SELF.SEARCH_ADDR2Weight) + MAX(0,SELF.LEXIDWeight));
    SELF := le;
  END;
  Recs0 := Recs(CLEAN_COMPANY_NAME <> (typeof(CLEAN_COMPANY_NAME))'');
  SALT33.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference,Bair_ExternalLinkKeys.Config.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,LEFT.CLEAN_COMPANY_NAME = RIGHT.CLEAN_COMPANY_NAME
     AND ( LEFT.SEARCH_ADDR1 = (TYPEOF(LEFT.SEARCH_ADDR1))'' OR RIGHT.SEARCH_ADDR1 = (TYPEOF(RIGHT.SEARCH_ADDR1))'' OR LEFT.SEARCH_ADDR1 = RIGHT.SEARCH_ADDR1  ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.CLEAN_COMPANY_NAME = RIGHT.CLEAN_COMPANY_NAME,5000)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),LEFT.CLEAN_COMPANY_NAME = RIGHT.CLEAN_COMPANY_NAME
     AND ( LEFT.SEARCH_ADDR1 = (TYPEOF(LEFT.SEARCH_ADDR1))'' OR RIGHT.SEARCH_ADDR1 = (TYPEOF(RIGHT.SEARCH_ADDR1))'' OR LEFT.SEARCH_ADDR1 = RIGHT.SEARCH_ADDR1  ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.CLEAN_COMPANY_NAME = RIGHT.CLEAN_COMPANY_NAME,5000),HASH,HINT(unsorted_output)); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := Process_PS_Layouts.CombineLinkpathScores(J2); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT33.MAC_Dups_Restore(J3,DD,J4,Reference,TRUE)
  RETURN J4;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_CLEAN_COMPANY_NAME='',Input_SEARCH_ADDR1='',Input_P_CITY_NAME='',Input_ST='',Input_SEARCH_ADDR2='',Input_LEXID='',output_file,AsIndex='true') := MACRO
IMPORT SALT33,Bair_ExternalLinkKeys;
#IF(#TEXT(Input_CLEAN_COMPANY_NAME)<>'')
  #uniquename(trans)
  Bair_ExternalLinkKeys.Key_Classify_PS_COMPANY.InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    SELF.CLEAN_COMPANY_NAME := (TYPEOF(SELF.CLEAN_COMPANY_NAME))le.Input_CLEAN_COMPANY_NAME;
    #IF ( #TEXT(Input_SEARCH_ADDR1) <> '' )
      SELF.SEARCH_ADDR1 := (TYPEOF(SELF.SEARCH_ADDR1))le.Input_SEARCH_ADDR1;
    #END
    #IF ( #TEXT(Input_P_CITY_NAME) <> '' )
      SELF.P_CITY_NAME := (TYPEOF(SELF.P_CITY_NAME))le.Input_P_CITY_NAME;
    #END
    #IF ( #TEXT(Input_ST) <> '' )
      SELF.ST := (TYPEOF(SELF.ST))le.Input_ST;
    #END
    #IF ( #TEXT(Input_SEARCH_ADDR2) <> '' )
      SELF.SEARCH_ADDR2 := (TYPEOF(SELF.SEARCH_ADDR2))le.Input_SEARCH_ADDR2;
    #END
    #IF ( #TEXT(Input_LEXID) <> '' )
      SELF.LEXID := (TYPEOF(SELF.LEXID))le.Input_LEXID;
    #END
  END;
  #uniquename(p)
  %p% := PROJECT(Infile,%trans%(left));
  output_file := Bair_ExternalLinkKeys.Key_Classify_PS_COMPANY.ScoredFetch_Batch(%p%,AsIndex);
#ELSE
  output_file := DATASET([],Bair_ExternalLinkKeys.Process_PS_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
END;
