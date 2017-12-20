export File_UCC_main_Base := 
         (DATASET(cluster.cluster_out+'base::ucc::main::CA', Layout_UCC_Common.Layout_ucc_new,thor,opt)+				 
				 DATASET(cluster.cluster_out+'base::ucc::main::DnB',Layout_UCC_Common.Layout_ucc_new,thor,opt)+
				 DATASET(cluster.cluster_out+'base::ucc::main::IL', Layout_UCC_Common.Layout_ucc_new,thor,opt)+
				 DATASET(cluster.cluster_out+'base::ucc::main::MA', Layout_UCC_Common.Layout_ucc_new,thor,opt)+
				 DATASET(cluster.cluster_out+'base::ucc::main::NYC',Layout_UCC_Common.Layout_ucc_new,thor,opt)+
				 DATASET(cluster.cluster_out+'base::ucc::main::TH', Layout_UCC_Common.Layout_ucc_new,thor,opt)+
				 DATASET(cluster.cluster_out+'base::ucc::main::TX', Layout_UCC_Common.Layout_ucc_new,thor,opt)+
				 DATASET(cluster.cluster_out+'base::ucc::main::WA', Layout_UCC_Common.Layout_ucc_new,thor,opt)+
				 DATASET(cluster.cluster_out+'base::ucc::main::TD', Layout_UCC_Common.Layout_ucc_new,thor,opt))
				 (tmsid not in UCCV2.Suppress_TMSID());