IMPORT American_Student_list, ut;

EXPORT Map_To_OKC_Base(DATASET(OKC_Student_List.Layout_Base.base_intermediate) ds) := FUNCTION

	//College_Info_In contains College_type, College_Type_Exploded, College_Code, and College_Code_Exploded for OKC schools
	okc_college_info := OKC_Student_List.File_College_Info_In;

	//Populate College_type, College_Type_Exploded, College_Code, and College_Code_Exploded per Direct Source Student Data Project requirement number 6.3 and 6.10
	OKC_Student_List.Layout_Base.base_intermediate fnPopulateAslFields(ds L, okc_college_info R) := TRANSFORM
	
		non_unique_college_names := ['BLUE RIDGE COMMUNITY COLLEGE','GATEWAY COMMUNITY COLLEGE','GLENDALE COMMUNITY COLLEGE',
																 'HIGHLAND COMMUNITY COLLEGE','MANCHESTER COMMUNITY COLLEGE','MIDDLESEX COMMUNITY COLLEGE',
																 'SOUTHEASTERN COMMUNITY COLLEGE','SOUTHWESTERN COMMUNITY COLLEGE','THREE RIVERS COMMUNITY COLLEGE'];

		//Key and flag setting is copied from American_Student_List.Proc_build_base
		SELF.HISTORICAL_FLAG        := 'C';
		SELF.FULL_NAME 							:= TRIM(L.FirstName) + ' ' + TRIM(L.LastName);
		// Individual's current class year in college
		// FR=Freshman, SO=Sophomore, JR=Junior, SR=Senior, GR=Graduate, PT=Part Time, UN=Unknown
		trimmedGrade								:= TRIM(L.Grade,LEFT,RIGHT);
		SELF.COLLEGE_CLASS					:= MAP(REGEXFIND('(DOCTORAL|POST\\-GRAD|YEAR GRADUATE|GRADUATE SCHOOL|' +
																			           '^GRADUATE|^GS|GRADUATE DOCTOR|^GD$|^DOCTOR|GRADUATE MASTER|^GM$|^MASTER|' +
																			           '^MD$|^MED$|^MED [1-4]|YR MED|YEAR MED|^M[E]?D[ICAL]* [.]*Y[EA]*R|^M[E]?D[ICINE]* [.]*Y[EA]*R|' +
																								 '^DENT$|DENTAL|DENTISTRY YR|^DDS | DDS$|VETMED |^VMED$|YEAR PROFESS|'+
																			           '^LAW | LAW$|^LAW$|\\(DR\\))',trimmedGrade,NOCASE) => 'GR',
																			 REGEXFIND('(PRE\\-FRESHMAN)',trimmedGrade,NOCASE) => 'UN',
																			 REGEXFIND('(FRESHMAN|FRESHMEN|FIRST\\-YEAR|FIRST_YR)',trimmedGrade,NOCASE) => 'FR',
																			 REGEXFIND('(MORE THAN SOPHOMORE)',trimmedGrade,NOCASE) => 'UN',
																		   REGEXFIND('(SOPHOMORE|^SOPH$)',trimmedGrade,NOCASE) => 'SO',
																		   REGEXFIND('(THIRD YEAR|JUNIOR)',trimmedGrade,NOCASE) => 'JR',
																		   REGEXFIND('(SENIOR|FOURTH YEAR)',trimmedGrade,NOCASE) => 'SR',
																		   REGEXFIND('(PART TIME)',trimmedGrade,NOCASE) => 'PT',
																			 // REGEXFIND('[0-9]+\\-[A-Z]{3}\\-[0-9]{4}',trimmedGrade,NOCASE) =>'',
																			 // REGEXFIND('^[0-9\\-\\.]+$',trimmedGrade,NOCASE) =>'',
																			 'UN');											
		//Fix non unique college names - append state code to college names when they are not unique.
		CollegeStateCode						:=ut.St2Abbrev(ut.CleanSpacesAndUpper(TRIM(L.CollegeState)));
		SELF.COLLEGE_NAME 					:= IF(TRIM(L.College) in non_unique_college_names, TRIM(L.College) + ' (' + CollegeStateCode + ')', TRIM(L.College));
		SELF.COLLEGE_CODE 					:= CASE(R.College_Type,
																				'2-year' => '2',
																				'4-year' => '4',
																				'');
		SELF.COLLEGE_CODE_EXPLODED 	:= CASE(R.College_Type,
																				'2-year' => 'TWO YEAR COLLEGE',
																				'4-year' => 'FOUR YEAR COLLEGE',
																				'');
		SELF.COLLEGE_TYPE						:= 'S';
		SELF.COLLEGE_TYPE_EXPLODED	:= 'S - PUBLIC/STATE SCHOOL';
		SELF.FILE_TYPE							:= 'O';
		SELF.CollegeUpdate					:= IF(TRIM(L.Semester)='FALL',(STRING4) (((unsigned) L.Year)+1),L.Year);
		SELF 												:= L;
	END;
	
	dsOkcStudentListCollegeInfo		:= JOIN(ds, okc_college_info,
	                                      LEFT.collegeid=RIGHT.collegeid,
																				fnPopulateAslFields(LEFT,RIGHT),
																				LEFT OUTER, LOOKUP);
	
	RETURN dsOkcStudentListCollegeInfo;

END;

