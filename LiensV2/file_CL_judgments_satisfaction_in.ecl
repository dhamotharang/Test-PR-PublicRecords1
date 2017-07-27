export file_CL_judgments_satisfaction_in := dataset('~thor_data400::in::liens::20060427::chicago_law::judgments_satisfaction',LiensV2.Layout_liens_CL_judgment_satisfaction,csv(separator('\\')))
                                         +  dataset('~thor_data400::in::liens::20060627::cgl::SatJmts',LiensV2.Layout_Liens_CL_Judgment_Satisfaction,csv(separator('\\')));
