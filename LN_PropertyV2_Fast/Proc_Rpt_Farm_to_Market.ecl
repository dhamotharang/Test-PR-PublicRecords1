import ut, dops;
EXPORT Proc_Rpt_Farm_to_Market (string pversion ='') := function

shared build_metrics :=  LN_PropertyV2_Fast.File_Build_Metrics.file(version = pversion);
shared start_process_date:= set(build_metrics, prep_start_date)[1];
shared end_process_date := set(build_metrics, key_build_end_date)[1]; 
shared prod_date :=ut.ConvertDate(set(dops.GetReleaseHistory('B', 'N', 'LNPropertyV2Keys')(prodversion = pversion), prodwhenupdated)[1]); 

rpts := parallel(
output(
LN_PropertyV2_Fast.fn_Reports_Farm_to_Market(start_process_date,end_process_date, prod_date).deed_days_apart_stats_cnty_updated, all, 
named('DeedByCounty')),
output(
LN_PropertyV2_Fast.fn_Reports_Farm_to_Market(start_process_date,end_process_date, prod_date).deed_days_apart_stats_doctype_updated, all,
named('DeedByDoctype')),
output(
LN_PropertyV2_Fast.fn_Reports_Farm_to_Market(start_process_date,end_process_date, prod_date).deed_days_apart_stats_delivery_date_updated, all,
named('DeedByFiledate')),
output(
LN_PropertyV2_Fast.fn_Reports_Farm_to_Market(start_process_date,end_process_date, prod_date).deed_noupdate_days_apart_stats_cnty, all,
named('DeedNotUpdatedByCounty')),
output(
LN_PropertyV2_Fast.fn_Reports_Farm_to_Market(start_process_date,end_process_date, prod_date).assess_days_apart_stats_cnty_updated, all,
named('AssessorByCounty')),
output(
LN_PropertyV2_Fast.fn_Reports_Farm_to_Market(start_process_date,end_process_date, prod_date).assess_days_apart_stats_delivery_date_updated, all,
named('AssessorByFiledate')),
output(
LN_PropertyV2_Fast.fn_Reports_Farm_to_Market(start_process_date,end_process_date, prod_date).assess_noupdate_days_apart_stats_cnty, all,
named('AssessorNotUpdatedByCounty'))
);

return rpts;
end;



