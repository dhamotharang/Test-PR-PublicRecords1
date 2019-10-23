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
	Layouts.Temporary.StandardizeInput tPreProcess(Credit_Unions.Layouts.Base l, unsigned8 cnt) :=
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
		self.Prep_Addr_Line1				:= l.Prep_Addr_Line1;
		self.Prep_Addr_Line_Last		:= l.Prep_Addr_Line_Last;
		self.rawaid									:= 0											;
																				 
	end;
	
	dAddressPrep	:= normalize(dPreAddrRec, 1, tNormalizeAddress(left,counter));

	HasAddress		:=  trim(dAddressPrep.Prep_Addr_Line1, left,right) != ''
									  and trim(dAddressPrep.Prep_Addr_Line_Last, left,right) != ''; 
									
	dWith_address			:= dAddressPrep(HasAddress) : persist('~thor_data400::persist::credit_unions::dWith_address');
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

		aidwork_acecache 	  := row(fReformatAceCache(r.aidwork_acecache));
		
		self.raw_aid				:= if(r.addr_type = 1	,r.AIDWork_RawAID				,l.raw_aid				);
		self.ace_aid				:= if(r.addr_type = 1	,r.aidwork_acecache.aid	,l.ace_aid				);
		self.prim_range			:= if(r.addr_type = 1	,r.aidwork_acecache.prim_range,l.prim_range);
		self.predir					:= if(r.addr_type = 1	,r.aidwork_acecache.predir,l.predir);
		self.prim_name			:= if(r.addr_type = 1	,r.aidwork_acecache.prim_name,l.prim_name);
		self.addr_suffix		:= if(r.addr_type = 1	,r.aidwork_acecache.addr_suffix,l.addr_suffix);
		self.postdir				:= if(r.addr_type = 1	,r.aidwork_acecache.postdir,l.postdir);
		self.unit_desig			:= if(r.addr_type = 1	,r.aidwork_acecache.unit_desig,l.unit_desig);
		self.sec_range			:= if(r.addr_type = 1	,r.aidwork_acecache.sec_range,l.sec_range);
		self.p_city_name		:= if(r.addr_type = 1	,r.aidwork_acecache.p_city_name,l.p_city_name);
		self.v_city_name		:= if(r.addr_type = 1	,r.aidwork_acecache.v_city_name,l.v_city_name);
		self.st							:= if(r.addr_type = 1	,r.aidwork_acecache.st,l.st);
		self.zip						:= if(r.addr_type = 1	,r.aidwork_acecache.zip5,l.zip);
		self.zip4						:= if(r.addr_type = 1	,r.aidwork_acecache.zip4,l.zip4);
		self.cart						:= if(r.addr_type = 1	,r.aidwork_acecache.cart,l.cart);
		self.cr_sort_sz			:= if(r.addr_type = 1	,r.aidwork_acecache.cr_sort_sz,l.cr_sort_sz);
		self.lot						:= if(r.addr_type = 1	,r.aidwork_acecache.lot,l.lot);
		self.lot_order			:= if(r.addr_type = 1	,r.aidwork_acecache.lot_order,l.lot_order);
		self.dbpc						:= if(r.addr_type = 1	,r.aidwork_acecache.dbpc,l.dbpc);
		self.chk_digit			:= if(r.addr_type = 1	,r.aidwork_acecache.chk_digit,l.chk_digit);
		self.rec_type				:= if(r.addr_type = 1	,r.aidwork_acecache.rec_type,l.rec_type);
		self.fips_state 		:= if(r.addr_type = 1	,r.aidwork_acecache.county[1..2],l.fips_state);
		self.fips_county		:= if(r.addr_type = 1	,r.aidwork_acecache.county[3..],l.fips_county);
		self.geo_lat				:= if(r.addr_type = 1	,r.aidwork_acecache.geo_lat,l.geo_lat);
		self.geo_long				:= if(r.addr_type = 1	,r.aidwork_acecache.geo_long,l.geo_long);
		self.msa						:= if(r.addr_type = 1	,r.aidwork_acecache.msa,l.msa);
		self.geo_blk				:= if(r.addr_type = 1	,r.aidwork_acecache.geo_blk,l.geo_blk);
		self.geo_match			:= if(r.addr_type = 1	,r.aidwork_acecache.geo_match,l.geo_match);
		self.err_stat				:= if(r.addr_type = 1	,r.aidwork_acecache.err_stat,l.err_stat);
		self					      := l																;
	
	end;
	
	dAddressAppended	:= denormalize(
															 dStandardizeInput_dist
															,dAddressStandardized_dist
															,left.unique_id = right.unique_id
															,tGetStandardizedAddress(left,right)
															,local
														);
														
	dCleanAddr := project(dAddressAppended ,transform(Credit_Unions.Layouts.Base, self := left));
								
	return dCleanAddr;
end;