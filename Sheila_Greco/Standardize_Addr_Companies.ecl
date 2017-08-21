import  Address, aid;

//////////////////////////////////////////////////////////////////////////////////////
// -- Apply AID process on the entire base recs for getting fresh address.
//////////////////////////////////////////////////////////////////////////////////////
export Standardize_Addr_Companies(
			
			dataset(Layouts.Base.Companies												) pCompaniesBaseFile
	
	) :=
	function

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	//////////////////////////////////////////////////////////////////////////////////////
	Layouts.Temporary.Companies.StandardizeInput tPreProcess(Layouts.Base.Companies l, unsigned8 cnt) :=
	transform

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Prepare Addresses for Cleaning using macro
		//////////////////////////////////////////////////////////////////////////////////////
			address1 :=	Address.Addr1FromComponents(
																							 stringlib.stringtouppercase(trim(l.rawfields.Address1)		)
																							,stringlib.stringtouppercase(trim(l.rawfields.Address2)		)
																							,''
																							,''
																							,''
																							,''
																							,''
																						 );
			address2 :=	Address.Addr2FromComponents(
																							stringlib.stringtouppercase(l.rawfields.City  	)	
																						 ,stringlib.stringtouppercase(l.rawfields.State	)	
																						 ,trim(l.rawfields.Zip,left,right)[1..5]
																						 );
			
															
		//////////////////////////////////////////////////////////////////////////////////////
		// -- Map Fields
		//////////////////////////////////////////////////////////////////////////////////////					
		SELF.address1 									:= address1;
		SELF.address2 									:= address2;
		SELF.unique_id									:= cnt;
		SELF														:= l; 
	end;
	
	
	dPreAddrRec := project(pCompaniesBaseFile, tPreProcess(left, counter));


	//////////////////////////////////////////////////////////////////////////////////////
	//
	// -- Standardizes addresses
	//////////////////////////////////////////////////////////////////////////////////////

	HasAddress	:=	trim(dPreAddrRec.address1, left,right) != ''
							and trim(dPreAddrRec.address2, left,right) != '';
									
	dWith_address			:= dPreAddrRec(HasAddress);
	dWithout_address	:= dPreAddrRec(not(HasAddress));

	unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

	AID.MacAppendFromRaw_2Line(dWith_address, Address1, Address2, Raw_AID, dwithAID, lFlags);
	
	dBase := project(
		dwithAID
		,transform(
			layouts.base.companies
			,
			self.ace_aid										:= left.aidwork_acecache.aid					;
			self.raw_aid										:= left.aidwork_rawaid								;
			self.clean_address.fips_state 	:= left.aidwork_acecache.county[1..2]	;
			self.clean_address.fips_county	:= left.aidwork_acecache.county[3..]	;
			self.clean_address.zip					:= left.aidwork_acecache.zip5					;
			self.clean_address							:= left.aidwork_acecache							;
			self														:= left																;
		)
	)
	+ project(dWithout_address,transform(Layouts.Base.Companies, self := left));

	return dBase;
end;