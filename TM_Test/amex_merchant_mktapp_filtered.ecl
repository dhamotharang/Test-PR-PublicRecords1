import ut, Business_Header, did_add;

// Use the marketing version of the Best information
bh_mkt_best := Business_Header.BestAll_MktApp;

os(STRING s) := IF(s = '', '', TRIM(s) + ' ');

Layout_Amex_Merchant_Base CheckBDIDMktRestricted(Layout_Amex_Merchant_Base l, bh_mkt_best r) := transform
self.bdid_mkt_flag := if(r.bdid = 0, 'Y', 'N');
self.best_CompanyName := if(r.bdid <> 0, r.company_name, '');

self.best_addr1 := if(r.bdid <> 0,
			os(r.prim_range) + 
			os(r.predir) + 
			os(r.prim_name) +
			os(r.addr_suffix) +
			os(r.postdir) +
				if(ut.tails(r.prim_name, os(r.unit_desig) + os(r.sec_range)),
					'',
					os(r.unit_desig) + os(r.sec_range)), '');
self.best_city := if(r.bdid <> 0, r.city, '');
self.best_state := if(r.bdid <> 0, r.state, '');
self.best_zip := if(r.bdid <> 0, if(r.zip = 0, '', intformat(r.zip, 5, 1)), '');
self.best_zip4 := if(r.bdid <> 0, if(r.zip4 <> 0, intformat(r.zip4, 4, 1), ''), '');

self.best_phone := if(r.bdid <> 0, if(r.phone <> 0, intformat(r.phone, 10, 1), ''), '');
self.best_fein := if(r.bdid <> 0, if(r.fein <> 0, intformat(r.fein, 9, 1), ''), '');
self.verify_best_phone := if(r.bdid <> 0, did_add.phone_match_score(l.phone10, IF(r.phone = 0, '', INTFORMAT(r.phone, 10, 1))), 255);
//self.verify_best_fein := if(r.bdid <> 0, did_add.ssn_match_score(l.fein, IF(r.fein = 0, '', INTFORMAT(r.fein, 9, 1))), 255);
self.verify_best_fein := 255;
self.verify_best_CompanyName := if(r.bdid <> 0, did_add.company_name_match_score(Stringlib.StringToUpperCase(l.Business_Name), r.company_name), 255);
self.verify_best_address := if(r.bdid <> 0, did_add.Address_Match_Score(
			l.bus_prim_range, l.bus_prim_name, l.bus_sec_range, l.bus_zip,
			r.prim_range, r.prim_name, r.sec_range, IF(r.zip = 0, '', INTFORMAT(r.zip, 5, 1))), 255);

self := l;
end;

amex_merchant_best_filtered := join(amex_merchant_prep(bdid <> 0),
                                    bh_mkt_best,
				                left.bdid = right.bdid,
				                CheckBDIDMktRestricted(left, right),
				                left outer,
				                hash);
				
amex_merchant_best_filtered_all := amex_merchant_best_filtered + amex_merchant_prep(bdid = 0);
amex_merchant_best_filtered_sort := sort(amex_merchant_best_filtered_all, rid, seq);

export amex_merchant_mktapp_filtered := amex_merchant_best_filtered_sort : persist('TMTEST::amex_merchant_mktapp_filtered');