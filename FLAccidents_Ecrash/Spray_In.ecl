
import VersionControl,_Control,ut,lib_fileservices;

export Spray_In(

	 boolean	pIsTesting	= false
	 

) :=
function

	lfile(string pkeyword) := '~thor_data400::in::ecrash::' + pkeyword + '.@version@.csv';
	sfile(string pkeyword) := '~thor_data400::in::ecrash::' + pkeyword;

	spry_raw:=DATASET([
             {Constants.LandingZone,'/data/super_credit/ecrash/agency/'
									,'mbs_ecrash_v_agency_hpcc_export_'+(string)((unsigned)ut.getDateOffset(-1,ut.GetDate))+'.txt'
																						,0 ,lfile('agency'				  ),[{sfile('agency'			  )}],Constants.DestinationCluster,'','[0-9]{8}','VARIABLE'}
		 	], VersionControl.Layout_Sprays.Info);
	
	Agency_sp :=  if( EXISTS(FileServices.RemoteDirectory(Constants.LandingZone,'/data/super_credit/ecrash/agency/','*ecrash_v_agency*'+(string)((unsigned)ut.getDateOffset(-1,ut.GetDate))+'.txt')),
                  sequential(fileservices.clearsuperfile('~thor_data400::in::ecrash::agency'),VersionControl.fSprayInputFiles(spry_raw,pIsTesting := pIsTesting)), 
                  output('NO Agency Files Recieved')); 

//Incident Spray

 Incident_file := Constants.INCIDENT_SPRAYED_DAILY + '_'+ thorlib.wuid();
 
 Incident_FileListing :=  FileServices.RemoteDirectory(Constants.LandingZone,
																						 Constants.ProcessPathForIncident , 
																						 '*');

	
fnvalid(string keyword,string name,integer size ) := module

export doverify := if ( size > 0 ,Output( 'file : ' +keyword+'  '+name+' is valid with size :'+size),FAIL('file : ' +keyword+'  '+name+' is invalid with size :'+size));

end;		
			
																						 
Incident_validate := nothor(apply(Incident_FileListing,fnvalid('Incident',name,size).doverify));
			 
Incident_spy := if (  COUNT(Incident_FileListing) > 0 , Sequential(Incident_validate, FileServices.SprayVariable(Constants.LandingZone, Constants.ProcessPathForIncident + Constants.FileSeparator + Constants.IncidentFileMask,60000,,,'"',
Constants.DestinationCluster,Incident_file,-1,,,true,true,true)),FAIL('Incident_Files_not_in_unix'));
			 


Incident_move := nothor(apply(Incident_FileListing,FileServices.MoveExternalFile(Constants.LandingZone,Constants.ProcessPathForIncident + Constants.FileSeparator + name  ,Constants.BackupPathForIncident + Constants.FileSeparator +  name )));
			 
	Incident_addsuper := if ( FileServices.FindSuperFileSubName(Constants.INCIDENT_SPRAYED_DAILY,Incident_file) = 0 and COUNT(Incident_FileListing) > 0,SEQUENTIAL(FileServices.StartSuperFileTransaction(),
										 						 FileServices.AddSuperFile(Constants.INCIDENT_SPRAYED_DAILY, Constants.INCIDENT_SPRAYED_DAILY +  '_' + thorlib.wuid() ),
																 FileServices.FinishSuperFileTransaction(),Incident_move),Output('Incident_LogicalFile_Already_Added_To_SuperFile'));
																 
//Billing Agency spray

BillingAgency_file := Constants.BILLINGAGENCY_SPRAYED_DAILY + '_'+ thorlib.wuid();
 
 BillingAgency_FileListing :=  FileServices.RemoteDirectory(Constants.LandingZone,
																						 Constants.ProcessPathForBillingAgency , 
																						 '*');
																						 
	BillingAgency_validate := nothor(apply(BillingAgency_FileListing,fnvalid('BillingAgency',name,size).doverify));


BillingAgency_spy := if (  COUNT(BillingAgency_FileListing) > 0 , Sequential( BillingAgency_validate,FileServices.SprayVariable(Constants.LandingZone, Constants.ProcessPathForBillingAgency + Constants.FileSeparator + Constants.BillingAgencyFileMask,60000,,,'"',
Constants.DestinationCluster,BillingAgency_file,-1,,,true,true,true)),FAIL('BillingAgency_Files_not_in_unix'));
			 


BillingAgency_move := nothor(apply(BillingAgency_FileListing,FileServices.MoveExternalFile(Constants.LandingZone,Constants.ProcessPathForBillingAgency + Constants.FileSeparator + name  ,Constants.BackupPathForBillingAgency + Constants.FileSeparator +  name )));
			 
	BillingAgency_addsuper := if ( FileServices.FindSuperFileSubName(Constants.BILLINGAGENCY_SPRAYED_DAILY,BillingAgency_file) = 0 and COUNT(BillingAgency_FileListing) > 0,SEQUENTIAL(FileServices.StartSuperFileTransaction(),
	                 FileServices.ClearSuperfile(Constants.BILLINGAGENCY_SPRAYED_DAILY),
										 						 FileServices.AddSuperFile(Constants.BILLINGAGENCY_SPRAYED_DAILY, Constants.BILLINGAGENCY_SPRAYED_DAILY +  '_' + thorlib.wuid() ),
																 FileServices.FinishSuperFileTransaction(),BillingAgency_move),Output('BillingAgency_LogicalFile_Already_Added_To_SuperFile'));
																 
//Vehicle Spray

 Vehicle_file := Constants.VEHICLE_SPRAYED_DAILY + '_'+ thorlib.wuid();

	
			 
  Vehicle_FileListing := FileServices.RemoteDirectory(Constants.LandingZone,
																						 Constants.ProcessPathForVehicle , 
																						 '*');

Vehicle_validate := nothor(apply(Vehicle_FileListing,fnvalid('Vehicle',name,size).doverify));

Vehicle_spy := if ( COUNT(Vehicle_FileListing) > 0 , Sequential(Vehicle_validate, FileServices.SprayVariable(Constants.LandingZone, Constants.ProcessPathForVehicle + Constants.FileSeparator + Constants.VehicleFileMask,50000,,,'"',
       Constants.DestinationCluster,Vehicle_file,-1,,,true,true,true)),FAIL('Vehicle_Files_not_in_unix'));


Vehicle_move := nothor(apply(Vehicle_FileListing,FileServices.MoveExternalFile(Constants.LandingZone,Constants.ProcessPathForVehicle + Constants.FileSeparator + name  ,Constants.BackupPathForVehicle + Constants.FileSeparator +  name )));
			 
	Vehicle_addsuper := if ( FileServices.FindSuperFileSubName(Constants.VEHICLE_SPRAYED_DAILY,Vehicle_file) = 0 and COUNT(Vehicle_FileListing) > 0,SEQUENTIAL(FileServices.StartSuperFileTransaction(),
										 						 FileServices.AddSuperFile(Constants.VEHICLE_SPRAYED_DAILY, Constants.VEHICLE_SPRAYED_DAILY +  '_' + thorlib.wuid() ),
																 FileServices.FinishSuperFileTransaction(),Vehicle_move),Output('Vehicle_LogicalFile_Already_Added_To_SuperFile'));
																 
																 
//Person Spray

Person_file := Constants.PERSON_SPRAYED_DAILY + '_'+ thorlib.wuid();


			 
Person_FileListing := FileServices.RemoteDirectory(Constants.LandingZone,
																						 Constants.ProcessPathForPerson , 
																						 '*');

Person_validate := nothor(apply(Person_FileListing,fnvalid('Person',name,size).doverify));

Person_spy := if (  COUNT(Person_FileListing) > 0 , Sequential(Person_validate,FileServices.SprayVariable(Constants.LandingZone, Constants.ProcessPathForPerson + Constants.FileSeparator + Constants.PersonFileMask,,,,'"',
       Constants.DestinationCluster,Person_file,-1,,,true,true,true)),FAIL('Person_Files_not_in_unix'));

Person_move := nothor(apply(Person_FileListing,FileServices.MoveExternalFile(Constants.LandingZone,Constants.ProcessPathForPerson + Constants.FileSeparator + name  ,Constants.BackupPathForPerson + Constants.FileSeparator +  name )));
			 
	Person_addsuper := if ( FileServices.FindSuperFileSubName(Constants.PERSON_SPRAYED_DAILY,Person_file) = 0 and COUNT(Person_FileListing) > 0,SEQUENTIAL(FileServices.StartSuperFileTransaction(),
										 						 FileServices.AddSuperFile(Constants.PERSON_SPRAYED_DAILY, Constants.PERSON_SPRAYED_DAILY +  '_' + thorlib.wuid() ),
																 FileServices.FinishSuperFileTransaction(),Person_move),Output('Person_LogicalFile_Already_Added_To_SuperFile'));
//document Spray
Document_file := Constants.DOCUMENT_SPRAYED_DAILY + '_'+ thorlib.wuid();


			 
Document_FileListing := FileServices.RemoteDirectory(Constants.LandingZone,
																						 Constants.ProcessPathForDocument , 
																						 '*');

Document_validate := nothor(apply(Document_FileListing,fnvalid('Document',name,size).doverify));

Document_spy := if (  COUNT(Document_FileListing) > 0 , Sequential(Document_validate,FileServices.SprayVariable(Constants.LandingZone, Constants.ProcessPathForPerson + Constants.FileSeparator + Constants.PersonFileMask,,,,'"',
       Constants.DestinationCluster,Document_file,-1,,,true,true,true)),Output('Document_Files_not_in_unix'));

Document_move := nothor(apply(Document_FileListing,FileServices.MoveExternalFile(Constants.LandingZone,Constants.ProcessPathForDocument + Constants.FileSeparator + name  ,Constants.BackupPathForDocument + Constants.FileSeparator +  name )));
			 
	Document_addsuper := if ( FileServices.FindSuperFileSubName(Constants.DOCUMENT_SPRAYED_DAILY,Document_file) = 0 and COUNT(Document_FileListing) > 0 ,SEQUENTIAL(FileServices.StartSuperFileTransaction(),
										 						 FileServices.AddSuperFile(Constants.DOCUMENT_SPRAYED_DAILY, Constants.DOCUMENT_SPRAYED_DAILY +  '_' + thorlib.wuid() ),
																 FileServices.FinishSuperFileTransaction(),Document_move),Output('Document_Files_Missing_In_Unix'));
																 
//Commercial Spray

Commercial_file := Constants.COMMERCIAL_SPRAYED_DAILY + '_'+ thorlib.wuid();

	
			 
Commercial_FileListing := FileServices.RemoteDirectory(Constants.LandingZone,
																						 Constants.ProcessPathForCommercial , 
																						 '*');

Commercial_validate := nothor(apply(Commercial_FileListing,fnvalid('Commercial',name,size).doverify));

Commercial_spy := if (ut.Weekday((integer) ut.GetDate) <> 'SUNDAY', if (  COUNT(Commercial_FileListing) > 0 , Sequential(Commercial_validate,FileServices.SprayVariable(Constants.LandingZone, Constants.ProcessPathForCommercial + Constants.FileSeparator + Constants.CommercialFileMask,,,,'"',
       Constants.DestinationCluster,Commercial_file,-1,,,true,true,true)),FAIL('Commercial_Files_not_in_unix')),Output('No_Commercial_Files_On_Sunday'));

Commercial_move := nothor(apply(Commercial_FileListing,FileServices.MoveExternalFile(Constants.LandingZone,Constants.ProcessPathForCommercial + Constants.FileSeparator + name  ,Constants.BackupPathForCommercial + Constants.FileSeparator +  name )));
			 
			 
	Commercial_addsuper := if ( FileServices.FindSuperFileSubName(Constants.COMMERCIAL_SPRAYED_DAILY,Commercial_file) = 0 and COUNT(Commercial_FileListing) > 0,SEQUENTIAL(FileServices.StartSuperFileTransaction(),
										 						 FileServices.AddSuperFile(Constants.COMMERCIAL_SPRAYED_DAILY, Constants.COMMERCIAL_SPRAYED_DAILY +  '_' + thorlib.wuid() ),
																 FileServices.FinishSuperFileTransaction(),Commercial_move),Output('Commerical_LogicalFile_Already_Added_To_SuperFile'));
																 
//Citation Spray

Citation_file := Constants.CITATION_SPRAYED_DAILY + '_'+ thorlib.wuid();

 
 Citation_FileListing := FileServices.RemoteDirectory(Constants.LandingZone,
																						 Constants.ProcessPathForCitation , 
																						 '*');

Citation_validate := nothor(apply(Citation_FileListing,fnvalid('Citation',name,size).doverify));

Citation_spy := if (  COUNT(Citation_FileListing) > 0 , Sequential(Citation_validate,FileServices.SprayVariable(Constants.LandingZone, Constants.ProcessPathForCitation + Constants.FileSeparator + Constants.CitationFileMask,,,,'"',
       Constants.DestinationCluster,Citation_file,-1,,,true,true,true)),FAIL('Citation_Files_not_in_unix'));
			 


Citation_move := nothor(apply(Citation_FileListing,FileServices.MoveExternalFile(Constants.LandingZone,Constants.ProcessPathForCitation + Constants.FileSeparator + name  ,Constants.BackupPathForCitation + Constants.FileSeparator +  name )));
			 
			 
	Citation_addsuper := if ( FileServices.FindSuperFileSubName(Constants.CITATION_SPRAYED_DAILY,Citation_file) = 0 and COUNT(Citation_FileListing) > 0,SEQUENTIAL(FileServices.StartSuperFileTransaction(),
										 						 FileServices.AddSuperFile(Constants.CITATION_SPRAYED_DAILY, Constants.CITATION_SPRAYED_DAILY +  '_' + thorlib.wuid() ),
																 FileServices.FinishSuperFileTransaction(),Citation_move),Output('Citation_LogicalFile_Already_Added_To_SuperFile'));
																 

//Property Damagae Spray

PropertyDamage_file := Constants.PTYDAMAGE_SPRAYED_DAILY + '_'+ thorlib.wuid();

 
			 
PTYD_FileListing := FileServices.RemoteDirectory(Constants.LandingZone,
																						 Constants.ProcessPathForPtyDamage , 
																						 '*');
PTYD_validate := nothor(apply(PTYD_FileListing,fnvalid('PropertyDamage',name,size).doverify));

PTYD_spy := if ( ut.Weekday((integer) ut.GetDate) <> 'SUNDAY' , if (  COUNT(PTYD_FileListing) > 0 , Sequential(PTYD_validate,FileServices.SprayVariable(Constants.LandingZone, Constants.ProcessPathForPtyDamage + Constants.FileSeparator + Constants.PtyDamageFileMask,50000,,,'"',
       Constants.DestinationCluster,PropertyDamage_file,-1,,,true,true,true)),FAIL('PTYDamage_Files_not_in_unix')),Output('No_PTYDFiles_On_Sunday'));


PTYD_move := nothor(apply(PTYD_FileListing,FileServices.MoveExternalFile(Constants.LandingZone,Constants.ProcessPathForPtyDamage + Constants.FileSeparator + name  ,Constants.BackupPathForPtyDamage + Constants.FileSeparator +  name )));
			 
	PropertyDamage_addsuper := if ( FileServices.FindSuperFileSubName(Constants.PTYDAMAGE_SPRAYED_DAILY,PropertyDamage_file) = 0 and COUNT(PTYD_FileListing) > 0,SEQUENTIAL(FileServices.StartSuperFileTransaction(),
										 						 FileServices.AddSuperFile(Constants.PTYDAMAGE_SPRAYED_DAILY, Constants.PTYDAMAGE_SPRAYED_DAILY +  '_' + thorlib.wuid() ),
																 FileServices.FinishSuperFileTransaction(),PTYD_move),Output('PropertyDamage_LogicalFile_Already_Added_To_SuperFile'));
																 


																 
return sequential(Agency_sp,Incident_spy,Incident_addsuper,BillingAgency_spy,BillingAgency_addsuper,Vehicle_spy,Vehicle_addsuper,Person_spy,Person_addsuper, Document_spy,Document_addsuper,Citation_spy,Citation_addsuper,
                  Commercial_spy,Commercial_addsuper,PTYD_spy,PropertyDamage_addsuper);
																 
end;