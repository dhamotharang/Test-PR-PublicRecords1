import doxie;

export fn_ScoreSearchView(DATASET(ebr_services.Layout_EBR_Search) ds) :=
FUNCTION

ebr_services.Layout_EBR_Search scorer(ebr_services.Layout_EBR_Search le) :=
TRANSFORM
	SELF.penalt := doxie.FN_Tra_Penalty_Addr(le.predir,le.prim_range,le.prim_name,le.addr_suffix,
																					 le.postdir,le.sec_range,le.city,le.st,
																					 le.zip) 
								 + doxie.FN_Tra_Penalty_CName(le.COMPANY_NAME)
								 + doxie.Fn_Tra_Penalty_Phone(le.PHONE_NUMBER)
								 + doxie.FN_Tra_Penalty_BDID((string)le.BDID);
	SELF := le;
END;
p := PROJECT(ds, scorer(LEFT));
RETURN p;


END;