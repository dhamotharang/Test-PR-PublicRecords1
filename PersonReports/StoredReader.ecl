IMPORT doxie, iesp, PersonReports;
doxie.MAC_Selection_Declare ();
doxie.MAC_Header_Field_Declare (); // only for versions

export StoredReader := MODULE

// Unfortunately, I can't use short syntax like (see #50974):
//       export boolean include_oldphones := include_all or (false : stored('IncludeOldPhones'));
// NB: "translations are not done here, since it is a kind of compatibility code;
// real translations are done in PersonReports@functions attribute


  export relatives_options := MODULE (PersonReports.IParam.relatives)
    export unsigned1 relative_depth           := min (max (^.Relative_Depth, 1), 3); //1
    export unsigned1 max_relatives            := min (^.max_relatives, iesp.Constants.BR.MaxRelatives); //100
    export boolean  include_relativeaddresses := Include_RelativeAddresses_val; //false
    export unsigned1 max_relatives_addresses  := min (^.Max_RelativeAddresses, iesp.Constants.BR.MaxRelatives_Address); //3
    // newly introduced (they're in SOAP mostly for debug, can be removed later)
    export boolean rels_with_phones        := false : stored ('AddressesWithoutPhones'); // meaning, ONLY relatives/associates with phones
    export boolean use_verified_address_ra := false : stored ('UnverifiedAddresses');    // enforce returning of verified addresses only
  end;

  export neighbors_options := MODULE (PersonReports.IParam.neighbors)
    export unsigned1 neighborhoods := min (max (Max_Neighborhoods, 0), iesp.Constants.BR.MaxNeighborhood); //0
    export unsigned1 neighbors_per_address := Neighbors_PerAddress; //3
    export unsigned1 addresses_per_neighbor := Addresses_PerNeighbor; //3
    export unsigned1 neighbors_per_na := ^.Neighbors_Per_NA; //6
    export unsigned1 neighbors_recency := Neighbor_Recency; //3
    // no used? export unsigned1 historical_neighborhoods  := min (max (zzz, 0), iesp.Constants.BR.MaxHistoricalNeighborhood);
    export unsigned1 neighbors_proximity := min (max (^.neighbors_proximity, 0), 50);
    // -- generally, the radius of neighbors' units: houses, or appartments or etc.
  end;

  export imposters_options := MODULE (PersonReports.IParam.imposters)
    export boolean return_AllImposterRecords := false : stored('ReturnAllImposters'); //new
  end;

  export phones_options := MODULE (PersonReports.IParam.phones)
    export boolean include_phonesfeedback := IncludePhonesFeedback;
    export boolean indicate_restricted    := false : stored ('IndicateUnpub'); //new
  end;

  export providers_options := MODULE (PersonReports.IParam.providers)
    // same exactly way as in doxie@prov_records
    export boolean include_groupaffiliations    := false : stored('IncludeGroupAffiliations');
    export boolean include_hospitalaffiliations := false : stored('IncludeHospitalAffiliations');
    export boolean include_education            := false : stored('IncludeEducation');
    export boolean include_businessaddress      := false : stored('IncludeBusinessAddress');
  end;

// Reads from the SOAP section, to ensure backward compatibility with non-ESDL mode.
  export global_options := MODULE (PersonReports.IParam.include, phones_options)
    export select_individually := Select_Indiv;

    export boolean include_akas            := Include_AKAs_val;
    export boolean include_alsofound       := false : stored('ReturnAlsoFound');
    export boolean include_associates      := Include_Associates_val;
    export boolean include_atf             := Include_FirearmsAndExplosives_val;
    // unsigned3 Max_Associates := 10 : stored('MaxAssociates');
    export boolean include_best            := false : stored('IncludeBestInfo');   //not defined in doxie-CRS
    export boolean include_bpsaddress      := false : stored('IncludeBpsAddress'); //not defined in doxie-CRS
    export boolean include_bankruptcy      := Include_Bankruptcies_val;
    export boolean include_censusdata      := Include_CensusData_val; // TODO: change to include_Census
    export boolean include_corpaffiliations:= Include_CorporateAffiliations_val;
    export boolean include_controlledsubstances := Include_DEA_Val;
    export boolean include_driversataddress:= IncludeDriversAtAddress_val;
    export boolean include_driverslicenses := Include_DriversLicenses_val;
    export boolean include_crimrecords     := Include_CriminalRecords_val;
    export boolean include_crimhistory     := Include_MatrixCriminalHistory_val;
    export boolean include_domains         := Include_InternetDomains_val;
    export boolean include_email           := Include_Email_Addresses_val;
    export boolean include_faaaircrafts    := Include_FAAAircrafts_val;
    export boolean include_faacertificates := Include_FAACertificates_val;
    export boolean include_fbn             := IncludeFBN_val;
    export boolean include_flcrash         := Include_Accidents_val;
    export boolean include_foreclosures    := include_foreclosures_val;
// --- hri ---
    export boolean include_hri             := include_hri_val;
    //export unsigned1 maxhriper_value       := maxHriPer_value;
    export boolean include_huntingfishing  := Include_HuntingFishingLicenses_val;
    export boolean include_imposters       := Include_Imposters_val;
  //export boolean Include_MerchantVessels := Include_MerchantVessels_val; //NOTUSED in CRS
    export boolean include_LiensJudgments  := Include_LiensJudgments_val;
    export boolean include_motorvehicles   := Include_MotorVehicles_val;
    export boolean include_neighbors       := Include_Neighbors_val;
    export boolean include_nod             := include_NoticeOfDefaults_val; // notices of default
    export boolean include_patriot         := IncludePatriot_val; // Global Watch
    export boolean include_peopleatwork	   := Include_PeopleAtWork_val;
    //unsigned3 Max_PeopleAtWork := 50 : stored('MaxPeopleAtWork');
    export boolean include_proflicenses    := Include_ProfessionalLicenses_val;
// --- properties ---
    export boolean include_properties      := Include_Properties_val;
    // not used: boolean Include_PropertiesV2 := false : stored('IncludePropertiesV2');
    export boolean use_currentlyownedproperty := Use_CurrentlyOwnedProperty_value;
    export boolean use_nonsubjectproperty  := Include_PriorProperties_val;
    export boolean include_oldphones       := Include_OldPhones_val;
    export boolean include_phonesplus	     := Include_PhonesPlus_val;
    export boolean include_phonesummary    :=  false : stored('IncludePhoneSummary'); // defined outside of mac_selection
    export boolean include_relatives       := Include_relatives_val;
    export boolean include_rtvehicles      := IncludeRTVeh_val;
    export boolean include_providers       := Include_Providers_val;
    export boolean include_sanctions       := Include_Sanctions_val;
    export boolean include_sexualoffences  := Include_SexualOffenses_val;
    export boolean include_uccfilings      := Include_UCCFilings_val;
    export boolean include_verification    := false : stored('IncludeVerification'); // defined outside of mac_selection
    export boolean include_voters          := Include_VoterRegistrations_val;
    export boolean include_watercrafts     := Include_Watercrafts_val;
    export boolean include_weaponpermits   := Include_WeaponPermits_val;
    export boolean include_criminalindicators := Include_CriminalIndicators_val;
    export boolean include_students           := Include_StudentInformation_val;
		export boolean include_kris    				 :=  false : stored('IncludeKeyRiskIndicators'); // defined outside of mac_selection
		export boolean include_aml_property    :=  false : stored('IncludeAMLProperty'); // defined outside of mac_selection
//For Address Report //?
    export boolean include_businesses        := false : stored('IncludeBusinesses');
    export boolean Include_ResidentialPhones := false : stored('IncludeResidentialPhones');
    export boolean Include_BusinessPhones    := false : stored('IncludeBusinessPhones');
    // export boolean Exclude_ResidentsForAssociatesAddresses_val 			:= false : stored('ExcludeResidentsForAssociatesAddresses');
    boolean Exclude_Sources_val := false : stored('ExcludeSources');
    export boolean include_sources := Include_Them_All or ~Exclude_Sources_val;
    export boolean Include_AddressSourceInfo := false : stored('IncludeAddressSourceInfo');   // defined outside of mac_selection
  end;

  export versions := MODULE (PersonReports.IParam.versions)
    export unsigned1 bankruptcy_version     := min (max (bankruptcyversion,     0), 4);
    export unsigned1 crimrecords_version    := min (max (CriminalRecordVersion, 0), 4);
    export unsigned1 dea_version            := min (max (deaversion,            0), 4);
    export unsigned1 dl_version             := min (max (dlversion,             0), 4);
    export unsigned1 email_version          := min (max (emailversion,          0), 4);
    export unsigned1 liensjudgments_version := min (max (judgmentlienversion,   0), 4);
    export unsigned1 property_version       := min (max (propertyversion,       0), 4);
    export unsigned1 ucc_version            := min (max (uccversion,            0), 4);
    export unsigned1 vehicles_version       := min (max (vehicleversion,        0), 4);
    export unsigned1 voters_version         := min (max (voterversion,          0), 4);

    // those were not used in doxie version

  end;

  export email_options := MODULE //(PersonReports.IParam.emails)
      export unsigned MaxEmailResults := 5 : STORED('MaxEmailResults');;
      export string   EmailSearchTier := '' : STORED('EmailSearchTier');
  end;


END;
/*
// some other options to define.
  unsigned3 Max_Addresses := 1000 : stored('MaxAddresses');
  export boolean   Include_HistoricalNeighbors := false : stored('IncludeHistoricalNeighbors');
  export boolean   Law_Enforcement := false : stored('LawEnforcement');
  export boolean   Legacy_Verified_Value := false : stored('LegacyVerified');

  //Other Selections
  unsigned1 n_phones := 3 : stored('PhonesPerAddress'); // I probably will choose internal name for that: "_nphones"

  export boolean		Use_CurrentlyOwnedVehicles_value := FALSE : stored('UseCurrentlyOwnedVehicles');
*/
