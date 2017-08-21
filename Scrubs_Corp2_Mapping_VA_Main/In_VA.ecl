import Corp2_Mapping, ut;
//va := dataset(ut.foreign_prod + 'thor_data400::in::corp2::20150513::corps::va',corp2_raw_va.Layouts.CorpsStringLayoutIn,thor);

ds_VA := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20150909::main_va',Corp2_Mapping.LayoutsCommon.main,thor);
dist_VA := distribute(ds_VA);
export In_VA := dist_VA(recordorigin = 'T');
//Corp2_Mapping.LayoutsCommon.Main