import lib_stringlib, DriversV2, std;
														
string8 reformatDate(string10 pDateIn)	:=	StringLib.StringFilterOut(pDateIn, '-');

	// process each restriction code
string CharCodeAndComma(string pRestrictionCode) :=	if(trim(pRestrictionCode,right)<>'',
																													',' + trim(pRestrictionCode,right),
																													''
																											 );

DriversV2.Layout_DL_Extended lTransform_LA_To_Common(DriversV2.File_DL_LA_In_All pInput)	:=	transform
		self.orig_state 								:=	'LA';
		self.source_code								:= 	'AD';		
		self.DateReceived								:=	(integer)pInput.append_PROCESS_DATE;
		self.name												:= 	pInput.Name;
		self.RawFullName								:=	pInput.Name;
		self.addr1											:= 	pInput.Address;
		self.city												:= 	pInput.City;
		self.state											:= 	pInput.State;
		self.zip												:= 	pInput.ZipCode;
		self.Race												:=	pInput.Race;
		self.Sex_Flag										:=	pInput.Gender;
		self.Height											:=	pInput.Height;
		self.Weight											:=	pInput.Weight;
		self.Restrictions								:=	pInput.Restriction1 + pInput.Restriction2 + pInput.Restriction3;
		self.Restrictions_delimited			:=	trim(pInput.Restriction1,right) +
																						CharCodeAndComma(pInput.Restriction2) + 
																						CharCodeAndComma(pInput.Restriction3); 
		self.license_class							:=	pInput.LicenseClass;
		self.expiration_date						:=	(unsigned4)pInput.ExpirationDate;
		self.history										:=	if ((unsigned4)pInput.ExpirationDate > 0 and (unsigned4)pInput.ExpirationDate < (unsigned4)Std.Date.Today(),
																							'E',
																							'U'
																						);
		self.license_type								:=	pInput.LicenseType;
		self.OrigLicenseType						:=	pInput.LicenseType;	
		self.OrigLicenseClass						:=	pInput.LicenseClass;		
		self.lic_endorsement						:=	pInput.Endorsements;
		self.privacy_flag								:=	pInput.PrivacyFlag;				
		self.dob 												:= (unsigned4)pInput.DOB;
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

// LA_Transform := project(DriversV2.File_DL_LA_In_All, lTransform_LA_To_Common(left));

// LA_Sort := sort(LA_Transform, dl_number, name, addr1, city, license_type);

export LA_as_DL := project(DriversV2.File_DL_LA_In_All, lTransform_LA_To_Common(left)) : persist(DriversV2.Constants.Cluster + 'Persist::DL2::DrvLic_LA_as_DL');

