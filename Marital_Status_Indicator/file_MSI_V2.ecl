import doxie, lib_fileservices, ut, watchdog;

//Constants
test := NOTHOR(fileservices.LogicalFileList('thor_data400::key::relatives_qa', true, true, ,'prod_dali.br.seisint.com'));;
string 	date :=(test[1].modified[1..10]);
string	effdt := date[1..4] + date[6..7] + date[9..10];

//start with watchdog
ds_in := distribute(marital_status_indicator.key_MSI_Best_did(adl_ind in ['CORE','DEAD'] and did <> 0), did);//use this on main build

////////////////////////////
//Append Attributes
MD_Shell_results := Marital_Status_Indicator.get_MD_Shell(ds_in):persist('~thor_data400::PersistForALPHA::msi::MD_Shell',expire(21));

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

	
	//B1 Model
	ms_waterfall_logic:= map(l.marital_status_v1 = 'M' AND 
															(l.filing_type = '7' OR
															(l.div_dt > l.mar_dt))											=> 'D', //Divorced from records
															
													 (l.div_dt < l.mar_dt) and l.spouse=2 					=> 'M', //Married
													 (l.div_dt < l.mar_dt) or l.ts_sp_recent_dt=0 	=> 'M', //Married
													 // l.spouse = 2 																	=> 'M', //Married
													 
													 l.ts_shared_addr_dt > 5 and 
															l.rel_shared_address = false and
															(l.age <= 63 or l.hhid_cnt = 1) 						=> 'D',	//Divorced from waterfall
	
													 l.marital_status_v1 = 'D' AND 
															(l.filing_type = '3' OR 
															(l.div_dt < l.mar_dt))											=> 'M', //Married  from records
													 
													 l.marital_status_v1 = 'D' 											=> 'D', //Divorced Inferred MSI V1														
														
													 l.marital_status_v1 = 'M' 											=> 'M', //Married  Inferred MSI V1
															
													//-------------------------
													 l.marital_status_v1 = 'W'											=> 'W', //Widowed  Inferred MSI V1


																																						 'A');//Not Scored  -> M, W, D -> set this immediately bypass regression 
	
	//B2 Model
	ms_regression := map(ms_waterfall_logic = 'A' and l.sex = 1 =>
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
											 ms_waterfall_logic = 'A' and l.sex = 0 =>
													//Waterfall is unscored and (female or unknown)					 
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
														,10); //10 will overload the ms_regression_final to false so the first condition is not true
	//B2 Final 
	ms_regression_final := map(1/(1+exp(-ms_regression)) > .04 => 'M', //Married
																				 l.ts_sp_recent_miss => 'S', //Single
																															  'D');//Divorced
	
	//move all D to S after this step
	//if B1 = M and B2 = 0 then B = M
	//if B1 = D and B2 = 0 then B = D
	//if B1 = A and B2 = M then B = M
	//if B1 = A and B2 = D then B = D
	//if B1 = A and B2 = S then B = S
	msi_final := map(l.age > 0 and l.age < 17 																			=> 'U', //Unknown
									 l.marital_status_v1 = 'X' or l.rc_decsflag 										=> 'U', //Deceased Inferred MSI V1
									 //------ B1 + B2 -----------
									 ms_waterfall_logic in ['S','D']																=> 'S', //Remap D to S per 1/25/2013 change request CR010
									 ms_waterfall_logic = 'M' 			 															 	=> 'M',
									 ms_waterfall_logic = 'W' and l.mar_dt > l.spouse_dod  					=> 'M', //-> Overrides W to M when a marriage cert is found after DOD of spouse
									 ms_waterfall_logic = 'W' 															 				=> 'W',
									 ms_waterfall_logic = 'A' and ms_regression_final in ['S','D']	=> 'S', //Remap D to S per 1/25/2013 change request CR010
									 ms_waterfall_logic = 'A' and ms_regression_final = 'M' 				=> 'M',
																																										 'U');//maps U and X to U
	
	self.marital_status_v2 := msi_final;		 
	self := l;
	self := [];
end;

MSI := project(dMSI_Shell, calcMSI(left), local);

EXPORT file_MSI_V2 := MSI:persist('~thor_data400::PersistForALPHA::msi::marriage_v2',expire(21));