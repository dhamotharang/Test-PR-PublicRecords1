import Corp2_Mapping, ut;

ds_stock			:= dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20160504::stock_nh',Corp2_Mapping.LayoutsCommon.stock,thor);
dist_stock 		:= dedup(sort(distribute(ds_stock,hash(corp_key)),record,local),record,local);
export In_NH 	:= dist_stock;

//Corp2_Mapping.LayoutsCommon.Stock