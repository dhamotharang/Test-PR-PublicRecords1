import ut;

export File_oh_summit_barberton := dataset(ut.foreign_prod+'~thor_data400::in::crim_court::oh_summit_barberton', Layout_OH_Summit_Barberton,
            						         CSV(heading(1),SEPARATOR(['|','|\'']), quote(''), TERMINATOR(['\n','\r\n','\n\r'])));	
																				
																				
																				


// dataset(ut.foreign_prod+'~thor_data400::in::crim_court::tx::jefferson::offense_ref', Layout_TX_Jefferson.layout_offense_ref,
            						 // CSV(SEPARATOR(','), TERMINATOR(['\n','\r\n','\n\r']), QUOTE('"')));	