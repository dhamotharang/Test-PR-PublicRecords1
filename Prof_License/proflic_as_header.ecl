import header;

df := Proflic_as_Source;

header.Layout_New_Records into(df L) := transform
	self.did := 0;
	self.rid := 0;
	self.vendor_id := L.license_number[1..18];
	self.dt_first_seen := 0;
	self.dt_last_seen := 0;
	self.dt_vendor_first_reported := 0;
	self.dt_vendor_last_reported := 0;
	self.dt_nonglb_last_seen := 0;
	self.rec_type := '2';
	self.pflag1 := '';
	self.pflag2 := '';
	self.pflag3 := '';
	self.jflag1 := '';
	self.jflag2 := '';
	self.jflag3 := '';
	self.ssn := '';
	self.dob := (integer)L.dob;
	self.city_name := L.p_city_name;
	self.cbsa := if(l.msa='','',l.msa+'0');
	self := L;
end;

export proflic_as_header := project(df,into(LEFT))(prim_name!='' and lname!='');