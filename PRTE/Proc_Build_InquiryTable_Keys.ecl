import inquiry_acclogs;
EXPORT Proc_Build_InquiryTable_Keys(string filedate) := function
	df := dataset([],inquiry_acclogs.Layout.common_indexes);
	
	slim := record
	df.bus_intel;
	df.person_q;
	df.search_info;
	df.fraudpoint_score;
  end;
	
	df_email := project(df, slim);
	
	slim_p := record
	df.bus_intel;
	df.person_q;
	df.search_info;
  end;
	
	df_name_ipaddr := project(df, slim_p);
		
	df_bill := dataset([], recordof(Inquiry_AccLogs.File_Inquiry_Billgroups_DID().File));
	
	Key_Inquiry_Address := INDEX(df, {string5 zip := map((unsigned)person_q.zip > 0 => person_q.zip, person_q.zip5),person_q.prim_name,person_q.prim_range,person_q.sec_range}, {df},
						'~prte::key::inquiry::'+filedate+'::address');
						
	Key_Inquiry_Phone := INDEX(df, {string10 phone10 := person_q.personal_phone}, {df},
						'~prte::key::inquiry::'+filedate+'::phone');

	Key_Inquiry_SSN := INDEX(df, {string9 ssn := person_q.SSN}, {df},
						'~prte::key::inquiry::'+filedate+'::ssn' );

	Key_Inquiry_DID := INDEX(df, {unsigned6 s_did := person_q.appended_ADL}, {df},
																'~prte::key::inquiry::'+filedate+'::did');

	Key_Inquiry_Email := INDEX(df_email, {string50 email_address := person_q.email_address}, {df_email},
						'~prte::key::inquiry::'+filedate+'::email');

	Key_Inquiry_Billgroups := INDEX(df_bill, {did}, {df_bill},
						'~prte::key::inquiry::'+filedate+'::billgroups_did');
						
	Key_Inquiry_name := INDEX(df_name_ipaddr, {person_q.fname,person_q.mname,person_q.lname}, {df_name_ipaddr},
						'~prte::key::inquiry::'+filedate+'::name');

	Key_Inquiry_IPaddr := INDEX(df_name_ipaddr, {string20 IPaddr := person_q.IPaddr}, {df_name_ipaddr},
						'~prte::key::inquiry::'+filedate+'::ipaddr' );

		return 
	sequential(
		parallel(
			 build(Key_Inquiry_Address 				,update)
			,build(Key_Inquiry_Phone  		,update)
			,build(Key_Inquiry_SSN  		,update)
			,build(Key_Inquiry_DID  		,update)
			,build(Key_Inquiry_Email  		,update)
			,build(Key_Inquiry_Billgroups ,update)
			,build(Key_Inquiry_name  		,update)
			,build(Key_Inquiry_IPaddr ,update)
		)
		,PRTE.UpdateVersion(
				'InquirytableKeys'													//	Package name
			 ,filedate												//	Package version
			 ,'Jack.Freibaum@lexisnexis.com' //	Who to email with specifics
			 ,'N'																	//  auto_pkg (optional) -- don't use it
			 ,'N'																	//	N = Non-FCRA, F = FCRA
			 ,'N'                                 //	N = Do not also include boolean, Y = Include boolean, too
		)
	);
	
end;