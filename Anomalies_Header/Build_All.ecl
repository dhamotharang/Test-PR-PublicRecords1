

Import VersionControl, _Control, ut, tools;

Export Build_all( String pversion, Boolean pUseProd = False ) := Function



    built := Sequential( 
                        Build_Base( pversion, pUseProd ).run_all,
					    Promote(pversion,pUseProd).buildfiles.Built2QA,
					    //Archive processed files in history					
					   FileServices.StartSuperFileTransaction(),
					   FileServices.AddSuperFile(Filenames(pversion,pUseProd).lInputHistTemplate,  Filenames(pversion,pUseProd).lInputTemplate,, True),
					   FileServices.ClearSuperFile(Filenames(pversion,pUseProd).lInputTemplate),
					   FileServices.FinishSuperFileTransaction(),
				): Success(Send_Email(pversion,pUseProd).BuildSuccess), Failure(send_email(pversion,pUseProd).BuildFailure );

Return built;

End;