import lib_stringlib, watercraft, watercraft_preprocess, ut, STD;

process_date := (string8)STD.Date.Today();
Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_WY_clean_in, watercraft.Layout_wy_new_2014, hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, watercraft.Layout_wy_new_2014, wDatasetwithflag)

Watercraft_preprocess.Layout_Watercraft_Search_Common search_mapping_format(wDatasetwithflag L) := TRANSFORM
	IsValidPurDate									:= STD.DATE.IsValidDate((integer)L.PURCHASEDATE);
	IsValidRegDate									:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.date_first_seen			      :=	IF(L.PURCHASEDATE <> '' AND IsValidPurDate,L.PURCHASEDATE,
																				IF(IsValidRegDate,L.REG_DATE,''));
	self.date_last_seen				      :=	IF(L.PURCHASEDATE <> '' AND IsValidPurDate,L.PURCHASEDATE,
																				IF(IsValidRegDate,L.REG_DATE,''));
	self.date_vendor_first_reported	:=	process_date;
	self.date_vendor_last_reported	:=	process_date;
	//New watercraft_key logic to be implemented at a later date
	// self.watercraft_key			:=	stringlib.StringFindReplace(IF(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
																														// IF(length(trim(L.HULL_ID,left, right)) = 12 and trim(L.year, left, right) = '0', trim(L.HULL_ID,left,right),
																															// IF(trim(L.REG_NUM,left,right) <> '', L.STATEABREV +trim(L.REG_NUM,left,right)+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																																	// (trim(L.HULL_ID,left,right)+ IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''))[1..30]))),' ',''); 
	self.watercraft_key				     	:=	if(trim(L.YEAR,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
	                                     if(trim(L.HULL_ID,left,right) <> 'VARIOUS' and trim(L.HULL_ID,left,right) <> 'UNKNOWN' and trim(L.HULL_ID,left,right) <> '',
	                                     (trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right))[1..30],
	                                     (trim(L.REG_NUM,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right) + trim(L.NAME,left,right))[1..30]));
	self.sequence_key				       :=	IF(L.PURCHASEDATE <> '' AND IsValidPurDate,L.PURCHASEDATE,L.REG_DATE);
	self.state_origin				       :=	'WY';
	self.source_code				       :=	'AW';
	self.dppa_flag                 :=  '';
	self.orig_name					        :=	L.NAME;
	self.orig_name_type_code		    :=	'O';
	self.orig_name_type_description	:=	'OWNER';
	self.orig_name_first			      :=	L.FIRST_NAME;
	self.orig_name_middle			      :=	L.MID;
	self.orig_name_last				      :=	L.LAST_NAME;
	self.orig_address_1				      :=	L.ADDRESS_1;
	self.orig_city					        :=	L.CITY;
	self.orig_state					        :=	L.STATE;
	self.orig_zip					          :=	L.ZIP;
	self.orig_fips					        :=	L.FIPS;
	self.name_format								:= IF(L.FIRST_NAME = '' and L.LAST_NAME <> '','U','L');
	self.prep_address_situs					:= StringLib.StringCleanSpaces(L.Address_1);
	tempPrepLastSitus								:= trim(L.City,left,right)
																		+	IF(trim(L.City) <> '',', ','')
																		+ trim(L.STATE,left,right)
																		+	' ' + trim(StringLib.StringFindReplace(L.ZIP,'-',''),left,right);
	self.prep_address_last_situs		:= StringLib.StringCleanSpaces(tempPrepLastSitus);
	self := L;
	self := [];
  end; 

EXPORT Map_WY_raw_to_Search := project(wDatasetwithflag,search_mapping_format(left));