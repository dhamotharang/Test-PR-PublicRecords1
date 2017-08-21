import header, ut;

h := header.File_EQ_OUT_plus;

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
    unsigned integer8 __filepos;// { virtual(fileposition)};
end;

string_rec t1(h le) := 
TRANSFORM
	mymin := ut.min2(ut.min2((unsigned6)le.dt_first_seen,
									
				 (unsigned6)le.dt_last_seen),
								
	(unsigned6)le.dt_vendor_last_reported);
	SELF.dt_vendor_first_reported := IF(mymin=0,'',(STRING6)mymin);
	SELF := le;
END;

p1 := project(h,t1(left));

unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

// Because the only layout that actually exists in an attribute is the "File_Out_Plus" used above.  However, that
// layout uses the extra unsigned8 of __filepos, which must be removed below before doing the match on record length.
rawsize := (sizeof(header.Layout_File_Out_plus)-8) * count(p1) : global;
headersize := if ((sizeof(header.Layout_File_Out_plus)-8)>215, (sizeof(header.Layout_File_Out_plus)-8), error('too bad')) : global;

dfile := INDEX(p1,{f:= moxietransform(__filepos, rawsize, headersize)},{p1},'~thor_data400::key::moxie.eq_header.fpos.data.key');

count(dfile);

export one_off := buildindex(dfile,moxie,overwrite);