IMPORT ut;
//			  ut.foreign_prod +	'thor::in::gong::targus::daily::'+ dt[1..6] +'::DailyFeed_' + dt + '.txt',
lfn_full := 'thor::in::gong::targus::full::' + '20160131';
lfn_daily := 'thor::in::gong::targus::daily::201602::DailyFeed_20160209.txt';
EXPORT In_File_Neustar := DATASET(ut.foreign_prod + lfn_daily,
						layout_file_neustar,
										CSV(
												SEPARATOR('|')
											, TERMINATOR(['\n', '\r\n'])
											, MAXLENGTH(2500)
											)
								);
