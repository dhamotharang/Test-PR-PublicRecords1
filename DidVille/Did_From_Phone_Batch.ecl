import doxie, header_services, ut;
export Did_From_Phone_Batch(DATASET(didville.Layout_BestInfo_BatchIn) indata, 
                            boolean dodedup) := FUNCTION

unsigned4 reclimit := ut.limits.default;

parent_rec := RECORD
     qstring20 acctno;
	DATASET(doxie.layout_references) child_dids {maxcount(reclimit)};
END;

parent_rec tran(didville.Layout_BestInfo_BatchIn l) := TRANSFORM
	matching_dids := Header_Services.Fetch_Header_Phone_Function(l.phoneno, l.name_last, l.name_first);
	SELF.child_dids := choosen(matching_dids, reclimit);
	SELF := l;
END;

ParentRecs := project(indata(phoneno!=''),tran(LEFT));

out_rec := record
	qstring20 acctno;
	doxie.layout_references;
end;

out_rec NormIt(ParentRecs l, doxie.layout_references r) := TRANSFORM
	SELF.did := r.did;
	SELF.acctno := l.acctno;
END;

NormRecs := NORMALIZE(ParentRecs,LEFT.child_dids,NormIt(Left,Right));

Outrecs := IF(dodedup, DEDUP(NormRecs,acctno,did,all), NormRecs);

RETURN Outrecs;

END;