import paw,address,ut,VersionControl,header,watchdog;
export File_Associates(

	 dataset(Header.layout_header_v2										) pHeader			= Header.File_Headers
	,dataset(Watchdog.Layout_Best_v2										) pWDBest			= watchdog.File_Best_nonglb
	,dataset(Header.Layout_Relatives										) pRelatives	= Header.File_Relatives

) :=
function

	// convert header to layout
	// join to relatives, get count of number of relatives
	
	shared lay_associates			:= Layout_consumer.Temporary.fileassociates					;
	
	cleandate(unsigned3 pdate) := 
	function
	
			return if(pdate < 185001 or pdate > 215001 ,0,pdate);
	
	end;
	
	// convert WD to extract layout for easy joining
	export dWDBest_convert := project(
		 pWDBest
		,transform(
			 lay_associates
			,self.did												:= left.did;
			 self.did2											:= 0;
			 self.Appended_data.record_id	 	:= (string)counter;
			 self.Appended_data.first_Name	 	:= left.fname;
			 self.Appended_data.middle_Name	 	:= left.mname;
			 self.Appended_data.last_Name			:= left.lname;
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

			 self.Appended_data.count_of_all_associates_available						 	:= ''; //join to relatives for this

				self.Appended_data.assoc_first_Name				 := '';
				self.Appended_data.assoc_middle_Name				 := '';
				self.Appended_data.assoc_last_Name					 := '';
				self.Appended_data.assoc_Street_Address		 := '';
				self.Appended_data.assoc_Secondary_Address	 := '';
				self.Appended_data.assoc_City							 := '';
				self.Appended_data.assoc_State							 := '';
				self.Appended_data.assoc_Zip_Code					 := '';
				self.Appended_data.assoc_phone							 := '';
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
			 self.count_associates							:= 0		;
		
		)
	)   : persist('~thor_data400::persist::FDS_Test::File_Associates.dWDBest_convert');


	// join to header to get date_added, date_last_reported
	dheaderlatest := table(pHeader, {
		 did
		,unsigned3 dt_vendor_last_reported	:= max(group, cleandate(dt_vendor_last_reported))
		,unsigned3 dt_vendor_first_reported := min(group, if(cleandate(dt_vendor_first_reported) != 0,cleandate(dt_vendor_first_reported),999999))
		}
		,did
	) : persist('~thor_data400::persist::FDS_Test::File_Associates.dheaderlatest');
	
	djoin2headers := join(
		 distribute(dWDBest_convert	,did)
		,distribute(dheaderlatest		,did)
		,left.did = right.did
		,transform(
			 lay_associates
			,self.Appended_data.date_added					:= if((unsigned8)right.dt_vendor_first_reported != 0 and right.dt_vendor_first_reported != 999999, intformat(ut.Date_MMDDYYYY_i2((string)right.dt_vendor_first_reported + '00'),8,1),'');
			 self.Appended_data.date_last_reported	:= if((unsigned8)right.dt_vendor_last_reported != 0, intformat(ut.Date_MMDDYYYY_i2((string)right.dt_vendor_last_reported+ '00'),8,1),'');
			 self := left;
		)
		,local
	);

	//next, aggregate relatives file to get relatives, associates counts
	drelativesdouble := pRelatives 
		+ project(pRelatives, transform(Header.Layout_Relatives
			,self.person1 := left.person2;
			 self.person2 := left.person1;
			 self 				:= left;
		))(same_lname = false);
		
	daggregaterelatives := table(drelativesdouble, 
		{	 unsigned6 did							:= (unsigned6)person1
			,unsigned8 count_associates	:= sum(group,if(same_lname=false, 1, 0))
		}
		,person1
	) : persist('~thor_data400::persist::FDS_Test::File_Associates.daggregaterelatives');
	
	//next, join to relatives to get count relatives, associates
	djoin2relatives := join(
		 distribute(djoin2headers				,did)
		,distribute(daggregaterelatives	,did)
		,left.did = right.did
		,transform(
			lay_associates
			,self.count_associates							:= right.count_associates		;
			 self.Appended_data.count_of_all_associates_available				:= (string)right.count_associates		;
			 self 													:= left;
		)
		,local
		,left outer
	) : persist('~thor_data400::persist::FDS_Test::File_Associates');

	// get info for relative dids
	dgetrelativesinfo := join(
		 distribute(djoin2relatives		,did		)
		,distribute(drelativesdouble	,person2)
		,left.did = right.person2
		,transform(
			 Layout_consumer.Temporary.associates_info_temp
			,self.did1									 := right.person1					;
			 self.did2									 := right.person2					;
			 self.assoc_first_Name				 := left.Appended_data.first_Name				;
			 self.assoc_middle_Name				 := left.Appended_data.middle_Name			;
			 self.assoc_last_Name					 := left.Appended_data.last_Name				;
			 self.assoc_Street_Address		 := left.Appended_data.Street_Address		;
			 self.assoc_Secondary_Address	 := left.Appended_data.Secondary_Address;
			 self.assoc_City							 := left.Appended_data.City							;
			 self.assoc_State							 := left.Appended_data.State						;
			 self.assoc_Zip_Code					 := left.Appended_data.Zip_Code					;
			 self.assoc_phone							 := left.Appended_data.phone						;
		
		)
		,local
		,keep(5)
	);
	
	dgetbackrelativesinfo := join(
		 distribute(djoin2relatives		,did	)
		,distribute(dgetrelativesinfo	,did1	)
		,left.did = right.did1
		,transform(
			 lay_associates
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