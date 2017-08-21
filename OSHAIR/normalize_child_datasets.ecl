import OSHAIR;

export normalize_child_datasets(string filedate, string process_date) := parallel(
					  OSHAIR.normalize_accidents(filedate, process_date)
           ,OSHAIR.normalize_hazardous_substances(filedate, process_date)                                                             
					 ,OSHAIR.normalize_optional_information(filedate, process_date)
           ,OSHAIR.normalize_programs(filedate, process_date)
           ,OSHAIR.normalize_related_activities(filedate, process_date)
           ,OSHAIR.normalize_violations(filedate, process_date)
								 );