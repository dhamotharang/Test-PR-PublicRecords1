import AlertList;

EXPORT AlertColumnDistributions(string JobId, string ColumnName) := FUNCTION
  
  d1 := AlertList.AlertOutput(JobId);
	d2 := table(d1, { alert_person_1,
	/*
MAP(ColumnName='totalcnt'=>totalcnt,
MAP(ColumnName='firstdegrees'=>firstdegrees,
MAP(ColumnName='seconddegrees'=>seconddegrees,
MAP(ColumnName='cohesivity'=>cohesivity,
MAP(ColumnName='active_company_count'=>active_company_count,
MAP(ColumnName='active_company_0'=>active_company_0,
MAP(ColumnName='active_company_1'=>active_company_1,
MAP(ColumnName='active_company_2'=>active_company_2,
MAP(ColumnName='alert_company_count'=>alert_company_count,
MAP(ColumnName='alert_company_0'=>alert_company_0,
MAP(ColumnName='alert_company_1'=>alert_company_1,
MAP(ColumnName='alert_company_2'=>alert_company_2,
MAP(ColumnName='active_person_count'=>active_person_count,
MAP(ColumnName='active_person_0'=>active_person_count,
MAP(ColumnName='active_person_1'=>active_person_1,
MAP(ColumnName='active_person_2'=>active_person_2,
MAP(ColumnName='alert_person_count'=>alert_person_count,
MAP(ColumnName='alert_person_0'=>alert_person_0,
MAP(ColumnName='alert_person_1'=>alert_person_1, 
                                 alert_person_2
    ))))))))))))))))),
  */
			 total := count(group)}, 
			 /*
MAP(ColumnName='totalcnt'=>totalcnt,
MAP(ColumnName='firstdegrees'=>firstdegrees,
MAP(ColumnName='seconddegrees'=>seconddegrees,
MAP(ColumnName='cohesivity'=>cohesivity,
MAP(ColumnName='active_company_count'=>active_company_count,
MAP(ColumnName='active_company_0'=>active_company_0,
MAP(ColumnName='active_company_1'=>active_company_1,
MAP(ColumnName='active_company_2'=>active_company_2,
MAP(ColumnName='alert_company_count'=>alert_company_count,
MAP(ColumnName='alert_company_0'=>alert_company_0,
MAP(ColumnName='alert_company_1'=>alert_company_1,
MAP(ColumnName='alert_company_2'=>alert_company_2,
MAP(ColumnName='active_person_count'=>active_person_count,
MAP(ColumnName='active_person_0'=>active_person_count,
MAP(ColumnName='active_person_1'=>active_person_1,
MAP(ColumnName='active_person_2'=>active_person_2,
MAP(ColumnName='alert_person_count'=>alert_person_count,
MAP(ColumnName='alert_person_0'=>alert_person_0,
MAP(ColumnName='alert_person_1'=>alert_person_1,
                                 alert_person_2
*/
    /*)))))))))))))))))*/ alert_person_1, few);
RETURN d2;
END;

