//gong key based on some address fields
import doxie, gong_v2;

hist_in := Gong_v2.proc_roxie_keybuild_prep(trim(prim_name)<>'', trim(z5)<>'');
gong_v2.mac_hist_full_slim_dep(hist_in, hist_out);

export Key_History_Address := 
       index(hist_out,
             {prim_name,
		    st,
		    z5, 
		    prim_range, 
		    sec_range,
		    boolean current_flag := if(current_record_flag='Y',true,false),
		    boolean business_flag := if(listing_type_bus='B',true,false)},
		    {hist_out},
		    Gong_v2.thor_cluster+'key::gongv2_history_address_' + doxie.Version_SuperKey);