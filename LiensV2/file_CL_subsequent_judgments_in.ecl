export file_CL_subsequent_judgments_in := dataset('~thor_data400::in::liens::20060427::chicago_law::subsequent_judgments',LiensV2.Layout_liens_CL_subsequent_judgments,csv(separator('\\')))
                                        + dataset('~thor_data400::in::liens::20060627::cgl::subjmts',LiensV2.Layout_Liens_CL_Subsequent_Judgments,csv(separator('\\')));

