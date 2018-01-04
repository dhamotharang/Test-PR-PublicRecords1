import doxie, data_services;

df := file_in_civil_court_party;


export Key_caseID := index(df,{case_key},{df},
          data_services.data_location.prefix() + 'thor_data400::key::civil_court_party::' + doxie.Version_SuperKey+'::caseid');					
					
