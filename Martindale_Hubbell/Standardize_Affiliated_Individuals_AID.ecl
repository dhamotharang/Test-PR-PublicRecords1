import  Address, aid;

//////////////////////////////////////////////////////////////////////////////////////
// -- Apply AID process on the entire base recs for getting fresh address.
//////////////////////////////////////////////////////////////////////////////////////
export Standardize_Affiliated_Individuals_AID (dataset(Layouts.Base.Affiliated_Individuals) pBaseFile)	:=	function

		Layouts.Temporary.Affiliated_Individuals tPreProcessAffiliated_Individuals(Layouts.Base.Affiliated_Individuals l, unsigned8 cnt) :=	transform
			self.unique_id									:=	cnt;
			self														:=	l;
		end;
		
		dPreProcess := project(pBaseFile, tPreProcessAffiliated_Individuals(left,counter));

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Second, pass addresses to macro for cleaning
		// -- normalize address out into one file with address1, address2, type, and uniqueid, then pass to macro
		//////////////////////////////////////////////////////////////////////////////////////
		addresslayout :=
		record
			unsigned8										unique_id			;	//to tie back to original record
			unsigned8										rawaid				;
			unsigned8										ACEaid				;			
			string100 									address1			;
			string50										address2			;
			unsigned8										addr_type			;	//to tie back to original record
		end;
		
		addresslayout tProjectAddress(Layouts.Temporary.Affiliated_Individuals l,unsigned8 cnt) :=
		transform

			self.unique_id							:= l.unique_id	;
			self.address1								:= choose(cnt	,l.contact_mailing_address1
																								,l.contact_location_address1
																						);
			self.address2								:= choose(cnt	,l.contact_mailing_address2
																								,l.contact_location_address2
																						);
			self.addr_type							:= cnt;
			self.rawaid									:= choose(cnt	,if(l.RawAid_mailing != 0, l.RawAid_mailing, 0)
																								,if(l.RawAid_Location != 0, l.RawAid_Location, 0)
																						);
			self.aceaid									:= choose(cnt	,if(l.AceAID_Mailing != 0, l.AceAID_Mailing, 0)
																								,if(l.AceAID_Location != 0, l.AceAID_Location, 0)
																						);																						
		end;
		
		dAddressPrep	:= normalize(dPreProcess, 2,tProjectAddress(left,counter));

		HasAddress		:= 		trim(dAddressPrep.address1, left,right) != ''
										and trim(dAddressPrep.address2, left,right) != '';
										
		dWith_address			:= dAddressPrep(HasAddress);
		dWithout_address	:= dAddressPrep(not(HasAddress));

		lFlags := AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
		AID.MacAppendFromRaw_2Line(dWith_address, Address1, Address2, rawaid, dwithAID, lFlags);
														
		// -- match back to dStandardizedFirstPass and append address
		dPreProcessInput_dist 			:= distribute(dPreProcess	,unique_id);
		dAddressStandardized_dist		:= distribute(dwithAID		,unique_id);

		Address.Layout_Clean182_fips fReformatAceCache(AID.Layouts.rACECache	pRow) :=
		transform
			self.fips_state		:= pRow.county[1..2];
			self.fips_county	:= pRow.county[3..]	;
			self.zip					:= pRow.zip5				;
			self							:= pRow							;
		end;

		Layouts.Temporary.Affiliated_Individuals tGetStandardizedAddress(Layouts.Temporary.Affiliated_Individuals l	,dAddressStandardized_dist r) :=
		transform

			aidwork_acecache := row(fReformatAceCache(r.aidwork_acecache));

			self.RawAid_mailing									:= if(r.addr_type = 1	,r.AIDWork_RawAID	,l.RawAid_mailing									);
			self.ACEAid_mailing									:= if(r.addr_type = 1	,r.aidwork_acecache.aid	,l.ACEAid_mailing						);			
			self.Clean_contact_mailing_address	:= if(r.addr_type = 1	,aidwork_acecache	,l.Clean_contact_mailing_address	);

			self.RawAid_Location								:= if(r.addr_type = 2	,r.AIDWork_RawAID	,l.RawAid_Location								);
			self.ACEAid_Location								:= if(r.addr_type = 2	,r.aidwork_acecache.aid	,l.ACEAid_Location					);			
			self.Clean_contact_location_address	:= if(r.addr_type = 2	,aidwork_acecache	,l.Clean_contact_location_address	);

			self 																:= l																																			 ;
		
		end;
		
		dCleancontactAddressAppended	:= denormalize(
																 dPreProcessInput_dist
																,dAddressStandardized_dist
																,left.unique_id = right.unique_id
																,tGetStandardizedAddress(left,right)
																,local
															);
															
		dReformattedAddress	:=	PROJECT(dCleancontactAddressAppended,TRANSFORM(Layouts.Base.Affiliated_Individuals,SELF := LEFT;));															

		return dReformattedAddress;
		
	end;