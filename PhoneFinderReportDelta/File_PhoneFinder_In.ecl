IMPORT dx_PhoneFinderReportDelta;

EXPORT File_PhoneFinder_In := MODULE

		export Identities_Raw					:= dataset('~thor_data400::in::phonefinderreportdelta::identities_daily', 			dx_PhoneFinderReportDelta.Layout_PhoneFinder.Identities_Raw, csv(heading(1), terminator('\n'), separator('|\t|')));
		export OtherPhones_Raw				:= dataset('~thor_data400::in::phonefinderreportdelta::otherphones_daily', 			dx_PhoneFinderReportDelta.Layout_PhoneFinder.OtherPhones_Raw, csv(heading(1), terminator('\n'), separator('|\t|')));	
		export RiskIndicators_Raw			:= dataset('~thor_data400::in::phonefinderreportdelta::riskindicators_daily', 	dx_PhoneFinderReportDelta.Layout_PhoneFinder.RiskIndicators_Raw, csv(heading(1), terminator('\n'), separator('|\t|')));
		export Transactions_Raw 			:= dataset('~thor_data400::in::phonefinderreportdelta::transaction_daily', 			dx_PhoneFinderReportDelta.Layout_PhoneFinder.Transactions_Raw, csv(heading(1), terminator('\n'), separator('|\t|')));
		
		export Identities_History			:= dataset('~thor_data400::in::phonefinderreportdelta::identities_history', 		dx_PhoneFinderReportDelta.Layout_PhoneFinder.Identities_History, flat);
		export OtherPhones_History		:= dataset('~thor_data400::in::phonefinderreportdelta::otherphones_history', 		dx_PhoneFinderReportDelta.Layout_PhoneFinder.OtherPhones_History, flat);
		export RiskIndicators_History	:= dataset('~thor_data400::in::phonefinderreportdelta::riskindicators_history', dx_PhoneFinderReportDelta.Layout_PhoneFinder.RiskIndicators_History, flat);
		export Transactions_History		:= dataset('~thor_data400::in::phonefinderreportdelta::transactions_history', 	dx_PhoneFinderReportDelta.Layout_PhoneFinder.Transactions_History, flat);

END;
		