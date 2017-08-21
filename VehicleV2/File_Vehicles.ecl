import Address,AID,CODES,ut,vehlic;

/*
file_vehicles_V1	:=	VehLic.File_Base_Vehicles_Prod;

file_filter	:=	file_vehicles_V1(	(source_code	in	['AE']	and	orig_state	in	['AL','CT','DE','MD','OK','OR','SC'])	or
																	(source_code	in	['DI']	and	~orig_state	in	['NC'])
																);
*/

VehicleV1_nonupdating	:=	dataset('~thor_data400::base::vehicleV1_noupdating',VehLic.Layout_Vehicles,flat,unsorted,__compressed__);

// Filter out NM direct samba data as per legal
dVehicleV1Filter	:=	VehicleV1_nonupdating(~(orig_state	=	'NM'	and	source_code	=	'DI'));

// reformat vehicles V1
VehicleV2.Layout_temp_module.Layout_vehiclesV2_slim	tVehSlim(dVehicleV1Filter	pInput)	:=
transform
	self.source_rec_id 									:= hash64(pInput.vrid
																							 ,pInput.dt_first_seen
																							 ,pInput.dt_last_seen
																							 ,pInput.dt_vendor_first_reported
																							 ,pInput.dt_vendor_last_reported
																							 ,pInput.orig_state
																							 ,pInput.source_code
																							 ,pInput.price
																							 ,pInput.seq_no
																							 ,pInput.vehicle_numberxbg1
																							 ,pInput.orig_vin
																							 ,pInput.vehicle_transaction_id
																							 ,pInput.first_registration_date
																							 ,pInput.year_make
																							 ,pInput.make_code
																							 ,pInput.vehicle_type
																							 ,pInput.model
																							 ,pInput.body_code
																							 ,pInput.vehicle_use
																							 ,pInput.major_color_code
																							 ,pInput.minor_color_code
																							 ,pInput.transfer_type
																							 ,pInput.fuel_type
																							 ,pInput.unit_numberxbg2
																							 ,pInput.fleet_number
																							 ,pInput.odometer_status
																							 ,pInput.odometer_date
																							 ,pInput.odometer_mileage
																							 ,pInput.net_weight
																							 ,pInput.gross_weight
																							 ,pInput.number_of_axles
																							 ,pInput.horse_power
																							 ,pInput.cubic_centimeters
																							 ,pInput.length_feet
																							 ,pInput.width_feet
																							 ,pInput.mh_county_code
																							 ,pInput.mh_city_code
																							 ,pInput.vessel_propulsion_type
																							 ,pInput.hull_material_type
																							 ,pInput.vessel_type
																							 ,pInput.vessel_water_type
																							 ,pInput.flaghistory
																							 ,pInput.file_handler_activity_flag
																							 ,pInput.correspondence_letter_flag
																							 ,pInput.owner_1_customer_typexbg3
																							 ,pInput.own_1_customer_number
																							 ,pInput.own_1_feid_ssn
																							 ,pInput.own_1_customer_name
																							 ,pInput.own_1_dealer_license_number
																							 ,pInput.own_1_driver_license_number
																							 ,pInput.own_1_dob
																							 ,pInput.own_1_sex
																							 ,pInput.own_1_sexual_predator_flag
																							 ,pInput.own_1_mail_suppession_flag
																							 ,pInput.own_1_addr_non_disclosure_flag
																							 ,pInput.own_1_law_enforcement_flag
																							 ,pInput.own_1_address_number
																							 ,pInput.own_1_foreign_address_flag
																							 ,pInput.own_1_street_address
																							 ,pInput.own_1_apartment_number
																							 ,pInput.own_1_city
																							 ,pInput.own_1_state
																							 ,pInput.own_1_zip5_zip4_foreign_postal
																							 ,pInput.own_1_residence_county
																							 ,pInput.owner_2_customer_type
																							 ,pInput.own_2_customer_number
																							 ,pInput.own_2_feid_ssn
																							 ,pInput.own_2_customer_name
																							 ,pInput.own_2_dealer_license_number
																							 ,pInput.own_2_driver_license_number
																							 ,pInput.own_2_dob
																							 ,pInput.own_2_sex
																							 ,pInput.own_2_sexual_predator_flag
																							 ,pInput.own_2_mail_suppession_flag
																							 ,pInput.own_2_addr_non_disclosure_flag
																							 ,pInput.own_2_law_enforcement_flag
																							 ,pInput.own_2_address_number
																							 ,pInput.own_2_foreign_address_flag
																							 ,pInput.own_2_street_address
																							 ,pInput.own_2_apartment_number
																							 ,pInput.own_2_city
																							 ,pInput.own_2_state
																							 ,pInput.own_2_zip5_zip4_foreign_postal
																							 ,pInput.own_2_residence_county
																							 ,pInput.joint_ownership_codexand_or
																							 ,pInput.flagvin
																							 ,pInput.license_plate_numberxbg4
																							 ,pInput.registration_number
																							 ,pInput.registration_transaction_id
																							 ,pInput.registration_effective_date
																							 ,pInput.registration_expiration_date
																							 ,pInput.plate_issue_date
																							 ,pInput.vehicle_class_code
																							 ,pInput.arf_credit
																							 ,pInput.decal_number
																							 ,pInput.decal_year
																							 ,pInput.decal_type
																							 ,pInput.registration_status_code
																							 ,pInput.reg_only_reason_code
																							 ,pInput.license_plate_code
																							 ,pInput.registration_use
																							 ,pInput.true_license_plste_number
																							 ,pInput.flagmatchcode
																							 ,pInput.vessel_resident_status
																							 ,pInput.registrant_1_customer_typexbg5
																							 ,pInput.reg_1_customer_number
																							 ,pInput.reg_1_feid_ssn
																							 ,pInput.reg_1_customer_name
																							 ,pInput.reg_1_dealer_license_number
																							 ,pInput.reg_1_driver_license_number
																							 ,pInput.reg_1_dob
																							 ,pInput.reg_1_sex
																							 ,pInput.reg_1_sexual_predator_flag
																							 ,pInput.reg_1_mail_suppession_flag
																							 ,pInput.reg_1_addr_non_disclosure_flag
																							 ,pInput.reg_1_law_enforcement_flag
																							 ,pInput.reg_1_address_number
																							 ,pInput.reg_1_foreign_address_flag
																							 ,pInput.reg_1_street_address
																							 ,pInput.reg_1_apartment_number
																							 ,pInput.reg_1_city
																							 ,pInput.reg_1_state
																							 ,pInput.reg_1_zip5_zip4_foreign_postal
																							 ,pInput.reg_1_residence_county
																							 ,pInput.registrant_2_customer_type
																							 ,pInput.reg_2_customer_number
																							 ,pInput.reg_2_feid_ssn
																							 ,pInput.reg_2_customer_name
																							 ,pInput.reg_2_dealer_license_number
																							 ,pInput.reg_2_driver_license_number
																							 ,pInput.reg_2_dob
																							 ,pInput.reg_2_sex
																							 ,pInput.reg_2_sexual_predator_flag
																							 ,pInput.reg_2_mail_suppession_flag
																							 ,pInput.reg_2_addr_non_disclosure_flag
																							 ,pInput.reg_2_law_enforcement_flag
																							 ,pInput.reg_2_address_number
																							 ,pInput.reg_2_foreign_address_flag
																							 ,pInput.reg_2_street_address
																							 ,pInput.reg_2_apartment_number
																							 ,pInput.reg_2_city
																							 ,pInput.reg_2_state
																							 ,pInput.reg_2_zip5_zip4_foreign_postal
																							 ,pInput.reg_2_residence_county
																							 ,pInput.activity_datexbg6
																							 ,pInput.activity_county
																							 ,pInput.activity_agencyxeg6
																							 ,pInput.insurance_company_codexbg7
																							 ,pInput.insurance_number
																							 ,pInput.insurance_status
																							 ,pInput.insurance_typexeg7
																							 ,pInput.emissions_inspection_statusxbg8
																							 ,pInput.emissions_inspection_date
																							 ,pInput.emissions_insp_reg_year
																							 ,pInput.emissions_inspection_level
																							 ,pInput.emissions_certificate_numberxeg8
																							 ,pInput.title_numberxbg9
																							 ,pInput.title_transaction_id
																							 ,pInput.title_issue_date
																							 ,pInput.previous_title_issue_date
																							 ,pInput.title_status_code
																							 ,pInput.title_type
																							 ,pInput.previous_title_state
																							 ,pInput.salvage_type
																							 ,pInput.dealer_license_number
																							 ,pInput.title_pending_flag
																							 ,pInput.name_too_long_flag
																							 ,pInput.duplicate_title_flag
																							 ,pInput.brand_codesx5
																							 ,pInput.efs_statusxeg9
																							 ,pInput.lien_countxbg10
																							 ,pInput.lh_1_lien_date
																							 ,pInput.lein_holder_1_customer_type
																							 ,pInput.lh_1_customer_number
																							 ,pInput.lh_1_feid_ssn
																							 ,pInput.lh_1_customer_name
																							 ,pInput.lh_1_dealer_license_number
																							 ,pInput.lh_1_driver_license_number
																							 ,pInput.lh_1_dob
																							 ,pInput.lh_1_sex
																							 ,pInput.lh_1_sexual_predator_flag
																							 ,pInput.lh_1_mail_suppession_flag
																							 ,pInput.lh_1_addr_non_disclosure_flag
																							 ,pInput.lh_1_law_enforcement_flag
																							 ,pInput.lh_1_address_number
																							 ,pInput.lh_1_foreign_address_flag
																							 ,pInput.lh_1_street_address
																							 ,pInput.lh_1_apartment_number
																							 ,pInput.lh_1_city
																							 ,pInput.lh_1_state
																							 ,pInput.lh_1_zip5_zip4_foreign_postal
																							 ,pInput.lh_1_residence_county
																							 ,pInput.lh_2_lein_date
																							 ,pInput.lein_holder_2_customer_type
																							 ,pInput.lh_2_customer_number
																							 ,pInput.lh_2_feid_ssn
																							 ,pInput.lh_2_customer_name
																							 ,pInput.lh_2_dealer_license_number
																							 ,pInput.lh_2_driver_license_number
																							 ,pInput.lh_2_dob
																							 ,pInput.lh_2_sex
																							 ,pInput.lh_2_sexual_predator_flag
																							 ,pInput.lh_2_mail_suppession_flag
																							 ,pInput.lh_2_addr_non_disclosure_flag
																							 ,pInput.lh_2_law_enforcement_flag
																							 ,pInput.lh_2_address_number
																							 ,pInput.lh_2_foreign_address_flag
																							 ,pInput.lh_2_street_address
																							 ,pInput.lh_2_apartment_number
																							 ,pInput.lh_2_city
																							 ,pInput.lh_2_state
																							 ,pInput.lh_2_zip5_zip4_foreign_postal
																							 ,pInput.lh_2_residence_county
																							 ,pInput.lh_3_lien_date
																							 ,pInput.lein_holder_3_customer_type
																							 ,pInput.lh_3_customer_number
																							 ,pInput.lh_3_feid_ssn
																							 ,pInput.lh_3_customer_name
																							 ,pInput.lh_3_dealer_license_number
																							 ,pInput.lh_3_driver_license_number
																							 ,pInput.lh_3_dob
																							 ,pInput.lh_3_sex
																							 ,pInput.lh_3_sexual_predator_flag
																							 ,pInput.lh_3_mail_suppession_flag
																							 ,pInput.lh_3_addr_non_disclosure_flag
																							 ,pInput.lh_3_law_enforcement_flag
																							 ,pInput.lh_3_address_number
																							 ,pInput.lh_3_foreign_address_flag
																							 ,pInput.lh_3_street_address
																							 ,pInput.lh_3_apartment_number
																							 ,pInput.lh_3_city
																							 ,pInput.lh_3_state
																							 ,pInput.lh_3_zip5_zip4_foreign_postal
																							 ,pInput.lh_3_residence_county
																							 ,pInput.own_1_title
																							 ,pInput.own_1_fname
																							 ,pInput.own_1_mname
																							 ,pInput.own_1_lname
																							 ,pInput.own_1_name_suffix
																							 ,pInput.own_1_did
																							 ,pInput.own_1_bdid
																							 ,pInput.own_1_ssn
																							 ,pInput.own_1_company_name
																							 ,pInput.own_1_prim_range
																							 ,pInput.own_1_predir
																							 ,pInput.own_1_prim_name
																							 ,pInput.own_1_suffix
																							 ,pInput.own_1_postdir
																							 ,pInput.own_1_unit_desig
																							 ,pInput.own_1_sec_range
																							 ,pInput.own_1_p_city_name
																							 ,pInput.own_1_v_city_name
																							 ,pInput.own_1_state_2
																							 ,pInput.own_1_zip5
																							 ,pInput.own_1_zip4
																							 ,pInput.own_1_county
																							 ,pInput.own_1_geo_lat
																							 ,pInput.own_1_geo_long
																							 ,pInput.own_2_title
																							 ,pInput.own_2_fname
																							 ,pInput.own_2_mname
																							 ,pInput.own_2_lname
																							 ,pInput.own_2_name_suffix
																							 ,pInput.own_2_did
																							 ,pInput.own_2_bdid
																							 ,pInput.own_2_ssn
																							 ,pInput.own_2_company_name
																							 ,pInput.own_2_prim_range
																							 ,pInput.own_2_predir
																							 ,pInput.own_2_prim_name
																							 ,pInput.own_2_suffix
																							 ,pInput.own_2_postdir
																							 ,pInput.own_2_unit_desig
																							 ,pInput.own_2_sec_range
																							 ,pInput.own_2_p_city_name
																							 ,pInput.own_2_v_city_name
																							 ,pInput.own_2_state_2
																							 ,pInput.own_2_zip5
																							 ,pInput.own_2_zip4
																							 ,pInput.own_2_county
																							 ,pInput.own_2_geo_lat
																							 ,pInput.own_2_geo_long
																							 ,pInput.reg_1_title
																							 ,pInput.reg_1_fname
																							 ,pInput.reg_1_mname
																							 ,pInput.reg_1_lname
																							 ,pInput.reg_1_name_suffix
																							 ,pInput.reg_1_did
																							 ,pInput.reg_1_bdid
																							 ,pInput.reg_1_ssn
																							 ,pInput.reg_1_company_name
																							 ,pInput.reg_1_prim_range
																							 ,pInput.reg_1_predir
																							 ,pInput.reg_1_prim_name
																							 ,pInput.reg_1_suffix
																							 ,pInput.reg_1_postdir
																							 ,pInput.reg_1_unit_desig
																							 ,pInput.reg_1_sec_range
																							 ,pInput.reg_1_p_city_name
																							 ,pInput.reg_1_v_city_name
																							 ,pInput.reg_1_state_2
																							 ,pInput.reg_1_zip5
																							 ,pInput.reg_1_zip4
																							 ,pInput.reg_1_county
																							 ,pInput.reg_1_geo_lat
																							 ,pInput.reg_1_geo_long
																							 ,pInput.reg_2_title
																							 ,pInput.reg_2_fname
																							 ,pInput.reg_2_mname
																							 ,pInput.reg_2_lname
																							 ,pInput.reg_2_name_suffix
																							 ,pInput.reg_2_did
																							 ,pInput.reg_2_bdid
																							 ,pInput.reg_2_ssn
																							 ,pInput.reg_2_company_name
																							 ,pInput.reg_2_prim_range
																							 ,pInput.reg_2_predir
																							 ,pInput.reg_2_prim_name
																							 ,pInput.reg_2_suffix
																							 ,pInput.reg_2_postdir
																							 ,pInput.reg_2_unit_desig
																							 ,pInput.reg_2_sec_range
																							 ,pInput.reg_2_p_city_name
																							 ,pInput.reg_2_v_city_name
																							 ,pInput.reg_2_state_2
																							 ,pInput.reg_2_zip5
																							 ,pInput.reg_2_zip4
																							 ,pInput.reg_2_county
																							 ,pInput.reg_2_geo_lat
																							 ,pInput.reg_2_geo_long
																							 ,pInput.vin_2
																							 ,pInput.veh_type
																							 ,pInput.ncic_make
																							 ,pInput.model_year_yy
																							 ,pInput.vin
																							 ,pInput.vin_pattern_indicator
																							 ,pInput.bypass_code
																							 ,pInput.vp_restraint
																							 ,pInput.vp_abbrev_make_name
																							 ,pInput.vp_year
																							 ,pInput.vp_series
																							 ,pInput.vp_model
																							 ,pInput.vp_air_conditioning
																							 ,pInput.vp_power_steering
																							 ,pInput.vp_power_brakes
																							 ,pInput.vp_power_windows
																							 ,pInput.vp_tilt_wheel
																							 ,pInput.vp_roof
																							 ,pInput.vp_optional_roof1
																							 ,pInput.vp_optional_roof2
																							 ,pInput.vp_radio
																							 ,pInput.vp_optional_radio1
																							 ,pInput.vp_optional_radio2
																							 ,pInput.vp_transmission
																							 ,pInput.vp_optional_transmission1
																							 ,pInput.vp_optional_transmission2
																							 ,pInput.vp_anti_lock_brakes
																							 ,pInput.vp_front_wheel_drive
																							 ,pInput.vp_four_wheel_drive
																							 ,pInput.vp_security_system
																							 ,pInput.vp_daytime_running_lights
																							 ,pInput.vp_series_name
																							 ,pInput.model_year
																							 ,pInput.vina_series
																							 ,pInput.vina_model
																							 ,pInput.vina_body_style
																							 ,pInput.make_description
																							 ,pInput.model_description
																							 ,pInput.series_description
																							 ,pInput.body_style_description
																							 ,pInput.number_of_cylinders
																							 ,pInput.engine_size
																							 ,pInput.fuel_code
																							 ,pInput.vina_price
																							 ,pInput.history
																							 ,pInput.best_make_code
																							 ,pInput.best_series_code
																							 ,pInput.best_model_code
																							 ,pInput.best_body_code
																							 ,pInput.best_model_year
																							 ,pInput.best_major_color_code
																							 ,pInput.best_minor_color_code);
	self.state_origin	:=	pInput.orig_state;
	self							:=	pInput;
	self							:=	[];
end;

vehicleV1_as_V2	:=	project(dVehicleV1Filter,tVehSlim(left));

rAppendVeh_layout	:=
record
	VehicleV2.Layout_temp_module.Layout_vehiclesV2_slim;
	unsigned8				Append_SeqNum;
	string2					Append_NameAddrInd;
	string1					Append_NameType;
	string100				Append_OrigName;
	string100				Append_PrepAddr1;
	string50				Append_PrepAddr2;
	AID.Common.xAID	Append_RawAID;
end;

rAppendVeh_layout	tReformat(vehicleV1_as_V2	pInput)	:=
transform
	self	:=	pInput;
	self	:=	[];
end;

dVehReformat	:=	project(vehicleV1_as_V2,tReformat(left));

// Append sequence number so as to normalize the records by address
ut.MAC_Sequence_Records(dVehReformat,Append_SeqNum,dVehAppendSeqNum);

dVehAppendSeqNum_Dist	:=	distribute(dVehAppendSeqNum,hash(Append_SeqNum));

rAppendVeh_layout	tNormalizeAddr(dVehAppendSeqNum_Dist	pInput,integer	cnt)	:=
transform
	self.Append_NameAddrInd		:=	choose(cnt,'O1','O2','R1','R2');
	self.Append_OrigName			:=	choose(	cnt,
																				pInput.OWN_1_CUSTOMER_NAME,
																				pInput.OWN_2_CUSTOMER_NAME,
																				pInput.REG_1_CUSTOMER_NAME,
																				pInput.REG_2_CUSTOMER_NAME
																			);
	self.Append_PrepAddr1			:=	choose(	cnt,
																				stringlib.stringtouppercase(stringlib.stringcleanspaces(pInput.OWN_1_STREET_ADDRESS	+	' '	+	pInput.OWN_1_APARTMENT_NUMBER)),
																				stringlib.stringtouppercase(stringlib.stringcleanspaces(pInput.OWN_2_STREET_ADDRESS	+	' '	+	pInput.OWN_2_APARTMENT_NUMBER)),
																				stringlib.stringtouppercase(stringlib.stringcleanspaces(pInput.REG_1_STREET_ADDRESS	+	' '	+	pInput.REG_1_APARTMENT_NUMBER)),
																				stringlib.stringtouppercase(stringlib.stringcleanspaces(pInput.REG_2_STREET_ADDRESS	+	' '	+	pInput.REG_2_APARTMENT_NUMBER))
																			);
	self.Append_PrepAddr2			:=	choose(	cnt,
																				stringlib.stringtouppercase(regexreplace(	'[,]$',
																																									stringlib.stringcleanspaces(		if(pInput.OWN_1_CITY	!=	'',trim(pInput.OWN_1_CITY,left,right)	+	', ','')
																																																								+	pInput.OWN_1_STATE
																																																								+	' '
																																																								+	if(regexfind('^[0]*$',trim(pInput.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL,left,right)),'',trim(pInput.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL,left,right)[1..5])
																																																							),
																																									''
																																								)
																																		),
																				stringlib.stringtouppercase(regexreplace(	'[,]$',
																																									stringlib.stringcleanspaces(		if(pInput.OWN_2_CITY	!=	'',trim(pInput.OWN_2_CITY,left,right)	+	', ','')
																																																								+	pInput.OWN_2_STATE
																																																								+	' '
																																																								+	if(regexfind('^[0]*$',trim(pInput.OWN_2_ZIP5_ZIP4_FOREIGN_POSTAL,left,right)),'',trim(pInput.OWN_2_ZIP5_ZIP4_FOREIGN_POSTAL,left,right)[1..5])
																																																							),
																																									''
																																								)
																																		),
																				stringlib.stringtouppercase(regexreplace(	'[,]$',
																																									stringlib.stringcleanspaces(		if(pInput.REG_1_CITY	!=	'',trim(pInput.REG_1_CITY,left,right)	+	', ','')
																																																								+	pInput.REG_1_STATE
																																																								+	' '
																																																								+	if(regexfind('^[0]*$',trim(pInput.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL,left,right)),'',trim(pInput.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL,left,right)[1..5])
																																																							),
																																									''
																																								)
																																		),
																				stringlib.stringtouppercase(regexreplace(	'[,]$',
																																									stringlib.stringcleanspaces(		if(pInput.REG_2_CITY	!=	'',trim(pInput.REG_2_CITY,left,right)	+	', ','')
																																																								+	pInput.REG_2_STATE
																																																								+	' '
																																																								+	if(regexfind('^[0]*$',trim(pInput.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL,left,right)),'',trim(pInput.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL,left,right)[1..5])
																																																							),
																																									''
																																								)
																																		)
																			);
	self											:=	pInput;
end;

dVehAppendPrepAddr	:=	normalize(dVehAppendSeqNum_Dist,4,tNormalizeAddr(left,counter),local);

// Distinguish between person and business names
dVehOrigNamePopulated			:=	dVehAppendPrepAddr(Append_OrigName	!=	'');
dVehOrigNameNotPopulated	:=	dVehAppendPrepAddr(Append_OrigName	=	'');

address.Mac_Is_Business(dVehOrigNamePopulated,Append_OrigName,dVehNameType,Append_NameType);

dAppendVehNameType	:=	project(dVehNameType,rAppendVeh_layout)	+	dVehOrigNameNotPopulated	:	persist('~thor_data400::persist::vehicleV1_normalized');

// Get RawAID and clean address using AddressID macro
dAppendVehAddrPopulated		:=	dAppendVehNameType(Append_PrepAddr2	!=	'');
dAppendVehAddrNotPoulated	:=	dAppendVehNameType(Append_PrepAddr2	=		'');

unsigned4	lAIDAppendFlags	:=	AID.Common.eReturnValues.RawAID	|
															AID.Common.eReturnValues.ACECacheRecords;

AID.MacAppendFromRaw_2Line(	dAppendVehAddrPopulated,
														Append_PrepAddr1,
														Append_PrepAddr2,
														Append_RawAID,
														dVehAppendAID,
														lAIDAppendFlags
													);

dVehAppendAIDCombined	:=	dVehAppendAID	+	project(dAppendVehAddrNotPoulated,transform(recordof(dVehAppendAID),self	:=	left;self	:=	[]));

dVehAppendAIDCombined_Dist	:=	distribute(dVehAppendAIDCombined,hash(Append_SeqNum));

rAppendVeh_layout	tDenormAddress(dVehAppendSeqNum_Dist	le,dVehAppendAIDCombined_Dist	ri)	:=
transform
	self.OWNER_1_CUSTOMER_TYPExBG3			:=	if(ri.Append_NameAddrInd	=	'O1',ri.Append_NameType,le.OWNER_1_CUSTOMER_TYPExBG3);
	self.OWNER_2_CUSTOMER_TYPE					:=	if(ri.Append_NameAddrInd	=	'O2',ri.Append_NameType,le.OWNER_2_CUSTOMER_TYPE);
	self.REGISTRANT_1_CUSTOMER_TYPExBG5	:=	if(ri.Append_NameAddrInd	=	'R1',ri.Append_NameType,le.REGISTRANT_1_CUSTOMER_TYPExBG5);
	self.REGISTRANT_2_CUSTOMER_TYPE			:=	if(ri.Append_NameAddrInd	=	'R2',ri.Append_NameType,le.REGISTRANT_2_CUSTOMER_TYPE);
	
	self.own_1_prim_range								:=	if(ri.Append_NameAddrInd	=	'O1',ri.AIDWork_AceCache.prim_range,le.own_1_prim_range);
	self.own_1_predir										:=	if(ri.Append_NameAddrInd	=	'O1',ri.AIDWork_AceCache.predir,le.own_1_predir);
	self.own_1_prim_name								:=	if(ri.Append_NameAddrInd	=	'O1',ri.AIDWork_AceCache.prim_name,le.own_1_prim_name);
	self.own_1_suffix										:=	if(ri.Append_NameAddrInd	=	'O1',ri.AIDWork_AceCache.addr_suffix,le.own_1_suffix);
	self.own_1_postdir									:=	if(ri.Append_NameAddrInd	=	'O1',ri.AIDWork_AceCache.postdir,le.own_1_postdir);
	self.own_1_unit_desig								:=	if(ri.Append_NameAddrInd	=	'O1',ri.AIDWork_AceCache.unit_desig,le.own_1_unit_desig);
	self.own_1_sec_range								:=	if(ri.Append_NameAddrInd	=	'O1',ri.AIDWork_AceCache.sec_range,le.own_1_sec_range);
	self.own_1_p_city_name							:=	if(ri.Append_NameAddrInd	=	'O1',ri.AIDWork_AceCache.p_city_name,le.own_1_p_city_name);
	self.own_1_v_city_name							:=	if(ri.Append_NameAddrInd	=	'O1',ri.AIDWork_AceCache.v_city_name,le.own_1_v_city_name);
	self.own_1_state_2									:=	if(ri.Append_NameAddrInd	=	'O1',ri.AIDWork_AceCache.st,le.own_1_state_2);
	self.own_1_zip5											:=	if(ri.Append_NameAddrInd	=	'O1',ri.AIDWork_AceCache.zip5,le.own_1_zip5);
	self.own_1_zip4											:=	if(ri.Append_NameAddrInd	=	'O1',ri.AIDWork_AceCache.zip4,le.own_1_zip4);
	self.own_1_county										:=	if(ri.Append_NameAddrInd	=	'O1',ri.AIDWork_AceCache.county,le.own_1_county);
	self.own_1_geo_lat									:=	if(ri.Append_NameAddrInd	=	'O1',ri.AIDWork_AceCache.geo_lat,le.own_1_geo_lat);
	self.own_1_geo_long									:=	if(ri.Append_NameAddrInd	=	'O1',ri.AIDWork_AceCache.geo_long,le.own_1_geo_long);
	self.own_1_err_stat									:=	if(ri.Append_NameAddrInd	=	'O1',ri.AIDWork_AceCache.err_stat,le.own_1_err_stat);
	self.own_2_prim_range								:=	if(ri.Append_NameAddrInd	=	'O2',ri.AIDWork_AceCache.prim_range,le.own_2_prim_range);;
	self.own_2_predir										:=	if(ri.Append_NameAddrInd	=	'O2',ri.AIDWork_AceCache.predir,le.own_2_predir);
	self.own_2_prim_name								:=	if(ri.Append_NameAddrInd	=	'O2',ri.AIDWork_AceCache.prim_name,le.own_2_prim_name);
	self.own_2_suffix										:=	if(ri.Append_NameAddrInd	=	'O2',ri.AIDWork_AceCache.addr_suffix,le.own_2_suffix);
	self.own_2_postdir									:=	if(ri.Append_NameAddrInd	=	'O2',ri.AIDWork_AceCache.postdir,le.own_2_postdir);
	self.own_2_unit_desig								:=	if(ri.Append_NameAddrInd	=	'O2',ri.AIDWork_AceCache.unit_desig,le.own_2_unit_desig);
	self.own_2_sec_range								:=	if(ri.Append_NameAddrInd	=	'O2',ri.AIDWork_AceCache.sec_range,le.own_2_sec_range);
	self.own_2_p_city_name							:=	if(ri.Append_NameAddrInd	=	'O2',ri.AIDWork_AceCache.p_city_name,le.own_2_p_city_name);
	self.own_2_v_city_name							:=	if(ri.Append_NameAddrInd	=	'O2',ri.AIDWork_AceCache.v_city_name,le.own_2_v_city_name);
	self.own_2_state_2									:=	if(ri.Append_NameAddrInd	=	'O2',ri.AIDWork_AceCache.st,le.own_2_state_2);
	self.own_2_zip5											:=	if(ri.Append_NameAddrInd	=	'O2',ri.AIDWork_AceCache.zip5,le.own_2_zip5);
	self.own_2_zip4											:=	if(ri.Append_NameAddrInd	=	'O2',ri.AIDWork_AceCache.zip4,le.own_2_zip4);
	self.own_2_county										:=	if(ri.Append_NameAddrInd	=	'O2',ri.AIDWork_AceCache.county,le.own_2_county);
	self.own_2_geo_lat									:=	if(ri.Append_NameAddrInd	=	'O2',ri.AIDWork_AceCache.geo_lat,le.own_2_geo_lat);
	self.own_2_geo_long									:=	if(ri.Append_NameAddrInd	=	'O2',ri.AIDWork_AceCache.geo_long,le.own_2_geo_long);
	self.own_2_err_stat									:=	if(ri.Append_NameAddrInd	=	'O2',ri.AIDWork_AceCache.err_stat,le.own_2_err_stat);
	self.reg_1_prim_range								:=	if(ri.Append_NameAddrInd	=	'R1',ri.AIDWork_AceCache.prim_range,le.reg_1_prim_range);;
	self.reg_1_predir										:=	if(ri.Append_NameAddrInd	=	'R1',ri.AIDWork_AceCache.predir,le.reg_1_predir);
	self.reg_1_prim_name								:=	if(ri.Append_NameAddrInd	=	'R1',ri.AIDWork_AceCache.prim_name,le.reg_1_prim_name);
	self.reg_1_suffix										:=	if(ri.Append_NameAddrInd	=	'R1',ri.AIDWork_AceCache.addr_suffix,le.reg_1_suffix);
	self.reg_1_postdir									:=	if(ri.Append_NameAddrInd	=	'R1',ri.AIDWork_AceCache.postdir,le.reg_1_postdir);
	self.reg_1_unit_desig								:=	if(ri.Append_NameAddrInd	=	'R1',ri.AIDWork_AceCache.unit_desig,le.reg_1_unit_desig);
	self.reg_1_sec_range								:=	if(ri.Append_NameAddrInd	=	'R1',ri.AIDWork_AceCache.sec_range,le.reg_1_sec_range);
	self.reg_1_p_city_name							:=	if(ri.Append_NameAddrInd	=	'R1',ri.AIDWork_AceCache.p_city_name,le.reg_1_p_city_name);
	self.reg_1_v_city_name							:=	if(ri.Append_NameAddrInd	=	'R1',ri.AIDWork_AceCache.v_city_name,le.reg_1_v_city_name);
	self.reg_1_state_2									:=	if(ri.Append_NameAddrInd	=	'R1',ri.AIDWork_AceCache.st,le.reg_1_state_2);
	self.reg_1_zip5											:=	if(ri.Append_NameAddrInd	=	'R1',ri.AIDWork_AceCache.zip5,le.reg_1_zip5);
	self.reg_1_zip4											:=	if(ri.Append_NameAddrInd	=	'R1',ri.AIDWork_AceCache.zip4,le.reg_1_zip4);
	self.reg_1_county										:=	if(ri.Append_NameAddrInd	=	'R1',ri.AIDWork_AceCache.county,le.reg_1_county);
	self.reg_1_geo_lat									:=	if(ri.Append_NameAddrInd	=	'R1',ri.AIDWork_AceCache.geo_lat,le.reg_1_geo_lat);
	self.reg_1_geo_long									:=	if(ri.Append_NameAddrInd	=	'R1',ri.AIDWork_AceCache.geo_long,le.reg_1_geo_long);
	self.reg_1_err_stat									:=	if(ri.Append_NameAddrInd	=	'R1',ri.AIDWork_AceCache.err_stat,le.reg_1_err_stat);
	self.reg_2_prim_range								:=	if(ri.Append_NameAddrInd	=	'R2',ri.AIDWork_AceCache.prim_range,le.reg_2_prim_range);;
	self.reg_2_predir										:=	if(ri.Append_NameAddrInd	=	'R2',ri.AIDWork_AceCache.predir,le.reg_2_predir);
	self.reg_2_prim_name								:=	if(ri.Append_NameAddrInd	=	'R2',ri.AIDWork_AceCache.prim_name,le.reg_2_prim_name);
	self.reg_2_suffix										:=	if(ri.Append_NameAddrInd	=	'R2',ri.AIDWork_AceCache.addr_suffix,le.reg_2_suffix);
	self.reg_2_postdir									:=	if(ri.Append_NameAddrInd	=	'R2',ri.AIDWork_AceCache.postdir,le.reg_2_postdir);
	self.reg_2_unit_desig								:=	if(ri.Append_NameAddrInd	=	'R2',ri.AIDWork_AceCache.unit_desig,le.reg_2_unit_desig);
	self.reg_2_sec_range								:=	if(ri.Append_NameAddrInd	=	'R2',ri.AIDWork_AceCache.sec_range,le.reg_2_sec_range);
	self.reg_2_p_city_name							:=	if(ri.Append_NameAddrInd	=	'R2',ri.AIDWork_AceCache.p_city_name,le.reg_2_p_city_name);
	self.reg_2_v_city_name							:=	if(ri.Append_NameAddrInd	=	'R2',ri.AIDWork_AceCache.v_city_name,le.reg_2_v_city_name);
	self.reg_2_state_2									:=	if(ri.Append_NameAddrInd	=	'R2',ri.AIDWork_AceCache.st,le.reg_2_state_2);
	self.reg_2_zip5											:=	if(ri.Append_NameAddrInd	=	'R2',ri.AIDWork_AceCache.zip5,le.reg_2_zip5);
	self.reg_2_zip4											:=	if(ri.Append_NameAddrInd	=	'R2',ri.AIDWork_AceCache.zip4,le.reg_2_zip4);
	self.reg_2_county										:=	if(ri.Append_NameAddrInd	=	'R2',ri.AIDWork_AceCache.county,le.reg_2_county);
	self.reg_2_geo_lat									:=	if(ri.Append_NameAddrInd	=	'R2',ri.AIDWork_AceCache.geo_lat,le.reg_2_geo_lat);
	self.reg_2_geo_long									:=	if(ri.Append_NameAddrInd	=	'R2',ri.AIDWork_AceCache.geo_long,le.reg_2_geo_long);
	self.reg_2_err_stat									:=	if(ri.Append_NameAddrInd	=	'R2',ri.AIDWork_AceCache.err_stat,le.reg_2_err_stat);
	
	self.Append_Own1_PrepAddr1					:=	if(ri.Append_NameAddrInd	=	'O1',ri.Append_PrepAddr1,le.Append_Own1_PrepAddr1);
	self.Append_Own1_PrepAddr2					:=	if(ri.Append_NameAddrInd	=	'O1',ri.Append_PrepAddr2,le.Append_Own1_PrepAddr2);
	self.Append_Own2_PrepAddr1					:=	if(ri.Append_NameAddrInd	=	'O2',ri.Append_PrepAddr1,le.Append_Own2_PrepAddr1);
	self.Append_Own2_PrepAddr2					:=	if(ri.Append_NameAddrInd	=	'O2',ri.Append_PrepAddr2,le.Append_Own2_PrepAddr2);
	self.Append_Reg1_PrepAddr1					:=	if(ri.Append_NameAddrInd	=	'R1',ri.Append_PrepAddr1,le.Append_Reg1_PrepAddr1);
	self.Append_Reg1_PrepAddr2					:=	if(ri.Append_NameAddrInd	=	'R1',ri.Append_PrepAddr2,le.Append_Reg1_PrepAddr2);
	self.Append_Reg2_PrepAddr1					:=	if(ri.Append_NameAddrInd	=	'R2',ri.Append_PrepAddr1,le.Append_Reg2_PrepAddr1);
	self.Append_Reg2_PrepAddr2					:=	if(ri.Append_NameAddrInd	=	'R2',ri.Append_PrepAddr2,le.Append_Reg2_PrepAddr2);
	
	self.Append_Own1_RawAID							:=	if(ri.Append_NameAddrInd	=	'O1',ri.AIDWork_RawAID,le.Append_Own1_RawAID);
	self.Append_Own2_RawAID							:=	if(ri.Append_NameAddrInd	=	'O2',ri.AIDWork_RawAID,le.Append_Own2_RawAID);
	self.Append_Reg1_RawAID							:=	if(ri.Append_NameAddrInd	=	'R1',ri.AIDWork_RawAID,le.Append_Reg1_RawAID);
	self.Append_Reg2_RawAID							:=	if(ri.Append_NameAddrInd	=	'R2',ri.AIDWork_RawAID,le.Append_Reg2_RawAID);
	
	self																:=	le;
end;

dVehDonorm	:=	denormalize(	dVehAppendSeqNum_Dist,
																dVehAppendAIDCombined_Dist,
																left.Append_SeqNum	=	right.Append_SeqNum,
																tDenormAddress(left,right),
																local
															);

// reformat to vehicles V2
VehicleV2.Layout_temp_module.Layout_vehiclesV2_slim	tFormat(rAppendVeh_layout	pInput)	:=
transform
	self	:=	pInput;
end;

dVehicleV2Slim	:=	project(dVehDonorm,tFormat(left));

//valid VIN by join with VINA 
VehicleV2.Mac_validVIN(dVehicleV2Slim,validvin_out)

//patch descriptions from codesV3
VehicleV2.MAC_Patch_Desc_by_codesV3(validvin_out,VehicleV2.Layout_temp_module.Layout_vehiclesV2_slim,true,veh_patch_desc_out)

export	File_Vehicles	:=	veh_patch_desc_out	:	persist('~thor_data400::persist::vehiclesV2_slim');