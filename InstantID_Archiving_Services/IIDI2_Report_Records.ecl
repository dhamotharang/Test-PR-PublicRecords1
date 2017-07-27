import iesp, InstantID_Archiving, std, suppress, doxie, Gateway;
/*This attribute retrieves data for  the instantId archiving and reporting project. 
		- retrieves data for the IIDI2_search_service. 
		- with the minimum criteria being CompanyId and (first and last name) or transaction_id.
		- the ESP layer will decode the blob fields sent back to the user
*/

EXPORT IIDI2_Report_Records := MODULE
	EXPORT doSingleReport(IParam.IIDI2_search_params in_mod, DATASET(Gateway.Layouts.Config) dGateways, iesp.iidi2singlereport.t_InstantIDIntl2ArchiveSingleReportSearchBy search_by) := FUNCTION
		// search_type  := Functions.SetProductType(in_mod.ProductType);		
		// Echo data
		ds_input :=	search_by;
		
		// By DeltaBase query 
		ds_report_by_DB := Raw.singleIIDI2ReportViaDeltaBase(in_mod, dGateways);	
		ds_Report_DB_inputandblobs := PROJECT(ds_report_by_DB, Transforms.denorm_report_IIDI2_DB_inputandblobs(left));

		// By Autokeys search. 
		ds_Base_Key_Search := Raw.singleReportSearchViaIIDI2keys(in_mod);  //transaction id, company, product, country, first, last,
		
		//filter off by product
		ds_report_by_AK_filtered :=	Functions.mac_filterByIIDI2KeyFields(ds_Base_Key_Search);
		
	REPORT := project(InstantID_Archiving.Key_Report(transaction_id = ds_report_by_AK_filtered[1].transaction_id), 
		transform(Layouts.delta_single_report_blob, 
					SELF.transactionid   := LEFT.transaction_id,
					self.requestdata := trim((string) left.request_data),
					self.responsedata := trim((string) left.response_data),
					self := []));
		ds_report_by_AK := 
			JOIN(
				ds_report_by_AK_filtered,  REPORT,
				LEFT.transaction_id = RIGHT.transactionid,
				 TRANSFORM( Layouts.delta_single_report_blob,
					 SELF.transactionid   := LEFT.transaction_id,
					SELF.date_added      := LEFT.date_added,
					SELF.companyid       := LEFT.company_id,
					SELF.companyidsource := (INTEGER)LEFT.company_id_source,
					SELF.espversion      := LEFT.version,
					SELF.source          := LEFT.source,
					self.requestdata := trim(RIGHT.requestdata),
					self.responsedata := trim(RIGHT.responsedata),
					SELF.Queryid				 := LEFT.query_id,
					self := [];
				),
				INNER, ATMOST(100)
			);

	REPORT1 := project(InstantID_Archiving.Key_Report1(transaction_id = ds_report_by_AK_filtered[1].transaction_id), 
		transform(Layouts.delta_single_report_blob, 
					SELF.transactionid   := LEFT.transaction_id,
					self.requestdata := trim((string) left.request_data),
					self.responsedata := trim((string) left.response_data),
					self := []));
	ds_report_by_AK1 := 
			JOIN(
				ds_report_by_AK,  REPORT1,
				LEFT.transactionid = RIGHT.transactionid,
				 TRANSFORM( Layouts.delta_single_report_blob,
					 SELF.transactionid   := LEFT.transactionid,
					SELF.date_added      := LEFT.date_added,
					SELF.companyid       := LEFT.companyid,
					SELF.companyidsource := (INTEGER)LEFT.companyidsource,
					SELF.espversion      := LEFT.espversion,
					SELF.source          := LEFT.source,
					self.requestdata := TRIM(LEFT.requestdata) + trim(RIGHT.requestdata),
					self.responsedata := trim(LEFT.responsedata) + trim(RIGHT.responsedata),
					SELF.Queryid				 := LEFT.queryid,
					self := [];
				),
				INNER, ATMOST(100)
			);			
	REPORT2 := project(InstantID_Archiving.Key_Report2(transaction_id = ds_report_by_AK_filtered[1].transaction_id), 
		transform(Layouts.delta_single_report_blob, 
					SELF.transactionid   := LEFT.transaction_id,
					self.requestdata := trim((string) left.request_data),
					self.responsedata := trim((string) left.response_data),
					self := []));
	ds_report_by_AK2 := 
			JOIN(
				ds_report_by_AK1,  REPORT2,
				LEFT.transactionid = RIGHT.transactionid,
				 TRANSFORM( Layouts.delta_single_report_blob,
					 SELF.transactionid   := LEFT.transactionid,
					SELF.date_added      := LEFT.date_added,
					SELF.companyid       := LEFT.companyid,
					SELF.companyidsource := (INTEGER)LEFT.companyidsource,
					SELF.espversion      := LEFT.espversion,
					SELF.source          := LEFT.source,
					self.requestdata := TRIM(LEFT.requestdata) + trim(RIGHT.requestdata),
					self.responsedata := trim(LEFT.responsedata) + trim(RIGHT.responsedata),
					SELF.Queryid				 := LEFT.queryid,
					self := [];
				),
				INNER, ATMOST(100)
			);
	REPORT3 := project(InstantID_Archiving.Key_Report3(transaction_id = ds_report_by_AK_filtered[1].transaction_id), 
		transform(Layouts.delta_single_report_blob, 
					SELF.transactionid   := LEFT.transaction_id,
					self.requestdata := trim((string) left.request_data),
					self.responsedata := trim((string) left.response_data),
					self := []));
	ds_report_by_AK3 := 
			JOIN(
				ds_report_by_AK2,  REPORT3,
				LEFT.transactionid = RIGHT.transactionid,
				 TRANSFORM( Layouts.delta_single_report_blob,
					 SELF.transactionid   := LEFT.transactionid,
					SELF.date_added      := LEFT.date_added,
					SELF.companyid       := LEFT.companyid,
					SELF.companyidsource := (INTEGER)LEFT.companyidsource,
					SELF.espversion      := LEFT.espversion,
					SELF.source          := LEFT.source,
					self.requestdata := TRIM(LEFT.requestdata) + trim(RIGHT.requestdata),
					self.responsedata := trim(LEFT.responsedata) + trim(RIGHT.responsedata),
					SELF.Queryid				 := LEFT.queryid,
					self := [];
				),
				INNER, ATMOST(100)
			);
	REPORT4 := project(InstantID_Archiving.Key_Report4(transaction_id = ds_report_by_AK_filtered[1].transaction_id), 
		transform(Layouts.delta_single_report_blob, 
					SELF.transactionid   := LEFT.transaction_id,
					self.requestdata := trim((string) left.request_data),
					self.responsedata := trim((string) left.response_data),
					self := []));
	ds_report_by_AK4 := 
			JOIN(
				ds_report_by_AK3,  REPORT4,
				LEFT.transactionid = RIGHT.transactionid,
				 TRANSFORM( Layouts.delta_single_report_blob,
					 SELF.transactionid   := LEFT.transactionid,
					SELF.date_added      := LEFT.date_added,
					SELF.companyid       := LEFT.companyid,
					SELF.companyidsource := (INTEGER)LEFT.companyidsource,
					SELF.espversion      := LEFT.espversion,
					SELF.source          := LEFT.source,
					self.requestdata := TRIM(LEFT.requestdata) + trim(RIGHT.requestdata),
					self.responsedata := trim(LEFT.responsedata) + trim(RIGHT.responsedata),
					SELF.Queryid				 := LEFT.queryid,
					self := [];
				),
				INNER, ATMOST(100)
			);
	REPORT5 := project(InstantID_Archiving.Key_Report5(transaction_id = ds_report_by_AK_filtered[1].transaction_id), 
		transform(Layouts.delta_single_report_blob, 
					SELF.transactionid   := LEFT.transaction_id,
					self.requestdata := trim((string) left.request_data),
					self.responsedata := trim((string) left.response_data),
					self := []));
	ds_report_by_AK5 := 
			JOIN(
				ds_report_by_AK4,  REPORT5,
				LEFT.transactionid = RIGHT.transactionid,
				 TRANSFORM( Layouts.delta_single_report_blob,
					 SELF.transactionid   := LEFT.transactionid,
					SELF.date_added      := LEFT.date_added,
					SELF.companyid       := LEFT.companyid,
					SELF.companyidsource := (INTEGER)LEFT.companyidsource,
					SELF.espversion      := LEFT.espversion,
					SELF.source          := LEFT.source,
					self.requestdata := TRIM(LEFT.requestdata) + trim(RIGHT.requestdata),
					self.responsedata := trim(LEFT.responsedata) + trim(RIGHT.responsedata),
					SELF.Queryid				 := LEFT.queryid,
					self := [];
				),
				INNER, ATMOST(100)
			);
	REPORT6 := project(InstantID_Archiving.Key_Report6(transaction_id = ds_report_by_AK_filtered[1].transaction_id), 
		transform(Layouts.delta_single_report_blob, 
					SELF.transactionid   := LEFT.transaction_id,
					self.requestdata := trim((string) left.request_data),
					self.responsedata := trim((string) left.response_data),
					self := []));
	ds_report_by_AK6 := 
			JOIN(
				ds_report_by_AK5,  REPORT6,
				LEFT.transactionid = RIGHT.transactionid,
				 TRANSFORM( Layouts.delta_single_report_blob,
					 SELF.transactionid   := LEFT.transactionid,
					SELF.date_added      := LEFT.date_added,
					SELF.companyid       := LEFT.companyid,
					SELF.companyidsource := (INTEGER)LEFT.companyidsource,
					SELF.espversion      := LEFT.espversion,
					SELF.source          := LEFT.source,
					self.requestdata := TRIM(LEFT.requestdata) + trim(RIGHT.requestdata),
					self.responsedata := trim(LEFT.responsedata) + trim(RIGHT.responsedata),
					SELF.Queryid				 := LEFT.queryid,
					self := [];
				),
				INNER, ATMOST(100)
			);

		AK_all_reportInfo :=	PROJECT(ds_report_by_AK6, 
				TRANSFORM( Layouts.Report_DeNormed_Records, 
					SELF := LEFT,
					SELF.Exceptions      := [],
					SELF := []));
					
	 ds_Report_AK_inputandblobs	:=	
 			PROJECT(AK_all_reportInfo, Transforms.denorm_report_IIDI2_Keys_inputandblobs(left)); 

	ds_Report_inputandblobs := 
		DEDUP( SORT( (ds_Report_DB_inputandblobs +ds_Report_AK_inputandblobs), transactionid, RECORD ), transactionid );
		
		//get count of records in the dataset
		cnt_Report := count(ds_Report_inputandblobs);
		ds_Report_inputandblobsWithCntr := PROJECT(ds_Report_inputandblobs,
				TRANSFORM(Layouts.denorm_IIDI2_inputandblobs, SELF.RecordCount := cnt_Report, SELF := LEFT));			
		//if a Db error then display the error and don't just return the autokeys
		ds_report_by_DBWithExceptions :=PROJECT(ds_report_by_DB, 
			TRANSFORM(Layouts.denorm_IIDI2_inputandblobs, SELF.Header := LEFT.exceptions, self := LEFT, SELF := []));
		//put data in final layout almost
		db_error := ds_report_by_DBWithExceptions.Header.exceptions[1].message;
		ds_report_tmp := if(db_error != '', 
			ds_report_by_DBWithExceptions, ds_Report_inputandblobsWithCntr);
			
		iesp.iidi2singlereport.t_InstantIDIntl2ArchiveSingleReportResponse final_REPORT_response(Layouts.denorm_IIDI2_inputandblobs l)	:= TRANSFORM
			SELF.Result := PROJECT(l, TRANSFORM(iesp.iidi2singlereport.t_InstantIDIntl2ArchiveSingleReportRecord, 
													SELF := LEFT, SELF := [])); 
			SELF._Header := PROJECT(L, TRANSFORM(iesp.share.t_ResponseHeader, SELF.Exceptions := LEFT.Header.Exceptions, self := LEFT, SELF := []));
			checkForErrors := if(db_error = '', ds_input);//, DATASET([], Layouts.Layout_in));
			// SELF.InputEcho := PROJECT(checkForErrors, Transforms.IIDI2InputToBeEchoed(LEFT));			
			SELF.InputEcho := checkForErrors;			
			SELF := L;
		END;
		ds_Report_response := PROJECT(ds_report_tmp, final_REPORT_response(LEFT));
	//make sure the miniumum input was entered - could send in 301 if want insufficient input returned
		ds_no_minimum_input := Macros.mac_GetDisplayErrors(301, iesp.iidi2singlereport.t_InstantIDIntl2ArchiveSingleReportResponse);				
		ds_report_results_tmp := if((in_mod.CompanyId != '' and in_mod.CountryId != '' and ((in_mod.newfirstname != '' and in_mod.newlastname != '')
						or in_mod.transactionId != '')), ds_Report_response, ds_no_minimum_input);
		//when more than 1 record is entered using PII, display an error.
		report_output_cnt := COUNT(ds_report_results_tmp);
		ds_output_with_error := Macros.mac_GetDisplayErrors(203, iesp.iidi2singlereport.t_InstantIDIntl2ArchiveSingleReportResponse);
		ds_report_results := if(in_mod.TransactionId = '' and report_output_cnt > 1, ds_output_with_error, ds_report_results_tmp);
		
		//*******Testing Outputs*************************
		// output(ds_input,named('ds_input'));
		// output(ds_report_by_DB,named('ds_report_by_DB'));
		// output(ds_Report_DB_inputandblobs,named('ds_Report_DB_inputandblobs'));
		// output(ds_Report_inputandblobs,named('ds_Report_inputandblobs'));
		// output(ds_report_by_AK_filtered,named('ds_report_by_AK_filtered'));
		// output(ds_report_tmp,named('ds_report_tmp'));
		//***********************************************
		
		RETURN ds_report_results;

	END;
END;