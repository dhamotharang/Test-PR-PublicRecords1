export MAC_SK_Move(kname, move_type, seq_name) := macro
	
/* move_type may be
		'Q' for movement from BUILT to QA
		'P' for movement from QA to PROD
		'R' for movement from PROD to QA
		
	the destination will be cleared
	the contents of source will be added to destination
*/
#uniquename(dfset);
%dfset% := ['P','Q'];//these move_types will attempt to delete the files in dest

#uniquename(source);
%source% := kname + case(move_type, 'Q' => '_BUILT',
							 'P' => '_QA',
							 'R' => '_PROD',
							 '_NO_MOVE');
#uniquename(dest);																		
%dest% := kname + case(move_type, 'Q' => '_QA',
						    'P' => '_PROD',
						    'R' => '_QA',
						    '_NO_MOVE');
																	
seq_name := 
	map(	FileServices.GetSuperFileSubCount(%source%) = 1 and 
		  FileServices.GetSuperFileSubCount(%dest%) = 1 and
		  FileServices.GetSuperFileSubName(%source%,1) = FileServices.GetSuperFileSubName(%dest%, 1)
										=> output(%source% + ' = ' + %dest% + '. No action taken.'),
		
		FileServices.GetSuperFileSubCount(%source%) = 0
										=> output(%source% + ' is empty! No action taken.'),
		 
		sequential(
			FileServices.StartSuperFileTransaction(),
				FileServices.ClearSuperFile(%dest%),
				FileServices.AddSuperFile(%dest%, %source%,,true),
			FileServices.FinishSuperFileTransaction(),
			output(%source% + ' moved into ' + %dest%))
	);
	
endmacro;