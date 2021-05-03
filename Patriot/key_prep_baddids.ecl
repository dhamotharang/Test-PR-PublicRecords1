//DF-28226
import dx_common;

ds := PROJECT($.baddies, $.KeyType_BadDids);
keyed_fields := RECORD
    ds.did;
    ds.other_count;
    ds.first_seen;
    ds.rel_count;
    ds.dummy;
END; 
export key_prep_baddids :=index(ds,keyed_fields,{ds},'~thor_data400::key::Baddids_' + thorlib.wuid());