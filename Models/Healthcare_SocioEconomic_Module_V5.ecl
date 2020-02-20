IMPORT Models, Std;

	V5_Defaults:= Models.Healthcare_Constants_V5.Defaults;

	export Healthcare_SocioEconomic_Module_V5() := module

        export string10 ReadmissionScore_Category_5_Low  := V5_Defaults.ReadmissionScore_Category_5_Low  : STORED('ReadmissionScore_Category_5_Low');
        export string10 ReadmissionScore_Category_4_High := V5_Defaults.ReadmissionScore_Category_4_High : STORED('ReadmissionScore_Category_4_High');
        export string10 ReadmissionScore_Category_4_Low  := V5_Defaults.ReadmissionScore_Category_4_Low  : STORED('ReadmissionScore_Category_4_Low');
        export string10 ReadmissionScore_Category_3_High := V5_Defaults.ReadmissionScore_Category_3_High : STORED('ReadmissionScore_Category_3_High');
        export string10 ReadmissionScore_Category_3_Low  := V5_Defaults.ReadmissionScore_Category_3_Low  : STORED('ReadmissionScore_Category_3_Low');
        export string10 ReadmissionScore_Category_2_High := V5_Defaults.ReadmissionScore_Category_2_High : STORED('ReadmissionScore_Category_2_High');
        export string10 ReadmissionScore_Category_2_Low  := V5_Defaults.ReadmissionScore_Category_2_Low  : STORED('ReadmissionScore_Category_2_Low');
        export string10 ReadmissionScore_Category_1_High := V5_Defaults.ReadmissionScore_Category_1_High : STORED('ReadmissionScore_Category_1_High');

        export string10 MedicationAdherenceScore_Category_5_High := V5_Defaults.MedicationAdherenceScore_Category_5_High : STORED('MedicationAdherenceScore_Category_5_High');
        export string10 MedicationAdherenceScore_Category_4_Low  := V5_Defaults.MedicationAdherenceScore_Category_4_Low  : STORED('MedicationAdherenceScore_Category_4_Low');
        export string10 MedicationAdherenceScore_Category_4_High := V5_Defaults.MedicationAdherenceScore_Category_4_High : STORED('MedicationAdherenceScore_Category_4_High');
        export string10 MedicationAdherenceScore_Category_3_Low  := V5_Defaults.MedicationAdherenceScore_Category_3_Low  : STORED('MedicationAdherenceScore_Category_3_Low');
        export string10 MedicationAdherenceScore_Category_3_High := V5_Defaults.MedicationAdherenceScore_Category_3_High : STORED('MedicationAdherenceScore_Category_3_High');
        export string10 MedicationAdherenceScore_Category_2_Low  := V5_Defaults.MedicationAdherenceScore_Category_2_Low  : STORED('MedicationAdherenceScore_Category_2_Low');
        export string10 MedicationAdherenceScore_Category_2_High := V5_Defaults.MedicationAdherenceScore_Category_2_High : STORED('MedicationAdherenceScore_Category_2_High');
        export string10 MedicationAdherenceScore_Category_1_Low  := V5_Defaults.MedicationAdherenceScore_Category_1_Low  : STORED('MedicationAdherenceScore_Category_1_Low');

        export string10 MotivationScore_Category_5_High := V5_Defaults.MotivationScore_Category_5_High : STORED('MotivationScore_Category_5_High');
        export string10 MotivationScore_Category_4_Low  := V5_Defaults.MotivationScore_Category_4_Low  : STORED('MotivationScore_Category_4_Low');
        export string10 MotivationScore_Category_4_High := V5_Defaults.MotivationScore_Category_4_High : STORED('MotivationScore_Category_4_High');
        export string10 MotivationScore_Category_3_Low  := V5_Defaults.MotivationScore_Category_3_Low  : STORED('MotivationScore_Category_3_Low');
        export string10 MotivationScore_Category_3_High := V5_Defaults.MotivationScore_Category_3_High : STORED('MotivationScore_Category_3_High');
        export string10 MotivationScore_Category_2_Low  := V5_Defaults.MotivationScore_Category_2_Low  : STORED('MotivationScore_Category_2_Low');
        export string10 MotivationScore_Category_2_High := V5_Defaults.MotivationScore_Category_2_High : STORED('MotivationScore_Category_2_High');
        export string10 MotivationScore_Category_1_Low  := V5_Defaults.MotivationScore_Category_1_Low  : STORED('MotivationScore_Category_1_Low');

	export string10 TotalCostRiskScore_Index_Denominator := V5_Defaults.TotalCostRiskScore_Index_Denominator : STORED('TotalCostRiskScore_Index_Denominator');

        export string10 TotalCostRiskScore_Rank_1_Min  :=   V5_Defaults.TotalCostRiskScore_Rank_1_Min  : STORED('TotalCostRiskScore_Rank_1_Min') ;
        export string10 TotalCostRiskScore_Rank_1_Max  :=   V5_Defaults.TotalCostRiskScore_Rank_1_Max  : STORED('TotalCostRiskScore_Rank_1_Max') ;
        export string10 TotalCostRiskScore_Rank_2_Min  :=   V5_Defaults.TotalCostRiskScore_Rank_2_Min  : STORED('TotalCostRiskScore_Rank_2_Min') ;
        export string10 TotalCostRiskScore_Rank_2_Max  :=   V5_Defaults.TotalCostRiskScore_Rank_2_Max  : STORED('TotalCostRiskScore_Rank_2_Max') ;
        export string10 TotalCostRiskScore_Rank_3_Min  :=   V5_Defaults.TotalCostRiskScore_Rank_3_Min  : STORED('TotalCostRiskScore_Rank_3_Min') ;
        export string10 TotalCostRiskScore_Rank_3_Max  :=   V5_Defaults.TotalCostRiskScore_Rank_3_Max  : STORED('TotalCostRiskScore_Rank_3_Max') ;
        export string10 TotalCostRiskScore_Rank_4_Min  :=   V5_Defaults.TotalCostRiskScore_Rank_4_Min  : STORED('TotalCostRiskScore_Rank_4_Min') ;
        export string10 TotalCostRiskScore_Rank_4_Max  :=   V5_Defaults.TotalCostRiskScore_Rank_4_Max  : STORED('TotalCostRiskScore_Rank_4_Max') ;
        export string10 TotalCostRiskScore_Rank_5_Min  :=   V5_Defaults.TotalCostRiskScore_Rank_5_Min  : STORED('TotalCostRiskScore_Rank_5_Min') ;
        export string10 TotalCostRiskScore_Rank_5_Max  :=   V5_Defaults.TotalCostRiskScore_Rank_5_Max  : STORED('TotalCostRiskScore_Rank_5_Max') ;
        export string10 TotalCostRiskScore_Rank_6_Min  :=   V5_Defaults.TotalCostRiskScore_Rank_6_Min  : STORED('TotalCostRiskScore_Rank_6_Min') ;
        export string10 TotalCostRiskScore_Rank_6_Max  :=   V5_Defaults.TotalCostRiskScore_Rank_6_Max  : STORED('TotalCostRiskScore_Rank_6_Max') ;
        export string10 TotalCostRiskScore_Rank_7_Min  :=   V5_Defaults.TotalCostRiskScore_Rank_7_Min  : STORED('TotalCostRiskScore_Rank_7_Min') ;
        export string10 TotalCostRiskScore_Rank_7_Max  :=   V5_Defaults.TotalCostRiskScore_Rank_7_Max  : STORED('TotalCostRiskScore_Rank_7_Max') ;
        export string10 TotalCostRiskScore_Rank_8_Min  :=   V5_Defaults.TotalCostRiskScore_Rank_8_Min  : STORED('TotalCostRiskScore_Rank_8_Min') ;
        export string10 TotalCostRiskScore_Rank_8_Max  :=   V5_Defaults.TotalCostRiskScore_Rank_8_Max  : STORED('TotalCostRiskScore_Rank_8_Max') ;
        export string10 TotalCostRiskScore_Rank_9_Min  :=   V5_Defaults.TotalCostRiskScore_Rank_9_Min  : STORED('TotalCostRiskScore_Rank_9_Min') ;
        export string10 TotalCostRiskScore_Rank_9_Max  :=   V5_Defaults.TotalCostRiskScore_Rank_9_Max  : STORED('TotalCostRiskScore_Rank_9_Max') ;
        export string10 TotalCostRiskScore_Rank_10_Min   := V5_Defaults.TotalCostRiskScore_Rank_10_Min : STORED('TotalCostRiskScore_Rank_10_Min') ;
        export string10 TotalCostRiskScore_Rank_10_Max   := V5_Defaults.TotalCostRiskScore_Rank_10_Max : STORED('TotalCostRiskScore_Rank_10_Max') ;
        export string10 TotalCostRiskScore_Rank_11_Min   := V5_Defaults.TotalCostRiskScore_Rank_11_Min : STORED('TotalCostRiskScore_Rank_11_Min') ;
        export string10 TotalCostRiskScore_Rank_11_Max   := V5_Defaults.TotalCostRiskScore_Rank_11_Max : STORED('TotalCostRiskScore_Rank_11_Max') ;
        export string10 TotalCostRiskScore_Rank_12_Min   := V5_Defaults.TotalCostRiskScore_Rank_12_Min : STORED('TotalCostRiskScore_Rank_12_Min') ;
        export string10 TotalCostRiskScore_Rank_12_Max   := V5_Defaults.TotalCostRiskScore_Rank_12_Max : STORED('TotalCostRiskScore_Rank_12_Max') ;
        export string10 TotalCostRiskScore_Rank_13_Min   := V5_Defaults.TotalCostRiskScore_Rank_13_Min : STORED('TotalCostRiskScore_Rank_13_Min') ;
        export string10 TotalCostRiskScore_Rank_13_Max   := V5_Defaults.TotalCostRiskScore_Rank_13_Max : STORED('TotalCostRiskScore_Rank_13_Max') ;
        export string10 TotalCostRiskScore_Rank_14_Min   := V5_Defaults.TotalCostRiskScore_Rank_14_Min : STORED('TotalCostRiskScore_Rank_14_Min') ;
        export string10 TotalCostRiskScore_Rank_14_Max   := V5_Defaults.TotalCostRiskScore_Rank_14_Max : STORED('TotalCostRiskScore_Rank_14_Max') ;
        export string10 TotalCostRiskScore_Rank_15_Min   := V5_Defaults.TotalCostRiskScore_Rank_15_Min : STORED('TotalCostRiskScore_Rank_15_Min') ;
        export string10 TotalCostRiskScore_Rank_15_Max   := V5_Defaults.TotalCostRiskScore_Rank_15_Max : STORED('TotalCostRiskScore_Rank_15_Max') ;
        export string10 TotalCostRiskScore_Rank_16_Min   := V5_Defaults.TotalCostRiskScore_Rank_16_Min : STORED('TotalCostRiskScore_Rank_16_Min') ;
        export string10 TotalCostRiskScore_Rank_16_Max   := V5_Defaults.TotalCostRiskScore_Rank_16_Max : STORED('TotalCostRiskScore_Rank_16_Max') ;
        export string10 TotalCostRiskScore_Rank_17_Min   := V5_Defaults.TotalCostRiskScore_Rank_17_Min : STORED('TotalCostRiskScore_Rank_17_Min') ;
        export string10 TotalCostRiskScore_Rank_17_Max   := V5_Defaults.TotalCostRiskScore_Rank_17_Max : STORED('TotalCostRiskScore_Rank_17_Max') ;
        export string10 TotalCostRiskScore_Rank_18_Min   := V5_Defaults.TotalCostRiskScore_Rank_18_Min : STORED('TotalCostRiskScore_Rank_18_Min') ;
        export string10 TotalCostRiskScore_Rank_18_Max   := V5_Defaults.TotalCostRiskScore_Rank_18_Max : STORED('TotalCostRiskScore_Rank_18_Max') ;
        export string10 TotalCostRiskScore_Rank_19_Min   := V5_Defaults.TotalCostRiskScore_Rank_19_Min : STORED('TotalCostRiskScore_Rank_19_Min') ;
        export string10 TotalCostRiskScore_Rank_19_Max   := V5_Defaults.TotalCostRiskScore_Rank_19_Max : STORED('TotalCostRiskScore_Rank_19_Max') ;
        export string10 TotalCostRiskScore_Rank_20_Min   := V5_Defaults.TotalCostRiskScore_Rank_20_Min : STORED('TotalCostRiskScore_Rank_20_Min') ;
        export string10 TotalCostRiskScore_Rank_20_Max   := V5_Defaults.TotalCostRiskScore_Rank_20_Max : STORED('TotalCostRiskScore_Rank_20_Max') ;
        export string10 TotalCostRiskScore_Rank_21_Min   := V5_Defaults.TotalCostRiskScore_Rank_21_Min : STORED('TotalCostRiskScore_Rank_21_Min') ;
        export string10 TotalCostRiskScore_Rank_21_Max   := V5_Defaults.TotalCostRiskScore_Rank_21_Max : STORED('TotalCostRiskScore_Rank_21_Max') ;
        export string10 TotalCostRiskScore_Rank_22_Min   := V5_Defaults.TotalCostRiskScore_Rank_22_Min : STORED('TotalCostRiskScore_Rank_22_Min') ;
        export string10 TotalCostRiskScore_Rank_22_Max   := V5_Defaults.TotalCostRiskScore_Rank_22_Max : STORED('TotalCostRiskScore_Rank_22_Max') ;
        export string10 TotalCostRiskScore_Rank_23_Min   := V5_Defaults.TotalCostRiskScore_Rank_23_Min : STORED('TotalCostRiskScore_Rank_23_Min') ;
        export string10 TotalCostRiskScore_Rank_23_Max   := V5_Defaults.TotalCostRiskScore_Rank_23_Max : STORED('TotalCostRiskScore_Rank_23_Max') ;
        export string10 TotalCostRiskScore_Rank_24_Min   := V5_Defaults.TotalCostRiskScore_Rank_24_Min : STORED('TotalCostRiskScore_Rank_24_Min') ;
        export string10 TotalCostRiskScore_Rank_24_Max   := V5_Defaults.TotalCostRiskScore_Rank_24_Max : STORED('TotalCostRiskScore_Rank_24_Max') ;
        export string10 TotalCostRiskScore_Rank_25_Min   := V5_Defaults.TotalCostRiskScore_Rank_25_Min : STORED('TotalCostRiskScore_Rank_25_Min') ;
        export string10 TotalCostRiskScore_Rank_25_Max   := V5_Defaults.TotalCostRiskScore_Rank_25_Max : STORED('TotalCostRiskScore_Rank_25_Max') ;
        export string10 TotalCostRiskScore_Rank_26_Min   := V5_Defaults.TotalCostRiskScore_Rank_26_Min : STORED('TotalCostRiskScore_Rank_26_Min') ;
        export string10 TotalCostRiskScore_Rank_26_Max   := V5_Defaults.TotalCostRiskScore_Rank_26_Max : STORED('TotalCostRiskScore_Rank_26_Max') ;
        export string10 TotalCostRiskScore_Rank_27_Min   := V5_Defaults.TotalCostRiskScore_Rank_27_Min : STORED('TotalCostRiskScore_Rank_27_Min') ;
        export string10 TotalCostRiskScore_Rank_27_Max   := V5_Defaults.TotalCostRiskScore_Rank_27_Max : STORED('TotalCostRiskScore_Rank_27_Max') ;
        export string10 TotalCostRiskScore_Rank_28_Min   := V5_Defaults.TotalCostRiskScore_Rank_28_Min : STORED('TotalCostRiskScore_Rank_28_Min') ;
        export string10 TotalCostRiskScore_Rank_28_Max   := V5_Defaults.TotalCostRiskScore_Rank_28_Max : STORED('TotalCostRiskScore_Rank_28_Max') ;
        export string10 TotalCostRiskScore_Rank_29_Min   := V5_Defaults.TotalCostRiskScore_Rank_29_Min : STORED('TotalCostRiskScore_Rank_29_Min') ;
        export string10 TotalCostRiskScore_Rank_29_Max   := V5_Defaults.TotalCostRiskScore_Rank_29_Max : STORED('TotalCostRiskScore_Rank_29_Max') ;
        export string10 TotalCostRiskScore_Rank_30_Min   := V5_Defaults.TotalCostRiskScore_Rank_30_Min : STORED('TotalCostRiskScore_Rank_30_Min') ;
        export string10 TotalCostRiskScore_Rank_30_Max   := V5_Defaults.TotalCostRiskScore_Rank_30_Max : STORED('TotalCostRiskScore_Rank_30_Max') ;
        export string10 TotalCostRiskScore_Rank_31_Min   := V5_Defaults.TotalCostRiskScore_Rank_31_Min : STORED('TotalCostRiskScore_Rank_31_Min') ;
        export string10 TotalCostRiskScore_Rank_31_Max   := V5_Defaults.TotalCostRiskScore_Rank_31_Max : STORED('TotalCostRiskScore_Rank_31_Max') ;
        export string10 TotalCostRiskScore_Rank_32_Min   := V5_Defaults.TotalCostRiskScore_Rank_32_Min : STORED('TotalCostRiskScore_Rank_32_Min') ;
        export string10 TotalCostRiskScore_Rank_32_Max   := V5_Defaults.TotalCostRiskScore_Rank_32_Max : STORED('TotalCostRiskScore_Rank_32_Max') ;
        export string10 TotalCostRiskScore_Rank_33_Min   := V5_Defaults.TotalCostRiskScore_Rank_33_Min : STORED('TotalCostRiskScore_Rank_33_Min') ;
        export string10 TotalCostRiskScore_Rank_33_Max   := V5_Defaults.TotalCostRiskScore_Rank_33_Max : STORED('TotalCostRiskScore_Rank_33_Max') ;
        export string10 TotalCostRiskScore_Rank_34_Min   := V5_Defaults.TotalCostRiskScore_Rank_34_Min : STORED('TotalCostRiskScore_Rank_34_Min') ;
        export string10 TotalCostRiskScore_Rank_34_Max   := V5_Defaults.TotalCostRiskScore_Rank_34_Max : STORED('TotalCostRiskScore_Rank_34_Max') ;
        export string10 TotalCostRiskScore_Rank_35_Min   := V5_Defaults.TotalCostRiskScore_Rank_35_Min : STORED('TotalCostRiskScore_Rank_35_Min') ;
        export string10 TotalCostRiskScore_Rank_35_Max   := V5_Defaults.TotalCostRiskScore_Rank_35_Max : STORED('TotalCostRiskScore_Rank_35_Max') ;
        export string10 TotalCostRiskScore_Rank_36_Min   := V5_Defaults.TotalCostRiskScore_Rank_36_Min : STORED('TotalCostRiskScore_Rank_36_Min') ;
        export string10 TotalCostRiskScore_Rank_36_Max   := V5_Defaults.TotalCostRiskScore_Rank_36_Max : STORED('TotalCostRiskScore_Rank_36_Max') ;
        export string10 TotalCostRiskScore_Rank_37_Min   := V5_Defaults.TotalCostRiskScore_Rank_37_Min : STORED('TotalCostRiskScore_Rank_37_Min') ;
        export string10 TotalCostRiskScore_Rank_37_Max   := V5_Defaults.TotalCostRiskScore_Rank_37_Max : STORED('TotalCostRiskScore_Rank_37_Max') ;
        export string10 TotalCostRiskScore_Rank_38_Min   := V5_Defaults.TotalCostRiskScore_Rank_38_Min : STORED('TotalCostRiskScore_Rank_38_Min') ;
        export string10 TotalCostRiskScore_Rank_38_Max   := V5_Defaults.TotalCostRiskScore_Rank_38_Max : STORED('TotalCostRiskScore_Rank_38_Max') ;
        export string10 TotalCostRiskScore_Rank_39_Min   := V5_Defaults.TotalCostRiskScore_Rank_39_Min : STORED('TotalCostRiskScore_Rank_39_Min') ;
        export string10 TotalCostRiskScore_Rank_39_Max   := V5_Defaults.TotalCostRiskScore_Rank_39_Max : STORED('TotalCostRiskScore_Rank_39_Max') ;
        export string10 TotalCostRiskScore_Rank_40_Min   := V5_Defaults.TotalCostRiskScore_Rank_40_Min : STORED('TotalCostRiskScore_Rank_40_Min') ;
        export string10 TotalCostRiskScore_Rank_40_Max   := V5_Defaults.TotalCostRiskScore_Rank_40_Max : STORED('TotalCostRiskScore_Rank_40_Max') ;
        export string10 TotalCostRiskScore_Rank_41_Min   := V5_Defaults.TotalCostRiskScore_Rank_41_Min : STORED('TotalCostRiskScore_Rank_41_Min') ;
        export string10 TotalCostRiskScore_Rank_41_Max   := V5_Defaults.TotalCostRiskScore_Rank_41_Max : STORED('TotalCostRiskScore_Rank_41_Max') ;
        export string10 TotalCostRiskScore_Rank_42_Min   := V5_Defaults.TotalCostRiskScore_Rank_42_Min : STORED('TotalCostRiskScore_Rank_42_Min') ;
        export string10 TotalCostRiskScore_Rank_42_Max   := V5_Defaults.TotalCostRiskScore_Rank_42_Max : STORED('TotalCostRiskScore_Rank_42_Max') ;
        export string10 TotalCostRiskScore_Rank_43_Min   := V5_Defaults.TotalCostRiskScore_Rank_43_Min : STORED('TotalCostRiskScore_Rank_43_Min') ;
        export string10 TotalCostRiskScore_Rank_43_Max   := V5_Defaults.TotalCostRiskScore_Rank_43_Max : STORED('TotalCostRiskScore_Rank_43_Max') ;
        export string10 TotalCostRiskScore_Rank_44_Min   := V5_Defaults.TotalCostRiskScore_Rank_44_Min : STORED('TotalCostRiskScore_Rank_44_Min') ;
        export string10 TotalCostRiskScore_Rank_44_Max   := V5_Defaults.TotalCostRiskScore_Rank_44_Max : STORED('TotalCostRiskScore_Rank_44_Max') ;
        export string10 TotalCostRiskScore_Rank_45_Min   := V5_Defaults.TotalCostRiskScore_Rank_45_Min : STORED('TotalCostRiskScore_Rank_45_Min') ;
        export string10 TotalCostRiskScore_Rank_45_Max   := V5_Defaults.TotalCostRiskScore_Rank_45_Max : STORED('TotalCostRiskScore_Rank_45_Max') ;
        export string10 TotalCostRiskScore_Rank_46_Min   := V5_Defaults.TotalCostRiskScore_Rank_46_Min : STORED('TotalCostRiskScore_Rank_46_Min') ;
        export string10 TotalCostRiskScore_Rank_46_Max   := V5_Defaults.TotalCostRiskScore_Rank_46_Max : STORED('TotalCostRiskScore_Rank_46_Max') ;
        export string10 TotalCostRiskScore_Rank_47_Min   := V5_Defaults.TotalCostRiskScore_Rank_47_Min : STORED('TotalCostRiskScore_Rank_47_Min') ;
        export string10 TotalCostRiskScore_Rank_47_Max   := V5_Defaults.TotalCostRiskScore_Rank_47_Max : STORED('TotalCostRiskScore_Rank_47_Max') ;
        export string10 TotalCostRiskScore_Rank_48_Min   := V5_Defaults.TotalCostRiskScore_Rank_48_Min : STORED('TotalCostRiskScore_Rank_48_Min') ;
        export string10 TotalCostRiskScore_Rank_48_Max   := V5_Defaults.TotalCostRiskScore_Rank_48_Max : STORED('TotalCostRiskScore_Rank_48_Max') ;
        export string10 TotalCostRiskScore_Rank_49_Min   := V5_Defaults.TotalCostRiskScore_Rank_49_Min : STORED('TotalCostRiskScore_Rank_49_Min') ;
        export string10 TotalCostRiskScore_Rank_49_Max   := V5_Defaults.TotalCostRiskScore_Rank_49_Max : STORED('TotalCostRiskScore_Rank_49_Max') ;
        export string10 TotalCostRiskScore_Rank_50_Min   := V5_Defaults.TotalCostRiskScore_Rank_50_Min : STORED('TotalCostRiskScore_Rank_50_Min') ;
        export string10 TotalCostRiskScore_Rank_50_Max   := V5_Defaults.TotalCostRiskScore_Rank_50_Max : STORED('TotalCostRiskScore_Rank_50_Max') ;
        export string10 TotalCostRiskScore_Rank_51_Min   := V5_Defaults.TotalCostRiskScore_Rank_51_Min : STORED('TotalCostRiskScore_Rank_51_Min') ;
        export string10 TotalCostRiskScore_Rank_51_Max   := V5_Defaults.TotalCostRiskScore_Rank_51_Max : STORED('TotalCostRiskScore_Rank_51_Max') ;
        export string10 TotalCostRiskScore_Rank_52_Min   := V5_Defaults.TotalCostRiskScore_Rank_52_Min : STORED('TotalCostRiskScore_Rank_52_Min') ;
        export string10 TotalCostRiskScore_Rank_52_Max   := V5_Defaults.TotalCostRiskScore_Rank_52_Max : STORED('TotalCostRiskScore_Rank_52_Max') ;
        export string10 TotalCostRiskScore_Rank_53_Min   := V5_Defaults.TotalCostRiskScore_Rank_53_Min : STORED('TotalCostRiskScore_Rank_53_Min') ;
        export string10 TotalCostRiskScore_Rank_53_Max   := V5_Defaults.TotalCostRiskScore_Rank_53_Max : STORED('TotalCostRiskScore_Rank_53_Max') ;
        export string10 TotalCostRiskScore_Rank_54_Min   := V5_Defaults.TotalCostRiskScore_Rank_54_Min : STORED('TotalCostRiskScore_Rank_54_Min') ;
        export string10 TotalCostRiskScore_Rank_54_Max   := V5_Defaults.TotalCostRiskScore_Rank_54_Max : STORED('TotalCostRiskScore_Rank_54_Max') ;
        export string10 TotalCostRiskScore_Rank_55_Min   := V5_Defaults.TotalCostRiskScore_Rank_55_Min : STORED('TotalCostRiskScore_Rank_55_Min') ;
        export string10 TotalCostRiskScore_Rank_55_Max   := V5_Defaults.TotalCostRiskScore_Rank_55_Max : STORED('TotalCostRiskScore_Rank_55_Max') ;
        export string10 TotalCostRiskScore_Rank_56_Min   := V5_Defaults.TotalCostRiskScore_Rank_56_Min : STORED('TotalCostRiskScore_Rank_56_Min') ;
        export string10 TotalCostRiskScore_Rank_56_Max   := V5_Defaults.TotalCostRiskScore_Rank_56_Max : STORED('TotalCostRiskScore_Rank_56_Max') ;
        export string10 TotalCostRiskScore_Rank_57_Min   := V5_Defaults.TotalCostRiskScore_Rank_57_Min : STORED('TotalCostRiskScore_Rank_57_Min') ;
        export string10 TotalCostRiskScore_Rank_57_Max   := V5_Defaults.TotalCostRiskScore_Rank_57_Max : STORED('TotalCostRiskScore_Rank_57_Max') ;
        export string10 TotalCostRiskScore_Rank_58_Min   := V5_Defaults.TotalCostRiskScore_Rank_58_Min : STORED('TotalCostRiskScore_Rank_58_Min') ;
        export string10 TotalCostRiskScore_Rank_58_Max   := V5_Defaults.TotalCostRiskScore_Rank_58_Max : STORED('TotalCostRiskScore_Rank_58_Max') ;
        export string10 TotalCostRiskScore_Rank_59_Min   := V5_Defaults.TotalCostRiskScore_Rank_59_Min : STORED('TotalCostRiskScore_Rank_59_Min') ;
        export string10 TotalCostRiskScore_Rank_59_Max   := V5_Defaults.TotalCostRiskScore_Rank_59_Max : STORED('TotalCostRiskScore_Rank_59_Max') ;
        export string10 TotalCostRiskScore_Rank_60_Min   := V5_Defaults.TotalCostRiskScore_Rank_60_Min : STORED('TotalCostRiskScore_Rank_60_Min') ;
        export string10 TotalCostRiskScore_Rank_60_Max   := V5_Defaults.TotalCostRiskScore_Rank_60_Max : STORED('TotalCostRiskScore_Rank_60_Max') ;
        export string10 TotalCostRiskScore_Rank_61_Min   := V5_Defaults.TotalCostRiskScore_Rank_61_Min : STORED('TotalCostRiskScore_Rank_61_Min') ;
        export string10 TotalCostRiskScore_Rank_61_Max   := V5_Defaults.TotalCostRiskScore_Rank_61_Max : STORED('TotalCostRiskScore_Rank_61_Max') ;
        export string10 TotalCostRiskScore_Rank_62_Min   := V5_Defaults.TotalCostRiskScore_Rank_62_Min : STORED('TotalCostRiskScore_Rank_62_Min') ;
        export string10 TotalCostRiskScore_Rank_62_Max   := V5_Defaults.TotalCostRiskScore_Rank_62_Max : STORED('TotalCostRiskScore_Rank_62_Max') ;
        export string10 TotalCostRiskScore_Rank_63_Min   := V5_Defaults.TotalCostRiskScore_Rank_63_Min : STORED('TotalCostRiskScore_Rank_63_Min') ;
        export string10 TotalCostRiskScore_Rank_63_Max   := V5_Defaults.TotalCostRiskScore_Rank_63_Max : STORED('TotalCostRiskScore_Rank_63_Max') ;
        export string10 TotalCostRiskScore_Rank_64_Min   := V5_Defaults.TotalCostRiskScore_Rank_64_Min : STORED('TotalCostRiskScore_Rank_64_Min') ;
        export string10 TotalCostRiskScore_Rank_64_Max   := V5_Defaults.TotalCostRiskScore_Rank_64_Max : STORED('TotalCostRiskScore_Rank_64_Max') ;
        export string10 TotalCostRiskScore_Rank_65_Min   := V5_Defaults.TotalCostRiskScore_Rank_65_Min : STORED('TotalCostRiskScore_Rank_65_Min') ;
        export string10 TotalCostRiskScore_Rank_65_Max   := V5_Defaults.TotalCostRiskScore_Rank_65_Max : STORED('TotalCostRiskScore_Rank_65_Max') ;
        export string10 TotalCostRiskScore_Rank_66_Min   := V5_Defaults.TotalCostRiskScore_Rank_66_Min : STORED('TotalCostRiskScore_Rank_66_Min') ;
        export string10 TotalCostRiskScore_Rank_66_Max   := V5_Defaults.TotalCostRiskScore_Rank_66_Max : STORED('TotalCostRiskScore_Rank_66_Max') ;
        export string10 TotalCostRiskScore_Rank_67_Min   := V5_Defaults.TotalCostRiskScore_Rank_67_Min : STORED('TotalCostRiskScore_Rank_67_Min') ;
        export string10 TotalCostRiskScore_Rank_67_Max   := V5_Defaults.TotalCostRiskScore_Rank_67_Max : STORED('TotalCostRiskScore_Rank_67_Max') ;
        export string10 TotalCostRiskScore_Rank_68_Min   := V5_Defaults.TotalCostRiskScore_Rank_68_Min : STORED('TotalCostRiskScore_Rank_68_Min') ;
        export string10 TotalCostRiskScore_Rank_68_Max   := V5_Defaults.TotalCostRiskScore_Rank_68_Max : STORED('TotalCostRiskScore_Rank_68_Max') ;
        export string10 TotalCostRiskScore_Rank_69_Min   := V5_Defaults.TotalCostRiskScore_Rank_69_Min : STORED('TotalCostRiskScore_Rank_69_Min') ;
        export string10 TotalCostRiskScore_Rank_69_Max   := V5_Defaults.TotalCostRiskScore_Rank_69_Max : STORED('TotalCostRiskScore_Rank_69_Max') ;
        export string10 TotalCostRiskScore_Rank_70_Min   := V5_Defaults.TotalCostRiskScore_Rank_70_Min : STORED('TotalCostRiskScore_Rank_70_Min') ;
        export string10 TotalCostRiskScore_Rank_70_Max   := V5_Defaults.TotalCostRiskScore_Rank_70_Max : STORED('TotalCostRiskScore_Rank_70_Max') ;
        export string10 TotalCostRiskScore_Rank_71_Min   := V5_Defaults.TotalCostRiskScore_Rank_71_Min : STORED('TotalCostRiskScore_Rank_71_Min') ;
        export string10 TotalCostRiskScore_Rank_71_Max   := V5_Defaults.TotalCostRiskScore_Rank_71_Max : STORED('TotalCostRiskScore_Rank_71_Max') ;
        export string10 TotalCostRiskScore_Rank_72_Min   := V5_Defaults.TotalCostRiskScore_Rank_72_Min : STORED('TotalCostRiskScore_Rank_72_Min') ;
        export string10 TotalCostRiskScore_Rank_72_Max   := V5_Defaults.TotalCostRiskScore_Rank_72_Max : STORED('TotalCostRiskScore_Rank_72_Max') ;
        export string10 TotalCostRiskScore_Rank_73_Min   := V5_Defaults.TotalCostRiskScore_Rank_73_Min : STORED('TotalCostRiskScore_Rank_73_Min') ;
        export string10 TotalCostRiskScore_Rank_73_Max   := V5_Defaults.TotalCostRiskScore_Rank_73_Max : STORED('TotalCostRiskScore_Rank_73_Max') ;
        export string10 TotalCostRiskScore_Rank_74_Min   := V5_Defaults.TotalCostRiskScore_Rank_74_Min : STORED('TotalCostRiskScore_Rank_74_Min') ;
        export string10 TotalCostRiskScore_Rank_74_Max   := V5_Defaults.TotalCostRiskScore_Rank_74_Max : STORED('TotalCostRiskScore_Rank_74_Max') ;
        export string10 TotalCostRiskScore_Rank_75_Min   := V5_Defaults.TotalCostRiskScore_Rank_75_Min : STORED('TotalCostRiskScore_Rank_75_Min') ;
        export string10 TotalCostRiskScore_Rank_75_Max   := V5_Defaults.TotalCostRiskScore_Rank_75_Max : STORED('TotalCostRiskScore_Rank_75_Max') ;
        export string10 TotalCostRiskScore_Rank_76_Min   := V5_Defaults.TotalCostRiskScore_Rank_76_Min : STORED('TotalCostRiskScore_Rank_76_Min') ;
        export string10 TotalCostRiskScore_Rank_76_Max   := V5_Defaults.TotalCostRiskScore_Rank_76_Max : STORED('TotalCostRiskScore_Rank_76_Max') ;
        export string10 TotalCostRiskScore_Rank_77_Min   := V5_Defaults.TotalCostRiskScore_Rank_77_Min : STORED('TotalCostRiskScore_Rank_77_Min') ;
        export string10 TotalCostRiskScore_Rank_77_Max   := V5_Defaults.TotalCostRiskScore_Rank_77_Max : STORED('TotalCostRiskScore_Rank_77_Max') ;
        export string10 TotalCostRiskScore_Rank_78_Min   := V5_Defaults.TotalCostRiskScore_Rank_78_Min : STORED('TotalCostRiskScore_Rank_78_Min') ;
        export string10 TotalCostRiskScore_Rank_78_Max   := V5_Defaults.TotalCostRiskScore_Rank_78_Max : STORED('TotalCostRiskScore_Rank_78_Max') ;
        export string10 TotalCostRiskScore_Rank_79_Min   := V5_Defaults.TotalCostRiskScore_Rank_79_Min : STORED('TotalCostRiskScore_Rank_79_Min') ;
        export string10 TotalCostRiskScore_Rank_79_Max   := V5_Defaults.TotalCostRiskScore_Rank_79_Max : STORED('TotalCostRiskScore_Rank_79_Max') ;
        export string10 TotalCostRiskScore_Rank_80_Min   := V5_Defaults.TotalCostRiskScore_Rank_80_Min : STORED('TotalCostRiskScore_Rank_80_Min') ;
        export string10 TotalCostRiskScore_Rank_80_Max   := V5_Defaults.TotalCostRiskScore_Rank_80_Max : STORED('TotalCostRiskScore_Rank_80_Max') ;
        export string10 TotalCostRiskScore_Rank_81_Min   := V5_Defaults.TotalCostRiskScore_Rank_81_Min : STORED('TotalCostRiskScore_Rank_81_Min') ;
        export string10 TotalCostRiskScore_Rank_81_Max   := V5_Defaults.TotalCostRiskScore_Rank_81_Max : STORED('TotalCostRiskScore_Rank_81_Max') ;
        export string10 TotalCostRiskScore_Rank_82_Min   := V5_Defaults.TotalCostRiskScore_Rank_82_Min : STORED('TotalCostRiskScore_Rank_82_Min') ;
        export string10 TotalCostRiskScore_Rank_82_Max   := V5_Defaults.TotalCostRiskScore_Rank_82_Max : STORED('TotalCostRiskScore_Rank_82_Max') ;
        export string10 TotalCostRiskScore_Rank_83_Min   := V5_Defaults.TotalCostRiskScore_Rank_83_Min : STORED('TotalCostRiskScore_Rank_83_Min') ;
        export string10 TotalCostRiskScore_Rank_83_Max   := V5_Defaults.TotalCostRiskScore_Rank_83_Max : STORED('TotalCostRiskScore_Rank_83_Max') ;
        export string10 TotalCostRiskScore_Rank_84_Min   := V5_Defaults.TotalCostRiskScore_Rank_84_Min : STORED('TotalCostRiskScore_Rank_84_Min') ;
        export string10 TotalCostRiskScore_Rank_84_Max   := V5_Defaults.TotalCostRiskScore_Rank_84_Max : STORED('TotalCostRiskScore_Rank_84_Max') ;
        export string10 TotalCostRiskScore_Rank_85_Min   := V5_Defaults.TotalCostRiskScore_Rank_85_Min : STORED('TotalCostRiskScore_Rank_85_Min') ;
        export string10 TotalCostRiskScore_Rank_85_Max   := V5_Defaults.TotalCostRiskScore_Rank_85_Max : STORED('TotalCostRiskScore_Rank_85_Max') ;
        export string10 TotalCostRiskScore_Rank_86_Min   := V5_Defaults.TotalCostRiskScore_Rank_86_Min : STORED('TotalCostRiskScore_Rank_86_Min') ;
        export string10 TotalCostRiskScore_Rank_86_Max   := V5_Defaults.TotalCostRiskScore_Rank_86_Max : STORED('TotalCostRiskScore_Rank_86_Max') ;
        export string10 TotalCostRiskScore_Rank_87_Min   := V5_Defaults.TotalCostRiskScore_Rank_87_Min : STORED('TotalCostRiskScore_Rank_87_Min') ;
        export string10 TotalCostRiskScore_Rank_87_Max   := V5_Defaults.TotalCostRiskScore_Rank_87_Max : STORED('TotalCostRiskScore_Rank_87_Max') ;
        export string10 TotalCostRiskScore_Rank_88_Min   := V5_Defaults.TotalCostRiskScore_Rank_88_Min : STORED('TotalCostRiskScore_Rank_88_Min') ;
        export string10 TotalCostRiskScore_Rank_88_Max   := V5_Defaults.TotalCostRiskScore_Rank_88_Max : STORED('TotalCostRiskScore_Rank_88_Max') ;
        export string10 TotalCostRiskScore_Rank_89_Min   := V5_Defaults.TotalCostRiskScore_Rank_89_Min : STORED('TotalCostRiskScore_Rank_89_Min') ;
        export string10 TotalCostRiskScore_Rank_89_Max   := V5_Defaults.TotalCostRiskScore_Rank_89_Max : STORED('TotalCostRiskScore_Rank_89_Max') ;
        export string10 TotalCostRiskScore_Rank_90_Min   := V5_Defaults.TotalCostRiskScore_Rank_90_Min : STORED('TotalCostRiskScore_Rank_90_Min') ;
        export string10 TotalCostRiskScore_Rank_90_Max   := V5_Defaults.TotalCostRiskScore_Rank_90_Max : STORED('TotalCostRiskScore_Rank_90_Max') ;
        export string10 TotalCostRiskScore_Rank_91_Min   := V5_Defaults.TotalCostRiskScore_Rank_91_Min : STORED('TotalCostRiskScore_Rank_91_Min') ;
        export string10 TotalCostRiskScore_Rank_91_Max   := V5_Defaults.TotalCostRiskScore_Rank_91_Max : STORED('TotalCostRiskScore_Rank_91_Max') ;
        export string10 TotalCostRiskScore_Rank_92_Min   := V5_Defaults.TotalCostRiskScore_Rank_92_Min : STORED('TotalCostRiskScore_Rank_92_Min') ;
        export string10 TotalCostRiskScore_Rank_92_Max   := V5_Defaults.TotalCostRiskScore_Rank_92_Max : STORED('TotalCostRiskScore_Rank_92_Max') ;
        export string10 TotalCostRiskScore_Rank_93_Min   := V5_Defaults.TotalCostRiskScore_Rank_93_Min : STORED('TotalCostRiskScore_Rank_93_Min') ;
        export string10 TotalCostRiskScore_Rank_93_Max   := V5_Defaults.TotalCostRiskScore_Rank_93_Max : STORED('TotalCostRiskScore_Rank_93_Max') ;
        export string10 TotalCostRiskScore_Rank_94_Min   := V5_Defaults.TotalCostRiskScore_Rank_94_Min : STORED('TotalCostRiskScore_Rank_94_Min') ;
        export string10 TotalCostRiskScore_Rank_94_Max   := V5_Defaults.TotalCostRiskScore_Rank_94_Max : STORED('TotalCostRiskScore_Rank_94_Max') ;
        export string10 TotalCostRiskScore_Rank_95_Min   := V5_Defaults.TotalCostRiskScore_Rank_95_Min : STORED('TotalCostRiskScore_Rank_95_Min') ;
        export string10 TotalCostRiskScore_Rank_95_Max   := V5_Defaults.TotalCostRiskScore_Rank_95_Max : STORED('TotalCostRiskScore_Rank_95_Max') ;
        export string10 TotalCostRiskScore_Rank_96_Min   := V5_Defaults.TotalCostRiskScore_Rank_96_Min : STORED('TotalCostRiskScore_Rank_96_Min') ;
        export string10 TotalCostRiskScore_Rank_96_Max   := V5_Defaults.TotalCostRiskScore_Rank_96_Max : STORED('TotalCostRiskScore_Rank_96_Max') ;
        export string10 TotalCostRiskScore_Rank_97_Min   := V5_Defaults.TotalCostRiskScore_Rank_97_Min : STORED('TotalCostRiskScore_Rank_97_Min') ;
        export string10 TotalCostRiskScore_Rank_97_Max   := V5_Defaults.TotalCostRiskScore_Rank_97_Max : STORED('TotalCostRiskScore_Rank_97_Max') ;
        export string10 TotalCostRiskScore_Rank_98_Min   := V5_Defaults.TotalCostRiskScore_Rank_98_Min : STORED('TotalCostRiskScore_Rank_98_Min') ;
        export string10 TotalCostRiskScore_Rank_98_Max   := V5_Defaults.TotalCostRiskScore_Rank_98_Max : STORED('TotalCostRiskScore_Rank_98_Max') ;
        export string10 TotalCostRiskScore_Rank_99_Min   := V5_Defaults.TotalCostRiskScore_Rank_99_Min : STORED('TotalCostRiskScore_Rank_99_Min') ;
        export string10 TotalCostRiskScore_Rank_99_Max   := V5_Defaults.TotalCostRiskScore_Rank_99_Max : STORED('TotalCostRiskScore_Rank_99_Max') ;
        export string10 TotalCostRiskScore_Rank_100_Min  := V5_Defaults.TotalCostRiskScore_Rank_100_Min : STORED('TotalCostRiskScore_Rank_100_Min');

        export string3 TotalCostRiskScore_Category_5_Low  := V5_Defaults.TotalCostRiskScore_Category_5_Low  : STORED('TotalCostRiskScore_Category_5_Low');
        export string3 TotalCostRiskScore_Category_4_High := V5_Defaults.TotalCostRiskScore_Category_4_High : STORED('TotalCostRiskScore_Category_4_High');
        export string3 TotalCostRiskScore_Category_4_Low  := V5_Defaults.TotalCostRiskScore_Category_4_Low  : STORED('TotalCostRiskScore_Category_4_Low');
        export string3 TotalCostRiskScore_Category_3_High := V5_Defaults.TotalCostRiskScore_Category_3_High : STORED('TotalCostRiskScore_Category_3_High');
        export string3 TotalCostRiskScore_Category_3_Low  := V5_Defaults.TotalCostRiskScore_Category_3_Low  : STORED('TotalCostRiskScore_Category_3_Low');
        export string3 TotalCostRiskScore_Category_2_High := V5_Defaults.TotalCostRiskScore_Category_2_High : STORED('TotalCostRiskScore_Category_2_High');
        export string3 TotalCostRiskScore_Category_2_Low  := V5_Defaults.TotalCostRiskScore_Category_2_Low  : STORED('TotalCostRiskScore_Category_2_Low');
        export string3 TotalCostRiskScore_Category_1_High := V5_Defaults.TotalCostRiskScore_Category_1_High : STORED('TotalCostRiskScore_Category_1_High');

	END;