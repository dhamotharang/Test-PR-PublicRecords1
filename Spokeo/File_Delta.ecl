//lfn := '~thor::spokeo::delta';
lfn := '~thor::spokeo::delta::2017JanAndMay';
EXPORT File_Delta := DATASET(lfn, spokeo.Layout_delta,
																			CSV(
																						SEPARATOR('|')
																					, TERMINATOR(['\n', '\r\n'])
																			)
															);					