IMPORT ut, Data_Services;

#WORKUNIT('name','NonFCRA Weekly History Changes');

//use dates from the *comprehensive_table_companyids files' names you want to compare
//if a date is unknown leave blank. it will choose the most recent and previous on its own.
//run from any thor. ok to read across, no pii data with customer information

old_date_in := '9999999999' : STORED('OLD_DATE'); 
new_date_in := '9999999999' : STORED('NEW_DATE');
 
new_find := sort(nothor(fileservices.logicalfilelist('thor100_21::out::inquiry_acclogs::*::comprehensive_table_companyids',,,,'10.241.50.45')), -name)[1..1];
old_find := sort(nothor(fileservices.logicalfilelist('thor100_21::out::inquiry_acclogs::*::comprehensive_table_companyids',,,,'10.241.50.45')), -name)[2..2];

nm(string name) := function
	one := stringlib.stringfind(name, '::', 3) + 2;
	two := stringlib.stringfind(name, '::', 4) - 1;
	three := name[one..two];
return three; end;

new_date := if(new_date_in = '9999999999', nm(new_find[1].name), trim(new_date_in, all));
old_date := if(old_date_in = '9999999999', nm(old_find[1].name), trim(old_date_in, all));

a := dataset(Data_Services.foreign_logs + 'thor100_21::out::inquiry_acclogs::'+new_date+'::comprehensive_table_companyids', Layout_ComprehensiveStats.NonFCRA_CompanyIDs, csv(separator('\t')));
f := dataset(Data_Services.foreign_logs + 'thor100_21::out::inquiry_acclogs::'+old_date+'::comprehensive_table_companyids', Layout_ComprehensiveStats.NonFCRA_CompanyIDs, csv(separator('\t')));

new := table(a(transaction_datey between '1990' and '2020' and ((unsigned)global_company_id > 0 or (unsigned)company_id > 0)), {new_dt := '20140515', global_company_id, company_id, product_code, vertical, industry, sub_market, s := sum(group, cnt),  min_ := min(group, transaction_datey + transaction_datem + transaction_dated), max_ := max(group, transaction_datey + transaction_datem + transaction_dated)}, company_id, product_code, few);
old := table(f(transaction_datey between '1990' and '2020' and ((unsigned)global_company_id > 0 or (unsigned)company_id > 0)), {old_dt := '20140417', previous_global_company_id := global_company_id, previous_company_id := company_id, previous_product_code := product_code, previous_vertical := vertical, previous_industry := industry, previous_sub_market := sub_market, previous_s := sum(group, cnt),  previous_min_ := min(group, transaction_datey + transaction_datem + transaction_dated), previous_max_ := max(group, transaction_datey + transaction_datem + transaction_dated)}, company_id, product_code, few);


j1 := join(new, old, 
										left.global_company_id = right.previous_global_company_id and left.company_id = right.previous_company_id and left.product_code = right.previous_product_code,
										TRANSFORM({string20 status, recordof(new), recordof(old)},
																changed := (left.vertical <> right.previous_vertical or 
																						left.industry <> right.previous_industry or
																						left.sub_market <> right.previous_sub_market) and left.new_dt <> '' and right.old_dt <> '';
																new_ := left.new_dt <> '' and right.old_dt = '';
																dropped := left.new_dt = '' and right.old_dt <> '';
															
															self.status := IF(changed, 'CHANGED', IF(new_, 'NEW', IF(dropped, 'REMOVED', 'NO CHANGE')));
															self := LEFT;
															self := RIGHT), 
											full outer);

tb := table(j1, {status, cid_cnt := count(group, new_dt <> ''), total := sum(group, s), min_dt := min(group, min_), max_dt := max(group, max_), 
									 cid_previous_cnt := count(group, old_dt <> ''), total_previous := sum(group, previous_s), min_dt_previous := min(group, previous_min_), max_dt_previous := max(group, previous_max_)}, status, few);

EXPORT _SCH_NonFCRACountChanges := sort(j1,record);