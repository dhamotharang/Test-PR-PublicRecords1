Import $, STD;  

Output(History_Analysis.Fn_BuildDeltas,, '~history_analysis_prod::base::counted_deltas', Thor, Compressed, Overwrite);


Sequential(
 STD.File.StartSuperFileTransaction(),
    
 STD.File.AddSuperFile('~thor_data400::history_analysis::base::counted_deltas', '~history_analysis_prod::base::counted_deltas'),
 STD.File.FinishSuperFileTransaction()
);
