import patriot,didville;

export Layout_Did_OutBatch := record
	 unsigned6 did := 0;
	 unsigned2 score := 0;
	 unsigned6 hhid := 0;
	 didville.layout_did_inbatch;
	 didville.layout_best_append;
	 patriot.Layout_PatriotAppend;
	 didville.layout_lookups;
	 didville.layout_livingsits;
end;