/*--SOAP--
<message name="ReportServiceFCRA">
<part name="doTest" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This service returns Verification of Employment and Consumer Statements.<p/>
It returns 2 kinds of error messages :
10 : "No records found" : the following are the conditions that cause it:-
    If DID is not found for the input PII
If SSN is not input
307 : "LexID was found but failed validation" : the following are the conditions that cause it:-
    If the DID resolved from the PII sent by equifax does not match the DID resolved from the input PII.
If nothing is sent back from equifax.
    If there are multiple persons' PII sent back in the same response.
*/

IMPORT iesp, AutoStandardI, FFD, WorkforceSolutionServices;

EXPORT ReportServiceFCRA := MACRO

//#onwarning(4207, warning); // to override "Error C4207: Inconsistent #STORED ..."
//#onwarning(2071, warning); // to override "Error C2071:

rec_in := iesp.employment_verification_fcra.t_FcraVerificationOfEmploymentReportRequest;
ds_in := DATASET ([], rec_in) : STORED ('FcraVerificationOfEmploymentReportRequest', FEW);
first_row := ds_in[1] : INDEPENDENT;

IF(first_row.Reportby.SSN = '',FAIL('SSN needed:' + Doxie.ErrorCodes(301)));

//set options
report_by := GLOBAL (first_row.ReportBy);
iesp.ECL2ESP.SetInputBaseRequest (first_row);
iesp.ECL2ESP.SetInputReportBy(ROW(report_by,TRANSFORM(iesp.bpsreport.t_BpsReportBy,SELF:=LEFT,SELF:=[])));

in_mod := MODULE(PROJECT(AutoStandardI.GlobalModule(TRUE), WorkforceSolutionServices.IParam.report_params,opt))
EXPORT INTEGER8 FFDOptionsMask := FFD.FFDMask.Get(first_row.options.FFDOptionsMask);
EXPORT INTEGER FCRAPurpose := FCRA.FCRAPurpose.Get(first_row.options.FCRAPurpose);
EXPORT BOOLEAN IncludeIncome := first_row.options.IncludeIncome;
EXPORT BOOLEAN IsRhodeIslandResident := first_row.options.IsRhodeIslandResident;
END;


wss_out := WorkforceSolutionServices.Records(ds_in, in_mod);
wssRecords := PROJECT(wss_out.GwResponse[1].Response.EvsResponse,
                                        WorkforceSolutionServices.transforms.toRecords(LEFT , wss_out.Lexid, first_row.user.ssnmask,first_row.user.dobmask ));
// We may even blank out exceptions ....
//tHeader := row(iesp.ECL2ESP.GetHeaderRow(), transform(iesp.share.t_ResponseHeader, self.Exceptions := wss_out.Exceptions; self := left));

iesp.employment_verification_fcra.t_FcraVerificationOfEmploymentReportResponse xtOut() := TRANSFORM
  //Keep the response status, message, and exceptions but use the query transactionID and queryID
  SELF._header := PROJECT(iesp.ECL2ESP.GetHeaderRow(), TRANSFORM(iesp.share.t_ResponseHeader,
    SELF.status := wss_out.eq_header.status,
    SELF.message := wss_out.eq_header.message,
    SELF.exceptions := wss_out.eq_header.exceptions,
    SELF := LEFT
  ));
  SELF.Validation := wss_out.Validation;
  SELF.VerificationOfEmploymentReportRecord := wssRecords;
  SELF.ConsumerStatements := wss_out.ConsumerStatements;
  SELF.ConsumerAlerts := wss_out.ConsumerAlerts;
  SELF.Consumer := wss_out.Consumer;
  SELF := [];
END;
results := ROW(xtOut());
OUTPUT(results, NAMED('Results'));
OUTPUT(wss_out.Royalty, NAMED('RoyaltySet'));

ENDMACRO;
