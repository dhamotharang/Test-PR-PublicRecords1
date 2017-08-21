export File_in_provideraddresstype := Module
export Allied_Health := dataset('~thor_data400::in::ingenix_natlprof_alliedhealth_provideraddresstype',Ingenix_NatlProf.Layout_in_provideraddresstype.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export DentalProf :=  dataset('~thor_data400::in::ingenix_natlprof_dentists_provideraddresstype',Ingenix_NatlProf.Layout_in_provideraddresstype.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export Physician :=  dataset('~thor_data400::in::ingenix_natlprof_physicians_provideraddresstype',Ingenix_NatlProf.Layout_in_provideraddresstype.raw,CSV(quote(''),separator('|'), maxlength(8192)));
export Allsrc := dataset( '~thor_data400::in::Ingenix_NatlProf_provideraddresstype',Ingenix_NatlProf.Layout_in_provideraddresstype.raw_srctype,CSV(quote(''),separator('|'), maxlength(8192)));

end;