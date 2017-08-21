Import _control, ut;

Export proc_suppress(String Filedate) := Function
Groupname := 'thor400_60';//Prod
// Groupname := 'thor40_241';//Dataland
Result := Sequential(
		 FileServices.SprayVariable(Constants.LandingZone,
															'/data/super_credit/ecrash/despray/tosuppress/build/'+Filedate+'/'+'*.csv',
															,, ,, groupname, '~thor_data::in::ecrash_deletes::'+filedate,-1,,,true,true,false),
		 FileServices.StartSuperFileTransaction(),
		 FileServices.AddSuperFile('~thor_data::in::ecrash_deletes', '~thor_data::in::ecrash_deletes::'+filedate),				 
		 FileServices.FinishSuperFileTransaction()
		  );
Return Result;
End;