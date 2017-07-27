import lib_stringlib;

fTitleStatusDescFromCode(string2 pState, string pCode)
 :=
  case(pState,
	   'FL'	=>	case(pCode,
					 'CA'	=>	'Cancelled',
					 'DD'	=>	'Duplicate Certificate Of Destruction',
					 'DE'	=>	'Certificate Of Destruction',
					 'DR'	=>	'Duplicate Certificate Of Repossession',
					 'DU'	=>	'Duplicate',
					 'JU'	=>	'Junked',
					 'LM'	=>	'Lien Maint Only',
					 'LO'	=>	'Lien Only Out Of State',
					 'MR'	=>	'Misc Revenue Title',
					 'OR'	=>	'Original New',
					 'OU'	=>	'Original Used',
					 'RE'	=>	'Reinstate',
					 'RP'	=>	'Certificate Of Repossession',
					 'SD'	=>	'Sold',
					 'TC'	=>	'Title Correction',
					 'TM'	=>	'Title Modification',
					 'TR'	=>	'Transfer',
					 'VO'	=>	'Void',
					 ''
					),
	   'MO'	=>	case(pCode,
					'0'		=>	'Duplicate Salvage Title',
					'1'		=>	'Original',
					'2'		=>	'Duplicate',
					'3'		=>	'Non-Negotiable',
					'4'		=>	'Repossession',
					'5'		=>	'Corrected Copy',
					'6'		=>	'Mechanic Lien',
					'7'		=>	'Owner Copy',
					'8'		=>	'Lienholder Copy',
					'9'		=>	'Salvage Title',
					'A'		=>	'Junk Title',
					'B'		=>	'Duplicate Junk Title',
					'Z'		=>	'Title Only',
					''
				   ),
	   ''
	  )
 ;

fColorDescFromCode(string2 pState, string pCode)
 :=
  case(pState,
	   'FL' => case(pCode,
					'AME' => 'AMETHYST',
					'BGE' => 'BEIGE',
					'BLK' => 'BLACK',
					'BLU' => 'BLUE',
					'BRO' => 'BROWN',
					'BRZ' => 'BRONZE',
					'CAM' => 'CAMOUFLAGE',
					'COM' => 'STAINLESS',
					'CPR' => 'COPPER',
					'CRM' => 'CREAM',
					'DBL' => 'DARK BLUE',
					'DGR' => 'DARK GREEN',
					'GLD' => 'GOLD',
					'GRN' => 'GREEN',
					'GRY' => 'GRAY',
					'LAV' => 'LAVENDER',
					'LBL' => 'LIGHT BLUE',
					'LGR' => 'LIGHT GREEN',
					'MAR' => 'MAROON',
					'MUL' => 'MULTICOLORED',
					'MVE' => 'MAUVE',
					'ONG' => 'ORANGE',
					'PLE' => 'PURPLE',
					'PNK' => 'PINK',
					'RED' => 'RED',
					'SIL' => 'SILVER',
					'TAN' => 'TAN',
					'TEA' => 'TEAL',
					'TPE' => 'TAUPE',
					'TRQ' => 'TURQUOISE',
					'UNK' => '',
					'WHI' => 'WHITE',
					'YEL' => 'YELLOW',
					''
				   ),
	   'MO' => case(pCode,
					'BGE' => 'BEIGE',
					'BLK' => 'BLACK',
					'BLU' => 'BLUE',
					'BRO' => 'BROWN',
					'BRZ' => 'BRONZE',
					'COM' => 'STAINLESS',
					'CPR' => 'COPPER',
					'CRM' => 'CREAM',
					'DBL' => 'DARK BLUE',
					'DGR' => 'DARK GREEN',
					'GLD' => 'GOLD',
					'GRN' => 'GREEN',
					'GRY' => 'GRAY',
					'LAV' => 'LAVENDER',
					'LBL' => 'LIGHT BLUE',
					'LGR' => 'LIGHT GREEN',
					'MAR' => 'MAROON',
					'ORG' => 'ORANGE',
					'PLE' => 'PURPLE',
					'PNK' => 'PINK',
					'RED' => 'RED',
					'SIL' => 'SILVER',
					'TAN' => 'TAN',
					'TRQ' => 'TURQUOISE',
					'UNK' => '',
					'WHI' => 'WHITE',
					'YEL' => 'YELLOW',
					''
				   ),
		''
	  ); 

fFuelDescFromCode(string2 pState, string pCode)
 :=
  case(pState,
	   'FL' => case(pCode,
					'D' => 'DIESEL',
					'E' => 'ELECTRIC',
					'G' => 'GAS',
					'H' => 'GASOHOL',
					'N' => 'NATURAL GAS',
					'O' => 'OTHER',
					'P' => 'PROPANE',
					''
				   ),
	   'MO' => case(pCode,
					'D' => 'DIESEL',
					'E' => 'ELECTRIC',
					'F' => 'GASOLINE',
					'G' => 'GASOLINE',
					'L' => 'LIQUID PETRO',
					'N' => 'NATURAL GAS',
					'O' => 'OTHER',
					''
				   ),
		''
	  ); 

fHullMaterialDescFromCode(string2 pState, string pCode)
 :=
  case(pState,
	   'FL' => case(pCode,
					'AL' => 'ALUMINUM',
					'FG' => 'FIBERGLASS',
					'OT' => 'OTHER',
					'ST' => 'STEEL',
					'WD' => 'WOOD',
					'WF' => 'WOOD/FIBERGLASS',
					''
				   ),
	   'MO' => case(pCode,
					'ALUM'  => 'ALUMINUM',
					'CONCR' => 'CONCRETE',
					'FGLAS' => 'FIBERGLASS',
					'HYPAL' => 'HYPAL',
					'KEVLA' => 'KEVLA',
					'PLAS'  => 'PLASTIC',
					'RUBBR' => 'RUBBER',
					'STEEL' => 'STEEL',
					'WOOD'  => 'WOOD',
					''
				   ),
		''
	  ); 

fVehicleUseDescFromCode(string2 pState, string pCode)
 :=
  case(pState,
	   'FL' => case(pCode,
					'C' => 'POLICE',
					'L' => 'LEASE',
					'M' => 'COMMERCIAL',
					'O' => 'LONG TERM LEASE',
					'P' => 'PRIVATE',
					'T' => 'TAXI',
					'V' => 'VESSEL',
					''
				   ),
	   'MO' => case(pCode,
					'C' => 'COMMERCIAL',
					'O' => 'OFFICIAL',
					'P' => 'PLEASURE',
					'R' => 'RENTAL',
					''
				   ),
		''
	  ); 

Watercraft.Layout_Watercraft_Main_Base tAccurintVehicleToMain(Watercraft.File_Vehicles_Prod_Watercraft_Only pInput)
:=
  transform
	self.watercraft_key						:=	lib_stringlib.stringlib.stringfindreplace(trim(pInput.VEHICLE_NUMBERxBG1),' ','_');
	self.sequence_key						:=	if(pInput.registration_effective_date <> '',
												   pInput.registration_effective_date,
												   if(pInput.registration_expiration_date <> '',
													  pInput.registration_expiration_date,
													  if(pInput.title_issue_date <> '',
														 pInput.title_issue_date,
														 pInput.registration_number
														)
													 )
												  );
	self.watercraft_id						:=	'';
	self.state_origin						:=	pInput.orig_state;
	self.source_code						:=	'AW';
	self.st_registration					:=	pInput.orig_state;
	self.county_registration				:=	'';
	self.registration_number				:=	pInput.REGISTRATION_NUMBER;
	self.hull_number						:=	pInput.ORIG_VIN;
	self.propulsion_code					:=	pInput.VESSEL_PROPULSION_TYPE;
	self.propulsion_description				:=	'';									//###Translation necessary? ###
	self.vehicle_type_Code					:=	pInput.VESSEL_TYPE;
	self.vehicle_type_Description			:=	'';									//###fromCODES_V3 lookup ###
	self.fuel_code							:=	pInput.FUEL_TYPE;
	self.fuel_description					:=	fFuelDescFromCode(pInput.orig_state,pInput.FUEL_TYPE);
	self.hull_type_code						:=	pInput.HULL_MATERIAL_TYPE;
	self.hull_type_description				:=	fHullMaterialDescFromCode(pInput.orig_state,pInput.HULL_MATERIAL_TYPE);
	self.use_code							:=	pInput.VEHICLE_USE;
	self.use_description					:=	fVehicleUseDescFromCode(pInput.orig_state,pInput.Vehicle_Use);
	self.watercraft_length					:=	(string)((integer)pInput.LENGTH_FEET * 12);
	self.model_year							:=	pInput.YEAR_MAKE;
	self.watercraft_name					:=	'';
	self.watercraft_class_code				:=	pInput.VEHICLE_CLASS_CODE;									//###fromCODES_V3 lookup ###
	self.watercraft_class_description		:=	'';
	self.watercraft_make_code				:=	pInput.MAKE_CODE;
	self.watercraft_make_description		:=	pInput.make_description;
	self.watercraft_model_code				:=	pInput.MODEL;
	self.watercraft_model_description		:=	if(pInput.series_description <> '',
												   pInput.series_description,
												   pInput.model_description
												  );
	self.watercraft_width					:=	(string)(((integer4)pInput.WIDTH_FEET) * 12);
	self.watercraft_weight					:=	pInput.NET_WEIGHT;
	self.watercraft_color_1_code			:=	pInput.MAJOR_COLOR_CODE;
	self.watercraft_color_1_description		:=	fColorDescFromCode(pInput.orig_state,pInput.MAJOR_COLOR_CODE);
	self.watercraft_color_2_code			:=	pInput.MINOR_COLOR_CODE;
	self.watercraft_color_2_description		:=	fColorDescFromCode(pInput.orig_state,pInput.MINOR_COLOR_CODE);
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
	self.registration_date					:=	pInput.REGISTRATION_EFFECTIVE_DATE;
	self.registration_expiration_date		:=	pInput.REGISTRATION_EXPIRATION_DATE;
	self.registration_status_code			:=	pInput.REGISTRATION_STATUS_CODE;
	self.registration_status_description	:=	'';									//###Translation necessary? ###
	self.registration_status_date			:=	'';
	self.registration_renewal_date			:=	'';
	self.decal_number						:=	pInput.DECAL_NUMBER;
	self.transaction_type_code				:=	'';
	self.transaction_type_description		:=	'';
	self.title_state						:=	pInput.orig_state;
	self.title_status_code					:=	pInput.TITLE_STATUS_CODE;
	self.title_status_description			:=	fTitleStatusDescFromCode(pInput.orig_state,pInput.TITLE_STATUS_CODE);
	self.title_number						:=	pInput.TITLE_NUMBERxBG9;
	self.title_issue_date					:=	pInput.TITLE_ISSUE_DATE;
	self.title_type_code					:=	pInput.TITLE_TYPE;
	self.title_type_description				:=	'';									//###Translation necessary? ###
	self.additional_owner_count				:=	'';
	self.lien_1_indicator					:=	'';
	self.lien_1_name						:=	pInput.LH_1_CUSTOMER_NAME;
	self.lien_1_date						:=	pInput.LH_1_LIEN_DATE;
	self.lien_1_address_1					:=	pInput.LH_1_STREET_ADDRESS;
	self.lien_1_address_2					:=	'';
	self.lien_1_city						:=	pInput.LH_1_CITY;
	self.lien_1_state						:=	pInput.LH_1_STATE;
	self.lien_1_zip							:=	pInput.LH_1_ZIP5_ZIP4_FOREIGN_POSTAL;
	self.lien_2_indicator					:=	'';
	self.lien_2_name						:=	pInput.LH_2_CUSTOMER_NAME;
	self.lien_2_date						:=	pInput.LH_2_LEIN_DATE;
	self.lien_2_address_1					:=	pInput.LH_2_STREET_ADDRESS;
	self.lien_2_address_2					:=	'';
	self.lien_2_city						:=	pInput.LH_2_CITY;
	self.lien_2_state						:=	pInput.LH_2_STATE;
	self.lien_2_zip							:=	pInput.LH_2_ZIP5_ZIP4_FOREIGN_POSTAL;
	self.state_purchased					:=	'';
	self.purchase_date						:=	'';
	self.dealer								:=	'';
	self.purchase_price						:=	pInput.price;
	self.new_used_flag						:=	'';
	self.watercraft_status_code				:=	'';
	self.watercraft_status_description		:=	'';
	self.history_flag						:=	'';
	self.coastguard_flag					:=	'';
  end										
 ;											

export Mapping_Vehicles_as_Main	:= project(Watercraft.File_Vehicles_Prod_Watercraft_Only,tAccurintVehicleToMain(left)) : persist('persist::watercraft_vehicle_as_main');

