import	header,ut;
//---------------------------------------------------------------------------
//-------ROLLUP MA PARTY FILE
//---------------------------------------------------------------------------

// MA temporary party file
dMATempParty	:=	VehicleV2.Mapping_MA_Temp_Party(orig_name	!=	'');

dMATempPartyDist	:=	distribute(dMATempParty,hash(vehicle_key,iteration_key));

dMATempPartySort	:=	sort(	dMATempPartyDist,                                       
															vehicle_key,
															-Iteration_Key,
															Reg_License_Plate,
															Reg_True_License_Plate,
															Orig_Party_Type,
															Orig_Name,
															Ace_prim_range,
															Ace_predir,
															Ace_prim_name,
															Ace_addr_suffix,
															Ace_postdir,
															Ace_unit_desig,
															Ace_sec_range,
															Ace_st,
															Ace_zip5,
															-date_vendor_first_reported,
															-REGISTRATION_EFFECTIVE_DATE,
															-REGISTRATION_Expiration_DATE,
															-TITLE_ISSUE_DATE,
															local
														);

VehicleV2.Layout_Base.Party_BIP	trollup(dMATempPartySort	le,dMATempPartySort	ri)	:=
transform
	self.Ttl_Earliest_Issue_Date			:=	VehicleV2.validate_date.fEarliestNonZeroDate(le.TITLE_ISSUE_DATE,ri.TITLE_ISSUE_DATE);
	self.Ttl_Latest_Issue_Date				:=	VehicleV2.validate_date.fLatestNonZeroDate(le.TITLE_ISSUE_DATE,ri.TITLE_ISSUE_DATE);
	self.Reg_Earliest_Effective_Date	:=	VehicleV2.validate_date.fEarliestNonZeroDate(le.REGISTRATION_EFFECTIVE_DATE,ri.REGISTRATION_EFFECTIVE_DATE);
	self.Reg_Latest_Effective_Date		:=	VehicleV2.validate_date.fLatestNonZeroDate(le.REGISTRATION_EFFECTIVE_DATE,ri.REGISTRATION_EFFECTIVE_DATE);
	self.Reg_Latest_Expiration_Date		:=	VehicleV2.validate_date.fLatestNonZeroDate(le.REGISTRATION_EXPIRATION_DATE,ri.REGISTRATION_EXPIRATION_DATE);
	self.Reg_Rollup_Count							:=	le.Reg_Rollup_Count	+	1;
	self.date_first_Seen							:=	(unsigned4)VehicleV2.validate_date.fEarliestNonZeroDate((string)le.date_first_Seen,(string)ri.date_first_Seen);
	self.date_last_Seen 							:=	(unsigned4)VehicleV2.validate_date.fLatestNonZeroDate((string)le.date_last_Seen,(string)ri.date_last_Seen);
	self.date_vendor_First_Reported		:=	(unsigned4)VehicleV2.validate_date.fEarliestNonZeroDate((string)le.date_vendor_First_Reported,(string)ri.date_vendor_First_Reported);
	self.date_vendor_Last_Reported		:=	(unsigned4)VehicleV2.validate_date.fLatestNonZeroDate((string)le.date_vendor_Last_Reported,(string)ri.date_vendor_Last_Reported);
	self.Reg_License_Plate						:=	if(le.Reg_License_Plate	<>	'',le.Reg_License_Plate,ri.Reg_License_Plate);
	self.Reg_True_License_Plate				:=	if(le.Reg_True_License_Plate	<>	'',le.Reg_True_License_Plate,ri.Reg_True_License_Plate);
	self.source_rec_id								:=  if(le.source_rec_id<>0,if(le.source_rec_id<ri.source_rec_id,le.source_rec_id,ri.source_rec_id),0);

	self															:=	le;


end;

dMAPartyRollup	:=	rollup(	dMATempPartySort,						  
														Header.ConvertYYYYMMToNumberOfMonths((integer)Right.REGISTRATION_EFFECTIVE_DATE) < Header.ConvertYYYYMMToNumberOfMonths((integer)Left.REGISTRATION_EXPIRATION_DATE) + 2
														and left.vehicle_key									=	right.vehicle_key
														and left.Iteration_Key								=	right.Iteration_Key
														and ut.NNEQ(left.Reg_True_License_Plate,right.Reg_True_License_Plate)
														and left.Orig_Party_Type							=	right.Orig_Party_Type
														and left.Orig_Name										=	right.Orig_Name
														and left.Ace_prim_range								=	right.Ace_prim_range
														and left.Ace_predir										=	right.Ace_predir
														and left.Ace_prim_name								=	right.Ace_prim_name
														and left.Ace_addr_suffix							=	right.Ace_addr_suffix
														and left.Ace_postdir									=	right.Ace_postdir
														and left.Ace_unit_desig								=	right.Ace_unit_desig
														and left.Ace_sec_range								=	right.Ace_sec_range
														and left.Ace_st												=	right.Ace_st
														and left.Ace_zip5											=	right.Ace_zip5,
														trollup(left,right),
														local
													);
								  
// generate sequence key for registrants/registration information
//---------------------------------------------------------------------------
//-------GENERATE SEQUENCE KEY
//---------------------------------------------------------------------------

VehicleV2.Layout_Base.Party_BIP	tdate(dMAPartyRollup	pInput)	:=
transform
	self.Ttl_Earliest_Issue_Date			:=	if(pInput.Reg_Rollup_Count	=	1,pInput.TITLE_ISSUE_DATE,pInput.Ttl_Earliest_Issue_Date);
	self.Ttl_Latest_Issue_Date				:=	if(pInput.Reg_Rollup_Count	=	1,pInput.TITLE_ISSUE_DATE,pInput.Ttl_Latest_Issue_Date);
	self.Reg_Earliest_Effective_Date	:=	if(pInput.Reg_Rollup_Count	=	1,pInput.REGISTRATION_EFFECTIVE_DATE,pInput.Reg_Earliest_Effective_Date);
	self.Reg_Latest_Effective_Date		:=	if(pInput.Reg_Rollup_Count	=	1,pInput.REGISTRATION_EFFECTIVE_DATE,pInput.Reg_Latest_Effective_Date);
	self.Reg_Latest_Expiration_Date		:=	if(pInput.Reg_Rollup_Count	=	1,pInput.REGISTRATION_Expiration_DATE,pInput.Reg_latest_Expiration_Date);
	self.sequence_key									:=	self.Reg_Latest_Effective_Date	+	(string6)pInput.date_vendor_Last_Reported[1..6]	+	'R';	

	self															:=	pInput;

end;

dMAPartySequenceKey	:=	project(dMAPartyRollup,tdate(left));

// setup flag fields
dMAParty	:=	VehicleV2.Mac_Setup_Latest_VehFlag.MA_reg_latest_vehflag(dMAPartySequenceKey,true);

EXPORT	Mapping_MA_Party	:=	dMAParty	:	persist('~thor_data400::persist::vehicleV2::ma_party');
