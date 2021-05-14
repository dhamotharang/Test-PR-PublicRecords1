IMPORT dx_PhoneFinderReportDelta, std;

EXPORT Map_Sources(string8 version) := FUNCTION
	
	inFile 					:= distribute(PhoneFinderReportDelta.File_PhoneFinder.Sources_Raw);
	
	dx_PhoneFinderReportDelta.Layout_PhoneFinder.Sources_Main trS(inFile l):= transform
		self.date_file_loaded 				:= version;
		self.phonenumber							:= PhoneFinderReportDelta._Functions.keepNum(l.phonenumber);
		self.lexid										:= (unsigned)l.lexid;
		self.source_type							:= PhoneFinderReportDelta._Functions.rmNull(l.source_type);
		self.category									:= PhoneFinderReportDelta._Functions.rmNull(l.category);
		self.date_added								:= PhoneFinderReportDelta._Functions.keepNum(l.date_added)[1..8];
		self.time_added								:= PhoneFinderReportDelta._Functions.keepNum(l.date_added)[9..];
		self 													:= l;
	end;
	
	mapSrcMain 			:= project(inFile, trS(left));
	concatFile			:= mapSrcMain + PhoneFinderReportDelta.File_PhoneFinder.Sources_Main;
	ddConcat 				:= dedup(sort(distribute(concatFile, hash(transaction_id)), transaction_id, sequence_number, phone_id, identity_id, date_file_loaded, date_added, time_added, local), transaction_id, sequence_number, phone_id, identity_id, local);
	
	return ddConcat;  
	
END;