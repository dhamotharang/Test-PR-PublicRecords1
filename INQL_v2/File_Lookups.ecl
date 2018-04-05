/*2014-05-22T17:19:41Z (Wendy Ma)
bug# 154665 add additional sub_product_id
*/
import ut, Data_Services;

export File_Lookups :=  module

	export sub_product := dataset(Data_Services.foreign_logs + 'thor100_21::in::sub_product', 
												{string gc_id, string status, string sub_product_id, string sub_product_code},
												 csv(separator('~~'), quote(''), heading(1)));
												 
	export code_info := dataset(Data_Services.foreign_logs + 'thor100_21::in::code_info', 
												{string table_name, string column_name, string code, string description},
												 csv(separator('~~'), quote(''), heading(1)));
	
	export company_ext := dataset(Data_Services.foreign_logs + 'thor100_21::in::company_ext', 
												{string gc_id, string ext_type, string cat_name, string detail1, string detail2}, 
												 csv(separator('~~'), quote(','), heading(1)));

	export moxie_function_desc := dataset(Data_Services.foreign_logs + 'thor100_21::in::moxie_function_desc', 
																{string transaction_type, string function_name, string search_description}, 
																 csv(separator('\t'), quote(','), heading(1)));
	
	export revenue_desc := dataset(Data_Services.foreign_logs + 'thor100_21::in::revenue_desc', 
													{string product_id, string billing_id, string mbs_market, string mbs_vertical, string mbs_sub_market, string status_updated, string top, string sales_household_name}, 
													 csv(separator('~~'), quote(','), heading(1)));
	
	export tax_exempt := dataset(Data_Services.foreign_logs + 'thor100_21::in::tax_exempt', 
												{string gc_id, string start_date, string end_date, string exempt_status, string is_active}, 
												 csv(separator('~~'), quote(','), heading(1)));
	
	export transaction_desc := dataset(Data_Services.foreign_logs + 'thor100_21::in::transaction_desc', 
															{string product_id, string transaction_type, string function_name, string description}, 
															 csv(separator('~~'), quote(','), heading(1)));
	
	export user_info := dataset(Data_Services.foreign_logs + 'thor100_21::in::user_info', 
												{string product_id, string company_id, string login_id, string first_name, string last_name, string status, string system_administrator}, 
												 csv(separator('~~'), quote(''), heading(1)));

	export position_code_info := project(dataset(Data_Services.foreign_logs + 'thor100_21::in::position_code_info', 
																	{string filler1, string filler2, string bitposition, string bitcode, string bitallowstatus, string bitallowdescr}, 
																	csv(separator('~~'), quote(''), heading(1))),
																transform({unsigned bitposition, string bitcode, string bitallowstatus, string bitallowdescr}, 
																				self.bitposition := (unsigned)left.bitposition;
																				self := left));
																				
	export prodr3_bankobatch_seqids := dataset('~thor20_11::in::banko_batch::sequence_to_pid', {string pid, string rid, string sequence_number}, csv(separator('\t')));
												
	raw_finance_table := project(dataset(Data_Services.foreign_logs + 'thor100_21::in::mbs::finance_master', INQL_v2.Layouts.MBS_Finance_update_, csv(separator('\t'), quote('"'))),
	transform(INQL_v2.Layouts.MBS_Finance_old_, //self.sub_acct_id := if(regexfind('[0-9]+', left.subaccount_id),left.subaccount_id, ''), 
	self.sub_acct_id := left.vcid, 
	self.attention_line := left.subaccount_id, self := left));

	//RW - riskwise, DI - Banko "Dolan", ST - Accurint "Seisint", LN - Dayton Leg, CP - Choicepoint Leg, PW - Peoplewise Leg, SD - Securint Leg																														
 export finance_table_ := project(raw_finance_table, transform(INQL_v2.Layouts.MBS_Finance_common,
																															self.hash_company_id_finance := INQL_v2.fnHashIDField(stringlib.stringtouppercase(if(regexfind('[a-zA-Z]', left.sub_acct_id[1..2]), 
																																											regexreplace('^[a-zA-Z]+',left.sub_acct_id,'') , left.sub_acct_id))),
																															self.company_id_finance := stringlib.stringtouppercase(if(regexfind('[a-zA-Z]', left.sub_acct_id[1..2]), 
																																											regexreplace('^[a-zA-Z]+',left.sub_acct_id,''), left.sub_acct_id)),
																															self.billing_id_finance := stringlib.stringtouppercase(if(regexfind('[a-zA-Z]', left.attention_line[1..3]), 
																																											regexreplace('^[a-zA-Z]+|-',left.attention_line,''), left.attention_line)),												
																															self.co_cd := stringlib.stringtouppercase(if(regexfind('[a-zA-Z]', left.attention_line[1..3]), 
																																							regexreplace('[^a-zA-Z]+',left.attention_line[..3],''),if(regexfind('[a-zA-Z]', left.sub_acct_id[1..2]), 
																																							regexreplace('[^a-zA-Z]+',left.sub_acct_id[..3],''),''))),
																															self.product_id := map(self.co_cd in  ['ACC', 'BRG','CRP', 'WCO'] => '1',
																															                       self.co_cd = 'RWS' => '2',
																															
																																										 self.co_cd = 'BNK' => '5',
																																										 self.co_cd in ['IDM', 'OKC',
																																										 'IDC', 'IQA', 'MFA', 'TRI', 'VCO','HCA','PRC']  => '7',
																																										//old co_cd
																																										self.co_cd = 'DI' => '5',
																																										 self.co_cd = 'IDM' => '7',
																																										 self.co_cd = 'ID' => '7',
																																										 self.co_cd = 'IDC' => '7',
																																										 self.co_cd = 'RW' => '2',
																																										 self.co_cd = 'ST' => '1', '');
																															self.industry := if(left.industry = '0', '', left.industry);
																															self := left));	
	

  export finance_table := INQL_v2.fn_patch_finance_table(finance_table_);
	
	export rw_searches := dataset(Data_Services.foreign_logs + 'thor100_21::in::rw_searches', 
																	{string function_name, string description, string is_fcra}, csv(separator('\t'), quote(''), heading(1)));

	export internal_companies := dataset(Data_Services.foreign_logs + 'thor100_21::in::internal_company', {string product_id, string company_id, string internal_flag}, csv(separator('~~'), quote(''),heading(1)));

  export inquiry_info_appends := dataset([
													{'APPEND','4988231','1','1','10000000000'},
													{'APPEND','4988341','1','1','10000000000'},
													{'APPEND','8175241','1','1','10000000000'},
													{'APPEND','8099721','1','1','10000000000'},
													{'APPEND','11579923','1','1','10000000000'},
													{'CHANGE','8116091','0','0','10000000000'},
													{'CHANGE','14068','0','0','10000000000'},
													{'CHANGE','14868','0','0','10000000000'},
													{'CHANGE','778061','0','0','10000000000'},
													{'CHANGE','888401','0','0','10000000000'},
													{'CHANGE','884781','0','0','10000000000'},
													{'CHANGE','6304661','0','0','10000000000'},
													{'CHANGE','8169881','0','0','10000000000'},
													{'CHANGE','8301272','0','0','10000000000'},
													{'CHANGE','985181','0','0','10000000000'}
													], 
													{string inquiry_tracking_id, string gc_id, string disable_observation, string opt_out, string content, string company_id := ''});

	export raw_bi_attributes := dataset(Data_Services.foreign_logs + 'thor100_21::in::mbs::bi_attribute', 
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

	export inquiry_info_full := dataset(Data_Services.foreign_logs + 'thor100_21::in::inquiry_info', 
															{string inquiry_tracking_id, string gc_id, string disable_observation, string opt_out, string content, string company_id := ''}, csv(separator('~~'), quote(''), heading(1)))
															(gc_id not in set(inquiry_info_appends, gc_id)) + bi_attributes + inquiry_info_appends;
																	
	export raw_bi_accounts := dataset(Data_Services.foreign_logs + 'thor100_21::in::mbs::bi_account', 
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
	
	export company_info := dataset(Data_Services.foreign_logs + 'thor100_21::in::company_info',
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
	
	export batchr3_codes := INQL_v2.File_BatchR3_Codes;
	
	export set_BridgerDisable := ['6047615','6180679','6181017','6181326','6181490','6182887','6209277','6232271','6181144','6184146','6398630','1600221','1600741','1588241','6181074','1604691','1523730','1467507','1586467','1522006'];

					lkup := DATASET([{'1','ST1474674'},
					{'1','ST1509305'},
					{'1','ST1509315'},
					{'1','ST1479594'},
					{'1','ST1486624'},
					{'1','ST1036754'},
					{'1','ST1011645'},
					{'1','ST1119040'},
					{'1','ST1005590'},
					{'1','ST1468447'},
					{'1','ST1561236'},
					{'1','ST1620687'},
					{'1','ST1356535'},
					{'1','ST1016951'},
					{'1','ST1007458'},
					{'1','ST1029850'},
					{'5','DI118642'},
					{'1','ST1016355'},
					{'1','ST1008640'},
					{'1','ST1409195'},
					{'1','ST1400060'},
					{'1','ST1456500'},
					{'1','ST1247441'},
					{'1','ST1346924'},
					{'1','ST1588561'},
					{'1','ST1013967'},
					{'1','ST1025230'},
					{'1','ST1535740'},
					{'1','ST1258654'},
					{'1','ST1172270'},
					{'1','ST1162980'},
					{'5','DI118242'},
					{'1','ST1554786'},
					{'1','ST1014654'},
					{'1','ST1475884'},
					{'1','ST1525826'},
					{'1','ST1126350'},
					{'1','ST1438930'},
					{'7','8508272'},
					{'1','ST1015431'},
					{'1','ST1520720'},
					{'1','ST1549906'},
					{'1','ST1549246'},
					{'1','ST1548916'},
					{'1','ST1026394'},
					{'1','ST1351184'},
					{'1','ST1607571'},
					{'1','ST1597491'},
					{'1','ST1538856'},
					{'1','ST1456500'},
					{'1','ST1397360'},
					{'1','ST1553235'},
					{'1','ST1622027'},
					{'1','ST1516630'},
					{'1','ST1007083'},
					{'1','ST1437620'},
					{'5','DI119026'},
					{'1','ST1542826'},
					{'1','ST1412815'},
					{'5','DI121492'},
					{'1','ST1005848'},
					{'5','DI118506'},
					{'1','ST1533156'},
					{'1','ST1347635'},
					{'1','ST1517196'},
					{'1','ST1539435'},
					{'1','ST1011472'},
					{'1','ST1205050'},
					{'1','ST1554576'},
					{'1','ST1511535'},
					{'1','ST1530776'},
					{'5','DI119216'},
					{'1','ST1011211'},
					{'1','ST1530166'},
					{'5','DI118722'},
					{'1','ST1022757'}], {string product_id, string sub_acct_id});

	EXPORT HealthcareCIDs :=  PROJECT(lkup, 
																		TRANSFORM({STRING PRODUCT_ID, STRING sub_acct_id, STRING company_id, STRING disable_observation},
																								SELF.company_id := MAP(LEFT.sub_acct_id[..2] in ['DI','ST'] => LEFT.sub_acct_id[3..], LEFT.sub_acct_id),
																								SELF.disable_observation := '1';
																								SELF := LEFT));
	
		SubProductid_filterCds := ['70002','70003','70006','70007','70008','70009']; 																		
	export HealthcareSubProductIDs := project(sub_product(sub_product_id in SubProductid_filterCds),
		                                TRANSFORM({STRING product_id, STRING gc_id, STRING status, STRING sub_product_id, STRING sub_product_code, STRING disable_observation},
																								SELF.product_id := '7'; SELF.disable_observation := '1';
																								SELF := LEFT));
end;