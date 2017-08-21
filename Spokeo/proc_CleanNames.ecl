import std, address, Nid;
EXPORT proc_CleanNames(DATASET(Spokeo.Layout_temp) src) := FUNCTION
	cln := Nid.fn_CleanFullNames(src, Prepped_name, useV2 := true) : PERSIST('~thor::spokeo::persist::cleannames');
	
	cln1 := PROJECT(cln(nametype in ['P','D']), TRANSFORM(Spokeo.Layout_temp,
						self.fname				:=	left.cln_fname;
						self.mname				:=	left.cln_mname;
						self.lname				:=	left.cln_lname;
						self.name_suffix	:=	left.cln_suffix;

						self := left;));
						
	//cln2 := proc_CleanNames_small(PROJECT(cln(nametype not in ['P','D']), Spokeo.Layout_temp));
	cln2 := PROJECT(cln(nametype not in ['P','D']), Spokeo.Layout_temp);
	return cln1 + cln2;
	
END;