import Crim_Common, CrimSrch, Corrections, hygenics_search,hygenics_crim;

//FCRA data files mapped to a NONFCRA layout
export File_FCRA_Criminal := module

export Offenders 			:= dataset('~thor_data400::base::fcra_corrections_offenders_public', corrections.layout_offender, flat)(Vendor not in hygenics_search.sCourt_Vendors_To_Omit);


ds                    := dataset('~thor_data400::base::corrections_court_offenses_public', hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory, flat)(Vendor not in hygenics_search.sCourt_Vendors_To_Omit);
corrections.layout_CourtOffenses oldFile1(ds l) := transform
		self := l;
end;
export Court_offenses:=	project(ds, oldFile1(left));


ds2 			:= dataset('~thor_data400::base::corrections_offenses_public', hygenics_crim.Layout_Base_Offenses_with_OffenseCategory, flat)(Vendor not in hygenics_search.sCourt_Vendors_To_Omit);
corrections.layout_offense oldFile2(ds2 l) := transform
		self := l;
end;
export Offenses:=	project(ds2, oldFile2(left));

//export Activity 			:= dataset('~thor_data400::base::corrections_activity_public', corrections.layout_activity, flat)(Vendor not in hygenics_search.sCourt_Vendors_To_Omit);

end;