IMPORT dx_PhoneFinderReportDelta;

//DF-23251: Add 'dx_' Prefix to Index Definitions

EXPORT File_PhoneFinder := MODULE

		export Identities_Main				:= dataset('~thor_data400::base::phonefinderreportdelta::identities', 					dx_PhoneFinderReportDelta.Layout_PhoneFinder.Identities_Main, flat);
		export OtherPhones_Main				:= dataset('~thor_data400::base::phonefinderreportdelta::otherphones', 					dx_PhoneFinderReportDelta.Layout_PhoneFinder.OtherPhones_Main, flat);
		export RiskIndicators_Main		:= dataset('~thor_data400::base::phonefinderreportdelta::riskindicators', 			dx_PhoneFinderReportDelta.Layout_PhoneFinder.RiskIndicators_Main, flat);
		export Transactions_Main			:= dataset('~thor_data400::base::phonefinderreportdelta::transactions', 				dx_PhoneFinderReportDelta.Layout_PhoneFinder.Transactions_Main, flat);
		
END;