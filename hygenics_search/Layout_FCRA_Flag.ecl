export Layout_FCRA_Flag := record
	string20	FlagFileID; 
	string12	DID;
	string20	FileID;
	string55	RecordID;
	string200	RecordID_1;
	string1		OverrideFlag;
	string1		InDisputeFlag;
	string1		ConsumerStatementFlag;
	string30	FName;
	string30	MName;
	string30	LName;
	string10	Name_Suffix;
	string9		SSN;
	string8		DOB;
	string20    riskwise_uid;
    string30    user_added;
    string8     date_added;
    string1     known_missing;
    string30    user_changed;
    string8     date_changed;
	string1		LF;
end;