IMPORT suppress;

doxie_cbrs.mac_Selection_Declare()

EXPORT contact_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

pre_mask := doxie_cbrs.contact_records_raw(bdids);
doxie_cbrs.mac_mask_ssn(pre_mask, msk1, ssn)

RETURN msk1;

END;
