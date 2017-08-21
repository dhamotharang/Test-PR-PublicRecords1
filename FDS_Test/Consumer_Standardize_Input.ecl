import Address, Ut, lib_stringlib, _Control, business_header,_Validate;

// -- add unique id
// -- standardize name
// -- normalize and slim record for address cleaning, keep unique id
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get addresses and dates

export Consumer_Standardize_Input :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(layout_consumer.Input.ConsumerRec) pRawFileInput) :=
	function
	
		Layout_Consumer.Temporary.StandardizeInput tPreProcessIndividuals(layout_consumer.Input.ConsumerRec l, unsigned8 cnt) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Addresses for Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
			address1 :=	
										trim(l.Address										)
					+ ' '		+ trim(l.Secondary_Address					)
					;                              
			address2 :=	
										trim(l.City			)
					+ ', '	+ trim(l.State		)
					+ ' '		+ trim(l.Zip_Code	)
					;                                      

																							
                                
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
																																												 
			self.address1														:= address1									;
			self.address2														:= address2									;
                                          
			self.unique_id													:= cnt											;
			
			self.clean_name													:= []												;		
			self.Clean_address											:= []												;
			
			self.Extract														:= l												;
			self.DID																:= 	0												;
			self.DID_Score													:= 	0												;
			self.clean_phone												:= (unsigned8)ut.CleanPhone(l.phone_number)													;
			self.clean_ssn													:= (unsigned4)trim(stringlib.stringfilter(l.ssn,'0123456789'),left,right);
			     
		end;
		
		dPreProcess := project(pRawFileInput, tPreProcessIndividuals(left,counter));
	
		return dPreProcess;

	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeName(dataset(Layout_Consumer.Temporary.StandardizeInput) pPreProcessInput) :=
	function

		Layout_Consumer.Temporary.StandardizeInput tStandardizeName(Layout_Consumer.Temporary.StandardizeInput l) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Clean Name, determine if it is a person
			//////////////////////////////////////////////////////////////////////////////////////
			assembled_name 					:=					trim(l.Extract.Name		)
																;                        

			clean_name			:= Address.CleanPersonLFM73_fields(assembled_name).CleanNameRecord;

			                                                                
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self.clean_name														:= clean_name	;
			self																			:= l									;
		end;
		
		dStandardizedName := project(pPreProcessInput, tStandardizeName(left));
		
		return dStandardizedName;

	end;


	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeAddresses(dataset(Layout_Consumer.Temporary.StandardizeInput) pStandardizeNameInput) :=
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
		
		addresslayout tProjectAddress(Layout_Consumer.Temporary.StandardizeInput l) :=
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

		Layout_Consumer.Temporary.StandardizeInput tGetStandardizedAddress(Layout_Consumer.Temporary.StandardizeInput l	,dAddressStandardized_dist r) :=
		transform

			Clean_address	:= Address.CleanAddressFieldsFips(r.clean).addressrecord;

			self.Clean_address	:= Clean_address	;

			self 								:= l							;
		
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

	export fAll( 
		
		 dataset(layout_consumer.Input.ConsumerRec	)	pRawFileInput
		,string																				pPersistName	= persistnames().ConsumerStandardizeInput
							
	) :=
	function
	
		dPreprocess					:= fPreProcess					(pRawFileInput					);
		dStandardizeName		:= fStandardizeName			(dPreprocess						);
		dStandardizeAddress	:= fStandardizeAddresses(dStandardizeName				)
			: persist(pPersistName);
		
		return dStandardizeAddress;
	
	end;


end;
