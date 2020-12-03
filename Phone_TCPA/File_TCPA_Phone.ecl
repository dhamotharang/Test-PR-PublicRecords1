EXPORT File_TCPA_Phone := MODULE

	//Raw Files
	EXPORT In_Wireless_to_Wireline 							:= dataset('~thor_data400::in::phones::tcpa_wireless-to-wireline', 				Phone_TCPA.Layout_TCPA.Daily, 					csv(heading(single), terminator('\n'), separator('|')));
	EXPORT In_Wireless_to_Wireline_NoRange			:= dataset('~thor_data400::in::phones::tcpa_wireless-to-wireline-norange',Phone_TCPA.Layout_TCPA.Daily_NoRange, 	csv(heading(single), terminator('\n'), separator('|')));
	EXPORT In_Wireline_to_Wireless							:= dataset('~thor_data400::in::phones::tcpa_wireline-to-wireless', 				Phone_TCPA.Layout_TCPA.Daily, 					csv(heading(single), terminator('\n'), separator('|')));
	EXPORT In_Wireline_to_Wireless_NoRange			:= dataset('~thor_data400::in::phones::tcpa_wireline-to-wireless-norange',Phone_TCPA.Layout_TCPA.Daily_NoRange, 	csv(heading(single), terminator('\n'), separator('|')));
	
	//History Files
	EXPORT Wireless_to_Wireline_History					:= dataset('~thor_data400::in::phones::tcpa_wireless-to-wireline_history', 				Phone_TCPA.Layout_TCPA.History, flat);
	EXPORT Wireless_to_Wireline_NoRange_History	:= dataset('~thor_data400::in::phones::tcpa_wireless-to-wireline-norange_history',Phone_TCPA.Layout_TCPA.History_NoRange, flat);
	EXPORT Wireline_to_Wireless_History					:= dataset('~thor_data400::in::phones::tcpa_wireline-to-wireless_history', 				Phone_TCPA.Layout_TCPA.History, flat);
	EXPORT Wireline_to_Wireless_NoRange_History	:= dataset('~thor_data400::in::phones::tcpa_wireline-to-wireless-norange_history',Phone_TCPA.Layout_TCPA.History_NoRange, flat); 
	
	//Base File	
	EXPORT Main																	:= dataset('~thor_data400::base::phones::tcpa_main', Phone_TCPA.Layout_TCPA.Main, flat); 
	
END;