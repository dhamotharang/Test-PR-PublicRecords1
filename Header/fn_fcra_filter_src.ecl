import header,mdr, FCRA, std;

todays_date := (string) (string) STD.Date.Today();

export fn_fcra_filter_src(dataset(header.Layout_Header) head0) :=
FUNCTION

filtered_src := head0(~(src not in mdr.sourceTools.set_scoring_FCRA) AND
     ((src='BA' AND FCRA.bankrupt_is_ok(todays_date,(string)dt_first_seen)) OR
	 (src='L2' AND FCRA.lien_is_ok(todays_date,(string)dt_first_seen)) OR
	 src NOT IN ['BA','L2']));

return filtered_src;

END;