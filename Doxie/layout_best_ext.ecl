import AID;
// To be used in doxie.mac_best_records() to pull additional watchdog key fields from best keys.
EXPORT layout_best_ext := record(layout_best)
	UNSIGNED3 addr_dt_first_seen := 0;	
	AID.Common.xAID	RawAID:=0; 	
	// for other additional fields: see Watchdog.Layout_Best_v2.
end;