import watercraft, watercraft_preprocess, ut, lib_StringLib, STD;
// translates me_phase01.mp Ab intio graph into ECL to a common format for all raw files
// Name/Address cleaning will be done after all raw files are in one common format to eliminate multiple passes to the cleaner for each source

fIn_clean_raw := watercraft_preprocess.file_ME_clean_in;
process_date := (string8)STD.Date.Today();

Watercraft.Macro_Clean_Hull_ID(fIn_clean_raw,Watercraft.layout_me,hull_clean_in)

Watercraft_preprocess.Layout_Watercraft_Search_Common search_mapping_format(hull_clean_in L, integer1 C)
 := transform
	IsValidRegDate						:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
 	self.date_first_seen			:=	IF(IsValidRegDate AND L.REG_DATE < process_date,L.REG_DATE,'');
	self.date_last_seen				:=	IF(IsValidRegDate AND L.REG_DATE < process_date,L.REG_DATE,'');
	self.date_vendor_first_reported	:=	process_date;
	self.date_vendor_last_reported	:=	process_date;
	// New watercraft_key logic to be implemented at a later date
	// self.watercraft_key			:=	StringLib.StringFindReplace(IF(trim(L.year,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12, trim(L.HULL_ID,left,right),
																															// IF(trim(L.REG_NUM) != '',L.STATEABREV + L.REG_NUM + IF(trim(L.year,left,right)<>'0',trim(L.year,left,right),''),
																																	// L.HULL_ID + IF(trim(L.year,left,right)<>'0',trim(L.year,left,right),''))),' ','');                                          
	self.watercraft_key			:=	if(length(trim(L.HULL_ID,left,right)) = 12 and trim(L.year,left,right) >= '1972', trim(L.HULL_ID,left,right),
	                               (trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right))[1..30]);
	self.sequence_key				:=	trim(L.REG_DATE,left,right);
	self.state_origin				:=	'ME';
	self.source_code				:=	'AW';
	self.dppa_flag                  :=  '';
	self.orig_name									:=	choose(C, L.NAME, L.BUSINESS_NAME, L.BUSINESS_CONTACT);
	self.orig_name_type_code				:=	choose(C, 'O', 'O', 'Z');
	self.orig_name_type_description	:=	choose(C,'OWNER','OWNER','CONTACT');
	self.orig_name_first		:=	choose(C,L.FIRST_NAME, '', '', '');
	self.orig_name_middle		:=	choose(C,L.MID, '', '', '');
	self.orig_name_last			:=	choose(C,L.LAST_NAME, '', '', '');
	self.orig_name_suffix		:=	choose(C, L.SUFFIX, '', '', '');
	
	tempAddress1						:=	IF(trim(L.ADDRESS_1, LEFT, RIGHT) != trim(L.RESIDENCE_ADDRESS, LEFT, RIGHT) and L.RESIDENCE_ADDRESS <> '' and trim(l.RESIDENCE_COUNTRY,left,right) in ['UNITED STATES' , 'USA'],L.RESIDENCE_ADDRESS,L.ADDRESS_1);
	tempAddress2						:=	IF(trim(L.ADDRESS_1, LEFT, RIGHT) != trim(L.RESIDENCE_ADDRESS, LEFT, RIGHT) and L.RESIDENCE_ADDRESS <> '' and trim(l.RESIDENCE_COUNTRY,left,right) in ['UNITED STATES' , 'USA'],L.RESIDENCE_ADDRESS2,'');
	tempCity								:=	IF(trim(L.ADDRESS_1, LEFT, RIGHT) != trim(L.RESIDENCE_ADDRESS, LEFT, RIGHT) and L.RESIDENCE_ADDRESS <> '' and trim(l.RESIDENCE_COUNTRY,left,right) in ['UNITED STATES' , 'USA'],L.RESIDENCE_TOWN,L.CITY);
	tempState								:=	IF(trim(L.ADDRESS_1, LEFT, RIGHT) != trim(L.RESIDENCE_ADDRESS, LEFT, RIGHT) and L.RESIDENCE_ADDRESS <> '' and trim(l.RESIDENCE_COUNTRY,left,right) in ['UNITED STATES' , 'USA'],L.RESIDENCE_ST,L.STATE);
	temp_res_zip 						:= 	L.RESIDENCE_ZIP;
	tempZip									:=	IF(trim(L.ADDRESS_1, LEFT, RIGHT) != trim(L.RESIDENCE_ADDRESS, LEFT, RIGHT) and L.RESIDENCE_ADDRESS <> '' and trim(l.RESIDENCE_COUNTRY,left,right) in ['UNITED STATES' , 'USA'],temp_res_zip,L.ZIP);
	
	self.orig_address_1			:=	tempAddress1;
	self.orig_address_2			:=	tempAddress2;
	self.orig_city					:=	tempCity;
	self.orig_state					:=	tempState;
	self.orig_zip						:=	tempZip;
	self.orig_fips					:=	L.FIPS;
	is_valid_date						:=	STD.DATE.IsValidDate((integer)L.DOB);
	Tempdob									:=	IF(is_valid_date,L.DOB,'');
	self.dob								:=	choose(C,Tempdob, '','','');
	self.name_format				:=	choose(C,'F','U','F');
	tempPrepAddress					:=	IF(trim(tempAddress1) <> '' and trim(tempAddress2) <> '', trim(tempAddress1)+' '+trim(tempAddress2),trim(tempAddress1));
	tempPrepLastSitus				:=	StringLib.StringCleanSpaces(trim(tempCity,left,right)
																													+	IF(trim(tempCity) <> '',', ','')
																													+ trim(tempState,left,right)
																													+	' ' + trim(StringLib.StringFilterOut(tempZip,'-'),left,right));
	self.prep_address_situs				:= StringLib.StringCleanSpaces(tempPrepAddress);
	self.prep_address_last_situs	:= tempPrepLastSitus;
	self              := L;
	self							:= [];
  end; 

EXPORT Map_ME_raw_to_Search := (normalize(hull_clean_in,3,search_mapping_format(left,counter)))
                                ((orig_name_first <> '' and orig_name_last <> '') or orig_name <> '');