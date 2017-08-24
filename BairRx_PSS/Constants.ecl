
EXPORT Constants := MODULE

	EXPORT DEFAULT_LEAD_THRESHOLD := 10;
	EXPORT DEFAULT_MAX_IDS := 50;

	EXPORT RecordType := MODULE
		EXPORT CFS_CALLER_ADDR 								:= 1;
		EXPORT CFS_COMPLAINANT_ADDR          	:= 2;
		EXPORT CFS_INCIDENT_ADDR              := 3;
		EXPORT EVE_MO_ADDRESS_OF_CRIME     		:= 4;
		EXPORT EVE_MO_ADDRESS              		:= 5;
		EXPORT EVE_PERSONS_PERSON_ADDRESS			:= 6;
		EXPORT EVE_PERSONS_ADDRESS     				:= 7;
		EXPORT EVE_VEHICLE_VEHICLE_ADDRESS 		:= 8;
		EXPORT EVE_VEHICLE_ADDRESS         		:= 9;
		EXPORT OFFENDERS                     	:= 10;
		EXPORT CRASH 	                        := 11;
		EXPORT LICENSE_PLATES 								:= 12;
		EXPORT CRASH_PERSON 									:= 13;
		EXPORT CRASH_VEHICLE 									:= 14;
	END;
	EXPORT RecordTypeLabel(integer c) := MAP(
		c = RecordType.CFS_CALLER_ADDR => 'CFS CALLER ADDR',
		c = RecordType.CFS_COMPLAINANT_ADDR => 'CFS COMPL ADDR',
		c = RecordType.CFS_INCIDENT_ADDR => 'CFS INCIDENT ADDR',
		c = RecordType.EVE_MO_ADDRESS_OF_CRIME => 'EVENT ADDR OF CRIME',
		c = RecordType.EVE_MO_ADDRESS => 'EVENT ADDR',
		c = RecordType.EVE_PERSONS_PERSON_ADDRESS => 'PERSON ADDR',
		c = RecordType.EVE_PERSONS_ADDRESS => 'PERSON ADDRESS',
		c = RecordType.EVE_VEHICLE_VEHICLE_ADDRESS => 'VEHICLE ADDR',
		c = RecordType.EVE_VEHICLE_ADDRESS => 'VEHICLE ADDRESS',
		c = RecordType.OFFENDERS => 'OFFENDERS',
		c = RecordType.CRASH => 'CRASH',
		c = RecordType.CRASH_PERSON => 'CRASH PERSON',
		c = RecordType.CRASH_VEHICLE => 'CRASH VEHICLE',
		c = RecordType.LICENSE_PLATES => 'LICENSE_PLATES',
		''
		);
	EXPORT IsIncidentRecord(integer t) := t in [3,4,5,10,11,12];	
	EXPORT IsPersonalRecord(integer t) := t in [1,2,6,7,10,13];	
	EXPORT IsPhoneRecord(integer t) := t in [1,2];	
	EXPORT IsVehicleRecord(integer t) := t in [8,9,14];	
	EXPORT ScoreFields := ['NAME_SUFFIX','FNAME','MNAME','LNAME','PRIM_RANGE','PRIM_NAME','SEC_RANGE','P_CITY_NAME','ST','ZIP','DOB',
													'PHONE','DL_ST','DL','LEXID','POSSIBLE_SSN','CRIME','NAME_TYPE','CLEAN_GENDER','CLASS_CODE','DT_FIRST_SEEN',
													'DT_LAST_SEEN','VIN','PLATE','LATITUDE','LONGITUDE','MAINNAME','FULLNAME','Match_SEARCH_ADDR1','Match_SEARCH_ADDR2'];	
														
	EXPORT PhoneSource := MODULE
		EXPORT STRING1 INCIDENT 	:= 'I';
		EXPORT STRING1 NARRATIVE 	:= 'N';
	END;
													
END;