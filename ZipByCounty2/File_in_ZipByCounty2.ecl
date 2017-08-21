
export File_in_ZipByCounty2 := dataset('~thor_data400::in::countystate_zip',ZipByCounty2.Layout_in_ZipByCounty2,
																				CSV(HEADING(0), SEPARATOR(','), TERMINATOR(['\n', '\r\n']),MAXLENGTH(100000)));