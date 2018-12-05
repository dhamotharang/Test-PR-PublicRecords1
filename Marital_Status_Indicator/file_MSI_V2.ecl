import doxie, lib_fileservices, ut, watchdog;

//Constants
test := fileservices.LogicalFileList('thor_data400::key::header::test20::relatives');
string 	date :=(test[1].modified[1..10]);
string	effdt := date[1..4] + date[6..7] + date[9..10];

//start with best did
ds_in := distribute(marital_status_indicator.key_MSI_Best_did(adl_ind in ['CORE','DEAD'] and did <> 0), did);//use this on main build

////////////////////////////
//Append Attributes
MD_Shell_results := Marital_Status_Indicator.get_MD_Shell(ds_in);

////////////////////
//start model logic
//Step 1: Data Manipulation
dMD_Shell_results := distribute(MD_Shell_results, did);
Marital_Status_Indicator.layouts.rMSIV2 prepShell(dMD_Shell_results l) := transform
	temp_recent_addr_dt := if(l.rel_addr_recent_dt <> 0, (integer)((string)l.rel_addr_recent_dt[1..6] + '01'), 0);
	temp_shared_addr_dt := if(l.rel_shared_addr_recent_dt <> 0, (integer)((string)l.rel_shared_addr_recent_dt[1..6] + '01'), 0);
	temp_sp_recent_dt 	:= if(l.rel_spouse_recent_dt <> 0, (integer)((string)l.rel_spouse_recent_dt[1..6] + '01'), 0);
	
	self.recent_addr_dt := temp_recent_addr_dt;
	self.shared_addr_dt := temp_shared_addr_dt;
	self.sp_recent_dt 	:= temp_sp_recent_dt;
	
	temp_ts_recent_addr_dt := if(temp_recent_addr_dt <> 0, ut.monthsApart_YYYYMMDD(effdt, (string)temp_recent_addr_dt,false),-999);
	self.ts_recent_addr_dt := temp_ts_recent_addr_dt;
	self.ts_shared_addr_dt := if(temp_shared_addr_dt <> 0, ut.monthsApart_YYYYMMDD(effdt, (string)temp_shared_addr_dt,false),-999);
	self.ts_sp_recent_dt 	 := if(temp_sp_recent_dt   <> 0, ut.monthsApart_YYYYMMDD(effdt, (string)temp_sp_recent_dt,  false),-999);
	self.ts_sp_recent_miss := if(l.rel_spouse_recent_dt = 0, true, false);
	
	temp_age1 := if(l.hhid_did1_dob <> 0, ut.monthsApart_YYYYMMDD(effdt, (string)l.hhid_did1_dob, false),-999);
	temp_age2 := if(l.hhid_did2_dob <> 0, ut.monthsApart_YYYYMMDD(effdt, (string)l.hhid_did2_dob, false),-999);
	temp_age3 := if(l.hhid_did3_dob <> 0, ut.monthsApart_YYYYMMDD(effdt, (string)l.hhid_did3_dob, false),-999);
	temp_age4 := if(l.hhid_did4_dob <> 0, ut.monthsApart_YYYYMMDD(effdt, (string)l.hhid_did4_dob, false),-999);
	temp_age5 := if(l.hhid_did5_dob <> 0, ut.monthsApart_YYYYMMDD(effdt, (string)l.hhid_did5_dob, false),-999);
	
	self.age1 := temp_age1;
	self.age2 := temp_age2;
	self.age3 := temp_age3;
	self.age4 := temp_age4;
	self.age5 := temp_age5;
	
	temp_age_chg_1 := if(temp_age1 <> -999, abs(ut.monthsApart_YYYYMMDD(effdt, (string)l.dob, false) - temp_age1), -999);
	temp_age_chg_2 := if(temp_age2 <> -999, abs(ut.monthsApart_YYYYMMDD(effdt, (string)l.dob, false) - temp_age2), -999);
	temp_age_chg_3 := if(temp_age3 <> -999, abs(ut.monthsApart_YYYYMMDD(effdt, (string)l.dob, false) - temp_age3), -999);
	temp_age_chg_4 := if(temp_age4 <> -999, abs(ut.monthsApart_YYYYMMDD(effdt, (string)l.dob, false) - temp_age4), -999);
	temp_age_chg_5 := if(temp_age5 <> -999, abs(ut.monthsApart_YYYYMMDD(effdt, (string)l.dob, false) - temp_age5), -999);
	
	self.age_chg_1 := temp_age_chg_1;
	self.age_chg_2 := temp_age_chg_2;
	self.age_chg_3 := temp_age_chg_3;
	self.age_chg_4 := temp_age_chg_4;
	self.age_chg_5 := temp_age_chg_5;
	
	self.name_change := if(l.gender = 'M', false, l.name_change);
	self.sex := map(l.gender = 'N' => -1, 
								  l.gender = 'M' => 1, 
								  0);
								 
	temp_fm_hhid := if((l.hhid_did1_gender not in ['U',''] and l.gender <> l.hhid_did1_gender) or
										 (l.hhid_did2_gender not in ['U',''] and l.gender <> l.hhid_did2_gender) or
										 (l.hhid_did3_gender not in ['U',''] and l.gender <> l.hhid_did3_gender) or
										 (l.hhid_did4_gender not in ['U',''] and l.gender <> l.hhid_did4_gender) or
										 (l.hhid_did5_gender not in ['U',''] and l.gender <> l.hhid_did5_gender), 1, 0);
	
	self.fm_hhid := temp_fm_hhid;
			 
	self.spouse := map(l.hhid_cnt > 1 and temp_fm_hhid = 1 and l.rel_spouse = true => 2,
										 l.hhid_cnt > 1 and (temp_age_chg_1 between 0 and 205 OR temp_age_chg_2 between 0 and 205 OR temp_age_chg_3 between 0 and 205 OR temp_age_chg_4 between 0 and 205 OR temp_age_chg_5 between 0 and 205) => 2,
										 l.rel_spouse = true => 1,
										 0);
	self.parent := if(l.hhid_cnt > 1 and (temp_age_chg_1 >204 or temp_age_chg_2 >204 or temp_age_chg_3 >204 or temp_age_chg_4 >204 or temp_age_chg_5 >204), 1,	0);
	
	self.lienBK := map(l.liens_recent_unreleased_count >= 1 and l.bk_flag = true => 3, 
										 l.liens_recent_unreleased_count >= 1 or  l.bk_flag = true => 2,  
										 0);
	
	self := l;
	self := [];
end;

MSI_Shell := project(dMD_Shell_results, prepShell(left), local);

//Step2: Waterfall Logic
dMSI_Shell := distribute(MSI_Shell, did);
Marital_Status_Indicator.layouts.rMSIV2 calcMSI(dMSI_Shell l) := transform

	ms_waterfall_logic:= map(l.age > 0 and l.age < 17 											=> 'U', //Unknown
													 l.marital_status_v1 = 'X' or l.rc_decsflag 		=> 'X', //Deceased Inferred MSI V1
													 l.marital_status_v1 = 'W'											=> 'W', //Widowed Inferred MSI V1
													 l.marital_status_v1 = 'D' 											=> 'D', //Divorced Inferred MSI V1
													 l.filing_type = '3'														=> 'M', //Married from records
													 l.filing_type = '7' 														=> 'D', //Divorced from records
													 (l.div_dt > l.mar_dt) and l.spouse=2 					=> 'M', //Married
													 l.div_dt > l.mar_dt 														=> 'D', //Divorced
													 (l.mar_dt > l.div_dt) or l.ts_sp_recent_dt=0 	=> 'M', //Married
																																						 'A');//Not Scored
													 //Additional Rules Not Used
													 //l.marital_status_v1 = 'M' 											=> 'M', //Married Inferred MSI V1
													 //l.spouse = 2 => 'M',
													 //l.rel_spouse_same_lname and l.ts_sp_recent_dt < 3 => 'M',
													 //l.name_change = false and spouse = 0 => 'S',
													 //l.rel_spouse_same_lname = false and l.rel_prop_same_lname = false and l.rel_addr_same_lname = false => 'S',
													 //l.ts_shared_addr_dt > 5 and l.rel_shared_address = false and (l.age <= 63 or l.hhid_cnt = 1) => 'D',
													

	ms_regression := if(ms_waterfall_logic = 'A' and l.sex = 1, 
					//Waterfall is unscored and male
						-3.75058431
						+ if(l.rel_vehicle,1,0)	*					0.875311855
						+ l.fm_hhid	*											0.091390913
						+ if(l.rel_prop_same_lname,1,0)	*	0.237567098
						+ l.spouse	*											0.14748589
						+ if(l.bk_flag,1,0)	*							0.224495393
						+ l.age	*													0.003399933
						+ if(l.ts_sp_recent_miss,1,0)	*	 -0.299340859
						+ 0.0011769057	*	1
						,
					//Waterfall is unscored and female or unknown					 
						-4.162794237
						+	l.parent	*											0.087809002
						+	if(l.name_change,1,0)	*					0.887655668
						+	if(l.rel_vehicle,1,0)	*					1.021068045
						+	l.fm_hhid	*											0.041838161
						+	if(l.rel_prop_same_lname,1,0)	*	0.277732694
						+	l.spouse	*											0.158345886
						+	l.lienBK	*										 -0.033267464
						+	if(l.ts_sp_recent_miss,1,0)	*	 -0.229978405
						+	0.0011769057	*	1
						);
				 
	ms_regression_final := map(1/(1+exp(-ms_regression)) > .04 => 'M', //Married
																				 l.ts_sp_recent_miss => 'S', //Single
																															  'D');//Divorced
	
	self.marital_status_v2 := if(ms_waterfall_logic <> 'A', ms_waterfall_logic, ms_regression_final);										 
	self := l;
	self := [];
end;

MSI := project(dMSI_Shell, calcMSI(left), local);

EXPORT file_MSI_V2 := MSI;





