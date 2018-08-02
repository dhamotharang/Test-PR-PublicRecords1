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
    PROJECT(BatchServices._Sample_inBatchMaster('BANKRUPTCY'), BatchServices.layout_BankruptcyV3_Batch_in)
    );

  //Need these values to utilize picklist to try and find missing DIDs from PII.
  batch_params := module(BatchShare.IParam.getBatchParams())
    export dataset (Gateway.layouts.config) gateways := Gateway.Configuration.Get();
  END;

  //The used to be taken from STORED, but using getBatchParams for picklist caused a duplicated STORED error.
  in_ssn_mask := batch_params.ssn_mask;

  //Attempt to append DIDs to ones that are missing using picklist.
  ds_batch_in_appended_plist := BankruptcyV3_Services.fn_append_picklist(ds_batch_in, batch_params, isFCRA);

  //Call person context to retrieve consumer data and alert flags.
  dids := PROJECT(DEDUP(SORT(ds_batch_in_appended_plist, did, acctno), did, acctno), FFD.Layouts.DidBatch);
  pc_recs := FFD.FetchPersonContext(dids((unsigned6)did > 0), batch_params.gateways, FFD.Constants.DataGroupSet.Bankruptcy, inFFDOptionsMask);
  // Search for Bk records by party, not including searched without lexID, or suppressed from consumer level alerts.
  ds_batch := BatchServices.Bankruptcy_BatchService_Records.search(ds_batch_in_appended_plist,
    party_types,
    isFCRA,
    isDeepDive,
    in_ssn_mask,
    use_namessnlast4,
    BIPFetchLevel,
    BIPSkipMatch,
    suppress_withdrawn_bankruptcy);

  //Apply FCRA FFD suppression and format the data to return user friendly statements.
  //This will also create blank records with flags for records which were suppressed due to FFD alerts.
  //The blank records retain the debtor_did value however.
  ds_batch_ffd := BankruptcyV3_Services.fn_fcra_ffd_batch(ds_batch, pc_recs, inFFDOptionsMask, inFCRAPurpose);

  //Do a join against input lexIDs, only keep those with matching debtor_did.
  //This is not done after inquiryLexId batch because a filter after that loses mismatched records
  //which are to be kept for logging purposes.
  ds_batch_validated_lexID := JOIN(ds_batch_ffd.records, ds_batch_in_appended_plist((unsigned6)did > 0),
    LEFT.acctno = RIGHT.acctno AND (unsigned6)LEFT.debtor_did = (unsigned6)RIGHT.did,
    TRANSFORM(BatchServices.layout_BankruptcyV3_Batch_out, SELF.alert_legal_flag := '', SELF := LEFT),
    KEEP(1), LIMIT(0));

  //Add inquiry lexIDs to the results. This also adds any suppressed records as blanks for inquiry logging purposes.
  ds_batch_inquiry_lexID := FFD.Mac.InquiryLexidBatch(ds_batch_in_appended_plist, ds_batch_validated_lexID, BatchServices.layout_BankruptcyV3_Batch_out, 0);

  results_pre := sort(ds_batch_inquiry_lexID, acctno); // records in batch out layout
  consumer_statements := sort(ds_batch_ffd.statements(recordType <> FFD.Constants.RecordType.LH), acctno); // statements
  ut.mac_TrimFields(results_pre, 'results_pre', results);

//DEBUG--------------------------------------------
  // OUTPUT(batch_params.gateways, NAMED('gateways'));
  // OUTPUT(ds_batch_in_picklist, NAMED('ds_batch_in_picklist'));
  // OUTPUT(ds_batch_in_appended_plist, NAMED('ds_batch_in_appended_plist'));
  // OUTPUT(pc_recs_pre, NAMED('pc_recs_pre'));
  // OUTPUT(pc_recs, NAMED('pc_recs'));
  // OUTPUT(ds_batch_inquiry_lexID, NAMED('ds_batch_inquiry_lexID'));
  // OUTPUT(ds_batch_ffd, NAMED('ds_batch_ffd'));
//END DEBUG-----------------------------------------

  OUTPUT(results, NAMED('Results'));
  OUTPUT(consumer_statements, NAMED('CSDResults'));


  ENDMACRO;
// BatchServices.Bankruptcy_BatchServiceFCRA();
