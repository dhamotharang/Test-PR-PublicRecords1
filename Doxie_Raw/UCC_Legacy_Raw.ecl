// This is a drop-in replacement for Doxie_Raw.UCC_Raw

// import uccd, ut, doxie_crs, business_header, doxie_cbrs, Doxie;
import doxie, UCCv2_Services, doxie_cbrs;

export UCC_Legacy_Raw(
	dataset(doxie.layout_references)	dids,
	dataset(doxie.Layout_ref_bdid)		bdids,
	unsigned3 dateVal = 0,
	unsigned1 dppa_purpose = 0,
	unsigned1 glb_purpose = 0,
	string6 ssn_mask_value = 'NONE',
	string		UCCKey = '',	// this is effectively orig_filing_number,
	string1 in_party_type = ''
) := FUNCTION

	by_did := UCCv2_Services.UCCRaw.get_tmsids_from_dids(dids,in_party_type);
	
	by_bdid := UCCv2_Services.UCCRaw.get_tmsids_from_bdids( project(bdids,doxie_cbrs.layout_references),, in_party_type );
	
	fileNum := if(UCCKey<>'', dataset([{UCCKey}], UCCv2_Services.layout_filing_number));
	by_uccKey := project(
		UCCv2_Services.UCCRaw.get_rmsids_from_Filing_Number(fileNum),
		UCCv2_Services.layout_tmsid
	);
	
	tmsids := dedup( by_did + by_bdid + by_uccKey, all, record );
	
	uccRecs := UCCv2_Services.UCCRaw.legacy_view.raw_by_tmsid(tmsids, ssn_mask_value);

	return(uccRecs);

END;