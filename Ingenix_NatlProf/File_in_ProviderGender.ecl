import ingenix_natlprof;

export File_in_ProviderGender :=  Module
  export Allied_Health := dataset('~thor_data400::in::ingenix_natlprof_alliedhealth_providergender',Ingenix_NatlProf.Layout_in_ProviderGender.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export DentalProf :=  dataset('~thor_data400::in::ingenix_natlprof_dentists_providergender',Ingenix_NatlProf.Layout_in_ProviderGender.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export Physician :=  dataset('~thor_data400::in::ingenix_natlprof_physicians_providergender',Ingenix_NatlProf.Layout_in_ProviderGender.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export Allsrc :=  dataset('~thor_data400::in::Ingenix_NatlProf_ProviderGender',Ingenix_NatlProf.Layout_in_ProviderGender.raw_srctype,CSV(quote(''),separator('|'), maxlength(8192)));
end;
