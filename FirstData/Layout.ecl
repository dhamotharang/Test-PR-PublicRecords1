﻿EXPORT LAYOUT := MODULE

EXPORT RAW := RECORD
  STRING1 RECORD_TYPE;
  STRING1 ACTION_CODE;
  STRING9 CONS_ID;
  STRING2 DL_STATE;
  STRING50 DL_ID;
  STRING8 FIRST_SEEN_DATE_TRUE;
  STRING8 LAST_SEEN_DATE;
  STRING1 DISPUTE_STATUS;
  STRING15 LEX_ID;
END;

EXPORT BASE := RECORD
  STRING8			PROCESS_DATE;
	STRING8     FILEDATE;
 RAW;
END;

END;