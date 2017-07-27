import lib_stringlib;

Watercraft.Layout_Watercraft_Search_Base tAccurintVehicleAsSearch(Watercraft.File_Vehicles_Prod_Watercraft_Only pInput, integer1 pCounter)
 :=
  transform
	self.date_first_seen			:=	intformat(pInput.dt_first_seen,6,1);
	self.date_last_seen				:=	intformat(pInput.dt_last_seen,6,1);
	self.date_vendor_first_reported	:=	intformat(pInput.dt_vendor_first_reported,6,1);
	self.date_vendor_last_reported	:=	intformat(pInput.dt_vendor_last_reported,6,1);
	self.watercraft_key				:=	lib_stringlib.stringlib.stringfindreplace(trim(pInput.VEHICLE_NUMBERxBG1),' ','_');
	self.sequence_key				:=	if(pInput.registration_effective_date <> '',
												   pInput.registration_effective_date,
												   if(pInput.registration_expiration_date <> '',
													  pInput.registration_expiration_date,
													  if(pInput.title_issue_date <> '',
														 pInput.title_issue_date,
														 pInput.registration_number
														)
													 )
												  );
	self.state_origin				:=	pInput.orig_state;
	self.source_code				:=	'AW';
	self.dppa_flag					:=	if(pInput.orig_state in Watercraft.sDPPA_Restricted_Watercraft_States,'Y','');
	self.orig_name					:=	choose(pCounter,pInput.OWN_1_CUSTOMER_NAME,pInput.OWN_2_CUSTOMER_NAME,pInput.REG_1_CUSTOMER_NAME,pInput.REG_2_CUSTOMER_NAME);
	self.orig_name_type_code		:=	choose(pCounter,'O','O','R','R');
	self.orig_name_type_description	:=	choose(pCounter,'OWNER','OWNER','REGISTRANT','REGISTRANT');
	self.orig_name_first			:=	'';
	self.orig_name_middle			:=	'';
	self.orig_name_last				:=	'';
	self.orig_name_suffix			:=	'';
	self.orig_address_1				:=	choose(pCounter,pInput.OWN_1_STREET_ADDRESS,pInput.OWN_2_STREET_ADDRESS,pInput.reg_1_STREET_ADDRESS,pInput.reg_2_STREET_ADDRESS);
	self.orig_address_2				:=	'';
	self.orig_city					:=	choose(pCounter,pInput.own_1_CITY,pInput.own_2_CITY,pInput.reg_1_CITY,pInput.reg_2_CITY);
	self.orig_state					:=	choose(pCounter,pInput.own_1_STATE,pInput.own_2_STATE,pInput.reg_1_STATE,pInput.reg_2_STATE);
	self.orig_zip					:=	choose(pCounter,pInput.own_1_ZIP5_ZIP4_FOREIGN_POSTAL,pInput.own_2_ZIP5_ZIP4_FOREIGN_POSTAL,pInput.reg_1_ZIP5_ZIP4_FOREIGN_POSTAL,pInput.reg_2_ZIP5_ZIP4_FOREIGN_POSTAL);
	self.orig_fips					:=	choose(pCounter,pInput.own_1_RESIDENCE_COUNTY,pInput.own_2_RESIDENCE_COUNTY,pInput.reg_1_RESIDENCE_COUNTY,pInput.reg_2_RESIDENCE_COUNTY);
	self.dob						:=	choose(pCounter,pInput.own_1_DOB,pInput.own_2_DOB,pInput.reg_1_DOB,pInput.reg_2_DOB);
	self.orig_ssn					:=	'';
	self.orig_fein					:=	'';
	self.gender						:=	'';
	self.phone_1					:=	'';
	self.phone_2					:=	'';
	self.title						:=	choose(pCounter,pInput.own_1_title,pInput.own_2_title,pInput.reg_1_title,pInput.reg_2_title);
	self.fname						:=	choose(pCounter,pInput.own_1_fname,pInput.own_2_fname,pInput.reg_1_fname,pInput.reg_2_fname);
	self.mname						:=	choose(pCounter,pInput.own_1_mname,pInput.own_2_mname,pInput.reg_1_mname,pInput.reg_2_mname);
	self.lname						:=	choose(pCounter,pInput.own_1_lname,pInput.own_2_lname,pInput.reg_1_lname,pInput.reg_2_lname);
	self.name_suffix				:=	choose(pCounter,pInput.own_1_name_suffix,pInput.own_2_name_suffix,pInput.reg_1_name_suffix,pInput.reg_2_name_suffix);
	self.name_cleaning_score		:=	'';
	self.company_name				:=	choose(pCounter,pInput.own_1_company_name,pInput.own_2_company_name,pInput.reg_1_company_name,pInput.reg_2_company_name);
	self.prim_range					:=	choose(pCounter,pInput.own_1_prim_range,pInput.own_2_prim_range,pInput.reg_1_prim_range,pInput.reg_2_prim_range);
	self.predir						:=	choose(pCounter,pInput.own_1_predir,pInput.own_2_predir,pInput.reg_1_predir,pInput.reg_2_predir);
	self.prim_name					:=	choose(pCounter,pInput.own_1_prim_name,pInput.own_2_prim_name,pInput.reg_1_prim_name,pInput.reg_2_prim_name);
	self.suffix						:=	choose(pCounter,pInput.own_1_suffix,pInput.own_2_suffix,pInput.reg_1_suffix,pInput.reg_2_suffix);
	self.postdir					:=	choose(pCounter,pInput.own_1_postdir,pInput.own_2_postdir,pInput.reg_1_postdir,pInput.reg_2_postdir);
	self.unit_desig					:=	choose(pCounter,pInput.own_1_unit_desig,pInput.own_2_unit_desig,pInput.reg_1_unit_desig,pInput.reg_2_unit_desig);
	self.sec_range					:=	choose(pCounter,pInput.own_1_sec_range,pInput.own_2_sec_range,pInput.reg_1_sec_range,pInput.reg_2_sec_range);
	self.p_city_name				:=	choose(pCounter,pInput.own_1_p_city_name,pInput.own_2_p_city_name,pInput.reg_1_p_city_name,pInput.reg_2_p_city_name);
	self.v_city_name				:=	choose(pCounter,pInput.own_1_v_city_name,pInput.own_2_v_city_name,pInput.reg_1_v_city_name,pInput.reg_2_v_city_name);
	self.st							:=	choose(pCounter,pInput.own_1_state,pInput.own_2_state,pInput.reg_1_state,pInput.reg_2_state);
	self.zip5						:=	choose(pCounter,pInput.own_1_zip5,pInput.own_2_zip5,pInput.reg_1_zip5,pInput.reg_2_zip5);
	self.zip4						:=	choose(pCounter,pInput.own_1_zip4,pInput.own_2_zip4,pInput.reg_1_zip4,pInput.reg_2_zip4);
	self.county						:=	choose(pCounter,pInput.own_1_county,pInput.own_2_county,pInput.reg_1_county,pInput.reg_2_county);
	self.cart						:=	'';                                 //pInput.own_1_cart
	self.cr_sort_sz					:=	'';                                 //pInput.own_1_cr_sort_sz
	self.lot						:=	'';                                 //pInput.own_1_lot
	self.lot_order					:=	'';                                 //pInput.own_1_lot_order
	self.dpbc						:=	'';                                 //pInput.own_1_dpbc
	self.chk_digit					:=	'';                                 //pInput.own_1_chk_digit
	self.rec_type					:=	'';                                 //pInput.own_1_rec_type
	self.ace_fips_st				:=	'';                                 //pInput.own_1_ace_fips_st
	self.ace_fips_county			:=	'';                                 //pInput.own_1_ace_fips_county
	self.geo_lat					:=	choose(pCounter,pInput.own_1_geo_lat,pInput.own_2_geo_lat,pInput.reg_1_geo_lat,pInput.reg_2_geo_lat);
	self.geo_long					:=	choose(pCounter,pInput.own_1_geo_long,pInput.own_2_geo_long,pInput.reg_1_geo_long,pInput.reg_2_geo_long);
	self.msa						:=	'';                                 //pInput.own_1_msa
	self.geo_blk					:=	'';                                 //pInput.own_1_geo_blk
	self.geo_match					:=	'';                                 //pInput.own_1_geo_match
	self.err_stat					:=	'';                                 //pInput.own_1_err_stat
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	choose(pCounter,pInput.own_1_did,pInput.own_2_did,pInput.reg_1_did,pInput.reg_2_did);
	self.did_score					:=	'';                                 //pInput.own_1_did_score
	self.ssn						:=	'';
	self.history_flag				:=	'';
  end
 ;

dNormalized			:= normalize(Watercraft.File_Vehicles_Prod_Watercraft_Only,4,tAccurintVehicleAsSearch(left,counter));
dNormalizedFiltered	:= dNormalized(lname<> '' or company_name <> '');
dNormalizedDist		:= distribute(dNormalizedFiltered,hash(state_origin,watercraft_key,sequence_key));
dNormalizedSort		:= sort(dNormalizedDist,state_origin,watercraft_key,sequence_key,title,lname,fname,mname,suffix,company_name,zip5,st,p_city_name,prim_name,prim_range,local);

Watercraft.Layout_Watercraft_Search_Base	tRollupSameEntity(dNormalizedSort pLeft, dNormalizedSort pRight)
 :=
  transform
	self.orig_name_type_code		:=	if('O' in [pLeft.orig_name_type_code,pRight.orig_name_type_code],
										   if('R' in [pLeft.orig_name_type_code,pRight.orig_name_type_code],
											  'B',
											  'O'
											 ),
										   if('R' in [pLeft.orig_name_type_code,pRight.orig_name_type_code],
											  'R',
											  ' '
											 )
										  );
	self.orig_name_type_description	:=	case(self.orig_name_type_code,
											 'B' => 'OWNER-REGISTRANT',
											 'O' => 'OWNER',
											 'R' => 'REGISTRANT',
											 ' '
											);
	self							:=	pLeft;
  end
 ;

dNormalizedRolled	:= rollup(dNormalizedSort,
							  tRollupSameEntity(left,right),
							  state_origin,watercraft_key,sequence_key,title,lname,fname,mname,suffix,company_name,zip5,st,p_city_name,prim_name,prim_range,
							  local
							 );

string fRemoveUnknown(string pStringIn)
 :=	if(trim(pStringIn)='UNKNOWN',
	   '',
	   pStringIn
	  );

Watercraft.Layout_Watercraft_Search_Base	tFixUnknownAddressParts(dNormalizedRolled pInput)
 :=
  transform
	self.orig_address_1		:=	fRemoveUnknown(pInput.orig_address_1);
	self.orig_city			:=	fRemoveUnknown(pInput.orig_city);
	self.orig_zip			:=	if((unsigned8)pInput.orig_zip=0,
								   '',
								   pInput.orig_zip
								  );
	self.prim_name			:=	fRemoveUnknown(pInput.prim_name);
	self.p_city_name		:=	fRemoveUnknown(pInput.p_city_name);
	self.v_city_name		:=	fRemoveUnknown(pInput.v_city_name);
	self.zip5				:=	if((unsigned8)pInput.zip5=0,
								   '',
								   pInput.zip5
								  );
	self.zip4				:=	if((unsigned8)pInput.zip4=0,
								   '',
								   pInput.zip4
								  );
	self					:=	pInput;
  end
 ;

dNormalizedRolledWithoutUnknowns	:= project(dNormalizedRolled,tFixUnknownAddressParts(left));

export Mapping_Vehicles_as_Search := dNormalizedRolledWithoutUnknowns : persist('persist::watercraft_vehicle_as_search');
