import  Address, aid, NID, ut;


export Standardize_NameAddr :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeName(dataset(Layouts.base) pPreProcessInput) :=
	function

		//*** Cleaning persion names using the new NID name cleaner.
		NID.Mac_CleanFullNames(pPreProcessInput, cleaned_name_output, Exec_Full_Name);
		
		cleaned_name_PreProcessInput := cleaned_name_output;

		Layouts.base tStandardizeName(cleaned_name_PreProcessInput l) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self.title		         	:= l.cln_title;
			self.fname	            := l.cln_fname;
			self.mname	            := l.cln_mname;
			self.lname		         	:= l.cln_lname;
			self.name_suffix	      := l.name_suffix;
			self.name_score	        := '';

			self										:= l;
			
		end;
		
		dStandardizedName := project(cleaned_name_PreProcessInput, tStandardizeName(left));
		
		return dStandardizedName;

	end;
	

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	// -- Apply AID process on the entire base recs for getting fresh address.
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeAddresses(dataset(Layouts.Base) pStandardizeNameInput) :=
	function
	
		HasAddress	:= trim(pStandardizeNameInput.prep_addr_line_last, left,right) != '';
										
		dWith_address			:= pStandardizeNameInput(HasAddress);
		dWithout_address	:= pStandardizeNameInput(not(HasAddress));

		unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

		AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_line_last, Raw_AID, dwithAID, lFlags);
		
		dBase := project(
			dwithAID
			,transform(
				Layouts.base,
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
				self.zip						:= left.aidwork_acecache.zip5					;
				self.zip4						:= left.aidwork_acecache.zip4					;
				self.cart						:= left.aidwork_acecache.cart					;
				self.cr_sort_sz			:= left.aidwork_acecache.cr_sort_sz		;
				self.lot						:= left.aidwork_acecache.lot					;
				self.lot_order			:= left.aidwork_acecache.lot_order		;
				self.dbpc						:= left.aidwork_acecache.dbpc					;
				self.chk_digit			:= left.aidwork_acecache.chk_digit		;
				self.rec_type				:= left.aidwork_acecache.rec_type			;
				self.fips_state 		:= left.aidwork_acecache.county[1..2]	;
				self.fips_county		:= left.aidwork_acecache.county[3..]	;
				self.geo_lat				:= left.aidwork_acecache.geo_lat			;
				self.geo_long				:= left.aidwork_acecache.geo_long			;
				self.msa						:= left.aidwork_acecache.msa					;
				self.geo_blk				:= left.aidwork_acecache.geo_blk			;
				self.geo_match			:= left.aidwork_acecache.geo_match		;
				self.err_stat				:= left.aidwork_acecache.err_stat			;
        self.sic_code				:= if(ut.fn_SIC_functions.fn_validate_SicCode(left.sic_code) = 1,ut.CleanSpacesAndUpper(left.sic_code),''); 
				self								:= left																;
			)
		)
		+ project(dWithout_address,transform(Layouts.base, self := left));

		return dBase;
		
	end;
	

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fAll
	//////////////////////////////////////////////////////////////////////////////////////
	export fAll( dataset(Layouts.Base						) pBaseFile
							,string														pversion
							,string														pPersistname = persistnames().StandardizeNameAddr
	) :=
	function
	
		dStandardizeName	:= fStandardizeName			(pBaseFile				);
				
		dStandardizeAddr	:= fStandardizeAddresses(dStandardizeName			) : persist(pPersistname);
		
		return dStandardizeAddr;
	
	end;

end;