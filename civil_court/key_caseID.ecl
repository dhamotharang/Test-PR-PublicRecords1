import doxie, ut;

df := file_in_civil_court_party;


export Key_caseID := index(df,{case_key},{df},
          '~thor_data400::key::civil_court_party::' + doxie.Version_SuperKey+'::caseid');					
					
