import ut;

export File_In_TX_Harris := 

		dataset('~thor_200::in::civil::tx_harris',Civ_Court.Layout_In_TX_Harris 
																		  ,csv(heading(1),terminator('\n'), separator('|')));