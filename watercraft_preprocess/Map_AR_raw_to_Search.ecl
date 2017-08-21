import lib_stringlib, watercraft, watercraft_preprocess, ut, STD;

//translates ar_sekhar_phase01_update.mp Ab intio graph into ECL to a common format for all raw files
// Cleaning will be done after all raw files are in one common format to eliminate multiple passes to the cleaner for each source

fIn_clean_raw := watercraft_preprocess.file_AR_clean_in;
process_date := (string8)STD.Date.Today();

Watercraft.Macro_Clean_Hull_ID(fIn_clean_raw, Watercraft.layout_AR,hull_clean_in)

Watercraft_preprocess.Layout_Watercraft_Search_Common search_mapping_format(hull_clean_in L, integer1 C)
 :=  transform
	IsValidRegDate							:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.date_first_seen			:=	IF(IsValidRegDate AND L.REG_DATE < process_date,L.REG_DATE,'');
	self.date_last_seen				:=	IF(IsValidRegDate AND L.REG_DATE < process_date,L.REG_DATE,'');
	self.date_vendor_first_reported	:=	process_date;
	self.date_vendor_last_reported	:=	process_date;
	//New watercraft_key logic to be implemented at a later date
	// self.watercraft_key				:=	stringlib.StringFindReplace(IF(trim(L.YEAR, left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12, L.HULL_ID,
																															// IF(trim(L.YEAR, left,right) = '0' and length(trim(L.HULL_ID,left,right)) = 12, L.HULL_ID,
																																	// L.STATEABREV+L.REG_NUM+IF(trim(L.year,left,right)<>'0',trim(L.year,left,right),''))),' ','');                                          
	self.watercraft_key			:=	(trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right))[1..30];
	self.sequence_key				:=	trim(L.REG_DATE,left,right);
	self.state_origin				:=	'AR';
	self.source_code				:=	'AW';
	self.dppa_flag					:=	'';
	tempName2								:= IF(L.SecondOwner_LastName <> '',
																TRIM(L.SecondOwner_LastName,left,right)+', '+trim(L.SecondOwner_FirstName,left,right)+' '+trim(L.SecondOwner_MidName,left,right),
																'');
	self.orig_name					:=	choose(C,L.NAME, tempName2);
	self.orig_name_type_code		:=	'O';
	self.orig_name_type_description	:=	'OWNER';
	self.orig_address_1			:=	L.ADDRESS_1;
	//self.orig_address_2			:=	L.ADD2;
	self.orig_city					:=	L.CITY;
	self.orig_state					:=	L.STATE;
	self.orig_zip						:=	L.ZIP;
	self.orig_fips					:=	L.FIPS;
	self.name_format				:= 'U';
	//tempPrepAddress					:= IF(trim(L.ADDRESS_1) <> '' and trim(L.ADD2) <> '', trim(L.ADDRESS_1)+' '+trim(L.ADD2),trim(L.ADDRESS_1));
	tempPrepLastSitus				:= StringLib.StringCleanSpaces(trim(L.CITY,left,right)
																													+	IF(trim(L.CITY) <> '',', ','')
																													+ trim(L.STATE,left,right)
																													+	' ' + trim(L.ZIP,left,right));
	self.prep_address_situs				:= StringLib.StringCleanSpaces(L.ADDRESS_1);
	self.prep_address_last_situs	:= tempPrepLastSitus;
	self              := L;
	self							:= [];
  end;
	
	Mapping_AR_as_Search_norm	:= normalize(hull_clean_in,2,search_mapping_format(left,counter));

EXPORT Map_AR_raw_to_Search := dedup(sort(Mapping_AR_as_Search_norm(orig_name <> ''),watercraft_key, orig_name),ALL);