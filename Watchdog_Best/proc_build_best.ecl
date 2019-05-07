IMPORT $,SALT311,data_services,header;

EXPORT proc_build_best(DATASET($.Layout_Hdr) h) := FUNCTION
	//$.Keys(h).BuildData;
	b := $.MAC_CreateBest(h, , ); // Instantiate Best module
	b.Stats;

	return b.BestBy_did_child;

END;