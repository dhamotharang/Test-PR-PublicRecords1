import doxie, ut;

df := file_in_civil_court_matter;

export Key_caseID_matter := index(df,{case_key},{df},
          '~thor_data400::key::civil_court_matter::' + doxie.Version_SuperKey+'::caseid');