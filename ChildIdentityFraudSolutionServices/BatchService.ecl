/*--SOAP--
<message name="BatchService">
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
  <part name="DataPermissionMask"   type="xsd:string"/>
  <part name="DataRestrictionMask"  type="xsd:string"/>
  <part name="IndustryClass"        type="xsd:string"/>
	<part name="ScoreThreshold" 			type="xsd:unsignedInt"/>
  <part name="TaxYearsToIgnore" 		type="xsd:unsignedInt"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="4"/>
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="ReturnDetailedRoyalties" type="xsd:boolean"/> 	
</message>
*/

/*

*/

IMPORT AutoStandardI, BatchShare, Suppress;

// **************************************************************************************
//
//   TBD: add a quick high level view of the flow.
//
// **************************************************************************************

EXPORT BatchService(useCannedRecs = false) := 
	MACRO
		/* Some of the older batch services that we are calling read, stored 
			 values including of PenaltThreshold in the records attribute.
			 In absence of a defined stored, they have a default value. 
       When these default values are different, it creates an error. We are 
			 hardcoding below to get around that issue. Ideally it will be removed. 	 	
   */
		#constant('PenaltThreshold',10);
		#stored('ExcludeInputAddrNeighbors',true);
		#stored('ExcludeUpdateAddrNeighbors',true);
		#stored('RelativesDepth',1);

		
		
		// **************************************************************************************
		//   Read parameters and XML input. 
		// **************************************************************************************		
		batch_params		:= ChildIdentityFraudSolutionServices.IParam.getBatchParams();				
		ds_xml_in_raw  	:= DATASET([], ChildIdentityFraudSolutionServices.Layouts.BatchIn) : STORED('batch_in', FEW);
		ds_xml_in 			:= if( useCannedRecs, ChildIdentityFraudSolutionServices.BatchCannedInput, ds_xml_in_raw);				

		// **************************************************************************************
		//   Use common macro to get input file ready for processing. 
		// **************************************************************************************				
		BatchShare.MAC_SequenceInput(ds_xml_in, ds_xml_in_seq);		
		BatchShare.MAC_CapitalizeInput(ds_xml_in_seq, ds_batch_in);

		// **************************************************************************************
		//    Call main attribute to fetch records. 
		// **************************************************************************************
		ds_recs_full		:= ChildIdentityFraudSolutionServices.BatchRecords(ds_batch_in, batch_params);
		ds_recs_results := ds_recs_full.Records;
		
		// **************************************************************************************
		//    Restore original acctno and format to output layout.
		// **************************************************************************************						
		BatchShare.Mac_RestoreAcctno(ds_batch_in, ds_recs_results, ds_Results,,false);
		Royalty.MAC_RestoreAcctno(ds_batch_in, ds_recs_full.Royalties, ds_Royalties);
		
				
		Results	:= sort(ds_results, acctno);
		
		output(Results, named('Results'));
		output(ds_Royalties, named('RoyaltySet'));
		
		
ENDMACRO;	