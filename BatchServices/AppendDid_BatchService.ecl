/*--SOAP--
<message name="BatchServices.AppendDid_BatchService">
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="Appends" type="xsd:string"/>
  <part name="Verify" type="xsd:string"/>
  <part name="Fuzzies" type="xsd:string"/>
  <part name="Lookups" type="xsd:boolean"/>
  <part name="LivingSits" type="xsd:boolean"/>
  <part name="Deduped" type="xsd:boolean"/>
  <part name="AppendThreshold" type="xsd:string"/>
  <part name="GLBData" type="xsd:boolean"/>
  <part name="PatriotProcess" type="xsd:boolean"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="IncludeMinors" type="xsd:boolean"/>
	<part name="ApplicationType" type="xsd:string"/>
	<part name="xADLVersion" type="xsd:integer"/>	

</message>
*/
/*--INFO-- This service returns dids based upon a set of personal data.*/

import DidVille, doxie,did_add,AutoStandardI, risk_indicators, didville, batchShare;

export AppendDid_BatchService := macro
string120 append_l := '' 		  : stored('Appends');
string120 verify_l := '' 		  : stored('Verify');
string120 fuzzy_l := '' 			: stored('Fuzzies');
boolean   lookups := false 		: stored('Lookups');
boolean   livingSits := false     : stored('LivingSits');
boolean   dedup_results := true 	: stored('Deduped');
string3   thresh_val := '' 		    : stored('AppendThreshold');
boolean   GLB := false 			      : stored('GLBData');
boolean   patriotproc := false   	: stored('PatriotProcess');
unsigned1 glb_purpose_value  := 0 : stored('GLBPurpose');
boolean   include_minors := false   : stored('IncludeMinors');
unsigned1 soap_xadl_version_value := 0 : stored('xADLVersion');			

string32 appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
string6 ssn_mask_value := AutoStandardI.InterfaceTranslator.ssn_mask_val.val(project(autostandardi.globalModule(), AutoStandardI.InterfaceTranslator.ssn_mask_val.params));      								

// Bug: 53541=> for this service, we are using the nonblank key to ensure the largest 
// majority of first and last names are populated during record retreival
UseNonBlankKey := TRUE;

appends := stringlib.stringtouppercase(append_l);
verify := stringlib.stringtouppercase(verify_l);
thresh_num := (unsigned2)thresh_val;
fuzzy := stringlib.stringtouppercase(fuzzy_l);

ds_batchIn := dataset([],BatchServices.AppendDid_BatchService_Layouts.layout_did_InbatchWithAcctno) : stored('batch_in');

 BatchShare.MAC_ProcessInput(ds_batchIn,ds_batchInProcessed);

ds_batchResults := BatchServices.AppendDID_BatchService_Records.search(ds_batchInProcessed, 
  appends,
  verify,
  fuzzy,
  dedup_results,
	thresh_num,
	GLB,
	patriotproc,
	lookups,
	livingSits,
	glb_purpose_value,
	Include_minors,
	useNonBlankKey,
	Apptype,
	soap_xadl_version_value,
	ssn_mask_value
 );
   											
BatchShare.MAC_RestoreAcctno(ds_batchInProcessed,ds_batchResults,results);												
					
//output(ds_batchIn, named('ds_batchIn'));
//output(Ds_batchInProcessed, named('Ds_batchInProcessed'));

//output(ds_batchResults, named('ds_batchResults'));

// output(isLabData1, named('isLabData1'));
// output(res, named('res'));
//output(res,named('Result'));
output(results, named('Results'));

endmacro;
