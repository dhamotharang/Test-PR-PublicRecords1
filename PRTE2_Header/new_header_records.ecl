IMPORT 

// PRTE2_Death_Master,
// prte2_DLV2,
// PRTE2_ATF,
// PRTE2_Prof_LicenseV2,
PRTE2_Liens,
// PRTE2_FAA,
// PRTE2_WaterCraft,
// PRTE2_DEA,
// PRTE2_LNProperty,
PRTE2_Bankruptcy,
// PRTE2_Foreclosure,
// prte2_VotersV2,
// prte2_DOC,
// prte2_Domains,
// PRTE2_Email_Data,
// PRTE2_EmergesKeys,
PRTE2_Gong,
// PRTE2_Marriage_Divorce,
PRTE2_PhonesPlus,
// PRTE2_SexOffender,
// PRTE2_UCC,
// PRTE2_Utility,
PRTE2_Vehicle;


    // ids             := header.file_new_month(pFastHeader)(use_header);
    // eq_hist_in      := eq_hist.As_header(,true)(use_eq_hist);
    // death_in        := PRTE2_Death_Master.As_Headers.Death_as_Header();
    // state_death_in  := state_death_as_header(,true)(use_state_death);
    // dl_in           := prte2_DLV2.as_headers;
    vr_in           := PRTE2_Vehicle.as_headers.person_header_vehicle_recs;
    ba_in           := PRTE2_Bankruptcy.as_headers.person_header_Bankruptcy  ;//if(pFastHeader, Bankrupt.BK_as_header(pFastHeader:=           true)(use_bank), Bankrupt.BK_as_header(pForHeaderBuild:=           true)(use_bank));
    // fa_in           := PRTE2_LNProperty.as_headers.Person_Header;   //:= if(pFastHeader, ln_propertyv2.ln_propertyv2_as_source(true).ln_propertyv2_as_fheader, ln_propertyv2.ln_propertyv2_as_source().ln_propertyv2_as_header);
    // atf_in          := PRTE2_ATF.as_headers.person_header_ATF;
    // ut_in           :=PRTE2_Utility.as_headers.person_header_utility;
    // ak_in           := ak_perm_fund.APF_As_Header(,,true)(use_ak_perm_fund);
    // em_in           := PRTE2_EmergesKeys.as_headers.Emerges_header;
    // pro_lic         := Prte2_prof_licenseV2.as_header.new_person_header;
    // MS_work         := govdata.MS_Worker_as_header(,true)(use_MS_worker);
    liens           := PRTE2_Liens.as_headers.person_header_liens;;
    // forcl           := PRTE2_Foreclosure.as_headers.person_header_foreclosure_recs;//  := property.Foreclosure_as_Header(,true)(use_foreclosures);
    // airm            := PRTE2_FAA.as_header_airmen.person_header_airmen_recs;                          
    // airc            := PRTE2_FAA.as_header_aircraft.person_header_aircraft_recs;
    // water           := PRTE2_WaterCraft.as_headers.person_header_watercraft;
    // boat            := PRTE2_EmergesKeys.as_headers //   := emerges.boat_as_header(,true)(use_boaters);                
    // dea_in          := PRTE2_DEA.as_headers.DEA_as_Header();
    // targus_wp       := targus.consumer_as_header(,true)(use_targus);
    liens_v2        := PRTE2_Liens.as_headers.person_header_liens;//if(pFastHeader, LiensV2.LiensV2_as_header(pFastHeader:=           true)(use_liensv2), LiensV2.LiensV2_as_header(pForHeaderBuild:=           true)(use_liensv2));
    // asl_in          := american_student_list.asl_as_header(,true)(use_asl);
    // voters_in       := prte2_VotersV2.as_headers();
    // certegy_in      := Certegy.As_header(,true)(use_certegy);
    // nod_in          := property.NOD_as_Header(,true)(use_nod);
    // Experian_in     := if(pFastHeader, ExperianCred.Experian_as_header(pFastHeader:=           true)(use_experian), ExperianCred.Experian_as_header(pForHeaderBuild:=           true)(use_experian)); 
    // Tranunion_in    := if(pFastHeader,TransunionCred.as_header(pFastHeader:=           true)(use_transunion), TransunionCred.as_header(pForHeaderBuild:=           true)(use_transunion));
    // Exprn_ph_in     := ExperianIRSG_Build.ExperianIRSG_asHeader(,true)(use_Experian_phones); 
    // AlloyMedia_in   := AlloyMedia_student_list.alloy_as_header(,true)(use_AlloyMedia_SL); 

    //new
    // docs_in         := prte2_DOC.as_headers();
    // domn_in         := prte2_Domains.as_headers.person_header_domain_recs;
    // emal_in         := PRTE2_Email_Data.as_headers.person_header_email_recs;
    gong_in         := dedup(sort(PRTE2_Gong.as_headers.person_header_gong_recs,record),record);
    // mrrg_in         := PRTE2_Marriage_Divorce.as_header.person_header_mar_div;
    phnp_in         := dedup(sort(PRTE2_PhonesPlus.as_headers.person_header_phones,record),record);
    // sxof_in         := PRTE2_SexOffender.as_headers.person_header_SOF;
    // ucch_in         := PRTE2_UCC.as_headers.person_header_ucc;

    _new_header_records := 

        PRTE2_Header.PreProcess
            // ids 
            // + eq_hist_in 
            // +death_in
            // + state_death_in
            // + dl_in 
        + vr_in 
        + ba_in 
            // + fa_in 
            // + atf_in 
            // + ut_in 
            // + ak_in 
            // + em_in 
            // + pro_lic 
            // + MS_Work 
        + liens 
            // + forcl 
            // + airm 
            // + airc 
            // + water 
            // + boat 
            // + dea_in 
            // + targus_wp 
        + liens_v2 
            // + asl_in 
            // + voters_in
            // + certegy_in
            // + nod_in
            // + Experian_in
            // + Exprn_ph_in
            // + AlloyMedia_in
            // + docs_in
            // + domn_in
            // + emal_in
        + gong_in
            // + mrrg_in
        + phnp_in
            // + sxof_in
            // + ucch_in
        ;

EXPORT new_header_records := _new_header_records;