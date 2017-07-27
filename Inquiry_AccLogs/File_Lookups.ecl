import ut;

export File_Lookups :=  module

	export code_info := dataset(ut.foreign_logs + '~thor10_11::in::code_info', 
												{string table_name, string column_name, string code, string description},
												 csv(separator('~~'), quote(''), heading(1)));
	
	export company_ext := dataset(ut.foreign_logs + '~thor10_11::in::company_ext', 
												{string gc_id, string ext_type, string cat_name, string detail1, string detail2}, 
												 csv(separator('~~'), quote(','), heading(1)));

	export moxie_function_desc := dataset(ut.foreign_logs + '~thor10_11::in::moxie_function_desc', 
																{string transaction_type, string function_name, string search_description}, 
																 csv(separator('\t'), quote(','), heading(1)));
	
	export revenue_desc := dataset(ut.foreign_logs + '~thor10_11::in::revenue_desc', 
													{string product_id, string billing_id, string mbs_market, string mbs_vertical, string mbs_sub_market, string status_updated, string top, string sales_household_name}, 
													 csv(separator('~~'), quote(','), heading(1)));
	
	export tax_exempt := dataset(ut.foreign_logs + '~thor10_11::in::tax_exempt', 
												{string gc_id, string start_date, string end_date, string exempt_status, string is_active}, 
												 csv(separator('~~'), quote(','), heading(1)));
	
	export transaction_desc := dataset(ut.foreign_logs + '~thor10_11::in::transaction_desc', 
															{string product_id, string transaction_type, string function_name, string description}, 
															 csv(separator('~~'), quote(','), heading(1)));
	
	export user_info := dataset(ut.foreign_logs + '~thor10_11::in::user_info', 
												{string product_id, string company_id, string login_id, string first_name, string last_name, string status, string system_administrator}, 
												 csv(separator('~~'), quote(''), heading(1)));

	export position_code_info := project(dataset(ut.foreign_logs + '~thor10_11::in::position_code_info', 
																	{string filler1, string filler2, string bitposition, string bitcode, string bitallowstatus, string bitallowdescr}, 
																	csv(separator('~~'), quote(''), heading(1))),
																transform({unsigned bitposition, string bitcode, string bitallowstatus, string bitallowdescr}, 
																				self.bitposition := (unsigned)left.bitposition;
																				self := left));
																				
	export prodr3_bankobatch_seqids := dataset('~thor20_11::in::banko_batch::sequence_to_pid', {string pid, string rid, string sequence_number}, csv(separator('\t')));
												
	raw_finance_table := dataset(ut.foreign_logs + '~thor10_11::in::mbs::finance_master', {string			HHID;
																																					string			HouseholdName;
																																					string			sub_acct_id;
																																					string			acct_name;
																																					string			attention_line;
																																					string			platform;
																																					string			Banko_MN;
																																					string			vertical;
																																					string			market;
																																					string			sub_market;
																																					string			industry;
																																					string			use;
																																					string			primary_market_code;
																																					string			secondary_market_code;
																																					string			industry_code_1;
																																					string			industry_code_2;
																																					string			create_date;
																																					string			NB_status;
																																					string			Region;
																																					string			Team2;
																																					string			mgr_name;
																																					string			Team;
																																					string			pri_rep_name;
																																					string			pri_territory;
																																					string			sec_rep_name;
																																					string			cust_id;
																																					string			cust_name;
																																					string			city_name;
																																					string			state_cd;
																																					string			postal_cd}, csv(separator('\t'), quote('"')));

	//RW - riskwise, DI - Banko "Dolan", ST - Accurint "Seisint", LN - Dayton Leg, CP - Choicepoint Leg, PW - Peoplewise Leg, SD - Securint Leg																														
	export finance_table := project(raw_finance_table, transform({recordof(raw_finance_table), string company_id_finance, string co_cd, string hash_company_id_finance, string product_id},
																															self.hash_company_id_finance := fnHashIDField(stringlib.stringtouppercase(if(regexfind('[a-zA-Z]', left.sub_acct_id[1..2]), 
																																											left.sub_acct_id[3..], left.sub_acct_id))),
																															self.company_id_finance := stringlib.stringtouppercase(if(regexfind('[a-zA-Z]', left.sub_acct_id[1..2]), 
																																											left.sub_acct_id[3..], left.sub_acct_id)),
																															self.co_cd := stringlib.stringtouppercase(if(regexfind('[a-zA-Z]', left.sub_acct_id[1..2]), 
																																							left.sub_acct_id[1..2],'')),
																															self.product_id := map(self.co_cd = 'DI' => '5',
																																										 self.co_cd = 'RW' => '2',
																																										 self.co_cd = 'ST' => '1', '');
																															self.industry := if(left.industry = '0', '', left.industry);
																															self := left));	


	export rw_searches := dataset(ut.foreign_logs + '~thor10_11::in::rw_searches', 
																	{string function_name, string description, string is_fcra}, csv(separator('\t'), quote(''), heading(1)));

	export internal_companies := dataset(ut.foreign_logs + '~thor10_11::in::internal_company', {string product_id, string company_id, string internal_flag}, csv(separator('~~'), quote('')));

  export inquiry_info_appends := dataset([
													{'APPEND','4988231','1','1','10000000000'},
													{'APPEND','4988341','1','1','10000000000'},
													{'APPEND','8175241','1','1','10000000000'},
													{'APPEND','8099721','1','1','10000000000'}
													], 
													{string inquiry_tracking_id, string gc_id, string disable_observation, string opt_out, string content, string company_id := ''});

	export raw_bi_attributes := dataset(ut.foreign_logs + '~thor10_11::in::mbs::bi_attribute', 
																						{string sub_acct_id,
																						string sub_acct_name,
																						string web_subscrp_id,
																						string web_subscrp_name,
																						string Allow_Inquiry_Observation,
																						string Customer_Inquiry_Opt_Out,
																						string allow_fraud_detection,
																						string allow_id_verification,
																						string allow_authentication,
																						string allow_credit_risk,
																						string allow_insurance,
																						string allow_collections,
																						string allow_le,
																						string allow_marketing,
																						string allow_emp_screening,
																						string allow_tenant_screening}, csv(separator(','), quote('"'), terminator(['\n','\r\n'])));

	export bi_attributes := project(raw_bi_attributes(sub_acct_name <> 'sub_acct_name'), 
								transform(recordof(inquiry_info_appends),
									self.disable_observation := map(left.Allow_Inquiry_Observation in ['y','Y'] => '0','1');
									self.opt_out := map(left.Customer_Inquiry_Opt_Out in ['y','Y'] => '1','0');
									self.inquiry_tracking_id := 'DAYTON APPEND';
									self.gc_id := '';//'496741';
									self.company_id := left.sub_acct_id;
									self.content := map(left.allow_fraud_detection in ['N','n'] or 
																		  left.allow_id_verification in ['N','n'] or 
																		  left.allow_authentication in ['N','n'] or 
																		  left.allow_credit_risk in ['N','n'] or 
																		  left.allow_insurance in ['N','n'] or 
																		  left.allow_collections in ['N','n'] or 
																		  left.allow_le in ['N','n'] or 
																		  left.allow_marketing in ['N','n'] or 
																		  left.allow_emp_screening in ['N','n'] or 
																		  left.allow_tenant_screening in ['N','n'] => '0','1') + 
																	map(left.allow_fraud_detection in ['N','n'] => '0','1') +
																	map(left.allow_id_verification in ['N','n'] => '0','1') +
																	map(left.allow_authentication in ['N','n'] => '0','1') +
																	map(left.allow_credit_risk in ['N','n'] => '0','1') +
																	map(left.allow_insurance in ['N','n'] => '0','1') +
																	map(left.allow_collections in ['N','n'] => '0','1') +
																	map(left.allow_le in ['N','n'] => '0','1') +
																	map(left.allow_marketing in ['N','n'] => '0','1') +
																	map(left.allow_emp_screening in ['N','n'] => '0','1') +
																	map(left.allow_tenant_screening in ['N','n'] => '0','1')));	

	export inquiry_info_full := bi_attributes + inquiry_info_appends + 
												 dataset(ut.foreign_logs + '~thor10_11::in::inquiry_info', 
															{string inquiry_tracking_id, string gc_id, string disable_observation, string opt_out, string content, string company_id := ''}, csv(separator('~~'), quote(''), heading(1)));
																	
	export raw_bi_accounts := dataset(ut.foreign_logs + '~thor10_11::in::mbs::bi_account', 
																						{string company_id,
																						string mbs_company_name,
																						string mbs_primary_market_code,
																						string prim_mkt_descr,
																						string mbs_secondary_market_code,
																						string secndry_mkt_descr,
																						string mbs_industry_code_1,
																						string industry1_descr,
																						string mbs_industry_code_2,
																						string industry2_descr}, csv(separator(','), quote('"'), terminator(['\n','\r\n'])));
	
	export company_info := dataset(ut.foreign_logs + '~thor10_11::in::company_info',
													{string product_id, string gc_id, string company_id, string billing_id, string mbs_company_name, string company_status, string mbs_primary_market_code, string mbs_secondary_market_code, string mbs_industry_code_1, string mbs_industry_code_2},
													csv(separator('~~'), quote(','), heading(1)));
	
	export bi_accounts := project(raw_bi_accounts,
																transform(recordof(company_info),
																						self.gc_id := '';//'496741';
																						self.billing_id := '';
																						self.product_id := '';
																						self.company_status := 'DAYTON BI ACCOUNTS APPEND - 1216650 496741';
																						self := left));
	
	export company_info_full := company_info + bi_accounts;
	
	export batchr3_codes := inquiry_acclogs.File_BatchR3_Codes;

																						
end;