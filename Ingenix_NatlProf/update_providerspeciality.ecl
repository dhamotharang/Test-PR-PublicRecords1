import Ingenix_natlprof,ut;


new_rec := record

Ingenix_Natlprof.Layout_in_ProviderSpeciality.raw_srctype;
string8  dt_first_seen;
    string8  dt_last_seen;
    string8  dt_vendor_first_reported;
    string8  dt_vendor_last_reported;
end;

file_Dist := distribute(File_in_ProviderSpeciality.Allsrc,hash(filetyp,specialityid));
file_sort := Sort(file_dist,filetyp,specialityid,ProviderID,-processdate,local);



new_rec  rollupXform(new_rec l, new_rec r) := transform
		self.Processdate    := if(l.Processdate > r.Processdate, l.Processdate, r.Processdate);
		self.dt_First_Seen := if(l.dt_First_Seen > r.dt_First_Seen, r.dt_First_Seen, l.dt_First_Seen);
		self.Dt_Last_Seen  := if(l.Dt_Last_Seen  < r.dt_Last_Seen,  r.dt_Last_Seen,  l.dt_Last_Seen);
		self.dt_Vendor_First_Reported := if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
		self.dt_Vendor_Last_Reported  := if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);
		self := l;
end;

export update_providerspeciality := rollup(file_sort,rollupXform(LEFT,RIGHT),FILETYP,specialityid,ProviderID, local);




