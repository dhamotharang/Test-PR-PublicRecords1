Dist_Cleaned_AMIDIR := distribute(Cleaned_AMIDIR, hash64(key + Physician_Name_Clean_fname + Physician_Name_Clean_lname));
																	
Sort_Dist_Cleaned_file := sort(Dist_Cleaned_AMIDIR,local,RECORD,
															 EXCEPT Process_Date, Date_First_Seen, Date_Last_Seen,
															 Date_Vendor_First_Reported, Date_Vendor_Last_Reported);

Layout_outfile := RECORD
		AMIDIR.Layout_AMIDIR_Common;
end;

Layout_outfile  rollupXform(Layout_outfile l, Layout_outfile r) := transform
		self.Process_Date    := if(l.Process_Date > r.Process_Date, l.Process_Date, r.Process_Date);
		self.Date_First_Seen := if(l.Date_First_Seen > r.Date_First_Seen, r.Date_First_Seen, l.Date_First_Seen);
		self.Date_Last_Seen  := if(l.Date_Last_Seen  < r.Date_Last_Seen,  r.Date_Last_Seen,  l.Date_Last_Seen);
		self.Date_Vendor_First_Reported := if(l.Date_Vendor_First_Reported > r.Date_Vendor_First_Reported, r.Date_Vendor_First_Reported, l.Date_Vendor_First_Reported);
		self.Date_Vendor_Last_Reported  := if(l.Date_Vendor_Last_Reported  < r.Date_Vendor_Last_Reported,  r.Date_Vendor_Last_Reported, l.Date_Vendor_Last_Reported);
		self := l;
end;

export Updated_AMIDIR := rollup(Sort_Dist_Cleaned_file,rollupXform(LEFT,RIGHT),RECORD,
                                EXCEPT Process_Date, Date_First_Seen, Date_Last_Seen,
																Date_Vendor_First_Reported, Date_Vendor_Last_Reported, local): persist(amidir.Cluster + 'persist::Updated_AMIDIR');
