import watercraft, watercraft_preprocess, ut, lib_StringLib, header, STD;

// translates  tx_phase01.mp Ab intio graph into ECL

fIn_clean_raw := watercraft_preprocess.file_TX_clean_in;
process_date := (string8)STD.Date.Today();

Watercraft.Macro_Clean_Hull_ID(fIn_clean_raw,Watercraft.layout_TX_new_18q3,hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, Watercraft.layout_TX_new_18q3, wDatasetwithflag)

string fFixHullID(string pHullIDIn)
 := lib_stringlib.StringLib.StringFilter(lib_stringlib.stringlib.stringtouppercase(pHullIDIn),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ ');
 
Watercraft_preprocess.Layout_Watercraft_Search_Common search_mapping_format(wDatasetwithflag L) := TRANSFORM
	IsValidRegDate						:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
 	self.date_first_seen			:=	IF(IsValidRegDate AND L.REG_DATE < process_date,L.REG_DATE,'');
	self.date_last_seen				:=	IF(IsValidRegDate AND L.REG_DATE < process_date,L.REG_DATE,'');
	self.date_vendor_first_reported	:=	process_date;
	self.date_vendor_last_reported	:=	process_date;
	//New watercraft_key logic to be implemented at a later date
	/*self.watercraft_key			:=	StringLib.StringFindReplace(IF(trim(L.year,left,right) >= '1972' and length(trim(fFixHullID,left, right)) = 12 and L.is_hull_id_in_MIC, trim(fFixHullID,left, right),
																																IF(length(trim(fFixHullID,left,right)) = 12 and trim(L.year,left,right) = '0', trim(fFixHullID,left,right),
																																		trim(L.REG_NUM) != '',L.STATEABREV + L.REG_NUM + IF(trim(L.year,left,right)<>'0',trim(L.year,left,right),''))),' ','');*/
	
	self.watercraft_key			:=	if(trim(L.YEAR,left,right) >= '1972' and length(trim(fFixHullID(L.HULL_ID),left,right)) = 12 and L.is_hull_id_in_MIC, trim(fFixHullID(L.HULL_ID),left,right),
	                              if(fFixHullID(L.HULL_ID) <> '' and trim(fFixHullID(L.HULL_ID),left,right) <> 'UNKN'and 
																	trim(fFixHullID(L.HULL_ID),left,right) <> 'UNKNOWN' and trim(L.YEAR,left,right) <> '19',
																	(trim(fFixHullID(L.HULL_ID),left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right))[1..30],
	                                (trim(L.MAKE,left,right) + trim(L.YEAR,left,right) + trim(L.NAME,left,right))[1..30]));
	self.sequence_key				:=	L.REG_DATE;
	self.state_origin				:=	'TX';
	self.source_code				:=	'AW';
	self.dppa_flag					:=	'';
	self.orig_name					:=	StringLib.StringCleanSpaces(IF(L.PRIMARY_OWNER_COMPANY = '',L.FIRST_NAME+' '+L.MID+' '+L.LAST_NAME+' '+L.PRIMARY_OWNER_SUFFIX,
																															L.PRIMARY_OWNER_COMPANY)); // Concat parsed name as FML to handle business names that are also in the parsed name
	self.orig_name_type_code		:=  'O';
	self.orig_name_type_description	:=	'OWNER';
	self.orig_name_first		:=	L.FIRST_NAME;
	self.orig_name_middle		:=	L.MID;
	self.orig_name_last			:=	L.LAST_NAME;
	self.orig_name_suffix		:=	L.PRIMARY_OWNER_SUFFIX;
	self.orig_address_1			:=	L.ADDRESS_1;
	self.orig_city					:=	L.CITY;
	self.orig_state					:=	L.STATE;
	self.orig_zip						:=	L.ZIP;
	self.orig_fips					:=	L.FIPS;
	self.name_format				:= IF(L.PRIMARY_OWNER_COMPANY <> '','U','F');

	tempPrepLastSitus				:= StringLib.StringCleanSpaces(trim(L.City,left,right)
																													+	IF(trim(L.City) <> '',', ','')
																													+ trim(L.STATE,left,right)
																													+	' ' + lib_stringlib.StringLib.StringFilter(trim(L.ZIP,left,right),'1234567890'));
	self.prep_address_situs				:= StringLib.StringCleanSpaces(L.Address_1);
	self.prep_address_last_situs	:= tempPrepLastSitus;
	self              := L;
	self							:= [];
  end; 

EXPORT Map_TX_raw_to_Search := project(wDatasetwithflag,search_mapping_format(left))(orig_name <> '' or orig_name_last <> '');