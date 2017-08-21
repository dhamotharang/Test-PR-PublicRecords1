import address,aid,tools;

export Append_AID :=
module

	export fPreProcess(

		dataset(Layouts.Base) pBase

	) :=
	function
		
		dPrep_for_aid := project(
			 pBase
			,transform(
				 layouts.temporary.aid_prep
				,
					Institutionaddress1 :=	tools.AID_Helpers.fRawFixLine1(left.rawfields.AddressInstitution); 
				  Institutionaddress2 :=	tools.AID_Helpers.fRawFixLineLast(left.FormattedInstitutionAddr.p_city_name + ', ' + left.FormattedInstitutionAddr.st + ' '
																		+left.rawfields.InstitutionZIPCode);
																						
					BranchAddress1 			:=	tools.AID_Helpers.fRawFixLine1(left.rawfields.AddressBranch);
					BranchAddress2			:=	tools.AID_Helpers.fRawFixLineLast(left.FormattedBranchAddr.p_city_name + ', ' + left.FormattedBranchAddr.st + ' '
																		+left.rawfields.BranchZIPCode);    
																								

				
					self.InstitutionAddress1 	:= Institutionaddress1;
					self.InstitutionAddress2	:= Institutionaddress2;
					self.BranchAddress1 			:= BranchAddress1;
					self.BranchAddress2 			:= BranchAddress2;
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

			self.unique_id							:= l.unique_id						;
			self.addr_type							:= cnt										;
			self.address1								:= choose(cnt	,l.InstitutionAddress1
																								,l.BranchAddress1	
																	);
			self.address2								:= choose(cnt	,l.InstitutionAddress2
																	              ,l.BranchAddress2	
																	);           
			self.rawaid									:= if(cnt = 1, l.Institutionaid, l.Branchaid);
																					 
		end;
		
		dAddressPrep	:= normalize(pAddrPrep, 2, tNormalizeAddress(left,counter));

		HasAddress		:= 		trim(dAddressPrep.address1, left,right) != ''
										and	trim(dAddressPrep.address2, left,right) != '';
										
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

		layouts.temporary.aid_prep tGetStandardizedAddress(layouts.temporary.aid_prep l	,dAddressStandardized_dist r) :=
		transform

			aidwork_acecache := row(fReformatAceCache(r.aidwork_acecache));

			self.Institutionaid				:= if(r.addr_type = 1	,r.AIDWork_RawAID							,l.Institutionaid				);
			self.Institutionaceaid				:= if(r.addr_type = 1	,r.aidwork_acecache.aid				,l.Institutionaceaid				);
			self.FormattedInstitutionaddr	:= if(r.addr_type = 1	,aidwork_acecache							,l.FormattedInstitutionaddr);

			self.Branchaid							:= if(r.addr_type = 2	,r.AIDWork_RawAID							,l.Branchaid							);
			self.Branchaceaid							:= if(r.addr_type = 2	,r.aidwork_acecache.aid				,l.Branchaceaid							);
			self.FormattedBranchAddr			:= if(r.addr_type = 2	,aidwork_acecache							,l.FormattedBranchaddr			);

			self 										:= l;
		
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
		 dataset(Layouts.Base)	pBase
		,string														pPersistname 		= persistnames().AppendAID
	) :=
	function
	  
		dPreprocess					:= fPreProcess			 		(pBase				);
		dStandardizeAddress	:= fStandardizeAddresses(dPreprocess) 
			: persist(pPersistname);
	                                                                                                                             
		return PROJECT(dStandardizeAddress,TRANSFORM(Layouts.Base,					                                 
			                                         self 						:= LEFT;));
	 
	end;
	
	

end;