
export File_in_ProviderAddressTaxID := Module
  export Allied_Health := dataset('~thor_data400::in::ingenix_natlprof_alliedhealth_provideraddresstaxid',Ingenix_NatlProf.Layout_in_ProviderAddressTaxID.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export DentalProf :=  dataset('~thor_data400::in::ingenix_natlprof_dentists_provideraddresstaxid',Ingenix_NatlProf.Layout_in_ProviderAddressTaxID.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export Physician :=  dataset('~thor_data400::in::ingenix_natlprof_physicians_provideraddresstaxid',Ingenix_NatlProf.Layout_in_ProviderAddressTaxID.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export Allsrc           := dataset('~thor_data400::in::Ingenix_NatlProf_ProviderTaxID',Ingenix_NatlProf.Layout_in_ProviderAddressTaxID.raw_srctype,CSV(quote(''),separator('|'), maxlength(8192)));
end;


