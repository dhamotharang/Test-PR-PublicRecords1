/*--SOAP--
<message name="Batch_ServiceFCRA">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string" default="000000000000000000000000" size="24"/>
	<part name="DataPermissionMask" type="xsd:string" default="111111111111111111111111" size="24"/>
	<part name="FFDOptionsMask"      type="xsd:string"/>
	<part name="FCRAPurpose"      type="xsd:string"/>
  <part name="Gateways" type="tns:XmlDataSet" cols="70" rows="8"/>
</message>
*/
/*--INFO-- This service returns aircraft registrations batch records with FCRA restrictions. */

import BatchShare;

export Batch_ServiceFCRA () := MACRO
	boolean IsFCRA := true;
  
  //**** INPUT TRANSFORM
  ds_xml_in := DATASET([], FaaV2_Services.Layouts.batch_in) : STORED('batch_in');

  BatchShare.MAC_SequenceInput(ds_xml_in, ds_sequenced);

	//non-subject suppression isn't needed here: each record may contain at most one person

  // common batch settings, including a gateway to a remote Picklist
	batch_params := FaaV2_Services.IParam.getBatchParams(IsFCRA);
		
  // append DID (a soap call to Picklist service
	BatchShare.MAC_AppendPicklistDID (ds_sequenced, ds_batch_did, batch_params, IsFCRA);		

  ds_batch_out := FaaV2_Services.batch_records (batch_params, ds_batch_did, IsFCRA);
  
  // Restore original acctno and format to output layout.        
  // BatchShare.MAC_RestoreAcctno (ds_batch_did, ds_batch_out, ds_batch_ready, false);
  // for testing purposes I will return all accounts for now:
  BatchShare.MAC_RestoreAcctno (ds_batch_did, ds_batch_out.records, ds_batch_ready);
  BatchShare.MAC_RestoreAcctno(ds_batch_did, ds_batch_out.statements, statements_ready, false, false);

  // TODO: sort by acctno, penalty?
  
  // OUTPUT(ds_batch_did, NAMED('ds_batch_did'));
	 
  OUTPUT(ds_batch_ready, NAMED('RESULT'));
  OUTPUT(statements_ready, NAMED('CSDResults')); //FFD

ENDMACRO; 
