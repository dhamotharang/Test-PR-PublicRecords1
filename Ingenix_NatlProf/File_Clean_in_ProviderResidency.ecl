import Ingenix_NatlProf;

File_in := ingenix_Natlprof.File_in_Providerresidency.Allsrc;

new_rec := record

Ingenix_Natlprof.Layout_in_ProviderResidency.raw_srctype;
string8  dt_first_seen;
    string8  dt_last_seen;
    string8  dt_vendor_first_reported;
    string8  dt_vendor_last_reported;
end;

new_rec  tcleaning(ingenix_Natlprof.Layout_in_ProviderResidency.raw_srctype L) := Transform

self.residency  := StringLib.stringfilter(L.residency, ' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz');
self.dt_first_seen := '';
self.dt_last_seen := '';
self.dt_vendor_first_reported := L.processdate;
self.dt_vendor_last_reported := L.processdate;

self := L;

end;

export File_Clean_in_ProviderResidency  := project(file_in, tcleaning(left));




