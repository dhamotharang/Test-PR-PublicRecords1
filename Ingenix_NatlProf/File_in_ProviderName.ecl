
export File_in_ProviderName := Module
  export Allied_Health := dataset('~thor_data400::in::ingenix_natlprof_alliedhealth_providername',Ingenix_NatlProf.Layout_in_ProviderName.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export DentalProf :=  dataset('~thor_data400::in::ingenix_natlprof_dentists_providername',Ingenix_NatlProf.Layout_in_ProviderName.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export Physician :=  dataset('~thor_data400::in::ingenix_natlprof_physicians_providername',Ingenix_NatlProf.Layout_in_ProviderName.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export Allsrc           := dataset('~thor_data400::in::Ingenix_NatlProf_ProviderName',Ingenix_NatlProf.Layout_in_ProviderName.raw_srctype,CSV(quote(''),separator('|'), maxlength(8192)));
end;
