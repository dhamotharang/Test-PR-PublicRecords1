// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
IMPORT liensv2_services, STD, FCRA, FFD, WSInput;

EXPORT LiensSearchServiceFCRA() := MACRO

  WSInput.MAC_LiensV2_LiensSearchServiceFCRA();

  #CONSTANT('getBdidsbyExecutive',FALSE);
  #CONSTANT('SearchGoodSSNOnly',TRUE);
  #CONSTANT('SearchIgnoresAddressOnly',TRUE);
  #STORED('ScoreThreshold',10);
  #STORED('PenaltThreshold',10);
  #CONSTANT('DisplayMatchedParty',TRUE);
  #CONSTANT('isFCRA', TRUE);
  #CONSTANT('NoDeepDive', TRUE);
  BOOLEAN isFCRA := TRUE;
  BOOLEAN evictions_only := FALSE : STORED('EvictionsOnly');
  BOOLEAN liens_only := FALSE : STORED('LiensOnly');
  BOOLEAN judgments_only := FALSE : STORED('JudgmentsOnly');
  doxie.MAC_Header_Field_Declare(isFCRA);

  //------------------------------------------------------------------------------------
  //soap call for remote DIDs for Collections
  fcra_subj_only := FALSE : STORED ('ApplyNonsubjectRestrictions');
  BOOLEAN isCollections := application_type_value IN AutoStandardI.Constants.COLLECTION_TYPES;
  BOOLEAN returnByDidOnly := fcra_subj_only OR isCollections;
  //------------------------------------------------------------------------------------
  gateways := Gateway.Configuration.Get();
  picklist_res := FCRA.PickListSoapcall.non_esdl(gateways, TRUE, returnByDidOnly AND (did_value='')); //call gateway only when returnByDidOnly is TRUE
  //------------------------------------------------------------------------------------

  STRING14 rdid := IF(returnByDidOnly AND did_value='', picklist_res[1].Records[1].UniqueId, did_value);

  // for FCRA version, set isFCRA boolean to true
  nss_default := IF(fcra_subj_only OR isCollections, Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription, Suppress.Constants.NonSubjectSuppression.doNothing);
  nss := ut.GetNonSubjectSuppression(nss_default);
  gm := AutoStandardI.GlobalModule(isFCRA);
  liens_params := MODULE(PROJECT(gm, LiensV2_Services.IParam.search_params, OPT))
    EXPORT STRING14 DID := rdid;
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
    EXPORT BOOLEAN subject_only := returnByDidOnly;
    EXPORT INTEGER8 FFDOptionsMask := FFD.FFDMask.Get();
    EXPORT INTEGER FCRAPurpose := FCRA.FCRAPurpose.Get();
  END;
  all_recs_and_statements := LiensV2_Services.LiensSearchService_records(liens_params, isFCRA);
  all_recs := all_recs_and_statements.records;
  statements := all_recs_and_statements.statements;
  consumer_alerts := all_recs_and_statements.ConsumerAlerts;

  // returns filtered results if filter is specifed
  recs_filt := all_recs(
    (evictions_only AND eviction = 'Y')
    OR (liens_only
      AND (STD.Str.ToUpperCase(STD.Str.CleanSpaces(filings[1].filing_type_desc)) IN liensv2.filing_type_desc.LIEN))
    OR (judgments_only
      AND (STD.Str.ToUpperCase(STD.Str.CleanSpaces(filings[1].filing_type_desc)) IN liensv2.filing_type_desc.JUDGMENT))
  );

  need_filter := evictions_only OR liens_only OR judgments_only;

  out_recs := IF(need_filter, recs_filt, all_recs);

  input_consumer := LiensV2_Services.fn_identify_consumer(out_recs, rdid);

  doxie.MAC_Marshall_Results(out_recs, recs_marshalled);
  OUTPUT(recs_marshalled, NAMED('Results'));
  OUTPUT(statements,NAMED('ConsumerStatements'));
  OUTPUT(consumer_alerts, NAMED('ConsumerAlerts'));
  OUTPUT(input_consumer, NAMED('Consumer'));

ENDMACRO;
