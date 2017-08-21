import ut;
string ExtractDate(string lfn) := MAP(
					REGEXFIND('(\\d{8}_)(\\d+)', lfn) =>			// full refresh file
					 REGEXFIND('(\\d{8})(\\d+)', lfn, 1),
					REGEXFIND('(\\d{8})\\.txt', lfn) =>			// daily file
						REGEXFIND('(\\d{8})\\.txt', lfn, 1),
					ut.Now());
					
EXPORT ProcessDailyHistory(dataset(layout_Neustar) daily, dataset(layout_history) history_base, string updatedate='') := FUNCTION

		update_date := IF(updatedate='', ExtractDate(daily[1].filename), updatedate);
																										
		dels := PreprocessDeletes(daily(action_code = 'D'));
		adds := PreprocessAdds(daily(action_code in ['A','I']), update_date);

		h1 := ApplyDelsToHistory(dels, history_base);
		h2 := ApplyAddsToHistory(adds, h1, update_date);

		return h2;
END;
