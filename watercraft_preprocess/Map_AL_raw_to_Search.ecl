import lib_stringlib, watercraft, watercraft_preprocess, ut, STD;

// translates al_update.mp Ab intio graph into ECL
// Cleaning will be done after all raw files are in one common format to eliminate multiple passes to the cleaner for each source

fIn_clean_raw := watercraft_preprocess.file_AL_clean_in;
process_date := (string8)STD.Date.Today();

Watercraft.Macro_Clean_Hull_ID(fIn_clean_raw, Watercraft.Layout_AL_fixed,hull_clean_in)

Watercraft_preprocess.Layout_Watercraft_Search_Common search_mapping_format(hull_clean_in L):= TRANSFORM
	IsValidRegDate						:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.date_first_seen			:=	IF(IsValidRegDate AND L.REG_DATE < process_date,L.REG_DATE,'');
	self.date_last_seen				:=	IF(IsValidRegDate AND L.REG_DATE < process_date,L.REG_DATE,'');
	self.date_vendor_first_reported	:=	process_date;
	self.date_vendor_last_reported	:=	process_date;
	//New watercraft_key logic to be implemented at a later date
	// self.watercraft_key				:= stringlib.StringFindReplace(IF(trim(L.year,left right) >= '72' and length(trim(L.HULL_ID,left,right)) = 12,trim(L.HULL_ID),
																// IF(L.REG_NUM<> '', trim(L.REG_NUM)+IF(trim(L.year,left,right)<>'0',trim(L.year,left,right),''),
																	// trim(state_origin) + trim(L.DECAL_NUMBER) + IF(trim(L.MAKE)<>'',trim(L.MAKE),''))),' ','');
	self.watercraft_key			:=	(trim(L.HULL_ID, left, right) + trim(L.DECAL_NUMBER, left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30];
	self.sequence_key				:=	trim(L.REG_DATE);
	self.state_origin				:=	'AL';
	self.source_code				:=	'AW';
	self.orig_name					:=	L.NAME;
	self.orig_name_type_code				:=	'R';
	self.orig_name_type_description	:=  'REGISTRANT';
	self.orig_name_first			:=	L.FIRST_NAME;
	self.orig_name_middle			:=	L.MID;
	self.orig_name_last				:=	L.LAST_NAME;
	self.orig_address_1				:=	L.ADDRESS_1;
	self.orig_city						:=	L.CITY;
	self.orig_state						:=	L.STATE;
	self.orig_zip							:=	L.ZIP;
	self.orig_fips						:=	L.FIPS;
	is_valid_date							:= STD.DATE.IsValidDate((integer)L.DOB);
	self.dob									:=	IF(is_valid_date,L.DOB,'');
	self.name_format					:= 'F';
	self.prep_address_situs		:= StringLib.StringCleanSpaces(L.Address_1);
	tempPrepLastSitus					:= trim(L.City,left,right)
															+	IF(trim(L.City) <> '',', ','')
															+ trim(L.STATE,left,right)
															+	' ' + trim(StringLib.StringFindReplace(L.ZIP,'-',''),left,right);
	self.prep_address_last_situs	:= StringLib.StringCleanSpaces(tempPrepLastSitus);
	self := L;
	self := [];
  end; 

EXPORT Map_AL_raw_to_Search := project(hull_clean_in(Name <> ''),search_mapping_format(left));