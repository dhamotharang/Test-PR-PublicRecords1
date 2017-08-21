import ut;
export File_ID_ADA := dataset(ut.foreign_prod + '~thor_data400::in::arrestlog::id::ada',	
				ArrestLogs.layout_id_ADA,csv(heading(1),terminator('\n'), separator('|'), quote('')));
				
				