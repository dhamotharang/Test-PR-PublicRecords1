IMPORT $, dx_Gong, Gong;

hist_in := $.File_History_Full_Prepped_for_Keys((unsigned)phone10<>0, listing_type_bus<>'', listed_name<>'', current_record_flag<>'');
Gong.mac_hist_full_slim_dep(hist_in, hist_out)

EXPORT data_key_cn_to_company := PROJECT(hist_out, dx_Gong.layouts.i_cn_to_company);