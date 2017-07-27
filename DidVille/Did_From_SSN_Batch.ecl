import doxie, header, header_services, ut;

export Did_From_SSN_Batch(DATASET(didville.Layout_BestInfo_BatchIn) indata, 
                          boolean dodedup,
 					 unsigned1 score_threshold_value,
					 boolean use_loose) := FUNCTION

unsigned4 reclimit := ut.limits.default;
					 
parent_rec := RECORD
	qstring20 acctno;
	DATASET(doxie.layout_references) child_dids {maxcount(reclimit)};
END;

parent_rec tran(didville.Layout_BestInfo_BatchIn l) := TRANSFORM
	matching_dids := Header_Services.Fetch_SSN_MOXIE_Function(l.ssn,
	                                                          l.name_last,
	                                                          l.name_first,
												   l.name_middle,
												   score_threshold_value,
												   use_loose);
	SELF.child_dids := choosen(matching_dids, reclimit);
	SELF := l;
END;

ParentRecs := project(indata(length(trim(ssn))=9),tran(LEFT));

out_rec := record
     qstring20 acctno;
	doxie.layout_references;
end;

out_rec NormIt(ParentRecs l, doxie.layout_references r) := TRANSFORM
     SELF.acctno := l.acctno;
	SELF.did := r.did;
END;

NormRecs := NORMALIZE(ParentRecs,LEFT.child_dids,NormIt(Left,Right));

Outrecs := IF(dodedup, DEDUP(NormRecs,acctno,did,all), NormRecs);

RETURN Outrecs;

END;