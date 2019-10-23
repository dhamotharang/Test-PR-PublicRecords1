//iConectiv File - Reflects Ported Phone Type Changes

IMPORT Data_services, dx_PhonesInfo, Ut;

//DF-23525: Phones Metadata - Split Key into Transaction & Phone Type
//DF-24397: Create Dx-Prefixed Keys

EXPORT File_iConectiv := module

	EXPORT Main										:= dataset('~thor_data400::base::phones::icport_main', 								dx_PhonesInfo.Layouts.Phones_Transaction_Main, flat);						//Phone Transaction Key (DF-23525)
	EXPORT Main_Current 					:= dataset('~thor_data400::base::phones::iconectiv_main', 						PhonesInfo.Layout_iConectiv.Main, flat);
	EXPORT Main_Previous					:= dataset('~thor_data400::base::phones::iconectiv_main_father', 			PhonesInfo.Layout_iConectiv.Main, flat);

	EXPORT In_Port_Daily 					:= dataset('~thor_data400::in::phones::iconectiv_daily', 							PhonesInfo.Layout_iConectiv.Daily, csv(terminator('\n'), separator(',')));
	EXPORT In_Port_Daily_History 	:= dataset('~thor_data400::in::phones::iconectiv_daily_history', 			PhonesInfo.Layout_iConectiv.History, flat);

end;