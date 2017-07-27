/*--SOAP--
<message name="clerk_id">
  <part name="id_batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="SourceState" type="xsd:string"/>
  <part name="IncludeExtraWork" type="xsd:boolean"/>
 </message>
*/
export ID_Batch_Service := MACRO
#STORED('SourceState','FL');

in_format := ClerksofCourt.Layout_In_Batch;

STRING2 default_state := '' : STORED('SourceState');
f := dataset([],in_format) : stored('id_batch_in',few);


clerksofCourt.Layout_ID_Batch proj(in_format le) :=
TRANSFORM
	a1_val := TRIM(le.addr1) + ' ' + le.addr2;
	a2_val := le.cityStateZip;
	clean_a2 := if(a1_val<>'' or a2_val<>'',Address.CleanAddress182(a1_val,A2_Val),'');
	clean_n := address.CleanPerson73(le.name);


	self.name := le.name;
	self.title := clean_n[1..5];
	self.fname := clean_n[6..25];
	self.mname := clean_n[26..45];
	self.lname := clean_n[46..65];
	self.suffix := clean_n[66..70];
	
	self.prim_range := clean_a2[1..10];
	self.predir := clean_a2[11..12];
	self.prim_name := clean_a2[13..40];
	self.addr_suffix := clean_a2[41..44];
	self.postdir := clean_a2[45..46];
	self.unit_desig := clean_a2[47..56];
	self.sec_range := clean_a2[57..65];
	self.p_city_name := clean_a2[90..114];
	self.st := IF(clean_a2[115..116]<>'',clean_a2[115..116],default_state);
	self.z5 := clean_a2[117..121];
	self.zip4 := clean_a2[122..125];
	
	self.county_code := (INTEGER)le.countycode;
	self.county_name := clerksofcourt.Counties_2Name(self.county_code);
	
	self.dob := le.dob[7..10] + le.dob[1..2] + le.dob[4..5];
	self.dlnum := le.dlnum;
	
	SELF.seq := le.seq;
	SELF := le;
	SELF := [];
END;
p := PROJECT(f,proj(LEFT));

res := clerksofcourt.ID_Function(p);

output(res,named('Results'))


ENDMACRO;
