export layout_trades_out := RECORD
	layout_corps_out;
	DATASET(layout_events_out) events {MAXCOUNT(25)};
END;