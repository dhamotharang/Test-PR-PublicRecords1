import mdr, doxie, Data_Services, ut;

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
fcra_base := dm_base(trim(src) in mdr.sourceTools.set_scoring_FCRA and trim(src) not in mdr.sourceTools.set_scoring_FCRA_retro_test);
//DF-21696 blank out specified fields in thor_data400::key::fcra::death_master_ssa::ssn_qa
ut.MAC_CLEAR_FIELDS(fcra_base, fcra_base_cleared, Death_Master.Constants('').fields_to_clear);

base := if(isFCRA, fcra_base_cleared, dm_base);

key_name := if(isFCRA, 
							data_services.data_location.prefix('Death')+'thor_data400::key::fcra::death_master_ssa::ssn_'+ doxie.Version_SuperKey,
							data_services.data_location.prefix('Death')+'thor_data400::key::death_master_ssa::ssn_'+ doxie.Version_SuperKey
							);

	return index(base,{ssn},{base},key_name);
	
end;

