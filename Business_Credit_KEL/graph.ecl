#OPTION(configmod)
#OPTION(persist, 0) 
 
//IMPORT Business_Credit_KEL.entities; 
 
Business := ENTITY(FLAT(UID=seq), MODEL(*));	
  
Account := ENTITY(FLAT(
							UID= acct_no, //contractacc_num, 
							seq,
							ultid, 
							orgid,
							seleid,
							proxid,
							powid,
							empid,
							dotid,
							ultscore,
							orgscore,
							selescore,
							proxscore,
							powscore,
							empscore,
							dotscore,
							ultweight,
							orgweight,
							seleweight,
							proxweight,
							powweight,
							empweight,
							dotweight,
							//sbfe_contributor_number,
							//contract_account_number,
							//account_type_reported,
							DATE dt_first_seen=NULL(''),
							DATE dt_last_seen=NULL(''),
							DATE dt_vendor_first_reported=NULL(''),
							DATE dt_vendor_last_reported=NULL(''),
							DATE dt_datawarehouse_first_reported=NULL(''),
							DATE dt_datawarehouse_last_reported=NULL(''),
							did,
							did_score),
					MODEL(*));
					
Tradeline := ENTITY(FLAT(
							UID=seq_num,
							DATE load_date=load_dateyyyymmdd/*NULL('')*/,
							STRING sbfe_contributor_number=NULL(''),
							STRING contract_account_number=NULL(''),
							DATE cycle_end_date=NULL(''),
							STRING segment_identifier=NULL(''),
							STRING file_segment_num=NULL(''),
							STRING parent_sequence_number=NULL(''),
							STRING account_holder_business_name=NULL(''),
							STRING dba=NULL(''),
							STRING company_website=NULL(''),
							INTEGER legal_business_structure=NULL(''),
							DATE business_established_date=NULL(''),
							INTEGER account_type_reported=NULL(0), //this is in string format in the key (001, 002, etc) but for calculations below we declare it an integer
							STRING account_status_1=NULL(''),
							STRING account_status_2=NULL(''),
							DATE date_account_opened=NULL(''),
							DATE date_account_closed=NULL(''),
							STRING account_closure_basis=NULL(''),
							DATE account_expiration_date=NULL(''),
							DATE last_activity_date=NULL(''),
							STRING last_activity_type=NULL(''),
							STRING recent_activity_indicator=NULL(''),
							INTEGER original_credit_limit=NULL(0),
							INTEGER highest_credit_used=NULL(''),
							INTEGER current_credit_limit=NULL(0),
							reporting_indicator_length,
							STRING payment_interval=NULL(''),
							STRING payment_status_category=NULL(''),
							term_of_account_in_months,
							DATE first_payment_due_date=NULL(''),
							DATE final_pyament_due_date=NULL(''),
							original_rate,
							floating_rate, 
							grace_period,
							payment_category,
							payment_history_profile_12_months,
							payment_history_profile_13_24_months,
							payment_history_profile_25_36_months,
							payment_history_profile_37_48_months,
							payment_history_length,
							year_to_date_purchases_count,
							lifetime_to_date_purchases_count,
							year_to_date_purchases_sum_amount,
							lifetime_to_date_purchases_sum_amount,
							INTEGER payment_amount_scheduled=NULL(''),
							INTEGER recent_payment_amount=NULL(''),
							DATE recent_payment_date=NULL(''),
							INTEGER remaining_balance=NULL(''),
							carried_over_amount,
							new_applied_charges,
							INTEGER balloon_payment_due=NULL(0),
							DATE balloon_payment_due_date=NULL(''),
							DATE delinquency_date=NULL(''),
							days_delinquent,
							INTEGER past_due_amount=NULL(''),
							maximum_number_of_past_due_aging_amounts_buckets_provided,
							past_due_aging_bucket_type,
							INTEGER past_due_aging_amount_bucket_1=NULL(''),
							INTEGER past_due_aging_amount_bucket_2=NULL(''),
							INTEGER past_due_aging_amount_bucket_3=NULL(''),
							INTEGER past_due_aging_amount_bucket_4=NULL(''),
							INTEGER past_due_aging_amount_bucket_5=NULL(''),
							INTEGER past_due_aging_amount_bucket_6=NULL(''),
							INTEGER past_due_aging_amount_bucket_7=NULL(''),
							maximum_number_of_payment_tracking_cycle_periods_provided,
							payment_tracking_cycle_type,
							payment_tracking_cycle_0_current,
							payment_tracking_cycle_1_1_30_days,
							payment_tracking_cycle_2_31_60_days,
							payment_tracking_cycle_3_61_90_days,
							payment_tracking_cycle_4_91_120_days,
							payment_tracking_cycle_5_121_150days,
							payment_tracking_number_of_times_cycle_6_151_180_days,
							payment_tracking_number_of_times_cycle_7_181_or_greater_days,
							DATE date_account_was_charged_off=NULL(0), //NULL('') <-- CHECK THIS!
							INTEGER amount_charged_off_by_creditor=NULL(''),
							STRING charge_off_type_indicator=NULL(''),
							INTEGER total_charge_off_recoveries_to_date,
							STRING government_guarantee_flag=NULL(''),
							INTEGER government_guarantee_category=NULL(0), //or NULL('') maybe string
							INTEGER portion_of_account_guaranteed_by_government=NULL(''), //001-100
							STRING guarantors_indicator=NULL(''),
							INTEGER number_of_guarantors=NULL(''),
							STRING owners_indicator=NULL(''),
							INTEGER number_of_principals=NULL(''), //or NULL(0)?
							account_update_deletion_indicator),
						MODEL(*));
Industry := ENTITY(FLAT(
							UID=seq_num,
							//INTEGER seq,
							INTEGER record_type,
							STRING	sbfe_contributor_number,
							contract_account_number,
							DATE dt_first_seen,
							DATE	dt_last_seen,
							INTEGER classification_code_type,
							INTEGER classification_code,
							STRING primary_industry_code_indicator,
							STRING privacy_indicator),
						MODEL(*));
						
BusinessOwner := ENTITY(FLAT(
							UID=seq_num,
							STRING sbfe_contributor_number,
							STRING contract_account_number,
							INTEGER account_type_reported,
							DATE dt_first_seen,
							DATE dt_last_seen,
							DATE dt_vendor_first_reported,
							DATE dt_vendor_last_reported,
							DATE dt_datawarehouse_first_reported,
							DATE dt_datawarehouse_last_reported,
							STRING business_name=NULL(''),
							STRING web_address=NULL(''),
							INTEGER guarantor_owner_indicator=NULL(0),
							relationship_to_business_indicator,
							INTEGER percent_of_liability=NULL(''),
							INTEGER percent_of_ownership_if_owner_principal=NULL('')),
							//STRING source,
							//BOOLEAN active),
						MODEL(*));
						
						
IndividualOwner := ENTITY(FLAT(
							UID=seq_num,
							STRING sbfe_contributor_number,
							STRING contract_account_number,
							INTEGER account_type_reported,
							DATE dt_first_seen,
							DATE dt_last_seen,
							DATE dt_vendor_first_reported,
							DATE dt_vendor_last_reported,
							DATE dt_datawarehouse_first_reported,
							DATE dt_datawarehouse_last_reported,
							STRING first_name=original_fname,
							STRING middle_name=original_mname,
							STRING last_name=original_lname,
							STRING suffix=original_suffix,
							STRING e_mail_address,
							INTEGER guarantor_owner_indicator,
							relationship_to_business_indicator,
							STRING business_title,
							INTEGER percent_of_liability,
							INTEGER percent_of_ownership,
							STRING source,
							BOOLEAN active),
						MODEL(*));

BusinessAccount := ASSOCIATION(FLAT(Business bus=seq, Account acc=acct_no));
AccountTradeline := ASSOCIATION(FLAT(Account acc=acct_no, Tradeline trade=seq_num));

BusinessIndustry := ASSOCIATION(FLAT(Business bus=seq, Industry industry=seq_num));
AccountIndustry := ASSOCIATION(FLAT(Account acc=acct_no, Industry industry=seq_num));

AccountBusOwner := ASSOCIATION(FLAT(Account acc=acct_no, BusinessOwner owner=seq_num));
AccountIndivOwner := ASSOCIATION(FLAT(Account acc=acct_no, IndividualOwner owner=seq_num));



USE Business_Credit_KEL.File_SBFE_temp(FDC, Business,
																						Linkids(Account),
																						Tradelines(Tradeline),
																						Linkids(BusinessAccount),
																						Tradelines(AccountTradeline),
																						
																						BusinessClassification(Industry),
																						BusinessClassification(BusinessIndustry),
																						BusinessClassification(AccountIndustry),
																						
																						BusinessOwner(BusinessOwner),
																						BusinessOwner(AccountBusOwner),
																						
																						IndividualOwner(IndividualOwner),
																						IndividualOwner(AccountIndivOwner));


Business: => BusinessNotOnFile := NOT EXISTS(BusinessAccount.acc);

// $$$$$ Leave the => off for these definitions.  Without the '=>' these are true constants.  With the '=>' these create a column
// $$$$$ which has the same value for each row.
Business: NOT_ON_FILE := -99;
Business: NO_DATA_AVAILABLE := -98;
Business: UNKNOWN_DATA := -97; Account: UNKNOWN_DATA := -97; Tradeline: UNKNOWN_DATA := -97;

//SBFE shell attributes
Business: => DateFirstCycleAll := BusinessAccount.acc.AccountTradeline.trade.cycle_end_date$Min;
Business: => Sbfedatefirstcycleall := IF(BusinessNotOnFile, NOT_ON_FILE, INTEGERFROMDATE(DateFirstCycleAll));
Business: => Sbfetimeoldestcycle := IF(BusinessNotOnFile, -99, MONTHSBETWEEN(DateFirstCycleAll, CURRENTDATE()) + 1);

Business: => DateLastCycleAll := BusinessAccount.acc.AccountTradeline.trade.cycle_end_date$Max;
Business: => Sbfedatelastcycleall := IF(BusinessNotOnFile, NOT_ON_FILE, INTEGERFROMDATE(DateLastCycleAll));
Business: => Sbfetimenewestcycle := IF(BusinessNotOnFile, NOT_ON_FILE, MONTHSBETWEEN(DateLastCycleAll, CURRENTDATE()) + 1);

Business: => Sbfeaccountcount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc:Count);
Business: => Sbfeaccountcount12m := IF(BusinessNotOnFile, NOT_ON_FILE, COUNT(BusinessAccount.acc(MONTHSBETWEEN(LastCycleEndDate, CURRENTDATE()) < 12)));

Tradeline: => ShowsOpenAccount := NOT date_account_opened:Null AND date_account_opened <= CURRENTDATE();
Account : => MostRecentlyOpenLoadDate := MAX(AccountTradeline.trade(NOT date_account_opened:Null AND date_account_opened <= CURRENTDATE()), load_date);
// $$$$$ ONLY should replace MAX in definitions like this.  ONLY assumes that a single row is selected and pulls the value
// $$$$$ from that row.  Note that if you need more than one value from the tradeline it's better to create a reference to
// $$$$$ the tradeline and then access the properties like this:
// $$$$$   Account: => MostRecentOpenTradeline := ONLY(Tradeline(load_date = Account.MostRecentlyOpenLoadDate));
// $$$$$   Account: => DateAccountOpened := MostRecentOpenTradeline.date_account_opened;
// $$$$$   Account: => MostRecentOpenBalance := MostRecentOpenTradeline.balance;
Account: => DateAccountOpened := ONLY(AccountTradeline.trade(load_date = Account.MostRecentlyOpenLoadDate), date_account_opened);

Account : => IsInvalidAccountOpenDate := ALL(AccountTradeline.trade, date_account_opened:Null OR date_account_opened > CURRENTDATE()) 
																						 AND EXISTS(AccountTradeline.trade(date_account_opened > CURRENTDATE()));

Account: => OpenedLast03Month := MONTHSBETWEEN(DateAccountOpened, CURRENTDATE()) < 3;
Account: => OpenedLast06Month := MONTHSBETWEEN(DateAccountOpened, CURRENTDATE()) < 6;
Account: => OpenedLast12Month := MONTHSBETWEEN(DateAccountOpened, CURRENTDATE()) < 12;
Account: => OpenedLast24Month := MONTHSBETWEEN(DateAccountOpened, CURRENTDATE()) < 24;
Account: => OpenedLast36Month := MONTHSBETWEEN(DateAccountOpened, CURRENTDATE()) < 36;
Account: => OpenedLast60Month := MONTHSBETWEEN(DateAccountOpened, CURRENTDATE()) < 60;
Account: => OpenedLast84Month := MONTHSBETWEEN(DateAccountOpened, CURRENTDATE()) < 84;

// $$$$$ Pull out common sub-expressions into their own properties
Business: => NoOpenAccounts := ALL(BusinessAccount.acc, DateAccountOpened:Null);

Business : => Sbfeopencount03m := MAP(BusinessNotOnFile => NOT_ON_FILE, 
																					NoOpenAccounts 		=> UNKNOWN_DATA, 
																					COUNT(BusinessAccount.acc(OpenedLast03Month)));
Business: => Sbfeopencount06month :=  MAP(BusinessNotOnFile => NOT_ON_FILE, 
																					NoOpenAccounts 		=> UNKNOWN_DATA, 
																					COUNT(BusinessAccount.acc(OpenedLast06Month)));
Business: => Sbfeopencount12month :=  MAP(BusinessNotOnFile => NOT_ON_FILE, 
																					NoOpenAccounts 		=> UNKNOWN_DATA, 
																					COUNT(BusinessAccount.acc(OpenedLast12Month)));
Business: => Sbfeopencount24month :=  MAP(BusinessNotOnFile => NOT_ON_FILE, 
																					NoOpenAccounts 		=> UNKNOWN_DATA, 
																					COUNT(BusinessAccount.acc(OpenedLast24Month)));
Business: => Sbfeopencount36month :=  MAP(BusinessNotOnFile => NOT_ON_FILE, 
																					NoOpenAccounts 		=> UNKNOWN_DATA, 
																					COUNT(BusinessAccount.acc(OpenedLast36Month)));
Business: => Sbfeopencount60month :=  MAP(BusinessNotOnFile => NOT_ON_FILE, 
																					NoOpenAccounts 		=> UNKNOWN_DATA, 
																					COUNT(BusinessAccount.acc(OpenedLast60Month)));
Business: => Sbfeopencount84m :=  MAP(BusinessNotOnFile => NOT_ON_FILE, 
																					NoOpenAccounts 		=> UNKNOWN_DATA, 
																					COUNT(BusinessAccount.acc(OpenedLast84Month)));
																					
Business: => DateOpenFirstSeenAll := MIN(BusinessAccount.acc, DateAccountOpened);
Business : => Sbfedateopenfirstseenall := IF(BusinessNotOnFile, NOT_ON_FILE, INTEGERFROMDATE(DateOpenFirstSeenAll));

Business: => Sbfetimeoldest := MAP(BusinessNotOnFile => NOT_ON_FILE, Sbfedateopenfirstseenall:Null => UNKNOWN_DATA, MONTHSBETWEEN(DateOpenFirstSeenAll,CURRENTDATE()) + 1);

Business: => DateOpenMostRecentAll := MAX(BusinessAccount.acc, DateAccountOpened);
Business : => Sbfedateopenmostrecentall := IF(BusinessNotOnFile, NOT_ON_FILE, INTEGERFROMDATE(DateOpenMostRecentAll));
Business: => Sbfetimenewest := MAP(BusinessNotOnFile => NOT_ON_FILE, Sbfedateopenmostrecentall:Null => UNKNOWN_DATA, MONTHSBETWEEN(DateOpenMostRecentAll,CURRENTDATE()) + 1);

////// Internal Attributes to Calculate Account Type and Status ////////
Tradeline: => DateReportedClosed := IF(date_account_closed:Null, date_account_was_charged_off, date_account_closed);
Tradeline: => ShowsClosedAccount := NOT DateReportedClosed:Null AND DateReportedClosed <= CURRENTDATE() AND NOT DateReportedClosed < date_account_opened;
Account: => MostRecentClosedReportDate := MAX(AccountTradeline.trade(ShowsClosedAccount), load_date);
//Can't use only for DateClosed because of cases where two tradelines for an account have the same cycle end date and different account closed dates
Account: => DateClosed := MAX(AccountTradeline.trade(load_date = Account.MostRecentClosedReportDate), DateReportedClosed);
Account: => DateClosedEstimated := IF(NOT DateClosed:Null, DateClosed, MIN(AccountTradeline.trade(IsClosed), cycle_end_date));
//Account: => IsInvalidAccountCloseDate := ALL(Tradeline, DateClosed:Null OR DateClosed > CURRENTDATE());

Tradeline: SET_CHARGEOFF_STATUS := ['009','011'];
Tradeline: SET_CLOSED_STATUS := ['002','003','004','005','008','009','011','016','017','018','022'];

Tradeline: => IsChargeoff := (NOT date_account_was_charged_off:Null AND date_account_was_charged_off <= CURRENTDATE()) OR //if chargeoff date is in the future, don't count as closed.
                              amount_charged_off_by_creditor > 0 OR
                              NOT charge_off_type_indicator:Null OR
                              total_charge_off_recoveries_to_date > 0 OR
                              account_status_1 IN SET_CHARGEOFF_STATUS OR
                              account_status_2 IN SET_CHARGEOFF_STATUS;

Account: => IsChargeoff := EXISTS(AccountTradeline.trade(IsChargeoff));
Tradeline: => IsClosed := NOT date_account_closed:Null OR
                          account_closure_basis != ''   OR
                          account_status_1 IN SET_CLOSED_STATUS OR
                          account_status_2 IN SET_CLOSED_STATUS OR
                          IsChargeoff;

Account: => HasClosed := EXISTS(AccountTradeline.trade(IsClosed)); //can an account be reopened?
Account: => HasClosed3Month := NOT OpenedLast03Month AND HasClosed AND MONTHSBETWEEN(DateClosedEstimated, CURRENTDATE()) >= 3; 
Account: => HasClosed6Month := NOT OpenedLast06Month AND HasClosed AND MONTHSBETWEEN(DateClosedEstimated, CURRENTDATE()) >= 6; 
Account: => HasClosed12Month := NOT OpenedLast12Month AND HasClosed AND MONTHSBETWEEN(DateClosedEstimated, CURRENTDATE()) >= 12; 
Account: => HasClosed24Month := NOT OpenedLast24Month AND HasClosed AND MONTHSBETWEEN(DateClosedEstimated, CURRENTDATE()) >= 24; 
Account: => HasClosed36Month := NOT OpenedLast36Month AND HasClosed AND MONTHSBETWEEN(DateClosedEstimated, CURRENTDATE()) >= 36; 
Account: => HasClosed60Month := NOT OpenedLast60Month AND HasClosed AND MONTHSBETWEEN(DateClosedEstimated, CURRENTDATE()) >= 60; 
Account: => HasClosed84Month := NOT OpenedLast84Month AND HasClosed AND MONTHSBETWEEN(DateClosedEstimated, CURRENTDATE()) >= 84; 

Tradeline: => IsClosedInvoluntary := account_closure_basis IN ['X','F','P','O'] OR
                                     account_status_1 IN ['017'] OR
                                     account_status_2 IN ['017'] OR
                                     IsChargeoff;
Account: => IsInvoluntaryClosure := EXISTS(AccountTradeline.trade(IsClosedInvoluntary));

Tradeline: => MonthsSinceTrade := MONTHSBETWEEN(cycle_end_date, CURRENTDATE());

Account: => LastCycleEndDate := MAX(AccountTradeline.trade, cycle_end_date);
Tradeline: AccountTradeline.acc.LastCycleEndDate = cycle_end_date => IsLastCycle := TRUE;

Account: => IsStale := NOT HasClosed AND MONTHSBETWEEN(LastCycleEndDate, CURRENTDATE()) > 12;
Account: => IsStale3Month := NOT OpenedLast03Month AND NOT HasClosed3Month AND NOT EXISTS(AccountTradeline.trade(MonthsSinceTrade >= 3 AND MonthsSinceTrade < 15));
		// MONTHSBETWEEN(LastCycleEndDate, CURRENTDATE()) > 15;
Account: => IsStale6Month := NOT OpenedLast06Month AND NOT HasClosed6Month AND NOT EXISTS(AccountTradeline.trade(MonthsSinceTrade >= 6 AND MonthsSinceTrade < 18));
Account: => IsStale12Month := NOT OpenedLast12Month AND NOT HasClosed12Month AND NOT EXISTS(AccountTradeline.trade(MonthsSinceTrade >= 12 AND MonthsSinceTrade < 24));
Account: => IsStale24Month := NOT OpenedLast24Month AND NOT HasClosed24Month AND NOT EXISTS(AccountTradeline.trade(MonthsSinceTrade >= 24 AND MonthsSinceTrade < 36));
Account: => IsStale36Month := NOT OpenedLast36Month AND NOT HasClosed36Month AND NOT EXISTS(AccountTradeline.trade(MonthsSinceTrade >= 36 AND MonthsSinceTrade < 48));
Account: => IsStale60Month := NOT OpenedLast60Month AND NOT HasClosed60Month AND NOT EXISTS(AccountTradeline.trade(MonthsSinceTrade >= 60 AND MonthsSinceTrade < 72));
Account: => IsStale84Month := NOT OpenedLast84Month AND NOT HasClosed84Month AND NOT EXISTS(AccountTradeline.trade(MonthsSinceTrade >= 84 AND MonthsSinceTrade < 96));


Account: => IsOpen := NOT HasClosed AND NOT IsStale;
Account: => IsOpen3Month := NOT OpenedLast03Month AND NOT HasClosed3Month AND NOT IsStale3Month;
Account: => IsOpen6Month := NOT OpenedLast06Month AND NOT HasClosed6Month AND NOT IsStale6Month;
Account: => IsOpen12Month := NOT OpenedLast12Month AND NOT HasClosed12Month AND NOT IsStale12Month;
Account: => IsOpen24Month := NOT OpenedLast24Month AND NOT HasClosed24Month AND NOT IsStale24Month;
Account: => IsOpen36Month := NOT OpenedLast36Month AND NOT HasClosed36Month AND NOT IsStale36Month;
Account: => IsOpen60Month := NOT OpenedLast60Month AND NOT HasClosed60Month AND NOT IsStale60Month;
Account: => IsOpen84Month := NOT OpenedLast84Month AND NOT HasClosed84Month AND NOT IsStale84Month;

Account: => Tradeline03MonthDate := MAX(AccountTradeline.trade(MonthsSinceTrade >= 3), cycle_end_date);
Account: => Tradeline03MonthLoadDate := MAX(AccountTradeline.trade(cycle_end_date = Account.Tradeline03MonthDate), load_date);
Account: => Hist03MTradeline := ONLY(AccountTradeline.trade(cycle_end_date = Account.Tradeline03MonthDate AND load_date = Account.Tradeline03MonthLoadDate));

Account: => Tradeline06MonthDate := MAX(AccountTradeline.trade(MonthsSinceTrade >= 6), cycle_end_date);
Account: => Tradeline06MonthLoadDate := MAX(AccountTradeline.trade(cycle_end_date = Account.Tradeline06MonthDate), load_date);
Account: => Hist06MTradeline := ONLY(AccountTradeline.trade(cycle_end_date = Account.Tradeline06MonthDate AND load_date = Account.Tradeline06MonthLoadDate));

Account: => Tradeline12MonthDate := MAX(AccountTradeline.trade(MonthsSinceTrade >= 12), cycle_end_date);
Account: => Tradeline12MonthLoadDate := MAX(AccountTradeline.trade(cycle_end_date = Account.Tradeline12MonthDate), load_date);
Account: => Hist12MTradeline := ONLY(AccountTradeline.trade(cycle_end_date = Account.Tradeline12MonthDate AND load_date = Account.Tradeline12MonthLoadDate));

Account: => Tradeline24MonthDate := MAX(AccountTradeline.trade(MonthsSinceTrade >= 24), cycle_end_date);
Account: => Tradeline24MonthLoadDate := MAX(AccountTradeline.trade(cycle_end_date = Account.Tradeline24MonthDate), load_date);
Account: => Hist24MTradeline := ONLY(AccountTradeline.trade(cycle_end_date = Account.Tradeline24MonthDate AND load_date = Account.Tradeline24MonthLoadDate));

Account: => Tradeline36MonthDate := MAX(AccountTradeline.trade(MonthsSinceTrade >= 36), cycle_end_date);
Account: => Tradeline36MonthLoadDate := MAX(AccountTradeline.trade(cycle_end_date = Account.Tradeline36MonthDate), load_date);
Account: => Hist36MTradeline := ONLY(AccountTradeline.trade(cycle_end_date = Account.Tradeline36MonthDate AND load_date = Account.Tradeline36MonthLoadDate));

Account: => Tradeline60MonthDate := MAX(AccountTradeline.trade(MonthsSinceTrade >= 60), cycle_end_date);
Account: => Tradeline60MonthLoadDate := MAX(AccountTradeline.trade(cycle_end_date = Account.Tradeline60MonthDate), load_date);
Account: => Hist60MTradeline := ONLY(AccountTradeline.trade(cycle_end_date = Account.Tradeline60MonthDate AND load_date = Account.Tradeline60MonthLoadDate));

Account: => Tradeline84MonthDate := MAX(AccountTradeline.trade(MonthsSinceTrade >= 84), cycle_end_date);
Account: => Tradeline84MonthLoadDate := MAX(AccountTradeline.trade(cycle_end_date = Account.Tradeline84MonthDate), load_date);
Account: => Hist84MTradeline := ONLY(AccountTradeline.trade(cycle_end_date = Account.Tradeline84MonthDate AND load_date = Account.Tradeline84MonthLoadDate));


Account: => IsZeroBalancePastYear := ALL(AccountTradeline.trade(Is12Month), remaining_balance = 0);
Account: => NoPaymentRecievedPastYear := ALL(AccountTradeline.trade(Is12Month), recent_payment_date:Null);
Account: => IsInactive := IsOpen AND 
				(EXISTS(AccountTradeline.trade(IsLastCycle AND recent_activity_indicator = 'N')) OR
				(EXISTS(AccountTradeline.trade(IsLastCycle AND recent_activity_indicator:Null)) AND
				IsZeroBalancePastYear AND NoPaymentRecievedPastYear) OR IsInvalidAccountOpenDate);

Account: => IsActive := IsOpen AND 
				((EXISTS(AccountTradeline.trade(IsLastCycle AND recent_activity_indicator = 'Y')) OR
				(EXISTS(AccountTradeline.trade(IsLastCycle AND recent_activity_indicator:Null)) AND
				(NOT IsZeroBalancePastYear OR NOT NoPaymentRecievedPastYear))) AND NOT IsInvalidAccountOpenDate);



Account: => MostRecentTypeReportDate := MAX(AccountTradeline.trade(NOT account_type_reported:Null), load_date);

Account: => AccountType := ONLY(AccountTradeline.trade(load_date = Account.MostRecentTypeReportDate), account_type_reported);
Account: => IsLoan := AccountType = 1;
Account: => IsLine := AccountType = 2;
Account: => IsCard := AccountType = 3;
Account: => IsLease := AccountType = 4;
Account: => IsLetter := AccountType = 5;
Account: => IsOLine := AccountType = 6;
Account: => IsOther := AccountType = 99;

Account: => TypeOfAcct := MAP(IsLoan => 	'Loan', 
															IsLine => 	'Line', 
															IsCard => 	'Card',
                              IsLease =>  'Lease', 
															IsLetter => 'Letter', 
															IsOLine => 	'OLine',
                              IsOther => 	'Other', 
																					'unknown');
																																						
////////////////////////////////////////////////////////////////////////

Business: => DateClosedMostRecentAll := BusinessAccount.acc.DateClosed$Max;
Business: => Sbfedateclosedmostrecentall := MAP(BusinessNotOnFile	=> NOT_ON_FILE, 
																								NOT EXISTS(BusinessAccount.acc(HasClosed)) 	=> NO_DATA_AVAILABLE,
																								INTEGERFROMDATE(DateClosedMostRecentAll));
Business: => Sbfetimenewestclosed := MAP(BusinessNotOnFile => NOT_ON_FILE, 
																				 Sbfedateclosedmostrecentall=NO_DATA_AVAILABLE => NO_DATA_AVAILABLE,
                                         Sbfedateclosedmostrecentall:Null => UNKNOWN_DATA, 
																				 MONTHSBETWEEN(DateClosedMostRecentAll,CURRENTDATE()) + 1);

Business: => Sbfeloancount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsLoan):Count);
Business: => DateOpenFirstSeenLoan := MIN(BusinessAccount.acc(IsLoan), DateAccountOpened);
Business: => Sbfedateopenfirstseenloan := MAP(BusinessNotOnFile => NOT_ON_FILE, 
																					Sbfeloancount = 0 => NO_DATA_AVAILABLE,
                                          INTEGERFROMDATE(DateOpenFirstSeenLoan));
Business: => Sbfetimeoldestloan := MAP(BusinessNotOnFile => NOT_ON_FILE, Sbfeloancount=0 => NO_DATA_AVAILABLE,
                                          Sbfedateopenfirstseenloan:Null => UNKNOWN_DATA, MONTHSBETWEEN(DateOpenFirstSeenLoan, CURRENTDATE()) + 1);

Business: => DateOpenMostRecentLoan :=  MAX(BusinessAccount.acc(IsLoan), DateAccountOpened);
Business: => Sbfedateopenmostrecentloan := MAP(BusinessNotOnFile => NOT_ON_FILE, Sbfeloancount = 0 => NO_DATA_AVAILABLE,
                                                                                         INTEGERFROMDATE(DateOpenMostRecentLoan));
Business: => Sbfetimenewestloan := MAP(BusinessNotOnFile => NOT_ON_FILE, Sbfeloancount = 0 => NO_DATA_AVAILABLE,
                                                                             Sbfedateopenmostrecentloan:Null => UNKNOWN_DATA, MONTHSBETWEEN(DateOpenMostRecentLoan, CURRENTDATE()) + 1);

Business: => DateClosedMostRecentLoan :=    MAX(BusinessAccount.acc(IsLoan), DateClosed);
Business: => Sbfedateclosedmostrecentloan := MAP(BusinessNotOnFile => NOT_ON_FILE, NOT EXISTS(BusinessAccount.acc(HasClosed AND IsLoan)) => NO_DATA_AVAILABLE,
                                                                                           INTEGERFROMDATE(DateClosedMostRecentLoan));
Business: => Sbfetimenewestclosedloan := MAP(BusinessNotOnFile => NOT_ON_FILE, NOT EXISTS(BusinessAccount.acc(HasClosed AND IsLoan)) => NO_DATA_AVAILABLE,
                                                                                     Sbfedateclosedmostrecentloan:Null => UNKNOWN_DATA, MONTHSBETWEEN(DateClosedMostRecentLoan, CURRENTDATE()) + 1);

Business: => Sbfelinecount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsLine):Count);

Business: => DateOpenFirstSeenLine := MIN(BusinessAccount.acc(IsLine), DateAccountOpened);
Business: => Sbfedateopenfirstseenline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			 Sbfelinecount = 0 => NO_DATA_AVAILABLE,
																			 INTEGERFROMDATE(DateOpenFirstSeenLine));
Business: => Sbfetimeoldestline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			 Sbfelinecount = 0 => NO_DATA_AVAILABLE,
																			 Sbfedateopenfirstseenline:Null => UNKNOWN_DATA,
																			 MONTHSBETWEEN(DateOpenFirstSeenLine, CURRENTDATE()) + 1);

Business: => DateOpenMostRecentLine := MAX(BusinessAccount.acc(IsLine), DateAccountOpened);
Business: => Sbfedateopenmostrecentline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfelinecount = 0 => NO_DATA_AVAILABLE,
																			INTEGERFROMDATE(DateOpenMostRecentLine));
Business: => Sbfetimenewestline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfelinecount = 0 => NO_DATA_AVAILABLE,
																			Sbfedateopenmostrecentline:Null => UNKNOWN_DATA,
																			MONTHSBETWEEN(DateOpenMostRecentLine, CURRENTDATE()) + 1);

Business: => DateClosedMostRecentLine := MAX(BusinessAccount.acc(IsLine),DateClosed);
Business: => Sbfedateclosedmostrecentline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					NOT EXISTS(BusinessAccount.acc(HasClosed AND IsLine)) => NO_DATA_AVAILABLE,
																					INTEGERFROMDATE(DateClosedMostRecentLine));
Business: => Sbfetimenewestclosedline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					NOT EXISTS(BusinessAccount.acc(HasClosed AND IsLine)) => NO_DATA_AVAILABLE,
																					Sbfedateclosedmostrecentline:Null => UNKNOWN_DATA,
																					MONTHSBETWEEN(DateClosedMostRecentLine, CURRENTDATE()) + 1);

Business: => Sbfecardcount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsCard):Count);

Business: => DateOpenFirstSeenCard := MIN(BusinessAccount.acc(IsCard), DateAccountOpened);
Business: => Sbfedateopenfirstseencard := MAP(BusinessNotOnFile => NOT_ON_FILE,
																						Sbfecardcount = 0 => NO_DATA_AVAILABLE,
																						INTEGERFROMDATE(DateOpenFirstSeenCard));
Business: => Sbfetimeoldestcard := MAP(BusinessNotOnFile => NOT_ON_FILE,
																						Sbfecardcount = 0 => NO_DATA_AVAILABLE,
																						Sbfedateopenfirstseencard:Null => UNKNOWN_DATA,
																						MONTHSBETWEEN(DateOpenFirstSeenCard, CURRENTDATE()) + 1);

Business: => DateOpenMostRecentCard := MAX(BusinessAccount.acc(IsCard), DateAccountOpened);
Business: => Sbfedateopenmostrecentcard := MAP(BusinessNotOnFile => NOT_ON_FILE,
																						Sbfecardcount = 0 => NO_DATA_AVAILABLE,
																						INTEGERFROMDATE(DateOpenMostRecentCard));
Business: => Sbfetimenewestcard := MAP(BusinessNotOnFile => NOT_ON_FILE,
																						Sbfecardcount = 0 => NO_DATA_AVAILABLE,
																						Sbfedateopenmostrecentcard:Null => UNKNOWN_DATA,
																						MONTHSBETWEEN(DateOpenMostRecentCard, CURRENTDATE()) + 1);

Business: => DateClosedMostRecentCard := MAX(BusinessAccount.acc(IsCard),DateClosed);
Business: => Sbfedateclosedmostrecentcard := MAP(BusinessNotOnFile => NOT_ON_FILE,
																						NOT EXISTS(BusinessAccount.acc(HasClosed AND IsCard)) => NO_DATA_AVAILABLE,
																						INTEGERFROMDATE(DateClosedMostRecentCard));
Business: => Sbfetimenewestclosedcard := MAP(BusinessNotOnFile => NOT_ON_FILE,
																						NOT EXISTS(BusinessAccount.acc(HasClosed AND IsCard)) => NO_DATA_AVAILABLE,
																						Sbfedateclosedmostrecentcard:Null => UNKNOWN_DATA,
																						MONTHSBETWEEN(DateClosedMostRecentCard, CURRENTDATE()) + 1);

Business: => Sbfeleasecount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsLease):Count);

Business: => DateOpenFirstSeenLease := MIN(BusinessAccount.acc(IsLease), DateAccountOpened);
Business: => Sbfedateopenfirstseenlease := MAP(BusinessNotOnFile => NOT_ON_FILE,
																						Sbfeleasecount = 0 => NO_DATA_AVAILABLE,
																						INTEGERFROMDATE(DateOpenFirstSeenLease));
Business: => Sbfetimeoldestlease := MAP(BusinessNotOnFile => NOT_ON_FILE,
																						Sbfeleasecount = 0 => NO_DATA_AVAILABLE,
																						Sbfedateopenfirstseenlease:Null => UNKNOWN_DATA,
																						MONTHSBETWEEN(DateOpenFirstSeenLease, CURRENTDATE()) + 1);

Business: => DateOpenMostRecentLease := MAX(BusinessAccount.acc(IsLease), DateAccountOpened);
Business: => Sbfedateopenmostrecentlease := MAP(BusinessNotOnFile => NOT_ON_FILE,
																						Sbfeleasecount = 0 => NO_DATA_AVAILABLE,
																						INTEGERFROMDATE(DateOpenMostRecentLease));
Business: => Sbfetimenewestlease := MAP(BusinessNotOnFile => NOT_ON_FILE,
																						Sbfeleasecount = 0 => NO_DATA_AVAILABLE,
																						Sbfedateopenmostrecentlease:Null 	=> UNKNOWN_DATA,
																						MONTHSBETWEEN(DateOpenMostRecentLease, CURRENTDATE()) + 1);

Business: => DateClosedMostRecentLease := MAX(BusinessAccount.acc(IsLease),DateClosed);
Business: => Sbfedateclosedmostrecentlease := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					   NOT EXISTS(BusinessAccount.acc(HasClosed AND IsLease)) => NO_DATA_AVAILABLE,
																						 INTEGERFROMDATE(DateClosedMostRecentLease));
Business: => Sbfetimenewestclosedlease := MAP(BusinessNotOnFile => NOT_ON_FILE,
																						 NOT EXISTS(BusinessAccount.acc(HasClosed AND IsLease)) => NO_DATA_AVAILABLE,
																						 Sbfedateclosedmostrecentlease:Null => UNKNOWN_DATA,
																						 MONTHSBETWEEN(DateClosedMostRecentLease, CURRENTDATE()) + 1);

Business: => Sbfelettercount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsLetter):Count);

Business: => DateOpenFirstSeenLetter := MIN(BusinessAccount.acc(IsLetter), DateAccountOpened);
Business: => Sbfedateopenfirstseenletter := MAP(BusinessNotOnFile	=> NOT_ON_FILE,
																					Sbfelettercount = 0	=> NO_DATA_AVAILABLE,
																					INTEGERFROMDATE(DateOpenFirstSeenLetter));
Business: => Sbfetimeoldestletter := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfelettercount = 0 => NO_DATA_AVAILABLE,
																					Sbfedateopenfirstseenletter:Null => UNKNOWN_DATA,
																					MONTHSBETWEEN(DateOpenFirstSeenLetter, CURRENTDATE()) + 1);

Business: => DateOpenMostRecentLetter := MAX(BusinessAccount.acc(IsLetter), DateAccountOpened);
Business: => Sbfedateopenmostrecentletter := MAP(BusinessNotOnFile 		=> NOT_ON_FILE,
																					Sbfelettercount = 0	=> NO_DATA_AVAILABLE,
																					INTEGERFROMDATE(DateOpenMostRecentLetter));
Business: => Sbfetimenewestletter := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfelettercount = 0 => NO_DATA_AVAILABLE,
																					Sbfedateopenmostrecentletter:Null => UNKNOWN_DATA,
																					MONTHSBETWEEN(DateOpenMostRecentLetter, CURRENTDATE()) + 1);

Business: => DateClosedMostRecentLetter := MAX(BusinessAccount.acc(IsLetter),DateClosed);
Business: => Sbfedateclosedmostrecentletter := MAP(BusinessNotOnFile=> NOT_ON_FILE,
																					NOT EXISTS(BusinessAccount.acc(HasClosed AND IsLetter)) => NO_DATA_AVAILABLE,
																					INTEGERFROMDATE(DateClosedMostRecentLetter));
Business: => Sbfetimenewestclosedletter := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					NOT EXISTS(BusinessAccount.acc(HasClosed AND IsLetter)) => NO_DATA_AVAILABLE,
																					Sbfedateclosedmostrecentletter:Null => UNKNOWN_DATA,
																					MONTHSBETWEEN(DateClosedMostRecentLetter, CURRENTDATE()) + 1);

Business: => Sbfeolinecount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOLine):Count);

Business: => DateOpenFirstSeenOLine := MIN(BusinessAccount.acc(IsOLine), DateAccountOpened);
Business: => Sbfedateopenfirstseenoline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeolinecount = 0 => NO_DATA_AVAILABLE,
																					INTEGERFROMDATE(DateOpenFirstSeenOLine));
Business: => Sbfetimeoldestoeline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeolinecount = 0 => NO_DATA_AVAILABLE,
																					Sbfedateopenfirstseenoline:Null => UNKNOWN_DATA,
																					MONTHSBETWEEN(DateOpenFirstSeenOLine, CURRENTDATE()) + 1);

Business: => DateOpenMostRecentOLine := MAX(BusinessAccount.acc(IsOLine), DateAccountOpened);
Business: => Sbfedateopenmostrecentoline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeolinecount = 0 => NO_DATA_AVAILABLE,
																					INTEGERFROMDATE(DateOpenMostRecentOLine));
Business: => Sbfetimenewestoeline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeolinecount = 0 => NO_DATA_AVAILABLE,
																					Sbfedateopenmostrecentoline:Null => UNKNOWN_DATA,
																					MONTHSBETWEEN(DateOpenMostRecentOLine, CURRENTDATE()) + 1);

Business: => DateClosedMostRecentOLine := MAX(BusinessAccount.acc(IsOLine),DateClosed);
Business: => Sbfedateclosedmostrecentoline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					NOT EXISTS(BusinessAccount.acc(HasClosed AND IsOLine)) => NO_DATA_AVAILABLE,
																					INTEGERFROMDATE(DateClosedMostRecentOLine));
Business: => Sbfetimenewestclosedoeline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					NOT EXISTS(BusinessAccount.acc(HasClosed AND IsOLine)) => NO_DATA_AVAILABLE,
																					Sbfedateclosedmostrecentoline:Null => UNKNOWN_DATA,
																					MONTHSBETWEEN(DateClosedMostRecentOLine, CURRENTDATE()) + 1);

Business: => Sbfeothercount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOther):Count);

Business: => DateOpenFirstSeenOther := MIN(BusinessAccount.acc(IsOther), DateAccountOpened);
Business: => Sbfedateopenfirstseenother := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeothercount = 0 => NO_DATA_AVAILABLE,
																					INTEGERFROMDATE(DateOpenFirstSeenOther));
Business: => Sbfetimeoldestother := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeothercount = 0 => NO_DATA_AVAILABLE,
																					Sbfedateopenfirstseenother:Null => UNKNOWN_DATA,
																					MONTHSBETWEEN(DateOpenFirstSeenOther, CURRENTDATE()) + 1);

Business: => DateOpenMostRecentOther := MAX(BusinessAccount.acc(IsOther), DateAccountOpened);
Business: => Sbfedateopenmostrecentother := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeothercount = 0 => NO_DATA_AVAILABLE,
																					INTEGERFROMDATE(DateOpenMostRecentOther));
Business: => Sbfetimenewestother := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeothercount = 0 => NO_DATA_AVAILABLE,
																					Sbfedateopenmostrecentother:Null => UNKNOWN_DATA,
																					MONTHSBETWEEN(DateOpenMostRecentOther, CURRENTDATE()) + 1);
Business: => DateClosedMostRecentOther := MAX(BusinessAccount.acc(IsOther),DateClosed);
Business: => Sbfedateclosedmostrecentother := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					NOT EXISTS(BusinessAccount.acc(HasClosed AND IsOther)) => NO_DATA_AVAILABLE,
																					INTEGERFROMDATE(DateClosedMostRecentOther));
Business: => Sbfetimenewestclosedother := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					NOT EXISTS(BusinessAccount.acc(HasClosed AND IsOther)) => NO_DATA_AVAILABLE,
																					Sbfedateclosedmostrecentother:Null => UNKNOWN_DATA,
																					MONTHSBETWEEN(DateClosedMostRecentOther, CURRENTDATE()) + 1);

Business: => Sbfeopenallcount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen):Count);
Business: => Sbfeopencounthist03m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen3Month):Count);
Business: => Sbfeopencounthist06m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen6Month):Count);
Business: => Sbfeopencounthist12m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen12Month):Count);
Business: => Sbfeopencounthist24m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen24Month):Count);
Business: => Sbfeopencounthist36m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen36Month):Count);
Business: => Sbfeopencounthist60m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen60Month):Count);
Business: => Sbfeopencounthist84m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen84Month):Count);

Business: => Sbfeopenloancount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen AND IsLoan):Count);
Business: => Sbfeopenloancount03m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen3Month AND IsLoan):Count);
Business: => Sbfeopenloancount06m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen6Month AND IsLoan):Count);
Business: => Sbfeopenloancount12m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen12Month AND IsLoan):Count);
Business: => Sbfeopenloancount24m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen24Month AND IsLoan):Count);
Business: => Sbfeopenloancount36m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen36Month AND IsLoan):Count);
Business: => Sbfeopenloancount60m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen60Month AND IsLoan):Count);
Business: => Sbfeopenloancount84m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen84Month AND IsLoan):Count);

Business: => Sbfeopenlinecount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen AND IsLine):Count);
Business: => Sbfeopenlinecount03m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen3Month AND IsLine):Count);
Business: => Sbfeopenlinecount06m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen6Month AND IsLine):Count);
Business: => Sbfeopenlinecount12m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen12Month AND IsLine):Count);
Business: => Sbfeopenlinecount24m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen24Month AND IsLine):Count);
Business: => Sbfeopenlinecount36m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen36Month AND IsLine):Count);
Business: => Sbfeopenlinecount60m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen60Month AND IsLine):Count);
Business: => Sbfeopenlinecount84m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen84Month AND IsLine):Count);

Business: => Sbfeopencardcount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen AND IsCard):Count);
Business: => Sbfeopencardcount03m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen3Month AND IsCard):Count);
Business: => Sbfeopencardcount06m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen6Month AND IsCard):Count);
Business: => Sbfeopencardcount12m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen12Month AND IsCard):Count);
Business: => Sbfeopencardcount24m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen24Month AND IsCard):Count);
Business: => Sbfeopencardcount36m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen36Month AND IsCard):Count);
Business: => Sbfeopencardcount60m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen60Month AND IsCard):Count);
Business: => Sbfeopencardcount84m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen84Month AND IsCard):Count);


Business: => Sbfeopenleasecount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen AND IsLease):Count);
Business: => Sbfeopenleasecount03m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen3Month AND IsLease):Count);
Business: => Sbfeopenleasecount06m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen6Month AND IsLease):Count);
Business: => Sbfeopenleasecount12m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen12Month AND IsLease):Count);
Business: => Sbfeopenleasecount24m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen24Month AND IsLease):Count);
Business: => Sbfeopenleasecount36m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen36Month AND IsLease):Count);
Business: => Sbfeopenleasecount60m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen60Month AND IsLease):Count);
Business: => Sbfeopenleasecount84m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen84Month AND IsLease):Count);

Business: => Sbfeopenlettercount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen AND IsLetter):Count);
Business: => Sbfeopenlettercount03m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen3Month AND IsLetter):Count);
Business: => Sbfeopenlettercount06m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen6Month AND IsLetter):Count);
Business: => Sbfeopenlettercount12m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen12Month AND IsLetter):Count);
Business: => Sbfeopenlettercount24m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen24Month AND IsLetter):Count);
Business: => Sbfeopenlettercount36m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen36Month AND IsLetter):Count);
Business: => Sbfeopenlettercount60m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen60Month AND IsLetter):Count);
Business: => Sbfeopenlettercount84m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen84Month AND IsLetter):Count);

Business: => Sbfeopenolinecount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen AND IsOLine):Count);
Business: => Sbfeopenoelinecount03m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen3Month AND IsOLine):Count);
Business: => Sbfeopenoelinecount06m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen6Month AND IsOLine):Count);
Business: => Sbfeopenoelinecount12m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen12Month AND IsOLine):Count);
Business: => Sbfeopenoelinecount24m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen24Month AND IsOLine):Count);
Business: => Sbfeopenoelinecount36m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen36Month AND IsOLine):Count);
Business: => Sbfeopenoelinecount60m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen60Month AND IsOLine):Count);
Business: => Sbfeopenoelinecount84m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen84Month AND IsOLine):Count);

Business: => Sbfeopenothercount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen AND IsOther):Count);
Business: => Sbfeopenothercount03m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen3Month AND IsOther):Count);
Business: => Sbfeopenothercount06m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen6Month AND IsOther):Count);
Business: => Sbfeopenothercount12m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen12Month AND IsOther):Count);
Business: => Sbfeopenothercount24m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen24Month AND IsOther):Count);
Business: => Sbfeopenothercount36m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen36Month AND IsOther):Count);
Business: => Sbfeopenothercount60m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen60Month AND IsOther):Count);
Business: => Sbfeopenothercount84m := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsOpen84Month AND IsOther):Count);


Business: => Sbfeopentypecount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenallcount=0 => NO_DATA_AVAILABLE,
																	IF(Sbfeopenloancount > 0, 1, 0) +
																	IF(Sbfeopenlinecount > 0, 1, 0) +
																	IF(Sbfeopencardcount > 0, 1, 0) +
																	IF(Sbfeopenleasecount > 0, 1, 0) +
																	IF(Sbfeopenlettercount > 0, 1, 0) +
																	IF(Sbfeopenolinecount > 0, 1, 0) +
																	IF(Sbfeopenothercount > 0, 1, 0));
Business: => Sbfeopencardcountonly := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenallcount=0 => NO_DATA_AVAILABLE,
																	IF(Sbfeopenloancount = 0 AND
																	Sbfeopenlinecount = 0 AND
																	Sbfeopencardcount > 0 AND
																	Sbfeopenleasecount = 0 AND
																	Sbfeopenlettercount = 0 AND
																	Sbfeopenolinecount = 0 AND
																	Sbfeopenothercount = 0, 1, 0));

Business: => Sbfeactivecount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsActive):Count);
Business: => Sbfeactiveloancount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsActive AND IsLoan):Count);
Business: => Sbfeactivelinecount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsActive AND IsLine):Count);
Business: => Sbfeactivecardcount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsActive AND IsCard):Count);
Business: => Sbfeactiveleasecount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsActive AND IsLease):Count);
Business: => Sbfeactivelettercount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsActive AND IsLetter):Count);
Business: => Sbfeactiveoline := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsActive AND IsOLine):Count);
Business: => Sbfeactiveothercount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsActive AND IsOther):Count);

Business: => Sbfeclosedcount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(HasClosed):Count);
Business: => Sbfeclosedcountloan := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(HasClosed AND IsLoan):Count);
Business: => Sbfeclosedcountline := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(HasClosed AND IsLine):Count);
Business: => Sbfeclosedcountcard := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(HasClosed AND IsCard):Count);
Business: => Sbfeclosedcountlease := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(HasClosed AND IsLease):Count);
Business: => Sbfeclosedcountletter := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(HasClosed AND IsLetter):Count);
Business: => Sbfeclosedcountoline := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(HasClosed AND IsOLine):Count);
Business: => Sbfeclosedcountother := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(HasClosed AND IsOther):Count);

Business: => Sbfeclosedcountinvoluntary := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsInvoluntaryClosure):Count);
Business: => Sbfeclosedcountvoluntary := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(HasClosed AND NOT IsInvoluntaryClosure):Count);
Business: => Sbfestaleclosedcount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsStale):Count);
Business: => Sbfestaleclosedcountloan := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsStale AND IsLoan):Count);
Business: => Sbfestaleclosedcountline := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsStale AND IsLine):Count);
Business: => Sbfestaleclosedcountcard := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsStale AND IsCard):Count);
Business: => Sbfestaleclosedcountlease := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsStale AND IsLease):Count);
Business: => Sbfestaleclosedcountletter := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsStale AND IsLetter):Count);
Business: => Sbfestaleclosedcountoline := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsStale AND IsOLine):Count);
Business: => Sbfestaleclosedcountother := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsStale AND IsOther):Count);
Business: => Sbfeinactivecount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsInactive):Count);
Business: => Sbfeinactiveloancount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsInactive AND IsLoan):Count);
Business: => Sbfeinactivelinecount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsInactive AND IsLine):Count);
Business: => Sbfeinactivecardcount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsInactive AND IsCard):Count);
Business: => Sbfeinactiveleasecount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsInactive AND IsLease):Count);
Business: => Sbfeinactivelettercount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsInactive AND IsLetter):Count);
Business: => Sbfeinactiveolinecount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsInactive AND IsOLine):Count);
Business: => Sbfeinactiveothercount := IF(BusinessNotOnFile, NOT_ON_FILE, BusinessAccount.acc(IsInactive AND IsOther):Count);


Tradeline: => AccountBalance := IF(remaining_balance < 0 AND NOT remaining_balance:Null, 0, remaining_balance);
//Account: => MostRecentBalanceDate := MAX(Tradeline(NOT AccountBalance:Null), load_date);
Account: => MostRecentBalanceDate := MAX(AccountTradeline.trade, load_date);

//Can't use only
Account: => AccountBalance := MAX(AccountTradeline.trade(load_date = Account.MostRecentBalanceDate), AccountBalance);
Account: => IsNullAccountBalance := AccountBalance:Null;

Account: => IsPositiveBalance := AccountBalance > 0 AND NOT AccountBalance:Null;
Account: => IsPositiveBalance03M := Hist03MTradeline.AccountBalance > 0 AND NOT Hist03MTradeline.AccountBalance:Null;
Account: => IsPositiveBalance06M := Hist06MTradeline.AccountBalance > 0 AND NOT Hist06MTradeline.AccountBalance:Null;
Account: => IsPositiveBalance12M := Hist12MTradeline.AccountBalance > 0 AND NOT Hist12MTradeline.AccountBalance:Null;
Account: => IsPositiveBalance24M := Hist24MTradeline.AccountBalance > 0 AND NOT Hist24MTradeline.AccountBalance:Null;
Account: => IsPositiveBalance36M := Hist36MTradeline.AccountBalance > 0 AND NOT Hist36MTradeline.AccountBalance:Null;
Account: => IsPositiveBalance60M := Hist60MTradeline.AccountBalance > 0 AND NOT Hist60MTradeline.AccountBalance:Null;
Account: => IsPositiveBalance84M := Hist84MTradeline.AccountBalance > 0 AND NOT Hist84MTradeline.AccountBalance:Null;


Business: => Sbferecentbalanceall := MAP(BusinessNotOnFile => NOT_ON_FILE,
																		  COUNT(BusinessAccount.acc(IsOpen)) = 0 => NO_DATA_AVAILABLE,
																		  ALL(BusinessAccount.acc(IsOpen), AccountBalance:Null) => UNKNOWN_DATA, //should include 0s
																			SUM(BusinessAccount.acc(IsOpen AND IsPositiveBalance), AccountBalance));
Business: => Sbferecentbalanceloan := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			COUNT(BusinessAccount.acc(IsOpen AND IsLoan)) = 0	=> NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen AND IsLoan), AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen AND IsLoan AND IsPositiveBalance), AccountBalance));
Business: => Sbferecentbalanceline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			COUNT(BusinessAccount.acc(IsOpen AND IsLine)) = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen AND IsLine), AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen AND IsLine AND IsPositiveBalance), AccountBalance));
Business: => Sbferecentbalancecard := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			COUNT(BusinessAccount.acc(IsOpen AND IsCard)) = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen AND IsCard), AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen AND IsCard AND IsPositiveBalance), AccountBalance));
Business: => Sbferecentbalancelease := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			COUNT(BusinessAccount.acc(IsOpen AND IsLease)) = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen AND IsLease), AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen AND IsLease AND IsPositiveBalance), AccountBalance));
Business: => Sbferecentbalanceletter := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			COUNT(BusinessAccount.acc(IsOpen AND IsLetter)) = 0	=> NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen AND IsLetter), AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen AND IsLetter AND IsPositiveBalance), AccountBalance));
Business: => Sbferecentbalanceoline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			COUNT(BusinessAccount.acc(IsOpen AND IsOLine)) = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen AND IsOLine), AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen AND IsOLine AND IsPositiveBalance), AccountBalance));
Business: => Sbferecentbalanceother := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			COUNT(BusinessAccount.acc(IsOpen AND IsOther)) = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen AND IsOther), AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen AND IsOther AND IsPositiveBalance), AccountBalance));
Business: => Sbferecentbalancerevamt := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			COUNT(BusinessAccount.acc(IsOpen AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen AND IsRevolvingAccount), AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen AND IsRevolvingAccount AND IsPositiveBalance), AccountBalance));
Business: => Sbferecentbalanceinstamt := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			COUNT(BusinessAccount.acc(IsOpen AND IsInstallment)) = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen AND IsInstallment), AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen AND IsInstallment AND IsPositiveBalance), AccountBalance));
																			
Business: => Sbfebalanceamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopencounthist03m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen3Month), Hist03MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen3Month AND IsPositiveBalance03M), Hist03MTradeline.AccountBalance));
Business: => Sbfebalanceamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopencounthist06m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen6Month), Hist06MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen6Month AND IsPositiveBalance06M), Hist06MTradeline.AccountBalance));
Business: => Sbfebalanceamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopencounthist12m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen12Month), Hist12MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen12Month AND IsPositiveBalance12M), Hist12MTradeline.AccountBalance));
Business: => Sbfebalanceamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopencounthist24m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen24Month), Hist24MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen24Month AND IsPositiveBalance24M), Hist24MTradeline.AccountBalance));
Business: => Sbfebalanceamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopencounthist36m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen36Month), Hist36MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen36Month AND IsPositiveBalance36M), Hist36MTradeline.AccountBalance));
Business: => Sbfebalanceamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopencounthist60m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen60Month), Hist60MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen60Month AND IsPositiveBalance60M), Hist60MTradeline.AccountBalance));
Business: => Sbfebalanceamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopencounthist84m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen84Month), Hist84MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen84Month AND IsPositiveBalance84M), Hist84MTradeline.AccountBalance));
																			
Business: => Sbfebalanceamtloan03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenloancount03m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen3Month AND IsLoan), Hist03MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen3Month AND IsPositiveBalance03M AND IsLoan), Hist03MTradeline.AccountBalance));
Business: => Sbfebalanceamtloan06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenloancount06m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen6Month AND IsLoan), Hist06MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen6Month AND IsPositiveBalance06M AND IsLoan), Hist06MTradeline.AccountBalance));
Business: => Sbfebalanceamtloan12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenloancount12m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen12Month AND IsLoan), Hist12MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen12Month AND IsPositiveBalance12M AND IsLoan), Hist12MTradeline.AccountBalance));
Business: => Sbfebalanceamtloan24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenloancount24m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen24Month AND IsLoan), Hist24MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen24Month AND IsPositiveBalance24M AND IsLoan), Hist24MTradeline.AccountBalance));
Business: => Sbfebalanceamtloan36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenloancount36m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen36Month AND IsLoan), Hist36MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen36Month AND IsPositiveBalance36M AND IsLoan), Hist36MTradeline.AccountBalance));
Business: => Sbfebalanceamtloan60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenloancount60m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen60Month AND IsLoan), Hist60MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen60Month AND IsPositiveBalance60M AND IsLoan), Hist60MTradeline.AccountBalance));
Business: => Sbfebalanceamtloan84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenloancount84m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen84Month AND IsLoan), Hist84MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen84Month AND IsPositiveBalance84M AND IsLoan), Hist84MTradeline.AccountBalance));

Business: => Sbfebalanceamtline03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenlinecount03m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen3Month AND IsLine), Hist03MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen3Month AND IsPositiveBalance03M AND IsLine), Hist03MTradeline.AccountBalance));
Business: => Sbfebalanceamtline06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenlinecount06m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen6Month AND IsLine), Hist06MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen6Month AND IsPositiveBalance06M AND IsLine), Hist06MTradeline.AccountBalance));
Business: => Sbfebalanceamtline12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenlinecount12m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen12Month AND IsLine), Hist12MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen12Month AND IsPositiveBalance12M AND IsLine), Hist12MTradeline.AccountBalance));
Business: => Sbfebalanceamtline24m :=  MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenlinecount24m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen24Month AND IsLine), Hist24MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen24Month AND IsPositiveBalance24M AND IsLine), Hist24MTradeline.AccountBalance));
Business: => Sbfebalanceamtline36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenlinecount36m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen36Month AND IsLine), Hist36MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen36Month AND IsPositiveBalance36M AND IsLine), Hist36MTradeline.AccountBalance));
Business: => Sbfebalanceamtline60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenlinecount60m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen60Month AND IsLine), Hist60MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen60Month AND IsPositiveBalance60M AND IsLine), Hist60MTradeline.AccountBalance));
Business: => Sbfebalanceamtline84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenlinecount84m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen84Month AND IsLine), Hist84MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen84Month AND IsPositiveBalance84M AND IsLine), Hist84MTradeline.AccountBalance));

Business: => Sbfebalanceamtcard03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopencardcount03m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen3Month AND IsCard), Hist03MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen3Month AND IsPositiveBalance03M AND IsCard), Hist03MTradeline.AccountBalance));
Business: => Sbfebalanceamtcard06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopencardcount06m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen6Month AND IsCard), Hist06MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen6Month AND IsPositiveBalance06M AND IsCard), Hist06MTradeline.AccountBalance));
Business: => Sbfebalanceamtcard12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopencardcount12m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen12Month AND IsCard), Hist12MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen12Month AND IsPositiveBalance12M AND IsCard), Hist12MTradeline.AccountBalance));
Business: => Sbfebalanceamtcard24m :=  MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopencardcount24m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen24Month AND IsCard), Hist24MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen24Month AND IsPositiveBalance24M AND IsCard), Hist24MTradeline.AccountBalance));
Business: => Sbfebalanceamtcard36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopencardcount36m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen36Month AND IsCard), Hist36MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen36Month AND IsPositiveBalance36M AND IsCard), Hist36MTradeline.AccountBalance));
Business: => Sbfebalanceamtcard60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopencardcount60m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen60Month AND IsCard), Hist60MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen60Month AND IsPositiveBalance60M AND IsCard), Hist60MTradeline.AccountBalance));
Business: => Sbfebalanceamtcard84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopencardcount84m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen84Month AND IsCard), Hist84MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen84Month AND IsPositiveBalance84M AND IsCard), Hist84MTradeline.AccountBalance));

Business: => Sbfebalanceamtlease03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenleasecount03m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen3Month AND IsLease), Hist03MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen3Month AND IsPositiveBalance03M AND IsLease), Hist03MTradeline.AccountBalance));
Business: => Sbfebalanceamtlease06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenleasecount06m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen6Month AND IsLease), Hist06MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen6Month AND IsPositiveBalance06M AND IsLease), Hist06MTradeline.AccountBalance));
Business: => Sbfebalanceamtlease12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenleasecount12m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen12Month AND IsLease), Hist12MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen12Month AND IsPositiveBalance12M AND IsLease), Hist12MTradeline.AccountBalance));
Business: => Sbfebalanceamtlease24m :=  MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenleasecount24m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen24Month AND IsLease), Hist24MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen24Month AND IsPositiveBalance24M AND IsLease), Hist24MTradeline.AccountBalance));
Business: => Sbfebalanceamtlease36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenleasecount36m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen36Month AND IsLease), Hist36MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen36Month AND IsPositiveBalance36M AND IsLease), Hist36MTradeline.AccountBalance));
Business: => Sbfebalanceamtlease60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenleasecount60m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen60Month AND IsLease), Hist60MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen60Month AND IsPositiveBalance60M AND IsLease), Hist60MTradeline.AccountBalance));
Business: => Sbfebalanceamtlease84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenleasecount84m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen84Month AND IsLease), Hist84MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen84Month AND IsPositiveBalance84M AND IsLease), Hist84MTradeline.AccountBalance));

Business: => Sbfebalanceamtletter03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenlettercount03m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen3Month AND IsLetter), Hist03MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen3Month AND IsPositiveBalance03M AND IsLetter), Hist03MTradeline.AccountBalance));
Business: => Sbfebalanceamtletter06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenlettercount06m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen6Month AND IsLetter), Hist06MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen6Month AND IsPositiveBalance06M AND IsLetter), Hist06MTradeline.AccountBalance));
Business: => Sbfebalanceamtletter12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenlettercount12m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen12Month AND IsLetter), Hist12MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen12Month AND IsPositiveBalance12M AND IsLetter), Hist12MTradeline.AccountBalance));
Business: => Sbfebalanceamtletter24m :=  MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenlettercount24m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen24Month AND IsLetter), Hist24MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen24Month AND IsPositiveBalance24M AND IsLetter), Hist24MTradeline.AccountBalance));
Business: => Sbfebalanceamtletter36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenlettercount36m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen36Month AND IsLetter), Hist36MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen36Month AND IsPositiveBalance36M AND IsLetter), Hist36MTradeline.AccountBalance));
Business: => Sbfebalanceamtletter60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenlettercount60m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen60Month AND IsLetter), Hist60MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen60Month AND IsPositiveBalance60M AND IsLetter), Hist60MTradeline.AccountBalance));
Business: => Sbfebalanceamtletter84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenlettercount84m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen84Month AND IsLetter), Hist84MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen84Month AND IsPositiveBalance84M AND IsLetter), Hist84MTradeline.AccountBalance));

Business: => Sbfebalanceamtoeline03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenoelinecount03m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen3Month AND IsOLine), Hist03MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen3Month AND IsPositiveBalance03M AND IsOLine), Hist03MTradeline.AccountBalance));
Business: => Sbfebalanceamtoeline06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenoelinecount06m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen6Month AND IsOLine), Hist06MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen6Month AND IsPositiveBalance06M AND IsOLine), Hist06MTradeline.AccountBalance));
Business: => Sbfebalanceamtoeline12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenoelinecount12m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen12Month AND IsOLine), Hist12MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen12Month AND IsPositiveBalance12M AND IsOLine), Hist12MTradeline.AccountBalance));
Business: => Sbfebalanceamtoeline24m :=  MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenoelinecount24m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen24Month AND IsOLine), Hist24MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen24Month AND IsPositiveBalance24M AND IsOLine), Hist24MTradeline.AccountBalance));
Business: => Sbfebalanceamtoeline36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenoelinecount36m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen36Month AND IsOLine), Hist36MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen36Month AND IsPositiveBalance36M AND IsOLine), Hist36MTradeline.AccountBalance));
Business: => Sbfebalanceamtoeline60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenoelinecount60m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen60Month AND IsOLine), Hist60MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen60Month AND IsPositiveBalance60M AND IsOLine), Hist60MTradeline.AccountBalance));
Business: => Sbfebalanceamtoeline84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenoelinecount84m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen84Month AND IsOLine), Hist84MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen84Month AND IsPositiveBalance84M AND IsOLine), Hist84MTradeline.AccountBalance));

Business: => Sbfebalanceamtother03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenothercount03m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen3Month AND IsOther), Hist03MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen3Month AND IsPositiveBalance03M AND IsOther), Hist03MTradeline.AccountBalance));
Business: => Sbfebalanceamtother06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenothercount06m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen6Month AND IsOther), Hist06MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen6Month AND IsPositiveBalance06M AND IsOther), Hist06MTradeline.AccountBalance));
Business: => Sbfebalanceamtother12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenothercount12m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen12Month AND IsOther), Hist12MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen12Month AND IsPositiveBalance12M AND IsOther), Hist12MTradeline.AccountBalance));
Business: => Sbfebalanceamtother24m :=  MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenothercount24m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen24Month AND IsOther), Hist24MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen24Month AND IsPositiveBalance24M AND IsOther), Hist24MTradeline.AccountBalance));
Business: => Sbfebalanceamtother36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenothercount36m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen36Month AND IsOther), Hist36MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen36Month AND IsPositiveBalance36M AND IsOther), Hist36MTradeline.AccountBalance));
Business: => Sbfebalanceamtother60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenothercount60m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen60Month AND IsOther), Hist60MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen60Month AND IsPositiveBalance60M AND IsOther), Hist60MTradeline.AccountBalance));
Business: => Sbfebalanceamtother84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenothercount84m = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen84Month AND IsOther), Hist84MTradeline.AccountBalance:Null) => UNKNOWN_DATA,
																			SUM(BusinessAccount.acc(IsOpen84Month AND IsPositiveBalance84M AND IsOther), Hist84MTradeline.AccountBalance));																		
																												
																																										
Tradeline: => CycleBalance := IF(remaining_balance < 0 AND NOT remaining_balance:Null, 0, remaining_balance);
Tradeline: => AccountClosed := EXISTS(AccountTradeline.acc(DateClosedEstimated <= Tradeline.cycle_end_date));

// Define an attribute to represent YYYYMM cycle_end_date
Tradeline: => CycleEndMonth := YEAR(cycle_end_date) * 100 + MONTH(cycle_end_date);
Tradeline: => CycleEndMonthDate := DATEFROMPARTS(YEAR(cycle_end_date), MONTH(cycle_end_date), 1);
Tradeline: => CurrentDateMonth := DATEFROMPARTS(YEAR(CURRENTDATE()),MONTH(CURRENTDATE()),1);
Tradeline: => GoodAverageDate := CycleEndMonthDate < CurrentDateMonth;

// These two lines mark the most recent tradeline in each account for each month
Tradeline: => acc := MAX(AccountTradeline, acc);
Tradeline: => IsLastMonthlyReport := cycle_end_date = cycle_end_date${acc, CycleEndMonth, AccountClosed}:Max; //include AccountClosed in grouping in order to choose the last open account each month (in case account was closed mid-month)
Business: => BalanceByMonth3 := BusinessAccount.acc.AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 3 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,CycleBalance)};
Business: => BalanceByMonth6 := BusinessAccount.acc.AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 6 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,CycleBalance)};
Business: => BalanceByMonth12 := BusinessAccount.acc.AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 12 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,CycleBalance)};
Business: => BalanceByMonth24 := BusinessAccount.acc.AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 24 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,CycleBalance)};
Business: => BalanceByMonth36 := BusinessAccount.acc.AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 36 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,CycleBalance)};
Business: => BalanceByMonth60 := BusinessAccount.acc.AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 60 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,CycleBalance)};
Business: => BalanceByMonth84 := BusinessAccount.acc.AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 84 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,CycleBalance)};
Business: => BalanceByMonthEver := BusinessAccount.acc.AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,CycleBalance)};

Business: => Sbfeavgbalance03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is3Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(BalanceByMonth3, Balance)));
Business: => Sbfeavebalance06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is6Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(BalanceByMonth6, Balance)));
Business: => Sbfeavebalance12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is12Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(BalanceByMonth12, Balance)));
Business: => Sbfeavebalance24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is24Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(BalanceByMonth24, Balance)));
Business: => Sbfeavebalance36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is36Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(BalanceByMonth36, Balance)));
Business: => Sbfeavebalance60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is60Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(BalanceByMonth60, Balance)));
Business: => Sbfeavebalance84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is84Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(BalanceByMonth84, Balance)));
Business: => Sbfeavebalanceever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(BalanceByMonthEver, Balance)));


// Loans
Business: => LoanBalanceByMonth3 := BusinessAccount.acc(IsLoan).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 3 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LoanBalanceByMonth6 := BusinessAccount.acc(IsLoan).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 6 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LoanBalanceByMonth12 := BusinessAccount.acc(IsLoan).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 12 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LoanBalanceByMonth24 := BusinessAccount.acc(IsLoan).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 24 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LoanBalanceByMonth36 := BusinessAccount.acc(IsLoan).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 36 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LoanBalanceByMonth60 := BusinessAccount.acc(IsLoan).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 60 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LoanBalanceByMonth84 := BusinessAccount.acc(IsLoan).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 84 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LoanBalanceByMonthEver := BusinessAccount.acc(IsLoan).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};

Business: => Sbfeavgbalanceloan03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LoanBalanceByMonth3, Balance)));
Business: => Sbfeavebalanceloan06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LoanBalanceByMonth6, Balance)));
Business: => Sbfeavebalanceloan12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LoanBalanceByMonth12, Balance)));
Business: => Sbfeavebalanceloan24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LoanBalanceByMonth24, Balance)));
Business: => Sbfeavebalanceloan36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LoanBalanceByMonth36, Balance)));
Business: => Sbfeavebalanceloan60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LoanBalanceByMonth60, Balance)));
Business: => Sbfeavebalanceloan84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LoanBalanceByMonth84, Balance)));
Business: => Sbfeavebalanceloanever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LoanBalanceByMonthEver, Balance)));

//Lines
Business: => LineBalanceByMonth3 := BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 3 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LineBalanceByMonth6 := BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 6 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LineBalanceByMonth12 := BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 12 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LineBalanceByMonth24 := BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 24 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LineBalanceByMonth36 := BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 36 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LineBalanceByMonth60 := BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 60 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LineBalanceByMonth84 := BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 84 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LineBalanceByMonthEver := BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};

Business: => Sbfeavgbalanceline03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LineBalanceByMonth3, Balance)));
Business: => Sbfeavebalanceline06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LineBalanceByMonth6, Balance)));
Business: => Sbfeavebalanceline12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LineBalanceByMonth12, Balance)));
Business: => Sbfeavebalanceline24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LineBalanceByMonth24, Balance)));
Business: => Sbfeavebalanceline36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LineBalanceByMonth36, Balance)));
Business: => Sbfeavebalanceline60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LineBalanceByMonth60, Balance)));
Business: => Sbfeavebalanceline84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LineBalanceByMonth84, Balance)));
Business: => Sbfeavebalancelineever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LineBalanceByMonthEver, Balance)));
//Cards
Business: => CardBalanceByMonth3 := BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 3 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => CardBalanceByMonth6 := BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 6 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => CardBalanceByMonth12 := BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 12 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => CardBalanceByMonth24 := BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 24 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => CardBalanceByMonth36 := BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 36 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => CardBalanceByMonth60 := BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 60 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => CardBalanceByMonth84 := BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 84 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => CardBalanceByMonthEver := BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};


Business: => Sbfeavgbalancecard03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(CardBalanceByMonth3, Balance)));
Business: => Sbfeavebalancecard06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(CardBalanceByMonth6, Balance)));
Business: => Sbfeavebalancecard12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(CardBalanceByMonth12, Balance)));
Business: => Sbfeavebalancecard24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(CardBalanceByMonth24, Balance)));
Business: => Sbfeavebalancecard36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(CardBalanceByMonth36, Balance)));
Business: => Sbfeavebalancecard60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(CardBalanceByMonth60, Balance)));
Business: => Sbfeavebalancecard84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(CardBalanceByMonth84, Balance)));
Business: => Sbfeavebalancecardever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(CardBalanceByMonthEver, Balance)));

//Leases
Business: => LeaseBalanceByMonth3 := BusinessAccount.acc(IsLease).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 3 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LeaseBalanceByMonth6 := BusinessAccount.acc(IsLease).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 6 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LeaseBalanceByMonth12 := BusinessAccount.acc(IsLease).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 12 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LeaseBalanceByMonth24 := BusinessAccount.acc(IsLease).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 24 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LeaseBalanceByMonth36 := BusinessAccount.acc(IsLease).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 36 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LeaseBalanceByMonth60 := BusinessAccount.acc(IsLease).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 60 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LeaseBalanceByMonth84 := BusinessAccount.acc(IsLease).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 84 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LeaseBalanceByMonthEver := BusinessAccount.acc(IsLease).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};

Business: => Sbfeavgbalancelease03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LeaseBalanceByMonth3, Balance)));
Business: => Sbfeavebalancelease06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LeaseBalanceByMonth6, Balance)));
Business: => Sbfeavebalancelease12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LeaseBalanceByMonth12, Balance)));
Business: => Sbfeavebalancelease24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LeaseBalanceByMonth24, Balance)));
Business: => Sbfeavebalancelease36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LeaseBalanceByMonth36, Balance)));
Business: => Sbfeavebalancelease60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LeaseBalanceByMonth60, Balance)));
Business: => Sbfeavebalancelease84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LeaseBalanceByMonth84, Balance)));
Business: => Sbfeavebalanceleaseever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LeaseBalanceByMonthEver, Balance)));
//Letters
Business: => LetterBalanceByMonth3 := BusinessAccount.acc(IsLetter).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 3 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LetterBalanceByMonth6 := BusinessAccount.acc(IsLetter).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 6 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LetterBalanceByMonth12 := BusinessAccount.acc(IsLetter).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 12 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LetterBalanceByMonth24 := BusinessAccount.acc(IsLetter).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 24 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LetterBalanceByMonth36 := BusinessAccount.acc(IsLetter).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 36 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LetterBalanceByMonth60 := BusinessAccount.acc(IsLetter).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 60 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LetterBalanceByMonth84 := BusinessAccount.acc(IsLetter).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 84 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => LetterBalanceByMonthEver := BusinessAccount.acc(IsLetter).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};

Business: => Sbfeavgbalanceletter03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LetterBalanceByMonth3, Balance)));
Business: => Sbfeavebalanceletter06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LetterBalanceByMonth6, Balance)));
Business: => Sbfeavebalanceletter12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LetterBalanceByMonth12, Balance)));
Business: => Sbfeavebalanceletter24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LetterBalanceByMonth24, Balance)));
Business: => Sbfeavebalanceletter36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LetterBalanceByMonth36, Balance)));
Business: => Sbfeavebalanceletter60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LetterBalanceByMonth60, Balance)));
Business: => Sbfeavebalanceletter84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LetterBalanceByMonth84, Balance)));
Business: => Sbfeavebalanceletterever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LetterBalanceByMonthEver, Balance)));
																 
//Olines
Business: => OLineBalanceByMonth3 := BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 3 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => OLineBalanceByMonth6 := BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 6 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => OLineBalanceByMonth12 := BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 12 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => OLineBalanceByMonth24 := BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 24 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => OLineBalanceByMonth36 := BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 36 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => OLineBalanceByMonth60 := BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 60 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => OLineBalanceByMonth84 := BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 84 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => OLineBalanceByMonthEver := BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};

Business: => Sbfeavgbalanceoeline03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(OLineBalanceByMonth3, Balance)));
Business: => Sbfeavebalanceoline06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(OLineBalanceByMonth6, Balance)));
Business: => Sbfeavebalanceoline12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(OLineBalanceByMonth12, Balance)));
Business: => Sbfeavebalanceoline24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(OLineBalanceByMonth24, Balance)));
Business: => Sbfeavebalanceoline36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(OLineBalanceByMonth36, Balance)));
Business: => Sbfeavebalanceoline60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(OLineBalanceByMonth60, Balance)));
Business: => Sbfeavebalanceoline84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(OLineBalanceByMonth84, Balance)));
Business: => Sbfeavebalanceolineever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(OLineBalanceByMonthEver, Balance)));
//Others
Business: => OtherBalanceByMonth3 := BusinessAccount.acc(IsOther).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 3 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => OtherBalanceByMonth6 := BusinessAccount.acc(IsOther).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 6 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => OtherBalanceByMonth12 := BusinessAccount.acc(IsOther).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 12 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => OtherBalanceByMonth24 := BusinessAccount.acc(IsOther).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 24 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => OtherBalanceByMonth36 := BusinessAccount.acc(IsOther).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 36 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => OtherBalanceByMonth60 := BusinessAccount.acc(IsOther).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 60 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => OtherBalanceByMonth84 := BusinessAccount.acc(IsOther).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 84 AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};
Business: => OtherBalanceByMonthEver := BusinessAccount.acc(IsOther).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND GoodAverageDate){CycleEndMonth, Balance := SUM(GROUP,AccountBalance)};

Business: => Sbfeavgbalanceother03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(OtherBalanceByMonth3, Balance)));
Business: => Sbfeavebalanceother06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(OtherBalanceByMonth6, Balance)));
Business: => Sbfeavebalanceother12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(OtherBalanceByMonth12, Balance)));
Business: => Sbfeavebalanceother24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(OtherBalanceByMonth24, Balance)));
Business: => Sbfeavebalanceother36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(OtherBalanceByMonth36, Balance)));
Business: => Sbfeavebalanceother60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(OtherBalanceByMonth60, Balance)));
Business: => Sbfeavebalanceother84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(OtherBalanceByMonth84, Balance)));
Business: => Sbfeavebalanceotherever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(NOT AccountClosed AND IsLastMonthlyReport)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND NOT CycleBalance:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(OtherBalanceByMonthEver, Balance)));																																										


Account: => HighBalance03M := MAX(AccountTradeline.trade(Is3Month AND NOT AccountClosed AND CycleBalance>=0), CycleBalance);
Account: => HighBalance06M := MAX(AccountTradeline.trade(Is6Month AND NOT AccountClosed AND CycleBalance>=0), CycleBalance);
Account: => HighBalance12M := MAX(AccountTradeline.trade(Is12Month AND NOT AccountClosed AND CycleBalance>=0), CycleBalance);
Account: => HighBalance24M := MAX(AccountTradeline.trade(Is24Month AND NOT AccountClosed AND CycleBalance>=0), CycleBalance);
Account: => HighBalance36M := MAX(AccountTradeline.trade(Is36Month AND NOT AccountClosed AND CycleBalance>=0), CycleBalance);
Account: => HighBalance60M := MAX(AccountTradeline.trade(Is60Month AND NOT AccountClosed AND CycleBalance>=0), CycleBalance);
Account: => HighBalance84M := MAX(AccountTradeline.trade(Is84Month AND NOT AccountClosed AND CycleBalance>=0), CycleBalance);
Account: => HighBalanceEver := MAX(AccountTradeline.trade(NOT AccountClosed AND CycleBalance>=0), CycleBalance);

Business: => Sbfehighbalance03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc, HighBalance03M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc, HighBalance03M));
Business: => Sbfehighbalance06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc, HighBalance06M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc, HighBalance06M));
Business: => Sbfehighbalance12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc, HighBalance12M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc, HighBalance12M));
Business: => Sbfehighbalance24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc, HighBalance24M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc, HighBalance24M));
Business: => Sbfehighbalance36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc, HighBalance36M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc, HighBalance36M));
Business: => Sbfehighbalance60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc, HighBalance60M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc, HighBalance60M));
Business: => Sbfehighbalance84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc, HighBalance84M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc, HighBalance84M));
Business: => Sbfehighbalanceever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc, HighBalanceEver:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc, HighBalanceEver));
																	 
Business: => Sbfehighbalanceloan03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLoan), HighBalance03M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLoan), HighBalance03M));
Business: => Sbfehighbalanceloan06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLoan), HighBalance06M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLoan), HighBalance06M));
Business: => Sbfehighbalanceloan12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLoan), HighBalance12M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLoan), HighBalance12M));
Business: => Sbfehighbalanceloan24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLoan), HighBalance24M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLoan), HighBalance24M));
Business: => Sbfehighbalanceloan36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLoan), HighBalance36M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLoan), HighBalance36M));
Business: => Sbfehighbalanceloan60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLoan), HighBalance60M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLoan), HighBalance60M));
Business: => Sbfehighbalanceloan84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLoan), HighBalance84M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLoan), HighBalance84M));
Business: => Sbfehighbalanceloanever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLoan), HighBalanceEver:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLoan), HighBalanceEver));

Business: => Sbfehighbalanceline03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLine), HighBalance03M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLine), HighBalance03M));
Business: => Sbfehighbalanceline06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLine), HighBalance06M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLine), HighBalance06M));
Business: => Sbfehighbalanceline12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLine), HighBalance12M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLine), HighBalance12M));
Business: => Sbfehighbalanceline24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLine), HighBalance24M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLine), HighBalance24M));
Business: => Sbfehighbalanceline36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLine), HighBalance36M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLine), HighBalance36M));
Business: => Sbfehighbalanceline60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLine), HighBalance60M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLine), HighBalance60M));
Business: => Sbfehighbalanceline84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLine), HighBalance84M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLine), HighBalance84M));
Business: => Sbfehighbalancelineever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLine), HighBalanceEver:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLine), HighBalanceEver));

Business: => Sbfehighbalancecard03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsCard), HighBalance03M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsCard), HighBalance03M));
Business: => Sbfehighbalancecard06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsCard), HighBalance06M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsCard), HighBalance06M));
Business: => Sbfehighbalancecard12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsCard), HighBalance12M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsCard), HighBalance12M));
Business: => Sbfehighbalancecard24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsCard), HighBalance24M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsCard), HighBalance24M));
Business: => Sbfehighbalancecard36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsCard), HighBalance36M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsCard), HighBalance36M));
Business: => Sbfehighbalancecard60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsCard), HighBalance60M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsCard), HighBalance60M));
Business: => Sbfehighbalancecard84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsCard), HighBalance84M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsCard), HighBalance84M));
Business: => Sbfehighbalancecardever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsCard), HighBalanceEver:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsCard), HighBalanceEver));

Business: => Sbfehighbalancelease03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLease), HighBalance03M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLease), HighBalance03M));
Business: => Sbfehighbalancelease06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLease), HighBalance06M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLease), HighBalance06M));
Business: => Sbfehighbalancelease12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLease), HighBalance12M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLease), HighBalance12M));
Business: => Sbfehighbalancelease24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLease), HighBalance24M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLease), HighBalance24M));
Business: => Sbfehighbalancelease36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLease), HighBalance36M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLease), HighBalance36M));
Business: => Sbfehighbalancelease60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLease), HighBalance60M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLease), HighBalance60M));
Business: => Sbfehighbalancelease84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLease), HighBalance84M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLease), HighBalance84M));
Business: => Sbfehighbalanceleaseever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLease), HighBalanceEver:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLease), HighBalanceEver));

Business: => Sbfehighbalanceletter03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLetter), HighBalance03M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLetter), HighBalance03M));
Business: => Sbfehighbalanceletter06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLetter), HighBalance06M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLetter), HighBalance06M));
Business: => Sbfehighbalanceletter12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLetter), HighBalance12M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLetter), HighBalance12M));
Business: => Sbfehighbalanceletter24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLetter), HighBalance24M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLetter), HighBalance24M));
Business: => Sbfehighbalanceletter36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLetter), HighBalance36M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLetter), HighBalance36M));
Business: => Sbfehighbalanceletter60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLetter), HighBalance60M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLetter), HighBalance60M));
Business: => Sbfehighbalanceletter84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLetter), HighBalance84M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLetter), HighBalance84M));
Business: => Sbfehighbalanceletterever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLetter), HighBalanceEver:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsLetter), HighBalanceEver));

Business: => Sbfehighbalanceoeline03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOLine), HighBalance03M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsOLine), HighBalance03M));
Business: => Sbfehighbalanceoeline06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOLine), HighBalance06M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsOLine), HighBalance06M));
Business: => Sbfehighbalanceoeline12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOLine), HighBalance12M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsOLine), HighBalance12M));
Business: => Sbfehighbalanceoeline24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOLine), HighBalance24M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsOLine), HighBalance24M));
Business: => Sbfehighbalanceoeline36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOLine), HighBalance36M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsOLine), HighBalance36M));
Business: => Sbfehighbalanceoeline60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOLine), HighBalance60M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsOLine), HighBalance60M));
Business: => Sbfehighbalanceoeline84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOLine), HighBalance84M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsOLine), HighBalance84M));
Business: => Sbfehighbalanceoelineever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOLine), HighBalanceEver:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsOLine), HighBalanceEver));

Business: => Sbfehighbalanceother03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOther), HighBalance03M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsOther), HighBalance03M));
Business: => Sbfehighbalanceother06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOther), HighBalance06M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsOther), HighBalance06M));
Business: => Sbfehighbalanceother12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOther), HighBalance12M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsOther), HighBalance12M));
Business: => Sbfehighbalanceother24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOther), HighBalance24M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsOther), HighBalance24M));
Business: => Sbfehighbalanceother36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOther), HighBalance36M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsOther), HighBalance36M));
Business: => Sbfehighbalanceother60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOther), HighBalance60M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsOther), HighBalance60M));
Business: => Sbfehighbalanceother84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOther), HighBalance84M:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsOther), HighBalance84M));
Business: => Sbfehighbalanceotherever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOther), HighBalanceEver:Null) => UNKNOWN_DATA,
																	 SUM(BusinessAccount.acc(IsOther), HighBalanceEver));


Account: => HasPositiveBalance3Month := EXISTS(AccountTradeline.trade(Is3Month AND CycleBalance>0));
Account: => HasPositiveBalance6Month := EXISTS(AccountTradeline.trade(Is6Month AND CycleBalance>0));
Account: => HasPositiveBalance12Month := EXISTS(AccountTradeline.trade(Is12Month AND CycleBalance>0));
Account: => HasPositiveBalance24Month := EXISTS(AccountTradeline.trade(Is24Month AND CycleBalance>0));
Account: => HasPositiveBalance36Month := EXISTS(AccountTradeline.trade(Is36Month AND CycleBalance>0));
Account: => HasPositiveBalance60Month := EXISTS(AccountTradeline.trade(Is60Month AND CycleBalance>0));
Account: => HasPositiveBalance84Month := EXISTS(AccountTradeline.trade(Is84Month AND CycleBalance>0));
Account: => HasPositiveBalanceEver := EXISTS(AccountTradeline.trade(CycleBalance>0));

Business: => Sbfebalancecount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 COUNT(BusinessAccount.acc(IsOpen)) = 0 => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOpen), AccountBalance:Null) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOpen AND IsPositiveBalance)));
Business: => Sbfebalancecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(Update3Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc.AccountTradeline.trade(Is3Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(HasPositiveBalance3Month)));																 
Business: => Sbfebalancecount06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(Update6Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc.AccountTradeline.trade(Is6Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(HasPositiveBalance6Month))); //any account in those time frames.
Business: => Sbfebalancecount12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(Update12Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc.AccountTradeline.trade(Is12Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(HasPositiveBalance12Month)));
Business: => Sbfebalancecount24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(Update24Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc.AccountTradeline.trade(Is24Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(HasPositiveBalance24Month)));
Business: => Sbfebalancecount36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(Update36Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc.AccountTradeline.trade(Is36Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(HasPositiveBalance36Month)));
Business: => Sbfebalancecount60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(Update60Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc.AccountTradeline.trade(Is60Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(HasPositiveBalance60Month)));
Business: => Sbfebalancecount84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(Update84Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc.AccountTradeline.trade(Is84Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(HasPositiveBalance84Month)));
Business: => Sbfebalancecountever := MAP(BusinessNotOnFile => NOT_ON_FILE,
														//			NOT EXISTS(BusinessAccount.acc(Update6Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc.AccountTradeline.trade, CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(HasPositiveBalanceEver)));																 																 
																 
Business: => Sbfebalancecountloan := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 COUNT(BusinessAccount.acc(IsOpen AND IsLoan)) = 0 => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOpen AND IsLoan), AccountBalance:Null) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOpen AND IsLoan AND IsPositiveBalance)));
Business: => Sbfebalanceloancount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLoan AND Update3Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is3Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLoan AND HasPositiveBalance3Month)));
Business: => Sbfebalancecountloan06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLoan AND Update6Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is6Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLoan AND HasPositiveBalance6Month)));
Business: => Sbfebalancecountloan12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLoan AND Update12Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is12Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLoan AND HasPositiveBalance12Month)));
Business: => Sbfebalancecountloan24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLoan AND Update24Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is24Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLoan AND HasPositiveBalance24Month)));
Business: => Sbfebalancecountloan36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLoan AND Update36Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is36Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLoan AND HasPositiveBalance36Month)));
Business: => Sbfebalancecountloan60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLoan AND Update60Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is60Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLoan AND HasPositiveBalance60Month)));
Business: => Sbfebalancecountloan84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLoan AND Update84Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is84Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLoan AND HasPositiveBalance84Month)));
Business: => Sbfebalancecountloanever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLoan)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade, CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLoan AND HasPositiveBalanceEver)));																 
																 
Business: => Sbfebalancecountline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 COUNT(BusinessAccount.acc(IsOpen AND IsLine)) = 0 => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOpen AND IsLine), AccountBalance:Null) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOpen AND IsLine AND IsPositiveBalance)));
Business: => Sbfebalancelinecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLine AND Update3Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is3Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLine AND HasPositiveBalance3Month)));
Business: => Sbfebalancecountline06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLine AND Update6Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is6Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLine AND HasPositiveBalance6Month)));
Business: => Sbfebalancecountline12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLine AND Update12Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is12Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLine AND HasPositiveBalance12Month)));
Business: => Sbfebalancecountline24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLine AND Update24Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is24Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLine AND HasPositiveBalance24Month)));
Business: => Sbfebalancecountline36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLine AND Update36Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is36Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLine AND HasPositiveBalance36Month)));
Business: => Sbfebalancecountline60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLine AND Update60Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is60Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLine AND HasPositiveBalance60Month)));
Business: => Sbfebalancecountline84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLine AND Update84Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is84Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLine AND HasPositiveBalance84Month)));
Business: => Sbfebalancecountlineever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLine)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade, CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLine AND HasPositiveBalanceEver)));																 
																 
Business: => Sbfebalancecountcard := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 COUNT(BusinessAccount.acc(IsOpen AND IsCard)) = 0 => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOpen AND IsCard), AccountBalance:Null) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOpen AND IsCard AND IsPositiveBalance)));
Business: => Sbfebalancecardcount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsCard AND Update3Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is3Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsCard AND HasPositiveBalance3Month)));
Business: => Sbfebalancecountcard06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsCard AND Update6Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is6Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsCard AND HasPositiveBalance6Month)));
Business: => Sbfebalancecountcard12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsCard AND Update12Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is12Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsCard AND HasPositiveBalance12Month)));
Business: => Sbfebalancecountcard24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsCard AND Update24Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is24Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsCard AND HasPositiveBalance24Month)));
Business: => Sbfebalancecountcard36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsCard AND Update36Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is36Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsCard AND HasPositiveBalance36Month)));
Business: => Sbfebalancecountcard60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsCard AND Update60Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is60Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsCard AND HasPositiveBalance60Month)));
Business: => Sbfebalancecountcard84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsCard AND Update84Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is84Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsCard AND HasPositiveBalance84Month)));
Business: => Sbfebalancecountcardever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsCard)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade, CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsCard AND HasPositiveBalanceEver)));																 
																 
Business: => Sbfebalancecountlease := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 COUNT(BusinessAccount.acc(IsOpen AND IsLease)) = 0 => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOpen AND IsLease), AccountBalance:Null) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOpen AND IsLease AND IsPositiveBalance)));
Business: => Sbfebalanceleasecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLease AND Update3Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is3Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLease AND HasPositiveBalance3Month)));																 
Business: => Sbfebalancecountlease06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLease AND Update6Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is6Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLease AND HasPositiveBalance6Month)));
Business: => Sbfebalancecountlease12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLease AND Update12Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is12Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLease AND HasPositiveBalance12Month)));
Business: => Sbfebalancecountlease24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLease AND Update24Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is24Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLease AND HasPositiveBalance24Month)));
Business: => Sbfebalancecountlease36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLease AND Update36Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is36Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLease AND HasPositiveBalance36Month)));
Business: => Sbfebalancecountlease60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLease AND Update60Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is60Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLease AND HasPositiveBalance60Month)));
Business: => Sbfebalancecountlease84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLease AND Update84Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is84Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLease AND HasPositiveBalance84Month)));
Business: => Sbfebalancecountleaseever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLease)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade, CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLease AND HasPositiveBalanceEver)));																 
																 
Business: => Sbfebalancecountletter := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 COUNT(BusinessAccount.acc(IsOpen AND IsLetter)) = 0 => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOpen AND IsLetter), AccountBalance:Null) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOpen AND IsLetter AND IsPositiveBalance)));
Business: => Sbfebalancelettercount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLetter AND Update3Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is3Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLetter AND HasPositiveBalance3Month)));
Business: => Sbfebalancecountletter06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLetter AND Update6Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is6Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLetter AND HasPositiveBalance6Month)));
Business: => Sbfebalancecountletter12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLetter AND Update12Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is12Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLetter AND HasPositiveBalance12Month)));
Business: => Sbfebalancecountletter24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																		 NOT EXISTS(BusinessAccount.acc(IsLetter AND Update24Month)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is24Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLetter AND HasPositiveBalance24Month)));
Business: => Sbfebalancecountletter36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLetter AND Update36Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is36Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLetter AND HasPositiveBalance36Month)));
Business: => Sbfebalancecountletter60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLetter AND Update60Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is60Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLetter AND HasPositiveBalance60Month)));
Business: => Sbfebalancecountletter84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLetter AND Update84Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is84Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLetter AND HasPositiveBalance84Month)));
Business: => Sbfebalancecountletterever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLetter)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade, CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsLetter AND HasPositiveBalanceEver)));																 
																 
Business: => Sbfebalancecountoline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 COUNT(BusinessAccount.acc(IsOpen AND IsOLine)) = 0 => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOpen AND IsOLine), AccountBalance:Null) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOpen AND IsOLine AND IsPositiveBalance)));
Business: => Sbfebalanceoelinecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOLine AND Update3Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is3Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsOLine AND HasPositiveBalance3Month)));
Business: => Sbfebalancecountoline06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOLine AND Update6Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is6Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsOLine AND HasPositiveBalance6Month)));
Business: => Sbfebalancecountoline12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOLine AND Update12Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is12Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsOLine AND HasPositiveBalance12Month)));
Business: => Sbfebalancecountoline24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOLine AND Update24Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is24Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsOLine AND HasPositiveBalance24Month)));
Business: => Sbfebalancecountoline36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOLine AND Update36Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is36Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsOLine AND HasPositiveBalance36Month)));
Business: => Sbfebalancecountoline60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOLine AND Update60Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is60Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsOLine AND HasPositiveBalance60Month)));
Business: => Sbfebalancecountoline84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOLine AND Update84Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is84Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsOLine AND HasPositiveBalance84Month)));
Business: => Sbfebalancecountolineever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOLine)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade, CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsOLine AND HasPositiveBalanceEver)));
																 
																 
Business: => Sbfebalancecountother := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 COUNT(BusinessAccount.acc(IsOpen AND IsOther)) = 0 => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOpen AND IsOther), AccountBalance:Null) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOpen AND IsOther AND IsPositiveBalance)));
Business: => Sbfebalanceothercount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOther AND Update3Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is3Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsOther AND HasPositiveBalance3Month)));
Business: => Sbfebalancecountother06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOther AND Update6Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is6Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsOther AND HasPositiveBalance6Month)));
Business: => Sbfebalancecountother12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOther AND Update12Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is12Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsOther AND HasPositiveBalance12Month)));
Business: => Sbfebalancecountother24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOther AND Update24Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is24Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsOther AND HasPositiveBalance24Month)));
Business: => Sbfebalancecountother36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOther AND Update36Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is36Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsOther AND HasPositiveBalance36Month)));
Business: => Sbfebalancecountother60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOther AND Update60Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is60Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsOther AND HasPositiveBalance60Month)));
Business: => Sbfebalancecountother84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOther AND Update84Month)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is84Month), CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsOther AND HasPositiveBalance84Month)));
Business: => Sbfebalancecountotherever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOther)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade, CycleBalance:Null) => UNKNOWN_DATA,
																	 COUNT(BusinessAccount.acc(IsOther AND HasPositiveBalanceEver)));																 

Account: => IsClosedWithBalance := HasClosed AND IsPositiveBalance;
Business: => Sbfebalancecountclosed := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			 COUNT(BusinessAccount.acc(HasClosed))=0 => NO_DATA_AVAILABLE,
																			 ALL(BusinessAccount.acc(HasClosed), AccountBalance:Null) => UNKNOWN_DATA,
																			 COUNT(BusinessAccount.acc(IsClosedWithBalance)));
																			 
Account: => MonthsClosed := MONTHSBETWEEN(DateClosed, CURRENTDATE()); 																			 
Business: => Sbfebalanceclosedcount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																							COUNT(BusinessAccount.acc(HasClosed AND MonthsClosed < 3))=0 => NO_DATA_AVAILABLE,
																							ALL(BusinessAccount.acc(HasClosed AND MonthsClosed < 3), AccountBalance:Null) => UNKNOWN_DATA,
																							COUNT(BusinessAccount.acc(IsClosedWithBalance AND MonthsClosed < 3)));
Business: => Sbfebalanceclosedcount06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																							COUNT(BusinessAccount.acc(HasClosed AND MonthsClosed < 6))=0 => NO_DATA_AVAILABLE,
																							ALL(BusinessAccount.acc(HasClosed AND MonthsClosed < 6), AccountBalance:Null) => UNKNOWN_DATA,
																							COUNT(BusinessAccount.acc(IsClosedWithBalance AND MonthsClosed < 6)));
Business: => Sbfebalanceclosedcount12month := MAP(BusinessNotOnFile => NOT_ON_FILE,
																							COUNT(BusinessAccount.acc(HasClosed AND MonthsClosed < 12))=0 => NO_DATA_AVAILABLE,
																							ALL(BusinessAccount.acc(HasClosed AND MonthsClosed < 12), AccountBalance:Null) => UNKNOWN_DATA,
																							COUNT(BusinessAccount.acc(IsClosedWithBalance AND MonthsClosed < 12)));																			 
Business: => Sbfebalanceclosedcount24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																							COUNT(BusinessAccount.acc(HasClosed AND MonthsClosed < 24))=0 => NO_DATA_AVAILABLE,
																							ALL(BusinessAccount.acc(HasClosed AND MonthsClosed < 24), AccountBalance:Null) => UNKNOWN_DATA,
																							COUNT(BusinessAccount.acc(IsClosedWithBalance AND MonthsClosed < 24)));

Tradeline: => OriginalCreditLimit := IF(EXISTS(AccountTradeline.acc(IsLoan)),
																		 IF(original_credit_limit > 0, original_credit_limit,
																		 IF(highest_credit_used > 0, highest_credit_used,
																	   IF(current_credit_limit > 0, current_credit_limit,
																	   original_credit_limit))), original_credit_limit);
																		 //use waterfall for loans, use original_credit_limit for lease and letter
Account: => IsInstallment := IsLoan OR IsLease OR IsLetter;
Account: => MostRecentlyReportedOriginalLimitDate := MAX(AccountTradeline.trade(NOT OriginalCreditLimit:Null), load_date); //most recent populated, per Lea
//Can't use only
Account: => OriginalCreditLimit := MAX(AccountTradeline.trade(load_date = Account.MostRecentlyReportedOriginalLimitDate), OriginalCreditLimit);


Business: => Sbfeoriginallimitinstallment := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsInstallment AND IsOpen)) = 0 => NO_DATA_AVAILABLE,
																					ALL(BusinessAccount.acc(IsInstallment AND IsOpen), OriginalCreditLimit:Null) => UNKNOWN_DATA, // 0 counted as null since we want limit > 0
																					SUM(BusinessAccount.acc(IsInstallment AND IsOpen), OriginalCreditLimit));
Business: => Sbfeoriginallimitloan := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsLoan AND IsOpen)) = 0 => NO_DATA_AVAILABLE,
																					ALL(BusinessAccount.acc(IsLoan AND IsOpen), OriginalCreditLimit:Null) => UNKNOWN_DATA, //only if all accounts are missing data
																					SUM(BusinessAccount.acc(IsLoan AND IsOpen), OriginalCreditLimit));
Business: => Sbfeoriginallimitlease := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsLease AND IsOpen)) = 0 => NO_DATA_AVAILABLE,
																					ALL(BusinessAccount.acc(IsLease AND IsOpen), OriginalCreditLimit:Null) => UNKNOWN_DATA,
																					SUM(BusinessAccount.acc(IsLease AND IsOpen), OriginalCreditLimit));

Account: => MostRecentlyReportedLimitDate := MAX(AccountTradeline.trade(current_credit_limit > 0), load_date); //or is it just the most recent date?
Account: => CurrentCreditLimit := ONLY(AccountTradeline.trade(load_date = Account.MostRecentlyReportedLimitDate), current_credit_limit);

Account: => Hist03MLimitDate := MAX(AccountTradeline.trade(current_credit_limit > 0 AND MonthsSinceTrade >= 3), cycle_end_date);
Account: => Hist03MLimitLoadDate := MAX(AccountTradeline.trade(cycle_end_date = Account.Hist03MLimitDate), load_date);
Account: => Hist03MCreditLimit := ONLY(AccountTradeline.trade(cycle_end_date = Account.Hist03MLimitDate AND load_date = Account.Hist03MLimitLoadDate AND current_credit_limit > 0), current_credit_limit);

Account: => Hist06MLimitDate := MAX(AccountTradeline.trade(current_credit_limit > 0 AND MonthsSinceTrade >= 6), cycle_end_date);
Account: => Hist06MLimitLoadDate := MAX(AccountTradeline.trade(cycle_end_date = Account.Hist06MLimitDate), load_date);
Account: => Hist06MCreditLimit := ONLY(AccountTradeline.trade(cycle_end_date = Account.Hist06MLimitDate AND load_date = Account.Hist06MLimitLoadDate AND current_credit_limit > 0), current_credit_limit);

Account: => Hist12MLimitDate := MAX(AccountTradeline.trade(current_credit_limit > 0 AND MonthsSinceTrade >= 12), cycle_end_date);
Account: => Hist12MLimitLoadDate := MAX(AccountTradeline.trade(cycle_end_date = Account.Hist12MLimitDate), load_date);
Account: => Hist12MCreditLimit := ONLY(AccountTradeline.trade(cycle_end_date = Account.Hist12MLimitDate AND load_date = Account.Hist12MLimitLoadDate AND current_credit_limit > 0), current_credit_limit);

Account: => Hist24MLimitDate := MAX(AccountTradeline.trade(current_credit_limit > 0 AND MonthsSinceTrade >= 24), cycle_end_date);
Account: => Hist24MLimitLoadDate := MAX(AccountTradeline.trade(cycle_end_date = Account.Hist24MLimitDate), load_date);
Account: => Hist24MCreditLimit := ONLY(AccountTradeline.trade(cycle_end_date = Account.Hist24MLimitDate AND load_date = Account.Hist24MLimitLoadDate AND current_credit_limit > 0), current_credit_limit);

Account: => Hist36MLimitDate := MAX(AccountTradeline.trade(current_credit_limit > 0 AND MonthsSinceTrade >= 36), cycle_end_date);
Account: => Hist36MLimitLoadDate := MAX(AccountTradeline.trade(cycle_end_date = Account.Hist36MLimitDate), load_date);
Account: => Hist36MCreditLimit := ONLY(AccountTradeline.trade(cycle_end_date = Account.Hist36MLimitDate AND load_date = Account.Hist36MLimitLoadDate AND current_credit_limit > 0), current_credit_limit);

Account: => Hist60MLimitDate := MAX(AccountTradeline.trade(current_credit_limit > 0 AND MonthsSinceTrade >= 60), cycle_end_date);
Account: => Hist60MLimitLoadDate := MAX(AccountTradeline.trade(cycle_end_date = Account.Hist60MLimitDate), load_date);
Account: => Hist60MCreditLimit := ONLY(AccountTradeline.trade(cycle_end_date = Account.Hist60MLimitDate AND load_date = Account.Hist60MLimitLoadDate AND current_credit_limit > 0), current_credit_limit);

Account: => Hist84MLimitDate := MAX(AccountTradeline.trade(current_credit_limit > 0 AND MonthsSinceTrade >= 84), cycle_end_date);
Account: => Hist84MLimitLoadDate := MAX(AccountTradeline.trade(cycle_end_date = Account.Hist84MLimitDate), load_date);
Account: => Hist84MCreditLimit := ONLY(AccountTradeline.trade(cycle_end_date = Account.Hist84MLimitDate AND load_date = Account.Hist84MLimitLoadDate AND current_credit_limit > 0), current_credit_limit);


Account: => IsRevolvingAccount := IsLine OR IsCard;			//all revolving fields look only at lines and cards

Business: => Sbfecurrentlimitrevolving := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																					ALL(BusinessAccount.acc(IsOpen AND IsRevolvingAccount), CurrentCreditLimit:Null) => UNKNOWN_DATA,
																					SUM(BusinessAccount.acc(IsOpen AND IsRevolvingAccount), CurrentCreditLimit));
Business: => Sbfelimitrevamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 COUNT(BusinessAccount.acc(IsOpen3Month AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen3Month AND IsRevolvingAccount), Hist03MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen3Month AND IsRevolvingAccount), Hist03MCreditLimit));
Business: => Sbfelimitrevamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 COUNT(BusinessAccount.acc(IsOpen6Month AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen6Month AND IsRevolvingAccount), Hist06MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen6Month AND IsRevolvingAccount), Hist06MCreditLimit));
Business: => Sbfelimitrevamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 COUNT(BusinessAccount.acc(IsOpen12Month AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen12Month AND IsRevolvingAccount), Hist12MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen12Month AND IsRevolvingAccount), Hist12MCreditLimit));
Business: => Sbfelimitrevamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 COUNT(BusinessAccount.acc(IsOpen24Month AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen24Month AND IsRevolvingAccount), Hist24MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen24Month AND IsRevolvingAccount), Hist24MCreditLimit));
Business: => Sbfelimitrevamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 COUNT(BusinessAccount.acc(IsOpen36Month AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen36Month AND IsRevolvingAccount), Hist36MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen36Month AND IsRevolvingAccount), Hist36MCreditLimit));
Business: => Sbfelimitrevamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 COUNT(BusinessAccount.acc(IsOpen60Month AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen60Month AND IsRevolvingAccount), Hist60MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen60Month AND IsRevolvingAccount), Hist60MCreditLimit));
Business: => Sbfelimitrevamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 COUNT(BusinessAccount.acc(IsOpen84Month AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen84Month AND IsRevolvingAccount), Hist84MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen84Month AND IsRevolvingAccount), Hist84MCreditLimit));																			

Business: => Sbfecurrentlimitline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen AND IsLine)) = 0 => NO_DATA_AVAILABLE,
																					ALL(BusinessAccount.acc(IsOpen AND IsLine), CurrentCreditLimit:Null) => UNKNOWN_DATA,
																					SUM(BusinessAccount.acc(IsOpen AND IsLine), CurrentCreditLimit));
Business: => Sbfelimitlineamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 Sbfeopenlinecount03m = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen3Month AND IsLine), Hist03MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen3Month AND IsLine), Hist03MCreditLimit));
Business: => Sbfelimitlineamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 Sbfeopenlinecount06m = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen6Month AND IsLine), Hist06MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen6Month AND IsLine), Hist06MCreditLimit));
Business: => Sbfelimitlineamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 Sbfeopenlinecount12m = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen12Month AND IsLine), Hist12MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen12Month AND IsLine), Hist12MCreditLimit));
Business: => Sbfelimitlineamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 Sbfeopenlinecount24m = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen24Month AND IsLine), Hist24MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen24Month AND IsLine), Hist24MCreditLimit));
Business: => Sbfelimitlineamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 Sbfeopenlinecount36m = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen36Month AND IsLine), Hist36MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen36Month AND IsLine), Hist36MCreditLimit));
Business: => Sbfelimitlineamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 Sbfeopenlinecount60m = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen60Month AND IsLine), Hist60MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen60Month AND IsLine), Hist60MCreditLimit));
Business: => Sbfelimitlineamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 Sbfeopenlinecount84m = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen84Month AND IsLine), Hist84MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen84Month AND IsLine), Hist84MCreditLimit));																				
																					
Business: => Sbfecurrentlimitcard := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen AND IsCard)) = 0 => NO_DATA_AVAILABLE,
																					ALL(BusinessAccount.acc(IsOpen AND IsCard), CurrentCreditLimit:Null) => UNKNOWN_DATA,
																					SUM(BusinessAccount.acc(IsOpen AND IsCard), CurrentCreditLimit));
Business: => Sbfelimitcardamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 Sbfeopencardcount03m = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen3Month AND IsCard), Hist03MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen3Month AND IsCard), Hist03MCreditLimit));
Business: => Sbfelimitcardamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 Sbfeopencardcount06m = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen6Month AND IsCard), Hist06MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen6Month AND IsCard), Hist06MCreditLimit));
Business: => Sbfelimitcardamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 Sbfeopencardcount12m = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen12Month AND IsCard), Hist12MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen12Month AND IsCard), Hist12MCreditLimit));
Business: => Sbfelimitcardamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 Sbfeopencardcount24m = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen24Month AND IsCard), Hist24MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen24Month AND IsCard), Hist24MCreditLimit));
Business: => Sbfelimitcardamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 Sbfeopencardcount36m = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen36Month AND IsCard), Hist36MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen36Month AND IsCard), Hist36MCreditLimit));
Business: => Sbfelimitcardamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 Sbfeopencardcount60m = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen60Month AND IsCard), Hist60MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen60Month AND IsCard), Hist60MCreditLimit));
Business: => Sbfelimitcardamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 Sbfeopencardcount84m = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen84Month AND IsCard), Hist84MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen84Month AND IsCard), Hist84MCreditLimit));																					
																					
Business: => Sbfecurrentlimitoline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen AND IsOLine)) = 0 => NO_DATA_AVAILABLE,
																					ALL(BusinessAccount.acc(IsOpen AND IsOLine), CurrentCreditLimit:Null) => UNKNOWN_DATA,
																					SUM(BusinessAccount.acc(IsOpen AND IsOLine), CurrentCreditLimit));
Business: => Sbfelimitoelineamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 Sbfeopenoelinecount03m = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen3Month AND IsOLine), Hist03MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen3Month AND IsOLine), Hist03MCreditLimit));
Business: => Sbfelimitoelineamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 Sbfeopenoelinecount06m = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen6Month AND IsOLine), Hist06MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen6Month AND IsOLine), Hist06MCreditLimit));
Business: => Sbfelimitoelineamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 Sbfeopenoelinecount12m = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen12Month AND IsOLine), Hist12MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen12Month AND IsOLine), Hist12MCreditLimit));
Business: => Sbfelimitoelineamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 Sbfeopenoelinecount24m = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen24Month AND IsOLine), Hist24MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen24Month AND IsOLine), Hist24MCreditLimit));
Business: => Sbfelimitoelineamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 Sbfeopenoelinecount36m = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen36Month AND IsOLine), Hist36MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen36Month AND IsOLine), Hist36MCreditLimit));
Business: => Sbfelimitoelineamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 Sbfeopenoelinecount60m = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen60Month AND IsOLine), Hist60MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen60Month AND IsOLine), Hist60MCreditLimit));
Business: => Sbfelimitoelineamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 Sbfeopenoelinecount84m = 0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc(IsOpen84Month AND IsOLine), Hist84MCreditLimit:Null) => UNKNOWN_DATA,
																				 SUM(BusinessAccount.acc(IsOpen84Month AND IsOLine), Hist84MCreditLimit));																				
																					

Account: => MostRecentPaymentIntervalDate := MAX(AccountTradeline.trade(NOT payment_interval:Null), load_date);
Tradeline: => MonthsBetweenPayment := MAP(payment_interval = 'A' 		=> 12,		// Annual
																					payment_interval = 'BM'		=> 2,   	// Bi-monthly
																					payment_interval = 'BW'		=> 0.5, 	// Bi-weekly
																					payment_interval = 'D'		=> 1/30, 	// Daily
																					payment_interval = 'M' 		=> 1,    	// Monthly
																					payment_interval = 'Q'		=> 3,    	// Quarterly
																					payment_interval = 'S'		=> 3,    	// Seasonal
																					payment_interval = 'SA'		=> 6,   	// Semi-annual
																					payment_interval = 'SM' 	=> 0.5, 	// Semi-monthly
																					payment_interval = 'SP' 	=> 1,   	// Single payment
																					payment_interval = 'W'		=> 0.25, 	// Weekly
																																			 1);
Account: => MonthsBetweenPayment := MAX(AccountTradeline(trade.load_date = acc.MostRecentPaymentIntervalDate), trade.MonthsBetweenPayment);
Account: => MostRecentScheduledDate := MAX(AccountTradeline.trade(NOT payment_amount_scheduled:Null), load_date); //check 0 okay, null isn't

//If payment_amount_scheduled is negative, then we mark the account scheduled amount as NULL, per Lea. 
Account: => AmountScheduledMonthly := ROUND(ONLY(AccountTradeline.trade(load_date = Account.MostRecentScheduledDate AND payment_amount_scheduled >= 0), payment_amount_scheduled) / MonthsBetweenPayment);

Business: => Sbfescheduledall := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 COUNT(BusinessAccount.acc(IsOpen)) = 0 => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOpen), AmountScheduledMonthly:Null) => UNKNOWN_DATA,
																 SUM(BusinessAccount.acc(IsOpen), AmountScheduledMonthly));  //sum of accounts
Business: => Sbfescheduledloan := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 COUNT(BusinessAccount.acc(IsOpen AND IsLoan)) = 0 => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOpen AND IsLoan), AmountScheduledMonthly:Null) => UNKNOWN_DATA,
																 SUM(BusinessAccount.acc(IsOpen AND IsLoan), AmountScheduledMonthly));
Business: => Sbfescheduledline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 COUNT(BusinessAccount.acc(IsOpen AND IsLine)) = 0 => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOpen AND IsLine), AmountScheduledMonthly:Null) => UNKNOWN_DATA,
																 SUM(BusinessAccount.acc(IsOpen AND IsLine), AmountScheduledMonthly));
Business: => Sbfescheduledcard := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 COUNT(BusinessAccount.acc(IsOpen AND IsCard)) = 0 => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOpen AND IsCard), AmountScheduledMonthly:Null) => UNKNOWN_DATA,
																 SUM(BusinessAccount.acc(IsOpen AND IsCard), AmountScheduledMonthly));
Business: => Sbfescheduledlease := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 COUNT(BusinessAccount.acc(IsOpen AND IsLease)) = 0 => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOpen AND IsLease), AmountScheduledMonthly:Null) => UNKNOWN_DATA,
																 SUM(BusinessAccount.acc(IsOpen AND IsLease), AmountScheduledMonthly));
Business: => Sbfescheduledletter := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 COUNT(BusinessAccount.acc(IsOpen AND IsLetter)) = 0 => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOpen AND IsLetter), AmountScheduledMonthly:Null) => UNKNOWN_DATA,
																 SUM(BusinessAccount.acc(IsOpen AND IsLetter), AmountScheduledMonthly));
Business: => Sbfescheduledoline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 COUNT(BusinessAccount.acc(IsOpen AND IsOLine)) = 0 => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOpen AND IsOLine), AmountScheduledMonthly:Null) => UNKNOWN_DATA,
																 SUM(BusinessAccount.acc(IsOpen AND IsOLine), AmountScheduledMonthly));
Business: => Sbfescheduledother := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 COUNT(BusinessAccount.acc(IsOpen AND IsOther)) = 0 => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOpen AND IsOther), AmountScheduledMonthly:Null) => UNKNOWN_DATA,
																 SUM(BusinessAccount.acc(IsOpen AND IsOther), AmountScheduledMonthly));

Account: => MostRecentRecievedDate := MAX(AccountTradeline.trade(NOT recent_payment_amount:Null), load_date); //check 0 okay, null isn't

//If recent_payment_amount is negative, then we mark the account recieved amount as NULL, per Lea. 
Account: => AmountRecievedMonthly := ROUND(MAX(AccountTradeline.trade(load_date = Account.MostRecentRecievedDate AND recent_payment_amount >= 0), recent_payment_amount) / MonthsBetweenPayment);

Business: => Sbfereceivedall := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 COUNT(BusinessAccount.acc(IsOpen)) = 0 => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOpen), AmountRecievedMonthly:Null) => UNKNOWN_DATA,
																 SUM(BusinessAccount.acc(IsOpen), AmountRecievedMonthly)); // sum of accounts
Business: => Sbfereceivedloan := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 COUNT(BusinessAccount.acc(IsOpen AND IsLoan)) = 0 => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOpen AND IsLoan), AmountRecievedMonthly:Null) => UNKNOWN_DATA,
																 SUM(BusinessAccount.acc(IsOpen AND IsLoan), AmountRecievedMonthly));
Business: => Sbfereceivedline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 COUNT(BusinessAccount.acc(IsOpen AND IsLine)) = 0 => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOpen AND IsLine), AmountRecievedMonthly:Null) => UNKNOWN_DATA,
																 SUM(BusinessAccount.acc(IsOpen AND IsLine), AmountRecievedMonthly));
Business: => Sbfereceivedcard := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 COUNT(BusinessAccount.acc(IsOpen AND IsCard)) = 0 => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOpen AND IsCard), AmountRecievedMonthly:Null) => UNKNOWN_DATA,
																 SUM(BusinessAccount.acc(IsOpen AND IsCard), AmountRecievedMonthly));
Business: => Sbfereceivedlease := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 COUNT(BusinessAccount.acc(IsOpen AND IsLease)) = 0 => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOpen AND IsLease), AmountRecievedMonthly:Null) => UNKNOWN_DATA,
																 SUM(BusinessAccount.acc(IsOpen AND IsLease), AmountRecievedMonthly));
Business: => Sbfereceivedletter := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 COUNT(BusinessAccount.acc(IsOpen AND IsLetter)) = 0 => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOpen AND IsLetter), AmountRecievedMonthly:Null) => UNKNOWN_DATA,
																 SUM(BusinessAccount.acc(IsOpen AND IsLetter), AmountRecievedMonthly));
Business: => Sbfereceivedoline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 COUNT(BusinessAccount.acc(IsOpen AND IsOLine)) = 0 => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOpen AND IsOLine), AmountRecievedMonthly:Null) => UNKNOWN_DATA,
																 SUM(BusinessAccount.acc(IsOpen AND IsOLine), AmountRecievedMonthly));
Business: => Sbfereceivedother := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 COUNT(BusinessAccount.acc(IsOpen AND IsOther)) = 0 => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOpen AND IsOther), AmountRecievedMonthly:Null) => UNKNOWN_DATA,
																 SUM(BusinessAccount.acc(IsOpen AND IsOther), AmountRecievedMonthly));

////////////internal////////////////
Account: => IsValidAccountUtilization := CurrentCreditLimit > 0; //only include accounts with nonzero limits
Account: => IsValidAccountUtilization03M := Hist03MCreditLimit > 0;
Account: => IsValidAccountUtilization06M := Hist06MCreditLimit > 0;
Account: => IsValidAccountUtilization12M := Hist12MCreditLimit > 0;
Account: => IsValidAccountUtilization24M := Hist24MCreditLimit > 0;
Account: => IsValidAccountUtilization36M := Hist36MCreditLimit > 0;
Account: => IsValidAccountUtilization60M := Hist60MCreditLimit > 0;
Account: => IsValidAccountUtilization84M := Hist84MCreditLimit > 0;

Account: => AccountUtilization := ROUND((AccountBalance / CurrentCreditLimit)*100);

Business: => RemainingBalanceRevolving := SUM(BusinessAccount.acc(IsOpen AND IsValidAccountUtilization AND IsRevolvingAccount), AccountBalance);
Business: => RemainingBalanceRevolving03M := SUM(BusinessAccount.acc(IsOpen3Month AND IsValidAccountUtilization03M AND IsRevolvingAccount), Hist03MTradeline.AccountBalance);
Business: => RemainingBalanceRevolving06M := SUM(BusinessAccount.acc(IsOpen6Month AND IsValidAccountUtilization03M AND IsRevolvingAccount), Hist06MTradeline.AccountBalance);
Business: => RemainingBalanceRevolving12M := SUM(BusinessAccount.acc(IsOpen12Month AND IsValidAccountUtilization03M AND IsRevolvingAccount), Hist12MTradeline.AccountBalance);
Business: => RemainingBalanceRevolving24M := SUM(BusinessAccount.acc(IsOpen24Month AND IsValidAccountUtilization03M AND IsRevolvingAccount), Hist24MTradeline.AccountBalance);
Business: => RemainingBalanceRevolving36M := SUM(BusinessAccount.acc(IsOpen36Month AND IsValidAccountUtilization03M AND IsRevolvingAccount), Hist36MTradeline.AccountBalance);
Business: => RemainingBalanceRevolving60M := SUM(BusinessAccount.acc(IsOpen60Month AND IsValidAccountUtilization03M AND IsRevolvingAccount), Hist60MTradeline.AccountBalance);
Business: => RemainingBalanceRevolving84M := SUM(BusinessAccount.acc(IsOpen84Month AND IsValidAccountUtilization03M AND IsRevolvingAccount), Hist84MTradeline.AccountBalance);

Business: => RemainingBalanceLine := SUM(BusinessAccount.acc(IsOpen AND IsValidAccountUtilization AND IsLine), AccountBalance);
Business: => RemainingBalanceLine03M := SUM(BusinessAccount.acc(IsOpen3Month AND IsValidAccountUtilization03M AND IsLine), Hist03MTradeline.AccountBalance);
Business: => RemainingBalanceLine06M := SUM(BusinessAccount.acc(IsOpen6Month AND IsValidAccountUtilization03M AND IsLine), Hist06MTradeline.AccountBalance);
Business: => RemainingBalanceLine12M := SUM(BusinessAccount.acc(IsOpen12Month AND IsValidAccountUtilization03M AND IsLine), Hist12MTradeline.AccountBalance);
Business: => RemainingBalanceLine24M := SUM(BusinessAccount.acc(IsOpen24Month AND IsValidAccountUtilization03M AND IsLine), Hist24MTradeline.AccountBalance);
Business: => RemainingBalanceLine36M := SUM(BusinessAccount.acc(IsOpen36Month AND IsValidAccountUtilization03M AND IsLine), Hist36MTradeline.AccountBalance);
Business: => RemainingBalanceLine60M := SUM(BusinessAccount.acc(IsOpen60Month AND IsValidAccountUtilization03M AND IsLine), Hist60MTradeline.AccountBalance);
Business: => RemainingBalanceLine84M := SUM(BusinessAccount.acc(IsOpen84Month AND IsValidAccountUtilization03M AND IsLine), Hist84MTradeline.AccountBalance);

Business: => RemainingBalanceCard := SUM(BusinessAccount.acc(IsOpen AND IsValidAccountUtilization AND IsCard), AccountBalance);
Business: => RemainingBalanceCard03M := SUM(BusinessAccount.acc(IsOpen3Month AND IsValidAccountUtilization03M AND IsCard), Hist03MTradeline.AccountBalance);
Business: => RemainingBalanceCard06M := SUM(BusinessAccount.acc(IsOpen6Month AND IsValidAccountUtilization03M AND IsCard), Hist06MTradeline.AccountBalance);
Business: => RemainingBalanceCard12M := SUM(BusinessAccount.acc(IsOpen12Month AND IsValidAccountUtilization03M AND IsCard), Hist12MTradeline.AccountBalance);
Business: => RemainingBalanceCard24M := SUM(BusinessAccount.acc(IsOpen24Month AND IsValidAccountUtilization03M AND IsCard), Hist24MTradeline.AccountBalance);
Business: => RemainingBalanceCard36M := SUM(BusinessAccount.acc(IsOpen36Month AND IsValidAccountUtilization03M AND IsCard), Hist36MTradeline.AccountBalance);
Business: => RemainingBalanceCard60M := SUM(BusinessAccount.acc(IsOpen60Month AND IsValidAccountUtilization03M AND IsCard), Hist60MTradeline.AccountBalance);
Business: => RemainingBalanceCard84M := SUM(BusinessAccount.acc(IsOpen84Month AND IsValidAccountUtilization03M AND IsCard), Hist84MTradeline.AccountBalance);

Business: => RemainingBalanceOLine := SUM(BusinessAccount.acc(IsOpen AND IsValidAccountUtilization AND IsOLine), AccountBalance);
Business: => RemainingBalanceOLine03M := SUM(BusinessAccount.acc(IsOpen3Month AND IsValidAccountUtilization03M AND IsOLine), Hist03MTradeline.AccountBalance);
Business: => RemainingBalanceOLine06M := SUM(BusinessAccount.acc(IsOpen6Month AND IsValidAccountUtilization03M AND IsOLine), Hist06MTradeline.AccountBalance);
Business: => RemainingBalanceOLine12M := SUM(BusinessAccount.acc(IsOpen12Month AND IsValidAccountUtilization03M AND IsOLine), Hist12MTradeline.AccountBalance);
Business: => RemainingBalanceOLine24M := SUM(BusinessAccount.acc(IsOpen24Month AND IsValidAccountUtilization03M AND IsOLine), Hist24MTradeline.AccountBalance);
Business: => RemainingBalanceOLine36M := SUM(BusinessAccount.acc(IsOpen36Month AND IsValidAccountUtilization03M AND IsOLine), Hist36MTradeline.AccountBalance);
Business: => RemainingBalanceOLine60M := SUM(BusinessAccount.acc(IsOpen60Month AND IsValidAccountUtilization03M AND IsOLine), Hist60MTradeline.AccountBalance);
Business: => RemainingBalanceOLine84M := SUM(BusinessAccount.acc(IsOpen84Month AND IsValidAccountUtilization03M AND IsOLine), Hist84MTradeline.AccountBalance);

Business: => CannotCalculateUtilizationRevolving := ALL(BusinessAccount.acc(IsOpen AND IsRevolvingAccount), AccountBalance:Null) OR	Sbfecurrentlimitrevolving <= 0;
Business: => CannotCalculateUtilizationRevolving03M := ALL(BusinessAccount.acc(IsOpen3Month AND IsRevolvingAccount), Hist03MTradeline.AccountBalance:Null) OR Sbfelimitrevamt03m <= 0;
Business: => CannotCalculateUtilizationRevolving06M := ALL(BusinessAccount.acc(IsOpen6Month AND IsRevolvingAccount), Hist06MTradeline.AccountBalance:Null) OR Sbfelimitrevamt06m <= 0;
Business: => CannotCalculateUtilizationRevolving12M := ALL(BusinessAccount.acc(IsOpen12Month AND IsRevolvingAccount), Hist12MTradeline.AccountBalance:Null) OR Sbfelimitrevamt12m <= 0;
Business: => CannotCalculateUtilizationRevolving24M := ALL(BusinessAccount.acc(IsOpen24Month AND IsRevolvingAccount), Hist24MTradeline.AccountBalance:Null) OR Sbfelimitrevamt24m <= 0;
Business: => CannotCalculateUtilizationRevolving36M := ALL(BusinessAccount.acc(IsOpen36Month AND IsRevolvingAccount), Hist36MTradeline.AccountBalance:Null) OR Sbfelimitrevamt36m <= 0;
Business: => CannotCalculateUtilizationRevolving60M := ALL(BusinessAccount.acc(IsOpen60Month AND IsRevolvingAccount), Hist60MTradeline.AccountBalance:Null) OR Sbfelimitrevamt60m <= 0;
Business: => CannotCalculateUtilizationRevolving84M := ALL(BusinessAccount.acc(IsOpen84Month AND IsRevolvingAccount), Hist84MTradeline.AccountBalance:Null) OR Sbfelimitrevamt84m <= 0;
																										
Business: => CannotCalculateUtilizationLine := ALL(BusinessAccount.acc(IsOpen AND IsLine), AccountBalance:Null) OR Sbfecurrentlimitline <= 0;
Business: => CannotCalculateUtilizationLine03M := ALL(BusinessAccount.acc(IsOpen3Month AND IsLine), Hist03MTradeline.AccountBalance:Null) OR Sbfelimitlineamt03m <= 0;
Business: => CannotCalculateUtilizationLine06M := ALL(BusinessAccount.acc(IsOpen6Month AND IsLine), Hist06MTradeline.AccountBalance:Null) OR Sbfelimitlineamt06m <= 0;
Business: => CannotCalculateUtilizationLine12M := ALL(BusinessAccount.acc(IsOpen12Month AND IsLine), Hist12MTradeline.AccountBalance:Null) OR Sbfelimitlineamt12m <= 0;
Business: => CannotCalculateUtilizationLine24M := ALL(BusinessAccount.acc(IsOpen24Month AND IsLine), Hist24MTradeline.AccountBalance:Null) OR Sbfelimitlineamt24m <= 0;
Business: => CannotCalculateUtilizationLine36M := ALL(BusinessAccount.acc(IsOpen36Month AND IsLine), Hist36MTradeline.AccountBalance:Null) OR Sbfelimitlineamt36m <= 0;
Business: => CannotCalculateUtilizationLine60M := ALL(BusinessAccount.acc(IsOpen60Month AND IsLine), Hist60MTradeline.AccountBalance:Null) OR Sbfelimitlineamt60m <= 0;
Business: => CannotCalculateUtilizationLine84M := ALL(BusinessAccount.acc(IsOpen84Month AND IsLine), Hist84MTradeline.AccountBalance:Null) OR Sbfelimitlineamt84m <= 0;
																				
Business: => CannotCalculateUtilizationCard := ALL(BusinessAccount.acc(IsOpen AND IsCard), AccountBalance:Null) OR Sbfecurrentlimitcard <= 0;
Business: => CannotCalculateUtilizationCard03M := ALL(BusinessAccount.acc(IsOpen3Month AND IsCard), Hist03MTradeline.AccountBalance:Null) OR Sbfelimitcardamt03m <= 0;
Business: => CannotCalculateUtilizationCard06M := ALL(BusinessAccount.acc(IsOpen6Month AND IsCard), Hist06MTradeline.AccountBalance:Null) OR Sbfelimitcardamt06m <= 0;
Business: => CannotCalculateUtilizationCard12M := ALL(BusinessAccount.acc(IsOpen12Month AND IsCard), Hist12MTradeline.AccountBalance:Null) OR Sbfelimitcardamt12m <= 0;
Business: => CannotCalculateUtilizationCard24M := ALL(BusinessAccount.acc(IsOpen24Month AND IsCard), Hist24MTradeline.AccountBalance:Null) OR Sbfelimitcardamt24m <= 0;
Business: => CannotCalculateUtilizationCard36M := ALL(BusinessAccount.acc(IsOpen36Month AND IsCard), Hist36MTradeline.AccountBalance:Null) OR Sbfelimitcardamt36m <= 0;
Business: => CannotCalculateUtilizationCard60M := ALL(BusinessAccount.acc(IsOpen60Month AND IsCard), Hist60MTradeline.AccountBalance:Null) OR Sbfelimitcardamt60m <= 0;
Business: => CannotCalculateUtilizationCard84M := ALL(BusinessAccount.acc(IsOpen84Month AND IsCard), Hist84MTradeline.AccountBalance:Null) OR Sbfelimitcardamt84m <= 0;

Business: => CannotCalculateUtilizationOLine := ALL(BusinessAccount.acc(IsOpen AND IsOLine), AccountBalance:Null) OR Sbfecurrentlimitoline <= 0;
Business: => CannotCalculateUtilizationOLine03M := ALL(BusinessAccount.acc(IsOpen3Month AND IsOLine), Hist03MTradeline.AccountBalance:Null) OR Sbfelimitoelineamt03m <= 0;
Business: => CannotCalculateUtilizationOLine06M := ALL(BusinessAccount.acc(IsOpen6Month AND IsOLine), Hist06MTradeline.AccountBalance:Null) OR Sbfelimitoelineamt06m <= 0;
Business: => CannotCalculateUtilizationOLine12M := ALL(BusinessAccount.acc(IsOpen12Month AND IsOLine), Hist12MTradeline.AccountBalance:Null) OR Sbfelimitoelineamt12m <= 0;
Business: => CannotCalculateUtilizationOLine24M := ALL(BusinessAccount.acc(IsOpen24Month AND IsOLine), Hist24MTradeline.AccountBalance:Null) OR Sbfelimitoelineamt24m <= 0;
Business: => CannotCalculateUtilizationOLine36M := ALL(BusinessAccount.acc(IsOpen36Month AND IsOLine), Hist36MTradeline.AccountBalance:Null) OR Sbfelimitoelineamt36m <= 0;
Business: => CannotCalculateUtilizationOLine60M := ALL(BusinessAccount.acc(IsOpen60Month AND IsOLine), Hist60MTradeline.AccountBalance:Null) OR Sbfelimitoelineamt60m <= 0;
Business: => CannotCalculateUtilizationOLine84M := ALL(BusinessAccount.acc(IsOpen84Month AND IsOLine), Hist84MTradeline.AccountBalance:Null) OR Sbfelimitoelineamt84m <= 0;
						
///////////////////////////////////

Business: => Sbfeutilizationcurrentrevolving := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationRevolving => UNKNOWN_DATA,
																					ROUND((RemainingBalanceRevolving / Sbfecurrentlimitrevolving)*100)); //oline not included, per Lea
Business: => Sbfeavailablecurrentrevolving := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationRevolving => UNKNOWN_DATA,
																					(100 - IF(Sbfeutilizationcurrentrevolving >= 100, 100, Sbfeutilizationcurrentrevolving)));

Business: => Sbfeutilrevolving03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen3Month AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationRevolving03M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceRevolving03M / Sbfelimitrevamt03m)*100));
Business: => Sbfeutilrevolving06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen6Month AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationRevolving06M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceRevolving06M / Sbfelimitrevamt06m)*100));
Business: => Sbfeutilrevolving12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen12Month AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationRevolving12M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceRevolving12M / Sbfelimitrevamt12m)*100));
Business: => Sbfeutilrevolving24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen24Month AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationRevolving24M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceRevolving24M / Sbfelimitrevamt24m)*100));
Business: => Sbfeutilrevolving36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen36Month AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationRevolving36M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceRevolving36M / Sbfelimitrevamt36m)*100));
Business: => Sbfeutilrevolving60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen60Month AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationRevolving60M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceRevolving60M / Sbfelimitrevamt60m)*100));
Business: => Sbfeutilrevolving84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen84Month AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationRevolving84M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceRevolving84M / Sbfelimitrevamt84m)*100));
																					
Business: => Sbfeutilizationcurrentline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen AND IsLine)) = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationLine  => UNKNOWN_DATA,
																					ROUND((RemainingBalanceLine / Sbfecurrentlimitline)*100));
Business: => Sbfeavailablecurrentline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen AND IsLine)) = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationLine => UNKNOWN_DATA,
																					(100 - IF(Sbfeutilizationcurrentline >= 100, 100, Sbfeutilizationcurrentline)));																			
																					
Business: => Sbfeutilline03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeopenlinecount03m = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationLine03M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceLine03M / Sbfelimitlineamt03m)*100));
Business: => Sbfeutilline06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeopenlinecount06m = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationLine06M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceLine06M / Sbfelimitlineamt06m)*100));
Business: => Sbfeutilline12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeopenlinecount12m = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationLine12M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceLine12M / Sbfelimitlineamt12m)*100));
Business: => Sbfeutilline24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeopenlinecount24m = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationLine24M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceLine24M / Sbfelimitlineamt24m)*100));
Business: => Sbfeutilline36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeopenlinecount36m = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationLine36M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceLine36M / Sbfelimitlineamt36m)*100));
Business: => Sbfeutilline60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeopenlinecount60m = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationLine60M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceLine60M / Sbfelimitlineamt60m)*100));
Business: => Sbfeutilline84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeopenlinecount84m = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationLine84M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceLine84M / Sbfelimitlineamt84m)*100));
																					
Business: => Sbfeutilizationcurrentcard := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen AND IsCard)) = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationCard => UNKNOWN_DATA,
																					ROUND((RemainingBalanceCard / Sbfecurrentlimitcard)*100));
																					
Business: => Sbfeavailablecurrentcard := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen AND IsCard)) = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationCard => UNKNOWN_DATA,
																					(100 - IF(Sbfeutilizationcurrentcard >= 100, 100, Sbfeutilizationcurrentcard)));
																					
Business: => Sbfeutilcard03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeopencardcount03m = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationCard03M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceCard03M / Sbfelimitcardamt03m)*100));
Business: => Sbfeutilcard06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeopencardcount06m = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationCard06M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceCard06M / Sbfelimitcardamt06m)*100));
Business: => Sbfeutilcard12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeopencardcount12m = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationCard12M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceCard12M / Sbfelimitcardamt12m)*100));
Business: => Sbfeutilcard24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeopencardcount24m = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationCard24M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceCard24M / Sbfelimitcardamt24m)*100));
Business: => Sbfeutilcard36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeopencardcount36m = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationCard36M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceCard36M / Sbfelimitcardamt36m)*100));
Business: => Sbfeutilcard60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeopencardcount60m = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationCard60M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceCard60M / Sbfelimitcardamt60m)*100));
Business: => Sbfeutilcard84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeopencardcount84m = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationCard84M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceCard84M / Sbfelimitcardamt84m)*100));
																					
Business: => Sbfeutilizationcurrentoline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen AND IsOLine)) = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationOLine => UNKNOWN_DATA,
																					ROUND((RemainingBalanceOLine / Sbfecurrentlimitoline)*100));
																					
Business: => Sbfeavailablecurrentoeline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen AND IsOLine)) = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationOLine => UNKNOWN_DATA,
																					(100 - IF(Sbfeutilizationcurrentoline >= 100, 100, Sbfeutilizationcurrentoline)));
																					
Business: => Sbfeutiloeline03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeopenoelinecount03m = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationOLine03M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceOLine03M / Sbfelimitoelineamt03m)*100));
Business: => Sbfeutiloeline06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeopenoelinecount06m = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationOLine06M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceOLine06M / Sbfelimitoelineamt06m)*100));
Business: => Sbfeutiloeline12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeopenoelinecount12m = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationOLine12M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceOLine12M / Sbfelimitoelineamt12m)*100));
Business: => Sbfeutiloeline24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeopenoelinecount24m = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationOLine24M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceOLine24M / Sbfelimitoelineamt24m)*100));
Business: => Sbfeutiloeline36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeopenoelinecount36m = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationOLine36M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceOLine36M / Sbfelimitoelineamt36m)*100));
Business: => Sbfeutiloeline60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeopenoelinecount60m = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationOLine60M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceOLine60M / Sbfelimitoelineamt60m)*100));
Business: => Sbfeutiloeline84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfeopenoelinecount84m = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationOLine84M => UNKNOWN_DATA,
																					ROUND((RemainingBalanceOLine84M / Sbfelimitoelineamt84m)*100));
																					
Business: => Sbfeutilization75revolvingcount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationRevolving => UNKNOWN_DATA,
																					COUNT(BusinessAccount.acc(IsOpen AND IsRevolvingAccount AND AccountUtilization >= 75)));
Business: => Sbfeutilization75line := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen AND IsLine)) = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationLine => UNKNOWN_DATA,
																					COUNT(BusinessAccount.acc(IsOpen AND IsLine AND AccountUtilization >= 75)));
Business: => Sbfeutilization75card := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen AND IsCard)) = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationCard => UNKNOWN_DATA,
																					COUNT(BusinessAccount.acc(IsOpen AND IsCard AND AccountUtilization >= 75)));
Business: => Sbfeutilization75oline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen AND IsOLine)) = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationOLine => UNKNOWN_DATA,
																					COUNT(BusinessAccount.acc(IsOpen AND IsOLine AND AccountUtilization >= 75)));

Business: => Sbfeutilization30revolving := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationRevolving => UNKNOWN_DATA,
																					COUNT(BusinessAccount.acc(IsOpen AND IsRevolvingAccount AND AccountUtilization >= 30)));
Business: => Sbfeutilization30line := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen AND IsLine)) = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationLine => UNKNOWN_DATA,
																					COUNT(BusinessAccount.acc(IsOpen AND IsLine AND AccountUtilization >= 30)));
Business: => Sbfeutilization30card := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen AND IsCard)) = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationCard => UNKNOWN_DATA,
																					COUNT(BusinessAccount.acc(IsOpen AND IsCard AND AccountUtilization >= 30)));
Business: => Sbfeutilization30oline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					COUNT(BusinessAccount.acc(IsOpen AND IsOLine)) = 0 => NO_DATA_AVAILABLE,
																					CannotCalculateUtilizationOLine => UNKNOWN_DATA,
																					COUNT(BusinessAccount.acc(IsOpen AND IsOLine AND AccountUtilization >= 30)));
																					
Account: => HighestCreditUsed := MAX(AccountTradeline.trade, highest_credit_used);
Account: => HighestBalance := MAX(AccountTradeline.trade, remaining_balance);
Account: => HighestUtilizedAmount := IF(HighestCreditUsed > HighestBalance,
																		 IF(HighestCreditUsed > 0, HighestCreditUsed, 0),
																		 IF(HighestBalance > 0, HighestBalance, 0));
Account: => UnknownHighUtilization := HighestBalance:Null AND HighestCreditUsed:Null;

Business: => Sbfeutilizationhighrevolving := MAP(BusinessNotOnFile => NOT_ON_FILE,
																						 COUNT(BusinessAccount.acc(IsOpen AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																						 ALL(BusinessAccount.acc(IsOpen AND IsRevolvingAccount), UnknownHighUtilization) => UNKNOWN_DATA,
																						 SUM(BusinessAccount.acc(IsOpen AND IsRevolvingAccount), HighestUtilizedAmount));
																									//open account -- find highest $ amount for each account -- sum of all accounts
Business: => Sbfeutilizationhighline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																						 COUNT(BusinessAccount.acc(IsOpen AND IsLine)) = 0 => NO_DATA_AVAILABLE,
																						 ALL(BusinessAccount.acc(IsOpen AND IsLine), UnknownHighUtilization) => UNKNOWN_DATA,
																						 SUM(BusinessAccount.acc(IsOpen AND IsLine), HighestUtilizedAmount));
Business: => Sbfeutilizationhighcard := MAP(BusinessNotOnFile => NOT_ON_FILE,
																						 COUNT(BusinessAccount.acc(IsOpen AND IsCard)) = 0 => NO_DATA_AVAILABLE,
																						 ALL(BusinessAccount.acc(IsOpen AND IsCard), UnknownHighUtilization) => UNKNOWN_DATA,
																						 SUM(BusinessAccount.acc(IsOpen AND IsCard), HighestUtilizedAmount));
Business: => Sbfeutiliztionhigholine := MAP(BusinessNotOnFile => NOT_ON_FILE,
																						 COUNT(BusinessAccount.acc(IsOpen AND IsOLine)) = 0 => NO_DATA_AVAILABLE,
																						 ALL(BusinessAccount.acc(IsOpen AND IsOLine), UnknownHighUtilization) => UNKNOWN_DATA,
																						 SUM(BusinessAccount.acc(IsOpen AND IsOLine), HighestUtilizedAmount));

//////////////////////////////////////////Card index calculations///////////////////////////////////
//  1. Find current value (sum of balances/total utilization for currently open cards)
//  2. Find which accounts were open 1 years ago. (they don't necessarily have to be open now.)
//  3. Find tradelines occured 11-13 months ago.
//  4. Find which of these tradelines occured closest to one year ago that has a valid balance.
//  5. Mark balance from #4 as 1 year ago tradelines.
//  6. Compare value in #5 to balance in #1.
//  7. Repeat 2-6 for two year tradeline.
//////////////////////////////////////////////////////////////////////////////////////////////////
//1. (Current Card Balance)
Business: => CurrentCardBalance := SUM(BusinessAccount.acc(IsCard AND IsOpen), AccountBalance);

//  (12 Month Balance)  //
//2.
Account: => Open1YearAgo := EXISTS(AccountTradeline.trade(MONTHSBETWEEN(cycle_end_date, CURRENTDATE()) > 11 AND NOT AccountClosed));
//3.
Tradeline: => Is12MonthsAgo := MONTHSBETWEEN(cycle_end_date, CURRENTDATE())IN [10,11,12] AND NOT AccountClosed;
//4.
Tradeline: => DaysAgo := DAYSBETWEEN(cycle_end_date, CURRENTDATE());
Tradeline: => DaysFromOneYear := ABS(DaysAgo - 365);
Account: => MinDaysFromOneYear := MIN(AccountTradeline.trade(NOT AccountBalance:Null), DaysFromOneYear);
//5.
Tradeline: => IsOneYearTradeline := (DaysFromOneYear = MIN(AccountTradeline.acc, MinDaysFromOneYear)) AND
																		Is12MonthsAgo;
Account: => Balance12Month := MAX(AccountTradeline.trade(IsOneYearTradeline), AccountBalance);
Account: => OneYearTradelineExists := EXISTS(AccountTradeline.trade(IsOneYearTradeline));
Business: => CardBalance12Month := SUM(BusinessAccount.acc(IsCard AND Open1YearAgo), Balance12Month);
//6.
Business: => Sbfebalancecard12month := MAP(BusinessNotOnFile => NOT_ON_FILE,
											         				 COUNT(BusinessAccount.acc(IsCard AND IsOpen)) = 0 OR COUNT(BusinessAccount.acc(IsCard AND Open1YearAgo))=0 => NO_DATA_AVAILABLE,
																			 COUNT(BusinessAccount.acc(IsCard AND OneYearTradelineExists))=0 => UNKNOWN_DATA,
																			 CardBalance12Month = CurrentCardBalance => 2,
																			 CardBalance12Month > CurrentCardBalance => 1,
																			 CardBalance12Month < CurrentCardBalance => 3,
																			 UNKNOWN_DATA);

//  (24 Month Balance)  //
//2.
Account: => Open2YearsAgo := EXISTS(AccountTradeline.trade(MONTHSBETWEEN(cycle_end_date, CURRENTDATE()) > 23 AND NOT AccountClosed));
//3.
Tradeline: => Is24MonthsAgo := MONTHSBETWEEN(cycle_end_date, CURRENTDATE())IN [22,23,24] AND NOT AccountClosed;
//4.
Tradeline: => DaysFromTwoYears := ABS(DaysAgo - 730);
Account: => MinDaysFromTwoYears := MIN(AccountTradeline.trade(NOT AccountBalance:Null), DaysFromTwoYears);
//5.
Tradeline: => IsTwoYearTradeline := (DaysFromTwoYears = MIN(AccountTradeline.acc, MinDaysFromTwoYears)) AND
																		Is24MonthsAgo;
Account: => Balance24Month := MAX(AccountTradeline.trade(IsTwoYearTradeline), AccountBalance);
Account: => TwoYearTradelineExists := EXISTS(AccountTradeline.trade(IsTwoYearTradeline));
Business: => CardBalance24Month := SUM(BusinessAccount.acc(IsCard AND Open2YearsAgo), Balance24Month);
//6.
Business: => Sbfebalancecard24month := MAP(BusinessNotOnFile => NOT_ON_FILE,
											         				 COUNT(BusinessAccount.acc(IsCard AND IsOpen)) = 0 OR COUNT(BusinessAccount.acc(IsCard AND Open2YearsAgo))=0 => NO_DATA_AVAILABLE,
																			 COUNT(BusinessAccount.acc(IsCard AND TwoYearTradelineExists))=0 => UNKNOWN_DATA,
																			 CardBalance24Month = CurrentCardBalance => 2,
																			 CardBalance24Month > CurrentCardBalance => 1,
																			 CardBalance24Month < CurrentCardBalance => 3,
																			 UNKNOWN_DATA);


//  (Card Utilization Index)  //
//1. (Current Card Utilization)

// (12 Month Utilization)
//4.
Account: => MinDaysFromOneYearUtil := MIN(AccountTradeline.trade(NOT AccountBalance:Null AND NOT current_credit_limit:Null), DaysFromOneYear);
//5.
Tradeline: => IsOneYearTradelineUtil := (DaysFromOneYear = MIN(AccountTradeline.acc, MinDaysFromOneYearUtil)) AND
																		Is12MonthsAgo;
Account: => Balance12MonthUtil := MAX(AccountTradeline.trade(IsOneYearTradeline), AccountBalance);
Account: => Limit12Month :=	MAX(AccountTradeline.trade(IsOneYearTradeline), current_credit_limit);
Account: => OneYearTradelineExistsUtil := EXISTS(AccountTradeline.trade(IsOneYearTradelineUtil));
Business: => CardUtilization12Month := ROUND((SUM(BusinessAccount.acc(IsCard AND Open1YearAgo), Balance12MonthUtil) / SUM(BusinessAccount.acc(IsCard AND Open1YearAgo), Limit12Month))*100);
//6.
Business: => Sbfeutilizationindexcard12month := MAP(BusinessNotOnFile => NOT_ON_FILE,
											         				 COUNT(BusinessAccount.acc(IsCard AND IsOpen)) = 0 OR COUNT(BusinessAccount.acc(IsCard AND Open1YearAgo))=0 => NO_DATA_AVAILABLE,
																			 COUNT(BusinessAccount.acc(IsCard AND OneYearTradelineExistsUtil))=0 => UNKNOWN_DATA,
																			 Sbfeutilizationcurrentcard = UNKNOWN_DATA => UNKNOWN_DATA,
																			 CardUtilization12Month = Sbfeutilizationcurrentcard => 2,
																			 CardUtilization12Month > Sbfeutilizationcurrentcard => 1,
																			 CardUtilization12Month < Sbfeutilizationcurrentcard => 3,
																			 UNKNOWN_DATA);

//  (24 Month Utilization)  //
//4.
Account: => MinDaysFromTwoYearsUtil := MIN(AccountTradeline.trade(NOT AccountBalance:Null AND NOT current_credit_limit:Null), DaysFromTwoYears);

//5.
Tradeline: => IsTwoYearTradelineUtil := (DaysFromTwoYears = MIN(AccountTradeline.acc, MinDaysFromTwoYearsUtil)) AND
																		Is24MonthsAgo;
Account: => Balance24MonthUtil := MAX(AccountTradeline.trade(IsTwoYearTradeline), AccountBalance);
Account: => Limit24Month :=	MAX(AccountTradeline.trade(IsTwoYearTradeline), current_credit_limit);
Account: => TwoYearTradelineExistsUtil := EXISTS(AccountTradeline.trade(IsTwoYearTradelineUtil));
Business: => CardUtilization24Month := ROUND((SUM(BusinessAccount.acc(IsCard AND Open2YearsAgo), Balance24MonthUtil) / SUM(BusinessAccount.acc(IsCard AND Open2YearsAgo), Limit24Month))*100);
//6.
Business: => Sbfeutilizationindexcard24month := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			 COUNT(BusinessAccount.acc(IsCard AND IsOpen)) = 0 OR COUNT(BusinessAccount.acc(IsCard AND Open2YearsAgo))=0 => NO_DATA_AVAILABLE,
																			 COUNT(BusinessAccount.acc(IsCard AND TwoYearTradelineExistsUtil))=0 => UNKNOWN_DATA,
																			 Sbfeutilizationcurrentcard = UNKNOWN_DATA => UNKNOWN_DATA,
																			 CardUtilization24Month = Sbfeutilizationcurrentcard => 2,
																			 CardUtilization24Month > Sbfeutilizationcurrentcard => 1,
																			 CardUtilization24Month < Sbfeutilizationcurrentcard => 3,
																			 UNKNOWN_DATA);

Tradeline: => UtilizationPercent :=(CycleBalance / current_credit_limit)*100; //should be null if either is null
Tradeline: => GoodUtilizationAveTradeline := GoodAverageDate AND NOT current_credit_limit:Null AND NOT CycleBalance:Null;
Business: => UtilizationByMonth3 := BusinessAccount.acc(IsRevolvingAccount).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 3 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => UtilizationByMonth6 := BusinessAccount.acc(IsRevolvingAccount).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 6 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => UtilizationByMonth12 := BusinessAccount.acc(IsRevolvingAccount).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 12 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => UtilizationByMonth24 := BusinessAccount.acc(IsRevolvingAccount).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 24 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => UtilizationByMonth36 := BusinessAccount.acc(IsRevolvingAccount).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 36 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => UtilizationByMonth60 := BusinessAccount.acc(IsRevolvingAccount).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 60 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => UtilizationByMonth84 := BusinessAccount.acc(IsRevolvingAccount).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 84 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => UtilizationByMonth := BusinessAccount.acc(IsRevolvingAccount).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };

Business: => Sbfeavgutil03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsRevolvingAccount).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsRevolvingAccount).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(UtilizationByMonth3, Utilization)));
Business: => Sbfeutilizationave06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsRevolvingAccount).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsRevolvingAccount).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(UtilizationByMonth6, Utilization)));
Business: => Sbfeutilizationave12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsRevolvingAccount).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsRevolvingAccount).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(UtilizationByMonth12, Utilization)));
Business: => Sbfeutilizationave24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsRevolvingAccount).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsRevolvingAccount).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(UtilizationByMonth24, Utilization)));
Business: => Sbfeutilizationave36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsRevolvingAccount).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsRevolvingAccount).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(UtilizationByMonth36, Utilization)));
Business: => Sbfeutilizationave60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsRevolvingAccount).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsRevolvingAccount).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(UtilizationByMonth60, Utilization)));
Business: => Sbfeutilizationave84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsRevolvingAccount).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsRevolvingAccount).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(UtilizationByMonth84, Utilization)));
Business: => Sbfeutilizationaveever :=  MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsRevolvingAccount).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsRevolvingAccount).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(UtilizationByMonth, Utilization)));

//Lines
Business: => LineUtilizationByMonth3 := BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 3 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => LineUtilizationByMonth6 := BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 6 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => LineUtilizationByMonth12 := BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 12 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => LineUtilizationByMonth24 := BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 24 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => LineUtilizationByMonth36 := BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 36 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => LineUtilizationByMonth60 := BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 60 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => LineUtilizationByMonth84 := BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 84 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => LineUtilizationByMonth := BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };

Business: => Sbfeavgutilline03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LineUtilizationByMonth3, Utilization)));
Business: => Sbfeutilizationave06line := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LineUtilizationByMonth6, Utilization)));
Business: => Sbfeutilizationave12line := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LineUtilizationByMonth12, Utilization)));
Business: => Sbfeutilizationave24line := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LineUtilizationByMonth24, Utilization)));
Business: => Sbfeutilizationave36line := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LineUtilizationByMonth36, Utilization)));
Business: => Sbfeutilizationave60line := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LineUtilizationByMonth60, Utilization)));
Business: => Sbfeutilizationave84line := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LineUtilizationByMonth84, Utilization)));
Business: => Sbfeutilizationaveeverline :=  MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(LineUtilizationByMonth, Utilization)));
//Cards
Business: => CardUtilizationByMonth3 := BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 3 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => CardUtilizationByMonth6 := BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 6 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => CardUtilizationByMonth12 := BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 12 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => CardUtilizationByMonth24 := BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 24 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => CardUtilizationByMonth36 := BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 36 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => CardUtilizationByMonth60 := BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 60 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => CardUtilizationByMonth84 := BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 84 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => CardUtilizationByMonth := BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };

Business: => Sbfeavgutilcard03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(CardUtilizationByMonth3, Utilization)));
Business: => Sbfeutilizationave06card := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(CardUtilizationByMonth6, Utilization)));
Business: => Sbfeutilizationave12card := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(CardUtilizationByMonth12, Utilization)));
Business: => Sbfeutilizationave24card := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(CardUtilizationByMonth24, Utilization)));
Business: => Sbfeutilizationave36card := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(CardUtilizationByMonth36, Utilization)));
Business: => Sbfeutilizationave60card := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(CardUtilizationByMonth60, Utilization)));
Business: => Sbfeutilizationave84card := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(CardUtilizationByMonth84, Utilization)));
Business: => Sbfeutilizationaveevercard :=  MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(CardUtilizationByMonth, Utilization)));
//OLines
Business: => OLineUtilizationByMonth3 := BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 3 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => OLineUtilizationByMonth6 := BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 6 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => OLineUtilizationByMonth12 := BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 12 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => OLineUtilizationByMonth24 := BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 24 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => OLineUtilizationByMonth36 := BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 36 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => OLineUtilizationByMonth60 := BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 60 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => OLineUtilizationByMonth84 := BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND MONTHSBETWEEN(CycleEndMonthDate,CurrentDateMonth) <= 84 AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };
Business: => OLineUtilizationByMonth := BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND GoodUtilizationAveTradeline){CycleEndMonth, Utilization := (SUM(GROUP,CycleBalance)/SUM(GROUP,current_credit_limit))*100 };

Business: => Sbfeavgutiloeline03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(OLineUtilizationByMonth3, Utilization)));
Business: => Sbfeutilizationave06oline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(OLineUtilizationByMonth6, Utilization)));
Business: => Sbfeutilizationave12oline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(OLineUtilizationByMonth12, Utilization)));
Business: => Sbfeutilizationave24oline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(OLineUtilizationByMonth24, Utilization)));
Business: => Sbfeutilizationave36oline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(OLineUtilizationByMonth36, Utilization)));
Business: => Sbfeutilizationave60oline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(OLineUtilizationByMonth60, Utilization)));
Business: => Sbfeutilizationave84oline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(OLineUtilizationByMonth84, Utilization)));
Business: => Sbfeutilizationaveeveroline :=  MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed AND NOT UtilizationPercent:Null)) => UNKNOWN_DATA,
																 ROUND(AVE(OLineUtilizationByMonth, Utilization)));

///////////////PaymentStatus//////////////////
				// UNKNOWN_DATA = Payment status unknown
				// 0 = Current
				// 1 = Past due, timeframe unknown
				// 2 = 1-30 days past due
				// 3 = 31-60 days past due
				// 4 = 61-90 days past due
				// 5 = 91-120 days past due
				// 6 = 121-150 days past due
				// 7 = 151-180 days past due
				// 8 = 181+ days past due
				// 9 = Charge Off
/////////////////////////////////////////////

Tradeline: => PastDueAmount := ABS(past_due_amount);

Tradeline: =>PastDueAmountStatus := MAP(PastDueAmount = ABS(past_due_aging_amount_bucket_1)		=> 2,
																				PastDueAmount = ABS(past_due_aging_amount_bucket_1) +
																												ABS(past_due_aging_amount_bucket_2) 	=> 3,
																				PastDueAmount = ABS(past_due_aging_amount_bucket_1) +
																												ABS(past_due_aging_amount_bucket_2) +
																												ABS(past_due_aging_amount_bucket_3) 	=> 4,
																				PastDueAmount = ABS(past_due_aging_amount_bucket_1) +
																												ABS(past_due_aging_amount_bucket_2) +
																												ABS(past_due_aging_amount_bucket_3) +
																												ABS(past_due_aging_amount_bucket_4) 	=>	5,
																				PastDueAmount = ABS(past_due_aging_amount_bucket_1) +
																												ABS(past_due_aging_amount_bucket_2) +
																												ABS(past_due_aging_amount_bucket_3) +
																												ABS(past_due_aging_amount_bucket_4) +
																												ABS(past_due_aging_amount_bucket_5) 	=>	6,
																				PastDueAmount = ABS(past_due_aging_amount_bucket_1) +
																												ABS(past_due_aging_amount_bucket_2) +
																												ABS(past_due_aging_amount_bucket_3) +
																												ABS(past_due_aging_amount_bucket_4) +
																												ABS(past_due_aging_amount_bucket_5) +
																												ABS(past_due_aging_amount_bucket_6) 	=>	7,
																				PastDueAmount = ABS(past_due_aging_amount_bucket_1) +
																												ABS(past_due_aging_amount_bucket_2) +
																												ABS(past_due_aging_amount_bucket_3) +
																												ABS(past_due_aging_amount_bucket_4) +
																												ABS(past_due_aging_amount_bucket_5) +
																												ABS(past_due_aging_amount_bucket_6) +
																												ABS(past_due_aging_amount_bucket_7) =>	8,
																																																1);

Tradeline: => PaymentStatus := MAP(IsChargeoff 																				=> 9,
																	payment_status_category:Null AND PastDueAmount > 0 	=> PastDueAmountStatus,
																	payment_status_category:Null AND PastDueAmount=0 		=> 0,
																	payment_status_category = '000' 										=> 0,
																	payment_status_category = '001' 										=> 2,
																	payment_status_category = '002' 										=> 3,
																	payment_status_category = '003' 										=> 4,
																	payment_status_category = '004' 										=> 5,
																	payment_status_category = '005' 										=> 6,
																	payment_status_category = '006' 										=> 7,
																	payment_status_category = '007' 										=> 8,
																																												 UNKNOWN_DATA);


Account: => MostRecentPaymentStatusDate := MAX(AccountTradeline.trade, load_date);
Account: => CurrentPaymentStatus := MAX(AccountTradeline.trade(load_date = Account.MostRecentPaymentStatusDate), PaymentStatus);
Account: => IsUnknownPaymentStatus := ALL(AccountTradeline.trade, PaymentStatus = UNKNOWN_DATA);
Account: => CurrentPDAmount := MAX(AccountTradeline.trade(load_date=Account.MostRecentPaymentStatusDate), PastDueAmount);

Tradeline: => Is3Month := MONTHSBETWEEN(cycle_end_date, CURRENTDATE()) < 3 AND (date_account_was_charged_off:Null OR MONTHSBETWEEN(date_account_was_charged_off, CURRENTDATE())<3);
Tradeline: => Is6Month := MONTHSBETWEEN(cycle_end_date, CURRENTDATE()) < 6 AND (date_account_was_charged_off:Null OR MONTHSBETWEEN(date_account_was_charged_off, CURRENTDATE())<6);
Tradeline: => Is12Month := MONTHSBETWEEN(cycle_end_date, CURRENTDATE()) < 12 AND (date_account_was_charged_off:Null OR MONTHSBETWEEN(date_account_was_charged_off, CURRENTDATE())<12);
Tradeline: => Is24Month := MONTHSBETWEEN(cycle_end_date, CURRENTDATE()) < 24 AND (date_account_was_charged_off:Null OR MONTHSBETWEEN(date_account_was_charged_off, CURRENTDATE())<24);
Tradeline: => Is36Month := MONTHSBETWEEN(cycle_end_date, CURRENTDATE()) < 36 AND (date_account_was_charged_off:Null OR MONTHSBETWEEN(date_account_was_charged_off, CURRENTDATE())<36);
Tradeline: => Is60Month := MONTHSBETWEEN(cycle_end_date, CURRENTDATE()) < 60 AND (date_account_was_charged_off:Null OR MONTHSBETWEEN(date_account_was_charged_off, CURRENTDATE())<60);
Tradeline: => Is84Month := MONTHSBETWEEN(cycle_end_date, CURRENTDATE()) < 84 AND (date_account_was_charged_off:Null OR MONTHSBETWEEN(date_account_was_charged_off, CURRENTDATE())<84);

Account: => Worst3 := MAX(AccountTradeline.trade(Is3Month), PaymentStatus); //UNKNOWN_DATA code is a possible value for Worst* attributes
Account: => Worst6 := MAX(AccountTradeline.trade(Is6Month), PaymentStatus);
Account: => Worst12 := MAX(AccountTradeline.trade(Is12Month), PaymentStatus); 
Account: => Worst24 := MAX(AccountTradeline.trade(Is24Month), PaymentStatus);
Account: => Worst36 := MAX(AccountTradeline.trade(Is36Month), PaymentStatus);
Account: => Worst60 := MAX(AccountTradeline.trade(Is60Month), PaymentStatus);
Account: => Worst84 := MAX(AccountTradeline.trade(Is84Month), PaymentStatus);
Account: => WorstEver := MAX(AccountTradeline.trade, PaymentStatus);

Business: => Sbfeworstopen := MAP(BusinessNotOnFile => NOT_ON_FILE,
															Sbfeopenallcount = 0 => NO_DATA_AVAILABLE,
															MAX(BusinessAccount.acc(IsOpen), CurrentPaymentStatus));

Account: => Update3Month := EXISTS(AccountTradeline.trade(Is3Month));
Account: => Update6Month := EXISTS(AccountTradeline.trade(Is6Month));
Account: => Update12Month := EXISTS(AccountTradeline.trade(Is12Month));
Account: => Update24Month := EXISTS(AccountTradeline.trade(Is24Month));
Account: => Update36Month := EXISTS(AccountTradeline.trade(Is36Month));
Account: => Update60Month := EXISTS(AccountTradeline.trade(Is60Month));
Account: => Update84Month := EXISTS(AccountTradeline.trade(Is84Month));


Business: => Sbfehighdelq03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
														NOT EXISTS(BusinessAccount.acc(Update3Month)) => NO_DATA_AVAILABLE,
														MAX(BusinessAccount.acc, Worst3));
Business: => Sbfeworst06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
														NOT EXISTS(BusinessAccount.acc(Update6Month)) => NO_DATA_AVAILABLE,
														MAX(BusinessAccount.acc, Worst6));
Business: => Sbfeworst12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
														NOT EXISTS(BusinessAccount.acc(Update12Month)) => NO_DATA_AVAILABLE,
														MAX(BusinessAccount.acc, Worst12)); //UNKNOWN_DATA built into max (check though)
Business: => Sbfeworst24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
														COUNT(BusinessAccount.acc(Update24Month))=0 => NO_DATA_AVAILABLE,
														MAX(BusinessAccount.acc, Worst24));
Business: => Sbfeworst36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
														COUNT(BusinessAccount.acc(Update36Month))=0 => NO_DATA_AVAILABLE,
														MAX(BusinessAccount.acc, Worst36));
Business: => Sbfeworst60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
														COUNT(BusinessAccount.acc(Update60Month))=0 => NO_DATA_AVAILABLE,
														MAX(BusinessAccount.acc, Worst60));
Business: => Sbfeworst84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
														COUNT(BusinessAccount.acc(Update84Month))=0 => NO_DATA_AVAILABLE,
														MAX(BusinessAccount.acc, Worst84));
Business: => Sbfeworstever := IF(BusinessNotOnFile, NOT_ON_FILE, MAX(BusinessAccount.acc, WorstEver));

Business: => Sbfeworstloan := MAP(BusinessNotOnFile => NOT_ON_FILE,
															Sbfeopenloancount = 0 => NO_DATA_AVAILABLE,
															MAX(BusinessAccount.acc(IsOpen AND IsLoan), CurrentPaymentStatus)); // UNKNOWN_DATA is included in CurrentPaymentStatus
Business: => Sbfehighdelqloan03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLoan AND Update3Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLoan), Worst3));
Business: => Sbfeworstloan06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLoan AND Update6Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLoan), Worst6));
Business: => Sbfeworstloan12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLoan AND Update12Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLoan), Worst12));
Business: => Sbfeworstloan24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLoan AND Update24Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLoan), Worst24));
Business: => Sbfeworstloan36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLoan AND Update36Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLoan), Worst36));
Business: => Sbfeworstloan60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLoan AND Update60Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLoan), Worst60));
Business: => Sbfeworstloan84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLoan AND Update84Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLoan), Worst84));
Business: => Sbfeworstloanever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLoan))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLoan), WorstEver));

Business: => Sbfeworstline := MAP(BusinessNotOnFile => NOT_ON_FILE,
															Sbfeopenlinecount = 0 => NO_DATA_AVAILABLE,
															MAX(BusinessAccount.acc(IsOpen AND IsLine), CurrentPaymentStatus));
Business: => Sbfehighdelqline03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLine AND Update3Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLine), Worst3));
Business: => Sbfeworstline06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLine AND Update6Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLine), Worst6));
Business: => Sbfeworstline12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLine AND Update12Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLine), Worst12));
Business: => Sbfeworstline24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLine AND Update24Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLine), Worst24));
Business: => Sbfeworstline36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLine AND Update36Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLine), Worst36));
Business: => Sbfeworstline60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLine AND Update60Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLine), Worst60));
Business: => Sbfeworstline84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLine AND Update84Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLine), Worst84));
Business: => Sbfeworstlineever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLine))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLine), WorstEver));
																
Business: => Sbfeworstcard := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount = 0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsOpen AND IsCard), CurrentPaymentStatus));
Business: => Sbfehighdelqcard03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsCard AND Update3Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsCard), Worst3));
Business: => Sbfeworstcard06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsCard AND Update6Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsCard), Worst6));
Business: => Sbfeworstcard12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsCard AND Update12Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsCard), Worst12));
Business: => Sbfeworstcard24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsCard AND Update24Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsCard), Worst24));
Business: => Sbfeworstcard36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsCard AND Update36Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsCard), Worst36));
Business: => Sbfeworstcard60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsCard AND Update60Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsCard), Worst60));
Business: => Sbfeworstcard84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsCard AND Update84Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsCard), Worst84));
Business: => Sbfeworstcardever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsCard))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsCard), WorstEver));

Business: => Sbfeworstlease := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount = 0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsOpen AND IsLease), CurrentPaymentStatus));
Business: => Sbfehighdelqlease03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLease AND Update3Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLease), Worst3));
Business: => Sbfeworstlease06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLease AND Update6Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLease), Worst6));
Business: => Sbfeworstlease12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLease AND Update12Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLease), Worst12));
Business: => Sbfeworstlease24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLease AND Update24Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLease), Worst24));
Business: => Sbfeworstlease36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLease AND Update36Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLease), Worst36));
Business: => Sbfeworstlease60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLease AND Update60Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLease), Worst60));
Business: => Sbfeworstlease84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLease AND Update84Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLease), Worst84));
Business: => Sbfeworstleaseever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLease))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLease), WorstEver));

Business: => Sbfeworstletter := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount = 0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsOpen AND IsLetter), CurrentPaymentStatus));
Business: => Sbfehighdelqletter03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLetter AND Update3Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLetter), Worst3));
Business: => Sbfeworstletter06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLetter AND Update6Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLetter), Worst6));
Business: => Sbfeworstletter12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLetter AND Update12Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLetter), Worst12));
Business: => Sbfeworstletter24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLetter AND Update24Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLetter), Worst24));
Business: => Sbfeworstletter36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLetter AND Update36Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLetter), Worst36));
Business: => Sbfeworstletter60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLetter AND Update60Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLetter), Worst60));
Business: => Sbfeworstletter84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLetter AND Update84Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLetter), Worst84));
Business: => Sbfeworstletterever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsLetter))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsLetter), WorstEver));

Business: => Sbfeworstoline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenolinecount = 0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsOpen AND IsOLine), CurrentPaymentStatus));
Business: => Sbfehighdelqoeline03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOLine AND Update3Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsOLine), Worst3));
Business: => Sbfeworstoline06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOLine AND Update6Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsOLine), Worst6));
Business: => Sbfeworstoline12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOLine AND Update12Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsOLine), Worst12));
Business: => Sbfeworstoline24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOLine AND Update24Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsOLine), Worst24));
Business: => Sbfeworstoline36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOLine AND Update36Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsOLine), Worst36));
Business: => Sbfeworstoline60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOLine AND Update60Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsOLine), Worst60));
Business: => Sbfeworstoline84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOLine AND Update84Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsOLine), Worst84));
Business: => Sbfeworstolineever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOLine))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsOLine), WorstEver));

Business: => Sbfeworstother := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount = 0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsOpen AND IsOther), CurrentPaymentStatus));
Business: => Sbfehighdelqother03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOther AND Update3Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsOther), Worst3));
Business: => Sbfeworstother06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOther AND Update6Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsOther), Worst6));
Business: => Sbfeworstother12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOther AND Update12Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsOther), Worst12));
Business: => Sbfeworstother24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOther AND Update24Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsOther), Worst24));
Business: => Sbfeworstother36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOther AND Update36Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsOther), Worst36));
Business: => Sbfeworstother60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOther AND Update60Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsOther), Worst60));
Business: => Sbfeworstother84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOther AND Update84Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsOther), Worst84));
Business: => Sbfeworstotherever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOther))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsOther), WorstEver));
																
Business: => Sbfehighdelqrevopen := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOpen AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsOpen AND IsRevolvingAccount), CurrentPaymentStatus));
Business: => Sbfehighdelqrev03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsRevolvingAccount AND Update3Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsRevolvingAccount), Worst3));
Business: => Sbfehighdelqrev06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsRevolvingAccount AND Update6Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsRevolvingAccount), Worst6));
Business: => Sbfehighdelqrev12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsRevolvingAccount AND Update12Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsRevolvingAccount), Worst12));
Business: => Sbfehighdelqrev24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsRevolvingAccount AND Update24Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsRevolvingAccount), Worst24));
Business: => Sbfehighdelqrev36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsRevolvingAccount AND Update36Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsRevolvingAccount), Worst36));
Business: => Sbfehighdelqrev60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsRevolvingAccount AND Update60Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsRevolvingAccount), Worst60));
Business: => Sbfehighdelqrev84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsRevolvingAccount AND Update84Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsRevolvingAccount), Worst84));
Business: => Sbfehighdelqrevever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsRevolvingAccount))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsRevolvingAccount), WorstEver));
																
Business: => Sbfehighdelqinstopen := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOpen AND IsInstallment)) = 0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsOpen AND IsInstallment), CurrentPaymentStatus));
Business: => Sbfehighdelqinst03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsInstallment AND Update3Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsInstallment), Worst3));
Business: => Sbfehighdelqinst06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsInstallment AND Update6Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsInstallment), Worst6));
Business: => Sbfehighdelqinst12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsInstallment AND Update12Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsInstallment), Worst12));
Business: => Sbfehighdelqinst24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsInstallment AND Update24Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsInstallment), Worst24));
Business: => Sbfehighdelqinst36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsInstallment AND Update36Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsInstallment), Worst36));
Business: => Sbfehighdelqinst60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsInstallment AND Update60Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsInstallment), Worst60));
Business: => Sbfehighdelqinst84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsInstallment AND Update84Month))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsInstallment), Worst84));
Business: => Sbfehighdelqinstever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsInstallment))=0 => NO_DATA_AVAILABLE,
																MAX(BusinessAccount.acc(IsInstallment), WorstEver));


Account: => IsSatisfactory := CurrentPaymentStatus IN [0,2]; //current or 1-30 DPD

Business: => Sbfesatisfactorycount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenallcount = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																			COUNT(BusinessAccount.acc(IsOpen AND IsSatisfactory)));
Business: => Sbfesatisfactorycountloan := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenloancount = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen AND IsLoan), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																			COUNT(BusinessAccount.acc(IsOpen AND IsLoan AND IsSatisfactory)));
Business: => Sbfesatisfactorycountline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenlinecount = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen AND IsLine), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																			COUNT(BusinessAccount.acc(IsOpen AND IsLine AND IsSatisfactory)));
Business: => Sbfesatisfactorycountcard := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopencardcount = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen AND IsCard), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																			COUNT(BusinessAccount.acc(IsOpen AND IsCard AND IsSatisfactory)));
Business: => Sbfesatisfactorycountlease := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenleasecount = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen AND IsLease), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																			COUNT(BusinessAccount.acc(IsOpen AND IsLease AND IsSatisfactory)));
Business: => Sbfesatisfactorycountletter := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenlettercount = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen AND IsLetter), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																			COUNT(BusinessAccount.acc(IsOpen AND IsLetter AND IsSatisfactory)));
Business: => Sbfesatisfactorycountoline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenolinecount = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen AND IsOLine), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																			COUNT(BusinessAccount.acc(IsOpen AND IsOLine AND IsSatisfactory)));
Business: => Sbfesatisfactorycountother := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenothercount = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen AND IsOther), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																			COUNT(BusinessAccount.acc(IsOpen AND IsOther AND IsSatisfactory)));

Account: => IsDelinquent := CurrentPaymentStatus >= 4; //61+ DPD

Account: => MostRecentDelinquencyReportedDate := MAX(AccountTradeline.trade(NOT delinquency_date:Null AND NOT AccountClosed AND NOT delinquency_date > CURRENTDATE()), load_date);
Account: => MostRecentDelinquencyDate := MAX(AccountTradeline.trade(load_date = Account.MostRecentDelinquencyReportedDate), delinquency_date);

Business: => DPDDateLastSeen := MAX(BusinessAccount.acc, MostRecentDelinquencyDate);
Business: => Sbfedpddatelastseen := MAP(BusinessNotOnFile => NOT_ON_FILE,  //use closest delinquency date to archive date -- don't care if >= 4
																					 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade((PaymentStatus>0 OR NOT delinquency_date:Null) AND NOT AccountClosed AND NOT delinquency_date > CURRENTDATE())) => 0,
																					 INTEGERFROMDATE(DPDDateLastSeen));
Business: => Sbfetimenewestdelq := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade((PaymentStatus>0 OR NOT delinquency_date:Null) AND NOT AccountClosed AND NOT delinquency_date > CURRENTDATE())) => NO_DATA_AVAILABLE,
																					Sbfedpddatelastseen:Null OR Sbfedpddatelastseen=0 => UNKNOWN_DATA,
																					MONTHSBETWEEN(DPDDateLastSeen, CURRENTDATE()) + 1);

Business: => Sbfedelq1countttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenallcount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND CurrentPaymentStatus = 2)));
															 
Business: => Sbfedelq1countttlchargeoff := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 NOT EXISTS(BusinessAccount.acc(IsOpen OR IsChargeoff)) => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen), CurrentPaymentStatus=UNKNOWN_DATA) AND NOT EXISTS(BusinessAccount.acc(IsChargeoff)) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc((IsOpen AND CurrentPaymentStatus >= 2)  OR IsChargeoff)));

Business: => Sbfedpd1count := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenallcount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND CurrentPaymentStatus >= 2)));
																
Business: => Sbfedelq1count03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update3Month AND Worst3 >= 2)));
Business: => Sbfedpd1count06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update6Month AND Worst6 >= 2)));
Business: => Sbfedpd1count12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update12Month AND Worst12 >= 2)));
Business: => Sbfedpd1count24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update24Month AND Worst24 >= 2)));
Business: => Sbfedpd1count36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update36Month AND Worst36 >= 2)));
Business: => Sbfedpd1count60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update60Month AND Worst60 >= 2)));
Business: => Sbfedpd1count84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update84Month AND Worst84 >= 2)));
Business: => Sbfedpd1countever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 ALL(BusinessAccount.acc, WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(WorstEver >= 2)));


Business: => Sbfedelq1counteverttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 ALL(BusinessAccount.acc, WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(WorstEver = 2)));

Business: => Sbfedelq1loancount := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenloancount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsLoan), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsLoan AND CurrentPaymentStatus >= 2)));
Business: => Sbfedelq1loancount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update3Month AND Worst3 >= 2)));
Business: => Sbfedelq1loancount06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update6Month AND Worst6 >= 2)));
Business: => Sbfedelq1loancount12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update12Month AND Worst12 >= 2)));
Business: => Sbfedelq1loancount24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update24Month AND Worst24 >= 2)));
Business: => Sbfedelq1loancount36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update36Month AND Worst36 >= 2)));
Business: => Sbfedelq1loancount60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update60Month AND Worst60 >= 2)));
Business: => Sbfedelq1loancount84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update84Month AND Worst84 >= 2)));
Business: => Sbfedelq1loancountever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeloancount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND WorstEver >= 2)));
															 
Business: => Sbfedelq1linecount := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenlinecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsLine), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsLine AND CurrentPaymentStatus >= 2)));
Business: => Sbfedelq1linecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update3Month AND Worst3 >= 2)));
Business: => Sbfedelq1linecount06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update6Month AND Worst6 >= 2)));
Business: => Sbfedelq1linecount12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update12Month AND Worst12 >= 2)));
Business: => Sbfedelq1linecount24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update24Month AND Worst24 >= 2)));
Business: => Sbfedelq1linecount36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update36Month AND Worst36 >= 2)));
Business: => Sbfedelq1linecount60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update60Month AND Worst60 >= 2)));
Business: => Sbfedelq1linecount84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update84Month AND Worst84 >= 2)));
Business: => Sbfedelq1linecountever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfelinecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND WorstEver >= 2)));
															 
Business: => Sbfedelq1cardcount := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopencardcount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsCard), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsCard AND CurrentPaymentStatus >= 2)));
Business: => Sbfedelq1cardcount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update3Month AND Worst3 >= 2)));
Business: => Sbfedelq1cardcount06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update6Month AND Worst6 >= 2)));
Business: => Sbfedelq1cardcount12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update12Month AND Worst12 >= 2)));
Business: => Sbfedelq1cardcount24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update24Month AND Worst24 >= 2)));
Business: => Sbfedelq1cardcount36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update36Month AND Worst36 >= 2)));
Business: => Sbfedelq1cardcount60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update60Month AND Worst60 >= 2)));
Business: => Sbfedelq1cardcount84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update84Month AND Worst84 >= 2)));
Business: => Sbfedelq1cardcountever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfecardcount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND WorstEver >= 2)));
															 
Business: => Sbfedelq1leasecount := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenleasecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsLease), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsLease AND CurrentPaymentStatus >= 2)));
Business: => Sbfedelq1leasecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update3Month AND Worst3 >= 2)));
Business: => Sbfedelq1leasecount06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update6Month AND Worst6 >= 2)));
Business: => Sbfedelq1leasecount12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update12Month AND Worst12 >= 2)));
Business: => Sbfedelq1leasecount24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update24Month AND Worst24 >= 2)));
Business: => Sbfedelq1leasecount36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update36Month AND Worst36 >= 2)));
Business: => Sbfedelq1leasecount60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update60Month AND Worst60 >= 2)));
Business: => Sbfedelq1leasecount84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update84Month AND Worst84 >= 2)));
Business: => Sbfedelq1leasecountever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeleasecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND WorstEver >= 2)));
															 
Business: => Sbfedelq1lettercount := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenlettercount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsLetter), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsLetter AND CurrentPaymentStatus >= 2)));
Business: => Sbfedelq1lettercount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update3Month AND Worst3 >= 2)));
Business: => Sbfedelq1lettercount06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update6Month AND Worst6 >= 2)));
Business: => Sbfedelq1lettercount12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update12Month AND Worst12 >= 2)));
Business: => Sbfedelq1lettercount24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update24Month AND Worst24 >= 2)));
Business: => Sbfedelq1lettercount36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update36Month AND Worst36 >= 2)));
Business: => Sbfedelq1lettercount60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update60Month AND Worst60 >= 2)));
Business: => Sbfedelq1lettercount84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update84Month AND Worst84 >= 2)));
Business: => Sbfedelq1lettercountever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfelettercount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND WorstEver >= 2)));
															 
Business: => Sbfedelq1oelinecount := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenolinecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsOLine), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsOLine AND CurrentPaymentStatus >= 2)));
Business: => Sbfedelq1oelinecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update3Month AND Worst3 >= 2)));
Business: => Sbfedelq1oelinecount06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update6Month AND Worst6 >= 2)));
Business: => Sbfedelq1oelinecount12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update12Month AND Worst12 >= 2)));
Business: => Sbfedelq1oelinecount24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update24Month AND Worst24 >= 2)));
Business: => Sbfedelq1oelinecount36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update36Month AND Worst36 >= 2)));
Business: => Sbfedelq1oelinecount60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update60Month AND Worst60 >= 2)));
Business: => Sbfedelq1oelinecount84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update84Month AND Worst84 >= 2)));
Business: => Sbfedelq1oelinecountever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeolinecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND WorstEver >= 2)));
															 
Business: => Sbfedelq1othercount := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenothercount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsOther), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsOther AND CurrentPaymentStatus >= 2)));
Business: => Sbfedelq1othercount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update3Month AND Worst3 >= 2)));
Business: => Sbfedelq1othercount06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update6Month AND Worst6 >= 2)));
Business: => Sbfedelq1othercount12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update12Month AND Worst12 >= 2)));
Business: => Sbfedelq1othercount24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update24Month AND Worst24 >= 2)));
Business: => Sbfedelq1othercount36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update36Month AND Worst36 >= 2)));
Business: => Sbfedelq1othercount60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update60Month AND Worst60 >= 2)));
Business: => Sbfedelq1othercount84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update84Month AND Worst84 >= 2)));
Business: => Sbfedelq1othercountever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeothercount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND WorstEver >= 2)));		
															 
Business: => Sbfedelq1leasecounteverttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeleasecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND WorstEver = 2)));		
Business: => Sbfedelq1loancounteverttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeloancount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND WorstEver = 2)));	
															 
Business: => Sbfedelqlettercounteverttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfelettercount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND WorstEver = 2)));	
									 
Business: => Sbfedelq1instcounteverttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsInstallment)) = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsInstallment), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsInstallment AND WorstEver = 2)));	
															 															 
															 
Business: => Sbfedelq1instcountever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsInstallment)) = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsInstallment), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsInstallment AND WorstEver >= 2)));		
															 
Business: => Sbfedelq1instcountttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOpen AND IsInstallment)) = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsInstallment), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsInstallment AND CurrentPaymentStatus = 2)));

			 
// Business: => Sbfedelq1installmentcountever := -999;

Business: => Sbfedelq1instcountttlchargeoff := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 NOT EXISTS(BusinessAccount.acc(IsInstallment AND (IsOpen OR IsChargeoff))) => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsInstallment AND IsOpen), CurrentPaymentStatus=UNKNOWN_DATA) AND NOT EXISTS(BusinessAccount.acc(IsInstallment AND IsChargeoff)) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsInstallment AND ((IsOpen AND CurrentPaymentStatus >= 2) OR IsChargeoff))));
															 
Business: => Sbfedelq1revcounteverttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsRevolvingAccount), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsRevolvingAccount AND WorstEver = 2)));	
															 
Business: => Sbfedelq1revcountever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsRevolvingAccount), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsRevolvingAccount AND WorstEver >= 2)));

Business: => Sbfedelq1revcountttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOpen AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsRevolvingAccount), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsRevolvingAccount AND CurrentPaymentStatus = 2)));
															 
Business: => Sbfedelq1revcountttlchargeoff := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 NOT EXISTS(BusinessAccount.acc(IsRevolvingAccount AND (IsOpen OR IsChargeoff))) => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsRevolvingAccount AND IsOpen), CurrentPaymentStatus=UNKNOWN_DATA) AND NOT EXISTS(BusinessAccount.acc(IsRevolvingAccount AND IsChargeoff)) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsRevolvingAccount AND ((IsOpen AND CurrentPaymentStatus >= 2) OR IsChargeoff))));
															 
Business: => Sbfedelq31countttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenallcount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND CurrentPaymentStatus = 3)));
															 
Business: => Sbfedelq31countttlchargeoff := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 NOT EXISTS(BusinessAccount.acc(IsOpen OR IsChargeoff)) => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen), CurrentPaymentStatus=UNKNOWN_DATA) AND NOT EXISTS(BusinessAccount.acc(IsChargeoff)) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc((IsOpen AND CurrentPaymentStatus >= 3)  OR IsChargeoff)));

Business: => Sbfedpd31count := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenallcount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND CurrentPaymentStatus >= 3)));
Business: => Sbfedelq31count03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update3Month AND Worst3 >= 3)));
Business: => Sbfedpd31count06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update6Month AND Worst6 >= 3)));
Business: => Sbfedpd31count12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update12Month AND Worst12 >= 3)));
Business: => Sbfedpd31count24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update24Month AND Worst24 >= 3)));
Business: => Sbfedpd31count36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update36Month AND Worst36 >= 3)));
Business: => Sbfedpd31count60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update60Month AND Worst60 >= 3)));
Business: => Sbfedpd31count84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update84Month AND Worst84 >= 3)));
Business: => Sbfedpd31countever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 ALL(BusinessAccount.acc, WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(WorstEver >= 3)));

Business: => Sbfedelq31counteverttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 ALL(BusinessAccount.acc, WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(WorstEver = 3)));


Business: => Sbfedpd31countloan := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenloancount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsLoan), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsLoan AND CurrentPaymentStatus >= 3)));
Business: => Sbfedelq31loancount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update3Month AND Worst3 >= 3)));
Business: => Sbfedpd31countloan06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update6Month AND Worst6 >= 3)));
Business: => Sbfedpd31countloan12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update12Month AND Worst12 >= 3)));
Business: => Sbfedpd31countloan24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update24Month AND Worst24 >= 3)));
Business: => Sbfedpd31countloan36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update36Month AND Worst36 >= 3)));
Business: => Sbfedpd31countloan60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update60Month AND Worst60 >= 3)));
Business: => Sbfedpd31countloan84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update84Month AND Worst84 >= 3)));
Business: => Sbfedpd31countloanever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeloancount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND WorstEver >= 3)));

Business: => Sbfedpd31countline := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenlinecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsLine), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsLine AND CurrentPaymentStatus >= 3)));
Business: => Sbfedelq31linecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update3Month AND Worst3 >= 3)));
Business: => Sbfedpd31countline06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update6Month AND Worst6 >= 3)));
Business: => Sbfedpd31countline12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update12Month AND Worst12 >= 3)));
Business: => Sbfedpd31countline24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update24Month AND Worst24 >= 3)));
Business: => Sbfedpd31countline36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update36Month AND Worst36 >= 3)));
Business: => Sbfedpd31countline60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update60Month AND Worst60 >= 3)));
Business: => Sbfedpd31countline84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update84Month AND Worst84 >= 3)));
Business: => Sbfedpd31countlineever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfelinecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND WorstEver >= 3)));

Business: => Sbfedpd31countcard := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopencardcount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsCard), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsCard AND CurrentPaymentStatus >= 3)));
Business: => Sbfedelq31cardcount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update3Month AND Worst3 >= 3)));
Business: => Sbfedpd31countcard06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update6Month AND Worst6 >= 3)));
Business: => Sbfedpd31countcard12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update12Month AND Worst12 >= 3)));
Business: => Sbfedpd31countcard24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update24Month AND Worst24 >= 3)));
Business: => Sbfedpd31countcard36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update36Month AND Worst36 >= 3)));
Business: => Sbfedpd31countcard60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update60Month AND Worst60 >= 3)));
Business: => Sbfedpd31countcard84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update84Month AND Worst84 >= 3)));
Business: => Sbfedpd31countcardever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfecardcount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND WorstEver >= 3)));

Business: => Sbfedpd31countlease := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenleasecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsLease), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsLease AND CurrentPaymentStatus >= 3)));
Business: => Sbfedelq31leasecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update3Month AND Worst3 >= 3)));
Business: => Sbfedpd31countlease06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update6Month AND Worst6 >= 3)));
Business: => Sbfedpd31countlease12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update12Month AND Worst12 >= 3)));
Business: => Sbfedpd31countlease24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update24Month AND Worst24 >= 3)));
Business: => Sbfedpd31countlease36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update36Month AND Worst36 >= 3)));
Business: => Sbfedpd31countlease60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update60Month AND Worst60 >= 3)));
Business: => Sbfedpd31countlease84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update84Month AND Worst84 >= 3)));
Business: => Sbfedpd31countleaseever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeleasecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND WorstEver >= 3)));

Business: => Sbfedpd31countletter := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenlettercount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsLetter), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsLetter AND CurrentPaymentStatus >= 3)));
Business: => Sbfedelq31lettercount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update3Month AND Worst3 >= 3)));
Business: => Sbfedpd31countletter06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update6Month AND Worst6 >= 3)));
Business: => Sbfedpd31countletter12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update12Month AND Worst12 >= 3)));
Business: => Sbfedpd31countletter24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update24Month AND Worst24 >= 3)));
Business: => Sbfedpd31countletter36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update36Month AND Worst36 >= 3)));
Business: => Sbfedpd31countletter60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update60Month AND Worst60 >= 3)));
Business: => Sbfedpd31countletter84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update84Month AND Worst84 >= 3)));
Business: => Sbfedpd31countletterever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfelettercount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND WorstEver >= 3)));

Business: => Sbfedpd31countoline := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenolinecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsOLine), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsOLine AND CurrentPaymentStatus >= 3)));
Business: => Sbfedelq31oelinecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update3Month AND Worst3 >= 3)));
Business: => Sbfedpd31countoline06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update6Month AND Worst6 >= 3)));
Business: => Sbfedpd31countoline12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update12Month AND Worst12 >= 3)));
Business: => Sbfedpd31countoline24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update24Month AND Worst24 >= 3)));
Business: => Sbfedpd31countoline36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update36Month AND Worst36 >= 3)));
Business: => Sbfedpd31countoline60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update60Month AND Worst60 >= 3)));
Business: => Sbfedpd31countoline84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update84Month AND Worst84 >= 3)));
Business: => Sbfedpd31countolineever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeolinecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND WorstEver >= 3)));

Business: => Sbfedpd31countother := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenothercount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsOther), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsOther AND CurrentPaymentStatus >= 3)));
Business: => Sbfedelq31othercount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update3Month AND Worst3 >= 3)));
Business: => Sbfedpd31countother06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update6Month AND Worst6 >= 3)));
Business: => Sbfedpd31countother12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update12Month AND Worst12 >= 3)));
Business: => Sbfedpd31countother24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update24Month AND Worst24 >= 3)));
Business: => Sbfedpd31countother36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update36Month AND Worst36 >= 3)));
Business: => Sbfedpd31countother60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update60Month AND Worst60 >= 3)));
Business: => Sbfedpd31countother84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update84Month AND Worst84 >= 3)));
Business: => Sbfedpd31countotherever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeothercount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND WorstEver >= 3)));															 

Business: => Sbfedelq31instcountttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOpen AND IsInstallment)) = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsInstallment), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsInstallment AND CurrentPaymentStatus = 3)));
Business: => Sbfedelq31instcountever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsInstallment)) = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsInstallment), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsInstallment AND WorstEver >= 3)));		
Business: => Sbfedelq31instcountttlchargeoff := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 NOT EXISTS(BusinessAccount.acc(IsInstallment AND (IsOpen OR IsChargeoff))) => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsInstallment AND IsOpen), CurrentPaymentStatus=UNKNOWN_DATA) AND NOT EXISTS(BusinessAccount.acc(IsInstallment AND IsChargeoff)) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsInstallment AND ((IsOpen AND CurrentPaymentStatus >= 3) OR IsChargeoff))));
Business: => Sbfedelq31revcounteverttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsRevolvingAccount), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsRevolvingAccount AND WorstEver = 3)));	
Business: => Sbfedelq31revcountever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsRevolvingAccount), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsRevolvingAccount AND WorstEver >= 3)));		
Business: => Sbfedelq31revcountttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOpen AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsRevolvingAccount), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsRevolvingAccount AND CurrentPaymentStatus = 3)));
															 
Business: => Sbfedelq31revcountttlchargeoff := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 NOT EXISTS(BusinessAccount.acc(IsRevolvingAccount AND (IsOpen OR IsChargeoff))) => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsRevolvingAccount AND IsOpen), CurrentPaymentStatus=UNKNOWN_DATA) AND NOT EXISTS(BusinessAccount.acc(IsRevolvingAccount AND IsChargeoff)) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsRevolvingAccount AND ((IsOpen AND CurrentPaymentStatus >= 3) OR IsChargeoff))));

Business: => Sbfedelq61countttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenallcount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND CurrentPaymentStatus = 4)));
															 
Business: => Sbfedelq61countttlchargeoff := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 NOT EXISTS(BusinessAccount.acc(IsOpen OR IsChargeoff)) => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen), CurrentPaymentStatus=UNKNOWN_DATA) AND NOT EXISTS(BusinessAccount.acc(IsChargeoff)) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc((IsOpen AND CurrentPaymentStatus >= 4) OR IsChargeoff)));

Business: => Sbfedelinquentcount := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenallcount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsDelinquent)));
Business: => Sbfedelq61count03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update3Month AND Worst3 >= 4)));
Business: => Sbfedelinquentcount06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update6Month AND Worst6 >= 4)));
Business: => Sbfedelinquentcount12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update12Month AND Worst12 >= 4)));
Business: => Sbfedelinquentcount24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update24Month AND Worst24 >= 4)));
Business: => Sbfedelinquentcount36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update36Month AND Worst36 >= 4)));
Business: => Sbfedelinquentcount60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update60Month AND Worst60 >= 4)));
Business: => Sbfedelinquentcount84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update84Month AND Worst84 >= 4)));
Business: => Sbfedelinquentcountever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 ALL(BusinessAccount.acc, WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(WorstEver >= 4)));

Business: => Sbfedelq61counteverttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 ALL(BusinessAccount.acc, WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(WorstEver = 4)));


Business: => Sbfedelinquentcountloan := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenloancount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsLoan), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsLoan AND IsDelinquent)));
Business: => Sbfedelq61loancount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update3Month AND Worst3 >= 4)));
Business: => Sbfedelinquentcountloan06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update6Month AND Worst6 >= 4)));
Business: => Sbfedelinquentcountloan12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update12Month AND Worst12 >= 4)));
Business: => Sbfedelinquentcountloan24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update24Month AND Worst24 >= 4)));
Business: => Sbfedelinquentcountloan36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update36Month AND Worst36 >= 4)));
Business: => Sbfedelinquentcountloan60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update60Month AND Worst60 >= 4)));
Business: => Sbfedelinquentcountloan84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update84Month AND Worst84 >= 4)));
Business: => Sbfedelinquentcountloanever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeloancount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND WorstEver >= 4)));

Business: => Sbfedelinquentcountline := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenlinecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsLine), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsLine AND IsDelinquent)));
Business: => Sbfedelq61linecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update3Month AND Worst3 >= 4)));
Business: => Sbfedelinquentcountline06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update6Month AND Worst6 >= 4)));
Business: => Sbfedelinquentcountline12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update12Month AND Worst12 >= 4)));
Business: => Sbfedelinquentcountline24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update24Month AND Worst24 >= 4)));
Business: => Sbfedelinquentcountline36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update36Month AND Worst36 >= 4)));
Business: => Sbfedelinquentcountline60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update60Month AND Worst60 >= 4)));
Business: => Sbfedelinquentcountline84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update84Month AND Worst84 >= 4)));
Business: => Sbfedelinquentcountlineever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfelinecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND WorstEver >= 4)));

Business: => Sbfedelinquentcountcard := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopencardcount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsCard), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsCard AND IsDelinquent)));
Business: => Sbfedelq61cardcount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update3Month AND Worst3 >= 4)));
Business: => Sbfedelinquentcountcard06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update6Month AND Worst6 >= 4)));
Business: => Sbfedelinquentcountcard12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update12Month AND Worst12 >= 4)));
Business: => Sbfedelinquentcountcard24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update24Month AND Worst24 >= 4)));
Business: => Sbfedelinquentcountcard36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update36Month AND Worst36 >= 4)));
Business: => Sbfedelinquentcountcard60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update60Month AND Worst60 >= 4)));
Business: => Sbfedelinquentcountcard84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update84Month AND Worst84 >= 4)));
Business: => Sbfedelinquentcountcardever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfecardcount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND WorstEver >= 4)));

Business: => Sbfedelinquentcountlease := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenleasecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsLease), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsLease AND IsDelinquent)));
Business: => Sbfedelq61leasecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update3Month AND Worst3 >= 4)));
Business: => Sbfedelinquentcountlease06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update6Month AND Worst6 >= 4)));
Business: => Sbfedelinquentcountlease12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update12Month AND Worst12 >= 4)));
Business: => Sbfedelinquentcountlease24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update24Month AND Worst24 >= 4)));
Business: => Sbfedelinquentcountlease36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update36Month AND Worst36 >= 4)));
Business: => Sbfedelinquentcountlease60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update60Month AND Worst60 >= 4)));
Business: => Sbfedelinquentcountlease84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update84Month AND Worst84 >= 4)));
Business: => Sbfedelinquentcountleaseever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeleasecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND WorstEver >= 4)));

Business: => Sbfedelinquentcountletter := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenlettercount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsLetter), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsLetter AND IsDelinquent)));
Business: => Sbfedelq61lettercount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update3Month AND Worst3 >= 4)));
Business: => Sbfedelinquentcountletter06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update6Month AND Worst6 >= 4)));
Business: => Sbfedelinquentcountletter12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update12Month AND Worst12 >= 4)));
Business: => Sbfedelinquentcountletter24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update24Month AND Worst24 >= 4)));
Business: => Sbfedelinquentcountletter36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update36Month AND Worst36 >= 4)));
Business: => Sbfedelinquentcountletter60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update60Month AND Worst60 >= 4)));
Business: => Sbfedelinquentcountletter84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update84Month AND Worst84 >= 4)));
Business: => Sbfedelinquentcountletterever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfelettercount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND WorstEver >= 4)));

Business: => Sbfedelinquentcountoline := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenolinecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsOLine), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsOLine AND IsDelinquent)));
Business: => Sbfedelq61oelinecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update3Month AND Worst3 >= 4)));
Business: => Sbfedelinquentcountoline06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update6Month AND Worst6 >= 4)));
Business: => Sbfedelinquentcountoline12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update12Month AND Worst12 >= 4)));
Business: => Sbfedelinquentcountoline24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update24Month AND Worst24 >= 4)));
Business: => Sbfedelinquentcountoline36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update36Month AND Worst36 >= 4)));
Business: => Sbfedelinquentcountoline60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update60Month AND Worst60 >= 4)));
Business: => Sbfedelinquentcountoline84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update84Month AND Worst84 >= 4)));
Business: => Sbfedelinquentcountolineever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeolinecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND WorstEver >= 4)));

Business: => Sbfedelinquentcountother := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenothercount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsOther), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsOther AND IsDelinquent)));
Business: => Sbfedelinquentcountother06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update6Month AND Worst6 >= 4)));
Business: => Sbfedelq61othercount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update3Month AND Worst3 >= 4)));
Business: => Sbfedelinquentcountother12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update12Month AND Worst12 >= 4)));
Business: => Sbfedelinquentcountother24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update24Month AND Worst24 >= 4)));
Business: => Sbfedelinquentcountother36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update36Month AND Worst36 >= 4)));
Business: => Sbfedelinquentcountother60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update60Month AND Worst60 >= 4)));
Business: => Sbfedelinquentcountother84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update84Month AND Worst84 >= 4)));
Business: => Sbfedelinquentcountotherever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeothercount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND WorstEver >= 4)));

Business: => Sbfedelq61instcountttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOpen AND IsInstallment)) = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsInstallment), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsInstallment AND CurrentPaymentStatus = 4)));
Business: => Sbfedelq61instcountever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsInstallment)) = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsInstallment), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsInstallment AND WorstEver >= 4)));	
Business: => Sbfedelq61instcountttlchargeoff := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 NOT EXISTS(BusinessAccount.acc(IsInstallment AND (IsOpen OR IsChargeoff))) => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsInstallment AND IsOpen), CurrentPaymentStatus=UNKNOWN_DATA) AND NOT EXISTS(BusinessAccount.acc(IsInstallment AND IsChargeoff)) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsInstallment AND ((IsOpen AND CurrentPaymentStatus >= 4) OR IsChargeoff))));
Business: => Sbfedelq61revcounteverttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsRevolvingAccount), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsRevolvingAccount AND WorstEver = 4)));	
Business: => Sbfedelq61revcountever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsRevolvingAccount), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsRevolvingAccount AND WorstEver >= 4)));	
Business: => Sbfedelq61revcountttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOpen AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsRevolvingAccount), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsRevolvingAccount AND CurrentPaymentStatus = 4)));
Business: => Sbfedelq61revcountttlchargeoff := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 NOT EXISTS(BusinessAccount.acc(IsRevolvingAccount AND (IsOpen OR IsChargeoff))) => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsRevolvingAccount AND IsOpen), CurrentPaymentStatus=UNKNOWN_DATA) AND NOT EXISTS(BusinessAccount.acc(IsRevolvingAccount AND IsChargeoff)) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsRevolvingAccount AND ((IsOpen AND CurrentPaymentStatus >= 4) OR IsChargeoff))));
															 
Business: => Sbfedelq91countttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenallcount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND CurrentPaymentStatus = 5)));
Business: => Sbfedelq91countttlchargeoff := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 NOT EXISTS(BusinessAccount.acc(IsOpen OR IsChargeoff)) => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen), CurrentPaymentStatus=UNKNOWN_DATA) AND NOT EXISTS(BusinessAccount.acc(IsChargeoff)) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc((IsOpen AND CurrentPaymentStatus >= 5) OR IsChargeoff)));

Business: => Sbfedpd91count := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenallcount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND CurrentPaymentStatus >= 5)));
Business: => Sbfedelq91count03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update3Month AND Worst3 >= 5)));
Business: => Sbfedpd91count06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update6Month AND Worst6 >= 5)));
Business: => Sbfedpd91count12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update12Month AND Worst12 >= 5)));
Business: => Sbfedpd91count24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update24Month AND Worst24 >= 5)));
Business: => Sbfedpd91count36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update36Month AND Worst36 >= 5)));
Business: => Sbfedpd91count60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update60Month AND Worst60 >= 5)));
Business: => Sbfedpd91count84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update84Month AND Worst84 >= 5)));
Business: => Sbfedpd91countever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 ALL(BusinessAccount.acc, WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(WorstEver >= 5)));

Business: => Sbfedpd91countloan := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenloancount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsLoan), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsLoan AND CurrentPaymentStatus >= 5)));
Business: => Sbfedelq91loancount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update3Month AND Worst3 >= 5)));
Business: => Sbfedpd91countloan06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update6Month AND Worst6 >= 5)));
Business: => Sbfedpd91countloan12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update12Month AND Worst12 >= 5)));
Business: => Sbfedpd91countloan24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update24Month AND Worst24 >= 5)));
Business: => Sbfedpd91countloan36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update36Month AND Worst36 >= 5)));
Business: => Sbfedpd91countloan60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update60Month AND Worst60 >= 5)));
Business: => Sbfedpd91countloan84 :=MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update84Month AND Worst84 >= 5)));
Business: => Sbfedpd91countloanever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeloancount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND WorstEver >= 5)));

Business: => Sbfedpd91countline := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenlinecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsLine), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsLine AND CurrentPaymentStatus >= 5)));
Business: => Sbfedelq91linecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update3Month AND Worst3 >= 5)));
Business: => Sbfedpd91countline06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update6Month AND Worst6 >= 5)));
Business: => Sbfedpd91countline12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update12Month AND Worst12 >= 5)));
Business: => Sbfedpd91countline24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update24Month AND Worst24 >= 5)));
Business: => Sbfedpd91countline36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update36Month AND Worst36 >= 5)));
Business: => Sbfedpd91countline60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update60Month AND Worst60 >= 5)));
Business: => Sbfedpd91countline84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update84Month AND Worst84 >= 5)));
Business: => Sbfedpd91countlineever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfelinecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND WorstEver >= 5)));

Business: => Sbfedpd91countcard := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopencardcount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsCard), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsCard AND CurrentPaymentStatus >= 5)));
Business: => Sbfedelq91cardcount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update3Month AND Worst3 >= 5)));
Business: => Sbfedpd91countcard06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update6Month AND Worst6 >= 5)));
Business: => Sbfedpd91countcard12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update12Month AND Worst12 >= 5)));
Business: => Sbfedpd91countcard24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update24Month AND Worst24 >= 5)));
Business: => Sbfedpd91countcard36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update36Month AND Worst36 >= 5)));
Business: => Sbfedpd91countcard60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update60Month AND Worst60 >= 5)));
Business: => Sbfedpd91countcard84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update84Month AND Worst84 >= 5)));
Business: => Sbfedpd91countcardever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfecardcount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND WorstEver >= 5)));

Business: => Sbfedpd91countlease := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenleasecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsLease), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsLease AND CurrentPaymentStatus >= 5)));
Business: => Sbfedelq91leasecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update3Month AND Worst3 >= 5)));
Business: => Sbfedpd91countlease06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update6Month AND Worst6 >= 5)));
Business: => Sbfedpd91countlease12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update12Month AND Worst12 >= 5)));
Business: => Sbfedpd91countlease24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update24Month AND Worst24 >= 5)));
Business: => Sbfedpd91countlease36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update36Month AND Worst36 >= 5)));
Business: => Sbfedpd91countlease60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update60Month AND Worst60 >= 5)));
Business: => Sbfedpd91countlease84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update84Month AND Worst84 >= 5)));
Business: => Sbfedpd91countleaseever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeleasecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND WorstEver >= 5)));

Business: => Sbfedpd91countletter := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenlettercount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsLetter), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsLetter AND CurrentPaymentStatus >= 5)));
Business: => Sbfedelq91lettercount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update3Month AND Worst3 >= 5)));
Business: => Sbfedpd91countletter06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update6Month AND Worst6 >= 5)));
Business: => Sbfedpd91countletter12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update12Month AND Worst12 >= 5)));
Business: => Sbfedpd91countletter24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update24Month AND Worst24 >= 5)));
Business: => Sbfedpd91countletter36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update36Month AND Worst36 >= 5)));
Business: => Sbfedpd91countletter60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update60Month AND Worst60 >= 5)));
Business: => Sbfedpd91countletter84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update84Month AND Worst84 >= 5)));
Business: => Sbfedpd91countletterever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfelettercount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND WorstEver >= 5)));

Business: => Sbfedpd91countoline := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenolinecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsOLine), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsOLine AND CurrentPaymentStatus >= 5)));
Business: => Sbfedelq91oelinecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update3Month AND Worst3 >= 5)));
Business: => Sbfedpd91countoline06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update6Month AND Worst6 >= 5)));
Business: => Sbfedpd91countoline12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update12Month AND Worst12 >= 5)));
Business: => Sbfedpd91countoline24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update24Month AND Worst24 >= 5)));
Business: => Sbfedpd91countoline36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update36Month AND Worst36 >= 5)));
Business: => Sbfedpd91countoline60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update60Month AND Worst60 >= 5)));
Business: => Sbfedpd91countoline84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update84Month AND Worst84 >= 5)));
Business: => Sbfedpd91countolineever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeolinecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND WorstEver >= 5)));

Business: => Sbfedpd91countother := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenothercount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsOther), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsOther AND CurrentPaymentStatus >= 5)));
Business: => Sbfedelq91othercount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update3Month AND Worst3 >= 5)));
Business: => Sbfedpd91countother06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update6Month AND Worst6 >= 5)));
Business: => Sbfedpd91countother12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update12Month AND Worst12 >= 5)));
Business: => Sbfedpd91countother24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update24Month AND Worst24 >= 5)));
Business: => Sbfedpd91countother36	:= MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update36Month AND Worst36 >= 5)));
Business: => Sbfedpd91countother60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update60Month AND Worst60 >= 5)));
Business: => Sbfedpd91countother84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update84Month AND Worst84 >= 5)));
Business: => Sbfedpd91countotherever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeothercount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND WorstEver >= 5)));

Business: => Sbfedelq91instcountttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOpen AND IsInstallment)) = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsInstallment), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsInstallment AND CurrentPaymentStatus = 5)));
Business: => Sbfedelq91instcountever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsInstallment)) = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsInstallment), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsInstallment AND WorstEver >= 5)));	
Business: => Sbfedelq91instcountttlchargeoff := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 NOT EXISTS(BusinessAccount.acc(IsInstallment AND (IsOpen OR IsChargeoff))) => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsInstallment AND IsOpen), CurrentPaymentStatus=UNKNOWN_DATA) AND NOT EXISTS(BusinessAccount.acc(IsInstallment AND IsChargeoff)) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsInstallment AND ((IsOpen AND CurrentPaymentStatus >= 5) OR IsChargeoff))));
Business: => Sbfedelq91revcounteverttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsRevolvingAccount), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsRevolvingAccount AND WorstEver = 5)));	
Business: => Sbfedelq91revcountever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsRevolvingAccount), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsRevolvingAccount AND WorstEver >= 5)));	
Business: => Sbfedelq91revcountttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOpen AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsRevolvingAccount), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsRevolvingAccount AND CurrentPaymentStatus = 5)));
Business: => Sbfedelq91revcountttlchargeoff := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 NOT EXISTS(BusinessAccount.acc(IsRevolvingAccount AND (IsOpen OR IsChargeoff))) => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsRevolvingAccount AND IsOpen), CurrentPaymentStatus=UNKNOWN_DATA) AND NOT EXISTS(BusinessAccount.acc(IsRevolvingAccount AND IsChargeoff)) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsRevolvingAccount AND ((IsOpen AND CurrentPaymentStatus >= 5) OR IsChargeoff))));
															 
Business: => Sbfedelq121countttlchargeoff := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 NOT EXISTS(BusinessAccount.acc(IsOpen OR IsChargeoff)) => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen), CurrentPaymentStatus=UNKNOWN_DATA) AND NOT EXISTS(BusinessAccount.acc(IsChargeoff)) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc((IsOpen AND CurrentPaymentStatus >= 6) OR IsChargeoff)));

Business: => Sbfedpd121count := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenallcount = 0 => NO_DATA_AVAILABLE, //-98 if all stale or closed accounts
															 ALL(BusinessAccount.acc(IsOpen), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND CurrentPaymentStatus >= 6)));
Business: => Sbfedelq121count03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update3Month AND Worst3 >= 6)));
Business: => Sbfedpd121count06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update6Month AND Worst6 >= 6)));
Business: => Sbfedpd121count12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update12Month AND Worst12 >= 6)));
Business: => Sbfedpd121count24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update24Month AND Worst24 >= 6)));
Business: => Sbfedpd121count36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update36Month AND Worst36 >= 6)));
Business: => Sbfedpd121count60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update60Month AND Worst60 >= 6)));
Business: => Sbfedpd121count84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(Update84Month AND Worst84 >= 6)));
Business: => Sbfedpd121countever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 ALL(BusinessAccount.acc, WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(WorstEver >= 6)));
															 
Business: => Sbfedpd121countloan := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenloancount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsLoan), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsLoan AND CurrentPaymentStatus >= 6)));
Business: => Sbfedelq121loancount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update3Month AND Worst3 >= 6)));
Business: => Sbfedpd121countloan06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update6Month AND Worst6 >= 6)));
Business: => Sbfedpd121countloan12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update12Month AND Worst12 >= 6)));
Business: => Sbfedpd121countloan24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update24Month AND Worst24 >= 6)));
Business: => Sbfedpd121countloan36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update36Month AND Worst36 >= 6)));
Business: => Sbfedpd121countloan60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update60Month AND Worst60 >= 6)));
Business: => Sbfedpd121countloan84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLoan AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND Update84Month AND Worst84 >= 6)));
Business: => Sbfedpd121countloanever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeloancount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLoan), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLoan AND WorstEver >= 6)));

Business: => Sbfedpd121countline := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenlinecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsLine), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsLine AND CurrentPaymentStatus >= 6)));
Business: => Sbfedelq121linecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update3Month AND Worst3 >= 6)));
Business: => Sbfedpd121countline06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update6Month AND Worst6 >= 6)));
Business: => Sbfedpd121countline12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update12Month AND Worst12 >= 6)));
Business: => Sbfedpd121countline24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update24Month AND Worst24 >= 6)));
Business: => Sbfedpd121countline36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update36Month AND Worst36 >= 6)));
Business: => Sbfedpd121countline60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update60Month AND Worst60 >= 6)));
Business: => Sbfedpd121countline84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLine AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND Update84Month AND Worst84 >= 6)));
Business: => Sbfedpd121countlineever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfelinecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLine), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLine AND WorstEver >= 6)));

Business: => Sbfedpd121countcard := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopencardcount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsCard), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsCard AND CurrentPaymentStatus >= 6)));
Business: => Sbfedelq121cardcount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update3Month AND Worst3 >= 6)));
Business: => Sbfedpd121countcard06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update6Month AND Worst6 >= 6)));
Business: => Sbfedpd121countcard12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update12Month AND Worst12 >= 6)));
Business: => Sbfedpd121countcard24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update24Month AND Worst24 >= 6)));
Business: => Sbfedpd121countcard36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update36Month AND Worst36 >= 6)));
Business: => Sbfedpd121countcard60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update60Month AND Worst60 >= 6)));
Business: => Sbfedpd121countcard84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsCard AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND Update84Month AND Worst84 >= 6)));
Business: => Sbfedpd121countcardever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfecardcount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsCard), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsCard AND WorstEver >= 6)));

Business: => Sbfedpd121countlease := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenleasecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsLease), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsLease AND CurrentPaymentStatus >= 6)));
Business: => Sbfedelq121leasecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update3Month AND Worst3 >= 6)));
Business: => Sbfedpd121countlease06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update6Month AND Worst6 >= 6)));
Business: => Sbfedpd121countlease12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update12Month AND Worst12 >= 6)));
Business: => Sbfedpd121countlease24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update24Month AND Worst24 >= 6)));
Business: => Sbfedpd121countlease36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update36Month AND Worst36 >= 6)));
Business: => Sbfedpd121countlease60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update60Month AND Worst60 >= 6)));
Business: => Sbfedpd121countlease84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLease AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND Update84Month AND Worst84 >= 6)));
Business: => Sbfedpd121countleaseever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeleasecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLease), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLease AND WorstEver >= 6)));

Business: => Sbfedpd121countletter := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenlettercount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsLetter), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsLetter AND CurrentPaymentStatus >= 6)));
Business: => Sbfedelq121lettercount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update3Month AND Worst3 >= 6)));
Business: => Sbfedpd121countletter06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update6Month AND Worst6 >= 6)));
Business: => Sbfedpd121countletter12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update12Month AND Worst12 >= 6)));
Business: => Sbfedpd121countletter24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update24Month AND Worst24 >= 6)));
Business: => Sbfedpd121countletter36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update36Month AND Worst36 >= 6)));
Business: => Sbfedpd121countletter60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update60Month AND Worst60 >= 6)));
Business: => Sbfedpd121countletter84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsLetter AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND Update84Month AND Worst84 >= 6)));
Business: => Sbfedpd121countletterever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfelettercount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsLetter), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsLetter AND WorstEver >= 6)));

Business: => Sbfedpd121countoline := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenolinecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsOLine), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsOLine AND CurrentPaymentStatus >= 6)));
Business: => Sbfedelq121oelinecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update3Month AND Worst3 >= 6)));
Business: => Sbfedpd121countoline06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update6Month AND Worst6 >= 6)));
Business: => Sbfedpd121countoline12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update12Month AND Worst12 >= 6)));
Business: => Sbfedpd121countoline24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update24Month AND Worst24 >= 6)));
Business: => Sbfedpd121countoline36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update36Month AND Worst36 >= 6)));
Business: => Sbfedpd121countoline60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update60Month AND Worst60 >= 6)));
Business: => Sbfedpd121countoline84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOLine AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND Update84Month AND Worst84 >= 6)));
Business: => Sbfedpd121countolineever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeolinecount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOLine), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOLine AND WorstEver >= 6)));

Business: => Sbfedpd121countother := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenothercount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen AND IsOther), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND IsOther AND CurrentPaymentStatus >= 6)));
Business: => Sbfedelq121othercount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update3Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update3Month), Worst3 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update3Month AND Worst3 >= 6)));
Business: => Sbfedpd121countother06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update6Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update6Month), Worst6 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update6Month AND Worst6 >= 6)));
Business: => Sbfedpd121countother12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update12Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update12Month), Worst12 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update12Month AND Worst12 >= 6)));
Business: => Sbfedpd121countother24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update24Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update24Month), Worst24 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update24Month AND Worst24 >= 6)));
Business: => Sbfedpd121countother36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update36Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update36Month), Worst36 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update36Month AND Worst36 >= 6)));
Business: => Sbfedpd121countother60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update60Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update60Month), Worst60 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update60Month AND Worst60 >= 6)));
Business: => Sbfedpd121countother84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsOther AND Update84Month))=0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther AND Update84Month), Worst84 = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND Update84Month AND Worst84 >= 6)));
Business: => Sbfedpd121countotherever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeothercount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOther), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOther AND WorstEver >= 6)));			
															 
Business: => Sbfedelq121instcountever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsInstallment)) = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsInstallment), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsInstallment AND WorstEver >= 6)));	
Business: => Sbfedelq121instcountttlchargeoff := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 NOT EXISTS(BusinessAccount.acc(IsInstallment AND (IsOpen OR IsChargeoff))) => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsInstallment AND IsOpen), CurrentPaymentStatus=UNKNOWN_DATA) AND NOT EXISTS(BusinessAccount.acc(IsInstallment AND IsChargeoff)) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsInstallment AND ((IsOpen AND CurrentPaymentStatus >= 6) OR IsChargeoff))));
Business: => Sbfedelq121revcountever := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 COUNT(BusinessAccount.acc(IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsRevolvingAccount), WorstEver = UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsRevolvingAccount AND WorstEver >= 6)));	
Business: => Sbfedelq121revcountttlchargeoff := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 NOT EXISTS(BusinessAccount.acc(IsRevolvingAccount AND (IsOpen OR IsChargeoff))) => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsRevolvingAccount AND IsOpen), CurrentPaymentStatus=UNKNOWN_DATA) AND NOT EXISTS(BusinessAccount.acc(IsRevolvingAccount AND IsChargeoff)) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsRevolvingAccount AND ((IsOpen AND CurrentPaymentStatus >= 6) OR IsChargeoff))));													 
															 
															 
Business: => Sbfedelinquent31ratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenallcount=0 OR Sbfedpd31count=0 => NO_DATA_AVAILABLE,
																	Sbfedpd31count=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenallcount - Sbfedpd31count)/Sbfedpd31count));
Business: => Sbfedelinquent31loanratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenloancount=0 OR Sbfedpd31countloan=0 => NO_DATA_AVAILABLE,
																	Sbfedpd31countloan=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenloancount - Sbfedpd31countloan)/Sbfedpd31countloan));
Business: => Sbfedelinquent31lineratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenlinecount=0 OR Sbfedpd31countline=0 => NO_DATA_AVAILABLE,
																	Sbfedpd31countline=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenlinecount - Sbfedpd31countline)/Sbfedpd31countline));
Business: => Sbfedelinquent31cardratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopencardcount=0 OR Sbfedpd31countcard=0 => NO_DATA_AVAILABLE,
																	Sbfedpd31countcard=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopencardcount - Sbfedpd31countcard)/Sbfedpd31countcard));
Business: => Sbfedelinquent31leaseratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenleasecount=0 OR Sbfedpd31countlease=0 => NO_DATA_AVAILABLE,
																	Sbfedpd31countlease=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenleasecount - Sbfedpd31countlease)/Sbfedpd31countlease));
Business: => Sbfedelinquent31letterratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenlettercount=0 OR Sbfedpd31countletter=0 => NO_DATA_AVAILABLE,
																	Sbfedpd31countletter=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenlettercount - Sbfedpd31countletter)/Sbfedpd31countletter));
Business: => Sbfedelinquent31olineratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenolinecount=0 OR Sbfedpd31countoline=0 => NO_DATA_AVAILABLE,
																	Sbfedpd31countoline=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenolinecount - Sbfedpd31countoline)/Sbfedpd31countoline));
Business: => Sbfedelinquent31otherratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenothercount=0 OR Sbfedpd31countother=0 => NO_DATA_AVAILABLE,
																	Sbfedpd31countother=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenothercount - Sbfedpd31countother)/Sbfedpd31countother));

Business: => Sbfedelinquent61ratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenallcount=0 OR Sbfedelinquentcount=0 => NO_DATA_AVAILABLE,
																	Sbfedelinquentcount=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenallcount - Sbfedelinquentcount)/Sbfedelinquentcount));
Business: => Sbfedelinquent61loanratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenloancount=0 OR Sbfedelinquentcountloan=0 => NO_DATA_AVAILABLE,
																	Sbfedelinquentcountloan=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenloancount - Sbfedelinquentcountloan)/Sbfedelinquentcountloan));
Business: => Sbfedelinquent61lineratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenlinecount=0 OR Sbfedelinquentcountline=0 => NO_DATA_AVAILABLE,
																	Sbfedelinquentcountline=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenlinecount - Sbfedelinquentcountline)/Sbfedelinquentcountline));
Business: => Sbfedelinquent61cardratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopencardcount=0 OR Sbfedelinquentcountcard=0 => NO_DATA_AVAILABLE,
																	Sbfedelinquentcountcard=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopencardcount - Sbfedelinquentcountcard)/Sbfedelinquentcountcard));
Business: => Sbfedelinquent61leaseratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenleasecount=0 OR Sbfedelinquentcountlease=0 => NO_DATA_AVAILABLE,
																	Sbfedelinquentcountlease=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenleasecount - Sbfedelinquentcountlease)/Sbfedelinquentcountlease));
Business: => Sbfedelinquent61letterratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenlettercount=0 OR Sbfedelinquentcountletter=0 => NO_DATA_AVAILABLE,
																	Sbfedelinquentcountletter=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenlettercount - Sbfedelinquentcountletter)/Sbfedelinquentcountletter));
Business: => Sbfedelinquent61olineratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenolinecount=0 OR Sbfedelinquentcountoline=0 => NO_DATA_AVAILABLE,
																	Sbfedelinquentcountoline=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenolinecount - Sbfedelinquentcountoline)/Sbfedelinquentcountoline));
Business: => Sbfedelinquent61otherratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenothercount=0 OR Sbfedelinquentcountother=0 => NO_DATA_AVAILABLE,
																	Sbfedelinquentcountother=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenothercount - Sbfedelinquentcountother)/Sbfedelinquentcountother));

Business: => Sbfedelinquent91ratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenallcount=0 OR Sbfedpd91count=0 => NO_DATA_AVAILABLE,
																	Sbfedpd91count=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenallcount - Sbfedpd91count)/Sbfedpd91count));
Business: => Sbfedelinquent91loanratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenloancount=0 OR Sbfedpd91countloan=0 => NO_DATA_AVAILABLE,
																	Sbfedpd91countloan=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenloancount - Sbfedpd91countloan)/Sbfedpd91countloan));
Business: => Sbfedelinquent91lineratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenlinecount=0 OR Sbfedpd91countline=0 => NO_DATA_AVAILABLE,
																	Sbfedpd91countline=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenlinecount - Sbfedpd91countline)/Sbfedpd91countline));
Business: => Sbfedelinquent91cardratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopencardcount=0 OR Sbfedpd91countcard=0 => NO_DATA_AVAILABLE,
																	Sbfedpd91countcard=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopencardcount - Sbfedpd91countcard)/Sbfedpd91countcard));
Business: => Sbfedelinquent91leaseratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenleasecount=0 OR Sbfedpd91countlease=0 => NO_DATA_AVAILABLE,
																	Sbfedpd91countlease=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenleasecount - Sbfedpd91countlease)/Sbfedpd91countlease));
Business: => Sbfedelinquent91letterratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenlettercount=0 OR Sbfedpd91countletter=0 => NO_DATA_AVAILABLE,
																	Sbfedpd91countletter=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenlettercount - Sbfedpd91countletter)/Sbfedpd91countletter));
Business: => Sbfedelinquent91olineratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenolinecount=0 OR Sbfedpd91countoline=0 => NO_DATA_AVAILABLE,
																	Sbfedpd91countoline=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenolinecount - Sbfedpd91countoline)/Sbfedpd91countoline));
Business: => Sbfedelinquent91otherratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenothercount=0 OR Sbfedpd91countother=0 => NO_DATA_AVAILABLE,
																	Sbfedpd91countother=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenothercount - Sbfedpd91countother)/Sbfedpd91countother));

Business: => Sbfedelinquent121ratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenallcount=0 OR Sbfedpd121count=0 => NO_DATA_AVAILABLE,
																	Sbfedpd121count=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenallcount - Sbfedpd121count)/Sbfedpd121count));
Business: => Sbfedelinquent121loanratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenloancount=0 OR Sbfedpd121countloan=0 => NO_DATA_AVAILABLE,
																	Sbfedpd121countloan=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenloancount - Sbfedpd121countloan)/Sbfedpd121countloan));
Business: => Sbfedelinquent121lineratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenlinecount=0 OR Sbfedpd121countline=0 => NO_DATA_AVAILABLE,
																	Sbfedpd121countline=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenlinecount - Sbfedpd121countline)/Sbfedpd121countline));
Business: => Sbfedelinquent121cardratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopencardcount=0 OR Sbfedpd121countcard=0 => NO_DATA_AVAILABLE,
																	Sbfedpd121countcard=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopencardcount - Sbfedpd121countcard)/Sbfedpd121countcard));
Business: => Sbfedelinquent121leaseratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenleasecount=0 OR Sbfedpd121countlease=0 => NO_DATA_AVAILABLE,
																	Sbfedpd121countlease=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenleasecount - Sbfedpd121countlease)/Sbfedpd121countlease));
Business: => Sbfedelinquent121letterratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenlettercount=0 OR Sbfedpd121countletter=0 => NO_DATA_AVAILABLE,
																	Sbfedpd121countletter=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenlettercount - Sbfedpd121countletter)/Sbfedpd121countletter));
Business: => Sbfedelinquent121olineratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenolinecount=0 OR Sbfedpd121countoline=0 => NO_DATA_AVAILABLE,
																	Sbfedpd121countoline=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenolinecount - Sbfedpd121countoline)/Sbfedpd121countoline));
Business: => Sbfedelinquent121otherratio := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	Sbfeopenothercount=0 OR Sbfedpd121countother=0 => NO_DATA_AVAILABLE,
																	Sbfedpd121countother=UNKNOWN_DATA => UNKNOWN_DATA,
																	ROUND((Sbfeopenothercount - Sbfedpd121countother)/Sbfedpd121countother));															 

Business: => Sbfedpdamount := MAP(BusinessNotOnFile => NOT_ON_FILE,
															COUNT(BusinessAccount.acc(IsOpen))=0 => NO_DATA_AVAILABLE,
															ALL(BusinessAccount.acc(IsOpen), CurrentPDAmount:Null) => UNKNOWN_DATA,
															SUM(BusinessAccount.acc(IsOpen), CurrentPDAmount));

Business: => Sbfedpdamountloan := MAP(BusinessNotOnFile => NOT_ON_FILE,
															COUNT(BusinessAccount.acc(IsOpen AND IsLoan))=0 => NO_DATA_AVAILABLE,
															ALL(BusinessAccount.acc(IsOpen AND IsLoan), CurrentPDAmount:Null) => UNKNOWN_DATA,
															SUM(BusinessAccount.acc(IsOpen AND IsLoan), CurrentPDAmount));
Business: => Sbfedpdamountline := MAP(BusinessNotOnFile => NOT_ON_FILE,
															COUNT(BusinessAccount.acc(IsOpen AND IsLine))=0 => NO_DATA_AVAILABLE,
															ALL(BusinessAccount.acc(IsOpen AND IsLine), CurrentPDAmount:Null) => UNKNOWN_DATA,
															SUM(BusinessAccount.acc(IsOpen AND IsLine), CurrentPDAmount));
Business: => Sbfedpdamountcard := MAP(BusinessNotOnFile => NOT_ON_FILE,
															COUNT(BusinessAccount.acc(IsOpen AND IsCard))=0 => NO_DATA_AVAILABLE,
															ALL(BusinessAccount.acc(IsOpen AND IsCard), CurrentPDAmount:Null) => UNKNOWN_DATA,
															SUM(BusinessAccount.acc(IsOpen AND IsCard), CurrentPDAmount));
Business: => Sbfedpdamountlease := MAP(BusinessNotOnFile => NOT_ON_FILE,
															COUNT(BusinessAccount.acc(IsOpen AND IsLease))=0 => NO_DATA_AVAILABLE,
															ALL(BusinessAccount.acc(IsOpen AND IsLease), CurrentPDAmount:Null) => UNKNOWN_DATA,
															SUM(BusinessAccount.acc(IsOpen AND IsLease), CurrentPDAmount));
Business: => Sbfedpdamountletter := MAP(BusinessNotOnFile => NOT_ON_FILE,
															COUNT(BusinessAccount.acc(IsOpen AND IsLetter))=0 => NO_DATA_AVAILABLE,
															ALL(BusinessAccount.acc(IsOpen AND IsLetter), CurrentPDAmount:Null) => UNKNOWN_DATA,
															SUM(BusinessAccount.acc(IsOpen AND IsLetter), CurrentPDAmount));
Business: => Sbfedpdamountoline := MAP(BusinessNotOnFile => NOT_ON_FILE,
															COUNT(BusinessAccount.acc(IsOpen AND IsOLine))=0 => NO_DATA_AVAILABLE,
															ALL(BusinessAccount.acc(IsOpen AND IsOLine), CurrentPDAmount:Null) => UNKNOWN_DATA,
															SUM(BusinessAccount.acc(IsOpen AND IsOLine), CurrentPDAmount));
Business: => Sbfedpdamountother := MAP(BusinessNotOnFile => NOT_ON_FILE,
															COUNT(BusinessAccount.acc(IsOpen AND IsOther))=0 => NO_DATA_AVAILABLE,
															ALL(BusinessAccount.acc(IsOpen AND IsOther), CurrentPDAmount:Null) => UNKNOWN_DATA,
															SUM(BusinessAccount.acc(IsOpen AND IsOther), CurrentPDAmount));

Business: => Sbfechargeoffcount := IF(BusinessNotOnFile, NOT_ON_FILE, COUNT(BusinessAccount.acc(IsChargeoff)));

Account: => MostRecentChargeoffAmountDate := MAX(AccountTradeline.trade(amount_charged_off_by_creditor > 0 AND NOT date_account_was_charged_off > CURRENTDATE()), load_date);
Account: => ChargeoffAmount := ONLY(AccountTradeline.trade(load_date = Account.MostRecentChargeoffAmountDate), amount_charged_off_by_creditor);


Business: => Sbfechargeoffamount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																		Sbfechargeoffcount = 0 => NO_DATA_AVAILABLE,
																		ALL(BusinessAccount.acc(IsChargeoff), ChargeoffAmount:Null) => UNKNOWN_DATA,
																		SUM(BusinessAccount.acc(IsChargeoff), ChargeoffAmount));

Account: => MostRecentChargeoffDate := MAX(AccountTradeline.trade(NOT date_account_was_charged_off:Null AND date_account_was_charged_off <= CURRENTDATE()), load_date);
Account: => ChargeoffDate := ONLY(AccountTradeline.trade(load_date = Account.MostRecentChargeoffDate), date_account_was_charged_off);

Business: => ChargeoffDateLastSeen := MAX(BusinessAccount.acc(IsChargeoff), ChargeoffDate);
Business: => Sbfechargeoffdatelastseen := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfechargeoffcount=0 => NO_DATA_AVAILABLE,
																					ALL(BusinessAccount.acc(IsChargeoff), ChargeoffDate:Null) => 0,
																					INTEGERFROMDATE(ChargeoffDateLastSeen));
Business: => Sbfetimenewestchargeoff := MAP(BusinessNotOnFile => NOT_ON_FILE,
																					Sbfechargeoffcount=0 => NO_DATA_AVAILABLE,
																					Sbfechargeoffdatelastseen=0 => UNKNOWN_DATA,
																					MONTHSBETWEEN(ChargeoffDateLastSeen, CURRENTDATE()) + 1);

Business: => Sbfecurrentcount := MAP(BusinessNotOnFile => NOT_ON_FILE,
															 Sbfeopenallcount = 0 => NO_DATA_AVAILABLE,
															 ALL(BusinessAccount.acc(IsOpen), CurrentPaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
															 COUNT(BusinessAccount.acc(IsOpen AND CurrentPaymentStatus=0)));
Business: => Sbfedelq1occurcount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=2)));
Business: => Sbfedpd1occurcount06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=2)));	//is this right?
																																																																						//count of tradelines with paymentstatus exactly equal to 2 in past 6 months?
Business: => Sbfedpd1occurcount12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=2)));
Business: => Sbfedpd1occurcount24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=2)));
Business: => Sbfedpd1occurcount36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=2)));
Business: => Sbfedpd1occurcount60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=2)));
Business: => Sbfedpd1occurcount84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=2)));
Business: => Sbfedpd1occurcountever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=2)));

Business: => Sbfedelq31occurcount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcount06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcount12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcount24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcount36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcount60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcount84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is84Month AND NOT AccountClosed))  => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=3)));
																 
Business: => Sbfedelq31occurloancount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountloan06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountloan12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountloan24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountloan36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountloan60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountloan84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountloanever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=3)));

Business: => Sbfedelq31occurlinecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountline06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountline12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountline24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountline36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountline60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountline84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountlineever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=3)));

Business: => Sbfedelq31occurcardcount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountcard06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountcard12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountcard24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountcard36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountcard60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountcard84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountcardever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=3)));

Business: => Sbfedelq31occurleasecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountlease06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountlease12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountlease24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountlease36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountlease60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountlease84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountleaseever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=3)));

Business: => Sbfedelq31occurlettercount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountletter06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountletter12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountletter24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountletter36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountletter60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountletter84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountletterever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=3)));

Business: => Sbfedelq31occuroelinecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountoline06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountoline12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountoline24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountoline36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountoline60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountoline84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountolineever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=3)));

Business: => Sbfedelq31occurothercount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountother06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountother12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountother24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountother36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountother60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountother84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=3)));
Business: => Sbfedpd31occurcountotherever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=3)));
																 

Business: => Sbfedelq61occurcount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcount06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcount12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcount24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcount36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcount60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcount84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=4)));

Business: => Sbfedelq61occurloancount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountloan06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountloan12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountloan24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountloan36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountloan60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountloan84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountloanever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=4)));

Business: => Sbfedelq61occurlinecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountline06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountline12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountline24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountline36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountline60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountline84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountlineever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=4)));

Business: => Sbfedelq61occurcardcount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountcard06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountcard12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountcard24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountcard36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountcard60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountcard84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountcardever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=4)));

Business: => Sbfedelq61occurleasecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountlease06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountlease12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountlease24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountlease36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountlease60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountlease84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountleaseever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=4)));

Business: => Sbfedelq61occurlettercount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountletter06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountletter12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountletter24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountletter36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountletter60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountletter84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountletterever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=4)));

Business: => Sbfedelq61occuroelinecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountoline06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountoline12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountoline24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountoline36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountoline60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountoline84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountolineever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=4)));

Business: => Sbfedelq61occurothercount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountother06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountother12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountother24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountother36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountother60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountother84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=4)));
Business: => Sbfedpd61occurcountotherever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=4)));

Business: => Sbfedelq91occurcount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcount06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcount12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcount24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcount36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcount60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcount84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=5)));

Business: => Sbfedelq91occurloancount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountloan06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountloan12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountloan24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountloan36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountloan60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountloan84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountloanever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=5)));

Business: => Sbfedelq91occurlinecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountline06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountline12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountline24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountline36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountline60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountline84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountlineever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=5)));

Business: => Sbfedelq91occurcardcount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountcard06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountcard12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountcard24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountcard36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountcard60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountcard84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountcardever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=5)));

Business: => Sbfedelq91occurleasecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountlease06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountlease12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountlease24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountlease36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountlease60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountlease84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountleaseever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=5)));

Business: => Sbfedelq91occurlettercount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountletter06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountletter12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountletter24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountletter36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountletter60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountletter84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountletterever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=5)));

Business: => Sbfedelq91occuroelinecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountoline06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountoline12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountoline24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountoline36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountoline60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountoline84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountolineever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=5)));

Business: => Sbfedelq91occurothercount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountother06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountother12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountother24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountother36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountother60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountother84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=5)));
Business: => Sbfedpd91occurcountotherever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=5)));

Business: => Sbfedelq121occurcount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcount06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcount12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcount24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcount36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcount60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcount84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc.AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc.AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=6)));
																 
Business: => Sbfedelq121occurloancount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountloan06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountloan12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountloan24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountloan36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountloan60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountloan84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountloanever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLoan).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=6)));

Business: => Sbfedelq121occurlinecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountline06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountline12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountline24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountline36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountline60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountline84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountlineever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLine).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=6)));

Business: => Sbfedelq121occurcardcount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountcard06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountcard12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountcard24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountcard36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountcard60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountcard84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountcardever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsCard).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=6)));

Business: => Sbfedelq121occurleasecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountlease06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountlease12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountlease24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountlease36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountlease60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountlease84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountleaseever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLease).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=6)));

Business: => Sbfedelq121occurlettercount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountletter06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountletter12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountletter24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountletter36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountletter60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountletter84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountletterever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsLetter).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=6)));

Business: => Sbfedelq121occuroelinecount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountoline06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountoline12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountoline24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountoline36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountoline60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountoline84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountolineever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOLine).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=6)));

Business: => Sbfedelq121occurothercount03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is3Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is3Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is3Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountother06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is6Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is6Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is6Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountother12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is12Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is12Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is12Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountother24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is24Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is24Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is24Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountother36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is36Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is36Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is36Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountother60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is60Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is60Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is60Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountother84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is84Month AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is84Month AND NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is84Month AND NOT AccountClosed AND PaymentStatus=6)));
Business: => Sbfedpd121occurcountotherever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(NOT AccountClosed)) => NO_DATA_AVAILABLE,
																 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(NOT AccountClosed), PaymentStatus=UNKNOWN_DATA) => UNKNOWN_DATA,
																 COUNT(BusinessAccount.acc(IsOther).AccountTradeline.trade(NOT AccountClosed AND PaymentStatus=6)));																 

Tradeline: => PastDueAmountBucket1 := IF(past_due_aging_amount_bucket_1:Null, 0, ABS(past_due_aging_amount_bucket_1));
Tradeline: => PastDueAmountBucket2 := IF(past_due_aging_amount_bucket_2:Null, 0, ABS(past_due_aging_amount_bucket_2));
Tradeline: => PastDueAmountBucket3 := IF(past_due_aging_amount_bucket_3:Null, 0, ABS(past_due_aging_amount_bucket_3));
Tradeline: => PastDueAmountBucket4 := IF(past_due_aging_amount_bucket_4:Null, 0, ABS(past_due_aging_amount_bucket_4));
Tradeline: => PastDueAmountBucket5 := IF(past_due_aging_amount_bucket_5:Null, 0, ABS(past_due_aging_amount_bucket_5));
Tradeline: => PastDueAmountBucket6 := IF(past_due_aging_amount_bucket_6:Null, 0, ABS(past_due_aging_amount_bucket_6));
Tradeline: => PastDueAmountBucket7 := IF(past_due_aging_amount_bucket_7:Null, 0, ABS(past_due_aging_amount_bucket_7));

Tradeline: => DPD01Amount :=  PastDueAmountBucket1 +
															PastDueAmountBucket2 +
															PastDueAmountBucket3 +
															PastDueAmountBucket4 +
															PastDueAmountBucket5 +
															PastDueAmountBucket6 +
															PastDueAmountBucket7;
Tradeline: => DPD31Amount :=  PastDueAmountBucket2 +
															PastDueAmountBucket3 +
															PastDueAmountBucket4 +
															PastDueAmountBucket5 +
															PastDueAmountBucket6 +
															PastDueAmountBucket7;
Tradeline: => DPD61Amount :=  PastDueAmountBucket3 +
															PastDueAmountBucket4 +
															PastDueAmountBucket5 +
															PastDueAmountBucket6 +
															PastDueAmountBucket7;
Tradeline: => DPD91Amount :=  PastDueAmountBucket4 +
															PastDueAmountBucket5 +
															PastDueAmountBucket6 +
															PastDueAmountBucket7;
Tradeline: => DPD121Amount := PastDueAmountBucket5 +
															PastDueAmountBucket6 +
															PastDueAmountBucket7;
/*
Account: => DPD01AmountAccount := MostRecentTradeline.DPD01Amount;
Account: => DPD31AmountAccount := MostRecentTradeline.DPD31Amount;
Account: => DPD61AmountAccount := MostRecentTradeline.DPD61Amount;
Account: => DPD91AmountAccount := MostRecentTradeline.DPD91Amount;
Account: => DPD121AmountAccount := MostRecentTradeline.DPD121Amount;
*/
Tradeline: => IsMostRecentTradeline := load_date = MAX(AccountTradeline.acc,MostRecentTradelineDate);
Account: => DPD01AmountAccount := MAX(AccountTradeline.trade(load_date = Account.MostRecentTradelineDate), DPD01Amount);
Account: => DPD31AmountAccount := MAX(AccountTradeline.trade(load_date = Account.MostRecentTradelineDate), DPD31Amount);
Account: => DPD61AmountAccount := MAX(AccountTradeline.trade(load_date = Account.MostRecentTradelineDate), DPD61Amount);
Account: => DPD91AmountAccount := MAX(AccountTradeline.trade(load_date = Account.MostRecentTradelineDate), DPD91Amount);
Account: => DPD121AmountAccount := MAX(AccountTradeline.trade(load_date = Account.MostRecentTradelineDate), DPD121Amount);

Tradeline: => UnknownDPD01Amount := past_due_aging_amount_bucket_1:Null AND
																		past_due_aging_amount_bucket_2:Null AND
																		past_due_aging_amount_bucket_3:Null AND
																		past_due_aging_amount_bucket_4:Null AND
																		past_due_aging_amount_bucket_5:Null AND
																		past_due_aging_amount_bucket_6:Null AND
																		past_due_aging_amount_bucket_7:Null;
Tradeline: => UnknownDPD31Amount := past_due_aging_amount_bucket_2:Null AND
																		past_due_aging_amount_bucket_3:Null AND
																		past_due_aging_amount_bucket_4:Null AND
																		past_due_aging_amount_bucket_5:Null AND
																		past_due_aging_amount_bucket_6:Null AND
																		past_due_aging_amount_bucket_7:Null;
Tradeline: => UnknownDPD61Amount := past_due_aging_amount_bucket_3:Null AND
																		past_due_aging_amount_bucket_4:Null AND
																		past_due_aging_amount_bucket_5:Null AND
																		past_due_aging_amount_bucket_6:Null AND
																		past_due_aging_amount_bucket_7:Null;
Tradeline: => UnknownDPD91Amount := past_due_aging_amount_bucket_4:Null AND
																		past_due_aging_amount_bucket_5:Null AND
																		past_due_aging_amount_bucket_6:Null AND
																		past_due_aging_amount_bucket_7:Null;
Tradeline: => UnknownDPD121Amount := past_due_aging_amount_bucket_5:Null AND
																		past_due_aging_amount_bucket_6:Null AND
																		past_due_aging_amount_bucket_7:Null;


Account: => UnknownDPD01AmountAccount := ALL(AccountTradeline.trade(load_date = Account.MostRecentTradelineDate), UnknownDPD01Amount);
Account: => UnknownDPD31AmountAccount := ALL(AccountTradeline.trade(load_date = Account.MostRecentTradelineDate), UnknownDPD31Amount);
Account: => UnknownDPD61AmountAccount := ALL(AccountTradeline.trade(load_date = Account.MostRecentTradelineDate), UnknownDPD61Amount);
Account: => UnknownDPD91AmountAccount := ALL(AccountTradeline.trade(load_date = Account.MostRecentTradelineDate), UnknownDPD91Amount);
Account: => UnknownDPD121AmountAccount := ALL(AccountTradeline.trade(load_date = Account.MostRecentTradelineDate), UnknownDPD121Amount);


Business: => Sbfedpd01amount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenallcount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen), UnknownDPD01AmountAccount) => UNKNOWN_DATA, //could also check for payment status and set to 0 is status is current
																SUM(BusinessAccount.acc(IsOpen), DPD01AmountAccount));
																
Business: => Sbfedelq01amtttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenallcount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen), UnknownDPD01AmountAccount OR UnknownDPD31AmountAccount) => UNKNOWN_DATA,
																Sbfedpd01amount - Sbfedpd31amount);
																
Business: => Sbfedelq01amt03m:= MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen3Month), Hist03MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen3Month), Hist03MTradeline.DPD01Amount));
Business: => Sbfedelq01amt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen6Month), Hist06MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen6Month), Hist06MTradeline.DPD01Amount));
Business: => Sbfedelq01amt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen12Month), Hist12MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen12Month), Hist12MTradeline.DPD01Amount));
Business: => Sbfedelq01amt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen24Month), Hist24MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen24Month), Hist24MTradeline.DPD01Amount));
Business: => Sbfedelq01amt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen36Month), Hist36MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen36Month), Hist36MTradeline.DPD01Amount));
Business: => Sbfedelq01amt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen60Month), Hist60MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen60Month), Hist60MTradeline.DPD01Amount));
Business: => Sbfedelq01amt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen84Month), Hist84MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen84Month), Hist84MTradeline.DPD01Amount));

Business: => Sbfedpd31amount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenallcount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen), UnknownDPD31AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen), DPD31AmountAccount));
																
Business: => Sbfedelq31amtttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenallcount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen), UnknownDPD31AmountAccount OR UnknownDPD61AmountAccount) => UNKNOWN_DATA,
																Sbfedpd31amount - Sbfedpd61amount);
																
Business: => Sbfedelq31amt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen3Month), Hist03MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen3Month), Hist03MTradeline.DPD31Amount));
Business: => Sbfedelq31amt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen6Month), Hist06MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen6Month), Hist06MTradeline.DPD31Amount));
Business: => Sbfedelq31amt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen12Month), Hist12MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen12Month), Hist12MTradeline.DPD31Amount));
Business: => Sbfedelq31amt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen24Month), Hist24MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen24Month), Hist24MTradeline.DPD31Amount));
Business: => Sbfedelq31amt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen36Month), Hist36MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen36Month), Hist36MTradeline.DPD31Amount));
Business: => Sbfedelq31amt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen60Month), Hist60MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen60Month), Hist60MTradeline.DPD31Amount));
Business: => Sbfedelq31amt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen84Month), Hist84MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen84Month), Hist84MTradeline.DPD31Amount));
																
Business: => Sbfedpd61amount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenallcount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen), UnknownDPD61AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen), DPD61AmountAccount));
																
Business: => Sbfedelq61amtttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenallcount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen), UnknownDPD61AmountAccount OR UnknownDPD91AmountAccount) => UNKNOWN_DATA,
																Sbfedpd61amount - Sbfedpd91amount);
																
Business: => Sbfedelq61amt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen3Month), Hist03MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen3Month), Hist03MTradeline.DPD61Amount));
Business: => Sbfedelq61amt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen6Month), Hist06MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen6Month), Hist06MTradeline.DPD61Amount));
Business: => Sbfedelq61amt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen12Month), Hist12MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen12Month), Hist12MTradeline.DPD61Amount));
Business: => Sbfedelq61amt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen24Month), Hist24MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen24Month), Hist24MTradeline.DPD61Amount));
Business: => Sbfedelq61amt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen36Month), Hist36MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen36Month), Hist36MTradeline.DPD61Amount));
Business: => Sbfedelq61amt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen60Month), Hist60MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen60Month), Hist60MTradeline.DPD61Amount));
Business: => Sbfedelq61amt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen84Month), Hist84MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen84Month), Hist84MTradeline.DPD61Amount));

Business: => Sbfedpd91amount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenallcount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen), UnknownDPD91AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen), DPD91AmountAccount));
																
Business: => Sbfedelq91amtttl := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenallcount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen), UnknownDPD91AmountAccount OR UnknownDPD121AmountAccount) => UNKNOWN_DATA,
																Sbfedpd91amount - Sbfedpd121amount);												
																
Business: => Sbfedelq91amt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen3Month), Hist03MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen3Month), Hist03MTradeline.DPD91Amount));
Business: => Sbfedelq91amt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen6Month), Hist06MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen6Month), Hist06MTradeline.DPD91Amount));
Business: => Sbfedelq91amt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen12Month), Hist12MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen12Month), Hist12MTradeline.DPD91Amount));
Business: => Sbfedelq91amt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen24Month), Hist24MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen24Month), Hist24MTradeline.DPD91Amount));
Business: => Sbfedelq91amt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen36Month), Hist36MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen36Month), Hist36MTradeline.DPD91Amount));
Business: => Sbfedelq91amt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen60Month), Hist60MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen60Month), Hist60MTradeline.DPD91Amount));
Business: => Sbfedelq91amt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen84Month), Hist84MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen84Month), Hist84MTradeline.DPD91Amount));
																
Business: => Sbfedpd121amount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenallcount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen), UnknownDPD121AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen), DPD121AmountAccount));																
Business: => Sbfedelq121amt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen3Month), Hist03MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen3Month), Hist03MTradeline.DPD121Amount));
Business: => Sbfedelq121amt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen6Month), Hist06MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen6Month), Hist06MTradeline.DPD121Amount));
Business: => Sbfedelq121amt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen12Month), Hist12MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen12Month), Hist12MTradeline.DPD121Amount));
Business: => Sbfedelq121amt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen24Month), Hist24MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen24Month), Hist24MTradeline.DPD121Amount));
Business: => Sbfedelq121amt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen36Month), Hist36MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen36Month), Hist36MTradeline.DPD121Amount));
Business: => Sbfedelq121amt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen60Month), Hist60MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen60Month), Hist60MTradeline.DPD121Amount));
Business: => Sbfedelq121amt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen84Month), Hist84MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen84Month), Hist84MTradeline.DPD121Amount));
																
Business: => Sbfedpd01amountloan := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsLoan), UnknownDPD01AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsLoan), DPD01AmountAccount));
Business: => Sbfedelq01loanamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen3Month), Hist03MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen3Month), Hist03MTradeline.DPD01Amount));
Business: => Sbfedelq01loanamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen6Month), Hist06MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen6Month), Hist06MTradeline.DPD01Amount));
Business: => Sbfedelq01loanamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen12Month), Hist12MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen12Month), Hist12MTradeline.DPD01Amount));
Business: => Sbfedelq01loanamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen24Month), Hist24MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen24Month), Hist24MTradeline.DPD01Amount));
Business: => Sbfedelq01loanamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen36Month), Hist36MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen36Month), Hist36MTradeline.DPD01Amount));
Business: => Sbfedelq01loanamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen60Month), Hist60MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen60Month), Hist60MTradeline.DPD01Amount));
Business: => Sbfedelq01loanamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen84Month), Hist84MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen84Month), Hist84MTradeline.DPD01Amount));

Business: => Sbfedpd31amountloan := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsLoan), UnknownDPD31AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsLoan), DPD31AmountAccount));
Business: => Sbfedelq31loanamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen3Month), Hist03MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen3Month), Hist03MTradeline.DPD31Amount));
Business: => Sbfedelq31loanamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen6Month), Hist06MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen6Month), Hist06MTradeline.DPD31Amount));
Business: => Sbfedelq31loanamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen12Month), Hist12MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen12Month), Hist12MTradeline.DPD31Amount));
Business: => Sbfedelq31loanamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen24Month), Hist24MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen24Month), Hist24MTradeline.DPD31Amount));
Business: => Sbfedelq31loanamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen36Month), Hist36MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen36Month), Hist36MTradeline.DPD31Amount));
Business: => Sbfedelq31loanamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen60Month), Hist60MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen60Month), Hist60MTradeline.DPD31Amount));
Business: => Sbfedelq31loanamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen84Month), Hist84MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen84Month), Hist84MTradeline.DPD31Amount));

Business: => Sbfedpd61amountloan := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsLoan), UnknownDPD61AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsLoan), DPD61AmountAccount));
Business: => Sbfedelq61loanamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen3Month), Hist03MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen3Month), Hist03MTradeline.DPD61Amount));
Business: => Sbfedelq61loanamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen6Month), Hist06MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen6Month), Hist06MTradeline.DPD61Amount));
Business: => Sbfedelq61loanamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen12Month), Hist12MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen12Month), Hist12MTradeline.DPD61Amount));
Business: => Sbfedelq61loanamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen24Month), Hist24MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen24Month), Hist24MTradeline.DPD61Amount));
Business: => Sbfedelq61loanamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen36Month), Hist36MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen36Month), Hist36MTradeline.DPD61Amount));
Business: => Sbfedelq61loanamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen60Month), Hist60MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen60Month), Hist60MTradeline.DPD61Amount));
Business: => Sbfedelq61loanamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen84Month), Hist84MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen84Month), Hist84MTradeline.DPD61Amount));

Business: => Sbfedpd91amountloan := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsLoan), UnknownDPD91AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsLoan), DPD91AmountAccount));
Business: => Sbfedelq91loanamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen3Month), Hist03MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen3Month), Hist03MTradeline.DPD91Amount));
Business: => Sbfedelq91loanamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen6Month), Hist06MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen6Month), Hist06MTradeline.DPD91Amount));
Business: => Sbfedelq91loanamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen12Month), Hist12MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen12Month), Hist12MTradeline.DPD91Amount));
Business: => Sbfedelq91loanamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen24Month), Hist24MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen24Month), Hist24MTradeline.DPD91Amount));
Business: => Sbfedelq91loanamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen36Month), Hist36MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen36Month), Hist36MTradeline.DPD91Amount));
Business: => Sbfedelq91loanamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen60Month), Hist60MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen60Month), Hist60MTradeline.DPD91Amount));
Business: => Sbfedelq91loanamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen84Month), Hist84MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen84Month), Hist84MTradeline.DPD91Amount));

Business: => Sbfedpd121amountloan := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsLoan), UnknownDPD121AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsLoan), DPD121AmountAccount));
Business: => Sbfedelq121loanamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen3Month), Hist03MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen3Month), Hist03MTradeline.DPD121Amount));
Business: => Sbfedelq121loanamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen6Month), Hist06MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen6Month), Hist06MTradeline.DPD121Amount));
Business: => Sbfedelq121loanamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen12Month), Hist12MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen12Month), Hist12MTradeline.DPD121Amount));
Business: => Sbfedelq121loanamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen24Month), Hist24MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen24Month), Hist24MTradeline.DPD121Amount));
Business: => Sbfedelq121loanamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen36Month), Hist36MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen36Month), Hist36MTradeline.DPD121Amount));
Business: => Sbfedelq121loanamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen60Month), Hist60MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen60Month), Hist60MTradeline.DPD121Amount));
Business: => Sbfedelq121loanamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenloancount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLoan AND IsOpen84Month), Hist84MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLoan AND IsOpen84Month), Hist84MTradeline.DPD121Amount));
////////////////////////////
Business: => Sbfedpd01amountline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsLine), UnknownDPD01AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsLine), DPD01AmountAccount));
Business: => Sbfedelq01lineamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen3Month), Hist03MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen3Month), Hist03MTradeline.DPD01Amount));
Business: => Sbfedelq01lineamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen6Month), Hist06MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen6Month), Hist06MTradeline.DPD01Amount));
Business: => Sbfedelq01lineamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen12Month), Hist12MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen12Month), Hist12MTradeline.DPD01Amount));
Business: => Sbfedelq01lineamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen24Month), Hist24MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen24Month), Hist24MTradeline.DPD01Amount));
Business: => Sbfedelq01lineamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen36Month), Hist36MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen36Month), Hist36MTradeline.DPD01Amount));
Business: => Sbfedelq01lineamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen60Month), Hist60MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen60Month), Hist60MTradeline.DPD01Amount));
Business: => Sbfedelq01lineamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen84Month), Hist84MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen84Month), Hist84MTradeline.DPD01Amount));
/////
Business: => Sbfedpd31amountline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsLine), UnknownDPD31AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsLine), DPD31AmountAccount));
Business: => Sbfedelq31lineamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen3Month), Hist03MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen3Month), Hist03MTradeline.DPD31Amount));
Business: => Sbfedelq31lineamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen6Month), Hist06MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen6Month), Hist06MTradeline.DPD31Amount));
Business: => Sbfedelq31lineamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen12Month), Hist12MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen12Month), Hist12MTradeline.DPD31Amount));
Business: => Sbfedelq31lineamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen24Month), Hist24MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen24Month), Hist24MTradeline.DPD31Amount));
Business: => Sbfedelq31lineamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen36Month), Hist36MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen36Month), Hist36MTradeline.DPD31Amount));
Business: => Sbfedelq31lineamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen60Month), Hist60MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen60Month), Hist60MTradeline.DPD31Amount));
Business: => Sbfedelq31lineamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen84Month), Hist84MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen84Month), Hist84MTradeline.DPD31Amount));

Business: => Sbfedpd61amountline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsLine), UnknownDPD61AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsLine), DPD61AmountAccount));
Business: => Sbfedelq61lineamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen3Month), Hist03MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen3Month), Hist03MTradeline.DPD61Amount));
Business: => Sbfedelq61lineamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen6Month), Hist06MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen6Month), Hist06MTradeline.DPD61Amount));
Business: => Sbfedelq61lineamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen12Month), Hist12MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen12Month), Hist12MTradeline.DPD61Amount));
Business: => Sbfedelq61lineamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen24Month), Hist24MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen24Month), Hist24MTradeline.DPD61Amount));
Business: => Sbfedelq61lineamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen36Month), Hist36MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen36Month), Hist36MTradeline.DPD61Amount));
Business: => Sbfedelq61lineamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen60Month), Hist60MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen60Month), Hist60MTradeline.DPD61Amount));
Business: => Sbfedelq61lineamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen84Month), Hist84MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen84Month), Hist84MTradeline.DPD61Amount));

Business: => Sbfedpd91amountline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsLine), UnknownDPD91AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsLine), DPD91AmountAccount));
Business: => Sbfedelq91lineamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen3Month), Hist03MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen3Month), Hist03MTradeline.DPD91Amount));
Business: => Sbfedelq91lineamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen6Month), Hist06MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen6Month), Hist06MTradeline.DPD91Amount));
Business: => Sbfedelq91lineamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen12Month), Hist12MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen12Month), Hist12MTradeline.DPD91Amount));
Business: => Sbfedelq91lineamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen24Month), Hist24MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen24Month), Hist24MTradeline.DPD91Amount));
Business: => Sbfedelq91lineamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen36Month), Hist36MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen36Month), Hist36MTradeline.DPD91Amount));
Business: => Sbfedelq91lineamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen60Month), Hist60MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen60Month), Hist60MTradeline.DPD91Amount));
Business: => Sbfedelq91lineamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen84Month), Hist84MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen84Month), Hist84MTradeline.DPD91Amount));

Business: => Sbfedpd121amountline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsLine), UnknownDPD121AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsLine), DPD121AmountAccount));
Business: => Sbfedelq121lineamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen3Month), Hist03MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen3Month), Hist03MTradeline.DPD121Amount));
Business: => Sbfedelq121lineamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen6Month), Hist06MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen6Month), Hist06MTradeline.DPD121Amount));
Business: => Sbfedelq121lineamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen12Month), Hist12MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen12Month), Hist12MTradeline.DPD121Amount));
Business: => Sbfedelq121lineamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen24Month), Hist24MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen24Month), Hist24MTradeline.DPD121Amount));
Business: => Sbfedelq121lineamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen36Month), Hist36MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen36Month), Hist36MTradeline.DPD121Amount));
Business: => Sbfedelq121lineamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen60Month), Hist60MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen60Month), Hist60MTradeline.DPD121Amount));
Business: => Sbfedelq121lineamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlinecount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLine AND IsOpen84Month), Hist84MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLine AND IsOpen84Month), Hist84MTradeline.DPD121Amount));

Business: => Sbfedpd01amountcard := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsCard), UnknownDPD01AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsCard), DPD01AmountAccount));
Business: => Sbfedelq01cardamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen3Month), Hist03MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen3Month), Hist03MTradeline.DPD01Amount));
Business: => Sbfedelq01cardamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen6Month), Hist06MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen6Month), Hist06MTradeline.DPD01Amount));
Business: => Sbfedelq01cardamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen12Month), Hist12MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen12Month), Hist12MTradeline.DPD01Amount));
Business: => Sbfedelq01cardamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen24Month), Hist24MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen24Month), Hist24MTradeline.DPD01Amount));
Business: => Sbfedelq01cardamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen36Month), Hist36MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen36Month), Hist36MTradeline.DPD01Amount));
Business: => Sbfedelq01cardamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen60Month), Hist60MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen60Month), Hist60MTradeline.DPD01Amount));
Business: => Sbfedelq01cardamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen84Month), Hist84MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen84Month), Hist84MTradeline.DPD01Amount));

Business: => Sbfedpd31amountcard := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsCard), UnknownDPD31AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsCard), DPD31AmountAccount));
Business: => Sbfedelq31cardamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen3Month), Hist03MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen3Month), Hist03MTradeline.DPD31Amount));
Business: => Sbfedelq31cardamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen6Month), Hist06MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen6Month), Hist06MTradeline.DPD31Amount));
Business: => Sbfedelq31cardamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen12Month), Hist12MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen12Month), Hist12MTradeline.DPD31Amount));
Business: => Sbfedelq31cardamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen24Month), Hist24MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen24Month), Hist24MTradeline.DPD31Amount));
Business: => Sbfedelq31cardamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen36Month), Hist36MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen36Month), Hist36MTradeline.DPD31Amount));
Business: => Sbfedelq31cardamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen60Month), Hist60MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen60Month), Hist60MTradeline.DPD31Amount));
Business: => Sbfedelq31cardamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen84Month), Hist84MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen84Month), Hist84MTradeline.DPD31Amount));

Business: => Sbfedpd61amountcard := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsCard), UnknownDPD61AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsCard), DPD61AmountAccount));
Business: => Sbfedelq61cardamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen3Month), Hist03MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen3Month), Hist03MTradeline.DPD61Amount));
Business: => Sbfedelq61cardamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen6Month), Hist06MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen6Month), Hist06MTradeline.DPD61Amount));
Business: => Sbfedelq61cardamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen12Month), Hist12MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen12Month), Hist12MTradeline.DPD61Amount));
Business: => Sbfedelq61cardamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen24Month), Hist24MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen24Month), Hist24MTradeline.DPD61Amount));
Business: => Sbfedelq61cardamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen36Month), Hist36MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen36Month), Hist36MTradeline.DPD61Amount));
Business: => Sbfedelq61cardamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen60Month), Hist60MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen60Month), Hist60MTradeline.DPD61Amount));
Business: => Sbfedelq61cardamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen84Month), Hist84MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen84Month), Hist84MTradeline.DPD61Amount));

Business: => Sbfedpd91amountcard := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsCard), UnknownDPD91AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsCard), DPD91AmountAccount));
Business: => Sbfedelq91cardamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen3Month), Hist03MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen3Month), Hist03MTradeline.DPD91Amount));
Business: => Sbfedelq91cardamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen6Month), Hist06MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen6Month), Hist06MTradeline.DPD91Amount));
Business: => Sbfedelq91cardamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen12Month), Hist12MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen12Month), Hist12MTradeline.DPD91Amount));
Business: => Sbfedelq91cardamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen24Month), Hist24MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen24Month), Hist24MTradeline.DPD91Amount));
Business: => Sbfedelq91cardamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen36Month), Hist36MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen36Month), Hist36MTradeline.DPD91Amount));
Business: => Sbfedelq91cardamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen60Month), Hist60MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen60Month), Hist60MTradeline.DPD91Amount));
Business: => Sbfedelq91cardamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen84Month), Hist84MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen84Month), Hist84MTradeline.DPD91Amount));

Business: => Sbfedpd121amountcard := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsCard), UnknownDPD121AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsCard), DPD121AmountAccount));
Business: => Sbfedelq121cardamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen3Month), Hist03MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen3Month), Hist03MTradeline.DPD121Amount));
Business: => Sbfedelq121cardamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen6Month), Hist06MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen6Month), Hist06MTradeline.DPD121Amount));
Business: => Sbfedelq121cardamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen12Month), Hist12MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen12Month), Hist12MTradeline.DPD121Amount));
Business: => Sbfedelq121cardamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen24Month), Hist24MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen24Month), Hist24MTradeline.DPD121Amount));
Business: => Sbfedelq121cardamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen36Month), Hist36MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen36Month), Hist36MTradeline.DPD121Amount));
Business: => Sbfedelq121cardamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen60Month), Hist60MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen60Month), Hist60MTradeline.DPD121Amount));
Business: => Sbfedelq121cardamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencardcount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsCard AND IsOpen84Month), Hist84MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsCard AND IsOpen84Month), Hist84MTradeline.DPD121Amount));


Business: => Sbfedpd01amountlease := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsLease), UnknownDPD01AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsLease), DPD01AmountAccount));
Business: => Sbfedelq01leaseamt03m :=  MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen3Month), Hist03MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen3Month), Hist03MTradeline.DPD01Amount));
Business: => Sbfedelq01leaseamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen6Month), Hist06MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen6Month), Hist06MTradeline.DPD01Amount));
Business: => Sbfedelq01leaseamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen12Month), Hist12MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen12Month), Hist12MTradeline.DPD01Amount));
Business: => Sbfedelq01leaseamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen24Month), Hist24MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen24Month), Hist24MTradeline.DPD01Amount));
Business: => Sbfedelq01leaseamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen36Month), Hist36MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen36Month), Hist36MTradeline.DPD01Amount));
Business: => Sbfedelq01leaseamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen60Month), Hist60MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen60Month), Hist60MTradeline.DPD01Amount));
Business: => Sbfedelq01leaseamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen84Month), Hist84MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen84Month), Hist84MTradeline.DPD01Amount));

Business: => Sbfedpd31amountlease := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsLease), UnknownDPD31AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsLease), DPD31AmountAccount));
Business: => Sbfedelq31leaseamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen3Month), Hist03MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen3Month), Hist03MTradeline.DPD31Amount));
Business: => Sbfedelq31leaseamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen6Month), Hist06MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen6Month), Hist06MTradeline.DPD31Amount));
Business: => Sbfedelq31leaseamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen12Month), Hist12MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen12Month), Hist12MTradeline.DPD31Amount));
Business: => Sbfedelq31leaseamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen24Month), Hist24MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen24Month), Hist24MTradeline.DPD31Amount));
Business: => Sbfedelq31leaseamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen36Month), Hist36MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen36Month), Hist36MTradeline.DPD31Amount));
Business: => Sbfedelq31leaseamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen60Month), Hist60MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen60Month), Hist60MTradeline.DPD31Amount));
Business: => Sbfedelq31leaseamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen84Month), Hist84MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen84Month), Hist84MTradeline.DPD31Amount));

Business: => Sbfedpd61amountlease := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsLease), UnknownDPD61AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsLease), DPD61AmountAccount));
Business: => Sbfedelq61leaseamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen3Month), Hist03MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen3Month), Hist03MTradeline.DPD61Amount));
Business: => Sbfedelq61leaseamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen6Month), Hist06MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen6Month), Hist06MTradeline.DPD61Amount));
Business: => Sbfedelq61leaseamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen12Month), Hist12MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen12Month), Hist12MTradeline.DPD61Amount));
Business: => Sbfedelq61leaseamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen24Month), Hist24MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen24Month), Hist24MTradeline.DPD61Amount));
Business: => Sbfedelq61leaseamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen36Month), Hist36MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen36Month), Hist36MTradeline.DPD61Amount));
Business: => Sbfedelq61leaseamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen60Month), Hist60MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen60Month), Hist60MTradeline.DPD61Amount));
Business: => Sbfedelq61leaseamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen84Month), Hist84MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen84Month), Hist84MTradeline.DPD61Amount));

Business: => Sbfedpd91amountlease := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsLease), UnknownDPD91AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsLease), DPD91AmountAccount));
Business: => Sbfedelq91leaseamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen3Month), Hist03MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen3Month), Hist03MTradeline.DPD91Amount));
Business: => Sbfedelq91leaseamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen6Month), Hist06MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen6Month), Hist06MTradeline.DPD91Amount));
Business: => Sbfedelq91leaseamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen12Month), Hist12MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen12Month), Hist12MTradeline.DPD91Amount));
Business: => Sbfedelq91leaseamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen24Month), Hist24MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen24Month), Hist24MTradeline.DPD91Amount));
Business: => Sbfedelq91leaseamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen36Month), Hist36MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen36Month), Hist36MTradeline.DPD91Amount));
Business: => Sbfedelq91leaseamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen60Month), Hist60MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen60Month), Hist60MTradeline.DPD91Amount));
Business: => Sbfedelq91leaseamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen84Month), Hist84MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen84Month), Hist84MTradeline.DPD91Amount));

Business: => Sbfedpd121amountlease := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsLease), UnknownDPD121AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsLease), DPD121AmountAccount));
Business: => Sbfedelq121leaseamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen3Month), Hist03MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen3Month), Hist03MTradeline.DPD121Amount));
Business: => Sbfedelq121leaseamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen6Month), Hist06MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen6Month), Hist06MTradeline.DPD121Amount));
Business: => Sbfedelq121leaseamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen12Month), Hist12MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen12Month), Hist12MTradeline.DPD121Amount));
Business: => Sbfedelq121leaseamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen24Month), Hist24MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen24Month), Hist24MTradeline.DPD121Amount));
Business: => Sbfedelq121leaseamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen36Month), Hist36MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen36Month), Hist36MTradeline.DPD121Amount));
Business: => Sbfedelq121leaseamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen60Month), Hist60MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen60Month), Hist60MTradeline.DPD121Amount));
Business: => Sbfedelq121leaseamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenleasecount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLease AND IsOpen84Month), Hist84MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLease AND IsOpen84Month), Hist84MTradeline.DPD121Amount));

Business: => Sbfedpd01amountletter := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsLetter), UnknownDPD01AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsLetter), DPD01AmountAccount));
Business: => Sbfedelq01letteramt03m :=  MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen3Month), Hist03MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen3Month), Hist03MTradeline.DPD01Amount));
Business: => Sbfedelq01letteramt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen6Month), Hist06MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen6Month), Hist06MTradeline.DPD01Amount));
Business: => Sbfedelq01letteramt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen12Month), Hist12MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen12Month), Hist12MTradeline.DPD01Amount));
Business: => Sbfedelq01letteramt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen24Month), Hist24MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen24Month), Hist24MTradeline.DPD01Amount));
Business: => Sbfedelq01letteramt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen36Month), Hist36MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen36Month), Hist36MTradeline.DPD01Amount));
Business: => Sbfedelq01letteramt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen60Month), Hist60MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen60Month), Hist60MTradeline.DPD01Amount));
Business: => Sbfedelq01letteramt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen84Month), Hist84MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen84Month), Hist84MTradeline.DPD01Amount));

Business: => Sbfedpd31amountletter := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsLetter), UnknownDPD31AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsLetter), DPD31AmountAccount));
Business: => Sbfedelq31letteramt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen3Month), Hist03MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen3Month), Hist03MTradeline.DPD31Amount));
Business: => Sbfedelq31letteramt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen6Month), Hist06MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen6Month), Hist06MTradeline.DPD31Amount));
Business: => Sbfedelq31letteramt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen12Month), Hist12MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen12Month), Hist12MTradeline.DPD31Amount));
Business: => Sbfedelq31letteramt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen24Month), Hist24MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen24Month), Hist24MTradeline.DPD31Amount));
Business: => Sbfedelq31letteramt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen36Month), Hist36MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen36Month), Hist36MTradeline.DPD31Amount));
Business: => Sbfedelq31letteramt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen60Month), Hist60MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen60Month), Hist60MTradeline.DPD31Amount));
Business: => Sbfedelq31letteramt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen84Month), Hist84MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen84Month), Hist84MTradeline.DPD31Amount));

Business: => Sbfedpd61amountletter := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsLetter), UnknownDPD61AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsLetter), DPD61AmountAccount));
Business: => Sbfedelq61letteramt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen3Month), Hist03MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen3Month), Hist03MTradeline.DPD61Amount));
Business: => Sbfedelq61letteramt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen6Month), Hist06MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen6Month), Hist06MTradeline.DPD61Amount));
Business: => Sbfedelq61letteramt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen12Month), Hist12MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen12Month), Hist12MTradeline.DPD61Amount));
Business: => Sbfedelq61letteramt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen24Month), Hist24MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen24Month), Hist24MTradeline.DPD61Amount));
Business: => Sbfedelq61letteramt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen36Month), Hist36MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen36Month), Hist36MTradeline.DPD61Amount));
Business: => Sbfedelq61letteramt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen60Month), Hist60MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen60Month), Hist60MTradeline.DPD61Amount));
Business: => Sbfedelq61letteramt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen84Month), Hist84MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen84Month), Hist84MTradeline.DPD61Amount));

Business: => Sbfedpd91amountletter := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsLetter), UnknownDPD91AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsLetter), DPD91AmountAccount));
Business: => Sbfedelq91letteramt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen3Month), Hist03MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen3Month), Hist03MTradeline.DPD91Amount));
Business: => Sbfedelq91letteramt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen6Month), Hist06MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen6Month), Hist06MTradeline.DPD91Amount));
Business: => Sbfedelq91letteramt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen12Month), Hist12MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen12Month), Hist12MTradeline.DPD91Amount));
Business: => Sbfedelq91letteramt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen24Month), Hist24MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen24Month), Hist24MTradeline.DPD91Amount));
Business: => Sbfedelq91letteramt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen36Month), Hist36MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen36Month), Hist36MTradeline.DPD91Amount));
Business: => Sbfedelq91letteramt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen60Month), Hist60MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen60Month), Hist60MTradeline.DPD91Amount));
Business: => Sbfedelq91letteramt84m :=MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen84Month), Hist84MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen84Month), Hist84MTradeline.DPD91Amount));

Business: => Sbfedpd121amountletter := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsLetter), UnknownDPD121AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsLetter), DPD121AmountAccount));
Business: => Sbfedelq121letteramt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen3Month), Hist03MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen3Month), Hist03MTradeline.DPD121Amount));
Business: => Sbfedelq121letteramt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen6Month), Hist06MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen6Month), Hist06MTradeline.DPD121Amount));
Business: => Sbfedelq121letteramt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen12Month), Hist12MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen12Month), Hist12MTradeline.DPD121Amount));
Business: => Sbfedelq121letteramt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen24Month), Hist24MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen24Month), Hist24MTradeline.DPD121Amount));
Business: => Sbfedelq121letteramt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen36Month), Hist36MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen36Month), Hist36MTradeline.DPD121Amount));
Business: => Sbfedelq121letteramt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen60Month), Hist60MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen60Month), Hist60MTradeline.DPD121Amount));
Business: => Sbfedelq121letteramt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenlettercount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsLetter AND IsOpen84Month), Hist84MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsLetter AND IsOpen84Month), Hist84MTradeline.DPD121Amount));

Business: => Sbfedpd01amountoline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenolinecount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsOLine), UnknownDPD01AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsOLine), DPD01AmountAccount));
Business: => Sbfedelq01oelineamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen3Month), Hist03MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen3Month), Hist03MTradeline.DPD01Amount));
Business: => Sbfedelq01oelineamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen6Month), Hist06MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen6Month), Hist06MTradeline.DPD01Amount));
Business: => Sbfedelq01oelineamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen12Month), Hist12MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen12Month), Hist12MTradeline.DPD01Amount));
Business: => Sbfedelq01oelineamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen24Month), Hist24MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen24Month), Hist24MTradeline.DPD01Amount));
Business: => Sbfedelq01oelineamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen36Month), Hist36MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen36Month), Hist36MTradeline.DPD01Amount));
Business: => Sbfedelq01oelineamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen60Month), Hist60MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen60Month), Hist60MTradeline.DPD01Amount));
Business: => Sbfedelq01oelineamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen84Month), Hist84MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen84Month), Hist84MTradeline.DPD01Amount));

Business: => Sbfedpd31amountoline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenolinecount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsOLine), UnknownDPD31AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsOLine), DPD31AmountAccount));
Business: => Sbfedelq31oelineamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen3Month), Hist03MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen3Month), Hist03MTradeline.DPD31Amount));
Business: => Sbfedelq31oelineamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen6Month), Hist06MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen6Month), Hist06MTradeline.DPD31Amount));
Business: => Sbfedelq31oelineamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen12Month), Hist12MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen12Month), Hist12MTradeline.DPD31Amount));
Business: => Sbfedelq31oelineamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen24Month), Hist24MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen24Month), Hist24MTradeline.DPD31Amount));
Business: => Sbfedelq31oelineamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen36Month), Hist36MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen36Month), Hist36MTradeline.DPD31Amount));
Business: => Sbfedelq31oelineamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen60Month), Hist60MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen60Month), Hist60MTradeline.DPD31Amount));
Business: => Sbfedelq31oelineamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen84Month), Hist84MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen84Month), Hist84MTradeline.DPD31Amount));

Business: => Sbfedpd61amountoline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenolinecount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsOLine), UnknownDPD61AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsOLine), DPD61AmountAccount));
Business: => Sbfedelq61oelineamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen3Month), Hist03MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen3Month), Hist03MTradeline.DPD61Amount));
Business: => Sbfedelq61oelineamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen6Month), Hist06MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen6Month), Hist06MTradeline.DPD61Amount));
Business: => Sbfedelq61oelineamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen12Month), Hist12MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen12Month), Hist12MTradeline.DPD61Amount));
Business: => Sbfedelq61oelineamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen24Month), Hist24MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen24Month), Hist24MTradeline.DPD61Amount));
Business: => Sbfedelq61oelineamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen36Month), Hist36MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen36Month), Hist36MTradeline.DPD61Amount));
Business: => Sbfedelq61oelineamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen60Month), Hist60MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen60Month), Hist60MTradeline.DPD61Amount));
Business: => Sbfedelq61oelineamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen84Month), Hist84MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen84Month), Hist84MTradeline.DPD61Amount));

Business: => Sbfedpd91amountoline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenolinecount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsOLine), UnknownDPD91AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsOLine), DPD91AmountAccount));
Business: => Sbfedelq91oelineamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen3Month), Hist03MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen3Month), Hist03MTradeline.DPD91Amount));
Business: => Sbfedelq91oelineamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen6Month), Hist06MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen6Month), Hist06MTradeline.DPD91Amount));
Business: => Sbfedelq91oelineamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen12Month), Hist12MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen12Month), Hist12MTradeline.DPD91Amount));
Business: => Sbfedelq91oelineamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen24Month), Hist24MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen24Month), Hist24MTradeline.DPD91Amount));
Business: => Sbfedelq91oelineamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen36Month), Hist36MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen36Month), Hist36MTradeline.DPD91Amount));
Business: => Sbfedelq91oelineamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen60Month), Hist60MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen60Month), Hist60MTradeline.DPD91Amount));
Business: => Sbfedelq91oelineamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen84Month), Hist84MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen84Month), Hist84MTradeline.DPD91Amount));
Business: => Sbfedpd121amountoline := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenolinecount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsOLine), UnknownDPD121AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsOLine), DPD121AmountAccount));
Business: => Sbfedelq121oelineamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen3Month), Hist03MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen3Month), Hist03MTradeline.DPD121Amount));
Business: => Sbfedelq121oelineamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen6Month), Hist06MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen6Month), Hist06MTradeline.DPD121Amount));
Business: => Sbfedelq121oelineamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen12Month), Hist12MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen12Month), Hist12MTradeline.DPD121Amount));
Business: => Sbfedelq121oelineamt24m :=MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen24Month), Hist24MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen24Month), Hist24MTradeline.DPD121Amount));
Business: => Sbfedelq121oelineamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen36Month), Hist36MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen36Month), Hist36MTradeline.DPD121Amount));
Business: => Sbfedelq121oelineamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen60Month), Hist60MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen60Month), Hist60MTradeline.DPD121Amount));
Business: => Sbfedelq121oelineamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenoelinecount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOLine AND IsOpen84Month), Hist84MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOLine AND IsOpen84Month), Hist84MTradeline.DPD121Amount));

Business: => Sbfedpd01amountother := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsOther), UnknownDPD01AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsOther), DPD01AmountAccount));
Business: => Sbfedelq01otheramt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen3Month), Hist03MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen3Month), Hist03MTradeline.DPD01Amount));
Business: => Sbfedelq01otheramt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen6Month), Hist06MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen6Month), Hist06MTradeline.DPD01Amount));
Business: => Sbfedelq01otheramt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen12Month), Hist12MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen12Month), Hist12MTradeline.DPD01Amount));
Business: => Sbfedelq01otheramt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen24Month), Hist24MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen24Month), Hist24MTradeline.DPD01Amount));
Business: => Sbfedelq01otheramt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen36Month), Hist36MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen36Month), Hist36MTradeline.DPD01Amount));
Business: => Sbfedelq01otheramt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen60Month), Hist60MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen60Month), Hist60MTradeline.DPD01Amount));
Business: => Sbfedelq01otheramt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen84Month), Hist84MTradeline.UnknownDPD01Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen84Month), Hist84MTradeline.DPD01Amount));

Business: => Sbfedpd31amountother := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsOther), UnknownDPD31AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsOther), DPD31AmountAccount));
Business: => Sbfedelq31otheramt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen3Month), Hist03MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen3Month), Hist03MTradeline.DPD31Amount));
Business: => Sbfedelq31otheramt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen6Month), Hist06MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen6Month), Hist06MTradeline.DPD31Amount));
Business: => Sbfedelq31otheramt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen12Month), Hist12MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen12Month), Hist12MTradeline.DPD31Amount));
Business: => Sbfedelq31otheramt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen24Month), Hist24MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen24Month), Hist24MTradeline.DPD31Amount));
Business: => Sbfedelq31otheramt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen36Month), Hist36MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen36Month), Hist36MTradeline.DPD31Amount));
Business: => Sbfedelq31otheramt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen60Month), Hist60MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen60Month), Hist60MTradeline.DPD31Amount));
Business: => Sbfedelq31otheramt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen84Month), Hist84MTradeline.UnknownDPD31Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen84Month), Hist84MTradeline.DPD31Amount));

Business: => Sbfedpd61amountother := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsOther), UnknownDPD61AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsOther), DPD61AmountAccount));
Business: => Sbfedelq61otheramt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen3Month), Hist03MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen3Month), Hist03MTradeline.DPD61Amount));
Business: => Sbfedelq61otheramt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen6Month), Hist06MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen6Month), Hist06MTradeline.DPD61Amount));
Business: => Sbfedelq61otheramt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen12Month), Hist12MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen12Month), Hist12MTradeline.DPD61Amount));
Business: => Sbfedelq61otheramt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen24Month), Hist24MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen24Month), Hist24MTradeline.DPD61Amount));
Business: => Sbfedelq61otheramt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen36Month), Hist36MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen36Month), Hist36MTradeline.DPD61Amount));
Business: => Sbfedelq61otheramt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen60Month), Hist60MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen60Month), Hist60MTradeline.DPD61Amount));
Business: => Sbfedelq61otheramt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen84Month), Hist84MTradeline.UnknownDPD61Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen84Month), Hist84MTradeline.DPD61Amount));

Business: => Sbfedpd91amountother := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsOther), UnknownDPD91AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsOther), DPD91AmountAccount));
Business: => Sbfedelq91otheramt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen3Month), Hist03MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen3Month), Hist03MTradeline.DPD91Amount));
Business: => Sbfedelq91otheramt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen6Month), Hist06MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen6Month), Hist06MTradeline.DPD91Amount));
Business: => Sbfedelq91otheramt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen12Month), Hist12MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen12Month), Hist12MTradeline.DPD91Amount));
Business: => Sbfedelq91otheramt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen24Month), Hist24MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen24Month), Hist24MTradeline.DPD91Amount));
Business: => Sbfedelq91otheramt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen36Month), Hist36MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen36Month), Hist36MTradeline.DPD91Amount));
Business: => Sbfedelq91otheramt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen60Month), Hist60MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen60Month), Hist60MTradeline.DPD91Amount));
Business: => Sbfedelq91otheramt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen84Month), Hist84MTradeline.UnknownDPD91Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen84Month), Hist84MTradeline.DPD91Amount));

Business: => Sbfedpd121amountother := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsOther), UnknownDPD121AmountAccount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOpen AND IsOther), DPD121AmountAccount));
Business: => Sbfedelq121otheramt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount03m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen3Month), Hist03MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen3Month), Hist03MTradeline.DPD121Amount));
Business: => Sbfedelq121otheramt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount06m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen6Month), Hist06MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen6Month), Hist06MTradeline.DPD121Amount));
Business: => Sbfedelq121otheramt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount12m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen12Month), Hist12MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen12Month), Hist12MTradeline.DPD121Amount));
Business: => Sbfedelq121otheramt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount24m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen24Month), Hist24MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen24Month), Hist24MTradeline.DPD121Amount));
Business: => Sbfedelq121otheramt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount36m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen36Month), Hist36MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen36Month), Hist36MTradeline.DPD121Amount));
Business: => Sbfedelq121otheramt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount60m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen60Month), Hist60MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen60Month), Hist60MTradeline.DPD121Amount));
Business: => Sbfedelq121otheramt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenothercount84m = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOther AND IsOpen84Month), Hist84MTradeline.UnknownDPD121Amount) => UNKNOWN_DATA,
																SUM(BusinessAccount.acc(IsOther AND IsOpen84Month), Hist84MTradeline.DPD121Amount));

Business: => Sbfedelq1amtpct := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenallcount = 0 => NO_DATA_AVAILABLE,
																Sbfedpd01amount = UNKNOWN_DATA OR Sbferecentbalanceall <= 0 => UNKNOWN_DATA,
																ROUND((Sbfedpd01amount/Sbferecentbalanceall)*100));
																
Business: => Sbfedelq1amtpct03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist03m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq01amt03m = UNKNOWN_DATA OR Sbfebalanceamt03m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq01amt03m / Sbfebalanceamt03m )*100));
Business: => Sbfedelq1amtpct06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist06m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq01amt06m = UNKNOWN_DATA OR Sbfebalanceamt06m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq01amt06m / Sbfebalanceamt06m )*100));
Business: => Sbfedelq1amtpct12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist12m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq01amt12m = UNKNOWN_DATA OR Sbfebalanceamt12m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq01amt12m / Sbfebalanceamt12m )*100));
Business: => Sbfedelq1amtpct24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist24m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq01amt24m = UNKNOWN_DATA OR Sbfebalanceamt24m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq01amt24m / Sbfebalanceamt24m )*100));
Business: => Sbfedelq1amtpct36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist36m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq01amt36m = UNKNOWN_DATA OR Sbfebalanceamt36m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq01amt36m / Sbfebalanceamt36m )*100));
Business: => Sbfedelq1amtpct60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist60m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq01amt60m = UNKNOWN_DATA OR Sbfebalanceamt60m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq01amt60m / Sbfebalanceamt60m )*100));
Business: => Sbfedelq1amtpct84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist84m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq01amt84m = UNKNOWN_DATA OR Sbfebalanceamt84m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq01amt84m / Sbfebalanceamt84m )*100));
																
Business: => Sbfedelq1revamtpct := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOpen AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsRevolvingAccount), UnknownDPD01AmountAccount OR NOT AccountBalance > 0) => UNKNOWN_DATA,
																ROUND((SUM(BusinessAccount.acc(IsOpen AND IsRevolvingAccount), DPD01AmountAccount)/Sbferecentbalancerevamt)*100));
																
Business: => Sbfedelq1instamtpct := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOpen AND IsInstallment)) = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsInstallment), UnknownDPD01AmountAccount OR NOT AccountBalance > 0) => UNKNOWN_DATA,
																ROUND((SUM(BusinessAccount.acc(IsOpen AND IsInstallment), DPD01AmountAccount)/Sbferecentbalanceinstamt)*100));

Business: => Sbfedelq31amtpct := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenallcount = 0 => NO_DATA_AVAILABLE,
																Sbfedpd31amount = UNKNOWN_DATA OR Sbferecentbalanceall <= 0 => UNKNOWN_DATA,
																ROUND((Sbfedpd31amount/Sbferecentbalanceall)*100));
Business: => Sbfedelq31amtpct03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist03m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq31amt03m = UNKNOWN_DATA OR Sbfebalanceamt03m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq31amt03m / Sbfebalanceamt03m )*100));
Business: => Sbfedelq31amtpct06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist06m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq31amt06m = UNKNOWN_DATA OR Sbfebalanceamt06m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq31amt06m / Sbfebalanceamt06m )*100));
Business: => Sbfedelq31amtpct12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist12m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq31amt12m = UNKNOWN_DATA OR Sbfebalanceamt12m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq31amt12m / Sbfebalanceamt12m )*100));
Business: => Sbfedelq31amtpct24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist24m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq31amt24m = UNKNOWN_DATA OR Sbfebalanceamt24m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq31amt24m / Sbfebalanceamt24m )*100));
Business: => Sbfedelq31amtpct36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist36m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq31amt36m = UNKNOWN_DATA OR Sbfebalanceamt36m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq31amt36m / Sbfebalanceamt36m )*100));
Business: => Sbfedelq31amtpct60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist60m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq31amt60m = UNKNOWN_DATA OR Sbfebalanceamt60m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq31amt60m / Sbfebalanceamt60m )*100));
Business: => Sbfedelq31amtpct84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist84m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq31amt84m = UNKNOWN_DATA OR Sbfebalanceamt84m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq31amt84m / Sbfebalanceamt84m )*100));
																
Business: => Sbfedelq31revamtpct := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOpen AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsRevolvingAccount), UnknownDPD31AmountAccount OR NOT AccountBalance > 0) => UNKNOWN_DATA,
																ROUND((SUM(BusinessAccount.acc(IsOpen AND IsRevolvingAccount), DPD31AmountAccount)/Sbferecentbalancerevamt)*100));
Business: => Sbfedelq31instamtpct := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOpen AND IsInstallment)) = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsInstallment), UnknownDPD31AmountAccount OR NOT AccountBalance > 0) => UNKNOWN_DATA,
																ROUND((SUM(BusinessAccount.acc(IsOpen AND IsInstallment), DPD31AmountAccount)/Sbferecentbalanceinstamt)*100));

Business: => Sbfedelq61amtpct := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenallcount = 0 => NO_DATA_AVAILABLE,
																Sbfedpd61amount = UNKNOWN_DATA OR Sbferecentbalanceall <= 0 => UNKNOWN_DATA,
																ROUND((Sbfedpd61amount/Sbferecentbalanceall)*100));
Business: => Sbfedelq61amtpct03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist03m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq61amt03m = UNKNOWN_DATA OR Sbfebalanceamt03m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq61amt03m / Sbfebalanceamt03m )*100));
Business: => Sbfedelq61amtpct06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist06m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq61amt06m = UNKNOWN_DATA OR Sbfebalanceamt06m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq61amt06m / Sbfebalanceamt06m )*100));
Business: => Sbfedelq61amtpct12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist12m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq61amt12m = UNKNOWN_DATA OR Sbfebalanceamt12m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq61amt12m / Sbfebalanceamt12m )*100));
Business: => Sbfedelq61amtpct24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist24m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq61amt24m = UNKNOWN_DATA OR Sbfebalanceamt24m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq61amt24m / Sbfebalanceamt24m )*100));
Business: => Sbfedelq61amtpct36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist36m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq61amt36m = UNKNOWN_DATA OR Sbfebalanceamt36m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq61amt36m / Sbfebalanceamt36m )*100));
Business: => Sbfedelq61amtpct60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist60m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq61amt60m = UNKNOWN_DATA OR Sbfebalanceamt60m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq61amt60m / Sbfebalanceamt60m )*100));
Business: => Sbfedelq61amtpct84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist84m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq61amt84m = UNKNOWN_DATA OR Sbfebalanceamt84m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq61amt84m / Sbfebalanceamt84m )*100));
																
Business: => Sbfedelq61revamtpct := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOpen AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsRevolvingAccount), UnknownDPD61AmountAccount OR NOT AccountBalance > 0) => UNKNOWN_DATA,
																ROUND((SUM(BusinessAccount.acc(IsOpen AND IsRevolvingAccount), DPD61AmountAccount)/Sbferecentbalancerevamt)*100));
Business: => Sbfedelq61instamtpct := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOpen AND IsInstallment)) = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsInstallment), UnknownDPD61AmountAccount OR NOT AccountBalance > 0) => UNKNOWN_DATA,
																ROUND((SUM(BusinessAccount.acc(IsOpen AND IsInstallment), DPD61AmountAccount)/Sbferecentbalanceinstamt)*100));
Business: => Sbfedelq91amtpct := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenallcount = 0 => NO_DATA_AVAILABLE,
																Sbfedpd91amount = UNKNOWN_DATA OR Sbferecentbalanceall <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedpd91amount/Sbferecentbalanceall)*100));
Business: => Sbfedelq91amtpct03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist03m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq91amt03m = UNKNOWN_DATA OR Sbfebalanceamt03m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq91amt03m / Sbfebalanceamt03m )*100));
Business: => Sbfedelq91amtpct06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist06m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq91amt06m = UNKNOWN_DATA OR Sbfebalanceamt06m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq91amt06m / Sbfebalanceamt06m )*100));
Business: => Sbfedelq91amtpct12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist12m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq91amt12m = UNKNOWN_DATA OR Sbfebalanceamt12m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq91amt12m / Sbfebalanceamt12m )*100));
Business: => Sbfedelq91amtpct24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist24m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq91amt24m = UNKNOWN_DATA OR Sbfebalanceamt24m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq91amt24m / Sbfebalanceamt24m )*100));
Business: => Sbfedelq91amtpct36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist36m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq91amt36m = UNKNOWN_DATA OR Sbfebalanceamt36m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq91amt36m / Sbfebalanceamt36m )*100));
Business: => Sbfedelq91amtpct60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist60m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq91amt60m = UNKNOWN_DATA OR Sbfebalanceamt60m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq91amt60m / Sbfebalanceamt60m )*100));
Business: => Sbfedelq91amtpct84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist84m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq91amt84m = UNKNOWN_DATA OR Sbfebalanceamt84m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq91amt84m / Sbfebalanceamt84m )*100));
Business: => Sbfedelq91revamtpct := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOpen AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsRevolvingAccount), UnknownDPD91AmountAccount OR NOT AccountBalance > 0) => UNKNOWN_DATA,
																ROUND((SUM(BusinessAccount.acc(IsOpen AND IsRevolvingAccount), DPD91AmountAccount)/Sbferecentbalancerevamt)*100));
Business: => Sbfedelq91instamtpct := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOpen AND IsInstallment)) = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsInstallment), UnknownDPD91AmountAccount OR NOT AccountBalance > 0) => UNKNOWN_DATA,
																ROUND((SUM(BusinessAccount.acc(IsOpen AND IsInstallment), DPD91AmountAccount)/Sbferecentbalanceinstamt)*100));

Business: => Sbfedelq121amtpct := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopenallcount = 0 => NO_DATA_AVAILABLE,
																Sbfedpd121amount = UNKNOWN_DATA OR Sbferecentbalanceall <= 0 => UNKNOWN_DATA,
																ROUND((Sbfedpd121amount/Sbferecentbalanceall)*100));
Business: => Sbfedelq121amtpct03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist03m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq121amt03m = UNKNOWN_DATA OR Sbfebalanceamt03m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq121amt03m / Sbfebalanceamt03m )*100));
Business: => Sbfedelq121amtpct06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist06m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq121amt06m = UNKNOWN_DATA OR Sbfebalanceamt06m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq121amt06m / Sbfebalanceamt06m )*100));
Business: => Sbfedelq121amtpct12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist12m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq121amt12m = UNKNOWN_DATA OR Sbfebalanceamt12m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq121amt12m / Sbfebalanceamt12m )*100));
Business: => Sbfedelq121amtpct24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist24m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq121amt24m = UNKNOWN_DATA OR Sbfebalanceamt24m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq121amt24m / Sbfebalanceamt24m )*100));
Business: => Sbfedelq121amtpct36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist36m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq121amt36m = UNKNOWN_DATA OR Sbfebalanceamt36m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq121amt36m / Sbfebalanceamt36m )*100));
Business: => Sbfedelq121amtpct60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist60m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq121amt60m = UNKNOWN_DATA OR Sbfebalanceamt60m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq121amt60m / Sbfebalanceamt60m )*100));
Business: => Sbfedelq121amtpct84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																Sbfeopencounthist84m = 0 => NO_DATA_AVAILABLE,
																Sbfedelq121amt84m = UNKNOWN_DATA OR Sbfebalanceamt84m <= 0 => UNKNOWN_DATA,
																ROUND(( Sbfedelq121amt84m / Sbfebalanceamt84m )*100));
Business: => Sbfedelq121revamtpct := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOpen AND IsRevolvingAccount)) = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsRevolvingAccount), UnknownDPD121AmountAccount OR NOT AccountBalance > 0) => UNKNOWN_DATA,
																ROUND((SUM(BusinessAccount.acc(IsOpen AND IsRevolvingAccount), DPD121AmountAccount)/Sbferecentbalancerevamt)*100));
Business: => Sbfedelq121instamtpct := MAP(BusinessNotOnFile => NOT_ON_FILE,
																COUNT(BusinessAccount.acc(IsOpen AND IsInstallment)) = 0 => NO_DATA_AVAILABLE,
																ALL(BusinessAccount.acc(IsOpen AND IsInstallment), UnknownDPD121AmountAccount OR NOT AccountBalance > 0) => UNKNOWN_DATA,
																ROUND((SUM(BusinessAccount.acc(IsOpen AND IsInstallment), DPD121AmountAccount)/Sbferecentbalanceinstamt)*100));


Business: => DPDAmountByMonth3 := BusinessAccount.acc.AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 3 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth6 := BusinessAccount.acc.AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 6 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth12 := BusinessAccount.acc.AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 12 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth24 := BusinessAccount.acc.AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 24 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth36 := BusinessAccount.acc.AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 36 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth60 := BusinessAccount.acc.AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 60 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth84 := BusinessAccount.acc.AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 84 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth := BusinessAccount.acc.AccountTradeline.trade(IsLastMonthlyReport AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };



Business: => Sbfedelqavgamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc.AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth3, DPDAmount)));
Business: => Sbfedpdaveamount06 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc.AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth6, DPDAmount)));
Business: => Sbfedpdaveamount12 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc.AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth12, DPDAmount)));
Business: => Sbfedpdaveamount24 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc.AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth24, DPDAmount)));
Business: => Sbfedpdaveamount36 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc.AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth36, DPDAmount)));
Business: => Sbfedpdaveamount60 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc.AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth60, DPDAmount)));
Business: => Sbfedpdaveamount84 := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc.AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth84, DPDAmount)));
Business: => Sbfedpdaveamountever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc.AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth, DPDAmount)));
							
							
Business: => DPDAmountByMonth3Loan := BusinessAccount.acc(IsLoan).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 3 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth6Loan := BusinessAccount.acc(IsLoan).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 6 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth12Loan := BusinessAccount.acc(IsLoan).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 12 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth24Loan := BusinessAccount.acc(IsLoan).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 24 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth36Loan := BusinessAccount.acc(IsLoan).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 36 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth60Loan := BusinessAccount.acc(IsLoan).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 60 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth84Loan := BusinessAccount.acc(IsLoan).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 84 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonthLoan := BusinessAccount.acc(IsLoan).AccountTradeline.trade(IsLastMonthlyReport AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
							
Business: => Sbfedelqloanavgamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth3Loan, DPDAmount)));
Business: => Sbfedelqloanavgamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth6Loan, DPDAmount)));
Business: => Sbfedelqloanavgamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth12Loan, DPDAmount)));
Business: => Sbfedelqloanavgamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth24Loan, DPDAmount)));
Business: => Sbfedelqloanavgamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth36Loan, DPDAmount)));
Business: => Sbfedelqloanavgamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth60Loan, DPDAmount)));
Business: => Sbfedelqloanavgamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth84Loan, DPDAmount)));
Business: => Sbfedelqloanavgamtever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLoan).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLoan).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonthLoan, DPDAmount)));

Business: => DPDAmountByMonth3Line := BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 3 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth6Line := BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 6 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth12Line := BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 12 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth24Line := BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 24 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth36Line := BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 36 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth60Line := BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 60 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth84Line := BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 84 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonthLine := BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
							
Business: => Sbfedelqlineavgamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth3Line, DPDAmount)));
Business: => Sbfedelqlineavgamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth6Line, DPDAmount)));
Business: => Sbfedelqlineavgamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth12Line, DPDAmount)));
Business: => Sbfedelqlineavgamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth24Line, DPDAmount)));
Business: => Sbfedelqlineavgamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth36Line, DPDAmount)));
Business: => Sbfedelqlineavgamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth60Line, DPDAmount)));
Business: => Sbfedelqlineavgamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth84Line, DPDAmount)));
Business: => Sbfedelqlineavgamtever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonthLine, DPDAmount)));

Business: => DPDAmountByMonth3Card := BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 3 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth6Card := BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 6 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth12Card := BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 12 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth24Card := BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 24 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth36Card := BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 36 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth60Card := BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 60 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth84Card := BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 84 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonthCard := BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
							
Business: => Sbfedelqcardavgamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth3Card, DPDAmount)));
Business: => Sbfedelqcardavgamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth6Card, DPDAmount)));
Business: => Sbfedelqcardavgamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth12Card, DPDAmount)));
Business: => Sbfedelqcardavgamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth24Card, DPDAmount)));
Business: => Sbfedelqcardavgamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth36Card, DPDAmount)));
Business: => Sbfedelqcardavgamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth60Card, DPDAmount)));
Business: => Sbfedelqcardavgamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth84Card, DPDAmount)));
Business: => Sbfedelqcardavgamtever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsCard).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonthCard, DPDAmount)));

Business: => DPDAmountByMonth3Lease := BusinessAccount.acc(IsLease).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 3 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth6Lease := BusinessAccount.acc(IsLease).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 6 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth12Lease := BusinessAccount.acc(IsLease).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 12 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth24Lease := BusinessAccount.acc(IsLease).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 24 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth36Lease := BusinessAccount.acc(IsLease).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 36 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth60Lease := BusinessAccount.acc(IsLease).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 60 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth84Lease := BusinessAccount.acc(IsLease).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 84 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonthLease := BusinessAccount.acc(IsLease).AccountTradeline.trade(IsLastMonthlyReport AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
							
Business: => Sbfedelqleaseavgamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth3Lease, DPDAmount)));
Business: => Sbfedelqleaseavgamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth6Lease, DPDAmount)));
Business: => Sbfedelqleaseavgamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth12Lease, DPDAmount)));
Business: => Sbfedelqleaseavgamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth24Lease, DPDAmount)));
Business: => Sbfedelqleaseavgamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth36Lease, DPDAmount)));
Business: => Sbfedelqleaseavgamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth60Lease, DPDAmount)));
Business: => Sbfedelqleaseavgamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth84Lease, DPDAmount)));
Business: => Sbfedelqleaseavgamtever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLease).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLease).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonthLease, DPDAmount)));

Business: => DPDAmountByMonth3Letter := BusinessAccount.acc(IsLetter).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 3 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth6Letter := BusinessAccount.acc(IsLetter).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 6 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth12Letter := BusinessAccount.acc(IsLetter).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 12 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth24Letter := BusinessAccount.acc(IsLetter).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 24 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth36Letter := BusinessAccount.acc(IsLetter).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 36 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth60Letter := BusinessAccount.acc(IsLetter).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 60 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth84Letter := BusinessAccount.acc(IsLetter).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 84 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonthLetter := BusinessAccount.acc(IsLetter).AccountTradeline.trade(IsLastMonthlyReport AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
							
Business: => Sbfedelqletteravgamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth3Letter, DPDAmount)));
Business: => Sbfedelqletteravgamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth6Letter, DPDAmount)));
Business: => Sbfedelqletteravgamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth12Letter, DPDAmount)));
Business: => Sbfedelqletteravgamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth24Letter, DPDAmount)));
Business: => Sbfedelqletteravgamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth36Letter, DPDAmount)));
Business: => Sbfedelqletteravgamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth60Letter, DPDAmount)));
Business: => Sbfedelqletteravgamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth84Letter, DPDAmount)));
Business: => Sbfedelqletteravgamtever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsLetter).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsLetter).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonthLetter, DPDAmount)));

Business: => DPDAmountByMonth3OLine := BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 3 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth6OLine := BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 6 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth12OLine := BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 12 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth24OLine := BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 24 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth36OLine := BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 36 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth60OLine := BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 60 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth84OLine := BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 84 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonthOLine := BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
							
Business: => Sbfedelqoelineavgamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth3OLine, DPDAmount)));
Business: => Sbfedelqoelineavgamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth6OLine, DPDAmount)));
Business: => Sbfedelqoelineavgamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth12OLine, DPDAmount)));
Business: => Sbfedelqoelineavgamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth24OLine, DPDAmount)));
Business: => Sbfedelqoelineavgamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth36OLine, DPDAmount)));
Business: => Sbfedelqoelineavgamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth60OLine, DPDAmount)));
Business: => Sbfedelqoelineavgamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth84OLine, DPDAmount)));
Business: => Sbfedelqoelineavgamtever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOLine).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonthOLine, DPDAmount)));

Business: => DPDAmountByMonth3Other := BusinessAccount.acc(IsOther).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 3 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth6Other := BusinessAccount.acc(IsOther).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 6 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth12Other := BusinessAccount.acc(IsOther).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 12 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth24Other := BusinessAccount.acc(IsOther).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 24 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth36Other := BusinessAccount.acc(IsOther).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 36 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth60Other := BusinessAccount.acc(IsOther).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 60 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonth84Other := BusinessAccount.acc(IsOther).AccountTradeline.trade(IsLastMonthlyReport, MONTHSBETWEEN(cycle_end_date,CurrentDateMonth) <= 84 AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
Business: => DPDAmountByMonthOther := BusinessAccount.acc(IsOther).AccountTradeline.trade(IsLastMonthlyReport AND GoodAverageDate){CycleEndMonth, DPDAmount := SUM(GROUP,PastDueAmount) };
							
Business: => Sbfedelqotheravgamt03m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is3Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth3Other, DPDAmount)));
Business: => Sbfedelqotheravgamt06m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is6Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth6Other, DPDAmount)));
Business: => Sbfedelqotheravgamt12m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is12Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth12Other, DPDAmount)));
Business: => Sbfedelqotheravgamt24m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is24Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth24Other, DPDAmount)));
Business: => Sbfedelqotheravgamt36m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is36Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth36Other, DPDAmount)));
Business: => Sbfedelqotheravgamt60m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is60Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth60Other, DPDAmount)));
Business: => Sbfedelqotheravgamt84m := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(Is84Month AND IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonth84Other, DPDAmount)));
Business: => Sbfedelqotheravgamtever := MAP(BusinessNotOnFile => NOT_ON_FILE,
																	 NOT EXISTS(BusinessAccount.acc(IsOther).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed)) => NO_DATA_AVAILABLE,
																	 ALL(BusinessAccount.acc(IsOther).AccountTradeline.trade(IsLastMonthlyReport AND NOT AccountClosed), PastDueAmount:Null) => UNKNOWN_DATA,
																	 ROUND(AVE(DPDAmountByMonthOther, DPDAmount)));




Business: => Sbfechargeoffloancount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			 Sbfeloancount=0 => NO_DATA_AVAILABLE,
																			 COUNT(BusinessAccount.acc(IsLoan AND IsChargeoff)));
Business: => Sbfechargeofflinecount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			 Sbfelinecount=0 => NO_DATA_AVAILABLE,
																			 COUNT(BusinessAccount.acc(IsLine AND IsChargeoff)));
Business: => Sbfechargeoffcardcount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			 Sbfecardcount=0 => NO_DATA_AVAILABLE,
																			 COUNT(BusinessAccount.acc(IsCard AND IsChargeoff)));
Business: => Sbfechargeoffleasecount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			 Sbfeleasecount=0 => NO_DATA_AVAILABLE,
																			 COUNT(BusinessAccount.acc(IsLease AND IsChargeoff)));
Business: => Sbfechargeofflettercount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			 Sbfelettercount=0 => NO_DATA_AVAILABLE,
																			 COUNT(BusinessAccount.acc(IsLetter AND IsChargeoff)));
Business: => Sbfechargeoffolinecount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			 Sbfeolinecount=0 => NO_DATA_AVAILABLE,
																			 COUNT(BusinessAccount.acc(IsOLine AND IsChargeoff)));
Business: => Sbfechargeoffothercount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			 Sbfeothercount=0 => NO_DATA_AVAILABLE,
																			 COUNT(BusinessAccount.acc(IsOther AND IsChargeoff)));

Business: => Sbfechargeoffloanamount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				Sbfechargeoffloancount<=0 => NO_DATA_AVAILABLE,
																				ALL(BusinessAccount.acc(IsLoan AND IsChargeoff), ChargeoffAmount:Null) => UNKNOWN_DATA,
																				SUM(BusinessAccount.acc(IsLoan AND IsChargeoff), ChargeoffAmount));
Business: => Sbfechargeofflineamount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				Sbfechargeofflinecount<=0 => NO_DATA_AVAILABLE,
																				ALL(BusinessAccount.acc(IsLine AND IsChargeoff), ChargeoffAmount:Null) => UNKNOWN_DATA,
																				SUM(BusinessAccount.acc(IsLine AND IsChargeoff), ChargeoffAmount));
Business: => Sbfechargeoffcardamount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				Sbfechargeoffcardcount<=0 => NO_DATA_AVAILABLE,
																				ALL(BusinessAccount.acc(IsCard AND IsChargeoff), ChargeoffAmount:Null) => UNKNOWN_DATA,
																				SUM(BusinessAccount.acc(IsCard AND IsChargeoff), ChargeoffAmount));
Business: => Sbfechargeoffleaseamount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				Sbfechargeoffleasecount<=0 => NO_DATA_AVAILABLE,
																				ALL(BusinessAccount.acc(IsLease AND IsChargeoff), ChargeoffAmount:Null) => UNKNOWN_DATA,
																				SUM(BusinessAccount.acc(IsLease AND IsChargeoff), ChargeoffAmount));
Business: => Sbfechargeoffletteramount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				Sbfechargeofflettercount<=0 => NO_DATA_AVAILABLE,
																				ALL(BusinessAccount.acc(IsLetter AND IsChargeoff), ChargeoffAmount:Null) => UNKNOWN_DATA,
																				SUM(BusinessAccount.acc(IsLetter AND IsChargeoff), ChargeoffAmount));
Business: => Sbfechargeoffolineamount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				Sbfechargeoffolinecount<=0 => NO_DATA_AVAILABLE,
																				ALL(BusinessAccount.acc(IsOLine AND IsChargeoff), ChargeoffAmount:Null) => UNKNOWN_DATA,
																				SUM(BusinessAccount.acc(IsOLine AND IsChargeoff), ChargeoffAmount));
Business: => Sbfechargeoffotheramount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				Sbfechargeoffothercount<=0 => NO_DATA_AVAILABLE,
																				ALL(BusinessAccount.acc(IsOther AND IsChargeoff), ChargeoffAmount:Null) => UNKNOWN_DATA,
																				SUM(BusinessAccount.acc(IsOther AND IsChargeoff), ChargeoffAmount));

Account: => MostRecentTradelineDate := MAX(AccountTradeline.trade, load_date);
//Account: => MostRecentTradeline := MAX(AccountTradeline.trade(load_date = Account.MostRecentTradelineDate));

//Account: => BalloonPaymentAmount := MostRecentTradeline.balloon_payment_due;
//Account: => BalloonPaymentDate := MostRecentTradeline.balloon_payment_due_date;

Account: => BalloonPaymentAmount := MAX(AccountTradeline.trade(load_date = Account.MostRecentTradelineDate), balloon_payment_due);
Account: => BalloonPaymentDate := MAX(AccountTradeline.trade(load_date = Account.MostRecentTradelineDate), balloon_payment_due_date);

Business: => Sbfeballooncount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																 Sbfeopenallcount=0 => NO_DATA_AVAILABLE,
																 COUNT(BusinessAccount.acc(NOT BalloonPaymentAmount:Null OR NOT BalloonPaymentDate:Null)));
Business: => Sbfeballoonpaymentamount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 NOT Sbfeballooncount>0 => NO_DATA_AVAILABLE,
																				 ALL(BusinessAccount.acc, BalloonPaymentAmount:Null) => UNKNOWN_DATA,
																				SUM(BusinessAccount.acc, BalloonPaymentAmount));
Business: => Sbfeballoonpaymentduedate := MAP(BusinessNotOnFile => NOT_ON_FILE,
																				 NOT Sbfeballooncount>0 => NO_DATA_AVAILABLE,
																				INTEGERFROMDATE(MIN(BusinessAccount.acc(BalloonPaymentDate > CURRENTDATE()), BalloonPaymentDate)));


Business: => MostRecentBusStructureDate := MAX(BusinessAccount.acc.AccountTradeline.trade(NOT legal_business_structure:Null), load_date);

Business: => Sbfefirmbusstructure := INTFORMAT(MAP(BusinessNotOnFile => NOT_ON_FILE,
																		MostRecentBusStructureDate:Null => UNKNOWN_DATA,
																		ONLY(BusinessAccount.acc.AccountTradeline.trade(load_date = Business.MostRecentBusStructureDate), legal_business_structure)),3,1);

/////SIC/NAICS waterfall//////////////
		//1. Primary
		//2. Most frequently reported
		//3. Most recently reported
		//4. Most recent account opened
		//5. Smallest code value
//////////////////////////////////////
Industry: => IsValidCode := MAP(IsSICCode => classification_code > 0 AND classification_code < 10000,
																IsNAICSCode => classification_code > 0 AND classification_code < 1000000,
																FALSE);
Industry: => IsSICCode := classification_code_type = 1;
Industry: => IsPrimary := primary_industry_code_indicator = 'Y';
Industry: => FrequencyCountSIC := COUNT(BusinessIndustry.bus.BusinessIndustry(industry.classification_code=Industry.classification_code AND industry.IsSICCode));
Business: => UsePrimarySIC := EXISTS(BusinessIndustry.industry(IsSICCode AND IsPrimary AND IsValidCode));
Industry: => IsGoodSIC := IF(EXISTS(BusinessIndustry.bus(UsePrimarySIC)), IsSICCode AND IsPrimary AND IsValidCode, IsSICCode AND IsValidCode); //Waterfall condition 1.
Business: => HighestFrequencySIC := MAX(BusinessIndustry.industry(IsGoodSIC), FrequencyCountSIC);
Industry: => IsHighestFrequencySIC := IsGoodSIC AND FrequencyCountSIC = MAX(BusinessIndustry.bus, HighestFrequencySIC); //Waterfall condition 2.

Business: => MostRecentSICDate := MAX(BusinessIndustry.industry(IsHighestFrequencySIC), dt_last_seen);
Industry: => IsMostRecentSIC := IsHighestFrequencySIC AND dt_last_seen = MAX(BusinessIndustry.bus, MostRecentSICDate); //Waterfall condition 3.

Industry: => DateAccountOpened := MAX(AccountIndustry.acc, DateAccountOpened);
Business: => MostRecentlyOpenedSIC := MAX(BusinessIndustry.industry(IsMostRecentSIC), DateAccountOpened);
Industry: => IsMostRecentlyOpenedSIC := IsMostRecentSIC AND DateAccountOpened = MAX(BusinessIndustry.bus,MostRecentlyOpenedSIC); //Waterfall condition 4.
Business: => Sbfesiccode := MAP(BusinessNotOnFile => NOT_ON_FILE,
														NOT EXISTS(BusinessIndustry.industry(IsMostRecentlyOpenedSIC)) => UNKNOWN_DATA,
														MIN(BusinessIndustry.industry(IsMostRecentlyOpenedSIC), classification_code)); //Waterfall condition 5.

//Repeat waterfall for NAICS
Industry: => IsNAICSCode := classification_code_type = 2;
Industry: => FrequencyCountNAICS := COUNT(BusinessIndustry.bus.BusinessIndustry(industry.classification_code=Industry.classification_code AND industry.IsNAICSCode));
Business: => UsePrimaryNAICS := EXISTS(BusinessIndustry.industry(IsNAICSCode AND IsPrimary AND IsValidCode));
Industry: => IsGoodNAICS := IF(EXISTS(BusinessIndustry.bus(UsePrimaryNAICS)), IsNAICSCode AND IsPrimary AND IsValidCode, IsNAICSCode AND IsValidCode);
Business: => HighestFrequencyNAICS := MAX(BusinessIndustry.industry(IsGoodNAICS), FrequencyCountNAICS);
Industry: => IsHighestFrequencyNAICS := IsGoodNAICS AND FrequencyCountNAICS = MAX(BusinessIndustry.bus, HighestFrequencyNAICS);
Business: => MostRecentNAICSDate := MAX(BusinessIndustry.industry(IsHighestFrequencyNAICS), dt_last_seen);
Industry: => IsMostRecentNAICS := IsHighestFrequencyNAICS AND dt_last_seen = MAX(BusinessIndustry.bus, MostRecentNAICSDate);

Business: => MostRecentlyOpenedNAICS := MAX(BusinessIndustry.industry(IsMostRecentNAICS), DateAccountOpened);
Industry: => IsMostRecentlyOpenedNAICS := IsMostRecentNAICS AND DateAccountOpened = MAX(BusinessIndustry.bus,MostRecentlyOpenedNAICS);
Business: => Sbfenaicscode := MAP(BusinessNotOnFile => NOT_ON_FILE,
															NOT EXISTS(BusinessIndustry.industry(IsMostRecentlyOpenedNAICS)) => UNKNOWN_DATA,
															MIN(BusinessIndustry.industry(IsMostRecentlyOpenedNAICS), classification_code));



Tradeline: => IsGovGuaranteed := government_guarantee_flag='Y' OR
																 government_guarantee_category > 0 OR
																 portion_of_account_guaranteed_by_government > 0;
Account: => IsGovGuaranteed := EXISTS(AccountTradeline.trade(IsGovGuaranteed));
Account: => UnknownGovGuarantee := NOT IsGovGuaranteed AND ALL(AccountTradeline.trade, government_guarantee_flag:Null);

Business: => Sbfegovguaranteecount := MAP(BusinessNotOnFile => NOT_ON_FILE,
																			Sbfeopenallcount = 0 => NO_DATA_AVAILABLE,
																			ALL(BusinessAccount.acc(IsOpen), UnknownGovGuarantee) => UNKNOWN_DATA,
																			COUNT(BusinessAccount.acc(IsOpen AND IsGovGuaranteed)));


//If tradelines has guarantor/principal info, use that, else use sum: IS + BS (number of unique names)

Account: => MostRecentTradelineGuarantorDate := MAX(AccountTradeline.trade(number_of_guarantors>0), load_date);
Account: => TradelineGuarantorCount := IF(MAX(AccountTradeline.trade(load_date = Account.MostRecentTradelineGuarantorDate), number_of_guarantors) > 0,
																		 MAX(AccountTradeline.trade(load_date = Account.MostRecentTradelineGuarantorDate), number_of_guarantors), 0);

Account: => MostRecentTradelinePrincipalDate := MAX(AccountTradeline.trade(number_of_principals>0), load_date);
Account: => TradelinePrincipalCount := IF(MAX(AccountTradeline.trade(load_date = Account.MostRecentTradelinePrincipalDate), number_of_principals) > 0,
																			MAX(AccountTradeline.trade(load_date = Account.MostRecentTradelinePrincipalDate), number_of_principals), 0);

IndividualOwner: => Name := TRIM(first_name) + ' ' + TRIM(last_name);
BusinessOwner: => Name := TRIM(business_name);

//owner_guarantor_indicator:
// 001 = owner
// 002 = guarantor
// 003 = both owner and guarantor

Account: => ISGuarantorCount := COUNT(AccountIndivOwner.owner(guarantor_owner_indicator IN [2,3]){Name});
Account: => BSGuarantorCount := COUNT(AccountBusOwner.owner(guarantor_owner_indicator IN [2,3]){Name});
Account: => GuarantorCount := IF(TradelineGuarantorCount > 0, TradelineGuarantorCount, ISGuarantorCount + BSGuarantorCount);

Account: => ISPrincipalCount := COUNT(AccountIndivOwner.owner(guarantor_owner_indicator IN [1,3]){Name});
Account: => BSPrincipalCount := COUNT(AccountBusOwner.owner(guarantor_owner_indicator IN [1,3]){Name});

Account: => PrincipalCount := IF(TradelinePrincipalCount > 0, TradelinePrincipalCount, ISPrincipalCount + BSPrincipalCount);
Business: => Sbfeguarantoraccountcount := IF(BusinessNotOnFile, NOT_ON_FILE, COUNT(BusinessAccount.acc(GuarantorCount>0)));
Business: => Sbfeguarantormincount := IF(BusinessNotOnFile, NOT_ON_FILE, MIN(BusinessAccount.acc, GuarantorCount));
Business: => Sbfeguarantormaxcount := IF(BusinessNotOnFile, NOT_ON_FILE, MAX(BusinessAccount.acc, GuarantorCount));
Business: => Sbfeprincipalaccountcount := IF(BusinessNotOnFile, NOT_ON_FILE, COUNT(BusinessAccount.acc(PrincipalCount>0)));
Business: => Sbfeprincipalmincount := IF(BusinessNotOnFile, NOT_ON_FILE, MIN(BusinessAccount.acc, PrincipalCount));
Business: => Sbfeprincipalmaxcount := IF(BusinessNotOnFile, NOT_ON_FILE, MAX(BusinessAccount.acc, PrincipalCount));


/////////// The following attributes are only calculated using a separate FDC bundle -- one that contains tradelines between CURRENTDATE() /////////
/////////// and a date 36 months in the future. Attributes are returned in SBFE_Future_Shell////////////////////////////////////////////////////////

Account: => WorstFuture6 := MAX(AccountTradeline.trade(MONTHSBETWEEN(CURRENTDATE(), load_date) < 6 AND load_date > CURRENTDATE() AND (date_account_was_charged_off:Null OR MONTHSBETWEEN(date_account_was_charged_off, CURRENTDATE())<6)), PaymentStatus);
Account: => WorstFuture12 := MAX(AccountTradeline.trade(MONTHSBETWEEN(CURRENTDATE(), load_date) < 12 AND load_date > CURRENTDATE() AND (date_account_was_charged_off:Null OR MONTHSBETWEEN(date_account_was_charged_off, CURRENTDATE())<12)), PaymentStatus);
Account: => WorstFuture18 := MAX(AccountTradeline.trade(MONTHSBETWEEN(CURRENTDATE(), load_date) < 18 AND load_date > CURRENTDATE() AND (date_account_was_charged_off:Null OR MONTHSBETWEEN(date_account_was_charged_off, CURRENTDATE())<18)), PaymentStatus);
Account: => WorstFuture24 := MAX(AccountTradeline.trade(MONTHSBETWEEN(CURRENTDATE(), load_date) < 24 AND load_date > CURRENTDATE() AND (date_account_was_charged_off:Null OR MONTHSBETWEEN(date_account_was_charged_off, CURRENTDATE())<24)), PaymentStatus);
Account: => WorstFuture36 := MAX(AccountTradeline.trade(MONTHSBETWEEN(CURRENTDATE(), load_date) < 36 AND load_date > CURRENTDATE() AND (date_account_was_charged_off:Null OR MONTHSBETWEEN(date_account_was_charged_off, CURRENTDATE())<36)), PaymentStatus);

Account: => UpdateFuture6 := EXISTS(AccountTradeline.trade(MONTHSBETWEEN(CURRENTDATE(), load_date ) < 6 AND load_date > CURRENTDATE()));
Account: => UpdateFuture12 := EXISTS(AccountTradeline.trade(MONTHSBETWEEN(CURRENTDATE(), load_date) < 12 AND load_date > CURRENTDATE()));
Account: => UpdateFuture18 := EXISTS(AccountTradeline.trade(MONTHSBETWEEN(CURRENTDATE(), load_date) < 18 AND load_date > CURRENTDATE()));
Account: => UpdateFuture24 := EXISTS(AccountTradeline.trade(MONTHSBETWEEN(CURRENTDATE(), load_date) < 24 AND load_date > CURRENTDATE()));
Account: => UpdateFuture36 := EXISTS(AccountTradeline.trade(MONTHSBETWEEN(CURRENTDATE(), load_date) < 36 AND load_date > CURRENTDATE()));

Business: => Sbfeinternalobservedperf06 := MAP(NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(load_date <= ADJUSTCALENDAR(CURRENTDATE(),0,6,0))) => NOT_ON_FILE,
																					 NOT EXISTS(BusinessAccount.acc(UpdateFuture6)) => NO_DATA_AVAILABLE,
																					 MAX(BusinessAccount.acc, WorstFuture6));
Business: => Sbfeinternalobservedperf12 := MAP(NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(load_date <= ADJUSTCALENDAR(CURRENTDATE(),0,12,0))) => NOT_ON_FILE,
																					 NOT EXISTS(BusinessAccount.acc(UpdateFuture12)) => NO_DATA_AVAILABLE,
																					 MAX(BusinessAccount.acc, WorstFuture12));
Business: => Sbfeinternalobservedperf18 := MAP(NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(load_date <= ADJUSTCALENDAR(CURRENTDATE(),0,18,0))) => NOT_ON_FILE,
																					 NOT EXISTS(BusinessAccount.acc(UpdateFuture18)) => NO_DATA_AVAILABLE,
																					 MAX(BusinessAccount.acc, WorstFuture18));
Business: => Sbfeinternalobservedperf24 := MAP(NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(load_date <= ADJUSTCALENDAR(CURRENTDATE(),0,24,0))) => NOT_ON_FILE,
																					 NOT EXISTS(BusinessAccount.acc(UpdateFuture24)) => NO_DATA_AVAILABLE,
																					 MAX(BusinessAccount.acc, WorstFuture24));
Business: => Sbfeinternalobservedperf36 := MAP(NOT EXISTS(BusinessAccount.acc.AccountTradeline.trade(load_date <= ADJUSTCALENDAR(CURRENTDATE(),0,36,0))) => NOT_ON_FILE,
																					 NOT EXISTS(BusinessAccount.acc(UpdateFuture36)) => NO_DATA_AVAILABLE,
																					 MAX(BusinessAccount.acc, WorstFuture36));

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



//QUERY: Dump <= Business{UID,/*CardBalance12Month, CardBalance24Month, CardUtilization12Month, CardUtilization24Month,Sbfedatefirstcycleall,Sbfedatelastcycleall,Sbfeaccountcount,Sbfedateopenfirstseenall,Sbfedateopenmostrecentall,*/
//								BusinessAccount.acc{/*sbfe_contributor_number,contract_account_number, account_type_reported,seq,MostRecentlyReportedLoadDate,DateAccountOpened, ultid, orgid, seleid, proxid, powid, empid, dotid,
//											dt_first_seen, dt_last_seen, dt_vendor_first_reported, dt_vendor_last_reported,
//											dt_datawarehouse_last_reported, did, did_score,*/TypeOfAcct,/*IsChargeoff,IsLoan, IsCard, IsOLine, HasClosed, IsStale, */IsOpen,/*Balance12Month,MostRecentTradelineDate,DPD01AmountAccount,MostRecentBalanceDate, 
//											AccountBalance, IsNullAccountBalance, CardBalance12Month, CardBalance24Month, IsOpenOneYear, IsOpenTwoYears,
//											AccountIndustry.industry{UID, record_type,
//									sbfe_contributor_number,contract_account_number,dt_last_seen, classification_code_type,classification_code,primary_industry_code_indicator,privacy_indicator},*/
//											AccountTradeline.trade{/*UID,DPD01Amount,current_credit_limit,AccountBalance,*/cycle_end_date,AccountClosed,Is6Month, Is12Month, Is24Month, Is36Month, Is60Month, Is84Month,
//							 /*,IsOneYearTradelineUtil,IsTwoYearTradelineUtil,IsOneYearTradeline,IsTwoYearTradeline, *//*IsClosed, PaymentStatus,Is6Month,UtilizationPercent,*/ remaining_balance, current_credit_limit, /*
//							 load_date,sbfe_contributor_number,contract_account_number,cycle_end_date,segment_identifier,file_segment_num,parent_sequence_number,accholder_businessname,dba,comp_website,*/
//							 /*legal_business_structure,busi_established_date,account_type_reported,account_status_1,account_status_2, date_account_opened,*/ date_account_closed,/*account_closure_basis,account_expiration_date,
//							 last_activity_date,lastactivitytype,recent_activity_indicator,original_credit_limit,highest_credit_used,reporterindicatorlength,payment_interval,
//							 payment_status_category,termofacc_months,firstpymtduedate,finalpymtduedate,origrate,floatingrate, graceperiod,paymentcategory,pymthistprofile12,pymthistprofile13_24,
//							 pymthistprofile25_36,pymthistprofile37_48,pymthistlength,ytd_purchasescount,ltd_purchasescount,ytd_purchasessumamt,ltd_purchasessumamt,payment_amount_scheduled,
//							 recent_payment_amount,recent_payment_date,remaining_balance,carriedoveramt,newappliedcharges,balloon_payment_due,balloon_payment_due_date,delinquency_date,days_delinquent,*/
//							 past_due_amount,/*maximum_number_of_past_due_aging_amounts_buckets_provided,past_due_aging_bucket_type,past_due_aging_amount_bucket_1,past_due_aging_amount_bucket_2,
//							 past_due_aging_amount_bucket_3,past_due_aging_amount_bucket_4,past_due_aging_amount_bucket_5,past_due_aging_amount_bucket_6,
//							 past_due_aging_amount_bucket_7,maximum_number_of_payment_tracking_cycle_periods_provided,payment_tracking_cycle_type,payment_tracking_cycle_0_current,
//							 payment_tracking_cycle_1_1_30_days,payment_tracking_cycle_2_31_60_days,payment_tracking_cycle_3_61_90_days,payment_tracking_cycle_4_91_120_days,
//							 payment_tracking_cycle_5_121_150days,payment_tracking_number_of_times_cycle_6_151_180_days,
//							 payment_tracking_number_of_times_cycle_7_181_or_greater_days,*/ date_account_was_charged_off/*, amount_charged_off_by_creditor,
//							 charge_off_type_indicator, total_charge_off_recoveries_to_date,government_guarantee_flag,government_guarantee_category,
//							 portion_of_account_guaranteed_by_government,guarantors_indicator,number_of_guarantors, owners_indicator,number_of_principals,account_update_deletion_indicator
//											}, AccountIndivOwner.owner{UID, guarantor_owner_indicator, Name}, AccountBusOwner.owner{UID, guarantor_owner_indicator, Name*/}}};

QUERY: Tradeline_dump <= Tradeline;

QUERY: SBFE_Future_Shell <= Business{UID,
															Sbfeinternalobservedperf06,
															Sbfeinternalobservedperf12,
															Sbfeinternalobservedperf18,
															Sbfeinternalobservedperf24,
															Sbfeinternalobservedperf36};

QUERY: SBFE_Shell <= Business{UID,
															//SBFEVer* fields calculated in Business_Risk_BIP.getSBFE
															Sbfedatefirstcycleall,
															Sbfetimeoldestcycle,
															Sbfedatelastcycleall,
															Sbfetimenewestcycle,															
															Sbfeaccountcount,
															Sbfeaccountcount12m,
															Sbfeopencount03m,															
															Sbfeopencount06month,
															Sbfeopencount12month,
															Sbfeopencount24month,
															Sbfeopencount36month,
															Sbfeopencount60month,
															Sbfeopencount84m,
															Sbfedateopenfirstseenall,
															Sbfetimeoldest,
															Sbfedateopenmostrecentall,
															Sbfetimenewest,
															Sbfedateclosedmostrecentall,
															Sbfetimenewestclosed,
															Sbfeloancount,
															Sbfedateopenfirstseenloan,
															Sbfetimeoldestloan,
															Sbfedateopenmostrecentloan,
															Sbfetimenewestloan,
															Sbfedateclosedmostrecentloan,
															Sbfetimenewestclosedloan,
															Sbfelinecount,
															Sbfedateopenfirstseenline,
															Sbfetimeoldestline,
															Sbfedateopenmostrecentline,
															Sbfetimenewestline,
															Sbfedateclosedmostrecentline,
															Sbfetimenewestclosedline,
															Sbfecardcount,
															Sbfedateopenfirstseencard,
															Sbfetimeoldestcard,
															Sbfedateopenmostrecentcard,
															Sbfetimenewestcard,
															Sbfedateclosedmostrecentcard,
															Sbfetimenewestclosedcard,
															Sbfeleasecount,
															Sbfedateopenfirstseenlease,
															Sbfetimeoldestlease,
															Sbfedateopenmostrecentlease,
															Sbfetimenewestlease,
															Sbfedateclosedmostrecentlease,
															Sbfetimenewestclosedlease,
															Sbfelettercount,
															Sbfedateopenfirstseenletter,
															Sbfetimeoldestletter,
															Sbfedateopenmostrecentletter,
															Sbfetimenewestletter,
															Sbfedateclosedmostrecentletter,
															Sbfetimenewestclosedletter,
															Sbfeolinecount,
															Sbfedateopenfirstseenoline,
															Sbfetimeoldestoeline,
															Sbfedateopenmostrecentoline,
															Sbfetimenewestoeline,
															Sbfedateclosedmostrecentoline,
															Sbfetimenewestclosedoeline,
															Sbfeothercount,
															Sbfedateopenfirstseenother,
															Sbfetimeoldestother,
															Sbfedateopenmostrecentother,
															Sbfetimenewestother,
															Sbfedateclosedmostrecentother,
															Sbfetimenewestclosedother,
															Sbfeopenallcount,
															Sbfeopencounthist03m,
															Sbfeopencounthist06m,
															Sbfeopencounthist12m, 
															Sbfeopencounthist24m, 
															Sbfeopencounthist36m,
															Sbfeopencounthist60m,
															Sbfeopencounthist84m,
															Sbfeopenloancount,
															Sbfeopenloancount03m,
															Sbfeopenloancount06m,
															Sbfeopenloancount12m,
															Sbfeopenloancount24m,
															Sbfeopenloancount36m,
															Sbfeopenloancount60m,
															Sbfeopenloancount84m,
															Sbfeopenlinecount,
															Sbfeopenlinecount03m,
															Sbfeopenlinecount06m,
															Sbfeopenlinecount12m,
															Sbfeopenlinecount24m,
															Sbfeopenlinecount36m,
															Sbfeopenlinecount60m,
															Sbfeopenlinecount84m,
															Sbfeopencardcount,
															Sbfeopencardcount03m,
															Sbfeopencardcount06m,
															Sbfeopencardcount12m,
															Sbfeopencardcount24m,
															Sbfeopencardcount36m,
															Sbfeopencardcount60m,
															Sbfeopencardcount84m,
															Sbfeopenleasecount,
															Sbfeopenleasecount03m,
															Sbfeopenleasecount06m,
															Sbfeopenleasecount12m,
															Sbfeopenleasecount24m,
															Sbfeopenleasecount36m,
															Sbfeopenleasecount60m,
															Sbfeopenleasecount84m,
															Sbfeopenlettercount,
															Sbfeopenlettercount03m,
															Sbfeopenlettercount06m,
															Sbfeopenlettercount12m,
															Sbfeopenlettercount24m,
															Sbfeopenlettercount36m,
															Sbfeopenlettercount60m,
															Sbfeopenlettercount84m,
															Sbfeopenolinecount,
															Sbfeopenoelinecount03m,
															Sbfeopenoelinecount06m,
															Sbfeopenoelinecount12m,
															Sbfeopenoelinecount24m,
															Sbfeopenoelinecount36m,
															Sbfeopenoelinecount60m,
															Sbfeopenoelinecount84m,
															Sbfeopenothercount,
															Sbfeopenothercount03m,
															Sbfeopenothercount06m,
															Sbfeopenothercount12m,
															Sbfeopenothercount24m,
															Sbfeopenothercount36m,
															Sbfeopenothercount60m,
															Sbfeopenothercount84m,
															Sbfeopentypecount,
															Sbfeopencardcountonly,
															Sbfeactivecount,
															Sbfeactiveloancount,
															Sbfeactivelinecount,
															Sbfeactivecardcount,
															Sbfeactiveleasecount,
															Sbfeactivelettercount,
															Sbfeactiveoline,
															Sbfeactiveothercount,
															Sbfeclosedcount,
															Sbfeclosedcountloan,
															Sbfeclosedcountline,
															Sbfeclosedcountcard,
															Sbfeclosedcountlease,
															Sbfeclosedcountletter,
															Sbfeclosedcountoline,
															Sbfeclosedcountother,
															Sbfeclosedcountinvoluntary,
															Sbfeclosedcountvoluntary,
															Sbfestaleclosedcount,
															Sbfestaleclosedcountloan,
															Sbfestaleclosedcountline,
															Sbfestaleclosedcountcard,
															Sbfestaleclosedcountlease,
															Sbfestaleclosedcountletter,
															Sbfestaleclosedcountoline,
															Sbfestaleclosedcountother,
															Sbfeinactivecount,
															Sbfeinactiveloancount,
															Sbfeinactivelinecount,
															Sbfeinactivecardcount,
															Sbfeinactiveleasecount,
															Sbfeinactivelettercount,
															Sbfeinactiveolinecount,
															Sbfeinactiveothercount,
															Sbferecentbalanceall,
															Sbferecentbalanceloan,
															Sbferecentbalanceline,
															Sbferecentbalancecard,
															Sbferecentbalancelease,
															Sbferecentbalanceletter,
															Sbferecentbalanceoline,
															Sbferecentbalanceother,
															Sbferecentbalancerevamt,
															Sbferecentbalanceinstamt,
															Sbfebalanceamt03m,
															Sbfebalanceamt06m,
															Sbfebalanceamt12m,
															Sbfebalanceamt24m,
															Sbfebalanceamt36m,
															Sbfebalanceamt60m,
															Sbfebalanceamt84m,
															Sbfebalanceamtloan03m,
															Sbfebalanceamtloan06m,
															Sbfebalanceamtloan12m,
															Sbfebalanceamtloan24m,
															Sbfebalanceamtloan36m,
															Sbfebalanceamtloan60m,
															Sbfebalanceamtloan84m,
															Sbfebalanceamtline03m,
															Sbfebalanceamtline06m,
															Sbfebalanceamtline12m,
															Sbfebalanceamtline24m,
															Sbfebalanceamtline36m,
															Sbfebalanceamtline60m,
															Sbfebalanceamtline84m,
															Sbfebalanceamtcard03m,
															Sbfebalanceamtcard06m,
															Sbfebalanceamtcard12m,
															Sbfebalanceamtcard24m,
															Sbfebalanceamtcard36m,
															Sbfebalanceamtcard60m,
															Sbfebalanceamtcard84m,
															Sbfebalanceamtlease03m,
															Sbfebalanceamtlease06m,
															Sbfebalanceamtlease12m,
															Sbfebalanceamtlease24m,
															Sbfebalanceamtlease36m,
															Sbfebalanceamtlease60m,
															Sbfebalanceamtlease84m,
															Sbfebalanceamtletter03m,
															Sbfebalanceamtletter06m,
															Sbfebalanceamtletter12m,
															Sbfebalanceamtletter24m,
															Sbfebalanceamtletter36m,
															Sbfebalanceamtletter60m,
															Sbfebalanceamtletter84m,
															Sbfebalanceamtoeline03m,
															Sbfebalanceamtoeline06m,
															Sbfebalanceamtoeline12m,
															Sbfebalanceamtoeline24m,
															Sbfebalanceamtoeline36m,
															Sbfebalanceamtoeline60m,
															Sbfebalanceamtoeline84m,
															Sbfebalanceamtother03m,
															Sbfebalanceamtother06m,
															Sbfebalanceamtother12m,
															Sbfebalanceamtother24m,
															Sbfebalanceamtother36m,
															Sbfebalanceamtother60m,
															Sbfebalanceamtother84m,
															Sbfeavgbalance03m,
															Sbfeavebalance06,
															Sbfeavebalance12,
															Sbfeavebalance24,
															Sbfeavebalance36,
															Sbfeavebalance60,
															Sbfeavebalance84,
															Sbfeavebalanceever,
															Sbfeavgbalanceloan03m,
															Sbfeavebalanceloan06,
															Sbfeavebalanceloan12,
															Sbfeavebalanceloan24,
															Sbfeavebalanceloan36,
															Sbfeavebalanceloan60,
															Sbfeavebalanceloan84,
															Sbfeavebalanceloanever,
															Sbfeavgbalanceline03m,
															Sbfeavebalanceline06,
															Sbfeavebalanceline12,
															Sbfeavebalanceline24,
															Sbfeavebalanceline36,
															Sbfeavebalanceline60,
															Sbfeavebalanceline84,
															Sbfeavebalancelineever,
															Sbfeavgbalancecard03m,
															Sbfeavebalancecard06,
															Sbfeavebalancecard12,
															Sbfeavebalancecard24,
															Sbfeavebalancecard36,
															Sbfeavebalancecard60,
															Sbfeavebalancecard84,
															Sbfeavebalancecardever,
															Sbfeavgbalancelease03m,
															Sbfeavebalancelease06,
															Sbfeavebalancelease12,
															Sbfeavebalancelease24,
															Sbfeavebalancelease36,
															Sbfeavebalancelease60,
															Sbfeavebalancelease84,
															Sbfeavebalanceleaseever,
															Sbfeavgbalanceletter03m,
															Sbfeavebalanceletter06,
															Sbfeavebalanceletter12,
															Sbfeavebalanceletter24,
															Sbfeavebalanceletter36,
															Sbfeavebalanceletter60,
															Sbfeavebalanceletter84,
															Sbfeavebalanceletterever,
															Sbfeavgbalanceoeline03m,
															Sbfeavebalanceoline06,
															Sbfeavebalanceoline12,
															Sbfeavebalanceoline24,
															Sbfeavebalanceoline36,
															Sbfeavebalanceoline60,
															Sbfeavebalanceoline84,
															Sbfeavebalanceolineever,
															Sbfeavgbalanceother03m,
															Sbfeavebalanceother06,
															Sbfeavebalanceother12,
															Sbfeavebalanceother24,
															Sbfeavebalanceother36,
															Sbfeavebalanceother60,
															Sbfeavebalanceother84,
															Sbfeavebalanceotherever,
															Sbfehighbalance03m,
															Sbfehighbalance06m,
															Sbfehighbalance12m,
															Sbfehighbalance24m,
															Sbfehighbalance36m,
															Sbfehighbalance60m,
															Sbfehighbalance84m,
															Sbfehighbalanceever,
															Sbfehighbalanceloan03m,
															Sbfehighbalanceloan06m,
															Sbfehighbalanceloan12m,
															Sbfehighbalanceloan24m,
															Sbfehighbalanceloan36m,
															Sbfehighbalanceloan60m,
															Sbfehighbalanceloan84m,
															Sbfehighbalanceloanever,
															Sbfehighbalanceline03m,
															Sbfehighbalanceline06m,
															Sbfehighbalanceline12m,
															Sbfehighbalanceline24m,
															Sbfehighbalanceline36m,
															Sbfehighbalanceline60m,
															Sbfehighbalanceline84m,
															Sbfehighbalancelineever,
															Sbfehighbalancecard03m,
															Sbfehighbalancecard06m,
															Sbfehighbalancecard12m,
															Sbfehighbalancecard24m,
															Sbfehighbalancecard36m,
															Sbfehighbalancecard60m,
															Sbfehighbalancecard84m,
															Sbfehighbalancecardever,
															Sbfehighbalancelease03m,
															Sbfehighbalancelease06m,
															Sbfehighbalancelease12m,
															Sbfehighbalancelease24m,
															Sbfehighbalancelease36m,
															Sbfehighbalancelease60m,
															Sbfehighbalancelease84m,
															Sbfehighbalanceleaseever,
															Sbfehighbalanceletter03m,
															Sbfehighbalanceletter06m,
															Sbfehighbalanceletter12m,
															Sbfehighbalanceletter24m,
															Sbfehighbalanceletter36m,
															Sbfehighbalanceletter60m,
															Sbfehighbalanceletter84m,
															Sbfehighbalanceletterever,
															Sbfehighbalanceoeline03m,
															Sbfehighbalanceoeline06m,
															Sbfehighbalanceoeline12m,
															Sbfehighbalanceoeline24m,
															Sbfehighbalanceoeline36m,
															Sbfehighbalanceoeline60m,
															Sbfehighbalanceoeline84m,
															Sbfehighbalanceoelineever,
															Sbfehighbalanceother03m,
															Sbfehighbalanceother06m,
															Sbfehighbalanceother12m,
															Sbfehighbalanceother24m,
															Sbfehighbalanceother36m,
															Sbfehighbalanceother60m,
															Sbfehighbalanceother84m,
															Sbfehighbalanceotherever,
															Sbfebalancecard12month,
															Sbfebalancecard24month,
															Sbfebalancecount,
															Sbfebalancecount03m,
															Sbfebalancecount06,
															Sbfebalancecount12,
															Sbfebalancecount24,
															Sbfebalancecount36,
															Sbfebalancecount60,
															Sbfebalancecount84,
															Sbfebalancecountever,
															Sbfebalancecountloan,
															Sbfebalanceloancount03m,
															Sbfebalancecountloan06,
															Sbfebalancecountloan12,
															Sbfebalancecountloan24,
															Sbfebalancecountloan36,
															Sbfebalancecountloan60,
															Sbfebalancecountloan84,
															Sbfebalancecountloanever,
															Sbfebalancecountline,
															Sbfebalancelinecount03m,
															Sbfebalancecountline06,
															Sbfebalancecountline12,
															Sbfebalancecountline24,
															Sbfebalancecountline36,
															Sbfebalancecountline60,
															Sbfebalancecountline84,
															Sbfebalancecountlineever,
															Sbfebalancecountcard,
															Sbfebalancecardcount03m,
															Sbfebalancecountcard06,
															Sbfebalancecountcard12,
															Sbfebalancecountcard24,
															Sbfebalancecountcard36,
															Sbfebalancecountcard60,
															Sbfebalancecountcard84,
															Sbfebalancecountcardever,
															Sbfebalancecountlease,
															Sbfebalanceleasecount03m,
															Sbfebalancecountlease06,
															Sbfebalancecountlease12,
															Sbfebalancecountlease24,
															Sbfebalancecountlease36,
															Sbfebalancecountlease60,
															Sbfebalancecountlease84,
															Sbfebalancecountleaseever,
															Sbfebalancecountletter,
															Sbfebalancelettercount03m,
															Sbfebalancecountletter06,
															Sbfebalancecountletter12,
															Sbfebalancecountletter24,
															Sbfebalancecountletter36,
															Sbfebalancecountletter60,
															Sbfebalancecountletter84,
															Sbfebalancecountletterever,
															Sbfebalancecountoline,
															Sbfebalanceoelinecount03m,
															Sbfebalancecountoline06,
															Sbfebalancecountoline12,
															Sbfebalancecountoline24,
															Sbfebalancecountoline36,
															Sbfebalancecountoline60,
															Sbfebalancecountoline84,
															Sbfebalancecountolineever,
															Sbfebalancecountother,
															Sbfebalanceothercount03m,
															Sbfebalancecountother06,
															Sbfebalancecountother12,
															Sbfebalancecountother24,
															Sbfebalancecountother36,
															Sbfebalancecountother60,
															Sbfebalancecountother84,
															Sbfebalancecountotherever,
															Sbfebalancecountclosed,
															Sbfebalanceclosedcount03m,
															Sbfebalanceclosedcount06m,
															Sbfebalanceclosedcount12month,
															Sbfebalanceclosedcount24m,
															Sbfeoriginallimitinstallment,
															Sbfeoriginallimitloan,
															Sbfeoriginallimitlease,
															Sbfecurrentlimitrevolving,
															Sbfelimitrevamt03m,
															Sbfelimitrevamt06m,
															Sbfelimitrevamt12m,
															Sbfelimitrevamt24m,
															Sbfelimitrevamt36m,
															Sbfelimitrevamt60m,
															Sbfelimitrevamt84m,
															Sbfecurrentlimitline,
															Sbfelimitlineamt03m,
															Sbfelimitlineamt06m,
															Sbfelimitlineamt12m,
															Sbfelimitlineamt24m,
															Sbfelimitlineamt36m,
															Sbfelimitlineamt60m,
															Sbfelimitlineamt84m,
															Sbfecurrentlimitcard,
															Sbfelimitcardamt03m,
															Sbfelimitcardamt06m,
															Sbfelimitcardamt12m,
															Sbfelimitcardamt24m,
															Sbfelimitcardamt36m,
															Sbfelimitcardamt60m,
															Sbfelimitcardamt84m,
															Sbfecurrentlimitoline,
															Sbfelimitoelineamt03m,
															Sbfelimitoelineamt06m,
															Sbfelimitoelineamt12m,
															Sbfelimitoelineamt24m,
															Sbfelimitoelineamt36m,
															Sbfelimitoelineamt60m,
															Sbfelimitoelineamt84m,
															Sbfescheduledall,
															Sbfescheduledloan,
															Sbfescheduledline,
															Sbfescheduledcard,
															Sbfescheduledlease,
															Sbfescheduledletter,
															Sbfescheduledoline,
															Sbfescheduledother,
															Sbfereceivedall,
															Sbfereceivedloan,
															Sbfereceivedline,
															Sbfereceivedcard,
															Sbfereceivedlease,
															Sbfereceivedletter,
															Sbfereceivedoline,
															Sbfereceivedother,
															Sbfeutilizationcurrentrevolving,
															Sbfeavailablecurrentrevolving,
															Sbfeutilrevolving03m,
															Sbfeutilrevolving06m,
															Sbfeutilrevolving12m,
															Sbfeutilrevolving24m,
															Sbfeutilrevolving36m,
															Sbfeutilrevolving60m,
															Sbfeutilrevolving84m,
															Sbfeutilizationcurrentline,
															Sbfeavailablecurrentline,
															Sbfeutilline03m,
															Sbfeutilline06m,
															Sbfeutilline12m,
															Sbfeutilline24m,
															Sbfeutilline36m,
															Sbfeutilline60m,
															Sbfeutilline84m,
															Sbfeutilizationcurrentcard,
															Sbfeavailablecurrentcard,
															Sbfeutilcard03m,
															Sbfeutilcard06m,
															Sbfeutilcard12m,
															Sbfeutilcard24m,
															Sbfeutilcard36m,
															Sbfeutilcard60m,
															Sbfeutilcard84m,
															Sbfeutilizationcurrentoline,
															Sbfeavailablecurrentoeline,
															Sbfeutiloeline03m,
															Sbfeutiloeline06m,
															Sbfeutiloeline12m,
															Sbfeutiloeline24m,
															Sbfeutiloeline36m,
															Sbfeutiloeline60m,
															Sbfeutiloeline84m,
															Sbfeutilization75revolvingcount,
															Sbfeutilization75line,
															Sbfeutilization75card,
															Sbfeutilization75oline,
															Sbfeutilization30revolving,
															Sbfeutilization30line,
															Sbfeutilization30card,
															Sbfeutilization30oline,
															Sbfeavgutil03m,
															Sbfeutilizationave06,
															Sbfeutilizationave12,
															Sbfeutilizationave24,
															Sbfeutilizationave36,
															Sbfeutilizationave60,
															Sbfeutilizationave84,
															Sbfeutilizationaveever,
															Sbfeavgutilline03m,
															Sbfeutilizationave06line,
															Sbfeutilizationave12line,
															Sbfeutilizationave24line,
															Sbfeutilizationave36line,
															Sbfeutilizationave60line,
															Sbfeutilizationave84line,
															Sbfeutilizationaveeverline,
															Sbfeavgutilcard03m,
															Sbfeutilizationave06card,
															Sbfeutilizationave12card,
															Sbfeutilizationave24card,
															Sbfeutilizationave36card,
															Sbfeutilizationave60card,
															Sbfeutilizationave84card,
															Sbfeutilizationaveevercard,
															Sbfeavgutiloeline03m,
															Sbfeutilizationave06oline,
															Sbfeutilizationave12oline,
															Sbfeutilizationave24oline,
															Sbfeutilizationave36oline,
															Sbfeutilizationave60oline,
															Sbfeutilizationave84oline,
															Sbfeutilizationaveeveroline,
															Sbfeutilizationhighrevolving,
															Sbfeutilizationhighline,
															Sbfeutilizationhighcard,
															Sbfeutilizationindexcard12month,
															Sbfeutilizationindexcard24month,
															Sbfeutiliztionhigholine,
															Sbfecurrentcount,
															Sbfeworstopen,
															Sbfehighdelq03m,
															Sbfeworst06,
															Sbfeworst12,
															Sbfeworst24,
															Sbfeworst36,
															Sbfeworst60,
															Sbfeworst84,
															Sbfeworstever,
															Sbfeworstloan,
															Sbfehighdelqloan03m,
															Sbfeworstloan06,
															Sbfeworstloan12,
															Sbfeworstloan24,
															Sbfeworstloan36,
															Sbfeworstloan60,
															Sbfeworstloan84,
															Sbfeworstloanever,
															Sbfeworstline,
															Sbfehighdelqline03m,
															Sbfeworstline06,
															Sbfeworstline12,
															Sbfeworstline24,
															Sbfeworstline36,
															Sbfeworstline60,
															Sbfeworstline84,
															Sbfeworstlineever,
															Sbfeworstcard,
															Sbfehighdelqcard03m,
															Sbfeworstcard06,
															Sbfeworstcard12,
															Sbfeworstcard24,
															Sbfeworstcard36,
															Sbfeworstcard60,
															Sbfeworstcard84,
															Sbfeworstcardever,
															Sbfeworstlease,
															Sbfehighdelqlease03m,
															Sbfeworstlease06,
															Sbfeworstlease12,
															Sbfeworstlease24,
															Sbfeworstlease36,
															Sbfeworstlease60,
															Sbfeworstlease84,
															Sbfeworstleaseever,
															Sbfeworstletter,
															Sbfehighdelqletter03m,
															Sbfeworstletter06,
															Sbfeworstletter12,
															Sbfeworstletter24,
															Sbfeworstletter36,
															Sbfeworstletter60,
															Sbfeworstletter84,
															Sbfeworstletterever,
															Sbfeworstoline,
															Sbfehighdelqoeline03m,
															Sbfeworstoline06,
															Sbfeworstoline12,
															Sbfeworstoline24,
															Sbfeworstoline36,
															Sbfeworstoline60,
															Sbfeworstoline84,
															Sbfeworstolineever,
															Sbfeworstother,
															Sbfehighdelqother03m,
															Sbfeworstother06,
															Sbfeworstother12,
															Sbfeworstother24,
															Sbfeworstother36,
															Sbfeworstother60,
															Sbfeworstother84,
															Sbfeworstotherever,
															Sbfehighdelqrevopen,
															Sbfehighdelqrev03m,
															Sbfehighdelqrev06m,
															Sbfehighdelqrev12m,
															Sbfehighdelqrev24m,
															Sbfehighdelqrev36m,
															Sbfehighdelqrev60m,
															Sbfehighdelqrev84m,
															Sbfehighdelqrevever,
															Sbfehighdelqinstopen,
															Sbfehighdelqinst03m,
															Sbfehighdelqinst06m,
															Sbfehighdelqinst12m,
															Sbfehighdelqinst24m,
															Sbfehighdelqinst36m,
															Sbfehighdelqinst60m,
															Sbfehighdelqinst84m,
															Sbfehighdelqinstever,
															Sbfesatisfactorycount,
															Sbfesatisfactorycountloan,
															Sbfesatisfactorycountline,
															Sbfesatisfactorycountcard,
															Sbfesatisfactorycountlease,
															Sbfesatisfactorycountletter,
															Sbfesatisfactorycountoline,
															Sbfesatisfactorycountother,
															Sbfedpddatelastseen,
															Sbfetimenewestdelq,
															Sbfedelq1countttl,
															Sbfedelq1countttlchargeoff,
															Sbfedpd1count,
															Sbfedelq1count03m,
															Sbfedpd1count06,
															Sbfedpd1count12,
															Sbfedpd1count24,
															Sbfedpd1count36,
															Sbfedpd1count60,
															Sbfedpd1count84,
															Sbfedpd1countever,
															Sbfedelq1counteverttl,
															Sbfedelq1loancount,
															Sbfedelq1loancount03m,
															Sbfedelq1loancount06m,
															Sbfedelq1loancount12m,
															Sbfedelq1loancount24m,
															Sbfedelq1loancount36m,
															Sbfedelq1loancount60m,
															Sbfedelq1loancount84m,
															Sbfedelq1loancountever,
															Sbfedelq1linecount,
															Sbfedelq1linecount03m,
															Sbfedelq1linecount06m,
															Sbfedelq1linecount12m,
															Sbfedelq1linecount24m,
															Sbfedelq1linecount36m,
															Sbfedelq1linecount60m,
															Sbfedelq1linecount84m,
															Sbfedelq1linecountever,
															Sbfedelq1cardcount,
															Sbfedelq1cardcount03m,
															Sbfedelq1cardcount06m,
															Sbfedelq1cardcount12m,
															Sbfedelq1cardcount24m,
															Sbfedelq1cardcount36m,
															Sbfedelq1cardcount60m,
															Sbfedelq1cardcount84m,
															Sbfedelq1cardcountever,
															Sbfedelq1leasecount,
															Sbfedelq1leasecount03m,
															Sbfedelq1leasecount06m,
															Sbfedelq1leasecount12m,
															Sbfedelq1leasecount24m,
															Sbfedelq1leasecount36m,
															Sbfedelq1leasecount60m,
															Sbfedelq1leasecount84m,
															Sbfedelq1leasecountever,
															Sbfedelq1lettercount,
															Sbfedelq1lettercount03m,
															Sbfedelq1lettercount06m,
															Sbfedelq1lettercount12m,
															Sbfedelq1lettercount24m,
															Sbfedelq1lettercount36m,
															Sbfedelq1lettercount60m,
															Sbfedelq1lettercount84m,
															Sbfedelq1lettercountever,
															Sbfedelq1oelinecount,
															Sbfedelq1oelinecount03m,
															Sbfedelq1oelinecount06m,
															Sbfedelq1oelinecount12m,
															Sbfedelq1oelinecount24m,
															Sbfedelq1oelinecount36m,
															Sbfedelq1oelinecount60m,
															Sbfedelq1oelinecount84m,
															Sbfedelq1oelinecountever,
															Sbfedelq1othercount,
															Sbfedelq1othercount03m,
															Sbfedelq1othercount06m,
															Sbfedelq1othercount12m,
															Sbfedelq1othercount24m,
															Sbfedelq1othercount36m,
															Sbfedelq1othercount60m,
															Sbfedelq1othercount84m,
															Sbfedelq1othercountever,
															Sbfedelq1leasecounteverttl,
															Sbfedelq1loancounteverttl,
															Sbfedelqlettercounteverttl,
															Sbfedelq1instcounteverttl,
															Sbfedelq1instcountever,
															Sbfedelq1instcountttl,
															Sbfedelq1instcountttlchargeoff,
															Sbfedelq1revcounteverttl,
															Sbfedelq1revcountever,
															Sbfedelq1revcountttl,
															Sbfedelq1revcountttlchargeoff,
															Sbfedelq31countttl,
															Sbfedelq31countttlchargeoff,
															Sbfedpd31count,
															Sbfedelq31count03m,
															Sbfedpd31count06,
															Sbfedpd31count12,
															Sbfedpd31count24,
															Sbfedpd31count36,
															Sbfedpd31count60,
															Sbfedpd31count84,
															Sbfedpd31countever,
															Sbfedelq31counteverttl,
															Sbfedpd31countloan,
															Sbfedelq31loancount03m,
															Sbfedpd31countloan06,
															Sbfedpd31countloan12,
															Sbfedpd31countloan24,
															Sbfedpd31countloan36,
															Sbfedpd31countloan60,
															Sbfedpd31countloan84,
															Sbfedpd31countloanever,
															Sbfedpd31countline,
															Sbfedelq31linecount03m,
															Sbfedpd31countline06,
															Sbfedpd31countline12,
															Sbfedpd31countline24,
															Sbfedpd31countline36,
															Sbfedpd31countline60,
															Sbfedpd31countline84,
															Sbfedpd31countlineever,
															Sbfedpd31countcard,
															Sbfedelq31cardcount03m,
															Sbfedpd31countcard06,
															Sbfedpd31countcard12,
															Sbfedpd31countcard24,
															Sbfedpd31countcard36,
															Sbfedpd31countcard60,
															Sbfedpd31countcard84,
															Sbfedpd31countcardever,
															Sbfedpd31countlease,
															Sbfedelq31leasecount03m,
															Sbfedpd31countlease06,
															Sbfedpd31countlease12,
															Sbfedpd31countlease24,
															Sbfedpd31countlease36,
															Sbfedpd31countlease60,
															Sbfedpd31countlease84,
															Sbfedpd31countleaseever,
															Sbfedpd31countletter,
															Sbfedelq31lettercount03m,
															Sbfedpd31countletter06,
															Sbfedpd31countletter12,
															Sbfedpd31countletter24,
															Sbfedpd31countletter36,
															Sbfedpd31countletter60,
															Sbfedpd31countletter84,
															Sbfedpd31countletterever,
															Sbfedpd31countoline,
															Sbfedelq31oelinecount03m,
															Sbfedpd31countoline06,
															Sbfedpd31countoline12,
															Sbfedpd31countoline24,
															Sbfedpd31countoline36,
															Sbfedpd31countoline60,
															Sbfedpd31countoline84,
															Sbfedpd31countolineever,
															Sbfedpd31countother,
															Sbfedelq31othercount03m,
															Sbfedpd31countother06,
															Sbfedpd31countother12,
															Sbfedpd31countother24,
															Sbfedpd31countother36,
															Sbfedpd31countother60,
															Sbfedpd31countother84,
															Sbfedpd31countotherever,
															Sbfedelq31instcountttl,
															Sbfedelq31instcountever,
															Sbfedelq31instcountttlchargeoff,
															Sbfedelq31revcounteverttl,
															Sbfedelq31revcountever,
															Sbfedelq31revcountttl,
															Sbfedelq31revcountttlchargeoff,
															Sbfedelq61countttl,
															Sbfedelq61countttlchargeoff,
															Sbfedelinquentcount,
															Sbfedelq61count03m,
															Sbfedelinquentcount06,
															Sbfedelinquentcount12,
															Sbfedelinquentcount24,
															Sbfedelinquentcount36,
															Sbfedelinquentcount60,
															Sbfedelinquentcount84,
															Sbfedelinquentcountever,
															Sbfedelq61counteverttl,
															Sbfedelinquentcountloan,
															Sbfedelq61loancount03m,
															Sbfedelinquentcountloan06,
															Sbfedelinquentcountloan12,
															Sbfedelinquentcountloan24,
															Sbfedelinquentcountloan36,
															Sbfedelinquentcountloan60,
															Sbfedelinquentcountloan84,
															Sbfedelinquentcountloanever,
															Sbfedelinquentcountline,
															Sbfedelq61linecount03m,
															Sbfedelinquentcountline06,
															Sbfedelinquentcountline12,
															Sbfedelinquentcountline24,
															Sbfedelinquentcountline36,
															Sbfedelinquentcountline60,
															Sbfedelinquentcountline84,
															Sbfedelinquentcountlineever,
															Sbfedelinquentcountcard,
															Sbfedelq61cardcount03m,
															Sbfedelinquentcountcard06,
															Sbfedelinquentcountcard12,
															Sbfedelinquentcountcard24,
															Sbfedelinquentcountcard36,
															Sbfedelinquentcountcard60,
															Sbfedelinquentcountcard84,
															Sbfedelinquentcountcardever,
															Sbfedelinquentcountlease,
															Sbfedelq61leasecount03m,
															Sbfedelinquentcountlease06,
															Sbfedelinquentcountlease12,
															Sbfedelinquentcountlease24,
															Sbfedelinquentcountlease36,
															Sbfedelinquentcountlease60,
															Sbfedelinquentcountlease84,
															Sbfedelinquentcountleaseever,
															Sbfedelinquentcountletter,
															Sbfedelq61lettercount03m,
															Sbfedelinquentcountletter06,
															Sbfedelinquentcountletter12,
															Sbfedelinquentcountletter24,
															Sbfedelinquentcountletter36,
															Sbfedelinquentcountletter60,
															Sbfedelinquentcountletter84,
															Sbfedelinquentcountletterever,
															Sbfedelinquentcountoline,
															Sbfedelq61oelinecount03m,
															Sbfedelinquentcountoline06,
															Sbfedelinquentcountoline12,
															Sbfedelinquentcountoline24,
															Sbfedelinquentcountoline36,
															Sbfedelinquentcountoline60,
															Sbfedelinquentcountoline84,
															Sbfedelinquentcountolineever,
															Sbfedelinquentcountother,
															Sbfedelq61othercount03m,
															Sbfedelinquentcountother06,
															Sbfedelinquentcountother12,
															Sbfedelinquentcountother24,
															Sbfedelinquentcountother36,
															Sbfedelinquentcountother60,
															Sbfedelinquentcountother84,
															Sbfedelinquentcountotherever,
															Sbfedelq61instcountttl,
															Sbfedelq61instcountever,
															Sbfedelq61instcountttlchargeoff,
															Sbfedelq61revcounteverttl,
															Sbfedelq61revcountever,
															Sbfedelq61revcountttl,
															Sbfedelq61revcountttlchargeoff,
															Sbfedelq91countttl,
															Sbfedelq91countttlchargeoff,
															Sbfedpd91count,
															Sbfedelq91count03m,
															Sbfedpd91count06,
															Sbfedpd91count12,
															Sbfedpd91count24,
															Sbfedpd91count36,
															Sbfedpd91count60,
															Sbfedpd91count84,
															Sbfedpd91countever,
															Sbfedpd91countloan,
															Sbfedelq91loancount03m,
															Sbfedpd91countloan06,
															Sbfedpd91countloan12,
															Sbfedpd91countloan24,
															Sbfedpd91countloan36,
															Sbfedpd91countloan60,
															Sbfedpd91countloan84,
															Sbfedpd91countloanever,
															Sbfedpd91countline,
															Sbfedelq91linecount03m,
															Sbfedpd91countline06,
															Sbfedpd91countline12,
															Sbfedpd91countline24,
															Sbfedpd91countline36,
															Sbfedpd91countline60,
															Sbfedpd91countline84,
															Sbfedpd91countlineever,
															Sbfedpd91countcard,
															Sbfedelq91cardcount03m,
															Sbfedpd91countcard06,
															Sbfedpd91countcard12,
															Sbfedpd91countcard24,
															Sbfedpd91countcard36,
															Sbfedpd91countcard60,
															Sbfedpd91countcard84,
															Sbfedpd91countcardever,
															Sbfedpd91countlease,
															Sbfedelq91leasecount03m,
															Sbfedpd91countlease06,
															Sbfedpd91countlease12,
															Sbfedpd91countlease24,
															Sbfedpd91countlease36,
															Sbfedpd91countlease60,
															Sbfedpd91countlease84,
															Sbfedpd91countleaseever,
															Sbfedpd91countletter,
															Sbfedelq91lettercount03m,
															Sbfedpd91countletter06,
															Sbfedpd91countletter12,
															Sbfedpd91countletter24,
															Sbfedpd91countletter36,
															Sbfedpd91countletter60,
															Sbfedpd91countletter84,
															Sbfedpd91countletterever,
															Sbfedpd91countoline,
															Sbfedelq91oelinecount03m,
															Sbfedpd91countoline06,
															Sbfedpd91countoline12,
															Sbfedpd91countoline24,
															Sbfedpd91countoline36,
															Sbfedpd91countoline60,
															Sbfedpd91countoline84,
															Sbfedpd91countolineever,
															Sbfedpd91countother,
															Sbfedelq91othercount03m,
															Sbfedpd91countother06,
															Sbfedpd91countother12,
															Sbfedpd91countother24,
															Sbfedpd91countother36,
															Sbfedpd91countother60,
															Sbfedpd91countother84,
															Sbfedpd91countotherever,
															Sbfedelq91instcountttl,
															Sbfedelq91instcountever,
															Sbfedelq91instcountttlchargeoff,
															Sbfedelq91revcounteverttl,
															Sbfedelq91revcountever,
															Sbfedelq91revcountttl,
															Sbfedelq91revcountttlchargeoff,
															Sbfedelq121countttlchargeoff,
															Sbfedpd121count,
															Sbfedelq121count03m,
															Sbfedpd121count06,
															Sbfedpd121count12,
															Sbfedpd121count24,
															Sbfedpd121count36,
															Sbfedpd121count60,
															Sbfedpd121count84,
															Sbfedpd121countever,
															Sbfedpd121countloan,
															Sbfedelq121loancount03m,
															Sbfedpd121countloan06,
															Sbfedpd121countloan12,
															Sbfedpd121countloan24,
															Sbfedpd121countloan36,
															Sbfedpd121countloan60,
															Sbfedpd121countloan84,
															Sbfedpd121countloanever,
															Sbfedpd121countline,
															Sbfedelq121linecount03m,
															Sbfedpd121countline06,
															Sbfedpd121countline12,
															Sbfedpd121countline24,
															Sbfedpd121countline36,
															Sbfedpd121countline60,
															Sbfedpd121countline84,
															Sbfedpd121countlineever,
															Sbfedpd121countcard,
															Sbfedelq121cardcount03m,
															Sbfedpd121countcard06,
															Sbfedpd121countcard12,
															Sbfedpd121countcard24,
															Sbfedpd121countcard36,
															Sbfedpd121countcard60,
															Sbfedpd121countcard84,
															Sbfedpd121countcardever,
															Sbfedpd121countlease,
															Sbfedelq121leasecount03m,
															Sbfedpd121countlease06,
															Sbfedpd121countlease12,
															Sbfedpd121countlease24,
															Sbfedpd121countlease36,
															Sbfedpd121countlease60,
															Sbfedpd121countlease84,
															Sbfedpd121countleaseever,
															Sbfedpd121countletter,
															Sbfedelq121lettercount03m,
															Sbfedpd121countletter06,
															Sbfedpd121countletter12,
															Sbfedpd121countletter24,
															Sbfedpd121countletter36,
															Sbfedpd121countletter60,
															Sbfedpd121countletter84,
															Sbfedpd121countletterever,
															Sbfedpd121countoline,
															Sbfedelq121oelinecount03m,
															Sbfedpd121countoline06,
															Sbfedpd121countoline12,
															Sbfedpd121countoline24,
															Sbfedpd121countoline36,
															Sbfedpd121countoline60,
															Sbfedpd121countoline84,
															Sbfedpd121countolineever,
															Sbfedpd121countother,
															Sbfedelq121othercount03m,
															Sbfedpd121countother06,
															Sbfedpd121countother12,
															Sbfedpd121countother24,
															Sbfedpd121countother36,
															Sbfedpd121countother60,
															Sbfedpd121countother84,
															Sbfedpd121countotherever,
															Sbfedelq121instcountever,
															Sbfedelq121instcountttlchargeoff,
															Sbfedelq121revcountever,
															Sbfedelq121revcountttlchargeoff,
															Sbfedelinquent31ratio,
															Sbfedelinquent31loanratio,
															Sbfedelinquent31lineratio,
															Sbfedelinquent31cardratio,
															Sbfedelinquent31leaseratio,
															Sbfedelinquent31letterratio,
															Sbfedelinquent31olineratio,
															Sbfedelinquent31otherratio,
															Sbfedelinquent61ratio,
															Sbfedelinquent61loanratio,
															Sbfedelinquent61lineratio,
															Sbfedelinquent61cardratio,
															Sbfedelinquent61leaseratio,
															Sbfedelinquent61letterratio,
															Sbfedelinquent61olineratio,
															Sbfedelinquent61otherratio,
															Sbfedelinquent91ratio,
															Sbfedelinquent91loanratio,
															Sbfedelinquent91lineratio,
															Sbfedelinquent91cardratio,
															Sbfedelinquent91leaseratio,
															Sbfedelinquent91letterratio,
															Sbfedelinquent91olineratio,
															Sbfedelinquent91otherratio,
															Sbfedelinquent121ratio,
															Sbfedelinquent121loanratio,
															Sbfedelinquent121lineratio,
															Sbfedelinquent121cardratio,
															Sbfedelinquent121leaseratio,
															Sbfedelinquent121letterratio,
															Sbfedelinquent121olineratio,
															Sbfedelinquent121otherratio,
															Sbfedelq1occurcount03m,
															Sbfedpd1occurcount06,
															Sbfedpd1occurcount12,
															Sbfedpd1occurcount24,
															Sbfedpd1occurcount36,
															Sbfedpd1occurcount60,
															Sbfedpd1occurcount84,
															Sbfedpd1occurcountever,
															Sbfedelq31occurcount03m,
															Sbfedpd31occurcount06,
															Sbfedpd31occurcount12,
															Sbfedpd31occurcount24,
															Sbfedpd31occurcount36,
															Sbfedpd31occurcount60,
															Sbfedpd31occurcount84,
															Sbfedpd31occurcountever,
															Sbfedelq31occurloancount03m,
															Sbfedpd31occurcountloan06,
															Sbfedpd31occurcountloan12,
															Sbfedpd31occurcountloan24,
															Sbfedpd31occurcountloan36,
															Sbfedpd31occurcountloan60,
															Sbfedpd31occurcountloan84,
															Sbfedpd31occurcountloanever,
															Sbfedelq31occurlinecount03m,
															Sbfedpd31occurcountline06,
															Sbfedpd31occurcountline12,
															Sbfedpd31occurcountline24,
															Sbfedpd31occurcountline36,
															Sbfedpd31occurcountline60,
															Sbfedpd31occurcountline84,
															Sbfedpd31occurcountlineever,
															Sbfedelq31occurcardcount03m,
															Sbfedpd31occurcountcard06,
															Sbfedpd31occurcountcard12,
															Sbfedpd31occurcountcard24,
															Sbfedpd31occurcountcard36,
															Sbfedpd31occurcountcard60,
															Sbfedpd31occurcountcard84,
															Sbfedpd31occurcountcardever,
															Sbfedelq31occurleasecount03m,
															Sbfedpd31occurcountlease06,
															Sbfedpd31occurcountlease12,
															Sbfedpd31occurcountlease24,
															Sbfedpd31occurcountlease36,
															Sbfedpd31occurcountlease60,
															Sbfedpd31occurcountlease84,
															Sbfedpd31occurcountleaseever,
															Sbfedelq31occurlettercount03m,
															Sbfedpd31occurcountletter06,
															Sbfedpd31occurcountletter12,
															Sbfedpd31occurcountletter24,
															Sbfedpd31occurcountletter36,
															Sbfedpd31occurcountletter60,
															Sbfedpd31occurcountletter84,
															Sbfedpd31occurcountletterever,
															Sbfedelq31occuroelinecount03m,
															Sbfedpd31occurcountoline06,
															Sbfedpd31occurcountoline12,
															Sbfedpd31occurcountoline24,
															Sbfedpd31occurcountoline36,
															Sbfedpd31occurcountoline60,
															Sbfedpd31occurcountoline84,
															Sbfedpd31occurcountolineever,
															Sbfedelq31occurothercount03m,
															Sbfedpd31occurcountother06,
															Sbfedpd31occurcountother12,
															Sbfedpd31occurcountother24,
															Sbfedpd31occurcountother36,
															Sbfedpd31occurcountother60,
															Sbfedpd31occurcountother84,
															Sbfedpd31occurcountotherever,
															Sbfedelq61occurcount03m,
															Sbfedpd61occurcount06,
															Sbfedpd61occurcount12,
															Sbfedpd61occurcount24,
															Sbfedpd61occurcount36,
															Sbfedpd61occurcount60,
															Sbfedpd61occurcount84,
															Sbfedpd61occurcountever,
															Sbfedelq61occurloancount03m,
															Sbfedpd61occurcountloan06,
															Sbfedpd61occurcountloan12,
															Sbfedpd61occurcountloan24,
															Sbfedpd61occurcountloan36,
															Sbfedpd61occurcountloan60,
															Sbfedpd61occurcountloan84,
															Sbfedpd61occurcountloanever,
															Sbfedelq61occurlinecount03m,
															Sbfedpd61occurcountline06,
															Sbfedpd61occurcountline12,
															Sbfedpd61occurcountline24,
															Sbfedpd61occurcountline36,
															Sbfedpd61occurcountline60,
															Sbfedpd61occurcountline84,
															Sbfedpd61occurcountlineever,
															Sbfedelq61occurcardcount03m,
															Sbfedpd61occurcountcard06,
															Sbfedpd61occurcountcard12,
															Sbfedpd61occurcountcard24,
															Sbfedpd61occurcountcard36,
															Sbfedpd61occurcountcard60,
															Sbfedpd61occurcountcard84,
															Sbfedpd61occurcountcardever,
															Sbfedelq61occurleasecount03m,
															Sbfedpd61occurcountlease06,
															Sbfedpd61occurcountlease12,
															Sbfedpd61occurcountlease24,
															Sbfedpd61occurcountlease36,
															Sbfedpd61occurcountlease60,
															Sbfedpd61occurcountlease84,
															Sbfedpd61occurcountleaseever,
															Sbfedelq61occurlettercount03m,
															Sbfedpd61occurcountletter06,
															Sbfedpd61occurcountletter12,
															Sbfedpd61occurcountletter24,
															Sbfedpd61occurcountletter36,
															Sbfedpd61occurcountletter60,
															Sbfedpd61occurcountletter84,
															Sbfedpd61occurcountletterever,
															Sbfedelq61occuroelinecount03m,
															Sbfedpd61occurcountoline06,
															Sbfedpd61occurcountoline12,
															Sbfedpd61occurcountoline24,
															Sbfedpd61occurcountoline36,
															Sbfedpd61occurcountoline60,
															Sbfedpd61occurcountoline84,
															Sbfedpd61occurcountolineever,
															Sbfedelq61occurothercount03m,
															Sbfedpd61occurcountother06,
															Sbfedpd61occurcountother12,
															Sbfedpd61occurcountother24,
															Sbfedpd61occurcountother36,
															Sbfedpd61occurcountother60,
															Sbfedpd61occurcountother84,
															Sbfedpd61occurcountotherever,
															Sbfedelq91occurcount03m,
															Sbfedpd91occurcount06,
															Sbfedpd91occurcount12,
															Sbfedpd91occurcount24,
															Sbfedpd91occurcount36,
															Sbfedpd91occurcount60,
															Sbfedpd91occurcount84,
															Sbfedpd91occurcountever,
															Sbfedelq91occurloancount03m,
															Sbfedpd91occurcountloan06,
															Sbfedpd91occurcountloan12,
															Sbfedpd91occurcountloan24,
															Sbfedpd91occurcountloan36,
															Sbfedpd91occurcountloan60,
															Sbfedpd91occurcountloan84,
															Sbfedpd91occurcountloanever,
															Sbfedelq91occurlinecount03m,
															Sbfedpd91occurcountline06,
															Sbfedpd91occurcountline12,
															Sbfedpd91occurcountline24,
															Sbfedpd91occurcountline36,
															Sbfedpd91occurcountline60,
															Sbfedpd91occurcountline84,
															Sbfedpd91occurcountlineever,
															Sbfedelq91occurcardcount03m,
															Sbfedpd91occurcountcard06,
															Sbfedpd91occurcountcard12,
															Sbfedpd91occurcountcard24,
															Sbfedpd91occurcountcard36,
															Sbfedpd91occurcountcard60,
															Sbfedpd91occurcountcard84,
															Sbfedpd91occurcountcardever,
															Sbfedelq91occurleasecount03m,
															Sbfedpd91occurcountlease06,
															Sbfedpd91occurcountlease12,
															Sbfedpd91occurcountlease24,
															Sbfedpd91occurcountlease36,
															Sbfedpd91occurcountlease60,
															Sbfedpd91occurcountlease84,
															Sbfedpd91occurcountleaseever,
															Sbfedelq91occurlettercount03m,
															Sbfedpd91occurcountletter06,
															Sbfedpd91occurcountletter12,
															Sbfedpd91occurcountletter24,
															Sbfedpd91occurcountletter36,
															Sbfedpd91occurcountletter60,
															Sbfedpd91occurcountletter84,
															Sbfedpd91occurcountletterever,
															Sbfedelq91occuroelinecount03m,
															Sbfedpd91occurcountoline06,
															Sbfedpd91occurcountoline12,
															Sbfedpd91occurcountoline24,
															Sbfedpd91occurcountoline36,
															Sbfedpd91occurcountoline60,
															Sbfedpd91occurcountoline84,
															Sbfedpd91occurcountolineever,
															Sbfedelq91occurothercount03m,
															Sbfedpd91occurcountother06,
															Sbfedpd91occurcountother12,
															Sbfedpd91occurcountother24,
															Sbfedpd91occurcountother36,
															Sbfedpd91occurcountother60,
															Sbfedpd91occurcountother84,
															Sbfedpd91occurcountotherever,
															Sbfedelq121occurcount03m,
															Sbfedpd121occurcount06,
															Sbfedpd121occurcount12,
															Sbfedpd121occurcount24,
															Sbfedpd121occurcount36,
															Sbfedpd121occurcount60,
															Sbfedpd121occurcount84,
															Sbfedpd121occurcountever,
															Sbfedelq121occurloancount03m,
															Sbfedpd121occurcountloan06,
															Sbfedpd121occurcountloan12,
															Sbfedpd121occurcountloan24,
															Sbfedpd121occurcountloan36,
															Sbfedpd121occurcountloan60,
															Sbfedpd121occurcountloan84,
															Sbfedpd121occurcountloanever,
															Sbfedelq121occurlinecount03m,
															Sbfedpd121occurcountline06,
															Sbfedpd121occurcountline12,
															Sbfedpd121occurcountline24,
															Sbfedpd121occurcountline36,
															Sbfedpd121occurcountline60,
															Sbfedpd121occurcountline84,
															Sbfedpd121occurcountlineever,
															Sbfedelq121occurcardcount03m,
															Sbfedpd121occurcountcard06,
															Sbfedpd121occurcountcard12,
															Sbfedpd121occurcountcard24,
															Sbfedpd121occurcountcard36,
															Sbfedpd121occurcountcard60,
															Sbfedpd121occurcountcard84,
															Sbfedpd121occurcountcardever,
															Sbfedelq121occurleasecount03m,
															Sbfedpd121occurcountlease06,
															Sbfedpd121occurcountlease12,
															Sbfedpd121occurcountlease24,
															Sbfedpd121occurcountlease36,
															Sbfedpd121occurcountlease60,
															Sbfedpd121occurcountlease84,
															Sbfedpd121occurcountleaseever,
															Sbfedelq121occurlettercount03m,
															Sbfedpd121occurcountletter06,
															Sbfedpd121occurcountletter12,
															Sbfedpd121occurcountletter24,
															Sbfedpd121occurcountletter36,
															Sbfedpd121occurcountletter60,
															Sbfedpd121occurcountletter84,
															Sbfedpd121occurcountletterever,
															Sbfedelq121occuroelinecount03m,
															Sbfedpd121occurcountoline06,
															Sbfedpd121occurcountoline12,
															Sbfedpd121occurcountoline24,
															Sbfedpd121occurcountoline36,
															Sbfedpd121occurcountoline60,
															Sbfedpd121occurcountoline84,
															Sbfedpd121occurcountolineever,
															Sbfedelq121occurothercount03m,
															Sbfedpd121occurcountother06,
															Sbfedpd121occurcountother12,
															Sbfedpd121occurcountother24,
															Sbfedpd121occurcountother36,
															Sbfedpd121occurcountother60,
															Sbfedpd121occurcountother84,
															Sbfedpd121occurcountotherever,
															Sbfedpdamount,
															Sbfedelq01amtttl,
															Sbfedpd01amount,
															Sbfedelq01amt03m,
															Sbfedelq01amt06m,
															Sbfedelq01amt12m,
															Sbfedelq01amt24m,
															Sbfedelq01amt36m,
															Sbfedelq01amt60m,
															Sbfedelq01amt84m,
															Sbfedpd31amount,
															Sbfedelq31amtttl,
															Sbfedelq31amt03m,
															Sbfedelq31amt06m,
															Sbfedelq31amt12m,
															Sbfedelq31amt24m,
															Sbfedelq31amt36m,
															Sbfedelq31amt60m,
															Sbfedelq31amt84m,
															Sbfedpd61amount,
															Sbfedelq61amtttl,
															Sbfedelq61amt03m,
															Sbfedelq61amt06m,
															Sbfedelq61amt12m,
															Sbfedelq61amt24m,
															Sbfedelq61amt36m,
															Sbfedelq61amt60m,
															Sbfedelq61amt84m,
															Sbfedpd91amount,
															Sbfedelq91amtttl,
															Sbfedelq91amt03m,
															Sbfedelq91amt06m,
															Sbfedelq91amt12m,
															Sbfedelq91amt24m,
															Sbfedelq91amt36m,
															Sbfedelq91amt60m,
															Sbfedelq91amt84m,
															Sbfedpd121amount,
															Sbfedelq121amt03m,
															Sbfedelq121amt06m,
															Sbfedelq121amt12m,
															Sbfedelq121amt24m,
															Sbfedelq121amt36m,
															Sbfedelq121amt60m,
															Sbfedelq121amt84m,
															Sbfedpdamountloan,
															Sbfedpd01amountloan,
															Sbfedelq01loanamt03m,
															Sbfedelq01loanamt06m,
															Sbfedelq01loanamt12m,
															Sbfedelq01loanamt24m,
															Sbfedelq01loanamt36m,
															Sbfedelq01loanamt60m,
															Sbfedelq01loanamt84m,
															Sbfedpd31amountloan,
															Sbfedelq31loanamt03m,
															Sbfedelq31loanamt06m,
															Sbfedelq31loanamt12m,
															Sbfedelq31loanamt24m,
															Sbfedelq31loanamt36m,
															Sbfedelq31loanamt60m,
															Sbfedelq31loanamt84m,
															Sbfedpd61amountloan,
															Sbfedelq61loanamt03m,
															Sbfedelq61loanamt06m,
															Sbfedelq61loanamt12m,
															Sbfedelq61loanamt24m,
															Sbfedelq61loanamt36m,
															Sbfedelq61loanamt60m,
															Sbfedelq61loanamt84m,
															Sbfedpd91amountloan,
															Sbfedelq91loanamt03m,
															Sbfedelq91loanamt06m,
															Sbfedelq91loanamt12m,
															Sbfedelq91loanamt24m,
															Sbfedelq91loanamt36m,
															Sbfedelq91loanamt60m,
															Sbfedelq91loanamt84m,
															Sbfedpd121amountloan,
															Sbfedelq121loanamt03m,
															Sbfedelq121loanamt06m,
															Sbfedelq121loanamt12m,
															Sbfedelq121loanamt24m,
															Sbfedelq121loanamt36m,
															Sbfedelq121loanamt60m,
															Sbfedelq121loanamt84m,
															Sbfedpdamountline,
															Sbfedpd01amountline,
															Sbfedelq01lineamt03m,
															Sbfedelq01lineamt06m,
															Sbfedelq01lineamt12m,
															Sbfedelq01lineamt24m,
															Sbfedelq01lineamt36m,
															Sbfedelq01lineamt60m,
															Sbfedelq01lineamt84m,
															Sbfedpd31amountline,
															Sbfedelq31lineamt03m,
															Sbfedelq31lineamt06m,
															Sbfedelq31lineamt12m,
															Sbfedelq31lineamt24m,
															Sbfedelq31lineamt36m,
															Sbfedelq31lineamt60m,
															Sbfedelq31lineamt84m,
															Sbfedpd61amountline,
															Sbfedelq61lineamt03m,
															Sbfedelq61lineamt06m,
															Sbfedelq61lineamt12m,
															Sbfedelq61lineamt24m,
															Sbfedelq61lineamt36m,
															Sbfedelq61lineamt60m,
															Sbfedelq61lineamt84m,
															Sbfedpd91amountline,
															Sbfedelq91lineamt03m,
															Sbfedelq91lineamt06m,
															Sbfedelq91lineamt12m,
															Sbfedelq91lineamt24m,
															Sbfedelq91lineamt36m,
															Sbfedelq91lineamt60m,
															Sbfedelq91lineamt84m,
															Sbfedpd121amountline,
															Sbfedelq121lineamt03m,
															Sbfedelq121lineamt06m,
															Sbfedelq121lineamt12m,
															Sbfedelq121lineamt24m,
															Sbfedelq121lineamt36m,
															Sbfedelq121lineamt60m,
															Sbfedelq121lineamt84m,
															Sbfedpdamountcard,
															Sbfedpd01amountcard,
															Sbfedelq01cardamt03m,
															Sbfedelq01cardamt06m,
															Sbfedelq01cardamt12m,
															Sbfedelq01cardamt24m,
															Sbfedelq01cardamt36m,
															Sbfedelq01cardamt60m,
															Sbfedelq01cardamt84m,
															Sbfedpd31amountcard,
															Sbfedelq31cardamt03m,
															Sbfedelq31cardamt06m,
															Sbfedelq31cardamt12m,
															Sbfedelq31cardamt24m,
															Sbfedelq31cardamt36m,
															Sbfedelq31cardamt60m,
															Sbfedelq31cardamt84m,
															Sbfedpd61amountcard,
															Sbfedelq61cardamt03m,
															Sbfedelq61cardamt06m,
															Sbfedelq61cardamt12m,
															Sbfedelq61cardamt24m,
															Sbfedelq61cardamt36m,
															Sbfedelq61cardamt60m,
															Sbfedelq61cardamt84m,
															Sbfedpd91amountcard,
															Sbfedelq91cardamt03m,
															Sbfedelq91cardamt06m,
															Sbfedelq91cardamt12m,
															Sbfedelq91cardamt24m,
															Sbfedelq91cardamt36m,
															Sbfedelq91cardamt60m,
															Sbfedelq91cardamt84m,
															Sbfedpd121amountcard,
															Sbfedelq121cardamt03m,
															Sbfedelq121cardamt06m,
															Sbfedelq121cardamt12m,
															Sbfedelq121cardamt24m,
															Sbfedelq121cardamt36m,
															Sbfedelq121cardamt60m,
															Sbfedelq121cardamt84m,
															Sbfedpdamountlease,
															Sbfedpd01amountlease,
															Sbfedelq01leaseamt03m,
															Sbfedelq01leaseamt06m,
															Sbfedelq01leaseamt12m,
															Sbfedelq01leaseamt24m,
															Sbfedelq01leaseamt36m,
															Sbfedelq01leaseamt60m,
															Sbfedelq01leaseamt84m,
															Sbfedpd31amountlease,
															Sbfedelq31leaseamt03m,
															Sbfedelq31leaseamt06m,
															Sbfedelq31leaseamt12m,
															Sbfedelq31leaseamt24m,
															Sbfedelq31leaseamt36m,
															Sbfedelq31leaseamt60m,
															Sbfedelq31leaseamt84m,
															Sbfedpd61amountlease,
															Sbfedelq61leaseamt03m,
															Sbfedelq61leaseamt06m,
															Sbfedelq61leaseamt12m,
															Sbfedelq61leaseamt24m,
															Sbfedelq61leaseamt36m,
															Sbfedelq61leaseamt60m,
															Sbfedelq61leaseamt84m,
															Sbfedpd91amountlease,
															Sbfedelq91leaseamt03m,
															Sbfedelq91leaseamt06m,
															Sbfedelq91leaseamt12m,
															Sbfedelq91leaseamt24m,
															Sbfedelq91leaseamt36m,
															Sbfedelq91leaseamt60m,
															Sbfedelq91leaseamt84m,
															Sbfedpd121amountlease,
															Sbfedelq121leaseamt03m,
															Sbfedelq121leaseamt06m,
															Sbfedelq121leaseamt12m,
															Sbfedelq121leaseamt24m,
															Sbfedelq121leaseamt36m,
															Sbfedelq121leaseamt60m,
															Sbfedelq121leaseamt84m,
															Sbfedpdamountletter,
															Sbfedpd01amountletter,
															Sbfedelq01letteramt03m,
															Sbfedelq01letteramt06m,
															Sbfedelq01letteramt12m,
															Sbfedelq01letteramt24m,
															Sbfedelq01letteramt36m,
															Sbfedelq01letteramt60m,
															Sbfedelq01letteramt84m,
															Sbfedpd31amountletter,
															Sbfedelq31letteramt03m,
															Sbfedelq31letteramt06m,
															Sbfedelq31letteramt12m,
															Sbfedelq31letteramt24m,
															Sbfedelq31letteramt36m,
															Sbfedelq31letteramt60m,
															Sbfedelq31letteramt84m,
															Sbfedpd61amountletter,
															Sbfedelq61letteramt03m,
															Sbfedelq61letteramt06m,
															Sbfedelq61letteramt12m,
															Sbfedelq61letteramt24m,
															Sbfedelq61letteramt36m,
															Sbfedelq61letteramt60m,
															Sbfedelq61letteramt84m,
															Sbfedpd91amountletter,
															Sbfedelq91letteramt03m,
															Sbfedelq91letteramt06m,
															Sbfedelq91letteramt12m,
															Sbfedelq91letteramt24m,
															Sbfedelq91letteramt36m,
															Sbfedelq91letteramt60m,
															Sbfedelq91letteramt84m,
															Sbfedpd121amountletter,
															Sbfedelq121letteramt03m,
															Sbfedelq121letteramt06m,
															Sbfedelq121letteramt12m,
															Sbfedelq121letteramt24m,
															Sbfedelq121letteramt36m,
															Sbfedelq121letteramt60m,
															Sbfedelq121letteramt84m,
															Sbfedpdamountoline,
															Sbfedpd01amountoline,
															Sbfedelq01oelineamt03m,
															Sbfedelq01oelineamt06m,
															Sbfedelq01oelineamt12m,
															Sbfedelq01oelineamt24m,
															Sbfedelq01oelineamt36m,
															Sbfedelq01oelineamt60m,
															Sbfedelq01oelineamt84m,
															Sbfedpd31amountoline,
															Sbfedelq31oelineamt03m,
															Sbfedelq31oelineamt06m,
															Sbfedelq31oelineamt12m,
															Sbfedelq31oelineamt24m,
															Sbfedelq31oelineamt36m,
															Sbfedelq31oelineamt60m,
															Sbfedelq31oelineamt84m,
															Sbfedpd61amountoline,
															Sbfedelq61oelineamt03m,
															Sbfedelq61oelineamt06m,
															Sbfedelq61oelineamt12m,
															Sbfedelq61oelineamt24m,
															Sbfedelq61oelineamt36m,
															Sbfedelq61oelineamt60m,
															Sbfedelq61oelineamt84m,
															Sbfedpd91amountoline,
															Sbfedelq91oelineamt03m,
															Sbfedelq91oelineamt06m,
															Sbfedelq91oelineamt12m,
															Sbfedelq91oelineamt24m,
															Sbfedelq91oelineamt36m,
															Sbfedelq91oelineamt60m,
															Sbfedelq91oelineamt84m,
															Sbfedpd121amountoline,
															Sbfedelq121oelineamt03m,
															Sbfedelq121oelineamt06m,
															Sbfedelq121oelineamt12m,
															Sbfedelq121oelineamt24m,
															Sbfedelq121oelineamt36m,
															Sbfedelq121oelineamt60m,
															Sbfedelq121oelineamt84m,
															Sbfedpdamountother,
															Sbfedpd01amountother,
															Sbfedelq01otheramt03m,
															Sbfedelq01otheramt06m,
															Sbfedelq01otheramt12m,
															Sbfedelq01otheramt24m,
															Sbfedelq01otheramt36m,
															Sbfedelq01otheramt60m,
															Sbfedelq01otheramt84m,
															Sbfedpd31amountother,
															Sbfedelq31otheramt03m,
															Sbfedelq31otheramt06m,
															Sbfedelq31otheramt12m,
															Sbfedelq31otheramt24m,
															Sbfedelq31otheramt36m,
															Sbfedelq31otheramt60m,
															Sbfedelq31otheramt84m,
															Sbfedpd61amountother,
															Sbfedelq61otheramt03m,
															Sbfedelq61otheramt06m,
															Sbfedelq61otheramt12m,
															Sbfedelq61otheramt24m,
															Sbfedelq61otheramt36m,
															Sbfedelq61otheramt60m,
															Sbfedelq61otheramt84m,
															Sbfedpd91amountother,
															Sbfedelq91otheramt03m,
															Sbfedelq91otheramt06m,
															Sbfedelq91otheramt12m,
															Sbfedelq91otheramt24m,
															Sbfedelq91otheramt36m,
															Sbfedelq91otheramt60m,
															Sbfedelq91otheramt84m,
															Sbfedpd121amountother,
															Sbfedelq121otheramt03m,
															Sbfedelq121otheramt06m,
															Sbfedelq121otheramt12m,
															Sbfedelq121otheramt24m,
															Sbfedelq121otheramt36m,
															Sbfedelq121otheramt60m,
															Sbfedelq121otheramt84m,
															Sbfedelq1amtpct,
															Sbfedelq1amtpct03m,
															Sbfedelq1amtpct06m,
															Sbfedelq1amtpct12m,
															Sbfedelq1amtpct24m,
															Sbfedelq1amtpct36m,
															Sbfedelq1amtpct60m,
															Sbfedelq1amtpct84m,
															Sbfedelq1revamtpct,
															Sbfedelq1instamtpct,
															Sbfedelq31amtpct,
															Sbfedelq31amtpct03m,
															Sbfedelq31amtpct06m,
															Sbfedelq31amtpct12m,
															Sbfedelq31amtpct24m,
															Sbfedelq31amtpct36m,
															Sbfedelq31amtpct60m,
															Sbfedelq31amtpct84m,
															Sbfedelq31revamtpct,
															Sbfedelq31instamtpct,
															Sbfedelq61amtpct,
															Sbfedelq61amtpct03m,
															Sbfedelq61amtpct06m,
															Sbfedelq61amtpct12m,
															Sbfedelq61amtpct24m,
															Sbfedelq61amtpct36m,
															Sbfedelq61amtpct60m,
															Sbfedelq61amtpct84m,
															Sbfedelq61revamtpct,
															Sbfedelq61instamtpct,
															Sbfedelq91amtpct,
															Sbfedelq91amtpct03m,
															Sbfedelq91amtpct06m,
															Sbfedelq91amtpct12m,
															Sbfedelq91amtpct24m,
															Sbfedelq91amtpct36m,
															Sbfedelq91amtpct60m,
															Sbfedelq91amtpct84m,
															Sbfedelq91revamtpct,
															Sbfedelq91instamtpct,
															Sbfedelq121amtpct,
															Sbfedelq121amtpct03m,
															Sbfedelq121amtpct06m,
															Sbfedelq121amtpct12m,
															Sbfedelq121amtpct24m,
															Sbfedelq121amtpct36m,
															Sbfedelq121amtpct60m,
															Sbfedelq121amtpct84m,
															Sbfedelq121revamtpct,
															Sbfedelq121instamtpct,
															Sbfedelqavgamt03m,
															Sbfedpdaveamount06,
															Sbfedpdaveamount12,
															Sbfedpdaveamount24,
															Sbfedpdaveamount36,
															Sbfedpdaveamount60,
															Sbfedpdaveamount84,
															Sbfedpdaveamountever,
															Sbfedelqloanavgamt03m,
															Sbfedelqloanavgamt06m,
															Sbfedelqloanavgamt12m,
															Sbfedelqloanavgamt24m,
															Sbfedelqloanavgamt36m,
															Sbfedelqloanavgamt60m,
															Sbfedelqloanavgamt84m,
															Sbfedelqloanavgamtever,
															Sbfedelqlineavgamt03m,
															Sbfedelqlineavgamt06m,
															Sbfedelqlineavgamt12m,
															Sbfedelqlineavgamt24m,
															Sbfedelqlineavgamt36m,
															Sbfedelqlineavgamt60m,
															Sbfedelqlineavgamt84m,
															Sbfedelqlineavgamtever,
															Sbfedelqcardavgamt03m,
															Sbfedelqcardavgamt06m,
															Sbfedelqcardavgamt12m,
															Sbfedelqcardavgamt24m,
															Sbfedelqcardavgamt36m,
															Sbfedelqcardavgamt60m,
															Sbfedelqcardavgamt84m,
															Sbfedelqcardavgamtever,
															Sbfedelqleaseavgamt03m,
															Sbfedelqleaseavgamt06m,
															Sbfedelqleaseavgamt12m,
															Sbfedelqleaseavgamt24m,
															Sbfedelqleaseavgamt36m,
															Sbfedelqleaseavgamt60m,
															Sbfedelqleaseavgamt84m,
															Sbfedelqleaseavgamtever,
															Sbfedelqletteravgamt03m,
															Sbfedelqletteravgamt06m,
															Sbfedelqletteravgamt12m,
															Sbfedelqletteravgamt24m,
															Sbfedelqletteravgamt36m,
															Sbfedelqletteravgamt60m,
															Sbfedelqletteravgamt84m,
															Sbfedelqletteravgamtever,
															Sbfedelqoelineavgamt03m,
															Sbfedelqoelineavgamt06m,
															Sbfedelqoelineavgamt12m,
															Sbfedelqoelineavgamt24m,
															Sbfedelqoelineavgamt36m,
															Sbfedelqoelineavgamt60m,
															Sbfedelqoelineavgamt84m,
															Sbfedelqoelineavgamtever,
															Sbfedelqotheravgamt03m,
															Sbfedelqotheravgamt06m,
															Sbfedelqotheravgamt12m,
															Sbfedelqotheravgamt24m,
															Sbfedelqotheravgamt36m,
															Sbfedelqotheravgamt60m,
															Sbfedelqotheravgamt84m,
															Sbfedelqotheravgamtever,
															Sbfechargeoffcount,
															Sbfechargeoffamount,
															Sbfechargeoffdatelastseen,
															Sbfetimenewestchargeoff,
															Sbfechargeoffloancount,
															Sbfechargeofflinecount,
															Sbfechargeoffcardcount,
															Sbfechargeoffleasecount,
															Sbfechargeofflettercount,
															Sbfechargeoffolinecount,
															Sbfechargeoffothercount,
															Sbfechargeoffloanamount,
															Sbfechargeofflineamount,
															Sbfechargeoffcardamount,
															Sbfechargeoffleaseamount,
															Sbfechargeoffletteramount,
															Sbfechargeoffolineamount,
															Sbfechargeoffotheramount,
															Sbfeballooncount,
															Sbfeballoonpaymentamount,
															Sbfeballoonpaymentduedate,
															Sbfefirmbusstructure,
															Sbfesiccode,
															Sbfenaicscode,
															Sbfegovguaranteecount,
															Sbfeguarantoraccountcount,
															Sbfeguarantormincount,
															Sbfeguarantormaxcount,
															Sbfeprincipalaccountcount,
															Sbfeprincipalmincount,
															Sbfeprincipalmaxcount
															};


QUERY: Dump <= Business;
													 
