//Function converts BenefitAssessment batch records in esdl response format.
IMPORT IESP;
EXPORT Functions := MODULE
 
 export ConvertBatchToESDL(dataset(BenefitAssessment_Services.Layouts.layout_batch_out) BatchResult,
                           iesp.benefitassessment_fcra.t_FcraBenefitAssessSearchBy Search_By) := function
    //sequence the batch output resutls for joining property chilc datasets later in this attribute.
		BenefitAssessment_Services.layouts.layout_batch_out_seq seqIt(batchresult l, integer c) := transform
		  self.seq := c;
			self := l;
		end;
    batchResults_Seq := project(batchResult, seqIt(left, counter));		
		
		out_rec_seq := record
		   integer seq;
		   iesp.benefitassessment_fcra.t_FcraBenefitAssessRecord;
    end;
		out_rec_seq  xformBatchToESDL(BenefitAssessment_Services.layouts.layout_batch_out_seq l) := transform
		  self.seq := l.seq;  //maintain sequence
		  //subject data
			self.subjectData := search_by;
			
			//death data
			self.DeceasedRecord.DeceasedFirstName := l.DeceasedFirstName;
	    self.DeceasedRecord.DeceasedLastName := l.DeceasedLastName;
	    self.DeceasedRecord.DOB := iesp.ECL2ESP.toDatestring8( l.DeceasedDOB);
	    self.DeceasedRecord.DOD := iesp.ECL2ESP.toDatestring8( l.DeceasedDOD);
	    self.DeceasedRecord.DeceasedMatchCode := l.DeceasedMatchCode ;
			//incarceration
			self.Incarceration.IncarceratedFlag := L.Incarcerated_Flag;
			self.Incarceration.CrimeReportData.StateOfOrigin := L.INCR_state_origin;
	    self.Incarceration.CrimeReportData.DOCNumber := L.INCR_doc_num;
	    self.Incarceration.CrimeReportData.DOB := iesp.ECL2ESP.toDatestring8(L.INCR_dob);
	    self.Incarceration.CrimeReportData.SSN := L.INCR_ssn;
	    self.Incarceration.CrimeReportData.EventDate := iesp.ECL2ESP.toDatestring8(L.event_dt);
			self.Incarceration.PunishmentType := L.punishment_type;
			self.Incarceration.SentenceLength := L.sent_length;
			self.Incarceration.SentenceLengthDesc := L.sent_length_desc;
			self.Incarceration.CurrentStatus := L.cur_stat_inm_desc;
			self.Incarceration.CurrrectLocationInm := L.cur_loc_inm;
			self.Incarceration.CurrentLocationSec := L.cur_loc_sec;
			self.Incarceration.AdmittedDate := iesp.ECL2ESP.toDatestring8(L.latest_adm_dt);
			self.Incarceration.ScheduledReleaseDate := iesp.ECL2ESP.toDatestring8(L.sch_rel_dt);
			self.Incarceration.ReleaseDate := iesp.ECL2ESP.toDatestring8(L.act_rel_dt);
			self.Incarceration.ControlledReleaseDate := iesp.ECL2ESP.toDatestring8(L.ctl_rel_dt);
 		  self.Incarceration.MatchCode := L.INCR_match_code;
	    self.Incarceration.INCR_Name := iesp.ECL2ESP.SetName(l.INCR_fname,'',l.INCR_lname,'','');
			//sex offender
			self.SexOffenderRecord.SOFR_Flag := L.SOFR_Flag;
			self.SexOffenderRecord.SOFR_Name := iesp.ECL2ESP.SetName(l.SOFR_fname,l.SOFR_mname,l.SOFR_lname, l.SOFR_suffix,'');
			self.SexOffenderRecord.SOFR_Addresses := DATASET([iesp.ECL2ESP.SetAddress('','','','','','','','','','','','','',
			                                                                      l.address_1, if (l.address_3<>'',l.address_2,''), 
																																	          if (l.address_3 <> '',l.address_3,l.address_2))
																																					 ],iesp.share.t_address) ;
			self.SexOffenderRecord.DateLastSeen := iesp.ECL2ESP.toDatestring8(l.date_last_seen);
			self.SexOffenderRecord.SOFR_RegistrationDates := DATASET([iesp.ECL2ESP.toDatestring8(l.SOFR_reg_date_1),
			                                        iesp.ECL2ESP.toDatestring8(l.SOFR_reg_date_2),
																							iesp.ECL2ESP.toDatestring8(l.SOFR_reg_date_3)
																							],iesp.share.t_date); 
			self.SexOffenderRecord.SOFR_Status := L.SOFR_status;
			self.SexOffenderRecord.SOFR_Category:= L.SOFR_category;
			self.SexOffenderRecord.SOFR_RiskLevelDesc := L.SOFR_risk_level_desc;
			self.SexOffenderRecord.SOFR_RegistrationType := L.SOFR_reg_type;
			self.SexOffenderRecord.SSN := L.ssn;
			self.SexOffenderRecord.Sex := L.sex;
			self.SexOffenderRecord.DOB := iesp.ECL2ESP.toDatestring8(L.dob);
			self.SexOffenderRecord.HairColor := L.hair_color;
			self.SexOffenderRecord.EyeColor := L.eye_color;
			self.SexOffenderRecord.ScarsMarksTattoos := L.Scars;
			self.SexOffenderRecord.Height := L.Height;
			self.SexOffenderRecord.Weight := L.Weight;
			self.SexOffenderRecord.Race := L.Race;
			self.SexOffenderRecord.OffenderId := L.offender_id;
			self.SexOffenderRecord.StateOfOriginCode := L.state_of_origin;
			conv_date1 := iesp.ECL2ESP.toDatestring8(l.conviction_date_1);
			off_date1 := iesp.ECL2ESP.toDatestring8(l.offense_date_1);
			conv_date2 := iesp.ECL2ESP.toDatestring8(l.conviction_date_2);
			off_date2 := iesp.ECL2ESP.toDatestring8(l.offense_date_2);
			conv_date3 := iesp.ECL2ESP.toDatestring8(l.conviction_date_3);
			off_date3 := iesp.ECL2ESP.toDatestring8(l.offense_date_3);
			conv_date4 := iesp.ECL2ESP.toDatestring8(l.conviction_date_4);
			off_date4 := iesp.ECL2ESP.toDatestring8(l.offense_date_4);
			conv_date5 := iesp.ECL2ESP.toDatestring8(l.conviction_date_5);
			off_date5 := iesp.ECL2ESP.toDatestring8(l.offense_date_5);
			conv_date6 := iesp.ECL2ESP.toDatestring8(l.conviction_date_6);
			off_date6 := iesp.ECL2ESP.toDatestring8(l.offense_date_6);
			self.SexOffenderRecord.SOFR_Convictions :=                 
			                         DATASET([{l.offense_1,'',conv_date1.year, conv_date1.month, conv_date1.day,l.victim_minor_1,l.conviction_jurisdiction_1,l.court_case_number_1,off_date1.year, off_date1.month, off_date1.day},
																				{l.offense_2,'',conv_date2.year, conv_date2.month, conv_date2.day,l.victim_minor_2,l.conviction_jurisdiction_2,l.court_case_number_2,off_date2.year, off_date2.month, off_date2.day},	
																				{l.offense_3,'',conv_date3.year, conv_date3.month, conv_date3.day,l.victim_minor_3,l.conviction_jurisdiction_3,l.court_case_number_3,off_date3.year, off_date3.month, off_date3.day},
																				{l.offense_4,'',conv_date4.year, conv_date4.month, conv_date4.day,l.victim_minor_4,l.conviction_jurisdiction_4,l.court_case_number_4,off_date4.year, off_date4.month, off_date4.day},
																				{l.offense_5,'',conv_date5.year, conv_date5.month, conv_date5.day,l.victim_minor_5,l.conviction_jurisdiction_5,l.court_case_number_5,off_date5.year, off_date5.month, off_date5.day},
																				{l.offense_6,'',conv_date6.year, conv_date6.month, conv_date6.day,l.victim_minor_6,l.conviction_jurisdiction_6,l.court_case_number_6,off_date6.year, off_date6.month, off_date6.day}
																			 ],iesp.benefitassessment_fcra.t_FcraBenefitAssessSexOffenderConviction);
	
			self.SexOffenderRecord.CleanAddress := iesp.ECL2ESP.SetAddress(l.prim_name, l.prim_range, l.predir, l.postdir, l.addr_suffix, l.unit_desig, l.sec_range, l.p_city_name, 
			                                                   l.state, l.zip, '', ''/*countyname*/);
			self.SexOffenderRecord.CleanAddress.VanityCity := L.v_city_name;
			//end of sexoffender
			//family
			self.FamilyRecord.UniqueId := l.did;
			self.FamilyRecord.CurrentAddressName := iesp.ECL2ESP.SetName(l.current_addr_fname,l.current_addr_mname,l.current_addr_lname,l.current_addr_suffix,'');
			self.FamilyRecord.FamilyAddress := iesp.ECL2ESP.SetAddress('','','','','','','',l.current_addr_city,l.current_addr_st,l.current_addr_zip,'','','', l.Current_addr, '',
																			 stringlib.stringcleanspaces(l.current_addr_city +' '+l.current_addr_st+' '+l.current_addr_zip));
			self.FamilyRecord.DateFirstSeen := iesp.ECL2ESP.toDatestring8(l.current_addr_first_seen);
			self.FamilyRecord.DateLastSeen := iesp.ECL2ESP.toDatestring8(l.current_addr_last_seen);
			self.FamilyRecord.MonthsAtAddress := l.months_at_addr;
			self.FamilyRecord.MatchInputAddress := l.match_input_addr;
			self.FamilyRecord.AddressOOS := l.current_addr_oos;
			self.FamilyRecord.NumberOfAdultsAtAddress:= (integer)l.num_adults_input_addr; 
			// self.FamilyRecord.ResidentAdults := DATASET([iesp.ECL2ESP.SetName('',l.adult_fname1,'',l.adult_lname1,'',''),
																																			 // iesp.ECL2ESP.SetName('',l.adult_fname2,'',l.adult_lname2,'',''),
																																			 // iesp.ECL2ESP.SetName('',l.adult_fname3,'',l.adult_lname3,'',''),
																																			 // iesp.ECL2ESP.SetName('',l.adult_fname4,'',l.adult_lname4,'',''),
																																			 // iesp.ECL2ESP.SetName('',l.adult_fname5,'',l.adult_lname5,'',''),
																																			 // iesp.ECL2ESP.SetName('',l.adult_fname6,'',l.adult_lname6,'',''),
																																			 // iesp.ECL2ESP.SetName('',l.adult_fname7,'',l.adult_lname7,'',''),
																																			 // iesp.ECL2ESP.SetName('',l.adult_fname8,'',l.adult_lname8,'',''),
																																			 // iesp.ECL2ESP.SetName('',l.adult_fname9,'',l.adult_lname9,'',''),
																																			 // iesp.ECL2ESP.SetName('',l.adult_fname10,'',l.adult_lname10,'','')		
																																				// ],iesp.share.t_Name);
			//property 
		
  		self.AssessetsAndWealth.CurrentPropertyRecords := [];
	    self.AssessetsAndWealth.PriorPropertyRecords  := [];

	    iesp.criminal.t_CrimReportOffense xformCrimOffense() := transform
			 // BenefitAssessment_Services.Layouts.layout_batch_out for crim has NOT [process_date, CRIM_Flag];
				self.Description := stringlib.stringcleanspaces(l.off_desc_1_1 + ' '+l.off_desc_2_1);
				self.NumberCounts := l.num_of_counts_1;
				self.OffenseDate := iesp.ECL2ESP.toDatestring8(l.off_date_1);
				self.OffenseType := l.off_typ_1;
				self.Court.description := l.court_desc_1;
				self.court.offense := l.chg_1;
				self.Court.level := l.off_lev_1;
				self.County := l.cty_conv_1 ;
				self.CaseType := l.off_code_1;
				self.SentenceDate := iesp.ecl2esp.toDatestring8(l.stc_dt_1);
				self := [];
      end;
      iesp.criminal.t_CrimReportRecord xformCrim() := transform
				self.OffenderId := l.crim_doc_num;  //bug 148270 put doc_num in this offfenderID as well as docnumber output field.
				self.CaseNumber := l.case_num_1;;
				self.CountyOfOrigin :='';
				self.DOCNumber := l.crim_doc_num;
				self.CaseFilingDate := iesp.ECL2ESP.toDatestring8('');
				self.Eyes :='';
				self.Hair :='';
				self.Height :='';
				self.Weight :='';
				self.Race :='';
				self.Sex :='';
				self.Skin :='';
				self.DataSource :='';
				self.SSN := l.CRIM_ssn;
				self.UniqueId :='';
				self.StateOfBirth :='';
				self.StateOfOrigin  := l.state_origin ;
				self.Status :='';
				self.Address  := iesp.ECL2ESP.SetAddress(l.CRIM_prim_name, l.CRIM_prim_range, l.CRIM_predir, l.CRIM_postdir,
			                                                         l.CRIM_addr_suffix, l.CRIM_unit_desig, l.CRIM_sec_range, l.CRIM_p_city_name, 
			                                                   l.CRIM_st, l.CRIM_zip5, l.CRIM_zip4, '',  '', '', '','');
				self.Name	:= iesp.ECL2ESP.SetName(l.CRIM_fname,l.CRIM_mname,l.CRIM_lname,'','');
				self.DOB := iesp.ECL2ESP.toDatestring8(l.CRIM_dob);
				self.isImageAvailable := FALSE;
				self.CaseTypeDescription :='';
				self.AKAs := DATASET([],iesp.share.t_Name);
				self.Offenses := DATASET([xformCrimOffense()]);
				self.PrisonSentences := DATASET([],iesp.criminal.t_CrimReportPrison);
				self.ParoleSentences := DATASET([],iesp.criminal.t_CrimReportParole);
				self.ParoleSentencesEx := DATASET([],iesp.criminal.t_CrimReportParoleEx);
				self.Activities	:= DATASET([],iesp.criminal.t_CrimReportEvent);
			end;
			self.CriminalRecords := PROJECT(DATASET([xformCrim()]),iesp.benefitassessment_fcra.t_FcraBenefitAssessCriminalRecord);
      self := l;			
			self := [];		
		 end; // end of transform
		 
	   esdl_records_seq := project(batchResults_Seq,xformBatchToESDL(left));

     //***********************************************************************************************************		 
		 // PROPERTY read seperately due to the fact that the batch output has 5 current and 5 prior property sections.
		 //***********************************************************************************************************		 
		 
     //get property children
 		 batch_curr_prop := NORMALIZE(batchResults_Seq, 5, BenefitAssessment_Services.Transforms.normCurrProperty(left, counter));
		 batch_prior_prop := NORMALIZE(batchResults_Seq, 5, BenefitAssessment_Services.Transforms.normPriorProperty(left, counter));

		 //load current property children
		 out_rec_seq denorm_current(esdl_records_seq l, DATASET(BenefitAssessment_Services.layouts.norm_prop_rec) r) := transform
			  self.AssessetsAndWealth.CurrentPropertyRecords := project(r,iesp.benefitassessment_fcra.t_FcraBenefitAssessPropertyRecord);
				self := L;
		 end;
		 esdl_records_current := DENORMALIZE(esdl_records_seq, batch_curr_prop, left.seq = right.seq, GROUP, denorm_current(left,ROWS(right)));
     
		 //load prior property children	to data with current already loaded.   		
		 out_rec_seq denorm_prior(esdl_records_seq l, DATASET(BenefitAssessment_Services.layouts.norm_prop_rec) r) := transform
			  self.AssessetsAndWealth.PriorPropertyRecords  := project(r,iesp.benefitassessment_fcra.t_FcraBenefitAssessPropertyRecord);
				self := L;
		 end;    

		 esdl_records := DENORMALIZE(esdl_records_current, batch_prior_prop, left.seq = right.seq, GROUP, denorm_prior(left,ROWS(right)));

		 // remove seq field from output prior to returning.	   
		 return project(esdl_records, iesp.benefitassessment_fcra.t_FcraBenefitAssessRecord);
  end; // end of function

END; //module