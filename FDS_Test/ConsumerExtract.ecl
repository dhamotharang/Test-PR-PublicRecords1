import header,address,ut,versioncontrol,watchdog;

layw := Watchdog.Layout_Best;
layh := header.Layout_header;

export ConsumerExtract(
	 string			pversion
	,dataset(layw)	pWatchdog		= Watchdog.File_Best
	,dataset(layh)	pPeopleHeader 	= header.File_Headers
	,set of string	pZipCodes		= ZipcodeSet		
	,boolean		pOverwrite		= false
	,boolean		pCsvout			= true
	,string			pSeparator		= '|'	

) :=
function
	h:=pPeopleHeader;
	dbh_filter0 := pWatchdog(zip in pZipCodes);
	dbh_filter1 :=join(dbh_filter0,h
							,	left.did=right.did
							,transform({dbh_filter0,h.dt_first_seen,h.dt_last_seen}
											,self:=left
											,self:=right
										)
							,left outer
							,local):persist('temp::fds_test::ssn_dts');
	dbh_filter_:=rollup(
					sort(dbh_filter1,did,local)
					,left.did=right.did
					,transform(recordof(dbh_filter1)
							,self.dt_first_seen:= ut.Min2(left.dt_first_seen,right.dt_first_seen)
							,self.dt_last_seen:= ut.Max2(left.dt_last_seen,right.dt_last_seen)
							,self:=left
							));

	dbh_filter:=join(dbh_filter_, header.file_ssn_map((unsigned3)ssn5>0)
							,left.ssn[1..5]=right.ssn5
							,transform({dbh_filter_
										,string50 SSN_issuing_state
										,string8 SSN_issuing_date}
											,self.SSN_issuing_state:=right.state
											,self.SSN_issuing_date:=if(right.end_date > ut.getdate,'20091231',right.end_date)
											,self:=left)
							,left outer
							,lookup);


	Consumer_Layouts.Response.Consumer_Extract tConvert2Response(dbh_filter l,unsigned8 cnt) :=
	transform
	
		self.Record_ID			 := (string)cnt;
		self.first_Name		 	:= stringlib.stringfilterout(l.fname,'0123456789');
		self.middle_Name	 	:= stringlib.stringfilterout(l.mname,'0123456789');
		self.last_Name		 	:= stringlib.stringfilterout(l.lname,'0123456789');
		self.Street_Address		 := trim(Address.Addr1FromComponents(
																 l.prim_range
																,l.predir
																,l.prim_name
																,l.suffix
																,l.postdir
																,'',''
															),left,right);
		self.Secondary_Address := trim(Address.Addr1FromComponents(
																 l.unit_desig
																,l.sec_range
																,''
																,''
																,''
																,''
																,''
															),left,right);
		self.City				:= l.city_name;
		self.State				:= l.st;
		self.Zip_Code			:= if(l.zip != '',l.zip,'');
		self.phone				:= if(l.phone != '',l.phone,'');
		self.SSN 				:= l.ssn;
		self.SSN_issuing_state	:= StringLib.StringToUpperCase(l.SSN_issuing_state);
		self.SSN_issuing_date	:= if((unsigned4)l.SSN_issuing_date != 0, intformat(ut.Date_MMDDYYYY_i2((string)l.SSN_issuing_date),8,1),'');
		self.date_of_birth	 	:= if(l.dob != 0, intformat(ut.Date_MMDDYYYY_i2((string)l.dob),8,1),'');
		self.added_date	 		:= if(l.dt_first_seen != 0, intformat(ut.Date_MMDDYYYY_i2((string)l.dt_first_seen+'01'),8,1),'');
		self.last_report_date	:= if(l.dt_last_seen != 0, intformat(ut.Date_MMDDYYYY_i2((string)l.dt_last_seen+'01'),8,1),'');

	end;

	dresponse := project(dbh_filter	,tConvert2Response(left,counter));
		
	dresponse_deduped := dedup(sort(dresponse,(unsigned8)Record_ID,-last_report_date),keep 5);

	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.Cns_Extract.new	,dresponse_deduped	,BuildResponseFile,,pCsvout,pOverwrite,pSeparator);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.Cns_Extract.new	 + 'PipeDelimited',dresponse_deduped	,BuildResponseFilePipe,,pCsvout,pOverwrite,pSeparator);

	dresponse_forstats := project(dresponse	,transform({Consumer_Layouts.Response.Consumer_Extract,string stuff}, self := left;self.stuff := 'G'));
	
	layout_stat := 
	record
    integer countGroup := count(group);
		dresponse_forstats.stuff  ;
		Record_ID_CountNonBlank          := sum(group,if(dresponse_forstats.Record_ID			<>'',1,0));
		First_Name_CountNonBlank	     := sum(group,if(dresponse_forstats.first_Name			<>'',1,0));
		Middle_Name_CountNonBlank    	 := sum(group,if(dresponse_forstats.middle_Name			<>'',1,0));
		Last_Name_CountNonBlank     	 := sum(group,if(dresponse_forstats.last_Name			<>'',1,0));
		Street_Address_CountNonBlank     := sum(group,if(dresponse_forstats.Street_Address		<>'',1,0));
		Secondary_Address_CountNonBlank  := sum(group,if(dresponse_forstats.Secondary_Address	<>'',1,0));
		City_CountNonBlank               := sum(group,if(dresponse_forstats.City				<>'',1,0));
		State_CountNonBlank              := sum(group,if(dresponse_forstats.State				<>'',1,0));
		Zip_Code_CountNonBlank           := sum(group,if(dresponse_forstats.Zip_Code			<>'',1,0));
		phone_CountNonBlank              := sum(group,if(dresponse_forstats.phone				<>'',1,0));
		ssn_CountNonBlank          		 := sum(group,if(dresponse_forstats.ssn 				<>'',1,0));
		SSN_issuing_state_CountNonBlank  := sum(group,if(dresponse_forstats.SSN_issuing_state	<>'',1,0));
		SSN_issuing_date_CountNonBlank   := sum(group,if(dresponse_forstats.SSN_issuing_date	<>'',1,0));
		date_of_birth_CountNonBlank   	 := sum(group,if(dresponse_forstats.date_of_birth		<>'',1,0));
		added_date_CountNonBlank  		 := sum(group,if(dresponse_forstats.added_date			<>'',1,0));
		last_report_date_CountNonBlank   := sum(group,if(dresponse_forstats.last_report_date	<>'',1,0));

	end;
	
	dresponse_stats := table(dresponse_forstats, layout_stat, stuff,few);

	return sequential(
		 output('FDS Extract Results Follow'	,named('__'							))
		,BuildResponseFile
		// ,BuildResponseFilePipe
		,output(dresponse_stats								,named('Consumer_Extract_Fill_Rates'))
	);

end;