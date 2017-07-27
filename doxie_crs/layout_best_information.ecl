import doxie, ffd;
export layout_best_information := record(Doxie.layout_best/* - [phone]*/)
	dataset(//doxie_crs.verifiedPhones().RecordLayout
	        doxie_crs.layout_best_phones // removed (---^) & added (<---) during FDN project
	                                    ) phones {maxcount(doxie_crs.verifiedPhones().MaxRecords)};
	string1 Deceased;

  // Added for the FDN project.
	unsigned2 fdn_did_ind   := 0;
	unsigned2 fdn_addr_ind  := 0;
	unsigned2 fdn_ssn_ind   := 0;
	unsigned2 fdn_phone_ind := 0; 
	boolean   fdn_waf_contrib_data := false; 
	// added for FFD project.
	FFD.Layouts.CommonRawRecordElements;
end;