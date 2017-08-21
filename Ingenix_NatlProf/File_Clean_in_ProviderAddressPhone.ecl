import Ingenix_Natlprof, address;

file_in := Ingenix_NatlProf.File_in_ProviderAddressPhone;

new_rec := record

Ingenix_Natlprof.Layout_in_ProviderAddressPhone;
string8  dt_first_seen;
string8  dt_last_seen;
string8  dt_vendor_first_reported;
string8  dt_vendor_last_reported;    
end;

new_rec tcleaning(file_in L) := transform

self.phonenumber   := ADDRESS.CleanPhone(L.phonenumber);
self.dt_first_seen              := '';
self.dt_last_seen               := '';
self.dt_vendor_first_reported   := L.processdate;
self.dt_vendor_last_reported    := L.processdate;
self := L;

end;


export File_Clean_in_ProviderAddressPhone := project(file_in, tcleaning(left));