import watercraft;


county_reg(string2 code) := case(code,

'1' => 'ANDROSCOGGIN',
'3' => 'AROOSTOOK',
'5' => 'CUMBERLAND',
'7' => 'FRANKLIN',
'9' => 'HANCOCK',
'11' => 'KENNEBEC',
'13' => 'KNOX',
'15' => 'LINCOLN',
'17' => 'OXFORD',
'19' => 'PENOBSCOT',
'21' => 'PISCATOAQUIS',
'23' => 'SAGADAHOC',
'25' => 'SOMERSET',
'27' => 'WALDO',
'29' => 'WASHINGTON',
'31' => 'YORK', '');

reg_status_desc(string2 code) := case(code,

'01' => 'Active',
'02' => 'Lost/Stolen',
'03' => 'Destroyed',
'04' => 'Transfer of Ownership',
'05' => 'Out of State',
'06' => 'Revoked',
'07' => 'Temporary Registration',
'08' => 'All Events Deleted','');

Watercraft.Macro_Clean_Hull_ID(watercraft.file_ME_clean_in_pre20060330, watercraft.Layout_ME_clean_in_pre20060330,hull_clean_in)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(hull_clean_in L) := transform


    self.watercraft_key				        :=	if(length(trim(L.HULL_ID, left, right)) = 12 and trim(L.year, left, right) >= '1972', trim(L.HULL_ID, left, right),
	                                            (trim(L.HULL_ID, left, right) + trim(L.MAKE,left, right) + trim(L.YEAR, left, right))[1..30]);                                          
	self.sequence_key				        :=	if(L.STATUS = '01', L.EXPIRATION_DATE, '30000000');
	self.watercraft_id						:=	'';
	self.state_origin						:=	'ME';
	self.source_code						:=	'AW';
	self.st_registration					:=	L.STATEABREV;
	self.county_registration				:=	county_reg(trim(L.county,left,right));
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
	self.watercraft_class_code				:=	'';
	self.watercraft_class_description		:=	'';
	self.watercraft_make_code				:=	L.MAKE_CODE;
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
	self.watercraft_hp_1					:=	L.HP;
	self.watercraft_hp_2					:=	'';
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
	self.registration_date					:=	L.REG_DATE;
	self.registration_expiration_date		:=	L.EXPIRATION_DATE;
	self.registration_status_code			:=	L.STATUS;
	self.registration_status_description	:=	REG_STATUS_DESC(L.STATUS);
	self.registration_status_date			:=	L.STATUS_DATE;
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
	self.coastguard_flag					:=	'';
  
  end;


export Mapping_ME_as_Main_pre20060330 := project(hull_clean_in, main_mapping_format(left));

		



	















































