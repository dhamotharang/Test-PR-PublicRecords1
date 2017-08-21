import std, _control;

EXPORT Spray_Deact_Daily(string version, const varstring eclsourceip, string thor_name):= FUNCTION

	srcdir 	:= '/data/data_999/phones/mobile_id_deact/build/';
	sfDaily := '~thor_data400::in::phones::deact_daily';
	
	//Clear Superfile
	clrFile	:= FileServices.RemoveOwnedSubFiles(sfDaily, true);

	//Sort Files in Directory for Spray
	List 		:= std.File.RemoteDirectory(eclsourceip, srcdir + version +'/', '*_deact*.txt');
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
																						NOTHOR(APPLY(List2, fAddToSuper(name))),
																						std.File.FinishSuperFileTransaction());

	return SEQUENTIAL(clrFile,	
										sprayFiles,
										addToSuperFile);

END; 
