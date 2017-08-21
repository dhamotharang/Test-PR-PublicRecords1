import ut;
export File_In_TX_Collin_Case := 
	dataset('~thor_data400::in::civil_court::tx::collin_case',
	Civ_Court.Layout_TX_Collin_Case,csv(heading(1),terminator('\n'), separator(',')));
