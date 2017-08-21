//lfn := '~thor::spokeo::out::201701';
lfn := '~thor::spokeo::out::201701a';
EXPORT File_Spokeo_Out := DATASET(lfn, Spokeo.Layout_Out, 
																						CSV(
																								SEPARATOR('|')
																							, TERMINATOR(['\n', '\r\n'])
																							)
													);