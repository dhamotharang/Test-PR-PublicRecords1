/*--SOAP--
<message name="BusinessBatch_BIP">
  <part name="DPPAPurpose"          type="xsd:byte"/>
  <part name="GLBPurpose"           type="xsd:byte"/>
  <part name="Max_Results_Per_Acct" type="xsd:unsignedInt" default=5/>
  <part name="Max_Businesses_Per_Acct" type="xsd:unsignedInt" default=25/>
  <part name="Max_Contacts_Per_Acct" type="xsd:unsignedInt" default=25/>
  <part name="Score_Threshold"       type="xsd:unsignedInt" default=75/>
  <part name="Biz_Score_Threshold"   type="xsd:unsignedInt" default=75/>
  <part name="History_Limit_Years"   type="xsd:unsignedInt" default=2/>
  <part name="Gateways"             type="tns:XmlDataSet" cols="100" rows="8"/>

  <part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/


EXPORT SingleViewService() :=
MACRO
  
  ds_batchIn := DATASET([], BusinessBatch_BIP.Layouts.SingleView.Input) : STORED('Batch_In');
  
  // Standardize input
  BatchShare.MAC_ProcessInput(ds_batchIn, ds_batchInProcessed);

  // get batch params
  batchParams := BusinessBatch_BIP.iParam.SingleView.getSVBatchParams();
  
  sv_records := BusinessBatch_BIP.SingleView_Records(ds_batchInProcessed, batchParams);

  // will return results combined into single dataset
  Results := sv_records.combined_results();

  output(Results, named('Results'));

ENDMACRO;
