import ut;
export SSN_Match_Score(string ssn1, string ssn2, boolean fouronly = false) := 
if(ssn1<>'' and ssn2<>'',
	if (fouronly,
		100-(10*(MAX(ut.stringsimilar(ssn1[length(trim(ssn1))-3..length(trim(ssn1))], ssn2[length(trim(ssn2)) - 3 .. length(trim(ssn2))]), 
								 ut.stringsimilar(ssn2[length(trim(ssn2)) - 3 .. length(trim(ssn2))], ssn1[length(trim(ssn1))-3..length(trim(ssn1))])))),
		100-(10*(MAX(ut.stringsimilar(ssn1,ssn2), ut.stringsimilar(ssn2,ssn1)))))
	,255);