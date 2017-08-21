import ut;
export File_In_TX_Collin_Defendant := 
	dataset('~thor_data400::in::civil_court::tx::collin_defendant',
	Civ_Court.Layout_TX_Collin_Party,csv(heading(1),terminator('\n'), separator(',')));
