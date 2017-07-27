export file_CL_judgments_vacated_judgments_in := dataset('~thor_data400::in::liens::20060427::chicago_law::vacated_judgments',LiensV2.Layout_Liens_CL_Vacated_judgements,csv(separator('\\')))
                                               + dataset('~thor_data400::in::liens::20060627::cgl::vacjmts',LiensV2.Layout_Liens_CL_Vacated_judgements,csv(separator('\\')));

