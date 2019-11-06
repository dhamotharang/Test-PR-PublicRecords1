﻿﻿Import Models, STD, Address, risk_indicators, riskwise, ut;
Import Models.Healthcare_SocioEconomic_Functions_Core;
Import Models.Healthcare_SocioEconomic_Ref_Data;
Import Models.Healthcare_Constants_RT_Service;
Import iesp;

EXPORT Healthcare_SocioEconomic_Transforms_RT_Service := MODULE
	
	EXPORT _blank := '';

	EXPORT	Models.Layouts_Healthcare_RT_Service.Layout_SocioEconomic_Data_In Trim_Input(Models.Layouts_Healthcare_RT_Service.Layout_SocioEconomic_Data_In le) := TRANSFORM
		SELF.AcctNo := TRIM(le.AcctNo,left,right);
		SELF.SSN_in := TRIM(le.SSN_in,left,right);
		SELF.unParsedFullName := TRIM(le.unParsedFullName,left,right);
		SELF.Name_First := TRIM(le.Name_First,left,right);
		SELF.Name_Middle := TRIM(le.Name_Middle,left,right);
		SELF.Name_Last := TRIM(le.Name_Last,left,right);
		SELF.Name_Suffix := TRIM(le.Name_Suffix,left,right);
		SELF.DOB_in := TRIM(le.DOB_in,left,right);
		SELF.street_addr := TRIM(le.street_addr,left,right);
		SELF.p_City_name := TRIM(le.p_City_name,left,right);
		SELF.St_in := TRIM(le.St_in,left,right);
		SELF.ZIP_in := TRIM(le.ZIP_in,left,right);
		SELF.DL_Number := TRIM(le.DL_Number,left,right);
		SELF.DL_State := TRIM(le.DL_State,left,right);
		SELF.Home_Phone_in := TRIM(le.Home_Phone_in,left,right);
		SELF.Work_Phone_in := TRIM(le.Work_Phone_in,left,right);
		SELF.MemberGENDer_in := TRIM(le.MemberGENDer_in,left,right);
		// SELF.DID := TRIM(le.DID,left,right);
		SELF.ADMIT_DATE_in := TRIM(le.ADMIT_DATE_in,left,right);
		SELF.ADMIT_DIAGNOSIS_CODE := TRIM(le.ADMIT_DIAGNOSIS_CODE,left,right);
		SELF.FINANCIAL_CLASS := TRIM(le.FINANCIAL_CLASS,left,right);
		SELF.PATIENT_TYPE := TRIM(le.PATIENT_TYPE,left,right);
		SELF.LOB := TRIM(le.LOB,left,right);
		// SELF.HistorydateYYYYMM := TRIM(le.HistorydateYYYYMM,left,right);
		SELF := le;
	END;
    // add sequence to matchup later to add acctno to output
    Export Models.Layouts_Healthcare_RT_Service.Layout_SocioEconomic_Data_Cln AddSeq_and_Clean(Models.Layouts_Healthcare_RT_Service.Layout_SocioEconomic_Data_In le, integer C) := TRANSFORM
		self.acctno := map((integer)le.seq<>0 => (string)le.seq,
		                                        (integer)le.acctno<>0 => (string)le.acctno,
		                                        (string)c);
		self.seq := map((integer)le.seq<>0 => (integer)le.seq,
		                      (integer)le.acctno<>0 => (integer)le.acctno,
		                      C);													
		unsigned3 useHistorydateYYYYMM := if(le.HistorydateYYYYMM = 0, 999999, le.HistorydateYYYYMM);                                    
		self.HistorydateYYYYMM := useHistorydateYYYYMM;
		ageRefYYYYMMDD := if((string)useHistorydateYYYYMM = '999999', (string)Std.Date.Today(), (string)le.HistorydateYYYYMM+(string2)Models.Healthcare_SocioEconomic_Functions_Core.calcDaysInMonth((string)le.HistorydateYYYYMM));
		self.Age := IF(le.DOB_in<>_blank,Models.Healthcare_SocioEconomic_Functions_Core.calcAgeInYears(le.DOB_in,(string)ageRefYYYYMMDD),0);
		self.SSN_Cln := Models.Healthcare_SocioEconomic_Functions_RT_Service.SSNCleaner(le.SSN_in);
		self.DOB_Cln := Models.Healthcare_SocioEconomic_Functions_RT_Service.DOBCleaner(le.DOB_in);
		self.ST_Cln := Models.Healthcare_SocioEconomic_Functions_RT_Service.StateCleaner(le.St_in);
		self.Z5_Cln := Models.Healthcare_SocioEconomic_Functions_RT_Service.ZIPCleaner(le.ZIP_in);
		self.Home_Phone_Cln := Models.Healthcare_SocioEconomic_Functions_RT_Service.PhoneCleaner(le.Home_Phone_in);
		self.Work_Phone_Cln := Models.Healthcare_SocioEconomic_Functions_RT_Service.PhoneCleaner(le.Work_Phone_in);
		self.ADMIT_DATE_Cln := Models.Healthcare_SocioEconomic_Functions_RT_Service.DOBCleaner(le.ADMIT_DATE_in);
		self.MemberGENDer_Cln := Models.Healthcare_SocioEconomic_Functions_RT_Service.GenderCleaner(le.MemberGENDer_in);
		self.Name_First := Models.Healthcare_SocioEconomic_Functions_RT_Service.FirstAndLastNameValidator(le.Name_First);
		self.Name_Last := Models.Healthcare_SocioEconomic_Functions_RT_Service.FirstAndLastNameValidator(le.Name_Last);
		self := le;
	END;

	//Modeled after HC Profile Search
	EXPORT Models.Layouts_Healthcare_RT_Service.transactionLog SocioTransactionLog(iesp.healthcare_socio_indicators.t_SocioeconomicIndicatorsRequest L, Boolean isAttributesRequested, Boolean isReadmissionRequested, Boolean isMedicationAdherenceRequested, Boolean isMotivationRequested, Boolean isTotalCostRiskScoreRequested, 
																				 	Boolean isAttributesSubscribed, Boolean isReadmissionSubscribed, Boolean isMedicationAdherenceSubscribed, Boolean isMotivationSubscribed, Boolean isTotalCostRiskScoreSubscribed ) := TRANSFORM
		SELF.transaction_id	:= L.AccountContext.Common.TransactionID;
		SELF.billing_code	:= L.User.BillingCode;
		SELF.gc_id	:= (integer) L.AccountContext.Common.GlobalCompanyId;
 		SELF.billing_id	 := (integer)L.User.BillingId;
  		SELF.customer_reference_code := L.User.ReferenceCode; 			
		SELF.i_bus_addr	:=	L.Member.MemberID; //Since MemberID could be 50 characters, logging it in an unused field that is long enough.
		SELF.i_person_name_prefix	:= L.Member.Name.Prefix;
		SELF.i_person_last_name	:= L.Member.Name.Last;
		SELF.i_person_first_name := L.Member.Name.First;
		SELF.i_person_middle_name	:= L.Member.Name.Middle;
		SELF.i_person_name_suffix	:= L.Member.Name.Suffix;
		SELF.i_person_dob	:= iesp.ECL2ESP.DateToString(L.Member.DOB);
		SELF.i_person_ssn	:= L.Member.SSN;
		SELF.i_person_phone	:= L.Member.HomePhone;
		SELF.i_person_addr := L.Member.Address.StreetAddress1;
		SELF.i_person_city := L.Member.Address.City;
		SELF.i_person_state	:= L.Member.Address.State;
		SELF.i_person_zip	:= L.Member.Address.Zip5 + If(L.Member.Address.Zip4=_blank,_blank,'-') + L.Member.Address.Zip4;
		SELF.i_person_country	:= _blank;
 		report_options_bit_1 := IF(isAttributesRequested, '1', '0');
 		report_options_bit_2 := IF(isReadmissionRequested, '1', '0');
 		report_options_bit_3 := IF(isMedicationAdherenceRequested, '1', '0');
 		report_options_bit_4 := IF(isMotivationRequested, '1', '0');
 		report_options_bit_5 := IF(isTotalCostRiskScoreRequested, '1', '0');
		SELF.report_options	:= report_options_bit_1 + report_options_bit_2 + report_options_bit_3 + report_options_bit_4 + report_options_bit_5;
		SELF.login_history_id	:= (integer)L.User.LoginHistoryId;
    	SELF.ip_address	:= L.User.IP;
    	SELF.end_user_name := L.User.EndUser.CompanyName;
    	SELF.end_user_address_1 := L.User.EndUser.StreetAddress1;
    	SELF.end_user_city := L.User.EndUser.City;
    	SELF.end_user_state := L.User.EndUser.State;
    	SELF.end_user_zip := L.User.EndUser.Zip5;
    	SELF.end_user_phone := L.User.EndUser.Phone;
		subscription_options_bit_1 := IF(isAttributesSubscribed, '1', '0');
 		subscription_options_bit_2 := IF(isReadmissionSubscribed, '1', '0');
 		subscription_options_bit_3 := IF(isMedicationAdherenceSubscribed, '1', '0');
 		subscription_options_bit_4 := IF(isMotivationSubscribed, '1', '0');
 		subscription_options_bit_5 := IF(isTotalCostRiskScoreSubscribed, '1', '0');
		SELF.i_provider_id := subscription_options_bit_1 + subscription_options_bit_2 + subscription_options_bit_3 + subscription_options_bit_4 + subscription_options_bit_5; // Reusing the i_provider_id field to log subscription options to the database.
		SELF := [];	
	END; // Transaction Log TRANSFORM

	//Since we just have one score now, simple transform is sufficient or else we need to denormalize socres DS
	Export iesp.healthcare_socio_indicators.t_SocioIndicators BuildSocioIndicators(Models.Layouts_Healthcare_Core.Final_Output_Layout_W_OptOutFlag le, dataset(Models.Layouts_Healthcare_RT_Service.common_runtime_config) Config) := TRANSFORM
		SELF.HealthAttributesV3.Accident.AccidentAge := IF(Config[1].SuppressAccident = false, (string)le.AccidentAge , _blank);
		SELF.HealthAttributesV3.Accident.AccidentCount := IF(Config[1].SuppressAccident = false, (string) le.AccidentCount , _blank); 
		SELF.HealthAttributesV3.AddressStability.AddrChangeCount01 := IF(Config[1].SuppressAddressStability = false, (string)le.AddrChangeCount01 , _blank);
		SELF.HealthAttributesV3.AddressStability.AddrChangeCount03 := IF(Config[1].SuppressAddressStability = false, le.AddrChangeCount03 , _blank);
		SELF.HealthAttributesV3.AddressStability.AddrChangeCount06 := IF(Config[1].SuppressAddressStability = false, le.AddrChangeCount06 , _blank);
		SELF.HealthAttributesV3.AddressStability.AddrChangeCount12 := IF(Config[1].SuppressAddressStability = false, le.AddrChangeCount12 , _blank);
		SELF.HealthAttributesV3.AddressStability.AddrChangeCount60 := IF(Config[1].SuppressAddressStability = false, le.AddrChangeCount60 , _blank);
		SELF.HealthAttributesV3.AddressStability.AddrStability := IF(Config[1].SuppressAddressStability = false, le.AddrStability , _blank);
		SELF.HealthAttributesV3.AddressStability.LifeEvEconTrajectory := IF(Config[1].SuppressAddressStability = false, le.LifeEvEconTrajectory , _blank);
		SELF.HealthAttributesV3.AddressStability.LifeEvEconTrajectoryIndex := IF(Config[1].SuppressAddressStability = false, le.LifeEvEconTrajectoryIndex , _blank);
		SELF.HealthAttributesV3.AddressStability.LifeEvEverResidedCnt := IF(Config[1].SuppressAddressStability = false, le.LifeEvEverResidedCnt , _blank);
		SELF.HealthAttributesV3.AddressStability.LifeEvLastMoveTaxRatioDiff := IF(Config[1].SuppressAddressStability = false, le.LifeEvLastMoveTaxRatioDiff , _blank);
		SELF.HealthAttributesV3.AddressStability.StatusMostRecent := IF(Config[1].SuppressAddressStability = false, le.StatusMostRecent , _blank);
		SELF.HealthAttributesV3.AddressStability.StatusPrevious := IF(Config[1].SuppressAddressStability = false, le.StatusPrevious , _blank);
		SELF.HealthAttributesV3.AddressStability.StatusNextPrevious := IF(Config[1].SuppressAddressStability = false, le.StatusNextPrevious , _blank); 
		SELF.HealthAttributesV3.Asset.AircraftCount := IF(Config[1].SuppressAsset = false, le.AircraftCount , _blank);
		SELF.HealthAttributesV3.Asset.AircraftCount12 := IF(Config[1].SuppressAsset = false, le.AircraftCount12 , _blank);
		SELF.HealthAttributesV3.Asset.AircraftCount60 := IF(Config[1].SuppressAsset = false, le.AircraftCount60 , _blank);
		SELF.HealthAttributesV3.Asset.AircraftOwner := IF(Config[1].SuppressAsset = false, le.AircraftOwner , _blank);
		SELF.HealthAttributesV3.Asset.AssetOwner := IF(Config[1].SuppressAsset = false, le.AssetOwner , _blank);
		SELF.HealthAttributesV3.Asset.HHPPCurrOwnedCnt := IF(Config[1].SuppressAsset = false, le.HHPPCurrOwnedCnt , _blank);
		SELF.HealthAttributesV3.Asset.HHPPCurrOwnedWtrcrftCnt := IF(Config[1].SuppressAsset = false, le.HHPPCurrOwnedWtrcrftCnt , _blank);
		SELF.HealthAttributesV3.Asset.HHPropCurrAVMHighest := IF(Config[1].SuppressAsset = false, le.HHPropCurrAVMHighest , _blank);
		SELF.HealthAttributesV3.Asset.HHPropCurrOwnedCnt := IF(Config[1].SuppressAsset = false, le.HHPropCurrOwnedCnt , _blank);
		SELF.HealthAttributesV3.Asset.HHPropCurrOwnerMmbrCnt := IF(Config[1].SuppressAsset = false, le.HHPropCurrOwnerMmbrCnt , _blank);
		SELF.HealthAttributesV3.Asset.LifeEvTimeFirstAssetPurchase := IF(Config[1].SuppressAsset = false, le.LifeEvTimeFirstAssetPurchase , _blank);
		SELF.HealthAttributesV3.Asset.LifeEvTimeLastAssetPurchase := IF(Config[1].SuppressAsset = false, le.LifeEvTimeLastAssetPurchase , _blank);
		SELF.HealthAttributesV3.Asset.PPCurrOwnedCnt := IF(Config[1].SuppressAsset = false, le.PPCurrOwnedCnt , _blank);
		SELF.HealthAttributesV3.Asset.PPCurrOwner := IF(Config[1].SuppressAsset = false, le.PPCurrOwner , _blank);
		SELF.HealthAttributesV3.Asset.PropAgeNewestPurchase := IF(Config[1].SuppressAsset = false, le.PropAgeNewestPurchase , _blank);
		SELF.HealthAttributesV3.Asset.PropAgeNewestSale := IF(Config[1].SuppressAsset = false, le.PropAgeNewestSale , _blank);
		SELF.HealthAttributesV3.Asset.PropAgeOldestPurchase := IF(Config[1].SuppressAsset = false, le.PropAgeOldestPurchase , _blank);
		SELF.HealthAttributesV3.Asset.PropCurrOwnedAVMTtl := IF(Config[1].SuppressAsset = false, le.PropCurrOwnedAVMTtl , _blank);
		SELF.HealthAttributesV3.Asset.PropertyOwner := IF(Config[1].SuppressAsset = false, le.PropertyOwner , _blank);
		SELF.HealthAttributesV3.Asset.PropEverOwnedCnt := IF(Config[1].SuppressAsset = false, le.PropEverOwnedCnt , _blank);
		SELF.HealthAttributesV3.Asset.PropNewestSalePrice := IF(Config[1].SuppressAsset = false, le.PropNewestSalePrice , _blank);
		SELF.HealthAttributesV3.Asset.PropNewestSalePurchaseIndex := IF(Config[1].SuppressAsset = false, le.PropNewestSalePurchaseIndex , _blank);
		SELF.HealthAttributesV3.Asset.PropOwnedCount := IF(Config[1].SuppressAsset = false, le.PropOwnedCount , _blank);
		SELF.HealthAttributesV3.Asset.PropOwnedHistoricalCount := IF(Config[1].SuppressAsset = false, le.PropOwnedHistoricalCount , _blank);
		SELF.HealthAttributesV3.Asset.PropOwnedTaxTotal := IF(Config[1].SuppressAsset = false, le.PropOwnedTaxTotal , _blank);
		SELF.HealthAttributesV3.Asset.PropOwnedTaxTotal_12 := IF(Config[1].SuppressAsset = false, le.PropOwnedTaxTotal_12 , _blank);
		SELF.HealthAttributesV3.Asset.PropOwnedTaxTotal_24 := IF(Config[1].SuppressAsset = false, le.PropOwnedTaxTotal_24 , _blank);
		SELF.HealthAttributesV3.Asset.PropPurchasedCount12 := IF(Config[1].SuppressAsset = false, le.PropPurchasedCount12 , _blank);
		SELF.HealthAttributesV3.Asset.PropPurchasedCount24 := IF(Config[1].SuppressAsset = false, le.PropPurchasedCount24 , _blank);
		SELF.HealthAttributesV3.Asset.PropPurchasedCount60 := IF(Config[1].SuppressAsset = false, le.PropPurchasedCount60 , _blank);
		SELF.HealthAttributesV3.Asset.PropSoldCount12 := IF(Config[1].SuppressAsset = false, le.PropSoldCount12 , _blank);
		SELF.HealthAttributesV3.Asset.PropSoldCount60 := IF(Config[1].SuppressAsset = false, le.PropSoldCount60 , _blank);
		SELF.HealthAttributesV3.Asset.RaAPPCurrOwnerAircrftMmbrCnt := IF(Config[1].SuppressAsset = false, le.RaAPPCurrOwnerAircrftMmbrCnt , _blank);
		SELF.HealthAttributesV3.Asset.RaAPPCurrOwnerMmbrCnt := IF(Config[1].SuppressAsset = false, le.RaAPPCurrOwnerMmbrCnt , _blank);
		SELF.HealthAttributesV3.Asset.RaAPPCurrOwnerWtrcrftMmbrCnt := IF(Config[1].SuppressAsset = false, le.RaAPPCurrOwnerWtrcrftMmbrCnt , _blank);
		SELF.HealthAttributesV3.Asset.RaAPropCurrOwnerMmbrCnt := IF(Config[1].SuppressAsset = false, le.RaAPropCurrOwnerMmbrCnt , _blank);
		SELF.HealthAttributesV3.Asset.RaAPropOwnerAVMHighest := IF(Config[1].SuppressAsset = false, le.RaAPropOwnerAVMHighest , _blank);
		SELF.HealthAttributesV3.Asset.RaAPropOwnerAVMMed := IF(Config[1].SuppressAsset = false, le.RaAPropOwnerAVMMed , _blank);
		SELF.HealthAttributesV3.Asset.RelativesPropOwnedCount := IF(Config[1].SuppressAsset = false, le.RelativesPropOwnedCount , _blank);
		SELF.HealthAttributesV3.Asset.RelativesPropOwnedTaxTotal := IF(Config[1].SuppressAsset = false, le.RelativesPropOwnedTaxTotal , _blank);
		SELF.HealthAttributesV3.Asset.WatercraftCount := IF(Config[1].SuppressAsset = false, le.WatercraftCount , _blank);
		SELF.HealthAttributesV3.Asset.WatercraftCount12 := IF(Config[1].SuppressAsset = false, le.WatercraftCount12 , _blank);
		SELF.HealthAttributesV3.Asset.WatercraftCount24 := IF(Config[1].SuppressAsset = false, le.WatercraftCount24 , _blank);
		SELF.HealthAttributesV3.Asset.WatercraftCount60 := IF(Config[1].SuppressAsset = false, le.WatercraftCount60 , _blank);
		SELF.HealthAttributesV3.Asset.WatercraftOwner := IF(Config[1].SuppressAsset = false, le.WatercraftOwner , _blank);
		SELF.HealthAttributesV3.Asset.WealthIndex := IF(Config[1].SuppressAsset = false, le.WealthIndex , _blank); 
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrAgeLastSale := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrAgeLastSale , _blank);
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrAgeNewestRecord := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrAgeNewestRecord , _blank);
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrAgeOldestRecord := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrAgeOldestRecord , _blank);
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrApplicantOwned := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrApplicantOwned , _blank);
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrAVMValue := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrAVMValue , _blank);
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrAVMValue12 := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrAVMValue12 , _blank);
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrAVMValue60 := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrAVMValue60 , _blank);
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrBlockIndex := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrBlockIndex , _blank);
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrBurglaryIndex := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrBurglaryIndex , _blank);
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrBurglaryIndex_12 := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrBurglaryIndex_12 , _blank);
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrBurglaryIndex_24 := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrBurglaryIndex_24 , _blank);
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrCarTheftIndex := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrCarTheftIndex , _blank);
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrCountyIndex := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrCountyIndex , _blank);
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrCrimeIndex := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrCrimeIndex , _blank);
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrDwellType := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrDwellType , _blank);
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrFamilyOwned := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrFamilyOwned , _blank);
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrLastSalesPrice := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrLastSalesPrice , _blank);
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrLenOfRes := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrLenOfRes , _blank);
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrMedianIncome := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrMedianIncome , _blank);
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrMedianValue := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrMedianValue , _blank);
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrMortgageType := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrMortgageType , _blank);
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrMurderIndex := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrMurderIndex , _blank);
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrOccupantOwned := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrOccupantOwned , _blank);
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrTaxMarketValue := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrTaxMarketValue , _blank);
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrTaxValue := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrTaxValue , _blank);
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrTaxYr := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrTaxYr , _blank);
		SELF.HealthAttributesV3.CurrentAddress.CurrAddrTractIndex := IF(Config[1].SuppressCurrentAddress = false, le.CurrAddrTractIndex , _blank);
		SELF.HealthAttributesV3.CurrentAddress.ResCurrAVMRatioDiff12Mo := IF(Config[1].SuppressCurrentAddress = false, le.ResCurrAVMRatioDiff12Mo , _blank);
		SELF.HealthAttributesV3.CurrentAddress.ResCurrAVMRatioDiff60Mo := IF(Config[1].SuppressCurrentAddress = false, le.ResCurrAVMRatioDiff60Mo , _blank);
		SELF.HealthAttributesV3.CurrentAddress.ResCurrBusinessCnt := IF(Config[1].SuppressCurrentAddress = false, le.ResCurrBusinessCnt , _blank);
		SELF.HealthAttributesV3.CurrentAddress.ResCurrMortgageAmount := IF(Config[1].SuppressCurrentAddress = false, le.ResCurrMortgageAmount , _blank);
		SELF.HealthAttributesV3.CurrentAddress.ResCurrOwnershipIndex := IF(Config[1].SuppressCurrentAddress = false, le.ResCurrOwnershipIndex , _blank); 
		
		DECIMAL6_3 Age_in_Years_Decimal6_3 := TRUNCATE((real8)Le.Age_in_Years*1000)/1000;
		SELF.HealthAttributesV3.Demographics.Age_in_Years := IF(Config[1].SuppressDemographics = false, (string) Age_in_Years_Decimal6_3 , _blank);
		
		SELF.HealthAttributesV3.Demographics.Female := IF(Config[1].SuppressDemographics = false, le.Female , _blank);
		SELF.HealthAttributesV3.Demographics.HHCnt := IF(Config[1].SuppressDemographics = false, le.HHCnt , _blank);
		SELF.HealthAttributesV3.Demographics.HHElderlyMmbrCnt := IF(Config[1].SuppressDemographics = false, le.HHElderlyMmbrCnt , _blank);
		SELF.HealthAttributesV3.Demographics.HHMiddleAgemmbrCnt := IF(Config[1].SuppressDemographics = false, le.HHMiddleAgemmbrCnt , _blank);
		SELF.HealthAttributesV3.Demographics.HHSeniorMmbrCnt := IF(Config[1].SuppressDemographics = false, le.HHSeniorMmbrCnt , _blank);
		SELF.HealthAttributesV3.Demographics.HHTeenagerMmbrCnt := IF(Config[1].SuppressDemographics = false, le.HHTeenagerMmbrCnt , _blank);
		SELF.HealthAttributesV3.Demographics.HHYoungAdultMmbrCnt := IF(Config[1].SuppressDemographics = false, le.HHYoungAdultMmbrCnt , _blank);
		SELF.HealthAttributesV3.Demographics.ProspectMaritalStatus := IF(Config[1].SuppressDemographics = false, le.ProspectMaritalStatus , _blank);
		SELF.HealthAttributesV3.Demographics.RaAElderlyMmbrCnt := IF(Config[1].SuppressDemographics = false, le.RaAElderlyMmbrCnt , _blank);
		SELF.HealthAttributesV3.Demographics.RaAHHCnt := IF(Config[1].SuppressDemographics = false, le.RaAHHCnt , _blank);
		SELF.HealthAttributesV3.Demographics.RaAMiddleAgeMmbrCnt := IF(Config[1].SuppressDemographics = false, le.RaAMiddleAgeMmbrCnt , _blank);
		SELF.HealthAttributesV3.Demographics.RaAMmbrCnt := IF(Config[1].SuppressDemographics = false, le.RaAMmbrCnt , _blank);
		SELF.HealthAttributesV3.Demographics.RaASeniorMmbrCnt := IF(Config[1].SuppressDemographics = false, le.RaASeniorMmbrCnt , _blank);
		SELF.HealthAttributesV3.Demographics.RaATeenageMmbrCnt := IF(Config[1].SuppressDemographics = false, le.RaATeenageMmbrCnt , _blank);
		SELF.HealthAttributesV3.Demographics.RaAYoungAdultMmbrCnt := IF(Config[1].SuppressDemographics = false, le.RaAYoungAdultMmbrCnt , _blank);
		SELF.HealthAttributesV3.Demographics.RelativesCount := IF(Config[1].SuppressDemographics = false, le.RelativesCount , _blank);
		SELF.HealthAttributesV3.Demographics.RelativesDistanceClosest := IF(Config[1].SuppressDemographics = false, le.RelativesDistanceClosest , _blank);
		SELF.HealthAttributesV3.Demographics.ST := IF(Config[1].SuppressDemographics = false, le.ST , _blank); 
		SELF.HealthAttributesV3.DerogatoryRecord.CrtRecCnt := IF(Config[1].SuppressDerogatoryRecord = false, le.CrtRecCnt , _blank);
		SELF.HealthAttributesV3.DerogatoryRecord.CrtRecSeverityIndex := IF(Config[1].SuppressDerogatoryRecord = false, le.CrtRecSeverityIndex , _blank);
		SELF.HealthAttributesV3.DerogatoryRecord.DerogAge := IF(Config[1].SuppressDerogatoryRecord = false, le.DerogAge , _blank);
		SELF.HealthAttributesV3.DerogatoryRecord.DerogCount := IF(Config[1].SuppressDerogatoryRecord = false, le.DerogCount , _blank);
		SELF.HealthAttributesV3.DerogatoryRecord.DerogRecentCount := IF(Config[1].SuppressDerogatoryRecord = false, le.DerogRecentCount , _blank);
		SELF.HealthAttributesV3.DerogatoryRecord.DerogSeverityIndex := IF(Config[1].SuppressDerogatoryRecord = false, le.DerogSeverityIndex , _blank);
		SELF.HealthAttributesV3.DerogatoryRecord.HHCrtRecMmbrCnt := IF(Config[1].SuppressDerogatoryRecord = false, le.HHCrtRecMmbrCnt , _blank);
		SELF.HealthAttributesV3.DerogatoryRecord.HHCrtRecMmbrCnt12Mo := IF(Config[1].SuppressDerogatoryRecord = false, le.HHCrtRecMmbrCnt12Mo , _blank);
		SELF.HealthAttributesV3.DerogatoryRecord.RaACrtRecMmbrCnt := IF(Config[1].SuppressDerogatoryRecord = false, le.RaACrtRecMmbrCnt , _blank);
		SELF.HealthAttributesV3.DerogatoryRecord.RaACrtRecMmbrCnt12Mo := IF(Config[1].SuppressDerogatoryRecord = false, le.RaACrtRecMmbrCnt12Mo , _blank); 
		SELF.HealthAttributesV3.DerogatoryCrimeRecord.ArrestAge := IF(Config[1].SuppressDerogatoryCrimeRecord = false, le.ArrestAge , _blank);
		SELF.HealthAttributesV3.DerogatoryCrimeRecord.ArrestCount := IF(Config[1].SuppressDerogatoryCrimeRecord = false, le.ArrestCount , _blank);
		SELF.HealthAttributesV3.DerogatoryCrimeRecord.ArrestCount12 := IF(Config[1].SuppressDerogatoryCrimeRecord = false, le.ArrestCount12 , _blank);
		SELF.HealthAttributesV3.DerogatoryCrimeRecord.ArrestCount60 := IF(Config[1].SuppressDerogatoryCrimeRecord = false, le.ArrestCount60 , _blank);
		SELF.HealthAttributesV3.DerogatoryCrimeRecord.CrtRecMsdmeanCnt := IF(Config[1].SuppressDerogatoryCrimeRecord = false, le.CrtRecMsdmeanCnt , _blank);
		SELF.HealthAttributesV3.DerogatoryCrimeRecord.CrtRecMsdmeanCnt12Mo := IF(Config[1].SuppressDerogatoryCrimeRecord = false, le.CrtRecMsdmeanCnt12Mo , _blank);
		SELF.HealthAttributesV3.DerogatoryCrimeRecord.CrtRecMsdmeanTimeNewest := IF(Config[1].SuppressDerogatoryCrimeRecord = false, le.CrtRecMsdmeanTimeNewest , _blank);
		SELF.HealthAttributesV3.DerogatoryCrimeRecord.FelonyAge := IF(Config[1].SuppressDerogatoryCrimeRecord = false, le.FelonyAge , _blank);
		SELF.HealthAttributesV3.DerogatoryCrimeRecord.FelonyCount := IF(Config[1].SuppressDerogatoryCrimeRecord = false, le.FelonyCount , _blank);
		SELF.HealthAttributesV3.DerogatoryCrimeRecord.FelonyCount12 := IF(Config[1].SuppressDerogatoryCrimeRecord = false, le.FelonyCount12 , _blank);
		SELF.HealthAttributesV3.DerogatoryCrimeRecord.FelonyCount60 := IF(Config[1].SuppressDerogatoryCrimeRecord = false, le.FelonyCount60 , _blank);
		SELF.HealthAttributesV3.DerogatoryCrimeRecord.HHCrtRecFelonyMmbrCnt := IF(Config[1].SuppressDerogatoryCrimeRecord = false, le.HHCrtRecFelonyMmbrCnt , _blank);
		SELF.HealthAttributesV3.DerogatoryCrimeRecord.HHCrtRecFelonyMmbrCnt12Mo := IF(Config[1].SuppressDerogatoryCrimeRecord = false, le.HHCrtRecFelonyMmbrCnt12Mo , _blank);
		SELF.HealthAttributesV3.DerogatoryCrimeRecord.HHCrtRecMsdmeanMmbrCnt := IF(Config[1].SuppressDerogatoryCrimeRecord = false, le.HHCrtRecMsdmeanMmbrCnt , _blank);
		SELF.HealthAttributesV3.DerogatoryCrimeRecord.HHCrtRecMsdmeanMmbrCnt12Mo := IF(Config[1].SuppressDerogatoryCrimeRecord = false, le.HHCrtRecMsdmeanMmbrCnt12Mo , _blank);
		SELF.HealthAttributesV3.DerogatoryCrimeRecord.HistoricalAddrCorrectional := IF(Config[1].SuppressDerogatoryCrimeRecord = false, le.HistoricalAddrCorrectional , _blank);
		SELF.HealthAttributesV3.DerogatoryCrimeRecord.RaACrtRecFelonyMmbrCnt := IF(Config[1].SuppressDerogatoryCrimeRecord = false, le.RaACrtRecFelonyMmbrCnt , _blank);
		SELF.HealthAttributesV3.DerogatoryCrimeRecord.RaACrtRecFelonyMmbrCnt12Mo := IF(Config[1].SuppressDerogatoryCrimeRecord = false, le.RaACrtRecFelonyMmbrCnt12Mo , _blank);
		SELF.HealthAttributesV3.DerogatoryCrimeRecord.RaACrtRecMsdmeanMmbrCnt := IF(Config[1].SuppressDerogatoryCrimeRecord = false, le.RaACrtRecMsdmeanMmbrCnt , _blank);
		SELF.HealthAttributesV3.DerogatoryCrimeRecord.RaACrtRecMsdmeanMmbrCnt12Mo := IF(Config[1].SuppressDerogatoryCrimeRecord = false, le.RaACrtRecMsdmeanMmbrCnt12Mo , _blank);
		SELF.HealthAttributesV3.DerogatoryCrimeRecord.RelativesFelonyCount := IF(Config[1].SuppressDerogatoryCrimeRecord = false, le.RelativesFelonyCount , _blank); 
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.BankruptcyAge := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.BankruptcyAge , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.BankruptcyCount := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.BankruptcyCount , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.BankruptcyCount12 := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.BankruptcyCount12 , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.BankruptcyCount60 := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.BankruptcyCount60 , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.BankruptcyStatus := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.BankruptcyStatus , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.BankruptcyType := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.BankruptcyType , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.CrtRecLienJudgTimeNewest := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.CrtRecLienJudgTimeNewest , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.EvictionAge := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.EvictionAge , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.EvictionCount := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.EvictionCount , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.EvictionCount12 := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.EvictionCount12 , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.EvictionCount60 := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.EvictionCount60 , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.HHCrtRecBkrptMmbrCnt := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.HHCrtRecBkrptMmbrCnt , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.HHCrtRecBkrptMmbrCnt12Mo := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.HHCrtRecBkrptMmbrCnt12Mo , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.HHCrtRecBkrptMmbrCnt24Mo := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.HHCrtRecBkrptMmbrCnt24Mo , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.HHCrtRecEvictionMmbrCnt := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.HHCrtRecEvictionMmbrCnt , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.HHCrtRecEvictionMmbrCnt12Mo := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.HHCrtRecEvictionMmbrCnt12Mo , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.HHCrtRecLienJudgAmtTtl := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.HHCrtRecLienJudgAmtTtl , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.HHCrtRecLienJudgMmbrCnt := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.HHCrtRecLienJudgMmbrCnt , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.HHCrtRecLienJudgMmbrCnt12Mo := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.HHCrtRecLienJudgMmbrCnt12Mo , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.LienCount := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.LienCount , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.LienFiledAge := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.LienFiledAge , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.LienFiledCount := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.LienFiledCount , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.LienFiledCount12 := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.LienFiledCount12 , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.LienFiledCount24 := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.LienFiledCount24 , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.LienFiledCount60 := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.LienFiledCount60 , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.LienFiledTotal := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.LienFiledTotal , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.LienReleasedAge := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.LienReleasedAge , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.LienReleasedCount := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.LienReleasedCount , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.LienReleasedCount12 := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.LienReleasedCount12 , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.LienReleasedCount24 := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.LienReleasedCount24 , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.LienReleasedCount60 := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.LienReleasedCount60 , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.LienReleasedTotal := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.LienReleasedTotal , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.RaACrtRecBkrptMmbrCnt36Mo := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.RaACrtRecBkrptMmbrCnt36Mo , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.RaACrtRecEvictionMmbrCnt := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.RaACrtRecEvictionMmbrCnt , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.RaACrtRecEvictionMmbrCnt12Mo := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.RaACrtRecEvictionMmbrCnt12Mo , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.RaACrtRecLienJudgAmtMax := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.RaACrtRecLienJudgAmtMax , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.RaACrtRecLienJudgMmbrCnt := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.RaACrtRecLienJudgMmbrCnt , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.RaACrtRecLienJudgMmbrCnt12Mo := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.RaACrtRecLienJudgMmbrCnt12Mo , _blank);
		SELF.HealthAttributesV3.DerogatoryFinancialRecord.RelativesBankruptcyCount := IF(Config[1].SuppressDerogatoryFinancialRecord = false, le.RelativesBankruptcyCount , _blank); 
		SELF.HealthAttributesV3.Education.EducationAttendedCollege := IF(Config[1].SuppressEducation = false, le.EducationAttendedCollege , _blank);
		SELF.HealthAttributesV3.Education.EducationFieldofStudyType := IF(Config[1].SuppressEducation = false, le.EducationFieldofStudyType , _blank);
		SELF.HealthAttributesV3.Education.EducationInstitutionPrivate := IF(Config[1].SuppressEducation = false, le.EducationInstitutionPrivate , _blank);
		SELF.HealthAttributesV3.Education.EducationInstitutionRating := IF(Config[1].SuppressEducation = false, le.EducationInstitutionRating , _blank);
		SELF.HealthAttributesV3.Education.EducationProgram2Yr := IF(Config[1].SuppressEducation = false, le.EducationProgram2Yr , _blank);
		SELF.HealthAttributesV3.Education.EducationProgram4Yr := IF(Config[1].SuppressEducation = false, le.EducationProgram4Yr , _blank);
		SELF.HealthAttributesV3.Education.EducationProgramGraduate := IF(Config[1].SuppressEducation = false, le.EducationProgramGraduate , _blank);
		SELF.HealthAttributesV3.Education.HHCollege2yrAttendedMmbrCnt := IF(Config[1].SuppressEducation = false, le.HHCollege2yrAttendedMmbrCnt , _blank);
		SELF.HealthAttributesV3.Education.HHCollege4yrAttendedMmbrCnt := IF(Config[1].SuppressEducation = false, le.HHCollege4yrAttendedMmbrCnt , _blank);
		SELF.HealthAttributesV3.Education.HHCollegeAttendedMmbrCnt := IF(Config[1].SuppressEducation = false, le.HHCollegeAttendedMmbrCnt , _blank);
		SELF.HealthAttributesV3.Education.HHCollegeGradAttendedMmbrCnt := IF(Config[1].SuppressEducation = false, le.HHCollegeGradAttendedMmbrCnt , _blank);
		SELF.HealthAttributesV3.Education.HHCollegePrivateMmbrCnt := IF(Config[1].SuppressEducation = false, le.HHCollegePrivateMmbrCnt , _blank);
		SELF.HealthAttributesV3.Education.HHCollegeTierMmbrHighest := IF(Config[1].SuppressEducation = false, le.HHCollegeTierMmbrHighest , _blank);
		SELF.HealthAttributesV3.Education.ProspectCollegeAttended := IF(Config[1].SuppressEducation = false, le.ProspectCollegeAttended , _blank);
		SELF.HealthAttributesV3.Education.ProspectCollegeAttending := IF(Config[1].SuppressEducation = false, le.ProspectCollegeAttending , _blank);
		SELF.HealthAttributesV3.Education.ProspectCollegeProgramType := IF(Config[1].SuppressEducation = false, le.ProspectCollegeProgramType , _blank);
		SELF.HealthAttributesV3.Education.ProspectCollegeTier := IF(Config[1].SuppressEducation = false, le.ProspectCollegeTier , _blank);
		SELF.HealthAttributesV3.Education.RaACollege2yrAttendedMmbrCnt := IF(Config[1].SuppressEducation = false, le.RaACollege2yrAttendedMmbrCnt , _blank);
		SELF.HealthAttributesV3.Education.RaACollege4yrAttendedMmbrCnt := IF(Config[1].SuppressEducation = false, le.RaACollege4yrAttendedMmbrCnt , _blank);
		SELF.HealthAttributesV3.Education.RaACollegeAttendedMmbrCnt := IF(Config[1].SuppressEducation = false, le.RaACollegeAttendedMmbrCnt , _blank);
		SELF.HealthAttributesV3.Education.RaACollegeGradAttendedMmbrCnt := IF(Config[1].SuppressEducation = false, le.RaACollegeGradAttendedMmbrCnt , _blank);
		SELF.HealthAttributesV3.Education.RaACollegeLowTierMmbrCnt := IF(Config[1].SuppressEducation = false, le.RaACollegeLowTierMmbrCnt , _blank);
		SELF.HealthAttributesV3.Education.RaACollegeMidTierMmbrCnt := IF(Config[1].SuppressEducation = false, le.RaACollegeMidTierMmbrCnt , _blank);
		SELF.HealthAttributesV3.Education.RaACollegePrivateMmbrCnt := IF(Config[1].SuppressEducation = false, le.RaACollegePrivateMmbrCnt , _blank);
		SELF.HealthAttributesV3.Education.RaACollegeTopTierMmbrCnt := IF(Config[1].SuppressEducation = false, le.RaACollegeTopTierMmbrCnt , _blank); 
		SELF.HealthAttributesV3.IdentityActivity.AgeNewestRecord := IF(Config[1].SuppressIdentityActivity = false, le.AgeNewestRecord , _blank);
		SELF.HealthAttributesV3.IdentityActivity.AgeOldestRecord := IF(Config[1].SuppressIdentityActivity = false, le.AgeOldestRecord , _blank);
		SELF.HealthAttributesV3.IdentityActivity.CreditBureauRecord := IF(Config[1].SuppressIdentityActivity = false, le.CreditBureauRecord , _blank);
		SELF.HealthAttributesV3.IdentityActivity.LastNameChangeAge := IF(Config[1].SuppressIdentityActivity = false, le.LastNameChangeAge , _blank);
		SELF.HealthAttributesV3.IdentityActivity.LastNameChangeCount06 := IF(Config[1].SuppressIdentityActivity = false, le.LastNameChangeCount06 , _blank);
		SELF.HealthAttributesV3.IdentityActivity.LastNameChangeCount12 := IF(Config[1].SuppressIdentityActivity = false, le.LastNameChangeCount12 , _blank);
		SELF.HealthAttributesV3.IdentityActivity.LastNameChangeCount60 := IF(Config[1].SuppressIdentityActivity = false, le.LastNameChangeCount60 , _blank);
		SELF.HealthAttributesV3.IdentityActivity.ProspectBankingExperience := IF(Config[1].SuppressIdentityActivity = false, le.ProspectBankingExperience , _blank);
		SELF.HealthAttributesV3.IdentityActivity.RecentActivityIndex := IF(Config[1].SuppressIdentityActivity = false, le.RecentActivityIndex , _blank);
		SELF.HealthAttributesV3.IdentityActivity.RecentUpdate := IF(Config[1].SuppressIdentityActivity = false, le.RecentUpdate , _blank); 
		SELF.HealthAttributesV3.IdentityAssociation.AssocCreditBureauOnlyCount := IF(Config[1].SuppressIdentityAssociation = false, le.AssocCreditBureauOnlyCount , _blank);
		SELF.HealthAttributesV3.IdentityAssociation.AssocCreditBureauOnlyCountMonth := IF(Config[1].SuppressIdentityAssociation = false, le.AssocCreditBureauOnlyCountMonth , _blank);
		SELF.HealthAttributesV3.IdentityAssociation.AssocCreditBureauOnlyCountNew := IF(Config[1].SuppressIdentityAssociation = false, le.AssocCreditBureauOnlyCountNew , _blank);
		SELF.HealthAttributesV3.IdentityAssociation.AssocHighRiskTopologyCount := IF(Config[1].SuppressIdentityAssociation = false, le.AssocHighRiskTopologyCount , _blank);
		SELF.HealthAttributesV3.IdentityAssociation.AssocSuspicousIdentitiesCount := IF(Config[1].SuppressIdentityAssociation = false, le.AssocSuspicousIdentitiesCount , _blank);
		SELF.HealthAttributesV3.IdentityFraudRisk.AssocRiskLevel := IF(Config[1].SuppressIdentityFraudRisk = false, le.AssocRiskLevel , _blank);
		SELF.HealthAttributesV3.IdentityFraudRisk.ComponentCharRiskLevel := IF(Config[1].SuppressIdentityFraudRisk = false, le.ComponentCharRiskLevel , _blank);
		SELF.HealthAttributesV3.IdentityFraudRisk.DivRiskLevel := IF(Config[1].SuppressIdentityFraudRisk = false, le.DivRiskLevel , _blank);
		SELF.HealthAttributesV3.IdentityFraudRisk.IdentityRiskLevel := IF(Config[1].SuppressIdentityFraudRisk = false, le.IdentityRiskLevel , _blank);
		SELF.HealthAttributesV3.IdentityFraudRisk.IDVerRiskLevel := IF(Config[1].SuppressIdentityFraudRisk = false, le.IDVerRiskLevel , _blank);
		SELF.HealthAttributesV3.IdentityFraudRisk.SearchComponentRiskLevel := IF(Config[1].SuppressIdentityFraudRisk = false, le.SearchComponentRiskLevel , _blank);
		SELF.HealthAttributesV3.IdentityFraudRisk.SearchVelocityRiskLevel := IF(Config[1].SuppressIdentityFraudRisk = false, le.SearchVelocityRiskLevel , _blank);
		SELF.HealthAttributesV3.IdentityFraudRisk.SourceRiskLevel := IF(Config[1].SuppressIdentityFraudRisk = false, le.SourceRiskLevel , _blank);
		SELF.HealthAttributesV3.IdentityFraudRisk.SourceWatchList := IF(Config[1].SuppressIdentityFraudRisk = false, le.SourceWatchList , _blank);
		SELF.HealthAttributesV3.IdentityFraudRisk.ValidationRiskLevel := IF(Config[1].SuppressIdentityFraudRisk = false, le.ValidationRiskLevel , _blank); 
		SELF.HealthAttributesV3.IdentityProductSearchEvent.PRSearchAddrIdentities := IF(Config[1].SuppressIdentityProductSearchEvent = false, le.PRSearchAddrIdentities , _blank);
		SELF.HealthAttributesV3.IdentityProductSearchEvent.PRSearchIdentityAddrs := IF(Config[1].SuppressIdentityProductSearchEvent = false, le.PRSearchIdentityAddrs , _blank);
		SELF.HealthAttributesV3.IdentityProductSearchEvent.PRSearchIdentityPhones := IF(Config[1].SuppressIdentityProductSearchEvent = false, le.PRSearchIdentityPhones , _blank);
		SELF.HealthAttributesV3.IdentityProductSearchEvent.PRSearchIdentitySSNs := IF(Config[1].SuppressIdentityProductSearchEvent = false, le.PRSearchIdentitySSNs , _blank);
		SELF.HealthAttributesV3.IdentityProductSearchEvent.PRSearchLocateCount := IF(Config[1].SuppressIdentityProductSearchEvent = false, le.PRSearchLocateCount , _blank);
		SELF.HealthAttributesV3.IdentityProductSearchEvent.PRSearchLocateCount01 := IF(Config[1].SuppressIdentityProductSearchEvent = false, le.PRSearchLocateCount01 , _blank);
		SELF.HealthAttributesV3.IdentityProductSearchEvent.PRSearchLocateCount03 := IF(Config[1].SuppressIdentityProductSearchEvent = false, le.PRSearchLocateCount03 , _blank);
		SELF.HealthAttributesV3.IdentityProductSearchEvent.PRSearchLocateCount06 := IF(Config[1].SuppressIdentityProductSearchEvent = false, le.PRSearchLocateCount06 , _blank);
		SELF.HealthAttributesV3.IdentityProductSearchEvent.PRSearchLocateCount12 := IF(Config[1].SuppressIdentityProductSearchEvent = false, le.PRSearchLocateCount12 , _blank);
		SELF.HealthAttributesV3.IdentityProductSearchEvent.PRSearchLocateCount24 := IF(Config[1].SuppressIdentityProductSearchEvent = false, le.PRSearchLocateCount24 , _blank);
		SELF.HealthAttributesV3.IdentityProductSearchEvent.PRSearchOtherCount := IF(Config[1].SuppressIdentityProductSearchEvent = false, le.PRSearchOtherCount , _blank);
		SELF.HealthAttributesV3.IdentityProductSearchEvent.PRSearchOtherCount03 := IF(Config[1].SuppressIdentityProductSearchEvent = false, le.PRSearchOtherCount03 , _blank);
		SELF.HealthAttributesV3.IdentityProductSearchEvent.PRSearchOtherCount12 := IF(Config[1].SuppressIdentityProductSearchEvent = false, le.PRSearchOtherCount12 , _blank);
		SELF.HealthAttributesV3.IdentityProductSearchEvent.PRSearchPersonalFinanceCount := IF(Config[1].SuppressIdentityProductSearchEvent = false, le.PRSearchPersonalFinanceCount , _blank);
		SELF.HealthAttributesV3.IdentityProductSearchEvent.PRSearchPersonalFinanceCount12 := IF(Config[1].SuppressIdentityProductSearchEvent = false, le.PRSearchPersonalFinanceCount12 , _blank);
		SELF.HealthAttributesV3.IdentityProductSearchEvent.PRSearchPersonalFinanceCount24 := IF(Config[1].SuppressIdentityProductSearchEvent = false, le.PRSearchPersonalFinanceCount24 , _blank);
		SELF.HealthAttributesV3.IdentityProductSearchEvent.PRSearchPhoneIdentities := IF(Config[1].SuppressIdentityProductSearchEvent = false, le.PRSearchPhoneIdentities , _blank);
		SELF.HealthAttributesV3.IdentityProductSearchEvent.PRSearchSSNIdentities := IF(Config[1].SuppressIdentityProductSearchEvent = false, le.PRSearchSSNIdentities , _blank);
		SELF.HealthAttributesV3.IdentityProductSearchEvent.SearchAddrSearchCount := IF(Config[1].SuppressIdentityProductSearchEvent = false, le.SearchAddrSearchCount , _blank);
		SELF.HealthAttributesV3.IdentityProductSearchEvent.SearchPhoneSearchCount := IF(Config[1].SuppressIdentityProductSearchEvent = false, le.SearchPhoneSearchCount , _blank);
		SELF.HealthAttributesV3.IdentityProductSearchEvent.SearchSSNSearchCount := IF(Config[1].SuppressIdentityProductSearchEvent = false, le.SearchSSNSearchCount , _blank);
		SELF.HealthAttributesV3.IdentityProductSearchEvent.SearchUnverifiedAddrCountYear := IF(Config[1].SuppressIdentityProductSearchEvent = false, le.SearchUnverifiedAddrCountYear , _blank);
		SELF.HealthAttributesV3.IdentityProductSearchEvent.SearchUnverifiedDOBCountYear := IF(Config[1].SuppressIdentityProductSearchEvent = false, le.SearchUnverifiedDOBCountYear , _blank);
		SELF.HealthAttributesV3.IdentityProductSearchEvent.SearchUnverifiedPhoneCountYear := IF(Config[1].SuppressIdentityProductSearchEvent = false, le.SearchUnverifiedPhoneCountYear , _blank);
		SELF.HealthAttributesV3.IdentityProductSearchEvent.SearchUnverifiedSSNCountYear := IF(Config[1].SuppressIdentityProductSearchEvent = false, le.SearchUnverifiedSSNCountYear , _blank); 
		SELF.HealthAttributesV3.IdentityValidation.AgeRiskIndicator := IF(Config[1].SuppressIdentityValidation = false, le.AgeRiskIndicator , _blank);
		SELF.HealthAttributesV3.IdentityValidation.CorrelationRiskLevel := IF(Config[1].SuppressIdentityValidation = false, le.CorrelationRiskLevel , _blank);
		SELF.HealthAttributesV3.IdentityValidation.OnlineDirectory := IF(Config[1].SuppressIdentityValidation = false, le.OnlineDirectory , _blank);
		SELF.HealthAttributesV3.IdentityValidation.SrcsConfirmIDAddrCount := IF(Config[1].SuppressIdentityValidation = false, le.SrcsConfirmIDAddrCount , _blank);
		SELF.HealthAttributesV3.IdentityValidation.VerificationFailure := IF(Config[1].SuppressIdentityValidation = false, le.VerificationFailure , _blank);
		SELF.HealthAttributesV3.IdentityValidation.VerifiedAddress := IF(Config[1].SuppressIdentityValidation = false, le.VerifiedAddress , _blank);
		SELF.HealthAttributesV3.IdentityValidation.VerifiedDOB := IF(Config[1].SuppressIdentityValidation = false, le.VerifiedDOB , _blank);
		SELF.HealthAttributesV3.IdentityValidation.VerifiedName := IF(Config[1].SuppressIdentityValidation = false, le.VerifiedName , _blank); 
		SELF.HealthAttributesV3.IdentityVariation.SubjectAddrCount := IF(Config[1].SuppressIdentityVariation = false, le.SubjectAddrCount , _blank);
		SELF.HealthAttributesV3.IdentityVariation.SubjectAddrRecentCount := IF(Config[1].SuppressIdentityVariation = false, le.SubjectAddrRecentCount , _blank);
		SELF.HealthAttributesV3.IdentityVariation.SubjectLastNameCount := IF(Config[1].SuppressIdentityVariation = false, le.SubjectLastNameCount , _blank);
		SELF.HealthAttributesV3.IdentityVariation.SubjectSSNCount := IF(Config[1].SuppressIdentityVariation = false, le.SubjectSSNCount , _blank);
		SELF.HealthAttributesV3.IdentityVariation.SubjectSSNRecentCount := IF(Config[1].SuppressIdentityVariation = false, le.SubjectSSNRecentCount , _blank);
		SELF.HealthAttributesV3.IdentityVariation.VariationDOBCount := IF(Config[1].SuppressIdentityVariation = false, le.VariationDOBCount , _blank);
		SELF.HealthAttributesV3.IdentityVariation.VariationDOBCountNew := IF(Config[1].SuppressIdentityVariation = false, le.VariationDOBCountNew , _blank);
		SELF.HealthAttributesV3.IdentityVariation.VariationIdentityCount := IF(Config[1].SuppressIdentityVariation = false, le.VariationIdentityCount , _blank);
		SELF.HealthAttributesV3.IdentityVariation.VariationMSourcesSSNCount := IF(Config[1].SuppressIdentityVariation = false, le.VariationMSourcesSSNCount , _blank);
		SELF.HealthAttributesV3.IdentityVariation.VariationMSourcesSSNUnrelCount := IF(Config[1].SuppressIdentityVariation = false, le.VariationMSourcesSSNUnrelCount , _blank);
		SELF.HealthAttributesV3.IdentityVariation.VariationRiskLevel := IF(Config[1].SuppressIdentityVariation = false, le.VariationRiskLevel , _blank); 
		SELF.HealthAttributesV3.Income.EstimatedAnnualIncome := IF(Config[1].SuppressIncome = false, le.EstimatedAnnualIncome , _blank);
		SELF.HealthAttributesV3.Income.EstimatedAnnualIncome_12 := IF(Config[1].SuppressIncome = false, le.EstimatedAnnualIncome_12 , _blank);
		SELF.HealthAttributesV3.Income.EstimatedAnnualIncome_24 := IF(Config[1].SuppressIncome = false, le.EstimatedAnnualIncome_24 , _blank);
		SELF.HealthAttributesV3.Income.HHEstimatedIncomeRange := IF(Config[1].SuppressIncome = false, le.HHEstimatedIncomeRange , _blank);
		SELF.HealthAttributesV3.Income.ProspectEstimatedIncomeRange := IF(Config[1].SuppressIncome = false, le.ProspectEstimatedIncomeRange , _blank);
		SELF.HealthAttributesV3.Income.RaAMedIncomeRange := IF(Config[1].SuppressIncome = false, le.RaAMedIncomeRange , _blank); 
		SELF.HealthAttributesV3.InputAddress.BusinessInputAddrCount := IF(Config[1].SuppressInputAddress = false, le.BusinessInputAddrCount , _blank);
		SELF.HealthAttributesV3.InputAddress.DivAddrIdentityCount := IF(Config[1].SuppressInputAddress = false, le.DivAddrIdentityCount , _blank);
		SELF.HealthAttributesV3.InputAddress.DivAddrIdentityCountNew := IF(Config[1].SuppressInputAddress = false, le.DivAddrIdentityCountNew , _blank);
		SELF.HealthAttributesV3.InputAddress.DivAddrIdentityMSourceCount := IF(Config[1].SuppressInputAddress = false, le.DivAddrIdentityMSourceCount , _blank);
		SELF.HealthAttributesV3.InputAddress.DivAddrSSNCount := IF(Config[1].SuppressInputAddress = false, le.DivAddrSSNCount , _blank);
		SELF.HealthAttributesV3.InputAddress.DivAddrSSNCountNew := IF(Config[1].SuppressInputAddress = false, le.DivAddrSSNCountNew , _blank);
		SELF.HealthAttributesV3.InputAddress.DivAddrSSNMSourceCount := IF(Config[1].SuppressInputAddress = false, le.DivAddrSSNMSourceCount , _blank);
		SELF.HealthAttributesV3.InputAddress.DivAddrSuspIdentityCountNew := IF(Config[1].SuppressInputAddress = false, le.DivAddrSuspIdentityCountNew , _blank);
		SELF.HealthAttributesV3.InputAddress.DivSearchAddrSuspIdentityCount := IF(Config[1].SuppressInputAddress = false, le.DivSearchAddrSuspIdentityCount , _blank);
		SELF.HealthAttributesV3.InputAddress.IDVerAddressAssocCount := IF(Config[1].SuppressInputAddress = false, le.IDVerAddressAssocCount , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrAgeLastSale := IF(Config[1].SuppressInputAddress = false, le.InputAddrAgeLastSale , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrAgeNewestRecord := IF(Config[1].SuppressInputAddress = false, le.InputAddrAgeNewestRecord , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrAgeOldestRecord := IF(Config[1].SuppressInputAddress = false, le.InputAddrAgeOldestRecord , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrApplicantOwned := IF(Config[1].SuppressInputAddress = false, le.InputAddrApplicantOwned , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrAVMValue := IF(Config[1].SuppressInputAddress = false, le.InputAddrAVMValue , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrAVMValue12 := IF(Config[1].SuppressInputAddress = false, le.InputAddrAVMValue12 , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrAVMValue60 := IF(Config[1].SuppressInputAddress = false, le.InputAddrAVMValue60 , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrBlockIndex := IF(Config[1].SuppressInputAddress = false, le.InputAddrBlockIndex , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrBurglaryIndex := IF(Config[1].SuppressInputAddress = false, le.InputAddrBurglaryIndex , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrBusinessCount := IF(Config[1].SuppressInputAddress = false, le.InputAddrBusinessCount , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrCarTheftIndex := IF(Config[1].SuppressInputAddress = false, le.InputAddrCarTheftIndex , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrCountyIndex := IF(Config[1].SuppressInputAddress = false, le.InputAddrCountyIndex , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrCrimeIndex := IF(Config[1].SuppressInputAddress = false, le.InputAddrCrimeIndex , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrDelivery := IF(Config[1].SuppressInputAddress = false, le.InputAddrDelivery , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrDwellType := IF(Config[1].SuppressInputAddress = false, le.InputAddrDwellType , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrErrorCode := IF(Config[1].SuppressInputAddress = false, le.InputAddrErrorCode , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrFamilyOwned := IF(Config[1].SuppressInputAddress = false, le.InputAddrFamilyOwned , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrHighRisk := IF(Config[1].SuppressInputAddress = false, le.InputAddrHighRisk , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrHistoricalMatch := IF(Config[1].SuppressInputAddress = false, le.InputAddrHistoricalMatch , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrLastSalesPrice := IF(Config[1].SuppressInputAddress = false, le.InputAddrLastSalesPrice , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrLenOfRes := IF(Config[1].SuppressInputAddress = false, le.InputAddrLenOfRes , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrMedianIncome := IF(Config[1].SuppressInputAddress = false, le.InputAddrMedianIncome , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrMedianValue := IF(Config[1].SuppressInputAddress = false, le.InputAddrMedianValue , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrMobilityIndex := IF(Config[1].SuppressInputAddress = false, le.InputAddrMobilityIndex , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrMortgageType := IF(Config[1].SuppressInputAddress = false, le.InputAddrMortgageType , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrMultiFamilyCount := IF(Config[1].SuppressInputAddress = false, le.InputAddrMultiFamilyCount , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrMurderIndex := IF(Config[1].SuppressInputAddress = false, le.InputAddrMurderIndex , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrNotPrimaryRes := IF(Config[1].SuppressInputAddress = false, le.InputAddrNotPrimaryRes , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrOccupantOwned := IF(Config[1].SuppressInputAddress = false, le.InputAddrOccupantOwned , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrProblems := IF(Config[1].SuppressInputAddress = false, le.InputAddrProblems , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrSICCode := IF(Config[1].SuppressInputAddress = false, le.InputAddrSICCode , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrSingleFamilyCount := IF(Config[1].SuppressInputAddress = false, le.InputAddrSingleFamilyCount , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrTaxMarketValue := IF(Config[1].SuppressInputAddress = false, le.InputAddrTaxMarketValue , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrTaxValue := IF(Config[1].SuppressInputAddress = false, le.InputAddrTaxValue , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrTaxYr := IF(Config[1].SuppressInputAddress = false, le.InputAddrTaxYr , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrTractIndex := IF(Config[1].SuppressInputAddress = false, le.InputAddrTractIndex , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrVacantPropCount := IF(Config[1].SuppressInputAddress = false, le.InputAddrVacantPropCount , _blank);
		SELF.HealthAttributesV3.InputAddress.InputAddrValidation := IF(Config[1].SuppressInputAddress = false, le.InputAddrValidation , _blank);
		SELF.HealthAttributesV3.InputAddress.ResInputAVMRatioDiff12Mo := IF(Config[1].SuppressInputAddress = false, le.ResInputAVMRatioDiff12Mo , _blank);
		SELF.HealthAttributesV3.InputAddress.ResInputAVMRatioDiff60Mo := IF(Config[1].SuppressInputAddress = false, le.ResInputAVMRatioDiff60Mo , _blank);
		SELF.HealthAttributesV3.InputAddress.ResInputBusinessCnt := IF(Config[1].SuppressInputAddress = false, le.ResInputBusinessCnt , _blank);
		SELF.HealthAttributesV3.InputAddress.ResInputMortgageAmount := IF(Config[1].SuppressInputAddress = false, le.ResInputMortgageAmount , _blank);
		SELF.HealthAttributesV3.InputAddress.ResInputOwnershipIndex := IF(Config[1].SuppressInputAddress = false, le.ResInputOwnershipIndex , _blank);
		SELF.HealthAttributesV3.InputAddress.SFDUAddrIdentitiesCount := IF(Config[1].SuppressInputAddress = false, le.SFDUAddrIdentitiesCount , _blank);
		SELF.HealthAttributesV3.InputAddress.SFDUAddrIdentitiesCount_12 := IF(Config[1].SuppressInputAddress = false, le.SFDUAddrIdentitiesCount_12 , _blank);
		SELF.HealthAttributesV3.InputAddress.SFDUAddrIdentitiesCount_24 := IF(Config[1].SuppressInputAddress = false, le.SFDUAddrIdentitiesCount_24 , _blank);
		SELF.HealthAttributesV3.InputAddress.SFDUAddrSSNCount := IF(Config[1].SuppressInputAddress = false, le.SFDUAddrSSNCount , _blank); 
		SELF.HealthAttributesV3.InputSSN.DivSSNAddrMSourceCount := IF(Config[1].SuppressInputSSN = false, le.DivSSNAddrMSourceCount , _blank);
		SELF.HealthAttributesV3.InputSSN.DivSSNIdentityMSourceCount := IF(Config[1].SuppressInputSSN = false, le.DivSSNIdentityMSourceCount , _blank);
		SELF.HealthAttributesV3.InputSSN.DivSSNIdentityMSourceUrelCount := IF(Config[1].SuppressInputSSN = false, le.DivSSNIdentityMSourceUrelCount , _blank);
		SELF.HealthAttributesV3.InputSSN.DivSSNLNameCountNew := IF(Config[1].SuppressInputSSN = false, le.DivSSNLNameCountNew , _blank);
		SELF.HealthAttributesV3.InputSSN.IDVerSSNCreditBureauCount := IF(Config[1].SuppressInputSSN = false, le.IDVerSSNCreditBureauCount , _blank);
		SELF.HealthAttributesV3.InputSSN.IDVerSSNCreditBureauDelete := IF(Config[1].SuppressInputSSN = false, le.IDVerSSNCreditBureauDelete , _blank);
		SELF.HealthAttributesV3.InputSSN.SSN3Years := IF(Config[1].SuppressInputSSN = false, le.SSN3Years , _blank);
		SELF.HealthAttributesV3.InputSSN.SSNAddrCount := IF(Config[1].SuppressInputSSN = false, le.SSNAddrCount , _blank);
		SELF.HealthAttributesV3.InputSSN.SSNAddrRecentCount := IF(Config[1].SuppressInputSSN = false, le.SSNAddrRecentCount , _blank);
		SELF.HealthAttributesV3.InputSSN.SSNAfter5 := IF(Config[1].SuppressInputSSN = false, le.SSNAfter5 , _blank);
		SELF.HealthAttributesV3.InputSSN.SSNFoundOther := IF(Config[1].SuppressInputSSN = false, le.SSNFoundOther , _blank);
		SELF.HealthAttributesV3.InputSSN.SSNHighIssueAge := IF(Config[1].SuppressInputSSN = false, le.SSNHighIssueAge , _blank);
		SELF.HealthAttributesV3.InputSSN.SSNIdentitiesCount := IF(Config[1].SuppressInputSSN = false, le.SSNIdentitiesCount , _blank);
		SELF.HealthAttributesV3.InputSSN.SSNIdentitiesRecentCount := IF(Config[1].SuppressInputSSN = false, le.SSNIdentitiesRecentCount , _blank);
		SELF.HealthAttributesV3.InputSSN.SSNIssueState := IF(Config[1].SuppressInputSSN = false, le.SSNIssueState , _blank);
		SELF.HealthAttributesV3.InputSSN.SSNLastNameCount := IF(Config[1].SuppressInputSSN = false, le.SSNLastNameCount , _blank);
		SELF.HealthAttributesV3.InputSSN.SSNLowIssueAge := IF(Config[1].SuppressInputSSN = false, le.SSNLowIssueAge , _blank);
		SELF.HealthAttributesV3.InputSSN.SSNNonUS := IF(Config[1].SuppressInputSSN = false, le.SSNNonUS , _blank);
		SELF.HealthAttributesV3.InputSSN.SSNNotFound := IF(Config[1].SuppressInputSSN = false, le.SSNNotFound , _blank);
		SELF.HealthAttributesV3.InputSSN.SSNProblems := IF(Config[1].SuppressInputSSN = false, le.SSNProblems , _blank);
		SELF.HealthAttributesV3.InputSSN.SSNRecent := IF(Config[1].SuppressInputSSN = false, le.SSNRecent , _blank);
		SELF.HealthAttributesV3.InputSSN.VerifiedSSN := IF(Config[1].SuppressInputSSN = false, le.VerifiedSSN , _blank); 
		SELF.HealthAttributesV3.Interests.HHInterestSportPersonMmbrCnt := IF(Config[1].SuppressInterests = false, le.HHInterestSportPersonMmbrCnt , _blank);
		SELF.HealthAttributesV3.Interests.InterestSportPerson := IF(Config[1].SuppressInterests = false, le.InterestSportPerson , _blank);
		SELF.HealthAttributesV3.Interests.RaAInterestSportPersonMmbrCnt := IF(Config[1].SuppressInterests = false, le.RaAInterestSportPersonMmbrCnt , _blank); 
		SELF.HealthAttributesV3.MostRecentAddress.AddrMostRecentCrimeDiff := IF(Config[1].SuppressMostRecentAddress = false, le.AddrMostRecentCrimeDiff , _blank);
		SELF.HealthAttributesV3.MostRecentAddress.AddrMostRecentDistance := IF(Config[1].SuppressMostRecentAddress = false, le.AddrMostRecentDistance , _blank);
		SELF.HealthAttributesV3.MostRecentAddress.AddrMostRecentIncomeDiff := IF(Config[1].SuppressMostRecentAddress = false, le.AddrMostRecentIncomeDiff , _blank);
		SELF.HealthAttributesV3.MostRecentAddress.AddrMostRecentMoveAge := IF(Config[1].SuppressMostRecentAddress = false, le.AddrMostRecentMoveAge , _blank);
		SELF.HealthAttributesV3.MostRecentAddress.AddrMostRecentStateDiff := IF(Config[1].SuppressMostRecentAddress = false, le.AddrMostRecentStateDiff , _blank);
		SELF.HealthAttributesV3.MostRecentAddress.AddrMostRecentTaxDiff := IF(Config[1].SuppressMostRecentAddress = false, le.AddrMostRecentTaxDiff , _blank);
		SELF.HealthAttributesV3.MostRecentAddress.AddrMostRecentValueDIff := IF(Config[1].SuppressMostRecentAddress = false, le.AddrMostRecentValueDIff , _blank);
		SELF.HealthAttributesV3.MostRecentAddress.AddrRecentEconTrajectory := IF(Config[1].SuppressMostRecentAddress = false, le.AddrRecentEconTrajectory , _blank);
		SELF.HealthAttributesV3.MostRecentAddress.AddrRecentEconTrajectoryIndex := IF(Config[1].SuppressMostRecentAddress = false, le.AddrRecentEconTrajectoryIndex , _blank); 
		SELF.HealthAttributesV3.NonDerogatoryRecord.NonDerogCount := IF(Config[1].SuppressNonDerogatoryRecord = false, le.NonDerogCount , _blank);
		SELF.HealthAttributesV3.NonDerogatoryRecord.NonDerogCount06 := IF(Config[1].SuppressNonDerogatoryRecord = false, le.NonDerogCount06 , _blank);
		SELF.HealthAttributesV3.NonDerogatoryRecord.NonDerogCount12 := IF(Config[1].SuppressNonDerogatoryRecord = false, le.NonDerogCount12 , _blank);
		SELF.HealthAttributesV3.NonDerogatoryRecord.NonDerogCount24 := IF(Config[1].SuppressNonDerogatoryRecord = false, le.NonDerogCount24 , _blank);
		SELF.HealthAttributesV3.NonDerogatoryRecord.NonDerogCount60 := IF(Config[1].SuppressNonDerogatoryRecord = false, le.NonDerogCount60 , _blank);
		SELF.HealthAttributesV3.NonDerogatoryRecord.VoterRegistrationRecord := IF(Config[1].SuppressNonDerogatoryRecord = false, le.VoterRegistrationRecord , _blank); 
		SELF.HealthAttributesV3.NonDerogatoryOccupationalRecord.BusinessActiveAssociation := IF(Config[1].SuppressNonDerogatoryOccupationalRecord = false, le.BusinessActiveAssociation , _blank);
		SELF.HealthAttributesV3.NonDerogatoryOccupationalRecord.BusinessAssociationAge := IF(Config[1].SuppressNonDerogatoryOccupationalRecord = false, le.BusinessAssociationAge , _blank);
		SELF.HealthAttributesV3.NonDerogatoryOccupationalRecord.BusinessInactiveAssociation := IF(Config[1].SuppressNonDerogatoryOccupationalRecord = false, le.BusinessInactiveAssociation , _blank);
		SELF.HealthAttributesV3.NonDerogatoryOccupationalRecord.HHOccBusinessAssocMmbrCnt := IF(Config[1].SuppressNonDerogatoryOccupationalRecord = false, le.HHOccBusinessAssocMmbrCnt , _blank);
		SELF.HealthAttributesV3.NonDerogatoryOccupationalRecord.HHOccProfLicMmbrCnt := IF(Config[1].SuppressNonDerogatoryOccupationalRecord = false, le.HHOccProfLicMmbrCnt , _blank);
		SELF.HealthAttributesV3.NonDerogatoryOccupationalRecord.OccBusinessAssociation := IF(Config[1].SuppressNonDerogatoryOccupationalRecord = false, le.OccBusinessAssociation , _blank);
		SELF.HealthAttributesV3.NonDerogatoryOccupationalRecord.OccBusinessAssociationTime := IF(Config[1].SuppressNonDerogatoryOccupationalRecord = false, le.OccBusinessAssociationTime , _blank);
		SELF.HealthAttributesV3.NonDerogatoryOccupationalRecord.OccBusinessTitleLeadership := IF(Config[1].SuppressNonDerogatoryOccupationalRecord = false, le.OccBusinessTitleLeadership , _blank);
		SELF.HealthAttributesV3.NonDerogatoryOccupationalRecord.OccProfLicense := IF(Config[1].SuppressNonDerogatoryOccupationalRecord = false, le.OccProfLicense , _blank);
		SELF.HealthAttributesV3.NonDerogatoryOccupationalRecord.OccProfLicenseCategory := IF(Config[1].SuppressNonDerogatoryOccupationalRecord = false, le.OccProfLicenseCategory , _blank);
		SELF.HealthAttributesV3.NonDerogatoryOccupationalRecord.ProfLicAge := IF(Config[1].SuppressNonDerogatoryOccupationalRecord = false, le.ProfLicAge , _blank);
		SELF.HealthAttributesV3.NonDerogatoryOccupationalRecord.ProfLicCount := IF(Config[1].SuppressNonDerogatoryOccupationalRecord = false, le.ProfLicCount , _blank);
		SELF.HealthAttributesV3.NonDerogatoryOccupationalRecord.ProfLicCount12 := IF(Config[1].SuppressNonDerogatoryOccupationalRecord = false, le.ProfLicCount12 , _blank);
		SELF.HealthAttributesV3.NonDerogatoryOccupationalRecord.ProfLicCount60 := IF(Config[1].SuppressNonDerogatoryOccupationalRecord = false, le.ProfLicCount60 , _blank);
		SELF.HealthAttributesV3.NonDerogatoryOccupationalRecord.ProfLicExpired := IF(Config[1].SuppressNonDerogatoryOccupationalRecord = false, le.ProfLicExpired , _blank);
		SELF.HealthAttributesV3.NonDerogatoryOccupationalRecord.ProfLicTypeCategory := IF(Config[1].SuppressNonDerogatoryOccupationalRecord = false, le.ProfLicTypeCategory , _blank);
		SELF.HealthAttributesV3.NonDerogatoryOccupationalRecord.RaAOccBusinessAssocMmbrCnt := IF(Config[1].SuppressNonDerogatoryOccupationalRecord = false, le.RaAOccBusinessAssocMmbrCnt , _blank);
		SELF.HealthAttributesV3.NonDerogatoryOccupationalRecord.RaAOccProfLicMmbrCnt := IF(Config[1].SuppressNonDerogatoryOccupationalRecord = false, le.RaAOccProfLicMmbrCnt , _blank); 
		SELF.HealthAttributesV3.Phone.CurrAddrActivePhoneList := IF(Config[1].SuppressPhone = false, le.CurrAddrActivePhoneList , _blank);
		SELF.HealthAttributesV3.Phone.InputAddrActivePhoneList := IF(Config[1].SuppressPhone = false, le.InputAddrActivePhoneList , _blank);
		SELF.HealthAttributesV3.Phone.InputAddrPhoneCount := IF(Config[1].SuppressPhone = false, le.InputAddrPhoneCount , _blank);
		SELF.HealthAttributesV3.Phone.InputAddrPhoneRecentCount := IF(Config[1].SuppressPhone = false, le.InputAddrPhoneRecentCount , _blank);
		SELF.HealthAttributesV3.Phone.InputAreaCodeChange := IF(Config[1].SuppressPhone = false, le.InputAreaCodeChange , _blank);
		SELF.HealthAttributesV3.Phone.InputPhoneHighRisk := IF(Config[1].SuppressPhone = false, le.InputPhoneHighRisk , _blank);
		SELF.HealthAttributesV3.Phone.InputPhoneMobile := IF(Config[1].SuppressPhone = false, le.InputPhoneMobile , _blank);
		SELF.HealthAttributesV3.Phone.InputPhoneProblems := IF(Config[1].SuppressPhone = false, le.InputPhoneProblems , _blank);
		SELF.HealthAttributesV3.Phone.InputPhoneServiceType := IF(Config[1].SuppressPhone = false, le.InputPhoneServiceType , _blank);
		SELF.HealthAttributesV3.Phone.InputPhoneType := IF(Config[1].SuppressPhone = false, le.InputPhoneType , _blank);
		SELF.HealthAttributesV3.Phone.PhoneEDAAgeNewestRecord := IF(Config[1].SuppressPhone = false, le.PhoneEDAAgeNewestRecord , _blank);
		SELF.HealthAttributesV3.Phone.PhoneEDAAgeOldestRecord := IF(Config[1].SuppressPhone = false, le.PhoneEDAAgeOldestRecord , _blank);
		SELF.HealthAttributesV3.Phone.PhoneIdentitiesCount := IF(Config[1].SuppressPhone = false, le.PhoneIdentitiesCount , _blank);
		SELF.HealthAttributesV3.Phone.PhoneIdentitiesRecentCount := IF(Config[1].SuppressPhone = false, le.PhoneIdentitiesRecentCount , _blank);
		SELF.HealthAttributesV3.Phone.PhoneOther := IF(Config[1].SuppressPhone = false, le.PhoneOther , _blank);
		SELF.HealthAttributesV3.Phone.PhoneOtherAgeNewestRecord := IF(Config[1].SuppressPhone = false, le.PhoneOtherAgeNewestRecord , _blank);
		SELF.HealthAttributesV3.Phone.PhoneOtherAgeOldestRecord := IF(Config[1].SuppressPhone = false, le.PhoneOtherAgeOldestRecord , _blank);
		SELF.HealthAttributesV3.Phone.SubjectPhoneCount := IF(Config[1].SuppressPhone = false, le.SubjectPhoneCount , _blank);
		SELF.HealthAttributesV3.Phone.SubjectPhoneRecentCount := IF(Config[1].SuppressPhone = false, le.SubjectPhoneRecentCount , _blank);
		SELF.HealthAttributesV3.Phone.VerifiedPhone := IF(Config[1].SuppressPhone = false, le.VerifiedPhone , _blank); 
		SELF.HealthAttributesV3.PreviousAddress.PrevAddrAgeLastSale := IF(Config[1].SuppressPreviousAddress = false, le.PrevAddrAgeLastSale , _blank);
		SELF.HealthAttributesV3.PreviousAddress.PrevAddrAgeNewestRecord := IF(Config[1].SuppressPreviousAddress = false, le.PrevAddrAgeNewestRecord , _blank);
		SELF.HealthAttributesV3.PreviousAddress.PrevAddrAgeOldestRecord := IF(Config[1].SuppressPreviousAddress = false, le.PrevAddrAgeOldestRecord , _blank);
		SELF.HealthAttributesV3.PreviousAddress.PrevAddrApplicantOwned := IF(Config[1].SuppressPreviousAddress = false, le.PrevAddrApplicantOwned , _blank);
		SELF.HealthAttributesV3.PreviousAddress.PrevAddrAVMValue := IF(Config[1].SuppressPreviousAddress = false, le.PrevAddrAVMValue , _blank);
		SELF.HealthAttributesV3.PreviousAddress.PrevAddrBlockIndex := IF(Config[1].SuppressPreviousAddress = false, le.PrevAddrBlockIndex , _blank);
		SELF.HealthAttributesV3.PreviousAddress.PrevAddrBurglaryIndex := IF(Config[1].SuppressPreviousAddress = false, le.PrevAddrBurglaryIndex , _blank);
		SELF.HealthAttributesV3.PreviousAddress.PrevAddrCarTheftIndex := IF(Config[1].SuppressPreviousAddress = false, le.PrevAddrCarTheftIndex , _blank);
		SELF.HealthAttributesV3.PreviousAddress.PrevAddrCountyIndex := IF(Config[1].SuppressPreviousAddress = false, le.PrevAddrCountyIndex , _blank);
		SELF.HealthAttributesV3.PreviousAddress.PrevAddrCrimeIndex := IF(Config[1].SuppressPreviousAddress = false, le.PrevAddrCrimeIndex , _blank);
		SELF.HealthAttributesV3.PreviousAddress.PrevAddrDwellType := IF(Config[1].SuppressPreviousAddress = false, le.PrevAddrDwellType , _blank);
		SELF.HealthAttributesV3.PreviousAddress.PrevAddrFamilyOwned := IF(Config[1].SuppressPreviousAddress = false, le.PrevAddrFamilyOwned , _blank);
		SELF.HealthAttributesV3.PreviousAddress.PrevAddrLastSalesPrice := IF(Config[1].SuppressPreviousAddress = false, le.PrevAddrLastSalesPrice , _blank);
		SELF.HealthAttributesV3.PreviousAddress.PrevAddrLenOfRes := IF(Config[1].SuppressPreviousAddress = false, le.PrevAddrLenOfRes , _blank);
		SELF.HealthAttributesV3.PreviousAddress.PrevAddrMedianIncome := IF(Config[1].SuppressPreviousAddress = false, le.PrevAddrMedianIncome , _blank);
		SELF.HealthAttributesV3.PreviousAddress.PrevAddrMedianValue := IF(Config[1].SuppressPreviousAddress = false, le.PrevAddrMedianValue , _blank);
		SELF.HealthAttributesV3.PreviousAddress.PrevAddrMurderIndex := IF(Config[1].SuppressPreviousAddress = false, le.PrevAddrMurderIndex , _blank);
		SELF.HealthAttributesV3.PreviousAddress.PrevAddrOccupantOwned := IF(Config[1].SuppressPreviousAddress = false, le.PrevAddrOccupantOwned , _blank);
		SELF.HealthAttributesV3.PreviousAddress.PrevAddrTaxMarketValue := IF(Config[1].SuppressPreviousAddress = false, le.PrevAddrTaxMarketValue , _blank);
		SELF.HealthAttributesV3.PreviousAddress.PrevAddrTaxValue := IF(Config[1].SuppressPreviousAddress = false, le.PrevAddrTaxValue , _blank);
		SELF.HealthAttributesV3.PreviousAddress.PrevAddrTaxYr := IF(Config[1].SuppressPreviousAddress = false, le.PrevAddrTaxYr , _blank);
		SELF.HealthAttributesV3.PreviousAddress.PrevAddrTractIndex := IF(Config[1].SuppressPreviousAddress = false, le.PrevAddrTractIndex , _blank); 
		SELF.HealthAttributesV3.SubprimeRequests.SubPrimeOfferRequestCount := IF(Config[1].SuppressSubprimeRequests = false, le.SubPrimeOfferRequestCount , _blank);
		SELF.HealthAttributesV3.SubprimeRequests.SubPrimeOfferRequestCount12 := IF(Config[1].SuppressSubprimeRequests = false, le.SubPrimeOfferRequestCount12 , _blank);
		SELF.HealthAttributesV3.SubprimeRequests.SubPrimeOfferRequestCount24 := IF(Config[1].SuppressSubprimeRequests = false, le.SubPrimeOfferRequestCount24 , _blank);	
		SELF := [];
	END;

	Export PopulateScoresDS(CoreResults, Config, isReadmissionRequested, isMedicationAdherenceRequested, isMotivationRequested, isTotalCostRiskScoreRequested) := FUNCTIONMACRO
		
		iesp.healthcare_socio_indicators.t_SocioScore formatRS() := TRANSFORM
			SELF.Name := IF(isReadmissionRequested, 'ReadmissionProbability', _blank);
			SELF.Value := IF(isReadmissionRequested, CoreResults[1].SeRs_Score, 'N/A');
			SeRs_Score := (DECIMAL32_16)CoreResults[1].SeRs_Score;
			SELF.Category := MAP(CoreResults[1].SeRs_Score = 'N/A' => 'N/A',
	   								SeRs_Score < Config[1].ReadmissionScore_Category_2_Low AND isReadmissionRequested => '1',
	   								SeRs_Score < Config[1].ReadmissionScore_Category_3_Low AND isReadmissionRequested => '2',
	   								SeRs_Score < Config[1].ReadmissionScore_Category_4_Low AND isReadmissionRequested => '3',
	   								SeRs_Score < Config[1].ReadmissionScore_Category_5_Low AND isReadmissionRequested => '4',
	   								SeRs_Score >= Config[1].ReadmissionScore_Category_5_Low AND isReadmissionRequested => '5',
	   								'N/A');
			SELF.CareDrivers.High1 := CoreResults[1].RAR_Driver_Hi1;
			SELF.CareDrivers.High2 := CoreResults[1].RAR_Driver_Hi2;
			SELF.CareDrivers.High3 := CoreResults[1].RAR_Driver_Hi3;
			SELF.CareDrivers.Low1  := CoreResults[1].RAR_Driver_Lo1;
			SELF.CareDrivers.Low2  := CoreResults[1].RAR_Driver_Lo2;
			SELF.CareDrivers.Low3  := CoreResults[1].RAR_Driver_Lo3;
			SELF := [];
		END;
		ReadmissionScoreDS := dataset([formatRS()]);

		iesp.healthcare_socio_indicators.t_SocioScore formatMA() := TRANSFORM
			SELF.Name := IF(isMedicationAdherenceRequested, 'MedicationAdherenceRate', _blank);
			SELF.Value := IF(isMedicationAdherenceRequested, CoreResults[1].SeMA_Score, 'N/A');
			SeMA_Score := (DECIMAL32_16)CoreResults[1].SeMA_Score;
			SELF.Category := MAP(CoreResults[1].SeMA_Score = 'N/A' => 'N/A',
	   								SeMA_Score < Config[1].MedicationAdherenceScore_category_4_Low AND isMedicationAdherenceRequested => '5',
	   								SeMA_Score < Config[1].MedicationAdherenceScore_category_3_Low AND isMedicationAdherenceRequested => '4',
	   								SeMA_Score < Config[1].MedicationAdherenceScore_category_2_Low AND isMedicationAdherenceRequested => '3',
	   								SeMA_Score < Config[1].MedicationAdherenceScore_category_1_Low AND isMedicationAdherenceRequested => '2',
	   								SeMA_Score >= Config[1].MedicationAdherenceScore_category_1_Low AND isMedicationAdherenceRequested => '1',
	   								'N/A');
			SELF.CareDrivers.High1 := CoreResults[1].MA_Driver_Hi1;
			SELF.CareDrivers.High2 := CoreResults[1].MA_Driver_Hi2;
			SELF.CareDrivers.High3 := CoreResults[1].MA_Driver_Hi3;
			SELF.CareDrivers.Low1  := CoreResults[1].MA_Driver_Lo1;
			SELF.CareDrivers.Low2  := CoreResults[1].MA_Driver_Lo2;
			SELF.CareDrivers.Low3  := CoreResults[1].MA_Driver_Lo3;
			SELF := [];

		END;
		MedicationScoreDS := dataset([formatMA()]);
		
		iesp.healthcare_socio_indicators.t_SocioScore formatMO() := TRANSFORM
			SELF.Name := IF(isMotivationRequested, 'MotivationLevel', _blank);
			SELF.Value := IF(isMotivationRequested, CoreResults[1].SeMO_Score, 'N/A');
			SeMO_Score := (DECIMAL32_16)CoreResults[1].SeMO_Score;
			SELF.Category := MAP(CoreResults[1].SeMO_Score = 'N/A' => 'N/A',
	   								SeMO_Score < Config[1].MotivationScore_category_4_Low AND isMotivationRequested => '5',
	   								SeMO_Score < Config[1].MotivationScore_category_3_Low AND isMotivationRequested => '4',
	   								SeMO_Score < Config[1].MotivationScore_category_2_Low AND isMotivationRequested => '3',
	   								SeMO_Score < Config[1].MotivationScore_category_1_Low AND isMotivationRequested => '2',
	   								SeMO_Score >= Config[1].MotivationScore_category_1_Low AND isMotivationRequested => '1',
	   								'N/A');
			SELF.CareDrivers.High1 := CoreResults[1].MO_Driver_Hi1;
			SELF.CareDrivers.High2 := CoreResults[1].MO_Driver_Hi2;
			SELF.CareDrivers.High3 := CoreResults[1].MO_Driver_Hi3;
			SELF.CareDrivers.Low1  := CoreResults[1].MO_Driver_Lo1;
			SELF.CareDrivers.Low2  := CoreResults[1].MO_Driver_Lo2;
			SELF.CareDrivers.Low3  := CoreResults[1].MO_Driver_Lo3;
			SELF := [];
		END;
		MotivationScoreDS := dataset([formatMO()]);
		
		iesp.healthcare_socio_indicators.t_SocioScore formatTC() := TRANSFORM
			SELF.Name := IF(isTotalCostRiskScoreRequested, 'TotalCostRiskScore', _blank);
			SeTC_Score := (DECIMAL32_16)CoreResults[1].Score;
			SeTC_Score_Str := trim(CoreResults[1].Score, left, right);
			DECIMAL5_4 Socio_Index_Value := (DECIMAL5_4)(SeTC_Score/Config[1].TotalCostRiskScore_Index_Denominator);
			SELF.Index := IF(isTotalCostRiskScoreRequested, MAP(SeTC_Score_Str = 'N/A' => 'N/A', SeTC_Score_Str = _blank => _blank,(string)Socio_Index_Value), 'N/A');
			SELF.Rank := (string) MAP(
								SeTC_Score_Str = 'N/A' => 'N/A',
								SeTC_Score_Str = _blank => _blank,
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_1_Max  => '1',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_2_Max  => '2',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_3_Max  => '3',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_4_Max  => '4',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_5_Max  => '5',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_6_Max  => '6',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_7_Max  => '7',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_8_Max  => '8',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_9_Max  => '9',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_10_Max => '10',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_11_Max => '11',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_12_Max => '12',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_13_Max => '13',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_14_Max => '14',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_15_Max => '15',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_16_Max => '16',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_17_Max => '17',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_18_Max => '18',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_19_Max => '19',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_20_Max => '20',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_21_Max => '21',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_22_Max => '22',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_23_Max => '23',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_24_Max => '24',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_25_Max => '25',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_26_Max => '26',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_27_Max => '27',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_28_Max => '28',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_29_Max => '29',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_30_Max => '30',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_31_Max => '31',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_32_Max => '32',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_33_Max => '33',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_34_Max => '34',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_35_Max => '35',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_36_Max => '36',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_37_Max => '37',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_38_Max => '38',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_39_Max => '39',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_40_Max => '40',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_41_Max => '41',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_42_Max => '42',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_43_Max => '43',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_44_Max => '44',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_45_Max => '45',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_46_Max => '46',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_47_Max => '47',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_48_Max => '48',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_49_Max => '49',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_50_Max => '50',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_51_Max => '51',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_52_Max => '52',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_53_Max => '53',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_54_Max => '54',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_55_Max => '55',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_56_Max => '56',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_57_Max => '57',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_58_Max => '58',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_59_Max => '59',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_60_Max => '60',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_61_Max => '61',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_62_Max => '62',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_63_Max => '63',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_64_Max => '64',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_65_Max => '65',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_66_Max => '66',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_67_Max => '67',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_68_Max => '68',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_69_Max => '69',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_70_Max => '70',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_71_Max => '71',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_72_Max => '72',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_73_Max => '73',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_74_Max => '74',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_75_Max => '75',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_76_Max => '76',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_77_Max => '77',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_78_Max => '78',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_79_Max => '79',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_80_Max => '80',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_81_Max => '81',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_82_Max => '82',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_83_Max => '83',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_84_Max => '84',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_85_Max => '85',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_86_Max => '86',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_87_Max => '87',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_88_Max => '88',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_89_Max => '89',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_90_Max => '90',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_91_Max => '91',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_92_Max => '92',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_93_Max => '93',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_94_Max => '94',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_95_Max => '95',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_96_Max => '96',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_97_Max => '97',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_98_Max => '98',
								SeTC_Score < Config[1].TotalCostRiskScore_Rank_99_Max => '99',
								SeTC_Score >= Config[1].TotalCostRiskScore_Rank_99_Max => '100',
								'N/A');
			SELF.Category := MAP(SeTC_Score_Str = 'N/A' => 'N/A',
								SeTC_Score_Str = _blank => _blank,
   								SeTC_Score  < Config[1].TotalCostRiskScore_Category_2_Low => '1',
   								SeTC_Score  < Config[1].TotalCostRiskScore_Category_3_Low => '2',
   								SeTC_Score  < Config[1].TotalCostRiskScore_Category_4_Low => '3',
   								SeTC_Score  < Config[1].TotalCostRiskScore_Category_5_Low => '4',
   								SeTC_Score >= Config[1].TotalCostRiskScore_Category_5_Low => '5',
								'N/A');
			SELF.CareDrivers.High1 := CoreResults[1].TC_Driver_Hi1;
			SELF.CareDrivers.High2 := CoreResults[1].TC_Driver_Hi2;
			SELF.CareDrivers.High3 := CoreResults[1].TC_Driver_Hi3;
			SELF.CareDrivers.Low1  := CoreResults[1].TC_Driver_Lo1;
			SELF.CareDrivers.Low2  := CoreResults[1].TC_Driver_Lo2;
			SELF.CareDrivers.Low3  := CoreResults[1].TC_Driver_Lo3;
			SELF := [];
		END;
		TotalCostRiskScoreDS := dataset([formatTC()]);
		
		ScoresDS := ReadmissionScoreDS + MedicationScoreDS + MotivationScoreDS + TotalCostRiskScoreDS;
		return ScoresDS(Name<>_blank);
	ENDMACRO;

	Export PopulateInvalidsDS(coreResults, Admit_date_cln, isReadmissionRequested, isTotalCostRiskScoreRequested) := FUNCTIONMACRO
		InvalidsEmptyDS := DATASET([{_blank, _blank, _blank}], iesp.healthcare_socio_indicators.t_SocioInvalidField);
		_EmptyRow := ROW({_blank, _blank, _blank}, iesp.healthcare_socio_indicators.t_SocioInvalidField);
		InvalidAdmitDate := IF(Admit_date_cln = _blank, ROW({Models.Healthcare_Constants_RT_Service.InvalidAdmitDate_FieldName, Models.Healthcare_Constants_RT_Service.InvalidAdmitDate_Code, Models.Healthcare_Constants_RT_Service.InvalidAdmitDate_Message}, iesp.healthcare_socio_indicators.t_SocioInvalidField), _EmptyRow);
		InvalidPatientType := IF((INTEGER)CoreResults[1].isSeRsInvalidPatientType = 1, ROW({Models.Healthcare_Constants_RT_Service.InvalidPatientType_FieldName, Models.Healthcare_Constants_RT_Service.InvalidPatientType_Code, Models.Healthcare_Constants_RT_Service.InvalidPatientType_Message}, iesp.healthcare_socio_indicators.t_SocioInvalidField), _EmptyRow);
		InvalidFinancialClass := IF((INTEGER)CoreResults[1].isSeRsInvalidFinancialClass = 1, ROW({Models.Healthcare_Constants_RT_Service.InvalidFinancialClass_FieldName, Models.Healthcare_Constants_RT_Service.InvalidFinancialClass_Code, Models.Healthcare_Constants_RT_Service.InvalidFinancialClass_Message}, iesp.healthcare_socio_indicators.t_SocioInvalidField), _EmptyRow);
		InvalidDiagnosisCode := IF((INTEGER)CoreResults[1].isSeRsInvalidDiag = 1, ROW({Models.Healthcare_Constants_RT_Service.InvalidDiagnosisCode_FieldName, Models.Healthcare_Constants_RT_Service.InvalidDiagnosisCode_Code, Models.Healthcare_Constants_RT_Service.InvalidDiagnosisCode_Message}, iesp.healthcare_socio_indicators.t_SocioInvalidField), _EmptyRow);
		InvalidsDS := InvalidsEmptyDS + InvalidAdmitDate + InvalidPatientType + InvalidFinancialClass + InvalidDiagnosisCode;
		readmission_resultDS := IF(isReadmissionRequested,InvalidsDS, InvalidsEmptyDS);
		InvalidLOB := IF( isTotalCostRiskScoreRequested AND ((INTEGER)CoreResults[1].isSeTCInvalidLOB = 1), ROW({Models.Healthcare_Constants_RT_Service.InvalidLOB_FieldName, Models.Healthcare_Constants_RT_Service.InvalidLOB_Code, Models.Healthcare_Constants_RT_Service.InvalidLOB_Message}, iesp.healthcare_socio_indicators.t_SocioInvalidField), _EmptyRow);
		resultDS := readmission_resultDS + InvalidLOB;
		return resultDS(FieldName<>_blank);
	ENDMACRO;

	Export BuildMinInputErrorsDS(Cleaned_Input) := FUNCTIONMACRO

		EmptyExceptionDS := DATASET([], iesp.share.t_WsException);
		_EmptyExceptionDSRow := ROW({_blank, 0, _blank, _blank}, iesp.share.t_WsException);
		//Check for rejects
		Cleaned_Member_Input := Cleaned_Input[1];
		Name_First := Cleaned_Member_Input.Name_First;
		Name_Last := Cleaned_Member_Input.Name_Last;
		street_addr := Cleaned_Member_Input.street_addr;
		p_City_name := Cleaned_Member_Input.p_City_name;
		ST_Cln := Cleaned_Member_Input.ST_Cln;
		Z5_Cln := Cleaned_Member_Input.Z5_Cln;
		DOB_Cln := Cleaned_Member_Input.DOB_Cln;
		MemberGender_Cln := Cleaned_Member_Input.MemberGender_Cln;
		SSN_Cln := Cleaned_Member_Input.SSN_Cln;
		Admit_date_cln := Cleaned_Member_Input.Admit_date_cln;
		isMinor:= IF(Cleaned_Member_Input.Age<18,TRUE,FALSE);

		Met_MinInput_Condition_1 := IF(SSN_Cln<>_blank AND MemberGender_Cln<>_blank AND DOB_Cln<>_blank AND ST_Cln<>_blank,TRUE, FALSE);
		//Met_MinInput_Condition_1;
		Met_MinInput_Condition_2 := IF(Name_First<>_blank AND Name_Last<>_blank AND street_addr<>_blank AND p_City_name<>_blank AND Z5_Cln<>_blank AND MemberGender_Cln <>_blank AND DOB_Cln <>_blank AND ST_Cln<>_blank,TRUE, FALSE);
		//Met_MinInput_Condition_2;

		Name_First_Rej_Row := IF(Name_First<>_blank, _EmptyExceptionDSRow, ROW({_blank, Models.Healthcare_Constants_RT_Service.Name_First_Rej_Code , _blank, Models.Healthcare_Constants_RT_Service.Name_First_Rej_Message}, iesp.share.t_WsException));
		Name_Last_Rej_Row := IF(Name_Last<>_blank,_EmptyExceptionDSRow, ROW({_blank, Models.Healthcare_Constants_RT_Service.Name_Last_Rej_Code , _blank, Models.Healthcare_Constants_RT_Service.Name_Last_Rej_Message}, iesp.share.t_WsException));
		street_addr_Rej_Row := IF(street_addr<>_blank,_EmptyExceptionDSRow, ROW({_blank, Models.Healthcare_Constants_RT_Service.street_addr_Rej_Code , _blank, Models.Healthcare_Constants_RT_Service.street_addr_Rej_Message}, iesp.share.t_WsException));
		p_City_name_Rej_Row := IF(p_City_name<>_blank,_EmptyExceptionDSRow, ROW({_blank, Models.Healthcare_Constants_RT_Service.p_City_name_Rej_Code , _blank, Models.Healthcare_Constants_RT_Service.p_City_name_Rej_Message}, iesp.share.t_WsException));
		ST_name_Rej_Row := IF(ST_Cln<>_blank,_EmptyExceptionDSRow, ROW({_blank, Models.Healthcare_Constants_RT_Service.ST_name_Rej_Code , _blank, Models.Healthcare_Constants_RT_Service.ST_name_Rej_Message}, iesp.share.t_WsException));
		Z5_Rej_Row := IF(Z5_Cln<>_blank,_EmptyExceptionDSRow, ROW({_blank, Models.Healthcare_Constants_RT_Service.Z5_Rej_Code , _blank, Models.Healthcare_Constants_RT_Service.Z5_Rej_Message}, iesp.share.t_WsException));
		DOB_Rej_Row := IF(DOB_Cln<>_blank,_EmptyExceptionDSRow, ROW({_blank, Models.Healthcare_Constants_RT_Service.DOB_Rej_Code , _blank, Models.Healthcare_Constants_RT_Service.DOB_Rej_Message}, iesp.share.t_WsException));
		MemberGender_Rej_Row := IF(MemberGender_Cln<>_blank,_EmptyExceptionDSRow, ROW({_blank, Models.Healthcare_Constants_RT_Service.MemberGender_Rej_Code , _blank, Models.Healthcare_Constants_RT_Service.MemberGender_Rej_Message}, iesp.share.t_WsException));
		SSN_Rej_Row := IF(SSN_Cln<>_blank,_EmptyExceptionDSRow, ROW({_blank, Models.Healthcare_Constants_RT_Service.SSN_Rej_Code , _blank, Models.Healthcare_Constants_RT_Service.SSN_Rej_Message}, iesp.share.t_WsException));

		Condition_1_Reject_DS := EmptyExceptionDS + SSN_Rej_Row + MemberGender_Rej_Row + DOB_Rej_Row + ST_name_Rej_Row;
		// Condition_1_Reject_DS;
		Condition_2_Reject_DS := EmptyExceptionDS + Name_First_Rej_Row + Name_Last_Rej_Row + street_addr_Rej_Row + p_City_name_Rej_Row+ Z5_Rej_Row + MemberGender_Rej_Row + DOB_Rej_Row + ST_name_Rej_Row;
		// Condition_2_Reject_DS;
		Condition_1_2_Reject_DS := IF(Met_MinInput_Condition_1 = TRUE or Met_MinInput_Condition_2 = TRUE, EmptyExceptionDS,IF(Met_MinInput_Condition_2 = FALSE AND Cleaned_Member_Input.SSN_in=_blank, Condition_2_Reject_DS,IF(Met_MinInput_Condition_2 = TRUE AND Met_MinInput_Condition_1 = FALSE, EmptyExceptionDS,Condition_1_Reject_DS)));
		//Condition_1_2_Reject_DS;
		Output_Condition_1_2_Reject_DS := IF(COUNT(Condition_1_2_Reject_DS(code<>0)) > 0, Condition_1_2_Reject_DS(code<>0), EmptyExceptionDS);

		Minor_Rej_Row := IF(COUNT(Condition_1_2_Reject_DS(code<>0)) < 1 AND isMinor, ROW({_blank, Models.Healthcare_Constants_RT_Service.Minor_Rej_Code, _blank, Models.Healthcare_Constants_RT_Service.Minor_Rej_Message}, iesp.share.t_WsException), _EmptyExceptionDSRow);
		Minor_Rej_DS := EmptyExceptionDS + Minor_Rej_Row;
		Output_Condition_1_2_Minor_Reject_DS := Output_Condition_1_2_Reject_DS + Minor_Rej_DS;
		return Output_Condition_1_2_Minor_Reject_DS(code<>0);
	ENDMACRO;

	Export BuildPermissiblePurposeErrorsDS(GLBPurpose_in, GLBPurpose_usage_string, DPPAPurpose_in) := FUNCTIONMACRO
		EmptyExceptionDS1 := DATASET([], iesp.share.t_WsException);
		_EmptyExceptionDSRow1 := ROW({_blank, 0, _blank, _blank}, iesp.share.t_WsException);

		GLBRequiredFailRow := IF(GLBPurpose_in = 0, ROW({_blank, Models.Healthcare_Constants_RT_Service.InvalidInput_Code, _blank, Models.Healthcare_Constants_RT_Service.GLBRequiredFail_Message}, iesp.share.t_WsException), _EmptyExceptionDSRow1);

		RiskControl := (UNSIGNED) IF(GLBPurpose_usage_string[13..14] = Models.Healthcare_Constants_RT_Service.usage_GLB_Value, Models.Healthcare_Constants_RT_Service.authorized_GLBA, 0);
		// Exception#5
		GLBInvalidFailRow := IF( (GLBPurpose_in<>0) AND (GLBPurpose_in <> RiskControl), ROW({_blank, Models.Healthcare_Constants_RT_Service.InvalidInput_Code, _blank, Models.Healthcare_Constants_RT_Service.GLBInvalidFail_Message}, iesp.share.t_WsException), _EmptyExceptionDSRow1);

		DPPAInvalidFailRow := IF(DPPAPurpose_in <> 0, ROW({_blank, Models.Healthcare_Constants_RT_Service.InvalidInput_Code, _blank, Models.Healthcare_Constants_RT_Service.DPPAInvalidFail_Message}, iesp.share.t_WsException), _EmptyExceptionDSRow1);

		Output_PermissiblePurposeErrorsDS := EmptyExceptionDS1 + GLBRequiredFailRow + GLBInvalidFailRow + DPPAInvalidFailRow;

		return Output_PermissiblePurposeErrorsDS(code<>0);
	ENDMACRO;


END;
