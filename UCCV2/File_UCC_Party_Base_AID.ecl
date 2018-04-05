export File_UCC_Party_Base_AID := 
                 DATASET(cluster.cluster_out+'base::ucc::party_AID',Layout_UCC_Common.Layout_Party_With_AID, thor)(tmsid not in UCCV2.Suppress_TMSID());