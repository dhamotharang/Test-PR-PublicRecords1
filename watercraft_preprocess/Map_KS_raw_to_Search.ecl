import lib_stringlib, watercraft, watercraft_preprocess, ut, STD;

// translates  ks_phase01.mp Ab intio graph into ECL

fIn_clean_raw := watercraft_preprocess.file_KS_clean_in;
process_date := (string8)STD.Date.Today();

Watercraft.Macro_Clean_Hull_ID(fIn_clean_raw, watercraft.Layout_KS,hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, watercraft.Layout_KS, wDatasetwithflag)

Watercraft_preprocess.Layout_Watercraft_Search_Common search_mapping_format(wDatasetwithflag L)
:=
 transform
	self.date_first_seen			:=	(string4)((unsigned2)(L.EXPIRATION_DATE[1..4]) - 3) + L.EXPIRATION_DATE[5..8];
	self.date_last_seen				:=	(string4)((unsigned2)(L.EXPIRATION_DATE[1..4]) - 3) + L.EXPIRATION_DATE[5..8];
	self.date_vendor_first_reported	:=	process_date;
	self.date_vendor_last_reported	:=	process_date;
	// New watercraft_key logic will be implemented at a later date
	// self.watercraft_key	:=	stringlib.StringFindReplace(if(trim(L.year,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
																												// if(L.HULL_ID = '', trim(L.Reg_num,left,right)+IF(trim(L.YEAR,left,right) <> '0',trim(L.YEAR,left,right),''), 
																													// (trim(L.HULL_ID,left,right) + IF(trim(L.YEAR,left,right) <> '0',trim(L.YEAR,left,right),''))[1..30])),' ','');
	self.watercraft_key			:=	if(trim(L.YEAR,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
	                               if(L.HULL_ID = '' or trim(L.YEAR,left,right) = '0' or L.MAKE ='', trim(L.REG_NUM,left,right), 
																	(trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right))[1..30]));
	self.sequence_key				:=	trim(L.EXPIRATION_DATE,left,right);
	self.state_origin				:=	'KS';
	self.source_code				:=	'AW';
	self.dppa_flag					:=	'';
	self.orig_name					:=	L.NAME;
	self.orig_name_type_code	:=	'R';
	self.orig_name_type_description	:=	'REGISTRANT';
	self.orig_name_first		:=	L.FIRST_NAME;
	self.orig_name_middle		:=	L.MID;
	self.orig_name_last			:=	L.LAST_NAME;
	self.orig_address_1			:=	L.ADDRESS_1;
	self.orig_city					:=	L.CITY;
	self.orig_state					:=	L.STATE;
	self.orig_zip						:=	L.ZIP;
	self.orig_fips					:=	L.FIPS;
	IsValidDOB							:=	STD.DATE.IsValidDate((integer)L.DOB);
	self.dob								:=	If(IsValidDOB,L.DOB,'');
	self.name_format				:= 'U';
	self.prep_address_situs	:= StringLib.StringCleanSpaces(L.Address_1);
	tempPrepLastSitus				:= trim(L.City,left,right)
															+	IF(trim(L.City) <> '',', ','')
															+ trim(L.STATE,left,right)
															+	' ' + trim(StringLib.StringFindReplace(L.ZIP,'-',''),left,right);
	self.prep_address_last_situs	:= StringLib.StringCleanSpaces(tempPrepLastSitus);
	self := L;
	self := [];
  end;
	
	dMapping_KS_as_Search	:= project(wDatasetwithflag(Name <> ''),search_mapping_format(left));
	
	//Removing invalid DOB - Does not catch all, but catches most
Watercraft_preprocess.Layout_Watercraft_Search_Common RmvDOB(dMapping_KS_as_Search L) := TRANSFORM
	self.DOB	:= IF(L.DOB in ['19010101','20180330'], '',L.DOB);
	self			:= L;
END;

d_RmvDOB	:= project(dMapping_KS_as_Search, RmvDOB(left));

EXPORT Map_KS_raw_to_Search := d_RmvDOB(orig_name <> '');