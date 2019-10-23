IMPORT BIPV2, BIPV2_Best, Business_Header, iesp, Infutor, Watchdog;

EXPORT Transforms := 
  MODULE

   /* ************************************************************************
	  *                 Create Input module                                    *
	  **************************************************************************/
   
   EXPORT DemoSearchTool.Layouts.SearchInput_rec 
     xfm_initializeInput(iesp.demoSearchTool.t_DemoSearchToolSearchBy SearchBy,
                         iesp.demoSearchTool.t_SearchOptions options) := 
     TRANSFORM
      SELF.Biz_AddressesCount := 
        IF(searchBy.BusinessDataset.AddressesCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.AddressesCount);
      SELF.Biz_AssociatesCount := 
        IF(searchBy.BusinessDataset.AssociatesCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.AssociatesCount);
      SELF.Biz_BankruptciesCount := 
        IF(searchBy.BusinessDataset.BankruptciesCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.BankruptciesCount);
      SELF.in_Biz_BusinessHeader := searchBy.BusinessDataset.inBusinessHeader;
      SELF.Biz_CorporateFilingsCount := 
        IF(searchBy.BusinessDataset.CorporateFilingsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.CorporateFilingsCount);
      SELF.Biz_DirectoryAssistanceCount := 
        IF(searchBy.BusinessDataset.DirectoryAssistanceCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.DirectoryAssistanceCount);
      SELF.Biz_EvictionsCount := 
        IF(searchBy.BusinessDataset.EvictionsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.EvictionsCount);
      SELF.Biz_ExecutivesCount := 
        IF(searchBy.BusinessDataset.ExecutivesCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.ExecutivesCount);
      SELF.Biz_FAAAircraftsCount := 
        IF(searchBy.BusinessDataset.FAAAircraftsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.FAAAircraftsCount);
      SELF.Biz_FictitiousBusinessesCount := 
        IF(searchBy.BusinessDataset.FictitiousBusinessesCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.FictitiousBusinessesCount);
      SELF.Biz_ForclosuresCount := 
        IF(searchBy.BusinessDataset.ForclosuresCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.ForclosuresCount);
      SELF.in_Biz_GlobalWatchListOFAC := searchBy.BusinessDataset.inGlobalWatchListOFAC;
      SELF.Biz_GlobalWatchListsCount := 
        IF(searchBy.BusinessDataset.GlobalWatchListsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.GlobalWatchListsCount);
      SELF.Biz_Industry_NAICSCount := 
        IF(searchBy.BusinessDataset.Industry_NAICSCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.Industry_NAICSCount);
      SELF.Biz_InternetDomainsCount := 
        IF(searchBy.BusinessDataset.InternetDomainsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.InternetDomainsCount);
      SELF.Biz_JudgmentsCount := 
        IF(searchBy.BusinessDataset.JudgmentsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.JudgmentsCount);
      SELF.Biz_LiensCount := 
        IF(searchBy.BusinessDataset.LiensCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.LiensCount);
      SELF.Biz_MotorVehiclesCount := 
        IF(searchBy.BusinessDataset.MotorVehiclesCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.MotorVehiclesCount);
      SELF.Biz_NameVariationsCount := 
        IF(searchBy.BusinessDataset.NameVariationsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.NameVariationsCount);
      SELF.Biz_NumMultiBusinessesCount := 
        IF(searchBy.BusinessDataset.NumMultiBusinessesCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.NumMultiBusinessesCount);
      SELF.Biz_PropertiesCount := 
        IF(searchBy.BusinessDataset.PropertiesCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.PropertiesCount);
      SELF.Biz_RegistrationsCount := 
        IF(searchBy.BusinessDataset.RegistrationsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.RegistrationsCount); 
      SELF.Biz_RegisteredAgentsCount := 
        IF(searchBy.BusinessDataset.RegisteredAgentsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.RegisteredAgentsCount);
      SELF.Biz_UCCFilingsCount := 
        IF(searchBy.BusinessDataset.UCCFilingsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.UCCFilingsCount);
      SELF.Biz_WatercraftsCount := 
        IF(searchBy.BusinessDataset.WatercraftsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.WatercraftsCount);
//Adding new datasets
// /*
       SELF.Biz_MARILicensesCount := 
        IF(searchBy.BusinessDataset.MARILicensesCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.MARILicensesCount);
					 SELF.Biz_PublicSanctnsCount := 
        IF(searchBy.BusinessDataset.PublicSanctnsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.PublicSanctnsCount);
					 SELF.Biz_NonPublicSanctnsCount := 
        IF(searchBy.BusinessDataset.NonPublicSanctnsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.NonPublicSanctnsCount);
					 SELF.Biz_FreddieMacSanctnsCount := 
        IF(searchBy.BusinessDataset.FreddieMacSanctnsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.BusinessDataset.FreddieMacSanctnsCount);
	// */		
			
			SELF.Per_AddressesCount := 
        IF(searchBy.PersonDataset.AddressesCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.AddressesCount);
      SELF.Per_AKAsCount := 
      IF(searchBy.PersonDataset.AKAsCount = '',
         DemoSearchTool.Constants.DEFAULT_INTEGER,
         (INTEGER2)searchBy.PersonDataset.AKAsCount);
      SELF.Per_AssociatesCount := 
        IF(searchBy.PersonDataset.AssociatesCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.AssociatesCount);
      SELF.Per_BankruptciesCount := 
        IF(searchBy.PersonDataset.BankruptciesCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.BankruptciesCount);
      SELF.Per_CorporateAffiliationsCount := 
        IF(searchBy.PersonDataset.CorporateAffiliationsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.CorporateAffiliationsCount);
      SELF.Per_CriminalDeptOfCorrectionsCount := 
        IF(searchBy.PersonDataset.CriminalDeptOfCorrectionsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.CriminalDeptOfCorrectionsCount);
      SELF.Per_CriminalRecordsCount := 
        IF(searchBy.PersonDataset.CriminalRecordsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.CriminalRecordsCount);
      SELF.in_Per_DeathKey := searchBy.PersonDataset.inDeath;
      SELF.Per_DirectoryAssistanceCount := 
        IF(searchBy.PersonDataset.DirectoryAssistanceCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.DirectoryAssistanceCount);
      SELF.Per_DriverLicenseCount := 
        IF(searchBy.PersonDataset.DriverLicenseCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.DriverLicenseCount);
      SELF.Per_EmailsCount := 
        IF(searchBy.PersonDataset.EmailsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.EmailsCount);
      SELF.Per_EvictionsCount := 
        IF(searchBy.PersonDataset.EvictionsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.EvictionsCount);
      SELF.Per_FAAAircraftsCount := 
        IF(searchBy.PersonDataset.FAAAircraftsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.FAAAircraftsCount);
      SELF.Per_FirstDegreeRelativesCount := 
        IF(searchBy.PersonDataset.FirstDegreeRelativesCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.FirstDegreeRelativesCount);
      SELF.Per_ForclosuresCount := 
        IF(searchBy.PersonDataset.ForclosuresCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.ForclosuresCount);
      SELF.in_Per_GlobalWatchListOFAC := searchBy.PersonDataset.inGlobalWatchListOFAC;
      SELF.Per_GlobalWatchListsCount := 
        IF(searchBy.PersonDataset.GlobalWatchListsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.GlobalWatchListsCount);
      SELF.has_Per_HighRiskIndicatorAddress := searchBy.PersonDataset.hasHighRiskIndicatorAddress;
      SELF.has_Per_HighRiskIndicatorSSN := searchBy.PersonDataset.hasHighRiskIndicatorSSN;
      SELF.Per_JudgmentsCount := 
        IF(searchBy.PersonDataset.JudgmentsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.JudgmentsCount);
      SELF.Per_LiensCount := 
        IF(searchBy.PersonDataset.LiensCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.LiensCount);
      SELF.Per_MarriageDivorceCount := 
        IF(searchBy.PersonDataset.MarriageDivorceCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.MarriageDivorceCount);
      SELF.Per_MotorVehiclesCount := 
        IF(searchBy.PersonDataset.MotorVehiclesCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.MotorVehiclesCount);
      SELF.Per_NeighborsCount := 
        IF(searchBy.PersonDataset.NeighborsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.NeighborsCount);
      SELF.Per_NoticesOfDefaultCount:= 
        IF(searchBy.PersonDataset.NoticesOfDefaultCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.NoticesOfDefaultCount);
      SELF.Per_NumOfBizExecutiveOfCount := 
        IF(searchBy.PersonDataset.NumOfBizExecutiveOfCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.NumOfBizExecutiveOfCount);
      SELF.Per_PeopleAtWorkCount := 
        IF(searchBy.PersonDataset.PeopleAtWorkCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.PeopleAtWorkCount);
      SELF.in_Per_PersonHeader := searchBy.PersonDataset.inPersonHeader;
      SELF.Per_PhonesPlusCount := 
        IF(searchBy.PersonDataset.PhonesPlusCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.PhonesPlusCount);
      SELF.Per_ProfessionalLicensesCount := 
        IF(searchBy.PersonDataset.ProfessionalLicensesCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.ProfessionalLicensesCount);
      SELF.Per_PropertiesCount := 
        IF(searchBy.PersonDataset.PropertiesCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.PropertiesCount);
      SELF.Per_RegisteredAgentsCount := 
        IF(searchBy.PersonDataset.RegisteredAgentsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.RegisteredAgentsCount);
      SELF.Per_SecondDegreeRelativesCount := 
        IF(searchBy.PersonDataset.SecondDegreeRelativesCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.SecondDegreeRelativesCount);
      SELF.Per_SexualOffenderCount := 
        IF(searchBy.PersonDataset.SexualOffenderCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.SexualOffenderCount);
      SELF.Per_SSNsCount := 
        IF(searchBy.PersonDataset.SSNsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.SSNsCount);
      SELF.Per_ThirdDegreeRelativesCount := 
        IF(searchBy.PersonDataset.ThirdDegreeRelativesCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.ThirdDegreeRelativesCount);
      SELF.Per_WatercraftsCount := 
        IF(searchBy.PersonDataset.WatercraftsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.WatercraftsCount);
   //Adding new datasets   
	 // /*
						SELF.Per_MARILicensesCount := 
        IF(searchBy.PersonDataset.MARILicensesCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.MARILicensesCount);
						SELF.Per_PublicSanctnsCount := 
        IF(searchBy.PersonDataset.PublicSanctnsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.PublicSanctnsCount);	 
						SELF.Per_NonPublicSanctnsCount := 
        IF(searchBy.PersonDataset.NonPublicSanctnsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.NonPublicSanctnsCount);
					 SELF.Per_FreddieMacSanctnsCount := 
        IF(searchBy.PersonDataset.FreddieMacSanctnsCount = '',
           DemoSearchTool.Constants.DEFAULT_INTEGER,
           (INTEGER2)searchBy.PersonDataset.FreddieMacSanctnsCount);
// */
			SELF.isFCRA := options.isFCRA; 
	   END;
    
    
    /* ****************************************************************
     *          TRANSFORMS INTO IESP LAYOUTS                          *
     ******************************************************************/
     
    EXPORT iesp.demoSearchTool.t_BusinessInformation 
      xfm_intoBusinessLayout_bdid(RECORDOF(Business_Header.Key_BH_Best) rw_in) :=
      TRANSFORM
        SELF.BusinessId := (STRING)rw_in.bdid;
        SELF.CompanyName := rw_in.company_name;  
        SELF.Address := iesp.ECL2ESP.SetAddress((STRING28)rw_in.prim_name, 
                                                (STRING10)rw_in.prim_range, 
                                                (STRING2)rw_in.predir, 
                                                (STRING2)rw_in.postdir,
                                                (STRING4)rw_in.addr_suffix, 
                                                (STRING10)rw_in.unit_desig, 
                                                (STRING8)rw_in.sec_range, 
                                                (STRING25)rw_in.city,
                                                (STRING2)rw_in.state, 
                                                (STRING5)rw_in.zip, 
                                                (STRING4)rw_in.zip4,'');
        SELF.PhoneNumber := (STRING10)rw_in.phone;
        SELF.FEIN := (STRING9)rw_in.FEIN;
        SELF := []; // there are no LinkIds in the BDID key 
      END;


    EXPORT iesp.demoSearchTool.t_BusinessInformation 
      xfm_intoBusinessLayout_BipIds(RECORDOF(BIPV2_Best.Key_LinkIds.kfetch2
                                    (DATASET([],BIPV2.IDlayouts.l_xlink_ids2),
                                    BIPV2.IDconstants.Fetch_Level_SELEID,,,
                                    DemoSearchTool.Constants.BIZ_HEADER_KFETCH_MAX_LIMIT)) rw_in ) :=
      TRANSFORM
        SELF.BusinessId := (STRING)rw_in.company_bdid;
        SELF.CompanyName := rw_in.company_name[1].company_name;  
        SELF.Address := iesp.ECL2ESP.SetAddress(rw_in.company_address[1].company_prim_name, 
                                                rw_in.company_address[1].company_prim_range, 
                                                rw_in.company_address[1].company_predir, 
                                                rw_in.company_address[1].company_postdir,
                                                rw_in.company_address[1].company_addr_suffix, 
                                                rw_in.company_address[1].company_unit_desig, 
                                                rw_in.company_address[1].company_sec_range, 
                                                rw_in.company_address[1].address_v_city_name,
                                                rw_in.company_address[1].company_st, 
                                                rw_in.company_address[1].company_zip5, 
                                                rw_in.company_address[1].company_zip4,'');
        SELF.PhoneNumber := (STRING10)rw_in.company_phone[1].company_phone;
        SELF.FEIN := (STRING9)rw_in.company_FEIN[1].company_fein;
        SELF.BusinessIds.DotId  := rw_in.DotId;
        SELF.BusinessIds.EmpId  := rw_in.EmpId;
        SELF.BusinessIds.PowId  := rw_in.PowId;
        SELF.BusinessIds.ProxId := rw_in.ProxId;
        SELF.BusinessIds.SeleId := rw_in.SeleId;
        SELF.BusinessIds.OrgId  := rw_in.OrgId;
        SELF.BusinessIds.UltId  := rw_in.UltId;
      END;
 
 
    EXPORT iesp.demoSearchTool.t_PersonInformation 
      xfm_intoPersonLayout( RECORDOF(Watchdog.Key_Prep_Watchdog_GLB(FALSE)) rw_in) :=
      TRANSFORM
        DemoSearchTool.Macros.mac_xfmCombinedPersonKeyFields(rw_in);
        SELF.Name := iesp.ECL2ESP.SetName(rw_in.fname, rw_in.mname, rw_in.lname, 
                                          rw_in.name_suffix, (STRING3)rw_in.title);
        SELF := rw_in; // SSN
      END;
   

    EXPORT iesp.demoSearchTool.t_PersonInformation 
      xfm_intoDtcLayout( RECORDOF(Infutor.key_infutor_best_did) rw_in) :=
      TRANSFORM
        DemoSearchTool.Macros.mac_xfmCombinedPersonKeyFields(rw_in);
        SELF.Name := iesp.ECL2ESP.SetName(rw_in.fname, rw_in.mname, rw_in.lname, 
                                          '', '');
        SELF := rw_in; // SSN
      END;
     
  END;