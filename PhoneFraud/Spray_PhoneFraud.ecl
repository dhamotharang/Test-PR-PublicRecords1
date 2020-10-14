IMPORT std, _control;

//dtype: 'otp' or 'spoofing'

EXPORT Spray_PhoneFraud(string version, string dtype):= FUNCTION

	srcdir 			:= '/data/data_999/phones/';
	root				:= '~thor_data400::in::phonefraud_';
	suffix			:= dtype;
	filename		:= if(dtype='otp',
										'delta_' + dtype + '_delta_' + dtype + '_' + version[1..8] + '.txt',
									if(dtype='spoofing',
										'delta_phonefinder_delta_phones_' + dtype + '_' + version[1..8] + '.txt',	
										'error'));
	
	sprayLR 		:= std.File.SprayVariable(_control.IPAddress.bctlpedata10,
																				srcdir + suffix + '/' + version + '/' + filename,
																				,
																				'|',
																				,
																				'\t',
																				'thor400_44',
																				root + suffix + '_' + version, 
																				,
																				,
																				,
																				true,
																				false,
																				true);

	addLR 			:= sequential(	FileServices.StartSuperFileTransaction(),
															FileServices.RemoveOwnedSubFiles('~thor_data400::in::phonefraud_'+ suffix +'_daily', true),
															Fileservices.AddSuperfile('~thor_data400::in::phonefraud_'+ suffix +'_daily', root + suffix + '_' + version),
															FileServices.FinishSuperFileTransaction();
															);
			
	RETURN SEQUENTIAL(sprayLR,
											addLR);

END;  
