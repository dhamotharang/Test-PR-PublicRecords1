/* *********************************************************
************************************************************
** The intermediate logs return the product ID that gets  **
** set by the To_LOG_Boca_Shell function. This works      **
** similar to the Billing Index in Risk_Indicators.       **
************************************************************
********************************************************** */

EXPORT ProductID := MODULE
	SHARED Accurint := 1; // WsIdentity- IID, FlexID, FraudPoint, etc //NON FCRA
	
	SHARED Riskwise := 2; // RiskView and RiskWise //FCRA


//FCRA - RiskWise
	EXPORT Models__RiskView_Testing_Service := Riskwise;
	EXPORT Models__RiskView_Service   := Riskwise;
	EXPORT RiskView__Search_Service   := RiskWise;
	EXPORT ISS_FcraInsurView__Service := Riskwise;
	EXPORT RiskWise__RiskWiseMainBC1O := Riskwise;
	EXPORT RiskWise__RiskWiseMainPRIO := Riskwise;
	EXPORT RiskWise__RiskWiseMainSC1O := Riskwise;
	EXPORT RiskWise__RiskWiseMainSD1O := Riskwise;
	EXPORT RiskWise__RiskWiseMainIT1O := Riskwise;
	EXPORT RiskWise__RiskWiseMainCT1O := Riskwise;
	EXPORT RiskWise__RiskWiseMainDLLO := Riskwise;
	EXPORT RiskWise__RiskWiseMainSDBO := Riskwise;
	EXPORT RiskWise__RiskWiseMainFA2O := Riskwise;
	EXPORT RiskWise__RiskWiseMainIDPO := Riskwise;
	EXPORT RiskWise__RiskWiseMainIPVO := Riskwise;
	EXPORT RiskWise__RiskWiseMainCDxO := Riskwise;
	EXPORT RiskWise__RiskWiseMainNP2O := Riskwise;
	EXPORT RiskWise__RiskWiseMainNPTO := Riskwise;
	EXPORT RiskWise__RiskWiseMainOFCO := Riskwise;
	EXPORT RiskWise__RiskWiseMainPB1O := Riskwise;
	EXPORT RiskWise__RiskWiseMainPRWO := Riskwise;
	EXPORT RiskWise__RiskWiseMainSS1O := Riskwise;
	EXPORT RiskWise__RiskWiseMainWF2O := Riskwise;
	
//NON FCRA
	EXPORT AML__AML_Service := Accurint;
	EXPORT Business_Risk__InstantID_Service := Accurint;
	EXPORT Business_Risk__InstantID_20_Service := Accurint;
	EXPORT BusinessCredit_Services__BCD_SmallBizCombinedReport := Accurint;
  EXPORT BusinessCredit_Services__BCD_BusinessSearch := Accurint;
	EXPORT BusinessCredit_Services__CreditReportService := Accurint;
	EXPORT LNSmallBusiness__SmallBusiness_Service := Accurint;
	EXPORT LNSmallBusiness__SmallBusiness_BIP_Service := Accurint;
	EXPORT LNSmallBusiness__SmallBusiness_BIP_Combined_Service := Accurint;
	EXPORT LNSmallBusiness__SmallBusiness_Marketing_Service := Accurint;
	EXPORT Models__ChargebackDefender_Service := Accurint;
	EXPORT Models__OrderScore_Service := Accurint;
	EXPORT Models__LeadIntegrity_Service := Accurint;
	EXPORT Models__FraudAdvisor_Service := Accurint;
	EXPORT ProfileBooster__Search_Service := Accurint;
	EXPORT Risk_Indicators__InstantID := Accurint;
	EXPORT Risk_Indicators__FlexID_Service := Accurint;	
	EXPORT VerificationOfOccupancy__PAR_Search_Service := Accurint;	
	EXPORT VerificationOfOccupancy__Search_Service := Accurint;	
	
END;