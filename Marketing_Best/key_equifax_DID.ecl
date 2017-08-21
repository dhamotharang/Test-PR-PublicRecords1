Import Data_Services, Marketing_Best, Address, Doxie, ut, DMA, lib_stringlib, did_add, Header_Slimsort, didville;

got_a_did0 := Marketing_Best.file_equifax_keybuild(did<>0);



//drop the gender in the key -> gender was added for title assignment in the header
old_layout_equifax_base := record
	unsigned6  	DID;
	marketing_best.layout_equifax;
	string5 		title;
	string20 		fname;
	string20 		mname;
	string20 		lname;
	string5 		name_suffix;
	string3 		name_score;
	string10  	prim_range;
	string2   	predir;
	string28  	prim_name;
	string4   	addr_suffix;
	string2   	postdir;
	string10  	unit_desig;
	string8   	sec_range;
	string25  	p_city_name;
	string25  	v_city_name;
	string2   	st;
	string5   	zip;
	string4   	zip4;
	string4   	cart;
	string1   	cr_sort_sz;
	string4   	lot;
	string1   	lot_order;
	string2   	dpbc;
	string1   	chk_digit;
	string2   	rec_type;
	string2   	ace_fips_st;
	string3			fips_county;
	string10  	geo_lat;
	string11  	geo_long;
	string4   	msa;
	string1   	geo_match;
	string4   	err_stat;
	String10		telephone;
end;

old_layout_equifax_base t1(got_a_did0 le) := transform
	//convert Median_Household_Income to Median_Household_Income_3_bytes and
	//        Median_Home_Value       to Median_Home_Value_4_bytes 11/6/13
	SELF.Median_Household_Income_3_bytes :=(STRING3) intformat(round((REAL)le.Median_Household_Income/100000*100),3,1);
	SELF.Median_Home_Value_4_bytes := (STRING4) intformat(round((REAL)le.Median_Home_Value/100000*100),4,1);
	self := le;
	//Needed because several fields, like mail_responsive_donor_indicator, have been removed from base file. 11/6/13
	self := [];
end;

got_a_did := project(got_a_did0,t1(left));

export key_equifax_DID := index(got_a_did,{unsigned6 l_did := (unsigned)did},{got_a_did},'~thor_data400::key::Marketing_Best::'+ Doxie.Version_SuperKey+'::equifax_DID');