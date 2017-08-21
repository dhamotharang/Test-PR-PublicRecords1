import Watercraft, Lib_StringLib;

string fColorDescFromCode(string pCode)
 :=
  case(trim(pCode),
	   '   ' => '',
	   'AQU' => 'AQUA',
	   'BGE' => 'BEIGE',
	   'BLK' => 'BLACK',
	   'BLU' => 'BLUE',
	   'BRO' => 'BROWN',
	   'BRZ' => 'BRONZE',
	   'CAM' => 'CAMOUFLAGE',
	   'COM' => 'CHROME',
	   'CPR' => 'COPPER',
	   'CRM' => 'IVORY',
	   'DBL' => 'DARK BLUE',
	   'DGR' => 'DARK GREEN',
	   'GLD' => 'GOLD',
	   'GRN' => 'GREEN',
	   'GRY' => 'GRAY',
	   'LAV' => 'LAVENDER',
	   'LBL' => 'LIGHT BLUE',
	   'LGR' => 'LIGHT GREEN',
	   'MAR' => 'MAROON',
	   'MUL' => 'MULTI-COLORED',
	   'MVE' => 'MAUVE',
	   'ONG' => 'ORANGE',
	   'PLE' => 'PURPLE',
	   'PNK' => 'PINK',
	   'RED' => 'RED',
	   'SCN' => '',
	   'SIL' => 'SILVER',
	   'TAN' => 'TAN',
	   'TEA' => 'TEAL',
	   'TPE' => 'TAUPE',
	   'TRQ' => 'TURQUOISE',
	   'WHI' => 'WHITE',
	   'YEL' => 'YELLOW',
	   '681' => '',
	   '683' => '',
	   '688' => '',
	   ''
	  );

string fFeetFromInches(string pValue)
 :=
  if((integer)pValue <> 0,
	 (string)(integer)((integer)pValue / 12),
	 ''
	)
 ;

Watercraft.Layout_Watercraft_Main_Base tVehicleToMain(Watercraft_UMF.File_In_Watercraft pInput)
 :=
  transform
	self.watercraft_key						:=	Watercraft_UMF.fConstruct_Watercraft_Key(pInput.GROUP_KEY,pInput.boat_HULL_ID);
	self.sequence_key						:=	Watercraft_UMF.fConstruct_Sequence_Key(pInput.GROUP_KEY);
	self.watercraft_id						:=	pInput.boat_VESSEL_ID;
	self.state_origin						:=	pInput.STATE_ORIGIN;
	self.source_code						:=	'AW';
	self.st_registration					:=	pInput.registration_AUTHORITY;
	self.county_registration				:=	'';
	self.registration_number				:=	pInput.registration_NUMBER;
	self.hull_number						:=	pInput.boat_HULL_ID;
	self.propulsion_code					:=	'';
	self.propulsion_description				:=	if(pInput.vehicle_PROP_TYPE<>'',
												   pInput.vehicle_PROP_TYPE,
												   pInput.boat_PROPULSION
												  );
	self.vehicle_type_Code					:=	'';
	self.vehicle_type_Description			:=	'';
	self.fuel_code							:=	'';
	self.fuel_description					:=	pInput.boat_FUEL;
	self.hull_type_code						:=	'';
	self.hull_type_description				:=	pInput.boat_HULL_TYPE;
	self.use_code							:=	'';
	self.use_description					:=	pInput.boat_USE;
	self.watercraft_length					:=	pInput.vehicle_LENGTH;
	self.model_year							:=	pInput.vehicle_YEAR;
	self.watercraft_name					:=	pInput.boat_VESSEL_NAME;
	self.watercraft_class_code				:=	'';
	self.watercraft_class_description		:=	'';
	self.watercraft_make_code				:=	'';
	self.watercraft_make_description		:=	pInput.vehicle_MAKE;
	self.watercraft_model_code				:=	'';
	self.watercraft_model_description		:=	pInput.vehicle_MODEL;
	self.watercraft_width					:=	pInput.boat_WIDTH;
	self.watercraft_weight					:=	if(pInput.vehicle_WEIGHT<>'',
												   pInput.vehicle_Weight,
												   if(pInput.boat_REG_NET_TONS<>'',
													  (string)(((integer)pInput.boat_REG_NET_TONS) * 2000),
													  ''
													 )
												  );
	self.watercraft_color_1_code			:=	pInput.vehicle_COLOR;
	self.watercraft_color_1_description		:=	fColorDescFromCode(pInput.vehicle_COLOR);
	self.watercraft_color_2_code			:=	pInput.vehicle_SECONDARY_COLOR;
	self.watercraft_color_2_description		:=	fColorDescFromCode(pInput.vehicle_SECONDARY_COLOR);
	self.watercraft_toilet_code				:=	'';
	self.watercraft_toilet_description		:=	'';
	self.watercraft_number_of_engines		:=	''; // pInput.*count of engines rolled up*;
	self.watercraft_hp_1					:=	pInput.engine_ENG_HP;
	self.watercraft_hp_2					:=	'';	//pInput.engine_ENG_HP;
	self.watercraft_hp_3					:=	'';	//pInput.engine_ENG_HP;
	self.engine_number_1					:=	pInput.engine_ENGINE_NBR;
	self.engine_number_2					:=	'';	//pInput.engine_ENGINE_NBR;
	self.engine_number_3					:=	'';	//pInput.engine_ENGINE_NBR;
	self.engine_make_1						:=	pInput.engine_ENG_MAKE;
	self.engine_make_2						:=	'';	//pInput.engine_ENG_MAKE;
	self.engine_make_3						:=	'';	//pInput.engine_ENG_MAKE;
	self.engine_model_1						:=	pInput.engine_ENG_MODEL;
	self.engine_model_2						:=	'';	//pInput.engine_ENG_MODEL;
	self.engine_model_3						:=	'';	//pInput.engine_ENG_MODEL;
	self.engine_year_1						:=	pInput.engine_ENG_YEAR;
	self.engine_year_2						:=	'';	//pInput.engine_ENG_YEAR;
	self.engine_year_3						:=	'';	//pInput.engine_ENG_YEAR;
	self.coast_guard_documented_flag		:=	if(pInput.boat_CGID<>'',
												   'Y',
												   ' '
												  );
	self.coast_guard_number					:=	pInput.boat_CGID;
	self.registration_date					:=	pInput.registration_ISSUE_DATE;
	self.registration_expiration_date		:=	pInput.registration_EXPIRE_DATE;
	self.registration_status_code			:=	'';
	self.registration_status_description	:=	pInput.registration_STATUS;
	self.registration_status_date			:=	pInput.registration_STATUS_DATE;
	self.registration_renewal_date			:=	'';
	self.decal_number						:=	pInput.registration_DECAL_NUMBER;
	self.transaction_type_code				:=	pInput.title_TRANSFER_TYPE;
	self.transaction_type_description		:=	pInput.title_TRANSFER_TYPE;
	self.title_state						:=	pInput.title_AUTHORITY;
	self.title_status_code					:=	pInput.title_STATUS;
	self.title_status_description			:=	pInput.title_STATUS;
	self.title_number						:=	pInput.title_NUMBER;
	self.title_issue_date					:=	pInput.title_ISSUE_DATE;
	self.title_type_code					:=	'';
	self.title_type_description				:=	pInput.title_TYPE2;
	self.additional_owner_count				:=	'';
	self.lien_1_indicator					:=	'';	//pInput.*if lien_1_xxx filled*;
	self.lien_1_name						:=	'';	//pInput.*from business_info records not yet included*;
	self.lien_1_date						:=	pInput.lien_LIEN_EFFECTIVE_DATE;
	self.lien_1_address_1					:=	'';	//pInput.*from business_info records not yet included*;
	self.lien_1_address_2					:=	'';	//pInput.*from business_info records not yet included*;
	self.lien_1_city						:=	'';	//pInput.*from business_info records not yet included*;
	self.lien_1_state						:=	'';	//pInput.*from business_info records not yet included*;
	self.lien_1_zip							:=	'';	//pInput.*from business_info records not yet included*;
	self.lien_2_indicator					:=	'';	//pInput.*if lien_2_xxx filled*;
	self.lien_2_name						:=	'';	//pInput.*from business_info records not yet included*;
	self.lien_2_date						:=	pInput.lien_LIEN_EFFECTIVE_DATE;
	self.lien_2_address_1					:=	'';	//pInput.*from business_info records not yet included*;
	self.lien_2_address_2					:=	'';	//pInput.*from business_info records not yet included*;
	self.lien_2_city						:=	'';	//pInput.*from business_info records not yet included*;
	self.lien_2_state						:=	'';	//pInput.*from business_info records not yet included*;
	self.lien_2_zip							:=	'';	//pInput.*from business_info records not yet included*;
	self.state_purchased					:=	'';
	self.purchase_date						:=	pInput.boat_PUR_DATE;
	self.dealer								:=	'';
	self.purchase_price						:=	pInput.boat_PUR_PRICE;
	self.new_used_flag						:=	'';
	self.watercraft_status_code				:=	'';
	self.watercraft_status_description		:=	'';
	self.history_flag						:=	'';
	self.coastguard_flag					:=	if(pInput.boat_CGID<>'' 
												or pInput.boat_IMO_NBR<>''
												or pInput.boat_ITC_GROSS_TONS<>'' 
												or pInput.boat_ITC_NET_TONS<>'' 
												or pInput.callsign_CALLSIGN<>'',
												   'Y',
												   ''
												  );
  end
 ;

dWatercraftDistributed	:= distribute(Watercraft_UMF.File_In_Watercraft,hash(STATE_ORIGIN,GROUP_KEY));
dWatercraftSorted		:= sort(dWatercraftDistributed,STATE_ORIGIN,GROUP_KEY,local);
dWatercraftAsCommon		:= project(dWatercraftSorted,tVehicleToMain(left));

Watercraft.Layout_Watercraft_Main_Base tRollupEngineAndLienholder(dWatercraftAsCommon pLeft,dWatercraftAsCommon pRight)
 :=
  transform
	integer1	lEngineFilled_1				:=	if(pLeft.watercraft_hp_1 + pLeft.engine_number_1 + pLeft.engine_make_1 + pLeft.engine_model_1 + pLeft.engine_year_1 <>'',
												   1,
												   0
												  );
	integer1	lEngineFilled_2				:=	if(pLeft.watercraft_hp_2 + pLeft.engine_number_2 + pLeft.engine_make_2 + pLeft.engine_model_2 + pLeft.engine_year_2 <>'',
												   1,
												   0
												  );
	integer1	lEngineFilled_3				:=	if(pLeft.watercraft_hp_3 + pLeft.engine_number_3 + pLeft.engine_make_3 + pLeft.engine_model_3 + pLeft.engine_year_3 <>'',
												   1,
												   0
												  );
	integer1	lEngineAvailable			:=	if(pRight.watercraft_hp_1 + pRight.engine_number_1 + pRight.engine_make_1 + pRIght.engine_model_1 + pRIght.engine_year_1 <>'',
												   1,
												   0
												  );
	self.watercraft_hp_1					:=	if(lEngineFilled_1 <> 0,
												   pLeft.watercraft_hp_1,
												   pRight.watercraft_hp_1
												  );
	self.watercraft_hp_2					:=	if(lEngineFilled_2 <> 0,
												   pLeft.watercraft_hp_2,
												   pRight.watercraft_hp_2
												  );
	self.watercraft_hp_3					:=	if(lEngineFilled_3 <> 0,
												   pLeft.watercraft_hp_3,
												   pRight.watercraft_hp_3
												  );
	self.engine_number_1					:=	if(lEngineFilled_1 <> 0,
												   pLeft.engine_number_1,
												   pRight.engine_number_1
												  );
	self.engine_number_2					:=	if(lEngineFilled_2 <> 0,
												   pLeft.engine_number_2,
												   pRight.engine_number_2
												  );
	self.engine_number_3					:=	if(lEngineFilled_3 <> 0,
												   pLeft.engine_number_3,
												   pRight.engine_number_3
												  );
	self.engine_make_1						:=	if(lEngineFilled_1 <> 0,
												   pLeft.engine_make_1,
												   pRight.engine_make_1
												  );
	self.engine_make_2						:=	if(lEngineFilled_2 <> 0,
												   pLeft.engine_make_2,
												   pRight.engine_make_2
												  );
	self.engine_make_3						:=	if(lEngineFilled_3 <> 0,
												   pLeft.engine_make_3,
												   pRight.engine_make_3
												  );
	self.engine_model_1						:=	if(lEngineFilled_1 <> 0,
												   pLeft.engine_model_1,
												   pRight.engine_model_1
												  );
	self.engine_model_2						:=	if(lEngineFilled_2 <> 0,
												   pLeft.engine_model_2,
												   pRight.engine_model_2
												  );
	self.engine_model_3						:=	if(lEngineFilled_3 <> 0,
												   pLeft.engine_model_3,
												   pRight.engine_model_3
												  );
	self.engine_year_1						:=	if(lEngineFilled_1 <> 0,
												   pLeft.engine_year_1,
												   pRight.engine_year_1
												  );
	self.engine_year_2						:=	if(lEngineFilled_2 <> 0,
												   pLeft.engine_year_2,
												   pRight.engine_year_2
												  );
	self.engine_year_3						:=	if(lEngineFilled_3 <> 0,
												   pLeft.engine_year_3,
												   pRight.engine_year_3
												  );
	self.watercraft_number_of_engines		:=	if(lEngineFilled_3 <> 0,
												   '3',
												   if(lEngineFilled_2 <> 0,
													  if(lEngineAvailable <> 0,
														 '3',
														 '2'
														),
													  if(lEngineFilled_1 <> 0,
														 if(lEngineAvailable <> 0,
															'2',
															'1'
														   ),
														  if(lEngineAvailable <> 0,
															 '1',
															 ''
															)
														)
													 )
												  );
	self									:=  pRight;
  end
 ;

dWatercraftRolledUp := rollup(dWatercraftAsCommon,
							  left.watercraft_key = right.watercraft_key
						  and left.sequence_key = right.sequence_key,
							  tRollupEngineAndLienholder(left,right),
							  local
							 );
							 

export Vehicle_as_Moxie_Main := dWatercraftRolledUp;
