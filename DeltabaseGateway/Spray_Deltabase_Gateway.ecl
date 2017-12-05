import std, _control;

EXPORT Spray_Deltabase_Gateway(string version, const varstring eclsourceip, string thor_name):= FUNCTION

	srcdir 			:= '/data/data_999/phones/delta_gateway/file_recieved/';
	root				:= '~thor_data400::in::deltabase_gateway::historic_results_';
	filename		:= '*.txt'; 
	
	sprayLR 		:= std.File.SprayVariable(eclsourceip,
																				srcdir + version + '/' + filename,
																				,
																				'|\t|',
																				'\r\n',
																				,
																				STD.System.Thorlib.Group(),
																				root + version, 
																				,
																				,
																				,
																				true,
																				false,
																				true);

	addLR 			:= sequential(	FileServices.StartSuperFileTransaction(),
															FileServices.RemoveOwnedSubFiles(root+'daily', true),
															Fileservices.AddSuperfile(root+'daily', root + version),
															FileServices.FinishSuperFileTransaction();
															);
			
	RETURN SEQUENTIAL(sprayLR,
											addLR);

END;  