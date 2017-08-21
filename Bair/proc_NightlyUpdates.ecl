import ut,std;

EXPORT proc_NightlyUpdates(string pversion, boolean pUseProd = false) := function
	
	version := pversion : global;
	
	MoveInputFilesToHist := sequential(
									FileServices.StartSuperFileTransaction(),
										FileServices.AddSuperFile(Filenames('',pUseProd).event_dbo_AgencyCrimeTypeLookup_lInputHistTemplate,  Filenames('',pUseProd).event_dbo_AgencyCrimeTypeLookup_lInputTemplate,,true),
										FileServices.AddSuperFile(Filenames('',pUseProd).cfs_dbo_AgencyCfsTypeLookup_lInputHistTemplate,  Filenames('',pUseProd).cfs_dbo_AgencyCfsTypeLookup_lInputTemplate,,true),
										FileServices.AddSuperFile(Filenames('',pUseProd).lpr_dbo_nightlylprdeletes_lInputHistTemplate,  Filenames('',pUseProd).lpr_dbo_nightlylprdeletes_lInputTemplate,,true),
										
										FileServices.ClearSuperFile(Filenames('',pUseProd).event_dbo_AgencyCrimeTypeLookup_lInputTemplate),
										FileServices.ClearSuperFile(Filenames('',pUseProd).cfs_dbo_AgencyCfsTypeLookup_lInputTemplate),
										FileServices.ClearSuperFile(Filenames('',pUseProd).lpr_dbo_nightlylprdeletes_lInputTemplate),
									FileServices.FinishSuperFileTransaction()
										);
		
	updates := sequential(
							bair.UpdateNightlyBaseAndKey.update_base_cfs(version, pUseProd).cfs_updates,
							bair.UpdateNightlyBaseAndKey.update_base_mo(version, pUseProd).mo_updates,
							bair.UpdateNightlyBaseAndKey.update_base_LPR(version, pUseProd).LPR_updates,
							MoveInputFilesToHist
   						);
							
	return updates;
END;