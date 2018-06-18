EXPORT Map_RiskIndicators(string8 version) := FUNCTION

	inFile 					:= distribute(PhoneFinderReportDelta.File_PhoneFinder.RiskIndicators_Raw);
	
	Layout_PhoneFinder.RiskIndicators_Main trRInd(inFile l):= transform
		self.date_file_loaded 				:= version;
		self.date_added								:= PhoneFinderReportDelta._Functions.keepNum(l.date_added)[1..8];
		self.time_added								:= PhoneFinderReportDelta._Functions.keepNum(l.date_added)[9..];
		self.risk_indicator_level			:= PhoneFinderReportDelta._Functions.rmNull(l.risk_indicator_level);
		self.risk_indicator_text			:= stringlib.stringtouppercase(l.risk_indicator_text);
		self.risk_indicator_category 	:= PhoneFinderReportDelta._Functions.keepAlph(l.risk_indicator_category);
		self 													:= l;
	end;
	
	mapRiskIndMain 	:= project(inFile, trRInd(left));
	concatFile			:= mapRiskIndMain + PhoneFinderReportDelta.File_PhoneFinder.RiskIndicators_Main;	
	ddConcat 				:= dedup(sort(distribute(concatFile, hash(transaction_id)), transaction_id, sequence_number, -(date_added+time_added), local), transaction_id, sequence_number, local);

	return ddConcat;  

END;