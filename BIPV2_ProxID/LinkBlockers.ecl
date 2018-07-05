// The purpose of this code is to generate pairs of Proxids that MAY NOT be linked together
IMPORT SALT37;
EXPORT LinkBlockers(DATASET(layout_DOT_Base) ih) := MODULE
SHARED h := specificities(ih).input_file;
SHARED bp := OverLinks;
// The object is to get a stream of Proxid pairs that cannot link
// First step is to convert the 'match criteria' in the block file into a Proxid stream
  SHARED IdRec := RECORD
    SALT37.UIDType Proxid; // The cluster id
    SALT37.UIDType RuleNum; // The id to show these 'goods and bads' are related
    SALT37.UIDType rcid; // The RecordID causing the rule to fire
    BOOLEAN Good; // Will be true for the individual, false for the bad data
  END;
  IdRec FilterHits(h le,bp ri) := TRANSFORM
    SELF.RuleNum := ri.rcid;
    SELF.Good := ri.Good;
    SELF := le;
  END;
// For now we are going to use an ALL join and assert the that RHS is small ...
// If and when that becomes an issue we will need to give the option of pulling out certain high specificity fields
  AllIds0 := JOIN(h,bp,(LEFT.active_duns_number = RIGHT.active_duns_number OR RIGHT.active_duns_number = (TYPEOF(RIGHT.active_duns_number))'')
     AND (LEFT.active_enterprise_number = RIGHT.active_enterprise_number OR RIGHT.active_enterprise_number = (TYPEOF(RIGHT.active_enterprise_number))'')
     AND (LEFT.active_domestic_corp_key = RIGHT.active_domestic_corp_key OR RIGHT.active_domestic_corp_key = (TYPEOF(RIGHT.active_domestic_corp_key))'')
     AND (LEFT.hist_enterprise_number = RIGHT.hist_enterprise_number OR RIGHT.hist_enterprise_number = (TYPEOF(RIGHT.hist_enterprise_number))'')
     AND (LEFT.hist_duns_number = RIGHT.hist_duns_number OR RIGHT.hist_duns_number = (TYPEOF(RIGHT.hist_duns_number))'')
     AND (LEFT.hist_domestic_corp_key = RIGHT.hist_domestic_corp_key OR RIGHT.hist_domestic_corp_key = (TYPEOF(RIGHT.hist_domestic_corp_key))'')
     AND (LEFT.foreign_corp_key = RIGHT.foreign_corp_key OR RIGHT.foreign_corp_key = (TYPEOF(RIGHT.foreign_corp_key))'')
     AND (LEFT.unk_corp_key = RIGHT.unk_corp_key OR RIGHT.unk_corp_key = (TYPEOF(RIGHT.unk_corp_key))'')
     AND (LEFT.ebr_file_number = RIGHT.ebr_file_number OR RIGHT.ebr_file_number = (TYPEOF(RIGHT.ebr_file_number))'')
     AND (LEFT.company_fein = RIGHT.company_fein OR RIGHT.company_fein = (TYPEOF(RIGHT.company_fein))'')
     AND LEFT.cnp_name = RIGHT.cnp_name
     AND (LEFT.company_name_type_derived = RIGHT.company_name_type_derived OR RIGHT.company_name_type_derived = (TYPEOF(RIGHT.company_name_type_derived))'')
     AND (LEFT.cnp_number = RIGHT.cnp_number OR RIGHT.cnp_number = (TYPEOF(RIGHT.cnp_number))'')
     AND (LEFT.cnp_btype = RIGHT.cnp_btype OR RIGHT.cnp_btype = (TYPEOF(RIGHT.cnp_btype))'')
     AND (LEFT.company_phone = RIGHT.company_phone OR RIGHT.company_phone = (TYPEOF(RIGHT.company_phone))'')
     AND (LEFT.prim_name_derived = RIGHT.prim_name_derived OR RIGHT.prim_name_derived = (TYPEOF(RIGHT.prim_name_derived))'')
     AND (LEFT.sec_range = RIGHT.sec_range OR RIGHT.sec_range = (TYPEOF(RIGHT.sec_range))'')
     AND (LEFT.v_city_name = RIGHT.v_city_name OR RIGHT.v_city_name = (TYPEOF(RIGHT.v_city_name))'')
     AND (LEFT.st = RIGHT.st OR RIGHT.st = (TYPEOF(RIGHT.st))'')
     AND (LEFT.zip = RIGHT.zip OR RIGHT.zip = (TYPEOF(RIGHT.zip))'')
     AND (LEFT.prim_range_derived = RIGHT.prim_range_derived OR RIGHT.prim_range_derived = (TYPEOF(RIGHT.prim_range_derived))''),FilterHits(LEFT,RIGHT),MANY LOOKUP);
  SHARED AllIds1 := DISTRIBUTE(AllIds0,HASH(RuleNum));
  SHARED AllIds := DEDUP( SORT( AllIds1,RuleNum,Proxid,Good,LOCAL ), WHOLE RECORD, LOCAL );
  EXPORT RuleBreakers0 := JOIN(AllIds,AllIds,LEFT.RuleNum=RIGHT.RuleNum AND LEFT.good <> RIGHT.good AND LEFT.rcid=RIGHT.rcid,LOCAL); // Records spanning good and bad of one rule!
  SHARED BadPairRec := RECORD
    SALT37.UIDType Proxid1;
    SALT37.UIDType Proxid2;
    SALT37.UIDType RuleNum; // Really for debug purposes - find rule being violated
  END;
  BadPairRec NotePair(AllIds le,AllIds ri) := TRANSFORM
    SELF.Proxid1 := le.Proxid;
    SELF.Proxid2 := ri.Proxid;
    SELF.RuleNum := le.RuleNum;
  END;
SHARED AllBadPairs := JOIN(AllIds,AllIds,LEFT.RuleNum = RIGHT.RuleNum AND LEFT.Proxid >= RIGHT.Proxid AND LEFT.Good <> RIGHT.Good,NotePair(LEFT,RIGHT),LOCAL);
EXPORT BrokenProxid := DEDUP(AllBadPairs(Proxid1=Proxid2),ALL);
// Now we need to create the 'patch' file for those we wish to split
// Format is RID - New DID
// First slim all the matches down to those with violations
  WithIssues := JOIN(AllIds1,BrokenProxid,LEFT.Proxid=RIGHT.Proxid1 AND LEFT.RuleNum=RIGHT.RuleNum,TRANSFORM(LEFT),SMART) : ONWARNING(1005,IGNORE);
// Now sort so that all the records that need to be clustered together - are together
SHARED InSeq := DEDUP(SORT(WithIssues,RuleNum,Proxid,Good,rcid,LOCAL),rcid,LOCAL);
  IdRec FormDid(IdRec le,IdRec ri) := TRANSFORM
    SELF.Proxid := IF ( le.RuleNum=ri.RuleNum and le.Good = ri.Good, le.Proxid, ri.rcid );
    SELF := ri;
  END;
EXPORT Patches := ITERATE(InSeq,FormDid(LEFT,RIGHT),LOCAL) : PERSIST('~temp::Proxid::BIPV2_ProxID::BlockLink::patches',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
// Now make a note of the new IDs that will be created
  allid := DEDUP(Patches,Proxid,ALL); // All the new dids (including old ones!)
EXPORT New := JOIN(allid,InSeq,LEFT.Proxid=RIGHT.Proxid,TRANSFORM(LEFT),LEFT ONLY);
EXPORT RuleCountTotal := COUNT(DEDUP(bp, rcid, ALL));
EXPORT RuleCountActive := COUNT(TABLE(New, {RuleNum}, RuleNum, FEW)); 
SALT37.MAC_Reassign_UID(h,Patches,Proxid,rcid,h1);
//Provide a version of the input file which has been split according to linkblockers
EXPORT input_file := h1;
// Now we need to create blockers - both for the DIDs which are already split
// and for those we are about to split out
  BadPairRec NoteNewPair(Patches le,Patches ri) := TRANSFORM
    SELF.Proxid1 := le.Proxid;
    SELF.Proxid2 := ri.Proxid;
    SELF.RuleNum := le.RuleNum;
  END;
  PB := DEDUP(Patches,Proxid,RuleNum,Good,ALL);
  NewPairs := JOIN(PB,PB,LEFT.RuleNum=RIGHT.RuleNum and LEFT.Proxid>RIGHT.Proxid AND LEFT.Good<>Right.Good,NoteNewPair(LEFT,RIGHT));
EXPORT Block := DEDUP(NewPairs+AllBadPairs(Proxid1<>Proxid2),WHOLE RECORD,ALL);
END;
