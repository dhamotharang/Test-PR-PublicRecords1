IMPORT ut;
export File_OK_Carter :=  MODULE
   EXPORT F20060:=dataset(ut.foreign_prod + '~thor_data400::in::arrestlog::OK::Carter::20060',
	ArrestLogs.layout_OK_Carter.l20060,csv(heading(1),terminator('\n'), separator('|'), quote('')));
   EXPORT F2008:=dataset(ut.foreign_prod + '~thor_data400::in::arrestlog::OK::Carter::2008',
	ArrestLogs.layout_OK_Carter.l2008,csv(heading(1),terminator('\n'), separator('|'), quote('')));
   EXPORT F20070:=dataset(ut.foreign_prod + '~thor_data400::in::arrestlog::OK::Carter::20070',
	ArrestLogs.layout_OK_Carter.l20070,csv(heading(1),terminator('\n'), separator('|'), quote('')));
   END;