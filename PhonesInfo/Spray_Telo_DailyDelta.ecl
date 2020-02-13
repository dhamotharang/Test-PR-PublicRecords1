import std, _control;

EXPORT Spray_Telo_DailyDelta(string version, string filename, string eclsourceip, string thor_name):= FUNCTION

	filedate				:=	filename[6..13];

	srcdir 					:= '/data/data_999/phones/mobile_id/build/';
	abbrVersion			:= filedate;
	
	//Spray New Raw DailyDelta File					
	sprayDeltaDaily := std.File.SprayVariable(eclsourceip,
																						srcdir + abbrVersion + '/' + filename,
																						8192,
																						',',
																						'\r\n',
																						,						
																						STD.System.Thorlib.Group(),
																						'~thor_data400::in::phones::telo_dailydelta::' + filename,
																						,
																						,
																						,
																						true,
																						false,
																						true);

	//Remove Previous Raw DailyDelta File and Add New to the DailyDelta Superfile
	addDeltaDaily 	:= sequential(FileServices.StartSuperFileTransaction(),
																Fileservices.RemoveOwnedSubFiles('~thor_data400::in::phones::telo_dailydelta'),
																Fileservices.AddSuperfile('~thor_data400::in::phones::telo_dailydelta', '~thor_data400::in::phones::telo_dailydelta::' + filename),
																FileServices.FinishSuperFileTransaction());
	
	return sequential(sprayDeltaDaily,
										addDeltaDaily);

END;