/*--SOAP--
<message name="BusinessBatch_BIP">
  <part name="DPPAPurpose"          type="xsd:byte"/>
  <part name="GLBPurpose"           type="xsd:byte"/>
  <part name="Max_Results_Per_Acct" type="xsd:unsignedInt" default=5/>
  <part name="Best_Only" 						type="xsd:boolean" default=false/>
  <part name="Use_Append" 					type="xsd:boolean" default=false/>
  <part name="ExcludeExperian" 			type="xsd:boolean" default=false/>
  <part name="Score_Threshold"       type="xsd:unsignedInt" default=75/>
  <part name="OFAC_Version"         type="xsd:integer"/>
  <part name="Gateways"             type="tns:XmlDataSet" cols="100" rows="8"/>

  <part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/


EXPORT RollupService() :=
MACRO
  
  ds_batchIn := DATASET([], BusinessBatch_BIP.Layouts.Input) : STORED('Batch_In');
  
  // Standardize input
  BatchShare.MAC_ProcessInput(ds_batchIn, ds_batchInProcessed);

  // get batch params
  batchParams := BusinessBatch_BIP.iParam.getBatchParams();
  
  ds_batchResults := BusinessBatch_BIP.Records(ds_batchInProcessed, batchParams);
  
  BatchShare.MAC_RestoreAcctno(ds_batchInProcessed, ds_batchResults, ds_results);
    
  ut.mac_TrimFields(ds_results, 'ds_results', Results);
  
  OUTPUT(Results, NAMED('Results'));

ENDMACRO;	

