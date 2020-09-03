import VersionControl,_Control,ut,lib_fileservices;

EXPORT Spray_nahdb_ERI(string filedate,	 boolean	pIsTesting	= false ) := function

lfile := '~thor_data::in::nahdb::raw_'+filedate;
	sfile := '~thor_data::in::nahdb::name' ;

	spry_raw:=DATASET([
             {NAHDBConstants.LandingZone,'/data/super_credit/ecrash/fulfilment/nhdb/raw/'+filedate
									,'ERI*.csv'
																						,0 ,lfile,[{sfile}],NAHDBConstants.DestinationCluster,'','[0-9]{8}','VARIABLE'}
		 	], VersionControl.Layout_Sprays.Info);
	
	nahdb_sp :=  if( EXISTS(FileServices.RemoteDirectory(_control.IPAddress.bctlpedata10,'/data/super_credit/ecrash/fulfilment/nhdb/raw/'+filedate,'*.csv')),
                  sequential(fileservices.clearsuperfile('~thor_data::in::nahdb::name'),VersionControl.fSprayInputFiles(spry_raw,pIsTesting := pIsTesting)), 
                  Sequential(output('NO NAHDB Files Recieved'),FAIL('JOB ABORTED AS NO NAHDB FILES ON BATCH'))); 
									
return nahdb_sp;
									
	end;