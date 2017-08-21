import Accurint_AccLogs, ut;

export Append_MBS_Fields := module

	export AccurintLogs(string version = ut.GetDate, dataset(recordof(Inquiry_AccLogs.File_Accurint_Logs)) inFile = Inquiry_AccLogs.File_Accurint_Logs) := function
		
			jCompanyInfo := join(inFile, Inquiry_AccLogs.File_Lookups.company_info, 
										left.orig_company_id = right.company_id,
										transform({recordof(inFile), recordof(Inquiry_AccLogs.File_Lookups.company_info) - company_id},
													self.gc_id := right.gc_id,
													self.billing_id := right.billing_id,
													self.product_id := right.product_id,
													self := left,
													self := right), lookup, left outer);

			jTaxExempt := join(jCompanyInfo, Inquiry_AccLogs.File_Lookups.tax_exempt,
													left.gc_id = right.gc_id,
										transform({recordof(jCompanyInfo), recordof(Inquiry_AccLogs.File_Lookups.tax_exempt) - gc_id},
														self := left,
														self := right), lookup, left outer);	
													
			jCompanyExt := join(jTaxExempt, Inquiry_AccLogs.File_Lookups.company_ext,
													left.gc_id = right.gc_id,
										transform({recordof(jTaxExempt), recordof(Inquiry_AccLogs.File_Lookups.company_ext) - gc_id},
														self := left,
														self := right), lookup, left outer);	

			jRevenueDesc := join(jCompanyExt, Inquiry_AccLogs.File_Lookups.revenue_desc,
													left.billing_id = right.billing_id,
										transform({recordof(jCompanyExt), recordof(Inquiry_AccLogs.File_Lookups.revenue_desc) - [product_id,billing_id]},
														self := left,
														self := right), lookup, left outer);	

			jTransactionDesc := join(jRevenueDesc, Inquiry_AccLogs.File_Lookups.transaction_desc,
														stringlib.stringtouppercase(left.orig_function_name) = stringlib.stringtouppercase(right.function_name) and
														stringlib.stringtouppercase(left.orig_transaction_type) = stringlib.stringtouppercase(right.transaction_type),
										transform({recordof(jRevenueDesc), recordof(Inquiry_AccLogs.File_Lookups.transaction_desc) - [function_name, transaction_type, product_id]},
														self := left,
														self := right), lookup, left outer);	
	
			prep_user0 := jTransactionDesc(orig_login_history_id = '0');
			jUser0 := join(prep_user0, Inquiry_AccLogs.File_Lookups.user_info, 
											left.orig_loginid = right.login_id and
											left.orig_company_id = right.company_id,
										transform({recordof(jTransactionDesc), recordof(Inquiry_AccLogs.File_Lookups.user_info) - [product_id, company_id, login_id]},
											self := left,
											self := right), lookup, left outer);
											
			prep_user1 := jTransactionDesc(orig_login_history_id > '0');
			jUser1 := join(prep_user1, Inquiry_AccLogs.File_Lookups.user_info, 
											left.orig_billing_code = right.login_id and
											left.orig_company_id = right.company_id,
										transform({recordof(jTransactionDesc), recordof(Inquiry_AccLogs.File_Lookups.user_info) - [product_id, company_id, login_id]},
											self := left,
											self := right), lookup, left outer);
											
			jUserInfo := jUser0 + jUser1;

			jCodeInfo_IndCode1 := join(jUserInfo, Inquiry_AccLogs.File_Lookups.code_info(regexfind('industry_code_1',column_name, nocase)),
																			left.industry_code_1 = right.code,
																		transform({recordof(jUserInfo), string industry_code_1_desc},
																			self.industry_code_1_desc := right.description,
																			self := left), lookup, left outer);

			jCodeInfo_IndCode2 := join(jCodeInfo_IndCode1, Inquiry_AccLogs.File_Lookups.code_info(regexfind('industry_code_2',column_name, nocase)),
																			left.industry_code_2 = right.code,
																		transform({recordof(jCodeInfo_IndCode1), string industry_code_2_desc},
																			self.industry_code_2_desc := right.description,
																			self := left), lookup, left outer);

			jCodeInfo_PMkt := join(jCodeInfo_IndCode2, Inquiry_AccLogs.File_Lookups.code_info(regexfind('primary_market_code',column_name, nocase)),
																			left.primary_market_code = right.code,
																		transform({recordof(jCodeInfo_IndCode2), string primary_market_code_desc},
																			self.primary_market_code_desc := right.description,
																			self := left), lookup, left outer);

			jCodeInfo_SMkt := join(jCodeInfo_PMkt, Inquiry_AccLogs.File_Lookups.code_info(regexfind('secondary_market_code',column_name, nocase)),
																			left.secondary_market_code = right.code,
																		transform({recordof(jCodeInfo_PMkt), string secondary_market_code_desc},
																			self.secondary_market_code_desc := right.description,
																			self := left), lookup, left outer);

			jCodeInfo_Exempt := join(jCodeInfo_SMkt, Inquiry_AccLogs.File_Lookups.code_info(regexfind('exempt_status',column_name, nocase)),
																			left.exempt_status = right.code,
																		transform({recordof(jCodeInfo_SMkt), string exempt_status_desc},
																			self.exempt_status_desc := right.description,
																			self := left), lookup, left outer);
																			
			InquiryInfo := table(Inquiry_AccLogs.File_Lookups.inquiry_info, {gc_id, disable_observation, opt_out, content},
																			gc_id, disable_observation, opt_out, content, few);
			
			jInquiryInfo := join(jCodeInfo_Exempt, InquiryInfo,
																			left.gc_id = right.gc_id, lookup, left outer);
			
			jUniqueID := join(jInquiryInfo, inquiry_acclogs.File_UniqueID(valuecnt = 1),
																			stringlib.stringtouppercase(left.orig_function_name) =  stringlib.stringtouppercase(right.function_name) and
																			stringlib.stringtouppercase(left.orig_transaction_type) =  stringlib.stringtouppercase(right.transaction_type),
																		transform({recordof(jInquiryInfo), string unique_id_code},
																			self.unique_id_code := right.unique_id_code;
																			self := left), lookup, left outer);
	
	
	return sequential(fileservices.startsuperfiletransaction();
												fileservices.clearsuperfile('~thor100_21::in::accurint_acclog::mbs'),
												output(jUniqueID,,'~thor100_21::in::accurint_acclog::'+version+'::mbs', overwrite),
												fileservices.addsuperfile('~thor100_21::in::accurint_acclog::mbs','~thor10_11::in::accurint_acclog::'+version+'::mbs'),
											fileservices.finishsuperfiletransaction());
	end;


end;

