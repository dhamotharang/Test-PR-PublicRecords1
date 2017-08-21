import watercraft;

watercraft.Layout_KY_clean_in reformat(watercraft.file_KY_clean_in L) := transform

self.BT_HIN_NO := if(trim(L.BT_HIN_NO,left,right)in['NO S/N','NOS/N','N/S/N', 'UNK', 'UNKNOWN','UNKN'],'',if(StringLib.StringFind(L.BT_HIN_NO,'S/N',1) = 1,trim(L.BT_HIN_NO,left,right)[4..],L.BT_HIN_NO)) ;
self := L;
end;

hull_clean_in := project(watercraft.file_KY_clean_in, reformat(left));



watercraft.Layout_Watercraft_Main_Base main_mapping_format(hull_clean_in L) := transform


    self.watercraft_key				        :=	if(length(trim(L.BT_HIN_NO, left, right)) = 12 and trim(L.BT_MODEL_YEAR, left, right) >= '1972', trim(L.BT_HIN_NO, left, right),
										        (trim(L.BT_HIN_NO,left, right) + trim(L.BT_MAKE,left, right) + trim(L.BT_MODEL_YEAR, left, right) + trim(L.ON_NAME_LAST,left, right) + trim(L.ON_NAME_FIRST,left, right))[1..30]);                          
	self.sequence_key				        :=	L.BT_REG_DATE[7..10]+L.BT_REG_DATE[1..2]+L.BT_REG_DATE[4..5];
	self.watercraft_id						:=	'';
	self.state_origin						:=	'KY';
	self.source_code						:=	'KY';
	self.st_registration					:=	L.state_origin;
	self.county_registration				:=	L.BT_COUNTY_REG;
	self.registration_number				:=	trim(L.BT_KY_NO, left, right);
	self.hull_number						:=	L.BT_HIN_NO;
	self.propulsion_code					:=	L.BT_PROPULSION;
	self.propulsion_description				:=	map((L.BT_PROPULSION='OB')=>'OUTBOARD',
													(L.BT_PROPULSION='IB')=>'INBOARD',
													(L.BT_PROPULSION='IO')=>'INB/OUT',
													(L.BT_PROPULSION='SI')=>'SAIL/INBOARD',
													(L.BT_PROPULSION='SO')=>'SAIL/OUTBOARD',
													(L.BT_PROPULSION='WJ')=>'WATER JET',
													(L.BT_PROPULSION='ET')=>'ELECTRIC TROLL',
													'');
	self.vehicle_type_Code					:=	L.BT_TYPE;
	self.vehicle_type_Description			:=	map((L.BT_TYPE='AIR')=>'AIRBOAT',
													(L.BT_TYPE='COM')=>'COMMERCIAL',
													(L.BT_TYPE='CRU')=>'CRUISER',
													(L.BT_TYPE='HSE')=>'HOUSEBOAT',
													(L.BT_TYPE='HOV')=>'HOVERCRAFT',
													(L.BT_TYPE='HRO')=>'HYDROPLANE',
													(L.BT_TYPE='HYD')=>'HYDROFOIL',
													(L.BT_TYPE='RUN')=>'RUNABOUT',
													(L.BT_TYPE='PON')=>'PONTOON',
													(L.BT_TYPE='SAL')=>'SAILBOAT',
													(L.BT_TYPE='UTL')=>'UTILITY',
													(L.BT_TYPE='YAT')=>'YACHT',
													(L.BT_TYPE='YYY')=>'ALL OTHERS',
													'');
	self.fuel_code							:=	L.MO_FUEL_TYPE;
	self.fuel_description					:=	map((L.MO_FUEL_TYPE='G')=>'GAS',
													(L.MO_FUEL_TYPE='D')=>'DIESEL',
													(L.MO_FUEL_TYPE='O')=>'OTHER',
													'');
	self.hull_type_code						:=	L.BT_HULL_MATERIAL;
	self.hull_type_description				:=	map((L.BT_HULL_MATERIAL='WD')=>'WOODEN',
													(L.BT_HULL_MATERIAL='PL')=>'FIBERGLASS',
													(L.BT_HULL_MATERIAL='ST')=>'STEEL',
													(L.BT_HULL_MATERIAL='AL')=>'ALUMINUM',
													(L.BT_HULL_MATERIAL='OT')=>'OTHER',
													'');
	self.use_code							:=	L.BT_PRIMARY_USE;
	self.use_description					:=	map((L.BT_PRIMARY_USE='PL')=>'PLEASURE',
													(L.BT_PRIMARY_USE='RL')=>'RENT/LEASE',
													(L.BT_PRIMARY_USE='DM')=>'DEMONSTRATION',
													(L.BT_PRIMARY_USE='CM')=>'COMMERCIAL',
													(L.BT_PRIMARY_USE='GA')=>'GOVERNMENT AGENCY',
													'');
	self.watercraft_length					:=	(string)(12.0 * (decimal2)L.BT_LOA_LENGTH);
	self.model_year							:=	L.BT_MODEL_YEAR;
	self.watercraft_name					:=	L.BT_DOCUMENTED_NAME;
	self.watercraft_class_code				:=	'';
	self.watercraft_class_description		:=	'';
	self.watercraft_make_code				:=	'';
	self.watercraft_make_description		:=	L.BT_MAKE;	
	self.watercraft_model_code				:=	'';
	self.watercraft_model_description		:=	L.BT_MODEL;
	self.watercraft_width					:=	(string)(12.0 * (decimal2)L.BT_BEAM);
	self.watercraft_weight					:=	'';
	self.watercraft_color_1_code			:=	'';
	self.watercraft_color_1_description		:=	'';
	self.watercraft_color_2_code			:=	'';
	self.watercraft_color_2_description		:=	'';
	self.watercraft_toilet_code				:=	L.BT_TOILETS_TYPE;
	self.watercraft_toilet_description		:=	map((L.BT_TOILETS_TYPE='T')=>'HOLDING TANKS',
													(L.BT_TOILETS_TYPE='I')=>'INCINERATORS',
													(L.BT_TOILETS_TYPE='C')=>'CHEMICAL',
													'');
	self.watercraft_number_of_engines		:=	L.BT_MOTORS_NO;
	self.watercraft_hp_1					:=	L.MO_HORSE_PWR;
	self.watercraft_hp_2					:=	'';
	self.watercraft_hp_3					:=	'';
	self.engine_number_1					:=	'';
	self.engine_number_2					:=	'';
	self.engine_number_3					:=	'';
	self.engine_make_1						:=	L.MO_MAKE;
	self.engine_make_2						:=	'';
	self.engine_make_3						:=	'';
	self.engine_model_1						:=	L.MO_MODEL;
	self.engine_model_2						:=	'';
	self.engine_model_3						:=	'';
	self.engine_year_1						:=	L.MO_MODEL_YEAR;
	self.engine_year_2						:=	'';
	self.engine_year_3						:=	'';
	self.coast_guard_documented_flag		:=	'';
	self.coast_guard_number					:=	'';
	self.registration_date					:=	L.BT_REG_DATE[7..10]+L.BT_REG_DATE[1..2]+L.BT_REG_DATE[4..5];
	self.registration_expiration_date		:=	L.BT_REG_EXP_DATE[7..10]+L.BT_REG_EXP_DATE[1..2]+L.BT_REG_EXP_DATE[4..5];
	self.registration_status_code			:=	'';
	self.registration_status_description	:=	L.BT_REMARKS_DESC;
	self.registration_status_date			:=	L.BT_LAST_UPD_DATE[7..10]+L.BT_LAST_UPD_DATE[1..2]+L.BT_LAST_UPD_DATE[4..5];
	self.registration_renewal_date			:=	'';
	self.decal_number						:=	L.BT_DECAL_NO;
	self.transaction_type_code				:=	L.BT_REG_TYPE;
	self.transaction_type_description		:=	map((L.BT_REG_TYPE='A')=>'ADVALOREM TAX RECEIPT',
													(L.BT_REG_TYPE='V')=>'DECAL CORRECTION',
													(L.BT_REG_TYPE='C')=>'ALL OTHER CORRECTIONS',
													(L.BT_REG_TYPE='D')=>'DUPLICATE CERTIFICATE',
													(L.BT_REG_TYPE='J')=>'BOAT TYPE CONVERSION',
													(L.BT_REG_TYPE='U')=>'DECAL REPLACEMENT',
													(L.BT_REG_TYPE='N')=>'FIRST TIME',
													(L.BT_REG_TYPE='O')=>'OUT OF STATE',
													(L.BT_REG_TYPE='R')=>'RENEWAL',
													(L.BT_REG_TYPE='T')=>'TRANSFER',
													(L.BT_REG_TYPE='Z')=>'WEEKLY REPORT CORRECTION',
													'');
	self.title_state						:=	'';
	self.title_status_code					:=	L.TL_STATUS;	
	self.title_status_description			:=	map((L.TL_STATUS='1')=>'APPLICATION STATUS',
													(L.TL_STATUS='2')=>'ACTIVE TITLE',
													(L.TL_STATUS='3')=>'SURRENDERED TITLE',
													(L.TL_STATUS='4')=>'APPLICATION CANCELLED',
													(L.TL_STATUS='5')=>'RETURNED TO DVR',
													(L.TL_STATUS='6')=>'NO ISSUE TITLE',
													(L.TL_STATUS='7')=>'DEALER ASSIGNMENT-ACTIVE',
													(L.TL_STATUS='8')=>'DEALER ASSIGNMENT-INACTIVE',
													(L.TL_STATUS='9')=>'CANCELLED/REVOKED',
													'');
	self.title_number						:=	L.TL_TITLE_NO;
	self.title_issue_date          			:=  if(L.TL_PRINTED_DATE = '01/01/0001', ' ', L.TL_PRINTED_DATE[7..10]+L.TL_PRINTED_DATE[1..2]+L.TL_PRINTED_DATE[4..5]);
	self.title_type_code					:=	L.TL_TYPE;
	self.title_type_description				:=	map((L.TL_TYPE='1')=>'ORIGINAL',
													(L.TL_TYPE='2')=>'OUT OF STATE',
													(L.TL_TYPE='3')=>'TRANSFER',
													(L.TL_TYPE='4')=>'DUPLICATE', 
													(L.TL_TYPE='5')=>'UPDATE',
													(L.TL_TYPE='6')=>'SALVAGE',
													(L.TL_TYPE='7')=>'DEALER ASSIG',
													'');
	self.additional_owner_count				:=	'';
	self.lien_1_indicator					:=	if(trim(L.TL_LIEN_HLDR_NAM1,left,right)<>'','Y','');
	self.lien_1_name						:=	L.TL_LIEN_HLDR_NAM1;
	self.lien_1_date						:=	if(trim(L.TL_LIEN_HLDR_NAM1,left,right)<>'',L.TL_LIEN_DATE1[7..10]+L.TL_LIEN_DATE1[1..2]+L.TL_LIEN_DATE1[4..5],'');
	self.lien_1_address_1					:=	L.TL_LIEN_HLDR_ADR1;
	self.lien_1_address_2					:=	'';
	self.lien_1_city						:=	L.TL_LIEN_HLDR_CTY1;
	self.lien_1_state						:=	L.TL_LIEN_HLDR_ST1;
	self.lien_1_zip							:=	L.TL_LIEN_HLDR_ZP1;
	self.lien_2_indicator					:=	if(trim(L.TL_LIEN_HLDR_NAM2,left,right)<>'','Y','');
	self.lien_2_name						:=	L.TL_LIEN_HLDR_NAM2;
	self.lien_2_date						:=	if(trim(L.TL_LIEN_HLDR_NAM2,left,right)<>'',L.TL_LIEN_DATE2[7..10]+L.TL_LIEN_DATE2[1..2]+L.TL_LIEN_DATE2[4..5],'');
	self.lien_2_address_1					:=	L.TL_LIEN_HLDR_ADR2;
	self.lien_2_address_2					:=	'';
	self.lien_2_city						:=	L.TL_LIEN_HLDR_CTY2;
	self.lien_2_state						:=	L.TL_LIEN_HLDR_ST2;
	self.lien_2_zip							:=	L.TL_LIEN_HLDR_ZP2;
	self.state_purchased					:=	'';
	self.purchase_date						:=	L.BT_PURCH_YEAR;
	self.dealer								:=	L.TL_DEALER_NO;
	self.purchase_price						:=	if(trim(L.BT_PURCH_AMOUNT,left,right)<>'0',L.BT_PURCH_AMOUNT,'');
	self.new_used_flag						:=	'';
	self.watercraft_status_code				:=	'';
	self.watercraft_status_description		:=	'';
	self.history_flag						:=	'';      
	self.coastguard_flag					:=	'';
  
  end;



export Mapping_KY_as_Main := project(hull_clean_in, main_mapping_format(left));
