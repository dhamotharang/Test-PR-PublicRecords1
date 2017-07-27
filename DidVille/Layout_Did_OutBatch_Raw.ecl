import patriot;

export Layout_Did_OutBatch_Raw := record		
		STRING3 score := '';
		STRING12 hhid := '';
		Layout_Did_InBatchRaw ;
		layout_best_append_Raw;
		patriot.Layout_PatriotAppend_Raw;
 end;