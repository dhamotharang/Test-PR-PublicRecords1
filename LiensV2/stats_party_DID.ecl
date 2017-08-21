import liensv2, Doxie, strata;

get_recs := LiensV2.file_liens_party;


rec_stats := record
  integer countGroup := count(group);
  Tmsid              := get_recs.TMSID[1..2];
  Has_DID 	 := sum(group,IF((unsigned6)get_recs(lname <> '').did <> 0,1,0))/sum(group,IF(get_recs.lname <> '',1,0)) * 100;
  has_bdid    := sum(group,IF((unsigned6)get_recs(cname <> '').bdid <> 0,1,0))/sum(group,IF(get_recs.cname <> '',1,0)) * 100;
end;

DID_party_stats := table(get_recs, rec_stats, get_recs.TMSID[1..2], few);


export stats_party_DID := output(DID_party_stats);


