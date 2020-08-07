IMPORT doxie,business_header;
doxie_cbrs.MAC_Selection_Declare()
EXPORT judgement_records_prs_max(DATASET(doxie_cbrs.layout_references) bdids) :=
  CHOOSEN(doxie_cbrs.judgement_records_prs(bdids)(Return_Judgments_val), Max_Judgments_val);
