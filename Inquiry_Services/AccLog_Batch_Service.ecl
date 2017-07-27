/*--SOAP--
<message name="AccLogBatchService">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>      <!-- [7] must be '0' for non-DMV sources -->
  <part name="DataPermissionMask"  type="xsd:string"/>
	<part name="Max_Results_Per_Acct" type="xsd:unsignedInt" default=5/>
	<part name="BIPFetchLevel" 				type="xsd:string"/>
	
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>

*/

/*--INFO-- ACCLog Inquiry - Service will return inquiry records for businesses. */

EXPORT AccLog_Batch_Service() := MACRO
	WSInput.MAC_Inquiry_Services_ACCLog_Batch_Service()
	
	ds_batchIn := DATASET([],Inquiry_Services.Layouts.Batch_Input) : STORED('Batch_In');
	
  // Standardize input
  BatchShare.MAC_ProcessInput(ds_batchIn,ds_batchInProcessed);
  
  batchParams := Inquiry_Services.Iparam.getBatchParams();
  
	// Get results
	ds_batchResults := Inquiry_Services.Batch_Records(ds_batchInProcessed,batchParams);
  
  BatchShare.MAC_RestoreAcctno(ds_batchInProcessed,ds_batchResults,results);
	
	OUTPUT(results,NAMED('Results'));

ENDMACRO;	

