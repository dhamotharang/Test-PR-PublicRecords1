import lib_stringlib, watercraft, watercraft_preprocess, ut, STD;

// translates mo_MJ.ksh* Ab intio graph into ECL

fIn_clean_raw := watercraft_preprocess.file_MO_clean_in;
process_date := (string8)STD.Date.Today();

Watercraft.Macro_Clean_Hull_ID(fIn_clean_raw, Watercraft.layout_MO,hull_clean_in)

Watercraft_preprocess.Layout_Watercraft_Search_Common search_mapping_format(hull_clean_in L) := TRANSFORM
	IsValidRegDate						:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.date_first_seen			:=	if(L.REG_DATE= '19910926','',
																	If(IsValidRegDate,L.REG_DATE,''));
	self.date_last_seen				:=	if(L.REG_DATE= '19910926','',
																	If(IsValidRegDate,L.REG_DATE,''));
	self.date_vendor_first_reported	:=	process_date;
	self.date_vendor_last_reported	:=	process_date;
	// New watercraft_key logic to be implemented at a later date
	// self.watercraft_key			:=	stringlib.StringFindReplace(IF(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12, trim(L.HULL_ID,left,right),
																														// IF(length(trim(L.HULL_ID,left, right)) = 12 and trim(L.year, left, right) = '0', trim(L.HULL_ID,left,right),
																															// IF(trim(L.REG_NUM,left,right) <> '', trim(L.REG_NUM,left,right)+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																																	// (trim(L.HULL_ID,left,right)+ IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''))[1..30]))),' ','');                                          
	self.watercraft_key			:=	(trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right))[1..30];
	self.sequence_key				:=	if((trim(L.REG_DATE, left, right)<>''),L.REG_DATE,L.APPLICATION);
	self.state_origin				:=	'MO';
	self.source_code				:=	'AW';
	self.dppa_flag					:=	'';
	self.orig_name					:=	L.NAME;
	self.orig_name_type_code	:=	'R';
	self.orig_name_type_description	:=	'REGISTRANT';
	self.orig_address_1				:=	trim(L.ADDRESS_1,left,right);
	self.orig_city						:=	L.CITY;
	self.orig_state						:=	L.STATE;
	self.orig_zip							:=	L.ZIP;
	self.orig_fips						:=	L.FIPS;
	self.name_format					:= 'U';
	self.prep_address_situs		:= StringLib.StringCleanSpaces(L.Address_1);
	tempPrepLastSitus					:= trim(L.CITY,left,right)
																		+	IF(trim(L.CITY) <> '',', ','')
																		+ trim(L.STATE,left,right)
																		+	' ' + trim(StringLib.StringFindReplace(L.ZIP,'-',''),left,right);
	self.prep_address_last_situs	:= StringLib.StringCleanSpaces(tempPrepLastSitus);
	self := L;
	self := [];
  end; 

EXPORT Map_MO_raw_to_Search := project(hull_clean_in(Name <> ''),search_mapping_format(left));