import doxie, header, ut;
export Did_From_SSN (DATASET(header.Layout_Header) indata, boolean dodedup,
												unsigned1 score_threshold_value) :=
FUNCTION

DID_PER_SSN := ut.limits.DID_PER_SSN;
parent := RECORD
	DATASET(doxie.layout_references) child_dids {maxcount(DID_PER_SSN)};
END;

parent tran(header.Layout_Header l) :=
TRANSFORM
	,SKIP(l.ssn = '')
	//Fetch_Header_SSN_Function (string9 ssn_value
	//															 ,string20 lname_value
	//															 ,string20 fname_value
	//															 ,unsigned1 score_threshold_value
	//															 )
	matching_dids := choosen(Header_Services.Fetch_Header_SSN_Function(l.ssn,'',
																			'',score_threshold_value), DID_PER_SSN);
	SELF.child_dids := matching_dids;
END;
dedupedindata := DEDUP(SORT(indata,ssn),ssn);
ParentRecs := project(dedupedindata,tran(LEFT));
doxie.layout_references NormIt(ParentRecs l, doxie.layout_references r) := TRANSFORM
	SELF.did := r.did;
END;

NormRecs := NORMALIZE(ParentRecs,LEFT.child_dids,NormIt(Left,Right));

Outrecs := IF(dodedup, DEDUP(NormRecs,did,all), NormRecs);


RETURN Outrecs;

END;
