
export File_in_ProviderAddressPhone :=  Module

  export Allied_Health := dataset('~thor_data400::in::ingenix_natlprof_alliedhealth_provideraddressphone',Ingenix_NatlProf.Layout_in_ProviderAddressPhone.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export DentalProf :=  dataset('~thor_data400::in::ingenix_natlprof_dentists_provideraddressphone',Ingenix_NatlProf.Layout_in_ProviderAddressPhone.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export Physician :=  dataset('~thor_data400::in::ingenix_natlprof_physicians_provideraddressphone',Ingenix_NatlProf.Layout_in_ProviderAddressPhone.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export Allsrc           := dataset('~thor_data400::in::Ingenix_NatlProf_ProviderPhone',Ingenix_NatlProf.Layout_in_ProviderAddressPhone.raw_srctype,CSV(quote(''),separator('|'), maxlength(8192)));
end;


