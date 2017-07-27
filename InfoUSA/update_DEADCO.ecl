import InfoUSA;

file_in   := infousa.File_DEADCO_Clean_In;

file_sort := sort(file_in, record, except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported, process_date);  

infousa.Layout_DEADCO_Clean_In  rollupXform(infousa.Layout_DEADCO_Clean_In l, infousa.Layout_DEADCO_Clean_In r) := transform
		
		self.Process_date    := if(l.Process_date > r.Process_date, l.Process_date, r.Process_date);
		self.Dt_First_Seen := if(l.dt_First_Seen > r.dt_First_Seen, r.dt_First_Seen, l.dt_First_Seen);
		self.Dt_Last_Seen  := if(l.dt_Last_Seen  < r.dt_Last_Seen,  r.dt_Last_Seen,  l.dt_Last_Seen);
		self.Dt_Vendor_First_Reported := if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);
		self := l;
end;

export Update_DEADCO := rollup(file_sort,rollupXform(LEFT,RIGHT),RECORD,
                                EXCEPT Process_date, dt_First_Seen, dt_Last_Seen,
								dt_Vendor_First_Reported, dt_Vendor_Last_Reported);





