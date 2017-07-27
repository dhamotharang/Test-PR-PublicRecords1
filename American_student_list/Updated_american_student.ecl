Dist_Cleaned_american_student := distribute(American_student_list.File_american_student_super, key);
																	
//Sort_Dist_Cleaned_file := sort(Dist_Cleaned_american_student,local,lname, mname, fname,-PROCESS_DATE);
							   
Sort_Dist_Cleaned_file := sort(Dist_Cleaned_american_student,local,RECORD,
							   EXCEPT Process_Date, Date_First_Seen, Date_Last_Seen,
							   Date_Vendor_First_Reported, Date_Vendor_Last_Reported);

Layout_outfile := RECORD
	American_student_list.layout_american_student_base;
end;

Layout_outfile  rollupXform(Layout_outfile l, Layout_outfile r) := transform
	self.Process_Date    := if(l.Process_Date > r.Process_Date, l.Process_Date, r.Process_Date);
	self.Date_First_Seen := if(l.Date_First_Seen > r.Date_First_Seen, r.Date_First_Seen, l.Date_First_Seen);
	self.Date_Last_Seen  := if(l.Date_Last_Seen  < r.Date_Last_Seen,  r.Date_Last_Seen,  l.Date_Last_Seen);
	self.Date_Vendor_First_Reported := if(l.Date_Vendor_First_Reported > r.Date_Vendor_First_Reported, r.Date_Vendor_First_Reported, l.Date_Vendor_First_Reported);
	self.Date_Vendor_Last_Reported  := if(l.Date_Vendor_Last_Reported  < r.Date_Vendor_Last_Reported,  r.Date_Vendor_Last_Reported, l.Date_Vendor_Last_Reported);
	self.Age  := if(l.Process_Date > r.Process_Date, l.AGE,r.AGE);
	self.COUNTY_NAME := if(r.COUNTY_NAME != '',r.COUNTY_NAME, l.COUNTY_NAME);
	self := l;
end;

export Updated_american_student := rollup(Sort_Dist_Cleaned_file,rollupXform(LEFT,RIGHT),RECORD,
										  EXCEPT Process_Date, Date_First_Seen, Date_Last_Seen,
										  Date_Vendor_First_Reported, Date_Vendor_Last_Reported, AGE, COUNTY_NAME, local): 
										  persist(American_student_list.thor_cluster + 'persist::Updated_american_student');
