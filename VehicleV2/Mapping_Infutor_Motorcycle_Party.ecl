//Copied from Mapping_Infutor_Vin_Party
import	header,ut;
//---------------------------------------------------------------------------
//-------ROLLUP OH PARTY FILE
//---------------------------------------------------------------------------
// OH temporary party file
dInfutorMotorcycleTempParty	:=	VehicleV2.Mapping_Infutor_Motorcycle_Temp_Party(orig_name	!=	'');

dInfutorMotorcycleTempPartyDist	:=	distribute(dInfutorMotorcycleTempParty,hash(vehicle_key,iteration_key));
dInfutorMotorcycleTempPartySort	:=	sort(	dInfutorMotorcycleTempPartyDist,                                       
																		vehicle_key,
																		-Iteration_Key,
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
																		local
																	);

VehicleV2.Layout_Base.Party_CCPA	trollup(dInfutorMotorcycleTempPartySort	le,dInfutorMotorcycleTempPartySort	ri)	:=
transform
	self.Reg_Rollup_Count							:=	le.Reg_Rollup_Count	+	1;
	//Vendor's definition of first and last seen date are not clear. We do not use their dates.
	self.date_first_Seen							:=	0;   //(unsigned4)VehicleV2.validate_date.fEarliestNonZeroDate((string)le.date_first_Seen,(string)ri.date_first_Seen);
	self.date_last_Seen 							:=	0;   //(unsigned4)VehicleV2.validate_date.fLatestNonZeroDate((string)le.date_last_Seen,(string)ri.date_last_Seen);
	self.date_vendor_First_Reported		:=	(unsigned4)VehicleV2.validate_date.fEarliestNonZeroDate((string)le.date_vendor_First_Reported,(string)ri.date_vendor_First_Reported);
	self.date_vendor_Last_Reported		:=	(unsigned4)VehicleV2.validate_date.fLatestNonZeroDate((string)le.date_vendor_Last_Reported,(string)ri.date_vendor_Last_Reported);
	self.source_rec_id								:=  if(le.source_rec_id<>0,if(le.source_rec_id<ri.source_rec_id,le.source_rec_id,ri.source_rec_id),0);
	//Added for CCPA-103
	// self.global_sid                   := 0;
	// self.record_sid                   := 0;
	//Added for DF-25578
	// self.raw_name                     := '';
	self															:=	le;


end;

dInfutorMotorcyclePartyRollup		:=	rollup(	dInfutorMotorcycleTempPartySort,						  
																			left.vehicle_key											=	right.vehicle_key
																			and left.Iteration_Key								=	right.Iteration_Key
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

VehicleV2.Layout_Base.Party_CCPA	tdate(dInfutorMotorcyclePartyRollup	pInput)	:=
transform
	self.Ttl_Earliest_Issue_Date			:=	''; //pInput.TITLE_ISSUE_DATE;
	self.Ttl_Latest_Issue_Date				:=	''; //pInput.TITLE_ISSUE_DATE;
	self.Reg_Earliest_Effective_Date	:=	'';
	self.Reg_Latest_Effective_Date		:=	'';
	self.Reg_Latest_Expiration_Date		:=	'';
	//moved to Mapping_Infutor_Motorcycle_Temp_Party because we are using raw_idate as first part of sequence key and 
	//it is not available here.
	//self.sequence_key									:=	TRIM(self.Reg_Latest_Effective_Date +	(string6)pInput.date_vendor_Last_Reported[1..6]	+	'R', LEFT, RIGHT);	

	self															:=	pInput;

end;

dInfutorMotorcyclePartySequenceKey	:=	project(dInfutorMotorcyclePartyRollup,tdate(left));

// setup flag fields
dInfutorMotorcycleParty					:=	VehicleV2.Mac_Setup_Latest_VehFlag.owner_latest_vehflag(dInfutorMotorcyclePartySequenceKey,false);

EXPORT	Mapping_Infutor_Motorcycle_Party	:=	dInfutorMotorcycleParty	:	persist('~thor_data400::persist::vehicleV2::inf_nondppa_motorcycle_party');
