export SQL_Helpers :=
module
	import	Std, MySQL;
	
	/////////////////////////////////////////////////////////
	shared	lNACGroupIDRegex		:=	'([A-Z]{2})([0-9]{2})';
	shared	lRecordCodeRegex		:=	'([A-Z]{2})([0-9]{2})';
	shared	lNCF2FileNameRegex	:=	'ncf2_([a-z]{2})([0-9]{2})_([0-9]{8})_([0-9]{6})\\.dat';

	/////////////////////////////////////////////////////////
	shared	MySQLUser						:=	'web_dev';
	shared	MySQLServer					:=	'webmiscdev01.risk.regn.net';
	shared	MySQLDatabase				:=	'hhsc_reports';
	shared	MySQLPassword				:=	'ZB3eVLUx3oeMTkZ4';

	/////////////////////////////////////////////////////////
	// Returns uppercase NAC Group ID if a valid ID of two letters followed by two numbers.  Could add specific validation list later.
  // Will fail if invalid and second parameter is not explicitly set to false.
	export	string4	fValidNACGroupID(string pGroupID, boolean pFailIfInvalid = true)	:=
	function
		string		lUpperCase		:=	Std.Str.ToUpperCase(pGroupID);
		string		lTrimmed			:=	trim(lUpperCase);
		string		lReturnValue	:=	regexfind('^' + lNACGroupIDRegex + '$', lTrimmed, 0);		// Regexfind FLAG as 0 returns entire matching string
		assert(lReturnValue = lTrimmed or not pFailIfInvalid, '"' + pGroupID + '" is an invalid NAC Group ID', fail);
		return		(string4)lReturnValue;
	end;

	/////////////////////////////////////////////////////////
	// Returns lowercase NCF2 filename if a valid NCF2 filename provided.  Could add specific group validation list later.
  // Will fail if invalid and second parameter is not explicitly set to false.
	export	string30	fValidNCF2FileName(string pNCF2FileName, boolean pFailIfInvalid = true)	:=
	function
		string		lLowerCase		:=	Std.Str.ToLowerCase(pNCF2FileName);
		string		lTrimmed			:=	trim(lLowerCase);
		string		lReturnValue	:=	regexfind('^' + lNCF2FileNameRegex + '$', lTrimmed, 0);	// Regexfind FLAG as 0 returns entire matching string
		assert(lReturnValue = lTrimmed or not pFailIfInvalid, '"' + pNCF2FileName + '" is an invalid ncf2 filename', fail);
		return		(string30)lReturnValue;
	end;

	/////////////////////////////////////////////////////////
	// Returns lowercase NCF2 filename extracted from a Thor-based NCF2 filename, such as "nac::uber::in::ncf2_la01_20191230_234800.dat" or similar.
	// Expects to find "ncf2_<group>_<date8>_<time6>.dat" in the filename.  Does not fail if not found, but will return nothing if regexfind fails.
	export	string30	fNCF2FileNameFromThorNCF2Filename(string pThorNCF2FileName)	:=
	function
		string		lLowerCase		:=	Std.Str.ToLowerCase(pThorNCF2FileName);
		string		lTrimmed			:=	trim(lLowerCase);
		string		lReturnValue	:=	regexfind(lNCF2FileNameRegex, lTrimmed, 0);							// Regexfind FLAG as 0 returns entire matching string
		return		(string30)lReturnValue;
	end;

	/////////////////////////////////////////////////////////
	// Returns uppercase Record Code if a valid ID of two letters followed by two numbers.  Could add specific validation list later.
  // Will fail if invalid and second parameter is not explicitly set to false.
	export	string4	fValidRecordCode(string pRecordCode, boolean pFailIfInvalid = true)	:=	
	function
		string		lUpperCase		:=	Std.Str.ToUpperCase(pRecordCode);
		string		lTrimmed			:=	trim(lUpperCase);
		string		lReturnValue	:=	regexfind('^' + lRecordCodeRegex + '$', lTrimmed, 0);		// Regexfind FLAG as 0 returns entire matching string
		assert(lReturnValue = lTrimmed or not pFailIfInvalid, '"' + pRecordCode + '" is an invalid Record Code', fail);
		return		(string4)lReturnValue;
	end;

	/////////////////////////////////////////////////////////
	// Returns valid YYYY-MM-DD string for date field for MySQL insert.
  // Will fail if an invalid date and second parameter is not explicitly set to false.
	export	string10	fValidSQLDate(string pDateString, boolean pFailIfInvalid = true)	:=	
	function
		unsigned8	lDateValue		:=	(unsigned8)trim(pDateString);
		string8		lDateString		:=	if(Std.Date.IsValidDate(lDateValue), intformat(lDateValue, 8, 1), '');
		string		lReturnValue	:=	if(lDateString <> '', lDateString[1..4] + '-' + lDateString[5..6] + '-' + lDateString[7..8], '');
		assert(lReturnValue <> '' or not pFailIfInvalid, '"' + pDateString + '" is an invalid date string', fail);
		return		(string10)lReturnValue;
	end;

	/////////////////////////////////////////////////////////
	// Returns true if date string passed resolves to Monday-Friday.  Invalid date will also result in false.  May pursue holidays later.
	export	boolean	fIsWorkingDay(string pDateString)	:=
	function
		unsigned8	lDateValue		:=	(unsigned8)trim(pDateString);
		boolean		lReturnValue	:=	Std.Date.DayOfWeek(lDateValue) between 2 and 6;
		return		lReturnValue;
	end;


	/////////////////////////////////////////////////////////
	export	dataset(NAC_V2.SQL_Layouts.ContributedFileMetadataSQL) fGetNCF2MetadataFromTable(string pFileName)	:=
	embed(mysql :	User(MySQLUser),
								Server(MySQLServer),
								Database(MySQLDatabase),
								Password(MySQLPassword)
						// id, date_added, file_name, program_code, activity_date, working_day, nac_group_id, orig_nac_group_id, record_code, accepted_records_count, rejected_records_count
			 )
					select 
						file_name, program_code, activity_date, working_day, nac_group_id, orig_nac_group_id, record_code, accepted_records_count, rejected_records_count
						from contributed_files_metadata where file_name=?;
	endembed;

	/////////////////////////////////////////////////////////
	export	dataset(NAC_V2.SQL_Layouts.NCF2FileMetadata) fGetMissingNCF2MetadataFromTable(string pFileName, dataset(NAC_V2.SQL_Layouts.NCF2FileMetadata) pAddCandidates)	:=
	function
		dFoundRecords		:=	fGetNCF2MetadataFromTable(pFileName);
		dMissingRecords	:=	join(pAddCandidates, dFoundRecords,
														 left.program_code = right.program_code
												 and left.record_code = right.record_code,
														 transform(NAC_V2.SQL_Layouts.NCF2FileMetadata, self := left),
														 left only
														);
		return dMissingRecords;
	end;

	/////////////////////////////////////////////////////////
	// Inserts records into the contributed_files_metadata table based upon NCF2 contribution.
	// Returns true if all records added successfully
	export	fAddNCF2MetadataToTable(string pNCF2Filename, string8 pActivityDate = (string8)Std.Date.Today(), dataset(NAC_V2.SQL_Layouts.NCF2FileMetadata) pDataset)	:=
	function

		// Avoid adding duplicates, allow this to be run again adding only missing records, etc.
		dRecordsNotYetInserted		:=	fGetMissingNCF2MetadataFromTable(fValidNCF2FileName(pNCF2FileName), pDataset);

		string30	lNCF2FileName		:=	fValidNCF2FileName(pNCF2Filename);
		string10	lActivityDate		:=	fValidSQLDate(pActivityDate);
		boolean		lIsWorkingDay		:=	fIsWorkingDay(pActivityDate);
		string4		lNACGroupID			:=	fValidNACGroupID(lNCF2Filename[6..9]);
		
		NAC_V2.SQL_Layouts.ContributedFileMetadataSQL	tPrepForMySQLInsert(NAC_V2.SQL_Layouts.NCF2FileMetadata pInput)	:=
		transform
			self.file_name									:=	lNCF2FileName;
			self.program_code								:=	pInput.program_code;
			self.activity_date							:=	lActivityDate;
			self.working_day								:=	lIsWorkingDay;
			self.nac_group_id								:=	lNACGroupID;
			self.orig_nac_group_id					:=	lNACGroupID;
			self.record_code								:=	pInput.record_code;
			self.accepted_records_count			:=	pInput.accepted_records_count;
			self.rejected_records_count			:=	pInput.rejected_records_count;
		end;
		dPrepForMySQLInsert	:=	project(dRecordsNotYetInserted, tPrepForMySQLInsert(left));

		fInsertNCF2(dataset(NAC_V2.SQL_Layouts.ContributedFileMetadataSQL) pValues) :=
		embed(mysql :	User(MySQLUser),
									Server(MySQLServer),
									Database(MySQLDatabase),
									Password(MySQLPassword)
				 )
						insert into contributed_files_metadata 
									 (file_name, program_code, activity_date, working_day, nac_group_id, orig_nac_group_id, record_code, accepted_records_count, rejected_records_count)
									 values (?, ?, ?, ?, ?, ?, ?, ?, ?);
		endembed;

		return	fInsertNCF2(dPrepForMySQLInsert);
	end;

end;
