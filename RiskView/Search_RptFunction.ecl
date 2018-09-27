import iesp, risk_indicators, fcra, doxie, ut, RiskView, Suppress, faa, 
	RiskWiseFCRA, PersonContext;
// for now this only supports a single input record -- that's what the fcradataservice restricts too...

EXPORT Search_RptFunction(dataset(Risk_Indicators.Layout_Input) raw_input, 
					boolean LexIDOnlyOnInput, 
					dataset (risk_indicators.Layout_Boca_Shell) bocashell,
					integer BocaShellVersion, 
					string50 DataRestrictionMask = risk_indicators.iid_constants.default_DataRestriction,
					string50 intendedPurpose,	
					string6	SSNMask,
					string6 DOBMask,
					boolean	DLMask,
					boolean isDirectToConsumerPurpose = false) := FUNCTION
		
		returnLayout := RECORD
			unsigned4 Seq;
			iesp.riskview2.t_RiskView2Report;
			string1 ConfirmationSubjectFound;
		END;

		bs := bocashell[1];
		history_date := bs.historydate;
	
		unsigned1 dob_mask_value := Suppress.date_mask_math.MaskIndicator (DOBMask);	
	
		dids_input := dataset ([bs.did], doxie.layout_references);
		nss := ut.getNonSubjectSuppression();
		boolean inquiryRestrict := DataRestrictionMask[Risk_Indicators.iid_constants.posInquiriesRestriction] = '1'; 
		boolean FilterLiens := DataRestrictionMask[risk_indicators.iid_constants.posLiensJudgRestriction]='1' ;
		
  ssn_flags := CHOOSEN (fcra.key_override_flag_ssn (l_ssn=bs.shell_Input.ssn, datalib.NameMatch (bs.shell_Input.fname, bs.shell_Input.mname, bs.shell_Input.lname, fname, mname, lname)<3), risk_indicators.iid_constants.MAX_OVERRIDE_LIMIT);
  did_flags := CHOOSEN (fcra.key_override_flag_did (keyed (l_did=(string)bs.did)), risk_indicators.iid_constants.MAX_OVERRIDE_LIMIT);
  flags := PROJECT (did_flags, fcra.Layout_override_flag) + PROJECT (ssn_flags, fcra.Layout_override_flag);
		flagrecs := CHOOSEN (dedup (flags, ALL), risk_indicators.iid_constants.MAX_OVERRIDE_LIMIT);	

// Watercraft information...
		watercrafts := RiskWiseFCRA._watercraft_data (dids_input, flagrecs, nss);
		watercraftreport := dedup(sort(watercrafts.details, state_origin, watercraft_key[1..10], -sequence_key),
			state_origin, watercraft_key[1..10]);
		watercraft_owner_report := dedup(sort(watercrafts.owners, state_origin, watercraft_key[1..10], -sequence_key), 
			state_origin, watercraft_key[1..10]);
		watercraft_info_join := JOIN(watercraftreport, watercraft_owner_report,
			left.state_origin   = right.state_origin and
			left.watercraft_key = right.watercraft_key and
      left.sequence_key   = right.sequence_key, 
			transform (layouts.layoutOfwatercraf_info, self := left, self := right ),
                   LIMIT (ut.limits.MAX_COASTGUARD_PER_WATERCRAFT, skip));
		watercraft_info := if(bs.watercraft.watercraft_count >= 1, watercraft_info_join, dataset([], layouts.layoutOfwatercraf_info));

		iesp.riskview2.t_Rv2ReportPersonalPropertyRecord formatwatercraft(watercraft_info l, integer c) := TRANSFORM
				self.seq := c;
				self._Type := 'WATERCRAFT';
				self.Description := l.watercraft_make_description;
				self.Id := l.registration_number;
				self.RegistrationDate := iesp.ECL2ESP.toDate((integer)l.registration_date);
				self.RegistrationState := l.st_registration;			
				self.Name := RiskView.Search_RptData.esdlName('', l.fname, l.mname, l.lname, l.name_suffix, l.title);
				self.Address := RiskView.Search_RptData.esdlAddress(l.prim_range, l.predir, l.prim_name, l.suffix,
					l.postdir, l.unit_desig, l.sec_range, '','', l.p_city_name, l.st, l.zip5, l.zip4, '','','');	
				self := [];
		END;
// Aircraft information...
		aircrafts := RiskWiseFCRA._FAA_data (dids_input, flagrecs);
		aircraftreport_duped := dedup(sort(aircrafts.aircrafts, serial_number, -last_action_date), serial_number);
		aircraftreport := if(bs.aircraft.aircraft_count >= 1, aircraftreport_duped, dataset([], faa.layout_aircraft_registration_out_Persistent_ID));
	
	 iesp.riskview2.t_Rv2ReportPersonalPropertyRecord formataircraft(aircraftreport l, integer c) := TRANSFORM
				self.seq := c;
				self._Type := 'AIRCRAFT';
				self.Description := trim(l.aircraft_mfr_name) + ' ' + trim(l.model_name); 
				self.Id := l.serial_number; 
				self.RegistrationDate := iesp.ECL2ESP.toDate((integer)l.cert_issue_date); 
				self.RegistrationState := l.st;
				self.Name := RiskView.Search_RptData.esdlName('', l.fname, l.mname, l.lname, l.name_suffix, l.title);
				self.Address := RiskView.Search_RptData.esdlAddress(l.prim_range, l.predir, l.prim_name, l.addr_suffix,
						l.postdir, l.unit_desig, l.sec_range, '','', l.v_city_name, l.st, l.zip, l.z4, '','','');	
				self := [];
		END;
// Filing Records -- liens -- this calls _Lien_RV_data rather than _Lien_data 
//as _Lien_data can't have just the RV logic
		RiskWiseFCRA._Lien_RV_data(dids_input, flagrecs, liensdata, history_date, bs);
	
		iesp.riskview2.t_Rv2ReportFilingRecord formatliens(liensdata l, integer c) := TRANSFORM
			self.Seq := c;
		ftd := trim(stringlib.stringtouppercase(l.filing_type_desc));
		ftd_suit := ftd not in risk_indicators.iid_constants.setSuitsFCRA and ftd not in Risk_Indicators.iid_constants.set_Invalid_Liens_50;
		ftd_noSuitEviction :=  ftd_suit and l.eviction != 'Y'; 
		evict := 'EVICTION';
		judgment := 'JUDGMENT';
		self.RecordType := MAP(
				l.eviction ='Y' OR ((ftd in risk_indicators.iid_constants.setLandlordTenant) and ftd_suit) => evict,			
				(ftd in risk_indicators.iid_constants.setCivilJudgment_50) and ftd_noSuitEviction => judgment,
				(((ftd in risk_indicators.iid_constants.setFederalTax) and ftd_noSuitEviction)) OR
					 (((ftd in risk_indicators.iid_constants.setOtherTax) and ftd_noSuitEviction)) =>	'LIEN',
				 (ftd in risk_indicators.iid_constants.setForeclosure_50) and ftd_noSuitEviction => judgment,
				 (ftd in risk_indicators.iid_constants.setSmallClaims_50) and ftd_noSuitEviction => judgment,
				 (ftd not in risk_indicators.iid_constants.setPROther) and ftd_noSuitEviction => 'OTHER',
				'');	
			self.Description := if(TRIM(l.eviction)='Y', evict, l.filing_type_desc);
			self.CourtName :=l.agency;
			self.CourtCounty := l.agency_county;
			self.CourtState := l.agency_state;
			self.Amount := l.amount;
			self.Status := if(TRIM(l.release_date)<>'', 'RELEASED', '');
			self.FilingDate := iesp.ECL2ESP.toDate((integer)l.orig_filing_date);
			laDate := if( (integer)l.pdate_last_seen > (integer)l.release_date, (integer)l.pdate_last_seen, (integer)l.release_date);
			self.LastActionDate := iesp.ECL2ESP.toDate(laDate);
   self.DateLastSeen := iesp.ECL2ESP.toDate((integer)l.VendorDateLastSeen);
			//self.ConsumerStatementId := l.ConsumerStatementId;
			self := [];
		END;
// Bankruptcies................	
		RiskWiseFCRA._Bankruptcy_data(dids_input, flagrecs, bankruptcy_search, bankruptcy_, bk_courts_, history_date, bk_withdraws_);
    insurancemode := false;
		bankruptcies_info := join(bankruptcy_search(trim(chapter) in risk_indicators.iid_constants.set_permitted_bk_chapters(BocaShellVersion, insurancemode) ),
															bankruptcy_, (integer)left.did = dids_input[1].did and left.tmsid = right.tmsid);
		bk_layout := recordOf(bankruptcies_info);
	  bankruptcies := if(bs.bjl.bankrupt, bankruptcies_info, dataset([], bk_layout)); 
 
	iesp.riskview2.t_Rv2ReportBankruptcyRecord formatbankruptcies(bankruptcies l, integer c) := TRANSFORM
			self.Seq := c;
			self.Name := RiskView.Search_RptData.esdlName(l.orig_name, l.fname, l.mname, l.lname, '', '');
			self.CaseNumber := l.case_number;
			self.Chapter := l.chapter;
			self.CourtName := l.court_name;
			self.CourtCounty := l.court_location;
			self.Disposition := l.disposition;
			self.FilingDate := iesp.ECL2ESP.toDate((integer)l.date_filed);
			self.LastActionDate := iesp.ECL2ESP.toDate((integer)l.date_last_seen);
			self := [];
		end;
// Criminal...............
		criminalrecs_nonSOs := RiskView.Search_RptData.criminalrecs(dids_input, flagrecs);		
		//filter off so charges
		criminalrecs_preMasks := criminalrecs_nonSOs(offense.offense_score <> 'S' and offender.offense_score <> 'S');
		Suppress.MAC_Mask(criminalrecs_preMasks, criminalrecs, offender.ssn, '', true, false, false, false, '', SSNMask);	
	
		iesp.riskview2.t_Rv2ReportCriminalRecord formatcriminal(criminalrecs l, integer c) := TRANSFORM
			self.Seq := c;
			self.Name := l.names1;
			self.Aliases := l.Aliases1;
			self.Address := RiskView.Search_RptData.esdlAddress(l.offender.prim_range, l.offender.predir, l.offender.prim_name, l.offender.addr_suffix, l.offender.postdir, l.offender.unit_desig, l.offender.sec_range, '','', l.offender.p_city_name, l.offender.st, l.offender.zip5, l.offender.zip4, '','','');
			dob_string := iesp.ECL2ESP.toMaskableDatestring8(l.offender.dob);
			masked_dob := iesp.ECL2ESP.ApplyDateStringMask(dob_string, dob_mask_value);
			self.DOB := masked_dob;			
			self.SSN := l.offender.ssn;
			self.State := l.offender.orig_state;
			self.CaseNumber := l.offender.case_num;
			dt := if( l.offense.fcra_date <> '', l.offense.fcra_date, l.offender.fcra_date);
			typ :=if( l.offense.offense_score <> '', l.offense.offense_score, l.offender.offense_score);
			self.OffenseDate := iesp.ECL2ESP.toDate((integer)dt);
			self.Charge := l.offense.chg;
			self._Type:= map(typ ='F' => 'FELONY',
											 typ ='M' => 'MISDEMEANOR',
											 'UNKNOWN'
												);
			self := [];
		end;
// sexOffender .....................
		sorecs_preMasks := RiskView.Search_RptData.sexOffenderRecs(dids_input, flagrecs);		
		Suppress.MAC_Mask(sorecs_preMasks, sorecs, ssn, '', true, false, false, false, '', SSNMask);
		
		iesp.riskview2.t_Rv2ReportOffenderRegistryRecord formatSO(Sorecs l, integer c) := TRANSFORM
			self.Seq := c;
			self.Name := l.names1;
			self.Aliases := l.Aliases1;
			self.Address := RiskView.Search_RptData.esdlAddress(l.prim_range, l.predir, l.prim_name, l.addr_suffix, l.postdir, l.unit_desig, l.sec_range, '','', l.p_city_name, l.st, l.zip5, l.zip4, '','','');
			dob_string := iesp.ECL2ESP.toMaskableDatestring8(l.dob);
			masked_dob := iesp.ECL2ESP.ApplyDateStringMask(dob_string, dob_mask_value);
			self.DOB := masked_dob;
			self.SSN := l.ssn;
			self.RegistrationCounty := l.registration_county;
			self := [];
		end;

// student .....................
		amstudent_recs := RiskView.Search_RptData.americanstudentrecs(dids_input, flagrecs);
	  amstudentrecs :=	if(bs.student.file_type != '' or bs.student.rec_type != '', amstudent_recs, dataset([],layouts.Layout_AmStudent)); 
		alloystudent_recs := RiskView.Search_RptData.alloystudentrecs(dids_input, flagrecs);
	  alloystudentrecs :=	if(bs.student.file_type != '' or bs.student.rec_type != '', alloystudent_recs, dataset([],layouts.Layout_Alloy)); 
		
		iesp.riskview2.t_Rv2ReportEducationRecord formatamstudent(amstudentrecs l, integer c):= TRANSFORM
			self.Seq := c;
			self.Name := RiskView.Search_RptData.esdlName(l.full_name, l.fname, l.mname, l.lname, l.name_suffix, l.title);
			self.Address := RiskView.Search_RptData.esdlAddress(l.prim_range, l.predir, l.prim_name, l.addr_suffix, l.postdir, l.unit_desig, l.sec_range, '','', l.p_city_name, l.st, l.z5, l.zip4, '','','');
			self.SchoolCode := l.code_exploded;
			self.SchoolType := l.type_exploded;
			self.SchoolName := l.ln_college_name;
			self.FieldOfStudy := l.college_major_exploded;
			self := [];
		END;
		iesp.riskview2.t_Rv2ReportEducationRecord formatalloystudent(alloystudentrecs l, integer c):= TRANSFORM
			self.Seq := c;
			self.Name := RiskView.Search_RptData.esdlName('', l.clean_fname, l.clean_mname, l.clean_lname, l.clean_name_suffix, l.clean_title);
			self.Address := RiskView.Search_RptData.esdlAddress(l.clean_prim_range, l.clean_predir, l.clean_prim_name, l.clean_addr_suffix, l.clean_postdir, l.clean_unit_desig, l.clean_sec_range, '','', l.clean_p_city_name, l.clean_st, l.clean_zip5, l.clean_zip4, '','','');
			self.SchoolCode := l.code_exploded;
			self.SchoolType := l.type_exploded;
			self.SchoolName := l.ln_college_name;
			self.FieldOfStudy := l.college_major_exploded;
			self := [];
		END;
//  License.......................Prof_lics
		proflicenserecs := RiskWiseFCRA._Prof_License_data(dids_input, flagrecs, isDirectToConsumerPurpose);
		licenserecs :=	if(bs.professional_license.professional_license_flag = true or 
					bs.professional_license.license_type != '', proflicenserecs, group(dataset([], layouts.layout_proflic), prolic_key));
					
	iesp.riskview2.t_Rv2ReportLicenseRecord formatlicenserecs(licenserecs l, integer c):= TRANSFORM
			self.Seq := c;
			self.Name := RiskView.Search_RptData.esdlName(l.orig_name, l.fname, l.mname, l.lname, l.name_suffix, l.title);
			self.Address := RiskView.Search_RptData.esdlAddress(l.prim_range, l.predir, l.prim_name, l.suffix, l.postdir, l.unit_desig, l.sec_range, '','', l.p_city_name, l.st, l.zip, l.zip4, '','','');
			self._Type := l.license_type;
			self.LastReported := iesp.ECL2ESP.toDate((integer)l.date_last_seen);
			self.Source := l.vendor;
			self := [];
		END;

//  Business Associates .............PAW
		pawrecs := RiskWiseFCRA._PAW_data(dids_input, flagrecs);
		
		iesp.riskview2.t_Rv2ReportBusinessAssociationRecord formatpeopleatwork(pawrecs l, integer c) := TRANSFORM
			self.Seq := c;
			self.Name := RiskView.Search_RptData.esdlName('', l.fname, l.mname, l.lname, l.name_suffix, l.title);
			self.Address := RiskView.Search_RptData.esdlAddress(l.prim_range, l.predir, l.prim_name, l.addr_suffix, l.postdir, l.unit_desig, l.sec_range, '','', l.city, l.state, l.zip, l.zip4, '','','');
			self.Title := l.company_title;
			self.Company := l.company_name;
			self.CompanyAddress := RiskView.Search_RptData.esdlAddress(l.company_prim_range, l.company_predir, l.company_prim_name, l.company_addr_suffix, l.company_postdir, l.company_unit_desig, l.company_sec_range, '','', l.company_city, l.company_state, l.company_zip, l.company_zip4, '','','');
			self.Status := l.company_status;
			self.FirstReport := iesp.ECL2ESP.toDate((integer)l.dt_first_seen);
			self.LastReport := iesp.ECL2ESP.toDate((integer)l.dt_last_seen);
			self := [];
		END;

//  Inquiry ...................
		inquiryrecs1 := RiskView.Search_RptData.inquiryrecs(dids_input, flagrecs); // these will need to be filtered...
		inquiryrecs := inquiryrecs1(permissions.fcra_purpose in ['100','164', '106']);
		iesp.riskview2.t_Rv2ReportCreditInquiryRecord formatinquiryrecs(inquiryrecs l, integer c) := TRANSFORM
			self.Seq := c;
			self.Date := iesp.ECL2ESP.toDate((integer)l.search_info.datetime);
			self._Type := map( l.permissions.fcra_purpose = '100' => 'EXTENSION OF CREDIT',
												 l.permissions.fcra_purpose = '164' => 'COLLECTIONS',
												 l.permissions.fcra_purpose = '106' => 'DEMAND DEPOSIT / CHECKING',
												 'UNKNOWN'); // these are filtered -- this will not happen.
			indstr := StringLib.StringToUpperCase(TRIM(l.bus_intel.industry));
			self.Industry := map( indstr in Constants.inq_short_types => Constants.inq_short_term,
														indstr in Constants.inq_card_types => Constants.inq_card,			
														indstr = Constants.inq_retail_types => Constants.inq_retail,
														indstr in Constants.inq_auto_types => Constants.inq_auto,
														indstr = Constants.inq_comm => Constants.inq_telcomm,
														indstr = Constants.inq_util => Constants.inq_util,
														indstr in Constants.inq_coll_types => Constants.inq_coll,
																			Constants.inq_other);
			self := [];
		END;

// Short term loans.............
		impulse_recs := RiskView.Search_RptData.impulserecs(dids_input, flagrecs, isDirectToConsumerPurpose);
		//don't use the check against bocashell as that is in last 7 years and does more verification than this does
		impulse_recs_fltrs := impulse_recs(ut.DaysApart(Risk_Indicators.iid_constants.myGetDate(history_date),(string8)(DateVendorLastReported[1..6] + '01')) < ut.DaysInNYears(1));
	
		iesp.riskview2.t_Rv2ReportLoanOfferRecord formatimpulserecs(impulse_recs l, integer c) := TRANSFORM
			self.Seq := c;
			self.Name := RiskView.Search_RptData.esdlName('', l.cln_fname, l.cln_mname, l.cln_lname, l.cln_name_suffix, '');
			// impulse doesn't have the full clean address, but esdlAddress will supply it.
			self.Address := RiskView.Search_RptData.esdlAddress( '','','','','','','', l.address1, l.address2, l.city, l.state, l.zip, '', '','','');
			self.Date := iesp.ECL2ESP.toDate((integer)(l.lastmodified[1..4]+l.lastmodified[6..7]+l.lastmodified[9..10]));
			self := [];
		END;
		impulse_recs_final := project(impulse_recs_fltrs, formatimpulserecs(left, counter));	

		thriverecs := RiskView.Search_RptData.thriverecs(dids_input, flagrecs); // need to be filtered by 'PD' src (payday) which is really 'T$'

		iesp.riskview2.t_Rv2ReportLoanOfferRecord formatthriverecs(thriverecs l, integer c) := TRANSFORM 
			self.Seq := c;
			self.Name := RiskView.Search_RptData.esdlName('', l.fname, l.mname, l.lname, l.name_suffix, l.title);
			self.Address := RiskView.Search_RptData.esdlAddress(l.prim_range, l.predir, l.prim_name, l.addr_suffix, l.postdir, l.unit_desig, l.sec_range, l.orig_addr,'', l.p_city_name, l.st, l.zip, l.zip4, '','','');
			self.Date := iesp.ECL2ESP.toDate((integer)(l.dt_first_seen));
			self := [];
		END;
		fixdate(d) := map( d = 0 => iesp.ECL2ESP.toDate(0), // if zero, leave blank
											 d < 10000 => iesp.ECL2ESP.toDate((d*10000) + 101), // no month / day
											 d < 1000000 => iesp.ECL2ESP.toDate((d*100) + 1), // no day
											 iesp.ECL2ESP.toDate(d));
	
// Property .......................
		property_recs := RiskView.Search_RptData.propertyrecs(bocashell, DataRestrictionMask);
		prop_recs :=	if(bs.address_verification.sold.property_total >= 1 or 
							bs.address_verification.owned.property_total >= 1, property_recs,
							group(dataset([], Risk_Indicators.Layouts.Layout_Relat_Prop_Plus_BusInd),seq)); 		
	
		propertyrecs :=	sort(prop_recs,  -purchase_date);	

		iesp.riskview2.t_Rv2ReportRealPropertyRecord formatpropertyrecs(Risk_Indicators.Layouts.Layout_Relat_Prop_Plus_BusInd l, integer c) := TRANSFORM
			self.Seq := c;
			self.Address := RiskView.Search_RptData.esdlAddress(l.prim_range, l.predir, l.prim_name, l.addr_suffix, l.postdir, l.unit_desig, l.sec_range, '','', l.city_name, l.st, l.zip5, '', '','','');
			self.Status := if(l.property_status_applicant = 'O', 'CURRENT', 'PREVIOUS');
			self.PurchaseDate := iesp.ECL2ESP.toDate((integer)(l.purchase_date));
			self.PurchasePrice := (string) l.purchase_amount;
			self.SaleDate := iesp.ECL2ESP.toDate((integer)(l.sale_date1));
			self.SalePrice := (string) l.sale_price1;
			self.AssessedValue := (string) l.assessed_total_value;// l.assessed_amount;
			self.AssessedDate := fixdate((integer)(l.assessed_value_year));
			self := [];
		END;
		final_propertyrecs :=	project(propertyrecs, formatpropertyrecs(left, counter));
		
// Consumer Statement .............
		ConsumerStatements := RiskView.Search_RptData.consumerstmt(bocashell);

// AddressHistory .................
		iesp.riskview2.t_Rv2ReportAddressHistoryRecord formathistoryrecs(Layouts.addrhist_layout l, integer c) := TRANSFORM
			self.Seq := c;	
			self.Address := RiskView.Search_RptData.esdlAddress(l.prim_range, l.predir,
				l.prim_name, l.suffix, l.postdir, l.unit_desig,l.sec_range, '','', 
				l.city_name, l.st, l.zip, '', '','','');	
			self.from := fixdate((integer) l.dt_first_seen);
			self.to := fixdate((integer) l.dt_last_seen);
			self.Characteristics := l.AddrCharacteristics;
			self.LandUse := l.land_use;
			self.AssessedValue := l.assessmentprice;
			self.AssessedDate :=fixdate((integer)(l.assessmentdate));
			self := [];
		END;
		addr_History_all := RiskView.Search_RptData.addrHistory2(bocashell, flagrecs, BocaShellVersion,  
				DataRestrictionMask, ungroup(propertyrecs));
				//can only show last 5 years of address history BUT summary needs all the address history
		addr_History2 := group(ungroup(addr_History_all(ut.DaysApart( 
			 Risk_Indicators.iid_constants.myGetDate(historydate),(string8)(dt_last_seen[1..6] + '01')) < ut.DaysInNYears(5))),seq);		
		final_addr_History2 := project(addr_History2, formathistoryrecs(left, counter));	


// Build final report record							
		returnLayout makereport(risk_indicators.Layout_Boca_Shell l) := TRANSFORM
			self.seq := l.seq;
			
   add_hist := ungroup(addr_History_all);
			self.Summary := RiskView.Search_RptData.summary(add_hist, l, inquiryRestrict, raw_input, 
				LexIDOnlyOnInput, SSNMask, dob_mask_value);
			self.AddressHistories := ungroup(final_addr_History2);;
			wc := project(watercraft_info, formatwatercraft(left, counter));
			ac := project(aircraftreport, formataircraft(left, counter));
			self.RealProperties := ungroup(final_propertyrecs);
			self.PersonalProperties := project(sort(wc + ac, -iesp.ECL2ESP.DateToString(RegistrationDate)), TRANSFORM(iesp.riskview2.t_Rv2ReportPersonalPropertyRecord, self.seq:=counter, self := left));
		
    self.FilingRecords := if(FilterLiens,  
      project(risk_indicators.iid_constants.ds_Record,
            transform(iesp.riskview2.t_Rv2ReportFilingRecord, self := [])),
      project(sort(liensdata, -(integer) VendorDateLastSeen, -(integer) orig_filing_date,
      -(integer) Release_Date ), formatliens(left, counter))); 
		
   self.Bankruptcies := project(sort(bankruptcies, -date_last_seen), formatbankruptcies(left, counter)); 
			self.Criminal.CriminalRecords := project(sort(criminalrecs, -offender.fcra_date), formatcriminal(left, counter));
			self.Criminal.OffenderRegistryRecords := project(sorecs, formatSO(left, counter));
			s1 := project(amstudentrecs, formatamstudent(left, counter));
			s2 := project(alloystudentrecs, formatalloystudent(left, counter));
			self.EducationRecords := project(s1 + s2,TRANSFORM(iesp.riskview2.t_Rv2ReportEducationRecord, self.Seq := counter, self := left)); // get a date so we can order?
			self.Licenses := project(sort(ungroup(licenserecs), -date_last_seen), formatlicenserecs(left, counter));
			self.BusinessAssociations := project(sort(pawrecs, -dt_last_seen), formatpeopleatwork(left, counter));
			self.CreditInquiries := if( not inquiryRestrict, project(sort(inquiryrecs, -search_info.datetime), formatinquiryrecs(left, counter)));
			l1 := impulse_recs_final;
			l2 := project(thriverecs(ut.DaysApart(RiskView.Search_RptData.historydate(l.historydate),dt_last_seen[1..8]) < ut.DaysInNYears(1)), formatthriverecs(left, counter));
			self.LoanOffers :=project(sort(l1 + l2, -iesp.ECL2ESP.DateToString(Date)), TRANSFORM(iesp.riskview2.t_Rv2ReportLoanOfferRecord, self.seq:=counter, self := left));
			isCollections := StringLib.StringToUpperCase(TRIM(intendedPurpose)) = Constants.inq_coll;
			
			self.ConsumerStatement := ConsumerStatements[1].cs_text;  // after all products are turned on to use personContext, this will be changing
			// self.ConsumerStatement := bocashell_in[1].ConsumerStatements(trim(StatementType)=PersonContext.Constants.RecordTypes.CS)[1].Content;  // after all products are turned on to use personContext function, this will also need to be updated and get rid of old search
			self.ConfirmationSubjectFound := if(riskview.constants.noscore(l.iid.nas_summary,l.iid.nap_summary, l.address_verification.input_address_information.naprop, l.truedid),
				'0',  // subject not found
				'1');  // subject found
			self := [];
		END;
		// OUTPUT (watercrafts.owners, NAMED ('watercraft'));
		// OUTPUT (watercrafts.coastguard, NAMED ('watercraft_coastguard'));
		// OUTPUT (watercrafts.details, NAMED ('watercraft_details'));
//		 OUTPUT (aircrafts.aircrafts, NAMED ('aircraft'));
		// OUTPUT (aircrafts.aircraft_details, NAMED ('aircraft_details'));
		// OUTPUT (aircrafts.aircraft_engine, NAMED ('aircraft_engine'));
		// OUTPUT (aircrafts.pilot_registrations, NAMED ('pilot_registration'));
		// OUTPUT (aircrafts.pilot_certificates, NAMED ('pilot_certificate'));
//		 output(aircraftreport, named('aircrafts'));
//		 output(liensdata, named('liensdata')); 
//		 output(bankruptcies, named('bankruptcies'));
//		 OUTPUT (criminalrecs,      NAMED ('offenders'));
//		 output(amstudentrecs, named('americanstuden'));
//		 output(alloystudentrecs, named('alloystudent'));
		// output(licenserecs, named('license'));
		// output(pawrecs, named('busassoc'));
		// output(inquiryrecs, named('inquiry'));
		// output(propertyrecs, named('prop'));
//		output(addrHistory, named('addrhist'));
//		  output(impulserecs, named('impulse'));
//		OUTPUT (criminalrecs.offenses,       NAMED ('offenses'));
//		OUTPUT (criminalrecs.punishments,    NAMED ('punishment'));
//		OUTPUT (criminalrecs.offenders_plus, NAMED ('offenders_plus'));
//		OUTPUT (criminalrecs.court_offenses, NAMED ('court_offenses'));
//		OUTPUT (criminalrecs.activity,       NAMED ('activity'));
			// output(addr_History1, named('addr_History1'));
		// output(outfile, named('outfile'));
		// output(best_data4did, named('best_data4did'));
		// output(prop_recs, named('prop_recs'));
  // output(history_date, named('history_date'));
		final_report := project(choosen(bocashell,1), makereport(left));
	// OUTPUT(	flagrecs, NAMED('Iflagrecs'));
  // OUTPUT(flags, NAMED('flags'));
  // OUTPUT(did_flags, NAMED('did_flags'));
  // output(bs, named('bs'));
		return final_report;
END;