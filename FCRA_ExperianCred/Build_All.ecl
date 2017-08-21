import ut, VersionControl,lib_stringlib,lib_fileservices,_control,orbit3;
export Build_all(string version=version) := function

//-----------Spray input and delete files
#IF (IsFullUpdate = false)
spray_it := sequential(
											VersionControl.fSprayInputFiles(Spray.Updates)
											,VersionControl.fSprayInputFiles(Spray.Deletes)
											,VersionControl.fSprayInputFiles(Spray.Deceased)
											);
#ELSE
spray_it := VersionControl.fSprayInputFiles(Spray.Load);
#END


ut.MAC_SF_BuildProcess(Build_base,Superfile_List.Base, FCRA_ExperianCred,2,,true);

zDoPopulationStats := Strata;

built := sequential(
					spray_it
					,FCRA_ExperianCred
					,zDoPopulationStats
					,FileServices.StartSuperFileTransaction()
#IF (IsFullUpdate = false)
					,FileServices.AddSuperFile(Superfile_List.updates_history,Superfile_List.updates_father,,true)
					,FileServices.ClearSuperFile(Superfile_List.updates_father)
					,FileServices.AddSuperFile(Superfile_List.updates_father,Superfile_List.updates,,true)
					,FileServices.ClearSuperFile(Superfile_List.updates)

					,FileServices.AddSuperFile(Superfile_List.deletes_history,Superfile_List.deletes_father,,true)
					,FileServices.ClearSuperFile(Superfile_List.deletes_father)
					,FileServices.AddSuperFile(Superfile_List.deletes_father,Superfile_List.deletes,,true)
					,FileServices.ClearSuperFile(Superfile_List.deletes)

					,FileServices.AddSuperFile(Superfile_List.deceased_history,Superfile_List.deceased_father,,true)
					,FileServices.ClearSuperFile(Superfile_List.deceased_father)
					,FileServices.AddSuperFile(Superfile_List.deceased_father,Superfile_List.deceased,,true)
					,FileServices.ClearSuperFile(Superfile_List.deceased)
#ELSE  //  flush past updates and start fresh
					,FileServices.AddSuperFile(Superfile_List.load_father,Superfile_List.load,,true)
					,FileServices.ClearSuperFile(Superfile_List.load)

					,FileServices.ClearSuperFile(Superfile_List.updates_history,true)
					,FileServices.ClearSuperFile(Superfile_List.updates_father,true)
					,FileServices.AddSuperFile(Superfile_List.updates_father,Superfile_List.updates,,true)
					,FileServices.ClearSuperFile(Superfile_List.updates)

					,FileServices.ClearSuperFile(Superfile_List.deletes_history,true)
					,FileServices.ClearSuperFile(Superfile_List.deletes_father,true)
					,FileServices.AddSuperFile(Superfile_List.deletes_father,Superfile_List.deletes,,true)
					,FileServices.ClearSuperFile(Superfile_List.deletes)

					,FileServices.ClearSuperFile(Superfile_List.deceased_history,true)
					,FileServices.ClearSuperFile(Superfile_List.deceased_father,true)
					,FileServices.AddSuperFile(Superfile_List.deceased_father,Superfile_List.deceased,,true)
					,FileServices.ClearSuperFile(Superfile_List.deceased)
#END
					,FileServices.FinishSuperFileTransaction()
					//,Orbit3.Proc_Orbit3_CreateBuild_npf('Credit Header FCRA Experian',version)
					);

return built;

end;