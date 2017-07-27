/*2016-06-03T21:35:16Z (Alexander  Lizano)
New transforms created for logging population
*/
IMPORT Healthcare_Shared, iesp;

EXPORT Transforms_Logging := MODULE

	EXPORT Healthcare_Shared.layouts_logging.transactionlog Affiliations(iesp.healthcare_provideraffiliation.t_AffiliationSearchRequest L) := TRANSFORM
		
		SELF.transaction_id	:= L.AccountContext.Common.TransactionID;
 // SELF.product_id	:=	R.product_id;
 // SELF.sub_product_id	:=	R.sub_product_id;		
    SELF.date_added	:=	L.AccountContext.Products.ProviderPointConfig.DateAdded; 
		SELF.login_id := L.AccountContext.Products.ProviderPointConfig.ConfigWebUserId;		
		SELF.billing_code	:= L.User.BillingCode;
 /* SELF.function_name	:=	0;
		SELF.report_code	:=	0; */
		SELF.gc_id	:= (integer) L.User.CompanyId;
 // SELF.billing_id	 := L.User.BillingId;
    SELF.customer_reference_code := L.User.ReferenceCode; 		
		SELF.i_unique_id := L.SearchBy.EntityID;
		/*
		SELF.i_tax_id	:=	'';
		SELF.i_fein	:=	'';
		SELF.i_npi	:=	'';
		SELF.i_clia	:=	'';
		SELF.i_upin	:=	''; 
		*/		
		SELF.i_provider_id	:=	IF(L.SearchBy.EntityIDType = 'LNPID', L.SearchBy.EntityID, '');
		SELF.i_facility_id	:=	IF(L.SearchBy.EntityIDType = 'LNFID', L.SearchBy.EntityID, '');
		/*
		SELF.i_person_name_prefix	:=	'';
		SELF.i_person_last_name	:=	'';
		SELF.i_person_first_name	:=	'';
		SELF.i_person_middle_name	:=	'';
		SELF.i_person_name_suffix	:=	'';
		SELF.i_person_dob	:=	'';
		SELF.i_person_ssn	:=	'';
		SELF.i_person_phone	:=	'';
		SELF.i_person_addr	:=	'';
		SELF.i_person_city	:=	'';
		SELF.i_person_state	:=	'';
		SELF.i_person_zip	:=	'';
		SELF.i_person_country	:=	'';
		SELF.i_bus_name	:=	'';
		SELF.i_bus_phone	:=	'';
		SELF.i_bus_addr	:=	'';
		SELF.i_bus_city	:=	'';
		SELF.i_bus_state	:=	'';
		SELF.i_bus_zip	:=	'';
		SELF.i_bus_country	:=	''; */
		SELF.user_agent	:= L.Options.UserAgent;
 /* SELF.error_code	:=	'';
		SELF.error_detail	:=	'';
		SELF.dataprep_error_code	:=	'';
		SELF.match_flag	:=	'';
		SELF.subject_to_sla	:=	'';
		SELF.price	:=	'';
		SELF.currency	:=	'';
		SELF.pricing_error_code	:=	'';
		SELF.free	:=	''; */		
		// SELF.record_count	:= R.record_count;		
		SELF.report_options	:=	'';
 /* SELF.transaction_code	:=	'';
		SELF.order_status_code	:=	'';
		SELF.result_code	:=	''; */
		SELF.login_history_id	:=	(integer) L.User.LoginHistoryId;
 // SELF.ip_address	:= '';
 //	SELF.response_time	:=	'';
 // SELF.esp_method	:=	''; 
				
		SELF := [];
		
	END; // TRANSFORM	

	EXPORT Healthcare_Shared.layouts_logging.transactionlog MDMFacilitiesSummary(iesp.healthcare_admorgsearchandreport.t_ADMOrganizationSearchRequest L) := TRANSFORM
		 
		SELF.transaction_id	:= L.AccountContext.Common.TransactionID;
 // SELF.product_id	:=	R.product_id;
 // SELF.sub_product_id	:=	R.sub_product_id;
		SELF.date_added	:=	L.AccountContext.Products.ProviderPointConfig.DateAdded; 
		SELF.login_id := L.AccountContext.Products.ProviderPointConfig.ConfigWebUserId;;		
		SELF.billing_code	:= L.User.BillingCode;
 /* SELF.function_name	:=	0;
		SELF.report_code	:=	0; */
		SELF.gc_id	:= (integer) If(L.User.CompanyId <> '', L.User.CompanyId, L.AccountContext.Common.GlobalCompanyId);
 // SELF.billing_id	 := L.User.BillingId;
    SELF.customer_reference_code := L.User.ReferenceCode; 				
		SELF.i_unique_id	:=	L.SearchBy.LNFID;
		
 // SELF.i_tax_id:= L.SearchBy.t_HCFacilityIdentifiers.;
		// SELF.i_fein	:=	L.SearchBy.Identifiers.FEIN;
		// SELF.i_npi	:=	L.SearchBy.Identifiers.NPI;
		// SELF.i_clia	:=	L.SearchBy.Identifiers.CLIA;
 // SELF.i_upin	:=	L.SearchBy.t_HCFacilityIdentifiers.UPIN; 
				
		SELF.i_provider_id	:=	'';
		SELF.i_facility_id	:=	L.SearchBy.LNFID;;
		/*
		SELF.i_person_name_prefix	:=	'';
		SELF.i_person_last_name	:=	'';
		SELF.i_person_first_name	:=	'';
		SELF.i_person_middle_name	:=	'';
		SELF.i_person_name_suffix	:=	'';
		SELF.i_person_dob	:=	'';
		SELF.i_person_ssn	:=	'';
		SELF.i_person_phone	:=	'';
		SELF.i_person_addr	:=	'';
		SELF.i_person_city	:=	'';
		SELF.i_person_state	:=	'';
		SELF.i_person_zip	:=	'';
		SELF.i_person_country	:=	'';
		*/
		SELF.i_bus_name	:= L.SearchBy.OrganizationName;		
		// SELF.i_bus_phone:= L.ReportBy.phone;		
		SELF.i_bus_addr	:= L.SearchBy.Address.StreetAddress1; // + ' ' + L.SearchBy.Address.StreetAddress2;
		SELF.i_bus_city	:= L.SearchBy.Address.City;
		SELF.i_bus_state:= L.SearchBy.Address.State;
		SELF.i_bus_zip	:= L.SearchBy.Address.Zip5 + If(L.SearchBy.Address.Zip4='','','-') + L.SearchBy.Address.Zip4;
		SELF.i_bus_country	:=	'';
		SELF.user_agent	:=	L.Options.UserAgent;
 /* SELF.error_code	:=	'';
		SELF.error_detail	:=	'';
		SELF.dataprep_error_code	:=	'';
		SELF.match_flag	:=	'';
		SELF.subject_to_sla	:=	'';
		SELF.price	:=	'';
		SELF.currency	:=	'';
		SELF.pricing_error_code	:=	'';
		SELF.free	:=	''; */		
 // SELF.record_count	:= R.record_count;		
		SELF.report_options	:=	'';
 /*	SELF.transaction_code	:=	'';
		SELF.order_status_code	:=	'';
		SELF.result_code	:=	''; */
		SELF.login_history_id	:= (integer) L.User.LoginHistoryId;
		SELF.ip_address	:=	L.User.IP;
 // SELF.response_time := '';
 // SELF.esp_method	:=	''; 
				
		SELF := [];
		
	END; // TRANSFORM
	EXPORT Healthcare_Shared.layouts_logging.transactionlog MDMFacilitiesProfile(iesp.healthcare_admorgsearchandreport.t_ADMOrganizationReportRequest L) := TRANSFORM
		 
		SELF.transaction_id	:= L.AccountContext.Common.TransactionID;
 // SELF.product_id	:=	R.product_id;
 // SELF.sub_product_id	:=	R.sub_product_id;
		SELF.date_added	:=	L.AccountContext.Products.ProviderPointConfig.DateAdded; 
		SELF.login_id := L.AccountContext.Products.ProviderPointConfig.ConfigWebUserId;;		
		SELF.billing_code	:= L.User.BillingCode;
 /* SELF.function_name	:=	0;
		SELF.report_code	:=	0; */
		SELF.gc_id	:= (integer) If(L.User.CompanyId <> '', L.User.CompanyId, L.AccountContext.Common.GlobalCompanyId);
 // SELF.billing_id	 := L.User.BillingId;
    SELF.customer_reference_code := L.User.ReferenceCode; 				
		SELF.i_unique_id	:=	L.ReportBy.LNFID;
		
 // SELF.i_tax_id:= L.SearchBy.t_HCFacilityIdentifiers.;
		// SELF.i_fein	:=	L.ReportBy.Identifiers.FEIN;
		// SELF.i_npi	:=	L.ReportBy.Identifiers.NPI;
		// SELF.i_clia	:=	L.ReportBy.Identifiers.CLIA;
 // SELF.i_upin	:=	L.ReportBy.t_HCFacilityIdentifiers.UPIN; 
				
		SELF.i_provider_id	:=	'';
		SELF.i_facility_id	:=	L.ReportBy.LNFID;;
		/*
		SELF.i_person_name_prefix	:=	'';
		SELF.i_person_last_name	:=	'';
		SELF.i_person_first_name	:=	'';
		SELF.i_person_middle_name	:=	'';
		SELF.i_person_name_suffix	:=	'';
		SELF.i_person_dob	:=	'';
		SELF.i_person_ssn	:=	'';
		SELF.i_person_phone	:=	'';
		SELF.i_person_addr	:=	'';
		SELF.i_person_city	:=	'';
		SELF.i_person_state	:=	'';
		SELF.i_person_zip	:=	'';
		SELF.i_person_country	:=	'';
		*/
		SELF.i_bus_name	:= L.ReportBy.OrganizationName;		
		// SELF.i_bus_phone:= L.ReportBy.phone;		
		SELF.i_bus_addr	:= L.ReportBy.Address.StreetAddress1; // + ' ' + L.SearchBy.Address.StreetAddress2;
		SELF.i_bus_city	:= L.ReportBy.Address.City;
		SELF.i_bus_state:= L.ReportBy.Address.State;
		SELF.i_bus_zip	:= L.ReportBy.Address.Zip5 + If(L.ReportBy.Address.Zip4='','','-') + L.ReportBy.Address.Zip4;
		SELF.i_bus_country	:=	'';
		SELF.user_agent	:=	L.Options.UserAgent;
 /* SELF.error_code	:=	'';
		SELF.error_detail	:=	'';
		SELF.dataprep_error_code	:=	'';
		SELF.match_flag	:=	'';
		SELF.subject_to_sla	:=	'';
		SELF.price	:=	'';
		SELF.currency	:=	'';
		SELF.pricing_error_code	:=	'';
		SELF.free	:=	''; */		
 // SELF.record_count	:= R.record_count;		
		SELF.report_options	:=	'';
 /*	SELF.transaction_code	:=	'';
		SELF.order_status_code	:=	'';
		SELF.result_code	:=	''; */
		SELF.login_history_id	:= (integer) L.User.LoginHistoryId;
		SELF.ip_address	:=	L.User.IP;
 // SELF.response_time := '';
 // SELF.esp_method	:=	''; 
				
		SELF := [];
		
	END; // TRANSFORM
	EXPORT Healthcare_Shared.layouts_logging.transactionlog FacilitiesProfile(iesp.healthcare_orgsearchandreport.t_OrganizationReportRequest L) := TRANSFORM
		 
		SELF.transaction_id	:= L.AccountContext.Common.TransactionID;
 // SELF.product_id	:=	R.product_id;
 // SELF.sub_product_id	:=	R.sub_product_id;
		SELF.date_added	:=	L.AccountContext.Products.ProviderPointConfig.DateAdded; 
		SELF.login_id := L.AccountContext.Products.ProviderPointConfig.ConfigWebUserId;;		
		SELF.billing_code	:= L.User.BillingCode;
 /* SELF.function_name	:=	0;
		SELF.report_code	:=	0; */
		SELF.gc_id	:= (integer) L.User.CompanyId;
 // SELF.billing_id	 := L.User.BillingId;
    SELF.customer_reference_code := L.User.ReferenceCode; 				
		SELF.i_unique_id	:=	L.ReportBy.LNFID;
		
 // SELF.i_tax_id:= L.SearchBy.t_HCFacilityIdentifiers.;
		// SELF.i_fein	:=	L.SearchBy.Identifiers.FEIN;
		// SELF.i_npi	:=	L.SearchBy.Identifiers.NPI;
		// SELF.i_clia	:=	L.SearchBy.Identifiers.CLIA;
 // SELF.i_upin	:=	L.SearchBy.t_HCFacilityIdentifiers.UPIN; 
				
		SELF.i_provider_id	:=	'';
		SELF.i_facility_id	:=	L.ReportBy.LNFID;;
		/*
		SELF.i_person_name_prefix	:=	'';
		SELF.i_person_last_name	:=	'';
		SELF.i_person_first_name	:=	'';
		SELF.i_person_middle_name	:=	'';
		SELF.i_person_name_suffix	:=	'';
		SELF.i_person_dob	:=	'';
		SELF.i_person_ssn	:=	'';
		SELF.i_person_phone	:=	'';
		SELF.i_person_addr	:=	'';
		SELF.i_person_city	:=	'';
		SELF.i_person_state	:=	'';
		SELF.i_person_zip	:=	'';
		SELF.i_person_country	:=	'';
		*/
		SELF.i_bus_name	:= L.ReportBy.OrganizationName;		
		// SELF.i_bus_phone:= L.SearchBy.phone;		
		SELF.i_bus_addr	:= L.ReportBy.Address.StreetAddress1; // + ' ' + L.SearchBy.Address.StreetAddress2;
		SELF.i_bus_city	:= L.ReportBy.Address.City;
		SELF.i_bus_state:= L.ReportBy.Address.State;
		SELF.i_bus_zip	:= L.ReportBy.Address.Zip5 + If(L.ReportBy.Address.Zip4='','','-') + L.ReportBy.Address.Zip4;
		SELF.i_bus_country	:=	'';
		SELF.user_agent	:=	L.Options.UserAgent;
 /* SELF.error_code	:=	'';
		SELF.error_detail	:=	'';
		SELF.dataprep_error_code	:=	'';
		SELF.match_flag	:=	'';
		SELF.subject_to_sla	:=	'';
		SELF.price	:=	'';
		SELF.currency	:=	'';
		SELF.pricing_error_code	:=	'';
		SELF.free	:=	''; */		
 // SELF.record_count	:= R.record_count;		
		SELF.report_options	:=	'';
 /*	SELF.transaction_code	:=	'';
		SELF.order_status_code	:=	'';
		SELF.result_code	:=	''; */
		SELF.login_history_id	:= (integer) L.User.LoginHistoryId;
		SELF.ip_address	:=	L.User.IP;
 // SELF.response_time := '';
 // SELF.esp_method	:=	''; 
				
		SELF := [];
		
	END; // TRANSFORM
	
	EXPORT Healthcare_Shared.layouts_logging.transactionlog FacilitiesSummary(iesp.healthcare_orgsearchandreport.t_OrganizationSearchRequest L) := TRANSFORM
		 
		SELF.transaction_id	:= L.AccountContext.Common.TransactionID;
 // SELF.product_id	:=	R.product_id;
 // SELF.sub_product_id	:=	R.sub_product_id;
		SELF.date_added	:=	L.AccountContext.Products.ProviderPointConfig.DateAdded; 
		SELF.login_id := L.AccountContext.Products.ProviderPointConfig.ConfigWebUserId;
		SELF.billing_code	:= L.User.BillingCode;
 /* SELF.function_name	:=	0;
		SELF.report_code	:=	0; */
		SELF.gc_id	:= (integer) L.User.CompanyId;
 // SELF.billing_id	 := L.User.BillingId;
    SELF.customer_reference_code := L.User.ReferenceCode; 			
		SELF.i_unique_id	:=	L.SearchBy.LNFID;
		
 // SELF.i_tax_id:= L.SearchBy.t_HCFacilityIdentifiers.;
		// SELF.i_fein	:=	L.SearchBy.Identifiers.FEIN;
		// SELF.i_npi	:=	L.SearchBy.Identifiers.NPI;
		// SELF.i_clia	:=	L.SearchBy.Identifiers.CLIA;
 // SELF.i_upin	:=	L.SearchBy.t_HCFacilityIdentifiers.UPIN; 
				
		SELF.i_provider_id	:=	'';
		SELF.i_facility_id	:=	L.SearchBy.LNFID;;
		/*
		SELF.i_person_name_prefix	:=	'';
		SELF.i_person_last_name	:=	'';
		SELF.i_person_first_name	:=	'';
		SELF.i_person_middle_name	:=	'';
		SELF.i_person_name_suffix	:=	'';
		SELF.i_person_dob	:=	'';
		SELF.i_person_ssn	:=	'';
		SELF.i_person_phone	:=	'';
		SELF.i_person_addr	:=	'';
		SELF.i_person_city	:=	'';
		SELF.i_person_state	:=	'';
		SELF.i_person_zip	:=	'';
		SELF.i_person_country	:=	'';
		*/
		SELF.i_bus_name	:= L.SearchBy.OrganizationName;		
		// SELF.i_bus_phone:= L.SearchBy.phone;		
		SELF.i_bus_addr	:= L.SearchBy.Address.StreetAddress1; // + ' ' + L.SearchBy.Address.StreetAddress2;
		SELF.i_bus_city	:= L.SearchBy.Address.City;
		SELF.i_bus_state:= L.SearchBy.Address.State;
		SELF.i_bus_zip	:= L.SearchBy.Address.Zip5 + If(L.SearchBy.Address.Zip4='','','-') + L.SearchBy.Address.Zip4;
		SELF.i_bus_country	:=	'';		
		SELF.user_agent	:=	L.Options.UserAgent;
 /* SELF.error_code	:=	'';
		SELF.error_detail	:=	'';
		SELF.dataprep_error_code	:=	'';
		SELF.match_flag	:=	'';
		SELF.subject_to_sla	:=	'';
		SELF.price	:=	'';
		SELF.currency	:=	'';
		SELF.pricing_error_code	:=	'';
		SELF.free	:=	''; 
		*/		
 // SELF.record_count	:= R.record_count;		
		SELF.report_options	:= '';
 /* SELF.transaction_code	:=	'';
		SELF.order_status_code	:=	'';
		SELF.result_code	:=	''; */
		SELF.login_history_id	:= (integer) L.User.LoginHistoryId;
    SELF.ip_address	:=	L.User.IP;
 // SELF.response_time	:=	'';
 // SELF.esp_method	:=	''; 
 
		SELF := [];
		
	END; // TRANSFORM

END; // MODULE