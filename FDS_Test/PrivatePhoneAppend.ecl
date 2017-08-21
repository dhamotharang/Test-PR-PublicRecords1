import header,address,ut,versioncontrol,watchdog,phonesplus, yellowpages, cellphone,risk_indicators , gong, doxie, doxie_raw, FDS_Test, _validate;

layp := phonesplus.layoutCommonOut;
pplus := phonesplus.file_phonesplus_base;
export PrivatePhoneAppend(
	 string															pversion
	, dataset(Layout_Consumer.Temporary.StandardizeInput	) pDataset	= FDS_Test.File_Consumer_Clean
	,dataset(layp)	pPhonesPlus										= pplus
	,boolean														pOverwrite				= true
	,boolean														pCsvout					= true
	,string															pSeparator				= '|'	

) := module
// /////////////////////////////////PREP PHONE FILE FOR SEARCH AND APPEND ////////////////////////////////////////
	temp_layout := record
	 unsigned did;
	 string title;
	 string fname;
	 string mname;
	 string lname;
	 string name_suffix;
	 string prim_range;
   	 string predir;
   	 string prim_name;
   	 string addr_suffix;
   	 string postdir;
	 string unit_desig;
   	 string sec_range;
	 string p_city_name;
	 string v_city_name;
	 string state;
	 string zip5;
	 string zip4;
	 unsigned datevendorfirstreported;
	 unsigned datefirstseen;
	 string phone_number;
	 unsigned confidencescore;
	 string ssn := '';
	end;

	phones_t := project(pPhonesPlus, transform(temp_layout, self.phone_number := left.cellphone, self := left));
	yellowpages.NPA_PhoneType(phones_t, phone_number, phonetype, pPhonesPlusPhType);
	
	//--------select pplus records that match zipcode file and are above threhold
	phones_filter := pPhonesPlusPhType(confidencescore > 10);
	
	temp_layout2 := record
	recordof(phones_filter);
	string ocn;
	end;
	
	//--------Append Telcordia data
	g2 := join(phones_filter, risk_indicators.Key_Telcordia_tpm, keyed(left.phone_number[1..3] = right.npa) and keyed(left.phone_number[4..6] = right.nxx) and left.phone_number[7] = right.tb, transform(temp_layout2, self.ocn := right.ocn, self := left),left outer, keep(1));
	    
	//------Dedup records and filter blank addresses where there is another record for the same individual and phone with an address  
		//---Split record with blank addresses
			no_address := g2(trim(prim_range + prim_name + sec_range, all) = '');
			no_address_with_did_dedp := dedup(sort(distribute(no_address(did > 0),  hash(phone_number)),phone_number, did, datefirstseen <> 0, -zip5, -zip4, -prim_range, -prim_name,-lname, -fname, -sec_range,local), phone_number, did, prim_range,prim_name, zip5, local);
			no_address_no_did_dedp := dedup(sort(distribute(no_address(did = 0),  hash(phone_number)),phone_number,  datefirstseen <> 0, -zip5, -zip4, -prim_range, -prim_name, -lname, -fname, -sec_range,local), phone_number, prim_range,prim_name, zip5, lname, local);

			with_address := g2(trim(prim_range + prim_name + sec_range, all) <> '');

		//-----Dedup records by phone, did and address
			pplus_with_address_did := dedup(sort(distribute(with_address(did > 0),  hash(phone_number)),phone_number, did, datefirstseen <> 0, -zip5, -zip4, -prim_range, -prim_name,-lname, -fname, -sec_range, local), phone_number, did, prim_range,prim_name, zip5, lname, fname, local);

		//-----Dedup records by phone, name and address
			pplus_with_address_no_did := dedup(sort(distribute(with_address(did = 0),  hash(phone_number)),phone_number,datefirstseen <> 0, -zip5, -zip4, -prim_range, -prim_name, -lname, -fname, -sec_range, local), phone_number, prim_range,prim_name, zip5, lname, fname, local);

		//----Concatenate all records to be included with address
			pplus_all_with_address  := pplus_with_address_did + pplus_with_address_no_did;

		//---Filter records with no address where that records is the only one available for the phone and individual
			no_address_only_one := join(distribute(no_address_with_did_dedp + no_address_no_did_dedp, hash(phone_number)),
										distribute(pplus_all_with_address, hash(phone_number)),
										left.phone_number = right.phone_number and
										 (left.did = right.did or
										  (left.did = 0 and
										  left.lname = right.lname and
										  left.fname = right.fname)),
										  transform(recordof(g2), self := left),
										  left only,
										  local);

		//----Concatenate all records to be included in final base file
			pplus_all_a := pplus_all_with_address + no_address_only_one;
	
	//----Filter records without first-last name where there is another record with the same phone but with names 
		   pplus_no_names    := pplus_all_a(fname+lname = ''); 
		   ppplus_with_names := pplus_all_a(fname+lname <> ''); 
		   
	   // Filter records with no names where another rec with same phone has a name
	      no_name_only_one   := join(distribute(pplus_no_names, hash(phone_number)),
		                             distribute(ppplus_with_names , hash(phone_number)),
									 left.phone_number = right.phone_number and
									 left.prim_range = right.prim_range and
									 left.prim_name = right.prim_name and
									 left.sec_range = right.sec_range,
									 transform(recordof(g2), self := left),
										  left only,
										  local);
										  
		//----Concatenate all records to be included in final base file
		pplus_all_b := ppplus_with_names + no_name_only_one;

//---Append SSN

     Best_f := Watchdog.File_Best;
	 
	 append_best	:= join(distribute(pplus_all_b(did > 0), hash(did)), 
				    distribute(Best_f, hash(did)), 
					(unsigned)left.did = (unsigned)right.did,
					transform(recordof(g2),
					          self.ssn := right.ssn,
							  self:= left),
					left outer,
					local);
					
					
	 hdr := header.File_Headers;
	 
	 append_hdr	:= join(distribute(append_best, hash(did)), 
				    distribute(hdr(ssn <> ''), hash(did)), 
					(unsigned)left.did = (unsigned)right.did,
					transform(recordof(g2),
					          self.ssn := if(left.ssn = '', right.ssn, left.ssn),
							  self:= left),
					left outer,
					keep (1),
					local);
					
   export all_phones_d := distribute(append_hdr + pplus_all_b(did = 0), hash(Phone_number));
   
   export all_phones_s := sort(all_phones_d , Phone_number, fname, lname, mname, prim_range, prim_name, sec_range, zip5,datefirstseen, local);
   
   export all_phones := dedup(all_phones_d , Phone_number, fname, lname, mname, prim_range, prim_name, sec_range, zip5,local);
   
   export temp_layout2 := 	
		record

			Layout_phone.Response.PrivatePhone_Extract	- Record_ID	Appended_data				;
			address.Layout_Clean_Name			clean_name		;
			Address.Layout_Clean182_fips	Clean_Address	;
			unsigned6											DID						;
			unsigned8											clean_phone		;
			unsigned8											clean_ssn			;
		end;
   
   
export   privph := 	project(
		 all_phones
		,transform(
			 temp_layout2
			,self.did												:= left.did;
			 self.Appended_data.first_Name	 	:= left.fname;
			 self.Appended_data.middle_Name	 	:= left.mname;
			 self.Appended_data.last_Name			:= left.lname;
			 self.Appended_data.Street_Address	:= trim(Address.Addr1FromComponents(
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
			 self.Appended_data.City							:= if(left.p_city_name <> '', left.p_city_name, left.v_city_name);
			 self.Appended_data.State						 	:= left.state;
			 self.Appended_data.Zip_Code					 	:= left.zip5;
			 self.Appended_data.phone_number					:= left.phone_number;
			 self.Appended_data.Line_Type						:= map(left.PhoneType[..4] in ['CELL', 'LNDL'] => 'Wireless',
																		  left.PhoneType = 'POTS' => 'Landline',
																		  left.PhoneType = 'PAGE' => 'Paging',
																			'Landline');;
			 self.Appended_data.Original_Carrier	:= left.ocn;;
			 self.Appended_data.First_Reported		:= if(left.datefirstseen > 0  and (unsigned) _validate.date.fCorrectedDateString((string)left.datefirstseen) <> 0  , intformat(ut.Date_MMDDYYYY_i2((string)left.datefirstseen +'00'),8,1), '');

	
			 self.clean_address.prim_range		:= left.prim_range		;
			 self.clean_address.predir				:= left.predir				;
			 self.clean_address.prim_name		:= left.prim_name		;
			 self.clean_address.addr_suffix	:= left.addr_suffix	;
			 self.clean_address.postdir			:= left.postdir			;
			 self.clean_address.unit_desig		:= left.unit_desig		;
			 self.clean_address.sec_range		:= left.sec_range		;
			 self.clean_address.v_city_name	:= left.v_city_name					;
			 self.clean_address.st						:= left.state				;
			 self.clean_address.zip					:= left.zip5;
			 self.clean_address							:= [];
			 self.clean_name.title				:= left.title		;
			 self.clean_name.fname				:= left.fname;		;
			 self.clean_name.mname				:= left.mname;		;
			 self.clean_name.lname				:= left.lname;		;
			 self.clean_name.name_suffix	:= left.name_suffix		;
			 self.clean_name.name_score		:= ''		;
			 self.clean_phone							:= (unsigned8)left.phone_number		;
			 self.clean_ssn								:= (unsigned8)left.ssn		;
	
		)
	) : persist('~thor_200::persist::fds::privatephone_for_append');
   
   
// /////////////////////////////////PREP VENDOR APPEND FILE FOR SEARCH AND APPEND ////////////////////////////////////////					

	shared csearch := Phone_Searches(pDataset);

	//export dssn_search												:= csearch.ssn_search											;
	export dssn_name_search 									:= csearch.ssn_name_search 								;
	export dName_Address_search 							:= csearch.Name_Address_search 						;
	export dPartialSsn_Name_search 						:= csearch.PartialSsn_Name_search					;
	export dName_Zip_search 									:= csearch.Name_Zip_search 								;
	export dName_State_search 								:= csearch.Name_State_search 							;
	//export dAddress_Only_search 							:= csearch.Address_Only_search 						;
	export dPhone_only_search 								:= csearch.Phone_only_search 							;
	export dhas_did			 											:= csearch.has_did			 									;
	export dother_search 											:= csearch.other_search 									;
	
	shared lay_priv_phone_out			:= Layout_phone.Response.PrivatePhone_Append				;
	shared lay_priv_phone_out_temp		:= Layout_phone.Temporary.PrivatePhone_Append_Temp	;
	
	//sets to filter paw down quick
	shared setsearchdids			:= set(dhas_did												, 						did											);
	shared setsearchssns			:= set(
											//dssn_search +
											dssn_name_search	+dPartialSsn_Name_search, (unsigned8)	Extract.ssn							);
	shared setsearchzips			:= set(dName_Zip_search								, (unsigned8)	Extract.zip_code				);
	shared setsearchstates			:= set(dName_State_search							, 						stringlib.stringtouppercase(trim(Extract.state,left,right))						);
	//shared setsearchaddress		:= set(dAddress_Only_search						, 						clean_address.prim_name	);
	shared setsearchphone 			:= set(dPhone_only_search							, (unsigned8)	clean_phone							);
	 
	export privph_with_did				:= privph(did != 0,did in setsearchdids);
	export privph_without_did			:= privph(did = 0);
	export privph_with_ssn				:= privph((unsigned8)clean_ssn != 0,(unsigned8)clean_ssn in setsearchssns);
	export privph_with_name_zip			:= privph(clean_name.lname != '',(unsigned8)clean_address.zip != 0,(unsigned8)clean_address.zip in setsearchzips);
	export privph_with_name_state		:= privph(clean_name.lname != '',clean_address.st != '',clean_address.st in setsearchstates);
	//export privph_with_address_only	:= privph(prim_name != '',v_city_name != '',state != '', zip5 != '',prim_name in setsearchaddress);
	export privph_with_phone_only		:= privph((unsigned)clean_phone != 0,(unsigned8)clean_phone in setsearchphone);
	
	////////////////////////////////////////////////////////////////////////////////
	// -- SSN, Name search
	////////////////////////////////////////////////////////////////////////////////
	export fssn_name_search :=
	function
	
		lssn_name_search := dssn_name_search;
		
		dwith_did			:= lssn_name_search(did != 0);
		dwithout_did	:= project(lssn_name_search(did  = 0)
		, transform(lay_priv_phone_out_temp
				,self.SearchCriteria := left.Extract;
				 self.Appended_data := [];
				 self.clean_name := left.clean_name;
				 self.clean_address									    := left.clean_address;
				 self.DID												:= left.DID					;
				 self.clean_phone										:= left.clean_phone	;
				 self.clean_ssn											:= left.clean_ssn		;
				 self.didmatch											:= false;
			)
		);

		//join with did to paw to get matches in out layout
		djoinOnDid := join(
			 distribute(privph_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_priv_phone_out_temp
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
			 distribute(privph_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_priv_phone_out_temp
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
			 distribute(privph_with_ssn	,clean_ssn)
			,distribute(dconcatnomatches1	,(unsigned8)SearchCriteria.ssn)
			,left.clean_ssn = (unsigned8)right.SearchCriteria.ssn
			and left.clean_name.fname = right.clean_name.fname
			and left.clean_name.lname = right.clean_name.lname
			,transform(
				 lay_priv_phone_out_temp
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
			 distribute(privph_with_ssn	,clean_ssn)
			,distribute(dconcatnomatches1	,(unsigned8)SearchCriteria.ssn)
			,left.clean_ssn = (unsigned8)right.SearchCriteria.ssn
			and left.clean_name.fname = right.clean_name.fname
			and left.clean_name.lname = right.clean_name.lname
			,transform(
				 lay_priv_phone_out_temp
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
		ddedupall_d1:= dedup(sort(dconcatall	,SearchCriteria.Record_id, Appended_data.phone_number, Appended_data.first_Name, Appended_data.middle_Name, Appended_data.last_Name,Appended_data.Street_Address, Appended_data.Secondary_Address, Appended_data.First_Reported <> '' ),SearchCriteria.Record_id,Appended_data.phone_number, Appended_data.first_Name, Appended_data.middle_Name, Appended_data.last_Name, Appended_data.Street_Address, Appended_data.Secondary_Address);
		ddedupall := dedup(sort(ddedupall_d1	,SearchCriteria.Record_id) , SearchCriteria.Record_id, keep(5));

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
		, transform(lay_priv_phone_out_temp
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
			 distribute(privph_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_priv_phone_out_temp
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
			 distribute(privph_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_priv_phone_out_temp
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
			 distribute(privph_with_ssn	,clean_ssn)
			,distribute(dconcatnomatches1	,(unsigned8)SearchCriteria.ssn)
			,left.clean_ssn = (unsigned8)right.SearchCriteria.ssn
			and left.clean_name.fname = right.clean_name.fname
			and left.clean_name.lname = right.clean_name.lname
			,transform(
				 lay_priv_phone_out_temp
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
			 distribute(privph_with_ssn	,clean_ssn)
			,distribute(dconcatnomatches1	,(unsigned8)SearchCriteria.ssn)
			,left.clean_ssn = (unsigned8)right.SearchCriteria.ssn
			and left.clean_name.fname = right.clean_name.fname
			and left.clean_name.lname = right.clean_name.lname
			,transform(
				 lay_priv_phone_out_temp
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
		ddedupall_d1:= dedup(sort(dconcatall	,SearchCriteria.Record_id, Appended_data.phone_number, Appended_data.first_Name, Appended_data.middle_Name, Appended_data.last_Name,Appended_data.Street_Address, Appended_data.Secondary_Address, Appended_data.First_Reported <> '' ),SearchCriteria.Record_id,Appended_data.phone_number, Appended_data.first_Name, Appended_data.middle_Name, Appended_data.last_Name, Appended_data.Street_Address, Appended_data.Secondary_Address);
		ddedupall := dedup(sort(ddedupall_d1	,SearchCriteria.Record_id) , SearchCriteria.Record_id, keep(5));

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
		, transform(lay_priv_phone_out_temp
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
			 distribute(privph_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_priv_phone_out_temp
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
			 distribute(privph_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_priv_phone_out_temp
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
		ddedupall_d1:= dedup(sort(dconcatall	,SearchCriteria.Record_id, Appended_data.phone_number, Appended_data.first_Name, Appended_data.middle_Name, Appended_data.last_Name,Appended_data.Street_Address, Appended_data.Secondary_Address, Appended_data.First_Reported <> '' ),SearchCriteria.Record_id,Appended_data.phone_number, Appended_data.first_Name, Appended_data.middle_Name, Appended_data.last_Name, Appended_data.Street_Address, Appended_data.Secondary_Address);
		ddedupall := dedup(sort(ddedupall_d1	,SearchCriteria.Record_id) , SearchCriteria.Record_id, keep(5));

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
		, transform(lay_priv_phone_out_temp
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
			 distribute(privph_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_priv_phone_out_temp
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
			 distribute(privph_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_priv_phone_out_temp
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
			 distribute(privph_with_name_zip	,hash64(clean_address.zip				,clean_name.lname,clean_name.fname))
			,distribute(dconcatnomatches1						,hash64(searchcriteria.zip_code	,clean_name.lname,clean_name.fname))
			,left.clean_address.zip = right.searchcriteria.zip_code
			and left.clean_name.fname = right.clean_name.fname
			and left.clean_name.lname = right.clean_name.lname
//			and left.clean_name.mname = right.clean_name.mname
			,transform(
				 lay_priv_phone_out_temp
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
			 distribute(privph_with_name_zip	,hash64(clean_address.zip				,clean_name.lname,clean_name.fname))
			,distribute(dconcatnomatches1						,hash64(searchcriteria.zip_code	,clean_name.lname,clean_name.fname))
			,left.clean_address.zip = right.searchcriteria.zip_code
			and left.clean_name.fname = right.clean_name.fname
			and left.clean_name.lname = right.clean_name.lname
//			and left.clean_name.mname = right.clean_name.mname
			,transform(
				 lay_priv_phone_out_temp
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
		ddedupall_d1:= dedup(sort(dconcatall	,SearchCriteria.Record_id, Appended_data.phone_number, Appended_data.first_Name, Appended_data.middle_Name, Appended_data.last_Name,Appended_data.Street_Address, Appended_data.Secondary_Address, Appended_data.First_Reported <> '' ),SearchCriteria.Record_id,Appended_data.phone_number, Appended_data.first_Name, Appended_data.middle_Name, Appended_data.last_Name, Appended_data.Street_Address, Appended_data.Secondary_Address);
		ddedupall := dedup(sort(ddedupall_d1	,SearchCriteria.Record_id) , SearchCriteria.Record_id, keep(5));

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
		, transform(lay_priv_phone_out_temp
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
			 distribute(privph_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_priv_phone_out_temp
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
			 distribute(privph_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_priv_phone_out_temp
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
			 distribute(privph_with_name_state	,hash64(clean_address.st,clean_name.lname,clean_name.fname))
			,distribute(dconcatnomatches1						,hash64(stringlib.stringtouppercase(searchcriteria.state),clean_name.lname,clean_name.fname))
			,left.clean_address.st = stringlib.stringtouppercase(right.searchcriteria.state)
			and left.clean_name.fname = right.clean_name.fname
			and left.clean_name.lname = right.clean_name.lname
//			and left.clean_name.mname = right.clean_name.mname
			,transform(
				 lay_priv_phone_out_temp
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
			 distribute(privph_with_name_state	,hash64(clean_address.st,clean_name.lname,clean_name.fname))
			,distribute(dconcatnomatches1						,hash64(stringlib.stringtouppercase(searchcriteria.state),clean_name.lname,clean_name.fname))
			,left.clean_address.st = stringlib.stringtouppercase(right.searchcriteria.state)
			and left.clean_name.fname = right.clean_name.fname
			and left.clean_name.lname = right.clean_name.lname
//			and left.clean_name.mname = right.clean_name.mname
			,transform(
				 lay_priv_phone_out_temp
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
		ddedupall_d1:= dedup(sort(dconcatall	,SearchCriteria.Record_id, Appended_data.phone_number, Appended_data.first_Name, Appended_data.middle_Name, Appended_data.last_Name,Appended_data.Street_Address, Appended_data.Secondary_Address, Appended_data.First_Reported <> '' ),SearchCriteria.Record_id,Appended_data.phone_number, Appended_data.first_Name, Appended_data.middle_Name, Appended_data.last_Name, Appended_data.Street_Address, Appended_data.Secondary_Address);
		ddedupall := dedup(sort(ddedupall_d1	,SearchCriteria.Record_id) , SearchCriteria.Record_id, keep(5));

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
		, transform(lay_priv_phone_out_temp
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
			 distribute(privph_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_priv_phone_out_temp
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
			 distribute(privph_with_did	,did)
			,distribute(dwith_did							,did)
			,left.did = right.did
			,transform(
				 lay_priv_phone_out_temp
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
			 distribute(privph_with_Phone_Only	,hash64(clean_phone))
			,distribute(dconcatnomatches1							,hash64(clean_phone))
			,
					left.clean_phone		= right.clean_phone
			,transform(
				 lay_priv_phone_out_temp
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
			 distribute(privph_with_Phone_Only	,hash64(clean_phone))
			,distribute(dconcatnomatches1							,hash64(clean_phone))
			,
					left.clean_phone		= right.clean_phone
			,transform(
				 lay_priv_phone_out_temp
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
		ddedupall_d1:= dedup(sort(dconcatall	,SearchCriteria.Record_id, Appended_data.phone_number, Appended_data.first_Name, Appended_data.middle_Name, Appended_data.last_Name,Appended_data.Street_Address, Appended_data.Secondary_Address, Appended_data.First_Reported <> '' ),SearchCriteria.Record_id,Appended_data.phone_number, Appended_data.first_Name, Appended_data.middle_Name, Appended_data.last_Name, Appended_data.Street_Address, Appended_data.Secondary_Address);
		ddedupall := dedup(sort(ddedupall_d1	,SearchCriteria.Record_id) , SearchCriteria.Record_id, keep(5));

		//sort in original order
		
		return ddedupall;
		
	end;

	//export fssn_search_matches 							:= fssn_search					(			didmatch	);
	//export fssn_search_nomatches						:= fssn_search					(not	didmatch	);
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
//	export fAddress_Only_search_matches 	 	:= fAddress_Only_search (			didmatch	);
//	export fAddress_Only_search_nomatches 	:= fAddress_Only_search (not	didmatch	);
	export fPhone_only_search_matches 	 		:= fPhone_only_search 	(			didmatch	);
	export fPhone_only_search_nomatches 		:= fPhone_only_search 	(not	didmatch	);

	//export countfssn_search_matches 						:= count(fssn_search_matches 						);
	//export countfssn_search_nomatches						:= count(fssn_search_nomatches					);
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
	//export countfAddress_Only_search_matches 	 	:= count(fAddress_Only_search_matches 	);
	//export countfAddress_Only_search_nomatches 	:= count(fAddress_Only_search_nomatches );
	export countfPhone_only_search_matches 	 		:= count(fPhone_only_search_matches 	 	);
	export countfPhone_only_search_nomatches 		:= count(fPhone_only_search_nomatches 	);

	//export countfssn_search_matches_unique_record_id							:= count(table(fssn_search_matches 						, {searchcriteria.record_id}, searchcriteria.record_id,few));
	//export countfssn_search_nomatches_unique_record_id						:= count(table(fssn_search_nomatches					, {searchcriteria.record_id}, searchcriteria.record_id,few));
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
	//export countfAddress_Only_search_matches_unique_record_id 	 	:= count(table(fAddress_Only_search_matches 	, {searchcriteria.record_id}, searchcriteria.record_id,few));
	//export countfAddress_Only_search_nomatches_unique_record_id 	:= count(table(fAddress_Only_search_nomatches , {searchcriteria.record_id}, searchcriteria.record_id,few));
	export countfPhone_only_search_matches_unique_record_id 	 		:= count(table(fPhone_only_search_matches 	 	, {searchcriteria.record_id}, searchcriteria.record_id,few));
	export countfPhone_only_search_nomatches_unique_record_id 		:= count(table(fPhone_only_search_nomatches 	, {searchcriteria.record_id}, searchcriteria.record_id,few));

	//export countdssn_search												:= count(dssn_search								);
	//export countdssn_name_search 									:= count(dssn_name_search 					);
	export countdPartialSsn_Name_search						:= count(dPartialSsn_Name_search		);
	export countdName_Address_search 							:= count(dName_Address_search 			);
	export countdName_Zip_search 									:= count(dName_Zip_search 					);
	export countdName_State_search 								:= count(dName_State_search 				);
	//export countdAddress_Only_search 							:= count(dAddress_Only_search 			);
	//export countdPhone_only_search 								:= count(dPhone_only_search 				);
	export countdhas_did			 										:= count(dhas_did			 							);
	export countdother_search 										:= count(dother_search 							);

	export dother_search_proj 										:= project(dother_search
		, transform(lay_priv_phone_out_temp
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
		//fssn_search					
//	+ 
	fssn_name_search 		
	+ fPartialSsn_Name_search 		
	+ fName_Address_search 
	+ fName_Zip_search 		
	+ fName_State_search 	
	//+ fAddress_Only_search 
	+ fPhone_only_search 	
	+ dother_search_proj
	;
	
	export count_all_recs := count(all_recs);
	export count_all_recs_record_ids := count(table(all_recs, {searchcriteria.record_id}, searchcriteria.record_id,few));

	export all_recs_out := sort(project(all_recs, transform(lay_priv_phone_out, self := left)),(unsigned8)searchcriteria.record_id);
	
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.PrivatePhone_Append.new										,all_recs_out	,BuildResponseFile,,,true);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.PrivatePhone_Append.new + 'PipeDelimited'	,all_recs_out	,BuildResponseFilePipe,,true,true,'|');
	
	dresponse_forstats := project(all_recs_out	,transform({lay_priv_phone_out,string stuff}, self := left;self.stuff := 'G'));
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
		phone_CountNonBlank   													:= sum(group,if(dresponse_forstats.Appended_data.phone_number																	<>'',1,0));
		Line_Type_CountNonBlank   											:= sum(group,if(dresponse_forstats.Appended_data.Line_Type															<>'',1,0));
		Original_Carrier_CountNonBlank   							:= sum(group,if(dresponse_forstats.Appended_data.Original_Carrier											<>'',1,0));
		First_Reported_CountNonBlank   									:= sum(group,if(dresponse_forstats.Appended_data.First_Reported													<>'',1,0));
	                                                                   
	end;
	
	export dresponse_stats := table(dresponse_forstats, layout_stat, stuff,few);


end;