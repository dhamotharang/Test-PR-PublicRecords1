import ut;
export File_ID_Canyon := dataset(ut.foreign_prod + '~thor_data400::in::arrestlog::id::canyon',	
				ArrestLogs.layout_id_canyon,csv(heading(1),terminator('\r\n'), separator('|'), quote('')));