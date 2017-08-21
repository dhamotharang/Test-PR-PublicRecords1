import Address, Ut, lib_stringlib, _Control, business_header,_Validate;

// -- add unique id
// -- standardize name
// -- normalize and slim record for address cleaning, keep unique id
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get addresses and dates

export Standardize_PA :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(Layouts.Input.PA) pRawFileInput, string pversion) :=
	function
	
		Layouts.Temporary.PA tPreProcessPA(Layouts.Input.PA l, unsigned8 cnt) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Address for Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
			address1 :=	trim(l.Licensee_ADDRESS_1	) + ' ' 
								+ trim(l.Licensee_ADDRESS_2	)
								;        
			address2 :=	trim(l.Licensee_ADDRESS_3	)
								+ trim(l.Licensee_ZIP_CODE	)
								;        
																							

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
																																												 
			self.address1													:= address1									;
			self.address2													:= address2									;

			self.unique_id												:= cnt											;
			
			self.dt_first_seen										:= 0												;	
			self.dt_last_seen											:= 0												;
			self.dt_vendor_first_reported					:= (unsigned4)pversion			;
			self.dt_vendor_last_reported					:= (unsigned4)pversion			;

			self.clean_person_name1								:= []												;		
			self.clean_person_name2								:= []												;		
			self.clean_person_name3								:= []												;		
			self.Clean_address										:= []												;

			self.rawfields												:= l												;
		end;
		
		dPreProcess := project(pRawFileInput, tPreProcessPA(left,counter));
	
		return dPreProcess;

	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeName(dataset(Layouts.Temporary.PA) pPreProcessInput) :=
	function
		
		Namelayout :=	record
			unsigned8		unique_id	;						//	to tie back to original record
			unsigned4		ofc_num		;						//	name type
			string40		ofc_name	;
		end;
		
		dNamesNorm	:= normalize(pPreProcessInput, 3, transform(Namelayout,
			self.unique_id	:= left.unique_id;
			self.ofc_num		:= counter;
			self.ofc_name		:= stringlib.stringtouppercase(trim(map( counter = 1 => left.rawfields.Licensee_NAME_1
																															,counter = 2 => left.rawfields.Licensee_NAME_2
																															,								left.rawfields.Licensee_NAME_3
			
			)));
		));
		
		dnamesdedup := dedup(dNamesNorm(ofc_name != ''),ofc_name,all);
		
		Address.Mac_Is_Business(dnamesdedup, ofc_name, dNamesClean, name_flag, false, true,options := ['f']);
		
		ut.mac_flipnames(dNamesClean, cln_fname, cln_mname, cln_lname, dNamesClean_flipnames);

		dNamesNorm_blank 		:= dNamesNorm(ofc_name  = '');
		dNamesNorm_notblank := dNamesNorm(ofc_name != '');
		
		djoinback := join(
			 distribute(dNamesNorm_notblank		,hash64(ofc_name))
			,distribute(dNamesClean_flipnames	,hash64(ofc_name))
			,left.ofc_name = right.ofc_name
			,transform(
				{unsigned8 unique_id, unsigned4		ofc_num, Address.Layout_Clean_Name clean_person_name1, Address.Layout_Clean_Name clean_person_name2, Address.Layout_Clean_Name clean_person_name3}
					,self.unique_id 								:= left.unique_id
					,self.ofc_num										:= left.ofc_num
					,self.clean_person_name1.title 	:= right.cln_title	
					,self.clean_person_name1.fname 	:= right.cln_fname	
					,self.clean_person_name1.mname	:= right.cln_mname	
					,self.clean_person_name1.lname 	:= right.cln_lname	
					,self.clean_person_name1.name_suffix := right.cln_suffix	
					,self														:= [];
			)
			,left outer
			,local
		) +
		project(dNamesNorm_blank	,transform({unsigned8 unique_id, unsigned4		ofc_num, Address.Layout_Clean_Name clean_person_name1, Address.Layout_Clean_Name clean_person_name2, Address.Layout_Clean_Name clean_person_name3},
			self := left;
			self := [];
		));
		
		dnamesclean_rollup := rollup(sort(djoinback, unique_id, ofc_num)
		, left.unique_id = right.unique_id,
			transform(recordof(djoinback),
				self.unique_id					:= left.unique_id	;
				self.ofc_num						:= left.ofc_num		;
				self.clean_person_name1 := left.clean_person_name1;
				self.clean_person_name2	:= if(right.ofc_num = 2	,right.clean_person_name1, left.clean_person_name2);
				self.clean_person_name3	:= if(right.ofc_num = 3	,right.clean_person_name1, left.clean_person_name3);
		));
		
		dNamesDenorm := join(
			 distribute(pPreProcessInput		,unique_id)
			,distribute(dnamesclean_rollup	,unique_id)
			,left.unique_id = right.unique_id
			,transform(Layouts.Temporary.PA,
				self.clean_person_name1		:= right.clean_person_name1;
				self.clean_person_name2		:= right.clean_person_name2;
				self.clean_person_name3		:= right.clean_person_name3;
				self											:= left;
			)
			,local
		);

		return dNamesDenorm;


	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeAddresses(dataset(Layouts.Temporary.PA) pStandardizeNameInput) :=
	function

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Second, pass addresses to macro for cleaning
		// -- normalize address out into one file with address1, address2, type, and uniqueid, then pass to macro
		//////////////////////////////////////////////////////////////////////////////////////
		addresslayout :=
		record
			pStandardizeNameInput.unique_id	;	//to tie back to original record
			pStandardizeNameInput.address1	;
			pStandardizeNameInput.address2	;
		end;                  
		
		dAddressPrep	:= table(pStandardizeNameInput,addresslayout);

		HasAddress		:= 		trim(dAddressPrep.address1, left,right) != ''
										and trim(dAddressPrep.address2, left,right) != '';
										
		dWith_address			:= dAddressPrep(HasAddress);
		dWithout_address	:= dAddressPrep(not(HasAddress));

		// -- Standardize the address 
		address.mac_address_clean( dWith_address
															,address1
															,address2
															,true
															,dAddressStandardized
														);
														
		// -- match back to dStandardizedFirstPass and append address
		dStandardizeNameInput_dist 	:= distribute(pStandardizeNameInput	,unique_id);
		dAddressStandardized_dist		:= distribute(dAddressStandardized	,unique_id);

		Layouts.Base.PA tGetStandardizedAddress(Layouts.Temporary.PA l	,dAddressStandardized_dist r) :=
		transform

			Clean_address	:= Address.CleanAddressFieldsFips(r.clean).addressrecord;

			self.Clean_address	:= Clean_address	;
																																																					 
			self 								:= l							;
		
		end;
		
		dCleanAddressAppended	:= join(
																 dStandardizeNameInput_dist
																,dAddressStandardized_dist
																,left.unique_id = right.unique_id
																,tGetStandardizedAddress(left,right)
																,local
																,left outer
															);

		return dCleanAddressAppended;
		
	end;
	
	export fAll(dataset(Layouts.Input.PA) pRawFileInput, string pversion) :=
	function
	
		dPreprocess					:= fPreProcess					(pRawFileInput,pversion	);
		dStandardizeName		:= fStandardizeName			(dPreprocess						);
		dStandardizeAddress	:= fStandardizeAddresses(dStandardizeName				) : persist(Persistnames.standardizePA);
	                                                                                                                             
		return dStandardizeAddress;
	
	end;


end;
