import header;

df := file_apf_pe_in;

header.Layout_New_Records into(df L,integer C) := transform
	self.title := L.pname[1..5];
	self.fname := L.pname[6..25];
	self.mname := L.pname[26..45];
	self.lname := L.pname[46..65];
	self.name_suffix := L.pname[66..70];
	self.prim_range := l.clean_address[1..10];
	self.Predir := l.clean_address[11..12];
	self.prim_name := l.clean_address[13..40];
	self.Suffix := l.clean_address[41..44];
	self.Postdir := l.clean_address[45..46];
	self.unit_desig := l.clean_address[47..56];
	self.Sec_Range := l.clean_address[57..64];
	self.City_name := l.clean_address[65..89];
	self.St := l.clean_address[115..116];
	self.Zip := l.clean_address[117..121];
	self.Zip4 := l.clean_address[122..125];
	self.county := L.clean_address[141..145];
	self.cbsa := if(L.clean_address[167..170]='','',L.clean_address[167..170] + '0');
	self.geo_blk := l.clean_address[171..177];
	self.did := 0;
	//self.preglb_did := 0;
	self.rid := 0;
	self.pflag1 := '';
	self.pflag2 := '';
	self.pflag3 := '';
	self.src := 'AK';
	self.dt_first_seen := ((integer)L.process_Date) div 100;
	self.dt_last_seen := ((integer)L.process_Date) div 100;
	self.dt_vendor_last_reported := ((integer)L.process_Date) div 100;
	self.dt_vendor_first_reported := ((integer)L.process_Date) div 100;
	self.dt_nonglb_last_seen := ((integer)L.process_Date) div 100;
	self.rec_type := '2'; 
	self.vendor_id := '';
	self.phone := '';
	self.ssn := '';
	self.dob := 0;
	self.tnt := '';
	self.uid := C;
end;

export APF_PE_As_Header := project(df,into(LEFT,COUNTER));