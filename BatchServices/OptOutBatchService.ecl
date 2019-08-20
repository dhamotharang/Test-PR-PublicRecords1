/*--SOAP--
<message name="OptOutBatchService">
  <part name="DPPAPurpose"          type="xsd:byte"/>
  <part name="GLBPurpose"           type="xsd:byte"/>
  <part name="AllowTestSuppression" type="xsd:unsignedInt" default=FALSE/>

  <part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/


EXPORT OptOutBatchService() := MACRO

  IMPORT BatchServices, BatchShare, ut;
  
  ds_batchIn := DATASET([], BatchServices.OptOut.Layouts.Input) : STORED('Batch_In');
  
  // Standardize input
  BatchShare.MAC_ProcessInput(ds_batchIn, ds_batchInProcessed);

  // get batch params
  batchParams := BatchServices.OptOut.IParams.getBatchParams();

  // check the input, adding lexid if necessary, and get the opt-out data for each record
  ds_checked := BatchServices.OptOut.Functions.CheckInputRecs(ds_batchInProcessed, batchParams);
  Results := BatchServices.OptOut.Records(ds_checked, batchParams);

  //output(ds_batchInProcessed, named('ds_batchInProcessed'));
  //output(ds_dville, named('ds_dville'));
  //output(ds_best, named('ds_best'));
  //output(ds_results, named('ds_results'));

  OUTPUT(Results, NAMED('Results'));

ENDMACRO;	

