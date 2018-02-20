import ut, data_services;

/* Recreation of MBS on thor. New Files uploaded daily. 1 version of file saved in fathered super.  */

export File_MBS := module

export File := dataset(Data_Services.foreign_logs + 'thor10_11::out::inquiry_acclogs::file_mbs', Inquiry_Acclogs.Layout_MBS, thor);

export CreateFile(string param_version = ut.GetDate) := function

cinfo := inquiry_acclogs.file_lookups.company_info_full;
iinfo := inquiry_acclogs.file_lookups.inquiry_info_full;
ninfo := inquiry_acclogs.file_lookups.internal_companies;
binfo := inquiry_acclogs.file_lookups.batchr3_codes;
finfo := inquiry_acclogs.file_lookups.finance_table;

jn1 := dedup(join(cinfo, iinfo, 
									left.gc_id = right.gc_id and 
									map(right.company_id <> '' => left.company_id, '') = right.company_id, 
									full outer), record, all);

jn2 := dedup(join(jn1, ninfo(internal_flag in ['Y','y']), left.company_id = right.company_id and left.product_id = right.product_id, full outer), record, all);

jn3 := dedup(sort(join(jn2, binfo, left.gc_id = right.gc_id, full outer), record), record);

t(string field) := trim(stringlib.stringtouppercase(field), all);

jn4A1 := dedup(sort(join(jn3, finfo, 
											t(left.company_id) = t(right.company_id_finance) and  t(left.product_id) =  t(right.product_id),
											left outer), record), record);
jn4A2 := dedup(sort(join(jn4A1(sub_acct_id = ''), finfo,  
											t(left.billing_id) =  t(right.company_id_finance) and  t(left.product_id) =  t(right.product_id),
											transform(recordof(jn4A1), 
											self.product_id := map(left.product_id <> '' => left.product_id, right.product_id),
											self := right, self := left),
											left outer), record), record);
jn4A3 := dedup(sort(join(jn4A2(sub_acct_id = ''), finfo,  
											t(left.company_id) =  t(right.sub_acct_id) and  t(right.product_id) = '',
											transform(recordof(jn4A1), 
											self.product_id := map(left.product_id <> '' => left.product_id, right.product_id),
											self := right, self := left),
											left outer), record), record);
											
AllMBSFiles := dedup(sort(jn4A1(sub_acct_id <> '') + jn4A2(sub_acct_id <> '') + jn4A3, record), record); 

jnFIN := join(AllMBSFiles, finfo, left.sub_acct_id = right.sub_acct_id, 
								transform(recordof(jn4A3), self :=right, self := []), right only);

AllFiles := distribute(jnFin + AllMBSFiles, random());

fnCleanUp(string instring) := stringlib.stringfilterout(
																		regexreplace('^COLLECTION$',
																			trim(stringlib.stringcleanspaces(stringlib.stringtouppercase(instring)), left, right), 
																				'COLLECTIONS'),
																					'?');
																					
NormAllFiles := dedup(sort(normalize(AllFiles, 6, transform(Inquiry_AccLogs.Layout_MBS, 
																									self.IDFlag := choose(counter, 'GCID','CID','BID','MNID','SID','PID'); //PID is batchR3 only
																									self.ID := choose(counter, 
																																		left.gc_id, 
																																		left.company_id, 
																																		left.billing_id, 
																																		map(left.Banko_MN[1..2] in ['RW','ST','DI'] => left.Banko_MN[3..], left.Banko_MN),  
																																		left.company_id_finance,
																																		left.pid);
																									
																									self.vertical := fncleanup(left.vertical);
																									self.market := fncleanup(left.market);
																									self.sub_market := fncleanup(left.sub_market);
																									self.industry := fncleanup(left.industry);
																									self.use := fncleanup(left.use);
																									self.mbs_primary_market_code := fncleanup(left.mbs_primary_market_code);
																									self.mbs_secondary_market_code := fncleanup(left.mbs_secondary_market_code);
																									self.mbs_industry_code_1 := fncleanup(left.mbs_industry_code_1);
																									self.mbs_industry_code_2 := fncleanup(left.mbs_industry_code_2);
																									self.primary_market_code := fncleanup(left.primary_market_code);
																									self.secondary_market_code := fncleanup(left.secondary_market_code);
																									self.industry_code_1 := fncleanup(left.industry_code_1);
																									self.industry_code_2 := fncleanup(left.industry_code_2);
																									self.mbs_company_name := fncleanup(left.mbs_company_name);
																									self.cust_name := fncleanup(left.cust_name);
																									self.acct_name := fncleanup(left.acct_name);
																									self.platform := fncleanup(left.platform);	
																									
																									self.internal_flag := if(left.company_id = '1476744' and left.product_id = '1', '', left.internal_flag);

																									self.product_id := if(left.co_cd = '' and left.product_id = '', '1', left.product_id);

																									self.hash_id := Inquiry_AccLogs.fnHashIDField(self.id);
																									self.hash_gc_id := Inquiry_AccLogs.fnHashIDField(left.gc_id);
																									self.hash_company_id := Inquiry_AccLogs.fnHashIDField(left.company_id);
																									self.hash_billing_id := Inquiry_AccLogs.fnHashIDField(left.billing_id);
																									self.hash_banko_mn := Inquiry_AccLogs.fnHashIDField(map(left.Banko_MN[1..2] in ['RW','ST','DI','SI','CP'] => left.Banko_MN[3..], left.Banko_MN));
																									self.hash_company_id_finance := Inquiry_AccLogs.fnHashIDField(left.company_id_finance);
																									self.hash_pid := Inquiry_AccLogs.fnHashIDField(left.pid);

																									chkVal := left.inquiry_tracking_id;
																									
																									self.allowflags := 
																									if((unsigned)chkVal = 0 and chkVal = '', ut.bit_set(0,1) | ut.bit_set(0,13), // no restrictions true , opt-out true is default
																										map(left.content[1..1] = '1' => ut.bit_set(0,1), ut.bit_set(0,0)) | 	//inquiry_tracking~~Content~~1~~1~~1~~No Restrictions
																										map(left.content[2..2] = '1' => ut.bit_set(0,2), ut.bit_set(0,0)) | 	//inquiry_tracking~~Content~~2~~1~~1~~Fraud Prevention
																										map(left.content[3..3] = '1' => ut.bit_set(0,3), ut.bit_set(0,0)) |		//inquiry_tracking~~Content~~3~~1~~1~~ID Verification
																										map(left.content[4..4] = '1' => ut.bit_set(0,4), ut.bit_set(0,0)) |		//inquiry_tracking~~Content~~4~~1~~1~~Authentication
																										map(left.content[5..5] = '1' => ut.bit_set(0,5), ut.bit_set(0,0)) |		//inquiry_tracking~~Content~~5~~1~~1~~Credit Risk Management
																										map(left.content[6..6] = '1' => ut.bit_set(0,6), ut.bit_set(0,0)) |		//inquiry_tracking~~Content~~6~~1~~1~~Insurance Underwriting
																										map(left.content[7..7] = '1' => ut.bit_set(0,7), ut.bit_set(0,0)) |		//inquiry_tracking~~Content~~7~~1~~1~~Collections
																										map(left.content[8..8] = '1' => ut.bit_set(0,8), ut.bit_set(0,0)) |		//inquiry_tracking~~Content~~8~~1~~1~~Law Enforcement
																										map(left.content[9..9] = '1' => ut.bit_set(0,9), ut.bit_set(0,0)) |		//inquiry_tracking~~Content~~9~~1~~1~~Marketing
																										map(left.content[10..10] = '1' => ut.bit_set(0,10), ut.bit_set(0,0)) |	//inquiry_tracking~~Content~~10~~1~~1~~Employment Screening
																										map(left.content[11..11] = '1' => ut.bit_set(0,11), ut.bit_set(0,0)) |	//inquiry_tracking~~Content~~11~~1~~1~~Tenant Screening
																										map(left.disable_observation = '1' => ut.bit_set(0,12), ut.bit_set(0,0))| //0 - enable observation/ 1 - disable observation
																										map(left.opt_out = '1' => ut.bit_set(0,13), ut.bit_set(0,0))) //opt out of raw data reporting
																										;
																									self.translation := inquiry_acclogs.fnTranslations.allowflags_str(self.allowflags);

																									self := left))(ID <> ''), record), record, except IDFlag);

normalize_hash_id := normalize(NormAllFiles, 2, transform(Inquiry_AccLogs.Layout_MBS,
														self.id := choose(counter, left.id, left.hash_id);
														self := left));

getDateLastSeen := dedup(join(normalize_hash_id, File, 
												left.id = right.id and left.idflag = right.idflag and left.product_id = right.product_id,
												transform(Inquiry_AccLogs.Layout_MBS,
																		self.datelastseen := map(left.vertical = right.vertical and
																														 left.industry = right.industry and
																														 left.internal_flag = right.internal_flag and
																														 left.sub_market = right.sub_market and
																														 left.use = right.use and
																														 left.primary_market_code = right.primary_market_code and
																														 left.secondary_market_code = right.secondary_market_code and
																														 left.industry_code_1 = right.industry_code_1 and
																														 left.industry_code_2 = right.industry_code_2 and
																														 left.allowflags = right.allowflags and 
																														 right.datelastseen <> '' => right.datelastseen, ut.GetDate);
																		self.current := left.id <> '';
																		self := left), full outer), record, all)(id <> '');

current_versionA := fileservices.superfilecontents('~thor10_11::out::inquiry_acclogs::file_mbs')[1].name;
current_versionB := stringlib.stringfind(current_versionA, '::', 4);
current_version := current_versionA[current_versionB + 2..];
isCurrent := current_version = param_version;

return if(~isCurrent, 
						sequential(output(Getdatelastseen,,'~thor10_11::out::inquiry_acclogs::file_mbs::' + param_version, overwrite, __compressed__);
															  fileservices.promotesuperfilelist(['~thor10_11::out::inquiry_acclogs::file_mbs',
																																	 '~thor10_11::out::inquiry_acclogs::file_mbs_father'],
																																	 '~thor10_11::out::inquiry_acclogs::file_mbs::' + param_version)));
																
end;
end;
