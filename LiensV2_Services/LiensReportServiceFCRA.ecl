// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================

/*--INFO-- This service searches the FCRA LiensV2 files, limited by a person filter ID
  or by DID with NonSubjectSuppression value of 2.*/

IMPORT liensv2_services, doxie, AutoStandardI, FFD, ut, Suppress;

EXPORT LiensReportServiceFCRA() := MACRO
  #CONSTANT('getBdidsbyExecutive',FALSE);
  #CONSTANT('SearchGoodSSNOnly',TRUE);
  #CONSTANT('SearchIgnoresAddressOnly',TRUE);
  #STORED('ScoreThreshold',10);
  #STORED('PenaltThreshold',20);
  #CONSTANT('DisplayMatchedParty',TRUE);
  #CONSTANT('isFCRA', TRUE);
  #CONSTANT('NoDeepDive', TRUE);

  BOOLEAN isFCRA := TRUE;
  doxie.MAC_Header_Field_Declare(isFCRA);
  fcra_subj_only := FALSE : STORED ('ApplyNonsubjectRestrictions');
  BOOLEAN isCollections := application_type_value IN AutoStandardI.Constants.COLLECTION_TYPES;
  BOOLEAN returnByDidOnly := fcra_subj_only OR isCollections;
  
    
  nss_default := IF(fcra_subj_only OR isCollections, Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription, Suppress.Constants.NonSubjectSuppression.doNothing);
  nss := ut.GetNonSubjectSuppression(nss_default);
  gm := AutoStandardI.GlobalModule(isFCRA);
  liens_params := MODULE(PROJECT(gm, LiensV2_Services.IParam.search_params, OPT))
    EXPORT STRING14 DID := did_value;
    EXPORT UNSIGNED2 pt := 10 : STORED('PenaltThreshold');
    EXPORT STRING CertificateNumber := '' : STORED('CertificateNumber');
    EXPORT UNSIGNED8 maxresults := maxresults_val;
    EXPORT STRING1 partyType := party_type;
    EXPORT STRING50 liencasenumber := liencasenumber_value;
    EXPORT STRING50 filingnumber := filingnumber_value;
    EXPORT STRING20 filingjurisdiction := filingjurisdiction_value;
    EXPORT STRING25 irsserialnumber := irsserialnumber_value;
    EXPORT STRING6 ssn_mask := ssn_mask_value;
    EXPORT INTEGER1 non_subject_suppression := nss;
    EXPORT STRING32 ApplicationType := application_type_value;
    EXPORT STRING101 rmsid := rmsid_value;
    EXPORT STRING50 tmsid := tmsid_value;
    EXPORT STRING person_filter_id := '' : STORED('PersonFilterID');
    EXPORT BOOLEAN subject_only := returnByDidOnly;
    EXPORT INTEGER8 FFDOptionsMask := FFD.FFDMask.Get();
    EXPORT INTEGER FCRAPurpose := FCRA.FCRAPurpose.Get();
  END;
  liens := LiensV2_Services.LiensSearchService_records(liens_params, isFCRA);
  recs := liens.records;
  statements := liens.statements;
  consumer_alerts := liens.ConsumerAlerts;
  input_consumer := LiensV2_Services.fn_identify_consumer(recs, liens_params.did);

  doxie.MAC_Marshall_Results(recs, recs_marshalled);
  
  BOOLEAN shouldFail := liens_params.person_filter_id = '' AND ~returnByDidOnly;
  sequential (
    IF(liens_params.person_filter_id <> '', OUTPUT(liens_params.person_filter_id, NAMED('PersonFilterID'))),
    IF (shouldFail,
        FAIL('Person filter ID must be used with FCRA search'),
        OUTPUT(recs_marshalled, NAMED('Results'))),
        
        OUTPUT(statements, NAMED('ConsumerStatements')),
        OUTPUT(consumer_alerts, NAMED('ConsumerAlerts')),
        OUTPUT(input_consumer, NAMED('Consumer'))
  );

ENDMACRO;
