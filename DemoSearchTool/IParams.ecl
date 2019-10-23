IMPORT DemoSearchTool, iesp, ut;

EXPORT IParams := 
  MODULE

    EXPORT searchOptionsIparams := INTERFACE
      EXPORT BOOLEAN is_Per_searchDirectToConsumer := DemoSearchTool.Constants.DEFAULT_BOOLEAN;
      EXPORT BOOLEAN is_Biz_SearchLegacyKeys := DemoSearchTool.Constants.DEFAULT_BOOLEAN;
      EXPORT BOOLEAN is_Biz_SearchBipKeys := DemoSearchTool.Constants.DEFAULT_BOOLEAN;
      EXPORT BOOLEAN isPersonSearch := DemoSearchTool.Constants.DEFAULT_BOOLEAN;
      EXPORT BOOLEAN isBusinessSearch := DemoSearchTool.Constants.DEFAULT_BOOLEAN;
      EXPORT BOOLEAN isMultiBizAtAddress := DemoSearchTool.Constants.DEFAULT_BOOLEAN; 
    END;
    
    EXPORT SearchIParams := 
      INTERFACE(searchOptionsIparams)
        EXPORT DATASET ds_SearchInput := DATASET([],DemoSearchTool.Layouts.SearchInput_rec);
      END;

		EXPORT fn_CreateSearchToolInputModule(iesp.demoSearchTool.t_DemoSearchToolSearchBy SearchBy,
                                          iesp.demoSearchTool.t_SearchOptions options) := 
      FUNCTION
		  
        ds_InitializeSearchInput := DATASET([DemoSearchTool.Transforms.xfm_initializeInput(SearchBy,Options)]);
      
        DemoSearchTool_inMod := 
          MODULE(SearchIParams)
            EXPORT DATASET (DemoSearchTool.Layouts.SearchInput_rec) ds_SearchInput := ds_InitializeSearchInput;
            EXPORT BOOLEAN is_Per_searchDirectToConsumer := searchBy.PersonDataset.isDirectToConsumer;
            EXPORT BOOLEAN isBusinessSearch := options.isBusinessSearch;
            EXPORT BOOLEAN isPersonSearch := options.isPersonSearch;
            EXPORT BOOLEAN isMultiBizAtAddress := options.isMultiBizAtSameAddress;
            EXPORT BOOLEAN is_Biz_SearchLegacyKeys := (options.isBusinessSearch OR options.isMultiBizAtSameAddress) AND
                                                       searchBy.BusinessDataset.isSearchLegacyKeys;
            EXPORT BOOLEAN is_Biz_SearchBipKeys := (options.isBusinessSearch OR options.isMultiBizAtSameAddress) AND
                                                   (searchBy.BusinessDataset.isSearchBipKeys OR NOT searchBy.BusinessDataset.isSearchLegacyKeys);
          END; 
          
        RETURN DemoSearchTool_inMod;
      END;
     
    fn_ValididateInputCountsBiz(iesp.demosearchtool.t_DemoSearchToolSearchBy SearchBy) :=
      FUNCTION
        RETURN
        (searchBy.BusinessDataset.AddressesCount = '' OR ut.isNumeric(searchBy.BusinessDataset.AddressesCount)) AND
        (searchBy.BusinessDataset.AssociatesCount = '' OR ut.isNumeric(searchBy.BusinessDataset.AssociatesCount)) AND 
        (searchBy.BusinessDataset.BankruptciesCount = '' OR ut.isNumeric(searchBy.BusinessDataset.BankruptciesCount)) AND
        (searchBy.BusinessDataset.CorporateFilingsCount = '' OR ut.isNumeric(searchBy.BusinessDataset.CorporateFilingsCount)) AND
        (searchBy.BusinessDataset.DirectoryAssistanceCount = '' OR ut.isNumeric(searchBy.BusinessDataset.DirectoryAssistanceCount)) AND
        (searchBy.BusinessDataset.EvictionsCount = '' OR ut.isNumeric(searchBy.BusinessDataset.EvictionsCount)) AND
        (searchBy.BusinessDataset.ExecutivesCount = '' OR ut.isNumeric(searchBy.BusinessDataset.ExecutivesCount)) AND
        (searchBy.BusinessDataset.FAAAircraftsCount = '' OR ut.isNumeric(searchBy.BusinessDataset.FAAAircraftsCount)) AND
        (searchBy.BusinessDataset.FictitiousBusinessesCount = '' OR ut.isNumeric(searchBy.BusinessDataset.FictitiousBusinessesCount)) AND
        (searchBy.BusinessDataset.ForclosuresCount = '' OR ut.isNumeric(searchBy.BusinessDataset.ForclosuresCount)) AND
        (searchBy.BusinessDataset.GlobalWatchListsCount = '' OR ut.isNumeric(searchBy.BusinessDataset.GlobalWatchListsCount)) AND
        (searchBy.BusinessDataset.Industry_NAICSCount = '' OR ut.isNumeric(searchBy.BusinessDataset.Industry_NAICSCount)) AND
        (searchBy.BusinessDataset.InternetDomainsCount = '' OR ut.isNumeric(searchBy.BusinessDataset.InternetDomainsCount)) AND
        (searchBy.BusinessDataset.JudgmentsCount = '' OR ut.isNumeric(searchBy.BusinessDataset.JudgmentsCount)) AND
        (searchBy.BusinessDataset.LiensCount = '' OR ut.isNumeric(searchBy.BusinessDataset.LiensCount)) AND
        (searchBy.BusinessDataset.MotorVehiclesCount = '' OR ut.isNumeric(searchBy.BusinessDataset.MotorVehiclesCount)) AND
        (searchBy.BusinessDataset.NameVariationsCount = '' OR ut.isNumeric(searchBy.BusinessDataset.NameVariationsCount)) AND
        (searchBy.BusinessDataset.PropertiesCount = '' OR ut.isNumeric(searchBy.BusinessDataset.PropertiesCount)) AND
        (searchBy.BusinessDataset.RegistrationsCount = '' OR ut.isNumeric(searchBy.BusinessDataset.RegistrationsCount)) AND
        (searchBy.BusinessDataset.RegisteredAgentsCount = '' OR ut.isNumeric(searchBy.BusinessDataset.RegisteredAgentsCount)) AND
        (searchBy.BusinessDataset.UCCFilingsCount = '' OR ut.isNumeric(searchBy.BusinessDataset.UCCFilingsCount)) AND
        (searchBy.BusinessDataset.WatercraftsCount = '' OR ut.isNumeric(searchBy.BusinessDataset.WatercraftsCount)) AND
								(searchBy.BusinessDataset.MARILicensesCount = '' OR ut.isNumeric(searchBy.BusinessDataset.MARILicensesCount)) AND
								(searchBy.BusinessDataset.PublicSanctnsCount = '' OR ut.isNumeric(searchBy.BusinessDataset.PublicSanctnsCount)) AND
								(searchBy.BusinessDataset.NonPublicSanctnsCount = '' OR ut.isNumeric(searchBy.BusinessDataset.NonPublicSanctnsCount)) AND
								(searchBy.BusinessDataset.FreddieMacSanctnsCount = '' OR ut.isNumeric(searchBy.BusinessDataset.FreddieMacSanctnsCount));
      END;
      
    fn_ValididateInputCountsPerson(iesp.demosearchtool.t_DemoSearchToolSearchBy SearchBy) :=
      FUNCTION
        RETURN
        (searchBy.PersonDataset.AddressesCount = '' OR ut.isNumeric(searchBy.PersonDataset.AddressesCount)) AND
        (searchBy.PersonDataset.AKAsCount = '' OR ut.isNumeric(searchBy.PersonDataset.AKAsCount)) AND
        (searchBy.PersonDataset.AssociatesCount = '' OR ut.isNumeric(searchBy.PersonDataset.AssociatesCount)) AND
        (searchBy.PersonDataset.BankruptciesCount = '' OR ut.isNumeric(searchBy.PersonDataset.BankruptciesCount)) AND
        (searchBy.PersonDataset.CorporateAffiliationsCount = '' OR ut.isNumeric(searchBy.PersonDataset.CorporateAffiliationsCount)) AND
        (searchBy.PersonDataset.CriminalDeptOfCorrectionsCount = '' OR ut.isNumeric(searchBy.PersonDataset.CriminalDeptOfCorrectionsCount)) AND
        (searchBy.PersonDataset.CriminalRecordsCount = '' OR ut.isNumeric(searchBy.PersonDataset.CriminalRecordsCount)) AND
        (searchBy.PersonDataset.DirectoryAssistanceCount = '' OR ut.isNumeric(searchBy.PersonDataset.DirectoryAssistanceCount)) AND
        (searchBy.PersonDataset.DriverLicenseCount = '' OR ut.isNumeric(searchBy.PersonDataset.DriverLicenseCount)) AND
        (searchBy.PersonDataset.EmailsCount = '' OR ut.isNumeric(searchBy.PersonDataset.EmailsCount)) AND
        (searchBy.PersonDataset.EvictionsCount = '' OR ut.isNumeric(searchBy.PersonDataset.EvictionsCount)) AND
        (searchBy.PersonDataset.FAAAircraftsCount = '' OR ut.isNumeric(searchBy.PersonDataset.FAAAircraftsCount)) AND
        (searchBy.PersonDataset.FirstDegreeRelativesCount = '' OR ut.isNumeric(searchBy.PersonDataset.FirstDegreeRelativesCount)) AND
        (searchBy.PersonDataset.ForclosuresCount = '' OR ut.isNumeric(searchBy.PersonDataset.ForclosuresCount)) AND
        (searchBy.PersonDataset.GlobalWatchListsCount = '' OR ut.isNumeric(searchBy.PersonDataset.GlobalWatchListsCount)) AND
        (searchBy.PersonDataset.JudgmentsCount = '' OR ut.isNumeric(searchBy.PersonDataset.JudgmentsCount)) AND
        (searchBy.PersonDataset.LiensCount = '' OR ut.isNumeric(searchBy.PersonDataset.LiensCount)) AND
        (searchBy.PersonDataset.MarriageDivorceCount = '' OR ut.isNumeric(searchBy.PersonDataset.MarriageDivorceCount)) AND
        (searchBy.PersonDataset.MotorVehiclesCount = '' OR ut.isNumeric(searchBy.PersonDataset.MotorVehiclesCount)) AND
        (searchBy.PersonDataset.NeighborsCount = '' OR ut.isNumeric(searchBy.PersonDataset.NeighborsCount)) AND
        (searchBy.PersonDataset.NoticesOfDefaultCount = '' OR ut.isNumeric(searchBy.PersonDataset.NoticesOfDefaultCount)) AND
        (searchBy.PersonDataset.NumOfBizExecutiveOfCount = '' OR ut.isNumeric(searchBy.PersonDataset.NumOfBizExecutiveOfCount)) AND
        (searchBy.PersonDataset.PeopleAtWorkCount = '' OR ut.isNumeric(searchBy.PersonDataset.PeopleAtWorkCount)) AND
        (searchBy.PersonDataset.PhonesPlusCount = '' OR ut.isNumeric(searchBy.PersonDataset.PhonesPlusCount)) AND
        (searchBy.PersonDataset.ProfessionalLicensesCount = '' OR ut.isNumeric(searchBy.PersonDataset.ProfessionalLicensesCount)) AND
        (searchBy.PersonDataset.PropertiesCount = '' OR ut.isNumeric(searchBy.PersonDataset.PropertiesCount)) AND
        (searchBy.PersonDataset.RegisteredAgentsCount = '' OR ut.isNumeric(searchBy.PersonDataset.RegisteredAgentsCount)) AND
        (searchBy.PersonDataset.SecondDegreeRelativesCount = '' OR ut.isNumeric(searchBy.PersonDataset.SecondDegreeRelativesCount)) AND
        (searchBy.PersonDataset.SexualOffenderCount = '' OR ut.isNumeric(searchBy.PersonDataset.SexualOffenderCount)) AND
        (searchBy.PersonDataset.SSNsCount = '' OR ut.isNumeric(searchBy.PersonDataset.SSNsCount)) AND
        (searchBy.PersonDataset.WatercraftsCount = '' OR ut.isNumeric(searchBy.PersonDataset.WatercraftsCount)) AND
        (searchBy.PersonDataset.ThirdDegreeRelativesCount = '' OR ut.isNumeric(searchBy.PersonDataset.ThirdDegreeRelativesCount)) AND
				    (searchBy.PersonDataset.MARILicensesCount = '' OR ut.isNumeric(searchBy.PersonDataset.MARILicensesCount)) AND
								(searchBy.PersonDataset.PublicSanctnsCount = '' OR ut.isNumeric(searchBy.PersonDataset.PublicSanctnsCount)) AND
								(searchBy.PersonDataset.NonPublicSanctnsCount = '' OR ut.isNumeric(searchBy.PersonDataset.NonPublicSanctnsCount)) AND
								(searchBy.PersonDataset.FreddieMacSanctnsCount = '' OR ut.isNumeric(searchBy.PersonDataset.FreddieMacSanctnsCount));
      END; 

    EXPORT fn_checkForInputFailures(iesp.demosearchtool.t_DemoSearchToolSearchBy SearchBy,
	                                  iesp.demosearchtool.t_SearchOptions options) :=
      FUNCTION
      
         isValidInputCounts :=  
           MAP( options.isMultiBizAtSameAddress => ut.isNumeric(searchBy.BusinessDataset.NumMultiBusinessesCount), 
                options.isPersonSearch AND
                options.isBusinessSearch        => fn_ValididateInputCountsPerson(searchBy) AND
                                                   fn_ValididateInputCountsBiz(searchBy),
                options.isPersonSearch          => fn_ValididateInputCountsPerson(searchBy),
                                                   fn_ValididateInputCountsBiz(searchBy)
              );  
 
          errorCode := 
            MAP(NOT options.isMultiBizAtSameAddress AND 
                NOT options.isPersonSearch AND 
                NOT options.isBusinessSearch                    => 
                              ut.constants_MessageCodes.DEMO_SEARCH_TOOL_INVAILD_SEARCH_TYPE,
                searchBy.PersonDataset.isDirectToConsumer AND   
                options.isFCRA                                  =>
                              ut.constants_MessageCodes.DEMO_SEARCH_TOOL_INVAILD_SEARCH_OPTIONS, 
                options.isPersonSearch AND 
                (INTEGER1)searchBy.PersonDataset.NumOfBizExecutiveOfCount = 0 AND 
                options.isBusinessSearch                        =>
                              ut.constants_MessageCodes.DEMO_SEARCH_TOOL_INVAILD_NUM_BIZ,
                options.isMultiBizAtSameAddress AND 
                (INTEGER)searchBy.BusinessDataset.NumMultiBusinessesCount < 2 
                                                                =>
                              ut.constants_MessageCodes.DEMO_SEARCH_TOOL_INVAILD_SEARCH_INPUT,
                NOT isValidInputCounts                          =>
                              ut.constants_MessageCodes.DEMO_SEARCH_TOOL_INVAILD_SEARCH_INPUT,
                              0 /* no error code */
               );

        RETURN errorCode;

      END;

  END;