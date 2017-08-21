import VersionControl,_Control;

export FLNTLCrash_Spray(

	 
	boolean	pIsTesting	= false
	

) :=
function

	

	Intorder_file := NtlConstants.INTORDER_SPRAYED_DAILY + '_'+ workunit;
	
	Intorder_spy := if (  FileServices.FileExists(Intorder_file),Output('Intorder_File_Exists_On_Thor'), FileServices.SprayVariable(NtlConstants.LandingZone, NtlConstants.ProcessPathForIntorder + NtlConstants.FileSeparator + NtlConstants.IntorderFileMask,60000,,,'"',
       NtlConstants.DestinationCluster,Intorder_file,-1,,,true,true,true));
			 
	Intorder_FileListing := FileServices.RemoteDirectory(NtlConstants.LandingZone,
																						 NtlConstants.ProcessPathForIntorder , 
																						 '*');


Intorder_move := nothor(apply(Intorder_FileListing,FileServices.MoveExternalFile(NtlConstants.LandingZone,NtlConstants.ProcessPathForIntorder + NtlConstants.FileSeparator + name  ,NtlConstants.BackupPathForIntorder + NtlConstants.FileSeparator +  name )));
			 
	Intorder_addsuper := if ( FileServices.FindSuperFileSubName(NtlConstants.INTORDER_SPRAYED_DAILY,Intorder_file) = 0,SEQUENTIAL(FileServices.StartSuperFileTransaction(),
										 						 FileServices.AddSuperFile(NtlConstants.INTORDER_SPRAYED_DAILY, NtlConstants.INTORDER_SPRAYED_DAILY +  '_' + workunit ),
																 FileServices.FinishSuperFileTransaction(),Intorder_move),Output('Intorder_LogicalFile_Already_Added_To_SuperFile'));
																 
//Vehicle Spray

 Vehicle_file := NtlConstants.VEHICLE_SPRAYED_DAILY + '_'+ workunit;

	Vehicle_spy := if ( FileServices.FileExists(Vehicle_file) , Output('Vehicle_File_Exists_On_Thor'), FileServices.SprayVariable(NtlConstants.LandingZone, NtlConstants.ProcessPathForVehicle + NtlConstants.FileSeparator + NtlConstants.VehicleFileMask,50000,,,'"',
       NtlConstants.DestinationCluster,Vehicle_file,-1,,,true,true,true));
			 
  Vehicle_FileListing := FileServices.RemoteDirectory(NtlConstants.LandingZone,
																						 NtlConstants.ProcessPathForVehicle , 
																						 '*');


Vehicle_move := nothor(apply(Vehicle_FileListing,FileServices.MoveExternalFile(NtlConstants.LandingZone,NtlConstants.ProcessPathForVehicle + NtlConstants.FileSeparator + name  ,NtlConstants.BackupPathForVehicle + NtlConstants.FileSeparator +  name )));
			 
	Vehicle_addsuper := if ( FileServices.FindSuperFileSubName(NtlConstants.VEHICLE_SPRAYED_DAILY,Vehicle_file) = 0,SEQUENTIAL(FileServices.StartSuperFileTransaction(),
										 						 FileServices.AddSuperFile(NtlConstants.VEHICLE_SPRAYED_DAILY, NtlConstants.VEHICLE_SPRAYED_DAILY +  '_' + workunit ),
																 FileServices.FinishSuperFileTransaction(),Vehicle_move),Output('Vehicle_LogicalFile_Already_Added_To_SuperFile'));
																 
																 
//Ordervs Spray

Ordervs_file := NtlConstants.ORDERVS_SPRAYED_DAILY + '_'+ workunit;

Ordervs_spy := if (  FileServices.FileExists(Ordervs_file),Output('Ordervs_File_Exists_On_Thor'),FileServices.SprayVariable(NtlConstants.LandingZone, NtlConstants.ProcessPathForOrdervs + NtlConstants.FileSeparator + NtlConstants.OrdervsFileMask,,,,'"',
       NtlConstants.DestinationCluster,Ordervs_file,-1,,,true,true,true));
			 
Ordervs_FileListing := FileServices.RemoteDirectory(NtlConstants.LandingZone,
																						 NtlConstants.ProcessPathForOrdervs , 
																						 '*');


Ordervs_move := nothor(apply(Ordervs_FileListing,FileServices.MoveExternalFile(NtlConstants.LandingZone,NtlConstants.ProcessPathForOrdervs + NtlConstants.FileSeparator + name  ,NtlConstants.BackupPathForOrdervs + NtlConstants.FileSeparator +  name )));
			 
	Ordervs_addsuper := if ( FileServices.FindSuperFileSubName(NtlConstants.ORDERVS_SPRAYED_DAILY,Ordervs_file) = 0,SEQUENTIAL(FileServices.StartSuperFileTransaction(),
										 						 FileServices.AddSuperFile(NtlConstants.ORDERVS_SPRAYED_DAILY, NtlConstants.ORDERVS_SPRAYED_DAILY +  '_' + workunit ),
																 FileServices.FinishSuperFileTransaction(),Ordervs_move),Output('Ordervs_LogicalFile_Already_Added_To_SuperFile'));
																 
//Result Spray

Result_file := NtlConstants.RESULT_SPRAYED_DAILY + '_'+ workunit;

	Result_spy := if (  FileServices.FileExists(Result_file),Output('Result_File_Exists_On_Thor'),FileServices.SprayVariable(NtlConstants.LandingZone, NtlConstants.ProcessPathForResult + NtlConstants.FileSeparator + NtlConstants.ResultFileMask,,,,'"',
       NtlConstants.DestinationCluster,Result_file,-1,,,true,true,true));
			 
Result_FileListing := FileServices.RemoteDirectory(NtlConstants.LandingZone,
																						 NtlConstants.ProcessPathForResult , 
																						 '*');


Result_move := nothor(apply(Result_FileListing,FileServices.MoveExternalFile(NtlConstants.LandingZone,NtlConstants.ProcessPathForResult + NtlConstants.FileSeparator + name  ,NtlConstants.BackupPathForresult + NtlConstants.FileSeparator +  name )));
			 
			 
	Result_addsuper := if ( FileServices.FindSuperFileSubName(NtlConstants.RESULT_SPRAYED_DAILY,Result_file) = 0,SEQUENTIAL(FileServices.StartSuperFileTransaction(),
										 						 FileServices.AddSuperFile(NtlConstants.RESULT_SPRAYED_DAILY, NtlConstants.RESULT_SPRAYED_DAILY +  '_' + workunit ),
																 FileServices.FinishSuperFileTransaction(),Result_move),Output('Result_LogicalFile_Already_Added_To_SuperFile'));
																 
//VehIncidnt Spray

VehIncidnt_file := NtlConstants.VEHINCIDENT_SPRAYED_DAILY + '_'+ workunit;

 VehIncidnt_spy := if (  FileServices.FileExists(VehIncidnt_file),Output('VehIncidnt_file_Exists_On_Thor'),FileServices.SprayVariable(NtlConstants.LandingZone, NtlConstants.ProcessPathForVehIncidnt + NtlConstants.FileSeparator + NtlConstants.VehIncidntFileMask,,,,'"',
       NtlConstants.DestinationCluster,VehIncidnt_file,-1,,,true,true,true));
			 
 VehIncidnt_FileListing := FileServices.RemoteDirectory(NtlConstants.LandingZone,
																						 NtlConstants.ProcessPathForVehIncidnt , 
																						 '*');


VehIncidnt_move := nothor(apply(VehIncidnt_FileListing,FileServices.MoveExternalFile(NtlConstants.LandingZone,NtlConstants.ProcessPathForVehIncidnt + NtlConstants.FileSeparator + name  ,NtlConstants.BackupPathForVehIncidnt + NtlConstants.FileSeparator +  name )));
			 
			 
	VehIncidnt_addsuper := if ( FileServices.FindSuperFileSubName(NtlConstants.VEHINCIDENT_SPRAYED_DAILY,VehIncidnt_file) = 0,SEQUENTIAL(FileServices.StartSuperFileTransaction(),
										 						 FileServices.AddSuperFile(NtlConstants.VEHINCIDENT_SPRAYED_DAILY, NtlConstants.VEHINCIDENT_SPRAYED_DAILY +  '_' + workunit ),
																 FileServices.FinishSuperFileTransaction(),VehIncidnt_move),Output('VehIncidnt_LogicalFile_Already_Added_To_SuperFile'));
																 

//Vehicle Party Spray

VehPty_file := NtlConstants.VEHPARTY_SPRAYED_DAILY + '_'+ workunit;

 VehPty_spy := if (  FileServices.FileExists(VehPty_file),Output('VehPty_file_Exists_On_Thor'),FileServices.SprayVariable(NtlConstants.LandingZone, NtlConstants.ProcessPathForVehPty + NtlConstants.FileSeparator + NtlConstants.VehPtyFileMask,50000,,,'"',
       NtlConstants.DestinationCluster,VehPty_file,-1,,,true,true,true));
			 
VehPty_FileListing := FileServices.RemoteDirectory(NtlConstants.LandingZone,
																						 NtlConstants.ProcessPathForVehPty , 
																						 '*');


VehPty_move := nothor(apply(VehPty_FileListing,FileServices.MoveExternalFile(NtlConstants.LandingZone,NtlConstants.ProcessPathForVehPty + NtlConstants.FileSeparator + name  ,NtlConstants.BackupPathForVehPty + NtlConstants.FileSeparator +  name )));
			 
	VehPty_addsuper := if ( FileServices.FindSuperFileSubName(NtlConstants.VEHPARTY_SPRAYED_DAILY,VehPty_file) = 0,SEQUENTIAL(FileServices.StartSuperFileTransaction(),
										 						 FileServices.AddSuperFile(NtlConstants.VEHPARTY_SPRAYED_DAILY, NtlConstants.VEHPARTY_SPRAYED_DAILY +  '_' + workunit ),
																 FileServices.FinishSuperFileTransaction(),VehPty_move),Output('VehPty_LogicalFile_Already_Added_To_SuperFile'));
																 


Client_file := NtlConstants.CLIENT_SPRAYED_DAILY + '_'+ workunit;

 Client_spy := if (  FileServices.FileExists(Client_file),Output('Client_file_Exists_On_Thor'),FileServices.SprayVariable(NtlConstants.LandingZone, NtlConstants.ProcessPathForClient + NtlConstants.FileSeparator + NtlConstants.ClientFileMask,50000,,,'"',
       NtlConstants.DestinationCluster,Client_file,-1,,,true,true,true));
			 
Client_FileListing := FileServices.RemoteDirectory(NtlConstants.LandingZone,
																						 NtlConstants.ProcessPathForClient , 
																						 '*');


Client_move := nothor(apply(Client_FileListing,FileServices.MoveExternalFile(NtlConstants.LandingZone,NtlConstants.ProcessPathForClient + NtlConstants.FileSeparator + name  ,NtlConstants.BackupPathForClient + NtlConstants.FileSeparator +  name )));
			 
	Client_addsuper := if ( FileServices.FindSuperFileSubName(NtlConstants.CLIENT_SPRAYED_DAILY,Client_file) = 0,SEQUENTIAL(FileServices.StartSuperFileTransaction(),
										 						 FileServices.AddSuperFile(NtlConstants.CLIENT_SPRAYED_DAILY, NtlConstants.CLIENT_SPRAYED_DAILY +  '_' + workunit ),
																 FileServices.FinishSuperFileTransaction(),Client_move),Output('Client_LogicalFile_Already_Added_To_SuperFile'));
																 
				
	Vehinscr_file := NtlConstants.VEHINS_SPRAYED_DAILY + '_'+ workunit;

 Vehinscr_spy := if (  FileServices.FileExists(Vehinscr_file),Output('Vehinscr_file_Exists_On_Thor'),FileServices.SprayVariable(NtlConstants.LandingZone, NtlConstants.ProcessPathForVehinscr + NtlConstants.FileSeparator + NtlConstants.VehinscrFileMask,50000,,,'"',
       NtlConstants.DestinationCluster,Vehinscr_file,-1,,,true,true,true));
			 
Vehinscr_FileListing := FileServices.RemoteDirectory(NtlConstants.LandingZone,
																						 NtlConstants.ProcessPathForVehinscr , 
																						 '*');


Vehinscr_move := nothor(apply(Vehinscr_FileListing,FileServices.MoveExternalFile(NtlConstants.LandingZone,NtlConstants.ProcessPathForVehinscr + NtlConstants.FileSeparator + name  ,NtlConstants.BackupPathForVehinscr + NtlConstants.FileSeparator +  name )));
			 
	Vehinscr_addsuper := if ( FileServices.FindSuperFileSubName(NtlConstants.VEHINS_SPRAYED_DAILY,Client_file) = 0,SEQUENTIAL(FileServices.StartSuperFileTransaction(),
										 						 FileServices.AddSuperFile(NtlConstants.VEHINS_SPRAYED_DAILY, NtlConstants.VEHINS_SPRAYED_DAILY +  '_' + workunit ),
																 FileServices.FinishSuperFileTransaction(),Vehinscr_move),Output('Vehinscr_LogicalFile_Already_Added_To_SuperFile'));			
				
				
return sequential(Intorder_spy,Intorder_addsuper,Vehicle_spy,Vehicle_addsuper,Ordervs_spy,
                  Ordervs_addsuper,Result_spy,Result_addsuper,VehIncidnt_spy,VehIncidnt_addsuper,VehPty_spy,VehPty_addsuper,Client_spy,Client_addsuper,Vehinscr_spy,Vehinscr_addsuper);
																 
end;