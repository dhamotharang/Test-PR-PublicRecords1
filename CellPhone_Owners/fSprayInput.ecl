Import _control, ut;

Export fSprayInput(String filename) := Function //Filedate Should be MMDDYYYY
Groupname := 'thor400_92';//Prod
// Groupname := 'thor40_241';//Dataland
Result := Sequential(FileServices.fSprayVariable('edata12-bld.br.seisint.com',
																						'/hds_2/PhoneOwnership/'+filename+'.csv',
																						40000,
																						',',
																						'\\n,\\r\\n',
																						'"',
																						groupname,
																						'~thor_data400::in::cellphoneowners::'+filename,
																						-1,
																						,
																						,
																						true,
																						true, 
																						true),
									 FileServices.StartSuperFileTransaction(),
									 // FileServices.ClearSuperFile('~thor_data400::in::cellphoneowners'),
									 FileServices.AddSuperFile('~thor_data400::in::cellphoneowners', '~thor_data400::in::cellphoneowners::'+filename),				 
									 FileServices.FinishSuperFileTransaction()
									 );
Return Result;
End;
