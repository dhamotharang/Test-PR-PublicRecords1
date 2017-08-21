import Corp2_Mapping, ut;

ds_NV := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20160328::stock_nv',Corp2_Mapping.LayoutsCommon.Stock,thor);
export In_NV := sort(distribute(ds_NV,hash32(corp_key)),corp_key);
//Corp2_Mapping.LayoutsCommon.Stock