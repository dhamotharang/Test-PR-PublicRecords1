export SQL_Layouts :=
module

	/*
	CREATE TABLE `contributed_files_metadata` (
	 `id` int(11) NOT NULL AUTO_INCREMENT,
	 `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	 `file_name` varchar(255) NOT NULL,
	 `program_code` char(1) NOT NULL DEFAULT '',
	 `activity_date` date NOT NULL,
	 `working_day` tinyint(1) DEFAULT NULL,
	 `nac_group_id` char(4) NOT NULL,
	 `orig_nac_group_id` char(4) NOT NULL,
	 `record_code` char(4) NOT NULL,
	 `accepted_records_count` int(11) DEFAULT NULL,
	 `rejected_records_count` int(11) DEFAULT NULL,
	 PRIMARY KEY (`id`,`date_added`),
	 UNIQUE KEY uq_1 (`nac_group_id`,`file_name`,`program_code`,`record_code`),
	 KEY ix_activity_date (`activity_date`),
	 KEY ix_nac_group_id (`nac_group_id`,`activity_date`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;

	CREATE TABLE `match_details_date` (
	 `id` int(11) NOT NULL AUTO_INCREMENT,
	 `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	 `activity_date` date` NOT NULL,
	 `is_working_day` tinyint(1) DEFAULT NULL,
	 `left_group_id` char(4)` NOT NULL,
	 `left_orig_group_id` char(4) NOT NULL,
	 `left_state` char(2) NOT NULL,
	 `left_activity_type` char(1) NOT NULL,
	 `is_online` tinyint(1) DEFAULT NULL,
	 `left_program_code` char(1) NOT NULL,
	 `right_group_id` char(4) NOT NULL,
	 `right_orig_group_id` char(4) NOT NULL,
	 `right_state` char(2) NOT NULL,
	 `right_eligibility_status` char(1) NOT NULL,
	 `is_lexid_used` tinyint(1) DEFAULT NULL,
	 `base_match_codes` char(10) NOT NULL,
	 `actual_match_codes` char(10) NOT NULL,
	 `exception_reason_code` char(1) NOT NULL,
	 `count` int(11) NOT NULL DEFAULT 0,
	 PRIMARY KEY (`id`,`date_added`),
	 UNIQUE KEY uq_1 (`activity_date`,`left_group_id`,`left_activity_type`,`is_online`,`left_program_code`,`right_group_id`,`right_eligibility_status`,`lexid_used`,`base_match_codes`,`actual_match_codes`,`exception_reason_code`),
	 KEY ix_activity_date (`activity_date`),
	 KEY ix_left_group_id (`left_group_id`,`activity_date`),
	 KEY ix_right_group_id (`right_group_id`,`activity_date`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;

	CREATE TABLE `no_match_details_date` (
	 `id` int(11) NOT NULL AUTO_INCREMENT,
	 `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	 `activity_date date NOT NULL,
	 `is_working_day` tinyint(1) DEFAULT NULL,
	 `left_group_id` char(4) NOT NULL,
	 `left_orig_group_id` char(4) NOT NULL,
	 `left_state` char(2) NOT NULL,
	 `left_activity_type` char(1) NOT NULL,
	 `is_online` tinyint(1) DEFAULT NULL,
	 `left_program_code` char(1) NOT NULL,
	 `query_status_code` int(11) NOT NULL DEFAULT 0,
	 `count` int(11) NOT NULL DEFAULT 0,
	 PRIMARY KEY (`id`,`date_added`),
	 UNIQUE KEY uq_1 (`activity_date`,`left_group_id`,`left_activity_type`,`is_online`,`left_program_code`),
	 KEY ix_activity_date (`activity_date`),
	 KEY ix_left_group_id (`left_group_id`,`activity_date`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	*/

	export	NCF2FileMetadata	:=
	record
		// integer8	id;													//	auto-incremented serial value provided for us by DB
		// string19	date_added;									//	auto-calculated date/time value provided for us by DB
		// string30	file_name;									//	not part of record yet
		string1		program_code;									//	uppercase program code
		// string8		activity_date;						//	not part of record yet
		// boolean		working_day := false;			//	we'll calculate this based upon activity_date
		// string4		nac_group_id;									//	uppercase group ID, will be validated as AA99 using [A-Z]{2}[0-9]{2}
		// string4		orig_nac_group_id;				//	we'll ensure the insert contains the same value for both
		string4		record_code;									//	uppercase record code, for now validated in list of valid codes
		unsigned4	accepted_records_count := 0;	//	number of accepted records by file/group/program/record
		unsigned4	rejected_records_count := 0;	//	number of rejected records by file/group/program/record
	end;

	export	ContributedFileMetadataSQL	:=
	record
		// integer8	id;													//	auto-incremented serial value provided for us by DB
		// string19	date_added;									//	auto-calculated date/time value provided for us by DB
		string30	file_name;										//	lowercase ncf2 filename, e.g. ncf2_la01_20191219_080102.dat, validated to format
		string1		program_code;									//	uppercase program code
		string10	activity_date;								//	YYYY-MM-DD
		boolean		working_day := false;					//	intended to be true if M-F, will be calculated for you
		string4		nac_group_id;									//	uppercase group ID, will be validated as AA99 using [A-Z]{2}[0-9]{2}
		string4		orig_nac_group_id;						//	uppercase group ID, for inserts validated to be same as nac_group_id
		string4		record_code;									//	uppercase record code, for now validated in list of valid codes
		unsigned4	accepted_records_count := 0;	//	number of accepted records by file/group/program/record
		unsigned4	rejected_records_count := 0;	//	number of rejected records by file/group/program/record
	end;


end;