EXPORT File_DailyUpdates := 
	dataset('~thor::in::gong::targus::daily',layout_neustar,
																													CSV(
					//																									HEADING(1)
																															SEPARATOR('|')
																														, TERMINATOR(['\n', '\r\n'])
					//																									, QUOTE(['\"'])
																														, MAXLENGTH(2500)
																														)
																											);