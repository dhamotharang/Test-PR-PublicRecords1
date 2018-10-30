<<<<<<< Updated upstream
﻿IMPORT dx_PhoneFinderReportDelta, std;
=======
﻿IMPORT dx_PhoneFinderReportDelta;
>>>>>>> Stashed changes

EXPORT Map_Transactions(string8 version) := FUNCTION
	
	inFile 					:= distribute(PhoneFinderReportDelta.File_PhoneFinder.Transactions_Raw);
	
	//DF-23251: Add 'dx_' Prefix to Index Definitions
	//DF-23286: Update Keys
	dx_PhoneFinderReportDelta.Layout_PhoneFinder.Transactions_Main trT(inFile l):= transform
		self.date_file_loaded 				:= version;
		self.transaction_date					:= if(Std.Date.IsValidDate((unsigned)(PhoneFinderReportDelta._Functions.keepNum(l.transaction_date)[1..8])),
																				PhoneFinderReportDelta._Functions.keepNum(l.transaction_date)[1..8],
																				'');
		self.transaction_time					:= PhoneFinderReportDelta._Functions.keepNum(l.transaction_date)[9..];
		self.user_id									:= PhoneFinderReportDelta._Functions.keepAlphNum(l.user_id);
		self.product_code							:= PhoneFinderReportDelta._Functions.rmNull(l.product_code);
		self.company_id								:= PhoneFinderReportDelta._Functions.rmNull(l.company_id);
		self.source_code							:= PhoneFinderReportDelta._Functions.rmNull(l.source_code);
		self.batch_job_id							:= PhoneFinderReportDelta._Functions.rmNull(l.batch_job_id);
		self.reference_code						:= PhoneFinderReportDelta._Functions.rmNull(l.reference_code);
		self.phonefinder_type					:= PhoneFinderReportDelta._Functions.rmNull(l.phonefinder_type);
		self.submitted_lexid					:= (unsigned)l.submitted_lexid;
		self.submitted_phonenumber		:= PhoneFinderReportDelta._Functions.rmNull(l.submitted_phonenumber);
		self.submitted_firstname			:= PhoneFinderReportDelta._Functions.rmNull(l.submitted_firstname);
		self.submitted_lastname				:= PhoneFinderReportDelta._Functions.rmNull(l.submitted_lastname);
		self.submitted_middlename			:= PhoneFinderReportDelta._Functions.rmNull(l.submitted_middlename);
		self.submitted_streetaddress1	:= PhoneFinderReportDelta._Functions.rmNull(l.submitted_streetaddress1);
		self.submitted_city						:= PhoneFinderReportDelta._Functions.rmNull(l.submitted_city);
		self.submitted_state					:= PhoneFinderReportDelta._Functions.rmNull(l.submitted_state);
		self.submitted_zip						:= PhoneFinderReportDelta._Functions.rmNull(l.submitted_zip);
		self.orig_phonenumber					:= PhoneFinderReportDelta._Functions.rmNull(l.phonenumber);	
		self.phonenumber							:= PhoneFinderReportDelta._Functions.keepNum(l.phonenumber); //Filtered Phonenumber
		self.risk_indicator						:= PhoneFinderReportDelta._Functions.rmNull(l.risk_indicator);
		self.phone_type								:= PhoneFinderReportDelta._Functions.rmNull(l.phone_type);
		self.phone_status							:= PhoneFinderReportDelta._Functions.rmNull(l.phone_status);		
		self.last_ported_date					:= PhoneFinderReportDelta._Functions.keepNum(l.last_ported_date)[1..8];
		self.last_ported_time					:= PhoneFinderReportDelta._Functions.keepNum(l.last_ported_date)[9..];	
		self.last_otp_date						:= PhoneFinderReportDelta._Functions.keepNum(l.last_otp_date)[1..8];	
		self.last_otp_time						:= PhoneFinderReportDelta._Functions.keepNum(l.last_otp_date)[9..];
		self.last_spoof_date					:= PhoneFinderReportDelta._Functions.keepNum(l.last_spoof_date)[1..8];	
	  self.last_spoof_time					:= PhoneFinderReportDelta._Functions.keepNum(l.last_spoof_date)[9..];	
		self.phone_forwarded					:= PhoneFinderReportDelta._Functions.rmNull(l.phone_forwarded);
		self.date_added								:= PhoneFinderReportDelta._Functions.keepNum(l.date_added)[1..8];
		self.time_added								:= PhoneFinderReportDelta._Functions.keepNum(l.date_added)[9..];
		self 													:= l;
	end;
	
	mapTranMain 		:= project(inFile, trT(left));
	concatFile			:= mapTranMain + PhoneFinderReportDelta.File_PhoneFinder.Transactions_Main;		//DF-23286
	ddConcat 				:= dedup(sort(distribute(concatFile, hash(transaction_id)), transaction_id, company_id, -(date_added+time_added), local), transaction_id, company_id, local);
	
	return ddConcat;  
	
END;