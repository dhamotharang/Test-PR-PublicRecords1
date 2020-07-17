IMPORT doxie, UCCv2_Services;

doxie.MAC_Header_Field_Declare();

ds_rmsid := DATASET([{'', rmsid_value}], UCCv2_Services.layout_rmsid);
by_rmsid := UCCv2_Services.UCCRaw.get_tmsids_from_rmsids(ds_rmsid);

ds_tmsid := DATASET([{tmsid_value}], UCCv2_Services.layout_tmsid);
by_tmsid := UCCv2_Services.UCCRaw.get_rmsids_from_tmsids(ds_tmsid);

EXPORT get_msids := MAP(
  tmsid_value<>'' AND rmsid_value<>'' => DEDUP(by_tmsid(rmsid=rmsid_value), all),
  tmsid_value<>'' => DEDUP(by_tmsid, all),
  rmsid_value<>'' => DEDUP(by_rmsid, all),
  DATASET([], UCCv2_Services.layout_rmsid)
);
