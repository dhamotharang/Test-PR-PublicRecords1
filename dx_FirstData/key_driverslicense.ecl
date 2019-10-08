﻿IMPORT $;

keyed_fields := RECORD
  $.layouts.i_driverslicense.DL_STATE;
	$.layouts.i_driverslicense.DL_ID;
END;

payload := RECORD
  $.layouts.i_driverslicense.PROCESS_DATE;
	$.layouts.i_driverslicense.FILEDATE;
	$.layouts.i_driverslicense.RECORD_TYPE;
	$.layouts.i_driverslicense.ACTION_CODE;
	$.layouts.i_driverslicense.CONS_ID;
	$.layouts.i_driverslicense.LEX_ID;
	$.layouts.i_driverslicense.FIRST_SEEN_DATE_TRUE;
	$.layouts.i_driverslicense.LAST_SEEN_DATE;
	$.layouts.i_driverslicense.DISPUTE_STATUS;
END;

EXPORT key_driverslicense := INDEX ({keyed_fields}, {payload}, $.names().i_driverslicense, OPT);