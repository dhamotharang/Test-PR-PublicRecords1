IMPORT dx_PhoneFinderReportDelta;

EXPORT File_PhoneFinder := MODULE

		export Identities_Raw					:= dataset('~thor_data400::in::phonefinderreportdelta::identities_daily', 			PhoneFinderReportDelta.Layout_PhoneFinder.Identities_Raw, csv(heading(1), terminator('\n'), separator('|\t|')));
		export OtherPhones_Raw				:= dataset('~thor_data400::in::phonefinderreportdelta::otherphones_daily', 			PhoneFinderReportDelta.Layout_PhoneFinder.OtherPhones_Raw, csv(heading(1), terminator('\n'), separator('|\t|')));	
		export RiskIndicators_Raw			:= dataset('~thor_data400::in::phonefinderreportdelta::riskindicators_daily', 	PhoneFinderReportDelta.Layout_PhoneFinder.RiskIndicators_Raw, csv(heading(1), terminator('\n'), separator('|\t|')));
		export Transactions_Raw 			:= dataset('~thor_data400::in::phonefinderreportdelta::transaction_daily', 			PhoneFinderReportDelta.Layout_PhoneFinder.Transactions_Raw, csv(heading(1), terminator('\n'), separator('|\t|')));
		export Sources_Raw 						:= dataset('~thor_data400::in::phonefinderreportdelta::sources_daily', 					PhoneFinderReportDelta.Layout_PhoneFinder.Sources_Raw, csv(heading(1), terminator('\n'), separator('|\t|')));
		
		export Identities_History			:= dataset('~thor_data400::in::phonefinderreportdelta::identities_history', 		PhoneFinderReportDelta.Layout_PhoneFinder.Identities_History, flat);
		export OtherPhones_History		:= dataset('~thor_data400::in::phonefinderreportdelta::otherphones_history', 		PhoneFinderReportDelta.Layout_PhoneFinder.OtherPhones_History, flat);
		export RiskIndicators_History	:= dataset('~thor_data400::in::phonefinderreportdelta::riskindicators_history', PhoneFinderReportDelta.Layout_PhoneFinder.RiskIndicators_History, flat);
		export Transactions_History		:= dataset('~thor_data400::in::phonefinderreportdelta::transactions_history', 	PhoneFinderReportDelta.Layout_PhoneFinder.Transactions_History, flat);
		export Sources_History				:= dataset('~thor_data400::in::phonefinderreportdelta::sources_history', 				PhoneFinderReportDelta.Layout_PhoneFinder.Sources_History, flat);

		//DF-23251: Add dx_ to Key Attributes
		export Identities_Main				:= dataset('~thor_data400::base::phonefinderreportdelta::identities', 					dx_PhoneFinderReportDelta.Layout_PhoneFinder.Identities_Main, flat);
		
		//DF-27818: Add "identity_count" field to OtherPhones & Transactions Base Files
		//DF-28194: Add "carrier" field to OtherPhones Base File
		export OtherPhones_Main				:= dataset('~thor_data400::base::phonefinderreportdelta::otherphones', 					PhoneFinderReportDelta.Layout_PhoneFinder.OtherPhones_Main_Temp, flat); 	//Placeholder for new field
		//export OtherPhones_Main			:= dataset('~thor_data400::base::phonefinderreportdelta::otherphones', 					dx_PhoneFinderReportDelta.Layout_PhoneFinder.OtherPhones_Main, flat);
		
		export RiskIndicators_Main		:= dataset('~thor_data400::base::phonefinderreportdelta::riskindicators', 			dx_PhoneFinderReportDelta.Layout_PhoneFinder.RiskIndicators_Main, flat);
		
		export Transactions_Main			:= dataset('~thor_data400::base::phonefinderreportdelta::transactions', 				PhoneFinderReportDelta.Layout_PhoneFinder.Transactions_Main_Temp, flat);	//Placeholder for new field
		//export Transactions_Main		:= dataset('~thor_data400::base::phonefinderreportdelta::transactions', 				dx_PhoneFinderReportDelta.Layout_PhoneFinder.Transactions_Main, flat);
		
		export Sources_Main						:= dataset('~thor_data400::base::phonefinderreportdelta::sources', 							dx_PhoneFinderReportDelta.Layout_PhoneFinder.Sources_Main, flat);

END;