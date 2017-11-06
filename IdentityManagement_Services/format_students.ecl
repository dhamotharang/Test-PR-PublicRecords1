/***
 ** Function to transform and filter a studentt dataset into desired format.
 ** Clear "UNCLASSIFIED" major.
 ** Filter addresses named "UNIV" or "UNIVERSITY".
 ***/

import American_Student_Services, ut, iesp, Address;

out_rec := iesp.identitymanagementreport.t_IdmStudentRecord;
Date_YY_to_YYYY(unsigned yy, unsigned delta=5) := function
	now		:= ut.GetDate;
	high	:= (unsigned)now[1..4] + delta;
	test	:= yy + ((unsigned)now[1..2]*100);
	yyyy	:= if(test<=high, test, test-100);
	return yyyy;
	// NOTE: Pass yy<100 and delta<100 or craziness ensues
end;
Idmcollege_DSSD :=iesp.identitymanagementreport.t_IdmStudentCollege;

college_rec := record
string2 src;
Idmcollege_DSSD;
end;

student_rec := American_Student_Services.Layouts.finalrecs;


export out_rec format_students(DATASET(student_rec) d_student) := FUNCTION
			
			// clear the college major field for records where college major is not "UNCLASSIFIED"()
			// clear the class field with non-numeric class (we want no alpha, just numeric, but empty is OK)
			student_with_major := project(d_student,
																transform(student_rec,
																			self.college_major := if(left.college_major not in ['U', 'u'], left.college_major, ''),
																			self.college_major_exploded := if(left.college_major not in ['U', 'u'], left.college_major_exploded, ''),
																			self.class := if(Stringlib.StringFilterOut(left.class,'0123456789') = '', left.class, ''),
																			self := left));

			// determine distinctiveness of non-empty numeric class
			classCount := count(dedup(sort(project(student_with_major(class <> ''), {string class}),class),class));
			isDistinctClass := classCount in [0,1];

			// we cannot know which one is correct if there is more than one distinct
			// graduating class, so when that happens, clear that field in each record.
			student_hs_class := project(student_with_major,
														transform(student_rec,
																self.class := if(isDistinctClass, left.class, ''),
																self := left));

			out_rec toParent(student_rec L) := Transform
						SELF.uniqueId := (String)L.did;
						// if the "class" field is a year, convert it to the year graduated from high school
						date_yyyy := IF(l.class<>'' and Stringlib.StringFilterOut(l.class,'0123456789')='',(String) Date_YY_to_YYYY((unsigned)l.class,10),'');
						SELF.HighSchoolGradYear := date_yyyy;
						SELF.Colleges := [];
			end;
			
			parent_rec:= rollup(project(student_hs_class, toParent(Left)), 
													left.UniqueId = right.UniqueID,
													transform(out_rec,
																		self.highSchoolGradYear := if(left.highSchoolGradYear <> '', Left.HighSchoolGradYear, Right.HighSchoolGradYear),
																		self := left));
			parent_row := row(parent_rec[1], out_rec); //should be only one record anyway
			
			// add a filter for when address is permutation of "University" to transforming the
			// addresses into the subject's dataset of colleges
			college_rec toCollege(student_rec L) := Transform
						self.CollegeName := L.LN_college_name;
						self.CollegeMajor := L.college_major_exploded;
						self.CollegeLevel := L.college_code_exploded;
						self.CollegeType := L.college_type_exploded;
						SELF.PhoneAtCollege := l.telephone;
						SELF.AddressAtCollege := iesp.ECL2ESP.SetAddress(l.prim_name, l.prim_range, l.predir, l.postdir,
																l.addr_suffix, l.unit_desig, l.sec_range, l.p_city_name,
																l.state, l.zip, l.zip4,	'', '',
																Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name, l.addr_suffix, l.postdir, l.unit_desig, l.sec_range),
																'',
																Address.Addr2FromComponents(l.p_city_name, l.state, l.zip));
						self.Filtered := L.prim_name IN ['UNIV', 'UNIVERSITY'];
						self.FirstReported := iesp.ECL2ESP.toDate((INTEGER)L.date_vendor_first_reported);
						self.LastReported  := iesp.ECL2ESP.toDate((INTEGER)L.date_vendor_last_reported);
						self.src := l.src;
			End;

			college_recs := project(student_hs_class, toCollege(left))(CollegeName <> '');
			idm_college_recs := DEDUP(SORT(college_recs,CollegeName,-LastReported,src),CollegeName);
				
			idm_college_recs_Dssd :=project(idm_college_recs,Idmcollege_DSSD);

 			out_rec toOut() := transform
   						// we want the Unique ID w/o the leading zeroes
   					self.UniqueId := parent_row.UniqueId;
   					self.HighSchoolGradYear := parent_row.HighSchoolGradYear;
   				  self.Colleges := choosen(SORT(idm_college_recs_Dssd,-LastReported),iesp.Constants.IDM.MaxStudentColleges);
   			end;
   			
   			esp_student := dataset ([toOut ()]);

			
/*******
			// DEBUG
			OUTPUT(d_student,           NAMED('d_student'));
			OUTPUT(student_with_major,  NAMED('student_with_major'));
			OUTPUT(student_hs_class,    NAMED('student_hs_class'));
			OUTPUT(college_recs,        NAMED('college_recs'));
			OUTPUT(esp_student,         NAMED('esp_student'));
/*******/

RETURN esp_student;
end;