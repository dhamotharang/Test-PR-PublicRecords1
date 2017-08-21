import ut;
export monthly := module


// volume and rev is in the address file, moving on...
essbase_vol := sort(
	table(CompanyAddresses.file_essbase(GL_DT_KEY>=20080000), {cust_cd, GL_DT_KEY, unit_cnt, sls_amt})
	,cust_cd, GL_DT_KEY
);

// filter accounts not in master list
accts := join(FS_Accounts.ds_accts,
              MasterAccount,
							left.mig_gen03_cd=right.mig_gen03_cd);

slim_units_layout := record
	accts.mig_gen03_cd;
	accts.hh_id;
	string yr_month;
	essbase_vol.unit_cnt;
	essbase_vol.sls_amt;
end;

shared slim_units := join(accts, //FS_Accounts.ds_accts,
												  essbase_vol,
												  left.cust_cd=right.cust_cd,
												  transform(slim_units_layout,
																	  self:=left,
																	  self:=right,
																	  self.yr_month:=right.gl_dt_key[1..6])
												 );

shared mig_yr_months_layout := record
	slim_units.mig_gen03_cd;
	slim_units.hh_id;
	slim_units.yr_month;
	decimal10_2 sls_amt := sum(group,slim_units.sls_amt);
	integer unit_cnt := sum(group,slim_units.unit_cnt);
	unsigned1 merged_sub_cnt := count(group);
end;

export mig_months := table(slim_units, mig_yr_months_layout, mig_gen03_cd, yr_month);

export
yr_months := dataset(
	[
	{'200801'},{'200901'},{'201001'},{'201101'},
	{'200802'},{'200902'},{'201002'},{'201102'},
	{'200803'},{'200903'},{'201003'},{'201103'},
	{'200804'},{'200904'},{'201004'},{'201104'},
	{'200805'},{'200905'},{'201005'},{'201105'},
	{'200806'},{'200906'},{'201006'},{'201106'},
	{'200807'},{'200907'},{'201007'},{'201107'},
	{'200808'},{'200908'},{'201008'},{'201108'},
	{'200809'},{'200909'},{'201009'},{'201109'},
	{'200810'},{'200910'},{'201010'},{'201110'},
	{'200811'},{'200911'},{'201011'},{'201111'},
	{'200812'},{'200912'},{'201012'},{'201112'}
	], {string yr_month}
	);

// build empty dset with a month for each mig_gen03_cd
empty_mths := join(yr_months,
                   table(mig_months,{mig_gen03_cd,hh_id, min_y:=min(group,yr_month)},mig_gen03_cd),
									 left.yr_month[1..2]=right.min_y[1..2], // trick compiler into cartesian join
									 transform(mig_yr_months_layout,
									           self.yr_month:=left.yr_month,
														 self:=right,
														 self:=[]));

export with_empty_mths := dedup(sort(mig_months+empty_mths,mig_gen03_cd,yr_month,-abs(sls_amt),-abs(unit_cnt)),mig_gen03_cd,yr_month);

hh_agg_layout := record
	with_empty_mths.hh_id;
	with_empty_mths.yr_month;
	decimal10_2 sls_amt:=sum(group,with_empty_mths.sls_amt);
	integer unit_cnt:=sum(group,with_empty_mths.unit_cnt);
end;

export hh_agg := table(with_empty_mths, hh_agg_layout, hh_id, yr_month);

shared mig_hh_agg_layout := record
	mig_months.mig_gen03_cd;
	mig_months.hh_id;
	mig_months.yr_month;
	mig_months.sls_amt;
	mig_months.unit_cnt;
	mig_months.merged_sub_cnt;
	decimal10_2 hh_sls_amt;
	integer hh_unit_cnt;
end;


export ds_monthly_vol := join(with_empty_mths,
															hh_agg,
															left.hh_id=right.hh_id 
															and right.hh_id!='0'
															and left.yr_month=right.yr_month,
															transform(mig_hh_agg_layout,
																				self.hh_sls_amt:=right.sls_amt;
																				self.hh_unit_cnt:=right.unit_cnt;
																				self:=left),
															left outer
															);

// figure out max annual revenue for tier calc
export
	string tier(decimal10_2 annual_rev) := 
		map(annual_rev < 10000 => 'B-2-5-0',
				annual_rev < 20000 => 'B-2-4-0',
				annual_rev < 30000 => 'B-2-3-0',
				annual_rev < 40000 => 'B-2-2-0',
				annual_rev < 50000 => 'B-2-1-0',
				annual_rev < 60000 => 'B-1-5-0',
				annual_rev < 70000 => 'B-1-4-0',
				annual_rev < 80000 => 'B-1-3-0',
				annual_rev < 90000 => 'B-1-2-0',
				annual_rev < 100000 => 'B-1-1-0',
				annual_rev < 150000 => 'T-3-4-2',
				annual_rev < 200000 => 'T-3-4-1',
				annual_rev < 250000 => 'T-3-3-2',
				annual_rev < 300000 => 'T-3-3-1',
				annual_rev < 350000 => 'T-3-2-2',
				annual_rev < 400000 => 'T-3-2-1',
				annual_rev < 450000 => 'T-3-1-2',
				annual_rev < 500000 => 'T-3-1-1',
				annual_rev < 550000 => 'T-2-5-2',
				annual_rev < 600000 => 'T-2-5-1',
				annual_rev < 650000 => 'T-2-4-2',
				annual_rev < 700000 => 'T-2-4-1',
				annual_rev < 750000 => 'T-2-3-2',
				annual_rev < 800000 => 'T-2-3-1',
				annual_rev < 850000 => 'T-2-2-2',
				annual_rev < 900000 => 'T-2-2-1',
				annual_rev < 950000 => 'T-2-1-2',
				annual_rev < 1000000 => 'T-2-1-1',
				annual_rev < 5000000 => 'T-1-2-0',
				'T-1-1-0');

annual_totals := table(ds_monthly_vol, {hh_id, string yr:=yr_month[1..4], annual_sls_amt:=sum(group,sls_amt)}, hh_id, yr_month[1..4]);

max_year := table(annual_totals, {hh_id, max_annual_sls_amt:=max(group,annual_sls_amt), string tier:=tier(max(group,annual_sls_amt))}, hh_id); 

with_tier := join(ds_monthly_vol,
                  max_year,
									left.hh_id=right.hh_id,
									transform({recordof(ds_monthly_vol),string tier,decimal10_2 max_annual_sls_amt},
									          self:=left,
														self:=right),
									left outer);

export ds_monthly_agg := with_tier;



export proc_despray_monthly :=
	sequential(
		output(ds_monthly_agg, ,
				   'poc::fs_monthly', 
				   csv(heading(single), quote(''), separator(','), terminator('\n')),
				   overwrite)
		,
		FileServices.DeSpray('poc::fs_monthly', 
												 Analytics_POC.Constants.landing_ip, 
												 'w:\\poc\\fs_monthly.csv', ,,,true)
	);

//Create User Activity file
act_alpha := Analytics_POC.UserActivity.Alpha_activity;
act_day := Analytics_POC.UserActivity.Dayton_activity((integer)act_cnt>0);

act_rec := record
 string MIG_GEN03_CD;
 string hh_id;
 string year_mnth;
 string active_users;
end;

before_slim := record
  string MIG_CUST_ID;
	act_rec;
end;

slim_alpha := project(act_alpha,transform(before_slim,
																					self.mig_cust_id:=left.CompanyID, 
																					self.year_mnth := trim(left.year) + 
																						map(left.month='Jan' => '01',
																						left.month='Feb' => '02',
																						left.month='Mar' => '03',
																						left.month='Apr' => '04',
																						left.month='May' => '05',
																						left.month='Jun' => '06',
																						left.month='Jul' => '07',
																						left.month='Aug' => '08',
																						left.month='Sep' => '09',
																						left.month='Oct' => '10',
																						left.month='Nov' => '11',
																						 '12');
																					self.active_users := left.ActiveUsers,
																					self := []));
																					
slim_day := project(act_day,transform(before_slim,
																					self.mig_cust_id:=left.sub_acct_id, 
																					self.year_mnth := left.clndr_yr_month,
																					self.active_users := left.act_cnt;
																					self := []));

all_act := slim_alpha + slim_day;

//join to finance data to turn sub accounts into migration account
act_rec get_act(all_act l, Analytics_POC.Finance.file_fs r) := transform
	self.hh_id := r.hh_id;
	self.MIG_GEN03_CD := r.MIG_GEN03_CD;
	self := l;
	end;

get_id := join(all_act,Analytics_POC.Finance.file_fs,
												left.mig_cust_id=right.MIG_CUST_ID,get_act(left,right));
												
//slim to master accounts
targert_data := join(Analytics_POC.MasterAccount,get_id,left.mig_gen03_cd=right.mig_gen03_cd,
										    transform(act_rec,self := right));
																					

// build empty dset with a month for each mig_gen03_cd
empty_mths := join(yr_months,
                   table(targert_data,{mig_gen03_cd,hh_id, min_y:=min(group,year_mnth)},mig_gen03_cd),
									 left.yr_month[1..2]=right.min_y[1..2], // trick compiler into cartesian join
									 transform(act_rec,
									           self.year_mnth:=left.yr_month,
														 self.active_users := '0',
														 self:=right,
														 self:=[]));
														 
all_dates := dedup(sort(targert_data+empty_mths,mig_gen03_cd,year_mnth,-active_users),mig_gen03_cd,year_mnth);

export proc_despray_monthly_activity :=
	sequential(
		output(all_dates, ,
				   'poc::fs_monthly_activity', 
				   csv(heading(single), quote(''), separator(','), terminator('\n')),
				   overwrite)
		,
		FileServices.DeSpray('poc::fs_monthly_activity', 
												 Analytics_POC.Constants.landing_ip, 
												 'w:\\poc\\fs_activity.csv', ,,,true)
	);
	
	
//prep sibel tasks file
tasks := Analytics_POC.Mrk_Tasks;

task_id := record
 string mig_gen03_cd;
 string hh_id;
 string yr_month;
 string email_cnt;
 string web_cnt;
 string buying_influence_cnt;
 string phone_cnt;
 string unsubscribe_cnt;
 string submitted_order_cnt;
 string credit_cnt;
 string welcome_all_cnt;
 string cancellation_cnt;
 string other_cnt;
end;

email_set := ['Email Open','Email Click Through','Email','Fax'];
other_set := ['NULL','To Do','Form Submit','Other','Batch Update','Audit Task',
'System Admin Request','Presentation','Blitz Cold Call - No Connect','IDVS',
'PCT Action','Intern Order','IP Request','Repeat Inbound Inquiry','Task - Follow Up',
'Appointment - Follow Up','Welcome Letter','Appointment - First','Correspondence',
'Reactivate','KYC - QBR','Outbound Call - No Connect','Credentialing','Task - Proposal',
'Event','Blitz Conference Call Set','Appointment - KYC','Cancels','Initial Meeting','Outbound Call - Followup - KYC',
'Appointment - Presentation','Direct Mail','Task - Follow Up Proposal','Inbound Call - Call In',
'Task - Email','Demos','Training','Tradeshow','CAM - Claims','Task - Send Information','Denied',
'New Sales - Call in','Account Plan Review'];
phone_set := ['Callback','Voicemail','Call','Meeting','New Business Team',
'1st Invoice Call','Demonstration','Outbound Call - Cold Call','Field Face to Face Appointment',
'Blitz Cold Call - Connect','Outbound Call - Connect - KYC','Conference Call',
'Conference Call - Follow Up','Conference Call - First','Customer Support','Blitz Appt Set From Cold Call'];
web_set := ['Website Visit','Web link'];

	
	//join to finance data to turn sub accounts into migration account
task_id get_cnts(tasks l, Analytics_POC.Finance.file_fs r) := transform
	self.hh_id := r.hh_id;
	self.MIG_GEN03_CD := r.MIG_GEN03_CD;
  self.yr_month := l.start_time[1..6];
  self.email_cnt := if(l.type_ in email_set,'1','0');
  self.web_cnt := if(l.type_ in web_set,'1','0');
  self.buying_influence_cnt := if(l.type_ = 'Connect w/Buying Influence','1','0');
  self.phone_cnt := if(l.type_ in phone_set,'1','0');
  self.unsubscribe_cnt := if(l.type_ = 'Email Unsubscribe','1','0');
  self.submitted_order_cnt := if(l.type_ = 'Submitted Order','1','0');
  self.credit_cnt := if(l.type_ = 'Credit','1','0');
  self.welcome_all_cnt := if(l.type_ = 'Welcome Call','1','0');
  self.cancellation_cnt := if(l.type_ = 'Cancellation','1','0');
  self.other_cnt := if(l.type_ in other_set,'1','0');
end;

wtih_cnt := join(tasks,Analytics_POC.Finance.file_fs,
												stringlib.stringfilterout(left.sub_acct_id,'ST')=right.MIG_CUST_ID,get_cnts(left,right));
												
//slim to master accounts
only_master := join(Analytics_POC.MasterAccount,wtih_cnt,left.mig_gen03_cd=right.mig_gen03_cd,
										    transform(task_id,self := right));
												
task_id rollcnt(only_master l, only_master r) := transform
  self.email_cnt := (string)((integer)l.email_cnt + (integer)r.email_cnt);
  self.web_cnt := (string)((integer)l.web_cnt +(integer)r.web_cnt );
  self.buying_influence_cnt := (string)((integer)l.buying_influence_cnt +(integer)r.buying_influence_cnt );
  self.phone_cnt := (string)((integer)l.phone_cnt +(integer)r.phone_cnt );
  self.unsubscribe_cnt := (string)((integer)l.unsubscribe_cnt +(integer)r.unsubscribe_cnt );
  self.submitted_order_cnt := (string)((integer)l.submitted_order_cnt +(integer)r.submitted_order_cnt );
  self.credit_cnt := (string)((integer)l.credit_cnt +(integer)r.credit_cnt );
  self.welcome_all_cnt := (string)((integer)l.welcome_all_cnt +(integer)r.welcome_all_cnt );
  self.cancellation_cnt := (string)((integer)l.cancellation_cnt +(integer)r.cancellation_cnt );
  self.other_cnt := (string)((integer)l.other_cnt +(integer)r.other_cnt );
  self := l;
end;
																																	 
final_data := rollup(group(sort(only_master,mig_gen03_cd,yr_month),mig_gen03_cd,yr_month),true,rollcnt(left,right));

export proc_despray_monthly_Siebel_tasks :=
	sequential(
		output(final_data, ,
				   'poc::fs_monthly_Siebel_tasks', 
				   csv(heading(single), quote(''), separator(','), terminator('\n')),
				   overwrite)
		,
		FileServices.DeSpray('poc::fs_monthly_Siebel_tasks', 
												 Analytics_POC.Constants.landing_ip, 
												 'w:\\poc\\fs_siebel_tasks.csv', ,,,true)
	);
 
//Add Training data
train := Analytics_POC.Training;

train_rec := record
 string mig_gen03_cd;
 string hh_id;
 string yr_month;
 string Telephonic_cnt;
 string Onsite_cnt;
 string Numattendees;
end;

	//join to finance data to turn sub accounts into migration account
train_rec get_train(train l, Analytics_POC.Finance.file_fs r) := transform
	self.hh_id := r.hh_id;
	self.MIG_GEN03_CD := r.MIG_GEN03_CD;
  self.yr_month := l.clndr_yr_month;
	self.telephonic_cnt := if(stringlib.stringfind(l.type_,'Telephonic',1)>0,'1','0');
	self.Onsite_cnt := if(stringlib.stringfind(l.type_,'Onsite',1)>0,'1','0');
  self := l;
end;

wtih_id := join(train,Analytics_POC.Finance.file_fs,
												stringlib.stringfilterout(left.vc_id,'ST')=right.MIG_CUST_ID,get_train(left,right));
												
//slim to master accounts
train_master := join(Analytics_POC.MasterAccount,wtih_id,left.mig_gen03_cd=right.mig_gen03_cd,
										    transform(train_rec,self := right));
												
train_rec getCnt(train_master l, train_master r) := transform
self.telephonic_cnt := (string)((integer)l.telephonic_cnt + (integer)r.telephonic_cnt);
self.onsite_cnt := (string)((integer)l.onsite_cnt + (integer)r.onsite_cnt);
self.Numattendees := (string)((integer)l.Numattendees + (integer)r.Numattendees);
self := l;
end;

training_rolled := rollup(group(sort(train_master,MIG_GEN03_CD,yr_month),MIG_GEN03_CD,yr_month),true,getCnt(left,right));
												
export proc_despray_monthly_training :=
	sequential(
		output(training_rolled, ,
				   'poc::fs_monthly_training', 
				   csv(heading(single), quote(''), separator(','), terminator('\n')),
				   overwrite)
		,
		FileServices.DeSpray('poc::fs_monthly_training', 
												 Analytics_POC.Constants.landing_ip, 
												 'w:\\poc\\fs_training.csv', ,,,true));
												 

//add PCT data
pct_raw := Analytics_POC.PCT;

pct_rec := record
 string mig_gen03_cd;
 string hh_id;
 string yr_month;
 string completed_cnt;
 string abandoned_cnt;
 string rejected_cnt;
 string waiting_cnt;
 
end;

//join to finance data to turn sub accounts into migration account
pct_rec get_pctID(pct_raw l, Analytics_POC.Finance.file_fs r) := transform
	self.hh_id := r.hh_id;
	self.MIG_GEN03_CD := r.MIG_GEN03_CD;
	sec_slash := stringlib.stringfind(l.timesubmitted,'/',2);
	first_slash := stringlib.stringfind(l.timesubmitted,'/',1);
	self.yr_month := '20'+l.timesubmitted[sec_slash+1..sec_slash+2] + 
											if(first_slash=3,l.timesubmitted[1..2],
											'0' + l.timesubmitted[1]);
  self.completed_cnt := if(l.status='Completed','1','0');
  self.abandoned_cnt := if(l.status='Abandoned','1','0');
  self.rejected_cnt := if(l.status='Rejected','1','0');
  self.waiting_cnt := if(l.status='Waiting','1','0');
	self := l;
	end;

PCT_ID := join(pct_raw,Analytics_POC.Finance.file_fs,
												stringlib.stringfilterout(left.bgrp,'ST')=right.MIG_CUST_ID,get_pctID(left,right));
												
//slim to master accounts
pct_data := join(Analytics_POC.MasterAccount,PCT_ID,left.mig_gen03_cd=right.mig_gen03_cd,
										    transform(pct_rec,self := right));
												
//rollup data
pct_rec rollPCT(pct_data L, pct_data R) := transform
  self.completed_cnt := (string)((integer)l.completed_cnt + (integer)r.completed_cnt);
  self.abandoned_cnt := (string)((integer)l.abandoned_cnt + (integer)r.abandoned_cnt);
  self.rejected_cnt := (string)((integer)l.rejected_cnt + (integer)r.rejected_cnt);
  self.waiting_cnt := (string)((integer)l.waiting_cnt + (integer)r.waiting_cnt);
	self := l;
end;

pct_rolled := rollup(group(sort(pct_data,MIG_GEN03_CD,yr_month),MIG_GEN03_CD,yr_month),true,rollPCT(left,right));
												
export proc_despray_monthly_PCT :=
	sequential(
		output(pct_rolled, ,
				   'poc::fs_monthly_PCT', 
				   csv(heading(single), quote(''), separator(','), terminator('\n')),
				   overwrite)
		,
		FileServices.DeSpray('poc::fs_monthly_PCT', 
												 Analytics_POC.Constants.landing_ip, 
												 'w:\\poc\\fs_PCT.csv', ,,,true));

//add funnel data
funnel_raw := Analytics_POC.Funnel;

funnel_rec := record
 string mig_gen03_cd;
 string hh_id;
 string yr_month;
 string opportunitytype;
 string expectedrevenue;
 string opportunityclassification;
 string probability;
 string stagestatus;
end;

//join to finance data to turn sub accounts into migration account
funnel_rec get_funnelID(funnel_raw l, Analytics_POC.Finance.file_fs r) := transform
	self.hh_id := r.hh_id;
	self.MIG_GEN03_CD := r.MIG_GEN03_CD;
	sec_slash := stringlib.stringfind(l.create_dt,'/',2);
	first_slash := stringlib.stringfind(l.create_dt,'/',1);
	self.yr_month := '20'+l.create_dt[sec_slash+1..sec_slash+2] + 
											if(first_slash=3,l.create_dt[1..2],
											'0' + l.create_dt[1]);
  self := l;
	end;

Funnel_ID := join(funnel_raw,Analytics_POC.Finance.file_fs,
												stringlib.stringfilterout(left.vc_id,'ST')=right.MIG_CUST_ID,get_funnelID(left,right));
												
//slim to master accounts
funnel_data := join(Analytics_POC.MasterAccount,Funnel_ID,left.mig_gen03_cd=right.mig_gen03_cd,
										    transform(funnel_rec,self := right));
												
export proc_despray_monthly_funnel :=
	sequential(
		output(sort(funnel_data,mig_gen03_cd,yr_month), ,
				   'poc::fs_monthly_Funnel', 
				   csv(heading(single), quote(''), separator(','), terminator('\n')),
				   overwrite)
		,
		FileServices.DeSpray('poc::fs_monthly_Funnel', 
												 Analytics_POC.Constants.landing_ip, 
												 'w:\\poc\\fs_Funnel.csv', ,,,true));

//add Service Request data
serReq_raw := Analytics_POC.ServiceRequests;

serreq_rec := record
 string mig_gen03_cd;
 string hh_id;
 string yr_month;
 string		sr_type_cd;
 string		sr_subtype_cd;
 string		sr_stat_id;
 string		sr_prio_cd;
 string		sr_sub_stat_id;
 string   act_duration;
end;

//join to finance data to turn sub accounts into migration account
serreq_rec get_servID(serReq_raw l, Analytics_POC.Finance.file_fs r) := transform
	self.hh_id := r.hh_id;
	self.MIG_GEN03_CD := r.MIG_GEN03_CD;
	self.yr_month := l.clndr_yr_month;
	start_sec_slash := stringlib.stringfind(l.act_open_dt,'/',2);
	start_first_slash := stringlib.stringfind(l.act_open_dt,'/',1);
	start_date := '20'+l.act_open_dt[start_sec_slash+1..start_sec_slash+2] + 
											if(start_first_slash=3,l.act_open_dt[1..2],
											'0' + l.act_open_dt[1])+ 
											if(start_sec_slash-start_first_slash=2,
												 '0','') + l.act_open_dt[start_first_slash + 1..start_sec_slash-1];
	end_sec_slash := stringlib.stringfind(l.act_close_dt,'/',2);
	end_first_slash := stringlib.stringfind(l.act_close_dt,'/',1);
	end_date := '20'+l.act_close_dt[end_sec_slash+1..end_sec_slash+2] + 
											if(end_first_slash=3,l.act_close_dt[1..2],
											'0' + l.act_close_dt[1])+ 
											if(end_sec_slash-end_first_slash=2,
												 '0','') + l.act_close_dt[end_first_slash + 1..end_sec_slash-1];
	self.act_duration := if(l.act_open_dt='NULL' or l.act_close_dt='NULL','0',(string)ut.DaysApart(start_date,end_date));
  self := l;
	end;

Srv_ID := join(serReq_raw,Analytics_POC.Finance.file_fs,
												stringlib.stringfilterout(left.X_ASSET_NUM_CI,'ST')=right.MIG_CUST_ID,get_servID(left,right));
												
//slim to master accounts
srv_data := join(Analytics_POC.MasterAccount,Srv_ID,left.mig_gen03_cd=right.mig_gen03_cd,
										    transform(serreq_rec,self := right));
												
export proc_despray_monthly_srvreq :=
	sequential(
		output(sort(srv_data,mig_gen03_cd,yr_month), ,
				   'poc::fs_monthly_Service_Request', 
				   csv(heading(single), quote(''), separator(','), terminator('\n')),
				   overwrite)
		,
		FileServices.DeSpray('poc::fs_monthly_Service_Request', 
												 Analytics_POC.Constants.landing_ip, 
												 'w:\\poc\\fs_SrvReq.csv', ,,,true));
	 
	 
//add Dunning data
Dunning_raw_alpha := Analytics_POC.Dunning.Alpharetta_Dunning;
Dunning_raw_dayton := Analytics_POC.Dunning.Dayton_Dunning;

dunning_rec := record
 string mig_gen03_cd;
 string hh_id;
 string yr_month;
 string dunning_system;
 string dunning_duration;
end;

//join to finance data to turn sub accounts into migration account
dunning_rec get_aDunningID(Dunning_raw_alpha l, Analytics_POC.Finance.file_fs r) := transform
	self.hh_id := r.hh_id;
	self.MIG_GEN03_CD := r.MIG_GEN03_CD;
	start_sec_slash := stringlib.stringfind(l.invoice_date,'/',2);
	start_first_slash := stringlib.stringfind(l.invoice_date,'/',1);
	start_date := l.invoice_date[start_sec_slash+1..start_sec_slash+4] + 
											if(start_first_slash=3,l.invoice_date[1..2],
											'0' + l.invoice_date[1])+ 
											if(start_sec_slash-start_first_slash=2,
												 '0','') + l.invoice_date[start_first_slash + 1..start_sec_slash-1];
  self.yr_month := start_date[1..6];
												 
	end_sec_slash := stringlib.stringfind(l.date_closed,'/',2);
	end_first_slash := stringlib.stringfind(l.date_closed,'/',1);
	end_date := l.date_closed[end_sec_slash+1..end_sec_slash+4] + 
											if(end_first_slash=3,l.date_closed[1..2],
											'0' + l.date_closed[1])+ 
											if(end_sec_slash-end_first_slash=2,
												 '0','') + l.date_closed[end_first_slash + 1..end_sec_slash-1];
  integer dur := ut.DaysApart(start_date,end_date);
	self.dunning_duration := (string)if(dur>500,30,dur);
	self.dunning_system := 'ALPHA';
  self := l;
	end;

Adun_ID := join(Dunning_raw_alpha,Analytics_POC.Finance.file_fs,
												stringlib.stringfilterout(left.company_id,'ST')=right.MIG_CUST_ID,get_aDunningID(left,right));
												
//remove dups
adun_dup := dedup(sort(adun_id,mig_gen03_cd,yr_month,-dunning_duration),mig_gen03_cd,yr_month);
												
//join dayton file
Analytics_POC.Dunning.Dayton_rec setNotice(Dunning_raw_dayton l, Dunning_raw_dayton R) := transform
self.Dunning_Stat_cd := map(r.Dunning_Stat_cd='Final Notice Sent' and l.Dunning_Stat_cd='Second Notice Sent' and (integer)r.date =(integer)l.date+1 => 'Final Notice1',
														r.dunning_stat_cd='Final Notice Sent' and l.Dunning_stat_cd='Final Notice Sent'  and (integer)r.date = (integer)l.date+1 => 'Final Notice2',
														r.Dunning_Stat_cd='Final Notice Sent' and l.Dunning_stat_cd='Final Notice1' and (integer)r.date =(integer)l.date+1=> 'Final Notice2',
														r.Dunning_stat_cd='Final Notice Sent' and l.Dunning_stat_cd='Final Notice2' and (integer)r.date =(integer)l.date+1=> 'Final Notice3',
														r.Dunning_stat_cd);
self := r;
end; 

dayton_fixed := iterate(group(sort(Dunning_raw_dayton,vc_id,(integer)date),vc_id),setNotice(left,right));

dunning_rec get_dDunningID(dayton_fixed l, Analytics_POC.Finance.file_fs r) := transform
	self.hh_id := r.hh_id;
	self.MIG_GEN03_CD := r.MIG_GEN03_CD;
  self.yr_month := l.Date;												 
	self.dunning_duration := map(l.Dunning_Stat_cd = 'First Notice Sent' => '30',
																l.Dunning_Stat_cd = 'Second Notice Sent' => '60',
																l.Dunning_stat_cd ='Final Notice Sent' => '90',
																l.Dunning_Stat_cd = 'Final Notice1' => '90',
																l.Dunning_Stat_cd = 'Final Notice2' => '120','150');
	self.dunning_system := 'DAYTON';
  self := l;
	end;

ddun_ID := join(dayton_fixed,Analytics_POC.Finance.file_fs,
												stringlib.stringfilterout(left.vc_id,'ST')=right.MIG_CUST_ID,get_dDunningID(left,right));
								
//add dunning
all_dun := adun_dup + ddun_ID;
												

//slim to master accounts
dunning_data := join(Analytics_POC.MasterAccount,all_dun,left.mig_gen03_cd=right.mig_gen03_cd,
										    transform(dunning_rec,self := right));
												
export proc_despray_monthly_dunning :=
	sequential(
		output(sort(dunning_data,mig_gen03_cd,yr_month), ,
				   'poc::fs_monthly_Dunning', 
				   csv(heading(single), quote(''), separator(','), terminator('\n')),
				   overwrite)
		,
		FileServices.DeSpray('poc::fs_monthly_Dunning', 
												 Analytics_POC.Constants.landing_ip, 
												 'w:\\poc\\fs_Dunning.csv', ,,,true));
end;