import gong, gong_v2, doxie;

input_recs := dedup(sort(project(Gong_v2.proc_roxie_keybuild_prep_current2(TRIM(st)<>'' AND TRIM(p_city_name)<>'' AND TRIM(prim_name)<>''),
                      transform(gong_v2.Layout_bscurrent_raw, self:=left, self := [])),record),record);

export Key_st_city_prim_name_prim_rangev2 := 
       index(input_recs,
             {string2 st := st,
							string25 city := p_city_name,
							string28 prim_name := prim_name,
							string10 prim_range := prim_range},
             {input_recs},
		   Gong_v2.thor_cluster + 'key::gongv2_eda_st_city_prim_name_prim_range_' + doxie.Version_SuperKey);
