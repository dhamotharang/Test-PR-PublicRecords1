//iConectiv File - Reflects Ported Phone Type Changes
IMPORT Data_services, dx_PhonesInfo, Ut;

//DF-23525: Phones Metadata - Split Key into Transaction & Phone Type
//DF-24397: Create Dx-Prefixed Keys
//DF-28224: Add iConectiv PortData Validate Data

EXPORT File_iConectiv := module

	//iConectiv Port - Historical Unrestricted File
	EXPORT Main															:= dataset('~thor_data400::base::phones::icport_main', 											dx_PhonesInfo.Layouts.Phones_Transaction_Main, 							flat);				//Phone Transaction Key (DF-23525)
	EXPORT Main_Current 										:= dataset('~thor_data400::base::phones::iconectiv_main', 									PhonesInfo.Layout_iConectiv.Main, 													flat);
	EXPORT Main_Previous										:= dataset('~thor_data400::base::phones::iconectiv_main_father', 						PhonesInfo.Layout_iConectiv.Main, 													flat);

	EXPORT In_Port_Daily 										:= dataset('~thor_data400::in::phones::iconectiv_daily', 										PhonesInfo.Layout_iConectiv.Daily, 													csv(terminator('\n'), separator(',')));
	EXPORT In_Port_Daily_History 						:= dataset('~thor_data400::in::phones::iconectiv_daily_history', 						PhonesInfo.Layout_iConectiv.History, 												flat);
	EXPORT In_Port_Daily_History_Translated := dataset('~thor_data400::in::phones::iconectiv_daily_history_trans',			PhonesInfo.Layout_iConectiv.Intermediate_Temp, 							flat); 				//Translated Historical iConectiv Records from SPID-to-OCN 

	//iConectiv Port - PortData Validate File
	EXPORT Main_PortData_Valid							:= dataset('~thor_data400::base::phones::portdata_valid_main',							PhonesInfo.Layout_iConectiv.Phones_Transaction_Main_PDV,		flat);				//File Feeds into PhoneTranaction / PhoneType
	EXPORT Main_PortData_Validate						:= dataset('~thor_data400::base::phones::portdata_validate_main', 					PhonesInfo.Layout_iConectiv.Main_PortData_Validate, 				flat);				//File Feeds into PhonesMetadata 					
	EXPORT Main_PortData_Validate_Prev			:= dataset('~thor_data400::base::phones::portdata_validate_main_father', 		PhonesInfo.Layout_iConectiv.Main_PortData_Validate, 				flat);  			//File Feeds into PhonesMetadata
	
	EXPORT PortData_Validate_Daily 					:= dataset('~thor_data400::in::phones::portdata_validate_daily', 						PhonesInfo.Layout_iConectiv.PortData_Validate_In, 					csv(heading(0), terminator(['}']), separator(''), quote('"')));	
	EXPORT PortData_Validate_History 				:= dataset('~thor_data400::in::phones::portdata_validate_history', 					PhonesInfo.Layout_iConectiv.PortData_Validate_History, 			flat);		
	EXPORT PortData_Validate_Historical 		:= dataset('~thor_data400::in::phones::portdata_validate_historical', 			PhonesInfo.Layout_iConectiv.PortData_Validate_Historical, 	flat);	
	EXPORT PortData_Validate_Historical_Prep:= dataset('~thor_data400::in::phones::portdata_validate_historical_prep', 	PhonesInfo.Layout_iConectiv.Intermediate_PortData_Validate, flat);	

end;