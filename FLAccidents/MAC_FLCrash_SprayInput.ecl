export mac_flcrash_sprayinput(in_xxxx,dummy) := macro
		#uniquename(in_file)
		%in_file% := in_xxxx;
		#uniquename(file_cnt)
		%file_cnt% := FileServices.GetSuperFileSubCount(%in_file%);
		#uniquename(last_file)
		%last_file% := FileServices.GetSuperFileSubName(%in_file%,1,true);
		#uniquename(env)
		%env%  := if ( _control.ThisEnvironment.Name = 'Dataland','thor400_88_dev','thor_dell400');
		dummy:=if	(%file_cnt%>0
					,sequential(
								fileServices.StartSuperFileTransaction(),
								fileServices.ClearSuperFile(%in_file% +  '_father' ),
								// FileServices.Copy(%last_file%,'thor_dataland_linux',%last_file%+'_'+thorlib.wuid()),
								//FileServices.Copy(%last_file%,%env%,%last_file%+'_'+thorlib.wuid()),
								fileServices.AddSuperFile(%in_file% + '_father',%in_file%,,true),
							  fileServices.ClearSuperFile(%in_file%  ),

								fileServices.FinishSuperFileTransaction()
								)
			);
endmacro;