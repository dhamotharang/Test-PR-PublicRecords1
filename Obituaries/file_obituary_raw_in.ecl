EXPORT file_obituary_raw_in := DATASET('~thor_data400::in::obituarydata_raw', Obituaries.layouts.Obituary_raw_in,
																						CSV(heading(single), separator('|')/*,terminator(['\r\n\f'])*/
																						,quote('\"')
																));