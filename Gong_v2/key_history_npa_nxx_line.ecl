import gong_v2, doxie;

hist_in := Gong_v2.proc_roxie_keybuild_prep(length(TRIM(phone10))=10);
gong_v2.mac_hist_full_slim_dep(hist_in, hist_out);

export key_history_npa_nxx_line :=  
       index(hist_out,
             {string3 npa := phone10[1..3],
		    string3 nxx := phone10[4..6],
		    string4 line := phone10[7..10],
		    boolean current_flag := if(current_record_flag='Y',true,false),
		    boolean business_flag := if(listing_type_bus='B',true,false)},
             {hist_out},
		     Gong_v2.thor_cluster+'key::gongv2_history_npa_nxx_line_' + doxie.Version_SuperKey);