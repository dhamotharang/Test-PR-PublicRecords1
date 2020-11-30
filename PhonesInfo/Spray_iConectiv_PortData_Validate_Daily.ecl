IMPORT _control, Std;

EXPORT Spray_iConectiv_PortData_Validate_Daily(string version, const varstring eclsourceip, string thor_name):= FUNCTION

	//SORT FILES IN DIRECTORY FOR SPRAY
	srcdir 	:= '/data/data_999/phones/mobile_id_api/build/';
	sfDaily := '~thor_data400::in::phones::portdata_validate_daily';

	List 		:= Std.File.RemoteDirectory(eclsourceip, srcdir + version +'/', '*.json');
	List2 	:= SORT(List, name) : GLOBAL(FEW); //Process Alphabetically
							
	sprayFile(string filename) 	:= Std.File.SprayVariable(eclsourceip,
																												srcdir + version + '/' + filename,
																												8192,
																												,
																												'},{,]',
																												,						
																												Std.System.Thorlib.Group(),
																												sfDaily + '_' + filename,
																												,
																												,
																												,
																												true,
																												false,
																												true);

	sprayFiles 									:= NOTHOR(APPLY(List2, sprayFile(name)));

	fAddToSuper(string pSubName):= Std.File.AddSuperFile(sfDaily, sfDaily + '_' + pSubName);
			
	addToSuperFile 							:= SEQUENTIAL(Std.File.StartSuperFileTransaction(),
																						FileServices.RemoveOwnedSubFiles(sfDaily, true),		
																						NOTHOR(APPLY(List2, fAddToSuper(name))),
																						Std.File.FinishSuperFileTransaction());

	RETURN SEQUENTIAL(sprayFiles,
										addToSuperFile);

END;