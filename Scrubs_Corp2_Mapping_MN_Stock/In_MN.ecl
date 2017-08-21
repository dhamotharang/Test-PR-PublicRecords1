import Corp2_Mapping, ut;

ds_MN := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20160420::stock_mn',Corp2_Mapping.LayoutsCommon.Stock,thor);
export In_MN := sort(distribute(ds_MN,hash32(corp_key)),corp_key);
//Corp2_Mapping.LayoutsCommon.Stock