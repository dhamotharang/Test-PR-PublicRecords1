IMPORT doxie, doxie_crs;

EXPORT Liens_Judgments_UCC_records_trimmed(DATASET(doxie_cbrs.layout_references) bdids, STRING6 SSNMask = 'NONE') :=
MODULE

doxie_cbrs.mac_Selection_Declare()
SHARED raw_jls := doxie_cbrs.Liens_Judments_records(bdids)(Include_LiensJudgments_val OR Include_LiensJudgmentsUCC_val);
doxie_cbrs.mac_Selection_Declare()
SHARED raw_uccs := doxie_cbrs.UCC_Records(bdids, SSNMask)(Include_UCCFilings_val OR Include_LiensJudgmentsUCC_val);

doxie_cbrs.mac_Selection_Declare()
jls := CHOOSEN(raw_jls,Max_LiensJudgmentsUCC_val);
uccs := CHOOSEN(raw_uccs,Max_UCCFilings_val);

jl_rec := RECORD
  jls.court_desc;
  jls.plaintiff;
  jls.defname;
  jls.amount;
  jls.filing_date;
  jls.filingtype_desc;
  jls.casenumber;
  jls.book;
  jls.page;
  jls.release_date;
  jls.prim_range;
  jls.predir;
  jls.prim_name;
  jls.suffix;
  jls.postdir;
  jls.unit_desig;
  jls.sec_range;
  jls.p_city_name;
  jls.v_city_name;
  jls.state;
  jls.zip;
  jls.zip4;
  jls.cart;
  jls.cr_sort_sz;
  jls.lot;
  jls.lot_order;
  jls.dbpc;
  jls.chk_digit;
  jls.rec_type;
  jls.county;
  jls.geo_lat;
  jls.geo_long;
  jls.msa;
  jls.geo_blk;
  jls.geo_match;
  jls.err_stat;
  jls.county_name;
END;

jl_rec jl_slim(jls L) := TRANSFORM
  SELF := L;
END;

jls_trimmed := PROJECT(jls,jl_slim(LEFT));

ucc_rec := RECORD
  uccs.debtor_name;
  uccs.secured_name;
  uccs.filing_date;
  uccs.filing_type_desc;
  uccs.filing_state;
  uccs.event_document_num;
END;

ucc_rec ucc_slim(uccs L) := TRANSFORM
  SELF := L;
END;

uccs_trimmed := PROJECT(uccs,ucc_slim(LEFT));

recjl := RECORDOF(jls_trimmed);
recucc := RECORDOF(uccs_trimmed);


//***** THE COMBINED LAYOUT
rec := RECORD, MAXLENGTH(doxie_crs.maxlength_report)
  DATASET(recjl) Judgment_Liens;
  DATASET(recucc) UCCS;
END;

//***** PROJECT THEM IN
nada := DATASET([0], {UNSIGNED1 a});
rec getJL(nada l) := TRANSFORM
  SELF.Judgment_Liens := GLOBAL(jls_trimmed);
  SELF.UCCS := GLOBAL(uccs_trimmed);
END;


EXPORT records := PROJECT(nada,getJL(LEFT));
EXPORT records_count := COUNT(raw_jls) + COUNT(raw_uccs);

END;
