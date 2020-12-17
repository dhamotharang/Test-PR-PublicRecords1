IMPORT corp, codes, fbn, suppress, business_header, doxie, doxie_cbrs_raw;
doxie_cbrs.MAC_Selection_Declare()

EXPORT Corporation_Filings_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

ck_rec := RECORD
  STRING30 corp_key;
END;

needCF := Include_CompanyIDnumbers_val OR Include_CorporationFilings_val OR Include_CompanyProfile_val OR Include_RegisteredAgents_val;

mycorp := doxie_cbrs_raw.Corporation_Filings(bdids,needcf, max_CorporationFilings_val).records;

outrec := doxie_cbrs.layouts.corporation_filings_record;

outrec keepr(mycorp r) := TRANSFORM
  SELF.corp_state_origin_decoded := codes.GENERAL.state_long(R.corp_state_origin);
  SELF.corp_inc_state_decoded := codes.GENERAL.state_long(R.corp_inc_state);
  SELF.corp_for_profit_ind_decoded := codes.corp2.CORP_FOR_PROFIT_IND(R.corp_for_profit_ind);
  SELF.corp_foreign_domestic_ind_decoded := codes.corp2.CORP_FOREIGN_DOMESTIC_IND(R.corp_foreign_domestic_ind);
  SELF := r;
END;

outf1 := PROJECT(mycorp, keepr(LEFT));

doxie_cbrs.mac_filter_fein(outf1,corp_ra_fein,outf2)
doxie_cbrs.mac_mask_ssn(outf2, outf3, corp_ra_ssn)

RETURN outf3;
END;
