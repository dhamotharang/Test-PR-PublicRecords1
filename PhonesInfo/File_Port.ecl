Import dx_PhonesInfo;

EXPORT File_Port := module

	EXPORT In_Port_Daily 					:= dataset('~thor_data400::in::phones::port_daily', 								PhonesInfo.Layout_Port.Daily, 									csv(terminator('\n'), separator(',')));
	EXPORT In_Port_Daily_History 	:= dataset('~thor_data400::in::phones::port_daily_history', 				PhonesInfo.Layout_Port.History, 								flat);
	
end;