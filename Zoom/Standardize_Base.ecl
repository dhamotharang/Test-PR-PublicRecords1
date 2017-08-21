import Address, Ut, lib_stringlib, _Control, business_header, _Validate, aid, idl_header;

export Standardize_Base :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	// -- add unique id
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(Layouts.Base) pBase) :=
	function
	
		//** Flipping the names that are wrongly cleaned by name cleaner.
		ut.mac_flipnames(pBase, clean_contact_name.fname, clean_contact_name.mname, clean_contact_name.lname, dBase_flipnames)
		
		Layouts.Temporary.StandardizeInput tPreProcessIndividuals(Layouts.Base l, unsigned8 cnt) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Addresses for Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
			address1 :=	
						stringlib.stringtouppercase(trim(l.rawfields.Company_Address_Street				))
					;        
			address2 :=stringlib.stringtouppercase(	
										trim(l.rawfields.Company_Address_City		)
					+ ', '	+ trim(l.rawfields.Company_Address_State	)
					+ ' '		+ trim(l.rawfields.Company_Address_Postal	)
					);                

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
																																												 
			self.address1														:= address1									;
			self.address2														:= address2									;
                                          
			self.unique_id													:= cnt											;
			
			self																		:= l												;
		end;
		
		dPreProcess := project(dBase_flipnames, tPreProcessIndividuals(left,counter));
	
		return dPreProcess;

	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeAddresses(dataset(Layouts.Temporary.StandardizeInput) pStandardizeNameInput) :=
	function

		HasAddress	:=	trim(pStandardizeNameInput.address1, left,right) != ''
								and trim(pStandardizeNameInput.address2, left,right) != '';
										
		dWith_address			:= pStandardizeNameInput(HasAddress);
		dWithout_address	:= pStandardizeNameInput(not(HasAddress));

		dWith_address_dedup		:= table(dWith_address, {unsigned8 raw_aid := 0,address1, address2}, address1, address2);

		unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

		AID.MacAppendFromRaw_2Line(dWith_address_dedup, Address1, Address2, Raw_AID, dwithAID, lFlags);
		
		
		dBase := join(
			 distribute(dWith_address	, hash64(trim(address1), trim(address2)))
			,distribute(dwithAID			, hash64(trim(address1), trim(address2)))
			,		left.address1 = right.address1
			and left.address2 = right.address2
			,transform(
				Layouts.Temporary.StandardizeInput
				,
				self.ace_aid														:= right.aidwork_acecache.aid					;
				self.raw_aid														:= right.aidwork_rawaid								;
				self.Clean_Company_address.fips_state 	:= right.aidwork_acecache.county[1..2];
				self.Clean_Company_address.fips_county	:= right.aidwork_acecache.county[3..]	;
				self.Clean_Company_address.zip					:= right.aidwork_acecache.zip5				;
				self.Clean_Company_address							:= right.aidwork_acecache							;
				self																		:= left																;
			)
			,local
			,left outer
		)
		+ project(dWithout_address,transform(Layouts.Temporary.StandardizeInput, self := left));

		return project(dBase, transform(layouts.base, self := left));
		
	end;

	export fAll( dataset(Layouts.Base	)	pBase
	) :=
	function
	
		dPreprocess					:= fPreProcess					(pBase	);
		dStandardizeAddress	:= fStandardizeAddresses(dPreprocess		);
		
		return dStandardizeAddress;
	
	end;

end;
