export Layout_Profile_Output_Group := record
unsigned6 group_id;
unsigned4 inseq;
Business_Risk.Layout_Profile_Output;
unsigned2 group_bdid_cnt := 0;
unsigned4 group_dt_first_seen_min := 0;
unsigned4 group_dt_last_seen_max := 0;
unsigned1 group_sources_max := 0;
unsigned3 group_cnt_base_max := 0;
unsigned2 group_property_cnt := 0;
unsigned4 group_property_total_value := 0;
unsigned3 group_vehicle_cnt := 0;
end;