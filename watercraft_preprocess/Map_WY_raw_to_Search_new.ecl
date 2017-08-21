import lib_stringlib, watercraft, watercraft_preprocess, ut, STD;

process_date := (string8)STD.Date.Today();
Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_WY_clean_in, watercraft.Layout_wy_2015_q1, hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, watercraft.Layout_wy_2015_q1, wDatasetwithflag)

Watercraft_preprocess.Layout_Watercraft_Search_Common search_mapping_format(wDatasetwithflag L, integer1 C) := TRANSFORM
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
	self.watercraft_key				     :=	if(trim(L.YEAR,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
	                                     if(trim(L.HULL_ID,left,right) <> 'VARIOUS' and trim(L.HULL_ID,left,right) <> 'UNKNOWN' and trim(L.HULL_ID,left,right) <> '',
	                                     (trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right))[1..30],
	                                     (trim(L.REG_NUM,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right) + trim(L.NAME,left,right))[1..30]));
	self.sequence_key				      :=	IF(L.PURCHASEDATE <> '' AND IsValidPurDate,L.PURCHASEDATE,L.REG_DATE);
	self.state_origin				      :=	'WY';
	self.source_code				      :=	'AW';
	self.dppa_flag                :=  '';
	tempPrevOwner									:= StringLib.StringCleanSpaces(L.PREVOWNERLNAME+' '+L.PREVOWNERFNAME+' '+L.PREVOWNERSUFFIX);
	self.orig_name								:=	choose(C,L.NAME,L.COOWNERNAME,tempPrevOwner);
	self.orig_name_type_code			:=	choose(C,'O','C','P');
	self.orig_name_type_description	:=	choose(C,'OWNER','CO-OWNER','PREVIOUS OWNER');
	self.orig_name_first					:=	choose(C,L.FIRST_NAME,L.COOWNERFNAME,L.PREVOWNERFNAME);
	self.orig_name_middle					:=	choose(C,L.MID,L.COOWNERMNAME,'');
	self.orig_name_last						:=	choose(C,L.LAST_NAME,L.COOWNERLNAME,L.PREVOWNERLNAME);
	self.orig_name_suffix					:=	choose(C,L.OWNERSUFFIX,L.COOWNERSUFFIX,L.PREVOWNERSUFFIX);
	Co_Owner_Addr									:= StringLib.StringCleanSpaces(L.OADDRESS1+' '+L.OADDRESS2);
	self.orig_address_1				    :=	choose(C,L.ADDRESS_1,CO_OWNER_ADDR,'');
	self.orig_city					      :=	choose(C,L.CITY,L.OCITY,'');
	self.orig_state					      :=	choose(C,L.STATE,L.OSTATE,'');
	self.orig_zip					        :=	choose(C,L.ZIP,TRIM(L.OZIP+L.OZIPSUFF,all),'');
	self.orig_fips					      :=	choose(C,L.FIPS,'','');
	self.name_format							:= IF(L.FIRST_NAME = '' and L.LAST_NAME <> '','U','L');
	self.prep_address_situs				:= self.orig_address_1;
	tempLastSitusOwn							:= StringLib.StringCleanSpaces(trim(L.CITY,left,right)
																		+	IF(trim(L.CITY) <> '',', ','')
																		+ trim(L.STATE,left,right)
																		+	' ' + trim(L.ZIP,left,right));
	tempLastSitusCoOwn						:= StringLib.StringCleanSpaces(trim(L.OCITY,left,right)
																		+	IF(trim(L.OCITY) <> '',', ','')
																		+ trim(L.OSTATE,left,right)
																		+	' ' + TRIM(L.OZIP+L.OZIPSUFF,all));
	self.prep_address_last_situs	:= choose(C,tempLastSitusOwn,tempLastSitusCoOwn,'');
	self := L;
	self := [];
  end; 

Mapping_WY_as_Search_norm			:= normalize(wDatasetwithflag,3,search_mapping_format(left,counter));

EXPORT Map_WY_raw_to_Search_new := Mapping_WY_as_Search_norm(orig_name <> '' and orig_name <> 'NA');