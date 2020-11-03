// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
// $.key_baddids_delta_rid
// ---------------------------------------------------------------
import doxie;

// export Key_Baddids := index(baddies,keytype_baddids,'~thor_data400::key::Baddids_' + doxie.Version_SuperKey);
rec := $.keytype_baddids;
keyed_fields := RECORD
    rec.did;
    rec.other_count;
    rec.first_seen;
    rec.rel_count;
    rec.dummy;
END;    

export Key_Baddids := index(keyed_fields,{rec - keyed_fields},'~thor_data400::key::Baddids_' + doxie.Version_SuperKey);