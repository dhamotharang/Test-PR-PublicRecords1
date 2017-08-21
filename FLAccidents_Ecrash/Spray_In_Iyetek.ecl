import VersionControl,_Control,ut,lib_fileservices;

export Spray_In_Iyetek(

	 //string		filedate,
	 boolean	pIsTesting	= false
	

) :=
function

	
	
//Incident Spray

 Incident_file := Iyetek_Constants.INCIDENT_SPRAYED_DAILY + '_'+ thorlib.wuid();
	
	Incident_spy := if (  FileServices.FileExists(Incident_file),Output('Incident_File_Exists_On_Thor'), FileServices.SprayVariable(Iyetek_Constants.LandingZone, Iyetek_Constants.ProcessPathForIncident + Iyetek_Constants.FileSeparator + Iyetek_Constants.IncidentFileMask,,,,,
       Iyetek_Constants.DestinationCluster,Incident_file,-1,,,true,true,false));
			 
Incident_FileListing := FileServices.RemoteDirectory(Iyetek_Constants.LandingZone,
																						 Iyetek_Constants.ProcessPathForIncident , 
																						 '*');


Incident_move := nothor(apply(Incident_FileListing,FileServices.MoveExternalFile(Iyetek_Constants.LandingZone,Iyetek_Constants.ProcessPathForIncident + Iyetek_Constants.FileSeparator + name  ,Iyetek_Constants.BackupPathForIncident + Iyetek_Constants.FileSeparator +  name )));
			 
			 
	Incident_addsuper := if ( FileServices.FindSuperFileSubName(Iyetek_Constants.INCIDENT_SPRAYED_DAILY,Incident_file) = 0,SEQUENTIAL(FileServices.StartSuperFileTransaction(),
										 						 FileServices.AddSuperFile(Iyetek_Constants.INCIDENT_SPRAYED_DAILY, Iyetek_Constants.INCIDENT_SPRAYED_DAILY +  '_' + thorlib.wuid() ),
																 FileServices.FinishSuperFileTransaction(),Incident_move),Output('Incident_LogicalFile_Already_Added_To_SuperFile'));
																 
//Vehicle Spray

 Vehicle_file := Iyetek_Constants.VEHICLE_SPRAYED_DAILY + '_'+ thorlib.wuid();

	Vehicle_spy := if ( FileServices.FileExists(Vehicle_file) , Output('Vehicle_File_Exists_On_Thor'), FileServices.SprayVariable(Iyetek_Constants.LandingZone, Iyetek_Constants.ProcessPathForVehicle + Iyetek_Constants.FileSeparator + Iyetek_Constants.VehicleFileMask,,,,,
       Iyetek_Constants.DestinationCluster,Vehicle_file,-1,,,true,true,false));
			 
Vehicle_FileListing := FileServices.RemoteDirectory(Iyetek_Constants.LandingZone,
																						 Iyetek_Constants.ProcessPathForVehicle , 
																						 '*');


Vehicle_move := nothor(apply(Vehicle_FileListing,FileServices.MoveExternalFile(Iyetek_Constants.LandingZone,Iyetek_Constants.ProcessPathForVehicle + Iyetek_Constants.FileSeparator + name  ,Iyetek_Constants.BackupPathForVehicle + Iyetek_Constants.FileSeparator +  name )));
			 
	Vehicle_addsuper := if ( FileServices.FindSuperFileSubName(Iyetek_Constants.VEHICLE_SPRAYED_DAILY,Vehicle_file) = 0,SEQUENTIAL(FileServices.StartSuperFileTransaction(),
										 						 FileServices.AddSuperFile(Iyetek_Constants.VEHICLE_SPRAYED_DAILY, Iyetek_Constants.VEHICLE_SPRAYED_DAILY +  '_' + thorlib.wuid() ),
																 FileServices.FinishSuperFileTransaction(),Vehicle_move),Output('Vehicle_LogicalFile_Already_Added_To_SuperFile'));
																 
																 
//Person Spray

Person_file := Iyetek_Constants.PERSON_SPRAYED_DAILY + '_'+ thorlib.wuid();

Person_spy := if (  FileServices.FileExists(Person_file),Output('Person_File_Exists_On_Thor'),FileServices.SprayVariable(Iyetek_Constants.LandingZone, Iyetek_Constants.ProcessPathForPerson + Iyetek_Constants.FileSeparator + Iyetek_Constants.PersonFileMask,,,,,
       Iyetek_Constants.DestinationCluster,Person_file,-1,,,true,true,false));
			 
Person_FileListing := FileServices.RemoteDirectory(Iyetek_Constants.LandingZone,
																						 Iyetek_Constants.ProcessPathForPerson , 
																						 '*');


Person_move := nothor(apply(Person_FileListing,FileServices.MoveExternalFile(Iyetek_Constants.LandingZone,Iyetek_Constants.ProcessPathForPerson + Iyetek_Constants.FileSeparator + name  ,Iyetek_Constants.BackupPathForPerson + Iyetek_Constants.FileSeparator +  name )));
			 
	Person_addsuper := if ( FileServices.FindSuperFileSubName(Iyetek_Constants.PERSON_SPRAYED_DAILY,Person_file) = 0,SEQUENTIAL(FileServices.StartSuperFileTransaction(),
										 						 FileServices.AddSuperFile(Iyetek_Constants.PERSON_SPRAYED_DAILY, Iyetek_Constants.PERSON_SPRAYED_DAILY +  '_' + thorlib.wuid() ),
																 FileServices.FinishSuperFileTransaction(),Person_move),Output('Person_LogicalFile_Already_Added_To_SuperFile'));
																 

//Citation Spray

Citation_file := Iyetek_Constants.CITATION_SPRAYED_DAILY + '_'+ thorlib.wuid();

 Citation_spy := if (  FileServices.FileExists(Citation_file),Output('Citation_file_Exists_On_Thor'),FileServices.SprayVariable(Iyetek_Constants.LandingZone, Iyetek_Constants.ProcessPathForCitation + Iyetek_Constants.FileSeparator + Iyetek_Constants.CitationFileMask,,,,,
       Iyetek_Constants.DestinationCluster,Citation_file,-1,,,true,true,false));
			 
Citation_FileListing := FileServices.RemoteDirectory(Iyetek_Constants.LandingZone,
																						 Iyetek_Constants.ProcessPathForCitation , 
																						 '*');


Citation_move := nothor(apply(Citation_FileListing,FileServices.MoveExternalFile(Iyetek_Constants.LandingZone,Iyetek_Constants.ProcessPathForCitation + Iyetek_Constants.FileSeparator + name  ,Iyetek_Constants.BackupPathForCitation + Iyetek_Constants.FileSeparator +  name )));
			 
			 
	Citation_addsuper := if ( FileServices.FindSuperFileSubName(Iyetek_Constants.CITATION_SPRAYED_DAILY,Citation_file) = 0,SEQUENTIAL(FileServices.StartSuperFileTransaction(),
										 						 FileServices.AddSuperFile(Iyetek_Constants.CITATION_SPRAYED_DAILY, Iyetek_Constants.CITATION_SPRAYED_DAILY +  '_' + thorlib.wuid() ),
																 FileServices.FinishSuperFileTransaction(),Citation_move),Output('Citation_LogicalFile_Already_Added_To_SuperFile'));
																 
																 
return sequential(Incident_spy,Incident_addsuper,Vehicle_spy,Vehicle_addsuper,Person_spy,
                  Person_addsuper,Citation_spy,Citation_addsuper);
																 
end;