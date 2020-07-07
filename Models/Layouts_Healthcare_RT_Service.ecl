﻿Import Models;
Import Profilebooster;
Import iesp;

EXPORT Layouts_Healthcare_RT_Service := module 
	EXPORT Layout_SocioEconomic_Data_In := RECORD unsigned4 seq;
		STRING30 AcctNo;
		STRING15 SSN_in;
		STRING120 unParsedFullName := '';
		STRING30 Name_First;
		STRING30 Name_Middle;
		STRING30 Name_Last;
		STRING5 Name_Suffix;
		STRING8 DOB_in;
		STRING65 street_addr := '';
		STRING25 p_City_name;
		STRING5 St_in;
		STRING10 ZIP_in;
		STRING20 DL_Number;
		STRING2 DL_State;
		STRING20 Home_Phone_in;
		STRING20 Work_Phone_in;
		string10 MemberGENDer_in := '';
		unsigned6 DID := 0;
		STRING8 ADMIT_DATE_in;
		STRING15 ADMIT_DIAGNOSIS_CODE; 
		STRING6 FINANCIAL_CLASS;
		STRING5 PATIENT_TYPE;
		unsigned3 HistorydateYYYYMM := 999999;
		STRING2 LOB;
	END;
	EXPORT Layout_SocioEconomic_Data_Cln := RECORD 
		Layout_SocioEconomic_Data_In;
		REAL8 Age   := 0.000;
		STRING9 SSN_Cln;
		STRING8 DOB_Cln;
		STRING2 ST_Cln;
		STRING5 Z5_Cln;
		STRING10 Home_Phone_Cln;
		STRING10 Work_Phone_Cln;
		STRING8 ADMIT_DATE_Cln;
		string1 MemberGENDer_Cln;
	END;

	export ScoresDSFromCore := RECORD
	unsigned4 seq;
	iesp.healthcare_socio_indicators.t_SocioScore;
	END;

	export IndicatorsDSwithSeq := RECORD
	unsigned4 seq;
	iesp.healthcare_socio_indicators.t_SocioIndicators
	END;

	export common_runtime_config := record
			unsigned1 cfg_Version := 0;

			string14 ReferenceNumber :='';
			string16 TransactionId :='';
			string10 GlobalCompanyId :='';

			string50 ProductKey := '';

			//Subscription Settings
			Boolean SubscribedToReadmissionScore := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SubscribedToHealthAttributesV3 := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SubscribedToMedicationAdherenceScore := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SubscribedToMotivationScore := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SubscribedToTotalCostRiskScore := Healthcare_Constants_RT_Service.CFG_False;
			
			//Attribute group suppression settings
			Boolean SuppressAccident := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressAddressStability := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressAsset := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressCurrentAddress := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressDemographics := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressDerogatoryRecord := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressDerogatoryCrimeRecord := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressDerogatoryFinancialRecord := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressEducation := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressIdentityActivity := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressIdentityAssociation := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressIdentityFraudRisk := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressIdentityProductSearchEvent := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressIdentityValidation := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressIdentityVariation := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressIncome := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressInputAddress := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressInputSSN := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressInterests := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressMostRecentAddress := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressNonDerogatoryRecord := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressNonDerogatoryOccupationalRecord := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressPhone := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressPreviousAddress := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressSubprimeRequests := Healthcare_Constants_RT_Service.CFG_False;

			//The thresholds for Socio Readmission Category Calculation are set to default values here
			DECIMAL7_4 ReadmissionScore_Category_5_High	:= 100 ;
			DECIMAL7_4 ReadmissionScore_Category_5_Low	:= 34.8015 ;
			DECIMAL7_4 ReadmissionScore_Category_4_High	:= 34.8014 ;
			DECIMAL7_4 ReadmissionScore_Category_4_Low	:= 16.3241 ;
			DECIMAL7_4 ReadmissionScore_Category_3_High	:= 16.3240 ;
			DECIMAL7_4 ReadmissionScore_Category_3_Low	:= 12.2211 ;
			DECIMAL7_4 ReadmissionScore_Category_2_High	:= 12.2210 ;
			DECIMAL7_4 ReadmissionScore_Category_2_Low	:= 8.5245 ;
			DECIMAL7_4 ReadmissionScore_Category_1_High	:= 8.5244 ;
			DECIMAL7_4 ReadmissionScore_Category_1_Low	:= 0 ;

			DECIMAL7_4 MedicationAdherenceScore_Category_5_High	:= 37.5323 ;
			DECIMAL7_4 MedicationAdherenceScore_Category_5_Low	:= 0 ;
			DECIMAL7_4 MedicationAdherenceScore_Category_4_High	:= 64.3456 ;
			DECIMAL7_4 MedicationAdherenceScore_Category_4_Low	:= 37.5324 ;
			DECIMAL7_4 MedicationAdherenceScore_Category_3_High	:= 74.2270 ;
			DECIMAL7_4 MedicationAdherenceScore_Category_3_Low	:= 64.3457 ;
			DECIMAL7_4 MedicationAdherenceScore_Category_2_High	:= 79.9234 ;
			DECIMAL7_4 MedicationAdherenceScore_Category_2_Low	:= 74.2271 ;
			DECIMAL7_4 MedicationAdherenceScore_Category_1_High	:= 100 ;
			DECIMAL7_4 MedicationAdherenceScore_Category_1_Low	:= 79.9235 ;

			DECIMAL7_4 MotivationScore_Category_5_High	:= 37.5323 ;
			DECIMAL7_4 MotivationScore_Category_5_Low	:= 0 ;
			DECIMAL7_4 MotivationScore_Category_4_High	:= 64.3456 ;
			DECIMAL7_4 MotivationScore_Category_4_Low	:= 37.5324 ;
			DECIMAL7_4 MotivationScore_Category_3_High	:= 74.2270 ;
			DECIMAL7_4 MotivationScore_Category_3_Low	:= 64.3457 ;
			DECIMAL7_4 MotivationScore_Category_2_High	:= 79.9234 ;
			DECIMAL7_4 MotivationScore_Category_2_Low	:= 74.2271 ;
			DECIMAL7_4 MotivationScore_Category_1_High	:= 100 ;
			DECIMAL7_4 MotivationScore_Category_1_Low	:= 79.9235 ;

			decimal8_4 TotalCostRiskScore_Index_Denominator := 530;

			decimal8_4 TotalCostRiskScore_Rank_1_Min  :=  0;
			decimal8_4 TotalCostRiskScore_Rank_1_Max  :=  129.3776;
			decimal8_4 TotalCostRiskScore_Rank_2_Min  :=  129.3776;
			decimal8_4 TotalCostRiskScore_Rank_2_Max  :=  143.4159;
			decimal8_4 TotalCostRiskScore_Rank_3_Min  :=  143.4159;
			decimal8_4 TotalCostRiskScore_Rank_3_Max  :=  155.1092;
			decimal8_4 TotalCostRiskScore_Rank_4_Min  :=  155.1092;
			decimal8_4 TotalCostRiskScore_Rank_4_Max  :=  166.0482;
			decimal8_4 TotalCostRiskScore_Rank_5_Min  :=  166.0482;
			decimal8_4 TotalCostRiskScore_Rank_5_Max  :=  176.3608;
			decimal8_4 TotalCostRiskScore_Rank_6_Min  :=  176.3608;
			decimal8_4 TotalCostRiskScore_Rank_6_Max  :=  186.0209;
			decimal8_4 TotalCostRiskScore_Rank_7_Min  :=  186.0209;
			decimal8_4 TotalCostRiskScore_Rank_7_Max  :=  194.8772;
			decimal8_4 TotalCostRiskScore_Rank_8_Min  :=  194.8772;
			decimal8_4 TotalCostRiskScore_Rank_8_Max  :=  203.2709;
			decimal8_4 TotalCostRiskScore_Rank_9_Min  :=  203.2709;
			decimal8_4 TotalCostRiskScore_Rank_9_Max  :=  211.2198;
			decimal8_4 TotalCostRiskScore_Rank_10_Min   :=  211.2198;
			decimal8_4 TotalCostRiskScore_Rank_10_Max   :=  218.7865;
			decimal8_4 TotalCostRiskScore_Rank_11_Min   :=  218.7865;
			decimal8_4 TotalCostRiskScore_Rank_11_Max   :=  226.0378;
			decimal8_4 TotalCostRiskScore_Rank_12_Min   :=  226.0378;
			decimal8_4 TotalCostRiskScore_Rank_12_Max   :=  233.1968;
			decimal8_4 TotalCostRiskScore_Rank_13_Min   :=  233.1968;
			decimal8_4 TotalCostRiskScore_Rank_13_Max   :=  239.9056;
			decimal8_4 TotalCostRiskScore_Rank_14_Min   :=  239.9056;
			decimal8_4 TotalCostRiskScore_Rank_14_Max   :=  246.685;
			decimal8_4 TotalCostRiskScore_Rank_15_Min   :=  246.685;
			decimal8_4 TotalCostRiskScore_Rank_15_Max   :=  253.2672;
			decimal8_4 TotalCostRiskScore_Rank_16_Min   :=  253.2672;
			decimal8_4 TotalCostRiskScore_Rank_16_Max   :=  259.8008;
			decimal8_4 TotalCostRiskScore_Rank_17_Min   :=  259.8008;
			decimal8_4 TotalCostRiskScore_Rank_17_Max   :=  266.1071;
			decimal8_4 TotalCostRiskScore_Rank_18_Min   :=  266.1071;
			decimal8_4 TotalCostRiskScore_Rank_18_Max   :=  272.1643;
			decimal8_4 TotalCostRiskScore_Rank_19_Min   :=  272.1643;
			decimal8_4 TotalCostRiskScore_Rank_19_Max   :=  278.3686;
			decimal8_4 TotalCostRiskScore_Rank_20_Min   :=  278.3686;
			decimal8_4 TotalCostRiskScore_Rank_20_Max   :=  284.0939;
			decimal8_4 TotalCostRiskScore_Rank_21_Min   :=  284.0939;
			decimal8_4 TotalCostRiskScore_Rank_21_Max   :=  289.903;
			decimal8_4 TotalCostRiskScore_Rank_22_Min   :=  289.903;
			decimal8_4 TotalCostRiskScore_Rank_22_Max   :=  295.5365;
			decimal8_4 TotalCostRiskScore_Rank_23_Min   :=  295.5365;
			decimal8_4 TotalCostRiskScore_Rank_23_Max   :=  300.9614;
			decimal8_4 TotalCostRiskScore_Rank_24_Min   :=  300.9614;
			decimal8_4 TotalCostRiskScore_Rank_24_Max   :=  306.2125;
			decimal8_4 TotalCostRiskScore_Rank_25_Min   :=  306.2125;
			decimal8_4 TotalCostRiskScore_Rank_25_Max   :=  311.1476;
			decimal8_4 TotalCostRiskScore_Rank_26_Min   :=  311.1476;
			decimal8_4 TotalCostRiskScore_Rank_26_Max   :=  316.1518;
			decimal8_4 TotalCostRiskScore_Rank_27_Min   :=  316.1518;
			decimal8_4 TotalCostRiskScore_Rank_27_Max   :=  321.0229;
			decimal8_4 TotalCostRiskScore_Rank_28_Min   :=  321.0229;
			decimal8_4 TotalCostRiskScore_Rank_28_Max   :=  325.7663;
			decimal8_4 TotalCostRiskScore_Rank_29_Min   :=  325.7663;
			decimal8_4 TotalCostRiskScore_Rank_29_Max   :=  330.5088;
			decimal8_4 TotalCostRiskScore_Rank_30_Min   :=  330.5088;
			decimal8_4 TotalCostRiskScore_Rank_30_Max   :=  335.2882;
			decimal8_4 TotalCostRiskScore_Rank_31_Min   :=  335.2882;
			decimal8_4 TotalCostRiskScore_Rank_31_Max   :=  340.0515;
			decimal8_4 TotalCostRiskScore_Rank_32_Min   :=  340.0515;
			decimal8_4 TotalCostRiskScore_Rank_32_Max   :=  344.786;
			decimal8_4 TotalCostRiskScore_Rank_33_Min   :=  344.786;
			decimal8_4 TotalCostRiskScore_Rank_33_Max   :=  349.5777;
			decimal8_4 TotalCostRiskScore_Rank_34_Min   :=  349.5777;
			decimal8_4 TotalCostRiskScore_Rank_34_Max   :=  354.4521;
			decimal8_4 TotalCostRiskScore_Rank_35_Min   :=  354.4521;
			decimal8_4 TotalCostRiskScore_Rank_35_Max   :=  359.3623;
			decimal8_4 TotalCostRiskScore_Rank_36_Min   :=  359.3623;
			decimal8_4 TotalCostRiskScore_Rank_36_Max   :=  364.3837;
			decimal8_4 TotalCostRiskScore_Rank_37_Min   :=  364.3837;
			decimal8_4 TotalCostRiskScore_Rank_37_Max   :=  369.4344;
			decimal8_4 TotalCostRiskScore_Rank_38_Min   :=  369.4344;
			decimal8_4 TotalCostRiskScore_Rank_38_Max   :=  374.6674;
			decimal8_4 TotalCostRiskScore_Rank_39_Min   :=  374.6674;
			decimal8_4 TotalCostRiskScore_Rank_39_Max   :=  380.0801;
			decimal8_4 TotalCostRiskScore_Rank_40_Min   :=  380.0801;
			decimal8_4 TotalCostRiskScore_Rank_40_Max   :=  385.6315;
			decimal8_4 TotalCostRiskScore_Rank_41_Min   :=  385.6315;
			decimal8_4 TotalCostRiskScore_Rank_41_Max   :=  391.3626;
			decimal8_4 TotalCostRiskScore_Rank_42_Min   :=  391.3626;
			decimal8_4 TotalCostRiskScore_Rank_42_Max   :=  397.1935;
			decimal8_4 TotalCostRiskScore_Rank_43_Min   :=  397.1935;
			decimal8_4 TotalCostRiskScore_Rank_43_Max   :=  403.3876;
			decimal8_4 TotalCostRiskScore_Rank_44_Min   :=  403.3876;
			decimal8_4 TotalCostRiskScore_Rank_44_Max   :=  409.7142;
			decimal8_4 TotalCostRiskScore_Rank_45_Min   :=  409.7142;
			decimal8_4 TotalCostRiskScore_Rank_45_Max   :=  416.2117;
			decimal8_4 TotalCostRiskScore_Rank_46_Min   :=  416.2117;
			decimal8_4 TotalCostRiskScore_Rank_46_Max   :=  422.7663;
			decimal8_4 TotalCostRiskScore_Rank_47_Min   :=  422.7663;
			decimal8_4 TotalCostRiskScore_Rank_47_Max   :=  429.4557;
			decimal8_4 TotalCostRiskScore_Rank_48_Min   :=  429.4557;
			decimal8_4 TotalCostRiskScore_Rank_48_Max   :=  436.1971;
			decimal8_4 TotalCostRiskScore_Rank_49_Min   :=  436.1971;
			decimal8_4 TotalCostRiskScore_Rank_49_Max   :=  443.0577;
			decimal8_4 TotalCostRiskScore_Rank_50_Min   :=  443.0577;
			decimal8_4 TotalCostRiskScore_Rank_50_Max   :=  450;
			decimal8_4 TotalCostRiskScore_Rank_51_Min   :=  450;
			decimal8_4 TotalCostRiskScore_Rank_51_Max   :=  459.2239;
			decimal8_4 TotalCostRiskScore_Rank_52_Min   :=  459.2239;
			decimal8_4 TotalCostRiskScore_Rank_52_Max   :=  468.5261;
			decimal8_4 TotalCostRiskScore_Rank_53_Min   :=  468.5261;
			decimal8_4 TotalCostRiskScore_Rank_53_Max   :=  477.5785;
			decimal8_4 TotalCostRiskScore_Rank_54_Min   :=  477.5785;
			decimal8_4 TotalCostRiskScore_Rank_54_Max   :=  487.053;
			decimal8_4 TotalCostRiskScore_Rank_55_Min   :=  487.053;
			decimal8_4 TotalCostRiskScore_Rank_55_Max   :=  496.551;
			decimal8_4 TotalCostRiskScore_Rank_56_Min   :=  496.551;
			decimal8_4 TotalCostRiskScore_Rank_56_Max   :=  505.9119;
			decimal8_4 TotalCostRiskScore_Rank_57_Min   :=  505.9119;
			decimal8_4 TotalCostRiskScore_Rank_57_Max   :=  515.5209;
			decimal8_4 TotalCostRiskScore_Rank_58_Min   :=  515.5209;
			decimal8_4 TotalCostRiskScore_Rank_58_Max   :=  525.1428;
			decimal8_4 TotalCostRiskScore_Rank_59_Min   :=  525.1428;
			decimal8_4 TotalCostRiskScore_Rank_59_Max   :=  534.7945;
			decimal8_4 TotalCostRiskScore_Rank_60_Min   :=  534.7945;
			decimal8_4 TotalCostRiskScore_Rank_60_Max   :=  544.3339;
			decimal8_4 TotalCostRiskScore_Rank_61_Min   :=  544.3339;
			decimal8_4 TotalCostRiskScore_Rank_61_Max   :=  554.0194;
			decimal8_4 TotalCostRiskScore_Rank_62_Min   :=  554.0194;
			decimal8_4 TotalCostRiskScore_Rank_62_Max   :=  563.878;
			decimal8_4 TotalCostRiskScore_Rank_63_Min   :=  563.878;
			decimal8_4 TotalCostRiskScore_Rank_63_Max   :=  573.827;
			decimal8_4 TotalCostRiskScore_Rank_64_Min   :=  573.827;
			decimal8_4 TotalCostRiskScore_Rank_64_Max   :=  584.0587;
			decimal8_4 TotalCostRiskScore_Rank_65_Min   :=  584.0587;
			decimal8_4 TotalCostRiskScore_Rank_65_Max   :=  594.3331;
			decimal8_4 TotalCostRiskScore_Rank_66_Min   :=  594.3331;
			decimal8_4 TotalCostRiskScore_Rank_66_Max   :=  604.7218;
			decimal8_4 TotalCostRiskScore_Rank_67_Min   :=  604.7218;
			decimal8_4 TotalCostRiskScore_Rank_67_Max   :=  615.5255;
			decimal8_4 TotalCostRiskScore_Rank_68_Min   :=  615.5255;
			decimal8_4 TotalCostRiskScore_Rank_68_Max   :=  626.8517;
			decimal8_4 TotalCostRiskScore_Rank_69_Min   :=  626.8517;
			decimal8_4 TotalCostRiskScore_Rank_69_Max   :=  638.2721;
			decimal8_4 TotalCostRiskScore_Rank_70_Min   :=  638.2721;
			decimal8_4 TotalCostRiskScore_Rank_70_Max   :=  650;
			decimal8_4 TotalCostRiskScore_Rank_71_Min   :=  650;
			decimal8_4 TotalCostRiskScore_Rank_71_Max   :=  660.0996;
			decimal8_4 TotalCostRiskScore_Rank_72_Min   :=  660.0996;
			decimal8_4 TotalCostRiskScore_Rank_72_Max   :=  670.1986;
			decimal8_4 TotalCostRiskScore_Rank_73_Min   :=  670.1986;
			decimal8_4 TotalCostRiskScore_Rank_73_Max   :=  680.908;
			decimal8_4 TotalCostRiskScore_Rank_74_Min   :=  680.908;
			decimal8_4 TotalCostRiskScore_Rank_74_Max   :=  692.0547;
			decimal8_4 TotalCostRiskScore_Rank_75_Min   :=  692.0547;
			decimal8_4 TotalCostRiskScore_Rank_75_Max   :=  703.3375;
			decimal8_4 TotalCostRiskScore_Rank_76_Min   :=  703.3375;
			decimal8_4 TotalCostRiskScore_Rank_76_Max   :=  715.1982;
			decimal8_4 TotalCostRiskScore_Rank_77_Min   :=  715.1982;
			decimal8_4 TotalCostRiskScore_Rank_77_Max   :=  727.4738;
			decimal8_4 TotalCostRiskScore_Rank_78_Min   :=  727.4738;
			decimal8_4 TotalCostRiskScore_Rank_78_Max   :=  740.3047;
			decimal8_4 TotalCostRiskScore_Rank_79_Min   :=  740.3047;
			decimal8_4 TotalCostRiskScore_Rank_79_Max   :=  753.5309;
			decimal8_4 TotalCostRiskScore_Rank_80_Min   :=  753.5309;
			decimal8_4 TotalCostRiskScore_Rank_80_Max   :=  767.7548;
			decimal8_4 TotalCostRiskScore_Rank_81_Min   :=  767.7548;
			decimal8_4 TotalCostRiskScore_Rank_81_Max   :=  782.7238;
			decimal8_4 TotalCostRiskScore_Rank_82_Min   :=  782.7238;
			decimal8_4 TotalCostRiskScore_Rank_82_Max   :=  798.3024;
			decimal8_4 TotalCostRiskScore_Rank_83_Min   :=  798.3024;
			decimal8_4 TotalCostRiskScore_Rank_83_Max   :=  814.6407;
			decimal8_4 TotalCostRiskScore_Rank_84_Min   :=  814.6407;
			decimal8_4 TotalCostRiskScore_Rank_84_Max   :=  831.9156;
			decimal8_4 TotalCostRiskScore_Rank_85_Min   :=  831.9156;
			decimal8_4 TotalCostRiskScore_Rank_85_Max   :=  850;
			decimal8_4 TotalCostRiskScore_Rank_86_Min   :=  850;
			decimal8_4 TotalCostRiskScore_Rank_86_Max   :=  869.9869;
			decimal8_4 TotalCostRiskScore_Rank_87_Min   :=  869.9869;
			decimal8_4 TotalCostRiskScore_Rank_87_Max   :=  890.6728;
			decimal8_4 TotalCostRiskScore_Rank_88_Min   :=  890.6728;
			decimal8_4 TotalCostRiskScore_Rank_88_Max   :=  911.7299;
			decimal8_4 TotalCostRiskScore_Rank_89_Min   :=  911.7299;
			decimal8_4 TotalCostRiskScore_Rank_89_Max   :=  934.3174;
			decimal8_4 TotalCostRiskScore_Rank_90_Min   :=  934.3174;
			decimal8_4 TotalCostRiskScore_Rank_90_Max   :=  957.6794;
			decimal8_4 TotalCostRiskScore_Rank_91_Min   :=  957.6794;
			decimal8_4 TotalCostRiskScore_Rank_91_Max   :=  982.5225;
			decimal8_4 TotalCostRiskScore_Rank_92_Min   :=  982.5225;
			decimal8_4 TotalCostRiskScore_Rank_92_Max   :=  1008.188;
			decimal8_4 TotalCostRiskScore_Rank_93_Min   :=  1008.188;
			decimal8_4 TotalCostRiskScore_Rank_93_Max   :=  1036.498;
			decimal8_4 TotalCostRiskScore_Rank_94_Min   :=  1036.498;
			decimal8_4 TotalCostRiskScore_Rank_94_Max   :=  1066.566;
			decimal8_4 TotalCostRiskScore_Rank_95_Min   :=  1066.566;
			decimal8_4 TotalCostRiskScore_Rank_95_Max   :=  1100;
			decimal8_4 TotalCostRiskScore_Rank_96_Min   :=  1100;
			decimal8_4 TotalCostRiskScore_Rank_96_Max   :=  1142.299;
			decimal8_4 TotalCostRiskScore_Rank_97_Min   :=  1142.299;
			decimal8_4 TotalCostRiskScore_Rank_97_Max   :=  1194.302;
			decimal8_4 TotalCostRiskScore_Rank_98_Min   :=  1194.302;
			decimal8_4 TotalCostRiskScore_Rank_98_Max   :=  1266.275;
			decimal8_4 TotalCostRiskScore_Rank_99_Min   :=  1266.275;
			decimal8_4 TotalCostRiskScore_Rank_99_Max   :=  1384.471;
			decimal8_4 TotalCostRiskScore_Rank_100_Min  :=  138;

			unsigned1 TotalCostRiskScore_Category_5_Low  :=  96;
			unsigned1 TotalCostRiskScore_Category_4_High :=  95;
			unsigned1 TotalCostRiskScore_Category_4_Low  :=  86;
			unsigned1 TotalCostRiskScore_Category_3_High :=  85;
			unsigned1 TotalCostRiskScore_Category_3_Low  :=  71;
			unsigned1 TotalCostRiskScore_Category_2_High :=  70;
			unsigned1 TotalCostRiskScore_Category_2_Low  :=  51;
			unsigned1 TotalCostRiskScore_Category_1_High :=  50;

			Boolean SuppressResultsForOptOuts := Healthcare_Constants_RT_Service.CFG_True;
			UNSIGNED1 LexIdSourceOptout := 1;
	end;

	EXPORT transactionLog := RECORD			
		STRING20 transaction_id ; 				// ID of the transaction. This ID will be associated with all logging entries.
		INTEGER  product_id ; 					// MBS gbl_product_id
		INTEGER  sub_product_id ; 				// MBS sub product id		
		STRING60 date_added ; 					// Date the record was added.
		STRING60 login_id ; 					// LOG-IN id of the USER executing the search.
		STRING60 billing_code ; 				// Billing CODE of the transaciton. FOR migrated products it would be special billing id
		STRING30 function_name ; 				// TYPE of TRANSACTION/search that IS being executed. Equivalent FOR the current insurance products AS "report_service_type"
		INTEGER  report_code ; 					// Denotes the reporting CODE TO be used FOR billing
		INTEGER  gc_id ; 						// Gc id of the company running the search
		INTEGER  billing_id ; 					// Billing id of the company running the search
		STRING32 customer_reference_code; 		// Pass through VALUE BY the customer TO ID the transaction. IN the current insurance world referred AS "full quote back" AND IN accurint "reference number"
		STRING120 end_user_name ; 				// EndUser Company name
		STRING200 end_user_address_1 ;			// EndUser address suppled in request
		STRING25 end_user_city ;
		STRING2 end_user_state ;
		STRING5 end_user_zip ;
		STRING10 end_user_phone ;
		STRING32 i_unique_id ; 					// UNIQUE ID provided aka LexID
		STRING15 i_tax_id ; 					// Input TaxId
		STRING15 i_fein ; 						// Input FEIN
		STRING10 i_npi ; 						// Input NPI
		STRING15 i_clia ; 						// Input CLIA
		STRING12 i_upin ; 						// Input UPIN
		STRING20 i_provider_id ; 				// Input LN ProviderId
		STRING20 i_facility_id ; 				// Input LN FacilityId
		STRING5  i_person_name_prefix ; 		// Prefix NAME provided
		STRING20 i_person_last_name ; 			// LAST NAME, input IN search
		STRING20 i_person_first_name ; 			// FIRST NAME input IN search
		STRING20 i_person_middle_name ; 		// Middle NAME input IN search
		STRING5  i_person_name_suffix ; 		// Suffix NAME provided
		STRING8  i_person_dob ; 				// DOB of the SUBJECT
		STRING9  i_person_ssn ; 				// SSN of the person being inquiried
		STRING10 i_person_phone ; 				// Phone of the person being inquiried
		STRING90 i_person_addr ; 				// Line1 address being passed
		STRING50 i_person_city ; 				// City of the address passed
		STRING2  i_person_state ; 				// State of the address being passed
		STRING10 i_person_zip ; 				// ZIP of the address passed
		STRING3  i_person_country ; 			// 3 letter ISO CODE of the country of the address passed
		STRING80 i_bus_name ; 					// Business/facility/organization Name
		STRING10 i_bus_phone ; 					// Phone of the business being inquiried
		STRING90 i_bus_addr ; 					// Line1 business address being passed
		STRING50 i_bus_city ; 					// City of the business address passed
		STRING2  i_bus_state ; 					// State of the business address being passed
		STRING10 i_bus_zip ; 					// ZIP of the business address passed
		STRING3  i_bus_country ; 				// 3 letter ISO CODE of the country of the business address passed
		STRING256 user_agent; 					// User Agent string if from Web App if Web transaction
		STRING10  error_code; 					// Other transaction error
		STRING100 error_detail; 				// Verbose description of error_code
		STRING10 dataprep_error_code ; 			// Processing error from Roxie
		STRING1  match_flag ; 					// From Roxie
		STRING1  subject_to_sla ; 				// From Roxie - if transaction is subject to SLA
		DECIMAL18_9 price; 						// Price of the transaction. Having the price in the accounting_log easily helps reporting tieing a type of transaction with the price
		INTEGER  currency; 						// Indicates the type of currency. 0=unknown, 1= U.S Dollar,etc
		INTEGER  pricing_error_code; 			// To be set by the pricing application. Indicates default pricing status after pricer process the record
		INTEGER  free; 							// Tells whether the record is for free and the reason, i.e free = 1 Free Trial, free 2= Exempt Company, free = 3 Next Page search, free = 4/6 , marked as Freebee
		INTEGER  record_count ; 				// Results returned from the search for one type
		STRING10 report_options ; 				// Register the options for each possible search if applies. Can be similar to what we use in Accurint accounting_log but even expand the use if necessary, and as opposed to use boolean 1/0 for each position, can have different values
		INTEGER  transaction_code ; 			// This would be used for billing and potentially for rollup
		INTEGER  order_status_code ; 			// Order status code reflects whether its subject to billing, not or if there has been any error
		INTEGER  result_code ; 					// Denotes the specifics/nature of the result, in case it could be fulfilled
		INTEGER  login_history_id ; 			// Optional. Possibly NULL in this case for non WEB transactions
		STRING20 ip_address ; 					// IP where the request was made for the search
		STRING8  response_time ; 				// Response time taken to fullfil the request, from request to result
		STRING40 esp_method ; 					// ESP method tied to this transaction id
	END; // RECORD
	
	EXPORT transactionLogWrap := RECORD
		transactionLog Rec {xpath('Rec')};
	END;
	
	EXPORT transactionLogWrapWrap := RECORD
		transactionLogWrap Records {xpath('Records')};
	END;
	
END; // MODULE
