/*--SOAP--
<message name="BankruptcyReportServiceFCRA">
  <part name="PersonFilterID"       type="xsd:string"/>
  <part name="TMSID"             type="xsd:string"/>
  <part name="DID"                 type="xsd:string"/>
  <part name="PartyType"          type="xsd:string"/>
  <part name="SSNMask"                  type="xsd:string"/>
  <part name="IncludeDockets"      type="xsd:boolean"/>
  <part name="LowerEnteredDateLimit"  type="xsd:string"/>
  <part name="UpperEnteredDateLimit"  type="xsd:string"/>
  <part name="ApplicationType"     type="xsd:string"/>
  <part name="NonSubjectSuppression" type="xsd:unsignedInt" default="2"/> <!-- [1,2,3] -->
  <part name="ApplyNonsubjectRestrictions" type="xsd:boolean"/> 
  <part name="SuppressWithdrawnBankruptcy" type="xsd:boolean"/> 
</message>
*/
/*--INFO-- This service returns one Bankruptcy Record and one debtor, limited by person filter ID.*/

import doxie, bankruptcyv3_services, WSInput, FFD, FCRA;

export BankruptcyReportServiceFCRA() :=  macro

  //The following macro defines the field sequence on WsECL page of query.
  WSInput.MAC_BankruptcyV3_Services_BankruptcyReportServiceFCRA();  
  
  doxie.MAC_Header_Field_Declare(true);
  
  #constant('NoDeepDive', true);
  
  string person_filter_id_value   := ''     : stored('PersonFilterID');
  boolean include_dockets         := false   : stored('IncludeDockets');
  string8 lower_entered_date      := ''      : stored('LowerEnteredDateLimit');
  string8 upper_entered_date      := ''      : stored('UpperEnteredDateLimit');

  //Check if the customer is a Collections customer
  fcra_subj_only := false : stored ('ApplyNonsubjectRestrictions');
  boolean isCollections := application_type_value IN AutoStandardI.Constants.COLLECTION_TYPES;
  const_nss := Suppress.Constants.NonSubjectSuppression;
  nss := ut.GetNonSubjectSuppression(const_nss.doNothing);
  boolean returnByDidOnly := fcra_subj_only OR isCollections;
  boolean suppress_withdrawn_bankruptcy  := false   : stored('SuppressWithdrawnBankruptcy');
  
  // For FCRA FFD
  
  valFFDOptionsMask := FFD.FFDMask.Get(inApplicationType := application_type_value);
  boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(valFFDOptionsMask);
  dataset (Gateway.layouts.config) gateways := Gateway.Configuration.Get();  
  unsigned6 input_did := (unsigned6) did_value;
  integer inFCRAPurpose := FCRA.FCRAPurpose.Get();

  // Adjust party-type: only [D]ebtors should be used for collections:
  string party_type_adj := if (returnByDidOnly, BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR, party_type);

  out_recs := Bankruptcyv3_Services.bankruptcy_raw(true).source_view( in_ssn_mask := ssn_mask_value,
                                                                      in_party_type := party_type_adj,
                                                                       include_dockets := include_dockets,
                                                                      lower_entered_date := lower_entered_date,
                                                                      upper_entered_date := upper_entered_date,
                                                                      suppress_withdrawn_bankruptcy := suppress_withdrawn_bankruptcy);
  
  key_court := bankruptcyv3.key_bankruptcyv3_courts;
  
  BankruptcyV3_Services.layout_bkv3_rollup_ext addCourtInfo(bankruptcyv3_services.layouts.layout_rollup L,
                                            recordof(key_court) R) := transform
      self.court.moxie_court := L.court_code;
      self.court.address1 :=     R.address1;
      self.court.city :=         R.city;
      self.court.state :=       R.state;
      self.court.zip :=         R.zip;
      self.court.phone :=       R.phone;
      self.court.district :=     R.district;
      self.court.cfiled :=       R.cfiled;
      self.court.boca_court :=   R.boca_court;
      self.court.c3courtid :=   R.c3courtid;
      
      self.court.address2    :=   R.address2;
      self.court.fax      :=   R.fax;
      self.court.courtID    :=   R.courtID;
      self.court.div      :=   R.div;
      self.court.hoganID    :=   R.hoganID;
      self.court.court    :=  R.court;
      self.court.active    :=  R.active;
      
      self := L;                                      
  end;
  
  // append missing court data
  out_recs_court := join(  out_recs, 
                          key_court, 
                          keyed(left.court_code = right.moxie_court),
                          addCourtInfo(left, right), LEFT OUTER, 
                          LIMIT(0));
                          
  out_recs_court_ddp := dedup(sort(out_recs_court,tmsid,record), tmsid);
  
  // apply non-subject suppression, if any
  BankruptcyV3_Services.layout_bkv3_rollup_ext xformNonSubject(BankruptcyV3_Services.layout_bkv3_rollup_ext L) := transform
  
    debtors_did := L.debtors((unsigned6)did = (unsigned6)did_value);
    debtors_filter := L.debtors(person_filter_id = person_filter_id_value or (person_filter_id_value = '' and include_dockets));
    
    debtors_chosen := if(did_value <> '', debtors_did, debtors_filter);
 
    // apply non-subject suppression, if requested
    debtors_supp := project(debtors_chosen((unsigned6)did = (unsigned6)did_value),
                           transform(BankruptcyV3_Services.layouts.layout_party,
                                     self.names := project(left.names, transform(BankruptcyV3_Services.layouts.layout_name,
                                                                                 self.orig_name := '', 
                                                                                 self := left)),
                                     self := left));
    
    debtors_restricted := debtors_supp + project(debtors_chosen(~((unsigned6)did = (unsigned6)did_value)), 
                                                 transform(BankruptcyV3_Services.layouts.layout_party,
                                                          self.names := project(left.names, 
                                                                                transform(BankruptcyV3_Services.layouts.layout_name,
                                                                                          self.lname := FCRA.Constants.FCRA_Restricted, 
                                                                                          self := [])),
                                                          self := []));
    self.debtors := map(nss = const_nss.returnRestrictedDescription => debtors_restricted, 
                        nss = const_nss.returnBlank => debtors_supp,
                        debtors_chosen);
    self := L;
  end;
  out_recs_final := project(out_recs_court_ddp, xformNonSubject(left));
  
  //*************FCRA FFD --- getting FFD statements for matched parties only
  
  //projecting to common layout for fn_fcra_ffd call
  temp_rollup := project(out_recs_final, bankruptcyv3_services.layouts.layout_rollup);
  
  did_batch_exp_rec := record(FFD.Layouts.DidBatch)
    boolean is_debtor := false;
  end;

  // for call to PC we need to grab all dids even if subject is not debtor
  matched_rec_dids := dedup(sort(project(temp_rollup,           
                            transform(did_batch_exp_rec,
                              _debtor := left.debtors(did = left.matched_party.did);
                              self.is_debtor := exists(_debtor),
                              self.did := (unsigned6) left.matched_party.did, 
                              self.acctno := FFD.Constants.SingleSearchAcctno)),
                              did, -is_debtor), did);
                              
  ds_subj_did := dataset([{FFD.Constants.SingleSearchAcctno, input_did}], FFD.Layouts.DidBatch);
    
  // even if no data found we still need to check for alerts and consumer level statements for subject
  dsDIDs := if(exists(matched_rec_dids(did>0)), project(matched_rec_dids(did>0), FFD.Layouts.DidBatch), ds_subj_did);

  //  call person context
  pc_recs_prelim := FFD.FetchPersonContext(dsDIDs, gateways, FFD.Constants.DataGroupSet.Bankruptcy, valFFDOptionsMask);
  
  // for record level statement/dispute  filter to keep data only if subject is debtor
  pc_recs_rlvl := join(pc_recs_prelim(RecordType IN FFD.Constants.RecordType.RecordLevel), 
                        matched_rec_dids(is_debtor),
                        (unsigned6) left.LexId = (unsigned6) right.did,
                        transform(left), keep(1), limit(0));
                        
  pc_recs := pc_recs_rlvl + pc_recs_prelim(RecordType in FFD.Constants.RecordType.ConsumerLevel);

  slim_pc_recs := FFD.SlimPersonContext(pc_recs);
  
  // get FFD compliance records
  temp_results_ffd  := BankruptcyV3_Services.fn_fcra_ffd(temp_rollup, slim_pc_recs, valFFDOptionsMask);
  alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, inFCRAPurpose, valFFDOptionsMask)[1];
  suppress_results_due_alerts := alert_indicators.suppress_records;
  
  // add back to report layout
  all_results := join(out_recs_final, temp_results_ffd,
                    left.tmsid = right.tmsid,
                    transform(BankruptcyV3_Services.layout_bkv3_rollup_ext,
                    self.StatementIds := right.StatementIds,
                    self.isDisputed := right.isDisputed,
                    self := right, // to get statementids and isdisputed for debtors child dataset
                    self:= left));
  
  final := if(suppress_results_due_alerts, dataset([], BankruptcyV3_Services.layout_bkv3_rollup_ext), all_results); 
  
  // Consumer Level statements will always be returned along with any alert messages.
  all_statements := IF(ShowConsumerStatements, FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);
  consumer_statements := if( exists(final), all_statements,
                            all_statements(StatementType IN FFD.Constants.RecordType.StatementConsumerLevel));
  
  consumer_alerts := FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, valFFDOptionsMask);

  matched_party_lexid := dsDIDs[1].did;
  search_lexId := if(matched_party_lexid > 0 and ~exists(dsDIDs(did <> matched_party_lexid)), matched_party_lexid, 0);
                        
  // if we cannot resolve to single LexId based on input or matched party results there will be no Consumer data populated
  input_consumer := FFD.MAC.PrepareConsumerRecord(search_lexId, false);
	
  doOutput := sequential(
    output(final, named('Results')),
    output(consumer_statements,named('ConsumerStatements')),
    output(consumer_alerts, named('ConsumerAlerts')),  
    output(input_consumer, named('Consumer')));  
    
  
  sequential(
              if(~returnByDidOnly, output(person_filter_id_value, named('person_filter_id'))),
              if (person_filter_id_value = '' AND ~returnByDidOnly AND NOT include_dockets, 
                  FAIL('Person filter ID must be used with FCRA report'),
                  doOutput));

endmacro;
