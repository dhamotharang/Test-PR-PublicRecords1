import address, ut;
export fRecleanBusinessContacts(dataset(Business_Header.Layout_Business_Contact_Full) pInput) :=
function

	layout_clean :=
	record
		Business_Header.Layout_Business_Contact_Full;
		string65 address_line_1; 
		string32 address_line_2;
	end;
	
	layout_clean tparseAddressLines(Business_Header.Layout_Business_Contact_Full l) :=
	transform
		self.address_line_1 := 
					Address.Addr1FromComponents(
												 l.prim_range
												,l.predir
												,l.prim_name
												,l.addr_suffix
												,l.postdir
												,l.unit_desig
												,l.sec_range
											);
		
		self.address_line_2 :=
					Address.Addr2FromComponents(
													 l.city
													,l.state
													,(string)l.zip
													);

		self := l;
	end;
	
	
	preclean_table := project(pInput, tparseAddressLines(left));
	
	// Re-Clean the addresses
/*	address.mac_address_clean( preclean_table
														,address_line_1
														,address_line_2
														,true
														,Outputfromcleaner
													);
	
	outputfromcleanerpersist := Outputfromcleaner : persist(business_header.Bus_Thor + 'persist::fRecleanBusinessHeaders');
	
	layout_recleaned_address :=
	record
	
		Business_Header.Layout_Business_Header_Base;
		Address.Layout_Clean182_fips reclean;

	end;
*/
	Business_Header.Layout_Business_Contact_Full tBreakOutCleanedAddress(layout_clean l) :=
	transform

		recleaned_address	:= Address.CleanAddressFieldsFips(address.CleanAddress182(l.address_line_1,l.address_line_2));
		old_error_code 		:= if(l.zip4 = 0, 'E', 'S');		
		new_error_code		:= recleaned_address.err_stat[1];
		take_old := if(new_error_code != 'S', true, false);

		
		self.prim_range		:= if(take_old,l.prim_range	,recleaned_address.prim_range		);
		self.predir				:= if(take_old,l.predir			,recleaned_address.predir				);
		self.prim_name		:= if(take_old,l.prim_name	,recleaned_address.prim_name		);
		self.addr_suffix	:= if(take_old,l.addr_suffix,recleaned_address.addr_suffix	);
		self.postdir			:= if(take_old,l.postdir		,recleaned_address.postdir			);
		self.unit_desig		:= if(take_old,l.unit_desig	,recleaned_address.unit_desig		);
		self.sec_range		:= if(take_old,l.sec_range	,recleaned_address.sec_range		);
		self.city					:= if(take_old,l.city				,recleaned_address.v_city_name	);
		self.state				:= if(take_old,l.state			,recleaned_address.st						);
		self.zip					:= if(take_old,l.zip				,(unsigned3)recleaned_address.zip					);
		self.zip4					:= if(take_old,l.zip4				,(unsigned2)recleaned_address.zip4					);
		self.county				:= if(take_old,l.county			,recleaned_address.fips_state + recleaned_address.fips_county);
		self.msa					:= if(take_old,l.msa				,recleaned_address.msa					);
		self.geo_lat			:= if(take_old,l.geo_lat		,recleaned_address.geo_lat			);
		self.geo_long			:= if(take_old,l.geo_long		,recleaned_address.geo_long			);
		self							:= l;                           
		
	end;

	parsedaddress := project(preclean_table, tBreakOutCleanedAddress(left));

	return parsedaddress;
end;