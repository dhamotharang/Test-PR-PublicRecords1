import ut;
export file_in_civil_court_case_activity := 
         dataset(ut.foreign_prod+'thor_200::base::civil_case_activity_'+ civil_court.Version_Development,
				      civil_court.Layout_Roxie_Case_Activity,flat);