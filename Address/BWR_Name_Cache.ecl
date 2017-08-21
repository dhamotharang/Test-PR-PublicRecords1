
#workunit('name', 'Name Cleaner : Create Name Cache')

import IDL_Header, Address;

fnames := DISTRIBUTE(DEDUP(SORT(CHOOSEN(SORT(
			IDL_Header.Name_Count_DS(regexfind('^[A-Z]+$', TRIM(name)) = true),	// AND LENGTH(TRIM(name))>1),
			-fname_cnt),7000), 
			name), name), HASH64(name));

						
// find the most common last names from the insurance header
lnames := DISTRIBUTE(DEDUP(SORT(
			IDL_Header.Name_Count_DS(regexfind('^[A-Z][A-Z\']+$', TRIM(name)) = true AND lname_cnt > 900),
			name), name), HASH64(name));
			
output(fnames,, Address.Persons.filename_fnames, COMPRESSED, OVERWRITE);
output(lnames,, Address.Persons.filename_lnames, COMPRESSED, OVERWRITE);