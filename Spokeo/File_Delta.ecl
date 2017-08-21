lfn := '~thor::spokeo::delta';
EXPORT File_Delta := DATASET(lfn, spokeo.Layout_delta,
																			CSV(
																						SEPARATOR('|')
																					, TERMINATOR(['\n', '\r\n'])
																			)
															);					