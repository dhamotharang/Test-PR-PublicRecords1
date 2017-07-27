import doxie_crs, business_header;
doxie_cbrs.mac_Selection_Declare()
	
//inputs
stateIDs := doxie_cbrs.Corp_records_raw(Include_CompanyIDnumbers_val);
FEINS := doxie_cbrs.getBaseRecs(fein <> '' and Include_CompanyIDnumbers_val);
duns := doxie_cbrs.DNB_records(Include_CompanyIDnumbers_val);

export ID_Number_records_count := count(stateIDs) + count(FEINS) + count(duns);
