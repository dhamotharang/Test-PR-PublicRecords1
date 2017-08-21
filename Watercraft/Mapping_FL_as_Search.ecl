import lib_stringlib, watercraft,Address, ut, NID;


Watercraft.Macro_Clean_Hull_ID(Watercraft.file_FL_clean_in, watercraft.Layout_FL_clean_in,hull_clean_in)

watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, watercraft.Layout_FL_clean_in, wDatasetwithflag)

Watercraft.Layout_Watercraft_Search_Group search_mapping_format(wDatasetwithflag L)
 :=
  transform
	self.date_first_seen			:=	L.reg_date;
	self.date_last_seen				:=	L.reg_date;
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key				:=	if(length(trim(L.HULL_ID, left, right)) = 12 and trim(L.year, left, right) >= '1972' and L.is_hull_id_in_MIC, trim(L.HULL_ID, left, right),
										(trim(L.HULL_ID,left, right) + trim(L.MAKE,left, right) + trim(L.YEAR, left, right)));                               
	self.sequence_key				:=	trim(L.REG_DATE, left, right);
	self.state_origin				:=	'FL';
	self.source_code				:=	'AW';
	self.dppa_flag					:=	'';
	clnName									:= ut.fn_RemoveSpecialChars(L.NAME);
	self.orig_name					:=	clnName;
	self.orig_name_type_code		:=	L.NM_Source[1..1];
	self.orig_name_type_description	:=	map((L.NM_Source[1..1]='O')=>'OWNER',
										    (L.NM_Source[1..1]='R')=>'REGISTRANT',
										    '');
	self.orig_name_first			:=	'';
	self.orig_name_middle			:=	'';
	self.orig_name_last				:=	'';
	self.orig_name_suffix			:=	'';
	self.orig_address_1				:=	L.ADDRESS_1;
	self.orig_address_2				:=	L.ADDRESS_2;
	self.orig_city					:=	if(trim(L.CITY)='UNKNOWN','',L.CITY);
	self.orig_state					:=	L.STATE;
	self.orig_zip					:=	L.ZIP;
	self.orig_fips					:=	L.FIPS;
	self.dob						:=	if(l.clean_cname<>'','',L.NM_DOB);
	self.orig_ssn					:=	if((L.NM_CUST_TYPE='I' and L.NM_FEID_SSN<>'000000000'),L.NM_FEID_SSN,'');
	self.orig_fein					:=	if((L.NM_CUST_TYPE='B' and L.NM_FEID_SSN<>'000000000'),L.NM_FEID_SSN,'');
	// NM_CUST_TYPE denotes business(B)
	// or individual(I) for Florida.  Because DOB is populated differently for each entity,
	// a way to exclude type "B" is needed for header build.  bug#33002
	self.gender						:=	if(L.NM_CUST_TYPE='B','B',L.NM_SEX);
	self.phone_1					:=	'';
	self.phone_2					:=	'';
	self.clean_pname      :=  L.clean_pname;
	self.company_name			:=	'';
	self.clean_address    :=  L.clean_address;            
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score			:=	'';                              
	self.ssn						:=	'';
	self.history_flag		:=	'';
  end ;
	
	map_to_search := project(wDatasetwithflag,search_mapping_format(left));
	rmv_dups := dedup(sort(distribute(map_to_search,hash(watercraft_key)),watercraft_key, sequence_key, -date_vendor_last_reported,local));
	
//Fix cleaning issues - Bug #120861
//Clean input name	
	NID.Mac_CleanFullNames(rmv_dups, FileClnName, orig_name, includeInRepository:=true, normalizeDualNames:=false);
	
// Clean names
	person_flags := ['P', 'D'];
  Bus_flags   := ['B', 'U', 'T']; 		
	fClean_name := project(FileClnName,transform({Watercraft.Layout_Watercraft_Search_Group},            
																		self.clean_pname	:= if(left.nametype = 'I' and left.gender <> 'B', left.clean_pname,	
																														if(left.nametype IN person_flags AND trim(left.clean_pname) <> '',left.clean_pname,
																															if(left.nametype IN person_flags,left.cln_title + left.Cln_fname + left.cln_mname + left.cln_lname + left.cln_suffix,'')));
																		self.company_name	:= if(left.nametype = 'I' and left.gender = 'B', StringLib.StringCleanSpaces(left.orig_name),
																														if(left.nametype IN Bus_flags, StringLib.StringCleanSpaces(left.orig_name),''));
																		self.dob					:= if(self.company_name <> '','',left.dob);
																		self              := left));
											
  export Mapping_FL_as_Search := fClean_name;
