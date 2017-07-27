import watercraft;


hull_type_desc(string1 code)
 := case(code,
'1' => 'ALUMINUM',
'2' => 'FIBERGLASS',
'3' => 'WOOD',
'4' => 'OTHER',
'5' => 'STEEL',
'6' => 'PLASTIC', '' );
					
veh_type_Desc(string1 code)
:= case(code,				
					
'1' => 'OPEN',
'2' => 'CABIN',
'3' => 'HOUSEBOAT',
'4' => 'OTHER',
'5' => 'OPEN',
'6' => 'SAIL', '');

use_desc(string1 code)

:= case(code,

'1' => 'PLEASURE',
'2' => 'COMMERCIAL (OTHER)',
'3' => 'LIVERY (RENT-LEASE)',
'4' => 'PATROL',
'5' => 'DEMONSTRATION',
'6' => 'COMMERCIAL PASSENGER',
'7' => 'FISHING',
'8' => 'OTHER', '');

prop_desc(string1 code)

:= case(code,


'1' => 'INBOARD',
'2' => 'OUTBOARD',
'3' => 'STERN',
'4' => 'AIR BOAT',
'5' => 'SELF PROPELLED',
'6' => 'JET',
'7' => 'SAIL',
'8' => 'SAIL',
'9' => 'UNDEFINED', '');


watercraft.Layout_Watercraft_Main_Base main_mapping_format(watercraft.file_NV_clean_in L) := transform


    self.watercraft_key				        :=	if(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12, trim(L.HULL_ID,left, right),
	                                            trim(L.Reg_num, left, right));                                 
	self.sequence_key				        :=	trim(L.REG_DATE, left, right);
	self.watercraft_id						:=	'';
	self.state_origin						:=	'NV';
	self.source_code						:=	'AW';
	self.st_registration					:=	trim(L.STATEABREV, left, right);
	self.county_registration				:=	trim(L.County_of_Taxation,left,right);
	self.registration_number				:=	trim(L.REG_NUM, left, right);
	self.hull_number						:=	L.hull_id;
	self.propulsion_code					:=	'';
	self.propulsion_description				:=	L.PROP;
	self.vehicle_type_Code					:=	'';
	self.vehicle_type_Description			:=	L.VEH_TYPE;
	self.fuel_code							:=	'';
	self.fuel_description					:=	L.FUEL;
	self.hull_type_code						:=	'';
	self.hull_type_description				:=	L.HULL;
	self.use_code							:=	'';
	self.use_description					:=	L.USE_1;
	self.watercraft_length					:=	L.TOTAL_INCH;
	self.model_year							:=	L.YEAR;
	self.watercraft_name					:=	'';
	self.watercraft_class_code				:=	L.Coast_Guard_Code;
	self.watercraft_class_description		:=	L.Coast_Guard_Code_Description;
	self.watercraft_make_code				:=	'';
	self.watercraft_make_description		:=	L.MAKE;
	self.watercraft_model_code				:=	'';
	self.watercraft_model_description		:=	'';
	self.watercraft_width					:=	'';
	self.watercraft_weight					:=	'';
	self.watercraft_color_1_code			:=	'';
	self.watercraft_color_1_description		:=	'';
	self.watercraft_color_2_code			:=	'';
	self.watercraft_color_2_description		:=	'';
	self.watercraft_toilet_code				:=	'';
	self.watercraft_toilet_description		:=	'';
	self.watercraft_number_of_engines		:=	'';
	self.watercraft_hp_1					:=	L.Horsepower_of_Motor_2;
	self.watercraft_hp_2					:=	L.Horsepower_of_Motor_3;
	self.watercraft_hp_3					:=	L.Horsepower_of_Motor_4;
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
	self.registration_date					:=	L.REG_DATE;
	self.registration_expiration_date		:=	'';
	self.registration_status_code			:=	'';
	self.registration_status_description	:=	'';
	self.registration_status_date			:=	'';
	self.registration_renewal_date			:=	'';
	self.decal_number						:=	'';
	self.transaction_type_code				:=	'';
	self.transaction_type_description		:=	'';
	self.title_state						:=	'';
	self.title_status_code					:=	L.Status_Code;
	self.title_status_description			:=	L.Status_Description;
	self.title_number						:=	L.Title_Number;
	self.title_issue_date					:=	L.Title_Issue_Date;
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
	self.coastguard_flag					:=	'';
    
  end;


export Mapping_NV_as_Main := project(watercraft.file_NV_clean_in, main_mapping_format(left));


	
	
