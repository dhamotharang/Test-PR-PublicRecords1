import std, _control;

EXPORT Spray_Lerg_In(string version, const varstring eclsourceip, string thor_file, string thor_name):= FUNCTION

	//DF-24140: Lerg6 Layout Change

	//Linux Directories
	srcdir 	:= '/data/data_999/phones/';
	dir1		:= 'lerg';
	
	//Thor File Names
	root		:= '~thor_data400::in::phones::';
																											
	//Clear Lerg Superfile
	clrFile				:= FileServices.RemoveOwnedSubFiles(root + thor_file, true);
	
	//Spray Lerg File to Thor
	sprayFile 		:= Std.File.SprayVariable(eclsourceip,
																					srcdir + dir1 + '/' + version[1..8] + '/' + stringlib.stringtouppercase(thor_file) + '.txt',
																					,
																					',',
																					'\r\n',
																					,
																					STD.System.Thorlib.Group(),
																					root + thor_file + '_' + version,
																					,
																					,
																					,
																					true,
																					false,
																					true);

	//Add Thor Logical File to Superfile
	addRaw 				:= sequential(FileServices.StartSuperFileTransaction(),
															FileServices.RemoveOwnedSubFiles('~thor_data400::in::phones::' + thor_file, true),
															Fileservices.AddSuperfile('~thor_data400::in::phones::' + thor_file, root + thor_file +'_' + version),
															FileServices.FinishSuperFileTransaction());	
	
	lergSpray 		:= SEQUENTIAL(clrFile,	
															sprayFile,
															addRaw);
			
	return lergSpray;

END;  
