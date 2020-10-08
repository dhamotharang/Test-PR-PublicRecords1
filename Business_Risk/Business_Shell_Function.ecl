import risk_indicators, Doxie, Business_Risk;

export Business_Shell_Function(dataset(Business_Risk.Layout_Output) biid, unsigned1 glb,
                                                        unsigned1 LexIdSourceOptout = 1,
                                                        string TransactionID = '',
                                                        string BatchUID = '',
                                                        unsigned6 GlobalCompanyId = 0, string DataPermission = '', string DataRestriction ) := function

mod_access := MODULE(Doxie.IDataAccess)
	EXPORT glb := ^.glb;
	EXPORT unsigned1 lexid_source_optout := LexIdSourceOptout;
	EXPORT string transaction_id := TransactionID; // esp transaction id or batch uid
	EXPORT unsigned6 global_company_id := GlobalCompanyId; // mbs gcid
  EXPORT String DataPermissionMask := DataPermission;
  EXPORT String DataRestrictionMask := DataRestriction;
END;

	// check the first record in the batch to determine if this a realtime transaction or an archive test
	production_realtime_mode := biid[1].historydate=risk_indicators.iid_constants.default_history_date;
	
prof_risk := if(production_realtime_mode, Business_Risk.getBDIDTable(biid, mod_access), business_risk.getBDIDTable_Hist(biid, mod_access));

withPRS := join(biid, prof_risk, left.seq=right.seq, 
				transform(business_risk.Layout_Business_Shell,
						// blank out these PRS fields so the modelers use the BIID equivalent to those fields instead
							self.prs.sources := 0,
							self.prs.company_name_score := 0,
							self.prs.combined_score := 0,
							self.prs.current_corp_cnt := 0,
							self.prs.ofac_cnt := 0,
						self.prs := right,
						self.biid.addr1 := Risk_Indicators.MOD_AddressClean.street_address('',left.prim_range, left.predir, left.prim_name,
												left.addr_suffix, left.postdir, left.unit_desig, left.sec_range);
						self.biid.rep_addr1 := Risk_Indicators.MOD_AddressClean.street_address('',left.rep_prim_range, left.rep_predir, left.rep_prim_name, 
																left.rep_addr_suffix, left.rep_postdir, left.rep_unit_desig, left.rep_sec_range);
						self.biid.bestfein_flag := left.fein=left.bestfein;  
						self.biid.repbestssn_flag := left.rep_ssn=left.RepBestSSN; 
						self.biid.repbestlname_flag := risk_indicators.LnameScore(left.rep_lname, left.RepBestLname) between 80 and 100; 
						self.biid.repbestlname_alt_flag := risk_indicators.LnameScore(left.rep_alt_lname, left.RepBestLname) between 80 and 100;										
						self.biid := left,
						self.history_date := (string)left.historydate),
				left outer,keep(1));	
				
return withPRS;

end;
