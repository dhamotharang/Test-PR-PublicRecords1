import iesp, InstantID_Archiving, Doxie, Gateway;
/*This attribute retrieves data for  the instantId archiving and reporting project. 
	- retrieves data for the search_service 
	- with the minimum criteria being first and last name.
	- uses autokeys to match on key data for PII
*/

EXPORT IIDI2_Search_Records := MODULE
	EXPORT doSingleSearch(IParam.IIDI2_search_params in_mod, DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION	
		// 1. By Deltabase query.
		ds_search_by_DB := Raw.singleIIDI2SearchViaDeltaBase(in_mod, dGateways);

		//fill in names and addresses for db records		
		ds_Search_NamesAddrs_from_DB := PROJECT(ds_search_by_DB, Transforms.FillNamesAddrsFromIIDI2DBRecs(left, 1));
		
		// 2. base filter for keys
		//need to add company to index?
		ds_Base_Key_Search := Raw.singleSearchViaIIDI2keys(in_mod);  //transaction id, company, product, country, first, last,
		
		//filter off by product
		ds_Search_filter_Keys :=	Functions.mac_filterByIIDI2KeyFields(ds_Base_Key_Search);
		
		ds_formated_keys := Project(ds_Search_filter_Keys,
																Transform(Layouts.Single_IIDI2_DeNormed_Records, 
																self.exceptions := [],
																self.transactionid := left.transaction_id,
																self.queryid := left.query_id,
																self.first_name := left.orig_fname,
																self.middle_name := left.orig_mname,
																self.last_name := left.orig_lname,
																self.full_name := left.fullname,
																self.street_number := left.orig_address_number,
																self.street_name := left.orig_address,
																self.street_type := left.orig_address_type,
																self.city := left.orig_city,
																self.state := left.orig_state,
																self.postal_code := left.orig_zip,
																self.telephone := left.phone,
																self:=left));
		
		//Project to matching layout
		ds_Search_NamesAddrs_from_Keys := PROJECT(ds_formated_keys, Transforms.FillNamesAddrsFromIIDI2DBRecs(left, 2));
		// 3. Combine, sort, dedup; transform into final layout.
		ds_Search_NamesAddrs := 
				DEDUP( SORT( (ds_Search_NamesAddrs_from_DB + ds_Search_NamesAddrs_from_Keys), TransactionId, RECORD )
							, TransactionId );
							
		//display a database error if an error occurs
		ds_Db_errors := Macros.mac_GetDisplayRowErrors(ds_search_by_DB.exceptions.exceptions[1].message,//doxie.ErrorCodes(0),
											iesp.iidi2archivesearch.t_InstantIDIntl2ArchiveSearchResponse);
		// ds_search_nonErrors:= PROJECT(ds_Search_NamesAddrs, 
		ds_search_nonErrors:= PROJECT(ds_Search_NamesAddrs, 
								TRANSFORM(iesp.iidi2archivesearch.t_InstantIDIntl2ArchiveSearchRecord, 
								SELF := LEFT)); 
		//put data in a row for final output
		iesp.iidi2archivesearch.t_InstantIDIntl2ArchiveSearchResponse SetFinalOutput() := TRANSFORM
						SELF.Records := CHOOSEN(ds_search_nonErrors, iesp.Constants.IIDReporting.MaxSearchRecords);							
						SELF._Header := iesp.ECL2ESP.GetHeaderRow();
						SELF.RecordCount := count(ds_search_nonErrors);
		END;
		ds_search_out := ROW(SetFinalOutput());
		ds_too_many_results := Macros.mac_GetDisplayRowErrors(doxie.ErrorCodes(203),
						iesp.iidi2archivesearch.t_InstantIDIntl2ArchiveSearchResponse);					
		//if database errors or exceeds record limit, then display them otherwise, return the results
		ds_search_response := map(ds_search_by_DB.exceptions.exceptions[1].message != '' => ds_Db_errors, 
														count(ds_search_nonErrors) >= iesp.Constants.IIDReporting.MaxSearchRecords => ds_too_many_results,
														ds_search_out);
		//Create empty dataset in case minimum criteria wasn't entered - could send in 301 if want insufficient input returned
		ds_no_minimum_input := Macros.mac_GetDisplayRowErrors(doxie.ErrorCodes(301),
						iesp.iidi2archivesearch.t_InstantIDIntl2ArchiveSearchResponse);
		//make sure the miniumum input was entered		
		ds_search_results := if(in_mod.NewFirstName != '' and in_mod.NewLastName != '' and in_mod.CompanyId != '' and in_mod.CountryId != '', 
								ds_search_response, ds_no_minimum_input);
		
		//*******Testing Outputs**************
		// output(in_mod);
		// output(ds_search_by_DB, named('ds_search_by_DB'));
		// output(ds_Search_NamesAddrs_from_DB, named('ds_Search_NamesAddrs_from_DB'));
		// output(ds_Base_Key_Search, named('ds_Base_Key_Search'));
		// output(ds_Search_filter_Keys, named('ds_Search_filter_Keys'));
		//************************************
		
		RETURN ds_search_results;

	END;
END;