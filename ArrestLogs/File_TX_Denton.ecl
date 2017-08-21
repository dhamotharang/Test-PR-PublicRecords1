import ut;

export File_TX_Denton := 
  module
	export old :=	dataset('~thor_data400::in::arrlog::tx::denton',
	ArrestLogs.Layout_TX_Denton.old_format,csv(heading(1),terminator('\n'), separator('|'), quote('')));
	export new :=	dataset('~thor_data400::in::arrlog::tx::denton_new',
	ArrestLogs.Layout_TX_Denton.new_format,csv(heading(1),terminator('\n'), separator('|'), quote('')));
	end;