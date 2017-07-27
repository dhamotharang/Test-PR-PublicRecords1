import Crim_Common, CrimSrch, Corrections, hygenics_search;

//FCRA data files mapped to a NONFCRA layout
export File_FCRA_Criminal := module

export Offenders := dataset('~thor_data400::base::fcra::life_eir::criminal_offenders_' + CrimSrch.Version.Development
																									, hygenics_search.Corrections_layout_offender,flat);

export Court_offenses := dataset('~thor_Data400::base::fcra::life_eir::court_offenses_' + CrimSrch.Version.Development
																									,corrections.layout_CourtOffenses,flat);


//export Activity := project(dataset('~thor_data400::base::fcra_criminal_activity_' + CrimSrch.Version.Development,Crimsrch.Layout_Moxie_Activity,flat),
//																		transform(corrections.layout_activity, SELF := left,self.process_date:= left.date_last_reported));

end;