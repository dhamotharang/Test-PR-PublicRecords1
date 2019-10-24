IMPORT DueDiligence, MDR, Models;

EXPORT Ver_source_Function(STRING ver_sources, STRING ver_sources_first_seen, STRING ver_sources_last_seen) := FUNCTION



     NULL := Models.common.NULL;
     COMMA := '  ,';
     MODIFIER := 'ie';
     CHAR0 := '0'; 
     
     
     
    SourceDataInfo := RECORD
        STRING5 source;
        STRING8 firstSeenDate;
        STRING8 lastSeenDate;
        INTEGER4 sasConvertedFirstSeenDate;
        INTEGER4 sasConvertedLastSeenDate;
        BOOLEAN countSource;
        BOOLEAN bureauSource;
        BOOLEAN credentialedSource;
    END;
     
     
    GetSource(STRING mdrSource) := FUNCTION
        
         ver_src_pos := Models.Common.findw_cpp(ver_sources, mdrSource, COMMA, MODIFIER);
         temp_ver_src_fdate := IF(ver_src_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_pos), CHAR0);
         temp_ver_src_ldate := IF(ver_src_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_pos), CHAR0);
         ver_src_fdate := Models.common.sas_date((STRING)(temp_ver_src_fdate));
         ver_src_ldate := Models.common.sas_date((STRING)(temp_ver_src_ldate));
             
        RETURN DATASET([TRANSFORM(SourceDataInfo,
                                  SELF.source := mdrSource;
                                  SELF.firstSeenDate := temp_ver_src_fdate;
                                  SELF.lastSeenDate := temp_ver_src_ldate;
                                  SELF.sasConvertedFirstSeenDate := ver_src_fdate;
                                  SELF.sasConvertedLastSeenDate := ver_src_ldate; 
                                  SELF.countSource := ver_src_pos > 0;
                                  SELF.bureauSource := mdrSource IN DueDiligence.Citizenship.Constants.SOURCE_BUREAU;
                                  SELF.credentialedSource := mdrSource IN DueDiligence.Citizenship.Constants.SOURCE_CREDENTIALED;)]);
    END;
   


    //AK
    ver_src_ak := GetSource(MDR.SourceTools.src_AK_Perm_Fund);

    //AM - CREDENTIALED
    ver_src_am := GetSource(MDR.SourceTools.src_Airmen);

    //AR - CREDENTIALED
    ver_src_ar := GetSource(MDR.SourceTools.src_Aircrafts);

    //BA - CREDENTIALED
    ver_src_ba := GetSource(MDR.SourceTools.src_Bankruptcy);

    //CG - CREDENTIALED
    ver_src_cg := GetSource(MDR.SourceTools.src_US_Coastguard);

    //CO
    ver_src_co := GetSource(MDR.SourceTools.src_FCRA_Corrections_record);

    //CY
    ver_src_cy := GetSource(MDR.SourceTools.src_Certegy);

    //DA - CREDENTIALED
    ver_src_da := GetSource(MDR.SourceTools.src_DEA);

    //D  - CREDENTIALED
    ver_src_d := GetSource(MDR.SourceTools.src_Dunn_Bradstreet);

    //DL - CREDENTIALED
    ver_src_dl := GetSource(Citizenship.Constants.DL_SOURCE);

    //DS
    ver_src_ds := GetSource(MDR.SourceTools.src_Death_State);

    //DE
    ver_src_de := GetSource(MDR.SourceTools.src_Death_Master);

    //EB - CREDENTIALED
    ver_src_eb := GetSource(MDR.SourceTools.src_EMerge_Boat);

    //EM
    ver_src_em := GetSource(MDR.SourceTools.src_EMerge_Master);

    //E1 - CREDENTIALED
    ver_src_e1 := GetSource(MDR.SourceTools.src_EMerge_Hunt);

    //E2 - CREDENTIALED
    ver_src_e2 := GetSource(MDR.SourceTools.src_EMerge_Fish);

    //E3 - CREDENTIALED
    ver_src_e3 := GetSource(MDR.SourceTools.src_EMerge_CCW);

    //E4
    ver_src_e4 := GetSource(MDR.SourceTools.src_EMerge_Cens);

    //EN - BUREAU
    ver_src_en := GetSource(MDR.SourceTools.src_Experian_Credit_Header);

    //EQ - BUREAU
    ver_src_eq := GetSource(MDR.SourceTools.src_Equifax);

    //FE - CREDENTIALED
    ver_src_fe := GetSource(MDR.SourceTools.src_Federal_Explosives);

    //FF - CREDENTIALED
    ver_src_ff := GetSource(MDR.SourceTools.src_Federal_Firearms);

    //FR
    ver_src_fr := GetSource(MDR.SourceTools.src_Foreclosures);

    //L2
    ver_src_l2 := GetSource(MDR.SourceTools.src_Liens_v2);

    //LI
    ver_src_li := GetSource(MDR.SourceTools.src_Liens);

    //MW
    ver_src_mw := GetSource(MDR.SourceTools.src_MS_Worker_Comp);

    //NT
    ver_src_nt := GetSource(MDR.SourceTools.src_Foreclosures_Delinquent);

    //P  - CREDENTIALED
    ver_src_p := GetSource(Citizenship.Constants.P_SOURCE);

    //PL - CREDENTIALED
    ver_src_pl := GetSource(MDR.SourceTools.src_Professional_License);

    //TN - BUREAU
    ver_src_tn := GetSource(MDR.SourceTools.src_TU_CreditHeader);

    //TS
    ver_src_ts := GetSource(MDR.SourceTools.src_TUCS_Ptrack);

    //TU
    ver_src_tu := GetSource(MDR.SourceTools.src_TransUnion);

    //SL - CREDENTIALED
    ver_src_sl := GetSource(MDR.SourceTools.src_American_Students_List);

    //V - CREDENTIALED
    ver_src_v := GetSource(MDR.SourceTools.src_Vickers);

    //VO - CREDENTIALED
    ver_src_vo := GetSource(MDR.SourceTools.src_Voters_v2);

    //W  - CREDENTIALED
    ver_src_w := GetSource(MDR.SourceTools.src_Whois_domains);

    //WP
    ver_src_wp := GetSource(MDR.SourceTools.src_Targus_White_pages);





    //add all the source data together to do calculations
    allSourceData := ver_src_ak + ver_src_am + ver_src_ar + ver_src_ba + ver_src_cg + ver_src_co +
                     ver_src_cy + ver_src_da + ver_src_d + ver_src_dl + ver_src_ds + ver_src_de +
                     ver_src_eb + ver_src_em + ver_src_e1 + ver_src_e2 + ver_src_e3 + ver_src_e4 +
                     ver_src_en + ver_src_eq + ver_src_fe + ver_src_ff + ver_src_fr + ver_src_l2 +
                     ver_src_li + ver_src_mw + ver_src_nt + ver_src_p + ver_src_pl + ver_src_tn + 
                     ver_src_ts + ver_src_tu + ver_src_sl + ver_src_v + ver_src_vo + ver_src_w + ver_src_wp;



    //count sources
    countAnySources := COUNT(allSourceData(countSource));
    countBureauSources := COUNT(allSourceData(bureauSource AND countSource));
    countNonBureauSourcs := COUNT(allSourceData(bureauSource = FALSE AND countSource));
    countCredentialedSources := COUNT(allSourceData(credentialedSource AND countSource));


    //earliest header date
    sortAllSources := SORT(allSourceData(sasConvertedFirstSeenDate <> NULL), sasConvertedFirstSeenDate);
    earliestSASHeaderDate := IF(EXISTS(sortAllSources), sortAllSources[1].sasConvertedFirstSeenDate, NULL);

    //earliest bureau date
    sortBureauSources := SORT(allSourceData(bureauSource AND sasConvertedFirstSeenDate <> NULL), sasConvertedFirstSeenDate);
    earliestSASBureauDate := IF(EXISTS(sortBureauSources), sortBureauSources[1].sasConvertedFirstSeenDate, NULL);

    //last reported date by credentialed source
    maxCredentialedDate := MAX(allSourceData(credentialedSource), sasConvertedLastSeenDate);

    
    
    
    //these dates need to be returned in date format vs sas code
    //they are not used in risk indicators but as a pass through
    
    //last reported date by any source
    maxSourceDate := MAX(allSourceData, lastSeenDate);

    //last reported date by bureau source
    maxBureauDate := MAX(allSourceData(bureauSource), lastSeenDate);



    returnValue := (STRING10)earliestSASHeaderDate + ',' +      //position 1 - 10
                   (STRING10)earliestSASBureauDate + ',' +      //position 12 - 21
                   (STRING10)maxCredentialedDate + ',' +        //position 23 - 32
                   (STRING3)countCredentialedSources + ',' +    //position 34 - 36
                   (STRING3)countBureauSources + ',' +          //position 38 - 40
                   (STRING3)countAnySources + ',' +             //position 42 - 44
                   (STRING3)countNonBureauSourcs + ',' +        //position 46 - 48
                   (STRING8)maxSourceDate + ',' +               //position 50 - 57
                   (STRING8)maxBureauDate + ',END';             //position 59 - 66
                              
                    
     
   
     
     
    // OUTPUT(allSourceData, NAMED('allSourceData'));  
    // OUTPUT(countAnySources, NAMED('countAnySources'));      
    // OUTPUT(countBureauSources, NAMED('countBureauSources'));      
    // OUTPUT(countNonBureauSourcs, NAMED('countNonBureauSourcs'));      
    // OUTPUT(countCredentialedSources, NAMED('countCredentialedSources'));   
    // OUTPUT(sortAllSources, NAMED('sortAllSources'));   
    // OUTPUT(earliestSASHeaderDate, NAMED('earliestSASHeaderDate'));   
    // OUTPUT(sortBureauSources, NAMED('sortBureauSources'));   
    // OUTPUT(earliestSASBureauDate, NAMED('earliestSASBureauDate'));   
    // OUTPUT(maxCredentialedDate, NAMED('maxCredentialedDate'));   
    // OUTPUT(maxSourceDate, NAMED('maxSourceDate'));   
    // OUTPUT(maxBureauDate, NAMED('maxBureauDate'));   
    // OUTPUT(returnValue, NAMED('returnValue'));   
     
     
 
    RETURN returnValue; 
END;