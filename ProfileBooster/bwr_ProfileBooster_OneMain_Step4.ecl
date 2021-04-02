#workunit('priority','high'); 

import SALT35, SALTRoutines, ProfileBooster;


EXPORT bwr_ProfileBooster_OneMain_Step4(string NotifyList) := function

// This script takes in a file (Either as a dataset with a RECORD definition you define, or as an ECL file/index reference), 
// and then performs a full SALT profile.  It will then take that profile and infer potential data types, show the least populated fields, etc.

// For future Workunit Identification it is suggested that you update this WORKUNIT name to something specific to the file you are profiling

EmailList := If(NotifyList = '', ProfileBooster.Constants.ECL_Developers_Slim, ProfileBooster.Constants.ECL_Developers_Slim + ',' + NotifyList);
 
batchout := RECORD
  unsigned6 LexID;
  string2 DoNotMail;
  string2 VerifiedSSN;
  string2 VerifiedPhone;
  string3 ProspectTimeOnRecord;
  string3 ProspectTimeLastUpdate;
  string2 ProspectLastUpdate12Mo;
  string3 ProspectAge;
  string2 ProspectGender;
  string2 ProspectMaritalStatus;
  string2 ProspectEstimatedIncomeRange;
  string2 ProspectDeceased;
  string2 ProspectCollegeAttending;
  string2 ProspectCollegeAttended;
  string2 ProspectCollegeProgramType;
  string2 ProspectCollegePrivate;
  string2 ProspectCollegeTier;
  string2 ProspectBankingExperience;
  string2 AssetCurrOwner;
  string2 PropCurrOwner;
  string3 PropCurrOwnedCnt;
  string7 PropCurrOwnedAssessedTtl;
  string7 PropCurrOwnedAVMTtl;
  string3 PropTimeLastSale;
  string3 PropEverOwnedCnt;
  string3 PropEverSoldCnt;
  string3 PropSoldCnt12Mo;
  string5 PropSoldRatio;
  string3 PropPurchaseCnt12Mo;
  string2 PPCurrOwner;
  string3 PPCurrOwnedCnt;
  string3 PPCurrOwnedAutoCnt;
  string3 PPCurrOwnedMtrcycleCnt;
  string3 PPCurrOwnedAircrftCnt;
  string3 PPCurrOwnedWtrcrftCnt;
  string3 LifeEvTimeLastMove;
  string2 LifeEvNameChange;
  string2 LifeEvNameChangeCnt12Mo;
  string3 LifeEvTimeFirstAssetPurchase;
  string3 LifeEvTimeLastAssetPurchase;
  string3 LifeEvEverResidedCnt;
  string5 LifeEvLastMoveTaxRatioDiff;
  string2 LifeEvEconTrajectory;
  string2 LifeEvEconTrajectoryIndex;
  string2 ResCurrOwnershipIndex;
  string7 ResCurrAVMValue;
  string7 ResCurrAVMValue12Mo;
  string5 ResCurrAVMRatioDiff12Mo;
  string7 ResCurrAVMValue60Mo;
  string5 ResCurrAVMRatioDiff60Mo;
  string5 ResCurrAVMCntyRatio;
  string5 ResCurrAVMTractRatio;
  string5 ResCurrAVMBlockRatio;
  string2 ResCurrDwellType;
  string2 ResCurrDwellTypeIndex;
  string2 ResCurrMortgageType;
  string7 ResCurrMortgageAmount;
  string3 ResCurrBusinessCnt;
  string3 CrtRecCnt;
  string3 CrtRecCnt12Mo;
  string3 CrtRecTimeNewest;
  string3 CrtRecFelonyCnt;
  string3 CrtRecFelonyCnt12Mo;
  string3 CrtRecFelonyTimeNewest;
  string3 CrtRecMsdmeanCnt;
  string3 CrtRecMsdmeanCnt12Mo;
  string3 CrtRecMsdmeanTimeNewest;
  string3 CrtRecEvictionCnt;
  string3 CrtRecEvictionCnt12Mo;
  string3 CrtRecEvictionTimeNewest;
  string3 CrtRecLienJudgCnt;
  string3 CrtRecLienJudgCnt12Mo;
  string3 CrtRecLienJudgTimeNewest;
  string7 CrtRecLienJudgAmtTtl;
  string3 CrtRecBkrptCnt;
  string3 CrtRecBkrptCnt12Mo;
  string3 CrtRecBkrptTimeNewest;
  string2 CrtRecSeverityIndex;
  string2 OccProfLicense;
  string2 OccProfLicenseCategory;
  string2 OccBusinessAssociation;
  string3 OccBusinessAssociationTime;
  string2 OccBusinessTitleLeadership;
  string2 InterestSportPerson;
  string3 HHTeenagerMmbrCnt;
  string3 HHYoungAdultMmbrCnt;
  string3 HHMiddleAgeMmbrCnt;
  string3 HHSeniorMmbrCnt;
  string3 HHElderlyMmbrCnt;
  string3 HHCnt;
  string2 HHEstimatedIncomeRange;
  string3 HHCollegeAttendedMmbrCnt;
  string3 HHCollege2yrAttendedMmbrCnt;
  string3 HHCollege4yrAttendedMmbrCnt;
  string3 HHCollegeGradAttendedMmbrCnt;
  string3 HHCollegePrivateMmbrCnt;
  string2 HHCollegeTierMmbrHighest;
  string3 HHPropCurrOwnerMmbrCnt;
  string3 HHPropCurrOwnedCnt;
  string7 HHPropCurrAVMHighest;
  string3 HHPPCurrOwnedCnt;
  string3 HHPPCurrOwnedAutoCnt;
  string3 HHPPCurrOwnedMtrcycleCnt;
  string3 HHPPCurrOwnedAircrftCnt;
  string3 HHPPCurrOwnedWtrcrftCnt;
  string3 HHCrtRecMmbrCnt;
  string3 HHCrtRecMmbrCnt12Mo;
  string3 HHCrtRecFelonyMmbrCnt;
  string3 HHCrtRecFelonyMmbrCnt12Mo;
  string3 HHCrtRecMsdmeanMmbrCnt;
  string3 HHCrtRecMsdmeanMmbrCnt12Mo;
  string3 HHCrtRecEvictionMmbrCnt;
  string3 HHCrtRecEvictionMmbrCnt12Mo;
  string3 HHCrtRecLienJudgMmbrCnt;
  string3 HHCrtRecLienJudgMmbrCnt12Mo;
  string7 HHCrtRecLienJudgAmtTtl;
  string3 HHCrtRecBkrptMmbrCnt;
  string3 HHCrtRecBkrptMmbrCnt12Mo;
  string3 HHCrtRecBkrptMmbrCnt24Mo;
  string3 HHOccProfLicMmbrCnt;
  string3 HHOccBusinessAssocMmbrCnt;
  string3 HHInterestSportPersonMmbrCnt;
  string3 RaATeenageMmbrCnt;
  string3 RaAYoungAdultMmbrCnt;
  string3 RaAMiddleAgeMmbrCnt;
  string3 RaASeniorMmbrCnt;
  string3 RaAElderlyMmbrCnt;
  string3 RaAHHCnt;
  string3 RaAMmbrCnt;
  string2 RaAMedIncomeRange;
  string3 RaACollegeAttendedMmbrCnt;
  string3 RaACollege2yrAttendedMmbrCnt;
  string3 RaACollege4yrAttendedMmbrCnt;
  string3 RaACollegeGradAttendedMmbrCnt;
  string3 RaACollegePrivateMmbrCnt;
  string3 RaACollegeTopTierMmbrCnt;
  string3 RaACollegeMidTierMmbrCnt;
  string3 RaACollegeLowTierMmbrCnt;
  string3 RaAPropCurrOwnerMmbrCnt;
  string7 RaAPropOwnerAVMHighest;
  string7 RaAPropOwnerAVMMed;
  string3 RaAPPCurrOwnerMmbrCnt;
  string3 RaAPPCurrOwnerAutoMmbrCnt;
  string3 RaAPPCurrOwnerMtrcycleMmbrCnt;
  string3 RaAPPCurrOwnerAircrftMmbrCnt;
  string3 RaAPPCurrOwnerWtrcrftMmbrCnt;
  string3 RaACrtRecMmbrCnt;
  string3 RaACrtRecMmbrCnt12Mo;
  string3 RaACrtRecFelonyMmbrCnt;
  string3 RaACrtRecFelonyMmbrCnt12Mo;
  string3 RaACrtRecMsdmeanMmbrCnt;
  string3 RaACrtRecMsdmeanMmbrCnt12Mo;
  string3 RaACrtRecEvictionMmbrCnt;
  string3 RaACrtRecEvictionMmbrCnt12Mo;
  string3 RaACrtRecLienJudgMmbrCnt;
  string3 RaACrtRecLienJudgMmbrCnt12Mo;
  string7 RaACrtRecLienJudgAmtMax;
  string3 RaACrtRecBkrptMmbrCnt36Mo;
  string3 RaAOccProfLicMmbrCnt;
  string3 RaAOccBusinessAssocMmbrCnt;
  string3 RaAInterestSportPersonMmbrCnt;
END;


// ---- Step 1.) Read in your data ----
RawInputDataset := DATASET('~' + '~thor400::profilebooster::LN_Output_springleaf_layout_ProfBooster.csv', batchout, csv(quote('"'), heading(1)));
OUTPUT(CHOOSEN(RawInputDataset, 25), NAMED('Sample_Raw_Input'));


SALT_AttributeResults :=  SALTRoutines.SALT_Profile_Run_Everything(RawInputDataset, 'SALT_Results');
OUTPUT(SALT_AttributeResults, NAMED('Total_Fields_Profiled'));

FileServices.SendEmail(EmailList, 'OneMain Step4 finished ' + WORKUNIT, 'Check Salt Results'):
FAILURE(FileServices.SendEmail(EmailList,'OneMain Step4 failed', 'The failed workunit is:' + WORKUNIT + FAILMESSAGE));


RETURN 'SUCCESSFUL';

END;