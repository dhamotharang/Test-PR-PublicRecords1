base_ds := YellowPages.File_Keybuild_Bid;

temprec := record
	base_ds.bdid;
	base_ds.fname;
	base_ds.mname;
	base_ds.lname;
	base_ds.business_name;
	base_ds.phone10;
	base_ds.prim_name;
	base_ds.prim_range;
	base_ds.st;
	base_ds.p_city_name;
	base_ds.zip;
	base_ds.sec_range;
	unsigned1 zero := 0;
	string1 blank := '';
end;

tempnormalize := normalize(base_ds,if(left.lname != '' and left.exec_lname != '',2,1),transform(temprec,
	self.fname := if(counter = 1 and left.lname != '',left.fname,left.exec_fname),
	self.mname := if(counter = 1 and left.lname != '',left.mname,left.exec_mname),
	self.lname := if(counter = 1 and left.lname != '',left.lname,left.exec_lname),
	self := left));

export File_Search_Base_Bid := tempnormalize;
