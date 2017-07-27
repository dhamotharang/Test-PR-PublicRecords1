import doxie_build,corrections, hygenics_crim;

ds := dataset('~thor_Data400::base::corrections_court_offenses_' + doxie_build.buildstate + '_BUILT',hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory,flat);

	corrections.Layout_CourtOffenses oldFile(ds l) := transform
		self := l;
	end;
	
export file_court_offenses :=	project(ds, oldFile(left));