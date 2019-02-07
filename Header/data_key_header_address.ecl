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

export data_key_header_address := PROJECT (slim_dedup, dx_Header.layouts.i_header_address);

//export Key_Header_Address := 
//       index(slim_dedup, {prim_name, zip, prim_range, sec_range},{slim_dedup},
//		ut.Data_Location.Person_header+   'thor_data400::key::header_address_' + doxie.Version_SuperKey);
	