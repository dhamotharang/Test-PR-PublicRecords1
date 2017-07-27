
import govdata;

export CASalesTax_member_records(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

indexedBDIDs := govdata.key_ca_sales_tax_bdid;

indexedBDIDs xf_indexedBDIDs(indexedBDIDs r) := TRANSFORM
	SELF := r;
END;

return JOIN(bdids, indexedBDIDs, KEYED(LEFT.bdid = RIGHT.bdid),
                   xf_indexedBDIDs(RIGHT), LIMIT(10000, SKIP));
END;