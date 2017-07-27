import watercraft;


county_reg(string2 code)

:= case(code, 	
'1' => 'ALCONA',
'2' => 'ALGER',
'3' => 'ALLEGAN',
'4' => 'ALPENA',
'5' => 'ANTRIM',
'6' => 'ARENAC',
'7' => 'BARAGA',
'8' => 'BARRY',
'9' => 'BAY',
'10' => 'BENZIE',
'11' => 'BERRIEN',
'12' => 'BRANCH',
'13' => 'CALHOUN',
'14' => 'CASS',
'15' => 'CHARLEVOIX',
'16' => 'CHEBOYGAN',
'17' => 'CHIPPEWA',
'18' => 'CLARE',
'19' => 'CLINTON',
'20' => 'CRAWFORD',
'21' => 'DELTA',
'22' => 'DICKINSON',
'23' => 'EATON',
'24' => 'EMMET',
'25' => 'GENESSEE',
'26' => 'GLADWIN',
'27' => 'GOGEBIC',
'28' => 'GRAND TRAVERSE',
'29' => 'GRATIOT',
'30' => 'HILLSDALE',
'31' => 'HOUGHTON',
'32' => 'HURON',
'33' => 'INGHAM',
'34' => 'IONIA',
'35' => 'IOSCO',
'36' => 'ITON',
'37' => 'ISABELLA',
'38' => 'JACKSON',
'39' => 'KALAMAZOO',
'40' => 'KALKASKA',
'41' => 'KENT',
'42' => 'KEWEENAW',
'43' => 'LAKE',
'44' => 'LAPEER',
'45' => 'LEELANAU',
'46' => 'LENAWEE',
'47' => 'LIVINGSTON',
'48' => 'LUCE',
'49' => 'MACKINAC',
'50' => 'MACOMB',
'51' => 'MANISTEE',
'52' => 'MARQUETTE',
'53' => 'MASON',
'54' => 'MECOSTA',
'55' => 'MENOMINEE',
'56' => 'MIDLAND',
'57' => 'MISSAUKEE',
'58' => 'MONROE',
'59' => 'MONTCALM',
'60' => 'MONTGOMERY',
'61' => 'MUSKEGON',
'62' => 'NEWAYGO',
'63' => 'OAKLAND',
'64' => 'OCEANA',
'65' => 'OGEMAW',
'66' => 'ONTONAGON',
'67' => 'OSCEOLA',
'68' => 'OSCODA',
'69' => 'OTSEGO',
'70' => 'OTTAWA',
'71' => 'PRESQUE ISLE',
'72' => 'ROSCOMMON',
'73' => 'SAGINAW',
'74' => 'ST. CLAIR',
'75' => 'ST. JOSEPH',
'76' => 'SANILAC',
'77' => 'SCHOOLCRAFT',
'78' => 'SHIAWASSEE',
'79' => 'TUSCOLA',
'80' => 'VAN BUREN',
'81' => 'WASHTENAW',
'82' => 'WAYNE',
'83' => 'WEXFORD',
'84' => 'FOREIGN','' );   


trans_type_desc(string1 code)

:= case(code, 
'1' => 'New Registration',
'2' => 'Renewal',
'3' => 'Hand Written Renewal',
'4' => 'Renewal Transfer',
'5' => 'Transfer',
'6' => 'Flag Header Only',
'7' => 'Correction',
'8' => 'Duplicate',
'9' =>	'{no output}', '');

watercraft.Layout_Watercraft_Main_Base main_mapping_format(watercraft.file_MI_clean_in L) := transform


    self.watercraft_key						:=	if(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12, trim(L.HULL_ID,left, right),
	                                            if(L.HULL_ID = '', trim(L.Reg_num, left, right), (trim(L.HULL_ID, left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right)
												+ trim(L.NAME, left, right))[1..30]));
	self.sequence_key						:=	trim(L.reg_date, left, right);
	self.watercraft_id						:=	'';
	self.state_origin						:=	'MI';
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
	self.registration_expiration_date		:=	'';
	self.registration_status_code			:=	'';
	self.registration_status_description	:=	'';
	self.registration_status_date			:=	'';
	self.registration_renewal_date			:=	'';
	self.decal_number						:=	'';
	self.transaction_type_code				:=	L.TRANS_CODE;
	self.transaction_type_description		:=	trans_type_desc(L.TRANS_CODE);
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



export Mapping_MI_as_Main := project(watercraft.file_MI_clean_in, main_mapping_format(left));


	


	
