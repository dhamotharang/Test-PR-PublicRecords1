import Corp2_Mapping, ut;

ds_event			:= dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20160504::event_nh',Corp2_Mapping.LayoutsCommon.Events,thor);
dist_event 		:= dedup(sort(distribute(ds_event,hash(corp_key)),record,local),record,local);
export In_NH 	:= dist_event;

//Corp2_Mapping.LayoutsCommon.Events