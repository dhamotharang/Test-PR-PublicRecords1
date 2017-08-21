import ingenix_natlprof;

 
export File_in_ProviderDegree := Module
  export Allied_Health := dataset('~thor_data400::in::ingenix_natlprof_alliedhealth_providerdegree',Ingenix_NatlProf.Layout_in_ProviderDegree.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export DentalProf :=  dataset('~thor_data400::in::ingenix_natlprof_dentists_providerdegree',Ingenix_NatlProf.Layout_in_ProviderDegree.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export Physician :=  dataset('~thor_data400::in::ingenix_natlprof_physicians_providerdegree',Ingenix_NatlProf.Layout_in_ProviderDegree.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  File_in := dataset('~thor_data400::in::Ingenix_NatlProf_ProviderDegree',Ingenix_NatlProf.Layout_in_ProviderDegree.raw_srctype,CSV(quote(''),separator('|'), maxlength(8192)));

new_rec := record

Ingenix_Natlprof.Layout_in_ProviderDegree.raw_srctype;
string8  dt_first_seen;
    string8  dt_last_seen;
    string8  dt_vendor_first_reported;
    string8  dt_vendor_last_reported;
end;

new_rec  tadddates(ingenix_Natlprof.Layout_in_ProviderDegree.raw_srctype L) := Transform

self.dt_first_seen := '';
self.dt_last_seen := '';
self.dt_vendor_first_reported := L.processdate;
self.dt_vendor_last_reported := L.processdate;

self  := L;

end;
 export Allsrc := project(file_in, tadddates(left));
end;