IMPORT doxie;

// lookup by DID
dids := DATASET([{input.did}], doxie.layout_references);
by_did := DLRaw.get_seq_from_dids(dids);

// lookup by DL_Number
nums := DATASET([{input.dl_num}], layouts.num);
by_num := DLRaw.get_seq_from_num(nums);

// lookup by seq
by_seq := DATASET([{input.dl_seq}], layouts.seq);

// assimilate all seqs
seqs := DEDUP( MAP(
  input.dl_seq<>0 => by_seq,
  input.dl_num<>'' => by_num,
  input.did<>0 => by_did
), ALL);

// generate the report
results := DLRaw.wide_view.by_seq(seqs);

// slim to final output format (preserving sort)
final_fmt := PROJECT(results, layouts.result_wide);
final_d := DEDUP(final_fmt, EXCEPT dl_seq);

EXPORT DLReportService_records := final_d;
