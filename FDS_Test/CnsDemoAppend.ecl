import header,address,ut,versioncontrol,watchdog,Marketing_Best;

layw := Watchdog.Layout_Best;
layh := header.Layout_header;

export CnsDemoAppend(
	 string													pversion
	,dataset(Consumer_Layouts.Input.CleanConsumerRec	)				pSearchCriteria		= Files.Input.CleanConsumerRec
	,dataset(layw)	pWatchdog													= Watchdog.File_Best
	,dataset(layh)	pPeopleHeader												= header.File_Headers
	,boolean												pOverwrite			= false
	,boolean												pCsvout				= true
	,string													pSeparator			= '|'	

) :=
function

	pPeopleHeader_:=join(distribute(pPeopleHeader,hash(did)), distribute(Marketing_Best.file_equifax_base(did>0),hash(did))
							,left.did=right.did
							,transform({pPeopleHeader
										,String2	Num_units:=''		//OWNER_OCCUPIED_HOUSING_UNITS
										,String1	Length_of_Residence
										,String1	RentOwn				//Home_OwnerRenter_Code
										,String3	Estimated_income	//Median_Household_Income_3_bytes
										,string1	household_member_cnt
										,string1	gender}
											,self.Num_units:=right.OWNER_OCCUPIED_HOUSING_UNITS
											,self.RentOwn:=right.Home_OwnerRenter_Code
											,self.Estimated_income:=right.Median_Household_Income_3_bytes
											,self:=left
											,self:=right)
							,left outer
							,local);

	Consumer_Layouts.Response.CnsDemo_Extract_temp tConvert2Response(pPeopleHeader_ l,unsigned8 cnt) :=
	transform
	
		self.did						:= l.did;
		self.Extract.Record_ID		 	:= (string)cnt;
		self.Extract.first_Name		 	:= stringlib.stringfilterout(l.fname,'0123456789');
		self.Extract.middle_Name	 	:= stringlib.stringfilterout(l.mname,'0123456789');
		self.Extract.last_Name		 	:= stringlib.stringfilterout(l.lname,'0123456789');
		self.Extract.Street_Address		:= trim(Address.Addr1FromComponents(
																 l.prim_range
																,l.predir
																,l.prim_name
																,l.suffix
																,l.postdir
																,'',''
															),left,right);
		self.Extract.Secondary_Address 	:= trim(Address.Addr1FromComponents(
																 l.unit_desig
																,l.sec_range
																,''
																,''
																,''
																,''
																,''
															),left,right);
		self.Extract.City				:= l.city_name;
		self.Extract.State				:= l.st;
		self.Extract.Zip_Code			:= if(l.zip != '',l.zip,'');
		self.Extract.phone				:= if(l.phone != '',l.phone,'');
		self.Extract.date_of_birth		:= if(l.dob != 0, intformat(ut.Date_MMDDYYYY_i2((string)l.dob),8,1),'');
		self.Extract.Num_units					:=l.Num_units;
		self.Extract.Length_of_Residence		:=l.Length_of_Residence;
		self.Extract.RentOwn					:=l.RentOwn;
		self.Extract.Estimated_income			:=l.Estimated_income;
		self.Extract.household_member_cnt		:=l.household_member_cnt;
		self.Extract.gender						:=l.gender;
		self.Extract.SSN 				:= l.SSN;
		self.Extract.last_report_date	:= if(l.dt_last_seen != 0, intformat(ut.Date_MMDDYYYY_i2((string)l.dt_last_seen+'01'),8,1),'');
		self.clean_address.prim_range	:= l.prim_range		;
		self.clean_address.predir		:= l.predir			;
		self.clean_address.prim_name	:= l.prim_name		;
		self.clean_address.addr_suffix	:= l.suffix			;
		self.clean_address.postdir		:= l.postdir		;
		self.clean_address.unit_desig	:= l.unit_desig		;
		self.clean_address.sec_range	:= l.sec_range		;
		self.clean_address.v_city_name	:= l.city_name		;
		self.clean_address.st			:= l.st				;
		self.clean_address.zip			:= l.zip;
		self.clean_address				:= [];

	end;

// ?	SSN
	PeopleHeader:=project(pPeopleHeader_	,tConvert2Response(left,counter));

	search_by_SSN := pSearchCriteria(
									(unsigned5)SSN 		> 9999
									,name				= ''
									,address			= ''
									,Secondary_Address	= ''
									,city				= ''
									,state				= ''
									,zip_code			= ''
									,Phone_Number		= ''
									);
	SSN_match := join(
		PeopleHeader(Extract.ssn<>'')
		,search_by_SSN
		,left.Extract.SSN=right.SSN
		,transform(
			 Consumer_Layouts.Response.CnsDemo_Append_temp
				,self.SearchCriteria	:= right
				,self.Appended_data.record_id		:= right.record_id
				,self.Appended_data		:= left.Extract
				,self.did				:= left.did
		)
		,lookup
	);

// ?	SSN and name
	search_by_SSN_name := pSearchCriteria(
									(unsigned5)SSN		 > 9999
									,name				<> ''
									,address			= ''
									,Secondary_Address	= ''
									,city				= ''
									,state				= ''
									,zip_code			= ''
									,Phone_Number		= ''
									);
	SSN_name_match := join(
		PeopleHeader(Extract.ssn<>'')
		,search_by_SSN_name
		,	left.Extract.SSN=right.SSN
		and	ut.NameMatch(left.Extract.first_name,left.Extract.middle_name,left.Extract.Last_name,right.fname,right.mname,right.lname)<5
		,transform(
			 Consumer_Layouts.Response.CnsDemo_Append_temp
				,self.SearchCriteria	:= right
				,self.Appended_data.record_id		:= right.record_id
				,self.Appended_data		:= left.Extract
				,self.did				:= left.did
		)
		,lookup
	);

// ?	Partial SSN and name/address
	search_by_partSSN_nmaddr := pSearchCriteria(
									(unsigned5)SSN 		<= 9999
									,(unsigned5)SSN 	> 0
									,name				<> ''
									,address			<> ''
									,city				<> ''
									,state				<> ''
									,zip_code			<> ''
									,Phone_Number		= ''
									);
	SSN_nmaddr_match := join(
		PeopleHeader
		,search_by_partSSN_nmaddr
		,	header.ssn_value(left.Extract.SSN,right.SSN) > 0
		and	ut.NameMatch(left.Extract.first_name,left.Extract.middle_name,left.Extract.Last_name,right.fname,right.mname,right.lname)<5
		and	left.clean_address.prim_range=right.prim_range
		and left.clean_address.prim_name=right.prim_name
		and left.clean_address.sec_range=right.sec_range
		and left.clean_address.v_city_name=right.city
		and left.clean_address.st=right.state
		and left.clean_address.zip=right.zip_code
		,transform(
			 Consumer_Layouts.Response.CnsDemo_Append_temp
				,self.SearchCriteria	:= right
				,self.Appended_data.record_id		:= right.record_id
				,self.Appended_data		:= left.Extract
				,self.did				:= left.did
		)
		,lookup
	);

// ?	Name and complete address
	search_by_name_addr := pSearchCriteria(
									(unsigned5)SSN 	= 0
									,name			<> ''
									,address		<> ''
									,city			<> ''
									,state			<> ''
									,zip_code		<> ''
									,Phone_Number	= ''
									);
	name_addr_match := join(
		PeopleHeader
		,search_by_name_addr
		,	ut.NameMatch(left.Extract.first_name,left.Extract.middle_name,left.Extract.Last_name,right.fname,right.mname,right.lname)<5
		and	left.clean_address.prim_range=right.prim_range
		and left.clean_address.prim_name=right.prim_name
		and left.clean_address.sec_range=right.sec_range
		and left.clean_address.v_city_name=right.city
		and left.clean_address.st=right.state
		and left.clean_address.zip=right.zip_code
		,transform(
			 Consumer_Layouts.Response.CnsDemo_Append_temp
				,self.SearchCriteria	:= right
				,self.Appended_data.record_id		:= right.record_id
				,self.Appended_data		:= left.Extract
				,self.did				:= left.did
		)
		,lookup
	);

// ?	Name and city/state and/or ZIP
	search_by_ncsz := pSearchCriteria(
									(unsigned5)SSN		= 0
									,name				<> ''
									,address			= ''
									,city				<> ''
									,state				<> ''
									,Phone_Number		= ''
									);
	ncsz_match := join(
		PeopleHeader
		,search_by_ncsz
		,	ut.NameMatch(left.Extract.first_name,left.Extract.middle_name,left.Extract.Last_name,right.fname,right.mname,right.lname)<5
		and left.clean_address.v_city_name=right.city
		and left.clean_address.st=right.state
		and ut.nneq(left.clean_address.zip,right.zip_code)
		,transform(
			 Consumer_Layouts.Response.CnsDemo_Append_temp
				,self.SearchCriteria	:= right
				,self.Appended_data.record_id		:= right.record_id
				,self.Appended_data		:= left.Extract
				,self.did				:= left.did
		)
		,lookup
	);

// ?	Name and state
	search_by_ns := pSearchCriteria(
									(unsigned5)SSN		= 0
									,name				<> ''
									,address			= ''
									,city				= ''
									,state				<> ''
									,zip_code			= ''
									,Phone_Number		= ''
									);
	ns_match := join(
		PeopleHeader
		,search_by_ns
		,	ut.NameMatch(left.Extract.first_name,left.Extract.middle_name,left.Extract.Last_name,right.fname,right.mname,right.lname)<5
		and left.clean_address.st=right.state
		,transform(
			 Consumer_Layouts.Response.CnsDemo_Append_temp
				,self.SearchCriteria	:= right
				,self.Appended_data.record_id		:= right.record_id
				,self.Appended_data		:= left.Extract
				,self.did				:= left.did
		)
		,lookup
	);

// ?	Address only
	search_by_addr := pSearchCriteria(
									(unsigned5)SSN	= 0
									,name			= ''
									,address		<> ''
									,city			<> ''
									,state			<> ''
									,zip_code		<> ''
									,Phone_Number	= ''
									);
	addr_match := join(
		PeopleHeader
		,search_by_addr
		,	left.clean_address.prim_range=right.prim_range
		and left.clean_address.prim_name=right.prim_name
		and left.clean_address.sec_range=right.sec_range
		and left.clean_address.v_city_name=right.city
		and left.clean_address.st=right.state
		and left.clean_address.zip=right.zip_code
		,transform(
			 Consumer_Layouts.Response.CnsDemo_Append_temp
				,self.SearchCriteria	:= right
				,self.Appended_data.record_id		:= right.record_id
				,self.Appended_data		:= left.Extract
				,self.did				:= left.did
		)
		,lookup
	);

// ?	Phone number only
	search_by_ph := pSearchCriteria(
									(unsigned5)SSN	= 0
									,name			= ''
									,address		= ''
									,city			= ''
									,state			= ''
									,zip_code		= ''
									,Phone_Number	<> ''
									);
	ph_match := join(
		PeopleHeader
		,search_by_ph
		, left.Extract.phone=right.Phone_Number
		,transform(
			 Consumer_Layouts.Response.CnsDemo_Append_temp
				,self.SearchCriteria	:= right
				,self.Appended_data.record_id		:= right.record_id
				,self.Appended_data		:= left.Extract
				,self.did				:= left.did
		)
		,lookup
	);

//////
	dresponse_match :=
// ?	SSN
	SSN_match +
// ?	SSN and name
	SSN_name_match +
// ?	Partial SSN and name/address
	SSN_nmaddr_match +
// ?	Name and complete address
	name_addr_match +
// ?	Name and city/state and/or ZIP
	ncsz_match +
// ?	Name and state
	ns_match +
// ?	Address only
	addr_match +
// ?	Phone number only
	ph_match ;
///////

	dresponse1 := rollup(sort(distribute(dresponse_match,hash(SearchCriteria.Record_ID))
					,SearchCriteria.Record_ID
					,appended_data.first_name
					,appended_data.last_name
					,appended_data.street_address
					,appended_data.state
					,local)
						,	left.SearchCriteria.Record_ID		=right.SearchCriteria.Record_ID
						and	left.appended_data.first_name		=right.appended_data.first_name
						and	left.appended_data.last_name		=right.appended_data.last_name
						and	left.appended_data.street_address	=right.appended_data.street_address
						and	left.appended_data.state			=right.appended_data.state
								,transform(recordof(dresponse_match)
									,self.appended_data.middle_name			:=if(left.appended_data.first_name='',right.appended_data.first_name,left.appended_data.first_name)
									,self.appended_data.secondary_address	:=if(left.appended_data.secondary_address='',right.appended_data.secondary_address,left.appended_data.secondary_address)
									,self.appended_data.city				:=if(left.appended_data.city='',right.appended_data.city,left.appended_data.city)
									,self.appended_data.state				:=if(left.appended_data.state='',right.appended_data.state,left.appended_data.state)
									,self.appended_data.zip_code			:=if(left.appended_data.zip_code='',right.appended_data.zip_code,left.appended_data.zip_code)
									,self.appended_data.Phone				:=if(left.appended_data.Phone='',right.appended_data.Phone,left.appended_data.Phone)
									,self.appended_data.date_of_birth		:=if(left.appended_data.date_of_birth='',right.appended_data.date_of_birth,left.appended_data.date_of_birth)
									,self:=left
								)
			,local);

	dresponse := dedup(sort(dresponse1
								,SearchCriteria.Record_ID
								,-appended_data.last_report_date[5..8]
								,-appended_data.last_report_date[1..2]
								,-appended_data.last_report_date[3..4]
							),SearchCriteria.Record_ID,local,keep 5);
	
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.CnsDemo_Append.new					,dresponse,BuildResponseFile,,pCsvout,pOverwrite,pSeparator);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.CnsDemo_Append.new + 'PipeDelimited'	,dresponse,BuildResponseFilePipe,,pCsvout,pOverwrite,pSeparator);

	dresponse_forstats := project(dresponse	,transform({Consumer_Layouts.Response.CnsDemo_append,string stuff}, self := left;self.stuff := 'G'));
	
	layout_stat := 
	record
    integer countGroup := count(group);
		dresponse_forstats.stuff  ;
		First_Name_CountNonBlank    	:= sum(group,if(dresponse_forstats.Appended_data.first_Name			<>'',1,0));
		Middle_Name_CountNonBlank   	:= sum(group,if(dresponse_forstats.Appended_data.middle_Name		<>'',1,0));
		Last_Name_CountNonBlank    		:= sum(group,if(dresponse_forstats.Appended_data.last_Name			<>'',1,0));
		Street_Address_CountNonBlank    := sum(group,if(dresponse_forstats.Appended_data.Street_Address		<>'',1,0));
		Secondary_Address_CountNonBlank := sum(group,if(dresponse_forstats.Appended_data.Secondary_Address	<>'',1,0));
		City_CountNonBlank              := sum(group,if(dresponse_forstats.Appended_data.City				<>'',1,0));
		State_CountNonBlank             := sum(group,if(dresponse_forstats.Appended_data.State				<>'',1,0));
		Zip_Code_CountNonBlank          := sum(group,if(dresponse_forstats.Appended_data.Zip_Code			<>'',1,0));
		phone_CountNonBlank             := sum(group,if(dresponse_forstats.Appended_data.phone				<>'',1,0));
		SSN_CountNonBlank         	    := sum(group,if(dresponse_forstats.Appended_data.SSN 				<>'',1,0));
		date_of_birth_CountNonBlank   	:= sum(group,if(dresponse_forstats.Appended_data.date_of_birth	<>'',1,0));
                                                     
	end;
	
	dresponse_fill_stats := table(dresponse_forstats, layout_stat, stuff,few);

	// -- //match rates

	tSearch_by_SSN:=count(search_by_SSN);
	tSearch_by_SSN_name:=count(search_by_SSN_name);
	tSearch_by_partSSN_nmaddr:=count(search_by_partSSN_nmaddr);
	tSearch_by_name_addr:=count(search_by_name_addr);
	tSearch_by_ncsz:=count(search_by_ncsz);
	tSearch_by_ns:=count(search_by_ns);
	tSearch_by_addr:=count(search_by_addr);
	tSearch_by_ph:=count(search_by_ph);

	tSSN_match:=count(table(SSN_match,{searchcriteria.record_id},searchcriteria.record_id));
	tSSN_name_match:=count(table(SSN_name_match,{searchcriteria.record_id},searchcriteria.record_id));
	tSSN_nmaddr_match:=count(table(SSN_nmaddr_match,{searchcriteria.record_id},searchcriteria.record_id));
	tName_addr_match:=count(table(name_addr_match,{searchcriteria.record_id},searchcriteria.record_id));
	tNcsz_match:=count(table(ncsz_match,{searchcriteria.record_id},searchcriteria.record_id));
	tNs_match:=count(table(ns_match,{searchcriteria.record_id},searchcriteria.record_id));
	tAddr_match:=count(table(addr_match,{searchcriteria.record_id},searchcriteria.record_id));
	tPh_match:=count(table(ph_match,{searchcriteria.record_id},searchcriteria.record_id));

	matchrate1 := (real8)(tSearch_by_SSN - tSSN_match) / (real8)tSearch_by_SSN * 100.0;
	matchrate2 := (real8)(tSearch_by_SSN_name - tSSN_name_match) / (real8)tSearch_by_SSN_name * 100.0;
	matchrate3 := (real8)(tSearch_by_partSSN_nmaddr - tSSN_nmaddr_match) / (real8)tSearch_by_partSSN_nmaddr * 100.0;
	matchrate4 := (real8)(tSearch_by_name_addr - tName_addr_match) / (real8)tSearch_by_name_addr * 100.0;
	matchrate5 := (real8)(tSearch_by_ncsz - tNcsz_match) / (real8)tSearch_by_ncsz * 100.0;
	matchrate6 := (real8)(tSearch_by_ns - tNs_match) / (real8)tSearch_by_ns * 100.0;
	matchrate7 := (real8)(tSearch_by_addr - tAddr_match) / (real8)tSearch_by_addr * 100.0;
	matchrate8 := (real8)(tSearch_by_ph - tPh_match) / (real8)tSearch_by_ph * 100.0;

	return sequential(
		 output('FDS Append Results Follow'						,named('_'							))

		,BuildResponseFile
		// ,BuildResponseFilePipe
// ,String2	Num_units:=''		//OWNER_OCCUPIED_HOUSING_UNITS
// ,String1	Length_of_Residence
// ,String1	RentOwn				//Home_OwnerRenter_Code
// ,String3	Estimated_income	//Median_Household_Income_3_bytes
// ,string1	household_member_cnt
// ,string1	gender}

		,output(dresponse_fill_stats						,named('Appended_fields_fill_Rates'	))
		,output(tSearch_by_SSN									,named('FDS_Search_File_With_SSN'	))
		,output(tSearch_by_SSN - tSSN_match						,named('Consumer_SSN_Not_Matched'	))
		,output(matchrate1										,named('Percentage_Match_Rate_by_SSN'		))
		,output(tSearch_by_SSN_name							,named('FDS_Search_File_With_SSN_and_name'	))
		,output(tSearch_by_SSN_name - tSSN_name_match		,named('Consumer_SSN_and_name_Not_Matched'	))
		,output(matchrate2									,named('Percentage_Match_Rate_by_SSN_and_name'		))
		,output(tSearch_by_partSSN_nmaddr						,named('FDS_Search_File_With_SSSN_and_name_address'	))
		,output(tSearch_by_partSSN_nmaddr - tSSN_nmaddr_match	,named('Consumer_SSN_and_name_address_Not_Matched'	))
		,output(matchrate3										,named('Percentage_Match_Rate_by_Partial_SSN_and_name_address'		))
		,output(tSearch_by_name_addr						,named('FDS_Search_File_With_Name_and_complete_address'	))
		,output(tSearch_by_name_addr - tName_addr_match		,named('Consumer_Name_and_complete_address_Not_Matched'	))
		,output(matchrate4									,named('Percentage_Match_Rate_by_Name_and_complete_address'		))
		,output(tSearch_by_ncsz									,named('FDS_Search_File_With_Name_and_city_state_and_or_ZIP'	))
		,output(tSearch_by_ncsz - tNcsz_match					,named('Consumer_Name_and_city_state_and_or_ZIP_Not_Matched'	))
		,output(matchrate5										,named('Percentage_Match_Rate_by_Name_and_city_state_and_or_ZIP'		))
		,output(tSearch_by_ns								,named('FDS_Search_File_With_Name_and_state'	))
		,output(tSearch_by_ns - tNs_match					,named('Consumer_Name_and_state_Not_Matched'	))
		,output(matchrate6									,named('Percentage_Match_Rate_by_Name_and_state'		))
		,output(tSearch_by_addr									,named('FDS_Search_File_With_Address_only'	))
		,output(tSearch_by_addr - tAddr_match					,named('Consumer_Address_only_Not_Matched'	))
		,output(matchrate7										,named('Percentage_Match_Rate_by_Address_only'		))
		,output(tSearch_by_ph								,named('FDS_Search_File_With_Phone_number_only'	))
		,output(tSearch_by_ph - tPh_match					,named('Consumer_Phone_number_only_Not_Matched'	))
		,output(matchrate8									,named('Percentage_Match_Rate_by_Phone_number_only'		))
		
	);

end;