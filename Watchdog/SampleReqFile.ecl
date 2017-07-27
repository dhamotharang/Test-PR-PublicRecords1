SampleReqFormat := RECORD
	UNSIGNED6 WID;
	STRING8 FirstTrackDate;
	STRING8 MostRcntTrackDate;
	STRING8 TrackUptoDate;
	BOOLEAN newName;
	BOOLEAN changeName;
	BOOLEAN newAddress;
	BOOLEAN changeAddress;
	BOOLEAN newSSN;
	BOOLEAN changeSSN;
	BOOLEAN deathStatus;
	BOOLEAN newPhone;
	BOOLEAN changePhone;
	BOOLEAN firstNameOnly;
	BOOLEAN firstAddressOnly;
	BOOLEAN firstSSNOnly;
	BOOLEAN firstPhoneOnly;
END;

export SampleReqFile := DATASET( [{1,'20030318','20030510','20030514',
								   false,true,false,true,false,
								   true,false,false,true,false,
								   false,false,false}],SampleReqFormat);