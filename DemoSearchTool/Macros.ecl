EXPORT Macros := 
  MODULE
    
    EXPORT mac_JoinPersonKeys() :=
      MACRO
        IF( LEFT.Per_FirstDegreeRelativesCount  = 0,
            LEFT.Per_FirstDegreeRelativesCount  = RIGHT.First_Degree_Relatives_cnt,
            LEFT.Per_FirstDegreeRelativesCount <= RIGHT.First_Degree_Relatives_cnt ) 
        AND
        IF( LEFT.Per_SecondDegreeRelativesCount  = 0,
            LEFT.Per_SecondDegreeRelativesCount  = RIGHT.Second_Degree_Relatives_cnt,
            LEFT.Per_SecondDegreeRelativesCount <= RIGHT.Second_Degree_Relatives_cnt ) 
        AND
        IF( LEFT.Per_ThirdDegreeRelativesCount  = 0,
            LEFT.Per_ThirdDegreeRelativesCount  = RIGHT.Third_Degree_Relatives_cnt,
            LEFT.Per_ThirdDegreeRelativesCount <= RIGHT.Third_Degree_Relatives_cnt ) 
        AND
        IF( LEFT.Per_AssociatesCount  = 0,
            LEFT.Per_AssociatesCount  = RIGHT.Associates_cnt,
            LEFT.Per_AssociatesCount <= RIGHT.Associates_cnt ) 
        AND
        IF( LEFT.Per_NeighborsCount  = 0,
            LEFT.Per_NeighborsCount  = RIGHT.Neighbors_cnt,
            LEFT.Per_NeighborsCount <= RIGHT.Neighbors_cnt ) 
        AND
        IF( LEFT.Per_AKAsCount  = 0,
            LEFT.Per_AKAsCount  = RIGHT.AKAs_cnt,
            LEFT.Per_AKAsCount <= RIGHT.AKAs_cnt ) 
        AND
        IF( LEFT.Per_BankruptciesCount  = 0,
            LEFT.Per_BankruptciesCount  = RIGHT.Bankruptcy_cnt,
            LEFT.Per_BankruptciesCount <= RIGHT.Bankruptcy_cnt )   
        AND
        IF( LEFT.Per_CorporateAffiliationsCount  = 0,
            LEFT.Per_CorporateAffiliationsCount  = RIGHT.Corporate_Affiliation_cnt,
            LEFT.Per_CorporateAffiliationsCount <= RIGHT.Corporate_Affiliation_cnt ) 
        AND
        IF( LEFT.Per_CriminalRecordsCount  = 0,
            LEFT.Per_CriminalRecordsCount  = RIGHT.Criminal_cnt,
            LEFT.Per_CriminalRecordsCount <= RIGHT.Criminal_cnt ) 
        AND
        IF( LEFT.Per_CriminalDeptOfCorrectionsCount  = 0,
            LEFT.Per_CriminalDeptOfCorrectionsCount  = RIGHT.Criminal_DOC_cnt,
            LEFT.Per_CriminalDeptOfCorrectionsCount <= RIGHT.Criminal_DOC_cnt ) 
        AND
        ( NOT LEFT.in_Per_DeathKey OR LEFT.in_Per_DeathKey = RIGHT.in_Deceased )
        AND
        IF( LEFT.Per_DirectoryAssistanceCount  = 0,
            LEFT.Per_DirectoryAssistanceCount  = RIGHT.Directory_Assistance_Gong_cnt,
            LEFT.Per_DirectoryAssistanceCount <= RIGHT.Directory_Assistance_Gong_cnt ) 
        AND
        IF( LEFT.Per_DriverLicenseCount  = 0,
            LEFT.Per_DriverLicenseCount  = RIGHT.DL_cnt,
            LEFT.Per_DriverLicenseCount <= RIGHT.DL_cnt )  
        AND
        IF( LEFT.Per_EmailsCount  = 0,
            LEFT.Per_EmailsCount  = RIGHT.Email_cnt,
            LEFT.Per_EmailsCount <= RIGHT.Email_cnt ) 
        AND
        IF( LEFT.Per_FAAAircraftsCount  = 0,
            LEFT.Per_FAAAircraftsCount  = RIGHT.FAA_Aircraft_cnt,
            LEFT.Per_FAAAircraftsCount <= RIGHT.FAA_Aircraft_cnt ) 
        AND
        IF( LEFT.Per_ForclosuresCount  = 0,
            LEFT.Per_ForclosuresCount  = RIGHT.Foreclosure_cnt,
            LEFT.Per_ForclosuresCount <= RIGHT.Foreclosure_cnt ) 
        AND
        IF( LEFT.Per_GlobalWatchListsCount  = 0,
            LEFT.Per_GlobalWatchListsCount  = RIGHT.GWL_cnt,
            LEFT.Per_GlobalWatchListsCount <= RIGHT.GWL_cnt ) 
        AND
        ( NOT LEFT.in_Per_GlobalWatchListOFAC OR LEFT.in_Per_GlobalWatchListOFAC = RIGHT.in_GWL_OFAC_Only ) 
        AND
        ( NOT LEFT.has_Per_HighRiskIndicatorAddress OR LEFT.has_Per_HighRiskIndicatorAddress = RIGHT.in_Address_HRI )
        AND
        ( NOT LEFT.has_Per_HighRiskIndicatorSSN OR LEFT.has_Per_HighRiskIndicatorSSN = RIGHT.in_SSN_HRI )
        AND
        IF( LEFT.Per_LiensCount  = 0,
            LEFT.Per_LiensCount  = RIGHT.Liens_cnt,
            LEFT.Per_LiensCount <= RIGHT.Liens_cnt ) 
        AND
        IF( LEFT.Per_JudgmentsCount  = 0,
            LEFT.Per_JudgmentsCount  = RIGHT.Judgements_cnt,
            LEFT.Per_JudgmentsCount <= RIGHT.Judgements_cnt ) 
        AND
        IF( LEFT.Per_EvictionsCount  = 0,
            LEFT.Per_EvictionsCount  = RIGHT.Evictions_cnt,
            LEFT.Per_EvictionsCount <= RIGHT.Evictions_cnt ) 
        AND
        IF( LEFT.Per_MarriageDivorceCount  = 0,
            LEFT.Per_MarriageDivorceCount  = RIGHT.Marriage_and_Divorce_cnt,
            LEFT.Per_MarriageDivorceCount <= RIGHT.Marriage_and_Divorce_cnt ) 
        AND
        IF( LEFT.Per_MotorVehiclesCount  = 0,
            LEFT.Per_MotorVehiclesCount  = RIGHT.MVR_cnt,
            LEFT.Per_MotorVehiclesCount <= RIGHT.MVR_cnt ) 
        AND
        IF( LEFT.Per_NoticesOfDefaultCount  = 0,
            LEFT.Per_NoticesOfDefaultCount  = RIGHT.Notice_of_Default_cnt,
            LEFT.Per_NoticesOfDefaultCount <= RIGHT.Notice_of_Default_cnt ) 
        AND
        IF( LEFT.Per_PeopleAtWorkCount  = 0,
            LEFT.Per_PeopleAtWorkCount  = RIGHT.People_at_Work_cnt,
            LEFT.Per_PeopleAtWorkCount <= RIGHT.People_at_Work_cnt ) 
        AND
        ( NOT LEFT.in_Per_PersonHeader OR LEFT.in_Per_PersonHeader = RIGHT.in_Person_Header )
        AND
        IF( LEFT.Per_PhonesPlusCount  = 0,
            LEFT.Per_PhonesPlusCount  = RIGHT.PhonesPlus_cnt,
            LEFT.Per_PhonesPlusCount <= RIGHT.PhonesPlus_cnt ) 
        AND
        IF( LEFT.Per_ProfessionalLicensesCount  = 0,
            LEFT.Per_ProfessionalLicensesCount  = RIGHT.Professional_License_cnt,
            LEFT.Per_ProfessionalLicensesCount <= RIGHT.Professional_License_cnt ) 
        AND
        IF( LEFT.Per_PropertiesCount  = 0,
            LEFT.Per_PropertiesCount  = RIGHT.Property_cnt,
            LEFT.Per_PropertiesCount <= RIGHT.Property_cnt ) 
        AND
        IF( LEFT.Per_RegisteredAgentsCount  = 0,
            LEFT.Per_RegisteredAgentsCount  = RIGHT.Registered_Agent_cnt,
            LEFT.Per_RegisteredAgentsCount <= RIGHT.Registered_Agent_cnt ) 
        AND
        IF( LEFT.Per_SexualOffenderCount  = 0,
            LEFT.Per_SexualOffenderCount  = RIGHT.Sex_Offender_cnt,
            LEFT.Per_SexualOffenderCount <= RIGHT.Sex_Offender_cnt ) 
        AND
        IF( LEFT.Per_RegisteredAgentsCount  = 0,
            LEFT.Per_RegisteredAgentsCount  = RIGHT.Registered_Agent_cnt,
            LEFT.Per_RegisteredAgentsCount <= RIGHT.Registered_Agent_cnt ) 
        AND
        IF( LEFT.Per_SexualOffenderCount  = 0,
            LEFT.Per_SexualOffenderCount  = RIGHT.Sex_Offender_cnt,
            LEFT.Per_SexualOffenderCount <= RIGHT.Sex_Offender_cnt ) 
        AND
        IF( LEFT.Per_WatercraftsCount  = 0,
            LEFT.Per_WatercraftsCount  = RIGHT.Watercraft_cnt,
            LEFT.Per_WatercraftsCount <= RIGHT.Watercraft_cnt )
        AND
        IF( LEFT.Per_AddressesCount  = 0,
            LEFT.Per_AddressesCount  = RIGHT.Addresses_cnt,
            LEFT.Per_AddressesCount <= RIGHT.Addresses_cnt ) 
        AND
        IF( LEFT.Per_SSNsCount  = 0,
            LEFT.Per_SSNsCount  = RIGHT.SSN_Cnt,
            LEFT.Per_SSNsCount <= RIGHT.SSN_Cnt ) 
        AND
				//Adding new dataset
        IF( LEFT.Per_MARILicensesCount  = 0,
            LEFT.Per_MARILicensesCount  = RIGHT.mari_license_cnt,
            LEFT.Per_MARILicensesCount <= RIGHT.mari_license_cnt )
 						AND
        IF( LEFT.Per_PublicSanctnsCount  = 0,
            LEFT.Per_PublicSanctnsCount  = RIGHT.public_sanctn_cnt,
            LEFT.Per_PublicSanctnsCount <= RIGHT.public_sanctn_cnt )
						AND
        IF( LEFT.Per_NonPublicSanctnsCount  = 0,
            LEFT.Per_NonPublicSanctnsCount  = RIGHT.nonpublic_sanctn_cnt,
            LEFT.Per_NonPublicSanctnsCount <= RIGHT.nonpublic_sanctn_cnt )
						AND
        IF( LEFT.Per_FreddieMacSanctnsCount  = 0,
            LEFT.Per_FreddieMacSanctnsCount  = RIGHT.freddiemac_sanctn_cnt,
            LEFT.Per_FreddieMacSanctnsCount <= RIGHT.freddiemac_sanctn_cnt )
						
      ENDMACRO;
    
    EXPORT mac_JoinBizKeys() :=
      MACRO
        IF( LEFT.Biz_AddressesCount = 0,
            LEFT.Biz_AddressesCount  = RIGHT.Addresses_cnt,
            LEFT.Biz_AddressesCount <= RIGHT.Addresses_cnt ) 
        AND
        IF( LEFT.Biz_BankruptciesCount = 0,
            LEFT.Biz_BankruptciesCount  = RIGHT.Bankruptcy_cnt,
            LEFT.Biz_BankruptciesCount <= RIGHT.Bankruptcy_cnt ) 
        AND
        ( NOT LEFT.in_Biz_BusinessHeader OR LEFT.in_Biz_BusinessHeader = RIGHT.in_Business_Header )
        AND
        IF( LEFT.Biz_AssociatesCount = 0,
            LEFT.Biz_AssociatesCount  = RIGHT.Business_Associates_cnt,
            LEFT.Biz_AssociatesCount <= RIGHT.Business_Associates_cnt ) 
        AND
        IF( LEFT.Biz_Industry_NaicsCount = 0,
            LEFT.Biz_Industry_NaicsCount  = RIGHT.Business_Industry_NAICS_cnt,
            LEFT.Biz_Industry_NaicsCount <= RIGHT.Business_Industry_NAICS_cnt ) 
        AND
        IF( LEFT.Biz_NameVariationsCount = 0,
            LEFT.Biz_NameVariationsCount  = RIGHT.Business_Name_Variations_cnt,
            LEFT.Biz_NameVariationsCount <= RIGHT.Business_Name_Variations_cnt ) 
        AND
        IF( LEFT.Biz_RegistrationsCount = 0,
            LEFT.Biz_RegistrationsCount  = RIGHT.Business_Registrations_cnt,
            LEFT.Biz_RegistrationsCount <= RIGHT.Business_Registrations_cnt ) 
        AND
        IF( LEFT.Biz_CorporateFilingsCount = 0,
            LEFT.Biz_CorporateFilingsCount  = RIGHT.Corporations_SOS_cnt,
            LEFT.Biz_CorporateFilingsCount <= RIGHT.Corporations_SOS_cnt )  
        AND
        IF( LEFT.Biz_DirectoryAssistanceCount = 0,
            LEFT.Biz_DirectoryAssistanceCount  = RIGHT.Directory_Assistance_Gong_cnt,
            LEFT.Biz_DirectoryAssistanceCount <= RIGHT.Directory_Assistance_Gong_cnt ) 
        AND
        IF( LEFT.Biz_ExecutivesCount = 0,
            LEFT.Biz_ExecutivesCount  = RIGHT.Executives_cnt,
            LEFT.Biz_ExecutivesCount <= RIGHT.Executives_cnt ) 
        AND
        IF( LEFT.Biz_FAAAircraftsCount = 0,
            LEFT.Biz_FAAAircraftsCount  = RIGHT.FAA_Aircraft_cnt,
            LEFT.Biz_FAAAircraftsCount <= RIGHT.FAA_Aircraft_cnt ) 
        AND
        IF( LEFT.Biz_FictitiousBusinessesCount = 0,
            LEFT.Biz_FictitiousBusinessesCount  = RIGHT.Fictitious_Businesses_cnt,
            LEFT.Biz_FictitiousBusinessesCount <= RIGHT.Fictitious_Businesses_cnt ) 
        AND
        IF( LEFT.Biz_ForclosuresCount = 0,
            LEFT.Biz_ForclosuresCount  = RIGHT.Foreclosure_cnt,
            LEFT.Biz_ForclosuresCount <= RIGHT.Foreclosure_cnt ) 
        AND
        IF( LEFT.Biz_GlobalWatchListsCount = 0,
            LEFT.Biz_GlobalWatchListsCount  = RIGHT.GWL_cnt,
            LEFT.Biz_GlobalWatchListsCount <= RIGHT.GWL_cnt ) 
        AND
        ( NOT LEFT.in_Biz_GlobalWatchListOFAC OR LEFT.in_Biz_GlobalWatchListOFAC = RIGHT.in_GWL_OFAC_Only ) 
        AND
        IF( LEFT.Biz_InternetDomainsCount = 0,
            LEFT.Biz_InternetDomainsCount  = RIGHT.Internet_Domain_cnt,
            LEFT.Biz_InternetDomainsCount <= RIGHT.Internet_Domain_cnt ) 
        AND
        IF( LEFT.Biz_LiensCount = 0,
            LEFT.Biz_LiensCount  = RIGHT.Liens_cnt,
            LEFT.Biz_LiensCount <= RIGHT.Liens_cnt ) 
        AND
        IF( LEFT.Biz_JudgmentsCount = 0,
            LEFT.Biz_JudgmentsCount  = RIGHT.Judgements_cnt,
            LEFT.Biz_JudgmentsCount <= RIGHT.Judgements_cnt ) 
        AND
        IF( LEFT.Biz_EvictionsCount = 0,
            LEFT.Biz_EvictionsCount  = RIGHT.Evictions_cnt,
            LEFT.Biz_EvictionsCount <= RIGHT.Evictions_cnt ) 
        AND
        IF( LEFT.Biz_MotorVehiclesCount = 0,
            LEFT.Biz_MotorVehiclesCount  = RIGHT.MVR_cnt,
            LEFT.Biz_MotorVehiclesCount <= RIGHT.MVR_cnt ) 
        AND
        IF( LEFT.Biz_PropertiesCount = 0,
            LEFT.Biz_PropertiesCount  = RIGHT.Property_cnt,
            LEFT.Biz_PropertiesCount <= RIGHT.Property_cnt ) 
        AND
        IF( LEFT.Biz_RegisteredAgentsCount = 0,
            LEFT.Biz_RegisteredAgentsCount  = RIGHT.Registered_Agent_cnt,
            LEFT.Biz_RegisteredAgentsCount <= RIGHT.Registered_Agent_cnt ) 
        AND 
        IF( LEFT.Biz_UCCFilingsCount = 0,
            LEFT.Biz_UCCFilingsCount  = RIGHT.UCC_cnt,
            LEFT.Biz_UCCFilingsCount <= RIGHT.UCC_cnt ) 
        AND
        IF( LEFT.Biz_WatercraftsCount = 0,
            LEFT.Biz_WatercraftsCount  = RIGHT.Watercraft_cnt,
            LEFT.Biz_WatercraftsCount <= RIGHT.Watercraft_cnt )
								AND
				//Adding new datasets				
								IF( LEFT.Biz_MARILicensesCount  = 0,
            LEFT.Biz_MARILicensesCount  = RIGHT.mari_license_cnt,
            LEFT.Biz_MARILicensesCount <= RIGHT.mari_license_cnt )
 						AND
        IF( LEFT.Biz_PublicSanctnsCount  = 0,
            LEFT.Biz_PublicSanctnsCount  = RIGHT.public_sanctn_cnt,
            LEFT.Biz_PublicSanctnsCount <= RIGHT.public_sanctn_cnt )
						AND
        IF( LEFT.Biz_NonPublicSanctnsCount  = 0,
            LEFT.Biz_NonPublicSanctnsCount  = RIGHT.nonpublic_sanctn_cnt,
            LEFT.Biz_NonPublicSanctnsCount <= RIGHT.nonpublic_sanctn_cnt )
						AND
        IF( LEFT.Biz_FreddieMacSanctnsCount  = 0,
            LEFT.Biz_FreddieMacSanctnsCount  = RIGHT.freddiemac_sanctn_cnt,
            LEFT.Biz_FreddieMacSanctnsCount <= RIGHT.freddiemac_sanctn_cnt )
      ENDMACRO;

    EXPORT mac_xfmCombinedPersonKeyFields (rw_in) := 
      MACRO
        SELF.UniqueId := (STRING12)rw_in.did;
        SELF.Address := iesp.ECL2ESP.SetAddress(rw_in.prim_name, rw_in.prim_range, 
                                                rw_in.predir, rw_in.postdir,
                                                rw_in.suffix, rw_in.unit_desig, 
                                                rw_in.sec_range, rw_in.city_name,
                                                rw_in.st, rw_in.zip, rw_in.zip4,'');
        SELF.DateLastSeen := iesp.ECL2ESP.toDateYM(rw_in.addr_dt_last_seen);
        SELF.PhoneNumber := rw_in.phone;
        SELF.DOB := iesp.ECL2ESP.toDate(rw_in.dob); 
      ENDMACRO;
     
END;