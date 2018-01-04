import doxie, data_services;

/////////////////////////////////////////////////////////////////
//Expand Florida file 
/////////////////////////////////////////////////////////////////
flc0 	:= FLAccidents.basefile_flcrash0;
xpnd_layout := record
       string2 report_code;
       string25 report_category;
       string65 report_code_desc;
	   string1    rec_type_o,
       string10    accident_nbr,
       string4    filler1,
       string11   microfilm_nbr,
       string1    st_road_accident,
       string8    accident_date,
       string4    city_nbr,
       string4    ft_city_town,
       string2    miles_city_town,
       string1    direction_city_town,
       string17   city_town_name,
       string12   county_name,
       string5    at_node_nbr,
       string4    ft_miles_node,
       string1    ft_miles_code1,
       string5    from_node_nbr,
       string5    next_node_rdwy,
       string36   st_road_hhwy_name,
       string36   at_intersect_of,
       string4    ft_miles_from_intersect,
       string1    ft_miles_code2,
       string1    intersect_dir_of,
       string36   of_intersect_of,
       string1    codeable_noncodeable,
       string1    type_fr_case,
       string1    action_code,
       string1    filler2,
       string1    dot_type_facility,
       string1    dot_road_type,
       string2    dot_nbr_lanes,
       string2    dot_site_loc,
       string1    dot_district_ind,
       string2    dot_county,
       string3    dot_section_nbr,
       string2    dot_skid_resistance,
       string1    dot_friction_coarse,
       string6    dot_avg_daily_traffic,
       string5    dot_node_nbr,
       string5    dot_distance_node,
       string1    dot_dir_from_node,
       string6    dot_st_road_nbr,
       string5    dot_us_road_nbr,
       string6    dot_milepost,
       string1    dot_hhwy_loc,
       string3    dot_subsection,
       string1    dot_system_type,
       string1    dot_travelway,
       string2    dot_node_type,
       string2    dot_fixture_type,
       string1    dot_side_of_road,
       string1    dot_accident_severity,
       string1    dot_lane_id,
       string98   filler3,
       string1    dhsmv_veh_crash_ind,
       string15   acc_key_online_update,
       string1    form_type,
       string2    update_nbr,
       string1    accident_error,
       string8    filler4
  end;
xpnd_layout xpndrecs(flc0 L) := transform
self.report_code					:= 'FA';
self.report_category				:= 'Auto Report';
self.report_code_desc				:= 'Auto Accident';
self 								:= L;
end;

pflc0 := project(flc0,xpndrecs(left));
  
/////////////////////////////////////////////////////////////////
//Slim National file 
/////////////////////////////////////////////////////////////////  
ntlFile := FLAccidents.BaseFile_NtlAccidents_Alpharetta;

pflc0 slimrec(ntlFile L) := transform

self.rec_type_o 			:= '0';
self.accident_nbr 			:= (string10)((unsigned6)L.vehicle_incident_id+1000000000);
self.accident_date 			:= L.loss_date[7..10]+ L.loss_date[1..2]+ L.loss_date[4..5];
self.city_town_name 		:= stringlib.stringtouppercase(L.city);

self						:= L;
self						:= [];
end;

pntl := project(ntlFile,slimrec(left));

allrecs := pflc0+pntl : persist('~thor_data400::persist::ntlcrash0');

export Key_NtlCrash0 := index(allrecs,
                              {unsigned6 l_acc_nbr :=(integer)accident_nbr},
                              {allrecs},
                              data_services.data_location.prefix() + 'thor_data400::key::ntlcrash0_' + doxie.Version_SuperKey);