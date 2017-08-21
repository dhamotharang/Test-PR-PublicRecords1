import property,lib_keylib,lib_fileservices,ut,Business_Header,Header, prte2_faa,mdr, faa;

export as_header_aircraft := module
	
//this then gets read into a separate process (our Header process) for the creation and managing of our LexID's
export person_header_aircraft_recs := faa.aircraft_as_header(Files.header_aircraft(did_out<>'' and did_out <> '0'),,true);


//YOU ONLY NEED THIS WHEN YOUR FILE HAS BUSINESSES - THIS SENDS DATA INTO THE LEGACY BUSINESS HEADER
export old_business_header_aircraft_recs := faa.fFAA_aircraft_reg_as_business_header(Files.header_aircraft_plus(bdid_out<>''), true);


//YOU ONLY NEED THIS WHEN YOUR FILE HAS A PERSON ASSOCIATED TO A BUSINESS - THIS SENDS DATA INTO THE LEGACY BUSINESS CONTACTS
export old_business_contacts_aircraft_recs := faa.fFAA_aircraft_reg_as_business_contact(Files.header_aircraft_plus(compname<>'' and bdid_out<>'' and fname<>'' and lname<>'')); 

//YOU ONLY NEED THIS WHEN YOUR FILE HAS BUSINESSES - THIS SENDS DATA INTO THE NEW BUSINESS HEADER
//IN THE NEW HEADER BUSINESSES AND CONTACTS ARE IN THE SAME FILE SO IN THIS MAPPING YOU INCLUDE BOTH OF THEM
export new_business_header_aircraft_recs := faa.fFAA_aircraft_reg_as_business_linking(Files.header_aircraft_plus(compname<>'' and bdid_out<>'')); 

end;

 


