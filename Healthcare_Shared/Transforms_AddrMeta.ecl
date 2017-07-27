import Healthcare_Shared,Healthcare_ProviderPoint,Healthcare_Cleaners,std;

export Transforms_AddrMeta := module

	export Healthcare_Shared.Layouts.layout_addrmeta getAddressMeta(Healthcare_Shared.Layouts.layout_addrmeta distinctAddress, Healthcare_Shared.Layouts.CombinedHeaderResults inrec) := transform
		
		today := STD.Date.Today();
		
		self.b_deceased :=  false;
		self.b_retired :=  false;
		
		addressState := distinctAddress.state;
		addrKey := distinctAddress.addr_key;
		isPobox := distinctAddress.pobox<>'';
		
		// license info
		licenseRecs := inrec.RecordsRaw(filecode_enum=m_filecode.FilecodeEnum.LIC);
		licenseActive := licenseRecs((lic1.lic_end_date='' or STD.Date.FromStringToDate(lic1.lic_end_date, '%Y%m%d')>today) and (lic1.lic_status='' or lic1.lic_status='A'));
		licenseActiveInState := licenseActive(lic1.lic_state=addressState);
		licenseInactive := licenseRecs - licenseActive;
		licenseInctiveInState := licenseInactive(lic1.lic_state=addressState);
		
		self.b_active_license_in_state := exists(licenseActiveInState);
		self.b_active_license_in_other_state := exists(licenseActive(lic1.lic_state<>addressState));
		self.b_inactive_license_in_state := not self.b_active_license_in_state and exists(licenseInctiveInState);
		
		self.d_state_lic_begin := map(self.b_active_license_in_state => licenseActiveInState[1].lic1.lic_begin_date,
																	self.b_inactive_license_in_state => licenseInctiveInState[1].lic1.lic_begin_date,
																	'');
		self.d_state_lic_exp   := map(self.b_active_license_in_state => licenseActiveInState[1].lic1.lic_end_date,
																	self.b_inactive_license_in_state => licenseInctiveInState[1].lic1.lic_end_date,
																	'');
																	
		// dea info
		deaRecs := inrec.RecordsRaw(filecode_enum=m_filecode.FilecodeEnum.DEA);
		deaActive := deaRecs(dea1.dea_num_st&Healthcare_Shared.Constants.stat_DEA_Retired=0 and dea1.dea_num_exp<>'' and STD.Date.FromStringToDate(dea1.dea_num_exp, '%Y%m%d')>today);
		deaActiveInState := deaActive(prac1.state=addressState);
		deaInctive := deaRecs - deaActive;
		deaInactiveInState := deaInctive(prac1.state=addressState);
		
		self.b_active_dea_in_state := exists(deaActiveInState);
		self.b_active_dea_in_other_state := exists(deaActive(prac1.state<>addressState));
		self.b_inactive_dea_in_state := not exists(deaActive) and exists(deaInactiveInState);

		d_state_dea_exp := map(self.b_active_dea_in_state => deaActiveInState[1].dea1.dea_num_exp,
													 self.b_inactive_dea_in_state => deaInactiveInState[1].dea1.dea_num_exp,
													 '');
		self.d_state_dea_exp   := STD.Str.Filter(d_state_dea_exp, '0123456789');
		self.d_state_dea_renew := if(self.d_state_dea_exp<>'', Healthcare_Shared.Functions_AddrMeta.createDEARenewDate(d_state_dea_exp), '');
		
		// match records
		pracRecords1 := inrec.RecordsRaw(surrogate_key<>'' and filecode_enum<>m_filecode.FilecodeEnum.CAM and prac1.addr_key=addrKey);
		pracRecords2 := inrec.RecordsRaw(surrogate_key<>'' and filecode_enum<>m_filecode.FilecodeEnum.CAM and prac2.addr_key=addrKey);
		pracRecords3 := inrec.RecordsRaw(surrogate_key<>'' and filecode_enum<>m_filecode.FilecodeEnum.CAM and prac3.addr_key=addrKey);
		pracRecords := pracRecords1 + pracRecords2 + pracRecords3;
		billRecords1 := inrec.RecordsRaw(surrogate_key<>'' and filecode_enum<>m_filecode.FilecodeEnum.CAM and bill1.addr_key=addrKey);
		billRecords2 := inrec.RecordsRaw(surrogate_key<>'' and filecode_enum<>m_filecode.FilecodeEnum.CAM and bill2.addr_key=addrKey);
		billRecords3 := inrec.RecordsRaw(surrogate_key<>'' and filecode_enum<>m_filecode.FilecodeEnum.CAM and bill3.addr_key=addrKey);
		billRecords := billRecords1 + billRecords2 + billRecords3;
		self.record_count := count(pracRecords) + count(billRecords);
		
		// dea
		deaPracRecords := pracRecords(filecode_enum=m_filecode.FilecodeEnum.DEA);
		deaBillRecords := billRecords(filecode_enum=m_filecode.FilecodeEnum.DEA);
		self.dea_count := count(deaPracRecords);
		dea_first_prac := STD.Str.Filter(min(deaPracRecords(dea1.dea_num_exp<>''), dea1.dea_num_exp), '0123456789');
		d_dea_first_prac := if(dea_first_prac<>'', Healthcare_Shared.Functions_AddrMeta.createDEARenewDate(dea_first_prac), '');
		dea_last_prac := STD.Str.Filter(max(deaPracRecords(dea1.dea_num_exp<>''), dea1.dea_num_exp), '0123456789');
		d_dea_last_prac := if(dea_last_prac<>'', Healthcare_Shared.Functions_AddrMeta.createDEARenewDate(dea_last_prac), '');
		dea_first_bill := STD.Str.Filter(if(exists(deaPracRecords), min(deaBillRecords(dea1.dea_num_exp<>''), dea1.dea_num_exp), ''), '0123456789');
		d_dea_first_bill := if(dea_first_bill<>'', Healthcare_Shared.Functions_AddrMeta.createDEARenewDate(dea_first_bill), '');
		dea_last_bill := STD.Str.Filter(if(exists(deaPracRecords), max(deaBillRecords(dea1.dea_num_exp<>''), dea1.dea_num_exp), ''), '0123456789');
		d_dea_last_bill := if(dea_last_bill<>'', Healthcare_Shared.Functions_AddrMeta.createDEARenewDate(dea_last_bill), '');
		
		// npi
		npiPracRecs := pracRecords(filecode_enum=m_filecode.FilecodeEnum.FC_NPI);
		npiBillRecs := billRecords(filecode_enum=m_filecode.FilecodeEnum.FC_NPI);
		self.npi_prac_count := count(npiPracRecs);
		self.npi_bill_count := count(npiBillRecs);
		
		// license
		licPracRecs := pracRecords(filecode_enum=m_filecode.FilecodeEnum.LIC);
		licBillRecs := pracRecords(filecode_enum=m_filecode.FilecodeEnum.LIC);
		self.lic_count := count(dedup(sort(licPracRecs+licBillRecs,surrogate_key),surrogate_key));
		// TODO - don't accumulate min/max from lic begin date for now. We don't know if they've moved around since beginning.
		
		// inact
		inactPracRecs := pracRecords(filecode_enum=m_filecode.FilecodeEnum.INACT or filecode_enum=m_filecode.FilecodeEnum.SKA_INACT);
		// find inact SKA records that have names that do not score well against best name
		badInactPracRecords := inactPracRecs(filecode_enum=m_filecode.FilecodeEnum.SKA_INACT and Healthcare_Shared.Functions.GetNameStrength(Healthcare_Shared.Functions.NameScoreMatch(pre_name,first_name,middle_name,last_name,maturity_suffix,preferred_name,(INTEGER1)gender,inrec.names[1].Title,inrec.names[1].FirstName,inrec.names[1].MiddleName,inrec.names[1].LastName,inrec.names[1].Suffix,inrec.names[1].PreferredFirst,(INTEGER1)inrec.names[1].GenderCd).NameExtendedMatchInfo)<Healthcare_Shared.Constants.NameScoreStrength.Strong);
		inactBillRecs := billRecords(filecode_enum=m_filecode.FilecodeEnum.INACT or filecode_enum=m_filecode.FilecodeEnum.SKA_INACT);
		goodInactPracRecs := inactPracRecs - badInactPracRecords;
		self.inact_count := count(goodInactPracRecs);
		self.d_inact_first_prac := STD.Str.Filter(min(goodInactPracRecs(last_update_date<>''), last_update_date), '0123456789');
		self.d_inact_last_prac := STD.Str.Filter(min(goodInactPracRecs(last_update_date<>''), last_update_date), '0123456789');
		self.d_inact_first_bill := STD.Str.Filter(min(inactBillRecs(last_update_date<>''), last_update_date), '0123456789');
		self.d_inact_last_bill := STD.Str.Filter(min(inactBillRecs(last_update_date<>''), last_update_date), '0123456789');

		// ska
		skaPracRecs := pracRecords(filecode_enum=m_filecode.FilecodeEnum.SKA);
		skaBillRecs := billRecords(filecode_enum=m_filecode.FilecodeEnum.SKA);
		self.pv_prac_count := count(dedup(sort(skaPracRecs,surrogate_key),surrogate_key));
		self.pv_bill_count := count(dedup(sort(skaBillRecs,surrogate_key),surrogate_key));
		self.d_pv_first_prac := STD.Str.Filter(min(skaPracRecs(last_update_date<>''), last_update_date), '0123456789');
		self.d_pv_last_prac := STD.Str.Filter(max(skaPracRecs(last_update_date<>''), last_update_date), '0123456789');
		self.d_pv_first_bill := STD.Str.Filter(min(skaBillRecs(last_update_date<>''), last_update_date), '0123456789');
		self.d_pv_last_bill := STD.Str.Filter(max(skaBillRecs(last_update_date<>''), last_update_date), '0123456789');
		
		// vsf
		vsfPracRecs := pracRecords(filecode_enum=m_filecode.FilecodeEnum.VSF);
		vsfBillRecs := billRecords(filecode_enum=m_filecode.FilecodeEnum.VSF);
		self.vsf_count := count(dedup(sort(vsfPracRecs+vsfBillRecs,surrogate_key),surrogate_key));
		self.d_vsf_first_prac := STD.Str.Filter(min(vsfPracRecs(last_update_date<>''), last_update_date), '0123456789');
		self.d_vsf_last_prac := STD.Str.Filter(max(vsfPracRecs(last_update_date<>''), last_update_date), '0123456789');
		self.d_vsf_first_bill := STD.Str.Filter(min(vsfBillRecs(last_update_date<>''), last_update_date), '0123456789');
		self.d_vsf_last_bill := STD.Str.Filter(max(vsfBillRecs(last_update_date<>''), last_update_date), '0123456789');

		// roster
		rstPracRecords := pracRecords(filecode_enum=m_filecode.FilecodeEnum.ROSTER);
		rstBillRecords := billRecords(filecode_enum=m_filecode.FilecodeEnum.ROSTER);
		rstRecords := rstPracRecords+rstBillRecords;
		self.rst_count := count(dedup(sort(rstRecords,surrogate_key),surrogate_key));
		self.roster_conf := max(rstRecords, source_confidence_score);
		self.b_roster_primary := exists(rstRecords(primary_location='Y'));
		self.d_rst_first_prac := STD.Str.Filter(min(rstPracRecords(last_update_date<>''), last_update_date), '0123456789');
		self.d_rst_last_prac := STD.Str.Filter(max(rstPracRecords(last_update_date<>''), last_update_date), '0123456789');
		self.d_rst_first_bill := STD.Str.Filter(min(rstBillRecords(last_update_date<>''), last_update_date), '0123456789');
		self.d_rst_last_bill := STD.Str.Filter(max(rstBillRecords(last_update_date<>''), last_update_date), '0123456789');
		
		pracRecordsNoInactOrRoster := pracRecords - inactPracRecs - rstPracRecords;
		billRecordsNoInactOrRoster := billRecords - inactBillRecs - rstBillRecords;
		d_first_prac := map(d_dea_first_prac<>'' => STD.Str.Filter(min(min(pracRecordsNoInactOrRoster(last_update_date<>'' and last_update_date<>'0000-00-00'), last_update_date), d_dea_first_prac), '0123456789'),
												STD.Str.Filter(min(pracRecordsNoInactOrRoster(last_update_date<>'' and last_update_date<>'0000-00-00'), last_update_date), '0123456789'));
		d_last_prac  := map(d_dea_last_prac<>'' => STD.Str.Filter(max(max(pracRecordsNoInactOrRoster(last_update_date<>'' and last_update_date<>'0000-00-00'), last_update_date), d_dea_last_prac), '0123456789'),
												STD.Str.Filter(max(pracRecordsNoInactOrRoster(last_update_date<>'' and last_update_date<>'0000-00-00'), last_update_date), '0123456789'));
		d_first_bill := map(d_dea_first_bill<>'' => STD.Str.Filter(min(min(billRecordsNoInactOrRoster(last_update_date<>'' and last_update_date<>'0000-00-00'), last_update_date), d_dea_first_bill), '0123456789'),
												STD.Str.Filter(min(billRecordsNoInactOrRoster(last_update_date<>'' and last_update_date<>'0000-00-00'), last_update_date), '0123456789'));
		d_last_bill  := map(d_dea_last_bill<>'' => STD.Str.Filter(max(max(billRecordsNoInactOrRoster(last_update_date<>'' and last_update_date<>'0000-00-00'), last_update_date), d_dea_last_bill), '0123456789'),
												STD.Str.Filter(max(billRecordsNoInactOrRoster(last_update_date<>'' and last_update_date<>'0000-00-00'), last_update_date), '0123456789'));

		// cam records
		camRecords := inrec.RecordsRaw(filecode_enum=m_filecode.FilecodeEnum.CAM and prac1.addr_key=addrKey);
		camPracRecords := camRecords(((unsigned1)addr_usage)&Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE>0);
		camBillRecords := camRecords(((unsigned1)addr_usage)&Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING>0);
		camRemitRecords := camRecords(((unsigned1)addr_usage)&Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.REMIT>0);
		self.b_cam_service_location := exists(camPracRecords);
		self.b_cam_billing := exists(camBillRecords);
		self.b_cam_remit := exists(camRemitRecords);
		self.cam_prac_count := count(dedup(sort(camPracRecords,rendering_npi,bill_npi,bill_tin),rendering_npi,bill_npi,bill_tin));
		self.cam_bill_count := count(dedup(sort(camBillRecords,rendering_npi,bill_npi,bill_tin),rendering_npi,bill_npi,bill_tin));
		self.cam_remit_count := count(dedup(sort(camRemitRecords,rendering_npi,bill_npi,bill_tin),rendering_npi,bill_npi,bill_tin));
		
		self.type_bill := set(dedup(sort(camRecords(type_bill<>''),type_bill),type_bill),type_bill);
		self.place_service := set(dedup(sort(camRecords(place_service<>''),place_service),place_service),place_service);
		
		self.d_cam_first_prac := STD.Str.Filter(min(min(camPracRecords(earliest_clm_date<>''), earliest_clm_date), min(camPracRecords(latest_clm_date<>''), latest_clm_date)), '0123456789');
		self.d_cam_last_prac := STD.Str.Filter(max(max(camPracRecords(earliest_clm_date<>''), earliest_clm_date), max(camPracRecords(latest_clm_date<>''), latest_clm_date)), '0123456789');
		self.d_cam_first_bill := STD.Str.Filter(min(min(camBillRecords(earliest_clm_date<>''), earliest_clm_date), min(camBillRecords(latest_clm_date<>''), latest_clm_date)), '0123456789');
		self.d_cam_last_bill := STD.Str.Filter(max(max(camBillRecords(earliest_clm_date<>''), earliest_clm_date), max(camBillRecords(latest_clm_date<>''), latest_clm_date)), '0123456789');
		
		self.d_first_prac := map(self.d_cam_first_prac<>'' and d_first_prac<>'' => min(d_first_prac, self.d_cam_first_prac), 
														 self.d_cam_first_prac<>'' => self.d_cam_first_prac,
														 d_first_prac);
		self.d_last_prac := if(self.d_cam_last_prac<>'', max(d_last_prac, self.d_cam_last_prac), d_last_prac);
		self.d_first_bill := map(self.d_cam_first_bill<>'' and d_first_bill<>'' => min(d_first_bill, self.d_cam_first_bill),
														 self.d_cam_first_bill<>'' => self.d_cam_first_bill,
														 d_first_bill);
		self.d_last_bill := if(self.d_cam_last_bill<>'', max(d_last_bill, self.d_cam_last_bill), d_last_bill);

		self.dd_total_prac := if(self.d_first_prac<>'', Healthcare_Shared.Functions_AddrMeta.dateDiffInDays(self.d_first_prac, self.d_last_prac), 0);
		self.dd_total_bill := if(self.d_first_bill<>'', Healthcare_Shared.Functions_AddrMeta.dateDiffInDays(self.d_first_bill, self.d_last_bill), 0);
		self.dd_cam_prac := if(self.d_cam_first_prac<>'', Healthcare_Shared.Functions_AddrMeta.dateDiffInDays(self.d_cam_first_prac, self.d_cam_last_prac), 0);
		self.dd_cam_bill := if(self.d_cam_first_bill<>'', Healthcare_Shared.Functions_AddrMeta.dateDiffInDays(self.d_cam_first_bill, self.d_cam_last_bill), 0);
		
		// get sources
		pracSources := project(pracRecords, transform(Healthcare_Shared.Layouts.layout_FileSource, self := left));
		self.prac_sources := dedup(pracSources,record,all);
		billSources := project(billRecords, transform(Healthcare_Shared.Layouts.layout_FileSource, self := left));
		self.bill_sources := dedup(billSources,record,all);

		dedupCamRecords := dedup(sort(camRecords,rendering_npi,bill_npi,bill_tin),rendering_npi,bill_npi,bill_tin);
		self.cbm1 := sum(dedupCamRecords,cbm1);
		self.cbm3 := sum(dedupCamRecords,cbm3);
		self.cbm6 := sum(dedupCamRecords,cbm6);
		self.cbm12 := sum(dedupCamRecords,cbm12);
		self.cbm18 := sum(dedupCamRecords,cbm18);
		
		// confidence scores
		// Are there lots of recent claims that lead us to believe that they are there in spite of an inactive?
		todayStr := STD.Date.DateToString(today, '%Y%m%d');
		inactDaysSince := if(self.d_inact_last_prac<>'', Healthcare_Shared.Functions_AddrMeta.dateDiffInDays(self.d_inact_last_prac,todayStr), 0);
		cbm3_11 := if('11' in self.place_service, self.cbm3, 0);
		activitySinceInact := cbm3_11>=90 and inactDaysSince>=90;
		decay_rate_per_week := 0.2;
		base_conf := 90;
		
		// practice confidence score
		conf_score_prac := map(self.b_deceased => 1,
													 self.b_retired => 5,
													 length(self.d_inact_last_prac)=8 and (length(self.d_pv_last_prac)=0 or (self.d_inact_last_prac>self.d_pv_last_prac)) and (length(self.d_vsf_last_prac)=0 or (self.d_inact_last_prac>self.d_vsf_last_prac)) and not activitySinceInact => 8,
													 0);
		conf_score_roster := if(self.d_rst_last_prac<>'',
													  (base_conf - decay_rate_per_week * (Healthcare_Shared.Functions_AddrMeta.dateDiffInDays(self.d_rst_last_prac,todayStr) / 7)) * (self.roster_conf/100) * (self.roster_conf/100),
													  0);
		conf_score_roster2 := if(conf_score_roster<0, 0, conf_score_roster);
		conf_score_prac2 := if(self.d_last_prac<>'',
													 base_conf - decay_rate_per_week * (Healthcare_Shared.Functions_AddrMeta.dateDiffInDays(self.d_last_prac,todayStr) / 7),
													 0);
		conf_score_prac3 := if(conf_score_prac2<0, 0, conf_score_prac2);
		self.conf_score_prac := if(conf_score_prac=0, max(conf_score_roster2,conf_score_prac3), conf_score_prac);
		
		// billing confidence score
		conf_score_bill := map(self.b_deceased => 1,
													 self.b_retired => 5,
													 length(self.d_inact_last_bill)=8 and (length(self.d_pv_last_bill)=0 or (self.d_inact_last_bill>self.d_pv_last_bill)) and (length(self.d_vsf_last_bill)=0 or (self.d_inact_last_bill>self.d_vsf_last_bill)) => 8,
													 0);
		conf_score_bill2 := if(conf_score_bill=0 and self.d_last_bill<>'',
													 base_conf - decay_rate_per_week * (Healthcare_Shared.Functions_AddrMeta.dateDiffInDays(self.d_last_bill,todayStr) / 7),
													 conf_score_bill);					 
		conf_score_bill3 := if(conf_score_bill2<0, 0, conf_score_bill2);
		self.conf_score_bill := conf_score_bill3;
		
		// billing score
		self.billing_score := if(self.cam_bill_count>0,if(self.cam_prac_count=0,40,20),0) +
													if(self.npi_bill_count>0,20,0) +
													if(isPobox,60,0);

		// home score
		self.home_score := if(isPobox,0,
													 if(self.lic_count>0,20,0) +
													 if(self.npi_bill_count>0,5,0) +
													 if(self.b_cam_billing,-10,0) +
													 if(self.b_cam_service_location,-10,0) +
													 if(self.dea_count>0,-10,0) +
													 if(self.b_roster_primary,-10,0) +
													 if((self.vsf_count>0) or (self.rst_count>0),-10,0) +
													 if(self.pv_prac_count>0,-15,0));
													 
		// office score
		office_score := if(isPobox,0,
												if(count(self.place_service)>0,if('11' in self.place_service,70,-10),0) +    // if place_service is populated, office/non-office bonus/penalty
												if(self.dea_count>0,50,0) +
												if(self.cam_prac_count>0,10,0) +
												if(self.pv_prac_count>0,10,0) +
												if(self.b_roster_primary,10,0) +
												if(self.npi_prac_count>0,if(self.npi_bill_count>0,20,10),0) +
												if((self.vsf_count>0) or (self.rst_count>0),20,0));      // bonus for having either vsf or roster
		office_score2 := if(isPobox,0,
												office_score +
												if((office_score=0) and exists(self.prac_sources),10,0) +   // bonus for any ref prac addr if score is still == 0
												if('12' in self.place_service,-30,0) +                      // override score and penalize for "Home" place of service
												if('16' in self.place_service,-30,0));                       // override score and penalize for "Temporary Lodging" place of service
		// apply bounds
		self.office_score := if(office_score2<0,0,if(office_score2>100,100,office_score2));

		// practice score
		practice_score := if(isPobox,0,
													if(self.dea_count>0,20,0) +
													if(self.cam_prac_count>0,20,0) +
													if(self.pv_prac_count>0,20,0) +
													if(self.npi_prac_count>0,20,0) +
													if((self.vsf_count>0) or (self.rst_count>0),20,0));      // bonus for having either vsf or roster
		practice_score2 := if(isPobox,0,
													practice_score +
													if(self.b_roster_primary and (practice_score<100),10,0));    // bonus for any ref prac addr if score is still == 0
		practice_score3 := if(isPobox,0,
													practice_score2 +
													if((practice_score2=0) and exists(self.prac_sources),10,0) +
													if('12' in self.place_service,-40,0) +                      // override score and penalize for "Home" place of service
													if('16' in self.place_service,-40,0));                       // override score and penalize for "Temporary Lodging" place of service
		// apply bounds
		self.practice_score := if(practice_score3<0,0,if(practice_score3>100,100,practice_score3));
		
		// bill_addr_score
		self.bill_addr_score := if(self.billing_score=0 or self.b_deceased or self.b_retired, 
															 0,
															 self.conf_score_bill + min(self.billing_score/10,5) + if(self.conf_score_bill>85, min(self.dd_total_bill * 0.027, 5), 0) +
															 if(self.b_active_dea_in_state,1,0) +
															 if(self.b_active_license_in_state,1,0) +
															 if(self.b_inactive_dea_in_state,-20,0) +
															 if(self.b_inactive_license_in_state,-20,0) +
															 if(not self.b_active_dea_in_state and self.b_active_dea_in_other_state,-10,0) +
															 if(not self.b_active_license_in_state and self.b_active_license_in_other_state,-10,0));

		// caf_addr_score
		self.caf_addr_score := if((self.office_score=0 and self.practice_score=0) or self.b_deceased or self.b_retired,
															0,
															self.conf_score_prac + (self.office_score / 20) + if(self.conf_score_prac>85, min(self.dd_total_prac * 0.027, 5), 0) +
															if(self.b_active_dea_in_state,1,0) +
															if(self.b_active_license_in_state,1,0) +
															if(self.b_inactive_dea_in_state,-10,0) +
															if(self.b_inactive_license_in_state,-20,0) +
															if(not self.b_active_dea_in_state and self.b_active_dea_in_other_state,-10,0) +
															if(not self.b_active_license_in_state and self.b_active_license_in_other_state,-10,0) +
															if('12' in self.place_service,-20,0) +
															if(cbm3_11>=30,2,0) +
															if(cbm3_11>=90,5,0) +
															if(cbm3_11>=180,5,0));

		self := distinctAddress;
		self:= [];
		
	end;

end;
