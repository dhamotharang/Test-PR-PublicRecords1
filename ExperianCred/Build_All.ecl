import ut, VersionControl, orbit3;
export Build_all(string version=version) := function

//-----------Spray input and delete files
spray_input  := VersionControl.fSprayInputFiles(Spray.Input);
spray_delete := VersionControl.fSprayInputFiles(Spray.Delete);
spray_deceased:= VersionControl.fSprayInputFiles(Spray.Deceased);

//-----------Normalize and clean data
NormAddress  :=  output(ExperianCred.Normalize_Address);
CleanName 	 :=  output(ExperianCred.Clean_Names);
CleanAddress :=  ExperianCred.Clean_Addresses;

ut.MAC_SF_BuildProcess(Build_base,Superfile_List.Base_File ,ExperianCred,3,,true);

//Build_all_keys := Build_keys(version);
zDoPopulationStats := Strata_Stat_ExperianCred;

built := sequential(
					//Automatically resets deceased and delete superfiles for full updates
					 spray_input
					,spray_delete
					,spray_deceased
					//,
					,NormAddress
					,CleanName
					,CleanAddress
					,ExperianCred
					//,Build_all_keys
					,zDoPopulationStats
					//Archive processed files in history
					,FileServices.StartSuperFileTransaction()						
						#IF (IsFullUpdate = true)
							//remove and delete previous input files
							,FileServices.ClearSuperFile(Superfile_List.Source_Full_File_History, true)
							,FileServices.ClearSuperFile(Superfile_List.Source_Deceased_Full_File_history, true)
							,FileServices.ClearSuperFile(Superfile_List.Source_Delete_Full_File_History, true)
							//add current input files to history
							,FileServices.AddSuperFile(Superfile_List.Source_Full_File_History,Superfile_List.Source_File,,true)
							,FileServices.AddSuperFile(Superfile_List.Source_Deceased_Full_File_history,Superfile_List.Source_Deceased_File,,true)
							,FileServices.AddSuperFile(Superfile_List.Source_Delete_Full_File_History,Superfile_List.Source_delete_File,,true)	
						#else
							//remove and delete previous input files
							,FileServices.ClearSuperFile(Superfile_List.Source_File_History, true)
							,FileServices.ClearSuperFile(Superfile_List.Source_Deceased_File_history, true)
							,FileServices.ClearSuperFile(Superfile_List.Source_Delete_File_history, true)
							//add current input files to history
							,FileServices.AddSuperFile(Superfile_List.Source_File_History,Superfile_List.Source_File,,true)
							,FileServices.AddSuperFile(Superfile_List.Source_Deceased_File_history,Superfile_List.Source_Deceased_File,,true)
							,FileServices.AddSuperFile(Superfile_List.Source_Delete_File_history,Superfile_List.Source_delete_File,,true)	
						#End
						//clear current input files						
						,FileServices.ClearSuperFile(Superfile_List.Source_File)
						,FileServices.ClearSuperFile(Superfile_List.Source_Deceased_File)
						,FileServices.ClearSuperFile(Superfile_List.Source_delete_File)
					,FileServices.FinishSuperFileTransaction()
					,Orbit3.Proc_Orbit3_CreateBuild_npf('Credit Header',version)
					);

return built;

end;