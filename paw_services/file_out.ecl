import autokeyb,Business_Header_SS,ut,business_header;

new_layout := RECORD
business_header.Layout_Business_Contact_Full;
string3 score;

/*
unsigned6  did; 
unsigned6  bdid;
string9   ssn;
string3   score;
string120 company_name;
string10  company_prim_range;
string2   company_predir;
string28  company_prim_name;
string4   company_addr_suffix;
string2   company_postdir;
string5   company_unit_desig;
string8   company_sec_range;
string25  company_city;
string2   company_state;
string5   company_zip;
//used to be string4   company_zip4;
string4   company_zip5;
string35  company_title;
string35  company_department;
string10  company_phone;
string9   company_fein;
string5   title;
string20  fname;
string20  mname;
string20  lname;
string5   name_suffix;
string10  prim_range;
string2   predir;
string28  prim_name;
string4   addr_suffix;
string2   postdir;
string5   unit_desig;
string8   sec_range;
string25  city;
string2   state;
string5   zip;
//used to be string4 zip4
string4   zip5;
string3   county;
string4   msa;
string10  geo_lat;
string11  geo_long;
string10  phone;
string60  email_address;
string8   dt_first_seen;
string8   dt_last_seen;
string1   record_type;
string1   active_phone_flag;
string1   GLB;
string2   source;
string2   DPPA_State;
*/
END;







dd := business_header.File_Employment_Out;
//output(d2);

new_layout transthis(business_header.Layout_Employment_Out l) :=TRANSFORM
self.dt_first_seen := (unsigned4) l.dt_first_seen;
self.dt_last_seen :=(unsigned4) l.dt_last_seen;
self.GLB := (boolean) ((integer) l.GLB);
self.zip := (unsigned3) l.zip;
self.zip4 := (unsigned2) l.zip4;
self.phone :=(unsigned5) l.phone;
self.ssn := (unsigned5) l.ssn;
self.company_zip :=(unsigned3) l.company_zip;
self.company_zip4 :=(unsigned2) l.company_zip4;
self.company_phone :=(unsigned5) l.company_phone;
self.company_fein := (unsigned5) l.company_fein;
self.did := (unsigned6) l.did;
self.bdid :=(unsigned6) l.bdid;

//self.zip5 := l.zip4;
//self.company_zip5 :=l.company_zip4;

self := l;
self := [];
END;

d1 := Project(dd, transthis(left));

rec := record
	d1;
	unsigned1 zero := 0;
	string5 zip5;
	string5 company_zip5;
end;

rec tra(d1 l) := transform
	self := l;
	self.zip5 := if(l.zip = 0, '', (string5)l.zip);
	self.company_zip5 := if(l.company_zip = 0, '', (string5)l.company_zip);
end;

d2 := project(d1, tra(left));


export file_out := d2;