
/*--SOAP--
<message name="Experian_Phones_Batch_Service">
	<part name="DPPAPurpose"             type="xsd:byte"/>
	<part name="GLBPurpose"              type="xsd:byte"/> 
	<part name="DataRestrictionMask"     type="xsd:string"/>

	<part name="MaxResults"              type="xsd:unsignedInt"/>
	<part name="Max_Results_Per_Acct"    type="xsd:unsignedInt"/>

	<part name="Include_Phones_Feedback" type="xsd:boolean"/>
	<part name="ReturnDetailedRoyalties" type="xsd:boolean"/>	

	<part name="Gateways"                type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="batch_in"                type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/

IMPORT BatchShare, Doxie, Gateway, Royalty, Suppress;

// See BatchSample module for template, hints, clues, etc.

EXPORT Batch_Service() := MACRO
	
		// **************************************************************************************
		//  Read parameters and XML input. Fail the job at once if insufficient GLB permissions
		//  were provided to the SOAP interface.
		// **************************************************************************************		
		gateways_in  := Gateway.Configuration.Get();
		batch_params := Experian_Phones_Services.IParam.getBatchParams();				
		ds_xml_in    := DATASET( [], Experian_Phones_Services.layouts.batch_in ) : STORED('batch_in', FEW);
		
		IF( NOT batch_params.isValidGlb(),
				FAIL('An error occurred while running Experian_Phones_Services.Batch_Service: invalid GLB purpose.') );

		IF( batch_params.isECHRestricted(), // i.e. if pos #6 = '1'
				FAIL('An error occurred while running Experian_Phones_Services.Batch_Service: invalid DataRestrictionMask value.') );

		// **************************************************************************************
		//  Use common macro to get input file ready for processing. This will take care of
		// 	sequencing the input records, captalizing the fields and, optionally, cleaning up
		//	addresses. NOTE: ds_xml_in_seq will have Batchshare.Layouts.ShareErrors and 
		//  orig_acctno appended.
		// **************************************************************************************				
		BatchShare.MAC_SequenceInput(ds_xml_in, ds_xml_in_seq);
		BatchShare.MAC_CapitalizeInput(ds_xml_in_seq, ds_xml_in_cap);
		BatchShare.MAC_CleanAddresses(ds_xml_in_cap, ds_xml_in_clean_addrs);

		// **************************************************************************************
		//    Call main attribute to fetch records. 
		// **************************************************************************************
		ds_batch_in := PROJECT( ds_xml_in_clean_addrs, Experian_Phones_Services.layouts.batch_in_plus );
		m_BatchView := Experian_Phones_Services.Records.BatchView(ds_batch_in, gateways_in, batch_params);

		ds_Experian_recs                     := m_BatchView.results;
		ds_batch_in_for_suppression          := m_BatchView.batch_in_common;

		// **************************************************************************************
		//  Apply data restrictions and/or supressions. Results must always be suppressed 
		//  by ssn or did before returning.
		// **************************************************************************************
		Suppress.MAC_Suppress(ds_batch_in_for_suppression, ds_batch_in_sup_1, batch_params.application_type,,,Suppress.Constants.LinkTypes.DID, did);			
		Suppress.MAC_Suppress(ds_batch_in_sup_1, ds_batch_in_sup_2, batch_params.application_type,,,Suppress.Constants.LinkTypes.SSN, ssn);			

		ds_Experian_recs_suppressed := 
			JOIN(
				ds_Experian_recs, ds_batch_in_sup_2,
				LEFT.acctno = RIGHT.acctno,
				TRANSFORM(LEFT),
				INNER
			);
		
		// **************************************************************************************
		//    Restore original acctno and format to output layout.
		// **************************************************************************************						
		BatchShare.MAC_RestoreAcctno(ds_batch_in, ds_Experian_recs_suppressed, ds_Experian_recs_ready)		
		ds_Experian_recs_out := PROJECT(ds_Experian_recs_ready, Experian_Phones_Services.Layouts.batch_out);				
		
		// Get the max_results_per_acct here. If necessary, attach the acctnos back to the matching documents 
		// first, sort, group, and then get max_results_per_acct using TOPN, which honors groupings. Note that 
		// we're getting max_results_per_acct in this sample service following the business rule that we want the 
		// most recent records. There may be different business rules in your product that will influence 
		// how you determine which records make it into the max_results_per_acct (e.g. lowest penalty).
		ds_Experian_recs_grouped := GROUP(SORT(ds_Experian_recs_out, acctno), acctno);
		ds_top_Experian_recs_grouped := UNGROUP(TOPN(ds_Experian_recs_grouped, batch_params.MaxResultsPerAcct, acctno));		

		// **************************************************************************************
		//    Make sure we also apply required masks before returning results.
		// **************************************************************************************
		//
		// No masking is required.

		results := SORT(ds_top_Experian_recs_grouped, acctno);
		 
		// **************************************************************************************
		//                                         DEBUGs
		// **************************************************************************************	
		// OUTPUT( m_BatchView.inhouse_Experian_recs            , NAMED('inhouse_Experian_recs') );
		// OUTPUT( m_BatchView.inhouse_Experian_recs_for_Gateway, NAMED('inhouse_Experian_recs_for_Gateway') );
		// OUTPUT( m_BatchView.Experian_gateway_records         , NAMED('Experian_gateway_records') );         
		// OUTPUT( m_BatchView.Telcordia_recs                   , NAMED('Telcordia_recs') );                   
		// OUTPUT( m_BatchView.Experian_recs_having_feedback    , NAMED('Experian_recs_having_feedback') );    
		// OUTPUT( m_BatchView.matching_records                 , NAMED('matching_records') );                 
		// OUTPUT( m_BatchView.nonmatching_records              , NAMED('nonmatching_records') );              
		
		// **************************************************************************************
		//    Output results. *Business rule*: output dataset must be named 'Results'.
		// **************************************************************************************			
		OUTPUT(results, named('Results'));
		OUTPUT(m_BatchView.royalties,named('RoyaltySet'));
		
ENDMACRO;
