Import _control, tools;
//test GIT
Export fSprayInFile(String FileName, String Date) := Function
Groupname := tools.fun_Groupname('44');
// Groupname := 'thor40_241';//Dataland
Result := Sequential(

		 FileServices.SprayVariable(_control.IPAddress.bctlpedata10,
															'/data/hds_2/address_feedback/online/'+filename,
															8192,'~~', '\\n,\\r\\n', '"', groupname, '~thor_data400::in::AddressFeedback::'+date,-1,,,true,true,),
		 FileServices.StartSuperFileTransaction(),
		 FileServices.ClearSuperFile('~thor_data400::in::AddressFeedback'),
		 FileServices.AddSuperFile('~thor_data400::in::AddressFeedback', '~thor_data400::in::AddressFeedback::'+date),				 
		 FileServices.FinishSuperFileTransaction()
		  );
Return Result;
End;
