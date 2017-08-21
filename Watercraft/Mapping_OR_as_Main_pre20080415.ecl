
import watercraft;


county_reg(string2 code) := case(code,

'01' => 'BAKER',
'02' => 'BENTON',
'03' => 'CLACKAMAS',
'04' => 'CLATSOP',
'05' => 'COLUMBIA',
'06' => 'COOS',
'07' => 'CROOK',
'08' => 'CURRY',
'09' => 'DESCHUTES',
'10' => 'DOUGLAS',
'11' => 'GILLIAM',
'12' => 'GRANT',
'13' => 'HARNEY',
'14' => 'HOOD RIVER',
'15' => 'JACKSON',
'16' => 'JEFFERSON',
'17' => 'JOSEPHINE',
'18' => 'KLAMATH',
'19' => 'LAKE',
'20' => 'LANE',
'21' => 'LINCOLN',
'22' => 'LINN',
'23' => 'MALHEUR',
'24' => 'MARION',
'25' => 'MORROW',
'26' => 'MULTNOMAH',
'27' => 'POLK',
'28' => 'SHERMAN',
'29' => 'TILLAMOOK',
'30' => 'UMATILLA',
'31' => 'UNION',
'32' => 'WALLOWA',
'33' => 'WASCO',
'34' => 'WASHINGTON',
'35' => 'WHEELER',
'36' => 'YAMHILL', '');

VEH_TYPE_DESC(string2 code) := case(code,

'1' => 'OPEN BOAT',
'2' => 'CABIN CRUISER',
'3' => 'CRUISING HOUSEBOAT',
'4' => 'OTHER',
'5' => 'PERSONAL WATERCRAFT', '');

Watercraft.Macro_Clean_Hull_ID(watercraft.file_OR_clean_in_pre20080415, watercraft.Layout_OR_clean_in_pre20080415,hull_clean_in)


Layout_OR_clean_temp1 := record

watercraft.Layout_OR_clean_in_pre20080415;
watercraft.Layout_OR_source_code_desc;

    	
end;

Layout_OR_clean_temp1 main_mapping_temp1(hull_clean_in L, watercraft.file_OR_source_code_desc R)

:= transform

self := L;
self := R;

end;

Mapping_OR_as_Main_temp1 := join(hull_clean_in, watercraft.file_OR_source_code_desc, left.code_lien1 = right.Nmbr_Id_Tbl,
main_mapping_temp1(left, right), left outer, lookup);

Layout_OR_clean_temp2 := record

Layout_OR_clean_temp1;
watercraft.Layout_MIC;

boolean is_hull_id_in_MIC;
    	
end;

Layout_OR_clean_temp2 main_mapping_temp2(Mapping_OR_as_Main_temp1 L, watercraft.file_MIC R)

:= transform

self := L;
self := R;
self.is_hull_id_in_MIC := if(trim(L.hull_id, left, right)[1..3] = R.MIC, true, false);

end;

Mapping_OR_as_Main_temp2 := join(Mapping_OR_as_Main_temp1, watercraft.file_MIC, trim(left.hull_id, left, right)[1..3] = right.MIC,
main_mapping_temp2(left, right), left outer, lookup);


watercraft.Layout_Watercraft_Main_Base main_mapping_format(Mapping_OR_as_Main_temp2 L) := transform


    self.watercraft_key				        :=	if(trim(L.YEAR, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12 and L.is_hull_id_in_MIC, 
	                                            trim(L.HULL_ID, left, right), if(trim(L.HULL_ID, left, right) <> 'VARIOUS'and trim(L.HULL_ID, left, right) <> 'UNKNOWN',
	                                            (trim(L.HULL_ID, left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30],
	                                            (trim(L.MAKE, left, right) + trim(L.YEAR, left, right) + trim(L.NAME, left, right))[1..30]));
	self.sequence_key				        :=	L.REG_DATE;
	self.watercraft_id						:=	'';
	self.state_origin						:=	'OR';
	self.source_code						:=	'AW';
	self.st_registration					:=	trim(L.STATEABREV, left, right);
	self.county_registration				:=	county_reg(L.COUNTY);
	self.registration_number				:=	trim(L.REG_NUM, left, right);
	self.hull_number						:=	L.hull_id;
	self.propulsion_code					:=	'';
	self.propulsion_description				:=	L.PROP;
	self.vehicle_type_Code					:=	L.CONSTRUCTION;
	self.vehicle_type_Description			:=	VEH_TYPE_DESC(L.CONSTRUCTION);
	self.fuel_code							:=	'';
	self.fuel_description					:=	L.FUEL;
	self.hull_type_code						:=	'';
	self.hull_type_description				:=	L.HULL;
	self.use_code							:=	'';
	self.use_description					:=	L.USE_1;
	self.watercraft_length					:=	L.TOTAL_INCH;
	self.model_year							:=	if(L.YEAR <> '0', L.YEAR, '');
	self.watercraft_name					:=	'';
	self.watercraft_class_code				:=	'';
	self.watercraft_class_description		:=	'';
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
	self.watercraft_hp_1					:=	'';
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
	self.registration_expiration_date		:=	L.REG_EXPIRE;
	self.registration_status_code			:=	'';
	self.registration_status_description	:=	'';
	self.registration_status_date			:=	'';
	self.registration_renewal_date			:=	'';
	self.decal_number						:=	L.DECAL;
	self.transaction_type_code				:=	'';
	self.transaction_type_description		:=	'';
	self.title_state						:=	'';
	self.title_status_code					:=	'';
	self.title_status_description			:=	'';
	self.title_number						:=	trim(L.NUM_TITLE_PREF, left, right) + trim(L.TITLE_NUM, left, right);
	self.title_issue_date					:=	L.CURRENT_TITLE_DATE;
	self.title_type_code					:=	'';
	self.title_type_description				:=	'';
	self.additional_owner_count				:=	'';
	self.lien_1_indicator					:=	if(L.CODE_LIEN1 <> '', 'Y','');
	self.lien_1_name						:=	if(L.Name_Sec <> '', L.Name_Sec, L.Name_Frst);
	self.lien_1_date						:=	'';
	self.lien_1_address_1					:=	L.Addr_Str;
	self.lien_1_address_2					:=	'';
	self.lien_1_city						:=	L.Addr_City;
	self.lien_1_state						:=	L.Code_State;
	self.lien_1_zip							:=	L.Code_Zip;
	self.lien_2_indicator					:=	if(L.CODE_LIEN2 <> '', 'Y', '');
	self.lien_2_name						:=	'';
	self.lien_2_date						:=	'';
	self.lien_2_address_1					:=	'';
	self.lien_2_address_2					:=	'';
	self.lien_2_city						:=	'';
	self.lien_2_state						:=	'';
	self.lien_2_zip							:=	'';
	self.state_purchased					:=	'';
	self.purchase_date						:=	L.DATE_PURCH;
	self.dealer								:=	'';
	self.purchase_price						:=	'';
	self.new_used_flag						:=	'';
	self.watercraft_status_code				:=	'';
	self.watercraft_status_description		:=	'';
	self.history_flag						:=	'';
	self.coastguard_flag					:=	'';
  
  end;



export Mapping_OR_as_Main_pre20080415 := project(Mapping_OR_as_Main_temp2, main_mapping_format(left));


	





