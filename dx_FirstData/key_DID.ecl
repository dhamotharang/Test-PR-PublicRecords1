IMPORT $;

keyed_fields := RECORD
  $.layouts.i_did.LEX_ID;
END;

payload := RECORD
  $.layouts.i_did.DL_STATE;
	$.layouts.i_did.DL_ID;
	$.layouts.i_did.PROCESS_DATE;
	$.layouts.i_did.DATE_FIRST_SEEN;
	$.layouts.i_did.DATE_LAST_SEEN;
END;

EXPORT key_DID() := 
         INDEX ({keyed_fields}, {payload}, $.names().i_did_FCRA);