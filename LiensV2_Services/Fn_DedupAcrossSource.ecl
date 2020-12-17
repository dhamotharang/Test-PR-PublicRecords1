

EXPORT Fn_DedupAcrossSource(DATASET(LiensV2_Services.layout_case_temp) inputs) :=
FUNCTION

  try := inputs.derived_case_number <> '' AND inputs.derived_filing_state <> '';
  inskip := inputs(~try);
  intry := inputs(try);

  picksource(STRING2 src) :=
    MAP(src = 'HG' => 0, //prefer Hogan
      1);

  srt := SORT(intry, derived_case_number, derived_filing_state, picksource(tmsid[1..2]), tmsid);
  ddp := DEDUP(srt, derived_case_number, derived_filing_state);

  RETURN inskip + ddp;

END;
  
