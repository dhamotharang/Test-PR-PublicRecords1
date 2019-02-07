IMPORT $;

keyed_fields := RECORD
  $.layouts.i_hhid.hhid_relat;
  $.layouts.i_hhid.ver;
END;

EXPORT key_hhid_did (integer data_category = 0) := 
         INDEX (keyed_fields, {$.layouts.i_hhid.did}, $.names().i_hhid_did, OPT); //TODO: OPT?
