import _Control, doxie_files, FCRA, ut, liensv2, riskwise, Risk_Indicators, STD, PersonContext;
onThor := _Control.Environment.OnThor;

export Boca_Shell_Liens_LnJ_FCRA (integer bsVersion, unsigned8 BSOptions=0, 
		GROUPED DATASET(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus) w_corrections,
		boolean IncludeLnJ = false, 
		GROUPED DATASET (risk_indicators.Layout_output) iid_withPersonContext,
    integer2 ReportingPeriod = 84 ) := function
 

	todaysdate := (string) risk_indicators.iid_constants.todaydate;
	// if the bsOption is turned on to remove liens, use the w_bankruptcy data prior to the liens joins
	FilterLiens := (BSOptions & risk_indicators.iid_constants.BSOptions.FilterLiens) > 0;
	FilterCityLiens := (BSOptions & risk_indicators.iid_constants.BSOptions.CityTaxLien) > 0;
	FilterCountyLiens := (BSOptions & risk_indicators.iid_constants.BSOptions.CountyTaxLien) > 0;
	FilterStateWarrent := (BSOptions & risk_indicators.iid_constants.BSOptions.StateTaxWarrant) > 0;
	FilterStateLiens := (BSOptions & risk_indicators.iid_constants.BSOptions.StateTaxLien) > 0;
	FilterFederalLiens := (BSOptions & risk_indicators.iid_constants.BSOptions.FederalTaxLien) > 0;
	FilterOtherLiens := (BSOptions & risk_indicators.iid_constants.BSOptions.OtherLien) > 0;
	FilterJudgments := (BSOptions & risk_indicators.iid_constants.BSOptions.Judgment) > 0;
	FilterEvictions := (BSOptions & risk_indicators.iid_constants.BSOptions.Eviction) > 0;
	FilterSSNs := (BSOptions & risk_indicators.iid_constants.BSOptions.SSNLienFtlr) > 0;
	FilterBcb := (BSOptions & risk_indicators.iid_constants.BSOptions.BCBLienFtlr) > 0;

	Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_LnJ add_liens(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus le, liensv2.key_liens_did_FCRA ri) :=
	TRANSFORM
		SELF.rmsid := ri.rmsid;
		self.tmsid := ri.tmsid;
		SELF := le;
		SELF := [];//name_type & Orig_name
	END;

	liens_added_roxie := JOIN(w_corrections, liensv2.key_liens_did_FCRA, 
											keyed(LEFT.did=RIGHT.did),
											add_liens(LEFT,RIGHT), LEFT OUTER, atmost(riskwise.max_atmost), keep(100));

	liens_added_thor := JOIN(distribute(w_corrections, hash64(did)), 
											distribute(pull(liensv2.key_liens_did_FCRA), hash64(did)), 
											LEFT.did=RIGHT.did,
											add_liens(LEFT,RIGHT), LEFT OUTER, atmost(riskwise.max_atmost), keep(100), local);
											
	#IF(onThor)
		liens_added := group(sort(distribute(liens_added_thor, hash64(seq)), seq, LOCAL), seq, LOCAL);
	#ELSE
		liens_added := liens_added_roxie;
	#END
  
	MAC_liensParty_transform(trans_name, key_liens_party) := MACRO	

	Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_working trans_name(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_LnJ le, key_liens_party ri) := TRANSFORM
		
		self.tmsid := if(ri.tmsid='', '', le.tmsid);	
		self.rmsid := if(ri.rmsid='', '', le.rmsid);
		self.date_last_seen := (unsigned) ri.date_last_seen; //at defendant level so take here over at main where it's all defendants
		self.date_first_seen := (unsigned) ri.date_first_seen;
		self.name_type := ri.name_type;
		//orig_name is not parsed/cleaned...so need to use the cleaned name fields
		self.orig_name := Risk_Indicators.iid_constants.CreateFullName(ri.title, ri.fname, ri.mname, ri.lname, ri.name_suffix);
		self.Party_PersistId := (string) ri.persistent_record_id;
		SELF := le;
		SELF := [];
	END;

	endmacro;
	MAC_liensParty_transform(get_liensparty_raw, liensv2.key_liens_party_id_FCRA);
	MAC_liensParty_transform(get_liensparty_corrections, fcra.key_Override_liensv2_party_ffid);

	liens_party_raw_roxie := JOIN (liens_added, liensv2.key_liens_party_id_FCRA, 
              LEFT.rmsid<>'' AND
							keyed(LEFT.rmsid=RIGHT.rmsid) AND keyed(left.tmsid=right.tmsid) and 
							left.did=(unsigned)right.did and
							(unsigned3)(RIGHT.date_first_seen[1..6]) < left.historydate AND (unsigned)RIGHT.date_first_seen<>0 and	// date first seen was blank on some records
							right.name_type='D' and
					  (string50)right.tmsid + (string50)right.rmsid not in left.lien_correct_tmsid_rmsid  // old way - exclude corrected records from prior to 11/13/2012
							and trim((string)right.persistent_record_id) not in left.lien_correct_tmsid_rmsid  // new way - exclude corrected records that match the persistent_record_id										
							and if(FilterSSNs, Risk_indicators.iid_constants.GoodSSNLength(RIGHT.SSN), TRUE),//if filter is not set return ALL
							get_liensparty_raw(LEFT,RIGHT), LEFT OUTER,
							ATMOST(keyed(LEFT.rmsid=RIGHT.rmsid) AND keyed(left.tmsid=right.tmsid), riskwise.max_atmost));

	liens_party_raw_thor_rmsid := JOIN (distribute(liens_added(rmsid<>''), hash64(rmsid)), 
							distribute(pull(liensv2.key_liens_party_id_FCRA(name_type='D')), hash64(rmsid)), 
							(LEFT.rmsid=RIGHT.rmsid) AND (left.tmsid=right.tmsid) and 
							left.did=(unsigned)right.did and
							(unsigned3)(RIGHT.date_first_seen[1..6]) < left.historydate AND (unsigned)RIGHT.date_first_seen<>0 and	// date first seen was blank on some records
      (string50)right.tmsid + (string50)right.rmsid not in left.lien_correct_tmsid_rmsid  // old way - exclude corrected records from prior to 11/13/2012
							and trim((string)right.persistent_record_id) not in left.lien_correct_tmsid_rmsid  // new way - exclude corrected records that match the persistent_record_id										
							and if(FilterSSNs, Risk_indicators.iid_constants.GoodSSNLength(RIGHT.SSN), TRUE),//if filter is not set return ALL
							get_liensparty_raw(LEFT,RIGHT), LEFT OUTER,
							ATMOST((LEFT.rmsid=RIGHT.rmsid) AND (left.tmsid=right.tmsid), riskwise.max_atmost), LOCAL);

	liens_party_raw_thor := group(sort(liens_party_raw_thor_rmsid + 
							project(liens_added(rmsid=''), 
							transform(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_working, self := left, self := [])), seq, local), seq, local);

	//we want the earliest date filed so order party info to keep that info
	#IF(onThor)
		liens_party_raw := liens_party_raw_thor;
	#ELSE
		liens_party_raw := liens_party_raw_roxie;
	#END
  
	unique_ffids := dedup(sort(liens_added,did), did);
	 
	liens_party_overrides_roxie := JOIN (unique_ffids, fcra.key_Override_liensv2_party_ffid,
											exists(left.lien_correct_ffid) and
											keyed(right.flag_file_id IN left.lien_correct_ffid) and 
											left.did=(unsigned)right.did and
											(unsigned3)(RIGHT.date_first_seen[1..6]) < left.historydate AND (unsigned)RIGHT.date_first_seen<>0 and	// date first seen was blank on some records
           right.name_type='D'
											and if(FilterSSNs, Risk_indicators.iid_constants.GoodSSNLength(RIGHT.SSN), TRUE),//if filter is not set return ALL								
											get_liensparty_corrections(LEFT, RIGHT),
											ATMOST(riskwise.max_atmost));

	liens_party_overrides_thor := JOIN (unique_ffids(exists(lien_correct_ffid)), pull(fcra.key_Override_liensv2_party_ffid),
											right.flag_file_id IN left.lien_correct_ffid and 
											left.did=(unsigned)right.did and
											(unsigned3)(RIGHT.date_first_seen[1..6]) < left.historydate AND (unsigned)RIGHT.date_first_seen<>0 and	// date first seen was blank on some records
           right.name_type='D'
											and if(FilterSSNs, Risk_indicators.iid_constants.GoodSSNLength(RIGHT.SSN), TRUE),//if filter is not set return ALL								
											get_liensparty_corrections(LEFT, RIGHT), ALL, LOCAL);
					
	#IF(onThor)
		liens_party_overrides := liens_party_overrides_thor;
	#ELSE
		liens_party_overrides := liens_party_overrides_roxie;
	#END

	MAC_liensMain_transform(trans_name, key_liens_main) := MACRO	

	Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_working trans_name(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_working le, key_liens_main ri) := transform
		isEviction := ri.eviction='Y';
		self.evictionInd := isEviction;
		//set variables for these fields and take from party key as that has the defendant info. Where as main has all the parties info
		releasedDate := (string) le.date_last_seen ;
		OrigDateFiled := (string) le.date_first_seen;
		SELF.VendorDateLastSeen := ri.collection_date;
		SELF.date_first_seen := (unsigned) OrigDateFiled;
		SELF.date_last_seen :=(unsigned)  releasedDate;
		myGetDate := iid_constants.myGetDate(le.historydate);
		isRecent := ut.DaysApart(OrigDateFiled,myGetDate)<365*2+1;

		// Unreleased Liens--------------------------------
		tmp_lnj_recent_unreleased_count := (INTEGER)(ri.rmsid<>'' AND 
																					 (INTEGER)releasedDate=0 AND
																						isRecent);
		tmp_lnj_historical_unreleased_count := (INTEGER)(ri.rmsid<>'' AND 
																							(INTEGER)releasedDate=0 AND
																							~isRecent);																						
		tmp_lnj_unreleased_count12 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)releasedDate=0 and 
																					Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)OrigDateFiled,ut.DaysInNYears(1)));
																																										
		// Released Liens	-----------------------------------																		
		tmp_lnj_recent_released_count := (INTEGER)(ri.rmsid<>'' AND 
																				(INTEGER)releasedDate<>0 AND
																				isRecent);
		tmp_lnj_historical_released_count := (INTEGER)(ri.rmsid<>'' AND 
																						(INTEGER)releasedDate<>0 AND
																						~isRecent);
		tmp_lnj_released_count12 := (INTEGER)(ri.rmsid<>'' AND (INTEGER)releasedDate<>0 and 
																				Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)OrigDateFiled,ut.DaysInNYears(1)));

		tmp_lnj_last_unreleased_date := if((INTEGER)releasedDate=0, OrigDateFiled, '');																			
		tmp_lnj_last_released_date := if((INTEGER)releasedDate<>0, (unsigned)OrigDateFiled, 0);
		
		self.tmsid := if(ri.tmsid='', '', le.tmsid);	// set these to blank so that we miss on the evictions search below
		self.rmsid := if(ri.rmsid='', '', le.rmsid);
		tmp_lnj_last_jgmt_unreleased_date := if((INTEGER)releasedDate=0, OrigDateFiled, '');																			
		tmp_lnj_last_jgmt_released_date := if((INTEGER)releasedDate<>0, (unsigned)OrigDateFiled, 0);
		tmp_lnj_last_lien_unreleased_date := if((INTEGER)releasedDate=0, OrigDateFiled, '');																			
		tmp_lnj_last_lien_released_date := if((INTEGER)releasedDate<>0, (unsigned)OrigDateFiled, 0);
		tmp_lnj_last_allTax_unreleased_date := if((INTEGER)releasedDate=0, OrigDateFiled, '');																			
		tmp_lnj_last_allTax_released_date := if((INTEGER)releasedDate<>0, (unsigned)OrigDateFiled, 0);
		tmp_lnj_last_state_unreleased_date := if((INTEGER)releasedDate=0, OrigDateFiled, '');																			
		tmp_lnj_last_state_released_date := if((INTEGER)releasedDate<>0, (unsigned)OrigDateFiled, 0);
		tmp_lnj_last_federal_unreleased_date := if((INTEGER)releasedDate=0, OrigDateFiled, '');																			
		tmp_lnj_last_federal_released_date := if((INTEGER)releasedDate<>0, (unsigned)OrigDateFiled, 0);


//end	
	
		SELF.lnj_eviction_recent_unreleased_count := (INTEGER)(isEviction and (INTEGER)releasedDate=0 AND isRecent);
		SELF.lnj_eviction_historical_unreleased_count := (INTEGER)(isEviction and (INTEGER)releasedDate=0 AND ~isRecent);
		SELF.lnj_eviction_recent_released_count := (INTEGER)(isEviction and (INTEGER)releasedDate<>0 AND isRecent);
		SELF.lnj_eviction_historical_released_count := (INTEGER)(isEviction and (INTEGER)releasedDate<>0 AND ~isRecent);

		SELF.lnj_eviction_count := (integer)(isEviction and (INTEGER)releasedDate=0) ; // fcra eviction must be unreleased
		SELF.lnj_eviction_count12 := (integer)(isEviction and (INTEGER)releasedDate=0 and 
			Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)OrigDateFiled,ut.DaysInNYears(1)));
		SELF.lnj_last_eviction_date := if(isEviction, (unsigned)OrigDateFiled, 0);

		// they want liens seperated by type and released or unreleased for modeling shell 3.0
		ftd := trim(stringlib.stringtouppercase(ri.filing_type_desc));
		goodResult := ri.rmsid<>'';
		unreleased := (integer) releasedDate=0;
		released := (integer) releasedDate<>0;
		
		// only count evictions in the liens buckets if you are running version prior to 50
		isCivilJudgment := ftd in iid_constants.setCivilJudgment_50 and goodResult and unreleased and ((~isEviction and ftd not in iid_constants.setSuitsFCRA) );
		isCivilJudgmentReleased := ftd in iid_constants.setCivilJudgment_50 and goodResult and released and ((~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isFederalTax := ftd in iid_constants.setFederalTax and goodResult and unreleased and ((~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isFederalTaxReleased := ftd in iid_constants.setFederalTax and goodResult and released and ((~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isForeclosure := ftd in iid_constants.setForeclosure_50 and goodResult and unreleased and ((~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isForeclosureReleased := ftd in iid_constants.setForeclosure_50 and goodResult and released and ((~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isLandlordTenant := ftd in iid_constants.setLandlordTenant_50 and goodResult and unreleased and ((~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isLandlordTenantReleased := ftd in iid_constants.setLandlordTenant_50 and goodResult and released and ((~isEviction and ftd not in iid_constants.setSuitsFCRA));
		//leaving lisPendens as is BUT we'll never get hits for lisPendens are in the Suits		
		isLisPendens := ftd in iid_constants.setLisPendens and goodResult and unreleased and ((~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isLisPendensReleased := ftd in iid_constants.setLisPendens and goodResult and released and ((~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isOtherLJ := ftd not in iid_constants.setPROther and goodResult and unreleased and ((~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isOtherLJReleased := ftd not in iid_constants.setPROther and goodResult and released and ((~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isOtherTax := ftd in iid_constants.setOtherTax and goodResult and unreleased and ((~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isOtherTaxReleased := ftd in iid_constants.setOtherTax and goodResult and released and ((~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isSmallClaims := ftd in iid_constants.setSmallClaims_50 and goodResult and unreleased and ((~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isSmallClaimsReleased := ftd in iid_constants.setSmallClaims_50 and goodResult and released and ((~isEviction and ftd not in iid_constants.setSuitsFCRA));
		isSuits := ftd in iid_constants.setSuitsFCRA and goodResult and unreleased and ((~isEviction));
		isSuitsReleased := ftd in iid_constants.setSuitsFCRA and goodResult and released and ((~isEviction));
		isStateTax := ftd in iid_constants.setStateTax and goodResult and unreleased and ((~isEviction and ftd not in iid_constants.setSuitsFCRA) );
		isStateTaxReleased := ftd in iid_constants.setStateTax and goodResult and released and ((~isEviction and ftd not in iid_constants.setSuitsFCRA) );
	 isAllTax :=ftd in iid_constants.setAllTax and goodResult and unreleased and ((~isEviction and ftd not in iid_constants.setSuitsFCRA) );
		isAllTaxReleased := ftd in iid_constants.setAllTax and goodResult and released and ((~isEviction and ftd not in iid_constants.setSuitsFCRA) );
	
		SELF.lnj_unreleased_civil_judgment_cnt:= (integer)isCivilJudgment;
		SELF.lnj_unreleased_civil_judgment_amt:= if(isCivilJudgment, (real)ri.amount, 0);
		
		SELF.lnj_released_civil_judgment_cnt:= (integer)isCivilJudgmentReleased;
		SELF.lnj_released_civil_judgment_amt:= if(isCivilJudgmentReleased, (real)ri.amount, 0);
		
		SELF.lnj_unreleased_federal_tax_cnt:= (integer)isFederalTax;
		SELF.lnj_unreleased_federal_tax_amt:= if(isFederalTax, (real)ri.amount, 0);
		
		SELF.lnj_released_federal_tax_cnt:= (integer)isFederalTaxReleased;
		SELF.lnj_released_federal_tax_amt:= if(isFederalTaxReleased, (real)ri.amount, 0);
		
		SELF.lnj_unreleased_foreclosure_cnt:= (integer)isForeclosure;
		SELF.lnj_unreleased_foreclosure_amt:= if(isForeclosure, (real)ri.amount, 0);
		
		SELF.lnj_released_foreclosure_cnt:= (integer)isForeclosureReleased;
		SELF.lnj_released_foreclosure_amt:= if(isForeclosureReleased, (real)ri.amount, 0);
		
		SELF.lnj_unreleased_landlord_tenant_cnt:= (integer)isLandlordTenant;
		SELF.lnj_unreleased_landlord_tenant_amt:= if(isLandlordTenant, (real)ri.amount, 0);
		
		SELF.lnj_released_landlord_tenant_cnt:= (integer)isLandlordTenantReleased;
		SELF.lnj_released_landlord_tenant_amt:= if(isLandlordTenantReleased, (real)ri.amount, 0);
		
		SELF.lnj_unreleased_lispendens_cnt:= (integer)isLisPendens;
	
		SELF.lnj_released_lispendens_cnt:= (integer)isLisPendensReleased;
		
		SELF.lnj_unreleased_other_lj_cnt:= (integer)isOtherLJ;
		SELF.lnj_unreleased_other_lj_amt:= if(isOtherLJ, (real)ri.amount, 0);
		
		SELF.lnj_released_other_lj_cnt:= (integer)isOtherLJReleased;
		SELF.lnj_released_other_lj_amt:= if(isOtherLJReleased, (real)ri.amount, 0);
		
		SELF.lnj_unreleased_other_tax_cnt:= (integer)isOtherTax;
		SELF.lnj_unreleased_other_tax_amt:= if(isOtherTax, (real)ri.amount, 0);
		
		SELF.lnj_released_other_tax_cnt:= (integer)isOtherTaxReleased;
		SELF.lnj_released_other_tax_amt:= if(isOtherTaxReleased, (real)ri.amount, 0);
		
		SELF.lnj_unreleased_small_claims_cnt:= (integer)isSmallClaims;
		SELF.lnj_unreleased_small_claims_amt:= if(isSmallClaims, (real)ri.amount, 0);
		
		SELF.lnj_released_small_claims_cnt:= (integer)isSmallClaimsReleased;
		SELF.lnj_released_small_claims_amt:= if(isSmallClaimsReleased, (real)ri.amount, 0);

		// blank out line counters and dates for suits on records that were counted in Liens Party join above
		SELF.lnj_recent_unreleased_count := if((isSuits or isSuitsReleased or isEviction), 0, tmp_lnj_recent_unreleased_count);
		SELF.lnj_historical_unreleased_count := if((isSuits or isSuitsReleased or isEviction), 0, tmp_lnj_historical_unreleased_count	);																					
		SELF.lnj_unreleased_count12 :=  if((isSuits or isSuitsReleased or isEviction), 0, tmp_lnj_unreleased_count12 );	
		SELF.lnj_recent_released_count :=  if((isSuits or isSuitsReleased or isEviction), 0, tmp_lnj_recent_released_count );	
		SELF.lnj_historical_released_count := if((isSuits or isSuitsReleased or isEviction), 0, tmp_lnj_historical_released_count );	
		SELF.lnj_released_count12 :=  if((isSuits or isSuitsReleased or isEviction), 0, tmp_lnj_released_count12 );	
		self.lnj_last_unreleased_date := if((isSuits or isSuitsReleased or isEviction), '', tmp_lnj_last_unreleased_date );	
		SELF.lnj_last_released_date :=  if((isSuits or isSuitsReleased or isEviction), 0, tmp_lnj_last_released_date );	
	
	//Start Juli additions
		SELF.LJType := map(
											//If it's a suit, do not count it as an Eviction	
												 ftd in risk_indicators.iid_constants.setSuitsFCRA => '',//not valid for our Juli Buckets but leave for testing for apples to apples
												 NOT goodResult => '',//not valid for our Juli Buckets
												 ftd in risk_indicators.iid_constants.setPRJudgment => risk_indicators.iid_constants.JudgmentText,
												 ftd in risk_indicators.iid_constants.setPREviction => risk_indicators.iid_constants.EvictionText,
												 ftd in risk_indicators.iid_constants.setPRLien => risk_indicators.iid_constants.LienText,	
												 ftd NOT in risk_indicators.iid_constants.setPROther => risk_indicators.iid_constants.OtherText,
												 '');
		SELF.DateFiled := OrigDateFiled;
		SELF.Amount := (string) (integer) ri.Amount; //attributes make this a real and store in an integer so making integer then string
		SELF.ReleaseDate := releasedDate;
		SELF.FileTypeDesc := trim(stringlib.stringtouppercase(ri.filing_type_desc));
		SELF.Filingnumber := ri.Filing_number;
		SELF.Filingbook := ri.Filing_book;
		SELF.Filingpage := ri.Filing_page;
		SELF.Agency := ri.Agency;
		SELF.Agencycounty := ri.Agency_County;
		SELF.Agencystate := ri.Agency_state;
		SELF.Defendant := if(trim(le.name_type) = 'D', trim(le.orig_name), '');
		SELF.Plaintiff := '';
		SELF.Eviction := if(isEviction, 'Y', 'N');
		SELF.FilingDescription := if(TRIM((String) releasedDate)<>'0', 'RELEASED', '');
		SELF.OrigFilingNumber := ri.Orig_Filing_Number;
		SELF.certificateNumber := ri.certificate_number;
		SELF.irsSerialNumber := ri.irs_serial_number;
		SELF.CaseNumberL := ri.Case_number;
  SELF.Filing_Type_id := ri.Filing_Type_ID;
		SELF.ProcessDate := ri.Process_Date;
		SELF.seq := (Unsigned4) le.Seq;
		//liens
		is_Lien := self.LJType = risk_indicators.iid_constants.LienText;
		SELF.lnj_lien_cnt := if(is_Lien, 1, 0);	
		SELF.lnj_lien_total := if(is_Lien, (real)ri.amount, 0);
		SELF.lnj_last_lien_unreleased_date := if((isSuits or isSuitsReleased or isEviction or ~is_lien), '', tmp_lnj_last_lien_unreleased_date );	
		SELF.lnj_last_lien_released_date := if((isSuits or isSuitsReleased or isEviction or ~is_lien), 0, tmp_lnj_last_lien_released_date );	
		//All Tax
		SELF.lnj_liens_unreleased_all_tax_cnt:= (integer)(isAllTax and is_Lien);
		SELF.lnj_liens_unreleased_all_tax_amt:= if(isAllTax and is_Lien, (real)ri.amount, 0);
		SELF.lnj_liens_released_all_tax_cnt:= (integer)(isAllTaxReleased and is_Lien);
		SELF.lnj_liens_released_all_tax_amt:= if(isAllTaxReleased and is_Lien, (real)ri.amount, 0);
		SELF.lnj_last_allTax_unreleased_date := if((isSuits or isSuitsReleased or isEviction or ~is_lien), '', if(isAllTax and is_Lien, tmp_lnj_last_allTax_unreleased_date, '') );	
		SELF.lnj_last_allTax_released_date := if((isSuits or isSuitsReleased or isEviction or ~is_lien), 0, if(isAllTaxReleased and is_Lien, tmp_lnj_last_allTax_released_date, 0) );	

		//state tax
		SELF.lnj_liens_unreleased_state_tax_cnt:= (integer)(isStateTax and is_Lien);
		SELF.lnj_liens_unreleased_state_tax_amt:= if(isStateTax and is_Lien, (real)ri.amount, 0);
		SELF.lnj_liens_released_state_tax_cnt:= (integer)(isStateTaxReleased and is_Lien);
		SELF.lnj_liens_released_state_tax_amt:= if(isStateTaxReleased and is_Lien, (real)ri.amount, 0);
		SELF.lnj_last_state_unreleased_date := if((isSuits or isSuitsReleased or isEviction or ~is_lien), '', if(isStateTax and is_Lien, tmp_lnj_last_state_unreleased_date, '') );	
		SELF.lnj_last_state_released_date := if((isSuits or isSuitsReleased or isEviction or ~is_lien), 0, if(isStateTaxReleased and is_Lien, tmp_lnj_last_state_released_date, 0) );	

		//federal tax
		SELF.lnj_liens_unreleased_federal_tax_cnt:= (integer)(isFederalTax and is_Lien);
		SELF.lnj_liens_unreleased_federal_tax_amt:= if(isFederalTax and is_Lien, (real)ri.amount, 0);
		SELF.lnj_liens_released_federal_tax_cnt:= (integer)(isFederalTaxReleased and is_Lien);
		SELF.lnj_liens_released_federal_tax_amt:= if(isFederalTaxReleased and is_Lien, (real)ri.amount, 0);
		SELF.lnj_last_federal_unreleased_date := if((isSuits or isSuitsReleased or isEviction or ~is_lien), '', if(isFederalTax and is_Lien, tmp_lnj_last_federal_unreleased_date, '') );	
		SELF.lnj_last_federal_released_date := if((isSuits or isSuitsReleased or isEviction or ~is_lien), 0, if(isFederalTaxReleased and is_Lien, tmp_lnj_last_federal_released_date, 0) );	

		//Judgments
		is_Jgmt := self.LJType IN [
								risk_indicators.iid_constants.JudgmentText,
								risk_indicators.iid_constants.EvictionText,
								risk_indicators.iid_constants.OtherText
								];
		self.lnj_last_jgmt_unreleased_date := if((isSuits or isSuitsReleased or isEviction or ~is_Jgmt), '', tmp_lnj_last_jgmt_unreleased_date );	
		SELF.lnj_last_jgmt_released_date :=  if((isSuits or isSuitsReleased or isEviction or ~is_Jgmt), 0, tmp_lnj_last_jgmt_released_date );	
		SELF.lnj_jgmt_total := if((isSuits or isSuitsReleased or isEviction or ~is_Jgmt), 0, (real)ri.amount);
		SELF.lnj_jgmt_cnt := if((isSuits or isSuitsReleased or isEviction or ~is_Jgmt), 0, 1);							
		//End Juli additions
		self.PersistId := (string) ri.persistent_record_id;
  self.Party_PersistId := (string) le.Party_PersistId;
		SELF := le;
	end;
	endmacro;

	MAC_liensMain_transform(get_liens_main_raw, liensv2.key_liens_main_id_FCRA);
	MAC_liensMain_transform(get_liens_main_corrections, fcra.key_Override_liensv2_main_ffid);

	liens_main_raw_roxie := JOIN(liens_party_raw, liensV2.key_liens_main_ID_FCRA,
					left.rmsid<>'' and left.tmsid<>'' and 
					keyed(left.tmsid=right.tmsid) and keyed(left.rmsid=right.rmsid) and
					(unsigned) left.date_first_seen = (unsigned) right.orig_filing_date and 
					(unsigned) left.date_last_seen = (unsigned) right.release_date and //ensure we get the correct record for the defendant
					right.filing_type_desc not in Risk_Indicators.iid_constants.setMechanicsLiens and
					right.filing_type_desc not in Risk_Indicators.iid_constants.set_Invalid_Liens_50 AND
					(string50)right.tmsid + (string50)right.rmsid not in left.lien_correct_tmsid_rmsid   // old way - exclude corrected records from prior to 11/13/2012
					and trim((string)right.persistent_record_id) not in left.lien_correct_tmsid_rmsid  // new way - exclude corrected records that match the persistent_record_id										
					and if(FilterBCB, RIGHT.BCBFlag = TRUE, TRUE),	
					get_liens_main_raw(LEFT,RIGHT), left outer, 
					ATMOST(keyed(LEFT.tmsid=RIGHT.tmsid) and keyed(left.rmsid=right.rmsid), riskwise.max_atmost));
 
	liens_main_raw_thor_pre := JOIN(distribute(liens_party_raw(rmsid <> '' and tmsid <> ''), hash64(tmsid, rmsid)), 
					distribute(pull(liensV2.key_liens_main_ID_FCRA(
					filing_type_desc not in Risk_Indicators.iid_constants.setMechanicsLiens and 
					filing_type_desc not in Risk_Indicators.iid_constants.set_Invalid_Liens_50)), hash64(tmsid, rmsid)),
					(left.tmsid=right.tmsid) and (left.rmsid=right.rmsid) and
					(unsigned) left.date_first_seen = (unsigned) right.orig_filing_date and 
					(unsigned) left.date_last_seen = (unsigned) right.release_date and //ensure we get the correct record for the defendant			
					(string50)right.tmsid + (string50)right.rmsid not in left.lien_correct_tmsid_rmsid  // old way - exclude corrected records from prior to 11/13/2012
					and trim((string)right.persistent_record_id) not in left.lien_correct_tmsid_rmsid  // new way - exclude corrected records that match the persistent_record_id										
					and if(FilterBCB, RIGHT.BCBFlag = TRUE, TRUE),	
					get_liens_main_raw(LEFT,RIGHT), left outer, 
					ATMOST((LEFT.tmsid=RIGHT.tmsid) and (left.rmsid=right.rmsid) 
					, riskwise.max_atmost), LOCAL);
												
	liens_main_raw_thor := group(sort(liens_main_raw_thor_pre + liens_party_raw(rmsid='' or tmsid=''), seq, local), seq, local);
								
 	#IF(onThor)
		liens_main_raw := liens_main_raw_thor;
	#ELSE
		liens_main_raw := liens_main_raw_roxie;
	#END
  
	liens_main_overrides_roxie := JOIN(liens_party_overrides, fcra.key_Override_liensv2_main_ffid,
            exists(left.lien_correct_ffid) and
            keyed(right.flag_file_id IN left.lien_correct_ffid) and
            right.filing_type_desc not in Risk_Indicators.iid_constants.setMechanicsLiens and
            right.filing_type_desc not in Risk_Indicators.iid_constants.set_Invalid_Liens_50,  
												get_liens_main_corrections(LEFT,RIGHT), 
												ATMOST(riskwise.max_atmost));

	liens_main_overrides_thor := JOIN(liens_party_overrides(exists(lien_correct_ffid)), 
											pull(fcra.key_Override_liensv2_main_ffid),
											(right.flag_file_id IN left.lien_correct_ffid) and
            right.filing_type_desc not in Risk_Indicators.iid_constants.setMechanicsLiens and
            right.filing_type_desc not in Risk_Indicators.iid_constants.set_Invalid_Liens_50, 
												get_liens_main_corrections(LEFT,RIGHT), ALL);
												
	#IF(onThor)
		liens_main_overrides := liens_main_overrides_thor;
	#ELSE
		liens_main_overrides := liens_main_overrides_roxie;
	#END
  
	liensWithDesc := ungroup(liens_main_raw(ljType !='')) + ungroup(liens_main_overrides(ljType !=''));//FileTypeDesc != '');
//get smallest date first seen for each tmsid
 liensTmsidDF := DEDUP(SORT(liensWithDesc, did, tmsid, (integer) DateFiled), did, tmsid);
	lienswithNewDF := join(liensWithDesc, liensTmsidDF,
		left.did = right.did and left.tmsid = right.tmsid,
		transform(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_workingDF,
			self.DF := (string) right.DateFiled;
			self := left,
			self := []), 
			left outer);	
	//unique TMSID and DF will have oldest date filed
	liensTmsidDF_total := DEDUP(SORT(lienswithNewDF, did, tmsid,
		(integer) if((integer) ReleaseDate = 0, 99999999, (integer) ReleaseDate),
		-(integer) DateFiled, -(integer) ProcessDate), did, tmsid);	
	
	liensWithDesc_DF2 := project(liensTmsidDF_total, 
		transform(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_workingDF,
			self.sort2Date := map(
				trim(left.OrigFilingNumber, left, right) != '' => left.OrigFilingNumber,
				trim(left.filingNumber, left, right) != '' => left.filingNumber,
				trim(left.certificateNumber, left, right) != '' => left.certificateNumber,
				trim(left.irsSerialNumber, left, right) != '' => left.irsSerialNumber,
				trim(left.filingBook, left, right) != '' and trim(left.filingPage, left, right) != ''=> 
							'BK' +trim(left.filingBook, left, right) + 'PG'+trim(left.filingPage, left, right),
				trim(left.CaseNumberL, left, right) != '' => left.CaseNumberL,
				left.tmsid);//default to tmsid over blank
				self := left,
				self := []));
	//least sort for sort2			
	liensSort2DF := DEDUP(SORT(liensWithDesc_DF2, did, Agencystate, AgencyCounty, 
			sort2Date, (integer) datefiled, (integer) DF), 
			did, Agencystate, AgencyCounty, sort2Date, datefiled);
	lienswithNewDF2 := join(liensWithDesc_DF2, liensSort2DF,
		left.did = right.did and left.AgencyState = right.AgencyState and 
		left.AgencyCounty = right.AgencyCounty and
		left.sort2Date = right.sort2Date and
		left.datefiled = right.datefiled,
		transform(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_workingDF,
			self.DF2 := (string) right.DF;
			self := left,
			self := []), 
			left outer);	
	//unique Agencystate, AgencyCounty, sort2Date and DF2 will have oldest date filed
	liensTmsidDF2_total := DEDUP(SORT(lienswithNewDF2, did, Agencystate, AgencyCounty, 
		sort2Date, (integer) if((integer) ReleaseDate = 0, 99999999, (integer) ReleaseDate),
		-(integer) DateFiled, -(integer) ProcessDate), did, Agencystate, AgencyCounty, 
		sort2Date);				
	//Just sorting to get the top record with the oldest date filed
	liensSort3DF := DEDUP(SORT(liensTmsidDF2_total, did, (integer) datefiled, -amount,
			Agencystate, AgencyCounty, (integer) DF2), 
			did, DateFiled, amount, Agencystate, AgencyCounty);
	//any matching records will get updated to have the earliest date filed		
	lienswithNewDF3 := join(liensTmsidDF2_total, liensSort3DF,
			left.did = right.did and 
			left.DateFiled = right.DateFiled and 
			left.amount = right.amount and
			left.AgencyState = right.AgencyState and 
			left.AgencyCounty = right.AgencyCounty,
		transform(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_workingDF,
			self.DF3 := (string) right.DF2;
			self := left,
			self := []), 
			left outer);
	//now all matching records have same date filed, so keep record by sort order for output		
	liensTmsidDF3_total := DEDUP(SORT(lienswithNewDF3, did,
			(integer) datefiled, -amount,  Agencystate, AgencyCounty,
		(integer) if((integer) ReleaseDate = 0, 99999999, (integer) ReleaseDate),
		 -(integer) ProcessDate), 
			did, DateFiled, amount, Agencystate, AgencyCounty);
		//Just sorting to get the top record with the oldest date filed
	liensSort4DF := DEDUP(SORT(liensTmsidDF3_total, did, filingNumber, 
			Agencystate, AgencyCounty, (integer) DF3), 
			did, filingNumber, Agencystate, AgencyCounty);
	//any matching records will get updated to have the earliest date filed		
	lienswithNewDF4 := join(liensTmsidDF3_total, liensSort4DF,
			left.did = right.did and 
			left.filingNumber = right.filingNumber and 
			left.AgencyState = right.AgencyState and 
			left.AgencyCounty = right.AgencyCounty,
		transform(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_workingDF,
			self.DF4 := (string) right.DF3;
			self := left,
			self := []), 
			left outer);
	//now all matching records have same date filed, so keep record by sort order for output		
	liensTmsidDF4_total := DEDUP(SORT(lienswithNewDF4, did,
			filingNumber, Agencystate, AgencyCounty,
			(integer) if((integer) ReleaseDate = 0, 99999999, (integer) ReleaseDate),
			-(integer) DateFiled, -(integer) ProcessDate), 
			did, filingNumber, Agencystate, AgencyCounty);	
	
	liens_filtered_DF_date := liensTmsidDF4_total(FCRA.lien_is_ok(Risk_indicators.iid_constants.myGetDate(historydate),(string) DF4));
	// make sure date_first_seen is within ReportingPeriod months of the historydate 
 liens_filtered_DF_ := liens_filtered_DF_date(ut.monthsapart((string) date_first_seen[1..6],(string)iid_constants.myGetDate(historydate)[1..6]) <= ReportingPeriod);
	
	//drop off the DF date
	liens_filtered_DF := project(liens_filtered_DF_, transform(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_working,
		self := left, self := []));

	//grab C records ...sometimes the cname can be blank on those
	Risk_Indicators.Layouts_Derog_Info.plaintiff_rec getPlaintiff(liensWithDesc le, liensv2.key_liens_party_id_FCRA ri) := TRANSFORM
		SELF.Plaintiff := if((le.lnj_jgmt_cnt>=1 or le.lnj_eviction_count >= 1) and ri.name_type='C', 
											if(ri.cname !='', ri.cname, 
											Risk_Indicators.iid_constants.CreateFullName(ri.title, ri.fname, ri.mname, ri.lname, ri.name_suffix)),
											'');
		SELF.Name_type := ri.name_type;
		SELF.datelastseen := ri.date_last_seen;
		SELF := le;
	END;
	
	liensWplainTiff_roxie := join(liens_filtered_DF, liensv2.key_liens_party_id_FCRA, 
							LEFT.rmsid<>'' and left.did != 0 and 
							keyed(LEFT.rmsid=RIGHT.rmsid) AND 
							keyed(left.tmsid=right.tmsid) and 
							(left.lnj_jgmt_cnt >= 1 or left.lnj_eviction_count >= 1) and 
							(unsigned3)(RIGHT.date_first_seen[1..6]) < left.historydate AND (unsigned)RIGHT.date_first_seen<>0 and	// date first seen was blank on some records
							(unsigned) left.date_first_seen = (unsigned) right.date_first_seen and 
							(unsigned) left.date_last_seen = (unsigned) right.date_last_seen and //ensure we get the correct record for the defendant
							right.name_type='C'
							AND (string50)right.tmsid + (string50)right.rmsid not in left.lien_correct_tmsid_rmsid  // old way - exclude corrected records from prior to 11/13/2012
							and trim((string)right.persistent_record_id) not in left.lien_correct_tmsid_rmsid  // new way - exclude corrected records that match the persistent_record_id										
							and if(FilterSSNs, Risk_indicators.iid_constants.GoodSSNLength(RIGHT.SSN), TRUE),//if filter is not set return ALL
							getPlaintiff(LEFT,RIGHT), 
							ATMOST(keyed(LEFT.rmsid=RIGHT.rmsid) AND 
							keyed(left.tmsid=right.tmsid), 
							riskwise.max_atmost));
	liensWplainTiff_thor := join(distribute(liens_filtered_DF(rmsid<>'' and did <> 0 and (lnj_jgmt_cnt >= 1 or lnj_eviction_count >= 1)), hash64(rmsid, tmsid)), 
							distribute(pull(liensv2.key_liens_party_id_FCRA), hash64(rmsid, tmsid)), 
							(LEFT.rmsid=RIGHT.rmsid) AND 
							(left.tmsid=right.tmsid) and
							(unsigned) left.date_first_seen = (unsigned) right.date_first_seen and 
							(unsigned) left.date_last_seen = (unsigned) right.date_last_seen and //ensure we get the correct record for the defendant
							(unsigned3)(RIGHT.date_first_seen[1..6]) < left.historydate AND (unsigned)RIGHT.date_first_seen<>0 and	// date first seen was blank on some records
							right.name_type='C'
							AND (string50)right.tmsid + (string50)right.rmsid not in left.lien_correct_tmsid_rmsid  // old way - exclude corrected records from prior to 11/13/2012
							and trim((string)right.persistent_record_id) not in left.lien_correct_tmsid_rmsid  // new way - exclude corrected records that match the persistent_record_id										
							and if(FilterSSNs, Risk_indicators.iid_constants.GoodSSNLength(RIGHT.SSN), TRUE),//if filter is not set return ALL
							getPlaintiff(LEFT,RIGHT), 
							ATMOST((LEFT.rmsid=RIGHT.rmsid) AND 
							(left.tmsid=right.tmsid), riskwise.max_atmost), LOCAL);

 	#IF(onThor)
		liensWplainTiff := liensWplainTiff_thor;
	#ELSE
		liensWplainTiff := ungroup(liensWplainTiff_roxie);
	#END
  
	liensWplainTiff_duped := DEDUP(SORT(liensWplainTiff, TMSID, RMSID, name_type, DateLastSeen), TMSID, name_type, KEEP(1));
	liens_fuller := JOIN(liens_filtered_DF, liensWplainTiff_duped,
		LEFT.Tmsid = RIGHT.Tmsid and 
		LEFT.rmsid = RIGHT.rmsid and 
		LEFT.Did = RIGHT.did,
		transform(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_working,
			self.plaintiff := right.plaintiff,
			self := left),LEFT OUTER);
			
	liens_fullunSorted := ungroup(liens_fuller);
	//normalize the childset out to dataset on it's own to work with easier
	PcontextStId := NORMALIZE(iid_withPersonContext, LEFT.ConsumerStatements, TRANSFORM(Risk_Indicators.Layouts.tmp_Consumer_Statements, SELF := RIGHT));

  //if any statementIds match between our data and person context, populate the statementId and carry it back
	//in the LNJ datasets. The datasets are limited to 99 records.
	LiensFullWithStId := join(liens_fullunSorted, PcontextStId,
		(unsigned) left.Did = (unsigned) Right.UniqueId and
		Right.DataGroup in [PersonContext.constants.datagroups.LIEN_MAIN, 
								PersonContext.constants.datagroups.LIEN_PARTY] and
		Right.StatementType in [PersonContext.constants.RecordTypes.CS, PersonContext.constants.RecordTypes.RS] and
		Right.RecIdForStId != '' and 
		(trim(left.PersistId, left, right) = trim(Right.RecIdForStId, left, right) OR
  trim(left.Party_PersistId, left, right) = trim(Right.RecIdForStId, left, right)),
		transform(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_working,
			self.did := left.did;
			self.ConsumerStatementId := (unsigned) Right.statementid;
			self := left), 
			left outer);
			
	liens_full := group(LiensFullWithStId, did);
	
	liens_filtered_a := if(FilterCityLiens, liens_full(FileTypeDesc NOT IN Risk_Indicators.iid_constants.CityLienFltrs), liens_full);
	liens_filtered_b := if(FilterCountyLiens, liens_filtered_a(FileTypeDesc NOT IN Risk_Indicators.iid_constants.CountyLienFltrs), liens_filtered_a);
	liens_filtered_c := if(FilterStateWarrent, liens_filtered_b(FileTypeDesc NOT IN Risk_Indicators.iid_constants.StateWarrentFltrs), liens_filtered_b);
	liens_filtered_d := if(FilterStateLiens, liens_filtered_c(FileTypeDesc NOT IN Risk_Indicators.iid_constants.StateTaxLienFltrs), liens_filtered_c);
	liens_filtered_e := if(FilterFederalLiens, liens_filtered_d(FileTypeDesc NOT IN Risk_Indicators.iid_constants.FedLienFltrs), liens_filtered_d);
	liens_filtered_f := if(FilterOtherLiens, liens_filtered_e(FileTypeDesc NOT IN Risk_Indicators.iid_constants.OtherLienFltrs), liens_filtered_e);
	liens_filtered_g := if(FilterJudgments, liens_filtered_f(FileTypeDesc NOT IN Risk_Indicators.iid_constants.JudgmentFltrs), liens_filtered_f);
	liens_filtered_h := if(FilterEvictions, liens_filtered_g(FileTypeDesc NOT IN Risk_Indicators.iid_constants.EvictionFltrs), liens_filtered_g);

	//start Juli Logic
	LiensOnly := liens_filtered_h(LJType = risk_indicators.iid_constants.LienText);

	SrtedLiens_dp := DEDUP(DEDUP(SORT(ungroup(LiensOnly), did,tmsid,
		-(integer) ReleaseDate, -(integer) datefiled, record),
		did,tmsid), did, KEEP(99)); //keep 99 for each did

//now sort for output the fields that only the client sees	
	SrtedLiens := SORT(group(SrtedLiens_dp,seq), -(integer) VendorDateLastSeen, -(integer) DateFiled, -(integer) ReleaseDate);
	//Judgments
	JudgmentsOnly := liens_filtered_h(LJType IN [
								risk_indicators.iid_constants.JudgmentText,
								risk_indicators.iid_constants.EvictionText,
								risk_indicators.iid_constants.OtherText
								]);

	SrtedJudgments_dp := DEDUP(DEDUP(SORT(ungroup(JudgmentsOnly), did,tmsid,
		-(integer) ReleaseDate, -(integer) datefiled, record),
		did,tmsid), did, Keep(99));//keep 99 for each did

//now sort for output the fields that only the client sees
	SrtedJudgments := SORT(group(SrtedJudgments_dp,seq), -(integer) VendorDateLastSeen, -(integer) DateFiled, -(integer) ReleaseDate);
	//save 99 liens and 99 judgments - most recent ones
	liensJudgments_hits := GROUP((ungroup(SrtedLiens) +ungroup(SrtedJudgments)), did);
	
	//NO records found for LiensJudgments
	liensJudgments := JOIN(w_corrections, liensJudgments_hits,
			left.did<>0 and LEFT.Did = RIGHT.Did,
			TRANSFORM(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_working,
			SELF.did := LEFT.did,
			SELF.Seq := LEFT.Seq,
			SELF.historydate := LEFT.historydate;
			SELF := RIGHT, 
			SELF := []),
			LEFT OUTER);

	Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_working roll_liens(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_working le, 
		Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_working ri) :=
	TRANSFORM
		sameLien := le.tmsid = ri.tmsid;

	//don't increment the lien counters in shell 5.0 and higher if right record is an eviction
		SELF.lnj_recent_unreleased_count := le.lnj_recent_unreleased_count + IF(sameLien or (ri.evictionInd and bsVersion >=50),0,ri.lnj_recent_unreleased_count);
		SELF.lnj_historical_unreleased_count := le.lnj_historical_unreleased_count + IF(sameLien or (ri.evictionInd and bsVersion >=50),0,ri.lnj_historical_unreleased_count);
		SELF.lnj_unreleased_count12 := le.lnj_unreleased_count12 + IF(sameLien or (ri.evictionInd and bsVersion >=50),0,ri.lnj_unreleased_count12);
		
		SELF.lnj_recent_released_count := le.lnj_recent_released_count + IF(sameLien or (ri.evictionInd and bsVersion >=50),0,ri.lnj_recent_released_count);
		SELF.lnj_historical_released_count := le.lnj_historical_released_count + IF(sameLien or (ri.evictionInd and bsVersion >=50),0,ri.lnj_historical_released_count);
		SELF.lnj_released_count12 := le.lnj_released_count12 + IF(sameLien or (ri.evictionInd and bsVersion >=50),0,ri.lnj_released_count12);
		
		SELF.lnj_last_unreleased_date := if((integer)le.lnj_last_unreleased_date > (integer)ri.lnj_last_unreleased_date, le.lnj_last_unreleased_date, ri.lnj_last_unreleased_date);
		SELF.lnj_last_released_date := if((integer)le.lnj_last_released_date > (integer)ri.lnj_last_released_date, le.lnj_last_released_date, ri.lnj_last_released_date);
		
		SELF.lnj_eviction_count := le.lnj_eviction_count + IF(sameLien, 0, ri.lnj_eviction_count);
		SELF.lnj_eviction_count12 := le.lnj_eviction_count12 + IF(sameLien,0,ri.lnj_eviction_count12);
	
		SELF.lnj_eviction_recent_unreleased_count := le.lnj_eviction_recent_unreleased_count + IF(sameLien,0,ri.lnj_eviction_recent_unreleased_count);
		SELF.lnj_eviction_historical_unreleased_count := le.lnj_eviction_historical_unreleased_count + IF(sameLien,0,ri.lnj_eviction_historical_unreleased_count);
		SELF.lnj_eviction_recent_released_count := le.lnj_eviction_recent_released_count + IF(sameLien,0,ri.lnj_eviction_recent_released_count);
		SELF.lnj_eviction_historical_released_count := le.lnj_eviction_historical_released_count + IF(sameLien,0,ri.lnj_eviction_historical_released_count);
	
		SELF.lnj_last_eviction_date := MAX(le.lnj_last_eviction_date,ri.lnj_last_eviction_date);

		SELF.lnj_unreleased_civil_judgment_cnt := le.lnj_unreleased_civil_judgment_cnt + IF(sameLien and le.lnj_unreleased_civil_judgment_cnt>0,0,ri.lnj_unreleased_civil_judgment_cnt);
		SELF.lnj_unreleased_civil_judgment_amt := le.lnj_unreleased_civil_judgment_amt + IF(sameLien and le.lnj_unreleased_civil_judgment_amt>0,0,ri.lnj_unreleased_civil_judgment_amt);
		
		SELF.lnj_released_civil_judgment_cnt := le.lnj_released_civil_judgment_cnt + IF(sameLien and le.lnj_released_civil_judgment_cnt>0,0,ri.lnj_released_civil_judgment_cnt);
		SELF.lnj_released_civil_judgment_amt := le.lnj_released_civil_judgment_amt + IF(sameLien and le.lnj_released_civil_judgment_amt>0,0,ri.lnj_released_civil_judgment_amt);
		
		SELF.lnj_unreleased_federal_tax_cnt := le.lnj_unreleased_federal_tax_cnt + IF(sameLien and le.lnj_unreleased_federal_tax_cnt>0,0,ri.lnj_unreleased_federal_tax_cnt);
		SELF.lnj_unreleased_federal_tax_amt := le.lnj_unreleased_federal_tax_amt + IF(sameLien and le.lnj_unreleased_federal_tax_amt>0,0,ri.lnj_unreleased_federal_tax_amt);
		
		SELF.lnj_released_federal_tax_cnt := le.lnj_released_federal_tax_cnt + IF(sameLien and le.lnj_released_federal_tax_cnt>0,0,ri.lnj_released_federal_tax_cnt);
		SELF.lnj_released_federal_tax_amt := le.lnj_released_federal_tax_amt + IF(sameLien and le.lnj_released_federal_tax_amt>0,0,ri.lnj_released_federal_tax_amt);
		
		SELF.lnj_unreleased_foreclosure_cnt := le.lnj_unreleased_foreclosure_cnt + IF(sameLien and le.lnj_unreleased_foreclosure_cnt>0,0,ri.lnj_unreleased_foreclosure_cnt);
		SELF.lnj_unreleased_foreclosure_amt := le.lnj_unreleased_foreclosure_amt + IF(sameLien and le.lnj_unreleased_foreclosure_amt>0,0,ri.lnj_unreleased_foreclosure_amt);
		
		SELF.lnj_released_foreclosure_cnt := le.lnj_released_foreclosure_cnt + IF(sameLien and le.lnj_released_foreclosure_cnt>0,0,ri.lnj_released_foreclosure_cnt);
		SELF.lnj_released_foreclosure_amt := le.lnj_released_foreclosure_amt + IF(sameLien and le.lnj_released_foreclosure_amt>0,0,ri.lnj_released_foreclosure_amt);
		
		SELF.lnj_unreleased_landlord_tenant_cnt := le.lnj_unreleased_landlord_tenant_cnt + IF(sameLien and le.lnj_unreleased_landlord_tenant_cnt>0,0,ri.lnj_unreleased_landlord_tenant_cnt);
		SELF.lnj_unreleased_landlord_tenant_amt := le.lnj_unreleased_landlord_tenant_amt + IF(sameLien and le.lnj_unreleased_landlord_tenant_amt>0,0,ri.lnj_unreleased_landlord_tenant_amt);
		
		SELF.lnj_released_landlord_tenant_cnt := le.lnj_released_landlord_tenant_cnt + IF(sameLien and le.lnj_released_landlord_tenant_cnt>0,0,ri.lnj_released_landlord_tenant_cnt);
		SELF.lnj_released_landlord_tenant_amt := le.lnj_released_landlord_tenant_amt + IF(sameLien and le.lnj_released_landlord_tenant_amt>0,0,ri.lnj_released_landlord_tenant_amt);
		
		SELF.lnj_unreleased_lispendens_cnt := le.lnj_unreleased_lispendens_cnt + IF(sameLien and le.lnj_unreleased_lispendens_cnt>0,0,ri.lnj_unreleased_lispendens_cnt);
		SELF.lnj_released_lispendens_cnt := le.lnj_released_lispendens_cnt + IF(sameLien and le.lnj_released_lispendens_cnt>0,0,ri.lnj_released_lispendens_cnt);
		
		SELF.lnj_unreleased_other_lj_cnt := le.lnj_unreleased_other_lj_cnt + IF(sameLien and le.lnj_unreleased_other_lj_cnt>0,0,ri.lnj_unreleased_other_lj_cnt);
		SELF.lnj_unreleased_other_lj_amt := le.lnj_unreleased_other_lj_amt + IF(sameLien and le.lnj_unreleased_other_lj_amt>0,0,ri.lnj_unreleased_other_lj_amt);
		
		SELF.lnj_released_other_lj_cnt := le.lnj_released_other_lj_cnt + IF(sameLien and le.lnj_released_other_lj_cnt>0,0,ri.lnj_released_other_lj_cnt);
		SELF.lnj_released_other_lj_amt := le.lnj_released_other_lj_amt + IF(sameLien and le.lnj_released_other_lj_amt>0,0,ri.lnj_released_other_lj_amt);
		
		SELF.lnj_unreleased_other_tax_cnt := le.lnj_unreleased_other_tax_cnt + IF(sameLien and le.lnj_unreleased_other_tax_cnt>0,0,ri.lnj_unreleased_other_tax_cnt);
		SELF.lnj_unreleased_other_tax_amt := le.lnj_unreleased_other_tax_amt + IF(sameLien and le.lnj_unreleased_other_tax_amt>0,0,ri.lnj_unreleased_other_tax_amt);
		
		SELF.lnj_released_other_tax_cnt := le.lnj_released_other_tax_cnt + IF(sameLien and le.lnj_released_other_tax_cnt>0,0,ri.lnj_released_other_tax_cnt);
		SELF.lnj_released_other_tax_amt := le.lnj_released_other_tax_amt + IF(sameLien and le.lnj_released_other_tax_amt>0,0,ri.lnj_released_other_tax_amt);
		
		SELF.lnj_unreleased_small_claims_cnt := le.lnj_unreleased_small_claims_cnt + IF(sameLien and le.lnj_unreleased_small_claims_cnt>0,0,ri.lnj_unreleased_small_claims_cnt);
		SELF.lnj_unreleased_small_claims_amt := le.lnj_unreleased_small_claims_amt + IF(sameLien and le.lnj_unreleased_small_claims_amt>0,0,ri.lnj_unreleased_small_claims_amt);
		
		SELF.lnj_released_small_claims_cnt := le.lnj_released_small_claims_cnt + IF(sameLien and le.lnj_released_small_claims_cnt>0,0,ri.lnj_released_small_claims_cnt);
		SELF.lnj_released_small_claims_amt := le.lnj_released_small_claims_amt + IF(sameLien and le.lnj_released_small_claims_amt>0,0,ri.lnj_released_small_claims_amt);

	//new attributes
	//liens
		isLien := ri.LJType = risk_indicators.iid_constants.LienText;
		SELF.lnj_lien_cnt := le.lnj_lien_cnt + if(islien, if(sameLien, 0, ri.lnj_lien_cnt), 0);
		SELF.lnj_lien_total := le.lnj_lien_total + if(islien, IF(sameLien and le.lnj_lien_total>0, 0, ri.lnj_lien_total), 0);
		SELF.lnj_last_lien_unreleased_date := if(~isLien, le.lnj_last_lien_unreleased_date, //not jdgmt so use left side
				if((integer)le.lnj_last_lien_unreleased_date > (integer)ri.lnj_last_lien_unreleased_date, 
				le.lnj_last_lien_unreleased_date, 
				ri.lnj_last_lien_unreleased_date));
		SELF.lnj_last_lien_released_date := if(~isLien, (integer)le.lnj_last_lien_released_date, //not jdgmt so use left side
			if((integer)le.lnj_last_lien_released_date > (integer)ri.lnj_last_lien_released_date, 
			le.lnj_last_lien_released_date, 
			ri.lnj_last_lien_released_date));
		
		SELF.lnj_liens_unreleased_all_tax_cnt:= le.lnj_liens_unreleased_all_tax_cnt + if(islien, IF(sameLien and le.lnj_liens_unreleased_all_tax_cnt>0,0,ri.lnj_liens_unreleased_all_tax_cnt),0);
		SELF.lnj_liens_unreleased_all_tax_amt:= le.lnj_liens_unreleased_all_tax_amt + if(islien,IF(sameLien and le.lnj_liens_unreleased_all_tax_amt>0,0,ri.lnj_liens_unreleased_all_tax_amt),0);		
		SELF.lnj_liens_released_all_tax_cnt:= le.lnj_liens_released_all_tax_cnt + if(islien,IF(sameLien and le.lnj_liens_released_all_tax_cnt>0,0,ri.lnj_liens_released_all_tax_cnt),0);
		SELF.lnj_liens_released_all_tax_amt:= le.lnj_liens_released_all_tax_amt + if(islien,IF(sameLien and le.lnj_liens_released_all_tax_amt>0,0,ri.lnj_liens_released_all_tax_amt),0);	
		SELF.lnj_last_allTax_unreleased_date := if(~isLien, le.lnj_last_allTax_unreleased_date, 
				if((integer)le.lnj_last_allTax_unreleased_date > (integer)ri.lnj_last_allTax_unreleased_date, 
				le.lnj_last_allTax_unreleased_date, 
				ri.lnj_last_allTax_unreleased_date));
		SELF.lnj_last_allTax_released_date := if(~isLien, (integer)le.lnj_last_allTax_released_date,
			if((integer)le.lnj_last_allTax_released_date > (integer)ri.lnj_last_allTax_released_date, 
			le.lnj_last_allTax_released_date, 
			ri.lnj_last_allTax_released_date));	
	
		SELF.lnj_liens_unreleased_state_tax_cnt:= le.lnj_liens_unreleased_state_tax_cnt + if(islien, IF(sameLien and le.lnj_liens_unreleased_state_tax_cnt>0,0,ri.lnj_liens_unreleased_state_tax_cnt),0);
		SELF.lnj_liens_unreleased_state_tax_amt:= le.lnj_liens_unreleased_state_tax_amt + if(islien,IF(sameLien and le.lnj_liens_unreleased_state_tax_amt>0,0,ri.lnj_liens_unreleased_state_tax_amt),0);		
		SELF.lnj_liens_released_state_tax_cnt:= le.lnj_liens_released_state_tax_cnt + if(islien,IF(sameLien and le.lnj_liens_released_state_tax_cnt>0,0,ri.lnj_liens_released_state_tax_cnt),0);
		SELF.lnj_liens_released_state_tax_amt:= le.lnj_liens_released_state_tax_amt + if(islien,IF(sameLien and le.lnj_liens_released_state_tax_amt>0,0,ri.lnj_liens_released_state_tax_amt),0);
		SELF.lnj_last_state_unreleased_date := if(~isLien, le.lnj_last_state_unreleased_date, 
				if((integer)le.lnj_last_state_unreleased_date > (integer)ri.lnj_last_state_unreleased_date, 
				le.lnj_last_state_unreleased_date, 
				ri.lnj_last_state_unreleased_date));
		SELF.lnj_last_state_released_date := if(~isLien, (integer)le.lnj_last_state_released_date,
			if((integer)le.lnj_last_state_released_date > (integer)ri.lnj_last_state_released_date, 
			le.lnj_last_state_released_date, 
			ri.lnj_last_state_released_date));		
	
		SELF.lnj_liens_unreleased_federal_tax_cnt := le.lnj_liens_unreleased_federal_tax_cnt + if(islien, IF(sameLien and le.lnj_liens_unreleased_federal_tax_cnt>0,0,ri.lnj_liens_unreleased_federal_tax_cnt),0);
		SELF.lnj_liens_unreleased_federal_tax_amt := le.lnj_liens_unreleased_federal_tax_amt + if(islien,IF(sameLien and le.lnj_liens_unreleased_federal_tax_amt>0,0,ri.lnj_liens_unreleased_federal_tax_amt),0);		
		SELF.lnj_liens_released_federal_tax_cnt := le.lnj_liens_released_federal_tax_cnt + if(islien,IF(sameLien and le.lnj_liens_released_federal_tax_cnt>0,0,ri.lnj_liens_released_federal_tax_cnt),0);
		SELF.lnj_liens_released_federal_tax_amt := le.lnj_liens_released_federal_tax_amt + if(islien,IF(sameLien and le.lnj_liens_released_federal_tax_amt>0,0,ri.lnj_liens_released_federal_tax_amt),0);
		SELF.lnj_last_federal_unreleased_date := if(~isLien, le.lnj_last_federal_unreleased_date, 
				if((integer)le.lnj_last_federal_unreleased_date > (integer)ri.lnj_last_federal_unreleased_date, 
				le.lnj_last_federal_unreleased_date, 
				ri.lnj_last_federal_unreleased_date));
		SELF.lnj_last_federal_released_date := if(~isLien, (integer)le.lnj_last_federal_released_date,
			if((integer)le.lnj_last_federal_released_date > (integer)ri.lnj_last_federal_released_date, 
			le.lnj_last_federal_released_date, 
			ri.lnj_last_federal_released_date));	
	
	//Jmgts											
		isJgmt := ri.LJType IN [
													risk_indicators.iid_constants.JudgmentText,
													risk_indicators.iid_constants.EvictionText,
													risk_indicators.iid_constants.OtherText
													];
		SELF.lnj_jgmt_cnt := le.lnj_jgmt_cnt + if(isJgmt, if(sameLien, 0, ri.lnj_jgmt_cnt), 0);

		SELF.lnj_last_jgmt_unreleased_date := if(~isJgmt, le.lnj_last_jgmt_unreleased_date, //not jdgmt so use left side
				if((integer)le.lnj_last_jgmt_unreleased_date > (integer)ri.lnj_last_jgmt_unreleased_date, 
				le.lnj_last_jgmt_unreleased_date, 
				ri.lnj_last_jgmt_unreleased_date));
		SELF.lnj_last_jgmt_released_date := if(~isJgmt, (integer)le.lnj_last_jgmt_released_date, //not jdgmt so use left side
			if((integer)le.lnj_last_jgmt_released_date > (integer)ri.lnj_last_jgmt_released_date, 
			le.lnj_last_jgmt_released_date, 
			ri.lnj_last_jgmt_released_date));
		SELF.lnj_jgmt_total := le.lnj_jgmt_total + if(isJgmt, IF(sameLien and le.lnj_jgmt_total>0, 0, ri.lnj_jgmt_total), 0);

		self.date_First_seen := le.date_first_seen;
		SELF.FileTypeDesc := trim(le.FileTypeDesc);
		SELF.Filingnumber := le.Filingnumber;
		SELF.Filingbook := le.Filingbook;
		SELF.Filingpage := le.Filingpage;
		SELF.Agency := le.Agency;
		SELF.Agencycounty := le.Agencycounty;
		SELF.Agencystate := le.Agencystate;
		SELF.Defendant := le.Defendant;
		SELF.Plaintiff := le.Plaintiff;
		SELF.Eviction := le.Eviction;
		SELF.FilingDescription := le.FilingDescription;
		SELF.datefiled := le.datefiled;
		SELF.ReleaseDate := le.ReleaseDate;
		SELF := ri;
	END;

	liens_rolled_original1 := ROLLUP(SORT(ungroup(liensJudgments), did, tmsid,
	-(integer) ReleaseDate, -(integer) datefiled, record),
		LEFT.did=RIGHT.did, roll_liens(LEFT,RIGHT)); 
	//if we have liens date from main that are not within 7 year window, drop them to the floor
	liens_rolled_original := group(liens_rolled_original1, did);	
	//Liens section of PR
	Risk_Indicators.Layouts_Derog_Info.Liens GetLienSeq(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_working le, integer c) := transform
		self.seq := (string) c;
		self.LienType := le.FileTypeDesc;
		self.DateLastSeen := (string) le.VendorDateLastSeen;
		self.ReleaseDate := if((integer) le.ReleaseDate =0, '', (string)le.ReleaseDate);
  self.LienTypeID := le.Filing_Type_ID;
		self := le;
		self :=[];
	end;
	//assign a Seq just on Lien records
	liens_formatted := PROJECT(SrtedLiens, GetLienSeq(LEFT, COUNTER));
	Risk_Indicators.Layouts_Derog_Info.Liens_seq LienWithInfo(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_working le, Risk_Indicators.Layouts_Derog_Info.Liens ri) := transform
		self.seq := (string) le.Seq;
		self.Did := le.Did;
		SELF.LnJliens := ri;
		self := le;
		self :=[];
	end;
	//Now put liens back on original record
	w_Liens := JOIN(liens_rolled_original, liens_formatted,
						 (String) LEFT.Did = (String) RIGHT.Did,
						 LienWithInfo(LEFT, RIGHT), LEFT OUTER);

	Risk_Indicators.Layouts_Derog_Info.Liens_seq RollLien(Risk_Indicators.Layouts_Derog_Info.Liens_seq le, Risk_Indicators.Layouts_Derog_Info.Liens_seq ri) := transform
		self.seq := (string) le.Seq;
		self.Did := le.Did;
		SELF.LnJliens := le.LnJliens + ri.LnJliens;
		self := le;
		self :=[];
	end;
	w_LiensSrt := SORT(w_Liens, Did, (integer) LnJliens[1].Seq);
	w_Liens_rolled := ROLLUP(w_LiensSrt,
						 (String) LEFT.Did = (String) RIGHT.Did,
						 RollLien(LEFT, RIGHT));

//Judgments
	Risk_Indicators.Layouts_Derog_Info.Judgments GetJdgSeq(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_working le, integer c) := transform
		self.seq := (string) c;
		self.JudgmentType := le.FileTypeDesc;
		self.DateLastSeen := (string) le.VendorDateLastSeen;
		self.ReleaseDate := if((integer) le.ReleaseDate =0, '', (string)le.ReleaseDate);
  self.JudgmentTypeID := le.Filing_Type_ID;
		self := le;
		self :=[];
	end;
	//assign a Seq just on Lien records
	Judgments_formatted := PROJECT(SrtedJudgments, GetJdgSeq(LEFT, COUNTER));
	Risk_Indicators.Layouts_Derog_Info.LJ_PublicRecords JdgWithInfo(Risk_Indicators.Layouts_Derog_Info.Liens_seq le, Risk_Indicators.Layouts_Derog_Info.Judgments ri) := transform
		self.seq := (unsigned4) le.Seq;
		self.Did := (unsigned6) le.Did;
		self.LnJJudgments :=  ri;
		self := le;
		self :=[];
	end;
	
	//Now put liens back on original record
	w_Judgments := JOIN(w_Liens_rolled, Judgments_formatted,
						 (String) LEFT.Did = (String) RIGHT.Did,
						 JdgWithInfo(LEFT, RIGHT), LEFT OUTER);

	Risk_Indicators.Layouts_Derog_Info.LJ_PublicRecords RollJdg(Risk_Indicators.Layouts_Derog_Info.LJ_PublicRecords le, Risk_Indicators.Layouts_Derog_Info.LJ_PublicRecords ri) := transform
		self.seq := (unsigned4)  le.Seq;
		self.Did := (unsigned6) le.Did;
		self.LnJJudgments := le.LnJJudgments + ri.LnJJudgments;
		self := le;
		self :=[];
	end;
	
	w_JudgmentsSrt := SORT(w_Judgments, Did, (integer) LnJJudgments[1].Seq);
	w_Liens_Jdg_rolled := ROLLUP(w_JudgmentsSrt,
						 (String) LEFT.Did = (String) RIGHT.Did,
						 RollJdg(LEFT, RIGHT));
		
	w_LiensNJudgments := JOIN(liens_rolled_original, w_Liens_Jdg_rolled,
		(string) LEFT.Did = (string) right.Did,
		TRANSFORM(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_LJ_withAttrs,
			SELF.LnJLiens := right.LnJLiens;
			SELF.LnJJudgments := right.LnJJudgments;	
			SELF := LEFT,
			SELF := []),
		LEFT OUTER);

//now that we have all the did info, rejoin back to get the Seq info
	w_LiensNJudgments_All := JOIN(w_Corrections, w_LiensNJudgments,
		(string) LEFT.Did = (string) right.Did,
		TRANSFORM(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_LJ_withAttrs,
			SELF.Seq := LEFT.Seq,
			SELF.dID := left.dID,
			SELF := LEFT,
			SELF := RIGHT,
			SELF := []),
		LEFT OUTER);

	w_LiensNJudgmentsFinal := if(FilterLiens or //filters by DRM posLiensJudgRestriction
			bsVersion < 50 or 
			IncludeLnJ = false, //filters off by Juli if input was not choosen
			project(risk_indicators.iid_constants.ds_Record,
			transform(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_LJ_withAttrs, self := [])),
			w_LiensNJudgments_All);
			
//outputs			
	// output(FilterLiens, named('FilterLiens'));
	// output(IncludeLnJ, named('IncludeLnJ2'));
	// output(liensJudgments, named('liensJudgments'));
	// output(liens_added, named('liens_added'));
	// output(liens_party_raw, named('liens_party_raw'));
	// OUTPUT(liens_main_raw, named('liens_main_raw'));
  // output(liens_main_overrides, named('liens_main_overrides'));
  // output(liens_party_overrides, named('liens_party_overrides'));
	// output(liens_full, named('liens_full'));
	// output(liens_rolled_original, named('liens_rolled_original'));
	// output(final_liens, named('final_liens'));
	// output(SrtedLiens, named('SrtedLiens'));
	// output(SrtedJudgments, named('SrtedJudgments'));
	// output(w_Liens, named('w_Liens'));
	// output(w_LiensNJudgments, named('w_LiensNJudgments'));
	// output(liens_formatted, named('liens_formatted'));
	// output(w_Liens_rolled, named('w_Liens_rolled'));
	// output(w_Liens_Jdg_rolled);
	// output(w_Judgments, named('w_Judgments'));
	// output(Judgments_formatted, named('Judgments_formatted'));
	// output(w_all, named('w_all'));
	// output(liens_filtered_a, named('liens_filtered_a'));
	// output(liens_filtered_h, named('liens_filtered_h'));
	// output(FilterCityLiens,   named('FilterCityLiens'));   
	// output(FilterCountyLiens, named('FilterCountyLiens')); 
	// output(FilterStateWarrent,named('FilterStateWarrent'));
	// output(FilterStateLiens,  named('FilterStateLiens'));  
	// output(FilterFederalLiens,named('FilterFederalLiens'));
	// output(FilterOtherLiens,  named('FilterOtherLiens'));  
	// output(FilterJudgments,   named('FilterJudgments'));   
	// output(FilterEvictions,   named('FilterEvictions'));     

	return SORT(GROUP(w_LiensNJudgmentsFinal, seq), seq);	

 END;