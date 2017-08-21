// Female  Bonnie Sue 
// unknown last name-possibly Prussia as a 17 y.o.
// has since married and taken new name at a tender age
// born in 1959 or 1960.  
// Resided in Erie County PA in 1977. 
// Unknown current whereabouts.  
// Witness to a murder in 1977…new info surfaced on case and they have stepped up search for her.
//
import ut,doxie;
import doxie_files,doxie_build,lib_stringlib;
import did_add,  didville;
import address;
import header;

file_headers := header.File_Headers;
res := file_headers(
			(fname='BONNIE SUE' or fname='BONNIESUE' or ((fname='BONNIE' or fname='BONNY') and mname='SUE'))
				and
			(trim((string8) dob,left,right)[1..4] in ['1959','1960'])
			    and
			st='PA');

export _bspa := res : persist('thor::persist::rvh::bonnie_sue_pa');
