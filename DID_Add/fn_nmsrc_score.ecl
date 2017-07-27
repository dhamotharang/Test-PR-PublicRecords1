export unsigned1 fn_nmsrc_score(unsigned6 orig_did, unsigned6 nmsrc_did, unsigned1 orig_did_score, low_score_threshold):= function

return map(orig_did > 0 and orig_did_score > low_score_threshold - 1 and orig_did = nmsrc_did => 100, 
	       nmsrc_did > 0  and orig_did_score > low_score_threshold - 1  => 75,
		   orig_did  > 0  => 50, 0);
						  
end;
						  
		