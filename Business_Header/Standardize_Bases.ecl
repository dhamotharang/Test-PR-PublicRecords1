import Address, Ut, lib_stringlib, _Control, business_header,_Validate;

// -- add unique id
// -- standardize name
// -- normalize and slim record for address cleaning, keep unique id
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get addresses and dates

export Standardize_Header :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(Layout_Business_Header_Base) pRawFileInput) :=
	function
	
		Layouts_Temp.StandardizeHeader tPreProcess(Layout_Business_Header_Base l, unsigned8 cnt) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Addresses for Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
			address1 :=	
										trim(l.prim_range		)
					+ ' '		+ trim(l.predir				)
					+ ' '		+ trim(l.prim_name		)
					+ ' '		+ trim(l.addr_suffix	)
					+ ' '		+ trim(l.postdir			)
					+ ' '		+ trim(l.unit_desig		)
					+ ' '		+ trim(l.sec_range		)
					;                
			address2 :=	
										trim(l.city		)
					+ ', '	+ trim(l.state	)
					+ ' '		+ trim(intformat(l.zip, 5, 1))
					;                

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
																																												 
			self.address1														:= address1									;
			self.address2														:= address2									;
                                          
			self.unique_id													:= cnt											;
			
			self																		:= l												;
		end;
		
		dPreProcess := project(pRawFileInput, tPreProcess(left,counter));
	
		return dPreProcess;

	end;


	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeAddresses(dataset(Layouts_Temp.StandardizeHeader) pStandardizeNameInput) :=
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
		
		addresslayout tProjectAddress(Layouts_Temp.StandardizeHeader l) :=
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

		Layouts_Temp.StandardizeHeader tGetStandardizedAddress(Layouts_Temp.StandardizeHeader l	,dAddressStandardized_dist r) :=
		transform

			Clean_Company_address	:= Address.CleanAddressFieldsFips(r.clean).addressrecord;

			self.prim_range		:= Clean_Company_address.prim_range		;
			self.predir				:= Clean_Company_address.predir				;
			self.prim_name		:= Clean_Company_address.prim_name		;
			self.addr_suffix	:= Clean_Company_address.addr_suffix	;
			self.postdir			:= Clean_Company_address.postdir			;
			self.unit_desig		:= Clean_Company_address.unit_desig		;
			self.sec_range		:= Clean_Company_address.sec_range		;
			self.city					:= Clean_Company_address.city					;
			self.state				:= Clean_Company_address.state				;
			self.zip					:= Clean_Company_address.zip					;
			self.zip4					:= Clean_Company_address.zip4					;
			self.county				:= Clean_Company_address.county				;
			self.msa					:= Clean_Company_address.msa					;
			self.geo_lat			:= Clean_Company_address.geo_lat			;
			self.geo_long			:= Clean_Company_address.geo_long			;
                                 
			self 							:= l																	;
		
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

		
	export fAll( dataset(Layout_Business_Header_Base	)	pRawFileInput
	) :=
	function
	
		dPreprocess					:= fPreProcess					(pRawFileInput,pversion	);
		dStandardizeAddress	:= fStandardizeAddresses(dPreprocess						);
		
		return dStandardizeAddress;
	
	end;

*/
end;
