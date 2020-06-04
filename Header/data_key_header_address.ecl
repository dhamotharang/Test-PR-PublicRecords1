import header, doxie_build,ut, dx_Header;

f := doxie_build.file_header_building(trim(prim_name)<>'', trim(zip)<>'');

slim_f := table(f, {did,
src,
dt_first_seen,
dt_last_seen,
phone,
ssn,
dob,
fname,
lname,
prim_range,
predir,
prim_name,
suffix,
postdir,
unit_desig,
sec_range,
city_name,
st,
zip,
zip4,
county,
geo_blk
});

slim_dedup  := DEDUP(SORT(slim_f,record),record);

pre_ccpa_compliance := PROJECT (slim_dedup, TRANSFORM(dx_Header.layouts.i_header_address,SELF:=LEFT,SELF.global_sid:=0,SELF.record_sid:=0));
wth_ccpa_compliance := header.fn_suppress_ccpa(pre_ccpa_compliance,true);

export data_key_header_address := wth_ccpa_compliance;

//export Key_Header_Address := 
//       index(slim_dedup, {prim_name, zip, prim_range, sec_range},{slim_dedup},
//		ut.Data_Location.Person_header+   'thor_data400::key::header_address_' + doxie.Version_SuperKey);
	