IMPORT doxie_cbrs, doxie_crs, doxie, dnb;

doxie_cbrs.mac_Selection_Declare()

EXPORT ID_Number_records_base(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

SHARED raw_stateIDs := SORT(DEDUP(doxie_cbrs.Corp_IDs_raw(bdids)(Include_CompanyIDnumbers_val),corp_orig_sos_charter_nbr,corp_state_origin,ALL),corp_state_origin);
SHARED raw_stateIDs_v2 := SORT(DEDUP(doxie_cbrs.Corp_IDs_raw_v2(bdids)(Include_CompanyIDnumbersv2_val),corp_orig_sos_charter_nbr,corp_state_origin,ALL),corp_state_origin);
SHARED raw_FEINS := SORT(DEDUP(doxie_cbrs.fn_getBaseRecs(bdids,FALSE)(fein <> '' AND Include_CompanyIDnumbers_val),fein,ALL),fein);
// shared raw_duns := sort(dedup(doxie_cbrs.DNB_records(Include_CompanyIDnumbers_val),duns_number,ALL),duns_number);
SHARED raw_duns := DATASET([],DNB.Layout_DNB_Base);

stateIDs := CHOOSEN(raw_stateIDs,Max_CompanyIDnumbers_val);
stateIDs_v2 := CHOOSEN(raw_stateIDs_v2,Max_CompanyIDnumbers_val);
FEINS := CHOOSEN(raw_FEINS,Max_CompanyIDnumbers_val);
duns := CHOOSEN(raw_duns,Max_CompanyIDnumbers_val);

FEIN_rec := RECORD
  FEINS.fein;
  FEINS.fein_source_id;
END;

FEIN_rec fein_slim(FEINS l) := TRANSFORM
  SELF := l;
END;

FEIN_recs := PROJECT(FEINS,fein_slim(LEFT));

DUNS_rec := RECORD
  duns.duns_number;
END;

DUNS_rec duns_slim(duns l) := TRANSFORM
  SELF := l;
END;

DUNS_recs := PROJECT(duns,duns_slim(LEFT));

STATE_rec := RECORD
  stateIDs.corp_orig_sos_charter_nbr;
  stateIDs.corp_state_origin;
END;

STATE_rec state_slim(stateIDs l) := TRANSFORM
  SELF := l;
END;

STATE_recs := PROJECT(stateIDs,state_slim(LEFT));

STATE_rec_v2 := RECORD
  stateIDs_v2.corp_orig_sos_charter_nbr;
  stateIDs_v2.corp_state_origin;
END;

STATE_rec_v2 state_slim_v2(stateIDs_v2 l) := TRANSFORM
  SELF := l;
END;

STATE_recs_v2 := PROJECT(stateIDs_v2,state_slim_v2(LEFT));

recDunsNumbers := RECORDOF(DUNS_recs);
recStateIDs := RECORDOF(STATE_recs);
recStateIDs_v2 := RECORDOF(STATE_recs_v2);
recFEINs := RECORDOF(FEIN_recs);

//***** PROJECT THEM IN
nada := DATASET([0], {UNSIGNED1 a});

doxie_cbrs.layouts.id_num_record getall(nada l) := TRANSFORM
  SELF.duns_numbers := GLOBAL(DUNS_recs);
  SELF.feins := GLOBAL(FEIN_recs);
  SELF.state_ids := GLOBAL(STATE_recs);
  SELF.state_ids_v2 := GLOBAL(STATE_recs_v2);
END;

EXPORT records := PROJECT(nada, getall(LEFT));
EXPORT records_count := COUNT(raw_stateIDs) + COUNT(raw_stateIDs_v2) + COUNT(raw_FEINS) + COUNT(raw_duns);
END;
