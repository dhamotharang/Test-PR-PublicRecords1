import Corp2_Mapping, ut;
export In_NH := module
		shared ds_main			:= dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20160509::main_nh',Corp2_Mapping.LayoutsCommon.main,thor);
		shared dist_main 		:= dedup(sort(distribute(ds_main,hash(corp_key)),record,local),record,local);
		export Corp := dist_main(recordorigin = 'C');
		export Cont := dist_main(recordorigin = 'T');
end;
//Corp2_Mapping.LayoutsCommon.Main