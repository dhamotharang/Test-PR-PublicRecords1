IMPORT ut;

EXPORT contact_address_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

cr := doxie_cbrs.contact_records(bdids);
outrec := doxie_cbrs.layout_contact_address;
addrs := PROJECT(cr, outrec);

addrs_ddp := DEDUP(addrs(prim_name <> ''), prim_range, prim_name, sec_range, zip, ALL);
ut.MAC_Sequence_Records(addrs_ddp, address_id, addrs_wid)

RETURN addrs_wid;
END;
