IMPORT BizLinkFull,SALT37,std;
EXPORT Key_BizHead_L_CONTACT_DID := MODULE
 
//contact_did
EXPORT KeyName := PRTE2_BIPV2_BusHeader.Filename_keys.L_CONTACT_DID; /*HACK07*/
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
 
s := PRTE2_BIPV2_BusHeader.Specificities(PRTE2_BIPV2_BusHeader.File_BizHead).Specificities[1];
 
DataForKey0 := DEDUP(SORT(TABLE(h((contact_did NOT IN SET(s.nulls_contact_did,contact_did) AND contact_did <> (TYPEOF(contact_did))'')),layout),contact_did,proxid,seleid,orgid,ultid,powid,contact_did_weight100,-fallback_value,LOCAL),WHOLE RECORD,EXCEPT fallback_value,LOCAL);
SHARED DataForKey := DataForKey0;
 
EXPORT Key := INDEX(DataForKey,{DataForKey},{},KeyName);
 
EXPORT BuildAll := BUILDINDEX(Key, OVERWRITE);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,proxid,contact_did,LOCAL); // Not perfect, does not need to be - for statistics
EXPORT Shrinkage := DATASET([],SALT37.ShrinkLayout);
EXPORT CanSearch(PRTE2_BIPV2_BusHeader.Process_Biz_Layouts.InputLayout le) := le.contact_did <> (TYPEOF(le.contact_did))'' AND BizLinkFull.Fields.InValid_contact_did((SALT37.StrType)le.contact_did)=0;
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch_server(TYPEOF(h.contact_did) param_contact_did = (TYPEOF(h.contact_did))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := 
    STEPPED( LIMIT( Key(
          KEYED(( contact_did = param_contact_did AND param_contact_did <> (TYPEOF(contact_did))''))
      AND KEYED(fallback_value >= param_fallback_value)),BizLinkFull.Config_BIP.L_CONTACT_DID_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),ultid,orgid,seleid,proxid);
 
EXPORT RawFetch(TYPEOF(h.contact_did) param_contact_did = (TYPEOF(h.contact_did))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := FUNCTION
// Why not LOOP? - Because I am expecting FIRST one to win 990f the time - and don't want to impact it
  RawData0 := RawFetch_server(param_contact_did,0);
  RawData1 := RawFetch_server(param_contact_did,1);
  RawData2 := RawFetch_server(param_contact_did,2);
  Returnable(DATASET(RECORDOF(RawData0)) d) := COUNT(NOFOLD(d))<>1 OR EXISTS(NOFOLD(d((SALT37.StrType)contact_did != '')));
  res := MAP (
      param_fallback_value <= 0 AND Returnable(RawData0) => RawData0,
      param_fallback_value <= 1 AND Returnable(RawData1) => RawData1,
      RawData2);
  RETURN res;
END;
 
EXPORT ScoredproxidFetch(TYPEOF(h.contact_did) param_contact_did = (TYPEOF(h.contact_did))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetch(param_contact_did,param_fallback_value);
 
  PRTE2_BIPV2_BusHeader.Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 16; // Set bitmap for keys used
    SELF.keys_failed := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1 << 16, 0); // Set bitmap for key failed
    SELF.contact_did_match_code := BizLinkFull.match_methods(PRTE2_BIPV2_BusHeader.File_BizHead).match_contact_did(le.contact_did,param_contact_did,TRUE);
    SELF.contact_didWeight := (50+MAP (
           le.contact_did = param_contact_did  => le.contact_did_weight100,
          le.contact_did = (TYPEOF(le.contact_did))'' OR param_contact_did = (TYPEOF(le.contact_did))'' => 0,
          -0.663*le.contact_did_weight100))/100; 
    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 100, MAX(0,SELF.contact_didWeight));
    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));
  result1 := PROJECT(result0, PRTE2_BIPV2_BusHeader.Process_Biz_Layouts.update_forcefailed(LEFT,param_disableForce));
  result2 := ROLLUP(result1,LEFT.proxid = RIGHT.proxid,PRTE2_BIPV2_BusHeader.Process_Biz_Layouts.combine_scores(LEFT,RIGHT,param_disableForce));
  RETURN result2;
END;
 
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT37.UIDType Reference;//How to recognize this record in the subsequent
  TYPEOF(h.contact_did) contact_did := (TYPEOF(h.contact_did))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex, BOOLEAN In_disableForce = FALSE) := FUNCTION
 
  PRTE2_BIPV2_BusHeader.Process_Biz_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 16; // Set bitmap for keys used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.contact_did_match_code := BizLinkFull.match_methods(PRTE2_BIPV2_BusHeader.File_BizHead).match_contact_did(le.contact_did,ri.contact_did,TRUE);
    SELF.contact_didWeight := (50+MAP (
           le.contact_did = ri.contact_did  => le.contact_did_weight100,
          le.contact_did = (TYPEOF(le.contact_did))'' OR ri.contact_did = (TYPEOF(le.contact_did))'' => 0,
          -0.663*le.contact_did_weight100))/100; 
    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 100, MAX(0,SELF.contact_didWeight));
    SELF := le;
  END;
  Recs0 := Recs(contact_did <> (TYPEOF(contact_did))'');
  SALT37.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference,BizLinkFull.Config_BIP.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,LEFT.contact_did = RIGHT.contact_did,Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.contact_did = RIGHT.contact_did,BizLinkFull.Config_BIP.L_CONTACT_DID_MAXBLOCKSIZE)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),LEFT.contact_did = RIGHT.contact_did,Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.contact_did = RIGHT.contact_did,BizLinkFull.Config_BIP.L_CONTACT_DID_MAXBLOCKSIZE),HASH,UNORDERED); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := PROJECT(J2, PRTE2_BIPV2_BusHeader.Process_Biz_Layouts.update_forcefailed(LEFT,In_disableForce));
  J4 := PRTE2_BIPV2_BusHeader.Process_Biz_Layouts.CombineLinkpathScores(J3,In_disableForce); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT37.MAC_Dups_Restore(J4,DD,J5,Reference,TRUE)
  RETURN J5;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_contact_did='',output_file,AsIndex='true', In_disableForce = 'false') := MACRO
IMPORT SALT37,BizLinkFull;
#IF(#TEXT(Input_contact_did)<>'')
  #uniquename(trans)
  PRTE2_BIPV2_BusHeader.Key_BizHead_L_CONTACT_DID.InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    SELF.contact_did := (TYPEOF(SELF.contact_did))le.Input_contact_did;
  END;
  #uniquename(p)
  %p% := PROJECT(Infile,%trans%(left));
  output_file := PRTE2_BIPV2_BusHeader.Key_BizHead_L_CONTACT_DID.ScoredFetch_Batch(%p%,AsIndex, In_disableForce);
#ELSE
  output_file := DATASET([],PRTE2_BIPV2_BusHeader.Process_Biz_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
END;
