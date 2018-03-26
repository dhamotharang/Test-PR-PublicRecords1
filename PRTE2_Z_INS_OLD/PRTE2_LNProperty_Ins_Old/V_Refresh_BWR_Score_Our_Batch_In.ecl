// EXPORT V_Refresh_Score_Our_Batch_In := 'todo';
IMPORT PRTE2_LNProperty;

batch_in := PRTE2_LNProperty.Files.LNP_Scramble_SF_DS;
scored_data := PRTE2_LNProperty.V_Refresh_data_fn_Score_BatchIn(batch_in);
OUTPUT(scored_data,,PRTE2_LNProperty.V_Refresh_Data_Base_Files.RefreshBaseScoredBatchIn,overwrite);