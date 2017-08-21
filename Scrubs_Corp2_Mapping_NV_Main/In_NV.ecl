import Corp2_Mapping, ut;

ds_NV := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20160328::main_nv',Corp2_Mapping.LayoutsCommon.Main,thor);
export In_NV := distribute(ds_NV);
//Corp2_Mapping.LayoutsCommon.Main