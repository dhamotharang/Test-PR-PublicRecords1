IMPORT Std;

EXPORT Spray_IP_Metadata (string version, const varstring eclsourceip):= FUNCTION

	srcdir 			:= '/data/data_999/phones/ip_metadata/build/';
	suffixF			:= 'ip_metadata_header.csv';
	root				:= '~thor_data400::in::ip_metadata_';
	
	sprayFile 	:= std.File.SprayVariable(eclsourceip,
																				srcdir + version + '/' + suffixF,
																				,
																				';',
																				'\r\n',
																				,
																				//'thor400_sta01',//dataland
																				'thor400_44',//production
																				root + version,
																				,
																				,
																				,
																				true,
																				false,
																				true);

	addSuper 		:= sequential(FileServices.StartSuperFileTransaction(),
														FileServices.RemoveOwnedSubFiles('~thor_data400::in::ip_metadata_raw', true),
														Fileservices.AddSuperfile('~thor_data400::in::ip_metadata_raw', root + version),
														FileServices.FinishSuperFileTransaction());

	return sequential(sprayFile, addSuper);

END;