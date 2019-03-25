/*--SOAP--
<message name="Batch_Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DPPAPurpose" type="xsd:byte" default="1" />
	<part name="GLBPurpose" type="xsd:byte" default="1" />
	<part name="DataRestrictionMask" type="xsd:string" default="000000000000000000000000" size="24"/>
	<part name="DataPermissionMask" type="xsd:string" default="111111111111111111111111" size="24"/>
	<part name="ApplicationType" type="xsd:string"/>
</message>
*/
/*--INFO-- This service returns marriage and divorce batch records. */
/*--USES-- ut.input_xslt */

import BatchShare;

export Batch_Service () := FUNCTION

  //**** INPUT TRANSFORM
  ds_xml_in := DATASET([], layouts.batch_in) : STORED('batch_in');

  // save original account numbers
  BatchShare.MAC_SequenceInput (ds_xml_in, ds_sequenced);

  // parameters common for all batch input records 
  batch_params := module (project (BatchShare.IParam.getBatchParamsV2(), input.batch_params, opt)) end;
  
  tmp := marriage_divorce_v2_Services.batch_records (batch_params, ds_sequenced);
	ds_batch_out := tmp.Records;
  // Restore original acctno (false -- do not return accounts for which there're no data)
  BatchShare.MAC_RestoreAcctno (ds_sequenced, ds_batch_out, ds_batch_ready, false);

  return OUTPUT(ds_batch_ready, NAMED('RESULT'));

END; 
