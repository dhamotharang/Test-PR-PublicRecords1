import doxie_cbrs_raw;
doxie_cbrs.mac_Selection_Declare();
export BBB_NM_records(dataset(doxie_cbrs.layout_references) bdids) := 
	doxie_cbrs_raw.BBB_NM(bdids,include_bbb_val,max_bbb_val).records;