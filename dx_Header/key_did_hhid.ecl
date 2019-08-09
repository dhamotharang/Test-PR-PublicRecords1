IMPORT _control;
IMPORT $;
#IF(_Control.Environment.onVault) IMPORT vault; #END;


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
#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
    vault.dx_header.key_did_hhid(data_category);
#ELSE
    INDEX (keyed_fields, payload, $.names().i_did_hhid, OPT); //TODO: OPT?
#END;
