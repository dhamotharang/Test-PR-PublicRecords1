import Corp2_Mapping, ut;

ds_WY:= dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20160516::stock_wy',Corp2_Mapping.LayoutsCommon.stock,thor);
export In_WY := distribute(ds_WY);
//Corp2_Mapping.LayoutsCommon.Stock