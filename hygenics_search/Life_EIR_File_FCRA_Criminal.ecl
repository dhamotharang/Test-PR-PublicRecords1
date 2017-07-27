import Crim_Common, CrimSrch, Corrections, hygenics_crim;

//FCRA data files mapped to a NONFCRA layout
export Life_EIR_File_FCRA_Criminal := module

export Offenders 		:= dataset('~thor_data400::base::fcra::life_eir::criminal_offenders_' + hygenics_search.Version.Development
																									,hygenics_search.layout_offender,flat)(length(trim(offender_key, left, right))>2);

export Court_offenses 	:= dataset('~thor_Data400::base::fcra::life_eir::court_offenses_' + hygenics_search.Version.Development
																									,hygenics_search.layout_CourtOffenses,flat)(length(trim(offender_key, left, right))>2);

export Activity			:= project(dataset('~thor_data400::base::fcra_criminal_activity_' + hygenics_search.Version.Development, hygenics_search.Layout_Moxie_Activity,flat)(length(trim(offender_key, left, right))>2),
																		transform(hygenics_search.layout_activity, SELF := left, self.process_date:= left.date_last_reported));

end;