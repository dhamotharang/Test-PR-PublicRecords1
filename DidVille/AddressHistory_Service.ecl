/*
2005-04-07 Jim Breffni Initial Version
*/
/*--SOAP--
<message name="AddressHistory_Service">
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
  <part name="UseGLBData" type="xsd:boolean"/>	
  <part name="UseDPPAData" type="xsd:boolean"/>		
	<part name="BestAddress" type="xsd:boolean"/>
  <part name="MaxRecordsToReturn" type="xsd:unsignedInt"/>	
  <part name="DataRestrictionMask" type="xsd:string"/>
	<part name="ApplicationType" type="xsd:string"/>
</message>
*/
/*--INFO-- 
This service returns a history of addresses for an individual OR
a single 'Best' address for an individual.

Addresses are sorted by TNT, last seen and then address.

*/

import didville, doxie, AutoStandardI;

//The following code is taken from the didville.Did_Service macro
export AddressHistory_Service := MACRO

string9 ssn_value := ''        : stored('ssn');
string8 dob_value := ''        : stored('DateOfBirth');
string120 addr1_val := ''      : stored('Addr1');
string120 addr2_val := ''      : stored('Addr2');
string30 fname_val := ''       : stored('FirstName');
string30 lname_val := ''       : stored('LastName');
string30 mname_val := ''       : stored('MiddleName');
string5 suffix_val := ''       : stored('NameSuffix');
string2 state_val := ''        : stored('State');
string25 city_val := ''        : stored('City');
string5 zip_value := ''        : stored('Zip');
string10 phone_value := ''     : stored('phone');
string10 prange_value := ''    : stored('primrange');
string10 sec_range_value := '' : stored('secrange');
string30 pname_value := ''     : stored('primname');
string120 name_value := ''     : stored('Name');
boolean GLB_Ok := false           : stored('UseGLBData');
boolean DPPA_Ok := false          : stored('UseDPPAData');
unsigned4 maxrecordstoreturn   := 0 : stored('MaxRecordsToReturn');
boolean bestaddress_input := false   : stored('BestAddress');
mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());


rec := record
  unsigned1 seq;
end;
d := dataset([{1}],rec);

a2_val := if (addr2_val != '',addr2_val,city_val + ' ' + state_val + ' ' + zip_value);

clean_a2    := if(addr1_val<>'' or a2_val<>'', doxie.CleanAddress182(Addr1_Val,A2_Val),'');
clean_n     := datalib.nameclean(name_value);

didville.Layout_Did_OutBatch into(rec l) := transform
self.seq         := l.seq;
self.ssn         := ssn_value;
self.dob         := dob_value;
self.phone10     := phone_value;
self.title       := clean_n[121..130];
self.fname       := if(fname_val='',clean_n[1..40],stringlib.stringtouppercase(fname_val));
self.mname       := if(mname_val='',clean_n[41..80],stringlib.stringtouppercase(mname_val));
self.lname       := if(lname_val='',clean_n[81..120],stringlib.stringtouppercase(lname_val));
self.suffix      := if(suffix_val='',clean_n[131..140],stringlib.stringtouppercase(suffix_val));
self.prim_range  := IF(prange_value='',clean_a2[1..10],prange_value);
self.predir      := clean_a2[11..12];
self.prim_name   := if(pname_value='',clean_a2[13..40],stringlib.stringtouppercase(pname_value));
self.addr_suffix := clean_a2[41..44];
self.postdir     := clean_a2[45..46];
self.unit_desig  := clean_a2[47..56];
self.sec_range   := if(sec_range_value='',clean_a2[57..65],sec_range_value);
self.p_city_name := clean_a2[90..114];
self.st          := clean_a2[115..116];
self.z5          := clean_a2[117..121];
self.zip4        := clean_a2[122..125];
  end;

precs := project(d,into(left));

//Call this common code instead of duplicating code for Service and Batch_Service
Result := didville.AddressHistory_Common(precs, mod_access, glb_Ok, dppa_Ok, maxrecordstoreturn, bestaddress_input); 

output(Result, named('Result'));


ENDMACRO;
// AddressHistory_Service()