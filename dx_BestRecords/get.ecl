export get(did_ds, did_field, permission_type, on_thor = 'false') := functionmacro;

	import dx_BestRecords;
	return dx_BestRecords.mac_fetch_recs(did_ds, did_field, permission_type, on_thor, false);

endmacro;