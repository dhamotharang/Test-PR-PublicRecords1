
/*
2005-04-20 Jim Breffni Initial Version
*/
/*--SOAP--
<message name="AddressHistory_Batch_Service">
  <part name="AddressHistory_Batch_In" type="tns:XmlDataset" cols="70" rows="25"/>
  <part name="UseGLBData" type="xsd:boolean"/>	
  <part name="UseDPPAData" type="xsd:boolean"/>		
	<part name="BestAddress" type="xsd:boolean"/>
  <part name="MaxRecordsToReturn" type="xsd:unsignedInt"/>	
  <part name="DataRestrictionMask" type="xsd:string"/>
	<part name="ApplicationType" type="xsd:string"/>
</message>
*/
/*--INFO-- 
For a supplied XML dataset, this service returns a history of addresses for each individual OR
a single 'Best' address for each individual.

*/

import DidVille, doxie, AutoStandardI;

export AddressHistory_Batch_Service := MACRO
boolean GLB_Ok                 := false  : stored('UseGLBData');
boolean DPPA_Ok                := false  : stored('UseDPPAData');
unsigned4 maxrecordstoreturn   := 0      : stored('MaxRecordsToReturn');
boolean bestaddress_input      := false  : stored('BestAddress');
BatchIn := dataset([], DidVille.AddressHistory_Layout_InBatch) : stored('addresshistory_batch_in', few);
mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());

layout_CleanNameAddress := record
  didville.Layout_Did_OutBatch;
  string200 clean_n;  // Temporary field needed to construct name parts, will be thrown away
	string200 a2_val;   // Temporary field needed to construct address parts, will be thrown away
	string200 clean_a2; // Ditto
end;

layout_CleanNameAddress into(didville.AddressHistory_Layout_InBatch l) := transform
self.seq         := l.seq;
self.ssn         := l.ssn;
self.dob         := l.dob;
self.phone10     := l.phone10;

self.clean_n     := datalib.nameclean(l.name);
self.title       := self.clean_n[121..130];  //clean_n[121..130];
self.fname       := if(l.fname='' ,self.clean_n[001..040],stringlib.stringtouppercase(l.fname));
self.mname       := if(l.mname='' ,self.clean_n[041..080],stringlib.stringtouppercase(l.mname));
self.lname       := if(l.lname='' ,self.clean_n[081..120],stringlib.stringtouppercase(l.lname));
self.suffix      := if(l.suffix='',self.clean_n[131..140],stringlib.stringtouppercase(l.suffix));

string a2 := if(l.addr2 != '', l.addr2, l.city + ' ' + l.st + ' ' + l.z5);
self.a2_val      := a2;
self.clean_a2    := if(l.Addr1<>'' or a2<>'', doxie.CleanAddress182(l.Addr1, a2),'');
self.prim_range  := if(l.prim_range='',self.clean_a2[1..10],l.prim_range);
self.predir      := self.clean_a2[11..12];
self.prim_name   := if(l.prim_name='',self.clean_a2[13..40],stringlib.stringtouppercase(l.prim_name));
self.addr_suffix := self.clean_a2[41..44];
self.postdir     := self.clean_a2[45..46];
self.unit_desig  := self.clean_a2[47..56];
self.sec_range   := if(l.sec_range='',self.clean_a2[57..65],l.sec_range);
self.p_city_name := self.clean_a2[90..114];
self.st          := self.clean_a2[115..116];
self.z5          := self.clean_a2[117..121];
self.zip4        := self.clean_a2[122..125];
self             := l;
end;
	
CleanedNameAddress := project(BatchIn,into(left));


didville.Layout_Did_OutBatch RemoveTempFields(layout_CleanNameAddress l) := transform
  self := l;
end;

RemovedTempFields := project(CleanedNameAddress, RemoveTempFields(left));  

//Call this common code instead of duplicating code for Service and Batch_Service
Result := didville.AddressHistory_Common(RemovedTempFields, mod_access, GLB_Ok, DPPA_Ok, maxrecordstoreturn, bestaddress_input); 

output(Result, named('Result'));


ENDMACRO;
// AddressHistory_Batch_Service()