IMPORT ut,Scoring_Project_Macros, scoring_project_ks;
date_in :=  ut.GetDate + '_1';



socioeconomic_v5_batch := Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_SOCIO_Monitoring_v5_LAYOUT;


scoring_project_ks.bwr_SOCIO_get_score_details('socioeconomic_v5_batch','SeRs_Score', date_in, test1);
scoring_project_ks.bwr_SOCIO_get_score_details('socioeconomic_v5_batch','SeMA_Score', date_in, test2);
scoring_project_ks.bwr_SOCIO_get_score_details('socioeconomic_v5_batch','SeMo_Score', date_in, test3);


seq1 := SEQUENTIAL(test1, test2, test3);			
RETURN seq1;

//EXPORT bwr_SOCIO_runbins := 'todo';