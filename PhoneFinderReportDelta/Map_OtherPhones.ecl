IMPORT dx_PhoneFinderReportDelta;

EXPORT Map_OtherPhones(string8 version) := FUNCTION

	inFile 			:= distribute(PhoneFinderReportDelta.File_PhoneFinder.OtherPhones_Raw);
	
	//DF-23251: Add 'dx_' Prefix to Index Definitions
	//DF-23286: Update Keys
	dx_PhoneFinderReportDelta.Layout_PhoneFinder.OtherPhones_Main trOPh(inFile l):= transform
		self.date_file_loaded := version;
		self.risk_indicator		:= PhoneFinderReportDelta._Functions.rmNull(l.risk_indicator);
		self.phone_type				:= PhoneFinderReportDelta._Functions.rmNull(l.phone_type);
		self.phone_status			:= PhoneFinderReportDelta._Functions.rmNull(l.phone_status);
		self.listing_name			:= PhoneFinderReportDelta._Functions.rmNull(l.listing_name);
		self.porting_code			:= PhoneFinderReportDelta._Functions.rmNull(l.porting_code);
		self.phone_forwarded	:= PhoneFinderReportDelta._Functions.rmNull(l.phone_forwarded);
		self.date_added				:= PhoneFinderReportDelta._Functions.keepNum(l.date_added)[1..8];
		self.time_added				:= PhoneFinderReportDelta._Functions.keepNum(l.date_added)[9..];
		self 									:= l;
	end;
	
	mapOPhMain 	:= project(inFile, trOPh(left));
	concatFile	:= mapOPhMain + PhoneFinderReportDelta.File_PhoneFinder.OtherPhones_Main;	//DF-23286	
	ddConcat 		:= dedup(sort(distribute(concatFile, hash(transaction_id)), transaction_id, sequence_number, -(date_added+time_added), local), transaction_id, sequence_number, local);
	
	return ddConcat; 

END;