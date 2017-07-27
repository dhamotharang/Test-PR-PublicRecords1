
import vehicleV2, ut;

//build vehicle main & party base file

exp_nc_main := VehicleV2.mapping_NC_main + VehicleV2.Mapping_Experian_Updating_Main;

ut.MAC_SF_BuildProcess(exp_nc_main,
                       '~thor_data400::base::VehicleV2::Main',bld_exp_main, 2);
				   
ut.MAC_SF_BuildProcess(VehicleV2.Experian_Updating_DID,
                       '~thor_data400::base::VehicleV2::party', bld_exp_party,2);

export Proc_build_Experian_Updating_Base := sequential(bld_exp_main, bld_exp_party);




