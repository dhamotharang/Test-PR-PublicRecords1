import ProfileBooster, risk_indicators;

export V2_getBankingExperiance(dataset(ProfileBooster.V2_Layouts.Layout_PB2_BatchOut) clam) := FUNCTION

 MODEL_DEBUG := false;
 //MODEL_DEBUG := True;
 
 
#if(MODEL_DEBUG)
 layout_debug := record
	real  b1_gbm_logit;
	real  b2_gbm_logit;
	real  b3_gbm_logit;
	real  b4_gbm_logit;
ProfileBooster.V2_Layouts.Layout_PB2_BatchOut;
	END;
layout_debug doModel( clam le ) := TRANSFORM
  #else
		ProfileBooster.V2_Layouts.Layout_PB2_BatchOut doModel( clam le ) := TRANSFORM
  #end

//Start: ECL SAS mapping variables 
v1_VerifiedProspectFound 				:=	(integer)le.attributes.version1.VerifiedProspectFound;					
v1_VerifiedName 								:=	 (integer)le.attributes.version1.VerifiedName;					
v1_VerifiedSSN 									:=	 (integer)le.attributes.version1.VerifiedSSN;					
v1_VerifiedPhone 								:=	 (integer)le.attributes.version1.VerifiedPhone;					
v1_VerifiedCurrResMatchIndex 		:=	 (integer)le.attributes.version1.VerifiedCurrResMatchIndex;					
v1_ProspectTimeOnRecord 				:=	 (integer)le.attributes.version1.ProspectTimeOnRecord;					
v1_ProspectTimeLastUpdate 			:=	 (integer)le.attributes.version1.ProspectTimeLastUpdate;					
v1_ProspectLastUpdate12Mo 			:=	 (integer)le.attributes.version1.ProspectLastUpdate12Mo;					
v1_ProspectAge 									:=	 (integer)le.attributes.version1.ProspectAge;					
v1_ProspectGender 							:=	 (string2)le.attributes.version1.ProspectGender;					
v1_ProspectMaritalStatus 				:=	 (string)le.attributes.version1.ProspectMaritalStatus;					
v1_ProspectEstimatedIncomeRange :=	 (integer)le.attributes.version1.ProspectEstimatedIncomeRange;					
v1_ProspectDeceased 						:=	 (integer)le.attributes.version1.ProspectDeceased;					
v1_ProspectCollegeAttending 		:=	 (integer)le.attributes.version1.ProspectCollegeAttending;					
v1_ProspectCollegeAttended 			:=	 (integer)le.attributes.version1.ProspectCollegeAttended;					
v1_ProspectCollegeProgramType 	:=	 (integer)le.attributes.version1.ProspectCollegeProgramType;					
v1_ProspectCollegePrivate 			:=	 (integer)le.attributes.version1.ProspectCollegePrivate;					
v1_ProspectCollegeTier 					:=	 (integer)le.attributes.version1.ProspectCollegeTier;					
v1_ProspectBankingExperience 		:=	 (integer)le.attributes.version1.ProspectBankingExperience;					
v1_AssetCurrOwner 							:=	 (integer)le.attributes.version1.AssetCurrOwner;					
v1_PropCurrOwner 								:=	 (integer)le.attributes.version1.PropCurrOwner;					
v1_PropCurrOwnedCnt 						:=	 (integer)le.attributes.version1.PropCurrOwnedCnt;					
v1_PropCurrOwnedAssessedTtl 		:=	 (integer)le.attributes.version1.PropCurrOwnedAssessedTtl;					
v1_PropCurrOwnedAVMTtl 					:=	 (integer)le.attributes.version1.PropCurrOwnedAVMTtl;					
v1_PropTimeLastSale 						:=	 (integer)le.attributes.version1.PropTimeLastSale;					
v1_PropEverOwnedCnt 						:=	 (integer)le.attributes.version1.PropEverOwnedCnt;					
v1_PropEverSoldCnt 							:=	 (integer)le.attributes.version1.PropEverSoldCnt;					
v1_PropSoldCnt12Mo 							:=	 (integer)le.attributes.version1.PropSoldCnt12Mo;					
v1_PropSoldRatio 								:=	 (real)le.attributes.version1.PropSoldRatio;					
v1_PropPurchaseCnt12Mo 					:=	 (integer)le.attributes.version1.PropPurchaseCnt12Mo;					
v1_PPCurrOwner 									:=	 (integer)le.attributes.version1.PPCurrOwner;					
v1_PPCurrOwnedCnt 							:=	 (integer)le.attributes.version1.PPCurrOwnedCnt;					
v1_PPCurrOwnedAutoCnt 					:=	 (integer)le.attributes.version1.PPCurrOwnedAutoCnt;					
v1_PPCurrOwnedMtrcycleCnt 			:=	 (integer)le.attributes.version1.PPCurrOwnedMtrcycleCnt;					
v1_PPCurrOwnedAircrftCnt 				:=	 (integer)le.attributes.version1.PPCurrOwnedAircrftCnt;					
v1_PPCurrOwnedWtrcrftCnt 				:=	 (integer)le.attributes.version1.PPCurrOwnedWtrcrftCnt;					
v1_LifeEvTimeLastMove 					:=	 (integer)le.attributes.version1.LifeEvTimeLastMove;					
v1_LifeEvNameChange 						:=	 (integer)le.attributes.version1.LifeEvNameChange;					
v1_LifeEvNameChangeCnt12Mo 			:=	 (integer)le.attributes.version1.LifeEvNameChangeCnt12Mo;					
v1_LifeEvTimeFirstAssetPurchase :=	 (integer)le.attributes.version1.LifeEvTimeFirstAssetPurchase;					
v1_LifeEvTimeLastAssetPurchase 	:=	 (integer)le.attributes.version1.LifeEvTimeLastAssetPurchase;					
v1_LifeEvEverResidedCnt 				:=	 (integer)le.attributes.version1.LifeEvEverResidedCnt;					
v1_LifeEvLastMoveTaxRatioDiff 	:=	 (real)le.attributes.version1.LifeEvLastMoveTaxRatioDiff;					
v1_LifeEvEconTrajectory 				:=	 (integer)le.attributes.version1.LifeEvEconTrajectory;					
v1_LifeEvEconTrajectoryIndex 		:=	 (integer)le.attributes.version1.LifeEvEconTrajectoryIndex;					
v1_ResCurrOwnershipIndex 				:=	 (Integer)le.attributes.version1.ResCurrOwnershipIndex;					
v1_ResCurrAVMValue 							:=	 (integer)le.attributes.version1.ResCurrAVMValue;					
v1_ResCurrAVMValue12Mo 					:=	 (Unsigned)le.attributes.version1.ResCurrAVMValue12Mo;					
v1_ResCurrAVMRatioDiff12Mo 			:=	 (real)le.attributes.version1.ResCurrAVMRatioDiff12Mo;					
v1_ResCurrAVMValue60Mo 					:=	 (Unsigned)le.attributes.version1.ResCurrAVMValue60Mo;					
v1_ResCurrAVMRatioDiff60Mo 			:=	 (real)le.attributes.version1.ResCurrAVMRatioDiff60Mo;					
v1_ResCurrAVMCntyRatio 					:=	 (real)le.attributes.version1.ResCurrAVMCntyRatio;					
v1_ResCurrAVMTractRatio 				:=	 (real)le.attributes.version1.ResCurrAVMTractRatio;					
v1_ResCurrAVMBlockRatio 				:=	 (real)le.attributes.version1.ResCurrAVMBlockRatio;					
v1_ResCurrDwellType 						:=	 (string2)le.attributes.version1.ResCurrDwellType;					
v1_ResCurrDwellTypeIndex 				:=	 (Unsigned1)le.attributes.version1.ResCurrDwellTypeIndex;					
v1_ResCurrMortgageType 					:=	 (Integer)le.attributes.version1.ResCurrMortgageType;					
v1_ResCurrMortgageAmount 				:=	 (Unsigned4)le.attributes.version1.ResCurrMortgageAmount;					
v1_ResCurrBusinessCnt 					:=	 (Unsigned2)le.attributes.version1.ResCurrBusinessCnt;					
v1_ResInputOwnershipIndex 			:=	 (Unsigned1)le.attributes.version1.ResInputOwnershipIndex;					
v1_ResInputAVMValue 						:=	 (Unsigned4)le.attributes.version1.ResInputAVMValue;					
v1_ResInputAVMValue12Mo 				:=	 (Unsigned4)le.attributes.version1.ResInputAVMValue12Mo;					
v1_ResInputAVMRatioDiff12Mo 		:=	 (Real)le.attributes.version1.ResInputAVMRatioDiff12Mo;					
v1_ResInputAVMValue60Mo 				:=	 (Unsigned4)le.attributes.version1.ResInputAVMValue60Mo;					
v1_ResInputAVMRatioDiff60Mo 		:=	 (Real)le.attributes.version1.ResInputAVMRatioDiff60Mo;					
v1_ResInputAVMCntyRatio 				:=	 (real)le.attributes.version1.ResInputAVMCntyRatio;					
v1_ResInputAVMTractRatio 				:=	 (real)le.attributes.version1.ResInputAVMTractRatio;					
v1_ResInputAVMBlockRatio 				:=	 (real)le.attributes.version1.ResInputAVMBlockRatio;					
v1_ResInputDwellType 						:=	 (string2)le.attributes.version1.ResInputDwellType;					
v1_ResInputDwellTypeIndex 			:=	 (Unsigned1)le.attributes.version1.ResInputDwellTypeIndex;					
v1_ResInputMortgageType 				:=	 (Integer)le.attributes.version1.ResInputMortgageType;					
v1_ResInputMortgageAmount 			:=	 (Unsigned4)le.attributes.version1.ResInputMortgageAmount;					
v1_ResInputBusinessCnt 					:=	 (integer)le.attributes.version1.ResInputBusinessCnt;					
v1_CrtRecCnt 										:=	 (integer)le.attributes.version1.CrtRecCnt;					
v1_CrtRecCnt12Mo 								:=	 (integer)le.attributes.version1.CrtRecCnt12Mo;					
v1_CrtRecTimeNewest 						:=	 (integer)le.attributes.version1.CrtRecTimeNewest;					
v1_CrtRecFelonyCnt 							:=	 (integer)le.attributes.version1.CrtRecFelonyCnt;					
v1_CrtRecFelonyCnt12Mo 					:=	 (integer)le.attributes.version1.CrtRecFelonyCnt12Mo;					
v1_CrtRecFelonyTimeNewest 			:=	 (integer)le.attributes.version1.CrtRecFelonyTimeNewest;					
v1_CrtRecMsdmeanCnt 						:=	 (integer)le.attributes.version1.CrtRecMsdmeanCnt;					
v1_CrtRecMsdmeanCnt12Mo 				:=	 (integer)le.attributes.version1.CrtRecMsdmeanCnt12Mo;					
v1_CrtRecMsdmeanTimeNewest 			:=	 (integer)le.attributes.version1.CrtRecMsdmeanTimeNewest;					
v1_CrtRecEvictionCnt 						:=	 (integer)le.attributes.version1.CrtRecEvictionCnt;					
v1_CrtRecEvictionCnt12Mo 				:=	 (integer)le.attributes.version1.CrtRecEvictionCnt12Mo;					
v1_CrtRecEvictionTimeNewest 		:=	 (integer)le.attributes.version1.CrtRecEvictionTimeNewest;					
v1_CrtRecLienJudgCnt 						:=	 (integer)le.attributes.version1.CrtRecLienJudgCnt;					
v1_CrtRecLienJudgCnt12Mo 				:=	 (integer)le.attributes.version1.CrtRecLienJudgCnt12Mo;					
v1_CrtRecLienJudgTimeNewest 		:=	 (integer)le.attributes.version1.CrtRecLienJudgTimeNewest;					
v1_CrtRecLienJudgAmtTtl 				:=	 (integer)le.attributes.version1.CrtRecLienJudgAmtTtl;					
v1_CrtRecBkrptCnt 							:=	 (integer)le.attributes.version1.CrtRecBkrptCnt;					
v1_CrtRecBkrptCnt12Mo 					:=	 (integer)le.attributes.version1.CrtRecBkrptCnt12Mo;					
v1_CrtRecBkrptTimeNewest 				:=	 (integer)le.attributes.version1.CrtRecBkrptTimeNewest;					
v1_CrtRecSeverityIndex 					:=	 (integer)le.attributes.version1.CrtRecSeverityIndex;					
v1_OccProfLicense 							:=	 (integer)le.attributes.version1.OccProfLicense;					
v1_OccProfLicenseCategory 			:=	 (integer)le.attributes.version1.OccProfLicenseCategory;					
v1_OccBusinessAssociation 			:=	 (integer)le.attributes.version1.OccBusinessAssociation;					
v1_OccBusinessAssociationTime 	:=	 (integer)le.attributes.version1.OccBusinessAssociationTime;					
v1_OccBusinessTitleLeadership 	:=	 (integer)le.attributes.version1.OccBusinessTitleLeadership;					
v1_InterestSportPerson 					:=	 (integer)le.attributes.version1.InterestSportPerson;					
v1_HHTeenagerMmbrCnt 						:=	 (integer)le.attributes.version1.HHTeenagerMmbrCnt;					
v1_HHYoungAdultMmbrCnt 					:=	 (integer)le.attributes.version1.HHYoungAdultMmbrCnt;					
v1_HHMiddleAgemmbrCnt 					:=	 (integer)le.attributes.version1.HHMiddleAgemmbrCnt;					
v1_HHSeniorMmbrCnt 							:=	 (integer)le.attributes.version1.HHSeniorMmbrCnt;					
v1_HHElderlyMmbrCnt 						:=	 (integer)le.attributes.version1.HHElderlyMmbrCnt;					
v1_HHCnt 												:=	 (integer)le.attributes.version1.HHCnt;					
v1_HHEstimatedIncomeRange 			:=	 (integer)le.attributes.version1.HHEstimatedIncomeRange;					
v1_HHCollegeAttendedMmbrCnt 		:=	 (integer)le.attributes.version1.HHCollegeAttendedMmbrCnt;					
v1_HHCollege2yrAttendedMmbrCnt 	:=	 (integer)le.attributes.version1.HHCollege2yrAttendedMmbrCnt;					
v1_HHCollege4yrAttendedMmbrCnt 	:=	 (integer)le.attributes.version1.HHCollege4yrAttendedMmbrCnt;					
v1_HHCollegeGradAttendedMmbrCnt :=	 (integer)le.attributes.version1.HHCollegeGradAttendedMmbrCnt;					
v1_HHCollegePrivateMmbrCnt 			:=	 (integer)le.attributes.version1.HHCollegePrivateMmbrCnt;					
v1_HHCollegeTierMmbrHighest 		:=	 (integer)le.attributes.version1.HHCollegeTierMmbrHighest;					
v1_HHPropCurrOwnerMmbrCnt 			:=	 (integer)le.attributes.version1.HHPropCurrOwnerMmbrCnt;					
v1_HHPropCurrOwnedCnt 					:=	 (integer)le.attributes.version1.HHPropCurrOwnedCnt;					
v1_HHPropCurrAVMHighest 				:=	 (integer)le.attributes.version1.HHPropCurrAVMHighest;					
v1_HHPPCurrOwnedCnt 						:=	 (integer)le.attributes.version1.HHPPCurrOwnedCnt;					
v1_HHPPCurrOwnedAutoCnt 				:=	 (integer)le.attributes.version1.HHPPCurrOwnedAutoCnt;					
v1_HHPPCurrOwnedMtrcycleCnt 		:=	 (integer)le.attributes.version1.HHPPCurrOwnedMtrcycleCnt;					
v1_HHPPCurrOwnedAircrftCnt 			:=	 (integer)le.attributes.version1.HHPPCurrOwnedAircrftCnt;					
v1_HHPPCurrOwnedWtrcrftCnt 			:=	 (integer)le.attributes.version1.HHPPCurrOwnedWtrcrftCnt;					
v1_HHCrtRecMmbrCnt 							:=	 (integer)le.attributes.version1.HHCrtRecMmbrCnt;					
v1_HHCrtRecMmbrCnt12Mo 					:=	 (integer)le.attributes.version1.HHCrtRecMmbrCnt12Mo;					
v1_HHCrtRecFelonyMmbrCnt 				:=	 (integer)le.attributes.version1.HHCrtRecFelonyMmbrCnt;					
v1_HHCrtRecFelonyMmbrCnt12Mo 		:=	 (integer)le.attributes.version1.HHCrtRecFelonyMmbrCnt12Mo;					
v1_HHCrtRecMsdmeanMmbrCnt 			:=	 (integer)le.attributes.version1.HHCrtRecMsdmeanMmbrCnt;					
v1_HHCrtRecMsdmeanMmbrCnt12Mo 	:=	 (integer)le.attributes.version1.HHCrtRecMsdmeanMmbrCnt12Mo;					
v1_HHCrtRecEvictionMmbrCnt 			:=	 (integer)le.attributes.version1.HHCrtRecEvictionMmbrCnt;					
v1_HHCrtRecEvictionMmbrCnt12Mo 	:=	 (integer)le.attributes.version1.HHCrtRecEvictionMmbrCnt12Mo;					
v1_HHCrtRecLienJudgMmbrCnt 			:=	 (integer)le.attributes.version1.HHCrtRecLienJudgMmbrCnt;					
v1_HHCrtRecLienJudgMmbrCnt12Mo 	:=	 (integer)le.attributes.version1.HHCrtRecLienJudgMmbrCnt12Mo;					
v1_HHCrtRecLienJudgAmtTtl 			:=	 (integer)le.attributes.version1.HHCrtRecLienJudgAmtTtl;					
v1_HHCrtRecBkrptMmbrCnt 				:=	 (integer)le.attributes.version1.HHCrtRecBkrptMmbrCnt;					
v1_HHCrtRecBkrptMmbrCnt12Mo 		:=	 (integer)le.attributes.version1.HHCrtRecBkrptMmbrCnt12Mo;					
v1_HHCrtRecBkrptMmbrCnt24Mo 		:=	 (integer)le.attributes.version1.HHCrtRecBkrptMmbrCnt24Mo;					
v1_HHOccProfLicMmbrCnt 					:=	 (integer)le.attributes.version1.HHOccProfLicMmbrCnt;					
v1_HHOccBusinessAssocMmbrCnt 		:=	 (integer)le.attributes.version1.HHOccBusinessAssocMmbrCnt;					
v1_HHInterestSportPersonMmbrCnt :=	 (integer)le.attributes.version1.HHInterestSportPersonMmbrCnt;					
v1_RaATeenageMmbrCnt 						:=	 (integer)le.attributes.version1.RaATeenageMmbrCnt;					
v1_RaAYoungAdultMmbrCnt 				:=	 (integer)le.attributes.version1.RaAYoungAdultMmbrCnt;					
v1_RaAMiddleAgeMmbrCnt 					:=	 (integer)le.attributes.version1.RaAMiddleAgeMmbrCnt;					
v1_RaASeniorMmbrCnt 						:=	 (integer)le.attributes.version1.RaASeniorMmbrCnt;					
v1_RaAElderlyMmbrCnt 						:=	 (integer)le.attributes.version1.RaAElderlyMmbrCnt;					
v1_RaAHHCnt 										:=	 (integer)le.attributes.version1.RaAHHCnt;					
v1_RaAMmbrCnt 									:=	 (integer)le.attributes.version1.RaAMmbrCnt;					
v1_RaAMedIncomeRange 						:=	 (integer)le.attributes.version1.RaAMedIncomeRange;					
v1_RaACollegeAttendedMmbrCnt 		:=	 (integer)le.attributes.version1.RaACollegeAttendedMmbrCnt;					
v1_RaACollege2yrAttendedMmbrCnt :=	 (integer)le.attributes.version1.RaACollege2yrAttendedMmbrCnt;					
v1_RaACollege4yrAttendedMmbrCnt :=	 (integer)le.attributes.version1.RaACollege4yrAttendedMmbrCnt;					
v1_RaACollegeGradAttendedMmbrCnt:=	 (integer)le.attributes.version1.RaACollegeGradAttendedMmbrCnt;					
v1_RaACollegePrivateMmbrCnt 		:=	 (integer)le.attributes.version1.RaACollegePrivateMmbrCnt;					
v1_RaACollegeTopTierMmbrCnt 		:=	 (integer)le.attributes.version1.RaACollegeTopTierMmbrCnt;					
v1_RaACollegeMidTierMmbrCnt 		:=	 (integer)le.attributes.version1.RaACollegeMidTierMmbrCnt;					
v1_RaACollegeLowTierMmbrCnt 		:=	 (integer)le.attributes.version1.RaACollegeLowTierMmbrCnt;					
v1_RaAPropCurrOwnerMmbrCnt 			:=	 (integer)le.attributes.version1.RaAPropCurrOwnerMmbrCnt;					
v1_RaAPropOwnerAVMHighest 			:=	 (integer)le.attributes.version1.RaAPropOwnerAVMHighest;					
v1_RaAPropOwnerAVMMed 					:=	 (integer)le.attributes.version1.RaAPropOwnerAVMMed;					
v1_RaAPPCurrOwnerMmbrCnt 				:=	 (integer)le.attributes.version1.RaAPPCurrOwnerMmbrCnt;					
v1_RaAPPCurrOwnerAutoMmbrCnt 		:=	 (integer)le.attributes.version1.RaAPPCurrOwnerAutoMmbrCnt;					
v1_RaAPPCurrOwnerMtrcycleMmbrCnt:=	 (integer)le.attributes.version1.RaAPPCurrOwnerMtrcycleMmbrCnt;					
v1_RaAPPCurrOwnerAircrftMmbrCnt :=	 (integer)le.attributes.version1.RaAPPCurrOwnerAircrftMmbrCnt;					
v1_RaAPPCurrOwnerWtrcrftMmbrCnt :=	 (integer)le.attributes.version1.RaAPPCurrOwnerWtrcrftMmbrCnt;					
v1_RaACrtRecMmbrCnt 						:=	 (integer)le.attributes.version1.RaACrtRecMmbrCnt;					
v1_RaACrtRecMmbrCnt12Mo 				:=	 (integer)le.attributes.version1.RaACrtRecMmbrCnt12Mo;					
v1_RaACrtRecFelonyMmbrCnt 			:=	 (integer)le.attributes.version1.RaACrtRecFelonyMmbrCnt;					
v1_RaACrtRecFelonyMmbrCnt12Mo 	:=	 (integer)le.attributes.version1.RaACrtRecFelonyMmbrCnt12Mo;					
v1_RaACrtRecMsdmeanMmbrCnt 			:=	 (integer)le.attributes.version1.RaACrtRecMsdmeanMmbrCnt;					
v1_RaACrtRecMsdmeanMmbrCnt12Mo 	:=	 (integer)le.attributes.version1.RaACrtRecMsdmeanMmbrCnt12Mo;					
v1_RaACrtRecEvictionMmbrCnt 		:=	 (integer)le.attributes.version1.RaACrtRecEvictionMmbrCnt;					
v1_RaACrtRecEvictionMmbrCnt12Mo :=	 (integer)le.attributes.version1.RaACrtRecEvictionMmbrCnt12Mo;					
v1_RaACrtRecLienJudgMmbrCnt 		:=	 (integer)le.attributes.version1.RaACrtRecLienJudgMmbrCnt;					
v1_RaACrtRecLienJudgMmbrCnt12Mo :=	 (integer)le.attributes.version1.RaACrtRecLienJudgMmbrCnt12Mo;					
v1_RaACrtRecLienJudgAmtMax 			:=	 (integer)le.attributes.version1.RaACrtRecLienJudgAmtMax;					
v1_RaACrtRecBkrptMmbrCnt36Mo 		:=	 (integer)le.attributes.version1.RaACrtRecBkrptMmbrCnt36Mo;					
v1_RaAOccProfLicMmbrCnt 				:=	 (integer)le.attributes.version1.RaAOccProfLicMmbrCnt;					
v1_RaAOccBusinessAssocMmbrCnt 	:=	 (integer)le.attributes.version1.RaAOccBusinessAssocMmbrCnt;					
v1_RaAInterestSportPersonMmbrCnt:=	 (integer)le.attributes.version1.RaAInterestSportPersonMmbrCnt;					

v1_donotmail                    := (integer)le.attributes.version1.donotmail;

NULL :=  -999999999; 
/////////////////////////////////
// Score for class 0: unbanked //
/////////////////////////////////

b1_tree_0 :=  0.0000000000;


// Tree: 1

b1_tree_1 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

   ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
0.2296139791
, 

      (v1_hhcnt > 1.5) => 
0.0656428787
, 

0.2226837711
)
, 

   (v1_hhpropcurrownermmbrcnt > 0.5) => 
-0.0227830644
, 

0.2019457746
)
, 

(v1_raammbrcnt > 0.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 6.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 2.5) => 
0.0757097792
, 

         (v1_raammbrcnt > 2.5) => 
0.0189950699
, 

0.0387487722
)
, 

      (v1_raammbrcnt > 6.5) => 
-0.0423887418
, 

-0.0046683693
)
, 

   (v1_lifeeveverresidedcnt > 0.5) => 
-0.1081949843
, 

-0.0614036008
)
, 

-0.0005961701
)
;


// Tree: 5

b1_tree_5 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

   ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
map(

      ( NULL < v1_lifeevecontrajectory and v1_lifeevecontrajectory <= 0.5) => 
0.1755252027
, 

      (v1_lifeevecontrajectory > 0.5) => 
0.0566055238
, 

0.1702948708
)
, 

   (v1_hhpropcurrownermmbrcnt > 0.5) => 
-0.0163654153
, 

0.1544059759
)
, 

(v1_raammbrcnt > 0.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 4.5) => 
0.0477428579
, 

      (v1_raammbrcnt > 4.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 11.5) => 
-0.0099456351
, 

         (v1_raammbrcnt > 11.5) => 
-0.0601880243
, 

-0.0298406096
)
, 

-0.0052650549
)
, 

   (v1_lifeeveverresidedcnt > 0.5) => 
-0.1018914416
, 

-0.0580988388
)
, 

-0.0089962691
)
;


// Tree: 9

b1_tree_9 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
map(

      ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
0.1401682339
, 

      (v1_lifeevtimefirstassetpurchase > -0.5) => 
0.0019716893
, 

0.1371979861
)
, 

   (v1_hhcnt > 1.5) => 
0.0051299708
, 

0.1234327255
)
, 

(v1_raammbrcnt > 0.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 4.5) => 
0.0405916831
, 

      (v1_raammbrcnt > 4.5) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
-0.0191009825
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.1027814669
, 

-0.0260692624
)
, 

-0.0049693925
)
, 

   (v1_lifeeveverresidedcnt > 0.5) => 
-0.0955177560
, 

-0.0546709491
)
, 

-0.0137932938
)
;


// Tree: 13

b1_tree_13 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

   ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

      ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
0.1135091281
, 

      (v1_hhmiddleagemmbrcnt > 0.5) => 
0.0121159984
, 

0.1098369309
)
, 

   (v1_lifeevtimefirstassetpurchase > -0.5) => 
-0.0375392282
, 

0.1005796927
)
, 

(v1_raammbrcnt > 0.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 9.5) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
0.0223059825
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0886221121
, 

0.0166551249
)
, 

      (v1_raammbrcnt > 9.5) => 
-0.0443115260
, 

-0.0051133253
)
, 

   (v1_lifeeveverresidedcnt > 0.5) => 
-0.0899671162
, 

-0.0515855091
)
, 

-0.0164707932
)
;


// Tree: 17

b1_tree_17 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

   ( NULL < v1_lifeevecontrajectory and v1_lifeevecontrajectory <= 0.5) => 
0.0966410962
, 

   (v1_lifeevecontrajectory > 0.5) => 
-0.0044124488
, 

0.0866449993
)
, 

(v1_raammbrcnt > 0.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 7.5) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

            ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
0.0271850044
, 

            (v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0958533962
, 

0.0236192472
)
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0857093459
, 

0.0186671979
)
, 

      (v1_raammbrcnt > 7.5) => 
-0.0321149727
, 

-0.0052362217
)
, 

   (v1_lifeeveverresidedcnt > 0.5) => 
-0.0847782033
, 

-0.0488411263
)
, 

-0.0176399079
)
;


// Tree: 21

b1_tree_21 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 1.5) => 
map(

   ( NULL < v1_lifeevecontrajectory and v1_lifeevecontrajectory <= 0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
0.0815782651
, 

      (v1_raammbrcnt > 0.5) => 
0.0510594404
, 

0.0770647589
)
, 

   (v1_lifeevecontrajectory > 0.5) => 
-0.0131681313
, 

0.0647190268
)
, 

(v1_raammbrcnt > 1.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 12.5) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
0.0068533723
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0862355755
, 

0.0009416022
)
, 

      (v1_raammbrcnt > 12.5) => 
-0.0488602248
, 

-0.0121003040
)
, 

   (v1_lifeeveverresidedcnt > 0.5) => 
-0.0840462989
, 

-0.0524068280
)
, 

-0.0190841621
)
;


// Tree: 25

b1_tree_25 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 109.5) => 
map(

      ( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 0.5) => 
0.0714402772
, 

      (v1_hhcollegeattendedmmbrcnt > 0.5) => 
-0.0279279360
, 

0.0694770042
)
, 

   (v1_prospecttimeonrecord > 109.5) => 
-0.0192548895
, 

0.0627946170
)
, 

(v1_raammbrcnt > 0.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 3.5) => 
0.0276391373
, 

      (v1_raammbrcnt > 3.5) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
-0.0127618332
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0898437774
, 

-0.0190620707
)
, 

-0.0079369564
)
, 

   (v1_lifeeveverresidedcnt > 0.5) => 
-0.0759049555
, 

-0.0451410675
)
, 

-0.0201555359
)
;


// Tree: 29

b1_tree_29 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 1.5) => 
map(

   ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 104.5) => 
map(

      ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
0.0592750658
, 

      (v1_lifeevtimefirstassetpurchase > -0.5) => 
-0.0140614729
, 

0.0563652834
)
, 

   (v1_lifeevtimelastmove > 104.5) => 
-0.0287547652
, 

0.0476931743
)
, 

(v1_raammbrcnt > 1.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

      ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
-0.0003413891
, 

         (v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0910589890
, 

-0.0045027469
)
, 

      (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0830084576
, 

-0.0102495964
)
, 

   (v1_lifeeveverresidedcnt > 0.5) => 
-0.0758845295
, 

-0.0470890177
)
, 

-0.0202872802
)
;


// Tree: 33

b1_tree_33 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

   ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 112.5) => 
0.0519890994
, 

   (v1_lifeevtimelastmove > 112.5) => 
-0.0233836430
, 

0.0470137832
)
, 

(v1_raammbrcnt > 0.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 28.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 9.5) => 
map(

         ( NULL < v1_hhcollegetiermmbrhighest and v1_hhcollegetiermmbrhighest <= 0.5) => 
map(

            ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 1.5) => 
0.0147657214
, 

            (v1_occbusinessassociationtime > 1.5) => 
-0.0876578624
, 

0.0120458348
)
, 

         (v1_hhcollegetiermmbrhighest > 0.5) => 
-0.0594742611
, 

0.0074693674
)
, 

      (v1_raammbrcnt > 9.5) => 
-0.0337068331
, 

-0.0075350884
)
, 

   (v1_prospecttimeonrecord > 28.5) => 
-0.0697260143
, 

-0.0396074874
)
, 

-0.0196433197
)
;


// Tree: 37

b1_tree_37 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 1.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
0.0461216730
, 

      (v1_hhseniormmbrcnt > 0.5) => 
-0.0555211154
, 

0.0433194431
)
, 

   (v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0350291060
, 

0.0365327846
)
, 

(v1_raammbrcnt > 1.5) => 
map(

   ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

      ( NULL < v1_raahhcnt and v1_raahhcnt <= 3.5) => 
map(

         ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
-0.0133821722
, 

         (v1_resinputownershipindex > 0.5) => 
0.0227450099
, 

0.0031865867
)
, 

      (v1_raahhcnt > 3.5) => 
-0.0352741750
, 

-0.0184401954
)
, 

   (v1_lifeevtimefirstassetpurchase > -0.5) => 
-0.0826688212
, 

-0.0394527469
)
, 

-0.0179723089
)
;


// Tree: 41

b1_tree_41 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 1.5) => 
map(

   ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

      ( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 0.5) => 
0.0399109891
, 

      (v1_hhcollegeattendedmmbrcnt > 0.5) => 
-0.0307224821
, 

0.0377219767
)
, 

   (v1_lifeevtimefirstassetpurchase > -0.5) => 
-0.0352110395
, 

0.0311641094
)
, 

(v1_raammbrcnt > 1.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

      ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
-0.0220240196
, 

      (v1_resinputownershipindex > 0.5) => 
map(

         ( NULL < v1_raahhcnt and v1_raahhcnt <= 6.5) => 
0.0180580264
, 

         (v1_raahhcnt > 6.5) => 
-0.0299343906
, 

0.0072291246
)
, 

-0.0067780958
)
, 

   (v1_lifeeveverresidedcnt > 0.5) => 
-0.0643846495
, 

-0.0389760654
)
, 

-0.0192261790
)
;


// Tree: 45

b1_tree_45 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

   ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 0.755) => 
map(

      ( NULL < v1_prospectcollegeattended and v1_prospectcollegeattended <= 0.5) => 
0.0400996872
, 

      (v1_prospectcollegeattended > 0.5) => 
-0.0697278782
, 

0.0387994379
)
, 

   (v1_resinputavmcntyratio > 0.755) => 
0.0064997464
, 

0.0328690305
)
, 

(v1_raammbrcnt > 0.5) => 
map(

   ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 6.5) => 
0.0087989599
, 

      (v1_raammbrcnt > 6.5) => 
map(

         ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
-0.0410107400
, 

         (v1_resinputownershipindex > 0.5) => 
-0.0079246837
, 

-0.0252688349
)
, 

-0.0110876461
)
, 

   (v1_hhpropcurrownermmbrcnt > 0.5) => 
-0.0714000777
, 

-0.0329130825
)
, 

-0.0177247740
)
;


// Tree: 49

b1_tree_49 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 1.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
0.0296117267
, 

   (v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0308944761
, 

0.0242968821
)
, 

(v1_raammbrcnt > 1.5) => 
map(

   ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

      ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

            ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
-0.0114619882
, 

            (v1_resinputownershipindex > 0.5) => 
0.0176166775
, 

0.0028881171
)
, 

         (v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0489714664
, 

-0.0095199688
)
, 

      (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0627286537
, 

-0.0185209945
)
, 

   (v1_lifeevtimefirstassetpurchase > -0.5) => 
-0.0738856089
, 

-0.0366229855
)
, 

-0.0193520639
)
;


// Tree: 53

b1_tree_53 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 3.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
map(

         ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 162976) => 
map(

            ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
0.0294236912
, 

            (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0395714828
, 

0.0273933219
)
, 

         (v1_resinputavmvalue > 162976) => 
0.0011109759
, 

0.0232993926
)
, 

      (v1_hhseniormmbrcnt > 0.5) => 
-0.0561661864
, 

0.0194982716
)
, 

   (v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0350669983
, 

0.0118758052
)
, 

(v1_raammbrcnt > 3.5) => 
map(

   (v1_rescurrdwelltype in ['F','P','S','U']) => 
-0.0632073425
, 

   (v1_rescurrdwelltype in ['-1','H','R']) => 
-0.0118644516
, 

-0.0353342713
)
, 

-0.0175381887
)
;


// Tree: 57

b1_tree_57 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

   ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 0.725) => 
0.0274928532
, 

   (v1_resinputavmcntyratio > 0.725) => 
-0.0009484769
, 

0.0220016188
)
, 

(v1_raammbrcnt > 0.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 13.5) => 
map(

            ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
0.0111131027
, 

            (v1_hhseniormmbrcnt > 0.5) => 
-0.0617787567
, 

0.0023270140
)
, 

         (v1_raammbrcnt > 13.5) => 
-0.0316132669
, 

-0.0043984354
)
, 

      (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0647254990
, 

-0.0163481118
)
, 

   (v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0590768737
, 

-0.0313438773
)
, 

-0.0190756876
)
;


// Tree: 61

b1_tree_61 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
0.0209226270
, 

   (v1_lifeeveverresidedcnt > 1.5) => 
-0.0861270532
, 

0.0189917584
)
, 

(v1_raammbrcnt > 0.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_occbusinessassociation and v1_occbusinessassociation <= 0.5) => 
map(

            ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 0.5) => 
0.0142223994
, 

            (v1_rescurrownershipindex > 0.5) => 
-0.0072354280
, 

0.0026958270
)
, 

         (v1_occbusinessassociation > 0.5) => 
-0.0774339515
, 

-0.0010384786
)
, 

      (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0622118248
, 

-0.0133058278
)
, 

   (v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0556618068
, 

-0.0282293965
)
, 

-0.0173582255
)
;


// Tree: 65

b1_tree_65 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 3.5) => 
map(

   ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

      ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 190463) => 
0.0187958508
, 

      (v1_resinputavmvalue > 190463) => 
-0.0054792013
, 

0.0156375274
)
, 

   (v1_lifeevtimefirstassetpurchase > -0.5) => 
-0.0319969617
, 

0.0089927052
)
, 

(v1_raammbrcnt > 3.5) => 
map(

   ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 13.5) => 
map(

         ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
-0.0156297137
, 

         (v1_resinputownershipindex > 0.5) => 
0.0110921874
, 

-0.0024267022
)
, 

      (v1_raammbrcnt > 13.5) => 
-0.0353931104
, 

-0.0130858623
)
, 

   (v1_lifeevtimefirstassetpurchase > -0.5) => 
-0.0643076664
, 

-0.0301309390
)
, 

-0.0152941917
)
;


// Tree: 69

b1_tree_69 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

   ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 0.705) => 
map(

      ( NULL < v1_prospectcollegeattended and v1_prospectcollegeattended <= 0.5) => 
0.0218809197
, 

      (v1_prospectcollegeattended > 0.5) => 
-0.0757782705
, 

0.0208059909
)
, 

   (v1_resinputavmcntyratio > 0.705) => 
-0.0032723493
, 

0.0160285291
)
, 

(v1_raammbrcnt > 0.5) => 
map(

   ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 120429) => 
map(

      ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
0.0080022768
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0404292091
, 

0.0006757315
)
, 

      (v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0389729984
, 

-0.0105881626
)
, 

   (v1_raapropowneravmhighest > 120429) => 
-0.0288296705
, 

-0.0202511219
)
, 

-0.0118548168
)
;


// Tree: 73

b1_tree_73 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 2.5) => 
map(

   ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 92951.5) => 
0.0158556953
, 

   (v1_resinputavmvalue12mo > 92951.5) => 
-0.0066510852
, 

0.0108288352
)
, 

(v1_raammbrcnt > 2.5) => 
map(

   ( NULL < v1_propeverownedcnt and v1_propeverownedcnt <= 0.5) => 
map(

      ( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 0.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 15.5) => 
map(

            ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
-0.0092440799
, 

            (v1_resinputownershipindex > 0.5) => 
0.0141477378
, 

0.0021272434
)
, 

         (v1_raammbrcnt > 15.5) => 
-0.0306779497
, 

-0.0055884124
)
, 

      (v1_prospectcollegeprogramtype > 0.5) => 
-0.0525913658
, 

-0.0087750533
)
, 

   (v1_propeverownedcnt > 0.5) => 
-0.0606084578
, 

-0.0256955241
)
, 

-0.0137014895
)
;


// Tree: 77

b1_tree_77 := 
map(

( NULL < v1_raahhcnt and v1_raahhcnt <= 2.5) => 
map(

   ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

      ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 0) => 
map(

         ( NULL < v1_prospectcollegetier and v1_prospectcollegetier <= 0.5) => 
map(

            ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
0.0131339150
, 

            (v1_hhseniormmbrcnt > 0.5) => 
-0.0347746136
, 

0.0118582267
)
, 

         (v1_prospectcollegetier > 0.5) => 
-0.0445004437
, 

0.0106034693
)
, 

      (v1_occbusinessassociationtime > 0) => 
-0.0560395366
, 

0.0092342453
)
, 

   (v1_lifeevtimefirstassetpurchase > -0.5) => 
-0.0322505420
, 

0.0030653550
)
, 

(v1_raahhcnt > 2.5) => 
map(

   ( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
-0.0211083908
, 

   (v1_prospectdeceased > 0.5) => 
0.3743711054
, 

-0.0206930325
)
, 

-0.0092584145
)
;


// Tree: 81

b1_tree_81 := 
map(

( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 70039.5) => 
map(

   ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 0) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
map(

         ( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 0.5) => 
map(

            ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 409946.5) => 
map(

               ( NULL < v1_donotmail and v1_donotmail <= -0.5) => 
-0.1715559984
, 

               (v1_donotmail > -0.5) => 
0.0125399428
, 

0.0123498096
)
, 

            (v1_resinputavmvalue12mo > 409946.5) => 
-0.0267250434
, 

0.0113306382
)
, 

         (v1_hhcollegeattendedmmbrcnt > 0.5) => 
-0.0124395328
, 

0.0086826832
)
, 

      (v1_lifeeveverresidedcnt > 1.5) => 
-0.0370270120
, 

0.0041574905
)
, 

   (v1_occbusinessassociationtime > 0) => 
-0.0667035319
, 

0.0016867040
)
, 

(v1_raapropowneravmhighest > 70039.5) => 
-0.0211043178
, 

-0.0091528363
)
;


// Tree: 85

b1_tree_85 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
0.0107037729
, 

   (v1_lifeeveverresidedcnt > 1.5) => 
-0.0794066189
, 

0.0090697728
)
, 

(v1_raammbrcnt > 0.5) => 
map(

   ( NULL < v1_occbusinessassociation and v1_occbusinessassociation <= 0.5) => 
map(

      ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 0.5) => 
map(

         ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

            ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
0.0135102027
, 

            (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0465746680
, 

0.0039606294
)
, 

         (v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0366837716
, 

-0.0051744832
)
, 

      (v1_rescurrownershipindex > 0.5) => 
-0.0158548418
, 

-0.0117229925
)
, 

   (v1_occbusinessassociation > 0.5) => 
-0.0678430468
, 

-0.0172259408
)
, 

-0.0111399291
)
;


// Tree: 89

b1_tree_89 := 
map(

( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

   ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
map(

         ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
map(

            (v1_resinputdwelltype in ['-1','G','H','P','R']) => 
-0.0050110174
, 

            (v1_resinputdwelltype in ['0','F','S','U']) => 
0.0111375869
, 

0.0060227051
)
, 

         (v1_verifiedcurrresmatchindex > 0.5) => 
0.0480515371
, 

0.0088445897
)
, 

      (v1_hhseniormmbrcnt > 0.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 1.5) => 
-0.0950168051
, 

         (v1_prospecttimeonrecord > 1.5) => 
-0.0324427432
, 

-0.0386511358
)
, 

0.0048956733
)
, 

   (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0484029147
, 

-0.0027351481
)
, 

(v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0361630294
, 

-0.0122301049
)
;


// Tree: 93

b1_tree_93 := 
map(

( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

   ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 247792.5) => 
map(

      ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 347207.5) => 
map(

            (v1_resinputdwelltype in ['-1','G','H','P','R']) => 
0.0002043518
, 

            (v1_resinputdwelltype in ['0','F','S','U']) => 
map(

               ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
0.0144774354
, 

               (v1_lifeeveverresidedcnt > 1.5) => 
-0.0269745352
, 

0.0109484283
)
, 

0.0073679822
)
, 

         (v1_resinputavmvalue12mo > 347207.5) => 
-0.0213305205
, 

0.0065015880
)
, 

      (v1_raacollege4yrattendedmmbrcnt > 0.5) => 
-0.0165865702
, 

0.0032157767
)
, 

   (v1_raapropowneravmhighest > 247792.5) => 
-0.0176193669
, 

-0.0004818540
)
, 

(v1_lifeevtimefirstassetpurchase > -0.5) => 
-0.0423703625
, 

-0.0113449680
)
;


// Tree: 97

b1_tree_97 := 
map(

( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 93998.5) => 
map(

   ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 111780.5) => 
map(

      ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 16.5) => 
map(

            ( NULL < v1_donotmail and v1_donotmail <= -0.5) => 
-0.1437630460
, 

            (v1_donotmail > -0.5) => 
0.0099953380
, 

0.0098393760
)
, 

         (v1_raammbrcnt > 16.5) => 
-0.0334024562
, 

0.0078545094
)
, 

      (v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0168198452
, 

0.0035528002
)
, 

   (v1_resinputavmvalue12mo > 111780.5) => 
-0.0119899716
, 

0.0012070295
)
, 

(v1_raapropowneravmhighest > 93998.5) => 
map(

   ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 0.5) => 
-0.0010706883
, 

   (v1_rescurrownershipindex > 0.5) => 
-0.0335966568
, 

-0.0218282886
)
, 

-0.0090860033
)
;


// Tree: 101

b1_tree_101 := 
map(

( NULL < v1_raacollegeattendedmmbrcnt and v1_raacollegeattendedmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 96106) => 
map(

      (v1_resinputdwelltype in ['-1','G','H','P','R','S']) => 
map(

         ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 3.5) => 
map(

            ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 162217.5) => 
0.0075099181
, 

            (v1_raapropowneravmhighest > 162217.5) => 
-0.0168955122
, 

0.0044911592
)
, 

         (v1_crtrecseverityindex > 3.5) => 
0.0495953864
, 

0.0073313879
)
, 

      (v1_resinputdwelltype in ['0','F','U']) => 
0.0771419197
, 

0.0077864262
)
, 

   (v1_resinputavmvalue12mo > 96106) => 
-0.0077645087
, 

0.0038301065
)
, 

(v1_raacollegeattendedmmbrcnt > 0.5) => 
map(

   ( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
-0.0141257037
, 

   (v1_prospectdeceased > 0.5) => 
0.2769270793
, 

-0.0138743690
)
, 

-0.0047744298
)
;


// Tree: 105

b1_tree_105 := 
map(

( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
map(

   ( NULL < v1_occbusinessassociation and v1_occbusinessassociation <= 0.5) => 
map(

      ( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 0.5) => 
map(

         ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
map(

            ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 24.5) => 
map(

               (v1_resinputdwelltype in ['-1','G','H','P','R']) => 
-0.0051595629
, 

               (v1_resinputdwelltype in ['0','F','S','U']) => 
0.0079106442
, 

0.0042637552
)
, 

            (v1_crtrectimenewest > 24.5) => 
-0.0319523320
, 

0.0011332620
)
, 

         (v1_crtrecseverityindex > 2.5) => 
0.0311462398
, 

0.0047974343
)
, 

      (v1_prospectcollegeprogramtype > 0.5) => 
-0.0409536843
, 

0.0027799183
)
, 

   (v1_occbusinessassociation > 0.5) => 
-0.0555384488
, 

0.0002554001
)
, 

(v1_lifeeveverresidedcnt > 1.5) => 
-0.0429051627
, 

-0.0093329525
)
;


// Tree: 109

b1_tree_109 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 5.5) => 
map(

   ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 74.5) => 
map(

            ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
0.0033181989
, 

            (v1_hhseniormmbrcnt > 0.5) => 
-0.0919064882
, 

0.0027142908
)
, 

         (v1_prospecttimeonrecord > 74.5) => 
0.0575617298
, 

0.0037131887
)
, 

      (v1_lifeeveverresidedcnt > 0.5) => 
-0.0233479635
, 

-0.0022875678
)
, 

   (v1_crtrecseverityindex > 2.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
0.0388382742
, 

      (v1_lifeeveverresidedcnt > 1.5) => 
-0.0164167603
, 

0.0220484024
)
, 

0.0003187150
)
, 

(v1_raammbrcnt > 5.5) => 
-0.0129312628
, 

-0.0065051808
)
;


// Tree: 113

b1_tree_113 := 
map(

( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

   ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_occbusinessassociation and v1_occbusinessassociation <= 0.5) => 
map(

         ( NULL < v1_occproflicense and v1_occproflicense <= 0.5) => 
map(

            ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 17.5) => 
map(

               ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
0.0053222248
, 

               (v1_crtrecseverityindex > 2.5) => 
0.0350920891
, 

0.0090397804
)
, 

            (v1_raammbrcnt > 17.5) => 
-0.0208593951
, 

0.0062697840
)
, 

         (v1_occproflicense > 0.5) => 
-0.0679683207
, 

0.0052525891
)
, 

      (v1_occbusinessassociation > 0.5) => 
-0.0452067893
, 

0.0034237771
)
, 

   (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0346151699
, 

-0.0010443555
)
, 

(v1_lifeevtimefirstassetpurchase > -0.5) => 
-0.0346527993
, 

-0.0097716955
)
;


// Tree: 117

b1_tree_117 := 
map(

( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
map(

   ( NULL < v1_occproflicense and v1_occproflicense <= 0.5) => 
map(

      ( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 1.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 15.5) => 
map(

            ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 0.5) => 
0.0021702246
, 

            (v1_raacrtrecevictionmmbrcnt > 0.5) => 
0.0190235050
, 

0.0056605203
)
, 

         (v1_raammbrcnt > 15.5) => 
-0.0172815553
, 

0.0028709656
)
, 

      (v1_prospectcollegeprogramtype > 1.5) => 
-0.0436621183
, 

0.0013162663
)
, 

   (v1_occproflicense > 0.5) => 
-0.0704986838
, 

-0.0002849115
)
, 

(v1_lifeeveverresidedcnt > 1.5) => 
map(

   ( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
-0.0383670355
, 

   (v1_prospectdeceased > 0.5) => 
0.3918650533
, 

-0.0378510666
)
, 

-0.0086277075
)
;


// Tree: 121

b1_tree_121 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
map(

            ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 54.5) => 
map(

               (v1_resinputdwelltype in ['-1','G','H','P','R']) => 
-0.0048604427
, 

               (v1_resinputdwelltype in ['0','F','S','U']) => 
0.0078986006
, 

0.0039180156
)
, 

            (v1_prospecttimelastupdate > 54.5) => 
0.0612436208
, 

0.0061158734
)
, 

         (v1_hhseniormmbrcnt > 0.5) => 
-0.0391454309
, 

0.0023489199
)
, 

      (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0367429744
, 

-0.0032257291
)
, 

   (v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0247597594
, 

-0.0093655983
)
, 

(v1_prospectdeceased > 0.5) => 
0.1909857446
, 

-0.0091901522
)
;


// Tree: 125

b1_tree_125 := 
map(

( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

   ( NULL < v1_occbusinessassociation and v1_occbusinessassociation <= 0.5) => 
map(

      ( NULL < v1_donotmail and v1_donotmail <= -0.5) => 
-0.1498063857
, 

      (v1_donotmail > -0.5) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

            ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 66.5) => 
map(

               (v1_resinputdwelltype in ['G','H','P','R']) => 
-0.0046656646
, 

               (v1_resinputdwelltype in ['-1','0','F','S','U']) => 
0.0062473732
, 

0.0028334506
)
, 

            (v1_prospecttimelastupdate > 66.5) => 
0.0365406370
, 

0.0055750913
)
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0250895451
, 

0.0020682703
)
, 

0.0019914652
)
, 

   (v1_occbusinessassociation > 0.5) => 
-0.0431843608
, 

0.0001458757
)
, 

(v1_lifeevtimefirstassetpurchase > -0.5) => 
-0.0305841582
, 

-0.0078302871
)
;


// Tree: 129

b1_tree_129 := 
map(

( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 51040) => 
map(

   ( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 1.5) => 
map(

      ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
-0.0021922739
, 

      (v1_resinputownershipindex > 0.5) => 
map(

         ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 298504) => 
map(

            ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

               ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
0.0139141092
, 

               (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0181707413
, 

0.0099633329
)
, 

            (v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0070201974
, 

0.0057561156
)
, 

         (v1_resinputavmvalue > 298504) => 
-0.0088939069
, 

0.0037620638
)
, 

0.0007744985
)
, 

   (v1_prospectcollegeprogramtype > 1.5) => 
-0.0482816919
, 

-0.0009028889
)
, 

(v1_propcurrownedavmttl > 51040) => 
-0.0390497952
, 

-0.0073732879
)
;


// Tree: 133

b1_tree_133 := 
map(

( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 3.5) => 
map(

   ( NULL < v1_hhteenagermmbrcnt and v1_hhteenagermmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

         ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 24.5) => 
0.0015409761
, 

         (v1_crtrecmsdmeantimenewest > 24.5) => 
-0.0289866826
, 

-0.0009213359
)
, 

      (v1_hhmiddleagemmbrcnt > 0.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 1.5) => 
-0.0655248923
, 

         (v1_prospecttimeonrecord > 1.5) => 
map(

            ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0631486089
, 

            (v1_lifeeveverresidedcnt > 0.5) => 
-0.0294908234
, 

-0.0275583683
)
, 

-0.0295816569
)
, 

-0.0087221347
)
, 

   (v1_hhteenagermmbrcnt > 0.5) => 
0.2257479444
, 

-0.0084095353
)
, 

(v1_crtrecseverityindex > 3.5) => 
0.0291216288
, 

-0.0054131489
)
;


// Tree: 137

b1_tree_137 := 
map(

( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 4.5) => 
map(

   ( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

      ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 248115.5) => 
map(

         ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 346014.5) => 
map(

            ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 0.5) => 
map(

               ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 17.5) => 
0.0038508187
, 

               (v1_raammbrcnt > 17.5) => 
-0.0243595264
, 

0.0015028315
)
, 

            (v1_crtrecbkrptcnt > 0.5) => 
-0.0505155155
, 

-0.0015958514
)
, 

         (v1_resinputavmvalue60mo > 346014.5) => 
-0.0210430549
, 

-0.0024174081
)
, 

      (v1_raapropowneravmhighest > 248115.5) => 
-0.0166991777
, 

-0.0059080172
)
, 

   (v1_prospectdeceased > 0.5) => 
0.1381678521
, 

-0.0057882068
)
, 

(v1_crtrecseverityindex > 4.5) => 
0.0424733699
, 

-0.0046011626
)
;


// Tree: 141

b1_tree_141 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 58.5) => 
map(

   ( NULL < v1_lifeevecontrajectory and v1_lifeevecontrajectory <= 0.5) => 
map(

      ( NULL < v1_occproflicense and v1_occproflicense <= 0.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 22.5) => 
map(

            (v1_resinputdwelltype in ['-1','G','H','P','R']) => 
-0.0042856891
, 

            (v1_resinputdwelltype in ['0','F','S','U']) => 
0.0056267296
, 

0.0025990231
)
, 

         (v1_raammbrcnt > 22.5) => 
-0.0360253131
, 

0.0008230579
)
, 

      (v1_occproflicense > 0.5) => 
-0.0788809611
, 

-0.0002529402
)
, 

   (v1_lifeevecontrajectory > 0.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0438829299
, 

      (v1_lifeeveverresidedcnt > 0.5) => 
-0.0360383960
, 

-0.0346757362
)
, 

-0.0108664883
)
, 

(v1_prospecttimelastupdate > 58.5) => 
0.0196259517
, 

-0.0067302642
)
;


// Tree: 145

b1_tree_145 := 
map(

( NULL < v1_donotmail and v1_donotmail <= -0.5) => 
-0.1437869494
, 

(v1_donotmail > -0.5) => 
map(

   ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
map(

      (v1_resinputdwelltype in ['G','H','P','R','S']) => 
map(

         ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
-0.0006778241
, 

         (v1_raacrtrecfelonymmbrcnt > 0.5) => 
map(

            ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 10.5) => 
map(

               ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 33.5) => 
0.0357369896
, 

               (v1_lifeevtimelastmove > 33.5) => 
-0.0003976162
, 

0.0209059670
)
, 

            (v1_raammbrcnt > 10.5) => 
0.0005987772
, 

0.0094582939
)
, 

0.0007435567
)
, 

      (v1_resinputdwelltype in ['-1','0','F','U']) => 
0.0565198241
, 

0.0009653588
)
, 

   (v1_raacollege4yrattendedmmbrcnt > 0.5) => 
-0.0147420477
, 

-0.0025600923
)
, 

-0.0026068252
)
;


// Tree: 149

b1_tree_149 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

   ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 274390.5) => 
map(

      ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 281958.5) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 0) => 
map(

            ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 3.5) => 
map(

               ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
0.0029678980
, 

               (v1_hhseniormmbrcnt > 0.5) => 
-0.0303571228
, 

0.0006812865
)
, 

            (v1_crtrecseverityindex > 3.5) => 
0.0304468790
, 

0.0031646794
)
, 

         (v1_crtrecbkrpttimenewest > 0) => 
-0.0417545165
, 

0.0003848743
)
, 

      (v1_resinputavmvalue60mo > 281958.5) => 
-0.0166682586
, 

-0.0006924667
)
, 

   (v1_raapropowneravmhighest > 274390.5) => 
-0.0166617173
, 

-0.0041587281
)
, 

(v1_prospectdeceased > 0.5) => 
0.1095425747
, 

-0.0040467722
)
;


// Tree: 153

b1_tree_153 := 
map(

( NULL < v1_hhteenagermmbrcnt and v1_hhteenagermmbrcnt <= 0.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 54.5) => 
map(

      ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
-0.0004003135
, 

      (v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0325204677
, 

-0.0076799342
)
, 

   (v1_prospecttimelastupdate > 54.5) => 
map(

      ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
-0.0033702343
, 

      (v1_crtrecseverityindex > 2.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 3.5) => 
map(

            ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
0.0886709722
, 

            (v1_hhcnt > 1.5) => 
0.0318428688
, 

0.0583250255
)
, 

         (v1_raammbrcnt > 3.5) => 
0.0312229654
, 

0.0362694230
)
, 

0.0112192681
)
, 

-0.0047624775
)
, 

(v1_hhteenagermmbrcnt > 0.5) => 
0.1721074677
, 

-0.0045205165
)
;


// Tree: 157

b1_tree_157 := 
map(

( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 0) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 0) => 
map(

      ( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 0.5) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 61.5) => 
map(

            ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
-0.0038809991
, 

            (v1_resinputownershipindex > 0.5) => 
map(

               ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 12475) => 
0.0061074410
, 

               (v1_propcurrownedavmttl > 12475) => 
-0.0241415789
, 

-0.0003335238
)
, 

-0.0019775389
)
, 

         (v1_prospecttimelastupdate > 61.5) => 
0.0244356530
, 

0.0010318663
)
, 

      (v1_occproflicensecategory > 0.5) => 
-0.0636908583
, 

-0.0006606591
)
, 

   (v1_crtrecbkrpttimenewest > 0) => 
-0.0459794313
, 

-0.0034874487
)
, 

(v1_occbusinessassociationtime > 0) => 
-0.0419299185
, 

-0.0064419484
)
;


// Tree: 161

b1_tree_161 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
0.0047443886
, 

         (v1_hhseniormmbrcnt > 0.5) => 
-0.0348133905
, 

0.0014624493
)
, 

      (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0276153089
, 

-0.0027162750
)
, 

   (v1_hhmiddleagemmbrcnt > 0.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 0) => 
-0.0610550109
, 

      (v1_prospecttimeonrecord > 0) => 
map(

         ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0582118766
, 

         (v1_lifeeveverresidedcnt > 0.5) => 
-0.0159474954
, 

-0.0146740094
)
, 

-0.0168840021
)
, 

-0.0067646957
)
, 

(v1_prospectdeceased > 0.5) => 
0.0997966567
, 

-0.0066700907
)
;


// Tree: 165

b1_tree_165 := 
map(

( NULL < v1_crtrecfelonycnt and v1_crtrecfelonycnt <= 0.5) => 
map(

   ( NULL < v1_donotmail and v1_donotmail <= -0.5) => 
-0.1131923191
, 

   (v1_donotmail > -0.5) => 
map(

      (v1_resinputdwelltype in ['F','G','H','P','R','S','U']) => 
map(

         ( NULL < v1_hhteenagermmbrcnt and v1_hhteenagermmbrcnt <= 0.5) => 
map(

            ( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
map(

               ( NULL < v1_occbusinessassociation and v1_occbusinessassociation <= 0.5) => 
0.0008571942
, 

               (v1_occbusinessassociation > 0.5) => 
-0.0346760007
, 

-0.0016979218
)
, 

            (v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
-0.0357593840
, 

-0.0039149158
)
, 

         (v1_hhteenagermmbrcnt > 0.5) => 
0.1421071321
, 

-0.0037226375
)
, 

      (v1_resinputdwelltype in ['-1','0']) => 
0.2286281735
, 

-0.0036601166
)
, 

-0.0037009101
)
, 

(v1_crtrecfelonycnt > 0.5) => 
0.0391655542
, 

-0.0026370501
)
;


// Tree: 169

b1_tree_169 := 
map(

( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

      ( NULL < v1_occproflicense and v1_occproflicense <= 0.5) => 
map(

         ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
map(

            ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
0.0027326150
, 

            (v1_verifiedcurrresmatchindex > 0.5) => 
0.0359753589
, 

0.0048964410
)
, 

         (v1_hhseniormmbrcnt > 0.5) => 
map(

            ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 2.5) => 
-0.0773764094
, 

            (v1_prospecttimeonrecord > 2.5) => 
-0.0133562602
, 

-0.0201045700
)
, 

0.0029654189
)
, 

      (v1_occproflicense > 0.5) => 
-0.0642615872
, 

0.0018747845
)
, 

   (v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0140202263
, 

-0.0026555792
)
, 

(v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0239256240
, 

-0.0056995155
)
;


// Tree: 173

b1_tree_173 := 
map(

( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 3.5) => 
map(

   ( NULL < v1_hhteenagermmbrcnt and v1_hhteenagermmbrcnt <= 0.5) => 
map(

      ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.455) => 
map(

         (v1_resinputdwelltype in ['-1','G','H','P','R','S']) => 
map(

            ( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
-0.0025699693
, 

            (v1_prospectdeceased > 0.5) => 
map(

               ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 109.5) => 
0.1218464587
, 

               (v1_prospecttimelastupdate > 109.5) => 
-0.0535966446
, 

0.0779856829
)
, 

-0.0024945226
)
, 

         (v1_resinputdwelltype in ['0','F','U']) => 
0.0375064009
, 

-0.0023228181
)
, 

      (v1_resinputavmratiodiff12mo > 1.455) => 
0.0152104291
, 

-0.0016403979
)
, 

   (v1_hhteenagermmbrcnt > 0.5) => 
0.1176422299
, 

-0.0014865226
)
, 

(v1_crtrecseverityindex > 3.5) => 
0.0210136390
, 

0.0003201803
)
;


// Tree: 177

b1_tree_177 := 
map(

(v1_resinputdwelltype in ['-1','F','G','H','P','R','S']) => 
map(

   ( NULL < v1_crtrecfelonycnt and v1_crtrecfelonycnt <= 0.5) => 
map(

      ( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

         (v1_resinputdwelltype in ['-1','G','R']) => 
-0.0500059220
, 

         (v1_resinputdwelltype in ['0','F','H','P','S','U']) => 
map(

            ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
-0.0044097953
, 

            (v1_resinputownershipindex > 0.5) => 
map(

               ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 50437) => 
0.0043150331
, 

               (v1_propcurrownedavmttl > 50437) => 
-0.0270224683
, 

-0.0040450885
)
, 

-0.0042024024
)
, 

-0.0043704389
)
, 

      (v1_prospectdeceased > 0.5) => 
0.0839138211
, 

-0.0042940175
)
, 

   (v1_crtrecfelonycnt > 0.5) => 
0.0301304827
, 

-0.0034346040
)
, 

(v1_resinputdwelltype in ['0','U']) => 
0.1122350592
, 

-0.0033510506
)
;


// Tree: 181

b1_tree_181 := 
map(

( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 60.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
map(

      ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 1.795) => 
map(

         (v1_resinputdwelltype in ['-1','G','H','P','R']) => 
map(

            ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
map(

               ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 4.5) => 
-0.0085332146
, 

               (v1_resinputbusinesscnt > 4.5) => 
0.0143369252
, 

-0.0068593810
)
, 

            (v1_verifiedcurrresmatchindex > 0.5) => 
0.0265400010
, 

-0.0044077649
)
, 

         (v1_resinputdwelltype in ['0','F','S','U']) => 
0.0020010585
, 

0.0001747387
)
, 

      (v1_resinputavmblockratio > 1.795) => 
0.0230201990
, 

0.0008018632
)
, 

   (v1_lifeeveverresidedcnt > 1.5) => 
-0.0330058573
, 

-0.0057967239
)
, 

(v1_crtreclienjudgtimenewest > 60.5) => 
0.0292369533
, 

-0.0034372905
)
;


// Tree: 185

b1_tree_185 := 
map(

( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 55.5) => 
map(

      ( NULL < v1_lifeevecontrajectory and v1_lifeevecontrajectory <= 0.5) => 
map(

         ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
0.0007034229
, 

         (v1_verifiedcurrresmatchindex > 0.5) => 
0.0328935750
, 

0.0021893012
)
, 

      (v1_lifeevecontrajectory > 0.5) => 
map(

         ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0435315247
, 

         (v1_lifeeveverresidedcnt > 0.5) => 
-0.0263604470
, 

-0.0246604278
)
, 

-0.0044096601
)
, 

   (v1_prospecttimelastupdate > 55.5) => 
map(

      ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
0.0021142385
, 

      (v1_crtrecseverityindex > 2.5) => 
0.0413704018
, 

0.0169958866
)
, 

-0.0013853312
)
, 

(v1_raacollege4yrattendedmmbrcnt > 0.5) => 
-0.0126016621
, 

-0.0038990523
)
;


// Tree: 189

b1_tree_189 := 
map(

( NULL < v1_hhcrtrecfelonymmbrcnt and v1_hhcrtrecfelonymmbrcnt <= 0.5) => 
map(

   ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 3.5) => 
map(

         ( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 0.5) => 
0.0015046060
, 

         (v1_hhelderlymmbrcnt > 0.5) => 
-0.0600563955
, 

0.0003460676
)
, 

      (v1_raammbrcnt > 3.5) => 
-0.0117143843
, 

-0.0063365400
)
, 

   (v1_resinputownershipindex > 0.5) => 
map(

      ( NULL < v1_propeverownedcnt and v1_propeverownedcnt <= 0.5) => 
map(

         ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 387293) => 
0.0070025944
, 

         (v1_resinputavmvalue12mo > 387293) => 
-0.0126794127
, 

0.0055034526
)
, 

      (v1_propeverownedcnt > 0.5) => 
-0.0161970806
, 

-0.0028372083
)
, 

-0.0043568928
)
, 

(v1_hhcrtrecfelonymmbrcnt > 0.5) => 
0.0258282721
, 

-0.0032512176
)
;


// Tree: 193

b1_tree_193 := 
map(

( NULL < v1_hhteenagermmbrcnt and v1_hhteenagermmbrcnt <= 0.5) => 
map(

   (v1_resinputdwelltype in ['-1','F','G','H','P','R','S','U']) => 
map(

      ( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 0.5) => 
map(

         ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
-0.0014657934
, 

         (v1_raacrtrecfelonymmbrcnt > 0.5) => 
0.0115716093
, 

0.0007029411
)
, 

      (v1_prospectcollegeprogramtype > 0.5) => 
map(

         ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
map(

            ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 0) => 
-0.0691712394
, 

            (v1_prospecttimeonrecord > 0) => 
-0.0594996647
, 

-0.0627564593
)
, 

         (v1_prospectcollegeattending > 0.5) => 
0.0024105903
, 

-0.0358482434
)
, 

-0.0011692017
)
, 

   (v1_resinputdwelltype in ['0']) => 
0.1947835842
, 

-0.0011129790
)
, 

(v1_hhteenagermmbrcnt > 0.5) => 
0.1255839044
, 

-0.0009350540
)
;


// Tree: 197

b1_tree_197 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 42.5) => 
map(

   ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 1.845) => 
map(

      ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 364268.5) => 
-0.0021223484
, 

      (v1_resinputavmvalue60mo > 364268.5) => 
map(

         ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 1.5) => 
-0.0260836318
, 

         (v1_raamiddleagemmbrcnt > 1.5) => 
-0.0045207346
, 

-0.0148941564
)
, 

-0.0029824784
)
, 

   (v1_resinputavmblockratio > 1.845) => 
0.0176630026
, 

-0.0023976881
)
, 

(v1_prospecttimelastupdate > 42.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0394789036
, 

   (v1_lifeeveverresidedcnt > 0.5) => 
map(

      ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
-0.0041233923
, 

      (v1_crtrecseverityindex > 2.5) => 
0.0283621364
, 

0.0082346178
)
, 

0.0089032365
)
, 

-0.0002303899
)
;


// Tree: 201

b1_tree_201 := 
map(

( NULL < v1_occproflicense and v1_occproflicense <= 0.5) => 
map(

   ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 0.5) => 
map(

      ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 0) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 16.5) => 
0.0031383979
, 

         (v1_raammbrcnt > 16.5) => 
-0.0131738812
, 

0.0011624397
)
, 

      (v1_occbusinessassociationtime > 0) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 12.5) => 
-0.0426524446
, 

         (v1_prospecttimeonrecord > 12.5) => 
-0.0178942993
, 

-0.0230881722
)
, 

-0.0004119702
)
, 

   (v1_crtrecbkrptcnt > 0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
-0.0935131716
, 

      (v1_raammbrcnt > 0.5) => 
-0.0332750790
, 

-0.0342348490
)
, 

-0.0026278835
)
, 

(v1_occproflicense > 0.5) => 
-0.0518186082
, 

-0.0044668484
)
;


// Tree: 205

b1_tree_205 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 94.5) => 
map(

   ( NULL < v1_donotmail and v1_donotmail <= -0.5) => 
-0.0897105219
, 

   (v1_donotmail > -0.5) => 
map(

      ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

            ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
0.0028976726
, 

            (v1_hhseniormmbrcnt > 0.5) => 
-0.0372641095
, 

0.0001047486
)
, 

         (v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0165249784
, 

-0.0042089290
)
, 

      (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0217819427
, 

-0.0066989355
)
, 

-0.0067280230
)
, 

(v1_prospecttimelastupdate > 94.5) => 
map(

   ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 50789) => 
0.0232295381
, 

   (v1_hhcrtreclienjudgamtttl > 50789) => 
0.1939299002
, 

0.0262656700
)
, 

-0.0045122354
)
;


// Tree: 209

b1_tree_209 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 54.5) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 49.5) => 
map(

      ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 1.5) => 
-0.0027999840
, 

      (v1_raacrtrecmsdmeanmmbrcnt > 1.5) => 
map(

         ( NULL < v1_raahhcnt and v1_raahhcnt <= 5.5) => 
map(

            ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
map(

               (v1_resinputdwelltype in ['G','H','R','U']) => 
-0.0051768518
, 

               (v1_resinputdwelltype in ['-1','0','F','P','S']) => 
0.0281847406
, 

0.0214451717
)
, 

            (v1_hhcrtrecmmbrcnt > 0.5) => 
0.0026834268
, 

0.0139519715
)
, 

         (v1_raahhcnt > 5.5) => 
-0.0043576078
, 

0.0037568373
)
, 

-0.0007070695
)
, 

   (v1_crtrectimenewest > 49.5) => 
-0.0244541240
, 

-0.0030129774
)
, 

(v1_prospecttimelastupdate > 54.5) => 
0.0144876562
, 

-0.0003092509
)
;


// Tree: 213

b1_tree_213 := 
map(

( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 7.5) => 
map(

      ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 5.5) => 
map(

         ( NULL < v1_hhteenagermmbrcnt and v1_hhteenagermmbrcnt <= 0.5) => 
-0.0030171730
, 

         (v1_hhteenagermmbrcnt > 0.5) => 
0.1071590422
, 

-0.0028930571
)
, 

      (v1_resinputbusinesscnt > 5.5) => 
0.0113951548
, 

-0.0022711026
)
, 

   (v1_crtrecmsdmeancnt > 7.5) => 
0.0500343815
, 

-0.0017811372
)
, 

(v1_raacrtrecevictionmmbrcnt > 0.5) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 4.5) => 
map(

      ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
0.0260934044
, 

      (v1_hhpropcurrownermmbrcnt > 0.5) => 
-0.0047857009
, 

0.0193579668
)
, 

   (v1_raammbrcnt > 4.5) => 
0.0039848213
, 

0.0056600870
)
, 

0.0005117919
)
;


// Tree: 217

b1_tree_217 := 
map(

(v1_resinputdwelltype in ['-1','F','G','H','P','R','S','U']) => 
map(

   ( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

      ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 3.5) => 
map(

         ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

            ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
0.0018229562
, 

            (v1_raammbrcnt > 0.5) => 
-0.0086859721
, 

-0.0055402329
)
, 

         (v1_resinputownershipindex > 0.5) => 
0.0017833339
, 

-0.0013510311
)
, 

      (v1_crtrecseverityindex > 3.5) => 
0.0180873397
, 

0.0001920109
)
, 

   (v1_prospectdeceased > 0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
-0.1124236976
, 

      (v1_raammbrcnt > 0.5) => 
0.1243256608
, 

0.1014144325
)
, 

0.0002806720
)
, 

(v1_resinputdwelltype in ['0']) => 
0.2405643284
, 

0.0003388511
)
;


// Tree: 221

b1_tree_221 := 
map(

( NULL < v1_donotmail and v1_donotmail <= -0.5) => 
-0.0992552473
, 

(v1_donotmail > -0.5) => 
map(

   ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 5.5) => 
map(

      ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 0.5) => 
map(

            ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 41.5) => 
-0.0021677336
, 

            (v1_prospecttimelastupdate > 41.5) => 
0.0109265103
, 

-0.0001905362
)
, 

         (v1_raacrtrecevictionmmbrcnt > 0.5) => 
map(

            ( NULL < v1_raahhcnt and v1_raahhcnt <= 2.5) => 
0.0194364479
, 

            (v1_raahhcnt > 2.5) => 
0.0062202539
, 

0.0085584065
)
, 

0.0021938211
)
, 

      (v1_raacollege4yrattendedmmbrcnt > 0.5) => 
-0.0118327789
, 

-0.0009666768
)
, 

   (v1_resinputbusinesscnt > 5.5) => 
0.0157600878
, 

-0.0003004232
)
, 

-0.0003347654
)
;


// Tree: 225

b1_tree_225 := 
map(

(v1_resinputdwelltype in ['-1','G','H','P','R','S']) => 
map(

   ( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 1.5) => 
map(

         (v1_resinputdwelltype in ['-1','G','R']) => 
-0.0445173602
, 

         (v1_resinputdwelltype in ['0','F','H','P','S','U']) => 
map(

            ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.185) => 
0.0015727129
, 

            (v1_resinputavmcntyratio > 1.185) => 
map(

               ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 1.5) => 
-0.0160440640
, 

               (v1_raamiddleagemmbrcnt > 1.5) => 
0.0164254426
, 

-0.0082713621
)
, 

0.0004922408
)
, 

0.0003115073
)
, 

      (v1_raacrtrecmsdmeanmmbrcnt > 1.5) => 
0.0127127964
, 

0.0030973155
)
, 

   (v1_raaoccbusinessassocmmbrcnt > 0.5) => 
-0.0061452211
, 

-0.0005164720
)
, 

(v1_resinputdwelltype in ['0','F','U']) => 
0.0462822363
, 

-0.0003313953
)
;


// Tree: 229

b1_tree_229 := 
map(

( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 4.5) => 
map(

      ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
0.0021520726
, 

      (v1_hhmiddleagemmbrcnt > 0.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 1.5) => 
-0.0521858872
, 

         (v1_prospecttimeonrecord > 1.5) => 
map(

            ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0345090291
, 

            (v1_lifeeveverresidedcnt > 0.5) => 
map(

               ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
-0.0478971037
, 

               (v1_raammbrcnt > 0.5) => 
-0.0044813483
, 

-0.0061208272
)
, 

-0.0053012530
)
, 

-0.0082120351
)
, 

-0.0004060887
)
, 

   (v1_crtrecmsdmeancnt > 4.5) => 
0.0317021665
, 

0.0007995045
)
, 

(v1_hhcollegeattendedmmbrcnt > 0.5) => 
-0.0093590521
, 

-0.0013234684
)
;


// Tree: 233

b1_tree_233 := 
map(

( NULL < v1_hhteenagermmbrcnt and v1_hhteenagermmbrcnt <= 0.5) => 
map(

   ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
-0.0031308830
, 

   (v1_resinputownershipindex > 0.5) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 47996.5) => 
map(

         ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 69930) => 
map(

            ( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 0.315) => 
0.0044541313
, 

            (v1_resinputavmratiodiff60mo > 0.315) => 
0.0183401811
, 

0.0083091694
)
, 

         (v1_resinputavmvalue12mo > 69930) => 
-0.0001924626
, 

0.0041700258
)
, 

      (v1_propcurrownedassessedttl > 47996.5) => 
-0.0239931266
, 

-0.0018945325
)
, 

-0.0024340794
)
, 

(v1_hhteenagermmbrcnt > 0.5) => 
map(

   ( NULL < v1_prospectcollegeattended and v1_prospectcollegeattended <= 0.5) => 
0.0273181200
, 

   (v1_prospectcollegeattended > 0.5) => 
0.2071760977
, 

0.0844494776
)
, 

-0.0023148706
)
;


// Tree: 237

b1_tree_237 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

   ( NULL < v1_crtrecfelonycnt and v1_crtrecfelonycnt <= 0.5) => 
map(

      ( NULL < v1_donotmail and v1_donotmail <= -0.5) => 
-0.0777128029
, 

      (v1_donotmail > -0.5) => 
map(

         (v1_resinputdwelltype in ['F','G','H','P','R','S','U']) => 
-0.0004385526
, 

         (v1_resinputdwelltype in ['-1','0']) => 
map(

            ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 281004.5) => 
0.0603391707
, 

            (v1_raapropowneravmmed > 281004.5) => 
0.4222913150
, 

0.1288166034
)
, 

-0.0003989200
)
, 

-0.0004267808
)
, 

   (v1_crtrecfelonycnt > 0.5) => 
map(

      (v1_resinputdwelltype in ['H','R','S']) => 
0.0205560650
, 

      (v1_resinputdwelltype in ['-1','0','F','G','P','U']) => 
0.1096408758
, 

0.0260134868
)
, 

0.0002304347
)
, 

(v1_prospectdeceased > 0.5) => 
0.0818743515
, 

0.0003042359
)
;


// Tree: 241

b1_tree_241 := 
map(

( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 5758) => 
map(

   ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 1.255) => 
map(

      ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 374860.5) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 185388) => 
-0.0004316043
, 

         (v1_raapropowneravmmed > 185388) => 
-0.0138189498
, 

-0.0030407086
)
, 

      (v1_resinputavmvalue12mo > 374860.5) => 
-0.0216356661
, 

-0.0037783379
)
, 

   (v1_resinputavmblockratio > 1.255) => 
map(

      ( NULL < v1_lifeevecontrajectory and v1_lifeevecontrajectory <= 0.5) => 
0.0118973085
, 

      (v1_lifeevecontrajectory > 0.5) => 
-0.0137120587
, 

-0.0001879318
)
, 

-0.0034363795
)
, 

(v1_hhcrtreclienjudgamtttl > 5758) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 2.5) => 
0.0318202286
, 

   (v1_raammbrcnt > 2.5) => 
0.0114552291
, 

0.0143400670
)
, 

-0.0021217472
)
;


// Tree: 245

b1_tree_245 := 
map(

( NULL < v1_raahhcnt and v1_raahhcnt <= 6.5) => 
map(

   ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 0) => 
map(

      ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 0.5) => 
map(

         ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 0.5) => 
map(

            ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 45.5) => 
0.0000464666
, 

            (v1_prospecttimelastupdate > 45.5) => 
0.0165736955
, 

0.0021855446
)
, 

         (v1_raacrtrecevictionmmbrcnt > 0.5) => 
0.0112992201
, 

0.0039663578
)
, 

      (v1_crtrecbkrptcnt > 0.5) => 
-0.0408018717
, 

0.0022137877
)
, 

   (v1_occbusinessassociationtime > 0) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 2.5) => 
-0.0421539320
, 

      (v1_prospecttimeonrecord > 2.5) => 
-0.0279591958
, 

-0.0306594923
)
, 

0.0002032084
)
, 

(v1_raahhcnt > 6.5) => 
-0.0125979224
, 

-0.0027057215
)
;


// Tree: 249

b1_tree_249 := 
map(

( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 5.5) => 
map(

   ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

         ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 16.5) => 
map(

            ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 0.5) => 
map(

               ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 52.5) => 
-0.0005555437
, 

               (v1_crtrectimenewest > 52.5) => 
0.0417240793
, 

0.0003707666
)
, 

            (v1_raacrtrecmsdmeanmmbrcnt > 0.5) => 
0.0096285623
, 

0.0036813881
)
, 

         (v1_crtrecmsdmeantimenewest > 16.5) => 
-0.0160879227
, 

0.0022182733
)
, 

      (v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0143173658
, 

-0.0024456146
)
, 

   (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0200490582
, 

-0.0049044578
)
, 

(v1_crtrecmsdmeancnt > 5.5) => 
0.0228470704
, 

-0.0040448239
)
;


// Tree: 253

b1_tree_253 := 
map(

( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

   ( NULL < v1_crtreccnt and v1_crtreccnt <= 3.5) => 
-0.0044511944
, 

   (v1_crtreccnt > 3.5) => 
0.0177382124
, 

-0.0019323174
)
, 

(v1_resinputownershipindex > 0.5) => 
map(

   ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 51932) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 709) => 
map(

         ( NULL < v1_raahhcnt and v1_raahhcnt <= 9.5) => 
map(

            ( NULL < v1_occproflicense and v1_occproflicense <= 0.5) => 
0.0056847611
, 

            (v1_occproflicense > 0.5) => 
-0.0503615154
, 

0.0041711556
)
, 

         (v1_raahhcnt > 9.5) => 
-0.0142047020
, 

0.0019455911
)
, 

      (v1_lifeevtimelastmove > 709) => 
0.2501007638
, 

0.0021074871
)
, 

   (v1_propcurrownedavmttl > 51932) => 
-0.0198788047
, 

-0.0036562809
)
, 

-0.0029006294
)
;


// Tree: 257

b1_tree_257 := 
map(

( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 7.5) => 
map(

   (v1_resinputdwelltype in ['-1','G','H','P','R','S']) => 
map(

      ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
map(

         ( NULL < v1_crtrecfelonycnt12mo and v1_crtrecfelonycnt12mo <= 2.5) => 
map(

            ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 54.5) => 
-0.0035530910
, 

            (v1_prospecttimelastupdate > 54.5) => 
0.0101151702
, 

-0.0015703019
)
, 

         (v1_crtrecfelonycnt12mo > 2.5) => 
0.3273780719
, 

-0.0015438229
)
, 

      (v1_raacrtrecfelonymmbrcnt > 0.5) => 
0.0075072528
, 

0.0000048061
)
, 

   (v1_resinputdwelltype in ['0','F','U']) => 
0.0360589779
, 

0.0001525961
)
, 

(v1_resinputbusinesscnt > 7.5) => 
map(

   ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
0.0063683193
, 

   (v1_crtrecseverityindex > 2.5) => 
0.0741515541
, 

0.0189787046
)
, 

0.0006859179
)
;


// Tree: 261

b1_tree_261 := 
map(

( NULL < v1_hhcnt and v1_hhcnt <= 7.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 128.5) => 
map(

      ( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
-0.0013118711
, 

      (v1_prospectdeceased > 0.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 63.5) => 
-0.0511876653
, 

         (v1_prospecttimeonrecord > 63.5) => 
0.1274999685
, 

0.0805306476
)
, 

-0.0012502361
)
, 

   (v1_prospecttimelastupdate > 128.5) => 
map(

      ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
0.0559239023
, 

      (v1_hhcnt > 1.5) => 
0.0044577243
, 

0.0179593575
)
, 

-0.0006075939
)
, 

(v1_hhcnt > 7.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0753609991
, 

   (v1_lifeeveverresidedcnt > 0.5) => 
0.0354149060
, 

0.0366534188
)
, 

0.0005030010
)
;


// Tree: 265

b1_tree_265 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

   ( NULL < v1_hhteenagermmbrcnt and v1_hhteenagermmbrcnt <= 0.5) => 
-0.0010167254
, 

   (v1_hhteenagermmbrcnt > 0.5) => 
map(

      ( NULL < v1_prospectcollegeattended and v1_prospectcollegeattended <= 0.5) => 
0.0145204579
, 

      (v1_prospectcollegeattended > 0.5) => 
0.1534723160
, 

0.0596905666
)
, 

-0.0009375237
)
, 

(v1_prospectdeceased > 0.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 109.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 317) => 
map(

         ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 0.5) => 
0.0224802654
, 

         (v1_raacrtrecmsdmeanmmbrcnt > 0.5) => 
0.1716664942
, 

0.1212222298
)
, 

      (v1_lifeevtimelastmove > 317) => 
-0.0428455781
, 

0.0913039824
)
, 

   (v1_prospecttimelastupdate > 109.5) => 
-0.0358953050
, 

0.0589462690
)
, 

-0.0008824257
)
;


// Tree: 269

b1_tree_269 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 107.5) => 
map(

   (v1_resinputdwelltype in ['-1','G','R']) => 
-0.0422118118
, 

   (v1_resinputdwelltype in ['0','F','H','P','S','U']) => 
map(

      ( NULL < v1_crtrecfelonycnt and v1_crtrecfelonycnt <= 2.5) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
-0.0002588367
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
map(

            ( NULL < v1_hhcnt and v1_hhcnt <= 4.5) => 
-0.0312598252
, 

            (v1_hhcnt > 4.5) => 
0.0200407490
, 

-0.0200565194
)
, 

-0.0030731822
)
, 

      (v1_crtrecfelonycnt > 2.5) => 
0.0387688399
, 

-0.0027611432
)
, 

-0.0029064443
)
, 

(v1_prospecttimelastupdate > 107.5) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
0.0468625633
, 

   (v1_hhcnt > 1.5) => 
0.0063329425
, 

0.0161460689
)
, 

-0.0019109319
)
;


// Tree: 273

b1_tree_273 := 
map(

( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 1.5) => 
map(

   ( NULL < v1_hhoccproflicmmbrcnt and v1_hhoccproflicmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_raaelderlymmbrcnt and v1_raaelderlymmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raacrtrecevictionmmbrcnt12mo and v1_raacrtrecevictionmmbrcnt12mo <= 0.5) => 
map(

            ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.595) => 
0.0019114279
, 

            (v1_resinputavmratiodiff12mo > 1.595) => 
0.0176071103
, 

0.0023108528
)
, 

         (v1_raacrtrecevictionmmbrcnt12mo > 0.5) => 
0.0206998686
, 

0.0033026771
)
, 

      (v1_raaelderlymmbrcnt > 0.5) => 
-0.0062666149
, 

0.0015662811
)
, 

   (v1_hhoccproflicmmbrcnt > 0.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 2.5) => 
-0.0587595102
, 

      (v1_prospecttimeonrecord > 2.5) => 
-0.0190720861
, 

-0.0228239464
)
, 

0.0001439889
)
, 

(v1_prospectcollegeprogramtype > 1.5) => 
-0.0283832707
, 

-0.0009643889
)
;


// Tree: 277

b1_tree_277 := 
map(

( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 2.5) => 
map(

   ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 1385.5) => 
map(

      ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

            ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
0.0010939891
, 

            (v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0201786919
, 

-0.0035005746
)
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0259129712
, 

-0.0060612496
)
, 

      (v1_hhseniormmbrcnt > 0.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 0) => 
-0.0668530142
, 

         (v1_prospecttimeonrecord > 0) => 
-0.0193893973
, 

-0.0230095560
)
, 

-0.0073683025
)
, 

   (v1_hhcrtreclienjudgamtttl > 1385.5) => 
0.0112984598
, 

-0.0052707855
)
, 

(v1_raacrtrecevictionmmbrcnt > 2.5) => 
0.0137426284
, 

-0.0034804997
)
;


// Tree: 281

b1_tree_281 := 
map(

( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 52.5) => 
map(

   ( NULL < v1_lifeevecontrajectory and v1_lifeevecontrajectory <= 0.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 38.5) => 
0.0020462143
, 

      (v1_crtrectimenewest > 38.5) => 
-0.0168227062
, 

0.0006111594
)
, 

   (v1_lifeevecontrajectory > 0.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0289519327
, 

      (v1_lifeeveverresidedcnt > 0.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

            ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
-0.0597704762
, 

            (v1_hhpropcurrownermmbrcnt > 0.5) => 
-0.0103784563
, 

-0.0264115416
)
, 

         (v1_raammbrcnt > 0.5) => 
-0.0129497757
, 

-0.0135582592
)
, 

-0.0126263253
)
, 

-0.0039762374
)
, 

(v1_crtreclienjudgtimenewest > 52.5) => 
0.0198082165
, 

-0.0022123962
)
;


// Tree: 285

b1_tree_285 := 
map(

( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 4.5) => 
map(

   ( NULL < v1_hhteenagermmbrcnt and v1_hhteenagermmbrcnt <= 0.5) => 
-0.0004023389
, 

   (v1_hhteenagermmbrcnt > 0.5) => 
map(

      ( NULL < v1_raahhcnt and v1_raahhcnt <= 5.5) => 
map(

         ( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 228292) => 
map(

            ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 0) => 
map(

               ( NULL < v1_rescurravmtractratio and v1_rescurravmtractratio <= 1.385) => 
0.1340647083
, 

               (v1_rescurravmtractratio > 1.385) => 
0.6441689367
, 

0.1860197686
)
, 

            (v1_crtrectimenewest > 0) => 
0.0380113766
, 

0.1263257762
)
, 

         (v1_rescurravmvalue12mo > 228292) => 
-0.1326294584
, 

0.0927113948
)
, 

      (v1_raahhcnt > 5.5) => 
-0.0396206025
, 

0.0515219652
)
, 

-0.0003374528
)
, 

(v1_crtrecseverityindex > 4.5) => 
0.0219109095
, 

0.0002130910
)
;


// Tree: 289

b1_tree_289 := 
map(

(v1_resinputdwelltype in ['-1','G','H','R','S']) => 
map(

   ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 1.115) => 
-0.0020482158
, 

   (v1_resinputavmblockratio > 1.115) => 
map(

      ( NULL < v1_lifeevecontrajectory and v1_lifeevecontrajectory <= 0.5) => 
0.0091981611
, 

      (v1_lifeevecontrajectory > 0.5) => 
-0.0069904630
, 

0.0008993373
)
, 

-0.0016021110
)
, 

(v1_resinputdwelltype in ['0','F','P','U']) => 
map(

   ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 2.5) => 
0.0055335761
, 

   (v1_crtrecmsdmeancnt > 2.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 5.5) => 
map(

         ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 13.5) => 
0.0930696117
, 

         (v1_crtrecmsdmeancnt > 13.5) => 
0.3817813946
, 

0.1282088748
)
, 

      (v1_raammbrcnt > 5.5) => 
0.0525890616
, 

0.0709357680
)
, 

0.0124067579
)
, 

-0.0009280793
)
;


// Tree: 293

b1_tree_293 := 
map(

( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
-0.0029215748
, 

(v1_resinputownershipindex > 0.5) => 
map(

   ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 65396.5) => 
0.0068582459
, 

   (v1_resinputavmvalue12mo > 65396.5) => 
map(

      ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 81078) => 
-0.0084764693
, 

      (v1_raapropowneravmmed > 81078) => 
map(

         ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 7.5) => 
map(

            ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.145) => 
map(

               ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 235867) => 
0.0196025927
, 

               (v1_raapropowneravmhighest > 235867) => 
-0.0105578235
, 

0.0020969761
)
, 

            (v1_resinputavmcntyratio > 1.145) => 
0.0266342602
, 

0.0117387813
)
, 

         (v1_lifeevtimelastmove > 7.5) => 
-0.0115955557
, 

-0.0031509184
)
, 

-0.0049565448
)
, 

0.0006688799
)
, 

-0.0009023461
)
;


// Tree: 297

b1_tree_297 := 
map(

( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 162630) => 
map(

   ( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 0.5) => 
0.0032630169
, 

   (v1_raaoccbusinessassocmmbrcnt > 0.5) => 
map(

      (v1_resinputdwelltype in ['F','H','P','R','S','U']) => 
-0.0043344009
, 

      (v1_resinputdwelltype in ['-1','0','G']) => 
0.2271341688
, 

-0.0042377543
)
, 

0.0005224466
)
, 

(v1_resinputavmvalue60mo > 162630) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 36364.5) => 
map(

      ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 1488658) => 
map(

         ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 0.5) => 
-0.0153986303
, 

         (v1_rescurrownershipindex > 0.5) => 
-0.0024381500
, 

-0.0107286723
)
, 

      (v1_resinputavmvalue > 1488658) => 
0.0690383644
, 

-0.0101040769
)
, 

   (v1_raapropowneravmmed > 36364.5) => 
-0.0011512283
, 

-0.0040792149
)
, 

-0.0004274896
)
;


// Tree: 301

b1_tree_301 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 54.5) => 
-0.0012147582
, 

(v1_prospecttimelastupdate > 54.5) => 
map(

   ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
0.0000835324
, 

   (v1_crtrecseverityindex > 2.5) => 
map(

      ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 3.5) => 
map(

            ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

               ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
-0.0517636862
, 

               (v1_verifiedcurrresmatchindex > 0.5) => 
0.0379904378
, 

0.0187464147
)
, 

            (v1_raammbrcnt > 0.5) => 
0.0918040628
, 

0.0585285871
)
, 

         (v1_raammbrcnt > 3.5) => 
0.0311056873
, 

0.0382270733
)
, 

      (v1_hhcnt > 1.5) => 
0.0106581920
, 

0.0204019907
)
, 

0.0075126452
)
, 

0.0001285640
)
;


// Tree: 305

b1_tree_305 := 
map(

( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.455) => 
map(

   ( NULL < v1_crtreccnt and v1_crtreccnt <= 6.5) => 
map(

      ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 16.5) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 0) => 
0.0002785276
, 

         (v1_crtrecbkrpttimenewest > 0) => 
map(

            ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
-0.0851260447
, 

            (v1_raammbrcnt > 0.5) => 
-0.0326717420
, 

-0.0337769697
)
, 

-0.0015476678
)
, 

      (v1_crtrecmsdmeantimenewest > 16.5) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 15.5) => 
-0.0200409286
, 

         (v1_prospecttimelastupdate > 15.5) => 
0.0111621617
, 

-0.0069629499
)
, 

-0.0021447034
)
, 

   (v1_crtreccnt > 6.5) => 
0.0182706474
, 

-0.0010183729
)
, 

(v1_resinputavmratiodiff12mo > 1.455) => 
0.0123392734
, 

-0.0004863397
)
;


// Tree: 309

b1_tree_309 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 18.5) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 26.5) => 
map(

      ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
-0.0019542347
, 

      (v1_raacrtrecfelonymmbrcnt > 0.5) => 
0.0084395979
, 

-0.0006386239
)
, 

   (v1_crtrectimenewest > 26.5) => 
-0.0168902483
, 

-0.0023947644
)
, 

(v1_prospecttimelastupdate > 18.5) => 
map(

   ( NULL < v1_lifeevecontrajectory and v1_lifeevecontrajectory <= 0.5) => 
map(

      (v1_resinputdwelltype in ['R','S','U']) => 
map(

         ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 7.5) => 
0.0082263676
, 

         (v1_resinputbusinesscnt > 7.5) => 
0.1067152770
, 

0.0102848175
)
, 

      (v1_resinputdwelltype in ['-1','0','F','G','H','P']) => 
0.0526813055
, 

0.0210144000
)
, 

   (v1_lifeevecontrajectory > 0.5) => 
0.0025674155
, 

0.0052532667
)
, 

-0.0002764977
)
;


// Tree: 313

b1_tree_313 := 
map(

(v1_resinputdwelltype in ['-1','F','G','H','P','R','S','U']) => 
map(

   ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
-0.0026888838
, 

   (v1_resinputownershipindex > 0.5) => 
map(

      ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 172250.5) => 
map(

         ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 236398) => 
map(

            ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
0.0082331582
, 

            (v1_lifeeveverresidedcnt > 1.5) => 
-0.0132448093
, 

0.0040738213
)
, 

         (v1_raapropowneravmhighest > 236398) => 
-0.0112281519
, 

0.0009957751
)
, 

      (v1_resinputavmvalue > 172250.5) => 
-0.0050920119
, 

-0.0010013724
)
, 

-0.0017415353
)
, 

(v1_resinputdwelltype in ['0']) => 
map(

   ( NULL < v1_raahhcnt and v1_raahhcnt <= 2.5) => 
-0.0667132598
, 

   (v1_raahhcnt > 2.5) => 
0.2229055228
, 

0.1292053284
)
, 

-0.0017056021
)
;


// Tree: 317

b1_tree_317 := 
map(

(v1_resinputdwelltype in ['-1','G','H','P','R','S']) => 
map(

   ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 3.5) => 
map(

      ( NULL < v1_hhcnt and v1_hhcnt <= 26.5) => 
-0.0010887430
, 

      (v1_hhcnt > 26.5) => 
0.4349557792
, 

-0.0010407467
)
, 

   (v1_crtrecseverityindex > 3.5) => 
0.0136473745
, 

0.0001312966
)
, 

(v1_resinputdwelltype in ['0','F','U']) => 
map(

   ( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 73756.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 3.5) => 
map(

         ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 0.5) => 
0.6448073374
, 

         (v1_rescurrownershipindex > 0.5) => 
0.0442305055
, 

0.0628892031
)
, 

      (v1_raammbrcnt > 3.5) => 
-0.0098424221
, 

0.0290131661
)
, 

   (v1_rescurravmvalue60mo > 73756.5) => 
0.4980038518
, 

0.0390119523
)
, 

0.0002858439
)
;


// Tree: 321

b1_tree_321 := 
map(

( NULL < v1_hhcnt and v1_hhcnt <= 33) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 16.5) => 
map(

      ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
0.0006245873
, 

         (v1_raacrtrecfelonymmbrcnt > 0.5) => 
map(

            ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 2.5) => 
0.0174711075
, 

            (v1_crtrectimenewest > 2.5) => 
0.0016640255
, 

0.0094345221
)
, 

0.0016533245
)
, 

      (v1_hhseniormmbrcnt > 0.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 2.5) => 
-0.0659623539
, 

         (v1_prospecttimeonrecord > 2.5) => 
-0.0095414125
, 

-0.0130391118
)
, 

0.0003241840
)
, 

   (v1_raammbrcnt > 16.5) => 
-0.0125280491
, 

-0.0015036839
)
, 

(v1_hhcnt > 33) => 
0.4472699652
, 

-0.0014765189
)
;


// Tree: 325

b1_tree_325 := 
map(

(v1_resinputdwelltype in ['G','H','R']) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
map(

            ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 1.075) => 
0.0059193650
, 

            (v1_resinputavmtractratio > 1.075) => 
0.0480932755
, 

0.0071756339
)
, 

         (v1_hhseniormmbrcnt > 0.5) => 
-0.0691132220
, 

0.0062897055
)
, 

      (v1_hhelderlymmbrcnt > 0.5) => 
-0.0982638791
, 

0.0053483552
)
, 

   (v1_raammbrcnt > 0.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 18.5) => 
-0.0139140100
, 

      (v1_prospecttimeonrecord > 18.5) => 
0.0044819526
, 

-0.0065296383
)
, 

-0.0032539598
)
, 

(v1_resinputdwelltype in ['-1','0','F','P','S','U']) => 
0.0015241821
, 

0.0004913450
)
;


// Tree: 329

b1_tree_329 := 
map(

( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 0.5) => 
map(

   ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 4.5) => 
map(

      ( NULL < v1_raaelderlymmbrcnt and v1_raaelderlymmbrcnt <= 0.5) => 
0.0011823829
, 

      (v1_raaelderlymmbrcnt > 0.5) => 
-0.0083866949
, 

-0.0005803253
)
, 

   (v1_crtrecmsdmeancnt > 4.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 2.5) => 
0.0452781556
, 

      (v1_raammbrcnt > 2.5) => 
0.0149571459
, 

0.0168561036
)
, 

0.0001053628
)
, 

(v1_prospectcollegeprogramtype > 0.5) => 
map(

   ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 0) => 
-0.0582231041
, 

      (v1_prospecttimeonrecord > 0) => 
-0.0406611065
, 

-0.0466855952
)
, 

   (v1_prospectcollegeattending > 0.5) => 
0.0101392054
, 

-0.0231680310
)
, 

-0.0010885299
)
;


// Tree: 333

b1_tree_333 := 
map(

( NULL < v1_hhcnt and v1_hhcnt <= 6.5) => 
map(

   ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 5.5) => 
-0.0026969975
, 

      (v1_resinputbusinesscnt > 5.5) => 
map(

         ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 1507987.5) => 
0.0062804110
, 

         (v1_resinputavmvalue60mo > 1507987.5) => 
0.1196172761
, 

0.0071547551
)
, 

-0.0022625374
)
, 

   (v1_raacrtrecevictionmmbrcnt > 0.5) => 
map(

      ( NULL < v1_raahhcnt and v1_raahhcnt <= 0.5) => 
0.0720372027
, 

      (v1_raahhcnt > 0.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 4.5) => 
0.0108386794
, 

         (v1_raammbrcnt > 4.5) => 
0.0011438803
, 

0.0022108971
)
, 

0.0023092358
)
, 

-0.0008751420
)
, 

(v1_hhcnt > 6.5) => 
0.0258159709
, 

0.0003618063
)
;


// Tree: 337

b1_tree_337 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 160.5) => 
map(

      ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 29274.5) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
0.0001894555
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0171414197
, 

-0.0022633272
)
, 

      (v1_hhcrtreclienjudgamtttl > 29274.5) => 
0.0369105525
, 

-0.0014890358
)
, 

   (v1_prospecttimelastupdate > 160.5) => 
0.0253099053
, 

-0.0009547478
)
, 

(v1_prospectdeceased > 0.5) => 
map(

   ( NULL < v1_raacollege2yrattendedmmbrcnt and v1_raacollege2yrattendedmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_crtreccnt and v1_crtreccnt <= 1.5) => 
0.0107004604
, 

      (v1_crtreccnt > 1.5) => 
0.1392054974
, 

0.0450982733
)
, 

   (v1_raacollege2yrattendedmmbrcnt > 0.5) => 
0.2059753697
, 

0.0631338222
)
, 

-0.0008970742
)
;


// Tree: 341

b1_tree_341 := 
map(

( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 1.5) => 
-0.0015714030
, 

(v1_raacrtrecmsdmeanmmbrcnt > 1.5) => 
map(

   ( NULL < v1_raahhcnt and v1_raahhcnt <= 5.5) => 
map(

      ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
map(

         (v1_resinputdwelltype in ['0','F','G','H','R','U']) => 
-0.0043356182
, 

         (v1_resinputdwelltype in ['-1','P','S']) => 
map(

            ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
0.0236018399
, 

            (v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0309795428
, 

0.0151031001
)
, 

0.0112289161
)
, 

      (v1_hhcrtrecmmbrcnt > 0.5) => 
map(

         (v1_resinputdwelltype in ['H','R','S','U']) => 
-0.0040709040
, 

         (v1_resinputdwelltype in ['-1','0','F','G','P']) => 
0.0393541912
, 

-0.0005904392
)
, 

0.0049928291
)
, 

   (v1_raahhcnt > 5.5) => 
-0.0049494392
, 

-0.0008069989
)
, 

-0.0012883035
)
;


// Tree: 345

b1_tree_345 := 
map(

( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 2.5) => 
map(

   ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 2100008) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 3.5) => 
-0.0002528006
, 

      (v1_crtrecbkrpttimenewest > 3.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
-0.0759709467
, 

         (v1_raammbrcnt > 0.5) => 
-0.0291290758
, 

-0.0299310959
)
, 

-0.0021106964
)
, 

   (v1_resinputavmvalue60mo > 2100008) => 
map(

      ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 23000) => 
0.0973425337
, 

      (v1_hhpropcurravmhighest > 23000) => 
-0.0805553252
, 

0.0158060151
)
, 

-0.0020901941
)
, 

(v1_crtrecmsdmeancnt > 2.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 71.5) => 
0.0089314695
, 

   (v1_prospecttimelastupdate > 71.5) => 
0.0901509527
, 

0.0146985896
)
, 

-0.0009318681
)
;


// Tree: 349

b1_tree_349 := 
map(

( NULL < v1_raacollegetoptiermmbrcnt and v1_raacollegetoptiermmbrcnt <= 0.5) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 7.5) => 
map(

      ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

            ( NULL < v1_raainterestsportpersonmmbrcnt and v1_raainterestsportpersonmmbrcnt <= 1.5) => 
map(

               ( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 0.5) => 
0.0013312619
, 

               (v1_hhelderlymmbrcnt > 0.5) => 
-0.0300419699
, 

0.0004141720
)
, 

            (v1_raainterestsportpersonmmbrcnt > 1.5) => 
0.0295811712
, 

0.0010758345
)
, 

         (v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0111792539
, 

-0.0021359749
)
, 

      (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0160031228
, 

-0.0039381067
)
, 

   (v1_hhcnt > 7.5) => 
0.0262197671
, 

-0.0030636126
)
, 

(v1_raacollegetoptiermmbrcnt > 0.5) => 
-0.0206306441
, 

-0.0041237140
)
;


// Tree: 353

b1_tree_353 := 
map(

( NULL < v1_hhcrtrecfelonymmbrcnt and v1_hhcrtrecfelonymmbrcnt <= 0.5) => 
map(

   ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 4.555) => 
map(

      ( NULL < v1_raaelderlymmbrcnt and v1_raaelderlymmbrcnt <= 0.5) => 
map(

         ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 377875) => 
map(

            ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
0.0022073996
, 

            (v1_lifeeveverresidedcnt > 1.5) => 
-0.0159982339
, 

-0.0008828436
)
, 

         (v1_resinputavmvalue60mo > 377875) => 
-0.0091888163
, 

-0.0014170412
)
, 

      (v1_raaelderlymmbrcnt > 0.5) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 469) => 
-0.0095142396
, 

         (v1_prospecttimelastupdate > 469) => 
0.3959458234
, 

-0.0093352127
)
, 

-0.0029233071
)
, 

   (v1_resinputavmtractratio > 4.555) => 
0.0433796415
, 

-0.0027854591
)
, 

(v1_hhcrtrecfelonymmbrcnt > 0.5) => 
0.0189507962
, 

-0.0019977738
)
;


// Tree: 357

b1_tree_357 := 
map(

( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
-0.0028498963
, 

(v1_resinputownershipindex > 0.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
map(

      ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 33.5) => 
map(

         ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 1.5) => 
map(

            ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
-0.0026717382
, 

            (v1_verifiedcurrresmatchindex > 0.5) => 
map(

               ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 104.5) => 
0.0651951727
, 

               (v1_lifeevtimelastmove > 104.5) => 
0.0051905231
, 

0.0231331909
)
, 

0.0031819623
)
, 

         (v1_raamiddleagemmbrcnt > 1.5) => 
0.0121979575
, 

0.0072892671
)
, 

      (v1_crtrecmsdmeantimenewest > 33.5) => 
-0.0135949316
, 

0.0055319832
)
, 

   (v1_lifeeveverresidedcnt > 1.5) => 
-0.0137836918
, 

0.0004775706
)
, 

-0.0009770514
)
;


// Tree: 361

b1_tree_361 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

   (v1_resinputdwelltype in ['G','R']) => 
map(

      ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 1.5) => 
-0.0529649854
, 

      (v1_raacrtreclienjudgmmbrcnt > 1.5) => 
0.0284292304
, 

-0.0258024662
)
, 

   (v1_resinputdwelltype in ['-1','0','F','H','P','S','U']) => 
map(

      ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 4.845) => 
0.0001108161
, 

      (v1_resinputavmcntyratio > 4.845) => 
0.0440798692
, 

0.0002334251
)
, 

0.0001417305
)
, 

(v1_prospectdeceased > 0.5) => 
map(

   ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 1.075) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 128) => 
0.0893355252
, 

      (v1_prospecttimelastupdate > 128) => 
-0.0322294346
, 

0.0621839605
)
, 

   (v1_rescurravmratiodiff60mo > 1.075) => 
-0.1508005775
, 

0.0518948524
)
, 

0.0001849619
)
;


// Tree: 365

b1_tree_365 := 
map(

( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 0.5) => 
0.0013077322
, 

(v1_hhcollegeattendedmmbrcnt > 0.5) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 1.5) => 
map(

      ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

            ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 123297) => 
-0.0672321218
, 

            (v1_resinputavmvalue12mo > 123297) => 
-0.0074834629
, 

-0.0568561892
)
, 

         (v1_raammbrcnt > 0.5) => 
-0.0277134446
, 

-0.0451503169
)
, 

      (v1_hhpropcurrownermmbrcnt > 0.5) => 
map(

         ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0618538323
, 

         (v1_lifeeveverresidedcnt > 0.5) => 
-0.0204380554
, 

-0.0060402081
)
, 

-0.0228167250
)
, 

   (v1_raammbrcnt > 1.5) => 
-0.0041930859
, 

-0.0053922158
)
, 

-0.0000960438
)
;


// Tree: 369

b1_tree_369 := 
map(

( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
map(

   ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 58.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 42.5) => 
-0.0015285781
, 

      (v1_prospecttimelastupdate > 42.5) => 
map(

         ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

            ( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 2.065) => 
0.0207520743
, 

            (v1_rescurravmratiodiff12mo > 2.065) => 
0.2459447225
, 

0.0230664900
)
, 

         (v1_lifeeveverresidedcnt > 0.5) => 
map(

            ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
-0.0125885378
, 

            (v1_raammbrcnt > 0.5) => 
0.0127060660
, 

0.0106896798
)
, 

0.0110198502
)
, 

0.0006930845
)
, 

   (v1_crtrecmsdmeancnt > 58.5) => 
0.5122846899
, 

0.0007179162
)
, 

(v1_raacrtrecfelonymmbrcnt > 0.5) => 
0.0086249302
, 

0.0020510785
)
;


// Tree: 373

b1_tree_373 := 
map(

( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 0.5) => 
-0.0008202059
, 

   (v1_raacrtrecmsdmeanmmbrcnt > 0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 5.5) => 
0.0123036000
, 

      (v1_raammbrcnt > 5.5) => 
0.0009358892
, 

0.0038402554
)
, 

0.0012027947
)
, 

(v1_raaoccproflicmmbrcnt > 0.5) => 
map(

   (v1_resinputdwelltype in ['F','H','U']) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 36.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 3.5) => 
-0.0588531699
, 

         (v1_raammbrcnt > 3.5) => 
-0.0294281890
, 

-0.0316192932
)
, 

      (v1_prospecttimeonrecord > 36.5) => 
0.0050398797
, 

-0.0133173219
)
, 

   (v1_resinputdwelltype in ['-1','0','G','P','R','S']) => 
-0.0039745523
, 

-0.0056309279
)
, 

-0.0004491304
)
;


// Tree: 377

b1_tree_377 := 
map(

( NULL < v1_crtreccnt and v1_crtreccnt <= 9.5) => 
map(

   ( NULL < v1_raahhcnt and v1_raahhcnt <= 6.5) => 
map(

      ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 1.5) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 18.5) => 
-0.0014319364
, 

         (v1_prospecttimelastupdate > 18.5) => 
map(

            ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 82.5) => 
0.0239073502
, 

            (v1_lifeevtimelastmove > 82.5) => 
0.0010368043
, 

0.0069656502
)
, 

0.0004871721
)
, 

      (v1_raacrtrecevictionmmbrcnt > 1.5) => 
0.0130574293
, 

0.0014228580
)
, 

   (v1_raahhcnt > 6.5) => 
-0.0095905029
, 

-0.0009824278
)
, 

(v1_crtreccnt > 9.5) => 
map(

   ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 4.4) => 
0.0219683509
, 

   (v1_rescurravmcntyratio > 4.4) => 
0.9816671320
, 

0.0239483871
)
, 

-0.0002022206
)
;


// Tree: 381

b1_tree_381 := 
map(

( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

   (v1_resinputdwelltype in ['-1','G','H','R','S']) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
0.0026807365
, 

      (v1_raammbrcnt > 0.5) => 
-0.0074807910
, 

-0.0046094890
)
, 

   (v1_resinputdwelltype in ['0','F','P','U']) => 
0.0079642390
, 

-0.0032378433
)
, 

(v1_resinputownershipindex > 0.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
map(

      ( NULL < v1_occproflicense and v1_occproflicense <= 0.5) => 
map(

         ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 1.5) => 
0.0052787381
, 

         (v1_occbusinessassociationtime > 1.5) => 
-0.0272129885
, 

0.0037584159
)
, 

      (v1_occproflicense > 0.5) => 
-0.0562074691
, 

0.0020184255
)
, 

   (v1_lifeeveverresidedcnt > 1.5) => 
-0.0167324133
, 

-0.0028724538
)
, 

-0.0030324912
)
;


// Tree: 385

b1_tree_385 := 
map(

( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 1.5) => 
0.0005223470
, 

(v1_hhmiddleagemmbrcnt > 1.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

      ( NULL < v1_hhcrtrecbkrptmmbrcnt and v1_hhcrtrecbkrptmmbrcnt <= 0.5) => 
0.0385543714
, 

      (v1_hhcrtrecbkrptmmbrcnt > 0.5) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 110.5) => 
map(

            ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.495) => 
-0.0147512455
, 

            (v1_resinputavmcntyratio > 1.495) => 
0.1588473907
, 

-0.0022019465
)
, 

         (v1_prospecttimelastupdate > 110.5) => 
-0.1273719601
, 

-0.0164561829
)
, 

0.0218791117
)
, 

   (v1_lifeeveverresidedcnt > 0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
-0.0551654386
, 

      (v1_raammbrcnt > 0.5) => 
-0.0268305852
, 

-0.0279433978
)
, 

-0.0262099694
)
, 

-0.0023519239
)
;


// Tree: 389

b1_tree_389 := 
map(

( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 4.5) => 
map(

   ( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
-0.0009862527
, 

   (v1_prospectdeceased > 0.5) => 
map(

      ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 1.26) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 176.5) => 
map(

            ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 134.5) => 
0.0366979650
, 

            (v1_prospecttimelastupdate > 134.5) => 
-0.1627580426
, 

0.0112771012
)
, 

         (v1_prospecttimeonrecord > 176.5) => 
map(

            ( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.225) => 
0.0901544636
, 

            (v1_rescurravmratiodiff12mo > 1.225) => 
0.3113363154
, 

0.1190042704
)
, 

0.0623642124
)
, 

      (v1_resinputavmtractratio > 1.26) => 
-0.0789245587
, 

0.0439903363
)
, 

-0.0009455953
)
, 

(v1_hhcrtrecmmbrcnt > 4.5) => 
0.0645927216
, 

-0.0006509686
)
;


// Tree: 393

b1_tree_393 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

   ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 6.035) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 106.5) => 
-0.0002248739
, 

      (v1_prospecttimelastupdate > 106.5) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
map(

            ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 9329) => 
0.0328861038
, 

            (v1_crtreclienjudgamtttl > 9329) => 
map(

               ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 237.5) => 
0.1633415928
, 

               (v1_prospecttimeonrecord > 237.5) => 
-0.0297966043
, 

0.1195920565
)
, 

0.0379551534
)
, 

         (v1_hhcnt > 1.5) => 
0.0037462913
, 

0.0118819985
)
, 

0.0004128559
)
, 

   (v1_resinputavmblockratio > 6.035) => 
0.0442784667
, 

0.0004897534
)
, 

(v1_prospectdeceased > 0.5) => 
0.0427583111
, 

0.0005293262
)
;


// Tree: 397

b1_tree_397 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

   ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 0.995) => 
-0.0020582793
, 

   (v1_resinputavmblockratio > 0.995) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

         ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 0.5) => 
map(

            ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 25) => 
-0.0014892134
, 

            (v1_lifeevtimelastmove > 25) => 
0.0544298786
, 

0.0000440224
)
, 

         (v1_raacrtrecmsdmeanmmbrcnt > 0.5) => 
map(

            ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 28.5) => 
0.0211676757
, 

            (v1_crtrecmsdmeantimenewest > 28.5) => 
-0.0201626524
, 

0.0161588240
)
, 

0.0069112839
)
, 

      (v1_lifeeveverresidedcnt > 0.5) => 
-0.0063083933
, 

-0.0002330042
)
, 

-0.0016321220
)
, 

(v1_prospectdeceased > 0.5) => 
0.0575069777
, 

-0.0015808117
)
;


// Tree: 401

b1_tree_401 := 
map(

( NULL < v1_hhteenagermmbrcnt and v1_hhteenagermmbrcnt <= 0.5) => 
map(

   ( NULL < v1_crtrecfelonycnt and v1_crtrecfelonycnt <= 2.5) => 
0.0008336873
, 

   (v1_crtrecfelonycnt > 2.5) => 
map(

      ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 124.5) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 43766.5) => 
map(

            ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.245) => 
0.0656715516
, 

            (v1_resinputavmratiodiff12mo > 1.245) => 
0.2358467754
, 

0.0753335149
)
, 

         (v1_raapropowneravmmed > 43766.5) => 
0.0228755433
, 

0.0486096426
)
, 

      (v1_crtrecfelonytimenewest > 124.5) => 
-0.0149968925
, 

0.0260907880
)
, 

0.0010095261
)
, 

(v1_hhteenagermmbrcnt > 0.5) => 
map(

   ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
0.0436188786
, 

   (v1_prospectcollegeattending > 0.5) => 
0.3249759806
, 

0.0551936961
)
, 

0.0010786218
)
;


// Tree: 405

b1_tree_405 := 
map(

( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 29482) => 
-0.0003259582
, 

(v1_hhcrtreclienjudgamtttl > 29482) => 
map(

   ( NULL < v1_raappcurrownerwtrcrftmmbrcnt and v1_raappcurrownerwtrcrftmmbrcnt <= 4.5) => 
map(

      ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 1.5) => 
map(

         ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
map(

            ( NULL < v1_rescurravmvalue and v1_rescurravmvalue <= 153013.5) => 
0.0345556027
, 

            (v1_rescurravmvalue > 153013.5) => 
map(

               ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 30.5) => 
0.2500762397
, 

               (v1_lifeevtimelastmove > 30.5) => 
0.1378464999
, 

0.1519429890
)
, 

0.0636564278
)
, 

         (v1_lifeeveverresidedcnt > 1.5) => 
0.0033672669
, 

0.0356581260
)
, 

      (v1_raapropcurrownermmbrcnt > 1.5) => 
0.0134060753
, 

0.0205075998
)
, 

   (v1_raappcurrownerwtrcrftmmbrcnt > 4.5) => 
1.2505521306
, 

0.0237723158
)
, 

0.0001503592
)
;


// Tree: 409

b1_tree_409 := 
map(

( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 4.5) => 
map(

   ( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 470038) => 
0.0009654718
, 

      (v1_resinputavmvalue > 470038) => 
map(

         ( NULL < v1_raahhcnt and v1_raahhcnt <= 0.5) => 
map(

            ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 714889) => 
-0.0254790353
, 

            (v1_hhpropcurravmhighest > 714889) => 
map(

               ( NULL < v1_lifeevecontrajectoryindex and v1_lifeevecontrajectoryindex <= 1.5) => 
0.1659061006
, 

               (v1_lifeevecontrajectoryindex > 1.5) => 
-0.0030945212
, 

0.0445937731
)
, 

-0.0195341772
)
, 

         (v1_raahhcnt > 0.5) => 
-0.0025244938
, 

-0.0073026977
)
, 

0.0006070012
)
, 

   (v1_hhcollegeattendedmmbrcnt > 0.5) => 
-0.0075006769
, 

-0.0010749592
)
, 

(v1_hhcrtrecmmbrcnt > 4.5) => 
0.0580116801
, 

-0.0008052824
)
;


// Tree: 413

b1_tree_413 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 20.5) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 11.5) => 
-0.0002594777
, 

   (v1_crtrectimenewest > 11.5) => 
-0.0134660920
, 

-0.0023982269
)
, 

(v1_prospecttimelastupdate > 20.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0215300335
, 

   (v1_lifeeveverresidedcnt > 0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

         ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
-0.0399471378
, 

         (v1_resinputownershipindex > 0.5) => 
map(

            ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 102.5) => 
0.0392053776
, 

            (v1_lifeevtimelastmove > 102.5) => 
-0.0163349790
, 

0.0037744604
)
, 

-0.0130941857
)
, 

      (v1_raammbrcnt > 0.5) => 
0.0090845104
, 

0.0076036808
)
, 

0.0078978597
)
, 

0.0003633484
)
;


// Tree: 417

b1_tree_417 := 
map(

( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 1.265) => 
-0.0003147327
, 

(v1_resinputavmblockratio > 1.265) => 
map(

   ( NULL < v1_lifeevecontrajectory and v1_lifeevecontrajectory <= 0.5) => 
map(

      ( NULL < v1_raacollegeattendedmmbrcnt and v1_raacollegeattendedmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 1.555) => 
0.0022551385
, 

         (v1_rescurravmcntyratio > 1.555) => 
0.1333243390
, 

0.0052077852
)
, 

      (v1_raacollegeattendedmmbrcnt > 0.5) => 
map(

         ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 689852.5) => 
map(

            ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 2.5) => 
0.0355074658
, 

            (v1_crtrectimenewest > 2.5) => 
-0.0025427023
, 

0.0279193777
)
, 

         (v1_resinputavmvalue > 689852.5) => 
-0.0339965671
, 

0.0238036150
)
, 

0.0131475961
)
, 

   (v1_lifeevecontrajectory > 0.5) => 
-0.0031708712
, 

0.0048163996
)
, 

0.0001637304
)
;


// Tree: 421

b1_tree_421 := 
map(

( NULL < v1_crtrecmsdmeancnt12mo and v1_crtrecmsdmeancnt12mo <= 1.5) => 
map(

   ( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 5.645) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 800) => 
map(

         ( NULL < v1_raacollegeattendedmmbrcnt and v1_raacollegeattendedmmbrcnt <= 0.5) => 
0.0006528851
, 

         (v1_raacollegeattendedmmbrcnt > 0.5) => 
-0.0039614578
, 

-0.0015870660
)
, 

      (v1_prospecttimeonrecord > 800) => 
map(

         ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 107938.5) => 
0.3797387996
, 

         (v1_raapropowneravmhighest > 107938.5) => 
-0.0123601041
, 

0.1556822832
)
, 

-0.0015691467
)
, 

   (v1_resinputavmratiodiff60mo > 5.645) => 
map(

      ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 0.57) => 
0.3246133120
, 

      (v1_resinputavmcntyratio > 0.57) => 
0.0470236480
, 

0.0619478235
)
, 

-0.0015211078
)
, 

(v1_crtrecmsdmeancnt12mo > 1.5) => 
0.0246503706
, 

-0.0013230823
)
;


// Tree: 425

b1_tree_425 := 
map(

(v1_resinputdwelltype in ['-1','F','G','H','P','R','S','U']) => 
map(

   ( NULL < v1_occproflicense and v1_occproflicense <= 0.5) => 
map(

      ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
-0.0002740515
, 

      (v1_raacrtrecfelonymmbrcnt > 0.5) => 
0.0075061487
, 

0.0010347029
)
, 

   (v1_occproflicense > 0.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 9.5) => 
-0.0617771450
, 

      (v1_prospecttimeonrecord > 9.5) => 
-0.0244914803
, 

-0.0304895739
)
, 

-0.0001430945
)
, 

(v1_resinputdwelltype in ['0']) => 
map(

   ( NULL < v1_raahhcnt and v1_raahhcnt <= 5.5) => 
map(

      ( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 0.5) => 
-0.0829016603
, 

      (v1_raaoccproflicmmbrcnt > 0.5) => 
0.1827537785
, 

0.0204087881
)
, 

   (v1_raahhcnt > 5.5) => 
0.2279693549
, 

0.1093633167
)
, 

-0.0001152543
)
;


// Tree: 429

b1_tree_429 := 
map(

( NULL < v1_crtrecfelonycnt12mo and v1_crtrecfelonycnt12mo <= 4.5) => 
map(

   ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 14499.5) => 
map(

      ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.595) => 
map(

         ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 1.745) => 
-0.0017077743
, 

         (v1_resinputavmblockratio > 1.745) => 
0.0118618667
, 

-0.0013064622
)
, 

      (v1_resinputavmratiodiff12mo > 1.595) => 
0.0094420029
, 

-0.0010220047
)
, 

   (v1_hhcrtreclienjudgamtttl > 14499.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 39.5) => 
0.0015103187
, 

      (v1_prospecttimelastupdate > 39.5) => 
map(

         ( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 3.44) => 
0.0348827013
, 

         (v1_rescurravmblockratio > 3.44) => 
0.6975899858
, 

0.0371203173
)
, 

0.0152041009
)
, 

-0.0004167935
)
, 

(v1_crtrecfelonycnt12mo > 4.5) => 
0.2045378056
, 

-0.0004002518
)
;


// Tree: 433

b1_tree_433 := 
map(

( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 1.5) => 
map(

   ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 1410042) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 21.5) => 
map(

         ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 1.5) => 
-0.0004346320
, 

         (v1_raacrtrecmsdmeanmmbrcnt > 1.5) => 
map(

            (v1_resinputdwelltype in ['F','H','R','S','U']) => 
0.0044351882
, 

            (v1_resinputdwelltype in ['-1','0','G','P']) => 
0.0292701768
, 

0.0058694312
)
, 

0.0015563822
)
, 

      (v1_raammbrcnt > 21.5) => 
-0.0158253809
, 

0.0002249427
)
, 

   (v1_resinputavmvalue > 1410042) => 
0.0424239905
, 

0.0003209546
)
, 

(v1_hhmiddleagemmbrcnt > 1.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0205395935
, 

   (v1_lifeeveverresidedcnt > 0.5) => 
-0.0282265648
, 

-0.0264347378
)
, 

-0.0025646834
)
;


// Tree: 437

b1_tree_437 := 
map(

( NULL < v1_hhteenagermmbrcnt and v1_hhteenagermmbrcnt <= 0.5) => 
map(

   ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 1.5) => 
map(

      (v1_resinputdwelltype in ['-1','G','R']) => 
-0.0357185780
, 

      (v1_resinputdwelltype in ['0','F','H','P','S','U']) => 
-0.0006474543
, 

-0.0007820115
)
, 

   (v1_raacrtrecevictionmmbrcnt > 1.5) => 
map(

      ( NULL < v1_raahhcnt and v1_raahhcnt <= 4.5) => 
map(

         ( NULL < v1_crtreccnt and v1_crtreccnt <= 0.5) => 
0.0278222779
, 

         (v1_crtreccnt > 0.5) => 
-0.0024508491
, 

0.0132781546
)
, 

      (v1_raahhcnt > 4.5) => 
0.0045697429
, 

0.0062562147
)
, 

0.0003924625
)
, 

(v1_hhteenagermmbrcnt > 0.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
-0.0146519838
, 

   (v1_hhmiddleagemmbrcnt > 0.5) => 
0.1162052926
, 

0.0708058293
)
, 

0.0004899258
)
;


// Tree: 441

b1_tree_441 := 
map(

( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 456794.5) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 3.5) => 
map(

      ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 0.5) => 
-0.0015236165
, 

      (v1_rescurrownershipindex > 0.5) => 
0.0047465546
, 

0.0022858717
)
, 

   (v1_raammbrcnt > 3.5) => 
-0.0017201002
, 

-0.0002042011
)
, 

(v1_resinputavmvalue60mo > 456794.5) => 
map(

   ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 33250) => 
map(

      ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 2.165) => 
-0.0268524369
, 

      (v1_resinputavmcntyratio > 2.165) => 
map(

         ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 0.875) => 
0.1877699937
, 

         (v1_resinputavmtractratio > 0.875) => 
0.0010716327
, 

0.0045418625
)
, 

-0.0193789267
)
, 

   (v1_raapropowneravmhighest > 33250) => 
-0.0024473756
, 

-0.0079081270
)
, 

-0.0005309753
)
;


// Tree: 445

b1_tree_445 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 3.5) => 
map(

   ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 0.605) => 
0.0039858176
, 

   (v1_resinputavmcntyratio > 0.605) => 
map(

      ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 1.5) => 
map(

         ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 18.5) => 
map(

            ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 0.615) => 
-0.0089645835
, 

            (v1_rescurravmcntyratio > 0.615) => 
map(

               ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0570873321
, 

               (v1_lifeeveverresidedcnt > 0.5) => 
0.0000456477
, 

0.0033582774
)
, 

-0.0047002708
)
, 

         (v1_resinputbusinesscnt > 18.5) => 
0.0635644236
, 

-0.0040912040
)
, 

      (v1_raamiddleagemmbrcnt > 1.5) => 
0.0273827184
, 

-0.0015525849
)
, 

0.0025588617
)
, 

(v1_raammbrcnt > 3.5) => 
-0.0030408961
, 

-0.0009237337
)
;


// Tree: 449

b1_tree_449 := 
map(

( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_crtreccnt and v1_crtreccnt <= 63.5) => 
-0.0017449586
, 

   (v1_crtreccnt > 63.5) => 
0.3037685216
, 

-0.0017217728
)
, 

(v1_raacrtrecevictionmmbrcnt > 0.5) => 
map(

   ( NULL < v1_raahhcnt and v1_raahhcnt <= 0.5) => 
0.0890348533
, 

   (v1_raahhcnt > 0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 7.5) => 
map(

         ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 30227) => 
map(

            ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 128.5) => 
0.0094454011
, 

            (v1_crtrecfelonytimenewest > 128.5) => 
-0.0647949336
, 

0.0084943736
)
, 

         (v1_raacrtreclienjudgamtmax > 30227) => 
0.0504563110
, 

0.0109118018
)
, 

      (v1_raammbrcnt > 7.5) => 
0.0003318731
, 

0.0030512745
)
, 

0.0031940073
)
, 

-0.0002040948
)
;


// Tree: 453

b1_tree_453 := 
map(

( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

   ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 5.5) => 
map(

      ( NULL < v1_crtreccnt and v1_crtreccnt <= 3.5) => 
map(

         ( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 139.5) => 
-0.0034971396
, 

         (v1_rescurrbusinesscnt > 139.5) => 
1.1286287688
, 

-0.0033763022
)
, 

      (v1_crtreccnt > 3.5) => 
0.0109082641
, 

-0.0017164530
)
, 

   (v1_resinputbusinesscnt > 5.5) => 
0.0171172344
, 

-0.0012852426
)
, 

(v1_resinputownershipindex > 0.5) => 
map(

   ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 60709.5) => 
map(

      ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 0.425) => 
0.0023001460
, 

      (v1_resinputavmtractratio > 0.425) => 
0.0152379411
, 

0.0055723657
)
, 

   (v1_resinputavmvalue > 60709.5) => 
-0.0002744303
, 

0.0021658617
)
, 

0.0006549207
)
;


// Tree: 457

b1_tree_457 := 
map(

( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 96.5) => 
map(

   ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 4.5) => 
-0.0008838883
, 

   (v1_resinputbusinesscnt > 4.5) => 
map(

      ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 1.5) => 
0.0033713945
, 

      (v1_crtreclienjudgtimenewest > 1.5) => 
map(

         ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 23.5) => 
0.1032084782
, 

         (v1_lifeevtimelastmove > 23.5) => 
map(

            ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 66.5) => 
-0.0037052742
, 

            (v1_prospecttimelastupdate > 66.5) => 
map(

               ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 204.5) => 
0.1334849567
, 

               (v1_crtreclienjudgtimenewest > 204.5) => 
-0.1008087030
, 

0.0948848518
)
, 

0.0170631059
)
, 

0.0331729688
)
, 

0.0070560934
)
, 

-0.0004818119
)
, 

(v1_crtrecevictiontimenewest > 96.5) => 
0.0256294005
, 

-0.0000184981
)
;


// Tree: 461

b1_tree_461 := 
map(

( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 1.135) => 
-0.0008359667
, 

(v1_resinputavmratiodiff60mo > 1.135) => 
map(

   ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 0.655) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 20.5) => 
-0.0430584287
, 

      (v1_prospecttimeonrecord > 20.5) => 
0.0155382997
, 

-0.0152796892
)
, 

   (v1_resinputavmtractratio > 0.655) => 
map(

      ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 0.185) => 
0.1229180368
, 

      (v1_resinputavmcntyratio > 0.185) => 
map(

         ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 1.725) => 
map(

            ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 0.615) => 
0.0348074859
, 

            (v1_resinputavmcntyratio > 0.615) => 
0.0110545792
, 

0.0148240422
)
, 

         (v1_resinputavmtractratio > 1.725) => 
-0.0107105845
, 

0.0106537727
)
, 

0.0112868078
)
, 

0.0093724632
)
, 

-0.0002848522
)
;


// Tree: 465

b1_tree_465 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
-0.0001865592
, 

(v1_prospectdeceased > 0.5) => 
map(

   ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
0.0828256994
, 

   (v1_resinputownershipindex > 0.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 197) => 
-0.0575364755
, 

      (v1_lifeevtimelastmove > 197) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 313.5) => 
map(

            ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.275) => 
map(

               ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 0.5) => 
0.3071790592
, 

               (v1_raacrtrecevictionmmbrcnt > 0.5) => 
0.0763788528
, 

0.1882819832
)
, 

            (v1_resinputavmcntyratio > 1.275) => 
-0.0223905569
, 

0.1287440914
)
, 

         (v1_prospecttimeonrecord > 313.5) => 
-0.0919894125
, 

0.0642219903
)
, 

0.0024203448
)
, 

0.0362752309
)
, 

-0.0001530113
)
;


// Tree: 469

b1_tree_469 := 
map(

( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 2.5) => 
map(

   ( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 248) => 
-0.0001736417
, 

   (v1_rescurrbusinesscnt > 248) => 
0.3213845016
, 

-0.0001457539
)
, 

(v1_crtrecmsdmeancnt > 2.5) => 
map(

   (v1_resinputdwelltype in ['F','H','R','S']) => 
0.0071446768
, 

   (v1_resinputdwelltype in ['-1','0','G','P','U']) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 48.5) => 
0.0340810768
, 

      (v1_crtrectimenewest > 48.5) => 
map(

         ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 3222.5) => 
0.0803018882
, 

         (v1_crtreclienjudgamtttl > 3222.5) => 
map(

            ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 146) => 
0.2908894230
, 

            (v1_crtreclienjudgtimenewest > 146) => 
0.8326188742
, 

0.4921032191
)
, 

0.1132083873
)
, 

0.0631563805
)
, 

0.0110275468
)
, 

0.0006295560
)
;


// Tree: 473

b1_tree_473 := 
map(

( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 0.5) => 
-0.0018188678
, 

(v1_raacrtrecmsdmeanmmbrcnt > 0.5) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 7.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 147.5) => 
map(

         ( NULL < v1_raainterestsportpersonmmbrcnt and v1_raainterestsportpersonmmbrcnt <= 1.5) => 
map(

            (v1_resinputdwelltype in ['0','F','H','R','U']) => 
map(

               ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
-0.0041498619
, 

               (v1_verifiedcurrresmatchindex > 0.5) => 
0.0547317773
, 

0.0021428945
)
, 

            (v1_resinputdwelltype in ['-1','G','P','S']) => 
0.0117508203
, 

0.0093093459
)
, 

         (v1_raainterestsportpersonmmbrcnt > 1.5) => 
0.0621252768
, 

0.0104494671
)
, 

      (v1_prospecttimeonrecord > 147.5) => 
-0.0031718175
, 

0.0065485546
)
, 

   (v1_raammbrcnt > 7.5) => 
-0.0010598986
, 

0.0013441395
)
, 

-0.0001720117
)
;


// Tree: 477

b1_tree_477 := 
map(

( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 10.5) => 
map(

   ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 1.135) => 
map(

      ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 381038.5) => 
-0.0004189787
, 

      (v1_resinputavmvalue12mo > 381038.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 16.5) => 
-0.0213508221
, 

         (v1_prospecttimeonrecord > 16.5) => 
-0.0093896113
, 

-0.0147848066
)
, 

-0.0008786396
)
, 

   (v1_resinputavmblockratio > 1.135) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 72.5) => 
map(

         ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 214566) => 
0.0021054402
, 

         (v1_raapropowneravmhighest > 214566) => 
0.0239063883
, 

0.0089638754
)
, 

      (v1_prospecttimeonrecord > 72.5) => 
-0.0091581170
, 

0.0004205964
)
, 

-0.0007027225
)
, 

(v1_hhcrtrecmmbrcnt > 10.5) => 
0.2831629686
, 

-0.0006878307
)
;


// Tree: 481

b1_tree_481 := 
map(

( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 29606.5) => 
map(

   ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 61486) => 
map(

      ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 19004) => 
-0.0002145396
, 

      (v1_resinputavmvalue60mo > 19004) => 
map(

         ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 24095) => 
0.0175365742
, 

         (v1_propcurrownedassessedttl > 24095) => 
-0.0190715123
, 

0.0105103809
)
, 

0.0003937548
)
, 

   (v1_resinputavmvalue60mo > 61486) => 
map(

      ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 16429) => 
-0.0066596266
, 

      (v1_raapropowneravmhighest > 16429) => 
-0.0011616546
, 

-0.0029969402
)
, 

-0.0007158138
)
, 

(v1_hhcrtreclienjudgamtttl > 29606.5) => 
map(

   ( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 21.5) => 
0.0275966480
, 

   (v1_rescurrbusinesscnt > 21.5) => 
0.3173718382
, 

0.0293151512
)
, 

-0.0001232026
)
;


// Tree: 485

b1_tree_485 := 
map(

( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
map(

   ( NULL < v1_prospectcollegetier and v1_prospectcollegetier <= 0.5) => 
0.0002167277
, 

   (v1_prospectcollegetier > 0.5) => 
-0.0435794962
, 

-0.0011007180
)
, 

(v1_prospectcollegeattending > 0.5) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 0) => 
map(

      ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 245) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

            ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.465) => 
0.0450379527
, 

            (v1_resinputavmcntyratio > 1.465) => 
0.1418784377
, 

0.0624265886
)
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0452355772
, 

0.0377003496
)
, 

      (v1_raacrtreclienjudgamtmax > 245) => 
-0.0016230023
, 

0.0218708610
)
, 

   (v1_crtrectimenewest > 0) => 
-0.0486566819
, 

0.0029285652
)
, 

-0.0010151744
)
;


// Tree: 489

b1_tree_489 := 
map(

( NULL < v1_hhcrtrecevictionmmbrcnt and v1_hhcrtrecevictionmmbrcnt <= 2.5) => 
map(

   ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 156.5) => 
map(

      ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 21.5) => 
-0.0002195509
, 

      (v1_resinputbusinesscnt > 21.5) => 
0.0164705975
, 

-0.0000752115
)
, 

   (v1_resinputbusinesscnt > 156.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

         ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 167.5) => 
-0.1833927042
, 

         (v1_resinputbusinesscnt > 167.5) => 
-0.0561707403
, 

-0.0677363734
)
, 

      (v1_lifeeveverresidedcnt > 0.5) => 
0.0578177635
, 

-0.0117865193
)
, 

-0.0000930519
)
, 

(v1_hhcrtrecevictionmmbrcnt > 2.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 28.5) => 
0.1969588890
, 

   (v1_prospecttimeonrecord > 28.5) => 
0.0619589902
, 

0.0820208947
)
, 

0.0000139795
)
;


// Tree: 493

b1_tree_493 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

   ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 32252) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 150) => 
0.0009423867
, 

      (v1_propcurrownedassessedttl > 150) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 1.5) => 
map(

            ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 10890) => 
0.1419979041
, 

            (v1_hhpropcurravmhighest > 10890) => 
map(

               ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 9.5) => 
-0.0597726393
, 

               (v1_prospecttimelastupdate > 9.5) => 
0.1082880498
, 

0.0331771273
)
, 

0.0896352185
)
, 

         (v1_raammbrcnt > 1.5) => 
0.0425609131
, 

0.0477526242
)
, 

0.0016950404
)
, 

   (v1_propcurrownedassessedttl > 32252) => 
-0.0164520380
, 

-0.0010752564
)
, 

(v1_prospectdeceased > 0.5) => 
0.0406208282
, 

-0.0010363878
)
;


// Tree: 497

b1_tree_497 := 
map(

( NULL < v1_hhcrtreclienjudgmmbrcnt and v1_hhcrtreclienjudgmmbrcnt <= 4.5) => 
map(

   ( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 5.645) => 
map(

      ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 29274.5) => 
map(

         ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
0.0008586099
, 

         (v1_hhseniormmbrcnt > 0.5) => 
map(

            ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 3.5) => 
map(

               ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
-0.1002520885
, 

               (v1_raammbrcnt > 0.5) => 
-0.0514904516
, 

-0.0542057168
)
, 

            (v1_prospecttimeonrecord > 3.5) => 
-0.0075185322
, 

-0.0103763900
)
, 

-0.0001193108
)
, 

      (v1_hhcrtreclienjudgamtttl > 29274.5) => 
0.0291794423
, 

0.0004299128
)
, 

   (v1_resinputavmratiodiff60mo > 5.645) => 
0.0706370158
, 

0.0004883437
)
, 

(v1_hhcrtreclienjudgmmbrcnt > 4.5) => 
0.1114802172
, 

0.0006168916
)
;


// Tree: 501

b1_tree_501 := 
map(

( NULL < v1_prospectcollegeprivate and v1_prospectcollegeprivate <= 0.5) => 
map(

   ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 3.355) => 
map(

      ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
0.0012704679
, 

      (v1_hhmiddleagemmbrcnt > 0.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 0) => 
-0.0423741208
, 

         (v1_prospecttimeonrecord > 0) => 
map(

            ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0245406245
, 

            (v1_lifeeveverresidedcnt > 0.5) => 
map(

               ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
-0.0354318795
, 

               (v1_raammbrcnt > 0.5) => 
-0.0025541613
, 

-0.0037207267
)
, 

-0.0032072160
)
, 

-0.0050744956
)
, 

-0.0005425085
)
, 

   (v1_resinputavmblockratio > 3.355) => 
0.0242463205
, 

-0.0003923734
)
, 

(v1_prospectcollegeprivate > 0.5) => 
-0.0523968959
, 

-0.0007680255
)
;


// Tree: 505

b1_tree_505 := 
map(

( NULL < v1_raainterestsportpersonmmbrcnt and v1_raainterestsportpersonmmbrcnt <= 0.5) => 
-0.0010507797
, 

(v1_raainterestsportpersonmmbrcnt > 0.5) => 
map(

   (v1_resinputdwelltype in ['H','R','S','U']) => 
0.0062630644
, 

   (v1_resinputdwelltype in ['-1','0','F','G','P']) => 
map(

      ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 0.5) => 
map(

         ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
map(

            ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 77) => 
0.0046292901
, 

            (v1_crtrecmsdmeantimenewest > 77) => 
0.3629657816
, 

0.0648298207
)
, 

         (v1_verifiedcurrresmatchindex > 0.5) => 
map(

            ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 115) => 
0.2256063935
, 

            (v1_crtrectimenewest > 115) => 
0.5405996682
, 

0.2618125170
)
, 

0.1456670593
)
, 

      (v1_raapropcurrownermmbrcnt > 0.5) => 
0.0429753452
, 

0.0598126564
)
, 

0.0087753874
)
, 

0.0000420564
)
;


// Tree: 509

b1_tree_509 := 
map(

( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 6.5) => 
map(

   ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 42.5) => 
map(

         ( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 0.5) => 
0.0007336560
, 

         (v1_hhelderlymmbrcnt > 0.5) => 
-0.0332591372
, 

-0.0000064244
)
, 

      (v1_prospecttimelastupdate > 42.5) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
0.0278057859
, 

         (v1_hhcnt > 1.5) => 
0.0046630562
, 

0.0103672421
)
, 

0.0014971179
)
, 

   (v1_raayoungadultmmbrcnt > 0.5) => 
-0.0035921805
, 

-0.0006300588
)
, 

(v1_crtrecmsdmeancnt > 6.5) => 
map(

   ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 2.5) => 
0.0277465353
, 

   (v1_raayoungadultmmbrcnt > 2.5) => 
-0.0162627610
, 

0.0152696368
)
, 

-0.0002274398
)
;


// Tree: 513

b1_tree_513 := 
map(

(v1_resinputdwelltype in ['-1','G','H','R','S']) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 23.5) => 
map(

      ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 30.5) => 
map(

            ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 1.5) => 
-0.0018415702
, 

            (v1_raacrtrecmsdmeanmmbrcnt > 1.5) => 
0.0063756551
, 

0.0003195733
)
, 

         (v1_crtrectimenewest > 30.5) => 
-0.0142636186
, 

-0.0010361499
)
, 

      (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0252135474
, 

-0.0037419716
)
, 

   (v1_prospecttimelastupdate > 23.5) => 
0.0045861749
, 

-0.0016382992
)
, 

(v1_resinputdwelltype in ['0','F','P','U']) => 
map(

   ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 15.5) => 
0.0069946106
, 

   (v1_crtrecmsdmeancnt > 15.5) => 
0.1037730788
, 

0.0080983909
)
, 

-0.0011766586
)
;


// Tree: 517

b1_tree_517 := 
map(

( NULL < v1_occbusinessassociation and v1_occbusinessassociation <= 0.5) => 
map(

   ( NULL < v1_hhcrtrecfelonymmbrcnt and v1_hhcrtrecfelonymmbrcnt <= 0.5) => 
-0.0003824962
, 

   (v1_hhcrtrecfelonymmbrcnt > 0.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 19.5) => 
0.0016836734
, 

      (v1_prospecttimelastupdate > 19.5) => 
map(

         ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 0.5) => 
map(

            ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 142.5) => 
0.0653234086
, 

            (v1_crtrectimenewest > 142.5) => 
-0.0362409048
, 

0.0531210114
)
, 

         (v1_raayoungadultmmbrcnt > 0.5) => 
0.0230991580
, 

0.0322094079
)
, 

0.0148605613
)
, 

0.0001814264
)
, 

(v1_occbusinessassociation > 0.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 2.5) => 
-0.0349985170
, 

   (v1_prospecttimeonrecord > 2.5) => 
-0.0151733439
, 

-0.0183871303
)
, 

-0.0012700149
)
;


// Tree: 521

b1_tree_521 := 
map(

( NULL < v1_crtrecfelonycnt and v1_crtrecfelonycnt <= 0.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 1.5) => 
map(

      ( NULL < v1_hhcnt and v1_hhcnt <= 7.5) => 
map(

         ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
0.0002345767
, 

         (v1_hhseniormmbrcnt > 0.5) => 
map(

            ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 0) => 
-0.0499140716
, 

            (v1_prospecttimeonrecord > 0) => 
map(

               ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0408410275
, 

               (v1_lifeeveverresidedcnt > 0.5) => 
-0.0175009186
, 

-0.0164152141
)
, 

-0.0188088277
)
, 

-0.0012497368
)
, 

      (v1_hhcnt > 7.5) => 
0.0258261469
, 

-0.0005230694
)
, 

   (v1_crtrecbkrpttimenewest > 1.5) => 
-0.0301221979
, 

-0.0024615844
)
, 

(v1_crtrecfelonycnt > 0.5) => 
0.0153329546
, 

-0.0020205339
)
;


// Tree: 525

b1_tree_525 := 
map(

( NULL < v1_crtrecmsdmeancnt12mo and v1_crtrecmsdmeancnt12mo <= 1.5) => 
0.0002580122
, 

(v1_crtrecmsdmeancnt12mo > 1.5) => 
map(

   ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 2.5) => 
map(

      ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 19) => 
map(

         ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 247667) => 
map(

            ( NULL < v1_crtreclienjudgcnt and v1_crtreclienjudgcnt <= 0.5) => 
map(

               ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 11.5) => 
0.0746351646
, 

               (v1_crtrecfelonytimenewest > 11.5) => 
0.2138173145
, 

0.0785742820
)
, 

            (v1_crtreclienjudgcnt > 0.5) => 
-0.0167973295
, 

0.0645659769
)
, 

         (v1_resinputavmvalue > 247667) => 
-0.1123901378
, 

0.0548098413
)
, 

      (v1_crtrecfelonytimenewest > 19) => 
-0.0947805412
, 

0.0418245651
)
, 

   (v1_raacrtrecmsdmeanmmbrcnt > 2.5) => 
0.0030495161
, 

0.0150896391
)
, 

0.0003690381
)
;


// Tree: 529

b1_tree_529 := 
map(

(v1_resinputdwelltype in ['-1','G','H','R']) => 
map(

   ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.105) => 
map(

      ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
map(

         ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 0.5) => 
map(

            ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 1.865) => 
0.0006902858
, 

            (v1_resinputavmblockratio > 1.865) => 
0.0753159761
, 

0.0010969001
)
, 

         (v1_raamiddleagemmbrcnt > 0.5) => 
-0.0110874112
, 

-0.0051261361
)
, 

      (v1_verifiedcurrresmatchindex > 0.5) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
0.0376577690
, 

         (v1_hhcnt > 1.5) => 
0.0022248282
, 

0.0171250456
)
, 

-0.0024842668
)
, 

   (v1_resinputavmratiodiff12mo > 1.105) => 
-0.0262488160
, 

-0.0039324328
)
, 

(v1_resinputdwelltype in ['0','F','P','S','U']) => 
0.0017582013
, 

0.0005195094
)
;


// Tree: 533

b1_tree_533 := 
map(

(v1_resinputdwelltype in ['-1','G']) => 
-0.0515055086
, 

(v1_resinputdwelltype in ['0','F','H','P','R','S','U']) => 
map(

   ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 4.915) => 
map(

      ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 4.56) => 
-0.0004887952
, 

      (v1_resinputavmratiodiff12mo > 4.56) => 
map(

         ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 1.405) => 
-0.0686042426
, 

         (v1_resinputavmtractratio > 1.405) => 
0.1775386673
, 

0.0919237421
)
, 

-0.0004716139
)
, 

   (v1_resinputavmratiodiff12mo > 4.915) => 
map(

      ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 3.155) => 
map(

         ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 126640) => 
0.0317263107
, 

         (v1_resinputavmvalue60mo > 126640) => 
-0.1164867492
, 

-0.0026055280
)
, 

      (v1_resinputavmblockratio > 3.155) => 
-0.1122809011
, 

-0.0434421031
)
, 

-0.0005205347
)
, 

-0.0005419324
)
;


// Tree: 537

b1_tree_537 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 18.5) => 
-0.0016560237
, 

(v1_prospecttimelastupdate > 18.5) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

      ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
-0.0273435551
, 

      (v1_resinputownershipindex > 0.5) => 
0.0035136598
, 

-0.0089749997
)
, 

   (v1_raammbrcnt > 0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 3.5) => 
map(

         ( NULL < v1_lifeevecontrajectory and v1_lifeevecontrajectory <= 0.5) => 
map(

            ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 130.5) => 
0.1231844126
, 

            (v1_prospecttimeonrecord > 130.5) => 
0.0036403838
, 

0.0819083558
)
, 

         (v1_lifeevecontrajectory > 0.5) => 
0.0189784880
, 

0.0279755555
)
, 

      (v1_raammbrcnt > 3.5) => 
0.0011657476
, 

0.0054881791
)
, 

0.0042925040
)
, 

-0.0000087546
)
;


// Tree: 541

b1_tree_541 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 2.5) => 
map(

   ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.005) => 
map(

      ( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 0.5) => 
0.0031024317
, 

      (v1_hhelderlymmbrcnt > 0.5) => 
map(

         ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
-0.0708833143
, 

         (v1_hhpropcurrownermmbrcnt > 0.5) => 
0.0101714211
, 

-0.0171565694
)
, 

0.0025482885
)
, 

   (v1_resinputavmcntyratio > 1.005) => 
map(

      ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 6.5) => 
map(

         ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 3.545) => 
-0.0118692984
, 

         (v1_resinputavmtractratio > 3.545) => 
0.0479658352
, 

-0.0103822441
)
, 

      (v1_resinputbusinesscnt > 6.5) => 
0.0358791574
, 

-0.0082526832
)
, 

0.0011027716
)
, 

(v1_raammbrcnt > 2.5) => 
-0.0022068976
, 

-0.0011251020
)
;


// Tree: 545

b1_tree_545 := 
map(

( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 2.5) => 
-0.0012329801
, 

(v1_raacrtrecevictionmmbrcnt > 2.5) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 17.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 13.5) => 
map(

         ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
map(

            ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 6.5) => 
0.0242756244
, 

            (v1_raacrtrecmsdmeanmmbrcnt > 6.5) => 
map(

               ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 0.5) => 
0.1269965835
, 

               (v1_resinputbusinesscnt > 0.5) => 
-0.0256318023
, 

0.0898707599
)
, 

0.0291985859
)
, 

         (v1_hhcrtrecmmbrcnt > 0.5) => 
0.0116983374
, 

0.0173968992
)
, 

      (v1_raammbrcnt > 13.5) => 
0.0024765119
, 

0.0073014652
)
, 

   (v1_hhcnt > 17.5) => 
0.3693492769
, 

0.0079344699
)
, 

-0.0003654529
)
;


// Tree: 549

b1_tree_549 := 
map(

(v1_resinputdwelltype in ['-1','F','G','H','P','R','S','U']) => 
map(

   (v1_resinputdwelltype in ['G','H','R']) => 
map(

      ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 0.5) => 
0.0014515910
, 

      (v1_raamiddleagemmbrcnt > 0.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 13.5) => 
map(

            ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 0.5) => 
-0.0267310428
, 

            (v1_raacrtrecevictionmmbrcnt > 0.5) => 
-0.0056224646
, 

-0.0163515290
)
, 

         (v1_prospecttimeonrecord > 13.5) => 
0.0031794862
, 

-0.0069984354
)
, 

-0.0030336150
)
, 

   (v1_resinputdwelltype in ['-1','0','F','P','S','U']) => 
0.0009929686
, 

0.0001236175
)
, 

(v1_resinputdwelltype in ['0']) => 
map(

   ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 44240) => 
0.0275445349
, 

   (v1_propcurrownedavmttl > 44240) => 
0.5047512464
, 

0.1184410513
)
, 

0.0001536978
)
;


// Tree: 553

b1_tree_553 := 
map(

( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 1.945) => 
-0.0009401874
, 

(v1_resinputavmblockratio > 1.945) => 
map(

   ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 276413.5) => 
0.0037503710
, 

   (v1_resinputavmvalue12mo > 276413.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 45.5) => 
map(

         ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 3.37) => 
map(

            ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 307532.5) => 
map(

               ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 2.405) => 
0.2148597227
, 

               (v1_resinputavmtractratio > 2.405) => 
-0.0144263395
, 

0.1288774494
)
, 

            (v1_resinputavmvalue > 307532.5) => 
0.0304176388
, 

0.0349032794
)
, 

         (v1_rescurravmcntyratio > 3.37) => 
0.3793409251
, 

0.0414456704
)
, 

      (v1_prospecttimeonrecord > 45.5) => 
0.0167277316
, 

0.0289164673
)
, 

0.0113529783
)
, 

-0.0006421400
)
;


// Tree: 557

b1_tree_557 := 
map(

( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
map(

      ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 0.5) => 
map(

         ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 1.5) => 
-0.0059049599
, 

         (v1_raacrtrecmsdmeanmmbrcnt > 1.5) => 
0.0062032664
, 

-0.0034957095
)
, 

      (v1_rescurrownershipindex > 0.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
0.0038248303
, 

         (v1_raammbrcnt > 0.5) => 
-0.0044999223
, 

-0.0018709731
)
, 

-0.0024899750
)
, 

   (v1_prospectcollegeattending > 0.5) => 
0.0257976574
, 

-0.0019265992
)
, 

(v1_raacrtrecevictionmmbrcnt > 0.5) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 6.5) => 
0.0107187438
, 

   (v1_raammbrcnt > 6.5) => 
0.0012655927
, 

0.0031855565
)
, 

-0.0003549564
)
;


// Tree: 561

b1_tree_561 := 
map(

( NULL < v1_raainterestsportpersonmmbrcnt and v1_raainterestsportpersonmmbrcnt <= 0.5) => 
-0.0009106433
, 

(v1_raainterestsportpersonmmbrcnt > 0.5) => 
map(

   ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 31.5) => 
map(

      (v1_resinputdwelltype in ['0','H','R','U']) => 
-0.0135444919
, 

      (v1_resinputdwelltype in ['-1','F','G','P','S']) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 15.5) => 
map(

            ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

               ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.015) => 
0.0207513763
, 

               (v1_resinputavmcntyratio > 1.015) => 
0.0465794785
, 

0.0257521155
)
, 

            (v1_lifeevtimefirstassetpurchase > -0.5) => 
-0.0132004274
, 

0.0195700670
)
, 

         (v1_raammbrcnt > 15.5) => 
0.0014025009
, 

0.0135775110
)
, 

0.0085745156
)
, 

   (v1_lifeevtimelastmove > 31.5) => 
-0.0023217845
, 

0.0021980828
)
, 

-0.0005665061
)
;


// Tree: 565

b1_tree_565 := 
map(

( NULL < v1_prospectcollegetier and v1_prospectcollegetier <= 5.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 1.5) => 
0.0013689862
, 

   (v1_hhmiddleagemmbrcnt > 1.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

         ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 1.5) => 
0.0056220620
, 

         (v1_verifiedcurrresmatchindex > 1.5) => 
map(

            ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 499935) => 
map(

               ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 307854) => 
0.0537968284
, 

               (v1_hhpropcurravmhighest > 307854) => 
0.2060068637
, 

0.0701634988
)
, 

            (v1_resinputavmvalue > 499935) => 
-0.0876933627
, 

0.0586257880
)
, 

0.0215921536
)
, 

      (v1_lifeeveverresidedcnt > 0.5) => 
-0.0251332082
, 

-0.0233719496
)
, 

-0.0012952089
)
, 

(v1_prospectcollegetier > 5.5) => 
-0.0438768014
, 

-0.0015847522
)
;


// Tree: 569

b1_tree_569 := 
map(

( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 5.825) => 
map(

   ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 1.5) => 
map(

      ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhoccproflicmmbrcnt and v1_hhoccproflicmmbrcnt <= 0.5) => 
0.0019119985
, 

         (v1_hhoccproflicmmbrcnt > 0.5) => 
-0.0333649365
, 

0.0003827182
)
, 

      (v1_raayoungadultmmbrcnt > 0.5) => 
-0.0039668032
, 

-0.0013392658
)
, 

   (v1_raacrtrecfelonymmbrcnt > 1.5) => 
0.0132196502
, 

-0.0003646140
)
, 

(v1_resinputavmblockratio > 5.825) => 
map(

   ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 2.15) => 
0.2576904890
, 

   (v1_resinputavmtractratio > 2.15) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 1.5) => 
0.0645288081
, 

      (v1_raammbrcnt > 1.5) => 
-0.0033200581
, 

0.0199201282
)
, 

0.0293679571
)
, 

-0.0003102611
)
;


// Tree: 573

b1_tree_573 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
0.0002228471
, 

(v1_prospectdeceased > 0.5) => 
map(

   ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 1.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 6.5) => 
-0.1536347972
, 

      (v1_prospecttimelastupdate > 6.5) => 
map(

         ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
0.0487985429
, 

         (v1_lifeeveverresidedcnt > 1.5) => 
map(

            ( NULL < v1_raacollegeattendedmmbrcnt and v1_raacollegeattendedmmbrcnt <= 1.5) => 
0.1291199323
, 

            (v1_raacollegeattendedmmbrcnt > 1.5) => 
0.2931556192
, 

0.1863416836
)
, 

0.0879664571
)
, 

0.0688151382
)
, 

   (v1_resinputbusinesscnt > 1.5) => 
map(

      ( NULL < v1_raacollegemidtiermmbrcnt and v1_raacollegemidtiermmbrcnt <= 0.5) => 
-0.1102688971
, 

      (v1_raacollegemidtiermmbrcnt > 0.5) => 
0.1188898333
, 

-0.0529792145
)
, 

0.0449338926
)
, 

0.0002596546
)
;


// Tree: 577

b1_tree_577 := 
map(

( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 2.035) => 
-0.0007395930
, 

(v1_resinputavmcntyratio > 2.035) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
map(

      ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 277592.5) => 
-0.0012410828
, 

      (v1_resinputavmvalue12mo > 277592.5) => 
map(

         ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 868256.5) => 
map(

            ( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 775500) => 
0.0345647603
, 

            (v1_rescurravmvalue12mo > 775500) => 
map(

               ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 823603.5) => 
1.0558927891
, 

               (v1_resinputavmvalue > 823603.5) => 
0.1397060645
, 

0.5380481186
)
, 

0.0394488250
)
, 

         (v1_resinputavmvalue > 868256.5) => 
-0.0014302162
, 

0.0286424511
)
, 

0.0170418765
)
, 

   (v1_lifeeveverresidedcnt > 1.5) => 
-0.0158892112
, 

0.0039666855
)
, 

-0.0005736604
)
;


// Tree: 581

b1_tree_581 := 
map(

( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 1.5) => 
map(

   ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.545) => 
-0.0015132151
, 

   (v1_resinputavmratiodiff12mo > 1.545) => 
map(

      ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 2.405) => 
0.0133792162
, 

      (v1_resinputavmtractratio > 2.405) => 
map(

         ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 0.5) => 
-0.0504895613
, 

         (v1_rescurravmcntyratio > 0.5) => 
0.1149330041
, 

-0.0025711859
)
, 

0.0122781365
)
, 

-0.0011295958
)
, 

(v1_raacrtrecevictionmmbrcnt > 1.5) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 4.5) => 
map(

      ( NULL < v1_raahhcnt and v1_raahhcnt <= 1.5) => 
0.0815629310
, 

      (v1_raahhcnt > 1.5) => 
0.0184180508
, 

0.0242661278
)
, 

   (v1_raammbrcnt > 4.5) => 
0.0058567397
, 

0.0066459953
)
, 

0.0001585334
)
;


// Tree: 585

b1_tree_585 := 
map(

( NULL < v1_hhcrtrecevictionmmbrcnt12mo and v1_hhcrtrecevictionmmbrcnt12mo <= 0.5) => 
0.0005373616
, 

(v1_hhcrtrecevictionmmbrcnt12mo > 0.5) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

      ( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.735) => 
map(

         ( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 1.105) => 
map(

            ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 2.5) => 
-0.1009220193
, 

            (v1_prospecttimelastupdate > 2.5) => 
map(

               ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 3907.5) => 
-0.0115567694
, 

               (v1_hhcrtreclienjudgamtttl > 3907.5) => 
-0.1100718031
, 

-0.0252394130
)
, 

-0.0410412759
)
, 

         (v1_rescurravmblockratio > 1.105) => 
0.0922621189
, 

-0.0336611571
)
, 

      (v1_rescurravmratiodiff12mo > 1.735) => 
-0.2073336222
, 

-0.0400291475
)
, 

   (v1_raammbrcnt > 0.5) => 
-0.0201530218
, 

-0.0224437778
)
, 

0.0002959615
)
;


// Tree: 589

b1_tree_589 := 
map(

( NULL < v1_crtrecfelonycnt and v1_crtrecfelonycnt <= 17.5) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 21.5) => 
map(

      ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 1.635) => 
-0.0000053108
, 

      (v1_resinputavmblockratio > 1.635) => 
0.0098694025
, 

0.0004041087
)
, 

   (v1_raammbrcnt > 21.5) => 
map(

      ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 3.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 0) => 
-0.0220984094
, 

         (v1_prospecttimeonrecord > 0) => 
-0.0064982590
, 

-0.0116376299
)
, 

      (v1_crtrecbkrptcnt > 3.5) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 18.5) => 
0.0476945121
, 

         (v1_prospecttimelastupdate > 18.5) => 
1.0724768443
, 

0.4689939153
)
, 

-0.0094339089
)
, 

-0.0003752130
)
, 

(v1_crtrecfelonycnt > 17.5) => 
0.2381358798
, 

-0.0003646255
)
;


// Tree: 593

b1_tree_593 := 
map(

( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

   ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 41171) => 
-0.0019318146
, 

   (v1_resinputavmvalue > 41171) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

         ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 0.935) => 
map(

            ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 63797.5) => 
-0.0569373157
, 

            (v1_resinputavmvalue12mo > 63797.5) => 
map(

               ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 135641.5) => 
-0.0477218239
, 

               (v1_resinputavmvalue60mo > 135641.5) => 
0.0750374470
, 

0.0396661316
)
, 

0.0068642148
)
, 

         (v1_resinputavmratiodiff12mo > 0.935) => 
-0.0352233365
, 

-0.0276583038
)
, 

      (v1_raammbrcnt > 0.5) => 
-0.0120258691
, 

-0.0148462902
)
, 

-0.0029154572
)
, 

(v1_resinputownershipindex > 0.5) => 
0.0007524190
, 

-0.0008535461
)
;


// Tree: 597

b1_tree_597 := 
map(

( NULL < v1_hhcrtreclienjudgmmbrcnt and v1_hhcrtreclienjudgmmbrcnt <= 2.5) => 
-0.0007245690
, 

(v1_hhcrtreclienjudgmmbrcnt > 2.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 6.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 7.5) => 
0.3290861758
, 

      (v1_lifeevtimelastmove > 7.5) => 
map(

         ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 0.5) => 
-0.1369130797
, 

         (v1_raacrtrecmsdmeanmmbrcnt > 0.5) => 
0.3852107525
, 

0.1894143154
)
, 

0.2275066410
)
, 

   (v1_prospecttimeonrecord > 6.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

         ( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 0.43) => 
0.0171679203
, 

         (v1_resinputavmratiodiff60mo > 0.43) => 
0.2033019968
, 

0.0769967306
)
, 

      (v1_lifeeveverresidedcnt > 0.5) => 
0.0239533432
, 

0.0249253425
)
, 

0.0278006899
)
, 

-0.0003677212
)
;


// Tree: 601

b1_tree_601 := 
map(

( NULL < v1_crtrecfelonycnt12mo and v1_crtrecfelonycnt12mo <= 2.5) => 
map(

   ( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 1.5) => 
map(

      ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
0.0008753925
, 

      (v1_prospectcollegeattending > 0.5) => 
map(

         ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 0.835) => 
0.0099495974
, 

         (v1_resinputavmcntyratio > 0.835) => 
map(

            ( NULL < v1_interestsportperson and v1_interestsportperson <= 0.5) => 
0.0794681725
, 

            (v1_interestsportperson > 0.5) => 
0.4162320349
, 

0.0937985496
)
, 

0.0327513375
)
, 

0.0010141977
)
, 

   (v1_prospectcollegeprogramtype > 1.5) => 
-0.0193985013
, 

0.0002221763
)
, 

(v1_crtrecfelonycnt12mo > 2.5) => 
map(

   ( NULL < v1_raacrtrecmsdmeanmmbrcnt12mo and v1_raacrtrecmsdmeanmmbrcnt12mo <= 0.5) => 
0.2235619657
, 

   (v1_raacrtrecmsdmeanmmbrcnt12mo > 0.5) => 
-0.0085800641
, 

0.0956469697
)
, 

0.0002410453
)
;


// Tree: 605

b1_tree_605 := 
map(

( NULL < v1_raacrtrecfelonymmbrcnt12mo and v1_raacrtrecfelonymmbrcnt12mo <= 0.5) => 
map(

   ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

      ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 89223) => 
-0.0008588643
, 

      (v1_resinputavmvalue60mo > 89223) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

            ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 2.61) => 
map(

               ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 7.5) => 
-0.0273171737
, 

               (v1_resinputbusinesscnt > 7.5) => 
0.0663367138
, 

-0.0238278337
)
, 

            (v1_resinputavmratiodiff12mo > 2.61) => 
-0.2523299596
, 

-0.0265200531
)
, 

         (v1_raammbrcnt > 0.5) => 
-0.0130201636
, 

-0.0156705684
)
, 

-0.0018176103
)
, 

   (v1_resinputownershipindex > 0.5) => 
0.0014641563
, 

0.0000299704
)
, 

(v1_raacrtrecfelonymmbrcnt12mo > 0.5) => 
0.0246024974
, 

0.0003552190
)
;


// Tree: 609

b1_tree_609 := 
map(

( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 86.5) => 
map(

   ( NULL < v1_crtrecmsdmeancnt12mo and v1_crtrecmsdmeancnt12mo <= 1.5) => 
0.0005000755
, 

   (v1_crtrecmsdmeancnt12mo > 1.5) => 
map(

      ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 92889.5) => 
map(

         ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.775) => 
map(

            ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 13.5) => 
0.0258738701
, 

            (v1_resinputbusinesscnt > 13.5) => 
0.2098012127
, 

0.0292247731
)
, 

         (v1_resinputavmratiodiff12mo > 1.775) => 
map(

            ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 3.5) => 
0.0052803361
, 

            (v1_crtrectimenewest > 3.5) => 
0.3209528570
, 

0.1794444856
)
, 

0.0321078781
)
, 

      (v1_resinputavmvalue > 92889.5) => 
-0.0229520861
, 

0.0211601122
)
, 

0.0006573224
)
, 

(v1_crtrecmsdmeancnt > 86.5) => 
0.4430970020
, 

0.0006751768
)
;


// Tree: 613

b1_tree_613 := 
map(

( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 459974.5) => 
0.0005267711
, 

(v1_resinputavmvalue60mo > 459974.5) => 
map(

   ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 385463.5) => 
map(

      ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 1584428.5) => 
map(

         ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

            ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 0.155) => 
-0.1738653396
, 

            (v1_resinputavmcntyratio > 0.155) => 
map(

               ( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 1.015) => 
-0.0133095493
, 

               (v1_resinputavmratiodiff60mo > 1.015) => 
-0.0350706779
, 

-0.0195517854
)
, 

-0.0204077243
)
, 

         (v1_lifeeveverresidedcnt > 0.5) => 
-0.0207201064
, 

-0.0205502545
)
, 

      (v1_resinputavmvalue > 1584428.5) => 
0.0477167416
, 

-0.0184685959
)
, 

   (v1_raapropowneravmhighest > 385463.5) => 
0.0006830256
, 

-0.0080885416
)
, 

0.0001633206
)
;


// Tree: 617

b1_tree_617 := 
map(

( NULL < v1_crtrecfelonycnt12mo and v1_crtrecfelonycnt12mo <= 4.5) => 
map(

   (v1_resinputdwelltype in ['-1','G']) => 
-0.0501676335
, 

   (v1_resinputdwelltype in ['0','F','H','P','R','S','U']) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 159.5) => 
-0.0001685605
, 

      (v1_prospecttimelastupdate > 159.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
-0.0278236228
, 

         (v1_raammbrcnt > 0.5) => 
map(

            ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
0.0576372307
, 

            (v1_hhcnt > 1.5) => 
map(

               ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 669115) => 
0.0084487767
, 

               (v1_raapropowneravmmed > 669115) => 
0.3334933353
, 

0.0155966412
)
, 

0.0255550511
)
, 

0.0206815729
)
, 

0.0002620117
)
, 

0.0002416599
)
, 

(v1_crtrecfelonycnt12mo > 4.5) => 
0.2045388017
, 

0.0002532019
)
;


// Tree: 621

b1_tree_621 := 
map(

( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 8819641.5) => 
map(

   ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
-0.0001912357
, 

   (v1_prospectcollegeattending > 0.5) => 
map(

      ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 2.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
-0.0578008657
, 

         (v1_raammbrcnt > 0.5) => 
map(

            ( NULL < v1_hhcollegetiermmbrhighest and v1_hhcollegetiermmbrhighest <= 2.5) => 
-0.0112828340
, 

            (v1_hhcollegetiermmbrhighest > 2.5) => 
map(

               ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 0.5) => 
0.0733160999
, 

               (v1_raayoungadultmmbrcnt > 0.5) => 
0.0259628011
, 

0.0560736294
)
, 

0.0402322733
)
, 

0.0355113716
)
, 

      (v1_raacrtrecmmbrcnt > 2.5) => 
-0.0053048444
, 

0.0125169737
)
, 

0.0000795009
)
, 

(v1_raapropowneravmhighest > 8819641.5) => 
0.9168216911
, 

0.0001201950
)
;


// Tree: 625

b1_tree_625 := 
map(

( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 15477) => 
map(

   ( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 0.5) => 
0.0005528447
, 

   (v1_raaoccbusinessassocmmbrcnt > 0.5) => 
map(

      ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 0.5) => 
map(

         ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

            ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 1.5) => 
map(

               ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 716) => 
-0.0400303735
, 

               (v1_raacrtreclienjudgamtmax > 716) => 
0.0156144731
, 

-0.0337615704
)
, 

            (v1_raacrtrecmmbrcnt > 1.5) => 
-0.0067135496
, 

-0.0155672293
)
, 

         (v1_lifeeveverresidedcnt > 0.5) => 
0.0005584873
, 

-0.0084175515
)
, 

      (v1_raapropcurrownermmbrcnt > 0.5) => 
-0.0033197533
, 

-0.0037790603
)
, 

-0.0011130189
)
, 

(v1_hhcrtreclienjudgamtttl > 15477) => 
0.0181987623
, 

-0.0004293243
)
;


// Tree: 629

b1_tree_629 := 
map(

( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 1860913) => 
map(

   ( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 0.5) => 
0.0010720767
, 

   (v1_hhcollegeattendedmmbrcnt > 0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
-0.0550622339
, 

         (v1_hhcnt > 1.5) => 
map(

            ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 66.5) => 
-0.0016742747
, 

            (v1_crtrectimenewest > 66.5) => 
-0.0993319138
, 

-0.0104871064
)
, 

-0.0228992383
)
, 

      (v1_raammbrcnt > 0.5) => 
-0.0030715888
, 

-0.0037980552
)
, 

0.0000575085
)
, 

(v1_resinputavmvalue60mo > 1860913) => 
map(

   ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 111672) => 
0.0870784703
, 

   (v1_raapropowneravmhighest > 111672) => 
-0.0078664991
, 

0.0372323614
)
, 

0.0001055140
)
;


// Tree: 633

b1_tree_633 := 
map(

( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 1.135) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 4.5) => 
-0.0020587020
, 

   (v1_hhcnt > 4.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

         ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 21612) => 
map(

            ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 1.045) => 
map(

               ( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 228288) => 
0.0509476799
, 

               (v1_rescurrmortgageamount > 228288) => 
0.4733833665
, 

0.0591028090
)
, 

            (v1_resinputavmtractratio > 1.045) => 
-0.0567600133
, 

0.0470755264
)
, 

         (v1_hhcrtreclienjudgamtttl > 21612) => 
-0.0765247795
, 

0.0347540006
)
, 

      (v1_lifeeveverresidedcnt > 0.5) => 
0.0087535865
, 

0.0094909425
)
, 

-0.0008387636
)
, 

(v1_resinputavmblockratio > 1.135) => 
0.0040898904
, 

-0.0001728492
)
;


// Tree: 637

b1_tree_637 := 
map(

( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 15.5) => 
-0.0008377332
, 

(v1_crtrecmsdmeancnt > 15.5) => 
map(

   ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 3.5) => 
map(

      ( NULL < v1_raacrtrecmsdmeanmmbrcnt12mo and v1_raacrtrecmsdmeanmmbrcnt12mo <= 0.5) => 
map(

         (v1_resinputdwelltype in ['H','S']) => 
0.0017831311
, 

         (v1_resinputdwelltype in ['-1','0','F','G','P','R','U']) => 
0.1838920851
, 

0.0242909794
)
, 

      (v1_raacrtrecmsdmeanmmbrcnt12mo > 0.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 162) => 
0.2557314537
, 

         (v1_prospecttimeonrecord > 162) => 
-0.1088634229
, 

0.1894414761
)
, 

0.0632750022
)
, 

   (v1_raacrtrecmmbrcnt > 3.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 63.5) => 
0.0015446567
, 

      (v1_crtrectimenewest > 63.5) => 
0.1108991973
, 

0.0150937164
)
, 

0.0221232966
)
, 

-0.0006897584
)
;


// Tree: 641

b1_tree_641 := 
map(

( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
map(

   ( NULL < v1_crtrecfelonycnt and v1_crtrecfelonycnt <= 11.5) => 
-0.0014399223
, 

   (v1_crtrecfelonycnt > 11.5) => 
0.1677895913
, 

-0.0014169248
)
, 

(v1_raacrtrecfelonymmbrcnt > 0.5) => 
map(

   ( NULL < v1_crtreccnt and v1_crtreccnt <= 0.5) => 
map(

      ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 25.5) => 
map(

            ( NULL < v1_prospectcollegetier and v1_prospectcollegetier <= 2.5) => 
0.0166399003
, 

            (v1_prospectcollegetier > 2.5) => 
-0.0263621555
, 

0.0137702335
)
, 

         (v1_raammbrcnt > 25.5) => 
-0.0175994328
, 

0.0101364189
)
, 

      (v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0087661947
, 

0.0051999890
)
, 

   (v1_crtreccnt > 0.5) => 
-0.0013996376
, 

0.0012646754
)
, 

-0.0009649883
)
;


// Tree: 645

b1_tree_645 := 
map(

( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

   ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 304.5) => 
map(

      ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 0.115) => 
-0.0002866708
, 

      (v1_resinputavmratiodiff12mo > 0.115) => 
map(

         ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 34.5) => 
0.0047303157
, 

         (v1_crtrecmsdmeantimenewest > 34.5) => 
-0.0175074642
, 

0.0028225988
)
, 

0.0008915285
)
, 

   (v1_crtrecfelonytimenewest > 304.5) => 
-0.0962646221
, 

0.0008437490
)
, 

(v1_hhmiddleagemmbrcnt > 0.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 0) => 
map(

      ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
-0.0486027325
, 

      (v1_raacrtrecfelonymmbrcnt > 0.5) => 
0.0068657840
, 

-0.0341650562
)
, 

   (v1_prospecttimeonrecord > 0) => 
-0.0043089855
, 

-0.0057521805
)
, 

-0.0010433272
)
;


// Tree: 649

b1_tree_649 := 
map(

( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 1.5) => 
0.0003080700
, 

(v1_hhmiddleagemmbrcnt > 1.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

      ( NULL < v1_hhcrtreclienjudgmmbrcnt and v1_hhcrtreclienjudgmmbrcnt <= 1.5) => 
map(

         ( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 6.5) => 
0.0225442329
, 

         (v1_rescurrbusinesscnt > 6.5) => 
0.2016454143
, 

0.0246814785
)
, 

      (v1_hhcrtreclienjudgmmbrcnt > 1.5) => 
-0.0348806807
, 

0.0159991250
)
, 

   (v1_lifeeveverresidedcnt > 0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

         ( NULL < v1_rescurravmtractratio and v1_rescurravmtractratio <= 2.595) => 
-0.0535131706
, 

         (v1_rescurravmtractratio > 2.595) => 
0.2558270692
, 

-0.0495891929
)
, 

      (v1_raammbrcnt > 0.5) => 
-0.0199055612
, 

-0.0209940454
)
, 

-0.0196388679
)
, 

-0.0018475008
)
;


// Tree: 653

b1_tree_653 := 
map(

( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 149.5) => 
map(

   ( NULL < v1_donotmail and v1_donotmail <= 0.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 760) => 
0.0003955244
, 

      (v1_prospecttimeonrecord > 760) => 
map(

         ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
map(

            ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 1.5) => 
0.3578115563
, 

            (v1_hhpropcurrownermmbrcnt > 1.5) => 
0.1282687176
, 

0.2430401370
)
, 

         (v1_hhcrtrecmmbrcnt > 0.5) => 
-0.1318082530
, 

0.1059004821
)
, 

0.0004130506
)
, 

   (v1_donotmail > 0.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
-0.1072345823
, 

      (v1_lifeeveverresidedcnt > 0.5) => 
-0.0734815893
, 

-0.0801332377
)
, 

0.0002131718
)
, 

(v1_resinputbusinesscnt > 149.5) => 
-0.0423280031
, 

0.0001484512
)
;


// Tree: 657

b1_tree_657 := 
map(

( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
-0.0008975596
, 

(v1_raacrtrecfelonymmbrcnt > 0.5) => 
map(

   ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 120033) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 5.5) => 
map(

         ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 46406.5) => 
0.0225060640
, 

         (v1_resinputavmvalue > 46406.5) => 
map(

            ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 109142.5) => 
-0.0305693474
, 

            (v1_resinputavmvalue > 109142.5) => 
map(

               ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 1.5) => 
-0.0528982235
, 

               (v1_raacrtrecmsdmeanmmbrcnt > 1.5) => 
0.1453053834
, 

0.0518435200
)
, 

-0.0116220900
)
, 

0.0176539347
)
, 

      (v1_raammbrcnt > 5.5) => 
0.0068262094
, 

0.0080009508
)
, 

   (v1_resinputavmvalue60mo > 120033) => 
-0.0085682186
, 

0.0052304049
)
, 

0.0001323570
)
;


// Tree: 661

b1_tree_661 := 
map(

( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 0.5) => 
0.0008452653
, 

(v1_hhcollegeattendedmmbrcnt > 0.5) => 
map(

   (v1_resinputdwelltype in ['F','H','U']) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 14.5) => 
-0.0293371661
, 

      (v1_prospecttimeonrecord > 14.5) => 
-0.0050720675
, 

-0.0177038739
)
, 

   (v1_resinputdwelltype in ['-1','0','G','P','R','S']) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 2.5) => 
-0.0459853241
, 

         (v1_prospecttimeonrecord > 2.5) => 
map(

            ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0270910600
, 

            (v1_lifeeveverresidedcnt > 0.5) => 
-0.0266970877
, 

-0.0098908915
)
, 

-0.0190550867
)
, 

      (v1_raammbrcnt > 0.5) => 
-0.0004872368
, 

-0.0012214772
)
, 

-0.0037840574
)
, 

-0.0001241680
)
;


// Tree: 665

b1_tree_665 := 
map(

( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 0.5) => 
0.0012683253
, 

(v1_raaoccproflicmmbrcnt > 0.5) => 
map(

   (v1_resinputdwelltype in ['F','H','P','R','S','U']) => 
map(

      ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 2.065) => 
-0.0072656368
, 

      (v1_resinputavmcntyratio > 2.065) => 
map(

         ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 4.5) => 
map(

            ( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 1.385) => 
map(

               ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 186446) => 
-0.0204700463
, 

               (v1_raapropowneravmmed > 186446) => 
0.0455484519
, 

0.0281081910
)
, 

            (v1_resinputavmratiodiff60mo > 1.385) => 
0.1467393990
, 

0.0360169382
)
, 

         (v1_lifeevtimelastmove > 4.5) => 
0.0020336278
, 

0.0121642992
)
, 

-0.0062389345
)
, 

   (v1_resinputdwelltype in ['-1','0','G']) => 
0.1816921635
, 

-0.0061794329
)
, 

-0.0005352774
)
;


// Tree: 669

b1_tree_669 := 
map(

( NULL < v1_crtreccnt and v1_crtreccnt <= 67.5) => 
map(

   ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 182.5) => 
0.0015306314
, 

   (v1_lifeevtimelastmove > 182.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
map(

            ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
-0.0024292999
, 

            (v1_lifeeveverresidedcnt > 0.5) => 
-0.0707374477
, 

-0.0548052400
)
, 

         (v1_hhpropcurrownermmbrcnt > 0.5) => 
map(

            ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0442289752
, 

            (v1_lifeeveverresidedcnt > 0.5) => 
-0.0268326469
, 

-0.0162751396
)
, 

-0.0270221407
)
, 

      (v1_raammbrcnt > 0.5) => 
-0.0046420961
, 

-0.0061127111
)
, 

0.0003253922
)
, 

(v1_crtreccnt > 67.5) => 
0.1814723638
, 

0.0003714458
)
;


// Tree: 673

b1_tree_673 := 
map(

( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 112.5) => 
map(

   ( NULL < v1_hhcrtrecevictionmmbrcnt and v1_hhcrtrecevictionmmbrcnt <= 4.5) => 
map(

      ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 44270.5) => 
-0.0002032148
, 

      (v1_raacrtreclienjudgamtmax > 44270.5) => 
map(

         (v1_resinputdwelltype in ['0','F','H','P','S']) => 
map(

            ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 44376.5) => 
0.3568631995
, 

            (v1_raacrtreclienjudgamtmax > 44376.5) => 
0.0116989239
, 

0.0125036277
)
, 

         (v1_resinputdwelltype in ['-1','G','R','U']) => 
0.3664544394
, 

0.0133268967
)
, 

0.0005025775
)
, 

   (v1_hhcrtrecevictionmmbrcnt > 4.5) => 
0.2828355948
, 

0.0005185627
)
, 

(v1_resinputbusinesscnt > 112.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
-0.0492777132
, 

   (v1_lifeeveverresidedcnt > 0.5) => 
0.0231638965
, 

-0.0183475877
)
, 

0.0004779075
)
;


// Tree: 677

b1_tree_677 := 
map(

(v1_resinputdwelltype in ['0','G','R']) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 21.5) => 
map(

      (v1_resinputdwelltype in ['0','G']) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 167934) => 
-0.1882966898
, 

         (v1_raapropowneravmmed > 167934) => 
0.0456494827
, 

-0.1087549911
)
, 

      (v1_resinputdwelltype in ['-1','F','H','P','R','S','U']) => 
-0.0359047735
, 

-0.0410714556
)
, 

   (v1_prospecttimelastupdate > 21.5) => 
map(

      ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 9450) => 
0.0389872013
, 

      (v1_crtreclienjudgamtttl > 9450) => 
0.3795230643
, 

0.0607235330
)
, 

-0.0196409317
)
, 

(v1_resinputdwelltype in ['-1','F','H','P','S','U']) => 
map(

   ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 2.5) => 
-0.0004849663
, 

   (v1_crtrecmsdmeancnt > 2.5) => 
0.0095217846
, 

0.0002057889
)
, 

0.0001342682
)
;


// Tree: 681

b1_tree_681 := 
map(

( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 0) => 
map(

   ( NULL < v1_occbusinessassociation and v1_occbusinessassociation <= 0.5) => 
map(

      ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 7.465) => 
0.0011001290
, 

      (v1_resinputavmcntyratio > 7.465) => 
0.0521946667
, 

0.0011439749
)
, 

   (v1_occbusinessassociation > 0.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 13.5) => 
map(

         ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 6.5) => 
-0.0405428958
, 

         (v1_resinputbusinesscnt > 6.5) => 
map(

            ( NULL < v1_raahhcnt and v1_raahhcnt <= 0.5) => 
0.0557054594
, 

            (v1_raahhcnt > 0.5) => 
-0.0404343990
, 

0.0046853901
)
, 

-0.0366856805
)
, 

      (v1_prospecttimeonrecord > 13.5) => 
-0.0092860642
, 

-0.0145855314
)
, 

0.0000015359
)
, 

(v1_crtrecbkrpttimenewest > 0) => 
-0.0224319338
, 

-0.0015005227
)
;


// Tree: 685

b1_tree_685 := 
map(

( NULL < v1_hhcnt and v1_hhcnt <= 8.5) => 
map(

   ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
-0.0006839416
, 

   (v1_prospectcollegeattending > 0.5) => 
map(

      ( NULL < v1_hhteenagermmbrcnt and v1_hhteenagermmbrcnt <= 0.5) => 
map(

         ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 0.5) => 
map(

            ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 148699.5) => 
0.0116069374
, 

            (v1_raapropowneravmmed > 148699.5) => 
map(

               ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 225658.5) => 
0.1250777467
, 

               (v1_raapropowneravmhighest > 225658.5) => 
0.0458193750
, 

0.0612374169
)
, 

0.0323810185
)
, 

         (v1_rescurrownershipindex > 0.5) => 
-0.0037935816
, 

0.0130474267
)
, 

      (v1_hhteenagermmbrcnt > 0.5) => 
0.1875450187
, 

0.0136653604
)
, 

-0.0003839354
)
, 

(v1_hhcnt > 8.5) => 
0.0307027150
, 

0.0002036656
)
;


// Tree: 689

b1_tree_689 := 
map(

( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.465) => 
-0.0000824789
, 

(v1_resinputavmratiodiff12mo > 1.465) => 
map(

   ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 1.5) => 
map(

      ( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 0.575) => 
map(

         ( NULL < v1_raacrtrecbkrptmmbrcnt36mo and v1_raacrtrecbkrptmmbrcnt36mo <= 0.5) => 
-0.0135153099
, 

         (v1_raacrtrecbkrptmmbrcnt36mo > 0.5) => 
0.1354504601
, 

-0.0073610038
)
, 

      (v1_resinputavmratiodiff60mo > 0.575) => 
map(

         ( NULL < v1_crtrecevictioncnt12mo and v1_crtrecevictioncnt12mo <= 0.5) => 
map(

            ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 1.775) => 
0.0263722304
, 

            (v1_resinputavmtractratio > 1.775) => 
-0.0102103043
, 

0.0216373899
)
, 

         (v1_crtrecevictioncnt12mo > 0.5) => 
-0.1786058768
, 

0.0207616905
)
, 

0.0146922293
)
, 

   (v1_raamiddleagemmbrcnt > 1.5) => 
0.0003630064
, 

0.0070080468
)
, 

0.0001874031
)
;


// Tree: 693

b1_tree_693 := 
map(

( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
-0.0009684840
, 

(v1_raacrtrecfelonymmbrcnt > 0.5) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 5.5) => 
map(

      ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 4.115) => 
map(

         ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 120014.5) => 
map(

            ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 5.5) => 
0.0250646032
, 

            (v1_crtrectimenewest > 5.5) => 
map(

               ( NULL < v1_crtrecmsdmeancnt12mo and v1_crtrecmsdmeancnt12mo <= 0.5) => 
0.0139719394
, 

               (v1_crtrecmsdmeancnt12mo > 0.5) => 
-0.0574352875
, 

0.0092961960
)
, 

0.0184940854
)
, 

         (v1_resinputavmvalue60mo > 120014.5) => 
-0.0201508644
, 

0.0127802159
)
, 

      (v1_resinputavmtractratio > 4.115) => 
-0.1453216306
, 

0.0117872029
)
, 

   (v1_raammbrcnt > 5.5) => 
0.0020618968
, 

0.0031019692
)
, 

-0.0002837621
)
;


// Tree: 697

b1_tree_697 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
-0.0001145712
, 

(v1_prospectdeceased > 0.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

      ( NULL < v1_raacollegelowtiermmbrcnt and v1_raacollegelowtiermmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
map(

            ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 217) => 
-0.1051337132
, 

            (v1_prospecttimelastupdate > 217) => 
0.0625393521
, 

-0.0746477013
)
, 

         (v1_hhseniormmbrcnt > 0.5) => 
0.0627484381
, 

-0.0439356231
)
, 

      (v1_raacollegelowtiermmbrcnt > 0.5) => 
0.1744463021
, 

-0.0189126942
)
, 

   (v1_lifeeveverresidedcnt > 0.5) => 
map(

      ( NULL < v1_raainterestsportpersonmmbrcnt and v1_raainterestsportpersonmmbrcnt <= 0.5) => 
0.0518533651
, 

      (v1_raainterestsportpersonmmbrcnt > 0.5) => 
0.1990303495
, 

0.0741836662
)
, 

0.0370996388
)
, 

-0.0000783788
)
;


// Tree: 701

b1_tree_701 := 
map(

( NULL < v1_prospectcollegeprivate and v1_prospectcollegeprivate <= 0.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 1.5) => 
map(

      ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
0.0016530912
, 

      (v1_hhyoungadultmmbrcnt > 0.5) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 4.5) => 
-0.0162455046
, 

         (v1_hhcnt > 4.5) => 
map(

            ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0657486724
, 

            (v1_lifeeveverresidedcnt > 0.5) => 
0.0197076262
, 

0.0210016176
)
, 

-0.0097453502
)
, 

0.0000122216
)
, 

   (v1_hhmiddleagemmbrcnt > 1.5) => 
map(

      ( NULL < v1_crtrecmsdmeancnt12mo and v1_crtrecmsdmeancnt12mo <= 3.5) => 
-0.0148989266
, 

      (v1_crtrecmsdmeancnt12mo > 3.5) => 
0.6857735551
, 

-0.0145816769
)
, 

-0.0015598780
)
, 

(v1_prospectcollegeprivate > 0.5) => 
-0.0521644752
, 

-0.0019223546
)
;


// Tree: 705

b1_tree_705 := 
map(

( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 2.5) => 
-0.0007774137
, 

(v1_raacrtrecevictionmmbrcnt > 2.5) => 
map(

   ( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_raahhcnt and v1_raahhcnt <= 6.5) => 
map(

         ( NULL < v1_crtreccnt and v1_crtreccnt <= 0.5) => 
map(

            ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 3.5) => 
map(

               ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 4.5) => 
0.0420054274
, 

               (v1_raacrtrecevictionmmbrcnt > 4.5) => 
0.1211701853
, 

0.0479080629
)
, 

            (v1_raamiddleagemmbrcnt > 3.5) => 
0.0006785229
, 

0.0364933847
)
, 

         (v1_crtreccnt > 0.5) => 
0.0038094422
, 

0.0170000087
)
, 

      (v1_raahhcnt > 6.5) => 
0.0082083933
, 

0.0104836666
)
, 

   (v1_hhcollegeattendedmmbrcnt > 0.5) => 
-0.0133470254
, 

0.0041777207
)
, 

-0.0003077633
)
;


// Tree: 709

b1_tree_709 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 17.5) => 
map(

   (v1_resinputdwelltype in ['0','F','G','H','P','R']) => 
map(

      ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 0.965) => 
-0.0031376498
, 

      (v1_resinputavmratiodiff12mo > 0.965) => 
map(

         ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 4.5) => 
map(

            ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 1.095) => 
-0.0369675155
, 

            (v1_resinputavmtractratio > 1.095) => 
0.0054023490
, 

-0.0276150605
)
, 

         (v1_resinputbusinesscnt > 4.5) => 
map(

            ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 2.5) => 
0.0514285814
, 

            (v1_raammbrcnt > 2.5) => 
-0.0538575255
, 

0.0001625092
)
, 

-0.0238139999
)
, 

-0.0046457934
)
, 

   (v1_resinputdwelltype in ['-1','S','U']) => 
-0.0001866261
, 

-0.0014329413
)
, 

(v1_prospecttimelastupdate > 17.5) => 
0.0053322185
, 

0.0004684529
)
;


// Tree: 713

b1_tree_713 := 
map(

( NULL < v1_crtreclienjudgcnt and v1_crtreclienjudgcnt <= 22.5) => 
map(

   ( NULL < v1_raaseniormmbrcnt and v1_raaseniormmbrcnt <= 0.5) => 
map(

      ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 0.675) => 
map(

         ( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 0.905) => 
0.0019892062
, 

         (v1_resinputavmratiodiff60mo > 0.905) => 
0.0159365352
, 

0.0026451348
)
, 

      (v1_resinputavmcntyratio > 0.675) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 1.5) => 
map(

            ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 152594.5) => 
-0.0082427776
, 

            (v1_propcurrownedassessedttl > 152594.5) => 
0.0447099239
, 

-0.0041959570
)
, 

         (v1_raammbrcnt > 1.5) => 
0.0023978887
, 

0.0002520646
)
, 

0.0020068733
)
, 

   (v1_raaseniormmbrcnt > 0.5) => 
-0.0030697898
, 

0.0004556098
)
, 

(v1_crtreclienjudgcnt > 22.5) => 
0.2131688524
, 

0.0005423075
)
;


// Tree: 717

b1_tree_717 := 
map(

( NULL < v1_hhcrtreclienjudgmmbrcnt and v1_hhcrtreclienjudgmmbrcnt <= 2.5) => 
-0.0007737370
, 

(v1_hhcrtreclienjudgmmbrcnt > 2.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 132.5) => 
map(

      ( NULL < v1_hhcrtrecfelonymmbrcnt12mo and v1_hhcrtrecfelonymmbrcnt12mo <= 0.5) => 
0.0195300700
, 

      (v1_hhcrtrecfelonymmbrcnt12mo > 0.5) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 9.5) => 
-0.0045481397
, 

         (v1_hhcnt > 9.5) => 
0.5243800417
, 

0.2599159510
)
, 

0.0211861905
)
, 

   (v1_prospecttimelastupdate > 132.5) => 
map(

      ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 154.5) => 
0.7292670541
, 

      (v1_hhcrtreclienjudgamtttl > 154.5) => 
map(

         ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 495906.5) => 
0.0460360273
, 

         (v1_raapropowneravmhighest > 495906.5) => 
0.5120746136
, 

0.0748361646
)
, 

0.1129247349
)
, 

0.0267937535
)
, 

-0.0004297608
)
;


// Tree: 721

b1_tree_721 := 
map(

( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 4.5) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 4.5) => 
map(

      ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 0.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 1.5) => 
map(

            ( NULL < v1_rescurrdwelltypeindex and v1_rescurrdwelltypeindex <= 2) => 
map(

               ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
-0.0047254290
, 

               (v1_verifiedcurrresmatchindex > 0.5) => 
0.0288439597
, 

-0.0030689273
)
, 

            (v1_rescurrdwelltypeindex > 2) => 
-0.0347496286
, 

-0.0049285750
)
, 

         (v1_raammbrcnt > 1.5) => 
0.0040997847
, 

-0.0020960143
)
, 

      (v1_rescurrownershipindex > 0.5) => 
0.0054127639
, 

0.0024199690
)
, 

   (v1_raammbrcnt > 4.5) => 
-0.0018702147
, 

0.0000108299
)
, 

(v1_crtrecseverityindex > 4.5) => 
0.0164118728
, 

0.0004195257
)
;


// Tree: 725

b1_tree_725 := 
map(

(v1_resinputdwelltype in ['-1','F','G','H','P','R','S','U']) => 
map(

   ( NULL < v1_raainterestsportpersonmmbrcnt and v1_raainterestsportpersonmmbrcnt <= 1.5) => 
-0.0004311986
, 

   (v1_raainterestsportpersonmmbrcnt > 1.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

         ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.395) => 
0.0143783733
, 

         (v1_resinputavmcntyratio > 1.395) => 
0.0674471939
, 

0.0193064318
)
, 

      (v1_lifeeveverresidedcnt > 0.5) => 
0.0061238815
, 

0.0101462364
)
, 

0.0000118175
)
, 

(v1_resinputdwelltype in ['0']) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 24.5) => 
map(

      ( NULL < v1_raaelderlymmbrcnt and v1_raaelderlymmbrcnt <= 0.5) => 
0.0545891148
, 

      (v1_raaelderlymmbrcnt > 0.5) => 
-0.1163340061
, 

0.0172967975
)
, 

   (v1_prospecttimelastupdate > 24.5) => 
0.2687825872
, 

0.0623390285
)
, 

0.0000286692
)
;


// Tree: 729

b1_tree_729 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
-0.0005081914
, 

(v1_prospectdeceased > 0.5) => 
map(

   ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 1.365) => 
map(

      ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= 8) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 5.5) => 
0.0463594593
, 

         (v1_hhcnt > 5.5) => 
map(

            ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 0.5) => 
-0.1684859287
, 

            (v1_raacrtreclienjudgmmbrcnt > 0.5) => 
0.0113578602
, 

-0.0528720644
)
, 

0.0313406341
)
, 

      (v1_lifeevtimefirstassetpurchase > 8) => 
map(

         ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 117848) => 
0.2760144104
, 

         (v1_hhpropcurravmhighest > 117848) => 
0.0414852619
, 

0.1587498361
)
, 

0.0480892616
)
, 

   (v1_resinputavmtractratio > 1.365) => 
-0.0915378728
, 

0.0344815324
)
, 

-0.0004748684
)
;


// Tree: 733

b1_tree_733 := 
map(

( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 0.5) => 
map(

   ( NULL < v1_raahhcnt and v1_raahhcnt <= 12.5) => 
map(

      ( NULL < v1_hhcnt and v1_hhcnt <= 7.5) => 
0.0008793766
, 

      (v1_hhcnt > 7.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 31.5) => 
0.0233096182
, 

         (v1_raammbrcnt > 31.5) => 
0.5979444330
, 

0.0266780582
)
, 

0.0015226409
)
, 

   (v1_raahhcnt > 12.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 15.5) => 
-0.0282395797
, 

      (v1_prospecttimeonrecord > 15.5) => 
0.0010143090
, 

-0.0083375211
)
, 

0.0010029665
)
, 

(v1_crtrecbkrptcnt > 0.5) => 
map(

   ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 0.5) => 
-0.0467523744
, 

   (v1_raapropcurrownermmbrcnt > 0.5) => 
-0.0117819200
, 

-0.0167387749
)
, 

-0.0001916105
)
;


// Tree: 737

b1_tree_737 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 435.5) => 
map(

   ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 69299) => 
0.0004964457
, 

   (v1_resinputavmvalue > 69299) => 
-0.0028505500
, 

-0.0006585805
)
, 

(v1_prospecttimelastupdate > 435.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 446) => 
0.5784643884
, 

   (v1_prospecttimeonrecord > 446) => 
map(

      ( NULL < v1_raaelderlymmbrcnt and v1_raaelderlymmbrcnt <= 0.5) => 
map(

         ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 327077.5) => 
-0.0204812261
, 

         (v1_resinputavmvalue60mo > 327077.5) => 
0.7909319209
, 

0.0378938205
)
, 

      (v1_raaelderlymmbrcnt > 0.5) => 
map(

         ( NULL < v1_raahhcnt and v1_raahhcnt <= 3.5) => 
0.3025344687
, 

         (v1_raahhcnt > 3.5) => 
0.0911245474
, 

0.1827355133
)
, 

0.0636053636
)
, 

0.1131639863
)
, 

-0.0005726867
)
;


// Tree: 741

b1_tree_741 := 
map(

( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 147.5) => 
map(

   ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 15.5) => 
-0.0003634528
, 

   (v1_crtrecmsdmeancnt > 15.5) => 
0.0352371034
, 

-0.0001344141
)
, 

(v1_crtrecevictiontimenewest > 147.5) => 
map(

   ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 148.5) => 
-0.0028492714
, 

   (v1_lifeevtimelastmove > 148.5) => 
map(

      ( NULL < v1_raainterestsportpersonmmbrcnt and v1_raainterestsportpersonmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 2.005) => 
map(

            ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 231.5) => 
0.0399640402
, 

            (v1_prospecttimelastupdate > 231.5) => 
0.3545596431
, 

0.0454462692
)
, 

         (v1_resinputavmblockratio > 2.005) => 
0.4502194559
, 

0.0508004119
)
, 

      (v1_raainterestsportpersonmmbrcnt > 0.5) => 
0.2665649736
, 

0.0762289075
)
, 

0.0442132281
)
, 

0.0001232920
)
;


// Tree: 745

b1_tree_745 := 
map(

( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_hhoccproflicmmbrcnt and v1_hhoccproflicmmbrcnt <= 3.5) => 
0.0013806034
, 

   (v1_hhoccproflicmmbrcnt > 3.5) => 
0.4801614674
, 

0.0014186245
)
, 

(v1_raaoccbusinessassocmmbrcnt > 0.5) => 
map(

   ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 0.5) => 
map(

      (v1_resinputdwelltype in ['0','F','H','R','S']) => 
map(

         ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 701) => 
map(

            ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
-0.0325433038
, 

            (v1_lifeeveverresidedcnt > 0.5) => 
-0.0142674672
, 

-0.0248833298
)
, 

         (v1_raacrtreclienjudgamtmax > 701) => 
-0.0051399119
, 

-0.0161514470
)
, 

      (v1_resinputdwelltype in ['-1','G','P','U']) => 
0.0325739806
, 

-0.0116959314
)
, 

   (v1_raapropcurrownermmbrcnt > 0.5) => 
-0.0015615790
, 

-0.0024567483
)
, 

-0.0000935597
)
;


// Tree: 749

b1_tree_749 := 
map(

( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 187) => 
map(

   ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 819658.5) => 
map(

      ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 809832.5) => 
-0.0005349178
, 

      (v1_resinputavmvalue12mo > 809832.5) => 
0.1402997420
, 

-0.0005051322
)
, 

   (v1_resinputavmvalue12mo > 819658.5) => 
map(

      ( NULL < v1_rescurravmtractratio and v1_rescurravmtractratio <= 0.785) => 
map(

         ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 1311000) => 
-0.0415833843
, 

         (v1_resinputavmvalue > 1311000) => 
0.0017180133
, 

-0.0263704880
)
, 

      (v1_rescurravmtractratio > 0.785) => 
0.0206410854
, 

-0.0054599774
)
, 

-0.0005431675
)
, 

(v1_rescurrbusinesscnt > 187) => 
map(

   ( NULL < v1_crtreccnt and v1_crtreccnt <= 0.5) => 
0.4799670144
, 

   (v1_crtreccnt > 0.5) => 
0.0540213925
, 

0.1914232060
)
, 

-0.0005191528
)
;


// Tree: 753

b1_tree_753 := 
map(

( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 18101) => 
-0.0017399229
, 

(v1_raapropowneravmmed > 18101) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 49701.5) => 
0.0182712288
, 

   (v1_raapropowneravmmed > 49701.5) => 
map(

      ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 0.665) => 
-0.0044622424
, 

      (v1_resinputavmblockratio > 0.665) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 0) => 
map(

            ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 1.5) => 
-0.0401268647
, 

            (v1_raammbrcnt > 1.5) => 
map(

               ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 17.5) => 
0.0123447247
, 

               (v1_crtrecmsdmeantimenewest > 17.5) => 
-0.0172115126
, 

0.0089530722
)
, 

0.0082261871
)
, 

         (v1_prospecttimeonrecord > 0) => 
-0.0032371435
, 

0.0007769051
)
, 

-0.0018437821
)
, 

-0.0007103214
)
, 

-0.0012116104
)
;


// Tree: 757

b1_tree_757 := 
map(

(v1_resinputdwelltype in ['-1','F','G','H','P','R','S']) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 1.5) => 
0.0006231541
, 

   (v1_hhmiddleagemmbrcnt > 1.5) => 
map(

      ( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 1.5) => 
-0.0165631064
, 

      (v1_hhelderlymmbrcnt > 1.5) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 159) => 
0.0631465010
, 

         (v1_crtrectimenewest > 159) => 
0.3446727962
, 

0.0870426322
)
, 

-0.0150996059
)
, 

-0.0010714230
)
, 

(v1_resinputdwelltype in ['0','U']) => 
map(

   ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 385211.5) => 
map(

      ( NULL < v1_raacrtrecmsdmeanmmbrcnt12mo and v1_raacrtrecmsdmeanmmbrcnt12mo <= 0.5) => 
0.0488196578
, 

      (v1_raacrtrecmsdmeanmmbrcnt12mo > 0.5) => 
-0.1108987362
, 

0.0257025218
)
, 

   (v1_raapropowneravmhighest > 385211.5) => 
0.1878158849
, 

0.0478088895
)
, 

-0.0010367063
)
;


// Tree: 761

b1_tree_761 := 
map(

(v1_resinputdwelltype in ['0','G','H','R','S','U']) => 
-0.0003234084
, 

(v1_resinputdwelltype in ['-1','F','P']) => 
map(

   ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
0.0003083357
, 

   (v1_hhcrtrecmmbrcnt > 0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 4.5) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 262.5) => 
map(

            ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 155.5) => 
map(

               ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 227.5) => 
0.0479975237
, 

               (v1_crtrectimenewest > 227.5) => 
0.3755128274
, 

0.0529120085
)
, 

            (v1_prospecttimelastupdate > 155.5) => 
-0.0795584319
, 

0.0475968365
)
, 

         (v1_crtrectimenewest > 262.5) => 
-0.1538855049
, 

0.0439335212
)
, 

      (v1_raammbrcnt > 4.5) => 
0.0204502671
, 

0.0254867535
)
, 

0.0102811842
)
, 

0.0001753161
)
;


// Tree: 765

b1_tree_765 := 
map(

( NULL < v1_raacollegeattendedmmbrcnt and v1_raacollegeattendedmmbrcnt <= 6.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 20.5) => 
-0.0008949387
, 

   (v1_prospecttimelastupdate > 20.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0162021374
, 

      (v1_lifeeveverresidedcnt > 0.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

            ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
-0.0662678321
, 

            (v1_verifiedcurrresmatchindex > 0.5) => 
map(

               ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
-0.0227952801
, 

               (v1_resinputownershipindex > 0.5) => 
0.0132873981
, 

0.0002770041
)
, 

-0.0097131099
)
, 

         (v1_raammbrcnt > 0.5) => 
0.0086140487
, 

0.0073312799
)
, 

0.0075298106
)
, 

0.0013422253
)
, 

(v1_raacollegeattendedmmbrcnt > 6.5) => 
-0.0256807990
, 

0.0005038490
)
;


// Tree: 769

b1_tree_769 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
0.0001354487
, 

(v1_prospectdeceased > 0.5) => 
map(

   ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 450) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 214.5) => 
map(

         ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 46) => 
map(

            ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 18950.5) => 
0.0339250866
, 

            (v1_propcurrownedassessedttl > 18950.5) => 
0.2184958927
, 

0.0515032586
)
, 

         (v1_hhcrtreclienjudgamtttl > 46) => 
-0.0666017014
, 

0.0195164986
)
, 

      (v1_lifeevtimelastmove > 214.5) => 
map(

         ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 259) => 
0.2491801346
, 

         (v1_lifeevtimelastmove > 259) => 
0.0752592951
, 

0.1106330252
)
, 

0.0459986418
)
, 

   (v1_lifeevtimelastmove > 450) => 
-0.0726669701
, 

0.0358425759
)
, 

0.0001674376
)
;


// Tree: 773

b1_tree_773 := 
map(

( NULL < v1_raacrtrecevictionmmbrcnt12mo and v1_raacrtrecevictionmmbrcnt12mo <= 0.5) => 
-0.0011816963
, 

(v1_raacrtrecevictionmmbrcnt12mo > 0.5) => 
map(

   ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_raahhcnt and v1_raahhcnt <= 12.5) => 
map(

         ( NULL < v1_raacrtrecevictionmmbrcnt12mo and v1_raacrtrecevictionmmbrcnt12mo <= 2.5) => 
0.0181939294
, 

         (v1_raacrtrecevictionmmbrcnt12mo > 2.5) => 
map(

            ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 3000.5) => 
0.0217486186
, 

            (v1_raacrtreclienjudgamtmax > 3000.5) => 
map(

               ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 3.5) => 
0.0642439848
, 

               (v1_raacrtrecmsdmeanmmbrcnt > 3.5) => 
0.3500226938
, 

0.1860513034
)
, 

0.1200080673
)
, 

0.0205493483
)
, 

      (v1_raahhcnt > 12.5) => 
-0.0190677382
, 

0.0147964988
)
, 

   (v1_hhcrtrecmmbrcnt > 0.5) => 
0.0001646485
, 

0.0049005348
)
, 

-0.0007905547
)
;


// Tree: 777

b1_tree_777 := 
map(

( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 67944.5) => 
map(

   ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 0.555) => 
0.0003785153
, 

   (v1_resinputavmratiodiff12mo > 0.555) => 
map(

      ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 1.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
0.0031185758
, 

         (v1_raammbrcnt > 0.5) => 
map(

            ( NULL < v1_crtreccnt and v1_crtreccnt <= 1.5) => 
map(

               ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 11378) => 
0.0344347274
, 

               (v1_propcurrownedavmttl > 11378) => 
0.0093977118
, 

0.0287936258
)
, 

            (v1_crtreccnt > 1.5) => 
-0.0068040669
, 

0.0203172209
)
, 

0.0118347290
)
, 

      (v1_raamiddleagemmbrcnt > 1.5) => 
-0.0013494708
, 

0.0046566875
)
, 

0.0008868766
)
, 

(v1_resinputavmvalue > 67944.5) => 
-0.0027635567
, 

-0.0003799565
)
;


// Tree: 781

b1_tree_781 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
-0.0002541782
, 

(v1_prospectdeceased > 0.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 109.5) => 
map(

      ( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 0.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 253.5) => 
0.0756030542
, 

         (v1_prospecttimeonrecord > 253.5) => 
0.2281530247
, 

0.0981388453
)
, 

      (v1_hhelderlymmbrcnt > 0.5) => 
map(

         ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 121832.5) => 
0.0440074385
, 

         (v1_resinputavmvalue60mo > 121832.5) => 
-0.0936340926
, 

0.0100439438
)
, 

0.0570278913
)
, 

   (v1_prospecttimelastupdate > 109.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 216.5) => 
-0.0827625915
, 

      (v1_prospecttimeonrecord > 216.5) => 
0.0836348164
, 

-0.0306081801
)
, 

0.0317191982
)
, 

-0.0002242440
)
;


// Tree: 785

b1_tree_785 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 3.5) => 
map(

   ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 0.5) => 
map(

      ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 1255727.5) => 
map(

         ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 116662) => 
-0.0015963511
, 

         (v1_raacrtreclienjudgamtmax > 116662) => 
0.1014627679
, 

-0.0014633537
)
, 

      (v1_resinputavmvalue60mo > 1255727.5) => 
0.0676633006
, 

-0.0011875431
)
, 

   (v1_rescurrownershipindex > 0.5) => 
map(

      ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 306) => 
map(

         ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 6.5) => 
0.0042258351
, 

         (v1_rescurravmratiodiff60mo > 6.5) => 
0.2959541581
, 

0.0043192762
)
, 

      (v1_crtrecfelonytimenewest > 306) => 
-0.1802421427
, 

0.0042700266
)
, 

0.0020915721
)
, 

(v1_raammbrcnt > 3.5) => 
-0.0018655715
, 

-0.0003715902
)
;


// Tree: 789

b1_tree_789 := 
map(

( NULL < v1_raainterestsportpersonmmbrcnt and v1_raainterestsportpersonmmbrcnt <= 0.5) => 
-0.0014641574
, 

(v1_raainterestsportpersonmmbrcnt > 0.5) => 
map(

   ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 25.5) => 
map(

      (v1_resinputdwelltype in ['F','H','R','U']) => 
-0.0131004404
, 

      (v1_resinputdwelltype in ['-1','0','G','P','S']) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 15.5) => 
map(

            ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 2.5) => 
0.0040986061
, 

            (v1_raamiddleagemmbrcnt > 2.5) => 
map(

               ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 6.5) => 
0.0443386189
, 

               (v1_crtrectimenewest > 6.5) => 
0.0078244668
, 

0.0359644840
)
, 

0.0219111021
)
, 

         (v1_raammbrcnt > 15.5) => 
0.0027481470
, 

0.0157676352
)
, 

0.0105193605
)
, 

   (v1_lifeevtimelastmove > 25.5) => 
-0.0024796929
, 

0.0028427021
)
, 

-0.0009864478
)
;


// Tree: 793

b1_tree_793 := 
map(

( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
map(

   ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
0.0015385046
, 

   (v1_hhyoungadultmmbrcnt > 0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

         ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.245) => 
-0.0278360530
, 

         (v1_resinputavmratiodiff12mo > 1.245) => 
0.0476418240
, 

-0.0211909908
)
, 

      (v1_raammbrcnt > 0.5) => 
-0.0055002814
, 

-0.0060744422
)
, 

0.0004272658
)
, 

(v1_hhseniormmbrcnt > 0.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 0) => 
map(

      ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 683500) => 
-0.0481555750
, 

      (v1_raapropowneravmmed > 683500) => 
0.2470534339
, 

-0.0437145843
)
, 

   (v1_prospecttimeonrecord > 0) => 
-0.0060329904
, 

-0.0081585756
)
, 

-0.0003484965
)
;


// Tree: 797

b1_tree_797 := 
map(

( NULL < v1_hhcrtrecbkrptmmbrcnt and v1_hhcrtrecbkrptmmbrcnt <= 3.5) => 
map(

   ( NULL < v1_hhinterestsportpersonmmbrcnt and v1_hhinterestsportpersonmmbrcnt <= 2.5) => 
-0.0004583402
, 

   (v1_hhinterestsportpersonmmbrcnt > 2.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 81) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 5.5) => 
map(

            ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 80) => 
0.5975441634
, 

            (v1_prospecttimeonrecord > 80) => 
map(

               ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
0.2403124480
, 

               (v1_lifeeveverresidedcnt > 1.5) => 
-0.0029499026
, 

0.1273692138
)
, 

0.2599826611
)
, 

         (v1_raammbrcnt > 5.5) => 
0.0742073902
, 

0.1823452345
)
, 

      (v1_lifeevtimelastmove > 81) => 
-0.0223411306
, 

0.0490858822
)
, 

-0.0004199290
)
, 

(v1_hhcrtrecbkrptmmbrcnt > 3.5) => 
0.1637422739
, 

-0.0003172464
)
;


// Tree: 801

b1_tree_801 := 
map(

( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
-0.0012832944
, 

(v1_resinputownershipindex > 0.5) => 
map(

   ( NULL < v1_hhteenagermmbrcnt and v1_hhteenagermmbrcnt <= 0.5) => 
0.0018900469
, 

   (v1_hhteenagermmbrcnt > 0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
-0.1186283352
, 

      (v1_raammbrcnt > 0.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 179.5) => 
map(

            ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 227500) => 
map(

               ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 2875) => 
0.0442142193
, 

               (v1_raacrtreclienjudgamtmax > 2875) => 
0.2255236709
, 

0.0957936322
)
, 

            (v1_hhpropcurravmhighest > 227500) => 
0.2928195836
, 

0.1272035665
)
, 

         (v1_prospecttimeonrecord > 179.5) => 
-0.0054885583
, 

0.0817091237
)
, 

0.0675259408
)
, 

0.0019965864
)
, 

0.0005595506
)
;


// Tree: 805

b1_tree_805 := 
map(

( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 2.5) => 
-0.0001369622
, 

(v1_raacrtrecevictionmmbrcnt > 2.5) => 
map(

   ( NULL < v1_crtrecmsdmeancnt12mo and v1_crtrecmsdmeancnt12mo <= 3.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 433.5) => 
map(

         ( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 0.5) => 
map(

            ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 14045) => 
0.0160145106
, 

            (v1_hhpropcurravmhighest > 14045) => 
-0.0170109440
, 

0.0099064500
)
, 

         (v1_hhcollegeattendedmmbrcnt > 0.5) => 
-0.0090636375
, 

0.0048911380
)
, 

      (v1_prospecttimelastupdate > 433.5) => 
0.4173175034
, 

0.0051011222
)
, 

   (v1_crtrecmsdmeancnt12mo > 3.5) => 
map(

      ( NULL < v1_raacrtrecfelonymmbrcnt12mo and v1_raacrtrecfelonymmbrcnt12mo <= 0.5) => 
0.1108462516
, 

      (v1_raacrtrecfelonymmbrcnt12mo > 0.5) => 
0.4688000975
, 

0.1661999391
)
, 

0.0057614190
)
, 

0.0004263503
)
;


// Tree: 809

b1_tree_809 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 160.5) => 
-0.0006667380
, 

(v1_prospecttimelastupdate > 160.5) => 
map(

   ( NULL < v1_rescurravmvalue and v1_rescurravmvalue <= 662250) => 
map(

      ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 0.5) => 
0.0000973003
, 

      (v1_resinputbusinesscnt > 0.5) => 
0.0448403983
, 

0.0138438349
)
, 

   (v1_rescurravmvalue > 662250) => 
map(

      ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 758000) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 228.5) => 
-0.0841397041
, 

         (v1_prospecttimelastupdate > 228.5) => 
0.2665413259
, 

0.0383203381
)
, 

      (v1_raapropowneravmhighest > 758000) => 
map(

         ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 947579.5) => 
0.7772342932
, 

         (v1_raapropowneravmhighest > 947579.5) => 
0.2678668519
, 

0.4287197281
)
, 

0.1852032769
)
, 

0.0172241676
)
, 

-0.0002970853
)
;


// Tree: 813

b1_tree_813 := 
map(

( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 225.5) => 
map(

      ( NULL < v1_crtrecfelonycnt and v1_crtrecfelonycnt <= 1.5) => 
0.0009985365
, 

      (v1_crtrecfelonycnt > 1.5) => 
map(

         ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 20.5) => 
0.0960810122
, 

         (v1_crtrecfelonytimenewest > 20.5) => 
map(

            ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 177) => 
-0.0016131066
, 

            (v1_prospecttimeonrecord > 177) => 
map(

               ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 127.5) => 
0.3306224216
, 

               (v1_crtrecfelonytimenewest > 127.5) => 
0.0269653755
, 

0.1765934852
)
, 

0.0195508432
)
, 

0.0370318380
)
, 

0.0011892130
)
, 

   (v1_crtrecfelonytimenewest > 225.5) => 
-0.0720228450
, 

0.0010869716
)
, 

(v1_raayoungadultmmbrcnt > 0.5) => 
-0.0032591643
, 

-0.0007599485
)
;


// Tree: 817

b1_tree_817 := 
map(

( NULL < v1_crtrecfelonycnt and v1_crtrecfelonycnt <= 3.5) => 
-0.0005764225
, 

(v1_crtrecfelonycnt > 3.5) => 
map(

   ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 51.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 5.5) => 
map(

         ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 12) => 
0.1189448153
, 

         (v1_crtreclienjudgtimenewest > 12) => 
-0.1272671669
, 

0.0845280866
)
, 

      (v1_raammbrcnt > 5.5) => 
0.0446209052
, 

0.0537847765
)
, 

   (v1_crtrecfelonytimenewest > 51.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 254) => 
-0.0017718649
, 

      (v1_lifeevtimelastmove > 254) => 
map(

         ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 1.5) => 
0.0239048290
, 

         (v1_raacrtrecfelonymmbrcnt > 1.5) => 
0.6419584996
, 

0.2682516290
)
, 

0.0145586699
)
, 

0.0287939505
)
, 

-0.0004441512
)
;


// Tree: 821

b1_tree_821 := 
map(

( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 0.5) => 
0.0015592377
, 

(v1_raaoccproflicmmbrcnt > 0.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 2386443) => 
map(

      ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 1.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 0) => 
map(

            ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 1.5) => 
map(

               ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 419708.5) => 
-0.0289688019
, 

               (v1_resinputavmvalue > 419708.5) => 
-0.1046973588
, 

-0.0347940755
)
, 

            (v1_raacrtrecmmbrcnt > 1.5) => 
-0.0139745323
, 

-0.0198656765
)
, 

         (v1_prospecttimeonrecord > 0) => 
0.0018562711
, 

-0.0086308197
)
, 

      (v1_raapropcurrownermmbrcnt > 1.5) => 
-0.0016691013
, 

-0.0026237202
)
, 

   (v1_raapropowneravmmed > 2386443) => 
0.6346330369
, 

-0.0025181896
)
, 

0.0005656317
)
;


// Tree: 825

b1_tree_825 := 
map(

( NULL < v1_raappcurrownerwtrcrftmmbrcnt and v1_raappcurrownerwtrcrftmmbrcnt <= 0.5) => 
-0.0005158312
, 

(v1_raappcurrownerwtrcrftmmbrcnt > 0.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 26.5) => 
map(

      ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.425) => 
map(

         (v1_resinputdwelltype in ['0','F','H','S','U']) => 
0.0055898339
, 

         (v1_resinputdwelltype in ['-1','G','P','R']) => 
0.0609073653
, 

0.0084028887
)
, 

      (v1_resinputavmcntyratio > 1.425) => 
map(

         ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 107808) => 
map(

            ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 9.5) => 
0.0736378091
, 

            (v1_raacrtrecmmbrcnt > 9.5) => 
-0.0427938872
, 

0.0583648268
)
, 

         (v1_hhpropcurravmhighest > 107808) => 
-0.0239594405
, 

0.0457726589
)
, 

0.0121205532
)
, 

   (v1_prospecttimeonrecord > 26.5) => 
0.0024182671
, 

0.0058742972
)
, 

-0.0000115401
)
;


// Tree: 829

b1_tree_829 := 
map(

( NULL < v1_hhcollegetiermmbrhighest and v1_hhcollegetiermmbrhighest <= 0.5) => 
map(

   ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 1.5) => 
-0.0005221513
, 

   (v1_raacrtrecmsdmeanmmbrcnt > 1.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 5.5) => 
map(

         ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 150028) => 
map(

            ( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 2.165) => 
0.0193597866
, 

            (v1_resinputavmratiodiff60mo > 2.165) => 
map(

               ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.015) => 
0.2660894619
, 

               (v1_resinputavmcntyratio > 1.015) => 
0.0547947599
, 

0.1393126407
)
, 

0.0199341817
)
, 

         (v1_raapropowneravmhighest > 150028) => 
-0.0012629322
, 

0.0138039975
)
, 

      (v1_raammbrcnt > 5.5) => 
0.0021317077
, 

0.0033915140
)
, 

0.0008830864
)
, 

(v1_hhcollegetiermmbrhighest > 0.5) => 
-0.0146417792
, 

-0.0003929642
)
;


// Tree: 833

b1_tree_833 := 
map(

( NULL < v1_raateenagemmbrcnt and v1_raateenagemmbrcnt <= 0.5) => 
map(

   ( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 5.625) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 15.5) => 
-0.0011522843
, 

      (v1_prospecttimelastupdate > 15.5) => 
0.0040549462
, 

0.0003571524
)
, 

   (v1_resinputavmratiodiff60mo > 5.625) => 
map(

      ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 1.075) => 
map(

         ( NULL < v1_raaseniormmbrcnt and v1_raaseniormmbrcnt <= 0.5) => 
0.2038879910
, 

         (v1_raaseniormmbrcnt > 0.5) => 
-0.0353066700
, 

0.1394894284
)
, 

      (v1_resinputavmtractratio > 1.075) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
0.0951550601
, 

         (v1_raammbrcnt > 0.5) => 
-0.0311246099
, 

-0.0050794279
)
, 

0.0303808576
)
, 

0.0003829131
)
, 

(v1_raateenagemmbrcnt > 0.5) => 
0.0498699564
, 

0.0005270982
)
;


// Tree: 837

b1_tree_837 := 
map(

( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 2918901) => 
map(

   ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 4.5) => 
-0.0007002307
, 

   (v1_crtrecseverityindex > 4.5) => 
map(

      ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 84941.5) => 
map(

         ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 427.5) => 
map(

            ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 239.5) => 
map(

               (v1_resinputdwelltype in ['H','R','S']) => 
0.0159144506
, 

               (v1_resinputdwelltype in ['-1','0','F','G','P','U']) => 
0.0675484967
, 

0.0196253163
)
, 

            (v1_crtrecfelonytimenewest > 239.5) => 
-0.0378985243
, 

0.0147595779
)
, 

         (v1_crtrecmsdmeantimenewest > 427.5) => 
0.4362542666
, 

0.0155503747
)
, 

      (v1_resinputavmvalue > 84941.5) => 
-0.0311165213
, 

0.0089244568
)
, 

-0.0004589016
)
, 

(v1_resinputavmvalue12mo > 2918901) => 
-0.1093030087
, 

-0.0004839380
)
;


// Tree: 841

b1_tree_841 := 
map(

( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
map(

   ( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 0.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 107.5) => 
0.0010143315
, 

      (v1_prospecttimelastupdate > 107.5) => 
0.0305888645
, 

0.0015586332
)
, 

   (v1_hhelderlymmbrcnt > 0.5) => 
map(

      ( NULL < v1_propeverownedcnt and v1_propeverownedcnt <= 0.5) => 
map(

         ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 1.5) => 
-0.0690326029
, 

         (v1_raapropcurrownermmbrcnt > 1.5) => 
-0.0183192789
, 

-0.0491762264
)
, 

      (v1_propeverownedcnt > 0.5) => 
0.0189017707
, 

-0.0233873580
)
, 

0.0013747198
)
, 

(v1_hhcnt > 1.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0127282182
, 

   (v1_lifeeveverresidedcnt > 0.5) => 
-0.0062350333
, 

-0.0057660791
)
, 

-0.0011538833
)
;


// Tree: 845

b1_tree_845 := 
map(

( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 768968.5) => 
-0.0002410850
, 

(v1_raapropowneravmmed > 768968.5) => 
map(

   ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 775555.5) => 
0.0082165686
, 

   (v1_resinputavmvalue > 775555.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 3.5) => 
map(

         ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.515) => 
-0.0735220390
, 

         (v1_resinputavmcntyratio > 1.515) => 
map(

            ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 1.565) => 
map(

               ( NULL < v1_propcurrowner and v1_propcurrowner <= 0.5) => 
0.1953650094
, 

               (v1_propcurrowner > 0.5) => 
0.2019255047
, 

0.1975518412
)
, 

            (v1_resinputavmtractratio > 1.565) => 
0.0278897380
, 

0.1490769546
)
, 

0.1134611156
)
, 

      (v1_raammbrcnt > 3.5) => 
0.0332886899
, 

0.0526228761
)
, 

0.0211779592
)
, 

-0.0000568911
)
;


// Tree: 849

b1_tree_849 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 498.5) => 
map(

   ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 2.025) => 
-0.0008044585
, 

   (v1_resinputavmcntyratio > 2.025) => 
map(

      ( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 124.5) => 
0.0081585899
, 

      (v1_crtrecevictiontimenewest > 124.5) => 
0.2845418966
, 

0.0092400226
)
, 

-0.0004417459
)
, 

(v1_prospecttimelastupdate > 498.5) => 
map(

   ( NULL < v1_raacrtrecmsdmeanmmbrcnt12mo and v1_raacrtrecmsdmeanmmbrcnt12mo <= 0.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 566.5) => 
map(

         ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 0.76) => 
0.0393740666
, 

         (v1_resinputavmblockratio > 0.76) => 
0.3222455869
, 

0.1428636472
)
, 

      (v1_prospecttimeonrecord > 566.5) => 
-0.0259134655
, 

0.0574583613
)
, 

   (v1_raacrtrecmsdmeanmmbrcnt12mo > 0.5) => 
0.4221730276
, 

0.0966749920
)
, 

-0.0004052984
)
;


// Tree: 853

b1_tree_853 := 
map(

( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 31.475) => 
map(

   (v1_resinputdwelltype in ['-1','F','G','H','P','R','S','U']) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 3.5) => 
0.0011015900
, 

      (v1_raammbrcnt > 3.5) => 
-0.0017133345
, 

-0.0006452503
)
, 

   (v1_resinputdwelltype in ['0']) => 
map(

      ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= 34) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 7.5) => 
-0.0632668593
, 

         (v1_raammbrcnt > 7.5) => 
map(

            ( NULL < v1_raacollegemidtiermmbrcnt and v1_raacollegemidtiermmbrcnt <= 0.5) => 
0.1921735423
, 

            (v1_raacollegemidtiermmbrcnt > 0.5) => 
-0.0243559723
, 

0.0839087850
)
, 

0.0170107648
)
, 

      (v1_lifeevtimefirstassetpurchase > 34) => 
0.2571353353
, 

0.0629169327
)
, 

-0.0006278061
)
, 

(v1_resinputavmtractratio > 31.475) => 
-0.1277206997
, 

-0.0006426795
)
;


// Tree: 857

b1_tree_857 := 
map(

( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 26.13) => 
map(

   (v1_resinputdwelltype in ['-1','F','G','H','P','R','S','U']) => 
map(

      ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 443) => 
-0.0018875625
, 

         (v1_prospecttimelastupdate > 443) => 
map(

            ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 62596.5) => 
0.3104214138
, 

            (v1_raapropowneravmhighest > 62596.5) => 
-0.0521157528
, 

0.1518114034
)
, 

-0.0018421436
)
, 

      (v1_resinputownershipindex > 0.5) => 
0.0010522302
, 

-0.0002130447
)
, 

   (v1_resinputdwelltype in ['0']) => 
map(

      (v1_rescurrdwelltype in ['-1','H']) => 
0.0124479253
, 

      (v1_rescurrdwelltype in ['F','P','R','S','U']) => 
0.2107156992
, 

0.0575087830
)
, 

-0.0001976697
)
, 

(v1_resinputavmratiodiff12mo > 26.13) => 
-0.1726178518
, 

-0.0002129772
)
;


// Tree: 861

b1_tree_861 := 
map(

( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
0.0013056560
, 

(v1_hhmiddleagemmbrcnt > 0.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 0) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 7.5) => 
-0.0538277193
, 

      (v1_raammbrcnt > 7.5) => 
-0.0178305106
, 

-0.0322122474
)
, 

   (v1_prospecttimeonrecord > 0) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

         ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 672500) => 
0.0271797596
, 

         (v1_resinputavmvalue > 672500) => 
0.1990042384
, 

0.0304377671
)
, 

      (v1_lifeeveverresidedcnt > 0.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
-0.0305243377
, 

         (v1_raammbrcnt > 0.5) => 
-0.0025913169
, 

-0.0035619869
)
, 

-0.0029503553
)
, 

-0.0043388773
)
, 

-0.0003067684
)
;


// Tree: 865

b1_tree_865 := 
map(

( NULL < v1_raainterestsportpersonmmbrcnt and v1_raainterestsportpersonmmbrcnt <= 1.5) => 
-0.0006319003
, 

(v1_raainterestsportpersonmmbrcnt > 1.5) => 
map(

   ( NULL < v1_raahhcnt and v1_raahhcnt <= 9.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 60.5) => 
map(

         ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 7.5) => 
0.0258538413
, 

         (v1_raacrtreclienjudgmmbrcnt > 7.5) => 
map(

            ( NULL < v1_raacrtreclienjudgmmbrcnt12mo and v1_raacrtreclienjudgmmbrcnt12mo <= 0.5) => 
0.3408750741
, 

            (v1_raacrtreclienjudgmmbrcnt12mo > 0.5) => 
map(

               ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 1.5) => 
-0.1244917600
, 

               (v1_raayoungadultmmbrcnt > 1.5) => 
0.1519232938
, 

0.0639730494
)
, 

0.1534337035
)
, 

0.0289725668
)
, 

      (v1_prospecttimeonrecord > 60.5) => 
0.0066760471
, 

0.0167194904
)
, 

   (v1_raahhcnt > 9.5) => 
-0.0098888914
, 

0.0055236567
)
, 

-0.0003787515
)
;

b1_gbm_logit := sum(
b1_tree_1,
b1_tree_5,
b1_tree_9,
b1_tree_13,
b1_tree_17,
b1_tree_21,
b1_tree_25,
b1_tree_29,
b1_tree_33,
b1_tree_37,
b1_tree_41,
b1_tree_45,
b1_tree_49,
b1_tree_53,
b1_tree_57,
b1_tree_61,
b1_tree_65,
b1_tree_69,
b1_tree_73,
b1_tree_77,
b1_tree_81,
b1_tree_85,
b1_tree_89,
b1_tree_93,
b1_tree_97,
b1_tree_101,
b1_tree_105,
b1_tree_109,
b1_tree_113,
b1_tree_117,
b1_tree_121,
b1_tree_125,
b1_tree_129,
b1_tree_133,
b1_tree_137,
b1_tree_141,
b1_tree_145,
b1_tree_149,
b1_tree_153,
b1_tree_157,
b1_tree_161,
b1_tree_165,
b1_tree_169,
b1_tree_173,
b1_tree_177,
b1_tree_181,
b1_tree_185,
b1_tree_189,
b1_tree_193,
b1_tree_197,
b1_tree_201,
b1_tree_205,
b1_tree_209,
b1_tree_213,
b1_tree_217,
b1_tree_221,
b1_tree_225,
b1_tree_229,
b1_tree_233,
b1_tree_237,
b1_tree_241,
b1_tree_245,
b1_tree_249,
b1_tree_253,
b1_tree_257,
b1_tree_261,
b1_tree_265,
b1_tree_269,
b1_tree_273,
b1_tree_277,
b1_tree_281,
b1_tree_285,
b1_tree_289,
b1_tree_293,
b1_tree_297,
b1_tree_301,
b1_tree_305,
b1_tree_309,
b1_tree_313,
b1_tree_317,
b1_tree_321,
b1_tree_325,
b1_tree_329,
b1_tree_333,
b1_tree_337,
b1_tree_341,
b1_tree_345,
b1_tree_349,
b1_tree_353,
b1_tree_357,
b1_tree_361,
b1_tree_365,
b1_tree_369,
b1_tree_373,
b1_tree_377,
b1_tree_381,
b1_tree_385,
b1_tree_389,
b1_tree_393,
b1_tree_397,
b1_tree_401,
b1_tree_405,
b1_tree_409,
b1_tree_413,
b1_tree_417,
b1_tree_421,
b1_tree_425,
b1_tree_429,
b1_tree_433,
b1_tree_437,
b1_tree_441,
b1_tree_445,
b1_tree_449,
b1_tree_453,
b1_tree_457,
b1_tree_461,
b1_tree_465,
b1_tree_469,
b1_tree_473,
b1_tree_477,
b1_tree_481,
b1_tree_485,
b1_tree_489,
b1_tree_493,
b1_tree_497,
b1_tree_501,
b1_tree_505,
b1_tree_509,
b1_tree_513,
b1_tree_517,
b1_tree_521,
b1_tree_525,
b1_tree_529,
b1_tree_533,
b1_tree_537,
b1_tree_541,
b1_tree_545,
b1_tree_549,
b1_tree_553,
b1_tree_557,
b1_tree_561,
b1_tree_565,
b1_tree_569,
b1_tree_573,
b1_tree_577,
b1_tree_581,
b1_tree_585,
b1_tree_589,
b1_tree_593,
b1_tree_597,
b1_tree_601,
b1_tree_605,
b1_tree_609,
b1_tree_613,
b1_tree_617,
b1_tree_621,
b1_tree_625,
b1_tree_629,
b1_tree_633,
b1_tree_637,
b1_tree_641,
b1_tree_645,
b1_tree_649,
b1_tree_653,
b1_tree_657,
b1_tree_661,
b1_tree_665,
b1_tree_669,
b1_tree_673,
b1_tree_677,
b1_tree_681,
b1_tree_685,
b1_tree_689,
b1_tree_693,
b1_tree_697,
b1_tree_701,
b1_tree_705,
b1_tree_709,
b1_tree_713,
b1_tree_717,
b1_tree_721,
b1_tree_725,
b1_tree_729,
b1_tree_733,
b1_tree_737,
b1_tree_741,
b1_tree_745,
b1_tree_749,
b1_tree_753,
b1_tree_757,
b1_tree_761,
b1_tree_765,
b1_tree_769,
b1_tree_773,
b1_tree_777,
b1_tree_781,
b1_tree_785,
b1_tree_789,
b1_tree_793,
b1_tree_797,
b1_tree_801,
b1_tree_805,
b1_tree_809,
b1_tree_813,
b1_tree_817,
b1_tree_821,
b1_tree_825,
b1_tree_829,
b1_tree_833,
b1_tree_837,
b1_tree_841,
b1_tree_845,
b1_tree_849,
b1_tree_853,
b1_tree_857,
b1_tree_861,
b1_tree_865);

////////////////////////////////////
// Score for class 1: underbanked //
////////////////////////////////////


b2_tree_0 :=  0.0000000000;


// Tree: 2

b2_tree_2 := 
map(

( NULL < v1_propcurrowner and v1_propcurrowner <= 0.5) => 
map(

   ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 1.5) => 
map(

      ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 0.5) => 
-0.0201361562
, 

      (v1_raacrtrecevictionmmbrcnt > 0.5) => 
0.0425407882
, 

-0.0075099149
)
, 

   (v1_crtrecseverityindex > 1.5) => 
map(

      ( NULL < v1_crtreccnt and v1_crtreccnt <= 3.5) => 
map(

         ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 0.5) => 
0.0427439990
, 

         (v1_raacrtrecevictionmmbrcnt > 0.5) => 
0.1273768326
, 

0.0843779986
)
, 

      (v1_crtreccnt > 3.5) => 
0.1717185171
, 

0.1188071531
)
, 

0.0284551413
)
, 

(v1_propcurrowner > 0.5) => 
map(

   ( NULL < v1_crtreccnt and v1_crtreccnt <= 2.5) => 
-0.0973860976
, 

   (v1_crtreccnt > 2.5) => 
-0.0154218781
, 

-0.0860129034
)
, 

0.0005079283
)
;


// Tree: 6

b2_tree_6 := 
map(

( NULL < v1_propcurrowner and v1_propcurrowner <= 0.5) => 
map(

   ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 1.5) => 
map(

      ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 0.5) => 
-0.0170260234
, 

      (v1_raacrtrecevictionmmbrcnt > 0.5) => 
0.0355563357
, 

-0.0064377949
)
, 

   (v1_crtrecseverityindex > 1.5) => 
map(

      ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 3.5) => 
map(

         ( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
0.0789893143
, 

         (v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
-0.0450641343
, 

0.0712650613
)
, 

      (v1_crtrecseverityindex > 3.5) => 
0.1428922229
, 

0.0948890152
)
, 

0.0223798622
)
, 

(v1_propcurrowner > 0.5) => 
map(

   ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
-0.0930480714
, 

   (v1_crtrecseverityindex > 2.5) => 
-0.0227056397
, 

-0.0800935033
)
, 

-0.0026004087
)
;


// Tree: 10

b2_tree_10 := 
map(

( NULL < v1_crtreccnt and v1_crtreccnt <= 1.5) => 
map(

   ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

      ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 0.5) => 
-0.0135151359
, 

      (v1_raacrtrecevictionmmbrcnt > 0.5) => 
0.0408203774
, 

-0.0013027109
)
, 

   (v1_lifeevtimefirstassetpurchase > -0.5) => 
-0.0858435264
, 

-0.0227967723
)
, 

(v1_crtreccnt > 1.5) => 
map(

   ( NULL < v1_propeverownedcnt and v1_propeverownedcnt <= 0.5) => 
map(

      ( NULL < v1_crtrecfelonycnt and v1_crtrecfelonycnt <= 0.5) => 
map(

         ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 1.5) => 
0.0676871098
, 

         (v1_raacrtrecevictionmmbrcnt > 1.5) => 
0.1156901724
, 

0.0866455649
)
, 

      (v1_crtrecfelonycnt > 0.5) => 
0.1563983208
, 

0.0963293967
)
, 

   (v1_propeverownedcnt > 0.5) => 
-0.0158304204
, 

0.0650185169
)
, 

-0.0046910970
)
;


// Tree: 14

b2_tree_14 := 
map(

( NULL < v1_crtreccnt and v1_crtreccnt <= 2.5) => 
map(

   ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
map(

      ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 0.5) => 
-0.0073928029
, 

      (v1_raacrtrecevictionmmbrcnt > 0.5) => 
map(

         ( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
0.0477615891
, 

         (v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
-0.0705754708
, 

0.0424708261
)
, 

0.0045916327
)
, 

   (v1_hhpropcurrownermmbrcnt > 0.5) => 
-0.0690768272
, 

-0.0168090492
)
, 

(v1_crtreccnt > 2.5) => 
map(

   ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 2.5) => 
map(

      ( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 0.5) => 
0.0926750564
, 

      (v1_prospectcollegeprogramtype > 0.5) => 
-0.0218664422
, 

0.0873975471
)
, 

   (v1_rescurrownershipindex > 2.5) => 
-0.0327465140
, 

0.0678002478
)
, 

-0.0046160151
)
;


// Tree: 18

b2_tree_18 := 
map(

( NULL < v1_crtreccnt and v1_crtreccnt <= 1.5) => 
map(

   ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
map(

      ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 1.5) => 
map(

         ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
-0.0020223828
, 

         (v1_lifeevtimefirstassetpurchase > -0.5) => 
-0.0601544951
, 

-0.0076349760
)
, 

      (v1_raacrtrecevictionmmbrcnt > 1.5) => 
0.0468094768
, 

-0.0015733391
)
, 

   (v1_verifiedcurrresmatchindex > 0.5) => 
-0.0709045896
, 

-0.0190212936
)
, 

(v1_crtreccnt > 1.5) => 
map(

   ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 2.5) => 
map(

      ( NULL < v1_crtreccnt and v1_crtreccnt <= 6.5) => 
0.0529448598
, 

      (v1_crtreccnt > 6.5) => 
0.0955690972
, 

0.0652255390
)
, 

   (v1_rescurrownershipindex > 2.5) => 
-0.0384876078
, 

0.0462433961
)
, 

-0.0055350557
)
;


// Tree: 22

b2_tree_22 := 
map(

( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 3.5) => 
map(

   ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 64632) => 
map(

      ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 1.5) => 
map(

         ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
map(

            ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
-0.0052543235
, 

            (v1_raacrtrecfelonymmbrcnt > 0.5) => 
0.0418722289
, 

-0.0005863472
)
, 

         (v1_verifiedcurrresmatchindex > 0.5) => 
-0.0553481843
, 

-0.0070269655
)
, 

      (v1_crtrecseverityindex > 1.5) => 
map(

         ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
0.0500592893
, 

         (v1_verifiedcurrresmatchindex > 0.5) => 
0.0065363807
, 

0.0370307496
)
, 

0.0022921172
)
, 

   (v1_hhpropcurravmhighest > 64632) => 
-0.0674264501
, 

-0.0123762419
)
, 

(v1_crtrecseverityindex > 3.5) => 
0.0740026250
, 

-0.0055064791
)
;


// Tree: 26

b2_tree_26 := 
map(

( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 3.5) => 
map(

   ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

      ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 1.5) => 
map(

         ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

            ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 2.5) => 
0.0009061796
, 

            (v1_raacrtrecevictionmmbrcnt > 2.5) => 
0.0543363653
, 

0.0031972783
)
, 

         (v1_lifeeveverresidedcnt > 0.5) => 
-0.0362406206
, 

-0.0019679778
)
, 

      (v1_crtrecseverityindex > 1.5) => 
0.0347564049
, 

0.0055502834
)
, 

   (v1_lifeevtimefirstassetpurchase > -0.5) => 
map(

      ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 0.5) => 
-0.0639444886
, 

      (v1_crtrecbkrptcnt > 0.5) => 
0.0101926805
, 

-0.0557150498
)
, 

-0.0109917352
)
, 

(v1_crtrecseverityindex > 3.5) => 
0.0634197660
, 

-0.0050800501
)
;


// Tree: 30

b2_tree_30 := 
map(

( NULL < v1_crtreccnt and v1_crtreccnt <= 3.5) => 
map(

   ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
map(

      ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
map(

         ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
map(

            ( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
-0.0014048480
, 

            (v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
-0.0681163277
, 

-0.0041631023
)
, 

         (v1_crtrecseverityindex > 2.5) => 
0.0392772154
, 

-0.0013632890
)
, 

      (v1_raacrtrecfelonymmbrcnt > 0.5) => 
0.0411174664
, 

0.0043506999
)
, 

   (v1_verifiedcurrresmatchindex > 0.5) => 
-0.0496812001
, 

-0.0101990590
)
, 

(v1_crtreccnt > 3.5) => 
map(

   ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 2.5) => 
0.0563670106
, 

   (v1_rescurrownershipindex > 2.5) => 
-0.0117197272
, 

0.0463060924
)
, 

-0.0040743460
)
;


// Tree: 34

b2_tree_34 := 
map(

( NULL < v1_crtreccnt and v1_crtreccnt <= 1.5) => 
map(

   ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
map(

      ( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 2.5) => 
0.0017331418
, 

         (v1_raacrtrecevictionmmbrcnt > 2.5) => 
0.0470246534
, 

0.0043306734
)
, 

      (v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
-0.0679027199
, 

0.0012587246
)
, 

   (v1_verifiedcurrresmatchindex > 0.5) => 
-0.0557612923
, 

-0.0130392113
)
, 

(v1_crtreccnt > 1.5) => 
map(

   ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 74852) => 
map(

      ( NULL < v1_hhcollegetiermmbrhighest and v1_hhcollegetiermmbrhighest <= 0.5) => 
0.0449597952
, 

      (v1_hhcollegetiermmbrhighest > 0.5) => 
-0.0190856262
, 

0.0401825440
)
, 

   (v1_hhpropcurravmhighest > 74852) => 
-0.0150612409
, 

0.0285857444
)
, 

-0.0044884278
)
;


// Tree: 38

b2_tree_38 := 
map(

( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 3.5) => 
map(

   ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 0.715) => 
map(

      ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 1.5) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 126487.5) => 
map(

            ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 3.5) => 
-0.0005177599
, 

            (v1_raacrtrecmmbrcnt > 3.5) => 
0.0284467116
, 

0.0045365920
)
, 

         (v1_raapropowneravmmed > 126487.5) => 
-0.0232558757
, 

-0.0026799707
)
, 

      (v1_raacrtrecevictionmmbrcnt > 1.5) => 
0.0296081546
, 

0.0017076500
)
, 

   (v1_rescurravmcntyratio > 0.715) => 
-0.0521020188
, 

-0.0082958437
)
, 

(v1_crtrecseverityindex > 3.5) => 
map(

   ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 1.5) => 
0.0531060675
, 

   (v1_verifiedcurrresmatchindex > 1.5) => 
0.0111572460
, 

0.0427629611
)
, 

-0.0042470571
)
;


// Tree: 42

b2_tree_42 := 
map(

( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

      ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 2.5) => 
0.0040469610
, 

      (v1_raacrtrecevictionmmbrcnt > 2.5) => 
0.0443628651
, 

0.0062511975
)
, 

   (v1_lifeeveverresidedcnt > 0.5) => 
map(

      ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 0.5) => 
-0.0547150895
, 

      (v1_crtrecbkrptcnt > 0.5) => 
0.0129856571
, 

-0.0467808169
)
, 

-0.0116761424
)
, 

(v1_crtrecseverityindex > 2.5) => 
map(

   ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
0.0424279172
, 

   (v1_verifiedcurrresmatchindex > 0.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 75.5) => 
0.0219289834
, 

      (v1_crtrectimenewest > 75.5) => 
-0.0390053288
, 

0.0059692052
)
, 

0.0266924720
)
, 

-0.0044441314
)
;


// Tree: 46

b2_tree_46 := 
map(

( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 2.5) => 
map(

   ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 1.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
map(

         ( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 1.5) => 
0.0032288876
, 

         (v1_prospectcollegeprogramtype > 1.5) => 
-0.0606689860
, 

0.0012648639
)
, 

      (v1_lifeeveverresidedcnt > 1.5) => 
-0.0522302699
, 

-0.0029040462
)
, 

   (v1_crtrecseverityindex > 1.5) => 
map(

      ( NULL < v1_prospectcollegetier and v1_prospectcollegetier <= 0.5) => 
map(

         ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 1.5) => 
0.0189430849
, 

         (v1_raacrtrecevictionmmbrcnt > 1.5) => 
0.0454839169
, 

0.0285504828
)
, 

      (v1_prospectcollegetier > 0.5) => 
-0.0408285133
, 

0.0249910015
)
, 

0.0051417861
)
, 

(v1_rescurrownershipindex > 2.5) => 
-0.0495270629
, 

-0.0048617017
)
;


// Tree: 50

b2_tree_50 := 
map(

( NULL < v1_crtreccnt and v1_crtreccnt <= 4.5) => 
map(

   ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
map(

      ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 119618) => 
map(

         ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 2.5) => 
0.0032120059
, 

         (v1_raacrtrecmmbrcnt > 2.5) => 
map(

            ( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 1.5) => 
0.0301943264
, 

            (v1_prospectcollegeprogramtype > 1.5) => 
-0.0537023049
, 

0.0268137982
)
, 

0.0102935605
)
, 

      (v1_raapropowneravmmed > 119618) => 
-0.0133487744
, 

0.0035846127
)
, 

   (v1_verifiedcurrresmatchindex > 0.5) => 
map(

      ( NULL < v1_hhcrtrecbkrptmmbrcnt24mo and v1_hhcrtrecbkrptmmbrcnt24mo <= 0.5) => 
-0.0386039134
, 

      (v1_hhcrtrecbkrptmmbrcnt24mo > 0.5) => 
0.0538900681
, 

-0.0357987385
)
, 

-0.0070875968
)
, 

(v1_crtreccnt > 4.5) => 
0.0365894929
, 

-0.0033654100
)
;


// Tree: 54

b2_tree_54 := 
map(

( NULL < v1_rescurravmvalue and v1_rescurravmvalue <= 113003.5) => 
map(

   ( NULL < v1_crtreccnt and v1_crtreccnt <= 0.5) => 
map(

      ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
0.0038913795
, 

      (v1_raacollege4yrattendedmmbrcnt > 0.5) => 
-0.0249036697
, 

-0.0008724032
)
, 

   (v1_crtreccnt > 0.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 91.5) => 
map(

         ( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
0.0314023966
, 

         (v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
-0.0225704068
, 

0.0282634153
)
, 

      (v1_crtrectimenewest > 91.5) => 
0.0015888756
, 

0.0210143261
)
, 

0.0057088909
)
, 

(v1_rescurravmvalue > 113003.5) => 
map(

   ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 509.5) => 
-0.0552989674
, 

   (v1_hhcrtreclienjudgamtttl > 509.5) => 
-0.0000301526
, 

-0.0421735461
)
, 

-0.0028319381
)
;


// Tree: 58

b2_tree_58 := 
map(

( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 63353.5) => 
map(

   ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 6.5) => 
map(

      ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 2.5) => 
map(

         ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 3.5) => 
0.0023854712
, 

         (v1_raacrtrecmmbrcnt > 3.5) => 
0.0227620661
, 

0.0049827528
)
, 

      (v1_raapropcurrownermmbrcnt > 2.5) => 
-0.0198100578
, 

-0.0004389059
)
, 

   (v1_raacrtrecmmbrcnt > 6.5) => 
map(

      ( NULL < v1_prospectcollegetier and v1_prospectcollegetier <= 0.5) => 
0.0267435569
, 

      (v1_prospectcollegetier > 0.5) => 
-0.0392321984
, 

0.0228831837
)
, 

0.0044039453
)
, 

(v1_propcurrownedavmttl > 63353.5) => 
map(

   ( NULL < v1_hhcrtrecbkrptmmbrcnt24mo and v1_hhcrtrecbkrptmmbrcnt24mo <= 0.5) => 
-0.0537680709
, 

   (v1_hhcrtrecbkrptmmbrcnt24mo > 0.5) => 
0.0942079315
, 

-0.0500394266
)
, 

-0.0044896468
)
;


// Tree: 62

b2_tree_62 := 
map(

( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
map(

   ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
map(

      ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 125951) => 
map(

         ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 3.5) => 
0.0039452091
, 

         (v1_raacrtrecmmbrcnt > 3.5) => 
0.0216261174
, 

0.0079022102
)
, 

      (v1_raapropowneravmmed > 125951) => 
-0.0148049342
, 

0.0018556040
)
, 

   (v1_crtrecseverityindex > 2.5) => 
0.0267763617
, 

0.0055619344
)
, 

(v1_verifiedcurrresmatchindex > 0.5) => 
map(

   ( NULL < v1_hhcrtrecbkrptmmbrcnt24mo and v1_hhcrtrecbkrptmmbrcnt24mo <= 0.5) => 
map(

      ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 153.5) => 
-0.0430319705
, 

      (v1_hhcrtreclienjudgamtttl > 153.5) => 
-0.0015066143
, 

-0.0307202897
)
, 

   (v1_hhcrtrecbkrptmmbrcnt24mo > 0.5) => 
0.0451363003
, 

-0.0279150313
)
, 

-0.0036474599
)
;


// Tree: 66

b2_tree_66 := 
map(

( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 160544.5) => 
map(

   ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 4.5) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 67010) => 
map(

         ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 5.5) => 
map(

            ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
0.0060639747
, 

            (v1_raacollege4yrattendedmmbrcnt > 0.5) => 
-0.0233327332
, 

0.0033290038
)
, 

         (v1_raacrtrecmmbrcnt > 5.5) => 
map(

            ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 1.5) => 
0.0238776164
, 

            (v1_raacollege4yrattendedmmbrcnt > 1.5) => 
-0.0085784883
, 

0.0187859246
)
, 

0.0064716482
)
, 

      (v1_propcurrownedassessedttl > 67010) => 
-0.0381482543
, 

0.0020048255
)
, 

   (v1_crtrecmsdmeancnt > 4.5) => 
0.0406928747
, 

0.0035645427
)
, 

(v1_raapropowneravmmed > 160544.5) => 
-0.0199975351
, 

-0.0027073568
)
;


// Tree: 70

b2_tree_70 := 
map(

( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 0.885) => 
map(

   ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 1.5) => 
map(

      ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 1.5) => 
map(

         ( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 1.5) => 
map(

            ( NULL < v1_crtreccnt and v1_crtreccnt <= 8.5) => 
map(

               ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 77405) => 
0.0047463943
, 

               (v1_propcurrownedassessedttl > 77405) => 
-0.0368396957
, 

0.0021330892
)
, 

            (v1_crtreccnt > 8.5) => 
0.0350075646
, 

0.0030588183
)
, 

         (v1_prospectcollegeprogramtype > 1.5) => 
-0.0472203148
, 

0.0014883364
)
, 

      (v1_occbusinessassociationtime > 1.5) => 
-0.0340403504
, 

-0.0004896352
)
, 

   (v1_raacrtrecfelonymmbrcnt > 1.5) => 
0.0288415291
, 

0.0015953618
)
, 

(v1_rescurravmcntyratio > 0.885) => 
-0.0352229588
, 

-0.0036197399
)
;


// Tree: 74

b2_tree_74 := 
map(

( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 121665) => 
map(

   ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 2.5) => 
map(

      ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 1.5) => 
map(

            ( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 0.5) => 
0.0076078796
, 

            (v1_raaoccbusinessassocmmbrcnt > 0.5) => 
-0.0067473928
, 

0.0041159913
)
, 

         (v1_raacrtrecfelonymmbrcnt > 1.5) => 
0.0301104477
, 

0.0052994622
)
, 

      (v1_raacollege4yrattendedmmbrcnt > 0.5) => 
-0.0128102528
, 

0.0017860161
)
, 

   (v1_crtrecmsdmeancnt > 2.5) => 
0.0269276995
, 

0.0035717988
)
, 

(v1_hhpropcurravmhighest > 121665) => 
map(

   ( NULL < v1_hhcrtrecbkrptmmbrcnt24mo and v1_hhcrtrecbkrptmmbrcnt24mo <= 0.5) => 
-0.0409378888
, 

   (v1_hhcrtrecbkrptmmbrcnt24mo > 0.5) => 
0.0603517744
, 

-0.0381035272
)
, 

-0.0031294451
)
;


// Tree: 78

b2_tree_78 := 
map(

( NULL < v1_crtreccnt and v1_crtreccnt <= 9.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 105049) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 131.5) => 
map(

         ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 3.5) => 
map(

            (v1_resinputdwelltype in ['-1','0','F','H','S','U']) => 
0.0026707773
, 

            (v1_resinputdwelltype in ['G','P','R']) => 
0.0394060946
, 

0.0045818452
)
, 

         (v1_raacrtrecmmbrcnt > 3.5) => 
0.0193747210
, 

0.0079690368
)
, 

      (v1_prospecttimeonrecord > 131.5) => 
-0.0113468895
, 

0.0044071855
)
, 

   (v1_raapropowneravmmed > 105049) => 
map(

      ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
-0.0187342034
, 

      (v1_crtrecseverityindex > 2.5) => 
0.0052337738
, 

-0.0142748398
)
, 

-0.0025819115
)
, 

(v1_crtreccnt > 9.5) => 
0.0332760788
, 

-0.0014232743
)
;


// Tree: 82

b2_tree_82 := 
map(

( NULL < v1_rescurravmvalue and v1_rescurravmvalue <= 145207) => 
map(

   ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 2.5) => 
map(

      ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 5.5) => 
0.0017699116
, 

         (v1_crtrectimenewest > 5.5) => 
map(

            ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 73.5) => 
0.0217270975
, 

            (v1_crtrectimenewest > 73.5) => 
-0.0017074618
, 

0.0124374980
)
, 

0.0040424424
)
, 

      (v1_raacollege4yrattendedmmbrcnt > 0.5) => 
-0.0146279110
, 

0.0005652904
)
, 

   (v1_raacrtrecevictionmmbrcnt > 2.5) => 
map(

      ( NULL < v1_prospectcollegetier and v1_prospectcollegetier <= 0.5) => 
0.0226256949
, 

      (v1_prospectcollegetier > 0.5) => 
-0.0396372174
, 

0.0194398481
)
, 

0.0024518418
)
, 

(v1_rescurravmvalue > 145207) => 
-0.0300049162
, 

-0.0023973396
)
;


// Tree: 86

b2_tree_86 := 
map(

( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 7.5) => 
map(

      ( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 0.5) => 
0.0057382163
, 

      (v1_raaoccbusinessassocmmbrcnt > 0.5) => 
-0.0105986778
, 

0.0010486210
)
, 

   (v1_crtrectimenewest > 7.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 80.5) => 
0.0214807652
, 

      (v1_crtrectimenewest > 80.5) => 
0.0032131456
, 

0.0145652035
)
, 

0.0042224578
)
, 

(v1_verifiedcurrresmatchindex > 0.5) => 
map(

   ( NULL < v1_hhcrtrecbkrptmmbrcnt24mo and v1_hhcrtrecbkrptmmbrcnt24mo <= 0.5) => 
map(

      ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 370.5) => 
-0.0338114693
, 

      (v1_hhcrtreclienjudgamtttl > 370.5) => 
0.0009814285
, 

-0.0237664119
)
, 

   (v1_hhcrtrecbkrptmmbrcnt24mo > 0.5) => 
0.0477430977
, 

-0.0211203568
)
, 

-0.0027562148
)
;


// Tree: 90

b2_tree_90 := 
map(

( NULL < v1_hhcrtrecfelonymmbrcnt and v1_hhcrtrecfelonymmbrcnt <= 0.5) => 
map(

   ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 69411.5) => 
map(

         ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 7.5) => 
map(

            ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 2.5) => 
map(

               ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
0.0001088703
, 

               (v1_resinputownershipindex > 0.5) => 
0.0143048598
, 

0.0064372959
)
, 

            (v1_raapropcurrownermmbrcnt > 2.5) => 
-0.0107663393
, 

0.0034810543
)
, 

         (v1_raacrtrecmmbrcnt > 7.5) => 
0.0186812472
, 

0.0052002445
)
, 

      (v1_propcurrownedavmttl > 69411.5) => 
-0.0289707714
, 

0.0005475052
)
, 

   (v1_raacollege4yrattendedmmbrcnt > 0.5) => 
-0.0152385696
, 

-0.0029613712
)
, 

(v1_hhcrtrecfelonymmbrcnt > 0.5) => 
0.0316994386
, 

-0.0016864390
)
;


// Tree: 94

b2_tree_94 := 
map(

( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 175.5) => 
map(

      ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

            (v1_resinputdwelltype in ['-1','0','F','H','R','S','U']) => 
0.0000400125
, 

            (v1_resinputdwelltype in ['G','P']) => 
0.0323538967
, 

0.0014465703
)
, 

         (v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0355339894
, 

-0.0016106452
)
, 

      (v1_hhcrtrecmmbrcnt > 0.5) => 
0.0123769309
, 

0.0026770519
)
, 

   (v1_prospecttimeonrecord > 175.5) => 
map(

      ( NULL < v1_hhcrtrecbkrptmmbrcnt24mo and v1_hhcrtrecbkrptmmbrcnt24mo <= 0.5) => 
-0.0189559463
, 

      (v1_hhcrtrecbkrptmmbrcnt24mo > 0.5) => 
0.0470217604
, 

-0.0167858838
)
, 

-0.0008681994
)
, 

(v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
-0.0402784475
, 

-0.0033805224
)
;


// Tree: 98

b2_tree_98 := 
map(

( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 203662.5) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 5.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
map(

         ( NULL < v1_raacollegetoptiermmbrcnt and v1_raacollegetoptiermmbrcnt <= 0.5) => 
0.0027456257
, 

         (v1_raacollegetoptiermmbrcnt > 0.5) => 
-0.0391049430
, 

0.0016420002
)
, 

      (v1_lifeeveverresidedcnt > 1.5) => 
-0.0362550307
, 

-0.0025413608
)
, 

   (v1_crtrectimenewest > 5.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 85.5) => 
0.0169409700
, 

      (v1_crtrectimenewest > 85.5) => 
map(

         ( NULL < v1_prospectlastupdate12mo and v1_prospectlastupdate12mo <= 0.5) => 
0.0015103043
, 

         (v1_prospectlastupdate12mo > 0.5) => 
-0.0594220923
, 

-0.0069443670
)
, 

0.0089060553
)
, 

0.0006334172
)
, 

(v1_raapropowneravmmed > 203662.5) => 
-0.0171085845
, 

-0.0029441374
)
;


// Tree: 102

b2_tree_102 := 
map(

( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 0) => 
map(

   ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 3.5) => 
map(

      ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 52.5) => 
map(

         ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 1.5) => 
map(

            ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0063906236
, 

            (v1_lifeeveverresidedcnt > 0.5) => 
-0.0138304020
, 

0.0026797640
)
, 

         (v1_raapropcurrownermmbrcnt > 1.5) => 
-0.0116984435
, 

-0.0032923661
)
, 

      (v1_hhcrtreclienjudgamtttl > 52.5) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 132.5) => 
0.0169104639
, 

         (v1_crtrectimenewest > 132.5) => 
-0.0206859958
, 

0.0119617569
)
, 

-0.0010824075
)
, 

   (v1_raacrtrecevictionmmbrcnt > 3.5) => 
0.0198145658
, 

0.0000861916
)
, 

(v1_occbusinessassociationtime > 0) => 
-0.0267648041
, 

-0.0020038831
)
;


// Tree: 106

b2_tree_106 := 
map(

( NULL < v1_prospectlastupdate12mo and v1_prospectlastupdate12mo <= 0.5) => 
map(

   ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 2.5) => 
map(

      ( NULL < v1_raacollegetoptiermmbrcnt and v1_raacollegetoptiermmbrcnt <= 0.5) => 
map(

         ( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 1.5) => 
map(

            ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 5.5) => 
0.0011253197
, 

            (v1_raacrtrecmmbrcnt > 5.5) => 
0.0105726708
, 

0.0030816990
)
, 

         (v1_occproflicensecategory > 1.5) => 
-0.0584112292
, 

0.0022647228
)
, 

      (v1_raacollegetoptiermmbrcnt > 0.5) => 
-0.0268264272
, 

0.0007659091
)
, 

   (v1_raacrtrecfelonymmbrcnt > 2.5) => 
0.0260009231
, 

0.0015427894
)
, 

(v1_prospectlastupdate12mo > 0.5) => 
map(

   ( NULL < v1_hhcrtrecbkrptmmbrcnt24mo and v1_hhcrtrecbkrptmmbrcnt24mo <= 0.5) => 
-0.0254469770
, 

   (v1_hhcrtrecbkrptmmbrcnt24mo > 0.5) => 
0.0443497089
, 

-0.0214609020
)
, 

-0.0019877283
)
;


// Tree: 110

b2_tree_110 := 
map(

( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
map(

   ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 1.5) => 
map(

      ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 1.065) => 
map(

         (v1_resinputdwelltype in ['-1','0','F','H','R','S','U']) => 
map(

            ( NULL < v1_hhcrtrecbkrptmmbrcnt24mo and v1_hhcrtrecbkrptmmbrcnt24mo <= 0.5) => 
-0.0002084460
, 

            (v1_hhcrtrecbkrptmmbrcnt24mo > 0.5) => 
0.0391176977
, 

0.0002522771
)
, 

         (v1_resinputdwelltype in ['G','P']) => 
0.0214925465
, 

0.0012013051
)
, 

      (v1_rescurravmcntyratio > 1.065) => 
-0.0297052253
, 

-0.0019508591
)
, 

   (v1_raacollege4yrattendedmmbrcnt > 1.5) => 
-0.0295580217
, 

-0.0039451472
)
, 

(v1_raacrtrecfelonymmbrcnt > 0.5) => 
map(

   ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 105019) => 
0.0148788627
, 

   (v1_resinputavmvalue > 105019) => 
-0.0125046053
, 

0.0101885897
)
, 

-0.0015678888
)
;


// Tree: 114

b2_tree_114 := 
map(

( NULL < v1_crtreccnt and v1_crtreccnt <= 10.5) => 
map(

   ( NULL < v1_hhcrtrecbkrptmmbrcnt24mo and v1_hhcrtrecbkrptmmbrcnt24mo <= 0.5) => 
map(

      ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 99689.5) => 
map(

         ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
0.0043448030
, 

         (v1_hhseniormmbrcnt > 0.5) => 
-0.0199026040
, 

0.0027894180
)
, 

      (v1_raapropowneravmmed > 99689.5) => 
map(

         ( NULL < v1_hhcrtrecevictionmmbrcnt and v1_hhcrtrecevictionmmbrcnt <= 0.5) => 
-0.0121764565
, 

         (v1_hhcrtrecevictionmmbrcnt > 0.5) => 
0.0122824138
, 

-0.0105505361
)
, 

-0.0023471051
)
, 

   (v1_hhcrtrecbkrptmmbrcnt24mo > 0.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 7.5) => 
0.0107291272
, 

      (v1_crtrecbkrpttimenewest > 7.5) => 
0.0656221025
, 

0.0382468222
)
, 

-0.0017627957
)
, 

(v1_crtreccnt > 10.5) => 
0.0248782785
, 

-0.0010316293
)
;


// Tree: 118

b2_tree_118 := 
map(

( NULL < v1_prospectlastupdate12mo and v1_prospectlastupdate12mo <= 0.5) => 
map(

   ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 3.5) => 
map(

      ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 1.5) => 
0.0021737114
, 

      (v1_raacollege4yrattendedmmbrcnt > 1.5) => 
-0.0202558917
, 

0.0006490988
)
, 

   (v1_raacrtrecevictionmmbrcnt > 3.5) => 
0.0169399080
, 

0.0015190717
)
, 

(v1_prospectlastupdate12mo > 0.5) => 
map(

   ( NULL < v1_hhcrtrecmmbrcnt12mo and v1_hhcrtrecmmbrcnt12mo <= 0.5) => 
map(

      ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 1.5) => 
-0.0405135523
, 

      (v1_crtrecbkrptcnt > 1.5) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 69.5) => 
0.1344562073
, 

         (v1_crtrecbkrpttimenewest > 69.5) => 
-0.0725974693
, 

0.0608371223
)
, 

-0.0381953254
)
, 

   (v1_hhcrtrecmmbrcnt12mo > 0.5) => 
0.0068935279
, 

-0.0259153669
)
, 

-0.0026715320
)
;


// Tree: 122

b2_tree_122 := 
map(

( NULL < v1_hhcrtrecfelonymmbrcnt and v1_hhcrtrecfelonymmbrcnt <= 0.5) => 
map(

   ( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 84.5) => 
map(

         ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 732.5) => 
map(

            ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 307129) => 
0.0015003627
, 

            (v1_resinputavmvalue12mo > 307129) => 
0.0278599646
, 

0.0030673194
)
, 

         (v1_raacrtreclienjudgamtmax > 732.5) => 
0.0147224611
, 

0.0050796115
)
, 

      (v1_prospecttimeonrecord > 84.5) => 
-0.0074454569
, 

0.0019115467
)
, 

   (v1_raaoccbusinessassocmmbrcnt > 0.5) => 
map(

      ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 5.5) => 
-0.0161531534
, 

      (v1_raacrtrecmmbrcnt > 5.5) => 
0.0015910175
, 

-0.0084206540
)
, 

-0.0020745593
)
, 

(v1_hhcrtrecfelonymmbrcnt > 0.5) => 
0.0200695167
, 

-0.0012619081
)
;


// Tree: 126

b2_tree_126 := 
map(

( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 7.5) => 
map(

   ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 1.5) => 
map(

      ( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

            ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 0.195) => 
0.0001542330
, 

            (v1_resinputavmcntyratio > 0.195) => 
-0.0299602178
, 

-0.0023705150
)
, 

         (v1_resinputownershipindex > 0.5) => 
map(

            ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 54350.5) => 
0.0103808598
, 

            (v1_propcurrownedassessedttl > 54350.5) => 
-0.0174546434
, 

0.0057369679
)
, 

0.0018305423
)
, 

      (v1_raaoccproflicmmbrcnt > 0.5) => 
-0.0082394074
, 

-0.0004303497
)
, 

   (v1_occbusinessassociationtime > 1.5) => 
-0.0238327300
, 

-0.0022417648
)
, 

(v1_crtrecmsdmeancnt > 7.5) => 
0.0237322866
, 

-0.0017017481
)
;


// Tree: 130

b2_tree_130 := 
map(

( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 3.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 1.5) => 
map(

      ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
map(

            ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
0.0005217261
, 

            (v1_hhcrtrecmmbrcnt > 0.5) => 
0.0085747987
, 

0.0030180015
)
, 

         (v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
-0.0298017802
, 

0.0012860969
)
, 

      (v1_hhseniormmbrcnt > 0.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 9.5) => 
-0.0634399279
, 

         (v1_prospecttimeonrecord > 9.5) => 
-0.0178109302
, 

-0.0210109645
)
, 

-0.0007030020
)
, 

   (v1_hhmiddleagemmbrcnt > 1.5) => 
-0.0228451549
, 

-0.0029384486
)
, 

(v1_hhcrtrecmmbrcnt > 3.5) => 
0.0321996217
, 

-0.0024637094
)
;


// Tree: 134

b2_tree_134 := 
map(

( NULL < v1_occproflicense and v1_occproflicense <= 0.5) => 
map(

   ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 76035) => 
map(

      ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

         (v1_resinputdwelltype in ['-1','0','F','R','S','U']) => 
-0.0101011524
, 

         (v1_resinputdwelltype in ['G','H','P']) => 
0.0048237520
, 

-0.0029323593
)
, 

      (v1_resinputownershipindex > 0.5) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 4.5) => 
map(

            ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 1.5) => 
0.0127969024
, 

            (v1_raapropcurrownermmbrcnt > 1.5) => 
-0.0038435227
, 

0.0048418769
)
, 

         (v1_crtrectimenewest > 4.5) => 
0.0152077917
, 

0.0077061379
)
, 

0.0025631869
)
, 

   (v1_propcurrownedassessedttl > 76035) => 
-0.0257646498
, 

-0.0007016644
)
, 

(v1_occproflicense > 0.5) => 
-0.0375622125
, 

-0.0020787808
)
;


// Tree: 138

b2_tree_138 := 
map(

( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 162.5) => 
map(

   ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 345.5) => 
map(

      ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 2.5) => 
map(

         ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 1.5) => 
map(

            ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
map(

               ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
0.0022404256
, 

               (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0143606613
, 

0.0002954802
)
, 

            (v1_hhseniormmbrcnt > 0.5) => 
-0.0293196064
, 

-0.0019854309
)
, 

         (v1_hhmiddleagemmbrcnt > 1.5) => 
-0.0396535098
, 

-0.0051085829
)
, 

      (v1_raacrtrecfelonymmbrcnt > 2.5) => 
0.0233175237
, 

-0.0043904106
)
, 

   (v1_hhcrtreclienjudgamtttl > 345.5) => 
0.0107941927
, 

-0.0022012520
)
, 

(v1_crtreclienjudgtimenewest > 162.5) => 
-0.0258894317
, 

-0.0026347636
)
;


// Tree: 142

b2_tree_142 := 
map(

( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 9.5) => 
map(

   ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 1.5) => 
map(

         ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 429575) => 
0.0030008844
, 

         (v1_raapropowneravmhighest > 429575) => 
-0.0126014768
, 

0.0016569885
)
, 

      (v1_prospectcollegeprogramtype > 1.5) => 
-0.0381939279
, 

0.0008154048
)
, 

   (v1_raacollege4yrattendedmmbrcnt > 0.5) => 
map(

      ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
-0.0158433644
, 

      (v1_resinputownershipindex > 0.5) => 
map(

         ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 1.5) => 
-0.0057017200
, 

         (v1_crtrecbkrptcnt > 1.5) => 
0.0494053067
, 

-0.0044683259
)
, 

-0.0086190226
)
, 

-0.0012857885
)
, 

(v1_crtrecmsdmeancnt > 9.5) => 
0.0236075733
, 

-0.0009205310
)
;


// Tree: 146

b2_tree_146 := 
map(

( NULL < v1_hhcrtrecbkrptmmbrcnt24mo and v1_hhcrtrecbkrptmmbrcnt24mo <= 0.5) => 
map(

   ( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 128.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 1.5) => 
map(

            ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 65742.5) => 
map(

               (v1_resinputdwelltype in ['-1','0','F','H','R','S','U']) => 
-0.0016833557
, 

               (v1_resinputdwelltype in ['G','P']) => 
0.0337906268
, 

0.0003582918
)
, 

            (v1_resinputavmvalue > 65742.5) => 
0.0216640305
, 

0.0060659899
)
, 

         (v1_raammbrcnt > 1.5) => 
-0.0076982859
, 

0.0006762088
)
, 

      (v1_raacrtreclienjudgamtmax > 128.5) => 
0.0088736209
, 

0.0027735400
)
, 

   (v1_raaoccbusinessassocmmbrcnt > 0.5) => 
-0.0065763846
, 

-0.0008467475
)
, 

(v1_hhcrtrecbkrptmmbrcnt24mo > 0.5) => 
0.0287200125
, 

-0.0003883389
)
;


// Tree: 150

b2_tree_150 := 
map(

( NULL < v1_prospectlastupdate12mo and v1_prospectlastupdate12mo <= 0.5) => 
map(

   ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 4.5) => 
map(

      ( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 49990) => 
0.0018105090
, 

      (v1_rescurrmortgageamount > 49990) => 
-0.0405451271
, 

0.0000091440
)
, 

   (v1_raacrtrecevictionmmbrcnt > 4.5) => 
0.0194000565
, 

0.0006332478
)
, 

(v1_prospectlastupdate12mo > 0.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 2.5) => 
-0.0222155130
, 

   (v1_crtrecbkrpttimenewest > 2.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 65.5) => 
map(

         ( NULL < v1_propcurrowner and v1_propcurrowner <= 0.5) => 
0.0179661150
, 

         (v1_propcurrowner > 0.5) => 
0.1090788566
, 

0.0646525402
)
, 

      (v1_crtrecbkrpttimenewest > 65.5) => 
-0.0327699659
, 

0.0165715284
)
, 

-0.0167569752
)
, 

-0.0020261221
)
;


// Tree: 154

b2_tree_154 := 
map(

( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 1.5) => 
map(

   ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 2.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 2.5) => 
0.0047305267
, 

      (v1_raammbrcnt > 2.5) => 
map(

         ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
map(

            ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 2.5) => 
-0.0083675906
, 

            (v1_crtrecbkrpttimenewest > 2.5) => 
0.0221357280
, 

-0.0067254333
)
, 

         (v1_crtrecseverityindex > 2.5) => 
map(

            ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 92.5) => 
0.0127506292
, 

            (v1_crtrectimenewest > 92.5) => 
-0.0137237777
, 

0.0057606741
)
, 

-0.0042374164
)
, 

-0.0009477943
)
, 

   (v1_raacrtrecevictionmmbrcnt > 2.5) => 
0.0090185272
, 

-0.0000045612
)
, 

(v1_occproflicensecategory > 1.5) => 
-0.0532508461
, 

-0.0011844265
)
;


// Tree: 158

b2_tree_158 := 
map(

( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 0.5) => 
map(

   ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
map(

      (v1_resinputdwelltype in ['-1','0','F','H','R','S','U']) => 
map(

         ( NULL < v1_hhcrtrecevictionmmbrcnt and v1_hhcrtrecevictionmmbrcnt <= 0.5) => 
-0.0017148156
, 

         (v1_hhcrtrecevictionmmbrcnt > 0.5) => 
0.0496043550
, 

-0.0012263154
)
, 

      (v1_resinputdwelltype in ['G','P']) => 
0.0172551169
, 

-0.0003464265
)
, 

   (v1_crtrecseverityindex > 2.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 178.5) => 
0.0105026737
, 

      (v1_crtrectimenewest > 178.5) => 
-0.0239963648
, 

0.0084721952
)
, 

0.0010567724
)
, 

(v1_rescurrbusinesscnt > 0.5) => 
map(

   ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 0.5) => 
-0.0286267649
, 

   (v1_rescurrownershipindex > 0.5) => 
-0.0066639016
, 

-0.0101595911
)
, 

-0.0009088658
)
;


// Tree: 162

b2_tree_162 := 
map(

( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 198.5) => 
map(

   ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 3.5) => 
map(

      ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

         ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 0.455) => 
-0.0003858516
, 

         (v1_resinputavmblockratio > 0.455) => 
map(

            ( NULL < v1_raahhcnt and v1_raahhcnt <= 0.5) => 
0.0170308271
, 

            (v1_raahhcnt > 0.5) => 
-0.0376721912
, 

-0.0234024289
)
, 

-0.0025048514
)
, 

      (v1_resinputownershipindex > 0.5) => 
0.0074892664
, 

0.0024991915
)
, 

   (v1_raapropcurrownermmbrcnt > 3.5) => 
map(

      ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 8.5) => 
-0.0134279022
, 

      (v1_raacrtrecmmbrcnt > 8.5) => 
0.0029812448
, 

-0.0076918878
)
, 

-0.0004083964
)
, 

(v1_crtreclienjudgtimenewest > 198.5) => 
-0.0340894354
, 

-0.0007519972
)
;


// Tree: 166

b2_tree_166 := 
map(

( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
map(

   ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 4.5) => 
0.0015215442
, 

   (v1_raacrtrecevictionmmbrcnt > 4.5) => 
map(

      ( NULL < v1_prospectcollegeattended and v1_prospectcollegeattended <= 0.5) => 
0.0248725340
, 

      (v1_prospectcollegeattended > 0.5) => 
-0.0159946123
, 

0.0181677185
)
, 

0.0021209162
)
, 

(v1_verifiedcurrresmatchindex > 0.5) => 
map(

   ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 1.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 65.5) => 
0.0096934753
, 

      (v1_prospecttimeonrecord > 65.5) => 
map(

         ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 0.5) => 
-0.0300694979
, 

         (v1_rescurrownershipindex > 0.5) => 
-0.0127157410
, 

-0.0157398601
)
, 

-0.0111006420
)
, 

   (v1_crtrecbkrptcnt > 1.5) => 
0.0329788902
, 

-0.0099320477
)
, 

-0.0011961732
)
;


// Tree: 170

b2_tree_170 := 
map(

( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
0.0008071977
, 

      (v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0301026638
, 

-0.0028235726
)
, 

   (v1_hhcrtrecmmbrcnt > 0.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 62.5) => 
map(

         ( NULL < v1_hhcrtrecbkrptmmbrcnt and v1_hhcrtrecbkrptmmbrcnt <= 1.5) => 
map(

            ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 216008) => 
0.0095737742
, 

            (v1_raapropowneravmmed > 216008) => 
-0.0093423098
, 

0.0060952295
)
, 

         (v1_hhcrtrecbkrptmmbrcnt > 1.5) => 
0.0410671801
, 

0.0076753639
)
, 

      (v1_crtrecbkrpttimenewest > 62.5) => 
-0.0128606688
, 

0.0054293143
)
, 

-0.0000292972
)
, 

(v1_raacollege4yrattendedmmbrcnt > 0.5) => 
-0.0079358938
, 

-0.0018097842
)
;


// Tree: 174

b2_tree_174 := 
map(

( NULL < v1_raacollegetoptiermmbrcnt and v1_raacollegetoptiermmbrcnt <= 0.5) => 
map(

   ( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 72498.5) => 
map(

      ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

         ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 0.235) => 
map(

            (v1_resinputdwelltype in ['-1','0','F','R','S','U']) => 
-0.0053232010
, 

            (v1_resinputdwelltype in ['G','H','P']) => 
0.0034668735
, 

-0.0008330573
)
, 

         (v1_resinputavmcntyratio > 0.235) => 
map(

            ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 1.5) => 
0.0136184184
, 

            (v1_raammbrcnt > 1.5) => 
-0.0351685149
, 

-0.0226389063
)
, 

-0.0025253124
)
, 

      (v1_resinputownershipindex > 0.5) => 
0.0058073929
, 

0.0019120853
)
, 

   (v1_rescurrmortgageamount > 72498.5) => 
-0.0342868318
, 

-0.0002032299
)
, 

(v1_raacollegetoptiermmbrcnt > 0.5) => 
-0.0192080900
, 

-0.0013563875
)
;


// Tree: 178

b2_tree_178 := 
map(

( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
map(

   ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 80.5) => 
map(

      ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 1.5) => 
0.0025548968
, 

         (v1_raapropcurrownermmbrcnt > 1.5) => 
-0.0065936552
, 

-0.0006814677
)
, 

      (v1_raacrtrecfelonymmbrcnt > 0.5) => 
0.0076931370
, 

0.0004555285
)
, 

   (v1_hhcrtreclienjudgamtttl > 80.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0560718537
, 

      (v1_lifeeveverresidedcnt > 0.5) => 
0.0091934243
, 

0.0117925719
)
, 

0.0016016362
)
, 

(v1_lifeeveverresidedcnt > 1.5) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
0.0071962104
, 

   (v1_hhcnt > 1.5) => 
-0.0136923779
, 

-0.0090682533
)
, 

-0.0007641303
)
;


// Tree: 182

b2_tree_182 := 
map(

( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 2.5) => 
map(

   ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 1.5) => 
map(

      ( NULL < v1_prospectlastupdate12mo and v1_prospectlastupdate12mo <= 0.5) => 
map(

         ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 3.5) => 
-0.0007763824
, 

         (v1_raacrtrecmmbrcnt > 3.5) => 
map(

            ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 0.565) => 
0.0096504653
, 

            (v1_resinputavmcntyratio > 0.565) => 
-0.0050190890
, 

0.0053467641
)
, 

0.0013005949
)
, 

      (v1_prospectlastupdate12mo > 0.5) => 
-0.0120192914
, 

-0.0006473488
)
, 

   (v1_crtrecbkrptcnt > 1.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 0.5) => 
0.0708974662
, 

      (v1_prospecttimelastupdate > 0.5) => 
0.0105316782
, 

0.0249301743
)
, 

-0.0003007410
)
, 

(v1_raacollege4yrattendedmmbrcnt > 2.5) => 
-0.0234414898
, 

-0.0010798376
)
;


// Tree: 186

b2_tree_186 := 
map(

( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 9.5) => 
map(

   ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

      ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 21917) => 
map(

         ( NULL < v1_crtrecevictioncnt and v1_crtrecevictioncnt <= 4.5) => 
-0.0011068899
, 

         (v1_crtrecevictioncnt > 4.5) => 
-0.0370255477
, 

-0.0015205652
)
, 

      (v1_resinputavmvalue > 21917) => 
-0.0258404852
, 

-0.0036044261
)
, 

   (v1_resinputownershipindex > 0.5) => 
map(

      ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 66106) => 
0.0088537829
, 

      (v1_raapropowneravmmed > 66106) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 4.5) => 
-0.0034782773
, 

         (v1_crtrecbkrpttimenewest > 4.5) => 
0.0174216844
, 

-0.0015681633
)
, 

0.0030030267
)
, 

0.0001166438
)
, 

(v1_crtrecmsdmeancnt > 9.5) => 
0.0215498143
, 

0.0004342441
)
;


// Tree: 190

b2_tree_190 := 
map(

( NULL < v1_hhoccproflicmmbrcnt and v1_hhoccproflicmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 8.5) => 
map(

      ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 1.5) => 
map(

         ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
map(

            ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 93.5) => 
0.0011351930
, 

            (v1_prospecttimelastupdate > 93.5) => 
0.0206270391
, 

0.0020627327
)
, 

         (v1_hhseniormmbrcnt > 0.5) => 
-0.0149392251
, 

0.0006990448
)
, 

      (v1_hhmiddleagemmbrcnt > 1.5) => 
map(

         ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0519042436
, 

         (v1_lifeeveverresidedcnt > 0.5) => 
-0.0223357184
, 

-0.0194159622
)
, 

-0.0010720968
)
, 

   (v1_hhcnt > 8.5) => 
0.0289936438
, 

-0.0005591111
)
, 

(v1_hhoccproflicmmbrcnt > 0.5) => 
-0.0220153384
, 

-0.0018687164
)
;


// Tree: 194

b2_tree_194 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

   ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 1.5) => 
map(

      ( NULL < v1_occbusinessassociation and v1_occbusinessassociation <= 0.5) => 
map(

         ( NULL < v1_hhcollegetiermmbrhighest and v1_hhcollegetiermmbrhighest <= 0.5) => 
map(

            ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
map(

               ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 3.5) => 
0.0021736738
, 

               (v1_raapropcurrownermmbrcnt > 3.5) => 
-0.0110784328
, 

0.0000264960
)
, 

            (v1_hhcrtrecmmbrcnt > 0.5) => 
0.0055529544
, 

0.0019052312
)
, 

         (v1_hhcollegetiermmbrhighest > 0.5) => 
-0.0147244523
, 

0.0008721806
)
, 

      (v1_occbusinessassociation > 0.5) => 
-0.0153677555
, 

-0.0002593406
)
, 

   (v1_raacollege4yrattendedmmbrcnt > 1.5) => 
-0.0139332746
, 

-0.0014254793
)
, 

(v1_prospectdeceased > 0.5) => 
0.1375545429
, 

-0.0012992888
)
;


// Tree: 198

b2_tree_198 := 
map(

( NULL < v1_occproflicense and v1_occproflicense <= 0.5) => 
map(

   ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 198.5) => 
map(

      ( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 63869.5) => 
map(

         ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

            ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 0.235) => 
-0.0005170174
, 

            (v1_resinputavmcntyratio > 0.235) => 
map(

               ( NULL < v1_raahhcnt and v1_raahhcnt <= 0.5) => 
0.0146693633
, 

               (v1_raahhcnt > 0.5) => 
-0.0319910108
, 

-0.0212667849
)
, 

-0.0021975992
)
, 

         (v1_resinputownershipindex > 0.5) => 
0.0047291809
, 

0.0014898419
)
, 

      (v1_rescurrmortgageamount > 63869.5) => 
-0.0297648042
, 

-0.0003898153
)
, 

   (v1_crtreclienjudgtimenewest > 198.5) => 
-0.0250646967
, 

-0.0006453512
)
, 

(v1_occproflicense > 0.5) => 
-0.0248878478
, 

-0.0015454788
)
;


// Tree: 202

b2_tree_202 := 
map(

( NULL < v1_hhcrtrecfelonymmbrcnt and v1_hhcrtrecfelonymmbrcnt <= 0.5) => 
map(

   ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 1.5) => 
map(

      ( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 1.5) => 
map(

         ( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 75.5) => 
map(

            ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 8.5) => 
map(

               ( NULL < v1_hhcrtrecevictionmmbrcnt and v1_hhcrtrecevictionmmbrcnt <= 0.5) => 
-0.0010397972
, 

               (v1_hhcrtrecevictionmmbrcnt > 0.5) => 
0.0134662884
, 

-0.0004871038
)
, 

            (v1_raacrtrecmmbrcnt > 8.5) => 
0.0076051566
, 

0.0003898635
)
, 

         (v1_crtrecevictiontimenewest > 75.5) => 
-0.0132664256
, 

0.0000870540
)
, 

      (v1_occproflicensecategory > 1.5) => 
-0.0467473629
, 

-0.0008384487
)
, 

   (v1_raacollege4yrattendedmmbrcnt > 1.5) => 
-0.0133335162
, 

-0.0018821466
)
, 

(v1_hhcrtrecfelonymmbrcnt > 0.5) => 
0.0123326613
, 

-0.0013631252
)
;


// Tree: 206

b2_tree_206 := 
map(

( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 8.5) => 
map(

   ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 159.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 110.5) => 
map(

         ( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 0.5) => 
map(

            ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
-0.0023389499
, 

            (v1_resinputownershipindex > 0.5) => 
0.0042463271
, 

0.0010960273
)
, 

         (v1_raaoccproflicmmbrcnt > 0.5) => 
-0.0071615416
, 

-0.0008560056
)
, 

      (v1_prospecttimelastupdate > 110.5) => 
0.0149133833
, 

-0.0001565109
)
, 

   (v1_crtreclienjudgtimenewest > 159.5) => 
map(

      ( NULL < v1_crtreclienjudgcnt and v1_crtreclienjudgcnt <= 2.5) => 
-0.0120568128
, 

      (v1_crtreclienjudgcnt > 2.5) => 
-0.0699849123
, 

-0.0196735682
)
, 

-0.0005210894
)
, 

(v1_crtrecmsdmeancnt > 8.5) => 
0.0164928951
, 

-0.0002234525
)
;


// Tree: 210

b2_tree_210 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

   ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

      (v1_resinputdwelltype in ['-1','0','F','S','U']) => 
-0.0087472303
, 

      (v1_resinputdwelltype in ['G','H','P','R']) => 
0.0018782180
, 

-0.0035802616
)
, 

   (v1_resinputownershipindex > 0.5) => 
map(

      ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 67578) => 
map(

         ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 81853.5) => 
map(

            ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 1910) => 
0.0063102279
, 

            (v1_propcurrownedassessedttl > 1910) => 
0.0396610305
, 

0.0105880194
)
, 

         (v1_propcurrownedassessedttl > 81853.5) => 
-0.0230558776
, 

0.0066303385
)
, 

      (v1_resinputavmvalue > 67578) => 
-0.0022519127
, 

0.0016054181
)
, 

-0.0006581852
)
, 

(v1_prospectdeceased > 0.5) => 
0.1130160517
, 

-0.0005572654
)
;


// Tree: 214

b2_tree_214 := 
map(

( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 135.5) => 
map(

   ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 3.5) => 
map(

      ( NULL < v1_hhcollegetiermmbrhighest and v1_hhcollegetiermmbrhighest <= 0.5) => 
map(

         ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 11.5) => 
-0.0005258119
, 

         (v1_crtreclienjudgtimenewest > 11.5) => 
map(

            ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 28.5) => 
-0.0123074550
, 

            (v1_lifeevtimelastmove > 28.5) => 
0.0111062059
, 

0.0075591130
)
, 

0.0002819740
)
, 

      (v1_hhcollegetiermmbrhighest > 0.5) => 
-0.0157382210
, 

-0.0009868581
)
, 

   (v1_hhcrtrecmmbrcnt > 3.5) => 
0.0221657553
, 

-0.0007015008
)
, 

(v1_crtrectimenewest > 135.5) => 
map(

   ( NULL < v1_crtreclienjudgcnt and v1_crtreclienjudgcnt <= 2.5) => 
-0.0114893885
, 

   (v1_crtreclienjudgcnt > 2.5) => 
-0.0525289364
, 

-0.0139889597
)
, 

-0.0013723511
)
;


// Tree: 218

b2_tree_218 := 
map(

( NULL < v1_prospectlastupdate12mo and v1_prospectlastupdate12mo <= 0.5) => 
0.0009586580
, 

(v1_prospectlastupdate12mo > 0.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 4.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0618688470
, 

      (v1_lifeeveverresidedcnt > 0.5) => 
-0.0182727186
, 

-0.0168410993
)
, 

   (v1_crtrecbkrpttimenewest > 4.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 49.5) => 
map(

         ( NULL < v1_propcurrowner and v1_propcurrowner <= 0.5) => 
map(

            ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 522.5) => 
0.0581251773
, 

            (v1_crtreclienjudgamtttl > 522.5) => 
-0.0177467887
, 

0.0226209881
)
, 

         (v1_propcurrowner > 0.5) => 
0.1085941281
, 

0.0674956301
)
, 

      (v1_crtrecbkrpttimenewest > 49.5) => 
-0.0224592435
, 

0.0131300963
)
, 

-0.0129353814
)
, 

-0.0011706617
)
;


// Tree: 222

b2_tree_222 := 
map(

( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 1.5) => 
map(

   ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 19.5) => 
map(

      ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 5.5) => 
map(

         ( NULL < v1_prospectlastupdate12mo and v1_prospectlastupdate12mo <= 0.5) => 
0.0008028663
, 

         (v1_prospectlastupdate12mo > 0.5) => 
map(

            ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 17.5) => 
0.0157659262
, 

            (v1_prospecttimeonrecord > 17.5) => 
-0.0171168309
, 

-0.0138436720
)
, 

-0.0014056729
)
, 

      (v1_raacrtrecevictionmmbrcnt > 5.5) => 
0.0161579176
, 

-0.0010437274
)
, 

   (v1_resinputbusinesscnt > 19.5) => 
-0.0312579160
, 

-0.0013882255
)
, 

(v1_crtrecbkrptcnt > 1.5) => 
map(

   ( NULL < v1_propcurrowner and v1_propcurrowner <= 0.5) => 
0.0047416383
, 

   (v1_propcurrowner > 0.5) => 
0.0564552548
, 

0.0261120137
)
, 

-0.0010044713
)
;


// Tree: 226

b2_tree_226 := 
map(

( NULL < v1_hhcrtrecfelonymmbrcnt and v1_hhcrtrecfelonymmbrcnt <= 0.5) => 
map(

   ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

      (v1_resinputdwelltype in ['-1','0','F','R','S','U']) => 
-0.0081450565
, 

      (v1_resinputdwelltype in ['G','H','P']) => 
0.0008654662
, 

-0.0038108020
)
, 

   (v1_resinputownershipindex > 0.5) => 
map(

      ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 89098.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 19.5) => 
0.0036451385
, 

         (v1_raammbrcnt > 19.5) => 
0.0206460758
, 

0.0055072518
)
, 

      (v1_resinputavmvalue > 89098.5) => 
-0.0030041021
, 

0.0011004140
)
, 

-0.0010367959
)
, 

(v1_hhcrtrecfelonymmbrcnt > 0.5) => 
map(

   ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 172.5) => 
0.0151739852
, 

   (v1_crtrecmsdmeantimenewest > 172.5) => 
-0.0341652747
, 

0.0117075140
)
, 

-0.0005661178
)
;


// Tree: 230

b2_tree_230 := 
map(

( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 67.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 7.5) => 
map(

      ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 13.5) => 
map(

         ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
-0.0010034642
, 

         (v1_hhseniormmbrcnt > 0.5) => 
-0.0296397326
, 

-0.0029927342
)
, 

      (v1_hhcrtreclienjudgamtttl > 13.5) => 
0.0068603679
, 

-0.0015857430
)
, 

   (v1_crtrecbkrpttimenewest > 7.5) => 
map(

      ( NULL < v1_propcurrowner and v1_propcurrowner <= 0.5) => 
map(

         ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 1.5) => 
0.0488379350
, 

         (v1_crtrecseverityindex > 1.5) => 
-0.0242292983
, 

0.0039666724
)
, 

      (v1_propcurrowner > 0.5) => 
0.0875022188
, 

0.0399707092
)
, 

-0.0006391252
)
, 

(v1_crtrecbkrpttimenewest > 67.5) => 
-0.0131388314
, 

-0.0011678068
)
;


// Tree: 234

b2_tree_234 := 
map(

( NULL < v1_crtrecevictioncnt and v1_crtrecevictioncnt <= 5.5) => 
map(

   ( NULL < v1_hhcrtrecevictionmmbrcnt and v1_hhcrtrecevictionmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 4.5) => 
-0.0014280854
, 

      (v1_crtrecbkrpttimenewest > 4.5) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 36.5) => 
0.0487132328
, 

         (v1_crtrecbkrpttimenewest > 36.5) => 
-0.0009436908
, 

0.0085818496
)
, 

-0.0008569561
)
, 

   (v1_hhcrtrecevictionmmbrcnt > 0.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 8.5) => 
map(

         ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
0.0146801913
, 

         (v1_prospectcollegeattending > 0.5) => 
-0.0738081305
, 

0.0133781055
)
, 

      (v1_crtrecbkrpttimenewest > 8.5) => 
-0.0134127098
, 

0.0092422734
)
, 

-0.0001349936
)
, 

(v1_crtrecevictioncnt > 5.5) => 
-0.0267112739
, 

-0.0003071253
)
;


// Tree: 238

b2_tree_238 := 
map(

( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 0) => 
map(

   ( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 0.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 128.5) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 1052728.5) => 
0.0017083526
, 

         (v1_raapropowneravmmed > 1052728.5) => 
0.0841281228
, 

0.0018885468
)
, 

      (v1_prospecttimeonrecord > 128.5) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
0.0084110551
, 

         (v1_hhcnt > 1.5) => 
map(

            ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0393871873
, 

            (v1_lifeeveverresidedcnt > 0.5) => 
-0.0140762527
, 

-0.0127103121
)
, 

-0.0083012857
)
, 

-0.0004967900
)
, 

   (v1_hhelderlymmbrcnt > 0.5) => 
0.0194150062
, 

0.0002676543
)
, 

(v1_occbusinessassociationtime > 0) => 
-0.0143058054
, 

-0.0008652698
)
;


// Tree: 242

b2_tree_242 := 
map(

( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 1.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 1.5) => 
map(

      ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
0.0027308474
, 

      (v1_hhseniormmbrcnt > 0.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 8.5) => 
-0.0464853207
, 

         (v1_prospecttimeonrecord > 8.5) => 
-0.0074781462
, 

-0.0101233318
)
, 

0.0015402444
)
, 

   (v1_hhmiddleagemmbrcnt > 1.5) => 
map(

      ( NULL < v1_hhcrtrecbkrptmmbrcnt and v1_hhcrtrecbkrptmmbrcnt <= 1.5) => 
-0.0208897615
, 

      (v1_hhcrtrecbkrptmmbrcnt > 1.5) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 59.5) => 
0.0381932183
, 

         (v1_crtrecbkrpttimenewest > 59.5) => 
-0.0111672593
, 

0.0130581041
)
, 

-0.0159740577
)
, 

-0.0003658997
)
, 

(v1_hhyoungadultmmbrcnt > 1.5) => 
-0.0245090814
, 

-0.0010287060
)
;


// Tree: 246

b2_tree_246 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

   ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 159.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 7.5) => 
map(

         (v1_resinputdwelltype in ['-1','F','H','R','S','U']) => 
-0.0020706131
, 

         (v1_resinputdwelltype in ['0','G','P']) => 
0.0141130338
, 

-0.0013933257
)
, 

      (v1_crtrectimenewest > 7.5) => 
map(

         ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 214.5) => 
-0.0021406517
, 

         (v1_raacrtreclienjudgamtmax > 214.5) => 
0.0079238321
, 

0.0040588428
)
, 

0.0000366773
)
, 

   (v1_crtreclienjudgtimenewest > 159.5) => 
map(

      ( NULL < v1_crtreclienjudgcnt and v1_crtreclienjudgcnt <= 2.5) => 
-0.0103678205
, 

      (v1_crtreclienjudgcnt > 2.5) => 
-0.0630124272
, 

-0.0170888917
)
, 

-0.0002840946
)
, 

(v1_prospectdeceased > 0.5) => 
0.0962599384
, 

-0.0001902014
)
;


// Tree: 250

b2_tree_250 := 
map(

( NULL < v1_hhcnt and v1_hhcnt <= 7.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 1.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 111.5) => 
map(

         ( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 0.5) => 
0.0015674326
, 

         (v1_raaoccproflicmmbrcnt > 0.5) => 
-0.0055818366
, 

-0.0000350673
)
, 

      (v1_prospecttimelastupdate > 111.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 10.5) => 
0.0038560409
, 

         (v1_raammbrcnt > 10.5) => 
0.0323012313
, 

0.0140027768
)
, 

0.0005326962
)
, 

   (v1_hhmiddleagemmbrcnt > 1.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0439515234
, 

      (v1_lifeeveverresidedcnt > 0.5) => 
-0.0191262546
, 

-0.0168403563
)
, 

-0.0011482453
)
, 

(v1_hhcnt > 7.5) => 
0.0166285565
, 

-0.0006185367
)
;


// Tree: 254

b2_tree_254 := 
map(

( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 172.5) => 
map(

   ( NULL < v1_crtrecfelonycnt and v1_crtrecfelonycnt <= 1.5) => 
map(

      ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 3.5) => 
map(

         ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 13.5) => 
map(

            ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 1.5) => 
0.0038058727
, 

            (v1_raammbrcnt > 1.5) => 
map(

               ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 1.5) => 
-0.0101881511
, 

               (v1_raacrtrecmmbrcnt > 1.5) => 
-0.0002289216
, 

-0.0027310231
)
, 

-0.0008165581
)
, 

         (v1_crtrecmsdmeancnt > 13.5) => 
0.0266570471
, 

-0.0006719815
)
, 

      (v1_hhcrtrecmmbrcnt > 3.5) => 
0.0192838704
, 

-0.0004233496
)
, 

   (v1_crtrecfelonycnt > 1.5) => 
0.0189455172
, 

-0.0002055550
)
, 

(v1_crtreclienjudgtimenewest > 172.5) => 
-0.0191721733
, 

-0.0005081129
)
;


// Tree: 258

b2_tree_258 := 
map(

( NULL < v1_hhcrtrecfelonymmbrcnt and v1_hhcrtrecfelonymmbrcnt <= 0.5) => 
map(

   ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 2.5) => 
map(

      ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 18.5) => 
map(

         ( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 2.5) => 
0.0002609152
, 

         (v1_occproflicensecategory > 2.5) => 
-0.0667852673
, 

-0.0006046466
)
, 

      (v1_resinputbusinesscnt > 18.5) => 
-0.0260722020
, 

-0.0009078804
)
, 

   (v1_raacollege4yrattendedmmbrcnt > 2.5) => 
-0.0206500432
, 

-0.0015692662
)
, 

(v1_hhcrtrecfelonymmbrcnt > 0.5) => 
map(

   ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 125014.5) => 
map(

      ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 72.5) => 
0.0203370665
, 

      (v1_crtrecmsdmeantimenewest > 72.5) => 
-0.0035098717
, 

0.0145585057
)
, 

   (v1_resinputavmvalue12mo > 125014.5) => 
-0.0286615771
, 

0.0109283229
)
, 

-0.0011105243
)
;


// Tree: 262

b2_tree_262 := 
map(

( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 172.5) => 
map(

   ( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 0.5) => 
0.0018729864
, 

   (v1_raaoccproflicmmbrcnt > 0.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 23.5) => 
map(

         ( NULL < v1_crtrecfelonycnt and v1_crtrecfelonycnt <= 0.5) => 
-0.0102056208
, 

         (v1_crtrecfelonycnt > 0.5) => 
0.0264679740
, 

-0.0091938130
)
, 

      (v1_prospecttimelastupdate > 23.5) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
0.0200377297
, 

         (v1_hhcnt > 1.5) => 
-0.0022297202
, 

0.0028015533
)
, 

-0.0052198792
)
, 

0.0001661452
)
, 

(v1_crtreclienjudgtimenewest > 172.5) => 
map(

   ( NULL < v1_crtreclienjudgcnt and v1_crtreclienjudgcnt <= 1.5) => 
-0.0051407301
, 

   (v1_crtreclienjudgcnt > 1.5) => 
-0.0500675158
, 

-0.0192725208
)
, 

-0.0001373535
)
;


// Tree: 266

b2_tree_266 := 
map(

( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 10.5) => 
map(

   ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

      ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 0.5) => 
map(

         ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 0.255) => 
0.0006748594
, 

         (v1_resinputavmcntyratio > 0.255) => 
-0.0198361786
, 

-0.0004656480
)
, 

      (v1_resinputbusinesscnt > 0.5) => 
-0.0119628855
, 

-0.0026561363
)
, 

   (v1_resinputownershipindex > 0.5) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 111757.5) => 
map(

         ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 150) => 
0.0020761702
, 

         (v1_propcurrownedassessedttl > 150) => 
0.0212744147
, 

0.0043048800
)
, 

      (v1_propcurrownedassessedttl > 111757.5) => 
-0.0180877054
, 

0.0009066309
)
, 

-0.0006473155
)
, 

(v1_raacrtrecevictionmmbrcnt > 10.5) => 
0.0381492729
, 

-0.0005525957
)
;


// Tree: 270

b2_tree_270 := 
map(

( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 75.5) => 
map(

   ( NULL < v1_hhcrtrecevictionmmbrcnt and v1_hhcrtrecevictionmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 1.5) => 
-0.0002161191
, 

      (v1_crtrecbkrptcnt > 1.5) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 0.5) => 
0.0640777249
, 

         (v1_prospecttimelastupdate > 0.5) => 
0.0073643470
, 

0.0211068701
)
, 

0.0000176242
)
, 

   (v1_hhcrtrecevictionmmbrcnt > 0.5) => 
map(

      ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 3.5) => 
0.0168927979
, 

      (v1_raacrtrecevictionmmbrcnt > 3.5) => 
-0.0092858923
, 

0.0105060132
)
, 

0.0005913338
)
, 

(v1_crtrecevictiontimenewest > 75.5) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 11.5) => 
-0.0256158545
, 

   (v1_raammbrcnt > 11.5) => 
0.0002552428
, 

-0.0126781731
)
, 

0.0002665627
)
;


// Tree: 274

b2_tree_274 := 
map(

( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 0.5) => 
map(

   ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 1.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 91.5) => 
map(

         ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 2.525) => 
-0.0009912910
, 

         (v1_resinputavmcntyratio > 2.525) => 
0.0259754755
, 

-0.0006048352
)
, 

      (v1_prospecttimelastupdate > 91.5) => 
0.0107048440
, 

0.0000185749
)
, 

   (v1_verifiedcurrresmatchindex > 1.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 21.5) => 
0.0184021013
, 

      (v1_prospecttimeonrecord > 21.5) => 
map(

         ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
-0.0160931767
, 

         (v1_lifeevtimefirstassetpurchase > -0.5) => 
-0.0099252903
, 

-0.0118902741
)
, 

-0.0098574118
)
, 

-0.0021936956
)
, 

(v1_hhelderlymmbrcnt > 0.5) => 
0.0155261295
, 

-0.0014938524
)
;


// Tree: 278

b2_tree_278 := 
map(

( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 1.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 1.5) => 
0.0010380867
, 

   (v1_hhmiddleagemmbrcnt > 1.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0377821766
, 

      (v1_lifeeveverresidedcnt > 0.5) => 
map(

         ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 13825) => 
-0.0257948506
, 

         (v1_hhpropcurravmhighest > 13825) => 
-0.0055650732
, 

-0.0123188032
)
, 

-0.0105094997
)
, 

-0.0002108153
)
, 

(v1_hhyoungadultmmbrcnt > 1.5) => 
map(

   ( NULL < v1_raahhcnt and v1_raahhcnt <= 0.5) => 
0.0467973597
, 

   (v1_raahhcnt > 0.5) => 
map(

      ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
-0.0496871864
, 

      (v1_hhpropcurrownermmbrcnt > 0.5) => 
-0.0200952947
, 

-0.0268921527
)
, 

-0.0202047973
)
, 

-0.0007656030
)
;


// Tree: 282

b2_tree_282 := 
map(

( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.755) => 
map(

   ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 19.5) => 
map(

      ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 47.5) => 
map(

         ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 4.5) => 
map(

            ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
-0.0027232384
, 

            (v1_resinputownershipindex > 0.5) => 
0.0017024918
, 

-0.0002533271
)
, 

         (v1_crtrecseverityindex > 4.5) => 
map(

            ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 196.5) => 
0.0154035394
, 

            (v1_crtrecfelonytimenewest > 196.5) => 
-0.0156524040
, 

0.0103349998
)
, 

0.0000075494
)
, 

      (v1_raacrtrecmsdmeanmmbrcnt > 47.5) => 
-0.0855654851
, 

-0.0000297977
)
, 

   (v1_resinputbusinesscnt > 19.5) => 
-0.0221847669
, 

-0.0002907934
)
, 

(v1_resinputavmratiodiff12mo > 1.755) => 
0.0174382545
, 

0.0000204258
)
;


// Tree: 286

b2_tree_286 := 
map(

( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.185) => 
map(

   ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= -0.5) => 
-0.1023538235
, 

   (v1_resinputownershipindex > -0.5) => 
map(

      ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 1.5) => 
-0.0000397547
, 

      (v1_hhseniormmbrcnt > 1.5) => 
map(

         ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
-0.0533952987
, 

         (v1_hhpropcurrownermmbrcnt > 0.5) => 
-0.0191994628
, 

-0.0245389097
)
, 

-0.0006321333
)
, 

-0.0006737067
)
, 

(v1_rescurravmratiodiff12mo > 1.185) => 
map(

   ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 176385) => 
map(

      ( NULL < v1_crtrecbkrptcnt12mo and v1_crtrecbkrptcnt12mo <= 0.5) => 
0.0170473156
, 

      (v1_crtrecbkrptcnt12mo > 0.5) => 
0.0765234370
, 

0.0181114356
)
, 

   (v1_hhpropcurravmhighest > 176385) => 
-0.0055083328
, 

0.0089500697
)
, 

0.0000177726
)
;


// Tree: 290

b2_tree_290 := 
map(

( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 3.5) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 2.5) => 
0.0026984076
, 

   (v1_raammbrcnt > 2.5) => 
-0.0061644038
, 

-0.0015143233
)
, 

(v1_raacrtrecmmbrcnt > 3.5) => 
map(

   ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 114455) => 
map(

      ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
0.0093786983
, 

         (v1_hhcnt > 1.5) => 
map(

            ( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 12445.5) => 
-0.0053916506
, 

            (v1_rescurravmvalue12mo > 12445.5) => 
0.0107882260
, 

0.0013621911
)
, 

0.0059431178
)
, 

      (v1_prospectcollegeattending > 0.5) => 
-0.0347474433
, 

0.0048986082
)
, 

   (v1_resinputavmvalue12mo > 114455) => 
-0.0066015929
, 

0.0023183393
)
, 

-0.0000818772
)
;


// Tree: 294

b2_tree_294 := 
map(

( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 77010) => 
map(

   ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 1.5) => 
map(

      (v1_resinputdwelltype in ['-1','F','H','R','S','U']) => 
-0.0039361953
, 

      (v1_resinputdwelltype in ['0','G','P']) => 
0.0214000461
, 

-0.0024317760
)
, 

   (v1_raacrtrecmmbrcnt > 1.5) => 
map(

      ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
0.0065874418
, 

      (v1_hhcnt > 1.5) => 
-0.0013965596
, 

0.0034197373
)
, 

0.0007222470
)
, 

(v1_resinputavmvalue > 77010) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 1.5) => 
0.0084789127
, 

   (v1_raammbrcnt > 1.5) => 
map(

      ( NULL < v1_hhcrtrecbkrptmmbrcnt24mo and v1_hhcrtrecbkrptmmbrcnt24mo <= 0.5) => 
-0.0095221569
, 

      (v1_hhcrtrecbkrptmmbrcnt24mo > 0.5) => 
0.0283707531
, 

-0.0087339589
)
, 

-0.0049808660
)
, 

-0.0011737888
)
;


// Tree: 298

b2_tree_298 := 
map(

( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 11.5) => 
map(

   ( NULL < v1_crtrecevictioncnt and v1_crtrecevictioncnt <= 4.5) => 
map(

      ( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 1.105) => 
map(

         ( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
-0.0012625208
, 

         (v1_prospectdeceased > 0.5) => 
0.0739989973
, 

-0.0011881288
)
, 

      (v1_resinputavmratiodiff60mo > 1.105) => 
map(

         ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 87808.5) => 
0.0219105650
, 

         (v1_resinputavmvalue60mo > 87808.5) => 
0.0026107040
, 

0.0088696110
)
, 

-0.0005499895
)
, 

   (v1_crtrecevictioncnt > 4.5) => 
map(

      ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 0.865) => 
-0.0254083217
, 

      (v1_rescurravmratiodiff60mo > 0.865) => 
0.0392160749
, 

-0.0203190304
)
, 

-0.0007128560
)
, 

(v1_crtrecmsdmeancnt > 11.5) => 
0.0170940112
, 

-0.0005163944
)
;


// Tree: 302

b2_tree_302 := 
map(

( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
-0.0026088463
, 

(v1_resinputownershipindex > 0.5) => 
map(

   ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 0.565) => 
0.0052190106
, 

   (v1_resinputavmcntyratio > 0.565) => 
map(

      ( NULL < v1_hhcrtrecbkrptmmbrcnt and v1_hhcrtrecbkrptmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 4.5) => 
map(

            ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 2.695) => 
-0.0004441552
, 

            (v1_resinputavmcntyratio > 2.695) => 
0.0340215325
, 

0.0012272321
)
, 

         (v1_raapropcurrownermmbrcnt > 4.5) => 
-0.0172800795
, 

-0.0041829524
)
, 

      (v1_hhcrtrecbkrptmmbrcnt > 0.5) => 
map(

         ( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 22.5) => 
0.0197774156
, 

         (v1_crtrecevictiontimenewest > 22.5) => 
-0.0241044371
, 

0.0161141581
)
, 

-0.0020170050
)
, 

0.0013497558
)
, 

-0.0003820647
)
;


// Tree: 306

b2_tree_306 := 
map(

( NULL < v1_raacrtrecmsdmeanmmbrcnt12mo and v1_raacrtrecmsdmeanmmbrcnt12mo <= 3.5) => 
map(

   ( NULL < v1_raacollegeattendedmmbrcnt and v1_raacollegeattendedmmbrcnt <= 7.5) => 
map(

      ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 2.5) => 
map(

         (v1_resinputdwelltype in ['-1','0','F','H','R','S','U']) => 
map(

            ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
-0.0018288530
, 

            (v1_raacrtrecfelonymmbrcnt > 0.5) => 
0.0043906052
, 

-0.0008959120
)
, 

         (v1_resinputdwelltype in ['G','P']) => 
map(

            ( NULL < v1_raahhcnt and v1_raahhcnt <= 0.5) => 
0.0282332272
, 

            (v1_raahhcnt > 0.5) => 
-0.0004049838
, 

0.0090191100
)
, 

-0.0004654496
)
, 

      (v1_raacollege4yrattendedmmbrcnt > 2.5) => 
-0.0246850593
, 

-0.0010546420
)
, 

   (v1_raacollegeattendedmmbrcnt > 7.5) => 
0.0166833717
, 

-0.0007086623
)
, 

(v1_raacrtrecmsdmeanmmbrcnt12mo > 3.5) => 
-0.0179694578
, 

-0.0009065522
)
;


// Tree: 310

b2_tree_310 := 
map(

( NULL < v1_lifeevnamechange and v1_lifeevnamechange <= 0.5) => 
map(

   ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 3.5) => 
0.0010076715
, 

   (v1_occbusinessassociationtime > 3.5) => 
map(

      ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 5723.5) => 
-0.0198847286
, 

      (v1_crtreclienjudgamtttl > 5723.5) => 
0.0176269878
, 

-0.0164959974
)
, 

-0.0001528440
)
, 

(v1_lifeevnamechange > 0.5) => 
map(

   ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

      ( NULL < v1_raacrtrecevictionmmbrcnt12mo and v1_raacrtrecevictionmmbrcnt12mo <= 0.5) => 
map(

         ( NULL < v1_lifeevecontrajectoryindex and v1_lifeevecontrajectoryindex <= 4.5) => 
-0.0352272532
, 

         (v1_lifeevecontrajectoryindex > 4.5) => 
-0.0082956960
, 

-0.0138866612
)
, 

      (v1_raacrtrecevictionmmbrcnt12mo > 0.5) => 
-0.0428035196
, 

-0.0183000576
)
, 

   (v1_lifeevtimefirstassetpurchase > -0.5) => 
-0.0012194465
, 

-0.0075354392
)
, 

-0.0007409098
)
;


// Tree: 314

b2_tree_314 := 
map(

( NULL < v1_hhcrtrecbkrptmmbrcnt24mo and v1_hhcrtrecbkrptmmbrcnt24mo <= 1.5) => 
map(

   ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 1.5) => 
map(

      ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
0.0011479388
, 

      (v1_raacrtrecfelonymmbrcnt > 0.5) => 
0.0141030073
, 

0.0018727681
)
, 

   (v1_raamiddleagemmbrcnt > 1.5) => 
map(

      ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 2.5) => 
map(

            ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 1229961.5) => 
-0.0044851177
, 

            (v1_raapropowneravmmed > 1229961.5) => 
0.1334541347
, 

-0.0040261589
)
, 

         (v1_crtrectimenewest > 2.5) => 
0.0045568653
, 

-0.0007474340
)
, 

      (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0112546404
, 

-0.0029895626
)
, 

-0.0005259116
)
, 

(v1_hhcrtrecbkrptmmbrcnt24mo > 1.5) => 
0.0332457314
, 

-0.0004014846
)
;


// Tree: 318

b2_tree_318 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

   ( NULL < v1_crtrecevictioncnt12mo and v1_crtrecevictioncnt12mo <= 3.5) => 
map(

      ( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 1.5) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 1214886.5) => 
map(

            ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
-0.0017182912
, 

            (v1_resinputownershipindex > 0.5) => 
0.0027169742
, 

0.0006946861
)
, 

         (v1_raapropowneravmmed > 1214886.5) => 
0.0801619731
, 

0.0008210296
)
, 

      (v1_rescurrbusinesscnt > 1.5) => 
map(

         ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 0.625) => 
-0.0186371188
, 

         (v1_rescurravmcntyratio > 0.625) => 
-0.0017992076
, 

-0.0085011868
)
, 

0.0000296294
)
, 

   (v1_crtrecevictioncnt12mo > 3.5) => 
-0.0661014926
, 

-0.0000088341
)
, 

(v1_prospectdeceased > 0.5) => 
0.0765332292
, 

0.0000597376
)
;


// Tree: 322

b2_tree_322 := 
map(

( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 14.5) => 
map(

   ( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 36614) => 
map(

      ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

         (v1_resinputdwelltype in ['-1','F','S','U']) => 
-0.0052904881
, 

         (v1_resinputdwelltype in ['0','G','H','P','R']) => 
map(

            ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
0.0001348466
, 

            (v1_hhpropcurrownermmbrcnt > 0.5) => 
0.0229983831
, 

0.0021941356
)
, 

-0.0016696620
)
, 

      (v1_resinputownershipindex > 0.5) => 
0.0031055735
, 

0.0008711867
)
, 

   (v1_rescurrmortgageamount > 36614) => 
map(

      ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 1.5) => 
-0.0294559747
, 

      (v1_crtrecbkrptcnt > 1.5) => 
0.0699034974
, 

-0.0275249087
)
, 

-0.0011106182
)
, 

(v1_resinputbusinesscnt > 14.5) => 
-0.0183773339
, 

-0.0013737955
)
;


// Tree: 326

b2_tree_326 := 
map(

( NULL < v1_hhcrtrecfelonymmbrcnt and v1_hhcrtrecfelonymmbrcnt <= 0.5) => 
map(

   ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 198.5) => 
map(

      ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 4922.5) => 
map(

         ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 2.5) => 
-0.0013182748
, 

         (v1_raacrtrecfelonymmbrcnt > 2.5) => 
0.0126109884
, 

-0.0010006225
)
, 

      (v1_hhcrtreclienjudgamtttl > 4922.5) => 
map(

         ( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 66.5) => 
map(

            ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 1.5) => 
0.0073062420
, 

            (v1_crtrecmsdmeancnt > 1.5) => 
0.0275880359
, 

0.0104368844
)
, 

         (v1_crtrecevictiontimenewest > 66.5) => 
-0.0174693842
, 

0.0081788199
)
, 

-0.0003392643
)
, 

   (v1_crtreclienjudgtimenewest > 198.5) => 
-0.0253361358
, 

-0.0005835740
)
, 

(v1_hhcrtrecfelonymmbrcnt > 0.5) => 
0.0089648125
, 

-0.0002329327
)
;


// Tree: 330

b2_tree_330 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

   ( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 83.5) => 
map(

         ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 1.5) => 
0.0018925593
, 

         (v1_raapropcurrownermmbrcnt > 1.5) => 
-0.0113134704
, 

-0.0003679344
)
, 

      (v1_raacrtreclienjudgamtmax > 83.5) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 65.5) => 
0.0084267692
, 

         (v1_crtrecbkrpttimenewest > 65.5) => 
-0.0143992099
, 

0.0069562224
)
, 

0.0015261838
)
, 

   (v1_raaoccbusinessassocmmbrcnt > 0.5) => 
map(

      ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 13550) => 
-0.0137904794
, 

      (v1_raapropowneravmhighest > 13550) => 
0.0002958671
, 

-0.0020583034
)
, 

0.0001236137
)
, 

(v1_prospectdeceased > 0.5) => 
0.0743237708
, 

0.0001870931
)
;


// Tree: 334

b2_tree_334 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 110.5) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 78.5) => 
map(

      ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 16999) => 
0.0002235281
, 

      (v1_hhcrtreclienjudgamtttl > 16999) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 28444.5) => 
map(

            ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 3.5) => 
map(

               ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 1.5) => 
0.0115096300
, 

               (v1_resinputbusinesscnt > 1.5) => 
-0.0459222617
, 

-0.0009976095
)
, 

            (v1_crtrecmsdmeancnt > 3.5) => 
-0.0837437436
, 

-0.0070466995
)
, 

         (v1_raapropowneravmmed > 28444.5) => 
0.0223733610
, 

0.0136303372
)
, 

0.0006087963
)
, 

   (v1_crtrectimenewest > 78.5) => 
-0.0071351076
, 

-0.0000863939
)
, 

(v1_prospecttimelastupdate > 110.5) => 
0.0097800170
, 

0.0003912713
)
;


// Tree: 338

b2_tree_338 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 27.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
map(

         ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.785) => 
-0.0001238477
, 

         (v1_resinputavmcntyratio > 1.785) => 
0.0179119543
, 

0.0005963960
)
, 

      (v1_hhseniormmbrcnt > 0.5) => 
-0.0266186866
, 

-0.0005678647
)
, 

   (v1_hhmiddleagemmbrcnt > 0.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 0) => 
-0.0252626904
, 

      (v1_lifeevtimelastmove > 0) => 
-0.0079395611
, 

-0.0104152679
)
, 

-0.0024205100
)
, 

(v1_prospecttimelastupdate > 27.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0405458845
, 

   (v1_lifeeveverresidedcnt > 0.5) => 
0.0031834196
, 

0.0039808552
)
, 

-0.0009027548
)
;


// Tree: 342

b2_tree_342 := 
map(

( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 10.5) => 
map(

   ( NULL < v1_crtrecfelonycnt and v1_crtrecfelonycnt <= 1.5) => 
map(

      ( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 1.5) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 63.5) => 
0.0003589322
, 

         (v1_crtrecbkrpttimenewest > 63.5) => 
-0.0088651281
, 

-0.0000283401
)
, 

      (v1_occproflicensecategory > 1.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 29.5) => 
-0.0712417170
, 

         (v1_prospecttimeonrecord > 29.5) => 
-0.0247980808
, 

-0.0303084882
)
, 

-0.0006987379
)
, 

   (v1_crtrecfelonycnt > 1.5) => 
0.0148362466
, 

-0.0005239566
)
, 

(v1_raacrtrecevictionmmbrcnt > 10.5) => 
map(

   ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 6305) => 
0.0538186123
, 

   (v1_hhcrtreclienjudgamtttl > 6305) => 
-0.0459700112
, 

0.0337646285
)
, 

-0.0004378906
)
;


// Tree: 346

b2_tree_346 := 
map(

( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 1.5) => 
map(

   ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 0.5) => 
map(

      (v1_resinputdwelltype in ['-1','F','H','R','S','U']) => 
map(

         ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
-0.0050868162
, 

         (v1_resinputownershipindex > 0.5) => 
0.0032658618
, 

-0.0007650242
)
, 

      (v1_resinputdwelltype in ['0','G','P']) => 
0.0191397008
, 

0.0000331624
)
, 

   (v1_raacrtrecmsdmeanmmbrcnt > 0.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 161.5) => 
map(

         ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 575) => 
0.0072679138
, 

         (v1_crtreclienjudgamtttl > 575) => 
0.0267735843
, 

0.0087517099
)
, 

      (v1_prospecttimeonrecord > 161.5) => 
-0.0093086587
, 

0.0048065496
)
, 

0.0012513626
)
, 

(v1_raamiddleagemmbrcnt > 1.5) => 
-0.0030602678
, 

-0.0008814506
)
;


// Tree: 350

b2_tree_350 := 
map(

( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 322.5) => 
map(

   ( NULL < v1_crtrecfelonycnt and v1_crtrecfelonycnt <= 1.5) => 
map(

      ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 2.5) => 
-0.0008699189
, 

      (v1_crtrecbkrptcnt > 2.5) => 
map(

         ( NULL < v1_rescurravmvalue and v1_rescurravmvalue <= 114949.5) => 
0.0083932975
, 

         (v1_rescurravmvalue > 114949.5) => 
0.0770150101
, 

0.0243000102
)
, 

-0.0007781295
)
, 

   (v1_crtrecfelonycnt > 1.5) => 
map(

      ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 7.5) => 
map(

         ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 38415.5) => 
0.0435686429
, 

         (v1_resinputavmvalue12mo > 38415.5) => 
-0.0080191343
, 

0.0295787372
)
, 

      (v1_raacrtrecmmbrcnt > 7.5) => 
-0.0002965254
, 

0.0144134642
)
, 

-0.0006090539
)
, 

(v1_crtrecfelonytimenewest > 322.5) => 
-0.0585562608
, 

-0.0006499764
)
;


// Tree: 354

b2_tree_354 := 
map(

( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 307.5) => 
map(

   ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 5.5) => 
map(

      ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 1.5) => 
-0.0010849869
, 

      (v1_raamiddleagemmbrcnt > 1.5) => 
-0.0093589742
, 

-0.0034299254
)
, 

   (v1_raacrtrecevictionmmbrcnt > 5.5) => 
0.0412282076
, 

-0.0033123081
)
, 

(v1_raacrtreclienjudgamtmax > 307.5) => 
map(

   ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 0.5) => 
map(

      ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
map(

         ( NULL < v1_prospectcollegeattended and v1_prospectcollegeattended <= 0.5) => 
0.0104982058
, 

         (v1_prospectcollegeattended > 0.5) => 
-0.0022160145
, 

0.0079598283
)
, 

      (v1_hhcnt > 1.5) => 
-0.0004268988
, 

0.0043267112
)
, 

   (v1_resinputbusinesscnt > 0.5) => 
-0.0035844086
, 

0.0014910246
)
, 

-0.0014308005
)
;


// Tree: 358

b2_tree_358 := 
map(

( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 5.5) => 
map(

   ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 169.5) => 
map(

      ( NULL < v1_raacrtrecfelonymmbrcnt12mo and v1_raacrtrecfelonymmbrcnt12mo <= 0.5) => 
map(

         ( NULL < v1_raacrtrecmsdmeanmmbrcnt12mo and v1_raacrtrecmsdmeanmmbrcnt12mo <= 3.5) => 
-0.0007228820
, 

         (v1_raacrtrecmsdmeanmmbrcnt12mo > 3.5) => 
-0.0231128250
, 

-0.0008779141
)
, 

      (v1_raacrtrecfelonymmbrcnt12mo > 0.5) => 
0.0155460537
, 

-0.0006835254
)
, 

   (v1_occbusinessassociationtime > 169.5) => 
-0.0394640591
, 

-0.0012151748
)
, 

(v1_crtrecmsdmeancnt > 5.5) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 62.5) => 
map(

      ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 7.5) => 
0.0098883637
, 

      (v1_crtreclienjudgtimenewest > 7.5) => 
0.0359164807
, 

0.0170274796
)
, 

   (v1_crtrectimenewest > 62.5) => 
-0.0121400683
, 

0.0109329972
)
, 

-0.0008425976
)
;


// Tree: 362

b2_tree_362 := 
map(

( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 102.5) => 
map(

   ( NULL < v1_hhcrtrecevictionmmbrcnt and v1_hhcrtrecevictionmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 27.5) => 
-0.0005914338
, 

      (v1_crtreclienjudgtimenewest > 27.5) => 
map(

         ( NULL < v1_rescurravmvalue and v1_rescurravmvalue <= 93578) => 
0.0031725530
, 

         (v1_rescurravmvalue > 93578) => 
0.0295895492
, 

0.0111422481
)
, 

-0.0000312374
)
, 

   (v1_hhcrtrecevictionmmbrcnt > 0.5) => 
map(

      ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 180.5) => 
0.0148164539
, 

      (v1_hhcrtreclienjudgamtttl > 180.5) => 
map(

         ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 1.5) => 
0.0206213701
, 

         (v1_raacrtreclienjudgmmbrcnt > 1.5) => 
-0.0086888185
, 

-0.0011349485
)
, 

0.0073430598
)
, 

0.0004978139
)
, 

(v1_crtreclienjudgtimenewest > 102.5) => 
-0.0093527908
, 

0.0001049091
)
;


// Tree: 366

b2_tree_366 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 48.5) => 
-0.0013414791
, 

(v1_prospecttimelastupdate > 48.5) => 
map(

   ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 1.5) => 
map(

      ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 78489) => 
map(

         ( NULL < v1_crtreccnt and v1_crtreccnt <= 2.5) => 
0.0164385280
, 

         (v1_crtreccnt > 2.5) => 
map(

            ( NULL < v1_rescurrdwelltypeindex and v1_rescurrdwelltypeindex <= 2) => 
map(

               ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 51.5) => 
-0.0285600113
, 

               (v1_crtrecmsdmeantimenewest > 51.5) => 
0.0046812220
, 

-0.0117451637
)
, 

            (v1_rescurrdwelltypeindex > 2) => 
0.0092457449
, 

0.0003077287
)
, 

0.0115566904
)
, 

      (v1_hhpropcurravmhighest > 78489) => 
-0.0071166054
, 

0.0072700265
)
, 

   (v1_verifiedcurrresmatchindex > 1.5) => 
-0.0039888680
, 

0.0024679867
)
, 

-0.0006945722
)
;


// Tree: 370

b2_tree_370 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

   ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 159.5) => 
map(

      ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 1229.5) => 
-0.0004820926
, 

      (v1_hhcrtreclienjudgamtttl > 1229.5) => 
map(

         ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 1.5) => 
0.0112350792
, 

         (v1_raacrtrecevictionmmbrcnt > 1.5) => 
map(

            ( NULL < v1_propcurrowner and v1_propcurrowner <= 0.5) => 
-0.0085977762
, 

            (v1_propcurrowner > 0.5) => 
0.0155920483
, 

-0.0016032162
)
, 

0.0069154779
)
, 

0.0004162006
)
, 

   (v1_crtreclienjudgtimenewest > 159.5) => 
-0.0136308126
, 

0.0001566979
)
, 

(v1_prospectdeceased > 0.5) => 
map(

   ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 242590) => 
0.0423008346
, 

   (v1_hhpropcurravmhighest > 242590) => 
0.3901983975
, 

0.0736281033
)
, 

0.0002192573
)
;


// Tree: 374

b2_tree_374 := 
map(

( NULL < v1_hhcnt and v1_hhcnt <= 7.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

      ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 640932.5) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
0.0020718049
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0052087195
, 

0.0010448004
)
, 

      (v1_resinputavmvalue12mo > 640932.5) => 
0.0278795986
, 

0.0013850890
)
, 

   (v1_hhmiddleagemmbrcnt > 0.5) => 
map(

      ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
-0.0241478716
, 

      (v1_hhcrtrecmmbrcnt > 0.5) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 103.5) => 
0.0032192340
, 

         (v1_crtrectimenewest > 103.5) => 
-0.0101991449
, 

-0.0000906746
)
, 

-0.0083023016
)
, 

-0.0012316604
)
, 

(v1_hhcnt > 7.5) => 
0.0139530239
, 

-0.0007843997
)
;


// Tree: 378

b2_tree_378 := 
map(

( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 30.5) => 
map(

   ( NULL < v1_crtrecevictioncnt and v1_crtrecevictioncnt <= 6.5) => 
map(

      ( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 65061.5) => 
map(

         ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
-0.0012557720
, 

         (v1_resinputownershipindex > 0.5) => 
map(

            ( NULL < v1_raacrtrecmsdmeanmmbrcnt12mo and v1_raacrtrecmsdmeanmmbrcnt12mo <= 4.5) => 
0.0030584295
, 

            (v1_raacrtrecmsdmeanmmbrcnt12mo > 4.5) => 
-0.0372078758
, 

0.0028666172
)
, 

0.0009674138
)
, 

      (v1_rescurrmortgageamount > 65061.5) => 
-0.0223765459
, 

-0.0005627174
)
, 

   (v1_crtrecevictioncnt > 6.5) => 
map(

      ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 46124) => 
-0.0239952405
, 

      (v1_crtreclienjudgamtttl > 46124) => 
0.1192466807
, 

-0.0206811600
)
, 

-0.0006576341
)
, 

(v1_raacrtrecmsdmeanmmbrcnt > 30.5) => 
-0.0402393880
, 

-0.0007291932
)
;


// Tree: 382

b2_tree_382 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 64.5) => 
map(

   ( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 75.5) => 
-0.0004472914
, 

   (v1_crtrecevictiontimenewest > 75.5) => 
-0.0148678410
, 

-0.0006434346
)
, 

(v1_prospecttimelastupdate > 64.5) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 10.5) => 
map(

      ( NULL < v1_crtreccnt and v1_crtreccnt <= 1.5) => 
0.0083843919
, 

      (v1_crtreccnt > 1.5) => 
-0.0136845822
, 

0.0030332577
)
, 

   (v1_raammbrcnt > 10.5) => 
map(

      ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
map(

         ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 156.5) => 
0.0336329949
, 

         (v1_crtrecmsdmeantimenewest > 156.5) => 
-0.0244461155
, 

0.0289265842
)
, 

      (v1_hhcnt > 1.5) => 
0.0074293891
, 

0.0127152858
)
, 

0.0067177518
)
, 

0.0002772038
)
;


// Tree: 386

b2_tree_386 := 
map(

( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
map(

   ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
0.0017417022
, 

   (v1_hhyoungadultmmbrcnt > 0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 1.5) => 
0.0304058952
, 

      (v1_raammbrcnt > 1.5) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 31.5) => 
map(

            ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 34869) => 
0.0021375607
, 

            (v1_resinputavmvalue > 34869) => 
-0.0184056722
, 

-0.0073294458
)
, 

         (v1_crtrecbkrpttimenewest > 31.5) => 
-0.0294781031
, 

-0.0091082698
)
, 

-0.0069164815
)
, 

0.0004681394
)
, 

(v1_hhseniormmbrcnt > 0.5) => 
map(

   (v1_rescurrdwelltype in ['-1','R']) => 
-0.0301754798
, 

   (v1_rescurrdwelltype in ['F','H','P','S','U']) => 
-0.0045003159
, 

-0.0078320150
)
, 

-0.0002824799
)
;


// Tree: 390

b2_tree_390 := 
map(

( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 2.5) => 
map(

   ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.205) => 
map(

      ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 2.5) => 
map(

         ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 213.5) => 
0.0024648490
, 

         (v1_lifeevtimelastmove > 213.5) => 
-0.0108671721
, 

0.0012348655
)
, 

      (v1_raapropcurrownermmbrcnt > 2.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 12.5) => 
-0.0092586956
, 

         (v1_raammbrcnt > 12.5) => 
map(

            ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 91735) => 
0.0052001994
, 

            (v1_resinputavmvalue > 91735) => 
-0.0119617150
, 

0.0004259158
)
, 

-0.0044173927
)
, 

-0.0007826641
)
, 

   (v1_resinputavmratiodiff12mo > 1.205) => 
0.0063032840
, 

0.0000297192
)
, 

(v1_occproflicensecategory > 2.5) => 
-0.0543557162
, 

-0.0007015534
)
;


// Tree: 394

b2_tree_394 := 
map(

( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 65.5) => 
map(

   ( NULL < v1_hhcrtrecevictionmmbrcnt and v1_hhcrtrecevictionmmbrcnt <= 0.5) => 
-0.0000599576
, 

   (v1_hhcrtrecevictionmmbrcnt > 0.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0541585304
, 

      (v1_lifeeveverresidedcnt > 0.5) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
0.0137072323
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0053400276
, 

0.0055492365
)
, 

0.0079950864
)
, 

0.0003521371
)
, 

(v1_crtrecevictiontimenewest > 65.5) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
0.0060107264
, 

   (v1_hhcnt > 1.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 335.5) => 
-0.0162589226
, 

      (v1_lifeevtimelastmove > 335.5) => 
-0.0944605154
, 

-0.0184570617
)
, 

-0.0087663955
)
, 

0.0000963587
)
;


// Tree: 398

b2_tree_398 := 
map(

( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 3.265) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 7.5) => 
map(

      ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 1.5) => 
map(

         ( NULL < v1_crtreccnt and v1_crtreccnt <= 12.5) => 
-0.0000892208
, 

         (v1_crtreccnt > 12.5) => 
map(

            ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 84.5) => 
map(

               ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 293851.5) => 
0.0121682354
, 

               (v1_resinputavmvalue60mo > 293851.5) => 
0.0900441058
, 

0.0143634678
)
, 

            (v1_crtrectimenewest > 84.5) => 
-0.0264030311
, 

0.0109019959
)
, 

0.0001296597
)
, 

      (v1_hhyoungadultmmbrcnt > 1.5) => 
-0.0190234682
, 

-0.0003549484
)
, 

   (v1_hhcnt > 7.5) => 
0.0124929265
, 

0.0000276434
)
, 

(v1_rescurravmblockratio > 3.265) => 
0.0484635607
, 

0.0001802981
)
;


// Tree: 402

b2_tree_402 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

   ( NULL < v1_crtrecevictioncnt and v1_crtrecevictioncnt <= 5.5) => 
map(

      ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 4.5) => 
map(

         ( NULL < v1_hhteenagermmbrcnt and v1_hhteenagermmbrcnt <= 0.5) => 
map(

            ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 294.5) => 
-0.0005077536
, 

            (v1_crtrecfelonytimenewest > 294.5) => 
-0.0440461436
, 

-0.0005522608
)
, 

         (v1_hhteenagermmbrcnt > 0.5) => 
0.0676988697
, 

-0.0004669692
)
, 

      (v1_hhcrtrecmmbrcnt > 4.5) => 
0.0243969698
, 

-0.0003534583
)
, 

   (v1_crtrecevictioncnt > 5.5) => 
map(

      ( NULL < v1_hhcrtrecmsdmeanmmbrcnt12mo and v1_hhcrtrecmsdmeanmmbrcnt12mo <= 1.5) => 
-0.0162139038
, 

      (v1_hhcrtrecmsdmeanmmbrcnt12mo > 1.5) => 
-0.1982815935
, 

-0.0176867600
)
, 

-0.0004659595
)
, 

(v1_prospectdeceased > 0.5) => 
0.0647534222
, 

-0.0004106897
)
;


// Tree: 406

b2_tree_406 := 
map(

( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 150.5) => 
map(

   (v1_resinputdwelltype in ['-1','0','F','R','U']) => 
-0.0198008463
, 

   (v1_resinputdwelltype in ['G','H','P','S']) => 
map(

      ( NULL < v1_crtrecevictioncnt and v1_crtrecevictioncnt <= 5.5) => 
map(

         ( NULL < v1_hhcrtrecevictionmmbrcnt and v1_hhcrtrecevictionmmbrcnt <= 0.5) => 
-0.0002610135
, 

         (v1_hhcrtrecevictionmmbrcnt > 0.5) => 
map(

            ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0433284100
, 

            (v1_lifeeveverresidedcnt > 0.5) => 
0.0054850936
, 

0.0069767893
)
, 

0.0002218621
)
, 

      (v1_crtrecevictioncnt > 5.5) => 
map(

         ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 12.5) => 
-0.0115145167
, 

         (v1_raamiddleagemmbrcnt > 12.5) => 
-0.1209277453
, 

-0.0157843012
)
, 

0.0001145550
)
, 

-0.0000353270
)
, 

(v1_crtrecevictiontimenewest > 150.5) => 
-0.0187427676
, 

-0.0001352041
)
;


// Tree: 410

b2_tree_410 := 
map(

( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 1.5) => 
map(

   ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

      ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 6.5) => 
0.0007509749
, 

      (v1_raapropcurrownermmbrcnt > 6.5) => 
-0.0088411971
, 

-0.0000074821
)
, 

   (v1_lifeevtimefirstassetpurchase > -0.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 4.5) => 
map(

         ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 62811.5) => 
map(

            ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 70064.5) => 
0.0292723344
, 

            (v1_propcurrownedassessedttl > 70064.5) => 
-0.0179584371
, 

0.0136592914
)
, 

         (v1_hhpropcurravmhighest > 62811.5) => 
-0.0045380320
, 

0.0017523088
)
, 

      (v1_crtrecbkrpttimenewest > 4.5) => 
0.0301480639
, 

0.0047931189
)
, 

0.0010023854
)
, 

(v1_hhmiddleagemmbrcnt > 1.5) => 
-0.0077467395
, 

0.0000568385
)
;


// Tree: 414

b2_tree_414 := 
map(

( NULL < v1_raacollegeattendedmmbrcnt and v1_raacollegeattendedmmbrcnt <= 10.5) => 
map(

   ( NULL < v1_crtreccnt and v1_crtreccnt <= 45.5) => 
map(

      ( NULL < v1_crtreclienjudgcnt and v1_crtreclienjudgcnt <= 1.5) => 
-0.0008139823
, 

      (v1_crtreclienjudgcnt > 1.5) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 169866) => 
map(

            ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 0.5) => 
-0.0052819453
, 

            (v1_resinputbusinesscnt > 0.5) => 
-0.0246380568
, 

-0.0115629847
)
, 

         (v1_raapropowneravmmed > 169866) => 
0.0068928374
, 

-0.0060908628
)
, 

-0.0011919659
)
, 

   (v1_crtreccnt > 45.5) => 
0.0438566147
, 

-0.0011443255
)
, 

(v1_raacollegeattendedmmbrcnt > 10.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 67664) => 
0.0528868048
, 

   (v1_raapropowneravmmed > 67664) => 
0.0088652676
, 

0.0180128933
)
, 

-0.0009936523
)
;


// Tree: 418

b2_tree_418 := 
map(

( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 1.5) => 
map(

   ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 2.5) => 
-0.0015775995
, 

   (v1_raacrtrecmmbrcnt > 2.5) => 
map(

      ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 273239.5) => 
map(

         ( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 0.5) => 
map(

            ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
0.0066787265
, 

            (v1_hhseniormmbrcnt > 0.5) => 
map(

               ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 13145.5) => 
-0.0294086490
, 

               (v1_raapropowneravmmed > 13145.5) => 
0.0011608111
, 

-0.0045059389
)
, 

0.0054119495
)
, 

         (v1_hhcollegeattendedmmbrcnt > 0.5) => 
-0.0028346109
, 

0.0032179189
)
, 

      (v1_resinputavmvalue12mo > 273239.5) => 
-0.0160710944
, 

0.0017747340
)
, 

-0.0000787452
)
, 

(v1_hhyoungadultmmbrcnt > 1.5) => 
-0.0180609740
, 

-0.0005745910
)
;


// Tree: 422

b2_tree_422 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

   (v1_resinputdwelltype in ['-1','U']) => 
-0.0710773286
, 

   (v1_resinputdwelltype in ['0','F','G','H','P','R','S']) => 
map(

      ( NULL < v1_crtreccnt and v1_crtreccnt <= 10.5) => 
0.0002075083
, 

      (v1_crtreccnt > 10.5) => 
map(

         ( NULL < v1_hhcrtrecmmbrcnt12mo and v1_hhcrtrecmmbrcnt12mo <= 1.5) => 
map(

            ( NULL < v1_raainterestsportpersonmmbrcnt and v1_raainterestsportpersonmmbrcnt <= 4.5) => 
map(

               (v1_resinputdwelltype in ['P']) => 
-0.0338134809
, 

               (v1_resinputdwelltype in ['-1','0','F','G','H','R','S','U']) => 
0.0127561884
, 

0.0103520740
)
, 

            (v1_raainterestsportpersonmmbrcnt > 4.5) => 
0.1281570117
, 

0.0114508298
)
, 

         (v1_hhcrtrecmmbrcnt12mo > 1.5) => 
-0.0386571697
, 

0.0089987677
)
, 

0.0004478954
)
, 

0.0003869378
)
, 

(v1_prospectdeceased > 0.5) => 
0.0606773672
, 

0.0004416800
)
;


// Tree: 426

b2_tree_426 := 
map(

(v1_resinputdwelltype in ['-1','0','F','H','R','U']) => 
map(

   ( NULL < v1_raacrtrecfelonymmbrcnt12mo and v1_raacrtrecfelonymmbrcnt12mo <= 0.5) => 
map(

      ( NULL < v1_crtrecfelonycnt and v1_crtrecfelonycnt <= 1.5) => 
map(

         ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
-0.0057242596
, 

         (v1_lifeevtimefirstassetpurchase > -0.5) => 
map(

            ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 2.5) => 
0.0330498658
, 

            (v1_rescurrownershipindex > 2.5) => 
-0.0135708957
, 

0.0048517582
)
, 

-0.0046013375
)
, 

      (v1_crtrecfelonycnt > 1.5) => 
map(

         ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 6.5) => 
0.0348286300
, 

         (v1_raacrtrecfelonymmbrcnt > 6.5) => 
-0.1397871951
, 

0.0278561231
)
, 

-0.0042544372
)
, 

   (v1_raacrtrecfelonymmbrcnt12mo > 0.5) => 
0.0275033232
, 

-0.0038420668
)
, 

(v1_resinputdwelltype in ['G','P','S']) => 
0.0004433350
, 

-0.0005009254
)
;


// Tree: 430

b2_tree_430 := 
map(

( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 4.275) => 
map(

   ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 145563.5) => 
0.0017906619
, 

   (v1_resinputavmvalue12mo > 145563.5) => 
map(

      ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 1.5) => 
map(

         ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 0.5) => 
0.0037409321
, 

         (v1_raacrtrecmmbrcnt > 0.5) => 
-0.0100744370
, 

-0.0053570141
)
, 

      (v1_crtrecbkrptcnt > 1.5) => 
map(

         ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 9.5) => 
0.0765576916
, 

         (v1_raacrtrecmmbrcnt > 9.5) => 
map(

            ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 327294) => 
-0.0555828266
, 

            (v1_raapropowneravmmed > 327294) => 
0.1468402500
, 

-0.0239111888
)
, 

0.0476556849
)
, 

-0.0048218813
)
, 

0.0004379086
)
, 

(v1_rescurravmblockratio > 4.275) => 
0.0669479366
, 

0.0005326530
)
;


// Tree: 434

b2_tree_434 := 
map(

( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 11.5) => 
map(

   ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 1.5) => 
-0.0016812043
, 

   (v1_crtrecbkrptcnt > 1.5) => 
0.0272468847
, 

-0.0014531640
)
, 

(v1_crtreclienjudgtimenewest > 11.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 33.5) => 
0.0074532898
, 

   (v1_crtrecbkrpttimenewest > 33.5) => 
map(

      ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 130853.5) => 
-0.0274796349
, 

      (v1_raapropowneravmhighest > 130853.5) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

            ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 77.5) => 
0.0340762207
, 

            (v1_crtreclienjudgtimenewest > 77.5) => 
-0.0071717826
, 

0.0123153304
)
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0315263569
, 

0.0036648238
)
, 

-0.0091001874
)
, 

0.0044870664
)
, 

-0.0007615386
)
;


// Tree: 438

b2_tree_438 := 
map(

( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 75.5) => 
map(

   ( NULL < v1_hhcrtrecevictionmmbrcnt and v1_hhcrtrecevictionmmbrcnt <= 0.5) => 
-0.0005481116
, 

   (v1_hhcrtrecevictionmmbrcnt > 0.5) => 
map(

      ( NULL < v1_crtrecmsdmeancnt12mo and v1_crtrecmsdmeancnt12mo <= 0.5) => 
map(

         ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
0.0065727998
, 

         (v1_prospectcollegeattending > 0.5) => 
-0.0686373792
, 

0.0054590233
)
, 

      (v1_crtrecmsdmeancnt12mo > 0.5) => 
0.0399664690
, 

0.0071192298
)
, 

-0.0001340491
)
, 

(v1_crtrecevictiontimenewest > 75.5) => 
map(

   ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 93.5) => 
map(

      ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
-0.0123867937
, 

      (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0621525922
, 

-0.0312503454
)
, 

   (v1_lifeevtimelastmove > 93.5) => 
-0.0038095936
, 

-0.0114562784
)
, 

-0.0004126226
)
;


// Tree: 442

b2_tree_442 := 
map(

( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 2.715) => 
map(

   ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 196.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 571) => 
map(

         ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 1.5) => 
-0.0023056672
, 

         (v1_raacrtreclienjudgmmbrcnt > 1.5) => 
0.0013370995
, 

-0.0009706200
)
, 

      (v1_prospecttimelastupdate > 571) => 
0.1918841097
, 

-0.0009412450
)
, 

   (v1_crtrecfelonytimenewest > 196.5) => 
map(

      ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 1.5) => 
-0.0450354248
, 

      (v1_raayoungadultmmbrcnt > 1.5) => 
0.0056509462
, 

-0.0213951411
)
, 

-0.0010261038
)
, 

(v1_resinputavmcntyratio > 2.715) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
0.0334980134
, 

   (v1_hhcnt > 1.5) => 
-0.0199108115
, 

0.0074479521
)
, 

-0.0008935236
)
;


// Tree: 446

b2_tree_446 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 105.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 94.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 5.5) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 947526) => 
map(

            ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 4.5) => 
0.0005087423
, 

            (v1_raapropcurrownermmbrcnt > 4.5) => 
-0.0081186883
, 

-0.0005731977
)
, 

         (v1_raapropowneravmmed > 947526) => 
0.0584558749
, 

-0.0003867487
)
, 

      (v1_lifeevtimelastmove > 5.5) => 
0.0086138388
, 

0.0010447056
)
, 

   (v1_prospecttimeonrecord > 94.5) => 
-0.0058969429
, 

-0.0010294621
)
, 

(v1_prospecttimelastupdate > 105.5) => 
map(

   ( NULL < v1_crtreclienjudgcnt and v1_crtreclienjudgcnt <= 1.5) => 
0.0126800042
, 

   (v1_crtreclienjudgcnt > 1.5) => 
-0.0157909806
, 

0.0098138116
)
, 

-0.0004291972
)
;


// Tree: 450

b2_tree_450 := 
map(

( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 0.5) => 
0.0013131431
, 

(v1_raaoccproflicmmbrcnt > 0.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 46.5) => 
-0.0058767442
, 

   (v1_prospecttimelastupdate > 46.5) => 
map(

      ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 2.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 11.5) => 
-0.0113565745
, 

         (v1_raammbrcnt > 11.5) => 
map(

            ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.195) => 
map(

               ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 1.425) => 
0.0014203892
, 

               (v1_rescurravmratiodiff60mo > 1.425) => 
0.1045284498
, 

0.0034125554
)
, 

            (v1_resinputavmratiodiff12mo > 1.195) => 
0.0399255710
, 

0.0092264236
)
, 

-0.0001158755
)
, 

      (v1_hhcrtrecmmbrcnt > 2.5) => 
0.0307291226
, 

0.0025609147
)
, 

-0.0039427523
)
, 

0.0000453220
)
;


// Tree: 454

b2_tree_454 := 
map(

( NULL < v1_hhcrtrecmsdmeanmmbrcnt and v1_hhcrtrecmsdmeanmmbrcnt <= 1.5) => 
map(

   ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 6.5) => 
-0.0000756474
, 

   (v1_raacrtreclienjudgmmbrcnt > 6.5) => 
0.0070371370
, 

0.0003784438
)
, 

(v1_hhcrtrecmsdmeanmmbrcnt > 1.5) => 
map(

   ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
map(

      ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 60047) => 
-0.0139001512
, 

      (v1_resinputavmvalue > 60047) => 
-0.0494576365
, 

-0.0224150513
)
, 

   (v1_hhpropcurrownermmbrcnt > 0.5) => 
map(

      ( NULL < v1_hhcnt and v1_hhcnt <= 11.5) => 
map(

         ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 809347.5) => 
-0.0089702454
, 

         (v1_hhcrtreclienjudgamtttl > 809347.5) => 
0.2407945654
, 

-0.0083941257
)
, 

      (v1_hhcnt > 11.5) => 
0.0439568022
, 

-0.0056863191
)
, 

-0.0104408657
)
, 

-0.0000956247
)
;


// Tree: 458

b2_tree_458 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 77.5) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 77.5) => 
map(

      ( NULL < v1_raacollegeattendedmmbrcnt and v1_raacollegeattendedmmbrcnt <= 8.5) => 
0.0001262504
, 

      (v1_raacollegeattendedmmbrcnt > 8.5) => 
0.0210079576
, 

0.0003972809
)
, 

   (v1_crtrectimenewest > 77.5) => 
map(

      ( NULL < v1_raacrtrecmsdmeanmmbrcnt12mo and v1_raacrtrecmsdmeanmmbrcnt12mo <= 2.5) => 
-0.0097084494
, 

      (v1_raacrtrecmsdmeanmmbrcnt12mo > 2.5) => 
-0.0521452543
, 

-0.0113650585
)
, 

-0.0004128353
)
, 

(v1_prospecttimelastupdate > 77.5) => 
map(

   ( NULL < v1_crtreccnt and v1_crtreccnt <= 3.5) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 74014) => 
0.0126220164
, 

      (v1_propcurrownedassessedttl > 74014) => 
-0.0185991219
, 

0.0068812272
)
, 

   (v1_crtreccnt > 3.5) => 
-0.0104919343
, 

0.0049945873
)
, 

0.0001248868
)
;


// Tree: 462

b2_tree_462 := 
map(

( NULL < v1_raappcurrownermmbrcnt and v1_raappcurrownermmbrcnt <= 4.5) => 
map(

   ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 228.5) => 
map(

      ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 5.5) => 
map(

         ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
map(

            ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 11.5) => 
-0.0003029053
, 

            (v1_raacrtrecmmbrcnt > 11.5) => 
0.0255719332
, 

-0.0000131136
)
, 

         (v1_raacrtrecfelonymmbrcnt > 0.5) => 
map(

            ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 1.5) => 
0.0209569636
, 

            (v1_raamiddleagemmbrcnt > 1.5) => 
0.0016152970
, 

0.0065341966
)
, 

0.0007061692
)
, 

      (v1_raacrtrecmsdmeanmmbrcnt > 5.5) => 
-0.0051177433
, 

0.0000032800
)
, 

   (v1_lifeevtimelastmove > 228.5) => 
-0.0086921185
, 

-0.0009609274
)
, 

(v1_raappcurrownermmbrcnt > 4.5) => 
0.0644240422
, 

-0.0008793954
)
;


// Tree: 466

b2_tree_466 := 
map(

( NULL < v1_donotmail and v1_donotmail <= 0.5) => 
map(

   ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 2.5) => 
-0.0002069065
, 

   (v1_crtrecbkrptcnt > 2.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 58.5) => 
map(

         ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 1.06) => 
map(

            ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 6.5) => 
map(

               ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 1.295) => 
-0.0154336468
, 

               (v1_resinputavmtractratio > 1.295) => 
0.0859900955
, 

-0.0031536421
)
, 

            (v1_raacrtrecevictionmmbrcnt > 6.5) => 
-0.1154587119
, 

-0.0121843590
)
, 

         (v1_rescurravmratiodiff60mo > 1.06) => 
0.0985851424
, 

-0.0029710168
)
, 

      (v1_crtrecbkrpttimenewest > 58.5) => 
0.0559597825
, 

0.0218521317
)
, 

-0.0001253550
)
, 

(v1_donotmail > 0.5) => 
-0.0795339692
, 

-0.0003092929
)
;


// Tree: 470

b2_tree_470 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
map(

      ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.315) => 
-0.0048195101
, 

         (v1_resinputavmcntyratio > 1.315) => 
0.0178171568
, 

-0.0030365917
)
, 

      (v1_raacrtrecmmbrcnt > 0.5) => 
map(

         ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 77764.5) => 
0.0065390073
, 

         (v1_resinputavmvalue > 77764.5) => 
-0.0033091341
, 

0.0037744024
)
, 

0.0007896233
)
, 

   (v1_hhcnt > 1.5) => 
map(

      ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
-0.0081995593
, 

      (v1_hhpropcurrownermmbrcnt > 0.5) => 
-0.0001609389
, 

-0.0025360048
)
, 

-0.0003773493
)
, 

(v1_prospectdeceased > 0.5) => 
0.0681813318
, 

-0.0003173130
)
;


// Tree: 474

b2_tree_474 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 29.5) => 
map(

   ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 2.5) => 
map(

      ( NULL < v1_hhcrtrecfelonymmbrcnt and v1_hhcrtrecfelonymmbrcnt <= 0.5) => 
0.0002066980
, 

      (v1_hhcrtrecfelonymmbrcnt > 0.5) => 
map(

         ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 279.5) => 
0.0186377664
, 

         (v1_crtrecmsdmeantimenewest > 279.5) => 
-0.1152554517
, 

0.0169117028
)
, 

0.0006088216
)
, 

   (v1_raamiddleagemmbrcnt > 2.5) => 
map(

      ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
-0.0057729513
, 

      (v1_lifeevtimefirstassetpurchase > -0.5) => 
map(

         ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 2.5) => 
0.0159457249
, 

         (v1_rescurrownershipindex > 2.5) => 
-0.0100069936
, 

-0.0019717515
)
, 

-0.0043792419
)
, 

-0.0010873685
)
, 

(v1_raammbrcnt > 29.5) => 
0.0104965393
, 

-0.0006880620
)
;


// Tree: 478

b2_tree_478 := 
map(

( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 4.5) => 
-0.0004413770
, 

(v1_crtrecbkrpttimenewest > 4.5) => 
map(

   ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

      ( NULL < v1_hhcrtreclienjudgmmbrcnt and v1_hhcrtreclienjudgmmbrcnt <= 0.5) => 
0.0113761072
, 

      (v1_hhcrtreclienjudgmmbrcnt > 0.5) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 110.5) => 
-0.0279128619
, 

         (v1_crtrecbkrpttimenewest > 110.5) => 
-0.0011751918
, 

-0.0152567785
)
, 

-0.0036113472
)
, 

   (v1_lifeevtimefirstassetpurchase > -0.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 49.5) => 
map(

         ( NULL < v1_raacrtrecevictionmmbrcnt12mo and v1_raacrtrecevictionmmbrcnt12mo <= 0.5) => 
0.0651095379
, 

         (v1_raacrtrecevictionmmbrcnt12mo > 0.5) => 
-0.0168319177
, 

0.0553294287
)
, 

      (v1_crtrecbkrpttimenewest > 49.5) => 
0.0138921035
, 

0.0260680000
)
, 

0.0099594521
)
, 

0.0002365127
)
;


// Tree: 482

b2_tree_482 := 
map(

( NULL < v1_hhcrtrecbkrptmmbrcnt and v1_hhcrtrecbkrptmmbrcnt <= 2.5) => 
map(

   ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 9.5) => 
-0.0003338407
, 

   (v1_crtrecmsdmeancnt > 9.5) => 
map(

      ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 107944.5) => 
map(

         ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 89.5) => 
map(

            ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 245) => 
0.0245855236
, 

            (v1_crtrecfelonytimenewest > 245) => 
-0.0690680579
, 

0.0224507729
)
, 

         (v1_crtrecmsdmeantimenewest > 89.5) => 
-0.0227464759
, 

0.0176002640
)
, 

      (v1_resinputavmvalue60mo > 107944.5) => 
-0.0164109562
, 

0.0118729379
)
, 

-0.0001527154
)
, 

(v1_hhcrtrecbkrptmmbrcnt > 2.5) => 
map(

   ( NULL < v1_raacrtrecmmbrcnt12mo and v1_raacrtrecmmbrcnt12mo <= 2.5) => 
0.0416738238
, 

   (v1_raacrtrecmmbrcnt12mo > 2.5) => 
-0.0411076741
, 

0.0301869417
)
, 

-0.0000459529
)
;


// Tree: 486

b2_tree_486 := 
map(

( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 21.5) => 
map(

   ( NULL < v1_hhcrtrecbkrptmmbrcnt and v1_hhcrtrecbkrptmmbrcnt <= 1.5) => 
map(

      ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 1.5) => 
0.0008365164
, 

      (v1_hhmiddleagemmbrcnt > 1.5) => 
-0.0134571054
, 

-0.0005109110
)
, 

   (v1_hhcrtrecbkrptmmbrcnt > 1.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 35.5) => 
map(

         ( NULL < v1_lifeevtimelastassetpurchase and v1_lifeevtimelastassetpurchase <= 83.5) => 
0.0167386840
, 

         (v1_lifeevtimelastassetpurchase > 83.5) => 
map(

            ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 12.5) => 
0.0370904042
, 

            (v1_crtrectimenewest > 12.5) => 
0.1338485753
, 

0.0869709097
)
, 

0.0316762311
)
, 

      (v1_crtrecbkrpttimenewest > 35.5) => 
-0.0000543425
, 

0.0121311629
)
, 

-0.0001467019
)
, 

(v1_raacrtrecmsdmeanmmbrcnt > 21.5) => 
-0.0276342569
, 

-0.0002932332
)
;


// Tree: 490

b2_tree_490 := 
map(

( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 8.5) => 
-0.0005622013
, 

(v1_crtreclienjudgtimenewest > 8.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 18.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 3.5) => 
-0.0158558344
, 

      (v1_prospecttimelastupdate > 3.5) => 
0.0591577718
, 

0.0398450066
)
, 

   (v1_prospecttimeonrecord > 18.5) => 
map(

      ( NULL < v1_lifeevecontrajectoryindex and v1_lifeevecontrajectoryindex <= 4.5) => 
map(

         ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 34.5) => 
-0.0094385688
, 

         (v1_occbusinessassociationtime > 34.5) => 
0.0323167303
, 

-0.0056930134
)
, 

      (v1_lifeevecontrajectoryindex > 4.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 56.5) => 
0.0270186204
, 

         (v1_prospecttimeonrecord > 56.5) => 
0.0048245155
, 

0.0062214304
)
, 

0.0035243562
)
, 

0.0043061448
)
, 

0.0000192011
)
;


// Tree: 494

b2_tree_494 := 
map(

( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.485) => 
map(

   ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 118.5) => 
map(

         ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 1.5) => 
-0.0036335402
, 

         (v1_hhcrtrecmmbrcnt > 1.5) => 
0.0116708607
, 

-0.0028446354
)
, 

      (v1_crtreclienjudgtimenewest > 118.5) => 
-0.0262009317
, 

-0.0032480743
)
, 

   (v1_raacrtrecmsdmeanmmbrcnt > 0.5) => 
map(

      ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 77012) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
0.0048250572
, 

         (v1_hhcnt > 1.5) => 
-0.0021262696
, 

0.0021118843
)
, 

      (v1_resinputavmvalue > 77012) => 
-0.0051070573
, 

-0.0003292146
)
, 

-0.0017376068
)
, 

(v1_resinputavmratiodiff12mo > 1.485) => 
0.0111201831
, 

-0.0012747753
)
;


// Tree: 498

b2_tree_498 := 
map(

(v1_resinputdwelltype in ['-1','F','H','R','U']) => 
map(

   ( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 239.5) => 
map(

      ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 0.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 18.5) => 
-0.0029131899
, 

         (v1_raammbrcnt > 18.5) => 
0.0134800801
, 

-0.0013558930
)
, 

      (v1_resinputbusinesscnt > 0.5) => 
-0.0110385394
, 

-0.0041902150
)
, 

   (v1_crtrecevictiontimenewest > 239.5) => 
0.2045339109
, 

-0.0041251681
)
, 

(v1_resinputdwelltype in ['0','G','P','S']) => 
map(

   ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 2.795) => 
0.0002475946
, 

   (v1_resinputavmcntyratio > 2.795) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0415632761
, 

      (v1_lifeeveverresidedcnt > 0.5) => 
0.0014411391
, 

0.0175628747
)
, 

0.0005336828
)
, 

-0.0004918870
)
;


// Tree: 502

b2_tree_502 := 
map(

( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 1.5) => 
map(

   ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
map(

      ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 2.5) => 
0.0014399359
, 

         (v1_raammbrcnt > 2.5) => 
-0.0081712091
, 

-0.0005945282
)
, 

      (v1_raacrtreclienjudgmmbrcnt > 0.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 79.5) => 
map(

            ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 0.855) => 
0.0133348669
, 

            (v1_resinputavmcntyratio > 0.855) => 
-0.0109106090
, 

0.0101388724
)
, 

         (v1_prospecttimeonrecord > 79.5) => 
-0.0021217659
, 

0.0053648596
)
, 

0.0006017665
)
, 

   (v1_raacrtrecfelonymmbrcnt > 0.5) => 
0.0130708435
, 

0.0012921452
)
, 

(v1_raamiddleagemmbrcnt > 1.5) => 
-0.0015689305
, 

-0.0001211087
)
;


// Tree: 506

b2_tree_506 := 
map(

( NULL < v1_crtrecevictioncnt12mo and v1_crtrecevictioncnt12mo <= 3.5) => 
map(

   ( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 0.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 316.5) => 
0.0003064446
, 

      (v1_lifeevtimelastmove > 316.5) => 
map(

         ( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 147.5) => 
-0.0163971050
, 

         (v1_crtrecevictiontimenewest > 147.5) => 
-0.1126928173
, 

-0.0168316035
)
, 

-0.0003324029
)
, 

   (v1_hhelderlymmbrcnt > 0.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 1.5) => 
map(

         ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 0.5) => 
-0.0203711440
, 

         (v1_raacrtrecevictionmmbrcnt > 0.5) => 
-0.0847755793
, 

-0.0340586141
)
, 

      (v1_prospecttimeonrecord > 1.5) => 
0.0164221411
, 

0.0137166231
)
, 

0.0002254169
)
, 

(v1_crtrecevictioncnt12mo > 3.5) => 
-0.0558677419
, 

0.0001905573
)
;


// Tree: 510

b2_tree_510 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 105.5) => 
map(

   (v1_resinputdwelltype in ['-1','F','U']) => 
-0.0319286059
, 

   (v1_resinputdwelltype in ['0','G','H','P','R','S']) => 
map(

      ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 5441) => 
map(

         ( NULL < v1_crtreclienjudgcnt and v1_crtreclienjudgcnt <= 2.5) => 
-0.0011693396
, 

         (v1_crtreclienjudgcnt > 2.5) => 
-0.0161128206
, 

-0.0014005441
)
, 

      (v1_hhcrtreclienjudgamtttl > 5441) => 
0.0050458004
, 

-0.0009312757
)
, 

-0.0010561309
)
, 

(v1_prospecttimelastupdate > 105.5) => 
map(

   ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 26551) => 
0.0091221498
, 

   (v1_hhcrtreclienjudgamtttl > 26551) => 
map(

      ( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.94) => 
-0.0343447390
, 

      (v1_rescurravmratiodiff12mo > 1.94) => 
0.2001701965
, 

-0.0287970738
)
, 

0.0078340763
)
, 

-0.0005650248
)
;


// Tree: 514

b2_tree_514 := 
map(

( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 95.5) => 
map(

   ( NULL < v1_rescurravmtractratio and v1_rescurravmtractratio <= 0.255) => 
map(

      ( NULL < v1_occbusinessassociation and v1_occbusinessassociation <= 0.5) => 
0.0009474436
, 

      (v1_occbusinessassociation > 0.5) => 
-0.0150852985
, 

0.0005059258
)
, 

   (v1_rescurravmtractratio > 0.255) => 
map(

      ( NULL < v1_rescurravmvalue and v1_rescurravmvalue <= 30355.5) => 
map(

         ( NULL < v1_raacrtrecmsdmeanmmbrcnt12mo and v1_raacrtrecmsdmeanmmbrcnt12mo <= 2.5) => 
0.0426859056
, 

         (v1_raacrtrecmsdmeanmmbrcnt12mo > 2.5) => 
map(

            ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 0.23) => 
-0.2342062362
, 

            (v1_rescurravmcntyratio > 0.23) => 
0.0754064017
, 

-0.1206816023
)
, 

0.0374159860
)
, 

      (v1_rescurravmvalue > 30355.5) => 
0.0130440725
, 

0.0146577618
)
, 

0.0017159718
)
, 

(v1_prospecttimeonrecord > 95.5) => 
-0.0033661998
, 

0.0000028277
)
;


// Tree: 518

b2_tree_518 := 
map(

( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 2504210) => 
map(

   ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhcrtrecevictionmmbrcnt and v1_hhcrtrecevictionmmbrcnt <= 0.5) => 
0.0005237284
, 

      (v1_hhcrtrecevictionmmbrcnt > 0.5) => 
0.0083865521
, 

0.0009638994
)
, 

   (v1_hhyoungadultmmbrcnt > 0.5) => 
map(

      ( NULL < v1_crtreccnt and v1_crtreccnt <= 2.5) => 
map(

         ( NULL < v1_raahhcnt and v1_raahhcnt <= 0.5) => 
0.0305396491
, 

         (v1_raahhcnt > 0.5) => 
-0.0016048129
, 

0.0004897296
)
, 

      (v1_crtreccnt > 2.5) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 30.5) => 
-0.0101903643
, 

         (v1_crtrecbkrpttimenewest > 30.5) => 
-0.0348044834
, 

-0.0137909668
)
, 

-0.0034443157
)
, 

0.0003281793
)
, 

(v1_crtreclienjudgamtttl > 2504210) => 
-0.1833934493
, 

0.0003155756
)
;


// Tree: 522

b2_tree_522 := 
map(

( NULL < v1_crtrecevictioncnt12mo and v1_crtrecevictioncnt12mo <= 5.5) => 
map(

   ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 2.5) => 
0.0000581191
, 

   (v1_crtrecbkrptcnt > 2.5) => 
map(

      ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhcollegetiermmbrhighest and v1_hhcollegetiermmbrhighest <= 4.5) => 
map(

            ( NULL < v1_raacrtrecevictionmmbrcnt12mo and v1_raacrtrecevictionmmbrcnt12mo <= 0.5) => 
map(

               ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 127.5) => 
0.0181822287
, 

               (v1_lifeevtimelastmove > 127.5) => 
0.0850725305
, 

0.0558933428
)
, 

            (v1_raacrtrecevictionmmbrcnt12mo > 0.5) => 
-0.0408473392
, 

0.0432376881
)
, 

         (v1_hhcollegetiermmbrhighest > 4.5) => 
0.2506781247
, 

0.0507729177
)
, 

      (v1_raacrtrecfelonymmbrcnt > 0.5) => 
-0.0112592128
, 

0.0221481946
)
, 

0.0001356006
)
, 

(v1_crtrecevictioncnt12mo > 5.5) => 
-0.0938610096
, 

0.0001162554
)
;


// Tree: 526

b2_tree_526 := 
map(

( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 2.435) => 
-0.0007486001
, 

(v1_resinputavmcntyratio > 2.435) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 20.5) => 
map(

      ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 2.005) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 211403.5) => 
map(

            ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 1.5) => 
0.0368757235
, 

            (v1_raacrtrecmmbrcnt > 1.5) => 
-0.0436487657
, 

0.0206259230
)
, 

         (v1_raapropowneravmmed > 211403.5) => 
0.0896399444
, 

0.0508164385
)
, 

      (v1_resinputavmblockratio > 2.005) => 
map(

         ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 1719449) => 
-0.0060614757
, 

         (v1_raapropowneravmhighest > 1719449) => 
0.1710003366
, 

0.0004218483
)
, 

0.0324658567
)
, 

   (v1_prospecttimeonrecord > 20.5) => 
-0.0019707732
, 

0.0125474803
)
, 

-0.0004717907
)
;


// Tree: 530

b2_tree_530 := 
map(

( NULL < v1_raacrtrecmsdmeanmmbrcnt12mo and v1_raacrtrecmsdmeanmmbrcnt12mo <= 3.5) => 
map(

   ( NULL < v1_crtreclienjudgcnt12mo and v1_crtreclienjudgcnt12mo <= 3.5) => 
map(

      ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 1.5) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 47.5) => 
-0.0002193476
, 

         (v1_prospecttimelastupdate > 47.5) => 
map(

            ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 1.5) => 
0.0086660694
, 

            (v1_verifiedcurrresmatchindex > 1.5) => 
-0.0038617466
, 

0.0034282369
)
, 

0.0003910775
)
, 

      (v1_hhseniormmbrcnt > 1.5) => 
-0.0199531536
, 

-0.0001311254
)
, 

   (v1_crtreclienjudgcnt12mo > 3.5) => 
map(

      ( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 0.67) => 
-0.1407336432
, 

      (v1_resinputavmratiodiff60mo > 0.67) => 
0.0675732296
, 

-0.0777571468
)
, 

-0.0001583761
)
, 

(v1_raacrtrecmsdmeanmmbrcnt12mo > 3.5) => 
-0.0136850504
, 

-0.0003125820
)
;


// Tree: 534

b2_tree_534 := 
map(

( NULL < v1_raacollegeattendedmmbrcnt and v1_raacollegeattendedmmbrcnt <= 8.5) => 
map(

   ( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 105.5) => 
-0.0001938948
, 

   (v1_crtrecevictiontimenewest > 105.5) => 
map(

      ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 0.455) => 
map(

         ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 8.5) => 
-0.0014871926
, 

         (v1_resinputbusinesscnt > 8.5) => 
-0.0972590087
, 

-0.0037192356
)
, 

      (v1_rescurravmcntyratio > 0.455) => 
map(

         ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 6875) => 
-0.0578065323
, 

         (v1_hhcrtreclienjudgamtttl > 6875) => 
0.0097561355
, 

-0.0383046595
)
, 

-0.0123329990
)
, 

-0.0003785990
)
, 

(v1_raacollegeattendedmmbrcnt > 8.5) => 
map(

   ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 16814.5) => 
0.0107428589
, 

   (v1_hhcrtreclienjudgamtttl > 16814.5) => 
0.0725580832
, 

0.0143222484
)
, 

-0.0001583272
)
;


// Tree: 538

b2_tree_538 := 
map(

( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

   ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
-0.0022825163
, 

   (v1_hhpropcurrownermmbrcnt > 0.5) => 
map(

      ( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 228.5) => 
0.0087356342
, 

      (v1_crtrecevictiontimenewest > 228.5) => 
0.2449398407
, 

0.0089353611
)
, 

-0.0009360316
)
, 

(v1_resinputownershipindex > 0.5) => 
map(

   ( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 27650) => 
0.0030628439
, 

   (v1_rescurrmortgageamount > 27650) => 
map(

      ( NULL < v1_hhcrtrecbkrptmmbrcnt and v1_hhcrtrecbkrptmmbrcnt <= 1.5) => 
-0.0274549678
, 

      (v1_hhcrtrecbkrptmmbrcnt > 1.5) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 46.5) => 
0.0776539697
, 

         (v1_crtrectimenewest > 46.5) => 
-0.0065679834
, 

0.0366453748
)
, 

-0.0236046736
)
, 

0.0000218330
)
, 

-0.0003971042
)
;


// Tree: 542

b2_tree_542 := 
map(

( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 17.5) => 
map(

   ( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 14.5) => 
map(

      ( NULL < v1_lifeevtimelastassetpurchase and v1_lifeevtimelastassetpurchase <= 149.5) => 
-0.0001426766
, 

      (v1_lifeevtimelastassetpurchase > 149.5) => 
map(

         ( NULL < v1_crtreccnt and v1_crtreccnt <= 1.5) => 
0.0042594895
, 

         (v1_crtreccnt > 1.5) => 
map(

            ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 4.5) => 
0.0237531065
, 

            (v1_lifeeveverresidedcnt > 4.5) => 
map(

               ( NULL < v1_proptimelastsale and v1_proptimelastsale <= 41.5) => 
0.1859274154
, 

               (v1_proptimelastsale > 41.5) => 
0.0237110925
, 

0.0835695142
)
, 

0.0317188296
)
, 

0.0110245933
)
, 

0.0002350564
)
, 

   (v1_rescurrbusinesscnt > 14.5) => 
-0.0399688955
, 

0.0001684890
)
, 

(v1_resinputbusinesscnt > 17.5) => 
-0.0167759983
, 

-0.0000503909
)
;


// Tree: 546

b2_tree_546 := 
map(

( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 5.5) => 
map(

   ( NULL < v1_hhcrtrecmsdmeanmmbrcnt12mo and v1_hhcrtrecmsdmeanmmbrcnt12mo <= 1.5) => 
map(

      ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

         ( NULL < v1_hhcrtrecmmbrcnt12mo and v1_hhcrtrecmmbrcnt12mo <= 2.5) => 
map(

            ( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 0.5) => 
-0.0001526847
, 

            (v1_raaoccbusinessassocmmbrcnt > 0.5) => 
-0.0064781402
, 

-0.0021760940
)
, 

         (v1_hhcrtrecmmbrcnt12mo > 2.5) => 
0.1021169233
, 

-0.0021237488
)
, 

      (v1_resinputownershipindex > 0.5) => 
0.0013442596
, 

-0.0001724390
)
, 

   (v1_hhcrtrecmsdmeanmmbrcnt12mo > 1.5) => 
-0.0366848148
, 

-0.0002467932
)
, 

(v1_raacrtrecfelonymmbrcnt > 5.5) => 
map(

   ( NULL < v1_lifeevecontrajectory and v1_lifeevecontrajectory <= 7.5) => 
0.0238858482
, 

   (v1_lifeevecontrajectory > 7.5) => 
-0.0843605374
, 

0.0191940544
)
, 

-0.0001454326
)
;


// Tree: 550

b2_tree_550 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

   ( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 19.98) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 58.5) => 
-0.0005783652
, 

      (v1_prospecttimelastupdate > 58.5) => 
map(

         ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 16.5) => 
0.0047457627
, 

         (v1_raacrtrecevictionmmbrcnt > 16.5) => 
0.1688421738
, 

0.0048192321
)
, 

0.0001521572
)
, 

   (v1_rescurravmblockratio > 19.98) => 
0.1993053293
, 

0.0001690506
)
, 

(v1_prospectdeceased > 0.5) => 
map(

   ( NULL < v1_crtreccnt and v1_crtreccnt <= 1.5) => 
map(

      ( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 276000) => 
0.0834881475
, 

      (v1_rescurravmvalue60mo > 276000) => 
0.4237081063
, 

0.1083356726
)
, 

   (v1_crtreccnt > 1.5) => 
-0.0488589086
, 

0.0677270725
)
, 

0.0002344811
)
;


// Tree: 554

b2_tree_554 := 
map(

( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 1.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 1389565.5) => 
map(

      ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 50.92) => 
0.0008968156
, 

      (v1_resinputavmblockratio > 50.92) => 
0.2549625847
, 

0.0009094710
)
, 

   (v1_raapropowneravmmed > 1389565.5) => 
0.0714585749
, 

0.0009895668
)
, 

(v1_hhmiddleagemmbrcnt > 1.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

      ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 3.225) => 
0.0255886800
, 

      (v1_rescurravmcntyratio > 3.225) => 
0.3891471442
, 

0.0297850526
)
, 

   (v1_lifeeveverresidedcnt > 0.5) => 
map(

      ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 141.5) => 
-0.0108527953
, 

      (v1_crtrecfelonytimenewest > 141.5) => 
-0.0546272642
, 

-0.0112384210
)
, 

-0.0097753257
)
, 

-0.0001712243
)
;


// Tree: 558

b2_tree_558 := 
map(

( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 45.5) => 
map(

   ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 14.5) => 
map(

      ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 3.5) => 
0.0011168764
, 

      (v1_raamiddleagemmbrcnt > 3.5) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 76233) => 
-0.0107528226
, 

         (v1_raapropowneravmmed > 76233) => 
-0.0012072952
, 

-0.0035434801
)
, 

0.0000479033
)
, 

   (v1_raacrtrecmmbrcnt > 14.5) => 
map(

      ( NULL < v1_crtrecevictioncnt and v1_crtrecevictioncnt <= 6.5) => 
map(

         ( NULL < v1_lifeevnamechange and v1_lifeevnamechange <= 0.5) => 
0.0124792671
, 

         (v1_lifeevnamechange > 0.5) => 
-0.0103701942
, 

0.0085644702
)
, 

      (v1_crtrecevictioncnt > 6.5) => 
-0.0522113974
, 

0.0071042113
)
, 

0.0003693999
)
, 

(v1_raacrtrecmmbrcnt > 45.5) => 
-0.0475443639
, 

0.0003212549
)
;


// Tree: 562

b2_tree_562 := 
map(

( NULL < v1_hhcnt and v1_hhcnt <= 8.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

      ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 340.5) => 
0.0016906816
, 

      (v1_crtrecfelonytimenewest > 340.5) => 
0.1020337977
, 

0.0017248590
)
, 

   (v1_hhmiddleagemmbrcnt > 0.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 1.5) => 
-0.0238163261
, 

      (v1_prospecttimeonrecord > 1.5) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
0.0092871624
, 

         (v1_hhcnt > 1.5) => 
map(

            ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 33.5) => 
0.0204680945
, 

            (v1_prospecttimeonrecord > 33.5) => 
-0.0065068290
, 

-0.0054642428
)
, 

-0.0029147696
)
, 

-0.0040039202
)
, 

0.0001493793
)
, 

(v1_hhcnt > 8.5) => 
0.0169398677
, 

0.0004763075
)
;


// Tree: 566

b2_tree_566 := 
map(

( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 2.5) => 
map(

   ( NULL < v1_resinputdwelltypeindex and v1_resinputdwelltypeindex <= 0.5) => 
-0.0531750630
, 

   (v1_resinputdwelltypeindex > 0.5) => 
-0.0005873398
, 

-0.0006505541
)
, 

(v1_hhpropcurrownermmbrcnt > 2.5) => 
map(

   ( NULL < v1_crtreccnt and v1_crtreccnt <= 6.5) => 
0.0164904278
, 

   (v1_crtreccnt > 6.5) => 
map(

      ( NULL < v1_raacrtrecbkrptmmbrcnt36mo and v1_raacrtrecbkrptmmbrcnt36mo <= 2.5) => 
map(

         ( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 0.5) => 
map(

            ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 0.61) => 
0.0084361734
, 

            (v1_resinputavmtractratio > 0.61) => 
0.1429885342
, 

0.0843931513
)
, 

         (v1_rescurrbusinesscnt > 0.5) => 
0.0001323147
, 

0.0414301160
)
, 

      (v1_raacrtrecbkrptmmbrcnt36mo > 2.5) => 
0.2166342410
, 

0.0512363170
)
, 

0.0179112240
)
, 

-0.0001596262
)
;


// Tree: 570

b2_tree_570 := 
map(

( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 5.5) => 
-0.0009565448
, 

(v1_raacrtrecevictionmmbrcnt > 5.5) => 
map(

   ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 9.5) => 
map(

      ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 0.5) => 
0.0204430527
, 

      (v1_crtrecbkrptcnt > 0.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 16.5) => 
0.0577426301
, 

         (v1_raammbrcnt > 16.5) => 
-0.0257200872
, 

-0.0132006796
)
, 

0.0150191437
)
, 

   (v1_raapropcurrownermmbrcnt > 9.5) => 
map(

      ( NULL < v1_crtrecevictioncnt and v1_crtrecevictioncnt <= 1.5) => 
-0.0073282208
, 

      (v1_crtrecevictioncnt > 1.5) => 
map(

         ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
-0.1082295104
, 

         (v1_lifeevtimefirstassetpurchase > -0.5) => 
0.0244408326
, 

-0.0704295803
)
, 

-0.0182943794
)
, 

0.0086317780
)
, 

-0.0007486851
)
;


// Tree: 574

b2_tree_574 := 
map(

( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 13.5) => 
map(

   ( NULL < v1_raacrtrecmsdmeanmmbrcnt12mo and v1_raacrtrecmsdmeanmmbrcnt12mo <= 1.5) => 
0.0002512098
, 

   (v1_raacrtrecmsdmeanmmbrcnt12mo > 1.5) => 
map(

      ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 1.5) => 
map(

         ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 192) => 
0.0075750950
, 

         (v1_crtreclienjudgtimenewest > 192) => 
-0.0966203732
, 

0.0060401840
)
, 

      (v1_raapropcurrownermmbrcnt > 1.5) => 
map(

         ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 2593) => 
map(

            ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 2.5) => 
-0.0152717938
, 

            (v1_hhmiddleagemmbrcnt > 2.5) => 
0.1446064586
, 

-0.0145559210
)
, 

         (v1_hhpropcurravmhighest > 2593) => 
0.0023783968
, 

-0.0095811193
)
, 

-0.0059055926
)
, 

-0.0000596168
)
, 

(v1_crtrecmsdmeancnt > 13.5) => 
0.0184934304
, 

0.0000952140
)
;


// Tree: 578

b2_tree_578 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 20.5) => 
map(

   ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 5.5) => 
-0.0005328393
, 

   (v1_raayoungadultmmbrcnt > 5.5) => 
-0.0312088646
, 

-0.0007669441
)
, 

(v1_raammbrcnt > 20.5) => 
map(

   ( NULL < v1_crtrecmsdmeancnt12mo and v1_crtrecmsdmeancnt12mo <= 1.5) => 
map(

      ( NULL < v1_raacrtrecmsdmeanmmbrcnt12mo and v1_raacrtrecmsdmeanmmbrcnt12mo <= 3.5) => 
0.0067628606
, 

      (v1_raacrtrecmsdmeanmmbrcnt12mo > 3.5) => 
map(

         (v1_rescurrdwelltype in ['-1','R','S']) => 
-0.0226345793
, 

         (v1_rescurrdwelltype in ['F','H','P','U']) => 
0.0645862384
, 

-0.0149228338
)
, 

0.0049899475
)
, 

   (v1_crtrecmsdmeancnt12mo > 1.5) => 
map(

      ( NULL < v1_crtreclienjudgcnt and v1_crtreclienjudgcnt <= 3.5) => 
0.0569107668
, 

      (v1_crtreclienjudgcnt > 3.5) => 
-0.1226927724
, 

0.0432774949
)
, 

0.0055134404
)
, 

-0.0002052921
)
;


// Tree: 582

b2_tree_582 := 
map(

( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 2.195) => 
map(

   ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 3.5) => 
map(

      ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 1.5) => 
0.0000789364
, 

      (v1_raamiddleagemmbrcnt > 1.5) => 
map(

         ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 242816.5) => 
-0.0123767788
, 

         (v1_raapropowneravmhighest > 242816.5) => 
map(

            ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 2.525) => 
-0.0010920524
, 

            (v1_resinputavmcntyratio > 2.525) => 
0.0691616789
, 

0.0020757748
)
, 

-0.0058213650
)
, 

-0.0014688251
)
, 

   (v1_raacrtrecmmbrcnt > 3.5) => 
0.0021304043
, 

-0.0001283845
)
, 

(v1_resinputavmtractratio > 2.195) => 
map(

   ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.175) => 
0.0343875275
, 

   (v1_resinputavmcntyratio > 1.175) => 
0.0021548832
, 

0.0135404776
)
, 

0.0001395826
)
;


// Tree: 586

b2_tree_586 := 
map(

( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 62.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 7.5) => 
map(

      ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 4.5) => 
-0.0004087344
, 

      (v1_crtrecseverityindex > 4.5) => 
0.0139520432
, 

-0.0001440807
)
, 

   (v1_crtrecbkrpttimenewest > 7.5) => 
map(

      ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 148.5) => 
-0.0301969675
, 

         (v1_prospecttimeonrecord > 148.5) => 
0.0032154839
, 

-0.0098019923
)
, 

      (v1_verifiedcurrresmatchindex > 0.5) => 
map(

         ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 1.5) => 
0.0696441437
, 

         (v1_crtrecseverityindex > 1.5) => 
0.0174052116
, 

0.0321891477
)
, 

0.0133776192
)
, 

0.0003609148
)
, 

(v1_crtrectimenewest > 62.5) => 
-0.0052461678
, 

-0.0003829280
)
;


// Tree: 590

b2_tree_590 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 107.5) => 
-0.0006237138
, 

(v1_prospecttimelastupdate > 107.5) => 
map(

   ( NULL < v1_crtreclienjudgcnt and v1_crtreclienjudgcnt <= 1.5) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 58387) => 
0.0139351169
, 

      (v1_propcurrownedassessedttl > 58387) => 
-0.0259772186
, 

0.0068351440
)
, 

   (v1_crtreclienjudgcnt > 1.5) => 
map(

      ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 2.5) => 
map(

         ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 70883) => 
map(

            ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 0.195) => 
-0.0607604766
, 

            (v1_resinputavmtractratio > 0.195) => 
0.0098465867
, 

-0.0443468106
)
, 

         (v1_raapropowneravmhighest > 70883) => 
-0.0004891343
, 

-0.0181811153
)
, 

      (v1_crtrecmsdmeancnt > 2.5) => 
0.0785076483
, 

-0.0120328518
)
, 

0.0049015038
)
, 

-0.0003363090
)
;


// Tree: 594

b2_tree_594 := 
map(

( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 2079019) => 
map(

   ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 4.5) => 
0.0003636163
, 

   (v1_crtrecmsdmeancnt > 4.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 41.5) => 
map(

         ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 44303.5) => 
0.0152463423
, 

         (v1_hhcrtreclienjudgamtttl > 44303.5) => 
-0.0413532803
, 

0.0138206820
)
, 

      (v1_crtrectimenewest > 41.5) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 60.5) => 
-0.0136825094
, 

         (v1_prospecttimelastupdate > 60.5) => 
0.0185498704
, 

-0.0058476750
)
, 

0.0067466201
)
, 

0.0006144101
)
, 

(v1_raapropowneravmmed > 2079019) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
0.1770589580
, 

   (v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0490595890
, 

0.0931762712
)
, 

0.0006375688
)
;


// Tree: 598

b2_tree_598 := 
map(

( NULL < v1_crtreccnt and v1_crtreccnt <= 29.5) => 
map(

   ( NULL < v1_raacrtreclienjudgmmbrcnt12mo and v1_raacrtreclienjudgmmbrcnt12mo <= 0.5) => 
0.0001878196
, 

   (v1_raacrtreclienjudgmmbrcnt12mo > 0.5) => 
map(

      ( NULL < v1_crtrecevictioncnt and v1_crtrecevictioncnt <= 14.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 7.5) => 
-0.0136273677
, 

         (v1_raammbrcnt > 7.5) => 
-0.0026814548
, 

-0.0048057475
)
, 

      (v1_crtrecevictioncnt > 14.5) => 
-0.0987104538
, 

-0.0049637372
)
, 

-0.0004445060
)
, 

(v1_crtreccnt > 29.5) => 
map(

   ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 0.785) => 
map(

      ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 2.5) => 
0.0181595314
, 

      (v1_crtrecbkrptcnt > 2.5) => 
-0.1393457601
, 

0.0149495050
)
, 

   (v1_rescurravmratiodiff60mo > 0.785) => 
0.0799018724
, 

0.0232609454
)
, 

-0.0003637672
)
;


// Tree: 602

b2_tree_602 := 
map(

( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 10.5) => 
-0.0005405042
, 

(v1_crtreclienjudgtimenewest > 10.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 18.5) => 
map(

      ( NULL < v1_hhcrtreclienjudgmmbrcnt and v1_hhcrtreclienjudgmmbrcnt <= 3.5) => 
map(

         ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 51.5) => 
map(

            ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 0.5) => 
0.1182974865
, 

            (v1_raapropcurrownermmbrcnt > 0.5) => 
0.0232908063
, 

0.0614126090
)
, 

         (v1_lifeevtimelastmove > 51.5) => 
-0.0118159393
, 

0.0349038745
)
, 

      (v1_hhcrtreclienjudgmmbrcnt > 3.5) => 
0.2342410757
, 

0.0407098124
)
, 

   (v1_prospecttimeonrecord > 18.5) => 
map(

      ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 85806) => 
-0.0011958823
, 

      (v1_raapropowneravmmed > 85806) => 
0.0090166824
, 

0.0041173898
)
, 

0.0047637438
)
, 

0.0000835804
)
;


// Tree: 606

b2_tree_606 := 
map(

( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 63.5) => 
map(

   ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 4923.5) => 
map(

      ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 1.5) => 
-0.0007141676
, 

      (v1_crtrecbkrptcnt > 1.5) => 
0.0193453217
, 

-0.0005350506
)
, 

   (v1_hhcrtreclienjudgamtttl > 4923.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0449326875
, 

      (v1_lifeeveverresidedcnt > 0.5) => 
0.0049051875
, 

0.0060641228
)
, 

-0.0000389393
)
, 

(v1_crtrecevictiontimenewest > 63.5) => 
map(

   ( NULL < v1_raacrtrecmsdmeanmmbrcnt12mo and v1_raacrtrecmsdmeanmmbrcnt12mo <= 5.5) => 
map(

      ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 284500) => 
-0.0065346802
, 

      (v1_resinputavmvalue12mo > 284500) => 
-0.0659540317
, 

-0.0084281520
)
, 

   (v1_raacrtrecmsdmeanmmbrcnt12mo > 5.5) => 
0.0965033258
, 

-0.0073889325
)
, 

-0.0002485798
)
;


// Tree: 610

b2_tree_610 := 
map(

( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 193.5) => 
map(

   ( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
-0.0006012941
, 

   (v1_prospectdeceased > 0.5) => 
map(

      ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 0.5) => 
map(

         ( NULL < v1_rescurravmvalue and v1_rescurravmvalue <= 277962) => 
map(

            ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 3.5) => 
0.0756156661
, 

            (v1_raacrtrecmsdmeanmmbrcnt > 3.5) => 
-0.0860063503
, 

0.0552858527
)
, 

         (v1_rescurravmvalue > 277962) => 
0.2678994768
, 

0.0811283926
)
, 

      (v1_crtrecmsdmeancnt > 0.5) => 
-0.1263804821
, 

0.0550644760
)
, 

-0.0005538200
)
, 

(v1_crtrectimenewest > 193.5) => 
map(

   ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 807) => 
-0.0077210177
, 

   (v1_crtreclienjudgamtttl > 807) => 
-0.0372391666
, 

-0.0144998611
)
, 

-0.0008400526
)
;


// Tree: 614

b2_tree_614 := 
map(

( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 7.5) => 
map(

   ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 15.085) => 
-0.0008208449
, 

   (v1_resinputavmblockratio > 15.085) => 
0.0875304056
, 

-0.0007895237
)
, 

(v1_crtrecmsdmeancnt > 7.5) => 
map(

   ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 1.515) => 
map(

      ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 38067.5) => 
0.0143816183
, 

      (v1_resinputavmvalue12mo > 38067.5) => 
map(

         ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 39784.5) => 
-0.1959448515
, 

         (v1_resinputavmvalue12mo > 39784.5) => 
map(

            ( NULL < v1_crtrecevictioncnt and v1_crtrecevictioncnt <= 4.5) => 
-0.0023943672
, 

            (v1_crtrecevictioncnt > 4.5) => 
-0.0997769435
, 

-0.0065500960
)
, 

-0.0089441308
)
, 

0.0079630934
)
, 

   (v1_rescurravmratiodiff60mo > 1.515) => 
0.1547402117
, 

0.0090609659
)
, 

-0.0005822613
)
;


// Tree: 618

b2_tree_618 := 
map(

( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 1.5) => 
map(

   ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 1.595) => 
map(

      ( NULL < v1_raacrtrecmsdmeanmmbrcnt12mo and v1_raacrtrecmsdmeanmmbrcnt12mo <= 1.5) => 
0.0003204490
, 

      (v1_raacrtrecmsdmeanmmbrcnt12mo > 1.5) => 
-0.0059976734
, 

-0.0000174477
)
, 

   (v1_resinputavmtractratio > 1.595) => 
map(

      ( NULL < v1_crtrecevictioncnt and v1_crtrecevictioncnt <= 6.5) => 
0.0101988090
, 

      (v1_crtrecevictioncnt > 6.5) => 
-0.0929298121
, 

0.0097734110
)
, 

0.0004335896
)
, 

(v1_hhmiddleagemmbrcnt > 1.5) => 
map(

   ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 10.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0206528630
, 

      (v1_lifeeveverresidedcnt > 0.5) => 
-0.0104401625
, 

-0.0093201955
)
, 

   (v1_hhcrtrecmmbrcnt > 10.5) => 
-0.1714149833
, 

-0.0094170444
)
, 

-0.0006309216
)
;


// Tree: 622

b2_tree_622 := 
map(

( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 0.785) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 342858.5) => 
map(

      ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 1.5) => 
0.0000436309
, 

         (v1_raammbrcnt > 1.5) => 
-0.0139071274
, 

-0.0023871945
)
, 

      (v1_raacrtrecmmbrcnt > 0.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 55.5) => 
map(

            ( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 0.5) => 
0.0061822473
, 

            (v1_occproflicensecategory > 0.5) => 
-0.0279596793
, 

0.0056647017
)
, 

         (v1_prospecttimeonrecord > 55.5) => 
-0.0011583625
, 

0.0025207899
)
, 

0.0007040348
)
, 

   (v1_raapropowneravmmed > 342858.5) => 
-0.0116461481
, 

0.0000117371
)
, 

(v1_resinputavmcntyratio > 0.785) => 
-0.0041731326
, 

-0.0010420461
)
;


// Tree: 626

b2_tree_626 := 
map(

( NULL < v1_raacollegeattendedmmbrcnt and v1_raacollegeattendedmmbrcnt <= 4.5) => 
map(

   ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 192.5) => 
map(

         ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 3.5) => 
0.0016809223
, 

         (v1_raapropcurrownermmbrcnt > 3.5) => 
-0.0036413822
, 

0.0004352315
)
, 

      (v1_crtrectimenewest > 192.5) => 
-0.0176356173
, 

0.0001258337
)
, 

   (v1_hhseniormmbrcnt > 0.5) => 
map(

      ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
-0.0198838296
, 

      (v1_hhpropcurrownermmbrcnt > 0.5) => 
-0.0025050458
, 

-0.0070039358
)
, 

-0.0005064881
)
, 

(v1_raacollegeattendedmmbrcnt > 4.5) => 
map(

   ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 186767) => 
0.0067808999
, 

   (v1_crtreclienjudgamtttl > 186767) => 
0.1330835872
, 

0.0071147146
)
, 

0.0000404274
)
;


// Tree: 630

b2_tree_630 := 
map(

( NULL < v1_crtrecevictioncnt12mo and v1_crtrecevictioncnt12mo <= 4.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 28.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 7.5) => 
-0.0016698382
, 

      (v1_crtrecbkrpttimenewest > 7.5) => 
0.0089600272
, 

-0.0012606180
)
, 

   (v1_prospecttimelastupdate > 28.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

         ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 3.5) => 
map(

            ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 31.5) => 
0.1754699393
, 

            (v1_prospecttimelastupdate > 31.5) => 
0.0299253507
, 

0.0349610706
)
, 

         (v1_raacrtrecmsdmeanmmbrcnt > 3.5) => 
-0.1220651018
, 

0.0293393037
)
, 

      (v1_lifeeveverresidedcnt > 0.5) => 
0.0024266767
, 

0.0029971132
)
, 

-0.0002639887
)
, 

(v1_crtrecevictioncnt12mo > 4.5) => 
-0.0663229366
, 

-0.0002887804
)
;


// Tree: 634

b2_tree_634 := 
map(

( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 125929.5) => 
map(

   ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 169.5) => 
map(

      ( NULL < v1_raacollegeattendedmmbrcnt and v1_raacollegeattendedmmbrcnt <= 20.5) => 
0.0015752907
, 

      (v1_raacollegeattendedmmbrcnt > 20.5) => 
0.0911277509
, 

0.0016222078
)
, 

   (v1_occbusinessassociationtime > 169.5) => 
-0.0355058549
, 

0.0011768861
)
, 

(v1_resinputavmvalue12mo > 125929.5) => 
map(

   ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 1005.5) => 
map(

      ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 7.5) => 
-0.0031047272
, 

      (v1_crtrecmsdmeantimenewest > 7.5) => 
-0.0211173878
, 

-0.0052615942
)
, 

   (v1_crtreclienjudgamtttl > 1005.5) => 
map(

      ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 85.5) => 
0.0204998589
, 

      (v1_crtreclienjudgtimenewest > 85.5) => 
-0.0120067839
, 

0.0090129286
)
, 

-0.0041235705
)
, 

-0.0000325952
)
;


// Tree: 638

b2_tree_638 := 
map(

(v1_resinputdwelltype in ['-1','0','F','H','R','S','U']) => 
0.0002383920
, 

(v1_resinputdwelltype in ['G','P']) => 
map(

   ( NULL < v1_raahhcnt and v1_raahhcnt <= 0.5) => 
map(

      ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 4835) => 
0.0228654987
, 

         (v1_hhcrtreclienjudgamtttl > 4835) => 
-0.0762871161
, 

0.0210965501
)
, 

      (v1_hhyoungadultmmbrcnt > 0.5) => 
0.0935807853
, 

0.0229222400
)
, 

   (v1_raahhcnt > 0.5) => 
map(

      ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 9961.5) => 
0.0018562612
, 

      (v1_crtreclienjudgamtttl > 9961.5) => 
map(

         ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 353) => 
-0.0595560065
, 

         (v1_propcurrownedassessedttl > 353) => 
0.0410460241
, 

-0.0346004640
)
, 

0.0006028184
)
, 

0.0074701743
)
, 

0.0005547117
)
;


// Tree: 642

b2_tree_642 := 
map(

( NULL < v1_raacrtrecfelonymmbrcnt12mo and v1_raacrtrecfelonymmbrcnt12mo <= 0.5) => 
map(

   ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 13.5) => 
map(

      ( NULL < v1_crtreccnt and v1_crtreccnt <= 88.5) => 
-0.0001174183
, 

      (v1_crtreccnt > 88.5) => 
0.1541478888
, 

-0.0001045901
)
, 

   (v1_resinputbusinesscnt > 13.5) => 
map(

      ( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 2.535) => 
map(

         ( NULL < v1_crtrecevictioncnt and v1_crtrecevictioncnt <= 8.5) => 
-0.0165190966
, 

         (v1_crtrecevictioncnt > 8.5) => 
-0.1652199380
, 

-0.0170054139
)
, 

      (v1_rescurravmblockratio > 2.535) => 
0.2645167008
, 

-0.0153158588
)
, 

-0.0003533738
)
, 

(v1_raacrtrecfelonymmbrcnt12mo > 0.5) => 
map(

   ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 2.79) => 
0.0145400825
, 

   (v1_resinputavmratiodiff12mo > 2.79) => 
0.1468041929
, 

0.0155034630
)
, 

-0.0001425286
)
;


// Tree: 646

b2_tree_646 := 
map(

( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 1.5) => 
0.0004505162
, 

(v1_hhyoungadultmmbrcnt > 1.5) => 
map(

   ( NULL < v1_raacrtrecmsdmeanmmbrcnt12mo and v1_raacrtrecmsdmeanmmbrcnt12mo <= 6.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 2.5) => 
map(

         ( NULL < v1_crtreccnt and v1_crtreccnt <= 7.5) => 
0.0179927959
, 

         (v1_crtreccnt > 7.5) => 
0.2124271453
, 

0.0216663194
)
, 

      (v1_raammbrcnt > 2.5) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 4.5) => 
-0.0390284925
, 

         (v1_hhcnt > 4.5) => 
map(

            ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 180550) => 
0.0194481732
, 

            (v1_resinputavmvalue > 180550) => 
-0.0684962277
, 

-0.0017869295
)
, 

-0.0284503436
)
, 

-0.0229232641
)
, 

   (v1_raacrtrecmsdmeanmmbrcnt12mo > 6.5) => 
0.2070731084
, 

-0.0222406810
)
, 

-0.0001665681
)
;


// Tree: 650

b2_tree_650 := 
map(

( NULL < v1_hhcrtrecbkrptmmbrcnt and v1_hhcrtrecbkrptmmbrcnt <= 4.5) => 
map(

   ( NULL < v1_rescurravmtractratio and v1_rescurravmtractratio <= 20.475) => 
map(

      ( NULL < v1_raacollege2yrattendedmmbrcnt and v1_raacollege2yrattendedmmbrcnt <= 3.5) => 
map(

         ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 10.5) => 
0.0001117174
, 

         (v1_raacrtrecevictionmmbrcnt > 10.5) => 
map(

            ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 108.5) => 
0.0179900867
, 

            (v1_prospecttimelastupdate > 108.5) => 
0.1626498579
, 

0.0249978265
)
, 

0.0001700599
)
, 

      (v1_raacollege2yrattendedmmbrcnt > 3.5) => 
map(

         ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 21.5) => 
-0.0370798277
, 

         (v1_crtrecmsdmeantimenewest > 21.5) => 
0.0136767345
, 

-0.0229083601
)
, 

0.0000576272
)
, 

   (v1_rescurravmtractratio > 20.475) => 
0.1551625941
, 

0.0000688952
)
, 

(v1_hhcrtrecbkrptmmbrcnt > 4.5) => 
-0.1154774869
, 

0.0000539742
)
;


// Tree: 654

b2_tree_654 := 
map(

( NULL < v1_resinputdwelltypeindex and v1_resinputdwelltypeindex <= 1.5) => 
map(

   ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 1.5) => 
map(

      ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 24.5) => 
map(

         ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 25.765) => 
-0.0066144915
, 

         (v1_resinputavmblockratio > 25.765) => 
0.2222871681
, 

-0.0065201535
)
, 

      (v1_crtrecfelonytimenewest > 24.5) => 
0.0480544444
, 

-0.0062263488
)
, 

   (v1_raacrtrecmsdmeanmmbrcnt > 1.5) => 
map(

      ( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 0.5) => 
0.0073503595
, 

      (v1_raaoccproflicmmbrcnt > 0.5) => 
map(

         ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 2.5) => 
-0.0070716481
, 

         (v1_hhmiddleagemmbrcnt > 2.5) => 
0.1164684251
, 

-0.0058183697
)
, 

0.0022273187
)
, 

-0.0035201323
)
, 

(v1_resinputdwelltypeindex > 1.5) => 
0.0011335604
, 

0.0001227789
)
;


// Tree: 658

b2_tree_658 := 
map(

( NULL < v1_raappcurrownerwtrcrftmmbrcnt and v1_raappcurrownerwtrcrftmmbrcnt <= 2.5) => 
map(

   ( NULL < v1_raacrtrecmmbrcnt12mo and v1_raacrtrecmmbrcnt12mo <= 2.5) => 
0.0003485581
, 

   (v1_raacrtrecmmbrcnt12mo > 2.5) => 
map(

      ( NULL < v1_raacollegeattendedmmbrcnt and v1_raacollegeattendedmmbrcnt <= 9.5) => 
map(

         ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 4.5) => 
map(

            ( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 7.5) => 
-0.0051322025
, 

            (v1_rescurrbusinesscnt > 7.5) => 
-0.0902216926
, 

-0.0056907631
)
, 

         (v1_lifeeveverresidedcnt > 4.5) => 
-0.0414973239
, 

-0.0074797111
)
, 

      (v1_raacollegeattendedmmbrcnt > 9.5) => 
map(

         ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 5.5) => 
0.1151408157
, 

         (v1_raamiddleagemmbrcnt > 5.5) => 
0.0126455808
, 

0.0199820818
)
, 

-0.0057657171
)
, 

-0.0000301120
)
, 

(v1_raappcurrownerwtrcrftmmbrcnt > 2.5) => 
0.0227684474
, 

0.0001571128
)
;


// Tree: 662

b2_tree_662 := 
map(

( NULL < v1_raacollegeattendedmmbrcnt and v1_raacollegeattendedmmbrcnt <= 7.5) => 
-0.0006732979
, 

(v1_raacollegeattendedmmbrcnt > 7.5) => 
map(

   ( NULL < v1_raacollegemidtiermmbrcnt and v1_raacollegemidtiermmbrcnt <= 1.5) => 
map(

      ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 42.5) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 67876) => 
map(

            ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 31.5) => 
0.0205304972
, 

            (v1_raammbrcnt > 31.5) => 
0.0791806417
, 

0.0457796369
)
, 

         (v1_raapropowneravmmed > 67876) => 
map(

            ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 121907.5) => 
0.0130583764
, 

            (v1_crtreclienjudgamtttl > 121907.5) => 
0.2303682944
, 

0.0144324177
)
, 

0.0233154045
)
, 

      (v1_raacrtrecmsdmeanmmbrcnt > 42.5) => 
-0.0901445096
, 

0.0214101489
)
, 

   (v1_raacollegemidtiermmbrcnt > 1.5) => 
-0.0053320642
, 

0.0096140722
)
, 

-0.0004565526
)
;


// Tree: 666

b2_tree_666 := 
map(

( NULL < v1_crtrecevictioncnt and v1_crtrecevictioncnt <= 25.5) => 
map(

   ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 3.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 4.5) => 
0.0009982185
, 

      (v1_raammbrcnt > 4.5) => 
-0.0055180275
, 

-0.0010750695
)
, 

   (v1_raacrtrecmmbrcnt > 3.5) => 
map(

      ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 0.5) => 
map(

         ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 358.5) => 
map(

            ( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 38900) => 
0.0059627099
, 

            (v1_rescurrmortgageamount > 38900) => 
-0.0247269639
, 

0.0038982638
)
, 

         (v1_crtrecfelonytimenewest > 358.5) => 
-0.1116898432
, 

0.0038104294
)
, 

      (v1_resinputbusinesscnt > 0.5) => 
-0.0022601438
, 

0.0017055622
)
, 

-0.0000350570
)
, 

(v1_crtrecevictioncnt > 25.5) => 
-0.1003260861
, 

-0.0000552930
)
;


// Tree: 670

b2_tree_670 := 
map(

( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 1.265) => 
map(

   ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

      ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 6.5) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 43.5) => 
-0.0007453317
, 

         (v1_crtrecbkrpttimenewest > 43.5) => 
-0.0125039653
, 

-0.0011302375
)
, 

      (v1_raapropcurrownermmbrcnt > 6.5) => 
-0.0096142777
, 

-0.0018188531
)
, 

   (v1_lifeevtimefirstassetpurchase > -0.5) => 
map(

      ( NULL < v1_hhcrtrecbkrptmmbrcnt and v1_hhcrtrecbkrptmmbrcnt <= 0.5) => 
-0.0001338008
, 

      (v1_hhcrtrecbkrptmmbrcnt > 0.5) => 
0.0181789674
, 

0.0030023733
)
, 

-0.0006312498
)
, 

(v1_resinputavmblockratio > 1.265) => 
map(

   ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
0.0099159084
, 

   (v1_verifiedcurrresmatchindex > 0.5) => 
-0.0079689020
, 

0.0022850147
)
, 

-0.0003590695
)
;


// Tree: 674

b2_tree_674 := 
map(

( NULL < v1_crtreccnt12mo and v1_crtreccnt12mo <= 11.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 121.5) => 
0.0001961689
, 

      (v1_crtrectimenewest > 121.5) => 
0.0119406016
, 

0.0005932394
)
, 

   (v1_hhmiddleagemmbrcnt > 0.5) => 
map(

      (v1_rescurrdwelltype in ['-1','P','R']) => 
-0.0148850283
, 

      (v1_rescurrdwelltype in ['F','H','S','U']) => 
map(

         ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 1.5) => 
map(

            ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0392949767
, 

            (v1_lifeeveverresidedcnt > 0.5) => 
0.0035078489
, 

0.0044019925
)
, 

         (v1_verifiedcurrresmatchindex > 1.5) => 
-0.0089475391
, 

-0.0032004323
)
, 

-0.0045876831
)
, 

-0.0008824688
)
, 

(v1_crtreccnt12mo > 11.5) => 
0.1088532745
, 

-0.0008696267
)
;


// Tree: 678

b2_tree_678 := 
map(

( NULL < v1_crtrecevictioncnt12mo and v1_crtrecevictioncnt12mo <= 5.5) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 8.5) => 
map(

      ( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 143.5) => 
-0.0000139001
, 

      (v1_crtrecevictiontimenewest > 143.5) => 
-0.0144249434
, 

-0.0001061646
)
, 

   (v1_hhcnt > 8.5) => 
map(

      ( NULL < v1_raaelderlymmbrcnt and v1_raaelderlymmbrcnt <= 1.5) => 
map(

         ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 2.295) => 
0.0156787605
, 

         (v1_rescurravmratiodiff60mo > 2.295) => 
map(

            ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 4.5) => 
0.3354768879
, 

            (v1_raamiddleagemmbrcnt > 4.5) => 
0.0115407286
, 

0.1735088083
)
, 

0.0164140508
)
, 

      (v1_raaelderlymmbrcnt > 1.5) => 
-0.0300904368
, 

0.0123328027
)
, 

0.0001301207
)
, 

(v1_crtrecevictioncnt12mo > 5.5) => 
-0.0723494809
, 

0.0001119865
)
;


// Tree: 682

b2_tree_682 := 
map(

( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 0.5) => 
-0.0017947632
, 

(v1_raacrtrecmsdmeanmmbrcnt > 0.5) => 
map(

   ( NULL < v1_prospectlastupdate12mo and v1_prospectlastupdate12mo <= 0.5) => 
map(

      ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 81804.5) => 
map(

         ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 241395) => 
map(

            ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 395147.5) => 
0.0038806270
, 

            (v1_raapropowneravmmed > 395147.5) => 
-0.0143876775
, 

0.0031666735
)
, 

         (v1_resinputavmvalue12mo > 241395) => 
map(

            ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 158080) => 
0.1092347467
, 

            (v1_resinputavmvalue > 158080) => 
-0.0094244346
, 

-0.0087688590
)
, 

0.0020376023
)
, 

      (v1_crtreclienjudgamtttl > 81804.5) => 
0.0467089959
, 

0.0021871260
)
, 

   (v1_prospectlastupdate12mo > 0.5) => 
-0.0054399788
, 

0.0006932381
)
, 

-0.0005003808
)
;


// Tree: 686

b2_tree_686 := 
map(

( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 9.5) => 
map(

   ( NULL < v1_crtreccnt and v1_crtreccnt <= 1.5) => 
map(

      ( NULL < v1_crtrecmsdmeancnt12mo and v1_crtrecmsdmeancnt12mo <= 0.5) => 
0.0008144435
, 

      (v1_crtrecmsdmeancnt12mo > 0.5) => 
-0.0314337242
, 

0.0006198215
)
, 

   (v1_crtreccnt > 1.5) => 
-0.0031826677
, 

-0.0001212092
)
, 

(v1_crtrecmsdmeancnt > 9.5) => 
map(

   ( NULL < v1_lifeevtimelastassetpurchase and v1_lifeevtimelastassetpurchase <= 107) => 
map(

      ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 126209) => 
0.0074077790
, 

      (v1_crtreclienjudgamtttl > 126209) => 
0.1652453271
, 

0.0081522957
)
, 

   (v1_lifeevtimelastassetpurchase > 107) => 
map(

      ( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 129374.5) => 
0.1424436161
, 

      (v1_rescurravmvalue60mo > 129374.5) => 
-0.0087528448
, 

0.0739529116
)
, 

0.0102212750
)
, 

0.0000340925
)
;


// Tree: 690

b2_tree_690 := 
map(

( NULL < v1_crtreccnt and v1_crtreccnt <= 6.5) => 
-0.0006218548
, 

(v1_crtreccnt > 6.5) => 
map(

   ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 63.5) => 
map(

         ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 30.5) => 
0.0154118529
, 

         (v1_crtrecmsdmeancnt > 30.5) => 
-0.0356206296
, 

0.0135067483
)
, 

      (v1_crtrectimenewest > 63.5) => 
-0.0053096886
, 

0.0091677370
)
, 

   (v1_hhyoungadultmmbrcnt > 0.5) => 
map(

      ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 520352.5) => 
map(

         ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 2.245) => 
-0.0051040100
, 

         (v1_resinputavmtractratio > 2.245) => 
0.0908294403
, 

-0.0034543607
)
, 

      (v1_resinputavmvalue > 520352.5) => 
-0.1641039860
, 

-0.0046356079
)
, 

0.0053101752
)
, 

-0.0002956702
)
;


// Tree: 694

b2_tree_694 := 
map(

( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_hhcrtrecevictionmmbrcnt and v1_hhcrtrecevictionmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 4.5) => 
map(

         ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
0.0012181352
, 

         (v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0083643156
, 

-0.0010151090
)
, 

      (v1_crtrecbkrpttimenewest > 4.5) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 48.5) => 
map(

            ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 85.5) => 
0.0033974672
, 

            (v1_lifeevtimelastmove > 85.5) => 
0.0476968379
, 

0.0332725306
)
, 

         (v1_crtrecbkrpttimenewest > 48.5) => 
0.0010432735
, 

0.0087730163
)
, 

-0.0005138168
)
, 

   (v1_hhcrtrecevictionmmbrcnt > 0.5) => 
0.0082404055
, 

-0.0000277028
)
, 

(v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0048548280
, 

-0.0007241573
)
;


// Tree: 698

b2_tree_698 := 
map(

( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 615) => 
-0.0004875943
, 

(v1_propcurrownedassessedttl > 615) => 
map(

   ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 31578) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 225.5) => 
map(

         ( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 36017.5) => 
map(

            ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.835) => 
map(

               ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 22.5) => 
0.0555335857
, 

               (v1_crtrectimenewest > 22.5) => 
0.0859652590
, 

0.0664727579
)
, 

            (v1_resinputavmratiodiff12mo > 1.835) => 
0.2385713217
, 

0.0702433054
)
, 

         (v1_resinputmortgageamount > 36017.5) => 
-0.0417614733
, 

0.0616151087
)
, 

      (v1_lifeevtimelastmove > 225.5) => 
0.0215902107
, 

0.0476013850
)
, 

   (v1_propcurrownedassessedttl > 31578) => 
0.0009612283
, 

0.0046152446
)
, 

0.0003524455
)
;


// Tree: 702

b2_tree_702 := 
map(

( NULL < v1_crtreccnt and v1_crtreccnt <= 19.5) => 
-0.0000311708
, 

(v1_crtreccnt > 19.5) => 
map(

   ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 152.5) => 
map(

      ( NULL < v1_hhcrtrecmsdmeanmmbrcnt and v1_hhcrtrecmsdmeanmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 6225.5) => 
0.0392319508
, 

         (v1_hhcrtreclienjudgamtttl > 6225.5) => 
map(

            ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 180.5) => 
-0.1419291096
, 

            (v1_prospecttimeonrecord > 180.5) => 
-0.0175103191
, 

-0.0598656520
)
, 

-0.0292619806
)
, 

      (v1_hhcrtrecmsdmeanmmbrcnt > 0.5) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 9.5) => 
0.0304873157
, 

         (v1_hhcnt > 9.5) => 
-0.0904233421
, 

0.0282535670
)
, 

0.0220191506
)
, 

   (v1_crtrecfelonytimenewest > 152.5) => 
-0.0370486200
, 

0.0158118385
)
, 

0.0001032816
)
;


// Tree: 706

b2_tree_706 := 
map(

( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 776063) => 
-0.0003000695
, 

(v1_resinputavmvalue > 776063) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 18.5) => 
map(

      ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 2.955) => 
map(

         ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 67) => 
map(

            ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 809209) => 
map(

               ( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 2.245) => 
0.0804432846
, 

               (v1_resinputavmratiodiff60mo > 2.245) => 
-0.1361719226
, 

0.0755041757
)
, 

            (v1_resinputavmvalue60mo > 809209) => 
0.0280679496
, 

0.0518247545
)
, 

         (v1_crtrecmsdmeantimenewest > 67) => 
-0.1334007253
, 

0.0482684253
)
, 

      (v1_resinputavmtractratio > 2.955) => 
-0.0170587789
, 

0.0380789694
)
, 

   (v1_prospecttimeonrecord > 18.5) => 
-0.0214326996
, 

0.0061100447
)
, 

-0.0002172929
)
;


// Tree: 710

b2_tree_710 := 
map(

( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 3.5) => 
map(

   ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 3.5) => 
map(

      ( NULL < v1_raacrtrecmmbrcnt12mo and v1_raacrtrecmmbrcnt12mo <= 1.5) => 
0.0005550705
, 

      (v1_raacrtrecmmbrcnt12mo > 1.5) => 
-0.0237178208
, 

0.0002651013
)
, 

   (v1_raacrtrecmmbrcnt > 3.5) => 
map(

      ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 37757.5) => 
map(

         ( NULL < v1_hhcrtrecmsdmeanmmbrcnt and v1_hhcrtrecmsdmeanmmbrcnt <= 1.5) => 
0.0099547977
, 

         (v1_hhcrtrecmsdmeanmmbrcnt > 1.5) => 
-0.0126289453
, 

0.0084854170
)
, 

      (v1_resinputavmvalue > 37757.5) => 
-0.0000942784
, 

0.0054145286
)
, 

0.0013233670
)
, 

(v1_raamiddleagemmbrcnt > 3.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 27575.5) => 
-0.0128456014
, 

   (v1_raapropowneravmmed > 27575.5) => 
-0.0008338189
, 

-0.0023954568
)
, 

0.0003383898
)
;


// Tree: 714

b2_tree_714 := 
map(

( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 3943.5) => 
-0.0009946202
, 

(v1_hhcrtreclienjudgamtttl > 3943.5) => 
map(

   ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 93.5) => 
map(

      ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 3.5) => 
0.0106996830
, 

      (v1_raacrtrecevictionmmbrcnt > 3.5) => 
map(

         ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 5870.5) => 
-0.0459344281
, 

         (v1_hhcrtreclienjudgamtttl > 5870.5) => 
map(

            ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= 109.5) => 
0.0059549750
, 

            (v1_lifeevtimefirstassetpurchase > 109.5) => 
-0.0577997609
, 

-0.0015631159
)
, 

-0.0091810822
)
, 

0.0080220302
)
, 

   (v1_crtreclienjudgtimenewest > 93.5) => 
map(

      ( NULL < v1_hhcrtrecbkrptmmbrcnt12mo and v1_hhcrtrecbkrptmmbrcnt12mo <= 1.5) => 
-0.0057444610
, 

      (v1_hhcrtrecbkrptmmbrcnt12mo > 1.5) => 
-0.1410172412
, 

-0.0066214320
)
, 

0.0047648480
)
, 

-0.0004788563
)
;


// Tree: 718

b2_tree_718 := 
map(

( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 3.245) => 
map(

   ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 210.5) => 
map(

      ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 69401) => 
0.0011559455
, 

      (v1_resinputavmvalue > 69401) => 
-0.0032426250
, 

-0.0002760936
)
, 

   (v1_lifeevtimelastmove > 210.5) => 
map(

      ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 1.5) => 
-0.0088771216
, 

      (v1_crtrecbkrptcnt > 1.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 470.5) => 
0.0209436803
, 

         (v1_prospecttimeonrecord > 470.5) => 
0.1997177711
, 

0.0239232485
)
, 

-0.0079439674
)
, 

-0.0012580639
)
, 

(v1_rescurravmblockratio > 3.245) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 24.5) => 
0.1493170673
, 

   (v1_prospecttimeonrecord > 24.5) => 
0.0262265112
, 

0.0346226495
)
, 

-0.0011455584
)
;


// Tree: 722

b2_tree_722 := 
map(

( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

   ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 6.5) => 
map(

      ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 10.5) => 
-0.0033934387
, 

      (v1_crtreclienjudgtimenewest > 10.5) => 
map(

         ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 6.5) => 
map(

            ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 44981.5) => 
map(

               ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 0.5) => 
0.0139342569
, 

               (v1_resinputbusinesscnt > 0.5) => 
-0.0074452294
, 

0.0099194865
)
, 

            (v1_hhcrtreclienjudgamtttl > 44981.5) => 
-0.0320880162
, 

0.0076928819
)
, 

         (v1_raamiddleagemmbrcnt > 6.5) => 
-0.0125629475
, 

0.0044369424
)
, 

-0.0025079972
)
, 

   (v1_raacrtrecevictionmmbrcnt > 6.5) => 
0.0188384473
, 

-0.0022193588
)
, 

(v1_resinputownershipindex > 0.5) => 
0.0018143719
, 

0.0000495374
)
;


// Tree: 726

b2_tree_726 := 
map(

( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 2.5) => 
map(

   ( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 70.5) => 
map(

      ( NULL < v1_hhcrtrecbkrptmmbrcnt and v1_hhcrtrecbkrptmmbrcnt <= 0.5) => 
-0.0009750618
, 

      (v1_hhcrtrecbkrptmmbrcnt > 0.5) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 29848) => 
-0.0039235321
, 

         (v1_raapropowneravmmed > 29848) => 
0.0136568319
, 

0.0087223220
)
, 

-0.0001213786
)
, 

   (v1_crtrecevictiontimenewest > 70.5) => 
-0.0096759465
, 

-0.0003508386
)
, 

(v1_raacrtrecfelonymmbrcnt > 2.5) => 
map(

   ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 89.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 1.5) => 
0.0165087928
, 

      (v1_crtrecbkrpttimenewest > 1.5) => 
-0.0154529873
, 

0.0124304250
)
, 

   (v1_crtrecmsdmeantimenewest > 89.5) => 
-0.0185381024
, 

0.0073397620
)
, 

-0.0001063448
)
;


// Tree: 730

b2_tree_730 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 36.5) => 
-0.0006101176
, 

(v1_prospecttimelastupdate > 36.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0278577724
, 

   (v1_lifeeveverresidedcnt > 0.5) => 
map(

      ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 41.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 9.5) => 
-0.0010120888
, 

         (v1_raammbrcnt > 9.5) => 
map(

            ( NULL < v1_crtrecevictioncnt and v1_crtrecevictioncnt <= 9.5) => 
0.0090492527
, 

            (v1_crtrecevictioncnt > 9.5) => 
map(

               ( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 1.5) => 
-0.0180721734
, 

               (v1_raaoccbusinessassocmmbrcnt > 1.5) => 
-0.1983881733
, 

-0.0864678975
)
, 

0.0087946222
)
, 

0.0033144774
)
, 

      (v1_crtrecfelonytimenewest > 41.5) => 
-0.0181464577
, 

0.0028237619
)
, 

0.0033530017
)
, 

0.0002144634
)
;


// Tree: 734

b2_tree_734 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 137179.5) => 
map(

      ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 1.5) => 
0.0002052401
, 

      (v1_raamiddleagemmbrcnt > 1.5) => 
-0.0047508602
, 

-0.0016264800
)
, 

   (v1_raapropowneravmmed > 137179.5) => 
map(

      ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 254.5) => 
0.0000184545
, 

      (v1_crtreclienjudgamtttl > 254.5) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 68.5) => 
map(

            ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 23.5) => 
0.0081996151
, 

            (v1_prospecttimelastupdate > 23.5) => 
0.0305970778
, 

0.0174434272
)
, 

         (v1_crtrectimenewest > 68.5) => 
-0.0032016150
, 

0.0100223976
)
, 

0.0014179319
)
, 

-0.0006855240
)
, 

(v1_prospectdeceased > 0.5) => 
0.0510759467
, 

-0.0006399880
)
;


// Tree: 738

b2_tree_738 := 
map(

( NULL < v1_crtrecbkrptcnt12mo and v1_crtrecbkrptcnt12mo <= 1.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 60.5) => 
0.0002569972
, 

   (v1_crtrecbkrpttimenewest > 60.5) => 
map(

      ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 86.5) => 
map(

         ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 11416.5) => 
-0.0058680635
, 

         (v1_crtreclienjudgamtttl > 11416.5) => 
0.0292098028
, 

-0.0028155168
)
, 

      (v1_crtreclienjudgtimenewest > 86.5) => 
-0.0267488713
, 

-0.0077422596
)
, 

-0.0000938950
)
, 

(v1_crtrecbkrptcnt12mo > 1.5) => 
map(

   ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 126895) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 56655) => 
0.0699326901
, 

      (v1_propcurrownedassessedttl > 56655) => 
-0.1389888265
, 

0.0297554754
)
, 

   (v1_hhpropcurravmhighest > 126895) => 
0.2370091687
, 

0.0830492822
)
, 

-0.0000704086
)
;


// Tree: 742

b2_tree_742 := 
map(

( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 148.5) => 
0.0000806874
, 

(v1_crtrecevictiontimenewest > 148.5) => 
map(

   ( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 164.5) => 
map(

      ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 514080.5) => 
-0.0475701758
, 

      (v1_raapropowneravmmed > 514080.5) => 
0.1786760640
, 

-0.0430722386
)
, 

   (v1_crtrecevictiontimenewest > 164.5) => 
map(

      ( NULL < v1_raacollege2yrattendedmmbrcnt and v1_raacollege2yrattendedmmbrcnt <= 2.5) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 362880) => 
map(

            ( NULL < v1_hhppcurrownedcnt and v1_hhppcurrownedcnt <= 0.5) => 
0.0033760091
, 

            (v1_hhppcurrownedcnt > 0.5) => 
-0.1904892776
, 

0.0007269182
)
, 

         (v1_raapropowneravmmed > 362880) => 
-0.0841933986
, 

-0.0067745368
)
, 

      (v1_raacollege2yrattendedmmbrcnt > 2.5) => 
0.1940774373
, 

-0.0031998631
)
, 

-0.0175050021
)
, 

-0.0000188071
)
;


// Tree: 746

b2_tree_746 := 
map(

( NULL < v1_raacrtrecmsdmeanmmbrcnt12mo and v1_raacrtrecmsdmeanmmbrcnt12mo <= 1.5) => 
map(

   ( NULL < v1_crtreccnt and v1_crtreccnt <= 20.5) => 
0.0005559952
, 

   (v1_crtreccnt > 20.5) => 
map(

      ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 14555) => 
map(

         ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 170) => 
0.0395738078
, 

         (v1_crtrecfelonytimenewest > 170) => 
map(

            ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 1.5) => 
-0.1553212037
, 

            (v1_raacrtreclienjudgmmbrcnt > 1.5) => 
map(

               ( NULL < v1_crtreccnt and v1_crtreccnt <= 29.5) => 
-0.1603453546
, 

               (v1_crtreccnt > 29.5) => 
0.0784249098
, 

0.0109463568
)
, 

-0.0460596639
)
, 

0.0331900559
)
, 

      (v1_raacrtreclienjudgamtmax > 14555) => 
-0.0154789601
, 

0.0218578095
)
, 

0.0006672319
)
, 

(v1_raacrtrecmsdmeanmmbrcnt12mo > 1.5) => 
-0.0070411975
, 

0.0002501497
)
;


// Tree: 750

b2_tree_750 := 
map(

( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 216.5) => 
map(

   ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 2.5) => 
0.0000214946
, 

   (v1_hhcrtrecmmbrcnt > 2.5) => 
map(

      ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 20.5) => 
0.0094236086
, 

      (v1_raacrtrecmmbrcnt > 20.5) => 
map(

         ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 405.5) => 
0.0122222686
, 

         (v1_crtreclienjudgamtttl > 405.5) => 
map(

            ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 85435.5) => 
-0.1011377168
, 

            (v1_resinputavmvalue > 85435.5) => 
0.0248628821
, 

-0.0691854118
)
, 

-0.0223594493
)
, 

0.0077575885
)
, 

0.0003147621
)
, 

(v1_crtrecevictiontimenewest > 216.5) => 
map(

   ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 49.5) => 
-0.0756972826
, 

   (v1_crtreclienjudgtimenewest > 49.5) => 
0.0120336721
, 

-0.0428501479
)
, 

0.0002780081
)
;


// Tree: 754

b2_tree_754 := 
map(

( NULL < v1_hhcnt and v1_hhcnt <= 2.5) => 
map(

   ( NULL < v1_hhcrtrecfelonymmbrcnt and v1_hhcrtrecfelonymmbrcnt <= 0.5) => 
0.0005116752
, 

   (v1_hhcrtrecfelonymmbrcnt > 0.5) => 
map(

      ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 1.5) => 
map(

         ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 22) => 
0.0315026947
, 

         (v1_resinputbusinesscnt > 22) => 
-0.2405719684
, 

0.0294226132
)
, 

      (v1_raacrtrecmsdmeanmmbrcnt > 1.5) => 
map(

         ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 2.5) => 
-0.0001732868
, 

         (v1_raayoungadultmmbrcnt > 2.5) => 
0.0264630623
, 

0.0085958228
)
, 

0.0140094638
)
, 

0.0008778827
)
, 

(v1_hhcnt > 2.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 57.5) => 
0.0115825198
, 

   (v1_prospecttimeonrecord > 57.5) => 
-0.0060697999
, 

-0.0040931071
)
, 

-0.0003725277
)
;


// Tree: 758

b2_tree_758 := 
map(

( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 1.105) => 
map(

   ( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 241.5) => 
map(

      ( NULL < v1_hhcrtrecbkrptmmbrcnt12mo and v1_hhcrtrecbkrptmmbrcnt12mo <= 2.5) => 
-0.0009023505
, 

      (v1_hhcrtrecbkrptmmbrcnt12mo > 2.5) => 
-0.1698501650
, 

-0.0009132670
)
, 

   (v1_crtrecevictiontimenewest > 241.5) => 
0.0860374588
, 

-0.0008922970
)
, 

(v1_resinputavmratiodiff60mo > 1.105) => 
map(

   ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 130544) => 
map(

      ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 3.895) => 
0.0193919810
, 

      (v1_resinputavmtractratio > 3.895) => 
map(

         ( NULL < v1_raaseniormmbrcnt and v1_raaseniormmbrcnt <= 1.5) => 
-0.0286626335
, 

         (v1_raaseniormmbrcnt > 1.5) => 
-0.1995555431
, 

-0.0601429063
)
, 

0.0177368190
)
, 

   (v1_resinputavmvalue > 130544) => 
0.0011576626
, 

0.0069780047
)
, 

-0.0003967110
)
;


// Tree: 762

b2_tree_762 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 82.5) => 
0.0000851478
, 

(v1_prospecttimelastupdate > 82.5) => 
map(

   ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 10.5) => 
map(

      ( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 21.5) => 
map(

         ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 49415) => 
map(

            ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 675) => 
0.0064701281
, 

            (v1_propcurrownedassessedttl > 675) => 
map(

               ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 0.145) => 
0.0695158313
, 

               (v1_rescurravmcntyratio > 0.145) => 
0.0073208794
, 

0.0410518353
)
, 

0.0086436004
)
, 

         (v1_propcurrownedassessedttl > 49415) => 
-0.0133569651
, 

0.0043981066
)
, 

      (v1_rescurrbusinesscnt > 21.5) => 
-0.0948234943
, 

0.0041087780
)
, 

   (v1_raacrtrecevictionmmbrcnt > 10.5) => 
0.0843682359
, 

0.0043929984
)
, 

0.0004680501
)
;


// Tree: 766

b2_tree_766 := 
map(

( NULL < v1_crtreccnt and v1_crtreccnt <= 1.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 2.5) => 
0.0004603172
, 

   (v1_crtrecbkrpttimenewest > 2.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 53.5) => 
0.0515337892
, 

      (v1_crtrectimenewest > 53.5) => 
0.0037188474
, 

0.0167981910
)
, 

0.0009055929
)
, 

(v1_crtreccnt > 1.5) => 
map(

   ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 48.5) => 
map(

      ( NULL < v1_lifeevtimelastassetpurchase and v1_lifeevtimelastassetpurchase <= 137.5) => 
map(

         ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 4.5) => 
-0.0043188776
, 

         (v1_occbusinessassociationtime > 4.5) => 
-0.0388954912
, 

-0.0049829871
)
, 

      (v1_lifeevtimelastassetpurchase > 137.5) => 
0.0185669072
, 

-0.0040200087
)
, 

   (v1_occbusinessassociationtime > 48.5) => 
0.0137204906
, 

-0.0023404204
)
, 

0.0002371843
)
;


// Tree: 770

b2_tree_770 := 
map(

( NULL < v1_raacrtrecmmbrcnt12mo and v1_raacrtrecmmbrcnt12mo <= 9.5) => 
map(

   ( NULL < v1_raacrtrecmsdmeanmmbrcnt12mo and v1_raacrtrecmsdmeanmmbrcnt12mo <= 7.5) => 
map(

      ( NULL < v1_crtrecfelonycnt and v1_crtrecfelonycnt <= 2.5) => 
0.0000679004
, 

      (v1_crtrecfelonycnt > 2.5) => 
map(

         ( NULL < v1_raaseniormmbrcnt and v1_raaseniormmbrcnt <= 2.5) => 
0.0226100395
, 

         (v1_raaseniormmbrcnt > 2.5) => 
map(

            ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 0.5) => 
0.0006230206
, 

            (v1_resinputbusinesscnt > 0.5) => 
map(

               ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 4391) => 
-0.1658052489
, 

               (v1_hhcrtreclienjudgamtttl > 4391) => 
0.0647924063
, 

-0.1141195676
)
, 

-0.0428741697
)
, 

0.0168386778
)
, 

0.0001856300
)
, 

   (v1_raacrtrecmsdmeanmmbrcnt12mo > 7.5) => 
0.0808713860
, 

0.0002228079
)
, 

(v1_raacrtrecmmbrcnt12mo > 9.5) => 
-0.0366926458
, 

0.0001641136
)
;


// Tree: 774

b2_tree_774 := 
map(

( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 2.345) => 
0.0000896470
, 

(v1_resinputavmcntyratio > 2.345) => 
map(

   ( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 11.585) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 122.5) => 
map(

         ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.345) => 
map(

            ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 462624) => 
0.0201203028
, 

            (v1_raapropowneravmmed > 462624) => 
map(

               ( NULL < v1_raappcurrownermmbrcnt and v1_raappcurrownermmbrcnt <= 0.5) => 
0.0581148384
, 

               (v1_raappcurrownermmbrcnt > 0.5) => 
0.2256473237
, 

0.0700814445
)
, 

0.0272406556
)
, 

         (v1_resinputavmratiodiff12mo > 1.345) => 
-0.0262104303
, 

0.0225725830
)
, 

      (v1_prospecttimeonrecord > 122.5) => 
-0.0033910414
, 

0.0108765800
)
, 

   (v1_rescurravmratiodiff12mo > 11.585) => 
0.3257442908
, 

0.0114649178
)
, 

0.0003598857
)
;


// Tree: 778

b2_tree_778 := 
map(

( NULL < v1_raacrtrecmsdmeanmmbrcnt12mo and v1_raacrtrecmsdmeanmmbrcnt12mo <= 1.5) => 
map(

   ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 1.5) => 
map(

      ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.605) => 
-0.0025832239
, 

      (v1_resinputavmcntyratio > 1.605) => 
0.0148298550
, 

-0.0012848105
)
, 

   (v1_raacrtrecmmbrcnt > 1.5) => 
0.0017609412
, 

0.0002969970
)
, 

(v1_raacrtrecmsdmeanmmbrcnt12mo > 1.5) => 
map(

   ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 194.5) => 
-0.0067051919
, 

   (v1_crtreclienjudgtimenewest > 194.5) => 
map(

      ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raacrtrecevictionmmbrcnt12mo and v1_raacrtrecevictionmmbrcnt12mo <= 0.5) => 
0.0843792056
, 

         (v1_raacrtrecevictionmmbrcnt12mo > 0.5) => 
-0.0465654307
, 

0.0594712585
)
, 

      (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.1102821373
, 

0.0398843282
)
, 

-0.0059790308
)
, 

-0.0000409862
)
;


// Tree: 782

b2_tree_782 := 
map(

(v1_resinputdwelltype in ['-1','H','R','U']) => 
map(

   ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 212.5) => 
map(

      ( NULL < v1_crtreclienjudgcnt and v1_crtreclienjudgcnt <= 4.5) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 159249) => 
-0.0011995081
, 

         (v1_raapropowneravmmed > 159249) => 
map(

            ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 4.5) => 
-0.0102706505
, 

            (v1_crtrecmsdmeancnt > 4.5) => 
-0.0434635905
, 

-0.0115161271
)
, 

-0.0034994175
)
, 

      (v1_crtreclienjudgcnt > 4.5) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 132600) => 
-0.0088421109
, 

         (v1_raapropowneravmmed > 132600) => 
0.0477400722
, 

0.0177847988
)
, 

-0.0030954372
)
, 

   (v1_crtrecfelonytimenewest > 212.5) => 
0.0543456990
, 

-0.0029047444
)
, 

(v1_resinputdwelltype in ['0','F','G','P','S']) => 
0.0012539153
, 

0.0003490439
)
;


// Tree: 786

b2_tree_786 := 
map(

( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 261.5) => 
map(

   ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 2.5) => 
map(

      ( NULL < v1_hhcrtrecfelonymmbrcnt and v1_hhcrtrecfelonymmbrcnt <= 0.5) => 
-0.0025897262
, 

      (v1_hhcrtrecfelonymmbrcnt > 0.5) => 
map(

         ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 0.765) => 
0.0318291575
, 

         (v1_resinputavmblockratio > 0.765) => 
map(

            ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 76.5) => 
-0.0496901291
, 

            (v1_prospecttimeonrecord > 76.5) => 
0.0233307579
, 

-0.0043767724
)
, 

0.0211530500
)
, 

-0.0022889118
)
, 

   (v1_raacrtrecmmbrcnt > 2.5) => 
0.0015662097
, 

-0.0005444678
)
, 

(v1_crtrecfelonytimenewest > 261.5) => 
map(

   ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 146.5) => 
-0.0069822032
, 

   (v1_lifeevtimelastmove > 146.5) => 
-0.0820504772
, 

-0.0330697594
)
, 

-0.0005999883
)
;


// Tree: 790

b2_tree_790 := 
map(

( NULL < v1_crtrecfelonycnt12mo and v1_crtrecfelonycnt12mo <= 0.5) => 
map(

   ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 3.5) => 
map(

      ( NULL < v1_crtreclienjudgcnt12mo and v1_crtreclienjudgcnt12mo <= 2.5) => 
0.0016158255
, 

      (v1_crtreclienjudgcnt12mo > 2.5) => 
-0.0700963969
, 

0.0015722462
)
, 

   (v1_raamiddleagemmbrcnt > 3.5) => 
map(

      ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 29424.5) => 
map(

         ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 50787) => 
-0.0093718625
, 

         (v1_raapropowneravmhighest > 50787) => 
-0.0701885051
, 

-0.0102758552
)
, 

      (v1_raapropowneravmmed > 29424.5) => 
-0.0009028539
, 

-0.0021389876
)
, 

0.0006005749
)
, 

(v1_crtrecfelonycnt12mo > 0.5) => 
map(

   ( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 10) => 
0.0191633500
, 

   (v1_crtrecevictiontimenewest > 10) => 
0.1464146336
, 

0.0349818797
)
, 

0.0006508002
)
;


// Tree: 794

b2_tree_794 := 
map(

( NULL < v1_crtreclienjudgcnt and v1_crtreclienjudgcnt <= 1.5) => 
-0.0004450244
, 

(v1_crtreclienjudgcnt > 1.5) => 
map(

   ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 2.5) => 
map(

      ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 67.5) => 
map(

         ( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 0.5) => 
-0.0070043319
, 

         (v1_rescurrbusinesscnt > 0.5) => 
-0.0220675547
, 

-0.0120937610
)
, 

      (v1_occbusinessassociationtime > 67.5) => 
0.0098832442
, 

-0.0095873047
)
, 

   (v1_crtrecmsdmeancnt > 2.5) => 
map(

      ( NULL < v1_propcurrownedcnt and v1_propcurrownedcnt <= 2.5) => 
map(

         ( NULL < v1_propeverownedcnt and v1_propeverownedcnt <= 2.5) => 
0.0112531260
, 

         (v1_propeverownedcnt > 2.5) => 
0.2373400375
, 

0.0123976767
)
, 

      (v1_propcurrownedcnt > 2.5) => 
-0.1016896321
, 

0.0099117862
)
, 

-0.0063275913
)
, 

-0.0008751476
)
;


// Tree: 798

b2_tree_798 := 
map(

( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 167.5) => 
map(

   ( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 150.5) => 
-0.0001663683
, 

   (v1_crtrecevictiontimenewest > 150.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 5.5) => 
map(

         ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 1.5) => 
map(

            ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 0.565) => 
0.0252521316
, 

            (v1_rescurravmcntyratio > 0.565) => 
-0.0828757488
, 

0.0044426150
)
, 

         (v1_hhcrtrecmmbrcnt > 1.5) => 
-0.0629271378
, 

-0.0226269471
)
, 

      (v1_lifeeveverresidedcnt > 5.5) => 
-0.1586599395
, 

-0.0290629166
)
, 

-0.0002207797
)
, 

(v1_crtrecevictiontimenewest > 167.5) => 
map(

   ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 790880) => 
0.0238286133
, 

   (v1_raapropowneravmhighest > 790880) => 
-0.1281479948
, 

0.0190237322
)
, 

-0.0001544579
)
;


// Tree: 802

b2_tree_802 := 
map(

( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
-0.0013862642
, 

(v1_lifeevtimefirstassetpurchase > -0.5) => 
map(

   ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 2.5) => 
map(

      ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 631.5) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 120191.5) => 
map(

            ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 54523) => 
map(

               ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 819.5) => 
0.0153281876
, 

               (v1_propcurrownedassessedttl > 819.5) => 
0.0596505724
, 

0.0303399319
)
, 

            (v1_propcurrownedassessedttl > 54523) => 
0.0002004611
, 

0.0173028209
)
, 

         (v1_raapropowneravmmed > 120191.5) => 
-0.0032523326
, 

0.0050434343
)
, 

      (v1_crtreclienjudgamtttl > 631.5) => 
0.0241860976
, 

0.0086637922
)
, 

   (v1_resinputownershipindex > 2.5) => 
-0.0036889451
, 

0.0007132450
)
, 

-0.0008449757
)
;


// Tree: 806

b2_tree_806 := 
map(

( NULL < v1_raacrtrecmmbrcnt12mo and v1_raacrtrecmmbrcnt12mo <= 2.5) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 15.5) => 
map(

      ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 2.5) => 
map(

         ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 2.5) => 
0.0016953924
, 

         (v1_raacollege4yrattendedmmbrcnt > 2.5) => 
-0.0620633443
, 

0.0013838245
)
, 

      (v1_raapropcurrownermmbrcnt > 2.5) => 
-0.0049733385
, 

-0.0003687328
)
, 

   (v1_raammbrcnt > 15.5) => 
map(

      ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 2.5) => 
-0.0082841049
, 

      (v1_raapropcurrownermmbrcnt > 2.5) => 
0.0096847130
, 

0.0070531255
)
, 

0.0005607214
)
, 

(v1_raacrtrecmmbrcnt12mo > 2.5) => 
map(

   ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 381.5) => 
-0.0014703854
, 

   (v1_hhcrtreclienjudgamtttl > 381.5) => 
-0.0154456746
, 

-0.0059793820
)
, 

0.0001493455
)
;


// Tree: 810

b2_tree_810 := 
map(

( NULL < v1_crtreccnt and v1_crtreccnt <= 20.5) => 
map(

   ( NULL < v1_crtreccnt and v1_crtreccnt <= 18.5) => 
map(

      ( NULL < v1_crtrecfelonycnt and v1_crtrecfelonycnt <= 4.5) => 
-0.0004553965
, 

      (v1_crtrecfelonycnt > 4.5) => 
0.0379397260
, 

-0.0003948578
)
, 

   (v1_crtreccnt > 18.5) => 
-0.0279843713
, 

-0.0004487075
)
, 

(v1_crtreccnt > 20.5) => 
map(

   ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 133.5) => 
0.0377194179
, 

      (v1_lifeevtimelastmove > 133.5) => 
0.1542912036
, 

0.0553985513
)
, 

   (v1_crtrecseverityindex > 2.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 94.5) => 
0.0120612962
, 

      (v1_crtrectimenewest > 94.5) => 
-0.0668453334
, 

0.0085606424
)
, 

0.0138202479
)
, 

-0.0003405116
)
;


// Tree: 814

b2_tree_814 := 
map(

( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 149.5) => 
-0.0000884178
, 

(v1_crtrecmsdmeantimenewest > 149.5) => 
map(

   ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 24951) => 
map(

      ( NULL < v1_rescurrdwelltypeindex and v1_rescurrdwelltypeindex <= 2) => 
0.0171196070
, 

      (v1_rescurrdwelltypeindex > 2) => 
map(

         ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 7.5) => 
map(

            ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 48.5) => 
0.0694116106
, 

            (v1_prospecttimeonrecord > 48.5) => 
-0.0049165657
, 

-0.0013863653
)
, 

         (v1_crtrecmsdmeancnt > 7.5) => 
-0.0945521433
, 

-0.0036170283
)
, 

0.0046978752
)
, 

   (v1_hhcrtreclienjudgamtttl > 24951) => 
map(

      ( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 0.405) => 
0.0109349361
, 

      (v1_resinputavmratiodiff60mo > 0.405) => 
0.1249487346
, 

0.0531986718
)
, 

0.0071432935
)
, 

0.0001130046
)
;


// Tree: 818

b2_tree_818 := 
map(

( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

   ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 17.5) => 
0.0011919153
, 

   (v1_raacrtreclienjudgmmbrcnt > 17.5) => 
0.0472277248
, 

0.0012708665
)
, 

(v1_hhmiddleagemmbrcnt > 0.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 276.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
0.0145719968
, 

      (v1_raammbrcnt > 0.5) => 
map(

         (v1_rescurrdwelltype in ['-1','P']) => 
-0.0130333203
, 

         (v1_rescurrdwelltype in ['F','H','R','S','U']) => 
map(

            ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 33.5) => 
0.0181248081
, 

            (v1_lifeevtimelastmove > 33.5) => 
-0.0045110210
, 

-0.0035281857
)
, 

-0.0046535794
)
, 

-0.0037148023
)
, 

   (v1_crtrecbkrpttimenewest > 276.5) => 
0.2587713061
, 

-0.0036664308
)
, 

-0.0001346665
)
;


// Tree: 822

b2_tree_822 := 
map(

( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 9.5) => 
map(

   ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 13.5) => 
-0.0005400803
, 

   (v1_raacrtrecmmbrcnt > 13.5) => 
map(

      ( NULL < v1_crtrecevictioncnt and v1_crtrecevictioncnt <= 0.5) => 
0.0169599235
, 

      (v1_crtrecevictioncnt > 0.5) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 84246) => 
-0.0383889096
, 

         (v1_raapropowneravmmed > 84246) => 
0.0105507779
, 

-0.0101320662
)
, 

0.0110202926
)
, 

-0.0002778446
)
, 

(v1_raacrtrecmsdmeanmmbrcnt > 9.5) => 
map(

   ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 4.5) => 
-0.0108915156
, 

   (v1_raacrtrecfelonymmbrcnt > 4.5) => 
map(

      ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 87.5) => 
0.0202100684
, 

      (v1_crtrecmsdmeantimenewest > 87.5) => 
-0.0236469020
, 

0.0106999145
)
, 

-0.0078617074
)
, 

-0.0006248359
)
;


// Tree: 826

b2_tree_826 := 
map(

( NULL < v1_hhcrtrecbkrptmmbrcnt and v1_hhcrtrecbkrptmmbrcnt <= 2.5) => 
0.0001296661
, 

(v1_hhcrtrecbkrptmmbrcnt > 2.5) => 
map(

   ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 101768) => 
map(

      ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 5.5) => 
map(

         ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 2.5) => 
0.0116627156
, 

         (v1_raapropcurrownermmbrcnt > 2.5) => 
map(

            ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 278519.5) => 
map(

               ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 675000) => 
0.0908966780
, 

               (v1_raapropowneravmhighest > 675000) => 
0.3426807150
, 

0.1112840494
)
, 

            (v1_resinputavmvalue60mo > 278519.5) => 
-0.0151271913
, 

0.0918028651
)
, 

0.0481696168
)
, 

      (v1_raacrtrecmsdmeanmmbrcnt > 5.5) => 
-0.0162911381
, 

0.0355524552
)
, 

   (v1_hhcrtreclienjudgamtttl > 101768) => 
-0.0894550414
, 

0.0298634913
)
, 

0.0002298571
)
;


// Tree: 830

b2_tree_830 := 
map(

( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 2.5) => 
-0.0000064183
, 

(v1_crtrecbkrptcnt > 2.5) => 
map(

   ( NULL < v1_hhcollegetiermmbrhighest and v1_hhcollegetiermmbrhighest <= 5.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 3.5) => 
map(

         ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 222892) => 
0.0556034992
, 

         (v1_raapropowneravmhighest > 222892) => 
-0.0103090248
, 

0.0383605604
)
, 

      (v1_lifeeveverresidedcnt > 3.5) => 
map(

         ( NULL < v1_rescurravmvalue and v1_rescurravmvalue <= 127160) => 
-0.0271551505
, 

         (v1_rescurravmvalue > 127160) => 
map(

            ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 66575) => 
0.1568295176
, 

            (v1_resinputavmvalue60mo > 66575) => 
-0.0076853289
, 

0.0666116986
)
, 

-0.0043866989
)
, 

0.0192564760
)
, 

   (v1_hhcollegetiermmbrhighest > 5.5) => 
0.1685521435
, 

0.0223277012
)
, 

0.0000724439
)
;


// Tree: 834

b2_tree_834 := 
map(

( NULL < v1_hhcrtrecfelonymmbrcnt12mo and v1_hhcrtrecfelonymmbrcnt12mo <= 0.5) => 
map(

   ( NULL < v1_prospectlastupdate12mo and v1_prospectlastupdate12mo <= 0.5) => 
0.0005623977
, 

   (v1_prospectlastupdate12mo > 0.5) => 
map(

      ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 0.5) => 
-0.0317733888
, 

         (v1_prospecttimelastupdate > 0.5) => 
-0.0043572493
, 

-0.0131201077
)
, 

      (v1_hhpropcurrownermmbrcnt > 0.5) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 4.5) => 
-0.0073963902
, 

         (v1_crtrecbkrpttimenewest > 4.5) => 
map(

            ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 62.5) => 
0.0419210936
, 

            (v1_crtrecbkrpttimenewest > 62.5) => 
-0.0096532879
, 

0.0132547124
)
, 

-0.0048987754
)
, 

-0.0072284961
)
, 

-0.0006326745
)
, 

(v1_hhcrtrecfelonymmbrcnt12mo > 0.5) => 
0.0288680491
, 

-0.0005655311
)
;


// Tree: 838

b2_tree_838 := 
map(

( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 12.5) => 
map(

   ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 192.5) => 
0.0004321324
, 

   (v1_crtrecfelonytimenewest > 192.5) => 
map(

      ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 4.5) => 
0.0008126608
, 

      (v1_raacrtrecmsdmeanmmbrcnt > 4.5) => 
-0.0479592286
, 

-0.0201511151
)
, 

0.0003462016
)
, 

(v1_raamiddleagemmbrcnt > 12.5) => 
map(

   ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

      ( NULL < v1_crtrecevictioncnt12mo and v1_crtrecevictioncnt12mo <= 1.5) => 
-0.0207148409
, 

      (v1_crtrecevictioncnt12mo > 1.5) => 
-0.2088333501
, 

-0.0218979762
)
, 

   (v1_lifeevtimefirstassetpurchase > -0.5) => 
map(

      ( NULL < v1_crtrecbkrptcnt12mo and v1_crtrecbkrptcnt12mo <= 0.5) => 
0.0039357184
, 

      (v1_crtrecbkrptcnt12mo > 0.5) => 
0.1285806860
, 

0.0062732828
)
, 

-0.0093799409
)
, 

0.0002001941
)
;


// Tree: 842

b2_tree_842 := 
map(

( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 318.5) => 
map(

   ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 313.5) => 
map(

      ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 0.545) => 
0.0008118573
, 

      (v1_resinputavmcntyratio > 0.545) => 
map(

         ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 0.5) => 
map(

            ( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 156.5) => 
-0.0055451047
, 

            (v1_crtrecevictiontimenewest > 156.5) => 
0.0846011064
, 

-0.0053472390
)
, 

         (v1_rescurrownershipindex > 0.5) => 
0.0017470519
, 

-0.0016097268
)
, 

0.0000019501
)
, 

   (v1_crtrecfelonytimenewest > 313.5) => 
0.1316498125
, 

0.0000131154
)
, 

(v1_crtrecfelonytimenewest > 318.5) => 
map(

   ( NULL < v1_raacrtrecbkrptmmbrcnt36mo and v1_raacrtrecbkrptmmbrcnt36mo <= 1.5) => 
-0.0625459463
, 

   (v1_raacrtrecbkrptmmbrcnt36mo > 1.5) => 
0.0455763663
, 

-0.0449829310
)
, 

-0.0000226557
)
;


// Tree: 846

b2_tree_846 := 
map(

( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 83.5) => 
map(

   ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
map(

      ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 3.5) => 
map(

         ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 0) => 
-0.0015444264
, 

         (v1_crtrecmsdmeantimenewest > 0) => 
-0.0115428314
, 

-0.0024319642
)
, 

      (v1_raacrtrecevictionmmbrcnt > 3.5) => 
0.0395130956
, 

-0.0022985551
)
, 

   (v1_raacrtrecfelonymmbrcnt > 0.5) => 
map(

      ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 141.5) => 
map(

         ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 1.5) => 
0.0129053829
, 

         (v1_raacrtreclienjudgmmbrcnt > 1.5) => 
-0.0068320775
, 

0.0064937879
)
, 

      (v1_crtreclienjudgtimenewest > 141.5) => 
0.0618724213
, 

0.0079273983
)
, 

-0.0015889741
)
, 

(v1_raacrtreclienjudgamtmax > 83.5) => 
0.0017910163
, 

-0.0002135666
)
;


// Tree: 850

b2_tree_850 := 
map(

( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 4.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

      ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 8.5) => 
0.0016812646
, 

      (v1_crtrecmsdmeancnt > 8.5) => 
map(

         ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 224) => 
0.0213242971
, 

         (v1_crtrecfelonytimenewest > 224) => 
-0.0918298451
, 

0.0189894607
)
, 

0.0019135102
)
, 

   (v1_hhmiddleagemmbrcnt > 0.5) => 
-0.0033502736
, 

0.0006685329
)
, 

(v1_raapropcurrownermmbrcnt > 4.5) => 
map(

   ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 0.5) => 
map(

      ( NULL < v1_raacollegemidtiermmbrcnt and v1_raacollegemidtiermmbrcnt <= 0.5) => 
-0.0134596538
, 

      (v1_raacollegemidtiermmbrcnt > 0.5) => 
-0.0005490408
, 

-0.0087712092
)
, 

   (v1_rescurrownershipindex > 0.5) => 
0.0000382921
, 

-0.0028462928
)
, 

-0.0000952414
)
;


// Tree: 854

b2_tree_854 := 
map(

( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 240.5) => 
map(

   ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 31.475) => 
map(

      ( NULL < v1_raacrtrecbkrptmmbrcnt36mo and v1_raacrtrecbkrptmmbrcnt36mo <= 3.5) => 
map(

         ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 4.5) => 
map(

            ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 12.5) => 
0.0005330212
, 

            (v1_raamiddleagemmbrcnt > 12.5) => 
-0.0671074948
, 

0.0004827054
)
, 

         (v1_raapropcurrownermmbrcnt > 4.5) => 
map(

            (v1_rescurrdwelltype in ['-1','F','H','R']) => 
-0.0080199117
, 

            (v1_rescurrdwelltype in ['P','S','U']) => 
0.0001376052
, 

-0.0032476290
)
, 

-0.0003158179
)
, 

      (v1_raacrtrecbkrptmmbrcnt36mo > 3.5) => 
0.0194375816
, 

-0.0002031441
)
, 

   (v1_resinputavmtractratio > 31.475) => 
0.1433207806
, 

-0.0001863441
)
, 

(v1_crtrecevictiontimenewest > 240.5) => 
0.0926012770
, 

-0.0001657499
)
;


// Tree: 858

b2_tree_858 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 16.5) => 
-0.0000233067
, 

   (v1_raammbrcnt > 16.5) => 
0.0039105775
, 

0.0005386495
)
, 

(v1_prospectdeceased > 0.5) => 
map(

   ( NULL < v1_rescurravmvalue and v1_rescurravmvalue <= 276620.5) => 
map(

      ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 4986) => 
map(

         ( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 1.5) => 
map(

            ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 14.5) => 
0.0072214790
, 

            (v1_raammbrcnt > 14.5) => 
0.1904481257
, 

0.0321502745
)
, 

         (v1_hhelderlymmbrcnt > 1.5) => 
0.2038787586
, 

0.0527165600
)
, 

      (v1_hhcrtreclienjudgamtttl > 4986) => 
-0.0639820437
, 

0.0364750018
)
, 

   (v1_rescurravmvalue > 276620.5) => 
0.1969739980
, 

0.0528221217
)
, 

0.0005842227
)
;


// Tree: 862

b2_tree_862 := 
map(

( NULL < v1_raappcurrownerwtrcrftmmbrcnt and v1_raappcurrownerwtrcrftmmbrcnt <= 2.5) => 
-0.0013869893
, 

(v1_raappcurrownerwtrcrftmmbrcnt > 2.5) => 
map(

   ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 69946) => 
map(

      ( NULL < v1_hhcrtrecmmbrcnt12mo and v1_hhcrtrecmmbrcnt12mo <= 0.5) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 203.5) => 
map(

            ( NULL < v1_raacrtrecbkrptmmbrcnt36mo and v1_raacrtrecbkrptmmbrcnt36mo <= 3.5) => 
0.0194725431
, 

            (v1_raacrtrecbkrptmmbrcnt36mo > 3.5) => 
-0.0951359999
, 

0.0165053317
)
, 

         (v1_crtrecbkrpttimenewest > 203.5) => 
0.2407741202
, 

0.0190171421
)
, 

      (v1_hhcrtrecmmbrcnt12mo > 0.5) => 
map(

         ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 5.5) => 
0.1774061718
, 

         (v1_raapropcurrownermmbrcnt > 5.5) => 
0.0534471779
, 

0.0839601610
)
, 

0.0251349627
)
, 

   (v1_propcurrownedassessedttl > 69946) => 
-0.0337742770
, 

0.0066910046
)
, 

-0.0013214992
)
;


// Tree: 866

b2_tree_866 := 
map(

( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 7.08) => 
map(

   ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 527.5) => 
0.0000739884
, 

   (v1_crtrecmsdmeantimenewest > 527.5) => 
-0.1636705627
, 

0.0000620778
)
, 

(v1_resinputavmblockratio > 7.08) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 50) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 17.5) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 10.5) => 
0.0091287102
, 

         (v1_crtrectimenewest > 10.5) => 
-0.1365188926
, 

-0.0007123440
)
, 

      (v1_crtrectimenewest > 17.5) => 
0.0789702040
, 

0.0185963963
)
, 

   (v1_prospecttimelastupdate > 50) => 
map(

      ( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 1.01) => 
0.1923463293
, 

      (v1_rescurravmblockratio > 1.01) => 
0.0016148042
, 

0.1236829803
)
, 

0.0339151403
)
, 

0.0001089358
)
;


b2_gbm_logit := sum(
b2_tree_2,
b2_tree_6,
b2_tree_10,
b2_tree_14,
b2_tree_18,
b2_tree_22,
b2_tree_26,
b2_tree_30,
b2_tree_34,
b2_tree_38,
b2_tree_42,
b2_tree_46,
b2_tree_50,
b2_tree_54,
b2_tree_58,
b2_tree_62,
b2_tree_66,
b2_tree_70,
b2_tree_74,
b2_tree_78,
b2_tree_82,
b2_tree_86,
b2_tree_90,
b2_tree_94,
b2_tree_98,
b2_tree_102,
b2_tree_106,
b2_tree_110,
b2_tree_114,
b2_tree_118,
b2_tree_122,
b2_tree_126,
b2_tree_130,
b2_tree_134,
b2_tree_138,
b2_tree_142,
b2_tree_146,
b2_tree_150,
b2_tree_154,
b2_tree_158,
b2_tree_162,
b2_tree_166,
b2_tree_170,
b2_tree_174,
b2_tree_178,
b2_tree_182,
b2_tree_186,
b2_tree_190,
b2_tree_194,
b2_tree_198,
b2_tree_202,
b2_tree_206,
b2_tree_210,
b2_tree_214,
b2_tree_218,
b2_tree_222,
b2_tree_226,
b2_tree_230,
b2_tree_234,
b2_tree_238,
b2_tree_242,
b2_tree_246,
b2_tree_250,
b2_tree_254,
b2_tree_258,
b2_tree_262,
b2_tree_266,
b2_tree_270,
b2_tree_274,
b2_tree_278,
b2_tree_282,
b2_tree_286,
b2_tree_290,
b2_tree_294,
b2_tree_298,
b2_tree_302,
b2_tree_306,
b2_tree_310,
b2_tree_314,
b2_tree_318,
b2_tree_322,
b2_tree_326,
b2_tree_330,
b2_tree_334,
b2_tree_338,
b2_tree_342,
b2_tree_346,
b2_tree_350,
b2_tree_354,
b2_tree_358,
b2_tree_362,
b2_tree_366,
b2_tree_370,
b2_tree_374,
b2_tree_378,
b2_tree_382,
b2_tree_386,
b2_tree_390,
b2_tree_394,
b2_tree_398,
b2_tree_402,
b2_tree_406,
b2_tree_410,
b2_tree_414,
b2_tree_418,
b2_tree_422,
b2_tree_426,
b2_tree_430,
b2_tree_434,
b2_tree_438,
b2_tree_442,
b2_tree_446,
b2_tree_450,
b2_tree_454,
b2_tree_458,
b2_tree_462,
b2_tree_466,
b2_tree_470,
b2_tree_474,
b2_tree_478,
b2_tree_482,
b2_tree_486,
b2_tree_490,
b2_tree_494,
b2_tree_498,
b2_tree_502,
b2_tree_506,
b2_tree_510,
b2_tree_514,
b2_tree_518,
b2_tree_522,
b2_tree_526,
b2_tree_530,
b2_tree_534,
b2_tree_538,
b2_tree_542,
b2_tree_546,
b2_tree_550,
b2_tree_554,
b2_tree_558,
b2_tree_562,
b2_tree_566,
b2_tree_570,
b2_tree_574,
b2_tree_578,
b2_tree_582,
b2_tree_586,
b2_tree_590,
b2_tree_594,
b2_tree_598,
b2_tree_602,
b2_tree_606,
b2_tree_610,
b2_tree_614,
b2_tree_618,
b2_tree_622,
b2_tree_626,
b2_tree_630,
b2_tree_634,
b2_tree_638,
b2_tree_642,
b2_tree_646,
b2_tree_650,
b2_tree_654,
b2_tree_658,
b2_tree_662,
b2_tree_666,
b2_tree_670,
b2_tree_674,
b2_tree_678,
b2_tree_682,
b2_tree_686,
b2_tree_690,
b2_tree_694,
b2_tree_698,
b2_tree_702,
b2_tree_706,
b2_tree_710,
b2_tree_714,
b2_tree_718,
b2_tree_722,
b2_tree_726,
b2_tree_730,
b2_tree_734,
b2_tree_738,
b2_tree_742,
b2_tree_746,
b2_tree_750,
b2_tree_754,
b2_tree_758,
b2_tree_762,
b2_tree_766,
b2_tree_770,
b2_tree_774,
b2_tree_778,
b2_tree_782,
b2_tree_786,
b2_tree_790,
b2_tree_794,
b2_tree_798,
b2_tree_802,
b2_tree_806,
b2_tree_810,
b2_tree_814,
b2_tree_818,
b2_tree_822,
b2_tree_826,
b2_tree_830,
b2_tree_834,
b2_tree_838,
b2_tree_842,
b2_tree_846,
b2_tree_850,
b2_tree_854,
b2_tree_858,
b2_tree_862,
b2_tree_866);

///////////////////////////////
// Score for class 2: banked //
///////////////////////////////


b3_tree_0 :=  0.0000000000;


// Tree: 3

b3_tree_3 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

   ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
-0.0874567298
, 

   (v1_hhpropcurrownermmbrcnt > 0.5) => 
0.0194731761
, 

-0.0784228739
)
, 

(v1_raammbrcnt > 0.5) => 
map(

   ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 3.5) => 
map(

      ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 0.5) => 
0.0068612898
, 

      (v1_raapropcurrownermmbrcnt > 0.5) => 
map(

         ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 279007.5) => 
map(

            ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
0.0356008194
, 

            (v1_prospectcollegeattending > 0.5) => 
0.0910425844
, 

0.0375208358
)
, 

         (v1_propcurrownedavmttl > 279007.5) => 
0.0057312157
, 

0.0342079689
)
, 

0.0277864275
)
, 

   (v1_crtrecseverityindex > 3.5) => 
-0.0178750768
, 

0.0233651300
)
, 

-0.0001377433
)
;


// Tree: 7

b3_tree_7 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

   ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
-0.0810453072
, 

   (v1_hhpropcurrownermmbrcnt > 0.5) => 
0.0219334736
, 

-0.0722795485
)
, 

(v1_raammbrcnt > 0.5) => 
map(

   ( NULL < v1_crtrecfelonycnt and v1_crtrecfelonycnt <= 0.5) => 
map(

      ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 0.5) => 
map(

         ( NULL < v1_prospectcollegeattended and v1_prospectcollegeattended <= 0.5) => 
map(

            ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 94989) => 
0.0034175954
, 

            (v1_raapropowneravmmed > 94989) => 
0.0241218855
, 

0.0139343962
)
, 

         (v1_prospectcollegeattended > 0.5) => 
0.0432545117
, 

0.0190898146
)
, 

      (v1_crtrecbkrptcnt > 0.5) => 
0.0566412793
, 

0.0223527707
)
, 

   (v1_crtrecfelonycnt > 0.5) => 
-0.0494458424
, 

0.0200934384
)
, 

-0.0012507887
)
;


// Tree: 11

b3_tree_11 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
-0.0742235943
, 

   (v1_lifeeveverresidedcnt > 0.5) => 
map(

      ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
0.0519693302
, 

      (v1_crtrecseverityindex > 2.5) => 
-0.0395715050
, 

0.0074055379
)
, 

-0.0645328708
)
, 

(v1_raammbrcnt > 0.5) => 
map(

   ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 4.5) => 
map(

      ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
-0.0090016421
, 

         (v1_hhcnt > 1.5) => 
0.0300639548
, 

0.0017120571
)
, 

      (v1_raapropcurrownermmbrcnt > 0.5) => 
0.0249534264
, 

0.0195022205
)
, 

   (v1_crtrecseverityindex > 4.5) => 
-0.0455881807
, 

0.0174543491
)
, 

-0.0013630354
)
;


// Tree: 15

b3_tree_15 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
-0.0665599985
, 

   (v1_hhcnt > 1.5) => 
0.0179775192
, 

-0.0579857639
)
, 

(v1_raammbrcnt > 0.5) => 
map(

   ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 109774.5) => 
map(

      ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
map(

         ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
-0.0074883664
, 

         (v1_prospectcollegeattending > 0.5) => 
0.0790635298
, 

-0.0055282506
)
, 

      (v1_hhpropcurrownermmbrcnt > 0.5) => 
0.0337081826
, 

0.0033728282
)
, 

   (v1_raapropowneravmhighest > 109774.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 1.5) => 
0.0223353915
, 

      (v1_crtrecbkrpttimenewest > 1.5) => 
0.0532467543
, 

0.0254346055
)
, 

0.0155524700
)
, 

-0.0014177319
)
;


// Tree: 19

b3_tree_19 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

   ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
-0.0593190841
, 

   (v1_lifeevtimefirstassetpurchase > -0.5) => 
0.0385868416
, 

-0.0530621771
)
, 

(v1_raammbrcnt > 0.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 86682) => 
map(

      ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhcollegetiermmbrhighest and v1_hhcollegetiermmbrhighest <= 0.5) => 
map(

            ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 4.5) => 
-0.0056156597
, 

            (v1_crtrecseverityindex > 4.5) => 
-0.0601348837
, 

-0.0084186489
)
, 

         (v1_hhcollegetiermmbrhighest > 0.5) => 
0.0492743567
, 

-0.0051247217
)
, 

      (v1_hhpropcurrownermmbrcnt > 0.5) => 
0.0287029141
, 

0.0028959611
)
, 

   (v1_raapropowneravmmed > 86682) => 
0.0218276522
, 

0.0131455775
)
, 

-0.0021014642
)
;


// Tree: 23

b3_tree_23 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 1.5) => 
map(

   ( NULL < v1_propeverownedcnt and v1_propeverownedcnt <= 0.5) => 
-0.0469130889
, 

   (v1_propeverownedcnt > 0.5) => 
0.0440815315
, 

-0.0389185827
)
, 

(v1_raammbrcnt > 1.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 1.5) => 
map(

      ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
0.0170318190
, 

         (v1_prospectcollegeattending > 0.5) => 
0.0639660476
, 

0.0186098786
)
, 

      (v1_raacrtrecevictionmmbrcnt > 0.5) => 
-0.0000028293
, 

0.0109773475
)
, 

   (v1_crtrecbkrpttimenewest > 1.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 96.5) => 
0.0692944670
, 

      (v1_crtrecbkrpttimenewest > 96.5) => 
0.0135165358
, 

0.0405761295
)
, 

0.0135932813
)
, 

-0.0013465055
)
;


// Tree: 27

b3_tree_27 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 1.5) => 
map(

   ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
-0.0417957119
, 

   (v1_lifeevtimefirstassetpurchase > -0.5) => 
0.0381926006
, 

-0.0346125165
)
, 

(v1_raammbrcnt > 1.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 94181) => 
map(

      ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

         ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
map(

            ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
-0.0100058967
, 

            (v1_raacollege4yrattendedmmbrcnt > 0.5) => 
0.0148253513
, 

-0.0047825448
)
, 

         (v1_prospectcollegeattending > 0.5) => 
0.0639970110
, 

-0.0028983973
)
, 

      (v1_lifeevtimefirstassetpurchase > -0.5) => 
0.0247547952
, 

0.0029951999
)
, 

   (v1_raapropowneravmmed > 94181) => 
0.0191194755
, 

0.0118341781
)
, 

-0.0013378768
)
;


// Tree: 31

b3_tree_31 := 
map(

( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 0.5) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
map(

      ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
-0.0291446312
, 

      (v1_prospectcollegeattending > 0.5) => 
0.1069064828
, 

-0.0282250162
)
, 

   (v1_hhcnt > 1.5) => 
0.0185703362
, 

-0.0199288923
)
, 

(v1_raapropcurrownermmbrcnt > 0.5) => 
map(

   ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 0.5) => 
map(

      ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 1.5) => 
0.0255604051
, 

      (v1_raacrtrecmmbrcnt > 1.5) => 
0.0060584902
, 

0.0106762842
)
, 

   (v1_crtrecbkrptcnt > 0.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 79.5) => 
0.0626558988
, 

      (v1_crtrecbkrpttimenewest > 79.5) => 
0.0140070805
, 

0.0339179991
)
, 

0.0129536994
)
, 

-0.0005759815
)
;


// Tree: 35

b3_tree_35 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

   ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
-0.0396780253
, 

   (v1_lifeevtimefirstassetpurchase > -0.5) => 
0.0320364747
, 

-0.0351438376
)
, 

(v1_raammbrcnt > 0.5) => 
map(

   ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
map(

      ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

         ( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 0.5) => 
-0.0028240032
, 

         (v1_hhcollegeattendedmmbrcnt > 0.5) => 
0.0207021473
, 

0.0021120443
)
, 

      (v1_lifeevtimefirstassetpurchase > -0.5) => 
0.0201935496
, 

0.0078939431
)
, 

   (v1_prospectcollegeattending > 0.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 14.5) => 
0.0813247014
, 

      (v1_prospecttimeonrecord > 14.5) => 
-0.0099565566
, 

0.0501546284
)
, 

0.0090374954
)
, 

-0.0011452638
)
;


// Tree: 39

b3_tree_39 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 1.5) => 
map(

   ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
-0.0312600494
, 

   (v1_hhpropcurrownermmbrcnt > 0.5) => 
0.0280249308
, 

-0.0245979789
)
, 

(v1_raammbrcnt > 1.5) => 
map(

   ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

      ( NULL < v1_prospectcollegeattended and v1_prospectcollegeattended <= 0.5) => 
-0.0002784262
, 

      (v1_prospectcollegeattended > 0.5) => 
map(

         ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
0.0196000549
, 

         (v1_prospectcollegeattending > 0.5) => 
0.0551261916
, 

0.0253917645
)
, 

0.0047337000
)
, 

   (v1_lifeevtimefirstassetpurchase > -0.5) => 
map(

      ( NULL < v1_occproflicense and v1_occproflicense <= 0.5) => 
0.0220368837
, 

      (v1_occproflicense > 0.5) => 
-0.0116850905
, 

0.0188051365
)
, 

0.0093372047
)
, 

-0.0002559716
)
;


// Tree: 43

b3_tree_43 := 
map(

( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 89792.5) => 
map(

   ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

      ( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhoccbusinessassocmmbrcnt and v1_hhoccbusinessassocmmbrcnt <= 0.5) => 
-0.0206154457
, 

         (v1_hhoccbusinessassocmmbrcnt > 0.5) => 
0.0261520364
, 

-0.0191171019
)
, 

      (v1_hhcollegeattendedmmbrcnt > 0.5) => 
0.0131219681
, 

-0.0149993730
)
, 

   (v1_lifeevtimefirstassetpurchase > -0.5) => 
0.0219820718
, 

-0.0094775214
)
, 

(v1_raapropowneravmmed > 89792.5) => 
map(

   ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 0.5) => 
0.0248273796
, 

   (v1_raacrtreclienjudgmmbrcnt > 0.5) => 
map(

      ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 0.5) => 
0.0063941461
, 

      (v1_crtrecbkrptcnt > 0.5) => 
0.0272469902
, 

0.0088517986
)
, 

0.0133826842
)
, 

-0.0000941028
)
;


// Tree: 47

b3_tree_47 := 
map(

( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

   ( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 141672.5) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
-0.0193190638
, 

         (v1_hhcnt > 1.5) => 
0.0051857950
, 

-0.0159023161
)
, 

      (v1_raapropowneravmmed > 141672.5) => 
0.0067159892
, 

-0.0112591247
)
, 

   (v1_hhcollegeattendedmmbrcnt > 0.5) => 
map(

      ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
0.0135824277
, 

      (v1_prospectcollegeattending > 0.5) => 
0.0468211037
, 

0.0178369614
)
, 

-0.0062394266
)
, 

(v1_lifeevtimefirstassetpurchase > -0.5) => 
map(

   ( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 0.5) => 
0.0195179765
, 

   (v1_occproflicensecategory > 0.5) => 
-0.0101427332
, 

0.0169482222
)
, 

-0.0002301047
)
;


// Tree: 51

b3_tree_51 := 
map(

( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 103526.5) => 
map(

      ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 1.5) => 
-0.0153477841
, 

         (v1_prospectcollegeprogramtype > 1.5) => 
0.0503352287
, 

-0.0146013340
)
, 

      (v1_raacollege4yrattendedmmbrcnt > 0.5) => 
0.0104558543
, 

-0.0116868798
)
, 

   (v1_raapropowneravmmed > 103526.5) => 
map(

      ( NULL < v1_prospectcollegeattended and v1_prospectcollegeattended <= 0.5) => 
0.0054905091
, 

      (v1_prospectcollegeattended > 0.5) => 
0.0256361945
, 

0.0097555984
)
, 

-0.0053887955
)
, 

(v1_lifeevtimefirstassetpurchase > -0.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
0.0273916367
, 

   (v1_hhmiddleagemmbrcnt > 0.5) => 
0.0108214217
, 

0.0173014127
)
, 

0.0005062598
)
;


// Tree: 55

b3_tree_55 := 
map(

( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

   ( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhoccbusinessassocmmbrcnt and v1_hhoccbusinessassocmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 206544.5) => 
-0.0127979208
, 

         (v1_raapropowneravmhighest > 206544.5) => 
0.0049448643
, 

-0.0096232276
)
, 

      (v1_hhoccbusinessassocmmbrcnt > 0.5) => 
0.0242937339
, 

-0.0079024154
)
, 

   (v1_hhcollegeattendedmmbrcnt > 0.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 6.5) => 
0.0254922857
, 

      (v1_prospecttimeonrecord > 6.5) => 
0.0024896983
, 

0.0157393684
)
, 

-0.0038189984
)
, 

(v1_lifeevtimefirstassetpurchase > -0.5) => 
map(

   ( NULL < v1_raacollegeattendedmmbrcnt and v1_raacollegeattendedmmbrcnt <= 0.5) => 
0.0247380032
, 

   (v1_raacollegeattendedmmbrcnt > 0.5) => 
0.0088350829
, 

0.0142976966
)
, 

0.0008683100
)
;


// Tree: 59

b3_tree_59 := 
map(

( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

   ( NULL < v1_prospectcollegeattended and v1_prospectcollegeattended <= 0.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 0) => 
map(

         ( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 0.5) => 
-0.0126151324
, 

         (v1_raaoccbusinessassocmmbrcnt > 0.5) => 
0.0027811317
, 

-0.0082964108
)
, 

      (v1_crtrecbkrpttimenewest > 0) => 
0.0208658578
, 

-0.0068035262
)
, 

   (v1_prospectcollegeattended > 0.5) => 
map(

      ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 0.5) => 
0.0294691364
, 

      (v1_raayoungadultmmbrcnt > 0.5) => 
0.0058107606
, 

0.0158407150
)
, 

-0.0037821409
)
, 

(v1_lifeevtimefirstassetpurchase > -0.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 1.5) => 
0.0119540191
, 

   (v1_crtrecbkrpttimenewest > 1.5) => 
0.0329905164
, 

0.0144497857
)
, 

0.0009346870
)
;


// Tree: 63

b3_tree_63 := 
map(

( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

   ( NULL < v1_prospectcollegeattended and v1_prospectcollegeattended <= 0.5) => 
map(

      ( NULL < v1_hhoccbusinessassocmmbrcnt and v1_hhoccbusinessassocmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
map(

            ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
-0.0073437582
, 

            (v1_crtrecseverityindex > 2.5) => 
-0.0299622953
, 

-0.0097525553
)
, 

         (v1_hhcnt > 1.5) => 
0.0053101674
, 

-0.0071648891
)
, 

      (v1_hhoccbusinessassocmmbrcnt > 0.5) => 
0.0177170402
, 

-0.0056823215
)
, 

   (v1_prospectcollegeattended > 0.5) => 
0.0152899885
, 

-0.0028819051
)
, 

(v1_lifeevtimefirstassetpurchase > -0.5) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 7.5) => 
0.0208047998
, 

   (v1_raammbrcnt > 7.5) => 
0.0057290685
, 

0.0125917860
)
, 

0.0011379426
)
;


// Tree: 67

b3_tree_67 := 
map(

( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 1.5) => 
map(

   ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 127430) => 
map(

      ( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhoccbusinessassocmmbrcnt and v1_hhoccbusinessassocmmbrcnt <= 0.5) => 
-0.0078557406
, 

         (v1_hhoccbusinessassocmmbrcnt > 0.5) => 
0.0166312123
, 

-0.0064244320
)
, 

      (v1_hhelderlymmbrcnt > 0.5) => 
0.0287923588
, 

-0.0053756987
)
, 

   (v1_raapropowneravmhighest > 127430) => 
map(

      ( NULL < v1_raahhcnt and v1_raahhcnt <= 2.5) => 
0.0206952018
, 

      (v1_raahhcnt > 2.5) => 
0.0038228383
, 

0.0069514557
)
, 

-0.0006469064
)
, 

(v1_crtrecbkrpttimenewest > 1.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 66.5) => 
0.0483279596
, 

   (v1_crtrecbkrpttimenewest > 66.5) => 
0.0067307780
, 

0.0218235384
)
, 

0.0008481067
)
;


// Tree: 71

b3_tree_71 := 
map(

( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
map(

   ( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 0) => 
-0.0057491449
, 

      (v1_occbusinessassociationtime > 0) => 
0.0209860233
, 

-0.0048119184
)
, 

   (v1_hhcollegeattendedmmbrcnt > 0.5) => 
map(

      ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
0.0094482017
, 

      (v1_prospectcollegeattending > 0.5) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
0.0475916283
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0240191627
, 

0.0328499128
)
, 

0.0126771803
)
, 

-0.0020776046
)
, 

(v1_hhpropcurrownermmbrcnt > 0.5) => 
map(

   ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 0.5) => 
0.0183257049
, 

   (v1_raacrtreclienjudgmmbrcnt > 0.5) => 
0.0058864618
, 

0.0104172147
)
, 

0.0016404770
)
;


// Tree: 75

b3_tree_75 := 
map(

( NULL < v1_propeverownedcnt and v1_propeverownedcnt <= 0.5) => 
map(

   ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 209602.5) => 
map(

            ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 0) => 
map(

               ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 0.5) => 
-0.0065344375
, 

               (v1_raacrtrecevictionmmbrcnt > 0.5) => 
-0.0154352551
, 

-0.0086624276
)
, 

            (v1_crtrecbkrpttimenewest > 0) => 
0.0135759788
, 

-0.0078128816
)
, 

         (v1_raapropowneravmmed > 209602.5) => 
0.0055239783
, 

-0.0061654350
)
, 

      (v1_prospectcollegeattending > 0.5) => 
0.0376014927
, 

-0.0055649008
)
, 

   (v1_raacollege4yrattendedmmbrcnt > 0.5) => 
0.0106517650
, 

-0.0026724850
)
, 

(v1_propeverownedcnt > 0.5) => 
0.0104481056
, 

0.0007029151
)
;


// Tree: 79

b3_tree_79 := 
map(

( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
map(

   ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
map(

      ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 285333.5) => 
map(

         ( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 0.5) => 
-0.0073010773
, 

         (v1_hhelderlymmbrcnt > 0.5) => 
0.0570537779
, 

-0.0068682705
)
, 

      (v1_raapropowneravmhighest > 285333.5) => 
0.0080069432
, 

-0.0046743662
)
, 

   (v1_prospectcollegeattending > 0.5) => 
0.0305442593
, 

-0.0038444748
)
, 

(v1_hhcnt > 1.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 2.5) => 
0.0059821537
, 

   (v1_crtrecbkrpttimenewest > 2.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 79.5) => 
0.0363350265
, 

      (v1_crtrectimenewest > 79.5) => 
-0.0001645703
, 

0.0213668675
)
, 

0.0081706213
)
, 

0.0003844992
)
;


// Tree: 83

b3_tree_83 := 
map(

( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
map(

   ( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
-0.0154555237
, 

         (v1_raammbrcnt > 0.5) => 
map(

            ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 0.5) => 
0.0173658717
, 

            (v1_raacrtrecmmbrcnt > 0.5) => 
-0.0005132250
, 

0.0030065187
)
, 

-0.0035766311
)
, 

      (v1_crtrecseverityindex > 2.5) => 
-0.0173552692
, 

-0.0051828161
)
, 

   (v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
map(

      ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
0.0375649856
, 

      (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0080048061
, 

0.0252824361
)
, 

-0.0041666049
)
, 

(v1_hhcnt > 1.5) => 
0.0081051689
, 

0.0001623692
)
;


// Tree: 87

b3_tree_87 := 
map(

( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
map(

   ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
-0.0024472381
, 

   (v1_prospectcollegeattending > 0.5) => 
0.0244882171
, 

-0.0018190308
)
, 

(v1_hhcnt > 1.5) => 
map(

   ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 67.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 395.5) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 3.5) => 
map(

            ( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 0.5) => 
0.0120702581
, 

            (v1_hhelderlymmbrcnt > 0.5) => 
0.0445401231
, 

0.0138701455
)
, 

         (v1_hhcnt > 3.5) => 
0.0029457402
, 

0.0085941800
)
, 

      (v1_lifeevtimelastmove > 395.5) => 
0.0325160875
, 

0.0098766308
)
, 

   (v1_crtreclienjudgtimenewest > 67.5) => 
-0.0077286619
, 

0.0077481167
)
, 

0.0015454389
)
;


// Tree: 91

b3_tree_91 := 
map(

( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 54703) => 
map(

   ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 1.5) => 
map(

      ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
-0.0022286056
, 

         (v1_crtrecseverityindex > 2.5) => 
-0.0126870243
, 

-0.0040308010
)
, 

      (v1_raacollege4yrattendedmmbrcnt > 0.5) => 
0.0061661818
, 

-0.0021128726
)
, 

   (v1_occbusinessassociationtime > 1.5) => 
0.0153354445
, 

-0.0011832204
)
, 

(v1_propcurrownedavmttl > 54703) => 
map(

   ( NULL < v1_crtreclienjudgcnt12mo and v1_crtreclienjudgcnt12mo <= 0.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 81.5) => 
0.0082433634
, 

      (v1_prospecttimelastupdate > 81.5) => 
0.0300231808
, 

0.0112139922
)
, 

   (v1_crtreclienjudgcnt12mo > 0.5) => 
0.0659484977
, 

0.0120185429
)
, 

0.0010276397
)
;


// Tree: 95

b3_tree_95 := 
map(

( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

   ( NULL < v1_hhcollegetiermmbrhighest and v1_hhcollegetiermmbrhighest <= 0.5) => 
map(

      ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 278.5) => 
-0.0041315670
, 

         (v1_crtrecmsdmeantimenewest > 278.5) => 
0.0782451028
, 

-0.0039550322
)
, 

      (v1_raacollege4yrattendedmmbrcnt > 0.5) => 
0.0063926591
, 

-0.0023134281
)
, 

   (v1_hhcollegetiermmbrhighest > 0.5) => 
map(

      ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 1.5) => 
0.0241720061
, 

      (v1_raayoungadultmmbrcnt > 1.5) => 
0.0006292389
, 

0.0153639301
)
, 

-0.0013022339
)
, 

(v1_lifeevtimefirstassetpurchase > -0.5) => 
map(

   ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 0.5) => 
0.0196349711
, 

   (v1_raacrtrecmmbrcnt > 0.5) => 
0.0057971432
, 

0.0084680697
)
, 

0.0012315379
)
;


// Tree: 99

b3_tree_99 := 
map(

( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

   ( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_occbusinessassociation and v1_occbusinessassociation <= 0.5) => 
-0.0021406739
, 

      (v1_occbusinessassociation > 0.5) => 
map(

         ( NULL < v1_raahhcnt and v1_raahhcnt <= 1.5) => 
0.0602213285
, 

         (v1_raahhcnt > 1.5) => 
0.0057715701
, 

0.0166939807
)
, 

-0.0014199039
)
, 

   (v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
0.0136505053
, 

-0.0007667958
)
, 

(v1_lifeevtimefirstassetpurchase > -0.5) => 
map(

   ( NULL < v1_interestsportperson and v1_interestsportperson <= 0.5) => 
map(

      ( NULL < v1_raahhcnt and v1_raahhcnt <= 5.5) => 
0.0120368127
, 

      (v1_raahhcnt > 5.5) => 
0.0016604679
, 

0.0077659761
)
, 

   (v1_interestsportperson > 0.5) => 
0.0374687488
, 

0.0088308012
)
, 

0.0017321023
)
;


// Tree: 103

b3_tree_103 := 
map(

( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 0.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 1.5) => 
map(

      ( NULL < v1_prospectcollegeattended and v1_prospectcollegeattended <= 0.5) => 
-0.0015383135
, 

      (v1_prospectcollegeattended > 0.5) => 
map(

         ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 0.5) => 
0.0331686583
, 

         (v1_raacrtrecmmbrcnt > 0.5) => 
0.0047756361
, 

0.0086895739
)
, 

-0.0001161562
)
, 

   (v1_crtrecbkrpttimenewest > 1.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 96.5) => 
0.0274124521
, 

      (v1_crtrecbkrpttimenewest > 96.5) => 
-0.0023345730
, 

0.0120926954
)
, 

0.0006706806
)
, 

(v1_hhelderlymmbrcnt > 0.5) => 
map(

   ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
0.0361683910
, 

   (v1_hhcrtrecmmbrcnt > 0.5) => 
0.0018727832
, 

0.0177553156
)
, 

0.0013537102
)
;


// Tree: 107

b3_tree_107 := 
map(

( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 98401.5) => 
map(

   ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 76.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
map(

         ( NULL < v1_hhcollegetiermmbrhighest and v1_hhcollegetiermmbrhighest <= 0.5) => 
map(

            ( NULL < v1_occbusinessassociation and v1_occbusinessassociation <= 0.5) => 
map(

               ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
-0.0015113787
, 

               (v1_raacrtrecfelonymmbrcnt > 0.5) => 
-0.0109020810
, 

-0.0028499279
)
, 

            (v1_occbusinessassociation > 0.5) => 
0.0168039867
, 

-0.0022156495
)
, 

         (v1_hhcollegetiermmbrhighest > 0.5) => 
0.0112006770
, 

-0.0014271858
)
, 

      (v1_lifeeveverresidedcnt > 1.5) => 
0.0093375933
, 

0.0000942435
)
, 

   (v1_crtreclienjudgtimenewest > 76.5) => 
-0.0125417406
, 

-0.0005774031
)
, 

(v1_propcurrownedavmttl > 98401.5) => 
0.0102898597
, 

0.0009849490
)
;


// Tree: 111

b3_tree_111 := 
map(

( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 1.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 3.5) => 
map(

      ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

            ( NULL < v1_prospectcollegeattended and v1_prospectcollegeattended <= 0.5) => 
-0.0083179965
, 

            (v1_prospectcollegeattended > 0.5) => 
0.0855982633
, 

-0.0072598865
)
, 

         (v1_raammbrcnt > 0.5) => 
0.0074802343
, 

-0.0003479623
)
, 

      (v1_raacrtreclienjudgmmbrcnt > 0.5) => 
-0.0041506278
, 

-0.0021719261
)
, 

   (v1_crtrecbkrpttimenewest > 3.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 65.5) => 
0.0263958646
, 

      (v1_crtrectimenewest > 65.5) => 
-0.0064687581
, 

0.0115388867
)
, 

-0.0013739782
)
, 

(v1_hhpropcurrownermmbrcnt > 1.5) => 
0.0100874125
, 

0.0003551931
)
;


// Tree: 115

b3_tree_115 := 
map(

( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 89883) => 
map(

   ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 13.5) => 
map(

      ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 239401.5) => 
-0.0038910989
, 

         (v1_raapropowneravmmed > 239401.5) => 
0.0055692675
, 

-0.0027627499
)
, 

      (v1_hhseniormmbrcnt > 0.5) => 
0.0097506515
, 

-0.0018754079
)
, 

   (v1_raacrtrecmsdmeanmmbrcnt > 13.5) => 
0.0230930489
, 

-0.0013597152
)
, 

(v1_propcurrownedavmttl > 89883) => 
map(

   ( NULL < v1_lifeevnamechange and v1_lifeevnamechange <= 0.5) => 
0.0121174624
, 

   (v1_lifeevnamechange > 0.5) => 
map(

      ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 15608) => 
-0.0073258698
, 

      (v1_crtreclienjudgamtttl > 15608) => 
0.0574355638
, 

-0.0042908570
)
, 

0.0088145092
)
, 

0.0001592088
)
;


// Tree: 119

b3_tree_119 := 
map(

( NULL < v1_interestsportperson and v1_interestsportperson <= 0.5) => 
map(

   ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 91858) => 
map(

      ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 67.5) => 
map(

         ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
-0.0003313846
, 

         (v1_prospectcollegeattending > 0.5) => 
map(

            ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 31.5) => 
0.0265246417
, 

            (v1_lifeevtimelastmove > 31.5) => 
-0.0229511970
, 

0.0167272155
)
, 

0.0000397923
)
, 

      (v1_crtreclienjudgtimenewest > 67.5) => 
-0.0124713329
, 

-0.0007124458
)
, 

   (v1_propcurrownedavmttl > 91858) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 119.5) => 
0.0069094501
, 

      (v1_prospecttimelastupdate > 119.5) => 
0.0395883901
, 

0.0084363656
)
, 

0.0006206423
)
, 

(v1_interestsportperson > 0.5) => 
0.0286291715
, 

0.0011208995
)
;


// Tree: 123

b3_tree_123 := 
map(

( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 97575) => 
map(

   ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 1.5) => 
-0.0028801036
, 

      (v1_raammbrcnt > 1.5) => 
0.0070993844
, 

0.0009782444
)
, 

   (v1_raacrtreclienjudgmmbrcnt > 0.5) => 
-0.0030106841
, 

-0.0010263431
)
, 

(v1_propcurrownedavmttl > 97575) => 
map(

   ( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 1.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 116.5) => 
0.0068753677
, 

      (v1_prospecttimelastupdate > 116.5) => 
map(

         ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
0.0579750843
, 

         (v1_hhcrtrecmmbrcnt > 0.5) => 
-0.0002328549
, 

0.0358154011
)
, 

0.0082687858
)
, 

   (v1_hhelderlymmbrcnt > 1.5) => 
0.0562185392
, 

0.0092502214
)
, 

0.0004587997
)
;


// Tree: 127

b3_tree_127 := 
map(

( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
map(

   ( NULL < v1_prospectcollegeattended and v1_prospectcollegeattended <= 0.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 31.5) => 
map(

         ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
-0.0032823162
, 

         (v1_hhseniormmbrcnt > 0.5) => 
0.0281211918
, 

-0.0027526215
)
, 

      (v1_prospecttimelastupdate > 31.5) => 
-0.0151091859
, 

-0.0038061222
)
, 

   (v1_prospectcollegeattended > 0.5) => 
0.0079083167
, 

-0.0022106323
)
, 

(v1_hhcnt > 1.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
-0.0258428441
, 

   (v1_lifeeveverresidedcnt > 0.5) => 
map(

      ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 0.5) => 
0.0160012074
, 

      (v1_raacrtrecmmbrcnt > 0.5) => 
0.0035277529
, 

0.0056191823
)
, 

0.0048313557
)
, 

0.0002769851
)
;


// Tree: 131

b3_tree_131 := 
map(

( NULL < v1_interestsportperson and v1_interestsportperson <= 0.5) => 
map(

   ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 49.5) => 
map(

      ( NULL < v1_rescurravmvalue and v1_rescurravmvalue <= 91109.5) => 
-0.0006072938
, 

      (v1_rescurravmvalue > 91109.5) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 3.5) => 
map(

            ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 2.5) => 
map(

               ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 81.5) => 
0.0150112872
, 

               (v1_prospecttimelastupdate > 81.5) => 
0.0399536462
, 

0.0195182191
)
, 

            (v1_raacrtrecmmbrcnt > 2.5) => 
0.0044498928
, 

0.0119541585
)
, 

         (v1_hhcnt > 3.5) => 
0.0014182371
, 

0.0074838950
)
, 

0.0009038032
)
, 

   (v1_crtreclienjudgtimenewest > 49.5) => 
-0.0091235521
, 

0.0001442231
)
, 

(v1_interestsportperson > 0.5) => 
0.0219869767
, 

0.0005286247
)
;


// Tree: 135

b3_tree_135 := 
map(

( NULL < v1_lifeevtimelastassetpurchase and v1_lifeevtimelastassetpurchase <= 74.5) => 
map(

   ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 0.5) => 
0.0007361274
, 

         (v1_hhelderlymmbrcnt > 0.5) => 
map(

            ( NULL < v1_hhcnt and v1_hhcnt <= 5.5) => 
0.0325660560
, 

            (v1_hhcnt > 5.5) => 
-0.0278350649
, 

0.0192265502
)
, 

0.0012856114
)
, 

      (v1_raacrtrecmsdmeanmmbrcnt > 0.5) => 
-0.0052827087
, 

-0.0015385811
)
, 

   (v1_raacollege4yrattendedmmbrcnt > 0.5) => 
0.0047287998
, 

-0.0001940623
)
, 

(v1_lifeevtimelastassetpurchase > 74.5) => 
map(

   ( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.115) => 
0.0041542303
, 

   (v1_rescurravmratiodiff12mo > 1.115) => 
0.0197384452
, 

0.0090063185
)
, 

0.0006547501
)
;


// Tree: 139

b3_tree_139 := 
map(

( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 58.5) => 
map(

      ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 1.5) => 
map(

         ( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
map(

            (v1_resinputdwelltype in ['-1','0','G','P','S']) => 
-0.0036665796
, 

            (v1_resinputdwelltype in ['F','H','R','U']) => 
0.0053937590
, 

-0.0011975156
)
, 

         (v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
0.0143024448
, 

-0.0006030070
)
, 

      (v1_hhcrtrecmmbrcnt > 1.5) => 
0.0122439127
, 

0.0001786066
)
, 

   (v1_prospecttimelastupdate > 58.5) => 
-0.0093269549
, 

-0.0008634678
)
, 

(v1_lifeevtimefirstassetpurchase > -0.5) => 
map(

   ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
0.0106755787
, 

   (v1_hhcrtrecmmbrcnt > 0.5) => 
0.0015647843
, 

0.0059939554
)
, 

0.0009171919
)
;


// Tree: 143

b3_tree_143 := 
map(

( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 150745.5) => 
map(

   ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 39.5) => 
map(

         ( NULL < v1_prospectcollegeattended and v1_prospectcollegeattended <= 0.5) => 
-0.0015030806
, 

         (v1_prospectcollegeattended > 0.5) => 
0.0100960077
, 

-0.0002956132
)
, 

      (v1_crtrectimenewest > 39.5) => 
-0.0088110956
, 

-0.0015547155
)
, 

   (v1_raacollege4yrattendedmmbrcnt > 0.5) => 
0.0049734417
, 

-0.0001823350
)
, 

(v1_rescurravmvalue60mo > 150745.5) => 
map(

   ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 62.5) => 
map(

      ( NULL < v1_hhcnt and v1_hhcnt <= 4.5) => 
0.0157089967
, 

      (v1_hhcnt > 4.5) => 
-0.0014584293
, 

0.0108796616
)
, 

   (v1_crtreclienjudgtimenewest > 62.5) => 
-0.0197546186
, 

0.0079697646
)
, 

0.0009525913
)
;


// Tree: 147

b3_tree_147 := 
map(

( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 1.5) => 
map(

   ( NULL < v1_crtreclienjudgcnt12mo and v1_crtreclienjudgcnt12mo <= 1.5) => 
map(

      ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 2.5) => 
0.0006307453
, 

      (v1_raacrtreclienjudgmmbrcnt > 2.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 30.5) => 
-0.0067102004
, 

         (v1_raammbrcnt > 30.5) => 
0.0090050924
, 

-0.0050346554
)
, 

-0.0008021339
)
, 

   (v1_crtreclienjudgcnt12mo > 1.5) => 
0.0409194703
, 

-0.0006391434
)
, 

(v1_hhpropcurrownermmbrcnt > 1.5) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 3.5) => 
map(

      ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 1172343.5) => 
0.0140786050
, 

      (v1_raapropowneravmhighest > 1172343.5) => 
0.0812636124
, 

0.0157175784
)
, 

   (v1_hhcnt > 3.5) => 
0.0015911399
, 

0.0074118110
)
, 

0.0005923273
)
;


// Tree: 151

b3_tree_151 := 
map(

( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 1.5) => 
map(

   ( NULL < v1_crtreccnt12mo and v1_crtreccnt12mo <= 0.5) => 
map(

      ( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

         ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 1.5) => 
map(

            ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 2.5) => 
-0.0031489003
, 

            (v1_raammbrcnt > 2.5) => 
0.0093633676
, 

0.0001444437
)
, 

         (v1_raacrtrecmmbrcnt > 1.5) => 
-0.0034047135
, 

-0.0016688608
)
, 

      (v1_prospectdeceased > 0.5) => 
-0.0884705402
, 

-0.0017602315
)
, 

   (v1_crtreccnt12mo > 0.5) => 
0.0118341289
, 

-0.0010585312
)
, 

(v1_hhpropcurrownermmbrcnt > 1.5) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 2.5) => 
0.0215479480
, 

   (v1_hhcnt > 2.5) => 
0.0034983548
, 

0.0070213199
)
, 

0.0001624587
)
;


// Tree: 155

b3_tree_155 := 
map(

( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 90003.5) => 
map(

   ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 17.5) => 
map(

      ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
0.0031701005
, 

         (v1_crtrecseverityindex > 2.5) => 
-0.0108301930
, 

0.0015226067
)
, 

      (v1_raayoungadultmmbrcnt > 0.5) => 
-0.0036383658
, 

-0.0005371492
)
, 

   (v1_raacrtrecmsdmeanmmbrcnt > 17.5) => 
map(

      ( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 2.5) => 
0.0188247212
, 

      (v1_rescurrbusinesscnt > 2.5) => 
0.1392164125
, 

0.0234132563
)
, 

-0.0002987243
)
, 

(v1_propcurrownedavmttl > 90003.5) => 
map(

   ( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 0.865) => 
0.0022840457
, 

   (v1_resinputavmratiodiff60mo > 0.865) => 
0.0138563340
, 

0.0074548425
)
, 

0.0008575335
)
;


// Tree: 159

b3_tree_159 := 
map(

( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 2.5) => 
map(

   ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 2.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 440.5) => 
0.0003361676
, 

      (v1_lifeevtimelastmove > 440.5) => 
map(

         ( NULL < v1_rescurravmvalue and v1_rescurravmvalue <= 304750) => 
0.0119840283
, 

         (v1_rescurravmvalue > 304750) => 
0.0685210365
, 

0.0212586386
)
, 

0.0006063112
)
, 

   (v1_resinputbusinesscnt > 2.5) => 
-0.0087800660
, 

-0.0003941653
)
, 

(v1_crtrecbkrpttimenewest > 2.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 55.5) => 
map(

      ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 163222.5) => 
0.0205178679
, 

      (v1_propcurrownedavmttl > 163222.5) => 
0.0605366737
, 

0.0267085796
)
, 

   (v1_crtrecbkrpttimenewest > 55.5) => 
0.0004053942
, 

0.0087181858
)
, 

0.0002068062
)
;


// Tree: 163

b3_tree_163 := 
map(

( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
map(

   ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 1.925) => 
map(

      ( NULL < v1_raacollegemidtiermmbrcnt and v1_raacollegemidtiermmbrcnt <= 1.5) => 
-0.0008809951
, 

      (v1_raacollegemidtiermmbrcnt > 1.5) => 
0.0117414486
, 

-0.0003754805
)
, 

   (v1_resinputavmblockratio > 1.925) => 
-0.0211855853
, 

-0.0008445971
)
, 

(v1_lifeeveverresidedcnt > 1.5) => 
map(

   ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 117.5) => 
0.0168650900
, 

      (v1_crtrecbkrpttimenewest > 117.5) => 
-0.0253818648
, 

0.0151126675
)
, 

   (v1_raacrtreclienjudgmmbrcnt > 0.5) => 
map(

      ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
0.0095105670
, 

      (v1_verifiedcurrresmatchindex > 0.5) => 
-0.0021029273
, 

0.0027442688
)
, 

0.0059533475
)
, 

0.0006694711
)
;


// Tree: 167

b3_tree_167 := 
map(

( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 238663) => 
map(

   ( NULL < v1_raacollege2yrattendedmmbrcnt and v1_raacollege2yrattendedmmbrcnt <= 4.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 572.5) => 
map(

         ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 101.5) => 
-0.0015304974
, 

         (v1_occbusinessassociationtime > 101.5) => 
0.0121229828
, 

-0.0011034364
)
, 

      (v1_lifeevtimelastmove > 572.5) => 
0.0464041365
, 

-0.0009937123
)
, 

   (v1_raacollege2yrattendedmmbrcnt > 4.5) => 
0.0505637926
, 

-0.0008627864
)
, 

(v1_raapropowneravmmed > 238663) => 
map(

   ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 3.5) => 
map(

      ( NULL < v1_hhcrtreclienjudgmmbrcnt and v1_hhcrtreclienjudgmmbrcnt <= 0.5) => 
0.0129127013
, 

      (v1_hhcrtreclienjudgmmbrcnt > 0.5) => 
-0.0059627333
, 

0.0105754386
)
, 

   (v1_raacrtrecmmbrcnt > 3.5) => 
-0.0000363763
, 

0.0059395214
)
, 

0.0002319886
)
;


// Tree: 171

b3_tree_171 := 
map(

( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
map(

   ( NULL < v1_ppcurrowner and v1_ppcurrowner <= 0.5) => 
map(

      ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 1.5) => 
map(

         ( NULL < v1_prospectcollegeattended and v1_prospectcollegeattended <= 0.5) => 
-0.0003564999
, 

         (v1_prospectcollegeattended > 0.5) => 
map(

            ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
0.0724808717
, 

            (v1_raammbrcnt > 0.5) => 
0.0065334626
, 

0.0098950486
)
, 

0.0006915392
)
, 

      (v1_raacrtreclienjudgmmbrcnt > 1.5) => 
-0.0045949629
, 

-0.0009449989
)
, 

   (v1_ppcurrowner > 0.5) => 
0.0382590403
, 

-0.0007973584
)
, 

(v1_lifeeveverresidedcnt > 1.5) => 
map(

   ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 122.5) => 
0.0067432407
, 

   (v1_crtreclienjudgtimenewest > 122.5) => 
-0.0121956731
, 

0.0050873248
)
, 

0.0005093146
)
;


// Tree: 175

b3_tree_175 := 
map(

( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 132.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 1.5) => 
map(

      ( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 0.5) => 
-0.0010866627
, 

      (v1_hhelderlymmbrcnt > 0.5) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 4.5) => 
map(

            ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 0.5) => 
0.0301030814
, 

            (v1_raacrtrecevictionmmbrcnt > 0.5) => 
-0.0108538136
, 

0.0206197180
)
, 

         (v1_hhcnt > 4.5) => 
-0.0043436845
, 

0.0098973176
)
, 

-0.0006737158
)
, 

   (v1_crtrecbkrpttimenewest > 1.5) => 
map(

      ( NULL < v1_rescurravmvalue and v1_rescurravmvalue <= 255826) => 
0.0106712400
, 

      (v1_rescurravmvalue > 255826) => 
0.0399894681
, 

0.0136602652
)
, 

-0.0000273251
)
, 

(v1_crtrecbkrpttimenewest > 132.5) => 
-0.0138263145
, 

-0.0003455654
)
;


// Tree: 179

b3_tree_179 := 
map(

( NULL < v1_interestsportperson and v1_interestsportperson <= 0.5) => 
map(

   ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 105.5) => 
map(

      ( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_occproflicense and v1_occproflicense <= 0.5) => 
map(

            ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 0) => 
-0.0015696741
, 

            (v1_crtrecbkrpttimenewest > 0) => 
0.0073596520
, 

-0.0010685960
)
, 

         (v1_occproflicense > 0.5) => 
0.0143656554
, 

-0.0005603034
)
, 

      (v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
map(

         ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
0.0174889598
, 

         (v1_hhcrtrecmmbrcnt > 0.5) => 
-0.0027842637
, 

0.0081994129
)
, 

-0.0000082165
)
, 

   (v1_crtreclienjudgtimenewest > 105.5) => 
-0.0120801182
, 

-0.0004669665
)
, 

(v1_interestsportperson > 0.5) => 
0.0192798265
, 

-0.0001127571
)
;


// Tree: 183

b3_tree_183 := 
map(

( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 1.5) => 
map(

   ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
0.0017888529
, 

   (v1_resinputownershipindex > 0.5) => 
-0.0074374006
, 

-0.0023039689
)
, 

(v1_raapropcurrownermmbrcnt > 1.5) => 
map(

   ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 3.5) => 
map(

      ( NULL < v1_hhcrtreclienjudgmmbrcnt and v1_hhcrtreclienjudgmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 1.5) => 
0.0051585038
, 

         (v1_hhpropcurrownermmbrcnt > 1.5) => 
0.0183876372
, 

0.0085389539
)
, 

      (v1_hhcrtreclienjudgmmbrcnt > 0.5) => 
map(

         ( NULL < v1_crtreclienjudgcnt12mo and v1_crtreclienjudgcnt12mo <= 2.5) => 
-0.0081304517
, 

         (v1_crtreclienjudgcnt12mo > 2.5) => 
0.1755730701
, 

-0.0071828961
)
, 

0.0065172512
)
, 

   (v1_raacrtrecmmbrcnt > 3.5) => 
-0.0002189570
, 

0.0024240095
)
, 

-0.0000312179
)
;


// Tree: 187

b3_tree_187 := 
map(

( NULL < v1_interestsportperson and v1_interestsportperson <= 0.5) => 
map(

   ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 66.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 0) => 
map(

         ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
map(

            ( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 1.5) => 
-0.0003817741
, 

            (v1_prospectcollegeprogramtype > 1.5) => 
0.0153265386
, 

0.0001951453
)
, 

         (v1_hhcrtrecmmbrcnt > 0.5) => 
-0.0097854447
, 

-0.0007624112
)
, 

      (v1_crtrectimenewest > 0) => 
0.0043226268
, 

0.0005641514
)
, 

   (v1_crtreclienjudgtimenewest > 66.5) => 
map(

      ( NULL < v1_lifeevecontrajectoryindex and v1_lifeevecontrajectoryindex <= 3.5) => 
0.0137344945
, 

      (v1_lifeevecontrajectoryindex > 3.5) => 
-0.0115625580
, 

-0.0076544468
)
, 

0.0000548745
)
, 

(v1_interestsportperson > 0.5) => 
0.0150373804
, 

0.0003217499
)
;


// Tree: 191

b3_tree_191 := 
map(

( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 98656.5) => 
map(

   ( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 610163.5) => 
-0.0005570347
, 

   (v1_rescurravmvalue60mo > 610163.5) => 
0.0305383967
, 

-0.0003897406
)
, 

(v1_propcurrownedavmttl > 98656.5) => 
map(

   ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 88.5) => 
0.0089670761
, 

      (v1_prospecttimelastupdate > 88.5) => 
0.0299070798
, 

0.0114919760
)
, 

   (v1_hhcrtrecmmbrcnt > 0.5) => 
map(

      ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 221746.5) => 
map(

         ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.045) => 
-0.0015617926
, 

         (v1_resinputavmratiodiff12mo > 1.045) => 
0.0221708063
, 

0.0094043667
)
, 

      (v1_propcurrownedavmttl > 221746.5) => 
-0.0073952456
, 

0.0001953786
)
, 

0.0059665245
)
, 

0.0005313387
)
;


// Tree: 195

b3_tree_195 := 
map(

( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 0.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
map(

      ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 2.585) => 
-0.0014233865
, 

      (v1_resinputavmcntyratio > 2.585) => 
map(

         ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 0.785) => 
-0.0377560290
, 

         (v1_rescurravmratiodiff60mo > 0.785) => 
0.0208420128
, 

-0.0276086770
)
, 

-0.0017819464
)
, 

   (v1_lifeeveverresidedcnt > 1.5) => 
0.0040636812
, 

-0.0004976155
)
, 

(v1_prospectcollegeprogramtype > 0.5) => 
map(

   ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 4.5) => 
0.0165198802
, 

   (v1_raacrtrecmmbrcnt > 4.5) => 
map(

      ( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 343551.5) => 
-0.0049217709
, 

      (v1_rescurravmvalue12mo > 343551.5) => 
0.0874791829
, 

-0.0020543452
)
, 

0.0091682834
)
, 

-0.0000021974
)
;


// Tree: 199

b3_tree_199 := 
map(

( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 1.5) => 
map(

   ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 0) => 
map(

      ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 1.5) => 
map(

         ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 4.045) => 
-0.0012805745
, 

         (v1_resinputavmcntyratio > 4.045) => 
-0.0424987823
, 

-0.0014593201
)
, 

      (v1_hhpropcurrownermmbrcnt > 1.5) => 
map(

         ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
-0.0359582986
, 

         (v1_lifeeveverresidedcnt > 0.5) => 
0.0057188294
, 

0.0047965468
)
, 

-0.0005452619
)
, 

   (v1_crtrecmsdmeantimenewest > 0) => 
0.0050169534
, 

0.0003852782
)
, 

(v1_hhelderlymmbrcnt > 1.5) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 206.5) => 
0.0223006742
, 

   (v1_crtrectimenewest > 206.5) => 
-0.0875310096
, 

0.0191967353
)
, 

0.0005598772
)
;


// Tree: 203

b3_tree_203 := 
map(

( NULL < v1_occbusinessassociation and v1_occbusinessassociation <= 0.5) => 
map(

   ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 3.305) => 
map(

      ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 161127.5) => 
-0.0013239399
, 

      (v1_raapropowneravmmed > 161127.5) => 
map(

         ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 16506.5) => 
0.0009818761
, 

         (v1_propcurrownedassessedttl > 16506.5) => 
map(

            ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 1.445) => 
0.0102023003
, 

            (v1_rescurravmratiodiff60mo > 1.445) => 
0.0935745168
, 

0.0116963730
)
, 

0.0031685398
)
, 

-0.0002314109
)
, 

   (v1_resinputavmcntyratio > 3.305) => 
-0.0278138750
, 

-0.0004338251
)
, 

(v1_occbusinessassociation > 0.5) => 
map(

   ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 0.5) => 
0.0275345927
, 

   (v1_raacrtrecmmbrcnt > 0.5) => 
0.0043758200
, 

0.0083531696
)
, 

0.0002402946
)
;


// Tree: 207

b3_tree_207 := 
map(

( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 1.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 110.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 0) => 
-0.0004107930
, 

      (v1_crtrecbkrpttimenewest > 0) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 53.5) => 
0.0205691312
, 

         (v1_crtrecbkrpttimenewest > 53.5) => 
0.0022161213
, 

0.0088705459
)
, 

0.0000966384
)
, 

   (v1_prospecttimelastupdate > 110.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
0.0305293762
, 

      (v1_raammbrcnt > 0.5) => 
-0.0166312980
, 

-0.0126373206
)
, 

-0.0004431851
)
, 

(v1_hhpropcurrownermmbrcnt > 1.5) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 3.5) => 
0.0127134986
, 

   (v1_hhcnt > 3.5) => 
0.0012150237
, 

0.0059775696
)
, 

0.0005286445
)
;


// Tree: 211

b3_tree_211 := 
map(

( NULL < v1_hhcrtreclienjudgmmbrcnt and v1_hhcrtreclienjudgmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 0.5) => 
0.0012186703
, 

   (v1_hhelderlymmbrcnt > 0.5) => 
0.0152928411
, 

0.0016632007
)
, 

(v1_hhcrtreclienjudgmmbrcnt > 0.5) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 7.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

         ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
0.0464114506
, 

         (v1_resinputownershipindex > 0.5) => 
-0.0167018318
, 

0.0117330584
)
, 

      (v1_raammbrcnt > 0.5) => 
map(

         ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 2662) => 
-0.0238909472
, 

         (v1_hhcrtreclienjudgamtttl > 2662) => 
-0.0065721572
, 

-0.0142974484
)
, 

-0.0090595937
)
, 

   (v1_raammbrcnt > 7.5) => 
0.0004130816
, 

-0.0033060802
)
, 

0.0007420537
)
;


// Tree: 215

b3_tree_215 := 
map(

( NULL < v1_occbusinessassociation and v1_occbusinessassociation <= 0.5) => 
map(

   ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.495) => 
map(

      ( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 3.5) => 
map(

         ( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 1.5) => 
-0.0010369824
, 

         (v1_prospectcollegeprogramtype > 1.5) => 
map(

            ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 26.5) => 
0.0195755593
, 

            (v1_lifeevtimelastmove > 26.5) => 
-0.0046772873
, 

0.0091066802
)
, 

-0.0006907162
)
, 

      (v1_raaoccbusinessassocmmbrcnt > 3.5) => 
0.0079877184
, 

-0.0002370038
)
, 

   (v1_resinputavmratiodiff12mo > 1.495) => 
-0.0135542371
, 

-0.0007125028
)
, 

(v1_occbusinessassociation > 0.5) => 
map(

   ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 3995.5) => 
0.0106922791
, 

   (v1_hhcrtreclienjudgamtttl > 3995.5) => 
-0.0082017558
, 

0.0075094095
)
, 

-0.0000769241
)
;


// Tree: 219

b3_tree_219 := 
map(

( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 16.5) => 
map(

   ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 0.735) => 
map(

      ( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 0.835) => 
map(

         ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 1.925) => 
-0.0002188210
, 

         (v1_resinputavmblockratio > 1.925) => 
-0.0207106399
, 

-0.0006026370
)
, 

      (v1_rescurravmblockratio > 0.835) => 
-0.0111023791
, 

-0.0011960564
)
, 

   (v1_rescurravmcntyratio > 0.735) => 
map(

      ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 4.5) => 
0.0132311370
, 

         (v1_hhcnt > 4.5) => 
-0.0068884045
, 

0.0090222027
)
, 

      (v1_hhcrtrecmmbrcnt > 0.5) => 
-0.0002206682
, 

0.0040372279
)
, 

-0.0002804164
)
, 

(v1_raacrtrecmsdmeanmmbrcnt > 16.5) => 
0.0194424664
, 

-0.0000570850
)
;


// Tree: 223

b3_tree_223 := 
map(

( NULL < v1_interestsportperson and v1_interestsportperson <= 0.5) => 
map(

   ( NULL < v1_hhcrtrecmmbrcnt12mo and v1_hhcrtrecmmbrcnt12mo <= 1.5) => 
map(

      ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 0.5) => 
map(

            ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
-0.0036559535
, 

            (v1_raammbrcnt > 0.5) => 
0.0067879717
, 

-0.0002782382
)
, 

         (v1_hhelderlymmbrcnt > 0.5) => 
0.0234511552
, 

0.0004288618
)
, 

      (v1_raacrtrecmmbrcnt > 0.5) => 
-0.0018869398
, 

-0.0010698968
)
, 

   (v1_hhcrtrecmmbrcnt12mo > 1.5) => 
0.0173561234
, 

-0.0009080160
)
, 

(v1_interestsportperson > 0.5) => 
map(

   ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 2.5) => 
0.0022246538
, 

   (v1_rescurrownershipindex > 2.5) => 
0.0307039970
, 

0.0130284883
)
, 

-0.0006579166
)
;


// Tree: 227

b3_tree_227 := 
map(

( NULL < v1_hhcrtrecbkrptmmbrcnt and v1_hhcrtrecbkrptmmbrcnt <= 1.5) => 
map(

   ( NULL < v1_interestsportperson and v1_interestsportperson <= 0.5) => 
-0.0003503798
, 

   (v1_interestsportperson > 0.5) => 
0.0133049383
, 

-0.0001179001
)
, 

(v1_hhcrtrecbkrptmmbrcnt > 1.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 4.5) => 
-0.0090034330
, 

   (v1_crtrecbkrpttimenewest > 4.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 110.5) => 
map(

         ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 298950) => 
0.0194028379
, 

         (v1_resinputavmvalue60mo > 298950) => 
0.0672728289
, 

0.0236945288
)
, 

      (v1_crtrecbkrpttimenewest > 110.5) => 
map(

         ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 19.5) => 
-0.0007472419
, 

         (v1_raacrtrecmmbrcnt > 19.5) => 
0.0963594404
, 

0.0033876783
)
, 

0.0153369849
)
, 

0.0099798294
)
, 

0.0001712945
)
;


// Tree: 231

b3_tree_231 := 
map(

( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 74221.5) => 
map(

   ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 2.635) => 
map(

      ( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 458107) => 
-0.0010985735
, 

      (v1_rescurravmvalue12mo > 458107) => 
map(

         ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 37.5) => 
0.0173751509
, 

         (v1_crtreclienjudgtimenewest > 37.5) => 
map(

            (v1_resinputdwelltype in ['H','S']) => 
-0.0372031380
, 

            (v1_resinputdwelltype in ['-1','0','F','G','P','R','U']) => 
0.2334664825
, 

-0.0298279440
)
, 

0.0130913883
)
, 

-0.0008341618
)
, 

   (v1_rescurravmratiodiff60mo > 2.635) => 
-0.0561654958
, 

-0.0009087622
)
, 

(v1_propcurrownedassessedttl > 74221.5) => 
map(

   ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 192.5) => 
0.0055614963
, 

   (v1_crtreclienjudgtimenewest > 192.5) => 
-0.0342257580
, 

0.0049063150
)
, 

-0.0001933878
)
;


// Tree: 235

b3_tree_235 := 
map(

(v1_resinputdwelltype in ['F','G','H','P','S']) => 
map(

   ( NULL < v1_hhcrtrecbkrptmmbrcnt24mo and v1_hhcrtrecbkrptmmbrcnt24mo <= 0.5) => 
map(

      ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
map(

            ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
map(

               ( NULL < v1_prospectcollegeattended and v1_prospectcollegeattended <= 0.5) => 
-0.0071297077
, 

               (v1_prospectcollegeattended > 0.5) => 
0.0854457378
, 

-0.0061173283
)
, 

            (v1_lifeeveverresidedcnt > 0.5) => 
0.0169516111
, 

-0.0033995609
)
, 

         (v1_raammbrcnt > 0.5) => 
0.0083879772
, 

0.0005606231
)
, 

      (v1_raacrtrecmmbrcnt > 0.5) => 
-0.0014200313
, 

-0.0007224360
)
, 

   (v1_hhcrtrecbkrptmmbrcnt24mo > 0.5) => 
0.0140826118
, 

-0.0004941896
)
, 

(v1_resinputdwelltype in ['-1','0','R','U']) => 
0.0408481397
, 

-0.0003065005
)
;


// Tree: 239

b3_tree_239 := 
map(

( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_proptimelastsale and v1_proptimelastsale <= 235.5) => 
-0.0019165538
, 

   (v1_proptimelastsale > 235.5) => 
0.1258315570
, 

-0.0018581657
)
, 

(v1_raaoccbusinessassocmmbrcnt > 0.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 8088) => 
map(

      ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
0.0159437330
, 

      (v1_verifiedcurrresmatchindex > 0.5) => 
-0.0018029049
, 

0.0108986438
)
, 

   (v1_raapropowneravmmed > 8088) => 
map(

      ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 122731.5) => 
-0.0012797667
, 

      (v1_propcurrownedavmttl > 122731.5) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 3.5) => 
0.0133190592
, 

         (v1_hhcnt > 3.5) => 
-0.0018737704
, 

0.0072376493
)
, 

0.0006728262
)
, 

0.0023922648
)
, 

-0.0001971627
)
;


// Tree: 243

b3_tree_243 := 
map(

( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 13.5) => 
map(

   ( NULL < v1_crtreclienjudgcnt12mo and v1_crtreclienjudgcnt12mo <= 1.5) => 
map(

      ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 0.5) => 
-0.0002288608
, 

         (v1_hhcollegeattendedmmbrcnt > 0.5) => 
map(

            ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 40.5) => 
map(

               ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 154876) => 
0.0062722912
, 

               (v1_resinputavmvalue60mo > 154876) => 
0.0244009430
, 

0.0102920405
)
, 

            (v1_lifeevtimelastmove > 40.5) => 
-0.0000624085
, 

0.0047444586
)
, 

0.0007287869
)
, 

      (v1_raacrtrecfelonymmbrcnt > 0.5) => 
-0.0047284406
, 

-0.0001264050
)
, 

   (v1_crtreclienjudgcnt12mo > 1.5) => 
0.0297280724
, 

-0.0000030881
)
, 

(v1_raacrtrecmsdmeanmmbrcnt > 13.5) => 
0.0166092948
, 

0.0003308972
)
;


// Tree: 247

b3_tree_247 := 
map(

( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 3.5) => 
map(

   ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 11.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 121.5) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 2.5) => 
-0.0003964935
, 

         (v1_crtrecbkrpttimenewest > 2.5) => 
map(

            ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 1644) => 
map(

               ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 85005.5) => 
0.0149246112
, 

               (v1_propcurrownedavmttl > 85005.5) => 
0.0422201243
, 

0.0209375608
)
, 

            (v1_crtreclienjudgamtttl > 1644) => 
0.0001872430
, 

0.0142912184
)
, 

0.0001905207
)
, 

      (v1_crtrecbkrpttimenewest > 121.5) => 
-0.0101851467
, 

-0.0000756845
)
, 

   (v1_raacrtrecmsdmeanmmbrcnt > 11.5) => 
0.0117803143
, 

0.0002743830
)
, 

(v1_occproflicensecategory > 3.5) => 
0.0297350384
, 

0.0004467690
)
;


// Tree: 251

b3_tree_251 := 
map(

( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 119.5) => 
map(

   ( NULL < v1_proppurchasecnt12mo and v1_proppurchasecnt12mo <= 0.5) => 
map(

      ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
-0.0011213661
, 

         (v1_raammbrcnt > 0.5) => 
0.0081790184
, 

0.0019630914
)
, 

      (v1_raacrtrecmmbrcnt > 0.5) => 
-0.0017381657
, 

-0.0003991076
)
, 

   (v1_proppurchasecnt12mo > 0.5) => 
0.0155888668
, 

-0.0001667822
)
, 

(v1_crtrecmsdmeantimenewest > 119.5) => 
map(

   ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.485) => 
0.0067703875
, 

   (v1_resinputavmcntyratio > 1.485) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 112.5) => 
0.0974985417
, 

      (v1_prospecttimeonrecord > 112.5) => 
0.0204300242
, 

0.0413527351
)
, 

0.0094622860
)
, 

0.0002340728
)
;


// Tree: 255

b3_tree_255 := 
map(

( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 574711.5) => 
map(

   ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 1.5) => 
map(

      ( NULL < v1_hhcrtreclienjudgmmbrcnt12mo and v1_hhcrtreclienjudgmmbrcnt12mo <= 0.5) => 
map(

         ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 109726.5) => 
map(

            ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 0.695) => 
0.0008989960
, 

            (v1_resinputavmratiodiff12mo > 0.695) => 
-0.0071696943
, 

-0.0005551840
)
, 

         (v1_resinputavmvalue > 109726.5) => 
0.0042023450
, 

0.0005977916
)
, 

      (v1_hhcrtreclienjudgmmbrcnt12mo > 0.5) => 
0.0144075177
, 

0.0008914355
)
, 

   (v1_resinputbusinesscnt > 1.5) => 
-0.0040065007
, 

0.0000188427
)
, 

(v1_raapropowneravmmed > 574711.5) => 
map(

   ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 0.5) => 
-0.0088948675
, 

   (v1_rescurrownershipindex > 0.5) => 
0.0264316773
, 

0.0138960430
)
, 

0.0003311586
)
;


// Tree: 259

b3_tree_259 := 
map(

( NULL < v1_interestsportperson and v1_interestsportperson <= 0.5) => 
map(

   ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 137785.5) => 
map(

      ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 0.045) => 
map(

         ( NULL < v1_hhcrtrecfelonymmbrcnt and v1_hhcrtrecfelonymmbrcnt <= 0.5) => 
0.0015779279
, 

         (v1_hhcrtrecfelonymmbrcnt > 0.5) => 
-0.0140428501
, 

0.0009876673
)
, 

      (v1_resinputavmratiodiff12mo > 0.045) => 
map(

         ( NULL < v1_lifeevtimelastassetpurchase and v1_lifeevtimelastassetpurchase <= 110.5) => 
-0.0067509715
, 

         (v1_lifeevtimelastassetpurchase > 110.5) => 
0.0082596285
, 

-0.0056165450
)
, 

-0.0005640405
)
, 

   (v1_resinputavmvalue60mo > 137785.5) => 
0.0036426124
, 

0.0004197287
)
, 

(v1_interestsportperson > 0.5) => 
map(

   ( NULL < v1_crtreccnt and v1_crtreccnt <= 11.5) => 
0.0157635567
, 

   (v1_crtreccnt > 11.5) => 
-0.0551908113
, 

0.0132195711
)
, 

0.0006444713
)
;


// Tree: 263

b3_tree_263 := 
map(

( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 2.5) => 
map(

   ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 169.5) => 
-0.0001924248
, 

   (v1_crtreclienjudgtimenewest > 169.5) => 
map(

      ( NULL < v1_lifeevecontrajectoryindex and v1_lifeevecontrajectoryindex <= 1.5) => 
0.0260670707
, 

      (v1_lifeevecontrajectoryindex > 1.5) => 
-0.0235886406
, 

-0.0163195872
)
, 

-0.0004066814
)
, 

(v1_crtrecbkrpttimenewest > 2.5) => 
map(

   ( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 311900.5) => 
map(

      ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
0.0045970722
, 

      (v1_prospectcollegeattending > 0.5) => 
-0.0561379482
, 

0.0038069970
)
, 

   (v1_rescurravmvalue60mo > 311900.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 124.5) => 
0.0510929936
, 

      (v1_crtrecbkrpttimenewest > 124.5) => 
-0.0021987204
, 

0.0294776229
)
, 

0.0059265469
)
, 

0.0000130479
)
;


// Tree: 267

b3_tree_267 := 
map(

( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 177.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
map(

      ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.765) => 
-0.0001867240
, 

      (v1_resinputavmcntyratio > 1.765) => 
-0.0122449371
, 

-0.0006869930
)
, 

   (v1_lifeeveverresidedcnt > 1.5) => 
map(

      ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 5.5) => 
0.0206203898
, 

         (v1_raammbrcnt > 5.5) => 
0.0059330435
, 

0.0108174555
)
, 

      (v1_hhcrtrecmmbrcnt > 0.5) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
-0.0026052501
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
0.0089178959
, 

0.0007675364
)
, 

0.0041068538
)
, 

0.0003531414
)
, 

(v1_crtrecbkrpttimenewest > 177.5) => 
-0.0158936645
, 

0.0001610414
)
;


// Tree: 271

b3_tree_271 := 
map(

( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 2.5) => 
map(

   ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 1.5) => 
-0.0017818817
, 

   (v1_raapropcurrownermmbrcnt > 1.5) => 
map(

      ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 2.5) => 
map(

         ( NULL < v1_interestsportperson and v1_interestsportperson <= 0.5) => 
0.0066317768
, 

         (v1_interestsportperson > 0.5) => 
0.0358641539
, 

0.0075007490
)
, 

      (v1_raacrtrecmmbrcnt > 2.5) => 
map(

         ( NULL < v1_hhcrtrecmmbrcnt12mo and v1_hhcrtrecmmbrcnt12mo <= 0.5) => 
-0.0009212400
, 

         (v1_hhcrtrecmmbrcnt12mo > 0.5) => 
map(

            ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
0.0200305954
, 

            (v1_verifiedcurrresmatchindex > 0.5) => 
-0.0004845054
, 

0.0105027106
)
, 

0.0004069392
)
, 

0.0024526509
)
, 

0.0002383463
)
, 

(v1_resinputbusinesscnt > 2.5) => 
-0.0061863709
, 

-0.0004429272
)
;


// Tree: 275

b3_tree_275 := 
map(

( NULL < v1_occproflicense and v1_occproflicense <= 0.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 95.5) => 
map(

      ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 160.5) => 
-0.0000857478
, 

      (v1_crtrecmsdmeantimenewest > 160.5) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 39.5) => 
0.0059214994
, 

         (v1_prospecttimelastupdate > 39.5) => 
0.0340062971
, 

0.0138656666
)
, 

0.0002181786
)
, 

   (v1_prospecttimelastupdate > 95.5) => 
map(

      ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 410577) => 
map(

         ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 2.455) => 
-0.0098813998
, 

         (v1_rescurravmcntyratio > 2.455) => 
0.0548551322
, 

-0.0091072510
)
, 

      (v1_hhpropcurravmhighest > 410577) => 
0.0242779153
, 

-0.0074466642
)
, 

-0.0002766612
)
, 

(v1_occproflicense > 0.5) => 
0.0101975564
, 

0.0001149533
)
;


// Tree: 279

b3_tree_279 := 
map(

( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 73873) => 
map(

   ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 46.5) => 
-0.0002319346
, 

   (v1_raacrtrecmmbrcnt > 46.5) => 
map(

      ( NULL < v1_raaseniormmbrcnt and v1_raaseniormmbrcnt <= 3.5) => 
-0.0191568822
, 

      (v1_raaseniormmbrcnt > 3.5) => 
map(

         ( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 370738.5) => 
0.1426755271
, 

         (v1_rescurravmvalue12mo > 370738.5) => 
-0.1404561064
, 

0.1101850118
)
, 

0.0589604993
)
, 

-0.0001768371
)
, 

(v1_propcurrownedassessedttl > 73873) => 
map(

   ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 161.5) => 
0.0043088310
, 

   (v1_crtrecmsdmeantimenewest > 161.5) => 
map(

      ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 0.5) => 
0.0754306035
, 

      (v1_raacrtreclienjudgmmbrcnt > 0.5) => 
0.0147358722
, 

0.0326965580
)
, 

0.0054833938
)
, 

0.0005264775
)
;


// Tree: 283

b3_tree_283 := 
map(

( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 64050.5) => 
map(

   ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
map(

      (v1_resinputdwelltype in ['P','S']) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
map(

            ( NULL < v1_prospectcollegeprivate and v1_prospectcollegeprivate <= 0.5) => 
-0.0032224628
, 

            (v1_prospectcollegeprivate > 0.5) => 
0.0391111297
, 

-0.0029701287
)
, 

         (v1_hhcnt > 1.5) => 
0.0055841986
, 

-0.0016099303
)
, 

      (v1_resinputdwelltype in ['-1','0','F','G','H','R','U']) => 
0.0053567000
, 

0.0002723245
)
, 

   (v1_verifiedcurrresmatchindex > 0.5) => 
map(

      ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
0.0023920293
, 

      (v1_hhcrtrecmmbrcnt > 0.5) => 
-0.0084407971
, 

-0.0045658046
)
, 

-0.0007245453
)
, 

(v1_propcurrownedassessedttl > 64050.5) => 
0.0047072878
, 

-0.0000092558
)
;


// Tree: 287

b3_tree_287 := 
map(

( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 372.5) => 
map(

   ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 3998.5) => 
0.0000236872
, 

   (v1_hhcrtreclienjudgamtttl > 3998.5) => 
-0.0058027751
, 

-0.0004841083
)
, 

(v1_lifeevtimelastmove > 372.5) => 
map(

   ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 122989) => 
0.0021104254
, 

   (v1_resinputavmvalue60mo > 122989) => 
map(

      ( NULL < v1_rescurravmtractratio and v1_rescurravmtractratio <= 0.935) => 
map(

         ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 129075.5) => 
0.2064037922
, 

         (v1_resinputavmvalue60mo > 129075.5) => 
map(

            ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 300001.5) => 
0.0229684400
, 

            (v1_resinputavmvalue12mo > 300001.5) => 
0.1003218902
, 

0.0416010229
)
, 

0.0485158244
)
, 

      (v1_rescurravmtractratio > 0.935) => 
0.0122872641
, 

0.0243241696
)
, 

0.0102486579
)
, 

-0.0002296965
)
;


// Tree: 291

b3_tree_291 := 
map(

( NULL < v1_proptimelastsale and v1_proptimelastsale <= 0) => 
map(

   (v1_resinputdwelltype in ['F','G','H','P','S']) => 
map(

      ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
-0.0012181610
, 

      (v1_hhseniormmbrcnt > 0.5) => 
map(

         ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
map(

            ( NULL < v1_raahhcnt and v1_raahhcnt <= 0.5) => 
0.0440627808
, 

            (v1_raahhcnt > 0.5) => 
0.0090098267
, 

0.0125961164
)
, 

         (v1_hhcrtrecmmbrcnt > 0.5) => 
-0.0001564136
, 

0.0052345658
)
, 

-0.0006742445
)
, 

   (v1_resinputdwelltype in ['-1','0','R','U']) => 
0.0308565939
, 

-0.0005277257
)
, 

(v1_proptimelastsale > 0) => 
map(

   ( NULL < v1_propcurrownedcnt and v1_propcurrownedcnt <= 1.5) => 
0.0138522952
, 

   (v1_propcurrownedcnt > 1.5) => 
-0.0041218333
, 

0.0084392998
)
, 

-0.0001266405
)
;


// Tree: 295

b3_tree_295 := 
map(

( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 473721) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 31.5) => 
map(

      ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
0.0003670287
, 

      (v1_hhseniormmbrcnt > 0.5) => 
0.0088385952
, 

0.0008374823
)
, 

   (v1_prospecttimelastupdate > 31.5) => 
map(

      ( NULL < v1_occbusinesstitleleadership and v1_occbusinesstitleleadership <= 1.5) => 
map(

         ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 733.5) => 
-0.0038000680
, 

         (v1_lifeevtimelastmove > 733.5) => 
-0.1091264257
, 

-0.0039108400
)
, 

      (v1_occbusinesstitleleadership > 1.5) => 
map(

         ( NULL < v1_ppcurrowner and v1_ppcurrowner <= 0.5) => 
0.0127841634
, 

         (v1_ppcurrowner > 0.5) => 
0.1413912242
, 

0.0157583299
)
, 

-0.0030260713
)
, 

-0.0000325686
)
, 

(v1_hhcrtreclienjudgamtttl > 473721) => 
-0.0586062862
, 

-0.0000840975
)
;


// Tree: 299

b3_tree_299 := 
map(

( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 4864707.5) => 
map(

   ( NULL < v1_interestsportperson and v1_interestsportperson <= 0.5) => 
map(

      ( NULL < v1_raahhcnt and v1_raahhcnt <= 82) => 
map(

         ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 3.5) => 
0.0005201612
, 

         (v1_resinputbusinesscnt > 3.5) => 
-0.0068461830
, 

0.0000084056
)
, 

      (v1_raahhcnt > 82) => 
0.1739912182
, 

0.0000205596
)
, 

   (v1_interestsportperson > 0.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 433) => 
0.0099648224
, 

      (v1_prospecttimeonrecord > 433) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 9.5) => 
-0.0098564743
, 

         (v1_prospecttimelastupdate > 9.5) => 
0.1647519334
, 

0.0969934468
)
, 

0.0112825439
)
, 

0.0002216851
)
, 

(v1_resinputavmvalue12mo > 4864707.5) => 
0.2044484040
, 

0.0002439371
)
;


// Tree: 303

b3_tree_303 := 
map(

( NULL < v1_ppcurrownedwtrcrftcnt and v1_ppcurrownedwtrcrftcnt <= 1.5) => 
map(

   ( NULL < v1_propcurrownedcnt and v1_propcurrownedcnt <= 5.5) => 
map(

      ( NULL < v1_crtrecevictioncnt12mo and v1_crtrecevictioncnt12mo <= 3.5) => 
map(

         ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 1.5) => 
map(

            ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 167.5) => 
0.0007897035
, 

            (v1_occbusinessassociationtime > 167.5) => 
0.0200176197
, 

0.0009729581
)
, 

         (v1_resinputbusinesscnt > 1.5) => 
map(

            ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 21.5) => 
-0.0044431863
, 

            (v1_raapropcurrownermmbrcnt > 21.5) => 
0.0454849398
, 

-0.0040847647
)
, 

0.0000581594
)
, 

      (v1_crtrecevictioncnt12mo > 3.5) => 
0.0804244784
, 

0.0001054153
)
, 

   (v1_propcurrownedcnt > 5.5) => 
-0.0542087766
, 

0.0000297528
)
, 

(v1_ppcurrownedwtrcrftcnt > 1.5) => 
0.0299558059
, 

0.0001340938
)
;


// Tree: 307

b3_tree_307 := 
map(

( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 91.5) => 
map(

   ( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_assetcurrowner and v1_assetcurrowner <= 0.5) => 
-0.0011279087
, 

      (v1_assetcurrowner > 0.5) => 
0.0214514124
, 

-0.0009688725
)
, 

   (v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
map(

      ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 7.5) => 
0.0221422273
, 

         (v1_raammbrcnt > 7.5) => 
0.0045705613
, 

0.0131399628
)
, 

      (v1_hhcrtrecmmbrcnt > 0.5) => 
-0.0044661181
, 

0.0053804147
)
, 

-0.0005705802
)
, 

(v1_crtrecmsdmeantimenewest > 91.5) => 
map(

   ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 4.5) => 
0.0050992591
, 

   (v1_raayoungadultmmbrcnt > 4.5) => 
0.0299780702
, 

0.0076431807
)
, 

-0.0001041138
)
;


// Tree: 311

b3_tree_311 := 
map(

( NULL < v1_occbusinessassociation and v1_occbusinessassociation <= 0.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 26.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 505.5) => 
0.0010231593
, 

      (v1_prospecttimeonrecord > 505.5) => 
0.0569308158
, 

0.0011158107
)
, 

   (v1_prospecttimelastupdate > 26.5) => 
-0.0035872249
, 

0.0000258335
)
, 

(v1_occbusinessassociation > 0.5) => 
map(

   ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 3.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 28.5) => 
0.0602470187
, 

         (v1_prospecttimeonrecord > 28.5) => 
0.0168405225
, 

0.0280738216
)
, 

      (v1_resinputbusinesscnt > 3.5) => 
-0.0136635147
, 

0.0204668351
)
, 

   (v1_raacrtrecmmbrcnt > 0.5) => 
0.0029637847
, 

0.0059692211
)
, 

0.0004871941
)
;


// Tree: 315

b3_tree_315 := 
map(

( NULL < v1_raacollegemidtiermmbrcnt and v1_raacollegemidtiermmbrcnt <= 1.5) => 
map(

   ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 286.5) => 
-0.0007650183
, 

   (v1_crtrecfelonytimenewest > 286.5) => 
0.0625623327
, 

-0.0006889640
)
, 

(v1_raacollegemidtiermmbrcnt > 1.5) => 
map(

   ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 2.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 103.5) => 
map(

         ( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 524745.5) => 
map(

            ( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 1.145) => 
0.0278168094
, 

            (v1_rescurravmblockratio > 1.145) => 
-0.0336345659
, 

0.0228349287
)
, 

         (v1_rescurravmvalue60mo > 524745.5) => 
0.1765090234
, 

0.0243540479
)
, 

      (v1_crtrecbkrpttimenewest > 103.5) => 
0.1039196555
, 

0.0268528528
)
, 

   (v1_raapropcurrownermmbrcnt > 2.5) => 
0.0009249029
, 

0.0061348365
)
, 

-0.0003311471
)
;


// Tree: 319

b3_tree_319 := 
map(

( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_occproflicense and v1_occproflicense <= 0.5) => 
map(

      ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.855) => 
map(

         ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 17.5) => 
-0.0001583375
, 

         (v1_raacrtreclienjudgmmbrcnt > 17.5) => 
-0.0380445626
, 

-0.0002683327
)
, 

      (v1_resinputavmcntyratio > 1.855) => 
-0.0105476028
, 

-0.0006830374
)
, 

   (v1_occproflicense > 0.5) => 
0.0101978601
, 

-0.0003195813
)
, 

(v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 3.5) => 
map(

      ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 1.145) => 
0.0105856468
, 

      (v1_rescurravmratiodiff60mo > 1.145) => 
0.0573440122
, 

0.0127432233
)
, 

   (v1_hhcnt > 3.5) => 
-0.0028257430
, 

0.0071055353
)
, 

0.0001517472
)
;


// Tree: 323

b3_tree_323 := 
map(

( NULL < v1_rescurravmtractratio and v1_rescurravmtractratio <= 10.8) => 
map(

   ( NULL < v1_raainterestsportpersonmmbrcnt and v1_raainterestsportpersonmmbrcnt <= 4.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 236.5) => 
-0.0006694438
, 

      (v1_prospecttimelastupdate > 236.5) => 
map(

         ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 283953.5) => 
0.0103869038
, 

         (v1_propcurrownedavmttl > 283953.5) => 
0.0866262302
, 

0.0173383028
)
, 

-0.0005709315
)
, 

   (v1_raainterestsportpersonmmbrcnt > 4.5) => 
map(

      ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 2.5) => 
map(

         ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= 197.5) => 
0.0577678774
, 

         (v1_lifeevtimefirstassetpurchase > 197.5) => 
0.2838816467
, 

0.0677288364
)
, 

      (v1_raacrtrecmsdmeanmmbrcnt > 2.5) => 
0.0092429514
, 

0.0207575186
)
, 

-0.0004716697
)
, 

(v1_rescurravmtractratio > 10.8) => 
-0.1145172529
, 

-0.0004983628
)
;


// Tree: 327

b3_tree_327 := 
map(

( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 3966.5) => 
map(

   ( NULL < v1_hhoccbusinessassocmmbrcnt and v1_hhoccbusinessassocmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 3951.5) => 
map(

         ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 4.5) => 
map(

            ( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 736275) => 
map(

               ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 9.5) => 
-0.0023870213
, 

               (v1_raacrtrecmsdmeanmmbrcnt > 9.5) => 
0.0168869726
, 

-0.0020137476
)
, 

            (v1_resinputmortgageamount > 736275) => 
0.1463431242
, 

-0.0019768519
)
, 

         (v1_raapropcurrownermmbrcnt > 4.5) => 
0.0033729588
, 

-0.0009868397
)
, 

      (v1_hhcrtreclienjudgamtttl > 3951.5) => 
0.2282779146
, 

-0.0009675750
)
, 

   (v1_hhoccbusinessassocmmbrcnt > 0.5) => 
0.0067469521
, 

-0.0001645221
)
, 

(v1_hhcrtreclienjudgamtttl > 3966.5) => 
-0.0055675471
, 

-0.0006438530
)
;


// Tree: 331

b3_tree_331 := 
map(

( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 151004) => 
map(

   ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 2.5) => 
map(

      ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 3.5) => 
map(

         ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 0.5) => 
map(

            ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 1.5) => 
0.0007375238
, 

            (v1_occbusinessassociationtime > 1.5) => 
map(

               ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 2.5) => 
0.0462244563
, 

               (v1_raammbrcnt > 2.5) => 
0.0008126824
, 

0.0233237884
)
, 

0.0013423344
)
, 

         (v1_raacrtrecmmbrcnt > 0.5) => 
-0.0036170550
, 

-0.0014211050
)
, 

      (v1_raacrtrecmsdmeanmmbrcnt > 3.5) => 
0.0036059159
, 

-0.0003405010
)
, 

   (v1_resinputbusinesscnt > 2.5) => 
-0.0090345364
, 

-0.0011509341
)
, 

(v1_resinputavmvalue60mo > 151004) => 
0.0038157520
, 

-0.0000596236
)
;


// Tree: 335

b3_tree_335 := 
map(

( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

   ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
0.0014907801
, 

   (v1_hhseniormmbrcnt > 0.5) => 
0.0119363837
, 

0.0021436424
)
, 

(v1_resinputownershipindex > 0.5) => 
map(

   ( NULL < v1_hhcrtreclienjudgmmbrcnt and v1_hhcrtreclienjudgmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 216558) => 
-0.0010475842
, 

      (v1_propcurrownedassessedttl > 216558) => 
0.0102143639
, 

-0.0001880489
)
, 

   (v1_hhcrtreclienjudgmmbrcnt > 0.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 7.5) => 
-0.0150080762
, 

      (v1_crtrectimenewest > 7.5) => 
map(

         ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 437393) => 
-0.0006379091
, 

         (v1_propcurrownedavmttl > 437393) => 
-0.0369382483
, 

-0.0021490343
)
, 

-0.0058928649
)
, 

-0.0013198036
)
, 

0.0001954505
)
;


// Tree: 339

b3_tree_339 := 
map(

( NULL < v1_prospectlastupdate12mo and v1_prospectlastupdate12mo <= 0.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 2.5) => 
-0.0015907628
, 

   (v1_lifeeveverresidedcnt > 2.5) => 
map(

      ( NULL < v1_lifeevtimelastassetpurchase and v1_lifeevtimelastassetpurchase <= 171.5) => 
0.0043106516
, 

      (v1_lifeevtimelastassetpurchase > 171.5) => 
map(

         ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 195476.5) => 
0.0472767238
, 

         (v1_resinputavmvalue60mo > 195476.5) => 
-0.0104244574
, 

0.0311980561
)
, 

0.0061694712
)
, 

-0.0010813267
)
, 

(v1_prospectlastupdate12mo > 0.5) => 
map(

   ( NULL < v1_raainterestsportpersonmmbrcnt and v1_raainterestsportpersonmmbrcnt <= 5.5) => 
0.0043119841
, 

   (v1_raainterestsportpersonmmbrcnt > 5.5) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 256674.5) => 
0.0953317628
, 

      (v1_propcurrownedassessedttl > 256674.5) => 
-0.1124451951
, 

0.0658249759
)
, 

0.0045837031
)
, 

-0.0002066904
)
;


// Tree: 343

b3_tree_343 := 
map(

( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 18.5) => 
map(

   ( NULL < v1_raaseniormmbrcnt and v1_raaseniormmbrcnt <= 3.5) => 
map(

      ( NULL < v1_raacollege2yrattendedmmbrcnt and v1_raacollege2yrattendedmmbrcnt <= 4.5) => 
map(

         ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 6.5) => 
-0.0001449355
, 

         (v1_raacrtreclienjudgmmbrcnt > 6.5) => 
-0.0093200392
, 

-0.0006385042
)
, 

      (v1_raacollege2yrattendedmmbrcnt > 4.5) => 
0.0424118806
, 

-0.0005651488
)
, 

   (v1_raaseniormmbrcnt > 3.5) => 
map(

      ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.005) => 
0.0225835745
, 

      (v1_resinputavmratiodiff12mo > 1.005) => 
-0.0065269608
, 

0.0121465624
)
, 

-0.0003068015
)
, 

(v1_crtrecbkrpttimenewest > 18.5) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
0.0868833315
, 

   (v1_raammbrcnt > 0.5) => 
0.0080904260
, 

0.0092850659
)
, 

0.0002650627
)
;


// Tree: 347

b3_tree_347 := 
map(

( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 47.5) => 
map(

   ( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 191920) => 
0.0001252521
, 

   (v1_rescurravmvalue12mo > 191920) => 
map(

      ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 3340453.5) => 
0.0127196852
, 

         (v1_raacrtreclienjudgamtmax > 3340453.5) => 
0.2771364112
, 

0.0130068066
)
, 

      (v1_hhcrtrecmmbrcnt > 0.5) => 
map(

         ( NULL < v1_crtreccnt12mo and v1_crtreccnt12mo <= 1.5) => 
-0.0029629061
, 

         (v1_crtreccnt12mo > 1.5) => 
0.0463090021
, 

-0.0020677609
)
, 

0.0052589979
)
, 

0.0006357727
)
, 

(v1_raacrtrecmsdmeanmmbrcnt > 47.5) => 
map(

   ( NULL < v1_raappcurrownermmbrcnt and v1_raappcurrownermmbrcnt <= 0.5) => 
-0.0230159040
, 

   (v1_raappcurrownermmbrcnt > 0.5) => 
0.1228426320
, 

0.0683160765
)
, 

0.0006649966
)
;


// Tree: 351

b3_tree_351 := 
map(

( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 287.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 376.5) => 
map(

      ( NULL < v1_propcurrownedcnt and v1_propcurrownedcnt <= 7.5) => 
0.0004301777
, 

      (v1_propcurrownedcnt > 7.5) => 
-0.0784983345
, 

0.0003935247
)
, 

   (v1_prospecttimeonrecord > 376.5) => 
map(

      ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 0.225) => 
map(

         ( NULL < v1_hhcrtrecfelonymmbrcnt and v1_hhcrtrecfelonymmbrcnt <= 0.5) => 
0.0281927408
, 

         (v1_hhcrtrecfelonymmbrcnt > 0.5) => 
-0.0579387154
, 

0.0250759793
)
, 

      (v1_rescurravmratiodiff60mo > 0.225) => 
map(

         ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 0.395) => 
-0.0231480686
, 

         (v1_resinputavmcntyratio > 0.395) => 
0.0107109711
, 

0.0015821714
)
, 

0.0114074704
)
, 

0.0005787837
)
, 

(v1_crtrecfelonytimenewest > 287.5) => 
0.0556135727
, 

0.0006469654
)
;


// Tree: 355

b3_tree_355 := 
map(

( NULL < v1_raacollegetoptiermmbrcnt and v1_raacollegetoptiermmbrcnt <= 0.5) => 
map(

   ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 350.5) => 
0.0000980032
, 

   (v1_lifeevtimelastmove > 350.5) => 
0.0090431270
, 

0.0003751151
)
, 

(v1_raacollegetoptiermmbrcnt > 0.5) => 
map(

   ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 3.44) => 
map(

      ( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 460811.5) => 
0.0056057624
, 

      (v1_rescurravmvalue12mo > 460811.5) => 
map(

         ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 11.5) => 
0.2788856399
, 

         (v1_lifeevtimelastmove > 11.5) => 
map(

            ( NULL < v1_hhcrtrecmsdmeanmmbrcnt and v1_hhcrtrecmsdmeanmmbrcnt <= 1.5) => 
0.0360891235
, 

            (v1_hhcrtrecmsdmeanmmbrcnt > 1.5) => 
-0.0645151921
, 

0.0290105437
)
, 

0.0318352187
)
, 

0.0076028409
)
, 

   (v1_resinputavmratiodiff12mo > 3.44) => 
0.1822691955
, 

0.0079145184
)
, 

0.0008354737
)
;


// Tree: 359

b3_tree_359 := 
map(

( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 13.5) => 
0.0006298709
, 

(v1_raacrtreclienjudgmmbrcnt > 13.5) => 
map(

   ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 406736.5) => 
map(

      ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 9958.5) => 
-0.0479296196
, 

      (v1_raacrtreclienjudgamtmax > 9958.5) => 
map(

         ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 144950) => 
map(

            ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 139779) => 
-0.0034186800
, 

            (v1_hhpropcurravmhighest > 139779) => 
0.2152177889
, 

-0.0013281321
)
, 

         (v1_hhpropcurravmhighest > 144950) => 
map(

            ( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 185781) => 
-0.1100571165
, 

            (v1_rescurravmvalue60mo > 185781) => 
0.0027485882
, 

-0.0549782748
)
, 

-0.0091125193
)
, 

-0.0202139079
)
, 

   (v1_resinputavmvalue60mo > 406736.5) => 
0.0995797997
, 

-0.0170928023
)
, 

0.0004788945
)
;


// Tree: 363

b3_tree_363 := 
map(

( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.415) => 
map(

   ( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 673562.5) => 
0.0000783344
, 

   (v1_rescurravmvalue12mo > 673562.5) => 
map(

      ( NULL < v1_hhcnt and v1_hhcnt <= 3.5) => 
map(

         ( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 0.625) => 
0.2220548092
, 

         (v1_rescurravmblockratio > 0.625) => 
map(

            ( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 4.5) => 
0.0361617923
, 

            (v1_raaoccproflicmmbrcnt > 4.5) => 
-0.1179893129
, 

0.0316236306
)
, 

0.0360399381
)
, 

      (v1_hhcnt > 3.5) => 
map(

         ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 1.685) => 
0.0341329002
, 

         (v1_rescurravmcntyratio > 1.685) => 
-0.0244451361
, 

-0.0057025751
)
, 

0.0162478782
)
, 

0.0002154290
)
, 

(v1_rescurravmratiodiff12mo > 1.415) => 
-0.0097039517
, 

-0.0000254663
)
;


// Tree: 367

b3_tree_367 := 
map(

( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 520223.5) => 
-0.0002406613
, 

(v1_rescurravmvalue60mo > 520223.5) => 
map(

   ( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 0.44) => 
0.2917946366
, 

   (v1_rescurravmratiodiff12mo > 0.44) => 
map(

      ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 159.5) => 
map(

         ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 1.5) => 
map(

            ( NULL < v1_hhcnt and v1_hhcnt <= 7.5) => 
0.0261441907
, 

            (v1_hhcnt > 7.5) => 
-0.0420577112
, 

0.0212543503
)
, 

         (v1_raacrtrecmmbrcnt > 1.5) => 
map(

            ( NULL < v1_hhinterestsportpersonmmbrcnt and v1_hhinterestsportpersonmmbrcnt <= 1.5) => 
-0.0065289941
, 

            (v1_hhinterestsportpersonmmbrcnt > 1.5) => 
0.2366238421
, 

-0.0054372875
)
, 

0.0077681650
)
, 

      (v1_crtrecmsdmeantimenewest > 159.5) => 
0.1003879060
, 

0.0098591569
)
, 

0.0104263174
)
, 

-0.0000266794
)
;


// Tree: 371

b3_tree_371 := 
map(

( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 477246) => 
map(

   ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 3171166.5) => 
map(

      ( NULL < v1_raacollege2yrattendedmmbrcnt and v1_raacollege2yrattendedmmbrcnt <= 3.5) => 
-0.0002883467
, 

      (v1_raacollege2yrattendedmmbrcnt > 3.5) => 
map(

         ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 23.5) => 
0.0300773591
, 

         (v1_raapropcurrownermmbrcnt > 23.5) => 
-0.0629812068
, 

0.0214488786
)
, 

-0.0001830812
)
, 

   (v1_resinputavmvalue12mo > 3171166.5) => 
0.1891784039
, 

-0.0001592452
)
, 

(v1_raapropowneravmmed > 477246) => 
map(

   ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 1.065) => 
0.0140537948
, 

   (v1_resinputavmblockratio > 1.065) => 
map(

      ( NULL < v1_lifeevecontrajectoryindex and v1_lifeevecontrajectoryindex <= 5.5) => 
-0.0131952230
, 

      (v1_lifeevecontrajectoryindex > 5.5) => 
0.1273102305
, 

-0.0079102534
)
, 

0.0079518975
)
, 

0.0001508586
)
;


// Tree: 375

b3_tree_375 := 
map(

( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 768.5) => 
map(

   ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 173391) => 
-0.0009326791
, 

   (v1_propcurrownedassessedttl > 173391) => 
map(

      ( NULL < v1_hhcnt and v1_hhcnt <= 4.5) => 
map(

         ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 1.5) => 
-0.0132796840
, 

         (v1_lifeevtimelastmove > 1.5) => 
map(

            ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 17.5) => 
0.0137770784
, 

            (v1_raacrtrecmmbrcnt > 17.5) => 
-0.0520050244
, 

0.0125807055
)
, 

0.0097039944
)
, 

      (v1_hhcnt > 4.5) => 
map(

         ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 180724) => 
0.0710469121
, 

         (v1_propcurrownedassessedttl > 180724) => 
-0.0112288993
, 

-0.0082897485
)
, 

0.0051974534
)
, 

-0.0005343984
)
, 

(v1_lifeevtimelastmove > 768.5) => 
-0.0839795494
, 

-0.0005606640
)
;


// Tree: 379

b3_tree_379 := 
map(

( NULL < v1_hhoccbusinessassocmmbrcnt and v1_hhoccbusinessassocmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 253.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 25.5) => 
0.0006785486
, 

      (v1_prospecttimelastupdate > 25.5) => 
map(

         ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 5.5) => 
map(

            ( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 1.035) => 
-0.0077650030
, 

            (v1_resinputavmratiodiff60mo > 1.035) => 
0.0080993289
, 

-0.0061876207
)
, 

         (v1_raacrtrecmsdmeanmmbrcnt > 5.5) => 
map(

            ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 0.5) => 
0.0488699617
, 

            (v1_raapropcurrownermmbrcnt > 0.5) => 
0.0018108641
, 

0.0053738498
)
, 

-0.0043026560
)
, 

-0.0004181762
)
, 

   (v1_prospecttimelastupdate > 253.5) => 
0.0261840492
, 

-0.0003085910
)
, 

(v1_hhoccbusinessassocmmbrcnt > 0.5) => 
0.0044578250
, 

0.0002508095
)
;


// Tree: 383

b3_tree_383 := 
map(

( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 1037741) => 
map(

   ( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 3.5) => 
map(

      ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 333008.5) => 
-0.0007964165
, 

      (v1_hhpropcurravmhighest > 333008.5) => 
-0.0074714435
, 

-0.0011563951
)
, 

   (v1_occproflicensecategory > 3.5) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 420480) => 
0.0088333775
, 

      (v1_propcurrownedassessedttl > 420480) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 9.5) => 
map(

            ( NULL < v1_lifeevtimelastassetpurchase and v1_lifeevtimelastassetpurchase <= 174.5) => 
0.1018543973
, 

            (v1_lifeevtimelastassetpurchase > 174.5) => 
0.3853323785
, 

0.1272696646
)
, 

         (v1_raammbrcnt > 9.5) => 
0.0128894071
, 

0.0784433096
)
, 

0.0208138624
)
, 

-0.0010260204
)
, 

(v1_hhcrtreclienjudgamtttl > 1037741) => 
-0.0744606203
, 

-0.0010512095
)
;


// Tree: 387

b3_tree_387 := 
map(

( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
-0.0001319671
, 

(v1_hhseniormmbrcnt > 0.5) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 3.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
0.0514343733
, 

      (v1_raammbrcnt > 0.5) => 
map(

         ( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 225.5) => 
0.0071184928
, 

         (v1_crtrecevictiontimenewest > 225.5) => 
0.2840967945
, 

0.0073960262
)
, 

0.0102263120
)
, 

   (v1_hhcnt > 3.5) => 
map(

      ( NULL < v1_crtreclienjudgcnt and v1_crtreclienjudgcnt <= 2.5) => 
map(

         ( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 5.655) => 
-0.0035095956
, 

         (v1_rescurravmblockratio > 5.655) => 
0.2020898182
, 

-0.0031924756
)
, 

      (v1_crtreclienjudgcnt > 2.5) => 
0.0221836140
, 

-0.0009276870
)
, 

0.0049116132
)
, 

0.0003241459
)
;


// Tree: 391

b3_tree_391 := 
map(

( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_occbusinesstitleleadership and v1_occbusinesstitleleadership <= 1.5) => 
-0.0008934529
, 

   (v1_occbusinesstitleleadership > 1.5) => 
0.0100714900
, 

-0.0005958309
)
, 

(v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
map(

   ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 3.5) => 
map(

      ( NULL < v1_hhcnt and v1_hhcnt <= 5.5) => 
map(

         ( NULL < v1_lifeevecontrajectory and v1_lifeevecontrajectory <= 8.5) => 
0.0114723982
, 

         (v1_lifeevecontrajectory > 8.5) => 
map(

            ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 82.5) => 
-0.0246783246
, 

            (v1_prospecttimeonrecord > 82.5) => 
0.0742881366
, 

0.0527591762
)
, 

0.0137784224
)
, 

      (v1_hhcnt > 5.5) => 
-0.0123426728
, 

0.0097692446
)
, 

   (v1_raacrtreclienjudgmmbrcnt > 3.5) => 
-0.0092378479
, 

0.0060895458
)
, 

-0.0001762345
)
;


// Tree: 395

b3_tree_395 := 
map(

( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 4837906.5) => 
map(

   ( NULL < v1_donotmail and v1_donotmail <= 0.5) => 
-0.0002825074
, 

   (v1_donotmail > 0.5) => 
map(

      ( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 712170) => 
map(

         ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 0.585) => 
map(

            ( NULL < v1_prospectlastupdate12mo and v1_prospectlastupdate12mo <= 0.5) => 
map(

               ( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 0.695) => 
0.0801073963
, 

               (v1_rescurravmblockratio > 0.695) => 
0.2755813588
, 

0.1052820733
)
, 

            (v1_prospectlastupdate12mo > 0.5) => 
-0.0256953141
, 

0.0616229442
)
, 

         (v1_resinputavmtractratio > 0.585) => 
0.0006473275
, 

0.0224007907
)
, 

      (v1_rescurravmvalue60mo > 712170) => 
0.1629974772
, 

0.0284609928
)
, 

-0.0002152242
)
, 

(v1_resinputavmvalue12mo > 4837906.5) => 
0.1609844596
, 

-0.0001976603
)
;


// Tree: 399

b3_tree_399 := 
map(

( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 149.5) => 
0.0000657530
, 

(v1_crtrecmsdmeantimenewest > 149.5) => 
map(

   ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 8.5) => 
map(

      ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 17.5) => 
map(

         ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 927000) => 
0.0086947627
, 

         (v1_resinputavmvalue > 927000) => 
map(

            ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.125) => 
0.0192181918
, 

            (v1_resinputavmratiodiff12mo > 1.125) => 
0.2762866985
, 

0.1594373773
)
, 

0.0094203325
)
, 

      (v1_raacrtreclienjudgmmbrcnt > 17.5) => 
-0.1184639662
, 

0.0083842328
)
, 

   (v1_raacrtrecfelonymmbrcnt > 8.5) => 
map(

      ( NULL < v1_hhcrtreclienjudgmmbrcnt and v1_hhcrtreclienjudgmmbrcnt <= 0.5) => 
0.0458525560
, 

      (v1_hhcrtreclienjudgmmbrcnt > 0.5) => 
0.2997431299
, 

0.1573167104
)
, 

0.0092624482
)
, 

0.0003237981
)
;


// Tree: 403

b3_tree_403 := 
map(

( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 494) => 
map(

   ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 1.565) => 
map(

      ( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 147921) => 
-0.0012472769
, 

      (v1_rescurravmvalue12mo > 147921) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 66.5) => 
map(

            ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 0.485) => 
0.0693722115
, 

            (v1_rescurravmcntyratio > 0.485) => 
-0.0135278274
, 

-0.0110986731
)
, 

         (v1_prospecttimeonrecord > 66.5) => 
0.0053959778
, 

0.0033050700
)
, 

-0.0006596625
)
, 

   (v1_rescurravmratiodiff60mo > 1.565) => 
map(

      ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 31.5) => 
-0.0082123108
, 

      (v1_crtreclienjudgtimenewest > 31.5) => 
-0.0540736727
, 

-0.0182895955
)
, 

-0.0007772124
)
, 

(v1_crtrecmsdmeantimenewest > 494) => 
0.1107064229
, 

-0.0007592170
)
;


// Tree: 407

b3_tree_407 := 
map(

( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 13.5) => 
map(

   ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 13.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 134.5) => 
0.0003355435
, 

      (v1_crtrecbkrpttimenewest > 134.5) => 
-0.0097597155
, 

0.0001185480
)
, 

   (v1_raamiddleagemmbrcnt > 13.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 65.5) => 
map(

         ( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 17.5) => 
0.0206787204
, 

         (v1_raaoccbusinessassocmmbrcnt > 17.5) => 
0.1137178288
, 

0.0243828536
)
, 

      (v1_raammbrcnt > 65.5) => 
-0.0263443014
, 

0.0169334112
)
, 

0.0002555642
)
, 

(v1_raacrtreclienjudgmmbrcnt > 13.5) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 229) => 
-0.0184785886
, 

   (v1_crtrectimenewest > 229) => 
0.1546071339
, 

-0.0167600069
)
, 

0.0001103368
)
;


// Tree: 411

b3_tree_411 := 
map(

( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
-0.0005190204
, 

(v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 3.5) => 
map(

      ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 829532) => 
map(

         ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 179214.5) => 
0.0059378213
, 

         (v1_propcurrownedavmttl > 179214.5) => 
map(

            ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.605) => 
0.0151884605
, 

            (v1_resinputavmcntyratio > 1.605) => 
map(

               ( NULL < v1_rescurravmvalue and v1_rescurravmvalue <= 627500) => 
0.0510004814
, 

               (v1_rescurravmvalue > 627500) => 
0.1582664553
, 

0.0648756820
)
, 

0.0318893493
)
, 

0.0105492557
)
, 

      (v1_raapropowneravmmed > 829532) => 
0.0949099940
, 

0.0114666694
)
, 

   (v1_hhcnt > 3.5) => 
-0.0030015038
, 

0.0063914897
)
, 

-0.0000805810
)
;


// Tree: 415

b3_tree_415 := 
map(

( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 694.5) => 
map(

   ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 565.5) => 
map(

      ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 2525.5) => 
0.0006857942
, 

      (v1_crtreclienjudgamtttl > 2525.5) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 2.5) => 
map(

            ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 859044) => 
-0.0008134481
, 

            (v1_raapropowneravmhighest > 859044) => 
-0.0579544325
, 

-0.0022653062
)
, 

         (v1_hhcnt > 2.5) => 
map(

            ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 188.5) => 
0.0166493659
, 

            (v1_crtreclienjudgtimenewest > 188.5) => 
-0.0217409829
, 

0.0138439173
)
, 

0.0056800340
)
, 

0.0010365232
)
, 

   (v1_crtrecmsdmeantimenewest > 565.5) => 
0.2503206741
, 

0.0010465863
)
, 

(v1_prospecttimeonrecord > 694.5) => 
-0.0860329128
, 

0.0010177711
)
;


// Tree: 419

b3_tree_419 := 
map(

( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 45.5) => 
map(

   ( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 200.5) => 
-0.0008610348
, 

      (v1_occbusinessassociationtime > 200.5) => 
0.0185362566
, 

-0.0006791078
)
, 

   (v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
0.0065326732
, 

-0.0002191966
)
, 

(v1_crtreclienjudgtimenewest > 45.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 168611) => 
map(

      ( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 0.995) => 
0.0021127263
, 

      (v1_rescurravmratiodiff12mo > 0.995) => 
-0.0136316924
, 

-0.0021366135
)
, 

   (v1_raapropowneravmmed > 168611) => 
map(

      ( NULL < v1_hhcnt and v1_hhcnt <= 11.5) => 
-0.0188054820
, 

      (v1_hhcnt > 11.5) => 
0.0684832903
, 

-0.0172209308
)
, 

-0.0063841776
)
, 

-0.0007204975
)
;


// Tree: 423

b3_tree_423 := 
map(

( NULL < v1_hhcnt and v1_hhcnt <= 5.5) => 
map(

   ( NULL < v1_raacollegemidtiermmbrcnt and v1_raacollegemidtiermmbrcnt <= 1.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 197.5) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 168.5) => 
0.0000008411
, 

         (v1_crtrecbkrpttimenewest > 168.5) => 
map(

            ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 8.5) => 
0.0144194187
, 

            (v1_raacrtrecmsdmeanmmbrcnt > 8.5) => 
map(

               ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 132432.5) => 
0.1696289066
, 

               (v1_raapropowneravmmed > 132432.5) => 
0.0006741278
, 

0.0888244472
)
, 

0.0210319213
)
, 

0.0001264780
)
, 

      (v1_crtrecbkrpttimenewest > 197.5) => 
-0.0217804479
, 

-0.0000080103
)
, 

   (v1_raacollegemidtiermmbrcnt > 1.5) => 
0.0072504787
, 

0.0003610418
)
, 

(v1_hhcnt > 5.5) => 
-0.0055270220
, 

-0.0000709564
)
;


// Tree: 427

b3_tree_427 := 
map(

( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.225) => 
map(

   ( NULL < v1_assetcurrowner and v1_assetcurrowner <= 0.5) => 
0.0007448339
, 

   (v1_assetcurrowner > 0.5) => 
map(

      ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 104.5) => 
map(

         ( NULL < v1_hhcollegetiermmbrhighest and v1_hhcollegetiermmbrhighest <= 2.5) => 
0.0290990214
, 

         (v1_hhcollegetiermmbrhighest > 2.5) => 
-0.0207876344
, 

0.0212960119
)
, 

      (v1_crtreclienjudgtimenewest > 104.5) => 
-0.0465491183
, 

0.0167705303
)
, 

0.0008705307
)
, 

(v1_rescurravmratiodiff12mo > 1.225) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 389.5) => 
map(

      ( NULL < v1_raacollege2yrattendedmmbrcnt and v1_raacollege2yrattendedmmbrcnt <= 1.5) => 
-0.0068368447
, 

      (v1_raacollege2yrattendedmmbrcnt > 1.5) => 
0.0248747877
, 

-0.0058250947
)
, 

   (v1_crtrectimenewest > 389.5) => 
0.2490006678
, 

-0.0056507476
)
, 

0.0004858921
)
;


// Tree: 431

b3_tree_431 := 
map(

( NULL < v1_donotmail and v1_donotmail <= 0.5) => 
-0.0003167710
, 

(v1_donotmail > 0.5) => 
map(

   ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
map(

      (v1_resinputdwelltype in ['0','S']) => 
0.0563143701
, 

      (v1_resinputdwelltype in ['-1','F','G','H','P','R','U']) => 
map(

         ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 1703.5) => 
0.2507061343
, 

         (v1_raacrtreclienjudgamtmax > 1703.5) => 
-0.0182357647
, 

0.1958200324
)
, 

0.0974937524
)
, 

   (v1_hhpropcurrownermmbrcnt > 0.5) => 
map(

      ( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 631633) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 49.5) => 
-0.0254535046
, 

         (v1_prospecttimelastupdate > 49.5) => 
0.0585618512
, 

-0.0055496173
)
, 

      (v1_rescurravmvalue12mo > 631633) => 
0.1831691469
, 

0.0075862596
)
, 

0.0325856629
)
, 

-0.0002375037
)
;


// Tree: 435

b3_tree_435 := 
map(

( NULL < v1_raaseniormmbrcnt and v1_raaseniormmbrcnt <= 2.5) => 
0.0002661794
, 

(v1_raaseniormmbrcnt > 2.5) => 
map(

   ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 120.5) => 
map(

      ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= 241.5) => 
0.0033956897
, 

      (v1_lifeevtimefirstassetpurchase > 241.5) => 
0.0615925639
, 

0.0045636898
)
, 

   (v1_crtrecmsdmeantimenewest > 120.5) => 
map(

      ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 200.5) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 3.5) => 
-0.1145638965
, 

         (v1_crtrectimenewest > 3.5) => 
0.0499634097
, 

0.0459963807
)
, 

      (v1_crtrecmsdmeantimenewest > 200.5) => 
map(

         ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 0.915) => 
0.0139141321
, 

         (v1_rescurravmratiodiff60mo > 0.915) => 
-0.0692804792
, 

-0.0013326891
)
, 

0.0275784016
)
, 

0.0067002024
)
, 

0.0006269774
)
;


// Tree: 439

b3_tree_439 := 
map(

( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 605448.5) => 
-0.0001659585
, 

(v1_rescurravmvalue60mo > 605448.5) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 2.5) => 
map(

      ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 0.915) => 
0.0005999564
, 

      (v1_rescurravmratiodiff60mo > 0.915) => 
map(

         ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 1682000) => 
map(

            ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 1038000) => 
0.0696183607
, 

            (v1_propcurrownedavmttl > 1038000) => 
-0.0187525577
, 

0.0520028953
)
, 

         (v1_hhpropcurravmhighest > 1682000) => 
0.2330508595
, 

0.0594985116
)
, 

0.0345030661
)
, 

   (v1_hhcnt > 2.5) => 
map(

      ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= 8.5) => 
0.0230319842
, 

      (v1_lifeevtimefirstassetpurchase > 8.5) => 
-0.0139233484
, 

0.0008195574
)
, 

0.0117827758
)
, 

-0.0000043301
)
;


// Tree: 443

b3_tree_443 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 117.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 95.5) => 
map(

      ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 1.5) => 
map(

         ( NULL < v1_hhcrtrecmmbrcnt12mo and v1_hhcrtrecmmbrcnt12mo <= 0.5) => 
-0.0001467332
, 

         (v1_hhcrtrecmmbrcnt12mo > 0.5) => 
0.0145211551
, 

0.0004519905
)
, 

      (v1_verifiedcurrresmatchindex > 1.5) => 
-0.0063268981
, 

-0.0001870033
)
, 

   (v1_prospecttimeonrecord > 95.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
-0.0242643382
, 

      (v1_lifeeveverresidedcnt > 0.5) => 
0.0035272966
, 

0.0030557053
)
, 

0.0008151310
)
, 

(v1_prospecttimelastupdate > 117.5) => 
map(

   ( NULL < v1_proptimelastsale and v1_proptimelastsale <= 232.5) => 
-0.0063269163
, 

   (v1_proptimelastsale > 232.5) => 
0.1437809442
, 

-0.0060343627
)
, 

0.0005173017
)
;


// Tree: 447

b3_tree_447 := 
map(

( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 3.5) => 
-0.0011859147
, 

   (v1_crtrecbkrpttimenewest > 3.5) => 
0.0059929992
, 

-0.0007645989
)
, 

(v1_hhyoungadultmmbrcnt > 0.5) => 
map(

   ( NULL < v1_crtreclienjudgcnt and v1_crtreclienjudgcnt <= 2.5) => 
map(

      ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 384390.5) => 
0.0003514931
, 

      (v1_raapropowneravmhighest > 384390.5) => 
map(

         ( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 235954.5) => 
map(

            ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 544375) => 
0.0181298724
, 

            (v1_resinputavmvalue > 544375) => 
0.0772360342
, 

0.0210806640
)
, 

         (v1_rescurravmvalue12mo > 235954.5) => 
-0.0034607981
, 

0.0124096977
)
, 

0.0025762419
)
, 

   (v1_crtreclienjudgcnt > 2.5) => 
0.0202732466
, 

0.0039301762
)
, 

-0.0000895512
)
;


// Tree: 451

b3_tree_451 := 
map(

( NULL < v1_raammbrcnt and v1_raammbrcnt <= 25.5) => 
-0.0007538454
, 

(v1_raammbrcnt > 25.5) => 
map(

   ( NULL < v1_raahhcnt and v1_raahhcnt <= 1.5) => 
0.2551439169
, 

   (v1_raahhcnt > 1.5) => 
map(

      ( NULL < v1_prospectcollegeattended and v1_prospectcollegeattended <= 0.5) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 349.5) => 
map(

            ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 53.5) => 
map(

               ( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 2.5) => 
0.0116345908
, 

               (v1_raaoccproflicmmbrcnt > 2.5) => 
-0.0095623032
, 

0.0060536429
)
, 

            (v1_crtrecmsdmeantimenewest > 53.5) => 
0.0262024735
, 

0.0101521355
)
, 

         (v1_crtrectimenewest > 349.5) => 
-0.1311638131
, 

0.0098279234
)
, 

      (v1_prospectcollegeattended > 0.5) => 
-0.0094029525
, 

0.0063605793
)
, 

0.0065942884
)
, 

-0.0003750579
)
;


// Tree: 455

b3_tree_455 := 
map(

( NULL < v1_propsoldratio and v1_propsoldratio <= 0.115) => 
map(

   ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 6.5) => 
0.0000671796
, 

   (v1_raacrtreclienjudgmmbrcnt > 6.5) => 
map(

      ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 33.5) => 
map(

         ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 337908.5) => 
-0.0142943440
, 

         (v1_raacrtreclienjudgamtmax > 337908.5) => 
0.0421532679
, 

-0.0128370262
)
, 

      (v1_hhcrtreclienjudgamtttl > 33.5) => 
map(

         ( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 1.5) => 
0.0027202152
, 

         (v1_hhcollege4yrattendedmmbrcnt > 1.5) => 
-0.0986497954
, 

0.0017971667
)
, 

-0.0062644576
)
, 

-0.0003578438
)
, 

(v1_propsoldratio > 0.115) => 
map(

   ( NULL < v1_hhcrtreclienjudgmmbrcnt and v1_hhcrtreclienjudgmmbrcnt <= 2.5) => 
0.0110894193
, 

   (v1_hhcrtreclienjudgmmbrcnt > 2.5) => 
0.1226903226
, 

0.0122817366
)
, 

-0.0001668760
)
;


// Tree: 459

b3_tree_459 := 
map(

( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 3.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 118.5) => 
map(

      ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 82.5) => 
0.0008844731
, 

      (v1_crtrecmsdmeantimenewest > 82.5) => 
map(

         ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 191650) => 
0.0058883750
, 

         (v1_propcurrownedassessedttl > 191650) => 
0.0340028145
, 

0.0081851456
)
, 

0.0013380607
)
, 

   (v1_prospecttimelastupdate > 118.5) => 
map(

      ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 287237.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
0.0219971108
, 

         (v1_raammbrcnt > 0.5) => 
-0.0116861984
, 

-0.0087669534
)
, 

      (v1_propcurrownedavmttl > 287237.5) => 
0.0247010747
, 

-0.0066248607
)
, 

0.0010050359
)
, 

(v1_resinputbusinesscnt > 3.5) => 
-0.0083542049
, 

0.0003515237
)
;


// Tree: 463

b3_tree_463 := 
map(

( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 105919.5) => 
0.0003044246
, 

(v1_raacrtreclienjudgamtmax > 105919.5) => 
map(

   ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 236.5) => 
map(

      ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 144941.5) => 
map(

         ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 107932) => 
0.1017523389
, 

         (v1_raacrtreclienjudgamtmax > 107932) => 
map(

            ( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 2.5) => 
-0.0110420012
, 

            (v1_raaoccproflicmmbrcnt > 2.5) => 
0.0931744365
, 

-0.0067896465
)
, 

-0.0025344224
)
, 

      (v1_raapropowneravmhighest > 144941.5) => 
0.0172540190
, 

0.0114669352
)
, 

   (v1_crtrecmsdmeantimenewest > 236.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 230) => 
-0.1004404946
, 

      (v1_lifeevtimelastmove > 230) => 
0.1510553127
, 

-0.0675065199
)
, 

0.0102778744
)
, 

0.0005289645
)
;


// Tree: 467

b3_tree_467 := 
map(

( NULL < v1_raaelderlymmbrcnt and v1_raaelderlymmbrcnt <= 3.5) => 
map(

   ( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 1044961.5) => 
0.0001675017
, 

   (v1_rescurravmvalue60mo > 1044961.5) => 
0.0278735773
, 

0.0002389491
)
, 

(v1_raaelderlymmbrcnt > 3.5) => 
map(

   ( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 1.075) => 
map(

      ( NULL < v1_raacrtrecmsdmeanmmbrcnt12mo and v1_raacrtrecmsdmeanmmbrcnt12mo <= 6.5) => 
map(

         ( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 218453) => 
-0.0204181978
, 

         (v1_rescurrmortgageamount > 218453) => 
0.1393722927
, 

-0.0161189021
)
, 

      (v1_raacrtrecmsdmeanmmbrcnt12mo > 6.5) => 
0.1138771226
, 

-0.0117528384
)
, 

   (v1_rescurravmblockratio > 1.075) => 
map(

      ( NULL < v1_hhcollegetiermmbrhighest and v1_hhcollegetiermmbrhighest <= 4.5) => 
-0.0765206080
, 

      (v1_hhcollegetiermmbrhighest > 4.5) => 
0.1503980470
, 

-0.0674800242
)
, 

-0.0236672538
)
, 

0.0001256907
)
;


// Tree: 471

b3_tree_471 := 
map(

( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 674.5) => 
map(

   ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 4.5) => 
0.0001173404
, 

   (v1_raacrtreclienjudgmmbrcnt > 4.5) => 
map(

      ( NULL < v1_proptimelastsale and v1_proptimelastsale <= 238.5) => 
map(

         ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 5.5) => 
map(

            ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 0.5) => 
-0.0117929430
, 

            (v1_raacrtrecevictionmmbrcnt > 0.5) => 
map(

               ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 2291) => 
-0.0042057723
, 

               (v1_hhcrtreclienjudgamtttl > 2291) => 
0.0078211455
, 

-0.0008130199
)
, 

-0.0029950890
)
, 

         (v1_crtrecmsdmeancnt > 5.5) => 
-0.0238276770
, 

-0.0046920623
)
, 

      (v1_proptimelastsale > 238.5) => 
0.1837782061
, 

-0.0045870876
)
, 

-0.0004966863
)
, 

(v1_lifeevtimelastmove > 674.5) => 
-0.0503479020
, 

-0.0005377254
)
;


// Tree: 475

b3_tree_475 := 
map(

( NULL < v1_crtreclienjudgcnt12mo and v1_crtreclienjudgcnt12mo <= 1.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 10.5) => 
-0.0002490539
, 

   (v1_lifeeveverresidedcnt > 10.5) => 
-0.0858373398
, 

-0.0002889350
)
, 

(v1_crtreclienjudgcnt12mo > 1.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 6.5) => 
map(

      ( NULL < v1_resinputmortgagetype and v1_resinputmortgagetype <= 0) => 
map(

         ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
0.0568815291
, 

         (v1_hhpropcurrownermmbrcnt > 0.5) => 
map(

            ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 97659.5) => 
-0.0178345829
, 

            (v1_propcurrownedavmttl > 97659.5) => 
0.0484346560
, 

0.0036054650
)
, 

0.0320680198
)
, 

      (v1_resinputmortgagetype > 0) => 
0.1976031129
, 

0.0343049805
)
, 

   (v1_lifeeveverresidedcnt > 6.5) => 
-0.0800130833
, 

0.0295227507
)
, 

-0.0001681503
)
;


// Tree: 479

b3_tree_479 := 
map(

( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 131156.5) => 
map(

   ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
0.0007195155
, 

   (v1_verifiedcurrresmatchindex > 0.5) => 
map(

      ( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.145) => 
-0.0025835361
, 

      (v1_rescurravmratiodiff12mo > 1.145) => 
-0.0130512601
, 

-0.0043342235
)
, 

-0.0003395958
)
, 

(v1_propcurrownedavmttl > 131156.5) => 
map(

   ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 1.5) => 
-0.0045034800
, 

   (v1_raapropcurrownermmbrcnt > 1.5) => 
map(

      ( NULL < v1_hhcnt and v1_hhcnt <= 2.5) => 
map(

         ( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 796875) => 
0.0137219176
, 

         (v1_rescurrmortgageamount > 796875) => 
0.1644584252
, 

0.0143844957
)
, 

      (v1_hhcnt > 2.5) => 
0.0025154166
, 

0.0073598869
)
, 

0.0044558535
)
, 

0.0002602708
)
;


// Tree: 483

b3_tree_483 := 
map(

( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
-0.0003843345
, 

(v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 747260) => 
map(

      ( NULL < v1_hhpropcurrownedcnt and v1_hhpropcurrownedcnt <= 2.5) => 
map(

         ( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 779811) => 
map(

            ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 757500) => 
0.0084329555
, 

            (v1_resinputavmvalue60mo > 757500) => 
-0.0795408848
, 

0.0078289207
)
, 

         (v1_rescurravmvalue12mo > 779811) => 
map(

            ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 0.5) => 
0.2370811902
, 

            (v1_raacrtrecmmbrcnt > 0.5) => 
0.0410897429
, 

0.1114456471
)
, 

0.0084628610
)
, 

      (v1_hhpropcurrownedcnt > 2.5) => 
-0.0087212012
, 

0.0051886152
)
, 

   (v1_raapropowneravmmed > 747260) => 
0.0662189142
, 

0.0060105078
)
, 

0.0000276591
)
;


// Tree: 487

b3_tree_487 := 
map(

( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 36050) => 
map(

   ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 10825) => 
map(

      ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
0.0000769737
, 

      (v1_hhseniormmbrcnt > 0.5) => 
map(

         ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 0.5) => 
0.0308432671
, 

         (v1_raacrtrecmmbrcnt > 0.5) => 
0.0055832173
, 

0.0105825478
)
, 

0.0006134007
)
, 

   (v1_hhpropcurravmhighest > 10825) => 
map(

      ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 69893) => 
-0.0134522585
, 

      (v1_hhpropcurravmhighest > 69893) => 
-0.0018600092
, 

-0.0037038648
)
, 

-0.0001874784
)
, 

(v1_resinputmortgageamount > 36050) => 
map(

   ( NULL < v1_proptimelastsale and v1_proptimelastsale <= 211.5) => 
0.0066766117
, 

   (v1_proptimelastsale > 211.5) => 
0.0888156834
, 

0.0075637974
)
, 

0.0002787793
)
;


// Tree: 491

b3_tree_491 := 
map(

( NULL < v1_proptimelastsale and v1_proptimelastsale <= 235.5) => 
map(

   ( NULL < v1_donotmail and v1_donotmail <= 0.5) => 
-0.0002801660
, 

   (v1_donotmail > 0.5) => 
map(

      ( NULL < v1_raacollegeattendedmmbrcnt and v1_raacollegeattendedmmbrcnt <= 0.5) => 
0.0718710342
, 

      (v1_raacollegeattendedmmbrcnt > 0.5) => 
0.0050955372
, 

0.0309441167
)
, 

-0.0002098035
)
, 

(v1_proptimelastsale > 235.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 251) => 
0.0149166728
, 

   (v1_prospecttimeonrecord > 251) => 
map(

      ( NULL < v1_raacollegemidtiermmbrcnt and v1_raacollegemidtiermmbrcnt <= 0.5) => 
map(

         ( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 20000) => 
0.0144081067
, 

         (v1_resinputmortgageamount > 20000) => 
0.2548650042
, 

0.0807410440
)
, 

      (v1_raacollegemidtiermmbrcnt > 0.5) => 
0.2810290291
, 

0.1281776720
)
, 

0.0616983899
)
, 

-0.0001638353
)
;


// Tree: 495

b3_tree_495 := 
map(

( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
-0.0007507364
, 

(v1_raacollege4yrattendedmmbrcnt > 0.5) => 
map(

   ( NULL < v1_raacrtrecevictionmmbrcnt12mo and v1_raacrtrecevictionmmbrcnt12mo <= 3.5) => 
map(

      ( NULL < v1_lifeevtimelastassetpurchase and v1_lifeevtimelastassetpurchase <= 238.5) => 
0.0022585419
, 

      (v1_lifeevtimelastassetpurchase > 238.5) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 276988) => 
0.0123721953
, 

         (v1_raapropowneravmmed > 276988) => 
map(

            ( NULL < v1_raahhcnt and v1_raahhcnt <= 11.5) => 
map(

               ( NULL < v1_hhcnt and v1_hhcnt <= 4.5) => 
0.2195410841
, 

               (v1_hhcnt > 4.5) => 
0.0085560961
, 

0.1645015220
)
, 

            (v1_raahhcnt > 11.5) => 
-0.0352251283
, 

0.1231787668
)
, 

0.0478140031
)
, 

0.0024810350
)
, 

   (v1_raacrtrecevictionmmbrcnt12mo > 3.5) => 
0.0970135645
, 

0.0026183260
)
, 

0.0000075351
)
;


// Tree: 499

b3_tree_499 := 
map(

( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 83359) => 
map(

   ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
0.0004720560
, 

   (v1_verifiedcurrresmatchindex > 0.5) => 
map(

      ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
-0.0137204169
, 

      (v1_hhcnt > 1.5) => 
-0.0019760782
, 

-0.0044461733
)
, 

-0.0005829261
)
, 

(v1_propcurrownedassessedttl > 83359) => 
map(

   ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 1.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 99.5) => 
0.0038984021
, 

      (v1_crtrectimenewest > 99.5) => 
0.0251739158
, 

0.0063224405
)
, 

   (v1_raacrtrecevictionmmbrcnt > 1.5) => 
map(

      ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 63177.5) => 
-0.0121801392
, 

      (v1_crtreclienjudgamtttl > 63177.5) => 
0.0874177375
, 

-0.0102999486
)
, 

0.0041385689
)
, 

-0.0000298075
)
;


// Tree: 503

b3_tree_503 := 
map(

( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 327.5) => 
map(

      ( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 3.5) => 
-0.0017851750
, 

      (v1_occproflicensecategory > 3.5) => 
0.0469198367
, 

-0.0016469009
)
, 

   (v1_crtrecfelonytimenewest > 327.5) => 
0.1605924604
, 

-0.0015621263
)
, 

(v1_raaoccbusinessassocmmbrcnt > 0.5) => 
map(

   ( NULL < v1_raahhcnt and v1_raahhcnt <= 0.5) => 
map(

      ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.215) => 
map(

         ( NULL < v1_hhcollegetiermmbrhighest and v1_hhcollegetiermmbrhighest <= 0.5) => 
0.0464577721
, 

         (v1_hhcollegetiermmbrhighest > 0.5) => 
-0.0732988356
, 

0.0400957023
)
, 

      (v1_resinputavmratiodiff12mo > 1.215) => 
-0.0634066166
, 

0.0316768534
)
, 

   (v1_raahhcnt > 0.5) => 
0.0016854005
, 

0.0020097885
)
, 

-0.0001694768
)
;


// Tree: 507

b3_tree_507 := 
map(

( NULL < v1_raaseniormmbrcnt and v1_raaseniormmbrcnt <= 4.5) => 
map(

   ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 6.5) => 
map(

      ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 9.5) => 
0.0003861048
, 

      (v1_raacrtrecmsdmeanmmbrcnt > 9.5) => 
0.0111892352
, 

0.0006706574
)
, 

   (v1_raacrtreclienjudgmmbrcnt > 6.5) => 
map(

      ( NULL < v1_rescurravmtractratio and v1_rescurravmtractratio <= 0.995) => 
-0.0030392155
, 

      (v1_rescurravmtractratio > 0.995) => 
map(

         ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 628769.5) => 
-0.0222155961
, 

         (v1_hhpropcurravmhighest > 628769.5) => 
map(

            ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 95.5) => 
0.2407897754
, 

            (v1_lifeevtimelastmove > 95.5) => 
0.0192506439
, 

0.0883018018
)
, 

-0.0193072435
)
, 

-0.0060830990
)
, 

0.0002406174
)
, 

(v1_raaseniormmbrcnt > 4.5) => 
0.0166226088
, 

0.0003867175
)
;


// Tree: 511

b3_tree_511 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 59.5) => 
map(

   ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 318.5) => 
0.0010694222
, 

   (v1_lifeevtimelastmove > 318.5) => 
map(

      ( NULL < v1_lifeevtimelastassetpurchase and v1_lifeevtimelastassetpurchase <= 8.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 26.5) => 
-0.0527906495
, 

         (v1_prospecttimeonrecord > 26.5) => 
0.0172055603
, 

0.0157151365
)
, 

      (v1_lifeevtimelastassetpurchase > 8.5) => 
map(

         ( NULL < v1_ppcurrowner and v1_ppcurrowner <= 0.5) => 
-0.0124224470
, 

         (v1_ppcurrowner > 0.5) => 
0.0369126703
, 

-0.0061273233
)
, 

0.0094088675
)
, 

0.0013543603
)
, 

(v1_prospecttimelastupdate > 59.5) => 
map(

   ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= 312.5) => 
-0.0031399875
, 

   (v1_lifeevtimefirstassetpurchase > 312.5) => 
-0.0776909327
, 

-0.0033705667
)
, 

0.0007193846
)
;


// Tree: 515

b3_tree_515 := 
map(

( NULL < v1_raacollegetoptiermmbrcnt and v1_raacollegetoptiermmbrcnt <= 0.5) => 
0.0002503165
, 

(v1_raacollegetoptiermmbrcnt > 0.5) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 136.5) => 
map(

      ( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 5.535) => 
0.0037421090
, 

      (v1_resinputavmratiodiff60mo > 5.535) => 
0.2277322873
, 

0.0039651909
)
, 

   (v1_crtrectimenewest > 136.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 224.5) => 
map(

         ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 2214) => 
map(

            ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 13529) => 
0.0554249962
, 

            (v1_hhcrtreclienjudgamtttl > 13529) => 
0.2912817526
, 

0.0630685022
)
, 

         (v1_crtreclienjudgamtttl > 2214) => 
-0.0238223726
, 

0.0499722367
)
, 

      (v1_crtrectimenewest > 224.5) => 
-0.0074889749
, 

0.0369313943
)
, 

0.0061280228
)
, 

0.0006071478
)
;


// Tree: 519

b3_tree_519 := 
map(

( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 50.5) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 5.5) => 
map(

      ( NULL < v1_donotmail and v1_donotmail <= 0.5) => 
map(

         ( NULL < v1_proptimelastsale and v1_proptimelastsale <= 213.5) => 
-0.0000125513
, 

         (v1_proptimelastsale > 213.5) => 
0.0342307579
, 

0.0000685475
)
, 

      (v1_donotmail > 0.5) => 
0.0344721557
, 

0.0001486365
)
, 

   (v1_hhcnt > 5.5) => 
map(

      ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 1285129.5) => 
map(

         ( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 9.5) => 
-0.0055526158
, 

         (v1_raaoccbusinessassocmmbrcnt > 9.5) => 
0.0410162113
, 

-0.0047551429
)
, 

      (v1_propcurrownedavmttl > 1285129.5) => 
-0.0859069771
, 

-0.0054770240
)
, 

-0.0002675088
)
, 

(v1_raacrtrecmsdmeanmmbrcnt > 50.5) => 
0.0822040369
, 

-0.0002372232
)
;


// Tree: 523

b3_tree_523 := 
map(

( NULL < v1_hhcrtreclienjudgmmbrcnt and v1_hhcrtreclienjudgmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
-0.0002664181
, 

   (v1_lifeeveverresidedcnt > 1.5) => 
map(

      ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 166286.5) => 
-0.0012834670
, 

      (v1_raapropowneravmhighest > 166286.5) => 
0.0099318272
, 

0.0054808460
)
, 

0.0006217311
)
, 

(v1_hhcrtreclienjudgmmbrcnt > 0.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 140004.5) => 
map(

      ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 383065.5) => 
0.0002429525
, 

      (v1_resinputavmvalue > 383065.5) => 
-0.0490131951
, 

-0.0006134275
)
, 

   (v1_raapropowneravmmed > 140004.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 6.5) => 
-0.0216816770
, 

      (v1_raammbrcnt > 6.5) => 
-0.0066554984
, 

-0.0098069849
)
, 

-0.0039299496
)
, 

-0.0002194713
)
;


// Tree: 527

b3_tree_527 := 
map(

( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 573818) => 
-0.0001271095
, 

(v1_raapropowneravmmed > 573818) => 
map(

   ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 0.5) => 
map(

      ( NULL < v1_rescurravmvalue and v1_rescurravmvalue <= 417925.5) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
-0.0138854795
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
map(

            ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 2.5) => 
0.0243307258
, 

            (v1_resinputbusinesscnt > 2.5) => 
0.1839800431
, 

0.0480500529
)
, 

-0.0083723980
)
, 

      (v1_rescurravmvalue > 417925.5) => 
0.1138552956
, 

-0.0056967669
)
, 

   (v1_rescurrownershipindex > 0.5) => 
map(

      ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 1.275) => 
0.0289380035
, 

      (v1_rescurravmcntyratio > 1.275) => 
-0.0026790451
, 

0.0171795970
)
, 

0.0090268503
)
, 

0.0000812340
)
;


// Tree: 531

b3_tree_531 := 
map(

( NULL < v1_hhcrtrecmmbrcnt12mo and v1_hhcrtrecmmbrcnt12mo <= 0.5) => 
map(

   ( NULL < v1_hhoccbusinessassocmmbrcnt and v1_hhoccbusinessassocmmbrcnt <= 1.5) => 
-0.0009189937
, 

   (v1_hhoccbusinessassocmmbrcnt > 1.5) => 
map(

      ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 3.5) => 
map(

         ( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 2.5) => 
map(

            ( NULL < v1_hhinterestsportpersonmmbrcnt and v1_hhinterestsportpersonmmbrcnt <= 0.5) => 
0.0211863271
, 

            (v1_hhinterestsportpersonmmbrcnt > 0.5) => 
0.0727459941
, 

0.0264767973
)
, 

         (v1_rescurrbusinesscnt > 2.5) => 
0.0019679744
, 

0.0174543185
)
, 

      (v1_raacrtreclienjudgmmbrcnt > 3.5) => 
-0.0173399565
, 

0.0104710143
)
, 

-0.0006932468
)
, 

(v1_hhcrtrecmmbrcnt12mo > 0.5) => 
map(

   ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
0.0139747795
, 

   (v1_verifiedcurrresmatchindex > 0.5) => 
-0.0019356632
, 

0.0061938116
)
, 

-0.0001920672
)
;


// Tree: 535

b3_tree_535 := 
map(

( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 7.5) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 30.5) => 
map(

      ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 2.5) => 
map(

         ( NULL < v1_hhcrtrecevictionmmbrcnt12mo and v1_hhcrtrecevictionmmbrcnt12mo <= 1.5) => 
map(

            ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 176.5) => 
-0.0003936820
, 

            (v1_prospecttimeonrecord > 176.5) => 
0.0046134743
, 

0.0004225580
)
, 

         (v1_hhcrtrecevictionmmbrcnt12mo > 1.5) => 
0.0884093923
, 

0.0004709943
)
, 

      (v1_raacrtreclienjudgmmbrcnt > 2.5) => 
-0.0036290687
, 

-0.0004959384
)
, 

   (v1_raammbrcnt > 30.5) => 
map(

      ( NULL < v1_lifeevtimelastassetpurchase and v1_lifeevtimelastassetpurchase <= 212.5) => 
0.0085441598
, 

      (v1_lifeevtimelastassetpurchase > 212.5) => 
-0.0791089849
, 

0.0076678620
)
, 

-0.0002485794
)
, 

(v1_raacollege4yrattendedmmbrcnt > 7.5) => 
-0.0451136007
, 

-0.0002864190
)
;


// Tree: 539

b3_tree_539 := 
map(

( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 733.5) => 
map(

   ( NULL < v1_raacollegemidtiermmbrcnt and v1_raacollegemidtiermmbrcnt <= 4.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 183.5) => 
0.0000704871
, 

      (v1_raammbrcnt > 183.5) => 
0.2122870437
, 

0.0000799376
)
, 

   (v1_raacollegemidtiermmbrcnt > 4.5) => 
map(

      ( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 1.135) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 387579.5) => 
0.0351544540
, 

         (v1_raapropowneravmmed > 387579.5) => 
0.2064449415
, 

0.0418241721
)
, 

      (v1_rescurravmblockratio > 1.135) => 
-0.0387722739
, 

0.0282925154
)
, 

0.0001572769
)
, 

(v1_lifeevtimelastmove > 733.5) => 
map(

   ( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.175) => 
-0.0890600108
, 

   (v1_rescurravmratiodiff12mo > 1.175) => 
0.1381715237
, 

-0.0687714809
)
, 

0.0001261232
)
;


// Tree: 543

b3_tree_543 := 
map(

( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 16.5) => 
map(

   ( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 25.5) => 
0.0004915068
, 

   (v1_raaoccbusinessassocmmbrcnt > 25.5) => 
map(

      ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 11.5) => 
0.2233616726
, 

      (v1_raacrtrecmsdmeanmmbrcnt > 11.5) => 
0.0277490213
, 

0.0844483405
)
, 

0.0005149823
)
, 

(v1_raacrtreclienjudgmmbrcnt > 16.5) => 
map(

   ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 388513.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 130.5) => 
-0.0364715658
, 

      (v1_crtrecbkrpttimenewest > 130.5) => 
map(

         ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 6.5) => 
0.1686237789
, 

         (v1_raacrtrecmsdmeanmmbrcnt > 6.5) => 
-0.0016202917
, 

0.0453435899
)
, 

-0.0293034705
)
, 

   (v1_resinputavmvalue60mo > 388513.5) => 
0.0988512900
, 

-0.0241029875
)
, 

0.0004121607
)
;


// Tree: 547

b3_tree_547 := 
map(

( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 28.5) => 
map(

   ( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.315) => 
0.0008830280
, 

   (v1_rescurravmratiodiff12mo > 1.315) => 
map(

      ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 644045) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
-0.0127298924
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
map(

            ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 0.965) => 
0.0193169204
, 

            (v1_resinputavmtractratio > 0.965) => 
-0.0122503010
, 

0.0046284990
)
, 

-0.0082663060
)
, 

      (v1_resinputavmvalue > 644045) => 
0.0340271482
, 

-0.0065078211
)
, 

0.0006161297
)
, 

(v1_raaoccproflicmmbrcnt > 28.5) => 
map(

   ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 43.5) => 
0.2543368699
, 

   (v1_raacrtrecmmbrcnt > 43.5) => 
0.0112184535
, 

0.1198458311
)
, 

0.0006387435
)
;


// Tree: 551

b3_tree_551 := 
map(

( NULL < v1_raacrtrecmmbrcnt12mo and v1_raacrtrecmmbrcnt12mo <= 17.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 49.5) => 
0.0003244495
, 

   (v1_prospecttimelastupdate > 49.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 237.5) => 
map(

         ( NULL < v1_donotmail and v1_donotmail <= 0.5) => 
-0.0066845413
, 

         (v1_donotmail > 0.5) => 
map(

            ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
0.2531986886
, 

            (v1_hhcnt > 1.5) => 
0.0469349264
, 

0.0829111640
)
, 

-0.0064256638
)
, 

      (v1_lifeevtimelastmove > 237.5) => 
map(

         ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 104532) => 
0.0013459793
, 

         (v1_raacrtreclienjudgamtmax > 104532) => 
0.0428308616
, 

0.0025181521
)
, 

-0.0039216896
)
, 

-0.0003840144
)
, 

(v1_raacrtrecmmbrcnt12mo > 17.5) => 
0.1016327227
, 

-0.0003621952
)
;


// Tree: 555

b3_tree_555 := 
map(

( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 4.5) => 
map(

   ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 339123) => 
map(

      ( NULL < v1_hhcrtrecevictionmmbrcnt and v1_hhcrtrecevictionmmbrcnt <= 1.5) => 
-0.0001624172
, 

      (v1_hhcrtrecevictionmmbrcnt > 1.5) => 
map(

         ( NULL < v1_raacollegeprivatemmbrcnt and v1_raacollegeprivatemmbrcnt <= 0.5) => 
0.0104673795
, 

         (v1_raacollegeprivatemmbrcnt > 0.5) => 
0.0675759995
, 

0.0142219993
)
, 

-0.0000061080
)
, 

   (v1_raacrtreclienjudgamtmax > 339123) => 
map(

      ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 358099) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 7.5) => 
-0.0822618040
, 

         (v1_raammbrcnt > 7.5) => 
0.1310338380
, 

0.0924864328
)
, 

      (v1_raacrtreclienjudgamtmax > 358099) => 
0.0138087471
, 

0.0185511203
)
, 

0.0000970422
)
, 

(v1_hhcollegeattendedmmbrcnt > 4.5) => 
-0.0820030765
, 

0.0000721939
)
;


// Tree: 559

b3_tree_559 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 240.5) => 
map(

   ( NULL < v1_propeversoldcnt and v1_propeversoldcnt <= 0.5) => 
-0.0003045669
, 

   (v1_propeversoldcnt > 0.5) => 
map(

      ( NULL < v1_lifeevtimelastassetpurchase and v1_lifeevtimelastassetpurchase <= 82.5) => 
-0.0000218013
, 

      (v1_lifeevtimelastassetpurchase > 82.5) => 
0.0159209902
, 

0.0067348918
)
, 

0.0000106268
)
, 

(v1_prospecttimelastupdate > 240.5) => 
map(

   ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 10.5) => 
0.0315693943
, 

      (v1_raacrtrecmmbrcnt > 10.5) => 
0.2329950946
, 

0.0337282979
)
, 

   (v1_raacrtrecevictionmmbrcnt > 0.5) => 
map(

      ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 352833) => 
-0.0296747392
, 

      (v1_raapropowneravmmed > 352833) => 
0.1158155413
, 

-0.0188976814
)
, 

0.0193422241
)
, 

0.0001107938
)
;


// Tree: 563

b3_tree_563 := 
map(

( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 17.5) => 
map(

   ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 4.5) => 
-0.0009725752
, 

   (v1_raayoungadultmmbrcnt > 4.5) => 
map(

      ( NULL < v1_raahhcnt and v1_raahhcnt <= 7.5) => 
map(

         ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 182.5) => 
map(

            ( NULL < v1_raacollegeprivatemmbrcnt and v1_raacollegeprivatemmbrcnt <= 2.5) => 
0.0189831615
, 

            (v1_raacollegeprivatemmbrcnt > 2.5) => 
0.1959056365
, 

0.0210733849
)
, 

         (v1_crtrecmsdmeantimenewest > 182.5) => 
0.2511519861
, 

0.0247041934
)
, 

      (v1_raahhcnt > 7.5) => 
0.0045363609
, 

0.0066630092
)
, 

-0.0006196900
)
, 

(v1_raacrtreclienjudgmmbrcnt > 17.5) => 
map(

   ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 35544.5) => 
-0.0523211896
, 

   (v1_raacrtreclienjudgamtmax > 35544.5) => 
0.0030068446
, 

-0.0274754906
)
, 

-0.0007005379
)
;


// Tree: 567

b3_tree_567 := 
map(

( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 2.5) => 
map(

   ( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhoccbusinessassocmmbrcnt and v1_hhoccbusinessassocmmbrcnt <= 0.5) => 
-0.0007053676
, 

      (v1_hhoccbusinessassocmmbrcnt > 0.5) => 
0.0054234375
, 

-0.0001386189
)
, 

   (v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
map(

      ( NULL < v1_hhppcurrownedcnt and v1_hhppcurrownedcnt <= 1.5) => 
0.0071977816
, 

      (v1_hhppcurrownedcnt > 1.5) => 
-0.0692105941
, 

0.0060342588
)
, 

0.0002437005
)
, 

(v1_resinputbusinesscnt > 2.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 1209782) => 
map(

      ( NULL < v1_hhcrtrecmmbrcnt12mo and v1_hhcrtrecmmbrcnt12mo <= 1.5) => 
-0.0036167658
, 

      (v1_hhcrtrecmmbrcnt12mo > 1.5) => 
-0.0468913434
, 

-0.0040031312
)
, 

   (v1_raapropowneravmmed > 1209782) => 
-0.0742997760
, 

-0.0042848329
)
, 

-0.0002351321
)
;


// Tree: 571

b3_tree_571 := 
map(

( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 17.5) => 
map(

   ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 19.5) => 
0.0001367699
, 

   (v1_raacrtrecmsdmeanmmbrcnt > 19.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 105.5) => 
map(

         ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 12.5) => 
0.0061893896
, 

         (v1_crtrecmsdmeantimenewest > 12.5) => 
0.0581429327
, 

0.0360164731
)
, 

      (v1_lifeevtimelastmove > 105.5) => 
map(

         ( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 1.5) => 
map(

            ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 3992) => 
-0.0111214939
, 

            (v1_hhcrtreclienjudgamtttl > 3992) => 
-0.1039001182
, 

-0.0327374561
)
, 

         (v1_rescurrbusinesscnt > 1.5) => 
0.0553329148
, 

-0.0137489778
)
, 

0.0198485114
)
, 

0.0002563776
)
, 

(v1_raacrtreclienjudgmmbrcnt > 17.5) => 
-0.0243163067
, 

0.0001806181
)
;


// Tree: 575

b3_tree_575 := 
map(

( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 3.055) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 68.5) => 
0.0001023967
, 

   (v1_crtrecbkrpttimenewest > 68.5) => 
map(

      ( NULL < v1_crtreclienjudgcnt and v1_crtreclienjudgcnt <= 13.5) => 
map(

         ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 7.5) => 
0.0063041603
, 

         (v1_raacrtrecevictionmmbrcnt > 7.5) => 
map(

            ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= 134) => 
map(

               ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 1.5) => 
0.0513459048
, 

               (v1_hhpropcurrownermmbrcnt > 1.5) => 
0.1987956771
, 

0.0672864207
)
, 

            (v1_lifeevtimefirstassetpurchase > 134) => 
-0.0956657440
, 

0.0502027261
)
, 

0.0073745412
)
, 

      (v1_crtreclienjudgcnt > 13.5) => 
-0.0610780570
, 

0.0065631921
)
, 

0.0003712602
)
, 

(v1_rescurravmratiodiff12mo > 3.055) => 
-0.0323661231
, 

0.0003100933
)
;


// Tree: 579

b3_tree_579 := 
map(

( NULL < v1_raacollegetoptiermmbrcnt and v1_raacollegetoptiermmbrcnt <= 0.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 83.5) => 
0.0005558142
, 

   (v1_prospecttimelastupdate > 83.5) => 
-0.0044382531
, 

0.0001193353
)
, 

(v1_raacollegetoptiermmbrcnt > 0.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 678204.5) => 
0.0047536810
, 

   (v1_raapropowneravmmed > 678204.5) => 
map(

      ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 1789191.5) => 
map(

         ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 4950) => 
map(

            ( NULL < v1_rescurravmvalue and v1_rescurravmvalue <= 1595591.5) => 
0.0522526112
, 

            (v1_rescurravmvalue > 1595591.5) => 
-0.0959362190
, 

0.0462605279
)
, 

         (v1_hhcrtreclienjudgamtttl > 4950) => 
-0.0664858067
, 

0.0398131569
)
, 

      (v1_raapropowneravmmed > 1789191.5) => 
-0.1425640796
, 

0.0353776590
)
, 

0.0061819009
)
, 

0.0004860192
)
;


// Tree: 583

b3_tree_583 := 
map(

( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 2.215) => 
map(

   ( NULL < v1_rescurravmtractratio and v1_rescurravmtractratio <= 1.965) => 
map(

      ( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 85414.5) => 
-0.0005024004
, 

      (v1_resinputmortgageamount > 85414.5) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 169107) => 
-0.0026831563
, 

         (v1_raapropowneravmmed > 169107) => 
0.0132124316
, 

0.0060940007
)
, 

-0.0001657962
)
, 

   (v1_rescurravmtractratio > 1.965) => 
map(

      ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 62035.5) => 
map(

         ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 112728.5) => 
0.0203055376
, 

         (v1_hhcrtreclienjudgamtttl > 112728.5) => 
0.1482955313
, 

0.0217458342
)
, 

      (v1_raacrtreclienjudgamtmax > 62035.5) => 
-0.0643728194
, 

0.0154952868
)
, 

-0.0000299670
)
, 

(v1_resinputavmtractratio > 2.215) => 
-0.0119621640
, 

-0.0002587841
)
;


// Tree: 587

b3_tree_587 := 
map(

( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
map(

   ( NULL < v1_crtreclienjudgcnt and v1_crtreclienjudgcnt <= 2.5) => 
map(

      ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.885) => 
map(

         ( NULL < v1_hhcrtreclienjudgmmbrcnt and v1_hhcrtreclienjudgmmbrcnt <= 2.5) => 
-0.0006883769
, 

         (v1_hhcrtreclienjudgmmbrcnt > 2.5) => 
-0.0237221229
, 

-0.0008412664
)
, 

      (v1_resinputavmcntyratio > 1.885) => 
-0.0130875135
, 

-0.0012625670
)
, 

   (v1_crtreclienjudgcnt > 2.5) => 
map(

      ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 75090) => 
map(

         ( NULL < v1_raacollegeattendedmmbrcnt and v1_raacollegeattendedmmbrcnt <= 1.5) => 
0.0247146921
, 

         (v1_raacollegeattendedmmbrcnt > 1.5) => 
0.0800971604
, 

0.0370124837
)
, 

      (v1_raapropowneravmmed > 75090) => 
0.0003207512
, 

0.0176577275
)
, 

-0.0009908855
)
, 

(v1_lifeeveverresidedcnt > 1.5) => 
0.0024277263
, 

-0.0002277803
)
;


// Tree: 591

b3_tree_591 := 
map(

( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 85910) => 
map(

   ( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 12805) => 
map(

      ( NULL < v1_occproflicense and v1_occproflicense <= 0.5) => 
map(

         ( NULL < v1_raacollege2yrattendedmmbrcnt and v1_raacollege2yrattendedmmbrcnt <= 6.5) => 
-0.0002023082
, 

         (v1_raacollege2yrattendedmmbrcnt > 6.5) => 
0.0899352603
, 

-0.0001643025
)
, 

      (v1_occproflicense > 0.5) => 
0.0131799504
, 

0.0001316458
)
, 

   (v1_rescurravmvalue12mo > 12805) => 
map(

      ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 95831.5) => 
map(

         ( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 59871.5) => 
-0.0157390168
, 

         (v1_rescurravmvalue60mo > 59871.5) => 
-0.0001728549
, 

-0.0059045769
)
, 

      (v1_resinputavmvalue12mo > 95831.5) => 
-0.0312514262
, 

-0.0078224130
)
, 

-0.0004717580
)
, 

(v1_rescurravmvalue12mo > 85910) => 
0.0028429619
, 

0.0001396896
)
;


// Tree: 595

b3_tree_595 := 
map(

( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 550.5) => 
map(

   ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 1.5) => 
map(

      ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 0.185) => 
map(

         ( NULL < v1_prospectlastupdate12mo and v1_prospectlastupdate12mo <= 0.5) => 
map(

            ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 1226062) => 
0.0034108517
, 

            (v1_raapropowneravmmed > 1226062) => 
0.0881718129
, 

0.0035183995
)
, 

         (v1_prospectlastupdate12mo > 0.5) => 
map(

            ( NULL < v1_lifeevtimelastassetpurchase and v1_lifeevtimelastassetpurchase <= 29.5) => 
0.0222547601
, 

            (v1_lifeevtimelastassetpurchase > 29.5) => 
-0.0070866032
, 

0.0158166665
)
, 

0.0044634625
)
, 

      (v1_resinputavmratiodiff12mo > 0.185) => 
-0.0022030285
, 

0.0018913751
)
, 

   (v1_raacrtrecmmbrcnt > 1.5) => 
-0.0014322569
, 

0.0000779703
)
, 

(v1_crtrecmsdmeantimenewest > 550.5) => 
0.1809452242
, 

0.0000889185
)
;


// Tree: 599

b3_tree_599 := 
map(

(v1_resinputdwelltype in ['0','F','H','P','S']) => 
0.0001710464
, 

(v1_resinputdwelltype in ['-1','G','R','U']) => 
map(

   ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 7286.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 167) => 
map(

         ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 36.5) => 
map(

            ( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 29) => 
0.0281346278
, 

            (v1_crtrecevictiontimenewest > 29) => 
0.2678491588
, 

0.0313779978
)
, 

         (v1_lifeevtimelastmove > 36.5) => 
0.1157466972
, 

0.0371765339
)
, 

      (v1_lifeevtimelastmove > 167) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 225) => 
-0.1078200890
, 

         (v1_prospecttimeonrecord > 225) => 
0.0963023761
, 

-0.0462593456
)
, 

0.0315606574
)
, 

   (v1_raacrtreclienjudgamtmax > 7286.5) => 
-0.0346921733
, 

0.0236452204
)
, 

0.0002717431
)
;


// Tree: 603

b3_tree_603 := 
map(

( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 555) => 
map(

   ( NULL < v1_raacollege2yrattendedmmbrcnt and v1_raacollege2yrattendedmmbrcnt <= 9.5) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 464951.5) => 
-0.0007581087
, 

      (v1_propcurrownedassessedttl > 464951.5) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 101.5) => 
map(

            ( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 4.36) => 
0.0047824349
, 

            (v1_rescurravmblockratio > 4.36) => 
0.2370534600
, 

0.0059481615
)
, 

         (v1_crtrectimenewest > 101.5) => 
map(

            ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 17.5) => 
0.0165909337
, 

            (v1_prospecttimelastupdate > 17.5) => 
0.0905937825
, 

0.0481069717
)
, 

0.0103429124
)
, 

-0.0005986541
)
, 

   (v1_raacollege2yrattendedmmbrcnt > 9.5) => 
0.1518832995
, 

-0.0005875776
)
, 

(v1_crtrecmsdmeantimenewest > 555) => 
0.1810265882
, 

-0.0005780499
)
;


// Tree: 607

b3_tree_607 := 
map(

( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.225) => 
0.0000598039
, 

(v1_rescurravmratiodiff12mo > 1.225) => 
map(

   ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 147730.5) => 
map(

      ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 210557.5) => 
map(

         ( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 222950.5) => 
-0.0134577280
, 

         (v1_rescurravmvalue60mo > 222950.5) => 
map(

            ( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 225912.5) => 
0.2106854671
, 

            (v1_rescurravmvalue60mo > 225912.5) => 
0.0153564320
, 

0.0197813616
)
, 

-0.0093070395
)
, 

      (v1_propcurrownedavmttl > 210557.5) => 
-0.0430150153
, 

-0.0133632605
)
, 

   (v1_raapropowneravmhighest > 147730.5) => 
map(

      ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 160712) => 
0.0383287118
, 

      (v1_raapropowneravmhighest > 160712) => 
-0.0022585305
, 

-0.0004447782
)
, 

-0.0054306725
)
, 

-0.0002631718
)
;


// Tree: 611

b3_tree_611 := 
map(

( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 3836490.5) => 
map(

   ( NULL < v1_donotmail and v1_donotmail <= 0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 18.5) => 
map(

         ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 1.5) => 
map(

            ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
0.0006774515
, 

            (v1_hhseniormmbrcnt > 0.5) => 
0.0077505565
, 

0.0012363526
)
, 

         (v1_raacrtreclienjudgmmbrcnt > 1.5) => 
-0.0030632758
, 

-0.0000438646
)
, 

      (v1_raammbrcnt > 18.5) => 
0.0039481172
, 

0.0004068956
)
, 

   (v1_donotmail > 0.5) => 
map(

      ( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 1.115) => 
0.0373002412
, 

      (v1_resinputavmratiodiff60mo > 1.115) => 
-0.0452311465
, 

0.0278680826
)
, 

0.0004728418
)
, 

(v1_resinputavmvalue12mo > 3836490.5) => 
0.1442817551
, 

0.0004931534
)
;


// Tree: 615

b3_tree_615 := 
map(

( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 41.5) => 
map(

   ( NULL < v1_hhoccbusinessassocmmbrcnt and v1_hhoccbusinessassocmmbrcnt <= 1.5) => 
0.0001513145
, 

   (v1_hhoccbusinessassocmmbrcnt > 1.5) => 
map(

      ( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 0.935) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 47.5) => 
0.0125766272
, 

         (v1_prospecttimelastupdate > 47.5) => 
map(

            ( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 0.905) => 
0.0395047994
, 

            (v1_rescurravmblockratio > 0.905) => 
0.1684082563
, 

0.0456273000
)
, 

0.0225327270
)
, 

      (v1_rescurravmblockratio > 0.935) => 
map(

         ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 2.845) => 
-0.0060785428
, 

         (v1_resinputavmtractratio > 2.845) => 
0.1017599076
, 

-0.0024484157
)
, 

0.0096969566
)
, 

0.0003562339
)
, 

(v1_raaoccbusinessassocmmbrcnt > 41.5) => 
-0.1302493866
, 

0.0003393682
)
;


// Tree: 619

b3_tree_619 := 
map(

( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 106778) => 
-0.0009095119
, 

(v1_resinputavmvalue60mo > 106778) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 1.5) => 
-0.0051184543
, 

   (v1_raammbrcnt > 1.5) => 
map(

      ( NULL < v1_hhcrtrecmmbrcnt12mo and v1_hhcrtrecmmbrcnt12mo <= 3.5) => 
map(

         ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 1.235) => 
map(

            ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 37.5) => 
map(

               ( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 224300) => 
0.0093133155
, 

               (v1_resinputmortgageamount > 224300) => 
0.0602910671
, 

0.0102956365
)
, 

            (v1_lifeevtimelastmove > 37.5) => 
0.0023018550
, 

0.0056892891
)
, 

         (v1_resinputavmblockratio > 1.235) => 
-0.0019026231
, 

0.0039647738
)
, 

      (v1_hhcrtrecmmbrcnt12mo > 3.5) => 
0.2328758516
, 

0.0040123411
)
, 

0.0019928433
)
, 

-0.0001134385
)
;


// Tree: 623

b3_tree_623 := 
map(

( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 459237) => 
map(

   ( NULL < v1_crtrecevictioncnt12mo and v1_crtrecevictioncnt12mo <= 7.5) => 
-0.0007673076
, 

   (v1_crtrecevictioncnt12mo > 7.5) => 
0.2069353165
, 

-0.0007553083
)
, 

(v1_rescurravmvalue12mo > 459237) => 
map(

   ( NULL < v1_lifeevtimelastassetpurchase and v1_lifeevtimelastassetpurchase <= 193.5) => 
map(

      ( NULL < v1_hhcrtrecmsdmeanmmbrcnt and v1_hhcrtrecmsdmeanmmbrcnt <= 1.5) => 
map(

         ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 1414464.5) => 
0.0193489215
, 

         (v1_propcurrownedavmttl > 1414464.5) => 
map(

            ( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 0.5) => 
-0.0642533763
, 

            (v1_raaoccproflicmmbrcnt > 0.5) => 
0.0189224885
, 

-0.0195328464
)
, 

0.0162250733
)
, 

      (v1_hhcrtrecmsdmeanmmbrcnt > 1.5) => 
-0.0274616891
, 

0.0129840152
)
, 

   (v1_lifeevtimelastassetpurchase > 193.5) => 
-0.0367954308
, 

0.0102998740
)
, 

-0.0005112327
)
;


// Tree: 627

b3_tree_627 := 
map(

( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 4837906.5) => 
map(

   ( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 3.5) => 
0.0000056008
, 

   (v1_occproflicensecategory > 3.5) => 
map(

      ( NULL < v1_raacrtrecbkrptmmbrcnt36mo and v1_raacrtrecbkrptmmbrcnt36mo <= 0.5) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 43.5) => 
map(

            ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 160.5) => 
0.0197664935
, 

            (v1_crtrecmsdmeantimenewest > 160.5) => 
-0.1367285197
, 

0.0158613499
)
, 

         (v1_prospecttimelastupdate > 43.5) => 
map(

            ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 117.5) => 
-0.0070645940
, 

            (v1_lifeevtimelastmove > 117.5) => 
0.0921474206
, 

0.0651509540
)
, 

0.0263927043
)
, 

      (v1_raacrtrecbkrptmmbrcnt36mo > 0.5) => 
-0.0507518969
, 

0.0181773052
)
, 

0.0001185410
)
, 

(v1_resinputavmvalue12mo > 4837906.5) => 
0.1419235726
, 

0.0001317026
)
;


// Tree: 631

b3_tree_631 := 
map(

( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
-0.0006822505
, 

(v1_hhyoungadultmmbrcnt > 0.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 193991) => 
map(

      ( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 3.5) => 
map(

         ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 15447.5) => 
-0.0024091644
, 

         (v1_raacrtreclienjudgamtmax > 15447.5) => 
0.0142306949
, 

-0.0000314367
)
, 

      (v1_raaoccbusinessassocmmbrcnt > 3.5) => 
0.0201123002
, 

0.0016311388
)
, 

   (v1_raapropowneravmmed > 193991) => 
map(

      ( NULL < v1_raappcurrownermmbrcnt and v1_raappcurrownermmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 9.5) => 
0.0070815203
, 

         (v1_raacrtreclienjudgmmbrcnt > 9.5) => 
0.0549196618
, 

0.0089113946
)
, 

      (v1_raappcurrownermmbrcnt > 0.5) => 
0.0388340267
, 

0.0125874166
)
, 

0.0046102406
)
, 

0.0000715649
)
;


// Tree: 635

b3_tree_635 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 238.5) => 
-0.0000998125
, 

(v1_prospecttimelastupdate > 238.5) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 10.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 366.5) => 
map(

         ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 29701.5) => 
0.0388031626
, 

         (v1_raacrtreclienjudgamtmax > 29701.5) => 
0.2007119462
, 

0.0426177674
)
, 

      (v1_prospecttimelastupdate > 366.5) => 
map(

         ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 2.5) => 
0.0152243698
, 

         (v1_raamiddleagemmbrcnt > 2.5) => 
-0.0719781561
, 

-0.0092474853
)
, 

0.0297152021
)
, 

   (v1_raammbrcnt > 10.5) => 
map(

      ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 1.56) => 
-0.0372495628
, 

      (v1_rescurravmcntyratio > 1.56) => 
0.1228692883
, 

-0.0248459898
)
, 

0.0178048420
)
, 

-0.0000058109
)
;


// Tree: 639

b3_tree_639 := 
map(

( NULL < v1_propsoldratio and v1_propsoldratio <= 5.735) => 
-0.0003190848
, 

(v1_propsoldratio > 5.735) => 
map(

   ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= 106.5) => 
-0.0517816314
, 

   (v1_lifeevtimefirstassetpurchase > 106.5) => 
map(

      ( NULL < v1_raahhcnt and v1_raahhcnt <= 0.5) => 
0.2582510909
, 

      (v1_raahhcnt > 0.5) => 
map(

         ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 0.935) => 
map(

            ( NULL < v1_proptimelastsale and v1_proptimelastsale <= 45.5) => 
0.1690018101
, 

            (v1_proptimelastsale > 45.5) => 
-0.0242510634
, 

0.0131527186
)
, 

         (v1_rescurravmcntyratio > 0.935) => 
map(

            ( NULL < v1_lifeevtimelastassetpurchase and v1_lifeevtimelastassetpurchase <= 100.5) => 
0.0428528890
, 

            (v1_lifeevtimelastassetpurchase > 100.5) => 
0.1667633311
, 

0.1024252170
)
, 

0.0538735073
)
, 

0.0624608008
)
, 

0.0429559953
)
, 

-0.0002689648
)
;


// Tree: 643

b3_tree_643 := 
map(

( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 2210625) => 
map(

   ( NULL < v1_raacollegelowtiermmbrcnt and v1_raacollegelowtiermmbrcnt <= 0.5) => 
0.0008700919
, 

   (v1_raacollegelowtiermmbrcnt > 0.5) => 
map(

      ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 197412.5) => 
-0.0039216007
, 

      (v1_hhcrtreclienjudgamtttl > 197412.5) => 
map(

         ( NULL < v1_lifeevecontrajectory and v1_lifeevecontrajectory <= 0.5) => 
0.3084154320
, 

         (v1_lifeevecontrajectory > 0.5) => 
map(

            ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 0.845) => 
map(

               ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 1.5) => 
-0.0514951056
, 

               (v1_crtrecbkrptcnt > 1.5) => 
0.1723246262
, 

-0.0147485825
)
, 

            (v1_rescurravmratiodiff60mo > 0.845) => 
0.1538182595
, 

0.0462565603
)
, 

0.0690529840
)
, 

-0.0036223966
)
, 

0.0003612756
)
, 

(v1_rescurravmvalue60mo > 2210625) => 
-0.0555817613
, 

0.0003251547
)
;


// Tree: 647

b3_tree_647 := 
map(

( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 2.535) => 
map(

   ( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 81621) => 
-0.0004545523
, 

   (v1_resinputmortgageamount > 81621) => 
0.0059088837
, 

-0.0001175041
)
, 

(v1_resinputavmratiodiff60mo > 2.535) => 
map(

   ( NULL < v1_rescurravmvalue and v1_rescurravmvalue <= 418276.5) => 
map(

      ( NULL < v1_rescurravmtractratio and v1_rescurravmtractratio <= 1.94) => 
map(

         ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 2.715) => 
-0.0136850875
, 

         (v1_rescurravmratiodiff60mo > 2.715) => 
-0.0779077858
, 

-0.0271466138
)
, 

      (v1_rescurravmtractratio > 1.94) => 
map(

         ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 70440) => 
-0.0185088688
, 

         (v1_propcurrownedavmttl > 70440) => 
0.1459506859
, 

0.0761116969
)
, 

-0.0172283813
)
, 

   (v1_rescurravmvalue > 418276.5) => 
-0.1075613975
, 

-0.0254404737
)
, 

-0.0002029345
)
;


// Tree: 651

b3_tree_651 := 
map(

( NULL < v1_prospectcollegeprivate and v1_prospectcollegeprivate <= 0.5) => 
map(

   ( NULL < v1_raacollege2yrattendedmmbrcnt and v1_raacollege2yrattendedmmbrcnt <= 3.5) => 
-0.0002045236
, 

   (v1_raacollege2yrattendedmmbrcnt > 3.5) => 
map(

      ( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 1.5) => 
0.0527420881
, 

      (v1_raaoccbusinessassocmmbrcnt > 1.5) => 
0.0051109432
, 

0.0190198715
)
, 

-0.0001106111
)
, 

(v1_prospectcollegeprivate > 0.5) => 
map(

   (v1_resinputdwelltype in ['H','P']) => 
-0.0106269732
, 

   (v1_resinputdwelltype in ['-1','0','F','G','R','S','U']) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 12.5) => 
map(

         ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 363402.5) => 
0.0561562586
, 

         (v1_resinputavmvalue12mo > 363402.5) => 
-0.0243614233
, 

0.0463231258
)
, 

      (v1_prospecttimeonrecord > 12.5) => 
0.0130085439
, 

0.0270763606
)
, 

0.0182329013
)
, 

0.0000187833
)
;


// Tree: 655

b3_tree_655 := 
map(

( NULL < v1_hhppcurrownedwtrcrftcnt and v1_hhppcurrownedwtrcrftcnt <= 5.5) => 
map(

   ( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 590750) => 
map(

      ( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 568800) => 
map(

         ( NULL < v1_rescurravmtractratio and v1_rescurravmtractratio <= 2.555) => 
-0.0001641943
, 

         (v1_rescurravmtractratio > 2.555) => 
map(

            ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 2.725) => 
map(

               ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 312596) => 
0.0415145798
, 

               (v1_raapropowneravmhighest > 312596) => 
-0.0198453082
, 

0.0304587441
)
, 

            (v1_rescurravmcntyratio > 2.725) => 
-0.0129641841
, 

0.0156238647
)
, 

-0.0000565097
)
, 

      (v1_resinputmortgageamount > 568800) => 
0.1009441704
, 

-0.0000373094
)
, 

   (v1_resinputmortgageamount > 590750) => 
-0.0321731129
, 

-0.0000933625
)
, 

(v1_hhppcurrownedwtrcrftcnt > 5.5) => 
-0.0581037274
, 

-0.0001247316
)
;


// Tree: 659

b3_tree_659 := 
map(

( NULL < v1_ppcurrownedcnt and v1_ppcurrownedcnt <= 2.5) => 
0.0005642674
, 

(v1_ppcurrownedcnt > 2.5) => 
map(

   ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 7.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 206) => 
map(

         ( NULL < v1_raacrtrecbkrptmmbrcnt36mo and v1_raacrtrecbkrptmmbrcnt36mo <= 0.5) => 
map(

            ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 6740.5) => 
-0.0322367636
, 

            (v1_hhcrtreclienjudgamtttl > 6740.5) => 
0.1633155669
, 

-0.0114333242
)
, 

         (v1_raacrtrecbkrptmmbrcnt36mo > 0.5) => 
0.1402710578
, 

0.0090421139
)
, 

      (v1_lifeevtimelastmove > 206) => 
map(

         ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 8.5) => 
0.0696037587
, 

         (v1_raapropcurrownermmbrcnt > 8.5) => 
0.3657711651
, 

0.0951721678
)
, 

0.0486847546
)
, 

   (v1_raamiddleagemmbrcnt > 7.5) => 
-0.0985564929
, 

0.0353798226
)
, 

0.0006109122
)
;


// Tree: 663

b3_tree_663 := 
map(

( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_raacrtrecmmbrcnt12mo and v1_raacrtrecmmbrcnt12mo <= 19.5) => 
-0.0009002802
, 

   (v1_raacrtrecmmbrcnt12mo > 19.5) => 
0.1332096634
, 

-0.0008824820
)
, 

(v1_hhcollegeattendedmmbrcnt > 0.5) => 
map(

   ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 0.5) => 
0.0091820495
, 

   (v1_rescurrownershipindex > 0.5) => 
map(

      ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 104877) => 
map(

         ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 1.68) => 
map(

            ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 3.705) => 
-0.0042595778
, 

            (v1_rescurravmcntyratio > 3.705) => 
0.0994746984
, 

-0.0038277115
)
, 

         (v1_rescurravmratiodiff60mo > 1.68) => 
-0.0539618339
, 

-0.0044430098
)
, 

      (v1_raapropowneravmmed > 104877) => 
0.0033695496
, 

-0.0002747130
)
, 

0.0030066249
)
, 

-0.0000680584
)
;


// Tree: 667

b3_tree_667 := 
map(

( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 3.5) => 
map(

   ( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 7.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 493.5) => 
-0.0007040273
, 

      (v1_lifeevtimelastmove > 493.5) => 
map(

         ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 80741.5) => 
-0.0302723790
, 

         (v1_resinputavmvalue > 80741.5) => 
0.0071246540
, 

-0.0151765317
)
, 

-0.0008039644
)
, 

   (v1_rescurrbusinesscnt > 7.5) => 
map(

      ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 1206873) => 
-0.0263726043
, 

      (v1_raapropowneravmhighest > 1206873) => 
map(

         ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= 2.5) => 
0.2197310936
, 

         (v1_lifeevtimefirstassetpurchase > 2.5) => 
-0.0063263530
, 

0.0690261292
)
, 

-0.0219525858
)
, 

-0.0009151491
)
, 

(v1_occproflicensecategory > 3.5) => 
0.0197050879
, 

-0.0007919955
)
;


// Tree: 671

b3_tree_671 := 
map(

( NULL < v1_hhcnt and v1_hhcnt <= 23.5) => 
map(

   ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 2.5) => 
0.0000733175
, 

   (v1_resinputbusinesscnt > 2.5) => 
map(

      ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 399034) => 
map(

         ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 4768872) => 
-0.0066679592
, 

         (v1_resinputavmvalue12mo > 4768872) => 
0.1810370001
, 

-0.0065367564
)
, 

      (v1_propcurrownedavmttl > 399034) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 3.5) => 
map(

            ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 5.5) => 
0.0369624995
, 

            (v1_crtrecmsdmeancnt > 5.5) => 
-0.1430881455
, 

0.0340080005
)
, 

         (v1_hhcnt > 3.5) => 
-0.0024774230
, 

0.0174272104
)
, 

-0.0048011510
)
, 

-0.0004425368
)
, 

(v1_hhcnt > 23.5) => 
0.1005054559
, 

-0.0004250198
)
;


// Tree: 675

b3_tree_675 := 
map(

( NULL < v1_assetcurrowner and v1_assetcurrowner <= 0.5) => 
0.0001121345
, 

(v1_assetcurrowner > 0.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 237.5) => 
0.0034831579
, 

   (v1_prospecttimeonrecord > 237.5) => 
map(

      ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 1.765) => 
map(

         ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 0.5) => 
map(

            ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.145) => 
0.0587237929
, 

            (v1_resinputavmratiodiff12mo > 1.145) => 
0.2207913820
, 

0.0739414069
)
, 

         (v1_raacrtrecmsdmeanmmbrcnt > 0.5) => 
0.0101840180
, 

0.0336793880
)
, 

      (v1_resinputavmtractratio > 1.765) => 
map(

         ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 407674.5) => 
0.2513161240
, 

         (v1_resinputavmvalue > 407674.5) => 
-0.0166670600
, 

0.1776207484
)
, 

0.0429959809
)
, 

0.0159481526
)
, 

0.0002373252
)
;


// Tree: 679

b3_tree_679 := 
map(

( NULL < v1_prospectcollegetier and v1_prospectcollegetier <= 0.5) => 
-0.0003468382
, 

(v1_prospectcollegetier > 0.5) => 
map(

   ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 915.5) => 
map(

      ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 175944.5) => 
0.0041796181
, 

      (v1_resinputavmvalue60mo > 175944.5) => 
map(

         ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.505) => 
map(

            ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 338603.5) => 
0.0302384966
, 

            (v1_raapropowneravmmed > 338603.5) => 
-0.0123695044
, 

0.0204948065
)
, 

         (v1_resinputavmratiodiff12mo > 1.505) => 
map(

            ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 0.5) => 
0.0587436332
, 

            (v1_crtrectimenewest > 0.5) => 
0.2881764768
, 

0.1417299809
)
, 

0.0229000632
)
, 

0.0080457793
)
, 

   (v1_crtreclienjudgamtttl > 915.5) => 
-0.0206243938
, 

0.0056038186
)
, 

-0.0000457322
)
;


// Tree: 683

b3_tree_683 := 
map(

( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
-0.0009549910
, 

(v1_hhyoungadultmmbrcnt > 0.5) => 
map(

   ( NULL < v1_raaseniormmbrcnt and v1_raaseniormmbrcnt <= 0.5) => 
map(

      ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 376392) => 
map(

         ( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 455500) => 
-0.0037184357
, 

         (v1_rescurravmvalue60mo > 455500) => 
0.0435819916
, 

-0.0027626581
)
, 

      (v1_raapropowneravmmed > 376392) => 
0.0196453445
, 

-0.0013790279
)
, 

   (v1_raaseniormmbrcnt > 0.5) => 
map(

      ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 0.5) => 
0.0135141912
, 

         (v1_prospectcollegeprogramtype > 0.5) => 
0.0547563300
, 

0.0240127264
)
, 

      (v1_raacrtreclienjudgmmbrcnt > 0.5) => 
0.0034340445
, 

0.0068985066
)
, 

0.0024722928
)
, 

-0.0004611271
)
;


// Tree: 687

b3_tree_687 := 
map(

( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 289991.5) => 
-0.0002634763
, 

(v1_resinputavmvalue60mo > 289991.5) => 
map(

   ( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 10.5) => 
map(

      ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 7.5) => 
0.0061067634
, 

      (v1_raapropcurrownermmbrcnt > 7.5) => 
map(

         ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 170425.5) => 
map(

            ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 16042) => 
map(

               ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 241175) => 
0.0110039371
, 

               (v1_raapropowneravmmed > 241175) => 
-0.0563539909
, 

-0.0391072953
)
, 

            (v1_raacrtreclienjudgamtmax > 16042) => 
0.0080933420
, 

-0.0251885517
)
, 

         (v1_hhpropcurravmhighest > 170425.5) => 
-0.0003809251
, 

-0.0091546760
)
, 

0.0044485634
)
, 

   (v1_raaoccbusinessassocmmbrcnt > 10.5) => 
0.0478465280
, 

0.0049331889
)
, 

0.0002867573
)
;


// Tree: 691

b3_tree_691 := 
map(

( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 52567) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 141051.5) => 
0.0010202781
, 

   (v1_raapropowneravmmed > 141051.5) => 
map(

      ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 4261) => 
-0.0012108511
, 

      (v1_hhcrtreclienjudgamtttl > 4261) => 
-0.0118197545
, 

-0.0023572681
)
, 

0.0000653766
)
, 

(v1_resinputmortgageamount > 52567) => 
map(

   ( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 4.5) => 
map(

      ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 4.565) => 
map(

         ( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 56255) => 
0.0639321162
, 

         (v1_resinputmortgageamount > 56255) => 
0.0058209520
, 

0.0063918687
)
, 

      (v1_resinputavmblockratio > 4.565) => 
0.1206256834
, 

0.0067435049
)
, 

   (v1_raaoccproflicmmbrcnt > 4.5) => 
-0.0426732353
, 

0.0055262109
)
, 

0.0003883275
)
;


// Tree: 695

b3_tree_695 := 
map(

( NULL < v1_raacrtrecfelonymmbrcnt12mo and v1_raacrtrecfelonymmbrcnt12mo <= 0.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 11.5) => 
map(

      ( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 4.59) => 
-0.0006252218
, 

         (v1_rescurravmratiodiff12mo > 4.59) => 
-0.0785762907
, 

-0.0006739074
)
, 

      (v1_raaoccproflicmmbrcnt > 0.5) => 
map(

         ( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 756648) => 
map(

            ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 443621.5) => 
0.0035434498
, 

            (v1_resinputavmvalue > 443621.5) => 
-0.0118129859
, 

0.0025250715
)
, 

         (v1_rescurravmvalue60mo > 756648) => 
0.0315920783
, 

0.0028648743
)
, 

0.0001757274
)
, 

   (v1_lifeeveverresidedcnt > 11.5) => 
-0.1080536548
, 

0.0001491648
)
, 

(v1_raacrtrecfelonymmbrcnt12mo > 0.5) => 
-0.0140632056
, 

-0.0000420510
)
;


// Tree: 699

b3_tree_699 := 
map(

( NULL < v1_raacrtrecfelonymmbrcnt12mo and v1_raacrtrecfelonymmbrcnt12mo <= 0.5) => 
map(

   ( NULL < v1_donotmail and v1_donotmail <= 0.5) => 
0.0001628176
, 

   (v1_donotmail > 0.5) => 
map(

      ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 0.5) => 
0.0662003288
, 

      (v1_resinputbusinesscnt > 0.5) => 
-0.0030638211
, 

0.0290517363
)
, 

0.0002311239
)
, 

(v1_raacrtrecfelonymmbrcnt12mo > 0.5) => 
map(

   ( NULL < v1_raacrtrecmmbrcnt12mo and v1_raacrtrecmmbrcnt12mo <= 17.5) => 
map(

      ( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 184187.5) => 
map(

         ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 148) => 
-0.0163616982
, 

         (v1_occbusinessassociationtime > 148) => 
0.1057483684
, 

-0.0149921703
)
, 

      (v1_rescurrmortgageamount > 184187.5) => 
-0.1469065639
, 

-0.0162594356
)
, 

   (v1_raacrtrecmmbrcnt12mo > 17.5) => 
0.1713874916
, 

-0.0152508824
)
, 

0.0000218890
)
;


// Tree: 703

b3_tree_703 := 
map(

( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 191801) => 
map(

   ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 0.085) => 
0.0008287085
, 

   (v1_resinputavmratiodiff12mo > 0.085) => 
map(

      ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 0.215) => 
-0.0196973095
, 

      (v1_resinputavmcntyratio > 0.215) => 
-0.0014281566
, 

-0.0024233452
)
, 

-0.0005202622
)
, 

(v1_raacrtreclienjudgamtmax > 191801) => 
map(

   ( NULL < v1_lifeevtimelastassetpurchase and v1_lifeevtimelastassetpurchase <= 203.5) => 
map(

      ( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 1.875) => 
map(

         ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 386) => 
0.0167162766
, 

         (v1_occbusinessassociationtime > 386) => 
0.2286174578
, 

0.0175899322
)
, 

      (v1_rescurravmblockratio > 1.875) => 
-0.0677687684
, 

0.0151049627
)
, 

   (v1_lifeevtimelastassetpurchase > 203.5) => 
-0.0788372417
, 

0.0131959768
)
, 

-0.0003650022
)
;


// Tree: 707

b3_tree_707 := 
map(

( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 7772) => 
map(

   ( NULL < v1_lifeevtimelastassetpurchase and v1_lifeevtimelastassetpurchase <= 3.5) => 
map(

      ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 129.5) => 
0.0011175295
, 

         (v1_prospecttimeonrecord > 129.5) => 
0.0088667460
, 

0.0019920392
)
, 

      (v1_raacollege4yrattendedmmbrcnt > 0.5) => 
0.0111608137
, 

0.0027161628
)
, 

   (v1_lifeevtimelastassetpurchase > 3.5) => 
map(

      ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 4.5) => 
-0.0084487485
, 

      (v1_crtrecseverityindex > 4.5) => 
0.1438062048
, 

-0.0076030219
)
, 

0.0021717563
)
, 

(v1_raapropowneravmmed > 7772) => 
map(

   ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 1.5) => 
-0.0068662345
, 

   (v1_raapropcurrownermmbrcnt > 1.5) => 
-0.0003573244
, 

-0.0013481447
)
, 

0.0003483549
)
;


// Tree: 711

b3_tree_711 := 
map(

( NULL < v1_raacrtrecmmbrcnt12mo and v1_raacrtrecmmbrcnt12mo <= 9.5) => 
map(

   ( NULL < v1_hhcrtreclienjudgmmbrcnt12mo and v1_hhcrtreclienjudgmmbrcnt12mo <= 0.5) => 
-0.0000480003
, 

   (v1_hhcrtreclienjudgmmbrcnt12mo > 0.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 227.5) => 
map(

         ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 378563.5) => 
map(

            ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 108.5) => 
0.0018208771
, 

            (v1_lifeevtimelastmove > 108.5) => 
0.0196337766
, 

0.0093703980
)
, 

         (v1_hhcrtreclienjudgamtttl > 378563.5) => 
-0.0719685965
, 

0.0081694815
)
, 

      (v1_crtrectimenewest > 227.5) => 
0.1676784508
, 

0.0091298366
)
, 

0.0001491607
)
, 

(v1_raacrtrecmmbrcnt12mo > 9.5) => 
map(

   ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 141755) => 
0.1024849328
, 

   (v1_raapropowneravmhighest > 141755) => 
0.0136206277
, 

0.0420299324
)
, 

0.0002152427
)
;


// Tree: 715

b3_tree_715 := 
map(

( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 510264) => 
0.0001592370
, 

(v1_raacrtreclienjudgamtmax > 510264) => 
map(

   ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 2907) => 
map(

      ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 0.825) => 
map(

         ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 6.5) => 
map(

            ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 291585) => 
map(

               ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 1303148.5) => 
0.0136475284
, 

               (v1_raacrtreclienjudgamtmax > 1303148.5) => 
-0.0917671621
, 

-0.0176037294
)
, 

            (v1_raapropowneravmhighest > 291585) => 
0.0480263869
, 

0.0157117762
)
, 

         (v1_raacrtrecevictionmmbrcnt > 6.5) => 
0.1976375364
, 

0.0222091248
)
, 

      (v1_rescurravmratiodiff60mo > 0.825) => 
0.0917860196
, 

0.0379346344
)
, 

   (v1_hhcrtreclienjudgamtttl > 2907) => 
-0.0235344707
, 

0.0237790457
)
, 

0.0002353949
)
;


// Tree: 719

b3_tree_719 := 
map(

( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 244.5) => 
0.0000636355
, 

(v1_occbusinessassociationtime > 244.5) => 
map(

   ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 111.5) => 
map(

      ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 2418.5) => 
map(

         ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 1443.5) => 
map(

            ( NULL < v1_raacollegelowtiermmbrcnt and v1_raacollegelowtiermmbrcnt <= 0.5) => 
0.0160947114
, 

            (v1_raacollegelowtiermmbrcnt > 0.5) => 
-0.1040321812
, 

0.0032360581
)
, 

         (v1_raacrtreclienjudgamtmax > 1443.5) => 
0.1433077422
, 

0.0131364127
)
, 

      (v1_raacrtreclienjudgamtmax > 2418.5) => 
-0.0465253647
, 

-0.0100016484
)
, 

   (v1_lifeevtimelastmove > 111.5) => 
map(

      ( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 1.195) => 
0.0188570671
, 

      (v1_rescurravmblockratio > 1.195) => 
0.0692298611
, 

0.0322620585
)
, 

0.0178822586
)
, 

0.0001955113
)
;


// Tree: 723

b3_tree_723 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 99.5) => 
-0.0001177106
, 

(v1_prospecttimelastupdate > 99.5) => 
map(

   ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 418095.5) => 
map(

      ( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 856000) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 132.5) => 
-0.0225338164
, 

         (v1_prospecttimeonrecord > 132.5) => 
-0.0053673216
, 

-0.0083950008
)
, 

      (v1_rescurravmvalue60mo > 856000) => 
map(

         (v1_resinputdwelltype in ['H']) => 
-0.0349586048
, 

         (v1_resinputdwelltype in ['-1','0','F','G','P','R','S','U']) => 
0.1738637276
, 

0.0871827594
)
, 

-0.0080405136
)
, 

   (v1_resinputavmvalue > 418095.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 309.5) => 
0.0042283706
, 

      (v1_lifeevtimelastmove > 309.5) => 
0.0594034327
, 

0.0194513696
)
, 

-0.0065313692
)
, 

-0.0005090462
)
;


// Tree: 727

b3_tree_727 := 
map(

( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 213.5) => 
-0.0002255170
, 

(v1_occbusinessassociationtime > 213.5) => 
map(

   ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 1.265) => 
map(

      ( NULL < v1_raacollegemidtiermmbrcnt and v1_raacollegemidtiermmbrcnt <= 3.5) => 
map(

         ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 1.005) => 
map(

            ( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 2.5) => 
0.0102286972
, 

            (v1_raaoccproflicmmbrcnt > 2.5) => 
-0.0542628011
, 

0.0041838703
)
, 

         (v1_resinputavmtractratio > 1.005) => 
map(

            ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 217.5) => 
0.2139569066
, 

            (v1_occbusinessassociationtime > 217.5) => 
0.0350690127
, 

0.0430922239
)
, 

0.0147680677
)
, 

      (v1_raacollegemidtiermmbrcnt > 3.5) => 
0.1491714225
, 

0.0173882483
)
, 

   (v1_rescurravmratiodiff60mo > 1.265) => 
-0.0699054894
, 

0.0141482504
)
, 

-0.0000895543
)
;


// Tree: 731

b3_tree_731 := 
map(

( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 175) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 5.5) => 
0.0004087962
, 

   (v1_hhcnt > 5.5) => 
map(

      ( NULL < v1_proptimelastsale and v1_proptimelastsale <= 141.5) => 
map(

         ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 432046.5) => 
-0.0047915073
, 

         (v1_propcurrownedassessedttl > 432046.5) => 
map(

            ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= 133.5) => 
map(

               ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= 118.5) => 
0.0444783375
, 

               (v1_lifeevtimefirstassetpurchase > 118.5) => 
0.2482968207
, 

0.0558967399
)
, 

            (v1_lifeevtimefirstassetpurchase > 133.5) => 
-0.0124375682
, 

0.0299154666
)
, 

-0.0036614854
)
, 

      (v1_proptimelastsale > 141.5) => 
-0.0427848964
, 

-0.0047096261
)
, 

0.0000332925
)
, 

(v1_rescurrbusinesscnt > 175) => 
0.1874182300
, 

0.0000506847
)
;


// Tree: 735

b3_tree_735 := 
map(

( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 1.5) => 
map(

   ( NULL < v1_hhoccproflicmmbrcnt and v1_hhoccproflicmmbrcnt <= 0.5) => 
0.0001965904
, 

   (v1_hhoccproflicmmbrcnt > 0.5) => 
map(

      ( NULL < v1_proptimelastsale and v1_proptimelastsale <= 230.5) => 
0.0067322413
, 

      (v1_proptimelastsale > 230.5) => 
0.1150888128
, 

0.0072145175
)
, 

0.0006013305
)
, 

(v1_hhseniormmbrcnt > 1.5) => 
map(

   ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 7.5) => 
map(

      ( NULL < v1_hhcrtrecmsdmeanmmbrcnt and v1_hhcrtrecmsdmeanmmbrcnt <= 2.5) => 
map(

         ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 1.78) => 
0.0111123706
, 

         (v1_rescurravmratiodiff60mo > 1.78) => 
0.1156490219
, 

0.0120942066
)
, 

      (v1_hhcrtrecmsdmeanmmbrcnt > 2.5) => 
0.1030584581
, 

0.0133660873
)
, 

   (v1_crtrecmsdmeantimenewest > 7.5) => 
-0.0188492872
, 

0.0094593242
)
, 

0.0008253505
)
;


// Tree: 739

b3_tree_739 := 
map(

( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 524495.5) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 0) => 
-0.0007485611
, 

   (v1_crtrectimenewest > 0) => 
map(

      ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
map(

         ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 238602) => 
map(

            ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 32.5) => 
0.0121841841
, 

            (v1_crtrectimenewest > 32.5) => 
0.0016273029
, 

0.0052484402
)
, 

         (v1_crtreclienjudgamtttl > 238602) => 
0.1063681195
, 

0.0054410366
)
, 

      (v1_verifiedcurrresmatchindex > 0.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 0.5) => 
0.0263245950
, 

         (v1_raammbrcnt > 0.5) => 
-0.0035066991
, 

-0.0004219814
)
, 

0.0031433330
)
, 

0.0004482408
)
, 

(v1_rescurrmortgageamount > 524495.5) => 
-0.0275113486
, 

0.0003662138
)
;


// Tree: 743

b3_tree_743 := 
map(

( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 600000.5) => 
map(

   ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 501016.5) => 
0.0002167622
, 

   (v1_propcurrownedassessedttl > 501016.5) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 502950) => 
0.2617020385
, 

      (v1_propcurrownedassessedttl > 502950) => 
0.0129070436
, 

0.0140083125
)
, 

0.0003709490
)
, 

(v1_resinputavmvalue60mo > 600000.5) => 
map(

   ( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 12.5) => 
map(

      ( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 1535833) => 
-0.0110383098
, 

      (v1_rescurravmvalue12mo > 1535833) => 
0.0780789713
, 

-0.0099262393
)
, 

   (v1_raaoccproflicmmbrcnt > 12.5) => 
map(

      ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 1325000) => 
0.2705384393
, 

      (v1_raapropowneravmhighest > 1325000) => 
0.0041490665
, 

0.1484433101
)
, 

-0.0092108489
)
, 

0.0001655120
)
;


// Tree: 747

b3_tree_747 := 
map(

( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 1.055) => 
-0.0001181992
, 

(v1_rescurravmratiodiff60mo > 1.055) => 
map(

   ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 0.105) => 
0.1982725212
, 

      (v1_rescurravmcntyratio > 0.105) => 
map(

         ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 608) => 
map(

            ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 55762) => 
-0.0058131210
, 

            (v1_propcurrownedassessedttl > 55762) => 
map(

               ( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 143176) => 
-0.0348522069
, 

               (v1_rescurravmvalue12mo > 143176) => 
-0.0104502840
, 

-0.0205979852
)
, 

-0.0111260533
)
, 

         (v1_lifeevtimelastmove > 608) => 
0.0723302851
, 

-0.0106279957
)
, 

-0.0103563436
)
, 

   (v1_hhyoungadultmmbrcnt > 0.5) => 
0.0070343547
, 

-0.0058702258
)
, 

-0.0004068636
)
;


// Tree: 751

b3_tree_751 := 
map(

( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 2444253.5) => 
map(

   ( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 30939.5) => 
map(

      ( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 1.635) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 33.5) => 
-0.0004546056
, 

         (v1_crtrecbkrpttimenewest > 33.5) => 
0.0065959404
, 

-0.0000965210
)
, 

      (v1_rescurravmblockratio > 1.635) => 
-0.0112898551
, 

-0.0003383625
)
, 

   (v1_resinputmortgageamount > 30939.5) => 
map(

      ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.155) => 
map(

         ( NULL < v1_propeverownedcnt and v1_propeverownedcnt <= 1.5) => 
0.0142456911
, 

         (v1_propeverownedcnt > 1.5) => 
-0.0055380364
, 

0.0094594777
)
, 

      (v1_resinputavmcntyratio > 1.155) => 
-0.0026612583
, 

0.0047065132
)
, 

-0.0000280954
)
, 

(v1_raacrtreclienjudgamtmax > 2444253.5) => 
-0.0612758740
, 

-0.0000614623
)
;


// Tree: 755

b3_tree_755 := 
map(

( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 7.5) => 
map(

   ( NULL < v1_proptimelastsale and v1_proptimelastsale <= 25.5) => 
0.0004812722
, 

   (v1_proptimelastsale > 25.5) => 
map(

      ( NULL < v1_proptimelastsale and v1_proptimelastsale <= 57.5) => 
map(

         ( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 271794) => 
map(

            ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 0.695) => 
0.0476970292
, 

            (v1_rescurravmratiodiff60mo > 0.695) => 
-0.0251592843
, 

0.0282122012
)
, 

         (v1_rescurravmvalue60mo > 271794) => 
0.0903544983
, 

0.0408249566
)
, 

      (v1_proptimelastsale > 57.5) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 125.5) => 
0.0063013999
, 

         (v1_prospecttimelastupdate > 125.5) => 
-0.0501432533
, 

0.0044309605
)
, 

0.0092018415
)
, 

0.0007860857
)
, 

(v1_raacrtreclienjudgmmbrcnt > 7.5) => 
-0.0060593232
, 

0.0004457821
)
;


// Tree: 759

b3_tree_759 := 
map(

( NULL < v1_occbusinesstitleleadership and v1_occbusinesstitleleadership <= 1.5) => 
map(

   ( NULL < v1_hhcrtrecbkrptmmbrcnt12mo and v1_hhcrtrecbkrptmmbrcnt12mo <= 2.5) => 
-0.0002037510
, 

   (v1_hhcrtrecbkrptmmbrcnt12mo > 2.5) => 
0.1644330959
, 

-0.0001934902
)
, 

(v1_occbusinesstitleleadership > 1.5) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 7.5) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 868139) => 
map(

         ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 8.5) => 
0.0221028016
, 

         (v1_resinputbusinesscnt > 8.5) => 
-0.0462229464
, 

0.0187222933
)
, 

      (v1_propcurrownedassessedttl > 868139) => 
map(

         ( NULL < v1_proptimelastsale and v1_proptimelastsale <= 108.5) => 
0.0644120944
, 

         (v1_proptimelastsale > 108.5) => 
0.2872324635
, 

0.1083009550
)
, 

0.0208077225
)
, 

   (v1_raammbrcnt > 7.5) => 
0.0005402820
, 

0.0086023269
)
, 

0.0000594831
)
;


// Tree: 763

b3_tree_763 := 
map(

( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 21983) => 
map(

   (v1_resinputdwelltype in ['-1','F','G','H','P','R','S']) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 63.5) => 
-0.0001420053
, 

      (v1_prospecttimelastupdate > 63.5) => 
map(

         ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 52681) => 
-0.0063207858
, 

         (v1_propcurrownedassessedttl > 52681) => 
0.0039233399
, 

-0.0045735500
)
, 

-0.0006938152
)
, 

   (v1_resinputdwelltype in ['0','U']) => 
0.0789958743
, 

-0.0006352264
)
, 

(v1_resinputmortgageamount > 21983) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 140.5) => 
0.0075064183
, 

   (v1_crtrecbkrpttimenewest > 140.5) => 
map(

      ( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 2.165) => 
-0.0349394066
, 

      (v1_rescurravmblockratio > 2.165) => 
0.1566251734
, 

-0.0288820286
)
, 

0.0062964988
)
, 

-0.0002095392
)
;


// Tree: 767

b3_tree_767 := 
map(

( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 7894736.5) => 
map(

   ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 23.5) => 
0.0000801077
, 

   (v1_raapropcurrownermmbrcnt > 23.5) => 
map(

      ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

         ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 224871.5) => 
0.0293237918
, 

         (v1_raapropowneravmhighest > 224871.5) => 
-0.0639199395
, 

-0.0457619497
)
, 

      (v1_lifeevtimefirstassetpurchase > -0.5) => 
map(

         ( NULL < v1_lifeevtimelastassetpurchase and v1_lifeevtimelastassetpurchase <= 154.5) => 
map(

            ( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 9.5) => 
-0.0298467656
, 

            (v1_raaoccbusinessassocmmbrcnt > 9.5) => 
0.0440779824
, 

0.0154510868
)
, 

         (v1_lifeevtimelastassetpurchase > 154.5) => 
-0.1033064331
, 

0.0046325964
)
, 

-0.0175573544
)
, 

0.0000186779
)
, 

(v1_raapropowneravmhighest > 7894736.5) => 
0.1424814481
, 

0.0000319006
)
;


// Tree: 771

b3_tree_771 := 
map(

( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 297.5) => 
-0.0001331740
, 

(v1_crtrecmsdmeantimenewest > 297.5) => 
map(

   ( NULL < v1_hhcrtreclienjudgmmbrcnt12mo and v1_hhcrtreclienjudgmmbrcnt12mo <= 0.5) => 
map(

      ( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 0.665) => 
map(

         ( NULL < v1_lifeevnamechange and v1_lifeevnamechange <= 0.5) => 
map(

            ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 29001) => 
-0.0299560698
, 

            (v1_raapropowneravmmed > 29001) => 
0.0519447641
, 

0.0232794723
)
, 

         (v1_lifeevnamechange > 0.5) => 
0.1892817629
, 

0.0379885360
)
, 

      (v1_rescurravmblockratio > 0.665) => 
map(

         ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 468445) => 
-0.0250682999
, 

         (v1_propcurrownedassessedttl > 468445) => 
0.2797731677
, 

-0.0136080943
)
, 

0.0172249904
)
, 

   (v1_hhcrtreclienjudgmmbrcnt12mo > 0.5) => 
0.1752655468
, 

0.0227621777
)
, 

-0.0000698848
)
;


// Tree: 775

b3_tree_775 := 
map(

( NULL < v1_rescurravmtractratio and v1_rescurravmtractratio <= 3.285) => 
-0.0002495228
, 

(v1_rescurravmtractratio > 3.285) => 
map(

   ( NULL < v1_raacollege2yrattendedmmbrcnt and v1_raacollege2yrattendedmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 142825) => 
-0.0093409050
, 

      (v1_rescurravmvalue60mo > 142825) => 
map(

         ( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 920251.5) => 
map(

            ( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 0.5) => 
0.0520716265
, 

            (v1_hhcollegeattendedmmbrcnt > 0.5) => 
0.1790899715
, 

0.0911541942
)
, 

         (v1_rescurravmvalue60mo > 920251.5) => 
-0.0604399187
, 

0.0651454003
)
, 

0.0138578832
)
, 

   (v1_raacollege2yrattendedmmbrcnt > 0.5) => 
map(

      ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 50540) => 
-0.0826982438
, 

      (v1_raapropowneravmhighest > 50540) => 
0.1176156568
, 

0.0874799372
)
, 

0.0246902948
)
, 

-0.0001722287
)
;


// Tree: 779

b3_tree_779 := 
map(

( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 5.5) => 
-0.0006784328
, 

(v1_raacrtrecmsdmeanmmbrcnt > 5.5) => 
map(

   ( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 1.005) => 
map(

      ( NULL < v1_hhcollege2yrattendedmmbrcnt and v1_hhcollege2yrattendedmmbrcnt <= 1.5) => 
map(

         ( NULL < v1_raahhcnt and v1_raahhcnt <= 4.5) => 
0.0203542553
, 

         (v1_raahhcnt > 4.5) => 
map(

            ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 1.375) => 
0.0031905911
, 

            (v1_rescurravmcntyratio > 1.375) => 
0.0505670876
, 

0.0038011682
)
, 

0.0058409349
)
, 

      (v1_hhcollege2yrattendedmmbrcnt > 1.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 170) => 
0.0241097106
, 

         (v1_prospecttimeonrecord > 170) => 
0.2456715563
, 

0.1043303788
)
, 

0.0060668996
)
, 

   (v1_rescurravmblockratio > 1.005) => 
-0.0086030188
, 

0.0038284486
)
, 

-0.0001358698
)
;


// Tree: 783

b3_tree_783 := 
map(

( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 0.5) => 
map(

   ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 2214859) => 
-0.0001530561
, 

   (v1_propcurrownedavmttl > 2214859) => 
-0.0645798346
, 

-0.0001950789
)
, 

(v1_occproflicensecategory > 0.5) => 
map(

   ( NULL < v1_raappcurrownermmbrcnt and v1_raappcurrownermmbrcnt <= 0.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 143.5) => 
0.0189922884
, 

      (v1_lifeevtimelastmove > 143.5) => 
0.0020227335
, 

0.0118801988
)
, 

   (v1_raappcurrownermmbrcnt > 0.5) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 684122) => 
-0.0173492260
, 

      (v1_propcurrownedassessedttl > 684122) => 
map(

         ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 821227) => 
0.3629798708
, 

         (v1_propcurrownedassessedttl > 821227) => 
0.0345122984
, 

0.1088823148
)
, 

-0.0115867181
)
, 

0.0087246404
)
, 

0.0001157025
)
;


// Tree: 787

b3_tree_787 := 
map(

( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 2.5) => 
0.0008029302
, 

(v1_hhpropcurrownermmbrcnt > 2.5) => 
map(

   ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 699919) => 
map(

      ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 13042.5) => 
-0.0108374073
, 

      (v1_crtreclienjudgamtttl > 13042.5) => 
0.0342384815
, 

-0.0092738374
)
, 

   (v1_resinputavmvalue60mo > 699919) => 
map(

      ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 693073.5) => 
map(

         ( NULL < v1_hhcrtreclienjudgmmbrcnt and v1_hhcrtreclienjudgmmbrcnt <= 1.5) => 
map(

            ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 823532.5) => 
0.2520975500
, 

            (v1_resinputavmvalue60mo > 823532.5) => 
0.0505504772
, 

0.1628409892
)
, 

         (v1_hhcrtreclienjudgmmbrcnt > 1.5) => 
-0.0662471528
, 

0.1293158952
)
, 

      (v1_propcurrownedavmttl > 693073.5) => 
0.0179204927
, 

0.0600146080
)
, 

-0.0070015701
)
, 

0.0005945301
)
;


// Tree: 791

b3_tree_791 := 
map(

( NULL < v1_raacollegetoptiermmbrcnt and v1_raacollegetoptiermmbrcnt <= 0.5) => 
-0.0004213643
, 

(v1_raacollegetoptiermmbrcnt > 0.5) => 
map(

   ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 150069.5) => 
0.0010407972
, 

   (v1_resinputavmvalue60mo > 150069.5) => 
map(

      ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 2302477) => 
map(

         ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 0.645) => 
0.0531451643
, 

         (v1_resinputavmcntyratio > 0.645) => 
map(

            ( NULL < v1_hhcollegetiermmbrhighest and v1_hhcollegetiermmbrhighest <= 0.5) => 
0.0058222735
, 

            (v1_hhcollegetiermmbrhighest > 0.5) => 
map(

               ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
0.0104672790
, 

               (v1_hhyoungadultmmbrcnt > 0.5) => 
0.0612905448
, 

0.0349960664
)
, 

0.0122390619
)
, 

0.0153532643
)
, 

      (v1_raapropowneravmhighest > 2302477) => 
-0.1110682038
, 

0.0143719542
)
, 

0.0056764240
)
, 

-0.0000475794
)
;


// Tree: 795

b3_tree_795 := 
map(

( NULL < v1_raacollegemidtiermmbrcnt and v1_raacollegemidtiermmbrcnt <= 4.5) => 
map(

   ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 370.5) => 
-0.0001202375
, 

   (v1_lifeevtimelastmove > 370.5) => 
0.0080638782
, 

0.0000759155
)
, 

(v1_raacollegemidtiermmbrcnt > 4.5) => 
map(

   ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 7947.5) => 
map(

      ( NULL < v1_raaseniormmbrcnt and v1_raaseniormmbrcnt <= 0.5) => 
0.1022477917
, 

      (v1_raaseniormmbrcnt > 0.5) => 
map(

         ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 7.5) => 
map(

            ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 3.5) => 
0.0579185108
, 

            (v1_raacrtrecmsdmeanmmbrcnt > 3.5) => 
-0.0487375772
, 

0.0036208660
)
, 

         (v1_raayoungadultmmbrcnt > 7.5) => 
0.1121669108
, 

0.0342969221
)
, 

0.0609020245
)
, 

   (v1_raacrtreclienjudgamtmax > 7947.5) => 
-0.0122192121
, 

0.0285474951
)
, 

0.0001538147
)
;


// Tree: 799

b3_tree_799 := 
map(

( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 4.5) => 
-0.0002211938
, 

(v1_raayoungadultmmbrcnt > 4.5) => 
map(

   ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 5.5) => 
map(

      ( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 144429.5) => 
0.0017957286
, 

      (v1_rescurravmvalue12mo > 144429.5) => 
map(

         ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 85.5) => 
-0.0058338702
, 

         (v1_lifeevtimelastmove > 85.5) => 
map(

            ( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 1.5) => 
0.0600506678
, 

            (v1_raaoccproflicmmbrcnt > 1.5) => 
0.0137129299
, 

0.0362255133
)
, 

0.0224566505
)
, 

0.0049341883
)
, 

   (v1_resinputbusinesscnt > 5.5) => 
map(

      ( NULL < v1_rescurravmvalue and v1_rescurravmvalue <= 333499) => 
0.0623002613
, 

      (v1_rescurravmvalue > 333499) => 
-0.0534751529
, 

0.0459587554
)
, 

0.0063849725
)
, 

0.0000939136
)
;


// Tree: 803

b3_tree_803 := 
map(

( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 770) => 
map(

   ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 739.5) => 
map(

      ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 4380.5) => 
0.0003070950
, 

      (v1_hhcrtreclienjudgamtttl > 4380.5) => 
map(

         ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 252770) => 
map(

            ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 1.905) => 
0.0000110880
, 

            (v1_rescurravmcntyratio > 1.905) => 
-0.0420929290
, 

-0.0009858478
)
, 

         (v1_raapropowneravmhighest > 252770) => 
map(

            ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 67957) => 
0.1834977666
, 

            (v1_raapropowneravmmed > 67957) => 
-0.0119006238
, 

-0.0114148602
)
, 

-0.0041683012
)
, 

-0.0000739593
)
, 

   (v1_lifeevtimelastmove > 739.5) => 
0.1383861961
, 

-0.0000633398
)
, 

(v1_lifeevtimelastmove > 770) => 
-0.0911661857
, 

-0.0000912805
)
;


// Tree: 807

b3_tree_807 := 
map(

( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 70121.5) => 
-0.0005279597
, 

(v1_rescurrmortgageamount > 70121.5) => 
map(

   ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 39744) => 
map(

      ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 0.995) => 
-0.0016967742
, 

      (v1_resinputavmratiodiff12mo > 0.995) => 
map(

         ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 162) => 
map(

            ( NULL < v1_crtreclienjudgcnt and v1_crtreclienjudgcnt <= 3.5) => 
0.0105759885
, 

            (v1_crtreclienjudgcnt > 3.5) => 
map(

               ( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 0.665) => 
0.2392812412
, 

               (v1_rescurravmblockratio > 0.665) => 
0.0503063482
, 

0.0669054942
)
, 

0.0114365135
)
, 

         (v1_occbusinessassociationtime > 162) => 
-0.0384607765
, 

0.0100543726
)
, 

0.0057667920
)
, 

   (v1_crtreclienjudgamtttl > 39744) => 
-0.0476359675
, 

0.0052276425
)
, 

-0.0001598673
)
;


// Tree: 811

b3_tree_811 := 
map(

( NULL < v1_hhcrtrecbkrptmmbrcnt24mo and v1_hhcrtrecbkrptmmbrcnt24mo <= 2.5) => 
map(

   ( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 11.5) => 
0.0000431150
, 

   (v1_raaoccbusinessassocmmbrcnt > 11.5) => 
map(

      ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 1.5) => 
map(

         ( NULL < v1_hhoccproflicmmbrcnt and v1_hhoccproflicmmbrcnt <= 1.5) => 
map(

            ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 7.5) => 
0.0263134835
, 

            (v1_raacrtreclienjudgmmbrcnt > 7.5) => 
-0.0523234197
, 

-0.0197590579
)
, 

         (v1_hhoccproflicmmbrcnt > 1.5) => 
0.1784422855
, 

-0.0093880574
)
, 

      (v1_raacollege4yrattendedmmbrcnt > 1.5) => 
0.0399747635
, 

0.0216764764
)
, 

0.0001241470
)
, 

(v1_hhcrtrecbkrptmmbrcnt24mo > 2.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 167) => 
0.1507260992
, 

   (v1_prospecttimeonrecord > 167) => 
-0.0233124472
, 

0.0817674298
)
, 

0.0001416088
)
;


// Tree: 815

b3_tree_815 := 
map(

( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 2.5) => 
0.0002105865
, 

(v1_hhcrtrecmmbrcnt > 2.5) => 
map(

   ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 0.595) => 
map(

      ( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 269052) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 98.5) => 
map(

            ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= 137.5) => 
-0.0112508114
, 

            (v1_lifeevtimefirstassetpurchase > 137.5) => 
0.0393304932
, 

-0.0082810531
)
, 

         (v1_crtrectimenewest > 98.5) => 
0.0187613054
, 

-0.0024298702
)
, 

      (v1_rescurravmvalue60mo > 269052) => 
0.0899202852
, 

-0.0011177915
)
, 

   (v1_rescurravmratiodiff60mo > 0.595) => 
map(

      ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 0.355) => 
-0.0630775889
, 

      (v1_rescurravmcntyratio > 0.355) => 
-0.0114697434
, 

-0.0151072429
)
, 

-0.0069541550
)
, 

-0.0000617734
)
;


// Tree: 819

b3_tree_819 := 
map(

( NULL < v1_hhcrtrecmmbrcnt12mo and v1_hhcrtrecmmbrcnt12mo <= 3.5) => 
map(

   ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 18.5) => 
map(

      ( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 21.5) => 
-0.0001699775
, 

      (v1_raaoccproflicmmbrcnt > 21.5) => 
0.0878252944
, 

-0.0001429267
)
, 

   (v1_raacrtreclienjudgmmbrcnt > 18.5) => 
map(

      ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 1.5) => 
map(

         ( NULL < v1_crtreccnt12mo and v1_crtreccnt12mo <= 1.5) => 
-0.0526694877
, 

         (v1_crtreccnt12mo > 1.5) => 
map(

            ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 17.5) => 
0.2923206465
, 

            (v1_raacrtrecmsdmeanmmbrcnt > 17.5) => 
-0.0337926448
, 

0.1292640009
)
, 

-0.0445010453
)
, 

      (v1_crtrecbkrptcnt > 1.5) => 
0.0747886944
, 

-0.0322662002
)
, 

-0.0002137148
)
, 

(v1_hhcrtrecmmbrcnt12mo > 3.5) => 
0.1126812935
, 

-0.0001991362
)
;


// Tree: 823

b3_tree_823 := 
map(

( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 673) => 
map(

   ( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 291150) => 
0.0004045568
, 

   (v1_rescurrmortgageamount > 291150) => 
map(

      ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 3.5) => 
map(

         ( NULL < v1_proptimelastsale and v1_proptimelastsale <= 215.5) => 
map(

            ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 12.5) => 
-0.0083519192
, 

            (v1_raacrtrecmsdmeanmmbrcnt > 12.5) => 
-0.1064882585
, 

-0.0101637584
)
, 

         (v1_proptimelastsale > 215.5) => 
map(

            ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 241) => 
0.1649651867
, 

            (v1_prospecttimeonrecord > 241) => 
-0.0855660072
, 

0.0993498740
)
, 

-0.0087891103
)
, 

      (v1_crtrecmsdmeancnt > 3.5) => 
-0.0884903423
, 

-0.0111692862
)
, 

0.0002433526
)
, 

(v1_lifeevtimelastmove > 673) => 
-0.0523736510
, 

0.0002053450
)
;


// Tree: 827

b3_tree_827 := 
map(

( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 13.5) => 
map(

   ( NULL < v1_raacrtrecfelonymmbrcnt12mo and v1_raacrtrecfelonymmbrcnt12mo <= 1.5) => 
map(

      ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 1.5) => 
-0.0004664690
, 

      (v1_hhmiddleagemmbrcnt > 1.5) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 2.5) => 
map(

            ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 1353125) => 
0.0158583799
, 

            (v1_hhpropcurravmhighest > 1353125) => 
0.2637411936
, 

0.0166185773
)
, 

         (v1_hhcnt > 2.5) => 
0.0009144533
, 

0.0034459124
)
, 

-0.0000473610
)
, 

   (v1_raacrtrecfelonymmbrcnt12mo > 1.5) => 
-0.0513339131
, 

-0.0000897369
)
, 

(v1_raacrtreclienjudgmmbrcnt > 13.5) => 
map(

   ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 230937) => 
-0.0175929298
, 

   (v1_crtreclienjudgamtttl > 230937) => 
0.1660470777
, 

-0.0164657721
)
, 

-0.0002297041
)
;


// Tree: 831

b3_tree_831 := 
map(

( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 4.5) => 
-0.0003457888
, 

(v1_raayoungadultmmbrcnt > 4.5) => 
map(

   ( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.225) => 
map(

      ( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 3.62) => 
map(

         ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 2.5) => 
map(

            ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 1.345) => 
0.0193325615
, 

            (v1_resinputavmtractratio > 1.345) => 
map(

               ( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 0.5) => 
0.1776371857
, 

               (v1_raaoccproflicmmbrcnt > 0.5) => 
0.0209931993
, 

0.1010818540
)
, 

0.0277806236
)
, 

         (v1_raamiddleagemmbrcnt > 2.5) => 
0.0055832689
, 

0.0082652061
)
, 

      (v1_resinputavmratiodiff60mo > 3.62) => 
0.2002698222
, 

0.0085711466
)
, 

   (v1_rescurravmratiodiff12mo > 1.225) => 
-0.0161657194
, 

0.0062343505
)
, 

-0.0000329318
)
;


// Tree: 835

b3_tree_835 := 
map(

( NULL < v1_hhcrtrecbkrptmmbrcnt24mo and v1_hhcrtrecbkrptmmbrcnt24mo <= 0.5) => 
0.0003295729
, 

(v1_hhcrtrecbkrptmmbrcnt24mo > 0.5) => 
map(

   ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 135564.5) => 
map(

      ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 121.5) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 16.5) => 
map(

            ( NULL < v1_lifeevtimelastassetpurchase and v1_lifeevtimelastassetpurchase <= 184.5) => 
0.0081826366
, 

            (v1_lifeevtimelastassetpurchase > 184.5) => 
map(

               ( NULL < v1_lifeevtimelastassetpurchase and v1_lifeevtimelastassetpurchase <= 249.5) => 
0.1405954530
, 

               (v1_lifeevtimelastassetpurchase > 249.5) => 
-0.1212032270
, 

0.0899247408
)
, 

0.0103401549
)
, 

         (v1_crtrecbkrpttimenewest > 16.5) => 
0.0395029168
, 

0.0181490116
)
, 

      (v1_occbusinessassociationtime > 121.5) => 
-0.0433316322
, 

0.0154202014
)
, 

   (v1_propcurrownedassessedttl > 135564.5) => 
-0.0238422578
, 

0.0115223989
)
, 

0.0004979143
)
;


// Tree: 839

b3_tree_839 := 
map(

( NULL < v1_raahhcnt and v1_raahhcnt <= 43.5) => 
map(

   ( NULL < v1_raacrtrecbkrptmmbrcnt36mo and v1_raacrtrecbkrptmmbrcnt36mo <= 7.5) => 
map(

      ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
-0.0003078241
, 

      (v1_hhseniormmbrcnt > 0.5) => 
map(

         ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 0.185) => 
map(

            ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 0.5) => 
0.0141680381
, 

            (v1_crtrecmsdmeancnt > 0.5) => 
map(

               ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 0.895) => 
-0.0097667489
, 

               (v1_rescurravmratiodiff60mo > 0.895) => 
0.2606234920
, 

-0.0079124518
)
, 

0.0105299173
)
, 

         (v1_rescurravmcntyratio > 0.185) => 
-0.0013205553
, 

0.0038413916
)
, 

0.0000668035
)
, 

   (v1_raacrtrecbkrptmmbrcnt36mo > 7.5) => 
-0.1183175082
, 

0.0000553262
)
, 

(v1_raahhcnt > 43.5) => 
0.0411286136
, 

0.0000970950
)
;


// Tree: 843

b3_tree_843 := 
map(

( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 3.5) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 24.5) => 
-0.0010224032
, 

   (v1_raammbrcnt > 24.5) => 
map(

      ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 5.5) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 219.5) => 
map(

            ( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 0.5) => 
0.0158701062
, 

            (v1_raaoccproflicmmbrcnt > 0.5) => 
0.0024412395
, 

0.0075386993
)
, 

         (v1_prospecttimelastupdate > 219.5) => 
-0.0635022574
, 

0.0069556995
)
, 

      (v1_raacrtrecfelonymmbrcnt > 5.5) => 
-0.0227983518
, 

0.0051360697
)
, 

-0.0006971120
)
, 

(v1_lifeeveverresidedcnt > 3.5) => 
map(

   ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 945890.5) => 
0.0067694349
, 

   (v1_propcurrownedassessedttl > 945890.5) => 
-0.0387707667
, 

0.0054425015
)
, 

-0.0004020535
)
;


// Tree: 847

b3_tree_847 := 
map(

( NULL < v1_raacrtrecmmbrcnt12mo and v1_raacrtrecmmbrcnt12mo <= 5.5) => 
map(

   ( NULL < v1_raacollegetoptiermmbrcnt and v1_raacollegetoptiermmbrcnt <= 0.5) => 
-0.0001139557
, 

   (v1_raacollegetoptiermmbrcnt > 0.5) => 
map(

      ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 1.5) => 
0.0069721329
, 

      (v1_raacrtrecfelonymmbrcnt > 1.5) => 
map(

         ( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 1.41) => 
-0.0210268401
, 

         (v1_resinputavmratiodiff60mo > 1.41) => 
0.1357789441
, 

-0.0165413350
)
, 

0.0056413315
)
, 

0.0002334534
)
, 

(v1_raacrtrecmmbrcnt12mo > 5.5) => 
map(

   ( NULL < v1_crtrecfelonytimenewest and v1_crtrecfelonytimenewest <= 303) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 129.5) => 
-0.0202466656
, 

      (v1_prospecttimelastupdate > 129.5) => 
0.0634663969
, 

-0.0177878544
)
, 

   (v1_crtrecfelonytimenewest > 303) => 
0.2215189149
, 

-0.0164972112
)
, 

0.0000832309
)
;


// Tree: 851

b3_tree_851 := 
map(

( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 50121) => 
map(

   ( NULL < v1_raaseniormmbrcnt and v1_raaseniormmbrcnt <= 4.5) => 
-0.0006990916
, 

   (v1_raaseniormmbrcnt > 4.5) => 
map(

      ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 8.5) => 
map(

         ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 23.5) => 
-0.0054988993
, 

         (v1_raacrtrecmsdmeanmmbrcnt > 23.5) => 
0.1428805035
, 

0.0003002957
)
, 

      (v1_raacrtreclienjudgmmbrcnt > 8.5) => 
0.0502183058
, 

0.0206814928
)
, 

-0.0005331106
)
, 

(v1_resinputavmvalue12mo > 50121) => 
map(

   ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.235) => 
map(

      ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.085) => 
0.0030769440
, 

      (v1_resinputavmcntyratio > 1.085) => 
0.0125528957
, 

0.0042888235
)
, 

   (v1_resinputavmcntyratio > 1.235) => 
-0.0012067655
, 

0.0025458443
)
, 

0.0005388156
)
;


// Tree: 855

b3_tree_855 := 
map(

( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.145) => 
map(

   ( NULL < v1_raacollegemidtiermmbrcnt and v1_raacollegemidtiermmbrcnt <= 1.5) => 
map(

      ( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 3.5) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 5.5) => 
-0.0008600211
, 

         (v1_crtrecbkrpttimenewest > 5.5) => 
map(

            ( NULL < v1_prospectcollegeattended and v1_prospectcollegeattended <= 0.5) => 
map(

               ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 395.5) => 
0.0073516529
, 

               (v1_lifeevtimelastmove > 395.5) => 
0.0569690771
, 

0.0085841409
)
, 

            (v1_prospectcollegeattended > 0.5) => 
-0.0184155496
, 

0.0059321713
)
, 

-0.0004985103
)
, 

      (v1_raaoccproflicmmbrcnt > 3.5) => 
-0.0146509571
, 

-0.0006714609
)
, 

   (v1_raacollegemidtiermmbrcnt > 1.5) => 
0.0065693294
, 

-0.0003029019
)
, 

(v1_rescurravmratiodiff12mo > 1.145) => 
-0.0047617225
, 

-0.0007049450
)
;


// Tree: 859

b3_tree_859 := 
map(

( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 1.345) => 
map(

   ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 1.835) => 
-0.0006777103
, 

   (v1_rescurravmratiodiff60mo > 1.835) => 
-0.0297397473
, 

-0.0007642075
)
, 

(v1_resinputavmtractratio > 1.345) => 
map(

   ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 8313.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 199.5) => 
0.0026768386
, 

      (v1_crtrectimenewest > 199.5) => 
0.0437171538
, 

0.0035122963
)
, 

   (v1_crtreclienjudgamtttl > 8313.5) => 
map(

      ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 1.135) => 
map(

         ( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 255301) => 
0.0480199069
, 

         (v1_rescurrmortgageamount > 255301) => 
-0.0989327654
, 

0.0421418000
)
, 

      (v1_rescurravmratiodiff60mo > 1.135) => 
-0.0555785398
, 

0.0311949860
)
, 

0.0044923567
)
, 

-0.0003256160
)
;


// Tree: 863

b3_tree_863 := 
map(

( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 2.5) => 
-0.0003849117
, 

(v1_lifeeveverresidedcnt > 2.5) => 
map(

   ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 1140432.5) => 
map(

      ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 1.345) => 
map(

         ( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 174.5) => 
0.0022505369
, 

         (v1_rescurrbusinesscnt > 174.5) => 
0.2019115793
, 

0.0023670932
)
, 

      (v1_resinputavmtractratio > 1.345) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 77.5) => 
0.0197787672
, 

         (v1_prospecttimelastupdate > 77.5) => 
map(

            ( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 211174.5) => 
0.0151644802
, 

            (v1_rescurravmvalue60mo > 211174.5) => 
-0.0871365737
, 

-0.0304905356
)
, 

0.0161581805
)
, 

0.0041751253
)
, 

   (v1_resinputavmvalue12mo > 1140432.5) => 
-0.0633992862
, 

0.0038210442
)
, 

0.0000523785
)
;


// Tree: 867

b3_tree_867 := 
map(

( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 670003) => 
0.0000077082
, 

(v1_rescurravmvalue12mo > 670003) => 
map(

   ( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 1.5) => 
map(

      ( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 689044) => 
map(

         ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 2.5) => 
0.0940206645
, 

         (v1_raacrtrecmsdmeanmmbrcnt > 2.5) => 
-0.0718793313
, 

0.0654900920
)
, 

      (v1_rescurravmvalue12mo > 689044) => 
0.0073374166
, 

0.0118393742
)
, 

   (v1_prospectcollegeprogramtype > 1.5) => 
map(

      ( NULL < v1_raaelderlymmbrcnt and v1_raaelderlymmbrcnt <= 1.5) => 
map(

         ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 4.5) => 
0.0781483209
, 

         (v1_resinputbusinesscnt > 4.5) => 
-0.1489597539
, 

0.0569232672
)
, 

      (v1_raaelderlymmbrcnt > 1.5) => 
0.3123179234
, 

0.0807312436
)
, 

0.0156274640
)
, 

0.0001429764
)
;


b3_gbm_logit := sum(
b3_tree_3,
b3_tree_7,
b3_tree_11,
b3_tree_15,
b3_tree_19,
b3_tree_23,
b3_tree_27,
b3_tree_31,
b3_tree_35,
b3_tree_39,
b3_tree_43,
b3_tree_47,
b3_tree_51,
b3_tree_55,
b3_tree_59,
b3_tree_63,
b3_tree_67,
b3_tree_71,
b3_tree_75,
b3_tree_79,
b3_tree_83,
b3_tree_87,
b3_tree_91,
b3_tree_95,
b3_tree_99,
b3_tree_103,
b3_tree_107,
b3_tree_111,
b3_tree_115,
b3_tree_119,
b3_tree_123,
b3_tree_127,
b3_tree_131,
b3_tree_135,
b3_tree_139,
b3_tree_143,
b3_tree_147,
b3_tree_151,
b3_tree_155,
b3_tree_159,
b3_tree_163,
b3_tree_167,
b3_tree_171,
b3_tree_175,
b3_tree_179,
b3_tree_183,
b3_tree_187,
b3_tree_191,
b3_tree_195,
b3_tree_199,
b3_tree_203,
b3_tree_207,
b3_tree_211,
b3_tree_215,
b3_tree_219,
b3_tree_223,
b3_tree_227,
b3_tree_231,
b3_tree_235,
b3_tree_239,
b3_tree_243,
b3_tree_247,
b3_tree_251,
b3_tree_255,
b3_tree_259,
b3_tree_263,
b3_tree_267,
b3_tree_271,
b3_tree_275,
b3_tree_279,
b3_tree_283,
b3_tree_287,
b3_tree_291,
b3_tree_295,
b3_tree_299,
b3_tree_303,
b3_tree_307,
b3_tree_311,
b3_tree_315,
b3_tree_319,
b3_tree_323,
b3_tree_327,
b3_tree_331,
b3_tree_335,
b3_tree_339,
b3_tree_343,
b3_tree_347,
b3_tree_351,
b3_tree_355,
b3_tree_359,
b3_tree_363,
b3_tree_367,
b3_tree_371,
b3_tree_375,
b3_tree_379,
b3_tree_383,
b3_tree_387,
b3_tree_391,
b3_tree_395,
b3_tree_399,
b3_tree_403,
b3_tree_407,
b3_tree_411,
b3_tree_415,
b3_tree_419,
b3_tree_423,
b3_tree_427,
b3_tree_431,
b3_tree_435,
b3_tree_439,
b3_tree_443,
b3_tree_447,
b3_tree_451,
b3_tree_455,
b3_tree_459,
b3_tree_463,
b3_tree_467,
b3_tree_471,
b3_tree_475,
b3_tree_479,
b3_tree_483,
b3_tree_487,
b3_tree_491,
b3_tree_495,
b3_tree_499,
b3_tree_503,
b3_tree_507,
b3_tree_511,
b3_tree_515,
b3_tree_519,
b3_tree_523,
b3_tree_527,
b3_tree_531,
b3_tree_535,
b3_tree_539,
b3_tree_543,
b3_tree_547,
b3_tree_551,
b3_tree_555,
b3_tree_559,
b3_tree_563,
b3_tree_567,
b3_tree_571,
b3_tree_575,
b3_tree_579,
b3_tree_583,
b3_tree_587,
b3_tree_591,
b3_tree_595,
b3_tree_599,
b3_tree_603,
b3_tree_607,
b3_tree_611,
b3_tree_615,
b3_tree_619,
b3_tree_623,
b3_tree_627,
b3_tree_631,
b3_tree_635,
b3_tree_639,
b3_tree_643,
b3_tree_647,
b3_tree_651,
b3_tree_655,
b3_tree_659,
b3_tree_663,
b3_tree_667,
b3_tree_671,
b3_tree_675,
b3_tree_679,
b3_tree_683,
b3_tree_687,
b3_tree_691,
b3_tree_695,
b3_tree_699,
b3_tree_703,
b3_tree_707,
b3_tree_711,
b3_tree_715,
b3_tree_719,
b3_tree_723,
b3_tree_727,
b3_tree_731,
b3_tree_735,
b3_tree_739,
b3_tree_743,
b3_tree_747,
b3_tree_751,
b3_tree_755,
b3_tree_759,
b3_tree_763,
b3_tree_767,
b3_tree_771,
b3_tree_775,
b3_tree_779,
b3_tree_783,
b3_tree_787,
b3_tree_791,
b3_tree_795,
b3_tree_799,
b3_tree_803,
b3_tree_807,
b3_tree_811,
b3_tree_815,
b3_tree_819,
b3_tree_823,
b3_tree_827,
b3_tree_831,
b3_tree_835,
b3_tree_839,
b3_tree_843,
b3_tree_847,
b3_tree_851,
b3_tree_855,
b3_tree_859,
b3_tree_863,
b3_tree_867);

//////////////////////////////////////
// Score for class 3: highly banked //
//////////////////////////////////////

b4_tree_0 :=  0.0000000000;


// Tree: 4

b4_tree_4 := 
map(

( NULL < v1_propeverownedcnt and v1_propeverownedcnt <= 0.5) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
map(

      ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 98188) => 
-0.0926662664
, 

      (v1_raapropowneravmhighest > 98188) => 
-0.0305119249
, 

-0.0734348378
)
, 

   (v1_hhcnt > 1.5) => 
map(

      ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
0.0749118142
, 

      (v1_crtrecseverityindex > 2.5) => 
-0.0487815421
, 

0.0129311745
)
, 

-0.0561038246
)
, 

(v1_propeverownedcnt > 0.5) => 
map(

   ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 107075.5) => 
map(

      ( NULL < v1_crtreccnt and v1_crtreccnt <= 2.5) => 
0.1357873895
, 

      (v1_crtreccnt > 2.5) => 
0.0208444275
, 

0.1150642344
)
, 

   (v1_propcurrownedavmttl > 107075.5) => 
0.2031573469
, 

0.1628569935
)
, 

0.0002259851
)
;


// Tree: 8

b4_tree_8 := 
map(

( NULL < v1_propeverownedcnt and v1_propeverownedcnt <= 0.5) => 
map(

   ( NULL < v1_rescurravmvalue and v1_rescurravmvalue <= 63106) => 
map(

      ( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raahhcnt and v1_raahhcnt <= 0.5) => 
-0.0970083652
, 

         (v1_raahhcnt > 0.5) => 
-0.0481671431
, 

-0.0677205751
)
, 

      (v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
0.0722513715
, 

-0.0623872666
)
, 

   (v1_rescurravmvalue > 63106) => 
map(

      ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
0.0901097214
, 

      (v1_crtrecseverityindex > 2.5) => 
-0.0359128647
, 

0.0415029902
)
, 

-0.0521338812
)
, 

(v1_propeverownedcnt > 0.5) => 
map(

   ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 87071) => 
0.0846562315
, 

   (v1_hhpropcurravmhighest > 87071) => 
0.1537857639
, 

0.1274302588
)
, 

-0.0060486697
)
;


// Tree: 12

b4_tree_12 := 
map(

( NULL < v1_propeverownedcnt and v1_propeverownedcnt <= 0.5) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
map(

      ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 150463.5) => 
-0.0775409354
, 

      (v1_raapropowneravmhighest > 150463.5) => 
-0.0184197478
, 

-0.0629427089
)
, 

   (v1_hhcnt > 1.5) => 
map(

      ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
0.0576378600
, 

      (v1_crtrecseverityindex > 2.5) => 
-0.0419102779
, 

0.0077372149
)
, 

-0.0487358513
)
, 

(v1_propeverownedcnt > 0.5) => 
map(

   ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
map(

      ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
0.0885736627
, 

      (v1_hhmiddleagemmbrcnt > 0.5) => 
0.1384582823
, 

0.1177272258
)
, 

   (v1_crtrecseverityindex > 2.5) => 
0.0429215935
, 

0.1031619818
)
, 

-0.0095630255
)
;


// Tree: 16

b4_tree_16 := 
map(

( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
map(

   ( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
-0.0622096133
, 

      (v1_hhmiddleagemmbrcnt > 0.5) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 0) => 
0.0959379124
, 

         (v1_crtrectimenewest > 0) => 
-0.0377323652
, 

0.0044135859
)
, 

-0.0531879784
)
, 

   (v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
0.0823047297
, 

-0.0480359722
)
, 

(v1_hhpropcurrownermmbrcnt > 0.5) => 
map(

   ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 100186) => 
map(

      ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
0.0682483340
, 

      (v1_crtrecseverityindex > 2.5) => 
-0.0028820441
, 

0.0476470845
)
, 

   (v1_propcurrownedavmttl > 100186) => 
0.1052025845
, 

0.0751806006
)
, 

-0.0114529755
)
;


// Tree: 20

b4_tree_20 := 
map(

( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

   ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_rescurravmvalue and v1_rescurravmvalue <= 78734) => 
-0.0594778759
, 

      (v1_rescurravmvalue > 78734) => 
0.0220856052
, 

-0.0530879603
)
, 

   (v1_raacollege4yrattendedmmbrcnt > 0.5) => 
map(

      ( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
0.0045120014
, 

      (v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
0.0902094219
, 

0.0158001865
)
, 

-0.0407444057
)
, 

(v1_lifeevtimefirstassetpurchase > -0.5) => 
map(

   ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 127249.5) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 91012) => 
0.0278763079
, 

      (v1_propcurrownedassessedttl > 91012) => 
0.0910580109
, 

0.0483542448
)
, 

   (v1_hhpropcurravmhighest > 127249.5) => 
0.0938740302
, 

0.0719961612
)
, 

-0.0114887464
)
;


// Tree: 24

b4_tree_24 := 
map(

( NULL < v1_propcurrowner and v1_propcurrowner <= 0.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 112368) => 
map(

      ( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
-0.0656813287
, 

         (v1_hhmiddleagemmbrcnt > 0.5) => 
map(

            ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
0.0792970948
, 

            (v1_hhcrtrecmmbrcnt > 0.5) => 
-0.0321863781
, 

-0.0084342218
)
, 

-0.0576549429
)
, 

      (v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
0.0588798109
, 

-0.0541617085
)
, 

   (v1_raapropowneravmmed > 112368) => 
0.0067283304
, 

-0.0368087278
)
, 

(v1_propcurrowner > 0.5) => 
map(

   ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 0.805) => 
0.0451193347
, 

   (v1_rescurravmcntyratio > 0.805) => 
0.0853065333
, 

0.0628987582
)
, 

-0.0125312723
)
;


// Tree: 28

b4_tree_28 := 
map(

( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
map(

   ( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhoccbusinessassocmmbrcnt and v1_hhoccbusinessassocmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 194116.5) => 
-0.0562627148
, 

         (v1_raapropowneravmhighest > 194116.5) => 
-0.0076102660
, 

-0.0465370344
)
, 

      (v1_hhoccbusinessassocmmbrcnt > 0.5) => 
0.0491131157
, 

-0.0422215604
)
, 

   (v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
0.0654623920
, 

-0.0380509949
)
, 

(v1_hhpropcurrownermmbrcnt > 0.5) => 
map(

   ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
0.0417278024
, 

      (v1_lifeeveverresidedcnt > 1.5) => 
0.0814820675
, 

0.0599185085
)
, 

   (v1_crtrecseverityindex > 2.5) => 
0.0076112051
, 

0.0481469868
)
, 

-0.0124236842
)
;


// Tree: 32

b4_tree_32 := 
map(

( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

   ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 0.775) => 
-0.0463335465
, 

      (v1_rescurravmcntyratio > 0.775) => 
map(

         ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 0.5) => 
0.1060024536
, 

         (v1_rescurrownershipindex > 0.5) => 
0.0050003628
, 

0.0291305551
)
, 

-0.0422208865
)
, 

   (v1_raacollege4yrattendedmmbrcnt > 0.5) => 
0.0191804782
, 

-0.0312330941
)
, 

(v1_lifeevtimefirstassetpurchase > -0.5) => 
map(

   ( NULL < v1_crtreccnt and v1_crtreccnt <= 3.5) => 
map(

      ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 114658.5) => 
0.0317966995
, 

      (v1_raapropowneravmmed > 114658.5) => 
0.0666513501
, 

0.0523870042
)
, 

   (v1_crtreccnt > 3.5) => 
-0.0105841050
, 

0.0458219165
)
, 

-0.0111900971
)
;


// Tree: 36

b4_tree_36 := 
map(

( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
map(

   ( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
-0.0505796907
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
0.0174981578
, 

-0.0440757908
)
, 

      (v1_hhmiddleagemmbrcnt > 0.5) => 
map(

         ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
0.0926652367
, 

         (v1_hhcrtrecmmbrcnt > 0.5) => 
-0.0157994484
, 

0.0101263740
)
, 

-0.0367685394
)
, 

   (v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
0.0565562816
, 

-0.0331734967
)
, 

(v1_hhpropcurrownermmbrcnt > 0.5) => 
map(

   ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 390.5) => 
0.0470748443
, 

   (v1_hhcrtreclienjudgamtttl > 390.5) => 
0.0053920285
, 

0.0363483524
)
, 

-0.0125128232
)
;


// Tree: 40

b4_tree_40 := 
map(

( NULL < v1_propcurrowner and v1_propcurrowner <= 0.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 123122.5) => 
map(

      ( NULL < v1_hhcollegetiermmbrhighest and v1_hhcollegetiermmbrhighest <= 0.5) => 
-0.0430675981
, 

      (v1_hhcollegetiermmbrhighest > 0.5) => 
0.0335566498
, 

-0.0396135013
)
, 

   (v1_raapropowneravmmed > 123122.5) => 
map(

      ( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 0.5) => 
0.0069052745
, 

      (v1_occproflicensecategory > 0.5) => 
0.1124283080
, 

0.0111197865
)
, 

-0.0260403488
)
, 

(v1_propcurrowner > 0.5) => 
map(

   ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 162494.5) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 93305) => 
0.0057603988
, 

      (v1_propcurrownedassessedttl > 93305) => 
0.0433029749
, 

0.0201528511
)
, 

   (v1_propcurrownedavmttl > 162494.5) => 
0.0547126050
, 

0.0355145123
)
, 

-0.0109561736
)
;


// Tree: 44

b4_tree_44 := 
map(

( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 39.5) => 
map(

   ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
-0.0428779900
, 

      (v1_hhmiddleagemmbrcnt > 0.5) => 
0.0354532578
, 

-0.0396381648
)
, 

   (v1_hhyoungadultmmbrcnt > 0.5) => 
0.0372833844
, 

-0.0342913189
)
, 

(v1_prospecttimeonrecord > 39.5) => 
map(

   ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 37.5) => 
map(

         ( NULL < v1_hhcrtrecbkrptmmbrcnt24mo and v1_hhcrtrecbkrptmmbrcnt24mo <= 0.5) => 
0.0662550942
, 

         (v1_hhcrtrecbkrptmmbrcnt24mo > 0.5) => 
-0.0636949873
, 

0.0614600321
)
, 

      (v1_prospecttimelastupdate > 37.5) => 
0.0207127916
, 

0.0416543351
)
, 

   (v1_crtrecseverityindex > 2.5) => 
-0.0136743854
, 

0.0214245536
)
, 

-0.0113031591
)
;


// Tree: 48

b4_tree_48 := 
map(

( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 44.5) => 
map(

   ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_occproflicense and v1_occproflicense <= 0.5) => 
-0.0368890442
, 

      (v1_occproflicense > 0.5) => 
0.1061475046
, 

-0.0354014742
)
, 

   (v1_hhyoungadultmmbrcnt > 0.5) => 
0.0313867119
, 

-0.0304866817
)
, 

(v1_prospecttimeonrecord > 44.5) => 
map(

   ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 24.5) => 
map(

         ( NULL < v1_hhcrtrecbkrptmmbrcnt24mo and v1_hhcrtrecbkrptmmbrcnt24mo <= 0.5) => 
0.0627449107
, 

         (v1_hhcrtrecbkrptmmbrcnt24mo > 0.5) => 
-0.0536697917
, 

0.0580507694
)
, 

      (v1_prospecttimelastupdate > 24.5) => 
0.0200318161
, 

0.0367527509
)
, 

   (v1_crtrecseverityindex > 2.5) => 
-0.0109085209
, 

0.0193205747
)
, 

-0.0101152799
)
;


// Tree: 52

b4_tree_52 := 
map(

( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 0.685) => 
map(

   ( NULL < v1_hhoccbusinessassocmmbrcnt and v1_hhoccbusinessassocmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 192383) => 
-0.0353864466
, 

         (v1_raapropowneravmhighest > 192383) => 
0.0054737765
, 

-0.0266456558
)
, 

      (v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
0.0426480639
, 

-0.0238288560
)
, 

   (v1_hhoccbusinessassocmmbrcnt > 0.5) => 
0.0416803937
, 

-0.0189033778
)
, 

(v1_rescurravmcntyratio > 0.685) => 
map(

   ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 785.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 6.5) => 
0.0227264423
, 

      (v1_raammbrcnt > 6.5) => 
0.0529599800
, 

0.0401894153
)
, 

   (v1_hhcrtreclienjudgamtttl > 785.5) => 
0.0002758736
, 

0.0310498680
)
, 

-0.0096113774
)
;


// Tree: 56

b4_tree_56 := 
map(

( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 82.5) => 
map(

   ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_occproflicense and v1_occproflicense <= 0.5) => 
-0.0340070631
, 

      (v1_occproflicense > 0.5) => 
0.0854006819
, 

-0.0325518351
)
, 

   (v1_raacollege4yrattendedmmbrcnt > 0.5) => 
0.0188539064
, 

-0.0239561927
)
, 

(v1_prospecttimeonrecord > 82.5) => 
map(

   ( NULL < v1_crtreccnt and v1_crtreccnt <= 1.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 45.5) => 
0.0495321978
, 

      (v1_prospecttimelastupdate > 45.5) => 
0.0103869309
, 

0.0307118406
)
, 

   (v1_crtreccnt > 1.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 90.5) => 
-0.0206007654
, 

      (v1_crtrectimenewest > 90.5) => 
0.0266200047
, 

-0.0069591429
)
, 

0.0172809855
)
, 

-0.0092811197
)
;


// Tree: 60

b4_tree_60 := 
map(

( NULL < v1_hhoccbusinessassocmmbrcnt and v1_hhoccbusinessassocmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 105021.5) => 
map(

      ( NULL < v1_hhcollegetiermmbrhighest and v1_hhcollegetiermmbrhighest <= 0.5) => 
-0.0289574725
, 

      (v1_hhcollegetiermmbrhighest > 0.5) => 
0.0328989418
, 

-0.0259266383
)
, 

   (v1_raapropowneravmmed > 105021.5) => 
map(

      ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= 6.5) => 
map(

         ( NULL < v1_occproflicense and v1_occproflicense <= 0.5) => 
0.0014432231
, 

         (v1_occproflicense > 0.5) => 
0.0640382910
, 

0.0039224177
)
, 

      (v1_lifeevtimefirstassetpurchase > 6.5) => 
0.0300743195
, 

0.0099582203
)
, 

-0.0135861610
)
, 

(v1_hhoccbusinessassocmmbrcnt > 0.5) => 
map(

   ( NULL < v1_hhcrtrecbkrptmmbrcnt and v1_hhcrtrecbkrptmmbrcnt <= 0.5) => 
0.0462243217
, 

   (v1_hhcrtrecbkrptmmbrcnt > 0.5) => 
-0.0017706865
, 

0.0373918207
)
, 

-0.0076324485
)
;


// Tree: 64

b4_tree_64 := 
map(

( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
-0.0398659220
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
0.0154171818
, 

-0.0337327807
)
, 

      (v1_hhseniormmbrcnt > 0.5) => 
0.0231435614
, 

-0.0300278457
)
, 

   (v1_hhmiddleagemmbrcnt > 0.5) => 
map(

      ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 80.5) => 
0.0280837193
, 

      (v1_hhcrtreclienjudgamtttl > 80.5) => 
-0.0168709062
, 

0.0103649574
)
, 

-0.0201413555
)
, 

(v1_raacollege4yrattendedmmbrcnt > 0.5) => 
map(

   ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 3.5) => 
0.0304901154
, 

   (v1_crtrecseverityindex > 3.5) => 
-0.0296246701
, 

0.0247940782
)
, 

-0.0100194407
)
;


// Tree: 68

b4_tree_68 := 
map(

( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

   ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
-0.0317013684
, 

      (v1_hhseniormmbrcnt > 0.5) => 
0.0286542822
, 

-0.0266639774
)
, 

   (v1_hhyoungadultmmbrcnt > 0.5) => 
map(

      ( NULL < v1_prospectcollegetier and v1_prospectcollegetier <= 1.5) => 
0.0151185622
, 

      (v1_prospectcollegetier > 1.5) => 
0.0726161831
, 

0.0234481655
)
, 

-0.0194917639
)
, 

(v1_hhmiddleagemmbrcnt > 0.5) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 0) => 
0.0376925096
, 

   (v1_crtrectimenewest > 0) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 94.5) => 
-0.0225876976
, 

      (v1_crtrectimenewest > 94.5) => 
0.0349087746
, 

-0.0024001872
)
, 

0.0169641042
)
, 

-0.0090971544
)
;


// Tree: 72

b4_tree_72 := 
map(

( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 1.5) => 
map(

   ( NULL < v1_occproflicense and v1_occproflicense <= 0.5) => 
map(

      ( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 1.5) => 
map(

         ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 196401.5) => 
map(

            ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
-0.0225968701
, 

            (v1_raacollege4yrattendedmmbrcnt > 0.5) => 
0.0052983068
, 

-0.0174626916
)
, 

         (v1_propcurrownedavmttl > 196401.5) => 
0.0205424865
, 

-0.0148327024
)
, 

      (v1_prospectcollegeprogramtype > 1.5) => 
0.0427268657
, 

-0.0128642423
)
, 

   (v1_occproflicense > 0.5) => 
0.0575041290
, 

-0.0108044941
)
, 

(v1_occbusinessassociationtime > 1.5) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 0) => 
0.0549457394
, 

   (v1_crtrectimenewest > 0) => 
0.0219677648
, 

0.0399725346
)
, 

-0.0068880870
)
;


// Tree: 76

b4_tree_76 := 
map(

( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 1.5) => 
map(

   ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 1.5) => 
map(

      ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 286759) => 
map(

         ( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 1.5) => 
map(

            ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 160.5) => 
-0.0242631810
, 

            (v1_prospecttimeonrecord > 160.5) => 
map(

               ( NULL < v1_crtreccnt and v1_crtreccnt <= 1.5) => 
0.0160744198
, 

               (v1_crtreccnt > 1.5) => 
-0.0175523820
, 

0.0038684132
)
, 

-0.0196443469
)
, 

         (v1_prospectcollegeprogramtype > 1.5) => 
0.0351413867
, 

-0.0180341504
)
, 

      (v1_raapropowneravmhighest > 286759) => 
0.0138049414
, 

-0.0122003776
)
, 

   (v1_occbusinessassociationtime > 1.5) => 
0.0334556703
, 

-0.0089344807
)
, 

(v1_occproflicensecategory > 1.5) => 
0.0668573767
, 

-0.0072580946
)
;


// Tree: 80

b4_tree_80 := 
map(

( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 174749.5) => 
map(

   ( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 1.5) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 133050) => 
map(

         ( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 1.5) => 
-0.0187630884
, 

         (v1_occproflicensecategory > 1.5) => 
0.0571129426
, 

-0.0181402629
)
, 

      (v1_propcurrownedassessedttl > 133050) => 
0.0234427061
, 

-0.0163347404
)
, 

   (v1_prospectcollegeprogramtype > 1.5) => 
0.0414971478
, 

-0.0148414693
)
, 

(v1_raapropowneravmhighest > 174749.5) => 
map(

   ( NULL < v1_crtreccnt and v1_crtreccnt <= 6.5) => 
map(

      ( NULL < v1_prospectlastupdate12mo and v1_prospectlastupdate12mo <= 0.5) => 
0.0105130938
, 

      (v1_prospectlastupdate12mo > 0.5) => 
0.0321716009
, 

0.0155822645
)
, 

   (v1_crtreccnt > 6.5) => 
-0.0332202259
, 

0.0125064925
)
, 

-0.0059320048
)
;


// Tree: 84

b4_tree_84 := 
map(

( NULL < v1_occproflicense and v1_occproflicense <= 0.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
-0.0280568107
, 

         (v1_hhseniormmbrcnt > 0.5) => 
0.0197330093
, 

-0.0242609509
)
, 

      (v1_hhyoungadultmmbrcnt > 0.5) => 
0.0197039451
, 

-0.0181917527
)
, 

   (v1_hhmiddleagemmbrcnt > 0.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 0) => 
0.0266759921
, 

      (v1_crtrectimenewest > 0) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 70.5) => 
-0.0291441476
, 

         (v1_crtrectimenewest > 70.5) => 
0.0181723189
, 

-0.0075828769
)
, 

0.0086748046
)
, 

-0.0108385572
)
, 

(v1_occproflicense > 0.5) => 
0.0441901736
, 

-0.0087880039
)
;


// Tree: 88

b4_tree_88 := 
map(

( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 0) => 
map(

   ( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 1.5) => 
map(

      ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 139991.5) => 
-0.0157845105
, 

         (v1_propcurrownedassessedttl > 139991.5) => 
0.0164684976
, 

-0.0142317459
)
, 

      (v1_raacollege4yrattendedmmbrcnt > 0.5) => 
map(

         ( NULL < v1_crtreccnt and v1_crtreccnt <= 4.5) => 
0.0150430743
, 

         (v1_crtreccnt > 4.5) => 
-0.0242932703
, 

0.0104086296
)
, 

-0.0091482441
)
, 

   (v1_occproflicensecategory > 1.5) => 
0.0577427177
, 

-0.0080737329
)
, 

(v1_occbusinessassociationtime > 0) => 
map(

   ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 1439.5) => 
0.0367711585
, 

   (v1_crtreclienjudgamtttl > 1439.5) => 
-0.0072492174
, 

0.0294970074
)
, 

-0.0051230067
)
;


// Tree: 92

b4_tree_92 := 
map(

( NULL < v1_prospectcollegetier and v1_prospectcollegetier <= 0.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
-0.0255697886
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
0.0124739111
, 

-0.0205592029
)
, 

      (v1_hhseniormmbrcnt > 0.5) => 
0.0166846243
, 

-0.0175546949
)
, 

   (v1_hhmiddleagemmbrcnt > 0.5) => 
map(

      ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
0.0297589390
, 

      (v1_hhcrtrecmmbrcnt > 0.5) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 134.5) => 
-0.0084984885
, 

         (v1_crtrectimenewest > 134.5) => 
0.0268239082
, 

-0.0026746097
)
, 

0.0077427305
)
, 

-0.0103681450
)
, 

(v1_prospectcollegetier > 0.5) => 
0.0364273656
, 

-0.0080051798
)
;


// Tree: 96

b4_tree_96 := 
map(

( NULL < v1_prospectlastupdate12mo and v1_prospectlastupdate12mo <= 0.5) => 
map(

   ( NULL < v1_occproflicense and v1_occproflicense <= 0.5) => 
map(

      ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 1.5) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 211604) => 
-0.0147490939
, 

         (v1_raapropowneravmmed > 211604) => 
0.0066361645
, 

-0.0113882791
)
, 

      (v1_raacollege4yrattendedmmbrcnt > 1.5) => 
0.0197321850
, 

-0.0091817645
)
, 

   (v1_occproflicense > 0.5) => 
0.0379287785
, 

-0.0078718966
)
, 

(v1_prospectlastupdate12mo > 0.5) => 
map(

   ( NULL < v1_crtreccnt12mo and v1_crtreccnt12mo <= 0.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 27.5) => 
-0.0177802668
, 

      (v1_prospecttimeonrecord > 27.5) => 
0.0314312974
, 

0.0275077206
)
, 

   (v1_crtreccnt12mo > 0.5) => 
-0.0225211201
, 

0.0158329671
)
, 

-0.0042285045
)
;


// Tree: 100

b4_tree_100 := 
map(

( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_prospectcollegetier and v1_prospectcollegetier <= 1.5) => 
map(

      ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 1.5) => 
-0.0157801757
, 

      (v1_hhmiddleagemmbrcnt > 1.5) => 
0.0107886074
, 

-0.0136495307
)
, 

   (v1_prospectcollegetier > 1.5) => 
0.0275556621
, 

-0.0124471578
)
, 

(v1_raaoccbusinessassocmmbrcnt > 0.5) => 
map(

   ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 3.5) => 
map(

      ( NULL < v1_hhcrtrecbkrptmmbrcnt24mo and v1_hhcrtrecbkrptmmbrcnt24mo <= 0.5) => 
map(

         ( NULL < v1_prospectlastupdate12mo and v1_prospectlastupdate12mo <= 0.5) => 
0.0100485963
, 

         (v1_prospectlastupdate12mo > 0.5) => 
0.0287033533
, 

0.0140460442
)
, 

      (v1_hhcrtrecbkrptmmbrcnt24mo > 0.5) => 
-0.0440932327
, 

0.0128366940
)
, 

   (v1_crtrecseverityindex > 3.5) => 
-0.0302708787
, 

0.0085363712
)
, 

-0.0042262013
)
;


// Tree: 104

b4_tree_104 := 
map(

( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 0) => 
map(

   ( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 45828) => 
map(

      ( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 1.5) => 
map(

         ( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 0.5) => 
map(

            ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 1.5) => 
-0.0126883403
, 

            (v1_hhmiddleagemmbrcnt > 1.5) => 
map(

               ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 1.5) => 
0.0276186563
, 

               (v1_hhcrtrecmmbrcnt > 1.5) => 
-0.0088975476
, 

0.0096206348
)
, 

-0.0109303859
)
, 

         (v1_occproflicensecategory > 0.5) => 
0.0293728850
, 

-0.0100190921
)
, 

      (v1_prospectcollegeprogramtype > 1.5) => 
0.0257088210
, 

-0.0088132612
)
, 

   (v1_rescurrmortgageamount > 45828) => 
0.0202797567
, 

-0.0071026785
)
, 

(v1_occbusinessassociationtime > 0) => 
0.0246633908
, 

-0.0046300158
)
;


// Tree: 108

b4_tree_108 := 
map(

( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_raacollegetoptiermmbrcnt and v1_raacollegetoptiermmbrcnt <= 0.5) => 
map(

      ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 2.5) => 
map(

         ( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 59210) => 
map(

            ( NULL < v1_crtreccnt and v1_crtreccnt <= 4.5) => 
map(

               ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
-0.0132300620
, 

               (v1_hhmiddleagemmbrcnt > 0.5) => 
0.0063457423
, 

-0.0093985931
)
, 

            (v1_crtreccnt > 4.5) => 
-0.0389254650
, 

-0.0118493609
)
, 

         (v1_rescurrmortgageamount > 59210) => 
0.0157394070
, 

-0.0105273287
)
, 

      (v1_occbusinessassociationtime > 2.5) => 
0.0166965536
, 

-0.0087451381
)
, 

   (v1_raacollegetoptiermmbrcnt > 0.5) => 
0.0247266457
, 

-0.0069953650
)
, 

(v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
0.0250234278
, 

-0.0049705127
)
;


// Tree: 112

b4_tree_112 := 
map(

( NULL < v1_occproflicense and v1_occproflicense <= 0.5) => 
map(

   ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 1.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 165.5) => 
-0.0098438201
, 

      (v1_prospecttimeonrecord > 165.5) => 
map(

         ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
-0.0630602562
, 

         (v1_lifeeveverresidedcnt > 0.5) => 
map(

            ( NULL < v1_crtreccnt and v1_crtreccnt <= 2.5) => 
map(

               ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 51.5) => 
0.0239724741
, 

               (v1_prospecttimelastupdate > 51.5) => 
-0.0019018176
, 

0.0125567343
)
, 

            (v1_crtreccnt > 2.5) => 
-0.0145001809
, 

0.0058759579
)
, 

0.0044470335
)
, 

-0.0070918229
)
, 

   (v1_raacollege4yrattendedmmbrcnt > 1.5) => 
0.0189231262
, 

-0.0049796853
)
, 

(v1_occproflicense > 0.5) => 
0.0307925275
, 

-0.0036478487
)
;


// Tree: 116

b4_tree_116 := 
map(

( NULL < v1_prospectcollegetier and v1_prospectcollegetier <= 1.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 155521) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 91125) => 
map(

         ( NULL < v1_hhcrtrecmsdmeanmmbrcnt and v1_hhcrtrecmsdmeanmmbrcnt <= 0.5) => 
-0.0072228116
, 

         (v1_hhcrtrecmsdmeanmmbrcnt > 0.5) => 
-0.0256285121
, 

-0.0108972443
)
, 

      (v1_propcurrownedassessedttl > 91125) => 
0.0114131854
, 

-0.0092376135
)
, 

   (v1_raapropowneravmmed > 155521) => 
map(

      ( NULL < v1_hhcrtrecbkrptmmbrcnt24mo and v1_hhcrtrecbkrptmmbrcnt24mo <= 0.5) => 
0.0102181988
, 

      (v1_hhcrtrecbkrptmmbrcnt24mo > 0.5) => 
-0.0525412448
, 

0.0089631888
)
, 

-0.0043604625
)
, 

(v1_prospectcollegetier > 1.5) => 
map(

   ( NULL < v1_raahhcnt and v1_raahhcnt <= 5.5) => 
0.0095951150
, 

   (v1_raahhcnt > 5.5) => 
0.0459756553
, 

0.0248849207
)
, 

-0.0029319702
)
;


// Tree: 120

b4_tree_120 := 
map(

( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 1.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
-0.0155622863
, 

      (v1_hhyoungadultmmbrcnt > 0.5) => 
0.0114468071
, 

-0.0120986074
)
, 

   (v1_hhmiddleagemmbrcnt > 0.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 0) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 39.5) => 
0.0312768582
, 

         (v1_prospecttimelastupdate > 39.5) => 
0.0004012434
, 

0.0183781673
)
, 

      (v1_crtrectimenewest > 0) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 65.5) => 
-0.0244685926
, 

         (v1_crtrectimenewest > 65.5) => 
0.0123486424
, 

-0.0066414336
)
, 

0.0053327353
)
, 

-0.0073972880
)
, 

(v1_raacollege4yrattendedmmbrcnt > 1.5) => 
0.0210565860
, 

-0.0049748437
)
;


// Tree: 124

b4_tree_124 := 
map(

( NULL < v1_prospectcollegetier and v1_prospectcollegetier <= 0.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 130267.5) => 
-0.0081686329
, 

   (v1_raapropowneravmmed > 130267.5) => 
map(

      ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 1038.5) => 
map(

         ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 1.5) => 
0.0035473792
, 

         (v1_raayoungadultmmbrcnt > 1.5) => 
0.0214726998
, 

0.0097377064
)
, 

      (v1_crtreclienjudgamtttl > 1038.5) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 121.5) => 
-0.0294234827
, 

         (v1_crtrectimenewest > 121.5) => 
0.0362242695
, 

-0.0183005874
)
, 

0.0063272792
)
, 

-0.0036199665
)
, 

(v1_prospectcollegetier > 0.5) => 
map(

   ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 0.5) => 
-0.0006111063
, 

   (v1_raayoungadultmmbrcnt > 0.5) => 
0.0338764787
, 

0.0213646400
)
, 

-0.0023490791
)
;


// Tree: 128

b4_tree_128 := 
map(

( NULL < v1_raaseniormmbrcnt and v1_raaseniormmbrcnt <= 0.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 1.5) => 
map(

      ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
-0.0113391603
, 

      (v1_hhyoungadultmmbrcnt > 0.5) => 
0.0092291819
, 

-0.0091191392
)
, 

   (v1_hhmiddleagemmbrcnt > 1.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
-0.0695041599
, 

      (v1_lifeeveverresidedcnt > 0.5) => 
0.0171596765
, 

0.0115604554
)
, 

-0.0073939619
)
, 

(v1_raaseniormmbrcnt > 0.5) => 
map(

   ( NULL < v1_crtreccnt and v1_crtreccnt <= 4.5) => 
map(

      ( NULL < v1_hhcrtrecbkrptmmbrcnt24mo and v1_hhcrtrecbkrptmmbrcnt24mo <= 0.5) => 
0.0138748085
, 

      (v1_hhcrtrecbkrptmmbrcnt24mo > 0.5) => 
-0.0417569440
, 

0.0127524658
)
, 

   (v1_crtreccnt > 4.5) => 
-0.0216613104
, 

0.0078483434
)
, 

-0.0027077360
)
;


// Tree: 132

b4_tree_132 := 
map(

( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 0.5) => 
map(

   ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 3.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
map(

         ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 0) => 
-0.0055125306
, 

         (v1_occbusinessassociationtime > 0) => 
0.0211675971
, 

-0.0044312581
)
, 

      (v1_lifeeveverresidedcnt > 1.5) => 
map(

         ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 7473.5) => 
map(

            ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 24.5) => 
0.0218826658
, 

            (v1_prospecttimelastupdate > 24.5) => 
0.0037754521
, 

0.0136025501
)
, 

         (v1_crtreclienjudgamtttl > 7473.5) => 
-0.0212361428
, 

0.0099844475
)
, 

-0.0016192067
)
, 

   (v1_crtrecseverityindex > 3.5) => 
-0.0323434057
, 

-0.0040973924
)
, 

(v1_prospectcollegeprogramtype > 0.5) => 
0.0222473629
, 

-0.0027547672
)
;


// Tree: 136

b4_tree_136 := 
map(

( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 2.5) => 
map(

   ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 3.5) => 
map(

      ( NULL < v1_raaseniormmbrcnt and v1_raaseniormmbrcnt <= 0.5) => 
-0.0039400074
, 

      (v1_raaseniormmbrcnt > 0.5) => 
map(

         ( NULL < v1_hhcrtrecbkrptmmbrcnt24mo and v1_hhcrtrecbkrptmmbrcnt24mo <= 0.5) => 
map(

            ( NULL < v1_lifeevnamechange and v1_lifeevnamechange <= 0.5) => 
map(

               ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 387.5) => 
0.0108453923
, 

               (v1_crtreclienjudgamtttl > 387.5) => 
-0.0159206867
, 

0.0074070156
)
, 

            (v1_lifeevnamechange > 0.5) => 
0.0287310181
, 

0.0100363459
)
, 

         (v1_hhcrtrecbkrptmmbrcnt24mo > 0.5) => 
-0.0408330071
, 

0.0088561838
)
, 

-0.0002238269
)
, 

   (v1_crtrecseverityindex > 3.5) => 
-0.0289066165
, 

-0.0025380887
)
, 

(v1_occproflicensecategory > 2.5) => 
0.0401917306
, 

-0.0019568139
)
;


// Tree: 140

b4_tree_140 := 
map(

( NULL < v1_raacollegetoptiermmbrcnt and v1_raacollegetoptiermmbrcnt <= 0.5) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 94.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 0) => 
map(

         ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

            ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

               ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
-0.0157163313
, 

               (v1_hhseniormmbrcnt > 0.5) => 
0.0246478612
, 

-0.0131252919
)
, 

            (v1_hhyoungadultmmbrcnt > 0.5) => 
0.0222768722
, 

-0.0103440860
)
, 

         (v1_hhmiddleagemmbrcnt > 0.5) => 
0.0115650329
, 

-0.0062313677
)
, 

      (v1_crtrectimenewest > 0) => 
-0.0177777426
, 

-0.0089969226
)
, 

   (v1_crtrectimenewest > 94.5) => 
0.0138154032
, 

-0.0070319535
)
, 

(v1_raacollegetoptiermmbrcnt > 0.5) => 
0.0169444952
, 

-0.0055706522
)
;


// Tree: 144

b4_tree_144 := 
map(

( NULL < v1_lifeevnamechange and v1_lifeevnamechange <= 0.5) => 
map(

   ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 1605.5) => 
map(

      ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
-0.0080065844
, 

         (v1_hhseniormmbrcnt > 0.5) => 
map(

            ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 11.5) => 
0.1022080418
, 

            (v1_prospecttimeonrecord > 11.5) => 
0.0067845995
, 

0.0192500744
)
, 

-0.0062805478
)
, 

      (v1_hhmiddleagemmbrcnt > 0.5) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 23.5) => 
0.0215153379
, 

         (v1_prospecttimelastupdate > 23.5) => 
-0.0027950165
, 

0.0089113992
)
, 

-0.0031884126
)
, 

   (v1_hhcrtreclienjudgamtttl > 1605.5) => 
-0.0169885528
, 

-0.0046465575
)
, 

(v1_lifeevnamechange > 0.5) => 
0.0147157672
, 

-0.0031192401
)
;


// Tree: 148

b4_tree_148 := 
map(

( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 1.5) => 
map(

   ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

      ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 34814.5) => 
0.0030848156
, 

      (v1_resinputavmvalue12mo > 34814.5) => 
map(

         ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 0.5) => 
0.0570573999
, 

         (v1_rescurrownershipindex > 0.5) => 
0.0206278873
, 

0.0394573749
)
, 

0.0058600464
)
, 

   (v1_resinputownershipindex > 0.5) => 
map(

      ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 2.5) => 
-0.0129866177
, 

      (v1_resinputownershipindex > 2.5) => 
map(

         ( NULL < v1_hhcrtrecbkrptmmbrcnt24mo and v1_hhcrtrecbkrptmmbrcnt24mo <= 1.5) => 
0.0053854303
, 

         (v1_hhcrtrecbkrptmmbrcnt24mo > 1.5) => 
-0.0966670169
, 

0.0045090631
)
, 

-0.0079224157
)
, 

-0.0018271436
)
, 

(v1_occproflicensecategory > 1.5) => 
0.0288871106
, 

-0.0011520111
)
;


// Tree: 152

b4_tree_152 := 
map(

( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 123.5) => 
map(

   ( NULL < v1_hhcrtrecfelonymmbrcnt and v1_hhcrtrecfelonymmbrcnt <= 0.5) => 
map(

      ( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 0.5) => 
-0.0041222020
, 

      (v1_raaoccproflicmmbrcnt > 0.5) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 4.5) => 
0.0103251457
, 

         (v1_crtrecbkrpttimenewest > 4.5) => 
-0.0173691113
, 

0.0079050275
)
, 

-0.0013302353
)
, 

   (v1_hhcrtrecfelonymmbrcnt > 0.5) => 
-0.0419532184
, 

-0.0027104052
)
, 

(v1_crtrectimenewest > 123.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 74.5) => 
map(

      ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 131.5) => 
0.0465923173
, 

      (v1_crtrecmsdmeantimenewest > 131.5) => 
0.0134430734
, 

0.0285915733
)
, 

   (v1_prospecttimelastupdate > 74.5) => 
-0.0018511989
, 

0.0158665475
)
, 

-0.0015891341
)
;


// Tree: 156

b4_tree_156 := 
map(

( NULL < v1_crtreccnt and v1_crtreccnt <= 5.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
map(

      ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 283306.5) => 
0.0035583245
, 

         (v1_raapropowneravmmed > 283306.5) => 
0.0392612920
, 

0.0059473537
)
, 

      (v1_resinputownershipindex > 0.5) => 
map(

         ( NULL < v1_occproflicense and v1_occproflicense <= 0.5) => 
-0.0091989878
, 

         (v1_occproflicense > 0.5) => 
0.0255529433
, 

-0.0081673729
)
, 

-0.0015841796
)
, 

   (v1_lifeeveverresidedcnt > 1.5) => 
map(

      ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 0.5) => 
0.0264756297
, 

      (v1_rescurrownershipindex > 0.5) => 
0.0057287009
, 

0.0105827112
)
, 

0.0008469030
)
, 

(v1_crtreccnt > 5.5) => 
-0.0242341226
, 

-0.0008449762
)
;


// Tree: 160

b4_tree_160 := 
map(

( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 2.5) => 
map(

   ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 3.5) => 
map(

      ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 200.5) => 
-0.0068407712
, 

         (v1_prospecttimeonrecord > 200.5) => 
0.0097111380
, 

-0.0050994381
)
, 

      (v1_raayoungadultmmbrcnt > 0.5) => 
map(

         ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 179.5) => 
map(

            ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 1.5) => 
0.0118187529
, 

            (v1_raacrtrecfelonymmbrcnt > 1.5) => 
-0.0110558902
, 

0.0095579308
)
, 

         (v1_crtreclienjudgamtttl > 179.5) => 
-0.0089682947
, 

0.0066182596
)
, 

-0.0003876722
)
, 

   (v1_crtrecseverityindex > 3.5) => 
-0.0227064784
, 

-0.0021924991
)
, 

(v1_occproflicensecategory > 2.5) => 
0.0339087372
, 

-0.0016919267
)
;


// Tree: 164

b4_tree_164 := 
map(

( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 1.5) => 
map(

   ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 20.5) => 
-0.0058239297
, 

         (v1_prospecttimelastupdate > 20.5) => 
-0.0201063530
, 

-0.0080853448
)
, 

      (v1_hhseniormmbrcnt > 0.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 0) => 
0.0843293694
, 

         (v1_prospecttimeonrecord > 0) => 
0.0069055670
, 

0.0123379143
)
, 

-0.0061293564
)
, 

   (v1_hhyoungadultmmbrcnt > 0.5) => 
0.0085439297
, 

-0.0039885696
)
, 

(v1_hhmiddleagemmbrcnt > 1.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
-0.0587809944
, 

   (v1_lifeeveverresidedcnt > 0.5) => 
0.0125596211
, 

0.0100032092
)
, 

-0.0024711806
)
;


// Tree: 168

b4_tree_168 := 
map(

( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 60.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 4.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 35.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 39.5) => 
map(

            ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 3.5) => 
-0.0049649833
, 

            (v1_occbusinessassociationtime > 3.5) => 
0.0368693414
, 

-0.0039520786
)
, 

         (v1_prospecttimeonrecord > 39.5) => 
0.0130570775
, 

-0.0001092453
)
, 

      (v1_prospecttimelastupdate > 35.5) => 
-0.0098112028
, 

-0.0019909005
)
, 

   (v1_crtrecbkrpttimenewest > 4.5) => 
map(

      ( NULL < v1_propcurrowner and v1_propcurrowner <= 0.5) => 
-0.0066899845
, 

      (v1_propcurrowner > 0.5) => 
-0.0854125450
, 

-0.0400383606
)
, 

-0.0028337418
)
, 

(v1_crtrecbkrpttimenewest > 60.5) => 
0.0180537603
, 

-0.0019226467
)
;


// Tree: 172

b4_tree_172 := 
map(

( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 1.5) => 
map(

   ( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.185) => 
map(

      ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 292073.5) => 
map(

         ( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 78387) => 
map(

            ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
0.0018630319
, 

            (v1_resinputownershipindex > 0.5) => 
-0.0100212595
, 

-0.0039530029
)
, 

         (v1_resinputmortgageamount > 78387) => 
0.0202679051
, 

-0.0032395973
)
, 

      (v1_raapropowneravmhighest > 292073.5) => 
0.0100287934
, 

-0.0008520458
)
, 

   (v1_rescurravmratiodiff12mo > 1.185) => 
-0.0133343699
, 

-0.0017466179
)
, 

(v1_prospectcollegeprogramtype > 1.5) => 
map(

   ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 1.5) => 
0.0021460199
, 

   (v1_raacrtreclienjudgmmbrcnt > 1.5) => 
0.0362758723
, 

0.0167575893
)
, 

-0.0010189319
)
;


// Tree: 176

b4_tree_176 := 
map(

( NULL < v1_prospectcollegetier and v1_prospectcollegetier <= 1.5) => 
map(

   ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 1102.5) => 
map(

      ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
-0.0032521491
, 

      (v1_hhmiddleagemmbrcnt > 0.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 0) => 
0.0488009252
, 

         (v1_prospecttimeonrecord > 0) => 
map(

            ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 125.5) => 
-0.0074046928
, 

            (v1_prospecttimeonrecord > 125.5) => 
0.0118982487
, 

0.0069895579
)
, 

0.0099619733
)
, 

-0.0002848246
)
, 

   (v1_hhcrtreclienjudgamtttl > 1102.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 92.5) => 
-0.0199907583
, 

      (v1_crtrectimenewest > 92.5) => 
0.0134630302
, 

-0.0131089195
)
, 

-0.0020302428
)
, 

(v1_prospectcollegetier > 1.5) => 
0.0160401728
, 

-0.0011444567
)
;


// Tree: 180

b4_tree_180 := 
map(

( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 0.5) => 
map(

   ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

      ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 268329) => 
map(

         ( NULL < v1_prospectcollegetier and v1_prospectcollegetier <= 0.5) => 
-0.0003877766
, 

         (v1_prospectcollegetier > 0.5) => 
0.0276462843
, 

0.0006701420
)
, 

      (v1_raapropowneravmmed > 268329) => 
0.0241777580
, 

0.0024753847
)
, 

   (v1_resinputownershipindex > 0.5) => 
-0.0076460205
, 

-0.0028313941
)
, 

(v1_rescurrbusinesscnt > 0.5) => 
map(

   ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 0.5) => 
0.0319379421
, 

   (v1_rescurrownershipindex > 0.5) => 
map(

      ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 2.5) => 
-0.0078386848
, 

      (v1_rescurrownershipindex > 2.5) => 
0.0108540576
, 

0.0028183679
)
, 

0.0074593626
)
, 

-0.0010178748
)
;


// Tree: 184

b4_tree_184 := 
map(

( NULL < v1_lifeevnamechange and v1_lifeevnamechange <= 0.5) => 
map(

   ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 2.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 113.5) => 
map(

         ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
-0.0015060150
, 

         (v1_hhseniormmbrcnt > 0.5) => 
map(

            ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
map(

               ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 5.5) => 
0.0917330718
, 

               (v1_prospecttimelastupdate > 5.5) => 
0.0183357841
, 

0.0462219900
)
, 

            (v1_hhpropcurrownermmbrcnt > 0.5) => 
0.0034932141
, 

0.0144906398
)
, 

-0.0004156979
)
, 

      (v1_prospecttimelastupdate > 113.5) => 
-0.0161106652
, 

-0.0011046337
)
, 

   (v1_hhcrtrecmmbrcnt > 2.5) => 
-0.0226214246
, 

-0.0018360106
)
, 

(v1_lifeevnamechange > 0.5) => 
0.0120101175
, 

-0.0007426982
)
;


// Tree: 188

b4_tree_188 := 
map(

( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 1.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 231.5) => 
map(

      ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 50.5) => 
map(

            ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
-0.0080947834
, 

            (v1_hhmiddleagemmbrcnt > 0.5) => 
0.0083083682
, 

-0.0051990686
)
, 

         (v1_hhcrtreclienjudgamtttl > 50.5) => 
-0.0179187963
, 

-0.0066688236
)
, 

      (v1_hhyoungadultmmbrcnt > 0.5) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 0.5) => 
0.0258451667
, 

         (v1_prospecttimelastupdate > 0.5) => 
0.0000971884
, 

0.0079391965
)
, 

-0.0044936324
)
, 

   (v1_prospecttimeonrecord > 231.5) => 
0.0107274644
, 

-0.0030908009
)
, 

(v1_hhelderlymmbrcnt > 1.5) => 
-0.0345377279
, 

-0.0033820420
)
;


// Tree: 192

b4_tree_192 := 
map(

( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.215) => 
map(

   ( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 0.5) => 
map(

      ( NULL < v1_hhcrtrecfelonymmbrcnt and v1_hhcrtrecfelonymmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
-0.0026417965
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
0.0107499921
, 

-0.0011945374
)
, 

      (v1_hhcrtrecfelonymmbrcnt > 0.5) => 
-0.0371353408
, 

-0.0024023057
)
, 

   (v1_rescurrbusinesscnt > 0.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
-0.0535639763
, 

      (v1_lifeeveverresidedcnt > 0.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 39.5) => 
-0.0184248369
, 

         (v1_prospecttimeonrecord > 39.5) => 
0.0115636950
, 

0.0090915728
)
, 

0.0079456118
)
, 

-0.0007675515
)
, 

(v1_rescurravmratiodiff12mo > 1.215) => 
-0.0125124820
, 

-0.0015058398
)
;


// Tree: 196

b4_tree_196 := 
map(

( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 65.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 4.5) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 127794.5) => 
map(

         ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 1082.5) => 
map(

            ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 0) => 
-0.0005041938
, 

            (v1_occbusinessassociationtime > 0) => 
0.0187889580
, 

0.0004949872
)
, 

         (v1_hhcrtreclienjudgamtttl > 1082.5) => 
-0.0161250240
, 

-0.0013646841
)
, 

      (v1_propcurrownedassessedttl > 127794.5) => 
0.0121734939
, 

-0.0001818522
)
, 

   (v1_crtrecbkrpttimenewest > 4.5) => 
map(

      ( NULL < v1_propcurrowner and v1_propcurrowner <= 0.5) => 
-0.0024062245
, 

      (v1_propcurrowner > 0.5) => 
-0.0728282565
, 

-0.0324610266
)
, 

-0.0009417303
)
, 

(v1_crtrecbkrpttimenewest > 65.5) => 
0.0172054541
, 

-0.0001717690
)
;


// Tree: 200

b4_tree_200 := 
map(

( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 2.5) => 
map(

   ( NULL < v1_hhcrtrecbkrptmmbrcnt24mo and v1_hhcrtrecbkrptmmbrcnt24mo <= 1.5) => 
map(

      ( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 49663) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 66.5) => 
map(

            ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 70.5) => 
map(

               ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 0) => 
0.0025454740
, 

               (v1_crtrectimenewest > 0) => 
-0.0139959339
, 

-0.0011258868
)
, 

            (v1_crtrectimenewest > 70.5) => 
0.0169249775
, 

0.0000467469
)
, 

         (v1_prospecttimelastupdate > 66.5) => 
-0.0108705999
, 

-0.0012483824
)
, 

      (v1_resinputmortgageamount > 49663) => 
0.0109302022
, 

-0.0005367457
)
, 

   (v1_hhcrtrecbkrptmmbrcnt24mo > 1.5) => 
-0.0608228409
, 

-0.0007633265
)
, 

(v1_raacollege4yrattendedmmbrcnt > 2.5) => 
0.0170516232
, 

-0.0001636094
)
;


// Tree: 204

b4_tree_204 := 
map(

( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.215) => 
map(

   ( NULL < v1_lifeevnamechange and v1_lifeevnamechange <= 0.5) => 
map(

      ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 417850.5) => 
map(

         ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 0.5) => 
0.0013174978
, 

         (v1_raacrtrecevictionmmbrcnt > 0.5) => 
map(

            ( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 1.5) => 
map(

               ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 304928.5) => 
-0.0127179459
, 

               (v1_propcurrownedassessedttl > 304928.5) => 
0.0455979707
, 

-0.0120619897
)
, 

            (v1_prospectcollegeprogramtype > 1.5) => 
0.0230482626
, 

-0.0107615166
)
, 

-0.0021505940
)
, 

      (v1_raapropowneravmhighest > 417850.5) => 
0.0093364948
, 

-0.0009712956
)
, 

   (v1_lifeevnamechange > 0.5) => 
0.0133685586
, 

0.0000365233
)
, 

(v1_rescurravmratiodiff12mo > 1.215) => 
-0.0117183430
, 

-0.0006937087
)
;


// Tree: 208

b4_tree_208 := 
map(

( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 1.5) => 
map(

   ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 4.5) => 
map(

      ( NULL < v1_raaelderlymmbrcnt and v1_raaelderlymmbrcnt <= 0.5) => 
map(

         ( NULL < v1_donotmail and v1_donotmail <= -0.5) => 
0.3828973906
, 

         (v1_donotmail > -0.5) => 
map(

            ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 1.115) => 
map(

               ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
-0.0035067604
, 

               (v1_hhyoungadultmmbrcnt > 0.5) => 
0.0079020975
, 

-0.0020899829
)
, 

            (v1_rescurravmratiodiff60mo > 1.115) => 
-0.0176222430
, 

-0.0025676553
)
, 

-0.0024063704
)
, 

      (v1_raaelderlymmbrcnt > 0.5) => 
0.0075319128
, 

-0.0005045553
)
, 

   (v1_crtrecseverityindex > 4.5) => 
-0.0474354590
, 

-0.0016723416
)
, 

(v1_hhelderlymmbrcnt > 1.5) => 
-0.0307491805
, 

-0.0019417498
)
;


// Tree: 212

b4_tree_212 := 
map(

(v1_resinputdwelltype in ['0','F','G','P','U']) => 
-0.0230298143
, 

(v1_resinputdwelltype in ['-1','H','R','S']) => 
map(

   ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 2.5) => 
-0.0056191368
, 

      (v1_raammbrcnt > 2.5) => 
map(

         ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 49168.5) => 
map(

            ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 0.5) => 
0.0185878243
, 

            (v1_raacrtrecevictionmmbrcnt > 0.5) => 
-0.0009631775
, 

0.0088047224
)
, 

         (v1_resinputavmvalue > 49168.5) => 
0.0359869116
, 

0.0114577212
)
, 

0.0047522899
)
, 

   (v1_resinputownershipindex > 0.5) => 
map(

      ( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 44550) => 
-0.0053606420
, 

      (v1_resinputmortgageamount > 44550) => 
0.0106455118
, 

-0.0036551575
)
, 

-0.0002255324
)
, 

-0.0013255129
)
;


// Tree: 216

b4_tree_216 := 
map(

( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 228.5) => 
map(

   ( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.095) => 
map(

      ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 296229) => 
map(

         ( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 0.5) => 
-0.0030526001
, 

         (v1_occproflicensecategory > 0.5) => 
0.0228973791
, 

-0.0025993327
)
, 

      (v1_raapropowneravmhighest > 296229) => 
0.0085051245
, 

-0.0008072251
)
, 

   (v1_rescurravmratiodiff12mo > 1.095) => 
map(

      ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 0.5) => 
0.0266640029
, 

      (v1_rescurrownershipindex > 0.5) => 
-0.0128074300
, 

-0.0094380962
)
, 

-0.0016401062
)
, 

(v1_prospecttimeonrecord > 228.5) => 
map(

   ( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 0.5) => 
0.0130811876
, 

   (v1_hhelderlymmbrcnt > 0.5) => 
-0.0122298596
, 

0.0096530409
)
, 

-0.0005155949
)
;


// Tree: 220

b4_tree_220 := 
map(

( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 1.5) => 
map(

   ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
0.0012207221
, 

   (v1_raacrtrecfelonymmbrcnt > 0.5) => 
-0.0105275048
, 

-0.0007552160
)
, 

(v1_prospectcollegeprogramtype > 1.5) => 
map(

   ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
map(

         ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 0.845) => 
0.0397616404
, 

         (v1_rescurravmcntyratio > 0.845) => 
-0.0076890087
, 

0.0244513669
)
, 

      (v1_prospectcollegeattending > 0.5) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
-0.0363120823
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
0.0318818652
, 

-0.0201965972
)
, 

0.0027144515
)
, 

   (v1_hhcrtrecmmbrcnt > 0.5) => 
0.0350729961
, 

0.0155130309
)
, 

-0.0001274740
)
;


// Tree: 224

b4_tree_224 := 
map(

( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 1.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 6.5) => 
map(

      ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

            ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
-0.0063232273
, 

            (v1_hhmiddleagemmbrcnt > 0.5) => 
0.0202663132
, 

-0.0046645568
)
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
0.0237062702
, 

-0.0029471707
)
, 

      (v1_hhseniormmbrcnt > 0.5) => 
0.0371134627
, 

-0.0021101578
)
, 

   (v1_prospecttimelastupdate > 6.5) => 
-0.0108632186
, 

-0.0041320794
)
, 

(v1_verifiedcurrresmatchindex > 1.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 32.5) => 
-0.0225232015
, 

   (v1_prospecttimeonrecord > 32.5) => 
0.0074981313
, 

0.0045650126
)
, 

-0.0020557612
)
;


// Tree: 228

b4_tree_228 := 
map(

(v1_resinputdwelltype in ['0','G','P']) => 
-0.0208058659
, 

(v1_resinputdwelltype in ['-1','F','H','R','S','U']) => 
map(

   ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
0.0067610418
, 

   (v1_resinputownershipindex > 0.5) => 
map(

      ( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 72756.5) => 
map(

         ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 141383.5) => 
-0.0070635936
, 

         (v1_propcurrownedassessedttl > 141383.5) => 
0.0081468203
, 

-0.0056338370
)
, 

      (v1_resinputmortgageamount > 72756.5) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 56.5) => 
map(

            ( NULL < v1_hhcrtrecbkrptmmbrcnt and v1_hhcrtrecbkrptmmbrcnt <= 1.5) => 
0.0067075416
, 

            (v1_hhcrtrecbkrptmmbrcnt > 1.5) => 
-0.0644189488
, 

0.0038351010
)
, 

         (v1_crtrectimenewest > 56.5) => 
0.0327975684
, 

0.0094841661
)
, 

-0.0041375070
)
, 

0.0003385816
)
, 

-0.0005999334
)
;


// Tree: 232

b4_tree_232 := 
map(

( NULL < v1_raaelderlymmbrcnt and v1_raaelderlymmbrcnt <= 0.5) => 
map(

   ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
map(

      ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 1.5) => 
-0.0026351384
, 

      (v1_raayoungadultmmbrcnt > 1.5) => 
0.0090000350
, 

-0.0007273959
)
, 

   (v1_raacrtrecfelonymmbrcnt > 0.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 52.5) => 
-0.0151358569
, 

      (v1_crtrecbkrpttimenewest > 52.5) => 
0.0222249225
, 

-0.0124526429
)
, 

-0.0023493787
)
, 

(v1_raaelderlymmbrcnt > 0.5) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 0) => 
0.0119728086
, 

   (v1_crtrectimenewest > 0) => 
map(

      ( NULL < v1_prospectcollegeattended and v1_prospectcollegeattended <= 0.5) => 
-0.0054427694
, 

      (v1_prospectcollegeattended > 0.5) => 
0.0218732839
, 

-0.0010238847
)
, 

0.0061255934
)
, 

-0.0007042072
)
;


// Tree: 236

b4_tree_236 := 
map(

( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 2.5) => 
map(

   ( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 1.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 272.5) => 
map(

         ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 10104.5) => 
map(

            ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 1.5) => 
-0.0016372307
, 

            (v1_hhyoungadultmmbrcnt > 1.5) => 
0.0178781553
, 

-0.0011417915
)
, 

         (v1_hhcrtreclienjudgamtttl > 10104.5) => 
-0.0172978488
, 

-0.0018645317
)
, 

      (v1_lifeevtimelastmove > 272.5) => 
0.0102145160
, 

-0.0010098576
)
, 

   (v1_hhelderlymmbrcnt > 1.5) => 
-0.0275487757
, 

-0.0012542423
)
, 

(v1_occproflicensecategory > 2.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 37.5) => 
0.0819849778
, 

   (v1_prospecttimeonrecord > 37.5) => 
0.0150050338
, 

0.0235645798
)
, 

-0.0009180218
)
;


// Tree: 240

b4_tree_240 := 
map(

( NULL < v1_raacollegetoptiermmbrcnt and v1_raacollegetoptiermmbrcnt <= 0.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 551.5) => 
map(

      ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 0.5) => 
map(

         ( NULL < v1_donotmail and v1_donotmail <= -0.5) => 
0.2254397481
, 

         (v1_donotmail > -0.5) => 
-0.0044108299
, 

-0.0042791667
)
, 

      (v1_resinputbusinesscnt > 0.5) => 
map(

         ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 201.5) => 
map(

            ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
-0.0020177142
, 

            (v1_hhyoungadultmmbrcnt > 0.5) => 
0.0121993783
, 

0.0000726623
)
, 

         (v1_lifeevtimelastmove > 201.5) => 
0.0150964022
, 

0.0023068041
)
, 

-0.0019984264
)
, 

   (v1_prospecttimeonrecord > 551.5) => 
-0.0610049937
, 

-0.0021041407
)
, 

(v1_raacollegetoptiermmbrcnt > 0.5) => 
0.0106872552
, 

-0.0013274295
)
;


// Tree: 244

b4_tree_244 := 
map(

( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 1.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 0.5) => 
map(

      ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

            ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
map(

               ( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 1.5) => 
-0.0061815370
, 

               (v1_occproflicensecategory > 1.5) => 
0.0954959210
, 

-0.0058491732
)
, 

            (v1_hhseniormmbrcnt > 0.5) => 
0.0305627567
, 

-0.0048578338
)
, 

         (v1_hhmiddleagemmbrcnt > 0.5) => 
0.0194181837
, 

-0.0032875308
)
, 

      (v1_hhyoungadultmmbrcnt > 0.5) => 
0.0197496069
, 

-0.0017408151
)
, 

   (v1_prospecttimelastupdate > 0.5) => 
-0.0061140385
, 

-0.0031835481
)
, 

(v1_hhmiddleagemmbrcnt > 1.5) => 
0.0075268848
, 

-0.0020280243
)
;


// Tree: 248

b4_tree_248 := 
map(

( NULL < v1_lifeevnamechange and v1_lifeevnamechange <= 0.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 82.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 92.5) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 0) => 
map(

            ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
-0.0022447082
, 

            (v1_hhmiddleagemmbrcnt > 0.5) => 
0.0105469942
, 

-0.0003307203
)
, 

         (v1_crtrectimenewest > 0) => 
map(

            ( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 1.5) => 
-0.0161736261
, 

            (v1_prospectcollegeprogramtype > 1.5) => 
0.0293260742
, 

-0.0142671628
)
, 

-0.0034736430
)
, 

      (v1_crtrectimenewest > 92.5) => 
0.0156259099
, 

-0.0024823707
)
, 

   (v1_prospecttimelastupdate > 82.5) => 
-0.0109925021
, 

-0.0032216473
)
, 

(v1_lifeevnamechange > 0.5) => 
0.0082715235
, 

-0.0023077277
)
;


// Tree: 252

b4_tree_252 := 
map(

( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 1.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 23.5) => 
map(

      ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 0) => 
-0.0022234547
, 

      (v1_occbusinessassociationtime > 0) => 
0.0197874451
, 

-0.0012387934
)
, 

   (v1_prospecttimelastupdate > 23.5) => 
-0.0097470462
, 

-0.0028022269
)
, 

(v1_verifiedcurrresmatchindex > 1.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 21.5) => 
map(

      ( NULL < v1_proppurchasecnt12mo and v1_proppurchasecnt12mo <= 0.5) => 
-0.0157279977
, 

      (v1_proppurchasecnt12mo > 0.5) => 
-0.0622336809
, 

-0.0229603018
)
, 

   (v1_prospecttimeonrecord > 21.5) => 
map(

      ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 1.5) => 
0.0121982352
, 

      (v1_hhpropcurrownermmbrcnt > 1.5) => 
-0.0014832587
, 

0.0061032079
)
, 

0.0042382147
)
, 

-0.0011281744
)
;


// Tree: 256

b4_tree_256 := 
map(

( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 53.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 4.5) => 
map(

      ( NULL < v1_hhcrtrecevictionmmbrcnt and v1_hhcrtrecevictionmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_crtreccnt and v1_crtreccnt <= 7.5) => 
0.0018370315
, 

         (v1_crtreccnt > 7.5) => 
-0.0335588682
, 

0.0009345832
)
, 

      (v1_hhcrtrecevictionmmbrcnt > 0.5) => 
-0.0164745071
, 

-0.0002795696
)
, 

   (v1_crtrecbkrpttimenewest > 4.5) => 
map(

      ( NULL < v1_propcurrowner and v1_propcurrowner <= 0.5) => 
-0.0041973690
, 

      (v1_propcurrowner > 0.5) => 
map(

         ( NULL < v1_crtreccnt and v1_crtreccnt <= 3.5) => 
-0.0851717185
, 

         (v1_crtreccnt > 3.5) => 
-0.0340543034
, 

-0.0666181781
)
, 

-0.0309852466
)
, 

-0.0008888715
)
, 

(v1_crtrecbkrpttimenewest > 53.5) => 
0.0130407021
, 

-0.0002536190
)
;


// Tree: 260

b4_tree_260 := 
map(

( NULL < v1_donotmail and v1_donotmail <= -0.5) => 
0.2493962881
, 

(v1_donotmail > -0.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 60.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 60.5) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 3.5) => 
0.0024884841
, 

         (v1_crtrectimenewest > 3.5) => 
map(

            ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 1.5) => 
map(

               ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 85645.5) => 
-0.0337767202
, 

               (v1_propcurrownedavmttl > 85645.5) => 
-0.0959988125
, 

-0.0490962075
)
, 

            (v1_crtrecseverityindex > 1.5) => 
-0.0076009264
, 

-0.0098035001
)
, 

0.0000913348
)
, 

      (v1_crtrectimenewest > 60.5) => 
0.0161050878
, 

0.0013956170
)
, 

   (v1_prospecttimelastupdate > 60.5) => 
-0.0075321241
, 

0.0002113325
)
, 

0.0002927839
)
;


// Tree: 264

b4_tree_264 := 
map(

( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

   ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 36147) => 
map(

      ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 279481.5) => 
0.0012390378
, 

      (v1_raapropowneravmmed > 279481.5) => 
0.0173698364
, 

0.0025332863
)
, 

   (v1_resinputavmvalue12mo > 36147) => 
0.0222309984
, 

0.0040117895
)
, 

(v1_resinputownershipindex > 0.5) => 
map(

   ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 2.5) => 
-0.0075797378
, 

   (v1_resinputownershipindex > 2.5) => 
map(

      ( NULL < v1_hhcrtrecbkrptmmbrcnt and v1_hhcrtrecbkrptmmbrcnt <= 1.5) => 
0.0040773376
, 

      (v1_hhcrtrecbkrptmmbrcnt > 1.5) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 66.5) => 
-0.0528064742
, 

         (v1_crtrecbkrpttimenewest > 66.5) => 
0.0071490936
, 

-0.0242498196
)
, 

0.0025541671
)
, 

-0.0045531838
)
, 

-0.0008007284
)
;


// Tree: 268

b4_tree_268 := 
map(

( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 2.5) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 70.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 6.5) => 
map(

         ( NULL < v1_raahhcnt and v1_raahhcnt <= 4.5) => 
-0.0019886765
, 

         (v1_raahhcnt > 4.5) => 
0.0084896225
, 

0.0007052663
)
, 

      (v1_crtrectimenewest > 6.5) => 
map(

         ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 1.5) => 
-0.0447188526
, 

         (v1_crtrecseverityindex > 1.5) => 
-0.0065838944
, 

-0.0088792811
)
, 

-0.0009434400
)
, 

   (v1_crtrectimenewest > 70.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 45.5) => 
0.0213033272
, 

      (v1_prospecttimelastupdate > 45.5) => 
-0.0007508967
, 

0.0088655669
)
, 

0.0001883103
)
, 

(v1_raacrtrecfelonymmbrcnt > 2.5) => 
-0.0251023821
, 

-0.0006107116
)
;


// Tree: 272

b4_tree_272 := 
map(

( NULL < v1_propcurrownedcnt and v1_propcurrownedcnt <= 4.5) => 
map(

   ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 1.415) => 
map(

      ( NULL < v1_raaseniormmbrcnt and v1_raaseniormmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 2.5) => 
-0.0027656029
, 

         (v1_raacollege4yrattendedmmbrcnt > 2.5) => 
0.0191603983
, 

-0.0023849033
)
, 

      (v1_raaseniormmbrcnt > 0.5) => 
map(

         ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 3.5) => 
map(

            ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 1.835) => 
0.0098773344
, 

            (v1_resinputavmblockratio > 1.835) => 
-0.0239380023
, 

0.0087861601
)
, 

         (v1_raacrtrecmsdmeanmmbrcnt > 3.5) => 
-0.0026560794
, 

0.0043932728
)
, 

-0.0003246351
)
, 

   (v1_rescurravmratiodiff60mo > 1.415) => 
-0.0249937866
, 

-0.0005637858
)
, 

(v1_propcurrownedcnt > 4.5) => 
0.0472113521
, 

-0.0004386625
)
;


// Tree: 276

b4_tree_276 := 
map(

( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 227.5) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 8.5) => 
map(

      ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
-0.0042040448
, 

         (v1_hhseniormmbrcnt > 0.5) => 
map(

            ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 11.5) => 
0.0490493470
, 

            (v1_prospecttimeonrecord > 11.5) => 
0.0055687912
, 

0.0107447801
)
, 

-0.0032790621
)
, 

      (v1_hhyoungadultmmbrcnt > 0.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 1.5) => 
-0.0307384932
, 

         (v1_raammbrcnt > 1.5) => 
0.0085500203
, 

0.0064602717
)
, 

-0.0018712992
)
, 

   (v1_hhcnt > 8.5) => 
-0.0205653206
, 

-0.0021781092
)
, 

(v1_prospecttimeonrecord > 227.5) => 
0.0068246313
, 

-0.0012705110
)
;


// Tree: 280

b4_tree_280 := 
map(

( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 7.5) => 
map(

   ( NULL < v1_raaelderlymmbrcnt and v1_raaelderlymmbrcnt <= 1.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 64.5) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 70.5) => 
map(

            ( NULL < v1_lifeevnamechangecnt12mo and v1_lifeevnamechangecnt12mo <= 0.5) => 
map(

               ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
-0.0014908642
, 

               (v1_hhyoungadultmmbrcnt > 0.5) => 
0.0086055904
, 

-0.0003142937
)
, 

            (v1_lifeevnamechangecnt12mo > 0.5) => 
-0.0232719937
, 

-0.0007887253
)
, 

         (v1_crtrectimenewest > 70.5) => 
0.0123379146
, 

0.0000855585
)
, 

      (v1_prospecttimelastupdate > 64.5) => 
-0.0073998273
, 

-0.0008319679
)
, 

   (v1_raaelderlymmbrcnt > 1.5) => 
0.0096282064
, 

-0.0001140870
)
, 

(v1_crtrecmsdmeancnt > 7.5) => 
-0.0343870800
, 

-0.0008350807
)
;


// Tree: 284

b4_tree_284 := 
map(

( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 553.5) => 
map(

   ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 281.5) => 
map(

      ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

         (v1_resinputdwelltype in ['0','F','G','H','P','U']) => 
-0.0044998223
, 

         (v1_resinputdwelltype in ['-1','R','S']) => 
map(

            ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
0.0050841575
, 

            (v1_hhcnt > 1.5) => 
0.0169972256
, 

0.0081788718
)
, 

0.0019635058
)
, 

      (v1_resinputownershipindex > 0.5) => 
-0.0041680051
, 

-0.0013934627
)
, 

   (v1_lifeevtimelastmove > 281.5) => 
map(

      ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
0.0260474303
, 

      (v1_lifeevtimefirstassetpurchase > -0.5) => 
0.0020303476
, 

0.0095641302
)
, 

-0.0006335975
)
, 

(v1_prospecttimeonrecord > 553.5) => 
-0.0489516253
, 

-0.0007269952
)
;


// Tree: 288

b4_tree_288 := 
map(

( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 1.085) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 1.5) => 
map(

      ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 38.5) => 
-0.0003187467
, 

         (v1_prospecttimelastupdate > 38.5) => 
-0.0101697261
, 

-0.0017523674
)
, 

      (v1_hhyoungadultmmbrcnt > 0.5) => 
map(

         ( NULL < v1_prospectcollegeattended and v1_prospectcollegeattended <= 0.5) => 
0.0001592495
, 

         (v1_prospectcollegeattended > 0.5) => 
0.0175608174
, 

0.0063336237
)
, 

-0.0006207422
)
, 

   (v1_hhmiddleagemmbrcnt > 1.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 152.5) => 
-0.0038936779
, 

      (v1_prospecttimeonrecord > 152.5) => 
0.0143686765
, 

0.0084821909
)
, 

0.0002934743
)
, 

(v1_rescurravmratiodiff60mo > 1.085) => 
-0.0121632403
, 

-0.0002311772
)
;


// Tree: 292

b4_tree_292 := 
map(

( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 3.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 553.5) => 
map(

      ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 0.5) => 
map(

         ( NULL < v1_prospectcollegetier and v1_prospectcollegetier <= 1.5) => 
-0.0035508082
, 

         (v1_prospectcollegetier > 1.5) => 
0.0110854268
, 

-0.0028863620
)
, 

      (v1_resinputbusinesscnt > 0.5) => 
map(

         ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 223.5) => 
map(

            ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 0.695) => 
0.0090070788
, 

            (v1_resinputavmtractratio > 0.695) => 
-0.0036069807
, 

0.0027891406
)
, 

         (v1_lifeevtimelastmove > 223.5) => 
0.0141121714
, 

0.0042102706
)
, 

-0.0003885467
)
, 

   (v1_prospecttimeonrecord > 553.5) => 
-0.0488302810
, 

-0.0004824575
)
, 

(v1_hhcrtrecmmbrcnt > 3.5) => 
-0.0272491689
, 

-0.0008391252
)
;


// Tree: 296

b4_tree_296 := 
map(

(v1_resinputdwelltype in ['0','F','G','P']) => 
-0.0172768110
, 

(v1_resinputdwelltype in ['-1','H','R','S','U']) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 177.5) => 
map(

      ( NULL < v1_donotmail and v1_donotmail <= -0.5) => 
0.1484212962
, 

      (v1_donotmail > -0.5) => 
map(

         ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 287.5) => 
map(

            ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
0.0047789705
, 

            (v1_resinputownershipindex > 0.5) => 
-0.0031715990
, 

0.0002084777
)
, 

         (v1_lifeevtimelastmove > 287.5) => 
map(

            ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 506.5) => 
0.0110501248
, 

            (v1_lifeevtimelastmove > 506.5) => 
-0.0213479149
, 

0.0081566141
)
, 

0.0007319585
)
, 

0.0007851276
)
, 

   (v1_crtrecbkrpttimenewest > 177.5) => 
0.0238508084
, 

0.0010533287
)
, 

0.0001856569
)
;


// Tree: 300

b4_tree_300 := 
map(

( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.165) => 
map(

   ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 0.5) => 
-0.0025891971
, 

   (v1_raayoungadultmmbrcnt > 0.5) => 
map(

      ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 275989) => 
map(

         ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 0.5) => 
map(

            ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 292461.5) => 
0.0082566950
, 

            (v1_raapropowneravmmed > 292461.5) => 
0.0391951404
, 

0.0123057113
)
, 

         (v1_raacrtrecmsdmeanmmbrcnt > 0.5) => 
0.0000439067
, 

0.0024147943
)
, 

      (v1_resinputavmvalue60mo > 275989) => 
0.0204611661
, 

0.0040549381
)
, 

0.0001555706
)
, 

(v1_rescurravmratiodiff12mo > 1.165) => 
map(

   ( NULL < v1_prospectcollegeattended and v1_prospectcollegeattended <= 0.5) => 
-0.0109730659
, 

   (v1_prospectcollegeattended > 0.5) => 
0.0148320604
, 

-0.0078367546
)
, 

-0.0004826440
)
;


// Tree: 304

b4_tree_304 := 
map(

( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 2.5) => 
map(

   ( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 0.5) => 
-0.0009324595
, 

   (v1_hhcollegeattendedmmbrcnt > 0.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 45.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 32.5) => 
map(

            (v1_resinputdwelltype in ['-1','0','P','R','S','U']) => 
-0.0144584687
, 

            (v1_resinputdwelltype in ['F','G','H']) => 
0.0234343910
, 

-0.0063048160
)
, 

         (v1_prospecttimeonrecord > 32.5) => 
0.0085191324
, 

0.0012778211
)
, 

      (v1_crtrectimenewest > 45.5) => 
map(

         ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
0.0164920200
, 

         (v1_prospectcollegeattending > 0.5) => 
0.0783452848
, 

0.0206492656
)
, 

0.0048266727
)
, 

0.0002129239
)
, 

(v1_hhcrtrecmmbrcnt > 2.5) => 
-0.0130125341
, 

-0.0002847573
)
;


// Tree: 308

b4_tree_308 := 
map(

( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 271.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 103.5) => 
map(

      ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 2.5) => 
map(

         ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 5084.5) => 
0.0004735958
, 

         (v1_crtreclienjudgamtttl > 5084.5) => 
-0.0155009003
, 

-0.0002290126
)
, 

      (v1_raacollege4yrattendedmmbrcnt > 2.5) => 
0.0139412779
, 

0.0002335944
)
, 

   (v1_prospecttimelastupdate > 103.5) => 
-0.0113061927
, 

-0.0002932992
)
, 

(v1_lifeevtimelastmove > 271.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 278.5) => 
map(

      ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
0.0229434286
, 

      (v1_lifeevtimefirstassetpurchase > -0.5) => 
0.0039271703
, 

0.0099293982
)
, 

   (v1_prospecttimelastupdate > 278.5) => 
-0.0380419203
, 

0.0083116456
)
, 

0.0003626175
)
;


// Tree: 312

b4_tree_312 := 
map(

( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 213.5) => 
map(

   ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 5000.5) => 
map(

      ( NULL < v1_lifeevnamechangecnt12mo and v1_lifeevnamechangecnt12mo <= 0.5) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
-0.0014076147
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
0.0073938470
, 

-0.0001968840
)
, 

      (v1_lifeevnamechangecnt12mo > 0.5) => 
map(

         ( NULL < v1_propcurrowner and v1_propcurrowner <= 0.5) => 
-0.0024971562
, 

         (v1_propcurrowner > 0.5) => 
-0.0391287341
, 

-0.0158056486
)
, 

-0.0004849882
)
, 

   (v1_crtreclienjudgamtttl > 5000.5) => 
-0.0170606559
, 

-0.0011238449
)
, 

(v1_prospecttimeonrecord > 213.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 525.5) => 
0.0079806979
, 

   (v1_prospecttimeonrecord > 525.5) => 
-0.0321911040
, 

0.0070674617
)
, 

-0.0001205417
)
;


// Tree: 316

b4_tree_316 := 
map(

( NULL < v1_raacollegetoptiermmbrcnt and v1_raacollegetoptiermmbrcnt <= 0.5) => 
map(

   ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 1.5) => 
map(

      ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 0.5) => 
-0.0003216238
, 

      (v1_raayoungadultmmbrcnt > 0.5) => 
0.0082508529
, 

0.0016870286
)
, 

   (v1_raacrtrecmsdmeanmmbrcnt > 1.5) => 
map(

      ( NULL < v1_prospectcollegetier and v1_prospectcollegetier <= 2.5) => 
map(

         ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 121015) => 
-0.0091034937
, 

         (v1_resinputavmvalue12mo > 121015) => 
0.0052002412
, 

-0.0061296529
)
, 

      (v1_prospectcollegetier > 2.5) => 
map(

         ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 13.5) => 
0.0075856669
, 

         (v1_raacrtrecmmbrcnt > 13.5) => 
0.0525213472
, 

0.0134866035
)
, 

-0.0050325358
)
, 

-0.0007213840
)
, 

(v1_raacollegetoptiermmbrcnt > 0.5) => 
0.0093213121
, 

-0.0001159546
)
;


// Tree: 320

b4_tree_320 := 
map(

( NULL < v1_prospectdeceased and v1_prospectdeceased <= 0.5) => 
map(

   ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 4.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 216.5) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 6.5) => 
-0.0000724066
, 

         (v1_hhcnt > 6.5) => 
-0.0147455244
, 

-0.0005579407
)
, 

      (v1_lifeevtimelastmove > 216.5) => 
map(

         ( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 1.5) => 
map(

            ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 21345) => 
0.0128343095
, 

            (v1_raapropowneravmhighest > 21345) => 
-0.0015694048
, 

0.0028307203
)
, 

         (v1_rescurrbusinesscnt > 1.5) => 
0.0186247348
, 

0.0059763278
)
, 

0.0002452197
)
, 

   (v1_crtrecseverityindex > 4.5) => 
-0.0372063060
, 

-0.0006747994
)
, 

(v1_prospectdeceased > 0.5) => 
-0.1036497009
, 

-0.0007670515
)
;


// Tree: 324

b4_tree_324 := 
map(

( NULL < v1_propeverownedcnt and v1_propeverownedcnt <= 2.5) => 
map(

   ( NULL < v1_interestsportperson and v1_interestsportperson <= 0.5) => 
map(

      ( NULL < v1_donotmail and v1_donotmail <= 0.5) => 
map(

         ( NULL < v1_crtrecfelonycnt and v1_crtrecfelonycnt <= 0.5) => 
map(

            ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
0.0001513534
, 

            (v1_hhseniormmbrcnt > 0.5) => 
0.0069860795
, 

0.0007397426
)
, 

         (v1_crtrecfelonycnt > 0.5) => 
-0.0339319601
, 

-0.0001393049
)
, 

      (v1_donotmail > 0.5) => 
map(

         ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 0.74) => 
0.0880826581
, 

         (v1_rescurravmcntyratio > 0.74) => 
-0.0005428273
, 

0.0452270075
)
, 

-0.0000405933
)
, 

   (v1_interestsportperson > 0.5) => 
-0.0179690678
, 

-0.0003478457
)
, 

(v1_propeverownedcnt > 2.5) => 
0.0140231020
, 

0.0000033611
)
;


// Tree: 328

b4_tree_328 := 
map(

( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 1.5) => 
map(

   ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 1.5) => 
map(

      ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 4.5) => 
-0.0027673638
, 

      (v1_raammbrcnt > 4.5) => 
0.0070286764
, 

0.0005024181
)
, 

   (v1_raacrtrecmsdmeanmmbrcnt > 1.5) => 
-0.0043726340
, 

-0.0012575185
)
, 

(v1_hhmiddleagemmbrcnt > 1.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
-0.0446710588
, 

   (v1_lifeeveverresidedcnt > 0.5) => 
map(

      ( NULL < v1_hhcrtrecbkrptmmbrcnt and v1_hhcrtrecbkrptmmbrcnt <= 1.5) => 
0.0102772460
, 

      (v1_hhcrtrecbkrptmmbrcnt > 1.5) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 48.5) => 
-0.0313439840
, 

         (v1_crtrecbkrpttimenewest > 48.5) => 
0.0088666130
, 

-0.0091121130
)
, 

0.0073810201
)
, 

0.0055190104
)
, 

-0.0005305164
)
;


// Tree: 332

b4_tree_332 := 
map(

( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 0.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 49.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 5.5) => 
map(

         ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 1.5) => 
map(

            ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 268.5) => 
-0.0000252301
, 

            (v1_lifeevtimelastmove > 268.5) => 
0.0098270932
, 

0.0005710048
)
, 

         (v1_raacrtrecfelonymmbrcnt > 1.5) => 
-0.0158383095
, 

-0.0004637260
)
, 

      (v1_crtrecbkrpttimenewest > 5.5) => 
map(

         ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 116547.5) => 
-0.0135459919
, 

         (v1_propcurrownedavmttl > 116547.5) => 
-0.0723599619
, 

-0.0255767841
)
, 

-0.0009102148
)
, 

   (v1_crtrecbkrpttimenewest > 49.5) => 
0.0111307018
, 

-0.0003578420
)
, 

(v1_hhelderlymmbrcnt > 0.5) => 
-0.0111592228
, 

-0.0007834392
)
;


// Tree: 336

b4_tree_336 := 
map(

( NULL < v1_hhcnt and v1_hhcnt <= 7.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 49.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 5.5) => 
0.0002658334
, 

      (v1_crtrecbkrpttimenewest > 5.5) => 
map(

         ( NULL < v1_propcurrowner and v1_propcurrowner <= 0.5) => 
-0.0060389357
, 

         (v1_propcurrowner > 0.5) => 
-0.0505665006
, 

-0.0251574193
)
, 

-0.0001738253
)
, 

   (v1_crtrecbkrpttimenewest > 49.5) => 
map(

      ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 70.5) => 
0.0041332064
, 

      (v1_crtreclienjudgtimenewest > 70.5) => 
0.0361051251
, 

0.0115789625
)
, 

0.0003592997
)
, 

(v1_hhcnt > 7.5) => 
map(

   ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.305) => 
-0.0179345618
, 

   (v1_resinputavmcntyratio > 1.305) => 
0.0226252715
, 

-0.0127850809
)
, 

-0.0000263263
)
;


// Tree: 340

b4_tree_340 := 
map(

( NULL < v1_donotmail and v1_donotmail <= 0.5) => 
map(

   ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 0.5) => 
-0.0018425061
, 

   (v1_resinputbusinesscnt > 0.5) => 
map(

      ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

         ( NULL < v1_raahhcnt and v1_raahhcnt <= 0.5) => 
-0.0034477435
, 

         (v1_raahhcnt > 0.5) => 
0.0176112537
, 

0.0107997566
)
, 

      (v1_resinputownershipindex > 0.5) => 
map(

         ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 228.5) => 
-0.0009943477
, 

         (v1_lifeevtimelastmove > 228.5) => 
0.0100095712
, 

0.0005018028
)
, 

0.0029369291
)
, 

-0.0001524828
)
, 

(v1_donotmail > 0.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 44) => 
0.1323864385
, 

   (v1_prospecttimeonrecord > 44) => 
0.0150814663
, 

0.0441587599
)
, 

-0.0000471604
)
;


// Tree: 344

b4_tree_344 := 
map(

( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.285) => 
map(

   ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 1.5) => 
map(

      ( NULL < v1_lifeevnamechange and v1_lifeevnamechange <= 0.5) => 
map(

         ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
map(

            ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
0.0023199922
, 

            (v1_prospectcollegeattending > 0.5) => 
map(

               ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 25.5) => 
-0.0238893533
, 

               (v1_crtrectimenewest > 25.5) => 
0.0366351981
, 

-0.0160749170
)
, 

0.0019388480
)
, 

         (v1_raacrtrecfelonymmbrcnt > 0.5) => 
-0.0074590462
, 

0.0004496907
)
, 

      (v1_lifeevnamechange > 0.5) => 
0.0086161662
, 

0.0010545492
)
, 

   (v1_crtrecbkrptcnt > 1.5) => 
-0.0233485943
, 

0.0007248994
)
, 

(v1_resinputavmratiodiff12mo > 1.285) => 
-0.0114227559
, 

-0.0001948859
)
;


// Tree: 348

b4_tree_348 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 52.5) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 51.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 3.5) => 
map(

         ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
-0.0004971197
, 

         (v1_hhmiddleagemmbrcnt > 0.5) => 
map(

            ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 0.5) => 
0.0267763338
, 

            (v1_rescurrownershipindex > 0.5) => 
0.0050442445
, 

0.0098811051
)
, 

0.0011110325
)
, 

      (v1_crtrectimenewest > 3.5) => 
map(

         ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 1.5) => 
-0.0466455021
, 

         (v1_crtrecseverityindex > 1.5) => 
-0.0072790910
, 

-0.0093200480
)
, 

-0.0007676783
)
, 

   (v1_crtrectimenewest > 51.5) => 
0.0109041209
, 

0.0002674423
)
, 

(v1_prospecttimelastupdate > 52.5) => 
-0.0048440807
, 

-0.0005463040
)
;


// Tree: 352

b4_tree_352 := 
map(

( NULL < v1_raacollegeprivatemmbrcnt and v1_raacollegeprivatemmbrcnt <= 0.5) => 
map(

   ( NULL < v1_crtreccnt and v1_crtreccnt <= 8.5) => 
map(

      ( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 520.5) => 
map(

            ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 228.5) => 
map(

               ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 2.5) => 
-0.0020258996
, 

               (v1_hhpropcurrownermmbrcnt > 2.5) => 
-0.0187697942
, 

-0.0022777689
)
, 

            (v1_lifeevtimelastmove > 228.5) => 
0.0059951151
, 

-0.0015237968
)
, 

         (v1_lifeevtimelastmove > 520.5) => 
-0.0301271676
, 

-0.0016558191
)
, 

      (v1_raaoccproflicmmbrcnt > 0.5) => 
0.0045336335
, 

-0.0002646006
)
, 

   (v1_crtreccnt > 8.5) => 
-0.0200068263
, 

-0.0009991838
)
, 

(v1_raacollegeprivatemmbrcnt > 0.5) => 
0.0101644992
, 

-0.0004670929
)
;


// Tree: 356

b4_tree_356 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 51.5) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 69.5) => 
map(

      ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 4982.5) => 
map(

         ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 0) => 
map(

            ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 153.5) => 
-0.0021939538
, 

            (v1_lifeevtimelastmove > 153.5) => 
0.0077177051
, 

-0.0012427025
)
, 

         (v1_occbusinessassociationtime > 0) => 
map(

            ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
0.0338011946
, 

            (v1_lifeeveverresidedcnt > 0.5) => 
0.0039878683
, 

0.0113202573
)
, 

-0.0004703633
)
, 

      (v1_crtreclienjudgamtttl > 4982.5) => 
-0.0172406970
, 

-0.0011541604
)
, 

   (v1_crtrectimenewest > 69.5) => 
0.0109523672
, 

-0.0003282432
)
, 

(v1_prospecttimelastupdate > 51.5) => 
-0.0063444956
, 

-0.0013070459
)
;


// Tree: 360

b4_tree_360 := 
map(

( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 49433.5) => 
map(

   ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

      ( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 0.5) => 
map(

         (v1_resinputdwelltype in ['0','F','G','H','P']) => 
-0.0076720058
, 

         (v1_resinputdwelltype in ['-1','R','S','U']) => 
0.0074080693
, 

0.0000060649
)
, 

      (v1_hhcollegeattendedmmbrcnt > 0.5) => 
0.0128931636
, 

0.0020750347
)
, 

   (v1_resinputownershipindex > 0.5) => 
-0.0040595565
, 

-0.0012219801
)
, 

(v1_rescurrmortgageamount > 49433.5) => 
map(

   ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= 6.5) => 
-0.0508364787
, 

   (v1_lifeevtimefirstassetpurchase > 6.5) => 
map(

      ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 1.5) => 
0.0211201272
, 

      (v1_hhpropcurrownermmbrcnt > 1.5) => 
0.0024965496
, 

0.0093392428
)
, 

0.0073844627
)
, 

-0.0006382240
)
;


// Tree: 364

b4_tree_364 := 
map(

( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 1.5) => 
map(

   ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 0.5) => 
0.0024529886
, 

   (v1_raacrtrecmsdmeanmmbrcnt > 0.5) => 
map(

      ( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 64661.5) => 
map(

         ( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 1.5) => 
-0.0053974225
, 

         (v1_prospectcollegeprogramtype > 1.5) => 
0.0097522756
, 

-0.0047310527
)
, 

      (v1_rescurrmortgageamount > 64661.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 16.5) => 
-0.0486368016
, 

         (v1_prospecttimeonrecord > 16.5) => 
0.0094366727
, 

0.0079699583
)
, 

-0.0037432610
)
, 

-0.0007407655
)
, 

(v1_hhyoungadultmmbrcnt > 1.5) => 
map(

   ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 1.5) => 
-0.0029575298
, 

   (v1_raayoungadultmmbrcnt > 1.5) => 
0.0241361729
, 

0.0116948211
)
, 

-0.0003994699
)
;


// Tree: 368

b4_tree_368 := 
map(

( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 1.445) => 
map(

   ( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.155) => 
map(

      ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 1.5) => 
-0.0002874647
, 

      (v1_raayoungadultmmbrcnt > 1.5) => 
map(

         ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 181806.5) => 
map(

            ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 2.5) => 
0.0169008668
, 

            (v1_raacrtrecmmbrcnt > 2.5) => 
0.0004069927
, 

0.0024484024
)
, 

         (v1_resinputavmvalue > 181806.5) => 
map(

            ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 83237.5) => 
0.0346209052
, 

            (v1_propcurrownedavmttl > 83237.5) => 
0.0034279258
, 

0.0203326550
)
, 

0.0051587167
)
, 

0.0010204902
)
, 

   (v1_rescurravmratiodiff12mo > 1.155) => 
-0.0067060055
, 

0.0004048182
)
, 

(v1_rescurravmratiodiff60mo > 1.445) => 
-0.0281444647
, 

0.0001491692
)
;


// Tree: 372

b4_tree_372 := 
map(

( NULL < v1_hhcnt and v1_hhcnt <= 10.5) => 
map(

   ( NULL < v1_hhteenagermmbrcnt and v1_hhteenagermmbrcnt <= 0.5) => 
map(

      ( NULL < v1_raacollegeprivatemmbrcnt and v1_raacollegeprivatemmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhcollegeprivatemmbrcnt and v1_hhcollegeprivatemmbrcnt <= 0.5) => 
map(

            ( NULL < v1_prospectcollegetier and v1_prospectcollegetier <= 5.5) => 
-0.0017428447
, 

            (v1_prospectcollegetier > 5.5) => 
0.0281038283
, 

-0.0015553492
)
, 

         (v1_hhcollegeprivatemmbrcnt > 0.5) => 
0.0197412008
, 

-0.0013657487
)
, 

      (v1_raacollegeprivatemmbrcnt > 0.5) => 
0.0083240459
, 

-0.0009056398
)
, 

   (v1_hhteenagermmbrcnt > 0.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 224) => 
-0.0912397234
, 

      (v1_prospecttimeonrecord > 224) => 
0.1070370248
, 

-0.0686348824
)
, 

-0.0009902249
)
, 

(v1_hhcnt > 10.5) => 
-0.0269298533
, 

-0.0011976967
)
;


// Tree: 376

b4_tree_376 := 
map(

( NULL < v1_donotmail and v1_donotmail <= -0.5) => 
0.1441466313
, 

(v1_donotmail > -0.5) => 
map(

   ( NULL < v1_raahhcnt and v1_raahhcnt <= 5.5) => 
map(

      ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 1.5) => 
0.0005772543
, 

      (v1_raacrtrecmsdmeanmmbrcnt > 1.5) => 
-0.0088179016
, 

-0.0014357102
)
, 

   (v1_raahhcnt > 5.5) => 
map(

      ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

         ( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 7.5) => 
0.0085554286
, 

         (v1_raaoccproflicmmbrcnt > 7.5) => 
0.0658419867
, 

0.0091332679
)
, 

      (v1_lifeevtimefirstassetpurchase > -0.5) => 
map(

         ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 2.5) => 
-0.0154427585
, 

         (v1_rescurrownershipindex > 2.5) => 
0.0044816660
, 

-0.0020568906
)
, 

0.0048836929
)
, 

0.0003502419
)
, 

0.0003972448
)
;


// Tree: 380

b4_tree_380 := 
map(

( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.435) => 
map(

   ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= 16.5) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 76.5) => 
0.0010064429
, 

      (v1_propcurrownedassessedttl > 76.5) => 
map(

         ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 31878.5) => 
-0.0485953460
, 

         (v1_propcurrownedassessedttl > 31878.5) => 
map(

            (v1_rescurrdwelltype in ['H','S']) => 
map(

               ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 48.5) => 
-0.0420563779
, 

               (v1_prospecttimeonrecord > 48.5) => 
-0.0062637413
, 

-0.0088390362
)
, 

            (v1_rescurrdwelltype in ['-1','F','P','R','U']) => 
0.0154446120
, 

-0.0051234058
)
, 

-0.0104246873
)
, 

-0.0000188016
)
, 

   (v1_lifeevtimefirstassetpurchase > 16.5) => 
0.0046903848
, 

0.0006601345
)
, 

(v1_resinputavmratiodiff12mo > 1.435) => 
-0.0149706889
, 

0.0000027422
)
;


// Tree: 384

b4_tree_384 := 
map(

( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 0.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 58.5) => 
map(

      ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 0) => 
0.0001014390
, 

      (v1_occbusinessassociationtime > 0) => 
0.0119741339
, 

0.0005774094
)
, 

   (v1_prospecttimelastupdate > 58.5) => 
-0.0074153443
, 

-0.0002997686
)
, 

(v1_rescurrbusinesscnt > 0.5) => 
map(

   ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 36.5) => 
-0.0132921360
, 

   (v1_lifeevtimelastmove > 36.5) => 
map(

      ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 0.785) => 
0.0115563769
, 

      (v1_rescurravmratiodiff60mo > 0.785) => 
map(

         ( NULL < v1_hhcrtrecbkrptmmbrcnt24mo and v1_hhcrtrecbkrptmmbrcnt24mo <= 0.5) => 
0.0022320734
, 

         (v1_hhcrtrecbkrptmmbrcnt24mo > 0.5) => 
-0.0453716319
, 

0.0007039256
)
, 

0.0067758152
)
, 

0.0050476493
)
, 

0.0006386686
)
;


// Tree: 388

b4_tree_388 := 
map(

( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 178999.5) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 6.5) => 
map(

      ( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.055) => 
-0.0021133537
, 

         (v1_rescurravmratiodiff12mo > 1.055) => 
-0.0109837533
, 

-0.0028689833
)
, 

      (v1_hhcollegeattendedmmbrcnt > 0.5) => 
0.0051760631
, 

-0.0013810659
)
, 

   (v1_hhcnt > 6.5) => 
-0.0130837916
, 

-0.0018775328
)
, 

(v1_resinputavmvalue > 178999.5) => 
map(

   ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 12.5) => 
map(

      ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
0.0028930010
, 

      (v1_prospectcollegeattending > 0.5) => 
-0.0380181176
, 

0.0019494071
)
, 

   (v1_crtrecmsdmeantimenewest > 12.5) => 
0.0201289942
, 

0.0040849954
)
, 

-0.0007309075
)
;


// Tree: 392

b4_tree_392 := 
map(

( NULL < v1_lifeevnamechange and v1_lifeevnamechange <= 0.5) => 
map(

   ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 69.5) => 
map(

      ( NULL < v1_hhcrtreclienjudgmmbrcnt and v1_hhcrtreclienjudgmmbrcnt <= 0.5) => 
0.0001308168
, 

      (v1_hhcrtreclienjudgmmbrcnt > 0.5) => 
map(

         ( NULL < v1_rescurravmtractratio and v1_rescurravmtractratio <= 0.985) => 
0.0147361300
, 

         (v1_rescurravmtractratio > 0.985) => 
0.0525175735
, 

0.0233601551
)
, 

0.0006015435
)
, 

   (v1_hhcrtreclienjudgamtttl > 69.5) => 
map(

      ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.305) => 
map(

         ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
-0.0559710292
, 

         (v1_lifeeveverresidedcnt > 0.5) => 
-0.0095156535
, 

-0.0110491349
)
, 

      (v1_resinputavmcntyratio > 1.305) => 
0.0165190098
, 

-0.0089706108
)
, 

-0.0007858638
)
, 

(v1_lifeevnamechange > 0.5) => 
0.0079768214
, 

-0.0000966003
)
;


// Tree: 396

b4_tree_396 := 
map(

( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 238.5) => 
map(

   ( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 1.5) => 
map(

      ( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 2.5) => 
-0.0012569521
, 

      (v1_occproflicensecategory > 2.5) => 
0.0168374824
, 

-0.0010493288
)
, 

   (v1_hhelderlymmbrcnt > 1.5) => 
-0.0245013985
, 

-0.0012068327
)
, 

(v1_prospecttimeonrecord > 238.5) => 
map(

   ( NULL < v1_assetcurrowner and v1_assetcurrowner <= 0.5) => 
0.0072022352
, 

   (v1_assetcurrowner > 0.5) => 
map(

      ( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 2.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 408.5) => 
-0.0352398635
, 

         (v1_prospecttimeonrecord > 408.5) => 
-0.1390955008
, 

-0.0486212630
)
, 

      (v1_rescurrbusinesscnt > 2.5) => 
0.0651015309
, 

-0.0313680495
)
, 

0.0060619060
)
, 

-0.0005986503
)
;


// Tree: 400

b4_tree_400 := 
map(

( NULL < v1_raaelderlymmbrcnt and v1_raaelderlymmbrcnt <= 1.5) => 
map(

   ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 69486.5) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 50) => 
-0.0006743268
, 

      (v1_propcurrownedassessedttl > 50) => 
map(

         ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 20848.5) => 
-0.0507033183
, 

         (v1_propcurrownedassessedttl > 20848.5) => 
-0.0133684248
, 

-0.0205783203
)
, 

-0.0014964409
)
, 

   (v1_propcurrownedassessedttl > 69486.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 1.5) => 
0.0207222360
, 

      (v1_lifeevtimelastmove > 1.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 10.5) => 
-0.0616324490
, 

         (v1_prospecttimeonrecord > 10.5) => 
0.0035315158
, 

0.0026950182
)
, 

0.0046447798
)
, 

-0.0007682255
)
, 

(v1_raaelderlymmbrcnt > 1.5) => 
0.0070300965
, 

-0.0002257190
)
;


// Tree: 404

b4_tree_404 := 
map(

( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

   ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 0.5) => 
-0.0035727893
, 

   (v1_raamiddleagemmbrcnt > 0.5) => 
map(

      ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

         ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 1.5) => 
map(

            ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 0.5) => 
0.0251192264
, 

            (v1_raacrtrecevictionmmbrcnt > 0.5) => 
0.0058624551
, 

0.0184208711
)
, 

         (v1_raacrtrecmsdmeanmmbrcnt > 1.5) => 
map(

            ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
0.0021259962
, 

            (v1_prospectcollegeattending > 0.5) => 
0.0454151965
, 

0.0033431668
)
, 

0.0098146000
)
, 

      (v1_lifeevtimefirstassetpurchase > -0.5) => 
-0.0058557441
, 

0.0073983033
)
, 

0.0024742273
)
, 

(v1_resinputownershipindex > 0.5) => 
-0.0017275812
, 

0.0001081115
)
;


// Tree: 408

b4_tree_408 := 
map(

( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 399.5) => 
map(

      ( NULL < v1_lifeevnamechange and v1_lifeevnamechange <= 0.5) => 
map(

         ( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 7.5) => 
-0.0018639994
, 

         (v1_raaoccbusinessassocmmbrcnt > 7.5) => 
0.0217226006
, 

-0.0016337318
)
, 

      (v1_lifeevnamechange > 0.5) => 
0.0073524615
, 

-0.0009887733
)
, 

   (v1_prospecttimeonrecord > 399.5) => 
-0.0270508674
, 

-0.0011656552
)
, 

(v1_hhseniormmbrcnt > 0.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 6.5) => 
0.0406524561
, 

   (v1_prospecttimeonrecord > 6.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 284.5) => 
-0.0013319048
, 

      (v1_lifeevtimelastmove > 284.5) => 
0.0118322621
, 

0.0031980308
)
, 

0.0054415125
)
, 

-0.0005691800
)
;


// Tree: 412

b4_tree_412 := 
map(

( NULL < v1_propcurrownedcnt and v1_propcurrownedcnt <= 1.5) => 
map(

   ( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.195) => 
map(

      ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
-0.0012065009
, 

      (v1_hhseniormmbrcnt > 0.5) => 
map(

         ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
map(

            ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
0.0361332605
, 

            (v1_crtrecseverityindex > 2.5) => 
0.0001803656
, 

0.0234036587
)
, 

         (v1_hhpropcurrownermmbrcnt > 0.5) => 
-0.0001979530
, 

0.0073898819
)
, 

-0.0005685072
)
, 

   (v1_rescurravmratiodiff12mo > 1.195) => 
-0.0090938143
, 

-0.0011103215
)
, 

(v1_propcurrownedcnt > 1.5) => 
map(

   ( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 52900) => 
0.0029231865
, 

   (v1_resinputmortgageamount > 52900) => 
0.0265585489
, 

0.0083203364
)
, 

-0.0006080081
)
;


// Tree: 416

b4_tree_416 := 
map(

( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 145541.5) => 
map(

   ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 40) => 
map(

      ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 1.5) => 
-0.0010627769
, 

      (v1_verifiedcurrresmatchindex > 1.5) => 
0.0059321667
, 

0.0000548748
)
, 

   (v1_propcurrownedassessedttl > 40) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 44873.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 10.5) => 
-0.0210710504
, 

         (v1_raammbrcnt > 10.5) => 
-0.0475472473
, 

-0.0328156719
)
, 

      (v1_propcurrownedassessedttl > 44873.5) => 
-0.0007191487
, 

-0.0084264548
)
, 

-0.0007511714
)
, 

(v1_propcurrownedassessedttl > 145541.5) => 
map(

   ( NULL < v1_rescurravmtractratio and v1_rescurravmtractratio <= 0.575) => 
0.0195104793
, 

   (v1_rescurravmtractratio > 0.575) => 
0.0017787839
, 

0.0076723061
)
, 

-0.0000910031
)
;


// Tree: 420

b4_tree_420 := 
map(

(v1_resinputdwelltype in ['0','G','P']) => 
-0.0141364057
, 

(v1_resinputdwelltype in ['-1','F','H','R','S','U']) => 
map(

   ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

      ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 1.5) => 
0.0040548776
, 

      (v1_hhseniormmbrcnt > 1.5) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 215.5) => 
0.0269845749
, 

         (v1_crtrectimenewest > 215.5) => 
0.1667588080
, 

0.0315391299
)
, 

0.0044429375
)
, 

   (v1_resinputownershipindex > 0.5) => 
map(

      ( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 65475) => 
-0.0025273247
, 

      (v1_resinputmortgageamount > 65475) => 
map(

         ( NULL < v1_hhcrtreclienjudgmmbrcnt and v1_hhcrtreclienjudgmmbrcnt <= 0.5) => 
0.0018407455
, 

         (v1_hhcrtreclienjudgmmbrcnt > 0.5) => 
0.0244108327
, 

0.0065956615
)
, 

-0.0016114768
)
, 

0.0008885494
)
, 

0.0002254733
)
;


// Tree: 424

b4_tree_424 := 
map(

( NULL < v1_propeverownedcnt and v1_propeverownedcnt <= 2.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 581.5) => 
map(

      ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 150.5) => 
map(

         ( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 1.075) => 
map(

            ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 75.5) => 
0.0012949272
, 

            (v1_hhcrtreclienjudgamtttl > 75.5) => 
-0.0053422201
, 

0.0002051553
)
, 

         (v1_resinputavmratiodiff60mo > 1.075) => 
-0.0087700348
, 

-0.0004441486
)
, 

      (v1_occbusinessassociationtime > 150.5) => 
0.0139236345
, 

-0.0002414328
)
, 

   (v1_prospecttimeonrecord > 581.5) => 
-0.0500862083
, 

-0.0003014102
)
, 

(v1_propeverownedcnt > 2.5) => 
map(

   ( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 131788.5) => 
0.0069805819
, 

   (v1_resinputmortgageamount > 131788.5) => 
0.0428294021
, 

0.0135302323
)
, 

0.0000315932
)
;


// Tree: 428

b4_tree_428 := 
map(

( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 2.5) => 
map(

   ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 1.5) => 
map(

      ( NULL < v1_ppcurrowner and v1_ppcurrowner <= 0.5) => 
0.0003004786
, 

      (v1_ppcurrowner > 0.5) => 
map(

         ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 0.5) => 
-0.0331194165
, 

         (v1_resinputbusinesscnt > 0.5) => 
0.0024905187
, 

-0.0175558544
)
, 

0.0001290942
)
, 

   (v1_hhyoungadultmmbrcnt > 1.5) => 
map(

      ( NULL < v1_raahhcnt and v1_raahhcnt <= 3.5) => 
-0.0084538713
, 

      (v1_raahhcnt > 3.5) => 
0.0199000188
, 

0.0118220799
)
, 

0.0004257243
)
, 

(v1_hhpropcurrownermmbrcnt > 2.5) => 
map(

   ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 48440) => 
-0.0221441546
, 

   (v1_propcurrownedassessedttl > 48440) => 
-0.0009623263
, 

-0.0113617231
)
, 

0.0001100656
)
;


// Tree: 432

b4_tree_432 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 107.5) => 
map(

   ( NULL < v1_raacollegeprivatemmbrcnt and v1_raacollegeprivatemmbrcnt <= 0.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 248.5) => 
map(

         ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 5419.5) => 
map(

            ( NULL < v1_proppurchasecnt12mo and v1_proppurchasecnt12mo <= 0.5) => 
0.0001382283
, 

            (v1_proppurchasecnt12mo > 0.5) => 
-0.0151436310
, 

-0.0000685542
)
, 

         (v1_hhcrtreclienjudgamtttl > 5419.5) => 
-0.0105969039
, 

-0.0007465148
)
, 

      (v1_prospecttimeonrecord > 248.5) => 
map(

         ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 58298) => 
0.0186249362
, 

         (v1_raapropowneravmhighest > 58298) => 
0.0026552520
, 

0.0072479865
)
, 

-0.0002597753
)
, 

   (v1_raacollegeprivatemmbrcnt > 0.5) => 
0.0104176817
, 

0.0002407547
)
, 

(v1_prospecttimelastupdate > 107.5) => 
-0.0083376059
, 

-0.0002085115
)
;


// Tree: 436

b4_tree_436 := 
map(

( NULL < v1_donotmail and v1_donotmail <= 0.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 1.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 20.5) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
-0.0010064315
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
0.0081827778
, 

-0.0000335999
)
, 

      (v1_prospecttimelastupdate > 20.5) => 
-0.0053457050
, 

-0.0012812169
)
, 

   (v1_hhmiddleagemmbrcnt > 1.5) => 
map(

      ( NULL < v1_hhcrtrecbkrptmmbrcnt and v1_hhcrtrecbkrptmmbrcnt <= 1.5) => 
0.0082657074
, 

      (v1_hhcrtrecbkrptmmbrcnt > 1.5) => 
-0.0109652424
, 

0.0054115087
)
, 

-0.0005612918
)
, 

(v1_donotmail > 0.5) => 
map(

   ( NULL < v1_hhcollege4yrattendedmmbrcnt and v1_hhcollege4yrattendedmmbrcnt <= 0.5) => 
0.0593576323
, 

   (v1_hhcollege4yrattendedmmbrcnt > 0.5) => 
-0.0541854084
, 

0.0417831443
)
, 

-0.0004630366
)
;


// Tree: 440

b4_tree_440 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 182.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 139.5) => 
0.0001060488
, 

   (v1_crtrecbkrpttimenewest > 139.5) => 
map(

      ( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 113225) => 
map(

         ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 148.5) => 
0.0028932399
, 

         (v1_crtreclienjudgtimenewest > 148.5) => 
0.0437417414
, 

0.0081120701
)
, 

      (v1_rescurrmortgageamount > 113225) => 
0.0568096895
, 

0.0127095443
)
, 

0.0003459601
)
, 

(v1_prospecttimelastupdate > 182.5) => 
map(

   ( NULL < v1_raacollegeprivatemmbrcnt and v1_raacollegeprivatemmbrcnt <= 1.5) => 
map(

      ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 743892.5) => 
-0.0120857560
, 

      (v1_raapropowneravmmed > 743892.5) => 
-0.1390399542
, 

-0.0133204364
)
, 

   (v1_raacollegeprivatemmbrcnt > 1.5) => 
-0.1711834959
, 

-0.0144413045
)
, 

0.0001358506
)
;


// Tree: 444

b4_tree_444 := 
map(

( NULL < v1_interestsportperson and v1_interestsportperson <= 0.5) => 
map(

   ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 547907) => 
map(

      ( NULL < v1_donotmail and v1_donotmail <= 0.5) => 
-0.0000942109
, 

      (v1_donotmail > 0.5) => 
0.0368716744
, 

-0.0000117974
)
, 

   (v1_propcurrownedavmttl > 547907) => 
map(

      ( NULL < v1_hhcrtreclienjudgmmbrcnt and v1_hhcrtreclienjudgmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 554324.5) => 
0.0291845993
, 

         (v1_hhpropcurravmhighest > 554324.5) => 
-0.0035532037
, 

0.0048383343
)
, 

      (v1_hhcrtreclienjudgmmbrcnt > 0.5) => 
0.0359301500
, 

0.0106144384
)
, 

0.0002319900
)
, 

(v1_interestsportperson > 0.5) => 
map(

   ( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 110160) => 
-0.0205376832
, 

   (v1_resinputmortgageamount > 110160) => 
0.0330785731
, 

-0.0164821710
)
, 

-0.0000711938
)
;


// Tree: 448

b4_tree_448 := 
map(

( NULL < v1_raaelderlymmbrcnt and v1_raaelderlymmbrcnt <= 0.5) => 
map(

   ( NULL < v1_hhcrtrecbkrptmmbrcnt and v1_hhcrtrecbkrptmmbrcnt <= 1.5) => 
map(

      ( NULL < v1_interestsportperson and v1_interestsportperson <= 0.5) => 
-0.0003718409
, 

      (v1_interestsportperson > 0.5) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 145.5) => 
-0.0217183951
, 

         (v1_prospecttimelastupdate > 145.5) => 
0.1649733854
, 

-0.0198127064
)
, 

-0.0006550111
)
, 

   (v1_hhcrtrecbkrptmmbrcnt > 1.5) => 
map(

      ( NULL < v1_propeverownedcnt and v1_propeverownedcnt <= 0.5) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 1.5) => 
-0.0093382825
, 

         (v1_hhyoungadultmmbrcnt > 1.5) => 
0.0613046974
, 

-0.0008239291
)
, 

      (v1_propeverownedcnt > 0.5) => 
-0.0266085385
, 

-0.0136896627
)
, 

-0.0009713915
)
, 

(v1_raaelderlymmbrcnt > 0.5) => 
0.0041459654
, 

0.0000178862
)
;


// Tree: 452

b4_tree_452 := 
map(

( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 0.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 48.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 5.5) => 
map(

         ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 2.5) => 
0.0008411420
, 

         (v1_raacrtrecevictionmmbrcnt > 2.5) => 
-0.0117998734
, 

-0.0002427636
)
, 

      (v1_crtrecbkrpttimenewest > 5.5) => 
map(

         ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 71758) => 
-0.0052491094
, 

         (v1_propcurrownedavmttl > 71758) => 
-0.0587707688
, 

-0.0191148956
)
, 

-0.0005644608
)
, 

   (v1_crtrecbkrpttimenewest > 48.5) => 
0.0087756911
, 

-0.0001289671
)
, 

(v1_occproflicensecategory > 0.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 169993) => 
0.0208254213
, 

   (v1_raapropowneravmmed > 169993) => 
-0.0000495544
, 

0.0101797646
)
, 

0.0002297942
)
;


// Tree: 456

b4_tree_456 := 
map(

( NULL < v1_donotmail and v1_donotmail <= 0.5) => 
map(

   ( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 837896) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 34.5) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 6.5) => 
-0.0001431192
, 

         (v1_crtrecbkrpttimenewest > 6.5) => 
-0.0318441865
, 

-0.0005114843
)
, 

      (v1_crtrecbkrpttimenewest > 34.5) => 
0.0075483377
, 

-0.0000874514
)
, 

   (v1_rescurrmortgageamount > 837896) => 
map(

      ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 388500) => 
0.0970448335
, 

      (v1_propcurrownedavmttl > 388500) => 
-0.1265655699
, 

-0.0718357509
)
, 

-0.0001289525
)
, 

(v1_donotmail > 0.5) => 
map(

   ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 0.67) => 
0.0788009593
, 

   (v1_rescurravmcntyratio > 0.67) => 
0.0046245001
, 

0.0387813576
)
, 

-0.0000375666
)
;


// Tree: 460

b4_tree_460 := 
map(

( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 4.5) => 
map(

   ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 1.465) => 
map(

      ( NULL < v1_donotmail and v1_donotmail <= 0.5) => 
map(

         ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 1.5) => 
-0.0016335767
, 

         (v1_occbusinessassociationtime > 1.5) => 
0.0053954373
, 

-0.0011074480
)
, 

      (v1_donotmail > 0.5) => 
0.0342138222
, 

-0.0010260703
)
, 

   (v1_rescurravmratiodiff60mo > 1.465) => 
map(

      ( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 2.705) => 
-0.0287229633
, 

      (v1_resinputavmratiodiff60mo > 2.705) => 
map(

         ( NULL < v1_propsoldratio and v1_propsoldratio <= 1.445) => 
0.0436283893
, 

         (v1_propsoldratio > 1.445) => 
-0.2301908920
, 

0.0326756180
)
, 

-0.0209233468
)
, 

-0.0011855954
)
, 

(v1_raaoccproflicmmbrcnt > 4.5) => 
0.0184670178
, 

-0.0010000962
)
;


// Tree: 464

b4_tree_464 := 
map(

( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 1.5) => 
map(

   ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 57605) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 76.5) => 
0.0004333289
, 

      (v1_propcurrownedassessedttl > 76.5) => 
map(

         ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 20820) => 
-0.0387777656
, 

         (v1_propcurrownedassessedttl > 20820) => 
-0.0118362839
, 

-0.0188837790
)
, 

-0.0002240081
)
, 

   (v1_propcurrownedassessedttl > 57605) => 
map(

      ( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 2.5) => 
map(

         ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 0.765) => 
0.0117414643
, 

         (v1_rescurravmratiodiff60mo > 0.765) => 
0.0004501103
, 

0.0069300519
)
, 

      (v1_raaoccbusinessassocmmbrcnt > 2.5) => 
-0.0048884405
, 

0.0045043163
)
, 

0.0004129319
)
, 

(v1_hhelderlymmbrcnt > 1.5) => 
-0.0187396842
, 

0.0002356301
)
;


// Tree: 468

b4_tree_468 := 
map(

( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 2.5) => 
map(

   ( NULL < v1_crtreccnt and v1_crtreccnt <= 9.5) => 
0.0010073826
, 

   (v1_crtreccnt > 9.5) => 
-0.0184871015
, 

0.0004768497
)
, 

(v1_raacrtrecfelonymmbrcnt > 2.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 384.5) => 
map(

      ( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 0.5) => 
-0.0219256329
, 

      (v1_prospectcollegeprogramtype > 0.5) => 
map(

         ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 20.5) => 
-0.0002946552
, 

         (v1_raacrtrecmmbrcnt > 20.5) => 
0.1099154299
, 

0.0293661065
)
, 

-0.0193990447
)
, 

   (v1_prospecttimeonrecord > 384.5) => 
map(

      ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 90178.5) => 
0.1174067636
, 

      (v1_propcurrownedavmttl > 90178.5) => 
-0.0966208987
, 

0.0774235740
)
, 

-0.0182672710
)
, 

-0.0001120148
)
;


// Tree: 472

b4_tree_472 := 
map(

( NULL < v1_raaseniormmbrcnt and v1_raaseniormmbrcnt <= 0.5) => 
map(

   ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 2.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 173.5) => 
map(

         ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 430922) => 
map(

            ( NULL < v1_hhpropcurrownedcnt and v1_hhpropcurrownedcnt <= 1.5) => 
-0.0028061256
, 

            (v1_hhpropcurrownedcnt > 1.5) => 
-0.0087272093
, 

-0.0034739559
)
, 

         (v1_propcurrownedavmttl > 430922) => 
0.0112978425
, 

-0.0030895716
)
, 

      (v1_crtrecbkrpttimenewest > 173.5) => 
0.0269992048
, 

-0.0028772842
)
, 

   (v1_raayoungadultmmbrcnt > 2.5) => 
map(

      ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 4.5) => 
0.0180587895
, 

      (v1_raacrtrecmmbrcnt > 4.5) => 
0.0010523196
, 

0.0061007221
)
, 

-0.0021021828
)
, 

(v1_raaseniormmbrcnt > 0.5) => 
0.0037554825
, 

-0.0003148673
)
;


// Tree: 476

b4_tree_476 := 
map(

( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 69475) => 
map(

   ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 413) => 
map(

      ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
-0.0000291685
, 

      (v1_hhseniormmbrcnt > 0.5) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 103479.5) => 
0.0230630287
, 

         (v1_raapropowneravmmed > 103479.5) => 
-0.0023679218
, 

0.0099068174
)
, 

0.0006020151
)
, 

   (v1_propcurrownedassessedttl > 413) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 18162.5) => 
-0.0415119255
, 

      (v1_propcurrownedassessedttl > 18162.5) => 
-0.0061208585
, 

-0.0120162720
)
, 

0.0000462394
)
, 

(v1_propcurrownedassessedttl > 69475) => 
map(

   ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 94753.5) => 
0.0120723677
, 

   (v1_hhpropcurravmhighest > 94753.5) => 
0.0013038260
, 

0.0046960528
)
, 

0.0006399348
)
;


// Tree: 480

b4_tree_480 := 
map(

( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 3.5) => 
map(

   ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 2.5) => 
0.0000377299
, 

   (v1_hhcrtrecmmbrcnt > 2.5) => 
map(

      ( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 523467.5) => 
-0.0110475745
, 

      (v1_rescurravmvalue60mo > 523467.5) => 
0.0533759152
, 

-0.0096181108
)
, 

-0.0003274521
)
, 

(v1_raacollege4yrattendedmmbrcnt > 3.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 302077) => 
map(

      ( NULL < v1_raacollegetoptiermmbrcnt and v1_raacollegetoptiermmbrcnt <= 4.5) => 
0.0217196149
, 

      (v1_raacollegetoptiermmbrcnt > 4.5) => 
0.1499913526
, 

0.0231198687
)
, 

   (v1_raapropowneravmmed > 302077) => 
map(

      ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 22.5) => 
-0.0326274614
, 

      (v1_raacrtrecmsdmeanmmbrcnt > 22.5) => 
0.1117854392
, 

-0.0229215027
)
, 

0.0166866549
)
, 

-0.0000861825
)
;


// Tree: 484

b4_tree_484 := 
map(

( NULL < v1_lifeevnamechangecnt12mo and v1_lifeevnamechangecnt12mo <= 0.5) => 
map(

   ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 0.965) => 
0.0013947335
, 

   (v1_rescurravmratiodiff60mo > 0.965) => 
map(

      ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 0.925) => 
-0.0137070246
, 

      (v1_resinputavmblockratio > 0.925) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 117.5) => 
0.0032721397
, 

         (v1_prospecttimelastupdate > 117.5) => 
-0.0249915626
, 

0.0009924973
)
, 

-0.0051233193
)
, 

0.0008580138
)
, 

(v1_lifeevnamechangecnt12mo > 0.5) => 
map(

   ( NULL < v1_rescurravmvalue and v1_rescurravmvalue <= 681193.5) => 
map(

      ( NULL < v1_rescurrmortgagetype and v1_rescurrmortgagetype <= -0.5) => 
-0.0123991771
, 

      (v1_rescurrmortgagetype > -0.5) => 
-0.0913141183
, 

-0.0139185323
)
, 

   (v1_rescurravmvalue > 681193.5) => 
-0.1064825339
, 

-0.0157289722
)
, 

0.0005636966
)
;


// Tree: 488

b4_tree_488 := 
map(

(v1_rescurrdwelltype in ['P','R','U']) => 
-0.0581459839
, 

(v1_rescurrdwelltype in ['-1','F','H','S']) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
-0.0026134770
, 

   (v1_hhmiddleagemmbrcnt > 0.5) => 
map(

      (v1_rescurrdwelltype in ['H','S']) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 96.5) => 
-0.0134801718
, 

         (v1_prospecttimeonrecord > 96.5) => 
map(

            ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
-0.0051568588
, 

            (v1_verifiedcurrresmatchindex > 0.5) => 
map(

               ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 1.5) => 
0.0129531482
, 

               (v1_hhpropcurrownermmbrcnt > 1.5) => 
-0.0002526583
, 

0.0062023280
)
, 

0.0022130259
)
, 

-0.0003625974
)
, 

      (v1_rescurrdwelltype in ['-1','F','P','R','U']) => 
0.0191887504
, 

0.0019591008
)
, 

-0.0013121998
)
, 

-0.0013885733
)
;


// Tree: 492

b4_tree_492 := 
map(

( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 15608) => 
map(

   ( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 41083.5) => 
-0.0003037762
, 

   (v1_rescurrmortgageamount > 41083.5) => 
0.0058002896
, 

0.0001179178
)
, 

(v1_crtreclienjudgamtttl > 15608) => 
map(

   ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 75.5) => 
map(

      ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 118960) => 
-0.0215929936
, 

      (v1_propcurrownedavmttl > 118960) => 
map(

         ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 815034.5) => 
-0.0540732939
, 

         (v1_resinputavmvalue > 815034.5) => 
0.1154034375
, 

-0.0482292686
)
, 

-0.0264093509
)
, 

   (v1_crtreclienjudgtimenewest > 75.5) => 
map(

      ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 307) => 
0.0096611156
, 

      (v1_occbusinessassociationtime > 307) => 
0.1689453672
, 

0.0121026990
)
, 

-0.0152735324
)
, 

-0.0001763660
)
;


// Tree: 496

b4_tree_496 := 
map(

( NULL < v1_lifeevnamechange and v1_lifeevnamechange <= 0.5) => 
map(

   ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 0.5) => 
0.0010293761
, 

   (v1_raacrtrecevictionmmbrcnt > 0.5) => 
-0.0048009309
, 

-0.0006963692
)
, 

(v1_lifeevnamechange > 0.5) => 
map(

   ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 4.5) => 
map(

         ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 451920) => 
0.0380973796
, 

         (v1_hhpropcurravmhighest > 451920) => 
-0.0630855974
, 

0.0338343405
)
, 

      (v1_crtrectimenewest > 4.5) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 213.5) => 
0.0083902087
, 

         (v1_crtrectimenewest > 213.5) => 
0.0862075784
, 

0.0105680427
)
, 

0.0168519208
)
, 

   (v1_lifeevtimefirstassetpurchase > -0.5) => 
0.0011459574
, 

0.0070045693
)
, 

-0.0000886948
)
;


// Tree: 500

b4_tree_500 := 
map(

( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 1.5) => 
map(

   ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
-0.0014196596
, 

   (v1_hhseniormmbrcnt > 0.5) => 
map(

      (v1_rescurrdwelltype in ['H','R','S']) => 
map(

         ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 4.5) => 
0.0063346162
, 

         (v1_raapropcurrownermmbrcnt > 4.5) => 
-0.0093581222
, 

0.0018758300
)
, 

      (v1_rescurrdwelltype in ['-1','F','P','U']) => 
0.0246338063
, 

0.0047163008
)
, 

-0.0008541711
)
, 

(v1_prospectcollegeprogramtype > 1.5) => 
map(

   ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 1.5) => 
map(

      ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 2.5) => 
-0.0021480710
, 

      (v1_hhcrtrecmmbrcnt > 2.5) => 
0.0977698484
, 

-0.0006028559
)
, 

   (v1_raacrtreclienjudgmmbrcnt > 1.5) => 
0.0209127987
, 

0.0084468105
)
, 

-0.0004939234
)
;


// Tree: 504

b4_tree_504 := 
map(

( NULL < v1_raaelderlymmbrcnt and v1_raaelderlymmbrcnt <= 6.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 52.5) => 
0.0002216366
, 

   (v1_prospecttimelastupdate > 52.5) => 
map(

      ( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.075) => 
map(

         ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 312870) => 
map(

            ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 2278500) => 
-0.0032792016
, 

            (v1_raapropowneravmhighest > 2278500) => 
0.1820299687
, 

-0.0031302828
)
, 

         (v1_hhpropcurravmhighest > 312870) => 
map(

            ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 10464) => 
0.0101357793
, 

            (v1_hhcrtreclienjudgamtttl > 10464) => 
0.0745484559
, 

0.0170250171
)
, 

-0.0018235000
)
, 

      (v1_rescurravmratiodiff12mo > 1.075) => 
-0.0110235432
, 

-0.0042901549
)
, 

-0.0005066932
)
, 

(v1_raaelderlymmbrcnt > 6.5) => 
0.1716422042
, 

-0.0004872416
)
;


// Tree: 508

b4_tree_508 := 
map(

( NULL < v1_interestsportperson and v1_interestsportperson <= 0.5) => 
map(

   ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 0.955) => 
map(

      ( NULL < v1_raacollegetoptiermmbrcnt and v1_raacollegetoptiermmbrcnt <= 4.5) => 
-0.0012299900
, 

      (v1_raacollegetoptiermmbrcnt > 4.5) => 
0.1264036709
, 

-0.0012048186
)
, 

   (v1_rescurravmcntyratio > 0.955) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 4.5) => 
-0.0478764022
, 

      (v1_prospecttimeonrecord > 4.5) => 
map(

         ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 123.5) => 
map(

            ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 5088) => 
0.0053865349
, 

            (v1_crtreclienjudgamtttl > 5088) => 
-0.0219661707
, 

0.0037978987
)
, 

         (v1_crtreclienjudgtimenewest > 123.5) => 
0.0286849310
, 

0.0048068771
)
, 

0.0043446671
)
, 

-0.0005109448
)
, 

(v1_interestsportperson > 0.5) => 
-0.0151194495
, 

-0.0007706867
)
;


// Tree: 512

b4_tree_512 := 
map(

( NULL < v1_raainterestsportpersonmmbrcnt and v1_raainterestsportpersonmmbrcnt <= 1.5) => 
map(

   ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 2.5) => 
0.0002930033
, 

   (v1_hhpropcurrownermmbrcnt > 2.5) => 
map(

      ( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 2.175) => 
-0.0080908342
, 

      (v1_rescurravmratiodiff12mo > 2.175) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 44243.5) => 
0.0788701633
, 

         (v1_raapropowneravmmed > 44243.5) => 
-0.1555420418
, 

-0.0960087833
)
, 

-0.0089936592
)
, 

0.0000532141
)
, 

(v1_raainterestsportpersonmmbrcnt > 1.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 397079.5) => 
-0.0067867167
, 

   (v1_raapropowneravmmed > 397079.5) => 
map(

      ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 1.5) => 
-0.0671816335
, 

      (v1_hhcrtrecmmbrcnt > 1.5) => 
0.0680372886
, 

-0.0525746512
)
, 

-0.0082404443
)
, 

-0.0002883332
)
;


// Tree: 516

b4_tree_516 := 
map(

( NULL < v1_hhelderlymmbrcnt and v1_hhelderlymmbrcnt <= 1.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 423.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 285.5) => 
map(

         ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 178.5) => 
-0.0012462952
, 

         (v1_occbusinessassociationtime > 178.5) => 
0.0163626945
, 

-0.0010608035
)
, 

      (v1_lifeevtimelastmove > 285.5) => 
map(

         ( NULL < v1_propeverownedcnt and v1_propeverownedcnt <= 0.5) => 
0.0167548418
, 

         (v1_propeverownedcnt > 0.5) => 
0.0015403002
, 

0.0061785577
)
, 

-0.0006021736
)
, 

   (v1_prospecttimelastupdate > 423.5) => 
-0.0544554991
, 

-0.0006451562
)
, 

(v1_hhelderlymmbrcnt > 1.5) => 
map(

   ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 178) => 
-0.0220434916
, 

   (v1_occbusinessassociationtime > 178) => 
0.0698551006
, 

-0.0191228111
)
, 

-0.0008117358
)
;


// Tree: 520

b4_tree_520 := 
map(

( NULL < v1_raahhcnt and v1_raahhcnt <= 5.5) => 
map(

   (v1_resinputdwelltype in ['0','F','G','P','U']) => 
-0.0191539333
, 

   (v1_resinputdwelltype in ['-1','H','R','S']) => 
-0.0005226221
, 

-0.0014569843
)
, 

(v1_raahhcnt > 5.5) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 6.5) => 
map(

      ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 3.5) => 
0.0096580170
, 

      (v1_raacrtrecevictionmmbrcnt > 3.5) => 
-0.0107388740
, 

0.0071667515
)
, 

   (v1_crtrectimenewest > 6.5) => 
map(

      ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
map(

         ( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 269596) => 
-0.0031307893
, 

         (v1_rescurrmortgageamount > 269596) => 
0.0363258879
, 

-0.0024140314
)
, 

      (v1_prospectcollegeattending > 0.5) => 
0.0415261107
, 

-0.0015795747
)
, 

0.0030172355
)
, 

-0.0001884605
)
;


// Tree: 524

b4_tree_524 := 
map(

( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 285.5) => 
-0.0002498099
, 

(v1_lifeevtimelastmove > 285.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 97793) => 
map(

      (v1_resinputdwelltype in ['S']) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 141.5) => 
0.0140162947
, 

         (v1_prospecttimelastupdate > 141.5) => 
-0.0150422329
, 

0.0105048903
)
, 

      (v1_resinputdwelltype in ['-1','0','F','G','H','P','R','U']) => 
0.0468706290
, 

0.0145001521
)
, 

   (v1_raapropowneravmmed > 97793) => 
map(

      ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 782750) => 
-0.0035005521
, 

      (v1_raapropowneravmhighest > 782750) => 
map(

         ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.325) => 
0.0388582402
, 

         (v1_resinputavmratiodiff12mo > 1.325) => 
-0.0507752531
, 

0.0298448163
)
, 

-0.0002942667
)
, 

0.0062537631
)
, 

0.0001884524
)
;


// Tree: 528

b4_tree_528 := 
map(

( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 1681159) => 
map(

   ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 1.5) => 
-0.0004505271
, 

   (v1_hhyoungadultmmbrcnt > 1.5) => 
map(

      ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 1.5) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 58408) => 
-0.0229377158
, 

         (v1_raapropowneravmmed > 58408) => 
0.0072373521
, 

-0.0053413433
)
, 

      (v1_raayoungadultmmbrcnt > 1.5) => 
map(

         ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 198.5) => 
map(

            ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 11.5) => 
0.0309465493
, 

            (v1_raapropcurrownermmbrcnt > 11.5) => 
-0.0107221369
, 

0.0253808299
)
, 

         (v1_lifeevtimelastmove > 198.5) => 
-0.0238971058
, 

0.0210331690
)
, 

0.0090834381
)
, 

-0.0001905539
)
, 

(v1_hhcrtreclienjudgamtttl > 1681159) => 
0.1589519301
, 

-0.0001635811
)
;


// Tree: 532

b4_tree_532 := 
map(

( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 1.5) => 
map(

   ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 69) => 
map(

      ( NULL < v1_hhcrtreclienjudgmmbrcnt and v1_hhcrtreclienjudgmmbrcnt <= 0.5) => 
-0.0003798803
, 

      (v1_hhcrtreclienjudgmmbrcnt > 0.5) => 
map(

         ( NULL < v1_rescurrownershipindex and v1_rescurrownershipindex <= 2.5) => 
map(

            ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 261) => 
0.0005137913
, 

            (v1_prospecttimeonrecord > 261) => 
0.0811170714
, 

0.0054021674
)
, 

         (v1_rescurrownershipindex > 2.5) => 
0.0362089956
, 

0.0156734424
)
, 

-0.0000288202
)
, 

   (v1_hhcrtreclienjudgamtttl > 69) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 200625) => 
-0.0081161692
, 

      (v1_propcurrownedassessedttl > 200625) => 
0.0153780540
, 

-0.0067451470
)
, 

-0.0010945528
)
, 

(v1_hhcollegeattendedmmbrcnt > 1.5) => 
0.0082349566
, 

-0.0007749526
)
;


// Tree: 536

b4_tree_536 := 
map(

( NULL < v1_donotmail and v1_donotmail <= -0.5) => 
0.0982805571
, 

(v1_donotmail > -0.5) => 
map(

   ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 2801725.5) => 
map(

      ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 0.775) => 
map(

         ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
0.0008763792
, 

         (v1_hhyoungadultmmbrcnt > 0.5) => 
map(

            ( NULL < v1_prospectcollegeattended and v1_prospectcollegeattended <= 0.5) => 
0.0029313335
, 

            (v1_prospectcollegeattended > 0.5) => 
map(

               ( NULL < v1_hhcnt and v1_hhcnt <= 3.5) => 
0.0238757836
, 

               (v1_hhcnt > 3.5) => 
-0.0057815192
, 

0.0177923213
)
, 

0.0080065394
)
, 

0.0017513053
)
, 

      (v1_rescurravmratiodiff60mo > 0.775) => 
-0.0029809913
, 

0.0010071225
)
, 

   (v1_raapropowneravmhighest > 2801725.5) => 
0.0609036261
, 

0.0010571745
)
, 

0.0010924851
)
;


// Tree: 540

b4_tree_540 := 
map(

( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 296.5) => 
map(

   ( NULL < v1_raainterestsportpersonmmbrcnt and v1_raainterestsportpersonmmbrcnt <= 1.5) => 
map(

      ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 6.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 378.5) => 
map(

            ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 278.5) => 
0.0002789131
, 

            (v1_prospecttimeonrecord > 278.5) => 
0.0087444904
, 

0.0005377323
)
, 

         (v1_prospecttimeonrecord > 378.5) => 
map(

            ( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 1.5) => 
-0.0131683581
, 

            (v1_hhcollegeattendedmmbrcnt > 1.5) => 
0.0513109703
, 

-0.0104111906
)
, 

0.0003665851
)
, 

      (v1_lifeeveverresidedcnt > 6.5) => 
0.0265684356
, 

0.0004923419
)
, 

   (v1_raainterestsportpersonmmbrcnt > 1.5) => 
-0.0091082266
, 

0.0000947721
)
, 

(v1_crtreclienjudgtimenewest > 296.5) => 
0.1968869005
, 

0.0001106549
)
;


// Tree: 544

b4_tree_544 := 
map(

( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 1.5) => 
map(

   ( NULL < v1_raacrtrecbkrptmmbrcnt36mo and v1_raacrtrecbkrptmmbrcnt36mo <= 0.5) => 
-0.0014138858
, 

   (v1_raacrtrecbkrptmmbrcnt36mo > 0.5) => 
map(

      ( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 2.5) => 
0.0035102094
, 

      (v1_occproflicensecategory > 2.5) => 
0.0483453397
, 

0.0040822602
)
, 

-0.0006216287
)
, 

(v1_hhseniormmbrcnt > 1.5) => 
map(

   ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 8.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 507.5) => 
map(

         ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 485.5) => 
0.0098259425
, 

         (v1_lifeevtimelastmove > 485.5) => 
0.0675432609
, 

0.0110210752
)
, 

      (v1_lifeevtimelastmove > 507.5) => 
-0.0305427645
, 

0.0092051475
)
, 

   (v1_raayoungadultmmbrcnt > 8.5) => 
-0.1337899661
, 

0.0085563900
)
, 

-0.0003848855
)
;


// Tree: 548

b4_tree_548 := 
map(

( NULL < v1_raacollegetoptiermmbrcnt and v1_raacollegetoptiermmbrcnt <= 1.5) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 10.5) => 
0.0000632302
, 

   (v1_hhcnt > 10.5) => 
-0.0199092567
, 

-0.0000916168
)
, 

(v1_raacollegetoptiermmbrcnt > 1.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 29.5) => 
map(

      ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 1.125) => 
map(

         ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
0.0571153304
, 

         (v1_raacrtrecfelonymmbrcnt > 0.5) => 
-0.0483855615
, 

0.0470994229
)
, 

      (v1_resinputavmblockratio > 1.125) => 
map(

         ( NULL < v1_raahhcnt and v1_raahhcnt <= 8.5) => 
-0.0607300599
, 

         (v1_raahhcnt > 8.5) => 
0.0804064262
, 

-0.0191732057
)
, 

0.0348014094
)
, 

   (v1_prospecttimeonrecord > 29.5) => 
0.0042449649
, 

0.0141380728
)
, 

0.0000804230
)
;


// Tree: 552

b4_tree_552 := 
map(

( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 1.5) => 
map(

   ( NULL < v1_ppcurrowner and v1_ppcurrowner <= 0.5) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 57805) => 
map(

         ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 663) => 
-0.0003742673
, 

         (v1_propcurrownedassessedttl > 663) => 
map(

            ( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 129350) => 
map(

               ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 35567.5) => 
-0.0330397984
, 

               (v1_propcurrownedassessedttl > 35567.5) => 
-0.0058589021
, 

-0.0197970023
)
, 

            (v1_rescurravmvalue60mo > 129350) => 
0.0349029521
, 

-0.0160816956
)
, 

-0.0008759298
)
, 

      (v1_propcurrownedassessedttl > 57805) => 
0.0045751510
, 

-0.0002671005
)
, 

   (v1_ppcurrowner > 0.5) => 
-0.0180479424
, 

-0.0004198439
)
, 

(v1_rescurrbusinesscnt > 1.5) => 
0.0057999804
, 

0.0001111167
)
;


// Tree: 556

b4_tree_556 := 
map(

( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 2.245) => 
0.0005207071
, 

(v1_resinputavmcntyratio > 2.245) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 210662.5) => 
0.0004974285
, 

   (v1_raapropowneravmmed > 210662.5) => 
map(

      ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 134.5) => 
-0.0420054387
, 

         (v1_prospecttimeonrecord > 134.5) => 
0.0012200060
, 

-0.0203484824
)
, 

      (v1_hhyoungadultmmbrcnt > 0.5) => 
map(

         ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 391772) => 
-0.1275925756
, 

         (v1_raapropowneravmhighest > 391772) => 
map(

            ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 444240) => 
0.1000053143
, 

            (v1_raapropowneravmhighest > 444240) => 
-0.0517523375
, 

-0.0370508150
)
, 

-0.0602126607
)
, 

-0.0263149275
)
, 

-0.0111670020
)
, 

0.0002092285
)
;


// Tree: 560

b4_tree_560 := 
map(

( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 74239) => 
map(

   ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
-0.0003970386
, 

   (v1_prospectcollegeattending > 0.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 1.5) => 
map(

         ( NULL < v1_occproflicense and v1_occproflicense <= 0.5) => 
map(

            ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 144416) => 
-0.0167410707
, 

            (v1_raapropowneravmhighest > 144416) => 
-0.0469336928
, 

-0.0322527955
)
, 

         (v1_occproflicense > 0.5) => 
0.0533757296
, 

-0.0287430356
)
, 

      (v1_crtrectimenewest > 1.5) => 
0.0245051687
, 

-0.0148863378
)
, 

-0.0006947067
)
, 

(v1_resinputmortgageamount > 74239) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 169139) => 
0.0138987064
, 

   (v1_raapropowneravmmed > 169139) => 
-0.0007383617
, 

0.0060357375
)
, 

-0.0003299704
)
;


// Tree: 564

b4_tree_564 := 
map(

( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 1.435) => 
map(

   ( NULL < v1_prospectcollegeprivate and v1_prospectcollegeprivate <= 0.5) => 
0.0001409486
, 

   (v1_prospectcollegeprivate > 0.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 107.5) => 
map(

         ( NULL < v1_hhcollegetiermmbrhighest and v1_hhcollegetiermmbrhighest <= 3.5) => 
map(

            ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 167) => 
0.0272338630
, 

            (v1_crtreclienjudgtimenewest > 167) => 
-0.2099836693
, 

0.0254355220
)
, 

         (v1_hhcollegetiermmbrhighest > 3.5) => 
map(

            ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 57.5) => 
-0.0100906862
, 

            (v1_prospecttimelastupdate > 57.5) => 
-0.1495148140
, 

-0.0253700427
)
, 

0.0169242054
)
, 

      (v1_crtrecbkrpttimenewest > 107.5) => 
0.1811030849
, 

0.0193372358
)
, 

0.0002792319
)
, 

(v1_rescurravmratiodiff60mo > 1.435) => 
-0.0220846530
, 

0.0000776172
)
;


// Tree: 568

b4_tree_568 := 
map(

( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 2.5) => 
map(

   ( NULL < v1_hhteenagermmbrcnt and v1_hhteenagermmbrcnt <= 0.5) => 
-0.0002221936
, 

   (v1_hhteenagermmbrcnt > 0.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 257.5) => 
-0.0654542374
, 

      (v1_lifeevtimelastmove > 257.5) => 
0.0994624800
, 

-0.0525390727
)
, 

-0.0002932566
)
, 

(v1_occproflicensecategory > 2.5) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 1.5) => 
-0.0348591602
, 

   (v1_raammbrcnt > 1.5) => 
map(

      ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 2.5) => 
map(

         ( NULL < v1_hhpropcurrownedcnt and v1_hhpropcurrownedcnt <= 1.5) => 
0.0312673276
, 

         (v1_hhpropcurrownedcnt > 1.5) => 
-0.0077094381
, 

0.0098668770
)
, 

      (v1_crtrecseverityindex > 2.5) => 
0.0480847433
, 

0.0154987248
)
, 

0.0113915214
)
, 

-0.0001336898
)
;


// Tree: 572

b4_tree_572 := 
map(

( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 3.5) => 
map(

   ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 205.5) => 
map(

      ( NULL < v1_hhteenagermmbrcnt and v1_hhteenagermmbrcnt <= 0.5) => 
-0.0006348334
, 

      (v1_hhteenagermmbrcnt > 0.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 118.5) => 
-0.1149245215
, 

         (v1_prospecttimeonrecord > 118.5) => 
0.0005692467
, 

-0.0555685911
)
, 

-0.0007081002
)
, 

   (v1_crtreclienjudgtimenewest > 205.5) => 
map(

      ( NULL < v1_crtreclienjudgcnt and v1_crtreclienjudgcnt <= 1.5) => 
0.0047795993
, 

      (v1_crtreclienjudgcnt > 1.5) => 
0.0491408506
, 

0.0177933243
)
, 

-0.0005439433
)
, 

(v1_raacollege4yrattendedmmbrcnt > 3.5) => 
map(

   ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 3.37) => 
0.0171887844
, 

   (v1_resinputavmblockratio > 3.37) => 
-0.1351014392
, 

0.0159997052
)
, 

-0.0003130836
)
;


// Tree: 576

b4_tree_576 := 
map(

( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 192.5) => 
map(

   ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 506.5) => 
-0.0009257145
, 

   (v1_lifeevtimelastmove > 506.5) => 
-0.0185321314
, 

-0.0010270538
)
, 

(v1_crtrectimenewest > 192.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 341.5) => 
0.0126195907
, 

   (v1_prospecttimeonrecord > 341.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 288.5) => 
-0.1294639331
, 

      (v1_lifeevtimelastmove > 288.5) => 
map(

         ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
map(

            ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 10.5) => 
0.1665209350
, 

            (v1_raammbrcnt > 10.5) => 
-0.0822797629
, 

0.0797299938
)
, 

         (v1_verifiedcurrresmatchindex > 0.5) => 
-0.0375757193
, 

-0.0071892996
)
, 

-0.0380333513
)
, 

0.0104116674
)
, 

-0.0007919591
)
;


// Tree: 580

b4_tree_580 := 
map(

( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.985) => 
map(

   ( NULL < v1_raaelderlymmbrcnt and v1_raaelderlymmbrcnt <= 3.5) => 
map(

      ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 706697) => 
-0.0000876459
, 

      (v1_propcurrownedavmttl > 706697) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 2.5) => 
-0.0072371261
, 

         (v1_hhcnt > 2.5) => 
0.0307019227
, 

0.0176589259
)
, 

0.0000959607
)
, 

   (v1_raaelderlymmbrcnt > 3.5) => 
0.0296337493
, 

0.0002347236
)
, 

(v1_resinputavmcntyratio > 1.985) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 170511.5) => 
0.0033609374
, 

   (v1_raapropowneravmmed > 170511.5) => 
map(

      ( NULL < v1_hhcnt and v1_hhcnt <= 4.5) => 
-0.0287034503
, 

      (v1_hhcnt > 4.5) => 
0.0057318905
, 

-0.0226385458
)
, 

-0.0098062304
)
, 

-0.0001459594
)
;


// Tree: 584

b4_tree_584 := 
map(

( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 1.5) => 
map(

      ( NULL < v1_hhpropcurrownedcnt and v1_hhpropcurrownedcnt <= 1.5) => 
map(

         ( NULL < v1_lifeevtimelastassetpurchase and v1_lifeevtimelastassetpurchase <= 23.5) => 
0.0032741877
, 

         (v1_lifeevtimelastassetpurchase > 23.5) => 
0.0168436571
, 

0.0037205068
)
, 

      (v1_hhpropcurrownedcnt > 1.5) => 
-0.0059384878
, 

0.0025567894
)
, 

   (v1_raayoungadultmmbrcnt > 1.5) => 
0.0127003678
, 

0.0033150940
)
, 

(v1_raacrtrecmsdmeanmmbrcnt > 0.5) => 
map(

   ( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 1.5) => 
-0.0025128556
, 

   (v1_prospectcollegeprogramtype > 1.5) => 
map(

      (v1_resinputdwelltype in ['0','F','P','R','S','U']) => 
0.0034420022
, 

      (v1_resinputdwelltype in ['-1','G','H']) => 
0.0326186314
, 

0.0088478579
)
, 

-0.0019278953
)
, 

0.0005960830
)
;


// Tree: 588

b4_tree_588 := 
map(

( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 4.5) => 
map(

   ( NULL < v1_raacollegeattendedmmbrcnt and v1_raacollegeattendedmmbrcnt <= 20.5) => 
map(

      ( NULL < v1_donotmail and v1_donotmail <= 0.5) => 
-0.0000256799
, 

      (v1_donotmail > 0.5) => 
map(

         ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 0.785) => 
0.0608456872
, 

         (v1_rescurravmcntyratio > 0.785) => 
map(

            ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 1.075) => 
-0.0882325891
, 

            (v1_rescurravmcntyratio > 1.075) => 
0.0181210286
, 

-0.0071658456
)
, 

0.0277088927
)
, 

0.0000406884
)
, 

   (v1_raacollegeattendedmmbrcnt > 20.5) => 
-0.0811699715
, 

0.0000115651
)
, 

(v1_raaoccproflicmmbrcnt > 4.5) => 
map(

   ( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 1.595) => 
0.0220265338
, 

   (v1_rescurravmblockratio > 1.595) => 
-0.0446335506
, 

0.0180517710
)
, 

0.0001873778
)
;


// Tree: 592

b4_tree_592 := 
map(

( NULL < v1_hhcnt and v1_hhcnt <= 9.5) => 
map(

   ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
-0.0006705957
, 

   (v1_hhyoungadultmmbrcnt > 0.5) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 415) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 0.5) => 
0.0198734774
, 

         (v1_prospecttimelastupdate > 0.5) => 
0.0053842508
, 

0.0099888996
)
, 

      (v1_propcurrownedassessedttl > 415) => 
map(

         ( NULL < v1_lifeevtimelastassetpurchase and v1_lifeevtimelastassetpurchase <= 11.5) => 
-0.0246734235
, 

         (v1_lifeevtimelastassetpurchase > 11.5) => 
map(

            ( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 901649.5) => 
0.0025383379
, 

            (v1_rescurravmvalue12mo > 901649.5) => 
-0.2599360479
, 

0.0016893641
)
, 

-0.0080133152
)
, 

0.0053637354
)
, 

0.0001742570
)
, 

(v1_hhcnt > 9.5) => 
-0.0157859123
, 

-0.0000187047
)
;


// Tree: 596

b4_tree_596 := 
map(

( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
map(

   ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 369.5) => 
map(

      ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
-0.0021444190
, 

      (v1_hhmiddleagemmbrcnt > 0.5) => 
0.0030609216
, 

-0.0007368699
)
, 

   (v1_lifeevtimelastmove > 369.5) => 
-0.0209037212
, 

-0.0010217481
)
, 

(v1_hhseniormmbrcnt > 0.5) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 10.5) => 
map(

      ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
0.0262204549
, 

      (v1_hhpropcurrownermmbrcnt > 0.5) => 
map(

         ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 0.5) => 
-0.0039221414
, 

         (v1_raacrtreclienjudgmmbrcnt > 0.5) => 
0.0127114820
, 

0.0052943860
)
, 

0.0098329919
)
, 

   (v1_crtrectimenewest > 10.5) => 
-0.0029053408
, 

0.0052419615
)
, 

-0.0004554198
)
;


// Tree: 600

b4_tree_600 := 
map(

( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
-0.0010837069
, 

   (v1_prospectcollegeattending > 0.5) => 
map(

      ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 153558) => 
-0.0085406955
, 

      (v1_resinputavmvalue > 153558) => 
-0.0523524627
, 

-0.0212173950
)
, 

-0.0014006271
)
, 

(v1_raayoungadultmmbrcnt > 0.5) => 
map(

   ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 185502) => 
0.0010011311
, 

   (v1_resinputavmvalue > 185502) => 
map(

      ( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.065) => 
map(

         ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 5.165) => 
0.0163551562
, 

         (v1_resinputavmcntyratio > 5.165) => 
-0.0662978042
, 

0.0151972333
)
, 

      (v1_rescurravmratiodiff12mo > 1.065) => 
0.0004255954
, 

0.0095432616
)
, 

0.0025301618
)
, 

0.0002698201
)
;


// Tree: 604

b4_tree_604 := 
map(

( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 483.5) => 
map(

   ( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 1.5) => 
-0.0004543486
, 

   (v1_hhcollegeattendedmmbrcnt > 1.5) => 
map(

      ( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 4.5) => 
0.0088386051
, 

      (v1_occproflicensecategory > 4.5) => 
-0.0927913242
, 

0.0078750599
)
, 

-0.0001691960
)
, 

(v1_prospecttimeonrecord > 483.5) => 
map(

   ( NULL < v1_crtreccnt and v1_crtreccnt <= 3.5) => 
-0.0271154986
, 

   (v1_crtreccnt > 3.5) => 
map(

      ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 3910) => 
map(

         ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
0.0052437071
, 

         (v1_hhmiddleagemmbrcnt > 0.5) => 
0.2048287437
, 

0.1120638675
)
, 

      (v1_crtreclienjudgamtttl > 3910) => 
-0.0392542752
, 

0.0391660762
)
, 

-0.0202725628
)
, 

-0.0002768503
)
;


// Tree: 608

b4_tree_608 := 
map(

( NULL < v1_raaseniormmbrcnt and v1_raaseniormmbrcnt <= 1.5) => 
map(

   ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 334686) => 
-0.0011476038
, 

   (v1_hhpropcurravmhighest > 334686) => 
map(

      ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 1.5) => 
map(

         ( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 0.905) => 
0.0105721491
, 

         (v1_resinputavmratiodiff60mo > 0.905) => 
-0.0087481075
, 

0.0016628079
)
, 

      (v1_crtrecseverityindex > 1.5) => 
map(

         ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 133.5) => 
0.0281089873
, 

         (v1_crtrecmsdmeantimenewest > 133.5) => 
-0.0196514560
, 

0.0215954424
)
, 

0.0069640012
)
, 

-0.0007358763
)
, 

(v1_raaseniormmbrcnt > 1.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 37581) => 
0.0202154469
, 

   (v1_raapropowneravmmed > 37581) => 
0.0029887140
, 

0.0054382822
)
, 

0.0001467051
)
;


// Tree: 612

b4_tree_612 := 
map(

( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 333874) => 
-0.0009593762
, 

(v1_hhpropcurravmhighest > 333874) => 
map(

   ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 1.5) => 
map(

      ( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 1.055) => 
0.0067733702
, 

      (v1_resinputavmratiodiff60mo > 1.055) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 62.5) => 
map(

            ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 112.5) => 
-0.0259761405
, 

            (v1_lifeevtimelastmove > 112.5) => 
0.0109531193
, 

-0.0060569664
)
, 

         (v1_prospecttimelastupdate > 62.5) => 
-0.0482881432
, 

-0.0147672612
)
, 

0.0018431302
)
, 

   (v1_crtrecseverityindex > 1.5) => 
map(

      ( NULL < v1_raainterestsportpersonmmbrcnt and v1_raainterestsportpersonmmbrcnt <= 0.5) => 
0.0232421715
, 

      (v1_raainterestsportpersonmmbrcnt > 0.5) => 
-0.0127509860
, 

0.0180552666
)
, 

0.0064522709
)
, 

-0.0005388812
)
;


// Tree: 616

b4_tree_616 := 
map(

( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 2.5) => 
-0.0004511302
, 

(v1_raacollege4yrattendedmmbrcnt > 2.5) => 
map(

   ( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 260714) => 
map(

      ( NULL < v1_raacollegetoptiermmbrcnt and v1_raacollegetoptiermmbrcnt <= 4.5) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 249.5) => 
0.0100237367
, 

         (v1_crtrectimenewest > 249.5) => 
0.0896742921
, 

0.0109203659
)
, 

      (v1_raacollegetoptiermmbrcnt > 4.5) => 
0.1335848580
, 

0.0115744021
)
, 

   (v1_rescurravmvalue12mo > 260714) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 197.5) => 
map(

         ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 679000) => 
-0.0567626081
, 

         (v1_hhpropcurravmhighest > 679000) => 
0.0497458512
, 

-0.0424043249
)
, 

      (v1_prospecttimeonrecord > 197.5) => 
0.0148341069
, 

-0.0198157111
)
, 

0.0084780086
)
, 

-0.0001512270
)
;


// Tree: 620

b4_tree_620 := 
map(

( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 174.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 35.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 7.5) => 
-0.0004262736
, 

      (v1_crtrecbkrpttimenewest > 7.5) => 
map(

         ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 97950) => 
map(

            ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 1.5) => 
-0.0508586760
, 

            (v1_crtrecseverityindex > 1.5) => 
0.0220609901
, 

-0.0063343074
)
, 

         (v1_propcurrownedavmttl > 97950) => 
-0.0742959100
, 

-0.0218000849
)
, 

-0.0006831075
)
, 

   (v1_crtrecbkrpttimenewest > 35.5) => 
map(

      ( NULL < v1_prospectcollegeattended and v1_prospectcollegeattended <= 0.5) => 
0.0038165880
, 

      (v1_prospectcollegeattended > 0.5) => 
0.0382260986
, 

0.0073840387
)
, 

-0.0002640731
)
, 

(v1_occbusinessassociationtime > 174.5) => 
0.0139077928
, 

-0.0000782633
)
;


// Tree: 624

b4_tree_624 := 
map(

( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 1.505) => 
map(

   ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 139882) => 
map(

      ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
-0.0005576555
, 

      (v1_hhyoungadultmmbrcnt > 0.5) => 
map(

         ( NULL < v1_prospectcollegeattended and v1_prospectcollegeattended <= 0.5) => 
0.0002498305
, 

         (v1_prospectcollegeattended > 0.5) => 
0.0157352159
, 

0.0053997252
)
, 

0.0002533373
)
, 

   (v1_propcurrownedassessedttl > 139882) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 1.5) => 
map(

         ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 2.5) => 
0.0495992965
, 

         (v1_raacrtrecmmbrcnt > 2.5) => 
-0.0131363397
, 

0.0307324280
)
, 

      (v1_prospecttimeonrecord > 1.5) => 
0.0047385791
, 

0.0061161299
)
, 

0.0007017762
)
, 

(v1_resinputavmblockratio > 1.505) => 
-0.0077671052
, 

0.0002508275
)
;


// Tree: 628

b4_tree_628 := 
map(

( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 149.5) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 144.5) => 
map(

      ( NULL < v1_hhcrtrecbkrptmmbrcnt and v1_hhcrtrecbkrptmmbrcnt <= 1.5) => 
0.0002885268
, 

      (v1_hhcrtrecbkrptmmbrcnt > 1.5) => 
map(

         ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 1.5) => 
map(

            ( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 108669) => 
-0.0211020868
, 

            (v1_resinputmortgageamount > 108669) => 
-0.0786006950
, 

-0.0270406941
)
, 

         (v1_crtrecseverityindex > 1.5) => 
map(

            ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 222.5) => 
0.0149711368
, 

            (v1_lifeevtimelastmove > 222.5) => 
-0.0369806360
, 

0.0039606514
)
, 

-0.0094328735
)
, 

0.0000487237
)
, 

   (v1_crtrectimenewest > 144.5) => 
0.0104915214
, 

0.0003230672
)
, 

(v1_crtrecmsdmeantimenewest > 149.5) => 
-0.0104677658
, 

0.0000146320
)
;


// Tree: 632

b4_tree_632 := 
map(

( NULL < v1_interestsportperson and v1_interestsportperson <= 0.5) => 
map(

   ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 1.125) => 
0.0005295365
, 

   (v1_rescurravmratiodiff60mo > 1.125) => 
-0.0076605174
, 

0.0002529524
)
, 

(v1_interestsportperson > 0.5) => 
map(

   ( NULL < v1_raamiddleagemmbrcnt and v1_raamiddleagemmbrcnt <= 2.5) => 
-0.0279162355
, 

   (v1_raamiddleagemmbrcnt > 2.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 70.5) => 
-0.0259719725
, 

      (v1_lifeevtimelastmove > 70.5) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 54.5) => 
0.0035161608
, 

         (v1_prospecttimelastupdate > 54.5) => 
map(

            ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 12.5) => 
0.0409955570
, 

            (v1_raacrtreclienjudgmmbrcnt > 12.5) => 
0.2813125867
, 

0.0510087666
)
, 

0.0156850847
)
, 

-0.0018763918
)
, 

-0.0135345210
)
, 

0.0000082537
)
;


// Tree: 636

b4_tree_636 := 
map(

( NULL < v1_hhoccproflicmmbrcnt and v1_hhoccproflicmmbrcnt <= 0.5) => 
-0.0006284189
, 

(v1_hhoccproflicmmbrcnt > 0.5) => 
map(

   ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 161.5) => 
map(

         ( NULL < v1_raacrtrecmmbrcnt12mo and v1_raacrtrecmmbrcnt12mo <= 5.5) => 
0.0183886547
, 

         (v1_raacrtrecmmbrcnt12mo > 5.5) => 
0.1639128181
, 

0.0194852949
)
, 

      (v1_prospecttimelastupdate > 161.5) => 
-0.0478566766
, 

0.0179722709
)
, 

   (v1_hhmiddleagemmbrcnt > 0.5) => 
map(

      ( NULL < v1_crtrecseverityindex and v1_crtrecseverityindex <= 1.5) => 
map(

         ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 112.5) => 
-0.0242643626
, 

         (v1_lifeevtimelastmove > 112.5) => 
0.0049484596
, 

-0.0047309384
)
, 

      (v1_crtrecseverityindex > 1.5) => 
0.0118441535
, 

0.0017905781
)
, 

0.0076161163
)
, 

-0.0001266016
)
;


// Tree: 640

b4_tree_640 := 
map(

( NULL < v1_propsoldratio and v1_propsoldratio <= 5.87) => 
map(

   ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 74.5) => 
map(

      ( NULL < v1_crtreclienjudgcnt and v1_crtreclienjudgcnt <= 0.5) => 
0.0006409493
, 

      (v1_crtreclienjudgcnt > 0.5) => 
0.0264346188
, 

0.0011324300
)
, 

   (v1_crtreclienjudgamtttl > 74.5) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 920610) => 
map(

         ( NULL < v1_crtrecevictioncnt and v1_crtrecevictioncnt <= 1.5) => 
-0.0079120366
, 

         (v1_crtrecevictioncnt > 1.5) => 
map(

            ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
-0.0041873816
, 

            (v1_hhyoungadultmmbrcnt > 0.5) => 
0.0535127811
, 

0.0175218976
)
, 

-0.0048777414
)
, 

      (v1_propcurrownedassessedttl > 920610) => 
0.0894034166
, 

-0.0045494035
)
, 

0.0004139687
)
, 

(v1_propsoldratio > 5.87) => 
-0.0464646567
, 

0.0003608101
)
;


// Tree: 644

b4_tree_644 := 
map(

( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 449995) => 
-0.0000693358
, 

(v1_propcurrownedavmttl > 449995) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 3.5) => 
map(

      ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 0.5) => 
-0.0142665610
, 

         (v1_raacrtrecmmbrcnt > 0.5) => 
map(

            ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 504) => 
0.0107377365
, 

            (v1_lifeevtimelastmove > 504) => 
0.1207184768
, 

0.0122805525
)
, 

0.0033452400
)
, 

      (v1_hhcrtrecmmbrcnt > 0.5) => 
map(

         ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 5.5) => 
0.0281784875
, 

         (v1_raayoungadultmmbrcnt > 5.5) => 
-0.0674313294
, 

0.0247219468
)
, 

0.0119067133
)
, 

   (v1_crtrecbkrpttimenewest > 3.5) => 
-0.0274086068
, 

0.0098104236
)
, 

0.0002477045
)
;


// Tree: 648

b4_tree_648 := 
map(

( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 1.5) => 
map(

   ( NULL < v1_raaoccproflicmmbrcnt and v1_raaoccproflicmmbrcnt <= 10.5) => 
map(

      ( NULL < v1_raappcurrownerwtrcrftmmbrcnt and v1_raappcurrownerwtrcrftmmbrcnt <= 3.5) => 
-0.0009149061
, 

      (v1_raappcurrownerwtrcrftmmbrcnt > 3.5) => 
map(

         ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 0.945) => 
-0.0474689800
, 

         (v1_rescurravmratiodiff60mo > 0.945) => 
0.0557229312
, 

-0.0360032121
)
, 

-0.0010153702
)
, 

   (v1_raaoccproflicmmbrcnt > 10.5) => 
0.0389330408
, 

-0.0009487601
)
, 

(v1_rescurrbusinesscnt > 1.5) => 
map(

   ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 68055) => 
0.0093562110
, 

   (v1_propcurrownedassessedttl > 68055) => 
map(

      ( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 4.36) => 
-0.0023051872
, 

      (v1_resinputavmblockratio > 4.36) => 
-0.1392948638
, 

-0.0030418940
)
, 

0.0050958311
)
, 

-0.0004339781
)
;


// Tree: 652

b4_tree_652 := 
map(

( NULL < v1_interestsportperson and v1_interestsportperson <= 0.5) => 
map(

   ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 23.5) => 
0.0009169098
, 

   (v1_raammbrcnt > 23.5) => 
map(

      ( NULL < v1_prospectcollegeprogramtype and v1_prospectcollegeprogramtype <= 0.5) => 
map(

         ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 96.5) => 
map(

            ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 540542.5) => 
-0.0087622522
, 

            (v1_raapropowneravmhighest > 540542.5) => 
0.0203464372
, 

-0.0035380455
)
, 

         (v1_lifeevtimelastmove > 96.5) => 
-0.0188231483
, 

-0.0097104516
)
, 

      (v1_prospectcollegeprogramtype > 0.5) => 
0.0238966591
, 

-0.0075366103
)
, 

0.0003761913
)
, 

(v1_interestsportperson > 0.5) => 
map(

   ( NULL < v1_proptimelastsale and v1_proptimelastsale <= 156.5) => 
-0.0146535111
, 

   (v1_proptimelastsale > 156.5) => 
0.0664621115
, 

-0.0129084965
)
, 

0.0001394510
)
;


// Tree: 656

b4_tree_656 := 
map(

( NULL < v1_proppurchasecnt12mo and v1_proppurchasecnt12mo <= 0.5) => 
map(

   ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 0.875) => 
map(

      ( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.005) => 
0.0001380492
, 

      (v1_rescurravmratiodiff12mo > 1.005) => 
-0.0072741705
, 

-0.0007570577
)
, 

   (v1_resinputavmcntyratio > 0.875) => 
0.0037562751
, 

0.0002086132
)
, 

(v1_proppurchasecnt12mo > 0.5) => 
map(

   ( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 237150) => 
map(

      ( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 2.5) => 
map(

         ( NULL < v1_lifeevnamechangecnt12mo and v1_lifeevnamechangecnt12mo <= 0.5) => 
-0.0138164808
, 

         (v1_lifeevnamechangecnt12mo > 0.5) => 
-0.0460383144
, 

-0.0211516217
)
, 

      (v1_hhcollegeattendedmmbrcnt > 2.5) => 
0.1203166877
, 

-0.0197651462
)
, 

   (v1_resinputmortgageamount > 237150) => 
0.0260506755
, 

-0.0117649497
)
, 

0.0000353907
)
;


// Tree: 660

b4_tree_660 := 
map(

( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 42985) => 
-0.0014684749
, 

(v1_resinputmortgageamount > 42985) => 
map(

   ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 1.5) => 
map(

      ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 161077.5) => 
map(

         ( NULL < v1_hhpropcurrownedcnt and v1_hhpropcurrownedcnt <= 1.5) => 
0.0293547749
, 

         (v1_hhpropcurrownedcnt > 1.5) => 
-0.0004758574
, 

0.0092707848
)
, 

      (v1_raapropowneravmmed > 161077.5) => 
map(

         ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= 48.5) => 
map(

            ( NULL < v1_propeverownedcnt and v1_propeverownedcnt <= 1.5) => 
-0.0432520789
, 

            (v1_propeverownedcnt > 1.5) => 
0.0229029675
, 

-0.0312294367
)
, 

         (v1_lifeevtimefirstassetpurchase > 48.5) => 
-0.0041577752
, 

-0.0105220521
)
, 

-0.0009218410
)
, 

   (v1_raacrtreclienjudgmmbrcnt > 1.5) => 
0.0145389327
, 

0.0053460403
)
, 

-0.0010543581
)
;


// Tree: 664

b4_tree_664 := 
map(

( NULL < v1_resinputmortgagetype and v1_resinputmortgagetype <= 1.5) => 
map(

   ( NULL < v1_lifeevnamechange and v1_lifeevnamechange <= 0.5) => 
-0.0005749297
, 

   (v1_lifeevnamechange > 0.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 371.5) => 
map(

         ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.075) => 
map(

            ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 314.5) => 
0.0123112053
, 

            (v1_crtrectimenewest > 314.5) => 
-0.1621584784
, 

0.0120082837
)
, 

         (v1_resinputavmratiodiff12mo > 1.075) => 
-0.0030060582
, 

0.0076585523
)
, 

      (v1_lifeevtimelastmove > 371.5) => 
-0.0273127766
, 

0.0062529321
)
, 

-0.0000373252
)
, 

(v1_resinputmortgagetype > 1.5) => 
map(

   ( NULL < v1_crtreccnt and v1_crtreccnt <= 12.5) => 
0.0216349622
, 

   (v1_crtreccnt > 12.5) => 
0.2262044447
, 

0.0240416620
)
, 

0.0000617876
)
;


// Tree: 668

b4_tree_668 := 
map(

( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 269.5) => 
map(

   ( NULL < v1_propsoldratio and v1_propsoldratio <= 1.265) => 
-0.0012813755
, 

   (v1_propsoldratio > 1.265) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 46) => 
map(

         ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 280500) => 
0.2694444647
, 

         (v1_resinputavmvalue > 280500) => 
-0.0208161408
, 

0.1701447838
)
, 

      (v1_prospecttimeonrecord > 46) => 
0.0147084963
, 

0.0176210105
)
, 

-0.0011137019
)
, 

(v1_lifeevtimelastmove > 269.5) => 
map(

   ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
0.0113389666
, 

   (v1_lifeeveverresidedcnt > 1.5) => 
map(

      ( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 1.035) => 
0.0020070970
, 

      (v1_resinputavmratiodiff60mo > 1.035) => 
-0.0277461162
, 

-0.0020115306
)
, 

0.0067577158
)
, 

-0.0005044234
)
;


// Tree: 672

b4_tree_672 := 
map(

( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 2318750) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 573330.5) => 
0.0005515209
, 

   (v1_raapropowneravmmed > 573330.5) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 38.5) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 12.5) => 
map(

            ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.735) => 
-0.0018684130
, 

            (v1_resinputavmcntyratio > 1.735) => 
-0.0422311621
, 

-0.0118611324
)
, 

         (v1_raammbrcnt > 12.5) => 
0.0264845893
, 

-0.0038079254
)
, 

      (v1_prospecttimelastupdate > 38.5) => 
-0.0289408906
, 

-0.0092667895
)
, 

0.0003270124
)
, 

(v1_rescurravmvalue60mo > 2318750) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 67) => 
-0.1858313102
, 

   (v1_prospecttimeonrecord > 67) => 
0.0827739005
, 

0.0571924518
)
, 

0.0003607456
)
;


// Tree: 676

b4_tree_676 := 
map(

( NULL < v1_ppcurrowner and v1_ppcurrowner <= 0.5) => 
0.0001574484
, 

(v1_ppcurrowner > 0.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 351.5) => 
map(

      ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 530940) => 
-0.0117671680
, 

      (v1_resinputavmvalue60mo > 530940) => 
0.1015215905
, 

-0.0094855613
)
, 

   (v1_prospecttimeonrecord > 351.5) => 
map(

      ( NULL < v1_raacrtrecmsdmeanmmbrcnt12mo and v1_raacrtrecmsdmeanmmbrcnt12mo <= 0.5) => 
map(

         ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 151374) => 
map(

            ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 2.5) => 
-0.1302603497
, 

            (v1_raacrtrecmmbrcnt > 2.5) => 
0.0046295703
, 

-0.0763043817
)
, 

         (v1_resinputavmvalue12mo > 151374) => 
-0.2605238058
, 

-0.1045315515
)
, 

      (v1_raacrtrecmsdmeanmmbrcnt12mo > 0.5) => 
0.0400801617
, 

-0.0726987844
)
, 

-0.0133632242
)
, 

0.0000160238
)
;


// Tree: 680

b4_tree_680 := 
map(

( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 29049.5) => 
0.0002552142
, 

(v1_crtreclienjudgamtttl > 29049.5) => 
map(

   ( NULL < v1_lifeevtimelastassetpurchase and v1_lifeevtimelastassetpurchase <= 99.5) => 
-0.0092963331
, 

   (v1_lifeevtimelastassetpurchase > 99.5) => 
map(

      ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 348) => 
map(

         ( NULL < v1_prospectcollegetier and v1_prospectcollegetier <= 3.5) => 
map(

            ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 56002) => 
-0.0971198432
, 

            (v1_crtreclienjudgamtttl > 56002) => 
map(

               ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 137935) => 
-0.0615622761
, 

               (v1_propcurrownedassessedttl > 137935) => 
0.0441519111
, 

-0.0315689486
)
, 

-0.0605134995
)
, 

         (v1_prospectcollegetier > 3.5) => 
0.1470268591
, 

-0.0552593132
)
, 

      (v1_occbusinessassociationtime > 348) => 
0.1422890692
, 

-0.0489648794
)
, 

-0.0156333601
)
, 

0.0000914581
)
;


// Tree: 684

b4_tree_684 := 
map(

( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 152.5) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 4.5) => 
0.0000552891
, 

   (v1_hhcnt > 4.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 141.5) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 73.5) => 
map(

            ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 201214) => 
-0.0235080412
, 

            (v1_resinputavmvalue > 201214) => 
0.0062512672
, 

-0.0171838936
)
, 

         (v1_prospecttimelastupdate > 73.5) => 
-0.0425147206
, 

-0.0216343953
)
, 

      (v1_prospecttimeonrecord > 141.5) => 
0.0041539055
, 

-0.0114576451
)
, 

-0.0006783604
)
, 

(v1_lifeevtimelastmove > 152.5) => 
map(

   ( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 1.5) => 
0.0007975838
, 

   (v1_rescurrbusinesscnt > 1.5) => 
0.0108908567
, 

0.0028288311
)
, 

0.0000181555
)
;


// Tree: 688

b4_tree_688 := 
map(

( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 659854) => 
map(

   ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 3.5) => 
map(

      ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 1.5) => 
0.0001139906
, 

      (v1_hhseniormmbrcnt > 1.5) => 
map(

         ( NULL < v1_propeverownedcnt and v1_propeverownedcnt <= 0.5) => 
map(

            ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
-0.0434218871
, 

            (v1_lifeeveverresidedcnt > 0.5) => 
0.0329414391
, 

0.0269837081
)
, 

         (v1_propeverownedcnt > 0.5) => 
0.0037136353
, 

0.0109076930
)
, 

0.0003697495
)
, 

   (v1_hhcrtrecmmbrcnt > 3.5) => 
-0.0167126295
, 

0.0001442282
)
, 

(v1_resinputavmvalue > 659854) => 
map(

   ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 44.5) => 
-0.0178285147
, 

   (v1_crtreclienjudgtimenewest > 44.5) => 
0.0465458015
, 

-0.0151144113
)
, 

-0.0001566294
)
;


// Tree: 692

b4_tree_692 := 
map(

( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 509.5) => 
map(

   ( NULL < v1_propsoldratio and v1_propsoldratio <= 0.915) => 
map(

      ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 297.5) => 
map(

         ( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 2.5) => 
-0.0007216913
, 

         (v1_occproflicensecategory > 2.5) => 
map(

            ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 10.5) => 
0.0577472038
, 

            (v1_prospecttimeonrecord > 10.5) => 
0.0062255270
, 

0.0119028918
)
, 

-0.0005582877
)
, 

      (v1_crtreclienjudgtimenewest > 297.5) => 
0.1848850133
, 

-0.0005483793
)
, 

   (v1_propsoldratio > 0.915) => 
map(

      ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 1.955) => 
0.0166240807
, 

      (v1_resinputavmtractratio > 1.955) => 
-0.0471358989
, 

0.0125066272
)
, 

-0.0003810495
)
, 

(v1_lifeevtimelastmove > 509.5) => 
-0.0210895951
, 

-0.0004930309
)
;


// Tree: 696

b4_tree_696 := 
map(

( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 8.285) => 
map(

   ( NULL < v1_rescurravmvalue and v1_rescurravmvalue <= 825500) => 
0.0002484350
, 

   (v1_rescurravmvalue > 825500) => 
map(

      ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 1367372.5) => 
map(

         ( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 748485.5) => 
0.0010829535
, 

         (v1_rescurravmvalue60mo > 748485.5) => 
map(

            ( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 803250) => 
-0.0436910076
, 

            (v1_resinputmortgageamount > 803250) => 
-0.2060012785
, 

-0.0470376111
)
, 

-0.0287902930
)
, 

      (v1_propcurrownedavmttl > 1367372.5) => 
0.0192849795
, 

-0.0170037226
)
, 

0.0001331138
)
, 

(v1_rescurravmratiodiff12mo > 8.285) => 
map(

   ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 79950) => 
-0.0769385773
, 

   (v1_raapropowneravmhighest > 79950) => 
0.1603739298
, 

0.1019585435
)
, 

0.0001598230
)
;


// Tree: 700

b4_tree_700 := 
map(

( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 174423.5) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 6.5) => 
map(

      ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
-0.0003222660
, 

      (v1_hhseniormmbrcnt > 0.5) => 
map(

         ( NULL < v1_hhpropcurrownedcnt and v1_hhpropcurrownedcnt <= 1.5) => 
map(

            ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 74.5) => 
0.0254273334
, 

            (v1_prospecttimelastupdate > 74.5) => 
-0.0049305045
, 

0.0170118957
)
, 

         (v1_hhpropcurrownedcnt > 1.5) => 
-0.0002287738
, 

0.0075252311
)
, 

0.0002860239
)
, 

   (v1_crtrectimenewest > 6.5) => 
map(

      ( NULL < v1_prospectcollegeattended and v1_prospectcollegeattended <= 0.5) => 
-0.0068172448
, 

      (v1_prospectcollegeattended > 0.5) => 
0.0098574085
, 

-0.0043602786
)
, 

-0.0010154430
)
, 

(v1_resinputmortgageamount > 174423.5) => 
0.0108343767
, 

-0.0006856331
)
;


// Tree: 704

b4_tree_704 := 
map(

( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 81.5) => 
map(

   ( NULL < v1_crtreccnt and v1_crtreccnt <= 11.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 168.5) => 
0.0000276044
, 

      (v1_lifeevtimelastmove > 168.5) => 
map(

         ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
-0.0032824206
, 

         (v1_hhmiddleagemmbrcnt > 0.5) => 
map(

            ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 1192.5) => 
0.0109559000
, 

            (v1_crtreclienjudgamtttl > 1192.5) => 
-0.0052508165
, 

0.0078345062
)
, 

0.0045475284
)
, 

0.0006235472
)
, 

   (v1_crtreccnt > 11.5) => 
-0.0219704797
, 

0.0000612806
)
, 

(v1_prospecttimelastupdate > 81.5) => 
map(

   ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 0.835) => 
-0.0019639650
, 

   (v1_rescurravmratiodiff60mo > 0.835) => 
-0.0131505737
, 

-0.0051364748
)
, 

-0.0004231642
)
;


// Tree: 708

b4_tree_708 := 
map(

( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 139258) => 
-0.0012404619
, 

(v1_resinputavmvalue > 139258) => 
map(

   ( NULL < v1_resinputavmratiodiff60mo and v1_resinputavmratiodiff60mo <= 0.775) => 
0.0114417146
, 

   (v1_resinputavmratiodiff60mo > 0.775) => 
map(

      (v1_resinputdwelltype in ['F','P','R','S']) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 152760.5) => 
0.0061798722
, 

         (v1_raapropowneravmmed > 152760.5) => 
-0.0047472899
, 

-0.0000964582
)
, 

      (v1_resinputdwelltype in ['-1','0','G','H','U']) => 
map(

         ( NULL < v1_raammbrcnt and v1_raammbrcnt <= 3.5) => 
-0.0046869825
, 

         (v1_raammbrcnt > 3.5) => 
map(

            ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 0) => 
0.1028159963
, 

            (v1_prospecttimeonrecord > 0) => 
0.0096997061
, 

0.0451300452
)
, 

0.0242457481
)
, 

0.0011532287
)
, 

0.0041815645
)
, 

0.0000604971
)
;


// Tree: 712

b4_tree_712 := 
map(

(v1_rescurrdwelltype in ['P','R','U']) => 
map(

   ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 149.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 327) => 
-0.0564744150
, 

      (v1_lifeevtimelastmove > 327) => 
0.0926003392
, 

-0.0440157180
)
, 

   (v1_occbusinessassociationtime > 149.5) => 
-0.2179989017
, 

-0.0498313118
)
, 

(v1_rescurrdwelltype in ['-1','F','H','S']) => 
map(

   ( NULL < v1_propcurrownedavmttl and v1_propcurrownedavmttl <= 1438488.5) => 
map(

      ( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 40.5) => 
-0.0006145469
, 

      (v1_resinputbusinesscnt > 40.5) => 
map(

         ( NULL < v1_lifeevecontrajectory and v1_lifeevecontrajectory <= 1.5) => 
0.0240607891
, 

         (v1_lifeevecontrajectory > 1.5) => 
0.1446694387
, 

0.0285116148
)
, 

-0.0004514518
)
, 

   (v1_propcurrownedavmttl > 1438488.5) => 
0.0318967682
, 

-0.0003675239
)
, 

-0.0004391833
)
;


// Tree: 716

b4_tree_716 := 
map(

( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 43.5) => 
map(

   ( NULL < v1_hhcrtreclienjudgmmbrcnt and v1_hhcrtreclienjudgmmbrcnt <= 0.5) => 
-0.0001888213
, 

   (v1_hhcrtreclienjudgmmbrcnt > 0.5) => 
map(

      ( NULL < v1_rescurravmtractratio and v1_rescurravmtractratio <= 1.165) => 
0.0115257038
, 

      (v1_rescurravmtractratio > 1.165) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 115.5) => 
-0.0163871036
, 

         (v1_prospecttimeonrecord > 115.5) => 
0.0654154485
, 

0.0483786690
)
, 

0.0166677879
)
, 

0.0001793507
)
, 

(v1_hhcrtreclienjudgamtttl > 43.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 31.5) => 
map(

      ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 545054) => 
-0.0084018401
, 

      (v1_hhpropcurravmhighest > 545054) => 
0.0242546773
, 

-0.0075631068
)
, 

   (v1_crtrecbkrpttimenewest > 31.5) => 
0.0087453060
, 

-0.0048108381
)
, 

-0.0006544887
)
;


// Tree: 720

b4_tree_720 := 
map(

( NULL < v1_hhteenagermmbrcnt and v1_hhteenagermmbrcnt <= 0.5) => 
map(

   ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 7.5) => 
map(

      ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 0.5) => 
map(

         ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 0.5) => 
0.0022691838
, 

         (v1_raayoungadultmmbrcnt > 0.5) => 
0.0081120511
, 

0.0035080006
)
, 

      (v1_raacrtrecfelonymmbrcnt > 0.5) => 
-0.0109193832
, 

0.0025171186
)
, 

   (v1_raacrtreclienjudgamtmax > 7.5) => 
map(

      ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
-0.0059227919
, 

      (v1_hhcnt > 1.5) => 
0.0026468212
, 

-0.0019986536
)
, 

0.0006786330
)
, 

(v1_hhteenagermmbrcnt > 0.5) => 
map(

   ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 139) => 
-0.0549907756
, 

   (v1_occbusinessassociationtime > 139) => 
0.1488732036
, 

-0.0480408672
)
, 

0.0006094280
)
;


// Tree: 724

b4_tree_724 := 
map(

( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 1.5) => 
map(

   ( NULL < v1_raaseniormmbrcnt and v1_raaseniormmbrcnt <= 1.5) => 
-0.0014372429
, 

   (v1_raaseniormmbrcnt > 1.5) => 
0.0037678148
, 

-0.0007023149
)
, 

(v1_hhyoungadultmmbrcnt > 1.5) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 35.5) => 
0.0027988763
, 

   (v1_crtrectimenewest > 35.5) => 
map(

      ( NULL < v1_raaelderlymmbrcnt and v1_raaelderlymmbrcnt <= 0.5) => 
0.0394100420
, 

      (v1_raaelderlymmbrcnt > 0.5) => 
map(

         ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= 156.5) => 
map(

            ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 198.5) => 
0.0156934848
, 

            (v1_crtrectimenewest > 198.5) => 
-0.1168785824
, 

0.0085787048
)
, 

         (v1_lifeevtimefirstassetpurchase > 156.5) => 
-0.1258852134
, 

-0.0006096629
)
, 

0.0273316602
)
, 

0.0098712624
)
, 

-0.0004080687
)
;


// Tree: 728

b4_tree_728 := 
map(

( NULL < v1_hhoccproflicmmbrcnt and v1_hhoccproflicmmbrcnt <= 0.5) => 
-0.0002621545
, 

(v1_hhoccproflicmmbrcnt > 0.5) => 
map(

   ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 4.5) => 
0.0086112327
, 

   (v1_crtrecbkrpttimenewest > 4.5) => 
map(

      ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 1.315) => 
map(

         ( NULL < v1_crtrecevictiontimenewest and v1_crtrecevictiontimenewest <= 26.5) => 
map(

            ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 32.5) => 
-0.0776702229
, 

            (v1_crtrecbkrpttimenewest > 32.5) => 
-0.0123983369
, 

-0.0248330708
)
, 

         (v1_crtrecevictiontimenewest > 26.5) => 
map(

            ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 85.5) => 
0.1574308442
, 

            (v1_lifeevtimelastmove > 85.5) => 
-0.0186530380
, 

0.0561826119
)
, 

-0.0172923441
)
, 

      (v1_rescurravmratiodiff60mo > 1.315) => 
0.0937150566
, 

-0.0128892573
)
, 

0.0060396787
)
, 

0.0001184416
)
;


// Tree: 732

b4_tree_732 := 
map(

( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 694008) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 35.5) => 
map(

      ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 35.5) => 
-0.0002801039
, 

      (v1_crtrectimenewest > 35.5) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 184315.5) => 
map(

            ( NULL < v1_hhpropcurravmhighest and v1_hhpropcurravmhighest <= 342516.5) => 
0.0034946341
, 

            (v1_hhpropcurravmhighest > 342516.5) => 
0.0618994883
, 

0.0047580584
)
, 

         (v1_raapropowneravmmed > 184315.5) => 
0.0203132832
, 

0.0093173073
)
, 

0.0006930604
)
, 

   (v1_prospecttimelastupdate > 35.5) => 
-0.0031303473
, 

-0.0001135333
)
, 

(v1_resinputavmvalue60mo > 694008) => 
map(

   ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= 21.5) => 
0.0054002903
, 

   (v1_lifeevtimefirstassetpurchase > 21.5) => 
0.0353276550
, 

0.0149377750
)
, 

0.0000938288
)
;


// Tree: 736

b4_tree_736 := 
map(

( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

   ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 69778.5) => 
0.0006280281
, 

   (v1_resinputavmvalue60mo > 69778.5) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 138368) => 
0.0179965600
, 

      (v1_propcurrownedassessedttl > 138368) => 
-0.0418410385
, 

0.0162719477
)
, 

0.0017005881
)
, 

(v1_resinputownershipindex > 0.5) => 
map(

   ( NULL < v1_hhcrtrecbkrptmmbrcnt and v1_hhcrtrecbkrptmmbrcnt <= 1.5) => 
map(

      ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 16807) => 
-0.0016984612
, 

      (v1_crtreclienjudgamtttl > 16807) => 
-0.0242806495
, 

-0.0021066104
)
, 

   (v1_hhcrtrecbkrptmmbrcnt > 1.5) => 
map(

      ( NULL < v1_crtreccnt and v1_crtreccnt <= 3.5) => 
-0.0218641574
, 

      (v1_crtreccnt > 3.5) => 
0.0131188699
, 

-0.0124475972
)
, 

-0.0024651567
)
, 

-0.0006445976
)
;


// Tree: 740

b4_tree_740 := 
map(

( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
map(

   ( NULL < v1_hhcollegeattendedmmbrcnt and v1_hhcollegeattendedmmbrcnt <= 1.5) => 
-0.0012242034
, 

   (v1_hhcollegeattendedmmbrcnt > 1.5) => 
0.0132388196
, 

-0.0009511967
)
, 

(v1_hhyoungadultmmbrcnt > 0.5) => 
map(

   ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 0.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 33.5) => 
map(

         ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 0.5) => 
0.0182085285
, 

         (v1_hhcrtrecmmbrcnt > 0.5) => 
0.0024241711
, 

0.0077903560
)
, 

      (v1_crtrecbkrpttimenewest > 33.5) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 77.5) => 
0.0912179027
, 

         (v1_crtrecbkrpttimenewest > 77.5) => 
0.0224455096
, 

0.0453117514
)
, 

0.0103064667
)
, 

   (v1_hhpropcurrownermmbrcnt > 0.5) => 
-0.0012346240
, 

0.0045465269
)
, 

-0.0001665525
)
;


// Tree: 744

b4_tree_744 := 
map(

( NULL < v1_hhpropcurrownedcnt and v1_hhpropcurrownedcnt <= 1.5) => 
map(

   ( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 1.5) => 
map(

      ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 2.5) => 
map(

         ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
0.0007716588
, 

         (v1_lifeevtimefirstassetpurchase > -0.5) => 
-0.0106812105
, 

0.0001581811
)
, 

      (v1_resinputownershipindex > 2.5) => 
0.0068629767
, 

0.0006204405
)
, 

   (v1_occproflicensecategory > 1.5) => 
map(

      ( NULL < v1_raacollege2yrattendedmmbrcnt and v1_raacollege2yrattendedmmbrcnt <= 2.5) => 
0.0253336484
, 

      (v1_raacollege2yrattendedmmbrcnt > 2.5) => 
-0.1282730126
, 

0.0233861788
)
, 

0.0009028069
)
, 

(v1_hhpropcurrownedcnt > 1.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 54.5) => 
-0.0187635602
, 

   (v1_prospecttimeonrecord > 54.5) => 
-0.0014820656
, 

-0.0029821588
)
, 

0.0002081806
)
;


// Tree: 748

b4_tree_748 := 
map(

( NULL < v1_donotmail and v1_donotmail <= 0.5) => 
map(

   ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 2.5) => 
-0.0012282471
, 

   (v1_resinputownershipindex > 2.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 140.5) => 
0.0025088575
, 

      (v1_crtrecbkrpttimenewest > 140.5) => 
0.0280611296
, 

0.0032669214
)
, 

-0.0004786826
)
, 

(v1_donotmail > 0.5) => 
map(

   ( NULL < v1_hhcollegetiermmbrhighest and v1_hhcollegetiermmbrhighest <= 0.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 69) => 
0.1185248339
, 

      (v1_prospecttimeonrecord > 69) => 
map(

         ( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.205) => 
0.0147615454
, 

         (v1_rescurravmratiodiff12mo > 1.205) => 
0.1369190389
, 

0.0312887357
)
, 

0.0571164004
)
, 

   (v1_hhcollegetiermmbrhighest > 0.5) => 
-0.0372982205
, 

0.0410561814
)
, 

-0.0003811326
)
;


// Tree: 752

b4_tree_752 := 
map(

( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 1.5) => 
map(

   ( NULL < v1_crtreclienjudgamtttl and v1_crtreclienjudgamtttl <= 226754.5) => 
map(

      ( NULL < v1_raaseniormmbrcnt and v1_raaseniormmbrcnt <= 0.5) => 
0.0004641015
, 

      (v1_raaseniormmbrcnt > 0.5) => 
0.0056600605
, 

0.0014245202
)
, 

   (v1_crtreclienjudgamtttl > 226754.5) => 
0.0882078476
, 

0.0014850645
)
, 

(v1_raacrtrecmsdmeanmmbrcnt > 1.5) => 
map(

   ( NULL < v1_propcurrownedcnt and v1_propcurrownedcnt <= 4.5) => 
map(

      ( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.405) => 
-0.0018970048
, 

      (v1_rescurravmratiodiff12mo > 1.405) => 
-0.0159410090
, 

-0.0024183796
)
, 

   (v1_propcurrownedcnt > 4.5) => 
map(

      ( NULL < v1_rescurravmvalue and v1_rescurravmvalue <= 176061) => 
0.0713263791
, 

      (v1_rescurravmvalue > 176061) => 
-0.0105811007
, 

0.0389888805
)
, 

-0.0022442760
)
, 

0.0001070518
)
;


// Tree: 756

b4_tree_756 := 
map(

( NULL < v1_lifeevnamechangecnt12mo and v1_lifeevnamechangecnt12mo <= 0.5) => 
0.0001105571
, 

(v1_lifeevnamechangecnt12mo > 0.5) => 
map(

   ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 32.5) => 
map(

      ( NULL < v1_lifeevecontrajectoryindex and v1_lifeevecontrajectoryindex <= 3.5) => 
-0.0299286243
, 

      (v1_lifeevecontrajectoryindex > 3.5) => 
map(

         ( NULL < v1_hhcollegetiermmbrhighest and v1_hhcollegetiermmbrhighest <= 1.5) => 
-0.0726800105
, 

         (v1_hhcollegetiermmbrhighest > 1.5) => 
-0.2528531648
, 

-0.0973811688
)
, 

-0.0332293802
)
, 

   (v1_lifeevtimelastmove > 32.5) => 
map(

      ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 424811.5) => 
map(

         ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 259231.5) => 
0.0054216405
, 

         (v1_resinputavmvalue60mo > 259231.5) => 
0.0680275288
, 

0.0119510890
)
, 

      (v1_resinputavmvalue12mo > 424811.5) => 
-0.0804463783
, 

0.0073483535
)
, 

-0.0159097278
)
, 

-0.0001752562
)
;


// Tree: 760

b4_tree_760 := 
map(

( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 0.5) => 
map(

   ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 0.5) => 
map(

      ( NULL < v1_raacollegetoptiermmbrcnt and v1_raacollegetoptiermmbrcnt <= 0.5) => 
-0.0032837251
, 

      (v1_raacollegetoptiermmbrcnt > 0.5) => 
0.0348716691
, 

-0.0028861013
)
, 

   (v1_raapropcurrownermmbrcnt > 0.5) => 
map(

      ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 0.5) => 
map(

         ( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 680626.5) => 
0.0266025653
, 

         (v1_rescurravmvalue12mo > 680626.5) => 
-0.1046819822
, 

0.0246882089
)
, 

      (v1_raacrtrecmmbrcnt > 0.5) => 
map(

         ( NULL < v1_lifeevtimefirstassetpurchase and v1_lifeevtimefirstassetpurchase <= -0.5) => 
0.0077052656
, 

         (v1_lifeevtimefirstassetpurchase > -0.5) => 
-0.0038276693
, 

0.0054626643
)
, 

0.0070121716
)
, 

0.0015317637
)
, 

(v1_resinputownershipindex > 0.5) => 
-0.0015919065
, 

-0.0002221148
)
;


// Tree: 764

b4_tree_764 := 
map(

( NULL < v1_ppcurrownedcnt and v1_ppcurrownedcnt <= 1.5) => 
map(

   ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 5.5) => 
map(

      ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
0.0020486810
, 

      (v1_prospectcollegeattending > 0.5) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 0.5) => 
map(

            ( NULL < v1_crtrecmsdmeancnt and v1_crtrecmsdmeancnt <= 2.5) => 
-0.0368626408
, 

            (v1_crtrecmsdmeancnt > 2.5) => 
0.0774663324
, 

-0.0334763102
)
, 

         (v1_prospecttimelastupdate > 0.5) => 
0.0175695747
, 

-0.0214439349
)
, 

0.0016018616
)
, 

   (v1_raacrtreclienjudgamtmax > 5.5) => 
map(

      ( NULL < v1_prospectcollegetier and v1_prospectcollegetier <= 1.5) => 
-0.0033188430
, 

      (v1_prospectcollegetier > 1.5) => 
0.0078962453
, 

-0.0026566601
)
, 

-0.0001333261
)
, 

(v1_ppcurrownedcnt > 1.5) => 
-0.0252991515
, 

-0.0002207653
)
;


// Tree: 768

b4_tree_768 := 
map(

( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 24.5) => 
map(

   ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 1.5) => 
-0.0000969216
, 

   (v1_hhyoungadultmmbrcnt > 1.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 111.5) => 
map(

         ( NULL < v1_hhcnt and v1_hhcnt <= 5.5) => 
0.0226077310
, 

         (v1_hhcnt > 5.5) => 
-0.0147428618
, 

0.0172598052
)
, 

      (v1_lifeevtimelastmove > 111.5) => 
-0.0070258501
, 

0.0086377212
)
, 

0.0001442852
)
, 

(v1_raapropcurrownermmbrcnt > 24.5) => 
map(

   ( NULL < v1_resinputavmvalue60mo and v1_resinputavmvalue60mo <= 476489) => 
map(

      ( NULL < v1_raacrtrecmmbrcnt12mo and v1_raacrtrecmmbrcnt12mo <= 0.5) => 
0.1239776354
, 

      (v1_raacrtrecmmbrcnt12mo > 0.5) => 
0.0276352593
, 

0.0372832798
)
, 

   (v1_resinputavmvalue60mo > 476489) => 
-0.0651748749
, 

0.0285662902
)
, 

0.0002319126
)
;


// Tree: 772

b4_tree_772 := 
map(

( NULL < v1_prospectcollegeprivate and v1_prospectcollegeprivate <= 0.5) => 
-0.0005427660
, 

(v1_prospectcollegeprivate > 0.5) => 
map(

   ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 308418) => 
0.0317648393
, 

   (v1_raapropowneravmhighest > 308418) => 
map(

      ( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 1.315) => 
map(

         ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 13044.5) => 
0.0100242455
, 

         (v1_hhcrtreclienjudgamtttl > 13044.5) => 
0.1793802975
, 

0.0164856210
)
, 

      (v1_resinputavmcntyratio > 1.315) => 
map(

         ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 113) => 
map(

            ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 3.73) => 
-0.0375602475
, 

            (v1_rescurravmcntyratio > 3.73) => 
0.1536523243
, 

-0.0242004172
)
, 

         (v1_hhcrtreclienjudgamtttl > 113) => 
-0.1951445337
, 

-0.0366578832
)
, 

-0.0011337690
)
, 

0.0181484708
)
, 

-0.0004069965
)
;


// Tree: 776

b4_tree_776 := 
map(

( NULL < v1_raaseniormmbrcnt and v1_raaseniormmbrcnt <= 0.5) => 
-0.0012002970
, 

(v1_raaseniormmbrcnt > 0.5) => 
map(

   ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 1.5) => 
map(

      ( NULL < v1_hhpropcurrownermmbrcnt and v1_hhpropcurrownermmbrcnt <= 2.5) => 
map(

         ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 3.5) => 
0.0225028699
, 

         (v1_raacrtrecmmbrcnt > 3.5) => 
map(

            ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
-0.0047397036
, 

            (v1_verifiedcurrresmatchindex > 0.5) => 
0.0226768201
, 

0.0015548452
)
, 

0.0113060608
)
, 

      (v1_hhpropcurrownermmbrcnt > 2.5) => 
-0.0464033679
, 

0.0104801179
)
, 

   (v1_raapropcurrownermmbrcnt > 1.5) => 
map(

      ( NULL < v1_rescurravmratiodiff60mo and v1_rescurravmratiodiff60mo <= 0.815) => 
0.0036700553
, 

      (v1_rescurravmratiodiff60mo > 0.815) => 
-0.0043702473
, 

0.0017923447
)
, 

0.0032796957
)
, 

0.0001720809
)
;


// Tree: 780

b4_tree_780 := 
map(

( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 183488.5) => 
-0.0007149111
, 

(v1_resinputavmvalue > 183488.5) => 
map(

   ( NULL < v1_resinputavmtractratio and v1_resinputavmtractratio <= 0.475) => 
0.0588874602
, 

   (v1_resinputavmtractratio > 0.475) => 
map(

      ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 79.5) => 
map(

         ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 195406) => 
0.0146237477
, 

         (v1_raapropowneravmhighest > 195406) => 
map(

            (v1_resinputdwelltype in ['R','S']) => 
map(

               ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 1.5) => 
-0.0054099315
, 

               (v1_raayoungadultmmbrcnt > 1.5) => 
0.0075663079
, 

-0.0012962368
)
, 

            (v1_resinputdwelltype in ['-1','0','F','G','H','P','U']) => 
0.0318176578
, 

0.0000667570
)
, 

0.0057881875
)
, 

      (v1_prospecttimelastupdate > 79.5) => 
-0.0094120365
, 

0.0042695535
)
, 

0.0048186840
)
, 

0.0003223198
)
;


// Tree: 784

b4_tree_784 := 
map(

( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.065) => 
map(

   ( NULL < v1_raacrtrecfelonymmbrcnt and v1_raacrtrecfelonymmbrcnt <= 2.5) => 
0.0015231400
, 

   (v1_raacrtrecfelonymmbrcnt > 2.5) => 
map(

      ( NULL < v1_lifeevtimelastassetpurchase and v1_lifeevtimelastassetpurchase <= 18.5) => 
map(

         ( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 62261.5) => 
-0.0198892776
, 

         (v1_rescurravmvalue60mo > 62261.5) => 
0.0345213732
, 

-0.0140312655
)
, 

      (v1_lifeevtimelastassetpurchase > 18.5) => 
-0.0475155692
, 

-0.0164695213
)
, 

0.0009332556
)
, 

(v1_resinputavmratiodiff12mo > 1.065) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 273.5) => 
-0.0054085579
, 

   (v1_prospecttimeonrecord > 273.5) => 
map(

      ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 1274664) => 
0.0097134464
, 

      (v1_raapropowneravmhighest > 1274664) => 
-0.0682390040
, 

0.0077959413
)
, 

-0.0045023422
)
, 

-0.0003400971
)
;


// Tree: 788

b4_tree_788 := 
map(

( NULL < v1_hhcollegeprivatemmbrcnt and v1_hhcollegeprivatemmbrcnt <= 0.5) => 
-0.0007231250
, 

(v1_hhcollegeprivatemmbrcnt > 0.5) => 
map(

   ( NULL < v1_raacollege4yrattendedmmbrcnt and v1_raacollege4yrattendedmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 110575) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 140) => 
0.0195709224
, 

         (v1_prospecttimeonrecord > 140) => 
0.0632325061
, 

0.0356720380
)
, 

      (v1_rescurrmortgageamount > 110575) => 
-0.0260448738
, 

0.0263579201
)
, 

   (v1_raacollege4yrattendedmmbrcnt > 0.5) => 
map(

      ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 55) => 
0.0261212065
, 

      (v1_prospecttimeonrecord > 55) => 
map(

         ( NULL < v1_hhpropcurrownedcnt and v1_hhpropcurrownedcnt <= 1.5) => 
-0.0497230566
, 

         (v1_hhpropcurrownedcnt > 1.5) => 
0.0011761781
, 

-0.0206543241
)
, 

-0.0044480808
)
, 

0.0113618755
)
, 

-0.0005883780
)
;


// Tree: 792

b4_tree_792 := 
map(

( NULL < v1_resinputbusinesscnt and v1_resinputbusinesscnt <= 0.5) => 
map(

   ( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 29.5) => 
map(

      ( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 439587) => 
map(

         ( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 1.5) => 
map(

            ( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 130432.5) => 
-0.0032551561
, 

            (v1_rescurrmortgageamount > 130432.5) => 
0.0112260082
, 

-0.0029093375
)
, 

         (v1_raaoccbusinessassocmmbrcnt > 1.5) => 
0.0039784077
, 

-0.0017732592
)
, 

      (v1_rescurravmvalue12mo > 439587) => 
-0.0143989509
, 

-0.0019653877
)
, 

   (v1_rescurrbusinesscnt > 29.5) => 
-0.0889740725
, 

-0.0020213122
)
, 

(v1_resinputbusinesscnt > 0.5) => 
map(

   ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 34.5) => 
0.0026737820
, 

   (v1_raacrtrecmsdmeanmmbrcnt > 34.5) => 
0.1094939627
, 

0.0027738260
)
, 

-0.0003270961
)
;


// Tree: 796

b4_tree_796 := 
map(

( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 45910) => 
-0.0005166340
, 

(v1_rescurrmortgageamount > 45910) => 
map(

   ( NULL < v1_rescurravmvalue and v1_rescurravmvalue <= 128967) => 
0.0177969076
, 

   (v1_rescurravmvalue > 128967) => 
map(

      ( NULL < v1_raacrtreclienjudgamtmax and v1_raacrtreclienjudgamtmax <= 9430.5) => 
map(

         ( NULL < v1_crtrecbkrptcnt and v1_crtrecbkrptcnt <= 0.5) => 
map(

            ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 0.5) => 
-0.0700809356
, 

            (v1_lifeeveverresidedcnt > 0.5) => 
0.0009120769
, 

0.0001866603
)
, 

         (v1_crtrecbkrptcnt > 0.5) => 
-0.0333613532
, 

-0.0023912209
)
, 

      (v1_raacrtreclienjudgamtmax > 9430.5) => 
map(

         ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 403369) => 
0.0388687796
, 

         (v1_raapropowneravmhighest > 403369) => 
0.0007807072
, 

0.0203108653
)
, 

0.0019534618
)
, 

0.0068977080
)
, 

-0.0000091577
)
;


// Tree: 800

b4_tree_800 := 
map(

( NULL < v1_raappcurrownerwtrcrftmmbrcnt and v1_raappcurrownerwtrcrftmmbrcnt <= 3.5) => 
map(

   ( NULL < v1_interestsportperson and v1_interestsportperson <= 0.5) => 
map(

      ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 2.5) => 
-0.0003244358
, 

      (v1_resinputownershipindex > 2.5) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 65135) => 
map(

            ( NULL < v1_verifiedcurrresmatchindex and v1_verifiedcurrresmatchindex <= 0.5) => 
0.0357553154
, 

            (v1_verifiedcurrresmatchindex > 0.5) => 
0.0060607135
, 

0.0110198402
)
, 

         (v1_raapropowneravmmed > 65135) => 
0.0008071710
, 

0.0037364662
)
, 

0.0003380784
)
, 

   (v1_interestsportperson > 0.5) => 
-0.0109100733
, 

0.0001372251
)
, 

(v1_raappcurrownerwtrcrftmmbrcnt > 3.5) => 
map(

   ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 212.5) => 
-0.0314769687
, 

   (v1_crtreclienjudgtimenewest > 212.5) => 
0.2005989859
, 

-0.0285016360
)
, 

0.0000470800
)
;


// Tree: 804

b4_tree_804 := 
map(

( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 284.5) => 
0.0004294350
, 

(v1_occbusinessassociationtime > 284.5) => 
map(

   ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 129.5) => 
0.0701118723
, 

   (v1_prospecttimeonrecord > 129.5) => 
map(

      ( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 1.5) => 
map(

         ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 205932) => 
-0.0409720065
, 

         (v1_raapropowneravmmed > 205932) => 
map(

            ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 0.5) => 
map(

               ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 266.5) => 
0.0361379226
, 

               (v1_lifeevtimelastmove > 266.5) => 
-0.0720869748
, 

-0.0012188948
)
, 

            (v1_raacrtrecevictionmmbrcnt > 0.5) => 
0.1050603591
, 

0.0216459646
)
, 

-0.0136853559
)
, 

      (v1_rescurrbusinesscnt > 1.5) => 
0.0359517215
, 

0.0072170918
)
, 

0.0205236737
)
, 

0.0005317696
)
;


// Tree: 808

b4_tree_808 := 
map(

( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 460973) => 
-0.0003202418
, 

(v1_propcurrownedassessedttl > 460973) => 
map(

   ( NULL < v1_hhcnt and v1_hhcnt <= 2.5) => 
map(

      ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 75.5) => 
-0.0366603078
, 

      (v1_crtreclienjudgtimenewest > 75.5) => 
0.0608290889
, 

-0.0319383921
)
, 

   (v1_hhcnt > 2.5) => 
map(

      ( NULL < v1_raainterestsportpersonmmbrcnt and v1_raainterestsportpersonmmbrcnt <= 0.5) => 
0.0071497832
, 

      (v1_raainterestsportpersonmmbrcnt > 0.5) => 
map(

         ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 202) => 
map(

            ( NULL < v1_lifeeveverresidedcnt and v1_lifeeveverresidedcnt <= 1.5) => 
-0.1126294547
, 

            (v1_lifeeveverresidedcnt > 1.5) => 
-0.0084768051
, 

-0.0230581760
)
, 

         (v1_crtrectimenewest > 202) => 
-0.2658809240
, 

-0.0357171819
)
, 

-0.0008865826
)
, 

-0.0124845587
)
, 

-0.0004966166
)
;


// Tree: 812

b4_tree_812 := 
map(

( NULL < v1_resinputavmcntyratio and v1_resinputavmcntyratio <= 2.275) => 
map(

   ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 433557) => 
0.0001050415
, 

   (v1_raapropowneravmhighest > 433557) => 
map(

      ( NULL < v1_raapropowneravmhighest and v1_raapropowneravmhighest <= 436012) => 
0.0582453137
, 

      (v1_raapropowneravmhighest > 436012) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 3.5) => 
0.0065741452
, 

         (v1_crtrecbkrpttimenewest > 3.5) => 
map(

            ( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.525) => 
-0.0163947516
, 

            (v1_resinputavmratiodiff12mo > 1.525) => 
0.1101059673
, 

-0.0119737106
)
, 

0.0050057738
)
, 

0.0056359501
)
, 

0.0006934658
)
, 

(v1_resinputavmcntyratio > 2.275) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 305162) => 
-0.0024014643
, 

   (v1_raapropowneravmmed > 305162) => 
-0.0292610035
, 

-0.0100696192
)
, 

0.0004156628
)
;


// Tree: 816

b4_tree_816 := 
map(

( NULL < v1_crtrecevictioncnt and v1_crtrecevictioncnt <= 6.5) => 
map(

   ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 1247059.5) => 
map(

      ( NULL < v1_lifeevlastmovetaxratiodiff and v1_lifeevlastmovetaxratiodiff <= 3.21) => 
map(

         ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 165.5) => 
0.0000507162
, 

         (v1_crtrecmsdmeantimenewest > 165.5) => 
map(

            ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 335913) => 
map(

               ( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 1.405) => 
-0.0121178873
, 

               (v1_rescurravmcntyratio > 1.405) => 
0.0345792229
, 

-0.0083423763
)
, 

            (v1_propcurrownedassessedttl > 335913) => 
-0.0826631013
, 

-0.0112300936
)
, 

-0.0001958190
)
, 

      (v1_lifeevlastmovetaxratiodiff > 3.21) => 
-0.1007633629
, 

-0.0002150194
)
, 

   (v1_propcurrownedassessedttl > 1247059.5) => 
0.0360992315
, 

-0.0001577272
)
, 

(v1_crtrecevictioncnt > 6.5) => 
0.0428395040
, 

0.0000572555
)
;


// Tree: 820

b4_tree_820 := 
map(

( NULL < v1_propsoldratio and v1_propsoldratio <= 0.985) => 
map(

   ( NULL < v1_hhoccbusinessassocmmbrcnt and v1_hhoccbusinessassocmmbrcnt <= 1.5) => 
0.0005962672
, 

   (v1_hhoccbusinessassocmmbrcnt > 1.5) => 
map(

      ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 1.5) => 
map(

         ( NULL < v1_occbusinessassociationtime and v1_occbusinessassociationtime <= 175.5) => 
-0.0254681247
, 

         (v1_occbusinessassociationtime > 175.5) => 
0.0106483540
, 

-0.0190993707
)
, 

      (v1_raacrtrecmsdmeanmmbrcnt > 1.5) => 
map(

         ( NULL < v1_raayoungadultmmbrcnt and v1_raayoungadultmmbrcnt <= 2.5) => 
0.0143798257
, 

         (v1_raayoungadultmmbrcnt > 2.5) => 
-0.0187732806
, 

0.0012598960
)
, 

-0.0095107611
)
, 

0.0003864037
)
, 

(v1_propsoldratio > 0.985) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 5.5) => 
0.0283536446
, 

   (v1_prospecttimelastupdate > 5.5) => 
0.0013687870
, 

0.0138393915
)
, 

0.0005548619
)
;


// Tree: 824

b4_tree_824 := 
map(

( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 254.5) => 
map(

   ( NULL < v1_raapropcurrownermmbrcnt and v1_raapropcurrownermmbrcnt <= 22.5) => 
map(

      ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 1222317) => 
-0.0003939423
, 

      (v1_raapropowneravmmed > 1222317) => 
-0.0364075725
, 

-0.0004571532
)
, 

   (v1_raapropcurrownermmbrcnt > 22.5) => 
0.0216749426
, 

-0.0003679250
)
, 

(v1_crtrectimenewest > 254.5) => 
map(

   ( NULL < v1_crtreccnt and v1_crtreccnt <= 1.5) => 
0.0069401832
, 

   (v1_crtreccnt > 1.5) => 
map(

      ( NULL < v1_hhcnt and v1_hhcnt <= 1.5) => 
0.0258864951
, 

      (v1_hhcnt > 1.5) => 
map(

         ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 421.5) => 
0.0917114662
, 

         (v1_lifeevtimelastmove > 421.5) => 
-0.1082006780
, 

0.0813873649
)
, 

0.0543724837
)
, 

0.0226500034
)
, 

-0.0002515368
)
;


// Tree: 828

b4_tree_828 := 
map(

( NULL < v1_raahhcnt and v1_raahhcnt <= 5.5) => 
map(

   ( NULL < v1_hhseniormmbrcnt and v1_hhseniormmbrcnt <= 0.5) => 
-0.0027035394
, 

   (v1_hhseniormmbrcnt > 0.5) => 
map(

      (v1_rescurrdwelltype in ['R','S']) => 
0.0015999489
, 

      (v1_rescurrdwelltype in ['-1','F','H','P','U']) => 
map(

         ( NULL < v1_rescurravmtractratio and v1_rescurravmtractratio <= 2.02) => 
0.0250771519
, 

         (v1_rescurravmtractratio > 2.02) => 
-0.2164011287
, 

0.0242116384
)
, 

0.0064704764
)
, 

-0.0019685039
)
, 

(v1_raahhcnt > 5.5) => 
map(

   ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 13.5) => 
0.0068228837
, 

   (v1_prospecttimelastupdate > 13.5) => 
map(

      ( NULL < v1_resinputmortgageamount and v1_resinputmortgageamount <= 106200) => 
-0.0037739975
, 

      (v1_resinputmortgageamount > 106200) => 
0.0224481981
, 

-0.0020629161
)
, 

0.0028879325
)
, 

-0.0005971609
)
;


// Tree: 832

b4_tree_832 := 
map(

( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 318916) => 
-0.0011262172
, 

(v1_raapropowneravmmed > 318916) => 
map(

   ( NULL < v1_crtrectimenewest and v1_crtrectimenewest <= 69.5) => 
map(

      ( NULL < v1_prospectcollegeattending and v1_prospectcollegeattending <= 0.5) => 
map(

         ( NULL < v1_prospecttimelastupdate and v1_prospecttimelastupdate <= 141.5) => 
0.0043700140
, 

         (v1_prospecttimelastupdate > 141.5) => 
-0.0252471767
, 

0.0035680546
)
, 

      (v1_prospectcollegeattending > 0.5) => 
-0.0376126504
, 

0.0024747092
)
, 

   (v1_crtrectimenewest > 69.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 76.5) => 
map(

         ( NULL < v1_resinputavmvalue12mo and v1_resinputavmvalue12mo <= 933159) => 
0.0507435134
, 

         (v1_resinputavmvalue12mo > 933159) => 
-0.2289893664
, 

0.0481865401
)
, 

      (v1_lifeevtimelastmove > 76.5) => 
0.0074619750
, 

0.0208130910
)
, 

0.0049991587
)
, 

-0.0005270128
)
;


// Tree: 836

b4_tree_836 := 
map(

( NULL < v1_resinputavmratiodiff12mo and v1_resinputavmratiodiff12mo <= 1.405) => 
map(

   ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 277.5) => 
0.0014108891
, 

      (v1_lifeevtimelastmove > 277.5) => 
map(

         ( NULL < v1_raacollegemidtiermmbrcnt and v1_raacollegemidtiermmbrcnt <= 1.5) => 
0.0140730244
, 

         (v1_raacollegemidtiermmbrcnt > 1.5) => 
-0.0366369438
, 

0.0118297345
)
, 

0.0020496921
)
, 

   (v1_raacrtrecmsdmeanmmbrcnt > 0.5) => 
map(

      ( NULL < v1_rescurravmvalue60mo and v1_rescurravmvalue60mo <= 414668.5) => 
-0.0023435415
, 

      (v1_rescurravmvalue60mo > 414668.5) => 
map(

         ( NULL < v1_raacrtrecmmbrcnt12mo and v1_raacrtrecmmbrcnt12mo <= 1.5) => 
0.0052017860
, 

         (v1_raacrtrecmmbrcnt12mo > 1.5) => 
0.0468276762
, 

0.0107831678
)
, 

-0.0018581019
)
, 

0.0000256136
)
, 

(v1_resinputavmratiodiff12mo > 1.405) => 
-0.0096440820
, 

-0.0004217684
)
;


// Tree: 840

b4_tree_840 := 
map(

( NULL < v1_propsoldratio and v1_propsoldratio <= 1.225) => 
map(

   ( NULL < v1_hhcrtrecevictionmmbrcnt and v1_hhcrtrecevictionmmbrcnt <= 0.5) => 
map(

      ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 1.5) => 
-0.0003060362
, 

      (v1_hhmiddleagemmbrcnt > 1.5) => 
map(

         ( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 4.5) => 
map(

            ( NULL < v1_hhcrtrecmsdmeanmmbrcnt12mo and v1_hhcrtrecmsdmeanmmbrcnt12mo <= 0.5) => 
map(

               ( NULL < v1_hhyoungadultmmbrcnt and v1_hhyoungadultmmbrcnt <= 0.5) => 
0.0054060933
, 

               (v1_hhyoungadultmmbrcnt > 0.5) => 
-0.0122754130
, 

0.0036419034
)
, 

            (v1_hhcrtrecmsdmeanmmbrcnt12mo > 0.5) => 
0.0295149533
, 

0.0050280617
)
, 

         (v1_occproflicensecategory > 4.5) => 
-0.0657706545
, 

0.0043989188
)
, 

0.0001688120
)
, 

   (v1_hhcrtrecevictionmmbrcnt > 0.5) => 
-0.0078219972
, 

-0.0004534033
)
, 

(v1_propsoldratio > 1.225) => 
0.0151987827
, 

-0.0003052847
)
;


// Tree: 844

b4_tree_844 := 
map(

( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 169.5) => 
-0.0000169748
, 

(v1_crtreclienjudgtimenewest > 169.5) => 
map(

   ( NULL < v1_crtreclienjudgcnt and v1_crtreclienjudgcnt <= 2.5) => 
map(

      ( NULL < v1_lifeevtimelastassetpurchase and v1_lifeevtimelastassetpurchase <= 240.5) => 
map(

         ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 254.5) => 
-0.0325857797
, 

         (v1_hhcrtreclienjudgamtttl > 254.5) => 
0.0109471199
, 

0.0068613506
)
, 

      (v1_lifeevtimelastassetpurchase > 240.5) => 
-0.1232566002
, 

0.0059231734
)
, 

   (v1_crtreclienjudgcnt > 2.5) => 
map(

      ( NULL < v1_crtreccnt and v1_crtreccnt <= 9.5) => 
map(

         ( NULL < v1_prospecttimeonrecord and v1_prospecttimeonrecord <= 319) => 
0.0553164589
, 

         (v1_prospecttimeonrecord > 319) => 
0.2085447852
, 

0.0614715080
)
, 

      (v1_crtreccnt > 9.5) => 
-0.0717603302
, 

0.0503688548
)
, 

0.0114869705
)
, 

0.0001743832
)
;


// Tree: 848

b4_tree_848 := 
map(

( NULL < v1_rescurrbusinesscnt and v1_rescurrbusinesscnt <= 0.5) => 
map(

   (v1_rescurrdwelltype in ['P','R','S','U']) => 
-0.0044722718
, 

   (v1_rescurrdwelltype in ['-1','F','H']) => 
map(

      ( NULL < v1_hhmiddleagemmbrcnt and v1_hhmiddleagemmbrcnt <= 0.5) => 
map(

         ( NULL < v1_occproflicensecategory and v1_occproflicensecategory <= 1.5) => 
-0.0015769100
, 

         (v1_occproflicensecategory > 1.5) => 
0.0382482030
, 

-0.0014041195
)
, 

      (v1_hhmiddleagemmbrcnt > 0.5) => 
map(

         (v1_resinputdwelltype in ['0','P']) => 
-0.0239412846
, 

         (v1_resinputdwelltype in ['-1','F','G','H','R','S','U']) => 
map(

            ( NULL < v1_raacrtrecmmbrcnt and v1_raacrtrecmmbrcnt <= 3.5) => 
0.0245749916
, 

            (v1_raacrtrecmmbrcnt > 3.5) => 
0.0057732460
, 

0.0141208579
)
, 

0.0110272356
)
, 

-0.0003329716
)
, 

-0.0013444426
)
, 

(v1_rescurrbusinesscnt > 0.5) => 
0.0034600739
, 

-0.0005003891
)
;


// Tree: 852

b4_tree_852 := 
map(

( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 1.085) => 
map(

   ( NULL < v1_rescurrmortgageamount and v1_rescurrmortgageamount <= 184052.5) => 
0.0001000853
, 

   (v1_rescurrmortgageamount > 184052.5) => 
0.0146967516
, 

0.0003738897
)
, 

(v1_rescurravmratiodiff12mo > 1.085) => 
map(

   ( NULL < v1_resinputownershipindex and v1_resinputownershipindex <= 2.5) => 
map(

      ( NULL < v1_proptimelastsale and v1_proptimelastsale <= 23.5) => 
-0.0074009915
, 

      (v1_proptimelastsale > 23.5) => 
-0.0300286128
, 

-0.0094074760
)
, 

   (v1_resinputownershipindex > 2.5) => 
map(

      ( NULL < v1_crtrecmsdmeantimenewest and v1_crtrecmsdmeantimenewest <= 2.5) => 
map(

         ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 34.5) => 
-0.0304060207
, 

         (v1_lifeevtimelastmove > 34.5) => 
-0.0003421948
, 

-0.0025309074
)
, 

      (v1_crtrecmsdmeantimenewest > 2.5) => 
0.0172764255
, 

0.0008105246
)
, 

-0.0050538057
)
, 

-0.0003013853
)
;


// Tree: 856

b4_tree_856 := 
map(

( NULL < v1_rescurravmcntyratio and v1_rescurravmcntyratio <= 0.995) => 
0.0004432135
, 

(v1_rescurravmcntyratio > 0.995) => 
map(

   ( NULL < v1_crtreclienjudgtimenewest and v1_crtreclienjudgtimenewest <= 137.5) => 
map(

      ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 5.5) => 
map(

         ( NULL < v1_raacrtrecmsdmeanmmbrcnt and v1_raacrtrecmsdmeanmmbrcnt <= 42) => 
0.0052219036
, 

         (v1_raacrtrecmsdmeanmmbrcnt > 42) => 
0.2284020357
, 

0.0053161013
)
, 

      (v1_crtrecbkrpttimenewest > 5.5) => 
map(

         ( NULL < v1_raacrtrecevictionmmbrcnt and v1_raacrtrecevictionmmbrcnt <= 2.5) => 
map(

            ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 34.5) => 
-0.0634485141
, 

            (v1_crtrecbkrpttimenewest > 34.5) => 
-0.0111707217
, 

-0.0218410884
)
, 

         (v1_raacrtrecevictionmmbrcnt > 2.5) => 
0.0247241072
, 

-0.0144859240
)
, 

0.0034828231
)
, 

   (v1_crtreclienjudgtimenewest > 137.5) => 
0.0332283919
, 

0.0045242128
)
, 

0.0009333702
)
;


// Tree: 860

b4_tree_860 := 
map(

( NULL < v1_resinputavmblockratio and v1_resinputavmblockratio <= 1.315) => 
map(

   ( NULL < v1_rescurravmratiodiff12mo and v1_rescurravmratiodiff12mo <= 3.475) => 
map(

      ( NULL < v1_hhcrtreclienjudgamtttl and v1_hhcrtreclienjudgamtttl <= 1167.5) => 
0.0015441728
, 

      (v1_hhcrtreclienjudgamtttl > 1167.5) => 
map(

         ( NULL < v1_crtrecbkrpttimenewest and v1_crtrecbkrpttimenewest <= 26.5) => 
map(

            ( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 566425) => 
-0.0088879873
, 

            (v1_rescurravmvalue12mo > 566425) => 
0.0530652335
, 

-0.0081048707
)
, 

         (v1_crtrecbkrpttimenewest > 26.5) => 
0.0100412127
, 

-0.0047981664
)
, 

0.0006943500
)
, 

   (v1_rescurravmratiodiff12mo > 3.475) => 
0.0598230318
, 

0.0007421500
)
, 

(v1_resinputavmblockratio > 1.315) => 
map(

   ( NULL < v1_raacollegeattendedmmbrcnt and v1_raacollegeattendedmmbrcnt <= 14.5) => 
-0.0073495541
, 

   (v1_raacollegeattendedmmbrcnt > 14.5) => 
0.0893199967
, 

-0.0070097077
)
, 

0.0001103744
)
;


// Tree: 864

b4_tree_864 := 
map(

( NULL < v1_proppurchasecnt12mo and v1_proppurchasecnt12mo <= 0.5) => 
map(

   ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 46101) => 
map(

      ( NULL < v1_propcurrownedassessedttl and v1_propcurrownedassessedttl <= 615) => 
0.0010801804
, 

      (v1_propcurrownedassessedttl > 615) => 
map(

         ( NULL < v1_rescurravmblockratio and v1_rescurravmblockratio <= 1.005) => 
-0.0257050133
, 

         (v1_rescurravmblockratio > 1.005) => 
0.0099656560
, 

-0.0201295636
)
, 

0.0005502920
)
, 

   (v1_propcurrownedassessedttl > 46101) => 
map(

      ( NULL < v1_raaoccbusinessassocmmbrcnt and v1_raaoccbusinessassocmmbrcnt <= 2.5) => 
0.0063685910
, 

      (v1_raaoccbusinessassocmmbrcnt > 2.5) => 
map(

         ( NULL < v1_raacrtrecmmbrcnt12mo and v1_raacrtrecmmbrcnt12mo <= 0.5) => 
-0.0177410081
, 

         (v1_raacrtrecmmbrcnt12mo > 0.5) => 
0.0042717720
, 

-0.0062636165
)
, 

0.0038372599
)
, 

0.0010025621
)
, 

(v1_proppurchasecnt12mo > 0.5) => 
-0.0097347497
, 

0.0008414617
)
;


// Tree: 868

b4_tree_868 := 
map(

( NULL < v1_rescurravmvalue12mo and v1_rescurravmvalue12mo <= 669729.5) => 
0.0001731691
, 

(v1_rescurravmvalue12mo > 669729.5) => 
map(

   ( NULL < v1_raapropowneravmmed and v1_raapropowneravmmed <= 1211868.5) => 
map(

      ( NULL < v1_resinputavmvalue and v1_resinputavmvalue <= 1156838.5) => 
map(

         ( NULL < v1_hhcrtrecmmbrcnt and v1_hhcrtrecmmbrcnt <= 1.5) => 
map(

            ( NULL < v1_raacrtreclienjudgmmbrcnt and v1_raacrtreclienjudgmmbrcnt <= 0.5) => 
-0.0414380689
, 

            (v1_raacrtreclienjudgmmbrcnt > 0.5) => 
-0.0080463040
, 

-0.0259941007
)
, 

         (v1_hhcrtrecmmbrcnt > 1.5) => 
map(

            ( NULL < v1_lifeevtimelastmove and v1_lifeevtimelastmove <= 61.5) => 
-0.1378695078
, 

            (v1_lifeevtimelastmove > 61.5) => 
0.0482497753
, 

0.0215523371
)
, 

-0.0193685548
)
, 

      (v1_resinputavmvalue > 1156838.5) => 
0.0224996816
, 

-0.0126110856
)
, 

   (v1_raapropowneravmmed > 1211868.5) => 
-0.1012635053
, 

-0.0155264732
)
, 

0.0000363855
)
;


b4_gbm_logit := sum(
b4_tree_4,
b4_tree_8,
b4_tree_12,
b4_tree_16,
b4_tree_20,
b4_tree_24,
b4_tree_28,
b4_tree_32,
b4_tree_36,
b4_tree_40,
b4_tree_44,
b4_tree_48,
b4_tree_52,
b4_tree_56,
b4_tree_60,
b4_tree_64,
b4_tree_68,
b4_tree_72,
b4_tree_76,
b4_tree_80,
b4_tree_84,
b4_tree_88,
b4_tree_92,
b4_tree_96,
b4_tree_100,
b4_tree_104,
b4_tree_108,
b4_tree_112,
b4_tree_116,
b4_tree_120,
b4_tree_124,
b4_tree_128,
b4_tree_132,
b4_tree_136,
b4_tree_140,
b4_tree_144,
b4_tree_148,
b4_tree_152,
b4_tree_156,
b4_tree_160,
b4_tree_164,
b4_tree_168,
b4_tree_172,
b4_tree_176,
b4_tree_180,
b4_tree_184,
b4_tree_188,
b4_tree_192,
b4_tree_196,
b4_tree_200,
b4_tree_204,
b4_tree_208,
b4_tree_212,
b4_tree_216,
b4_tree_220,
b4_tree_224,
b4_tree_228,
b4_tree_232,
b4_tree_236,
b4_tree_240,
b4_tree_244,
b4_tree_248,
b4_tree_252,
b4_tree_256,
b4_tree_260,
b4_tree_264,
b4_tree_268,
b4_tree_272,
b4_tree_276,
b4_tree_280,
b4_tree_284,
b4_tree_288,
b4_tree_292,
b4_tree_296,
b4_tree_300,
b4_tree_304,
b4_tree_308,
b4_tree_312,
b4_tree_316,
b4_tree_320,
b4_tree_324,
b4_tree_328,
b4_tree_332,
b4_tree_336,
b4_tree_340,
b4_tree_344,
b4_tree_348,
b4_tree_352,
b4_tree_356,
b4_tree_360,
b4_tree_364,
b4_tree_368,
b4_tree_372,
b4_tree_376,
b4_tree_380,
b4_tree_384,
b4_tree_388,
b4_tree_392,
b4_tree_396,
b4_tree_400,
b4_tree_404,
b4_tree_408,
b4_tree_412,
b4_tree_416,
b4_tree_420,
b4_tree_424,
b4_tree_428,
b4_tree_432,
b4_tree_436,
b4_tree_440,
b4_tree_444,
b4_tree_448,
b4_tree_452,
b4_tree_456,
b4_tree_460,
b4_tree_464,
b4_tree_468,
b4_tree_472,
b4_tree_476,
b4_tree_480,
b4_tree_484,
b4_tree_488,
b4_tree_492,
b4_tree_496,
b4_tree_500,
b4_tree_504,
b4_tree_508,
b4_tree_512,
b4_tree_516,
b4_tree_520,
b4_tree_524,
b4_tree_528,
b4_tree_532,
b4_tree_536,
b4_tree_540,
b4_tree_544,
b4_tree_548,
b4_tree_552,
b4_tree_556,
b4_tree_560,
b4_tree_564,
b4_tree_568,
b4_tree_572,
b4_tree_576,
b4_tree_580,
b4_tree_584,
b4_tree_588,
b4_tree_592,
b4_tree_596,
b4_tree_600,
b4_tree_604,
b4_tree_608,
b4_tree_612,
b4_tree_616,
b4_tree_620,
b4_tree_624,
b4_tree_628,
b4_tree_632,
b4_tree_636,
b4_tree_640,
b4_tree_644,
b4_tree_648,
b4_tree_652,
b4_tree_656,
b4_tree_660,
b4_tree_664,
b4_tree_668,
b4_tree_672,
b4_tree_676,
b4_tree_680,
b4_tree_684,
b4_tree_688,
b4_tree_692,
b4_tree_696,
b4_tree_700,
b4_tree_704,
b4_tree_708,
b4_tree_712,
b4_tree_716,
b4_tree_720,
b4_tree_724,
b4_tree_728,
b4_tree_732,
b4_tree_736,
b4_tree_740,
b4_tree_744,
b4_tree_748,
b4_tree_752,
b4_tree_756,
b4_tree_760,
b4_tree_764,
b4_tree_768,
b4_tree_772,
b4_tree_776,
b4_tree_780,
b4_tree_784,
b4_tree_788,
b4_tree_792,
b4_tree_796,
b4_tree_800,
b4_tree_804,
b4_tree_808,
b4_tree_812,
b4_tree_816,
b4_tree_820,
b4_tree_824,
b4_tree_828,
b4_tree_832,
b4_tree_836,
b4_tree_840,
b4_tree_844,
b4_tree_848,
b4_tree_852,
b4_tree_856,
b4_tree_860,
b4_tree_864,
b4_tree_868);

////////////////
// Prediction //
////////////////

SetScores := [b1_gbm_logit, b2_gbm_logit, b3_gbm_logit, b4_gbm_logit];

// 0 Unbanked
// 1 Underbanked
// 2 Banked
// 3 HighlyBanked

ProspectBankingExperience := MAP (le.attributes.version1.VerifiedProspectFound	= '-1' 	=> '-1',
																	b1_gbm_logit = MAX(SetScores) => '0',
                                  b2_gbm_logit = MAX(SetScores) => '0',
                                  b3_gbm_logit = MAX(SetScores) => '1',
                                  b4_gbm_logit = MAX(SetScores) => '2',
																																	'0');




//Intermediate variables
	#if(MODEL_DEBUG)
			//self.v2_hhoccbusinessassocmmbrcnt     := v2_hhoccbusinessassocmmbrcnt;
			self.b1_gbm_logit 	:=  b1_gbm_logit;
			self.b2_gbm_logit 	:=  b2_gbm_logit;
			self.b3_gbm_logit 	:=  b3_gbm_logit;
			self.b4_gbm_logit		:=  b4_gbm_logit;
			self.attributes.version1.ProspectBankingExperience	:= 	ProspectBankingExperience;
		#else
			self.attributes.version1.ProspectBankingExperience	:= 	ProspectBankingExperience;
		#end
			self := le;
	END;

		model := project(clam, doModel(left)); 

		return model;

END;