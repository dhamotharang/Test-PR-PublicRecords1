import ut;
export file_CA_Orange := module

	export Original := dataset(ut.foreign_prod +'~thor_data400::in::arrlog::20080922::ca_orange.txt',
	ArrestLogs.Layout_CA_Orange.Original,csv(heading(1),terminator('\n'), separator('|'), quote('')));

	export New := dataset(ut.foreign_prod +'~thor_data400::in::arrlog::ca::orange',
	ArrestLogs.Layout_CA_Orange.New,csv(heading(1),terminator('\n'), separator('|'), quote('')));
	
	end;