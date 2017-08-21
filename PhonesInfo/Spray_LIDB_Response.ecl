import std, _control;

EXPORT Spray_LIDB_Response(string version, const varstring eclsourceip, string thor_name):= FUNCTION

	srcdir 			:= '/data/data_999/phones/lidb_response/file_recieved/';
	root				:= '~thor_data400::in::phones::lidb_response_';
	suffix			:= 'FROM_ATT_';
	
	sprayLR 		:= std.File.SprayVariable(eclsourceip,
																				srcdir + version + '/' + suffix + version + '.txt',
																				,
																				'\t',
																				'\r\n',
																				,
																				thor_name,
																				root + version, 
																				,
																				,
																				,
																				true,
																				false,
																				true);

	addLR 			:= sequential(	FileServices.StartSuperFileTransaction(),
															FileServices.AddSuperFile('~thor_data400::in::phones::lidb_response_delete','~thor_data400::in::phones::lidb_response_grandfather',,true),
															FileServices.ClearSuperFile('~thor_data400::in::phones::lidb_response_grandfather'),
															FileServices.AddSuperFile('~thor_data400::in::phones::lidb_response_grandfather','~thor_data400::in::phones::lidb_response_father',,true),
															FileServices.ClearSuperFile('~thor_data400::in::phones::lidb_response_father'),
															FileServices.AddSuperFile('~thor_data400::in::phones::lidb_response_father','~thor_data400::in::phones::lidb_response',,true),
															FileServices.ClearSuperFile('~thor_data400::in::phones::lidb_response'),
															FileServices.AddSuperFile('~thor_data400::in::phones::lidb_response', root + version),
															FileServices.FinishSuperFileTransaction(),
															FileServices.RemoveOwnedSubFiles('~thor_data400::in::phones::lidb_response_delete',true)
															//Fileservices.ClearSuperfile('~thor_data400::in::phones::lidb_response'),
															//Fileservices.AddSuperfile('~thor_data400::in::phones::lidb_response', root + version),
															//FileServices.FinishSuperFileTransaction()
															);
			
	return SEQUENTIAL(sprayLR,
											addLR);

END;  
