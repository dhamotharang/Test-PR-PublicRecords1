EXPORT layout_lookups := MODULE

  // Lookups
  export counts := RECORD
    unsigned2 veh_cnt;
    unsigned2 dl_cnt;
    unsigned2 head_cnt;
    unsigned2 crim_cnt;
    unsigned2 sex_cnt;
    unsigned2 ccw_cnt;
    unsigned2 rel_count;
  	unsigned2 assoc_count;
    unsigned2 fire_count;
    unsigned2 faa_count;
    unsigned2 prof_count;
    unsigned2 vess_count;
    unsigned2 bus_count;
    unsigned2 paw_count;
    unsigned2 bc_count;
    unsigned2 prop_count;
    unsigned2 prop_asses_count;
    unsigned2 prop_deeds_count;
    unsigned2 bk_count;
		unsigned2 sanc_count;
		unsigned2 prov_count;
	end;


	// Lookups v2
  export counts_v2 := RECORD
    unsigned2 corp_affil_count;
    unsigned2 comp_prop_count;
    unsigned2 phonesplus_count;
		unsigned2 email_count;
		unsigned2 accident_count;
  end;

  // combined
  export xcount := RECORD
    counts;
    counts_v2;
  end;
  
END;
