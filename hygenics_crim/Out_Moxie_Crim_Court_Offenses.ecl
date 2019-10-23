import crim_common;

///////////////////////////////////////////////////////////////////////////////////
//Create Offense file
///////////////////////////////////////////////////////////////////////////////////

	string8 fFixDate(string8 pDateIn) := if(stringlib.StringFilter(pDateIn,'0123456789') <> pDateIn or (integer8)pDateIn = 0,
																				'',
																				pDateIn);
																				
//Add_Types to LN Files																			
	ln_arr_offenses	:= hygenics_crim.File_In_Arrest_Offenses;
	
			add_Layout_In_Court_Offenses := record
				Crim_common.Layout_In_Court_Offenses;
				string2 data_type;
			end;	
			
			add_Layout_In_Court_Offenses addArrType(ln_arr_offenses l) := transform
				self.data_type := '5';
				self := l;
			end;

	ln_arr_offenses_out := project(ln_arr_offenses, addArrType(left));	
	
		ln_ct_offenses	:= hygenics_crim.File_In_Court_Offenses;	
			
			add_Layout_In_Court_Offenses addCtType(ln_ct_offenses l) := transform
				self.data_type := '2';
				self := l;
			end;

	ln_ct_offenses_out := project(ln_ct_offenses, addCtType(left));
	
	lnOffenses := ln_arr_offenses_out + ln_ct_offenses_out;

//Map LN File to New Layout		
	Layout_Common_Court_Offenses stOffLayout2(lnOffenses l):= transform
		  self.offender_key     := StringLib.StringToUpperCase(l.offender_key);
      self.off_date			    := fFixDate(l.off_date);
      self.arr_date			    := fFixDate(l.arr_date);
      self.arr_disp_date		:= fFixDate(l.arr_disp_date);
      self.court_disp_date	:= fFixDate(l.court_disp_date);
      self.sent_date				:= fFixDate(l.sent_date);
      self.appeal_date			:= fFixDate(l.appeal_date);
		
			self.convict_dt				:= '';
			self.offense_town			:= '';
			self.cty_conv			  	:= '';
			self.restitution			:= '';
			self.community_service:= '';
			self.parole				  	:= '';
			self.addl_sent_dates	:= '';
			self.Probation_desc2	:= '';
			self.court_dt			  	:= '';
			self.court_county			:= '';
			SELF.sent_court_cost_orig      	:= '';
      SELF.sent_court_fine_orig      	:= '';
      SELF.sent_susp_court_fine_orig 	:= '';
			self.offense_persistent_id			:= 0;
			// self.offense_category           := 0;
      self.Hyg_classification_code    := '';			
			// self.Old_ln_Offense_score       := '';
			self 														:= l;
		end;
	
dLNCourtOffensesOut1			:= project(lnOffenses, stOffLayout2(left))(vendor in [//'02','03',
															//'1A','1E','1J','1L','1M','1N','1R','2H','2K','2L','2O','2Q',
																//'2U','2V','2W','2X','2Y','3J','3R','3Y'
																'1B','1I','1S','1T','1U','1W','1X',
																'1Z','2A','2B','2C','2D','2E','2F',
																'2Z','3K',//'3L', replaced with hygenics TX lamar
																'3N','3O',
																//'42','43', Using hygenics Pasco
																//'47','55','75','89','93','97','98',
																'63','73','77',
																//'64', replaced with crimwise  CALIFORNIA MENDOCINO COUNTY
																//'78', replaced with hygenics TX lamar
																'79','80','90','91','A3','A4','A7',
																'AP','AT','B7','D4','B8','4D','1V'
																]):persist('~thordata40::persist::ln_arrest_court_offenses_all2');
					
dLNsorted_offense := sort(distribute(dLNCourtOffensesOut1,HASH(offender_key,  vendor,  source_file)),
                  offender_key,  vendor,  state_origin,  source_file,  data_type,  
                  trim(off_date),  trim(arr_date),  
									StringLib.StringFilter(StringLib.StringToUpperCase(num_of_counts),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									StringLib.StringFilter(StringLib.StringToUpperCase(le_agency_cd),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),   
									StringLib.StringFilter(StringLib.StringToUpperCase(le_agency_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									StringLib.StringFilter(StringLib.StringToUpperCase(le_agency_case_number),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
                  StringLib.StringFilter(StringLib.StringToUpperCase(traffic_ticket_number),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
                  StringLib.StringFilter(StringLib.StringToUpperCase(traffic_dl_no),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),																				
									trim(traffic_dl_st),
									StringLib.StringFilter(StringLib.StringToUpperCase(arr_off_code),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),									
									StringLib.StringFilter(StringLib.StringToUpperCase(arr_off_desc_1+arr_off_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									trim(arr_off_type_cd),  trim(arr_off_type_desc), trim(arr_off_lev),
                  StringLib.StringFilter(StringLib.StringToUpperCase(arr_statute),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),									
									trim(arr_statute_desc),  trim(arr_disp_date),  trim(arr_disp_code),  
                  StringLib.StringFilter(StringLib.StringToUpperCase(arr_disp_desc_1+arr_disp_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),                                      
									trim(pros_refer_cd),  trim(pros_refer),  trim(pros_assgn_cd),  trim(pros_assgn),  trim(pros_chg_rej),  trim(pros_off_code),  trim(pros_off_desc_1),  trim(pros_off_desc_2),
                  trim(pros_off_type_cd),  trim(pros_off_type_desc),  trim(pros_off_lev),  trim(pros_act_filed),  trim(court_case_number),  trim(court_cd), 
                  StringLib.StringFilter(StringLib.StringToUpperCase(court_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),                  
									trim(court_appeal_flag), 
									StringLib.StringFilter(StringLib.StringToUpperCase(court_final_plea),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									StringLib.StringFilter(StringLib.StringToUpperCase(court_off_code),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									StringLib.StringFilter(StringLib.StringToUpperCase(court_off_desc_1+court_off_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
                  trim(court_off_type_desc),  trim(court_off_lev),
									StringLib.StringFilter(StringLib.StringToUpperCase(court_statute),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
							    trim(court_additional_statutes),                  
									StringLib.StringFilter(StringLib.StringToUpperCase(court_statute_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),									
									court_disp_date, 
									StringLib.StringFilter(StringLib.StringToUpperCase(court_disp_code),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									StringLib.StringFilter(StringLib.StringToUpperCase(court_disp_desc_1+court_disp_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									trim(sent_date),  
									StringLib.StringFilter(StringLib.StringToUpperCase(sent_jail),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									StringLib.StringFilter(StringLib.StringToUpperCase(sent_susp_time),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									trim(sent_court_cost),
                  trim(sent_court_fine),  trim(sent_susp_court_fine),  
									StringLib.StringFilter(StringLib.StringToUpperCase(sent_probation),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									trim(sent_addl_prov_code),  
									StringLib.StringFilter(StringLib.StringToUpperCase(sent_addl_prov_desc_1+sent_addl_prov_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
                  trim(sent_consec),  trim(sent_agency_rec_cust_ori),  
									StringLib.StringFilter(StringLib.StringToUpperCase(sent_agency_rec_cust),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									trim(appeal_date),  trim(appeal_off_disp),  trim(appeal_final_decision),
                  trim(convict_dt),  
									StringLib.StringFilter(StringLib.StringToUpperCase(offense_town),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									trim(cty_conv),  trim(restitution),  
									StringLib.StringFilter(StringLib.StringToUpperCase(community_service),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									trim(parole), StringLib.StringFilter(StringLib.StringToUpperCase(addl_sent_dates),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									StringLib.StringFilter(StringLib.StringToUpperCase(probation_desc2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									trim(court_dt),  
                  StringLib.StringFilter(StringLib.StringToUpperCase(court_county),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),									
									offense_persistent_id,off_comp,Hyg_classification_code,-process_date,local);
dLNCourtOffensesOut := dedup(dLNsorted_offense,
                  offender_key,  vendor,  state_origin,  source_file,  data_type,  
                  trim(off_date),  trim(arr_date),  
									StringLib.StringFilter(StringLib.StringToUpperCase(num_of_counts),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									StringLib.StringFilter(StringLib.StringToUpperCase(le_agency_cd),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),   
									StringLib.StringFilter(StringLib.StringToUpperCase(le_agency_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									StringLib.StringFilter(StringLib.StringToUpperCase(le_agency_case_number),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
                  StringLib.StringFilter(StringLib.StringToUpperCase(traffic_ticket_number),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
                  StringLib.StringFilter(StringLib.StringToUpperCase(traffic_dl_no),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),																				
									trim(traffic_dl_st),
									StringLib.StringFilter(StringLib.StringToUpperCase(arr_off_code),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),									
									StringLib.StringFilter(StringLib.StringToUpperCase(arr_off_desc_1+arr_off_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									trim(arr_off_type_cd),  trim(arr_off_type_desc), trim(arr_off_lev),
                  StringLib.StringFilter(StringLib.StringToUpperCase(arr_statute),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),									
									trim(arr_statute_desc),  trim(arr_disp_date),  trim(arr_disp_code),  
                  StringLib.StringFilter(StringLib.StringToUpperCase(arr_disp_desc_1+arr_disp_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),                                      
									trim(pros_refer_cd),  trim(pros_refer),  trim(pros_assgn_cd),  trim(pros_assgn),  trim(pros_chg_rej),  trim(pros_off_code),  trim(pros_off_desc_1),  trim(pros_off_desc_2),
                  trim(pros_off_type_cd),  trim(pros_off_type_desc),  trim(pros_off_lev),  trim(pros_act_filed),  trim(court_case_number),  trim(court_cd), 
                  StringLib.StringFilter(StringLib.StringToUpperCase(court_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),                  
									trim(court_appeal_flag), 
									StringLib.StringFilter(StringLib.StringToUpperCase(court_final_plea),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									StringLib.StringFilter(StringLib.StringToUpperCase(court_off_code),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									StringLib.StringFilter(StringLib.StringToUpperCase(court_off_desc_1+court_off_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
                  trim(court_off_type_desc),  trim(court_off_lev),
									StringLib.StringFilter(StringLib.StringToUpperCase(court_statute),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
							    trim(court_additional_statutes),                  
									StringLib.StringFilter(StringLib.StringToUpperCase(court_statute_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),									
									court_disp_date, 
									StringLib.StringFilter(StringLib.StringToUpperCase(court_disp_code),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									StringLib.StringFilter(StringLib.StringToUpperCase(court_disp_desc_1+court_disp_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									trim(sent_date),  
									StringLib.StringFilter(StringLib.StringToUpperCase(sent_jail),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									StringLib.StringFilter(StringLib.StringToUpperCase(sent_susp_time),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									trim(sent_court_cost),
                  trim(sent_court_fine),  trim(sent_susp_court_fine),  
									StringLib.StringFilter(StringLib.StringToUpperCase(sent_probation),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									trim(sent_addl_prov_code),  
									StringLib.StringFilter(StringLib.StringToUpperCase(sent_addl_prov_desc_1+sent_addl_prov_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
                  trim(sent_consec),  trim(sent_agency_rec_cust_ori),  
									StringLib.StringFilter(StringLib.StringToUpperCase(sent_agency_rec_cust),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									trim(appeal_date),  trim(appeal_off_disp),  trim(appeal_final_decision),
                  trim(convict_dt),  
									StringLib.StringFilter(StringLib.StringToUpperCase(offense_town),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									trim(cty_conv),  trim(restitution),  
									StringLib.StringFilter(StringLib.StringToUpperCase(community_service),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									trim(parole), StringLib.StringFilter(StringLib.StringToUpperCase(addl_sent_dates),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									StringLib.StringFilter(StringLib.StringToUpperCase(probation_desc2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
									trim(court_dt),  
                  StringLib.StringFilter(StringLib.StringToUpperCase(court_county),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),	
									offense_persistent_id,off_comp,Hyg_classification_code,local);       																	
//Add_Types to Hygenics Files	
  dArrestOffenses			:= hygenics_crim.proc_build_arrest_offenses;
		
		add_Layout_Common_Court_Offenses := record
			hygenics_crim.Layout_Common_Court_Offenses_orig;
			string2 data_type;
		end;

		add_Layout_Common_Court_Offenses addArrTy(dArrestOffenses l):= transform
			self.data_type := '5';
			self := l;
		end;
		
		dArrestOffensesOut 	:= project(dArrestOffenses, addArrTy(left));
	
	dCourtOffenses		  	:= hygenics_crim.proc_build_court_offenses_base + hygenics_crim.proc_build_county_court_offenses;
		
		add_Layout_Common_Court_Offenses addCtTy(dCourtOffenses l):= transform
			self.data_type := '2';
			self := l;
		end;
		
	dCourtOffensesOut 		:= project(dCourtOffenses, addCtTy(left));  
	
	hygOffenses						:= dArrestOffensesOut + dCourtOffensesOut;

//Map Hygenics Files to New Layout		
		Layout_Common_Court_Offenses stOffLayout3(hygOffenses l):= transform
			self.offense_persistent_id 	:= 0;
			//self.offense_category     	:= 0;
			self 												:= l;		
		end;

	dLHygCourtOffensesOut := project(HygOffenses, stOffLayout3(left));
	
dCombinedOffensesOut 		:= dLNCourtOffensesOut + dLHygCourtOffensesOut:persist('~thor400_20::persist::court_offenses_pid2');

EXPORT Out_Moxie_Crim_Court_Offenses := dCombinedOffensesOut;