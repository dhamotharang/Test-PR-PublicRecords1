import Address, Ut, lib_stringlib, _Control, business_header,_Validate;


// -- add unique id
// -- standardize name
// -- normalize and slim record for address cleaning, keep unique id
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get addresses and dates

export Standardize_OH :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(Layouts.Input.OH) pRawFileInput, string pversion) :=
	function
	
		Layouts.Temporary.OH tPreProcessOH(Layouts.Input.OH l, unsigned8 cnt) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Address for Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
			address1 :=	trim(l.Address_line1	) + ' ' 
								+ trim(l.Address_line2	);
			address2 :=	trim(l.City_state_zip	);
																							

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

			self.clean_person_name								:= []												;		
			self.Clean_address										:= []												;

			self.rawfields												:= l												;
		end;
		
		dPreProcess := project(pRawFileInput, tPreProcessOH(left,counter));
	
		return dPreProcess;

	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeName(dataset(Layouts.Temporary.OH) pPreProcessInput) :=
	function

		Layouts.Temporary.OH tStandardizeName(Layouts.Temporary.OH l) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Clean Name, determine if it is a person
			//////////////////////////////////////////////////////////////////////////////////////
			clean_person_name				:= Address.Clean_n_Validate_Name(l.rawfields.NAME,'F').CleanNameRecord;
			
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self.clean_person_name		:= clean_person_name	;
																																									 
			self											:= l									;
		end;
		
		dStandardizedName := project(pPreProcessInput, tStandardizeName(left));
		
		return dStandardizedName;

	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeAddresses(dataset(Layouts.Temporary.OH) pStandardizeNameInput) :=
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

		Layouts.Base.OH tGetStandardizedAddress(Layouts.Temporary.OH l	,dAddressStandardized_dist r) :=
		transform

			Clean_address	:= Address.CleanAddressFieldsFips(r.clean).addressrecord;

			self.Clean_address		:= Clean_address;
																																																					 
			self 									:= l						;
		
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
	
	export fAll(dataset(Layouts.Input.OH) pRawFileInput, string pversion) :=
	function
	
		dPreprocess					:= fPreProcess					(pRawFileInput,pversion	);
		dStandardizeName		:= fStandardizeName			(dPreprocess						);
		dStandardizeAddress	:= fStandardizeAddresses(dStandardizeName				) : persist(Persistnames.standardizeoh);
	                                                                                                                             
		return dStandardizeAddress;
	
	end;


end;
