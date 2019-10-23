import address,aid,tools;

export Append_AID :=
module

	export fPreProcess(

		dataset(Layouts.Base_new) pBase

	) :=
	function
		dPrep_for_aid := project(
			 pBase
			,transform(
				 layouts.temporary.aid_prep
				,
					address1 			:=	tools.AID_Helpers.fRawFixLine1(left.rawfields.address + left.rawfields.address1);
					address2			:=	tools.AID_Helpers.fRawFixLineLast(
																													trim(left.rawfields.city)    
																									+ ', ' + left.rawfields.state   	
																									+ ' '  + left.rawfields.zip_code
																							);
					self.address1 			:= address1;
					self.address2 			:= address2;
					self								:= left;
			
			)
		
		);
		return dPrep_for_aid;
	
	end;

	export fStandardizeAddresses(
	
		dataset(layouts.temporary.aid_prep) pAddrPrep
	
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
		
		addresslayout tNormalizeAddress(layouts.temporary.aid_prep l, unsigned1 cnt) :=
		transform

			self.unique_id							:= l.rid			;
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
		dStandardizeNameInput_dist 	:= sort(distribute(pAddrPrep			,rid			)	,rid			,local);
		dAddressStandardized_dist		:= sort(distribute(dwithAID_full	,unique_id)	,unique_id,local);

		Address.Layout_Clean182_fips fReformatAceCache(AID.Layouts.rACECache	pRow) :=
		transform
			self.fips_state		:= pRow.county[1..2];
			self.fips_county	:= pRow.county[3..]	;
			self.zip					:= pRow.zip5				;
			self							:= pRow							;
		end;

		layouts.temporary.aid_prep tGetStandardizedAddress(layouts.temporary.aid_prep l	,dAddressStandardized_dist r) :=
		transform

			aidwork_acecache := row(fReformatAceCache(r.aidwork_acecache));

			self.rawaid							:= r.AIDWork_RawAID							;
			self.aceaid							:= r.aidwork_acecache.aid				;
			self.clean_address			:= aidwork_acecache							;

			self 										:= l;
		
		end;
		
		dAddressAppended	:= denormalize(
																 dStandardizeNameInput_dist
																,dAddressStandardized_dist
																,left.rid = right.unique_id
																,tGetStandardizedAddress(left,right)
																,local
															);

	
		return dAddressAppended;
		
	end;
	
	export fAll(
		 dataset(Layouts.Base_new)	pBase
		,string									pPersistname 		= persistnames().AppendAID
	) :=
	function
	  
		dPreprocess					:= fPreProcess			 		(pBase				);
		dStandardizeAddress	:= fStandardizeAddresses(dPreprocess) 
			: persist(pPersistname);
	                                                                                                                             
	//Populate current_rec based on whether or not record is in the new input file as this is a full replace
	//Unknown = 1 Ancient = 2 Old = 3 Unchanged = 4 Updated = 5 New = 6	
		return PROJECT(dStandardizeAddress,TRANSFORM(Layouts.Base_new,
																							 SELF.current_rec := IF(LEFT.record_type in [2,3],FALSE,TRUE);
			                                         SELF 						:= LEFT;));
	
	end;
	
	

end;