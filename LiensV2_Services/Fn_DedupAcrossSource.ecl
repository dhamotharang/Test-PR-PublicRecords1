

export Fn_DedupAcrossSource(dataset(LiensV2_Services.layout_case_temp) inputs) := 
FUNCTION

try := inputs.derived_case_number <> '' and inputs.derived_filing_state <> '';
inskip := inputs(~try);
intry  := inputs(try);

picksource(string2 src) := 
	map(src = 'HG' => 0,	//prefer Hogan
		1);

srt := sort(intry, derived_case_number, derived_filing_state, picksource(tmsid[1..2]), tmsid);
ddp := dedup(srt,  derived_case_number, derived_filing_state);

return inskip + ddp;

END;
	