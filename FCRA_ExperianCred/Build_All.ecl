/*2017-11-10T21:40:19Z (Debendra Kumar)

*/
import ut, VersionControl,lib_stringlib,lib_fileservices,_control,orbit3,std;
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

updates 		:= STD.File.RemoteDirectory(Spray.ip, Spray.path,'D*LEXNEX*FCRA.dat');
deletes 		:= STD.File.RemoteDirectory(Spray.ip, Spray.path,'DPINS');
deceased  	:= STD.File.RemoteDirectory(Spray.ip, Spray.path,'DEC');
loads  			:= STD.File.RemoteDirectory(Spray.ip, Spray.path,'D*LEXNEX*EXP*FCRA.dat');

DEL_EXT_FILE := nothor(apply(updates + deletes + deceased + loads, STD.File.DeleteExternalFile(Spray.ip, Spray.path + '/' + name)));

built := sequential(
					spray_it
					,FCRA_ExperianCred
					,zDoPopulationStats
					,FileServices.StartSuperFileTransaction()
#IF (IsFullUpdate = false)
						,FileServices.ClearSuperFile(Superfile_List.updates,true)
						,FileServices.ClearSuperFile(Superfile_List.deletes,true)
						,FileServices.ClearSuperFile(Superfile_List.deceased,true)
#ELSE  //  flush past updates and start fresh
						,FileServices.ClearSuperFile(Superfile_List.load,true)
#END
					,FileServices.FinishSuperFileTransaction()
					,DEL_EXT_FILE
					);

return built;

end;