//gong key based on some address fields
import doxie, gong;

hist_in := Gong.file_daily_full(trim(prim_name)<>'', trim(z5)<>'');
gong.mac_hist_full_slim_dep_dly(hist_in, hist_out);

export Key_Daily_History_Address := 
       index(hist_out,
             {prim_name,
		    st,
		    z5, 
		    prim_range, 
		    sec_range},
		    //boolean current_flag := if(current_record_flag='Y',true,false),
		    //boolean business_flag := if(listing_type_bus='B',true,false)},
		    {hist_out},
		    '~thor_data400::key::gong_daily_address_' + doxie.Version_SuperKey);