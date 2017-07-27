import business_header, BIPV2;

export Layout_employment := record
	business_header.Layout_Employment_Out;
	string4		company_timezone;
	string4   timezone;
	string25  county_name := '';
	boolean active_phone_flag_name := false;
	boolean verified := false;
	string1 score_name := '';
	BIPV2.IDlayouts.l_header_ids;
end;
