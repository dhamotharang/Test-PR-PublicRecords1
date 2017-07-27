import corp, codes, fbn, suppress, business_header, doxie, doxie_cbrs_raw;
doxie_cbrs.MAC_Selection_Declare()

// ck_rec := record
	// string30  corp_key;
// end;

export Corporation_Filings_records_slim(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

needCF := Include_CompanyIDnumbers_val or Include_CorporationFilings_val or Include_CompanyProfile_val or Include_RegisteredAgents_val;

mycorp := doxie_cbrs_raw.Corporation_Filings(bdids,needcf, max_CorporationFilings_val).records_slim;



mycorp keepr(mycorp r) := transform
	self.corp_state_origin_decoded := codes.GENERAL.state_long(R.corp_state_origin);
	self.corp_inc_state_decoded := codes.GENERAL.state_long(R.corp_inc_state);
	self.corp_for_profit_ind_decoded := codes.corp2.CORP_FOR_PROFIT_IND(R.corp_for_profit_ind);
	self.corp_foreign_domestic_ind_decoded := codes.corp2.CORP_FOREIGN_DOMESTIC_IND(R.corp_foreign_domestic_ind);
	self := r;
end;

outf1 := project(mycorp, keepr(left));

doxie_cbrs.mac_filter_fein(outf1,corp_ra_fein,outf2)
doxie_cbrs.mac_mask_ssn(outf2, outf3, corp_ra_ssn)

return outf3;
END;