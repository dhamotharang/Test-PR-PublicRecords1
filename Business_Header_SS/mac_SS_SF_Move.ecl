export mac_SS_SF_Move(fname, seq_name) := macro
	
/* right now just for move from base to prod (which exposes world to new slimsorts)
code borrowed from ut.MAC_SK_Move and modified
*/


#uniquename(source);
%source% := fname;
#uniquename(dest);																		
%dest% := fname +  '_PROD';
																	
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