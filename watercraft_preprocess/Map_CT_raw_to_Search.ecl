import lib_stringlib, watercraft, watercraft_preprocess, ut, STD;

// translates  ct_phase01.mp Ab intio graph into ECL

fIn_clean_raw := watercraft_preprocess.file_CT_clean_in;
process_date := (string8)STD.Date.Today();

//Consolodate parsed/full names and normalize primary address
Watercraft.layout_CT_2015Q3 NormAddr(fIn_clean_raw L, integer1 C) := TRANSFORM
	TempFullName		:= STD.Str.CleanSpaces(TRIM(L.LAST_NAME,left,right)+IF(L.PRIMARY_NAME_SUFFIX <> '',' '+TRIM(L.PRIMARY_NAME_SUFFIX,left,right)+', ',', ')
																				+TRIM(L.FIRST_NAME,left,right)+' '+TRIM(L.MID,left,right));
	self.NAME				:= IF(L.NAME <> '' AND L.LAST_NAME <> '' and REGEXFIND('TRUST',L.NAME),TempFullName,
												IF(L.NAME = '' AND L.LAST_NAME <> '', TempFullName, L.NAME));
	self.ADDRESS_1	:= CHOOSE(C,L.ADDRESS_1,STD.Str.CleanSpaces(L.PRIMARY_OWNER_ADDRESS1+' '+L.PRIMARY_OWNER_ADDRESS2));
	self.CITY				:= CHOOSE(C,L.CITY,L.PRIMARY_OWNER_CITY);
	self.STATE			:= CHOOSE(C,L.STATE,L.PRIMARY_OWNER_STATE);
	self.ZIP				:= CHOOSE(C,L.ZIP,L.PRIMARY_OWNER_ZIP);
	self.SEC_OWNER	:= IF(L.SEC_OWNER_LASTNAME <> '',STD.Str.CleanSpaces(TRIM(L.SEC_OWNER_LASTNAME,left,right)
																																		+IF(L.SEC_OWNER_NAME_SUFFIX <> '',' '+TRIM(L.SEC_OWNER_NAME_SUFFIX,left,right)+', ',', ')
																																		+TRIM(L.SEC_OWNER_FIRSTNAME,left,right)+' '+TRIM(L.SEC_OWNER_MIDDLENAME,left,right)),L.SEC_OWNER);
	self		:= L;
END;

nName_Address	:= NORMALIZE(fIn_clean_raw,2,NormAddr(left,counter))(name <> '');

Watercraft.Macro_Clean_Hull_ID(nName_Address, Watercraft.layout_CT_2015Q3,hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, Watercraft.layout_CT_2015Q3,wDatasetwithflag)

//Normalize Primary and Secondary owner name and Address
Watercraft_preprocess.Layout_Watercraft_Search_Common search_mapping_format(wDatasetwithflag L, integer1 C)
:=	TRANSFORM
	IsValidRegDate						:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
 	self.date_first_seen			:=	IF(IsValidRegDate AND L.REG_DATE < process_date,L.REG_DATE,'');
	self.date_last_seen				:=	IF(IsValidRegDate AND L.REG_DATE < process_date,L.REG_DATE,'');
	self.date_vendor_first_reported	:=	process_date;
	self.date_vendor_last_reported	:=	process_date;
	//New watercraft_key logic to be implemented at a later date
	// self.watercraft_key			:=	stringlib.StringFindReplace(if(length(trim(L.HULL_ID,left,right)) = 12 and trim(L.year,left,right) >= '1972' and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
	                               // if(trim(L.HULL_ID,left,right) = '' or length(trim(L.HULL_ID,left,right)) < 12, trim(L.REG_NUM,left,right)+ IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																		// (trim(L.HULL_ID,left,right) + trim(L.YEAR,left,right))[1..30])),' ','');
	self.watercraft_key			:=	IF(length(trim(L.HULL_ID,left,right)) = 12 and trim(L.year,left,right) >= '1972' and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
	                                IF(stringlib.stringfind(L.HULL_ID, 'UNKNOWN', 1) = 0, (trim(L.HULL_ID,left,right) + trim(regexreplace('UNKNOWN', L.MAKE, ''),left,right) + trim(L.YEAR, left,right))[1..30],
																		(trim(regexreplace('UNKNOWN', L.HULL_ID, ''),left,right) + trim(regexreplace('UNKNOWN', L.MAKE, ''),left,right) + trim(L.YEAR,left,right) + trim(L.NAME,left,right))[1..30]));
	self.sequence_key				:=	trim(L.REG_DATE,left,right);
	self.state_origin				:=	'CT';
	self.source_code				:=	'AW';
	self.dppa_flag					:=	'';
	self.orig_name					:=	StringLib.StringCleanSpaces(REGEXREPLACE(',$',CHOOSE(C,L.NAME, L.SEC_OWNER),''));
	self.orig_name_type_code		:=	'R';
	self.orig_name_type_description	:=	'REGISTRANT';
	self.orig_address_1			:=	CHOOSE(C,L.ADDRESS_1,STD.Str.CleanSpaces(L.SEC_OWNER_ADDRESS1+' '+L.SEC_OWNER_ADDRESS2));
	self.orig_city					:=	CHOOSE(C,L.CITY,L.SEC_OWNER_CITY);
	self.orig_state					:=	CHOOSE(C,L.STATE,L.SEC_OWNER_STATE);
	self.orig_zip						:=	CHOOSE(C,L.ZIP,L.SEC_OWNER_ZIP);
	self.orig_fips					:=	CHOOSE(C,L.FIPS,'');
	IsValidDOB							:=	STD.DATE.IsValidDate((integer)CHOOSE(C,L.PRIMARY_DOB,L.SEC_OWNER_DOB));
	self.dob								:=	CHOOSE(C,IF(IsValidDOB,L.PRIMARY_DOB,''),IF(IsValidDOB,L.SEC_OWNER_DOB,''));
	self.gender							:=	'';
	self.name_format				:= 	IF(self.orig_name = L.SEC_OWNER OR StringLib.StringFind(self.orig_name,',',1)>0,'L','U');
	self.prep_address_situs	:= StringLib.StringCleanSpaces(CHOOSE(C,L.ADDRESS_1,L.SEC_OWNER_ADDRESS1+' '+L.SEC_OWNER_ADDRESS2));
	tempPrepLastSitus				:= CHOOSE(C,trim(L.CITY,left,right)
																			+ IF(trim(L.CITY) <> '',', ','')
																			+ trim(L.STATE,left,right)
																			+	' ' + trim(L.ZIP,left,right)[1..5]
																			+ trim(L.ZIP,left,right)[7..10],
																			trim(L.SEC_OWNER_CITY,left,right)
																			+ IF(trim(L.SEC_OWNER_CITY) <> '',', ','')
																			+ trim(L.SEC_OWNER_STATE,left,right)
																			+ ' ' + trim(L.SEC_OWNER_ZIP,left,right)[1..5]
																			+ trim(L.SEC_OWNER_ZIP,left,right)[7..10]);
	self.prep_address_last_situs	:= StringLib.StringCleanSpaces(tempPrepLastSitus);
	self              := L;
	self							:= [];
  end; 
 
Mapping_CT_as_Search_norm			:= normalize(wDatasetwithflag,2,search_mapping_format(left,counter));

EXPORT Map_CT_raw_to_Search := dedup(sort(Mapping_CT_as_Search_norm(orig_name <> ''),watercraft_key,orig_name,orig_address_1,orig_city,orig_state)
																		,watercraft_key,orig_name,orig_address_1,orig_city,orig_state); //prevents secondary addresses that have no zip extension from not dedupping