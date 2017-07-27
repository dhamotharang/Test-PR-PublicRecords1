import VotersV2, ut, _Validate, emerges;

Clean_In_file := VotersV2.File_Voters_Cleaned_Super;

Layout_outfile := VotersV2.Layouts_Voters.Layout_Voters_Common;

// stored values to override the year low & high range from default value to 1900 & current year.
#stored('_Validate_Year_Range_Low',  '1900');
year_high := ut.GetDate[1..4];
#stored('_Validate_Year_Range_High', year_high);
// function to fix the invalid date value and returns to ccyymmdd format.
string8 fixdate(string indate) := function
    outdate := _Validate.date.fCorrectedDateString(trim(indate,left,right));
	  return(if((integer)trim(outdate,left,right) = 0, '', outdate));
end;

Layout_outfile FixDates(Clean_In_file l) := transform
  self.dob          := fixdate(l.dob);
	self.regdate      := fixdate(l.regdate);
	self.LastDateVote := fixdate(l.LastDateVote);
	self              := l;
end;

Clean_file := project(Clean_In_file, FixDates(left));

emerges.MAC_eMerge_Date_Patch(clean_file,regdate,lastdatevote,regdate,regdate,date_fix);//Extra regdate's don't matter because Voters doesn't use them

// generating a sequence number for "vtid"
ut.MAC_Sequence_Records(date_fix,vtid,Clean_file_seq);

Dist_Cleaned_Voters := distribute(Clean_file_seq, hash64(source_state, lname, name_suffix, fname, mname, 
																	dob, prim_range, prim_name, predir, addr_suffix, postdir,
																	unit_desig, sec_range, p_city_name, st, zip));

Srt_Dist_Cleaned_Voters := sort(Dist_Cleaned_Voters, lname, fname, mname, name_suffix, prim_range, prim_name,
                                predir, addr_suffix, postdir, unit_desig, sec_range, p_city_name, st, zip, 
																phone, work_phone, local);

Layout_outfile patchVitdKeys(Dist_Cleaned_Voters l, Dist_Cleaned_Voters r) := transform
   self.vtid := if (trim(l.lname,left,right) = trim(r.lname,left,right) and 
	                  trim(l.fname,left,right) = trim(r.fname,left,right) and 
										trim(l.mname,left,right) = trim(r.mname,left,right) and 
										trim(l.name_suffix,left,right) = trim(r.name_suffix,left,right) and 
										trim(l.dob,left,right) = trim(r.dob,left,right) and 
										trim(l.prim_range,left,right) = trim(r.prim_range,left,right) and 
										trim(l.prim_name,left,right) = trim(r.prim_name,left,right) and 
										trim(l.predir,left,right) = trim(r.predir,left,right) and 
										trim(l.addr_suffix,left,right) = trim(r.addr_suffix,left,right) and 
										trim(l.postdir,left,right) = trim(r.postdir,left,right) and 
										trim(l.unit_desig,left,right) = trim(r.unit_desig,left,right) and 
										trim(l.sec_range,left,right) = trim(r.sec_range,left,right) and 
										trim(l.p_city_name,left,right) = trim(r.p_city_name,left,right) and 
										trim(l.v_city_name,left,right) = trim(r.v_city_name,left,right) and 
										trim(l.st,left,right) = trim(r.st,left,right) and 
										trim(l.zip,left,right) = trim(r.zip,left,right) and
										trim(l.phone,left,right) = trim(r.phone,left,right) and
										trim(l.work_phone,left,right) = trim(r.work_phone,left,right), l.vtid, r.vtid
	                 );
   self      := r;
end;

Clean_file_patchVtid := iterate(Srt_Dist_Cleaned_Voters, patchVitdKeys(left,right),local);										
							   
Sort_Cleaned_PatchVtid_file := sort(Clean_file_patchVtid,RECORD,
															      EXCEPT vtid, vendor_id, Process_Date, Date_First_Seen, Date_Last_Seen,
															      file_acquired_date,local);

Layout_outfile  rollupXform(Layout_outfile l, Layout_outfile r) := transform
	self.Process_Date    := if(l.Process_Date > r.Process_Date, l.Process_Date, r.Process_Date);
	self.Date_First_Seen := if(l.Date_First_Seen > r.Date_First_Seen, r.Date_First_Seen, l.Date_First_Seen);
	self.Date_Last_Seen  := if(l.Date_Last_Seen  < r.Date_Last_Seen,  r.Date_Last_Seen,  l.Date_Last_Seen);
	self := l;
end;

export Updated_Voters := rollup(Sort_Cleaned_PatchVtid_file,rollupXform(LEFT,RIGHT),RECORD,
																EXCEPT vtid, vendor_id, Process_Date, Date_First_Seen, Date_Last_Seen,
																file_acquired_date, local): 
																persist(VotersV2.Cluster + 'persist::Updated_Voters');

