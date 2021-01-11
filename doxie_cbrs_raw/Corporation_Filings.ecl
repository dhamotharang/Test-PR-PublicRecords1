import corp2, doxie_cbrs;

export Corporation_Filings(
	dataset(doxie_cbrs.layout_references) bdids,
	boolean Include_val = false,
	unsigned3 Max_val = 0
) := MODULE

shared k := corp2.Key_Corp_BdidPL;

doxie_cbrs.mac_RollStart
	(bdids, outf1, k,
	 Max_val * 2,Include_val,bdid,true,bdid,corp_legal_name+corp_inc_date, corp_state_origin+corp_orig_sos_charter_nbr+corp_status_desc)



shared out_f 		:= outf1;


shared simple_count :=
	count(project(k(keyed(bdid in SET(doxie_cbrs.ds_SupergroupLevels(bdids), bdid))), transform({k.bdid}, self := left)));

	export records := out_f;

	doxie_cbrs.mac_RollStart
	(bdids, outf1_slim, k,
	 Max_val * 2,Include_val,bdid,true,bdid,corp_legal_name+corp_inc_date, corp_state_origin+corp_orig_sos_charter_nbr+corp_status_desc,
	 true, doxie_cbrs.layout_corporation_filings_slim)

	export records_slim := outf1_slim;
	export record_count(boolean count_only = false) :=
													IF(count_only,simple_count,count(out_f));

END;
