// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
import ATF_services, iesp, AutoStandardI, WSInput;

export SearchService := MACRO

 #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);

    //The following macro defines the field sequence on WsECL page of query.
    WSInput.MAC_ATF_Services_SearchService();

    rec_in := iesp.firearm.t_FirearmSearchRequest;
    ds_in := DATASET ([], rec_in) : STORED ('FirearmSearchRequest', FEW);
    first_row := ds_in[1] : independent;

    //set options
    iesp.ECL2ESP.SetInputBaseRequest (first_row);
    iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);
    #stored('includeCriminalIndicators',first_row.options.includeCriminalIndicators);

    //set main search criteria:
    search_by := global (first_row.SearchBy);
    #stored ('TradeName', search_by.TradeName);
    #stored ('ATFLicenseNumber', search_by.LicenseNumber);
    #stored ('SSN', search_by.SSN);
    iesp.ECL2ESP.SetInputName (search_by.Name);
    iesp.ECL2ESP.SetInputAddress (search_by.Address);
    iesp.ECL2ESP.SetInputSearchOptions (first_row.options);

    input_params := AutoStandardI.GlobalModule();
    tempmod := module(project(input_params,ATF_Services.IParam.search_params,opt))
      EXPORT string15 license_number := '' : stored('ATFLicenseNumber');
      EXPORT string120 companyname := '' : stored('TradeName');
      Export string32 applicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
      EXPORT boolean IncludeCriminalIndicators := false : stored('IncludeCriminalIndicators');
    end;
    atf_recs := ATF_Services.SearchService_Records.search(tempmod, false);

    iesp.ECL2ESP.Marshall.MAC_Marshall_Results(atf_recs.records, results, iesp.firearm.t_FirearmSearchResponse);
    output(results, named('Results'));

ENDMACRO;
