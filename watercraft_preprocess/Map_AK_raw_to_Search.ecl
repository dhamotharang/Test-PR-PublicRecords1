import watercraft, watercraft_preprocess, ut, lib_StringLib, header, STD;

// translates ak_phase01_update.mp Ab intio graph into ECL to a common format for all raw files
// Cleaning will be done after all raw files are in one common format to eliminate multiple passes to the cleaner for each source

fIn_clean_raw := watercraft_preprocess.file_AK_clean_in;
process_date := (string8)STD.Date.Today();

Watercraft.Macro_Clean_Hull_ID(fIn_clean_raw,Watercraft.layout_ak,hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, Watercraft.layout_ak, wDatasetwithflag)


Watercraft_preprocess.Layout_Watercraft_Search_Common search_mapping_format(wDatasetwithflag L, integer1 C)
 :=
  transform
	IsValidStatusDte								:=	STD.DATE.IsValidDate((integer)L.DMVStatusDate1);
	IsValidRegDate									:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.date_first_seen						:=	IF(IsValidStatusDte AND TRIM(L.DMVStatusDate1) != '' and L.DMVStatusDate1 < L.REG_DATE, L.DMVStatusDate1,
																				IF(IsValidRegDate, L.REG_DATE, ''));
	self.date_last_seen							:=	IF(IsValidStatusDte AND TRIM(L.DMVStatusDate1) != '' and L.DMVStatusDate1 < L.REG_DATE, L.DMVStatusDate1,
																				IF(IsValidRegDate, L.REG_DATE, ''));
	self.date_vendor_first_reported	:=	process_date;
	self.date_vendor_last_reported	:=	process_date;
	tempHullID											:=  StringLib.StringFindReplace(L.HULL_ID,'NONE','');
	//New watercraft_key logic to be implemented at a later date
	// tempWatercraftKey						:= StringLib.StringFindReplace(IF(trim(L.year,left,right) >= '1972' and length(trim(tempHullID,left, right)) = 12 and L.is_hull_id_in_MIC, trim(tempHullID,left, right),
																															// 	IF(length(trim(L.HULL_ID,left,right)) = 12 and trim(L.year,left,right) = '0', trim(tempHullID,left,right),
																																		//trim(L.REG_NUM) != '',L.STATEABREV + L.REG_NUM + IF(trim(L.year,left,right)<>'0',trim(L.year,left,right),''))),' ','');
	// self.watercraft_key					:=	IF(StringLib.Stringfind(tempWatercraftKey,'.',1) > 0, stringlib.StringFindReplace(tempWatercraftKey,'.',''),tempWatercraftKey);                                          
	self.watercraft_key				  :=	if(trim(L.year,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12 and L.is_hull_id_in_MIC, trim(tempHullID,left,right),
	                                        IF(length(trim(L.HULL_ID,left,right)) = 12 and trim(L.year,left,right) = '0', trim(tempHullID,left,right),
																						(trim(tempHullID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right) + L.last_NAME + L.first_name + L.mid)[1..30]));                                        
	self.sequence_key								:=	IF(L.DMVStatusDate1 > L.REG_DATE, L.DMVStatusDate1,
																				IF(trim(L.REG_DATE) != '',L.REG_DATE,L.LastActionDate));
	self.state_origin								:=	'AK';
	self.source_code								:=	'AW';
	self.orig_name									:=	choose(C,L.Company1, L.OwnerNameCompany2, L.OwnerNameCompany3, L.OwnerNameCompany4, L.OwnerNameCompany5);
	self.orig_name_type_code				:=	'O';
	self.orig_name_type_description	:=	'OWNER';
	self.orig_name_first			:=	choose(C,L.FIRST_NAME, L.OwnerNameFirst2, L.OwnerNameFirst3, L.OwnerNameFirst4, L.OwnerNameFirst5);
	self.orig_name_middle			:=	choose(C,L.MID, L.OwnerNameMiddle2, L.OwnerNameMiddle3, L.OwnerNameMiddle4, L.OwnerNameMiddle5);
	self.orig_name_last				:=	choose(C,L.LAST_NAME, L.OwnerNameLast2, L.OwnerNameLast3, L.OwnerNameLast4, L.OwnerNameLast5);
	self.orig_name_suffix			:=	choose(C,L.Suffix1, L.OwnerNameSuffix2, L.OwnerNameSuffix3, L.OwnerNameSuffix4, L.OwnerNameSuffix5);
	
	tempAddress1							:= if(trim(L.AddressRes1) = ''or regexfind('PO BOX', L.AddressRes1), L.Address_1, L.AddressRes1);
	tempAddress2							:= if(trim(L.AddressRes2) = '' or regexfind('PO BOX', L.AddressRes2), L.Address2,L.AddressRes2);
	tempCity									:= if(trim(L.AddressRes1) = '' or regexfind('PO BOX', L.AddressRes1),  L.City, L.CityRes);
	tempState									:= if(trim(L.AddressRes1) = '' or regexfind('PO BOX', L.AddressRes1),  L.STATE, L.StateRes);
	tempZip										:= if(trim(L.AddressRes1) = '' or regexfind('PO BOX', L.AddressRes1), L.ZIP, if(L.ZipRes <> '' and L.Zip4res <> '', L.ZipRes +'-'+ L.Zip4Res, 
	                                   if(L.ZipRes = '', L.Zip4res, L.Zipres)));
	self.orig_address_1				:=	tempAddress1;
	self.orig_address_2				:=	tempAddress2;
	self.orig_city						:=	tempCity;
	self.orig_state						:=	tempState;
	self.orig_zip							:=	tempZip;
	self.orig_fips						:=	L.FIPS;
	self.name_format					:= IF(self.orig_name <> '', 'U', 'P');
	
	tempPrepAddress						:= IF(trim(tempAddress1) <> '' and trim(tempAddress2) <> '', trim(tempAddress1)+' '+trim(tempAddress2),trim(tempAddress1));
	tempPrepLastSitus					:= StringLib.StringCleanSpaces(trim(tempCity,left,right)
																													+	IF(trim(tempCity) <> '',', ','')
																													+ trim(tempState,left,right)
																													+	' ' + trim(StringLib.StringFindReplace(tempZip,'-',''),left,right));
	self.prep_address_situs				:= StringLib.StringCleanSpaces(tempPrepAddress);
	self.prep_address_last_situs	:= tempPrepLastSitus;
	
	self              := L;
	self							:= [];
  end; 
 
EXPORT Map_AK_raw_to_Search	:= (normalize(wDatasetwithflag,5,search_mapping_format(left,counter)))
                                ((orig_name_first <> '' and orig_name_last <> '') or orig_name <> '');
