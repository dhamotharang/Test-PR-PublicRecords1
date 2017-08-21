//iConectiv File - Reflects Ported Phone Type Changes

import ut;

EXPORT File_iConectiv := module

	EXPORT Main_Current 					:= dataset('~thor_data400::base::phones::iconectiv_main', 				PhonesInfo.Layout_iConectiv.Main, flat);
	EXPORT Main_Previous					:= dataset('~thor_data400::base::phones::iconectiv_main_father', 	PhonesInfo.Layout_iConectiv.Main, flat);

	EXPORT In_Port_Daily 					:= dataset('~thor_data400::in::phones::iconectiv_daily', 					PhonesInfo.Layout_iConectiv.Daily, csv(terminator('\n'), separator(',')));
	EXPORT In_Port_Daily_History 	:= dataset('~thor_data400::in::phones::iconectiv_daily_history', 	PhonesInfo.Layout_iConectiv.History, flat);

end; 