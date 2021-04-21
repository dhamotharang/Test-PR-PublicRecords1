IMPORT $, Advo, Autokey_batch, AutokeyB2, Codes, doxie, Doxie_Raw, iesp,
      LN_PropertyV2, LN_PropertyV2_Services, PropertyCharacteristics,
      Risk_Indicators, SNA, Suppress, ut, STD;

lPropHistCollusion := Location_Services.Layouts;

// to enforce alpha-numeric in, say, secondary ranges
STRING alpha_num := '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';

// Autokey constants
akName    := LN_PropertyV2.Constants.ak_keyname;
akDataset := LN_PropertyV2.Constants.ak_dataset;
akTypeStr := LN_PropertyV2.Constants.ak_typeStr;
akSkipSet := LN_PropertyV2.Constants.ak_skipSet;

EXPORT Functions :=
MODULE

  // Appends deduped meaningful (non-blank) secondary ranges to the input address;
  // sec_ranges are processed to remove punctuation characters.
  // Note: mostly for verification purposes! The value of sec range in the output can be modified!

  EXPORT GetSecRanges (DATASET(Autokey_batch.Layouts.rec_inBatchMaster) dReqCleanAddr) :=
  FUNCTION
    dReqWithNoUnitNum := dReqCleanAddr(sec_range = '');
    Autokey_batch.Layouts.rec_inBatchMaster tUnitNumCheck(Autokey_batch.Layouts.rec_inBatchMaster le,RECORDOF(LN_PropertyV2.key_addr_fid()) ri) :=
    TRANSFORM
      SELF.z5          := ri.zip;
      SELF.addr_suffix := ri.suffix;
      Self.sec_range   := Stringlib.StringFilter (ri.sec_range, alpha_num);
      SELF             := ri;
    END;

    dUnitNumbers := JOIN( dReqWithNoUnitNum,
                          LN_PropertyV2.key_addr_fid(),
                              KEYED(LEFT.prim_name   = RIGHT.prim_name)
                          and KEYED(LEFT.prim_range  = RIGHT.prim_range)
                          and KEYED(LEFT.z5          = RIGHT.zip)
                          and KEYED(LEFT.predir      = RIGHT.predir)
                          and KEYED(LEFT.postdir     = RIGHT.postdir)
                          and KEYED(LEFT.addr_suffix = RIGHT.suffix)
                          and (RIGHT.sec_range != ''),
                          tUnitNumCheck(LEFT,RIGHT),
                          // actual counts can be as high as hundreds of thousands: appartments, condos, business, etc.,
                          // but for the purpose of input verification this is irrelevant
                          LIMIT(2000,SKIP));

    dUnitNumbersDedup := DEDUP(SORT(dUnitNumbers,acctno,prim_range,prim_name,z5,predir,postdir,addr_suffix,sec_range),
                                                acctno,prim_range,prim_name,z5,predir,postdir,addr_suffix,sec_range);

    RETURN dUnitNumbersDedup;
  END;


  // Function to get the fares id based on address or apn
  EXPORT GetFaresId(DATASET(Autokey_batch.Layouts.rec_inBatchMaster) dIn,
                    Location_Services.iParam.PropHistHRI             inMod) :=
  FUNCTION
    vAPNExists := dIn[1].apn != ''; //input dataset always contains one record only

    dInFormatAPN := PROJECT(dIn,
                            TRANSFORM(Autokey_batch.Layouts.rec_inBatchMaster,
                                      SELF.apn := LN_PropertyV2.fn_strip_pnum(LEFT.apn),
                                      SELF     := LEFT));

    keyAddrFID       := LN_PropertyV2.key_addr_fid();
    keyAssessmentAPN := LN_PropertyV2.key_assessor_parcelnum;
    keyDeedAPN       := LN_PropertyV2.key_deed_parcelnum;

    dInAPN   := dInFormatAPN(apn != '');
    dInNoAPN := dInFormatAPN(apn = '');

    // Search by address only if apn is not input
    dAkIDs := AutokeyB2.get_IDs(akName,akTypeStr,akSkipSet);

    // JOIN to payload key to get fares ids
    AutokeyB2.mac_get_payload(dAkIDs,akName,akDataset,dAkResults,,,akTypeStr);

    // Calculate penalty
    lPropHistCollusion.AkResultsWithPenalty tCalculatePenalty(dAkResults pInput) :=
    TRANSFORM
      addr := IF( pInput.person_addr.prim_name != '' or pInput.person_addr.st != '',
                  pInput.person_addr,
                  pInput.company_addr);

      SELF.penalt := Doxie.FN_Tra_Penalty_Addr(addr.predir,addr.prim_range,addr.prim_name,addr.addr_suffix,
                                                addr.postdir,addr.sec_range,addr.v_city_name,addr.st,addr.zip5);

      SELF        := pInput;
    END;

    dAkAddrPenalty := PROJECT(dAkResults,tCalculatePenalty(LEFT));

    // Keep records with penalty threshold of 0 (CONFIRM with Vlad)
    dAkAddrPenaltyFilter := dAkAddrPenalty(penalt = 0);

    // Apply FaresID based restrictions
    dAkFaresId := DEDUP(PROJECT(dAkAddrPenalty,TRANSFORM(lPropHistCollusion.FaresId,SELF := LEFT)),ln_fares_id,ALL);

    dAkFaresIdSrcRestrict := dAkFaresId(ln_fares_id[1] NOT IN LN_PropertyV2_Services.input.srcRestrict);

    // Get fares id by joining to the address key
    lPropHistCollusion.FaresId tGetAddrFaresId(dInNoAPN le,keyAddrFID ri) :=
    TRANSFORM
      SELF := ri;
      SELF := le;
    END;

    dFaresIdByAddrKey := JOIN(dInNoAPN,
                              keyAddrFID,
                              LEFT.prim_name != ''
                              and KEYED(LEFT.prim_name = RIGHT.prim_name)
                              and KEYED(LEFT.prim_range = RIGHT.prim_range)
                              and KEYED(LEFT.z5 = RIGHT.zip)
                              and KEYED(LEFT.predir = RIGHT.predir)
                              and KEYED(LEFT.postdir = RIGHT.postdir)
                              and KEYED(LEFT.addr_suffix = RIGHT.suffix)
                              and KEYED(LEFT.sec_range = RIGHT.sec_range)
                              and KEYED(RIGHT.source_code_2 = 'P')
                              and RIGHT.ln_fares_id[1] NOT IN LN_PropertyV2_Services.input.srcRestrict,
                              tGetAddrFaresId(LEFT,RIGHT),
                              LIMIT(Location_Services.Consts.MaxProperties,SKIP));

    #IF(Location_Services.Consts.SearchByAutoKeys)
      dAddrFaresId := dAkFaresIdSrcRestrict; //need to pick a way to restrict the search to only property addresses
    #ELSE
      dAddrFaresId := dFaresIdByAddrKey;
    #END

    // Get fares id by APN
    lPropHistCollusion.FaresId tGetAssesFaresId(dInFormatAPN le,keyAssessmentAPN ri) :=
    TRANSFORM
      SELF := ri;
    END;

    dAssesAPN := JOIN(dInAPN,
                      keyAssessmentAPN,
                      KEYED(LEFT.apn = RIGHT.fares_unformatted_apn) and
                      RIGHT.ln_fares_id[1] NOT IN LN_PropertyV2_Services.input.srcRestrict,
                      tGetAssesFaresId(LEFT,RIGHT),LIMIT(Location_Services.Consts.MaxProperties,SKIP));

    lPropHistCollusion.FaresId tGetDeedsFaresId(dInFormatAPN le,keyDeedAPN ri) :=
    TRANSFORM
      SELF := ri;
    END;

    dDeedsAPN := JOIN(dInAPN,
                      keyDeedAPN,
                      KEYED(LEFT.apn = RIGHT.fares_unformatted_apn) and
                      RIGHT.ln_fares_id[1] NOT IN LN_PropertyV2_Services.input.srcRestrict,
                      tGetDeedsFaresId(LEFT,RIGHT),LIMIT(Location_Services.Consts.MaxProperties,SKIP));

    dAPNFaresId := dAssesAPN + dDeedsAPN;

    dFaresId := DEDUP(IF(vAPNExists,dAPNFaresId,dAddrFaresId),ln_fares_id,ALL);

    Suppress.MAC_Suppress(dFaresId,dFaresIdSuppress,inMod.application_type,,,Suppress.Constants.DocTypes.FaresID,ln_fares_id);

    #IF(Location_Services.Consts.Debug.FaresId)
      OUTPUT(dInFormatAPN,NAMED('dInFormatAPN'));
      #IF(Location_Services.Consts.SearchByAutoKeys)
        OUTPUT(dAkIDs,NAMED('dAkIDs'));
        OUTPUT(dAkResults,NAMED('dAkResults'));
        OUTPUT(dAkAddrPenalty,NAMED('dAkAddrPenalty'));
        OUTPUT(dAkFaresId,NAMED('dAkFaresId'));
        OUTPUT(dAkFaresIdSrcRestrict,NAMED('dAkFaresIdSrcRestrict'));
      #ELSE
        OUTPUT(dFaresIdByAddrKey,NAMED('dFaresIdByAddrKey'));
      #END
      OUTPUT(dAssesAPN,NAMED('dAssesAPN'));
      OUTPUT(dDeedsAPN,NAMED('dDeedsAPN'));
      OUTPUT(dFaresId,NAMED('dFaresId'));
    #END

    RETURN dFaresIdSuppress;
  END;

  // HRIs
  SHARED CreateHRIs(UNSIGNED2 pHRICode) :=
  FUNCTION
    vHRIDesc := Codes.VARIOUS_HRI_FILES.HRI_CODE((STRING)pHRICode);

    // TO DO - Using DATASET instead of ROW isn't returning any records, needs further investigation
    RETURN IF(vHRIDesc != '',ROW({(STRING)pHRICode,vHRIDesc},Risk_indicators.Layout_Desc));
  END;

  // Collusion HRIs
  SHARED CreateCollusionHRIs(STRING pAttr,BOOLEAN pIsBuyer,INTEGER pCode) :=
  FUNCTION
    dCollusionRiskAttr := Location_Services.consts.CollusionAttributes;

    RETURN PROJECT(dCollusionRiskAttr(Attribute = ut.CleanSpacesAndUpper(pAttr) and isBuyer = pIsBuyer and Code = pCode),
                    TRANSFORM(Risk_Indicators.Layout_Desc,SELF.hri := LEFT.RiskCode,SELF := LEFT));
  END;

  // Address HRI
  EXPORT GetAddressHRI(DATASET(lPropHistCollusion.PropCleanNameAddr) dIn) :=
  FUNCTION
    // Standard address HRI
    maxHRIPer_Value := ut.limits.HRI_MAX;
    Doxie.mac_AddHRIAddress(dIn,dAddressHRI);

    // Valassis, aka ADVO
    adv := Location_Services.consts.AdvoRiskCodes;

    // ADVO HRI codes
    UNSIGNED2 AdvoCodeByAddressType(STRING1 cd) := CASE(cd,
                                                        'A' => adv.ADVO_RESIDENTIAL,
                                                        'B' => adv.ADVO_BUSINESS,
                                                        'C' => adv.ADVO_RESIDENTIAL_PRIM,
                                                        'D' => adv.ADVO_BUSINESS_PRIM,
                                                        0);

    UNSIGNED2 AdvoCodeByRecordType(STRING1 cd) := CASE(cd,
                                                        'F' => adv.ADVO_FIRM,
                                                        'H' => adv.ADVO_HIGHRISE,
                                                        'G' => adv.ADVO_GENERAL,
                                                        // MAY BE USED FOR LATER USE
                                                        // 'P' => adv.ADVO_POBOX,
                                                        // 'R' => adv.ADVO_RURAL_ROUTE,
                                                        // 'S' => adv.ADVO_STREET,
                                                        0);

    // this maps delivery type and address type to ADVO HRI codes
    // compare to Advo.Lookup_Descriptions.Delivery_Type_Description_lookup, which uses one field for the same
    UNSIGNED2 GetAdvoCode(STRING1 cd) := CASE(cd,
                                              'F' => adv.ADVO_CONTRACT,
                                              'H' => adv.ADVO_NPU,
                                              'Q' => adv.ADVO_GENERAL,
                                              'S' => adv.ADVO_CALLER,
                                              'T' => adv.ADVO_REMITTANCE,
                                              0);

     // Attach ADVO indicators
    lPropHistCollusion.PropCleanNameAddr tAppendADVOIndicators(lPropHistCollusion.PropCleanNameAddr le,RECORDOF(Advo.Key_Addr1) ri) :=
    TRANSFORM
      UNSIGNED2 vVacancyRiskCode := IF(le.prim_name = 'PO BOX',adv.ADVO_VACANT_PO,adv.ADVO_VACANT);

      advoRiskInd := IF(ri.address_vacancy_indicator   = 'Y',CreateHRIs(vVacancyRiskCode)) +
                     IF(ri.seasonal_delivery_indicator = 'Y',CreateHRIs(adv.ADVO_SEASONAL)) +
                     IF(ri.college_indicator           = 'Y',CreateHRIs(adv.ADVO_COLLEGE)) +
                     IF(ri.residential_or_business_ind != '',CreateHRIs(AdvoCodeByAddressType(ri.residential_or_business_ind))) +
                     IF(ri.record_type_code            != '',CreateHRIs(AdvoCodeByRecordType(ri.record_type_code))) +
                     IF(ri.mixed_address_usage         != '',CreateHRIs(GetAdvoCode(ri.mixed_address_usage)));

      SELF.hri_address := CHOOSEN(le.hri_address(desc != '') + IF(ri.zip != '' and EXISTS(advoRiskInd),advoRiskInd(desc != '')),
                                  iesp.Constants.PropertyHistoryPlusReport.MaxCountHRI);
      SELF             := le;
    END;

    // Must be exact match on all parts -- including sec range being blank
    dAddrHRIWithAdvo := JOIN (dAddressHRI,
                              Advo.Key_Addr1,
                              KEYED(LEFT.zip = RIGHT.zip) and
                              KEYED(LEFT.prim_range = RIGHT.prim_range) and
                              KEYED(LEFT.prim_name = RIGHT.prim_name) and
                              KEYED(LEFT.suffix = RIGHT.addr_suffix) and
                              KEYED(LEFT.predir = RIGHT.predir) and
                              KEYED(LEFT.postdir = RIGHT.postdir) and
                              KEYED(LEFT.sec_range = RIGHT.sec_range),
                              tAppendADVOIndicators(LEFT,RIGHT),
                              LEFT OUTER,
                              LIMIT(0),KEEP(1));

    #IF(Location_Services.consts.Debug.AddressHRI)
      OUTPUT(dAddressHRI,NAMED('dAddressHRI'));
    #END

    RETURN dAddrHRIWithAdvo;
  END;

  // Function to get latest assessment information
  EXPORT GetLatestAssessment(DATASET(lPropHistCollusion.FaresId) dIn) :=
  FUNCTION
    keyAssessFID      := LN_Propertyv2.key_assessor_fid();
    keyFaresAssessFID := LN_Propertyv2.key_addl_fares_tax_fid;

    // LN + fares combined fields
    dLNAssess := JOIN(dIn,
                      LN_Propertyv2.key_assessor_fid(),
                      KEYED(LEFT.ln_fares_id = RIGHT.ln_fares_id), //1:1 mapping
                      TRANSFORM(RIGHT),
                      LIMIT(0),KEEP(1));

    lPropHistCollusion.Assessments tGetAssessments(RECORDOF(keyAssessFID) le,RECORDOF(keyFaresAssessFID) ri) :=
    TRANSFORM
      STRING vNoStories := REGEXREPLACE('^[O]+$',
                                        REGEXREPLACE( '[,]|[.]+',
                                                      REGEXREPLACE( 'AA|[A][+][A]',
                                                                    REGEXREPLACE( 'BB|[B][+][B]',
                                                                                  REGEXREPLACE( '[A][+][B]|[B][+][A]|BA',
                                                                                                stringlib.stringfilterout(le.no_of_stories,' '),
                                                                                                'AB',
                                                                                                nocase),
                                                                                  'B',
                                                                                  nocase),
                                                                    'A',
                                                                    nocase),
                                                      '.',
                                                      nocase),
                                        '',
                                        nocase);

      SELF.vendor_source_flag           := CASE(le.vendor_source_flag,
                                                'D' => Location_Services.consts.VendorSource.Dayton,
                                                'F' => Location_Services.consts.VendorSource.Fares,
                                                'O' => Location_Services.consts.VendorSource.Okcty,
                                                'S' => Location_Services.consts.VendorSource.FaresSupplemental,
                                                '');
      SELF.living_square_footage        := IF(REGEXREPLACE('^[0]*$',ri.fares_living_square_feet,'') != '',
                                              stringlib.stringfilterout(ri.fares_living_square_feet,','),
                                              MAP(le.vendor_source_flag IN ['D','O']  and ut.CleanSpacesAndUpper(le.building_area_indicator) = 'E' and REGEXREPLACE('^[0]*$',le.building_area,'') != '' => stringlib.stringfilterout(le.building_area,','),
                                                  ut.CleanSpacesAndUpper(le.building_area_indicator) = 'L'         and REGEXREPLACE('^[0]*$',le.building_area,'')  != ''                                => stringlib.stringfilterout(le.building_area,','),
                                                  ut.CleanSpacesAndUpper(le.building_area1_indicator) IN ['E','L'] and REGEXREPLACE('^[0]*$',le.building_area1,'') != ''                                => stringlib.stringfilterout(le.building_area1,','),
                                                  ut.CleanSpacesAndUpper(le.building_area2_indicator) IN ['E','L'] and REGEXREPLACE('^[0]*$',le.building_area2,'') != ''                                => stringlib.stringfilterout(le.building_area2,','),
                                                  ut.CleanSpacesAndUpper(le.building_area3_indicator) IN ['E','L'] and REGEXREPLACE('^[0]*$',le.building_area3,'') != ''                                => stringlib.stringfilterout(le.building_area3,','),
                                                  ut.CleanSpacesAndUpper(le.building_area4_indicator) IN ['E','L'] and REGEXREPLACE('^[0]*$',le.building_area4,'') != ''                                => stringlib.stringfilterout(le.building_area4,','),
                                                  ut.CleanSpacesAndUpper(le.building_area5_indicator) IN ['E','L'] and REGEXREPLACE('^[0]*$',le.building_area5,'') != ''                                => stringlib.stringfilterout(le.building_area5,','),
                                                  ut.CleanSpacesAndUpper(le.building_area6_indicator) IN ['E','L'] and REGEXREPLACE('^[0]*$',le.building_area6,'') != ''                                => stringlib.stringfilterout(le.building_area6,','),
                                                  ut.CleanSpacesAndUpper(le.building_area7_indicator) IN ['E','L'] and REGEXREPLACE('^[0]*$',le.building_area7,'') != ''                                => stringlib.stringfilterout(le.building_area7,','),
                                                  ''));
      SELF.pool_indicator               := IF(ri.fares_pool_indicator != '',
                                              ri.fares_pool_indicator,
                                              IF(le.pool_code != '' and le.pool_code != 'C' and (UNSIGNED)le.pool_code != 0,'Y','N'));
      SELF.lot_size                     := le.land_square_footage;
      SELF.assessed_land_value          := ut.rmv_ld_zeros(le.assessed_land_value);
      SELF.assessed_improvement_value   := ut.rmv_ld_zeros(le.assessed_improvement_value);
      SELF.fares_calculated_total_value := ut.rmv_ld_zeros(ri.fares_calculated_total_value);
      SELF.assessed_total_value         := ut.rmv_ld_zeros(le.assessed_total_value);
      SELF.market_land_value            := ut.rmv_ld_zeros(le.market_land_value);
      SELF.market_improvement_value     := ut.rmv_ld_zeros(le.market_improvement_value);
      SELF.market_total_value           := ut.rmv_ld_zeros(le.market_total_value);
      SELF.tax_year                     := IF((INTEGER)le.tax_year = 0,'0000',le.tax_year);
      SELF.tax_amount                   := if (trim(le.tax_amount)='','',(string)((real)le.tax_amount));
      SELF.no_of_stories                := IF(PropertyCharacteristics.Functions.fn_remove_zeroes(le.no_of_stories) != '',
                                              IF( le.vendor_source_flag IN ['F','S'],
                                                  PropertyCharacteristics.Functions.fn_remove_zeroes(le.no_of_stories),
                                                  IF( REGEXFIND('(S/L|B/L|[1-9]/L|S/E|S/F|^[0-9]+[.]?[0-9]*[+]?[AB]?[AB]?$|^[1-9]*[1-9][/][1-9][+]?[AB]?[AB]?$)',vNoStories,nocase),
                                                      MAP(vNoStories = 'S/L'                                                 => '1',
                                                          vNoStories = 'B/L'                                                 => '2',
                                                          REGEXFIND('[1-9]/L',vNoStories,nocase)                             => REGEXFIND('[1-9]',vNoStories,0,nocase),
                                                          REGEXFIND('^[0-9]+[.]?[0-9]*[+]?[AB]?[AB]?$',vNoStories,nocase)    => REGEXFIND('^[0-9]+[.]?[0-9]*',vNoStories,0,nocase),
                                                          REGEXFIND('^[1-9]*[1-9][/][1-9][+]?[AB]?[AB]?$',vNoStories,nocase) => REGEXREPLACE('[1-9][/][1-9]',REGEXFIND('^[1-9]*[1-9][/][1-9]',vNoStories,0,nocase),' $0'),
                                                          ''),
                                                      '')),
                                              '');
      SELF                              := le;
      SELF                              := ri;
      SELF                              := []; //Description fields for the codes
    END;

    // Addl fares fields
    dAssessments := JOIN( dLNAssess,
                          LN_Propertyv2.key_addl_fares_tax_fid,
                          KEYED(LEFT.ln_fares_id = RIGHT.ln_fares_id), //1:1 mapping
                          tGetAssessments(LEFT,RIGHT),
                          LEFT OUTER,
                          LIMIT(0),KEEP(1));

    dAssessmentsSort := SORT(dAssessments,-tax_year,vendor_source_flag NOT IN Location_Services.consts.VendorSource.setOkcty); //If we have records from both Okcty and Fares, pick Okcty

    latestTaxFaresId := dAssessmentsSort[1].ln_fares_id;

    dRecentAssessment := dAssessments(ln_fares_id = latestTaxFaresId);

    // Code translations
    Codes.Mac_GetPropertyCode(dRecentAssessment,dLandUseDesc,Codes.Key_Codes_V3,'FARES_2580','LAND_USE',standardized_land_use_code,land_use_desc);
    Codes.Mac_GetPropertyCode(dLandUseDesc,dStyleDesc,Codes.Key_Codes_V3,'FARES_2580','STYLE',style_code,style_desc);
    Codes.Mac_GetPropertyCode(dStyleDesc,dCondDesc,Codes.Key_Codes_V3,'FARES_2580','CONDITION',fares_condition,condition_desc);
    Codes.Mac_GetPropertyCode(dCondDesc,dACDesc,Codes.Key_Codes_V3,'FARES_2580','AIR_CONDITIONING',air_conditioning_code,air_conditioning_desc);
    Codes.Mac_GetPropertyCode(dACDesc,dHeatDesc,Codes.Key_Codes_V3,'FARES_2580','HEATING',heating_code,heating_desc);
    Codes.Mac_GetPropertyCode(dHeatDesc,dFuelDesc,Codes.Key_Codes_V3,'FARES_2580','FUEL',heating_fuel_type_code,fuel_type_desc);
    Codes.Mac_GetPropertyCode(dFuelDesc,dSewerDesc,Codes.Key_Codes_V3,'FARES_2580','SEWER',sewer_code,sewer_desc);
    Codes.Mac_GetPropertyCode(dSewerDesc,dWaterDesc,Codes.Key_Codes_V3,'FARES_2580','WATER',water_code,water_desc);
    Codes.Mac_GetPropertyCode(dWaterDesc,dElectricEnergyDesc,Codes.Key_Codes_V3,'FARES_2580','ELECTRIC_ENERGY',fares_electric_energy,electric_energy_desc);
    Codes.Mac_GetPropertyCode(dElectricEnergyDesc,dFrameDesc,Codes.Key_Codes_V3,'FARES_2580','FRAME',fares_frame,frame_desc);
    Codes.Mac_GetPropertyCode(dFrameDesc,dRoofCoverDesc,Codes.Key_Codes_V3,'FARES_2580','ROOF_COVER',roof_cover_code,roof_cover_desc);
    Codes.Mac_GetPropertyCode(dRoofCoverDesc,dRoofDesc,Codes.Key_Codes_V3,'FARES_2580','ROOF_TYPE',roof_type_code,roof_type_desc);

    #IF(Location_Services.consts.Debug.Assessments)
      OUTPUT(dIn,NAMED('dIn_Assessment'));
      OUTPUT(dLNAssess,NAMED('dLNAssess'));
      OUTPUT(dAssessments,NAMED('dAssessments'));
      OUTPUT(dRecentAssessment,NAMED('dRecentAssessment'));
      #IF(Location_Services.consts.Debug.CodesV3)
        OUTPUT(dLandUseDesc,NAMED('dLandUseDesc'));
        OUTPUT(dStyleDesc,NAMED('dStyleDesc'));
        OUTPUT(dCondDesc,NAMED('dCondDesc'));
        OUTPUT(dACDesc,NAMED('dACDesc'));
        OUTPUT(dHeatDesc,NAMED('dHeatDesc'));
        OUTPUT(dFuelDesc,NAMED('dFuelDesc'));
        OUTPUT(dSewerDesc,NAMED('dSewerDesc'));
        OUTPUT(dWaterDesc,NAMED('dWaterDesc'));
        OUTPUT(dElectricEnergyDesc,NAMED('dElectricEnergyDesc'));
        OUTPUT(dFrameDesc,NAMED('dFrameDesc'));
        OUTPUT(dRoofCoverDesc,NAMED('dRoofCoverDesc'));
        OUTPUT(dRoofDesc,NAMED('dRoofDesc'));
      #END
    #END

    RETURN dRoofDesc;
  END;

  SHARED CountKeyFields(RECORDOF(ln_propertyv2.key_deed_fid()) rowDeed) :=
  FUNCTION
    RETURN IF(rowDeed.contract_date != '',1,0) +
            IF(rowDeed.sales_price != '',1,0) +
            IF(rowDeed.first_td_loan_amount != '' or rowDeed.second_td_loan_amount != '',1,0) +
            IF(rowDeed.lender_name != '',1,0) +
            IF(rowDeed.document_type_code != '',1,0) +
            IF(rowDeed.recording_date != '',1,0);
  END;

  // Get deeds information
  EXPORT GetDeeds(DATASET(lPropHistCollusion.FaresId)           dIn,
                  DATASET(lPropHistCollusion.PropCleanNameAddr) dPartyInfo,
                  Location_Services.iParam.PropHistHRI          inMod,
                  boolean includeAssignmentsAndReleases=false) :=
  FUNCTION
    keyDeedFID := LN_PropertyV2.key_deed_fid();

    lPropHistCollusion.Deeds tGetDeeds(dIn le,keyDeedFID ri) :=
    TRANSFORM
      SELF.vendor                := IF( ri.vendor_source_flag IN Location_Services.consts.VendorSource.setFares,
                                        LN_PropertyV2_Services.consts.VENDOR_FARES,
                                        LN_PropertyV2_Services.consts.VENDOR_FIDELITY[1]);
      SELF.vendor_source_flag    := CASE( ri.vendor_source_flag,
                                          'D' => Location_Services.consts.VendorSource.Dayton,
                                          'F' => Location_Services.consts.VendorSource.Fares,
                                          'O' => Location_Services.consts.VendorSource.Okcty,
                                          'S' => Location_Services.consts.VendorSource.FaresSupplemental,
                                          '');
      SELF.sales_price           := IF((UNSIGNED)ri.sales_price = 0,'',ut.rmv_ld_zeros(ri.sales_price));
      SELF.first_td_loan_amount  := IF((UNSIGNED)ri.first_td_loan_amount = 0,'',ut.rmv_ld_zeros(ri.first_td_loan_amount));
      SELF.second_td_loan_amount := IF((UNSIGNED)ri.second_td_loan_amount = 0,'',ut.rmv_ld_zeros(ri.second_td_loan_amount));
      SELF.title_company_name    := stringlib.stringfilter(ut.CleanSpacesAndUpper(ri.title_company_name),alpha_num + ' ');
      SELF.cnt_key_fields        := CountKeyFields(ri);
      SELF.book_page_num         := IF(ri.recorder_book_number != '' and ri.recorder_page_number != '',
                                        TRIM(ri.recorder_book_number,ALL) + ';' + TRIM(ri.recorder_page_number,ALL),
                                        '');
      SELF.first_td_due_date     := ri.first_td_due_date;
      SELF.record_type           := ri.record_type;
      SELF                       := ri;
      SELF                       := le;
      SELF                       := []; //fields not defined in the deeds layout
    END;

    dDeeds := JOIN( dIn,
                    keyDeedFID,
                    KEYED(LEFT.ln_fares_id = RIGHT.ln_fares_id) and //1:1 mapping
                    (LEFT.ln_fares_id[2] = Location_services.Consts.FaresCodes.Deed or
                          if(includeAssignmentsAndReleases, LEFT.ln_fares_id[2] = Location_services.Consts.FaresCodes.Mortgage
                               and LN_PropertyV2.fn_isAssignmentAndReleaseRecord(right.record_type,right.state,right.document_type_code), false) ), //get only deed records (changed this to return also 'M' records based on the flag)
                    tGetDeeds(LEFT,RIGHT),
                    LIMIT(0), KEEP(1) );

    // Append sequence number
    ut.MAC_Sequence_Records(dDeeds,seq,dDeedsSeqNum);

    // Join to the codesV3 file to get the descriptions
    Codes.Mac_GetPropertyCode(dDeedsSeqNum, dDeedDocumentTypeDesc,Codes.Key_Codes_V3,'FARES_1080','DOCUMENT_TYPE',document_type_code,document_type_desc);

    // Join to the party file to get the clean buyer and seller names
    lPropHistCollusion.Deeds tDenormNames(lPropHistCollusion.Deeds le,lPropHistCollusion.PropCleanNameAddr ri) :=
    TRANSFORM
      lPropHistCollusion.NameWithCollusionAttrs tBuyerSellerNames() :=
      TRANSFORM
        SELF.seq       := le.seq;
        SELF.full_name := ri.nameasis;
        SELF.ssn       := ri.app_ssn;
        SELF           := ri;
        SELF           := []; // hri_individual, isBuyer
      END;

      buyerName  := ROW(tBuyerSellerNames());
      sellerName := ROW(tBuyerSellerNames());

      SELF.buyers  := IF(ri.source_code[1] = 'O',le.buyers + buyerName,le.buyers);
      SELF.sellers := IF(ri.source_code[1] = 'S',le.sellers + sellerName,le.sellers);
      SELF         := le;
    END;

    dBuyerSellerNames := DENORMALIZE( dDeedDocumentTypeDesc,
                                      dPartyInfo,
                                      LEFT.ln_fares_id = RIGHT.ln_fares_id,
                                      tDenormNames(LEFT,RIGHT));

    // Rollup buyer and sellers since you can get the same person from a property or mailing record
    // Need both property and mailing records since the DIDs can exist in either record or both
    lPropHistCollusion.Deeds tRollupNames(lPropHistCollusion.Deeds pInput) :=
    TRANSFORM
      lPropHistCollusion.NameWithCollusionAttrs tRollupNamesKeepDid(lPropHistCollusion.NameWithCollusionAttrs le,lPropHistCollusion.NameWithCollusionAttrs ri) :=
      TRANSFORM
        SELF.did  := IF(le.did = 0,ri.did,le.did);
        SELF.bdid := IF(le.bdid = 0,ri.bdid,le.bdid);
        SELF      := le;
      END;

      SELF.buyers  := CHOOSEN(ROLLUP(SORT(pInput.buyers,fname,mname,lname,full_name),
                                      tRollupNamesKeepDid(LEFT,RIGHT),fname,mname,lname,full_name),
                              iesp.Constants.PropertyHistoryPlusReport.MaxCountIndividual);
      SELF.sellers := CHOOSEN(ROLLUP(SORT(pInput.sellers,fname,mname,lname,full_name),
                                      tRollupNamesKeepDid(LEFT,RIGHT),fname,mname,lname,full_name),
                              iesp.Constants.PropertyHistoryPlusReport.MaxCountIndividual);
      SELF         := pInput;
    END;

    dBuyerSellerNamesDedup := PROJECT(dBuyerSellerNames,tRollupNames(LEFT));

    // Join to the mortgage collusion file to get the collusion attributes pertaining to the property
    lPropHistCollusion.Deeds tGetCollusionAttrs(lPropHistCollusion.Deeds le,RECORDOF(SNA.key_prop_transaction_stats) ri) :=
    TRANSFORM
      BOOLEAN vNoHit := ri.ln_fares_id = '';

      SELF.ln_fares_id                 := le.ln_fares_id;
      SELF.sales_price                 := le.sales_price;
      SELF.title_company_name          := le.title_company_name;
      SELF.contract_date               := le.contract_date;
      SELF.recording_date              := le.recording_date;
      SELF.document_type_code          := le.document_type_code;
      SELF.in_network                  := ri.in_network_risk;
      SELF.high_profit_flip            := ri.high_profit and ri.flip;
      SELF.high_profit_flop            := ri.high_profit and ri.flop;
      SELF.in_network_flop             := ri.in_network_risk and ri.flop;
      SELF.in_network_high_profit_flop := ri.in_network_risk and ri.high_profit and ri.flop;
      SELF.property_status_risk_index  := MAP(vNoHit                                                                                              => -1,
                                              ri.mortgage_foreclosure                                                                             => 9,
                                              ri.mortgage_default                                                                                 => 8,
                                              ri.has_mortgage_foreclosure_preceeding_suspicious and ri.has_mortgage_default_preceeding_suspicious => 7,
                                              ri.has_mortgage_foreclosure_preceeding_suspicious                                                   => 6,
                                              ri.has_mortgage_default_preceeding_suspicious                                                       => 5,
                                              ri.has_mortgage_foreclosure and ri.has_mortgage_default                                             => 4,
                                              ri.has_mortgage_foreclosure                                                                         => 3,
                                              ri.has_mortgage_default                                                                             => 2,
                                              NOT(ri.has_mortgage_foreclosure or ri.has_mortgage_default)                                         => 1,
                                              0);
      SELF.property_history_risk_index := MAP(vNoHit                                   => -1,
                                              ri.in_network_high_profit_flip_count > 1 => 9,
                                              ri.flip_count + ri.flop_count > 5        => 8,
                                              ri.in_network_flip_business_count > 1    => 7,
                                              ri.high_profit_flip_count > 1            => 6,
                                              ri.in_network_flip_count  > 1            => 5,
                                              ri.in_network_high_profit_count > 1      => 4,
                                              ri.suspicious_deed_count > 1             => 3,
                                              ri.in_network_count > 1                  => 2,
                                              ri.ln_fares_id != ''                     => 1,
                                              0);
      SELF.hri_transactions            := CreateCollusionHRIs('PROP_STATUS_RISK_INDEX',FALSE,SELF.property_status_risk_index) +
                                          CreateCollusionHRIs('PROP_HIST_RISK_INDEX',FALSE,SELF.property_history_risk_index) +
                                          CreateCollusionHRIs('FLIP',FALSE,(INTEGER)ri.flip) +
                                          CreateCollusionHRIs('FLOP',FALSE,(INTEGER)ri.flop) +
                                          CreateCollusionHRIs('IN_NETWORK',FALSE,(INTEGER)ri.in_network_risk) +
                                          CreateCollusionHRIs('HIGH_PROFIT',FALSE,(INTEGER)ri.high_profit) +
                                          // self-flip/flop share same indicator
                                          CreateCollusionHRIs('HIGH_PROFIT_FLIP',FALSE,(INTEGER)(SELF.high_profit_flip or SELF.high_profit_flop)) +
                                          CreateCollusionHRIs('IN_NETWORK_FLIP',FALSE,(INTEGER)ri.in_network_flip) +
                                          CreateCollusionHRIs('IN_NETWORK_FLIP',FALSE,(INTEGER)SELF.in_network_flop) +
                                          CreateCollusionHRIs('IN_NETWORK_HIGH_PROFIT',FALSE,(INTEGER)ri.in_network_high_profit) +
                                          CreateCollusionHRIs('IN_NETWORK_HIGH_PROFIT_FLIP',FALSE,(INTEGER)ri.in_network_high_profit_flip) +
                                          CreateCollusionHRIs('IN_NETWORK_HIGH_PROFIT_FLIP',FALSE,(INTEGER)SELF.in_network_high_profit_flop);
      SELF                             := ri;
      SELF                             := le;
    END;

    dDeedsWithPropCollusionAttrs := JOIN( dBuyerSellerNamesDedup,
                                          SNA.key_prop_transaction_stats,
                                          KEYED(LEFT.ln_fares_id = RIGHT.ln_fares_id),
                                          tGetCollusionAttrs(LEFT,RIGHT),
                                          LEFT OUTER,
                                          LIMIT(0),KEEP(1));

    // Normalize buyer and sellers
    lPropHistCollusion.NameWithFaresId tNormBuyerSeller(lPropHistCollusion.Deeds le,
                                                        lPropHistCollusion.NameWithCollusionAttrs ri,
                                                        BOOLEAN isBuyer) :=
    TRANSFORM
      SELF.ln_fares_id := le.ln_fares_id;
      SELF.seq         := le.seq;
      SELF.isBuyer     := isBuyer;
      SELF             := ri;
    END;

    // Normalize buyers
    dBuyers := NORMALIZE(dDeedsWithPropCollusionAttrs,LEFT.buyers,tNormBuyerSeller(LEFT,RIGHT,TRUE));

    // Normalize sellers
    dSellers := NORMALIZE(dDeedsWithPropCollusionAttrs,LEFT.sellers,tNormBuyerSeller(LEFT,RIGHT,FALSE));

    // Apply suppression
    Suppress.MAC_Suppress(dBuyers,dBuyerDIDSuppress,inMod.application_type,Suppress.Constants.LinkTypes.DID,did);
    Suppress.MAC_Suppress(dBuyerDIDSuppress,dBuyerSuppress,inMod.application_type,Suppress.Constants.LinkTypes.SSN,ssn);

    Suppress.MAC_Suppress(dSellers,dSellerDIDSuppress,inMod.application_type,Suppress.Constants.LinkTypes.DID,did);
    Suppress.MAC_Suppress(dSellerDIDSuppress,dSellerSuppress,inMod.application_type,Suppress.Constants.LinkTypes.SSN,ssn);

    // Combine buyers and sellers
    dBuyerSellerCombined := dBuyerSuppress + dSellerSuppress;

    // Tie back the suppressed buyer and seller information to the main record
    lPropHistCollusion.Deeds tPopulateBuyerSeller(lPropHistCollusion.Deeds le,DATASET(lPropHistCollusion.NameWithFaresId) ri) :=
    TRANSFORM
      SELF.buyers  := PROJECT(ri(isBuyer),lPropHistCollusion.NameWithCollusionAttrs);
      SELF.sellers := PROJECT(ri(~isBuyer),lPropHistCollusion.NameWithCollusionAttrs);
      SELF         := le;
    END;

    dDeedsWithBSSuppress := DENORMALIZE(dDeedsWithPropCollusionAttrs,
                                        dBuyerSellerCombined,
                                        LEFT.seq = RIGHT.seq,
                                        GROUP,
                                        tPopulateBuyerSeller(LEFT,ROWS(RIGHT)));

    // Buyer and seller relationship
    dBuyerDIDs  := PROJECT(dBuyerSuppress,$.Layouts.RelDetailsIn);
    dSellerDIDs := PROJECT(dSellerSuppress,$.Layouts.RelDetailsIn);

    relDetailsMod := MODULE($.iParam.RelDetails)
      EXPORT BOOLEAN   IncludeRelatives  := TRUE;
      EXPORT UNSIGNED1 RelativeDepth     := 3;
      EXPORT UNSIGNED3 MaxRelatives      := Location_Services.consts.max_rels;
      EXPORT BOOLEAN   IncludeAssociates := TRUE;
    END;

    dDIDAssociations := IF(EXISTS(dSellerDIDs(did != 0)),
                            $.Get_DID_Associations(dBuyerDIDs, relDetailsMod, TRUE, dSellerDIDs));

    // Tie back the relationship to the transactions
    lPropHistCollusion.Deeds tDeedsWithBSRelationship(lPropHistCollusion.Deeds le,$.Layouts.RelDetailsOut ri) :=
    TRANSFORM
      rowBSRelation := ROW({ri.seq,ri.src_did,ri.person2,ri.title},lPropHistCollusion.BuyerSellerRelationship);

      SELF.buyer_seller_relationship := le.buyer_seller_relationship + rowBSRelation;
      SELF                           := le;
    END;

    dDeedsWithBSRelationship := DENORMALIZE(dDeedsWithBSSuppress,
                                            dDIDAssociations,
                                            LEFT.seq = RIGHT.seq,
                                            tDeedsWithBSRelationship(LEFT,RIGHT));

    // Cluster collusion attributes
    lPropHistCollusion.NameWithFaresId tClusterCollusionAttrs(lPropHistCollusion.NameWithFaresId le,RECORDOF(SNA.Key_prop_cluster_stats) ri) :=
    TRANSFORM
      HighRiskFlipNetwork        := MAP(ri.cluster_id = 0                                                                       => -1,
                                        ri.prop_people_count < 10000 and ri.prop_network_cohesivity < 1.8 and
                                        ri.cluster_flip_count > 5 and (ri.cluster_flip_count/ri.distinct_property_count > 0.10) => 1,
                                        0);

      // Indicates the seller is a member of a high person foreclosure network
      HighRiskForeclosureNetwork := MAP(ri.cluster_id = 0                                                                              => -1,
                                        ri.prop_people_count < 10000 and ri.prop_network_cohesivity < 1.8 and
                                        ri.cluster_flip_count > 5 and (ri.cluster_foreclosure_count/ri.distinct_property_count > 0.10) => 1,
                                        0);

      SELF.RiskIndex        := MAP( ri.cluster_id = 0                                                                                => -1,
                                    ri.cluster_foreclosure_default_count_0_degree > 1                                                => 9,
                                    HighRiskForeclosureNetwork = 1                                                                    => 8,
                                    HighRiskFlipNetwork  = 1                                                                         => 7,
                                    ri.cluster_foreclosure_default_count_0_degree > 0                                                => 6,
                                    ri.cluster_in_network_high_profit_0_degree > 1 and ri.cluster_in_network_flip_count_0_degree > 1 => 5,
                                    ri.cluster_in_network_flip_count_0_degree > 1                                                    => 4,
                                    ri.cluster_flip_0_degree > 1                                                                     => 3,
                                    ri.cluster_high_profit_count_0_degree > 1                                                        => 2,
                                    ri.cluster_id != 0                                                                               => 1,
                                    0);
      SELF.ClusterRiskIndex := MAP( ri.cluster_id = 0                                                 => -1,
                                    ri.cluster_foreclosure_default_count > 4                          => 9,
                                    ri.cluster_foreclosure_default_count > 1                          => 8,
                                    ri.cluster_in_network_flip_count + ri.cluster_in_network_flop > 4 => 7,
                                    ri.cluster_in_network_high_profit_flip_count > 1                  => 6,
                                    ri.cluster_in_network_high_profit > 1                             => 5,
                                    ri.cluster_flop_count > 1                                         => 4,
                                    ri.cluster_flip_count > 1                                         => 3,
                                    ri.cluster_flip_business_count > 1                                => 2,
                                    ri.cluster_id != 0                                                => 1,
                                    0);
      SELF.hri_individual   :=  CreateCollusionHRIs('RISK_INDEX',le.isBuyer,SELF.RiskIndex) +
                                CreateCollusionHRIs('CLUSTER_RISK_INDEX',le.isBuyer,SELF.ClusterRiskIndex);
      SELF                  := ri;
      SELF                  := le;
    END;

    dDeedsWithPersonCollusionAttrs := JOIN(dBuyerSellerCombined,
                                            SNA.Key_prop_cluster_stats,
                                            KEYED(LEFT.did = RIGHT.cluster_id),
                                            tClusterCollusionAttrs(LEFT,RIGHT),
                                            LEFT OUTER,
                                            ATMOST(Location_Services.consts.MaxClusterAttr),KEEP(1));

    // Tie the collusion attributes back to main
    dDeedsTransactions := DENORMALIZE(dDeedsWithBSRelationship,
                                      dDeedsWithPersonCollusionAttrs,
                                      LEFT.ln_fares_id = RIGHT.ln_fares_id,
                                      GROUP,
                                      tPopulateBuyerSeller(LEFT,ROWS(RIGHT)));

    // Dedup transaction records
    // Sort by recording date and document number
    dTransDocNumSort := SORT(dDeedsTransactions,recording_date,document_number);

    // Assign group id
    lPropHistCollusion.Deeds tAssignDocNumGrpId(lPropHistCollusion.Deeds le,lPropHistCollusion.Deeds ri) :=
    TRANSFORM
      BOOLEAN isSameGrp := (le.recording_date = ri.recording_date and le.recording_date != '') and
                            (le.document_number = ri.document_number and le.document_number != '');

      // SELF.group_id := IF(le.recording_date != ri.recording_date or le.document_number != ri.document_number,
                          // le.group_id + 1,
                          // le.group_id);
      SELF.group_id := IF(isSameGrp,le.group_id,le.group_id + 1);
      SELF          := ri;
    END;

    dTransDocNumGrpId := ITERATE(dTransDocNumSort,tAssignDocNumGrpId(LEFT,RIGHT));

    // Sort by recording date and book/page number
    dTransBookPageNumSort := SORT(dTransDocNumGrpId,recording_date,book_page_num);

    // Reassign group id based on the new group criteria
    lPropHistCollusion.Deeds tAssignBookPageNumGrpId(lPropHistCollusion.Deeds le,lPropHistCollusion.Deeds ri) :=
    TRANSFORM
      BOOLEAN isSameGrp := (le.recording_date = ri.recording_date and le.recording_date != '') and
                            (le.book_page_num = ri.book_page_num and le.book_page_num != '');

      // SELF.group_id := IF(le.recording_date != ri.recording_date or le.book_page_num != ri.book_page_num,ri.group_id,MIN(le.group_id,ri.group_id));
      SELF.group_id := IF(isSameGrp,MIN(le.group_id,ri.group_id),ri.group_id);
      SELF          := ri;
    END;

    dTransBookPageNumGrpId := ITERATE(dTransBookPageNumSort,tAssignBookPageNumGrpId(LEFT,RIGHT));

    // Last resort to identify the correct group. Sort by recording date, sale date, sales price and document type
    dTransOtherCriteriaSort := SORT(dTransBookPageNumGrpId,recording_date,contract_date,sales_price,document_type_desc);

    // Reassign group id based on the new group criteria
    lPropHistCollusion.Deeds tAssignGrpId(lPropHistCollusion.Deeds le,lPropHistCollusion.Deeds ri) :=
    TRANSFORM
      BOOLEAN isSameGrp := (le.recording_date = ri.recording_date and le.recording_date != '') and
                            (le.contract_date = ri.contract_date and le.contract_date != '') and
                            (le.sales_price = ri.sales_price and le.sales_price != '') and
                            (le.document_type_desc = ri.document_type_desc and le.document_type_desc != '');

      SELF.group_id := IF(isSameGrp,MIN(le.group_id,ri.group_id),ri.group_id);
      SELF          := ri;
    END;

    dTransGrpId := ITERATE(dTransOtherCriteriaSort,tAssignGrpId(LEFT,RIGHT));

    // Group on group_id, if count of key fields is the same, then sort records by vendor and longest lender name
    dDeedsTransactionsGrp  := GROUP(SORT(dTransGrpId,group_id,-cnt_key_fields,-vendor,-LENGTH(stringlib.stringcleanspaces(lender_name))),
                                    group_id);

    // Designating records which are duplicates or need to be suppressed
    lPropHistCollusion.Deeds tIterate(lPropHistCollusion.Deeds le,lPropHistCollusion.Deeds ri) :=
    TRANSFORM
      SELF.rec_type := MAP( ri.cnt_key_fields > le.cnt_key_fields                            => Location_Services.consts.RecordType.Display,
                            le.cnt_key_fields = ri.cnt_key_fields and le.vendor != ri.vendor => Location_Services.consts.RecordType.Duplicate,
                            le.cnt_key_fields = ri.cnt_key_fields and le.vendor = ri.vendor  => Location_Services.consts.RecordType.Suppress,
                            Location_Services.consts.RecordType.Duplicate);
      SELF          := ri;
    END;

    dDeedsTransactionsIterate := UNGROUP(ITERATE(dDeedsTransactionsGrp,tIterate(LEFT,RIGHT)));

    // Remove records that need to be suppressed (rec_type=-1 is suppressed)
    dTransactions := SORT(dDeedsTransactionsIterate(rec_type != Location_Services.consts.RecordType.Suppress),
                          -group_id,-rec_type,-IF(contract_date != '',contract_date,recording_date));

    // Debug
    #IF(Location_Services.consts.Debug.Deeds)
      OUTPUT(dIn,NAMED('dIn_Deed'));
      OUTPUT(dDeeds,NAMED('dDeeds'));
      OUTPUT(dDeedsSeqNum,NAMED('dDeedsSeqNum'));
      #IF(Location_Services.consts.Debug.CodesV3)
        OUTPUT(dDeedDocumentTypeDesc,NAMED('dDeedDocumentTypeDesc'));
      #END
      OUTPUT(dBuyerSellerNames,NAMED('dBuyerSellerNames'));
      OUTPUT(dBuyerSellerNamesDedup,NAMED('dBuyerSellerNamesDedup'));
      OUTPUT(dDeedsWithPropCollusionAttrs,NAMED('dDeedsWithPropCollusionAttrs'));
      OUTPUT(dBuyers,NAMED('dBuyers'));
      OUTPUT(dSellers,NAMED('dSellers'));
      OUTPUT(dBuyerSuppress,NAMED('dBuyerSuppress'));
      OUTPUT(dSellerSuppress,NAMED('dSellerSuppress'));
      OUTPUT(dDeedsWithBSSuppress,NAMED('dDeedsWithBSSuppress'));
      OUTPUT(dDIDAssociations,NAMED('dDIDAssociations'));
      OUTPUT(dDeedsWithBSRelationship,NAMED('dDeedsWithBSRelationship'));
      OUTPUT(dDeedsWithPersonCollusionAttrs,NAMED('dDeedsWithPersonCollusionAttrs'));
      OUTPUT(dDeedsTransactions,NAMED('dDeedsTransactions'));
      OUTPUT(dTransDocNumSort,NAMED('dTransDocNumSort'));
      OUTPUT(dTransDocNumGrpId,NAMED('dTransDocNumGrpId'));
      OUTPUT(dTransBookPageNumSort,NAMED('dTransBookPageNumSort'));
      OUTPUT(dTransBookPageNumGrpId,NAMED('dTransBookPageNumGrpId'));
      OUTPUT(dTransOtherCriteriaSort,NAMED('dTransOtherCriteriaSort'));
      OUTPUT(dTransGrpId,NAMED('dTransGrpId'));
      OUTPUT(dDeedsTransactionsIterate,NAMED('dDeedsTransactionsIterate'));
    #END

    RETURN dTransactions;
  END;

  // Current residents
  EXPORT GetCurrentResidents( DATASET(lPropHistCollusion.PropCleanNameAddr) dIn,
                              Location_Services.iParam.PropHistHRI          inMod) :=
  FUNCTION
    doxie.layout_addressSearch_plus tAddress(lPropHistCollusion.PropCleanNameAddr pInput) :=
    TRANSFORM
      SELF.seq   := 0;
      SELF.state := pInput.st;
      SELF       := pInput;
    END;

    dAddress := PROJECT(dIn,tAddress(LEFT));

    dAddrResidents := doxie_raw.residents_raw(dAddress, inMod.date_threshold, //dateVal
                                              inMod.dppa, inMod.glb,
                                              inMod.ssn_mask,
                                              inMod.ln_branded,
                                              inMod.probation_override);

    // Filter residents with address older than 12 months
    dAddrCurrentResidents := dAddrResidents(ut.DaysApart((string) STD.Date.Today(),(STRING8)dt_last_seen) <= 365);

    #IF(Location_Services.consts.Debug.CurrentResidents)
      OUTPUT(dAddress,NAMED('dAddress'));
      OUTPUT(dAddrResidents,NAMED('dAddrResidents'));
    #END

    RETURN dAddrCurrentResidents;
  END;

  EXPORT AvgSalesAmtByZip(DATASET(lPropHistCollusion.PropCleanNameAddr) dIn,
                          BOOLEAN calZip4SalesPrice = FALSE) :=
  FUNCTION
    keyZipAvgSalesPrice := LN_PropertyV2.key_deed_zip_avg_sales_price;

    dZipAvgSalesPrice  := JOIN(dIn,keyZipAvgSalesPrice,
                                KEYED(LEFT.zip = RIGHT.z5 and RIGHT.z4 = ''),
                                TRANSFORM(RIGHT),
                                LIMIT(Location_Services.consts.max_zip,SKIP));

    dZip4AvgSalesPrice := JOIN(dIn,keyZipAvgSalesPrice,
                                KEYED(LEFT.zip  = RIGHT.z5) and
                                KEYED(LEFT.zip4 = RIGHT.z4),
                                TRANSFORM(RIGHT),
                                LIMIT(Location_Services.consts.max_zip,SKIP));

    #IF(Location_Services.consts.Debug.HistoricalZipSalesPrice)
      OUTPUT(dZipAvgSalesPrice,NAMED('dZipAvgSalesPrice'));
      OUTPUT(dZip4AvgSalesPrice,NAMED('dZip4AvgSalesPrice'));
    #END

    RETURN IF(calZip4SalesPrice,dZip4AvgSalesPrice,dZipAvgSalesPrice);
  END;

END;
