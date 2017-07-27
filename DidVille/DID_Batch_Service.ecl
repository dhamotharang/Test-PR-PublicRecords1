/*--SOAP--
<message name="Did_Batch_Service">
  <part name="did_batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
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
  <part name="usePreLab" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This service returns dids based upon a set of personal data.*/

import AutoStandardI, ut;

export DID_Batch_Service := macro
string120 append_l := '' 		: stored('Appends');
string120 verify_l := '' 		: stored('Verify');
string120 fuzzy_l := '' 			: stored('Fuzzies');
boolean   lookups := false 		: stored('Lookups');
boolean   livingSits := false 	: stored('LivingSits');
boolean   dedup_results_l := true 	: stored('Deduped');
string3   thresh_val := '' 		: stored('AppendThreshold');
boolean   GLB := false 			: stored('GLBData');
boolean   patriotproc := false 	: stored('PatriotProcess');
unsigned1 glb_purpose_value := 0 : stored('GLBPurpose');
boolean include_minors := false : stored('IncludeMinors');
unsigned1 soap_xadl_version_value := 0 : stored('xADLVersion');			
boolean usePreLab := false : stored('usePreLab');
appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));

// Bug: 53541=> for this service, we are using the nonblank key to ensure the largest 
// majority of first and last names are populated during record retreival
UseNonBlankKey := TRUE;

dedup_results := dedup_results_l;// IN ['on','1'];
appends := stringlib.stringtouppercase(append_l);
verify := stringlib.stringtouppercase(verify_l);
thresh_num := (unsigned2)thresh_val;
fuzzy := stringlib.stringtouppercase(fuzzy_l);

in_format := DidVille.Layout_Did_InBatch;

f := dataset([],in_format) : stored('did_batch_in',few);

o_format := DidVille.Layout_Did_OutBatch;

DidVille.Layout_Did_OutBatch into(f i) := transform
  self.ssn := stringlib.stringfilter(i.ssn,'0123456789');
  self := i;
  end;

recs := project(f,into(left));

IndustryClass := ut.IndustryClass.Get();
res1 := didville.did_service_common_function(recs, appends, verify, fuzzy, dedup_results, 
                                            thresh_num, GLB, patriotproc, lookups, 
																						livingSits, false, false, glb_purpose_value, 
																						include_minors,,UseNonBlankKey, appType, soap_xadl_version_value,
																						IndustryClass_val := IndustryClass);


Mapkey := DidVille.key_lab_did_mapping;

string isLabData1 := stringlib.StringToUpperCase(thorlib.getenv('isLabData',''));

dummyDIDs := [1791860725];

Res := If(usePreLab ,
					Join(res1 , Mapkey, 
					(isLabData1='TRUE' or Left.did in dummyDIDs) 
					and Keyed(Left.did = right.postLAB_LexID)  ,
							Transform({res1},
								Self.DID := if(right.preLAB_ADL > 0, 
																right.preLAB_ADL, left.DID),
								Self := left	),
						left outer, keep(1)),
					res1);

// output(usePreLab, named('usePreLab'));
// output(isLabData1, named('isLabData1'));
// output(res, named('res'));
output(res,named('Result'));

endmacro;
