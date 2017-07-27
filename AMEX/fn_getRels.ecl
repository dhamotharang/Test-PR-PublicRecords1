import contactCard,doxie;
export fn_getRels(dataset (doxie.layout_references) dids) := FUNCTION
//contact card
finderRels := ContactCard.FinderRecords(dids).rel_det;
//risk wise	rels	
outrec  := record
  doxie.layout_references;
  integer recent_cohabit;
end;
outrec get_all_dids(doxie.layout_references le, doxie.Key_Relatives r) := TRANSFORM
	 SELF.did := r.person2;
	 self.recent_cohabit := r.recent_cohabit;
END;						 
rel_ids := JOIN(dids, doxie.Key_Relatives, keyed(LEFT.did=RIGHT.person1), get_all_dids(LEFT,RIGHT), KEEP(100));
recordof(finderRels)  samerec(outrec l) := transform
  self := l;
	self := [];
end;
allrels := project(rel_ids, samerec(left));
bothsets := allrels + finderRels;
bothsorted := sort(bothsets, did , -title, -recent_cohabit);
dedupall := sort(dedup(bothsorted,did),-recent_cohabit);
top10Rels := TOPN (dedupall, AMEX.constants.max_rel, -recent_cohabit, record) ;

RETURN top10Rels;
END;