export File_in_ProviderLicense := Module
  export Allied_Health := dataset('~thor_data400::in::ingenix_natlprof_alliedhealth_providerlicense',Ingenix_NatlProf.Layout_in_ProviderLicense.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export DentalProf :=  dataset('~thor_data400::in::ingenix_natlprof_dentists_providerlicense',Ingenix_NatlProf.Layout_in_ProviderLicense.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export Physician :=  dataset('~thor_data400::in::ingenix_natlprof_physicians_providerlicense',Ingenix_NatlProf.Layout_in_ProviderLicense.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export Allsrc           := dataset('~thor_data400::in::Ingenix_NatlProf_ProviderLicense',Ingenix_NatlProf.Layout_in_ProviderLicense.raw_srctype,CSV(quote(''),separator('|'), maxlength(8192)));


end;
