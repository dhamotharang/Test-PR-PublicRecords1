import doxie, UCCv2_Services;

doxie.MAC_Header_Field_Declare();

ds_rmsid := dataset([{'', rmsid_value}], UCCv2_Services.layout_rmsid);
by_rmsid := UCCv2_Services.UCCRaw.get_tmsids_from_rmsids(ds_rmsid);

ds_tmsid := dataset([{tmsid_value}], UCCv2_Services.layout_tmsid);
by_tmsid := UCCv2_Services.UCCRaw.get_rmsids_from_tmsids(ds_tmsid);

export get_msids := map(
	tmsid_value<>'' and rmsid_value<>'' => dedup(by_tmsid(rmsid=rmsid_value), all),
	tmsid_value<>''											=> dedup(by_tmsid, all),
	rmsid_value<>''											=> dedup(by_rmsid, all),
	dataset([], UCCv2_Services.layout_rmsid)
);
