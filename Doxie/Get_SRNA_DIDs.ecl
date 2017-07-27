//get all the dids together
export get_srna_dids := dedup(doxie.Get_Dids() + doxie.Get_RNA_DIDs, all): global;