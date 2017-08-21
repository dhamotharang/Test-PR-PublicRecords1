//Watercraft_Main_Base - Vessels

import lib_stringlib, watercraft;

Watercraft.Layout_Watercraft_Main_Base main_mapping_format(ak_comm_fish_vessels.layout_vessels_clean L) :=
 
    transform
	
	self.watercraft_key					:= trim(L.VADGF_VESSEL_NUMBER)+trim(L.YEAR_BUILT)+'FV';
	self.sequence_key					:= '';
	self.watercraft_id					:= '';
	self.state_origin					:= 'FV';
	self.source_code					:= 'FV';
	self.st_registration				:= trim(L.HOMEPORT_STATE,left,right);
	self.county_registration			:= '';
	self.registration_number			:= '';
	self.hull_number					:= '';
	self.propulsion_code				:= '';
	self.propulsion_description			:= '';
	self.vehicle_type_code				:= '';
	self.vehicle_type_description		:= if((integer)l.fuel_cap_gal<>0,'FUEL CAP: '+(string)(integer)l.fuel_cap_gal,'');
	self.fuel_code                      := l.engine_type;
	self.fuel_description    			:= if(l.engine_type='D','DIESEL',if(l.engine_type='G','GAS',''));
	self.hull_type_code					:= l.hull_type;
	self.hull_type_description			:= case(l.hull_type,
	                                        'A' => 'ALUMINUM',
											'F' => 'FIBER-PLASTIC',
											'K' => 'CONCRETE',
											'R' => 'RUBBER',
											'S' => 'IRON-STEEL ALLOY',
											'W' => 'WOOD',
											'');
	self.use_code						:= '';
	self.use_description				:= '';
	self.model_year						:= trim(L.YEAR_BUILT,left,right);
	self.watercraft_name				:= trim(L.VESSEL_NAME,left,right);
	self.watercraft_class_code			:= '';
	self.watercraft_class_description	:= '';
	self.watercraft_make_code			:= '';
	self.watercraft_make_description	:= '';
	self.watercraft_model_code			:= '';
	self.watercraft_model_description	:= '';
	self.watercraft_length				:= (string)(integer4)(((decimal5_2)L.LENGTH_FEET)*12.0); 
	self.watercraft_width				:= '';
	self.watercraft_weight				:= (string)(integer4)(((decimal6_2)L.NET_TONS)*2204.62);
	self.watercraft_color_1_code		:= '';
	self.watercraft_color_1_description	:= '';
	self.watercraft_color_2_code		:= '';
	self.watercraft_color_2_description	:= '';
	self.watercraft_toilet_code			:= '';
	self.watercraft_toilet_description	:= '';
	self.watercraft_number_of_engines	:= '';
	self.watercraft_hp_1				:= '';
	self.watercraft_hp_2				:= '';
	self.watercraft_hp_3				:= '';
	self.engine_number_1				:= '';
	self.engine_number_2				:= '';
	self.engine_number_3				:= '';
	self.engine_make_1					:= '';
	self.engine_make_2					:= '';
	self.engine_make_3					:= '';
	self.engine_model_1					:= '';
	self.engine_model_2					:= '';
	self.engine_model_3					:= '';
	self.engine_year_1					:= '';
	self.engine_year_2					:= '';
	self.engine_year_3					:= '';
	self.coast_guard_documented_flag	:= '';
	self.coast_guard_number				:= if(L.CG_NUMBER <> '', L.CG_NUMBER, '');
	self.registration_date				:= '';
	self.registration_expiration_date	:= '';
	self.registration_status_code		:= '';
	self.registration_status_description:= '';
	self.registration_status_date		:= '';
	self.registration_renewal_date		:= '';
	self.decal_number					:= '';
	self.transaction_type_code			:= '';
	self.transaction_type_description	:= '';
	self.title_state					:= '';
	self.title_status_code				:= '';
	self.title_status_description		:= '';
	self.title_number					:= '';
	self.title_issue_date				:= '';
	self.title_type_code				:= '';
	self.title_type_description			:= '';
	self.additional_owner_count			:= '';
	self.lien_1_indicator				:= '';
	self.lien_1_name					:= '';
	self.lien_1_date					:= '';
	self.lien_1_address_1				:= '';
	self.lien_1_address_2				:= '';
	self.lien_1_city					:= '';
	self.lien_1_state					:= '';
	self.lien_1_zip						:= '';
	self.lien_2_indicator				:= '';
	self.lien_2_name					:= '';
	self.lien_2_date					:= '';
	self.lien_2_address_1				:= '';
	self.lien_2_address_2				:= '';
	self.lien_2_city					:= '';
	self.lien_2_state					:= '';
	self.lien_2_zip						:= '';
	self.state_purchased				:= '';
	self.purchase_date					:= '';
	self.dealer							:= '';
	self.purchase_price					:= '';
	self.new_used_flag					:= '';
	self.watercraft_status_code			:= '';
	self.watercraft_status_description	:= '';
	self.history_flag					:= '';
	self.coastguard_flag                := '';//Flag is used to denote if record exists in CoastGuard file
	//self.coastguard_flag				:= if(L.CG_NUMBER <> '','Y','');

  end; 

export Mapping_Watercraft_Main_Base_AK_Comm_Fishing_Vessels := project(ak_comm_fish_vessels.file_vessels_clean, main_mapping_format(left));