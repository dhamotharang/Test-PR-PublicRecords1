import Corp2_Mapping, ut;

ds := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20151014::stock_mi',Corp2_Mapping.LayoutsCommon.Stock,thor);
export In_MI := distribute(ds);
//Corp2_Mapping.LayoutsCommon.stock