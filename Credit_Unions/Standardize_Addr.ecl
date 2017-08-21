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

		SELF.unique_id			:= cnt;
		SELF								:= l; 
	end;
	
	
	dPreAddrRec := project(pBaseFile, tPreProcess(left, counter));


	//////////////////////////////////////////////////////////////////////////////////////
	// -- Second, pass addresses to macro for cleaning
	// -- normalize address out into one file with address1, address2, type, and uniqueid, then pass to macro
	//////////////////////////////////////////////////////////////////////////////////////
	addresslayout :=
	record
		unsigned8										unique_id			;	//to tie back to original record
		unsigned8										rawaid				;
		unsigned4										addr_type	;	// contact or mailing
		string100 									Prep_Addr_Line1			;
		string50										Prep_Addr_Line_Last	;
	end;
	
	addresslayout tNormalizeAddress(Layouts.Temporary.StandardizeInput l, unsigned4 cnt) :=
	transform

		self.unique_id							:= l.unique_id						;
		self.addr_type							:= cnt										;
		self.Prep_Addr_Line1				:= l.Prep_Addr_Line1			;
		self.Prep_Addr_Line_Last		:= l.Prep_Addr_Line_Last	;
		self.rawaid									:= 0											;
																				 
	end;
	
	dAddressPrep	:= normalize(dPreAddrRec, 1, tNormalizeAddress(left,counter));

	HasAddress		:= 		trim(dAddressPrep.Prep_Addr_Line1, left,right) != ''
									and trim(dAddressPrep.Prep_Addr_Line_Last, left,right) != '';
									
	dWith_address			:= dAddressPrep(HasAddress);
	dWithout_address	:= dAddressPrep(not(HasAddress));

	lFlags := AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

	AID.MacAppendFromRaw_2Line(dWith_address, Prep_Addr_Line1, Prep_Addr_Line_Last, rawaid, dwithAID, lFlags);

	// -- match back to dStandardizedFirstPass and append address
	dStandardizeInput_dist		 	:= distribute(dPreAddrRec	,unique_id);
	dAddressStandardized_dist		:= distribute(dwithAID		,unique_id);

	Address.Layout_Clean182_fips fReformatAceCache(AID.Layouts.rACECache	pRow) :=
	transform
		self.fips_state		:= pRow.county[1..2];
		self.fips_county	:= pRow.county[3..]	;
		self.zip					:= pRow.zip5				;
		self							:= pRow							;
	end;

	Layouts.Temporary.StandardizeInput tGetStandardizedAddress(Layouts.Temporary.StandardizeInput l	,dAddressStandardized_dist r) :=
	transform

		aidwork_acecache 		:= row(fReformatAceCache(r.aidwork_acecache));

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
															,local
														);

	dCleanAddr := project(dAddressAppended, transform(Layouts.Base, self := left));
	return dCleanAddr;
end;