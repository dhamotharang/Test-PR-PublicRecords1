IMPORT doxie, doxie_crs;

EXPORT Liens_Judgments_UCC_records_trimmed_v2(DATASET(doxie_cbrs.layout_references) bdids, STRING6 SSNMask = 'NONE') :=
MODULE

  doxie_cbrs.mac_Selection_Declare()
  SHARED raw_jls := doxie_cbrs.Liens_Judments_records_v2(bdids, SSNMask).report_view(Max_LiensJudgmentsUCC_val)(Include_LiensJudgmentsV2_val OR Include_LiensJudgmentsUCCV2_val);
  doxie_cbrs.mac_Selection_Declare()
  SHARED raw_uccs := doxie_cbrs.UCC_Records_v2(bdids, SSNMask).report_view(Max_UCCFilings_val)(Include_UCCFilingsV2_val OR Include_LiensJudgmentsUCCV2_val);

  doxie_cbrs.mac_Selection_Declare()
  jls := CHOOSEN(raw_jls,Max_LiensJudgmentsUCC_val);
  uccs := CHOOSEN(raw_uccs,Max_UCCFilings_val);

  jls_trimmed := jls;
  uccs_trimmed := uccs;

  //***** PROJECT THEM IN
  nada := DATASET([0], {UNSIGNED1 a});
  doxie_cbrs.layouts.lj_ucc_record_slim_v2 getJL(nada l) := TRANSFORM
    SELF.Judgment_Liens := GLOBAL(jls_trimmed);
    SELF.UCCS := GLOBAL(uccs_trimmed);
  END;

  EXPORT records := PROJECT(nada,getJL(LEFT));
  EXPORT records_count := COUNT(raw_jls) + COUNT(raw_uccs);

END;
