/*--SOAP--
<message name="ReportServiceFCRA">
 <part name="doTest" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This service returns Verification of Employment and Consumer Statements.<p/>
It returns 2 kinds of error messages :
10  : "No records found" : the following are the conditions that cause it:-
			If DID is not found for the input PII
      If SSN is not input
307 : "LexID was found but failed validation" : the following are the conditions that cause it:-
			If the DID resolved from the PII sent by equifax does not match the DID resolved from the input PII.
      If nothing is sent back from equifax.
			If there are multiple persons' PII sent back in the same response. 
 */

Import iesp, AutoStandardI, FFD, WorkforceSolutionServices;

EXPORT ReportServiceFCRA  := macro

	//#onwarning(4207, warning); // to override "Error C4207:  Inconsistent #STORED ..." 
	//#onwarning(2071, warning); // to override "Error C2071: 
	
	rec_in := iesp.employment_verification_fcra.t_FcraVerificationOfEmploymentReportRequest;	
  ds_in := DATASET ([], rec_in) : STORED ('FcraVerificationOfEmploymentReportRequest', FEW);
	first_row := ds_in[1] : independent;
	
	if(first_row.Reportby.SSN = '',fail('SSN needed:' + Doxie.ErrorCodes(301)));

	//set options
	report_by := global (first_row.ReportBy);
	iesp.ECL2ESP.SetInputBaseRequest (first_row);
	iesp.ECL2ESP.SetInputReportBy(row(report_by,transform(iesp.bpsreport.t_BpsReportBy,self:=left,self:=[])));	
		
	in_mod := module(project(AutoStandardI.GlobalModule(true), WorkforceSolutionServices.IParam.report_params,opt))
		export integer8 FFDOptionsMask := FFD.FFDMask.Get(first_row.options.FFDOptionsMask);		
		export integer FCRAPurpose := FCRA.FCRAPurpose.Get(first_row.options.FCRAPurpose); 
		export boolean IncludeIncome := first_row.options.IncludeIncome;
		export boolean IsRhodeIslandResident := first_row.options.IsRhodeIslandResident;
	end;
   	
	
	wss_out := WorkforceSolutionServices.Records(ds_in, in_mod);
	wssRecords := project(wss_out.GwResponse[1].Response.EvsResponse,
												WorkforceSolutionServices.transforms.toRecords(left , wss_out.Lexid, first_row.user.ssnmask,first_row.user.dobmask ));
// We may even blank out exceptions .... 	
	//tHeader := row(iesp.ECL2ESP.GetHeaderRow(), transform(iesp.share.t_ResponseHeader, self.Exceptions := wss_out.Exceptions; self := left));
	
	iesp.employment_verification_fcra.t_FcraVerificationOfEmploymentReportResponse xtOut() := transform
			//Keep the response status, message, and exceptions but use the query transactionID and queryID
			SELF._header := PROJECT(iesp.ECL2ESP.GetHeaderRow(), TRANSFORM(iesp.share.t_ResponseHeader,
				SELF.status := wss_out.eq_header.status,
				SELF.message := wss_out.eq_header.message,
				SELF.exceptions := wss_out.eq_header.exceptions,
				SELF := LEFT
			));
		Self.Validation := wss_out.Validation;
		self.VerificationOfEmploymentReportRecord := wssRecords;
		self.ConsumerStatements := wss_out.ConsumerStatements;
		self.ConsumerAlerts := wss_out.ConsumerAlerts;
		self.Consumer := wss_out.Consumer;
		self := [];
	end;
	results := row(xtOut());
	output(results, named('Results'));
	output(wss_out.Royalty, named('RoyaltySet'));
		
endmacro;