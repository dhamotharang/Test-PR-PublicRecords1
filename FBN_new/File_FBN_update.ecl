import FBN_new, Fictitious_Business_Names;


FBN_history := Fictitious_Business_Names.Cleaned_File;
FBN_fixed := FBN_new.File_FBN_Clean_fixed;


// Normalize 2 contact names


FBN_new.Layout_FBN_update fbn_norm_names(Fictitious_Business_Names.Layout_Cleaned_File l, integer CTR) := TRANSFORM
self.CCT_Clean_title := choose(CTR,l.CCT1_Clean_title,l.CCT2_Clean_title);
self.CCT_Clean_fname := choose(CTR,l.CCT1_Clean_fname,l.CCT2_Clean_fname );
self.CCT_Clean_mname := choose(CTR,l.CCT1_Clean_mname,l.CCT2_Clean_mname );
self.CCT_Clean_lname := choose(CTR,l.CCT1_Clean_lname,l.CCT2_Clean_lname );
self.CCT_Clean_name_suffix := choose(CTR,l.CCT1_Clean_name_suffix,l.CCT2_Clean_name_suffix );
self.CCT_Clean_cleaning_score := choose(CTR,l.CCT1_Clean_cleaning_score,l.CCT2_Clean_cleaning_score );
SELF.dt_first_seen := map(L.filingdate <> ''=> (UNSIGNED4)L.filingdate, 
														L.date_last_updated >'200308' => (UNSIGNED4)L.date_last_updated,
														0);
SELF.dt_last_seen := map(L.date_last_updated >'200308' => (UNSIGNED4)L.date_last_updated,
												   L.filingdate <> ''=> (UNSIGNED4)L.filingdate,
														0);
	
SELF.dt_vendor_first_reported := (UNSIGNED4)L.date_first_updated_app;
SELF.dt_vendor_last_reported := (UNSIGNED4)L.date_last_updated_app;
self := L;
end;

fbn_history_slim := NORMALIZE(fbn_history, 2, fbn_norm_names(LEFT, COUNTER));


FBN_new.Layout_FBN_update fixed_slim(FBN_new.Layout_FBN_fixed_Clean l) := transform


SELF.dt_first_seen :=(UNSIGNED4)l.dt_first_seen;
SELF.dt_last_seen := (UNSIGNED4)l.dt_last_seen;
	
SELF.dt_vendor_first_reported := (UNSIGNED4)l.dt_vendor_first_reported;
SELF.dt_vendor_last_reported := (UNSIGNED4)l.dt_vendor_last_reported;
self.businessname            := l.bus_name;
self.date_last_updated :=  ' ';
self.infousa_fbn_key := l.bus_state +l.bus_city +hash64(l.bus_name,l.filing_date);

self := L;
end;


fbn_fixed_slim := project(fbn_fixed,fixed_slim(LEFT));

File_FBN_update_temp := fbn_history_slim + fbn_fixed_slim;

//rollup FBN history and FBN fixed

file_dist := distribute(File_FBN_update_temp, hash(infousa_fbn_key));

file_sort := sort(file_dist, infousa_fbn_key, local);  

FBN_new.Layout_FBN_update  rollupXform(FBN_new.Layout_FBN_update l, FBN_new.Layout_FBN_update r) := transform
		
		self.Process_date    := if(l.Process_date > r.Process_date, l.Process_date, r.Process_date);
		self.Dt_First_Seen := if(l.dt_First_Seen > r.dt_First_Seen, r.dt_First_Seen, l.dt_First_Seen);
		self.Dt_Last_Seen  := if(l.dt_Last_Seen  < r.dt_Last_Seen,  r.dt_Last_Seen,  l.dt_Last_Seen);
		self.Dt_Vendor_First_Reported := if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);
		self := l;
end;

export File_FBN_update := rollup(file_sort,rollupXform(LEFT,RIGHT),RECORD,
                                EXCEPT Process_date, dt_First_Seen, dt_Last_Seen,
								dt_Vendor_First_Reported, dt_Vendor_Last_Reported, local);


