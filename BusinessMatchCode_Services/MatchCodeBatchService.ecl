/*--SOAP--
<message name="BusinessMatchCode_Service">
  <part name="batch_in"                   type="tns:XmlDataSet" cols="70" rows="25"/>	
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/>
  <part name="DataPermissionMask" 			type="xsd:unsigned" default=0/>
  <part name="DataRestrictionMask" 			type="xsd:unsigned" default=0/>
  <part name="Max_Results_Per_Acct" type="xsd:unsignedInt" default=1/>
  <part name="ExcludeExperian" 			type="xsd:boolean" default=false/>
  <part name="InMatchcode_city"          type="xsd:integer" default=0/>
	<part name="InMatchCode_cname"          type="xsd:integer" default=0/>
	<part name="InMatchCode_company_fein"   type="xsd:integer" default=0/>
	<part name="InMatchCode_company_phone"  type="xsd:integer" default=0/>
  <part name="InMatchCode_company_sic_code1" type="xsd:integer" default=0/>
	<part name="InMatchCode_contact_did"    type="xsd:integer" default=0/>
	<part name="InMatchCode_contact_email"  type="xsd:integer" default=0/>
	<part name="InMatchCode_contact_ssn"    type="xsd:integer" default=0/>
	<part name="InMatchCode_fname"          type="xsd:integer" default=0/>
	<part name="InMatchCode_lname"          type="xsd:integer" default=0/>
	<part name="InMatchCode_mname"          type="xsd:integer" default=0/>
	<part name="InMatchCode_prim_name"      type="xsd:integer" default=0/>
	<part name="InMatchCode_prim_range"     type="xsd:integer" default=0/>
	<part name="InMatchCode_score"          type="xsd:integer" default=0/>
	<part name="InMatchCode_sec_range"      type="xsd:integer" default=0/>
	<part name="InMatchCode_st"             type="xsd:integer" default=0/>
	<part name="InMatchCode_zip5"           type="xsd:integer" default=0/>
	// THIS listing of fields inputs is just informational.  Fields being listed
  // in query input are determined programmically by internal compiler.

  // NOTE this is not a batch service in the formal terminology of having kettle
  // stuff in the front of it to do various things such as name/address cleaning.
  // so pls know that only reason for batch notion is to allow multiple inputs
  // by user so as to help with products functionality.
</message>
*/

EXPORT MatchCodeBatchService() :=
MACRO
	
	ds_batchIn := DATASET([],BusinessMatchCode_Services.Layouts.Input) : STORED('Batch_In');
	
  // Standardize input
  BatchShare.MAC_ProcessInput(ds_batchIn,ds_batchInProcessed);
  
  batchParams := BusinessMatchCode_Services.iParam.getBatchParams();
  
	ds_batchResults := BusinessMatchCode_Services.Records(ds_batchInProcessed,batchParams);
  
  BatchShare.MAC_RestoreAcctno(ds_batchInProcessed,ds_batchResults,results);
	
	OUTPUT(results,NAMED('Results'));

ENDMACRO;	
