/*2014-05-19T23:33:15Z (Wendy Ma)
bug# 154665
*/
import ut, Data_Services;

/* Recreation of MBS on thor. New Files uploaded daily. 1 version of file saved in fathered super.  */

export File_MBS_Prod:= module

export File := dataset(Data_Services.foreign_logs + 'thor100_21::out::inquiry_acclogs::file_mbs', Inquiry_Acclogs.Layout_MBS, thor);

export CreateFile(string param_version = ut.GetDate) := function

cinfo := dedup(inquiry_acclogs.file_lookups.company_info_full, all);
iinfo := dedup(inquiry_acclogs.file_lookups.inquiry_info_full, all); 
ninfo := dedup(inquiry_acclogs.file_lookups.internal_companies, all);
binfo := dedup(inquiry_acclogs.file_lookups.batchr3_codes, all);
finfo := dedup(inquiry_acclogs.file_lookups.finance_table, all); 

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
											self.gc_id := map(left.gc_id <> '' => left.gc_id, right.gc_id),
											self := right, self := left),
											left outer), record), record);

jn4A3 := dedup(sort(join(jn4A2(sub_acct_id = ''), finfo,  
											t(left.company_id) =  t(right.sub_acct_id) and  t(right.product_id) = '',
											transform(recordof(jn4A1), 
											self.product_id := map(left.product_id <> '' => left.product_id, right.product_id),
											self.gc_id := map(left.gc_id <> '' => left.gc_id, right.gc_id),
											self := right, self := left),
											left outer), record), record);
									
AllMBSFiles := dedup(sort(jn4A1(sub_acct_id <> '') + jn4A2(sub_acct_id <> '') + jn4A3, record), record); 

jnFIN := join(AllMBSFiles, finfo, left.sub_acct_id = right.sub_acct_id, 
								transform(recordof(jn4A3), self :=right, self := []), right only);

AllFiles := distribute(jnFin + AllMBSFiles, random());


FlagHealthcareCIDs := JOIN(AllFiles, Inquiry_Acclogs.File_Lookups.HealthcareCIDs, 
													 LEFT.product_id = RIGHT.product_id AND LEFT.company_id = RIGHT.company_id,
													 TRANSFORM({RECORDOF(AllFiles)}, SELF.disable_observation := MAP(RIGHT.disable_observation = '1' => '1', LEFT.disable_observation),
																													 SELF := LEFT),
													 LEFT OUTER, LOOKUP);

//flag healthcare products with sub_product_id = '70008' from mbs table
FlagHealthcareSubProductIDs := JOIN(FlagHealthcareCIDs, Inquiry_Acclogs.File_Lookups.HealthcareSubProductIDs, 
													 LEFT.product_id = RIGHT.product_id and LEFT.gc_id = RIGHT.gc_id,
													 TRANSFORM({RECORDOF(AllFiles)}, SELF.disable_observation := MAP(RIGHT.disable_observation = '1' => '1', LEFT.disable_observation),
													 SELF := LEFT),
													 LEFT OUTER, LOOKUP);

NormAllFiles := dedup(sort(normalize(FlagHealthcareSubProductIDs, 6, transform(Inquiry_AccLogs.Layout_MBS, 
																									self.IDFlag := choose(counter, 'GCID','CID','BID','MNID','SID','PID'); //PID is batchR3 only
																									self.ID := choose(counter, 
																																		left.gc_id, 
																																		left.company_id, 
																																		left.billing_id, 
																																		map(left.Banko_MN[1..2] in ['RW','ST','DI'] => left.Banko_MN[3..], left.Banko_MN),  
																																		left.company_id_finance,
																																		left.pid);
																									
																									self.vertical := Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.vertical);
																									self.market := Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.market);
																									self.sub_market := Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.sub_market);
																									self.industry := Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.industry);
																									self.use := Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.use);
																									self.mbs_primary_market_code := Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.mbs_primary_market_code);
																									self.mbs_secondary_market_code := Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.mbs_secondary_market_code);
																									self.mbs_industry_code_1 := Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.mbs_industry_code_1);
																									self.mbs_industry_code_2 := Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.mbs_industry_code_2);
																									self.primary_market_code := Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.primary_market_code);
																									self.secondary_market_code := Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.secondary_market_code);
																									self.industry_code_1 := Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.industry_code_1);
																									self.industry_code_2 := Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.industry_code_2);
																									self.mbs_company_name := Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.mbs_company_name);
																									self.cust_name := Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.cust_name);
																									self.acct_name := Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.acct_name);
																									self.platform := Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.platform);	
																									
																									self.internal_flag := MAP(left.company_id = '1476744' and left.product_id = '1' => '', 
																																						left.company_id in ['1321235','1521075'] and left.product_id = '1' => 'Y',
																																						left.internal_flag);

																									self.product_id := if(left.co_cd = '' and left.product_id = '', '1', left.product_id);

																									self.hash_id := Inquiry_AccLogs.fnHashIDField(self.id);
																									self.hash_gc_id := Inquiry_AccLogs.fnHashIDField(left.gc_id);
																									self.hash_company_id := Inquiry_AccLogs.fnHashIDField(left.company_id);
																									self.hash_billing_id := Inquiry_AccLogs.fnHashIDField(left.billing_id);
																									self.hash_banko_mn := Inquiry_AccLogs.fnHashIDField(map(left.Banko_MN[1..2] in ['RW','ST','DI','SI','CP'] => left.Banko_MN[3..], left.Banko_MN));
																									self.hash_company_id_finance := Inquiry_AccLogs.fnHashIDField(left.company_id_finance);
																									self.hash_pid := Inquiry_AccLogs.fnHashIDField(left.pid);

																									chkVal := left.inquiry_tracking_id + self.internal_flag + left.disable_observation;
																									
																									self.allowflags := 
																									if((unsigned)chkVal = 0 and chkVal = '' and 
																											self.sub_market not in inquiry_acclogs.fnCleanFunctions.SubMarket_FilterCds and
																											self.vertical not in inquiry_acclogs.fnCleanFunctions.FilterCds and
																											 ~regexfind(inquiry_acclogs.fnCleanFunctions.FilterCds_extra,self.vertical) and  
																											self.industry not in inquiry_acclogs.fnCleanFunctions.Industry_FilterCds and 
																											~(self.industry in ['', '[BLANK]'] and (regexfind(inquiry_acclogs.fnCleanFunctions.healthcare_FilterCds_extra,self.mbs_company_name)
																											or regexfind(inquiry_acclogs.fnCleanFunctions.healthcare_FilterCds_extra,self.acct_name)
																											or regexfind(inquiry_acclogs.fnCleanFunctions.healthcare_FilterCds_extra,self.cust_name))),	
																											ut.bit_set(0,1) | ut.bit_set(0,13), // no restrictions true , opt-out true is default
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
																										map(left.disable_observation = '1' or (left.product_id = '1' and left.company_id in Inquiry_AccLogs.File_Lookups.set_BridgerDisable) => ut.bit_set(0,12), ut.bit_set(0,0))| //0 - enable observation/ 1 - disable observation
																										map(left.opt_out = '1' or left.company_id in Inquiry_AccLogs.File_Lookups.set_BridgerDisable  => ut.bit_set(0,13), ut.bit_set(0,0)) |
																										map(left.internal_flag in ['Y','y'] and left.gc_id <> '8135331' => ut.bit_set(0,14), ut.bit_set(0,0)) |
																										// map( => ut.bit_set(0,15), ut.bit_set(0,0)) | // details in phase 3 - not completed
																										// map( => ut.bit_set(0,16), ut.bit_set(0,0)) | // details in phase 3 - not completed
																										map(self.vertical in inquiry_acclogs.fnCleanFunctions.FilterCds => ut.bit_set(0,17), ut.bit_set(0,0)) |
																										map(regexfind(inquiry_acclogs.fnCleanFunctions.FilterCds_extra,self.vertical,nocase) => ut.bit_set(0,17), ut.bit_set(0,0)) |
																										map(self.industry in inquiry_acclogs.fnCleanFunctions.Industry_FilterCds => ut.bit_set(0,18), ut.bit_set(0,0)) |
																										map(self.sub_market in inquiry_acclogs.fnCleanFunctions.SubMarket_FilterCds => ut.bit_set(0,19), ut.bit_set(0,0))|
																										map((regexfind(inquiry_acclogs.fnCleanFunctions.healthcare_FilterCds_extra,self.mbs_company_name)
																											or regexfind(inquiry_acclogs.fnCleanFunctions.healthcare_FilterCds_extra,self.acct_name)
																											or regexfind(inquiry_acclogs.fnCleanFunctions.healthcare_FilterCds_extra,self.cust_name)) and 
																										self.industry in ['', '[BLANK]'] => ut.bit_set(0,20), ut.bit_set(0,0))
																										) //opt out of raw data reporting
																										;
																									self.translation := inquiry_acclogs.fnTranslations.allowflags_str(self.allowflags);

																									self := left))((unsigned)ID <> 0), record), record);

normalize_hash_id := normalize(NormAllFiles, 2, transform(Inquiry_AccLogs.Layout_MBS,
														self.id := choose(counter, left.id, left.hash_id);
														self := left));

getDateLastSeen := dedup(sort(join(normalize_hash_id, File, 
												left.id = right.id and left.idflag = right.idflag and 
												((left.product_id = right.product_id and left.company_id = right.company_id and left.company_id <> '') or
												 (left.gc_id = right.gc_id and left.gc_id <> '') or
												 (left.banko_mn = right.banko_mn and left.banko_mn <> '') or
												 (left.billing_id = right.billing_id and left.billing_id <> '') or
												 (left.sub_acct_id = right.sub_acct_id and left.sub_acct_id <> '')),
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
																		self.current := map(left.vertical = right.vertical and
																														 left.industry = right.industry and
																														 left.internal_flag = right.internal_flag and
																														 left.sub_market = right.sub_market and
																														 left.use = right.use and
																														 left.primary_market_code = right.primary_market_code and
																														 left.secondary_market_code = right.secondary_market_code and
																														 left.industry_code_1 = right.industry_code_1 and
																														 left.industry_code_2 = right.industry_code_2 and
																														 left.allowflags = right.allowflags => true, false); 
																														 // right.datelastseen <> '' => right.datelastseen, ut.GetDate);																		self.id := if(left.id <> '', left.id, right.id);
																		
																		self.id := if(left.id <> '', left.id, right.id);
																		self.idflag := if(left.idflag <> '', left.idflag, right.idflag);
																		self.product_id := if(left.product_id <> '', left.product_id, right.product_id);
																		self.gc_id := if(left.gc_id <> '', left.gc_id, right.gc_id);
																		self.company_id := if(left.company_id <> '', left.company_id, right.company_id);
																		self.billing_id := if(left.billing_id <> '', left.billing_id, right.billing_id);
																		self.banko_mn := if(left.banko_mn <> '', left.banko_mn, right.banko_mn);
																		self.company_id_finance := if(left.company_id_finance <> '', left.company_id_finance, right.company_id_finance);
																		self.pid := if(left.pid <> '', left.pid, right.pid);
																		self.id_source := if(left.id_source <> '', left.id_source, right.id_source);
																		self.sub_acct_id := if(left.sub_acct_id <> '', left.sub_acct_id, right.sub_acct_id);
																		self.co_cd := if(left.co_cd <> '', left.co_cd, right.co_cd);
																		self.vertical := if(left.vertical <> '', left.vertical, right.vertical);
																		self.market := if(left.market <> '', left.market, right.market);
																		self.sub_market := if(left.sub_market <> '', left.sub_market, right.sub_market);
																		self.industry := if(left.industry <> '', left.industry, right.industry);
																		self.use := if(left.use <> '', left.use, right.use);
																		self.mbs_primary_market_code := if(left.mbs_primary_market_code <> '', left.mbs_primary_market_code, right.mbs_primary_market_code);
																		self.mbs_secondary_market_code := if(left.mbs_secondary_market_code <> '', left.mbs_secondary_market_code, right.mbs_secondary_market_code);
																		self.mbs_industry_code_1 := if(left.mbs_industry_code_1 <> '', left.mbs_industry_code_1, right.mbs_industry_code_1);
																		self.mbs_industry_code_2 := if(left.mbs_industry_code_2 <> '', left.mbs_industry_code_2, right.mbs_industry_code_2);
																		self.primary_market_code := if(left.primary_market_code <> '', left.primary_market_code, right.primary_market_code);
																		self.secondary_market_code := if(left.secondary_market_code <> '', left.secondary_market_code, right.secondary_market_code);
																		self.industry_code_1 := if(left.industry_code_1 <> '', left.industry_code_1, right.industry_code_1);
																		self.industry_code_2 := if(left.industry_code_2 <> '', left.industry_code_2, right.industry_code_2);
																		self.disable_observation := if(left.disable_observation <> '', left.disable_observation, right.disable_observation);
																		self.opt_out := if(left.opt_out <> '', left.opt_out, right.opt_out);
																		self.content := if(left.content <> '', left.content, right.content);
																		self.allowflags := if(left.allowflags > 0 and left.id <> '', left.allowflags, right.allowflags);
																		self.translation := if(left.translation <> '', left.translation, right.translation);
																		self.internal_flag := if(left.internal_flag <> '', left.internal_flag, right.internal_flag);
																		self.mbs_company_name := if(left.mbs_company_name <> '', left.mbs_company_name, right.mbs_company_name);
																		self.cust_name := if(left.cust_name <> '', left.cust_name, right.cust_name);
																		self.acct_name := if(left.acct_name <> '', left.acct_name, right.acct_name);
																		self.platform := if(left.platform <> '', left.platform, right.platform);

																		self.hash_id := Inquiry_AccLogs.fnHashIDField(self.id);
																		self.hash_gc_id := Inquiry_AccLogs.fnHashIDField(self.gc_id);
																		self.hash_company_id := Inquiry_AccLogs.fnHashIDField(self.company_id);
																		self.hash_billing_id := Inquiry_AccLogs.fnHashIDField(self.billing_id);
																		self.hash_banko_mn := Inquiry_AccLogs.fnHashIDField(map(self.Banko_MN[1..2] in ['RW','ST','DI','SI','CP'] => self.Banko_MN[3..], self.Banko_MN));
																		self.hash_company_id_finance := Inquiry_AccLogs.fnHashIDField(self.company_id_finance);
																		self.hash_pid := Inquiry_AccLogs.fnHashIDField(self.pid);

																		self := left), full outer),
																		
																		id,
								 idflag,
								  hash_id,
								 product_id,
								 gc_id,
								 company_id,
								 billing_id,
								 banko_mn,
								 company_id_finance,
								 pid,
								 id_source,
								 sub_acct_id,
								 co_cd,
								 vertical,
								 market,
								 sub_market,
								 industry,
								 use,
								 mbs_primary_market_code,
								 mbs_secondary_market_code,
								 mbs_industry_code_1,
								 mbs_industry_code_2,
								 primary_market_code,
								 secondary_market_code,
								 industry_code_1,
								 industry_code_2,
								 disable_observation,
								 opt_out,
								 content,
								 allowflags,
								 translation,
								 internal_flag,
								 mbs_company_name,
								 cust_name,
								 acct_name,
								 platform,
								 hash_gc_id,
								 hash_company_id,
								 hash_billing_id,
								 hash_banko_mn,
								 hash_company_id_finance,
								 hash_pid,
								datelastseen,
								current,
							  -datelastseen), record, except datelastseen)((unsigned)id <> 0);
								
applysubset := join(getDateLastSeen, inquiry_acclogs.File_Lookups_UseSubset, 
											left.sub_acct_id = right.sub_acct_id,
											transform(recordof(getDateLastSeen), 
																self.use := if(right.sub_acct_id <> '', right.use, left.use);
																self.industry := if(right.sub_acct_id <> '', right.industry, left.industry);
																self := left), left outer)(co_cd <> 'ID');
																
current_versionA := fileservices.superfilecontents('~thor100_21::out::inquiry_acclogs::file_mbs')[1].name;
current_versionB := stringlib.stringfind(current_versionA, '::', 4);
current_version := current_versionA[current_versionB + 2..];
isCurrent := current_version = param_version;

return 
						output(applysubset,,'~thor100_21::out::inquiry_acclogs::file_mbs::' + param_version, overwrite, __compressed__);
 
																
end;
end;
