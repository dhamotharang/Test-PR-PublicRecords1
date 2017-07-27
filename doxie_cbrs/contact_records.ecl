import suppress;

doxie_cbrs.mac_Selection_Declare()

export contact_records(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

pre_mask := doxie_cbrs.contact_records_raw(bdids);
doxie_cbrs.mac_mask_ssn(pre_mask, msk1, ssn)

return msk1;

END;
