import Ingenix_natlprof,ut;

new_rec := record

Ingenix_Natlprof.Layout_in_Speciality.raw_srctype;
string8  dt_first_seen;
    string8  dt_last_seen;
    string8  dt_vendor_first_reported;
    string8  dt_vendor_last_reported;
end;

// Found out that there was a junk character in the group id, so cleaning it and the speciality id,
// just in case (only want numbers).  It'll also take care any duplicates due to capitalization
// differences.
new_rec clean_record(new_rec L) := TRANSFORM
  SELF.specialityid := REGEXREPLACE('[^0-9]', L.specialityid, '');
  SELF.specialitygroupid := REGEXREPLACE('[^0-9]', L.specialitygroupid, '');
	SELF.SpecialityName := StringLib.StringToUpperCase(L.SpecialityName);

  SELF := L;
END;

file_clean := PROJECT(File_in_Speciality.Allsrc, clean_record(LEFT));
file_Dist := distribute(file_clean,hash(filetyp,specialityid));
file_sort := Sort(file_dist,filetyp,specialityid,SpecialityName,SpecialityGroupID,-processdate,local);

new_rec  rollupXform(new_rec l, new_rec r) := transform
    left_date_vend_first_reported := IF(l.dt_Vendor_First_Reported = '', '99999999', l.dt_Vendor_First_Reported);
    right_date_vend_first_reported := IF(r.dt_Vendor_First_Reported = '', '99999999', r.dt_Vendor_First_Reported);
		
		self.Processdate    := if(l.Processdate > r.Processdate, l.Processdate, r.Processdate);
		self.dt_First_Seen := if(l.dt_First_Seen > r.dt_First_Seen, r.dt_First_Seen, l.dt_First_Seen);
		self.Dt_Last_Seen  := if(l.Dt_Last_Seen  < r.dt_Last_Seen,  r.dt_Last_Seen,  l.dt_Last_Seen);
		self.dt_Vendor_First_Reported := if(left_date_vend_first_reported > right_date_vend_first_reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
		self.dt_Vendor_Last_Reported  := if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);
		self := l;
end;

export update_speciality := rollup(file_sort,rollupXform(LEFT,RIGHT),FILETYP, specialityid,SpecialityName,SpecialityGroupID,local);



