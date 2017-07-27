import UCCv2_Services, doxie, doxie_cbrs;

export UCC_Legacy_Records (dataset (doxie.layout_references) dids, string6 ssn_mask='NONE', string1 in_party_type = '') := function

  // this is V1 version; V2 doesn't have BDID-method, and it that it is redundant here as well.
	bdids := dataset ([], doxie_cbrs.layout_references);

  return UCCv2_Services.UCCRaw.legacy_view.by_both_ids(dids, bdids, ssn_mask, in_party_type);

end;

