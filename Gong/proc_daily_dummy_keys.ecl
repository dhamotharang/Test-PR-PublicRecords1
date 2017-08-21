import gong,roxiekeybuild,doxie,ut,lssi;

thisfiledate := '00000000';


dels_rec := record
	gong.Layout_gong_deletion,
	unsigned8 __fpos { virtual (fileposition)},
end;

dels_plus := choosen(dataset('~thor_data400::base::gong_daily_deletions_building',dels_rec,flat,OPT),1);

layout_remove := record
	string10 phone10,	
	unsigned8 __fpos,
end;

layout_remove get_phone10(dels_plus l) := transform
	self.phone10 := l.area_code + l.phone7;
	self := l;	
end;

pre2 := project(dels_plus(phone7[4..7]<>'XXXX'), get_phone10(left));

pre1_record := record
unsigned6 did := 0;
gong.Layout_bscurrent_raw;

end;

pre1_short := choosen(dataset('~thor_data400::Base::Gong',gong.Layout_bscurrent_raw,flat)(bell_id = 'AAA'),10);

pre1_record project_it(pre1_short l) := transform

	self := l;
	end;
	




pre1 := project(pre1_short,project_it(left));






bk1 := buildindex(
	index(pre1,{unsigned6 l_did := did},{pre1},'bk1', OPT)
	,'~thor_data400::key::gong_daily::'+thisfiledate+'::did_add' ,overwrite);


pre3_record := record
unsigned6 hhid := 0;
gong.Layout_bscurrent_raw;

end;

pre3_short := choosen(dataset('~thor_data400::Base::Gong',gong.Layout_bscurrent_raw,flat)(bell_id = 'AAA'),10);

pre3_record project_it1(pre3_short l) := transform

	self := l;
	end;
	




pre3 := project(pre3_short,project_it1(left));



	
bk2 := buildindex(	index(pre3,	{unsigned6 s_hhid := hhid}, {pre3},'bk2',OPT),
	'~thor_data400::key::gong_daily::'+thisfiledate+'::hhid_add' ,overwrite);



pre4_record := record
gong.Layout_bscurrent_raw;
string20 fname := '';
string20 mname := '';
string20 lname := '';
end;

pre4_short := choosen(dataset('~thor_data400::Base::Gong',gong.Layout_bscurrent_raw,flat)(bell_id = 'AAA'),10);

pre4_record project_it4(pre4_short l) := transform

	self := l;
	end;
	




pre4 := project(pre4_short,project_it4(left));



bk3 := buildindex(
		index(pre4,{prim_name, z5, prim_range, sec_range, predir, suffix},
		{phone10, listed_name, fname, mname, lname}


		,'bk3',	OPT),
		'~thor_data400::key::gong_daily::'+thisfiledate+'::address_add' ,overwrite);

pre5_record := record
gong.Layout_bscurrent_raw;
string7 phone7 := '';
string3 area_code := '';
end;

pre5_short := choosen(dataset('~thor_data400::Base::Gong',gong.Layout_bscurrent_raw,flat)(bell_id = 'AAA'),10);

pre5_record project_it5(pre5_short l) := transform

	self := l;
	end;
	




pre5 := project(pre5_short,project_it5(left));



bk4 := buildindex(index(pre5,
						 {STRING7 ph7 := phone7,
						  STRING3 ph3 := area_code,
							st,
						  boolean business_flag := if(listing_type_bus = 'B', true, false)},
						 {pre5},
						 '~thor_data400::key::gong_phone_add_' + doxie.Version_SuperKey,OPT),
	             '~thor_data400::key::gong_daily::'+thisfiledate+'::phone_add' ,overwrite);

pre6_record := record
gong.Layout_bscurrent_raw;
end;

pre6_short := choosen(dataset('~thor_data400::Base::Gong',gong.Layout_bscurrent_raw,flat)(bell_id = 'AAA'),10);

pre6_record project_it6(pre6_short l) := transform

	self := l;
	end;
	




pre6 := project(pre6_short,project_it6(left));


	   
bk5 := buildindex(index(pre6,
				 {p_city_name,z5,prim_name,prim_range,name_last,name_first},
				 {pre6},
				 'bk5',OPT	),
	             '~thor_data400::key::gong_daily::'+thisfiledate+'::czsslf_add' ,overwrite);


pre7_record := record
gong.Layout_bscurrent_raw;
end;

pre7_short := choosen(dataset('~thor_data400::Base::Gong',gong.Layout_bscurrent_raw,flat)(bell_id = 'AAA'),10);

pre7_record project_it7(pre7_short l) := transform

	self := l;
	end;
	




pre7 := project(pre7_short,project_it7(left));
						   

bk6 := buildindex(index(pre7,
				{name_last,p_city_name,z5,name_first},
				 {pre7},
				 'bk6',OPT),
	             '~thor_data400::key::gong_daily::'+thisfiledate+'::lczf_add' ,overwrite);
						   
///  delete file   help me here
bk7 := buildindex(index(pre2,
                           {l_phone10 := phone10, __fpos}, 
				       'bk7',OPT),
					   '~thor_data400::key::gong_daily::'+thisfiledate+'::remove' ,overwrite,few);


pre8_record := record
gong.Layout_bscurrent_raw;
end;

pre8_short := choosen(dataset('~thor_data400::Base::Gong',gong.Layout_bscurrent_raw,flat)(bell_id = 'AAA'),10);

pre8_record project_it8(pre8_short l) := transform

	self := l;
	end;
	




pre8 := project(pre8_short,project_it8(left));



eda1 := buildindex(index(pre8,
           {string3 npa := phone10[1..3],
		   string3 nxx := phone10[4..6],
		   string4 line := phone10[7..10]},
           {pre8},
		   'eda1', OPT),
		   '~thor_data400::key::gong_daily::'+thisfiledate+'::eda_npa_nxx_line_add' ,overwrite);

pre9_record := record
gong.Layout_bscurrent_raw;

end;

pre9_short := choosen(dataset('~thor_data400::Base::Gong',gong.Layout_bscurrent_raw,flat)(bell_id = 'AAA'),10);

pre9_record project_it9(pre9_short l) := transform

	self := l;
	end;
	




pre9 := project(pre9_short,project_it9(left));

eda2 := buildindex(index(pre9,
             {string2 st := st,
			  string30 word := '',
			  string25 city := ''},
             {pre9},
		   'eda2', OPT),
		   '~thor_data400::key::gong_daily::'+thisfiledate+'::eda_st_bizword_city_add' ,overwrite);

pre10_record := record
gong.Layout_bscurrent_raw;
end;

pre10_short := choosen(dataset('~thor_data400::Base::Gong',gong.Layout_bscurrent_raw,flat)(bell_id = 'AAA'),10);

pre10_record project_it10(pre10_short l) := transform

	self := l;
	end;
	




pre10 := project(pre10_short,project_it10(left));

eda3 := buildindex(index(pre10,
             {string2 st := st,
				string25 city := '',
				string28 prim_name := prim_name,
				string10 prim_range := prim_range},
             {pre10},
		   'eda3', OPT),
		   '~thor_data400::key::gong_daily::'+thisfiledate+'::eda_st_city_prim_name_prim_range_add' ,overwrite);

pre11_record := record
gong.Layout_bscurrent_raw;
end;

pre11_short := choosen(dataset('~thor_data400::Base::Gong',gong.Layout_bscurrent_raw,flat)(bell_id = 'AAA'),10);

pre11_record project_it11(pre11_short l) := transform

	self := l;
	end;
	




pre11 := project(pre11_short,project_it11(left));


eda4 := buildindex(index(pre11,
             {string2 st := st,
			  string20 lname := name_last,
			  string25 city := ''},
             {pre11},
		   'eda4', OPT),
		   '~thor_data400::key::gong_daily::'+thisfiledate+'::eda_st_lname_city_add' ,overwrite);

pre12_record := record
gong.Layout_bscurrent_raw;
end;

pre12_short := choosen(dataset('~thor_data400::Base::Gong',gong.Layout_bscurrent_raw,flat)(bell_id = 'AAA'),10);

pre12_record project_it12(pre12_short l) := transform

	self := l;
	end;
	




pre12 := project(pre12_short,project_it12(left));

eda5 := buildindex(index(pre12,
             {string2 st := st;
			string20 lname := name_last;
			string20 fname := '';
			string25 city := ''},
             {pre12},
		   'eda5', OPT),
		   '~thor_data400::key::gong_daily::'+thisfiledate+'::eda_st_lname_fname_city_add' ,overwrite);

pre13_record := record
 string28 prim_name;
  string2 st;
  string5 z5;
  string10 prim_range;
  string8 sec_range;
  string1 listing_type_bus;
  string1 listing_type_res;
  string1 listing_type_gov;
  string1 publish_code;
  string3 prior_area_code;
  string10 phone10;
  string2 predir;
  string4 suffix;
  string2 postdir;
  string10 unit_desig;
  string25 p_city_name;
  string2 v_predir;
  string28 v_prim_name;
  string4 v_suffix;
  string2 v_postdir;
  string25 v_city_name;
  string4 z4;
  string5 county_code;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string32 designation;
  string5 name_prefix;
  string20 name_first;
  string20 name_middle;
  string20 name_last;
  string5 name_suffix;
  string120 listed_name;
  string254 caption_text;
  string1 omit_address;
  string1 omit_phone;
  string1 omit_locality;
  string64 see_also_text;

end;

pre13_short := choosen(dataset('~thor_data400::Base::Gong',gong.Layout_bscurrent_raw,flat)(bell_id = 'AAA'),10);

pre13_record project_it13(pre13_short l) := transform

	self := l;
	end;
	




pre13 := project(pre13_short,project_it13(left));
						   
hist1 := buildindex(index(pre13,
             {prim_name,
		    st,
		    z5, 
		    prim_range, 
		    sec_range},
		    {pre13},
		    'hist1'),
			'~thor_data400::key::gong_daily::'+thisfiledate+'::address' ,overwrite);

pre14_record := record
  string2 st;
  string1 listing_type_bus;
  string1 listing_type_res;
  string1 listing_type_gov;
  string1 publish_code;
  string3 prior_area_code;
  string10 phone10;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string2 v_predir;
  string28 v_prim_name;
  string4 v_suffix;
  string2 v_postdir;
  string25 v_city_name;
  string5 z5;
  string4 z4;
  string5 county_code;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string32 designation;
  string5 name_prefix;
  string20 name_first;
  string20 name_middle;
  string20 name_last;
  string5 name_suffix;
  string120 listed_name;
  string254 caption_text;
  string1 omit_address;
  string1 omit_phone;
  string1 omit_locality;
  string64 see_also_text;
string7 phone7 := '';
	string3 area_code := '';
end;

pre14_short := choosen(dataset('~thor_data400::Base::Gong',gong.Layout_bscurrent_raw,flat)(bell_id = 'AAA'),10);

pre14_record project_it14(pre14_short l) := transform

	self := l;
	end;
	




pre14 := project(pre14_short,project_it14(left));

hist2 := buildindex(index(pre14,
             {p7 := phone7,p3 := area_code,st},
			 {pre14},
             'hist2'),
			 '~thor_data400::key::gong_daily::'+thisfiledate+'::phone' ,overwrite);

pre15_record := record

  string20 name_last;
  string2 st;

  string20 name_first;
  string1 listing_type_bus;
  string1 listing_type_res;
  string1 listing_type_gov;
  string1 publish_code;
  string3 prior_area_code;
  string10 phone10;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string2 v_predir;
  string28 v_prim_name;
  string4 v_suffix;
  string2 v_postdir;
  string25 v_city_name;
  string5 z5;
  string4 z4;
  string5 county_code;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string32 designation;
  string5 name_prefix;
  string20 name_middle;
  string5 name_suffix;
  string120 listed_name;
  string254 caption_text;
  string1 omit_address;
  string1 omit_phone;
  string1 omit_locality;
  string64 see_also_text;


end;

pre15_short := choosen(dataset('~thor_data400::Base::Gong',gong.Layout_bscurrent_raw,flat)(bell_id = 'AAA'),10);

pre15_record project_it15(pre15_short l) := transform

	self := l;
	end;
	




pre15 := project(pre15_short,project_it15(left));
						   
hist3 := buildindex(index(pre15,
             {string6 dph_name_last := metaphonelib.DMetaPhone1(name_last),
							name_last,
							st,
              string20 p_name_first := datalib.preferredfirst(name_first),
							name_first},
             {pre15},
		   'hist4'),
		   '~thor_data400::key::gong_daily::'+thisfiledate+'::name' ,overwrite);

pre16_record := record

  string20 name_last;
  string20 name_first;
  string1 listing_type_bus;
  string1 listing_type_res;
  string1 listing_type_gov;
  string1 publish_code;
  string3 prior_area_code;
  string10 phone10;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string2 v_predir;
  string28 v_prim_name;
  string4 v_suffix;
  string2 v_postdir;
  string25 v_city_name;
  string2 st;
  string5 z5;
  string4 z4;
  string5 county_code;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string32 designation;
  string5 name_prefix;
  string20 name_middle;
  string5 name_suffix;
  string120 listed_name;
  string254 caption_text;
  string1 omit_address;
  string1 omit_phone;
  string1 omit_locality;
  string64 see_also_text;

end;

pre16_short := choosen(dataset('~thor_data400::Base::Gong',gong.Layout_bscurrent_raw,flat)(bell_id = 'AAA'),10);

pre16_record project_it16(pre16_short l) := transform

	self := l;
	end;
	




pre16 := project(pre16_short,project_it16(left));

hist4 := buildindex(index(pre16,
             {string6 dph_name_last := metaphonelib.DMetaPhone1(name_last),
			  integer4 zip5 := (integer4)z5,
              string20 p_name_first := datalib.preferredfirst(name_first),
			  name_last,
			  name_first},
            {pre16},
		   'hist4'),
		   '~thor_data400::key::gong_daily::'+thisfiledate+'::zip_name' ,overwrite);

// Move to built


mv1 := sequential(
			FileServices.AddSuperFile('~thor_data400::key::gong_did_add_father', 
						   '~thor_data400::key::gong_did_add_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_did_add_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_did_add_built', 
						   '~thor_data400::key::gong_daily::'+thisfiledate+'::did_add' ));


mv2 := sequential(
			FileServices.AddSuperFile('~thor_data400::key::gong_hhid_add_father', 
	  					   '~~thor_data400::key::gong_hhid_add_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_hhid_add_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_hhid_add_built', 
						   '~thor_data400::key::gong_daily::'+thisfiledate+'::hhid_add' ));


mv3 := sequential(	  
			FileServices.AddSuperFile('~thor_data400::key::gong_address_add_father', 
						   '~thor_data400::key::gong_address_add_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_address_add_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_address_add_built', 
						   '~thor_data400::key::gong_daily::'+thisfiledate+'::address_add' ));
						   
mv4 := sequential(	  
			FileServices.AddSuperFile('~thor_data400::key::gong_phone_add_father', 
						   '~thor_data400::key::gong_phone_add_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_phone_add_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_phone_add_built', 
						   '~thor_data400::key::gong_daily::'+thisfiledate+'::phone_add' ));
						   
mv5 := sequential(	  
			FileServices.AddSuperFile('~thor_data400::key::gong_czsslf_add_father', 
						   '~thor_data400::key::gong_czsslf_add_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_czsslf_add_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_czsslf_add_built', 
						   '~thor_data400::key::gong_daily::'+thisfiledate+'::czsslf_add' ));						   

mv6 := sequential(	  
			FileServices.AddSuperFile('~thor_data400::key::gong_lczf_add_father', 
						   '~thor_data400::key::gong_lczf_add_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_lczf_add_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_lczf_add_built', 
						   '~thor_data400::key::gong_daily::'+thisfiledate+'::lczf_add' ));						   


mv7 := sequential(	  
			FileServices.AddSuperFile('~thor_data400::key::gong_remove_father', 
						   '~thor_data400::key::gong_remove_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_remove_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_remove_built', 
						   '~thor_data400::key::gong_daily::'+thisfiledate+'::remove' ));	
							 
mv8 := sequential(	  
			FileServices.AddSuperFile('~thor_data400::key::gong_eda_npa_nxx_line_add_father', 
						   '~thor_data400::key::gong_eda_npa_nxx_line_add_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_eda_npa_nxx_line_add_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_eda_npa_nxx_line_add_built', 
						   '~thor_data400::key::gong_daily::'+thisfiledate+'::eda_npa_nxx_line_add' ));

mv9 := sequential(	  
			FileServices.AddSuperFile('~thor_data400::key::gong_eda_st_bizword_city_add_father', 
						   '~thor_data400::key::gong_eda_st_bizword_city_add_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_eda_st_bizword_city_add_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_eda_st_bizword_city_add_built', 
						   '~thor_data400::key::gong_daily::'+thisfiledate+'::eda_st_bizword_city_add' ));

mv10 := sequential(	  
			FileServices.AddSuperFile('~thor_data400::key::gong_eda_st_city_prim_name_prim_range_add_father', 
						   '~thor_data400::key::gong_eda_st_city_prim_name_prim_range_add_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_eda_st_city_prim_name_prim_range_add_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_eda_st_city_prim_name_prim_range_add_built', 
						   '~thor_data400::key::gong_daily::'+thisfiledate+'::eda_st_city_prim_name_prim_range_add' ));

mv11 := sequential(	
			FileServices.AddSuperFile('~thor_data400::key::gong_eda_st_lname_city_add_father', 
						   '~thor_data400::key::gong_eda_st_lname_city_add_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_eda_st_lname_city_add_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_eda_st_lname_city_add_built', 
						   '~thor_data400::key::gong_daily::'+thisfiledate+'::eda_st_lname_city_add' ));

mv12 := sequential(	 
			FileServices.AddSuperFile('~thor_data400::key::gong_eda_st_lname_fname_city_add_father', 
						   '~thor_data400::key::gong_eda_st_lname_fname_city_add_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_eda_st_lname_fname_city_add_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_eda_st_lname_fname_city_add_built', 
						   '~thor_data400::key::gong_daily::'+thisfiledate+'::eda_st_lname_fname_city_add' ));
							 
mvhist1 := sequential(	 
			FileServices.AddSuperFile('~thor_data400::key::gong_daily_address_father', 
						   '~thor_data400::key::gong_daily_address_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_daily_address_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_daily_address_built', 
						   '~thor_data400::key::gong_daily::'+thisfiledate+'::address' ));

mvhist2 := sequential(	 
			FileServices.AddSuperFile('~thor_data400::key::gong_daily_phone_father', 
						   '~thor_data400::key::gong_daily_phone_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_daily_phone_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_daily_phone_built', 
						   '~thor_data400::key::gong_daily::'+thisfiledate+'::phone' ));
						   
mvhist3 := sequential(	 
			FileServices.AddSuperFile('~thor_data400::key::gong_daily_name_father', 
						   '~thor_data400::key::gong_daily_name_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_daily_name_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_daily_name_built', 
						   '~thor_data400::key::gong_daily::'+thisfiledate+'::name' ));

mvhist4 := sequential(	 
			FileServices.AddSuperFile('~thor_data400::key::gong_daily_zip_name_father', 
						   '~thor_data400::key::gong_daily_zip_name_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_daily_zip_name_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_daily_zip_name_built', 
					   '~thor_data400::key::gong_daily::'+thisfiledate+'::zip_name' ));
						 
ut.mac_sk_move('~thor_data400::key::gong_did_add','Q',out1)
ut.mac_sk_move('~thor_data400::key::gong_hhid_add','Q',out2)
ut.mac_sk_move('~thor_data400::key::gong_address_add','Q',out3)
ut.mac_sk_move('~thor_data400::key::gong_phone_add','Q',out4)
ut.mac_sk_move('~thor_data400::key::gong_czsslf_add','Q',out5)
ut.mac_sk_move('~thor_data400::key::gong_lczf_add','Q',out6)
ut.mac_sk_move('~thor_data400::key::gong_remove','Q',out7)
ut.mac_sk_move('~thor_data400::key::gong_eda_npa_nxx_line_add','Q',out8)
ut.mac_sk_move('~thor_data400::key::gong_eda_st_bizword_city_add','Q',out9)
ut.mac_sk_move('~thor_data400::key::gong_eda_st_city_prim_name_prim_range_add','Q',out10)
ut.mac_sk_move('~thor_data400::key::gong_eda_st_lname_city_add','Q',out11)
ut.mac_sk_move('~thor_data400::key::gong_eda_st_lname_fname_city_add','Q',out12)
ut.mac_sk_move('~thor_data400::key::gong_daily_address','Q',out13)
ut.mac_sk_move('~thor_data400::key::gong_daily_phone','Q',out14)
ut.mac_sk_move('~thor_data400::key::gong_daily_name','Q',out15)
ut.mac_sk_move('~thor_data400::key::gong_daily_zip_name','Q',out16)

RoxieKeyBuild.Mac_Daily_Email_Local('GONG','SUCC', thisfiledate, send_succ_msg,lssi.Notification_Email_Address);
//RoxieKeyBuild.Mac_Daily_Email_Local('GONG','FAIL', thisfiledate, send_fail_msg,lssi.Failure_Notification_Email_Address);


export proc_daily_dummy_keys := 
					sequential(parallel(bk1,bk2,bk3,bk4,bk5,bk6,bk7,eda1,eda2,eda3,eda4,eda5,
					hist1,hist2,hist3,hist4),
					parallel(mv1,mv2,mv3,mv4,mv5,mv6,mv8,mv9,mv10,mv11,mv12,mvhist1,mvhist2,mvhist3,mvhist4,mv7),
					parallel(out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12,
					 out13,out14,out15,out16),send_succ_msg);