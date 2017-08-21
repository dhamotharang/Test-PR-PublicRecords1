import Ingenix_NatlProf,ut;                              


in_file := File_in_ProviderBirthDate.Allsrc;

reformatDate(STRING inDate) := FUNCTION
	string clean_inDate := if (StringLib.StringFind(inDate,'/',1)=0,
									trim(stringlib.stringfilterout(regexreplace('00:00:00.000', inDate, ''), '-'),left,right),
									inDate[7..10] + inDate[1..2] + indate[4..5]
								);
	return clean_inDate;	
END;

new_rec := record

Ingenix_Natlprof.Layout_in_ProviderBirthDate.raw_srctype;
string8  dt_first_seen;
string8  dt_last_seen;
string8  dt_vendor_first_reported;
string8  dt_vendor_last_reported;    
end;

//append date and filter out junk data
new_rec  tappending(Ingenix_NatlProf.File_in_ProviderBirthDate.Allsrc L) := Transform

self.birthdate     				:= reformatDate(L.birthdate);
self.dt_first_seen              := '';
self.dt_last_seen               := '';
self.dt_vendor_first_reported   := L.processdate;
self.dt_vendor_last_reported    := L.processdate;
self := L;

end;

ProviderBirthDate := project(in_file, tappending(left));

file_dist := distribute(ProviderBirthDate, hash(FILETYP, ProviderID));
file_sort := sort(file_dist,FILETYP, ProviderID,BirthDate, -ProcessDate, local);

//rollup birthdate
new_rec  rollupXform(new_rec l, new_rec r) := transform

self.Processdate    := if(l.Processdate > r.Processdate, l.Processdate, r.Processdate);
self.dt_First_Seen := if(l.dt_First_Seen > r.dt_First_Seen, r.dt_First_Seen, l.dt_First_Seen);
self.Dt_Last_Seen  := if(l.Dt_Last_Seen  < r.dt_Last_Seen,  r.dt_Last_Seen,  l.dt_Last_Seen);
self.dt_Vendor_First_Reported := if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
self.dt_Vendor_Last_Reported  := if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);
self := l;
end;

update_ProviderBirthDate_rollup := rollup(file_sort,rollupXform(LEFT,RIGHT),FILETYP, ProviderID,BirthDate, local);  

// When there are multiple birthdates for a person and type, we only want what's "best".

// BirthDateTierTypeID is used as a tie-breaker and the IF portion is so that an id of 0 is pushed
// to the bottom of the sort pile.  Current IDs it could be are 0, 1, 2, 3, and 99.
update_ProviderBirthDate_sort := SORT(update_ProviderBirthDate_rollup,
                                      FILETYP, ProviderID, -Processdate, -BirthDateCompanyCount,
																			   IF(BirthDateTierTypeID = '0', 1, 0), BirthDateTierTypeID,
																			LOCAL);

// We're doing this to keep the earliest and latest date associated with the provider and their type,
// instead of just doing a DEDUP, which could give a misleading date... one that's associated with
// the new birthdate vs. how long the provider's been in the system.
// Since date first and last seen aren't used, not going to bother coding them in this transform.
new_rec rollup_dates(new_rec L, new_rec R) := TRANSFORM
  SELF.dt_Vendor_First_Reported := IF(L.dt_Vendor_First_Reported > R.dt_Vendor_First_Reported, R.dt_Vendor_First_Reported, L.dt_Vendor_First_Reported);
  SELF.dt_Vendor_Last_Reported := IF(L.dt_Vendor_Last_Reported < R.dt_Vendor_Last_Reported, R.dt_Vendor_Last_Reported, L.dt_Vendor_Last_Reported);

  SELF := L;
END;

export update_ProviderBirthDate := ROLLUP(update_ProviderBirthDate_sort,
                                          rollup_dates(LEFT, RIGHT),
																					FILETYP, ProviderID,
																					LOCAL);