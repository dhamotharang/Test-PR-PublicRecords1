// export File_UCC_Party_Base := 
                 // DATASET(cluster.cluster_out+'base::ucc::party',Layout_UCC_Common.Layout_Party , thor)(tmsid not in UCCV2.Suppress_TMSID);
								 
export File_UCC_Party_Base := PROJECT(UCCV2.File_UCC_Party_Base_AID,TRANSFORM(Layout_UCC_Common.Layout_Party,SELF := LEFT;));