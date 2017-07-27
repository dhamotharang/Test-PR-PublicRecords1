import autokey;

export fn_calc_person_filter_id(string did = '', string bdid = '',
																string ssn = '', string tax_id = '', 
																string cname = '', string lname = '',
																string fname = '') 
																:= function
	person_filter_id := (string) (hash32(did, bdid, ssn, tax_id, cname, lname, fname));
	return person_filter_id;																										
end;