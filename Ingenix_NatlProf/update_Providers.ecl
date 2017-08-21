import Ingenix_NatlProf,ut;


in_file := Ingenix_NatlProf.File_in_Providers.Allsrc ;

file_dist := distribute(in_file, hash(FILETYP, ProviderID));
file_sort := sort(file_dist,FILETYP, ProviderID, -ProcessDate, local);

new_rec := record

Ingenix_NatlProf.Layout_in_Provider.raw_srctype;
string8  dt_first_seen;
string8  dt_last_seen;
string8  dt_vendor_first_reported;
string8  dt_vendor_last_reported;    
end;

new_rec tappending(in_file L) := transform

self.dt_first_seen              := '';
self.dt_last_seen               := '';
self.dt_vendor_first_reported   := L.processdate;
self.dt_vendor_last_reported    := L.processdate;
self := L;

end;

providers := project(file_sort, tappending(left));

new_rec  rollupXform(new_rec l, new_rec r) := transform
		self.Processdate    := if(l.Processdate > r.Processdate, l.Processdate, r.Processdate);
		self.dt_First_Seen := if(l.dt_First_Seen > r.dt_First_Seen, r.dt_First_Seen, l.dt_First_Seen);
		self.Dt_Last_Seen  := if(l.Dt_Last_Seen  < r.dt_Last_Seen,  r.dt_Last_Seen,  l.dt_Last_Seen);
		self.dt_Vendor_First_Reported := if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
		self.dt_Vendor_Last_Reported  := if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);
		self := l;
end;

export update_Providers := rollup(providers,rollupXform(LEFT,RIGHT),FILETYP, ProviderID, local);  
                              


