import VehLic,Vehiclev2,address,doxie_files,Codes,watchdog,ut,VehicleCodes,header,Lib_StringLib,STD;

// validate reg dates
temp_veh_in	:=	VehicleV2.mapping_TEMP_vehicle;

//*************************************************************************************************************
//*************************************************************************************************************
// mapping registration 
string8	fFixDate(string8	pDateIn)
	:=	if((integer8)pDateIn=0,
				 '',
				 Lib_StringLib.StringLib.StringFindReplace(pDateIn,' ','0')
				);

VehicleV2.Layout_temp_module.layout_preparty	tpreparty(temp_veh_in	L)	:=
transform
	self.orig_number_of_axles					:=	L.number_of_axles;
	self.orig_net_weight							:=	L.net_weight;
	self.date_first_Seen							:=	L.dt_first_Seen;
	self.date_last_Seen 							:=	L.dt_last_Seen;
	self.date_vendor_First_Reported		:=	L.dt_vendor_First_Reported;
	self.date_vendor_Last_Reported 		:=	L.dt_vendor_last_Reported;
	self.Reg_Rollup_Count							:=	1;
	self.OWN_1_DOB										:=	fFixDate(L.OWN_1_DOB);
	self.OWN_2_DOB										:=	fFixDate(L.OWN_2_DOB);
	self.reg_1_DOB										:=	fFixDate(L.reg_1_DOB);
	self.reg_2_DOB										:=	fFixDate(L.reg_2_DOB);
	self.LH_1_DOB											:=	fFixDate(L.LH_1_DOB);
	self.LH_2_DOB											:=	fFixDate(L.LH_2_DOB);
	self.LH_3_DOB											:=	fFixDate(L.LH_3_DOB);
	self.lh_1_lien_date								:=	fFixDate(L.lh_1_lien_date);
	self.LH_2_LEIN_DATE								:=	fFixDate(L.LH_2_LEIN_DATE);
	self.lh_3_lien_date								:=	fFixDate(L.lh_3_lien_date);
	self.previous_title_issue_date		:=	fFixDate(L.previous_title_issue_date);
	self.title_issue_date							:=	fFixDate(L.title_issue_date);
	self.odometer_date								:=	fFixDate(L.odometer_date);
	self.REGISTRATION_EFFECTIVE_DATE	:=	fFixDate(L.REGISTRATION_EFFECTIVE_DATE);
	self.REGISTRATION_Expiration_DATE	:=	fFixDate(L.REGISTRATION_Expiration_DATE);

	self															:=	L;
end;

preparty	:=	project(temp_veh_in,tpreparty(left));

// only owner information available

// notes: license plate number information only go with registrant information in V2,it can not be used to do search while only owner information available.
owner_preparty	:=	preparty((reg_1_CUSTOMER_NAME = '' and reg_2_CUSTOMER_NAME = '') and (own_1_CUSTOMER_NAME <> '' or own_2_CUSTOMER_NAME <> '' or LH_1_CUSTOMER_NAME <> '' or LH_2_CUSTOMER_NAME <> '' or LH_3_CUSTOMER_NAME <> ''));

owner_preparty_dist 	:=	distribute(owner_preparty,hash(vehicle_key,iteration_key));

owner_set_sort	:=	sort(	owner_preparty_dist,                                        
													vehicle_key,
													-Iteration_Key,
													OWNER_1_CUSTOMER_TYPExBG3,
													OWN_1_FEID_SSN,
													OWN_1_CUSTOMER_NAME,
													OWN_1_DRIVER_LICENSE_NUMBER,
													OWN_1_DOB,
													OWN_1_SEX,
													own_1_ssn,
													own_1_prim_range,
													own_1_predir,
													own_1_prim_name,
													own_1_suffix,
													own_1_postdir,
													own_1_unit_desig,
													own_1_sec_range,
													own_1_state_2,
													own_1_zip5,
													OWNER_2_CUSTOMER_TYPE,
													OWN_2_FEID_SSN,
													OWN_2_CUSTOMER_NAME,
													OWN_2_DRIVER_LICENSE_NUMBER,
													OWN_2_DOB,
													OWN_2_SEX,
													own_2_ssn,
													own_2_prim_range,
													own_2_predir,
													own_2_prim_name,
													own_2_suffix,
													own_2_postdir,
													own_1_unit_desig,
													own_2_sec_range,
													own_2_state_2,
													own_2_zip5,
													TITLE_NUMBERxBG9,
													TITLE_ISSUE_DATE,
													PREVIOUS_TITLE_ISSUE_DATE,
													TITLE_STATUS_CODE,
													LH_1_LIEN_DATE,
													LEIN_HOLDER_1_CUSTOMER_TYPE,
													LH_1_FEID_SSN,
													LH_1_CUSTOMER_NAME,
													LH_1_DRIVER_LICENSE_NUMBER,
													LH_1_SEX,
													LH_2_LEIN_DATE,
													LEIN_HOLDER_2_CUSTOMER_TYPE,
													LH_2_FEID_SSN,
													LH_2_CUSTOMER_NAME,
													LH_2_DRIVER_LICENSE_NUMBER,
													LH_2_SEX,
													LH_3_LIEN_DATE,
													LEIN_HOLDER_3_CUSTOMER_TYPE,
													LH_3_FEID_SSN,
													LH_3_CUSTOMER_NAME,
													LH_3_DRIVER_LICENSE_NUMBER,
													LH_3_SEX,
													-date_vendor_first_reported,
													-TITLE_ISSUE_DATE,
													local
												);

owner_set_sort	townerrollup(owner_set_sort	L,owner_set_sort	R)	:=
transform
	self.Ttl_Earliest_Issue_Date			:=	vehiclev2.validate_date.fEarliestNonZeroDate(L.TITLE_ISSUE_DATE,R.TITLE_ISSUE_DATE);
	self.Ttl_Latest_Issue_Date  			:=	vehiclev2.validate_date.fLatestNonZeroDate(L.TITLE_ISSUE_DATE,R.TITLE_ISSUE_DATE);
	self.date_first_Seen							:=	(unsigned3)vehiclev2.validate_date.fEarliestNonZeroDate((string6)l.date_first_Seen,(string6)r.date_first_Seen);
	self.date_last_Seen 							:=	(unsigned3)vehiclev2.validate_date.fLatestNonZeroDate((string6)l.date_last_Seen, (string6)r.date_last_Seen);
	self.date_vendor_First_Reported		:=	(unsigned3)vehiclev2.validate_date.fEarliestNonZeroDate((string6)l.date_vendor_First_Reported,(string6)r.date_vendor_First_Reported);
	self.date_vendor_Last_Reported 		:=	(unsigned3)vehiclev2.validate_date.fLatestNonZeroDate((string6)l.date_vendor_Last_Reported,(string6)r.date_vendor_Last_Reported);
	self.ttl_Rollup_Count							:=	L.ttl_Rollup_Count + 1;
	self.OWN_1_FEID_SSN								:=	if((unsigned)l.OWN_1_FEID_SSN <> 0,l.OWN_1_FEID_SSN,r.OWN_1_FEID_SSN);
	self.OWN_1_DRIVER_LICENSE_NUMBER	:=	if(l.OWN_1_DRIVER_LICENSE_NUMBER <> '',l.OWN_1_DRIVER_LICENSE_NUMBER,r.OWN_1_DRIVER_LICENSE_NUMBER);
	self.OWN_1_DOB										:=	if(l.OWN_1_DOB <> '',l.OWN_1_DOB,r.OWN_1_DOB);
	self.OWN_1_SEX										:=	if(l.OWN_1_SEX <> '',l.OWN_1_SEX,r.OWN_1_SEX);
	self.own_1_ssn										:=	if((unsigned)l.OWN_1_ssn <> 0,l.OWN_1_SSN,r.own_1_ssn);
	self.OWN_2_FEID_SSN								:=	if((unsigned)l.OWN_2_FEID_SSN <> 0,l.OWN_2_FEID_SSN,r.OWN_2_FEID_SSN);
	self.OWN_2_DRIVER_LICENSE_NUMBER	:=	if(l.OWN_2_DRIVER_LICENSE_NUMBER <> '',l.OWN_2_DRIVER_LICENSE_NUMBER,r.OWN_2_DRIVER_LICENSE_NUMBER);
	self.OWN_2_DOB										:=	if(l.OWN_2_DOB <> '',l.OWN_2_DOB,r.OWN_2_DOB);
	self.OWN_2_SEX										:=	if(l.OWN_2_SEX <> '',l.OWN_2_SEX,r.OWN_2_SEX);
	self.own_2_ssn										:=	if((unsigned)l.OWN_2_ssn <> 0,l.OWN_2_SSN,r.own_2_ssn);
	self.TITLE_ISSUE_DATE							:=	if(L.TITLE_ISSUE_DATE <> '',L.TITLE_ISSUE_DATE,r.TITLE_ISSUE_DATE);
	self.PREVIOUS_TITLE_ISSUE_DATE		:=	if(L.PREVIOUS_TITLE_ISSUE_DATE <> '',L.PREVIOUS_TITLE_ISSUE_DATE,r.PREVIOUS_TITLE_ISSUE_DATE);
	self.LH_1_LIEN_DATE								:=	if(l.LH_1_LIEN_DATE <> '',l.LH_1_LIEN_DATE,r.LH_1_LIEN_DATE);
	self.LH_1_FEID_SSN								:=	if((unsigned)L.LH_1_FEID_SSN <> 0,L.LH_1_FEID_SSN,r.LH_1_FEID_SSN);
	self.LH_1_DRIVER_LICENSE_NUMBER		:=	if(l.LH_1_DRIVER_LICENSE_NUMBER <> '',l.LH_1_DRIVER_LICENSE_NUMBER,r.LH_1_DRIVER_LICENSE_NUMBER);
	self.LH_1_SEX											:=	if(L.LH_1_SEX <> '',L.LH_1_SEX,r.LH_1_SEX);
	self.LH_2_LEIN_DATE								:=	if(l.LH_2_LEIN_DATE <> '',l.LH_2_LEIN_DATE,r.LH_2_LEIN_DATE);
	self.LH_2_FEID_SSN								:=	if((unsigned)L.LH_2_FEID_SSN <> 0,L.LH_2_FEID_SSN,r.LH_2_FEID_SSN);
	self.LH_2_DRIVER_LICENSE_NUMBER		:=	if(l.LH_2_DRIVER_LICENSE_NUMBER <> '',l.LH_2_DRIVER_LICENSE_NUMBER,r.LH_2_DRIVER_LICENSE_NUMBER);
	self.LH_2_SEX											:=	if(L.LH_2_SEX <> '',L.LH_2_SEX,r.LH_2_SEX);
	self.LH_3_LIEN_DATE								:=	if(l.LH_3_LIEN_DATE <> '',l.LH_3_LIEN_DATE,r.LH_3_LIEN_DATE);
	self.LH_3_FEID_SSN								:=	if((unsigned)L.LH_3_FEID_SSN <> 0,L.LH_3_FEID_SSN,r.LH_3_FEID_SSN);
	self.LH_3_DRIVER_LICENSE_NUMBER		:=	if(l.LH_3_DRIVER_LICENSE_NUMBER <> '',l.LH_3_DRIVER_LICENSE_NUMBER,r.LH_3_DRIVER_LICENSE_NUMBER);
	self.LH_3_SEX											:=	if(L.LH_3_SEX <> '',L.LH_3_SEX,r.LH_3_SEX);
	self.source_rec_id            		:=  if(L.source_rec_id < R.source_rec_id, L.source_rec_id, R.source_rec_id);
	
	self															:=	L;
end;

owner_set_rollup	:=	rollup(	owner_set_sort,						  
																	left.vehicle_key = right.vehicle_key
															and left.Iteration_Key = right.Iteration_Key
															and left.OWNER_1_CUSTOMER_TYPExBG3 = right.OWNER_1_CUSTOMER_TYPExBG3
															and ut.NNEQ_SSN(left.OWN_1_FEID_SSN,right.OWN_1_FEID_SSN)
															and left.OWN_1_CUSTOMER_NAME = right.OWN_1_CUSTOMER_NAME
															and ut.NNEQ(left.OWN_1_DRIVER_LICENSE_NUMBER,right.OWN_1_DRIVER_LICENSE_NUMBER)
															and ut.NNEQ(left.OWN_1_DOB,right.OWN_1_DOB)
															and ut.NNEQ(left.OWN_1_SEX,right.OWN_1_SEX)
															and ut.NNEQ_SSN(left.own_1_ssn,right.own_1_ssn)
															and left.own_1_prim_range = right.own_1_prim_range
															and left.own_1_predir = right.own_1_predir
															and left.own_1_prim_name = right.own_1_prim_name
															and left.own_1_suffix = right.own_1_suffix
															and left.own_1_postdir = right.own_1_postdir
															and left.own_1_unit_desig = right.own_1_unit_desig
															and left.own_1_sec_range = right.own_1_sec_range
															and left.own_1_state_2 = right.own_1_state_2
															and left.own_1_zip5 = right.own_1_zip5
															and left.OWNER_2_CUSTOMER_TYPE = right.OWNER_2_CUSTOMER_TYPE
															and ut.NNEQ_SSN(left.OWN_2_FEID_SSN,right.OWN_2_FEID_SSN)
															and left.OWN_2_CUSTOMER_NAME = right.OWN_2_CUSTOMER_NAME
															and ut.NNEQ(left.OWN_2_DRIVER_LICENSE_NUMBER,right.OWN_2_DRIVER_LICENSE_NUMBER)
															and ut.NNEQ(left.OWN_2_DOB,right.OWN_2_DOB)
															and ut.NNEQ(left.OWN_2_SEX,right.OWN_2_SEX)
															and ut.NNEQ_SSN(left.own_2_ssn,right.own_2_ssn)
															and left.own_2_prim_range = right.own_2_prim_range
															and left.own_2_predir = right.own_2_predir
															and left.own_2_prim_name = right.own_2_prim_name
															and left.own_2_suffix = right.own_2_suffix
															and left.own_2_postdir = right.own_2_postdir
															and left.own_2_unit_desig = right.own_2_unit_desig
															and left.own_2_sec_range = right.own_2_sec_range
															and left.own_2_state_2 = right.own_2_state_2
															and left.own_2_zip5 = right.own_2_zip5
															and left.TITLE_NUMBERxBG9 = right.TITLE_NUMBERxBG9
															and ut.nneq(left.TITLE_ISSUE_DATE,right.TITLE_ISSUE_DATE)
															and ut.nneq(left.PREVIOUS_TITLE_ISSUE_DATE,right.PREVIOUS_TITLE_ISSUE_DATE)
															and left.TITLE_STATUS_CODE = right.TITLE_STATUS_CODE
															and ut.nneq(left.LH_1_LIEN_DATE,right.LH_1_LIEN_DATE)
															and left.LEIN_HOLDER_1_CUSTOMER_TYPE = right.LEIN_HOLDER_1_CUSTOMER_TYPE
															and ut.nneq_SSN(left.LH_1_FEID_SSN,right.LH_1_FEID_SSN)
															and left.LH_1_CUSTOMER_NAME = right.LH_1_CUSTOMER_NAME
															and ut.nneq(left.LH_1_DRIVER_LICENSE_NUMBER,right.LH_1_DRIVER_LICENSE_NUMBER)
															and ut.nneq(left.LH_1_SEX,right.LH_1_SEX)
															and ut.nneq(left.LH_2_LEIN_DATE,right.LH_2_LEIN_DATE)
															and left.LEIN_HOLDER_2_CUSTOMER_TYPE = right.LEIN_HOLDER_2_CUSTOMER_TYPE
															and ut.nneq_SSN(left.LH_2_FEID_SSN,right.LH_2_FEID_SSN)
															and left.LH_2_CUSTOMER_NAME = right.LH_2_CUSTOMER_NAME
															and ut.nneq(left.LH_2_DRIVER_LICENSE_NUMBER,right.LH_2_DRIVER_LICENSE_NUMBER)
															and ut.nneq(left.LH_2_SEX,right.LH_2_SEX)
															and ut.nneq(left.LH_3_LIEN_DATE,right.LH_3_LIEN_DATE)
															and left.LEIN_HOLDER_3_CUSTOMER_TYPE = right.LEIN_HOLDER_3_CUSTOMER_TYPE
															and ut.nneq_SSN(left.LH_3_FEID_SSN,right.LH_3_FEID_SSN)
															and left.LH_3_CUSTOMER_NAME = right.LH_3_CUSTOMER_NAME
															and ut.nneq(left.LH_3_DRIVER_LICENSE_NUMBER,right.LH_3_DRIVER_LICENSE_NUMBER)
															and left.LH_3_SEX = right.LH_3_SEX,
															townerrollup(left,right),
															local
														);

//only registrants information available 
reg_preparty			:=	preparty((reg_1_CUSTOMER_NAME <>'' or reg_2_CUSTOMER_NAME <>'') and (own_1_CUSTOMER_NAME = '' and own_2_CUSTOMER_NAME = '' and LH_1_CUSTOMER_NAME = '' and LH_2_CUSTOMER_NAME = '' and LH_3_CUSTOMER_NAME = ''));
reg_preparty_dist :=	distribute(reg_preparty,hash(vehicle_key,iteration_key));
reg_set_sort			:=	sort(	reg_preparty_dist,                                        
														vehicle_key,
														-Iteration_Key,
														REGISTRANT_1_CUSTOMER_TYPExBG5,    
														REG_1_FEID_SSN,                    
														REG_1_CUSTOMER_NAME,               
														REG_1_DRIVER_LICENSE_NUMBER,       
														REG_1_DOB,                         
														REG_1_SEX,
														reg_1_ssn,
														REG_1_prim_range,
														REG_1_predir,
														REG_1_prim_name,
														REG_1_suffix,
														REG_1_postdir,
														REG_1_unit_desig,
														REG_1_sec_range,
														REG_1_state_2,
														REG_1_zip5,           
														REGISTRANT_2_CUSTOMER_TYPE,        
														REG_2_FEID_SSN,                    
														REG_2_CUSTOMER_NAME,               
														REG_2_DRIVER_LICENSE_NUMBER,       
														REG_2_DOB,                         
														REG_2_SEX, 
														reg_2_ssn,
														REG_2_prim_range,
														REG_2_predir,
														REG_2_prim_name,
														REG_2_suffix,
														REG_2_postdir,
														REG_2_unit_desig,
														REG_2_sec_range,
														REG_2_state_2,
														REG_2_zip5,
														LICENSE_PLATE_NUMBERxBG4,
														REGISTRATION_STATUS_CODE,
														LICENSE_PLATE_CODE,
														TRUE_LICENSE_PLSTE_NUMBER,
														-date_vendor_first_reported,
														-REGISTRATION_EFFECTIVE_DATE,
														-REGISTRATION_Expiration_DATE,
														local
													);
													
reg_set_sort	tregrollup(reg_set_sort	L,reg_set_sort	R)	:=
transform
	self.Reg_Earliest_Effective_Date	:=	vehiclev2.validate_date.fEarliestNonZeroDate(L.REGISTRATION_EFFECTIVE_DATE,R.REGISTRATION_EFFECTIVE_DATE);
	self.Reg_Latest_Effective_Date  	:=	vehiclev2.validate_date.fLatestNonZeroDate(L.REGISTRATION_EFFECTIVE_DATE,R.REGISTRATION_EFFECTIVE_DATE);
	self.Reg_Latest_Expiration_Date 	:=	vehiclev2.validate_date.fLatestNonZeroDate(L.REGISTRATION_EXPIRATION_DATE,R.REGISTRATION_EXPIRATION_DATE);
	self.Reg_Rollup_Count							:=	L.Reg_Rollup_Count + 1;
	self.decal_number									:=	if(L.REGISTRATION_EFFECTIVE_DATE > R.REGISTRATION_EFFECTIVE_DATE,L.decal_number,R.decal_number);
	self.date_first_Seen							:=	(unsigned3)vehiclev2.validate_date.fEarliestNonZeroDate((string6)l.date_first_Seen,(string6)r.date_first_Seen);
	self.date_last_Seen 							:=	(unsigned3)vehiclev2.validate_date.fLatestNonZeroDate((string6)l.date_last_Seen, (string6)r.date_last_Seen);
	self.date_vendor_First_Reported		:=	(unsigned3)vehiclev2.validate_date.fEarliestNonZeroDate((string6)l.date_vendor_First_Reported,(string6)r.date_vendor_First_Reported);
	self.date_vendor_Last_Reported 		:=	(unsigned3)vehiclev2.validate_date.fLatestNonZeroDate((string6)l.date_vendor_Last_Reported,(string6)r.date_vendor_Last_Reported);
	self.REG_1_FEID_SSN								:=	if((unsigned)l.REG_1_FEID_SSN <> 0,l.REG_1_FEID_SSN,r.REG_1_FEID_SSN);
	self.REG_1_DRIVER_LICENSE_NUMBER	:=	if(l.REG_1_DRIVER_LICENSE_NUMBER <> '',l.REG_1_DRIVER_LICENSE_NUMBER,r.REG_1_DRIVER_LICENSE_NUMBER);
	self.REG_1_DOB										:=	if(l.REG_1_DOB <> '',l.REG_1_DOB,r.REG_1_DOB);
	self.REG_1_SEX										:=	if(l.REG_1_SEX <> '',l.REG_1_SEX,r.REG_1_SEX);
	self.REG_1_ssn										:=	if((unsigned)l.REG_1_ssn <> 0,l.REG_1_SSN,r.REG_1_ssn);
	self.REG_2_FEID_SSN								:=	if((unsigned)l.REG_2_FEID_SSN <> 0,l.REG_2_FEID_SSN,r.REG_2_FEID_SSN);
	self.REG_2_DRIVER_LICENSE_NUMBER	:=	if(l.REG_2_DRIVER_LICENSE_NUMBER <> '',l.REG_2_DRIVER_LICENSE_NUMBER,r.REG_2_DRIVER_LICENSE_NUMBER);
	self.REG_2_DOB										:=	if(l.REG_2_DOB <> '',l.REG_2_DOB,r.REG_2_DOB);
	self.REG_2_SEX										:=	if(l.REG_2_SEX <> '',l.REG_2_SEX,r.REG_2_SEX);
	self.REG_2_ssn										:=	if((unsigned)l.REG_2_ssn <> 0,l.REG_2_SSN,r.REG_2_ssn);
	self.LICENSE_PLATE_NUMBERxBG4			:=	if(L.LICENSE_PLATE_NUMBERxBG4 <> '',L.LICENSE_PLATE_NUMBERxBG4,r.LICENSE_PLATE_NUMBERxBG4);
	self.TRUE_LICENSE_PLSTE_NUMBER		:=	if(L.TRUE_LICENSE_PLSTE_NUMBER <> '',L.TRUE_LICENSE_PLSTE_NUMBER,r.TRUE_LICENSE_PLSTE_NUMBER);
	self.source_rec_id            		:=  if(L.source_rec_id < R.source_rec_id, L.source_rec_id, R.source_rec_id);

	self															:=	L;
end;

reg_set_rollup	:=	rollup(	reg_set_sort,						  
																Header.ConvertYYYYMMToNumberOfMonths((integer)Right.REGISTRATION_EFFECTIVE_DATE) < Header.ConvertYYYYMMToNumberOfMonths((integer)Left.REGISTRATION_EXPIRATION_DATE) + 2
														and left.vehicle_key = right.vehicle_key
														and left.Iteration_Key = right.Iteration_Key
														and left.REGISTRANT_1_CUSTOMER_TYPExBG5 = right.REGISTRANT_1_CUSTOMER_TYPExBG5
														and ut.nneq_SSN(left.REG_1_FEID_SSN,right.REG_1_FEID_SSN)
														and left.REG_1_CUSTOMER_NAME = right.REG_1_CUSTOMER_NAME 
														and ut.nneq(left.REG_1_DRIVER_LICENSE_NUMBER,right.REG_1_DRIVER_LICENSE_NUMBER)
														and ut.nneq(left.REG_1_DOB,right.REG_1_DOB)
														and ut.nneq(left.reg_1_sex,right.reg_1_sex)
														and ut.nneq_SSN(left.reg_1_ssn,right.reg_1_ssn)
														and left.reg_1_prim_range = right.reg_1_prim_range
														and left.reg_1_predir = right.reg_1_predir
														and left.reg_1_prim_name = right.reg_1_prim_name
														and left.reg_1_suffix = right.reg_1_suffix
														and left.reg_1_postdir = right.reg_1_postdir
														and left.reg_1_unit_desig = right.reg_1_unit_desig
														and left.reg_1_sec_range = right.reg_1_sec_range
														and left.reg_1_state_2 = right.reg_1_state_2
														and left.reg_1_zip5 = right.reg_1_zip5
														and left.REGISTRANT_2_CUSTOMER_TYPE = right.REGISTRANT_2_CUSTOMER_TYPE
														and ut.nneq_SSN(left.REG_2_FEID_SSN,right.REG_2_FEID_SSN)
														and left.REG_2_CUSTOMER_NAME = right.REG_2_CUSTOMER_NAME 
														and ut.nneq(left.REG_2_DRIVER_LICENSE_NUMBER,right.REG_2_DRIVER_LICENSE_NUMBER)
														and ut.nneq(left.REG_2_DOB,right.REG_2_DOB)
														and ut.nneq(left.reg_2_sex,right.reg_2_sex)
														and ut.nneq_SSN(left.reg_2_ssn,right.reg_2_ssn)
														and left.reg_2_prim_range = right.reg_2_prim_range
														and left.reg_2_predir = right.reg_2_predir
														and left.reg_2_prim_name = right.reg_2_prim_name
														and left.reg_2_suffix = right.reg_2_suffix
														and left.reg_2_postdir = right.reg_2_postdir
														and left.reg_2_unit_desig = right.reg_2_unit_desig
														and left.reg_2_sec_range = right.reg_2_sec_range
														and left.reg_2_state_2 = right.reg_2_state_2
														and left.reg_2_zip5 = right.reg_2_zip5
														and ut.NNEQ(left.LICENSE_PLATE_NUMBERxBG4,right.LICENSE_PLATE_NUMBERxBG4)
														and left.REGISTRATION_STATUS_CODE = right.REGISTRATION_STATUS_CODE
														and ut.NNEQ(left.TRUE_LICENSE_PLSTE_NUMBER,right.TRUE_LICENSE_PLSTE_NUMBER)
														and left.LICENSE_PLATE_CODE = right.LICENSE_PLATE_CODE,
														tregrollup(left,right),
														local
													);

//registrants and owners information all available
reg_owner_preparty			:=	preparty((reg_1_CUSTOMER_NAME <> '' or reg_2_CUSTOMER_NAME <> '') and (own_1_CUSTOMER_NAME <> '' or own_2_CUSTOMER_NAME <> '' or LH_1_CUSTOMER_NAME <> '' or LH_2_CUSTOMER_NAME <> '' or LH_3_CUSTOMER_NAME <> ''));
reg_owner_preparty_dist :=	distribute(reg_owner_preparty,hash(vehicle_key,iteration_key));

reg_owner_set_sort	:=	sort(	reg_owner_preparty_dist,                                        
                              vehicle_key,
								              -Iteration_Key,
															OWNER_1_CUSTOMER_TYPExBG3,
															OWN_1_FEID_SSN,
															OWN_1_CUSTOMER_NAME,
															OWN_1_DRIVER_LICENSE_NUMBER,
															OWN_1_DOB,
															OWN_1_SEX,
															own_1_ssn,
															own_1_prim_range,
															own_1_predir,
															own_1_prim_name,
															own_1_suffix,
															own_1_postdir,
															own_1_unit_desig,
															own_1_sec_range,
															own_1_state_2,
															own_1_zip5,
															OWNER_2_CUSTOMER_TYPE,
															OWN_2_FEID_SSN,
															OWN_2_CUSTOMER_NAME,
															OWN_2_DRIVER_LICENSE_NUMBER,
															OWN_2_DOB,
															OWN_2_SEX,
															own_2_ssn,
															own_2_prim_range,
															own_2_predir,
															own_2_prim_name,
															own_2_suffix,
															own_2_postdir,
															own_1_unit_desig,
															own_2_sec_range,
															own_2_state_2,
															own_2_zip5,
															TITLE_NUMBERxBG9,
															TITLE_ISSUE_DATE,
															PREVIOUS_TITLE_ISSUE_DATE,
															TITLE_STATUS_CODE,
															LH_1_LIEN_DATE,
															LEIN_HOLDER_1_CUSTOMER_TYPE,
															LH_1_FEID_SSN,
															LH_1_CUSTOMER_NAME,
															LH_1_DRIVER_LICENSE_NUMBER,
															LH_1_SEX,
															LH_2_LEIN_DATE,
															LEIN_HOLDER_2_CUSTOMER_TYPE,
															LH_2_FEID_SSN,
															LH_2_CUSTOMER_NAME,
															LH_2_DRIVER_LICENSE_NUMBER,
															LH_2_SEX,
															LH_3_LIEN_DATE,
															LEIN_HOLDER_3_CUSTOMER_TYPE,
															LH_3_FEID_SSN,
															LH_3_CUSTOMER_NAME,
															LH_3_DRIVER_LICENSE_NUMBER,
															LH_3_SEX,      
															REGISTRANT_1_CUSTOMER_TYPExBG5,    
															REG_1_FEID_SSN,                    
															REG_1_CUSTOMER_NAME,               
															REG_1_DRIVER_LICENSE_NUMBER,       
															REG_1_DOB,                         
															REG_1_SEX,
															reg_1_ssn,
															REG_1_prim_range,
															REG_1_predir,
															REG_1_prim_name,
															REG_1_suffix,
															REG_1_postdir,
															REG_1_unit_desig,
															REG_1_sec_range,
															REG_1_state_2,
															REG_1_zip5,            
															REGISTRANT_2_CUSTOMER_TYPE,        
															REG_2_FEID_SSN,                    
															REG_2_CUSTOMER_NAME,               
															REG_2_DRIVER_LICENSE_NUMBER,       
															REG_2_DOB,                         
															REG_2_SEX, 
															reg_2_ssn,
															REG_2_prim_range,
															REG_2_predir,
															REG_2_prim_name,
															REG_2_suffix,
															REG_2_postdir,
															REG_2_unit_desig,
															REG_2_sec_range,
															REG_2_state_2,
															REG_2_zip5,
															LICENSE_PLATE_NUMBERxBG4,
															REGISTRATION_STATUS_CODE,
															LICENSE_PLATE_CODE,
															TRUE_LICENSE_PLSTE_NUMBER,
															-date_vendor_first_reported,
															-REGISTRATION_EFFECTIVE_DATE,
															-REGISTRATION_Expiration_DATE,
															-TITLE_ISSUE_DATE,
															local
														);

reg_owner_set_sort	tregownerrollup(reg_owner_set_sort	L,reg_owner_set_sort	R)	:=
transform
	self.Ttl_Earliest_Issue_Date			:=	vehiclev2.validate_date.fEarliestNonZeroDate(L.TITLE_ISSUE_DATE,R.TITLE_ISSUE_DATE);
	self.Ttl_Latest_Issue_Date  			:=	vehiclev2.validate_date.fLatestNonZeroDate(L.TITLE_ISSUE_DATE,R.TITLE_ISSUE_DATE);
	self.Reg_Earliest_Effective_Date	:=	vehiclev2.validate_date.fEarliestNonZeroDate(L.REGISTRATION_EFFECTIVE_DATE,R.REGISTRATION_EFFECTIVE_DATE);
	self.Reg_Latest_Effective_Date  	:=	vehiclev2.validate_date.fLatestNonZeroDate(L.REGISTRATION_EFFECTIVE_DATE,R.REGISTRATION_EFFECTIVE_DATE);
	self.Reg_Latest_Expiration_Date 	:=	vehiclev2.validate_date.fLatestNonZeroDate(L.REGISTRATION_EXPIRATION_DATE,R.REGISTRATION_EXPIRATION_DATE);
	self.Reg_Rollup_Count							:=	L.Reg_Rollup_Count + 1;
	self.decal_number									:=	if(L.REGISTRATION_EFFECTIVE_DATE > R.REGISTRATION_EFFECTIVE_DATE,L.decal_number,R.decal_number);
	self.date_first_Seen							:=	(unsigned3)vehiclev2.validate_date.fEarliestNonZeroDate((string6)l.date_first_Seen,(string6)r.date_first_Seen);
	self.date_last_Seen 							:=	(unsigned3)vehiclev2.validate_date.fLatestNonZeroDate((string6)l.date_last_Seen, (string6)r.date_last_Seen);
	self.date_vendor_First_Reported		:=	(unsigned3)vehiclev2.validate_date.fEarliestNonZeroDate((string6)l.date_vendor_First_Reported,(string6)r.date_vendor_First_Reported);
	self.date_vendor_Last_Reported 		:=	(unsigned3)vehiclev2.validate_date.fLatestNonZeroDate((string6)l.date_vendor_Last_Reported,(string6)r.date_vendor_Last_Reported);
	self.OWN_1_FEID_SSN								:=	if((unsigned)l.OWN_1_FEID_SSN <> 0,l.OWN_1_FEID_SSN,r.OWN_1_FEID_SSN);
	self.OWN_1_DRIVER_LICENSE_NUMBER	:=	if(l.OWN_1_DRIVER_LICENSE_NUMBER <> '',l.OWN_1_DRIVER_LICENSE_NUMBER,r.OWN_1_DRIVER_LICENSE_NUMBER);
	self.OWN_1_DOB										:=	if(l.OWN_1_DOB <> '',l.OWN_1_DOB,r.OWN_1_DOB);
	self.OWN_1_SEX										:=	if(l.OWN_1_SEX <> '',l.OWN_1_SEX,r.OWN_1_SEX);
	self.own_1_ssn										:=	if((unsigned)l.OWN_1_ssn <> 0,l.OWN_1_SSN,r.own_1_ssn);
	self.OWN_2_FEID_SSN								:=	if((unsigned)l.OWN_2_FEID_SSN <> 0,l.OWN_2_FEID_SSN,r.OWN_2_FEID_SSN);
	self.OWN_2_DRIVER_LICENSE_NUMBER	:=	if(l.OWN_2_DRIVER_LICENSE_NUMBER <> '',l.OWN_2_DRIVER_LICENSE_NUMBER,r.OWN_2_DRIVER_LICENSE_NUMBER);
	self.OWN_2_DOB										:=	if(l.OWN_2_DOB <> '',l.OWN_2_DOB,r.OWN_2_DOB);
	self.OWN_2_SEX										:=	if(l.OWN_2_SEX <> '',l.OWN_2_SEX,r.OWN_2_SEX);
	self.own_2_ssn										:=	if((unsigned)l.OWN_2_ssn <> 0,l.OWN_2_SSN,r.own_2_ssn);
	self.TITLE_ISSUE_DATE							:=	if(L.TITLE_ISSUE_DATE <> '',L.TITLE_ISSUE_DATE,r.TITLE_ISSUE_DATE);
	self.PREVIOUS_TITLE_ISSUE_DATE		:=	if(L.PREVIOUS_TITLE_ISSUE_DATE <> '',L.PREVIOUS_TITLE_ISSUE_DATE,r.PREVIOUS_TITLE_ISSUE_DATE);
	self.LH_1_LIEN_DATE								:=	if(l.LH_1_LIEN_DATE <> '',l.LH_1_LIEN_DATE,r.LH_1_LIEN_DATE);
	self.LH_1_FEID_SSN								:=	if((unsigned)L.LH_1_FEID_SSN <> 0,L.LH_1_FEID_SSN,r.LH_1_FEID_SSN);
	self.LH_1_DRIVER_LICENSE_NUMBER		:=	if(l.LH_1_DRIVER_LICENSE_NUMBER <> '',l.LH_1_DRIVER_LICENSE_NUMBER,r.LH_1_DRIVER_LICENSE_NUMBER);
	self.LH_1_SEX											:=	if(L.LH_1_SEX <> '',L.LH_1_SEX,r.LH_1_SEX);
	self.LH_2_LEIN_DATE								:=	if(l.LH_2_LEIN_DATE <> '',l.LH_2_LEIN_DATE,r.LH_2_LEIN_DATE);
	self.LH_2_FEID_SSN								:=	if((unsigned)L.LH_2_FEID_SSN <> 0,L.LH_2_FEID_SSN,r.LH_2_FEID_SSN);
	self.LH_2_DRIVER_LICENSE_NUMBER		:=	if(l.LH_2_DRIVER_LICENSE_NUMBER <> '',l.LH_2_DRIVER_LICENSE_NUMBER,r.LH_2_DRIVER_LICENSE_NUMBER);
	self.LH_2_SEX											:=	if(L.LH_2_SEX <> '',L.LH_2_SEX,r.LH_2_SEX);
	self.LH_3_LIEN_DATE								:=	if(l.LH_3_LIEN_DATE <> '',l.LH_3_LIEN_DATE,r.LH_3_LIEN_DATE);
	self.LH_3_FEID_SSN								:=	if((unsigned)L.LH_3_FEID_SSN <> 0,L.LH_3_FEID_SSN,r.LH_3_FEID_SSN);
	self.LH_3_DRIVER_LICENSE_NUMBER		:=	if(l.LH_3_DRIVER_LICENSE_NUMBER <> '',l.LH_3_DRIVER_LICENSE_NUMBER,r.LH_3_DRIVER_LICENSE_NUMBER);
	self.LH_3_SEX											:=	if(L.LH_3_SEX <> '',L.LH_3_SEX,r.LH_3_SEX);
	self.REG_1_FEID_SSN								:=	if((unsigned)l.REG_1_FEID_SSN <> 0,l.REG_1_FEID_SSN,r.REG_1_FEID_SSN);
	self.REG_1_DRIVER_LICENSE_NUMBER	:=	if(l.REG_1_DRIVER_LICENSE_NUMBER <> '',l.REG_1_DRIVER_LICENSE_NUMBER,r.REG_1_DRIVER_LICENSE_NUMBER);
	self.REG_1_DOB										:=	if(l.REG_1_DOB <> '',l.REG_1_DOB,r.REG_1_DOB);
	self.REG_1_SEX										:=	if(l.REG_1_SEX <> '',l.REG_1_SEX,r.REG_1_SEX);
	self.REG_1_ssn										:=	if((unsigned)l.REG_1_ssn <> 0,l.REG_1_SSN,r.REG_1_ssn);
	self.REG_2_FEID_SSN								:=	if((unsigned)l.REG_2_FEID_SSN <> 0,l.REG_2_FEID_SSN,r.REG_2_FEID_SSN);
	self.REG_2_DRIVER_LICENSE_NUMBER	:=	if(l.REG_2_DRIVER_LICENSE_NUMBER <> '',l.REG_2_DRIVER_LICENSE_NUMBER,r.REG_2_DRIVER_LICENSE_NUMBER);
	self.REG_2_DOB										:=	if(l.REG_2_DOB <> '',l.REG_2_DOB,r.REG_2_DOB);
	self.REG_2_SEX										:=	if(l.REG_2_SEX <> '',l.REG_2_SEX,r.REG_2_SEX);
	self.REG_2_ssn										:=	if((unsigned)l.REG_2_ssn <> 0,l.REG_2_SSN,r.REG_2_ssn);
	self.LICENSE_PLATE_NUMBERxBG4			:=	if(L.LICENSE_PLATE_NUMBERxBG4 <> '',L.LICENSE_PLATE_NUMBERxBG4,r.LICENSE_PLATE_NUMBERxBG4);
	self.TRUE_LICENSE_PLSTE_NUMBER		:=	if(L.TRUE_LICENSE_PLSTE_NUMBER <> '',L.TRUE_LICENSE_PLSTE_NUMBER,r.TRUE_LICENSE_PLSTE_NUMBER);
	self.source_rec_id            		:=  if(L.source_rec_id < R.source_rec_id, L.source_rec_id, R.source_rec_id);

	self	:=	L;
end;

reg_owner_set_rollup	:=	rollup(	reg_owner_set_sort,						  
																			Header.ConvertYYYYMMToNumberOfMonths((integer)Right.REGISTRATION_EFFECTIVE_DATE) < Header.ConvertYYYYMMToNumberOfMonths((integer)Left.REGISTRATION_EXPIRATION_DATE) + 2
																	and left.vehicle_key = right.vehicle_key
																	and left.Iteration_Key = right.Iteration_Key
																	and left.OWNER_1_CUSTOMER_TYPExBG3 = right.OWNER_1_CUSTOMER_TYPExBG3
																	and ut.NNEQ_SSN(left.OWN_1_FEID_SSN,right.OWN_1_FEID_SSN)
																	and left.OWN_1_CUSTOMER_NAME = right.OWN_1_CUSTOMER_NAME
																	and ut.NNEQ(left.OWN_1_DRIVER_LICENSE_NUMBER,right.OWN_1_DRIVER_LICENSE_NUMBER)
																	and ut.NNEQ(left.OWN_1_DOB,right.OWN_1_DOB)
																	and ut.NNEQ(left.OWN_1_SEX,right.OWN_1_SEX)
																	and ut.NNEQ_SSN(left.own_1_ssn,right.own_1_ssn)
																	and left.own_1_prim_range = right.own_1_prim_range
																	and left.own_1_predir = right.own_1_predir
																	and left.own_1_prim_name = right.own_1_prim_name
																	and left.own_1_suffix = right.own_1_suffix
																	and left.own_1_postdir = right.own_1_postdir
																	and left.own_1_unit_desig = right.own_1_unit_desig
																	and left.own_1_sec_range = right.own_1_sec_range
																	and left.own_1_state_2 = right.own_1_state_2
																	and left.own_1_zip5 = right.own_1_zip5
																	and left.OWNER_2_CUSTOMER_TYPE = right.OWNER_2_CUSTOMER_TYPE
																	and ut.NNEQ_SSN(left.OWN_2_FEID_SSN,right.OWN_2_FEID_SSN)
																	and left.OWN_2_CUSTOMER_NAME = right.OWN_2_CUSTOMER_NAME
																	and ut.NNEQ(left.OWN_2_DRIVER_LICENSE_NUMBER,right.OWN_2_DRIVER_LICENSE_NUMBER)
																	and ut.NNEQ(left.OWN_2_DOB,right.OWN_2_DOB)
																	and ut.NNEQ(left.OWN_2_SEX,right.OWN_2_SEX)
																	and ut.NNEQ_SSN(left.own_2_ssn,right.own_2_ssn)
																	and left.own_2_prim_range = right.own_2_prim_range
																	and left.own_2_predir = right.own_2_predir
																	and left.own_2_prim_name = right.own_2_prim_name
																	and left.own_2_suffix = right.own_2_suffix
																	and left.own_2_postdir = right.own_2_postdir
																	and left.own_2_unit_desig = right.own_2_unit_desig
																	and left.own_2_sec_range = right.own_2_sec_range
																	and left.own_2_state_2 = right.own_2_state_2
																	and left.own_2_zip5 = right.own_2_zip5
																	and left.TITLE_NUMBERxBG9 = right.TITLE_NUMBERxBG9
																	and ut.nneq(left.TITLE_ISSUE_DATE,right.TITLE_ISSUE_DATE)
																	and ut.nneq(left.PREVIOUS_TITLE_ISSUE_DATE,right.PREVIOUS_TITLE_ISSUE_DATE)
																	and left.TITLE_STATUS_CODE = right.TITLE_STATUS_CODE
																	and ut.nneq(left.LH_1_LIEN_DATE,right.LH_1_LIEN_DATE)
																	and left.LEIN_HOLDER_1_CUSTOMER_TYPE = right.LEIN_HOLDER_1_CUSTOMER_TYPE
																	and ut.nneq_SSN(left.LH_1_FEID_SSN,right.LH_1_FEID_SSN)
																	and left.LH_1_CUSTOMER_NAME = right.LH_1_CUSTOMER_NAME
																	and ut.nneq(left.LH_1_DRIVER_LICENSE_NUMBER,right.LH_1_DRIVER_LICENSE_NUMBER)
																	and ut.nneq(left.LH_1_SEX,right.LH_1_SEX)
																	and ut.nneq(left.LH_2_LEIN_DATE,right.LH_2_LEIN_DATE)
																	and left.LEIN_HOLDER_2_CUSTOMER_TYPE = right.LEIN_HOLDER_2_CUSTOMER_TYPE
																	and ut.nneq_SSN(left.LH_2_FEID_SSN,right.LH_2_FEID_SSN)
																	and left.LH_2_CUSTOMER_NAME = right.LH_2_CUSTOMER_NAME
																	and ut.nneq(left.LH_2_DRIVER_LICENSE_NUMBER,right.LH_2_DRIVER_LICENSE_NUMBER)
																	and ut.nneq(left.LH_2_SEX,right.LH_2_SEX)
																	and ut.nneq(left.LH_3_LIEN_DATE,right.LH_3_LIEN_DATE)
																	and left.LEIN_HOLDER_3_CUSTOMER_TYPE = right.LEIN_HOLDER_3_CUSTOMER_TYPE
																	and ut.nneq_SSN(left.LH_3_FEID_SSN,right.LH_3_FEID_SSN)
																	and left.LH_3_CUSTOMER_NAME = right.LH_3_CUSTOMER_NAME
																	and ut.nneq(left.LH_3_DRIVER_LICENSE_NUMBER,right.LH_3_DRIVER_LICENSE_NUMBER)
																	and left.LH_3_SEX = right.LH_3_SEX		
																	and left.REGISTRANT_1_CUSTOMER_TYPExBG5 = right.REGISTRANT_1_CUSTOMER_TYPExBG5
																	and ut.nneq_SSN(left.REG_1_FEID_SSN,right.REG_1_FEID_SSN)
																	and left.REG_1_CUSTOMER_NAME = right.REG_1_CUSTOMER_NAME 
																	and ut.nneq(left.REG_1_DRIVER_LICENSE_NUMBER,right.REG_1_DRIVER_LICENSE_NUMBER)
																	and ut.nneq(left.REG_1_DOB,right.REG_1_DOB)
																	and ut.nneq(left.reg_1_sex,right.reg_1_sex)
																	and ut.nneq_SSN(left.reg_1_ssn,right.reg_1_ssn)
																	and left.reg_1_prim_range = right.reg_1_prim_range
																	and left.reg_1_predir = right.reg_1_predir
																	and left.reg_1_prim_name = right.reg_1_prim_name
																	and left.reg_1_suffix = right.reg_1_suffix
																	and left.reg_1_postdir = right.reg_1_postdir
																	and left.reg_1_unit_desig = right.reg_1_unit_desig
																	and left.reg_1_sec_range = right.reg_1_sec_range
																	and left.reg_1_state_2 = right.reg_1_state_2
																	and left.reg_1_zip5 = right.reg_1_zip5
																	and left.REGISTRANT_2_CUSTOMER_TYPE = right.REGISTRANT_2_CUSTOMER_TYPE
																	and ut.nneq_SSN(left.REG_2_FEID_SSN,right.REG_2_FEID_SSN)
																	and left.REG_2_CUSTOMER_NAME = right.REG_2_CUSTOMER_NAME 
																	and ut.nneq(left.REG_2_DRIVER_LICENSE_NUMBER,right.REG_2_DRIVER_LICENSE_NUMBER)
																	and ut.nneq(left.REG_2_DOB,right.REG_2_DOB)
																	and ut.nneq(left.reg_2_sex,right.reg_2_sex)
																	and ut.nneq_SSN(left.reg_2_ssn,right.reg_2_ssn)
																	and left.reg_2_prim_range = right.reg_2_prim_range
																	and left.reg_2_predir = right.reg_2_predir
																	and left.reg_2_prim_name = right.reg_2_prim_name
																	and left.reg_2_suffix = right.reg_2_suffix
																	and left.reg_2_postdir = right.reg_2_postdir
																	and left.reg_2_unit_desig = right.reg_2_unit_desig
																	and left.reg_2_sec_range = right.reg_2_sec_range
																	and left.reg_2_state_2 = right.reg_2_state_2
																	and left.reg_2_zip5 = right.reg_2_zip5
																	and ut.NNEQ(left.LICENSE_PLATE_NUMBERxBG4,right.LICENSE_PLATE_NUMBERxBG4)
																	and left.REGISTRATION_STATUS_CODE = right.REGISTRATION_STATUS_CODE
																	and ut.NNEQ(left.TRUE_LICENSE_PLSTE_NUMBER,right.TRUE_LICENSE_PLSTE_NUMBER)
																	and left.LICENSE_PLATE_CODE = right.LICENSE_PLATE_CODE,
																	tregownerrollup(left,right),
																	local
																);
				 
//do transform
veh_rollup	:=	owner_set_rollup + reg_set_rollup + reg_owner_set_rollup;

//DF-16772. Modified to remove warning messae substring applied to value of type integer.
ConvertYYYYMMToNumberOfMonths(string	pInput)	:=	(integer) pInput[1..4]*12 + (integer) pInput[5..6];
	 
veh_rollup	tregdate(veh_rollup	L)	:=
transform
  //set-up to handle cases where the latest expiration date is way in the future
  //if the latest expiration date is 10 years in the future,don't use it (unless it's the only one)
  integer nbr_months_lt_exp_dt			:=	ConvertYYYYMMToNumberOfMonths(L.Reg_latest_Expiration_Date);
  integer nbr_months_today    			:=	ConvertYYYYMMToNumberOfMonths((STRING8)Std.Date.Today());

	self.Ttl_Earliest_Issue_Date			:=	L.title_issue_date;
	self.Ttl_Latest_Issue_Date  			:=	L.title_issue_date;  
	self.Reg_Earliest_Effective_Date	:=	if(L.Reg_Rollup_Count = 1,L.REGISTRATION_EFFECTIVE_DATE,L.Reg_Earliest_Effective_Date);
	self.Reg_Latest_Effective_Date  	:=	if(L.Reg_Rollup_Count = 1,L.REGISTRATION_EFFECTIVE_DATE,L.Reg_Latest_Effective_Date);
	self.Reg_Latest_Expiration_Date 	:=	if(L.Reg_Rollup_Count = 1 or nbr_months_lt_exp_dt-nbr_months_today>120,L.REGISTRATION_Expiration_DATE,L.Reg_latest_Expiration_Date);

	self															:=	L;
end;

reg_latest_date	:=	project(veh_rollup,tregdate(left));

//assign sequence number for sequence_key to link owner and registrants

ut.Mac_Sequence_Records(reg_latest_date,sequence_key,reg_seq)

//setup flag fields

reg_seq_dist	:=	distribute(reg_seq,hash(vehicle_key,iteration_key));

reg_seq_dedup	:=	dedup(sort(reg_seq_dist,vehicle_key,iteration_key,-Reg_Earliest_Effective_Date,-Reg_Latest_Expiration_Date,-date_vendor_Last_Reported,local),vehicle_key,iteration_key,local);

reg_seq_dedup_dist	:=	distribute(reg_seq_dedup,hash(vehicle_key,iteration_key));

typeof(reg_seq) tregjoin(reg_seq_dist L,reg_seq_dedup_dist R)	:=
transform
	self.Latest_Vehicle_Flag						:=	if(l.sequence_key = r.sequence_key,'Y','N');
	self.Latest_Vehicle_iteration_Flag	:=	if(l.sequence_key = r.sequence_key,'Y','N');
	self																:=	L;
end;

reg_out	:=	join(reg_seq_dist,reg_seq_dedup_dist,Left.vehicle_key = right.vehicle_key and Left.iteration_key = right.iteration_key,tregjoin(left,right),left outer,local);

export	mapping_TEMP_party	:=	dedup(reg_out,all,local)	:	persist('~thor_data400::persist::vehicleV2::vehicleV1_temp_party');