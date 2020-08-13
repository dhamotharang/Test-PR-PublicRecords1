IMPORT doxie_raw,doxie,doxie_Cbrs,WatercraftV2_services;

doxie_cbrs.MAC_Selection_Declare()
    
EXPORT watercraft_records(DATASET(doxie_cbrs.layout_references) bdids) :=
  CHOOSEN(WatercraftV2_services.WatercraftV2_raw.Report_View.by_bdid(bdids,ssn_mask_value),Max_Watercrafts);
