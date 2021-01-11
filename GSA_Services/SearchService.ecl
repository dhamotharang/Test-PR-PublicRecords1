// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- Returns GSA Excluded Parties / Verifications Search records.*/
import iesp, AutoStandardI, std;

export SearchService := macro

		ds_in := DATASET ([], iesp.gsaverification.t_GSAVerificationRequest) : STORED ('GSAVerificationRequest', FEW);

		first_row := ds_in[1] : independent;
		iesp.ECL2ESP.SetInputBaseRequest (first_row);
		iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);
		search_by := global (first_row.SearchBy);
		iesp.ECL2ESP.SetInputNameCompanyName(search_by.Name);
   iesp.ECL2ESP.SetInputAddress (search_by.Address);
		iesp.ECL2ESP.SetInputSearchOptions (first_row.options);
		#stored ('PenaltThreshold', first_row.options.PenaltyThreshold);

			tmp								:=AutoStandardI.GlobalModule();
			in_mod  					:= module (project (tmp,GSA_Services.Functions.params,  opt))
        export string5 name_suffix := '' : stored ('NameSuffix');
			end;

	  StartDate  := iesp.ECL2ESP.t_DateToString8(search_by.ActionDateRange.StartDate);
		EndDate    := iesp.ECL2ESP.t_DateToString8(search_by.ActionDateRange.EndDate);

		is_valid_dateinput := (StartDate = '' or STD.DATE.IsValidDate((UNSIGNED4)StartDate))
		                      and (EndDate = '' or STD.DATE.IsValidDate((UNSIGNED)EndDate));

    IF(~is_valid_dateinput, FAIL('An error occurred while running GSA_Services.SearchService: invalid input dates.') );

		inputData := GSA_Services.Functions.fn_getInputData(in_mod);
		// search and return results record structure
		ds_all_recs := project(choosen(GSA_Services.BatchService_Records(inputData,0,StartDate,EndDate).ds_outRecs,iesp.constants.MAX_GSA_VERIFICATION_RESPONSE_RECORDS),iesp.gsaverification.t_GSAVerificationRecord);

		// apply final iesp response layout.
		iesp.ECL2ESP.Marshall.MAC_Marshall_Results(ds_all_recs, results, iesp.gsaverification.t_GSAVerificationResponse);

		// display the final response.
		output(results, named('Results'));
endmacro;
