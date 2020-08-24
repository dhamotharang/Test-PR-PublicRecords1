Import Data_Services, doxie,FLAccidents;

/////////////////////////////////////////////////////////////////
//Expand Florida file 
/////////////////////////////////////////////////////////////////
flc3v	:= FLAccidents.basefile_flcrash3v;
xpnd_layout := record
    string2 report_code;
    string25 report_category;
    string65 report_code_desc;
  	string1    rec_type_3,
	string40   accident_nbr,
	string2    section_nbr,
	string2    filler1,
	string4    towed_trlr_veh_yr,
	string4    towed_trlr_make,
	string2    towed_trailer_type,
	string8    towed_trlr_veh_tag_nbr,
	string2    towed_trlr_veh_state,
	string22   towed_trlr_veh_id_nbr,
	string7    towed_trlr_veh_est_damage,
	string25   towed_trlr_veh_owner_name,
	string16   filler2,
	string1    towed_trlr_veh_owner_name_suffix,
	string40   towed_trlr_veh_owner_st_city,
	string18   filler3,
	string2    towed_trlr_veh_owner_st,
	string9    towed_trlr_veh_owner_zip,
	string2    towed_trlr_fr_cap_code,
	string224  filler4,
	string4    blank1,
	string42   vehicle_seg,
	string1    vehicle_seg_type,
	string14   match_code,
	string4    model_year,
	string1    blank2,
	string3    manufacturer_corporation,
	string1    division_code,
	string2    vehicle_group_code,
	string2    vehicle_subgroup_code,
	string2    vehicle_series_code,
	string2    body_style_code,
	string3    vehicle_abbreviation,
	string1    assembly_country,
	string1    headquarter_country,
	string1    number_of_doors,
	string1    seating_capacity,
	string2    number_of_cylinders,
	string4    engine_size,
	string1    fuel_code,
	string1    carburetion_type,
	string1    number_of_barrels,
	string1    price_class_code,
	string2    body_size_code,
	string1    number_of_wheels_on_road,
	string1    number_of_driving_wheels,
	string1    drive_type,
	string1    steering_type,
	string1    gvw_code,
	string1    load_capacity_code,
	string1    cab_type_code,
	string2    bed_length,
	string1    rim_size,
	string5    manufacture_body_style,
	string1    vehicle_type_code,
	string3    car_line_code,
	string1    car_series_code,
	string1    car_body_style_code,
	string1    engine_cylinder_code,
	string3    truck_make_abbreviation,
	string3    truck_body_style_abbreviation,
	string3    motorcycle_make_abbreviation,
	string3    vina_series,
	string3    vina_model,
	string5    reference_number,
	string3    vina_make,
	string2    vina_body_style,
	string20   make_description,
	string20   model_description,
	string20   series_description,
	string2    blank3,
	string3    car_series,
	string2    car_body_style,
	string3    car_cid,
	string2    car_cylinders,
	string1    car_carburetion,
	string1    car_fuel_code,
	string2    truck_chassis_body_style,
	string2    truck_wheels_driving_wheels,
	string4    truck_cid,
	string2    truck_cylinders,
	string1    truck_fuel_code,
	string1    truck_manufacturers_gvw_code,
	string2    truck_ton_rating_code,
	string3    truck_series,
	string3    truck_model,
	string3    motorcycle_model,
	string4    motorcycle_engine_displacement,
	string2    motorcycle_type_of_bike,
	string2    motorcycle_cylinder_coding,
	string40   orig_accnbr; 
  end;
xpnd_layout xpndrecs(flc3v L) := transform
self.report_code					:= 'FA';
self.report_category				:= 'Auto Report';
self.report_code_desc				:= 'Auto Accident';
self.accident_nbr := stringlib.StringFilter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.orig_accnbr := l.accident_nbr; 
self 								:= L;
end;

pflc3v:= project(flc3v,xpndrecs(left));
//ntlFile := FLAccidents.BaseFile_NtlAccidents_Alpharetta;
//National file does not have information pertinent to this layout.  Therefore only passing FL records.


export key_Ecrash3v := index(pflc3v
                            ,{string40 l_acc_nbr := accident_nbr}
							,{pflc3v}
							,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrash3v_' + doxie.Version_SuperKey);