pSearchCriteria:=fds_test.Files.input.CleanConsumerRec;
TULT:=dataset('~thor400_84::persist::transunion_did',header.Layout_Header,flat);
h:=distribute((header.File_Headers + TULT)(header.Blocked_data()),hash(did));
w:=distribute(Watchdog.File_Best,hash(did));
m:=distribute(Marketing_Best.file_equifax_base(did>0),hash(did));

fds_test.Consumer_Layouts.Input.H_Enhanced tr0(h l, w r) := transform
	self.title:=if(l.title='',r.title,l.title);
	fname:=if(l.fname=r.lname and l.lname=r.fname,r.fname,datalib.PreferredFirstNew(l.fname,true));
	mname:=if(l.mname='',r.mname,datalib.PreferredFirstNew(l.mname,true));
	lname:=if(l.lname=r.fname and l.fname=r.lname,r.lname,l.lname);
	name_suffix:=if(l.name_suffix='' or l.name_suffix[1..2]='UN',r.name_suffix,l.name_suffix);
	self.fname:=StringLib.StringFilterOut(fname,'`~!@#$%^&*()_-+={[}]|\\:;"\'<,>.?/0123456789');
	self.mname:=StringLib.StringFilterOut(mname,'`~!@#$%^&*()_-+={[}]|\\:;"\'<,>.?/0123456789');
	self.lname:=StringLib.StringFilterOut(lname,'`~!@#$%^&*()_+={[}]|\\:;"\'<,>.?/0123456789'); // leave dashes alone
	self.name_suffix:=StringLib.StringFilterOut(name_suffix,'`~!@#$%^&*()_-+={[}]|\\:;"\'<,>.?/');
	self.phone:=if(l.phone<>r.phone and r.phone<>'',r.phone,l.phone);
	self.ssn:=if(l.ssn='',r.ssn,if((l.valid_ssn<>'G' or l.jflag3<>'C') and r.ssn<>'',r.ssn,l.ssn));
	self.dob:=if(l.dob=0,r.dob,if(l.jflag1<>'C' and r.dob>0,r.dob,l.dob));
	self:=l;
	self:=r;
	self:=[];
end;

h_enhanced0 :=join(distribute(h,hash(did)),distribute(w,hash(did))
			,	left.did=right.did
			,tr0(left,right)
			,left outer
			,local);

fds_test.Consumer_Layouts.Input.H_Enhanced tr1(h_enhanced0 l, m r) := transform
	self.Num_units:=r.Dwelling_Type;
	// self.Num_units:=case((integer)r.Dwelling_Type
									// ,1 => '1'
									// ,2 => '4'
									// ,3 => '4'
									// ,4 => '9'
									// ,5 => '9'
									// ,6 => '11'
									// ,7 => '11'
									// ,'');
	self.Length_of_Residence:=r.Length_of_Residence;
	// self.Length_of_Residence:=case(r.Length_of_Residence
									// ,'A' => '1'
									// ,'B' => '1'
									// ,'C' => '1'
									// ,'D' => '2'
									// ,'E' => '3'
									// ,'F' => '4'
									// ,'G' => '5'
									// ,'H' => '6'
									// ,'I' => '7'
									// ,'J' => '8'
									// ,'K' => '9'
									// ,'L' => '10'
									// ,'M' => '11'
									// ,'N' => '12'
									// ,'O' => '13'
									// ,'P' => '14'
									// ,'Q' => '15'
									// ,'R' => '16'
									// ,'S' => '17'
									// ,'T' => '18'
									// ,'U' => '19'
									// ,'V' => '20'
									// ,'');
	self.RentOwn:=r.Home_OwnerRenter_Code;
	// self.RentOwn:=case((integer)r.Home_OwnerRenter_Code
									// ,1 => 'RENTER'
									// ,2 => 'RENTER'
									// ,3 => 'OWNER'
									// ,4 => 'OWNER'
									// ,'');
	self.Estimated_income:=r.Narrow_Band_Income_Predictor;
	// self.Estimated_income:=case(r.Narrow_Band_Income_Predictor
									// ,'1' => '4000'
									// ,'2' => '15000'
									// ,'3' => '20000'
									// ,'4' => '25000'
									// ,'5' => '30000'
									// ,'6' => '35000'
									// ,'7' => '40000'
									// ,'8' => '45000'
									// ,'9' => '50000'
									// ,'A' => '55000'
									// ,'B' => '60000'
									// ,'C' => '65000'
									// ,'D' => '70000'
									// ,'E' => '75000'
									// ,'F' => '80000'
									// ,'G' => '85000'
									// ,'H' => '90000'
									// ,'I' => '95000'
									// ,'J' => '100000'
									// ,'K' => '105000'
									// ,'L' => '110000'
									// ,'M' => '115000'
									// ,'N' => '120000'
									// ,'O' => '125000'
									// ,'P' => '130000'
									// ,'Q' => '135000'
									// ,'R' => '140000'
									// ,'S' => '145000'
									// ,'T' => '150000'
									// ,'');
	self.household_member_cnt:=r.Household_Type_Code;
	// self.household_member_cnt:=case((integer)r.Household_Type_Code
									// ,1 => '3'
									// ,2 => '2'
									// ,3 => '3'
									// ,4 => '2'
									// ,5 => '3'
									// ,6 => '2'
									// ,7 => '3'
									// ,8 => '2'
									// ,9 => '3'
									// ,10 => '2'
									// ,11 => '2'
									// ,12 => '1'
									// ,13 => '2'
									// ,14 => '1'
									// ,15 => '2'
									// ,16 => '1'
									// ,'');
	gender:=map(r.title='MS'=>'F'
				,r.title='MR'=>'M'
				,datalib.gender(trim(datalib.PreferredFirst(r.fname))));
	self.gender:=if(gender not in ['M','F'],'',gender);
	self:=l;
	self:=r;
end;

h_enhanced1:=join(h_enhanced0,m
						,left.did=right.did
						,tr1(left,right)
						,left outer
						,local);

h_enhanced2:=join(h_enhanced1, header.file_ssn_map((unsigned3)ssn5>0)
						,left.ssn[1..5]=right.ssn5
						,transform(fds_test.Consumer_Layouts.Input.H_Enhanced
										,self.SSN_issuing_state:=right.state
										,self.SSN_issuing_date:=if(right.end_date > ut.getdate,'20091231',right.end_date)
										,self:=left)
						,left outer
						,lookup):persist('temp::fds_test::consumer::henhanced4append');

PeopleHeader:=rollup(
				sort(h_enhanced2
								,did
								,lname
								,fname
								,prim_range
								,prim_name
								,sec_range
								,zip
								,local)
				,	left.did=right.did
				and	left.fname=right.fname
				and	left.lname=right.lname
				and	left.prim_range=right.prim_range
				and	left.prim_name=right.prim_name
				and	left.sec_range=right.sec_range
				and	left.zip=right.zip
				,transform(fds_test.Consumer_Layouts.Input.H_Enhanced
						,self.ssn:= If(left.ssn='',right.ssn,left.ssn)
						,self.dob:= If(left.dob=0,right.dob,left.dob)
						,self.phone:= If(left.phone='',right.phone,left.phone)
						,self.dt_first_seen:= ut.Min2(left.dt_first_seen,right.dt_first_seen)
						,self.dt_last_seen:= ut.Max2(left.dt_last_seen,right.dt_last_seen)
						,self:=left
						)):persist('temp::fds_test::consumer::henhanced4append_rolled');
// output(PeopleHeader);
///////////////////////////////////////////

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
// SSN_match := join(
	// PeopleHeader(ssn<>'')
	// ,search_by_SSN
	// ,left.SSN=right.SSN
	// ,transform(
		 // FDS_test.Consumer_Layouts.Response.Append_temp
			// ,self.SearchCriteria			:= right
			// ,self.Appended_data.Record_ID	:= right.Record_ID
			// ,self.Appended_data				:= left
			// ,self.did						:= left.did
	// )
	// ,lookup
// ):persist('temp::fds_test::SSN_match');
SSN_match := dataset('~thor400_92::temp::fds_test::SSN_match',recordof(FDS_test.Consumer_Layouts.Response.Append_temp),flat);

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
// SSN_name_match := join(
	// PeopleHeader(ssn<>'')
	// ,search_by_SSN_name
	// ,	left.SSN=right.SSN
	// and	ut.NameMatch(left.fname,left.mname,left.Lname,right.fname,right.mname,right.lname)<5
	// ,transform(
		 // FDS_test.Consumer_Layouts.Response.Append_temp
			// ,self.SearchCriteria			:= right
			// ,self.Appended_data.Record_ID	:= right.Record_ID
			// ,self.Appended_data				:= left
			// ,self.did						:= left.did
	// )
	// ,lookup
// ):persist('temp::fds_test::SSN_name_match');
SSN_name_match := dataset('~thor400_92::temp::fds_test::SSN_name_match',recordof(FDS_test.Consumer_Layouts.Response.Append_temp),flat);

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
// SSN_nmaddr_match := join(
	// PeopleHeader
	// ,search_by_partSSN_nmaddr
	// ,	header.ssn_value(left.SSN,right.SSN) > 0
	// and	ut.NameMatch(left.fname,left.mname,left.Lname,right.fname,right.mname,right.lname)<5
	// and	left.prim_range=right.prim_range
	// and left.prim_name=right.prim_name
	// and left.sec_range=right.sec_range
	// and left.city_name=right.city
	// and left.st=right.state
	// and left.zip=right.zip_code
	// ,transform(
		 // FDS_test.Consumer_Layouts.Response.Append_temp
			// ,self.SearchCriteria			:= right
			// ,self.Appended_data.Record_ID	:= right.Record_ID
			// ,self.Appended_data				:= left
			// ,self.did						:= left.did
	// )
	// ,lookup
// ):persist('temp::fds_test::SSN_nmaddr_match');
SSN_nmaddr_match := dataset('~thor400_92::temp::fds_test::SSN_nmaddr_match',recordof(FDS_test.Consumer_Layouts.Response.Append_temp),flat);

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
// name_addr_match := join(
	// PeopleHeader
	// ,search_by_name_addr
	// ,	ut.NameMatch(left.fname,left.mname,left.Lname,right.fname,right.mname,right.lname)<5
	// and	left.prim_range=right.prim_range
	// and left.prim_name=right.prim_name
	// and left.sec_range=right.sec_range
	// and left.city_name=right.city
	// and left.st=right.state
	// and left.zip=right.zip_code
	// ,transform(
		 // FDS_test.Consumer_Layouts.Response.Append_temp
			// ,self.SearchCriteria			:= right
			// ,self.Appended_data.Record_ID	:= right.Record_ID
			// ,self.Appended_data				:= left
			// ,self.did						:= left.did
	// )
	// ,lookup
// ):persist('temp::fds_test::name_addr_match');
name_addr_match := dataset('~thor400_92::temp::fds_test::name_addr_match',recordof(FDS_test.Consumer_Layouts.Response.Append_temp),flat);

// ?	Name and city/state and/or ZIP
search_by_ncsz := pSearchCriteria(
								(unsigned5)SSN		= 0
								,name				<> ''
								,address			= ''
								,city				<> ''
								,state				<> ''
								,Phone_Number		= ''
								);
// ncsz_match := join(
	// PeopleHeader
	// ,search_by_ncsz
	// ,	ut.NameMatch(left.fname,left.mname,left.Lname,right.fname,right.mname,right.lname)<5
	// and left.city_name=right.city
	// and left.st=right.state
	// and ut.nneq(left.zip,right.zip_code)
	// ,transform(
		 // FDS_test.Consumer_Layouts.Response.Append_temp
			// ,self.SearchCriteria			:= right
			// ,self.Appended_data.Record_ID	:= right.Record_ID
			// ,self.Appended_data				:= left
			// ,self.did						:= left.did
	// )
	// ,lookup
// ):persist('temp::fds_test::ncsz_match');
ncsz_match := dataset('~thor400_92::temp::fds_test::ncsz_match',recordof(FDS_test.Consumer_Layouts.Response.Append_temp),flat);

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
// ns_match := join(
	// PeopleHeader
	// ,search_by_ns
	// ,	ut.NameMatch(left.fname,left.mname,left.Lname,right.fname,right.mname,right.lname)<5
	// and left.st=right.state
	// ,transform(
		 // FDS_test.Consumer_Layouts.Response.Append_temp
			// ,self.SearchCriteria			:= right
			// ,self.Appended_data.Record_ID	:= right.Record_ID
			// ,self.Appended_data				:= left
			// ,self.did						:= left.did
	// )
	// ,lookup
// ):persist('temp::fds_test::search_by_ns');
ns_match := dataset('~thor400_92::temp::fds_test::search_by_ns',recordof(FDS_test.Consumer_Layouts.Response.Append_temp),flat);

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
// addr_match := join(
	// PeopleHeader
	// ,search_by_addr
	// ,	left.prim_range=right.prim_range
	// and left.prim_name=right.prim_name
	// and left.sec_range=right.sec_range
	// and left.city_name=right.city
	// and left.st=right.state
	// and left.zip=right.zip_code
	// ,transform(
		 // FDS_test.Consumer_Layouts.Response.Append_temp
			// ,self.SearchCriteria			:= right
			// ,self.Appended_data.Record_ID	:= right.Record_ID
			// ,self.Appended_data				:= left
			// ,self.did						:= left.did
	// )
	// ,lookup
// ):persist('temp::fds_test::addr_match');
addr_match := dataset('~thor400_92::temp::fds_test::addr_match',recordof(FDS_test.Consumer_Layouts.Response.Append_temp),flat);

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
// ph_match := join(
	// PeopleHeader
	// ,search_by_ph
	// , left.phone=right.Phone_Number
	// ,transform(
		 // FDS_test.Consumer_Layouts.Response.Append_temp
			// ,self.SearchCriteria			:= right
			// ,self.Appended_data.Record_ID	:= right.Record_ID
			// ,self.Appended_data				:= left
			// ,self.did						:= left.did
	// )
	// ,lookup
// ):persist('temp::fds_test::ph_match');
ph_match := dataset('~thor400_92::temp::fds_test::ph_match',recordof(FDS_test.Consumer_Layouts.Response.Append_temp),flat);

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

dresponse1 := rollup(sort(distribute(dresponse_match,hash((unsigned6)SearchCriteria.Record_ID
															,appended_data.fname
															,appended_data.lname
															,appended_data.prim_range
															,appended_data.prim_name
															,appended_data.sec_range
															,appended_data.st))
				,(unsigned6)SearchCriteria.Record_ID
				,appended_data.fname
				,appended_data.lname
				,appended_data.prim_range
				,appended_data.prim_name
				,appended_data.sec_range
				,appended_data.st
				,local)
					,	left.SearchCriteria.Record_ID	=right.SearchCriteria.Record_ID
					and	left.appended_data.fname		=right.appended_data.fname
					and	left.appended_data.lname		=right.appended_data.lname
					and	left.appended_data.prim_range	=right.appended_data.prim_range
					and	left.appended_data.prim_name	=right.appended_data.prim_name
					and	left.appended_data.sec_range	=right.appended_data.sec_range
					and	left.appended_data.st			=right.appended_data.st
							,transform(recordof(dresponse_match)
								,self.appended_data.SSN			:=if(left.appended_data.SSN='',right.appended_data.SSN,left.appended_data.SSN)
								,self.appended_data.mname		:=if(left.appended_data.mname='',right.appended_data.mname,left.appended_data.mname)
								,self.appended_data.sec_range	:=if(left.appended_data.sec_range='',right.appended_data.sec_range,left.appended_data.sec_range)
								,self.appended_data.unit_desig	:=if(left.appended_data.unit_desig='',right.appended_data.unit_desig,left.appended_data.unit_desig)
								,self.appended_data.city_name	:=if(left.appended_data.city_name='',right.appended_data.city_name,left.appended_data.city_name)
								,self.appended_data.st			:=if(left.appended_data.st='',right.appended_data.st,left.appended_data.st)
								,self.appended_data.zip			:=if(left.appended_data.zip='',right.appended_data.zip,left.appended_data.zip)
								,self.appended_data.Phone		:=if(left.appended_data.Phone='',right.appended_data.Phone,left.appended_data.Phone)
								,self.appended_data.dob			:=if(left.appended_data.dob=0,right.appended_data.dob,left.appended_data.dob)
								,self.SearchCriteria:=left.SearchCriteria
								,self.Appended_data:=left.Appended_data
								,self:=left
							)
		,local):persist('temp::fds_test::dresponse1');

// output(dresponse1);

dresponseNomatch:=project(pSearchCriteria
								,transform(FDS_test.Consumer_Layouts.Response.Append_temp
											,self.SearchCriteria	:= left
											,self.Appended_data		:= []
											,self					:= [] ));

AddrHist0:=dedup(sort(distribute(dresponse1/* + dresponseNomatch*/,hash((unsigned6)SearchCriteria.Record_ID))
							,(unsigned6)SearchCriteria.Record_ID
							,did
							,appended_data.prim_range
							,appended_data.prim_name
							,appended_data.sec_range	
							,appended_data.st
							,-appended_data.dt_last_seen
							,local)
						,(unsigned6)SearchCriteria.Record_ID
						,did
						,appended_data.prim_range
						,appended_data.prim_name
						,appended_data.sec_range
						,appended_data.st
						,local):persist('temp::fds_test::AddrHist0');
// output(AddrHist0);

AddrHist1 := rollup(AddrHist0
						,	left.SearchCriteria.Record_ID=right.SearchCriteria.Record_ID
						and left.did=right.did
							,transform(FDS_test.Consumer_Layouts.Response.append_temp
										,self.count_of_total_previous_addresses_available:=
												left.count_of_total_previous_addresses_available + 1;
										,self:=left)
							,local):persist('temp::fds_test::AddrHist1');
// output(sort(AddrHist1,(integer)SearchCriteria.Record_ID));

// /*
AddrHist2:=join(distribute(pSearchCriteria,hash(record_id)),distribute(AddrHist1,hash(SearchCriteria.Record_ID))
// AddrHist2:=join(pSearchCriteria,AddrHist1
				,left.Record_ID=right.SearchCriteria.Record_ID
				,transform(recordof(AddrHist1)
						,self.SearchCriteria:=left
						,self.Appended_data:=right.Appended_data
						,self:=right)
				,left outer
				,local
				):persist('temp::fds_test::AddrHist2');
// output(sort(AddrHist2,(integer)SearchCriteria.Record_ID));
// output(sort(distribute(AddrHist2,hash((integer)SearchCriteria.Record_ID)),(integer)SearchCriteria.Record_ID,local));
// output(AddrHist2);
// */

dresponse2 := dedup(sort(dresponse1
							,(unsigned6)SearchCriteria.Record_ID
							,-appended_data.dt_last_seen
						),(unsigned6)SearchCriteria.Record_ID,local,keep 5):persist('temp::fds_test::dresponse2');
// output(dresponse2);

dresponse:=join(distribute(pSearchCriteria,hash(record_id)),distribute(dresponse2,hash(SearchCriteria.Record_ID))
				,left.Record_ID=right.SearchCriteria.Record_ID
				,transform(recordof(dresponse2)
						,self.SearchCriteria:=left
						,self.Appended_data:=right.Appended_data
						,self:=right)
				,left outer
				,local):persist('temp::fds_test::dresponse');
// output(dresponse);
// output(sort(dresponse,(integer)SearchCriteria.Record_ID));

/////////////////////////////////
FDS_test.Consumer_Layouts.Response.Append tAppend(dresponse l) :=
transform
	self.SearchCriteria				:= l.SearchCriteria;
	self.Appended_data.first_Name	:= l.Appended_data.fname;
	self.Appended_data.middle_Name	:= l.Appended_data.mname;
	self.Appended_data.last_Name	:= l.Appended_data.lname;
	self.Appended_data.name_suffix	:= if(l.Appended_data.name_suffix[1..2]='UN','',l.Appended_data.name_suffix);
	self.Appended_data.Street_Address		:= trim(Address.Addr1FromComponents(
															 l.Appended_data.prim_range
															,l.Appended_data.predir
															,l.Appended_data.prim_name
															,l.Appended_data.suffix
															,l.Appended_data.postdir
															,'',''),left,right);
	self.Appended_data.Secondary_Address 	:= trim(Address.Addr1FromComponents(
															 l.Appended_data.unit_desig
															,l.Appended_data.sec_range
															,''	,''	,''	,''	,''	),left,right);
	self.Appended_data.City				:= l.Appended_data.city_name;
	self.Appended_data.State			:= l.Appended_data.st;
	self.Appended_data.Zip_Code			:= if(l.Appended_data.zip != '',l.Appended_data.zip,'');
	self.Appended_data.phone			:= if(l.Appended_data.phone != '',l.Appended_data.phone,'');
	self.Appended_data.SSN_issuing_state:= StringLib.StringToUpperCase(l.Appended_data.SSN_issuing_state);
	self.Appended_data.SSN_issuing_date	:= if((unsigned4)l.Appended_data.SSN_issuing_date != 0, intformat(ut.Date_MMDDYYYY_i2((string)l.Appended_data.SSN_issuing_date),8,1),'');
	self.Appended_data.date_of_birth	:= if(l.Appended_data.dob != 0, intformat(ut.Date_MMDDYYYY_i2((string)l.Appended_data.dob),8,1),'');
	self.Appended_data.added_date		:= if(l.Appended_data.dt_first_seen != 0, intformat(ut.Date_MMDDYYYY_i2((string)l.Appended_data.dt_first_seen+'01'),8,1),'');
	self.Appended_data.last_report_date	:= if(l.Appended_data.dt_last_seen != 0, intformat(ut.Date_MMDDYYYY_i2((string)l.Appended_data.dt_last_seen+'01'),8,1),'');
	self.Appended_data.count_of_total_previous_addresses_available
										:=(string)l.count_of_total_previous_addresses_available;
	self.Appended_data:=l.Appended_data;
	self:=l;
end;

Append	:=project(sort(dresponse,(unsigned6)SearchCriteria.Record_ID,-appended_data.dt_last_seen,local)	,tAppend(left)):persist('temp::fds_test::Append');
AddrHist:=project(sort(AddrHist2,(unsigned6)SearchCriteria.Record_ID,-appended_data.dt_last_seen,local)	,tAppend(left)):persist('temp::fds_test::AddrHist');
// output(sort(Append,-(unsigned6)SearchCriteria.Record_ID));
// output(sort(AddrHist,(unsigned6)SearchCriteria.Record_ID));
// output(AddrHist);
///////////////////////////////////////////
layout_append_fill_rates := record
integer countGroup := count(group);
	Title_CountNonBlank 		   	:= sum(group,if(Append.Appended_data.Title				<>'',1,0));
	First_Name_CountNonBlank    	:= sum(group,if(Append.Appended_data.first_Name			<>'',1,0));
	Middle_Name_CountNonBlank   	:= sum(group,if(Append.Appended_data.middle_Name		<>'',1,0));
	Last_Name_CountNonBlank    		:= sum(group,if(Append.Appended_data.last_Name			<>'',1,0));
	Name_suffix_CountNonBlank    	:= sum(group,if(Append.Appended_data.Name_suffix		<>'',1,0));
	Street_Address_CountNonBlank    := sum(group,if(Append.Appended_data.Street_Address		<>'',1,0));
	Secondary_Address_CountNonBlank := sum(group,if(Append.Appended_data.Secondary_Address	<>'',1,0));
	City_CountNonBlank              := sum(group,if(Append.Appended_data.City				<>'',1,0));
	State_CountNonBlank             := sum(group,if(Append.Appended_data.State				<>'',1,0));
	Zip_Code_CountNonBlank          := sum(group,if(Append.Appended_data.Zip_Code			<>'',1,0));
	phone_CountNonBlank             := sum(group,if(Append.Appended_data.phone				<>'',1,0));
	SSN_CountNonBlank         	    := sum(group,if(Append.Appended_data.SSN 				<>'',1,0));
	SSN_issuing_state_CountNonBlank := sum(group,if(Append.Appended_data.SSN_issuing_state	<>'',1,0));
	SSN_issuing_date_CountNonBlank  := sum(group,if(Append.Appended_data.SSN_issuing_date	<>'',1,0));
	date_of_birth_CountNonBlank   	:= sum(group,if(Append.Appended_data.date_of_birth	<>'',1,0));
	added_date_CountNonBlank 	  	:= sum(group,if(Append.Appended_data.added_date	<>'',1,0));
	last_report_date_CountNonBlank  := sum(group,if(Append.Appended_data.last_report_date	<>'',1,0));

	Num_units_CountNonBlank			:= sum(group,if(Append.Appended_data.Num_units	<>'',1,0));
	Length_of_Residence_CountNonBlank  := sum(group,if(Append.Appended_data.Length_of_Residence	<>'',1,0));
	RentOwn_CountNonBlank   		:= sum(group,if(Append.Appended_data.RentOwn	<>'',1,0));
	Estimated_income_CountNonBlank 	:= sum(group,if(Append.Appended_data.Estimated_income	<>'',1,0));
	household_member_cnt_CountNonBlank  := sum(group,if(Append.Appended_data.household_member_cnt	<>'',1,0));
	gender_CountNonBlank			:= sum(group,if(Append.Appended_data.gender	<>'',1,0));
end;

output(table(Append(did>0), layout_append_fill_rates, '',few),named('fill_counts'));

layout_append_fill_rates2 := record
integer countGroup := count(group);
	Title_CountNonBlank 		   	:= sum(group,if(AddrHist.Appended_data.Title				<>'',1,0));
	First_Name_CountNonBlank    	:= sum(group,if(AddrHist.Appended_data.first_Name			<>'',1,0));
	Middle_Name_CountNonBlank   	:= sum(group,if(AddrHist.Appended_data.middle_Name		<>'',1,0));
	Last_Name_CountNonBlank    		:= sum(group,if(AddrHist.Appended_data.last_Name			<>'',1,0));
	Name_suffix_CountNonBlank    	:= sum(group,if(AddrHist.Appended_data.Name_suffix		<>'',1,0));
	Street_Address_CountNonBlank    := sum(group,if(AddrHist.Appended_data.Street_Address		<>'',1,0));
	Secondary_Address_CountNonBlank := sum(group,if(AddrHist.Appended_data.Secondary_Address	<>'',1,0));
	City_CountNonBlank              := sum(group,if(AddrHist.Appended_data.City				<>'',1,0));
	State_CountNonBlank             := sum(group,if(AddrHist.Appended_data.State				<>'',1,0));
	Zip_Code_CountNonBlank          := sum(group,if(AddrHist.Appended_data.Zip_Code			<>'',1,0));
	phone_CountNonBlank             := sum(group,if(AddrHist.Appended_data.phone				<>'',1,0));
	SSN_CountNonBlank         	    := sum(group,if(AddrHist.Appended_data.SSN 				<>'',1,0));
	SSN_issuing_state_CountNonBlank := sum(group,if(AddrHist.Appended_data.SSN_issuing_state	<>'',1,0));
	SSN_issuing_date_CountNonBlank  := sum(group,if(AddrHist.Appended_data.SSN_issuing_date	<>'',1,0));
	date_of_birth_CountNonBlank   	:= sum(group,if(AddrHist.Appended_data.date_of_birth	<>'',1,0));
	added_date_CountNonBlank 	  	:= sum(group,if(AddrHist.Appended_data.added_date	<>'',1,0));
	last_report_date_CountNonBlank  := sum(group,if(AddrHist.Appended_data.last_report_date	<>'',1,0));

	Num_units_CountNonBlank			:= sum(group,if(AddrHist.Appended_data.Num_units	<>'',1,0));
	Length_of_Residence_CountNonBlank  := sum(group,if(AddrHist.Appended_data.Length_of_Residence	<>'',1,0));
	RentOwn_CountNonBlank   		:= sum(group,if(AddrHist.Appended_data.RentOwn	<>'',1,0));
	Estimated_income_CountNonBlank 	:= sum(group,if(AddrHist.Appended_data.Estimated_income	<>'',1,0));
	household_member_cnt_CountNonBlank  := sum(group,if(AddrHist.Appended_data.household_member_cnt	<>'',1,0));
	gender_CountNonBlank			:= sum(group,if(AddrHist.Appended_data.gender	<>'',1,0));
	count_of_total_previous_addresses_available_CountNonBlank
									:=sum(group,if(AddrHist.Appended_data.count_of_total_previous_addresses_available	<>'',1,0));
end;
output(table(AddrHist(did>0), layout_append_fill_rates2, '',few),named('fill_counts2'));

/////////////////////////////
tSearch_by_SSN:=count(search_by_SSN);
tSearch_by_SSN_name:=count(search_by_SSN_name);
tSearch_by_partSSN_nmaddr:=count(search_by_partSSN_nmaddr);
tSearch_by_name_addr:=count(search_by_name_addr);
tSearch_by_ncsz:=count(search_by_ncsz);
tSearch_by_ns:=count(search_by_ns);
tSearch_by_addr:=count(search_by_addr);
tSearch_by_ph:=count(search_by_ph);

tSSN_match:=count(table(SSN_match,{searchcriteria.record_id},searchcriteria.record_id,local,few));
tSSN_name_match:=count(table(SSN_name_match,{searchcriteria.record_id},searchcriteria.record_id,local,few));
tSSN_nmaddr_match:=count(table(SSN_nmaddr_match,{searchcriteria.record_id},searchcriteria.record_id,local,few));
tName_addr_match:=count(table(name_addr_match,{searchcriteria.record_id},searchcriteria.record_id,local,few));
tNcsz_match:=count(table(ncsz_match,{searchcriteria.record_id},searchcriteria.record_id,local,few));
tNs_match:=count(table(ns_match,{searchcriteria.record_id},searchcriteria.record_id,local,few));
tAddr_match:=count(table(addr_match,{searchcriteria.record_id},searchcriteria.record_id,local,few));
tPh_match:=count(table(ph_match,{searchcriteria.record_id},searchcriteria.record_id,local,few));

matchrate1 := tSSN_match / tSearch_by_SSN;
matchrate2 := tSSN_name_match / tSearch_by_SSN_name;
matchrate3 := tSSN_nmaddr_match / tSearch_by_partSSN_nmaddr;
matchrate4 := tName_addr_match / tSearch_by_name_addr;
matchrate5 := tNcsz_match / tSearch_by_ncsz;
matchrate6 := tNs_match / tSearch_by_ns;
matchrate7 := tAddr_match / tSearch_by_addr;
matchrate8 := tPh_match / tSearch_by_ph;

sequential(
	output(sort(project(Append	,FDS_test.Consumer_Layouts.Response.SSN_Append),intformat((integer)SearchCriteria.Record_id,12,1))
		,,'~thor_data400::out::lexisnexis_consumer_SSN_app_12192009_fixed'
		,__compressed__,overwrite)
	,output(sort(project(Append	,FDS_test.Consumer_Layouts.Response.SSN_Append),intformat((integer)SearchCriteria.Record_id,12,1))
		,,'~thor_data400::out::lexisnexis_consumer_SSN_app_12192009'
		,csv(heading(SINGLE),separator('|')),overwrite)

	,output(sort(project(Append	,FDS_test.Consumer_Layouts.Response.CnsDemo_Append),intformat((integer)SearchCriteria.Record_id,12,1))
		,,'~thor_data400::out::lexisnexis_consumer_demo_app_12192009_fixed'
		,__compressed__,overwrite)
	,output(sort(project(Append	,FDS_test.Consumer_Layouts.Response.CnsDemo_Append),intformat((integer)SearchCriteria.Record_id,12,1))
		,,'~thor_data400::out::lexisnexis_consumer_demo_app_12192009'
		,csv(heading(SINGLE),separator('|')),overwrite)

	,output(sort(project(AddrHist	,transform(FDS_test.Consumer_Layouts.Response.AddrHist_Append
												,self.Appended_data.dob:=(string)left.Appended_data.date_of_birth
												,self.SearchCriteria:=left.SearchCriteria
												,self.Appended_data:=left.Appended_data
												,self:=left)),intformat((integer)SearchCriteria.Record_id,12,1))
		,,'~thor_data400::out::lexisnexis_consumer_AddrHist_app_12192009_fixed'
		,__compressed__,overwrite)
	,output(sort(project(AddrHist	,transform(FDS_test.Consumer_Layouts.Response.AddrHist_Append
												,self.Appended_data.dob:=(string)left.Appended_data.date_of_birth
												,self.SearchCriteria:=left.SearchCriteria
												,self.Appended_data:=left.Appended_data
												,self:=left)),intformat((integer)SearchCriteria.Record_id,12,1))
		,,'~thor_data400::out::lexisnexis_consumer_AddrHist_app_12192009'
		,csv(heading(SINGLE),separator('|')),overwrite)

	,output(tSearch_by_SSN									,named('FDS_Search_File_With_SSN'	))
	,output(tSearch_by_SSN - tSSN_match						,named('Consumer_SSN_Not_Matched'	))
	,output(matchrate1										,named('Percentage_Match_Rate_by_SSN'		))
	,output(tSearch_by_SSN_name							,named('FDS_Search_File_With_SSN_and_name'	))
	,output(tSearch_by_SSN_name - tSSN_name_match		,named('Consumer_SSN_and_name_Not_Matched'	))
	,output(matchrate2									,named('Percentage_Match_Rate_by_SSN_and_name'		))
	,output(tSearch_by_partSSN_nmaddr						,named('FDS_Search_File_With_Partial_SSN_and_name_address'	))
	,output(tSearch_by_partSSN_nmaddr - tSSN_nmaddr_match	,named('Consumer_Partial_SSN_and_name_address_Not_Matched'	))
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