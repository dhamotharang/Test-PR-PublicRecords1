import std, _control;

EXPORT Spray_iConectiv_DailyDelta(string version, string filename, string eclsourceip, string thor_name):= FUNCTION

filedate	:=	filename[9..16];

	srcdir 					:= '/data/data_999/phones/mobile_id/build/';
	abbrVersion			:= filedate;
	
	//Spray New Raw DailyDelta File					
	sprayDeltaDaily := std.File.SprayVariable(eclsourceip,
																												srcdir + abbrVersion + '/' + filename,
																												8192,
																												',',
																												'\r\n',
																												,						
																												thor_name,
																												'~thor_data400::in::phones::iconectiv_dailydelta::' + filename,
																												,
																												,
																												,
																												true,
																												false,
																												true);

	//Remove Previous Raw DailyDelta File and Add New to the DailyDelta Superfile
	addDeltaDaily 	:= sequential(FileServices.StartSuperFileTransaction(),
																Fileservices.RemoveOwnedSubFiles('~thor_data400::in::phones::iconectiv_dailydelta'),
																Fileservices.AddSuperfile('~thor_data400::in::phones::iconectiv_dailydelta', '~thor_data400::in::phones::iconectiv_dailydelta::' + filename),
																FileServices.FinishSuperFileTransaction());
	
	return 	sequential(sprayDeltaDaily,
											addDeltaDaily);

END;