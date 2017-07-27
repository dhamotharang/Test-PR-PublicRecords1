import patriot, didville;

export Layout_InstantID := record
     unsigned6 did := 0;
     unsigned2 score := 0;
     unsigned6 hhid := 0;
     didville.layout_did_inbatch;
     didville.layout_best_append;
	UNSIGNED1 verify_best_fname;
	UNSIGNED1 verify_best_lname;
  end;