//Populate PRTE keys for American Student List
IMPORT Data_Services, American_student_list;

EXPORT Proc_Build_ASL_Keys(STRING version) := FUNCTION

	//DID
	ASL_DID_Key_Layout	:= RECORD
      unsigned6 l_did;
			American_student_list.layout_american_student_base and not [HISTORICAL_FLAG, SOURCE];
      unsigned8 __internal_fpos__;
	END;
	prte_asl_did:=buildindex(index(dataset([],ASL_DID_Key_Layout),
																 {l_did},{dataset([],ASL_DID_Key_Layout)},'keyname'),
																 Data_Services.Data_location.Prefix('american_student')+'prte::key::American_Student::'+version+'::DID',update);
	//DID2
	ASL_DID2_Key_Layout	:= RECORD
      unsigned6 l_did;
			American_student_list.layout_american_student_base_v2;
      unsigned8 __internal_fpos__;
	END;
	prte_asl_did2:=buildindex(index(dataset([],ASL_DID2_Key_Layout),
																 {l_did},{dataset([],ASL_DID2_Key_Layout)},'keyname'),
																 Data_Services.Data_location.Prefix('american_student')+'prte::key::American_Student::'+version+'::DID2',update);
	//Address List   DF-18244
	ASL_Address_List_Key_Layout	:= RECORD
      string50 ln_college_name;
			American_student_list.layout_american_student_list_address_matches;
      unsigned8 __internal_fpos__;
	END;
	prte_asl_address_list:=buildindex(index(dataset([],American_student_list.layout_american_student_list_address_matches),
																 {LN_COLLEGE_NAME},{dataset([],American_student_list.layout_american_student_list_address_matches)},'keyname'),
																 Data_Services.Data_location.Prefix('american_student')+'prte::key::American_Student::'+version+'::address_list',update);

	//FCRA DID
	prte_fcra_asl_did:=buildindex(index(dataset([],ASL_DID_Key_Layout),
																 {l_did},{dataset([],ASL_DID_Key_Layout)},'keyname'),
																 /*Data_Services.Data_location.Prefix('fcra')+*/'~prte::key::fcra::American_Student::'+version+'::DID',update);

	//FCRA DID2
	prte_fcra_asl_did2:=buildindex(index(dataset([],ASL_DID2_Key_Layout),
																 {l_did},{dataset([],ASL_DID2_Key_Layout)},'keyname'),
																 /*Data_Services.Data_location.Prefix('fcra')+*/'~prte::key::fcra::American_Student::'+version+'::DID2',update);
	//Auto keys - Address
	arecord2:= RECORD
		string28 prim_name;
		string10 prim_range;
		string2 st;
		unsigned4 city_code;
		string5 zip;
		string8 sec_range;
		string6 dph_lname;
		string20 lname;
		string20 pfname;
		string20 fname;
		unsigned8 states;
		unsigned4 lname1;
		unsigned4 lname2;
		unsigned4 lname3;
		unsigned4 lookups;
		unsigned6 did;
	END;
	prte_asl_ak_address:=buildindex(index(dataset([],arecord2),{prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups},{dataset([],arecord2)},'keyname'),'~prte::key::american_student::'+version+'::autokey::address',update);
	
	//Auto keys - CityStName
	arecord3:= RECORD
		unsigned4 city_code;
		string2 st;
		string6 dph_lname;
		string20 lname;
		string20 pfname;
		string20 fname;
		integer4 dob;
		unsigned8 states;
		unsigned4 lname1;
		unsigned4 lname2;
		unsigned4 lname3;
		unsigned4 city1;
		unsigned4 city2;
		unsigned4 city3;
		unsigned4 rel_fname1;
		unsigned4 rel_fname2;
		unsigned4 rel_fname3;
		unsigned4 lookups;
		unsigned6 did;
	END;
	prte_asl_ak_citystname:=buildindex(index(dataset([],arecord3),{city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dataset([],arecord3)},'keyname'),'~prte::key::american_student::'+version+'::autokey::citystname',update);
	
	//Auto keys - Name
	arecord4:= RECORD
		string6 dph_lname;
		string20 lname;
		string20 pfname;
		string20 fname;
		string1 minit;
		unsigned2 yob;
		unsigned2 s4;
		integer4 dob;
		unsigned8 states;
		unsigned4 lname1;
		unsigned4 lname2;
		unsigned4 lname3;
		unsigned4 city1;
		unsigned4 city2;
		unsigned4 city3;
		unsigned4 rel_fname1;
		unsigned4 rel_fname2;
		unsigned4 rel_fname3;
		unsigned4 lookups;
		unsigned6 did;
	END;
	prte_asl_ak_name:=buildindex(index(dataset([],arecord4),{dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dataset([],arecord4)},'keyname'),'~prte::key::american_student::'+version+'::autokey::name',update);

	//Auto keys - Payload
	arecord9:= RECORD
		unsigned6 fakeid;
		American_student_list.layout_american_student_base_v2 and not source;
		unsigned1 zero;
		string1 blank;
		unsigned8 __internal_fpos__;
	 END;
	prte_asl_ak_payload:=buildindex(index(dataset([],arecord9),{fakeid},{dataset([],arecord9)},'keyname'),'~prte::key::american_student::'+version+'::autokey::payload',update);

	//Auto keys - Phone2
	arecord5:= RECORD
		string7 p7;
		string3 p3;
		string6 dph_lname;
		string20 pfname;
		string2 st;
		unsigned6 did;
		unsigned4 lookups;
	END;
	prte_asl_ak_phone2:=buildindex(index(dataset([],arecord5),{p7,p3,dph_lname,pfname,st,did},{dataset([],arecord5)},'keyname'),'~prte::key::american_student::'+version+'::autokey::phone2',update);

	//Auto keys - SSN2
	arecord6:= RECORD
		string1 s1;
		string1 s2;
		string1 s3;
		string1 s4;
		string1 s5;
		string1 s6;
		string1 s7;
		string1 s8;
		string1 s9;
		string6 dph_lname;
		string20 pfname;
		unsigned6 did;
		unsigned4 lookups;
	END;
	prte_asl_ak_ssn2:=buildindex(index(dataset([],arecord6),{s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did},{dataset([],arecord6)},'keyname'),'~prte::key::american_student::'+version+'::autokey::ssn2',update);
	
	//Auto keys - StName
	arecord7:= RECORD
		string2 st;
		string6 dph_lname;
		string20 lname;
		string20 pfname;
		string20 fname;
		string1 minit;
		unsigned2 yob;
		unsigned2 s4;
		integer4 zip;
		integer4 dob;
		unsigned8 states;
		unsigned4 lname1;
		unsigned4 lname2;
		unsigned4 lname3;
		unsigned4 city1;
		unsigned4 city2;
		unsigned4 city3;
		unsigned4 rel_fname1;
		unsigned4 rel_fname2;
		unsigned4 rel_fname3;
		unsigned4 lookups;
		unsigned6 did;
	END;
	prte_asl_ak_stname:=buildindex(index(dataset([],arecord7),{st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dataset([],arecord7)},'keyname'),'~prte::key::american_student::'+version+'::autokey::stname',update);

	//Auto keys - Zip
	arecord8:= RECORD
		integer4 zip;
		string6 dph_lname;
		string20 lname;
		string20 pfname;
		string20 fname;
		string1 minit;
		unsigned2 yob;
		unsigned2 s4;
		integer4 dob;
		unsigned8 states;
		unsigned4 lname1;
		unsigned4 lname2;
		unsigned4 lname3;
		unsigned4 city1;
		unsigned4 city2;
		unsigned4 city3;
		unsigned4 rel_fname1;
		unsigned4 rel_fname2;
		unsigned4 rel_fname3;
		unsigned4 lookups;
		unsigned6 did;
	END;
	prte_asl_ak_zip:=buildindex(index(dataset([],arecord8),{zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dataset([],arecord8)},'keyname'),'~prte::key::american_student::'+version+'::autokey::zip',update);

	RETURN PARALLEL(prte_asl_did,
								  prte_asl_did2,
									prte_asl_address_list,											//DF18244
									prte_fcra_asl_did,
									prte_fcra_asl_did2,
								  prte_asl_ak_address,
								  prte_asl_ak_citystname,
								  prte_asl_ak_name,
								  prte_asl_ak_phone2,
								  prte_asl_ak_ssn2,
								  prte_asl_ak_stname,
								  prte_asl_ak_zip,
								  prte_asl_ak_payload
									);

END;