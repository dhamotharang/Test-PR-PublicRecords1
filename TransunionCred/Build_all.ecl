import ut, VersionControl;
export Build_all(string version=version) := function

//-----------Spray input and delete files
#IF (IsFullUpdate = false)
spray_it := VersionControl.fSprayInputFiles(Spray.Updates);
#ELSE
spray_it := VersionControl.fSprayInputFiles(Spray.Load);
#END

ut.MAC_SF_BuildProcess(Build_base,Superfile_List.Base, TransunionCred,2,,true);

zDoPopulationStats := Strata;

built := sequential(
					// spray_it
					TransunionCred
					,zDoPopulationStats
					//Archive processed files in history
					,FileServices.StartSuperFileTransaction()
#IF (IsFullUpdate = false)
					,FileServices.AddSuperFile(Superfile_List.updates_history_compressed,Superfile_List.updates_father,,true)
					,FileServices.ClearSuperFile(Superfile_List.updates_father)
					,FileServices.AddSuperFile(Superfile_List.updates_father,Superfile_List.updates,,true)
					,FileServices.ClearSuperFile(Superfile_List.updates)
					,FileServices.FinishSuperFileTransaction()
#ELSE
					,FileServices.AddSuperFile(Superfile_List.load_father,Superfile_List.load,,true)
					,FileServices.ClearSuperFile(Superfile_List.load)
#END
					,FileServices.FinishSuperFileTransaction()
					);

return built;

end;