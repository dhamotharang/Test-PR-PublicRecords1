import ut, advo, VersionControl;
export Build_all(string version=version) := function

sprayf := VersionControl.fSprayInputFiles(Advo.Spray);

ut.MAC_SF_BuildProcess(Build_base,Superfile_List.Base_File_Out ,advobase,2,,true);

Build_all_keys := Build_keys(version);

zDoPopulationStats:=Strata_Stat_Advo;

built := sequential(
					sprayf
					,advobase
					,Build_all_keys
					,zDoPopulationStats
					,FileServices.PromoteSuperFileList([Superfile_List.Source_File_In,Superfile_List.Source_File_In_Processed])
					);

return built;

end;