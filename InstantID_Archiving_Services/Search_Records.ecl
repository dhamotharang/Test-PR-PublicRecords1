import iesp, InstantID_Archiving, Doxie, Gateway;
/*This attribute retrieves data for  the instantId archiving and reporting project. 
	- retrieves data for the search_service 
	- with the minimum criteria being first and last name.
	- uses autokeys to match on key data for PII
*/

EXPORT Search_Records := MODULE
	EXPORT doSingleSearch(IParam.search_params in_mod, DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION
		search_type  := Functions.SetProductType(in_mod.ProductType);		
		// 1. By Deltabase query.
		ds_search_by_DB := Raw.singleSearchViaDeltaBase(in_mod, search_type, dGateways);
		//fill in names and addresses for db records		
		ds_Search_NamesAddrs_from_DB := PROJECT(ds_search_by_DB, Transforms.FillNamesAddrsFromDBRecs(left));
		// 2. By Autokey search. Project into layout_base to pass successfully as a parameter.
		ds_search_by_AK_pre := Raw.singleSearchViaAutokeys(in_mod, search_type);
		//filter off by product
		ds_search_by_AK_filtered :=	Functions.mac_filterByNonAutoKeyFields(ds_search_by_AK_pre, search_type);
		ds_search_by_AK  := PROJECT(ds_search_by_AK_filtered, TRANSFORM(InstantID_Archiving.Layout_Base, SELF := LEFT));		
		//fill in nams and addresses for Autokeys
		ds_Search_NamesAddrs_from_AK := 
				PROJECT(ds_search_by_AK, Transforms.FillNamesAddrsFromAKRecs(left));
		// 3. Combine, sort, dedup; transform into final layout.
		ds_Search_NamesAddrs := 
				DEDUP( SORT( (ds_Search_NamesAddrs_from_DB + ds_Search_NamesAddrs_from_AK), TransactionId, RECORD )
							, TransactionId );
		//display a database error if an error occurs
		ds_Db_errors := Macros.mac_GetDisplayRowErrors(ds_search_by_DB.exceptions.exceptions[1].message,//doxie.ErrorCodes(0),
											iesp.iidarchivesearch.t_InstantIDArchiveSearchResponse);
		ds_search_nonErrors:= PROJECT(ds_Search_NamesAddrs, 
								TRANSFORM(iesp.iidarchivesearch.t_InstantIDArchiveSearchRecord, 
								SELF := LEFT)); 
		//put data in a row for final output
		iesp.iidarchivesearch.t_InstantIDArchiveSearchResponse SetFinalOutput() := TRANSFORM
						SELF.Records := CHOOSEN(ds_search_nonErrors, iesp.Constants.IIDReporting.MaxSearchRecords);							
						SELF._Header := iesp.ECL2ESP.GetHeaderRow();
						SELF.RecordCount := count(ds_search_nonErrors);
		END;
		ds_search_out := ROW(SetFinalOutput());
		ds_too_many_results := Macros.mac_GetDisplayRowErrors(doxie.ErrorCodes(203),
						iesp.iidarchivesearch.t_InstantIDArchiveSearchResponse);					
		//if database errors or exceeds record limit, then display them otherwise, return the results
		ds_search_response := map(ds_search_by_DB.exceptions.exceptions[1].message != '' => ds_Db_errors, 
														count(ds_search_nonErrors) >= iesp.Constants.IIDReporting.MaxSearchRecords => ds_too_many_results,
														ds_search_out);
		//Create empty dataset in case minimum criteria wasn't entered - could send in 301 if want insufficient input returned
		ds_no_minimum_input := Macros.mac_GetDisplayRowErrors(doxie.ErrorCodes(301),
						iesp.iidarchivesearch.t_InstantIDArchiveSearchResponse);				
		//make sure the miniumum input was entered		
		ds_search_results := if(in_mod.firstname != '' and in_mod.lastname != '' and in_mod.CompanyId != '', 
								ds_search_response, ds_no_minimum_input);
		RETURN ds_search_results;
	END;
END;