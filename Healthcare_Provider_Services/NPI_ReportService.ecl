// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- This service pulls from the NPPES files.*/
import iesp, AutoStandardI;

EXPORT NPI_ReportService := MACRO
	ds_in := DATASET ([], iesp.npireport.t_NPIReportRequest) : STORED('NPIReportRequest', FEW);

	first_row := ds_in[1] : INDEPENDENT;
	iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);
	iesp.ECL2ESP.SetInputSearchOptions(first_row.options);
	iesp.ECL2ESP.SetInputReportBy (ROW (first_row.reportBy, transform (iesp.bpsreport.t_BpsReportBy, Self := Left, Self := [])));
	// string11 Fein       := trim(first_row.ReportBy.Taxid);
	// #stored('Fein', Fein);
  STRING CompanyName := trim(first_row.ReportBy.CompanyName);
	#STORED('CompanyName', CompanyName);
	unsigned1 PenaltThreshold := if(first_row.Options.penaltythreshold>0,first_row.Options.penaltythreshold,10);
	#stored ('PenaltThreshold', PenaltThreshold);
  STRING npi_number := '' : STORED('NPINumber');
	input_params := AutoStandardI.GlobalModule();
	tmpMod:= MODULE(PROJECT(input_params, Healthcare_Provider_Services.IParams.searchParams,opt))
		EXPORT unsigned2 	penalty_threshold := PenaltThreshold;
		EXPORT STRING 		NPI := IF(npi_number <> '', npi_number, first_row.reportBy.NPINumber);
		// EXPORT string11 	Fein := AutoStandardI.InterfaceTranslator.fein_val.val(project(input_params, AutoStandardI.InterfaceTranslator.fein_val.params));
		EXPORT STRING30 	LastName := AutoStandardI.InterfaceTranslator.lname_value.val(project(input_params, AutoStandardI.InterfaceTranslator.lname_value.params));
		EXPORT STRING30 	FirstName := AutoStandardI.InterfaceTranslator.fname_value.val(project(input_params, AutoStandardI.InterfaceTranslator.fname_value.params));
		EXPORT STRING30 	MiddleName := AutoStandardI.InterfaceTranslator.mname_value.val(project(input_params, AutoStandardI.InterfaceTranslator.mname_value.params));
		EXPORT string120 	CompanyName := AutoStandardI.InterfaceTranslator.company_name.val(project(input_params, AutoStandardI.InterfaceTranslator.company_name_value.params));
		EXPORT boolean 		isReport := first_row.options.isReport;
	END;

	results := Healthcare_Provider_Services.NPI_ReportService_Records(tmpMod);

	final_results := project(results, transform(iesp.npireport.t_NPIReportResponse,
																						self.InputEchoReportBy :=  first_row.ReportBy,
																						self:=left));
	output(final_results, named('Results'));

ENDMACRO;
