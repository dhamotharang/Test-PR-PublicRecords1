export Layout_Relat_Prop := RECORD
	STRING1 AD;
	boolean isrelat;
	Layout_Boca_Shell_ids.seq;
	Layout_Boca_Shell_ids.did;
	STRING1   property_status_applicant;			// Clealy owned='O', clearly sold='S', ambiguous='A', None=' '
	STRING1   property_status_family;					// same as for applicant
	UNSIGNED2 property_count;
	UNSIGNED2 property_total;
	UNSIGNED5 property_owned_purchase_total;
	UNSIGNED2 property_owned_purchase_count;
	UNSIGNED5 property_owned_assessed_total;
	UNSIGNED2 property_owned_assessed_count;
	Risk_Indicators.Layout_Address_Information;
	boolean census_loose;
	STRING1 dataSrce;
END;
