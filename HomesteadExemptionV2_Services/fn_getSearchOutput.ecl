IMPORT Address, iesp, Std, ut;

EXPORT fn_getSearchOutput(DATASET(HomesteadExemptionV2_Services.Layouts.workRec) ds_work_recs,
        HomesteadExemptionV2_Services.IParams.Params in_mod) := FUNCTION

  HomesteadExemptionV2_Services.Layouts.partySlim partyRecords(HomesteadExemptionV2_Services.Layouts.partySlim L,STRING FID) := TRANSFORM
    SELF.ln_fares_id:=IF(L.ln_fares_id=FID,L.ln_fares_id,SKIP);
    SELF:=L;
  END;

  CNST:=HomesteadExemptionV2_Services.Constants;

  iesp.homestead_exemption_search.t_HEPropertyRecord propertyRecords(HomesteadExemptionV2_Services.Layouts.propertyRec L) := TRANSFORM
    // KEEP INPUT PROPERTY AND CURRENT PROPERTIES IN TAX YEAR DATE RANGE
    isOwner:=L.isCurrentOwner OR L.isTaxYearOwner;
    propertyInDateRange:=L.inputTaxYear BETWEEN MIN(L.seenDates,tax_year) AND MAX(L.seenDates,tax_year) OR L.lastSeen <= L.inputTaxYear;
    PropertyRank:=IF(L.property_rank<=CNST.ASSESS_ONLY,L.property_rank DIV 10,SKIP);
    SELF.PropertyRank:=IF(L.property_rank<=CNST.INPUT_ADDR OR (isOwner AND propertyInDateRange) OR in_mod.IncludePrevOwnedProps,PropertyRank,SKIP);

    // MOST RECENT DEED RECORD
    deed:=SORT(L.deed_records.deeds(isBuyerBorrower,sortby_date[1..4]<=L.inputTaxYear),-sortby_date,-vendor_source_flag);
    deedPart:=PROJECT(L.deed_records.parties,partyRecords(LEFT,deed[1].ln_fares_id));
    deedName:=PROJECT(deedPart(party_type IN [CNST.OWNER,CNST.BORROWER]).entity,HomesteadExemptionV2_Services.Layouts.entitySlim);
    hasDeedRec:=EXISTS(deed);

    // MOST RECENT ASSESSMENT RECORD
    assessment:=SORT(L.assessment_records.assessments(isAssessee,sortby_date[1..4]<=L.inputTaxYear),-sortby_date,-vendor_source_flag);
    assessPart:=PROJECT(L.assessment_records.parties,partyRecords(LEFT,assessment[1].ln_fares_id));
    assessName:=PROJECT(assessPart(party_type=CNST.OWNER).entity,HomesteadExemptionV2_Services.Layouts.entitySlim);
    hasAssessment:=EXISTS(assessment);

    // PROPERTY ADDRESS
    clnAddr1:=address.Addr1FromComponents(L.prim_range,L.predir,L.prim_name,L.addr_suffix,L.postdir,'','');
    clnAddr2:=address.Addr1FromComponents('','','','','',L.unit_desig,L.sec_range);
    clnAddr3:=address.Addr2FromComponentsWithZip4(L.p_city_name,L.st,L.z5,L.zip4);

    deedState:=IF(L.st='',deed[1].state,L.st);
    deedAddr1:=IF(clnAddr1='',deed[1].property_full_street_address,clnAddr1);
    deedAddr2:=IF(clnAddr2='',deed[1].property_address_unit_number,clnAddr2);
    deedAddr3:=IF(clnAddr3='',deed[1].property_address_citystatezip,clnAddr3);

    assessState:=IF(L.st='',assessment[1].state_code,L.st);
    assessAddr1:=IF(clnAddr1='',assessment[1].property_full_street_address,clnAddr1);
    assessAddr2:=IF(clnAddr2='',assessment[1].property_unit_number,clnAddr2);
    assessAddr3:=IF(clnAddr3='',assessment[1].property_city_state_zip,clnAddr3);

    // PROPERTY
    deedNames:=CHOOSEN(deedName,iesp.Constants.hmstdExmptn.MAX_OWNERS);
    assessNames:=CHOOSEN(assessName,iesp.Constants.hmstdExmptn.MAX_OWNERS);
    SELF.Property.Owners:=PROJECT(IF(hasDeedRec,deedNames,assessNames),TRANSFORM(iesp.share.t_NameAndCompany,
      SELF.First :=LEFT.fname,
      SELF.Middle:=LEFT.mname,
      SELF.Last  :=LEFT.lname,
      SELF.Suffix:=LEFT.name_suffix,
      SELF.CompanyName:=LEFT.cname,
      SELF:=[]
      ));
    SELF.Property.Address.StreetAddress1 :=IF(hasDeedRec,deedAddr1,assessAddr1);
    SELF.Property.Address.StreetAddress2 :=IF(hasDeedRec,deedAddr2,assessAddr2);
    SELF.Property.Address.StateCityZip :=IF(hasDeedRec,deedAddr3,assessAddr3);
    SELF.Property.Address.City   :=L.p_city_name;
    SELF.Property.Address.State  :=IF(hasDeedRec,deedState,assessState);
    SELF.Property.Address.Zip5   :=L.z5;
    SELF.Property.Address.Zip4   :=L.zip4;
    SELF.Property.Address.County :=IF(hasDeedRec,deed[1].county_name,assessment[1].county_name);
    SELF.Property.FipsCode       :=IF(hasDeedRec,deed[1].fips_code,assessment[1].fips_code);
    SELF.Property.ParcelNumber   :=IF(hasDeedRec,deed[1].apnt_or_pin_number,assessment[1].apna_or_pin_number);

    // DEED
    SELF.Deed.Owners:=PROJECT(deedNames,TRANSFORM(iesp.share.t_NameAndCompany,
        SELF.First :=LEFT.fname,
        SELF.Middle:=LEFT.mname,
        SELF.Last  :=LEFT.lname,
        SELF.Suffix:=LEFT.name_suffix,
        SELF.CompanyName:=LEFT.cname,
        SELF:=[]
        ));
    SELF.Deed.Address.StreetAddress1 :=IF(hasDeedRec,deedAddr1,'');
    SELF.Deed.Address.StreetAddress2 :=IF(hasDeedRec,deedAddr2,'');
    SELF.Deed.Address.StateCityZip :=IF(hasDeedRec,deedAddr3,'');
    SELF.Deed.Address.City   :=IF(hasDeedRec,L.p_city_name,'');
    SELF.Deed.Address.State  :=IF(hasDeedRec,deedState,'');
    SELF.Deed.Address.Zip5   :=IF(hasDeedRec,L.z5,'');
    SELF.Deed.Address.Zip4   :=IF(hasDeedRec,L.zip4,'');
    SELF.Deed.Address.County :=deed[1].county_name;
    SELF.Deed.FipsCode       :=deed[1].fips_code;
    SELF.Deed.ParcelNumber   :=deed[1].apnt_or_pin_number;
    SELF.Deed.ContractDate   :=iesp.ECL2ESP.toDatestring8(deed[1].contract_date);
    SELF.Deed.RecordingDate  :=iesp.ECL2ESP.toDatestring8(deed[1].recording_date);
    SELF.Deed.MortgageDate   :=iesp.ECL2ESP.toDatestring8(deed[1].fares_mortgage_date);

    // ASSESSMENT OWNER
    SELF.Assessment.Owners:=PROJECT(assessNames,TRANSFORM(iesp.share.t_NameAndCompany,
        SELF.First :=LEFT.fname,
        SELF.Middle:=LEFT.mname,
        SELF.Last  :=LEFT.lname,
        SELF.Suffix:=LEFT.name_suffix,
        SELF.CompanyName:=LEFT.cname,
        SELF:=[]
        ));
    SELF.Assessment.MailingAddress.StreetAddress1 :=assessment[1].mailing_full_street_address;
    SELF.Assessment.MailingAddress.StreetAddress2 :=assessment[1].mailing_unit_number;
    SELF.Assessment.MailingAddress.StateCityZip :=assessment[1].mailing_city_state_zip;
    SELF.Assessment.PropertyAddress.StreetAddress1 :=IF(hasAssessment,assessAddr1,'');
    SELF.Assessment.PropertyAddress.StreetAddress2 :=IF(hasAssessment,assessAddr2,'');
    SELF.Assessment.PropertyAddress.StateCityZip :=IF(hasAssessment,assessAddr3,'');
    SELF.Assessment.PropertyAddress.City   :=IF(hasAssessment,L.p_city_name,'');
    SELF.Assessment.PropertyAddress.State  :=IF(hasAssessment,assessState,'');
    SELF.Assessment.PropertyAddress.Zip5   :=IF(hasAssessment,L.z5,'');
    SELF.Assessment.PropertyAddress.Zip4   :=IF(hasAssessment,L.zip4,'');
    SELF.Assessment.PropertyAddress.County :=assessment[1].county_name;
    SELF.Assessment.FipsCode      :=assessment[1].fips_code;
    SELF.Assessment.ParcelNumber  :=assessment[1].apna_or_pin_number;
    SELF.Assessment.RecordingDate :=iesp.ECL2ESP.toDatestring8(assessment[1].recording_date);
    SELF.Assessment.SaleDate      :=iesp.ECL2ESP.toDatestring8(assessment[1].sale_date);
    SELF.Assessment.OwnerOccupied :=assessment[1].owner_occupied;
    SELF.Assessment.LandUsage     :=assessment[1].standardized_land_use_code;
    SELF.Assessment.TaxYear       :=IF(assessment[1].tax_year!='',assessment[1].tax_year,assessment[1].assessed_value_year);

    // ROLLUP EXEMPTIONS
    previousYears:=HomesteadExemptionV2_Services.Functions.previousYears(L.inputTaxYear,CNST.HOMESTEAD_YEARS);
    hmstdYearRecs:=L.hmstdExmptns(tax_year IN SET(previousYears,year));
    hmstdRollRecs:=ROLLUP(SORT(hmstdYearRecs,-tax_year),TRUE,TRANSFORM(HomesteadExemptionV2_Services.Layouts.hmstdYearRec,
      SELF.hmstdExmptn:=IF(LEFT.hmstdExmptn!='',LEFT.hmstdExmptn,RIGHT.hmstdExmptn),
      SELF.exmptn1:=IF(LEFT.exmptn1!='',LEFT.exmptn1,RIGHT.exmptn1),
      SELF.exmptn2:=IF(LEFT.exmptn2!='',LEFT.exmptn2,RIGHT.exmptn2),
      SELF.exmptn3:=IF(LEFT.exmptn3!='',LEFT.exmptn3,RIGHT.exmptn3),
      SELF.exmptn4:=IF(LEFT.exmptn4!='',LEFT.exmptn4,RIGHT.exmptn4),
      SELF:=LEFT
    ));
    SELF.Assessment.ExemptionFlag :=IF(L.hasHmstdExmptn,hmstdRollRecs[1].hmstdExmptn,assessment[1].homestead_homeowner_exemption);
    Descriptions:=IF(L.hasHmstdExmptn,
      DATASET([
        hmstdRollRecs[1].exmptn1,
        hmstdRollRecs[1].exmptn2,
        hmstdRollRecs[1].exmptn3,
        hmstdRollRecs[1].exmptn4
      ],iesp.share.t_StringArrayItem),
      DATASET([
        assessment[1].tax_exemption1_desc,
        assessment[1].tax_exemption2_desc,
        assessment[1].tax_exemption3_desc,
        assessment[1].tax_exemption4_desc
      ],iesp.share.t_StringArrayItem));
   SELF.Assessment.Exemptions:=CHOOSEN(Descriptions(value!=''),iesp.Constants.hmstdExmptn.MAX_EXMPTN);
   SELF.Assessment.ExemptionClaimed:=IF(L.hasHmstdExmptn,'Y',IF(hasAssessment,'N',''));

    // MISC INFO
    SELF.RecordType:=MAP(hasAssessment AND hasDeedRec => CNST.ASSESSMENT+CNST.DEED,
      hasAssessment => CNST.ASSESSMENT,
      hasDeedRec => CNST.DEED,
      '');
    SELF.PossibleBusinessOwned:=IF(L.isBusinessOwned OR EXISTS(deedName(cname!='')+assessName(cname!='')),'Y',IF(hasDeedRec OR hasAssessment,'N',''));
    SELF.BestAddressMatch:=IF(L.isBestAddress,'Y','N');
    SELF.CountExemptionYears:=IF(L.hasHmstdExmptn,L.cntHmstdExmptns,0);
    SELF.RecentExemptionYear:=IF(L.hasHmstdExmptn,L.lastHmstdExmptn,'');

    // MOST RECENT FORECLOSURE RECORD
    foreclosure:=SORT(L.foreclosure_records,-recording_date)[1];
    Buyers:=DATASET([
      {'',foreclosure.name1_first,foreclosure.name1_middle,foreclosure.name1_last,foreclosure.name1_suffix,'',foreclosure.name1_company},
      {'',foreclosure.name2_first,foreclosure.name2_middle,foreclosure.name2_last,foreclosure.name2_suffix,'',foreclosure.name2_company}
    ],iesp.share.t_NameAndCompany);
    SELF.Foreclosure.Buyers:=CHOOSEN(Buyers(Last!='' OR CompanyName!=''),iesp.Constants.hmstdExmptn.MAX_OWNERS);
    SELF.Foreclosure.RecordingDate:=iesp.ECL2ESP.toDatestring8(foreclosure.recording_date);

    // MOST RECENT HEADER RECORDS
    person:=SORT(L.additional_person_records,-dt_last_seen,-dt_first_seen);
    persons:=CHOOSEN(person,iesp.Constants.hmstdExmptn.MAX_PERSONS);
    SELF.AdditionalPersons:=PROJECT(persons,TRANSFORM(iesp.homestead_exemption_search.t_HEAdditionalPerson,
      SELF.LexId:=(STRING)LEFT.did,
      SELF.Name.First:=LEFT.name_first,
      SELF.Name.Middle:=LEFT.name_middle,
      SELF.Name.Last:=LEFT.name_last,
      SELF.Name.Suffix:=LEFT.name_suffix,
      SELF.DateFirstSeen:=iesp.ECL2ESP.toDatestring8((STRING)LEFT.dt_first_seen),
      SELF.DateLastSeen:=iesp.ECL2ESP.toDatestring8((STRING)LEFT.dt_last_seen),
      SELF:=[]
      ));

    // RELATIVES
    relatives:=L.relative_records(hasAddrMatch);
    SELF.RelativeAddressMatch:=IF(EXISTS(relatives),'Y','N');

    // ONLY REPORT ADDRESS MATCHES FOR PROPERTIES RANKED BETWEEN 10 AND 30
    hasAddrMatchRank:=L.property_rank BETWEEN CNST.INPUT_ADDR AND CNST.HAS_EXMPTNS;

    // VEHICLES
    vehicleCurrent:=DEDUP(SORT(L.vehicle_records(isCurrent),VIN,-DataSource),VIN);
    vehicleAddrMatch:=DEDUP(SORT(L.vehicle_records(hasCurrAddrMatch),VIN,-DataSource),VIN);
    SELF.VehicleAddressMatch:=MAP(
      NOT hasAddrMatchRank => '',
      NOT EXISTS(vehicleCurrent) => CNST.NO_INFO, // NO CURRENT VEHICLE RECORDS
      EXISTS(vehicleAddrMatch) => 'Y', // CURRENT VEHICLE RECORD WITH ADDR MATCH
      'N'); // CURRENT VEHICLE NO ADDR MATCH
    SELF.VehicleRegistrationCount:=COUNT(vehicleAddrMatch); // COUNT CURRENT VEHICLES WITH ADDR MATCH

    // DRIVER
    driverAddrMatch:=SORT(L.driver_records(hasCurrAddrMatch),-lic_issue_date);
    SELF.DriverAddressMatch:=MAP(
      NOT hasAddrMatchRank => '',
      NOT EXISTS(L.driver_records) => CNST.NO_INFO, // NO DRIVER RECORDS
      EXISTS(driverAddrMatch) => 'Y', // CURRENT DRIVER RECORD WITH ADDR MATCH
      'N'); // DRIVER RECORDS CURRENT AND/OR EXPIRED

    // VOTER
    SELF.VoterAddressMatch:=MAP(
      NOT hasAddrMatchRank => '',
      NOT EXISTS(L.voter_records) => CNST.NO_INFO, // NO VOTER RECORDS
      EXISTS(L.voter_records(hasAddrMatch)) => 'Y', // HAS VOTER RECORD WITH ADDR MATCH
      'N');

      SELF:=[];
  END;

  iesp.homestead_exemption_search.t_HomesteadExemptionRecord searchRecords(HomesteadExemptionV2_Services.Layouts.workRec L) := TRANSFORM
    // LEXID
    SELF.LexId:=(STRING)L.did;
    SELF.LexIdScore:=(STRING)L.score;
    hasException:=L.error_code!=0;
    SELF.ExceptionOccured:=IF(hasException,'Y','');
    SELF.ExceptionCode:=L.exception_code;

    // BEST RECORD
    bestRec:=L.Best_Records[1];
    hasNameMatch:=L.name_first=bestRec.name_first AND L.name_middle=bestRec.name_middle AND L.name_last=bestRec.name_last AND L.name_suffix=bestRec.name_suffix;
    // Populate Name WHEN not exact match for full input name
    SELF.BestRecord.Name.First  :=IF(NOT hasNameMatch,bestRec.name_first,'');
    SELF.BestRecord.Name.Middle :=IF(NOT hasNameMatch,bestRec.name_middle,'');
    SELF.BestRecord.Name.Last   :=IF(NOT hasNameMatch,bestRec.name_last,'');
    SELF.BestRecord.Name.Suffix :=IF(NOT hasNameMatch,bestRec.name_suffix,'');
    // Populate SSN WHEN not match input OR blank input
    SELF.BestRecord.SSN :=IF(L.SSN!=bestRec.SSN OR L.SSN='',bestRec.SSN_masked,'');
    // Populate DOB WHEN not match input YYYYMM OR blank input
    DOB:=IF(L.DOB[1..6]!=bestRec.DOB[1..6] OR L.DOB='',bestRec.DOB_masked,'');
    SELF.BestRecord.DOB   :=iesp.ECL2ESP.toDatestring8(DOB);
    SELF.BestRecord.Phone :=bestRec.phoneno;
    // Use best DOB else input DOB to calculate age
    BestRecAge:=ut.Age((UNSIGNED4)IF(bestRec.DOB!='',bestRec.DOB,L.DOB));
    SELF.BestRecord.Age:=BestRecAge;
    SELF.BestRecord.Address.StreetNumber        :=bestRec.prim_range;
    SELF.BestRecord.Address.StreetPreDirection  :=bestRec.predir;
    SELF.BestRecord.Address.StreetName          :=bestRec.prim_name;
    SELF.BestRecord.Address.StreetSuffix        :=bestRec.addr_suffix;
    SELF.BestRecord.Address.StreetPostDirection :=bestRec.postdir;
    SELF.BestRecord.Address.UnitDesignation     :=bestRec.unit_desig;
    SELF.BestRecord.Address.UnitNumber          :=bestRec.sec_range;
    SELF.BestRecord.Address.StreetAddress1      :=bestRec.addr;
    SELF.BestRecord.Address.City      :=bestRec.p_city_name;
    SELF.BestRecord.Address.State     :=bestRec.st;
    SELF.BestRecord.Address.Zip5      :=bestRec.z5;
    SELF.BestRecord.Address.Zip4      :=bestRec.zip4;
    SELF.BestRecord.Address.County    :=bestRec.county_name;
    SELF.BestRecord.AddressConfidence :=bestRec.conf_flag; //values['H','M','L','']

    // DECEASED RECORD
    // Populate WHEN match code includes 'N' (name match) AND DOB YYYY matches best DOB or input DOB
    dcsdRecs:=SORT(L.deceased_records(Std.Str.Find(MatchCode,'N')>0 AND (DOB[1..4]=bestRec.DOB[1..4] OR DOB[1..4]=L.DOB[1..4])),-fileDate);
    dcsdRec:=dcsdRecs[1]; // latest deceased record
    SELF.DeceasedRecord.DOD :=iesp.ECL2ESP.toDatestring8(dcsdRec.DOD);
    SELF.DeceasedRecord.DOB :=iesp.ECL2ESP.toDatestring8(dcsdRec.DOB_masked);
    SELF.DeceasedRecord.Name.First  :=dcsdRec.name_first;
    SELF.DeceasedRecord.Name.Middle :=dcsdRec.name_middle;
    SELF.DeceasedRecord.Name.Last   :=dcsdRec.name_last;
    SELF.DeceasedRecord.Name.Suffix :=dcsdRec.name_suffix;
    SELF.DeceasedRecord.SSN         :=dcsdRec.SSN_masked;
    SELF.DeceasedRecord.State       :=dcsdRec.state;
    SELF.DeceasedRecord.Source      :=dcsdRec.source;
    SELF.DeceasedRecord.Confirmed   :=MAP(
      dcsdRec.vorp_code=CNST.VERIFIED[1] => CNST.VERIFIED,
      dcsdRec.vorp_code=CNST.PROOF[1] => CNST.PROOF,
      '');

    // INPUT PROPERTY NOT OWNED
    // Populate WHEN input property is not currently owned by subject
    SELF.InputAddress.LexId :=IF(L.Ownership_Record.owner_did>0,(STRING)L.Ownership_Record.owner_did,'');
    SELF.InputAddress.BusinessID :=IF(L.Ownership_Record.owner_bdid>0,(STRING)L.Ownership_Record.owner_bdid,'');
    SELF.InputAddress.Name.First  :=L.Ownership_Record.name_first;
    SELF.InputAddress.Name.Middle :=L.Ownership_Record.name_middle;
    SELF.InputAddress.Name.Last   :=L.Ownership_Record.name_last;
    SELF.InputAddress.Name.Suffix :=L.Ownership_Record.name_suffix;
    SELF.InputAddress.Name.CompanyName :=L.Ownership_Record.company_name;
    SELF.InputAddress.SaleDate       :=iesp.ECL2ESP.toDatestring8(L.Ownership_Record.sale_date);
    SELF.InputAddress.ContractDate   :=iesp.ECL2ESP.toDatestring8(L.Ownership_Record.contract_date);
    SELF.InputAddress.isSubjectOwner :=IF(L.Ownership_Record.owner_did!=0 OR L.Ownership_Record.owner_bdid!=0,IF(L.Ownership_Record.isCurrentOwner,'Y','N'),'');

    // ALWAYS OUTPUT CURRENT DRIVER STATE
    driver_records:=SORT(NORMALIZE(L.property_records,LEFT.driver_records,TRANSFORM(HomesteadExemptionV2_Services.Layouts.driverRec,SELF:=RIGHT)),-lic_issue_date);
    driverAddrMatch:=driver_records(hasCurrAddrMatch);
    driverCurrent:=driver_records(isCurrent);
    SELF.Driver.State:=MAP(
      EXISTS(driverAddrMatch) => driverAddrMatch[1].st, // CURRENT DRIVER STATE WITH ADDR MATCH
      EXISTS(driverCurrent) => driverCurrent[1].st, // CURRENT DRIVER STATE
      ''); // NO DRIVER RECORDS OR EXPIRED RECORDS

    // ALWAYS OUTPUT MOST RECENT VOTER INFO
    voter_records:=NORMALIZE(L.property_records,LEFT.voter_records,TRANSFORM(HomesteadExemptionV2_Services.Layouts.voterRec,SELF:=RIGHT));
    voterLastVote:=SORT(voter_records,-LastDateVote);
    SELF.Voter.State:=voterLastVote[1].source_state; // LAST VOTER STATE
    SELF.Voter.Year:=voterLastVote[1].LastDateVote; // LAST VOTER YEAR

    // MAX PROPERTY RECORDS
    Properties:=CHOOSEN(PROJECT(SORT(L.property_records,property_rank,-sortby_date),propertyRecords(LEFT)),in_mod.MaxProperties);
    SELF.Properties:=Properties;

    // RISK CODES
    TODAY:=iesp.ECL2ESP.toDatestring8((STRING)Std.Date.Today());
    dsEmpty:=DATASET([],iesp.homestead_exemption_search.t_HomesteadExemptionRiskCodes);

    inputAddr:=ROW({L.prim_range,L.prim_name,L.sec_range,L.p_city_name,L.st,L.z5},HomesteadExemptionV2_Services.Layouts.addrMin);
    bestAddr:=ROW({bestRec.prim_range,bestRec.prim_name,bestRec.sec_range,bestRec.p_city_name,bestRec.st,bestRec.z5},HomesteadExemptionV2_Services.Layouts.addrMin);
    inputMatchesBest:=HomesteadExemptionV2_Services.Functions.compare2Addresses(inputAddr,bestAddr,includeSecondaryRange:=FALSE);
    // IF BEST ADDRESS IS PO BOX OR INPUT ADDDRESS MATCHES BEST ADDRESS THEN EMPTY DATASET ELSE RISK CODE 20
    scoreRec20:=IF(address.isPOBox(bestRec.prim_name) OR inputMatchesBest,dsEmpty,
      DATASET([{CNST.BEST_ADDR,CNST.BEST_ADDR_MSG,CNST.WARN,TODAY}],iesp.homestead_exemption_search.t_HomesteadExemptionRiskCodes));

    drvrRec:=driverCurrent[1];
    drvrAddr:=ROW({drvrRec.prim_range,drvrRec.prim_name,drvrRec.sec_range,drvrRec.p_city_name,drvrRec.st,drvrRec.z5},HomesteadExemptionV2_Services.Layouts.addrMin);
    inputMatchesDrvr:=HomesteadExemptionV2_Services.Functions.compare2Addresses(inputAddr,drvrAddr,includeSecondaryRange:=FALSE);
    // IF NO CURRENT DRIVER RECORD OR INPUT ADDDRESS MATCHES DRIVER ADDRESS THEN KEEP ELSE ADD RISK CODE 30
    scoreRec30:=IF(NOT EXISTS(driverCurrent) OR inputMatchesDrvr,scoreRec20,scoreRec20+
      DATASET([{CNST.DRVR_ADDR,CNST.DRVR_ADDR_MSG,CNST.WARN,TODAY}],iesp.homestead_exemption_search.t_HomesteadExemptionRiskCodes));

    // IF NO BEST RECORD AGE OR BEST RECORD AGE MEETS OR EXCEEDS THRESHOLD THEN KEEP ELSE ADD RISK CODE 40
    scoreRec40:=IF(BestRecAge=0 OR BestRecAge>=CNST.AGE_THRESHOLD,scoreRec30,scoreRec30+
      DATASET([{CNST.NOT_AGE_65,CNST.NOT_AGE_65_MSG,CNST.WARN,TODAY}],iesp.homestead_exemption_search.t_HomesteadExemptionRiskCodes));

    previousYear:=((INTEGER)L.tax_year)-1;
    previousYears:=HomesteadExemptionV2_Services.Functions.previousYears((STRING)previousYear,CNST.EXEMPTION_YEARS);
    otherProperties:=Properties(PropertyRank>1,Property.Address.StreetAddress1!='',Property.Address.StateCityZip!='');
    exemptionClaimed:=otherProperties(Assessment.ExemptionClaimed='Y',RecentExemptionYear IN SET(previousYears,year));
    // IF NO OTHER FULL ADDRESS PROPERTIES CLAIM EXEMPTION WITHIN TWO YEARS THEN KEEP ELSE ADD RISK CODE 50
    scoreRec50:=IF(NOT EXISTS(exemptionClaimed),scoreRec40,scoreRec40+
      DATASET([{CNST.HAS_EXMPTN,CNST.HAS_EXMPTN_MSG,CNST.FAILED,TODAY}],iesp.homestead_exemption_search.t_HomesteadExemptionRiskCodes));

    // IF NO DECEASED RECORDS EXISTS THEN KEEP ELSE ADD RISK CODE 60
    scoreRec60:=IF(NOT EXISTS(dcsdRecs), scoreRec50,scoreRec50+
      DATASET([{CNST.IS_DECEASED,CNST.IS_DECEASED_MSG,CNST.FAILED,TODAY}],iesp.homestead_exemption_search.t_HomesteadExemptionRiskCodes));

    // IF EXCEPTION THEN EMPTY DATASET ELSEIF ANY RISK CODES 20-60 EXISTS THEN KEEP ELSE REPORT NO RISK INDICATORS CODE 10
    RiskCodeRecs:=MAP(hasException => dsEmpty,
      EXISTS(scoreRec60) => scoreRec60,
      DATASET([{CNST.NO_RISK,CNST.NO_RISK_MSG,CNST.PASS,TODAY}],iesp.homestead_exemption_search.t_HomesteadExemptionRiskCodes));

    SELF.RiskCodes:=CHOOSEN(RiskCodeRecs,iesp.constants.hmstdExmptn.MAX_RISKCODES);
    SELF:=[];
  END;

  RETURN PROJECT(ds_work_recs,searchRecords(LEFT));
END;
