import Address, Ut, lib_stringlib, _Control, business_header,_Validate,aid,idl_header;

// -- add unique id
// -- standardize name
// -- normalize and slim record for address cleaning, keep unique id
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get addresses and dates

export Standardize_Input :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcessCC
	// -- Prep the Credit Counsel(CC) data for standardization.
	// -- Get address ready for cleaning
	// -- Clean the phone numbers
	// -- add unique id
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcessCC(dataset(Layouts.Input.CC) pRawFileInput, string pversion) :=
	function
	
		Layouts.Temporary.StandardizeInput tPreProcess(Layouts.Input.CC l, unsigned8 cnt) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Addresses for Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
			address1 :=	StringLib.StringCleanSpaces(
										stringlib.stringtouppercase(
															trim(l.Address1)
											+ ' ' + trim(l.Address2)));        
			address2 :=	StringLib.StringCleanSpaces(
										stringlib.stringtouppercase(
																trim(l.City)
											+ ', '	+ trim(l.State)
											+ ' '		+ trim(l.Zip)));

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Cleaning Phone numbers
			//////////////////////////////////////////////////////////////////////////////////////

			Phone					:= 	ut.CleanPhone(l.Phone);			
			Fax						:= 	ut.CleanPhone(l.Fax);	
			
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
																																												 
			self.address1									:= address1				;
			self.address2									:= address2				;
                                          
			self.unique_id													:= cnt											;
			self.record_type												:= 'C'											;
			
			self.dt_vendor_first_reported						:= (unsigned4)pversion	;
			self.dt_vendor_last_reported						:= (unsigned4)pversion	;
			
			self.clean_phones.Phone									:= Phone										;
			self.clean_phones.Fax										:= Fax											;
			self.clean_attorney_name								:= []												;		
			self.Clean_address											:= []												;
			self.rawfields													:= l												;
			self																		:= []												;
		end;
		
		dPreProcess := project(pRawFileInput, tPreProcess(left,counter));
	
		return dPreProcess;

	end;
	
		//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcessRSIH
	// -- Prep the Rausch, Sturm, Isreal and Hornick(RSIH) data for standardization.
	// -- Get address ready for cleaning
	// -- Clean the phone numbers
	// -- add unique id
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcessRSIH(dataset(Layouts.Prep.RSIH) pRawFileInput, string pversion) :=
	function
	
		Layouts.Temporary.StandardizeInput tPreProcess(Layouts.Prep.RSIH l, unsigned8 cnt) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Addresses for Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
			address1 :=	StringLib.StringCleanSpaces(stringlib.stringtouppercase(trim(l.Address1))); 
			//Remove any zip4 from the end of address2.
			address2 :=	StringLib.StringCleanSpaces(
											stringlib.stringtouppercase(
													regexreplace('-[0-9]{4}$',trim(l.Address2),'')));

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Cleaning Phone numbers
			//////////////////////////////////////////////////////////////////////////////////////

			Phone					:= 	ut.CleanPhone(l.Phone);			
					
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
																																												 
			self.address1									:= address1				;
			self.address2									:= address2				;
                                          
			self.unique_id													:= cnt											;
			self.record_type												:= 'C'											;
			
			self.dt_vendor_first_reported						:= (unsigned4)pversion	;
			self.dt_vendor_last_reported						:= (unsigned4)pversion	;
			
			self.clean_phones.Phone									:= Phone										;
			self.clean_phones.Fax										:= [] 											;
			self.clean_attorney_name								:= []												;		
			self.Clean_address											:= []												;
			self.rawfields													:= l												;
			self																		:= []												;
		end;
		
		dPreProcess := project(pRawFileInput, tPreProcess(left,counter));
	
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
			assembled_name 					:=					trim(l.rawfields.attorneyName		)
																;                

			clean_attorney_name			:= Address.CleanPersonLFM73_fields(assembled_name).CleanNameRecord;

			                                                                
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self.clean_attorney_name									:= clean_attorney_name	;

			self																			:= l									;
		end;

		dStandardizedName := project(pPreProcessInput, tStandardizeName(left));
		
		//ut.mac_flipnames(dStandardizedName, clean_attorney_name.fname, clean_attorney_name.mname, clean_attorney_name.lname, dStandardizedName_flipnames)

		//return dStandardizedName_flipnames;
		return dStandardizedName;

	end;


	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeAddresses(dataset(Layouts.Temporary.StandardizeInput) pStandardizeInput) :=
	function

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Second, pass addresses to macro for cleaning
		// -- normalize address out into one file with address1, address2, type, and uniqueid, then pass to macro
		//////////////////////////////////////////////////////////////////////////////////////
		addresslayout :=
		record
			unsigned8										unique_id			;	//to tie back to original record
			unsigned8										rawaid				;
			unsigned4										addr_type	;	// contact or mailing
			string150 									address1			;
			string50										address2			;
		end;
		
		addresslayout tNormalizeAddress(Layouts.Temporary.StandardizeInput l, unsigned4 cnt) :=
		transform

			self.unique_id							:= l.unique_id						;
			self.addr_type							:= cnt										;
			self.address1								:= l.address1;
			self.address2								:= l.address2;
			self.rawaid									:= 0;
																					 
		end;
		
		dAddressPrep	:= normalize(pStandardizeInput, 1, tNormalizeAddress(left,counter));

		HasAddress		:= 		trim(dAddressPrep.address1, left,right) != ''
										and trim(dAddressPrep.address2, left,right) != '';
										
		dWith_address			:= dAddressPrep(HasAddress);
		dWithout_address	:= dAddressPrep(not(HasAddress));

		lFlags := AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

		AID.MacAppendFromRaw_2Line(dWith_address, Address1, Address2, rawaid, dwithAID, lFlags);

		// -- match back to dStandardizedFirstPass and append address
		dStandardizeInput_dist 	:= distribute(pStandardizeInput	,unique_id);
		dAddressStandardized_dist		:= distribute(dwithAID							,unique_id);

		Address.Layout_Clean182_fips fReformatAceCache(AID.Layouts.rACECache	pRow) :=
		transform
			self.fips_state		:= pRow.county[1..2];
			self.fips_county	:= pRow.county[3..]	;
			self.zip					:= pRow.zip5				;
			self							:= pRow							;
		end;

		Layouts.Temporary.StandardizeInput tGetStandardizedAddress(Layouts.Temporary.StandardizeInput l	,dAddressStandardized_dist r) :=
		transform

			aidwork_acecache := row(fReformatAceCache(r.aidwork_acecache));

			self.raw_aid				:= if(r.addr_type = 1	,r.AIDWork_RawAID				,l.raw_aid				);
			self.ace_aid				:= if(r.addr_type = 1	,r.aidwork_acecache.aid	,l.ace_aid				);
			self.Clean_address	:= if(r.addr_type = 1	,aidwork_acecache				,l.Clean_address	);

			self 								:= l;
		
		end;
		
		dAddressAppended	:= denormalize(
																 dStandardizeInput_dist
																,dAddressStandardized_dist
																,left.unique_id = right.unique_id
																,tGetStandardizedAddress(left,right)
															);

	
		return dAddressAppended;
		
	end;

	export fAllCC( 
		 dataset(Layouts.Input.CC				)	pRawFileInput
		,string														pversion
		,string														pPersistname = persistnames().StandardizeInputCC
	) :=
	function
	
		dPreprocess					:= fPreProcessCC				(pRawFileInput,pversion	);
		
		dStandardizeAddress	:= fStandardizeAddresses(dPreprocess);
		
		dback2base :=  project(dStandardizeAddress, transform(layouts.base, self := left))
			: persist(pPersistname);
		
		return dback2base;
	
	end;
	
	export fAllRSIH( 
		 dataset(Layouts.Prep.RSIH				)	pRawFileInput
		,string														pversion
		,string														pPersistname = persistnames().StandardizeInputRSIH
	) :=
	function
	
		dPreprocess					:= fPreProcessRSIH			(pRawFileInput,pversion	);
		dStandardizeName		:= fStandardizeName			(dPreprocess						);
		dStandardizeAddress	:= fStandardizeAddresses(dStandardizeName				);
		
		dback2base :=  project(dStandardizeAddress, transform(layouts.base, self := left))
			: persist(pPersistname);
		
		return dback2base;
	
	end;


end;
