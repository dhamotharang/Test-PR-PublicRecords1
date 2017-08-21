lfn := '~thor_data400::in::cortera::20170131::attributes';
root := '~thor::cortera::in::';

EXPORT File_Attributes_In(string8 version) := dataset(root + 'bugatti_stats_' + version + '_output.dat',
																					cortera.Layout_Attributes, CSV(
																								SEPARATOR('|')
																							, TERMINATOR(['\n', '\r\n'])
																							, HEADING(1)
																							, MAXLENGTH(8192)
																							)
																				);
