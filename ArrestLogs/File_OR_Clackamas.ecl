Import ut;
export File_OR_Clackamas :=  MODULE
   EXPORT F20061_20070:=dataset(ut.foreign_prod + '~thor_data400::in::arrestlog::OR::clackamas::20070',
	ArrestLogs.layout_OR_clackamas.l20061_20070,csv(heading(1),terminator('\n'), separator('|'), quote('')));
   EXPORT F20071_2008:=dataset(ut.foreign_prod + '~thor_data400::in::arrestlog::OR::clackamas::20071',
	ArrestLogs.layout_OR_clackamas.l20071_2008,csv(heading(1),terminator('\n'), separator('|'), quote('')));
   END;