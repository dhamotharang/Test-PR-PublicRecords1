import ut;
export File_in_Providers := Module

  export Allied_Health := dataset('~thor_data400::in::ingenix_natlprof_alliedhealth_provider',Ingenix_NatlProf.Layout_in_Provider.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export DentalProf :=  dataset('~thor_data400::in::ingenix_natlprof_dentists_provider',Ingenix_NatlProf.Layout_in_Provider.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export Physician :=  dataset('~thor_data400::in::ingenix_natlprof_physicians_provider',Ingenix_NatlProf.Layout_in_Provider.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export Allsrc           := dataset('~thor_data400::in::Ingenix_NatlProf_ProviderID',Ingenix_NatlProf.Layout_in_Provider.raw_srctype,CSV(quote(''),separator('|'), maxlength(8192)));
end;

