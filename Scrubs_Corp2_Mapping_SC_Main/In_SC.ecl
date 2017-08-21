import Corp2_Mapping, ut;

ds_SC:= dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20160328::main_sc',Corp2_Mapping.LayoutsCommon.Main,thor);
export In_SC := distribute(ds_SC);
//Corp2_Mapping.LayoutsCommon.Main