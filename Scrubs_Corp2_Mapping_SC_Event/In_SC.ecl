import Corp2_Mapping, ut;

ds_SC := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20150328::event_sc',Corp2_Mapping.LayoutsCommon.events,thor);
export In_SC := distribute(ds_SC);
//Corp2_Mapping.LayoutsCommon.Events