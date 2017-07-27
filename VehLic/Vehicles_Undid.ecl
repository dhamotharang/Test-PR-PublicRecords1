import VehLic, ut, vehicleCodes;

//ut.MAC_Sequence_Records_StrField(vehicles_joined,seq_no,veh_fat)	//v1.1 found out my seq	no's are not unique when applying updates
veh_fat := vehicles_joined;

//****** Join to VIN file (no longer utilizing vehlic.MAC_Join_Vehreg_VIN)
dInFileDist	:=	distribute(veh_fat,hash((string25)orig_vin));
// change to join on vin_input in VINA file, since that is the value in the vehicle file that is searched in VINA app.
veh_vin	:=	join(dInFileDist, VehLic.Vin_Matches,
				 left.orig_vin = right.vin_input,
				 vehlic.tra_make_veh_vin(left, right, left.orig_vin, false, true),
				 left outer,
				 local
				);

//****** Improve descriptions as in VehLic.BWR_Patch_Vehreg_By_Codes
vehlic.mac_patch_vehreg_by_codes(veh_vin, veh_vins_done)		//v1.5

#if(VehLic.BuildType = VehLic.BuildType_Accurint)
  export Vehicles_Undid := veh_vins_done : persist('Persist::VehReg_Vehicles_UnDID');
#end
#if(VehLic.BuildType = VehLic.BuildType_Matrix)
  export Vehicles_Undid := veh_vins_done : persist('Persist::Matrix_MV_Vehicles_UnDID');
#end