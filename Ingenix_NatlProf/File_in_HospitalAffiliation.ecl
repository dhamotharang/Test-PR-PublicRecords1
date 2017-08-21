
export File_in_HospitalAffiliation :=  Module

  export Allied_Health := dataset('~thor_data400::in::ingenix_natlprof_alliedhealth_hospitalaffiliation',Ingenix_NatlProf.Layout_in_HospitalAffiliation.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export DentalProf :=  dataset('~thor_data400::in::ingenix_natlprof_dentists_hospitalaffiliation',Ingenix_NatlProf.Layout_in_HospitalAffiliation.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export Physician :=  dataset('~thor_data400::in::ingenix_natlprof_physicians_hospitalaffiliation',Ingenix_NatlProf.Layout_in_HospitalAffiliation.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export Allsrc :=  dataset('~thor_data400::in::Ingenix_NatlProf_HospitalAffiliation',Ingenix_NatlProf.Layout_in_HospitalAffiliation.raw_srctype,CSV(quote(''),separator('|'), maxlength(8192)));
end;