import address,aid;
/*
	This is for datasets that go into POE that don't have AIDs already.  It will append AIDs for them to get ready for ingestion into POE
*/
export Append_AID :=
module

	export fPreProcess(

		dataset(Layouts.Base) pPOE

	) :=
	function
		
		dPrep_for_aid := project(
			 pPOE
			,transform(
				 layouts.temporary.aid_prep
				,
					subject_address1 :=	Address.Addr1FromComponents(
																								 left.subject_address.prim_range	
																								,left.subject_address.predir			
																								,left.subject_address.prim_name	
																								,left.subject_address.addr_suffix
																								,left.subject_address.postdir		
																								,left.subject_address.unit_desig	
																								,left.subject_address.sec_range	
																							); 
					subject_address2 :=	Address.Addr2FromComponents(
																									 left.subject_address.city_name
																									,left.subject_address.st					
																									,left.subject_address.zip			
																							);
					company_address1 :=	Address.Addr1FromComponents(
																								 left.company_address.prim_range	
																								,left.company_address.predir			
																								,left.company_address.prim_name	
																								,left.company_address.addr_suffix
																								,left.company_address.postdir		
																								,left.company_address.unit_desig	
																								,left.company_address.sec_range	
																							); 
					company_address2 :=	Address.Addr2FromComponents(
																									 left.company_address.city_name
																									,left.company_address.st					
																									,left.company_address.zip			
																							);

				
					self.subject_address1 := subject_address1;
					self.subject_address2 := subject_address2;
					self.company_address1 := company_address1;
					self.company_address2 := company_address2;
					self.unique_id				:= counter;
					self									:= left;
			
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

			self.unique_id							:= l.unique_id										;
			self.addr_type							:= cnt										;
			self.address1								:= choose(cnt	,l.subject_address1
																								,l.company_address1	
																	);
			self.address2								:= choose(cnt	,l.subject_address2
																	              ,l.company_address2	
																	);           
			self.rawaid									:= if(cnt = 1, l.subject_rawaid, 0);
																					 
		end;
		
		dAddressPrep	:= normalize(pAddrPrep, 2, tNormalizeAddress(left,counter));

		HasAddress		:= 		trim(dAddressPrep.address1, left,right) != ''
										and trim(dAddressPrep.address2, left,right) != '';
										
		dWith_address			:= dAddressPrep(HasAddress);
		dWithout_address	:= dAddressPrep(not(HasAddress));

		lFlags := AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

		AID.MacAppendFromRaw_2Line(dWith_address, Address1, Address2, rawaid, dwithAID, lFlags);

		// -- match back to dStandardizedFirstPass and append address
		dStandardizeNameInput_dist 	:= distribute(pAddrPrep	,unique_id);
		dAddressStandardized_dist		:= distribute(dwithAID	,unique_id);

		Address.Layout_Clean_Slim fReformatAceCache(AID.Layouts.rACECache	pRow) :=
		transform
			self.zip					:= pRow.zip5				;
			self.city_name		:= pRow.v_city_name	;
			self							:= pRow							;
		end;

		layouts.temporary.aid_prep tGetStandardizedAddress(layouts.temporary.aid_prep l	,dAddressStandardized_dist r) :=
		transform

			aidwork_acecache := row(fReformatAceCache(r.aidwork_acecache));

			self.subject_rawaid							:= if(r.addr_type = 1	,r.AIDWork_RawAID							,l.subject_rawaid							);
			self.subject_aceaid							:= if(r.addr_type = 1	,r.aidwork_acecache.aid				,l.subject_aceaid							);
			self.subject_address						:= if(r.addr_type = 1	,aidwork_acecache							,l.subject_address						);

			self.company_rawaid							:= if(r.addr_type = 2	,r.AIDWork_RawAID							,l.company_rawaid							);
			self.company_aceaid							:= if(r.addr_type = 2	,r.aidwork_acecache.aid				,l.company_aceaid							);
			self.company_address						:= if(r.addr_type = 2	,aidwork_acecache							,l.company_address						);

			self 														:= l;
		
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
		 dataset(Layouts.Base)	pPOE
		,string									pPersistname = persistnames().AppendAID
	) :=
	function
	  
		dPreprocess					:= fPreProcess			 		(pPOE				);
		dStandardizeAddress	:= fStandardizeAddresses(dPreprocess) 
			: persist(pPersistname);
	                                                                                                                             
		return PROJECT(dStandardizeAddress,TRANSFORM(Layouts.Base,					                                 
			                                         self 						:= LEFT;));
	
	end;
	
	

end;