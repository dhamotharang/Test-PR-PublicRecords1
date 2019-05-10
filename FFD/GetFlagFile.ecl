import doxie, FCRA, FFD;

// keeping this temporarily here...
DataGroupToFileID(STRING data_group) := CASE(data_group, 
		FFD.Constants.DataGroups.ACTIVITY => FCRA.FILE_ID.ACTIVITY,
		FFD.Constants.DataGroups.ADDRESS => FCRA.FILE_ID.ADDRESSES,
		FFD.Constants.DataGroups.ADVO => FCRA.FILE_ID.ADVO,
		FFD.Constants.DataGroups.AIRCRAFT => FCRA.FILE_ID.AIRCRAFT,
		FFD.Constants.DataGroups.AIRCRAFT_DETAILS => FCRA.FILE_ID.AIRCRAFT_DETAILS,
		FFD.Constants.DataGroups.AIRCRAFT_ENGINE => FCRA.FILE_ID.AIRCRAFT_ENGINE,
		FFD.Constants.DataGroups.ASSESSMENT => FCRA.FILE_ID.ASSESSMENT,
		FFD.Constants.DataGroups.ATF => FCRA.FILE_ID.ATF,
		FFD.Constants.DataGroups.AVM => FCRA.FILE_ID.AVM,
		FFD.Constants.DataGroups.AVM_MEDIANS => FCRA.FILE_ID.AVM_MEDIANS,
		FFD.Constants.DataGroups.BANKRUPTCY_SEARCH => FCRA.FILE_ID.BANKRUPTCY,
		FFD.Constants.DataGroups.BANKRUPTCY_MAIN => FCRA.FILE_ID.BANKRUPTCY,
		FFD.Constants.DataGroups.CCW => FCRA.FILE_ID.CCW,
		FFD.Constants.DataGroups.COURT_OFFENSES => FCRA.FILE_ID.COURT_OFFENSES,
		FFD.Constants.DataGroups.DEED => FCRA.FILE_ID.DEED,
		FFD.Constants.DataGroups.DID_DEATH => FCRA.FILE_ID.DID_DEATH,
		FFD.Constants.DataGroups.EMAIL_DATA => FCRA.FILE_ID.EMAIL_DATA,
		FFD.Constants.DataGroups.GONG => FCRA.FILE_ID.GONG,
		FFD.Constants.DataGroups.HDR => FCRA.FILE_ID.HDR,
		FFD.Constants.DataGroups.HUNTING_FISHING => FCRA.FILE_ID.HUNTING_FISHING,
		FFD.Constants.DataGroups.IBEHAVIOR_CONSUMER => FCRA.FILE_ID.IBEHAVIOR_CONSUMER,
		FFD.Constants.DataGroups.IBEHAVIOR_PURCHASE => FCRA.FILE_ID.IBEHAVIOR_PURCHASE,
		FFD.Constants.DataGroups.IMPULSE => FCRA.FILE_ID.IMPULSE,
		FFD.Constants.DataGroups.INFUTOR => FCRA.FILE_ID.INFUTOR,
		//FFD.Constants.DataGroups.INFUTORCID => FCRA.FILE_ID.INFUTORCID,  // no flag id for it
		FFD.Constants.DataGroups.INQUIRIES => FCRA.FILE_ID.INQUIRIES,
		FFD.Constants.DataGroups.LIEN_MAIN => FCRA.FILE_ID.LIEN,
		FFD.Constants.DataGroups.LIEN_PARTY => FCRA.FILE_ID.LIEN,
		FFD.Constants.DataGroups.MARI => FCRA.FILE_ID.MARI,
		FFD.Constants.DataGroups.MARRIAGE => FCRA.FILE_ID.MARRIAGE,
		FFD.Constants.DataGroups.MARRIAGE_SEARCH => FCRA.FILE_ID.MARRIAGE_SEARCH,
		FFD.Constants.DataGroups.OFFENDERS => FCRA.FILE_ID.OFFENDERS,
		FFD.Constants.DataGroups.OFFENDERS_PLUS => FCRA.FILE_ID.OFFENDERS_PLUS,
		FFD.Constants.DataGroups.OFFENSES => FCRA.FILE_ID.OFFENSES,
		FFD.Constants.DataGroups.PAW => FCRA.FILE_ID.PAW,
		FFD.Constants.DataGroups.PILOT_CERTIFICATE => FCRA.FILE_ID.PILOT_CERTIFICATE,
		FFD.Constants.DataGroups.PILOT_REGISTRATION => FCRA.FILE_ID.PILOT_REGISTRATION,
		FFD.Constants.DataGroups.PROFLIC => FCRA.FILE_ID.PROFLIC,
		FFD.Constants.DataGroups.PROPERTY => FCRA.FILE_ID.PROPERTY,
		FFD.Constants.DataGroups.PROPERTY_SEARCH => FCRA.FILE_ID.SEARCH,
		FFD.Constants.DataGroups.PUNISHMENT => FCRA.FILE_ID.PUNISHMENT,
		FFD.Constants.DataGroups.SO_MAIN => FCRA.FILE_ID.SO_MAIN,
		FFD.Constants.DataGroups.SO_OFFENSES => FCRA.FILE_ID.SO_OFFENSES,
		FFD.Constants.DataGroups.SSN => FCRA.FILE_ID.SSN,
		FFD.Constants.DataGroups.STUDENT => FCRA.FILE_ID.STUDENT,
		FFD.Constants.DataGroups.STUDENT_ALLOY => FCRA.FILE_ID.STUDENT_ALLOY,
		FFD.Constants.DataGroups.THRIVE => FCRA.FILE_ID.THRIVE,
		FFD.Constants.DataGroups.UCC => FCRA.FILE_ID.UCC,
		FFD.Constants.DataGroups.UCC_PARTY => FCRA.FILE_ID.UCC_PARTY,
		FFD.Constants.DataGroups.WATERCRAFT => FCRA.FILE_ID.WATERCRAFT,
		FFD.Constants.DataGroups.WATERCRAFT_COASTGUARD => FCRA.FILE_ID.WATERCRAFT_COASTGUARD,
		FFD.Constants.DataGroups.WATERCRAFT_DETAILS => FCRA.FILE_ID.WATERCRAFT_DETAILS,
		'');	

/*
	A function to merge flag file with suppressions coming from person context. 
*/
export GetFlagFile(dataset (doxie.layout_best) ds_best,
									 dataset(FFD.Layouts.PersonContextBatch) pc_recs = dataset([], FFD.Layouts.PersonContextBatch)) := 
function

	ds_file_flags := FCRA.GetFlagFile(ds_best);
	
	ds_pc_flags := project(pc_recs(recordtype=FFD.Constants.RecordType.SR), transform(fcra.Layout_override_flag,
		self.record_id := trim(left.RecId1)+trim(left.RecId2)+trim(left.RecId3)+trim(left.RecId4); // string100 enough?		
		self.file_id := DataGroupToFileID(left.datagroup);
		self.did := left.lexid;
		self.flag_file_id := ''; // need a new record type in person context for overrides; recid would be file_id (?)
		self := []
		));

	ds_flags := rollup(sort(ds_file_flags + ds_pc_flags, did, file_id, record_id),
		left.did = right.did and left.file_id = right.file_id and left.record_id = right.record_id,
		transform(fcra.Layout_override_flag,
			self.flag_file_id := if(left.flag_file_id <> '', left.flag_file_id, right.flag_file_id);
			self.override_flag := if(left.override_flag <> '', left.override_flag, right.override_flag);
			self.in_dispute_flag := if(left.in_dispute_flag <> '', left.in_dispute_flag, right.in_dispute_flag);
			self.consumer_statement_flag := if(left.consumer_statement_flag <> '', left.consumer_statement_flag, right.consumer_statement_flag);
			self.fname := if(left.fname <> '', left.fname, right.fname);
			self.mname := if(left.mname <> '', left.mname, right.mname);
			self.lname := if(left.lname <> '', left.lname, right.lname);
			self.name_suffix := if(left.name_suffix <> '', left.name_suffix, right.name_suffix);
			self.ssn := if(left.ssn <> '', left.ssn, right.ssn);
			self.dob := if(left.dob <> '', left.dob, right.dob);
			self := left
			));

	return if(exists(pc_recs), sort(ds_flags, flag_file_id, did, file_id, record_id), ds_file_flags);

end;