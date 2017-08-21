export mac_seedfile_spray(in_xxxx,dummy) := macro
import lib_fileservices;

		#uniquename(in_file)
		%in_file% := in_xxxx;
		#uniquename(file_cnt)
		%file_cnt% := nothor(FileServices.GetSuperFileSubCount(%in_file%));
							     
	
		dummy := if	(%file_cnt%>0
					,sequential(
								fileServices.StartSuperFileTransaction(),
								if( not FileServices.FileExists(%in_file% +  '_father'),fileServices.CreateSuperFile(%in_file% +  '_father')),
								fileServices.ClearSuperFile(%in_file% +  '_father' ),
								fileServices.AddSuperFile(%in_file% + '_father',%in_file%),
							  fileServices.ClearSuperFile(%in_file%  ),

								fileServices.FinishSuperFileTransaction()
								)
			);
endmacro;