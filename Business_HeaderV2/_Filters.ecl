import header, phonesplus, irs_Dummy, doxie, business_header;
export _Filters :=
module

	export Input :=
	module
	
		export Business_headers(dataset(Layouts.Base.Source_Business_header) 		pInput) := 
		function
		
			STRING name_chars := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';

			boolean lStandardFilter 	:= 		pInput.company_name 									= ''	//Discard records with blank company names
											or	StringLib.StringFilter(pInput.company_name, name_chars) = ''	//company name must be alphanumeric
											;
			boolean lAdditionalFilter	:=	 (pInput.source in ['AW'] and pInput.vendor_id[1..2] in ['OR']) //Discard Oregon Watercraft records
											or  (		pInput.bdid	>= irs_dummy.bdid_cutoff
												)
			; 		

			boolean lFullFilter 		:= not(lStandardFilter or lAdditionalFilter);	//negate it
			///////////////////////////////////////////////////////////////////
			// -- Bug 25304 -- blank this phone
			// -- Bug 24219 -- Remove this phone
			///////////////////////////////////////////////////////////////////
			Layouts.Base.Source_Business_header tblankoutphone(Layouts.Base.Source_Business_header l) :=
			transform
				
				filterbug25304 :=			l.phone					= 2127938763
													and l.company_name	= 'CITIGROUP'
												;
				
				filterbug24219 :=		l.company_name	= 'WASTE MANAGEMENT' 
												and l.prim_range		= '6521' 
												and l.prim_name 		= 'VANDERBILT'
												and l.zip 					= 77005
												;
				
				self.prim_range 	:= if(filterbug24219,'1001'				,l.prim_range 		);
				self.prim_name		:= if(filterbug24219,'FANNIN'			,l.prim_name			);
				self.addr_suffix	:= if(filterbug24219,'ST'					,l.addr_suffix		);
				self.unit_desig		:= if(filterbug24219,'STE'				,l.unit_desig			);
				self.sec_range		:= if(filterbug24219,'4000'				,l.sec_range			);
				self.city					:= if(filterbug24219,'HOUSTON'		,l.city						);
				self.state				:= if(filterbug24219,'TX'					,l.state					);
				self.zip					:= if(filterbug24219, 77002				,l.zip						);
				self.zip4					:= if(filterbug24219, 6711				,l.zip4						);
				self.county				:= if(filterbug24219,'201'				,l.county					);
				self.msa					:= if(filterbug24219,'3360'				,l.msa						);
				self.geo_lat			:= if(filterbug24219,'29.756396'	,l.geo_lat				);
				self.geo_long			:= if(filterbug24219,'-095.364044',l.geo_long				);
				self.phone				:= map(	 filterbug24219 => 7135126200
																	,filterbug25304 => 0					
																	,l.phone				
																);
				self							:= l																							;                              
			end;
			
			return project(pInput(lFullFilter), tblankoutphone(left));
			
		end;
	
		export Business_contacts(dataset(Layouts.Base.Business_Contacts_Full) 	pInput) := 
		function 
			
			boolean lStandardFilter 	:=		
													pInput.company_name																= ''	// Discard Blank Company names
											or	pInput.lname																			= ''	// Discard Contacts with no last name
											or	regexfind('REGISTERED AGENT', pInput.company_title, nocase) // Discard Registered Agents
											;
											
			boolean lAdditionalFilter	:= (pInput.source in ['AW'] and pInput.vendor_id[1..2] in ['OR']) //Discard Oregon Watercraft records
											or	(
														pInput.did	>= irs_dummy.did_cutoff and 
														pInput.bdid	>= irs_dummy.bdid_cutoff
												)
			;

			boolean lFullFilter 		:= not(lStandardFilter or lAdditionalFilter);	//negate it 

			///////////////////////////////////////////////////////////////////
			// -- Bug 25304 -- blank this phone
			///////////////////////////////////////////////////////////////////
			Layouts.Base.Business_Contacts_Full tblankoutphone(Layouts.Base.Business_Contacts_Full l) :=
			transform
				
				filterbug25304 :=		l.company_name	= 'CITIGROUP'
												;
				
				self.phone					:= map(	 filterbug25304 and l.phone = 2127938763 => 0					
																	,l.phone				
																);
				self.company_phone	:= map(	 filterbug25304 and l.company_phone = 2127938763 => 0					
																	,l.company_phone				
																);
				self							:= l																							;                              
			end;
			
			return project(pInput(lFullFilter), tblankoutphone(left));
		
		end;

	end;
	
	
	export Bases :=
	module
		
		export Business_Headers(dataset(Layouts.Base.Business_headers) pInput) :=
		function
			
			boolean lStandardFilter 	:=	
				///////////////////////////////////////////////////////////////////
				// -- Corporations with Blank addresses
				///////////////////////////////////////////////////////////////////
				(		pInput.source			= 	'C'
				 and	trim(pInput.prim_name)	= 	''
				 and	pInput.zip				= 	0
				)

				///////////////////////////////////////////////////////////////////
				// -- Corporations records with certain bad names
				///////////////////////////////////////////////////////////////////
			or	(		pInput.company_name		in [ 'X'
													,'SAME'
													,'NATIONAL REGISTERED AGENTS, INC.'
													,'NATIONAL REGISTERED AGENTS'
												   ]
				)
				///////////////////////////////////////////////////////////////////
				// -- IRS Dummy records
				///////////////////////////////////////////////////////////////////
			or  (		pInput.bdid	>= irs_dummy.bdid_cutoff
				)
				; 
			
			boolean lAdditionalFilter	:= 
				///////////////////////////////////////////////////////////////////
				// -- Oregon Watercraft records
				///////////////////////////////////////////////////////////////////
				(			pInput.source						= 'AW'
				 and	pInput.vendor_id[1..2]	=	'OR'
				)

				;

			boolean lFullFilter 	:= not(lStandardFilter or lAdditionalFilter);	//negate it 
			
			///////////////////////////////////////////////////////////////////
			// -- Bug 24219 -- Remove this phone
			// -- bUG 25304 -- blank this phone
			///////////////////////////////////////////////////////////////////
			Layouts.Base.Business_headers tblankoutphone(Layouts.Base.Business_headers l) :=
			transform
				
				filterbug24219 :=		(l.bdid				= 942461905
												or	l.company_name	= 'WASTE MANAGEMENT') 
												and l.prim_range	= '6521' 
												and l.prim_name 	= 'VANDERBILT'
												and l.zip 				= 77005
												;
				
				filterbug25304 :=		l.bdid				= 278065382 
												and l.phone				= 2127938763
												;
				
				self.prim_range 	:= if(filterbug24219,'1001'				,l.prim_range 		);
				self.prim_name		:= if(filterbug24219,'FANNIN'			,l.prim_name			);
				self.addr_suffix	:= if(filterbug24219,'ST'					,l.addr_suffix		);
				self.unit_desig		:= if(filterbug24219,'STE'				,l.unit_desig			);
				self.sec_range		:= if(filterbug24219,'4000'				,l.sec_range			);
				self.city					:= if(filterbug24219,'HOUSTON'		,l.city						);
				self.state				:= if(filterbug24219,'TX'					,l.state					);
				self.zip					:= if(filterbug24219, 77002				,l.zip						);
				self.zip4					:= if(filterbug24219, 6711				,l.zip4						);
				self.county				:= if(filterbug24219,'201'				,l.county					);
				self.msa					:= if(filterbug24219,'3360'				,l.msa						);
				self.geo_lat			:= if(filterbug24219,'29.756396'	,l.geo_lat				);
				self.geo_long			:= if(filterbug24219,'-095.364044',l.geo_long				);
				self.phone				:= map(	 filterbug24219 => 7135126200
																	,filterbug25304 => 0					
																	,l.phone				
																);
				self							:= l																							;                              
			end;
			
			return project(pInput(lFullFilter), tblankoutphone(left));

		end;
		
		export Business_Contacts(dataset(Layouts.Base.Business_Contacts_Full) pInput) :=
		function

			boolean lStandardFilter 	:=
				pInput.from_hdr <> 'N'
				///////////////////////////////////////////////////////////////////
				// -- Corporations with Blank addresses
				///////////////////////////////////////////////////////////////////
			or (		pInput.source					= 	'C'
				 and	trim(pInput.company_prim_name)	= 	''
				 and	pInput.company_zip				= 	0
				)

				///////////////////////////////////////////////////////////////////
				// -- Corporations records with certain bad names
				///////////////////////////////////////////////////////////////////
			or	(		pInput.company_name				in [ 'X'
															,'SAME'
															,'NATIONAL REGISTERED AGENTS, INC.'
															,'NATIONAL REGISTERED AGENTS'
															]
				)
			or	(
						pInput.did	>= irs_dummy.did_cutoff and 
						pInput.bdid	>= irs_dummy.bdid_cutoff
				)
			or	regexfind('REGISTERED AGENT', pInput.company_title, nocase) // Discard Registered Agents
				
				;

			boolean lAdditionalFilter	:= 
				///////////////////////////////////////////////////////////////////
				// -- Bug 23466
				///////////////////////////////////////////////////////////////////
				(		pInput.source			=	  'AW'
				or	pInput.source			=		'AE'
				or	pInput.source			=		'MV'
				)
			or	//Filter this guy for bug #20377
				(			pInput.bdid 					= 60667000
				 and	pInput.did						= 1830088723
				 and	pInput.ssn						= 379607091
				)
				//filter this senator
			or
				(			pInput.did						= 1363114130
				 and	pInput.bdid						= 14733991
				)

				;

			boolean lFullFilter 	:= not(lStandardFilter or lAdditionalFilter);	//negate it 

			///////////////////////////////////////////////////////////////////
			// -- Bug 25304 -- blank this phone
			///////////////////////////////////////////////////////////////////
			Layouts.Base.Business_Contacts_Full tblankoutphone(Layouts.Base.Business_Contacts_Full l) :=
			transform
				
				filterbug25304 :=		l.bdid					= 278065382
												and	l.did						= 113639240254
												;
				
				self.phone					:= map(	 filterbug25304 and l.phone = 2127938763 => 0					
																	,l.phone				
																);
				self.company_phone	:= map(	 filterbug25304 and l.company_phone = 2127938763 => 0					
																	,l.company_phone				
																);
				self							:= l																							;                              
			end;
			
			return project(pInput(lFullFilter), tblankoutphone(left));

		end;

		export Business_Header_Best(dataset(Layouts.Base.Business_headers) pInput) :=
		function

			lfilter		:= 		pInput.source = 'EB'
									or 	pInput.source = 'AE';	//set to false for no filter
			
			lfullfilter := not(lfilter);
			
			return pInput(lfullfilter);
		
		end;
		

	end;
	
	export Outs :=
	module
	
		export Business_Headers(dataset(Layouts.Base.Business_headers) pInput) :=
		function

			lfilter		:= pInput.source = 'EB';	//set to false for no filter
			
			lfullfilter := not(lfilter);
			
			return pInput(lfullfilter);
		end;
		
		export Business_Contacts(dataset(Layouts.Base.Business_Contacts_Full) pInput) :=
		function

			boolean lAdditionalFilter	:= 
						pInput.source					=	'EB'
			or			pInput.source					=	'ZM'
			or
			(			pInput.source 					=	'D'	 // filter out DNB records
				and		pInput.company_fein				=	0
			)

			or			pInput.from_hdr					<>	'N'	// filters out all header records(because it is negated below)
			or			Business_Header.CheckUCC(pInput.source, pInput.company_name, pInput.fname, pInput.mname, pInput.lname, pInput.name_suffix)
			or
				(		pInput.did						= 1363114130
				 and	pInput.bdid						= 14733991
				)
			;

			boolean lFullFilter 	:= not(lAdditionalFilter);	//negate it 
			///////////////////////////////////////////////////////////////////
			// -- Bug 25257 -- left only lookup join on pull ssn on ssn and did
			///////////////////////////////////////////////////////////////////

			pullids := doxie.File_pullSSN;
			
			Layouts.Base.Business_Contacts_Full tremoverecords(Layouts.Base.Business_Contacts_Full l, pullids r) :=
			transform
				self := l;
			end;
			
			pulldids := join(pInput(lFullFilter)
											,pullids
											,left.did != 0 and left.did = (unsigned6)right.ssn
											,tremoverecords(left,right)
											,lookup
											,left only
											);
			
			pullssns := join(pulldids
											,pullids
											,left.ssn != 0 and left.ssn = (unsigned4)right.ssn
											,tremoverecords(left,right)
											,lookup
											,left only
											);
			
			return pullssns;

		end;

		export PeopleAtWork(dataset(layouts.base.Business_Contacts_Keybuild) pInput) := 
		function
			boolean lAdditionalFilter	:= 
				(		pInput.source					=	'EB') 
			or
				(		pInput.did						= 1363114130
				 and	pInput.bdid						= 14733991
				)
				;

			boolean lFullFilter 	:= not(lAdditionalFilter);	//negate it 
			
			layouts.base.Business_Contacts_Keybuild  filterDNBAddressPhone(layouts.base.Business_Contacts_Keybuild l) := 
			transform
				self.prim_range						:= if(l.source = 'D'	,''	,l.prim_range						);
				self.predir								:= if(l.source = 'D'	,''	,l.predir								);
				self.prim_name						:= if(l.source = 'D'	,''	,l.prim_name						);
				self.addr_suffix					:= if(l.source = 'D'	,''	,l.addr_suffix					);
				self.postdir							:= if(l.source = 'D'	,''	,l.postdir							);
				self.unit_desig						:= if(l.source = 'D'	,''	,l.unit_desig						);
				self.sec_range						:= if(l.source = 'D'	,''	,l.sec_range						);
				self.zip									:= if(l.source = 'D'	,0	,l.zip									);
				self.zip4									:= if(l.source = 'D'	,0	,l.zip4									);
				self.county								:= if(l.source = 'D'	,''	,l.county								);
				self.msa									:= if(l.source = 'D'	,''	,l.msa									);
				self.geo_lat							:= if(l.source = 'D'	,''	,l.geo_lat							);
				self.geo_long							:= if(l.source = 'D'	,''	,l.geo_long							);
				self.company_prim_range		:= if(l.source = 'D'	,''	,l.company_prim_range		);
				self.company_predir				:= if(l.source = 'D'	,''	,l.company_predir				);
				self.company_prim_name		:= if(l.source = 'D'	,''	,l.company_prim_name		);
				self.company_addr_suffix	:= if(l.source = 'D'	,''	,l.company_addr_suffix	);
				self.company_postdir			:= if(l.source = 'D'	,''	,l.company_postdir			);
				self.company_unit_desig		:= if(l.source = 'D'	,''	,l.company_unit_desig		);
				self.company_sec_range		:= if(l.source = 'D'	,''	,l.company_sec_range		);
				self.company_zip					:= if(l.source = 'D'	,0	,l.company_zip					);
				self.company_zip4					:= if(l.source = 'D'	,0	,l.company_zip4					);
				self.phone								:= if(l.source = 'D'	,0	,l.phone								);
				self.company_phone				:= if(l.source = 'D'	,0	,l.company_phone				);
				self 											:= l;                     
			end;
			
			filterdnb :=  project(pInput(lFullFilter), filterDNBAddressPhone(left));
			
			///////////////////////////////////////////////////////////////////
			// -- Bug 25257 -- left only lookup join on pullssn on ssn and did
			///////////////////////////////////////////////////////////////////

			pullids := doxie.File_pullSSN;
			
			layouts.base.Business_Contacts_Keybuild tremoverecords(layouts.base.Business_Contacts_Keybuild l, pullids r) :=
			transform
				self := l;
			end;
			
			pulldids := join(filterdnb
											,pullids
											,left.did != 0 and left.did = (unsigned6)right.ssn
											,tremoverecords(left,right)
											,lookup
											,left only
											);
			
			pullssns := join(pulldids
											,pullids
											,left.ssn != 0 and left.ssn = (unsigned4)right.ssn
											,tremoverecords(left,right)
											,lookup
											,left only
											);
			
			return pullssns;
			
		end;

		export Business_Relatives(dataset(layouts.base.Business_Relative) pInput) :=
		function

			//filter out EBR only bdids from relatives file
			Utilities.macFilterPassedBdids(pInput,					bdid1, QueryGetEBROnlyBdids, br_EBR_Filtered_1st_Pass);
			Utilities.macFilterPassedBdids(br_EBR_Filtered_1st_Pass,	bdid2, QueryGetEBROnlyBdids, br_EBR_Filtered_2nd_Pass);

			return br_EBR_Filtered_2nd_Pass;
		
		end;
		
		export Business_Relatives_Group(dataset(layouts.base.Business_Relative_group) pInput) :=
		function
			
			Utilities.macFilterPassedBdids(pInput, bdid, QueryGetEBROnlyBdids, brg_Filtered);
			
			return brg_Filtered;

		end;
		
		export Business_Header_Best(dataset(Layouts.Base.Business_headers) pInput) :=
		function

			lfilter		:= 		pInput.source = 'EB'
							or 	pInput.source = 'AE'	//set to false for no filter
							;
			lfullfilter := not(lfilter);
			
			Layouts.Base.Business_headers  filterDNBAddressPhone(Layouts.Base.Business_headers l) := 
			transform
				self.prim_range		:= if(l.source = 'D'	,''	,l.prim_range		);
				self.predir				:= if(l.source = 'D'	,''	,l.predir				);
				self.prim_name		:= if(l.source = 'D'	,''	,l.prim_name		);
				self.addr_suffix	:= if(l.source = 'D'	,''	,l.addr_suffix	);
				self.postdir			:= if(l.source = 'D'	,''	,l.postdir			);
				self.unit_desig		:= if(l.source = 'D'	,''	,l.unit_desig		);
				self.sec_range		:= if(l.source = 'D'	,''	,l.sec_range		);
				self.zip					:= if(l.source = 'D'	,0	,l.zip					);
				self.zip4					:= if(l.source = 'D'	,0	,l.zip4					);
				self.county				:= if(l.source = 'D'	,''	,l.county				);
				self.msa					:= if(l.source = 'D'	,''	,l.msa					);
				self.geo_lat			:= if(l.source = 'D'	,''	,l.geo_lat			);
				self.geo_long			:= if(l.source = 'D'	,''	,l.geo_long			);
				self.phone				:= if(l.source = 'D'	,0	,l.phone				);
				self.phone_score	:= if(l.source = 'D'	,0	,l.phone_score	);
				self 							:= l;                     
			end;

			return project(pInput(lfullfilter), filterDNBAddressPhone(left));
			
		end;
		
		export Business_Header_Stat(dataset(Layout_Business_Header_Stat) pInput) :=
		function
			
			macFilterPassedBdids(pInput, bdid, QueryGetEBROnlyBdids, bhs_Filtered);
			
			return bhs_Filtered;

		end;
		
	end;
	
	export MaxRcid(dataset(Layouts.Base.Business_headers) pInput) :=
	function

			lfilterout		:= 	pInput.bdid	>= irs_dummy.bdid_cutoff;
			
			lfullfilter := not(lfilterout);
			
			return pInput(lfullfilter);
	
	end;

	export HeaderContacts(dataset(header.Layout_Header) pInput) :=
	function

			lfilterout		:= 	pInput.jflag2 = 'A' or pInput.did	>= irs_dummy.did_cutoff;
			
			lfullfilter := not(lfilterout);
			
			return pInput(lfullfilter);
	
	end;

	export EqContacts(dataset(header.Layout_Eq_DID) pInput) :=
	function

			lfilterout		:= 		pInput.did	>= irs_dummy.did_cutoff
								;
								
			lfullfilter := not(lfilterout);
			// blank out senator's former employer because it is not correct
			header.Layout_Eq_DID  filterSenator(header.Layout_Eq_DID l) := 
			transform
				boolean shouldblankrec := 		l.ssn  							=  '158521050' 
											and l.former_occupation_employer	= ',SOUTH OAK HOSPITAL';
											
				self.former_occupation_employer	:= if(shouldblankrec	,''	,l.former_occupation_employer);
				self 							:= l;                     
			end;
			
			return project(pInput(lFullFilter), filterSenator(left));
	
	end;

	export PhonesPlusContacts(dataset(Phonesplus.layoutCommonOut) pInput) :=
	function

			lfilterout		:= 	pInput.did	>= irs_dummy.did_cutoff;
			
			lfullfilter := not(lfilterout);
			
			return pInput(lfullfilter);
	
	end;
	
	export Keys :=
	module

		export Business_Contacts(dataset(layouts.base.Business_Contacts_Keybuild) pInput) :=
		function

			boolean lAdditionalFilter	:=
						pInput.source					=	'ZM' // filter out zoom records
			or			
			(			pInput.source 					=	'D'	 // filter out DNB records
				and		pInput.company_fein				=	0
			)
			or
				(		(unsigned8)pInput.did			= 1363114130
				 and	(unsigned8)pInput.bdid			= 14733991
				)
			;

			boolean lFullFilter 	:= not(lAdditionalFilter);	//negate it 

			return pInput(lFullFilter);

		end;
		
		export PeopleAtWork(dataset(layouts.out.PeopleAtWork_Keybuild) pInput) := 
		function
			boolean lAdditionalFilter	:= 
				(		pInput.source					=	'EB') 
			or
				(		(unsigned8)pInput.did			= 1363114130
				 and	(unsigned8)pInput.bdid			= 14733991
				)
				;

			boolean lFullFilter 	:= not(lAdditionalFilter);	//negate it 
			
			layouts.out.PeopleAtWork_Keybuild  filterDNBAddressPhone(layouts.out.PeopleAtWork_Keybuild l) := 
			transform
				self.prim_range						:= if(l.source = 'D'	,''	,l.prim_range						);
				self.predir								:= if(l.source = 'D'	,''	,l.predir								);
				self.prim_name						:= if(l.source = 'D'	,''	,l.prim_name						);
				self.addr_suffix					:= if(l.source = 'D'	,''	,l.addr_suffix					);
				self.postdir							:= if(l.source = 'D'	,''	,l.postdir							);
				self.unit_desig						:= if(l.source = 'D'	,''	,l.unit_desig						);
				self.sec_range						:= if(l.source = 'D'	,''	,l.sec_range						);
				self.zip									:= if(l.source = 'D'	,''	,l.zip									);
				self.zip4									:= if(l.source = 'D'	,''	,l.zip4									);
				self.county								:= if(l.source = 'D'	,''	,l.county								);
				self.msa									:= if(l.source = 'D'	,''	,l.msa									);
				self.geo_lat							:= if(l.source = 'D'	,''	,l.geo_lat							);
				self.geo_long							:= if(l.source = 'D'	,''	,l.geo_long							);
				self.company_prim_range		:= if(l.source = 'D'	,''	,l.company_prim_range		);
				self.company_predir				:= if(l.source = 'D'	,''	,l.company_predir				);
				self.company_prim_name		:= if(l.source = 'D'	,''	,l.company_prim_name		);
				self.company_addr_suffix	:= if(l.source = 'D'	,''	,l.company_addr_suffix	);
				self.company_postdir			:= if(l.source = 'D'	,''	,l.company_postdir			);
				self.company_unit_desig		:= if(l.source = 'D'	,''	,l.company_unit_desig		);
				self.company_sec_range		:= if(l.source = 'D'	,''	,l.company_sec_range		);
				self.company_zip					:= if(l.source = 'D'	,''	,l.company_zip					);
				self.company_zip4					:= if(l.source = 'D'	,''	,l.company_zip4					);
				self.phone								:= if(l.source = 'D'	,''	,l.phone								);
				self.company_phone				:= if(l.source = 'D'	,''	,l.company_phone				);
				self 											:= l;                     
			end;
			
			return project(pInput(lFullFilter), filterDNBAddressPhone(left));
			
		end;

	end;

	export BHBDIDSIC(dataset(business_header.Layout_SIC_Code) pInput) :=
	function
		
		//first get bdids from business header with the offending address
		bh := files().base.business_headers.built(
			
			//for bug 26195
			(
					prim_name 	= 'EAST WEST'
			and prim_range	= '4400'
			and city				= 'BETHESDA'
			and state				= 'MD'
			)
			
			//for bug 26883
			or
			(
					prim_name 	= '17TH'
			and prim_range	= '1050'
			and postdir			= 'NW'
			and city				= 'WASHINGTON'
			and state				= 'DC'
			)
		);
		
		bh_table	:= table(bh, {bdid}, bdid, few);
		bh_set 		:= set(bh_table, bdid);
		
		//then select those bdids from the sic code input file that are psychiatric hospitals(sic code 8063)
		//and match one of the bdids for that address

		lfilterout		:=	(	 		pInput.sic_code[1..4] = 	'8063'	//psychiatric hospital
												or	pInput.sic_code[1..4] = 	'8051'	//skilled nursing care facility	
											)
											and pInput.bdid in bh_set;
			
		lfullfilter := not(lfilterout);
			
		return pInput(lfullfilter);
	
	end;

end;
