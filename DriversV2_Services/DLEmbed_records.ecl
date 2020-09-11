// NOTE: This is intended to be a replacement for doxie.dl_Search_Records
IMPORT doxie;

EXPORT DATASET(layouts.result_wide) DLEmbed_records(
  DATASET (doxie.layout_references) dids
) := FUNCTION

// retrieve results
rsrt := DLRaw.wide_view.by_did(dids);

// slim to final output format (preserving sort)
final_fmt := PROJECT(rsrt, layouts.result_wide);
final_d := DEDUP(final_fmt, EXCEPT dl_seq);

RETURN final_d;

END;
