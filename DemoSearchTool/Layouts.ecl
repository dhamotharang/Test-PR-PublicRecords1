IMPORT iesp, DemoSearchTool;

EXPORT Layouts := 
  MODULE
    
    EXPORT business_bdid_rec := 
      RECORD
        UNSIGNED6 BDID := 0;
    END;
   
    EXPORT business_linkid_rec := 
      RECORD
        UNSIGNED6 ULTID := 0;
        UNSIGNED6 ORGID := 0;
        UNSIGNED6 SELEID := 0;
    END;    
    
    EXPORT Ids_rec := 
      RECORD
        UNSIGNED6 DID;
        business_bdid_rec;
        business_linkid_rec;
      END;
    
    EXPORT bizCounts_rec :=
      RECORD
        INTEGER2  Biz_AddressesCount;
        INTEGER2  Biz_AssociatesCount;
        INTEGER2  Biz_BankruptciesCount;
        BOOLEAN   in_Biz_BusinessHeader;
        INTEGER2  Biz_CorporateFilingsCount;
        INTEGER2  Biz_DirectoryAssistanceCount;
        INTEGER2  Biz_EvictionsCount;
        INTEGER2  Biz_ExecutivesCount;
        INTEGER2  Biz_FAAAircraftsCount;
        INTEGER2  Biz_FictitiousBusinessesCount;
        INTEGER2  Biz_ForclosuresCount;
        BOOLEAN   in_Biz_GlobalWatchListOFAC;
        INTEGER2  Biz_GlobalWatchListsCount;
        INTEGER2  Biz_Industry_NAICSCount;
        INTEGER2  Biz_InternetDomainsCount;
        INTEGER2  Biz_JudgmentsCount;
        INTEGER2  Biz_LiensCount;
        INTEGER2  Biz_MotorVehiclesCount;
        INTEGER2  Biz_NumMultiBusinessesCount;
        INTEGER2  Biz_NameVariationsCount;
        INTEGER2  Biz_PropertiesCount;
        INTEGER2  Biz_RegistrationsCount;
        INTEGER2  Biz_RegisteredAgentsCount;
        INTEGER2  Biz_UCCFilingsCount;
        INTEGER2  Biz_WatercraftsCount;
        INTEGER2  Biz_ProfLicMariCount;
        INTEGER2  Biz_PublicSanctnCount;
        INTEGER2  Biz_NonpublicSanctnCount;
        INTEGER2  Biz_FreddieMacSanctnCount;
      END;
      
    EXPORT combinedTemp_rec :=
      RECORD
        Ids_rec;
        bizCounts_rec;
        BOOLEAN   isFCRA;
        INTEGER2 owned_business_bdid_cnt;
		    INTEGER2 owned_business_linkId_cnt;
		    DATASET(business_bdid_rec)   ds_owned_businesses_bdid{MAXCOUNT(DemoSearchTool.Constants.JOIN_LIMIT)};
			  DATASET(business_linkid_rec) ds_owned_businesses_linkid{MAXCOUNT(DemoSearchTool.Constants.JOIN_LIMIT)};
      END;

    EXPORT SearchInput_rec := 
      RECORD
        BOOLEAN  isFCRA;
        bizCounts_rec;
        INTEGER2 Per_AddressesCount;
        INTEGER2 Per_AKAsCount;
        INTEGER2 Per_AssociatesCount;
        INTEGER2 Per_BankruptciesCount;
        INTEGER2 Per_CorporateAffiliationsCount;
        INTEGER2 Per_CriminalDeptOfCorrectionsCount;
        INTEGER2 Per_CriminalRecordsCount;
        BOOLEAN  in_Per_DeathKey;
        INTEGER2 Per_DirectoryAssistanceCount;
        INTEGER2 Per_DriverLicenseCount;
        INTEGER2 Per_EmailsCount;
        INTEGER2 Per_EvictionsCount;
        INTEGER2 Per_FAAAircraftsCount;
        INTEGER2 Per_FirstDegreeRelativesCount;
        INTEGER2 Per_ForclosuresCount;
        BOOLEAN  in_Per_GlobalWatchListOFAC;
        INTEGER2 Per_GlobalWatchListsCount;
        BOOLEAN  has_Per_HighRiskIndicatorAddress;
        BOOLEAN  has_Per_HighRiskIndicatorSSN;
        INTEGER2 Per_JudgmentsCount;
        INTEGER2 Per_LiensCount;
        INTEGER2 Per_MarriageDivorceCount;
        INTEGER2 Per_MotorVehiclesCount;
        INTEGER2 Per_NeighborsCount;
        INTEGER2 Per_NoticesOfDefaultCount;
        INTEGER2 Per_NumOfBizExecutiveOfCount;
        INTEGER2 Per_PeopleAtWorkCount;
        BOOLEAN  in_Per_PersonHeader;
        INTEGER2 Per_PhonesPlusCount;
        INTEGER2 Per_ProfessionalLicensesCount;
        INTEGER2 Per_PropertiesCount;
        INTEGER2 Per_RegisteredAgentsCount;
        INTEGER2 Per_SecondDegreeRelativesCount;
        INTEGER2 Per_SexualOffenderCount;
        INTEGER2 Per_SSNsCount;
        INTEGER2 Per_ThirdDegreeRelativesCount;
        INTEGER2 Per_WatercraftsCount;
        INTEGER2 Per_ProfLicMariCount;
        INTEGER2 Per_PublicSanctnCount;
        INTEGER2 Per_NonpublicSanctnCount;
        INTEGER2 Per_FreddieMacSanctnCount;
     END;

    EXPORT finalPlusSorting_rec :=
      RECORD
        iesp.demoSearchTool.t_DemoSearchToolSearchRecord; 
        UNSIGNED6 UniqueId;
        business_bdid_rec;
        business_linkid_rec;
      END;
    
    EXPORT SearchToolSrcRecPlusBdidForCombOutput_rec :=
      RECORD
        iesp.demoSearchTool.t_DemoSearchToolSearchRecord;
        business_bdid_rec;
      END;
      
    EXPORT SearchToolSrcRecPlusBipidsForCombOutput_rec :=
      RECORD
        iesp.demoSearchTool.t_DemoSearchToolSearchRecord;
        business_linkid_rec;
      END;

 END;