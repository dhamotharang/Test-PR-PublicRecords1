import doxie, data_services;

df := file_in_civil_court_case_activity;


export Key_caseID_activity := index(df,
                                    {case_key},
                                    {df},
                                    data_services.data_location.prefix() + 'thor_data400::key::civil_court_case_activity::' + doxie.Version_SuperKey+'::caseid');