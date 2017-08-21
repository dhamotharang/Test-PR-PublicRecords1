import std, _control;

EXPORT Spray_iConectiv_Daily(string version, const varstring eclsourceip, string thor_name):= FUNCTION

	//SORT FILES IN DIRECTORY FOR SPRAY
	srcdir 	:= '/data/data_999/phones/mobile_id/build/';
	sfDaily := '~thor_data400::in::phones::iconectiv_daily';

	List 		:= std.File.RemoteDirectory(eclsourceip, srcdir + version +'/', '*.CSV');
	List2 	:= SORT(List, name) : GLOBAL(FEW); //Process Alphabetically
							
	sprayFile(string filename) 	:= std.File.SprayVariable(eclsourceip,
																												srcdir + version + '/' + filename,
																												8192,
																												',',
																												'\r\n',
																												,						
																												thor_name,
																												'~thor_data400::in::phones::' + filename,
																												,
																												,
																												,
																												true,
																												false,
																												true);

	sprayFiles 									:= NOTHOR(APPLY(List2, sprayFile(name)));

	fAddToSuper(string pSubName):= std.File.AddSuperFile(sfDaily, '~thor_data400::in::phones::' + pSubName);
			
	addToSuperFile 							:= SEQUENTIAL(std.File.StartSuperFileTransaction(),
																						FileServices.RemoveOwnedSubFiles(sfDaily, true),		
																						NOTHOR(APPLY(List2, fAddToSuper(name))),
																						std.File.FinishSuperFileTransaction());

	return 											SEQUENTIAL(sprayFiles,
																					addToSuperFile);

END;