import iesp, AutoStandardI, ut, doxie, suppress,American_student_list,American_student_services, standard,codes,risk_indicators,American_Student_Services,lib_stringlib;

export Functions := MODULE

	EXPORT apply_penalty(dataset(American_Student_Services.Layouts.finalRecs) StudentRec, 
												American_Student_Services.IParam.searchParams aInputData) := FUNCTION												
		
		American_Student_Services.Layouts.finalRecs setPenalty(American_Student_Services.Layouts.finalRecs StudentRecs) := TRANSFORM		
			tempIndvMod := MODULE(PROJECT(aInputData, AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
				export allow_wildcard := false;
				export city_field := StudentRecs.p_city_name;
				export did_field := (string) StudentRecs.did;
				export fname_field := StudentRecs.fname;
				export lname_field := StudentRecs.lname;
				export mname_field := StudentRecs.mname;
				export pname_field := StudentRecs.prim_name;
				export postdir_field := StudentRecs.postdir;
				export prange_field := StudentRecs.prim_range;
				export predir_field := StudentRecs.predir;
				export ssn_field := StudentRecs.ssn;  
				export state_field := StudentRecs.state;
				export suffix_field := StudentRecs.addr_suffix;
				export sec_range_field := StudentRecs.sec_range;
				export zip_field := StudentRecs.zip;
				// Empty non input.
				export city2_field := '';
				export county_field := '';
				export dob_field := StudentRecs.dob_formatted;
				export dod_field := '';
				export phone_field := StudentRecs.telephone;
			END;
						
			SELF.record_penalty:= AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempIndvMod);
			SELF := StudentRecs;
		END;
	
			penaltyRecs := project(StudentRec, setPenalty(LEFT));					
		RETURN penaltyRecs;
	END;
	
	
	EXPORT apply_restrictions(DATASET(American_Student_Services.Layouts.finalRecs) ds_recs, 													
													American_Student_Services.IParam.reportParams aInputData) := FUNCTION
		// DPPA CHECKING.		
		dppa_purpose := aInputData.dppaPurpose;
		Suppress.MAC_Suppress(ds_recs,pull_ssns,aInputData.applicationType,Suppress.Constants.LinkTypes.SSN,ssn);
		Suppress.MAC_Suppress(pull_ssns,ds_recs_out,aInputData.applicationType,Suppress.Constants.LinkTypes.DID,did);
 
		ssn_mask_value := aInputData.ssnMask;
      
    suppress.mac_mask(ds_recs_out, ds_recs_out_0, ssn, '', true, false);  
		
		layout_dobmask := record
			ds_recs_out;
			unsigned4 dob_unmasked;
			Standard.Date.Datestr dob_masked;
		end;
		
		layout_dobmask pre_dm_trans(ds_recs_out_0 l) := transform
			self.dob_masked := ROW ({'', '', ''}, Standard.Date.Datestr);
			self.dob_unmasked := (unsigned4) l.dob_formatted;
			self := L;
		end;
		
		pre_dobmask_ready := project(ds_recs_out_0,pre_dm_trans(left));
		
		
	  unsigned1  mask := aInputData.dob_mask_value;
		
		Suppress.MAC_Mask_Date(pre_dobmask_ready, post_dobmask_ready, dob_unmasked, dob_masked, mask);
		
		ds_recs_out_0 xform_out(layout_dobmask l) := transform
			self.dob_formatted := l.dob_masked.year + l.dob_masked.month + l.dob_masked.day;
			self := L;
		end;
		
		records := project(post_dobmask_ready, xform_out(left));
		RETURN records;
	END;
	
	Date_YY_to_YYYY(unsigned yy, unsigned delta=5) := function
		now		:= ut.GetDate;
		high	:= (unsigned)now[1..4] + delta;
		test	:= yy + ((unsigned)now[1..2]*100);
		yyyy	:= if(test<=high, test, test-100);
		return yyyy;
		// NOTE: Pass yy<100 and delta<100 or craziness ensues
	end;
	
	
	EXPORT xform_iesp_output(DATASET(American_Student_Services.Layouts.full_output) results) := FUNCTION
				
				iesp.student.t_StudentRecord xform_output(American_Student_Services.Layouts.full_output L) := Transform
					self._penalty := L.record_penalty;
					self.alsofound := L.isdeepdive;
					self.uniqueId := intformat((unsigned6)L.did,12,1);
					self.FirstReported := iesp.ECL2ESP.toDate ((integer4) l.date_vendor_first_reported);
					self.LastReported := iesp.ECL2ESP.toDate ((integer4) l.date_vendor_last_reported); 
					self.CollegeData.Name := L.LN_college_name;
					self.CollegeData.OriginalName := L.college_name;
					self.CollegeData.Major := L.college_major_exploded;
					self.CollegeData.Level := L.college_code_exploded;
					self.CollegeData._Type := L.college_type_exploded;
					SELF.PhoneAtCollege := l.telephone;
					SELF.Name := iesp.ECL2ESP.SetName(l.fname, l.mname, l.lname, l.name_suffix, l.title) ;
					SELF.AddressAtCollege := iesp.ECL2ESP.SetAddress(l.prim_name, l.prim_range, l.predir, l.postdir,
															 l.addr_suffix, l.unit_desig, l.sec_range, l.p_city_name,
															 l.state, l.zip, l.zip4,	'');
					date_yyyy := IF(Stringlib.StringFilterOut(l.class,'0123456789')='',(String) Date_YY_to_YYYY((unsigned)l.class,10),'');
					SELF.HighSchoolGradYear := date_yyyy;
					SELF.SSN := l.SSN;
					SELF.DOB := iesp.ECL2ESP.toMaskableDatestring8(l.dob_formatted);
					self.StudentData.AttendedHighSchool := L.Attended_High_school_indicator;
					self.StudentData.YearsSinceHSGraduation  := L.Years_since_HS_Graduation;
					self.StudentData.AttendedCollege1 :=  L.College_indicator1;
					self.StudentData.CollegePublicPrivate1 := L.College_public_private_flag1;
					self.StudentData.College2Yr4YrGrad1 := L.College_2yr_4yr__grad_indicator1;
					self.StudentData.CollegeEducationProgramTier1 := L.College_Education_program_tier1;
					self.StudentData.AttendedCollege2 :=  L.College_indicator2;
					self.StudentData.CollegePublicPrivate2 := L.College_public_private_flag2;
					self.StudentData.College2Yr4YrGrad2 := L.College_2yr_4yr__grad_indicator2;
					self.StudentData.CollegeEducationProgramTier2 := L.College_Education_program_tier2;
					self.ClassRank := L.ClassRankExploded;
			    self.SchoolSize := L.SchoolSizeExploded;
	        self.Tuition := L.TuitionExploded; 
	 				SELF := L;
			end;
			ds_output := sort(project(results,xform_output(left)),alsofound,_Penalty,-isCurrent,uniqueid,record );
				
		RETURN ds_output;
	END;
	
	
	export GetCollegeIndicators(dataset (doxie.layout_references) dids, boolean isFCRA = false,unsigned3 history_date = 999999) := FUNCTION;
	full_history_date := risk_indicators.iid_constants.full_history_date(history_date);
	sLayout	:= record
		american_student_list.key_DID;
		string1 COLLEGE_TIER;	
	end;
	sLayout studentFCRA(dids le, recordof(american_student_list.key_DID_FCRA) ri) := TRANSFORM
		self.did := le.did;
		self := ri;
		self.college_tier := american_student_list.CollegeTier(ri.college_name[1..23],ri.file_type,ri.college_code, ri.college_type);
	end;
	sLayout student(dids le, recordof(american_student_list.key_DID) ri) := TRANSFORM
		self.did := le.did;
		self := ri;
		self.college_tier := american_student_list.CollegeTier(ri.college_name[1..23],ri.file_type,ri.college_code, ri.college_type);
	end;

	sfile_nonFCRA := join(dids, american_student_list.key_DID, 
												left.did!=0 and keyed(left.did=right.l_did),
												student(left,right), left outer, atmost(keyed(left.did=right.l_did), 100), 
												keep(American_Student_Services.Constants.max_college_to_use));

	sfile_FCRA := join(dids, american_student_list.key_DID_FCRA, 
												left.did!=0 and keyed(left.did=right.l_did),
												studentFCRA(left,right), left outer, atmost(keyed(left.did=right.l_did), 100), 
												keep(American_Student_Services.Constants.max_college_to_use));
	studentRecs := if (isFCRA, sfile_FCRA, sfile_nonFCRA);									
	studentRecsH := studentRecs((unsigned)date_first_seen < (unsigned)full_history_date);

	outlayout  := record
		integer class_score;
		sLayout;
	end;
	outlayout classScore(sLayout l) := transform
		self.class_score := map(l.class = 'GR' => 1,
															l.class = 'UN' => 2,
															l.class = 'SR' => 3,
															l.class = 'JR' => 4,
															l.class = 'SO' => 5,
															l.class = 'FR' => 6,
															7); 
		self := l;
	end;
	 recsA := project(studentRecsH, classScore(left));
	 sortedrecs := sort(recsA, did, class, class_score, college_name, college_code, college_type);
	 doutrecs := dedup(sortedrecs, did, class, class_score, college_name, college_code, college_type);
	 soutrecs := sort(doutrecs, class_score);
	 
	 // this isnt' in prod repository yet..  ut.date_yy_to_YYYY, so i'll just use it locally for now 
	Date_YY_to_YYYY(unsigned yy, unsigned delta=5) := function
		now		:= ut.GetDate;
		high	:= (unsigned)now[1..4] + delta;
		test	:= yy + ((unsigned)now[1..2]*100);
		yyyy	:= if(test<=high, test, test-100);
		return yyyy;
		// NOTE: Pass yy<100 and delta<100 or craziness ensues
	end;
	 
	 highSchool_info := record
		soutrecs;
		string2 attended_hs;
		string4 highschool_year;
		string4 yearsSinceHighSchool;
		American_Student_Services.layouts.college_data - did;
	 end;
	 
	 highRecs := soutrecs(class <> '', college_name = '', college_code = '', college_type = '');
	 
	 
	 highSchool_info xform_hs_info(highRecs L) := transform
		self.attended_hs := 'Y';
		self.highschool_year := (string) Date_YY_to_YYYY((integer)L.class); 
		self.yearsSinceHighSchool := (string)ut.GetAge((string)self.highschool_year +'0601');
		self := L;
		self := [];
	 end;
	 
	 ds_hs := project(highRecs, xform_hs_info(left));
	 
		
	 foundCollege := soutRecs(file_type = 'C' or 
														file_type = 'H' or 
														(file_type = 'M' and 
														 class <> '' and 
														 college_name = '' and 
														 college_code = '' and
														 college_type = ''
														));
	 
	 // add attended high school and years since high school info for each did.
	 ds_all := join(soutRecs, ds_hs,
									left.did = right.did,
									transform(highSchool_info, self.attended_hs := if((right.attended_hs='Y' or (exists(foundCollege(did=left.did)))),'Y',''), self:=left, self:=right),
									left outer);

	 
	 best1 := sort(ds_all,did,class_score, record);
	 best2 := dedup(best1,did,keep(Constants.max_college));

		highSchool_info xform_indicators(best2 L, dataset(highSchool_info) R) := TRANSFORM
			
			self.did :=  L.did;
			self.Attended_High_school_indicator := L.attended_hs; 
			self.Years_since_HS_Graduation := L.yearssincehighschool;
			
			foundCollege1 := L.college_type<>'' or L.college_code<>'' or L.college_tier<>'';
			self.College_indicator1 := if (foundCollege1, 'Y','');
			self.College_public_private_flag1 := L.college_type;
			self.College_2yr_4yr__grad_indicator1 := L.college_code;
			self.College_Education_program_tier1 := L.college_tier;
				
			foundCollege2 := R[1].college_type<>'' or R[1].college_code<>'' or R[1].college_tier<>'';
			self.College_indicator2 := if (foundCollege2, 'Y','');
			self.College_public_private_flag2 := R[1].college_type;
			self.College_2yr_4yr__grad_indicator2 := R[1].college_code;
			self.College_Education_program_tier2 := R[1].college_tier;
			self := L;
		end;
		
		group_ds := group(best2,did);
		collegeRecs_pre := Rollup(group_ds , GROUP,xform_indicators(left,rows(left)));
		
		collegeRecs := project(collegeRecs_pre,transform(American_Student_Services.layouts.college_data,self.did := left.did; self:= left));

	//debug
	/*
	output(studentRecs,named('studentRecs'));
	output(soutRecs);
	output(highRecs,named('highRecs'));
	output(ds_hs,named('ds_hs'));
	output(foundCollege,named('foundCollege'));
	output(ds_all,named('ds_all'));
	output(best1,named('best1'));
	output(best2,named('best2'));
	output(group_ds,named('group_ds'));
	output(collegeRecs_pre,named('collegeRecs_pre'));
	output(collegeRecs,named('collegeRecs'));
	*/
	return collegeRecs;
	END;
	EXPORT fn_get_classRank(string30 lclassRank, string30 rclassRank) := FUNCTION
	
		// class rank order:
		//	High School < Freshman < Sophmore < Junior < Senior < Graduate
		
	  string class_rank_concat := trim(lclassRank)+'-'+trim(rclassRank);

		boolean flag_1 := stringlib.stringfind(class_rank_concat,'Hig',1);
		boolean flag_2 := stringlib.stringfind(class_rank_concat,'Fre',1);
		boolean flag_3 := stringlib.stringfind(class_rank_concat,'Sop',1);
		boolean flag_4 := stringlib.stringfind(class_rank_concat,'Jun',1);
		boolean flag_5 := stringlib.stringfind(class_rank_concat,'Sen',1);
		boolean flag_6 := stringlib.stringfind(class_rank_concat,'Gra',1);
		
		low_rank := map(flag_1 => American_Student_Services.Constants.CLASS_RANK.HIGHSCHOOL, flag_2 => American_Student_Services.Constants.CLASS_RANK.FRESHMAN, flag_3 => American_Student_Services.Constants.CLASS_RANK.SOPHMORE,
					flag_4 => American_Student_Services.Constants.CLASS_RANK.JUNIOR, flag_5 => American_Student_Services.Constants.CLASS_RANK.SENIOR,flag_6 => American_Student_Services.Constants.CLASS_RANK.GRADUATE,
					'');

		high_rank := map(flag_6 => American_Student_Services.Constants.CLASS_RANK.GRADUATE, flag_5 => American_Student_Services.Constants.CLASS_RANK.SENIOR, flag_4	=> American_Student_Services.Constants.CLASS_RANK.JUNIOR,
					flag_3 => American_Student_Services.Constants.CLASS_RANK.SOPHMORE, flag_2 => American_Student_Services.Constants.CLASS_RANK.FRESHMAN,	flag_1 => American_Student_Services.Constants.CLASS_RANK.HIGHSCHOOL,
					'');

		return map(
						low_rank='' => high_rank,
						high_rank=''=> low_rank,
						low_rank<>high_rank => stringlib.StringCleanSpaces(low_rank)+ '-' + stringlib.StringCleanSpaces(high_rank),
						low_rank // both are the same
						); 
	END;
	EXPORT fn_get_schoolPeriod(string lschoolperiod, string rschoolperiod) := function
		highPeriod 	:= (integer) max(lschoolperiod[1..4],lschoolperiod[6..9],rschoolperiod[1..4],rschoolperiod[6..9]);			
		llowPeriod 	:= ut.Min2((integer)lschoolperiod[1..4], (integer) lschoolperiod[6..9]);
		rlowPeriod 	:= ut.Min2((integer)rschoolperiod[1..4], (integer) rschoolperiod[6..9]); 
		lowPeriod 	:= ut.Min2(llowPeriod, rlowPeriod);
		return map(lowPeriod = 0 and highPeriod = 0 => '',
								lowPeriod = 0 => (string) highPeriod,
								highPeriod = 0 => (string) lowPeriod,
								lowPeriod = highPeriod => (string) lowPeriod,
								lowPeriod+'-'+highPeriod);
	END;	
	EXPORT rollup_recs(dataset(American_Student_Services.Layouts.finalRecs) StudentRecs) := FUNCTION	
	  ds_sorted := sort(StudentRecs, did,college_name,college_major_exploded,prim_name,prim_range,predir,postdir, p_city_name,state,zip,zip4,telephone,fname,mname,lname,ssn,dob_formatted,iscurrent,src);

	  ds_sorted xform_roll(ds_sorted L, ds_sorted R) := Transform
				self.iscurrent := if(l.iscurrent,l.iscurrent,r.iscurrent);
				self.date_vendor_first_reported := if(l.date_vendor_first_reported < r.date_vendor_first_reported and  (unsigned4) l.date_vendor_first_reported <> 0  , l.date_vendor_first_reported, r.date_vendor_first_reported);
				self.date_vendor_last_reported := if(l.date_vendor_last_reported > r.date_vendor_last_reported, l.date_vendor_last_reported, r.date_vendor_last_reported);
				self.ssn := if(l.ssn <> '', l.ssn, r.ssn);
				self.dob_formatted := if(l.dob_formatted <> '', l.dob_formatted, r.dob_formatted);
				self.fname := if(l.fname <> '', l.fname, r.fname);
				self.mname := if(l.mname <> '', l.mname, r.mname);
				self.lname := if(l.lname <> '', l.lname, r.lname);
				self.prim_name := if(l.prim_name <> '', l.prim_name, r.prim_name);
				self.prim_range := if(l.prim_range <> '', l.prim_range, r.prim_range);
				self.predir := if(l.predir <> '', l.predir, r.predir);
				self.postdir := if(l.postdir <> '', l.postdir, r.postdir);
				self.addr_suffix := if(l.addr_suffix <> '', l.addr_suffix, r.addr_suffix);
				self.p_city_name := if(l.p_city_name <> '', l.p_city_name, r.p_city_name);
				self.state := if(l.state <> '', l.state, r.state);
				self.zip := if(l.zip <> '', l.zip, r.zip);
				self.zip4 := if(l.zip4 <> '', l.zip4, r.zip4);
				self.telephone := if(l.telephone <> '' and l.iscurrent = true, l.telephone, if(r.telephone <> '',r.telephone, l.telephone));
				self.class:= if(l.class <> '', l.class, r.class);
				self.college_major := if(l.college_major <> '', l.college_major, r.college_major);
				self.college_major_exploded := if(l.college_major_exploded <> '', l.college_major_exploded, r.college_major_exploded);
				self.ln_college_name := if(l.Ln_college_name <> '', l.Ln_college_name, r.Ln_college_name);
				self.SchoolSizeCode := if(l.SchoolSizeCode <> '', l.SchoolSizeCode, r.SchoolSizeCode);
				self.SchoolSizeExploded := if(l.SchoolSizeExploded <> '', l.SchoolSizeExploded, r.SchoolSizeExploded);
				self.TuitionCode := if(l.TuitionCode <> '', l.TuitionCode, r.TuitionCode);
				self.TuitionExploded := if(l.TuitionExploded <> '', l.TuitionExploded, r.TuitionExploded);
				self.ClassRank := if(l.ClassRank <> '', l.ClassRank, r.ClassRank);
				self.src := if(l.src <> '', l.src, r.src);
				self.ClassRankExploded := fn_get_classRank(l.ClassRankExploded, r.ClassRankExploded);
				self.SchoolPeriod := fn_get_schoolPeriod(l.schoolPeriod, r.schoolPeriod);				
				self := if(l.iscurrent, L, R);
	END;
	
	ds_rollup := rollup(ds_sorted, 
											left.did = right.did and
											ut.nneq(left.college_name , right.college_name) and
											ut.nneq(left.college_major_exploded , right.college_major_exploded) and
											ut.nneq(left.prim_name , right.prim_name) and
											ut.nneq(left.prim_range , right.prim_range) and
											ut.nneq(left.predir , right.predir) and
											ut.nneq(left.postdir , right.postdir) and
											ut.nneq(left.addr_suffix , right.addr_suffix) and
											ut.nneq(left.p_city_name , right.p_city_name) and
											ut.nneq(left.state , right.state) and
											ut.nneq(left.zip , right.zip) and
											ut.nneq(left.zip4, right.zip4) and
											ut.nneq(left.telephone , right.telephone)  and
											ut.nneq(left.lname , right.lname) and
											ut.nneq(left.fname , right.fname) and
											ut.nneq(left.mname , right.mname) and
											ut.nneq(left.ssn, right.ssn) and
											ut.nneq(left.dob_formatted , right.dob_formatted) 
											,xform_roll(left,right));
			return ds_rollup;
  END;
EXPORT add_college_indicators(dataset(American_Student_Services.Layouts.finalRecs) studentrecs, dataset(American_Student_Services.layouts.deepDids) all_dids) := FUNCTION			
 	
	  college_indicators := GetCollegeIndicators(project(all_dids,doxie.layout_references), false);
	
	  Layouts.full_output  xform_collegeIndicators(studentrecs R, American_Student_Services.layouts.college_data L) := Transform
					self := L;
					self := R;
				END;
	
	  ds_indicators_plus := join(studentrecs, college_indicators,
															left.did = right.did,
															xform_collegeIndicators(LEFT,RIGHT),
															left outer,
															KEEP(1), LIMIT(0));
    return ds_indicators_plus;															
	END;	
	EXPORT  get_report_slim (dataset(iesp.student.t_StudentRecord) inReportRecs) := FUNCTION
      report_wide :=  choosen(inReportRecs,iesp.Constants.MaxCountASL)	;
			iesp.student.t_PossibleStudentInformation slimIt(report_wide  L) := transform
				self.uniqueId := L.uniqueId;
				self.FirstReported := L.FirstReported;
				self.LastReported := L.LastReported; 
				self.CollegeName := L.collegeData.Name;
				self.CollegeMajor := L.collegeData.Major;
				self.CollegeCode := L.collegeData.Level;
				self.CollegeType := L.collegeData._Type;	
			end;
			report_slim := project(report_wide, slimIt(LEFT));
			return report_slim;
	
	END;	
	EXPORT	get_report_recs(dataset(doxie.layout_references) dids, 
	                        American_Student_Services.IParam.reportParams aInputData, boolean onlyCurrent = true) := FUNCTION		
														 // this isnt' in prod repository yet..  ut.date_yy_to_YYYY, so i'll just use it locally for now 
	  Date_YY_to_YYYY(unsigned yy, unsigned delta=5) := function
		  now		:= ut.GetDate;
		  high	:= (unsigned)now[1..4] + delta;
		  test	:= yy + ((unsigned)now[1..2]*100);
		  yyyy	:= if(test<=high, test, test-100);
		  return yyyy;
		// NOTE: Pass yy<100 and delta<100 or craziness ensues
	  end;
 student_rec:= record
 iesp.student.t_StudentRecord;
 string2 src;
 end;
		
    all_dids := project(dids,transform(American_student_services.layouts.deepDids, self.isDeepDive := false, self := left));													
	  recs_by_dids := American_student_services.Raw.getPayloadByDIDS(all_dids);
	  sup_recs_by_dids := American_student_services.Raw.getSupplementalStudentInfobyDIDs(all_dids);
	  all_recs := recs_by_dids + sup_recs_by_dids;
		//ds_rollup := rollup_recs(all_recs);
	  commonParam := PROJECT(aInputData, American_Student_Services.IParam.reportParams);
	  studentrecs := apply_restrictions(all_recs, commonParam);		
    student_w_indicators := add_college_indicators(studentrecs, all_dids);
		student_rec iesp_format(student_w_indicators l) := transform
			self._Penalty := 0;//l.record_penalty;  //no penalty for report records.
			self.AlsoFound := l.isDeepDive;
			self.UniqueId := intformat(l.did,12,1);
			self.FirstReported := iesp.ecl2esp.toDatestring8(l.date_vendor_first_reported);
			self.LastReported := iesp.ecl2esp.toDatestring8(l.date_vendor_last_reported);
			date_yyyy := IF(Stringlib.StringFilterOut(l.class,'0123456789')='',(String) Date_YY_to_YYYY((unsigned)l.class,10),'');
			self.HighSchoolGradYear := date_yyyy;
			self.Name := iesp.ecl2esp.SetName(l.fname,l.mname,l.lname,l.name_suffix,l.title);
			self.AddressAtCollege := iesp.ecl2esp.SetAddress(l.prim_name, l.prim_range, l.predir, l.postdir, l.addr_suffix,l.unit_desig, 
			                                                 l.sec_range,  l.p_city_name,l.state, l.zip, l.zip4, '');
			self.PhoneAtCollege := l.telephone;
			self.SSN := l.SSN;
			self.DOB := iesp.ecl2esp.toMaskableDatestring8(l.DOB_FORMATTED);
			self.IsCurrent := l.IsCurrent;	    
			self.CollegeData.Name := l.LN_college_name;
			self.CollegeData.Major := L.college_major_exploded;
			self.CollegeData.Level := l.college_code_exploded;
			self.CollegeData._Type := l.college_type_exploded;
			self.CollegeData.OriginalName := l.college_name;
			self.StudentData.AttendedHighSchool := l.Attended_High_school_indicator;
			self.StudentData.YearsSinceHSGraduation := l.Years_since_HS_Graduation;
			self.StudentData.AttendedCollege1 := l.College_indicator1;
			self.StudentData.CollegePublicPrivate1 :=  l.College_public_private_flag1;
			self.StudentData.College2Yr4YrGrad1 := l.College_2yr_4yr__grad_indicator1;
			self.StudentData.CollegeEducationProgramTier1 :=  l.College_Education_program_tier1;
			self.StudentData.AttendedCollege2 := l.College_indicator2;
			self.StudentData.CollegePublicPrivate2 := l.College_public_private_flag2;
			self.StudentData.College2Yr4YrGrad2 := l.College_2yr_4yr__grad_indicator2;
			self.StudentData.CollegeEducationProgramTier2 := l.College_Education_program_tier2;	
			self.ClassRank := l.ClassRankExploded;
		  self.SchoolPeriod := l.SchoolPeriod;
	    self.SchoolSize := l.SchoolSizeExploded;
	    self.Tuition := l.TuitionExploded;
			self.src := l.src;
		end;
    report_recs1 := project(student_w_indicators, iesp_format(LEFT));
		report_recs := Project(report_recs1, iesp.student.t_StudentRecord);
		
		iesp.student.t_StudentRecord roll_current_only(iesp.student.t_StudentRecord l,iesp.student.t_StudentRecord r) := transform
			 self.ClassRank := fn_get_classRank(l.ClassRank, r.ClassRank);
  		 self.SchoolPeriod := fn_get_schoolPeriod(l.schoolPeriod, r.schoolPeriod);
			 self.SchoolSize := if (l.SchoolSize <> '', l.SchoolSize,r.SchoolSize);
	     self.Tuition := if (l.Tuition <> '', l.Tuition, r.Tuition);
		   self := l;
		end;
		student_report_recs := sort(report_recs1, CollegeData.Name, - IsCurrent, -classRank, -LastReported, -FirstReported, src, record);
		s_report_recs := Project(student_report_recs, iesp.student.t_StudentRecord);
	  rollup_current_only := rollup(s_report_recs, left.CollegeData.Name = right.CollegeData.Name,roll_current_only(left,right));
		outrecs := if (onlyCurrent, rollup_current_only, report_recs);
		sorted_outrecs := sort(outrecs,- IsCurrent, -iesp.ecl2esp.DateToInteger(LastReported));
 	return sorted_outrecs;
	END;
	
END;