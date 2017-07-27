IMPORT Business_Header, ut;

export fABIUS_Executive_As_Business_Contact(dataset(Layout_abius_executive_data_In) pABIUS_Executive)
 :=
  function

	string8 validatedate(string8 mydate) :=
	map(mydate = '' or (integer)mydate > (integer)(stringlib.GetDateYYYYMMDD()) or (integer)mydate < 16000101 => '',
		mydate);

	string35 mapProfessionalTitle(string1 prof_title_code) :=
	MAP(
	prof_title_code = 'A' => 'CHAIRMAN',
	prof_title_code = 'B' => 'VICE CHAIRMAN',
	prof_title_code = 'C' => 'CHIEF EXECUTIVE OFFICER',
	prof_title_code = 'D' => 'DIRECTOR (PUBLIC CO)',
	prof_title_code = 'E' => 'CHIEF OPERATING OFFICER',
	prof_title_code = 'F' => 'CHIEF FINANCIAL OFFICER',
	prof_title_code = 'G' => 'TREASURER',
	prof_title_code = 'H' => 'CONTROLLER',
	prof_title_code = 'I' => 'EXECUTIVE VICE PRESIDENT',
	prof_title_code = 'J' => 'SENIOR VICE PRESIDENT',
	prof_title_code = 'K' => 'VICE PRESIDENT',
	prof_title_code = 'L' => 'ADMINISTRATION EXECUTIVE',
	prof_title_code = 'M' => 'CORPORATE COMMUNICATIONS EXECUTIVE',
	prof_title_code = 'N' => 'DATA PROCESSING EXECUTIVE',
	prof_title_code = 'O' => 'FINANCE EXECUTIVE',
	prof_title_code = 'P' => 'HUMAN RESOURCES EXECUTIVE',
	prof_title_code = 'Q' => 'TELECOMMUNICATION EXECUTIVE',
	prof_title_code = 'R' => 'MARKETING EXECUTIVE',
	prof_title_code = 'S' => 'OPERATIONS EXECUTIVE',
	prof_title_code = 'T' => 'SALES EXECUTIVE',
	prof_title_code = 'U' => 'CORPORATE SECRETARY',
	prof_title_code = 'V' => 'GENERAL COUNSEL',
	prof_title_code = 'W' => 'EXECUTIVE OFFICER',
	prof_title_code = 'X' => 'PLANT MANAGER',
	prof_title_code = 'Y' => 'PURCHASING AGENT',
	prof_title_code = 'Z' => 'AUDITOR',
	prof_title_code = '1' => 'OWNER',
	prof_title_code = '2' => 'PRESIDENT',
	prof_title_code = '3' => 'MANAGER',
	prof_title_code = '4' => 'EXECUTIVE DIRECTOR',
	prof_title_code = '5' => 'PRINCIPAL',
	prof_title_code = '6' => 'PUBLISHER',
	prof_title_code = '7' => 'ADMINISTRATOR',
	prof_title_code = '8' => 'RELIGIOUS LEADER',
	prof_title_code = '9' => 'PARTNER', ' ');



	//*************************************************************************
	// Translate Contact from abius to Business Contact Format
	//*************************************************************************

	abius_executive_contacts := pABIUS_Executive(CONTACT_NAME <> '');

	Business_Header.Layout_Business_Contact_Full Translate_abius_to_BCF(Layout_abius_executive_data_In l, integer CTR) := TRANSFORM
	SELF.vendor_id 		 := L.ABI_NUMBER + L.COMPANY_NAME;
	SELF.dt_first_seen 		 := if(L.DATE_ADDED <> '', ((UNSIGNED4)L.DATE_ADDED) * 100, 0);
	SELF.dt_last_seen		 := if(L.DATE_ADDED <> '', ((UNSIGNED4)L.DATE_ADDED) * 100, 0);
	SELF.source			 := 'IA'; 
	SELF.record_type		 := 'C';
	SELF.company_title		 := stringlib.stringtouppercase(mapProfessionalTitle(L.CONTACT_TITLE));
	SELF.company_department 	 := '';
	SELF.title			 := L.title;
	SELF.fname			 := L.fname;
	SELF.mname			 := L.mname;
	SELF.lname			 := L.lname;
	SELF.name_suffix		 := L.name_suffix;
	SELF.name_score		 := Business_Header.CleanName(l.fname,l.mname,l.lname, l.name_suffix)[142];
	SELF.prim_range 		 := CHOOSE(CTR, L.prim_range, 	L.prim_range2, 	L.prim_range, 		L.prim_range2);
	SELF.predir 			 := CHOOSE(CTR, L.predir, 		L.predir2, 		L.predir, 		L.predir2);
	SELF.prim_name 		 := CHOOSE(CTR, L.prim_name, 		L.prim_name2, 		L.prim_name, 		L.prim_name2);
	SELF.addr_suffix 		 := CHOOSE(CTR, L.addr_suffix, 	L.addr_suffix2, 	L.addr_suffix, 	L.addr_suffix2);
	SELF.postdir 			 := CHOOSE(CTR, L.postdir, 		L.postdir2, 		L.postdir, 		L.postdir2);
	SELF.unit_desig 		 := CHOOSE(CTR, L.unit_desig, 	L.unit_desig2, 	L.unit_desig, 		L.unit_desig2);
	SELF.sec_range 		 := CHOOSE(CTR, L.sec_range, 		L.sec_range2, 		L.sec_range, 		L.sec_range2);
	SELF.city 			 := CHOOSE(CTR, L.p_city_name, 	L.p_city_name2, 	L.p_city_name, 	L.p_city_name2);
	SELF.state 			 := CHOOSE(CTR, L.st, 			L.st2, 			L.st, 			L.st2);
	SELF.zip 				 := CHOOSE(CTR, (UNSIGNED3)L.z5, 	(UNSIGNED3)L.z52, 	(UNSIGNED3)L.z5, 	(UNSIGNED3)L.z52);
	SELF.zip4 			 := CHOOSE(CTR, (UNSIGNED2)L.zip4, (UNSIGNED2)L.zip42, (UNSIGNED2)L.zip4, 	(UNSIGNED2)L.zip42);
	SELF.county 			 := CHOOSE(CTR, L.county[3..5], 	L.county2[3..5], 	L.county[3..5], 	L.county2[3..5]);
	SELF.msa 				 := CHOOSE(CTR, L.msa, 			L.msa2, 			L.msa, 			L.msa2);
	SELF.geo_lat 			 := CHOOSE(CTR, L.geo_lat, 		L.geo_lat2, 		L.geo_lat, 		L.geo_lat2);
	SELF.geo_long 			 := CHOOSE(CTR, L.geo_long, 		L.geo_long2, 		L.geo_long, 		L.geo_long2);
	SELF.phone			 := (unsigned6)((unsigned8)L.PHONE);
	SELF.email_address		 := '';
	SELF.ssn				 := 0;
	SELF.company_source_group := L.ABI_NUMBER;
	SELF.company_name		 := L.COMPANY_NAME;
	SELF.company_prim_range 	 := CHOOSE(CTR, L.prim_range, 	L.prim_range2, 	L.prim_range2, 	L.prim_range);
	SELF.company_predir 	 := CHOOSE(CTR, L.predir, 		L.predir2, 		L.predir2, 		L.predir);
	SELF.company_prim_name 	 := CHOOSE(CTR, L.prim_name, 		L.prim_name2, 		L.prim_name2, 		L.prim_name);
	SELF.company_addr_suffix  := CHOOSE(CTR, L.addr_suffix, 	L.addr_suffix2, 	L.addr_suffix2, 	L.addr_suffix);
	SELF.company_postdir 	 := CHOOSE(CTR, L.postdir, 		L.postdir2, 		L.postdir2, 		L.postdir);
	SELF.company_unit_desig 	 := CHOOSE(CTR, L.unit_desig, 	L.unit_desig2, 	L.unit_desig2, 	L.unit_desig);
	SELF.company_sec_range 	 := CHOOSE(CTR, L.sec_range, 		L.sec_range2, 		L.sec_range2, 		L.sec_range);
	SELF.company_city 		 := CHOOSE(CTR, L.p_city_name, 	L.p_city_name2, 	L.p_city_name2, 	L.p_city_name);
	SELF.company_state 		 := CHOOSE(CTR, L.st, 			L.st2, 			L.st2, 			L.st);
	SELF.company_zip 		 := CHOOSE(CTR, (UNSIGNED3)L.z5, 	(UNSIGNED3)L.z52, 	(UNSIGNED3)L.z52, 	(UNSIGNED3)L.z5);
	SELF.company_zip4 		 := CHOOSE(CTR, (UNSIGNED2)L.zip4, (UNSIGNED2)L.zip42, (UNSIGNED2)L.zip42, (UNSIGNED2)L.zip4);
	SELF.company_phone		 := (unsigned6)((unsigned8)L.PHONE);
	SELF.company_fein 		 := 0;
	end;

	//--------------------------------------------
	// Normalize names
	//--------------------------------------------
	from_abius_executive_norm := NORMALIZE(abius_executive_contacts, 4, Translate_abius_To_BCF(LEFT, COUNTER));

	from_abius_executive_norm_filtered	:=	from_abius_executive_norm((integer)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix));
	
	return from_abius_executive_norm_filtered;

  end
 ;
