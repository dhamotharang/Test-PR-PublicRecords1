import business_header,address;

rec := Business_Header.Layout_Business_Contact_Full;
inf := govdata.MEWA_Norm;

isperson(string81 n) := 
	Address.Business.GetNameType(n) in ['P','D'] and
  Datalib.CompanyClean(n)[41..120] = '' and
	n <> '(SEE ATTACHED)';


rec tra(inf l) := transform
	SELF.bdid := 0;
	SELF.did := 0;
	SELF.vendor_id := trim(l.year) + trim(l.st) + l.name[1..15] + trim(l.prim_range);
  SELF.dt_first_seen := (unsigned4)(l.year + '0101');
  SELF.dt_last_seen := (unsigned4)(l.year + '0101');
	SELF.source := 'ME';
	SELF.record_type := 'C';  
	//Person Data
	SELF.company_title := '';
	SELF.title :=  address.cleanperson73(l.Name_Care_Of)[1..5];
	SELF.fname := address.cleanperson73(l.Name_Care_Of)[6..25];
	SELF.mname := address.cleanperson73(l.Name_Care_Of)[26..45];
	SELF.lname := address.cleanperson73(l.Name_Care_Of)[46..65];
	SELF.name_suffix := address.cleanperson73(l.Name_Care_Of)[66..70];
	SELF.name_score := address.cleanperson73(l.Name_Care_Of)[71..73];
	SELF.prim_range := L.prim_range;
	SELF.predir := L.predir;
	SELF.prim_name := L.prim_name;
	SELF.addr_suffix := L.addr_suffix;
	SELF.postdir := L.postdir;
	SELF.unit_desig := L.unit_desig;
	SELF.sec_range := L.sec_range;
	SELF.city := L.p_city_name;
	SELF.state := L.st;
	SELF.zip := (INTEGER)L.zip5;
	SELF.zip4 := (INTEGER)L.zip4;
	SELF.county := L.county;
	SELF.msa := L.msa;
	SELF.geo_lat := L.geo_lat;
	SELF.geo_long := L.geo_long;
	SELF.phone := (integer)l.phone10;
	SELF.email_address := '';
	SELF.ssn := 0;
	// Company Data
	
  self.company_source_group := '';//L.dea_registration_number; // Source group
  self.company_name := l.name;
  self.company_prim_range := l.prim_range;
  self.company_predir := l.predir;
  self.company_prim_name := l.prim_name;
  self.company_addr_suffix := l.addr_suffix;
  self.company_postdir := l.postdir;
  self.company_unit_desig := l.unit_desig;
  self.company_sec_range := l.sec_range;
  self.company_city := l.p_city_name;
  self.company_state := l.st;
  self.company_zip := (unsigned3)l.zip5;
  self.company_zip4 := (unsigned2)l.zip4;
  self.company_phone := (integer)l.phone10;
	self.company_fein := (integer)l.fein;

end;

outf := project(inf(name <> '', isperson(name_Care_of)), tra(left));

export MEWA_As_Business_Contact := dedup(outf, all)
	: persist(persistnames().AsBusinessContact.MEWA);