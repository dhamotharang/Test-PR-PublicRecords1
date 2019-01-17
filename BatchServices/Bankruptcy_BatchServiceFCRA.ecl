/*--SOAP--
<message name="Bankruptcy_BatchServiceFCRA">
  <part name="DPPAPurpose"          type="xsd:byte"/>
  <part name="GLBPurpose"           type="xsd:byte"/>
  <part name="ApplicationType"     type="xsd:string"/>

  <part name="Phonetics"            type="xsd:boolean"/>
  <part name="Nicknames"            type="xsd:boolean"/>
  <part name="SSNMask"              type="xsd:string"/>

  <part name="Match_Name"           type="xsd:boolean"/>
  <part name="Match_Comp_Name"      type="xsd:boolean"/>
  <part name="Match_Street_Address" type="xsd:boolean"/>
  <part name="Match_City"           type="xsd:boolean"/>
  <part name="Match_State"          type="xsd:boolean"/>
  <part name="Match_Zip"            type="xsd:boolean"/>
  <part name="Match_Phone"          type="xsd:boolean"/>
  <part name="Match_SSN"            type="xsd:boolean"/>
  <part name="Match_FEIN"           type="xsd:boolean"/>
  <part name="Match_DOB"            type="xsd:boolean"/>

  <part name="IsDeepDive"           type="xsd:boolean"/>
  <part name="IsFCRA"                type="xsd:boolean"/>
  <part name="MatchCode_ADL_Append" type="xsd:boolean"/>

    <part name="PenaltThreshold"    type="xsd:unsignedInt"/>
  <part name="MaxResults"           type="xsd:unsignedInt"/>
  <part name="Max_Results_Per_Acct" type="xsd:byte"/>

  <part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>

  <part name="Match_Attorneys"      type="xsd:boolean"/>
  <part name="Match_Creditors"      type="xsd:boolean"/>
  <part name="Match_Debtors"        type="xsd:boolean"/>

  <part name="MatchCode_Includes"    type="xsd:string"/>
  <part name="Chapter_Includes"      type="xsd:string"/>
  <part name="DCode_Includes"        type="xsd:string"/>

  <part name="DaysBack"               type="xsd:unsignedInt"/>
  <part name="DID_Score_Threshold"  type="xsd:unsignedInt"/>
  <part name="BDID_Score_Threshold" type="xsd:unsignedInt"/>
  <part name="BIPFetchLevel"         type="xsd:string"/>
  <part name="BIPSkipMatch"         type="xsd:boolean"/>

  <part name="SuppressWithdrawnBankruptcy" type="xsd:boolean"/>
  <part name="FFDOptionsMask"       type="xsd:string"/>
  <part name="FCRAPurpose"          type="xsd:string"/>
  <part name="UseNameSSNLast4"      type="xsd:boolean"/>
</message>
*/
IMPORT AutoStandardI, BatchShare, BatchServices, BankruptcyV3_Services, FFD, UT;

export Bankruptcy_BatchServiceFCRA(useCannedRecs = 'false') := MACRO

  #OPTION('optimizeProjects', TRUE);

  // Imitate in part the constants and stored variables found in the bankruptcy search service.
  #constant('SearchIgnoresAddressOnly',true);
  #stored('ScoreThreshold',10);
  #stored('PenaltThreshold',20);

  #constant('DisplayMatchedParty',true);
  #constant('isFCRA', true);
  #constant('noDeepDive', true);

  BOOLEAN isFCRA           := true    : STORED('IsFCRA');
  BOOLEAN isDeepDive         := false  : STORED('IsDeepDive');

  // 1. Build party_type set.
  BOOLEAN match_attorneys        := FALSE  : STORED('Match_Attorneys');
  BOOLEAN match_creditors        := FALSE   : STORED('Match_Creditors');
  BOOLEAN match_debtors          := TRUE   : STORED('Match_Debtors');

  boolean use_namessnlast4      := true   : stored('UseNameSSNLast4');

  STRING1 BIPFetchLevel    := 'S'   : STORED('BIPFetchLevel');
  BOOLEAN BIPSkipMatch    := true  : STORED('BIPSkipMatch');

  BOOLEAN suppress_withdrawn_bankruptcy  := FALSE   : STORED('SuppressWithdrawnBankruptcy');
  STRING32 application_type := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
  INTEGER8 inFFDOptionsMask := FFD.FFDMask.Get(inApplicationType := application_type);
  INTEGER inFCRAPurpose := FCRA.FCRAPurpose.Get();

  // Return all records if either all the booleans are true, or all are false. The reason is
  // because it's common to run a batch job without checking any parties and yet expect the
  // system to return all results. Strictly a concession to human behavior.
  BOOLEAN all_or_none_are_checked := (match_attorneys AND match_creditors AND match_debtors) OR
                                      NOT (match_attorneys OR match_creditors OR match_debtors);

  SET OF STRING1 attorney_type := IF( match_attorneys, ['A'], [] );
  SET OF STRING1 creditor_type := IF( match_creditors, ['C'], [] );
  SET OF STRING1 debtor_type   := IF( match_debtors,   ['D'], [] );

  SET OF STRING1 party_types   := IF( all_or_none_are_checked,
                                      ['A','C','D',''],
                                      attorney_type + creditor_type + debtor_type
                                      );

  ds_batch_in := IF( NOT useCannedRecs,
    BatchServices.file_Bankruptcy_Batch_in(forceSeq := FALSE),
    PROJECT(BatchServices._Sample_inBatchMaster('BANKRUPTCY'), BatchServices.layout_BankruptcyV3_Batch_in));

  //Need these values to utilize picklist to try and find missing DIDs from PII.
  batch_params := MODULE(BatchShare.IParam.getBatchParams())
    EXPORT DATASET (Gateway.layouts.config) gateways := Gateway.Configuration.Get();
  END;

  //The used to be taken from STORED, but using getBatchParams for picklist caused a duplicated STORED error.
  in_ssn_mask := batch_params.ssn_mask;

 //Search for Bk records by party. Leave input as is to maintain expected results.
 //Picklist used to be utlized here, however it was determined that it's redundant and not needed.
 //This is due to the batch services running ADL Best on the input PRIOR to sending the query to this service.
 //Since picklist is changing to DidVille it would run the same lexID resolution logic twice if done within roxie.
  ds_batch := BatchServices.Bankruptcy_BatchService_Records.search(ds_batch_in,
    party_types,
    isFCRA,
    isDeepDive,
    in_ssn_mask,
    use_namessnlast4,
    BIPFetchLevel,
    BIPSkipMatch,
    suppress_withdrawn_bankruptcy);

  //Get results with matching inquiry and result dids (exluding 0), and populate the inquiry_lexID.
  ds_batch_validated_lexID := JOIN(ds_batch, ds_batch_in,
    RIGHT.did > 0 AND LEFT.acctno = RIGHT.acctno AND (UNSIGNED6)LEFT.debtor_did = RIGHT.did,
    TRANSFORM(BatchServices.layout_BankruptcyV3_Batch_out, SELF.inquiry_lexID := (STRING)RIGHT.did, SELF := LEFT),
    KEEP(1), LIMIT(0));

  //Any inquiry without a single match is sent to remote linking.
  ds_batch_for_remote_linking := JOIN(ds_batch, ds_batch_validated_lexID,
    LEFT.acctno = RIGHT.acctno, LEFT ONLY);

  //Get remote linking matches and concat them to the lexID validated results.
  ds_remote_linking_matches := BankruptcyV3_Services.fn_get_remote_linking_matches(ds_batch_in, ds_batch_for_remote_linking, batch_params.gateways);
  ds_batch_all_validated := ds_batch_validated_lexID + ds_remote_linking_matches;

  //Find records on input which have no results but a did > 0 and extract the dids.
  dids_no_results := JOIN(ds_batch_in(did > 0), ds_batch_all_validated, LEFT.acctno = RIGHT.acctno,
    TRANSFORM(FFD.Layouts.DidBatch, SELF.did := LEFT.did, SELF.acctno := LEFT.acctno), LEFT ONLY);

  //Extract all inquiry_lexID values per acctno and use this data to call person context.
  //This is either set by input DID when matching, or remote linking's best_lexID.
  dids_results := PROJECT(ds_batch_all_validated, TRANSFORM(FFD.Layouts.DidBatch,
    SELF.did := (UNSIGNED6)LEFT.inquiry_lexID, SELF.acctno := LEFT.acctno));

  //Combine all the dids needed for person context.
  dids := dids_no_results + dids_results;

  deduped_dids := DEDUP(SORT(dids(did>0), acctno, did), acctno, did);
  pc_recs := FFD.FetchPersonContext(deduped_dids, batch_params.gateways, FFD.Constants.DataGroupSet.Bankruptcy, inFFDOptionsMask);

  //Apply FCRA FFD suppression.
  ds_batch_ffd := BankruptcyV3_Services.fn_fcra_ffd_batch(ds_batch_all_validated, pc_recs, inFFDOptionsMask, inFCRAPurpose);

  //Add back records with no results for inquiry logging.
  //Set AddlOptions to 1 so we don't overwrite inquiry_lexID values set by remote linking or input DID.
  ds_batch_inquiry_lexID := FFD.Mac.InquiryLexidBatch(ds_batch_in, ds_batch_ffd.records, BatchServices.layout_BankruptcyV3_Batch_out, 1);

  results_pre := SORT(ds_batch_inquiry_lexID, acctno); // records in batch out layout
  consumer_statements := SORT(ds_batch_ffd.statements, acctno); // statements
  ut.mac_TrimFields(results_pre, 'results_pre', results);

//DEBUG--------------------------------------------
  // OUTPUT(ds_batch, NAMED('ds_batch'));
  // OUTPUT(ds_batch_for_remote_linking, NAMED('ds_batch_for_remote_linking'));
  // OUTPUT(ds_remote_linking_matches, NAMED('ds_remote_linking_matches'));
  // OUTPUT(dids, NAMED('dids'));
  // OUTPUT(deduped_dids, NAMED('deduped_dids'));
  // OUTPUT(pc_recs, NAMED('pc_recs'));
  // OUTPUT(ds_batch_ffd, NAMED('ds_batch_ffd'));
//END DEBUG-----------------------------------------

  OUTPUT(results, NAMED('Results'));
  OUTPUT(consumer_statements, NAMED('CSDResults'));

  ENDMACRO;
// BatchServices.Bankruptcy_BatchServiceFCRA();
