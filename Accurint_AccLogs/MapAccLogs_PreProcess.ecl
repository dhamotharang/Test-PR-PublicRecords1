import Inquiry_AccLogs, ut;

export MapAccLogs_PreProcess := function

NullSet := ['NULL','null','UNKNOWN','unknown', 'UKNOWN', 'Null', ''];

inFile := Accurint_Acclogs.File_AccLogs_In(orig_source_code = '3' or (unsigned)orig_login_history_id > 0 or stringlib.stringtouppercase(orig_function_name) = 'DECONCOMPREPORT')
	;
	
//// join  mbs for gov and le only filters

			jMBSFilter := distribute(join(Inquiry_AccLogs.File_Lookups.company_ext,Inquiry_AccLogs.File_Lookups.company_info, 
								left.gc_id = right.gc_id, left outer)(stringlib.stringtouppercase(detail1) in ['GOV','LE']), random());


//// join to company info to retrieve global company id and customer company name

			jCompanyInfoExt := join(inFile, jMBSFilter(product_id = '1'), 
										left.orig_company_id = right.company_id,
										transform({recordof(inFile), recordof(jMBSFilter) - company_id},
													self.gc_id := right.gc_id,
													self.billing_id := right.billing_id,
													self.product_id := right.product_id,
													self := left,
													self := right), lookup)(stringlib.stringtouppercase(detail1) in ['GOV','LE']);

//// join to transactions to retrieve function full name

			jTransactionDesc := join(jCompanyInfoExt, Inquiry_AccLogs.File_Lookups.transaction_desc,
														stringlib.stringtouppercase(left.orig_function_name) = stringlib.stringtouppercase(right.function_name) and
														stringlib.stringtouppercase(left.orig_transaction_type) = stringlib.stringtouppercase(right.transaction_type),
										transform({recordof(jCompanyInfoExt), recordof(Inquiry_AccLogs.File_Lookups.transaction_desc) - [function_name, transaction_type, product_id]},
														self.orig_transaction_type := stringlib.stringtouppercase(left.orig_transaction_type);
														self.orig_function_name := stringlib.stringtouppercase(left.orig_function_name);
														self := left,
														self := right), lookup, left outer);	
														
//// join to user table to retrieve user name and status
	
			// prep_user1 := jTransactionDesc(orig_login_history_id > '0');
			jUserInfo := join(jTransactionDesc, Inquiry_AccLogs.File_Lookups.user_info, 
											stringlib.stringtouppercase(left.orig_billing_code) = stringlib.stringtouppercase(right.login_id) and
											left.orig_company_id = right.company_id,
										transform({recordof(jTransactionDesc), recordof(Inquiry_AccLogs.File_Lookups.user_info) - [product_id, company_id, login_id]},
											self := left,
											self := right), lookup, left outer);
											
//// join to claudio's function table - does not directly map with function names. his are different

			junique_id1 := join(jUserInfo, inquiry_acclogs.File_UniqueID(valuecnt = 1), 
											trim(stringlib.stringtouppercase(left.orig_function_name)) = trim(stringlib.stringtouppercase(right.long_name)),
										TRANSFORM({recordof(jUserInfo),
														string orig_ein,
														string orig_charter_nbr,
														string orig_ucc_nbr,
														string orig_filing_nbr,
														string orig_did,
														string orig_domain,
														string orig_dl},
											self.orig_ein 				:= map(right.unique_id_code in ['13','27'] => left.orig_unique_id, ''),
											self.orig_charter_nbr 		:= map(right.unique_id_code = '5' => left.orig_unique_id, ''),
											self.orig_ucc_nbr 			:= map(right.unique_id_code = '9' => left.orig_unique_id, ''),
											self.orig_filing_nbr 		:= map(right.unique_id_code in ['15','14','4']  => left.orig_unique_id, ''),
											self.orig_did 				:= map(right.unique_id_code = '29' => left.orig_unique_id, ''),
											self.orig_domain 			:= map(right.unique_id_code = '10' => left.orig_unique_id, ''),
											self.orig_dl 				:= map(right.unique_id_code = '11' => left.orig_unique_id, ''),
											self := LEFT), left outer, lookup);

			junique_id2 := join(junique_id1, inquiry_acclogs.File_UniqueID(valuecnt = 1), 
											stringlib.stringtouppercase(trim(left.description, all)) = 
											stringlib.stringtouppercase(trim(right.long_name, all)),
										TRANSFORM(recordof(junique_id1),
											self.orig_ein 				:= map(right.unique_id_code in ['13','27'] and left.orig_ein = '' 	=> left.orig_unique_id, left.orig_ein),
											self.orig_charter_nbr 		:= map(right.unique_id_code = '5' and left.orig_charter_nbr = '' 	=> left.orig_unique_id, left.orig_charter_nbr),
											self.orig_ucc_nbr 			:= map(right.unique_id_code = '9' and left.orig_ucc_nbr = '' 		=> left.orig_unique_id, left.orig_ucc_nbr),
											self.orig_filing_nbr 		:= map(right.unique_id_code in ['15','14','4'] and left.orig_filing_nbr = ''  => left.orig_unique_id, left.orig_filing_nbr),
											self.orig_did 				:= map(right.unique_id_code = '29' and left.orig_did = '' 			=> left.orig_unique_id, left.orig_did),
											self.orig_domain 			:= map(right.unique_id_code = '10' and left.orig_domain = '' 		=> left.orig_unique_id, left.orig_domain),
											self.orig_dl 				:= map(right.unique_id_code = '11' and left.orig_dl = '' 			=> left.orig_unique_id, left.orig_dl),
											self := LEFT), left outer, lookup);
											
prInFile := project(junique_id2,
							transform({Accurint_AccLogs.Layout_AccLogs},
																
								self.orig_User_CompanyName := left.mbs_company_name;
								self.orig_User_FirstName := left.first_name;
								self.orig_User_LastName := left.last_name;
								self.orig_searchdescription := left.description;
								self.orig_detail := left.detail1;
								self.orig_user_status := left.status;

									SET_UCC 		:= ['UCCSEARCHV2'];
									SET_DL 			:= ['DLREPORT2','DLSEARCH2'];//['ACCIDENTSEARCH','MVSEARCH','MVSEARCH2'] - removed per Jennifer;
									SET_CHART 	:= ['CORPREPORTV2'];
									SET_FEIN 		:= ['CORPSEARCHV2','ENHANCEDBUSSRCH','FEINSEARCH','LIENSEARCH','ROLLBUSSEARCH','UCCSEARCHV2'];
									SET_LINKID 	:= ['ADDRHISTREPORT','BANKRUPTREPORT2','BANKRUPTREPORT3','BANKRUPTSEARCH','BANKRUPTSEARCH2','COURTSEARCH','CRIMREPORT',
																	'DEA_REGISTRATION','DEATHREPORT','DECONCOMPREPORT','FICTITIOUSBIZSRH','FORECLOSEREPORT','STATEWIDEDOCCNTS','PROVIDERREPORT','PROVIDERSEARCH',
																	'SANCTIONSEARCH','LIENREPORT','MDSEARCH2','MVREPORT','MVREPORT2','PEOPLEATWORKV2','PROFLICSEARCH2','PROPERTYREPORT2',
																	'PROPERTYSEARCH2','SEXOFFREPORT','UCCREPORTV2','WATERCRAFTRPT2','WATERCRAFTSRH2'];

									cat_dl 			:= map(stringlib.stringtouppercase(left.orig_function_name) in set_dl => left.orig_unique_id,
															stringlib.stringtouppercase(left.description) in set_dl => left.orig_unique_id, '');
									cat_chart 	:= map(stringlib.stringtouppercase(left.orig_function_name) in set_chart => 
																				regexreplace('^[A-Za-z0-9][A-Za-z0-9]-', trim(left.orig_unique_id, all), ''),
															stringlib.stringtouppercase(left.description) in set_chart => left.orig_unique_id, '');
									cat_fein 		:= map(stringlib.stringtouppercase(left.orig_function_name) in set_fein => left.orig_unique_id,
															stringlib.stringtouppercase(left.description) in set_fein => left.orig_unique_id, '');
									cat_linkid 	:= map(stringlib.stringtouppercase(left.orig_function_name) in set_linkid => left.orig_unique_id,
															stringlib.stringtouppercase(left.description) in set_linkid => left.orig_unique_id, '');
									cat_ucc			:= map(stringlib.stringtouppercase(left.orig_function_name) in set_ucc => left.orig_unique_id,
															stringlib.stringtouppercase(left.description) in set_ucc => left.orig_unique_id, '');
								
								self.orig_ucc_nbr := map(left.orig_ucc_nbr = '' => cat_ucc, left.orig_ucc_nbr);
								self.orig_ein			:= map(left.orig_ein = '' 			=> cat_fein, left.orig_ein),
								self.orig_charter_nbr	:= map(left.orig_charter_nbr = '' 	=> cat_chart, left.orig_charter_nbr),
								self.orig_did			:= map(left.orig_did = '' 			=> cat_linkid, left.orig_did),
								self.orig_dl			:= map(left.orig_dl = '' 			=> cat_dl, left.orig_dl),
								
								self := left));

return prInFile;																			
end;