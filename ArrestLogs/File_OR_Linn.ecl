IMPORT UT;
export File_OR_Linn := 
   MODULE
   EXPORT Old:=dataset(ut.foreign_prod + '~thor_data400::in::arrestlog::OR::oldLinn',
	ArrestLogs.layout_OR_Linn.old,csv(heading(1),terminator('\n'), separator('|'), quote('')));
   EXPORT new:=dataset(ut.foreign_prod + '~thor_data400::in::arrestlog::OR::Linn',
	ArrestLogs.layout_OR_Linn.new,csv(heading(1),terminator('\n'), separator('|'), quote('')));
   END;