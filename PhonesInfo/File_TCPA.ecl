//TCPA File - Reflects Ported Carrier Changes

IMPORT Data_Services, dx_PhonesInfo;

//DF-23525: Phones Metadata - Split Key into Transaction & Phone Type
//DF-24397: Create Dx-Prefixed Keys

EXPORT File_TCPA := MODULE

	EXPORT Daily_Raw_Wireless_to_Wireline 				:= distribute(dataset('~thor_data400::in::phones::wireless_to_wireline::tcpa_daily', PhonesInfo.Layout_TCPA.Daily, flat));
	EXPORT Daily_Raw_Wireline_to_Wireless 				:= distribute(dataset('~thor_data400::in::phones::wireline_to_wireless::tcpa_daily', PhonesInfo.Layout_TCPA.Daily, flat));

	EXPORT Daily_History_Raw_Wireless_to_Wireline := dataset('~thor_data400::in::phones::wireless_to_wireline::tcpa_daily_history_father', PhonesInfo.Layout_TCPA.History, flat);
	EXPORT Daily_History_Raw_Wireline_to_Wireless := dataset('~thor_data400::in::phones::wireline_to_wireless::tcpa_daily_history_father', PhonesInfo.Layout_TCPA.History, flat);

	EXPORT Historical_Raw_Wireless_to_Wireline 		:= dataset('~thor_data400::in::phones::wireless_to_wireline::tcpa_historical', PhonesInfo.Layout_TCPA.Historical, csv(heading(1), separator('\t'), terminator('\r\n')));
	EXPORT Historical_Raw_Wireline_to_Wireless 		:= dataset('~thor_data400::in::phones::wireline_to_wireless::tcpa_historical', PhonesInfo.Layout_TCPA.Historical, csv(heading(1), separator('\t'), terminator('\r\n')));	
	EXPORT Historical_Main 												:= dataset('~thor_data400::in::phones::tcpa_historical_main', 								 PhonesInfo.Layout_TCPA.Main, flat);
	
	EXPORT Main 																	:= dataset('~thor_data400::base::phones::nport_main', 			dx_PhonesInfo.Layouts.Phones_Transaction_Main, flat);  //Phone Transaction Key (DF-23525)
	EXPORT Main_Current 													:= dataset('~thor_data400::base::phones::tcpa_main', 				PhonesInfo.Layout_TCPA.Main, flat);
	EXPORT Main_Previous													:= dataset('~thor_data400::base::phones::tcpa_main_father', PhonesInfo.Layout_TCPA.Main, flat);

END;