IMPORT $;

keyed_fields := RECORD
  $.layouts.i_did.LEX_ID;
END;

payload := RECORD
  $.layouts.i_did.DL_STATE;
	$.layouts.i_did.DL_ID;
	$.layouts.i_did.PROCESS_DATE;
	$.layouts.i_did.FIRST_SEEN_DATE_TRUE;
	$.layouts.i_did.LAST_SEEN_DATE;
END;

EXPORT key_DID() := 
         INDEX ({keyed_fields}, {payload}, $.names().i_did_FCRA, OPT);