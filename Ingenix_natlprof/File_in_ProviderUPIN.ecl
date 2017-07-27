import Ingenix_Natlprof;

file_in:= Ingenix_Natlprof.File_ProviderUPIN_Update;

new_rec := record

Ingenix_Natlprof.Layout_in_ProviderUPIN;
string8  dt_first_seen;
    string8  dt_last_seen;
    string8  dt_vendor_first_reported;
    string8  dt_vendor_last_reported;
end;

new_rec  tadddates(ingenix_Natlprof.Layout_in_ProviderUPIN L) := Transform

self.dt_first_seen := '';
self.dt_last_seen := '';
self.dt_vendor_first_reported := L.processdate;
self.dt_vendor_last_reported := L.processdate;

self  := L;

end;



export File_in_ProviderUPIN := project(file_in, tadddates(left));
