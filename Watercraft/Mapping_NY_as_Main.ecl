import watercraft;


county_reg(string4 code)

:= case(code, 	
'ALBA' => 'ALBANY',
'ALLE' => 'ALLEGANY',
'BRON' => 'BRONX',
'BROO' => 'BROOME',
'CATT' => 'CATTARAUGUS',
'CAYU' => 'CAYUGA',
'CHAU' => 'CHAUTAUQUA',
'CHEM' => 'CHEMUNG',
'CHEN' => 'CHENANGO',
'COLU' => 'COLUMBIA',
'CORT' => 'CORTLAND',
'DELA' => 'DELAWARE',
'DUTC' => 'DUTCHESS',
'ERIE' => 'ERIE',
'ESSE' => 'ESSEX',
'FRAN' => 'FRANKLIN',
'FULT' => 'FULTON',
'GENE' => 'GENESEE',
'GREE' => 'GREENE',
'HAMI' => 'HAMILTON',
'HERK' => 'HERKIMER',
'JEFF' => 'JEFFERSON',
'KING' => 'KINGS',
'LEWI' => 'LEWIS',
'LIVI' => 'LIVINGSTON',
'MADI' => 'MADISON',
'MONR' => 'MONROE',
'MONT' => 'MONTGOMERY',
'NASS' => 'NASSAU',
'NEWY' => 'NEW YORK',
'NIAG' => 'NIAGARA',
'ONEI' => 'ONEIDA',
'ONON' => 'ONONDAGA',
'ONTA' => 'ONTARIO',
'ORAN' => 'ORANGE',
'ORLE' => 'ORLEANS',
'OSWE' => 'OSWEGO',
'OTSE' => 'OTSEGO',
'QUEE' => 'QUEENS',
'RENS' => 'RENSSELSER',
'RICH' => 'RICHMOND',
'ROCK' => 'ROCKLAND',
'SARA' => 'SARATOGA',
'SCHE' => 'SCHENECTADY',
'SENE' => 'SENECA',
'STEU' => 'STEUBEN',
'STLA' => 'ST LAWRENCE',
'SUFF' => 'SUFFOLK',
'SULL' => 'SULLIVAN',
'TIOG' => 'TIOGA',
'TOMP' => 'TOMPKINS',
'ULST' => 'ULSTER',
'WARR' => 'WARREN',
'WASH' => 'WASHINGTON',
'WAYN' => 'WAYNE',
'WEST' => 'WESTCHESTER',
'WYOM' => 'WYOMING',
'YATE' => 'YATES','');

tran_type_desc(string2 code)

:= case(code, 
'R' => 'REPOSSESSED',
'S' => 'SUSPENDED',
'T' => 'TITLE SURRENDERED','');


file_NY_filter := sort(dedup(watercraft.file_NY_clean_in, HULL_ID, MAKE,YEAR, NAME, REG_DATE), HULL_ID, MAKE,YEAR, NAME, REG_DATE);  

Watercraft.Macro_Clean_Hull_ID(file_NY_filter, watercraft.layout_NY_clean_in,hull_clean_in)

watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in,watercraft.layout_NY_clean_in,wDatasetwithflag)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(wDatasetwithflag L) := transform


    self.watercraft_key				        :=	if(trim(L.YEAR, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12 and L.is_hull_id_in_MIC, 
	                                            trim(L.HULL_ID, left, right), if(L.HULL_ID <> '' and trim(L.HULL_ID, left, right) <> 'UNKN'and 
												trim(L.HULL_ID, left, right) <> 'UNKNOWN' and trim(L.YEAR, left, right) <> '19',
	                                            (trim(L.HULL_ID, left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30],
	                                            (trim(L.MAKE, left, right) + trim(L.YEAR, left, right) + trim(L.NAME, left, right))[1..30]));
	self.sequence_key				        :=	L.REG_DATE;
	self.watercraft_id						:=	'';
	self.state_origin						:=	'NY';
	self.source_code						:=	'AW';
	self.st_registration					:=	TRIM(L.STATEABREV, left, right);
	self.county_registration				:=	county_reg(L.county);
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
	self.registration_expiration_date		:=	L.REG_EXPIRE;
	self.registration_status_code			:=	'';
	self.registration_status_description	:=	'';
	self.registration_status_date			:=	'';
	self.registration_renewal_date			:=	'';
	self.decal_number						:=	'';
	self.transaction_type_code				:=	L.TRANS_TYPE;
	self.transaction_type_description		:=	tran_type_desc(L.TRANS_TYPE);
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



export Mapping_NY_as_Main := project(wDatasetwithflag, main_mapping_format(left));

	

