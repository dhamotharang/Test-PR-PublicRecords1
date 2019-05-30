IMPORT $;

keyed_fields := RECORD
  $.layouts.i_did.LEX_ID;
END;

payload := RECORD
  $.layouts.i_did.DL_STATE;
	$.layouts.i_did.DL_ID;
END;

EXPORT key_DID(boolean isFCRA = true) := 
         INDEX ({keyed_fields}, {payload}, $.names().i_did_FCRA, OPT);