import lib_stringlib, watercraft, watercraft_preprocess, ut, STD;

// translates ia_phase01_update.mp Ab intio graph into ECL

process_date := (string8)STD.Date.Today();

Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_IA_clean_in,Watercraft.Layout_IA_new, hull_clean_in)

Watercraft_preprocess.Layout_Watercraft_Search_Common search_mapping_format(hull_clean_in L, integer1 C):= TRANSFORM
	self.date_first_seen			:=	IF(L.reg_date[7..8] not in ['00',''],L.reg_date,L.reg_date[1..6] + '01');
	self.date_last_seen				:=	IF(L.reg_date[7..8] not in ['00',''],L.reg_date,L.reg_date[1..6] + '01');
	self.date_vendor_first_reported	:=	process_date;
	self.date_vendor_last_reported	:=	process_date;
	//New watercraft_key logic to be implemented at a later date
	// self.watercraft_key		:=	stringlib.StringFindReplace(IF(trim(L.year,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12, trim(L.HULL_ID,left,right),
																													// IF(trim(L.REG_NUM,left,right) <> '', L.STATEABREV+trim(L.REG_NUM,left,right)+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																														// (trim(L.HULL_ID,left,right)+ IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''))[1..30])),' ','');                                        
	self.watercraft_key			:=	IF(L.HULL_ID = '', trim(L.REG_NUM,left,right), if(trim(L.year,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12, trim(L.HULL_ID,left,right),
	                               (trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right))[1..30]));
	self.sequence_key				:=	trim(L.REG_DATE,left,right);
	self.state_origin				:=	'IA';
	self.source_code				:=	'AW';
	self.dppa_flag					:=	'';
	self.orig_name					:= L.NAME;
	self.orig_name_type_code		:=	'O';
	self.orig_name_type_description	:=	'OWNER';
	self.orig_name_first			:=	choose(C,L.FIRST_NAME, '');
	self.orig_name_middle			:=	choose(C,L.MID, '');
	self.orig_name_last				:=	choose(C,L.LAST_NAME, '');
	self.orig_address_1				:=	L.ADDRESS_1;
	self.orig_city					:=	L.CITY;
	self.orig_state					:=	L.STATE;
	self.orig_zip						:=	L.ZIP;
	self.orig_fips					:=	L.FIPS;
	self.name_format				:= 'F';
	self.prep_address_situs	:= StringLib.StringCleanSpaces(L.Address_1);
	tempPrepLastSitus				:= trim(L.City,left,right)
																+	IF(trim(L.City) <> '',', ','')
																+ trim(L.STATE,left,right)
																+	' ' + trim(StringLib.StringFindReplace(L.ZIP,'-',''),left,right);
	self.prep_address_last_situs	:= StringLib.StringCleanSpaces(tempPrepLastSitus);
	self := L;
	self := [];
  end; 

EXPORT Map_IA_raw_to_Search := (normalize(hull_clean_in,2,search_mapping_format(left,counter)))(orig_name <> '');