import mdr, doxie, Data_Services, vault, _control;

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
EXPORT key_ssn_ssa(boolean isFCRA) := vault.Death_Master.key_ssn_ssa(isFCRA);
#ELSE

EXPORT key_ssn_ssa(boolean isFCRA) := function

	dm_base := Death_Master.File_DeathMaster_Building_ssa((LENGTH(TRIM(ssn))=9));

// for reference, this is the list of the new sources being added to Death Master
// which we want to make sure are excluded from FCRA key until shell 5.0 goes live
// src_Death_Tributes 	:= 'TR';
// src_Death_CA				:= 'D0';
// src_Death_GA				:= 'D3';
// src_Death_MI				:= 'D7';
// src_Death_MT				:= 'D9';
// src_Death_NV				:= 'D#';
// src_Death_OH				:= 'D@';
set_temp_fcra_exclude := [
	mdr.sourcetools.src_Death_Tributes,
	mdr.sourceTools.src_Death_CA,
	mdr.sourceTools.src_Death_GA,
	mdr.sourceTools.src_Death_MI,
	mdr.sourceTools.src_Death_MT,
	mdr.sourceTools.src_Death_NV,
	mdr.sourceTools.src_Death_OH
	];
	
// to match what we have in SSN Table for now, only use DE source for FCRA	
fcra_base := dm_base(trim(src) IN  [mdr.sourceTools.src_Death_Master, mdr.sourceTools.src_Death_Restricted] and glb_flag != 'Y');
base := if(isFCRA, fcra_base, dm_base);

key_name := if(isFCRA, 
							data_services.data_location.prefix('Death')+'thor_data400::key::fcra::death_master_ssa::ssn_'+ doxie.Version_SuperKey,
							data_services.data_location.prefix('Death')+'thor_data400::key::death_master_ssa::ssn_'+ doxie.Version_SuperKey
							);

	return index(base,{ssn},{base},key_name);
	
end;
#END;

