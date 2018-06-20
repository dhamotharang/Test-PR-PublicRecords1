/*--SOAP--
<message name="WatercraftReportServiceFCRA">  
	<part name="DID"         type="xsd:string"/>
	<part name="GLBPurpose"	 type="xsd:byte"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="FCRAPurpose" type="xsd:string"/>
	<part name="ApplicationType"     	type="xsd:string"/>
  <part name="SSNMask"     type="xsd:string"/>	<!-- [NONE, ALL, LAST4, FIRST5] -->
	<part name="FFDOptionsMask"      type="xsd:string"/>
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

export WatercraftReportServiceFCRA := macro
	
	gm := AutoStandardI.GlobalModule(true);
	
	//non-subject suppression
  nss := ut.getNonSubjectSuppression (Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription);

	params := module(project(gm, WatercraftV2_Services.Interfaces.report_params, opt))
		export string14  DID     	:= '' : stored('DID');
		export unsigned2 pt 			:= 10;
		export integer1 non_subject_suppression := nss;
		export integer8 FFDOptionsMask := FFD.FFDMask.Get();
		export integer  FCRAPurpose := FCRA.FCRAPurpose.Get();
	END;
	
	report_recs := watercraftV2_Services.WatercraftReport(params, true);

  input_consumer := FFD.MAC.PrepareConsumerRecord(params.did, false);
																	
	output(report_recs.Records, named('Results'));
	output(report_recs.Statements, named('ConsumerStatements'));
	output(report_recs.ConsumerAlerts, named('ConsumerAlerts'));
	output(input_consumer, named('Consumer'));

endmacro;