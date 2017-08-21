EXPORT Layouts := module
	Export full_rec := RECORD
		unsigned6 did;
		unsigned2 sex_cnt;
		unsigned2 crim_cnt;
		unsigned2 ccw_cnt;
		unsigned2 head_cnt;
		unsigned2 veh_cnt;
		unsigned2 dl_cnt;
		unsigned2 rel_count;
		unsigned2 fire_count;
		unsigned2 faa_count;
		unsigned2 vess_count;
		unsigned2 prof_count;
		unsigned2 bus_count;
		unsigned2 prop_count;
		unsigned2 bk_count;
		unsigned2 prop_asses_count;
		unsigned2 prop_deeds_count;
		unsigned2 paw_count;
		unsigned2 bc_count;
		unsigned2 prov_count := 0;
		unsigned2 sanc_count := 0;
		unsigned6 hhid;
		string1 gender;
		unsigned2 house_size;
		unsigned2 sg_within_7;
		unsigned2 dg_within_7;
		unsigned2 ug_within_7;
		unsigned2 sg_y_8_15;
		unsigned2 dg_y_8_15;
		unsigned2 ug_y_8_15;
		unsigned2 sg_y_16_30;
		unsigned2 dg_y_16_30;
		unsigned2 ug_y_16_30;
		unsigned2 sg_o_8_15;
		unsigned2 dg_o_8_15;
		unsigned2 ug_o_8_15;
		unsigned2 sg_o_16_30;
		unsigned2 dg_o_16_30;
		unsigned2 ug_o_16_30;
		unsigned2 sg_o_30;
		unsigned2 dg_o_30;
		unsigned2 ug_o_30;
		unsigned2 sg_y_30;
		unsigned2 dg_y_30;
		unsigned2 ug_y_30;
		unsigned2 sg;
		unsigned2 dg;
		unsigned2 ug;
		unsigned2 kids;
		unsigned2 parents;
		unsigned2 corp_affil_count;
		unsigned2 comp_prop_count := 0;
		unsigned2 phonesplus_count;
		unsigned2 nonfares_prop_count;
		unsigned2 nofares_prop_asses_count;
		unsigned2 nofares_prop_deeds_count;
		unsigned2 filler5_count;
		unsigned2 filler6_count;
		unsigned2 filler7_count;
		unsigned2 filler8_count;
		unsigned2 filler9_count;
		unsigned2 filler10_count;
	END;

	Export r_layout :=  record
		unsigned6 did;
		unsigned2 corp_affil_count := 0;
		unsigned2 comp_prop_count := 0;
		// placeholders for future expansion so that the layout of the key does not change every time
		// we need to add a count
		unsigned2 veh_cnt := 0;
		unsigned2 dl_cnt := 0;
		unsigned2 head_cnt := 0;
		unsigned2 crim_cnt := 0;
		unsigned2 sex_cnt := 0;
		unsigned2 ccw_cnt := 0;
		unsigned2 rel_count := 0;
		unsigned2 fire_count := 0;
		unsigned2 faa_count := 0;
		unsigned2 prof_count := 0;
		unsigned2 vess_count := 0;
		unsigned2 bus_count := 0;
		unsigned2 paw_count := 0;	// new for hfss
		unsigned2 bc_count := 0;	// new for hfss
		unsigned2 prop_count := 0;
		unsigned2 prop_asses_count := 0;	// new for hfss
		unsigned2 prop_deeds_count := 0;	// new for hfss
		unsigned2 bk_count := 0;
		unsigned2 phonesplus_count := 0;
		unsigned2 nonfares_prop_count := 0;
		unsigned2 nofares_prop_asses_count := 0;
		unsigned2 nofares_prop_deeds_count := 0;
		unsigned2 filler5_count := 0;
		unsigned2 filler6_count := 0;
		unsigned2 filler7_count := 0;
		unsigned2 filler8_count := 0;
		unsigned2 filler9_count := 0;
		unsigned2 filler10_count := 0;
	END;

END;