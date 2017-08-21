import ut, VersionControl;
export Build_all(string version=version) := function

//-----------Spray input and delete files
spray_input1  := VersionControl.fSprayInputFiles(Spray.Input1);
spray_input2  := VersionControl.fSprayInputFiles(Spray.Input2);


//-----------Normalize and clean data
CleanAddress :=  output(Clean_Addresses);

ut.MAC_SF_BuildProcess(Build_base,Superfile_List.Base_File ,OptinCellphones,3,,true);

Build_all_keys := Build_keys(version);
zDoPopulationStats := Strata_Stat_OptinCellphones_Build;

built := sequential(
					/*spray_input1,
					spray_input2,*/
					CleanAddress
					,OptinCellphones
					// ,Build_all_keys
					,zDoPopulationStats
					//Archive processed files in history
					,FileServices.StartSuperFileTransaction()
					,FileServices.AddSuperFile(Superfile_List.Source_File_Processed,Superfile_List.Source_File,,true)
					,FileServices.AddSuperFile(Superfile_List.Source_File_Processed2,Superfile_List.Source_File2,,true)
					,FileServices.ClearSuperFile(Superfile_List.Source_File)
					,FileServices.ClearSuperFile(Superfile_List.Source_File2)
					,FileServices.FinishSuperFileTransaction()
					);

return built;

end;