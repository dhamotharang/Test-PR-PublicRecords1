import Address, Ut, lib_stringlib, _Control, business_header,_Validate;

// -- add unique id
// -- standardize name
// -- normalize and slim record for address cleaning, keep unique id
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get addresses and dates

export Standardize_Input :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(Layouts.Input.Sprayed) pRawFileInput, string pversion) :=
	function
	
		Layouts.Temporary.StandardizeInput tPreProcessIndividuals(Layouts.Input.Sprayed l, unsigned8 cnt) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Addresses for Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
			address1 :=	
						trim(l.Best_Street_Address				) + ' ' 
					+	trim(l.Best_Supplementary_Address	) + ' ' 
					;        
			address2 :=	
										trim(l.Best_City	)
					+ ', '	+ trim(l.Best_State	)
					+ ' '		+ trim(l.Best_Zip		)
					;             

			Phone		:= 	ut.CleanPhone(l.Phone	);			
			Fax			:= 	ut.CleanPhone(l.Fax		);
																							
                                
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

			self.clean_contact_name								:= []												;		
			self.Clean_best_address								:= []												;
			self.clean_phones.Phone								:= Phone										;
			self.clean_phones.Fax									:= Fax											;
			
			self.rawfields												:= l												;
		end;
		
		dPreProcess := project(pRawFileInput, tPreProcessIndividuals(left,counter));
	
		return dPreProcess;

	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeName(dataset(Layouts.Temporary.StandardizeInput) pPreProcessInput) :=
	function

		Layouts.Temporary.StandardizeInput tStandardizeName(Layouts.Temporary.StandardizeInput l) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Clean Name, determine if it is a person
			//////////////////////////////////////////////////////////////////////////////////////
			assembled_name 					:=					trim(l.rawfields.Last_Name		)
																+ ', '	+	trim(l.rawfields.First_Name 	)
																+	' '		+	trim(l.rawfields.Middle_Name 	)
																;                
			clean_contact_name			:= Address.CleanPersonLFM73_fields(assembled_name).CleanNameRecord;

			                                                                
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self.clean_contact_name										:= clean_contact_name	;

			self																			:= l									;
		end;
		
		dStandardizedName := project(pPreProcessInput, tStandardizeName(left));
		
		return dStandardizedName;

	end;


	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeAddresses(dataset(Layouts.Temporary.StandardizeInput) pStandardizeNameInput) :=
	function

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Second, pass addresses to macro for cleaning
		// -- normalize address out into one file with address1, address2, type, and uniqueid, then pass to macro
		//////////////////////////////////////////////////////////////////////////////////////
		addresslayout :=
		record
			unsigned8										unique_id			;	//to tie back to original record
			string100 									address1			;
			string50										address2			;
		end;
		
		addresslayout tProjectAddress(Layouts.Temporary.StandardizeInput l) :=
		transform

			self.unique_id							:= l.unique_id	;
			self.address1								:= l.address1		;
			self.address2								:= l.address2		;
			
		end;
		
		dAddressPrep	:= project(pStandardizeNameInput, tProjectAddress(left));

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

		Layouts.Temporary.StandardizeInput tGetStandardizedAddress(Layouts.Temporary.StandardizeInput l	,dAddressStandardized_dist r) :=
		transform

			Clean_address	:= Address.CleanAddressFieldsFips(r.clean).addressrecord;

			self.Clean_best_address	:= Clean_address;

			self 										:= l						;
		
		end;
		
		dCleancontactAddressAppended	:= join(
																 dStandardizeNameInput_dist
																,dAddressStandardized_dist
																,left.unique_id = right.unique_id
																,tGetStandardizedAddress(left,right)
																,local
																,left outer
															);

		return dCleancontactAddressAppended;
		
	end;
	
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fAppendBusinessInfo
	// -- Standardizes Dates
	// -- returns Layouts.Base dataset
	//////////////////////////////////////////////////////////////////////////////////////
	export fAppendBusinessInfo(
	
		 dataset(Layouts.Temporary.StandardizeInput	) pStandardizeAddressInput
	
	) :=
	function
		
		Layouts.Base tToBaseFormat(Layouts.Temporary.StandardizeInput l) :=
		transform
		
			self														:= l;
			
		end;
		
		base_file := project(pStandardizeAddressInput , tToBaseFormat(left));
		
		return base_file;

	end;



	export fAll( dataset(Layouts.Input.Sprayed	)	pRawFileInput
							,string														pversion
	) :=
	function
	
		dPreprocess					:= fPreProcess					(pRawFileInput,pversion	);
		dStandardizeName		:= fStandardizeName			(dPreprocess						);
		dStandardizeAddress	:= fStandardizeAddresses(dStandardizeName				);
		
		#if(_flags.UseStandardizePersists)
			dAppendBusinessInfo	:= fAppendBusinessInfo	(dStandardizeAddress) : persist(Persistnames.standardizeInput);
		#else
			dAppendBusinessInfo	:= fAppendBusinessInfo	(dStandardizeAddress);
		#end
		
		return dAppendBusinessInfo;
	
	end;


end;
