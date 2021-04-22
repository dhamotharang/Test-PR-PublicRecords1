import patriot,didville;

export Layout_Did_OutBatch_V2 := record
	 unsigned6 did := 0;
	 unsigned2 score := 0;
	 unsigned6 hhid := 0;
	 didville.layout_did_inbatch_v2;
	 didville.layout_best_append;
	 patriot.Layout_PatriotAppend;
	 didville.layout_lookups;
	 didville.layout_livingsits;
	 unsigned8 location_id := 0;
end;
