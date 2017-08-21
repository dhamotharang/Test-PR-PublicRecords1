export PhonesFeedback:= 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20090706';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export rthor_data400__key__phonesfeedback__phone	:=
record
	string10 phone_number;
	unsigned integer6 did;
	unsigned integer1 did_score;
	unsigned integer6 hhid;
	string login_history_id;
	string fname;
	string lname;
	string mname;
	string street_pre_direction;
	string street_post_direction;
	string street_number;
	string street_name;
	string street_suffix;
	string unit_number;
	string unit_designation;
	string zip5;
	string zip4;
	string city;
	string state;
	string alt_phone;
	string other_info;
	string phone_contact_type;
	string feedback_source;
	string date_time_added;
	string loginid;
	string customerid;
	unsigned integer8 __internal_fpos__;
end;

export dthor_data400__key__phonesfeedback__phone := dataset(lCSVFileNamePrefix + 'thor_data400__key__phonesfeedback__' + lCSVVersion + '__phone.csv', rthor_data400__key__phonesfeedback__phone, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;