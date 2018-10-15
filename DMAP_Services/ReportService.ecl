/*--SOAP--
<message name="DMAP_Services.ReportService">
</message>
*/
//***********************
/*--INFO-- This service returns records for a Digital Mortgage Application Prefill using did, Property Address & Loan Purpose as inputs .*/
//***********************
IMPORT iesp, WSInput, DMAP_Services;

EXPORT ReportService:= MACRO
	#ONWARNING(4207, IGNORE);
	WSInput.MAC_DMAP_Services_ReportService();
	
	Ds_In:= DATASET([], iesp.dmap.t_DMAPReportRequest): STORED('DMAPReportRequest', FEW);
	First_Row:= ds_in[1]: INDEPENDENT;
	iesp.ECL2ESP.SetInputBaseRequest(first_row);
		
	Report_Input:= PROJECT(first_row, TRANSFORM(DMAP_Services.Layouts.Input_Layout, SELF.did:= (UNSIGNED6)LEFT.ReportBy.UniqueId, SELF.PropertyAddr:= DMAP_Services.Functions.fn_clean_addr(LEFT.ReportBy.PropertyAddress), SELF:=[]));
	DMAP_Records:= DMAP_Services.Records(Report_Input);				
	Results:= PROJECT(DMAP_records, TRANSFORM(iesp.dmap.t_DMAPReportResponse, SELF.Result:= LEFT,  SELF.InputEcho:= First_Row.ReportBy, self._Header:= iesp.ECL2ESP.GetHeaderRow(), SELF:=[]));
	
	OUTPUT(Results, NAMED('Results'));
ENDMACRO;
//DMAP_Services.ReportService();