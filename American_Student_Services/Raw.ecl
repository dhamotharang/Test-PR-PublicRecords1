import Appriss, doxie, AutoStandardI, iesp,American_student_services,American_student_list,codes,AlloyMedia_student_list,American_Student_Services, lib_stringlib;

export Raw := MODULE
	
	shared CodesV3_ASL := codes.Key_Codes_V3(file_name='AMERICAN_STUDENT_LIST');
	shared CodesV3_Alloy := codes.Key_Codes_V3(file_name='ALLOY_STUDENT_LIST');
	
	shared explodeClassRank(string2 class_name_code) := FUNCTION		
	  class_name_val := trim(stringlib.StringToUpperCase(class_name_code));
	  class_name_desc := map(class_name_val='0' 	=> Constants.CLASS_RANK.HIGHSCHOOL,
		                        class_name_val='1' 	=> Constants.CLASS_RANK.FRESHMAN,
		                        class_name_val='2' 	=> Constants.CLASS_RANK.SOPHMORE,                                                                                     
														class_name_val='3' 	=> Constants.CLASS_RANK.JUNIOR,
														class_name_val='4' 	=> Constants.CLASS_RANK.SENIOR,                                                                                     
														class_name_val='5' 	=> Constants.CLASS_RANK.GRADUATE,
														class_name_val='9' 	=> Constants.CLASS_RANK.GRADUATE,
														class_name_val='A' 	=> Constants.CLASS_RANK.FRESHMAN,
														class_name_val='B' 	=> Constants.CLASS_RANK.SOPHMORE,
														class_name_val='C' 	=> Constants.CLASS_RANK.JUNIOR,
														class_name_val='D' 	=> Constants.CLASS_RANK.SENIOR,
														class_name_val='E' 	=> Constants.CLASS_RANK.GRADUATE,
														class_name_val='FR' => Constants.CLASS_RANK.FRESHMAN,
														class_name_val='SO' => Constants.CLASS_RANK.SOPHMORE,
														class_name_val='JR' => Constants.CLASS_RANK.JUNIOR,
														class_name_val='SR' => Constants.CLASS_RANK.SENIOR,
														class_name_val='GR' => Constants.CLASS_RANK.GRADUATE,
														'');
	  return class_name_desc;
  END;		
	
	EXPORT getPayloadByIDS(Dataset(American_Student_Services.layouts.id) ids) := FUNCTION
	
	search_key := American_student_list.Key_ASL_Autokey_Payload;
	
	American_Student_Services.Layouts.finalRecs get_results(search_key L) := transform
		self.college_major := L.college_major;
		self.college_major_exploded := if(L.college_major <> '',CodesV3_ASL(field_name='COLLEGE_MAJOR' AND code=L.college_major)[1].long_desc,'');
		self.isCurrent := if(stringlib.stringtouppercase(L.HISTORICAL_FLAG)='C',True,false);
		self.ClassRank := L.college_class;
		self.ClassRankExploded := explodeClassRank(L.college_class);
		self.SchoolPeriod := '';
	  self.SchoolSizeCode := L.school_size_code;
		self.SchoolSizeExploded := if(L.school_size_code<>'', CodesV3_ASL(field_name='SCHOOL_SIZE_CODE' AND code=L.school_size_code)[1].long_desc, ''),
	  self.TuitionCode := L.tuition_code;
		self.TuitionExploded := if(L.tuition_code<>'', CodesV3_ASL(field_name='TUITION_CODE' AND code=L.tuition_code)[1].long_desc, ''),
		self.src := L.source,
		self := L;
	end;
	
	ds_recs := join(ids,search_key,
									keyed(left.id=right.fakeid),
									get_results(right),
									LIMIT(American_Student_Services.Constants.MAX_RECS_ON_JOIN, fail(203, doxie.ErrorCodes(203))));									
	RETURN ds_recs;
	
	END;
	
	EXPORT getPayloadByDIDS(Dataset(American_Student_Services.layouts.deepDids) dids) := FUNCTION
	
	search_key := American_student_list.Key_did;
	
	American_Student_Services.Layouts.finalRecs get_results(American_Student_Services.layouts.deepDids R, search_key L ) := transform
		self.college_major := L.college_major;
		self.college_major_exploded := if(L.college_major <> '',CodesV3_ASL(field_name='COLLEGE_MAJOR' AND code=L.college_major)[1].long_desc,'');
		self.isCurrent := if(stringlib.stringtouppercase(L.HISTORICAL_FLAG)='C',True,false);
		self.ClassRank := L.college_class;
		self.ClassRankExploded := explodeClassRank(L.college_class);
		self.SchoolPeriod := '';
	  self.SchoolSizeCode := L.school_size_code;
		self.SchoolSizeExploded := if(L.school_size_code<>'', CodesV3_ASL(field_name='SCHOOL_SIZE_CODE' AND code=L.school_size_code)[1].long_desc, ''),
	  self.TuitionCode := L.tuition_code;
		self.TuitionExploded := if(L.tuition_code<>'', CodesV3_ASL(field_name='TUITION_CODE' AND code=L.tuition_code)[1].long_desc, ''),
		self.src := L.source,
		self.isDeepDive := R.isDeepDive;
		self := L;
	end;
	
	ds_recs := join(dids,search_key,
									keyed(left.did=right.l_did),
									get_results(left,right),
									LIMIT(American_Student_Services.Constants.MAX_RECS_ON_JOIN, fail(203, doxie.ErrorCodes(203))));									
								
	RETURN ds_recs;
	
	END;
	
	EXPORT getSupplementalStudentInfobyDIDs(Dataset(American_Student_Services.layouts.deepDids) dids) := FUNCTION
	
	search_key_alloy := AlloyMedia_student_list.Key_DID;

	// NOTE: original translation code in Risk_Indicators.Boca_Shell_Student
	American_Student_Services.Layouts.finalRecs get_results(American_Student_Services.layouts.deepDids L, search_key_alloy R ) := transform
		self.college_major 					:= R.major_code,
		self.college_name  					:= R.school_name,		
		self.telephone 							:= R.clean_phone_number, 
		self.title 									:= R.clean_title,
		self.fname 									:= R.clean_fname,
		self.mname 									:= R.clean_mname,
		self.lname 									:= R.clean_lname,
		self.name_suffix 						:= R.clean_name_suffix,
		self.prim_range 						:= R.clean_prim_range,
		self.predir  								:= R.clean_predir,
		self.prim_name							:= R.clean_prim_name,
		self.addr_suffix						:= R.clean_addr_suffix,
		self.postdir	  						:= R.clean_postdir,
		self.unit_desig 						:= R.clean_unit_desig,
		self.sec_range							:= R.clean_sec_range,
		self.p_city_name						:= R.clean_p_city_name,
		self.state									:= R.clean_st,
		self.zip										:= R.clean_zip5,
		self.zip4										:= R.clean_zip4,
		self.ssn										:= '',
		self.dob_formatted					:= '',
		self.isCurrent 							:= false;
		self.isDeepDive 						:= L.isDeepDive,
		self.Class 									:= '',		
		self.ClassRank 							:= R.class_rank;		
		self.ClassRankExploded			:= '';		
		self.SchoolPeriod 					:= R.key_code;
	  self.SchoolSizeCode 				:= R.school_size_code;
		self.SchoolSizeExploded		 	:= '',		
	  self.TuitionCode 						:= R.tuition_code;
		self.TuitionExploded		 		:= '',		
		self.public_private_code		:= R.public_private_code;
		self.college_code_exploded 	:= '',
		self.college_type_exploded 	:= '',		
		self.src                    := R.Source,
		self 												:= R
	end;	
	
	ds_recs_pre := join(dids, search_key_alloy,
								  keyed(left.did=right.did),
									get_results(left, right),
									LIMIT(American_Student_Services.Constants.MAX_RECS_ON_JOIN, fail(203, doxie.ErrorCodes(203))));			

	American_Student_Services.Layouts.finalRecs translate_codes(American_Student_Services.Layouts.finalRecs L) := transform
		self.college_major_exploded := if(L.college_major <> '',stringlib.StringToUpperCase(CodesV3_Alloy(field_name='MAJOR_CODE' AND code=L.college_major)[1].long_desc),''),
		
		// Regarding college code and college type mapping below:
		//	ASL data contains college_code and college_type. In alloy data, we only have public_private_code. 		
		// 	The mappings below are an attempt to convert public_private_code to its respective ASL college_code and public_private_code.
		// **** NOTE: ANY CHANGE TO THESE CODES IN CODES V3 WILL REQUIRE CODE CHANGES BELOW.

		// Mapping from codes V3:
		// ALLOY PUBLIC_PRIVATE_CODE	ASL COLLEGE_CODE					ASL COLLEGE_TYPE
		//	1 - Public								4 - Four Year College			S - Public/State School
		//	2 - Private								4 - Four Year College			P	- Private School
		//	3 - 2 year school					2 - Two Year College			U	
		
		_college_code := case( L.public_private_code,
			'1' => '4',
			'2' => '4',
			'3'	=> '2',
			L.public_private_code
		);
		self.college_code_exploded := if(L.public_private_code <> '',stringlib.StringToUpperCase(CodesV3_ASL(field_name='COLLEGE_CODE' AND code=_college_code)[1].long_desc),'');

		_college_type := case( L.public_private_code,
			'2' => 'P',
			'1' => 'S',
			'3' => 'U',
			L.public_private_code
		);
		self.college_type_exploded 	:= if(L.public_private_code <> '',stringlib.StringToUpperCase(CodesV3_ASL(field_name='COLLEGE_TYPE' AND code=_college_type)[1].long_desc),'');
		_class := case( trim(L.ClassRank),
			''  => '',
			'0' => 'HS',
			'1' => 'FR',
			'2' => 'SO',
			'3' => 'JR',
			'4' => 'SR',
			'5' => 'GS1',
			'6' => 'GS2',
			'7' => 'GS3',
			'8' => 'GS4',
			'9' => 'GR',
			'A' => 'P1',
			'B' => 'U2',
			'C' => 'U3',
			'D' => 'U4',
			'E' => 'U5',
			'UN'
			);
		self.Class									:= _class, // class is used in functions to calculate score.
		self.ClassRankExploded      := explodeClassRank(L.ClassRank);
		self.SchoolSizeExploded 		:= if(L.SchoolSizeCode<>'', CodesV3_Alloy(field_name='SCHOOL_SIZE_CODE' AND code=L.SchoolSizeCode)[1].long_desc, ''),
		self.TuitionExploded 				:= if(L.TuitionCode<>'', CodesV3_Alloy(field_name='TUITION_CODE' AND code=L.TuitionCode)[1].long_desc, ''),
		self 												:= L
	end;	

	ds_recs := project(ds_recs_pre, translate_codes(left));
									
	RETURN ds_recs;
	END;
	
	//For comp report - supports existing Comp Report layout.
	export getStudentInfobyDIDS(Dataset(doxie.layout_references) dids,boolean isFCRA = false) := FUNCTION
	
	key := American_student_list.key_stu_DID;
	key_FCRA := American_student_list.key_stu_DID_FCRA;
	
	iesp.student.t_PossibleStudentInformation get_results(key L) := transform
		self.uniqueId := intformat((unsigned6)L.did,12,1);
		self.FirstReported := iesp.ECL2ESP.toDate ((integer4) l.date_vendor_first_reported);
		self.LastReported := iesp.ECL2ESP.toDate ((integer4) l.date_vendor_last_reported); 
		self.CollegeName := L.college_name;
		self.CollegeMajor := if(L.college_major <> '',CodesV3_ASL(field_name='COLLEGE_MAJOR' AND code=L.college_major)[1].long_desc,'');
		self.CollegeCode := L.college_code_exploded;
		self.CollegeType := L.college_type_exploded;	
	end;
	
	search_key := if (isFCRA, key_FCRA, key);
	
	ds_recs := join(dids,search_key,
									keyed(left.did=right.l_did),
									get_results(right),
									keep(1));
	RETURN ds_recs;
	
	END;
END;