import VersionControl,_Control,ut,lib_fileservices;

EXPORT Spray_nahdb(string filedate,	 boolean	pIsTesting	= false ) := function

lfile := '~thor_data::in::nahdb::raw_'+filedate;
	sfile := '~thor_data::in::nahdb' ;

	spry_raw:=DATASET([
             {Constants('edata12').LandingZone,'/super_credit/ecrash/nhdb/raw/'+filedate
									,'Ally*.csv'
																						,0 ,lfile,[{sfile}],Constants('edata12').DestinationCluster,'','[0-9]{8}','VARIABLE'}
		 	], VersionControl.Layout_Sprays.Info);
	
	nahdb_sp :=  if( EXISTS(FileServices.RemoteDirectory(_control.IPAddress.edata12,'/super_credit/ecrash/nhdb/raw/'+filedate,'Ally_*.csv')),
                  sequential(fileservices.clearsuperfile('~thor_data::in::nahdb'),VersionControl.fSprayInputFiles(spry_raw,pIsTesting := pIsTesting)), 
                  Sequential(output('NO NAHDB Files Recieved'),FAIL('JOB ABORTED AS NO NAHDB FILES ON BATCH'))); 
									
return nahdb_sp;
									
	end;