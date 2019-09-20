IMPORT data_services, _Control;
IMPORT $;
#IF(_Control.Environment.onVault) IMPORT vault; #END;

keyed_fields := RECORD
  $.layouts.i_hhid.hhid_relat;
  $.layouts.i_hhid.ver;
END;

EXPORT key_hhid_did (integer data_category = 0) := 
#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
    vault.dx_header.key_hhid_did(data_category);
#ELSE
    INDEX (keyed_fields, {$.layouts.i_hhid.did}, $.names().i_hhid_did, OPT); //TODO: OPT?
#END;
