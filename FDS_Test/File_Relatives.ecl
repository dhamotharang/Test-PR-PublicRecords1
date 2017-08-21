import paw,address,ut,VersionControl,header,watchdog;
export File_Relatives(

	 dataset(Header.layout_header_v2										) pHeader			= Header.File_Headers
	,dataset(Watchdog.Layout_Best_v2										) pWDBest			= watchdog.File_Best_nonglb
	,dataset(Header.Layout_Relatives										) pRelatives	= Header.File_Relatives

) :=
function

	// convert header to layout
	// join to relatives, get count of number of relatives
	
	shared lay_rel			:= Layout_consumer.Temporary.filerelatives					;
	
	cleandate(unsigned3 pdate) := 
	function
	
			return if(pdate < 185001 or pdate > 215001 ,0,pdate);
	
	end;
	
	// convert WD to extract layout for easy joining
	export dWDBest_convert := project(
		 pWDBest
		,transform(
			 lay_rel
			,self.did												:= left.did;
			 self.did2											:= 0;
			 self.Appended_data.record_id	 	:= (string)counter;
			 self.Appended_data.first_Name	 	:= left.fname;
			 self.Appended_data.middle_Name	 	:= left.mname;
			 self.Appended_data.last_Name			:= left.lname;
			 self.Appended_data.Alias_fName		 	:= '';
			 self.Appended_data.Alias_lName		 	:= '';
			 self.Appended_data.Alias_mName		 	:= '';
			 self.Appended_data.Street_Address	:= trim(Address.Addr1FromComponents(
																					 left.prim_range
																					,left.predir
																					,left.prim_name
																					,left.suffix
																					,left.postdir				
																					,'',''
																				),left,right);
			 self.Appended_data.Secondary_Address 	:= trim(Address.Addr1FromComponents(
																					 left.unit_desig
																					,left.sec_range	
																					,''
																					,''
																					,''
																					,''
																					,''
																				),left,right);
			 self.Appended_data.City							 	:= left.city_name;
			 self.Appended_data.State						 	:= left.st;
			 self.Appended_data.Zip_Code					 	:= left.zip;
			 self.Appended_data.phone						 	:= left.phone;
			 self.Appended_data.date_added					:= '';
			 self.Appended_data.date_last_reported	:= '';

			 self.Appended_data.date_of_birth		:= if((unsigned8)left.dob != 0, intformat(ut.Date_MMDDYYYY_i2((string)left.dob),8,1),'');
			 self.Appended_data.deceased_indicator		:= if((unsigned8)left.dod != 0, true, false);

			 self.Appended_data.count_of_all_relatives_available						 	:= ''; //join to relatives for this
				self.Appended_data.rel_first_Name				 := '';
				self.Appended_data.rel_middle_Name				 := '';
				self.Appended_data.rel_last_Name					 := '';
				self.Appended_data.rel_Street_Address		 := '';
				self.Appended_data.rel_Secondary_Address	 := '';
				self.Appended_data.rel_City							 := '';
				self.Appended_data.rel_State							 := '';
				self.Appended_data.rel_Zip_Code					 := '';
				self.Appended_data.rel_phone							 := '';

			 self.clean_address.prim_range		:= left.prim_range		;
			 self.clean_address.predir				:= left.predir				;
			 self.clean_address.prim_name		:= left.prim_name		;
			 self.clean_address.addr_suffix	:= left.suffix	;
			 self.clean_address.postdir			:= left.postdir			;
			 self.clean_address.unit_desig		:= left.unit_desig		;
			 self.clean_address.sec_range		:= left.sec_range		;
			 self.clean_address.v_city_name	:= left.city_name					;
			 self.clean_address.st						:= left.st				;
			 self.clean_address.zip					:= left.zip;
			 self.clean_address							:= [];
			 self.clean_name.title				:= left.title		;
			 self.clean_name.fname				:= left.fname;		;
			 self.clean_name.mname				:= left.mname;		;
			 self.clean_name.lname				:= left.lname;		;
			 self.clean_name.name_suffix	:= left.name_suffix		;
			 self.clean_name.name_score		:= ''		;
			 self.clean_phone							:= (unsigned8)left.phone		;
			 self.clean_ssn								:= (unsigned8)left.ssn		;
			 self.count_relatives								:= 0		;
		
		)
	)   : persist('~thor_data400::persist::FDS_Test::File_Relatives.dWDBest_convert');
	
	// get aliases per did
	daliasprep := project(pHeader	,transform({unsigned6 did,string lname,string fname,string mname}
			,self.did		:= left.did		;
			 self.lname := left.lname	;
			 self.fname := left.fname	;
			 self.mname := left.mname	;
		)
	);
	
	daliases := join(
		 distribute(dWDBest_convert	,did)
		,distribute(daliasprep			,did)
		,		left.did		= right.did
		and left.clean_name.lname	= right.lname
		and left.clean_name.fname	= right.fname
		,transform(
			recordof(daliasprep)
			,self	:= right;
		)
		,local
		,right only
	);
	
	daliases_dedup := dedup(daliases,did,all)  : persist('~thor_data400::persist::FDS_Test::File_Relatives.daliases_dedup');
	
	// join to header to get date_added, date_last_reported
	dheaderlatest := table(pHeader, {
		 did
		,unsigned3 dt_vendor_last_reported	:= max(group, cleandate(dt_vendor_last_reported))
		,unsigned3 dt_vendor_first_reported := min(group, if(cleandate(dt_vendor_first_reported) != 0,cleandate(dt_vendor_first_reported),999999))
		}
		,did
	) : persist('~thor_data400::persist::FDS_Test::File_Relatives.dheaderlatest');
	
	djoin2headers := join(
		 distribute(dWDBest_convert	,did)
		,distribute(dheaderlatest		,did)
		,left.did = right.did
		,transform(
			 lay_rel
			,self.Appended_data.date_added					:= if((unsigned8)right.dt_vendor_first_reported != 0 and right.dt_vendor_first_reported != 999999, intformat(ut.Date_MMDDYYYY_i2((string)right.dt_vendor_first_reported + '00'),8,1),'');
			 self.Appended_data.date_last_reported	:= if((unsigned8)right.dt_vendor_last_reported != 0, intformat(ut.Date_MMDDYYYY_i2((string)right.dt_vendor_last_reported+ '00'),8,1),'');
			 self := left;
		)
		,local
	);

	djoin2aliases := join(
		 distribute(djoin2headers	,did)
		,distribute(daliases_dedup,did)
		,left.did = right.did
		,transform(
			 lay_rel
			,self.Appended_data.Alias_fName		:= trim(right.fname);
			 self.Appended_data.Alias_lName		:= trim(right.lname);
			 self.Appended_data.Alias_mName		:= trim(right.mname);
			 self := left;
		)
		,local
		,left outer
	);

	//next, aggregate relatives file to get relatives, associates counts
	drelativesdouble := pRelatives 
		+ project(pRelatives, transform(Header.Layout_Relatives
			,self.person1 := left.person2;
			 self.person2 := left.person1;
			 self 				:= left;
		))(same_lname = true);
		
	daggregaterelatives := table(drelativesdouble, 
		{	 unsigned6 did							:= (unsigned6)person1
			,unsigned8 count_relatives	:= sum(group,if(same_lname=true	, 1, 0))
		}
		,person1
	) : persist('~thor_data400::persist::FDS_Test::File_Relatives.daggregaterelatives');
	
	//next, join to relatives to get count relatives
	djoin2relatives := join(
		 distribute(djoin2aliases				,did)
		,distribute(daggregaterelatives	,did)
		,left.did = right.did
		,transform(
			lay_rel
			,self.count_relatives																	:= right.count_relatives		;
			 self.Appended_data.count_of_all_relatives_available	:= (string)right.count_relatives		;
			 self 													:= left;
		)
		,local
		,left outer
	) : persist('~thor_data400::persist::FDS_Test::File_Relatives');

	/*
		so, take relatives file, join to watchdog best on person2 did to grab that relatives' info(name,addr,phone)
		then, join that file to djoin2relatives and populate the relative info fields
	*/

	// get info for relative dids
	dgetrelativesinfo := join(
		 distribute(djoin2relatives		,did		)
		,distribute(drelativesdouble	,person2)
		,left.did = right.person2
		,transform(
			 Layout_consumer.Temporary.relatives_info_temp
			,self.did1									 := right.person1					;
			 self.did2									 := right.person2					;
			 self.rel_first_Name				 := left.Appended_data.first_Name				;
			 self.rel_middle_Name				 := left.Appended_data.middle_Name			;
			 self.rel_last_Name					 := left.Appended_data.last_Name				;
			 self.rel_Street_Address		 := left.Appended_data.Street_Address		;
			 self.rel_Secondary_Address	 := left.Appended_data.Secondary_Address;
			 self.rel_City							 := left.Appended_data.City							;
			 self.rel_State							 := left.Appended_data.State						;
			 self.rel_Zip_Code					 := left.Appended_data.Zip_Code					;
			 self.rel_phone							 := left.Appended_data.phone						;
		
		)
		,local
		,keep(5)
	);
	
	dgetbackrelativesinfo := join(
		 distribute(djoin2relatives		,did	)
		,distribute(dgetrelativesinfo	,did1	)
		,left.did = right.did1
		,transform(
			 lay_rel
			,self.did 									 := right.did1					;
			 self.did2									 := right.did2					;
			 self.Appended_data				 	 := right			;	//populate the relative fields
			 self.Appended_data				 	 := left			;	//populate rest of appended fields
			 self												 := left;
		)
		,local
	);

	return dgetbackrelativesinfo(Appended_data.last_Name != '');

end;

