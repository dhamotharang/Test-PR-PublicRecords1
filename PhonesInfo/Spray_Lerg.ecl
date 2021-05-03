import std, _control;

EXPORT Spray_Lerg(string version, const varstring eclsourceip, string thor_name):= FUNCTION

	//Linux Directories
	srcdir 	:= '/data/data_999/phones/';
	dir1		:= 'lerg';
	
	//Thor File Names
	root		:= '~thor_data400::in::phones::';
	suff1		:= 'lerg1';
	suff2		:= 'lerg1con';
																											
	//Clear Lerg1 Superfile
	clrL1File			:= FileServices.RemoveOwnedSubFiles(root + suff1, true);
	
	sprayL1File 	:= std.File.SprayVariable(eclsourceip,
																				srcdir + dir1 + '/' + version + '/' + 'LERG_1.txt',
																				,
																				',',
																				'\r\n',
																				,
																				STD.System.Thorlib.Group(),
																				root + suff1 + '_' + version,
																				,
																				,
																				,
																				true,
																				false,
																				true);

	addL1Raw 			:= sequential(FileServices.StartSuperFileTransaction(),
															FileServices.RemoveOwnedSubFiles('~thor_data400::in::phones::lerg1', true),
															Fileservices.AddSuperfile('~thor_data400::in::phones::lerg1', root + suff1 + '_' + version),
															FileServices.FinishSuperFileTransaction());	
	
	//Clear Lerg1Con Superfile
	clrL1CFile		:= FileServices.RemoveOwnedSubFiles(root + suff2, true);
	
	sprayL1CFile	:= std.File.SprayVariable(eclsourceip,
																				srcdir + dir1 + '/' + version + '/' + 'LERG_1_CON.txt',
																				,
																				',',
																				'\r\n',
																				,
																				STD.System.Thorlib.Group(),
																				root + suff2 + '_' + version,
																				,
																				,
																				,
																				true,
																				false,
																				true);

	addL1CRaw 		:= sequential(FileServices.StartSuperFileTransaction(),
															FileServices.RemoveOwnedSubFiles('~thor_data400::in::phones::lerg1con', true),
															Fileservices.AddSuperfile('~thor_data400::in::phones::lerg1con', root + suff2 + '_' + version),
															FileServices.FinishSuperFileTransaction());
	
	lergOrig 			:= SEQUENTIAL(clrL1File,	
															sprayL1File,
															addL1Raw,
															clrL1CFile,	
															sprayL1CFile,
															addL1CRaw);
			
	return lergOrig;

END;  
