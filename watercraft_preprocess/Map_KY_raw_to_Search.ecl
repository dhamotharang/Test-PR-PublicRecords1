import lib_stringlib, watercraft, watercraft_preprocess, ut, STD;

// translates ky_infolink.mp Ab intio graph into ECL

fIn_clean_raw := watercraft_preprocess.file_KY_clean_in;
process_date := (string8)STD.Date.Today();

Watercraft_preprocess.Layout_Watercraft_Search_Common search_mapping_format(fIn_clean_raw L):= TRANSFORM
	IsValidRegDate						:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
 	self.date_first_seen			:=	IF(IsValidRegDate AND L.REG_DATE < process_date,L.REG_DATE,'');
	self.date_last_seen				:=	IF(IsValidRegDate AND L.REG_DATE < process_date,L.REG_DATE,'');
	self.date_vendor_first_reported	:=	process_date;
	self.date_vendor_last_reported	:=	process_date;
	// New watercraft_key logic to be implemented at a later date
	// self.watercraft_key	:=	stringlib.StringFindReplace(IF(length(trim(L.HULL_ID, left, right)) = 12 and trim(L.YEAR, left, right) >= '1972', trim(L.HULL_ID, left, right),
																												// IF(trim(L.REG_NUM,left,right) <> '',trim(L.REG_NUM,left,right)+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																													// trim(L.HULL_ID,left,right)+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),'')[1..30])),' ','');                          
	self.watercraft_key			:=	if(length(trim(L.HULL_ID,left,right)) = 12 and trim(L.YEAR,left,right) >= '1972', trim(L.HULL_ID,left,right),
																(trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right) + trim(L.LNAME,left,right) + trim(L.FNAME,left,right))[1..30]); 
	self.sequence_key				:=	trim(L.REG_DATE,left,right);
	self.state_origin				:=	'KY';
	self.source_code				:=	'AW';
	self.orig_name					:=	L.NAME;
	self.orig_name_type_code	:=	'O';
	self.orig_name_type_description	:=	'OWNER';
	self.orig_name_first			:=	L.FNAME;
	self.orig_name_middle			:=	L.MNAME;
	self.orig_name_last				:=	L.LNAME;
	self.orig_address_1				:=	L.ADDRESS;
	self.orig_city						:=	L.CITY;
	self.orig_state						:=	L.STATE;
	self.orig_zip							:=	L.ZIP;
	self.orig_fips						:=	L.FIPS;
	self.gender								:=	L.SEX;
	self.name_format					:= 'U';
	self.prep_address_situs		:= StringLib.StringCleanSpaces(L.Address);
	tempPrepLastSitus					:= trim(L.City,left,right)
																+	IF(trim(L.City) <> '',', ','')
																+ trim(L.STATE,left,right)
																+	' ' + trim(StringLib.StringFindReplace(L.ZIP,'-',''),left,right);
	self.prep_address_last_situs	:= StringLib.StringCleanSpaces(tempPrepLastSitus);
	self := L;
	self := [];
  end; 

EXPORT Map_KY_raw_to_Search := project(fIn_clean_raw,search_mapping_format(left));