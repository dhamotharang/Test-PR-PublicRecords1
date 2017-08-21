IMPORT crim_common, Crim, ut;

ds := crim.file_fl_pasco;

Crim_Common.Layout_In_Court_Offenses tFLCrim(ds dInput) := Transform
UpperName						:= ut.fnTrim2Upper(dInput.Defendant_Name);
UpperCaseNum				:= ut.fnTrim2Upper(dInput.CJIS_Case_Number); 
self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key 	:= '42'+UpperCaseNum+hash(UpperName);
self.vendor					:= '42';
self.state_origin		:= 'FL';
self.source_file		:= 'FL-PASCO_COUNTY';
self.off_comp 			:= '';
self.off_delete_flag 	:= '';
self.off_date 			:= '';
self.arr_date 			:= '';
self.num_of_counts 	:= '';
self.le_agency_cd 	:= '';
self.le_agency_desc := '';
self.le_agency_case_number := '';
self.traffic_ticket_number := '';
self.traffic_dl_no 			:= '';
self.traffic_dl_st 			:= '';
self.arr_off_code 			:= '';
self.arr_off_desc_1 		:= '';
self.arr_off_desc_2 		:= '';
self.arr_off_type_cd 		:= '';
self.arr_off_type_desc 	:= '';
self.arr_off_lev 				:= '';
self.arr_statute 				:= '';
self.arr_statute_desc 	:= '';
self.arr_disp_date 			:= '';
self.arr_disp_code 			:= '';
self.arr_disp_desc_1 		:= '';
self.arr_disp_desc_2 		:= '';
self.pros_refer_cd 			:= '';
self.pros_refer 				:= '';
self.pros_assgn_cd 			:= '';
self.pros_assgn 				:= '';
self.pros_chg_rej 			:= '';
self.pros_off_code 			:= '';
self.pros_off_desc_1 		:= '';
self.pros_off_desc_2 		:= '';
self.pros_off_type_cd 	:= '';
self.pros_off_type_desc := '';
self.pros_off_lev 			:= '';
self.pros_act_filed 		:= '';
self.court_case_number 	:= '';
self.court_cd 					:= '';
self.court_desc 				:= '';
self.court_appeal_flag 	:= '';
self.court_final_plea 	:= '';
self.court_off_code 		:= '';
self.court_off_desc_1 	:= '';
self.court_off_desc_2		:= '';
self.court_off_type_cd 	:= '';
self.court_off_type_desc := '';
self.court_off_lev 			:= '';
self.court_statute 			:= trim(dInput.Statute_Reference,left,right);
self.court_additional_statutes 	:= '';
self.court_statute_desc := '';
self.court_disp_date 		:= '';
self.court_disp_code 		:= trim(dInput.Court_Action_Taken,left,right);
self.court_disp_desc_1	:= map(self.court_disp_code = 'A' => 'ACQUITTED',
																self.court_disp_code = 'I' => 'ACQUITTED BY REASON OF INSANITY',
																self.court_disp_code = 'D' => 'DISMISSED',
																self.court_disp_code = 'E' => 'DISMISSED UPON PYMNT OF RESTITU/CRT COST',
																self.court_disp_code = 'T' => 'DISMISSED SPEEDY TRIAL',
																self.court_disp_code = 'M' => 'MENTAL/PHYSICAL UNABLE TO STAND TRIAL',
																self.court_disp_code = 'G' => 'ADJUDICATED GUILTY',
																self.court_disp_code = 'H' => 'PRE-TRIAL DIVERSION',
																self.court_disp_code = 'W' => 'ADJUDICATED WITHHELD',
																self.court_disp_code = 'V' => 'CHANGE OF VENUE',
																self.court_disp_code = 'Z' => 'EXTRADITION',
																self.court_disp_code = 'K' => 'ADJUDGED DELINQUENT',
																self.court_disp_code = 'B' => 'BOND ESTREATURE',
																self.court_disp_code = 'X' => 'STIPULATED DEPORTATION',
																self.court_disp_code = 'Q' => 'WAIVED TO ADULT COURT',
																self.court_disp_code = 'Y' => 'DECLINE TO ADJUDICATE','');
self.court_disp_desc_2 	:= '';
self.sent_date 					:= '';
self.sent_jail 					:= '';
self.sent_susp_time 		:= '';
self.sent_court_cost 		:= '';
self.sent_court_fine 		:= '';
self.sent_susp_court_fine := '';
self.sent_probation 			:= '';
self.sent_addl_prov_code 	:= trim(dInput.Sentence_Provisions,left,right);
self.sent_addl_prov_desc_1 := map(self.sent_addl_prov_code = 'B' => 'BAIL FORFEITED/ESTREATED',
																	self.sent_addl_prov_code = 'C' => 'CONFINEMENT OR FINE',
																	self.sent_addl_prov_code = 'H' => 'CONFINEMENT IN HOSPITAL',
																	self.sent_addl_prov_code = 'G' => 'NIGHT CONFINEMENT',
																	self.sent_addl_prov_code = 'W' => 'WEEKEND CONFINEMENT',
																	self.sent_addl_prov_code = 'S' => 'SUSPENDED FINE',
																	self.sent_addl_prov_code = 'O' => 'COMMUNITY SERVICE',
																	self.sent_addl_prov_code = 'F' => 'FINE OR COMMUNITY SERVICE',
																	self.sent_addl_prov_code = 'A' => 'ATTEND DUI SCHOOL OR DRUG REHAB PROGRAM',
																	self.sent_addl_prov_code = 'E' => 'PROBATION REVOKED',
																	self.sent_addl_prov_code = 'D' => 'CONFINEMENT OR COMMUNITY SERVICE',
																	self.sent_addl_prov_code = 'K' => 'WORK RELEASE',
																	self.sent_addl_prov_code = 'T' => 'OTHR CRT RESTRICTIONS/JUDICIAL WARNING',
																	self.sent_addl_prov_code = 'U' => 'SPLIT SENTENCE(INCARCER/PROBATION)',
																	self.sent_addl_prov_code = 'V' => 'SPLIT SENTENCE(INCARCER/COMMUNITY CNTRL)',
																	self.sent_addl_prov_code = 'Z' => 'SPLIT SENTENCE(INCARCER/YOUTHFUL OFFNDR)',
																	self.sent_addl_prov_code = 'I' => 'ELECTRONIC MONITOR',
																	self.sent_addl_prov_code = 'J' => 'UNDETERMND PERIOD NO LONGER THAN 19 BDAY',
																	self.sent_addl_prov_code = 'L' => 'UNDERTERMND PERIOD NO LONGER THAN 21 BDAY',
																	self.sent_addl_prov_code = 'N' =>'NOT APPLICABLE','');
trimSpecialProvision			 := ut.fnTrim2Upper(dInput.Special_Sentence_Provisions);
self.sent_addl_prov_desc_2 := MAP(trimSpecialProvision = 'Y' => 'YOUTHFUL OFFENDER ACT',
																	trimSpecialProvision = 'M' => 'CAPITAL OFFENSE',
																	trimSpecialProvision = 'R' => 'RESENTENCING',
																	trimSpecialProvision = 'D' => 'DEFENDANT SENT-MENTAL DSORDER, SEX OFFNDR',
																	trimSpecialProvision = 'G' => 'DEFENDANT SENT - UNDER SENTENCIN GUIDELINE',
																	trimSpecialProvision = 'C' => 'CONTROLLED SUBSTANCE W/1000 FT OF SCHOOL',
																	trimSpecialProvision = 'S' => 'SHORT BARREL RIFLE, SHOTGUN, MACHINE GUN',
																	trimSpecialProvision = 'E' => 'CONTINUING CRIMINAL ENTERPRISE',
																	trimSpecialProvision = 'P' => 'PRISON CREDIT',
																	trimSpecialProvision = 'L' => 'LAW ENFORCEMENT PROTECTION ACT',
																	trimSpecialProvision = 'T' => 'DEFENDANT NOT ALLOWED TO EARN GAIN TIME',
																	trimSpecialProvision = 'J' => 'JUNNY-RIOS-MARTINEZ, JR. ACT OF 1992',
																	trimSpecialProvision = 'O' => 'UNLAWFUL TAKING/USE OF OFFICER FIREARM',
																	trimSpecialProvision = 'A' => 'ASSAULT/BATTERY ON PERSON 65 OR OLDER',
																	trimSpecialProvision = 'W' => 'MAKING/THROWING A DESTRUCTIVE DEVICE',
																	trimSpecialProvision = 'B' => 'PLANTING OF HOAX BOMB',
																	trimSpecialProvision = 'K' => 'DEALING 200FT OF CERTAIN PUBLIC AREAS',
																	trimSpecialProvision = 'Q' => 'EVIDENCING PREJUDICE WHILE COMMIT OFFNSE',
																	trimSpecialProvision = 'U' => 'WEARING MASK WHILE COMMITTING OFFENSE',
																	trimSpecialProvision = 'I' => 'DEFENDANT DETERMINED TO BE A SEX PRED',
																	trimSpecialProvision = 'N' => 'NOT APPLICABLE',
																	trimSpecialProvision = '1' => 'BATT OF LAW ENFORCEMNT OFFIC W/FIREARM',
																	trimSpecialProvision = '2' => 'BATT OF LAW ENFORCEMNT OFFIC W/SEMI-AUTO',
																	trimSpecialProvision = '3' => 'ADJUDGED HABITUAL FELONY OFFNDER',
																	trimSpecialProvision = 'H' => 'SENTENCED HABITUAL FELONY OFFNDER',
																	trimSpecialProvision = '4' => 'ADJUDGED, HABITUAL VIOLENT FEL OFFNDER',
																	trimSpecialProvision = 'V' => 'SENTENCED HABITUAL VIOLENT FEL OFFNDER',
																	trimSpecialProvision = '5' => 'ADJUDGED VIOLENT CAREER CRIMINAL',
																	trimSpecialProvision = 'X' => 'SENTENCED VIOLENT CAREER CRIMINAL','');
self.sent_consec 							:= '';
self.sent_agency_rec_cust_ori := '';
self.sent_agency_rec_cust 		:= '';
self.appeal_date 							:= '';
self.appeal_off_disp 					:= '';
self.appeal_final_decision 		:= '';
end;

pFLCrim := project(dS,tFLCrim(left));

//Look up statue description
lkstatute := crim.files_lkp.Pasco_Crim;

jStatuteDesc := join(pFLCrim(court_statute != ''), lkstatute,
								trim(left.court_statute,left,right) = trim(right.statute,left,right),
								transform({pFLCrim},self.court_statute_desc := right.description; self := left),left outer, lookup);
								
sd_ds_offenses:= dedup(sort(distribute(jStatuteDesc,hash(offender_key)),
									offender_key,court_statute,court_statute_desc,court_disp_code,court_disp_desc_1,sent_addl_prov_code,sent_addl_prov_desc_1,local),
									record,local):
									PERSIST('~thor_dell400::persist::Crim_FL_Pasco_Offenses');

EXPORT Map_FL_Pasco_Offenses := sd_ds_offenses;