import doxie, header, header_services, autokey, utilfile, didville;

export QuickDid_From_SSN_Batch(DATASET(didville.Layout_BestInfo_BatchIn) indata, 
                              boolean dodedup,
 					     unsigned1 score_threshold_value) := FUNCTION
					 
parent_rec := RECORD
	qstring20 acctno;
	DATASET(doxie.layout_references) child_dids;
END;

parent_rec tran(didville.Layout_BestInfo_BatchIn l) := TRANSFORM
	matching_dids := header_quick.Fetch_Quick_SSN_Function(l.ssn,
	                                                       l.name_last,
	                                                       l.name_first,
											     score_threshold_value);
	SELF.child_dids := matching_dids;
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

Outrecs := IF(dodedup, DEDUP(NormRecs,did,all), NormRecs);

RETURN Outrecs;

END;