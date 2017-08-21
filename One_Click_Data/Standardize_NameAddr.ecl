import  Address, aid, NID, ut;

// -- add unique id
// -- standardize name
// -- normalize and slim record for address cleaning, keep unique id
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get addresses and dates

export Standardize_NameAddr :=
module
 	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeName(
	
		dataset(Layouts.Base) pStandardizedInput
	
	) :=
	function
	
	 	//Added mname and name_suffix to the layout because Mac_CleanParsedNames generates an error with them	
	  dconcatbasefiles := project(pStandardizedInput,transform(Layouts.Temporary.Layout_NID,self.mname:=' ',self.name_suffix:=' ',self:=LEFT));
		
		NID.Mac_CleanParsedNames(dconcatbasefiles, cleaned_name_output, rawfields.FirstName, mname, rawfields.LastName, name_suffix);
														 
		Layouts.Temporary.AddrCleanPrep tStandardizeName(cleaned_name_output l) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self.clean_name.title	 	     := l.cln_title;
			self.clean_name.fname	       := l.cln_fname;
			self.clean_name.mname	       := l.cln_mname;
			self.clean_name.lname		     := l.cln_lname;
			self.clean_name.name_suffix	 := l.name_suffix;
			self.clean_name.name_score	 := '';
      self.unique_id               := 0;
			self									       := l;
			
		end;
		
		dStandardizedName := project(cleaned_name_output, tStandardizeName(left));
		
		return dStandardizedName;

	end;


	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeAddresses(
	
		dataset(Layouts.Temporary.AddrCleanPrep) pStandardizeNameInput
	
	) :=
	function
	
	  fCleanStreetNames(string inStreet) :=
	  function
			 //////////////////////////////////////////////////////////////////////////////////////
			 // -- Pre-clean addresses
			 // -- Fix the addresses that have no spaces
			 //////////////////////////////////////////////////////////////////////////////////////
			 string preCln_Street1  := REGEXREPLACE('([A-Z]{1,})(DRIVE|AVENUE|STREET)',REGEXREPLACE('POBOX',REGEXREPLACE('NOT COLLECTED|ADDRESS2|ADDRESS1|\\+',inStreet,' '),'PO BOX '),'$1 $2');
			 string preCln_Street2  := REGEXREPLACE('([A-Z]{1,})(\\d{1,})',preCln_Street1,'$1 $2');			//Fix the bad addresses
			 string Out_Street      := IF(StringLib.StringFind(preCln_Street2,' ',1) = 0 AND preCln_Street2 <> '',
																		 IF(REGEXFIND('(\\d{1,})([A-Z]{1,})',preCln_Street2) AND NOT REGEXFIND('(\\d{1,})([ST|ND|RD|TH]\\s)',preCln_Street2),REGEXREPLACE('(\\d{1,})([A-Z]{1,})',preCln_Street2,'$1 $2'),preCln_Street2),preCln_Street2);
			 return ut.CleanSpacesAndUpper(Out_Street); 														 
		end;
		
    Layouts.Temporary.AddrCleanPrep tPrepAddrProcess(Layouts.Temporary.AddrCleanPrep l, unsigned8 cnt) :=
		  transform
			self.unique_id										:= cnt;
			self.prep_home_addr_line1 				:= fCleanStreetNames(l.rawfields.HomeAddress);
			self.prep_home_addr_line_last 		:= if(ut.CleanSpacesAndUpper(l.rawfields.HomeCity) <> '',ut.CleanSpacesAndUpper(l.rawfields.HomeCity) + ', ','') +
			                                     ut.CleanSpacesAndUpper(l.rawfields.HomeState) + ' ' + ut.CleanSpacesAndUpper(l.rawfields.HomeZip);
			self.prep_work_addr_line1 				:= fCleanStreetNames(l.rawfields.WorkAddress);
			self.prep_work_addr_line_last 		:= if(ut.CleanSpacesAndUpper(l.rawfields.WorkCity) <> '',ut.CleanSpacesAndUpper(l.rawfields.WorkCity) + ', ','') +
																			  	 ut.CleanSpacesAndUpper(l.rawfields.WorkState) + ' ' + ut.CleanSpacesAndUpper(l.rawfields.WorkZip);
			self                              := l;
		end;

  	dPrepAddrProcess := project(pStandardizeNameInput, tPrepAddrProcess(left,counter)) : independent;
	

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Second, pass addresses to macro for cleaning
		// -- normalize address out into one file with address1, address2, type, and uniqueid, then pass to macro
		//////////////////////////////////////////////////////////////////////////////////////
		addresslayout :=
		record
			unsigned8										unique_id			;	//to tie back to original record
			unsigned8										rawaid				;
			unsigned1										addr_type			;	// contact or mailing
			string100 									address1			;
			string50										address2			;
		end;
		
		addresslayout tNormalizeAddress(Layouts.Temporary.AddrCleanPrep l, unsigned1 cnt) :=
		transform

			self.unique_id							:= l.unique_id						;
			self.addr_type							:= cnt										;
			self.address1								:= choose(cnt	,l.prep_home_addr_line1
																								,l.prep_work_addr_line1	
																	);
			self.address2								:= choose(cnt	,l.prep_home_addr_line_last
																	              ,l.prep_work_addr_line_last	
																	);           
			self.rawaid									:= 0;
																					 
		end;
		
		dNormAddr	:= normalize(dPrepAddrProcess, 2, tNormalizeAddress(left,counter));

		HasAddress		:= trim(dNormAddr.address2, left,right) != '';
										
		dWith_address			:= dNormAddr(HasAddress);
		//dWithout_address	:= dNormAddr(not(HasAddress));

		lFlags := AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords | AID.Common.eReturnValues.NoNewCacheFiles;

		AID.MacAppendFromRaw_2Line(dWith_address, Address1, Address2, rawaid, dwithAID, lFlags);

		// -- match back to dStandardizedFirstPass and append address
		dStandardizeNameInput_dist 	:= distribute(dPrepAddrProcess     	,unique_id);
		dwithAID_dist	            	:= distribute(dwithAID							,unique_id);

		Address.Layout_Clean182_fips fReformatAceCache(AID.Layouts.rACECache	pRow) :=
		transform
			self.fips_state		:= pRow.county[1..2];
			self.fips_county	:= pRow.county[3..]	;
			self.zip					:= pRow.zip5				;
			self							:= pRow							;
		end;

		Layouts.Temporary.AddrCleanPrep tGetStandardizedAddress(Layouts.Temporary.AddrCleanPrep l	,dwithAID_dist r) :=
		transform

			aidwork_acecache := row(fReformatAceCache(r.aidwork_acecache));

			self.raw_home_aid							:= if(r.addr_type = 1	,r.AIDWork_RawAID				,l.raw_home_aid				);
			self.ace_home_aid							:= if(r.addr_type = 1	,r.aidwork_acecache.aid	,l.ace_home_aid				);
			self.Clean_home_address				:= if(r.addr_type = 1	,aidwork_acecache				,l.Clean_home_address	);
			
			self.raw_work_aid							:= if(r.addr_type = 2	,r.AIDWork_RawAID				,l.raw_work_aid				);
			self.ace_work_aid							:= if(r.addr_type = 2	,r.aidwork_acecache.aid	,l.ace_work_aid				);
			self.Clean_work_address				:= if(r.addr_type = 2	,aidwork_acecache				,l.Clean_work_address	);
			self 													:= l;
		end;
		
		dAddressAppended	:= denormalize(
																 dStandardizeNameInput_dist
																,dwithAID_dist
																,left.unique_id = right.unique_id
																,tGetStandardizedAddress(left,right)
																,local
															);

	  pAddressAppended := project(dAddressAppended,TRANSFORM(Layouts.Base,    self := LEFT));
																							 
		return pAddressAppended;
		
	end;


	export fAll( dataset(Layouts.Base	)	pBaseFile
		          ,string									pversion
		          ,string									pPersistname = persistnames().StandardizeNameAddr
	) :=
	function
		dStandardizeName		:= fStandardizeName		 	(pBaseFile);
		dStandardizeAddress	:= fStandardizeAddresses(dStandardizeName) : persist(pPersistname);
	                                                                                                                             
		return dStandardizeAddress;
	
	end;

end;
