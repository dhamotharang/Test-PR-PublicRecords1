import  Address, aid;

//////////////////////////////////////////////////////////////////////////////////////
// -- Apply AID process on the entire base recs for getting fresh address.
//////////////////////////////////////////////////////////////////////////////////////
export Standardize_Addr(
			
			dataset(Layouts.Base												) pBaseFile
	
	) :=
	function

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	//////////////////////////////////////////////////////////////////////////////////////
	Layouts.Temporary.StandardizeInput tPreProcess(Layouts.Base l, unsigned8 cnt) :=
	transform

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Prepare Addresses for Cleaning using macro
		//////////////////////////////////////////////////////////////////////////////////////
		address1 :=	
					stringlib.stringtouppercase(trim(l.rawfields.Company_Street_Address				))
				;        
		address2 :=	if(trim(l.rawfields.Company_City) <> '',
										stringlib.stringtouppercase(
															trim(l.rawfields.Company_City				)
										+ ', '	+ trim(l.rawfields.Company_State			)
										+ ' '		+ trim(l.rawfields.Company_Postal_Code)[1..5]
										),
										stringlib.stringtouppercase(
															trim(l.rawfields.Company_State			)
										+ ' '		+ trim(l.rawfields.Company_Postal_Code)[1..5]
										)
									);                

																
		//////////////////////////////////////////////////////////////////////////////////////
		// -- Map Fields
		//////////////////////////////////////////////////////////////////////////////////////					
		SELF.address1 									:= address1;
		SELF.address2 									:= address2;
		SELF.unique_id									:= cnt;
		SELF														:= l; 
	end;
	
	
	dPreAddrRec := project(pBaseFile, tPreProcess(left, counter));


	//////////////////////////////////////////////////////////////////////////////////////
	// -- Standardizes addresses using the AID macro
	// 
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
			Layouts.base
			,
			self.ace_aid														:= left.aidwork_acecache.aid					;
			self.raw_aid														:= left.aidwork_rawaid								;
			self.Clean_Company_address.fips_state 	:= left.aidwork_acecache.county[1..2]	;
			self.Clean_Company_address.fips_county	:= left.aidwork_acecache.county[3..]	;
			self.Clean_Company_address.zip					:= left.aidwork_acecache.zip5					;
			self.Clean_Company_address							:= left.aidwork_acecache							;
			self																		:= left																;
		)
	)
	+ project(dWithout_address,transform(Layouts.base, self := left));

	return dBase;
end;