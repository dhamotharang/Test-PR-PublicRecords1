/*2017-11-10T21:40:19Z (Debendra Kumar)

*/
import ut, VersionControl,lib_stringlib,lib_fileservices,_control,orbit3,std;
export Build_all(string ver=version) := function

//-----------Spray input and delete files
#IF (IsFullUpdate = false)
spray_it := sequential(
											VersionControl.fSprayInputFiles(Spray(ver).Updates)
											,VersionControl.fSprayInputFiles(Spray(ver).Deletes)
											,VersionControl.fSprayInputFiles(Spray(ver).Deceased)
											);
#ELSE
spray_it := VersionControl.fSprayInputFiles(Spray(ver).Load);
#END

Base := Build_base(ver).all;
ut.MAC_SF_BuildProcess(Base,Superfile_List.Base, FCRA_ExperianCred,2,,true);

zDoPopulationStats := Strata(ver);

updates 		:= STD.File.RemoteDirectory(Spray(ver).ip, Spray(ver).path,'D*LEXNEX*FCRA.dat');
deletes 		:= STD.File.RemoteDirectory(Spray(ver).ip, Spray(ver).path,'DPINS');
deceased  	:= STD.File.RemoteDirectory(Spray(ver).ip, Spray(ver).path,'DEC');
loads  			:= STD.File.RemoteDirectory(Spray(ver).ip, Spray(ver).path,'D*LEXNEX*EXP*FCRA.dat');

DEL_EXT_FILE := nothor(apply(updates + deletes + deceased + loads, STD.File.DeleteExternalFile(Spray(ver).ip, Spray(ver).path + '/' + name)));

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