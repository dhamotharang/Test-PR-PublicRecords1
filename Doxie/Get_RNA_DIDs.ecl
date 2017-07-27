IMPORT doxie;

rec := doxie.layout_references;

//get the relatives and associates
rels_fat := doxie.relative_records(false);
rels := project(rels_fat, doxie.layout_references);

//get the neighbors
nbrs_fat := doxie.historic_nbr_records_crs(false); // this attributes only returns dids
nbrs := project(nbrs_fat, doxie.layout_references);

//get all the dids together
export get_rna_dids := dedup(rels + nbrs, did, all): global;