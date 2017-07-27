/*--SOAP--
<message name="Did_Batch_Service_Raw">
  <part name="did_batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="Appends" type="xsd:string"/>
  <part name="Verify" type="xsd:string"/>
  <part name="Fuzzies" type="xsd:string"/>
  <part name="Deduped" type="xsd:boolean"/>
  <part name="AppendThreshold" type="xsd:string"/>
  <part name="GLBData" type="xsd:boolean"/>
  <part name="GLBPurpose" type="xsd:byte"/>
  <part name="PatriotProcess" type="xsd:boolean"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
	<part name="ApplicationType" type="xsd:string"/>
	<part name="IncludeMinors" type="xsd:boolean"/>
	<part name="xADLVersion" type="xsd:integer"/>	
	<part name="Max_Results_Per_Acct" type="xsd:integer"/>	
  <part name="IncludeRanking" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This service returns dids based upon a set of personal data.*/
export Did_Batch_Service_Raw := macro

import AutoStandardI, ut;
	
#WEBSERVICE(FIELDS('AllowAll',
									 'Appends',
									 'AppendThreshold',
									 'Applicationtype',
									 'DataPermissionMask',
									 'DataRestrictionMask',
									 'Deduped',
									 'did_batch_in',
									 'GLBData',
									 'GLBPurpose',
									 'IncludeMinors',
									 'IndustryClass',
									 'Max_Results_Per_Acct',
									 'PatriotProcess',
									 'SSNMask',
									 'Verify',
									 'IncludeRanking'));
							
	
// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
// Putting the default value into #stored will not overwrite a value that has
// been provided by the user, and the default that is provided below when we read
// from stored (e.g. GLBPurpose) will never actually be used.
#stored('GLBPurpose',0); 				// defined as 8 in AutoStandardI.GlobalModule() which is 
															  // called by used by Header.MAC_GlbClean_Header in 
																// in Address_Rank.  

string120 append_l 								:= '' 		: stored('Appends');
string120 verify_l 								:= '' 		: stored('Verify');
string120 fuzzy_l 								:= '' 		: stored('Fuzzies');
boolean   dedup_results_l 				:= true 	: stored('Deduped');
string3   thresh_val 							:= '' 		: stored('AppendThreshold');
boolean   GLB_data 								:= false	: stored('GLBData');
unsigned1 glb_purpose_value 			:= AutoStandardI.Constants.GLBPurpose_default : stored('GLBPurpose');

boolean   patriotproc 						:= false 	: stored('PatriotProcess');
boolean include_minors 						:= false 	: stored('IncludeMinors');
unsigned1 soap_xadl_version_value := 0 			: stored('xADLVersion');		
unsigned8 MaxResultsPerAcct 			:= 1 			: stored('Max_Results_Per_Acct');	
boolean IncludeRanking						:= false 	: stored('IncludeRanking');

appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));

params_mod := module(AutoStandardI.PermissionI_Tools.params)
	export boolean 	 AllowAll 					 := false;
	export boolean 	 AllowGLB     			 := false;
	export boolean 	 AllowDPPA 					 := false;
	export unsigned1 DPPAPurpose         := 0;
	export unsigned1 GLBPurpose 				 := glb_purpose_value;
	export boolean   IncludeMinors       := include_minors;
END;

GLB := AutoStandardI.PermissionI_Tools.val(params_mod).glb.ok(glb_purpose_value) OR GLB_data;
dedup_results := dedup_results_l;// IN ['on','1'];
appends := stringlib.stringtouppercase(append_l);
verify := stringlib.stringtouppercase(verify_l);
thresh_num := (unsigned2)thresh_val;
fuzzy := stringlib.stringtouppercase(fuzzy_l);

hhidplus := stringlib.stringfind(appends,'HHID_PLUS',1)<>0;
edabest := stringlib.stringfind(appends,'BEST_EDA',1)<>0;

in_format := DidVille.Layout_Did_InBatchRaw;

f := dataset([],in_format) : stored('did_batch_in',few);

DidVille.Layout_Did_OutBatch into(f l) := transform
 self.seq := (unsigned)l.acctno;
 self.phone10 := l.phoneno;
 self.fname := l.name_first;
 self.mname := l.name_middle;
 self.lname := l.name_last;
 self.suffix := l.name_suffix;
 self.addr_suffix := l.suffix;
 self.ssn := stringlib.stringfilter(l.ssn,'0123456789');
 self.did := (unsigned)l.did;
 self := l;
 end;

recs := project(f,into(left));

// Bug: 53541=> for this service, we are using the nonblank key to ensure the largest 
// majority of first and last names are populated during record retreival

UseNonBlankKey := TRUE;
inLimit :=if(MaxResultsPerAcct > 5,5,MaxResultsPerAcct);

IndustryClass := ut.IndustryClass.Get();
ds_res_best := didville.did_service_common_function(recs, appends, verify, fuzzy, dedup_results,  
																										thresh_num, GLB, patriotproc, false, false, 
																										hhidplus, edabest, params_mod.GLBPurpose, 
																										include_minors,,UseNonBlankKey,appType,
																										soap_xadl_version_value,inLimit,
																										IndustryClass_val := IndustryClass); 
				

ds_res_ranked := Didville.fn_GetRankedAddress(UNGROUP(ds_res_best), params_mod);

res := IF(IncludeRanking, GROUP(SORT(ds_res_ranked, seq, -score), seq), SORT(ds_res_best, seq, -score));

// output in "raw" compatible - which means all strings
didville.Layout_Did_OutBatch_Raw makeStrings(didville.Layout_Did_OutBatch le) :=
TRANSFORM
	SELF.did := INTFORMAT(le.did,12,1);
	SELF.score := INTFORMAT(le.score,3,1);
	SELF.hhid := INTFORMAT(le.hhid,12,1);

	SELF.best_addr_date := (STRING)le.best_addr_date;
	SELF.verify_best_phone := INTFORMAT(le.verify_best_phone,3,1);
	SELF.verify_best_ssn := INTFORMAT(le.verify_best_ssn,3,1);
	SELF.verify_best_address := INTFORMAT(le.verify_best_address,3,1);
	SELF.verify_best_name := INTFORMAT(le.verify_best_name,3,1);
	SELF.verify_best_dob := INTFORMAT(le.verify_best_dob,3,1);
	SELF.score_any_ssn := INTFORMAT(le.score_any_ssn,3,1);
	SELF.score_any_addr := INTFORMAT(le.score_any_addr,3,1);
	SELF.any_addr_date := (STRING)le.any_addr_date;
	SELF.score_any_dob := INTFORMAT(le.score_any_dob,3,1);
	SELF.score_any_phn := INTFORMAT(le.score_any_phn,3,1);
	SELF.score_any_fzzy := INTFORMAT(le.score_any_fzzy,3,1);

	SELF.known := IF(le.known,'Y','N');
	SELF.name_match := IF(le.name_match,'Y','N');
	SELF.number_with_same_name := IF(le.name_match, INTFORMAT(le.number_with_same_name,10,1), '');
	SELF.first_seen := IF(le.name_match, (STRING)le.first_seen, '');
	SELF.relative_count := IF(le.name_match, INTFORMAT(le.relative_count,5,1), '');
	self.acctno := intformat(le.seq,10,1) ;
	self.phoneno := le.phone10 ;
	self.name_first := le.fname ;
	self.name_middle := le.mname ;
	self.name_last := le.lname ;
	self.name_suffix := le.suffix ;
	self.suffix := le.addr_suffix ;
	SELF := le;
END;
intoStrings := PROJECT(res, makeStrings(LEFT));
output(intoStrings,named('Result'));

endmacro;
// Did_Batch_Service_Raw()