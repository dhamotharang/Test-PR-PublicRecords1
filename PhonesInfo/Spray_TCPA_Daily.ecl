import std, _control;

EXPORT Spray_TCPA_Daily(string version, const varstring eclsourceip, string thor_name):= FUNCTION

	srcdir 			:= '/data/data_999/phones/tcpa_daily/build/';
	root				:= '~thor_data400::in::phones::neustar_';
	
	suffixCL		:= 'WIRELESS-TO-WIRELINE-NORANGE.TXT';
	suffixLC		:= 'WIRELINE-TO-WIRELESS-NORANGE.TXT';
						
	sprayLCFile := std.File.SprayVariable(eclsourceip,
																				srcdir + version + '/' + suffixLC,
																				,
																				',',
																				'\r\n',
																				,
																				STD.System.Thorlib.Group(),
																				root + version + '_' + suffixLC,
																				,
																				,
																				,
																				true,
																				false,
																				true);

	addLCDaily 	:= sequential(	FileServices.StartSuperFileTransaction(),
															FileServices.RemoveOwnedSubFiles('~thor_data400::in::phones::wireline_to_wireless::tcpa_daily', true),
															Fileservices.AddSuperfile('~thor_data400::in::phones::wireline_to_wireless::tcpa_daily', root + version + '_' + suffixLC),
															FileServices.FinishSuperFileTransaction());

	sprayCLFile	:= std.File.SprayVariable(eclsourceip,
																				srcdir + version + '/' + suffixCL,
																				,
																				',',
																				'\r\n',
																				,
																				thor_name,
																				root + version + '_' + suffixCL,
																				,
																				,
																				,
																				true,
																				false,
																				true);							
													
	addCLDaily := sequential(	FileServices.StartSuperFileTransaction(),
														Fileservices.RemoveOwnedSubFiles('~thor_data400::in::phones::wireless_to_wireline::tcpa_daily', true),
														Fileservices.AddSuperfile('~thor_data400::in::phones::wireless_to_wireline::tcpa_daily', root + version + '_' + suffixCL),
														FileServices.FinishSuperFileTransaction());
			
	return 			SEQUENTIAL(sprayLCFile,
														addLCDaily,
														sprayCLFile,
														addCLDaily);

END;