EXPORT make_BBBprs(DATASET(doxie_cbrs.layout_BBB) ds_bbb) :=
  SORT(DEDUP(ds_bbb, RECORD, ALL), level, company_name, prim_range, bdid);//

