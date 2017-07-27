import doxie;

// lookup by DID
dids := dataset([{input.did}], doxie.layout_references);
by_did := DLRaw.get_seq_from_dids(dids);

// lookup by DL_Number
nums := dataset([{input.dl_num}], layouts.num);
by_num := DLRaw.get_seq_from_num(nums);

// lookup by seq
by_seq := dataset([{input.dl_seq}], layouts.seq);

// assimilate all seqs
seqs := dedup( map(
	input.dl_seq<>0		=> by_seq,
	input.dl_num<>''	=> by_num,
	input.did<>0			=> by_did
), all);

// generate the report
results := DLRaw.wide_view.by_seq(seqs);

// slim to final output format (preserving sort)
final_fmt	:= project(results, layouts.result_wide);
final_d		:= dedup(final_fmt, except dl_seq);

export DLReportService_records := final_d;