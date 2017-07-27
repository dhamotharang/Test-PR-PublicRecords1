import ut,Gong_v2,Phonesplus;

export file_QSENT_GONG_IN := dataset('~thor_data400::in::qsent_processed',
								   Phonesplus.Layout_QSENT_DailyTransfer,csv(terminator('\n'), separator('\t')));

