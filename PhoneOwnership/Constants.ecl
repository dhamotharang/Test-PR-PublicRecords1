﻿EXPORT Constants := MODULE
	EXPORT SearchLevel := ENUM(BASIC = 0,PREMIUM = 1,ULTIMATE = 2); 
	EXPORT STRING LIDB := 'LIDB;'; 
	EXPORT STRING CNAM := 'CNAM;'; 
	EXPORT LNMatch := MODULE
		EXPORT STRING1 INVALID := 'I'; //created for internal use - to consistently use a single character - will be outputted as INV
		EXPORT STRING1 NONE := 'O';    //created for internal use - to consistently use a single character - will be outputted as NON
		EXPORT STRING1 NAME := 'N';
		EXPORT STRING1 LEXID := 'L';
		EXPORT STRING1 RELATIVE := 'R';
		EXPORT STRING1 EMPLOYER := 'E';
		EXPORT STRING1 ADDRESS := 'A';
		EXPORT STRING1 PHONE := 'P';
		EXPORT STRING1 CELL := 'C';
		EXPORT STRING1 BUSINESS := 'B';
		EXPORT STRING1 NON_CELL_CONSUMER := 'D';
		EXPORT STRING3 RELATION := LEXID + RELATIVE + EMPLOYER;
		EXPORT STRING COMPLETE := 'NAPCBD' + RELATION; //Name,Address,Phone,Cell,Non-cell Business,non-cell comsumer,LexID,Relative/Associate,Employer/Business
	END;	
	
	EXPORT UseCaseValues := ['OTPCFD','IdentityFraud','TCPA','GeoLocation'];
	EXPORT Ownership := MODULE
		EXPORT STRING INVALID := 'Invalid';
		EXPORT STRING LOW := 'Low';
		EXPORT STRING UNDETERMINED := 'Undetermined';		
		EXPORT STRING MEDIUM := 'Medium';
		EXPORT STRING MEDIUM_HIGH := 'Medium High';
		EXPORT STRING HIGH := 'High';	
		EXPORT enumIndex := ENUM(INVALID=0,LOW,UNDETERMINED,MEDIUM,MEDIUM_HIGH,HIGH);	
	END;		
	EXPORT Relationship := MODULE
		EXPORT STRING EMPLOYER := 'Possible Employer';
		EXPORT STRING BUSINESS := 'Possible Business Affliation';
		EXPORT STRING SUBJECT  := 'Possible Subject';
		EXPORT STRING RELATIVE := 'Possible Relative';
		EXPORT STRING INVALID  := 'Number Invalid';
	END;	
	EXPORT DisconnectStatus := MODULE
		EXPORT STRING DISCONNECTED := 'POSSIBLE DISCONNECT';
		EXPORT STRING UNDETERMINED := 'POSSIBLE DISCONNECT/PORTING';
		EXPORT STRING UNKNOWN := '';
	END;	
	EXPORT REASON_CODES := MODULE
		EXPORT STRING MATCH := '1,';
		EXPORT STRING NO_MATCH := '2,';
		EXPORT STRING NO_IDENTITY := '3,';
		EXPORT STRING INVALID_NUMBER := '4';//will be a standalone reason.
		EXPORT STRING DISCONNECTED := '5,';
	END;		
	
	EXPORT STRING BAD_NUMBER := 'lidb: bad querynumber;'; //ATT LIDB error
	EXPORT UNSIGNED1 MAX_RelativeDept := 2;
	EXPORT UNSIGNED1 MAXCOUNT_Relative := 9;
	EXPORT UNSIGNED1 MAXCOUNT_Employer := 2;
	EXPORT UNSIGNED1 MAXCOUNT_Business := 2;
	EXPORT UNSIGNED  MAX_RECORDS := 10000;
	// Debug
	EXPORT Debug :=
	MODULE
		EXPORT Main := FALSE;
		EXPORT REAB := FALSE;
	END;

END;