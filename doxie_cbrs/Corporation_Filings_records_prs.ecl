IMPORT ut;

EXPORT Corporation_Filings_records_prs(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

cfr := doxie_cbrs.Corporation_Filings_records_slim(bdids);



srtd := SORT(cfr, level, -corp_inc_date, -dt_last_seen, corp_legal_name, corp_state_origin, corp_orig_sos_charter_nbr,
             corp_status_desc, RECORD); //this keeps active over inactive when ALL else equal

srtd rollem(srtd l, srtd r) := TRANSFORM
  SELF.dt_first_seen := IF(l.dt_first_seen > 0 AND l.dt_first_seen < r.dt_first_seen, l.dt_first_seen, r.dt_first_seen);
  SELF.dt_last_seen := IF(l.dt_last_seen > r.dt_last_seen, l.dt_last_seen, r.dt_last_seen);
  SELF := l;
END;

RETURN ROLLUP(srtd, LEFT.corp_legal_name = RIGHT.corp_legal_name AND
                    LEFT.corp_inc_date = RIGHT.corp_inc_date AND
                    LEFT.corp_state_origin = RIGHT.corp_state_origin AND
                    LEFT.corp_orig_sos_charter_nbr = RIGHT.corp_orig_sos_charter_nbr, rollem(LEFT, RIGHT));
END;
