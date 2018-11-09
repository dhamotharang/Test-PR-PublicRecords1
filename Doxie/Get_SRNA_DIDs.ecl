//get all the dids together
IMPORT doxie;

export get_srna_dids := dedup(PROJECT (doxie.Get_Dids(), doxie.layout_references) + doxie.Get_RNA_DIDs, all): global;