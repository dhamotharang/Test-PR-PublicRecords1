EXPORT File_Full_Refresh := 
	dataset('~thor::in::gong::targus::full',layout_neustar,
																													CSV(
																															SEPARATOR('|')
																														, TERMINATOR(['\n', '\r\n'])
																														, MAXLENGTH(2500)
																														)
																											);