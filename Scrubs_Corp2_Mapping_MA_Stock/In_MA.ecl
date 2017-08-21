import Corp2_Mapping, ut;

ds_MA := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20150812::stock_MA',Corp2_Mapping.LayoutsCommon.Stock,thor);
export In_MA := sort(distribute(ds_MA,hash32(corp_key)),corp_key);
//Corp2_Mapping.LayoutsCommon.Stock