IMPORT DeltabaseGateway;

EXPORT Map_Identities(string8 version) := FUNCTION

	inFile 			:= distribute(PhoneFinderReportDelta.File_PhoneFinder.Identities_Raw);
	
	Layout_PhoneFinder.Identities_Main trId(inFile l):= transform
		self.date_file_loaded := version;
		self.full_name				:= PhoneFinderReportDelta._Functions.rmNull(l.full_name);
		self.full_address			:= PhoneFinderReportDelta._Functions.rmNull(l.full_address);
		self.city							:= PhoneFinderReportDelta._Functions.rmNull(l.city);
		self.state						:= PhoneFinderReportDelta._Functions.rmNull(l.state);
		self.date_added				:= PhoneFinderReportDelta._Functions.keepNum(l.date_added)[1..8];
		self.time_added				:= PhoneFinderReportDelta._Functions.keepNum(l.date_added)[9..];
		self 									:= l;
	end;
	
	mapIdMain 	:= project(inFile, trId(left));
	concatFile	:= mapIdMain + PhoneFinderReportDelta.File_PhoneFinder.Identities_Main;	
	ddConcat 		:= dedup(sort(distribute(concatFile, hash(transaction_id)), transaction_id, sequence_number, -(date_added+time_added), local), transaction_id, sequence_number, local);
	
	return ddConcat; 

END;