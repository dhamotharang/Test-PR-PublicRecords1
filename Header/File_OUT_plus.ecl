string_rec := record

	string12 	did;	//converted from int
	//string12 	preGLB_did;	//converted from int
	string12 	rid;  //converted from int

	string1     src;
	string1     src2;

	string6 	dt_first_seen;
	string6     dt_last_seen;
	string6     dt_vendor_last_reported;
	string6     dt_vendor_first_reported ;
	string6     dt_nonglb_last_seen ;

	string1     rec_type ;
	string18    vendor_id;
	string10    phone ;
	string9     ssn ;

	string8     dob ;

	string5     title ;
	string20    fname;
	string20    mname ;
	string20    lname ;
	string5     name_suffix ;
	string10    prim_range ;
	string2     predir ;
	string28    prim_name ;
	string4     suffix ;
	string2     postdir ;
	string10    unit_desig;
	string8     sec_range ;
	string25    city_name ;
	string2     st ;
	string5     zip ;
	string4     zip4 ;
	string3     county ;
	string4     msa ;
	string1     tnt;
	string1		valid_ssn;
    unsigned integer8 __filepos { virtual(fileposition)};
end;



export file_out_plus := dataset(header.Filename_Out,string_rec,flat);