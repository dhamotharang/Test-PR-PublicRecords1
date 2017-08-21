import Address,AID,codes,Lib_StringLib,standard,ut,vehlic,vehicleCodes,PromoteSupers;

dExperianUpdate	:=	VehicleV2.Map_Experian_Update;

// combine to the base file and rollup data on all the key fields except process date and standardized fields
dExperianCombined	:=	dExperianUpdate	+	VehicleV2.Files.Base.Experian;

// Join to VINA file

// Change to join on vin_input in VINA file, since that is the value in the vehicle file that is searched in VINA app.
VehicleV2.Mac_validVIN_exp(VehicleV2.Layout_Experian.Layout_Experian_Updating_as_VehicleV2,dExperianCombined,dExperianValidVin);

// Improve descriptions
VehicleV2.MAC_Patch_Vehmain_by_codes(dExperianValidVin,VehicleV2.Layout_Experian.Layout_Experian_Updating_as_VehicleV2,dExperianImproveCodeDesc);

// Patch descriptions from codesV3
VehicleV2.MAC_Patch_Desc_by_codesV3(dExperianImproveCodeDesc,VehicleV2.Layout_Experian.Layout_Experian_Updating_as_VehicleV2,false,dExperianPatchDesc)

// Generate vehicle key
VehicleV2.Layout_Experian.Layout_Experian_Updating_as_VehicleV2	tExpMain(dExperianPatchDesc	pInput)	:=
transform
	self.vehicle_key								:=	trim(	if(	pInput.vina_vinflag	=	'T'	and	pInput.vina_body_style not in  ['IC'],
																								pInput.vina_vin, 
																								if(	pInput.vina_vinflag = 'T' and pInput.vina_body_style in  ['IC'],
																										pInput.orig_vin,
																										//if vina takes a 17 character VIN and "converts" it to 16 characters, take the orig_vin
																										if(			pInput.vina_vinflag='F'
																												and	length(trim(pInput.orig_vin))=17
																												and	length(trim(pInput.vina_vin))!= 17,
																												pInput.orig_vin,
																												if(			pInput.orig_vin[1..4]	in	['','NONE','HMDE','HOME','UNK','N0NE','UNKN']
																														or	StringLib.StringFilterOut(pInput.orig_vin,'0|*')	=	''
																														or	regexfind('HOMEMADE$|H0MEMADE|NONE|N0NE|UNKNOWN|vehicle|UNKNOWN|UNKOWN|UNK0WN|NUMBER',pInput.orig_vin)
																														or	pInput.orig_vin in ['N/A','N','NR','NA','ASPT','01','SPCN','O','NO VIN','UKN'],  
																														(string30)hash64(pInput.state_origin,pInput.orig_vin,pInput.TITLE_NUMBERxBG9,pInput.vina_make_desc,pInput.year_make), 
																														(string30)hash64(pInput.state_origin,pInput.orig_vin,pInput.vina_make_desc,pInput.year_make)
																													)
																											)
																									)
																							),
																						left,right
																					);

	self.model_year									:=	if(pInput.best_model_year	<>	'',pInput.best_model_year,pInput.year_make);
	self.make_desc									:=	pInput.vina_make_desc;
	self.vehicle_type_desc					:=	vehicleV2.getVehtypeDesc(pInput.vehicle_type[1]);
	self.model_desc									:=	pInput.vina_model_desc;
	self.series_desc								:=	pInput.vina_series_desc;
	self.body_style_desc						:=	pInput.vina_body_style_desc;
	self.major_color_desc						:=	pInput.orig_Major_Color_Desc;
	self.minor_color_desc						:=	pInput.orig_Minor_Color_Desc;
	
	self														:=	pInput;
end;

dExperianBaseProjDesc	:=	project(dExperianPatchDesc,tExpMain(left));

//Add the source_rec_id
//Note:  There are approximately 10K records with the same record id.  However, in reviewing the data, the
//			 discrepancy is due to derived fields.
//Note:  Trimming the fields below to ensure consistent source_rec_id's.
VehicleV2.Layout_Experian.Layout_Experian_Updating_as_VehicleV2 tSource_Rec_ID(dExperianBaseProjDesc L) := 
transform										
	person_name_hash										:= hash(stringlib.stringcleanspaces(l.raw_first_name)
																						 ,stringlib.stringcleanspaces(l.raw_middle_name)
																						 ,stringlib.stringcleanspaces(l.raw_last_name)
																						 ,stringlib.stringcleanspaces(l.raw_name_suffix)
																						 ,stringlib.stringcleanspaces(l.raw_prof_suffix));
	address_hash												:= hash(stringlib.stringcleanspaces(l.raw_mail_street_address)
																						 ,stringlib.stringcleanspaces(l.raw_mail_city)
																						 ,stringlib.stringcleanspaces(l.raw_mail_state)
																						 ,stringlib.stringcleanspaces(l.raw_mail_zip5)
																						 ,stringlib.stringcleanspaces(l.raw_mail_zip4)
																						 ,stringlib.stringcleanspaces(l.raw_physical_street_address)
																						 ,stringlib.stringcleanspaces(l.raw_physical_city)
																						 ,stringlib.stringcleanspaces(l.raw_physical_state)
																						 ,stringlib.stringcleanspaces(l.raw_physical_zip5)
																						 ,stringlib.stringcleanspaces(l.raw_physical_zip4));
	car_info_hash												:= hash(stringlib.stringcleanspaces(l.net_weight)
																						 ,stringlib.stringcleanspaces(l.number_of_axles)
																						 ,stringlib.stringcleanspaces(l.make_code)
																						 ,stringlib.stringcleanspaces(l.orig_make_desc)
																						 ,stringlib.stringcleanspaces(l.model)
																						 ,stringlib.stringcleanspaces(l.series)
																						 ,stringlib.stringcleanspaces(l.major_color_code)
																						 ,stringlib.stringcleanspaces(l.minor_color_code)
																						 ,stringlib.stringcleanspaces(l.body_code)
																						 ,stringlib.stringcleanspaces(l.orig_body_desc)
																						 ,stringlib.stringcleanspaces(l.vehicle_type));
	self.source_rec_id 									:= hash64(stringlib.stringcleanspaces(l.state_origin)
																							 ,stringlib.stringcleanspaces(l.orig_vin)
																							 ,stringlib.stringcleanspaces(l.year_make)
																							 ,car_info_hash
																							 ,stringlib.stringcleanspaces(l.license_plate_numberxbg4)
																							 ,stringlib.stringcleanspaces(l.true_license_plste_number)
																							 ,stringlib.stringcleanspaces(l.license_state)
																							 ,stringlib.stringcleanspaces(l.previous_license_state)
																							 ,stringlib.stringcleanspaces(l.previous_license_plate_number)
																							 ,stringlib.stringcleanspaces(l.registration_expiration_date)
																							 ,stringlib.stringcleanspaces(l.license_plate_code)
																							 ,stringlib.stringcleanspaces(l.decal_number)
																							 ,stringlib.stringcleanspaces(l.first_registration_date)
																							 ,stringlib.stringcleanspaces(l.registration_effective_date)
																							 ,stringlib.stringcleanspaces(l.title_numberxbg9)
																							 ,stringlib.stringcleanspaces(l.title_issue_date)
																							 ,stringlib.stringcleanspaces(l.previous_title_issue_date)
																							 ,stringlib.stringcleanspaces(l.orig_name_type)
																							 ,stringlib.stringcleanspaces(l.orig_party_type)
																							 ,address_hash
																							 ,stringlib.stringcleanspaces(l.orig_ssn)
																							 ,stringlib.stringcleanspaces(l.orig_FEIN)
																							 ,stringlib.stringcleanspaces(l.orig_DOB)
																							 ,person_name_hash
																							 ,stringlib.stringcleanspaces(l.source_ctl_id)
																							 ,stringlib.stringcleanspaces(l.tod_flag)
																							 );
	self := L;
end;
	
dExperianBaseProj := project(dExperianBaseProjDesc,tSource_Rec_ID(left));

dExperianDist	:=	distribute(dExperianBaseProj,hash(state_origin,orig_vin));
dExperianSort	:=	sort(	dExperianDist
														,state_origin
														,orig_vin
														,year_make
														,net_weight
														,number_of_axles
														,make_code
														,orig_make_desc
														,model
														,series
														,major_color_code                 
														,minor_color_code
														,body_code
														,orig_body_desc
														,vehicle_type
														,license_plate_numberxbg4
														,true_license_plste_number
														,license_state
														,previous_license_state
														,previous_license_plate_number
														,registration_expiration_date
														,license_plate_code               
														,decal_number
														,first_registration_date
														,registration_effective_date
														,title_numberxbg9
														,title_issue_date
														,previous_title_issue_date
														,orig_name_type
														,orig_party_type                  
														,orig_name
														,orig_address
														,orig_city
														,orig_state
														,orig_zip
														,orig_ssn
														,orig_fein
														,orig_dob
														,fname
														,mname
														,lname
														,name_suffix
														,append_clean_cname
														,-dt_vendor_last_reported
														,local
													);

typeof(dExperianSort)	tRollup(dExperianSort	L,dExperianSort	R)	:=
transform
  self.dt_first_seen				    			:=	ut.min2(L.dt_first_seen,R.dt_first_seen);
  self.dt_last_seen				      			:=	MAX(L.dt_last_seen,R.dt_last_seen);
	self.dt_vendor_first_reported				:=	ut.min2(L.dt_vendor_first_reported,R.dt_vendor_first_reported);
	self.dt_vendor_last_reported  			:=  MAX(L.dt_vendor_last_reported,R.dt_vendor_last_reported);
	self.source_rec_id									:=  if(L.source_rec_id<>0,if(L.source_rec_id<R.source_rec_id,L.source_rec_id,R.source_rec_id),0);			
  self																:=	L;
end;

dExperianBase		:=	rollup(	dExperianSort
																,tRollup(left,right)
																,stringlib.stringcleanspaces(state_origin)
																,stringlib.stringcleanspaces(orig_vin)
																,stringlib.stringcleanspaces(year_make)
																,stringlib.stringcleanspaces(net_weight)
																,stringlib.stringcleanspaces(number_of_axles)
																,stringlib.stringcleanspaces(make_code)
																,stringlib.stringcleanspaces(orig_make_desc)
																,stringlib.stringcleanspaces(model)
																,stringlib.stringcleanspaces(series)
																,stringlib.stringcleanspaces(major_color_code )                
																,stringlib.stringcleanspaces(minor_color_code)
																,stringlib.stringcleanspaces(body_code)
																,stringlib.stringcleanspaces(orig_body_desc)
																,stringlib.stringcleanspaces(vehicle_type)
																,stringlib.stringcleanspaces(license_plate_numberxbg4)
																,stringlib.stringcleanspaces(true_license_plste_number)
																,stringlib.stringcleanspaces(license_state)
																,stringlib.stringcleanspaces(previous_license_state)
																,stringlib.stringcleanspaces(previous_license_plate_number)
																,stringlib.stringcleanspaces(registration_expiration_date)
																,stringlib.stringcleanspaces(license_plate_code)               
																,stringlib.stringcleanspaces(decal_number)
																,stringlib.stringcleanspaces(first_registration_date)
																,stringlib.stringcleanspaces(registration_effective_date)
																,stringlib.stringcleanspaces(title_numberxbg9)
																,stringlib.stringcleanspaces(title_issue_date)
																,stringlib.stringcleanspaces(previous_title_issue_date)
																,stringlib.stringcleanspaces(orig_name_type)
																,stringlib.stringcleanspaces(orig_party_type)                  
																,stringlib.stringcleanspaces(orig_name)
																,stringlib.stringcleanspaces(orig_address)
																,stringlib.stringcleanspaces(orig_city)
																,stringlib.stringcleanspaces(orig_state)
																,stringlib.stringcleanspaces(orig_zip)
																,stringlib.stringcleanspaces(orig_ssn)
																,stringlib.stringcleanspaces(orig_FEIN)
																,stringlib.stringcleanspaces(orig_DOB)
																,stringlib.stringcleanspaces(fname)
																,stringlib.stringcleanspaces(mname)
																,stringlib.stringcleanspaces(lname)
																,stringlib.stringcleanspaces(name_suffix)
																,stringlib.stringcleanspaces(append_clean_cname)
																,local
															);
															
PromoteSupers.MAC_SF_BuildProcess(dExperianBase,'~thor_data400::base::vehiclev2::experian',buildExperianBase,2,,true);

removeExpBldg	:=	sequential(	fileservices.startsuperfiletransaction(),
																fileservices.clearsuperfile('~thor_data400::in::vehiclev2::experian_building'),
																fileservices.finishsuperfiletransaction()
															);

buildExperianAll	:=	sequential(buildExperianBase,removeExpBldg);

export	experian_as_base	:=	if(	fileservices.getsuperfilesubcount('~thor_data400::in::vehiclev2::experian_building')	>	0,
																	buildExperianAll,
																	output('Not building Experian base file as no new experian vehicle updates available')
																);