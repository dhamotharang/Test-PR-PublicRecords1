/*--SOAP--
<message name="Batch_ServiceFCRA">
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="DPPAPurpose" type="xsd:byte" default="1"/>
  <part name="GLBPurpose" type="xsd:byte" default="1"/>
  <part name="DataRestrictionMask" type="xsd:string" default="000000000000000000000000" size="24"/>
  <part name="DataPermissionMask" type="xsd:string" default="111111111111111111111111" size="24"/>
  <part name="ApplicationType" type="xsd:string"/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
	<part name="FFDOptionsMask" 	      type="xsd:string"/>
	<part name="FCRAPurpose" 	      type="xsd:string"/>
  <part name="NonSubjectSuppression" type="xsd:unsignedInt" default="2"/> <!-- [1,2,3] -->
  <part name="Gateways" type="tns:XmlDataSet" cols="70" rows="8"/>
</message>
*/
/*--INFO-- This service returns marriage and divorce batch records with FCRA restrictions.<p/>
           When using NonSubjectSuppression:<br/>
           -1: no co-owners suppression<br/>
           -2: co-owners are blanked and lname is overriden with value "FCRA Restricted"<br/>
           -3: co-owners are suppressed<p/>
           The default behavior for NonSubjectSuppression is 2.*/


IMPORT BatchShare, marriage_divorce_v2_Services, Suppress, Gateway, ut,FFD,STD, FCRA;

EXPORT Batch_ServiceFCRA () := MACRO
  boolean IsFCRA := true;
  
  // input batch records
  rec_in := marriage_divorce_v2_Services.layouts.batch_in;
  ds_xml_in := DATASET([], rec_in) : STORED('batch_in', FEW);
  
  //non-subject suppression
  nss := ut.getNonSubjectSuppression (Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription);
	  
  // common batch settings, including a gateway to a remote Picklist
  batch_params := module (project (BatchShare.IParam.getBatchParamsV2(), marriage_divorce_v2_Services.input.batch_params, opt))
    export dataset (Gateway.layouts.config) gateways := Gateway.Configuration.Get();
    export integer1 non_subject_suppression := nss;
		export integer8 FFDOptionsMask := FFD.FFDMask.Get();
		export integer  FCRAPurpose := FCRA.FCRAPurpose.Get();
  end;
  
  // run input through some standard procedures
  BatchShare.MAC_SequenceInput (ds_xml_in, ds_sequenced);

  // append DID (a soap call to Picklist service
  BatchShare.MAC_AppendPicklistDID (ds_sequenced, ds_batch_did, batch_params, IsFCRA);    
  
  md_recs := marriage_divorce_v2_Services.batch_records (batch_params, ds_batch_did, IsFCRA);
	ds_batch_out := md_recs.Records;
	statements := md_recs.Statements;
	
  // Restore original acctno and format to output layout.        
  BatchShare.MAC_RestoreAcctno (ds_batch_did, ds_batch_out, results);
  BatchShare.MAC_RestoreAcctno (ds_batch_did, statements, statements_ready, false, false);
    
	OUTPUT(results, NAMED('RESULTS'));
	OUTPUT(statements_ready, NAMED('CSDResults'));
  
ENDMACRO;
