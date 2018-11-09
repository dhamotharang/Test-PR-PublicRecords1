import ut,data_services;

/* Recreation of MBS on thor. New Files uploaded daily. 1 version of file saved in fathered super.  */
export File_MBS := module

export File := dataset(data_services.foreign_new_logs + 'thor100_21::out::inquiry_acclogs::file_mbs', inquiry_acclogs.layout_FIDO.new_MBS, thor);

export CreateFile(string param_version = ut.GetDate) := function

//apply filter on healthcare CIDs

FlagHealthcareCIDs := JOIN(inquiry_acclogs.file_FIDO, Inquiry_Acclogs.File_Lookups.HealthcareCIDs, 
													 (string)LEFT.mbs_product_id = RIGHT.product_id AND (string)LEFT.mbs_company_id = RIGHT.company_id,
													 TRANSFORM(inquiry_acclogs.Layout_FIDO.extract_out, 
													 SELF.disable_observation := MAP(RIGHT.disable_observation = '1' => '1', LEFT.disable_observation),
													 SELF := LEFT),
													 LEFT OUTER, LOOKUP);

df_fido_mbs := project(FlagHealthcareCIDs,
transform(inquiry_acclogs.layout_FIDO.new_MBS,
//self.product_id := if(left.hist_subaccount_id[1..3] = 'DYT', '1',trim((string)left.mbs_product_id,left,right));
self.product_id := trim((string)left.mbs_product_id,left,right);
self.sub_product_id := trim((string)left.mbs_sub_product_id,left,right);
self.gc_id := trim(if(left.mbs_gc_id != 0, (string)left.mbs_gc_id, left.hist_subaccount_id),left,right);
//self.company_id := trim(if(left.mbs_company_id != 0, (string)left.mbs_company_id, 
//if(left.hist_subaccount_id[1..3] = 'DYT',regexreplace('^[a-zA-Z]+|-',left.hist_subaccount_id,''), '')),left,right);
self.company_id := trim(if(left.mbs_company_id != 0,(string)left.mbs_company_id, ''),left,right);
self.sub_acct_id := trim(left.hist_subaccount_id,left,right);
self.primary_market_code := trim(left.primary_market_cd,left,right);
self.secondary_market_code := trim(left.secondary_market_cd,left,right);
self.vertical := trim(stringlib.stringtouppercase(left.abstracted_vertical_market),left,right);
self.market   := trim(stringlib.stringtouppercase(left.market),left,right);
self.sub_market := trim(stringlib.stringtouppercase(left.sub_market),left,right);
self.industry   := trim(stringlib.stringtouppercase(left.industry),left,right);
self.use        := trim(stringlib.stringtouppercase(left.use),left,right);
self.disable_observation := if(left.disable_observation = '1', '1', '0');
self.content := trim(left.content,left,right);
self.internal_flag := MAP(left.mbs_company_id = accounts_exclude.company_id_not_internal and left.mbs_product_id = 1 => '', 
left.mbs_company_id in accounts_exclude.set_company_id_internal and left.mbs_product_id = 1 => 'Y',
left.internal_flag = true => 'Y', '');
self.mbs_company_name := trim(stringlib.stringtouppercase(left.subaccount_name), left,right);
self.allowflags := 
																									
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
																										map(self.disable_observation = '1' or (left.mbs_product_id = 1 and self.company_id in Inquiry_AccLogs.File_Lookups.set_BridgerDisable) => ut.bit_set(0,12), ut.bit_set(0,0))| //0 - enable observation/ 1 - disable observation
																										map(left.opt_out = '1' or self.company_id in Inquiry_AccLogs.File_Lookups.set_BridgerDisable  => ut.bit_set(0,13), ut.bit_set(0,0)) |
																										map(self.internal_flag = 'Y' and self.gc_id <> accounts_exclude.gc_id_not_internal => ut.bit_set(0,14), ut.bit_set(0,0)) |
																										map(left.exclude_from_access = 1 => ut.bit_set(0,15), ut.bit_set(0,0)) |
																										map(self.vertical in inquiry_acclogs.fnCleanFunctions.FilterCds => ut.bit_set(0,17), ut.bit_set(0,0)) |
																										map(self.vertical = 'AUTO FINANCE' => ut.bit_set(0,0),
																												regexfind(inquiry_acclogs.fnCleanFunctions.FilterCds_extra,self.vertical,nocase) => ut.bit_set(0,17), ut.bit_set(0,0)) |
																										map(self.industry in inquiry_acclogs.fnCleanFunctions.Industry_FilterCds => ut.bit_set(0,18), ut.bit_set(0,0)) |
																										map(self.sub_market in inquiry_acclogs.fnCleanFunctions.SubMarket_FilterCds => ut.bit_set(0,19), ut.bit_set(0,0))|
																										map(regexfind(inquiry_acclogs.fnCleanFunctions.healthcare_FilterCds_extra,self.mbs_company_name) and 
																											~regexfind('VETERINARY',self.mbs_company_name) AND
																										self.industry in ['', 'BLANK','UNASSIGNED'] => ut.bit_set(0,20), ut.bit_set(0,0));
																										 //opt out of raw data reporting
																										allowflag_val := if(self.allowflags = 1, ut.bit_set(0,1), self.allowflags);
																										
																										self.translation := inquiry_acclogs.fnTranslations.allowflags_str(allowflag_val);
self.priority_flag := if(left.hist_subaccount_id = left.current_subaccount_id, 1, 0);
self.country := trim(stringlib.stringtouppercase(left.country),left,right);
self := left));
																									
df_fido_mbs_dist := distribute(df_fido_mbs(gc_id <> '' or company_id <> ''), hash(gc_id,company_id));
df_fido_mbs_dedup := dedup(sort(df_fido_mbs_dist,gc_id, company_id,product_id,sub_product_id,priority_flag,allowflags,local),
                     gc_id, company_id, product_id, sub_product_id, priority_flag,allowflags, local);
											
fido_stats := table(df_fido_mbs_dedup, {gc_id, company_id,product_id,sub_product_id,priority_flag, id_cnt := count(group)}, 
										gc_id, company_id,product_id,sub_product_id,priority_flag, few);
	pValidate_FIDO := if(count(fido_stats(id_cnt > 1)) > 1 or count(df_fido_mbs_dedup(sub_acct_id = '')) > 1, 
	FileServices.SendEmail(Email_Notification_Lists(param_version).fidostats,'FIDO has issues on logs thor '+ workunit ,'FIDO ID not unique' + failmessage)); 
	
	pValidate_subaccountID := if(count(df_fido_mbs_dedup(sub_acct_id = '')) > 1, 
	FileServices.SendEmail(Email_Notification_Lists(param_version).fidostats,'FIDO has issues on logs thor '+ workunit ,'FIDO subaccountID blank' + failmessage)); 
  
	Current:=nothor(fileservices.superfilecontents('~thor100_21::out::inquiry_acclogs::file_mbs'))[1].name[46..54];
  isCurrent:=param_version<=current;
	
mbs_new := sequential(output(df_fido_mbs_dedup, ,'~thor100_21::out::inquiry_acclogs::file_fido::' + param_version, overwrite, __compressed__),
											   fileservices.startsuperfiletransaction(),
											 
												 fileservices.clearsuperfile('~thor100_21::out::inquiry_acclogs::file_mbs_grandfather'),
												 fileservices.addsuperfile('~thor100_21::out::inquiry_acclogs::file_mbs_grandfather', '~thor100_21::out::inquiry_acclogs::file_mbs_father',,true),

												 fileservices.clearsuperfile('~thor100_21::out::inquiry_acclogs::file_mbs_father'),
												 fileservices.addsuperfile('~thor100_21::out::inquiry_acclogs::file_mbs_father', '~thor100_21::out::inquiry_acclogs::file_mbs',,true),
												 
												 fileservices.clearsuperfile('~thor100_21::out::inquiry_acclogs::file_mbs'),
												 fileservices.addsuperfile('~thor100_21::out::inquiry_acclogs::file_mbs', '~thor100_21::out::inquiry_acclogs::file_fido::' + param_version),
												 
											 fileservices.finishsuperfiletransaction();
											 output('MBS File Check', named('Quality_Check')),
											 output(table(df_fido_mbs_dedup, {vertical, cnt := count(group)}, vertical, few), all, named('Verticals')),
											 output(table(df_fido_mbs_dedup, {industry, cnt := count(group)}, industry, few), all, named('Industries')),
											 output(table(df_fido_mbs_dedup, {use, cnt := count(group)}, use, few), all, named('Uses')),
											 output(table(df_fido_mbs_dedup, {product_id, cnt := count(group)}, product_id, few), all, named('Product_IDs')),
											 output(df_fido_mbs_dedup(sub_acct_id = ''), named('subaccountID_blank')),
											 output(fido_stats(id_cnt > 1), named('multiple_allowflags')),
                       pValidate_FIDO,
											 pValidate_subaccountID);
																
return if(~isCurrent, mbs_new);

end;
end;



