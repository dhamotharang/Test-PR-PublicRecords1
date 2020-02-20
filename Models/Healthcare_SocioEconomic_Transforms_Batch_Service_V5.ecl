Import Models;

EXPORT Healthcare_SocioEconomic_Transforms_Batch_Service_V5 := MODULE

	EXPORT AddScoreCategories(ds,
							Socio_TC_Model_Version_in,
							SuppressResultsForOptOuts,
							batch_params
							) := FUNCTIONMACRO
	Models.Layouts_Healthcare_V5.Output_Layout doXform(TYPEOF(RECORDOF(ds)) L, BOOLEAN SuppressResultsForOptOuts) := TRANSFORM
		_blank := '';
		_OptOutMessage := 'OO';
		_SuppressOutput := ((boolean)L.isLexIdInOptOut) AND SuppressResultsForOptOuts;
		SeRs_Score := (DECIMAL32_16)L.SeRs_Score;
		SeRs_Score_Str := trim(L.SeRs_Score, left, right);
		SeRs_Category := (string) MAP(
								SeRs_Score_Str = 'N/A' => 'N/A',
								SeRs_Score_Str = _blank => _blank,
   								SeRs_Score < (DECIMAL7_4)batch_params.ReadmissionScore_Category_2_Low => '1',
   								SeRs_Score < (DECIMAL7_4)batch_params.ReadmissionScore_Category_3_Low => '2',
   								SeRs_Score < (DECIMAL7_4)batch_params.ReadmissionScore_Category_4_Low => '3',
   								SeRs_Score < (DECIMAL7_4)batch_params.ReadmissionScore_Category_5_Low => '4',
   								SeRs_Score >= (DECIMAL7_4)batch_params.ReadmissionScore_Category_5_Low => '5',
   								'N/A');
		SELF.ReadmissionScore_Category := IF(_SuppressOutput, _OptOutMessage, SeRs_Category);
		SeMA_Score := (DECIMAL32_16)L.SeMA_Score;
		SeMA_Score_Str := trim(L.SeMA_Score, left, right);
		SeMA_Category := (string) MAP(
								SeMA_Score_Str = 'N/A' => 'N/A',
								SeMA_Score_Str = _blank => _blank,
  								SeMA_Score < (DECIMAL7_4)batch_params.MedicationAdherenceScore_category_4_Low => '5',
  								SeMA_Score < (DECIMAL7_4)batch_params.MedicationAdherenceScore_category_3_Low => '4',
  								SeMA_Score < (DECIMAL7_4)batch_params.MedicationAdherenceScore_category_2_Low => '3',
  								SeMA_Score < (DECIMAL7_4)batch_params.MedicationAdherenceScore_category_1_Low => '2',
  								SeMA_Score >= (DECIMAL7_4)batch_params.MedicationAdherenceScore_Category_1_Low => '1',
  								'N/A');
		SELF.MedicationAdherenceScore_Category := IF(_SuppressOutput, _OptOutMessage,SeMA_Category);
		SeMO_Score := (DECIMAL32_16)L.SeMO_Score;
		SeMO_Score_Str := trim(L.SeMO_Score, left, right);
		SeMO_Category := (string) MAP(
								SeMO_Score_Str = 'N/A' => 'N/A',
								SeMO_Score_Str = _blank => _blank,
  								SeMO_Score < (DECIMAL7_4)batch_params.MotivationScore_category_4_Low => '5',
  								SeMO_Score < (DECIMAL7_4)batch_params.MotivationScore_category_3_Low => '4',
  								SeMO_Score < (DECIMAL7_4)batch_params.MotivationScore_category_2_Low => '3',
  								SeMO_Score < (DECIMAL7_4)batch_params.MotivationScore_category_1_Low => '2',
  								SeMO_Score >= (DECIMAL7_4)batch_params.MotivationScore_Category_1_Low => '1',
  								'N/A');
		SELF.MotivationScore_Category := IF(_SuppressOutput, _OptOutMessage,SeMO_Category);

		SeTC_Score := (DECIMAL32_16)L.Score;
		SeTC_Score_Str := trim(L.Score, left, right);
		DECIMAL5_4 Socio_Index_Value := (DECIMAL5_4)(SeTC_Score/(DECIMAL9_4)batch_params.TotalCostRiskScore_Index_Denominator);
		SELF.Socio_Index := IF(Socio_TC_Model_Version_in=3, MAP(
								_SuppressOutput = TRUE => _OptOutMessage,
								SeTC_Score_Str = 'N/A' => 'N/A',
								SeTC_Score_Str = _blank => _blank,
								(string)Socio_Index_Value), _blank);
		val_Socio_Rank := IF(Socio_TC_Model_Version_in=3, (string) MAP(
								_SuppressOutput = TRUE => _OptOutMessage,
								SeTC_Score_Str = 'N/A' => 'N/A',
								SeTC_Score_Str = _blank => _blank,
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_1_Max  => '1',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_2_Max  => '2',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_3_Max  => '3',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_4_Max  => '4',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_5_Max  => '5',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_6_Max  => '6',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_7_Max  => '7',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_8_Max  => '8',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_9_Max  => '9',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_10_Max => '10',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_11_Max => '11',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_12_Max => '12',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_13_Max => '13',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_14_Max => '14',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_15_Max => '15',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_16_Max => '16',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_17_Max => '17',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_18_Max => '18',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_19_Max => '19',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_20_Max => '20',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_21_Max => '21',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_22_Max => '22',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_23_Max => '23',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_24_Max => '24',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_25_Max => '25',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_26_Max => '26',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_27_Max => '27',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_28_Max => '28',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_29_Max => '29',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_30_Max => '30',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_31_Max => '31',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_32_Max => '32',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_33_Max => '33',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_34_Max => '34',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_35_Max => '35',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_36_Max => '36',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_37_Max => '37',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_38_Max => '38',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_39_Max => '39',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_40_Max => '40',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_41_Max => '41',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_42_Max => '42',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_43_Max => '43',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_44_Max => '44',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_45_Max => '45',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_46_Max => '46',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_47_Max => '47',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_48_Max => '48',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_49_Max => '49',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_50_Max => '50',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_51_Max => '51',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_52_Max => '52',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_53_Max => '53',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_54_Max => '54',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_55_Max => '55',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_56_Max => '56',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_57_Max => '57',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_58_Max => '58',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_59_Max => '59',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_60_Max => '60',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_61_Max => '61',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_62_Max => '62',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_63_Max => '63',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_64_Max => '64',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_65_Max => '65',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_66_Max => '66',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_67_Max => '67',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_68_Max => '68',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_69_Max => '69',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_70_Max => '70',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_71_Max => '71',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_72_Max => '72',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_73_Max => '73',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_74_Max => '74',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_75_Max => '75',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_76_Max => '76',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_77_Max => '77',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_78_Max => '78',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_79_Max => '79',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_80_Max => '80',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_81_Max => '81',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_82_Max => '82',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_83_Max => '83',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_84_Max => '84',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_85_Max => '85',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_86_Max => '86',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_87_Max => '87',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_88_Max => '88',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_89_Max => '89',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_90_Max => '90',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_91_Max => '91',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_92_Max => '92',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_93_Max => '93',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_94_Max => '94',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_95_Max => '95',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_96_Max => '96',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_97_Max => '97',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_98_Max => '98',
								SeTC_Score < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_99_Max => '99',
								SeTC_Score >= (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_99_Max => '100',
								'N/A'), _blank);
		SELF.Socio_Rank := val_Socio_Rank;
		SELF.Socio_Category := IF(Socio_TC_Model_Version_in=3, (string) MAP(
								_SuppressOutput = TRUE => _OptOutMessage,
								val_Socio_Rank = 'N/A' => 'N/A',
								val_Socio_Rank = _blank => _blank,
   								(UNSIGNED1) val_Socio_Rank  < (UNSIGNED1) batch_params.TotalCostRiskScore_Category_2_Low => '1',
   								(UNSIGNED1) val_Socio_Rank  < (UNSIGNED1) batch_params.TotalCostRiskScore_Category_3_Low => '2',
   								(UNSIGNED1) val_Socio_Rank  < (UNSIGNED1) batch_params.TotalCostRiskScore_Category_4_Low => '3',
   								(UNSIGNED1) val_Socio_Rank  < (UNSIGNED1) batch_params.TotalCostRiskScore_Category_5_Low => '4',
   								(UNSIGNED1) val_Socio_Rank >= (UNSIGNED1) batch_params.TotalCostRiskScore_Category_5_Low => '5',
   								'N/A'), _blank);
		SELF := L;
		END;
		result := PROJECT(ds, doXform(LEFT, SuppressResultsForOptOuts));
	RETURN result;
	ENDMACRO;

	EXPORT doParamCheck(batch_params) := MACRO
	// This is a simple check that makes sure the buckets of category thresholds don't overlap. We have a batter, more complete algorithm that does a better validation and can be added later.
	 IF((DECIMAL7_4)batch_params.ReadmissionScore_Category_2_Low <= (DECIMAL7_4)batch_params.ReadmissionScore_Category_1_High OR
		(DECIMAL7_4)batch_params.ReadmissionScore_Category_3_Low <= (DECIMAL7_4)batch_params.ReadmissionScore_Category_2_High OR
		(DECIMAL7_4)batch_params.ReadmissionScore_Category_4_Low <= (DECIMAL7_4)batch_params.ReadmissionScore_Category_3_High OR
		(DECIMAL7_4)batch_params.ReadmissionScore_Category_5_Low <= (DECIMAL7_4)batch_params.ReadmissionScore_Category_4_High,
		FAIL('Bad ReadmissionScore_Category thresholds supplied.'));

	 IF((DECIMAL7_4)batch_params.MedicationAdherenceScore_Category_4_Low <= (DECIMAL7_4)batch_params.MedicationAdherenceScore_Category_5_High OR
		(DECIMAL7_4)batch_params.MedicationAdherenceScore_Category_3_Low <= (DECIMAL7_4)batch_params.MedicationAdherenceScore_Category_4_High OR
		(DECIMAL7_4)batch_params.MedicationAdherenceScore_Category_2_Low <= (DECIMAL7_4)batch_params.MedicationAdherenceScore_Category_3_High OR
		(DECIMAL7_4)batch_params.MedicationAdherenceScore_Category_1_Low <= (DECIMAL7_4)batch_params.MedicationAdherenceScore_Category_2_High,
		FAIL('Bad MedicationAdherenceScore_Category thresholds supplied.'));

	 IF((DECIMAL7_4)batch_params.MotivationScore_Category_4_Low <= (DECIMAL7_4)batch_params.MotivationScore_Category_5_High OR
		(DECIMAL7_4)batch_params.MotivationScore_Category_3_Low <= (DECIMAL7_4)batch_params.MotivationScore_Category_4_High OR
		(DECIMAL7_4)batch_params.MotivationScore_Category_2_Low <= (DECIMAL7_4)batch_params.MotivationScore_Category_3_High OR
		(DECIMAL7_4)batch_params.MotivationScore_Category_1_Low <= (DECIMAL7_4)batch_params.MotivationScore_Category_2_High,
		FAIL('Bad MotivationScore_Category thresholds supplied.'));

	 IF((DECIMAL9_4)batch_params.TotalCostRiskScore_Index_Denominator = 0, FAIL('Bad TotalCostRiskScore_Index_Denominator supplied.'));

	 IF((DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_2_Min  < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_1_Max OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_3_Min  < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_2_Max   OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_4_Min  < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_3_Max   OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_5_Min  < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_4_Max   OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_6_Min  < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_5_Max   OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_7_Min  < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_6_Max   OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_8_Min  < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_7_Max   OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_9_Min  < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_8_Max   OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_10_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_9_Max   OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_11_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_10_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_12_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_11_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_13_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_12_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_14_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_13_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_15_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_14_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_16_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_15_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_17_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_16_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_18_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_17_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_19_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_18_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_20_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_19_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_21_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_20_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_22_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_21_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_23_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_22_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_24_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_23_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_25_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_24_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_26_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_25_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_27_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_26_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_28_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_27_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_29_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_28_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_30_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_29_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_31_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_30_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_32_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_31_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_33_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_32_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_34_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_33_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_35_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_34_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_36_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_35_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_37_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_36_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_38_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_37_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_39_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_38_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_40_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_39_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_41_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_40_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_42_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_41_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_43_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_42_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_44_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_43_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_45_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_44_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_46_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_45_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_47_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_46_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_48_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_47_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_49_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_48_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_50_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_49_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_51_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_50_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_52_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_51_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_53_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_52_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_54_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_53_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_55_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_54_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_56_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_55_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_57_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_56_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_58_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_57_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_59_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_58_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_60_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_59_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_61_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_60_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_62_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_61_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_63_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_62_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_64_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_63_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_65_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_64_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_66_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_65_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_67_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_66_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_68_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_67_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_69_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_68_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_70_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_69_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_71_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_70_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_72_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_71_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_73_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_72_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_74_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_73_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_75_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_74_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_76_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_75_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_77_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_76_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_78_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_77_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_79_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_78_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_80_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_79_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_81_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_80_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_82_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_81_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_83_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_82_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_84_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_83_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_85_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_84_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_86_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_85_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_87_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_86_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_88_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_87_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_89_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_88_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_90_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_89_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_91_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_90_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_92_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_91_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_93_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_92_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_94_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_93_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_95_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_94_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_96_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_95_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_97_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_96_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_98_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_97_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_99_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_98_Max  OR
		(DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_100_Min < (DECIMAL9_4)batch_params.TotalCostRiskScore_Rank_99_Max,
		FAIL('Bad TotalCostRiskScore_Rank thresholds supplied.'));

	 IF((UNSIGNED1)batch_params.TotalCostRiskScore_Category_2_Low < (UNSIGNED1)batch_params.TotalCostRiskScore_Category_1_High OR
		(UNSIGNED1)batch_params.TotalCostRiskScore_Category_3_Low < (UNSIGNED1)batch_params.TotalCostRiskScore_Category_2_High OR
		(UNSIGNED1)batch_params.TotalCostRiskScore_Category_4_Low < (UNSIGNED1)batch_params.TotalCostRiskScore_Category_3_High OR
		(UNSIGNED1)batch_params.TotalCostRiskScore_Category_5_Low < (UNSIGNED1)batch_params.TotalCostRiskScore_Category_4_High,
		FAIL('Bad TotalCostRiskScore_Category thresholds supplied.'));

	ENDMACRO;

END;
