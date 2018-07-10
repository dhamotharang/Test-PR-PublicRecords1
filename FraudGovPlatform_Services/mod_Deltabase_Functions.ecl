IMPORT Address, FraudGovPlatform_Services, FraudShared, FraudShared_Services, Gateway, iesp, lib_thorlib, mysql, STD, ut;

EXPORT mod_Deltabase_Functions := MODULE

		SHARED GetRecentTimelineDetails(DATASET(FraudGovPlatform_Services.Layouts.LOG_Deltabase_Layout_Record) ds_delta_records) := FUNCTION

		iesp.fraudgovreport.t_FraudGovTimelineDetails xForm_getTimeLineDetails(
										FraudGovPlatform_Services.Layouts.LOG_Deltabase_Layout_Record L) := TRANSFORM
										
			date_added := (INTEGER)(L.date_added[1..8]);
			SELF.IsRecentActivity := TRUE;
			SELF.FileType := 3;
			SELF.GlobalCompanyId := (INTEGER)L.gc_id;
			SELF.TransactionId := (STRING)L.cust_transaction_id;
			SELF.HouseHoldId := L.case_id;
			SELF.CustomerPersonId := L.client_uid;
			SELF.EventDate.Year := STD.Date.Year(date_added);
			SELF.EventDate.Month := STD.Date.Month(date_added);
			SELF.EventDate.Day := STD.Date.Day(date_added);
			SELF.IndustryTypeDescription := L.program_name;
			SELF.ReportedBy := L.inquiry_source;
			SELF.ActivityReason := L.inquiry_reason;
			SELF.UniqueId := (STRING)L.lex_id;
			SELF.Name.Full := L.name_full;
			SELF.Name.First := L.name_first;
			SELF.Name.Middle := L.name_middle;
			SELF.Name.Last := L.name_last;
			SELF.Name.Suffix := L.name_suffix;
			SELF.Name.Prefix := L.name_prefix;
			SELF.SSN := L.ssn;
			SELF.DOB.Year := IF(L.dob <> '', STD.Date.Year((INTEGER)L.dob), 0);
			SELF.DOB.Month := IF(L.dob <> '', STD.Date.Month((INTEGER)L.dob), 0);
			SELF.DOB.Day := IF(L.dob <> '', STD.Date.Day((INTEGER)L.dob), 0);
			SELF.PhysicalAddress.StreetAddress1 := L.physical_address;		
			SELF.PhysicalAddress.City := L.physical_city;
			SELF.PhysicalAddress.State := L.physical_state;
			SELF.PhysicalAddress.Zip5 := L.physical_zip;
			SELF.PhysicalAddress.County := L.physical_county;
			SELF.MailingAddress.StreetAddress1 := L.mailing_address;
			SELF.MailingAddress.City := L.mailing_city;
			SELF.MailingAddress.State := L.mailing_state;
			SELF.MailingAddress.Zip5 := L.mailing_zip;
			SELF.MailingAddress.County := L.mailing_county;
			SELF.Phones := IF(L.phone <> '',
												ROW({FraudGovPlatform_Services.Constants.PHONE_TYPE.PHONE_TYPE_HOME, L.phone,''}, iesp.fraudgovreport.t_FraudGovPhoneInfo),
												ROW([], iesp.fraudgovreport.t_FraudGovPhoneInfo)
												);
			SELF.EmailAddress := L.email_address;
			SELF.DriversLicense.DriversLicenseNumber := L.dl_number;
			SELF.DriversLicense.DriversLicenseState := L.dl_state;
			SELF.BankInformation1.BankAccountNumber := L.bank_account_number;
			SELF.BankInformation1.BankRoutingNumber := L.bank_routing_number;
			SELF.IpAddress := L.ip_address;
			SELF.DeviceId := L.device_id;
			SELF.GeoLocation.Latitude := L.geo_lat;
			SELF.GeoLocation.Longitude := L.geo_long;
			SELF := [];
		END;

		ds_timeline_recent_activity := PROJECT(ds_delta_records,xForm_getTimeLineDetails(LEFT));

		return ds_timeline_recent_activity;
	END;
	
	SHARED DeltabaseMBSFilter(DATASET(FraudGovPlatform_Services.Layouts.LOG_Deltabase_Layout_Record) deltabase_recs, 
													FraudGovPlatform_Services.IParam.BatchParams batch_params) := FUNCTION
			
			Layout_Deltabase_w_product_code := RECORD
				INTEGER product_code;
				INTEGER ind_type_id;
				FraudGovPlatform_Services.Layouts.LOG_Deltabase_Layout_Record deltadata;
			END;			
			
			Layout_Deltabase_w_product_code xForm_AddProductCode(FraudGovPlatform_Services.Layouts.LOG_Deltabase_Layout_Record L) := TRANSFORM
				SELF.product_code := batch_params.ProductCode;
				SELF.ind_type_id := batch_params.IndustryType;
				SELF.deltadata := L;
			END;
			
			delta_w_filter := PROJECT(deltabase_recs, xForm_AddProductCode(LEFT));
			
			
			delta_mbs_filtered := JOIN(delta_w_filter, FraudShared.Key_MbsDeltaBase(FraudGovPlatform_Services.Constants.FRAUD_PLATFORM),
																KEYED(LEFT.deltadata.gc_id = (STRING)RIGHT.gc_id AND
																			LEFT.ind_type_id = RIGHT.ind_type) AND
																		  RIGHT.product_include = FraudShared_Services.Constants.PRODUCT_INCLUDE_CODE_ALL,
																TRANSFORM(FraudGovPlatform_Services.Layouts.LOG_Deltabase_Layout_Record,
																					SELF := LEFT.deltadata),
																LIMIT(FraudGovPlatform_Services.Constants.Limits.MAX_JOIN_LIMIT, SKIP)
																);
																
			return delta_mbs_filtered;
	END;

	EXPORT getDeltabaseReportRecords(DATASET(FraudShared_Services.Layouts.BatchInExtended_rec) in_recs, 
																	FraudGovPlatform_Services.IParam.BatchParams batch_params) := FUNCTION
	
			first_row := in_recs[1];
			
			db_url := batch_params.gateways(ServiceName=FraudGovPlatform_Services.Constants.DELTABASE_ESP_GATEWAY_NAME)[1].Url;	
			
			//Parsing db_url variable. ESP sends in the complete Deltabase login information in one string
			//String format: 'HTTPS://[username]:[password]@[database_location]:[port_number]'
			//The below regexfind statements parse db_url based on the above format
			db_loginInfo := regexfind('(.*)://(.*)$',db_url,2);

			db_user := regexfind('(.*):(.*)@(.*)$',db_loginInfo,1);
			db_pw := regexfind('(.*):(.*)@(.*)$',db_loginInfo,2);
			db_loc := regexfind('(.*):(.*)@(.*):(.*)$',db_loginInfo,3);
			db_port := regexfind('(.*):(.*)@(.*):(.*)$',db_loginInfo,4);
			
			query_filter := PROJECT(first_row,FraudGovPlatform_Services.Transforms.xform_getDeltabaseQueryParams(LEFT));
			
			// Embedding direct MySQL query code
			// Format: EMBED(mysql: password, username, database_name, server_location, port_number) [MySQL query code] ENDEMBED;
			// Info for lines 144-154 (commenting here because everything in the EMBED structure is interpreted as MySQL code)
			// Parametrized SQL query 
			// each "?" corresponds to a field of the "filter" dataset (in the same field order as in the dataset's layout)
			// that was passed in to this function			
			dataset(FraudGovPlatform_Services.Layouts.LOG_Deltabase_Layout_Record) deltadata(
																	integer gc_id,
																	string ind_type_name,
																	FraudGovPlatform_Services.Layouts.Layout_delta_filter filter
																	) := EMBED(mysql :   password(db_pw), user(db_user), database('delta_fraudgov'),
																						server(db_loc), port(db_port))
									
			SELECT gc_id, CAST(inquiry_log_id AS CHAR(10)) AS cust_transaction_id, date_added as cust_transaction_date, case_id, client_uid, program_name,
				inquiry_reason, inquiry_source, customer_county_code, customer_state, customer_vertical_code, ssn, dob, CAST(lex_id AS UNSIGNED) as lex_id, 
				name_full, name_prefix, name_first, name_middle, name_last, name_suffix,full_address, physical_address,
				physical_city, physical_state, physical_zip, physical_county, mailing_address, mailing_city, mailing_state, mailing_zip,
				mailing_county, phone, ultid, orgid, seleid, tin, email_address, appendedproviderid, lnpid, npi, ip_address, device_id,
				professional_id, bank_routing_number, bank_account_number, dl_state, dl_number, geo_lat, geo_long, date_added 
			FROM delta_identity 
			WHERE gc_id=? AND program_name=? AND
							(
							(length(ssn) > 0 AND ssn=?) OR (length(dob) > 0 AND dob=?) OR (lex_id <> 0 AND lex_id=?) OR
							(length(name_first) > 0 AND name_first=?) OR (length(name_middle) > 0 AND name_middle=?) OR 
							(length(name_last) > 0 AND name_last=?) OR 
							(length(physical_address) > 0 AND physical_address=? AND length(physical_city) > 0 AND physical_city=? AND length(physical_state) > 0 AND physical_state=? AND
									length(physical_zip) > 0 AND physical_zip=?) OR
							(length(mailing_address) > 0 AND mailing_address=? AND length(mailing_city) > 0 AND mailing_city=? AND length(mailing_state) > 0 AND mailing_state=? AND
									length(mailing_zip) > 0 AND mailing_zip=?) OR
							(length(phone) > 0 AND phone=?) OR (length(ip_address) > 0 AND ip_address=?) OR (length(device_id) > 0 AND device_id=?) OR
							(length(bank_account_number) > 0 AND bank_account_number=?) OR (length(dl_state) > 0 AND dl_state=? AND length(dl_number) >0 AND dl_number=?) OR
							(length(geo_lat) > 0 AND geo_lat=? AND length(geo_long) > 0 AND geo_long=?)
							) AND date_added >= ?
			ENDEMBED;
			
			db_records := deltadata(batch_params.GlobalCompanyId,batch_params.IndustryTypeName,query_filter);
			
			db_records_filtered := DeltabaseMBSFilter(db_records, batch_params);

			ds_timeline_records := GetRecentTimelineDetails(db_records_filtered);
			
			// OUTPUT(db_records,NAMED('Delta_Recs'));
			// OUTPUT(db_records_filtered,NAMED('Delta_Filtered_MBS'));
			// OUTPUT(ds_timeline_records,NAMED('Delta_Timeline'));

			return ds_timeline_records;
	END;
	
	EXPORT getDeltabaseSearchRecords(FraudGovPlatform_Services.IParam.BatchParams batch_params) := FUNCTION
			
			db_url := batch_params.gateways(ServiceName=FraudGovPlatform_Services.Constants.DELTABASE_ESP_GATEWAY_NAME)[1].Url;
			
			//Parsing db_url variable. ESP sends in the complete Deltabase login information in one string
			//String format: 'HTTPS://[username]:[password]@[database_location]:[port_number]'
			//The below regexfind statements parse db_url based on the above format			
			db_loginInfo := regexfind('(.*)://(.*)$',db_url,2);

			db_user := regexfind('(.*):(.*)@(.*)$',db_loginInfo,1);
			db_pw := regexfind('(.*):(.*)@(.*)$',db_loginInfo,2);
			db_loc := regexfind('(.*):(.*)@(.*):(.*)$',db_loginInfo,3);
			db_port := regexfind('(.*):(.*)@(.*):(.*)$',db_loginInfo,4);
			
			// Embedding direct MySQL query code
			// Format: EMBED(mysql: password, username, database_name, server_location, port_number) [MySQL query code] ENDEMBED;
			// Info for line 200 (commenting here because everything in the EMBED structure is interpreted as MySQL code)
			// Parametrized SQL query 
			// the "?" corresponds to the "lastBuildDate" parameter passed in to this function
			dataset(FraudGovPlatform_Services.Layouts.LOG_Deltabase_Layout_Record) deltadata(
								integer gc_id,
								string ind_type_name,
								integer lastBuildDate) := 
								
				EMBED(mysql :   password(db_pw), user(db_user), database('delta_fraudgov'),server(db_loc), port(db_port))
									
					SELECT gc_id, CAST(inquiry_log_id AS CHAR(10)) AS cust_transaction_id, date_added as cust_transaction_date, case_id, client_uid, program_name,
						inquiry_reason, inquiry_source, customer_county_code, customer_state, customer_vertical_code, ssn, dob, CAST(lex_id AS UNSIGNED) as lex_id, 
						name_full, name_prefix, name_first, name_middle, name_last, name_suffix,full_address, physical_address,
						physical_city, physical_state, physical_zip, physical_county, mailing_address, mailing_city, mailing_state, mailing_zip,
						mailing_county, phone, ultid, orgid, seleid, tin, email_address, appendedproviderid, lnpid, npi, ip_address, device_id,
						professional_id, bank_routing_number, bank_account_number, dl_state, dl_number, geo_lat, geo_long, date_added 
					FROM delta_identity 
					WHERE gc_id = ? AND program_name=? AND date_added >= ?
			ENDEMBED;
			
			yesterday := STD.Date.AdjustDate(STD.Date.Today(),0,0,-1);			
			
			//Date in DB is stored as YYYYMMDDhhmmss but the environment variable only has YYYYMMDD, so addedd hhmmss
			//Also added failsafe...if we can't get the environment variable, we default it to yesterday
			last_data_build_date := (INTEGER)(thorlib.getenv(FraudGovPlatform_Services.Constants.FRAUDGOV_BUILD_ENV_VARIABLE,
																											(STRING)yesterday)[1..8] + '000000');
			
			db_records := deltadata(batch_params.GlobalCompanyId,batch_params.IndustryTypeName,last_data_build_date);
			
			db_records_filtered := DeltabaseMBSFilter(db_records, batch_params);

			ds_timeline_records := GetRecentTimelineDetails(db_records_filtered);
			
			 // OUTPUT(db_records,NAMED('Delta_Recs'));
			 // OUTPUT(db_records_filtered,NAMED('Delta_Filtered_MBS'));
			 // OUTPUT(ds_timeline_records,NAMED('Delta_Timeline'));

			return ds_timeline_records;
	END;
	
END;