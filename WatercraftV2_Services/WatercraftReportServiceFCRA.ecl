/*--SOAP--
<message name="WatercraftReportServiceFCRA">
  <part name="DID" type="xsd:string"/>
  <part name="GLBPurpose" type="xsd:byte"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="FCRAPurpose" type="xsd:string"/>
  <part name="ApplicationType" type="xsd:string"/>
  <part name="SSNMask" type="xsd:string"/> <!-- [NONE, ALL, LAST4, FIRST5] -->
  <part name="FFDOptionsMask" type="xsd:string"/>
  <part name='NonSubjectSuppression' type = 'xsd:unsignedInt' default="2"/> <!-- [1,2,3] -->


</message>
*/
/*--INFO-- This service returns one watercraft Record with FCRA restrictions.<p/>
           When using NonSubjectSuppression:<br/>
           -1: no co-owners suppression<br/>
           -2: co-owners are blanked and lname is overriden with value "FCRA Restricted"<br/>
           -3: co-owners are suppressed<p/>
           The default behavior for NonSubjectSuppression is 2.*/
IMPORT STD;

EXPORT WatercraftReportServiceFCRA := MACRO
  
  gm := AutoStandardI.GlobalModule(TRUE);
  
  //non-subject suppression
  nss := ut.getNonSubjectSuppression (Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription);

  params := MODULE(PROJECT(gm, WatercraftV2_Services.Interfaces.report_params, opt))
    EXPORT STRING14 DID := '' : STORED('DID');
    EXPORT UNSIGNED2 pt := 10;
    EXPORT INTEGER1 non_subject_suppression := nss;
    EXPORT INTEGER8 FFDOptionsMask := FFD.FFDMask.Get();
    EXPORT INTEGER FCRAPurpose := FCRA.FCRAPurpose.Get();
  END;
  
  report_recs := watercraftV2_Services.WatercraftReport(params, TRUE);

  input_consumer := FFD.MAC.PrepareConsumerRecord(params.did, FALSE);
                                  
  OUTPUT(report_recs.Records, NAMED('Results'));
  OUTPUT(report_recs.Statements, NAMED('ConsumerStatements'));
  OUTPUT(report_recs.ConsumerAlerts, NAMED('ConsumerAlerts'));
  OUTPUT(input_consumer, NAMED('Consumer'));

ENDMACRO;
