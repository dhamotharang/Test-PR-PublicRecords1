import property,lib_keylib,lib_fileservices,ut,Business_Header,Header;

airmen_base := faa.file_airmen_data_out;

Header.Layout_New_Records Translate_Airmen_to_Header(airmen_base l) := transform
	self.did := 0;
	self.rid := 0;
	self.pflag1 := '';
	self.pflag2 := '';
	self.pflag3 := '';
	self.src := 'AM';
	self.dt_first_seen := (unsigned3)(l.date_first_seen[1..6]);
	self.dt_last_seen := (unsigned3)(l.date_last_seen[1..6]);
	self.dt_vendor_first_reported := (unsigned3)(l.date_first_seen[1..6]);
	self.dt_vendor_last_reported := (unsigned3)(l.date_last_seen[1..6]);
	self.dt_nonglb_last_seen := self.dt_last_seen;
	self.rec_type := if(l.current_flag = 'A', '1', '2');
	self.vendor_id := L.unique_id + ',' + L.current_flag + ',' + 
				   l.med_date;
	self.phone := '';
	self.ssn := '';
	self.dob := 0;
	self.city_name := l.v_city_name;
	self.cbsa := if(l.msa!='',l.msa + '0','');
	self.tnt := '';
	self.valid_ssn := '';
	self.jflag1 := '';
	self.jflag2 := '';
	self.jflag3 := '';
	self := L;
end;


airmen_project := project(airmen_base,Translate_Airmen_to_Header(left));

export faa_airmen_as_header := airmen_project(lname != '' and prim_name != '' and zip != '');