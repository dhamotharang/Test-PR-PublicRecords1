EXPORT getRelatives(UNSIGNED6 thebdid) :=
  doxie_cbrs.getRelatives_ds(DATASET([{thebdid}], doxie_cbrs.layout_references));
