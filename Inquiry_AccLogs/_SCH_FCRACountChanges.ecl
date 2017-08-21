//use dates from the *comprehensive_table_companyids files' names you want to compare
//if a date is unknown leave blank. it will choose the most recent and previous on its own.
//run from any thor. ok to read across, no pii data with customer information

old_date_in := ''; 
new_date_in := '';
 
filelist := sort(nothor(fileservices.LogicalFileList('thor20_11::out::inquiry_acclogs::fcra::*::comprehensive_table_companyids',,,,'10.173.231.12')), -name);

filelist_first := filelist[1].name;
filelist_second := filelist[2].name;

new_date := if(new_date_in = '', filelist_first[stringlib.stringfind(filelist_first, '::', 4) + 2..stringlib.stringfind(filelist_first, '::', 5)-1], new_date_in);
old_date := if(old_date_in = '', filelist_second[stringlib.stringfind(filelist_second, '::', 4) + 2..stringlib.stringfind(filelist_second, '::', 5)-1], old_date_in);

#WORKUNIT('name','FCRA Weekly History Changes')

layout := RECORD
  string global_company_id;
  string company_id;
  string4 transaction_datey;
  string2 transaction_datem;
  string2 transaction_dated;
  string stat_type;
  string industry;
  string vertical;
  string sub_market;
  string use;
  string product;
  string source;
  string product_code;
  string fcra_permissions;
  string glb_permissions;
  string dppa_permissions;
  string has_ssn;
  string has_email;
  string has_ein;
  string has_dob;
  string has_address;
  string has_phone;
  string has_adl;
  string has_bdid;
  boolean opt_out;
  integer8 cnt;
 END;

comp_new := distribute(dataset(ut.foreign_fcra_logs + 'thor100_21::out::inquiry_acclogs::'+new_date+'::comprehensive_table_companyids', layout, csv(separator('\t'))), hash(transaction_datey, transaction_datem, transaction_dated, product, global_company_id, company_id));//(transaction_datey = '2012' and transaction_datem in ['08','05']);
comp_old := distribute(dataset(ut.foreign_fcra_logs + 'thor100_21::out::inquiry_acclogs::'+old_date+'::comprehensive_table_companyids', layout, csv(separator('\t'))), hash(transaction_datey, transaction_datem, transaction_dated, product, global_company_id, company_id));//(transaction_datey = '2012' and transaction_datem in ['08','05']);

tcomp_new := table(comp_new, {file := 'new', transaction_datey, transaction_datem, transaction_dated, product, global_company_id, company_id, product_code, industry, vertical, sub_market, opt_out, s := sum(group, cnt)},
															 transaction_datey, transaction_datem, transaction_dated, product, global_company_id, company_id, product_code, industry, vertical, sub_market, opt_out, local);
tcomp_old := table(comp_old, {old_file := 'old', old_transaction_datey := transaction_datey, old_transaction_dated := transaction_dated, old_transaction_datem := transaction_datem, old_product := product, old_global_company_id := global_company_id, old_company_id := company_id, old_product_code := product_code, old_industry := industry, old_vertical := vertical, old_sub_market := sub_market, old_opt_out := opt_out, old_s := sum(group, cnt)},
															 transaction_datey, transaction_datem, transaction_dated, product, global_company_id, company_id, product_code, industry, vertical, sub_market, local);

ucomp1 := join((tcomp_new)(global_company_id = '' and company_id <> ''), dedup(inquiry_acclogs.file_mbs.file(idflag <> 'GCID'), id, idflag, all), 
														left.product_code = right.product_id and left.company_id = right.id,
														transform({recordof(left), string company_id_finance := '', string banko_mn := '', string billing_id := ''},
														self.global_company_id := right.gc_id,
														self := left, self := right), left outer);

ucomp2 := join((tcomp_new)(company_id = '' and global_company_id <> ''), dedup(inquiry_acclogs.file_mbs.file(idflag = 'GCID'), id, idflag, all), 
														left.global_company_id = right.id,
														transform({recordof(left), string company_id_finance := '', string banko_mn := '', string billing_id := ''},
														self.company_id := map(right.company_id <> '' => right.company_id,
																									 right.company_id_finance <> '' => right.company_id_finance,
																									 right.billing_id <> '' => right.billing_id,
																									 right.banko_mn);
														self.product_code := right.product_id;
														self := left, self := right), left outer);
														
ucomp_new := ucomp1 + ucomp2 + project(tcomp_new(company_id <> '' and global_company_id <> ''), recordof(ucomp1));
// ucomp1;
// ucomp2;

ucomp1o := join((tcomp_old)(old_global_company_id = '' and old_company_id <> ''), dedup(inquiry_acclogs.file_mbs.file(idflag <> 'GCID'), id, product_id, all), 
														left.old_product_code = right.product_id and left.old_company_id = right.id,
														transform({recordof(left), string company_id_finance := '', string banko_mn := '', string billing_id := ''},
														self.old_global_company_id := right.gc_id,
														self := left, self := right), left outer);

ucomp2o := join((tcomp_old)(old_company_id = '' and old_global_company_id <> ''), dedup(inquiry_acclogs.file_mbs.file(idflag = 'GCID'), id, all), 
														left.old_global_company_id = right.id,
														transform({recordof(left), string company_id_finance := '', string banko_mn := '', string billing_id := ''},
														self.old_company_id := map(right.company_id <> '' => right.company_id,
																									 right.company_id_finance <> '' => right.company_id_finance,
																									 right.billing_id <> '' => right.billing_id,
																									 right.banko_mn);
														self.old_product_code := right.product_id;
														self := left, self := right), left outer);
														
ucomp_old := ucomp1o + ucomp2o + project(tcomp_old(old_company_id <> '' and old_global_company_id <> ''), recordof(ucomp1o));

jcomp := join(ucomp_new, ucomp_old, left.transaction_datey = right.old_transaction_datey and
														left.transaction_datem = right.old_transaction_datem and
														left.transaction_dated = right.old_transaction_dated and
														left.product = right.old_product and
														left.global_company_id = right.old_global_company_id and
														left.company_id = right.old_company_id and
														left.product_code = right.old_product_code, 
														full outer); // join by fields that are static

jcomp_status := project(jcomp, transform({unsigned change_status, string status_description, recordof(jcomp)},
																				  self.change_status := map(left.opt_out <> left.old_opt_out and left.file <> '' and left.old_file <> '' => ut.bit_set(0,1), ut.bit_set(0,0)) |
																												 map(left.s <> left.old_s and left.file <> '' and left.old_file <> '' => ut.bit_set(0,2), ut.bit_set(0,0)) |
																												 map(left.vertical <> left.old_vertical and left.file <> '' and left.old_file <> '' => ut.bit_set(0,3), ut.bit_set(0,0)) |
																												 map(left.industry <> left.old_industry and left.file <> '' and left.old_file <> '' => ut.bit_set(0,4), ut.bit_set(0,0)) |
																												 map(left.sub_market <> left.old_sub_market and left.file <> '' and left.old_file <> '' => ut.bit_set(0,5), ut.bit_set(0,0)) |
																												 map(left.old_file = '' => ut.bit_set(0,6), ut.bit_set(0,0)) |
																												 map(left.file = '' => ut.bit_set(0,7), ut.bit_set(0,0)) |
																												 map(left.company_id_finance + left.banko_mn + left.billing_id <> '' => ut.bit_set(0,8), ut.bit_set(0,0));
																					 self.status_description := trim(map(left.opt_out <> left.old_opt_out and left.file <> '' and left.old_file <> '' => 'OPT OUT CHANGE | ', '') +
																												 map(left.s <> left.old_s and left.file <> '' and left.old_file <> '' => 'RECORD COUNT CHANGE | ', '') +
																												 map(left.vertical <> left.old_vertical and left.file <> '' and left.old_file <> '' => 'VERTICAL CHANGE | ', '') +
																												 map(left.industry <> left.old_industry and left.file <> '' and left.old_file <> '' => 'INDUSTRY CHANGE | ', '') +
																												 map(left.sub_market <> left.old_sub_market and left.file <> '' and left.old_file <> '' => 'SUB MARKET CHANGE | ', '') +
																												 map(left.old_file = '' => 'NEW | ', '') +
																												 map(left.file = '' => 'REMOVED | ', '') +
																												 map(left.company_id_finance + left.banko_mn + left.billing_id <> '' => 'ALTERNATIVE ID USED | ', ''), left, right);
																					self := left));

output(filelist, named('Comprehensive_Stat_Files_Available'));

output(jcomp_status,, 'out::inquiry_acclogs::'+old_date+'::'+new_date+'::comprehensive_table_comparison', named('Output_Results'), overwrite);
output(jcomp_status(status_description <> ''),, 'out::inquiry_acclogs::'+old_date+'::'+new_date+'::comprehensive_table_changes', named('Output_Results_Changes_Only_CSV'), overwrite, csv(heading(single), separator('\t')));

output(old_date + ' Compared to ' + new_date, named('Comp_Files_Used'));

output(comp_old, named('Old_Comp_Report_Sample'));
output(comp_new, named('New_Comp_Report_Sample'));

output(jcomp_status(status_description <> ''), named('Changes_Only_Sample'));
output(table(jcomp_status, {
										 Total_Records_New := sum(jcomp_status, s),
										 Total_Records_Old := sum(jcomp_status, old_s),
										 Total_Records_All := sum(jcomp_status, s)+sum(jcomp_status, old_s),
										 
										 OptOut_New := sum(jcomp_status(change_status & ut.bit_set(0,1) = ut.bit_set(0,1)), s),
										 OptOut_MinDt_New := min(jcomp_status(change_status & ut.bit_set(0,1) = ut.bit_set(0,1)), transaction_datey+ transaction_datem+ transaction_dated),
										 OptOut_MaxDt_New := max(jcomp_status(change_status & ut.bit_set(0,1) = ut.bit_set(0,1)), transaction_datey+ transaction_datem+ transaction_dated),
										 OptOut_Old := sum(jcomp_status(change_status & ut.bit_set(0,1) = ut.bit_set(0,1)), old_s),
										 OptOut_MinDt_Old := min(jcomp_status(change_status & ut.bit_set(0,1) = ut.bit_set(0,1)), old_transaction_datey+ old_transaction_datem+ old_transaction_dated),
										 OptOut_MaxDt_Old := max(jcomp_status(change_status & ut.bit_set(0,1) = ut.bit_set(0,1)), old_transaction_datey+ old_transaction_datem+ old_transaction_dated),
										 
										 RecordCount_New := sum(jcomp_status(change_status & ut.bit_set(0,2) = ut.bit_set(0,2)), s),
										 RecordCount_MinDt_New := min(jcomp_status(change_status & ut.bit_set(0,2) = ut.bit_set(0,2)), transaction_datey+ transaction_datem+ transaction_dated),
										 RecordCount_MaxDt_New := max(jcomp_status(change_status & ut.bit_set(0,2) = ut.bit_set(0,2)), transaction_datey+ transaction_datem+ transaction_dated),
										 RecordCount_Old := sum(jcomp_status(change_status & ut.bit_set(0,2) = ut.bit_set(0,2)), old_s),
										 RecordCount_MinDt_Old := min(jcomp_status(change_status & ut.bit_set(0,2) = ut.bit_set(0,2)), old_transaction_datey+ old_transaction_datem+ old_transaction_dated),
										 RecordCount_MaxDt_Old := max(jcomp_status(change_status & ut.bit_set(0,2) = ut.bit_set(0,2)), old_transaction_datey+ old_transaction_datem+ old_transaction_dated),
										 
										 Vertical_New := sum(jcomp_status(change_status & ut.bit_set(0,3) = ut.bit_set(0,3)), s),
										 Vertical_MinDt_New := min(jcomp_status(change_status & ut.bit_set(0,3) = ut.bit_set(0,3)), transaction_datey+ transaction_datem+ transaction_dated),
										 Vertical_MaxDt_New := max(jcomp_status(change_status & ut.bit_set(0,3) = ut.bit_set(0,3)), transaction_datey+ transaction_datem+ transaction_dated),
										 Vertical_Old := sum(jcomp_status(change_status & ut.bit_set(0,3) = ut.bit_set(0,3)), old_s),
										 Verticalt_MinDt_Old := min(jcomp_status(change_status & ut.bit_set(0,3) = ut.bit_set(0,3)), old_transaction_datey+ old_transaction_datem+ old_transaction_dated),
										 Vertical_MaxDt_Old := max(jcomp_status(change_status & ut.bit_set(0,3) = ut.bit_set(0,3)), old_transaction_datey+ old_transaction_datem+ old_transaction_dated),
										 
										 Industry_New := sum(jcomp_status(change_status & ut.bit_set(0,4) = ut.bit_set(0,4)), s),
										 Industry_MinDt_New := min(jcomp_status(change_status & ut.bit_set(0,4) = ut.bit_set(0,4)), transaction_datey+ transaction_datem+ transaction_dated),
										 Industry_MaxDt_New := max(jcomp_status(change_status & ut.bit_set(0,4) = ut.bit_set(0,4)), transaction_datey+ transaction_datem+ transaction_dated),
										 Industry_Old := sum(jcomp_status(change_status & ut.bit_set(0,4) = ut.bit_set(0,4)), old_s),
										 Industry_MinDt_Old := min(jcomp_status(change_status & ut.bit_set(0,4) = ut.bit_set(0,4)), old_transaction_datey+ old_transaction_datem+ old_transaction_dated),
										 Industry_MaxDt_Old := max(jcomp_status(change_status & ut.bit_set(0,4) = ut.bit_set(0,4)), old_transaction_datey+ old_transaction_datem+ old_transaction_dated),

										 SubMarket_New := sum(jcomp_status(change_status & ut.bit_set(0,5) = ut.bit_set(0,5)), s),
										 SubMarket_MinDt_New := min(jcomp_status(change_status & ut.bit_set(0,5) = ut.bit_set(0,5)), transaction_datey+ transaction_datem+ transaction_dated),
										 SubMarket_MaxDt_New := max(jcomp_status(change_status & ut.bit_set(0,5) = ut.bit_set(0,5)), transaction_datey+ transaction_datem+ transaction_dated),
										 SubMarket_Old := sum(jcomp_status(change_status & ut.bit_set(0,5) = ut.bit_set(0,5)), old_s),
										 SubMarket_MinDt_Old := min(jcomp_status(change_status & ut.bit_set(0,5) = ut.bit_set(0,5)), old_transaction_datey+ old_transaction_datem+ old_transaction_dated),
										 SubMarket_MaxDt_Old := max(jcomp_status(change_status & ut.bit_set(0,5) = ut.bit_set(0,5)), old_transaction_datey+ old_transaction_datem+ old_transaction_dated),

										 NewValues_New := sum(jcomp_status(change_status & ut.bit_set(0,6) = ut.bit_set(0,6)), s),
										 NewValues_MinDt_New := min(jcomp_status(change_status & ut.bit_set(0,6) = ut.bit_set(0,6)), transaction_datey+ transaction_datem+ transaction_dated),
										 NewValues_MaxDt_New := max(jcomp_status(change_status & ut.bit_set(0,6) = ut.bit_set(0,6)), transaction_datey+ transaction_datem+ transaction_dated),
										 NewValues_Old := sum(jcomp_status(change_status & ut.bit_set(0,6) = ut.bit_set(0,6)), old_s),
										 NewValues_MinDt_Old := min(jcomp_status(change_status & ut.bit_set(0,6) = ut.bit_set(0,6)), old_transaction_datey+ old_transaction_datem+ old_transaction_dated),
										 NewValues_MaxDt_Old := max(jcomp_status(change_status & ut.bit_set(0,6) = ut.bit_set(0,6)), old_transaction_datey+ old_transaction_datem+ old_transaction_dated),

										 RemovedValues_New := sum(jcomp_status(change_status & ut.bit_set(0,7) = ut.bit_set(0,7)), s),
										 RemovedValues_MinDt_New := min(jcomp_status(change_status & ut.bit_set(0,7) = ut.bit_set(0,7)), transaction_datey+ transaction_datem+ transaction_dated),
										 RemovedValues_MaxDt_New := max(jcomp_status(change_status & ut.bit_set(0,7) = ut.bit_set(0,7)), transaction_datey+ transaction_datem+ transaction_dated),
										 RemovedValues_Old := sum(jcomp_status(change_status & ut.bit_set(0,7) = ut.bit_set(0,7)), old_s),
										 RemovedValues_MinDt_Old := min(jcomp_status(change_status & ut.bit_set(0,7) = ut.bit_set(0,7)), old_transaction_datey+ old_transaction_datem+ old_transaction_dated),
										 RemovedValues_MaxDt_Old := max(jcomp_status(change_status & ut.bit_set(0,7) = ut.bit_set(0,7)), old_transaction_datey+ old_transaction_datem+ old_transaction_dated),

										 AlternativeIDUsed_New := sum(jcomp_status(change_status & ut.bit_set(0,8) = ut.bit_set(0,8)), s),
										 AlternativeIDUsed_MinDt_New := min(jcomp_status(change_status & ut.bit_set(0,8) = ut.bit_set(0,8)), transaction_datey+ transaction_datem+ transaction_dated),
										 AlternativeIDUsed_MaxDt_New := max(jcomp_status(change_status & ut.bit_set(0,8) = ut.bit_set(0,8)), transaction_datey+ transaction_datem+ transaction_dated),
										 AlternativeIDUsed_Old := sum(jcomp_status(change_status & ut.bit_set(0,8) = ut.bit_set(0,8)), old_s),
										 AlternativeIDUsed_MinDt_Old := min(jcomp_status(change_status & ut.bit_set(0,8) = ut.bit_set(0,8)), old_transaction_datey+ old_transaction_datem+ old_transaction_dated),
										 AlternativeIDUsed_MaxDt_Old := max(jcomp_status(change_status & ut.bit_set(0,8) = ut.bit_set(0,8)), old_transaction_datey+ old_transaction_datem+ old_transaction_dated)

										}, 'a', few), named('Change_Summary'));