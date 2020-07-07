﻿
export Healthcare_SocioEconomic_RT_Service := MACRO
import risk_indicators, models, std, Profilebooster;
IMPORT LUCI, ut, STD;
IMPORT HCSE_GE_18_LUCI_MODEL;
IMPORT HCSE_LT_18_LUCI_MODEL;
IMPORT iesp;

#DECLARE(BuildDate); 
#SET(BuildDate,(String)STD.Date.Today());
	
	//Get IESP input
	ds_in := DATASET ([], iesp.healthcare_socio_indicators.t_SocioeconomicIndicatorsRequest) : STORED('SocioeconomicIndicatorsRequest', FEW);
	first_row := ds_in[1] : INDEPENDENT; //Since this is an ESP service, reading only one row.
	// OUTPUT(first_row, NAMED('first_row'));
	MemberInfo := first_row.Member;
	RequestOptions := first_row.Options;
	//Get Account Config
	acct_configRaw := first_row.AccountContext;
	//Get Account Config Entries
	cfg_CompanyID := acct_configRaw.Common.GlobalCompanyId;
	cfg_TransactionId := acct_configRaw.Common.TransactionId;
	// Changed GLOBAL.CONFIG to SOCIOECONOMIC Config
	cfg_Config := acct_configRaw.Configs(STD.STR.ToUpperCase(Name)='SOCIOECONOMIC.CONFIG')[1];//Need to filter as there may be multiple for different products
	cfg_Name := cfg_Config.Name;
	cfg_Type := cfg_Config._Type;
	cfg_ProductKey := cfg_Config.ProductKey;
	cfg_DS_SectionName := cfg_Config.Sections(STD.STR.ToUpperCase(Name)='HC_SOCIO_MAIN')[1];//Need to filter on this
	cfg_DS_Sections := cfg_DS_SectionName.KeyValues;

    //CCPA fields
    // unsigned1 LexIdSourceOptout := 1 : STORED ('LexIdSourceOptout');
    string TransactionID := '' : stored ('_TransactionId');
    string BatchUID := '' : stored('_BatchUID');
    unsigned6 GlobalCompanyId := 0 : stored('_GCID');
    
	//Constants
	_blank := '';

	//Format for Socio Core Call
	Models.Layouts_Healthcare_RT_Service.Layout_SocioEconomic_Data_In getMemberInfo() := transform
			self.AcctNo := MemberInfo.MemberID;
			self.SSN_in := MemberInfo.SSN;
			self.unParsedFullName := MemberInfo.Name.Full;
			self.Name_First := MemberInfo.Name.First;
			self.Name_Middle := MemberInfo.Name.Middle;
			self.Name_Last := MemberInfo.Name.Last;
			self.Name_Suffix := MemberInfo.Name.Suffix;
			self.DOB_in := iesp.ECL2ESP.DateToString(MemberInfo.DOB);
			self.street_addr := MemberInfo.Address.StreetAddress1 + MemberInfo.Address.StreetAddress2;
			self.p_City_name := MemberInfo.Address.City;
			self.St_in := MemberInfo.Address.State;
			self.Zip_in := MemberInfo.Address.Zip5;
			self.DL_Number := _blank;
			self.DL_State := _blank;
			self.Home_Phone_in := MemberInfo.HomePhone;
			self.Work_Phone_in := MemberInfo.AlternatePhone;
			self.MemberGender_in := MemberInfo.Gender;
			self.DID := 0;
			self.Admit_date_in := iesp.ECL2ESP.DateToString(MemberInfo.Admission.AdmitDate);
			self.Admit_diagnosis_code := MemberInfo.Admission.DiagnosisCode;
			self.Financial_class := MemberInfo.Admission.FinancialClass;
			self.Patient_type := MemberInfo.Admission.PatientType;
			self.HistorydateYYYYMM:=999999;
			self.LOB := MemberInfo.LOB;
			self := [];
	end;
	dsMemberInfo := dataset([getMemberInfo()]);
	// OUTPUT(dsMemberInfo, NAMED('dsMemberInfo'));

	//Cleaning Member Info
	Trimmed_Input := PROJECT(dsMemberInfo, Models.Healthcare_SocioEconomic_Transforms_RT_Service.Trim_Input(LEFT));
	//Output(Trimmed_Input, NAMED('Trimmed_Input'));
	Cleaned_Input := PROJECT(Trimmed_Input, Models.Healthcare_SocioEconomic_Transforms_RT_Service.AddSeq_and_Clean(LEFT,COUNTER));
	//Output(Cleaned_Input, NAMED('Cleaned_Input'));

	BOOLEAN isAttributesRequested := (BOOLEAN) RequestOptions.IncludeHealthAttributesV3;
	BOOLEAN isReadmissionRequested := (BOOLEAN) RequestOptions.IncludeReadmissionScore;
	BOOLEAN isMedicationAdherenceRequested := (BOOLEAN) RequestOptions.IncludeMedicationAdherenceScore;
	BOOLEAN isMotivationRequested := (BOOLEAN) RequestOptions.IncludeMotivationScore;
	BOOLEAN isTotalCostRiskScoreRequested := (BOOLEAN) RequestOptions.IncludeTotalCostRiskScore;

	BOOLEAN isAttributesSubscribed := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SubscribedToHealthAttributesV3);
	BOOLEAN isReadmissionSubscribed := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SubscribedToReadmissionScore);
	BOOLEAN isMedicationAdherenceSubscribed := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SubscribedToMedicationAdherenceScore);
	BOOLEAN isMotivationSubscribed := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SubscribedToMotivationScore);
	BOOLEAN isTotalCostRiskScoreSubscribed := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SubscribedToTotalCostRiskScore);

	// isAttributesSubscribed;
	// isReadmissionSubscribed;
	// isMedicationAdherenceSubscribed;
	// isMotivationSubscribed

	EmptyExceptionDS0 := DATASET([], iesp.share.t_WsException);
	_EmptyExceptionDSRow0 := ROW({_blank,0,_blank,_blank}, iesp.share.t_WsException);

	isAttributesRequestValid := IF(isAttributesRequested, IF(isAttributesRequested = isAttributesSubscribed,TRUE,FALSE),TRUE);
	// isAttributesRequestValid;
	isReadmissionRequestValid := IF(isReadmissionRequested, IF(isReadmissionRequested = isReadmissionSubscribed,TRUE,FALSE),TRUE);
	// isReadmissionRequestValid;
	isMedicationAdherenceRequestValid := IF(isMedicationAdherenceRequested, IF(isMedicationAdherenceRequested = isMedicationAdherenceSubscribed,TRUE,FALSE),TRUE);
	// isMedicationAdherenceRequestValid;
	isMotivationRequestValid := IF(isMotivationRequested, IF(isMotivationRequested = isMotivationSubscribed,TRUE,FALSE),TRUE);
	// isMedicationAdherenceRequestValid;
	isTotalCostRiskScoreRequestValid := IF(isTotalCostRiskScoreRequested, IF(isTotalCostRiskScoreRequested = isTotalCostRiskScoreSubscribed,TRUE,FALSE),TRUE);

	AttributesFailMessage := IF(isAttributesRequestValid,_blank, Models.Healthcare_Constants_RT_Service.AttributesSubFailMessage);
	ReadmissionFailMessage := IF(isReadmissionRequestValid,_blank, Models.Healthcare_Constants_RT_Service.ReadmissionSubFailMessage);
	MedicationAdherenceFailMessage := IF(isMedicationAdherenceRequestValid,_blank, Models.Healthcare_Constants_RT_Service.MedicationAdherenceSubFailMessage);
	MotivationFailMessage := IF(isMotivationRequestValid,_blank, Models.Healthcare_Constants_RT_Service.MotivationSubFailMessage);
	TotalCostRiskScoreFailMessage := IF(isTotalCostRiskScoreRequestValid,_blank, Models.Healthcare_Constants_RT_Service.TotalCostRiskScoreSubFailMessage);
	RequestFailedMessage := Models.Healthcare_Constants_RT_Service.SubInvalidRequest + AttributesFailMessage + ReadmissionFailMessage + MedicationAdherenceFailMessage + MotivationFailMessage + TotalCostRiskScoreFailMessage;
	
	//Exception#1
	SubscriptionFail_DS := EmptyExceptionDS0 + IF(isAttributesRequestValid = FALSE OR isReadmissionRequestValid = FALSE OR isMedicationAdherenceRequestValid = FALSE OR isMotivationRequestValid = FALSE or isTotalCostRiskScoreRequestValid = FALSE , ROW({_blank, Models.Healthcare_Constants_RT_Service.InvalidInput_Code, _blank, RequestFailedMessage}, iesp.share.t_WsException), _EmptyExceptionDSRow0);

	Models.Layouts_Healthcare_RT_Service.common_runtime_config getCfg() := transform
			custID := if(first_row.user.CompanyId <> _blank and first_row.user.CompanyId <> first_row.AccountContext.Common.GlobalCompanyId,first_row.user.CompanyId,first_row.AccountContext.Common.GlobalCompanyId);
			self.ReferenceNumber := acct_configRaw.Common.ReferenceNumber;
			self.TransactionId := acct_configRaw.Common.TransactionId;

			self.SubscribedToHealthAttributesV3 := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SubscribedToHealthAttributesV3);
			self.SubscribedToReadmissionScore := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SubscribedToReadmissionScore);
			self.SubscribedToMedicationAdherenceScore := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SubscribedToMedicationAdherenceScore);
			self.SubscribedToMotivationScore := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SubscribedToMotivationScore);
			self.SubscribedToTotalCostRiskScore := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SubscribedToTotalCostRiskScore);

			self.SuppressAccident := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SuppressAccident);
			self.SuppressAddressStability := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SuppressAddressStability);
			self.SuppressAsset := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SuppressAsset);
			self.SuppressCurrentAddress := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SuppressCurrentAddress);
			self.SuppressDemographics := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SuppressDemographics);
			self.SuppressDerogatoryRecord := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SuppressDerogatoryRecord);
			self.SuppressDerogatoryCrimeRecord := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SuppressDerogatoryCrimeRecord);
			self.SuppressDerogatoryFinancialRecord := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SuppressDerogatoryFinancialRecord);
			self.SuppressEducation := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SuppressEducation);
			self.SuppressIdentityActivity := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SuppressIdentityActivity);
			self.SuppressIdentityAssociation := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SuppressIdentityAssociation);
			self.SuppressIdentityFraudRisk := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SuppressIdentityFraudRisk);
			self.SuppressIdentityProductSearchEvent := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SuppressIdentityProductSearchEvent);
			self.SuppressIdentityValidation := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SuppressIdentityValidation);
			self.SuppressIdentityVariation := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SuppressIdentityVariation);
			self.SuppressIncome := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SuppressIncome);
			self.SuppressInputAddress := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SuppressInputAddress);
			self.SuppressInputSSN := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SuppressInputSSN);
			self.SuppressInterests := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SuppressInterests);
			self.SuppressMostRecentAddress := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SuppressMostRecentAddress);
			self.SuppressNonDerogatoryRecord := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SuppressNonDerogatoryRecord);
			self.SuppressNonDerogatoryOccupationalRecord := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SuppressNonDerogatoryOccupationalRecord);
			self.SuppressPhone := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SuppressPhone);
			self.SuppressPreviousAddress := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SuppressPreviousAddress);
			self.SuppressSubprimeRequests := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SuppressSubprimeRequests);

			val_ReadmissionScore_Category_5_High := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_ReadmissionScore_Category_5_High);
			val_ReadmissionScore_Category_5_Low := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_ReadmissionScore_Category_5_Low);
			val_ReadmissionScore_Category_4_High := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_ReadmissionScore_Category_4_High);
			val_ReadmissionScore_Category_4_Low := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_ReadmissionScore_Category_4_Low);
			val_ReadmissionScore_Category_3_High := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_ReadmissionScore_Category_3_High);
			val_ReadmissionScore_Category_3_Low := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_ReadmissionScore_Category_3_Low);
			val_ReadmissionScore_Category_2_High := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_ReadmissionScore_Category_2_High);
			val_ReadmissionScore_Category_2_Low := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_ReadmissionScore_Category_2_Low);
			val_ReadmissionScore_Category_1_High := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_ReadmissionScore_Category_1_High);
			val_ReadmissionScore_Category_1_Low := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_ReadmissionScore_Category_1_Low);

			self.ReadmissionScore_Category_5_High := IF(val_ReadmissionScore_Category_5_High <> 0,val_ReadmissionScore_Category_5_High ,Models.Healthcare_Constants_RT_Service.val_ReadmissionScore_Category_5_High );
			self.ReadmissionScore_Category_5_Low := IF(val_ReadmissionScore_Category_5_Low <> 0, val_ReadmissionScore_Category_5_Low ,Models.Healthcare_Constants_RT_Service.val_ReadmissionScore_Category_5_Low );
			self.ReadmissionScore_Category_4_High := IF(val_ReadmissionScore_Category_4_High<> 0, val_ReadmissionScore_Category_4_High ,Models.Healthcare_Constants_RT_Service.val_ReadmissionScore_Category_4_High );
			self.ReadmissionScore_Category_4_Low := IF(val_ReadmissionScore_Category_4_Low<> 0, val_ReadmissionScore_Category_4_Low ,Models.Healthcare_Constants_RT_Service.val_ReadmissionScore_Category_4_Low );
			self.ReadmissionScore_Category_3_High := IF(val_ReadmissionScore_Category_3_High<> 0, val_ReadmissionScore_Category_3_High ,Models.Healthcare_Constants_RT_Service.val_ReadmissionScore_Category_3_High );
			self.ReadmissionScore_Category_3_Low := IF(val_ReadmissionScore_Category_3_Low<> 0, val_ReadmissionScore_Category_3_Low ,Models.Healthcare_Constants_RT_Service.val_ReadmissionScore_Category_3_Low );
			self.ReadmissionScore_Category_2_High := IF(val_ReadmissionScore_Category_2_High<> 0, val_ReadmissionScore_Category_2_High ,Models.Healthcare_Constants_RT_Service.val_ReadmissionScore_Category_2_High );
			self.ReadmissionScore_Category_2_Low := IF(val_ReadmissionScore_Category_2_Low<> 0, val_ReadmissionScore_Category_2_Low ,Models.Healthcare_Constants_RT_Service.val_ReadmissionScore_Category_2_Low );
			self.ReadmissionScore_Category_1_High := IF(val_ReadmissionScore_Category_1_High<> 0, val_ReadmissionScore_Category_1_High ,Models.Healthcare_Constants_RT_Service.val_ReadmissionScore_Category_1_High );
			self.ReadmissionScore_Category_1_Low := IF(val_ReadmissionScore_Category_1_Low <> 0, val_ReadmissionScore_Category_1_Low ,Models.Healthcare_Constants_RT_Service.val_ReadmissionScore_Category_1_Low );
			
			val_MedicationAdherenceScore_Category_5_High := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_MedicationAdherenceScore_Category_5_High);
			val_MedicationAdherenceScore_Category_5_Low := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_MedicationAdherenceScore_Category_5_Low);
			val_MedicationAdherenceScore_Category_4_High := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_MedicationAdherenceScore_Category_4_High);
			val_MedicationAdherenceScore_Category_4_Low := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_MedicationAdherenceScore_Category_4_Low);
			val_MedicationAdherenceScore_Category_3_High := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_MedicationAdherenceScore_Category_3_High);
			val_MedicationAdherenceScore_Category_3_Low := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_MedicationAdherenceScore_Category_3_Low);
			val_MedicationAdherenceScore_Category_2_High := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_MedicationAdherenceScore_Category_2_High);
			val_MedicationAdherenceScore_Category_2_Low := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_MedicationAdherenceScore_Category_2_Low);
			val_MedicationAdherenceScore_Category_1_High := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_MedicationAdherenceScore_Category_1_High);
			val_MedicationAdherenceScore_Category_1_Low := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_MedicationAdherenceScore_Category_1_Low);

			self.MedicationAdherenceScore_Category_5_High := IF(val_MedicationAdherenceScore_Category_5_High <> 0,val_MedicationAdherenceScore_Category_5_High ,Models.Healthcare_Constants_RT_Service.val_MedicationAdherenceScore_Category_5_High );
			self.MedicationAdherenceScore_Category_5_Low := IF(val_MedicationAdherenceScore_Category_5_Low <> 0, val_MedicationAdherenceScore_Category_5_Low ,Models.Healthcare_Constants_RT_Service.val_MedicationAdherenceScore_Category_5_Low );
			self.MedicationAdherenceScore_Category_4_High := IF(val_MedicationAdherenceScore_Category_4_High<> 0, val_MedicationAdherenceScore_Category_4_High ,Models.Healthcare_Constants_RT_Service.val_MedicationAdherenceScore_Category_4_High );
			self.MedicationAdherenceScore_Category_4_Low := IF(val_MedicationAdherenceScore_Category_4_Low<> 0, val_MedicationAdherenceScore_Category_4_Low ,Models.Healthcare_Constants_RT_Service.val_MedicationAdherenceScore_Category_4_Low );
			self.MedicationAdherenceScore_Category_3_High := IF(val_MedicationAdherenceScore_Category_3_High<> 0, val_MedicationAdherenceScore_Category_3_High ,Models.Healthcare_Constants_RT_Service.val_MedicationAdherenceScore_Category_3_High );
			self.MedicationAdherenceScore_Category_3_Low := IF(val_MedicationAdherenceScore_Category_3_Low<> 0, val_MedicationAdherenceScore_Category_3_Low ,Models.Healthcare_Constants_RT_Service.val_MedicationAdherenceScore_Category_3_Low );
			self.MedicationAdherenceScore_Category_2_High := IF(val_MedicationAdherenceScore_Category_2_High<> 0, val_MedicationAdherenceScore_Category_2_High ,Models.Healthcare_Constants_RT_Service.val_MedicationAdherenceScore_Category_2_High );
			self.MedicationAdherenceScore_Category_2_Low := IF(val_MedicationAdherenceScore_Category_2_Low<> 0, val_MedicationAdherenceScore_Category_2_Low ,Models.Healthcare_Constants_RT_Service.val_MedicationAdherenceScore_Category_2_Low );
			self.MedicationAdherenceScore_Category_1_High := IF(val_MedicationAdherenceScore_Category_1_High<> 0, val_MedicationAdherenceScore_Category_1_High ,Models.Healthcare_Constants_RT_Service.val_MedicationAdherenceScore_Category_1_High );
			self.MedicationAdherenceScore_Category_1_Low := IF(val_MedicationAdherenceScore_Category_1_Low <> 0, val_MedicationAdherenceScore_Category_1_Low ,Models.Healthcare_Constants_RT_Service.val_MedicationAdherenceScore_Category_1_Low );
			
			val_MotivationScore_Category_5_High := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_MotivationScore_Category_5_High);
			val_MotivationScore_Category_5_Low := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_MotivationScore_Category_5_Low);
			val_MotivationScore_Category_4_High := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_MotivationScore_Category_4_High);
			val_MotivationScore_Category_4_Low := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_MotivationScore_Category_4_Low);
			val_MotivationScore_Category_3_High := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_MotivationScore_Category_3_High);
			val_MotivationScore_Category_3_Low := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_MotivationScore_Category_3_Low);
			val_MotivationScore_Category_2_High := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_MotivationScore_Category_2_High);
			val_MotivationScore_Category_2_Low := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_MotivationScore_Category_2_Low);
			val_MotivationScore_Category_1_High := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_MotivationScore_Category_1_High);
			val_MotivationScore_Category_1_Low := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_MotivationScore_Category_1_Low);

			self.MotivationScore_Category_5_High := IF(val_MotivationScore_Category_5_High <> 0,val_MotivationScore_Category_5_High ,Models.Healthcare_Constants_RT_Service.val_MotivationScore_Category_5_High );
			self.MotivationScore_Category_5_Low := IF(val_MotivationScore_Category_5_Low <> 0, val_MotivationScore_Category_5_Low ,Models.Healthcare_Constants_RT_Service.val_MotivationScore_Category_5_Low );
			self.MotivationScore_Category_4_High := IF(val_MotivationScore_Category_4_High<> 0, val_MotivationScore_Category_4_High ,Models.Healthcare_Constants_RT_Service.val_MotivationScore_Category_4_High );
			self.MotivationScore_Category_4_Low := IF(val_MotivationScore_Category_4_Low<> 0, val_MotivationScore_Category_4_Low ,Models.Healthcare_Constants_RT_Service.val_MotivationScore_Category_4_Low );
			self.MotivationScore_Category_3_High := IF(val_MotivationScore_Category_3_High<> 0, val_MotivationScore_Category_3_High ,Models.Healthcare_Constants_RT_Service.val_MotivationScore_Category_3_High );
			self.MotivationScore_Category_3_Low := IF(val_MotivationScore_Category_3_Low<> 0, val_MotivationScore_Category_3_Low ,Models.Healthcare_Constants_RT_Service.val_MotivationScore_Category_3_Low );
			self.MotivationScore_Category_2_High := IF(val_MotivationScore_Category_2_High<> 0, val_MotivationScore_Category_2_High ,Models.Healthcare_Constants_RT_Service.val_MotivationScore_Category_2_High );
			self.MotivationScore_Category_2_Low := IF(val_MotivationScore_Category_2_Low<> 0, val_MotivationScore_Category_2_Low ,Models.Healthcare_Constants_RT_Service.val_MotivationScore_Category_2_Low );
			self.MotivationScore_Category_1_High := IF(val_MotivationScore_Category_1_High<> 0, val_MotivationScore_Category_1_High ,Models.Healthcare_Constants_RT_Service.val_MotivationScore_Category_1_High );
			self.MotivationScore_Category_1_Low := IF(val_MotivationScore_Category_1_Low <> 0, val_MotivationScore_Category_1_Low ,Models.Healthcare_Constants_RT_Service.val_MotivationScore_Category_1_Low );

			val_TotalCostRiskScore_Index_Denominator := (DECIMAL7_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Index_Denominator);
			self.TotalCostRiskScore_Index_Denominator := IF(val_TotalCostRiskScore_Index_Denominator <> 0, val_TotalCostRiskScore_Index_Denominator ,Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Index_Denominator );

			val_TotalCostRiskScore_Rank_1_Min   := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_1_Min  );
			val_TotalCostRiskScore_Rank_1_Max   := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_1_Max  );
			val_TotalCostRiskScore_Rank_2_Min   := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_2_Min  );
			val_TotalCostRiskScore_Rank_2_Max   := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_2_Max  );
			val_TotalCostRiskScore_Rank_3_Min   := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_3_Min  );
			val_TotalCostRiskScore_Rank_3_Max   := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_3_Max  );
			val_TotalCostRiskScore_Rank_4_Min   := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_4_Min  );
			val_TotalCostRiskScore_Rank_4_Max   := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_4_Max  );
			val_TotalCostRiskScore_Rank_5_Min   := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_5_Min  );
			val_TotalCostRiskScore_Rank_5_Max   := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_5_Max  );
			val_TotalCostRiskScore_Rank_6_Min   := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_6_Min  );
			val_TotalCostRiskScore_Rank_6_Max   := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_6_Max  );
			val_TotalCostRiskScore_Rank_7_Min   := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_7_Min  );
			val_TotalCostRiskScore_Rank_7_Max   := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_7_Max  );
			val_TotalCostRiskScore_Rank_8_Min   := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_8_Min  );
			val_TotalCostRiskScore_Rank_8_Max   := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_8_Max  );
			val_TotalCostRiskScore_Rank_9_Min   := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_9_Min  );
			val_TotalCostRiskScore_Rank_9_Max   := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_9_Max  );
			val_TotalCostRiskScore_Rank_10_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_10_Min );
			val_TotalCostRiskScore_Rank_10_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_10_Max );
			val_TotalCostRiskScore_Rank_11_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_11_Min );
			val_TotalCostRiskScore_Rank_11_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_11_Max );
			val_TotalCostRiskScore_Rank_12_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_12_Min );
			val_TotalCostRiskScore_Rank_12_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_12_Max );
			val_TotalCostRiskScore_Rank_13_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_13_Min );
			val_TotalCostRiskScore_Rank_13_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_13_Max );
			val_TotalCostRiskScore_Rank_14_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_14_Min );
			val_TotalCostRiskScore_Rank_14_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_14_Max );
			val_TotalCostRiskScore_Rank_15_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_15_Min );
			val_TotalCostRiskScore_Rank_15_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_15_Max );
			val_TotalCostRiskScore_Rank_16_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_16_Min );
			val_TotalCostRiskScore_Rank_16_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_16_Max );
			val_TotalCostRiskScore_Rank_17_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_17_Min );
			val_TotalCostRiskScore_Rank_17_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_17_Max );
			val_TotalCostRiskScore_Rank_18_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_18_Min );
			val_TotalCostRiskScore_Rank_18_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_18_Max );
			val_TotalCostRiskScore_Rank_19_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_19_Min );
			val_TotalCostRiskScore_Rank_19_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_19_Max );
			val_TotalCostRiskScore_Rank_20_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_20_Min );
			val_TotalCostRiskScore_Rank_20_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_20_Max );
			val_TotalCostRiskScore_Rank_21_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_21_Min );
			val_TotalCostRiskScore_Rank_21_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_21_Max );
			val_TotalCostRiskScore_Rank_22_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_22_Min );
			val_TotalCostRiskScore_Rank_22_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_22_Max );
			val_TotalCostRiskScore_Rank_23_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_23_Min );
			val_TotalCostRiskScore_Rank_23_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_23_Max );
			val_TotalCostRiskScore_Rank_24_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_24_Min );
			val_TotalCostRiskScore_Rank_24_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_24_Max );
			val_TotalCostRiskScore_Rank_25_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_25_Min );
			val_TotalCostRiskScore_Rank_25_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_25_Max );
			val_TotalCostRiskScore_Rank_26_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_26_Min );
			val_TotalCostRiskScore_Rank_26_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_26_Max );
			val_TotalCostRiskScore_Rank_27_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_27_Min );
			val_TotalCostRiskScore_Rank_27_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_27_Max );
			val_TotalCostRiskScore_Rank_28_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_28_Min );
			val_TotalCostRiskScore_Rank_28_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_28_Max );
			val_TotalCostRiskScore_Rank_29_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_29_Min );
			val_TotalCostRiskScore_Rank_29_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_29_Max );
			val_TotalCostRiskScore_Rank_30_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_30_Min );
			val_TotalCostRiskScore_Rank_30_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_30_Max );
			val_TotalCostRiskScore_Rank_31_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_31_Min );
			val_TotalCostRiskScore_Rank_31_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_31_Max );
			val_TotalCostRiskScore_Rank_32_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_32_Min );
			val_TotalCostRiskScore_Rank_32_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_32_Max );
			val_TotalCostRiskScore_Rank_33_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_33_Min );
			val_TotalCostRiskScore_Rank_33_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_33_Max );
			val_TotalCostRiskScore_Rank_34_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_34_Min );
			val_TotalCostRiskScore_Rank_34_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_34_Max );
			val_TotalCostRiskScore_Rank_35_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_35_Min );
			val_TotalCostRiskScore_Rank_35_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_35_Max );
			val_TotalCostRiskScore_Rank_36_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_36_Min );
			val_TotalCostRiskScore_Rank_36_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_36_Max );
			val_TotalCostRiskScore_Rank_37_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_37_Min );
			val_TotalCostRiskScore_Rank_37_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_37_Max );
			val_TotalCostRiskScore_Rank_38_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_38_Min );
			val_TotalCostRiskScore_Rank_38_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_38_Max );
			val_TotalCostRiskScore_Rank_39_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_39_Min );
			val_TotalCostRiskScore_Rank_39_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_39_Max );
			val_TotalCostRiskScore_Rank_40_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_40_Min );
			val_TotalCostRiskScore_Rank_40_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_40_Max );
			val_TotalCostRiskScore_Rank_41_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_41_Min );
			val_TotalCostRiskScore_Rank_41_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_41_Max );
			val_TotalCostRiskScore_Rank_42_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_42_Min );
			val_TotalCostRiskScore_Rank_42_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_42_Max );
			val_TotalCostRiskScore_Rank_43_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_43_Min );
			val_TotalCostRiskScore_Rank_43_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_43_Max );
			val_TotalCostRiskScore_Rank_44_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_44_Min );
			val_TotalCostRiskScore_Rank_44_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_44_Max );
			val_TotalCostRiskScore_Rank_45_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_45_Min );
			val_TotalCostRiskScore_Rank_45_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_45_Max );
			val_TotalCostRiskScore_Rank_46_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_46_Min );
			val_TotalCostRiskScore_Rank_46_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_46_Max );
			val_TotalCostRiskScore_Rank_47_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_47_Min );
			val_TotalCostRiskScore_Rank_47_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_47_Max );
			val_TotalCostRiskScore_Rank_48_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_48_Min );
			val_TotalCostRiskScore_Rank_48_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_48_Max );
			val_TotalCostRiskScore_Rank_49_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_49_Min );
			val_TotalCostRiskScore_Rank_49_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_49_Max );
			val_TotalCostRiskScore_Rank_50_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_50_Min );
			val_TotalCostRiskScore_Rank_50_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_50_Max );
			val_TotalCostRiskScore_Rank_51_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_51_Min );
			val_TotalCostRiskScore_Rank_51_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_51_Max );
			val_TotalCostRiskScore_Rank_52_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_52_Min );
			val_TotalCostRiskScore_Rank_52_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_52_Max );
			val_TotalCostRiskScore_Rank_53_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_53_Min );
			val_TotalCostRiskScore_Rank_53_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_53_Max );
			val_TotalCostRiskScore_Rank_54_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_54_Min );
			val_TotalCostRiskScore_Rank_54_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_54_Max );
			val_TotalCostRiskScore_Rank_55_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_55_Min );
			val_TotalCostRiskScore_Rank_55_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_55_Max );
			val_TotalCostRiskScore_Rank_56_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_56_Min );
			val_TotalCostRiskScore_Rank_56_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_56_Max );
			val_TotalCostRiskScore_Rank_57_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_57_Min );
			val_TotalCostRiskScore_Rank_57_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_57_Max );
			val_TotalCostRiskScore_Rank_58_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_58_Min );
			val_TotalCostRiskScore_Rank_58_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_58_Max );
			val_TotalCostRiskScore_Rank_59_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_59_Min );
			val_TotalCostRiskScore_Rank_59_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_59_Max );
			val_TotalCostRiskScore_Rank_60_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_60_Min );
			val_TotalCostRiskScore_Rank_60_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_60_Max );
			val_TotalCostRiskScore_Rank_61_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_61_Min );
			val_TotalCostRiskScore_Rank_61_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_61_Max );
			val_TotalCostRiskScore_Rank_62_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_62_Min );
			val_TotalCostRiskScore_Rank_62_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_62_Max );
			val_TotalCostRiskScore_Rank_63_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_63_Min );
			val_TotalCostRiskScore_Rank_63_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_63_Max );
			val_TotalCostRiskScore_Rank_64_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_64_Min );
			val_TotalCostRiskScore_Rank_64_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_64_Max );
			val_TotalCostRiskScore_Rank_65_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_65_Min );
			val_TotalCostRiskScore_Rank_65_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_65_Max );
			val_TotalCostRiskScore_Rank_66_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_66_Min );
			val_TotalCostRiskScore_Rank_66_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_66_Max );
			val_TotalCostRiskScore_Rank_67_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_67_Min );
			val_TotalCostRiskScore_Rank_67_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_67_Max );
			val_TotalCostRiskScore_Rank_68_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_68_Min );
			val_TotalCostRiskScore_Rank_68_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_68_Max );
			val_TotalCostRiskScore_Rank_69_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_69_Min );
			val_TotalCostRiskScore_Rank_69_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_69_Max );
			val_TotalCostRiskScore_Rank_70_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_70_Min );
			val_TotalCostRiskScore_Rank_70_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_70_Max );
			val_TotalCostRiskScore_Rank_71_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_71_Min );
			val_TotalCostRiskScore_Rank_71_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_71_Max );
			val_TotalCostRiskScore_Rank_72_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_72_Min );
			val_TotalCostRiskScore_Rank_72_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_72_Max );
			val_TotalCostRiskScore_Rank_73_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_73_Min );
			val_TotalCostRiskScore_Rank_73_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_73_Max );
			val_TotalCostRiskScore_Rank_74_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_74_Min );
			val_TotalCostRiskScore_Rank_74_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_74_Max );
			val_TotalCostRiskScore_Rank_75_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_75_Min );
			val_TotalCostRiskScore_Rank_75_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_75_Max );
			val_TotalCostRiskScore_Rank_76_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_76_Min );
			val_TotalCostRiskScore_Rank_76_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_76_Max );
			val_TotalCostRiskScore_Rank_77_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_77_Min );
			val_TotalCostRiskScore_Rank_77_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_77_Max );
			val_TotalCostRiskScore_Rank_78_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_78_Min );
			val_TotalCostRiskScore_Rank_78_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_78_Max );
			val_TotalCostRiskScore_Rank_79_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_79_Min );
			val_TotalCostRiskScore_Rank_79_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_79_Max );
			val_TotalCostRiskScore_Rank_80_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_80_Min );
			val_TotalCostRiskScore_Rank_80_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_80_Max );
			val_TotalCostRiskScore_Rank_81_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_81_Min );
			val_TotalCostRiskScore_Rank_81_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_81_Max );
			val_TotalCostRiskScore_Rank_82_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_82_Min );
			val_TotalCostRiskScore_Rank_82_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_82_Max );
			val_TotalCostRiskScore_Rank_83_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_83_Min );
			val_TotalCostRiskScore_Rank_83_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_83_Max );
			val_TotalCostRiskScore_Rank_84_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_84_Min );
			val_TotalCostRiskScore_Rank_84_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_84_Max );
			val_TotalCostRiskScore_Rank_85_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_85_Min );
			val_TotalCostRiskScore_Rank_85_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_85_Max );
			val_TotalCostRiskScore_Rank_86_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_86_Min );
			val_TotalCostRiskScore_Rank_86_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_86_Max );
			val_TotalCostRiskScore_Rank_87_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_87_Min );
			val_TotalCostRiskScore_Rank_87_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_87_Max );
			val_TotalCostRiskScore_Rank_88_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_88_Min );
			val_TotalCostRiskScore_Rank_88_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_88_Max );
			val_TotalCostRiskScore_Rank_89_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_89_Min );
			val_TotalCostRiskScore_Rank_89_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_89_Max );
			val_TotalCostRiskScore_Rank_90_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_90_Min );
			val_TotalCostRiskScore_Rank_90_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_90_Max );
			val_TotalCostRiskScore_Rank_91_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_91_Min );
			val_TotalCostRiskScore_Rank_91_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_91_Max );
			val_TotalCostRiskScore_Rank_92_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_92_Min );
			val_TotalCostRiskScore_Rank_92_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_92_Max );
			val_TotalCostRiskScore_Rank_93_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_93_Min );
			val_TotalCostRiskScore_Rank_93_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_93_Max );
			val_TotalCostRiskScore_Rank_94_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_94_Min );
			val_TotalCostRiskScore_Rank_94_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_94_Max );
			val_TotalCostRiskScore_Rank_95_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_95_Min );
			val_TotalCostRiskScore_Rank_95_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_95_Max );
			val_TotalCostRiskScore_Rank_96_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_96_Min );
			val_TotalCostRiskScore_Rank_96_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_96_Max );
			val_TotalCostRiskScore_Rank_97_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_97_Min );
			val_TotalCostRiskScore_Rank_97_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_97_Max );
			val_TotalCostRiskScore_Rank_98_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_98_Min );
			val_TotalCostRiskScore_Rank_98_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_98_Max );
			val_TotalCostRiskScore_Rank_99_Min  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_99_Min );
			val_TotalCostRiskScore_Rank_99_Max  := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_99_Max );
			val_TotalCostRiskScore_Rank_100_Min := (DECIMAL8_4) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Rank_100_Min);

			self.TotalCostRiskScore_Rank_1_Min   := IF( val_TotalCostRiskScore_Rank_1_Min <>0, val_TotalCostRiskScore_Rank_1_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_1_Min);
			self.TotalCostRiskScore_Rank_1_Max   := IF( val_TotalCostRiskScore_Rank_1_Max <>0, val_TotalCostRiskScore_Rank_1_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_1_Max);
			self.TotalCostRiskScore_Rank_2_Min   := IF( val_TotalCostRiskScore_Rank_2_Min <>0, val_TotalCostRiskScore_Rank_2_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_2_Min);
			self.TotalCostRiskScore_Rank_2_Max   := IF( val_TotalCostRiskScore_Rank_2_Max <>0, val_TotalCostRiskScore_Rank_2_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_2_Max);
			self.TotalCostRiskScore_Rank_3_Min   := IF( val_TotalCostRiskScore_Rank_3_Min <>0, val_TotalCostRiskScore_Rank_3_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_3_Min);
			self.TotalCostRiskScore_Rank_3_Max   := IF( val_TotalCostRiskScore_Rank_3_Max <>0, val_TotalCostRiskScore_Rank_3_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_3_Max);
			self.TotalCostRiskScore_Rank_4_Min   := IF( val_TotalCostRiskScore_Rank_4_Min <>0, val_TotalCostRiskScore_Rank_4_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_4_Min);
			self.TotalCostRiskScore_Rank_4_Max   := IF( val_TotalCostRiskScore_Rank_4_Max <>0, val_TotalCostRiskScore_Rank_4_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_4_Max);
			self.TotalCostRiskScore_Rank_5_Min   := IF( val_TotalCostRiskScore_Rank_5_Min <>0, val_TotalCostRiskScore_Rank_5_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_5_Min);
			self.TotalCostRiskScore_Rank_5_Max   := IF( val_TotalCostRiskScore_Rank_5_Max <>0, val_TotalCostRiskScore_Rank_5_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_5_Max);
			self.TotalCostRiskScore_Rank_6_Min   := IF( val_TotalCostRiskScore_Rank_6_Min <>0, val_TotalCostRiskScore_Rank_6_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_6_Min);
			self.TotalCostRiskScore_Rank_6_Max   := IF( val_TotalCostRiskScore_Rank_6_Max <>0, val_TotalCostRiskScore_Rank_6_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_6_Max);
			self.TotalCostRiskScore_Rank_7_Min   := IF( val_TotalCostRiskScore_Rank_7_Min <>0, val_TotalCostRiskScore_Rank_7_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_7_Min);
			self.TotalCostRiskScore_Rank_7_Max   := IF( val_TotalCostRiskScore_Rank_7_Max <>0, val_TotalCostRiskScore_Rank_7_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_7_Max);
			self.TotalCostRiskScore_Rank_8_Min   := IF( val_TotalCostRiskScore_Rank_8_Min <>0, val_TotalCostRiskScore_Rank_8_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_8_Min);
			self.TotalCostRiskScore_Rank_8_Max   := IF( val_TotalCostRiskScore_Rank_8_Max <>0, val_TotalCostRiskScore_Rank_8_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_8_Max);
			self.TotalCostRiskScore_Rank_9_Min   := IF( val_TotalCostRiskScore_Rank_9_Min <>0, val_TotalCostRiskScore_Rank_9_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_9_Min);
			self.TotalCostRiskScore_Rank_9_Max   := IF( val_TotalCostRiskScore_Rank_9_Max <>0, val_TotalCostRiskScore_Rank_9_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_9_Max);
			self.TotalCostRiskScore_Rank_10_Min  := IF( val_TotalCostRiskScore_Rank_10_Min <>0, val_TotalCostRiskScore_Rank_10_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_10_Min);
			self.TotalCostRiskScore_Rank_10_Max  := IF( val_TotalCostRiskScore_Rank_10_Max <>0, val_TotalCostRiskScore_Rank_10_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_10_Max);
			self.TotalCostRiskScore_Rank_11_Min  := IF( val_TotalCostRiskScore_Rank_11_Min <>0, val_TotalCostRiskScore_Rank_11_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_11_Min);
			self.TotalCostRiskScore_Rank_11_Max  := IF( val_TotalCostRiskScore_Rank_11_Max <>0, val_TotalCostRiskScore_Rank_11_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_11_Max);
			self.TotalCostRiskScore_Rank_12_Min  := IF( val_TotalCostRiskScore_Rank_12_Min <>0, val_TotalCostRiskScore_Rank_12_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_12_Min);
			self.TotalCostRiskScore_Rank_12_Max  := IF( val_TotalCostRiskScore_Rank_12_Max <>0, val_TotalCostRiskScore_Rank_12_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_12_Max);
			self.TotalCostRiskScore_Rank_13_Min  := IF( val_TotalCostRiskScore_Rank_13_Min <>0, val_TotalCostRiskScore_Rank_13_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_13_Min);
			self.TotalCostRiskScore_Rank_13_Max  := IF( val_TotalCostRiskScore_Rank_13_Max <>0, val_TotalCostRiskScore_Rank_13_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_13_Max);
			self.TotalCostRiskScore_Rank_14_Min  := IF( val_TotalCostRiskScore_Rank_14_Min <>0, val_TotalCostRiskScore_Rank_14_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_14_Min);
			self.TotalCostRiskScore_Rank_14_Max  := IF( val_TotalCostRiskScore_Rank_14_Max <>0, val_TotalCostRiskScore_Rank_14_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_14_Max);
			self.TotalCostRiskScore_Rank_15_Min  := IF( val_TotalCostRiskScore_Rank_15_Min <>0, val_TotalCostRiskScore_Rank_15_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_15_Min);
			self.TotalCostRiskScore_Rank_15_Max  := IF( val_TotalCostRiskScore_Rank_15_Max <>0, val_TotalCostRiskScore_Rank_15_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_15_Max);
			self.TotalCostRiskScore_Rank_16_Min  := IF( val_TotalCostRiskScore_Rank_16_Min <>0, val_TotalCostRiskScore_Rank_16_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_16_Min);
			self.TotalCostRiskScore_Rank_16_Max  := IF( val_TotalCostRiskScore_Rank_16_Max <>0, val_TotalCostRiskScore_Rank_16_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_16_Max);
			self.TotalCostRiskScore_Rank_17_Min  := IF( val_TotalCostRiskScore_Rank_17_Min <>0, val_TotalCostRiskScore_Rank_17_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_17_Min);
			self.TotalCostRiskScore_Rank_17_Max  := IF( val_TotalCostRiskScore_Rank_17_Max <>0, val_TotalCostRiskScore_Rank_17_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_17_Max);
			self.TotalCostRiskScore_Rank_18_Min  := IF( val_TotalCostRiskScore_Rank_18_Min <>0, val_TotalCostRiskScore_Rank_18_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_18_Min);
			self.TotalCostRiskScore_Rank_18_Max  := IF( val_TotalCostRiskScore_Rank_18_Max <>0, val_TotalCostRiskScore_Rank_18_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_18_Max);
			self.TotalCostRiskScore_Rank_19_Min  := IF( val_TotalCostRiskScore_Rank_19_Min <>0, val_TotalCostRiskScore_Rank_19_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_19_Min);
			self.TotalCostRiskScore_Rank_19_Max  := IF( val_TotalCostRiskScore_Rank_19_Max <>0, val_TotalCostRiskScore_Rank_19_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_19_Max);
			self.TotalCostRiskScore_Rank_20_Min  := IF( val_TotalCostRiskScore_Rank_20_Min <>0, val_TotalCostRiskScore_Rank_20_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_20_Min);
			self.TotalCostRiskScore_Rank_20_Max  := IF( val_TotalCostRiskScore_Rank_20_Max <>0, val_TotalCostRiskScore_Rank_20_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_20_Max);
			self.TotalCostRiskScore_Rank_21_Min  := IF( val_TotalCostRiskScore_Rank_21_Min <>0, val_TotalCostRiskScore_Rank_21_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_21_Min);
			self.TotalCostRiskScore_Rank_21_Max  := IF( val_TotalCostRiskScore_Rank_21_Max <>0, val_TotalCostRiskScore_Rank_21_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_21_Max);
			self.TotalCostRiskScore_Rank_22_Min  := IF( val_TotalCostRiskScore_Rank_22_Min <>0, val_TotalCostRiskScore_Rank_22_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_22_Min);
			self.TotalCostRiskScore_Rank_22_Max  := IF( val_TotalCostRiskScore_Rank_22_Max <>0, val_TotalCostRiskScore_Rank_22_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_22_Max);
			self.TotalCostRiskScore_Rank_23_Min  := IF( val_TotalCostRiskScore_Rank_23_Min <>0, val_TotalCostRiskScore_Rank_23_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_23_Min);
			self.TotalCostRiskScore_Rank_23_Max  := IF( val_TotalCostRiskScore_Rank_23_Max <>0, val_TotalCostRiskScore_Rank_23_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_23_Max);
			self.TotalCostRiskScore_Rank_24_Min  := IF( val_TotalCostRiskScore_Rank_24_Min <>0, val_TotalCostRiskScore_Rank_24_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_24_Min);
			self.TotalCostRiskScore_Rank_24_Max  := IF( val_TotalCostRiskScore_Rank_24_Max <>0, val_TotalCostRiskScore_Rank_24_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_24_Max);
			self.TotalCostRiskScore_Rank_25_Min  := IF( val_TotalCostRiskScore_Rank_25_Min <>0, val_TotalCostRiskScore_Rank_25_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_25_Min);
			self.TotalCostRiskScore_Rank_25_Max  := IF( val_TotalCostRiskScore_Rank_25_Max <>0, val_TotalCostRiskScore_Rank_25_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_25_Max);
			self.TotalCostRiskScore_Rank_26_Min  := IF( val_TotalCostRiskScore_Rank_26_Min <>0, val_TotalCostRiskScore_Rank_26_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_26_Min);
			self.TotalCostRiskScore_Rank_26_Max  := IF( val_TotalCostRiskScore_Rank_26_Max <>0, val_TotalCostRiskScore_Rank_26_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_26_Max);
			self.TotalCostRiskScore_Rank_27_Min  := IF( val_TotalCostRiskScore_Rank_27_Min <>0, val_TotalCostRiskScore_Rank_27_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_27_Min);
			self.TotalCostRiskScore_Rank_27_Max  := IF( val_TotalCostRiskScore_Rank_27_Max <>0, val_TotalCostRiskScore_Rank_27_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_27_Max);
			self.TotalCostRiskScore_Rank_28_Min  := IF( val_TotalCostRiskScore_Rank_28_Min <>0, val_TotalCostRiskScore_Rank_28_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_28_Min);
			self.TotalCostRiskScore_Rank_28_Max  := IF( val_TotalCostRiskScore_Rank_28_Max <>0, val_TotalCostRiskScore_Rank_28_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_28_Max);
			self.TotalCostRiskScore_Rank_29_Min  := IF( val_TotalCostRiskScore_Rank_29_Min <>0, val_TotalCostRiskScore_Rank_29_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_29_Min);
			self.TotalCostRiskScore_Rank_29_Max  := IF( val_TotalCostRiskScore_Rank_29_Max <>0, val_TotalCostRiskScore_Rank_29_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_29_Max);
			self.TotalCostRiskScore_Rank_30_Min  := IF( val_TotalCostRiskScore_Rank_30_Min <>0, val_TotalCostRiskScore_Rank_30_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_30_Min);
			self.TotalCostRiskScore_Rank_30_Max  := IF( val_TotalCostRiskScore_Rank_30_Max <>0, val_TotalCostRiskScore_Rank_30_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_30_Max);
			self.TotalCostRiskScore_Rank_31_Min  := IF( val_TotalCostRiskScore_Rank_31_Min <>0, val_TotalCostRiskScore_Rank_31_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_31_Min);
			self.TotalCostRiskScore_Rank_31_Max  := IF( val_TotalCostRiskScore_Rank_31_Max <>0, val_TotalCostRiskScore_Rank_31_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_31_Max);
			self.TotalCostRiskScore_Rank_32_Min  := IF( val_TotalCostRiskScore_Rank_32_Min <>0, val_TotalCostRiskScore_Rank_32_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_32_Min);
			self.TotalCostRiskScore_Rank_32_Max  := IF( val_TotalCostRiskScore_Rank_32_Max <>0, val_TotalCostRiskScore_Rank_32_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_32_Max);
			self.TotalCostRiskScore_Rank_33_Min  := IF( val_TotalCostRiskScore_Rank_33_Min <>0, val_TotalCostRiskScore_Rank_33_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_33_Min);
			self.TotalCostRiskScore_Rank_33_Max  := IF( val_TotalCostRiskScore_Rank_33_Max <>0, val_TotalCostRiskScore_Rank_33_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_33_Max);
			self.TotalCostRiskScore_Rank_34_Min  := IF( val_TotalCostRiskScore_Rank_34_Min <>0, val_TotalCostRiskScore_Rank_34_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_34_Min);
			self.TotalCostRiskScore_Rank_34_Max  := IF( val_TotalCostRiskScore_Rank_34_Max <>0, val_TotalCostRiskScore_Rank_34_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_34_Max);
			self.TotalCostRiskScore_Rank_35_Min  := IF( val_TotalCostRiskScore_Rank_35_Min <>0, val_TotalCostRiskScore_Rank_35_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_35_Min);
			self.TotalCostRiskScore_Rank_35_Max  := IF( val_TotalCostRiskScore_Rank_35_Max <>0, val_TotalCostRiskScore_Rank_35_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_35_Max);
			self.TotalCostRiskScore_Rank_36_Min  := IF( val_TotalCostRiskScore_Rank_36_Min <>0, val_TotalCostRiskScore_Rank_36_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_36_Min);
			self.TotalCostRiskScore_Rank_36_Max  := IF( val_TotalCostRiskScore_Rank_36_Max <>0, val_TotalCostRiskScore_Rank_36_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_36_Max);
			self.TotalCostRiskScore_Rank_37_Min  := IF( val_TotalCostRiskScore_Rank_37_Min <>0, val_TotalCostRiskScore_Rank_37_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_37_Min);
			self.TotalCostRiskScore_Rank_37_Max  := IF( val_TotalCostRiskScore_Rank_37_Max <>0, val_TotalCostRiskScore_Rank_37_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_37_Max);
			self.TotalCostRiskScore_Rank_38_Min  := IF( val_TotalCostRiskScore_Rank_38_Min <>0, val_TotalCostRiskScore_Rank_38_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_38_Min);
			self.TotalCostRiskScore_Rank_38_Max  := IF( val_TotalCostRiskScore_Rank_38_Max <>0, val_TotalCostRiskScore_Rank_38_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_38_Max);
			self.TotalCostRiskScore_Rank_39_Min  := IF( val_TotalCostRiskScore_Rank_39_Min <>0, val_TotalCostRiskScore_Rank_39_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_39_Min);
			self.TotalCostRiskScore_Rank_39_Max  := IF( val_TotalCostRiskScore_Rank_39_Max <>0, val_TotalCostRiskScore_Rank_39_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_39_Max);
			self.TotalCostRiskScore_Rank_40_Min  := IF( val_TotalCostRiskScore_Rank_40_Min <>0, val_TotalCostRiskScore_Rank_40_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_40_Min);
			self.TotalCostRiskScore_Rank_40_Max  := IF( val_TotalCostRiskScore_Rank_40_Max <>0, val_TotalCostRiskScore_Rank_40_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_40_Max);
			self.TotalCostRiskScore_Rank_41_Min  := IF( val_TotalCostRiskScore_Rank_41_Min <>0, val_TotalCostRiskScore_Rank_41_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_41_Min);
			self.TotalCostRiskScore_Rank_41_Max  := IF( val_TotalCostRiskScore_Rank_41_Max <>0, val_TotalCostRiskScore_Rank_41_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_41_Max);
			self.TotalCostRiskScore_Rank_42_Min  := IF( val_TotalCostRiskScore_Rank_42_Min <>0, val_TotalCostRiskScore_Rank_42_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_42_Min);
			self.TotalCostRiskScore_Rank_42_Max  := IF( val_TotalCostRiskScore_Rank_42_Max <>0, val_TotalCostRiskScore_Rank_42_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_42_Max);
			self.TotalCostRiskScore_Rank_43_Min  := IF( val_TotalCostRiskScore_Rank_43_Min <>0, val_TotalCostRiskScore_Rank_43_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_43_Min);
			self.TotalCostRiskScore_Rank_43_Max  := IF( val_TotalCostRiskScore_Rank_43_Max <>0, val_TotalCostRiskScore_Rank_43_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_43_Max);
			self.TotalCostRiskScore_Rank_44_Min  := IF( val_TotalCostRiskScore_Rank_44_Min <>0, val_TotalCostRiskScore_Rank_44_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_44_Min);
			self.TotalCostRiskScore_Rank_44_Max  := IF( val_TotalCostRiskScore_Rank_44_Max <>0, val_TotalCostRiskScore_Rank_44_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_44_Max);
			self.TotalCostRiskScore_Rank_45_Min  := IF( val_TotalCostRiskScore_Rank_45_Min <>0, val_TotalCostRiskScore_Rank_45_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_45_Min);
			self.TotalCostRiskScore_Rank_45_Max  := IF( val_TotalCostRiskScore_Rank_45_Max <>0, val_TotalCostRiskScore_Rank_45_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_45_Max);
			self.TotalCostRiskScore_Rank_46_Min  := IF( val_TotalCostRiskScore_Rank_46_Min <>0, val_TotalCostRiskScore_Rank_46_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_46_Min);
			self.TotalCostRiskScore_Rank_46_Max  := IF( val_TotalCostRiskScore_Rank_46_Max <>0, val_TotalCostRiskScore_Rank_46_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_46_Max);
			self.TotalCostRiskScore_Rank_47_Min  := IF( val_TotalCostRiskScore_Rank_47_Min <>0, val_TotalCostRiskScore_Rank_47_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_47_Min);
			self.TotalCostRiskScore_Rank_47_Max  := IF( val_TotalCostRiskScore_Rank_47_Max <>0, val_TotalCostRiskScore_Rank_47_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_47_Max);
			self.TotalCostRiskScore_Rank_48_Min  := IF( val_TotalCostRiskScore_Rank_48_Min <>0, val_TotalCostRiskScore_Rank_48_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_48_Min);
			self.TotalCostRiskScore_Rank_48_Max  := IF( val_TotalCostRiskScore_Rank_48_Max <>0, val_TotalCostRiskScore_Rank_48_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_48_Max);
			self.TotalCostRiskScore_Rank_49_Min  := IF( val_TotalCostRiskScore_Rank_49_Min <>0, val_TotalCostRiskScore_Rank_49_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_49_Min);
			self.TotalCostRiskScore_Rank_49_Max  := IF( val_TotalCostRiskScore_Rank_49_Max <>0, val_TotalCostRiskScore_Rank_49_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_49_Max);
			self.TotalCostRiskScore_Rank_50_Min  := IF( val_TotalCostRiskScore_Rank_50_Min <>0, val_TotalCostRiskScore_Rank_50_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_50_Min);
			self.TotalCostRiskScore_Rank_50_Max  := IF( val_TotalCostRiskScore_Rank_50_Max <>0, val_TotalCostRiskScore_Rank_50_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_50_Max);
			self.TotalCostRiskScore_Rank_51_Min  := IF( val_TotalCostRiskScore_Rank_51_Min <>0, val_TotalCostRiskScore_Rank_51_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_51_Min);
			self.TotalCostRiskScore_Rank_51_Max  := IF( val_TotalCostRiskScore_Rank_51_Max <>0, val_TotalCostRiskScore_Rank_51_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_51_Max);
			self.TotalCostRiskScore_Rank_52_Min  := IF( val_TotalCostRiskScore_Rank_52_Min <>0, val_TotalCostRiskScore_Rank_52_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_52_Min);
			self.TotalCostRiskScore_Rank_52_Max  := IF( val_TotalCostRiskScore_Rank_52_Max <>0, val_TotalCostRiskScore_Rank_52_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_52_Max);
			self.TotalCostRiskScore_Rank_53_Min  := IF( val_TotalCostRiskScore_Rank_53_Min <>0, val_TotalCostRiskScore_Rank_53_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_53_Min);
			self.TotalCostRiskScore_Rank_53_Max  := IF( val_TotalCostRiskScore_Rank_53_Max <>0, val_TotalCostRiskScore_Rank_53_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_53_Max);
			self.TotalCostRiskScore_Rank_54_Min  := IF( val_TotalCostRiskScore_Rank_54_Min <>0, val_TotalCostRiskScore_Rank_54_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_54_Min);
			self.TotalCostRiskScore_Rank_54_Max  := IF( val_TotalCostRiskScore_Rank_54_Max <>0, val_TotalCostRiskScore_Rank_54_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_54_Max);
			self.TotalCostRiskScore_Rank_55_Min  := IF( val_TotalCostRiskScore_Rank_55_Min <>0, val_TotalCostRiskScore_Rank_55_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_55_Min);
			self.TotalCostRiskScore_Rank_55_Max  := IF( val_TotalCostRiskScore_Rank_55_Max <>0, val_TotalCostRiskScore_Rank_55_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_55_Max);
			self.TotalCostRiskScore_Rank_56_Min  := IF( val_TotalCostRiskScore_Rank_56_Min <>0, val_TotalCostRiskScore_Rank_56_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_56_Min);
			self.TotalCostRiskScore_Rank_56_Max  := IF( val_TotalCostRiskScore_Rank_56_Max <>0, val_TotalCostRiskScore_Rank_56_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_56_Max);
			self.TotalCostRiskScore_Rank_57_Min  := IF( val_TotalCostRiskScore_Rank_57_Min <>0, val_TotalCostRiskScore_Rank_57_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_57_Min);
			self.TotalCostRiskScore_Rank_57_Max  := IF( val_TotalCostRiskScore_Rank_57_Max <>0, val_TotalCostRiskScore_Rank_57_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_57_Max);
			self.TotalCostRiskScore_Rank_58_Min  := IF( val_TotalCostRiskScore_Rank_58_Min <>0, val_TotalCostRiskScore_Rank_58_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_58_Min);
			self.TotalCostRiskScore_Rank_58_Max  := IF( val_TotalCostRiskScore_Rank_58_Max <>0, val_TotalCostRiskScore_Rank_58_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_58_Max);
			self.TotalCostRiskScore_Rank_59_Min  := IF( val_TotalCostRiskScore_Rank_59_Min <>0, val_TotalCostRiskScore_Rank_59_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_59_Min);
			self.TotalCostRiskScore_Rank_59_Max  := IF( val_TotalCostRiskScore_Rank_59_Max <>0, val_TotalCostRiskScore_Rank_59_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_59_Max);
			self.TotalCostRiskScore_Rank_60_Min  := IF( val_TotalCostRiskScore_Rank_60_Min <>0, val_TotalCostRiskScore_Rank_60_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_60_Min);
			self.TotalCostRiskScore_Rank_60_Max  := IF( val_TotalCostRiskScore_Rank_60_Max <>0, val_TotalCostRiskScore_Rank_60_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_60_Max);
			self.TotalCostRiskScore_Rank_61_Min  := IF( val_TotalCostRiskScore_Rank_61_Min <>0, val_TotalCostRiskScore_Rank_61_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_61_Min);
			self.TotalCostRiskScore_Rank_61_Max  := IF( val_TotalCostRiskScore_Rank_61_Max <>0, val_TotalCostRiskScore_Rank_61_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_61_Max);
			self.TotalCostRiskScore_Rank_62_Min  := IF( val_TotalCostRiskScore_Rank_62_Min <>0, val_TotalCostRiskScore_Rank_62_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_62_Min);
			self.TotalCostRiskScore_Rank_62_Max  := IF( val_TotalCostRiskScore_Rank_62_Max <>0, val_TotalCostRiskScore_Rank_62_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_62_Max);
			self.TotalCostRiskScore_Rank_63_Min  := IF( val_TotalCostRiskScore_Rank_63_Min <>0, val_TotalCostRiskScore_Rank_63_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_63_Min);
			self.TotalCostRiskScore_Rank_63_Max  := IF( val_TotalCostRiskScore_Rank_63_Max <>0, val_TotalCostRiskScore_Rank_63_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_63_Max);
			self.TotalCostRiskScore_Rank_64_Min  := IF( val_TotalCostRiskScore_Rank_64_Min <>0, val_TotalCostRiskScore_Rank_64_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_64_Min);
			self.TotalCostRiskScore_Rank_64_Max  := IF( val_TotalCostRiskScore_Rank_64_Max <>0, val_TotalCostRiskScore_Rank_64_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_64_Max);
			self.TotalCostRiskScore_Rank_65_Min  := IF( val_TotalCostRiskScore_Rank_65_Min <>0, val_TotalCostRiskScore_Rank_65_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_65_Min);
			self.TotalCostRiskScore_Rank_65_Max  := IF( val_TotalCostRiskScore_Rank_65_Max <>0, val_TotalCostRiskScore_Rank_65_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_65_Max);
			self.TotalCostRiskScore_Rank_66_Min  := IF( val_TotalCostRiskScore_Rank_66_Min <>0, val_TotalCostRiskScore_Rank_66_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_66_Min);
			self.TotalCostRiskScore_Rank_66_Max  := IF( val_TotalCostRiskScore_Rank_66_Max <>0, val_TotalCostRiskScore_Rank_66_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_66_Max);
			self.TotalCostRiskScore_Rank_67_Min  := IF( val_TotalCostRiskScore_Rank_67_Min <>0, val_TotalCostRiskScore_Rank_67_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_67_Min);
			self.TotalCostRiskScore_Rank_67_Max  := IF( val_TotalCostRiskScore_Rank_67_Max <>0, val_TotalCostRiskScore_Rank_67_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_67_Max);
			self.TotalCostRiskScore_Rank_68_Min  := IF( val_TotalCostRiskScore_Rank_68_Min <>0, val_TotalCostRiskScore_Rank_68_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_68_Min);
			self.TotalCostRiskScore_Rank_68_Max  := IF( val_TotalCostRiskScore_Rank_68_Max <>0, val_TotalCostRiskScore_Rank_68_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_68_Max);
			self.TotalCostRiskScore_Rank_69_Min  := IF( val_TotalCostRiskScore_Rank_69_Min <>0, val_TotalCostRiskScore_Rank_69_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_69_Min);
			self.TotalCostRiskScore_Rank_69_Max  := IF( val_TotalCostRiskScore_Rank_69_Max <>0, val_TotalCostRiskScore_Rank_69_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_69_Max);
			self.TotalCostRiskScore_Rank_70_Min  := IF( val_TotalCostRiskScore_Rank_70_Min <>0, val_TotalCostRiskScore_Rank_70_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_70_Min);
			self.TotalCostRiskScore_Rank_70_Max  := IF( val_TotalCostRiskScore_Rank_70_Max <>0, val_TotalCostRiskScore_Rank_70_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_70_Max);
			self.TotalCostRiskScore_Rank_71_Min  := IF( val_TotalCostRiskScore_Rank_71_Min <>0, val_TotalCostRiskScore_Rank_71_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_71_Min);
			self.TotalCostRiskScore_Rank_71_Max  := IF( val_TotalCostRiskScore_Rank_71_Max <>0, val_TotalCostRiskScore_Rank_71_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_71_Max);
			self.TotalCostRiskScore_Rank_72_Min  := IF( val_TotalCostRiskScore_Rank_72_Min <>0, val_TotalCostRiskScore_Rank_72_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_72_Min);
			self.TotalCostRiskScore_Rank_72_Max  := IF( val_TotalCostRiskScore_Rank_72_Max <>0, val_TotalCostRiskScore_Rank_72_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_72_Max);
			self.TotalCostRiskScore_Rank_73_Min  := IF( val_TotalCostRiskScore_Rank_73_Min <>0, val_TotalCostRiskScore_Rank_73_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_73_Min);
			self.TotalCostRiskScore_Rank_73_Max  := IF( val_TotalCostRiskScore_Rank_73_Max <>0, val_TotalCostRiskScore_Rank_73_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_73_Max);
			self.TotalCostRiskScore_Rank_74_Min  := IF( val_TotalCostRiskScore_Rank_74_Min <>0, val_TotalCostRiskScore_Rank_74_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_74_Min);
			self.TotalCostRiskScore_Rank_74_Max  := IF( val_TotalCostRiskScore_Rank_74_Max <>0, val_TotalCostRiskScore_Rank_74_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_74_Max);
			self.TotalCostRiskScore_Rank_75_Min  := IF( val_TotalCostRiskScore_Rank_75_Min <>0, val_TotalCostRiskScore_Rank_75_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_75_Min);
			self.TotalCostRiskScore_Rank_75_Max  := IF( val_TotalCostRiskScore_Rank_75_Max <>0, val_TotalCostRiskScore_Rank_75_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_75_Max);
			self.TotalCostRiskScore_Rank_76_Min  := IF( val_TotalCostRiskScore_Rank_76_Min <>0, val_TotalCostRiskScore_Rank_76_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_76_Min);
			self.TotalCostRiskScore_Rank_76_Max  := IF( val_TotalCostRiskScore_Rank_76_Max <>0, val_TotalCostRiskScore_Rank_76_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_76_Max);
			self.TotalCostRiskScore_Rank_77_Min  := IF( val_TotalCostRiskScore_Rank_77_Min <>0, val_TotalCostRiskScore_Rank_77_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_77_Min);
			self.TotalCostRiskScore_Rank_77_Max  := IF( val_TotalCostRiskScore_Rank_77_Max <>0, val_TotalCostRiskScore_Rank_77_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_77_Max);
			self.TotalCostRiskScore_Rank_78_Min  := IF( val_TotalCostRiskScore_Rank_78_Min <>0, val_TotalCostRiskScore_Rank_78_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_78_Min);
			self.TotalCostRiskScore_Rank_78_Max  := IF( val_TotalCostRiskScore_Rank_78_Max <>0, val_TotalCostRiskScore_Rank_78_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_78_Max);
			self.TotalCostRiskScore_Rank_79_Min  := IF( val_TotalCostRiskScore_Rank_79_Min <>0, val_TotalCostRiskScore_Rank_79_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_79_Min);
			self.TotalCostRiskScore_Rank_79_Max  := IF( val_TotalCostRiskScore_Rank_79_Max <>0, val_TotalCostRiskScore_Rank_79_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_79_Max);
			self.TotalCostRiskScore_Rank_80_Min  := IF( val_TotalCostRiskScore_Rank_80_Min <>0, val_TotalCostRiskScore_Rank_80_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_80_Min);
			self.TotalCostRiskScore_Rank_80_Max  := IF( val_TotalCostRiskScore_Rank_80_Max <>0, val_TotalCostRiskScore_Rank_80_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_80_Max);
			self.TotalCostRiskScore_Rank_81_Min  := IF( val_TotalCostRiskScore_Rank_81_Min <>0, val_TotalCostRiskScore_Rank_81_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_81_Min);
			self.TotalCostRiskScore_Rank_81_Max  := IF( val_TotalCostRiskScore_Rank_81_Max <>0, val_TotalCostRiskScore_Rank_81_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_81_Max);
			self.TotalCostRiskScore_Rank_82_Min  := IF( val_TotalCostRiskScore_Rank_82_Min <>0, val_TotalCostRiskScore_Rank_82_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_82_Min);
			self.TotalCostRiskScore_Rank_82_Max  := IF( val_TotalCostRiskScore_Rank_82_Max <>0, val_TotalCostRiskScore_Rank_82_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_82_Max);
			self.TotalCostRiskScore_Rank_83_Min  := IF( val_TotalCostRiskScore_Rank_83_Min <>0, val_TotalCostRiskScore_Rank_83_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_83_Min);
			self.TotalCostRiskScore_Rank_83_Max  := IF( val_TotalCostRiskScore_Rank_83_Max <>0, val_TotalCostRiskScore_Rank_83_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_83_Max);
			self.TotalCostRiskScore_Rank_84_Min  := IF( val_TotalCostRiskScore_Rank_84_Min <>0, val_TotalCostRiskScore_Rank_84_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_84_Min);
			self.TotalCostRiskScore_Rank_84_Max  := IF( val_TotalCostRiskScore_Rank_84_Max <>0, val_TotalCostRiskScore_Rank_84_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_84_Max);
			self.TotalCostRiskScore_Rank_85_Min  := IF( val_TotalCostRiskScore_Rank_85_Min <>0, val_TotalCostRiskScore_Rank_85_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_85_Min);
			self.TotalCostRiskScore_Rank_85_Max  := IF( val_TotalCostRiskScore_Rank_85_Max <>0, val_TotalCostRiskScore_Rank_85_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_85_Max);
			self.TotalCostRiskScore_Rank_86_Min  := IF( val_TotalCostRiskScore_Rank_86_Min <>0, val_TotalCostRiskScore_Rank_86_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_86_Min);
			self.TotalCostRiskScore_Rank_86_Max  := IF( val_TotalCostRiskScore_Rank_86_Max <>0, val_TotalCostRiskScore_Rank_86_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_86_Max);
			self.TotalCostRiskScore_Rank_87_Min  := IF( val_TotalCostRiskScore_Rank_87_Min <>0, val_TotalCostRiskScore_Rank_87_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_87_Min);
			self.TotalCostRiskScore_Rank_87_Max  := IF( val_TotalCostRiskScore_Rank_87_Max <>0, val_TotalCostRiskScore_Rank_87_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_87_Max);
			self.TotalCostRiskScore_Rank_88_Min  := IF( val_TotalCostRiskScore_Rank_88_Min <>0, val_TotalCostRiskScore_Rank_88_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_88_Min);
			self.TotalCostRiskScore_Rank_88_Max  := IF( val_TotalCostRiskScore_Rank_88_Max <>0, val_TotalCostRiskScore_Rank_88_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_88_Max);
			self.TotalCostRiskScore_Rank_89_Min  := IF( val_TotalCostRiskScore_Rank_89_Min <>0, val_TotalCostRiskScore_Rank_89_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_89_Min);
			self.TotalCostRiskScore_Rank_89_Max  := IF( val_TotalCostRiskScore_Rank_89_Max <>0, val_TotalCostRiskScore_Rank_89_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_89_Max);
			self.TotalCostRiskScore_Rank_90_Min  := IF( val_TotalCostRiskScore_Rank_90_Min <>0, val_TotalCostRiskScore_Rank_90_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_90_Min);
			self.TotalCostRiskScore_Rank_90_Max  := IF( val_TotalCostRiskScore_Rank_90_Max <>0, val_TotalCostRiskScore_Rank_90_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_90_Max);
			self.TotalCostRiskScore_Rank_91_Min  := IF( val_TotalCostRiskScore_Rank_91_Min <>0, val_TotalCostRiskScore_Rank_91_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_91_Min);
			self.TotalCostRiskScore_Rank_91_Max  := IF( val_TotalCostRiskScore_Rank_91_Max <>0, val_TotalCostRiskScore_Rank_91_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_91_Max);
			self.TotalCostRiskScore_Rank_92_Min  := IF( val_TotalCostRiskScore_Rank_92_Min <>0, val_TotalCostRiskScore_Rank_92_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_92_Min);
			self.TotalCostRiskScore_Rank_92_Max  := IF( val_TotalCostRiskScore_Rank_92_Max <>0, val_TotalCostRiskScore_Rank_92_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_92_Max);
			self.TotalCostRiskScore_Rank_93_Min  := IF( val_TotalCostRiskScore_Rank_93_Min <>0, val_TotalCostRiskScore_Rank_93_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_93_Min);
			self.TotalCostRiskScore_Rank_93_Max  := IF( val_TotalCostRiskScore_Rank_93_Max <>0, val_TotalCostRiskScore_Rank_93_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_93_Max);
			self.TotalCostRiskScore_Rank_94_Min  := IF( val_TotalCostRiskScore_Rank_94_Min <>0, val_TotalCostRiskScore_Rank_94_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_94_Min);
			self.TotalCostRiskScore_Rank_94_Max  := IF( val_TotalCostRiskScore_Rank_94_Max <>0, val_TotalCostRiskScore_Rank_94_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_94_Max);
			self.TotalCostRiskScore_Rank_95_Min  := IF( val_TotalCostRiskScore_Rank_95_Min <>0, val_TotalCostRiskScore_Rank_95_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_95_Min);
			self.TotalCostRiskScore_Rank_95_Max  := IF( val_TotalCostRiskScore_Rank_95_Max <>0, val_TotalCostRiskScore_Rank_95_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_95_Max);
			self.TotalCostRiskScore_Rank_96_Min  := IF( val_TotalCostRiskScore_Rank_96_Min <>0, val_TotalCostRiskScore_Rank_96_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_96_Min);
			self.TotalCostRiskScore_Rank_96_Max  := IF( val_TotalCostRiskScore_Rank_96_Max <>0, val_TotalCostRiskScore_Rank_96_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_96_Max);
			self.TotalCostRiskScore_Rank_97_Min  := IF( val_TotalCostRiskScore_Rank_97_Min <>0, val_TotalCostRiskScore_Rank_97_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_97_Min);
			self.TotalCostRiskScore_Rank_97_Max  := IF( val_TotalCostRiskScore_Rank_97_Max <>0, val_TotalCostRiskScore_Rank_97_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_97_Max);
			self.TotalCostRiskScore_Rank_98_Min  := IF( val_TotalCostRiskScore_Rank_98_Min <>0, val_TotalCostRiskScore_Rank_98_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_98_Min);
			self.TotalCostRiskScore_Rank_98_Max  := IF( val_TotalCostRiskScore_Rank_98_Max <>0, val_TotalCostRiskScore_Rank_98_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_98_Max);
			self.TotalCostRiskScore_Rank_99_Min  := IF( val_TotalCostRiskScore_Rank_99_Min <>0, val_TotalCostRiskScore_Rank_99_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_99_Min);
			self.TotalCostRiskScore_Rank_99_Max  := IF( val_TotalCostRiskScore_Rank_99_Max <>0, val_TotalCostRiskScore_Rank_99_Max, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_99_Max);
			self.TotalCostRiskScore_Rank_100_Min := IF( val_TotalCostRiskScore_Rank_100_Min <>0, val_TotalCostRiskScore_Rank_100_Min, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Rank_100_Min);

			val_TotalCostRiskScore_Category_5_Low  := (UNSIGNED1) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Category_5_Low );
			val_TotalCostRiskScore_Category_4_High := (UNSIGNED1) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Category_4_High);
			val_TotalCostRiskScore_Category_4_Low  := (UNSIGNED1) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Category_4_Low );
			val_TotalCostRiskScore_Category_3_High := (UNSIGNED1) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Category_3_High);
			val_TotalCostRiskScore_Category_3_Low  := (UNSIGNED1) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Category_3_Low );
			val_TotalCostRiskScore_Category_2_High := (UNSIGNED1) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Category_2_High);
			val_TotalCostRiskScore_Category_2_Low  := (UNSIGNED1) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Category_2_Low );
			val_TotalCostRiskScore_Category_1_High := (UNSIGNED1) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_TotalCostRiskScore_Category_1_High);

			self.TotalCostRiskScore_Category_5_Low  := IF(val_TotalCostRiskScore_Category_5_Low  <>0, val_TotalCostRiskScore_Category_5_Low , Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Category_5_Low );
			self.TotalCostRiskScore_Category_4_High := IF(val_TotalCostRiskScore_Category_4_High <>0, val_TotalCostRiskScore_Category_4_High, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Category_4_High);
			self.TotalCostRiskScore_Category_4_Low  := IF(val_TotalCostRiskScore_Category_4_Low  <>0, val_TotalCostRiskScore_Category_4_Low , Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Category_4_Low );
			self.TotalCostRiskScore_Category_3_High := IF(val_TotalCostRiskScore_Category_3_High <>0, val_TotalCostRiskScore_Category_3_High, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Category_3_High);
			self.TotalCostRiskScore_Category_3_Low  := IF(val_TotalCostRiskScore_Category_3_Low  <>0, val_TotalCostRiskScore_Category_3_Low , Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Category_3_Low );
			self.TotalCostRiskScore_Category_2_High := IF(val_TotalCostRiskScore_Category_2_High <>0, val_TotalCostRiskScore_Category_2_High, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Category_2_High);
			self.TotalCostRiskScore_Category_2_Low  := IF(val_TotalCostRiskScore_Category_2_Low  <>0, val_TotalCostRiskScore_Category_2_Low , Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Category_2_Low );
			self.TotalCostRiskScore_Category_1_High := IF(val_TotalCostRiskScore_Category_1_High <>0, val_TotalCostRiskScore_Category_1_High, Models.Healthcare_Constants_RT_Service.val_TotalCostRiskScore_Category_1_High);
			
			val_LexIdSourceOptout := (UNSIGNED1) Models.Healthcare_SocioEconomic_Functions_RT_Service.getCatThresholdValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_LexIdSourceOptout);
			self.LexIdSourceOptout := IF(val_LexIdSourceOptout IN [0,1,2], val_LexIdSourceOptout, Models.Healthcare_Constants_RT_Service.val_LexIdSourceOptout);
			self.SuppressResultsForOptOuts := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP_DefaultTrue(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SuppressResultsForOptOuts);
			self := [];
	end;
	dsCfg := dataset([getCfg()]);
	// OUTPUT(dsCfg, NAMED('dsCfg'));

	// Checking the ReadmissionScore_Category thresholds for overlaps 
	IF(dsCfg[1].ReadmissionScore_Category_2_Low <= dsCfg[1].ReadmissionScore_Category_1_High OR 
		dsCfg[1].ReadmissionScore_Category_3_Low <= dsCfg[1].ReadmissionScore_Category_2_High OR
		dsCfg[1].ReadmissionScore_Category_4_Low <= dsCfg[1].ReadmissionScore_Category_3_High OR
		dsCfg[1].ReadmissionScore_Category_5_Low <= dsCfg[1].ReadmissionScore_Category_4_High,
		FAIL('Overlapping ReadmissionScore_Category thresholds supplied.'));
	// Checking the MedicationAdherenceScore_Category thresholds for overlaps 
	IF(dsCfg[1].MedicationAdherenceScore_Category_4_Low <= dsCfg[1].MedicationAdherenceScore_Category_5_High OR 
		dsCfg[1].MedicationAdherenceScore_Category_3_Low <= dsCfg[1].MedicationAdherenceScore_Category_4_High OR
		dsCfg[1].MedicationAdherenceScore_Category_2_Low <= dsCfg[1].MedicationAdherenceScore_Category_3_High OR
		dsCfg[1].MedicationAdherenceScore_Category_1_Low <= dsCfg[1].MedicationAdherenceScore_Category_2_High,
		FAIL('Overlapping MedicationAdherenceScore_Category thresholds supplied.'));
	// Checking the MotivationScore_Category thresholds for overlaps 
	IF(dsCfg[1].MotivationScore_Category_4_Low <= dsCfg[1].MotivationScore_Category_5_High OR 
		dsCfg[1].MotivationScore_Category_3_Low <= dsCfg[1].MotivationScore_Category_4_High OR
		dsCfg[1].MotivationScore_Category_2_Low <= dsCfg[1].MotivationScore_Category_3_High OR
		dsCfg[1].MotivationScore_Category_1_Low <= dsCfg[1].MotivationScore_Category_2_High,
		FAIL('Overlapping MotivationScore_Category thresholds supplied.'));
	//This is a very simple check, have a separate algorithm to do a comprehensive check for overlaps and if any records fall off the buckets, that algo can be added at a later date
	IF( dsCfg[1].TotalCostRiskScore_Rank_2_Min  < dsCfg[1].TotalCostRiskScore_Rank_1_Max OR 
		dsCfg[1].TotalCostRiskScore_Rank_3_Min  < dsCfg[1].TotalCostRiskScore_Rank_2_Max   OR 
		dsCfg[1].TotalCostRiskScore_Rank_4_Min  < dsCfg[1].TotalCostRiskScore_Rank_3_Max   OR 
		dsCfg[1].TotalCostRiskScore_Rank_5_Min  < dsCfg[1].TotalCostRiskScore_Rank_4_Max   OR 
		dsCfg[1].TotalCostRiskScore_Rank_6_Min  < dsCfg[1].TotalCostRiskScore_Rank_5_Max   OR 
		dsCfg[1].TotalCostRiskScore_Rank_7_Min  < dsCfg[1].TotalCostRiskScore_Rank_6_Max   OR 
		dsCfg[1].TotalCostRiskScore_Rank_8_Min  < dsCfg[1].TotalCostRiskScore_Rank_7_Max   OR 
		dsCfg[1].TotalCostRiskScore_Rank_9_Min  < dsCfg[1].TotalCostRiskScore_Rank_8_Max   OR 
		dsCfg[1].TotalCostRiskScore_Rank_10_Min < dsCfg[1].TotalCostRiskScore_Rank_9_Max   OR 
		dsCfg[1].TotalCostRiskScore_Rank_11_Min < dsCfg[1].TotalCostRiskScore_Rank_10_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_12_Min < dsCfg[1].TotalCostRiskScore_Rank_11_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_13_Min < dsCfg[1].TotalCostRiskScore_Rank_12_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_14_Min < dsCfg[1].TotalCostRiskScore_Rank_13_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_15_Min < dsCfg[1].TotalCostRiskScore_Rank_14_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_16_Min < dsCfg[1].TotalCostRiskScore_Rank_15_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_17_Min < dsCfg[1].TotalCostRiskScore_Rank_16_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_18_Min < dsCfg[1].TotalCostRiskScore_Rank_17_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_19_Min < dsCfg[1].TotalCostRiskScore_Rank_18_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_20_Min < dsCfg[1].TotalCostRiskScore_Rank_19_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_21_Min < dsCfg[1].TotalCostRiskScore_Rank_20_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_22_Min < dsCfg[1].TotalCostRiskScore_Rank_21_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_23_Min < dsCfg[1].TotalCostRiskScore_Rank_22_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_24_Min < dsCfg[1].TotalCostRiskScore_Rank_23_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_25_Min < dsCfg[1].TotalCostRiskScore_Rank_24_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_26_Min < dsCfg[1].TotalCostRiskScore_Rank_25_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_27_Min < dsCfg[1].TotalCostRiskScore_Rank_26_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_28_Min < dsCfg[1].TotalCostRiskScore_Rank_27_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_29_Min < dsCfg[1].TotalCostRiskScore_Rank_28_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_30_Min < dsCfg[1].TotalCostRiskScore_Rank_29_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_31_Min < dsCfg[1].TotalCostRiskScore_Rank_30_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_32_Min < dsCfg[1].TotalCostRiskScore_Rank_31_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_33_Min < dsCfg[1].TotalCostRiskScore_Rank_32_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_34_Min < dsCfg[1].TotalCostRiskScore_Rank_33_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_35_Min < dsCfg[1].TotalCostRiskScore_Rank_34_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_36_Min < dsCfg[1].TotalCostRiskScore_Rank_35_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_37_Min < dsCfg[1].TotalCostRiskScore_Rank_36_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_38_Min < dsCfg[1].TotalCostRiskScore_Rank_37_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_39_Min < dsCfg[1].TotalCostRiskScore_Rank_38_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_40_Min < dsCfg[1].TotalCostRiskScore_Rank_39_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_41_Min < dsCfg[1].TotalCostRiskScore_Rank_40_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_42_Min < dsCfg[1].TotalCostRiskScore_Rank_41_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_43_Min < dsCfg[1].TotalCostRiskScore_Rank_42_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_44_Min < dsCfg[1].TotalCostRiskScore_Rank_43_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_45_Min < dsCfg[1].TotalCostRiskScore_Rank_44_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_46_Min < dsCfg[1].TotalCostRiskScore_Rank_45_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_47_Min < dsCfg[1].TotalCostRiskScore_Rank_46_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_48_Min < dsCfg[1].TotalCostRiskScore_Rank_47_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_49_Min < dsCfg[1].TotalCostRiskScore_Rank_48_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_50_Min < dsCfg[1].TotalCostRiskScore_Rank_49_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_51_Min < dsCfg[1].TotalCostRiskScore_Rank_50_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_52_Min < dsCfg[1].TotalCostRiskScore_Rank_51_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_53_Min < dsCfg[1].TotalCostRiskScore_Rank_52_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_54_Min < dsCfg[1].TotalCostRiskScore_Rank_53_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_55_Min < dsCfg[1].TotalCostRiskScore_Rank_54_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_56_Min < dsCfg[1].TotalCostRiskScore_Rank_55_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_57_Min < dsCfg[1].TotalCostRiskScore_Rank_56_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_58_Min < dsCfg[1].TotalCostRiskScore_Rank_57_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_59_Min < dsCfg[1].TotalCostRiskScore_Rank_58_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_60_Min < dsCfg[1].TotalCostRiskScore_Rank_59_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_61_Min < dsCfg[1].TotalCostRiskScore_Rank_60_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_62_Min < dsCfg[1].TotalCostRiskScore_Rank_61_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_63_Min < dsCfg[1].TotalCostRiskScore_Rank_62_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_64_Min < dsCfg[1].TotalCostRiskScore_Rank_63_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_65_Min < dsCfg[1].TotalCostRiskScore_Rank_64_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_66_Min < dsCfg[1].TotalCostRiskScore_Rank_65_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_67_Min < dsCfg[1].TotalCostRiskScore_Rank_66_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_68_Min < dsCfg[1].TotalCostRiskScore_Rank_67_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_69_Min < dsCfg[1].TotalCostRiskScore_Rank_68_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_70_Min < dsCfg[1].TotalCostRiskScore_Rank_69_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_71_Min < dsCfg[1].TotalCostRiskScore_Rank_70_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_72_Min < dsCfg[1].TotalCostRiskScore_Rank_71_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_73_Min < dsCfg[1].TotalCostRiskScore_Rank_72_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_74_Min < dsCfg[1].TotalCostRiskScore_Rank_73_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_75_Min < dsCfg[1].TotalCostRiskScore_Rank_74_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_76_Min < dsCfg[1].TotalCostRiskScore_Rank_75_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_77_Min < dsCfg[1].TotalCostRiskScore_Rank_76_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_78_Min < dsCfg[1].TotalCostRiskScore_Rank_77_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_79_Min < dsCfg[1].TotalCostRiskScore_Rank_78_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_80_Min < dsCfg[1].TotalCostRiskScore_Rank_79_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_81_Min < dsCfg[1].TotalCostRiskScore_Rank_80_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_82_Min < dsCfg[1].TotalCostRiskScore_Rank_81_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_83_Min < dsCfg[1].TotalCostRiskScore_Rank_82_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_84_Min < dsCfg[1].TotalCostRiskScore_Rank_83_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_85_Min < dsCfg[1].TotalCostRiskScore_Rank_84_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_86_Min < dsCfg[1].TotalCostRiskScore_Rank_85_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_87_Min < dsCfg[1].TotalCostRiskScore_Rank_86_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_88_Min < dsCfg[1].TotalCostRiskScore_Rank_87_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_89_Min < dsCfg[1].TotalCostRiskScore_Rank_88_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_90_Min < dsCfg[1].TotalCostRiskScore_Rank_89_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_91_Min < dsCfg[1].TotalCostRiskScore_Rank_90_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_92_Min < dsCfg[1].TotalCostRiskScore_Rank_91_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_93_Min < dsCfg[1].TotalCostRiskScore_Rank_92_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_94_Min < dsCfg[1].TotalCostRiskScore_Rank_93_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_95_Min < dsCfg[1].TotalCostRiskScore_Rank_94_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_96_Min < dsCfg[1].TotalCostRiskScore_Rank_95_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_97_Min < dsCfg[1].TotalCostRiskScore_Rank_96_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_98_Min < dsCfg[1].TotalCostRiskScore_Rank_97_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_99_Min < dsCfg[1].TotalCostRiskScore_Rank_98_Max  OR 
		dsCfg[1].TotalCostRiskScore_Rank_100_Min < dsCfg[1].TotalCostRiskScore_Rank_99_Max,
		FAIL('Overlapping TotalCostRiskScore_Rank thresholds supplied.'));
	
	 IF(dsCfg[1].TotalCostRiskScore_Category_2_Low < dsCfg[1].TotalCostRiskScore_Category_1_High OR 
		dsCfg[1].TotalCostRiskScore_Category_3_Low < dsCfg[1].TotalCostRiskScore_Category_2_High OR
		dsCfg[1].TotalCostRiskScore_Category_4_Low < dsCfg[1].TotalCostRiskScore_Category_3_High OR
		dsCfg[1].TotalCostRiskScore_Category_5_Low < dsCfg[1].TotalCostRiskScore_Category_4_High,
		FAIL('Overlapping TotalCostRiskScore_Category thresholds supplied.'));
	// Exception#2 and Exception#3
	Condition_1_2_Minor_Reject_DS := Models.Healthcare_SocioEconomic_Transforms_RT_Service.BuildMinInputErrorsDS(Cleaned_Input);

	//Core option resolution
	Socio_Core_Option := MAP(isAttributesRequested = TRUE AND isReadmissionRequested = TRUE AND isMedicationAdherenceRequested = TRUE AND isMotivationRequested = TRUE AND isTotalCostRiskScoreRequested = TRUE => '7MO',
							isAttributesRequested = TRUE AND isReadmissionRequested = TRUE AND isMedicationAdherenceRequested = TRUE AND isMotivationRequested = TRUE => '5MO',
							isAttributesRequested = TRUE AND isReadmissionRequested = TRUE AND isMedicationAdherenceRequested = TRUE AND isTotalCostRiskScoreRequested = TRUE => '7M',
							isAttributesRequested = TRUE AND isReadmissionRequested = TRUE AND isMotivationRequested = TRUE AND isTotalCostRiskScoreRequested = TRUE => '7O',
							isAttributesRequested = TRUE AND isMedicationAdherenceRequested = TRUE AND isMotivationRequested = TRUE AND isTotalCostRiskScoreRequested = TRUE => '6MO',
							isReadmissionRequested = TRUE AND isMedicationAdherenceRequested = TRUE AND isMotivationRequested = TRUE AND isTotalCostRiskScoreRequested = TRUE => '4MO',
							isAttributesRequested = TRUE AND isReadmissionRequested = TRUE AND isMedicationAdherenceRequested = TRUE => '5M',
							isAttributesRequested = TRUE AND isReadmissionRequested = TRUE AND isMotivationRequested = TRUE => '5O',
							isAttributesRequested = TRUE AND isReadmissionRequested = TRUE AND isTotalCostRiskScoreRequested = TRUE => '7',
							isAttributesRequested = TRUE AND isMedicationAdherenceRequested = TRUE AND isMotivationRequested = TRUE => '1MO',
							isAttributesRequested = TRUE AND isMedicationAdherenceRequested = TRUE AND isTotalCostRiskScoreRequested = TRUE => '6M',
							isAttributesRequested = TRUE AND isMotivationRequested = TRUE AND isTotalCostRiskScoreRequested = TRUE => '6O',
							isReadmissionRequested = TRUE AND isMedicationAdherenceRequested = TRUE AND isMotivationRequested = TRUE => '2MO',
							isReadmissionRequested = TRUE AND isMedicationAdherenceRequested = TRUE AND isTotalCostRiskScoreRequested = TRUE => '4M',
							isReadmissionRequested = TRUE AND isMotivationRequested = TRUE AND isTotalCostRiskScoreRequested = TRUE => '4O',
							isMedicationAdherenceRequested = TRUE AND isMotivationRequested = TRUE AND isTotalCostRiskScoreRequested = TRUE => '3MO',
							isAttributesRequested = TRUE AND isReadmissionRequested = TRUE => '5',
							isAttributesRequested = TRUE AND isMedicationAdherenceRequested = TRUE => '1M',
							isAttributesRequested = TRUE AND isMotivationRequested = TRUE => '1O',
							isAttributesRequested = TRUE AND isTotalCostRiskScoreRequested = TRUE => '6',
							isReadmissionRequested = TRUE AND isMedicationAdherenceRequested = TRUE => '2M',
							isReadmissionRequested = TRUE AND isMotivationRequested = TRUE => '2O',
							isReadmissionRequested = TRUE AND isTotalCostRiskScoreRequested = TRUE => '4',
							isMedicationAdherenceRequested = TRUE AND isMotivationRequested = TRUE => 'MO',
							isMedicationAdherenceRequested = TRUE AND isTotalCostRiskScoreRequested = TRUE => '3M',
							isMotivationRequested = TRUE AND isTotalCostRiskScoreRequested = TRUE => '3O',
							isAttributesRequested = TRUE => '1',
							isReadmissionRequested = TRUE => '2',
							isMedicationAdherenceRequested = TRUE => 'M',
							isMotivationRequested = TRUE => 'O',
							isTotalCostRiskScoreRequested = TRUE => '3',
							'1');
	// OUTPUT(Socio_Core_Option, NAMED('Socio_Core_Option'));

	//Input prep for Socio Core and GLB/DPPA validation
	batch_in := PROJECT(Cleaned_Input, TRANSFORM(Models.Layouts_Healthcare_Core.Layout_SocioEconomic_Batch_In,
										SELF.SSN := LEFT.SSN_Cln;
										SELF.DOB := LEFT.DOB_Cln;
										SELF.ST := LEFT.ST_Cln;
										SELF.Z5 := LEFT.Z5_Cln;
										SELF.Home_Phone := LEFT.Home_Phone_Cln;
										SELF.Work_Phone := LEFT.Work_Phone_Cln;
										SELF.ADMIT_DATE := LEFT.ADMIT_DATE_CLN;
										SELF.MemberGender := LEFT.MemberGender_Cln;			
										SELF := LEFT));
	// OUTPUT(batch_in, NAMED('batch_in'));

	// Process GLB and DPPA for exceptions

	DPPAPurpose_user := trim(first_row.user.DLPurpose, LEFT, RIGHT);
	GLBPurpose_user := trim(first_row.user.GLBPurpose, LEFT, RIGHT);
	DPPAPurpose_in := (UNSIGNED) DPPAPurpose_user;
	GLBPurpose_in := (UNSIGNED) GLBPurpose_user; //Values of '','-','0' etc will be casted to 0.
	DPPAPurpose_usage_string := (string) TRIM(acct_configRaw.Common.Usage.DPPA, LEFT, RIGHT); //Getting the usage from the account context
	GLBPurpose_usage_string := (string) TRIM(acct_configRaw.Common.Usage.GLB, LEFT, RIGHT);

	// Exception#4 Exception#5 Exception#6
	GLB_DPPA_Exceptions_DS := Models.Healthcare_SocioEconomic_Transforms_RT_Service.BuildPermissiblePurposeErrorsDS(GLBPurpose_in, GLBPurpose_usage_string, DPPAPurpose_in);
	// Pre Core Call Exception Dataset
	PreCoreException_DS := SubscriptionFail_DS + Condition_1_2_Minor_Reject_DS + GLB_DPPA_Exceptions_DS;
	ExceptionsInInputRequest := IF(COUNT(PreCoreException_DS(code<>0)) > 0, TRUE, FALSE);

	Boolean NothingIsRequested := IF(isAttributesRequested = FALSE AND isReadmissionRequested = FALSE AND isMedicationAdherenceRequested = FALSE AND isMotivationRequested = FALSE AND isTotalCostRiskScoreRequested = FALSE, TRUE, FALSE);
	isCoreRequestValid := IF(NothingIsRequested = FALSE AND ExceptionsInInputRequest = FALSE, TRUE, FALSE);

	DataRestrictionMask_in := (string) TRIM(first_row.user.DataRestrictionMask, LEFT, RIGHT);
	DataPermissionMask_in := (string) TRIM(first_row.user.DataPermissionMask, LEFT, RIGHT);
	IF(DataRestrictionMask_in=_blank, FAIL('A blank DataRestrictionMask value is supplied.'));
	IF(DataPermissionMask_in=_blank, FAIL('A blank DataPermissionMask value is supplied.'));
	// Calling Socio core
	//Passing additional parameters to the core, set them to defaults unless otherwise directed. Set ofac_version_in, gateways_in_ds
	unsigned1 ofac_version_in := 1; //Set to default
	gateways_in_ds := dataset([], Gateway.Layouts.Config); //Set to default
	Socio_TC_Model_Version_in := Models.Healthcare_Constants_RT_Service.default_Socio_TC_Model_Version;
	LexIdSourceOptout := dsCfg[1].LexIdSourceOptout;
	Models.Healthcare_SocioEconomic_Core(Socio_TC_Model_Version_in, dsCfg[1].SuppressResultsForOptOuts, isCoreRequestValid, batch_in, DPPAPurpose_in, GLBPurpose_in, DataRestrictionMask_in, DataPermissionMask_in, Socio_Core_Option, ofac_version_in, gateways_in_ds, coreResults,
                                                                              LexIdSourceOptout := LexIdSourceOptout, 
                                                                              TransactionID := TransactionID, 
                                                                              BatchUID := BatchUID, 
                                                                              GlobalCompanyID := GlobalCompanyID);
	// Models.Healthcare_SocioEconomic_Core(isCoreRequestValid, batch_in, DPPAPurpose_in, GLBPurpose_in, DataRestrictionMask_in, DataPermissionMask_in, Socio_Core_Option, coreResults);
  	// OUTPUT(coreResults, NAMED('coreResults'));

  	EmptyCoreResults0 := dataset([], Models.Layouts_Healthcare_Core.Final_Output_Layout_W_OptOutFlag);
  	CoreResultsForAttributes := IF(isAttributesRequested AND isAttributesRequestValid, coreResults,  EmptyCoreResults0);

  	// Populating Attributes
	SocioIncicators_Attributes :=  project(CoreResultsForAttributes, Models.Healthcare_SocioEconomic_Transforms_RT_Service.BuildSocioIndicators(left, dsCfg));
	// OUTPUT(SocioIncicators_Attributes, NAMED('SocioIncicators_Attributes'));

	// Exception#7
	ADLScoreFailRow := IF(isCoreRequestValid AND (unsigned) coreResults[1].ADLScore < (unsigned)Models.Healthcare_Constants_RT_Service.default_adl_score_filter_val, ROW({_blank, Models.Healthcare_Constants_RT_Service.ADLScoreFail_Code, _blank, Models.Healthcare_Constants_RT_Service.ADLScoreFail_Message }, iesp.share.t_WsException), _EmptyExceptionDSRow0);
	ADLScoreFail_DS := EmptyExceptionDS0 + ADLScoreFailRow;

	FinalException_DS := PreCoreException_DS + ADLScoreFail_DS;

	SocioScoresDS := Models.Healthcare_SocioEconomic_Transforms_RT_Service.PopulateScoresDS(coreResults, dsCfg, isReadmissionRequested, isMedicationAdherenceRequested, isMotivationRequested, isTotalCostRiskScoreRequested);
	SocioScoresChildDS := choosen(SocioScoresDS,iesp.Constants.Socio.Max_Scores);
	// OUTPUT(SocioScoresChildDS, NAMED('SocioScoresChildDS'));

	iesp.healthcare_socio_indicators.t_SocioIndicators format_attributes_scores() := transform
		SELF.Scores := SocioScoresChildDS;
		SELF.HealthAttributesV3 := SocioIncicators_Attributes[1].HealthAttributesV3;
	end;
	SocioIncicators_Attributes_Scores := dataset([format_attributes_scores()]);
	// OUTPUT(SocioIncicators_Attributes_Scores, NAMED('SocioIncicators_Attributes_Scores'));
	
	//Transform core results based on the config, return attribute groups and also add scores and categories based on the config
	Admit_date := Cleaned_Input[1].Admit_date_cln;	
	Empty_SocioInvalidsDS := dataset([], iesp.healthcare_socio_indicators.t_SocioInvalidField);
	SocioInvalidsDS := Models.Healthcare_SocioEconomic_Transforms_RT_Service.PopulateInvalidsDS(coreResults, Admit_date, isReadmissionRequested, isTotalCostRiskScoreRequested);
	// OUTPUT(SocioInvalidsDS, NAMED('SocioInvalidsDS'));

	Empty_SocioIncicators_Attributes_Scores := dataset([],iesp.healthcare_socio_indicators.t_SocioIndicators);
	hasExceptions := IF(COUNT(FinalException_DS(code<>0)) > 0, TRUE, FALSE);

	isLexIdInOptOut := (Boolean)CoreResults[1].isLexIdInOptOut;
	EmptyDisclaimersDS :=  dataset([], iesp.share.t_ResultDisclaimer);
	_EmptyDisclaimerRow := ROW({_blank, _blank}, iesp.share.t_ResultDisclaimer);
	DisclaimersRow := IF(isLexIdInOptOut, ROW({Models.Healthcare_Constants_RT_Service.optout_code, Models.Healthcare_Constants_RT_Service.optout_message}, iesp.share.t_ResultDisclaimer), _EmptyDisclaimerRow);
	DisclaimersDS := EmptyDisclaimersDS + DisclaimersRow;
	//Add additional info into the response
	iesp.healthcare_socio_indicators.t_SocioeconomicIndicatorsResponse format() := transform
				self.Options := RequestOptions;
				self.Member := MemberInfo;
				self.Indicators := IF(hasExceptions OR (isLexIdInOptOut AND dsCfg[1].SuppressResultsForOptOuts), Empty_SocioIncicators_Attributes_Scores[1], SocioIncicators_Attributes_Scores[1]);
				self.InvalidFields := IF((isLexIdInOptOut AND dsCfg[1].SuppressResultsForOptOuts), Empty_SocioInvalidsDS, choosen(SocioInvalidsDS,iesp.Constants.Socio.Max_Invalids));
				self._Header.TransactionId := first_row.AccountContext.Common.TransactionID;
				self._Header.Status := if(hasExceptions, Models.Healthcare_Constants_RT_Service.InvalidInput_Code, 0);
				self._Header.Message := if(hasExceptions, Models.Healthcare_Constants_RT_Service.InvalidInput_Message, _blank);
				self._Header.Exceptions := if(hasExceptions,
																FinalException_DS(code<>0),
																dataset([],iesp.share.t_WsException));
				self._Header.QueryId := first_row.user.QueryId;
				self._Header.Disclaimers := DisclaimersDS(code<>_blank);
				self:=[];
	end;
	results := dataset([format()]);

	// LOGGING
	// Populate the input fields
	 myloggingdata0 := PROJECT(ds_in, Models.Healthcare_SocioEconomic_Transforms_RT_Service.SocioTransactionLog(LEFT, isAttributesRequested, isReadmissionRequested, isMedicationAdherenceRequested, isMotivationRequested, isTotalCostRiskScoreRequested,
	 																												  isAttributesSubscribed, isReadmissionSubscribed, isMedicationAdherenceSubscribed, isMotivationSubscribed, isTotalCostRiskScoreSubscribed ));
	// Populate all non input fields
	Models.Layouts_Healthcare_RT_Service.transactionlog setNonInput(Models.Layouts_Healthcare_RT_Service.transactionlog L):=transform
			self.product_id := (UNSIGNED) Models.Healthcare_Constants_RT_Service.Socio_product_id; 
			self.sub_product_id := (UNSIGNED) Models.Healthcare_Constants_RT_Service.Socio_sub_product_id;
			self.report_options := if(hasExceptions, _blank, L.report_options);
			self.record_count := if(hasExceptions, 0, 1);
			self.error_code	:= if(hasExceptions, (string) Models.Healthcare_Constants_RT_Service.InvalidInput_Code, _blank);
			self.error_detail := if(hasExceptions, Models.Healthcare_Constants_RT_Service.InvalidInput_Message, _blank);
			self:=L;
	end;
	myloggingdata	:= PROJECT(myloggingdata0, setNonInput(LEFT));	 
	// Wraps Logging into Records.Rec since that's the format ESP expects	
	myloggingdataWrap := PROJECT(myloggingdata, TRANSFORM(Models.Layouts_Healthcare_RT_Service.transactionLogWrap, SELF.Rec := LEFT));
	loggingResult := PROJECT(myloggingdataWrap, TRANSFORM(Models.Layouts_Healthcare_RT_Service.transactionLogWrapWrap, SELF.Records := LEFT));

	OUTPUT(Results, NAMED('Results'));
	OUTPUT(loggingResult, NAMED('LOG_log__hcar_transaction__log'));
	
ENDMACRO;