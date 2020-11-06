// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- Returns concealed weapon Search records.*/
import CCW_services, iesp, AutoStandardI;

export SearchService := macro

 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);

    rec_in := iesp.concealedWeapon.t_WeaponSearchRequest;
    ds_in := DATASET ([], rec_in) : STORED ('WeaponSearchRequest', FEW);
		 first_row := ds_in[1] : independent;
    //set options

		iesp.ECL2ESP.SetInputBaseRequest (first_row);
    iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

    //set main search criteria:
		search_by := global (first_row.SearchBy);
    iesp.ECL2ESP.SetInputSearchOptions (first_row.options);
	  iesp.ECL2ESP.SetInputReportBy(row(first_row.searchby,transform(iesp.bpsreport.t_BpsReportBy,self:=left,self:=[])));

	  input_params := AutoStandardI.GlobalModule();
		tempmod := module(project(input_params,CCW_services.SearchService_Records.params,opt))
			EXPORT STRING32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
			EXPORT STRING5 IndustryClass := AutoStandardI.InterfaceTranslator.industry_class_value.val (project(input_params,AutoStandardI.InterfaceTranslator.industry_class_value.params));
		end;

		tmpresults := CCW_services.SearchService_Records.search(tempmod);
		iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tmpresults.Records, results, iesp.concealedweapon.t_WeaponSearchResponse);
		output(results, named('Results'));

endmacro;
