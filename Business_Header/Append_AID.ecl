import address,aid,tools;
export Append_AID :=
module

	export aid_prep :=
	record
	
		unsigned8		unique_id	;
		string			address1				;
		string			address2				;
		Layout_Business_Header_Base							;
		unsigned8            aceAID                                                                      ;
	
	end;

	export layoutaceaid :=
	record
	
		Layout_Business_Header_Base							;
		unsigned8            aceAID                                                                      ;
	
	end;

	export fPreProcess(
		dataset(Layout_Business_Header_Base) pBase
	) :=
	function
		
		dPrep_for_aid := project(
			 pBase
			,transform(
				 aid_prep
				,
					address1 			:=	tools.AID_Helpers.fRawFixLine1(
										trim(left.prim_range )
						+ ' ' + trim(left.predir     )
						+ ' ' + trim(left.prim_name  )
						+ ' ' + trim(left.addr_suffix)
						+ ' ' + trim(left.postdir    )
						+ ' ' + trim(left.unit_desig )
						+ ' ' + trim(left.sec_range  )
					);

					address2			:=	tools.AID_Helpers.fRawFixLineLast(
																													 trim(left.city )    
																									+ ', ' + trim(left.state ) 	
																									+ ' '  + trim((string5)left.zip  )
																							);
				
					self.address1 			:= address1;
					self.address2 			:= address2;
					self.unique_id			:= left.rcid;
					self.aceaid					:= 0;
					self								:= left;
			
			)
		
		) : global;
		return dPrep_for_aid;
	
	end;
	export fStandardizeAddresses(
	
		dataset(aid_prep) pAddrPrep
	
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
			unsigned1										addr_type			;	// subject or company
			string100 									address1			;
			string50										address2			;
		end;
		
		addresslayout tNormalizeAddress(aid_prep l, unsigned1 cnt) :=
		transform
			self.unique_id							:= l.unique_id;
			self.addr_type							:= cnt				;
			self.address1								:= l.address1	;
			self.address2								:= l.address2	;           
			self.rawaid									:= l.rawaid		;
																					 
		end;
		
		dAddressPrep	:= normalize(pAddrPrep, 1, tNormalizeAddress(left,counter));
		HasAddress		:= 		trim(dAddressPrep.address1, left,right) != ''
										or	trim(dAddressPrep.address2, left,right) != '';
										
		dWith_address			:= dAddressPrep(HasAddress);
		dWithout_address	:= dAddressPrep(not(HasAddress));
		dWith_address_dedup	 := dedup(dWith_address, hash64(address1,address2),hash);	//dedup to lower number of records going into macro
		lFlags := AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
		AID.MacAppendFromRaw_2Line(dWith_address_dedup, Address1, Address2, rawaid, dwithAID, lFlags);
		//join back to dWith_Address to get rid and type back
		dwithAID_full := join(
			 dWith_address
			,dwithAID
			,		left.address1 = right.address1
			and left.address2 = right.address2
			,transform(
				 recordof(dwithAID)
				,self.unique_id := left.unique_id	;
				 self.addr_type	:= left.addr_type	;
				 self						:= right					;
			)
		);
		// -- match back to dStandardizedFirstPass and append address
		dStandardizeNameInput_dist 	:= sort(distribute(pAddrPrep			,unique_id)	,unique_id,local);
		dAddressStandardized_dist		:= sort(distribute(dwithAID_full	,unique_id)	,unique_id,local);
		
		Address.Layout_Clean182_fips fReformatAceCache(AID.Layouts.rACECache	pRow) :=
		transform
			self.fips_state		:= pRow.county[1..2];
			self.fips_county	:= pRow.county[3..]	;
			self.zip					:= pRow.zip5				;
			self							:= pRow							;
		end;

		aid_prep tGetStandardizedAddress(aid_prep l	,dAddressStandardized_dist r) :=
		transform

			aidwork_acecache := row(fReformatAceCache(r.aidwork_acecache));
			
			self.rawaid							:= r.AIDWork_RawAID									;
			self.aceaid							:= r.aidwork_acecache.aid						;
			self.city								:= aidwork_acecache.v_city_name			;
			self.state							:= aidwork_acecache.st							;
			self.zip								:= (unsigned3)aidwork_acecache.zip	;
			self.zip4								:= (unsigned2)aidwork_acecache.zip4	;
			self										:= aidwork_acecache									;
			self 										:= l																;
		
		end;
		
		dAddressAppended	:= denormalize(
																 dStandardizeNameInput_dist
																,dAddressStandardized_dist
																,left.unique_id = right.unique_id
																,tGetStandardizedAddress(left,right)
																,local
															);
	
		return dAddressAppended;
		
	end;
	
	export fAll(
		 dataset(Layout_Business_Header_Base)	pBase
		,string														pPersistname 		= persistnames().AppendAID
	) :=
	function
	  
		dPreprocess					:= fPreProcess			 		(pBase				);
		dStandardizeAddress	:= fStandardizeAddresses(dPreprocess) 
			: persist(pPersistname);
	                                                                                                                             
		return PROJECT(dStandardizeAddress,TRANSFORM(layoutaceaid,					                                 
			                                         self 						:= LEFT;));
	
	end;
	
	
end;
