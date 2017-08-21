
export File_in_ProviderBirthDate := Module
  export Allied_Health := dataset('~thor_data400::in::ingenix_natlprof_alliedhealth_providerbirthdate',Ingenix_NatlProf.Layout_in_ProviderBirthDate.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export DentalProf :=  dataset('~thor_data400::in::ingenix_natlprof_dentists_providerbirthdate',Ingenix_NatlProf.Layout_in_ProviderBirthDate.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export Physician :=  dataset('~thor_data400::in::ingenix_natlprof_physicians_providerbirthdate',Ingenix_NatlProf.Layout_in_ProviderBirthDate.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export Allsrc           := dataset('~thor_data400::in::Ingenix_NatlProf_ProviderBirthDate',Ingenix_NatlProf.Layout_in_ProviderBirthDate.raw_srctype,CSV(quote(''),separator('|'), maxlength(8192)));
end;

