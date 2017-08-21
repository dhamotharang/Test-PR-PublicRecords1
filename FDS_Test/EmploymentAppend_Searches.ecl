import paw,address,ut,VersionControl;
export EmploymentAppend_Searches(

	 dataset(Layout_Consumer.Temporary.StandardizeInput	) pDataset	= FDS_Test.File_Consumer_Clean
	,dataset(paw.Layout.Employment_out									) pPaw			= paw.File_Base
	,string																								pversion

) :=
module

	shared csearch := Consumer_Searches(pDataset);

	export dssn_search												:= csearch.ssn_search											;
	export dssn_name_search 									:= csearch.ssn_name_search 								;
	export dPartialssn_name_search 						:= csearch.partialssn_name_search 				;
	export dName_Address_search 							:= csearch.Name_Address_search 						;
	export dName_Zip_search 									:= csearch.Name_Zip_search 								;
	export dName_State_search 								:= csearch.Name_State_search 							;
	export dAddress_Only_search 							:= csearch.Address_Only_search 						;
	export dPhone_only_search 								:= csearch.Phone_only_search 							;
	export dhas_did			 											:= csearch.has_did			 									;
	export dother_search 											:= csearch.other_search 									;
	
	shared lay_emp_out			:= Layout_consumer.Response.Employment_Append				;
	shared lay_emp_out_temp	:= Layout_consumer.Temporary.Employment_Append_Temp	;
	shared lay_paw_temp			:= Layout_consumer.Temporary.PAW_Temp								;
	
	//sets to filter paw down quick
	shared setsearchdids			:= set(dhas_did												, 						did											);
	shared setsearchssns			:= set(dssn_search + dssn_name_search	+ dPartialssn_name_search, (unsigned8)	Extract.ssn							);
	shared setsearchzips			:= set(dName_Zip_search								, (unsigned8)	Extract.zip_code				);
	shared setsearchstates		:= set(dName_State_search							, 						stringlib.stringtouppercase(trim(Extract.state,left,right))						);
	shared setsearchaddress		:= set(dAddress_Only_search						, 						clean_address.prim_name	);
	shared setsearchphone 		:= set(dPhone_only_search							, (unsigned8)	clean_phone							);
	 
	// convert paw to extract layout for easy joining
	export dpaw_convert := project(
		pPaw
		,transform(
			 lay_paw_temp
			,self.did												:= left.did;
			 self.Appended_data.first_Name	 	:= left.fname;
			 self.Appended_data.middle_Name	 	:= left.mname;
			 self.Appended_data.last_Name			:= left.lname;
			 self.Appended_data.Company_Name		 	:= left.company_name;
			 self.Appended_data.tax_ID 					 	:= left.company_fein;
			 self.Appended_data.title	 						:= left.company_title;
			 self.Appended_data.Street_Address		 	:= trim(Address.Addr1FromComponents(
																					 left.prim_range
																					,left.predir
																					,left.prim_name
																					,left.addr_suffix
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
			 self.Appended_data.City							 	:= left.city;
			 self.Appended_data.State						 	:= left.state;
			 self.Appended_data.Zip_Code					 	:= left.zip;
			 self.Appended_data.phone						 	:= left.phone;
			 self.Appended_data.email						 	:= left.email_address;
			 self.Appended_data.ssn						 	:= left.ssn;
			 
			 self.Appended_data.date_last_reported		:= if((unsigned8)left.dt_last_seen != 0, intformat(ut.Date_MMDDYYYY_i2((string)left.dt_last_seen),8,1),'');
			 
			 self.Appended_data.date_added		:= if((unsigned8)left.dt_first_seen != 0, intformat(ut.Date_MMDDYYYY_i2((string)left.dt_first_seen),8,1),'');
			 self.Appended_data.confidence_level		:= if((unsigned)left.score>6, true,false);;
			 self.clean_address.prim_range		:= left.prim_range		;
			 self.clean_address.predir				:= left.predir				;
			 self.clean_address.prim_name		:= left.prim_name		;
			 self.clean_address.addr_suffix	:= left.addr_suffix	;
			 self.clean_address.postdir			:= left.postdir			;
			 self.clean_address.unit_desig		:= left.unit_desig		;
			 self.clean_address.sec_range		:= left.sec_range		;
			 self.clean_address.v_city_name	:= left.city					;
			 self.clean_address.st						:= left.state				;
			 self.clean_address.zip					:= left.zip;
			 self.clean_address							:= [];
			 self.clean_name.title				:= left.title		;
			 self.clean_name.fname				:= left.fname;		;
			 self.clean_name.mname				:= left.mname;		;
			 self.clean_name.lname				:= left.lname;		;
			 self.clean_name.name_suffix	:= left.name_suffix		;
			 self.clean_name.name_score	:= ''		;
			 self.clean_phone		:= (unsigned8)left.phone		;
			 self.clean_ssn			:= (unsigned8)left.ssn		;
			 self.date_last_reported := (unsigned8)left.dt_last_seen;
		
		)
	);
	
	export dpaw_convert_with_did					:= dpaw_convert(did != 0,did in setsearchdids);
	export dpaw_convert_without_did				:= dpaw_convert(did = 0);
	export dpaw_convert_with_ssn					:= dpaw_convert((unsigned8)clean_ssn != 0,(unsigned8)clean_ssn in setsearchssns);
	export dpaw_convert_with_name_zip			:= dpaw_convert(clean_name.lname != '',(unsigned8)clean_address.zip != 0,(unsigned8)clean_address.zip in setsearchzips);
	export dpaw_convert_with_name_state		:= dpaw_convert(clean_name.lname != '',clean_address.st != '',clean_address.st in setsearchstates);
	export dpaw_convert_with_address_only	:= dpaw_convert(clean_address.prim_name != '',clean_address.v_city_name != '',clean_address.st != '', clean_address.zip != '',clean_address.prim_name in setsearchaddress);
	export dpaw_convert_with_phone_only		:= dpaw_convert(clean_phone != 0,(unsigned8)clean_phone in setsearchphone);
	
	////////////////////////////////////////////////////////////////////////////////
	// -- SSN search
	////////////////////////////////////////////////////////////////////////////////
	export fssn_search :=
	function
	
		lssn_search := dssn_search;
		
		dwith_did			:= lssn_search(did != 0);
		
		dwithout_did	:= project(lssn_search(did  = 0)
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria := left.Extract;
				 self.Appended_data := [];
				 self.clean_name := left.clean_name;
				 self.clean_address									:= left.clean_address;
				 self.DID														:= left.DID					;
				 self.clean_phone										:= left.clean_phone	;
				 self.clean_ssn											:= left.clean_ssn		;
				 self.didmatch											:= false;
				 self.date_last_reported						:= 0;

			)
		);

		//join with did to paw to get matches in out layout
		djoinOnDid := join(
			 distribute(dpaw_convert_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnDidNomatches := join(
			 distribute(dpaw_convert_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
			,right only
		);
		
		//concat nomatches + those without did
		dconcatnomatches1 := dwithout_did + djoinOnDidNomatches;
		
		//join concat to paw on ssn, get matches
		djoinOnSsn := join(
			 distribute(dpaw_convert_with_ssn	,hash64(Appended_data.ssn))
			,distribute(dconcatnomatches1			,hash64(SearchCriteria.ssn))
			,left.Appended_data.ssn = right.SearchCriteria.ssn
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnSSnNomatches := join(
			 distribute(dpaw_convert_with_ssn	,hash64(Appended_data.ssn))
			,distribute(dconcatnomatches1			,hash64(SearchCriteria.ssn))
			,left.Appended_data.ssn = right.SearchCriteria.ssn
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
			,right only
		);

		//concat first join + last two joins
		dconcatall := djoinOnDid + djoinOnSsn + djoinOnSSnNomatches;

		//dedup, keeping 5 records per orig record
		ddedupall := dedup(sort(dconcatall	,SearchCriteria.Record_id,-date_last_reported),SearchCriteria.Record_id,keep 5);

		//sort in original order
		
		return ddedupall;
		
	end;
	
	////////////////////////////////////////////////////////////////////////////////
	// -- SSN, Name search
	////////////////////////////////////////////////////////////////////////////////
	export fssn_name_search :=
	function
	
		lssn_name_search := dssn_name_search;
		
		dwith_did			:= lssn_name_search(did != 0);
		dwithout_did	:= project(lssn_name_search(did  = 0)
		, transform(lay_emp_out_temp
				,self.SearchCriteria := left.Extract;
				 self.Appended_data := [];
				 self.clean_name := left.clean_name;
				 self.clean_address									:= left.clean_address;
				 self.DID														:= left.DID					;
				 self.clean_phone										:= left.clean_phone	;
				 self.clean_ssn											:= left.clean_ssn		;
				 self.didmatch											:= false;
				 self.date_last_reported						:= 0;
			)
		);

		//join with did to paw to get matches in out layout
		djoinOnDid := join(
			 distribute(dpaw_convert_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnDidNomatches := join(
			 distribute(dpaw_convert_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
			,right only
		);
		
		//concat nomatches + those without did
		dconcatnomatches1 := dwithout_did + djoinOnDidNomatches;
		
		//join concat to paw on ssn,name get matches
		djoinOnSsnName := join(
			 distribute(dpaw_convert_with_ssn	,hash64(Appended_data.ssn))
			,distribute(dconcatnomatches1			,hash64(SearchCriteria.ssn))
			,left.Appended_data.ssn = right.SearchCriteria.ssn
			and left.clean_name.fname = right.clean_name.fname
			and left.clean_name.lname = right.clean_name.lname
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnSSnNameNomatches := join(
			 distribute(dpaw_convert_with_ssn	,hash64(Appended_data.ssn))
			,distribute(dconcatnomatches1			,hash64(SearchCriteria.ssn))
			,left.Appended_data.ssn = right.SearchCriteria.ssn
			and left.clean_name.fname = right.clean_name.fname
			and left.clean_name.lname = right.clean_name.lname
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
			,right only
		);

		//concat first join + last two joins
		dconcatall := djoinOnDid + djoinOnSsnName + djoinOnSSnNameNomatches;

		//dedup, keeping 5 records per orig record
		ddedupall := dedup(sort(dconcatall	,SearchCriteria.Record_id,-date_last_reported),SearchCriteria.Record_id,keep 5);

		//sort in original order
		
		return ddedupall;
		
	end;

	////////////////////////////////////////////////////////////////////////////////
	// -- Partial SSN, Name search
	////////////////////////////////////////////////////////////////////////////////
	export fPartialssn_name_search :=
	function
	
		lssn_name_search := dpartialssn_name_search;
		
		dwith_did			:= lssn_name_search(did != 0);
		dwithout_did	:= project(lssn_name_search(did  = 0)
		, transform(lay_emp_out_temp
				,self.SearchCriteria := left.Extract;
				 self.Appended_data := [];
				 self.clean_name := left.clean_name;
				 self.clean_address									:= left.clean_address;
				 self.DID														:= left.DID					;
				 self.clean_phone										:= left.clean_phone	;
				 self.clean_ssn											:= left.clean_ssn		;
				 self.didmatch											:= false;
				 self.date_last_reported						:= 0;
			)
		);

		//join with did to paw to get matches in out layout
		djoinOnDid := join(
			 distribute(dpaw_convert_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnDidNomatches := join(
			 distribute(dpaw_convert_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
			,right only
		);
		
		//concat nomatches + those without did
		dconcatnomatches1 := dwithout_did + djoinOnDidNomatches;
		
		//join concat to paw on ssn,name get matches
		djoinOnSsnName := join(
			 distribute(dpaw_convert_with_ssn	,hash64(Appended_data.ssn))
			,distribute(dconcatnomatches1			,hash64(SearchCriteria.ssn))
			,left.Appended_data.ssn = right.SearchCriteria.ssn
			and left.clean_name.fname = right.clean_name.fname
			and left.clean_name.lname = right.clean_name.lname
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnSSnNameNomatches := join(
			 distribute(dpaw_convert_with_ssn	,hash64(Appended_data.ssn))
			,distribute(dconcatnomatches1			,hash64(SearchCriteria.ssn))
			,left.Appended_data.ssn = right.SearchCriteria.ssn
			and left.clean_name.fname = right.clean_name.fname
			and left.clean_name.lname = right.clean_name.lname
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
			,right only
		);

		//concat first join + last two joins
		dconcatall := djoinOnDid + djoinOnSsnName + djoinOnSSnNameNomatches;

		//dedup, keeping 5 records per orig record
		ddedupall := dedup(sort(dconcatall	,SearchCriteria.Record_id,-date_last_reported),SearchCriteria.Record_id,keep 5);

		//sort in original order
		
		return ddedupall;
		
	end;

	////////////////////////////////////////////////////////////////////////////////
	// -- Name,Address search
	////////////////////////////////////////////////////////////////////////////////
	export fname_address_search :=
	function
	
		lname_address_search := dname_address_search;
		
		dwith_did			:= lname_address_search(did != 0);
		
		dwithout_did	:= project(lname_address_search(did  = 0)
		, transform(lay_emp_out_temp
				,self.SearchCriteria := left.Extract;
				 self.Appended_data := [];
				 self.clean_name := left.clean_name;
				 self.clean_address									:= left.clean_address;
				 self.DID														:= left.DID					;
				 self.clean_phone										:= left.clean_phone	;
				 self.clean_ssn											:= left.clean_ssn		;
				 self.didmatch											:= false;
				 self.date_last_reported						:= 0;
			)
		);

		//join with did to paw to get matches in out layout
		djoinOnDid := join(
			 distribute(dpaw_convert_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnDidNomatches := join(
			 distribute(dpaw_convert_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
			,right only
		);
		
		//concat nomatches + those without did
		dconcatnomatches1 := djoinOnDid + djoinOnDidNomatches + dwithout_did;
		
		//concat first join + last two joins
		dconcatall := dconcatnomatches1;

		//dedup, keeping 5 records per orig record
		ddedupall := dedup(sort(dconcatall	,SearchCriteria.Record_id,-date_last_reported),SearchCriteria.Record_id,keep 5);

		//sort in original order
		
		return ddedupall;
		
	end;

	////////////////////////////////////////////////////////////////////////////////
	// -- Name,Zip search
	////////////////////////////////////////////////////////////////////////////////
	export fname_zip_search :=
	function
	
		lname_zip_search := dname_zip_search;
		
		dwith_did			:= lname_zip_search(did != 0);
		dwithout_did	:= project(lname_zip_search(did  = 0)
		, transform(lay_emp_out_temp
				,self.SearchCriteria := left.Extract;
				 self.Appended_data := [];
				 self.clean_name := left.clean_name;
				 self.clean_address									:= left.clean_address;
				 self.DID														:= left.DID					;
				 self.clean_phone										:= left.clean_phone	;
				 self.clean_ssn											:= left.clean_ssn		;
				 self.didmatch											:= false;
				 self.date_last_reported						:= 0;
			)
		);

		//join with did to paw to get matches in out layout
		djoinOnDid := join(
			 distribute(dpaw_convert_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnDidNomatches := join(
			 distribute(dpaw_convert_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
			,right only
		);
		
		//concat nomatches + those without did
		dconcatnomatches1 := dwithout_did + djoinOnDidNomatches;
		
		//join concat to paw on name,zip get matches
		djoinOnNameZip := join(
			 distribute(dpaw_convert_with_name_zip	,hash64(clean_address.zip				,clean_name.lname,clean_name.fname))
			,distribute(dconcatnomatches1						,hash64(searchcriteria.zip_code	,clean_name.lname,clean_name.fname))
			,left.clean_address.zip = right.searchcriteria.zip_code
			and left.clean_name.fname = right.clean_name.fname
			and left.clean_name.lname = right.clean_name.lname
//			and left.clean_name.mname = right.clean_name.mname
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnNameZipNomatches := join(
			 distribute(dpaw_convert_with_name_zip	,hash64(clean_address.zip				,clean_name.lname,clean_name.fname))
			,distribute(dconcatnomatches1						,hash64(searchcriteria.zip_code	,clean_name.lname,clean_name.fname))
			,left.clean_address.zip = right.searchcriteria.zip_code
			and left.clean_name.fname = right.clean_name.fname
			and left.clean_name.lname = right.clean_name.lname
//			and left.clean_name.mname = right.clean_name.mname
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
			,right only
		);

		//concat first join + last two joins
		dconcatall := djoinOnDid + djoinOnNameZip + djoinOnNameZipNomatches;

		//dedup, keeping 5 records per orig record
		ddedupall := dedup(sort(dconcatall	,SearchCriteria.Record_id,-date_last_reported),SearchCriteria.Record_id,keep 5);

		//sort in original order
		
		return ddedupall;
		
	end;
	
	////////////////////////////////////////////////////////////////////////////////
	// -- Name,State search
	////////////////////////////////////////////////////////////////////////////////
	export fname_state_search :=
	function
	
		lname_state_search := dname_state_search;
		
		dwith_did			:= lname_state_search(did != 0);
		dwithout_did	:= project(lname_state_search(did  = 0)
		, transform(lay_emp_out_temp
				,self.SearchCriteria := left.Extract;
				 self.Appended_data := [];
				 self.clean_name := left.clean_name;
				 self.clean_address									:= left.clean_address;
				 self.DID														:= left.DID					;
				 self.clean_phone										:= left.clean_phone	;
				 self.clean_ssn											:= left.clean_ssn		;
				 self.didmatch											:= false;
				 self.date_last_reported						:= 0;
			)
		);

		//join with did to paw to get matches in out layout
		djoinOnDid := join(
			 distribute(dpaw_convert_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnDidNomatches := join(
			 distribute(dpaw_convert_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
			,right only
		);
		
		//concat nomatches + those without did
		dconcatnomatches1 := dwithout_did + djoinOnDidNomatches;
		
		//join concat to paw on name,zip get matches
		djoinOnNameState := join(
			 distribute(dpaw_convert_with_name_state	,hash64(clean_address.st,clean_name.lname,clean_name.fname))
			,distribute(dconcatnomatches1						,hash64(stringlib.stringtouppercase(searchcriteria.state),clean_name.lname,clean_name.fname))
			,left.clean_address.st = stringlib.stringtouppercase(right.searchcriteria.state)
			and left.clean_name.fname = right.clean_name.fname
			and left.clean_name.lname = right.clean_name.lname
//			and left.clean_name.mname = right.clean_name.mname
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnNameStateNomatches := join(
			 distribute(dpaw_convert_with_name_state	,hash64(clean_address.st,clean_name.lname,clean_name.fname))
			,distribute(dconcatnomatches1						,hash64(stringlib.stringtouppercase(searchcriteria.state),clean_name.lname,clean_name.fname))
			,left.clean_address.st = stringlib.stringtouppercase(right.searchcriteria.state)
			and left.clean_name.fname = right.clean_name.fname
			and left.clean_name.lname = right.clean_name.lname
//			and left.clean_name.mname = right.clean_name.mname
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
			,right only
		);

		//concat first join + last two joins
		dconcatall := djoinOnDid + djoinOnNameState + djoinOnNameStateNomatches;

		//dedup, keeping 5 records per orig record
		ddedupall := dedup(sort(dconcatall	,SearchCriteria.Record_id,-date_last_reported),SearchCriteria.Record_id,keep 5);

		//sort in original order
		
		return ddedupall;
		
	end;

	////////////////////////////////////////////////////////////////////////////////
	// -- Address Only search
	////////////////////////////////////////////////////////////////////////////////
	export fAddress_Only_search :=
	function
	
		lAddress_Only_search := dAddress_Only_search;
		
		dwith_did			:= lAddress_Only_search(did != 0);
		dwithout_did	:= project(lAddress_Only_search(did  = 0)
		, transform(lay_emp_out_temp
				,self.SearchCriteria := left.Extract;
				 self.Appended_data := [];
				 self.clean_name := left.clean_name;
				 self.clean_address									:= left.clean_address;
				 self.DID														:= left.DID					;
				 self.clean_phone										:= left.clean_phone	;
				 self.clean_ssn											:= left.clean_ssn		;
				 self.didmatch											:= false;
				 self.date_last_reported						:= 0;
			)
		);

		//join with did to paw to get matches in out layout
		djoinOnDid := join(
			 distribute(dpaw_convert_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnDidNomatches := join(
			 distribute(dpaw_convert_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
			,right only
		);
		
		//concat nomatches + those without did
		dconcatnomatches1 := dwithout_did + djoinOnDidNomatches;
		
		//join concat to paw on name,zip get matches
		djoinOnAddress_Only := join(
			 distribute(dpaw_convert_with_Address_Only	,hash64(clean_address.prim_range,clean_address.prim_name,clean_address.st,clean_address.zip))
			,distribute(dconcatnomatches1								,hash64(clean_address.prim_range,clean_address.prim_name,clean_address.st,clean_address.zip))
			,
					left.clean_address.prim_range		= right.clean_address.prim_range
			and left.clean_address.prim_name		= right.clean_address.prim_name
			and left.clean_address.sec_range 		= right.clean_address.sec_range
			and (left.clean_address.v_city_name	= right.clean_address.v_city_name
			or 	 left.clean_address.v_city_name	= right.clean_address.p_city_name
					)
			and left.clean_address.st						= right.clean_address.st
			and left.clean_address.zip					= right.clean_address.zip
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnAddress_OnlyNomatches := join(
			 distribute(dpaw_convert_with_Address_Only	,hash64(clean_address.prim_range,clean_address.prim_name,clean_address.st,clean_address.zip))
			,distribute(dconcatnomatches1								,hash64(clean_address.prim_range,clean_address.prim_name,clean_address.st,clean_address.zip))
			,
					left.clean_address.prim_range		= right.clean_address.prim_range
			and left.clean_address.prim_name		= right.clean_address.prim_name
			and left.clean_address.sec_range 		= right.clean_address.sec_range
			and (left.clean_address.v_city_name	= right.clean_address.v_city_name
			or 	 left.clean_address.v_city_name	= right.clean_address.p_city_name
					)
			and left.clean_address.st						= right.clean_address.st
			and left.clean_address.zip					= right.clean_address.zip
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
			,right only
		);

		//concat first join + last two joins
		dconcatall := djoinOnDid + djoinOnAddress_Only + djoinOnAddress_OnlyNomatches;

		//dedup, keeping 5 records per orig record
		ddedupall := dedup(sort(dconcatall	,SearchCriteria.Record_id,-date_last_reported),SearchCriteria.Record_id,keep 5);

		//sort in original order
		
		return ddedupall;
		
	end;

	////////////////////////////////////////////////////////////////////////////////
	// -- Phone Only search
	////////////////////////////////////////////////////////////////////////////////
	export fPhone_Only_search :=
	function
	
		lPhone_Only_search := dPhone_Only_search;
		
		dwith_did			:= lPhone_Only_search(did != 0);
		dwithout_did	:= project(lPhone_Only_search(did  = 0)
		, transform(lay_emp_out_temp
				,self.SearchCriteria := left.Extract;
				 self.Appended_data := [];
				 self.clean_name := left.clean_name;
				 self.clean_address									:= left.clean_address;
				 self.DID														:= left.DID					;
				 self.clean_phone										:= left.clean_phone	;
				 self.clean_ssn											:= left.clean_ssn		;
				 self.didmatch											:= false;
				 self.date_last_reported						:= 0;
			)
		);

		//join with did to paw to get matches in out layout
		djoinOnDid := join(
			 distribute(dpaw_convert_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnDidNomatches := join(
			 distribute(dpaw_convert_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
			,right only
		);
		
		//concat nomatches + those without did
		dconcatnomatches1 := dwithout_did + djoinOnDidNomatches;
		
		//join concat to paw on phone only get matches
		djoinOnPhone_Only := join(
			 distribute(dpaw_convert_with_Phone_Only	,hash64(clean_phone))
			,distribute(dconcatnomatches1							,hash64(clean_phone))
			,
					left.clean_phone		= right.clean_phone
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnPhone_OnlyNomatches := join(
			 distribute(dpaw_convert_with_Phone_Only	,hash64(clean_phone))
			,distribute(dconcatnomatches1							,hash64(clean_phone))
			,
					left.clean_phone		= right.clean_phone
			,transform(
				 lay_emp_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
				 self.date_last_reported						:= left.date_last_reported;
			)
			,local
			,right only
		);

		//concat first join + last two joins
		dconcatall := djoinOnDid + djoinOnPhone_Only + djoinOnPhone_OnlyNomatches;

		//dedup, keeping 5 records per orig record
		ddedupall := dedup(sort(dconcatall	,SearchCriteria.Record_id,-date_last_reported),SearchCriteria.Record_id,keep 5);

		//sort in original order
		
		return ddedupall;
		
	end;

	export fssn_search_matches 							:= fssn_search					(			didmatch	);
	export fssn_search_nomatches						:= fssn_search					(not	didmatch	);
	export fssn_partialname_search_matches 	:= fpartialssn_name_search 		(			didmatch	);
	export fssn_name_search_matches 	 			:= fssn_name_search 		(			didmatch	);
	export fssn_name_search_nomatches 			:= fssn_name_search 		(not	didmatch	);
	export fName_Address_search_matches 	 	:= fName_Address_search (			didmatch	);
	export fName_Address_search_nomatches 	:= fName_Address_search (not	didmatch	);
	export fName_Zip_search_matches 	 			:= fName_Zip_search 		(			didmatch	);
	export fName_Zip_search_nomatches 			:= fName_Zip_search 		(not	didmatch	);
	export fName_State_search_matches 	 		:= fName_State_search 	(			didmatch	);
	export fName_State_search_nomatches 		:= fName_State_search 	(not	didmatch	);
	export fAddress_Only_search_matches 	 	:= fAddress_Only_search (			didmatch	);
	export fAddress_Only_search_nomatches 	:= fAddress_Only_search (not	didmatch	);
	export fPhone_only_search_matches 	 		:= fPhone_only_search 	(			didmatch	);
	export fPhone_only_search_nomatches 		:= fPhone_only_search 	(not	didmatch	);

	export countfssn_search_matches 						:= count(fssn_search_matches 						);
	export countfssn_search_nomatches						:= count(fssn_search_nomatches					);
	export countfssn_partialname_search_matches	:= count(fssn_partialname_search_matches 	 		);
	export countfssn_name_search_matches 	 			:= count(fssn_name_search_matches 	 		);
	export countfssn_name_search_nomatches 			:= count(fssn_name_search_nomatches 		);
	export countfName_Address_search_matches 	 	:= count(fName_Address_search_matches 	);
	export countfName_Address_search_nomatches 	:= count(fName_Address_search_nomatches );
	export countfName_Zip_search_matches 	 			:= count(fName_Zip_search_matches 	 		);
	export countfName_Zip_search_nomatches 			:= count(fName_Zip_search_nomatches 		);
	export countfName_State_search_matches 	 		:= count(fName_State_search_matches 	 	);
	export countfName_State_search_nomatches 		:= count(fName_State_search_nomatches 	);
	export countfAddress_Only_search_matches 	 	:= count(fAddress_Only_search_matches 	);
	export countfAddress_Only_search_nomatches 	:= count(fAddress_Only_search_nomatches );
	export countfPhone_only_search_matches 	 		:= count(fPhone_only_search_matches 	 	);
	export countfPhone_only_search_nomatches 		:= count(fPhone_only_search_nomatches 	);

	export countfssn_search_matches_unique_record_id							:= count(table(fssn_search_matches 						, {searchcriteria.record_id}, searchcriteria.record_id,few));
	export countfssn_search_nomatches_unique_record_id						:= count(table(fssn_search_nomatches					, {searchcriteria.record_id}, searchcriteria.record_id,few));
	export countfssn_name_search_matches_unique_record_id 	 			:= count(table(fssn_name_search_matches 	 		, {searchcriteria.record_id}, searchcriteria.record_id,few));
	export countfpartialssn_name_search_matches_unique_record_id 	:= count(table(fssn_partialname_search_matches, {searchcriteria.record_id}, searchcriteria.record_id,few));
	export countfssn_name_search_nomatches_unique_record_id 			:= count(table(fssn_name_search_nomatches 		, {searchcriteria.record_id}, searchcriteria.record_id,few));
	export countfName_Address_search_matches_unique_record_id 	 	:= count(table(fName_Address_search_matches 	, {searchcriteria.record_id}, searchcriteria.record_id,few));
	export countfName_Address_search_nomatches_unique_record_id 	:= count(table(fName_Address_search_nomatches , {searchcriteria.record_id}, searchcriteria.record_id,few));
	export countfName_Zip_search_matches_unique_record_id 	 			:= count(table(fName_Zip_search_matches 	 		, {searchcriteria.record_id}, searchcriteria.record_id,few));
	export countfName_Zip_search_nomatches_unique_record_id 			:= count(table(fName_Zip_search_nomatches 		, {searchcriteria.record_id}, searchcriteria.record_id,few));
	export countfName_State_search_matches_unique_record_id 	 		:= count(table(fName_State_search_matches 	 	, {searchcriteria.record_id}, searchcriteria.record_id,few));
	export countfName_State_search_nomatches_unique_record_id 		:= count(table(fName_State_search_nomatches 	, {searchcriteria.record_id}, searchcriteria.record_id,few));
	export countfAddress_Only_search_matches_unique_record_id 	 	:= count(table(fAddress_Only_search_matches 	, {searchcriteria.record_id}, searchcriteria.record_id,few));
	export countfAddress_Only_search_nomatches_unique_record_id 	:= count(table(fAddress_Only_search_nomatches , {searchcriteria.record_id}, searchcriteria.record_id,few));
	export countfPhone_only_search_matches_unique_record_id 	 		:= count(table(fPhone_only_search_matches 	 	, {searchcriteria.record_id}, searchcriteria.record_id,few));
	export countfPhone_only_search_nomatches_unique_record_id 		:= count(table(fPhone_only_search_nomatches 	, {searchcriteria.record_id}, searchcriteria.record_id,few));

	export countdssn_search												:= count(dssn_search								);
	export countdssn_name_search 									:= count(dssn_name_search 					);
	export countdName_Address_search 							:= count(dName_Address_search 			);
	export countdName_Zip_search 									:= count(dName_Zip_search 					);
	export countdName_State_search 								:= count(dName_State_search 				);
	export countdAddress_Only_search 							:= count(dAddress_Only_search 			);
	export countdPhone_only_search 								:= count(dPhone_only_search 				);
	export countdhas_did			 										:= count(dhas_did			 							);
	export countdother_search 										:= count(dother_search 							);

	export dother_search_proj 										:= project(dother_search
		, transform(lay_emp_out_temp
				,self.SearchCriteria := left.Extract;
				 self.Appended_data := [];
				 self.clean_name := left.clean_name;
				 self.clean_address									:= left.clean_address;
				 self.DID														:= left.DID					;
				 self.clean_phone										:= left.clean_phone	;
				 self.clean_ssn											:= left.clean_ssn		;
				 self.didmatch											:= false;
				 self.date_last_reported						:= 0;
			)
		);
		
	export all_recs := 
		fssn_search					
	+ fssn_name_search 		
	+ fPartialssn_name_search 		
	+ fName_Address_search 
	+ fName_Zip_search 		
	+ fName_State_search 	
	+ fAddress_Only_search 
	+ fPhone_only_search 	
	+ dother_search_proj
	;
	
	export count_all_recs := count(all_recs);
	export count_all_recs_record_ids := count(table(all_recs, {searchcriteria.record_id}, searchcriteria.record_id,few));

	export all_recs_out := project(
													dedup(
														sort(all_recs,(unsigned8)searchcriteria.record_id,did,-date_last_reported)
													,(unsigned8)searchcriteria.record_id,did,keep 5)
												, transform(lay_emp_out, self := left)) : persist('thor::persist::empappendsearchs');
	
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.Employment_Append.new										,all_recs_out	,BuildResponseFile,,,true);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.Employment_Append.new + 'PipeDelimited'	,all_recs_out	,BuildResponseFilePipe,,true,true,'|');

	export BuildResponseFileout := BuildResponseFile;
	export BuildResponseFileoutpipe := BuildResponseFilePipe;

	// -- Stats
	dresponse_forstats := project(all_recs_out	,transform({Layout_consumer.Response.Employment_append,string stuff}, self := left;self.stuff := 'G'));
//	dresponse_forstats := project(dataset(Filenames(pversion).out.Employment_Append.new,lay_emp_out,flat)	,transform({Layout_consumer.Response.Employment_append,string stuff}, self := left;self.stuff := 'G'));
	
	layout_stat := 
	record
    integer countGroup := count(group);
		dresponse_forstats.stuff  ;
		first_Name_CountNonBlank   				:= sum(group,if(dresponse_forstats.Appended_data.first_Name					<>'',1,0));
		middle_Name_CountNonBlank   			:= sum(group,if(dresponse_forstats.Appended_data.middle_Name				<>'',1,0));
		last_Name_CountNonBlank   				:= sum(group,if(dresponse_forstats.Appended_data.last_Name					<>'',1,0));
		Company_Name_CountNonBlank   			:= sum(group,if(dresponse_forstats.Appended_data.Company_Name				<>'',1,0));
		tax_ID_CountNonBlank   						:= sum(group,if(dresponse_forstats.Appended_data.tax_ID 						<>'',1,0));
		title_CountNonBlank   						:= sum(group,if(dresponse_forstats.Appended_data.title 							<>'',1,0));
		Street_Address_CountNonBlank   		:= sum(group,if(dresponse_forstats.Appended_data.Street_Address			<>'',1,0));
		Secondary_Address_CountNonBlank   := sum(group,if(dresponse_forstats.Appended_data.Secondary_Address	<>'',1,0));
		City_CountNonBlank   							:= sum(group,if(dresponse_forstats.Appended_data.City								<>'',1,0));
		State_CountNonBlank   						:= sum(group,if(dresponse_forstats.Appended_data.State							<>'',1,0));
		Zip_Code_CountNonBlank   					:= sum(group,if(dresponse_forstats.Appended_data.Zip_Code						<>'',1,0));
		phone_CountNonBlank   						:= sum(group,if(dresponse_forstats.Appended_data.phone							<>'',1,0));
		email_CountNonBlank   						:= sum(group,if(dresponse_forstats.Appended_data.email							<>'',1,0));
		ssn_CountNonBlank   							:= sum(group,if(dresponse_forstats.Appended_data.ssn								<>'',1,0));
		date_last_reported_CountNonBlank  := sum(group,if(dresponse_forstats.Appended_data.date_last_reported	<>'',1,0));
		date_added_CountNonBlank   				:= sum(group,if(dresponse_forstats.Appended_data.date_added					<>'',1,0));
		confidence_level_CountNonBlank   	:= sum(group,if(dresponse_forstats.Appended_data.confidence_level		=true,1,0));
                                                                       
	end;
	
	export dresponse_fill_stats := table(dresponse_forstats, layout_stat, stuff,few);

end;