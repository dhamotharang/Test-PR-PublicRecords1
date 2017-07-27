import bankruptcyv2_services,doxie,doxie_cbrs;
export bkV2_raw(
    dataset(Doxie.layout_references) dids = doxie_raw.ds_EmptyDIDs,
    dataset(Doxie.Layout_ref_bdid) bdids = doxie_raw.ds_EmptyBDIDs,
		dataset(bankruptcyv2_services.layout_tmsid_ext) tmsids = dataset([],bankruptcyv2_services.layout_tmsid_ext),
    unsigned3 dateVal = 0,
    string6 ssn_mask_value = 'NONE',
		string1 in_party_type = ''
) := FUNCTION

//***** GATHER TMSIDS BY INPUTS
d := bankruptcyv2_services.bankruptcy_raw().report_view(
	in_dids := dids,
	in_bdids := project(bdids,doxie_cbrs.layout_references),
	in_tmsids := tmsids,
	in_ssn_mask := ssn_mask_value,
	in_party_type := in_party_type);

return d(dateVal = 0 OR (unsigned3)(date_filed[1..6]) <= dateVal);

END;