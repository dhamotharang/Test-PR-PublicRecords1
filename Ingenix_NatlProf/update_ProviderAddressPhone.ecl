import Ingenix_NatlProf,address,ut;


in_file := File_in_ProviderAddressPhone.Allsrc  ;

new_rec := record

Ingenix_Natlprof.Layout_in_ProviderAddressphone.raw_srctype;
string8  dt_first_seen;
string8  dt_last_seen;
string8  dt_vendor_first_reported;
string8  dt_vendor_last_reported;    
end;

//append date and clean phone
new_rec  tappending(Ingenix_Natlprof.Layout_in_ProviderAddressphone.raw_srctype L) := Transform

self.phonenumber   := ADDRESS.CleanPhone(L.phonenumber);
self.dt_first_seen              := '';
self.dt_last_seen               := '';
self.dt_vendor_first_reported   := L.processdate;
self.dt_vendor_last_reported    := L.processdate;
self := L;

end;

ProviderAddressphone := project(in_file, tappending(left));

file_dist := distribute(ProviderAddressphone, hash(FILETYP, ProviderID, addressID));
file_sort := sort(file_dist,FILETYP, ProviderID,AddressID, PhoneNumber,PhoneType, -ProcessDate, local);

new_rec  rollupXform(new_rec l, new_rec r) := transform

self.Processdate    := if(l.Processdate > r.Processdate, l.Processdate, r.Processdate);
self.dt_First_Seen := if(l.dt_First_Seen > r.dt_First_Seen, r.dt_First_Seen, l.dt_First_Seen);
self.Dt_Last_Seen  := if(l.Dt_Last_Seen  < r.dt_Last_Seen,  r.dt_Last_Seen,  l.dt_Last_Seen);
self.dt_Vendor_First_Reported := if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
self.dt_Vendor_Last_Reported  := if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);
self := l;
end;

export update_ProviderAddressphone := rollup(file_sort,rollupXform(LEFT,RIGHT),FILETYP, ProviderID,AddressID, PhoneNumber,PhoneType, local);  