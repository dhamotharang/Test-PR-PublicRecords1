//lfn := '~thor::spokeo::out::201701';
lfn := '~thor::spokeo::out::201709';
EXPORT File_Spokeo_Out := DATASET(lfn, Spokeo.Layout_Out, 
																						CSV(
																								SEPARATOR('|')
																							, TERMINATOR(['\n', '\r\n'])
																							)
													);