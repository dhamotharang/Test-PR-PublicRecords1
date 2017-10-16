
//lfn := '~thor::in::spokeo::sample::ln_sample_3k.csv';
//lfn := '~thor::spokeo::in::spokeo_input_201705';
lfn := '~thor::spokeo::in::spokeo_input_201709';

EXPORT File_Spokeo_In := dataset(lfn, Spokeo.Layout_in,
																						CSV(
																								SEPARATOR('|')
																							, TERMINATOR(['\n', '\r\n'])
																							, MAXLENGTH(512)
																							)
																				);
