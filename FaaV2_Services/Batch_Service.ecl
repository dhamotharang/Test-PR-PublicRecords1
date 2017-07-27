/*--SOAP--
<message name="Batch_Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string" default="000000000000000000000000" size="24"/>
	<part name="DataPermissionMask" type="xsd:string" default="111111111111111111111111" size="24"/>
	<part name="BIPFetchLevel"        type="xsd:string"/>
</message>
*/
/*--INFO-- This service returns aircraft registrations batch records. */
/*--USES-- ut.input_xslt */

import BatchShare, faa;

export Batch_Service () := FUNCTION
  
  //**** INPUT TRANSFORM
  ds_xml_in := DATASET([], FaaV2_Services.Layouts.batch_in) : STORED('batch_in');
	
	BatchShare.MAC_SequenceInput(ds_xml_in, ds_sequenced);
  // BatchShare.MAC_CapitalizeInput(ds_sequenced, ds_batch_in);

  // parameters common for all batch input records 
	batch_params := FaaV2_Services.IParam.getBatchParams();
  
  ds_batch_out := FaaV2_Services.batch_records (batch_params, ds_sequenced);

  // Restore original acctno and format to output layout (false == do not return accounts for which data was not found).
  BatchShare.MAC_RestoreAcctno (ds_sequenced, ds_batch_out.records, ds_batch_ready, false);  
	
  return OUTPUT(ds_batch_ready, NAMED('RESULT'));

END; 
