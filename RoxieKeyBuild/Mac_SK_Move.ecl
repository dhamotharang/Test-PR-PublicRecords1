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
%source% := case(move_type, 'Q' => RoxieKeyBuild.Check_Replace_Version(kname,'BUILT'),
							 'P' => RoxieKeyBuild.Check_Replace_Version(kname,'QA'),
							 'R' => RoxieKeyBuild.Check_Replace_Version(kname,'PROD'),
							 RoxieKeyBuild.Check_Replace_Version(kname,'NO_MOVE'));
#uniquename(dest);																		
%dest% := case(move_type, 'Q' => RoxieKeyBuild.Check_Replace_Version(kname,'QA'),
						    'P' => RoxieKeyBuild.Check_Replace_Version(kname,'PROD'),
						    'R' => RoxieKeyBuild.Check_Replace_Version(kname,'QA'),
						    RoxieKeyBuild.Check_Replace_Version(kname,'NO_MOVE'));

#uniquename(deleted)
%deleted% := RoxieKeyBuild.Check_Replace_Version(kname,'delete');


																	
seq_name := sequential(
		if (~fileservices.superfileexists(%source%),fileservices.createsuperfile(%source%)),
		if (~fileservices.superfileexists(%dest%),fileservices.createsuperfile(%dest%)),
		if (~fileservices.superfileexists(%deleted%),fileservices.createsuperfile(%deleted%)),
	map(	FileServices.GetSuperFileSubCount(%source%) = 1 and 
		  FileServices.GetSuperFileSubCount(%dest%) = 1 and
		  FileServices.GetSuperFileSubName(%source%,1) = FileServices.GetSuperFileSubName(%dest%, 1)
										=> output(%source% + ' = ' + %dest% + '. No action taken.'),
		
		FileServices.GetSuperFileSubCount(%source%) = 0
										=> output(%source% + ' is empty! No action taken.'),
		 
		sequential(
			FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(%deleted%, %dest%,, true),
				FileServices.ClearSuperFile(%dest%),
				FileServices.AddSuperFile(%dest%, %source%,,true),
				
			FileServices.FinishSuperFileTransaction(),
			FileServices.RemoveOwnedSubFiles(%deleted%, move_type in %dfset%),
			FileServices.ClearSuperFile(%deleted%),
			output(%source% + ' moved into ' + %dest%))
	));
	
endmacro;