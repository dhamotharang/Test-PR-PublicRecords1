import	header,ut;
//---------------------------------------------------------------------------
//-------ROLLUP OH PARTY FILE
//---------------------------------------------------------------------------

// OH temporary party file
dOHTempParty	:=	VehicleV2.Mapping_OH_Temp_Party(orig_name	!=	'');

// dOHTempParty	:=	dataset('~thor_data400::persist::vehicleV2::OH_temp_party',VehicleV2.Layout_Base.Party_CCPA,thor)(orig_name	!=	'');

dOHTempPartyDist	:=	distribute(dOHTempParty,hash(vehicle_key,iteration_key));

dOHTempPartySort	:=	sort(	dOHTempPartyDist,                                       
															vehicle_key,
															-Iteration_Key,
															Reg_License_Plate,
															Reg_Status_Code,
															Reg_License_Plate_Type_Code,
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

VehicleV2.Layout_Base.Party_CCPA	trollup(dOHTempPartySort	le,dOHTempPartySort	ri)	:=
transform
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
	//Added for CCPA-103
	// self.global_sid                   := 0;
	// self.record_sid                   := 0;
	//Added for DF-25578
	// self.raw_name                     := '';

	self															:=	le;


end;

dOHPartyRollup	:=	rollup(	dOHTempPartySort,						  
														Header.ConvertYYYYMMToNumberOfMonths((integer)Right.REGISTRATION_EFFECTIVE_DATE) < Header.ConvertYYYYMMToNumberOfMonths((integer)Left.REGISTRATION_EXPIRATION_DATE) + 2
														and left.vehicle_key									=	right.vehicle_key
														and left.Iteration_Key								=	right.Iteration_Key
														and left.Reg_Status_Code							=	right.Reg_Status_Code
														and left.Reg_License_Plate_Type_Code	=	right.Reg_License_Plate_Type_Code
														and ut.NNEQ(left.Reg_License_Plate,right.Reg_License_Plate)
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

VehicleV2.Layout_Base.Party_CCPA	tdate(dOHPartyRollup	pInput)	:=
transform
	self.Ttl_Earliest_Issue_Date			:=	pInput.TITLE_ISSUE_DATE;
	self.Ttl_Latest_Issue_Date				:=	pInput.TITLE_ISSUE_DATE;
	self.Reg_Earliest_Effective_Date	:=	if(pInput.Reg_Rollup_Count	=	1,pInput.REGISTRATION_EFFECTIVE_DATE,pInput.Reg_Earliest_Effective_Date);
	self.Reg_Latest_Effective_Date		:=	if(pInput.Reg_Rollup_Count	=	1,pInput.REGISTRATION_EFFECTIVE_DATE,pInput.Reg_Latest_Effective_Date);
	self.Reg_Latest_Expiration_Date		:=	if(pInput.Reg_Rollup_Count	=	1,pInput.REGISTRATION_Expiration_DATE,pInput.Reg_latest_Expiration_Date);
	//DF-16772. Modified to remove warning messae substring applied to value of type integer.
	self.sequence_key									:=	self.Reg_Latest_Effective_Date	+	((string8)pInput.date_vendor_Last_Reported)[1..6]	+	'R';	

	self															:=	pInput;

end;

dOHPartySequenceKey	:=	project(dOHPartyRollup,tdate(left));

// setup flag fields
dOHParty	:=	VehicleV2.Mac_Setup_Latest_VehFlag.OH_reg_latest_vehflag(dOHPartySequenceKey,true);

export	Mapping_OH_Party	:=	dOHParty	:	persist('~thor_data400::persist::vehicleV2::oh_party');