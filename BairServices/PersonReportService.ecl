/*--SOAP--
<message name="CompReportService">
  <part name="BAIRPersonReportRequest" type="tns:XmlDataSet" cols="70" rows="25"/>  
</message>
*/

EXPORT PersonReportService := MACRO
	import iesp, BairRx_Common, BairRx_PSS, ut;
	dIn := DATASET([], iesp.bair_person.t_BAIRPersonReportRequest) : STORED('BAIRPersonReportRequest', FEW);
	first_row := dIn[1] : independent;	

	options := GLOBAL(first_row.options);
	user := GLOBAL(first_row.user);
	reportBy := GLOBAL(first_row.reportBy);
				
	BairRx_PSS.IParam.SetReportOptions(options);	
	BairRx_PSS.IParam.SetInputUser(user);
	
	max_results := ut.min2(options.MaxResults, BairRx_Common.Constants.DEFAULT_MAX_RPT_RESULT);
	input_params := BairRx_PSS.IParam.GetPersonReportParams(reportBy, options, user); 	
	dReportRec := BairRx_PSS.PersonReportRecords(input_params, max_results, options.includeNotes);
	
	//iesp.ECL2ESP.Marshall.MAC_Marshall_Results(dReportRec, results, iesp.bair_person.t_BAIRPersonReportResponse);
	output(dReportRec, named('Results'));

ENDMACRO;