import Address, Ut, lib_stringlib, _Control, business_header,_Validate,aid;

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
	export fPreProcess(
		 dataset(Layouts.Input.Sprayed	)	pSprayedFile
		,string														pversion
	) :=
	function
	
		dconcatsprayedfiles := 
			pSprayedFile
		;
	
		Layouts.Temporary.AddrCleanPrep tPreProcess(Layouts.Input.Sprayed l, unsigned8 cnt) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Addresses for Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
		contact_address1 :=	Address.Addr1FromComponents(
																					 stringlib.stringtouppercase(l.Main_Address_Line_1		)
																					,stringlib.stringtouppercase(l.Main_Address_Line_2		)
																					,''
																					,''
																					,''
																					,''
																					,''
																				); 
		contact_address2 :=	Address.Addr2FromComponents(
																						 stringlib.stringtouppercase(l.Main_City    				)	
																						,stringlib.stringtouppercase(l.Main_State   				)	
																						,stringlib.stringtouppercase(l.Main_Zip_Code[1..5] )
																				);

		company_address1 :=	Address.Addr1FromComponents(
																					 stringlib.stringtouppercase(l.Address_Line_1		)
																					,stringlib.stringtouppercase(l.Address_Line_2		)
																					,''
																					,''
																					,''
																					,''
																					,''
																				); 
		company_address2 :=	Address.Addr2FromComponents(
																						 stringlib.stringtouppercase(l.City    					)	
																						,stringlib.stringtouppercase(l.State   					)	
																						,stringlib.stringtouppercase(l.Zip_Code[1..5]  	)
																				);
			
                                
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
						
			SELF.contact_address1 						:= contact_address1											;
			SELF.contact_address2 						:= contact_address2											;
			SELF.company_address1 						:= company_address1											;
			SELF.company_address2 						:= company_address2											;
			self.unique_id										:= cnt		 				    								;
			self.rawfields										:= l																				;
			self.raw_contact_aid							:= 0																				;
			self.ace_contact_aid							:= 0																				;
			self.raw_company_aid							:= 0																				;
			self.ace_company_aid							:= 0																				;
			SELF															:= []																				; 
		end;
 		
		
		dPreProcess := project(dconcatsprayedfiles, tPreProcess(left,counter));
	
		return dPreProcess; 
     
	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeName(
	
		dataset(Layouts.Temporary.AddrCleanPrep) pPreProcessInput
	
	) :=
	function

		Layouts.Temporary.AddrCleanPrep tStandardizeName(Layouts.Temporary.AddrCleanPrep l) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Clean Name, determine if it is a person
			//////////////////////////////////////////////////////////////////////////////////////
			name := trim(l.rawfields.Main_Contact_Name);
			self.clean_name	:= Address.CleanPersonFML73_fields(name).CleanNameRecord;
			
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self													:= l																			;
		end;
		
		dStandardizedName := project(pPreProcessInput, tStandardizeName(left));
		
		return dStandardizedName;

	end;


	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeAddresses(
	
		dataset(Layouts.Temporary.AddrCleanPrep) pStandardizeNameInput
	
	) :=
	function

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Second, pass addresses to macro for cleaning
		// -- normalize address out into one file with address1, address2, type, and uniqueid, then pass to macro
		//////////////////////////////////////////////////////////////////////////////////////
		addresslayout :=
		record
			unsigned8										unique_id			;	//to tie back to original record
			unsigned8										rawaid				;
			unsigned1										addr_type			;	// contact or mailing
			string100 									address1			;
			string50										address2			;
		end;
		
		addresslayout tNormalizeAddress(Layouts.Temporary.AddrCleanPrep l, unsigned1 cnt) :=
		transform

			self.unique_id							:= l.unique_id						;
			self.addr_type							:= cnt										;
			self.address1								:= choose(cnt	,l.contact_address1
																								,l.company_address1	
																	);
			self.address2								:= choose(cnt	,l.contact_address2
																	              ,l.company_address2	
																	);           
			self.rawaid									:= 0;
																					 
		end;
		
		dAddressPrep	:= normalize(pStandardizeNameInput, 2, tNormalizeAddress(left,counter));

		HasAddress		:= 		trim(dAddressPrep.address1, left,right) != ''
										and trim(dAddressPrep.address2, left,right) != '';
										
		dWith_address			:= dAddressPrep(HasAddress);
		dWithout_address	:= dAddressPrep(not(HasAddress));

		lFlags := AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

		AID.MacAppendFromRaw_2Line(dWith_address, Address1, Address2, rawaid, dwithAID, lFlags);

		// -- match back to dStandardizedFirstPass and append address
		dStandardizeNameInput_dist 	:= distribute(pStandardizeNameInput	,unique_id);
		dAddressStandardized_dist		:= distribute(dwithAID							,unique_id);

		Address.Layout_Clean182_fips fReformatAceCache(AID.Layouts.rACECache	pRow) :=
		transform
			self.fips_state		:= pRow.county[1..2];
			self.fips_county	:= pRow.county[3..]	;
			self.zip					:= pRow.zip5				;
			self							:= pRow							;
		end;

		Layouts.Temporary.AddrCleanPrep tGetStandardizedAddress(Layouts.Temporary.AddrCleanPrep l	,dAddressStandardized_dist r) :=
		transform

			aidwork_acecache := row(fReformatAceCache(r.aidwork_acecache));

			self.raw_contact_aid							:= if(r.addr_type = 1	,r.AIDWork_RawAID				,l.raw_contact_aid				);
			self.ace_contact_aid							:= if(r.addr_type = 1	,r.aidwork_acecache.aid	,l.ace_contact_aid				);
			self.Clean_contact_address				:= if(r.addr_type = 1	,aidwork_acecache				,l.Clean_contact_address	);

			self.raw_company_aid							:= if(r.addr_type = 2	,r.AIDWork_RawAID				,l.raw_company_aid				);
			self.ace_company_aid							:= if(r.addr_type = 2	,r.aidwork_acecache.aid	,l.ace_company_aid				);
			self.Clean_company_address				:= if(r.addr_type = 2	,aidwork_acecache				,l.Clean_company_address	);

			self 													:= l;
		
		end;
		
		dAddressAppended	:= denormalize(
																 dStandardizeNameInput_dist
																,dAddressStandardized_dist
																,left.unique_id = right.unique_id
																,tGetStandardizedAddress(left,right)
															);

	
		return dAddressAppended;
		
	end;


	export fAll(
		 dataset(Layouts.Input.Sprayed	)	pSprayedFile
		,string														pversion
	) :=
	function
	  
		dPreprocess					:= fPreProcess			 		(pSprayedFile,pversion);
		dStandardizeName		:= fStandardizeName		 	(dPreprocess					);
		dStandardizeAddress	:= fStandardizeAddresses(dStandardizeName			) 
			: persist(persistnames().StandardizeInput);
	                                                                                                                             
		return PROJECT(dStandardizeAddress,TRANSFORM(Layouts.Base,					                                 
			                                         self 						:= LEFT;));
	
	end;

end;
