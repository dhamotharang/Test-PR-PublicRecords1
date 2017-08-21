import lib_stringlib;

ds_water_old := watercraft.file_CG_clean_in_pre20090709; 
ds_water_new := watercraft.file_CG_clean_in;//new layout

watercraft.Layout_CG_clean_in_pre20090407 old_format(ds_water_old l) := transform
self := l;
end;

ds_water_proj_pre20090407 := project(ds_water_old, old_format(left));

watercraft.Layout_CG_clean_in_pre20090407 old_format2(ds_water_new l) := transform
self := l;
end;

ds_water_proj_pre20090709 := project(ds_water_new, old_format2(left));

ds_water_concat := ds_water_proj_pre20090709 + ds_water_proj_pre20090407 + watercraft.file_CG_clean_in_pre20090407;

Watercraft.Macro_Clean_Hull_ID(ds_water_concat, watercraft.Layout_CG_clean_in_pre20090407,hull_clean_in)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(hull_clean_in L) := transform


    self.watercraft_key				        :=	L.vessel_id;
	self.sequence_key				        :=	trim(L.NAME,left,right)+trim(L.FIRST_NAME,left,right)+trim(L.MID,left,right)+trim(L.LAST_NAME,left,right);
	self.watercraft_id						:=	L.HULL_ID;
	self.state_origin						:=	'US';
	self.source_code						:=	'CG';
	self.st_registration					:=	'';
	self.county_registration				:=	'';
	self.registration_number				:=	'';
	self.hull_number						:=	if(trim(L.HULL_ID,left, right)<>trim(L.Hull_Identification_Number_2,left, right),trim(L.HULL_ID+L.Hull_Identification_Number_2,left, right),trim(L.HULL_ID,left, right));
	self.propulsion_code					:=	'';
	self.propulsion_description				:=	trim(L.Propulsion_Type, left, right);
	self.vehicle_type_Code					:=	'';
	self.vehicle_type_Description			:=	trim(L.VEH_TYPE, left, right);
	self.fuel_code							:=	'';
	self.fuel_description					:=	L.FUEL;
	self.hull_type_code						:=	'';
	self.hull_type_description				:=	L.HULL;
	self.use_code							:=	'';
	self.use_description					:=	L.USE_1;
	self.watercraft_length					:=	L.TOTAL_INCH;
	self.model_year							:=	L.YEAR;
	self.watercraft_name					:=	L.name_of_vessel;
	self.watercraft_class_code				:=	'';
	self.watercraft_class_description		:=	'';
	self.watercraft_make_code				:=	'';
	self.watercraft_make_description		:=	L.MAKE;
	self.watercraft_model_code				:=	'';
	self.watercraft_model_description		:=	'';
	self.watercraft_width					:=	(string)(integer4)(((decimal5_2)L.registered_breadth)*12.0);
	self.watercraft_weight					:=	(string)(integer4)(((decimal6_2)L.registered_net_tons)*2204.62);
	self.watercraft_color_1_code			:=	'';
	self.watercraft_color_1_description		:=	'';
	self.watercraft_color_2_code			:=	'';
	self.watercraft_color_2_description		:=	'';
	self.watercraft_toilet_code				:=	'';
	self.watercraft_toilet_description		:=	'';
	self.watercraft_number_of_engines		:=	'';
	self.watercraft_hp_1					:=	L.Main_HP_Ahead;
	self.watercraft_hp_2					:=	L.Main_HP_Astern;
	self.watercraft_hp_3					:=	'';
	self.engine_number_1					:=	'';
	self.engine_number_2					:=	'';
	self.engine_number_3					:=	'';
	self.engine_make_1						:=	'';
	self.engine_make_2						:=	'';
	self.engine_make_3						:=	'';
	self.engine_model_1						:=	'';
	self.engine_model_2						:=	'';
	self.engine_model_3						:=	'';
	self.engine_year_1						:=	'';
	self.engine_year_2						:=	'';
	self.engine_year_3						:=	'';
	self.coast_guard_documented_flag		:=	'';
	self.coast_guard_number					:=	'';
	self.registration_date					:=	'';
	self.registration_expiration_date		:=	'';
	self.registration_status_code			:=	'';
	self.registration_status_description	:=	L.COD_Status;
	self.registration_status_date			:=	'';
	self.registration_renewal_date			:=	'';
	self.decal_number						:=	'';
	self.transaction_type_code				:=	'';
	self.transaction_type_description		:=	'';
	self.title_state						:=	'';
	self.title_status_code					:=	'';
	self.title_status_description			:=	'';
	self.title_number						:=	'';
	self.title_issue_date					:=	'';
	self.title_type_code					:=	'';
	self.title_type_description				:=	'';
	self.additional_owner_count				:=	'';
	self.lien_1_indicator					:=	'';
	self.lien_1_name						:=	'';
	self.lien_1_date						:=	'';
	self.lien_1_address_1					:=	'';
	self.lien_1_address_2					:=	'';
	self.lien_1_city						:=	'';
	self.lien_1_state						:=	'';
	self.lien_1_zip							:=	'';
	self.lien_2_indicator					:=	'';
	self.lien_2_name						:=	'';
	self.lien_2_date						:=	'';
	self.lien_2_address_1					:=	'';
	self.lien_2_address_2					:=	'';
	self.lien_2_city						:=	'';
	self.lien_2_state						:=	'';
	self.lien_2_zip							:=	'';
	self.state_purchased					:=	'';
	self.purchase_date						:=	'';
	self.dealer								:=	'';
	self.purchase_price						:=	'';
	self.new_used_flag						:=	'';
	self.watercraft_status_code				:=	'';
	self.watercraft_status_description		:=	'';
	self.history_flag						:=	'';
	self.coastguard_flag					:=	'Y';
  end
 ;

export Mapping_CG_As_Main := project(hull_clean_in,main_mapping_format(left));