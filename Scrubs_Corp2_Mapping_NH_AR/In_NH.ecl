import Corp2_Mapping, ut;

ds_ar					:= dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20160504::ar_nh',Corp2_Mapping.LayoutsCommon.AR,thor);
dist_ar 			:= dedup(sort(distribute(ds_ar,hash(corp_key)),record,local),record,local);
export In_NH 	:= dist_ar;

//Corp2_Mapping.LayoutsCommon.AR