import ut, VersionControl;
export Build_all(string version=version) := function

//-----------Spray input and delete files
spray_input  := VersionControl.fSprayInputFiles(Spray.Input);


//-----------Normalize and clean data
Norm  :=  output(ExperianIRSG_Build.Normalize_Record);
CleanAddress :=  output(ExperianIRSG_Build.Clean_Addresses);

ut.MAC_SF_BuildProcess(Build_base,Superfile_List.IRSG_Base_File ,ExperianIRSG_Build,3,,true);

//Build_all_keys := Build_keys(version);
zDoPopulationStats := Strata_Stat_ExperianIRSG_Build;

built := sequential(
					spray_input,
					//spray_delete,
					//,
					Norm					
					,CleanAddress
					,ExperianIRSG_Build
					//,Build_all_keys
					,zDoPopulationStats
					//Archive processed files in history
					,FileServices.StartSuperFileTransaction()
					,FileServices.AddSuperFile(Superfile_List.IRSG_Source_File_Processed,Superfile_List.IRSG_Source_File,,true)
					,FileServices.ClearSuperFile(Superfile_List.IRSG_Source_File)
					,FileServices.FinishSuperFileTransaction()
					);

return built;

end;