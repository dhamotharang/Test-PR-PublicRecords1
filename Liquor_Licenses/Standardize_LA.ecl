import Address, Ut, lib_stringlib, _Control, business_header,_Validate;


// -- add unique id
// -- standardize name
// -- normalize and slim record for address cleaning, keep unique id
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get addresses and dates

export Standardize_LA :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(Layouts.Input.LA) pRawFileInput, string pversion) :=
	function
	
		Layouts.Temporary.LA tPreProcessLA(Layouts.Input.LA l, unsigned8 cnt) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Addresses for Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
			trade_address1 :=		
					trim(l.ADDRESS)
				;
			trade_address2 :=	
					trim(l.TRADECITY	) + ', ' 
				+ trim(l.TRADESTATE	) + ' ' 
				+ trim(l.TRADEZIP		)
				;        
			owner_address1 :=
					trim(l.OWNERADDRESS)
				;
			owner_address2 :=	
					trim(l.OWNER_CITY		) + ', ' 
				+ trim(l.OWNER_STATE	) + ' ' 
				+ trim(l.OWNER_ZIP		)
				;        
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
																																												 
			self.trade_address1										:= trade_address1				;
			self.trade_address2										:= trade_address2				;
			self.owner_address1										:= owner_address1				;
			self.owner_address2										:= owner_address2				;
          
			self.unique_id												:= cnt											;
			
			self.dt_first_seen										:= 0												;	
			self.dt_last_seen											:= 0												;
			self.dt_vendor_first_reported					:= (unsigned4)pversion			;
			self.dt_vendor_last_reported					:= (unsigned4)pversion			;

			self.clean_owner_name									:= []												;		
			self.Clean_trade_address							:= []												;
			self.Clean_owner_address							:= []												;

			self.rawfields												:= l												;
		end;
		
		dPreProcess := project(pRawFileInput, tPreProcessLA(left,counter));
	
		return dPreProcess;

	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeName(dataset(Layouts.Temporary.LA) pPreProcessInput) :=
	function

		Layouts.Temporary.LA tStandardizeName(Layouts.Temporary.LA l) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Clean Name, determine if it is a person
			//////////////////////////////////////////////////////////////////////////////////////
			clean_owner_name			:= Address.Clean_n_Validate_Name(trim(l.rawfields.OwnerName),'L').CleanNameRecord;

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self.clean_owner_name					:= clean_owner_name	;
																																												 
			self													:= l									;
		end;
		
		dStandardizedName := project(pPreProcessInput, tStandardizeName(left));
		
		return dStandardizedName;

	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeAddresses(dataset(Layouts.Temporary.LA) pStandardizeNameInput) :=
	function

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Second, pass addresses to macro for cleaning
		// -- normalize address out into one file with address1, address2, type, and uniqueid, then pass to macro
		//////////////////////////////////////////////////////////////////////////////////////
		addresslayout :=
		record
			unsigned8										unique_id			;	//to tie back to original record
			unsigned4										address_type	;	// location or mailing
			string100 									address1			;
			string50										address2			;
		end;
		
		addresslayout tNormalizeAddress(Layouts.Temporary.LA l, unsigned4 cnt) :=
		transform

			self.unique_id							:= l.unique_id;
			self.address_type						:= cnt				;
			self.address1								:= if(cnt = 1	,l.trade_address1
																								,l.owner_address1
																	);
			self.address2								:= if(cnt = 1	,l.trade_address2
																								,l.owner_address2
																	);
		end;
		
		dAddressPrep	:= normalize(pStandardizeNameInput, 2, tNormalizeAddress(left,counter));

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

		Layouts.Temporary.LA tGetStandardizedAddress(Layouts.Temporary.LA l	,dAddressStandardized_dist r) :=
		transform

			Clean_address	:= Address.CleanAddressFieldsFips(r.clean).addressrecord;

			self.Clean_trade_address	:= if(r.address_type = 1, Clean_address	,l.Clean_trade_address	);
			self.Clean_owner_address	:= if(r.address_type = 2, Clean_address	,l.Clean_owner_address	);
                                                                     
			self 												:= l;
		
		end;
		
		dCleanTradeAddressAppended	:= join(
																 dStandardizeNameInput_dist
																,dAddressStandardized_dist(address_type = 1)
																,left.unique_id = right.unique_id
																,tGetStandardizedAddress(left,right)
																,local
																,left outer
															);
		
		dCleanOwnerAddressAppended	:= join(
																 dCleanTradeAddressAppended
																,dAddressStandardized_dist(address_type = 2)
																,left.unique_id = right.unique_id
																,tGetStandardizedAddress(left,right)
																,local
																,left outer
															);

		dCleanAddressAppended := project(dCleanOwnerAddressAppended, transform(Layouts.Base.LA, self := left));
		
		return dCleanAddressAppended;
		
	end;
	
	



	export fAll(dataset(Layouts.Input.LA) pRawFileInput, string pversion) :=
	function
	
		dPreprocess					:= fPreProcess					(pRawFileInput,pversion	);
		dStandardizeName		:= fStandardizeName			(dPreprocess						);
		dStandardizeAddress	:= fStandardizeAddresses(dStandardizeName				) : persist(Persistnames.standardizeLA);
	                                                                                                                             
		return dStandardizeAddress;
	
	end;


end;
