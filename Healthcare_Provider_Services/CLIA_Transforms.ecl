import iesp, clia;
EXPORT CLIA_Transforms := MODULE

	export iesp.cliasearch.t_CLIARecord esdlRecords(Healthcare_Provider_Services.CLIA_Layouts.batch_out recs):= TRANSFORM
		self.BusinessId := (string)recs.bdid;
		self.TerminationCode := recs.term_code;
		self.TerminationCodeDesc := recs.term_code_desc;
		self.CLIANumber := recs.clia_number;
		self.LaboratoryType := recs.lab_type;
		self.CompanyName := recs.facility_name;
		self.CompanyName2 := recs.facility_name2;
		// addr := recs.clean_company_address;
		self.CLIAProviderAddress := iesp.ECL2ESP.SetAddress(
																recs.clean_company_address_prim_name, recs.clean_company_address_prim_range, recs.clean_company_address_predir, recs.clean_company_address_postdir, recs.clean_company_address_addr_suffix,
																recs.clean_company_address_unit_desig, recs.clean_company_address_sec_range, recs.city, recs.State, recs.zip, recs.zip4,
																'','', recs.address1, recs.address2, '');
		// self.CLIAProviderAddress.Location.Latitude := addr.geo_lat;
		// self.CLIAProviderAddress.Location.Longitude := addr.geo_long;
		self.Phone10 := recs.facility_phone;
		self.RecordType := recs.record_type;
		self.DateFirstSeen := iesp.ECL2ESP.toDatestring8((string)recs.dt_vendor_first_reported);
		self.DateLastSeen := iesp.ECL2ESP.toDatestring8((string)recs.dt_vendor_last_reported);
		self.ExpirationDate := iesp.ECL2ESP.toDatestring8((string)recs.expiration_date);
		self.CertificateType := recs.certificate_type;
		self := recs;
		self := [];
	end;
	
	export Healthcare_Provider_Services.Layouts.layout_clia acctPlusESDLRecords(Healthcare_Provider_Services.Layouts.layout_slim_clia input,recordof(clia.keys().CLIA_Number.qa) recs):= TRANSFORM
		self.acctno := input.acctno;
		self.providerid := input.providerid;
		self.BusinessId := (string)recs.bdid;
		self.CLIANumber := recs.clia_number;
		self.LaboratoryType := recs.lab_type;
		self.CompanyName := recs.facility_name;
		self.CompanyName2 := recs.facility_name2;
		addr := recs.clean_company_address;
		self.CLIAProviderAddress := iesp.ECL2ESP.SetAddress(
																addr.prim_name, addr.prim_range, addr.predir, addr.postdir, addr.addr_suffix,
																addr.unit_desig, addr.sec_range, recs.city, recs.State, recs.zip, recs.zip4,
																'','', recs.address1, recs.address2, '');
		// self.CLIAProviderAddress.Location.Latitude := addr.geo_lat;
		// self.CLIAProviderAddress.Location.Longitude := addr.geo_long;
		self.Phone10 := recs.facility_phone;
		self.RecordType := recs.record_type;
		self.DateFirstSeen := iesp.ECL2ESP.toDatestring8((string)recs.dt_vendor_first_reported);
		self.DateLastSeen := iesp.ECL2ESP.toDatestring8((string)recs.dt_vendor_last_reported);
		self.ExpirationDate := iesp.ECL2ESP.toDatestring8((string)recs.expiration_date);
		self.CertificateType := recs.certificate_type;
		self.TerminationCode := recs.lab_term_code;
		self := recs;
		self := [];
	end;
end;