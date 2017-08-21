export MAC_SK_Move_V3(kname,move_type, seq_name,filedate = '\' \'', noofbackups = '\'\'',nameasis = 'false') := macro
	
/* move_type may be
		'Q' for movement from BUILT to QA
		'P' for movement from QA to PROD
		'R' for movement from PROD to QA
		'D' - move the logical key directly to QA
		
	the destination will be cleared
	the contents of source will be added to destination
*/
#uniquename(dfset);
%dfset% := ['P'];//these move_types will attempt to delete the files in dest

#uniquename(source);
%source% := if (~nameasis
							,case(move_type, 'Q' => RoxieKeyBuild.Check_Replace_Version(kname,'BUILT'),
							 'P' => RoxieKeyBuild.Check_Replace_Version(kname,'QA'),
							 'R' => RoxieKeyBuild.Check_Replace_Version(kname,'PROD'),
							 'D' => RoxieKeyBuild.Check_Replace_Version(kname,filedate),
							 RoxieKeyBuild.Check_Replace_Version(kname,'NO_MOVE'))
							 ,RoxieKeyBuild.Check_Replace_Version(kname,filedate)
							);

#uniquename(firstbackup);
%firstbackup% := RoxieKeyBuild.Check_Replace_Version(kname,'father');

#uniquename(secondbackup);
%secondbackup% := RoxieKeyBuild.Check_Replace_Version(kname,'grandfather');

#uniquename(ng)
%ng% := (integer)noofbackups;

#uniquename(dest);																		
%dest% := if (~nameasis
							,case(move_type, 'Q' => RoxieKeyBuild.Check_Replace_Version(kname,'QA'),
						    'P' => RoxieKeyBuild.Check_Replace_Version(kname,'PROD'),
						    'R' => RoxieKeyBuild.Check_Replace_Version(kname,'QA'),
							'D' => RoxieKeyBuild.Check_Replace_Version(kname,'QA'),
						    RoxieKeyBuild.Check_Replace_Version(kname,'NO_MOVE'))
							,kname
						);

#uniquename(deleted)
%deleted% := RoxieKeyBuild.Check_Replace_Version(kname,'delete');

#uniquename(todelete)
%todelete% := map(%ng% = 2 => %secondbackup%,
                  %ng% = 1 => %firstbackup%, 
                  %dest%);

#uniquename(createsuperfiles)
%createsuperfiles% := sequential
						(
							if(not fileservices.superfileexists(%dest%),
							fileservices.createsuperfile(%dest%)
							),
							#if (move_type <> 'D')
								if(not fileservices.superfileexists(%source%),
								fileservices.createsuperfile(%source%)
								),
							#end
							if(not fileservices.superfileexists(%firstbackup%),
							fileservices.createsuperfile(%firstbackup%)
							),
							if(not fileservices.superfileexists(%secondbackup%),
							fileservices.createsuperfile(%secondbackup%)
							),
							if(not fileservices.superfileexists(%deleted%),
							fileservices.createsuperfile(%deleted%)
							)
						);

																	
seq_name := 
	sequential(
	%createsuperfiles%,
	if ( move_type <> 'D',
	map(	FileServices.GetSuperFileSubCount(%source%) = 1 and 
		  FileServices.GetSuperFileSubCount(%dest%) = 1 and
		  FileServices.GetSuperFileSubName(%source%,1) = FileServices.GetSuperFileSubName(%dest%, 1)
										=> output(%source% + ' = ' + %dest% + '. No action taken.'),
		
		FileServices.GetSuperFileSubCount(%source%) = 0
										=> output(%source% + ' is empty! No action taken.'),
		 
		sequential(
			FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(%deleted%, %todelete%,, true),
				#if(%ng% = 2)
					
					fileservices.clearsuperfile(%secondbackup%),
					fileservices.addsuperfile(%secondbackup%,%firstbackup%,,true),
				#end
				#if(%ng% in [1,2])
					fileservices.clearsuperfile(%firstbackup%),
					fileservices.addsuperfile(%firstbackup%,%dest%,,true),
				
				#end
				
				FileServices.ClearSuperFile(%dest%),
				FileServices.AddSuperFile(%dest%, %source%,,true),
				
				
			FileServices.FinishSuperFileTransaction(),
			FileServices.RemoveOwnedSubFiles(%deleted%, move_type in %dfset%),
			output(%source% + ' moved into ' + %dest%))
	),
	map(	%source% = '~'+FileServices.GetSuperFileSubName(%dest%, 1)
										=> output(%source% + ' = ' + %dest% + '. No action taken.'),
		sequential(
			FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(%deleted%, %todelete%,, true),
				#if(%ng% = 2)
					
					fileservices.clearsuperfile(%secondbackup%),
					fileservices.addsuperfile(%secondbackup%,%firstbackup%,,true),
				#end
				#if(%ng% in [1,2])
					fileservices.clearsuperfile(%firstbackup%),
					fileservices.addsuperfile(%firstbackup%,%dest%,,true),
				
				#end
				Fileservices.clearsuperfile(%dest%),
				FileServices.AddSuperFile(%dest%, %source%),
			FileServices.FinishSuperFileTransaction(),
			FileServices.RemoveOwnedSubFiles(%deleted%, true),
			output(%source% + ' moved into ' + %dest%))
	)));
	
endmacro;