import business_header, doxie_cbrs, doxie,corp2,corp2_services;

export Corp_v2(
	dataset(doxie_cbrs.layout_references) bdids,
	boolean Include_val = false,
	unsigned3 Max_val = 0,
	string ssn_mask_value = ''
) := MODULE

	shared CorpKey := corp2.key_corp_bdid;

	doxie_cbrs.mac_RollStart(
		bdids, outf1,
		Corpkey, Max_val * 2, Include_val
	);
	
	ids := choosen(dedup(project(outf1, Corp2_Services.layout_Corpkey), all), Max_val);
	CorpRecs := Corp2_Services.Corp2_Raw.report_view.by_CorpKey(ids, ssn_mask_value);

	shared out_f := CorpRecs;

	export records := out_f;
	export record_count(boolean count_only) := 
			IF(count_only,
			   count(project(CorpKey(keyed(bdid in SET(doxie_cbrs.ds_SupergroupLevels(bdids), bdid))), transform({CorpKey.bdid}, self := left))),
				 count(out_f));
END;