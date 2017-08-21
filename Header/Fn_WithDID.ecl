import watchdog, ut;

export Fn_WithDID(
	dataset(header.layout_header) head,
	dataset(watchdog.Layout_Best) bestf,
	string persist_suffix = '',
	boolean includeOutsideMatches = true
	) :=
MODULE

//****** GENERATE THE POPULATED MATCHRECS AND THEN THE MATCH CANDIDATES
boolean NewPreferredFirst := false;
pma 			 := header.fn_populate_matchrecs(head, bestf, persist_suffix, NewPreferredFirst); 
export mca := header.fn_match_candidates(pma, head, persist_suffix, NewPreferredFirst);


//****** GENERATE DID RULES
export mod_DR0 := Did_Rules0(mca,persist_suffix,includeOutsideMatches);
DR0 := 						project(mod_DR0.result,header.Layout_PairMatch);
export DR1 := 		header.fn_Did_Rules1(DR0);


//****** APPLY DID RULES
Header.MAC_ApplyDid1(head,DID,DR1,outfile_both)

export result :=  outfile_both;

END;