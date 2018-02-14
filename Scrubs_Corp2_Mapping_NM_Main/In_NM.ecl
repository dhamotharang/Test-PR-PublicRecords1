import Corp2_Mapping, ut;

ds_main:= dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20150909::main_nm',Corp2_Mapping.LayoutsCommon.main,thor);
dist_main := dedup(sort(distribute(ds_main,hash(corp_key)),record,local),record,local);
export In_NM := dist_main;

//Corp2_Mapping.LayoutsCommon.Main