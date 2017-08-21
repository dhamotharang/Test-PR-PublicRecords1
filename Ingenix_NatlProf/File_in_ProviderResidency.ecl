
export File_in_ProviderResidency := Module
  export Allied_Health := dataset('~thor_data400::in::ingenix_natlprof_alliedhealth_providerresidency',Ingenix_NatlProf.Layout_in_ProviderResidency.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export DentalProf :=  dataset('~thor_data400::in::ingenix_natlprof_dentists_providerresidency',Ingenix_NatlProf.Layout_in_ProviderResidency.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export Physician :=  dataset('~thor_data400::in::ingenix_natlprof_physicians_providerresidency',Ingenix_NatlProf.Layout_in_ProviderResidency.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export Allsrc           := dataset('~thor_data400::in::Ingenix_NatlProf_ProviderResidency',Ingenix_NatlProf.Layout_in_ProviderResidency.raw_srctype,CSV(quote(''),separator('|'), maxlength(8192)));
end;

