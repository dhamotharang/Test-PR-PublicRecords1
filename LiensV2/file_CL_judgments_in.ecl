export file_CL_judgments_in := dataset('~thor_data400::in::liens::20060427::chicago_law::judgments',LiensV2.Layout_liens_CL_judgments,csv(separator('\\')))
                            +  dataset('~thor_data400::in::liens::20060627::cgl::judgmts',LiensV2.Layout_Liens_CL_Judgments,csv(separator('\\')));
