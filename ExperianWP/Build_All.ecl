import ut, VersionControl;
export Build_all(string version=version) := function

sprayf := VersionControl.fSprayInputFiles(Spray);

ut.MAC_SF_BuildProcess(Build_base,Superfile_List.Base_File ,ExperianWP,2,,true);

//Build_all_keys := Build_keys(version);

zDoPopulationStats := Strata_Stat_ExperianWP;

built := sequential(
					sprayf
					,ExperianWP
					//,Build_all_keys
					,zDoPopulationStats
					,FileServices.PromoteSuperFileList([Superfile_List.Source_File,Superfile_List.Source_File_Processed])
					);

return built;

end;