import DriversV2_Services,doxie,doxie_cbrs;

l_rolled			:= DriversV2_Services.layouts.result_rolled;

emptySnums := dataset([], DriversV2_Services.layouts.snum);
empty_dl_src := dataset([], DriversV2_Services.layouts.src);

export dataset(l_rolled) DLV2_Raw(
    dataset(Doxie.layout_references) dids = doxie_raw.ds_EmptyDIDs,
		dataset(DriversV2_Services.layouts.snum) snums = emptySnums,
		dataset(DriversV2_Services.layouts.src) dl_src=empty_dl_src,
    unsigned1 dppa_purpose = 0,
    string6 ssn_mask_value = 'NONE'
) := function

	// generate simple DL report by DID
	raw_byDid := DriversV2_Services.DLRaw.wide_view.by_did(dids);

	// generate simple DL report by Seq
	raw_bySnum := DriversV2_Services.DLRaw.wide_view.by_snum(snums);

	// generate simple DL report from source rec
	raw_bySrc := DriversV2_Services.DLRaw.wide_view.by_src(dl_src);

	// rollup by DLCP_key and add CP data to results
	dl_rolled := DriversV2_Services.DLRaw.wideToDLCP(raw_byDid + raw_bySnum + raw_bySrc, true);
	
	return dl_rolled;

end;