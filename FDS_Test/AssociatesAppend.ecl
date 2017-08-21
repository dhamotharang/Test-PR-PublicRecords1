//Use header.file_relatives (same_lname=true is a relative, false is an associate).  
//Based on documentation what you’re saying makes sense.  Also note that for the extract 
//you’re just returning a count, no data.
import paw,address,ut,VersionControl,header,watchdog;
export AssociatesAppend(

	 dataset(Layout_Consumer.Temporary.StandardizeInput	) pDataset	= FDS_Test.File_Consumer_Clean
	,dataset(Layout_consumer.Temporary.WD_Temp					)	prelass		= File_Relatives_Associates()
	,string																								pversion

) :=
module

	shared csearch := Consumer_Searches(pDataset);

	export dssn_search												:= csearch.ssn_search											;
	export dssn_name_search 									:= csearch.ssn_name_search 								;
	export dName_Address_search 							:= csearch.Name_Address_search 						;
	export dPartialSsn_Name_search 						:= csearch.PartialSsn_Name_search					;
	export dName_Zip_search 									:= csearch.Name_Zip_search 								;
	export dName_State_search 								:= csearch.Name_State_search 							;
	export dAddress_Only_search 							:= csearch.Address_Only_search 						;
	export dPhone_only_search 								:= csearch.Phone_only_search 							;
	export dhas_did			 											:= csearch.has_did			 									;
	export dother_search 											:= csearch.other_search 									;
	
	shared lay_rel_out			:= Layout_consumer.Response.associates_Append				;
	shared lay_rel_out_temp	:= Layout_consumer.Temporary.associates_Append_Temp	;
	
	//sets to filter paw down quick
	shared setsearchdids			:= set(dhas_did												, 						did											);
	shared setsearchssns			:= set(dssn_search + dssn_name_search	+dPartialSsn_Name_search, (unsigned8)	Extract.ssn							);
	shared setsearchzips			:= set(dName_Zip_search								, (unsigned8)	Extract.zip_code				);
	shared setsearchstates		:= set(dName_State_search							, 						stringlib.stringtouppercase(trim(Extract.state,left,right))						);
	shared setsearchaddress		:= set(dAddress_Only_search						, 						clean_address.prim_name	);
	shared setsearchphone 		:= set(dPhone_only_search							, (unsigned8)	clean_phone							);
	 
	export prelass_with_did						:= prelass(did != 0,did in setsearchdids);
	export prelass_without_did				:= prelass(did = 0);
	export prelass_with_ssn						:= prelass((unsigned8)clean_ssn != 0,(unsigned8)clean_ssn in setsearchssns);
	export prelass_with_name_zip			:= prelass(clean_name.lname != '',(unsigned8)clean_address.zip != 0,(unsigned8)clean_address.zip in setsearchzips);
	export prelass_with_name_state		:= prelass(clean_name.lname != '',clean_address.st != '',clean_address.st in setsearchstates);
	export prelass_with_address_only	:= prelass(clean_address.prim_name != '',clean_address.v_city_name != '',clean_address.st != '', clean_address.zip != '',clean_address.prim_name in setsearchaddress);
	export prelass_with_phone_only		:= prelass(clean_phone != 0,(unsigned8)clean_phone in setsearchphone);
	
	////////////////////////////////////////////////////////////////////////////////
	// -- SSN search
	////////////////////////////////////////////////////////////////////////////////
	export fssn_search :=
	function
	
		lssn_search := dssn_search;
		
		dwith_did			:= lssn_search(did != 0);
		
		dwithout_did	:= project(lssn_search(did  = 0)
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria := left.Extract;
				 self.Appended_data := [];
				 self.clean_name := left.clean_name;
				 self.clean_address									:= left.clean_address;
				 self.DID														:= left.DID					;
				 self.clean_phone										:= left.clean_phone	;
				 self.clean_ssn											:= left.clean_ssn		;
				 self.didmatch											:= false;
			)
		);

		//join with did to paw to get matches in out layout
		djoinOnDid := join(
			 distribute(prelass_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnDidNomatches := join(
			 distribute(prelass_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
			)
			,local
			,right only
		);
		
		//concat nomatches + those without did
		dconcatnomatches1 := dwithout_did + djoinOnDidNomatches;
		
		//join concat to paw on ssn, get matches
		djoinOnSsn := join(
			 distribute(prelass_with_ssn	,clean_ssn)
			,distribute(dconcatnomatches1	,(unsigned8)SearchCriteria.ssn)
			,left.clean_ssn = (unsigned8)right.SearchCriteria.ssn
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnSSnNomatches := join(
			 distribute(prelass_with_ssn	,clean_ssn)
			,distribute(dconcatnomatches1	,(unsigned8)SearchCriteria.ssn)
			,left.clean_ssn = (unsigned8)right.SearchCriteria.ssn
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
			)
			,local
			,right only
		);

		//concat first join + last two joins
		dconcatall := djoinOnDid + djoinOnSsn + djoinOnSSnNomatches;

		//dedup, keeping 5 records per orig record
		ddedupall := dedup(sort(dconcatall	,SearchCriteria.Record_id),SearchCriteria.Record_id,keep 5);

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
		, transform(lay_rel_out_temp
				,self.SearchCriteria := left.Extract;
				 self.Appended_data := [];
				 self.clean_name := left.clean_name;
				 self.clean_address									:= left.clean_address;
				 self.DID														:= left.DID					;
				 self.clean_phone										:= left.clean_phone	;
				 self.clean_ssn											:= left.clean_ssn		;
				 self.didmatch											:= false;
			)
		);

		//join with did to paw to get matches in out layout
		djoinOnDid := join(
			 distribute(prelass_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnDidNomatches := join(
			 distribute(prelass_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
			)
			,local
			,right only
		);
		
		//concat nomatches + those without did
		dconcatnomatches1 := dwithout_did + djoinOnDidNomatches;
		
		//join concat to paw on ssn,name get matches
		djoinOnSsnName := join(
			 distribute(prelass_with_ssn	,clean_ssn)
			,distribute(dconcatnomatches1	,(unsigned8)SearchCriteria.ssn)
			,left.clean_ssn = (unsigned8)right.SearchCriteria.ssn
			and left.clean_name.fname = right.clean_name.fname
			and left.clean_name.lname = right.clean_name.lname
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnSSnNameNomatches := join(
			 distribute(prelass_with_ssn	,clean_ssn)
			,distribute(dconcatnomatches1	,(unsigned8)SearchCriteria.ssn)
			,left.clean_ssn = (unsigned8)right.SearchCriteria.ssn
			and left.clean_name.fname = right.clean_name.fname
			and left.clean_name.lname = right.clean_name.lname
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
			)
			,local
			,right only
		);

		//concat first join + last two joins
		dconcatall := djoinOnDid + djoinOnSsnName + djoinOnSSnNameNomatches;

		//dedup, keeping 5 records per orig record
		ddedupall := dedup(sort(dconcatall	,SearchCriteria.Record_id),SearchCriteria.Record_id,keep 5);

		//sort in original order
		
		return ddedupall;
		
	end;

	////////////////////////////////////////////////////////////////////////////////
	// -- Partial SSN, Name search
	////////////////////////////////////////////////////////////////////////////////
	export fPartialSsn_Name_search :=
	function
	
		lssn_name_search := dPartialSsn_Name_search;
		
		dwith_did			:= lssn_name_search(did != 0);
		dwithout_did	:= project(lssn_name_search(did  = 0)
		, transform(lay_rel_out_temp
				,self.SearchCriteria := left.Extract;
				 self.Appended_data := [];
				 self.clean_name := left.clean_name;
				 self.clean_address									:= left.clean_address;
				 self.DID														:= left.DID					;
				 self.clean_phone										:= left.clean_phone	;
				 self.clean_ssn											:= left.clean_ssn		;
				 self.didmatch											:= false;
			)
		);

		//join with did to paw to get matches in out layout
		djoinOnDid := join(
			 distribute(prelass_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnDidNomatches := join(
			 distribute(prelass_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
			)
			,local
			,right only
		);
		
		//concat nomatches + those without did
		dconcatnomatches1 := dwithout_did + djoinOnDidNomatches;
		
		//join concat to paw on ssn,name get matches
		djoinOnSsnName := join(
			 distribute(prelass_with_ssn	,clean_ssn)
			,distribute(dconcatnomatches1	,(unsigned8)SearchCriteria.ssn)
			,left.clean_ssn = (unsigned8)right.SearchCriteria.ssn
			and left.clean_name.fname = right.clean_name.fname
			and left.clean_name.lname = right.clean_name.lname
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnSSnNameNomatches := join(
			 distribute(prelass_with_ssn	,clean_ssn)
			,distribute(dconcatnomatches1	,(unsigned8)SearchCriteria.ssn)
			,left.clean_ssn = (unsigned8)right.SearchCriteria.ssn
			and left.clean_name.fname = right.clean_name.fname
			and left.clean_name.lname = right.clean_name.lname
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
			)
			,local
			,right only
		);

		//concat first join + last two joins
		dconcatall := djoinOnDid + djoinOnSsnName + djoinOnSSnNameNomatches;

		//dedup, keeping 5 records per orig record
		ddedupall := dedup(sort(dconcatall	,SearchCriteria.Record_id),SearchCriteria.Record_id,keep 5);

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
		, transform(lay_rel_out_temp
				,self.SearchCriteria := left.Extract;
				 self.Appended_data := [];
				 self.clean_name := left.clean_name;
				 self.clean_address									:= left.clean_address;
				 self.DID														:= left.DID					;
				 self.clean_phone										:= left.clean_phone	;
				 self.clean_ssn											:= left.clean_ssn		;
				 self.didmatch											:= false;
			)
		);

		//join with did to paw to get matches in out layout
		djoinOnDid := join(
			 distribute(prelass_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnDidNomatches := join(
			 distribute(prelass_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
			)
			,local
			,right only
		);
		
		//concat nomatches + those without did
		dconcatnomatches1 := djoinOnDid + djoinOnDidNomatches + dwithout_did;
		
		//concat first join + last two joins
		dconcatall := dconcatnomatches1;

		//dedup, keeping 5 records per orig record
		ddedupall := dedup(sort(dconcatall	,SearchCriteria.Record_id),SearchCriteria.Record_id,keep 5);

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
		, transform(lay_rel_out_temp
				,self.SearchCriteria := left.Extract;
				 self.Appended_data := [];
				 self.clean_name := left.clean_name;
				 self.clean_address									:= left.clean_address;
				 self.DID														:= left.DID					;
				 self.clean_phone										:= left.clean_phone	;
				 self.clean_ssn											:= left.clean_ssn		;
				 self.didmatch											:= false;
			)
		);

		//join with did to paw to get matches in out layout
		djoinOnDid := join(
			 distribute(prelass_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnDidNomatches := join(
			 distribute(prelass_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
			)
			,local
			,right only
		);
		
		//concat nomatches + those without did
		dconcatnomatches1 := dwithout_did + djoinOnDidNomatches;
		
		//join concat to paw on name,zip get matches
		djoinOnNameZip := join(
			 distribute(prelass_with_name_zip	,hash64(clean_address.zip				,clean_name.lname,clean_name.fname))
			,distribute(dconcatnomatches1						,hash64(searchcriteria.zip_code	,clean_name.lname,clean_name.fname))
			,left.clean_address.zip = right.searchcriteria.zip_code
			and left.clean_name.fname = right.clean_name.fname
			and left.clean_name.lname = right.clean_name.lname
//			and left.clean_name.mname = right.clean_name.mname
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnNameZipNomatches := join(
			 distribute(prelass_with_name_zip	,hash64(clean_address.zip				,clean_name.lname,clean_name.fname))
			,distribute(dconcatnomatches1						,hash64(searchcriteria.zip_code	,clean_name.lname,clean_name.fname))
			,left.clean_address.zip = right.searchcriteria.zip_code
			and left.clean_name.fname = right.clean_name.fname
			and left.clean_name.lname = right.clean_name.lname
//			and left.clean_name.mname = right.clean_name.mname
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
			)
			,local
			,right only
		);

		//concat first join + last two joins
		dconcatall := djoinOnDid + djoinOnNameZip + djoinOnNameZipNomatches;

		//dedup, keeping 5 records per orig record
		ddedupall := dedup(sort(dconcatall	,SearchCriteria.Record_id),SearchCriteria.Record_id,keep 5);

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
		, transform(lay_rel_out_temp
				,self.SearchCriteria := left.Extract;
				 self.Appended_data := [];
				 self.clean_name := left.clean_name;
				 self.clean_address									:= left.clean_address;
				 self.DID														:= left.DID					;
				 self.clean_phone										:= left.clean_phone	;
				 self.clean_ssn											:= left.clean_ssn		;
				 self.didmatch											:= false;
			)
		);

		//join with did to paw to get matches in out layout
		djoinOnDid := join(
			 distribute(prelass_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnDidNomatches := join(
			 distribute(prelass_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
			)
			,local
			,right only
		);
		
		//concat nomatches + those without did
		dconcatnomatches1 := dwithout_did + djoinOnDidNomatches;
		
		//join concat to paw on name,zip get matches
		djoinOnNameState := join(
			 distribute(prelass_with_name_state	,hash64(clean_address.st,clean_name.lname,clean_name.fname))
			,distribute(dconcatnomatches1						,hash64(stringlib.stringtouppercase(searchcriteria.state),clean_name.lname,clean_name.fname))
			,left.clean_address.st = stringlib.stringtouppercase(right.searchcriteria.state)
			and left.clean_name.fname = right.clean_name.fname
			and left.clean_name.lname = right.clean_name.lname
//			and left.clean_name.mname = right.clean_name.mname
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnNameStateNomatches := join(
			 distribute(prelass_with_name_state	,hash64(clean_address.st,clean_name.lname,clean_name.fname))
			,distribute(dconcatnomatches1						,hash64(stringlib.stringtouppercase(searchcriteria.state),clean_name.lname,clean_name.fname))
			,left.clean_address.st = stringlib.stringtouppercase(right.searchcriteria.state)
			and left.clean_name.fname = right.clean_name.fname
			and left.clean_name.lname = right.clean_name.lname
//			and left.clean_name.mname = right.clean_name.mname
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
			)
			,local
			,right only
		);

		//concat first join + last two joins
		dconcatall := djoinOnDid + djoinOnNameState + djoinOnNameStateNomatches;

		//dedup, keeping 5 records per orig record
		ddedupall := dedup(sort(dconcatall	,SearchCriteria.Record_id),SearchCriteria.Record_id,keep 5);

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
		, transform(lay_rel_out_temp
				,self.SearchCriteria := left.Extract;
				 self.Appended_data := [];
				 self.clean_name := left.clean_name;
				 self.clean_address									:= left.clean_address;
				 self.DID														:= left.DID					;
				 self.clean_phone										:= left.clean_phone	;
				 self.clean_ssn											:= left.clean_ssn		;
				 self.didmatch											:= false;
			)
		);

		//join with did to paw to get matches in out layout
		djoinOnDid := join(
			 distribute(prelass_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnDidNomatches := join(
			 distribute(prelass_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
			)
			,local
			,right only
		);
		
		//concat nomatches + those without did
		dconcatnomatches1 := dwithout_did + djoinOnDidNomatches;
		
		//join concat to paw on name,zip get matches
		djoinOnAddress_Only := join(
			 distribute(prelass_with_Address_Only	,hash64(clean_address.prim_range,clean_address.prim_name,clean_address.st,clean_address.zip))
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
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnAddress_OnlyNomatches := join(
			 distribute(prelass_with_Address_Only	,hash64(clean_address.prim_range,clean_address.prim_name,clean_address.st,clean_address.zip))
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
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
			)
			,local
			,right only
		);

		//concat first join + last two joins
		dconcatall := djoinOnDid + djoinOnAddress_Only + djoinOnAddress_OnlyNomatches;

		//dedup, keeping 5 records per orig record
		ddedupall := dedup(sort(dconcatall	,SearchCriteria.Record_id),SearchCriteria.Record_id,keep 5);

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
		, transform(lay_rel_out_temp
				,self.SearchCriteria := left.Extract;
				 self.Appended_data := [];
				 self.clean_name := left.clean_name;
				 self.clean_address									:= left.clean_address;
				 self.DID														:= left.DID					;
				 self.clean_phone										:= left.clean_phone	;
				 self.clean_ssn											:= left.clean_ssn		;
				 self.didmatch											:= false;
			)
		);

		//join with did to paw to get matches in out layout
		djoinOnDid := join(
			 distribute(prelass_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnDidNomatches := join(
			 distribute(prelass_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.Extract;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
			)
			,local
			,right only
		);
		
		//concat nomatches + those without did
		dconcatnomatches1 := dwithout_did + djoinOnDidNomatches;
		
		//join concat to paw on phone only get matches
		djoinOnPhone_Only := join(
			 distribute(prelass_with_Phone_Only	,hash64(clean_phone))
			,distribute(dconcatnomatches1							,hash64(clean_phone))
			,
					left.clean_phone		= right.clean_phone
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= true;
			)
			,local
		);
		
		//join to get nomatches
		djoinOnPhone_OnlyNomatches := join(
			 distribute(prelass_with_Phone_Only	,hash64(clean_phone))
			,distribute(dconcatnomatches1							,hash64(clean_phone))
			,
					left.clean_phone		= right.clean_phone
			,transform(
				 lay_rel_out_temp
				,self.SearchCriteria								:= right.SearchCriteria;
				 self.Appended_data									:= left.Appended_data	;
				 self.clean_name										:= right.clean_name;
				 self.clean_address									:= right.clean_address;
				 self.DID														:= right.DID					;
				 self.clean_phone										:= right.clean_phone	;
				 self.clean_ssn											:= right.clean_ssn		;
				 self.didmatch											:= false;
			)
			,local
			,right only
		);

		//concat first join + last two joins
		dconcatall := djoinOnDid + djoinOnPhone_Only + djoinOnPhone_OnlyNomatches;

		//dedup, keeping 5 records per orig record
		ddedupall := dedup(sort(dconcatall	,SearchCriteria.Record_id),SearchCriteria.Record_id,keep 5);

		//sort in original order
		
		return ddedupall;
		
	end;

	export fssn_search_matches 							:= fssn_search					(			didmatch	);
	export fssn_search_nomatches						:= fssn_search					(not	didmatch	);
	export fssn_name_search_matches 	 			:= fssn_name_search 		(			didmatch	);
	export fssn_name_search_nomatches 			:= fssn_name_search 		(not	didmatch	);
	export fPartialSsn_Name_search_matches 	:= fPartialSsn_Name_search 		(			didmatch	);
	export fPartialSsn_Name_search_nomatches:= fPartialSsn_Name_search 		(not	didmatch	);
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
	export countfssn_name_search_matches 	 			:= count(fssn_name_search_matches 	 		);
	export countfssn_name_search_nomatches 			:= count(fssn_name_search_nomatches 		);
	export countfPartialSsn_Name_search_matches 		:= count(fPartialSsn_Name_search_matches 	 		);
	export countfPartialSsn_Name_search_nomatches		:= count(fPartialSsn_Name_search_nomatches 		);
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
	export countfssn_name_search_nomatches_unique_record_id 			:= count(table(fssn_name_search_nomatches 		, {searchcriteria.record_id}, searchcriteria.record_id,few));
	export countfPartialSsn_Name_search_matches_unique_record_id 	 			:= count(table(fPartialSsn_Name_search_matches 		, {searchcriteria.record_id}, searchcriteria.record_id,few));
	export countfPartialSsn_Name_search_nomatches_unique_record_id 			:= count(table(fPartialSsn_Name_search_nomatches	, {searchcriteria.record_id}, searchcriteria.record_id,few));
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
	export countdPartialSsn_Name_search						:= count(dPartialSsn_Name_search		);
	export countdName_Address_search 							:= count(dName_Address_search 			);
	export countdName_Zip_search 									:= count(dName_Zip_search 					);
	export countdName_State_search 								:= count(dName_State_search 				);
	export countdAddress_Only_search 							:= count(dAddress_Only_search 			);
	export countdPhone_only_search 								:= count(dPhone_only_search 				);
	export countdhas_did			 										:= count(dhas_did			 							);
	export countdother_search 										:= count(dother_search 							);

	export dother_search_proj 										:= project(dother_search
		, transform(lay_rel_out_temp
				,self.SearchCriteria := left.Extract;
				 self.Appended_data := [];
				 self.clean_name := left.clean_name;
				 self.clean_address									:= left.clean_address;
				 self.DID														:= left.DID					;
				 self.clean_phone										:= left.clean_phone	;
				 self.clean_ssn											:= left.clean_ssn		;
				 self.didmatch											:= false;
			)
		);
		
	export all_recs := 
		fssn_search					
	+ fssn_name_search 		
	+ fPartialSsn_Name_search 		
	+ fName_Address_search 
	+ fName_Zip_search 		
	+ fName_State_search 	
	+ fAddress_Only_search 
	+ fPhone_only_search 	
	+ dother_search_proj
	;
	
	export count_all_recs := count(all_recs);
	export count_all_recs_record_ids := count(table(all_recs, {searchcriteria.record_id}, searchcriteria.record_id,few));

	export all_recs_out := sort(project(all_recs, transform(lay_rel_out, self := left)),(unsigned8)searchcriteria.record_id);
	
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.associates_Append.new										,all_recs_out	,BuildResponseFile,,,true);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.associates_Append.new + 'PipeDelimited'	,all_recs_out	,BuildResponseFilePipe,,true,true,'|');
	
	dresponse_forstats := project(all_recs_out	,transform({lay_rel_out,string stuff}, self := left;self.stuff := 'G'));
//	dresponse_forstats := project(dataset(Filenames(pversion).out.Relatives_Append.new,lay_rel_out,flat)	,transform({lay_rel_out,string stuff}, self := left;self.stuff := 'G'));
	
	layout_stat := 
	record
    integer countGroup := count(group);
		dresponse_forstats.stuff  ;
		first_Name_CountNonBlank   											:= sum(group,if(dresponse_forstats.Appended_data.first_Name															<>'',1,0));
		middle_Name_CountNonBlank   										:= sum(group,if(dresponse_forstats.Appended_data.middle_Name														<>'',1,0));
		last_Name_CountNonBlank   											:= sum(group,if(dresponse_forstats.Appended_data.last_Name															<>'',1,0));
		Street_Address_CountNonBlank   									:= sum(group,if(dresponse_forstats.Appended_data.Street_Address													<>'',1,0));
		Secondary_Address_CountNonBlank   							:= sum(group,if(dresponse_forstats.Appended_data.Secondary_Address											<>'',1,0));
		City_CountNonBlank   														:= sum(group,if(dresponse_forstats.Appended_data.City																		<>'',1,0));
		State_CountNonBlank   													:= sum(group,if(dresponse_forstats.Appended_data.State																	<>'',1,0));
		Zip_Code_CountNonBlank   												:= sum(group,if(dresponse_forstats.Appended_data.Zip_Code																<>'',1,0));
		phone_CountNonBlank   													:= sum(group,if(dresponse_forstats.Appended_data.phone																	<>'',1,0));
		date_added_CountNonBlank   											:= sum(group,if(dresponse_forstats.Appended_data.date_added															<>'',1,0));
		date_last_reported_CountNonBlank   							:= sum(group,if(dresponse_forstats.Appended_data.date_last_reported											<>'',1,0));
		date_of_birth_CountNonBlank   									:= sum(group,if(dresponse_forstats.Appended_data.date_of_birth													<>'',1,0));
		count_of_all_associates_available_CountNonBlank  := sum(group,if(dresponse_forstats.Appended_data.count_of_all_associates_available				<>'',1,0));
                                                                       
	end;
	
	export dresponse_stats := table(dresponse_forstats, layout_stat, stuff,few);

	
end;