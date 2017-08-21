IMPORT ut;
export File_OR_Multnomah := dataset('~thor_data400::in::arrestlog::OR::Multnomah',
	ArrestLogs.layout_OR_Multnomah,csv(heading(1),terminator('\n'), separator('|'), quote('')));
