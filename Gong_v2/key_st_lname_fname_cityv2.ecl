import gong_v2, doxie;

input_recs := Gong_v2.proc_roxie_keybuild_prep2(listing_type_res = 'R' and name_last <>'' and name_first<>'' and p_city_name <>'');



export Key_st_lname_fname_cityv2 := 
       index(input_recs,
             {string2 st := st;
							string20 lname := name_last;
						  string20 fname := fname;
							string25 city := p_city_name},
             {input_recs},
		     Gong_v2.thor_cluster+'key::gongv2_eda_st_lname_fname_city_' + doxie.Version_SuperKey);
