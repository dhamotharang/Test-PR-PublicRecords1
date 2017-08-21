import ut;
EXPORT File_Full := 
	dataset(ut.foreign_dataland + 'thor::in::gong::targus::full',layout_neustar,
																													CSV(
					//																									HEADING(1)
																															SEPARATOR('|')
																														, TERMINATOR(['\n', '\r\n'])
					//																									, QUOTE(['\"'])
																														, MAXLENGTH(50000)
																														)
																											)(add_date<'20140401');