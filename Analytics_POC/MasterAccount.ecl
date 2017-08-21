import lib_date;

// this file contains subaccounts for joining other datasets
// files should then be rolled up by mig_gen03_cd
file_FSRaw := Analytics_POC.Finance.file_FSRaw;

ds_accts := table(file_FSRaw, 
								  {mig_gen03_cd,
									 integer billing_start_dt:= min(group,
										 billing_start[length(billing_start)-3..length(billing_start)]+
										 billing_start[length(billing_start)-6..length(billing_start)-5]), 
									 integer billing_end_dt:= max(group,
										 billing_end[length(billing_end)-3..length(billing_end)]+
										 billing_end[length(billing_end)-6..length(billing_end)-5]),
									 integer hh_id:=max(group,(integer)hh_id),
									 string sales_rep := stringlib.stringfilterout(sales_rep,'"')
									 },
								  mig_gen03_cd);

// count/rev data
daily_agg := dedup(sort(Analytics_POC.Daily.fs_daily_agg(sls_amt>0 or unit_cnt>0),mig_gen03_cd),mig_gen03_cd);

// filter out account w/ out revenue or volume
ds_with_activity := join(ds_accts,
                         daily_agg,
												 left.mig_gen03_cd=right.mig_gen03_cd);

// add bid
companies := CompanyAddresses.file_bid_deduped;

layout_acct_bid := record
	recordof(ds_accts);
	integer tenure;
	companies.bid;
	companies.bid_score;
	string company_business_name;
	string company_phone;
	string company_source;
	string company_addr;
end;

ds_with_bid := join(ds_with_activity,
										companies,
										left.mig_gen03_cd = right.mig_gen03_cd,
										transform(layout_acct_bid,
										          self:=left,
															self:=right,
															self.company_business_name:=right.business_name,
															self.company_phone:=right.business_phone,
															self.company_source:=right.source,
															self.company_addr:=right.cleanaddr,
															self.tenure:=lib_date.daysapart(left.billing_start_dt+'01',
	                                                            if(left.billing_end_dt!=0,left.billing_end_dt+'01','20111201'))
															),
										left outer);

export MasterAccount := ds_with_bid : persist('~thor::poc::persist::master_account');

// despray_acct_file := 
	// sequential(
		// output(acct, ,
					 // 'poc::master_acct', 
					 // csv(heading(single), quote('"'), separator(','), terminator('\n'), maxlength(1024)),
					 // overwrite
					 // )
		// ,FileServices.DeSpray('~thor20_11::poc::master_acct', Analytics_POC.Constants.landing_ip, 'w:\\poc\\master_acct.csv', ,,,true)
	// );