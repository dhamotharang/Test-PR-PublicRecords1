IMPORT business_header, doxie, doxie_cbrs, iesp, MIDEX_Services;

EXPORT SmartLinx_Business_Sections ( STRING12 in_bdid, doxie.IDataAccess mod_access, BOOLEAN include_SourceDocs = FALSE, BOOLEAN includeBlackKnight = FALSE ) :=
  FUNCTION
   
    // NOTE: The constants, max values declared, and the calls to get the records for each section
    // in this code were taken from the doxie_cbrs.all_base_records_prs
    // attribute and modified to bring in the SmartLinx Business sections requested
    // for the Midex project. Per Jiafu, the layouts were transformed into the
    // layouts used in: iesp.enhancedbizreport so that the Midex project would be iesp compliant
 
    #CONSTANT( 'globalAutoHoist', FALSE);
    #CONSTANT( 'spotCSE', FALSE);
    #CONSTANT( 'GONG_SEARCHTYPE','BUSINESS');
    #CONSTANT( 'bdidsDerived', TRUE);
    #CONSTANT( 'usePropMarshall', TRUE);
    
    MaxAddressVariations := 100 : STORED( 'MaxAddressVariations' );
    MaxAssociatedPeople := 150 : STORED( 'MaxAssociatedPeople' );
    MaxBankruptciesV2 := 50 : STORED( 'MaxBankruptciesV2' );
    MaxBusinessAssociates := 50 : STORED( 'MaxBusinessAssociates' );
    MaxLiensJudgmentsUcc := 100 : STORED( 'MaxLiensJudgmentsUcc' );
    MaxNameVariations := 100 : STORED( 'MaxNameVariations' );
    MaxPhoneVariations := 100 : STORED( 'MaxPhoneVariations' );
    MaxProperties := 100 : STORED( 'MaxProperties' );
    
    Bdids := doxie_cbrs.getBizReportBDIDs(mod_access).bdids;
    
    //-----------------------------------------------------------------------------------------------------------
    //----- Address Variations ----------------------------------------------------------------------------------
    //-----------------------------------------------------------------------------------------------------------
    
    advr := doxie_cbrs.address_variations_base(bdids);
    
    ds_addrVariations :=
      PROJECT( GLOBAL(advr.records),
               TRANSFORM( iesp.rollupbizreport.t_AddressInfo,
                          SELF.Address := iesp.ECL2ESP.SetAddress ( LEFT.prim_name, LEFT.prim_range, LEFT.predir, '',
                                                                    LEFT.addr_suffix, '', LEFT.sec_range, LEFT.city,
                                                                    LEFT.state, LEFT.zip, '', LEFT.county_name);
                          
                          SELF.MsaNumber := LEFT.msa,
                          SELF.MsaDescription := LEFT.msadesc,
                          SELF.LocationId := '',
                          SELF.SourceDocId := '',
                       ));


    //-----------------------------------------------------------------------------------------------------------
    //----- Bankruptcy V2 ---------------------------------------------------------------------------------------
    //-----------------------------------------------------------------------------------------------------------
    
    bnkr_v2 := doxie_cbrs.bankruptcy_records_trimmed_v2(bdids, mod_access.SSN_Mask);
    
    ds_bankruptcyV2 := iesp.transform_bankruptcy_v2(bnkr_v2.records);

    //-----------------------------------------------------------------------------------------------------------
    //----- Best Information ------------------------------------------------------------------------------------
    //-----------------------------------------------------------------------------------------------------------
    
    name_table := DEDUP(TABLE(SORT(doxie_cbrs.fn_getBaseRecs(bdids,FALSE),company_name),{company_name,name_source_id}));
    addr_table := DEDUP(TABLE(SORT(doxie_cbrs.fn_getBaseRecs(bdids,FALSE),state,zip,prim_name,prim_range,sec_range),{state,zip,prim_name,prim_range,sec_range,addr_source_id}));
    phone_table := DEDUP(TABLE(SORT(doxie_cbrs.fn_getBaseRecs(bdids,FALSE),phone),{phone,phone_source_id}));

    temp_besr := CHOOSEN(doxie_cbrs.fn_best_information(bdids,FALSE),1);

    rec_besr := RECORD
      temp_besr;
      UNSIGNED name_source_id;
      UNSIGNED addr_source_id;
      UNSIGNED phone_source_id;
    END;
    
    rec_besr add_bdid(temp_besr l) := TRANSFORM
      SELF.bdid := business_header.stored_bdid_val,
      SELF.name_source_id := 0,
      SELF.addr_source_id := 0,
      SELF.phone_source_id := 0,
      SELF := l,
    END;
    
    rec_besr add_name_source_id(rec_besr l, name_table r) := TRANSFORM
      SELF.name_source_id := r.name_source_id,
      SELF := l,
    END;
    
    rec_besr add_addr_source_id(rec_besr l, addr_table r) := TRANSFORM
      SELF.addr_source_id := r.addr_source_id,
      SELF := l,
    END;
    
    rec_besr add_phone_source_id(rec_besr l, phone_table r) := TRANSFORM
      SELF.phone_source_id := r.phone_source_id,
      SELF := l,
    END;

    besr1 := PROJECT( temp_besr,add_bdid(LEFT) );
    besr2 :=
      JOIN( besr1, name_table,
            LEFT.company_name=RIGHT.company_name,
            add_name_source_id(LEFT,RIGHT),
            LEFT OUTER );
    besr3 :=
      JOIN( besr2, addr_table,
            LEFT.state=RIGHT.state AND
            LEFT.zip=RIGHT.zip AND
            LEFT.prim_name=RIGHT.prim_name AND
            LEFT.prim_range=RIGHT.prim_range AND
            LEFT.sec_range=RIGHT.sec_range,
            add_addr_source_id(LEFT,RIGHT),
            LEFT OUTER );
    besr :=
      JOIN( besr3, phone_table,
            LEFT.phone=RIGHT.phone,
            add_phone_source_id(LEFT,RIGHT),
            LEFT OUTER );

    iesp.rollupbizreport.t_BizReportFor xfm_bestinfo() :=
      TRANSFORM
        SELF.BusinessId := in_bdid,
        SELF.CompanyName := besr[1].Company_Name,
        SELF.FEIN := besr[1].FEIN,
        SELF.Address := iesp.ECL2ESP.SetAddress ( besr[1].prim_name, besr[1].prim_range, besr[1].predir, besr[1].postdir,
                                                  besr[1].addr_suffix, besr[1].unit_desig, besr[1].sec_range, besr[1].city,
                                                  besr[1].state, besr[1].zip, besr[1].zip4, besr[1].county_name),
        SELF.PhoneInfo := iesp.ECL2ESP.SetPhoneInfo(besr[1].Phone),
        SELF.ReportId := '',
        SELF.MsaNumber := besr[1].msa,
        SELF.MsaDescription := besr[1].msadesc,
      END;
                       
    rw_bestInfo := ROW(xfm_bestinfo());
                       

    //-----------------------------------------------------------------------------------------------------------
    //----- Business Associates ---------------------------------------------------------------------------------
    //-----------------------------------------------------------------------------------------------------------

    basr := doxie_cbrs.business_associates_records_trimmed(bdids, mod_access);

    ds_businessAssociates :=
      PROJECT( GLOBAL(basr.records),
               TRANSFORM( iesp.rollupbizreport.t_BusinessAssociate,
                          SELF.CompanyName := LEFT.company_name,
                          SELF.Address := iesp.ECL2ESP.SetAddress ( LEFT.prim_name, LEFT.prim_range, LEFT.predir, LEFT.postdir,
                                                                        LEFT.addr_suffix, LEFT.unit_desig, LEFT.sec_range, LEFT.city,
                                                                        LEFT.state, LEFT.zip, LEFT.zip4, ''),
                          SELF.BusinessId := (STRING)LEFT.bdid,
                       ));
    
    
    //-----------------------------------------------------------------------------------------------------------
    //----- Contacts -------------------------------------------------------------------------------------------
    //-----------------------------------------------------------------------------------------------------------
    
    conr := doxie_cbrs.contact_records_prs_trimmed(bdids);
    
    ds_contacts :=
      PROJECT( GLOBAL(conr.records),
               TRANSFORM( iesp.enhancedbizreport.t_EnhancedBizReportContact,
                          SELF.BusinessId := (STRING)LEFT.bdid,
                          SELF.UniqueId := (STRING)LEFT.did,
                          SELF.SSN := LEFT.ssn,
                          SELF.Address := iesp.ECL2ESP.SetAddress ( LEFT.prim_name, LEFT.prim_range, LEFT.predir, LEFT.postdir,
                                                                          LEFT.addr_suffix, LEFT.unit_desig, LEFT.sec_range, LEFT.city,
                                                                          LEFT.state, LEFT.zip, LEFT.zip4, ''),
                          SELF.Name := iesp.ECL2ESP.setName(LEFT.fname, LEFT.mname, LEFT.lname, LEFT.name_suffix, '', ''),
                          SELF.CompanyTitles := MIDEX_Services.Functions.fn_setContactCompanyTitles( LEFT.company_titles, 1 ),
                          SELF.DateLastSeen := iesp.ECL2ESP.toDateString8((STRING)LEFT.dt_last_seen),
                        ));
  
  
    //-----------------------------------------------------------------------------------------------------------
    //----- Liens Judgments V2 ---------------------------------------------------------------------------------
    //-----------------------------------------------------------------------------------------------------------
    raw_jls := doxie_cbrs.Liens_Judments_records_v2(bdids, mod_access.SSN_Mask).report_view(MIDEX_Services.Constants.MAX_LIENS_JUDGMENTS_val)(TRUE);
    
    judgmentsAndLiensV2Recs := CHOOSEN(raw_jls,MIDEX_Services.Constants.MAX_LIENS_JUDGMENTS_val);
    countOfJudgmentsAndLiensV2 := COUNT(raw_jls);

    ds_lienJudgmentsV2 :=
      PROJECT( GLOBAL(judgmentsAndLiensV2Recs),
               TRANSFORM( iesp.lienjudgement.t_LienJudgmentReportRecord,
                          SELF.BusinessIds := [], // iesp.share.t_BusinessIdentity bip ids
                          SELF.IdValue := '',
                          SELF.RMSId := LEFT.rmsid,
                          SELF.OriginFilingTime := LEFT.orig_filing_time,
                          SELF.TaxCode := LEFT.tax_code,
                          SELF.Judge := LEFT.judge,
                          SELF.ExternalKey := '', // ??
                          SELF.TMSId := LEFT.tmsid,
                          SELF.MatchedParty := MIDEX_Services.functions.fn_setMatchedParty(LEFT.matched_party),
                          SELF.IRSSerialNumber := LEFT.irs_serial_number,
                          SELF.OriginFilingNumber := LEFT.orig_filing_number,
                          SELF.OriginFilingType := LEFT.orig_filing_type,
                          SELF.OriginFilingDate := iesp.ECL2ESP.toDateString8(LEFT.orig_filing_date),
                          SELF.CaseNumber := LEFT.case_number,
                          SELF.Eviction := LEFT.eviction,
                          SELF.Amount := LEFT.amount,
                          SELF.FilingJurisdiction := LEFT.filing_jurisdiction,
                          SELF.FilingJurisdictionName := LEFT.filing_jurisdiction_name,
                          SELF.FilingState := LEFT.filing_state,
                          SELF.FilingStatus := LEFT.filing_status[1].filing_status,
                          SELF.CertificateNumber := LEFT.certificate_number,
                          SELF.MultipleDefendant := IF( LEFT.multiple_debtor, 'TRUE', 'FALSE'),
                          SELF.JudgeSatisfiedDate := iesp.ECL2ESP.toDateString8(LEFT.judg_satisfied_date),
                          SELF.SuitDate := iesp.ECL2ESP.toDateString8(''),
                          SELF.JudgeVacatedDate := iesp.ECL2ESP.toDateString8(LEFT.judg_vacated_date),
                          SELF.ReleaseDate := iesp.ECL2ESP.toDateString8(LEFT.release_date),
                          SELF.LegalLot := LEFT.Legal_Lot,
                          SELF.LegalBlock := LEFT.Legal_Block,
                          SELF.Debtors := MIDEX_Services.Functions.fn_setLienJudgDebtor (LEFT.debtors, iesp.Constants.Liens.MAX_DEBTORS),
                          SELF.ThirdParties := MIDEX_Services.Functions.fn_setLienJudgThirdParty(LEFT.thds, 1),
                          SELF.Creditors := MIDEX_Services.Functions.fn_setLienJudgCreditors(LEFT.creditors, iesp.Constants.Liens.MAX_CREDITORS),
                          SELF.DebtorAttorneys := MIDEX_Services.Functions.fn_setLienJudgAttorneys(LEFT.attorneys, iesp.Constants.Liens.MAX_ATTORNEYS),
                          SELF.Filings := MIDEX_Services.Functions.fn_setLienJudgFilings(LEFT.filings, iesp.Constants.Liens.MAX_FILINGS),
                      ));

    //-----------------------------------------------------------------------------------------------------------
    //----- Name Variations -------------------------------------------------------------------------------------
    //-----------------------------------------------------------------------------------------------------------
    
    nmvr := doxie_cbrs.name_variations_base(bdids);
     
    ds_nameVariations :=
      PROJECT( GLOBAL(nmvr.records),
               TRANSFORM( iesp.rollupbizreport.t_CompanyNameVariation,
                          SELF.CompanyName := LEFT.company_name,
                          SELF.SourceDocId := (STRING)LEFT.name_source_id,
                        ));



    //-----------------------------------------------------------------------------------------------------------
    //----- Phone Variations ------------------------------------------------------------------------------------
    //-----------------------------------------------------------------------------------------------------------
    
    phvr := doxie_cbrs.phone_variations_base(bdids);
    
    ds_phoneVariations :=
      PROJECT( GLOBAL(phvr.records),
               TRANSFORM( iesp.rollupbizreport.t_PhoneVariation,
                          SELF.PhoneInfo := iesp.ECL2ESP.setPhoneInfo(LEFT.phone),
                          SELF.SourceDocId := (STRING)LEFT.phone_source_id,
                        ));


    //-----------------------------------------------------------------------------------------------------------
    //----- Property V2 -----------------------------------------------------------------------------------------
    //-----------------------------------------------------------------------------------------------------------
    
    pror_v2 := doxie_cbrs.property_records_v2(bdids, includeBlackKnight);
    // bug: 146211, per Jiafu the sourcePropertyRecordID needs to be populated with the FaresID.
    ds_propertyV2 :=
      PROJECT( GLOBAL(pror_v2.all_recs),
               TRANSFORM( iesp.property.t_PropertyReport2Record,
                          SELF.DataSource := LEFT.vendor_source_desc,
                          SELF.FaresId := LEFT.ln_fares_id,
                          SELF.SourcePropertyRecordID := LEFT.ln_fares_id,
                          SELF.RecordType := LEFT.fid_type,
                          SELF.RecordTypeDesc := LEFT.fid_type_desc,
                          SELF.OutputSeqNo := LEFT.current_record,
                          SELF.Assessment := MIDEX_Services.Functions.fn_setPropertyAssessment(LEFT.assessments[1]),
                          SELF.Deed := MIDEX_Services.Functions.fn_setPropertyDeed(LEFT.deeds[1]),
                          SELF.Entities := MIDEX_Services.Functions.fn_setPropertyEntities(LEFT.parties, iesp.Constants.Prop.MaxEntities),
                          SELF := [],
                       ));
    

    //-----------------------------------------------------------------------------------------------------------
    //----- Source Docs Section ---------------------------------------------------------------------------------
    //-----------------------------------------------------------------------------------------------------------
    
    //----- Get Section Flag for each Section --------------------------------------------------
    // if there are no records in the section, the flag is section
    // if there are no more than the max number of records for a section, return retrievable
    // if there were more than the max number of records for the section available, but only
    // the max number of records were returned, return overflow for the section flag
    countOfPropertyV2Recs := COUNT(pror_v2.all_recs);
    
    STRING11 fn_getSectionFlag( UNSIGNED2 sectionCount, UNSIGNED2 sectionMaxVal ) :=
      FUNCTION
        sectionFlag := MAP( sectionCount = 0 => 'Section',
                            sectionCount > sectionMaxVal => 'Overflow',
                             /* default */ 'Retrievable');
        RETURN sectionFlag;
      END;

    Address_Variations_Section_flag := fn_getSectionFlag( advr.records_count, MaxAddressVariations );
    Bankruptcy_Section_V2_flag := fn_getSectionFlag( bnkr_v2.records_count, MaxBankruptciesV2 );
    Business_Associates_Section_flag := fn_getSectionFlag( basr.records_count, MaxBusinessAssociates );
    Contacts_Section_flag := fn_getSectionFlag( conr.records_count, MaxAssociatedPeople );
    Liens_Judgments_Section_v2_flag := fn_getSectionFlag( countOfJudgmentsAndLiensV2, MaxLiensJudgmentsUcc );
    Name_Variations_Section_flag := fn_getSectionFlag( nmvr.records_count, MaxNameVariations );
    Phone_Variations_Section_flag := fn_getSectionFlag( phvr.records_count, MaxPhoneVariations );
    Property_Section_v2_flag := fn_getSectionFlag( countOfPropertyV2Recs, MaxProperties );
    
    //-------- Build the Source Doc information ------------------------------------------------
    trimmed_bdid := TRIM(in_bdid, LEFT, RIGHT);
    ds_SourceInfo := IF( include_SourceDocs,
      DATASET([{'ADDRESS_VARIATIONS', advr.records_count, 'B'+ trimmed_bdid + '$ADDRESS_VARIATIONS', Address_Variations_Section_flag },
               {'BANKRUPTCY_V2', bnkr_v2.records_count, 'B'+ trimmed_bdid + '$BANKRUPTCY_V2', Bankruptcy_Section_V2_flag},
               {'BUSINESS_ASSOCIATES', basr.records_count, 'B'+ trimmed_bdid + '$BUSINESS_ASSOCIATES', Business_Associates_Section_flag },
               {'CONTACTS', conr.records_count, 'B'+ trimmed_bdid + '$CONTACTS', Contacts_Section_flag},
               {'LIENS_JUDGMENTS_V2', countOfJudgmentsAndLiensV2, 'B'+ trimmed_bdid + '$LIENS_JUDGMENTS_V2', Liens_Judgments_Section_v2_flag},
               {'NAME_VARIATIONS', nmvr.records_count, 'B'+ trimmed_bdid + '$NAME_VARIATIONS', Name_Variations_Section_flag},
               {'PHONE_VARIATIONS', phvr.records_count, 'B'+ trimmed_bdid + '$PHONE_VARIATIONS', Phone_Variations_Section_flag},
               {'PROPERTY_V2', countOfPropertyV2Recs, 'B'+ trimmed_bdid + '$PROPERTY_V2', Property_Section_v2_flag}], iesp.share.t_SourceSection),
      DATASET([],iesp.share.t_SourceSection));
               

    //***** PROJECT THEM IN
    MIDEX_Services.Layouts.rec_SmartLinxBusinessPlusSources xfm_getSmartLinxBusSections() :=
      TRANSFORM
        SELF.BestInformation := rw_bestInfo,
        SELF.NameVariations := CHOOSEN(ds_nameVariations, iesp.Constants.MIDEX.MAX_COUNT_SMARTLINX_BIZ_NAME_VARIATIONS),
        SELF.AddressVariations := CHOOSEN(ds_addrVariations, iesp.Constants.MIDEX.MAX_COUNT_SMARTLINX_BIZ_ADDRESS_VARIATIONS),
        SELF.PhoneVariations := CHOOSEN(ds_phoneVariations, iesp.Constants.MIDEX.MAX_COUNT_SMARTLINX_BIZ_PHONE_VARIATIONS),
        SELF.Bankruptcies := CHOOSEN(ds_bankruptcyV2, iesp.Constants.MIDEX.MAX_COUNT_SMARTLINX_BIZ_BANKRUPTCIES),
        SELF.LiensJudgments := CHOOSEN(ds_lienJudgmentsV2, iesp.Constants.MIDEX.MAX_COUNT_SMARTLINX_BIZ_LIENS_JUDGMENTS),
        SELF.BusinessAssociates := CHOOSEN(ds_businessAssociates, iesp.Constants.MIDEX.MAX_COUNT_SMARTLINX_BIZ_BUSINESS_ASSOCIATES),
        SELF.Contacts := CHOOSEN(ds_contacts, iesp.Constants.MIDEX.MAX_COUNT_SMARTLINX_BIZ_ASSOCIATED_PEOPLE),
        SELF.Properties := CHOOSEN(ds_propertyV2, iesp.Constants.MIDEX.MAX_COUNT_SMARTLINX_BIZ_PROPERTIES),
        SELF.Sources := ds_SourceInfo,
        SELF := [],
    END;


    smartLinxBusinessRecs := DATASET([xfm_getSmartLinxBusSections()]);

    RETURN smartLinxBusinessRecs;
 
  END;

  /* // Sample Bdids

    // bdids := DATASET([{'55982156'}],doxie_cbrs.layout_references);
    bdids := DATASET([{'76827062'}],doxie_cbrs.layout_references); // Gold Coast Funding Group, Inc. Property recs
    // bdids := DATASET([{'16'}],doxie_cbrs.layout_references); // business with J&L
    // bdids := DATASET([{'374816324'}],doxie_cbrs.layout_references); // bdid with bankruptcy

//----------------------------------------------------------------------------------------------------------------
doxie.cbrs code:


    //***** SYNTAX REQUIRES THAT I CREATE A NAME FOR THE LAYOUT OF SOME (CANNOT ASSIGN TABLE OF UNNAMED...)
    mac_give_name(r, outr) := MACRO
      #uniquename(rec)
      #uniquename(renameit)
      %rec% := RECORDOF(r);
      %rec% %renameit%(r l) := TRANSFORM
        SELF := l;
      END;
      outr := PROJECT(r, %renameit%(LEFT));
    ENDMACRO;

    // mac_give_name(advr.records, advr_named)
    // mac_give_name(phvr.records, phvr_named)
    // mac_give_name(nmvr.records, nmvr_named)


    //***** Layouts for each section
    recbesr := RECORDOF(besr); // best info
    recadvr := RECORDOF(advr_named); // address variations
    recbnkr_v2 := RECORDOF(bnkr_v2.records); // bankruptcy v2
    recbasr := RECORDOF(basr.records); // business associates
    recconr := RECORDOF(conr.records); // contacts
    recljur_v2 := RECORDOF(judgmentsAndLiensV2Recs); // liens and judgments
    recnmvr := RECORDOF(nmvr_named); // name variations
    recphvr := recordof(phvr_named); // phone variations
    recpror_v2 := RECORDOF(pror_v2.all_recs); // properties v2

    //***** THE COMBINED LAYOUT
    // rec := RECORD, MAXLENGTH(7500000)
      // DATASET(recbesr) Best_Information;
      // DATASET(recnmvr) Name_Variations;
      // DATASET(recadvr) Address_Variations;
      // DATASET(recbnkr_v2) Bankruptcy_v2;
      // DATASET(recbasr) Business_Associates;
      // DATASET(recconr) Contacts;
      // DATASET(recljur_v2) Liens_Judgments_v2;
      // DATASET(recphvr) Phone_Variations;
      // DATASET(recpror_v2) Property_v2;
      // DATASET(iesp.share.t_SourceSection) Sources;
    // END;
    // rec getall(ds_empty l) :=
      // TRANSFORM
        // SELF.Best_Information := GLOBAL(GROUP(besr));
        // SELF.Name_Variations := GLOBAL(nmvr_named);
        // SELF.Address_Variations := GLOBAL(advr_named);
        // SELF.Phone_Variations := GLOBAL(phvr_named);
        // SELF.Bankruptcy_v2 := GLOBAL(bnkr_v2.records);
        // SELF.Liens_Judgments_v2 := GLOBAL(judgmentsAndLiensV2Recs);
        // SELF.Business_Associates := GLOBAL(basr.records);
        // SELF.Contacts := GLOBAL(conr.records);
        // SELF.Property_v2 := GLOBAL(pror_v2.all_recs);
        // SELF.Sources := ds_sourceInfo;
        // SELF := [];
    // END;
 // smartLinxBusinessRecs := PROJECT(ds_empty, getall(LEFT));





*/
