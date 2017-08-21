import Corp2_Mapping, ut;

ds_main := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20160420::main_mn',Corp2_Mapping.LayoutsCommon.Main,thor);
main := ds_main(recordorigin = 'T');

export In_MN_Cont := distribute(main,hash32(corp_key));
//Corp2_Mapping.LayoutsCommon.Main