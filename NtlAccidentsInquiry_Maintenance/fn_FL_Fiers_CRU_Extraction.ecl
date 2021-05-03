IMPORT Data_Services, STD, flaccidents;

EXPORT fn_FL_Fiers_CRU_Extraction(STRING Pdate = (STRING) STD.Date.CurrentDate(TRUE)) := FUNCTION

  SequencingRecSummary := RECORD
		UNSIGNED recid;
		STRING line;
		END;

  //Used for CSV header record						
   OrderVersionHeader := 'ORDER_ID,' + 
								'SEQUENCE_NBR,' + 
								'CREATION_DATE,' + 
								'ACCT_NBR,' + 
								'ACCT_SUFFIX,' + 
								'CLIENT_ID,' + 
								'ADJUSTER_ID,' + 
								'STATE_NBR,' + 
								'AGENCY_ID,' + 
								'AGENCY_TYPE,' + 
								'EDIT_AGENCY_NAME,' + 
								'SERVICE_ID,' + 
								'STATUS_ID,' + 
								'REASON_ID,' + 
								'QUEUE,' + 
								'CLAIM_NBR,' + 
								'LOSS_DATE,' + 
								'LOSS_TIME,' + 
								'PRECINCT,' + 
								'REPORT_NBR,' + 
								'HOUSE_NBR,' + 
								'STREET,' + 
								'APT_NBR,' + 
								'CROSS_STREET,' + 
								'CITY,' + 
								'STATE,' + 
								'ZIP5,' + 
								'ZIP4,' + 
								'COUNTY,' + 
								'oTAG,' + 
								'oTAG_STATE,' + 
								'VIN,' + 
								'MAKE,' + 
								'MODEL,' + 
								'FIRST_NAME_1,' + 
								'MIDDLE_NAME_1,' + 
								'LAST_NAME_1,' + 
								'SSN_1,' + 
								'DOB_1,' + 
								'FIRST_NAME_2,' + 
								'MIDDLE_NAME_2,' + 
								'LAST_NAME_2,' + 
								'FIRST_NAME_3,' + 
								'MIDDLE_NAME_3,' + 
								'LAST_NAME_3,' + 
								'DRIVERS_LICENSE,' + 
								'DRIVERS_LICENSE_ST,' + 
								'PROCESSED_DATE,' + 
								'PRINT_DATE,' + 
								'CHECKIN_DATE,' + 
								'COST_OVERRIDE,' + 
								'ADDITIONAL_INFO,' + 
								'SPECIAL_NOTE,' + 
								'SPECIAL_BILLING_ID,' + 
								'LAST_CHANGED,' + 
								'USERID,' + 
								'EXPECTED_TURNAROUND,' + 
								'ORDERPOINT_STATUS,' + 
								'YEAR,' + 
								'ACTUAL_TURNAROUND,' + 
								'HISTORICAL_NOTICE,' + 
								'CLIENT_QUOTEBACK,' + 
								'AGENCY_COST,' + 
								'HANDLING_FEE,' + 
								'SECOND_REQUEST_PRINT_DATE,' +
								'SUFFIX_1,' + 
								'GENDER_1,' + 
								'STATE_SERVICE_TYPE_NAME,' + 
								'BILLING_RESTRICTED,';

  ResultHeader := 'RESULT_ID,' + 
					'ORDER_ID,' + 
					'SEQUENCE_NBR,' + 
					'BATCH_ID,' + 
					'PAGE_COUNT,' + 
					'START_INDEX,' + 
					'END_INDEX,' + 
					'RESULT_STATUS,' + 
					'RESULT_TYPE,' + 
					'CREATION_DATE,' + 
					'HAS_ORIGINAL_COVER,' + 
					'POOR_QUALITY,' + 
					'BATCH_DOC_NBR,' + 
					'LAST_CHANGED,' + 
					'USERID,' + 
					'VIN_ENTRY_STATUS,' + 
					'PDF_IMAGE_HASH,' + 
					'TIF_IMAGE_HASH,';
					
	IncidentHeader := 'VEHICLE_INCIDENT_ID,' + 
						'ORDER_ID,' + 
						'SEQUENCE_NBR,' + 
						'REPORT_NBR,' + 
						'LOSS_DATE,' + 
						'LOSS_TIME,' + 
						'SERVICE_ID,' + 
						'inc_CITY,' + 
						'STATE_ABBR,' +                                                                                                                                                                                                                                                                                                                                                                                                                                                           
						'NBR_VEHICLES,' + 
						'RESULT_ID,' + 
						'LAST_CHANGED,' + 
						'USERID,';
						
	PartyHeader := 'PARTY_ID,' + 
				 'PARTY_TYPE,' + 
				 'VEHICLE_ID,' + 
				 'VEHICLE_INCIDENT_ID,' + 
				 'FIRST_NAME,' + 
				 'LAST_NAME,' + 
				 'BUSINESS_NAME,' + 
				 'pty_DRIVERS_LICENSE,' + 
				 'pty_DRIVERS_LICENSE_ST,' + 
				 'DOB,' + 
				 'LAST_CHANGED,' + 
				 'USERID,';
				 
  ClientHeader := 'ACCT_NBR,' +
					'CLIENT_ID,' +
					'COMPANY_NAME,' +
					'BILL_TYPE,' +
					'BILL_CYCLE,' +
					'EBILL_CLIENT,' +
					'ACTIVE,' +
					'OPERATOR_REQUIRED,' +
					'COVER_PAGE,' +
					'FILE_SOURCE,' +
					'AUTH_LETTER,' +
					'START_DATE,' +
					'SEND_COST_TO_CLIENT,' +
					'COMMENT1,' +
					'COMMENT2,' +
					'DIVISION_CLIENT,' +
					'ONLINE_SERVICES,' +
					'ALT_DELIVERY,' +
					'NATIONAL_CLIENT,' +
					'SALES_REP,' +
					'ACCT_MGR,' +
					'CLIENT_NOTICE,' +
					'ENVELOPE_ADDR_TYPE,' +
					'VERSION,' +
					'LAST_CHANGED,' +
					'USERID,' +
					'DMV_CLIENT,' +
					'CLIENT_TYPE_ID,' +
					'COMPANY_NBR,' +
					'AGREEMENT_NBR,' +
					'AGREEMENT_ON_FILE,' +
					'ASSOC_COST_RESTRICTED,' +
					'ORDER_IMPORT_FORMAT_ID,' +
					'WSDL_URL,' +
					'WSDL_LAST_CHANGED,' +
					'WSDL_LAST_CHANGED_USERID,' +
					'INTERNAL_VERTICAL,' +
					'AUTH_USERNAME,' +
					'AUTH_PASSWORD,' +
					'NON_BILLABLE,' +
					'INTERNAL_VERTICAL_NAME,' +
					'LEGAL_NAME,';

	VehiclesHeader := 'VEHICLE_ID,' +
						'VEHICLE_INCIDENT_ID,' +
						'VEHICLE_NBR,' +
						'VEHICLE_STATUS,' +
						'vehVIN,' +
						'vehYEAR,' +
						'vehMAKE,' +
						'vehMODEL,' +
						'ODOMETER,' +
						'TAG,' +
						'TAG_STATE,' +
						'COLOR,' +
						'IMPACT_LOCATION,' +
						'POLICY_NBR,' +
						'POLICY_EXP_DATE,' +
						'CARRIER_ID,' +
						'OTHER_CARRIER,' +
						'COMMERCIAL_VIN,' +
						'CAR_FIRE,' +
						'AIRBAGS_DEPLOY,' +
						'CAR_TOWED,' +
						'CAR_ROLLOVER,' +
						'DECODED_INFO,' +
						'LAST_CHANGED,' +
						'USERID,' +
						'DAMAGE,' +
						'POLK_VALIDATED_VIN,';
							
  SimpleLine := RECORD
		STRING line;
		END;
		
  //Despray file to target LZ
  BigLineFormatDespray (DATASET(SequencingRecSummary) inputRecs, STRING attachmentName) := FUNCTION
	thorDs := PROJECT(SORT(inputRecs, recID), SimpleLine);
	FilePath := '/data/super_credit/ecrash/despray/flremoval' + '/' + attachmentName; 
	FlatFiles := OUTPUT (thorDs, ,attachmentName, CSV, OVERWRITE, EXPIRE(30));
	//FlatFiles := OUTPUT (CHOOSEN(thorDs, 100), ,attachmentName, CSV, OVERWRITE, EXPIRE(30));
	DesprayAction := FileServices.DESPRAY(attachmentName, 'bctlpedata12.risk.regn.net', FilePath,,,,TRUE);

  despary := SEQUENTIAL(FlatFiles, DesprayAction);
 
	RETURN SEQUENTIAL(despary);
 END;

 lay_order := RECORD
               STRING order_id; 
						  END;
						 
 dsOrder := DATASET('~thor_data400::CRU::All::FLData::OrderID_07072020', lay_order, CSV(SEPARATOR([',','\t']), TERMINATOR(['\n','\r\n','\n\r']),QUOTE('"')))(order_id != 'ORDER_ID');
 ddsOrder := DEDUP(dsOrder, order_id); 

 //OrderVersion input file 
 ds_ordervs := DATASET(data_services.foreign_prod +'thor_data400::in::flcrash::alpharetta::order_version_new'
						           ,flaccidents.Layout_NtlAccidents_Alpharetta.order_vs
						           ,CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')))(ORDER_ID  != 'ORDER_ID');

 flaccidents.Layout_NtlAccidents_Alpharetta.order_vs updateordervs(ds_ordervs L, ddsOrder R) := TRANSFORM
																																																	SELF := L;
																																																 END;
 rm_ordervs := JOIN(DISTRIBUTE(ds_ordervs,HASH32(order_id)),DISTRIBUTE(ddsOrder,HASH32(order_id)),
						        TRIM(LEFT.order_id, LEFT, RIGHT) = TRIM(RIGHT.order_id, LEFT, RIGHT),
						        updateordervs(LEFT,RIGHT), INNER, LOCAL):INDEPENDENT;
					
  SequencingRecSummary xformCtr_ordervs(rm_ordervs L, INTEGER CTR) := TRANSFORM
	   SELF.recid            	:= CTR;
		 SELF.LINE             	:= TRIM('"' + TRIM(L.ORDER_ID, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.SEQUENCE_NBR, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.CREATION_DATE, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.ACCT_NBR, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.ACCT_SUFFIX, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.CLIENT_ID, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.ADJUSTER_ID, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.STATE_NBR, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.AGENCY_ID, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.AGENCY_TYPE, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.EDIT_AGENCY_NAME, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.SERVICE_ID, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.STATUS_ID, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.REASON_ID, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.QUEUE, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.CLAIM_NBR, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.LOSS_DATE, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.LOSS_TIME, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.PRECINCT, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.REPORT_NBR, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.HOUSE_NBR, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.STREET, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.APT_NBR, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.CROSS_STREET, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.CITY, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.STATE, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.ZIP5, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.ZIP4, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.COUNTY, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.oTAG, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.oTAG_STATE, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.VIN, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.MAKE, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.MODEL, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.FIRST_NAME_1, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.MIDDLE_NAME_1, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.LAST_NAME_1, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.SSN_1, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.DOB_1, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.FIRST_NAME_2, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.MIDDLE_NAME_2, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.LAST_NAME_2, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.FIRST_NAME_3, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.MIDDLE_NAME_3, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.LAST_NAME_3, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.DRIVERS_LICENSE, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.DRIVERS_LICENSE_ST, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.PROCESSED_DATE, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.PRINT_DATE, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.CHECKIN_DATE, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.COST_OVERRIDE, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.ADDITIONAL_INFO, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.SPECIAL_NOTE, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.SPECIAL_BILLING_ID, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.LAST_CHANGED, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.USERID, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.EXPECTED_TURNAROUND, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.ORDERPOINT_STATUS, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.YEAR, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.ACTUAL_TURNAROUND, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.HISTORICAL_NOTICE, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.CLIENT_QUOTEBACK, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.AGENCY_COST, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.HANDLING_FEE, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.SECOND_REQUEST_PRINT_DATE, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.SUFFIX_1, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.GENDER_1, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.STATE_SERVICE_TYPE_NAME, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.BILLING_RESTRICTED, LEFT, RIGHT) + '"', LEFT, RIGHT); 
  END; 
	ExtractData_ordervs          := PROJECT(rm_ordervs, xformCtr_ordervs(LEFT, COUNTER));
	ExtractHeaderRec_ordervs  		:= DATASET([{0, OrderVersionHeader}], SequencingRecSummary);
	FORMATTEDFINALA_ordervs 		  := BigLineFormatDespray(ExtractData_ordervs & ExtractHeaderRec_ordervs, 'FL_NtlAccInq_OrderVersion.CSV');

  //Result input file
  ds_result := DATASET(data_services.foreign_prod + 'thor_data400::in::flcrash::alpharetta::result_new'
										   ,flaccidents.Layout_NtlAccidents_Alpharetta.result
										   ,CSV(TERMINATOR('\n'), SEPARATOR(',')))(RESULT_ID != 'RESULT_ID');                  
  
	flaccidents.Layout_NtlAccidents_Alpharetta.result updateResult(ds_result L, ddsOrder R) := TRANSFORM
																																																SELF := L;
																																															END;
  rm_result := JOIN(DISTRIBUTE(ds_result,HASH32(order_id)),DISTRIBUTE(ddsOrder,HASH32(order_id)),
										TRIM(LEFT.order_id, LEFT, RIGHT) = TRIM(RIGHT.order_id, LEFT, RIGHT),
										updateResult(LEFT,RIGHT), INNER, LOCAL);

  SequencingRecSummary xformCtr_result(rm_result L, INTEGER CTR) := TRANSFORM
	   SELF.recid            	:= CTR;
		 SELF.LINE             	:= 	TRIM('"' + TRIM(L.RESULT_ID, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.ORDER_ID, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.SEQUENCE_NBR, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.BATCH_ID, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.PAGE_COUNT, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.START_INDEX, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.END_INDEX, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.RESULT_STATUS, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.RESULT_TYPE, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.CREATION_DATE, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.HAS_ORIGINAL_COVER, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.POOR_QUALITY, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.BATCH_DOC_NBR, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.LAST_CHANGED, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.USERID, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.VIN_ENTRY_STATUS, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.PDF_IMAGE_HASH, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.TIF_IMAGE_HASH, LEFT, RIGHT) + '"', LEFT, RIGHT); 
  END;
	ExtractData_result        := PROJECT(rm_result, xformCtr_result(LEFT, COUNTER));
	ExtractHeaderRec_result  	:= DATASET([{0, ResultHeader}], SequencingRecSummary);
	FORMATTEDFINALA_result 		:= BigLineFormatDespray(ExtractData_result & ExtractHeaderRec_result, 'FL_NtlAccInq_Result.CSV');
	
	//Incident input file
  ds_incident 		:= DATASET(data_services.foreign_prod + 'thor_data400::in::flcrash::alpharetta::vehicle_incident_new'
										        ,flaccidents.Layout_NtlAccidents_Alpharetta.incident
										        ,cSV(TERMINATOR('\n'), SEPARATOR(',')));
	
  flaccidents.Layout_NtlAccidents_Alpharetta.incident updateInc(ds_incident L, ddsOrder R) := TRANSFORM
																																																 SELF := L;
																																																END;
  rm_Inc := JOIN(DISTRIBUTE(ds_incident,HASH32(order_id)),DISTRIBUTE(ddsOrder,HASH32(order_id)),
								 TRIM(LEFT.order_id, LEFT, RIGHT) = TRIM(RIGHT.order_id, LEFT, RIGHT),
								 updateInc(LEFT,RIGHT), INNER, LOCAL):INDEPENDENT;
  
	SequencingRecSummary xformCtr_inc(rm_Inc L, INTEGER CTR) := TRANSFORM
	   SELF.recid            	:= CTR;
		 SELF.LINE             	:= 	TRIM('"' + TRIM(L.VEHICLE_INCIDENT_ID, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.ORDER_ID, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.SEQUENCE_NBR, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.REPORT_NBR, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.LOSS_DATE, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.LOSS_TIME, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.SERVICE_ID, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.inc_CITY, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.STATE_ABBR, LEFT, RIGHT) + '"' + ',' +                                                                                                                                                                                                                                                                                                                                                                                                                                                          
					'"' + TRIM(L.NBR_VEHICLES, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.RESULT_ID, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.LAST_CHANGED, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.USERID, LEFT, RIGHT) + '"', LEFT, RIGHT); 
  END;
	ExtractData_inc           := PROJECT(rm_inc, xformCtr_inc(LEFT, COUNTER));
	ExtractHeaderRec_inc  		:= DATASET([{0, IncidentHeader}], SequencingRecSummary);
	FORMATTEDFINALA_inc 		  := BigLineFormatDespray(ExtractData_inc & ExtractHeaderRec_inc, 'FL_NtlAccInq_Incident.CSV');
			
	//Client input file
  ds_client := DATASET(data_services.foreign_prod + 'thor_data400::in::flcrash::alpharetta::client_new'
										  ,flaccidents.Layout_NtlAccidents_Alpharetta.client
										  ,CSV(TERMINATOR('\n'), SEPARATOR(',')))(ACCT_NBR != 'ACCT_NBR'); 

  d_client := DISTRIBUTE(ds_client,HASH32(acct_nbr,client_id));
	dd_ordervs := DEDUP(SORT(DISTRIBUTE(rm_ordervs(client_id <> ''),HASH32(acct_nbr,client_id))
	                         ,acct_nbr,client_id,(last_changed[7..10]+last_changed[1..2]+last_changed[4..5]),local)
								      ,acct_nbr,client_id,right,local);
											
	flaccidents.Layout_NtlAccidents_Alpharetta.client updateClient(ds_client L, rm_ordervs R) := TRANSFORM
																																														     SELF := L;
																																														   END;
	rm_Client := JOIN(d_client, dd_ordervs,
								    TRIM(LEFT.acct_nbr, LEFT, RIGHT) = TRIM(RIGHT.acct_nbr, LEFT, RIGHT) AND
								    TRIM(LEFT.client_id, LEFT, RIGHT) = TRIM(RIGHT.client_id, LEFT, RIGHT),
										updateClient(LEFT,RIGHT), INNER, LOCAL);
 
  SequencingRecSummary xformCtr_client(rm_Client L, INTEGER CTR) := TRANSFORM
	   SELF.recid            	:= CTR;
		 SELF.LINE             	:= TRIM('"' + TRIM(L.ACCT_NBR, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.CLIENT_ID, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.COMPANY_NAME, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.BILL_TYPE, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.BILL_CYCLE, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.EBILL_CLIENT, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.ACTIVE, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.OPERATOR_REQUIRED, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.COVER_PAGE, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.FILE_SOURCE, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.AUTH_LETTER, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.START_DATE, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.SEND_COST_TO_CLIENT, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.COMMENT1, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.COMMENT2, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.DIVISION_CLIENT, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.ONLINE_SERVICES, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.ALT_DELIVERY, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.NATIONAL_CLIENT, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.SALES_REP, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.ACCT_MGR, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.CLIENT_NOTICE, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.ENVELOPE_ADDR_TYPE, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.VERSION, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.LAST_CHANGED, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.USERID, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.DMV_CLIENT, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.CLIENT_TYPE_ID, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.COMPANY_NBR, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.AGREEMENT_NBR, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.AGREEMENT_ON_FILE, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.ASSOC_COST_RESTRICTED, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.ORDER_IMPORT_FORMAT_ID, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.WSDL_URL, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.WSDL_LAST_CHANGED, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.WSDL_LAST_CHANGED_USERID, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.INTERNAL_VERTICAL, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.AUTH_USERNAME, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.AUTH_PASSWORD, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.NON_BILLABLE, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.INTERNAL_VERTICAL_NAME, LEFT, RIGHT) + '"' + ',' +
						'"' + TRIM(L.LEGAL_NAME, LEFT, RIGHT) + '"', LEFT, RIGHT); 
  END;
  ExtractData_client        := PROJECT(rm_Client, xformCtr_client(LEFT, COUNTER));
	ExtractHeaderRec_client  	:= DATASET([{0, ClientHeader}], SequencingRecSummary);
	FORMATTEDFINALA_client 		:= BigLineFormatDespray(ExtractData_client & ExtractHeaderRec_client, 'FL_NtlAccInq_Client.CSV');	
	
	//Vehicles input file
  vehicles_in := DATASET(data_services.foreign_prod +'thor_data400::in::flcrash::alpharetta::vehicle_new'
										    ,flaccidents.Layout_NtlAccidents_Alpharetta.payload
										    ,CSV(TERMINATOR('\n'), SEPARATOR(''), QUOTE('')));
										
	flaccidents.Layout_NtlAccidents_Alpharetta.vehicles parserecs(vehicles_in L) := TRANSFORM
	STRING unparsedRec := REGEXREPLACE('"',REGEXREPLACE(',"',REGEXREPLACE('","',L.line+'|','|'),'|'),'');							

	SELF.VEHICLE_ID       		:= unparsedRec[1..stringlib.stringfind(unparsedRec,'|',1)-1];						
	SELF.VEHICLE_INCIDENT_ID	 := unparsedRec[stringlib.stringfind(unparsedRec,'|',1)+1..stringlib.stringfind(unparsedRec,'|',2)-1];						
	SELF.VEHICLE_NBR		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',2)+1..stringlib.stringfind(unparsedRec,'|',3)-1];						
	SELF.VEHICLE_STATUS		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',3)+1..stringlib.stringfind(unparsedRec,'|',4)-1];						
	SELF.vehVIN		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',4)+1..stringlib.stringfind(unparsedRec,'|',5)-1];
	SELF.vehYEAR			:= unparsedRec[stringlib.stringfind(unparsedRec,'|',5)+1..stringlib.stringfind(unparsedRec,'|',6)-1];
	SELF.vehMAKE	:= unparsedRec[stringlib.stringfind(unparsedRec,'|',6)+1..stringlib.stringfind(unparsedRec,'|',7)-1];
	SELF.vehMODEL			:= unparsedRec[stringlib.stringfind(unparsedRec,'|',7)+1..stringlib.stringfind(unparsedRec,'|',8)-1];
	SELF.ODOMETER	:= unparsedRec[stringlib.stringfind(unparsedRec,'|',8)+1..stringlib.stringfind(unparsedRec,'|',9)-1];
	SELF.TAG	:= unparsedRec[stringlib.stringfind(unparsedRec,'|',9)+1..stringlib.stringfind(unparsedRec,'|',10)-1];
	SELF.TAG_STATE			:= unparsedRec[stringlib.stringfind(unparsedRec,'|',10)+1..stringlib.stringfind(unparsedRec,'|',11)-1];
	SELF.COLOR		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',11)+1..stringlib.stringfind(unparsedRec,'|',12)-1];
	SELF.IMPACT_LOCATION	:= unparsedRec[stringlib.stringfind(unparsedRec,'|',12)+1..stringlib.stringfind(unparsedRec,'|',13)-1];
	SELF.POLICY_NBR		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',13)+1..stringlib.stringfind(unparsedRec,'|',14)-1];
	SELF.POLICY_EXP_DATE			:= unparsedRec[stringlib.stringfind(unparsedRec,'|',14)+1..stringlib.stringfind(unparsedRec,'|',15)-1];
	SELF.CARRIER_ID		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',15)+1..stringlib.stringfind(unparsedRec,'|',16)-1];
	SELF.OTHER_CARRIER		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',16)+1..stringlib.stringfind(unparsedRec,'|',17)-1];
	SELF.COMMERCIAL_VIN    := unparsedRec[stringlib.stringfind(unparsedRec,'|',17)+1..stringlib.stringfind(unparsedRec,'|',18)-1];					
	SELF.CAR_FIRE	   		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',18)+1..stringlib.stringfind(unparsedRec,'|',19)-1];						
	SELF.AIRBAGS_DEPLOY		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',19)+1..stringlib.stringfind(unparsedRec,'|',20)-1];						
	SELF.CAR_TOWED		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',20)+1..stringlib.stringfind(unparsedRec,'|',21)-1];						
	SELF.CAR_ROLLOVER		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',21)+1..stringlib.stringfind(unparsedRec,'|',22)-1];
	SELF.DECODED_INFO			:= unparsedRec[stringlib.stringfind(unparsedRec,'|',22)+1..stringlib.stringfind(unparsedRec,'|',23)-1];
	SELF.LAST_CHANGED	:= unparsedRec[stringlib.stringfind(unparsedRec,'|',23)+1..stringlib.stringfind(unparsedRec,'|',24)-1];
	SELF.USERID			:= unparsedRec[stringlib.stringfind(unparsedRec,'|',24)+1..stringlib.stringfind(unparsedRec,'|',25)-1];
	SELF.DAMAGE	:= unparsedRec[stringlib.stringfind(unparsedRec,'|',25)+1..stringlib.stringfind(unparsedRec,'|',26)-1];
	SELF.POLK_VALIDATED_VIN	:= unparsedRec[stringlib.stringfind(unparsedRec,'|',26)+1..stringlib.stringfind(unparsedRec,'|',27)-1];
	SELF := L;
 END;
 ds_vehicles := PROJECT(vehicles_in(REGEXFIND('[0-9]',line)), parserecs(LEFT)); 
 d_vehicles := DISTRIBUTE(ds_vehicles, HASH32(vehicle_incident_id));
 dd_inc := DEDUP(SORT(DISTRIBUTE(rm_Inc(vehicle_incident_id <> ''),HASH32(vehicle_incident_id))
	                    ,vehicle_incident_id,(last_changed[7..10]+ last_changed[1..2]+ last_changed[4..5]),local)
								 ,vehicle_incident_id, right,local);

 flaccidents.Layout_NtlAccidents_Alpharetta.vehicles updatevehicles(d_vehicles L, dd_inc R) := TRANSFORM
																																														       SELF := L;
																																														    END;

 rm_Vehicles := JOIN(d_vehicles, dd_inc,
                     TRIM(LEFT.vehicle_incident_id, LEFT, RIGHT) = TRIM(RIGHT.vehicle_incident_id, LEFT, RIGHT),
								     updatevehicles(LEFT,RIGHT), INNER, LOCAL):INDEPENDENT;
 
 SequencingRecSummary xformCtr_vehicles(rm_Vehicles L, INTEGER CTR) := TRANSFORM
	   SELF.recid            	:= CTR;
		 SELF.LINE             	:= TRIM('"' + TRIM(L.VEHICLE_ID, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.VEHICLE_INCIDENT_ID, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.VEHICLE_NBR, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.VEHICLE_STATUS, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.vehVIN, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.vehYEAR, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.vehMAKE, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.vehMODEL, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.ODOMETER, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.TAG, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.TAG_STATE, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.COLOR, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.IMPACT_LOCATION, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.POLICY_NBR, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.POLICY_EXP_DATE, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.CARRIER_ID, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.OTHER_CARRIER, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.COMMERCIAL_VIN, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.CAR_FIRE, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.AIRBAGS_DEPLOY, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.CAR_TOWED, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.CAR_ROLLOVER, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.DECODED_INFO, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.LAST_CHANGED, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.USERID, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.DAMAGE, LEFT, RIGHT) + '"' + ',' +
					'"' + TRIM(L.POLK_VALIDATED_VIN, LEFT, RIGHT) + '"', LEFT, RIGHT); 
  END;

	ExtractData_vehicles      := PROJECT(rm_Vehicles, xformCtr_vehicles(LEFT, COUNTER));
	ExtractHeaderRec_vehciles := DATASET([{0, VehiclesHeader}], SequencingRecSummary);
	FORMATTEDFINALA_vehicles  := BigLineFormatDespray(ExtractData_vehicles & ExtractHeaderRec_vehciles, 'FL_NtlAccInq_Vehicles.CSV');
	
	//Party input file
  ds_party := DATASET(data_services.foreign_prod + 'thor_data400::in::flcrash::alpharetta::vehicle_party_new'
										 ,flaccidents.Layout_NtlAccidents_Alpharetta.party
										 ,CSV(TERMINATOR('\n'), SEPARATOR(',')))(PARTY_ID != 'PARTY_ID');								 
	d_party := DISTRIBUTE(ds_party, HASH32(vehicle_incident_id,vehicle_id));
	dd_veh_vehid := DEDUP(SORT(DISTRIBUTE(rm_Vehicles(TRIM(vehicle_incident_id, LEFT, RIGHT)<> ''),HASH32(vehicle_incident_id,vehicle_id)), 
	                           vehicle_id ,-(last_changed[7..10]+last_changed[1..2]+last_changed[4..5]), LOCAL)
												,vehicle_id, LOCAL);
	
	flaccidents.Layout_NtlAccidents_Alpharetta.party updateParty(d_party L, rm_Vehicles R) := TRANSFORM
																																														  SELF := L;
																																												     END;
  rm_Party := JOIN(d_party, dd_veh_vehid,
	                 TRIM(LEFT.vehicle_incident_id, LEFT, RIGHT) = TRIM(RIGHT.vehicle_incident_id, LEFT, RIGHT) and
								   TRIM(LEFT.vehicle_id, LEFT, RIGHT) = TRIM(RIGHT.vehicle_id, LEFT, RIGHT),
								   updateParty(LEFT,RIGHT), INNER, LOCAL);
  
	SequencingRecSummary xformCtr_party(rm_Party L, INTEGER CTR) := TRANSFORM
	   SELF.recid            	:= CTR;
		 SELF.LINE             	:= TRIM('"' + TRIM(L.PARTY_ID, LEFT, RIGHT) + '"' + ',' +
							'"' + TRIM(L.PARTY_TYPE, LEFT, RIGHT) + '"' + ',' +
							'"' + TRIM(L.VEHICLE_ID, LEFT, RIGHT) + '"' + ',' +
							'"' + TRIM(L.VEHICLE_INCIDENT_ID, LEFT, RIGHT) + '"' + ',' +
							'"' + TRIM(L.FIRST_NAME, LEFT, RIGHT) + '"' + ',' +
							'"' + TRIM(L.LAST_NAME, LEFT, RIGHT) + '"' + ',' +
							'"' + TRIM(L.BUSINESS_NAME, LEFT, RIGHT) + '"' + ',' +
							'"' + TRIM(L.pty_DRIVERS_LICENSE, LEFT, RIGHT) + '"' + ',' +
							'"' + TRIM(L.pty_DRIVERS_LICENSE_ST, LEFT, RIGHT) + '"' + ',' +
							'"' + TRIM(L.DOB, LEFT, RIGHT) + '"' + ',' +
							'"' + TRIM(L.LAST_CHANGED, LEFT, RIGHT) + '"' + ',' +
							'"' + TRIM(L.USERID, LEFT, RIGHT) + '"', LEFT, RIGHT); 
    END;

	ExtractData_party         := PROJECT(rm_Party, xformCtr_party(LEFT, COUNTER));
	ExtractHeaderRec_party  	:= DATASET([{0, PartyHeader}], SequencingRecSummary);
	FORMATTEDFINALA_party 		:= BigLineFormatDespray(ExtractData_party & ExtractHeaderRec_party, 'FL_NtlAccInq_Party.CSV');	
	
	Write_Output_Files := SEQUENTIAL(FORMATTEDFINALA_ordervs, FORMATTEDFINALA_result, FORMATTEDFINALA_inc, FORMATTEDFINALA_client, FORMATTEDFINALA_vehicles, FORMATTEDFINALA_party); 
	
 RETURN Write_Output_Files;
END;

