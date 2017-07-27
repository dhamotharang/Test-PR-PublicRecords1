/*--SOAP--
<message name="SAMBatchService">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>      <!-- [7] must be '0' for non-DMV sources -->
  <part name="DataPermissionMask"  type="xsd:string"/>
	<part name="Max_Results_Per_Acct" type="xsd:unsignedInt" default=5/>
	<part name="BIPFetchLevel" 				type="xsd:string"/>
	
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>

/*--INFO-- SAM - Service will return companies on the gov't debarred list. */

EXPORT Batch_Service() := MACRO
	WSInput.MAC_SAM_Services_Batch_Service()
	
	ds_batchIn := DATASET([],SAM_Services.Layouts.Batch_Input) : STORED('Batch_In');
	
  // Standardize input
  BatchShare.MAC_ProcessInput(ds_batchIn,ds_batchInProcessed);
  
  batchParams := SAM_Services.Iparam.getBatchParams();
  
	// Get results
	ds_batchResults := SAM_Services.Batch_Records(ds_batchInProcessed,batchParams);
  
  BatchShare.MAC_RestoreAcctno(ds_batchInProcessed,ds_batchResults,results);
	
	OUTPUT(results,NAMED('Results'));

ENDMACRO;	

