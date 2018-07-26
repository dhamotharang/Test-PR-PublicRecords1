import Ut, DriversV2;

export NV_as_DL (dataset(DriversV2.Layout_DL_NV_In.Cleaned) in_file):=function

	layout_normAddr	:=	record
		string1		addr_type;
		unsigned3	dt_first_seen;
		unsigned3	dt_last_seen;
		unsigned3	dt_vendor_first_reported;
		unsigned3	dt_vendor_last_reported;
		string08	append_PROCESS_DATE;		
		string33	LST_NAME;
		string33 	FST_NAME;
		string33	MID_NAME;
		string10	DOB;
		string25	DLN;
		string2		PERM_CD_1;
		string2		PERM_CD_2;
		string2		PERM_CD_3;
		string2		PERM_CD_4;
		string10	EFF_DT;
		string50	Orig_Address;
		string20	Orig_City;
		string2		Orig_State;
		string5		Orig_Zip;
		string05	clean_name_prefix;
		string20	clean_name_first;
		string20	clean_name_middle;
		string20	clean_name_last;
		string05	clean_name_suffix;
		string03	clean_name_score;
		string10	clean_prim_range;
		string02	clean_predir;
		string28	clean_prim_name;
		string04	clean_addr_suffix;
		string02	clean_postdir;
		string10	clean_unit_desig;
		string08	clean_sec_range;
		string25	clean_p_city_name;
		string25	clean_v_city_name;
		string02	clean_st;
		string05	clean_zip;
		string04	clean_zip4;
		string04	clean_cart;
		string01	clean_cr_sort_sz;
		string04	clean_lot;
		string01	clean_lot_order;
		string02	clean_dpbc;
		string01	clean_chk_digit;
		string02	clean_record_type;
		string02	clean_ace_fips_st;
		string03	clean_fipscounty;
		string10	clean_geo_lat;
		string11	clean_geo_long;
		string04	clean_msa;
		string07	clean_geo_blk;
		string01	clean_geo_match;
		string04	clean_err_stat;
	end;

	layout_normPerms	:=	record
		layout_normAddr - [perm_cd_1, perm_cd_2, perm_cd_3, perm_cd_4, Eff_dt];
		string2		PERM_CD;
	end;

	layout_normAddr trfNormAddr(DriversV2.Layout_DL_NV_In.Cleaned l, integer c) := transform
		self.addr_type					:= choose(c, 'M',  									'P');	
		self.orig_Address				:= choose(c, l.m_addr,  						l.p_addr);
		self.orig_City					:= choose(c, l.m_city,  						l.p_city);
		self.orig_State					:= choose(c, l.m_state,  						l.p_state);
		self.orig_Zip						:= choose(c, l.m_zip,  							l.p_zip);
		self.clean_prim_range		:= '';
		self.clean_predir				:= '';
		self.clean_prim_name		:= '';
		self.clean_addr_suffix	:= '';
		self.clean_postdir			:= '';
		self.clean_unit_desig		:= '';
		self.clean_sec_range		:= '';
		self.clean_p_city_name	:= '';
		self.clean_v_city_name	:= '';  
		self.clean_st						:= ''; 
		self.clean_zip					:= '';
		self.clean_zip4					:= '';  
		self.clean_cart					:= '';
		self.clean_cr_sort_sz		:= '';
		self.clean_lot					:= '';
		self.clean_lot_order		:= '';
		self.clean_dpbc					:= '';  
		self.clean_chk_digit		:= '';  
		self.clean_record_type	:= '';  
		self.clean_ace_fips_st	:= '';
		self.clean_fipscounty		:= '';
		self.clean_geo_lat			:= '';
		self.clean_geo_long			:= '';
		self.clean_msa					:= '';
		self.clean_geo_blk			:= '';
		self.clean_geo_match		:= '';
		self.clean_err_stat			:= '';
		self										:= l;
	end;

	norm_file1 := normalize(in_file, 
													if(	trim(left.m_addr,left,right)  <> trim(left.p_addr,left,right)  and
															trim(left.m_city,left,right)  <> trim(left.p_city,left,right)  and
															trim(left.m_state,left,right) <> trim(left.p_state,left,right) and
															trim(left.m_zip,left,right)   <> trim(left.p_zip,left,right)   and
															trim(left.p_addr,left,right)  <> '',2,1
														),trfNormAddr(left,counter)
													);
														
	layout_normPerms trfNormPerms(norm_file1 l, integer c) := transform
		 self.perm_cd							:= choose(c, l.perm_cd_1,		l.perm_cd_2,		l.perm_cd_3,		l.perm_cd_4);	
	   self											:= l;
	end;													
														
	norm_file2 := normalize(norm_file1, 
													if (trim(left.perm_cd_2,left,right) <> '',
															if (trim(left.perm_cd_3,left,right) <> '',
																	if (trim(left.perm_cd_4,left,right) <> '',
																			4,3),
																	2),
															1),trfNormPerms(left,counter)
													);	
															
	string8 reformatDate(string10 pDateIn)	:=	StringLib.StringFilterOut(pDateIn, '-');

	DriversV2.Layout_DL_Extended lTransform_NV_To_Common(norm_file2 pInput)	:=	transform
			self.orig_state 								:=	'NV';
			self.source_code								:= 	'AD';		
			self.DateReceived								:=	(integer)pInput.append_PROCESS_DATE;
			self.name												:= 	trim(pInput.FST_NAME) + trim(' '+pInput.MID_NAME) + trim(' '+pInput.LST_NAME);		
			self.RawFullName								:= 	trim(pInput.FST_NAME) + trim(' '+pInput.MID_NAME) + trim(' '+pInput.LST_NAME);
			self.addr1											:= 	pInput.Orig_Address;
			self.city												:= 	pInput.Orig_City;
			self.state											:= 	pInput.Orig_State;
			self.zip												:= 	pInput.Orig_Zip;
			self.dob 												:= (unsigned4)pInput.DOB;
			self.license_type								:= 	pInput.Perm_cd;
			self.OrigLicenseType						:= 	pInput.Perm_cd;
			self.OrigLicenseClass						:=	'';
			self.history										:=	'U';
			self.dl_number									:= 	pInput.DLN;
			self.title 											:= 	pInput.clean_name_prefix;
			self.fname 											:= 	pInput.clean_name_first;		                             
			self.mname											:= 	pInput.clean_name_middle;		                             
			self.lname											:= 	pInput.clean_name_last;		                             
			self.name_suffix								:= 	pInput.clean_name_suffix;		                             
			self.cleaning_score							:= 	pInput.clean_name_score;		                             
			self.prim_range									:= 	pInput.clean_prim_range;		                             
			self.predir											:= 	pInput.clean_predir;		                             
			self.prim_name									:= 	pInput.clean_prim_name;		                             
			self.suffix											:= 	pInput.clean_addr_suffix;		                             
			self.postdir										:= 	pInput.clean_postdir;		                             
			self.unit_desig									:= 	pInput.clean_unit_desig;		                             
			self.sec_range									:= 	pInput.clean_sec_range;		                             
			self.p_city_name								:= 	pInput.clean_p_city_name;		                             
			self.v_city_name								:= 	pInput.clean_v_city_name;		                             
			self.st													:= 	pInput.clean_st;		                             
			self.zip5												:= 	pInput.clean_zip;		                             
			self.zip4												:= 	pInput.clean_zip4;		                             
			self.cart												:= 	pInput.clean_cart;		                             
			self.cr_sort_sz									:= 	pInput.clean_cr_sort_sz;		                             
			self.lot												:= 	pInput.clean_lot;		                             
			self.lot_order									:= 	pInput.clean_lot_order;		                             
			self.dpbc												:= 	pInput.clean_dpbc;		                             
			self.chk_digit									:= 	pInput.clean_chk_digit;		                             
			self.rec_type										:= 	pInput.clean_record_type;		                             
			self.ace_fips_st								:= 	pInput.clean_ace_fips_st;		                             
			self.county											:= 	pInput.clean_fipscounty;		                             
			self.geo_lat										:= 	pInput.clean_geo_lat;		                             
			self.geo_long										:= 	pInput.clean_geo_long;		                             
			self.msa												:= 	pInput.clean_msa;		                             
			self.geo_blk										:= 	pInput.clean_geo_blk;		                             
			self.geo_match									:= 	pInput.clean_geo_match;		                             
			self.err_stat										:= 	pInput.clean_err_stat;		                             
			self														:=	pInput;
			self														:=	[];
	end;

	nv_as_dl_mapper :=  project(norm_file2, lTransform_NV_To_Common(left));
	return nv_as_dl_mapper; 

end;
// Other builds don't do an initial dedup...the rollup downstream takes care of 
// collapsing dups. 7/30/2012

// NV_Sort := sort(NV_Transform, dl_number, name, addr1, city, license_type);

// export NV_as_DL := dedup(NV_Sort, dl_number, name, addr1, city, license_type) : persist(DriversV2.Constants.Cluster + 'Persist::DL2::DrvLic_NV_as_DL');

