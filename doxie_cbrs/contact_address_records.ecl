import ut;

export contact_address_records(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

cr := doxie_cbrs.contact_records(bdids);
outrec := doxie_cbrs.layout_contact_address;
addrs := project(cr, outrec);

addrs_ddp := dedup(addrs(prim_name <> ''), prim_range, prim_name, sec_range, zip, all);
ut.MAC_Sequence_Records(addrs_ddp, address_id, addrs_wid)

return addrs_wid;
END;