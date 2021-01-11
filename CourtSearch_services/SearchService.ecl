// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
import CourtSearch_services, iesp, AutoStandardI;

export SearchService := macro
  #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
    //read ESP input values into ECL "standard" names
		// iesp.ECL2ESP.MAC_ReadESPInput();

    rec_in := iesp.CourtSearchAdviser.t_CourtSearchAdviserRequest;
    ds_in := DATASET ([], rec_in) : STORED ('CourtSearchAdviserRequest', FEW);
		first_row := ds_in[1] : independent;
    //set options

		iesp.ECL2ESP.SetInputBaseRequest (first_row);
    iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);
		iesp.ECL2ESP.SetInputSearchOptions (first_row.options);

    //set main search criteria:
		search_by := global (first_row.SearchBy);

	  string12 UniqueId := trim(search_by.UniqueID);
    #stored('did', UniqueId);


		#stored('useLevels', TRUE); //:= true;
		#stored('useSupergroup', TRUE);// := true;  setting this forces the bdid_dataset.val to possible allow multiple bdid values.

		string BusinessID := trim(search_by.BusinessID);
		#stored('bdid', BusinessID);

    input_params := AutoStandardI.GlobalModule();
		tempmod := module(project(input_params,CourtSearch_services.SearchService_Records.params,opt))
			export string32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
		end;

		tmp := CourtSearch_services.SearchService_Records.val(tempmod);

		iesp.courtsearchAdviser.t_courtSearchAdviserResponse format_out () := transform
			self._Header := iesp.ECL2ESP.getHeaderRow();
			self._Record := tmp[1];
		end;

		results := dataset ([Format_out ()]);

		output(results, named('Results'));

endmacro;
