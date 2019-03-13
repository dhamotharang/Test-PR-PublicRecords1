Import _control, ut;

Export fsprayInFile(String FileName, String Filedate) := Function
Groupname := 'thor400_36';//Prod
// Groupname := 'thor40_241';//Dataland
Result := Sequential(
		 FileServices.SprayVariable(_control.IPAddress.bctlpedata10,
															'/data/data_build_2/BadAddresses/data/'+Filedate+'/'+filename,
															8192,'\t', '\\n,\\r\\n', '"', groupname, '~thor400_92::in::BadAddresses::'+filedate,-1,,,true,true,),
		 FileServices.StartSuperFileTransaction(),
		 FileServices.ClearSuperFile('~thor400_92::in::BadAddresses'),
		 FileServices.AddSuperFile('~thor400_92::in::BadAddresses', '~thor400_92::in::BadAddresses::'+filedate),				 
		 FileServices.FinishSuperFileTransaction()
		  );
Return Result;
End;