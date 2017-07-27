add_to_built := 
       sequential(FileServices.StartSuperFileTransaction(),
                  FileServices.ClearSuperFile('~thor_data400::in::lssi_update_built'),
	       	   FileServices.AddSuperFile('~thor_data400::in::lssi_update_built', 
                                            '~thor_data400::in::lssi_update',, true),
                  FileServices.FinishSuperFileTransaction());
			   
export proc_build_lssi_update_all := 
       if(FileServices.GetSuperFileSubName('~thor_data400::in::lssi_update',1) = 
          FileServices.GetSuperFileSubName('~thor_data400::in::lssi_update_built',1),
		fail('No new input file, might be file spraying failed.'), 
		sequential(lssi.proc_build_lssi_update_file,
	                lssi.proc_build_lssi_update_keys,
                     add_to_built));       