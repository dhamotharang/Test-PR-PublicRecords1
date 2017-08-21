import ut;
export file_bankruptcyv3_courts := dataset('~thor_data400::base::bankruptcyv3::courts',
																					{layout_courts, unsigned8 RecPos{virtual(fileposition)}},
																					CSV(SEPARATOR(['\t']), quote('"'),TERMINATOR(['\n','\r\n'])));