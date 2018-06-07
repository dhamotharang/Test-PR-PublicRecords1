/*--SOAP--
<message name="LiensReportServiceFCRA">
  <part name="PersonFilterID" 					type="xsd:string"/>
  <part name="TMSID" 				type="xsd:string"/>
  <part name="DID" 				type="xsd:string"/>
  <part name="SSNMask"			type="xsd:string"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="NonSubjectSuppression" type="xsd:unsignedInt" default="2"/> <!-- [1,2,3] -->
  <part name="ApplyNonsubjectRestrictions" type="xsd:boolean"/>
	<part name="FFDOptionsMask" type="xsd:string"/>
  <part name="FCRAPurpose" type="xsd:string"/>
	
</message>
*/
/*--INFO-- This service searches the FCRA LiensV2 files, limited by a person filter ID 
					 or by DID with NonSubjectSuppression value of 2.*/

import liensv2_services, doxie, AutoStandardI, FFD, ut, Suppress;

export LiensReportServiceFCRA() := macro
	#constant('getBdidsbyExecutive',FALSE);
	#constant('SearchGoodSSNOnly',true);
	#constant('SearchIgnoresAddressOnly',true);
	#stored('ScoreThreshold',10);
	#stored('PenaltThreshold',20);
	#constant('DisplayMatchedParty',true);
	#constant('isFCRA', true);
	#constant('NoDeepDive', true);

	boolean isFCRA := true;
	doxie.MAC_Header_Field_Declare(isFCRA);
  fcra_subj_only := false : stored ('ApplyNonsubjectRestrictions');
	boolean isCollections := application_type_value IN AutoStandardI.Constants.COLLECTION_TYPES;
	boolean returnByDidOnly := fcra_subj_only OR isCollections;
	
		
	nss_default := if(fcra_subj_only or isCollections, Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription, Suppress.Constants.NonSubjectSuppression.doNothing);
	nss := ut.GetNonSubjectSuppression(nss_default);
	gm := AutoStandardI.GlobalModule(isFCRA);
	liens_params := module(project(gm, LiensV2_Services.IParam.search_params, opt))
		export string14 DID := did_value;
		export unsigned2 pt := 10 			: stored('PenaltThreshold');
		export string CertificateNumber := '' : stored('CertificateNumber');
		export unsigned8 maxresults := maxresults_val;
		export string1 partyType := party_type;
		export string50 liencasenumber := liencasenumber_value;
		export string50 filingnumber := filingnumber_value;
		export string20 filingjurisdiction := filingjurisdiction_value;
		export string25 irsserialnumber := irsserialnumber_value;
		export string6 ssn_mask := ssn_mask_value;
		export integer1 non_subject_suppression := nss;
		export string32 ApplicationType := application_type_value;
		export string101 rmsid := rmsid_value;
		export string50 tmsid := tmsid_value;
		export string person_filter_id := '' : stored('PersonFilterID');
		export boolean subject_only := returnByDidOnly;
		export integer8 FFDOptionsMask := FFD.FFDMask.Get();
		export integer FCRAPurpose := FCRA.FCRAPurpose.Get();
	END;
	liens := LiensV2_Services.LiensSearchService_records(liens_params, isFCRA);
	recs := liens.records;
	statements := liens.statements;
	consumer_alerts := liens.ConsumerAlerts;
  input_consumer := LiensV2_Services.fn_identify_consumer(recs, liens_params.did);

	doxie.MAC_Marshall_Results(recs, recs_marshalled);
	
	boolean shouldFail := liens_params.person_filter_id = '' and ~returnByDidOnly;
	sequential (
		if(liens_params.person_filter_id <> '', output(liens_params.person_filter_id, named('PersonFilterID'))),
    if (shouldFail, 
		    FAIL('Person filter ID must be used with FCRA search'),
        OUTPUT(recs_marshalled, NAMED('Results'))),
				
        OUTPUT(statements, NAMED('ConsumerStatements')),
        OUTPUT(consumer_alerts, NAMED('ConsumerAlerts')),
        OUTPUT(input_consumer, NAMED('Consumer'))
	);

endmacro;