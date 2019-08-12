IMPORT $;

keyed_fields := RECORD
  $.layouts.i_hhid.did;
  $.layouts.i_hhid.ver;
END;

payload := RECORD
  $.layouts.i_hhid.hhid;
  $.layouts.i_hhid.hhid_indiv;
  $.layouts.i_hhid.hhid_relat;
END;

EXPORT key_did_hhid (integer data_category = 0) := 
         INDEX (keyed_fields, payload, $.names().i_did_hhid, OPT); //TODO: OPT?
