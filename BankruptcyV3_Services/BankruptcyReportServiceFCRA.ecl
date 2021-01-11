/*--SOAP--
<message name="BankruptcyReportServiceFCRA">
  <part name="PersonFilterID" type="xsd:string"/>
  <part name="TMSID" type="xsd:string"/>
  <part name="DID" type="xsd:string"/>
  <part name="PartyType" type="xsd:string"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="IncludeDockets" type="xsd:boolean"/>
  <part name="LowerEnteredDateLimit" type="xsd:string"/>
  <part name="UpperEnteredDateLimit" type="xsd:string"/>
  <part name="ApplicationType" type="xsd:string"/>
  <part name="NonSubjectSuppression" type="xsd:unsignedInt" default="2"/> <!-- [1,2,3] -->
  <part name="ApplyNonsubjectRestrictions" type="xsd:boolean"/>
  <part name="SuppressWithdrawnBankruptcy" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This service returns one Bankruptcy Record and one debtor, limited by person filter ID.*/

IMPORT doxie, bankruptcyv3_services, WSInput, FFD, FCRA;

EXPORT BankruptcyReportServiceFCRA() := MACRO

  //The following macro defines the field sequence on WsECL page of query.
  WSInput.MAC_BankruptcyV3_Services_BankruptcyReportServiceFCRA();
  
  doxie.MAC_Header_Field_Declare(TRUE);
  
  #CONSTANT('NoDeepDive', TRUE);
  
  STRING person_filter_id_value := '' : STORED('PersonFilterID');
  BOOLEAN include_dockets := FALSE : STORED('IncludeDockets');
  STRING8 lower_entered_date := '' : STORED('LowerEnteredDateLimit');
  STRING8 upper_entered_date := '' : STORED('UpperEnteredDateLimit');

  //Check if the customer is a Collections customer
  fcra_subj_only := FALSE : STORED ('ApplyNonsubjectRestrictions');
  BOOLEAN isCollections := application_type_value IN AutoStandardI.Constants.COLLECTION_TYPES;
  const_nss := Suppress.Constants.NonSubjectSuppression;
  nss := ut.GetNonSubjectSuppression(const_nss.doNothing);
  BOOLEAN returnByDidOnly := fcra_subj_only OR isCollections;
  BOOLEAN suppress_withdrawn_bankruptcy := FALSE : STORED('SuppressWithdrawnBankruptcy');
  
  // For FCRA FFD
  
  valFFDOptionsMask := FFD.FFDMask.Get(inApplicationType := application_type_value);
  BOOLEAN ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(valFFDOptionsMask);
  DATASET (Gateway.layouts.config) gateways := Gateway.Configuration.Get();
  UNSIGNED6 input_did := (UNSIGNED6) did_value;
  INTEGER inFCRAPurpose := FCRA.FCRAPurpose.Get();

  // Adjust party-type: only [D]ebtors should be used for collections:
  STRING party_type_adj := IF (returnByDidOnly, BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR, party_type);

  out_recs := Bankruptcyv3_Services.bankruptcy_raw(TRUE).source_view( 
    in_ssn_mask := ssn_mask_value,
    in_party_type := party_type_adj,
    include_dockets := include_dockets,
    lower_entered_date := lower_entered_date,
    upper_entered_date := upper_entered_date,
    suppress_withdrawn_bankruptcy := suppress_withdrawn_bankruptcy
  );
  
  key_court := bankruptcyv3.key_bankruptcyv3_courts;
  
  BankruptcyV3_Services.layout_bkv3_rollup_ext addCourtInfo(
    bankruptcyv3_services.layouts.layout_rollup L,
    RECORDOF(key_court) R) := TRANSFORM
    SELF.court.moxie_court := L.court_code;
    SELF.court.address1 := R.address1;
    SELF.court.city := R.city;
    SELF.court.state := R.state;
    SELF.court.zip := R.zip;
    SELF.court.phone := R.phone;
    SELF.court.district := R.district;
    SELF.court.cfiled := R.cfiled;
    SELF.court.boca_court := R.boca_court;
    SELF.court.c3courtid := R.c3courtid;
    SELF.court.address2 := R.address2;
    SELF.court.fax := R.fax;
    SELF.court.courtID := R.courtID;
    SELF.court.div := R.div;
    SELF.court.hoganID := R.hoganID;
    SELF.court.court := R.court;
    SELF.court.active := R.active;
    SELF := L;
  END;
  
  // append missing court data
  out_recs_court := 
    JOIN(out_recs, key_court,
      KEYED(LEFT.court_code = RIGHT.moxie_court),
      addCourtInfo(LEFT, RIGHT), LEFT OUTER,
      LIMIT(0));
                            
  out_recs_court_ddp := DEDUP(SORT(out_recs_court,tmsid,RECORD), tmsid);
  
  // apply non-subject suppression, if any
  BankruptcyV3_Services.layout_bkv3_rollup_ext xformNonSubject(BankruptcyV3_Services.layout_bkv3_rollup_ext L) := TRANSFORM
  
    debtors_did := L.debtors((UNSIGNED6)did = (UNSIGNED6)did_value);
    debtors_filter := L.debtors(person_filter_id = person_filter_id_value OR (person_filter_id_value = '' AND include_dockets));
    debtors_chosen := IF(did_value <> '', debtors_did, debtors_filter);
 
    // apply non-subject suppression, if requested
    debtors_supp := PROJECT(debtors_chosen((UNSIGNED6)did = (UNSIGNED6)did_value),
      TRANSFORM(BankruptcyV3_Services.layouts.layout_party,
        SELF.names := PROJECT(LEFT.names, 
          TRANSFORM(BankruptcyV3_Services.layouts.layout_name,
            SELF.orig_name := '',
            SELF := LEFT)),
        SELF := LEFT));
    
    debtors_restricted := debtors_supp + 
      PROJECT(debtors_chosen(~((UNSIGNED6)did = (UNSIGNED6)did_value)),
        TRANSFORM(BankruptcyV3_Services.layouts.layout_party,
          SELF.names := PROJECT(LEFT.names,
            TRANSFORM(BankruptcyV3_Services.layouts.layout_name,
              SELF.lname := FCRA.Constants.FCRA_Restricted,
              SELF := [])),
          SELF := []));
          
    SELF.debtors := MAP(
      nss = const_nss.returnRestrictedDescription => debtors_restricted,
      nss = const_nss.returnBlank => debtors_supp,
      debtors_chosen
    );
    SELF := L;
  END;
  out_recs_final := PROJECT(out_recs_court_ddp, xformNonSubject(LEFT));
  
  //*************FCRA FFD --- getting FFD statements for matched parties only
  
  //projecting to common layout for fn_fcra_ffd call
  temp_rollup := PROJECT(out_recs_final, bankruptcyv3_services.layouts.layout_rollup);
  
  did_batch_exp_rec := RECORD(FFD.Layouts.DidBatch)
    BOOLEAN is_debtor := FALSE;
  END;

  // for call to PC we need to grab all dids even if subject is not debtor
  matched_rec_dids := DEDUP(SORT(PROJECT(temp_rollup,
    TRANSFORM(did_batch_exp_rec,
      _debtor := LEFT.debtors(did = LEFT.matched_party.did);
      SELF.is_debtor := EXISTS(_debtor),
      SELF.did := (UNSIGNED6) LEFT.matched_party.did,
      SELF.acctno := FFD.Constants.SingleSearchAcctno)),
      did, -is_debtor), did);
                              
  ds_subj_did := DATASET([{FFD.Constants.SingleSearchAcctno, input_did}], FFD.Layouts.DidBatch);
    
  // even if no data found we still need to check for alerts and consumer level statements for subject
  dsDIDs := IF(EXISTS(matched_rec_dids(did>0)), 
    PROJECT(matched_rec_dids(did>0), FFD.Layouts.DidBatch), ds_subj_did);

  // call person context
  pc_recs_prelim := FFD.FetchPersonContext(dsDIDs, gateways, FFD.Constants.DataGroupSet.Bankruptcy, valFFDOptionsMask);
  
  // for record level statement/dispute filter to keep data only if subject is debtor
  pc_recs_rlvl := 
    JOIN(pc_recs_prelim(RecordType IN FFD.Constants.RecordType.RecordLevel),
    matched_rec_dids(is_debtor),
    (UNSIGNED6) LEFT.LexId = (UNSIGNED6) RIGHT.did,
    TRANSFORM(LEFT), KEEP(1), LIMIT(0));
                        
  pc_recs := pc_recs_rlvl + pc_recs_prelim(RecordType IN FFD.Constants.RecordType.ConsumerLevel);

  slim_pc_recs := FFD.SlimPersonContext(pc_recs);
  
  // get FFD compliance records
  temp_results_ffd := BankruptcyV3_Services.fn_fcra_ffd(temp_rollup, slim_pc_recs, valFFDOptionsMask);
  alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, inFCRAPurpose, valFFDOptionsMask)[1];
  suppress_results_due_alerts := alert_indicators.suppress_records;
  
  // add back to report layout
  all_results := 
    JOIN(out_recs_final, temp_results_ffd,
      LEFT.tmsid = RIGHT.tmsid,
      TRANSFORM(BankruptcyV3_Services.layout_bkv3_rollup_ext,
      SELF.StatementIds := RIGHT.StatementIds,
      SELF.isDisputed := RIGHT.isDisputed,
      SELF := RIGHT, // to get statementids AND isdisputed for debtors child DATASET
      SELF:= LEFT));
  
  final := IF(suppress_results_due_alerts, DATASET([], BankruptcyV3_Services.layout_bkv3_rollup_ext), all_results);
  
  // Consumer Level statements will always be returned along with any alert messages.
  all_statements := IF(ShowConsumerStatements, FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);
  consumer_statements := IF( EXISTS(final), all_statements,
                            all_statements(StatementType IN FFD.Constants.RecordType.StatementConsumerLevel));
  
  consumer_alerts := FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, valFFDOptionsMask);

  matched_party_lexid := dsDIDs[1].did;
  search_lexId := IF(matched_party_lexid > 0 AND ~EXISTS(dsDIDs(did <> matched_party_lexid)), matched_party_lexid, 0);
                        
  // if we cannot resolve to single LexId based on input or matched party results there will be no Consumer data populated
  input_consumer := FFD.MAC.PrepareConsumerRecord(search_lexId, FALSE);
  
  doOutput := SEQUENTIAL(
    OUTPUT(final, NAMED('Results')),
    OUTPUT(consumer_statements,NAMED('ConsumerStatements')),
    OUTPUT(consumer_alerts, NAMED('ConsumerAlerts')),
    OUTPUT(input_consumer, NAMED('Consumer'))
  );

  SEQUENTIAL(
    IF(~returnByDidOnly, OUTPUT(person_filter_id_value, NAMED('person_filter_id'))),
    IF (person_filter_id_value = '' AND ~returnByDidOnly AND NOT include_dockets,
        FAIL('Person filter ID must be used with FCRA report'),
        doOutput)
  );

ENDMACRO;
