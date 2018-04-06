import  Address, aid, ut;
export Standardize_Addr := module

	export fPreProcess(dataset(Layouts_input.cleaned_inspection) pRawFileInput) :=function
	
		Layouts_input.cleaned_inspection tPreProcessIndividuals(Layouts_input.cleaned_inspection l) :=transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Addresses for Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
			addr1 																 :=	ut.CleanSpacesAndUpper(l.Inspected_Site_Street);					       
			addr2 																 :=	ut.CleanSpacesAndUpper(ut.CleanSpacesAndUpper(l.Inspected_Site_City_Name) +
																																			 if (trim(l.Inspected_Site_City_Name,all) <> '',', ','')+ 
																																			 ut.CleanSpacesAndUpper(l.Inspected_Site_State) + ' ' + intformat(l.Inspected_Site_Zip,5,1)
																																			 ); 
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////																																												 
			self.prep_addr_line1										:= addr1;
			self.prep_addr_line_last								:= addr2;
			self																		:= l;
			self																		:= [];
					
		end;
		
		dPreProcess := project(pRawFileInput, tPreProcessIndividuals(left));
	
		return dPreProcess;

	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	// -- Apply AID process on the entire base recs for getting fresh address.
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeAddresses(dataset(Layouts_input.cleaned_inspection) pStandardizeInput) :=function	
	
		HasAddress				:= trim(pStandardizeInput.prep_addr_line_last, left,right) != '';										
		dWith_address			:= pStandardizeInput(HasAddress);
		dWithout_address	:= pStandardizeInput(not(HasAddress));
		unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

		AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_line_last, Raw_AID, dwithAID, lFlags);
		
		dBase := project( dwithAID,transform( Layouts_input.cleaned_inspection,
																					self.ace_aid				:= left.aidwork_acecache.aid					;
																					self.raw_aid				:= left.aidwork_rawaid								;
																					self.prim_range			:= left.aidwork_acecache.prim_range		;
																					self.predir					:= left.aidwork_acecache.predir				;
																					self.prim_name			:= left.aidwork_acecache.prim_name		;
																					self.addr_suffix		:= left.aidwork_acecache.addr_suffix	;
																					self.postdir				:= left.aidwork_acecache.postdir			;
																					self.unit_desig			:= left.aidwork_acecache.unit_desig		;
																					self.sec_range			:= left.aidwork_acecache.sec_range		;
																					self.p_city_name		:= left.aidwork_acecache.p_city_name	;
																					self.v_city_name		:= left.aidwork_acecache.v_city_name	;
																					self.st							:= left.aidwork_acecache.st						;
																					self.zip5						:= left.aidwork_acecache.zip5					;
																					self.zip4						:= left.aidwork_acecache.zip4					;
																					self.cart						:= left.aidwork_acecache.cart					;
																					self.cr_sort_sz			:= left.aidwork_acecache.cr_sort_sz		;
																					self.lot						:= left.aidwork_acecache.lot					;
																					self.lot_order			:= left.aidwork_acecache.lot_order		;
																				  self.dpbc						:= left.aidwork_acecache.dbpc					;
																					self.chk_digit			:= left.aidwork_acecache.chk_digit		;
																					self.addr_rec_type	:= left.aidwork_acecache.rec_type			;
																					self.fips_state 		:= left.aidwork_acecache.county[1..2]	;
																					self.fips_county		:= left.aidwork_acecache.county[3..]	;
																					self.geo_lat				:= left.aidwork_acecache.geo_lat			;
																					self.geo_long				:= left.aidwork_acecache.geo_long			;
																					self.cbsa						:= left.aidwork_acecache.msa					;
																					self.geo_blk				:= left.aidwork_acecache.geo_blk			;
																					self.geo_match			:= left.aidwork_acecache.geo_match		;
																					self.err_stat				:= left.aidwork_acecache.err_stat			;								
																					self								:= left	)
							) + project(dWithout_address,transform(Layouts_input.cleaned_inspection, self := left;self:=[];));

		return dBase;
		
	end;
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fAll
	//////////////////////////////////////////////////////////////////////////////////////
	export fAll(dataset(Layouts_input.cleaned_inspection) pRawFileInput
							,string	pPersistInput = persistnames().StandardizeInput
							,string	pPersistAddr  = persistnames().StandardizeAddr ):= function
							 	
		dPreprocess				:= fPreProcess(pRawFileInput) 				: persist(pPersistInput);							 
		dStandardizeAddr	:= fStandardizeAddresses(dPreprocess) : persist(pPersistAddr);			
		return dStandardizeAddr;
	
	end;

end;