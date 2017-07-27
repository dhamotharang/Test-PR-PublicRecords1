IMPORT SALT33,ut,std;
EXPORT Key_BizHead_L_CONTACT_DID := MODULE
 
//contact_did
 
EXPORT KeyName := BizLinkFull.Filename_keys.L_CONTACT_DID; /*HACK07*/
SHARED h := CandidatesForKey;//The input file - distributed by proxid
layout := RECORD // project out required fields
// Compulsory fields
  h.contact_did;
  h.fallback_value; // Populate the fallback field
  h.ultid; // Parent #3
  h.orgid; // Parent #2
  h.seleid; // Parent #1
  h.proxid; // The ID field
  h.powid; // Uncle #1
//Scores for various field components
  h.contact_did_weight100 ; // Contains 100x the specificity
END;
 
s := Specificities(File_BizHead).Specificities[1];
 
DataForKey0 := DEDUP(SORT(TABLE(h((contact_did NOT IN SET(s.nulls_contact_did,contact_did) AND contact_did <> (TYPEOF(contact_did))'')),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
 
EXPORT Key := INDEX(DataForKey0,,KeyName);
 
EXPORT BuildAll := BUILDINDEX(Key, OVERWRITE);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,proxid,contact_did,LOCAL); // Not perfect, does not need to be - for statistics
EXPORT Shrinkage := DATASET([],SALT33.ShrinkLayout);
EXPORT CanSearch(Process_Biz_Layouts.InputLayout le) := le.contact_did <> (typeof(le.contact_did))'';
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch_server(TYPEOF(h.contact_did) param_contact_did = (TYPEOF(h.contact_did))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := 
    STEPPED( LIMIT( Key(
          KEYED(( contact_did = param_contact_did AND param_contact_did <> (TYPEOF(contact_did))''))
      AND KEYED(fallback_value >= param_fallback_value)),10000,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),ultid,orgid,seleid,proxid);
 
EXPORT RawFetch(TYPEOF(h.contact_did) param_contact_did = (TYPEOF(h.contact_did))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := FUNCTION
// Why not LOOP? - Because I am expecting FIRST one to win 990f the time - and don't want to impact it
  RawData0 := RawFetch_server(param_contact_did,0);
  RawData1 := RawFetch_server(param_contact_did,1);
  RawData2 := RawFetch_server(param_contact_did,2);
  Returnable(DATASET(RECORDOF(RawData0)) d) := COUNT(NOFOLD(d))<>1 OR EXISTS(NOFOLD(d((SALT33.StrType)contact_did != '')));
  res := MAP (
      param_fallback_value <= 0 AND Returnable(RawData0) => RawData0,
      param_fallback_value <= 1 AND Returnable(RawData1) => RawData1,
      RawData2);
  RETURN res;
END;
 
EXPORT ScoredproxidFetch(TYPEOF(h.contact_did) param_contact_did = (TYPEOF(h.contact_did))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := FUNCTION
  RawData := RawFetch(param_contact_did,param_fallback_value);
 
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 16; // Set bitmap for key used
    SELF.keys_failed := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1 << 16, 0); // Set bitmap for key failed
    SELF.contact_did_match_code := MAP(le.contact_did = (TYPEOF(le.contact_did))'' OR le.contact_did = (TYPEOF(le.contact_did))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_contact_did(le.contact_did,param_contact_did,TRUE));
    SELF.contact_didWeight := (50+MAP ( le.contact_did = param_contact_did  => le.contact_did_weight100,
          le.contact_did = (TYPEOF(le.contact_did))'' OR param_contact_did = (TYPEOF(le.contact_did))'' => 0,
          -0.663*le.contact_did_weight100))/100; 
    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 100, MAX(0,SELF.contact_didWeight));
    SELF := le;
  END;
  RETURN ROLLUP(PROJECT(NOFOLD(RawData),Score(LEFT)),LEFT.proxid = RIGHT.proxid,Process_Biz_Layouts.combine_scores(LEFT,RIGHT));
END;
 
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT33.UIDType Reference;//How to recognize this record in the subsequent
  TYPEOF(h.contact_did) contact_did := (TYPEOF(h.contact_did))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex) := FUNCTION
 
  Process_Biz_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 16; // Set bitmap for key used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.contact_did_match_code := MAP(le.contact_did = (TYPEOF(le.contact_did))'' OR le.contact_did = (TYPEOF(le.contact_did))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_contact_did(le.contact_did,ri.contact_did,TRUE));
    SELF.contact_didWeight := (50+MAP ( le.contact_did = ri.contact_did  => le.contact_did_weight100,
          le.contact_did = (TYPEOF(le.contact_did))'' OR ri.contact_did = (TYPEOF(le.contact_did))'' => 0,
          -0.663*le.contact_did_weight100))/100; 
    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 100, MAX(0,SELF.contact_didWeight));
    SELF := le;
  END;
  Recs0 := Recs(contact_did <> (typeof(contact_did))'');
  SALT33.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference,BizLinkFull.Config.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,LEFT.contact_did = RIGHT.contact_did,Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.contact_did = RIGHT.contact_did,10000)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),LEFT.contact_did = RIGHT.contact_did,Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.contact_did = RIGHT.contact_did,10000),HASH,HINT(unsorted_output)); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := Process_Biz_Layouts.CombineLinkpathScores(J2); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT33.MAC_Dups_Restore(J3,DD,J4,Reference,TRUE)
  RETURN J4;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_contact_did='',output_file,AsIndex='true') := MACRO
IMPORT SALT33,BizLinkFull;
#IF(#TEXT(Input_contact_did)<>'')
  #uniquename(trans)
  BizLinkFull.Key_BizHead_L_CONTACT_DID.InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    SELF.contact_did := (TYPEOF(SELF.contact_did))le.Input_contact_did;
  END;
  #uniquename(p)
  %p% := PROJECT(Infile,%trans%(left));
  output_file := BizLinkFull.Key_BizHead_L_CONTACT_DID.ScoredFetch_Batch(%p%,AsIndex);
#ELSE
  output_file := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
END;
