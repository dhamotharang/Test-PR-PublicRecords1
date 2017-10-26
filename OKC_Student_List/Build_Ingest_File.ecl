IMPORT address, std, tools, ut, Header_Slimsort, did_add, VersionControl, emailservice, email_data, 
Scrubs_OKC_Student_List_V2, MDR, header, didville, Salt35, watchdog, lib_stringlib, AID;
#OPTION('multiplePersistInstances',FALSE);

// This function merges OKC Student List student, address, and phone files, cleans up the input files, and creates ingest file.
// Then run scrubs on the ingest file to create scrubs summary report for quarantine.
EXPORT Build_Ingest_File(string pversion='')	:= FUNCTION
		
	StudentFile:=OKC_Student_List.File_Student_In.using;
	AddressFile:=OKC_Student_List.File_Address_In.using;
	PhoneFile:=OKC_Student_List.File_Phone_In.using;

	OKC_Student_List.Layout_Base.base_intermediate tMergeStudentAddress(StudentFile L, AddressFile R):= TRANSFORM
		SELF.studentid				:=	L.studentid;
		SELF.process_date			:=	thorlib.wuid()[2..9];
		temp_date_first_seen	:=	L.dateadded[5..8]+L.dateadded[1..2]+L.dateadded[3..4];
		temp_date_last_seen		:=	L.dateupdated[5..8]+L.dateupdated[1..2]+L.dateupdated[3..4];
		SELF.dateadded				:=	temp_date_first_seen;
		SELF.dateupdated			:=	temp_date_last_seen;
		SELF.date_first_seen	:=	IF(temp_date_first_seen<=temp_date_last_seen,temp_date_first_seen,'');
		SELF.date_last_seen		:=	IF(temp_date_first_seen<=temp_date_last_seen,temp_date_last_seen,'');
		SELF.date_vendor_first_reported	:=	pversion;
		SELF.date_vendor_last_reported	:=	pversion;
		SELF.DOB_Formatted		:= MAP(LENGTH(TRIM(L.dateofbirth,left,right)) = 6 => if (L.dateofbirth[5..6] > '40',
																																									'19' + L.dateofbirth[5..6]+L.dateofbirth[1..2]+L.dateofbirth[3..4],
																																									'20' + L.dateofbirth[5..6]+L.dateofbirth[1..2]+L.dateofbirth[3..4]),
																 LENGTH(TRIM(L.dateofbirth,left,right)) = 8 => IF(L.dateofbirth[5..]='1900',
																																									'',
																																									L.dateofbirth[5..]+L.dateofbirth[1..2]+L.dateofbirth[3..4]),
																 '');
		SELF.z5							:= R.zip;											//z5 stores original zip from address file
		SELF.z4							:= R.zip4;										//z4 stores original zip4 from address file
		SELF								:=L;
		SELF								:=R;
		SELF								:=[];
	END;


	StudentAndAddress:=JOIN(DISTRIBUTE(StudentFile,HASH(studentid)),DISTRIBUTE(AddressFile,HASH(studentid)),
											LEFT.studentid=RIGHT.studentid,
											tMergeStudentAddress(LEFT,RIGHT),LEFT OUTER,LOCAL);
											
	
											
	CleanDOB	:=	PROJECT(StudentAndAddress, TRANSFORM(RECORDOF(StudentAndAddress),
																							 SELF.dob_formatted:=if(LEFT.dob_formatted[1..4]>thorlib.wuid()[2..5],'19'+LEFT.dob_formatted[3..8],LEFT.dob_formatted);
																							 SELF:=LEFT));
											
	OKC_Student_List.Layout_Base.base_intermediate tMergeStudentPhone(CleanDOB L, PhoneFile R):= transform
		SELF.studentid		:=	L.studentid;
		SELF							:=	R;
		SELF							:=	L;
		SELF							:=	[];
	end;
	
	
	AllThreeFiles:=join(CleanDOB,DISTRIBUTE(PhoneFile,HASH(studentid)),
											left.studentid=right.studentid,
											tMergeStudentPhone(LEFT,RIGHT),LEFT OUTER,LOCAL);

	unitMatchRegexString	:=	'#|APARTMENT|APT|BASEMENT|BLDG|BSMT|BUILDING|DEPARTMENT|DEPT|FL|FLOOR|FRNT|FRONT|HANGER|HNGR|KEY|LBBY|LOBBY|LOT|LOWER|LOWR|OFC|OFFICE|PENTHOUSE|PH|PIER|REAR|RM|ROOM|SIDE|SLIP|SPACE|SPC|STE|STOP|SUITE|TRAILER|TRLR|UNIT|UPPER|UPPR';
	OKC_Student_List.Layout_Base.base_intermediate tFormatInput(AllThreeFiles pInput):= transform
			SELF.ProjectSource:=ut.CleanSpacesAndUpper(pInput.ProjectSource);
			SELF.CollegeState:=ut.CleanSpacesAndUpper(pInput.CollegeState);
			SELF.College:=ut.CleanSpacesAndUpper(pInput.College);
			SELF.CollegeID := ut.CleanSpacesAndUpper(pInput.CollegeID);
			SELF.Semester:=ut.CleanSpacesAndUpper(pInput.Semester);
			SELF.FirstName:=ut.CleanSpacesAndUpper(pInput.FirstName);
			SELF.MiddleName:=ut.CleanSpacesAndUpper(pInput.MiddleName);
			SELF.LastName:=ut.CleanSpacesAndUpper(pInput.LastName);
			SELF.Suffix:=ut.CleanSpacesAndUpper(pInput.Suffix);
			SELF.Major:=ut.CleanSpacesAndUpper(pInput.Major);
			SELF.Grade:=ut.CleanSpacesAndUpper(pInput.Grade);
			SELF.Email:=ut.CleanSpacesAndUpper(pInput.Email);
			SELF.EnrollmentStatus:=ut.CleanSpacesAndUpper(pInput.EnrollmentStatus);
			SELF.AddressType:=ut.CleanSpacesAndUpper(pInput.AddressType);
			//Remove (N/A) in address fields
			temp_Address_1:=REGEXREPLACE('\\(N/A\\)',ut.CleanSpacesAndUpper(pInput.Address_1),'');
			SELF.Address_1:=temp_Address_1;
			temp_Address_2:=REGEXREPLACE('\\(N/A\\)',ut.CleanSpacesAndUpper(pInput.Address_2),'');
			SELF.Address_2:=temp_Address_2;
			temp_City:=REGEXREPLACE('\\(N/A\\)',ut.CleanSpacesAndUpper(pInput.City),'');
			SELF.City:=temp_City;
			temp_State:=REGEXREPLACE('\\(N/A\\)',ut.CleanSpacesAndUpper(pInput.State),'');
			SELF.State:=temp_State;
			temp_Zip:=REGEXREPLACE('\\(N/A\\)',ut.CleanSpacesAndUpper(pInput.zip),'');
			temp_Zip4:=REGEXREPLACE('\\(N/A\\)',ut.CleanSpacesAndUpper(pInput.zip4),'');
			TrimAttendanceDte      := ut.CleanSpacesAndUpper(pInput.attendancedate);
			SELF.CleanAttendanceDte := REGEXREPLACE('00:00:00.000',TrimAttendanceDte,'');
			SELF.CleanDOB     := ut.CleanSpacesAndUpper(pInput.DateofBirth);
			SELF.cleanMajor   := ut.CleanSpacesAndUpper(pInput.Major);
			// SELF.cleanphone   := ut.CleanPhone(pInput.phoneNumber);
			SELF.cleanphone   := ut.CleanPhone(REGEXREPLACE('\\+',pInput.phoneNumber,''));
			SELF.CleanCity    := temp_City;
			SELF.cleanState   := temp_State;
			SELF.cleanzip     := temp_Zip;
			SELF.cleanzip4    := temp_Zip4;
			SELF.cleanfullAddr:= ut.CleanSpacesAndUpper(temp_Address_1+' '+temp_Address_2+' '+temp_City+' '+temp_State+' '+temp_Zip);

			SELF.TELEPHONE	:= IF(LENGTH(TRIM(SELF.cleanphone))=10 AND NOT REGEXFIND('(^(0)+$|^(1)+$|^(9)+$)',TRIM(SELF.cleanphone)),
			                      TRIM(SELF.cleanphone),'');		//Per requirement, blank out telephone if it is not 10 digits, or it is all 0s
			SELF:=pInput;
			SELF:=[];
		END;
		
	FormattedInput:=PROJECT(AllThreeFiles,tFormatInput(LEFT)) : PERSIST('~persist::okc_student_list::allthreefiles_formatted');
	
	//************Clean Name
	OKC_Student_List.Layout_Base.base_intermediate tCleanName(FormattedInput L):= TRANSFORM
		string PrepNameStep1:=If(trim(L.MiddleName,left,right)='' or trim(L.MiddleName,left,right)='-',trim(L.FirstName,left,right)+' '+trim(L.LastName,left,right),trim(L.FirstName,left,right)+' '+trim(L.MiddleName,left,right)+' '+trim(L.LastName,left,right));
		string PrepNameStep2:=If(trim(L.Suffix,left,right)='',trim(PrepNameStep1,left,right)+' '+trim(L.Suffix,left,right),trim(PrepNameStep1,left,right));
		CleanName:=Address.CleanPersonFML73_Fields(PrepNameStep2).CleanNameRecord;
		SELF.CleanCollegeId := ut.CleanSpacesAndUpper(L.CollegeID);
		// ***Delete these fields when redo Scrubs
		SELF.CleanTitle:=CleanName.title;
		SELF.CleanFirstName:=CleanName.fname;
		SELF.CleanMidName:=CleanName.mname;
		SELF.CleanLastName:=CleanName.lname;
		SELF.CleanSuffixName:=CleanName.name_suffix;
		SELF := CleanName;
		SELF := L;
		SELF := [];
	end;
	
	CleanedNames:=project(FormattedInput,tCleanName(left));


	OKC_Student_List.Layout_Base.base_intermediate tCleanAddressPhone(CleanedNames L):= transform
	  string state    			:= ut.CleanSpacesAndUpper(L.state)[1..2];
	  String address1				:= ut.cleanSpacesAndUpper(L.Address_1 + ' ' + L.Address_2);
	  String address2				:= ut.cleanSpacesAndUpper(TRIM(StringLib.StringCleanSpaces(TRIM(L.city)  + IF(state <> '',',','')
																												 + ' '+ state
																												 + ' '+ L.zip),
																												 LEFT,RIGHT)
																									 );													
		CleanedAddress				:=Address.CleanAddressParsed(Address1,Address2).addressrecord;
		//Blank out cleaned address fields if it is a foreign address
		foreign_address			:= IF(CleanedAddress.st='',TRUE, FALSE);
		Self.prim_range			:= IF(foreign_address,'',CleanedAddress.prim_range);
		Self.predir					:= IF(foreign_address,'',CleanedAddress.predir);
		Self.prim_name			:= IF(foreign_address,'',CleanedAddress.prim_name);
		Self.addr_suffix		:= IF(foreign_address,'',CleanedAddress.addr_suffix);
		Self.postdir				:= IF(foreign_address,'',CleanedAddress.postdir);
		Self.unit_desig			:= IF(foreign_address,'',CleanedAddress.unit_desig);
		Self.sec_range			:= IF(foreign_address,'',CleanedAddress.sec_range);
		Self.p_city_name		:= IF(foreign_address,'',CleanedAddress.p_city_name);
		Self.v_city_name		:= IF(foreign_address,'',CleanedAddress.v_city_name);
		Self.st							:= IF(foreign_address,'',CleanedAddress.st);
		Self.zip							:= IF(foreign_address,'',CleanedAddress.zip);
		Self.zip4						:= IF(foreign_address,'',CleanedAddress.zip4);
		Self.cart						:= IF(foreign_address,'',CleanedAddress.cart);
		Self.cr_sort_sz			:= IF(foreign_address,'',CleanedAddress.cr_sort_sz);
		Self.lot						:= IF(foreign_address,'',CleanedAddress.lot);
		Self.lot_order			:= IF(foreign_address,'',CleanedAddress.lot_order);
		Self.dpbc						:= IF(foreign_address,'',CleanedAddress.dbpc);
		Self.chk_digit			:= IF(foreign_address,'',CleanedAddress.chk_digit);
		Self.rec_type				:= IF(foreign_address,'',CleanedAddress.rec_type);
		Self.fips_state			:= IF(foreign_address,'',CleanedAddress.fips_state);
		Self.fips_county		:= IF(foreign_address,'',CleanedAddress.fips_county);
		Self.geo_lat				:= IF(foreign_address,'',CleanedAddress.geo_lat);
		Self.geo_long				:= IF(foreign_address,'',CleanedAddress.geo_long);
		Self.msa						:= IF(foreign_address,'',CleanedAddress.msa);
		Self.geo_blk				:= IF(foreign_address,'',CleanedAddress.geo_blk);
		Self.geo_match			:= IF(foreign_address,'',CleanedAddress.geo_match);
		Self.err_stat				:= CleanedAddress.err_stat;
		Self:=L;
	
	end;	
	
	CleanAddress := project(CleanedNames,tCleanAddressPhone(left));
  emailservice.mac_append_domain_flags(CleanAddress, out_email, email);

	//************Clean Email
	OKC_Student_List.Layout_Base.base_intermediate tCleanEmail (out_email L) := TRANSFORM
		SELF.append_email_username 						:= stringlib.stringtouppercase(Email_data.Fn_Clean_Email_Username(L.email));
		SELF.append_domain 										:= stringlib.stringtouppercase(L.domain);
		SELF.append_domain_type 							:= stringlib.stringtouppercase(L.domain_type);
		SELF.append_domain_root 							:= stringlib.stringtouppercase(L.domain_root);
		SELF.append_domain_ext 								:= stringlib.stringtouppercase(L.domain_ext);
		SELF.append_is_tld_state							:= L.is_tld_state;
		SELF.append_is_tld_generic 						:= L.is_tld_generic;
		SELF.append_is_tld_country 						:= L.is_tld_country;
		SELF.append_is_valid_domain_ext 			:= L.is_valid_domain_ext;
		clnEmail          						:= trim(SELF.append_email_username, left, right) + '@' + trim(SELF.append_domain, left, right);	
		SELF.CleanEmail               := if(clnEmail = '@','',clnEmail);
		SELF:=L;
	end;
 
	CleaneMail := project(out_email, tCleanEmail(left)) : PERSIST('~persist::okc_student_list::CleaneMail');

	//Flip name for Scrubs and DID processing
	ut.mac_flipnames(CleaneMail,fname,mname,lname,dsOKCStudentListFlipNames);
	
	//append src for DID processing
	src_rec := record
		header_slimsort.Layout_Source;
		OKC_Student_List.Layout_Base.base_intermediate;
	end;
	DID_ADD.Mac_Set_Source_Code(dsOKCStudentListFlipNames, src_rec, MDR.sourceTools.src_OKC_Student_List, dsOKCStudentListSrc)

	matchset :=['A','D','P','G','Z'];
	DID_Add.Mac_Match_Flex_V2(dsOKCStudentListSrc, matchset,
													 '', DOB_FORMATTED, fname, mname, lname, name_suffix, 
														prim_range, prim_name, sec_range, zip, st, TELEPHONE,
														did,   			
														src_rec, 
														false, did_score_field,	//these should default to zero in definition
														75,	  //dids with a score below here will be dropped 
														dsOKCStudentListDid,true,src);

	//Transform dataset back to base_intermediate layout for Scrubs and further processing
	dsOKCStudentListDid2 := PROJECT(dsOKCStudentListDid,TRANSFORM(OKC_Student_List.Layout_Base.base_intermediate,SELF.source := left.src, SELF := left));

	// Blank out DOB if it does not match the DOB in best file. Following section is copied from American_Student_List.Proc_build_base
	best_file 									 := watchdog.File_Best;
	//Dates are considered the same if 
	//	1. MM DD YYYY are present and the same
	//	2. One or both dates are partial, and the present part (YYYY, or YYYYMM) match
	boolean isSameDOB(integer4 best_dob_int, string8 asl_dob) := function
		best_dob				:= (STRING8) best_dob_int;
		//determine how many chars is used to match
		asl_dob_match 	:= map(best_dob[5..]='0000' or asl_dob[5..]='0000' => asl_dob[..4],
													 best_dob[7..]='00'   or asl_dob[7..]='00'   => asl_dob[..6],
													 asl_dob);
		best_dob_match	:= map(best_dob[5..]='0000' or asl_dob[5..]='0000' => best_dob[..4],
													 best_dob[7..]='00'   or asl_dob[7..]='00'   => best_dob[..6],
													 best_dob);
		result					:=	IF(REGEXFIND('^'+asl_dob_match,best_dob_match),true,false);
		RETURN result;
	END;

	OKC_Student_List.Layout_Base.base_intermediate fixDOB(dsOKCStudentListDid2 L, best_file R) := TRANSFORM

		clearOKCDOB							:= IF(R.dob<>0 and NOT isSameDOB(R.dob, L.dob_formatted), TRUE, FALSE);
		SELF.dateofbirth		 			:= IF(R.dob=0,'',if(clearOKCDOB,'',L.dateofbirth));
		SELF.dob_formatted 			:= IF(R.dob=0,'',if(clearOKCDOB,'',L.dob_formatted));
		SELF 										:= L;

	END; 
	
	rsFormattedCleanDOB := join(distribute(dsOKCStudentListDid2(did<>0 and dob_formatted<>''),did),
																			 distribute(best_file,did),
																			 left.did=right.did, 
																			 fixDOB(left,right),
																			 LEFT OUTER,KEEP(1), LOCAL);

	rsFormattedFixDOB	:= dsOKCStudentListDid2(did=0 OR dob_formatted='') + rsFormattedCleanDOB;

	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).IngestName,rsFormattedFixDOB,Build_Ingest,TRUE,,TRUE);

	RETURN SEQUENTIAL(Build_Ingest);
	
END;
