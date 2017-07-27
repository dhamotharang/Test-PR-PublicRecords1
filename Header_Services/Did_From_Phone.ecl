import doxie, header;
export Did_From_Phone (DATASET(header.Layout_Header) indata, boolean dodedup) :=
FUNCTION
parent := RECORD
	DATASET(doxie.layout_references) child_dids;
END;

parent tran(header.Layout_Header l) :=
TRANSFORM
	,SKIP(l.phone = '')
	/*
Fetch_Header_Phone_Function(string10 phone_value
																	,string20 lname_value
																	,string20 fname_value
																	)
*/
	matching_dids := Header_Services.Fetch_Header_Phone_Function(l.phone, '', '');
	SELF.child_dids := matching_dids;
END;
dedupedindata := DEDUP(SORT(indata,phone),phone);
ParentRecs := project(dedupedindata,tran(LEFT));
doxie.layout_references NormIt(ParentRecs l, doxie.layout_references r) := TRANSFORM
	SELF.did := r.did;
END;

NormRecs := NORMALIZE(ParentRecs,LEFT.child_dids,NormIt(Left,Right));

Outrecs := IF(dodedup, DEDUP(NormRecs,did,all), NormRecs);


RETURN Outrecs;

END;
