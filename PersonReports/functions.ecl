IMPORT iesp, doxie, ut, Risk_Indicators, doxie_crs, Suppress, census_data, CriminalRecords_Services, PersonReports, std;

/*
  boolean IncludeMotorVehicleV1 {xpath('IncludeMotorVehicleV1')};//hidden[internal]
  boolean IncludeRealTimeVehicles {xpath('IncludeRealTimeVehicles')};
  string RealTimePermissibleUse {xpath('RealTimePermissibleUse')}; //values['','Government','LawEnforcement','Parking','VerifyFraudOrDebt','Litigation','InsuranceClaims','InsuranceUnderwriting','TowedAndImpounded','PrivateToll','']
  string DateRange {xpath('DateRange')}; //values['0','1','12','24','36','48','']//hidden[internal]
  */  

EXPORT functions := MODULE
  // saves options from ESDL input into global storage for subsequent old-style reading;
  // for existing input parameters legacy names must be used here 
  // TODO: worth creating constant literals for SOAP names?
  // TODO: this code must be executed only in ESDL mode! So far I can't accomplish this
  // NB: careful: some ESDL-standard options (glb, dppa, etc.) are stored through iesp@ECL2EP
  EXPORT SetInputSearchOptions (PersonReports.input._compoptions m_esdl) := FUNCTION
    // this is to zero down as much as possible from SOAP header options
    #stored ('SelectIndividually', true);

    #stored ('IncludeBPSAddress',        m_esdl.include_bpsaddress); //new
    #stored ('ReturnAllImposters',       m_esdl.return_allimposterrecords); //new
    #stored ('IndicateUnpub',            m_esdl.indicate_restricted); // new

    #stored ('IncludeAccidents', m_esdl.include_flcrash);
    #stored ('IncludeAKAs', m_esdl.include_AKAs);
    #stored ('IncludeAssociates', m_esdl.include_associates);
    #stored ('IncludeBankruptcies', m_esdl.include_bankruptcy);
        #stored ('BankruptcyVersion', m_esdl.bankruptcy_version);
    #stored ('IncludeBestInfo', m_esdl.include_best);
    #stored ('IncludeCensusData', m_esdl.include_CensusData);
    #stored ('IncludeCivilCourts', m_esdl.include_civilcourts);
    #stored ('IncludeCorporateAffiliations', m_esdl.include_corpaffiliations);
    #stored ('IncludeCriminalRecords', m_esdl.include_crimrecords);
        #stored ('CriminalRecordVersion', m_esdl.crimrecords_version);
    #stored ('IncludeDEARecords', m_esdl.include_controlledsubstances);
        #stored ('DeaVersion', m_esdl.dea_version);
    #stored ('IncludeDriversAtAddress', m_esdl.include_driversataddress);
    #stored ('IncludeDriversLicenses', m_esdl.include_DriversLicenses);
        #stored ('DlVersion', m_esdl.dl_version);
    #stored ('IncludeEmailAddresses', m_esdl.include_email);
    #stored ('IncludeFAACertificates', m_esdl.include_FAACertificates);
    #stored ('IncludeFAAAircrafts', m_esdl.include_faaaircrafts);
    #stored ('IncludeFBN', m_esdl.include_fbn);
    #stored ('IncludeFirearmsAndExplosives', m_esdl.include_atf);
    #stored ('IncludeForeclosures', m_esdl.include_Foreclosures);
    #stored ('IncludeHealthCareProviders', m_esdl.include_providers);
        #stored ('IncludeGroupAffiliations', m_esdl.include_groupaffiliations); //see Doxie@Prov_records
        #stored ('IncludeHospitalAffiliations', m_esdl.include_hospitalaffiliations);
        #stored ('IncludeEducation', m_esdl.include_education);
        #stored ('IncludeBusinessAddress', m_esdl.include_businessaddress);
    #stored ('IncludeHealthCareSanctions', m_esdl.include_sanctions);
    #stored ('IncludeHRI', m_esdl.include_hri);
    #stored ('IncludeHuntingFishingLicenses', m_esdl.include_huntingfishing);
    #stored ('IncludeImposters', m_esdl.include_imposters);
    #stored ('IncludeInternetDomains', m_esdl.include_domains);
    #stored ('IncludeLiensJudgments', m_esdl.include_LiensJudgments);
        #stored ('JudgmentLienVersion', m_esdl.liensjudgments_version);
    #stored ('IncludeMatrixCriminalHistory', m_esdl.include_crimhistory);
    #stored ('IncludeMerchantVessels', m_esdl.include_merchantvessels);
    #stored ('IncludeMotorVehicles', m_esdl.include_MotorVehicles);
        #stored ('VehicleVersion', m_esdl.vehicles_version);
    #stored ('IncludeNeighbors', m_esdl.include_neighbors);
        #stored ('NeighborhoodCount', m_esdl.neighborhoods);
				#stored ('MaxNeighborhoods', m_esdl.neighborhoods); //Used leagacy MaxNeighborhoods to fetch the right input from interface.Refer to -> doxie_crs.nbr_records
        #stored ('NeighborsPerAddress', m_esdl.neighbors_per_address);
        #stored ('AddressesPerNeighbor', m_esdl.addresses_per_neighbor);
        #stored ('IncludeHistoricalNeighbors', m_esdl.include_historicalneighbors);
        #stored ('NeighborsPerNA', m_esdl.neighbors_per_na);
        #stored ('NeighborRecency', m_esdl.neighbors_recency);
    #stored ('IncludeNoticeOfDefaults', m_esdl.include_nod);
    #stored ('IncludeOldPhones', m_esdl.include_oldphones);
    #stored ('IncludePatriot', m_esdl.include_patriot);
    #stored ('IncludePeopleAtWork', m_esdl.include_peopleatwork);
    #stored ('IncludePhoneSummary', m_esdl.include_phonesummary);
    #stored ('IncludeProfessionalLicenses', m_esdl.include_proflicenses);
    #stored ('IncludeProperties', m_esdl.include_properties);
        #stored ('PropertyVersion', m_esdl.property_version);
        #stored ('IncludeCurrentProperties', m_esdl.use_currentlyownedproperty);
        #stored ('IncludePriorProperties', m_esdl.use_nonsubjectproperty);
    #stored ('IncludePhonesPlus', m_esdl.include_PhonesPlus);
    #stored ('IncludePhonesFeedback', m_esdl.include_phonesfeedback);
    #stored ('IncludeRelatives', m_esdl.include_relatives);
        #stored ('RelativeDepth', m_esdl.relative_depth);
        #stored ('MaxRelatives', m_esdl.max_relatives);
        #stored ('IncludeRelativeAddresses', m_esdl.include_relativeaddresses);
        #stored ('MaxRelativeAddresses', m_esdl.max_relatives_addresses);
    #stored ('IncludeSexualOffenses', m_esdl.include_sexualoffences);
    #stored ('IncludeUCCFilings', m_esdl.include_UCCFilings);
        #stored ('UccVersion', m_esdl.ucc_version);
    #stored ('IncludeVerification', m_esdl.include_verification);
    #stored ('IncludeVoterRegistrations', m_esdl.include_voters);
        #stored ('VoterVersion', m_esdl.voters_version);
    #stored ('IncludeWaterCrafts', m_esdl.include_WaterCrafts);
    #stored ('IncludeWeaponPermits', m_esdl.include_WeaponPermits);
  // boolean DoPhoneReport {xpath('DoPhoneReport')};
  // boolean LawEnforcement {xpath('LawEnforcement')};
   //boolean PruneAgedSSNs {xpath('PruneAgedSSNs')};//hidden[lndayton]
    //#stored ('MaxAddresses', m_esdl.MaxAddresses);
    #stored ('LegacyVerified', m_esdl.legacy_verified);
    #stored ('ExcludeSources', ~m_esdl.include_sources);
    #stored ('IncludeCriminalIndicators', m_esdl.include_criminalindicators);
    #stored ('IncludeStudentInformation', m_esdl.include_students);
		#stored ('IncludeAMLProperty', m_esdl.include_aml_property);
		#stored ('IncludeKeyRiskIndicators', m_esdl.include_kris);
    return output (dataset ([],{integer x}), named('__internal__'), extend);
  end;

  

  // reads options from ESDL-input;
  // returns a module encapsulating them (will allow us to by-pass reading from "stored" later, if we'd want to).
  // TODO: specify return type
  EXPORT GetInputOptions (iesp.smartlinxreport.t_SmartLinxReportOption tag) := FUNCTION
    customer_ver := 0.0; //TODO: read from input XML
    options := module

      // Choose defaults, when defined (syntax Self := options_def would be nice to have
      export boolean include_akas               := tag.IncludeAKAs;
      export boolean include_associates         := tag.IncludeAssociates;
      export boolean include_atf                := tag.IncludeFirearmExplosives;
      export boolean include_bankruptcy         := tag.IncludeBankruptcies;
      export boolean include_best               := tag.IncludeBestInfo;
      export boolean include_censusdata         := tag.IncludeCensusData;
      export boolean include_civilcourts        := tag.IncludeCivilCourts;
      export boolean include_controlledsubstances := tag.IncludeDEAControlledSubstance;
      export boolean include_corpaffiliations   := tag.IncludeCorporateAffiliations;
      export boolean include_crimrecords        := tag.IncludeCriminalRecords;
      shared string str_crimhistory := trim (tag.IncludeMatrixCriminalHistory);
      export boolean include_crimhistory           := (str_crimhistory = 'yes') or (str_crimhistory = 'full');
      // export boolean include_relativescrimhistory  := (str_crimhistory = 'full'); only in ESP
      export boolean include_domains            := tag.IncludeInternetDomains;
      export boolean include_driverslicenses    := tag.IncludeDriversLicenses;
      export boolean include_driversataddress   := false;//tag.IncludeDriversAtAddress;
      export boolean include_email              := tag.IncludeEmailAddresses;
      export boolean include_faaaircrafts       := tag.IncludeFAAAircrafts;
      export boolean include_faacertificates    := tag.IncludeFAACertificates;
      export boolean include_fbn                := tag.IncludeFictitiousBusinesses;
      export boolean include_flcrash            := tag.IncludeAccidents;
      export boolean include_foreclosures       := tag.IncludeForeclosures;
      export boolean include_hri                := tag.IncludeHighRiskIndicators;
      export boolean include_huntingfishing     := tag.IncludeHuntingFishingLicenses;
      export boolean include_imposters          := tag.IncludeImposters;
      export boolean include_includeoldphones   := tag.IncludeOldPhones;
      export boolean include_liensjudgments     := tag.IncludeLiensJudgments;
      //export boolean include_merchantvessels    := tag.IncludeMerchantVessels; // not used in CRS
      export boolean include_motorvehicles      := tag.IncludeMotorVehicles;
      export boolean include_neighbors          := tag.Neighbors.IncludeNeighbors;
          export boolean include_historicalneighbors := tag.Neighbors.IncludeHistoricalNeighbors;
          export unsigned1 neighborhoods             := min (max (tag.Neighbors.NeighborhoodCount, 0), iesp.Constants.BR.MaxNeighborhood);
          export unsigned1 historical_neighborhoods  := min (max (tag.Neighbors.HistoricalNeighborhoodCount, 0), iesp.Constants.BR.MaxHistoricalNeighborhood);
          // TODO: mapping: ESP also defines NeighborCount, HistoricalNeighborCount
           export unsigned1 neighbors_per_address     := tag.Neighbors.NeighborCount;
          // export unsigned1 addresses_per_neighbor    := 10;
          // export unsigned1 neighbors_per_na          := 10;
          // export unsigned1 neighbors_recency    := tag.Neighbors.
      export boolean include_nod                := tag.IncludeNoticeOfDefaults;
      export boolean include_phonesummary       := false;//tag.IncludePhoneSummary;
      export boolean include_patriot            := false;//tag.IncludeGlobalWatchLists;
      export boolean include_phonesfeedback     := tag.IncludePhonesFeedback;
      export boolean include_proflicenses       := tag.IncludeProfessionalLicenses;
      export boolean include_properties         := tag.IncludeProperties;
      export boolean use_nonsubjectproperty     := tag.IncludePriorProperties;
      export boolean use_currentlyownedproperty := tag.IncludeCurrentProperties;
      // shared hcp := tag.HealthCareProviders;
       export boolean include_providers          := tag.IncludeHealthCareProviders ;//or hcp.IncludeHealthCareProviders;
          // export boolean include_groupaffiliations    := hcp.IncludeGroupAffiliations;
          // export boolean include_hospitalaffiliations := hcp.IncludeHospitalAffiliations;
          // export boolean include_education            := hcp.IncludeEducation;
          // export boolean include_businessaddress      := hcp.IncludeBusinessAddress;
      export boolean include_sanctions          := tag.IncludeHealthCareSanctions;
      export boolean include_peopleatwork       := tag.IncludePeopleAtWork;
      export boolean include_phonesplus         := tag.IncludePhonesPlus;
      //export boolean include_a := tag.DoPhoneReport;
      export boolean include_relatives          := tag.Relatives.IncludeRelatives; // RELATIVES SECTION
          export unsigned1 relative_depth           := min (max (tag.Relatives.RelativeDepth, 1), 3);
          export unsigned1 max_relatives            := min (tag.Relatives.MaxRelatives, iesp.Constants.SMART.MaxRelatives);
          export boolean include_relativeaddresses  := tag.Relatives.IncludeRelativeAddresses;
          export unsigned1 max_relatives_addresses  := min (tag.Relatives.MaxRelativeAddresses, iesp.Constants.BR.MaxRelatives_Address);
      export boolean include_sexualoffences     := tag.IncludeSexualOffenses;
      export boolean include_sources            := tag.IncludeSourceDocs;
      export boolean include_uccfilings         := tag.IncludeUCCFilings;
      export boolean include_verification       := false;//tag.IncludeVerification;
      export boolean include_voters             := tag.IncludeVoterRegistrations;
      export boolean include_watercrafts        := tag.IncludeWaterCrafts;
      export boolean include_weaponpermits      := tag.IncludeWeaponPermits;
      export boolean include_criminalindicators := tag.IncludeCriminalIndicators;
			export boolean include_students           := tag.IncludeStudentInformation;
			export boolean include_aml_property      	:= tag.IncludeAMLProperty;
			export boolean include_kris           		:= tag.IncludeKeyRiskIndicators;
      // export boolean include_a := tag.LawEnforcement;
      // export boolean include_a  := tag.PruneAgedSSNs;
      //export boolean include_a := tag.MaxAddresses;
      // export boolean include_a := tag.LegacyVerified;

      // versioning (TODO: define MaxVersionNumber? BankruptcyVersion
      shared ver := iesp.ECL2ESP.version (customer_ver);
      export unsigned1 bankruptcy_version     := min (max (ver.Bankruptcy     , 0), 4);
      export unsigned1 crimrecords_version    := min (max (ver.CriminalRecord , 0), 4);
      export unsigned1 dea_version            := min (max (ver.DEA            , 0), 4);
      export unsigned1 dl_version             := min (max (ver.Dl             , 0), 4);
      export unsigned1 liensjudgments_version := min (max (ver.JudgmentLien   , 0), 4);
      export unsigned1 property_version       := min (max (ver.Property       , 0), 4);
      export unsigned1 ucc_version            := min (max (ver.UCC            , 0), 4);
      export unsigned1 vehicles_version       := min (max (ver.Vehicles       , 0), 4);
      export unsigned1 voters_version         := min (max (ver.Voters         , 0), 4);
 
      // those are not real versioning: they are used to suppress sections and/or counts
      export unsigned1 en_version             := min (max (ver.En             , 0), 1);
      export unsigned1 phonesplus_version     := min (max (ver.PhonesPlus     , 0), 1);
      export unsigned1 proflicense_version    := min (max (ver.ProfLicense    , 0), 1);
      export unsigned1 statedeath_version     := min (max (ver.StateDeath     , 0), 1);
      export unsigned1 targus                 := min (max (ver.Targus         , 0), 1);

			// relationship
			export boolean   relationship_highConfidenceRelatives  := tag.relationshipOption.HighConfidenceRelatives;
			export boolean   relationship_highConfidenceAssociates := tag.relationshipOption.HighConfidenceAssociates;
			export unsigned2 relationship_relLookbackMonths        := tag.relationshipOption.RelativeLookBackMonths;
			export string24  relationship_transAssocMask           := tag.relationshipOption.TransactionalAssociatesMask;
    end;

    // unfortunately, I can't take immutable -- for CRS -- defaults in a manner like this:
    // res := module (project (options, PersonReports.input.default_options_crs, opt)) end;
    //SetInputSearchOptions (res);  // can't make this call by some reasons 
    return options;
  END;

  //debug
  EXPORT GetCRSOptionsDataset (PersonReports.input._compoptions options) := dataset ([
    {'select_individually', options.select_individually},
    {'REPORT', ''},
    {'    GLBPurpose', options.GLBPurpose},
    {'    DPPAPurpose', options.DPPAPurpose},
    {'    ssn_mask', options.ssn_mask},
    {'    legacy_verified', options.legacy_verified},
    {'    record_by_date', options.record_by_date},
    {'    ln_branded', options.ln_branded},
    {'    score_threshold', options.score_threshold},
    {'    exact_sec_range_match', options.exact_sec_range_match},
    {'    address_recency_days', options.address_recency_days},
    {'    include_hri', options.include_hri},
    {'NEIGHBORS', ''},
    {'    neighborhoods', options.neighborhoods},
    {'    historical_neighborhoods', options.historical_neighborhoods},
    {'    neighbors_per_address', options.neighbors_per_address},
    {'    addresses_per_neighbor', options.addresses_per_neighbor},
    {'    neighbors_per_na', options.neighbors_per_na},
    {'    neighbors_recency', options.neighbors_recency},
    {'    neighbors_proximity', options.neighbors_proximity},
    {'    nbrs_with_phones', options.nbrs_with_phones},
    {'    use_verified_address_nb', options.use_verified_address_nb},
    {'    use_bestaka_nb', options.use_bestaka_nb},
    {'    neighbors_proximity', options.neighbors_proximity},
    {'PHONES', ''},
    {'    indicate_restricted', options.indicate_restricted},
    {'    include_phonesfeedback', options.include_phonesfeedback},
    {'RELATIVES', ''},
    {'    relative_depth', options.relative_depth},
    {'    max_relatives', options.max_relatives},
    {'    include_relativeaddresses', options.include_relativeaddresses},
    {'    max_relatives_addresses', options.max_relatives_addresses},
    {'    rels_with_phones', options.rels_with_phones},
    {'    use_verified_address_ra', options.use_verified_address_ra},
    {'    use_bestaka_ra', options.use_bestaka_ra},
    {'IMPOSTERS', ''},
    {'    return_AllImposterRecords', options.return_AllImposterRecords},

    {'include_akas', options.include_akas},
    {'include_alsofound', options.include_alsofound}, //was not defined in "standard" doxie-selection.
    {'include_associates', options.include_associates},
    {'include_atf', options.include_atf},
    {'include_bankruptcy', options.include_bankruptcy},
    {'include_best', options.include_best},
    {'include_boaters', options.include_boaters},
    {'include_bpsaddress', options.include_bpsaddress}, //was not defined in "standard" doxie-selection.
    {'include_censusdata', options.include_censusdata},
    {'include_civilcourts', options.include_civilcourts},
    {'include_corpaffiliations', options.include_corpaffiliations},
    {'include_controlledsubstances', options.include_controlledsubstances}, //aka DEA
    {'include_crimrecords', options.include_crimrecords},
    {'include_crimhistory', options.include_crimhistory}, //aka DOC
    {'include_deceased', options.include_deceased},
    {'include_domains', options.include_domains},
    {'include_driversataddress', options.include_driversataddress},
    {'include_driverslicenses ', options.include_driverslicenses},
    {'include_email', options.include_email},
    {'include_eq', options.include_eq}, //Equifax?
    {'include_faaaircrafts', options.include_faaaircrafts},
    {'include_faacertificates', options.include_faacertificates},
    {'include_fbn', options.include_fbn}, // fictitious business names
    {'include_flcrash ', options.include_flcrash},
    {'include_foreclosures', options.include_foreclosures},
    {'include_huntingfishing ', options.include_huntingfishing},
    {'include_imposters', options.include_imposters},
    {'include_liensjudgments', options.include_liensjudgments},
    {'include_merchantvessels', options.include_merchantvessels},
    {'include_motorvehicles', options.include_motorvehicles},
    {'include_neighbors', options.include_neighbors},
    {'include_nod', options.include_nod}, // notice of default
    {'include_patriot', options.include_patriot}, // global watch
    {'include_peopleatwork ', options.include_peopleatwork},
    {'include_phonesplus', options.include_phonesplus},
    {'include_phonesummary', options.include_phonesummary},
    {'include_providers', options.include_providers},
    {'include_oldphones', options.include_oldphones},
    {'include_proflicenses', options.include_proflicenses},
    {'include_properties ', options.include_properties},
    {'include_relatives ', options.include_relatives},
    {'include_sanctions', options.include_sanctions},
    {'include_sexualoffences', options.include_sexualoffences},
    {'include_uccfilings', options.include_uccfilings},
    {'include_verification', options.include_verification},
    {'include_voters', options.include_voters},
    {'include_watercrafts', options.include_watercrafts},
    {'include_weaponpermits ', options.include_weaponpermits}, // aka CCW?
    {'include_criminalindicators ', options.include_criminalindicators},
    {'include_sources ', options.include_sources},
    {'VERSIONS ', ''},
    {'bankruptcy_version ', options.bankruptcy_version},
    {'crimrecords_version ', options.crimrecords_version},
    {'dea_version ', options.dea_version},
    {'dl_version ', options.dl_version},
    {'liensjudgments_version ', options.liensjudgments_version},
    {'property_version ', options.property_version},
    {'ucc_version ', options.ucc_version},
    {'vehicles_version ', options.vehicles_version},
    {'voters_version ', options.voters_version}
  ], {string32 option, string32 value});

      // export resi := project (doxie.Resident_Records, transform (layout_comp_names, self.age := GetAge (left.dob), self :=left));

  export layouts.identity_bps ExpandIdentity (layouts.identity_slim L) := transform
    Self := L;
    Self := [];
  end;

  export Address (input.personal in_params) := MODULE

    export string GetLocationID (iesp.share.t_AddressEx addr) := function
      string str_addr := trim (addr.City) + ';' + trim (addr.State) + ';' + trim (addr.StreetName) + ';' + 
                         trim (addr.StreetNumber) + ';' + trim (addr.StreetPostDirection) + ';' + 
                         trim (addr.StreetSuffix) + ';' + trim (addr.UnitDesignation) + ';' + 
                         trim (addr.StreetPreDirection) + ';' + trim (addr.UnitNumber) + ';' + trim (addr.Zip5) + ';' + 
                         trim (addr.Zip4);
      // ESP in addition encodes it, but cleaned input address shouldn't contain XML-invalid characters.
      return str_addr;
    end; 

    // To assisst phones-linking, add residents to the list of addresses: some residents are missing
    // from the list of addresses.
    // returns: dataset (doxie.layout_comp_addresses)
    export ExpandWithResidents (dataset (doxie.layout_comp_addresses) addr, 
                                dataset (PersonReports.layouts.comp_names) residents) := function

      doxie.layout_comp_addresses CreateAddress (doxie.layout_comp_addresses L, PersonReports.layouts.comp_names R) := transform
        Self.address_seq_no := PersonReports.Constants.APPENDED_BY_RESIDENTS; // simply to make adds-on unique
        Self.isSubject := false; // we will never ever add subject here.
        Self := R;
        Self := L;
      end;

      // I'm deliberately avoiding full outer join here, explicit sum looks more clear
      residents_plus := join (addr, dedup (sort (residents, address_seq_no, lname), address_seq_no, lname),
                              Left.address_seq_no = Right.address_seq_no and 
                             (Left.lname != Right.lname) and
        // minor improvement, accounts for name variations: for instance, for did=001813614478
        // [residents] and [comp_addresses] produce name varitions for person with did=836898021
                             (Left.did = 0 or Right.did = 0 or (Left.did != Right.did)), 
                             CreateAddress (Left, Right), 
                             limit (iesp.Constants.BR.MaxAddress_Residents, skip));

      // extra residents may introduce duplicates, since input may have same address mentioned more than once.
      res_ddp := dedup (residents_plus, lname, zip, prim_name, prim_range, sec_range, all);
      return addr + res_ddp;
      // Note: generally, result still may contain redundant records with a fake sequence, 
      //       but the benefit of having new last names is essential.
    end;


    export AttachPhones (dataset (doxie.layout_comp_addresses) addr,
                         dataset (PersonReports.layouts.phones_rec) phor) := function

      // Address-phone linking logic in short:
      // 1. addresses are joined with the phones (generally, ignoring sec range) and verified;
      // 2. group-rolled by unique address (counting sec range), collecting all phones and applying specific matching logic;
      // 3. joined back to original input adresses (TODO: check if this can be avoided by using left outer in 1)

      PersonReports.layouts.rec_wide GetPhones (doxie.layout_comp_addresses L, PersonReports.layouts.phones_rec R) := transform
        boolean date_matched := (L.dt_last_seen = 0 or ut.Age(L.dt_last_seen * 100) < 5); //2a - not positive about the zero here, but want to be conservative to start

        boolean IsNameMatched := (ut.StringSimilar100 (L.lname, R.lname) <= 30) or
                                 ut.isNamePart (R.lname, trim (L.lname), true) or
                                 (R.lname = '' and length(trim(L.lname)) > 1 and
                                 ut.isNamePart (R.listing_name, trim (L.lname), true));

        Self.name_matched := IsNameMatched;

        // check for unpublished phones (they will be filtered later)
        Self.phone := if (R.publish_code = 'N' or R.omit_phone = 'Y', 'UNPUB', R.phone); 
        boolean isVerified := IsNameMatched and date_matched;
        Self.sequence_verified := if (isVerified, L.address_seq_no, 0);
        Self.is_subject_verified := isVerified and L.isSubject;
        // do I need to keep 'tnt' field at all?
        Self.tnt := if (R.zip <> '' and isVerified, 'V', 'H'),  //V triggers a verified address, but tnt is not exposed past ESP
        Self.phone_sec_range := R.sec_range;
        Self.feedback := R.feedback; // this must be from phones (both phones and addresses have it)
        Self := L; // address components, dates seen
        Self := R; // listing name, publishing, other phone data, name_first, name_last
      end;

      // take (prefetched) phones -- probable candidates, including unlisted.
     addr_w_phones := join (addr, phor,
                             Left.prim_range=Right.prim_range and 
                             Left.prim_name=Right.prim_name and
                             Left.zip = Right.zip and
                             ((in_params.exact_sec_range_match and (Left.sec_range = Right.sec_range)) or // exact match
                             ut.NNEQ (Left.sec_range, Right.sec_range)), //relaxed
                             // TODO: define better limit
                             GetPhones (Left, Right), limit (100, skip));

      // Now roll it up to have phones as a child dataset for every address
      // NB: sequence can't be used, since there can be multiple verified phones per address
      addr_grp := group (sort (addr_w_phones, prim_range, prim_name, zip, sec_range, if (tnt = 'V', 0, 1)),
                                              prim_range, prim_name, zip, sec_range);

      t_BpsReportPhone_seq := record (iesp.bpsreport.t_BpsReportPhone)
        integer sequence_verified;
        boolean is_subject_verified;
      end;

      t_BpsReportPhone_seq SetPhonesChild (PersonReports.layouts.rec_wide L):=transform
        Self.sequence_verified := L.sequence_verified;
        Self.is_subject_verified := L.is_subject_verified;
        // take whatever is there already, don't spent any efforts for parsing: ESP will take listing anyway.
        Self.Name := iesp.ECL2ESP.SetName (L.name_first, '', L.name_last, '', '');
        Self.Phone10 := L.phone;
        Self.TimeZone := L.timezone; 
        Self.PubNonpub := l.publish_code; //TODO: what about omit_phone = 'Y'?
        Self.ListingName := L.listing_name;
        Self.CompanyName := if (L.business_flag, L.listing_name, '');
        Self.HighRiskIndicators := project (L.hri_Phone, iesp.ECL2ESP.FormatRiskIndicators (Left));
        // note: phones feedback is defined as dataset, not row
        fb := L.feedback [1];
        fback := ROW ({fb.feedback_count, fb.Last_Feedback_Result, (string8) fb.Last_Feedback_Result_Provided}, 
                      iesp.phonesfeedback.t_PhonesFeedback);
        Self.phonefeedback := if (in_params.Include_PhonesFeedback, fback);
      END;

      rec_addr_phones := record
        doxie.Layout_Comp_Addresses.address_seq_no;
        boolean IsVerified;
        doxie.Layout_Comp_Addresses.prim_range;
        doxie.Layout_Comp_Addresses.prim_name;
        doxie.Layout_Comp_Addresses.zip;
        doxie.Layout_Comp_Addresses.sec_range;
        doxie.Layout_Comp_Addresses.predir;
        // should be same constant as in phones-wild
        dataset (t_BpsReportPhone_seq) phones {MAXCOUNT(ut.limits.PHONE_PER_ADDRESS * 5)};
      end;


      rec_addr_phones RollPhones (PersonReports.layouts.rec_wide L, dataset (PersonReports.layouts.rec_wide) all_phones) := transform
        boolean is_verified := L.TNT = 'V';//(L.TNT='B' or l.TNT='V');
        Self.IsVerified := is_verified;

/*
// this is according to latest Lisa's e-mail
CURRENT addresses (subject's, relatives', neighbors', last names exists in comp_address):
1) if address has sec_range, then
      a) if found Gong records by sec_range,  done; otherwise
      b) fetch all Gong, return only phones matched by last name

2) if there is no sec_range
      fetch Gong (only those without a sec_range), return only phones matched by last name
      (Smith in apartment building in NY may bring false positives here)
Set "verified" or "not verified" according to the last name.

HISTORICAL addresses (so far subject's only, no last name)
1) if address has sec_range, then
      a) if found Gong records by sec_range,  done;
2) if address has no sec_range, then
      a) return records from gong with no sec_range
*/

        phs := all_phones (phone != '');
        phs_by_range := phs (phone_sec_range = L.sec_range);
        phs_by_name  := phs (name_matched);
        // I don't have better definition of "historical address" at this point, maybe ~is_verified would be enough.
        boolean IsHistorical := L.IsSubject and ~is_verified;

        phones_child := IF (L.sec_range != '',
                            IF (exists (phs_by_range), phs_by_range, IF (~IsHistorical, 
                                                                         phs_by_name, 
                                                                         if (in_params.include_nonresidents_phones, phs))),
                            IF (IsHistorical, 
                                if (in_params.include_nonresidents_phones, phs_by_range),
                                phs_by_range (name_matched)));

        // there may be a problem with historical addresses, if last name is the same as subject's
        // (Bonnie's case): same last name people living at a previous address

      //  phones_done := choosen (dedup (phones_child, phone, listing_name, all), iesp.Constants.BR.MaxAddress_Phones);
        // Self.Phones := project (phones_done, SetPhonesChild (Left));
        Self.Phones := project (phones_child, SetPhonesChild (Left));
        Self := L; //address_seq_no, address components: prim_range, prim_name, zip, sec_range, predir
      end;
 
       phones_ready := ROLLUP (addr_grp, GROUP, RollPhones (Left, ROWS (Left)));

      // now we have unique set of addresses with all relevant phones filled in; join back to original addresses

      iesp.share.t_RiskIndicator SetAddressRiskIndicators (Risk_Indicators.Layout_Desc L) := transform
        Self.RiskCode := L.hri;
        Self.Description := L.desc;
      end;

      PersonReports.layouts.slim_addr_rec AttachPhones (doxie.Layout_Comp_Addresses L, rec_addr_phones R) := transform
        Self.did := L.did;
        Self.address_seq_no := L.address_seq_no;
        Self.county := L.county;
        Self.geo_blk := L.geo_blk;
       
        ri := project (L.hri_address, SetAddressRiskIndicators (Left));
        Self.Address := iesp.ECL2ESP.SetAddressEx (
          L.prim_name, L.prim_range, L.predir, L.postdir, L.suffix, L.unit_desig, L.sec_range, 
          L.city_name, L.st, L.zip, L.zip4, L.county_name, HRIs := ri);
        Self.LocationId := GetLocationID (Self.Address);
        Self.DateLastSeen  := iesp.ECL2ESP.toDate ((unsigned4) (L.dt_last_seen + '00'));
        Self.DateFirstSeen := iesp.ECL2ESP.toDate ((unsigned4) (L.dt_first_seen + '00'));
        Self._Shared := (L.shared_address='S');

        // what can happen here: "this" address can actually be 'verified' by a last name from a
        // "different" address -- same address with different sequence. This is the case of associates
        // (including spouses having different last names), relatives (who used to live at this address at some point).
        // To avoid verification of non-current addresses, "recency" must be used.
        phones_verificators := R.phones(sequence_verified = L.address_seq_no or 
                                (is_subject_verified and (ut.DaysApart ((STRING)Std.Date.Today(), L.dt_last_seen + '00') < in_params.address_recency_days)));
        Self.Verified := R.IsVerified and exists (phones_verificators);

        // there can be duplicates -- for example, spouses with the same last name
        phones := dedup (R.phones (in_params.indicate_restricted or (Phone10 != 'UNPUB')), Phone10, ListingName, all);
        // phones := R.phones (in_params.indicate_restricted or (Phone10 != 'UNPUB'));
        Self.Phones := choosen (project (phones, iesp.bpsreport.t_BpsReportPhone), iesp.Constants.BR.MaxAddress_Phones);
      end;

      addr_phones_ready := join (addr, phones_ready,
                                    // Left.address_seq_no=Right.address_seq_no,
                                    Left.prim_range=Right.prim_range and 
                                    Left.prim_name=Right.prim_name and
                                    Left.zip = Right.zip and
                                    Left.sec_range = Right.sec_range,
                                    AttachPhones (Left, Right), left outer); //at most 1:1
      // ---------- Now have addresses with phones ----------
			    // output(addr_w_phones);
			    // output(phones_ready);
			    // output(addr_phones_ready);
      return addr_phones_ready;
    end;

    // Census information
    export dataset (PersonReports.layouts.address_bps) AddCensus (dataset (PersonReports.layouts.address_bps) addr) := function
      addr_census := JOIN (addr, census_data.Key_Smart_Jury,
                           keyed (left.AddressEx.State=right.stusab and
                           left.county = right.county and 
                           left.geo_blk[1..6] = right.tract and 
                           left.geo_blk[7]=right.blkgrp),
                           transform (PersonReports.layouts.address_bps, Self.CensusData := iesp.ECL2ESP.ProjectCensus (Right),
                                                           Self := Left),
                           left outer, keep(1));
      return addr_census;
    end;

    // add residents to the base addresses; produces complete address layout
    export dataset (PersonReports.layouts.address_bps) AddResidents (dataset (PersonReports.layouts.slim_addr_rec) addr,
																																		dataset (PersonReports.layouts.identity_bps_rolled) residents) := function

      PersonReports.layouts.address_bps AddResidents (PersonReports.layouts.slim_addr_rec L, PersonReports.layouts.identity_bps_rolled R) := transform
        Self.residents := R.akas; //'choosen' was already done
        Self.AddressEx := L.Address,
        Self.Address := [], // TODO: slim down Left.Address 
        Self.LocationId := GetLocationID (L.Address);

        Self := L; //did, seq_no, Address, DateLastSeen, DateFirstSeen, _Shared, Verified, Phones, countyn, geo_blk
        Self := []; //Census_Data, Properties, Properties2
      end;
      addr_res := JOIN (addr, residents,
                        Left.address_seq_no = Right.address_seq_no,
                        AddResidents (Left, Right), left outer);
      return addr_res;
    end;


    // add residents to the base addresses; produces slim address layout
    export dataset (PersonReports.layouts.address_slim) AddResidentsSlim (dataset (PersonReports.layouts.slim_addr_rec) addr,
																																				dataset (PersonReports.layouts.identity_slim_rolled) residents) := function

      PersonReports.layouts.address_slim AddResidents (PersonReports.layouts.slim_addr_rec L, PersonReports.layouts.identity_slim_rolled R) := transform
        Self.residents := R.akas; //'choosen' was already done
        Self := L; //did, seq_no, Address, DateLastSeen, DateFirstSeen, _Shared, Verified, Phones, countyn, geo_blk
      end;
      addr_res := JOIN (addr, residents,
                        Left.address_seq_no = Right.address_seq_no,
                        AddResidents (Left, Right), left outer);
      return addr_res;
    end;

    // TODO: a place holder; signature isn't clear yet
    export dataset (PersonReports.layouts.address_bps) AddProperty (dataset (PersonReports.layouts.address_bps) addr) := function
      return addr;
    end;

  END;

  export unsigned1 GetAge (integer4 dob) := IF (dob<>0, ut.Age(dob),0);

//  export layouts.identity_slim GetDeadInfo (layouts.identity_slim L, doxie.key_death_masterV2_DID R):= transform
  export PersonReports.layouts.identity_slim GetDeadInfo (PersonReports.layouts.identity_slim L, doxie_crs.layout_deathfile_records R):= transform
        // there can be different DOB in key_death_masterV2_DID and source dataset (for example: DID=002644313020),
        // thus it is safer to take DOB from the left side
        left_dob := (string4) L.DOB.year + intformat (L.DOB.month, 2, 1) + intformat (L.DOB.day, 2, 1);
        u_doB := (unsigned) if (L.DOB.year != 0 and L.DOB.month != 0, left_dob, r.dob8);
        u_doD := (unsigned) r.dod8;
        Self.DOD := iesp.ECL2ESP.toDatestring8 (r.dod8);
        Self.DeathVerificationCode := r.vorp_code; //death_code in header index
        Self.AgeAtDeath := if (u_doD = 0 or L.age = 0, 0, ut.Age (u_doB, u_doD));
        Self.DeathCounty := R.county_name;
        Self.DeathState := R.state;
        self.Deceased := if ( r.did != '', 'Y','N');
        // make a copy of SSNInfoEx: this must go away eventually when ESDL will be fixed
        Self.SSNInfo := project (L.SSNInfoEx, transform (iesp.share.t_SSNInfo, Self := Left,Self:=[];));
        Self := L;
      END;
			
shared layout_names_HRI := record
	        PersonReports.layouts.comp_names;
					personReports.layouts.ssn_hri_rec and not [did, ssn];
        end;

  export  PersonReports.layouts.identity_slim AddIssuance (layout_names_HRI L, doxie_crs.layout_SSN_Lookups R):=transform
        Self.did := L.did;
        Self.address_seq_no := L.address_seq_no;
        Self.UniqueID := intformat (L.did, 12, 1);
        Self.Name := iesp.ECL2ESP.SetName (L.fname, L.mname, L.lname, L.name_suffix, '');
        Self.Gender := '';
        IssuedStart := iesp.ECL2ESP.toDate (R.ssn_issue_early);
        IssuedEnd   := iesp.ECL2ESP.toDate (R.ssn_issue_last);
        Self.SSNInfo := []; //will be copied from SSNInfoEx later;
				HighRiskIndicators := project(l.hri_ssn,transform(iesp.share.t_RiskIndicator, self.riskcode := left.hri, self.Description := left.desc));
        Self.SSNInfoEx := iesp.ECL2ESP.SetSSNInfoEx (L.ssn, if (R.valid, 'yes', 'no'), R.ssn_issue_place, 
                                                   IssuedStart, IssuedEnd, HighRiskIndicators);
        Self.DOB := iesp.ECL2ESP.toDate (L.dob);
        Self.Age := GetAge (L.dob);

        Self := []; // death information, indicators
      END;


  export GetPersonBase (dataset (PersonReports.layouts.comp_names) persons, 
                        dataset (doxie_crs.layout_SSN_Lookups) ssn_lookups,
                        dataset (doxie_crs.layout_deathfile_records) deathfile_records,
                        PersonReports.input.personal in_params) := function

			//moved HRI for SSNs here to improve performance.
			maxHriPer_Value := in_params.max_hri;
			persons_noHRI := project(persons, transform(layout_names_HRI, self := left, 
			                                             self.valid_SSN := '',
																									 self.cnt := 0,
																									 self.ssn_issue_early := 0,
																									 self.ssn_issue_last := 0,
																									 self.ssn_issue_place := '' ,
																									 self.hri_ssn := dataset([],risk_indicators.layout_desc)));
  		doxie.mac_AddHRISSN(persons_noHRI,persons_HRI,FALSE);
			personsHRI := if (in_params.include_hri, persons_HRI, persons_noHRI);
      //====================================================================			
			
      // append SSN info
      // bug 92311 -- lookups need to be done at the ssn9 level, not ssn5
      issuance := JOIN (personsHRI, ssn_lookups,
                        Left.ssn = Right.ssn_unmasked,
                        AddIssuance (Left, Right), keep(1), left outer);
      
			ssn_mask_value := in_params.ssn_mask;
      Suppress.MAC_Mask (issuance, issuance_msk, SSNInfoEx.ssn, null, true, false);

      // get deceased info
      pers_deceased := JOIN (issuance_msk, deathfile_records, 
                        Left.did = (unsigned6) Right.did,
                        GetDeadInfo (Left, Right),
                        left outer, limit (0), keep (1));
      // add crim indicators
      CriminalRecords_Services.MAC_Indicators(pers_deceased,pers_res);
      return IF(in_params.include_criminalindicators,pers_res,pers_deceased);
  end;

  // export Residents (dataset (layouts.comp_names) residents, input.personal in_params) := MODULE
  // END;

  // returnes: dataset (layouts.identity_slim)
  export GetSSNRecordsBase (dataset (doxie_crs.layout_ssn_records) ssn_main,
                            dataset (doxie_crs.layout_deathfile_records) deathfile_records,
                            PersonReports.input.personal in_params,
												boolean IsFCRA = false) := function

    all_names := dedup (sort (ssn_main, fname,lname,mname,-dob,-ssn), 
                              left.fname=right.fname and left.lname=right.lname and
                              left.mname=right.mname and left.ssn=right.ssn or right.ssn='' and
                              (left.dob=right.dob or right.dob=0 or
                              (right.dob % 100 =0 and
                              ((string)left.dob)[1..6]=((string)right.dob)[1..6])));

    iesp.share.t_SSNInfoEx FormatSSN (doxie_crs.layout_ssn_records L) := TRANSFORM
      Self.SSN := L.ssn;
      Self.Valid := IF (L.valid, 'yes', 'no');
      Self.IssuedLocation := L.ssn_issue_place;
      Self.IssuedStartDate := iesp.ECL2ESP.toDate ((integer) L.ssn_issue_early);
      Self.IssuedEndDate   := iesp.ECL2ESP.toDate ((integer) L.ssn_issue_last);
      Self.HighRiskIndicators := dataset([],iesp.share.t_RiskIndicator); //if(in_params.include_hri,get_SSN_HRI(l.ssn,l.did));
    END;

    // append SSN info to imposters
    PersonReports.layouts.identity_slim AddIssuanceImposters (doxie_crs.layout_ssn_records l) := TRANSFORM
      Self.did := L.did;
      Self.UniqueID := intformat (L.did, 12, 1);
      Self.Name := iesp.ECL2ESP.SetName (l.fname, l.mname, l.lname, L.name_suffix, '');
      Self.Gender := '';
      Self.SSNInfo := project (L, FormatSSN (Left));
      Self.SSNInfoEx := project (L, FormatSSN (Left));
      Self.DOB := iesp.ECL2ESP.toDate (L.dob);
      Self.Age := L.age;
      Self.SubjectSSNIndicator := stringlib.StringToLowerCase (L.subject_ssn_indicator);
      Self.IsCurrentName := (L.current_name = 'YES');
      Self.IsCorrectDOB := (L.correct_dob = 'YES');
			Self.Statementids  :=  L.Statementids;
			Self.isDisputed := L.isDisputed;
      Self := [];
    END;

    all_names_noHRI := project (all_names, AddIssuanceImposters (Left));
    //====================================================================															
			//moved HRI for SSNs here to improve performance.
			maxHriPer_Value := personReports.layouts.max_hri;
			ssnDidRecs := project(all_names_noHRI, transform(personReports.layouts.ssn_hri_rec, self.ssn := left.SSNInfoEx.ssn, self.did := left.did, self := left, self := [])); 
			doxie.mac_AddHRISSN(ssnDidRecs,ssnDidRecsHRI,FALSE);
			all_names_noHRI fillHRI(all_names_noHRI l, ssnDidRecsHRI r) := transform
			  self.SSNInfoEx.HighRiskIndicators := project(r.hri_ssn,transform(iesp.share.t_RiskIndicator, self.riskcode := left.hri, self.Description := left.desc));
				self := l;
			end;

    all_names_noHRI fillHRI_FCRA(all_names_noHRI l, ssnDidRecs r) := transform

		self.SSNInfoEx.HighRiskIndicators := project(r.hri_ssn,transform(iesp.share.t_RiskIndicator, self.riskcode := left.hri, self.Description := left.desc));
		self := l;
	end;
	
	all_namesHRI := if(~IsFCRA, join(all_names_noHRI, ssnDidRecsHRI ,left.SSNInfoEx.ssn = right.ssn and left.did = right.did, fillHRI(left, right), keep(1), left outer));
	all_names_ready := IF (IsFcra or ~in_params.include_hri, all_names_noHRI, all_namesHRI);
	      //====================================================================			
    // get "dead" info here, since we will need it anyway in both imposters and AKA
    all_persons_deceased := JOIN (all_names_ready, deathfile_records, 
                         left.did = (unsigned6) right.did,
                         GetDeadInfo (left, right),
                         left outer, limit (0), keep (1));
    // add crim indicators
    CriminalRecords_Services.MAC_Indicators(all_persons_deceased,all_persons);
		
    return map(~IsFCRA and in_params.include_criminalindicators  => all_persons,
							 ~IsFCRA and ~in_params.include_criminalindicators => all_persons_deceased,	
		                                                                all_names_ready);
  end;



  // returns iesp.bps_share.t_BpsReportImposter (it is based on iesp.bps_share.t_BpsReportIdentity)
  export GetImposters (dataset (PersonReports.layouts.identity_slim) all_persons,
                       dataset (doxie.layout_best) bestrecs,
                       PersonReports.input.personal in_params) := function

    // TODO: replace join with a filter
    imposters_by_ssn := join (all_persons, bestrecs, 
                              left.SSNInfo.SSN=right.ssn_unmasked,
                              transform (PersonReports.layouts.identity_slim, Self := Left), keep (1))
    (did != bestrecs[1].did);
//(did NOT IN input_dids_set);

    // Use this to return ALL entries -- having different SSNs -- for an imposter (as Moxie currently does)
    all_imposters := join (all_persons, imposters_by_ssn, left.did = right.did, keep (1));

    // every imposter may have several records on file, not necessarily all of them having same SSN
    // as the subject. Thus, we can return either imposter records having same SSN, or all imposter's records
    // (Moxie currently returns all, which may produce kind of "duplicate" output)
    names_imposters := if (in_params.return_AllImposterRecords, all_imposters, imposters_by_ssn);

    imposters_d := dedup (sort (names_imposters, did, record,if (DeathVerificationCode<>'',0,1)), 
                                        did, record, except DOD.year, DOD.month, DOD.day, DeathVerificationCode);

    imposters_grp := group (sort (imposters_d, did), did);

    iesp.bps_share.t_BpsReportImposter RollImposters (PersonReports.layouts.identity_slim l, dataset (PersonReports.layouts.identity_slim) r):=transform
      self.AKAs := choosen (project (R, transform (iesp.bps_share.t_BpsReportIdentity, Self := Left; Self := [])), 
                            min(in_params.max_imposter_akas,iesp.constants.BR.MaxImposters_AKA));
    END;

    imposters := ROLLUP (imposters_grp, GROUP, RollImposters (Left, rows (Left)));
    return imposters;
  end;




  // returnes: dataset (layouts.identity_slim)
  export GetSubjectBestAKA (dataset (doxie_crs.layout_best_information) bestrecs,
                            dataset (doxie_crs.layout_deathfile_records) deathfile_records,
                            PersonReports.input.personal in_params,
														boolean IsFCRA = false
														) := function

    //--------------------------------------------------------------------------------------------------------------
    //--------------------------------------------------------------------------------------------------------------
    // This is an unfortunate artefact of the old Comp Report (and a weird code, having said that):
    // doxie/ssn_records doesn't contain "best" record, so here I have to add it to AKAs
    // (see also #14515)
    // I believe it is still better than what was here before (calls to both doxie/ssn_records and doxie/ssn_persons)
    // Eventually, doxie/ssn_records MUST be modified to return all persons, and all this code will be gone
    // (down to "subj_names" below).
    //--------------------------------------------------------------------------------------------------------------
    //--------------------------------------------------------------------------------------------------------------

    get_SSN_HRI(STRING9 ssn, UNSIGNED6 did, integer maxHriPer_Value) := FUNCTION
      ssnDidRecs := DATASET([{ssn,did,'',0,0,0,'',DATASET([],risk_indicators.layout_desc)}],layouts.ssn_hri_rec);
      doxie.mac_AddHRISSN(ssnDidRecs,ssnDidRecsHRI,FALSE);
      hri_ssn := NORMALIZE(ssnDidRecsHRI,LEFT.hri_ssn,TRANSFORM(risk_indicators.layout_desc,SELF:=RIGHT));
      RETURN PROJECT(hri_ssn,TRANSFORM(iesp.share.t_RiskIndicator,SELF.RiskCode:=LEFT.hri,SELF.Description:=LEFT.desc));
    END;

    // in part mimics transform "ssnm" from doxie/SSN_Records
    iesp.share.t_SSNInfoEx FormatSSN_2 (doxie.layout_best L, recordof (doxie.Key_SSN_Map) R) := TRANSFORM
      r_end := IF (R.end_date='20990101', 0, (unsigned4) R.end_date);
      Self.SSN := L.ssn;
      Self.Valid            := if(Suppress.dateCorrect.do(L.ssn).needed, 'yes', iesp.ECL2ESP.GetSSNValidation(L.valid_ssn));
      Self.IssuedStartDate  := iesp.ECL2ESP.toDate(Suppress.dateCorrect.sdate_u4(L.ssn, (integer)R.start_date));
      Self.IssuedEndDate    := iesp.ECL2ESP.toDate(Suppress.dateCorrect.edate_u4(L.ssn, r_end));
      Self.IssuedLocation    := Suppress.dateCorrect.state(L.ssn, R.state);
      Self.HighRiskIndicators := if(~IsFCRA and in_params.include_hri,get_SSN_HRI(l.ssn,l.did, in_params.max_hri));
    END;
    
		key_ssnmap := if(IsFCRA,doxie.Key_SSN_FCRA_Map,doxie.Key_SSN_Map);
		
    layouts.identity_slim AddIssuanceAKAs (doxie_crs.layout_best_information L, key_ssnmap R) := TRANSFORM
      Self.did := L.did;
      Self.UniqueID := intformat (L.did, 12, 1);
      Self.Name := iesp.ECL2ESP.SetName (l.fname, l.mname, l.lname, L.name_suffix, L.title);
      Self.Gender := iesp.ECL2ESP.GetGender (L.title);
      //ds_ssn_info := limit (doxie.Key_SSN_Map (keyed (
			ssnInfoHRI := project (L, FormatSSN_2 (Left, R));
      Self.SSNInfo   := project (ssnInfoHRI, transform(iesp.share.t_SSNInfo, self := left));
      Self.SSNInfoEx := ssnInfoHRI;

      Self.DOB := iesp.ECL2ESP.toDate (L.dob);
      // Self.DOD := iesp.ECL2ESP.toDatestring8 (L.dod);//twb not needed
      Self.Age := L.age;
      Self.SubjectSSNIndicator := '';//stringlib.StringToLowerCase (L.subject_ssn_indicator);
      Self.IsCurrentName := true;
      Self.IsCorrectDOB := L.dob != 0;
			Self.StatementIDs := L.StatementIds;
			Self.isDisputed := L.isDisputed;
      // TODO: Self.DeathVerificationCode := r.death_code; // -- need another join?
      // dod := (unsigned) L.dod;  //twb not needed
      // dob := (unsigned) L.dob;//twb not needed
      // Self.AgeAtDeath := if (dod = 0 or dob = 0, 0, ut.GetAgeI_asOf (dob, dod)); //R.dod is "unsigned"//twb not needed
      Self := [];
    END;
	
		
    // the above dod assignments appear to not be needed because the aka_best below is only 
    // used once and that is for aka_best_dead directly below. It calls GetDead and it will
    // assign those same columns from the right ( meaning the death index )
    aka_best := join (bestrecs, key_ssnmap,
                      keyed (left.ssn [1..5] = Right.ssn5) AND
                      keyed (left.ssn[ 6..9] between Right.start_serial AND Right.end_serial),
                      AddIssuanceAKAs (Left, Right),
                      left outer, limit (0), keep (1)); //1 : 1 relation
									
    // append deceased info
    aka_best_dead := JOIN (aka_best, deathfile_records, 
                           Left.did = (unsigned6) Right.did,
                           GetDeadInfo (Left, Right),
                           left outer, limit (0), keep (1));
    // add crim indicators
    CriminalRecords_Services.MAC_Indicators(aka_best_dead,aka_best_recs);
		return map(~IsFCRA and in_params.include_criminalindicators  => aka_best_recs,
				~IsFCRA and ~in_params.include_criminalindicators => aka_best_dead,	
		                                                         aka_best);
  end;

  shared PersonReports.layouts.identity_bps_rolled RollIdentity (PersonReports.layouts.identity_bps l, dataset(PersonReports.layouts.identity_bps) r):=transform
    self.did := L.did; // note: DID can be unreliable here, if input is grouped by seq_no
    self.address_seq_no := l.address_seq_no;
    self.akas := choosen (project (r, iesp.bps_share.t_BpsReportIdentity), iesp.Constants.BR.MaxAddress_Residents);
  END;

  // ------------------------- expanded relatives/associates -------------------------
  export CreateRelativesBps (dataset (recordof (doxie.relative_summary)) rel_assoc,
                             dataset (PersonReports.layouts.identity_slim) relassoc_base, 
                             dataset (PersonReports.layouts.address_bps) addr, 
                             PersonReports.input.personal in_params) := function

    akas_xpanded := project (relassoc_base, ExpandIdentity (Left));
    // Note: additional linking by DID (concealed weapon, sex offense indicators, etc.)
    //       can be done here or after grouping.
    akas_grouped := group (sort (akas_xpanded, did), did); 
    akas_rolled := rollup (akas_grouped, GROUP, RollIdentity (Left, rows (Left)));

    wide_rec := iesp.bpsreport.t_BpsReportRelative;

    // Get Relative info
    wide_rec GetRelativesInfo (doxie_crs.layout_relative_summary L, PersonReports.layouts.identity_bps_rolled R) := transform
      self.UniqueId := intformat (R.did, 12, 1);

      Self.AKAs := choosen (R.akas, iesp.Constants.BR.MaxRelatives_AKA);
      Self.RelativeDepth := if (L.relative, L.depth, -1);
      Self.Cohabitants:= L.number_cohabits;
      Self.DateLastCohabit := iesp.ECL2ESP.toDatestring8 (L.recent_cohabit + '00');
      Self.RelationshipType:= L.relationship_type;
      Self.RelationshipConfidence:= L.relationship_confidence;
    //? Confidence == Cohabitants
      Self :=[]; // addresses, indicators, etc.
    END;

    akas := join (rel_assoc, akas_rolled, 
                  (unsigned6) Left.person2 = Right.did,  
                  GetRelativesInfo (Left, Right), limit (0), keep (1));

    // rel/assoc addresses will be linked with AKAs by DID (vs. sequence)
    addr_grp := group (sort (addr, did), did);

    PersonReports.layouts.address_bps_rolled RollAddress (PersonReports.layouts.address_bps L, dataset (PersonReports.layouts.address_bps) R):=transform
      self.addresses := choosen (project (R, iesp.bpsreport.t_BpsReportAddress), iesp.Constants.BR.MaxRelatives_Address);
      self.did := L.did;
    END;
    addr_rolled := rollup (addr_grp, group, RollAddress (Left, rows (Left)));

    wide_rec GetFullRelatives (wide_rec l, PersonReports.layouts.address_bps_rolled r):=transform
      // set addresses, apply optional filters, if any
      rel_addrs := R.addresses (~in_params.rels_with_phones OR exists (Phones));
      self.addresses := sort (choosen (rel_addrs, iesp.Constants.BR.MaxRelatives_Address), -DateLastSeen);
      self := l;
    END; 

    all_recs := JOIN (akas, addr_rolled, 
                      (integer) left.uniqueid = right.did,
                      GetFullRelatives (left,right),left outer);
    return all_recs;
  end;


shared PersonReports.layouts.identity_slim_rolled RollIdentitySlim (PersonReports.layouts.identity_slim l, dataset(PersonReports.layouts.identity_slim) r):=transform
  self.did := L.did; // note: DID can be unreliable here, if input is grouped by seq_no
  self.address_seq_no := l.address_seq_no;
  self.akas := choosen (project (r, iesp.bpsreport.t_BpsReportIdentitySlim), iesp.Constants.BR.MaxRelatives_AKA);
END;

  export CreateRelativesSlim (dataset (recordof (doxie.relative_summary)) rel_assoc,
                              dataset (PersonReports.layouts.identity_slim) relassoc_base, 
                              dataset (PersonReports.layouts.address_slim) addr, 
                              PersonReports.input.personal in_params) := function

    akas_grouped := group (sort (relassoc_base, did), did); 
    akas_rolled := rollup (akas_grouped, GROUP, RollIdentitySlim (Left, rows (Left)));

    slim_rec := iesp.bpsreport.t_BpsReportRelativeSlim;

    // Get Relative info
    slim_rec GetRelativesInfo (doxie_crs.layout_relative_summary L, PersonReports.layouts.identity_slim_rolled R) := transform
      self.UniqueId := intformat (R.did, 12, 1);

      Self.AKAs := choosen (R.akas, iesp.Constants.BR.MaxRelatives_AKA);
      Self.RelativeDepth := if (L.relative, L.depth, -1);
      Self.Cohabitants:= L.number_cohabits;
      Self.RelationshipType:= L.relationship_type;
      Self.RelationshipConfidence:= L.relationship_confidence;
    //? Confidence == Cohabitants
      Self :=[]; // addresses, indicators, etc.
    END;

    akas := join (rel_assoc, akas_rolled, 
                  (unsigned6) Left.person2 = Right.did,  
                  GetRelativesInfo (Left, Right), limit (0), keep (1));

    record_addr_did := record
      unsigned6 did;
      dataset (iesp.bpsreport.t_BpsReportAddressSlim) addresses {maxcount(iesp.Constants.BR.MaxAddress)};
    END;

    // rel/assoc addresses will be linked with AKAs by DID (vs. sequence)
    addr_grp := group (sort (addr, did), did);

    PersonReports.layouts.address_slim_rolled RollAddress (PersonReports.layouts.address_slim L, dataset (PersonReports.layouts.address_slim) R):=transform
      self.addresses := choosen (project (R, iesp.bpsreport.t_BpsReportAddressSlim), iesp.Constants.BR.MaxRelatives_Address);
      self.did := L.did;
    END;
    roll_addrs := rollup (addr_grp, group, RollAddress (Left, rows (Left)));

    slim_rec GetFullRelatives (slim_rec l, record_addr_did r):=transform
      // set addresses, apply optional filters, if any
      rel_addrs := R.addresses (~in_params.rels_with_phones OR exists (Phones));
      self.addresses := sort (choosen (rel_addrs, iesp.Constants.BR.MaxRelatives_Address), -DateLastSeen);
      self := l;
    END; 

    all_recs := JOIN (akas, roll_addrs, 
                      (integer) left.uniqueid = right.did,
                      GetFullRelatives (left,right),left outer);
    return all_recs;
  end;

END;



