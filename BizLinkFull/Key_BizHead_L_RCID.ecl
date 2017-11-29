EXPORT Key_BizHead_L_RCID := MODULE
IMPORT SALT28,ut,std;
//rcid2
EXPORT KeyName := BizLinkFull.Filename_keys.L_RCID;
SHARED h := CandidatesForKey;//The input file - distributed by proxid
layout := RECORD // project out required fields
// Compulsory fields
  h.rcid2;
  h.ultid; // Parent #3
  h.orgid; // Parent #2
  h.seleid; // Parent #1
  h.proxid; // The ID field
//Scores for various field components
  h.rcid2_weight100 ; // Contains 100x the specificity
END;
s := Specificities(File_BizHead).Specificities[1];
DataForKey0 := DEDUP(SORT(TABLE(h(rcid2 NOT IN SET(s.nulls_rcid2,rcid2)),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
EXPORT Key := INDEX(DataForKey0,,KeyName);
EXPORT CanSearch(Process_Biz_Layouts.InputLayout le) := le.rcid2 <> (typeof(le.rcid2))'';
KeyRec := RECORDOF(Key);
EXPORT RawFetch( typeof(h.rcid2) param_rcid2) := 
    STEPPED( LIMIT( Key(
          ( rcid2 = param_rcid2 AND param_rcid2 <> (TYPEOF(rcid2))'' )),10000,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),ultid,orgid,seleid,proxid);
EXPORT ScoredproxidFetch( typeof(h.rcid2) param_rcid2) := FUNCTION
  RawData := RawFetch(param_rcid2);
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 14; // Set bitmap for key used
    SELF.keys_failed := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1 << 14, 0); // Set bitmap for key failed
    SELF.rcid2Weight := (50+MAP ( le.rcid2 = param_rcid2  => le.rcid2_weight100,
          le.rcid2 = (TYPEOF(le.rcid2))'' OR le.rcid2 = (TYPEOF(le.rcid2))'' => 0,
           -1.000*le.rcid2_weight100))/100; 
    SELF.Weight :=MAX(0,SELF.rcid2Weight);
    SELF := le;
  END;
  RETURN ROLLUP(PROJECT(NOFOLD(RawData),Score(LEFT)),LEFT.proxid = RIGHT.proxid,Process_Biz_Layouts.combine_scores(LEFT,RIGHT));
END;
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT28.UIDType Reference;//How to recognize this record in the subsequent
  TYPEOF(h.rcid2) rcid2 := (TYPEOF(h.rcid2))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex) := FUNCTION
  Process_Biz_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 14; // Set bitmap for key used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.rcid2Weight := (50+MAP ( le.rcid2 = ri.rcid2  => le.rcid2_weight100,
          le.rcid2 = (TYPEOF(le.rcid2))'' OR le.rcid2 = (TYPEOF(le.rcid2))'' => 0,
           -1.000*le.rcid2_weight100))/100; 
    SELF.Weight :=MAX(0,SELF.rcid2Weight);
    SELF := le;
  END;
J0 := JOIN(Recs(rcid2 <> (typeof(rcid2))''),Key,LEFT.rcid2 = RIGHT.rcid2,Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.rcid2 = RIGHT.rcid2,/*HACK*/2000)); // Use indexed join (used for smaller batches
J1 := JOIN(Recs(rcid2 <> (typeof(rcid2))''),PULL(Key),LEFT.rcid2 = RIGHT.rcid2,Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.rcid2 = RIGHT.rcid2,/*HACK*/2000),HASH); // PULL used to cause non-indexed join
  RETURN IF(AsIndex,J0,J1);
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_rcid2='',output_file,AsIndex='true') := MACRO
IMPORT SALT28,BizLinkFull;
#IF(#TEXT(Input_rcid2)<>'')
  #uniquename(trans)
  BizLinkFull.Key_BizHead_L_RCID.InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    SELF.rcid2 := (TYPEOF(SELF.rcid2))le.Input_rcid2;
  END;
  #uniquename(p)
  %p% := PROJECT(Infile,%trans%(left));
  output_file := BizLinkFull.Key_BizHead_L_RCID.ScoredFetch_Batch(%p%,AsIndex);
#ELSE
  output_file := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
END;

