import Corp2_Mapping, ut;

ds := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20160513::stock_tn',Corp2_Mapping.LayoutsCommon.Stock,thor);
ds_filt := ds;

export In_TN := distribute(ds_filt,hash32(corp_key));
//Corp2_Mapping.LayoutsCommon.Stock