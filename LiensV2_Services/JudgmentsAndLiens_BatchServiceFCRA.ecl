/*--SOAP--
<message name="JudgmentsAndLiens_BatchServiceFCRA">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
		
	<part name="MaxResults"           type="xsd:unsignedInt"/>
	<part name="Max_Results_Per_Acct" type="xsd:byte"/>	
	
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
	
	<part name="Match_Attorneys"      type="xsd:boolean"/>
	<part name="Match_Creditors"      type="xsd:boolean"/>
	<part name="Match_Debtors"        type="xsd:boolean"/>
	<part name="PenaltThreshold"      type="xsd:unsignedInt"/>
	
	<part name="NonSubjectSuppression" type="xsd:unsignedInt" default="2"/> <!-- [1,2,3] -->
  <part name="Gateways" type="tns:XmlDataSet" cols="70" rows="8"/>
	<part name="FFDOptionsMask" type="xsd:string"/>
	<part name="FCRAPurpose" type="xsd:string"/>

</message>
*/

IMPORT LiensV2_Services, BatchShare, BatchServices, FFD, Gateway, ut;

EXPORT JudgmentsAndLiens_BatchServiceFCRA(useCannedRecs = 'false') := 
	MACRO
	
		#OPTION('optimizeProjects', TRUE);
		
		#CONSTANT('getBdidsbyExecutive',FALSE);
		#CONSTANT('SearchGoodSSNOnly',TRUE);
		#CONSTANT('SearchIgnoresAddressOnly',TRUE);
		#STORED('ScoreThreshold',10);
		
		// FFD				 
		INTEGER8 inFFDOptionsMask := FFD.FFDMask.Get();				
		INTEGER inFCRAPurpose := FCRA.FCRAPurpose.Get();				
	
		BOOLEAN isFCRA := TRUE;		
		gw_config := Gateway.Configuration.Get();
		
		// 1. Build party_type set.
		BOOLEAN match_attorneys      := FALSE : STORED('Match_Attorneys');
		BOOLEAN match_creditors      := FALSE : STORED('Match_Creditors');
		BOOLEAN match_debtors        := FALSE : STORED('Match_Debtors');
		// Return all records if either all the booleans are true, or all are false. The reason is 
		// because it's common to run a batch job without checking any parties and yet expect the 
		// system to return all results. Strictly a concession to human behavior.
		BOOLEAN all_or_none_are_checked := (match_attorneys AND match_creditors AND match_debtors) OR
		                                    NOT (match_attorneys OR match_creditors OR match_debtors);
		SET OF STRING1 attorney_type := IF( match_attorneys, ['A'], [] );
		SET OF STRING1 creditor_type := IF( match_creditors, ['C'], [] );
		SET OF STRING1 debtor_type   := IF( match_debtors,   ['D'], [] );
		SET OF STRING1 partyTypes   := IF( all_or_none_are_checked, 
		                                    ['A','C','D',''],
		                                    attorney_type + creditor_type + debtor_type
		                                   );
				
		// 2. Grab the input XML and throw into a dataset.	
		ds_xml_in_raw 	:= DATASET([], LiensV2_Services.Batch_Layouts.batch_in) : STORED('batch_in', FEW);
		ds_xml_in := IF( NOT useCannedRecs, 
										 ds_xml_in_raw, 
										 PROJECT(BatchServices._Sample_inBatchMaster('JUDGEMENTSLIENS'), LiensV2_Services.Batch_Layouts.batch_in)
									  );	
		//non-subject suppression
		nss := ut.getNonSubjectSuppression (Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription);
		gm := AutoStandardI.GlobalModule(isFCRA);	
		batch_params		:= BatchShare.IParam.getBatchParams();
		
		jl_batch_params := module(PROJECT(batch_params, LiensV2_Services.IParam.batch_params, opt))
			EXPORT UNSIGNED8 MaxResults   										:= 10000 : STORED('MaxResults');	
			INTEGER max_results_per_acct 											:= 1000 : STORED('Max_Results_Per_Acct');	
			EXPORT MaxResultsPerAcct 													:= max_results_per_acct;
			EXPORT party_types 																:= partyTypes;
			EXPORT DATASET (Gateway.layouts.config) gateways 	:= gw_config;
			EXPORT INTEGER1 non_subject_suppression 					:= nss;
			EXPORT applicationType 														:= AutoStandardI.InterfaceTranslator.application_type_val.val(PROJECT(gm,AutoStandardI.InterfaceTranslator.application_type_val.params));
			EXPORT INTEGER8 FFDOptionsMask 								    := inFFDOptionsMask | FFD.Constants.ConsumerOptions.SHOW_CONSUMER_STATEMENTS;  // we need to override 1st bit here to make sure records with statements are flagged in Batch_records. Dempsey Hits filtering is done later if needed
			EXPORT INTEGER  FCRAPurpose    								    := inFCRAPurpose;
		END;
		
		BatchShare.MAC_SequenceInput(ds_xml_in, ds_batch_in);
		
		// append DID (a soap call to Picklist service
		BatchShare.MAC_AppendPicklistDID (ds_batch_in, ds_batch_did, jl_batch_params, IsFCRA);	
		
		//FCRA FFD 
		dids := PROJECT(ds_batch_did(did>0), FFD.Layouts.DidBatch); 

		pc_recs := IF(isFCRA, FFD.FetchPersonContext(dids, gw_config, FFD.Constants.DataGroupSet.Liens, inFFDOptionsMask));
		slim_pc_recs := FFD.SlimPersonContext(pc_recs);
		
		// overrides for FCRA
		ds_best  := project(ds_batch_did,transform(doxie.layout_best,self.did:=left.did, self:=[])); //using input to create dataset for getting the flag file (overrides). For FCRA we only use DID to get overrides.
		ds_flags := if(isFCRA, FFD.GetFlagFile (ds_best, pc_recs)); //this is for more than one person

		// Search for J&L records by party.
		ds_batch_out := LiensV2_Services.Batch_records(ds_batch_did, jl_batch_params, isFCRA, slim_pc_recs, ds_flags);
		
		ds_JL_recs_flat_pre := PROJECT(ds_batch_out, LiensV2_Services.fcra_batch_make_flat(LEFT,COUNTER));
				
	  alert_flags := FFD.ConsumerFlag.getAlertIndicators(pc_recs, inFCRAPurpose, inFFDOptionsMask);
	  ds_JL_recs_flat_with_alerts := FFD.Mac.ApplyConsumerAlertsBatch(ds_JL_recs_flat_pre, alert_flags, statements, LiensV2_Services.Batch_Layouts.fcra_batch_out_pre, inFFDOptionsMask);

    // add resolved LexId to the results for inquiry history logging support                    
    ds_flat_with_inquiry := FFD.Mac.InquiryLexidBatch(ds_batch_did, ds_JL_recs_flat_with_alerts, LiensV2_Services.Batch_Layouts.fcra_batch_out_pre, 0);

		ds_statements := NORMALIZE (ds_flat_with_inquiry, LEFT.statements, 
			TRANSFORM (FFD.Layouts.ConsumerStatementBatch, SELF := RIGHT));
			
		// consumer statements dataset contains information about disputed records as well as Statements.
		consumer_statements_prep := FFD.prepareConsumerStatementsBatch(ds_statements, pc_recs, inFFDOptionsMask);
    consumer_alerts  := FFD.ConsumerFlag.prepareAlertMessagesBatch(pc_recs, alert_flags, inFFDOptionsMask);                                               
    consumer_statements_alerts_pre := consumer_statements_prep + consumer_alerts;
		
		ds_JL_recs_flat := PROJECT(ds_flat_with_inquiry, LiensV2_Services.Batch_Layouts.fcra_batch_out);
				
		BatchShare.MAC_RestoreAcctno(ds_batch_in, ds_JL_recs_flat, ds_JL_recs_flat_out);
		BatchShare.MAC_RestoreAcctno(ds_batch_in, consumer_statements_alerts_pre, consumer_statements_alerts, FALSE, FALSE);

		pre_result := SORT(ds_JL_recs_flat_out, acctno, penalt, -orig_filing_date, -release_Date, filing_jurisdiction, orig_filing_number);
		pre_resultSlim := UNGROUP(TOPN(GROUP(pre_result, acctno), jl_batch_params.MaxResultsPerAcct,acctno));
		
		ut.mac_TrimFields(pre_resultSlim, 'pre_resultSlim', result);

		OUTPUT(result, NAMED('Results'));
		OUTPUT(consumer_statements_alerts, NAMED('CSDResults'));
		
ENDMACRO;	