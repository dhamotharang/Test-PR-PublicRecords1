import Risk_Indicators,FFD;
export Layout_Phones_Old := RECORD
    unsigned6    did;
    qstring10    phone;
		string4      timezone;
    unsigned3    dt_first_seen;
    unsigned3    dt_last_seen;
    qstring5     zip;
    qstring4     zip4;
		string25    city_name;
		string2     st;
		string1 		listing_type_res := '';	
		string1 		listing_type_bus := '';
		string1 		listing_type_gov := '';
    unsigned2   fdn_did_ind   := 0; // Added for the FDN project.
    unsigned2   fdn_phone_ind := 0; // Added for the FDN project.
		DATASET(Risk_Indicators.Layout_Desc) hri_Phone;
		FFD.Layouts.CommonRawRecordElements;
END;

