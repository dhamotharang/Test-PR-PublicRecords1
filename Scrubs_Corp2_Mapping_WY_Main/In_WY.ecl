import Corp2_Mapping, ut;

ds_WY:= dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20160516::main_wy',Corp2_Mapping.LayoutsCommon.main,thor);
dist_WY := dedup(sort(distribute(ds_WY,hash(corp_key)),record,local),record,local);
export In_WY := dist_WY;

//Corp2_Mapping.LayoutsCommon.Main
