IMPORT FraudGovPlatform_Services, FraudShared, FraudShared_Services, Gateway, iesp, STD;

EXPORT mod_Deltabase_Functions (FraudGovPlatform_Services.IParam.BatchParams batch_params) := MODULE
		
		SHARED Layout_LogDeltabase := FraudGovPlatform_Services.Layouts.LOG_Deltabase_Layout_Record;
		SHARED Layout_DeltabaseSelect := FraudShared_Services.Layouts.t_DeltaBaseSelectRequest;
		SHARED Layout_DeltabaseResponse := FraudGovPlatform_Services.Layouts.response_deltabase_layout;
		SHARED Fraud_Platform := FraudShared_Services.Constants.Platform.FraudGov;
		SHARED serviceUrl := batch_params.gateways(servicename = Gateway.Constants.ServiceName.FraudGovDeltabase)[1].Url;
		SHARED dqString := FraudShared_Services.Utilities.dqString;
		
		SHARED DeltabaseSoapcall(DATASET(Layout_DeltabaseSelect) readDeltabase) := FUNCTION
			
			Layout_DeltabaseResponse failRead(Layout_DeltabaseSelect L) := TRANSFORM
				SELF := [];
			END;
			
			soapcall_out := IF(serviceUrl  <> '', 
												SOAPCALL(	readDeltabase,
																	serviceUrl,
																	'DeltaBasePreparedSql',
																	Layout_DeltabaseSelect,
																	FraudShared_Services.Layouts.into_in(LEFT),
																	DATASET(Layout_DeltabaseResponse),
																	XPATH('DeltaBaseSelectResponse'),
																	ONFAIL(failRead(LEFT)),
																	RETRY(FraudShared_Services.Constants.read_retry),
																	TIMEOUT(FraudShared_Services.Constants.read_timeout),
																	TRIM, 
																	LOG), 
												DATASET([], Layout_DeltabaseResponse));		
												
			return soapcall_out;
		END;

		SHARED GetRecentTimelineDetails(DATASET(FraudShared_Services.Layouts.Raw_Payload_rec) ds_delta_records) := FUNCTION

			iesp.fraudgovreport.t_FraudGovTimelineDetails xForm_getTimeLineDetails( FraudShared_Services.Layouts.Raw_Payload_rec L) := TRANSFORM
				
				SELF.IsRecentActivity := TRUE;
				SELF.FileType := L.classification_Permissible_use_access.file_type;
				SELF.GlobalCompanyId := (INTEGER)L.Customer_ID;
				SELF.TransactionId := (STRING)L.transaction_id;
				SELF.DeceitfulConfidenceId := (INTEGER)L.classification_Activity.Confidence_that_activity_was_deceitful_id;
				SELF.HouseHoldId := L.Investigation_Referral_Case_ID;
				SELF.CustomerPersonId := (STRING)L.uid;
				SELF.EventType1 := L.Event_Type_1;
				SELF.EventDate.Year := (INTEGER)(L.Event_Date[1..4]);
				SELF.EventDate.Month := (INTEGER)(L.Event_Date[5..6]);
				SELF.EventDate.Day := (INTEGER)(L.Event_Date[7..8]);
				SELF.ReportedDateTime.Year := (INTEGER)(L.Reported_Date[1..4]);
				SELF.ReportedDateTime.Month := (INTEGER)(L.Reported_Date[5..6]);
				SELF.ReportedDateTime.Day := (INTEGER)(L.Reported_Date[7..8]);
				SELF.ReportedDateTime.Hour24 := (INTEGER)(L.Reported_Time[1..2]);
				SELF.ReportedDateTime.Minute := (INTEGER)(L.Reported_Time[3..4]);
				SELF.ReportedDateTime.Second := (INTEGER)(L.Reported_Time[5..6]);
				SELF.IndustryTypeDescription := L.classification_source.Industry_segment;
				SELF.ReportedBy := L.classification_Permissible_use_access.user_added;
				SELF.ActivityReason := L.Referral_reason;
				SELF.UniqueId := (STRING)L.did;
				SELF.Name.Full := L.raw_Full_name;
				SELF.Name.First := L.raw_first_name;
				SELF.Name.Middle := L.raw_middle_name;
				SELF.Name.Last := L.raw_last_name;
				SELF.Name.Suffix := L.raw_orig_suffix;
				SELF.Name.Prefix := L.raw_title;
				SELF.SSN := L.ssn;
				SELF.DOB.Year := IF(L.dob <> '', STD.Date.Year((INTEGER)L.dob), 0);
				SELF.DOB.Month := IF(L.dob <> '', STD.Date.Month((INTEGER)L.dob), 0);
				SELF.DOB.Day := IF(L.dob <> '', STD.Date.Day((INTEGER)L.dob), 0);
				SELF.PhysicalAddress.StreetAddress1 := L.Street_1;		
				SELF.PhysicalAddress.City := L.City;
				SELF.PhysicalAddress.State := L.State;
				SELF.PhysicalAddress.Zip5 := L.Zip;
				SELF.MailingAddress.StreetAddress1 := L.additional_address.Street_1;
				SELF.MailingAddress.City := L.additional_address.City;
				SELF.MailingAddress.State := L.additional_address.State;
				SELF.MailingAddress.Zip5 := L.additional_address.Zip;
				SELF.Phones := IF(L.phone_number <> '',
													ROW({FraudGovPlatform_Services.Constants.PHONE_TYPE.PHONE_TYPE_HOME, L.phone_number,''}, iesp.fraudgovreport.t_FraudGovPhoneInfo),
													ROW([], iesp.fraudgovreport.t_FraudGovPhoneInfo)
													);
				SELF.EmailAddress := L.email_address;
				SELF.DriversLicense.DriversLicenseNumber := L.Drivers_License;
				SELF.DriversLicense.DriversLicenseState := L.Drivers_License_State;
				SELF.BankInformation1.BankAccountNumber := L.bank_account_number_1;
				SELF.BankInformation1.BankRoutingNumber := L.bank_routing_number_1;
				SELF.IpAddress := L.ip_address;
				SELF.DeviceId := L.device_id;
				
				//The new input format (FraudShared_Services.Layouts.Raw_Payload_rec) record
				//stores the geo lat long information in one field with "," as the separator
				SELF.GeoLocation.Latitude := regexfind('(.*),(.*)$',L.GPS_coordinates,1);
				SELF.GeoLocation.Longitude := regexfind('(.*),(.*)$',L.GPS_coordinates,2);
				SELF := [];
			END;

		ds_timeline_recent_activity := PROJECT(ds_delta_records,xForm_getTimeLineDetails(LEFT));

		return ds_timeline_recent_activity;
	END;
	
	SHARED DeltabaseMBSFilter(DATASET(Layout_LogDeltabase) deltabase_recs) := FUNCTION
			
			mbs_delta_key := FraudShared.Key_MbsDeltaBase(FraudGovPlatform_Services.Constants.FRAUD_PLATFORM);
			
			//Transform into input format of FraudShared_Services.FilterThruMBS function
			FraudShared_Services.Layouts.Raw_Payload_rec xform_create_mbs_in(deltabase_recs L, 
																																			mbs_delta_key R) := TRANSFORM
				// SELF.Record_ID := (INTEGER)L.cust_transaction_id;
				SELF.transaction_id := L.cust_transaction_id;
				SELF.Customer_ID := L.gc_id;
				SELF.Event_Date := L.date_added[1..4] + L.date_added[6..7] + L.date_added[9..10];
				SELF.Reported_Date := L.date_added[1..4] + L.date_added[6..7] + L.date_added[9..10];
				SELF.Reported_Time := L.date_added[12..13] + L.date_added[15..16] + L.date_added[18..19];
				SELF.Investigation_Referral_Case_ID := L.case_id;
				// SELF.Customer_Person_ID := L.client_uid;
				SELF.uid := (INTEGER)L.client_uid;
				SELF.Type_of_Referral := L.inquiry_source;
				SELF.Referral_Reason := L.reason_description;
				SELF.SSN := L.SSN;
				SELF.DOB := L.DOB;
				// SELF.UID := L.lex_id;
				SELF.did := L.lex_id;
				SELF.raw_Full_name := L.name_full;
				SELF.raw_title := L.name_prefix;
				SELF.raw_first_name := L.name_first;
				SELF.raw_middle_name := L.name_middle;
				SELF.raw_last_name := L.name_last;
				SELF.raw_orig_suffix := L.name_suffix;
				SELF.Street_1 := L.physical_address;
				SELF.City := L.physical_city;
				SELF.State := L.physical_state;
				SELF.Zip := L.physical_zip;
				SELF.phone_number := L.phone;
				SELF.UltID := L.UltID;
				SELF.OrgID := L.OrgId;
				SELF.SeleID := L.SeleID;
				SELF.tin := L.tin;
				SELF.email_address := L.email_address;
				SELF.Appended_Provider_ID := L.appendedProviderID;
				SELF.lnpid := L.lnpid;
				SELF.npi := L.NPI;
				SELF.IP_Address := L.ip_address;
				SELF.Device_ID := L.Device_ID;
				SELF.Professional_ID := L.professional_id;
				SELF.bank_routing_number_1 := L.bank_routing_number;
				SELF.bank_account_number_1 := L.bank_account_number;
				SELF.Drivers_License := L.dl_number;
				SELF.Drivers_License_State := L.dl_state;
				SELF.GPS_coordinates := L.geo_lat + ',' + L.geo_long;
				//mailing address
				SELF.additional_address.Street_1 := L.mailing_address;
				SELF.additional_address.City := L.mailing_city;
				SELF.additional_address.State := L.mailing_state;
				SELF.additional_address.Zip := L.mailing_zip;
				SELF.Event_Type_1 := L.Event_Type_1;
				
				SELF.classification_Permissible_use_access.user_added := L.user_added;
				SELF.classification_Permissible_use_access.file_type := L.file_type;
				SELF.classification_Permissible_use_access := R;
				SELF.classification_Entity.entity_type := L.event_entity_1;
				SELF.classification_Activity.Confidence_that_activity_was_deceitful_id := (INTEGER)L.deceitful_confidence;
				SELF.classification_source.Industry_segment := L.program_name;

				SELF := [];
			END;
			
			//Get fdn permissible use access information (fdn file info id) from mbsdeltabase key for deltabase recs
			//This is needed in order to run FraudShared_Services.FilterThruMBS to apply MBS sharing rules
			delta_w_fdn_file_info := JOIN(deltabase_recs, mbs_delta_key,
																	KEYED(LEFT.gc_id = (STRING)RIGHT.gc_id) AND
																				LEFT.program_name = RIGHT.ind_type_description AND
																				RIGHT.product_include = FraudShared_Services.Constants.PRODUCT_INCLUDE_CODE_ALL,
																xform_create_mbs_in(LEFT,RIGHT),
																LIMIT(FraudGovPlatform_Services.Constants.Limits.MAX_JOIN_LIMIT, SKIP)
																);
																
			payload_mbs_filtered := FraudShared_Services.FilterThruMBS(delta_w_fdn_file_info,batch_params.GlobalCompanyId,batch_params.IndustryType,
																															batch_params.ProductCode, 
																															DATASET([],iesp.frauddefensenetwork.t_FDNIndType),
																															DATASET([],iesp.frauddefensenetwork.t_FDNFileType),
																															fraud_platform);
																															
																					
			// output(deltabase_recs,named('deltabase_recs'));
			// output(delta_w_fdn_file_info,named('delta_w_fdn_file_info'));
			// output(payload_mbs_filtered,named('payload_mbs_filtered'));
			// output(payload_mbs_filtered,named('payload_mbs_filtered'));
			
			// return payload_mbs_filtered;
			return payload_mbs_filtered;
	END;

	EXPORT getDeltabaseReportRecords(DATASET(FraudShared_Services.Layouts.BatchInExtended_rec) in_recs) := FUNCTION

			/*
			----------------------------------------------------------------------------------------------------------------------------------
			CODING IN THE COMMENT IS NO LONGER USED. SINCE NOW INSTEAD OF DIRECT DELTA BASE LOOKUP FROM ROXIE, WE 
			ARE GOING TO CALL GATEWAY ESP VIA SOAPCALL TO ACCESS DELTABASE RECORDS.
			STILL KEEPING IT AS COMMENTED, IN CASE WE SWITCH BACK TO EARLIER METHOD IN FUTURE....
			----------------------------------------------------------------------------------------------------------------------------------	
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
			dataset(Layout_LogDeltabase) deltadata(
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
			*/
			
			query_filter:= PROJECT(in_recs,FraudGovPlatform_Services.Transforms.xform_getDeltabaseQueryParams(LEFT));
		
			Layout_DeltabaseSelect xRead_report(FraudGovPlatform_Services.Layouts.Layout_delta_filter L) := TRANSFORM
				SELF.Select := 	
					'SELECT * FROM delta_fraudgov.delta_identity WHERE '
					+ ' date_added >= "' + L.date_added + '"'
					+ ' AND ( '
					+ ' (length(' + dqString(L.ssn) + ') > 0 AND ssn= ' + dqString(L.ssn) + ') OR ' 
					+ ' (length(' + dqString(L.dob)+ ') > 0 AND dob= ' + dqString(L.dob)+ ' ) OR '
					+ ' (' + L.lex_id + ' <> 0 AND lex_id= ' + L.lex_id + ') OR '
					+ ' (length(' + dqString(L.name_first)+ ') > 0 AND name_first= ' + dqString(L.name_first)+ ') OR '
					+ ' (length(' + dqString(L.name_middle)+ ') > 0 AND name_middle= ' + dqString(L.name_middle)+ ') OR '
					+ ' (length(' + dqString(L.name_last)+ ') > 0 AND name_last= ' + dqString(L.name_last)+ ') OR '
					+ ' (	length(' + dqString(L.physical_address)+ ') > 0 AND physical_address= ' + dqString(L.physical_address)+ ' AND '
					+ ' length(' + dqString(L.physical_city)+ ') > 0 AND physical_city= ' + dqString(L.physical_city)+ ' AND '
					+ ' length(' + dqString(L.physical_state)+ ') > 0 AND physical_state= ' + dqString(L.physical_state)+ ' AND '
					+ ' length(' + dqString(L.physical_zip)+ ') > 0 AND physical_zip= ' + dqString(L.physical_zip)+ ') OR '
					+ ' (	length(' + dqString(L.mailing_address)+ ') > 0 AND mailing_address= ' + dqString(L.mailing_address)+ ' AND '
					+ ' length(' + dqString(L.mailing_city)+ ') > 0 AND mailing_city= ' + dqString(L.mailing_city)+ ' AND '
					+ ' length(' + dqString(L.mailing_state)+ ') > 0 AND mailing_state= ' + dqString(L.mailing_state)+ ' AND '
					+ ' length(' + dqString(L.mailing_zip)+ ') > 0 AND mailing_zip= ' + dqString(L.mailing_zip)+ ') OR '
					+ ' (length(' + dqString(L.phone)+ ') > 0 AND phone= ' + dqString(L.phone)+ ') OR '
					+ ' (length(' + dqString(L.ip_address)+ ') > 0 AND ip_address= ' + dqString(L.ip_address)+ ') OR '
					+ ' (length(' + dqString(L.device_id)+ ') > 0 AND device_id= ' + dqString(L.device_id)+ ') OR '
					+ ' (length(' + dqString(L.bank_account_number)+ ') > 0 AND bank_account_number= ' + dqString(L.bank_account_number)+ ') OR '
					+ ' (length(' + dqString(L.dl_state) + ') > 0 AND dl_state= ' + dqString(L.dl_state) + ' AND '
					+	'	 length(' + dqString(L.dl_number)+ ') >0 AND dl_number= ' + dqString(L.dl_number)+ ') OR '
					+ ' (length(' + dqString(L.geo_lat) + ') > 0 AND geo_lat= ' + dqString(L.geo_lat) + ' AND '
					+ '  length(' + dqString(L.geo_long) + ') > 0 AND geo_long= ' + dqString(L.geo_long) + ')	'	
					+ ' )'
					+ FraudGovPlatform_Services.Constants.limiter;
			END;
			 
			readDeltabase :=	PROJECT(query_filter, xRead_report(LEFT));
			
			soapcall_out := DeltabaseSoapcall(readDeltabase);

			Layout_LogDeltabase NormIt_report(Layout_LogDeltabase R) := TRANSFORM
				SELF := R;
			END;
			
			deltabase_recs_norm := NORMALIZE(soapcall_out, LEFT.deltaFields, NormIt_report(RIGHT));	
			db_records_filtered := DeltabaseMBSFilter(deltabase_recs_norm);
			ds_timeline_records := GetRecentTimelineDetails(db_records_filtered);
			
			//output(ds_timeline_records,named('ds_timeline_records'));

			return ds_timeline_records;
	END;
	
	EXPORT getDeltabaseSearchRecords() := FUNCTION
			
			/*
			----------------------------------------------------------------------------------------------------------------------------------
			CODING IN THE COMMENT IS NO LONGER USED. SINCE NOW INSTEAD OF DIRECT DELTA BASE LOOKUP FROM ROXIE, WE 
			ARE GOING TO CALL GATEWAY ESP VIA SOAPCALL TO ACCESS DELTABASE RECORDS.
			STILL KEEPING IT AS COMMENTED, IN CASE WE SWITCH BACK TO EARLIER METHOD IN FUTURE....
			----------------------------------------------------------------------------------------------------------------------------------	

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
			dataset(Layout_LogDeltabase) deltadata(
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
			*/
			
			//Date in DB is stored as YYYYMMDDhhmmss but the environment variable only has YYYYMMDD, so addedd hhmmss
			//Also added failsafe...if we can't get the environment variable, we default it to yesterday
			last_data_build_date := (INTEGER)(thorlib.getenv(FraudGovPlatform_Services.Constants.FRAUDGOV_BUILD_ENV_VARIABLE,
															(STRING)FraudGovPlatform_Services.Utilities.yesterday)[1..8] + '000000');			
		
			Layout_DeltabaseSelect xRead_search() := TRANSFORM
				SELF.Select := 'SELECT * FROM delta_fraudgov.delta_identity WHERE '
					+ ' date_added >= ' + last_data_build_date
					+ FraudGovPlatform_Services.Constants.limiter;
			END;
			
			readDeltabase := DATASET([xRead_search()]);
			
			soapcall_out := DeltabaseSoapcall(readDeltabase);
																		
			Layout_LogDeltabase NormIt(Layout_LogDeltabase R) := TRANSFORM
				SELF := R;
			END;
			
			deltabase_recs_norm := NORMALIZE(soapcall_out, LEFT.deltaFields, NormIt(RIGHT));																					
			db_records_filtered := DeltabaseMBSFilter(deltabase_recs_norm);
			ds_timeline_records := GetRecentTimelineDetails(db_records_filtered);
			
			return ds_timeline_records(FileType <> FraudGovPlatform_Services.Constants.PayloadFileTypeEnum.StatusUpdate);
	END;
	
END;