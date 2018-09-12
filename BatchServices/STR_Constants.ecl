import AutoKeyI, ut, std;

export STR_Constants := 
MODULE
	EXPORT Defaults := MODULE
		EXPORT UNSIGNED1 DPPAPURPOSE          := 0;
		EXPORT UNSIGNED1 GLBPURPOSE           := 0;
		EXPORT UNSIGNED1 PENALT_THRESHOLD     := 10;
		EXPORT STRING6   SSN_MASK             := 'NONE';
		EXPORT INTEGER   MAXCURR_RESIDENTS    := 20;
		EXPORT INTEGER   MAXPRIOR_RESIDENTS   := 50;
		EXPORT INTEGER   MAXRESULTS_PER_ACCT  := 50;
		EXPORT INTEGER	 NAME_MATCH_THRESHOLD := 2; // 0-100%, 1-90%, 2-80%	
		EXPORT UNSIGNED2 SHORT_TERM_THRESHOLD := 180; // days
		EXPORT INTEGER 	 THRESHOLD_FOR_CURRENT_RESIDENCY := (Std.Date.Today() DIV 100 - 100); // 1 year 
	END;

	EXPORT HitFlags := MODULE
		EXPORT string2 OWNER          := 'O';
		EXPORT string2 OWNER_OCCUPIED := 'OO';
		EXPORT string2 PREVIOUS_OWNER := 'PO';
		EXPORT string2 LONG_TERM      := 'LT';
		EXPORT string2 SHORT_TERM     := 'ST';
		EXPORT string2 NO_HIT         := 'NO';	
	END;	
	
	EXPORT SplitFlags := MODULE
		EXPORT string3 OWNER_OCCUPIED := 'OO';
		EXPORT string3 LONG_TERM      := 'LT';
		EXPORT string3 SHORT_TERM     := 'ST';
		EXPORT string3 UNKNOWN        := 'UD';
		EXPORT string3 NO_HIT         := 'NO';
		EXPORT string3 REJECT         := 'REJ';
	END;		
	
	EXPORT Limits := MODULE
		EXPORT UNSIGNED2 MAX_RECORDS_KEEP := 2000;
		EXPORT UNSIGNED2 JOIN_LIMIT       := 10000;
		EXPORT UNSIGNED1 MAX_OWNERS_KEEP  := 10;
		// used in doxie.header_records_byDID as the ReturnLimit value
		// we had to higher this value for STR from 20k to 50k to enable all the resident data processing
		EXPORT UNSIGNED  MAX_interHdrRecs := 50000;
	END;
	
	EXPORT ErrorCodes := MODULE
		EXPORT NO_ERROR           := 0;																 
		EXPORT TOO_MANY_MATCHES   := AutoKeyI.errorcodes._codes.TOO_MANY_SUBJECTS;
		EXPORT INSUFFICIENT_INPUT := AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT;
		EXPORT MISSING_SEC_RANGE  := 299; 
	END;
END;