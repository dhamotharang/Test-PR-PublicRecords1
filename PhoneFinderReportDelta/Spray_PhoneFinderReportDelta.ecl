import std, _control;

EXPORT Spray_PhoneFinderReportDelta(string version, const varstring eclsourceip, string dtype):= FUNCTION

	srcdir 		:= '/data/data_999/phones/phonefinderreportdelta/';
	root			:= '~thor_data400::in::phonefinderreportdelta::';
	suffix		:= '_daily';
	filename	:= if(dtype='identities',
										'delta_phonefinder_delta_phones_rpt_' + dtype + '_' + version[1..8] + '*.txt',
									if(dtype='otherphones',
										'delta_phonefinder_delta_phones_rpt_' + dtype + '_' + version[1..8] + '*.txt',	
									if(dtype='riskindicators',
										'delta_phonefinder_delta_phones_rpt_' + dtype + '_' + version[1..8] + '*.txt',	
									if(dtype='transaction',
										'delta_phonefinder_delta_phones_rpt_' + dtype + '_' + version[1..8] + '*.txt',	
										'error')))); 
	
	//Identities
	sprayFile := std.File.SprayVariable(eclsourceip,
																			srcdir + version[1..8] + '/' + '*' + filename,
																			,
																			'|\t|',
																			'\r\n',
																			,
																			STD.System.Thorlib.Group(),
																			root + dtype + suffix + '_' + version, 
																			,
																			,
																			,
																			true,
																			false,
																			true);

	addFile 	:= sequential(FileServices.StartSuperFileTransaction(), 
													FileServices.RemoveOwnedSubFiles(root + dtype + '_daily', true),
													Fileservices.AddSuperfile(root + dtype + '_daily', root + dtype + suffix + '_' + version),
													FileServices.FinishSuperFileTransaction();
													);
	
	RETURN SEQUENTIAL(sprayFile,
										addFile);

END;  