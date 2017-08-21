import ut;

export File_QSENT_DailyTransfer := dataset('~thor_data400::in::qsent_update',
								   Layout_QSENT_DailyTransfer,csv(terminator('\n'), separator('\t')));