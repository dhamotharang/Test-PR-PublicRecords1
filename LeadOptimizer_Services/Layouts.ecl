IMPORT iesp, Insurance_ConsumerIID, InsuranceContext_iesp, Insurance_iesp,
       MarketDataPrefill, DriverDiscovery, IDLExternalLinking, CarrierDiscovery;

EXPORT Layouts := MODULE
	// insurance context
	EXPORT Layout_LeadMgmtInsContext						:= InsuranceContext_iesp.insurance_risk_context.t_LEADMGMTInsuranceContext;
	EXPORT Layout_LeadMgmtInstantIDRule					:= InsuranceContext_iesp.insurance_risk_context.t_InstantIDRuleStrcut;
	EXPORT Layout_LeadMgmtAMBest								:= iesp.share.t_StringArrayItem;
	EXPORT Layout_LeadMgmtRestrictedState				:= iesp.share.t_StringArrayItem;
	EXPORT Layout_LeadMgmtRestrictedZip					:= iesp.share.t_StringArrayItem;
	EXPORT Layout_LeadMgmtAllowedSourceAcct			:= iesp.share.t_StringArrayItem;
	EXPORT Layout_LeadMgmtVINInHouseStates			:= iesp.share.t_StringArrayItem;
	EXPORT Layout_LeadMgmtMarketViewScoring 		:= InsuranceContext_iesp.insurance_risk_context.t_MarketViewThresholdsStruct;
	EXPORT Layout_LeadMgmtMVScore_HigherBetter	:= InsuranceContext_iesp.insurance_risk_context.t_EvaluateStructHigherBetter;
	EXPORT Layout_LeadMgmtMVScore_LowerBetter 	:= InsuranceContext_iesp.insurance_risk_context.t_EvaluateStructLessBetter;
	EXPORT Layout_LeadMgmtMVScore_PassFailList	:= InsuranceContext_iesp.insurance_risk_context.t_InsightStruct;
	EXPORT Layout_LeadMgmtMVScore_PassValue			:= iesp.share.t_StringArrayItem;		
	EXPORT Layout_LeadMgmtMVScore_FailValue			:= iesp.share.t_StringArrayItem;
	EXPORT Layout_Gateways											:= InsuranceContext_iesp.AccountInformation.t_Gateway;

	// request/response
	EXPORT Layout_LeadMgmtRequest					:= Insurance_iesp.lead_optimizer.t_LeadOptimizerRequest;
	EXPORT Layout_LeadMgmtLeadInfo				:= Insurance_iesp.lead_optimizer.t_LeadInfoStruct;
	EXPORT Layout_LeadMgmtTargetSubject		:= Insurance_iesp.lead_optimizer.t_TargetSubjectStruct;
	EXPORT Layout_LeadMgmtTargetSubjPhone	:= Insurance_iesp.lead_optimizer.t_PhoneStruct;
	EXPORT Layout_LeadMgmtResponse				:= Insurance_iesp.lead_optimizer.t_LeadOptimizerResponse;
	EXPORT Layout_LeadMgmtResponseCarrier	:= Insurance_iesp.lead_optimizer.t_ResponseToCarrierStruct;
	EXPORT Layout_LeadMgmtResponseSource	:= Insurance_iesp.lead_optimizer.t_ResponseToLeadSourceStruct;
	EXPORT Layout_LeadMgmtResponseWarningMessage	:= Insurance_iesp.lead_optimizer.t_WarningMessageStruct;
	EXPORT Layout_LeadMgmtResponseExistingPolicy	:= Insurance_iesp.lead_optimizer.t_ExistingPolicyStruct;
	
	EXPORT Layout_SoapFault	:= RECORD
		STRING2048 soapfault;
	END;
	
	// Carrier Discovery layouts
	EXPORT Layout_CarrierDiscovery_FilteredPolicy := CarrierDiscovery.loadlayouts.filtered_policy_info;
	EXPORT Layout_CarrierDiscovery_FilteredHolder	:= CarrierDiscovery.loadlayouts.filtered_holder_info;
	EXPORT Layout_CarrierDiscoveryBasicPolicyInfo := RECORD
		Layout_CarrierDiscovery_FilteredPolicy.insurance_type;
		Layout_CarrierDiscovery_FilteredPolicy.ambest;
		Layout_CarrierDiscovery_FilteredPolicy.policy_number;
		Layout_CarrierDiscovery_FilteredPolicy.agent_id;
	END;

	// Instant ID layouts
	EXPORT Layout_IIDRequest  		:= iesp.instantid.t_InstantIDRequest;
	EXPORT Layout_IIDResponse 		:= {iesp.instantid.t_InstantIDResponseEx, Layout_SoapFault};
	EXPORT Layout_IIDWatchlist		:= iesp.share.t_StringArrayItem;
	EXPORT Layout_InstantIDRiskIndicator := RECORD
		STRING2 RiskIndicator;
	END;
	EXPORT Layout_InstantIDScores	:= RECORD
		STRING2 CVIScore;
		STRING2 NASScore;
		STRING2 NAPScore;
		DATASET(Layout_InstantIDRiskIndicator) RiskIndicators;		
	END;
	
	// MarketView layouts
	EXPORT Layout_MarketViewReq						:= MarketDataPrefill.Layouts.Layout_MDPReq;
	EXPORT Layout_MarketViewInsContext		:= MarketDataPrefill.Layouts.Layout_InsContext;
	EXPORT Layout_MarketViewResponse			:= {MarketDataPrefill.Layouts.Layout_MDPResp, Layout_SoapFault};
	EXPORT Layout_MarketViewSearchResult	:= {MarketDataPrefill.Layouts.Layout_AUTOKEY_FakeID, BOOLEAN bAmbiguousSearchResults};
	EXPORT Layout_MarketViewFilteredResult	:= MarketDataPrefill.Layouts.Layout_MDPResp;
	EXPORT Layout_MarketViewScoreResults	:= RECORD
		STRING1 ConsInsightResult;
		STRING1 ActivityResult;
		STRING1 MarketingRiskIndexResult;
		STRING1 MarketingAttractIndexResult;
		STRING1 MarketingNonstandardRiskIndexResult;
		STRING1 SpanishLanguagePreferenceResult;
		STRING1 ChannelPreferenceDirectResult;
		STRING1 ChannelPreferenceExclusiveResult;
		STRING1 ChannelPreferenceIndependentResult;
		STRING1 ChannelPreferenceCombinedResult;
		STRING1 ProspectSurvivalResult;
		STRING1 PremiumPotentialResult;
		STRING1 AnnuityResult;	
		STRING1 LongTermCareResult;
		STRING1 MedSuppResult;
		STRING1 MortgageProtectionResult;
		STRING1 LifeAttritionResult;
		STRING1 FinalExpenseResult;
		STRING1 CustomCompeteAllstateResult;
		STRING1 CustomCompeteTravelersResult;
		STRING1 Model1Result;
		STRING1 Model2Result;
		STRING1 Model3Result;
		STRING1 Model4Result;
		STRING1 Model5Result;
	END;
	
	// E-mail layouts
	EXPORT Layout_EmailRequest	:= iesp.emailsearch.t_EmailSearchRequest;
	EXPORT Layout_EmailResponse	:= {iesp.emailsearch.t_EmailSearchResponseEx, Layout_SoapFault};
	EXPORT Layout_SearchRecord	:= iesp.emailsearch.t_EmailSearchRecord;		
	EXPORT Layout_SearchEmail		:= iesp.emailsearch.t_EmailSearchEmail;
	EXPORT Layout_EmailAddress 	:= RECORD
		STRING EmailAddress;
	END;
	
	// Driver Discovery Layouts
	EXPORT Layout_DDRequest						:= DriverDiscovery.Layouts.Layout_DriverDiscovery_Inputs;
	EXPORT Layout_DDInsContext				:= InsuranceContext_iesp.DDInsuranceContext.t_DDInsuranceContext;
	EXPORt Layout_DDResponse					:= {DriverDiscovery.Layouts.Layout_DriverDiscovery_Outputs, Layout_SoapFault};
	EXPORT Layout_DDAffidavit					:= InsuranceContext_iesp.DDInsuranceContext.t_DDAffidavitID;
	EXPORT Layout_DDDiscoveredDriver	:= DriverDiscovery.Layouts.Layout_DriverDiscovery_DD;
	
	// VIN Layouts
	EXPORT Layout_VINInsuranceContext			:= InsuranceContext_iesp.VINInsuranceContext.t_VINInsuranceContext;
	EXPORT Layout_VINInsContextStateCodes	:= InsuranceContext_iesp.VINInsuranceContext.t_VINStateCodes;
	EXPORT Layout_VINRequest							:= Insurance_iesp.VinHouseholdOrder.t_VinHouseholdRequest;
	EXPORT Layout_VINResp									:= {Insurance_iesp.VinHouseholdReport.t_VinHouseholdResponse, Layout_SoapFault};
	EXPORT Layout_VINStateCodes						:= InsuranceContext_iesp.VINInsuranceContext.t_VINStateCodes;
	
	// CCVIN layouts
	EXPORT Layout_CCVINInsContext	:= InsuranceContext_iesp.CCInsuranceContext.t_CCInsuranceContext;
	EXPORT Layout_CCVINRequest		:= Insurance_iesp.V3CCVINInquiryRequest.t_CCVINInquiryRequest;
	EXPORT Layout_CCVINReqSubject	:= Insurance_iesp.V3CCVINInquiryRequest.t_PersonalIdSetV3CCVINInquiry;
	EXPORT Layout_CCVINResp				:= {Insurance_iesp.V3CCVINResultstoCustomerReport.t_CCVINCustResponse, Layout_SoapFault};
	EXPORT Layout_CCVINDevelopedVehicle := Insurance_iesp.V3CCVINResultstoCustomerReport.t_DevelopedVehicleSubSectionV3CCVINCustReport;
	
	// Watercraft layouts
	EXPORT Layout_WatercraftSearch		:= iesp.watercraft.t_WaterCraftSearch2Request;
	EXPORT Layout_WatercraftResponse	:= {iesp.watercraft.t_WaterCraftSearch2ResponseEx, Layout_SoapFault};
	EXPORT Layout_WatercraftOwner			:= iesp.watercraft.t_WaterCraftSearch2Owner;
	
	// HSI layouts
	EXPORT Layout_HSIRequest					:= iesp.insurance_score.t_InsuranceScoreRequest;
	EXPORT Layout_HSIInsContext				:= InsuranceContext_iesp.insurance_risk_context.t_InsuranceScoreContext;
	EXPORT Layout_HSIResponse					:= {iesp.insurance_score.t_InsuranceScoreResponse, Layout_SoapFault};
	EXPORT Layout_HSIReqSubject				:= iesp.ins_share.t_InsuranceInquirySubject;
	EXPORT Layout_HSIReqOptions				:= iesp.ins_share_iss.t_InsuranceScoreOptions;
	EXPORT Layout_HSIReqModel					:= iesp.ins_share_iss.t_InsuranceScoringModelRequested;
	EXPORT Layout_HSIReqMultiOptions	:= iesp.ins_multi_product_order.t_PublicRecordsOptions;
	EXPORT Layout_HSIReqModelAllow		:= InsuranceContext_iesp.insurance_risk_context.t_InsuranceScoreModel;
	EXPORT Layout_HSIScore						:= iesp.ins_share_iss.t_InsuranceScoringModelResult;
		
END;