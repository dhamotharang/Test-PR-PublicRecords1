import ut, VersionControl, orbit3, header, std;
export Build_all(string ver=version) := function

//-----------Spray input and delete files
spray_input  := VersionControl.fSprayInputFiles(Spray(ver).Input);
spray_delete := VersionControl.fSprayInputFiles(Spray(ver).Delete);
spray_deceased:= VersionControl.fSprayInputFiles(Spray(ver).Deceased);

//-----------Normalize and clean data
NormAddress  :=  output(ExperianCred.Normalize_Address(ver).all);
CleanName 	 :=  output(ExperianCred.Clean_Names(ver).all);
CleanAddress :=  ExperianCred.Clean_Addresses(ver).all;

ut.MAC_SF_BuildProcess(Build_base(ver).all,Superfile_List.Base_File ,ExperianCred,3,,true);

//Build_all_keys := Build_keys(version);
zDoPopulationStats := Strata_Stat_ExperianCred(ver);

PromoteSupers.MAC_SF_BuildProcess(Header.Mod_CreditBureau_address.flagged_nlr_addresses,'~thor_data400::prepped::nlr_addresses',bld_prepped,pcompress:=true,numgenerations:='2');

input 		:= STD.File.RemoteDirectory(Spray(ver).ip, Spray(ver).path,'*.dat');
delete 		:= STD.File.RemoteDirectory(Spray(ver).ip, Spray(ver).path,'DPINS');
deceased  := STD.File.RemoteDirectory(Spray(ver).ip, Spray(ver).path,'DEC');

DEL_EXT_FILE := nothor(apply(input + delete + deceased, STD.File.DeleteExternalFile(Spray(ver).ip, Spray(ver).path + '/' + name)));

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
					,bld_prepped
					//Archive processed files in history
					,FileServices.StartSuperFileTransaction()						
						//clear and delete current input files	
						,FileServices.ClearSuperFile(Superfile_List.Source_File, true)
						,FileServices.ClearSuperFile(Superfile_List.Source_Deceased_File, true)
						,FileServices.ClearSuperFile(Superfile_List.Source_delete_File, true)
					,FileServices.FinishSuperFileTransaction()
					,DEL_EXT_FILE
					,Orbit3.Proc_Orbit3_CreateBuild_npf('Credit Header',ver)
					);

return built;

end;