/*
  BIPV2_Build.BWR_Check_BIPV2FullKeys_Queries
    -- check all queries to find out dependencies of attributes that you changed.
       This works by you sandboxing your changed attribute to cause it to have a syntax error.
       Then, all queries that use that attribute will fail.  you can total up the failures and have your list of queries 
       that use it.
    So:
    1. Sandbox your attribute to cause a syntax error, such as bipv2.idfunctions
    2. run this, and at the end, the ds_queries dataset result(the last result) should contain the queries 
       dependent on your attribute which are the ones that failed because of a syntax error
       in your attribute.
*/

your_attribute := 'bipv2.idfunctions'   ;   //change this to your attribute
your_version   := '20170425'            ;   //change this to today's date


ECL_AddressReport_Services_ReportService                                      := '#workunit(\'name\',\'AddressReport_Services.ReportService\');\n'                              + 'AddressReport_Services.ReportService();'                               ;
ECL_AML_AML_Batch_Service                                                     := '#workunit(\'name\',\'AML.AML_Batch_Service\');\n'                                             + 'AML.AML_Batch_Service();'                                              ;    
ECL_AML_AML_Service                                                           := '#workunit(\'name\',\'AML.AML_Service\');\n'                                                   + 'AML.AML_Service();'                                                    ;    
ECL_BatchServices_Accurint_Property_BatchService                              := '#workunit(\'name\',\'BatchServices.Accurint_Property_BatchService\');\n'                      + 'BatchServices.Accurint_Property_BatchService();'                       ;     
ECL_BatchServices_Bankruptcy_BatchService                                     := '#workunit(\'name\',\'BatchServices.Bankruptcy_BatchService\');\n'                             + 'BatchServices.Bankruptcy_BatchService();'                              ;
ECL_BatchServices_JudgmentsAndLiens_BatchService                              := '#workunit(\'name\',\'BatchServices.JudgmentsAndLiens_BatchService\');\n'                      + 'BatchServices.JudgmentsAndLiens_BatchService();'                       ;
ECL_BatchServices_Property_BatchService                                       := '#workunit(\'name\',\'BatchServices.Property_BatchService\');\n'                               + 'BatchServices.Property_BatchService();'                                ; 
ECL_BatchServices_TaxRefundISv3_BatchService                                  := '#workunit(\'name\',\'BatchServices.TaxRefundISv3_BatchService\');\n'                          + 'BatchServices.TaxRefundISv3_BatchService();'                           ;
ECL_BatchServices_TaxRefundIS_BatchService                                    := '#workunit(\'name\',\'BatchServices.TaxRefundIS_BatchService\');\n'                            + 'BatchServices.TaxRefundIS_BatchService();'                             ;
ECL_BatchServices_UCCLiens_BatchService                                       := '#workunit(\'name\',\'BatchServices.UCCLiens_BatchService\');\n'                               + 'BatchServices.UCCLiens_BatchService();'                                ; 
ECL_BIPV2_Company_Names_CompanyNameClean                                      := '#workunit(\'name\',\'BIPV2_Company_Names.CompanyNameClean\');\n'                              + 'BIPV2_Company_Names.CompanyNameClean();'                               ;
ECL_bipv2_company_names_svcbatchnamecleaner                                   := '#workunit(\'name\',\'bipv2_company_names.svcbatchnamecleaner\');\n'                           + 'bipv2_company_names.svcbatchnamecleaner();'                            ;
ECL_bipv2_hrchy_showservice                                                   := '#workunit(\'name\',\'bipv2_hrchy.showservice\');\n'                                           + 'bipv2_hrchy.showservice();'                                            ; 
ECL_BIPV2_LGID3_LGID3CompareService                                           := '#workunit(\'name\',\'BIPV2_LGID3.LGID3CompareService\');\n'                                   + 'BIPV2_LGID3.LGID3CompareService();'                                    ;
ECL_BIPV2_ProxID_ProxidCompareService                                         := '#workunit(\'name\',\'BIPV2_ProxID.ProxidCompareService\');\n'                                 + 'BIPV2_ProxID.ProxidCompareService();'                                  ;
ECL_BizLinkFull_Biz_Header_Service_2                                          := '#workunit(\'name\',\'BizLinkFull.Biz_Header_Service_2\');\n'                                  + 'BizLinkFull.Biz_Header_Service_2();'                                   ; 
ECL_BizLinkFull_svcBatch                                                      := '#workunit(\'name\',\'BizLinkFull.svcBatch\');\n'                                              + 'BizLinkFull.svcBatch();'                                               ;
ECL_bizlinkfull_svcwheelcity                                                  := '#workunit(\'name\',\'bizlinkfull.svcwheelcity\');\n'                                          + 'bizlinkfull.svcwheelcity();'                                           ;
ECL_BLJ_V2_Services_BLJSearchService                                          := '#workunit(\'name\',\'BLJ_V2_Services.BLJSearchService\');\n'                                  + 'BLJ_V2_Services.BLJSearchService();'                                   ; 
ECL_BusinessBatch_BIP_RollupService                                           := '#workunit(\'name\',\'BusinessBatch_BIP.RollupService\');\n'                                   + 'BusinessBatch_BIP.RollupService();'                                    ;
ECL_BusinessContactCard_ReportService                                         := '#workunit(\'name\',\'BusinessContactCard.ReportService\');\n'                                 + 'BusinessContactCard.ReportService();'                                  ;
ECL_BusinessCredit_Services_BusinessAuthRepSearchService                      := '#workunit(\'name\',\'BusinessCredit_Services.BusinessAuthRepSearchService\');\n'              + 'BusinessCredit_Services.BusinessAuthRepSearchService();'               ; 
ECL_BusinessCredit_Services_CreditBatchService                                := '#workunit(\'name\',\'BusinessCredit_Services.CreditBatchService\');\n'                        + 'BusinessCredit_Services.CreditBatchService();'                         ;
ECL_BusinessCredit_Services_CreditReportService                               := '#workunit(\'name\',\'BusinessCredit_Services.CreditReportService\');\n'                       + 'BusinessCredit_Services.CreditReportService();'                        ;
ECL_BusinessInstantID20_Services_InstantID20_Batch_Service                    := '#workunit(\'name\',\'BusinessInstantID20_Services.InstantID20_Batch_Service\');\n'            + 'BusinessInstantID20_Services.InstantID20_Batch_Service();'             ; 
ECL_BusinessInstantID20_Services_InstantID20_Service                          := '#workunit(\'name\',\'BusinessInstantID20_Services.InstantID20_Service\');\n'                  + 'BusinessInstantID20_Services.InstantID20_Service();'                   ;
ECL_Business_Risk_BIP_Business_Shell_Batch_Service                            := '#workunit(\'name\',\'Business_Risk_BIP.Business_Shell_Batch_Service\');\n'                    + 'Business_Risk_BIP.Business_Shell_Batch_Service();'                     ;
ECL_Business_Risk_BIP_Business_Shell_Service                                  := '#workunit(\'name\',\'Business_Risk_BIP.Business_Shell_Service\');\n'                          + 'Business_Risk_BIP.Business_Shell_Service();'                           ; 
ECL_Business_Risk_BIP_ProdData                                                := '#workunit(\'name\',\'Business_Risk_BIP.ProdData\');\n'                                        + 'Business_Risk_BIP.ProdData();'                                         ;
ECL_ChildIdentityFraudSolutionServices_BatchService                           := '#workunit(\'name\',\'ChildIdentityFraudSolutionServices.BatchService\');\n'                   + 'ChildIdentityFraudSolutionServices.BatchService();'                    ;
ECL_ChildIdentityFraudSolutionServices_ReportService                          := '#workunit(\'name\',\'ChildIdentityFraudSolutionServices.ReportService\');\n'                  + 'ChildIdentityFraudSolutionServices.ReportService();'                   ; 
ECL_Corp2_services_SOS_Batch_service                                          := '#workunit(\'name\',\'Corp2_services.SOS_Batch_service\');\n'                                  + 'Corp2_services.SOS_Batch_service();'                                   ;
ECL_DataInvestigation_Services_SmallBizDataInvestigationReportService         := '#workunit(\'name\',\'DataInvestigation_Services.SmallBizDataInvestigationReportService\');\n' + 'DataInvestigation_Services.SmallBizDataInvestigationReportService();'  ;
ECL_doxie_cbrs_Business_Report_Service                                        := '#workunit(\'name\',\'doxie_cbrs.Business_Report_Service\');\n'                                + 'doxie_cbrs.Business_Report_Service();'                                 ; 
ECL_doxie_cbrs_Profile_Report_Service                                         := '#workunit(\'name\',\'doxie_cbrs.Profile_Report_Service\');\n'                                 + 'doxie_cbrs.Profile_Report_Service();'                                  ;
ECL_FaaV2_Services_Batch_Service                                              := '#workunit(\'name\',\'FaaV2_Services.Batch_Service\');\n'                                      + 'FaaV2_Services.Batch_Service();'                                       ;
ECL_Foreclosure_Services_SearchService                                        := '#workunit(\'name\',\'Foreclosure_Services.SearchService\');\n'                                + 'Foreclosure_Services.SearchService();'                                 ; 
ECL_Gong_Services_GongHistorySearchService                                    := '#workunit(\'name\',\'Gong_Services.GongHistorySearchService\');\n'                            + 'Gong_Services.GongHistorySearchService();'                             ;
ECL_Healthcare_Header_Services_ResearchService                                := '#workunit(\'name\',\'Healthcare_Header_Services.ResearchService\');\n'                        + 'Healthcare_Header_Services.ResearchService();'                         ;
ECL_Healthcare_Provider_Services_report_service                               := '#workunit(\'name\',\'Healthcare_Provider_Services.report_service\');\n'                       + 'Healthcare_Provider_Services.report_service();'                        ; 
ECL_Healthcare_Provider_Services_SearchService                                := '#workunit(\'name\',\'Healthcare_Provider_Services.SearchService\');\n'                        + 'Healthcare_Provider_Services.SearchService();'                         ;
ECL_Healthcare_Provider_Services_SearchService_Batch                          := '#workunit(\'name\',\'Healthcare_Provider_Services.SearchService_Batch\');\n'                  + 'Healthcare_Provider_Services.SearchService_Batch();'                   ;
ECL_Healthcare_Services_DisclosedEntity_BatchService                          := '#workunit(\'name\',\'Healthcare_Services.DisclosedEntity_BatchService\');\n'                  + 'Healthcare_Services.DisclosedEntity_BatchService();'                   ; 
ECL_Healthcare_Services_DisclosedEntity_SearchService                         := '#workunit(\'name\',\'Healthcare_Services.DisclosedEntity_SearchService\');\n'                 + 'Healthcare_Services.DisclosedEntity_SearchService();'                  ;
ECL_Health_Facility_Services_xLNPID_Header_Service                            := '#workunit(\'name\',\'Health_Facility_Services.xLNPID_Header_Service\');\n'                    + 'Health_Facility_Services.xLNPID_Header_Service();'                     ;
ECL_Inquiry_Services_AccLog_Batch_Service                                     := '#workunit(\'name\',\'Inquiry_Services.AccLog_Batch_Service\');\n'                             + 'Inquiry_Services.AccLog_Batch_Service();'                              ; 
ECL_Inquiry_Services_Log_Service                                              := '#workunit(\'name\',\'Inquiry_Services.Log_Service\');\n'                                      + 'Inquiry_Services.Log_Service();'                                       ;
ECL_InView_Services_InViewReportService                                       := '#workunit(\'name\',\'InView_Services.InViewReportService\');\n'                               + 'InView_Services.InViewReportService();'                                ;
ECL_LiensV2_Services_LiensSearchService                                       := '#workunit(\'name\',\'LiensV2_Services.LiensSearchService\');\n'                               + 'LiensV2_Services.LiensSearchService();'                                ; 
ECL_LNSmallBusiness_SmallBusiness_BIP_Batch_Service                           := '#workunit(\'name\',\'LNSmallBusiness.SmallBusiness_BIP_Batch_Service\');\n'                   + 'LNSmallBusiness.SmallBusiness_BIP_Batch_Service();'                    ;
ECL_LNSmallBusiness_SmallBusiness_BIP_Combined_Service                        := '#workunit(\'name\',\'LNSmallBusiness.SmallBusiness_BIP_Combined_Service\');\n'                + 'LNSmallBusiness.SmallBusiness_BIP_Combined_Service();'                 ;
ECL_LNSmallBusiness_SmallBusiness_BIP_Service                                 := '#workunit(\'name\',\'LNSmallBusiness.SmallBusiness_BIP_Service\');\n'                         + 'LNSmallBusiness.SmallBusiness_BIP_Service();'                          ; 
ECL_LNSmallBusiness_SmallBusiness_Marketing_Batch_Service                     := '#workunit(\'name\',\'LNSmallBusiness.SmallBusiness_Marketing_Batch_Service\');\n'             + 'LNSmallBusiness.SmallBusiness_Marketing_Batch_Service();'              ;
ECL_LNSmallBusiness_SmallBusiness_Marketing_Service                           := '#workunit(\'name\',\'LNSmallBusiness.SmallBusiness_Marketing_Service\');\n'                   + 'LNSmallBusiness.SmallBusiness_Marketing_Service();'                    ;
ECL_LN_PropertyV2_Services_SearchService                                      := '#workunit(\'name\',\'LN_PropertyV2_Services.SearchService\');\n'                              + 'LN_PropertyV2_Services.SearchService();'                               ; 
ECL_Location_Services_LocationReportService                                   := '#workunit(\'name\',\'Location_Services.LocationReportService\');\n'                           + 'Location_Services.LocationReportService();'                            ;
ECL_MIDEX_Services_MidexReportService                                         := '#workunit(\'name\',\'MIDEX_Services.MidexReportService\');\n'                                 + 'MIDEX_Services.MidexReportService();'                                  ;
ECL_Models_ChargebackDefender_Batch_Service                                   := '#workunit(\'name\',\'Models.ChargebackDefender_Batch_Service\');\n'                           + 'Models.ChargebackDefender_Batch_Service();'                            ; 
ECL_Models_ChargebackDefender_Service                                         := '#workunit(\'name\',\'Models.ChargebackDefender_Service\');\n'                                 + 'Models.ChargebackDefender_Service();'                                  ;
ECL_Models_FraudAdvisor_Batch_Service                                         := '#workunit(\'name\',\'Models.FraudAdvisor_Batch_Service\');\n'                                 + 'Models.FraudAdvisor_Batch_Service();'                                  ;
ECL_Models_FraudAdvisor_Service                                               := '#workunit(\'name\',\'Models.FraudAdvisor_Service\');\n'                                       + 'Models.FraudAdvisor_Service();'                                        ; 
ECL_Models_OrderScore_Service                                                 := '#workunit(\'name\',\'Models.OrderScore_Service\');\n'                                         + 'Models.OrderScore_Service();'                                          ;
ECL_PersonReports_SmartLinxReportService                                      := '#workunit(\'name\',\'PersonReports.SmartLinxReportService\');\n'                              + 'PersonReports.SmartLinxReportService();'                               ;
ECL_ProfileBooster_Batch_Service                                              := '#workunit(\'name\',\'ProfileBooster.Batch_Service\');\n'                                      + 'ProfileBooster.Batch_Service();'                                       ; 
ECL_ProfileBooster_Search_Service                                             := '#workunit(\'name\',\'ProfileBooster.Search_Service\');\n'                                     + 'ProfileBooster.Search_Service();'                                      ;
ECL_prof_LicenseV2_Services_Discpl_Batch_Service                              := '#workunit(\'name\',\'prof_LicenseV2_Services.Discpl_Batch_Service\');\n'                      + 'prof_LicenseV2_Services.Discpl_Batch_Service();'                       ;
ECL_prof_LicenseV2_Services_Medlic_Batch_Service                              := '#workunit(\'name\',\'prof_LicenseV2_Services.Medlic_Batch_Service\');\n'                      + 'prof_LicenseV2_Services.Medlic_Batch_Service();'                       ; 
ECL_prof_LicenseV2_Services_Medlic_PL_Combined_Batch_Service                  := '#workunit(\'name\',\'prof_LicenseV2_Services.Medlic_PL_Combined_Batch_Service\');\n'          + 'prof_LicenseV2_Services.Medlic_PL_Combined_Batch_Service();'           ;
ECL_PublicProfileServices_ReportService                                       := '#workunit(\'name\',\'PublicProfileServices.ReportService\');\n'                               + 'PublicProfileServices.ReportService();'                                ;
ECL_RelationshipIdentifier_Services_Batch_Service                             := '#workunit(\'name\',\'RelationshipIdentifier_Services.Batch_Service\');\n'                     + 'RelationshipIdentifier_Services.Batch_Service();'                      ; 
ECL_RelationshipIdentifier_Services_Report_Service                            := '#workunit(\'name\',\'RelationshipIdentifier_Services.Report_Service\');\n'                    + 'RelationshipIdentifier_Services.Report_Service();'                     ;
ECL_RelationshipIdentifier_Services_Search_Service                            := '#workunit(\'name\',\'RelationshipIdentifier_Services.Search_Service\');\n'                    + 'RelationshipIdentifier_Services.Search_Service();'                     ;
ECL_Residency_Services_BatchService                                           := '#workunit(\'name\',\'Residency_Services.BatchService\');\n'                                   + 'Residency_Services.BatchService();'                                    ; 
ECL_RiskWise_RiskWiseMainCDxO                                                 := '#workunit(\'name\',\'RiskWise.RiskWiseMainCDxO\');\n'                                         + 'RiskWise.RiskWiseMainCDxO();'                                          ;
ECL_RiskWise_RiskWiseMainSC1O                                                 := '#workunit(\'name\',\'RiskWise.RiskWiseMainSC1O\');\n'                                         + 'RiskWise.RiskWiseMainSC1O();'                                          ;
ECL_RiskWise_SC1O_Batch_Service                                               := '#workunit(\'name\',\'RiskWise.SC1O_Batch_Service\');\n'                                       + 'RiskWise.SC1O_Batch_Service();'                                        ; 
ECL_Risk_Indicators_Boca_Shell_BtSt_Service                                   := '#workunit(\'name\',\'Risk_Indicators.Boca_Shell_BtSt_Service\');\n'                           + 'Risk_Indicators.Boca_Shell_BtSt_Service();'                            ;
ECL_SAM_Services_Batch_Service                                                := '#workunit(\'name\',\'SAM_Services.Batch_Service\');\n'                                        + 'SAM_Services.Batch_Service();'                                         ;
ECL_Statewide_Services_CountService                                           := '#workunit(\'name\',\'Statewide_Services.CountService\');\n'                                   + 'Statewide_Services.CountService();'                                    ; 
ECL_Statewide_Services_FAB_SearchService                                      := '#workunit(\'name\',\'Statewide_Services.FAB_SearchService\');\n'                              + 'Statewide_Services.FAB_SearchService();'                               ;
ECL_Statewide_Services_FAP_SearchService                                      := '#workunit(\'name\',\'Statewide_Services.FAP_SearchService\');\n'                              + 'Statewide_Services.FAP_SearchService();'                               ;
ECL_SupplierRisk_Services_SupplierRiskReport_Service                          := '#workunit(\'name\',\'SupplierRisk_Services.SupplierRiskReport_Service\');\n'                  + 'SupplierRisk_Services.SupplierRiskReport_Service();'                   ; 
ECL_TaxRefundIS_Service_SearchService                                         := '#workunit(\'name\',\'TaxRefundIS_Service.SearchService\');\n'                                 + 'TaxRefundIS_Service.SearchService();'                                  ;
ECL_TeaserSearchServices_ReversePhoneTeaserService                            := '#workunit(\'name\',\'TeaserSearchServices.ReversePhoneTeaserService\');\n'                    + 'TeaserSearchServices.ReversePhoneTeaserService();'                     ;
ECL_TopBusiness_Services_BusinessReportComprehensive                          := '#workunit(\'name\',\'TopBusiness_Services.BusinessReportComprehensive\');\n'                  + 'TopBusiness_Services.BusinessReportComprehensive();'                   ; 
ECL_TopBusiness_Services_BusinessSearch                                       := '#workunit(\'name\',\'TopBusiness_Services.BusinessSearch\');\n'                               + 'TopBusiness_Services.BusinessSearch();'                                ;
ECL_TopBusiness_Services_SourceCountService                                   := '#workunit(\'name\',\'TopBusiness_Services.SourceCountService\');\n'                           + 'TopBusiness_Services.SourceCountService();'                            ;
ECL_TopBusiness_Services_SourceService                                        := '#workunit(\'name\',\'TopBusiness_Services.SourceService\');\n'                                + 'TopBusiness_Services.SourceService();'                                 ; 
ECL_UCCv2_Services_UCCSearchService                                           := '#workunit(\'name\',\'UCCv2_Services.UCCSearchService\');\n'                                   + 'UCCv2_Services.UCCSearchService();'                                    ;
ECL_VehicleV2_Services_RealTime_Batch_Service_V2                              := '#workunit(\'name\',\'VehicleV2_Services.RealTime_Batch_Service_V2\');\n'                      + 'VehicleV2_Services.RealTime_Batch_Service_V2();'                       ;
ECL_VehicleV2_Services_Vin_Batch_Service                                      := '#workunit(\'name\',\'VehicleV2_Services.Vin_Batch_Service\');\n'                              + 'VehicleV2_Services.Vin_Batch_Service();'                               ; 
ECL_WatercraftV2_Services_Batch_Service                                       := '#workunit(\'name\',\'WatercraftV2_Services.Batch_Service\');\n'                               + 'WatercraftV2_Services.Batch_Service();'                                ;
                                                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                          
cluster := wk_ut._Constants.LocalHthor;

Kick_AddressReport_Services_ReportService                                := wk_ut.mac_ChainWuids(ECL_AddressReport_Services_ReportService                                    ,1 ,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_AML_AML_Batch_Service                                               := wk_ut.mac_ChainWuids(ECL_AML_AML_Batch_Service                                                   ,2 ,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_AML_AML_Service                                                     := wk_ut.mac_ChainWuids(ECL_AML_AML_Service                                                         ,3 ,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_BatchServices_Accurint_Property_BatchService                        := wk_ut.mac_ChainWuids(ECL_BatchServices_Accurint_Property_BatchService                            ,4 ,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_BatchServices_Bankruptcy_BatchService                               := wk_ut.mac_ChainWuids(ECL_BatchServices_Bankruptcy_BatchService                                   ,5 ,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_BatchServices_JudgmentsAndLiens_BatchService                        := wk_ut.mac_ChainWuids(ECL_BatchServices_JudgmentsAndLiens_BatchService                            ,6 ,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_BatchServices_Property_BatchService                                 := wk_ut.mac_ChainWuids(ECL_BatchServices_Property_BatchService                                     ,7 ,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_BatchServices_TaxRefundISv3_BatchService                            := wk_ut.mac_ChainWuids(ECL_BatchServices_TaxRefundISv3_BatchService                                ,8 ,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_BatchServices_TaxRefundIS_BatchService                              := wk_ut.mac_ChainWuids(ECL_BatchServices_TaxRefundIS_BatchService                                  ,9 ,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_BatchServices_UCCLiens_BatchService                                 := wk_ut.mac_ChainWuids(ECL_BatchServices_UCCLiens_BatchService                                     ,10,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_BIPV2_Company_Names_CompanyNameClean                                := wk_ut.mac_ChainWuids(ECL_BIPV2_Company_Names_CompanyNameClean                                    ,11,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_bipv2_company_names_svcbatchnamecleaner                             := wk_ut.mac_ChainWuids(ECL_bipv2_company_names_svcbatchnamecleaner                                 ,12,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_bipv2_hrchy_showservice                                             := wk_ut.mac_ChainWuids(ECL_bipv2_hrchy_showservice                                                 ,13,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_BIPV2_LGID3_LGID3CompareService                                     := wk_ut.mac_ChainWuids(ECL_BIPV2_LGID3_LGID3CompareService                                         ,14,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_BIPV2_ProxID_ProxidCompareService                                   := wk_ut.mac_ChainWuids(ECL_BIPV2_ProxID_ProxidCompareService                                       ,15,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_BizLinkFull_Biz_Header_Service_2                                    := wk_ut.mac_ChainWuids(ECL_BizLinkFull_Biz_Header_Service_2                                        ,16,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_BizLinkFull_svcBatch                                                := wk_ut.mac_ChainWuids(ECL_BizLinkFull_svcBatch                                                    ,17,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_bizlinkfull_svcwheelcity                                            := wk_ut.mac_ChainWuids(ECL_bizlinkfull_svcwheelcity                                                ,18,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_BLJ_V2_Services_BLJSearchService                                    := wk_ut.mac_ChainWuids(ECL_BLJ_V2_Services_BLJSearchService                                        ,19,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_BusinessBatch_BIP_RollupService                                     := wk_ut.mac_ChainWuids(ECL_BusinessBatch_BIP_RollupService                                         ,20,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_BusinessContactCard_ReportService                                   := wk_ut.mac_ChainWuids(ECL_BusinessContactCard_ReportService                                       ,21,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_BusinessCredit_Services_BusinessAuthRepSearchService                := wk_ut.mac_ChainWuids(ECL_BusinessCredit_Services_BusinessAuthRepSearchService                    ,22,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_BusinessCredit_Services_CreditBatchService                          := wk_ut.mac_ChainWuids(ECL_BusinessCredit_Services_CreditBatchService                              ,23,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_BusinessCredit_Services_CreditReportService                         := wk_ut.mac_ChainWuids(ECL_BusinessCredit_Services_CreditReportService                             ,24,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_BusinessInstantID20_Services_InstantID20_Batch_Service              := wk_ut.mac_ChainWuids(ECL_BusinessInstantID20_Services_InstantID20_Batch_Service                  ,25,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_BusinessInstantID20_Services_InstantID20_Service                    := wk_ut.mac_ChainWuids(ECL_BusinessInstantID20_Services_InstantID20_Service                        ,26,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_Business_Risk_BIP_Business_Shell_Batch_Service                      := wk_ut.mac_ChainWuids(ECL_Business_Risk_BIP_Business_Shell_Batch_Service                          ,27,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_Business_Risk_BIP_Business_Shell_Service                            := wk_ut.mac_ChainWuids(ECL_Business_Risk_BIP_Business_Shell_Service                                ,28,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_Business_Risk_BIP_ProdData                                          := wk_ut.mac_ChainWuids(ECL_Business_Risk_BIP_ProdData                                              ,29,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_ChildIdentityFraudSolutionServices_BatchService                     := wk_ut.mac_ChainWuids(ECL_ChildIdentityFraudSolutionServices_BatchService                         ,30,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_ChildIdentityFraudSolutionServices_ReportService                    := wk_ut.mac_ChainWuids(ECL_ChildIdentityFraudSolutionServices_ReportService                        ,31,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_Corp2_services_SOS_Batch_service                                    := wk_ut.mac_ChainWuids(ECL_Corp2_services_SOS_Batch_service                                        ,32,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_DataInvestigation_Services_SmallBizDataInvestigationReportService   := wk_ut.mac_ChainWuids(ECL_DataInvestigation_Services_SmallBizDataInvestigationReportService       ,33,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_doxie_cbrs_Business_Report_Service                                  := wk_ut.mac_ChainWuids(ECL_doxie_cbrs_Business_Report_Service                                      ,34,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_doxie_cbrs_Profile_Report_Service                                   := wk_ut.mac_ChainWuids(ECL_doxie_cbrs_Profile_Report_Service                                       ,35,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_FaaV2_Services_Batch_Service                                        := wk_ut.mac_ChainWuids(ECL_FaaV2_Services_Batch_Service                                            ,36,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_Foreclosure_Services_SearchService                                  := wk_ut.mac_ChainWuids(ECL_Foreclosure_Services_SearchService                                      ,37,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_Gong_Services_GongHistorySearchService                              := wk_ut.mac_ChainWuids(ECL_Gong_Services_GongHistorySearchService                                  ,38,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_Healthcare_Header_Services_ResearchService                          := wk_ut.mac_ChainWuids(ECL_Healthcare_Header_Services_ResearchService                              ,39,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_Healthcare_Provider_Services_report_service                         := wk_ut.mac_ChainWuids(ECL_Healthcare_Provider_Services_report_service                             ,40,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_Healthcare_Provider_Services_SearchService                          := wk_ut.mac_ChainWuids(ECL_Healthcare_Provider_Services_SearchService                              ,41,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_Healthcare_Provider_Services_SearchService_Batch                    := wk_ut.mac_ChainWuids(ECL_Healthcare_Provider_Services_SearchService_Batch                        ,42,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_Healthcare_Services_DisclosedEntity_BatchService                    := wk_ut.mac_ChainWuids(ECL_Healthcare_Services_DisclosedEntity_BatchService                        ,43,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_Healthcare_Services_DisclosedEntity_SearchService                   := wk_ut.mac_ChainWuids(ECL_Healthcare_Services_DisclosedEntity_SearchService                       ,44,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_Health_Facility_Services_xLNPID_Header_Service                      := wk_ut.mac_ChainWuids(ECL_Health_Facility_Services_xLNPID_Header_Service                          ,45,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_Inquiry_Services_AccLog_Batch_Service                               := wk_ut.mac_ChainWuids(ECL_Inquiry_Services_AccLog_Batch_Service                                   ,46,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_Inquiry_Services_Log_Service                                        := wk_ut.mac_ChainWuids(ECL_Inquiry_Services_Log_Service                                            ,47,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_InView_Services_InViewReportService                                 := wk_ut.mac_ChainWuids(ECL_InView_Services_InViewReportService                                     ,48,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_LiensV2_Services_LiensSearchService                                 := wk_ut.mac_ChainWuids(ECL_LiensV2_Services_LiensSearchService                                     ,49,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_LNSmallBusiness_SmallBusiness_BIP_Batch_Service                     := wk_ut.mac_ChainWuids(ECL_LNSmallBusiness_SmallBusiness_BIP_Batch_Service                         ,50,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_LNSmallBusiness_SmallBusiness_BIP_Combined_Service                  := wk_ut.mac_ChainWuids(ECL_LNSmallBusiness_SmallBusiness_BIP_Combined_Service                      ,51,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_LNSmallBusiness_SmallBusiness_BIP_Service                           := wk_ut.mac_ChainWuids(ECL_LNSmallBusiness_SmallBusiness_BIP_Service                               ,52,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_LNSmallBusiness_SmallBusiness_Marketing_Batch_Service               := wk_ut.mac_ChainWuids(ECL_LNSmallBusiness_SmallBusiness_Marketing_Batch_Service                   ,53,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_LNSmallBusiness_SmallBusiness_Marketing_Service                     := wk_ut.mac_ChainWuids(ECL_LNSmallBusiness_SmallBusiness_Marketing_Service                         ,54,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_LN_PropertyV2_Services_SearchService                                := wk_ut.mac_ChainWuids(ECL_LN_PropertyV2_Services_SearchService                                    ,55,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_Location_Services_LocationReportService                             := wk_ut.mac_ChainWuids(ECL_Location_Services_LocationReportService                                 ,56,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_MIDEX_Services_MidexReportService                                   := wk_ut.mac_ChainWuids(ECL_MIDEX_Services_MidexReportService                                       ,57,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_Models_ChargebackDefender_Batch_Service                             := wk_ut.mac_ChainWuids(ECL_Models_ChargebackDefender_Batch_Service                                 ,58,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_Models_ChargebackDefender_Service                                   := wk_ut.mac_ChainWuids(ECL_Models_ChargebackDefender_Service                                       ,59,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_Models_FraudAdvisor_Batch_Service                                   := wk_ut.mac_ChainWuids(ECL_Models_FraudAdvisor_Batch_Service                                       ,60,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_Models_FraudAdvisor_Service                                         := wk_ut.mac_ChainWuids(ECL_Models_FraudAdvisor_Service                                             ,61,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_Models_OrderScore_Service                                           := wk_ut.mac_ChainWuids(ECL_Models_OrderScore_Service                                               ,62,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_PersonReports_SmartLinxReportService                                := wk_ut.mac_ChainWuids(ECL_PersonReports_SmartLinxReportService                                    ,63,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_ProfileBooster_Batch_Service                                        := wk_ut.mac_ChainWuids(ECL_ProfileBooster_Batch_Service                                            ,64,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_ProfileBooster_Search_Service                                       := wk_ut.mac_ChainWuids(ECL_ProfileBooster_Search_Service                                           ,65,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_prof_LicenseV2_Services_Discpl_Batch_Service                        := wk_ut.mac_ChainWuids(ECL_prof_LicenseV2_Services_Discpl_Batch_Service                            ,66,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_prof_LicenseV2_Services_Medlic_Batch_Service                        := wk_ut.mac_ChainWuids(ECL_prof_LicenseV2_Services_Medlic_Batch_Service                            ,67,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_prof_LicenseV2_Services_Medlic_PL_Combined_Batch_Service            := wk_ut.mac_ChainWuids(ECL_prof_LicenseV2_Services_Medlic_PL_Combined_Batch_Service                ,68,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_PublicProfileServices_ReportService                                 := wk_ut.mac_ChainWuids(ECL_PublicProfileServices_ReportService                                     ,69,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_RelationshipIdentifier_Services_Batch_Service                       := wk_ut.mac_ChainWuids(ECL_RelationshipIdentifier_Services_Batch_Service                           ,70,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_RelationshipIdentifier_Services_Report_Service                      := wk_ut.mac_ChainWuids(ECL_RelationshipIdentifier_Services_Report_Service                          ,71,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_RelationshipIdentifier_Services_Search_Service                      := wk_ut.mac_ChainWuids(ECL_RelationshipIdentifier_Services_Search_Service                          ,72,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_Residency_Services_BatchService                                     := wk_ut.mac_ChainWuids(ECL_Residency_Services_BatchService                                         ,73,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_RiskWise_RiskWiseMainCDxO                                           := wk_ut.mac_ChainWuids(ECL_RiskWise_RiskWiseMainCDxO                                               ,74,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_RiskWise_RiskWiseMainSC1O                                           := wk_ut.mac_ChainWuids(ECL_RiskWise_RiskWiseMainSC1O                                               ,75,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_RiskWise_SC1O_Batch_Service                                         := wk_ut.mac_ChainWuids(ECL_RiskWise_SC1O_Batch_Service                                             ,76,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_Risk_Indicators_Boca_Shell_BtSt_Service                             := wk_ut.mac_ChainWuids(ECL_Risk_Indicators_Boca_Shell_BtSt_Service                                 ,77,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_SAM_Services_Batch_Service                                          := wk_ut.mac_ChainWuids(ECL_SAM_Services_Batch_Service                                              ,78,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_Statewide_Services_CountService                                     := wk_ut.mac_ChainWuids(ECL_Statewide_Services_CountService                                         ,79,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_Statewide_Services_FAB_SearchService                                := wk_ut.mac_ChainWuids(ECL_Statewide_Services_FAB_SearchService                                    ,80,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_Statewide_Services_FAP_SearchService                                := wk_ut.mac_ChainWuids(ECL_Statewide_Services_FAP_SearchService                                    ,81,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_SupplierRisk_Services_SupplierRiskReport_Service                    := wk_ut.mac_ChainWuids(ECL_SupplierRisk_Services_SupplierRiskReport_Service                        ,82,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_TaxRefundIS_Service_SearchService                                   := wk_ut.mac_ChainWuids(ECL_TaxRefundIS_Service_SearchService                                       ,83,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_TeaserSearchServices_ReversePhoneTeaserService                      := wk_ut.mac_ChainWuids(ECL_TeaserSearchServices_ReversePhoneTeaserService                          ,84,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_TopBusiness_Services_BusinessReportComprehensive                    := wk_ut.mac_ChainWuids(ECL_TopBusiness_Services_BusinessReportComprehensive                        ,85,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_TopBusiness_Services_BusinessSearch                                 := wk_ut.mac_ChainWuids(ECL_TopBusiness_Services_BusinessSearch                                     ,86,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_TopBusiness_Services_SourceCountService                             := wk_ut.mac_ChainWuids(ECL_TopBusiness_Services_SourceCountService                                 ,87,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_TopBusiness_Services_SourceService                                  := wk_ut.mac_ChainWuids(ECL_TopBusiness_Services_SourceService                                      ,88,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_UCCv2_Services_UCCSearchService                                     := wk_ut.mac_ChainWuids(ECL_UCCv2_Services_UCCSearchService                                         ,89,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_VehicleV2_Services_RealTime_Batch_Service_V2                        := wk_ut.mac_ChainWuids(ECL_VehicleV2_Services_RealTime_Batch_Service_V2                            ,90,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_VehicleV2_Services_Vin_Batch_Service                                := wk_ut.mac_ChainWuids(ECL_VehicleV2_Services_Vin_Batch_Service                                    ,91,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');
Kick_WatercraftV2_Services_Batch_Service                                 := wk_ut.mac_ChainWuids(ECL_WatercraftV2_Services_Batch_Service                                     ,92,1,your_version,,cluster,pForceSkip := true,pPollingFrequency := '1');

mylay := wk_ut.Layouts.wks_slim;

ds_wuids := wk_ut.get_DS_Result(workunit  ,'Workunits',mylay);

ds_queries := project(ds_wuids(STD.Str.Find( STD.Str.ToUpperCase(trim(errors)), STD.Str.ToUpperCase(your_attribute), 1 ) > 0),transform({string wuid,string query}
  ,self.wuid := left.wuid
  ,self.query := regexfind('([[:alnum:]_]*?[.][[:alnum:]_]*?)[(][)];',wk_ut.get_WUInfo(left.wuid).Query,1,nocase)
));
                                                                                                                                                                              
sequential(                                                                                                                                                                    
   Kick_AddressReport_Services_ReportService                                                                                                                                   
  ,Kick_AML_AML_Batch_Service                                                                                                                                                  
  ,Kick_AML_AML_Service                                                                                                                                                        
  ,Kick_BatchServices_Accurint_Property_BatchService                                                                                                                           
  ,Kick_BatchServices_Bankruptcy_BatchService                                                                                                                                  
  ,Kick_BatchServices_JudgmentsAndLiens_BatchService                     
  ,Kick_BatchServices_Property_BatchService                              
  ,Kick_BatchServices_TaxRefundISv3_BatchService                         
  ,Kick_BatchServices_TaxRefundIS_BatchService                           
  ,Kick_BatchServices_UCCLiens_BatchService                              
  ,Kick_BIPV2_Company_Names_CompanyNameClean                             
  ,Kick_bipv2_company_names_svcbatchnamecleaner                          
  ,Kick_bipv2_hrchy_showservice                                          
  ,Kick_BIPV2_LGID3_LGID3CompareService                                  
  ,Kick_BIPV2_ProxID_ProxidCompareService                                
  ,Kick_BizLinkFull_Biz_Header_Service_2                                 
  ,Kick_BizLinkFull_svcBatch                                             
  ,Kick_bizlinkfull_svcwheelcity                                         
  ,Kick_BLJ_V2_Services_BLJSearchService                                 
  ,Kick_BusinessBatch_BIP_RollupService                                  
  ,Kick_BusinessContactCard_ReportService                                
  ,Kick_BusinessCredit_Services_BusinessAuthRepSearchService             
  ,Kick_BusinessCredit_Services_CreditBatchService                       
  ,Kick_BusinessCredit_Services_CreditReportService                      
  ,Kick_BusinessInstantID20_Services_InstantID20_Batch_Service           
  ,Kick_BusinessInstantID20_Services_InstantID20_Service                 
  ,Kick_Business_Risk_BIP_Business_Shell_Batch_Service                   
  ,Kick_Business_Risk_BIP_Business_Shell_Service                         
  ,Kick_Business_Risk_BIP_ProdData                                       
  ,Kick_ChildIdentityFraudSolutionServices_BatchService                  
  ,Kick_ChildIdentityFraudSolutionServices_ReportService                 
  ,Kick_Corp2_services_SOS_Batch_service                                 
  ,Kick_DataInvestigation_Services_SmallBizDataInvestigationReportService
  ,Kick_doxie_cbrs_Business_Report_Service                               
  ,Kick_doxie_cbrs_Profile_Report_Service                                
  ,Kick_FaaV2_Services_Batch_Service                                     
  ,Kick_Foreclosure_Services_SearchService                               
  ,Kick_Gong_Services_GongHistorySearchService                           
  ,Kick_Healthcare_Header_Services_ResearchService                       
  ,Kick_Healthcare_Provider_Services_report_service                      
  ,Kick_Healthcare_Provider_Services_SearchService                       
  ,Kick_Healthcare_Provider_Services_SearchService_Batch                 
  ,Kick_Healthcare_Services_DisclosedEntity_BatchService                 
  ,Kick_Healthcare_Services_DisclosedEntity_SearchService                
  ,Kick_Health_Facility_Services_xLNPID_Header_Service                   
  ,Kick_Inquiry_Services_AccLog_Batch_Service                            
  ,Kick_Inquiry_Services_Log_Service                                     
  ,Kick_InView_Services_InViewReportService                              
  ,Kick_LiensV2_Services_LiensSearchService                              
  ,Kick_LNSmallBusiness_SmallBusiness_BIP_Batch_Service                  
  ,Kick_LNSmallBusiness_SmallBusiness_BIP_Combined_Service               
  ,Kick_LNSmallBusiness_SmallBusiness_BIP_Service                        
  ,Kick_LNSmallBusiness_SmallBusiness_Marketing_Batch_Service            
  ,Kick_LNSmallBusiness_SmallBusiness_Marketing_Service                  
  ,Kick_LN_PropertyV2_Services_SearchService                             
  ,Kick_Location_Services_LocationReportService                          
  ,Kick_MIDEX_Services_MidexReportService                                
  ,Kick_Models_ChargebackDefender_Batch_Service                          
  ,Kick_Models_ChargebackDefender_Service                                
  ,Kick_Models_FraudAdvisor_Batch_Service                                
  ,Kick_Models_FraudAdvisor_Service                                      
  ,Kick_Models_OrderScore_Service                                        
  ,Kick_PersonReports_SmartLinxReportService                             
  ,Kick_ProfileBooster_Batch_Service                                     
  ,Kick_ProfileBooster_Search_Service                                    
  ,Kick_prof_LicenseV2_Services_Discpl_Batch_Service                     
  ,Kick_prof_LicenseV2_Services_Medlic_Batch_Service                     
  ,Kick_prof_LicenseV2_Services_Medlic_PL_Combined_Batch_Service         
  ,Kick_PublicProfileServices_ReportService                              
  ,Kick_RelationshipIdentifier_Services_Batch_Service                    
  ,Kick_RelationshipIdentifier_Services_Report_Service                   
  ,Kick_RelationshipIdentifier_Services_Search_Service                   
  ,Kick_Residency_Services_BatchService                                  
  ,Kick_RiskWise_RiskWiseMainCDxO                                        
  ,Kick_RiskWise_RiskWiseMainSC1O                                        
  ,Kick_RiskWise_SC1O_Batch_Service                                      
  ,Kick_Risk_Indicators_Boca_Shell_BtSt_Service                          
  ,Kick_SAM_Services_Batch_Service                                       
  ,Kick_Statewide_Services_CountService                                  
  ,Kick_Statewide_Services_FAB_SearchService                             
  ,Kick_Statewide_Services_FAP_SearchService                             
  ,Kick_SupplierRisk_Services_SupplierRiskReport_Service                 
  ,Kick_TaxRefundIS_Service_SearchService                                
  ,Kick_TeaserSearchServices_ReversePhoneTeaserService                   
  ,Kick_TopBusiness_Services_BusinessReportComprehensive                 
  ,Kick_TopBusiness_Services_BusinessSearch                              
  ,Kick_TopBusiness_Services_SourceCountService                          
  ,Kick_TopBusiness_Services_SourceService                               
  ,Kick_UCCv2_Services_UCCSearchService                                
  ,Kick_VehicleV2_Services_RealTime_Batch_Service_V2                     
  ,Kick_VehicleV2_Services_Vin_Batch_Service                             
  ,Kick_WatercraftV2_Services_Batch_Service  
  ,output(ds_queries,named('ds_queries'),all)
);