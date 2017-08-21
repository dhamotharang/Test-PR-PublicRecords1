import watercraft;


county_reg(string2 code)

:= case(code, 	
'01' => 'ADAMS',
'02' => 'ALLEN',
'03' => 'ASHLAND',
'04' => 'ASHTABULA',
'05' => 'ATHENS',
'06' => 'AUGLAIZE',
'07' => 'BELMONT',
'08' => 'BROWN',
'09' => 'BUTLER',
'10' => 'CARROLL',
'11' => 'CHAMPAIGN',
'12' => 'CLARK',
'13' => 'CLERMONT',
'14' => 'CLINTON',
'15' => 'COLUMBIANA',
'16' => 'COSHOCTON',
'17' => 'CRAWFORD',
'18' => 'CUYAHOGA',
'19' => 'DARKE',
'20' => 'DEFIANCE',
'21' => 'DELAWARE',
'22' => 'ERIE',
'23' => 'FAIRFIELD',
'24' => 'FAYETTE',
'25' => 'FRANKLIN',
'26' => 'FULTON',
'27' => 'GALLIA',
'28' => 'GEAUGA',
'29' => 'GREENE',
'30' => 'GUERNSEY',
'31' => 'HAMILTON',
'32' => 'HANCOCK',
'33' => 'HARDIN',
'34' => 'HARRISON',
'35' => 'HENRY',
'36' => 'HIGHLAND',
'37' => 'HOCKING',
'38' => 'HOLMES',
'39' => 'HURON',
'40' => 'JACKSON',
'41' => 'JEFFERSON',
'42' => 'KNOX',
'43' => 'LAKE',
'44' => 'LAWRENCE',
'45' => 'LICKING',
'46' => 'LOGAN',
'47' => 'LORAIN',
'48' => 'LUCAS',
'49' => 'MADISON',
'50' => 'MAHONING',
'51' => 'MARION',
'52' => 'MEDINA',
'53' => 'MEIGS',
'54' => 'MERCER',
'55' => 'MIAMI',
'56' => 'MONROE',
'57' => 'MONTGOMERY',
'58' => 'MORGAN',
'59' => 'MORROW',
'60' => 'MUSKINGUM',
'61' => 'NOBLE',
'62' => 'OTTAWA',
'63' => 'PAULDING',
'64' => 'PERRY',
'65' => 'PICKAWAY',
'66' => 'PIKE',
'67' => 'PORTAGE',
'68' => 'PREBLE',
'69' => 'PUTNAM',
'70' => 'RICHLAND',
'71' => 'ROSS',
'72' => 'SANDUSKY',
'73' => 'SCIOTO',
'74' => 'SENECA',
'75' => 'SHELBY',
'76' => 'STARK',
'77' => 'SUMMIT',
'78' => 'TRUMBULL',
'79' => 'TUSCARAWAS',
'80' => 'UNION',
'81' => 'VAN WERT',
'82' => 'VINTON',
'83' => 'WARREN',
'84' => 'WASHINGTON',
'85' => 'WAYNE',
'86' => 'WILLIAMS',
'87' => 'WOOD',
'88' => 'WYANDOT','');

Watercraft.Macro_Clean_Hull_ID(watercraft.file_OH_clean_in, watercraft.layout_OH_clean_in,hull_clean_in)

Layout_OH_clean_temp := record

watercraft.Layout_OH_clean_in;
watercraft.Layout_MIC;

boolean is_hull_id_in_MIC;
    	
end;

Layout_OH_clean_temp main_mapping_temp(hull_clean_in L, watercraft.file_MIC R)

:= transform

self := L;
self := R;
self.is_hull_id_in_MIC := if(trim(L.hull_id, left, right)[1..3] = R.MIC, true, false);

end;

Mapping_OH_as_Main_temp := join(hull_clean_in, watercraft.file_MIC, trim(left.hull_id, left, right)[1..3] = right.MIC,
main_mapping_temp(left, right), left outer, lookup);

watercraft.Layout_Watercraft_Main_Base main_mapping_format(Mapping_OH_as_Main_temp L) := transform


    self.watercraft_key						:=	if(trim(L.YEAR, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12 and L.is_hull_id_in_MIC, 
	                                            trim(L.HULL_ID, left, right), if(L.HULL_ID <> ''and trim(L.HULL_ID, left, right) <> 'UNKNOWN',
	                                            (trim(L.HULL_ID, left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30],
	                                            (trim(L.MAKE, left, right) + trim(L.YEAR, left, right) + (trim(L.FIRST_NAME, left, right) + trim(L.MID, left, right)
												+ trim(L.LAST_NAME, left, right))[1..30])));
	self.sequence_key						:=	L.REG_DATE;
	self.watercraft_id						:=	'';
	self.state_origin						:=	'OH';
	self.source_code						:=	'AW';
	self.st_registration					:=	TRIM(L.STATEABREV, left, right);
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
	self.registration_expiration_date		:=	L.EXPIRATION_DATE;
	self.registration_status_code			:=	'';
	self.registration_status_description	:=	'';
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
	self.coastguard_flag					:=	'';
    
  end;



export Mapping_OH_as_Main := project(Mapping_OH_as_Main_temp, main_mapping_format(left));


	
	
