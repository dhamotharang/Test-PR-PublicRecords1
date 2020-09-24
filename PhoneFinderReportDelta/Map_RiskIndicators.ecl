﻿IMPORT dx_PhoneFinderReportDelta;

EXPORT Map_RiskIndicators(string8 version) := FUNCTION

	inFile 					:= distribute(PhoneFinderReportDelta.File_PhoneFinder.RiskIndicators_Raw);
	
	//DF-23251: Add 'dx_' Prefix to Index Definitions
	//DF-23286: Update Keys
	dx_PhoneFinderReportDelta.Layout_PhoneFinder.RiskIndicators_Main trRInd(inFile l):= transform
		self.date_file_loaded 				:= version;
		self.date_added								:= PhoneFinderReportDelta._Functions.keepNum(l.date_added)[1..8];
		self.time_added								:= PhoneFinderReportDelta._Functions.keepNum(l.date_added)[9..];
		self.risk_indicator_level			:= PhoneFinderReportDelta._Functions.rmNull(l.risk_indicator_level);
		self.risk_indicator_text			:= stringlib.stringtouppercase(l.risk_indicator_text);
		self.risk_indicator_category 	:= PhoneFinderReportDelta._Functions.keepAlph(l.risk_indicator_category);
		self 													:= l;
	end;
	
	mapRiskIndMain 	:= project(inFile, trRInd(left));
	concatFile			:= mapRiskIndMain + PhoneFinderReportDelta.File_PhoneFinder.RiskIndicators_Main;//DF-23286
	//DF-27859 keep the earliest records for delta update changes
	ddConcat 				:= dedup(sort(distribute(concatFile, hash(transaction_id)), transaction_id, sequence_number, phone_id, date_file_loaded,date_added,time_added, local), transaction_id, sequence_number, phone_id, local);

	return ddConcat;  

END;