import gong, gong_v2, doxie;

layout_with_fname := record
	gong_v2.Layout_bscurrent_raw;
	string20 fname;
end;

input_recs := project(Gong_v2.proc_roxie_keybuild_prep_current2((listing_type_res = 'R') AND (TRIM(name_last)<>'') AND 
                                                        (TRIM(name_first)<>'')),
                      transform(layout_with_fname, self:=left, self := []));

export Key_st_lname_fname_cityv2 := 
       index(input_recs,
             {string2 st := st;
							string20 lname := name_last;
						  string20 fname := fname;
							string25 city := p_city_name},
             {input_recs},
		   Gong_v2.thor_cluster + 'key::gongv2_eda_st_lname_fname_city_' + doxie.Version_SuperKey);
