/*--SOAP--
<message name="clerk_id">
  <part name="Pid" type="xsd:string"/>
  <part name="UCN" type="xsd:string"/>
  <part name="SSN" type="xsd:string"/>
  <part name="Name" type="xsd:string"/>
  <part name="Addr1" type="xsd:string"/>
  <part name="Addr2" type="xsd:string"/>
  <part name="CityStateZip" type="xsd:string"/>
  <part name="DateOfBirth" type="xsd:string"/>
  <part name="DLNum" type="xsd:string"/>
  <part name="CountyCode" type="xsd:UnsignedInt"/>
  <part name="SourceState" type="xsd:string"/>
  <part name="IncludeExtraWork" type="xsd:boolean"/>
 </message>
*/
export ID_Service := MACRO
#STORED('SourceState','FL');


STRING2 default_state := '' : STORED('SourceState');
string2	p_id := ''		: STORED('Pid');
string20	u_cn := ''		: STORED('UCN');
string120 name_value := ''   : stored('Name');
string9 ssn_value := ''      : stored('SSN');
string10 dob_value := ''      : stored('DateOfBirth');

string120 addr1_val := ''    : stored('Addr1');
string120 addr2_val := ''    : stored('Addr2');
STRING120 city_State_Zip := ''	: STORED('CityStateZip');
STRING25 dl_num := ''		: STORED('DLNum');

unsigned2 county_code := 0	: stored('CountyCode');


rec := record
  unsigned1 seq;
  end;
d := dataset([{1}],rec);

a1_val := TRIM(addr1_val) + ' ' + addr2_val;
a2_val := city_State_Zip;


clean_a2 := if(a1_val<>'' or a2_val<>'',Address.CleanAddress182(a1_val,A2_Val),'');
clean_n := address.CleanPerson73(name_value);


clerksofcourt.Layout_ID_Batch into(rec l) := transform
	self.seq := l.seq;
	self.ucn := u_cn;
	self.pid := p_id;
	self.ssn := ssn_value;
	self.dob := dob_value[7..10] + dob_value[1..2] + dob_value[4..5];
	self.phone10 := '';
	self.name := name_value;
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
	self.county_code := county_code;
	self.county_name := clerksofcourt.Counties_2Name(self.county_code);
	self.dlnum := dl_num;
	SELF := [];
end;

full_layout := project(d,into(left));


res := clerksofcourt.ID_Function(full_layout);

output(res,named('Results'))


ENDMACRO;
