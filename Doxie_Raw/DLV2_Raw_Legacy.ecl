// NOTE: This mimics the behavior and output format of Doxie_Raw.DL_Raw

import DriversV2_Services,doxie,doxie_cbrs,DriversV2;

l_results := doxie.layout_dlsearch;

export dataset(l_results) DLV2_Raw_Legacy(
    dataset(Doxie.layout_references) dids = doxie_raw.ds_EmptyDIDs,
		string24 dl_value = ''
) := function

	dl_num	:= if( dl_value<>'', dataset([{dl_value}], DriversV2_Services.layouts.num) );
	seq_dl	:= DriversV2_Services.DLRaw.get_seq_from_num(dl_num);
	seq_did	:= DriversV2_Services.DLRaw.get_seq_from_dids(dids);
	seqs		:= dedup(seq_did+seq_dl, all);
	raw			:= DriversV2_Services.DLRaw.wide_view.by_seq(seqs);

	dmv := raw(source_code not in DriversV2.Constants.nonDMVSources);
	non_dmv := raw(source_code in DriversV2.Constants.nonDMVSources);
	raw_s := sort(dmv, penalt, -lic_issue_date, -expiration_date, record ) &
					 sort(non_dmv, penalt, -dt_last_seen, record);

	// slim to final output format (preserving sort)
	l_results tra(raw_s L) := transform
		self.license_type := L.moxie_license_type;
		self := L;
	end;
	final_fmt	:= project(raw_s, tra(left));

	return final_fmt;

end;