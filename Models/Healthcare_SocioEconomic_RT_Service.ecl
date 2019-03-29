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
	cfg_Config := acct_configRaw.Configs(STD.STR.ToUpperCase(Name)='GLOBAL.CONFIG')[1];//Need to filter as there may be multiple for different products
	cfg_Name := cfg_Config.Name;
	cfg_Type := cfg_Config._Type;
	cfg_ProductKey := cfg_Config.ProductKey;
	cfg_DS_SectionName := cfg_Config.Sections(STD.STR.ToUpperCase(Name)='HC_SOCIO_MAIN')[1];//Need to filter on this
	cfg_DS_Sections := cfg_DS_SectionName.KeyValues;

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

	BOOLEAN isAttributesSubscribed := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SubscribedToHealthAttributesV3);
	BOOLEAN isReadmissionSubscribed := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SubscribedToReadmissionScore);
	BOOLEAN isMedicationAdherenceSubscribed := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SubscribedToMedicationAdherenceScore);
	BOOLEAN isMotivationSubscribed := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SubscribedToMotivationScore);

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

	AttributesFailMessage := IF(isAttributesRequestValid,_blank, Models.Healthcare_Constants_RT_Service.AttributesSubFailMessage);
	ReadmissionFailMessage := IF(isReadmissionRequestValid,_blank, Models.Healthcare_Constants_RT_Service.ReadmissionSubFailMessage);
	MedicationAdherenceFailMessage := IF(isMedicationAdherenceRequestValid,_blank, Models.Healthcare_Constants_RT_Service.MedicationAdherenceSubFailMessage);
	MotivationFailMessage := IF(isMotivationRequestValid,_blank, Models.Healthcare_Constants_RT_Service.MotivationSubFailMessage);
	RequestFailedMessage := Models.Healthcare_Constants_RT_Service.SubInvalidRequest + AttributesFailMessage + ReadmissionFailMessage + MedicationAdherenceFailMessage + MotivationFailMessage;
	
	//Exception#1
	SubscriptionFail_DS := EmptyExceptionDS0 + IF(isAttributesRequestValid = FALSE OR isReadmissionRequestValid = FALSE OR isMedicationAdherenceRequestValid = FALSE OR isMotivationRequestValid = FALSE, ROW({_blank, Models.Healthcare_Constants_RT_Service.InvalidInput_Code, _blank, RequestFailedMessage}, iesp.share.t_WsException), _EmptyExceptionDSRow0);

	Models.Layouts_Healthcare_RT_Service.common_runtime_config getCfg() := transform
			custID := if(first_row.user.CompanyId <> _blank and first_row.user.CompanyId <> first_row.AccountContext.Common.GlobalCompanyId,first_row.user.CompanyId,first_row.AccountContext.Common.GlobalCompanyId);
			self.ReferenceNumber := acct_configRaw.Common.ReferenceNumber;
			self.TransactionId := acct_configRaw.Common.TransactionId;

			self.SubscribedToHealthAttributesV3 := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SubscribedToHealthAttributesV3);
			self.SubscribedToReadmissionScore := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SubscribedToReadmissionScore);
			self.SubscribedToMedicationAdherenceScore := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SubscribedToMedicationAdherenceScore);
			self.SubscribedToMotivationScore := Models.Healthcare_SocioEconomic_Functions_RT_Service.getBooleanFlagValueForKeyFromIESP(cfg_DS_Sections, Models.Healthcare_Constants_RT_Service.CFG_MBS_SubscribedToMotivationScore);

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

	// Exception#2 and Exception#3
	Condition_1_2_Minor_Reject_DS := Models.Healthcare_SocioEconomic_Transforms_RT_Service.BuildMinInputErrorsDS(Cleaned_Input);

	//Core option resolution
	Socio_Core_Option := MAP(isAttributesRequested = TRUE AND isReadmissionRequested = TRUE AND isMedicationAdherenceRequested = TRUE AND isMotivationRequested = TRUE => '5MO',
							isAttributesRequested = TRUE AND isMedicationAdherenceRequested = TRUE AND isMotivationRequested = TRUE => '1MO',
							isReadmissionRequested = TRUE AND isMedicationAdherenceRequested = TRUE AND isMotivationRequested = TRUE => '2MO',
							isAttributesRequested = TRUE AND isReadmissionRequested = TRUE AND isMotivationRequested = TRUE => '5O',
							isAttributesRequested = TRUE AND isMotivationRequested = TRUE => '1O',
							isReadmissionRequested = TRUE AND isMotivationRequested = TRUE => '2O',
							isMedicationAdherenceRequested = TRUE AND isMotivationRequested = TRUE => 'MO',
							isAttributesRequested = TRUE AND isReadmissionRequested = TRUE AND isMedicationAdherenceRequested = TRUE => '5M',
							isAttributesRequested = TRUE AND isMedicationAdherenceRequested = TRUE => '1M',
							isReadmissionRequested = TRUE AND isMedicationAdherenceRequested = TRUE => '2M',
							isAttributesRequested = TRUE AND isReadmissionRequested = TRUE => '5',
							isAttributesRequested = TRUE => '1',
							isReadmissionRequested = TRUE => '2',
							isMedicationAdherenceRequested = TRUE => 'M',
							isMotivationRequested = TRUE => 'O',
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

	Boolean NothingIsRequested := IF(isAttributesRequested = FALSE AND isReadmissionRequested = FALSE AND isMedicationAdherenceRequested = FALSE AND isMotivationRequested = FALSE, TRUE, FALSE);
	isCoreRequestValid := IF(NothingIsRequested = FALSE AND ExceptionsInInputRequest = FALSE, TRUE, FALSE);

	DataRestrictionMask_in := (string) TRIM(first_row.user.DataRestrictionMask, LEFT, RIGHT);
	DataPermissionMask_in := (string) TRIM(first_row.user.DataPermissionMask, LEFT, RIGHT);
	IF(DataRestrictionMask_in=_blank, FAIL('A blank DataRestrictionMask value is supplied.'));
	IF(DataPermissionMask_in=_blank, FAIL('A blank DataPermissionMask value is supplied.'));
	// Calling Socio core
	//Passing additional parameters to the core, set them to defaults unless otherwise directed. Set ofac_version_in, gateways_in_ds
	unsigned1 ofac_version_in := 1; //Set to default
	gateways_in_ds := dataset([], Gateway.Layouts.Config); //Set to default
	
	Models.Healthcare_SocioEconomic_Core(isCoreRequestValid, batch_in, DPPAPurpose_in, GLBPurpose_in, DataRestrictionMask_in, DataPermissionMask_in, Socio_Core_Option, ofac_version_in, gateways_in_ds, coreResults);
	// Models.Healthcare_SocioEconomic_Core(isCoreRequestValid, batch_in, DPPAPurpose_in, GLBPurpose_in, DataRestrictionMask_in, DataPermissionMask_in, Socio_Core_Option, coreResults);
  	// OUTPUT(coreResults, NAMED('coreResults'));

  	EmptyCoreResults0 := dataset([], Models.Layouts_Healthcare_Core.Final_Output_Layout);
  	CoreResultsForAttributes := IF(isAttributesRequested AND isAttributesRequestValid, coreResults,  EmptyCoreResults0);

  	// Populating Attributes
	SocioIncicators_Attributes :=  project(CoreResultsForAttributes, Models.Healthcare_SocioEconomic_Transforms_RT_Service.BuildSocioIndicators(left, dsCfg));
	// OUTPUT(SocioIncicators_Attributes, NAMED('SocioIncicators_Attributes'));

	// Exception#7
	ADLScoreFailRow := IF(isCoreRequestValid AND (unsigned) coreResults[1].ADLScore < (unsigned)Models.Healthcare_Constants_RT_Service.default_adl_score_filter_val, ROW({_blank, Models.Healthcare_Constants_RT_Service.ADLScoreFail_Code, _blank, Models.Healthcare_Constants_RT_Service.ADLScoreFail_Message }, iesp.share.t_WsException), _EmptyExceptionDSRow0);
	ADLScoreFail_DS := EmptyExceptionDS0 + ADLScoreFailRow;

	FinalException_DS := PreCoreException_DS + ADLScoreFail_DS;

	SocioScoresDS := Models.Healthcare_SocioEconomic_Transforms_RT_Service.PopulateScoresDS(coreResults, dsCfg, isReadmissionRequested, isMedicationAdherenceRequested, isMotivationRequested);
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
	SocioInvalidsDS := Models.Healthcare_SocioEconomic_Transforms_RT_Service.PopulateInvalidsDS(coreResults, Admit_date, isReadmissionRequested);
	// OUTPUT(SocioInvalidsDS, NAMED('SocioInvalidsDS'));

	Empty_SocioIncicators_Attributes_Scores := dataset([],iesp.healthcare_socio_indicators.t_SocioIndicators);
	hasExceptions := IF(COUNT(FinalException_DS(code<>0)) > 0, TRUE, FALSE);

	//Add additional info into the response
	iesp.healthcare_socio_indicators.t_SocioeconomicIndicatorsResponse format() := transform
				self.Options := RequestOptions;
				self.Member := MemberInfo;
				self.Indicators := IF(hasExceptions, Empty_SocioIncicators_Attributes_Scores[1], SocioIncicators_Attributes_Scores[1]);
				self.InvalidFields := choosen(SocioInvalidsDS,iesp.Constants.Socio.Max_Invalids);
				self._Header.TransactionId := first_row.AccountContext.Common.TransactionID;
				self._Header.Status := if(hasExceptions, Models.Healthcare_Constants_RT_Service.InvalidInput_Code, 0);
				self._Header.Message := if(hasExceptions, Models.Healthcare_Constants_RT_Service.InvalidInput_Message, _blank);
				self._Header.Exceptions := if(hasExceptions,
																FinalException_DS(code<>0),
																dataset([],iesp.share.t_WsException));
				self._Header.QueryId := first_row.user.QueryId;
				self:=[];
	end;
	results := dataset([format()]);
																						
	// LOGGING
	// Populate the input fields
	 myloggingdata0 := PROJECT(ds_in, Models.Healthcare_SocioEconomic_Transforms_RT_Service.SocioTransactionLog(LEFT, isAttributesRequested, isReadmissionRequested, isMedicationAdherenceRequested, isMotivationRequested));
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