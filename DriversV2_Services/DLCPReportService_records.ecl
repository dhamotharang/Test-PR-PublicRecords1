IMPORT doxie;

// abbreviations
l_dl := DriversV2_Services.layouts.result_wide;
l_dl_tmp := DriversV2_Services.layouts.result_wide_tmp;
l_rolled := DriversV2_Services.layouts.result_rolled;

l_conviction := DriversV2_Services.layouts.cp.conviction;
l_suspension := DriversV2_Services.layouts.cp.suspension;
l_drinfo := DriversV2_Services.layouts.cp.drinfo;
l_accident := DriversV2_Services.layouts.cp.accident;
l_insurance := DriversV2_Services.layouts.cp.insurance;

k_conviction := DriversV2_Services.layouts.key_conviction;
k_suspension := DriversV2_Services.layouts.key_suspension;
k_drinfo := DriversV2_Services.layouts.key_drinfo;
k_accident := DriversV2_Services.layouts.key_accident;
k_insurance := DriversV2_Services.layouts.key_insurance;


// First generate the standard DLCP report...

// lookup by DID
dids := DATASET([{input.did}], doxie.layout_references);
by_did := IF(input.did > 0, DLRaw.get_seq_from_dids(dids));

// lookup by DL_Number
nums := DATASET([{input.dl_num}], layouts.num);
by_num := IF(input.dl_num <> '', DLRaw.get_seq_from_num(nums));

// lookup by seq
by_seq := IF(input.dl_seq > 0, DATASET([{input.dl_seq}], layouts.seq));

// assimilate all seqs
seqs := DEDUP( MAP(
  input.dl_seq<>0 => by_seq,
  input.dl_num<>'' => by_num,
  input.did<>0 => by_did
), ALL);

// generate simple DL report
dl_recs := DLRaw.wide_view.by_seq(seqs);

// rollup by DLCP_key and add CP data to results
dl_rolled := DLRaw.wideToDLCP(dl_recs);

// that's all folks
EXPORT DLCPReportService_records := dl_rolled;
