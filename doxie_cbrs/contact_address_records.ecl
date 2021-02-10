IMPORT doxie_cbrs, ut;

EXPORT contact_address_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

cr := doxie_cbrs.contact_records(bdids);
addrs := PROJECT(cr, doxie_cbrs.layout_contact.address_rec);

addrs_ddp := DEDUP(addrs(prim_name <> ''), prim_range, prim_name, sec_range, zip, ALL);
ut.MAC_Sequence_Records(addrs_ddp, address_id, addrs_wid)

RETURN addrs_wid;
END;
