export make_BBBprs(dataset(doxie_cbrs.layout_BBB) ds_bbb) := 
	sort(dedup(ds_bbb, record, all), level, company_name, prim_range, bdid);//

