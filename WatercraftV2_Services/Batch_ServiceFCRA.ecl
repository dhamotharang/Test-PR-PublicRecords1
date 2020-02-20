/*--SOAP--
<message name="Batch_ServiceFCRA">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string" default="000000000000000000000000" size="24"/>
	<part name="DataPermissionMask" type="xsd:string" default="111111111111111111111111" size="24"/>
	<part name="Return_Current_Only" type="xsd:boolean"/>
	<part name="MaxResults" type="xsd:unsignedInt"/>
	<part name="NonSubjectSuppression" type="xsd:unsignedInt" default="2"/> <!-- [1,2,3] -->
	<part name="FFDOptionsMask"      type="xsd:string"/>
	<part name="FCRAPurpose"      type="xsd:string"/>
  <part name="Gateways" type="tns:XmlDataSet" cols="70" rows="8"/>
</message>
*/
/*--INFO-- This service returns watercraft batch records with FCRA restrictions.<p/>
					 When using NonSubjectSuppression:<br/>
					 -1: no co-owners suppression<br/>
					 -2: co-owners are blanked and lname is overriden with value "FCRA Restricted"<br/>
					 -3: co-owners are suppressed<p/>
					 The default behavior for NonSubjectSuppression is 2.*/

IMPORT BatchShare, WatercraftV2_Services, Gateway, suppress, ut, FFD, STD;

EXPORT Batch_ServiceFCRA () := MACRO
	boolean IsFCRA := true;
	
   /*  IMPORTANT : It is a known issue that currently the code is not a
									able to diffrentiate between the statements and disputes to 
									common records of multiple subjects that might be given in the input 
                  that owne the same watercraft. We should be joinning using DID 
                  or acctno in addition the persistent record identifiers. 
                  A record is not inherently disputed/statemented , but it is 
									disputed/statemented by a DID and for that same DID. 
									This will be fixed as soon as FCRA correction code is fixed 
									to act that way too. 
  */
	// input batch records
	rec_in := WatercraftV2_Services.Layouts.batch_in;
	ds_xml_in		:= DATASET([], rec_in) : STORED('batch_in', FEW);
	gw_config := Gateway.Configuration.Get();
	
	// FFD			
	integer8 inFFDOptionsMask := FFD.FFDMask.Get();		
	integer8 inFCRAPurpose := FCRA.FCRAPurpose.Get();		
	
	//non-subject suppression
  nss := ut.getNonSubjectSuppression (Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription);
	
  // common batch settings, including a gateway to a remote Picklist
	batch_params := module (project (BatchShare.IParam.getBatchParams(), WatercraftV2_Services.Interfaces.batch_params, opt))
    export dataset (Gateway.layouts.config) gateways := gw_config;
		export integer1 non_subject_suppression := nss;
		export integer8 FFDOptionsMask := inFFDOptionsMask | FFD.Constants.ConsumerOptions.SHOW_CONSUMER_STATEMENTS; // we need to override 1st bit here to make sure records with statements are flagged correctly. Dempsey Hits filtering is done separately (if needed)
		export integer8 FCRAPurpose := inFCRAPurpose;
  end;
	
  // run input through some standard procedures
	BatchShare.MAC_SequenceInput(ds_xml_in, ds_sequenced);
	BatchShare.MAC_CapitalizeInput(ds_sequenced, ds_batch_in);

  // append DID (a soap call to Picklist service
	BatchShare.MAC_AppendPicklistDID (ds_batch_in, ds_batch_did, batch_params, IsFCRA);		
	
  //FCRA FFD 	
	dids := project(ds_batch_did(did>0),FFD.Layouts.DidBatch); 
	
	pc_recs := FFD.FetchPersonContext(dids, gw_config, FFD.Constants.DataGroupSet.Watercraft);	
	slim_pc_recs	:= FFD.SlimPersonContext(pc_recs);
	
	// overrides - For FCRA we only use DID to get overrides.
	ds_best  := project(ds_batch_did,transform(doxie.layout_best,self.did:=left.did, self:=[]));
	ds_flags := if(isFCRA, FFD.GetFlagFile(ds_best, pc_recs));
	
	ds_batch_out := WatercraftV2_Services.BatchRecords(batch_params, ds_batch_did, IsFCRA, slim_pc_recs, ds_flags);
	
	alert_flags := FFD.ConsumerFlag.getAlertIndicators(pc_recs, inFCRAPurpose, inFFDOptionsMask);

	// Project to the batch_out_pre layout.
	ds_batch_watercraft_pre := PROJECT(ds_batch_out, WatercraftV2_Services.Transforms.xform_toFinalBatch(LEFT,counter));
  
  ds_records_with_alerts := FFD.Mac.ApplyConsumerAlertsBatch(ds_batch_watercraft_pre, alert_flags, Statements, WatercraftV2_Services.Layouts.batch_out_pre, inFFDOptionsMask);
	                            
	// add resolved LexId to the results for inquiry history logging support                    
  ds_batch_final_pre := FFD.Mac.InquiryLexidBatch(ds_batch_did, ds_records_with_alerts, WatercraftV2_Services.Layouts.batch_out_pre, 0);

	ds_statements := NORMALIZE(ds_batch_final_pre, left.Statements,
											TRANSFORM(FFD.Layouts.ConsumerStatementBatch,
												SELF.SequenceNumber := LEFT.SequenceNumber,
												SELF.acctno := LEFT.acctno, 
												SELF := RIGHT));

	consumer_statements_prep := FFD.prepareConsumerStatementsBatch(ds_statements, pc_recs, inFFDOptionsMask);	
  consumer_alerts  := FFD.ConsumerFlag.prepareAlertMessagesBatch(pc_recs, alert_flags, inFFDOptionsMask);                                               
  consumer_statements_alerts_pre := consumer_statements_prep + consumer_alerts;
	
	//Actual project to the final batch out 
	ds_batch_final := PROJECT(ds_batch_final_pre, WatercraftV2_Services.Layouts.batch_out);	
	
	BatchShare.MAC_RestoreAcctno(ds_batch_did, ds_batch_final, ds_batch_final_out);
	BatchShare.MAC_RestoreAcctno(ds_batch_did, consumer_statements_alerts_pre, consumer_statements_alerts, false, false);

	results	:= SORT(ds_batch_final_out, acctno, penalt);
		
  OUTPUT(results, NAMED('RESULTS'), ALL);
  OUTPUT(consumer_statements_alerts, NAMED('CSDResults'));
	 
ENDMACRO;
