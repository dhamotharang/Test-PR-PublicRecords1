import ut;
// extract date from filename
EXPORT string ExtractDate(string lfn, string default = '') := MAP(
					REGEXFIND('(\\d{8})_(\\d+)', lfn) =>			// full refresh file
					 REGEXFIND('(\\d{8})_(\\d+)', lfn, 1),
					REGEXFIND('(\\d{8})\\.txt', lfn) =>			// daily file
						REGEXFIND('(\\d{8})\\.txt', lfn, 1),
					default <> '' => default,
					ut.Now());
