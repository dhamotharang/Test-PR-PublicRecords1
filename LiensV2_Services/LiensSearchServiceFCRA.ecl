// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
import liensv2_services, STD, FCRA, FFD, WSInput;

export LiensSearchServiceFCRA() := macro

	WSInput.MAC_LiensV2_LiensSearchServiceFCRA();

	#constant('getBdidsbyExecutive',FALSE);
	#constant('SearchGoodSSNOnly',true);
	#constant('SearchIgnoresAddressOnly',true);
	#stored('ScoreThreshold',10);
	#stored('PenaltThreshold',10);
	#constant('DisplayMatchedParty',true);
	#constant('isFCRA', true);
	#constant('NoDeepDive', true);
	boolean isFCRA := true;
	boolean evictions_only := false : stored('EvictionsOnly');
	boolean liens_only := false : stored('LiensOnly');
	boolean judgments_only := false : stored('JudgmentsOnly');
	doxie.MAC_Header_Field_Declare(isFCRA);

	//------------------------------------------------------------------------------------
	//soap call for remote DIDs for Collections
  fcra_subj_only := false : stored ('ApplyNonsubjectRestrictions');
	boolean isCollections := application_type_value IN AutoStandardI.Constants.COLLECTION_TYPES;
	boolean returnByDidOnly := fcra_subj_only OR isCollections;
	//------------------------------------------------------------------------------------
	gateways := Gateway.Configuration.Get();
	picklist_res := FCRA.PickListSoapcall.non_esdl(gateways, true, returnByDidOnly and (did_value='')); //call gateway only when returnByDidOnly is true
	//------------------------------------------------------------------------------------

	string14 rdid := if(returnByDidOnly and did_value='', picklist_res[1].Records[1].UniqueId, did_value);

	// for FCRA version, set isFCRA boolean to true
	nss_default := if(fcra_subj_only or isCollections, Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription, Suppress.Constants.NonSubjectSuppression.doNothing);
	nss := ut.GetNonSubjectSuppression(nss_default);
	gm := AutoStandardI.GlobalModule(isFCRA);
	liens_params := module(project(gm, LiensV2_Services.IParam.search_params, opt))
		export string14 DID := rdid;
		export unsigned2 pt := 10 : stored('PenaltThreshold');
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
		export boolean subject_only := returnByDidOnly;
		export integer8 FFDOptionsMask := FFD.FFDMask.Get();
	  export integer FCRAPurpose := FCRA.FCRAPurpose.Get();
	END;
	all_recs_and_statements := LiensV2_Services.LiensSearchService_records(liens_params, isFCRA);
	all_recs := all_recs_and_statements.records;
	statements := all_recs_and_statements.statements;
	consumer_alerts := all_recs_and_statements.ConsumerAlerts;

	// returns filtered results if filter is specifed
	recs_filt := all_recs((evictions_only and eviction = 'Y')
													or (liens_only
														and (STD.Str.ToUpperCase(STD.Str.CleanSpaces(filings[1].filing_type_desc)) in liensv2.filing_type_desc.LIEN))
													or (judgments_only
														and (STD.Str.ToUpperCase(STD.Str.CleanSpaces(filings[1].filing_type_desc)) in liensv2.filing_type_desc.JUDGMENT)));

	need_filter := evictions_only or liens_only or judgments_only;

	out_recs := if(need_filter, recs_filt, all_recs);

  input_consumer := LiensV2_Services.fn_identify_consumer(out_recs, rdid);

	doxie.MAC_Marshall_Results(out_recs, recs_marshalled);
	OUTPUT(recs_marshalled, NAMED('Results'));
	OUTPUT(statements,NAMED('ConsumerStatements'));
	OUTPUT(consumer_alerts, NAMED('ConsumerAlerts'));
	OUTPUT(input_consumer, NAMED('Consumer'));

endmacro;
