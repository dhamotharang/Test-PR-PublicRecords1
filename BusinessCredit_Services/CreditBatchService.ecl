/*--SOAP--
<message name="CreditBatchService">
  <message name="BusinessBatch_BIP">
	<part name="DPPAPurpose"          			type="xsd:byte"/>
	<part name="GLBPurpose"           			type="xsd:byte"/>
	<part name="Max_Search_Results_Per_Acct" type="xsd:unsignedInt" default=5/>
	<part name="Max_Results_Per_Acct" 			type="xsd:unsignedInt" default=5/>
	<part name="BIPFetchLevel" 							type="xsd:string"/>
	<part name="DataPermissionMask"    			type="xsd:string"/>
	<part name="Include_BusHeader"    			type="xsd:string"/>

	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/

IMPORT BatchShare, BusinessCredit_Services;

EXPORT CreditBatchService() := MACRO

	ds_batchIn := DATASET([],BusinessCredit_Services.Batch_layouts.Batch_Input) : STORED('Batch_In');

	  // Standardize input
  BatchShare.MAC_ProcessInput(ds_batchIn,ds_batchInProcessed);
	
	batchParams := BusinessCredit_Services.iParam.getBatchParams();
  
	ds_batchResults := BusinessCredit_Services.Batch_Records(ds_batchInProcessed,batchParams);
  
  BatchShare.MAC_RestoreAcctno(ds_batchInProcessed,ds_batchResults,results);

	OUTPUT(results,NAMED('Results'));
	
ENDMACRO;