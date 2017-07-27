import OSHAIR;

export file_out_accident_cleaned := dataset(OSHAIR.cluster + 'out::oshair::accident_cleaned'
                                           ,OSHAIR.layout_OSHAIR_accident_clean
								           ,thor);