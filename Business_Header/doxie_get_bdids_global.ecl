Business_Header.doxie_MAC_Field_Declare(true)

export doxie_get_bdids_global(boolean forceLocal = true) := 
	if(not(company_name_value = '' AND fein_val = '' AND phone_value = '' and bdid_value = 0), 
		 business_header.doxie_get_bdids_plus(forceLocal)) : global;