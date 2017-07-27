import OSHAIR;

export normalize_child_datasets(string filedate) := parallel(OSHAIR.normalize_accidents(filedate)
                                                             ,OSHAIR.normalize_hazardous_substances(filedate)                                                             
															 ,OSHAIR.normalize_optional_information(filedate)
                                                             ,OSHAIR.normalize_programs(filedate)
                                                             ,OSHAIR.normalize_related_activities(filedate)
                                                             ,OSHAIR.normalize_violations(filedate)
															 );
