IMPORT dx_PhoneFinderReportDelta, Std;

EXPORT Map_Identities(string8 version) := FUNCTION

	inFile 			:= distribute(PhoneFinderReportDelta.File_PhoneFinder.Identities_Raw);
	
	//DF-23251: Add 'dx_' Prefix to Index Definitions & Add Additional Filters to Identities File
	//DF-23286: Update Keys
	dx_PhoneFinderReportDelta.Layout_PhoneFinder.Identities_Main trId(inFile l):= transform
		self.date_file_loaded := version;
<<<<<<< Updated upstream
		self.lexid						:= (unsigned)l.lexid;
=======
>>>>>>> Stashed changes
		self.full_name				:= Std.Str.FindReplace(PhoneFinderReportDelta._Functions.rmNull(l.full_name), '\\', '');//DF-23251
		self.full_address			:= PhoneFinderReportDelta._Functions.rmNull(l.full_address);
		self.city							:= PhoneFinderReportDelta._Functions.rmNull(l.city);
		self.state						:= PhoneFinderReportDelta._Functions.rmNull(l.state);
		self.zip							:= PhoneFinderReportDelta._Functions.rmNull(l.zip); //DF-23251
		self.date_added				:= PhoneFinderReportDelta._Functions.keepNum(l.date_added)[1..8];
		self.time_added				:= PhoneFinderReportDelta._Functions.keepNum(l.date_added)[9..];
		self 									:= l;
	end;
	
	mapIdMain 	:= project(inFile, trId(left));
	concatFile	:= mapIdMain + PhoneFinderReportDelta.File_PhoneFinder.Identities_Main;//DF-23286
	ddConcat 		:= dedup(sort(distribute(concatFile, hash(transaction_id)), transaction_id, sequence_number, -(date_added+time_added), local), transaction_id, sequence_number, local);
	
	return ddConcat; 

END;