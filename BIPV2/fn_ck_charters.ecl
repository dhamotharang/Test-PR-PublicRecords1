EXPORT fn_ck_charters(ds, id) := FUNCTIONMACRO
	IMPORT MDR;
	
	// filter for only foreign corpkey records
	LOCAL ds_filt := ds(
		MDR.sourceTools.SourceIsCorpV2(source),
		foreign_corp_key != '' OR active_domestic_corp_key != '',
		company_inc_state != '',
		company_charter_number != ''
	);

	LOCAL ds_thin := TABLE(ds_filt, {id, company_inc_state, company_charter_number});
	LOCAL ds_dist := DISTRIBUTE(ds_thin, HASH32(id));
	LOCAL ds_sort := SORT(ds_dist, id, company_inc_state, company_charter_number, LOCAL);

	RETURN DEDUP(ds_sort, id, company_inc_state, company_charter_number, LOCAL);
ENDMACRO;