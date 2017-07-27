EXPORT layout_best_phones := RECORD
  // v--- copied from doxie_crs.verifiedPhones.RecordLayout, 
	//      but csa.listed_phone replaced with actual field definition
  //csa.listed_phone;
  string10  listed_phone;
  string4	  timezone;
  unsigned2 fdn_phone_ind := 0; //Added for the FDN Project
END;