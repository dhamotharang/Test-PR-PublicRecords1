import business_header,dea;

rec := Business_Header.Layout_Business_Contact_Full;
inf := dea.File_DEA; //govdata.File_DEA_In;

rec tra(inf l) := transform
	SELF.bdid := (integer)L.bdid;
	SELF.did := (integer)L.did;
	SELF.vendor_id := L.dea_registration_number;
  SELF.dt_first_seen := (unsigned4)l.date_first_reported;
  SELF.dt_last_seen := (unsigned4)l.date_last_reported;
	SELF.source := 'DE';
	SELF.record_type := 'C';  
	//Person Data
	SELF.company_title := '';
	SELF.title := L.title;
	SELF.fname := L.fname;
	SELF.mname := L.mname;
	SELF.lname := L.lname;
	SELF.name_suffix := L.name_suffix;
	SELF.name_score := L.name_score;
	SELF.prim_range := L.prim_range;
	SELF.predir := L.predir;
	SELF.prim_name := L.prim_name;
	SELF.addr_suffix := L.addr_suffix;
	SELF.postdir := L.postdir;
	SELF.unit_desig := L.unit_desig;
	SELF.sec_range := L.sec_range;
	SELF.city := L.p_city_name;
	SELF.state := L.st;
	SELF.zip := (INTEGER)L.zip;
	SELF.zip4 := (INTEGER)L.zip4;
	SELF.county := L.county;
	SELF.msa := L.msa;
	SELF.geo_lat := L.geo_lat;
	SELF.geo_long := L.geo_long;
	SELF.phone := 0;
	SELF.email_address := '';
	SELF.ssn := 0;
	// Company Data
	
  self.company_source_group := L.dea_registration_number; // Source group
  self.company_name := l.cname;
  self.company_prim_range := l.prim_range;
  self.company_predir := l.predir;
  self.company_prim_name := l.prim_name;
  self.company_addr_suffix := l.addr_suffix;
  self.company_postdir := l.postdir;
  self.company_unit_desig := l.unit_desig;
  self.company_sec_range := l.sec_range;
  self.company_city := l.p_city_name;
  self.company_state := l.st;
  self.company_zip := (unsigned3)l.zip;
  self.company_zip4 := (unsigned2)l.zip4;
  self.company_phone := 0;

end;

outf := project(inf(cname <> '', fname <> '', lname <>  ''), tra(left));

export DEA_As_Business_Contact := outf
	: persist('TEMP::DEA_As_BC');