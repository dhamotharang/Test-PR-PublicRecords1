import gong, gong_v2, doxie;

input_recs := dedup(sort(project(Gong_v2.proc_roxie_keybuild_prep_current2(listing_type_res = 'R' AND name_last<>''), 
                      transform(gong_v2.Layout_bscurrent_raw, self:=left, self := [])),record),record);

export Key_st_lname_cityv2 := 
       index(input_recs,
             {string2 st := st,
						  string20 lname := name_last,
							string25 city := p_city_name},
             {input_recs},
		   Gong_v2.thor_cluster + 'key::gongv2_eda_st_lname_city_' + doxie.Version_SuperKey);
