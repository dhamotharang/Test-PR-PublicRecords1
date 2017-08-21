/*--SOAP--
<message name="CFSReportService">
  <part name="BAIRCFSReportRequest" type="tns:XmlDataSet" cols="70" rows="25"/>  
</message>
*/
import iesp, BairRx_Common, BairRx_CFS;

EXPORT CFSReportService := MACRO
	
	dIn := DATASET([], iesp.bair_cfs.t_BAIRCFSReportRequest) : STORED('BAIRCFSReportRequest', FEW);
	first_row := dIn[1] : independent;
	
	options := GLOBAL(first_row.options);
	max_results := IF(options.MaxResults>0 AND options.MaxResults<=BairRx_Common.Constants.MAX_RPT_RESULT, options.MaxResults, BairRx_Common.Constants.DEFAULT_MAX_RPT_RESULT);
			
	user := GLOBAL(first_row.user);
	BairRx_Common.IParam.SetInputSearchUser(user);
	
	report_by := global(first_row.Reportby);							
	input_params := BairRx_Common.IParam.getReportParams(report_by); 
	
	BAIRContext := GLOBAL(first_row.BAIRContext);
	BairRx_Common.IParam.SetInputContext(BAIRContext);

	recs := BairRx_CFS.ReportRecords(input_params, max_results, options.IncludeNotes);		

	BairRx_Common.ECL2ESP.Marshall.MAC_Marshall_Results(recs, results, iesp.bair_cfs.t_BAIRCFSReportResponse,0, Records,true);		

	output(results, named('Results'));

ENDMACRO;