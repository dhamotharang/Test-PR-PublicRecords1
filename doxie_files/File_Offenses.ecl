import doxie_build,corrections,hygenics_crim;

 ds:= dataset('~thor_Data400::base::Corrections_offenses_' + doxie_build.buildstate + '_BUILT',hygenics_crim.Layout_Base_Offenses_with_OffenseCategory,flat);

 corrections.layout_offense_common oldFile(ds l) := transform
		self := l;
 end;
	
 export File_Offenses :=	project(ds, oldFile(left));