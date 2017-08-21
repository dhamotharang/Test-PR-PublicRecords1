import ut;
export File_WA_Pierce := dataset(ut.foreign_prod + '~thor_data400::in::arrestlog::WA::Pierce',	
				ArrestLogs.layout_WA_Pierce,csv(heading(1),terminator('\n'), separator('|'), quote('')));