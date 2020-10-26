/*--SOAP--
<message name="Did_Service">
  <part name="SSN" type="xsd:string"/>
  <part name="Name" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="LastName" type="xsd:string"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="NameSuffix" type="xsd:string"/>
  <part name="Addr1" type="xsd:string"/>
  <part name="Addr2" type="xsd:string"/>
  <part name="PrimRange" type="xsd:string"/>
  <part name="PrimName" type="xsd:string"/>
  <part name="SecRange" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="Phone" type="xsd:string"/>
  <part name="DateOfBirth" type="xsd:string"/>
  <part name="ADL" type="xsd:string"/>
  <part name="Email" type="xsd:string"/>
  <part name="Appends" type="xsd:string"/>
  <part name="Verify" type="xsd:string"/>
  <part name="Fuzzies" type="xsd:string"/>
  <part name="Lookups" type="xsd:boolean"/>
  <part name="LivingSits" type="xsd:boolean"/>
  <part name="AppendThreshold" type="xsd:string"/>
  <part name="GLBData" type="xsd:boolean"/>
  <part name="AllPossibles" type="xsd:boolean"/>
  <part name="PatriotProcess" type="xsd:boolean"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="GLBPurpose" type="xsd:byte"/>
  <part name="IncludeMinors" type="xsd:boolean"/>
  <part name="ApplicationType" type="xsd:string"/>

  <part name="maxScoreFromSSN" type="xsd:integer"/>
  <part name="maxScoreFromAddress" type="xsd:integer"/>
  <part name="maxScoreFromDOB" type="xsd:integer"/>
  <part name="maxScoreFromPhone" type="xsd:integer"/>
  <part name="NameIsOrdered" type="xsd:boolean"/>
  <part name="xADLVersion" type="xsd:integer"/>
  <part name="LimitedOutput" type="xsd:boolean"/>
 </message>
*/
/*--INFO-- This service returns a did.*/

import address, AutoStandardI, doxie, dx_common, patriot, STD, ut, Suppress;

export Did_Service := MACRO

string9 ssn_value := '' : stored('ssn');
string14 did_value := '' : stored('ADL');
string8 dob_value := '' : stored('DateOfBirth');
string120 addr1_val := '' : stored('Addr1');
string120 addr2_val := '' : stored('Addr2');
string30 fname_val := '' : stored('FirstName');
string30 lname_val := '' : stored('LastName');
string30 mname_val := '' : stored('MiddleName');
string5 suffix_val := '' : stored('NameSuffix');
string2 state_val := '' : stored('State');
string25 city_val := '' : stored('City');
string5 zip_value := '' : stored('Zip');
string10 phone_value := '' : stored('phone');
string10 prange_value := '' : stored('primrange');
string10 sec_range_value := '' : stored('secrange');
string30 pname_value := '' : stored('primname');
string120 name_value := '' : stored('Name');
string120 append_l := '' : stored('Appends');
string120 verify_l := '' : stored('Verify');
string120 fuzzy_l := '' : stored('Fuzzies');
boolean lookups := false : stored('Lookups');
boolean livingsits := false : stored('LivingSits');
boolean glb_ok := false  : stored('GLBData');
boolean AllPos_l := false  : stored('AllPossibles');
string3 thresh_val := '' : stored('AppendThreshold');
boolean patriotproc := false : stored('PatriotProcess');
boolean name_is_ordered_value := false : stored('NameIsOrdered');
string120 email_val := '' : stored('Email');

unsigned2 maxScoreFromSSN := DidVille.MaxScores.MMax.maxScoreFromSSN : stored('maxScoreFromSSN');
unsigned2 maxScoreFromAddress := DidVille.MaxScores.MMax.maxScoreFromAddress : stored('maxScoreFromAddress');
unsigned2 maxScoreFromDOB := DidVille.MaxScores.MMax.maxScoreFromDOB : stored('maxScoreFromDOB');
unsigned2 maxScoreFromPhone := DidVille.MaxScores.MMax.maxScoreFromPhone : stored('maxScoreFromPhone');
unsigned1 soap_xadl_version_value := 0 : stored('xADLVersion');
boolean Limited_Output := false : stored('LimitedOutput');

mod_access_pre := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
mod_access := MODULE(mod_access_pre)
                EXPORT unsigned1 unrestricted := mod_access_pre.unrestricted | IF (glb_ok, doxie.compliance.ALLOW.GLB, 0);
              END;


checkInputMax(unsigned2 inp) := if (inp > 100, 100, inp);

/* The below steps (till the FAIL) are done to mandate the minimum input criteria.
   The minimum criteria is only applicable to the customer facing, LimitedOutput = true
   version of the query. The regular version does not have any mandated minimum input
   criteria. The detailed requirements are available in Bug: 142298
*/

boolean isValidFirstName := length(TRIM(fname_val,LEFT,RIGHT))> 1 ;
boolean isValidLastName := length(TRIM(lname_val,LEFT,RIGHT)) > 1 ;
name_value_clean := STD.Str.CleanSpaces(name_value);
pos1 := STD.STR.Find(name_value_clean,' ',1);
name_f :=  name_value_clean[1..pos1-1] ;
pos2 := STD.STR.Find(name_value_clean,' ',2);
name_l := if(pos2 > 0 , name_value_clean[pos2+1..], name_value_clean[pos1+1 ..]);
boolean isValidName := (length(TRIM(name_f,LEFT,RIGHT)) > 1 and length(TRIM(name_l,LEFT,RIGHT)) > 1)
  OR (isValidFirstName AND isValidLastName);

boolean isInputSufficient_limited_output :=
    did_value <> '' OR
   (SSN_value <> '' and isValidName ) OR
   (
      isValidName AND ((City_val <> '' AND State_val <> '') OR ( addr2_val <> '')) AND
      ( Addr1_val <> '' or (prange_value <> '' and pname_value <> '') )
   );

boolean isInputSufficient := if(limited_output,isInputSufficient_limited_output,true);
if(isInputSufficient = false,FAIL(301,doxie.ErrorCodes(301)));

mod_MaxScores :=
MODULE(DidVille.MaxScores.IMax)
    export unsigned2 maxScoreFromSSN := checkInputMax(^.maxScoreFromSSN);
    export unsigned2 maxScoreFromAddress := checkInputMax(^.maxScoreFromAddress);
    export unsigned2 maxScoreFromDOB := checkInputMax(^.maxScoreFromDOB);
    export unsigned2 maxScoreFromPhone := checkInputMax(^.maxScoreFromPhone);
END;

a2_val := if (addr2_val != '', addr2_val,city_val + ' ' + state_val + ' ' + zip_value);

dedup_these := ~AllPos_l;// IN ['1','on'];
clean_a2 := if(addr1_val<>'' or a2_val<>'', doxie.CleanAddress182(Addr1_Val,A2_Val),'');
clean_n := if(name_is_ordered_value, address.CleanPersonFML73(name_value_clean),
              address.CleanPerson73(name_value_clean));

clean_n_parsed := Address.CleanNameFields(clean_n);

appends := STD.STR.ToUpperCase(append_l);
verify := STD.STR.ToUpperCase(verify_l);
fuzzy := STD.STR.ToUpperCase(fuzzy_l);
thresh_num := (unsigned2)thresh_val;
DidOnlySearch := ssn_value = '' and dob_value = ''
and addr1_val = '' and addr2_val = '' and fname_val = '' and lname_val = '' and mname_val = ''
and suffix_val = '' and state_val = '' and city_val = '' and zip_value = '' and phone_value = '' and prange_value = ''
and sec_range_value = '' and pname_value = '' and name_value_clean = '';

didville.Layout_Did_OutBatch into() := transform
  self.did := if(DidOnlySearch,(unsigned6) did_value, 0);
  self.seq := 1;
  self.ssn := STD.STR.Filter(ssn_value,'0123456789');
  self.dob := dob_value;
  self.phone10 := phone_value;
  self.title := clean_n_parsed.title;
  self.fname := STD.STR.FilterOut(if(fname_val='',clean_n_parsed.fname,STD.STR.ToUpperCase(fname_val)),'\'');
  self.mname := STD.STR.FilterOut(if(mname_val='',clean_n_parsed.mname,STD.STR.ToUpperCase(mname_val)),'\'');
  self.lname := STD.STR.FilterOut(if(lname_val='',clean_n_parsed.lname,STD.STR.ToUpperCase(lname_val)),'\'');
  self.suffix := if(suffix_val='',clean_n_parsed.name_suffix,STD.STR.ToUpperCase(suffix_val));
  self.prim_range := IF(prange_value='',clean_a2[1..10],prange_value);
  self.predir := clean_a2[11..12];
  self.prim_name := if(pname_value='',clean_a2[13..40],STD.STR.ToUpperCase(pname_value));
  self.addr_suffix := clean_a2[41..44];
  self.postdir := clean_a2[45..46];
  self.unit_desig := clean_a2[47..56];
  self.sec_range := if(sec_range_value='',clean_a2[57..65],sec_range_value);
  self.p_city_name := clean_a2[90..114];
  self.st := clean_a2[115..116];
  self.z5 := clean_a2[117..121];
  self.zip4 := clean_a2[122..125];
  self.email := STD.STR.ToUpperCase(email_val);
end;

precs := DATASET([into()]);

// Bug: 53541=> for this service, we are using the nonblank key to ensure the largest
// majority of first and last names are populated during record retreival
UseNonBlankKey := TRUE;

res_ready := didville.did_service_common_function(precs, appends, verify, fuzzy,
                                                  dedup_these, thresh_num, mod_access.isValidGlb(), false,
                                                  lookups, livingsits, false, false,
                                                  mod_access.glb, mod_access.show_minors,
                                                  mod_MaxScores, UseNonBlankKey, mod_access.application_type,
                                                  soap_xadl_version_value,
                                                  IndustryClass_val := mod_access.industry_class);

patriot.MAC_AppendPatriot(res_ready, mod_access, did,fname,mname,lname,res_w_pat,ptys,false)
res := if(patriotproc, res_w_pat, res_ready);

pj1 := JOIN(res(name_match AND known), patriot.key_did_patriot_file,
  keyed(LEFT.did=RIGHT.did),
  TRANSFORM(patriot.Layout_Patriot, SELF := RIGHT));
pj2 := JOIN(ptys, patriot.key_patriot_file,
  keyed(LEFT.pty_key=RIGHT.pty_key) AND
  ut.namematch(left.fname,left.mname,left.lname,right.fname,right.mname,right.lname)<3,
  TRANSFORM(patriot.Layout_Patriot, SELF := RIGHT));

patrecs_suppressed := Suppress.MAC_SuppressSource(pj1+pj2, mod_access);
patrecs := IF(patriotproc, patrecs_suppressed);
patrecs_slim := project(patrecs, {patriot.Layout_Patriot - dx_common.layout_metadata});
output(patrecs_slim);

//bug 69994: enable did only search.

best_appended := res[1].best_ssn <> '' OR res[1].best_addr1 <> ''
OR res[1].best_city <> '' OR res[1].best_state <> '' OR res[1].best_zip <> '' OR res[1].best_title <> ''
OR res[1].best_fname <> '' OR res[1].best_mname <> '' OR res[1].best_lname <> '' OR res[1].best_city <> ''
OR res[1].best_state <> '' OR res[1].best_zip <> '' OR res[1].best_addr_date <> 0 OR res[1].best_dod <> ''
OR res[1].best_phone <> '';
//IF Limited_Output apply SSN LAST4 mask
ssn_mask_value := if (Limited_Output,'FIRST5','');
Suppress.MAC_Mask(res,res_masked,best_ssn,blank,true,false);

// Transform for regular requests
res set_score(res L) := transform
  self.score := if((unsigned6) did_value = L.did and best_appended and DidOnlySearch, 100, L.score);
  self := L;
end;

// Transform for Limited_Output regular requests
/* Sometimes, due to restrictions on data , just the DID and no other  (BEST) information  gets returned.
   We would like to suppress all the only-DID-in-result records for LIMITED_OUTPUT version of this service ).
    It has been agreed upon by the all parties (ESP, configuration)involved that for "Limited Output" version
    the "appends" field may one or any combination of the below values:
    best_ssn, best_name,  best_addr, best_address_date, best_dob
*/

res set_limited_Output (res L) := transform , skip (l.best_ssn = '' AND l.best_addr1 = '' AND l.best_city = '' AND
                            l.best_state = '' AND l.best_zip = ''   AND l.best_title = '' AND
                            l.best_fname = '' AND l.best_mname = '' AND l.best_lname = '' AND
                            l.best_city = ''  AND l.best_state = '' AND l.best_zip = ''   AND
                            l.best_addr_date = 0 )

  self.score := if((unsigned6) did_value = L.did and best_appended and DidOnlySearch, 100, L.score);
  //strip street from full address for returning in limited_output responses
  addr2 := address.addr2FromComponents(l.best_city,l.best_state,l.best_zip);
  fulladdr := Address.CleanAddressParsed(l.best_addr1,addr2);
  prim_name_only := fulladdr.prim_name;
  self.best_addr1 :=  prim_name_only;
  self.best_dob :=   l.best_dob[1..4];  //YYYY mask
  self :=  L;
end;

res_final_1 := project(res_masked, set_limited_Output(left));
res_final_2 := project(res_masked, set_score(left));

res_final := if(Limited_Output, res_final_1, res_final_2 );

output(res_final);

ENDMACRO;
// DidVille.Did_Service;
