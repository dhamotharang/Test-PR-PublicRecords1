import lib_stringlib, watercraft, watercraft_preprocess, ut, STD;

// translates merchent_vessel.mp Ab intio graph into ECL 

process_date := (string8)STD.Date.Today();
Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_CG_clean_in, watercraft.Layout_CG, hull_clean_in)

Watercraft_preprocess.Layout_Watercraft_Search_Common search_mapping_format(hull_clean_in L) :=  TRANSFORM
	self.date_first_seen			:=	'';
	self.date_last_seen				:=	'';
	self.date_vendor_first_reported	:=	process_date;
	self.date_vendor_last_reported	:=	process_date;
	self.watercraft_key				:=	L.vessel_id;
	self.sequence_key			    :=	StringLib.StringCleanSpaces(trim(L.NAME,left,right)+trim(L.FIRST_NAME,left,right)+trim(L.MID,left,right)+trim(L.LAST_NAME,left,right));
	self.state_origin					:=	'US';
	self.source_code					:=	'CG';
	self.dppa_flag            :=  '';
	self.orig_name						:=	L.NAME;
	self.orig_name_type_description	:=	IF(REGEXFIND('N/A|UNKNOWN|UNSPECIFIED',L.ORGANIZATION_TYPE),'',L.ORGANIZATION_TYPE);
	self.orig_name_first			:=	L.FIRST_NAME;
	self.orig_name_middle			:=	L.MID;
	self.orig_name_last				:=	L.LAST_NAME;
	self.orig_name_suffix			:=	L.PERSON_NAME_SUFFIX;
	self.orig_address_1				:=	L.ADDRESS_1;
	self.orig_address_2       :=  L.STREET_ADDRESS_LINE_2;
	self.orig_city						:=	L.city;
	self.orig_state						:=	L.state;
	self.orig_zip							:=	L.ZIP;
	self.orig_fips						:=	L.fips;
	self.orig_province        :=  l.province;
	self.orig_country         :=  l.country;
	self.name_format					:= IF(L.NAME <> '','U','P');
	tempPrepAddress						:= IF(trim(L.ADDRESS_1) <> '' and trim(L.STREET_ADDRESS_LINE_2) <> '', trim(L.ADDRESS_1)+' '+trim(L.STREET_ADDRESS_LINE_2),trim(L.ADDRESS_1));
	tempPrepLastSitus					:= trim(L.CITY,left,right)
															+	IF(trim(L.CITY) <> '',', ','')
															+ trim(L.STATE,left,right)
															+	' ' + trim(StringLib.StringFindReplace(L.ZIP,'-',''),left,right);
	self.prep_address_situs				:= StringLib.StringCleanSpaces(tempPrepAddress);
	self.prep_address_last_situs	:= StringLib.StringCleanSpaces(tempPrepLastSitus);
	self := L;
	self := [];
END;

EXPORT Map_CG_raw_to_Search := project(hull_clean_in(NAME <> '' or FIRST_NAME <> '' OR LAST_NAME <> ''),search_mapping_format(left));