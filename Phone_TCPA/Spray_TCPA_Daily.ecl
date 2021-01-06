IMPORT Std, _control;

EXPORT Spray_TCPA_Daily(string pVersion, const varstring pEclSourceIp, string pDirectory, string pFileName, string pThor):= FUNCTION

	root				:= '~thor_data400::in::phones::tcpa_';
	tNode				:= if(pThor='',
										Std.System.Thorlib.Group(),
										pThor);
						
	sprayFile 	:= Std.File.SprayVariable(pEclSourceIp,
																				pDirectory + IF(NOT REGEXFIND(pVersion,pDirectory),pVersion,'') + '/' + pFileName + '.TXT',
																				,
																				'|',
																				'\r\n',
																				,
																				tNode,
																				root + pFileName + '_' + pVersion,
																				,
																				,
																				,
																				true,
																				false,
																				true);

	addDaily 		:= SEQUENTIAL(FileServices.StartSuperFileTransaction(),
														FileServices.RemoveOwnedSubFiles(root + pFileName, true),
														Fileservices.AddSuperfile(root + pFileName, root + pFileName + '_' + pVersion),
														FileServices.FinishSuperFileTransaction());
			
	RETURN 	SEQUENTIAL(sprayFile,
										 addDaily
										 );

END;