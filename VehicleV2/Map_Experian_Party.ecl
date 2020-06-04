import	AID,codes,header,ut,vehicleV2,VehicleCodes,vehlic,STD;

dExpPartyTmp	:=	vehicleV2.Map_Experian_Party_Temp;

// dExpPartyTmp	:=	dataset('~thor_data400::persist::vehiclev2::experian_party_temp',vehiclev2.Layout_Experian.Layout_Experian_Updating_as_VehicleV2,thor);

// Reformat owners to the common party layout
VehicleV2.Layout_Base.Party_AID	tReformatOwner(VehicleV2.Layout_Experian.Layout_Experian_Updating_as_VehicleV2	pInput)	:=
transform
	self.date_first_seen								:=	pInput.Dt_First_Seen;
	self.date_last_seen 								:=	pInput.Dt_Last_Seen;
	self.date_vendor_first_reported			:=	pInput.Dt_Vendor_First_Reported;
	self.date_vendor_last_reported 			:=	pInput.Dt_Vendor_Last_Reported;
	self.ttl_number											:=	pInput.Title_NumberxBG9;
	self.ttl_previous_issue_date		    :=	pInput.Previous_Title_Issue_Date;
	self.ttl_rollup_count               :=	1;
	self.ttl_status_code								:=	pInput.Title_Status_Code;
	self.Ttl_Odometer_Mileage						:=	pInput.Odometer_Mileage;
	self.Ttl_Odometer_Status_Code				:=	pInput.Odometer_Status;
	self.Ttl_Odometer_Date							:=	pInput.Odometer_Date;
	
	self.Append_Ace1_PrepAddr1					:=	pInput.Append_MailPrepAddr1;
	self.Append_Ace1_PrepAddr2					:=	pInput.Append_MailPrepAddr2;
	self.Append_Ace1_RawAID							:=	pInput.Append_MailRawAID;
	self.Append_Ace2_PrepAddr1					:=	pInput.Append_PhysicalPrepAddr1;
	self.Append_Ace2_PrepAddr2					:=	pInput.Append_PhysicalPrepAddr2;
	self.Append_Ace2_RawAID							:=	pInput.Append_PhysicalAddrRawAID;
	
	self																:=	pInput;
	self																:=	[];
end;

dExpOwners	:=	project(dExpPartyTmp(orig_name_type	in	['1','2','7']),tReformatOwner(left));

// Reformat registrants to the common party layout
VehicleV2.Layout_Base.Party_AID	tReformatReg(VehicleV2.Layout_Experian.Layout_Experian_Updating_as_VehicleV2	pInput)	:=
transform
	self.History												:=	pInput.history;
	self.date_first_seen								:=	pInput.Dt_First_Seen;
	self.date_last_seen									:=	pInput.Dt_Last_Seen;
	self.date_vendor_first_reported			:=	pInput.Dt_Vendor_First_Reported;
	self.date_vendor_last_reported			:=	pInput.Dt_Vendor_Last_Reported;
	self.reg_first_date									:=	pInput.First_Registration_Date;
	self.reg_rollup_count								:=	1;
	self.Reg_Decal_Number								:=	pInput.Decal_Number;
	self.reg_status_code								:=	pInput.Registration_Status_Code;
	self.reg_true_license_plate					:=	pInput.True_License_Plste_Number;
	self.reg_license_plate							:=	pInput.License_Plate_NumberxBG4;
	self.Reg_License_State							:=	pInput.License_State;
	self.reg_license_plate_type_code		:=	pInput.License_Plate_Code;
	self.reg_license_plate_Type_Desc		:=	VehicleCodes.GetLicensePlate(pInput.License_Plate_Code);
	self.Reg_Previous_License_State			:=	pInput.Previous_License_State;
	self.Reg_Previous_License_Plate			:=	pInput.Previous_License_Plate_Number;

	self.Append_Ace1_PrepAddr1					:=	pInput.Append_MailPrepAddr1;
	self.Append_Ace1_PrepAddr2					:=	pInput.Append_MailPrepAddr2;
	self.Append_Ace1_RawAID							:=	pInput.Append_MailRawAID;
	self.Append_Ace2_PrepAddr1					:=	pInput.Append_PhysicalPrepAddr1;
	self.Append_Ace2_PrepAddr2					:=	pInput.Append_PhysicalPrepAddr2;
	self.Append_Ace2_RawAID							:=	pInput.Append_PhysicalAddrRawAID;
	
	self																:=	pInput;
	self																:=	[];
end;

dExpRegistrants	:=	project(dExpPartyTmp(orig_name_type	in	['4','5']),tReformatReg(left));

dExpCombined	:=	dExpOwners	+	dExpRegistrants;

// Normalize party records by address

// Append sequence number
ut.MAC_Sequence_Records(dExpCombined,Append_SeqNum,dExpPartyAppendSeqNum);

dExpPartyAppendSeqNumDist	:=	distribute(dExpPartyAppendSeqNum,hash(Append_SeqNum));

VehicleV2.Layout_Base.Party_AID	tNormalizeAddr(dExpPartyAppendSeqNumDist	pInput,integer	cnt)	:=
transform
	self.Append_AddressInd	:=	choose(cnt,'M','P');
	self.Append_PrepAddr1		:=	choose(cnt,pInput.Append_Ace1_PrepAddr1,pInput.Append_Ace2_PrepAddr1);
	self.Append_PrepAddr2		:=	choose(cnt,pInput.Append_Ace1_PrepAddr2,pInput.Append_Ace2_PrepAddr2);
	self.Append_RawAID			:=	choose(cnt,pInput.Append_Ace1_RawAID,pInput.Append_Ace2_RawAID);
	self										:=	pInput;
end;

dExpPartyNormalizeAddr	:=	normalize(dExpPartyAppendSeqNumDist,2,tNormalizeAddr(left,counter),local);

dExpPartyAddrPopulated		:=	dExpPartyNormalizeAddr(Append_PrepAddr2	!=	'');
dExpPartyAddrNotPopulated	:=	dExpPartyNormalizeAddr(Append_PrepAddr2	=		'');

// Pass to the Address ID macro to get the cleaned addresses
unsigned4	lAIDAppendFlags	:=	AID.Common.eReturnValues.RawAID	|
															AID.Common.eReturnValues.ACECacheRecords;
		
AID.MacAppendFromRaw_2Line(	dExpPartyAddrPopulated,
														Append_PrepAddr1,
														Append_PrepAddr2,
														Append_RawAID,
														dExpPartyAppendCleanAddr,
														lAIDAppendFlags
													);

VehicleV2.Layout_Base.Party_AID	tMapAceAddress(dExpPartyAppendCleanAddr	pInput):=
transform
	self.Append_RawAID						:=	pInput.AIDWork_RawAID;
	self.AID_ACEClean_prim_range	:=	pInput.AIDWork_AceCache.prim_range;
	self.AID_ACEClean_predir			:=	pInput.AIDWork_AceCache.predir;
	self.AID_ACEClean_prim_name		:=	pInput.AIDWork_AceCache.prim_name;
	self.AID_ACEClean_addr_suffix	:=	pInput.AIDWork_AceCache.addr_suffix;
	self.AID_ACEClean_postdir			:=	pInput.AIDWork_AceCache.postdir;
	self.AID_ACEClean_unit_desig	:=	pInput.AIDWork_AceCache.unit_desig;
	self.AID_ACEClean_sec_range		:=	pInput.AIDWork_AceCache.sec_range;
	self.AID_ACEClean_p_city_name	:=	pInput.AIDWork_AceCache.p_city_name;
	self.AID_ACEClean_v_city_name	:=	pInput.AIDWork_AceCache.v_city_name;
	self.AID_ACEClean_st					:=	pInput.AIDWork_AceCache.st;
	self.AID_ACEClean_zip					:=	pInput.AIDWork_AceCache.zip5;
	self.AID_ACEClean_zip4				:=	pInput.AIDWork_AceCache.zip4;
	self.AID_ACEClean_cart				:=	pInput.AIDWork_AceCache.cart;
	self.AID_ACEClean_cr_sort_sz	:=	pInput.AIDWork_AceCache.cr_sort_sz;
	self.AID_ACEClean_lot					:=	pInput.AIDWork_AceCache.lot;
	self.AID_ACEClean_lot_order		:=	pInput.AIDWork_AceCache.lot_order;
	self.AID_ACEClean_dbpc				:=	pInput.AIDWork_AceCache.dbpc;
	self.AID_ACEClean_chk_digit		:=	pInput.AIDWork_AceCache.chk_digit;
	self.AID_ACEClean_record_type	:=	pInput.AIDWork_AceCache.rec_type;
	self.AID_ACEClean_ace_fips_st	:=	pInput.AIDWork_AceCache.county[1..2];
	self.AID_ACEClean_fipscounty	:=	pInput.AIDWork_AceCache.county[3..5];
	self.AID_ACEClean_geo_lat			:=	pInput.AIDWork_AceCache.geo_lat;
	self.AID_ACEClean_geo_long		:=	pInput.AIDWork_AceCache.geo_long;
	self.AID_ACEClean_msa					:=	pInput.AIDWork_AceCache.msa;
	self.AID_ACEClean_geo_blk			:=	pInput.AIDWork_AceCache.geo_blk;
	self.AID_ACEClean_geo_match		:=	pInput.AIDWork_AceCache.geo_match;
	self.AID_ACEClean_err_stat		:=	pInput.AIDWork_AceCache.err_stat;
	self 													:=	pInput;
end;

dExpPartyAppendCleanAID	:=		project(dExpPartyAppendCleanAddr,tMapAceAddress(left));

dExpPartyAID	:=	dExpPartyAppendCleanAID	+	dExpPartyAddrNotPopulated;

dExpPartyAIDDist	:=	distribute(dExpPartyAID,hash(Append_SeqNum));

// Denormalize party records
VehicleV2.Layout_Base.Party_AID	tDenormalizeParty(dExpPartyAppendSeqNumDist	le,dExpPartyAIDDist	ri)	:=
transform
	self.Append_Ace1_PrepAddr1	:=	if(ri.Append_AddressInd	=	'M',ri.Append_PrepAddr1,le.Append_Ace1_PrepAddr1);
	self.Append_Ace1_PrepAddr2	:=	if(ri.Append_AddressInd	=	'M',ri.Append_PrepAddr2,le.Append_Ace1_PrepAddr2);
	self.Append_Ace1_RawAID			:=	if(ri.Append_AddressInd	=	'M',ri.Append_RawAID,le.Append_Ace1_RawAID);
	self.Append_Ace2_PrepAddr1	:=	if(ri.Append_AddressInd	=	'P',ri.Append_PrepAddr1,le.Append_Ace2_PrepAddr1);
	self.Append_Ace2_PrepAddr2	:=	if(ri.Append_AddressInd	=	'P',ri.Append_PrepAddr2,le.Append_Ace2_PrepAddr2);
	self.Append_Ace2_RawAID			:=	if(ri.Append_AddressInd	=	'P',ri.Append_RawAID,le.Append_Ace2_RawAID);
	
	self.Ace1_prim_range				:=	if(ri.Append_AddressInd	=	'M',ri.AID_AceClean_prim_range,le.Ace1_prim_range);
	self.Ace1_predir						:=	if(ri.Append_AddressInd	=	'M',ri.AID_AceClean_predir,le.Ace1_predir);
	self.Ace1_prim_name					:=	if(ri.Append_AddressInd	=	'M',ri.AID_AceClean_prim_name,le.Ace1_prim_name);
	self.Ace1_addr_suffix				:=	if(ri.Append_AddressInd	=	'M',ri.AID_AceClean_addr_suffix,le.Ace1_addr_suffix);
	self.Ace1_postdir						:=	if(ri.Append_AddressInd	=	'M',ri.AID_AceClean_postdir,le.Ace1_postdir);
	self.Ace1_unit_desig				:=	if(ri.Append_AddressInd	=	'M',ri.AID_AceClean_unit_desig,le.Ace1_unit_desig);
	self.Ace1_sec_range					:=	if(ri.Append_AddressInd	=	'M',ri.AID_AceClean_sec_range,le.Ace1_sec_range);
	self.Ace1_p_city_name				:=	if(ri.Append_AddressInd	=	'M',ri.AID_AceClean_p_city_name,le.Ace1_p_city_name);
	self.Ace1_v_city_name				:=	if(ri.Append_AddressInd	=	'M',ri.AID_AceClean_v_city_name,le.Ace1_v_city_name);
	self.Ace1_st								:=	if(ri.Append_AddressInd	=	'M',ri.AID_AceClean_st,le.Ace1_st);
	self.Ace1_zip5							:=	if(ri.Append_AddressInd	=	'M',ri.AID_AceClean_zip,le.Ace1_zip5);
	self.Ace1_zip4							:=	if(ri.Append_AddressInd	=	'M',ri.AID_AceClean_zip4,le.Ace1_zip4);
	self.Ace1_addr_rec_type			:=	if(ri.Append_AddressInd	=	'M',ri.AID_AceClean_record_type,le.Ace1_addr_rec_type);
	self.Ace1_fips_state				:=	if(ri.Append_AddressInd	=	'M',ri.AID_AceClean_ace_fips_st,le.Ace1_fips_state);
	self.Ace1_fips_county				:=	if(ri.Append_AddressInd	=	'M',ri.AID_AceClean_fipscounty,le.Ace1_fips_county);
	self.Ace1_geo_lat						:=	if(ri.Append_AddressInd	=	'M',ri.AID_AceClean_geo_lat,le.Ace1_geo_lat);
	self.Ace1_geo_long					:=	if(ri.Append_AddressInd	=	'M',ri.AID_AceClean_geo_long,le.Ace1_geo_long);
	self.Ace1_cbsa							:=	if(ri.Append_AddressInd	=	'M',ri.AID_AceClean_msa,le.Ace1_cbsa);
	self.Ace1_geo_blk						:=	if(ri.Append_AddressInd	=	'M',ri.AID_AceClean_geo_blk,le.Ace1_geo_blk);
	self.Ace1_geo_match					:=	if(ri.Append_AddressInd	=	'M',ri.AID_AceClean_geo_match,le.Ace1_geo_match);
	self.Ace1_err_stat					:=	if(ri.Append_AddressInd	=	'M',ri.AID_AceClean_err_stat,le.Ace1_err_stat);
	
	self.Ace2_prim_range				:=	if(ri.Append_AddressInd	=	'P',ri.AID_AceClean_prim_range,le.Ace2_prim_range);
	self.Ace2_predir						:=	if(ri.Append_AddressInd	=	'P',ri.AID_AceClean_predir,le.Ace2_predir);
	self.Ace2_prim_name					:=	if(ri.Append_AddressInd	=	'P',ri.AID_AceClean_prim_name,le.Ace2_prim_name);
	self.Ace2_addr_suffix				:=	if(ri.Append_AddressInd	=	'P',ri.AID_AceClean_addr_suffix,le.Ace2_addr_suffix);
	self.Ace2_postdir						:=	if(ri.Append_AddressInd	=	'P',ri.AID_AceClean_postdir,le.Ace2_postdir);
	self.Ace2_unit_desig				:=	if(ri.Append_AddressInd	=	'P',ri.AID_AceClean_unit_desig,le.Ace2_unit_desig);
	self.Ace2_sec_range					:=	if(ri.Append_AddressInd	=	'P',ri.AID_AceClean_sec_range,le.Ace2_sec_range);
	self.Ace2_p_city_name				:=	if(ri.Append_AddressInd	=	'P',ri.AID_AceClean_p_city_name,le.Ace2_p_city_name);
	self.Ace2_v_city_name				:=	if(ri.Append_AddressInd	=	'P',ri.AID_AceClean_v_city_name,le.Ace2_v_city_name);
	self.Ace2_st								:=	if(ri.Append_AddressInd	=	'P',ri.AID_AceClean_st,le.Ace2_st);
	self.Ace2_zip5							:=	if(ri.Append_AddressInd	=	'P',ri.AID_AceClean_zip,le.Ace2_zip5);
	self.Ace2_zip4							:=	if(ri.Append_AddressInd	=	'P',ri.AID_AceClean_zip4,le.Ace2_zip4);
	self.Ace2_addr_rec_type			:=	if(ri.Append_AddressInd	=	'P',ri.AID_AceClean_record_type,le.Ace2_addr_rec_type);
	self.Ace2_fips_state				:=	if(ri.Append_AddressInd	=	'P',ri.AID_AceClean_ace_fips_st,le.Ace2_fips_state);
	self.Ace2_fips_county				:=	if(ri.Append_AddressInd	=	'P',ri.AID_AceClean_fipscounty,le.Ace2_fips_county);
	self.Ace2_geo_lat						:=	if(ri.Append_AddressInd	=	'P',ri.AID_AceClean_geo_lat,le.Ace2_geo_lat);
	self.Ace2_geo_long					:=	if(ri.Append_AddressInd	=	'P',ri.AID_AceClean_geo_long,le.Ace2_geo_long);
	self.Ace2_cbsa							:=	if(ri.Append_AddressInd	=	'P',ri.AID_AceClean_msa,le.Ace2_cbsa);
	self.Ace2_geo_blk						:=	if(ri.Append_AddressInd	=	'P',ri.AID_AceClean_geo_blk,le.Ace2_geo_blk);
	self.Ace2_geo_match					:=	if(ri.Append_AddressInd	=	'P',ri.AID_AceClean_geo_match,le.Ace2_geo_match);
	self.Ace2_err_stat					:=	if(ri.Append_AddressInd	=	'P',ri.AID_AceClean_err_stat,le.Ace2_err_stat);
	self												:=	le;
end;

dExpPartyDenorm	:=	denormalize(	dExpPartyAppendSeqNumDist,
																	dExpPartyAIDDist,
																	left.append_seqnum	=	right.append_seqnum,
																	tDenormalizeParty(left,right),
																	local
																);

// Bring back to the temp base layout
VehicleV2.Layout_Base.Party_CCPA	tReformat2V2(dExpPartyDenorm	pInput)	:=
transform
	boolean	isMailCityNotBlank	:=	pInput.Ace1_v_city_name	!=	'';
	
	self.ace_prim_range			:=	if(isMailCityNotBlank,pInput.Ace1_prim_range,pInput.Ace2_prim_range);
	self.ace_predir					:=	if(isMailCityNotBlank,pInput.Ace1_predir,pInput.Ace2_predir);
	self.ace_prim_name			:=	if(isMailCityNotBlank,pInput.Ace1_prim_name,pInput.Ace2_prim_name);
	self.ace_addr_suffix		:=	if(isMailCityNotBlank,pInput.Ace1_addr_suffix,pInput.Ace2_addr_suffix);
	self.ace_postdir				:=	if(isMailCityNotBlank,pInput.Ace1_postdir,pInput.Ace2_postdir);
	self.ace_unit_desig			:=	if(isMailCityNotBlank,pInput.Ace1_unit_desig,pInput.Ace2_unit_desig);
	self.ace_sec_range			:=	if(isMailCityNotBlank,pInput.Ace1_sec_range,pInput.Ace2_sec_range);
	self.ace_p_city_name		:=	if(isMailCityNotBlank,pInput.Ace1_p_city_name,pInput.Ace2_p_city_name);
	self.ace_v_city_name		:=	if(isMailCityNotBlank,pInput.Ace1_v_city_name,pInput.Ace2_v_city_name);
	self.ace_st							:=	if(isMailCityNotBlank,pInput.Ace1_st,pInput.Ace2_st);
	self.ace_zip5						:=	if(isMailCityNotBlank,pInput.Ace1_zip5,pInput.Ace2_zip5);
	self.ace_zip4						:=	if(isMailCityNotBlank,pInput.Ace1_zip4,pInput.Ace2_zip4);
	self.ace_addr_rec_type	:=	if(isMailCityNotBlank,pInput.Ace1_addr_rec_type,pInput.Ace2_addr_rec_type);
	self.ace_fips_state			:=	if(isMailCityNotBlank,pInput.Ace1_fips_state,pInput.Ace2_fips_state);
	self.ace_fips_county		:=	if(isMailCityNotBlank,pInput.Ace1_fips_county,pInput.Ace2_fips_county);
	self.ace_geo_lat				:=	if(isMailCityNotBlank,pInput.Ace1_geo_lat,pInput.Ace2_geo_lat);
	self.ace_geo_long				:=	if(isMailCityNotBlank,pInput.Ace1_geo_long,pInput.Ace2_geo_long);
	self.ace_cbsa						:=	if(isMailCityNotBlank,pInput.Ace1_cbsa,pInput.Ace2_cbsa);
	self.ace_geo_blk				:=	if(isMailCityNotBlank,pInput.Ace1_geo_blk,pInput.Ace2_geo_blk);
	self.ace_geo_match			:=	if(isMailCityNotBlank,pInput.Ace1_geo_match,pInput.Ace2_geo_match);
	self.ace_err_stat				:=	if(isMailCityNotBlank,pInput.Ace1_err_stat,pInput.Ace2_err_stat);
	//Added for CCPA-103
	// self.global_sid         := 0;
	// self.record_sid         := 0;
	//Added for DF-25578
	self.raw_name           := pInput.raw_name;
	
	self										:=	pInput;
end;

dExpPartyCleanAddr	:=	project(dExpPartyDenorm,tReformat2V2(left));

// Rollup for a set of owner/lienholder/title
dExperianOwnerDist	:=	distribute(	dExpPartyCleanAddr(orig_name_type	in	['1','2','7']),
																		hash(vehicle_key,iteration_key)
																	);
 
dExperianOwnerSort :=	sort(	dExperianOwnerDist,
														vehicle_key,
														-iteration_key,
														orig_name_type,
														orig_ssn,
														orig_fein,
														orig_name,
														orig_dob,
														ace_prim_range,
														ace_predir,
														ace_prim_name,
														ace_addr_suffix,
														ace_postdir,
														ace_unit_desig,
														ace_sec_range,
														ace_st,
														ace_zip5,
														ttl_number,
														ttl_status_code,
														previous_title_state,
														-date_vendor_last_reported,
														-title_issue_date,
														ttl_previous_issue_date,
														orig_lien_date,
														local
													);

VehicleV2.Layout_Base.Party_CCPA tOwnerRollup(dExperianOwnerSort	le,dExperianOwnerSort	ri) :=
transform
	self.ttl_earliest_issue_date		:=	vehiclev2.validate_date.fEarliestNonZeroDate(	le.title_issue_date,
																																										ri.title_issue_date
																																									);
	self.ttl_latest_issue_date   		:=	vehiclev2.validate_date.fLatestNonZeroDate(	le.title_issue_date,
																																									ri.title_issue_date
																																								);
	self.ttl_rollup_count        		:=	le.ttl_rollup_count	+	1;
	self.date_first_seen						:=	(unsigned)vehiclev2.validate_date.fEarliestNonZeroDate((string8)le.date_first_seen,(string8)ri.date_first_seen);
	self.date_last_seen							:=	(unsigned)vehiclev2.validate_date.fLatestNonZeroDate((string8)le.date_last_seen,(string8)ri.date_last_seen);
	self.date_vendor_first_reported	:=	(unsigned)vehiclev2.validate_date.fEarliestNonZeroDate((string8)le.date_vendor_first_reported,(string8)ri.date_vendor_first_reported);
	self.date_vendor_last_reported 	:=	(unsigned)vehiclev2.validate_date.fLatestNonZeroDate((string8)le.date_vendor_last_reported,(string8)ri.date_vendor_last_reported);
	self.orig_ssn										:=	if(le.orig_ssn	<>	'',le.orig_ssn,ri.orig_ssn);
	self.orig_fein									:=	if(le.orig_fein	<>	'',le.orig_fein,ri.orig_fein);
	self.orig_dob										:=	if(le.orig_dob	<>	'',le.orig_dob,ri.orig_dob); 
	self.ttl_previous_issue_date		:=	if(le.ttl_previous_issue_date	<>	'',le.ttl_previous_issue_date,ri.ttl_previous_issue_date);
	self.orig_lien_date							:=	if(le.orig_lien_date	<>	'',le.orig_lien_date,ri.orig_lien_date);
	self.source_rec_id							:=  if(le.source_rec_id<>0,if(le.source_rec_id<ri.source_rec_id,le.source_rec_id,ri.source_rec_id),0);
	
	self														:=	le;
end;

dOwnersRollup :=	rollup(	dExperianOwnerSort,
													left.vehicle_key 							= right.vehicle_key
													and left.iteration_key 				= right.iteration_key
													and left.orig_name_type 			= right.orig_name_type
													and ut.nneq(left.orig_ssn,right.orig_ssn)
													and ut.nneq(left.orig_fein,right.orig_fein)
													and left.orig_name 						= right.orig_name
													and ut.nneq(left.orig_dob,right.orig_dob) 
													and left.ace_prim_range 			= right.ace_prim_range
													and left.ace_predir 					= right.ace_predir
													and left.ace_prim_name 				= right.ace_prim_name
													and left.ace_addr_suffix 			= right.ace_addr_suffix
													and left.ace_postdir 					= right.ace_postdir
													and left.ace_unit_desig 			= right.ace_unit_desig
													and left.ace_sec_range 				= right.ace_sec_range
													and left.ace_st 							= right.ace_st
													and left.ace_zip5 						= right.ace_zip5
													and left.ttl_number 					= right.ttl_number
													and ut.nneq(left.ttl_previous_issue_date ,right.ttl_previous_issue_date)
													and left.ttl_status_code 			=	right.ttl_status_code
													and left.previous_title_state	=	right.previous_title_state
													and ut.nneq(left.orig_lien_date,right.orig_lien_date),
													townerrollup(left,right),
													local
												);

// Assign sequence key for owners
VehicleV2.Layout_Base.Party_CCPA	tOwnerSequenceKey(dOwnersRollup	pInput)	:=
transform
	self.ttl_earliest_issue_date	:=	if(pInput.ttl_rollup_count	=	1,pInput.title_issue_date,pInput.ttl_earliest_issue_date);
	self.ttl_latest_issue_date		:=	if(pInput.ttl_rollup_count	=	1,pInput.title_issue_date,pInput.ttl_latest_issue_date);
	//DF-16772. Modified to remove warning messae substring applied to value of type integer.
	self.sequence_key							:=	self.ttl_latest_issue_date	+	((string8) pInput.date_vendor_last_reported)[1..6]	+	'O';
	self													:=	pInput;
end;

dOwnerSeqKey	:=	project(dOwnersRollup,tOwnerSequenceKey(left));

// Setup owner flag fields
dOwnerVehicleFlag	:=	VehicleV2.Mac_Setup_Latest_VehFlag.owner_latest_vehflag(dOwnerSeqKey,true);

// Rollup for a set of registration and lessee records
dExperianRegDist	:=	distribute(	dExpPartyCleanAddr(orig_name_type	in	['4','5']),
																	hash(vehicle_key,iteration_key)
																);

string8 yyyymmdd(string	date_field)	:=	if(length(date_field)	= 6,date_field	+	'01',date_field);

dExperianRegSort :=	sort(	dExperianRegDist,                                        
													vehicle_key,
													-iteration_key,
													orig_name_type,
													orig_ssn,
													orig_fein,
													orig_name,
													orig_dob,
													ace_prim_range,
													ace_predir,
													ace_prim_name,
													ace_addr_suffix,
													ace_postdir,
													ace_unit_desig,
													ace_sec_range,
													ace_st,
													ace_zip5,
													reg_license_plate,
													reg_first_date,
													reg_status_code,
													reg_license_plate_type_code,
													reg_true_license_plate,
													-date_vendor_last_reported,
													local
												);

VehicleV2.Layout_Base.Party_CCPA	tRegRollup(dExperianRegSort	le,dExperianRegSort	ri)	:=
transform
	self.reg_earliest_effective_date	:=	vehiclev2.validate_date.fEarliestNonZeroDate(le.registration_effective_date,ri.registration_effective_date);
	self.reg_latest_effective_date		:=	vehiclev2.validate_date.fLatestNonZeroDate(le.registration_effective_date,ri.registration_effective_date);
	self.reg_latest_expiration_date		:=	vehiclev2.validate_date.fLatestNonZeroDate(yyyymmdd(le.registration_expiration_date),yyyymmdd(ri.registration_expiration_date));
	self.reg_rollup_count							:=	le.reg_rollup_count + 1;
	self.reg_decal_number							:=	if(le.registration_effective_date > ri.registration_effective_date,le.reg_decal_number,ri.reg_decal_number);
	self.date_first_seen							:=	(unsigned)vehiclev2.validate_date.fEarliestNonZeroDate((string8)le.date_first_seen,(string8)ri.date_first_seen);
	self.date_last_seen								:=	(unsigned)vehiclev2.validate_date.fLatestNonZeroDate((string8)le.date_last_seen, (string8)ri.date_last_seen);
	self.date_vendor_first_reported		:=	(unsigned)vehiclev2.validate_date.fEarliestNonZeroDate((string8)le.date_vendor_first_reported,(string8)ri.date_vendor_first_reported);
	self.date_vendor_last_reported		:=	(unsigned)vehiclev2.validate_date.fLatestNonZeroDate((string8)le.date_vendor_last_reported,(string8)ri.date_vendor_last_reported);
	self.orig_ssn											:=	if(le.orig_ssn <> '',le.orig_ssn,ri.orig_ssn);
	self.orig_fein										:=	if(le.orig_fein <> '',le.orig_fein,ri.orig_fein);
	self.orig_dob											:=	if(le.orig_dob <> '',le.orig_dob,ri.orig_dob); 
	self.reg_license_plate						:=	if(le.reg_license_plate <> '',le.reg_license_plate,ri.reg_license_plate);
	self.reg_first_date								:=	if(le.reg_first_date <> '',le.reg_first_date,ri.reg_first_date);
	self.reg_true_license_plate				:=	if(le.reg_true_license_plate <> '',le.reg_true_license_plate,ri.reg_true_license_plate);
	self															:=	le;
end;

dExperianRegRollup	:=	rollup(	dExperianRegSort,						  
																header.ConvertYYYYMMToNumberOfMonths((integer)Right.registration_effective_date)	<	Header.ConvertYYYYMMToNumberOfMonths((integer)left.registration_expiration_date)	+	2
																and left.vehicle_key									=	right.vehicle_key
																and left.iteration_key								=	right.iteration_key
																and left.orig_name_type								=	right.orig_name_type
																and ut.nneq(left.orig_ssn,right.orig_ssn)
																and ut.nneq(left.orig_fein,right.orig_fein)
																and left.orig_name										=	right.orig_name
																and ut.nneq(left.orig_dob,right.orig_dob) 
																and left.ace_prim_range								=	right.ace_prim_range
																and left.ace_predir										=	right.ace_predir
																and left.ace_prim_name								=	right.ace_prim_name
																and left.ace_addr_suffix							=	right.ace_addr_suffix
																and left.ace_postdir									=	right.ace_postdir
																and left.ace_unit_desig								=	right.ace_unit_desig
																and left.ace_sec_range								=	right.ace_sec_range
																and left.ace_st												=	right.ace_st
																and left.ace_zip5											=	right.ace_zip5
																and ut.nneq(left.reg_license_plate,right.reg_license_plate)
																and ut.nneq(left.reg_first_date,right.reg_first_date)
																and left.reg_status_code							=	right.reg_status_code
																and left.reg_license_plate_type_code	=	right.reg_license_plate_type_code
																and ut.nneq(left.reg_true_license_plate,right.reg_true_license_plate),
																tregrollup(left,right),
																local
															);
								  
// Assign sequence key for registrants
//DF-16772. Modified to remove warning messae substring applied to value of type integer.
ConvertYYYYMMToNumberOfMonths(string	pInput)	:=	(integer) pInput[1..4]*12 + (integer) pInput[5..6];

VehicleV2.Layout_Base.Party_CCPA	tRegSequnceKey(dExperianRegRollup	pInput)	:=
transform
  // set-up to handle cases where the latest expiration date is way in the future
  // if the latest expiration date is 10 years in the future,don't use it (unless it's the only one)
	//DF-16772. Modified to remove warning messae substring applied to value of type integer.
  integer nbr_months_lt_exp_dt			:=	ConvertYYYYMMToNumberOfMonths(pInput.reg_latest_expiration_date);
  integer nbr_months_today     			:=	ConvertYYYYMMToNumberOfMonths((STRING8)Std.Date.Today());
  
	self.reg_earliest_effective_date	:=	if(pInput.reg_rollup_count	=	1,pInput.registration_effective_date,pInput.reg_earliest_effective_date);
	self.reg_latest_effective_date		:=	if(pInput.reg_rollup_count	=	1,pInput.registration_effective_date,pInput.reg_latest_effective_date);
	self.reg_latest_expiration_date		:=	if(pInput.reg_rollup_count	=	1	or	nbr_months_lt_exp_dt-nbr_months_today	>	120,pInput.registration_expiration_date,pInput.reg_latest_expiration_date);
	//DF-16772. Modified to remove warning messae substring applied to value of type integer.
	self.sequence_key									:=	self.reg_latest_effective_date	+	((string8)pInput.date_vendor_last_reported)[1..6]	+	'R';
	self															:=	pInput;
end;

dRegSeqKey	:=	project(dExperianRegRollup,tRegSequnceKey(left));

// Setup registrant flag fields
dRegVehicleFlag	:=	VehicleV2.Mac_Setup_Latest_VehFlag.reg_latest_vehflag(dRegSeqKey,true);

export Map_Experian_Party	:=	dOwnerVehicleFlag	+	dRegVehicleFlag	:	persist('~thor_data400::persist::vehicleV2::experian_party');