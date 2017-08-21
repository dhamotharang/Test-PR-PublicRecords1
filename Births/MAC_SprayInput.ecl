export MAC_SprayInput(in_xxxx,dummy) := macro
	#uniquename(in_file)
	%in_file% := in_xxxx;
	#uniquename(file_cnt)
	%file_cnt% := FileServices.GetSuperFileSubCount(%in_file%);
	#uniquename(last_file)
	%last_file% := FileServices.GetSuperFileSubName(%in_file%,1,true);
	dummy:=if	(%file_cnt%>0
				,sequential(
							fileServices.StartSuperFileTransaction(),
							fileServices.ClearSuperFile(%in_file% + '_father',true),
							FileServices.Copy(%last_file%,'thor_200',%last_file%+'_'+thorlib.wuid()),
							fileServices.AddSuperFile(%in_file% + '_father',%last_file%+'_'+thorlib.wuid()),
							fileServices.ClearSuperFile(%in_file%,true),
							fileServices.FinishSuperFileTransaction()
							)
		);
endmacro;