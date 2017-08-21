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
	
dLNCourtOffensesOut			:= project(lnOffenses, stOffLayout2(left))(vendor in [//'02','03',
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