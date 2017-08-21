import lib_stringlib, watercraft, watercraft_preprocess, ut, STD;

// translates az_update.mp Ab intio graph into ECL

fIn_clean_raw := watercraft_preprocess.file_AZ_clean_in;
process_date := (string8)STD.Date.Today();

Watercraft.Macro_Clean_Hull_ID(fIn_clean_raw,Watercraft.layout_AZ_new,hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, Watercraft.layout_AZ_new, wDatasetwithflag)


Watercraft_preprocess.Layout_Watercraft_Search_Common search_mapping_format(wDatasetwithflag L)
 :=  transform
	IsValidRegDate						:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
 	self.date_first_seen			:=	IF(IsValidRegDate AND L.REG_DATE < process_date,L.REG_DATE,'');
	self.date_last_seen				:=	IF(IsValidRegDate AND L.REG_DATE < process_date,L.REG_DATE,'');
	self.date_vendor_first_reported	:=	process_date;
	self.date_vendor_last_reported	:=	process_date;
	//New watercraft_key logic to be implemented at a later date 
	// self.watercraft_key	:=	stringlib.StringFindReplace(IF(length(trim(L.HULL_ID,left,right)) = 12 and trim(L.year,left,right) >= '1972'
																												// and trim(L.HULL_ID,left,right) <> '000000000000'and L.is_hull_id_in_MIC,trim(L.HULL_ID, left, right),
																												// IF(trim(L.HULL_ID,left,right) = '000000000000' or trim(L.YEAR,left,right) = '1900'
																													// or trim(L.HULL_ID,left,right) = '' or length(trim(L.HULL_ID,left,right)) < 12,
																													// L.STATEABREV+trim(L.REG_NUM,left,right) + IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																													// (trim(L.HULL_ID,left,right) + IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''))[1..30])),' ','');                                      
	self.watercraft_key			:=	IF(length(trim(L.HULL_ID,left,right)) = 12 and trim(L.year,left,right) >= '1972'
	                               and trim(L.HULL_ID,left,right) <> '000000000000'and L.is_hull_id_in_MIC,trim(L.HULL_ID, left, right),
																	IF(trim(L.HULL_ID,left,right) = '000000000000' or trim(L.YEAR,left,right) = '1900' or
																		L.MAKE = ''or trim(L.HULL_ID,left,right) ='NONE' ,trim(L.REG_NUM,left,right), (trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right))[1..30]));
	self.sequence_key				:=	trim(L.REG_DATE,left,right);
	self.state_origin				:=	'AZ';
	self.source_code				:=	'AW';
	self.dppa_flag					:=	'';
	self.orig_name					:=	L.NAME;
	self.orig_name_type_code		:=	'R';
	self.orig_name_type_description	:=  'REGISTRANT';
	self.orig_name_first			:=	L.FIRST_NAME;
	self.orig_name_middle			:=	L.MID;
	self.orig_name_last				:=	L.LAST_NAME;
	self.orig_name_suffix			:=	L.SUFFIX;
	self.orig_address_1				:=	L.ADDRESS_1;
	self.orig_city						:=	L.CITY;
	self.orig_state						:=	L.STATE;
	self.orig_zip							:=	L.ZIP;
	self.orig_fips						:=	L.FIPS;
	self.name_format					:= 'P';
	self.prep_address_situs		:= StringLib.StringCleanSpaces(L.Address_1);
	tempPrepLastSitus					:= StringLib.StringCleanSpaces(trim(L.City,left,right)
																													+	IF(trim(L.City) <> '',', ','')
																													+ trim(L.STATE,left,right)
																													+	' ' + trim(L.ZIP,left,right));
	self.prep_address_last_situs	:= tempPrepLastSitus;
	self		:= L;
	self		:= [];
  end;
	
EXPORT Map_AZ_raw_to_Search := project(wDatasetwithflag(Name <> ''),search_mapping_format(left));