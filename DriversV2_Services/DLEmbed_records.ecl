// NOTE: This is intended to be a replacement for doxie.dl_Search_Records
IMPORT doxie;

export dataset(layouts.result_wide) DLEmbed_records(
	dataset (doxie.layout_references) dids
) := function

// retrieve results
rsrt := DLRaw.wide_view.by_did(dids);

// slim to final output format (preserving sort)
final_fmt	:= project(rsrt, layouts.result_wide);
final_d		:= dedup(final_fmt, except dl_seq);

// output(ids,	named('ids'));	// DEBUG
// output(seqs,	named('seqs'));	// DEBUG
// output(rpen,	named('rpen'));	// DEBUG
// output(rsrt,	named('rsrt'));	// DEBUG

return final_d;

end;
