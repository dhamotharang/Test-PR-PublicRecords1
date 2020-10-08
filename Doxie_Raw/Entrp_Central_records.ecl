import ut, doxie_crs, domains, STD;

todays_date := (string)STD.date.Today();

export doxie_crs.layout_report Entrp_Central_records(doxie_crs.layout_report L) := TRANSFORM

  addr_curr := DEDUP(SORT(L.addresses_children,did,-dt_last_seen,record),did);
	doxie_raw.MAC_ENTRP_CLEAN(L.addresses_children,dt_last_seen,addr_entrp);
	addr2_child := if(ut.IndustryClass.EntDateVal =1,addr_curr,addr_entrp);
  self.addresses_children:= addr2_child;

	//PULL residents of address of only past 12 months
  // self.resident_links_children := global(resr);

	doxie_raw.MAC_ENTRP_CLEAN(L.ucc_children,filing_date,ucc_entrp);
  self.ucc_children                       := ucc_entrp;

	//UCCv2 is rollup so needs filter at intermediate level
  // self.uccv2_children                       := uccv2_entrp;

  doxie_raw.MAC_ENTRP_CLEAN(L.corporate_affiliations_children,filing_date,corporate_affiliations_entrp);
  self.corporate_affiliations_children    := corporate_affiliations_entrp;

	doxie_raw.MAC_ENTRP_CLEAN(L.property_children,recording_date,property_entrp);
  self.property_children                  := property_entrp;

	prop2_curr := CHOOSEN(SORT(L.propertyV2_children,-owned,-sortby_date,record),1);
	doxie_raw.MAC_ENTRP_CLEAN(L.propertyV2_children,sortby_date,propertyV2_entrp);
	prop2 := if(ut.IndustryClass.EntDateVal =1,prop2_curr,propertyV2_entrp);
	self.propertyV2_children                  := prop2;

	plrr_active := L.professional_licenses_children(expiration_date > todays_date);
	plrr_inactive := L.professional_licenses_children(expiration_date <= todays_date);
	Doxie_Raw.MAC_ENTRP_CLEAN(plrr_inactive,expiration_date,plrr_entrp);
	plrr_curr := CHOOSEN(SORT(plrr_active+plrr_entrp,-expiration_date,record),1);
	self.professional_licenses_children     := IF(ut.industryClass.entDateVal=1,plrr_curr,plrr_active+plrr_entrp);

	Doxie_Raw.MAC_ENTRP_CLEAN(L.sanction_children,sanc_sancdte_form,sanc_entrp);
	self.sanction_children									:= sanc_entrp;
  // Firearms is rollup ds - added filter at intermediate level
	// self.driverstChildren
	// self.FBNChildren
	// self.provider_children									:= prov_active + prov_entrp;
	// Doxie_Raw.MAC_ENTRP_CLEAN(L.firearms_and_explosives_children,date_last_seen,atfr1_entrp);
  // self.firearms_and_explosives_children   := atfr1_entrp;

	//Pilot Licenses
	pilr_dt_format(string dt) := dt[3..6]+dt[1..2];
	pilr_dt_unformat(string dt) := dt[5..6]+dt[1..4];
  pilr_active := L.pilot_licenses_children(record_type='ACTIVE');
	pilr_inactive := L.pilot_licenses_children(record_type<>'ACTIVE');
	pilr_med_dt := PROJECT(pilr_inactive
													,TRANSFORM(recordof(pilr_inactive)
													,SELF.med_exp_date:= pilr_dt_format(LEFT.med_exp_date),SELF := LEFT));

  Doxie_Raw.MAC_ENTRP_CLEAN(pilr_med_dt,med_exp_date,pilr_entrp_1);
  pilr_entrp :=PROJECT(pilr_entrp_1
													,TRANSFORM(recordof(pilr_entrp_1)
													,SELF.med_exp_date:= pilr_dt_unformat(LEFT.med_exp_date),SELF := LEFT));
	pilr_active_c := CHOOSEN(SORT(pilr_med_dt + pilr_entrp_1,-med_exp_date,record),1);
	pilr_curr :=PROJECT(pilr_active_c
													,TRANSFORM(recordof(pilr_active_c)
													,SELF.med_exp_date:= pilr_dt_unformat(LEFT.med_exp_date),SELF := LEFT));
  self.pilot_licenses_children            := IF(ut.industryClass.entDateVal=1,pilr_curr,pilr_active + pilr_entrp);

	//Pilot Certificates
	cerr_dt_format(string dt) := dt[5..8]+dt[1..2]+dt[3..4];
	cerr_dt_unformat(string dt) := dt[5..6]+dt[7..8]+dt[1..4];
  cerr_active := L.pilot_certificates_children(current_flag='A');
	cerr_inactive := L.pilot_certificates_children(current_flag<>'A');
	cerr_med_dt := PROJECT(L.pilot_certificates_children
													,TRANSFORM(recordof(L.pilot_certificates_children)
													,SELF.cer_exp_date:= cerr_dt_format(LEFT.cer_exp_date),SELF := LEFT));

  Doxie_Raw.MAC_ENTRP_CLEAN(cerr_med_dt,cer_exp_date,cerr_entrp_1);
  cerr_entrp := PROJECT(cerr_entrp_1
													,TRANSFORM(recordof(cerr_entrp_1)
													,SELF.cer_exp_date:= cerr_dt_unformat(LEFT.cer_exp_date),SELF := LEFT));
	cerr_active_c := CHOOSEN(SORT(cerr_med_dt+cerr_entrp_1,-cer_exp_date,record),1);
	cerr_curr := PROJECT(cerr_active_c
													,TRANSFORM(recordof(cerr_active_c)
													,SELF.cer_exp_date:= cerr_dt_unformat(LEFT.cer_exp_date),SELF := LEFT));
  self.pilot_certificates_children        := IF(ut.industryClass.entDateVal=1,cerr_curr,cerr_active+cerr_entrp);

	Doxie_Raw.MAC_ENTRP_CLEAN(L.pilot_aircraft_children,last_Action_date,faar_entrp);
  self.pilot_aircraft_children            := faar_entrp;

	Doxie_Raw.MAC_ENTRP_CLEAN(L.bankruptcies_children,date_filed,bkrr_entrp);
  self.bankruptcies_children              := bkrr_entrp;

	Doxie_Raw.MAC_ENTRP_CLEAN(L.bankruptcies_v2_children,date_filed,bkrr2_entrp);
	self.bankruptcies_v2_children           := bkrr2_entrp;

	Doxie_Raw.MAC_ENTRP_CLEAN(L.liens_judgements_children,filing_date,lier_entrp);
  self.liens_judgements_children          := lier_entrp;

	//doing at intermediate level
  // self.liens_judgements_v2_children       := lier2_entrp;

	dea_active := L.dea_children(expiration_date > todays_date);
	dea_inactive := L.dea_children(expiration_date <= todays_date);
	Doxie_Raw.MAC_ENTRP_CLEAN(dea_inactive,expiration_date,derr_entrp);
	dea_curr := CHOOSEN(SORT(dea_active,-expiration_date,record),1);
  self.dea_children                       := IF(ut.industryClass.entDateVal=1,dea_curr,dea_active+derr_entrp);
  //Filters applied at intermediate level
	// self.deaV2_children                     := dea2_active+derr2_entrp;

	Doxie_Raw.MAC_ENTRP_CLEAN(L.relative_summary_children,recent_cohabit,relr_entrp);
	self.relative_summary_children          := relr_entrp;

	Doxie_Raw.MAC_ENTRP_CLEAN(L.associate_summary_children,recent_cohabit,assr_entrp);
  self.associate_summary_children         := assr_entrp;

	//implemented filters in intermediate levels
  // self.phones_children                    := global(phor);
  // self.phones_old_children                := global(phOld);

	wtcr_active := L.watercraft_children(registration_expiration_date > todays_date);
	wtcr_inactive := L.watercraft_children(registration_expiration_date <= todays_date);
	Doxie_Raw.MAC_ENTRP_CLEAN(wtcr_inactive,registration_expiration_date,wtcr_entrp);
	wtcr_curr := CHOOSEN(SORT(wtcr_active+wtcr_entrp,-registration_expiration_date,record),1);
  self.watercraft_children                := if(ut.industryClass.EntDateVal=1,wtcr_curr,wtcr_active+wtcr_entrp);

	idom_dt := PROJECT(L.netdomain_children,TRANSFORM(recordof({L.netdomain_children,string expiredate1})
	,SELF.expiredate1 := domains.convertdate(LEFT.expire_date),SELF := LEFT));
	idom_active := idom_dt(expiredate1 > todays_date);
	idom_inactive := idom_dt(expiredate1 <= todays_date);
	Doxie_Raw.MAC_ENTRP_CLEAN(idom_inactive,expiredate1,idom_entrp);
	idom_curr := CHOOSEN(SORT(idom_Active+idom_entrp,-expiredate1,record),1);
  self.netdomain_children                 := PROJECT(if(ut.industryClass.EntDateVal=1,idom_curr,idom_active+idom_entrp)
	                                            ,TRANSFORM(recordof(L.netdomain_children),SELF := LEFT));

	Doxie_Raw.MAC_ENTRP_CLEAN(L.employment_children,dt_last_seen,empl_entrp);
  self.employment_children                := empl_entrp;

	nod := PROJECT(L.nod_children,TRANSFORM(recordof({L.nod_children,string record_date})
	,SELF.record_date := (string)LEFT.recordingdate.year+(string)LEFT.recordingdate.month+(string)LEFT.recordingdate.day,SELF := LEFT));
	Doxie_Raw.MAC_ENTRP_CLEAN(nod,record_date,nod_entrp_1);
	nod_entrp := PROJECT(nod_entrp_1,TRANSFORM(recordof(L.nod_children),SELF := LEFT));
  self.nod_children                       := nod_entrp;

	Doxie_Raw.MAC_ENTRP_CLEAN(L.foreclosure_children,filing_date,frcl_entrp);
  self.foreclosure_children               := frcl_entrp;
	//Filter applied at intermediate level
	// Doxie_Raw.MAC_ENTRP_CLEAN(L.phonesplus_children,last_seen,phpl_entrp);
  // self.phonesplus_children								:= phpl_entrp;
	Doxie_Raw.MAC_ENTRP_CLEAN(L.email_children,latest_orig_login_date,email_entrp);
  self.Email_children                      := email_entrp;

	vehi_active := L.vehicle_children(registration_expiration_date > todays_date);
	vehi_inactive := L.vehicle_children(registration_expiration_date > todays_date);
	Doxie_Raw.MAC_ENTRP_CLEAN(vehi_inactive,registration_expiration_date,vehi_entrp);
	vehi_curr := CHOOSEN(SORT(vehi_active+vehi_entrp,-registration_expiration_date,record),1);
	self.vehicle_children := IF(ut.industryClass.EntDateVal=1,vehi_curr,vehi_active+vehi_entrp);
	//Filters applied at intermediate level
	// self.vehicle2_children := IF(not ut.IndustryClass.is_knowx,global(vehi2));

	Doxie_Raw.MAC_ENTRP_CLEAN(L.sex_offenses_children,dt_last_reported,sexo_entrp);
	self.sex_offenses_children := sexo_entrp;

	dlsr_active := L.drivers_licenses_children((string)expiration_Date > todays_date);
	dlsr_inactive := L.drivers_licenses_children((string)expiration_Date <= todays_date);
	Doxie_Raw.MAC_ENTRP_CLEAN(dlsr_inactive,expiration_date,dlsr_entrp);
	dlsr_curr := CHOOSEN(SORT(dlsr_active+dlsr_entrp,-expiration_date,record),1);
	self.drivers_licenses_children := IF(ut.industryClass.EntDateVal=1,dlsr_curr,dlsr_active+dlsr_entrp);

	dlsr2_active := L.drivers_licenses2_children((string)expiration_Date > todays_date);
	dlsr2_inactive := L.drivers_licenses2_children((string)expiration_Date <= todays_date);
	Doxie_Raw.MAC_ENTRP_CLEAN(dlsr2_inactive,expiration_date,dlsr2_entrp);
  dlsr2_curr := CHOOSEN(SORT(dlsr2_active+dlsr2_entrp,-expiration_date,record),1);
	self.drivers_licenses2_children := IF(ut.industryClass.EntDateVal=1,dlsr2_curr,dlsr2_active+dlsr2_entrp);

	Doxie_Raw.MAC_ENTRP_CLEAN(L.doc_children,case_date,docr_entrp);
	self.DOC_children := docr_entrp;

	Doxie_Raw.MAC_ENTRP_CLEAN(L.images_children,date,imar_entrp);
	self.images_children:= imar_entrp;

	self.bankruptcies_v2_indicator 					:= exists(bkrr2_entrp);
	self.corporate_affiliations_indicator 	:= exists(corporate_affiliations_entrp);
	self.propertyV2__indicator							:= exists(propertyV2_entrp(owned));
  SELF := L;
  SELF := [];

END;
