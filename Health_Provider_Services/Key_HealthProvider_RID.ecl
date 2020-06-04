IMPORT SALT311,std;
EXPORT Key_HealthProvider_RID := MODULE
 
//RID
EXPORT KeyName := Health_Provider_Services.Files.FILE_Rid_SF;  //'~'+'key::Health_Provider_Services::LNPID::Refs::RID';
SHARED h := CandidatesForKey;//The input file - distributed by LNPID
 
SHARED s := Specificities(File_HealthProvider).Specificities[1];
SHARED s_index := Keys(File_HealthProvider).Specificities_Key[1]; // Index access for MEOW queries
layout := RECORD // project out required fields
// Compulsory fields
  h.RID;
  h.LNPID; // The ID field
//Scores for various field components
  h.RID_weight100 ; // Contains 100x the specificity
END;
 
DataForKey0 := DEDUP(SORT(TABLE(h((RID NOT IN SET(s.nulls_RID,RID) AND RID <> (TYPEOF(RID))'')),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
SHARED DataForKey := DataForKey0;
 
EXPORT Key := INDEX(DataForKey,{DataForKey},{},KeyName);
 
EXPORT BuildAll := BUILDINDEX(Key, OVERWRITE);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,LNPID,RID,LOCAL); // Not perfect, does not need to be - for statistics
EXPORT Shrinkage := DATASET([],SALT311.ShrinkLayout);
EXPORT CanSearch(Process_xLNPID_Layouts.InputLayout le) := le.RID <> (TYPEOF(le.RID))'' AND Fields.InValid_RID((SALT311.StrType)le.RID)=0;
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(TYPEOF(h.RID) param_RID = (TYPEOF(h.RID))'') := 
    STEPPED( LIMIT( Key(
          KEYED((RID = param_RID))),Config.RID_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),LNPID);
 
 
EXPORT ScoredLNPIDFetch(TYPEOF(h.RID) param_RID = (TYPEOF(h.RID))'') := FUNCTION
  RawData := RawFetch(param_RID);
 
  Process_xLNPID_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 24; // Set bitmap for keys used
    SELF.keys_failed := IF(le.LNPID = 0, 1 << 24, 0); // Set bitmap for key failed
    SELF.RID_match_code := match_methods(File_HealthProvider).match_RID(le.RID,param_RID,TRUE);
    SELF.RIDWeight := (50+MAP (
           SELF.RID_match_code = SALT311.MatchCode.ExactMatch =>le.RID_weight100,
           -0.000*le.RID_weight100))/100; 
    SELF.Weight := IF(le.LNPID = 0, 100, MAX(0, SELF.RIDWeight));
    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));
  result1 := ROLLUP(result0,LEFT.LNPID = RIGHT.LNPID,Process_xLNPID_Layouts.combine_scores(LEFT,RIGHT));
  RETURN result1;
END;
 
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT311.UIDType Reference;//How to recognize this record in the subsequent
  TYPEOF(h.RID) RID := (TYPEOF(h.RID))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex) := FUNCTION
 
  Process_xLNPID_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 24; // Set bitmap for keys used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.RID_match_code := match_methods(File_HealthProvider).match_RID(le.RID,ri.RID,TRUE);
    SELF.RIDWeight := (50+MAP (
           SELF.RID_match_code = SALT311.MatchCode.ExactMatch =>le.RID_weight100,
           -0.000*le.RID_weight100))/100; 
    SELF.Weight := IF(le.LNPID = 0, 100, MAX(0, SELF.RIDWeight));
    SELF := le;
  END;
  Recs0 := Recs(RID <> (TYPEOF(RID))'');
  SALT311.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference,Config.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,((RIGHT.RID = LEFT.RID)),Score_Batch(RIGHT,LEFT),
    ATMOST(((RIGHT.RID = LEFT.RID)),Config.RID_MAXBLOCKSIZE)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),((RIGHT.RID = LEFT.RID)),Score_Batch(RIGHT,LEFT),
    ATMOST(((RIGHT.RID = LEFT.RID)),Config.RID_MAXBLOCKSIZE),HASH,UNORDERED); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := Process_xLNPID_Layouts.CombineLinkpathScores(J2); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT311.MAC_Dups_Restore(J3,DD,J4,Reference,TRUE)
  RETURN J4;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_RID='',output_file,AsIndex='true') := MACRO
  IMPORT SALT311,Health_Provider_Services;
  #IF(#TEXT(Input_RID)<>'')
    #UNIQUENAME(trans)
    Health_Provider_Services.Key_HealthProvider_RID.InputLayout_Batch %trans%(InFile le) := TRANSFORM
      SELF.Reference := le.Input_Ref;
      SELF.RID := (TYPEOF(SELF.RID))le.Input_RID;
    END;
    #UNIQUENAME(p)
    %p% := PROJECT(Infile,%trans%(left));
    output_file := Health_Provider_Services.Key_HealthProvider_RID.ScoredFetch_Batch(%p%,AsIndex);
  #ELSE
    output_file := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.LayoutScoredFetch); // Compulsory fields missing
  #END
ENDMACRO;
END;
