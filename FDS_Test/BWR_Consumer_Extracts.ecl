set of string z := fds_test.ZipcodeSet;
TULT:=dataset('~thor400_84::persist::transunion_did',header.Layout_Header,flat);
he:=distribute((header.File_Headers + TULT)(zip in z,header.Blocked_data()),hash(did));
w:=distribute(Watchdog.File_Best,hash(did));
m:=distribute(Marketing_Best.file_equifax_base(did>0),hash(did));

fds_test.Consumer_Layouts.Input.H_Enhanced tr0(he l, w r) := transform
	self.title:=if(l.title<>r.title and r.title<>'',r.title,l.title);
	fname:=if(l.fname<>r.fname and r.fname<>'',r.fname,l.fname);
	mname:=if(l.mname<>r.mname and r.mname<>'',r.mname,l.mname);
	lname:=if(l.lname<>r.lname and r.lname<>'',r.lname,l.lname);
	name_suffix:=if(l.name_suffix<>r.name_suffix and r.name_suffix<>'',r.name_suffix,l.name_suffix);
	self.fname:=StringLib.StringFilterOut(fname,'`~!@#$%^&*()_-+={[}]|\\:;"\'<,>.?/0123456789');
	self.mname:=StringLib.StringFilterOut(mname,'`~!@#$%^&*()_-+={[}]|\\:;"\'<,>.?/0123456789');
	self.lname:=StringLib.StringFilterOut(lname,'`~!@#$%^&*()_+={[}]|\\:;"\'<,>.?/0123456789'); // leave dashes alone
	self.name_suffix:=StringLib.StringFilterOut(name_suffix,'`~!@#$%^&*()_-+={[}]|\\:;"\'<,>.?/');
	self.phone:=if(l.phone<>r.phone and r.phone<>'',r.phone,l.phone);
	self.ssn:=if(l.ssn<>r.ssn and r.ssn<>'',r.ssn,l.ssn);
	self.dob:=if(l.dob<>r.dob and r.dob>0,r.dob,l.dob);
	self:=l;
	self:=r;
	self:=[];
end;

h_enhanced0 :=join(he,w
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

h:=join(h_enhanced1, header.file_ssn_map((unsigned3)ssn5>0)
						,left.ssn[1..5]=right.ssn5
						,transform({h_enhanced1}
										,self.SSN_issuing_state:=right.state
										,self.SSN_issuing_date:=if(right.end_date > ut.getdate,'20091231',right.end_date)
										,self:=left)
						,left outer
						,lookup):persist('temp::fds_test::consumer::henhanced4extract');

output(h);
//////////////////////////////////////////
hddpd1:=dedup(sort(h,did,prim_range,prim_name,sec_range,zip,local),did,prim_range,prim_name,sec_range,zip,local);
t1:=table(hddpd1,{Zip_Code:=zip,count_of_total_previous_addresses_available:=count(group)},zip,few);
tt:=project(t1,transform({t1.zip_code,integer Record_id,t1.count_of_total_previous_addresses_available},self.record_id:=counter,self:=left));
layout_stat1 := record
integer countGroup := count(group);
	Zip_Code_CountNonBlank          := sum(group,if(tt.Zip_Code			<>'',1,0));
	AddrHistCount_CountNonBlank     := sum(group,if(tt.count_of_total_previous_addresses_available	>0,1,0));
end;
output(table(tt, layout_stat1,'',few),named('AddressHist_Extract_fill_rate'));
output(tt,,'~thor_data400::out::lexisnexis_consumer_address_history_ext_12192009_fixed',__compressed__,overwrite);
output(tt,,'~thor_data400::out::lexisnexis_consumer_address_history_ext_12192009',csv(heading(SINGLE),separator('|')),overwrite);
////////////////////////////////////////////////////
hddpd2:=dedup(sort(h,did,-dt_last_seen,local),did,local);
fds_test.Consumer_Layouts.Response.Consumer_Extract tConvert1Response(hddpd2 l,unsigned8 cnt) :=
transform
	self.Record_ID		 	:= (string)cnt;
	self.title			 	:= l.title;
	self.first_Name		 	:= l.fname;
	self.middle_Name	 	:= l.mname;
	self.last_Name		 	:= l.lname;
	self.name_suffix	 	:= if(l.name_suffix[1..2]='UN','',l.name_suffix);
	self.Street_Address		:= trim(Address.Addr1FromComponents(
															 l.prim_range
															,l.predir
															,l.prim_name
															,l.suffix
															,l.postdir
															,'',''
														),left,right);
	self.Secondary_Address 	:= trim(Address.Addr1FromComponents(
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
	self.SSN 				:= l.SSN;
	self.SSN_issuing_state	:= StringLib.StringToUpperCase(l.SSN_issuing_state);
	self.SSN_issuing_date	:= if((unsigned4)l.SSN_issuing_date != 0, intformat(ut.Date_MMDDYYYY_i2((string)l.SSN_issuing_date),8,1),'');
	self.date_of_birth		:= if(l.dob != 0, intformat(ut.Date_MMDDYYYY_i2((string)l.dob),8,1),'');
	self.added_date			:= if(l.dt_first_seen != 0, intformat(ut.Date_MMDDYYYY_i2((string)l.dt_first_seen+'01'),8,1),'');
	self.last_report_date	:= if(l.dt_last_seen != 0, intformat(ut.Date_MMDDYYYY_i2((string)l.dt_last_seen+'01'),8,1),'');
end;
d1:=project(hddpd2(ssn<>''),tConvert1Response(left,counter));
layout_stat2 := record
integer countGroup := count(group);
		Title_CountNonBlank 		   	:= sum(group,if(d1.Title				<>'',1,0));
		First_Name_CountNonBlank    	:= sum(group,if(d1.first_Name			<>'',1,0));
		Middle_Name_CountNonBlank   	:= sum(group,if(d1.middle_Name		<>'',1,0));
		Last_Name_CountNonBlank    		:= sum(group,if(d1.last_Name			<>'',1,0));
		Name_suffix_CountNonBlank    	:= sum(group,if(d1.Name_suffix		<>'',1,0));
		Street_Address_CountNonBlank    := sum(group,if(d1.Street_Address		<>'',1,0));
		Secondary_Address_CountNonBlank := sum(group,if(d1.Secondary_Address	<>'',1,0));
		City_CountNonBlank              := sum(group,if(d1.City				<>'',1,0));
		State_CountNonBlank             := sum(group,if(d1.State				<>'',1,0));
		Zip_Code_CountNonBlank          := sum(group,if(d1.Zip_Code			<>'',1,0));
		phone_CountNonBlank             := sum(group,if(d1.phone				<>'',1,0));
		SSN_CountNonBlank         	    := sum(group,if(d1.SSN 				<>'',1,0));
		SSN_issuing_state_CountNonBlank := sum(group,if(d1.SSN_issuing_state	<>'',1,0));
		SSN_issuing_date_CountNonBlank  := sum(group,if(d1.SSN_issuing_date	<>'',1,0));
		date_of_birth_CountNonBlank   	:= sum(group,if(d1.date_of_birth	<>'',1,0));
		added_date_CountNonBlank 	  	:= sum(group,if(d1.added_date	<>'',1,0));
		last_report_date_CountNonBlank  := sum(group,if(d1.last_report_date	<>'',1,0));
end;
output(table(d1, layout_stat2,'',few),named('SSN_Extract_fill_rate'));
output(d1,,'~thor_data400::out::lexisnexis_consumer_ssn_ext_12192009_fixed',__compressed__,overwrite);
output(d1,,'~thor_data400::out::lexisnexis_consumer_ssn_ext_12192009',csv(heading(SINGLE),separator('|')),overwrite);
//////////////////////////////
fds_test.Consumer_Layouts.Response.CnsDemo_Extract tConvert2Response(hddpd2 l,unsigned8 cnt) :=
transform
	self.Record_ID		 	:= (string)cnt;
	self.title			 	:= l.title;
	self.first_Name		 	:= l.fname;
	self.middle_Name	 	:= l.mname;
	self.last_Name		 	:= l.lname;
	self.name_suffix	 	:= if(l.name_suffix[1..2]='UN','',l.name_suffix);
	self.Street_Address		:= trim(Address.Addr1FromComponents(
															 l.prim_range
															,l.predir
															,l.prim_name
															,l.suffix
															,l.postdir
															,'',''
														),left,right);
	self.Secondary_Address 	:= trim(Address.Addr1FromComponents(
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
	self.date_of_birth		:= if(l.dob != 0, intformat(ut.Date_MMDDYYYY_i2((string)l.dob),8,1),'');
	self.Num_units					:=l.Num_units;
	self.Length_of_Residence		:=l.Length_of_Residence;
	self.RentOwn					:=l.RentOwn;
	self.Estimated_income			:=l.Estimated_income;
	self.household_member_cnt		:=l.household_member_cnt;
	self.gender						:=l.gender;
	self.last_report_date	:= if(l.dt_last_seen != 0, intformat(ut.Date_MMDDYYYY_i2((string)l.dt_last_seen+'01'),8,1),'');
	self.ssn						:=l.ssn;
end;
d2:=project(hddpd2(RentOwn<>'')	,tConvert2Response(left,counter));
layout_stat3 := record
integer countGroup := count(group);
		Title_CountNonBlank 		   	:= sum(group,if(d2.Title				<>'',1,0));
		First_Name_CountNonBlank    	:= sum(group,if(d2.first_Name			<>'',1,0));
		Middle_Name_CountNonBlank   	:= sum(group,if(d2.middle_Name		<>'',1,0));
		Last_Name_CountNonBlank    		:= sum(group,if(d2.last_Name			<>'',1,0));
		Name_suffix_CountNonBlank    	:= sum(group,if(d2.Name_suffix		<>'',1,0));
		Street_Address_CountNonBlank    := sum(group,if(d2.Street_Address		<>'',1,0));
		Secondary_Address_CountNonBlank := sum(group,if(d2.Secondary_Address	<>'',1,0));
		City_CountNonBlank              := sum(group,if(d2.City				<>'',1,0));
		State_CountNonBlank             := sum(group,if(d2.State				<>'',1,0));
		Zip_Code_CountNonBlank          := sum(group,if(d2.Zip_Code			<>'',1,0));
		phone_CountNonBlank             := sum(group,if(d2.phone				<>'',1,0));
		Num_units_CountNonBlank			:= sum(group,if(d2.Num_units	<>'',1,0));
		Length_of_Residence_CountNonBlank  := sum(group,if(d2.Length_of_Residence	<>'',1,0));
		RentOwn_CountNonBlank   		:= sum(group,if(d2.RentOwn	<>'',1,0));
		Estimated_income_CountNonBlank 	:= sum(group,if(d2.Estimated_income	<>'',1,0));
		household_member_cnt_CountNonBlank  := sum(group,if(d2.household_member_cnt	<>'',1,0));
		date_of_birth_CountNonBlank   	:= sum(group,if(d2.date_of_birth	<>'',1,0));
		gender_CountNonBlank			:= sum(group,if(d2.gender	<>'',1,0));
		SSN_CountNonBlank         	    := sum(group,if(d2.SSN 				<>'',1,0));
		last_report_date_CountNonBlank  := sum(group,if(d2.last_report_date	<>'',1,0));
end;
output(table(d2, layout_stat3,'',few),named('CnsDemo_Extract_fill_rate'));
output(d2,,'~thor_data400::out::lexisnexis_consumer_demo_ext_12192009_fixed',__compressed__,overwrite);
output(d2,,'~thor_data400::out::lexisnexis_consumer_demo_ext_12192009',csv(heading(SINGLE),separator('|')),overwrite);





