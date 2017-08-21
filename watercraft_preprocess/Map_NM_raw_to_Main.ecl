import watercraft, watercraft_preprocess, ut, lib_StringLib, STD;

county_reg(string5 code) := case(code,
'NM001'=> 'BERNALILLO',
'NM003'=> 'CATRON',
'NM005'=>	'CHAVES',
'NM006'=>	'CIBOLA',
'NM007'=>	'COLFAX',
'NM009'=>	'CURRY',
'NM011'=>	'DE BACA',
'NM013'=>	'DOÃƒâ€˜A ANA',
'NM015'=>	'EDDY',
'NM017'=>	'GRANT',
'NM019'=>	'GUADALUPE',
'NM021'=>	'HARDING',
'NM023'=>	'HIDALGO',
'NM025'=>	'LEA',
'NM027'=>	'LINCOLN',
'NM028'=>	'LOS ALAMOS',
'NM029'=>	'LUNA',
'NM031'=>	'MCKINLEY',
'NM033'=>	'MORA',
'NM035'=>	'OTERO',
'NM037'=>	'QUAY',
'NM039'=>	'RIO ARRIBA',
'NM041'=>	'ROOSEVELT',
'NM043'=>	'SANDOVAL',
'NM045'=>	'SAN JUAN',
'NM047'=>	'SAN MIGUEL',
'NM049'=>	'SANTA FE',
'NM051'=>	'SIERRA',
'NM053'=>	'SOCORRO',
'NM055'=>	'TAOS',
'NM057'=>	'TORRANCE',
'NM059'=>	'UNION',
'NM061'=>	'VALENCIA',
 '');

title_stat(string1 code) := case(code,
'0'	=>	'ACTIVE VALUE',
'1'	=>	'INCOMPLETE VALUE',
'9'	=>	'STOP VALUE',
'R'	=>	'RETURN VALUE','');

record_stat(string1 code)	:= case(code,
'0'	=>	'ACTIVE',
'2'	=>	'DELETE',
'3'	=>	'CANCEL',
'4'	=>	'JUNKED',
'5'	=>	'STOLEN',
'6'	=>	'SOLD', '');

Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_NM_clean_in,Watercraft.layout_nm,hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, Watercraft.layout_nm, wDatasetwithflag)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(wDatasetwithflag L) := TRANSFORM
	self.watercraft_key				      :=	StringLib.StringFindReplace(IF(trim(L.year,left,right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left, right),
																																		IF(length(trim(L.HULL_ID,left,right)) = 12 and trim(L.year,left,right) = '0', trim(L.HULL_ID,left,right),
																																			IF(trim(L.REG_NUM) != '' and L.REG_NUM != '00000000',L.REG_NUM + IF(trim(L.year,left,right)<>'0',trim(L.year,left,right),''),
																																					trim(L.MAKE,left,right) + trim(L.YEAR,left,right) + trim(L.NAME,left,right)))),' ','');
	self.sequence_key				        :=	L.REG_DATE;
	self.state_origin				        :=	'NM';
	self.source_code				        :=	'AW';
	self.st_registration					 	:=	trim(L.STATE,left,right);
	self.county_registration				:=	county_reg(trim(L.COUNTY,left,right));
	self.registration_number				:=	trim(L.REG_NUM,left,right);
	self.hull_number						    :=	L.hull_id;
	self.propulsion_description			:=	L.PROP;
	self.vehicle_type_Description		:=	L.VEH_TYPE;
	self.fuel_description					  :=	L.FUEL;
	self.hull_type_description			:=	L.HULL;
	self.use_description					  :=	L.USE_1;
	self.watercraft_length					:=	L.TOTAL_INCH;
	self.model_year							    :=	if(L.YEAR <> '0', L.YEAR, '');
	self.watercraft_make_description	:=	L.MAKE;
	self.watercraft_model_description	:=	L.MODEL;
	self.watercraft_width					    :=	L.BEAM_WIDTH;
	self.watercraft_hp_1					    :=	L.HORSE_POWER;
	self.engine_number_1					    :=	L.ENGINE_NUMBER;
	IsValidRegDate										:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.registration_date					  :=	IF(IsValidRegDate,L.REG_DATE,'');
	self.registration_status_code			:=	L.REG_STATUS;
	self.registration_status_description	:=	IF(L.REG_STATUS <> '','CLEAR','');
	IsValidReg_Expdte									:=  STD.DATE.IsValidDate((integer)L.ISSUE_DATE);
	self.registration_expiration_date :=  IF(IsValidReg_Expdte,L.EXPIRATION_DATE,'');
	// self.decal_number						      :=	L.STICKER_NUMBER;
	self.decal_number						      :=	'';
	// self.transaction_type_code				:=	L.LAST_TRANS_CODE;
	self.transaction_type_description	:=	'';
	self.title_status_code					  :=	'';
	self.title_status_description			:=	L.TITLE_STATUS;
	self.title_number						      :=	intformat((integer) L.TITLE_NUMBER,15,0);
	IsValidIssueDate									:=  STD.DATE.IsValidDate((integer)L.ISSUE_DATE);
	self.title_issue_date					    :=	IF(IsValidIssueDate,L.ISSUE_DATE,'');
	self.lien_1_indicator					    :=	IF(L.LIEN_NAME <> '', 'Y', 'N');
	self.lien_1_name						      :=	L.LIEN_NAME;
	IsValidMatureDate									:=	STD.DATE.IsValidDate((integer)L.LIEN_MATURITY_DATE);
	self.lien_1_date						      :=	IF(IsValidMatureDate,L.LIEN_MATURITY_DATE,'');
	self.lien_1_address_1					    :=	L.LIEN_ADDRESS;
	self.lien_1_address_2					    :=	L.LIEN_ADDRESS_2;
	self.lien_1_city						      :=	L.LIEN_CITY;
	self.lien_1_state						      :=	L.LIEN_STATE;
	self.lien_1_zip							      :=	L.LIEN_ZIP;
	self.lien_2_indicator					    :=	IF(L.LIEN_NAME2 <> '', 'Y', 'N');
	self.lien_2_name						      :=	L.LIEN_NAME2;
	IsValidMature2Date								:=	STD.DATE.IsValidDate((integer)L.LIEN_MATURITY_DATE2);
	self.lien_2_date						      :=	IF(IsValidMature2Date,L.LIEN_MATURITY_DATE2,'');
	self.lien_2_address_1					    :=	L.LIEN_ADDRESS2;
	self.lien_2_address_2					    :=	L.LIEN_ADDRESS2_2;
	self.lien_2_city						      :=	L.LIEN_CITY2;
	self.lien_2_state						      :=	L.LIEN_STATE2;
	self.lien_2_zip							     	:=	L.LIEN_ZIP2;
	IsValidPurchDate									:=	STD.DATE.IsValidDate((integer)L.PURCHASE_DATE);
	self.purchase_date						    :=	If(IsValidPurchDate,L.PURCHASE_DATE,'');
	self.dealer								        :=	L.DEALER_NUMBER;
	self.purchase_price						    :=	L.PURCHASE_PRICE;
	// self.watercraft_status_code				:=	L.RECORD_STATUS;
	// self.watercraft_status_description	:= record_stat(TRIM(L.RECORD_STATUS,LEFT,RIGHT));
	self	:= L;
	self	:= [];
END;
	
EXPORT Map_NM_raw_to_Main := project(wDatasetwithflag, main_mapping_format(left));