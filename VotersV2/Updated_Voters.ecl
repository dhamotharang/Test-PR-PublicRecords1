import VotersV2, ut, _Validate, emerges, std;

Clean_In_file  := VotersV2.File_Voters_Cleaned_Super;

Layout_outfile := VotersV2.Layouts_Voters.Layout_Voters_Common_new;

// stored values to override the year low & high range from default value to 1900 & current year.
#stored('_Validate_Year_Range_Low',  '1900');
year_high := ((STRING8)Std.Date.Today())[1..4];
#stored('_Validate_Year_Range_High', year_high);

// function to fix the invalid date value and returns to ccyymmdd format.
string8 fixdate(string indate) := function
    outdate := _Validate.date.fCorrectedDateString(trim(indate,left,right));
	return(if((integer)trim(outdate,left,right) = 0, '', outdate));
end;

//bug 29750 - Modified the code to blank all the regdate's that are 19000101.
// bug 68322 - Modified the code to blank all dob that are 19010101.
Layout_outfile FixDates(Clean_In_file l) := transform
  self.dob          := if (ut.Age((integer)fixdate(l.dob))< 18, // bug 167807
	                         '',
													 if(l.dob = '19010101', '', fixdate(l.dob)));  // bug 68322
	self.regdate      := if (fixdate(l.regdate) = '19000101', '', fixdate(l.regdate)); 
	self.LastDateVote := fixdate(l.LastDateVote);
	self              := l;
end;

Clean_file := project(Clean_In_file, FixDates(left));

emerges.MAC_eMerge_Date_Patch(clean_file,regdate,lastdatevote,regdate,regdate,date_fix);//Extra regdate's don't matter because Voters doesn't use them

// generating a sequence number for "vtid"
ut.MAC_Sequence_Records(date_fix,vtid,Clean_file_seq);

								 
Dist_Cleaned_Voters := distribute(Clean_file_seq, hash64(source_state, lname, name_suffix, fname, mname, 
														 prim_range, prim_name, predir, addr_suffix, postdir,
														 unit_desig, sec_range, p_city_name, st, zip,
														 mail_prim_range, mail_prim_name, mail_predir, mail_addr_suffix,
														 mail_postdir, mail_unit_desig, mail_sec_range, mail_p_city_name,
														 mail_st, mail_ace_zip, phone, work_phone
														 ));

Srt_Dist_Cleaned_Voters := sort(Dist_Cleaned_Voters, source_state, lname, fname, mname, name_suffix, prim_range, 
                                prim_name, predir, addr_suffix, postdir, unit_desig, sec_range, p_city_name, st, zip,
								mail_prim_range, mail_prim_name, mail_predir, mail_addr_suffix,	mail_postdir, 
								mail_unit_desig, mail_sec_range, mail_p_city_name, mail_st, mail_ace_zip,
								phone, work_phone, -dob, -process_date, local);

// Patching the VTID keys to have the same VTID key for the same group records and also patching the 
// YOB dates with a good dob dates if available with in a group.  
Layout_outfile patchRecs(Dist_Cleaned_Voters l, Dist_Cleaned_Voters r) := transform
   same_group := if(trim(l.lname,left,right) = trim(r.lname,left,right) and 
	                trim(l.fname,left,right) = trim(r.fname,left,right) and 
					trim(l.mname,left,right) = trim(r.mname,left,right) and 
					trim(l.name_suffix,left,right) = trim(r.name_suffix,left,right) and 
					trim(l.prim_range,left,right) = trim(r.prim_range,left,right) and 
					trim(l.prim_name,left,right) = trim(r.prim_name,left,right) and 
					trim(l.predir,left,right) = trim(r.predir,left,right) and 
					trim(l.addr_suffix,left,right) = trim(r.addr_suffix,left,right) and 
					trim(l.postdir,left,right) = trim(r.postdir,left,right) and 
					trim(l.unit_desig,left,right) = trim(r.unit_desig,left,right) and 
					trim(l.sec_range,left,right) = trim(r.sec_range,left,right) and 
					trim(l.p_city_name,left,right) = trim(r.p_city_name,left,right) and 
					trim(l.st,left,right) = trim(r.st,left,right) and 
					trim(l.zip,left,right) = trim(r.zip,left,right) and
					trim(l.mail_prim_range,left,right) = trim(r.mail_prim_range,left,right) and 
					trim(l.mail_prim_name,left,right) = trim(r.mail_prim_name,left,right) and 
					trim(l.mail_predir,left,right) = trim(r.mail_predir,left,right) and 
					trim(l.mail_addr_suffix,left,right) = trim(r.mail_addr_suffix,left,right) and 
					trim(l.mail_postdir,left,right) = trim(r.mail_postdir,left,right) and 
					trim(l.mail_unit_desig,left,right) = trim(r.mail_unit_desig,left,right) and 
					trim(l.mail_sec_range,left,right) = trim(r.mail_sec_range,left,right) and 
					trim(l.mail_p_city_name,left,right) = trim(r.mail_p_city_name,left,right) and 
					trim(l.mail_st,left,right) = trim(r.mail_st,left,right) and 
					trim(l.mail_ace_zip,left,right) = trim(r.mail_ace_zip,left,right) and
					trim(l.phone,left,right) = trim(r.phone,left,right) and
					trim(l.work_phone,left,right) = trim(r.work_phone,left,right) and
					trim(l.source_state) = trim(r.source_state), true, false);
					
   self.dob  := if (same_group and 
                    ut.NNEQ_Date((integer)l.dob, (integer)r.dob) and 
				    l.dob[5..8] <> r.dob[5..8] and
				    (integer)r.dob[5..8] = 0, l.dob, r.dob);

   self.vtid := if (same_group and 
                    trim(self.dob) = trim(l.dob), l.vtid, r.vtid);
   self      := r;
end;

Clean_patched_vtid_dob_file := iterate(Srt_Dist_Cleaned_Voters, patchRecs(left,right),local);
						   
Sort_Cleaned_Patched_file := sort(Clean_patched_vtid_dob_file,RECORD,
								  EXCEPT vtid, vendor_id, Process_Date, Date_First_Seen, Date_Last_Seen,
								  file_acquired_date,local);

Layout_outfile  rollupXform(Layout_outfile l, Layout_outfile r) := transform
	self.Process_Date    := if(l.Process_Date > r.Process_Date, l.Process_Date, r.Process_Date);
	self.Date_First_Seen := if(l.Date_First_Seen > r.Date_First_Seen, r.Date_First_Seen, l.Date_First_Seen);
	self.Date_Last_Seen  := if(l.Date_Last_Seen  < r.Date_Last_Seen,  r.Date_Last_Seen,  l.Date_Last_Seen);
	self := l;
end;

export Updated_Voters := rollup(Sort_Cleaned_Patched_file,rollupXform(LEFT,RIGHT),RECORD,
								EXCEPT vtid, vendor_id, Process_Date, Date_First_Seen, Date_Last_Seen,
								file_acquired_date, local): 
								persist(VotersV2.Cluster + 'persist::Updated_Voters');

