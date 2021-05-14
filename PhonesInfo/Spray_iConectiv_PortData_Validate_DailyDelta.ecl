IMPORT _control, Std;

EXPORT Spray_iConectiv_PortData_Validate_DailyDelta(string version, string filename, string eclsourceip, string thor_name):= FUNCTION

	//SORT FILES IN DIRECTORY FOR SPRAY
	srcdir 					:= '/data/data_999/phones/mobile_id_api/build/';
	sfDaily 				:= '~thor_data400::in::phones::portdata_validate_dailydelta';

	filedate				:= filename[11..18];
	abbrVersion			:= filedate;
	
	//Spray New Raw DailyDelta File					
	sprayDeltaDaily := std.File.SprayVariable(eclsourceip,
																						srcdir + abbrVersion + '/' + filename,
																						8192,
																						,
																						'},{,]',
																						,						
																						STD.System.Thorlib.Group(),
																						sfDaily + '_' + filename,
																						,
																						,
																						,
																						true,
																						false,
																						true);

	//Remove Previous Raw DailyDelta File and Add New to the DailyDelta Superfile
	addDeltaDaily 	:= sequential(FileServices.StartSuperFileTransaction(),
																Fileservices.RemoveOwnedSubFiles(sfDaily),
																Fileservices.AddSuperfile(sfDaily, sfDaily + '_' + filename),
																FileServices.FinishSuperFileTransaction());
	
	RETURN sequential(sprayDeltaDaily,
										addDeltaDaily);

END;