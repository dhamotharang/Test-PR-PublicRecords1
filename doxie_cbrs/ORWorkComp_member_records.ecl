
IMPORT govdata;

EXPORT ORWorkComp_member_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

indexedBDIDs := govdata.key_or_workers_comp_bdid;

indexedBDIDs xf_indexedBDIDs(indexedBDIDs r) := TRANSFORM
  SELF := r;
END;

RETURN JOIN(bdids, indexedBDIDs, KEYED(LEFT.bdid = RIGHT.bdid),
            xf_indexedBDIDs(RIGHT), LIMIT(10000, SKIP));
END;
