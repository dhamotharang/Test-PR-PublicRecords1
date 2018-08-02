IMPORT Address, Std, ut;

EXPORT fn_getBatchOutput(DATASET(HomesteadExemptionV2_Services.Layouts.workRec) ds_work_recs,
				HomesteadExemptionV2_Services.IParams.Params in_mod) := FUNCTION

	HomesteadExemptionV2_Services.Layouts.partySlim partyRecords(HomesteadExemptionV2_Services.Layouts.partySlim L,STRING FID) := TRANSFORM
		SELF.ln_fares_id:=IF(L.ln_fares_id=FID,L.ln_fares_id,SKIP);
		SELF:=L;
	END;

	HomesteadExemptionV2_Services.Layouts.batchWorkPropRec propertyRecords(HomesteadExemptionV2_Services.Layouts.propertyRec L) := TRANSFORM
		// KEEP INPUT PROPERTY AND CURRENT PROPERTIES IN TAX YEAR DATE RANGE
		isOwner:=L.isCurrentOwner OR L.isTaxYearOwner;
		propertyInDateRange:=L.inputTaxYear BETWEEN MIN(L.seenDates,tax_year) AND MAX(L.seenDates,tax_year) OR L.lastSeen <= L.inputTaxYear;
		SELF.acctno:=IF(L.property_rank<=HomesteadExemptionV2_Services.Constants.INPUT_ADDR OR (isOwner AND propertyInDateRange) OR in_mod.IncludePrevOwnedProps,L.acctno,SKIP);
		SELF.property_rank:=L.property_rank DIV 10;

		// MOST RECENT DEED RECORD
		deed:=SORT(L.deed_records.deeds(isBuyerBorrower,sortby_date[1..4]<=L.inputTaxYear),-sortby_date,-vendor_source_flag);
		deedPart:=PROJECT(L.deed_records.parties,partyRecords(LEFT,deed[1].ln_fares_id));
		deedName:=PROJECT(deedPart(party_type IN ['O','B']).entity,TRANSFORM(HomesteadExemptionV2_Services.Layouts.entitySlim,SELF:=LEFT));
		hasDeedRec:=EXISTS(deed);

		// MOST RECENT ASSESSMENT RECORD
		assessment:=SORT(L.assessment_records.assessments(isAssessee,sortby_date[1..4]<=L.inputTaxYear),-sortby_date,-vendor_source_flag);
		assessPart:=PROJECT(L.assessment_records.parties,partyRecords(LEFT,assessment[1].ln_fares_id));
		assessName:=PROJECT(assessPart(party_type='O').entity,TRANSFORM(HomesteadExemptionV2_Services.Layouts.entitySlim,SELF:=LEFT));
		hasAssessment:=EXISTS(assessment);

		// PROPERTY ADDRESS
		clnAddr1:=address.Addr1FromComponents(L.prim_range,L.predir,L.prim_name,L.addr_suffix,L.postdir,L.unit_desig,L.sec_range);
		clnAddr2:=address.Addr2FromComponentsWithZip4(L.p_city_name,L.st,L.z5,L.zip4);
		clnFullAddr:=TRIM(clnAddr1)+' '+clnAddr2;

		deedState:=IF(L.st='',deed[1].state,L.st);
		deedAddr:=IF(clnAddr1='',TRIM(deed[1].property_full_street_address)+' '+deed[1].property_address_unit_number,clnAddr1);
		deedFullAddr:=IF(clnFullAddr='',TRIM(deedAddr)+' '+deed[1].property_address_citystatezip,clnFullAddr);

		assessState:=IF(L.st='',assessment[1].state_code,L.st);
		assessAddr:=IF(clnAddr1='',TRIM(assessment[1].property_full_street_address)+' '+assessment[1].property_unit_number,clnAddr1);
		assessFullAddr:=IF(clnFullAddr='',TRIM(assessAddr)+' '+assessment[1].property_city_state_zip,clnFullAddr);

		// BATCH OWNER
		SELF.batch_owner_1_first_name    :=IF(hasDeedRec,deedName[1].fname,assessName[1].fname);
		SELF.batch_owner_1_middle_name   :=IF(hasDeedRec,deedName[1].mname,assessName[1].mname);
		SELF.batch_owner_1_last_name     :=IF(hasDeedRec,deedName[1].lname,assessName[1].lname);
		SELF.batch_owner_1_suffix        :=IF(hasDeedRec,deedName[1].name_suffix,assessName[1].name_suffix);
		SELF.batch_owner_1_company_name  :=IF(hasDeedRec,deedName[1].cname,assessName[1].cname);
		SELF.batch_owner_2_first_name    :=IF(hasDeedRec,deedName[2].fname,assessName[2].fname);
		SELF.batch_owner_2_middle_name   :=IF(hasDeedRec,deedName[2].mname,assessName[2].mname);
		SELF.batch_owner_2_last_name     :=IF(hasDeedRec,deedName[2].lname,assessName[2].lname);
		SELF.batch_owner_2_suffix        :=IF(hasDeedRec,deedName[2].name_suffix,assessName[2].name_suffix);
		SELF.batch_owner_2_company_name  :=IF(hasDeedRec,deedName[2].cname,assessName[2].cname);
		SELF.batch_owner_3_first_name    :=IF(hasDeedRec,deedName[3].fname,assessName[3].fname);
		SELF.batch_owner_3_middle_name   :=IF(hasDeedRec,deedName[3].mname,assessName[3].mname);
		SELF.batch_owner_3_last_name     :=IF(hasDeedRec,deedName[3].lname,assessName[3].lname);
		SELF.batch_owner_3_suffix        :=IF(hasDeedRec,deedName[3].name_suffix,assessName[3].name_suffix);
		SELF.batch_owner_3_company_name  :=IF(hasDeedRec,deedName[3].cname,assessName[3].cname);
		SELF.batch_owner_4_first_name    :=IF(hasDeedRec,deedName[4].fname,assessName[4].fname);
		SELF.batch_owner_4_middle_name   :=IF(hasDeedRec,deedName[4].mname,assessName[4].mname);
		SELF.batch_owner_4_last_name     :=IF(hasDeedRec,deedName[4].lname,assessName[4].lname);
		SELF.batch_owner_4_suffix        :=IF(hasDeedRec,deedName[4].name_suffix,assessName[4].name_suffix);
		SELF.batch_owner_4_company_name  :=IF(hasDeedRec,deedName[4].cname,assessName[4].cname);
		SELF.batch_full_property_address :=IF(hasDeedRec,deedFullAddr,assessFullAddr);
		SELF.batch_address               :=IF(hasDeedRec,deedAddr,assessAddr);
		SELF.batch_city                  :=L.p_city_name;
		SELF.batch_state                 :=IF(hasDeedRec,deedState,assessState);
		SELF.batch_zip                   :=L.z5+IF(L.zip4!='','-'+TRIM(L.zip4),'');
		SELF.batch_county                :=IF(hasDeedRec,deed[1].county_name,assessment[1].county_name);
		SELF.batch_fips_code             :=IF(hasDeedRec,deed[1].fips_code,assessment[1].fips_code);
		SELF.batch_parcel_number         :=IF(hasDeedRec,deed[1].apnt_or_pin_number,assessment[1].apna_or_pin_number);

		// DEED OWNER
		SELF.deed_owner_1_first_name     :=deedName[1].fname;
		SELF.deed_owner_1_middle_name    :=deedName[1].mname;
		SELF.deed_owner_1_last_name      :=deedName[1].lname;
		SELF.deed_owner_1_suffix         :=deedName[1].name_suffix;
		SELF.deed_owner_1_company_name   :=deedName[1].cname;
		SELF.deed_owner_2_first_name     :=deedName[2].fname;
		SELF.deed_owner_2_middle_name    :=deedName[2].mname;
		SELF.deed_owner_2_last_name      :=deedName[2].lname;
		SELF.deed_owner_2_suffix         :=deedName[2].name_suffix;
		SELF.deed_owner_2_company_name   :=deedName[2].cname;
		SELF.deed_owner_3_first_name     :=deedName[3].fname;
		SELF.deed_owner_3_middle_name    :=deedName[3].mname;
		SELF.deed_owner_3_last_name      :=deedName[3].lname;
		SELF.deed_owner_3_suffix         :=deedName[3].name_suffix;
		SELF.deed_owner_3_company_name   :=deedName[3].cname;
		SELF.deed_owner_4_first_name     :=deedName[4].fname;
		SELF.deed_owner_4_middle_name    :=deedName[4].mname;
		SELF.deed_owner_4_last_name      :=deedName[4].lname;
		SELF.deed_owner_4_suffix         :=deedName[4].name_suffix;
		SELF.deed_owner_4_company_name   :=deedName[4].cname;
		SELF.deed_full_property_address  :=IF(hasDeedRec,deedFullAddr,'');
		SELF.deed_address                :=IF(hasDeedRec,deedAddr,'');
		SELF.deed_city                   :=IF(hasDeedRec,L.p_city_name,'');
		SELF.deed_state                  :=IF(hasDeedRec,deedState,'');
		SELF.deed_zip                    :=IF(hasDeedRec,L.z5+IF(L.zip4!='','-'+TRIM(L.zip4),''),'');
		SELF.deed_county                 :=deed[1].county_name;
		SELF.deed_fips_code              :=deed[1].fips_code;
		SELF.deed_parcel_number          :=deed[1].apnt_or_pin_number;
		SELF.deed_contract_date          :=deed[1].contract_date;
		SELF.deed_recording_date         :=deed[1].recording_date;
		SELF.deed_mortgage_date          :=deed[1].fares_mortgage_date;

		// ASSESSMENT OWNER
		SELF.assessment_owner_1_first_name    :=assessName[1].fname;
		SELF.assessment_owner_1_middle_name   :=assessName[1].mname;
		SELF.assessment_owner_1_last_name     :=assessName[1].lname;
		SELF.assessment_owner_1_suffix        :=assessName[1].name_suffix;
		SELF.assessment_owner_1_company_name  :=assessName[1].cname;
		SELF.assessment_owner_2_first_name    :=assessName[2].fname;
		SELF.assessment_owner_2_middle_name   :=assessName[2].mname;
		SELF.assessment_owner_2_last_name     :=assessName[2].lname;
		SELF.assessment_owner_2_suffix        :=assessName[2].name_suffix;
		SELF.assessment_owner_2_company_name  :=assessName[2].cname;
		SELF.assessment_owner_3_first_name    :=assessName[3].fname;
		SELF.assessment_owner_3_middle_name   :=assessName[3].mname;
		SELF.assessment_owner_3_last_name     :=assessName[3].lname;
		SELF.assessment_owner_3_suffix        :=assessName[3].name_suffix;
		SELF.assessment_owner_3_company_name  :=assessName[3].cname;
		SELF.assessment_owner_4_first_name    :=assessName[4].fname;
		SELF.assessment_owner_4_middle_name   :=assessName[4].mname;
		SELF.assessment_owner_4_last_name     :=assessName[4].lname;
		SELF.assessment_owner_4_suffix        :=assessName[4].name_suffix;
		SELF.assessment_owner_4_company_name  :=assessName[4].cname;
		SELF.assessment_full_mailing_address  :=TRIM(assessment[1].mailing_full_street_address)+
			' '+TRIM(assessment[1].mailing_unit_number)+' '+TRIM(assessment[1].mailing_city_state_zip);
		SELF.assessment_full_property_address :=IF(hasAssessment,assessFullAddr,'');
		SELF.assessment_address               :=IF(hasAssessment,assessAddr,'');
		SELF.assessment_city                  :=IF(hasAssessment,L.p_city_name,'');
		SELF.assessment_state                 :=IF(hasAssessment,assessState,'');
		SELF.assessment_zip                   :=IF(hasAssessment,L.z5+IF(L.zip4!='','-'+TRIM(L.zip4),''),'');
		SELF.assessment_county                :=assessment[1].county_name;
		SELF.assessment_fips_code             :=assessment[1].fips_code;
		SELF.assessment_parcel_number         :=assessment[1].apna_or_pin_number;
		SELF.assessment_recording_date        :=assessment[1].recording_date;
		SELF.assessment_sale_date             :=assessment[1].sale_date;
		SELF.assessment_owner_occupied        :=assessment[1].owner_occupied;
		SELF.assessment_land_usage            :=assessment[1].standardized_land_use_code;
		SELF.assessment_tax_year              :=IF(assessment[1].tax_year!='',assessment[1].tax_year,assessment[1].assessed_value_year);

		// ROLLUP EXEMPTIONS
		previousYears:=HomesteadExemptionV2_Services.Functions.previousYears(L.inputTaxYear,HomesteadExemptionV2_Services.Constants.HOMESTEAD_YEARS);
		hmstdYearRecs:=L.hmstdExmptns(tax_year IN SET(previousYears,year));
		hmstdRollRecs:=ROLLUP(SORT(hmstdYearRecs,-tax_year),TRUE,TRANSFORM(HomesteadExemptionV2_Services.Layouts.hmstdYearRec,
			SELF.hmstdExmptn:=IF(LEFT.hmstdExmptn!='',LEFT.hmstdExmptn,RIGHT.hmstdExmptn),
			SELF.exmptn1:=IF(LEFT.exmptn1!='',LEFT.exmptn1,RIGHT.exmptn1),
			SELF.exmptn2:=IF(LEFT.exmptn2!='',LEFT.exmptn2,RIGHT.exmptn2),
			SELF.exmptn3:=IF(LEFT.exmptn3!='',LEFT.exmptn3,RIGHT.exmptn3),
			SELF.exmptn4:=IF(LEFT.exmptn4!='',LEFT.exmptn4,RIGHT.exmptn4),
			SELF:=LEFT
		));

		SELF.assess_homestead_exemption_flag  :=IF(L.hasHmstdExmptn,hmstdRollRecs[1].hmstdExmptn,assessment[1].homestead_homeowner_exemption);
		SELF.assess_tax_exemption1_desc       :=IF(L.hasHmstdExmptn,hmstdRollRecs[1].exmptn1,assessment[1].tax_exemption1_desc);
		SELF.assess_tax_exemption2_desc       :=IF(L.hasHmstdExmptn,hmstdRollRecs[1].exmptn2,assessment[1].tax_exemption2_desc);
		SELF.assess_tax_exemption3_desc       :=IF(L.hasHmstdExmptn,hmstdRollRecs[1].exmptn3,assessment[1].tax_exemption3_desc);
		SELF.assess_tax_exemption4_desc       :=IF(L.hasHmstdExmptn,hmstdRollRecs[1].exmptn4,assessment[1].tax_exemption4_desc);

		// MISC INFO
		SELF.homestead_exemption_claimed:=IF(L.hasHmstdExmptn,'Y',IF(hasAssessment,'N',''));
		SELF.record_type:=MAP(hasAssessment AND hasDeedRec => 'AD',
			hasAssessment => 'A',
			hasDeedRec => 'D',
			'');
		SELF.possible_business_owned:=IF(L.isBusinessOwned OR EXISTS(deedName(cname!='')+assessName(cname!='')),'Y',IF(hasDeedRec OR hasAssessment,'N',''));
		SELF.best_address_addr_match:=IF(L.isBestAddress,'Y','N');
		SELF.count_hmstd_exmptn_years:=IF(L.hasHmstdExmptn,L.cntHmstdExmptns,0);
		SELF.most_recent_hmstd_exmptn_year:=IF(L.hasHmstdExmptn,L.lastHmstdExmptn,'');

		// MOST RECENT FORECLOSURE RECORD
		foreclosure:=SORT(L.foreclosure_records,-recording_date);
		SELF.foreclosure_buyer_1_first_name   :=foreclosure[1].name1_first;
		SELF.foreclosure_buyer_1_middle_name  :=foreclosure[1].name1_middle;
		SELF.foreclosure_buyer_1_last_name    :=foreclosure[1].name1_last;
		SELF.foreclosure_buyer_1_suffix       :=foreclosure[1].name1_suffix;
		SELF.foreclosure_buyer_1_company_name :=foreclosure[1].name1_company;
		SELF.foreclosure_buyer_2_first_name   :=foreclosure[1].name2_first;
		SELF.foreclosure_buyer_2_middle_name  :=foreclosure[1].name2_middle;
		SELF.foreclosure_buyer_2_last_name    :=foreclosure[1].name2_last;
		SELF.foreclosure_buyer_2_suffix       :=foreclosure[1].name2_suffix;
		SELF.foreclosure_buyer_2_company_name :=foreclosure[1].name2_company;
		SELF.foreclosure_recording_date       :=foreclosure[1].recording_date;

		// MOST RECENT HEADER RECORDS
		person:=SORT(L.additional_person_records,-dt_last_seen,-dt_first_seen);
		SELF.addlperson_1_lexid       :=person[1].did;
		SELF.addlperson_1_first_name  :=person[1].name_first;
		SELF.addlperson_1_middle_name :=person[1].name_middle;
		SELF.addlperson_1_last_name   :=person[1].name_last;
		SELF.addlperson_1_suffix      :=person[1].name_suffix;
		SELF.addlperson_1_firstseen   :=(STRING)person[1].dt_first_seen;
		SELF.addlperson_1_lastseen    :=(STRING)person[1].dt_last_seen;
		SELF.addlperson_2_lexid       :=person[2].did;
		SELF.addlperson_2_first_name  :=person[2].name_first;
		SELF.addlperson_2_middle_name :=person[2].name_middle;
		SELF.addlperson_2_last_name   :=person[2].name_last;
		SELF.addlperson_2_suffix      :=person[2].name_suffix;
		SELF.addlperson_2_firstseen   :=(STRING)person[2].dt_first_seen;
		SELF.addlperson_2_lastseen    :=(STRING)person[2].dt_last_seen;

		// RELATIVES
		relatives:=L.relative_records(hasAddrMatch);
		SELF.relative_addr_match:=IF(EXISTS(relatives),'Y','N');

		// VEHICLES
		vehicleCurrent:=DEDUP(SORT(L.vehicle_records(isCurrent),VIN,-DataSource),VIN);
		vehicleAddrMatch:=DEDUP(SORT(L.vehicle_records(hasCurrAddrMatch),VIN,-DataSource),VIN);
		SELF.vehicle_reg_addr_match:=MAP(
			NOT EXISTS(vehicleCurrent) => HomesteadExemptionV2_Services.Constants.NO_INFO, // NO CURRENT VEHICLE RECORDS
			EXISTS(vehicleAddrMatch) => 'Y', // CURRENT VEHICLE RECORD WITH ADDR MATCH
			'N'); // CURRENT VEHICLE NO ADDR MATCH
		SELF.vehicle_reg_count:=COUNT(vehicleAddrMatch); // COUNT CURRENT VEHICLES WITH ADDR MATCH

		// DRIVER
		driverAddrMatch:=SORT(L.driver_records(hasCurrAddrMatch),-lic_issue_date);
		SELF.driver_addr_match:=MAP(
			NOT EXISTS(L.driver_records) => HomesteadExemptionV2_Services.Constants.NO_INFO, // NO DRIVER RECORDS
			EXISTS(driverAddrMatch) => 'Y', // CURRENT DRIVER RECORD WITH ADDR MATCH
			'N'); // DRIVER RECORDS CURRENT AND/OR EXPIRED

		// VOTER
		SELF.voter_reg_addr_match:=MAP(
			NOT EXISTS(L.voter_records) => HomesteadExemptionV2_Services.Constants.NO_INFO, // NO VOTER RECORDS
			EXISTS(L.voter_records(hasAddrMatch)) => 'Y', // HAS VOTER RECORD WITH ADDR MATCH
 			'N');
	END;

	HomesteadExemptionV2_Services.Layouts.batchWorkRec batchRecords(HomesteadExemptionV2_Services.Layouts.workRec L) := TRANSFORM
		// LEXID
		SELF.acctno:=L.acctno;
		SELF.lexid:=L.did;
		SELF.lexid_score:=L.score;
		SELF.exception:=IF(L.error_code!=0,'Y','');
		SELF.exception_code:=L.exception_code;
		// BEST RECORD
		bestRec:=L.Best_Records[1];
		hasNameMatch:=L.name_first=bestRec.name_first AND L.name_middle=bestRec.name_middle AND L.name_last=bestRec.name_last AND L.name_suffix=bestRec.name_suffix;
		SELF.best_first_name  :=IF(NOT hasNameMatch,bestRec.name_first,'');
		SELF.best_middle_name :=IF(NOT hasNameMatch,bestRec.name_middle,'');
		SELF.best_last_name   :=IF(NOT hasNameMatch,bestRec.name_last,'');
		SELF.best_suffix      :=IF(NOT hasNameMatch,bestRec.name_suffix,'');
		SELF.best_SSN         :=IF(L.SSN!=bestRec.SSN OR L.SSN='',bestRec.SSN_masked,'');
		SELF.best_DOB         :=IF(L.DOB[1..6]!=bestRec.DOB[1..6] OR L.DOB='',bestRec.DOB_masked,'');
		SELF.best_phone       :=bestRec.phoneno;
		SELF.calculated_age   :=ut.Age((UNSIGNED4)IF(bestRec.DOB!='',bestRec.DOB,L.DOB));
		SELF.best_address     :=bestRec.addr;
		SELF.best_city        :=bestRec.p_city_name;
		SELF.best_state       :=bestRec.st;
		SELF.best_zip         :=bestRec.z5;
		SELF.best_address_confidence:=bestRec.conf_flag;
		// DECEASED RECORD
		dcsdRec:=SORT(L.deceased_records(Std.Str.Find(MatchCode,'N')>0 AND (DOB[1..4]=bestRec.DOB[1..4] OR DOB[1..4]=L.DOB[1..4])),-fileDate)[1];
		SELF.deceased_date_of_death :=dcsdRec.DOD;
		SELF.deceased_dob           :=dcsdRec.DOB_masked;
		SELF.deceased_first_name    :=dcsdRec.name_first;
		SELF.deceased_middle_name   :=dcsdRec.name_middle;
		SELF.deceased_last_name     :=dcsdRec.name_last;
		SELF.deceased_suffix        :=dcsdRec.name_suffix;
		SELF.deceased_ssn           :=dcsdRec.SSN_masked;
		SELF.deceased_state         :=dcsdRec.state;
		SELF.deceased_source        :=dcsdRec.source;
		SELF.death_confirmed        :=MAP(dcsdRec.vorp_code='V'=>'Verified',dcsdRec.vorp_code='P'=>'Proof','');
		// INPUT PROPERTY NOT OWNED
		SELF.input_addr_owner_1_lexid       :=L.Ownership_Record.owner_did;
		SELF.input_addr_owner_1_bdid        :=L.Ownership_Record.owner_bdid;
		SELF.input_addr_owner_1_first_name  :=L.Ownership_Record.name_first;
		SELF.input_addr_owner_1_middle_name :=L.Ownership_Record.name_middle;
		SELF.input_addr_owner_1_last_name   :=L.Ownership_Record.name_last;
		SELF.input_addr_owner_1_suffix      :=L.Ownership_Record.name_suffix;
		SELF.input_addr_owner_1_company_name:=L.Ownership_Record.company_name;
		SELF.input_addr_sale_date           :=L.Ownership_Record.sale_date;
		SELF.input_addr_contract_date       :=L.Ownership_Record.contract_date;
		SELF.input_subject_still_owner      :=IF(L.Ownership_Record.owner_did!=0 OR L.Ownership_Record.owner_bdid!=0,IF(L.Ownership_Record.isCurrentOwner,'Y','N'),'');

		// ALWAYS OUTPUT CURRENT DRIVER STATE
		driver_records:=SORT(NORMALIZE(L.property_records,LEFT.driver_records,TRANSFORM(HomesteadExemptionV2_Services.Layouts.driverRec,SELF:=RIGHT)),-lic_issue_date);
		driverAddrMatch:=driver_records(hasCurrAddrMatch);
		driverCurrent:=driver_records(isCurrent);
		SELF.driver_state:=MAP(
			EXISTS(driverAddrMatch) => driverAddrMatch[1].st, // CURRENT DRIVER STATE WITH ADDR MATCH
			EXISTS(driverCurrent) => driverCurrent[1].st, // CURRENT DRIVER STATE
			''); // NO DRIVER RECORDS OR EXPIRED RECORDS

		// ALWAYS OUTPUT MOST RECENT VOTER INFO
		voter_records:=NORMALIZE(L.property_records,LEFT.voter_records,TRANSFORM(HomesteadExemptionV2_Services.Layouts.voterRec,SELF:=RIGHT));
		voterLastVote:=SORT(voter_records,-LastDateVote);
		SELF.voter_reg_state:=voterLastVote[1].source_state; // LAST VOTER STATE
		SELF.voter_reg_last_vote_year:=voterLastVote[1].LastDateVote; // LAST VOTER YEAR

		// MAX PROPERTY RECORDS
		SELF.property_records:=CHOOSEN(PROJECT(SORT(L.property_records,property_rank,-sortby_date),propertyRecords(LEFT)),in_mod.MaxProperties);
	END;

	RETURN PROJECT(ds_work_recs,batchRecords(LEFT));
END;
