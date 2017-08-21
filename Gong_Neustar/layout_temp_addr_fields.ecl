//during the process we separately store the orig clean address fields and the appended address fields
//and while we want to continue keeping them separate, map them to a single set of fields for DID'ing, etc

export layout_temp_addr_fields := record
 layout_gongMaster;
 boolean   targus_append_flag:=false;
 unsigned1 did_score         := 0;
 unsigned1 hhid_score        := 0;
 unsigned1 bdid_score        := 0;
 string10  temp_prim_range   :='';
 string2   temp_predir       :='';
 string28  temp_prim_name    :='';
 string4   temp_suffix       :='';
 string2   temp_postdir      :='';
 string8   temp_sec_range    :='';
 string25  temp_p_city_name  :='';
 string2   temp_st           :='';
 string5   temp_z5           :='';
end;