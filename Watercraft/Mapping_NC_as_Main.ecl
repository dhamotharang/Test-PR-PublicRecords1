import watercraft;


county_reg(string5 code)

:= case(code, 	
'Alama' => 'ALAMANCE',
'Alexa' => 'ALEXANDER',
'Alleg' => 'ALLEGHANY',
'Anson' => 'ANSON',
'Ashe' => 'ASHE',
'Avery' => 'AVERY',
'Beauf' => 'BEAUFORT',
'Berti' => 'BERTIE',
'Blade' => 'BLADEN',
'Bruns' => 'BRUNSWICK',
'Bunco' => 'BUNCOMBE',
'Burke' => 'BURKE',
'Cabar' => 'CABARRUS',
'Caldw' => 'CALDWELL',
'Camde' => 'CAMDEN',
'Carte' => 'CARTERET',
'Caswe' => 'CASWELL',
'Cataw' => 'CATAWBA',
'Chath' => 'CHATHAM',
'Chero' => 'CHEROKEE',
'Chowa' => 'CHOWAN',
'Clay' => 'CLAY',
'Cleve' => 'CLEVELAND',
'Colum' => 'COLUMBUS',
'Crave' => 'CRAVEN',
'Cumbe' => 'CUMBERLAND',
'Curri' => 'CURRITUCK',
'Dare' => 'DARE',
'David' => 'DAVIDSON',
'Davie' => 'DAVIE',
'Dupli' => 'DUPLIN',
'Durha' => 'DURHAM',
'Edgec' => 'EDGECOMBE',
'Forsy' => 'FORSYTH',
'Frank' => 'FRANKLIN',
'Gasto' => 'GASTON',
'Gates' => 'GATES',
'Graha' => 'GRAHAM',
'Granv' => 'GRANVILLE',
'Green' => 'GREENE',
'Guilf' => 'GUILFORD',
'Halof' => 'HALOFAX',
'Harne' => 'HARNETT',
'Haywo' => 'HAYWOOD',
'Hende' => 'HENDERSON',
'Hertf' => 'HERTFORD',
'Hoke' => 'HOKE',
'Hyde' => 'HYDE',
'Irede' => 'IREDELL',
'Jacks' => 'JACKSON',
'Johns' => 'JOHNSTON',
'Jones' => 'JONES',
'Lee' => 'LEE',
'Lenio' => 'LENIOR',
'Linco' => 'LINCOLN',
'Macon' => 'MACON',
'Madis' => 'MADISON',
'Marti' => 'MARTIN',
'McDow' => 'MCDOWELL',
'Meckl' => 'MECKLENBURG',
'Mitch' => 'MITCHELL',
'Montg' => 'MONTGOMERY',
'Moore' => 'MOORE',
'Nash' => 'NASH',
'New H' => 'NEW HANOVER',
'North' => 'NORTHAMPTON',
'Onslo' => 'ONSLOW',
'Orang' => 'ORANGE',
'Pamli' => 'PAMLICO',
'Pasqu' => 'PASQUOTANK',
'Pende' => 'PENDER',
'Perqu' => 'PERQUIMANS',
'Perso' => 'PERSON',
'Pitt' => 'PITT',
'Polk' => 'POLK',
'Rando' => 'RANDOLPH',
'Richm' => 'RICHMOND',
'Robes' => 'ROBESON',
'Rocki' => 'ROCKINGHAM',
'Rowan' => 'ROWAN',
'Ruthe' => 'RUTHERFORD',
'Samps' => 'SAMPSON',
'Scotl' => 'SCOTLAND',
'Stanl' => 'STANLY',
'Stoke' => 'STOKES',
'Surry' => 'SURRY',
'Swain' => 'SWAIN',
'Trans' => 'TRANSYLVANIA',
'Tyrre' => 'TYRRELL',
'Union' => 'UNION',
'Vance' => 'VANCE',
'Wake' => 'WAKE',
'Warre' => 'WARREN',
'Washi' => 'WASHINGTON',
'Watau' => 'WATAUGA',
'Wayne' => 'WAYNE',
'Wilke' => 'WILKES',
'Wilso' => 'WILSON',
'Yadki' => 'YADKIN',
'Yance' => 'YANCEY', ''); 


reg_status_desc(string1 code)

:= case(code,

'A' => 'ACTIVE',
'1' => 'INACTIVE', '');

title_status_desc(string1 code)

:= case(code,

'A' => 'ACTIVE',
'I' => 'INACTIVE',
'1' => 'ACTIVE', 
'D' => 'INACTIVE',
'0' => 'INACTIVE', '');


watercraft.Layout_Watercraft_Main_Base main_mapping_format(watercraft.file_NC_clean_in L) := transform


    self.watercraft_key				        :=	if(length(trim(L.HULL_ID, left, right)) = 12 and trim(L.year, left, right) >= '1972', trim(L.HULL_ID, left, right),
	                                            (trim(L.HULL_ID, left, right) + trim(L.MAKE,left, right) + trim(L.YEAR, left, right))[1..30]);                                          
	self.sequence_key				        :=	trim(L.RENEWNUM, left, right);
	self.watercraft_id						:=	'';
	self.state_origin						:=	'NC';
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
	self.use_description					:=	trim(L.USE_1,left,right) + ',' + trim(L.SPECIALREG,left,right);
	self.watercraft_length					:=	L.TOTAL_INCH;
	self.model_year							:=	L.YEAR;
	self.watercraft_name					:=	'';
	self.watercraft_class_code				:=	'';
	self.watercraft_class_description		:=	'';
	self.watercraft_make_code				:=	'';
	self.watercraft_make_description		:=	L.MAKE;
	self.watercraft_model_code				:=	'';
	self.watercraft_model_description		:=	L.MODEL;
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
	self.registration_expiration_date		:=	L.EXPIRE_DATE;
	self.registration_status_code			:=	L.STATUS;
	self.registration_status_description	:=	reg_status_desc(L.STATUS);
	self.registration_status_date			:=	'';
	self.registration_renewal_date			:=	'';
	self.decal_number						:=	'';
	self.transaction_type_code				:=	'';
	self.transaction_type_description		:=	'';
	self.title_state						:=	'';
	self.title_status_code					:=	L.TITLESTATUS;
	self.title_status_description			:=	title_status_desc(L.TITLESTATUS);
	self.title_number						:=	L.TITLENUM;
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



export Mapping_NC_as_Main := project(watercraft.file_NC_clean_in, main_mapping_format(left));


	

	













	



