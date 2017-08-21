file_in := dataset('~thor_data400::in::Ingenix_NatlProf_ProviderHospital',Ingenix_NatlProf.Layout_in_ProviderHospitalAffiliation,CSV(quote(''),separator('|'),maxlength(8192)));

new_rec := record

Ingenix_Natlprof.Layout_in_ProviderHospitalAffiliation;
string8  dt_first_seen;
    string8  dt_last_seen;
    string8  dt_vendor_first_reported;
    string8  dt_vendor_last_reported;
end;

new_rec  tadddates(ingenix_Natlprof.Layout_in_ProviderHospitalAffiliation L) := Transform

self.dt_first_seen := '';
self.dt_last_seen := '';
self.dt_vendor_first_reported := L.processdate;
self.dt_vendor_last_reported := L.processdate;

self  := L;

end;



export File_in_ProviderHospitalAffiliation := project(file_in, tadddates(left));
