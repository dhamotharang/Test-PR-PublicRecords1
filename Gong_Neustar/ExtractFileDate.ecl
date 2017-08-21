EXPORT string ExtractFileDate(string lfn, string rundate) := MAP(
					REGEXFIND('(\\d{8}_)(\\d+)', lfn) =>			// full refresh file
					 REGEXFIND('(\\d{8}_)(\\d+)', lfn, 1) + IntFormat((integer)REGEXFIND('(\\d{8}_)(\\d+)', lfn, 2), 2, 1),
					REGEXFIND('(\\d{8})\\.txt', lfn) =>			// daily file
						REGEXFIND('(\\d{8})\\.txt', lfn, 1),
					rundate);
