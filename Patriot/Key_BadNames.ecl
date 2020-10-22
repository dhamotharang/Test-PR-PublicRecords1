// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
// $.key_badnames_delta_rid
// ---------------------------------------------------------------
import doxie;

rec := $.keytype_badnames;
keyed_fields := RECORD
    rec.fname;
    rec.mname;
    rec.lname;
    rec.cnt;
END; 
export Key_BadNames := index(keyed_fields,{rec - keyed_fields},'~thor_data400::key::annotated_names_' + doxie.Version_SuperKey);