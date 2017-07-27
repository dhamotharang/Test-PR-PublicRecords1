import business_header;

export FBNReport := FUNCTION

	business_header.doxie_MAC_Field_Declare()
	
	boolean is_search := FALSE: stored('isSearch');
	
	ids := FBNReportService_ids(is_search);
	
	prepr := FBNV2_services.FBN_raw.report_view .by_rmsid(ids,is_search);

	r :=prepr(rmsid = rmsid_value or rmsid_value='',
						tmsid = tmsid_value or tmsid_value='',
						(string) bdid=bdid_val or bdid_val='');

	RETURN r;

END;	