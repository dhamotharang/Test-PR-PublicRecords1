import lib_stringlib, watercraft, watercraft_preprocess, ut, STD;

// Translates wi_01.mp

process_date := (string8)STD.Date.Today();
Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_WI_clean_in, watercraft.Layout_WI_new.common, hull_clean_in)





Watercraft_preprocess.Layout_Watercraft_Search_Common search_mapping_format(hull_clean_in L, integer1 C) :=  TRANSFORM
	IsValidRegDate						:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	IsValidTransDate					:=	STD.DATE.IsValidDate((integer)L.LAST_TRANSACTION_DATE);
	self.date_first_seen			:=	If(L.REG_DATE<>'' AND IsValidRegDate,L.REG_DATE,
																	If(IsValidTransDate,L.LAST_TRANSACTION_DATE,''));
	self.date_last_seen				:=	If(L.REG_DATE<>'' AND IsValidRegDate,L.REG_DATE,
																	If(IsValidTransDate,L.LAST_TRANSACTION_DATE,''));
	self.date_vendor_first_reported	:=	process_date;
	self.date_vendor_last_reported	:=	process_date;
	//New watercraft_key logic to be implemented at a later date
	// self.watercraft_key			:=	stringlib.StringFindReplace(IF(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12, trim(L.HULL_ID,left,right),
																														// IF(length(trim(L.HULL_ID,left, right)) = 12 and trim(L.year, left, right) = '0', trim(L.HULL_ID,left,right),
																															// IF(trim(L.REG_NUM,left,right) <> '', L.STATEABREV +trim(L.REG_NUM,left,right)+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																																	// (trim(L.HULL_ID,left,right)+ IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''))[1..30]))),' ',''); 
	self.watercraft_key			:=	trim(L.REG_NUM,left,right);
	self.sequence_key				:=	if(trim(L.REG_DATE,left,right)<>'',L.REG_DATE,L.LAST_TRANSACTION_DATE);
	self.state_origin				:=	'WI';
	self.source_code				:=	'AW';
	self.dppa_flag					:=	'';
	ClnContact							:= StringLib.StringCleanSpaces(MAP(StringLib.StringFind(L.CONTACT,'@',1)>0 => StringLib.StringFindReplace(L.CONTACT,'@',' '),
																															StringLib.StringFind(L.CONTACT,'C/O',1)>0 => StringLib.StringFindReplace(L.CONTACT,'C/O',' '),
																															StringLib.StringFind(L.CONTACT,'C/0',1)>0 => StringLib.StringFindReplace(L.CONTACT,'C/0',' '),
																															StringLib.StringFind(L.CONTACT,'ATTN:',1)>0 => StringLib.StringFindReplace(L.CONTACT,'ATTN:',' '),
																															L.CONTACT));
	self.orig_name					:=	choose(C,if(trim(L.NAME,left,right)='NULL' OR (L.BUSINESS <> 'NULL' and L.BUSINESS <> ''),'',L.NAME), if(trim(L.BUSINESS,left,right)='NULL','',L.BUSINESS), if(trim(L.CONTACT,left,right)='NULL','',ClnContact));
	self.orig_name_type_code	:=	choose(C,'O','O','Z');
	self.orig_name_type_description	:=	choose(C,'OWNER','OWNER','CONTACT');
	self.orig_name_first			:=	choose(C,L.FIRST_NAME, '', '');
	self.orig_name_middle			:=	choose(C,L.MID, '', '');
	self.orig_name_last				:=	choose(C,L.LAST_NAME, '', '');
	self.orig_name_suffix			:=	'';
	self.orig_address_1				:=	L.ADDRESS_1;
	self.orig_address_2				:=	L.ADDRESS2;
	self.orig_city						:=	L.CITY;
	self.orig_state						:=	L.STATE;
	self.orig_zip							:=	L.ZIP;
	self.orig_fips						:=	L.FIPS;
	self.name_format					:= IF(L.BUSINESS <> '','U','F');
	tempPrepAddress						:= IF(trim(L.ADDRESS_1) <> '' and trim(L.ADDRESS2) <> '', trim(L.ADDRESS_1)+' '+trim(L.ADDRESS2),trim(L.ADDRESS_1));
	tempPrepLastSitus					:= trim(L.CITY,left,right)
															+	IF(trim(L.CITY) <> '',', ','')
															+ trim(L.STATE,left,right)
															+	' ' + trim(StringLib.StringFindReplace(L.ZIP,'-',''),left,right);
	self.prep_address_situs		:= StringLib.StringCleanSpaces(tempPrepAddress);
	self.prep_address_last_situs	:= StringLib.StringCleanSpaces(tempPrepLastSitus);
	self := L;
	self := [];
END;

NormWI_Search		:=  (normalize(hull_clean_in,3,search_mapping_format(left,counter)))(orig_name <> '');

EXPORT Map_WI_raw_to_Search := dedup(NormWI_Search);