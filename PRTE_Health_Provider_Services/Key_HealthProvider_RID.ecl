EXPORT Key_HealthProvider_RID := MODULE
IMPORT SALT29,ut,std;
//RID
EXPORT KeyName := PRTE_Health_Provider_Services.Files.FILE_RID; //'~'+'key::PRTE_Health_Provider_Services::LNPID::Refs::RID';
SHARED h := CandidatesForKey;//The input file - distributed by LNPID
layout := RECORD // project out required fields
// Compulsory fields
  h.RID;
  h.LNPID; // The ID field
//Scores for various field components
  h.RID_weight100 ; // Contains 100x the specificity
END;
s := Specificities(File_HealthProvider).Specificities[1];
DataForKey0 := DEDUP(SORT(TABLE(h(RID NOT IN SET(s.nulls_RID,RID)),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
EXPORT Key := INDEX(DataForKey0,,KeyName);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,LNPID,RID,LOCAL); // Not perfect, does not need to be - for statistics
EXPORT Shrinkage := DATASET([],SALT29.ShrinkLayout);
EXPORT CanSearch(Process_xLNPID_Layouts.InputLayout le) := le.RID <> (typeof(le.RID))'';
KeyRec := RECORDOF(Key);
EXPORT RawFetch(TYPEOF(h.RID) param_RID) := 
    STEPPED( LIMIT( Key(
          ( RID = param_RID AND param_RID <> (TYPEOF(RID))'' )),10000,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),LNPID);
EXPORT ScoredLNPIDFetch(TYPEOF(h.RID) param_RID) := FUNCTION
  RawData := RawFetch(param_RID);
  Process_xLNPID_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 24; // Set bitmap for key used
    SELF.keys_failed := IF(le.LNPID = 0, 1 << 24, 0); // Set bitmap for key failed
    SELF.RID_match_code := MAP(
		le.RID = (TYPEOF(le.RID))'' OR le.RID = (TYPEOF(le.RID))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_RID(le.RID,param_RID,TRUE));
    SELF.RIDWeight := (50+MAP ( le.RID = param_RID  => le.RID_weight100,
          le.RID = (TYPEOF(le.RID))'' OR param_RID = (TYPEOF(le.RID))'' => 0,
           -0.000*le.RID_weight100))/100; 
    SELF.Weight :=MAX(0,SELF.RIDWeight);
    SELF := le;
  END;
  RETURN ROLLUP(PROJECT(NOFOLD(RawData),Score(LEFT)),LEFT.LNPID = RIGHT.LNPID,Process_xLNPID_Layouts.combine_scores(LEFT,RIGHT));
END;
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT29.UIDType Reference;//How to recognize this record in the subsequent
  TYPEOF(h.RID) RID := (TYPEOF(h.RID))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex) := FUNCTION
  Process_xLNPID_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 24; // Set bitmap for key used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.RID_match_code := MAP(
		le.RID = (TYPEOF(le.RID))'' OR le.RID = (TYPEOF(le.RID))'' => SALT29.MatchCode.OneSideNull,match_methods(File_HealthProvider).match_RID(le.RID,ri.RID,TRUE));
    SELF.RIDWeight := (50+MAP ( le.RID = ri.RID  => le.RID_weight100,
          le.RID = (TYPEOF(le.RID))'' OR ri.RID = (TYPEOF(le.RID))'' => 0,
           -0.000*le.RID_weight100))/100; 
    SELF.Weight :=MAX(0,SELF.RIDWeight);
    SELF := le;
  END;
  Recs0 := Recs(RID <> (typeof(RID))'');
  SALT29.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,LEFT.RID = RIGHT.RID,Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.RID = RIGHT.RID,10000)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),LEFT.RID = RIGHT.RID,Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.RID = RIGHT.RID,10000),HASH,HINT(unsorted_output)); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := Process_xLNPID_Layouts.CombineLinkpathScores(J2); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT29.MAC_Dups_Restore(J3,DD,J4,Reference,TRUE)
  RETURN J4;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_RID='',output_file,AsIndex='true') := MACRO
IMPORT SALT29,PRTE_Health_Provider_Services;
#IF(#TEXT(Input_RID)<>'')
  #uniquename(trans)
  PRTE_Health_Provider_Services.Key_HealthProvider_RID.InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    SELF.RID := (TYPEOF(SELF.RID))le.Input_RID;
  END;
  #uniquename(p)
  %p% := PROJECT(Infile,%trans%(left));
  output_file := PRTE_Health_Provider_Services.Key_HealthProvider_RID.ScoredFetch_Batch(%p%,AsIndex);
#ELSE
  output_file := DATASET([],PRTE_Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
END;
