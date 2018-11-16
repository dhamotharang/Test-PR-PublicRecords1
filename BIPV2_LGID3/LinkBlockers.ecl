// The purpose of this code is to generate pairs of LGID3s that MAY NOT be linked together
IMPORT SALT311;
EXPORT LinkBlockers(DATASET(layout_LGID3) ih) := MODULE
SHARED h := Specificities(ih).input_file;
SHARED bp := OverLinks;
// The object is to get a stream of LGID3 pairs that cannot link
// First step is to convert the 'match criteria' in the block file into a LGID3 stream
  SHARED IdRec := RECORD
    SALT311.UIDType LGID3; // The cluster id
    SALT311.UIDType RuleNum; // The id to show these 'goods and bads' are related
    SALT311.UIDType rcid; // The RecordID causing the rule to fire
    BOOLEAN Good; // Will be true for the individual, false for the bad data
  END;
  IdRec FilterHits(h le,bp ri) := TRANSFORM
    SELF.RuleNum := ri.rcid;
    SELF.Good := ri.Good;
    SELF := le;
  END;
// For now we are going to use an ALL join and assert the that RHS is small ...
// If and when that becomes an issue we will need to give the option of pulling out certain high specificity fields
  AllIds0 := JOIN(h, bp,
    (LEFT.sbfe_id = RIGHT.sbfe_id OR RIGHT.sbfe_id = (TYPEOF(RIGHT.sbfe_id))'')
    AND (LEFT.Lgid3IfHrchy = RIGHT.Lgid3IfHrchy OR RIGHT.Lgid3IfHrchy = (TYPEOF(RIGHT.Lgid3IfHrchy))'')
    AND LEFT.company_name = RIGHT.company_name
    AND (LEFT.cnp_number = RIGHT.cnp_number OR RIGHT.cnp_number = (TYPEOF(RIGHT.cnp_number))'')
    AND (LEFT.active_duns_number = RIGHT.active_duns_number OR RIGHT.active_duns_number = (TYPEOF(RIGHT.active_duns_number))'')
    AND (LEFT.duns_number = RIGHT.duns_number OR RIGHT.duns_number = (TYPEOF(RIGHT.duns_number))'')
    AND (LEFT.company_fein = RIGHT.company_fein OR RIGHT.company_fein = (TYPEOF(RIGHT.company_fein))'')
    AND (LEFT.company_inc_state = RIGHT.company_inc_state OR RIGHT.company_inc_state = (TYPEOF(RIGHT.company_inc_state))'')
    AND (LEFT.company_charter_number = RIGHT.company_charter_number OR RIGHT.company_charter_number = (TYPEOF(RIGHT.company_charter_number))'')
    AND (LEFT.cnp_btype = RIGHT.cnp_btype OR RIGHT.cnp_btype = (TYPEOF(RIGHT.cnp_btype))'')
    , FilterHits(LEFT, RIGHT), MANY LOOKUP);
  SHARED AllIds1 := DISTRIBUTE(AllIds0,HASH(RuleNum));
  SHARED AllIds := DEDUP( SORT( AllIds1,RuleNum,LGID3,Good,LOCAL ), WHOLE RECORD, LOCAL );
  EXPORT RuleBreakers0 := JOIN(AllIds,AllIds,LEFT.RuleNum=RIGHT.RuleNum AND LEFT.good <> RIGHT.good AND LEFT.rcid=RIGHT.rcid,LOCAL); // Records spanning good and bad of one rule!
  SHARED BadPairRec := RECORD
    SALT311.UIDType LGID31;
    SALT311.UIDType LGID32;
    SALT311.UIDType RuleNum; // Really for debug purposes - find rule being violated
  END;
  BadPairRec NotePair(AllIds le,AllIds ri) := TRANSFORM
    SELF.LGID31 := le.LGID3;
    SELF.LGID32 := ri.LGID3;
    SELF.RuleNum := le.RuleNum;
  END;
SHARED AllBadPairs := JOIN(AllIds,AllIds,LEFT.RuleNum = RIGHT.RuleNum AND LEFT.LGID3 >= RIGHT.LGID3 AND LEFT.Good <> RIGHT.Good,NotePair(LEFT,RIGHT),LOCAL);
EXPORT BrokenLGID3 := DEDUP(AllBadPairs(LGID31=LGID32),ALL);
// Now we need to create the 'patch' file for those we wish to split
// Format is RID - New DID
// First slim all the matches down to those with violations
  WithIssues := JOIN(AllIds1,BrokenLGID3,LEFT.LGID3=RIGHT.LGID31 AND LEFT.RuleNum=RIGHT.RuleNum,TRANSFORM(LEFT),SMART) : ONWARNING(1005,IGNORE);
// Now sort so that all the records that need to be clustered together - are together
SHARED InSeq := DEDUP(SORT(WithIssues,RuleNum,LGID3,Good,rcid,LOCAL),rcid,LOCAL);
  IdRec FormDid(IdRec le,IdRec ri) := TRANSFORM
    SELF.LGID3 := IF ( le.RuleNum=ri.RuleNum and le.Good = ri.Good, le.LGID3, ri.rcid );
    SELF := ri;
  END;
EXPORT PatchesAll := ITERATE(InSeq,FormDid(LEFT,RIGHT),LOCAL);
//Identify all rules that can cause an RID to be Good as True AND False for the same entity
//Rids that assigned to more than one cluster
EXPORT Patches_dirty_rids0 :=JOIN(PatchesAll, PatchesAll, LEFT.rcid = RIGHT.rcid AND LEFT.LGID3 <> RIGHT.LGID3, TRANSFORM(LEFT),HASH) : PERSIST('~temp::LGID3::BIPV2_LGID3::BlockLink::patches_dirty_rids0',EXPIRE(BIPV2_LGID3.Config.PersistExpire));
EXPORT IgnoreRules0 := DEDUP(SORT(DISTRIBUTE(Patches_dirty_rids0,HASH(RuleNum)), RuleNum, LOCAL),RuleNum, LOCAL);
EXPORT Patches_dirty0 := JOIN(PatchesAll,  IgnoreRules0, LEFT.RuleNum = RIGHT.RuleNum, TRANSFORM(LEFT)) : PERSIST('~temp::LGID3::BIPV2_LGID3::BlockLink::patches_dirty0',EXPIRE(BIPV2_LGID3.Config.PersistExpire));
EXPORT Patches := JOIN(PatchesAll,  IgnoreRules0, LEFT.RuleNum = RIGHT.RuleNum, TRANSFORM(LEFT), LEFT ONLY) : PERSIST('~temp::LGID3::BIPV2_LGID3::BlockLink::patches',EXPIRE(BIPV2_LGID3.Config.PersistExpire));
// Now make a note of the new IDs that will be created
  allid := DEDUP(Patches,LGID3,ALL); // All the new dids (including old ones!)
EXPORT New := JOIN(allid,InSeq,LEFT.LGID3=RIGHT.LGID3,TRANSFORM(LEFT),LEFT ONLY);
EXPORT RuleCountTotal := COUNT(DEDUP(bp, rcid, ALL));
EXPORT RuleCountActive := COUNT(TABLE(New, {RuleNum}, RuleNum, FEW)); 
SALT311.MAC_Reassign_UID(h,Patches,LGID3,rcid,h1);
//Provide a version of the input file which has been split according to linkblockers
EXPORT input_file := h1;
// Now we need to create blockers - both for the DIDs which are already split
// and for those we are about to split out
  BadPairRec NoteNewPair(Patches le,Patches ri) := TRANSFORM
    SELF.LGID31 := le.LGID3;
    SELF.LGID32 := ri.LGID3;
    SELF.RuleNum := le.RuleNum;
  END;
  PB := DEDUP(Patches,LGID3,RuleNum,Good,ALL);
  NewPairs := JOIN(PB,PB,LEFT.RuleNum=RIGHT.RuleNum and LEFT.LGID3>RIGHT.LGID3 AND LEFT.Good<>Right.Good,NoteNewPair(LEFT,RIGHT));
EXPORT Block := DEDUP(NewPairs+AllBadPairs(LGID31<>LGID32),WHOLE RECORD,ALL);
END;
