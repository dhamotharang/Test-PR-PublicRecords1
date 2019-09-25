Import Models;

EXPORT Healthcare_SocioEconomic_Transforms_Batch_Service_V5 := MODULE

	EXPORT AddScoreCategories(ds, 
							SuppressResultsForOptOuts,
							ReadmissionScore_Category_5_Low,
							ReadmissionScore_Category_4_Low,
							ReadmissionScore_Category_3_Low,
							ReadmissionScore_Category_2_Low,
							MedicationAdherenceScore_Category_4_Low,
							MedicationAdherenceScore_Category_3_Low,
							MedicationAdherenceScore_Category_2_Low,
							MedicationAdherenceScore_Category_1_Low,
							MotivationScore_Category_4_Low,
							MotivationScore_Category_3_Low,
							MotivationScore_Category_2_Low,
							MotivationScore_Category_1_Low
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
   								SeRs_Score < ReadmissionScore_Category_2_Low => '1',
   								SeRs_Score < ReadmissionScore_Category_3_Low => '2',
   								SeRs_Score < ReadmissionScore_Category_4_Low => '3',
   								SeRs_Score < ReadmissionScore_Category_5_Low => '4',
   								SeRs_Score >= ReadmissionScore_Category_5_Low => '5',
   								'N/A');
		SELF.ReadmissionScore_Category := IF(_SuppressOutput, _OptOutMessage, SeRs_Category);
		SeMA_Score := (DECIMAL32_16)L.SeMA_Score;
		SeMA_Score_Str := trim(L.SeMA_Score, left, right);
		SeMA_Category := (string) MAP(
								SeMA_Score_Str = 'N/A' => 'N/A',
								SeMA_Score_Str = _blank => _blank,
  								SeMA_Score < MedicationAdherenceScore_category_4_Low => '5',
  								SeMA_Score < MedicationAdherenceScore_category_3_Low => '4',
  								SeMA_Score < MedicationAdherenceScore_category_2_Low => '3',
  								SeMA_Score < MedicationAdherenceScore_category_1_Low => '2',
  								SeMA_Score >= MedicationAdherenceScore_Category_1_Low => '1',
  								'N/A');
		SELF.MedicationAdherenceScore_Category := IF(_SuppressOutput, _OptOutMessage,SeMA_Category);
		SeMO_Score := (DECIMAL32_16)L.SeMO_Score;
		SeMO_Score_Str := trim(L.SeMO_Score, left, right);
		SeMO_Category := (string) MAP(
								SeMO_Score_Str = 'N/A' => 'N/A',
								SeMO_Score_Str = _blank => _blank,
  								SeMO_Score < MotivationScore_category_4_Low => '5',
  								SeMO_Score < MotivationScore_category_3_Low => '4',
  								SeMO_Score < MotivationScore_category_2_Low => '3',
  								SeMO_Score < MotivationScore_category_1_Low => '2',
  								SeMO_Score >= MotivationScore_Category_1_Low => '1',
  								'N/A');
		SELF.MotivationScore_Category := IF(_SuppressOutput, _OptOutMessage,SeMO_Category);
		SELF := L;
		END;
		result := PROJECT(ds, doXform(LEFT, SuppressResultsForOptOuts));
	RETURN result;
	ENDMACRO;

END;
